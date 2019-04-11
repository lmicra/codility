; https://app.codility.com/programmers/lessons/1-iterations/binary_gap/
; > nasm -f elf32 binary-gap.s
; > ld -melf_i386 -o binary-gap binary-gap.o
; > ./binary-gap 1041
; > ./binary-gap 32 (not implemented, should return 0)

%define SYS_WRITE 4
%define SYS_EXIT 1
%define MAX_BIT 0x40000000

global	_start

section	.data

	_s1	resb 32

section	.text

_start:
	; check if argc is 2
	mov	eax, [esp] ; argc
	sub	eax, 2
	jz	_argc_ok

	; signal a error and exit
	mov	ebx, 1
	jmp	_exit

_argc_ok:
	; TODO: check if argv[1] string is a number
	mov	esi, [esp+8] ; argv[1]
	call	_atoi

_b1:
	call	_count_largest_zero_bin_sequence

	mov	edi, _s1
	call	_itoa

	mov	ecx, _s1 ; string pointer
	mov	edx, eax ; string length
	mov	ebx, 1 ; fd file descriptor (stdout)
	mov	eax, SYS_WRITE
	int	0x80

	mov	ebx, 0 ; return code (success)
	jmp	_exit

_get_first_bit_position:
	; eax = get_first_bit_position(eax) ; get the first bit from the signed eax integer

	xor	ecx, ecx
_get_first_bit_position_l1:
	inc	ecx
	rol	eax, 1
	jno	_get_first_bit_position_l1
	dec	ecx
	mov	eax, 31
	sub	eax, ecx
	ret

_count_largest_zero_bin_sequence:
	; eax = count_largest_zero_bin_sequence(eax)

	push	eax
	call	_get_first_bit_position
	mov	ecx, eax
	pop 	eax

	xor	ebx, ebx ; store the longest sequence of zeros in ebx

	; TODO: ignore all trailing zeros (!!!)
	; as stated in the problem it wanted gaps no longest zeros sequences 
	; shift right eax until we find a bit-1

	dec	ecx ; optimization: we don't need the last bit (we know it's bit-1)

_count_largest_zero_bin_sequence_l1:
	xor	edx, edx ; count the zero bits in edx
_count_largest_zero_bin_sequence_l2:
	dec	ecx
	shr	eax, 1
	jc	_count_largest_zero_bin_sequence_l3 ; found a bit-1
	inc	edx
	test	ecx, ecx
	jnz	_count_largest_zero_bin_sequence_l2
_count_largest_zero_bin_sequence_l3:
	; compare the found zeros (edx) with the maximum zeros (ebx)
	cmp	ebx, edx
	jge	_count_largest_zero_bin_sequence_l4
	mov	ebx, edx
_count_largest_zero_bin_sequence_l4:
	test	ecx, ecx ; check if we're done
	jnz	_count_largest_zero_bin_sequence_l1
	mov	eax, ebx
	ret

_atoi:
	; eax = atoi(esi)

	; read a char from argv[1]
	; check for end-of-string
	; convert ascii number to number ('0' -> 0)
	; multiply total by 10 and add the number

_atoi_l1:
	xor	eax, eax
	lodsb
	test	al, al
	jz	_atoi_exit
	sub	al, '0'
	mov	ecx, eax
	mov	eax, ebx
	mov	ebx, 10
	mul	ebx
	mov	ebx, eax
	add	ebx, ecx
	jmp	_atoi_l1
_atoi_exit:
	mov	eax, ebx
	ret

_itoa:
	; eax = itoa(eax, edi) ; convert value in eax to ascii string in edi, return number the string length (with \n\0 at end)

	; divide eax by 10
	; push the remainder to stack
	; keep dividing until we reach zero
	; pop each remainder
	; convert number to ascii number (0 -> '0')
	; write char to string buffer
	; add \0 to the end of string (increase the string length by 1, assuming the string was zeroed)
	; print the string

	mov	ebx, 10
	xor	ecx, ecx

_itoa_l1:
	xor	edx, edx
	div	ebx
	push	dx
	inc	cx
	test	eax, eax
	jnz	_itoa_l1

	mov	ebx, ecx
	mov	dl, '0'

_itoa_l2:
	pop	ax

	add	al, dl
	stosb
	loop	_itoa_l2

	mov	al, 10
	stosb

	mov	al, 0
	stosb

	inc	ebx

	mov	eax, ebx
	ret

_exit:
	mov	eax, SYS_EXIT
	int	0x80
