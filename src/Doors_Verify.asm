
; Super Metroid
; All Doors Verification Hack

lorom

!VERSION_MAJOR = 1
!VERSION_MINOR = 1

!ram_FailAddress = $7ED910


; Hijack ship function for final verification
org $A2AA20
    JSL VerifyAllDoors


org $A2F500
print pc, " freespace bank $82 start"
VerifyAllDoors:
{
    ; check if Zebes timebomb set
    LDA $7ED821 : BIT #$0040 : BNE .verify
    JML $91E3F6 ; overwritten code

  .verify
    PHX : PHY

    LDX #$D8B0 : LDY #$0000

  .loop
    LDA $7E0000,X : CMP.w Verified_Doors,Y : BNE .failed
    INY #2
    INX #2 : CPX #$D8C6 : BMI .loop

    ; checks passed, draw "VALID"
    LDA #$2CF5 : STA $7EC6B0
    LDA #$2CE0 : STA $7EC6B2
    LDA #$2CEB : STA $7EC6B4
    LDA #$2CE8 : STA $7EC6B6
    LDA #$2CE3 : STA $7EC6B8

    PLY : PLX
    JML $91E3F6 ; overwritten code

  .failed
    ; failed door check
    TXA : JSR Draw4Hex

    PLY : PLX
    JML $91E3F6 ; overwritten code
}

Verified_Doors:
    db $23, $F0, $09, $FE, $6F, $FF, $FF, $FF, $FF, $FE, $FF, $FF, $01, $00, $00, $00, $7C, $FF, $FF, $FD, $AF, $03

Draw4Hex:
{
    STA !ram_FailAddress : AND #$F000  ; get first digit (X000)
    XBA : LSR #3                       ; move it to last digit (000X) and shift left one
    TAY : LDA.w HexGFXTable,Y          ; load tilemap address with 2x digit as index
    STA $7EC6B0                        ; draw digit to HUD

    LDA !ram_FailAddress : AND #$0F00  ; (0X00)
    XBA : ASL
    TAY : LDA.w HexGFXTable,Y
    STA $7EC6B2

    LDA !ram_FailAddress : AND #$00F0  ; (00X0)
    LSR #3 : TAY : LDA.w HexGFXTable,Y
    STA $7EC6B4

    LDA !ram_FailAddress : AND #$000F  ; (000X)
    ASL : TAY : LDA.w HexGFXTable,Y
    STA $7EC6B6
    RTS
}

HexGFXTable:
    dw #$2C45, #$2C3C, #$2C3D, #$2C3E, #$2C3F, #$2C40, #$2C41, #$2C42, #$2C43, #$2C44
    dw #$2CE0, #$2CE1, #$2CE2, #$2CE3, #$2CE4, #$2CE5
print pc, " freespace bank $82 end"


; Title menu watermark

org $8EDC70
    ;           D      O      O      R  
    dw $000F, $006D, $0078, $0078, $007B

org $8EDCB0
    ;    V      E      R      I      F      Y  
    dw $007F, $006E, $007B, $0072, $006F, $0082

org $8EDCF0
    ;           v                          .                      
    dw $000F, $007F, !VERSION_MAJOR|$60, $0088, !VERSION_MINOR|$60
