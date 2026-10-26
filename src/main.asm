.createfile "../bin/"+OUT_FILE, 0

.word 1
.word main_block_end - main_block
.ascii "2xST"
main_block:
increase_1:
    ; restore op replaced by the hook
    lhu     v1, 0x0(a1)
    
    sll     v1, v1, 1
    sll     v0, v0, 1
    j       INCREASE_HOOK_1 + 8
    nop
increase_2:
    ; restore op replaced by the hook
    sh      v1, 0x0(a3)
    
    sll     a1, a1, 1
    j       INCREASE_HOOK_2 + 8
    nop
main_block_end:

.word 2 ;  Hook Block
.word INCREASE_HOOK_1
.halfword increase_1 - main_block_end
.byte 8
.byte 0

.word 2 ;  Hook Block
.word INCREASE_HOOK_2
.halfword increase_2 - main_block_end
.byte 8
.byte 0

.word 0 ;  Patch Block
.word SET_PATCH_ADD
.word 8
    lh      v0, 0x0(v0)
    sll     v0, 1

.close
