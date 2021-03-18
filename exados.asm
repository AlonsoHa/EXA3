#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
	 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF   
	;configuración del dispositivotodo en OFF y la frecuencia de oscilador
	;es la del "reloj del oscilador interno" (INTOSCCLK)    
	RES_VECT  CODE    0x0000            ; processor reset vector
	    GOTO    START                   ; go to beginning of program
	; TODO ADD INTERRUPTS HERE IF USED
	MAIN_PROG CODE                      ; let linker place main program
	;variables para el contador:
	i equ 0x30
	j equ 0x31
	k equ 0x32
	cont equ 0x36
	x equ 0x33
	y equ 0x34
	z equ 0x35
	a equ 0x36
	c equ 0x37
	d equ 0x38
	 
	START
	    MOVLW 0x07 
	    MOVWF CMCON
	    BCF STATUS, RP1 
	    BSF STATUS, RP0
	    MOVLW b'00000010' 
	    MOVWF TRISB
	    BCF STATUS, RP0 
	    NOP
	inicio:
	    BTFSC PORTB,1
	    GOTO $+6
	    bcf PORTB,0
	    call temp3
	    nop
	    bsf PORTB,0
	    call temp3
	    BTFSS PORTB,1
	    GOTO inicio   
	    bcf PORTB,0  
	    call temp1 
	    call temp2
	    movlw d'3'
	    movwf cont
	    DECFSZ cont,f
	    goto $-1
	    bsf PORTB,0  
	    call temp1 
	    call temp2
	    movlw d'2'
	    movwf cont
	    DECFSZ cont,f
	    goto $-1
	    nop
	    goto inicio  
	 
	temp3:
	movlw d'27' 
	movwf a
	aloop:
	nop
	nop
	nop
	nop
	nop
	movlw d'50' 
	movwf c
	cloop:
	nop 
	movlw d'60' 
	movwf d
	dloop:
	decfsz d,f
	goto dloop
	decfsz c,f
	goto cloop
	decfsz a,f
	goto aloop
	return 
	   
	temp2:
	nop 
	nop
	movlw d'54' 
	movwf x
	xloop:
	nop 
	nop
	nop
	nop
	nop
	movlw d'50' 
	movwf y
	yloop:
	nop 
	movlw d'60' 
	movwf z
	zloop:
	decfsz z,f
	goto zloop
	decfsz y,f
	goto yloop
	decfsz x,f
	goto xloop
	return 
	

	temp1:
	    movlw d'100' 
	    movwf i
	iloop:
	    nop
	    nop
	    nop
	    nop
	    nop
	    movlw d'54'
	    movwf j
	jloop:
	    nop
	    nop
	    nop
	    nop
	    movlw d'59'
	    movwf k
	kloop:   
	    decfsz k,f
	    goto kloop
	    decfsz j,f
	    goto jloop
	    decfsz i,f
	    goto iloop
	    movlw d'30'
	    movwf j
	    decfsz j,f
	    goto $-1
	    return    
	    END