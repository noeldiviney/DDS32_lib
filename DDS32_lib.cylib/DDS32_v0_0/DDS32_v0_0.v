/* ============================================================================
 * File Name: DDS32_v0_0.v
 * Version 0.0 (build 01)
 * 
 * Description:
 *   DDS32: up to 32-bit DDS frequency generator component (v0.0)
 *   adjustable resolution: 8, 16, 24, 32-bits
 *   realized in UDB datapath
 *
 * Credits:
 *   based on original DDS code by <voha6>:
 *   http://kazus.ru/forums/showthread.php?t=21022&page=10
 * 
 *   Special thanks to <pavloven>, <kabron>
 *
 * Note:
 *   frequency resolution = clock_frequency / 2^N, N=8, 16, 24, 32 
 *   frequency maximum    = clock_frequency / 2
 *   frequency minimum    = clock_frequency / 2^N
 *
 * ============================================================================
 * PROVIDED AS-IS, NO WARRANTY OF ANY KIND, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 * FREE TO SHARE, USE AND MODIFY UNDER TERMS: CREATIVE COMMONS - SHARE ALIKE
 * ============================================================================
*/


//`#start header` -- edit after this line, do not edit this line
`include "cypress.v"
`ifdef DDS32_V0_0_ALREADY_INCLUDED
`else
`define DDS32_V0_0_ALREADY_INCLUDED
//`#end` -- edit above this line, do not edit this line
// Generated on 01/03/2011 at 14:41
// Component: DDS32_v0_0
/*
********************************************************************************
* Data Path register definitions
********************************************************************************
* DDS32_v0_0: dpDDS_u0, dpDDS_u1, dpDDS_u2, dpDDS_u3
* DESCRIPTION: Used to implement ...
* REGISTER USAGE:
* F0 => not used
* F1 => not used
* D0 => phase increment on each clock constant
* D1 => not used
* A0 => phase accumulator
* A1 => not used
*
********************************************************************************
* I*O Signals:
********************************************************************************
*    name              direction       Description
*    clk               input           Clock                      
*    res		       input           Reset
*    outp	               output          Output freq 
*    drq               output          DMA request
*
********************************************************************************/
module DDS32_v0_0 (
	drq,
	outp,
	clk,
	res
);
	output  drq;
	output  outp;
	input   clk;
	input   res;
    parameter BusWidth = 8'd8;

//`#start body` -- edit after this line, do not edit this line
    /* Unused Datapath Output Signals */
    wire     nc1,nc2,nc3,nc4,nc5,nc6,nc7,nc8,nc9, nc10, nc11, nc12;
    /***************************************************************************
    *               Parameters                                                 *
    ***************************************************************************/
	
	localparam [7:0]    DDS_8_BIT    = 8'd8;
    localparam [7:0]    DDS_16_BIT   = 8'd16;
	localparam [7:0]    DDS_24_BIT   = 8'd24;
	localparam [7:0]    DDS_32_BIT   = 8'd32;    

	
							 
	wire co_msb;
	assign drq = co_msb;
	
	wire cmsb;
	assign outp = cmsb;
	
    /***************************************************************************
    *         Instantiation of udb_clock_enable  
    ****************************************************************************
    * The udb_clock_enable primitive component is used to indicate that the input
	* clock must always be synchronous and if not implement synchronizers to make
	* it synchronous.
    */
    wire op_clk;    /* operational clock */
    
    cy_psoc3_udb_clock_enable_v1_0 #(.sync_mode(`TRUE)) ClkSync
    (
        /* input  */    .clock_in(clk),
        /* input  */    .enable(1'b1),
        /* output */    .clock_out(op_clk)
    );  	
	
	localparam [2:0] ACC_CMD_SUM = 3'b0;
	wire [2:0] cs_addr;
	
	assign cs_addr = ACC_CMD_SUM;

//`#end` -- edit above this line, do not edit this line
    /**************************************************************************/
    /* Instantiate the data path elements                                     */
    /**************************************************************************/
    
    parameter dpconfig0 = 
{
    `CS_ALU_OP__ADD, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM0:      sum*/
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM1:      */
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM2:      */
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM3:      */
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM4:      */
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM5:      */
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM6:      */
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM7:      */
    8'hFF, 8'h00,  /*CFG9:      */
    8'hFF, 8'hFF,  /*CFG11-10:      */
    `SC_CMPB_A1_D1, `SC_CMPA_A1_D1, `SC_CI_B_ARITH,
    `SC_CI_A_ARITH, `SC_C1_MASK_DSBL, `SC_C0_MASK_DSBL,
    `SC_A_MASK_DSBL, `SC_DEF_SI_0, `SC_SI_B_DEFSI,
    `SC_SI_A_DEFSI, /*CFG13-12:      */
    `SC_A0_SRC_ACC, `SC_SHIFT_SL, 1'h0,
    1'h0, `SC_FIFO1_BUS, `SC_FIFO0_BUS,
    `SC_MSB_DSBL, `SC_MSB_BIT0, `SC_MSB_NOCHN,
    `SC_FB_NOCHN, `SC_CMP1_NOCHN,
    `SC_CMP0_NOCHN, /*CFG15-14:      */
    10'h00, `SC_FIFO_CLK__DP,`SC_FIFO_CAP_AX,
    `SC_FIFO_LEVEL,`SC_FIFO__SYNC,`SC_EXTCRC_DSBL,
    `SC_WRK16CAT_DSBL /*CFG17-16:      */
};

    parameter dpconfig1 = 
{
    `CS_ALU_OP__ADD, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM0:      sum*/
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM1:      */
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM2:      */
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM3:      */
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM4:      */
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM5:      */
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM6:      */
    `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
    `CS_SHFT_OP_PASS, `CS_A0_SRC_NONE, `CS_A1_SRC_NONE,
    `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
    `CS_CMP_SEL_CFGA, /*CFGRAM7:      */
    8'hFF, 8'h00,  /*CFG9:      */
    8'hFF, 8'hFF,  /*CFG11-10:      */
    `SC_CMPB_A1_D1, `SC_CMPA_A1_D1, `SC_CI_B_CHAIN,
    `SC_CI_A_CHAIN, `SC_C1_MASK_DSBL, `SC_C0_MASK_DSBL,
    `SC_A_MASK_DSBL, `SC_DEF_SI_0, `SC_SI_B_DEFSI,
    `SC_SI_A_DEFSI, /*CFG13-12:      */
    `SC_A0_SRC_ACC, `SC_SHIFT_SL, 1'h0,
    1'h0, `SC_FIFO1_BUS, `SC_FIFO0_BUS,
    `SC_MSB_DSBL, `SC_MSB_BIT7, `SC_MSB_NOCHN,
    `SC_FB_NOCHN, `SC_CMP1_NOCHN,
    `SC_CMP0_NOCHN, /*CFG15-14:      */
    10'h00, `SC_FIFO_CLK__DP,`SC_FIFO_CAP_AX,
    `SC_FIFO_LEVEL,`SC_FIFO__SYNC,`SC_EXTCRC_DSBL,
    `SC_WRK16CAT_DSBL /*CFG17-16:      */
};

	generate 
	if(BusWidth == DDS_8_BIT) begin : sD8
	cy_psoc3_dp8 #(.cy_dpconfig_a (dpconfig0))
    DDSdp(
        /*  input                   */  .reset(res),
        /*  input                   */  .clk(op_clk),
        /*  input   [02:00]         */  .cs_addr(cs_addr),
        /*  input                   */  .route_si(1'b0),
        /*  input                   */  .route_ci(1'b0),
        /*  input                   */  .f0_load(1'b0),
        /*  input                   */  .f1_load(1'b0),
        /*  input                   */  .d0_load(1'b0),
        /*  input                   */  .d1_load(1'b0),
        /*  output                  */  .ce0(),
        /*  output                  */  .cl0(),
        /*  output                  */  .z0(),
        /*  output                  */  .ff0(),
        /*  output                  */  .ce1(),
        /*  output                  */  .cl1(),
        /*  output                  */  .z1(),
        /*  output                  */  .ff1(),
        /*  output                  */  .ov_msb(),
        /*  output                  */  .co_msb(co_msb),
        /*  output                  */  .cmsb(cmsb),
        /*  output                  */  .so(),
        /*  output                  */  .f0_bus_stat(),
        /*  output                  */  .f0_blk_stat(),
        /*  output                  */  .f1_bus_stat(),
        /*  output                  */  .f1_blk_stat()
);
	end //end of if statement for 8 bit section of generate
    else if(BusWidth <= DDS_16_BIT) begin : sD16
	cy_psoc3_dp16 #(.cy_dpconfig_a (dpconfig0), .cy_dpconfig_b (dpconfig1))
    DDSdp(
        /*  input                   */  .reset(res),
        /*  input                   */  .clk(op_clk),
        /*  input   [02:00]         */  .cs_addr(cs_addr),
        /*  input                   */  .route_si(1'b0),
        /*  input                   */  .route_ci(1'b0),
        /*  input                   */  .f0_load(1'b0),
        /*  input                   */  .f1_load(1'b0),
        /*  input                   */  .d0_load(1'b0),
        /*  input                   */  .d1_load(1'b0),
        /*  output  [01:00]                  */  .ce0(),
        /*  output  [01:00]                  */  .cl0(),
        /*  output  [01:00]                  */  .z0(),
        /*  output  [01:00]                  */  .ff0(),
        /*  output  [01:00]                  */  .ce1(),
        /*  output  [01:00]                  */  .cl1(),
        /*  output  [01:00]                  */  .z1(),
        /*  output  [01:00]                  */  .ff1(),
        /*  output  [01:00]                  */  .ov_msb(),
        /*  output  [01:00]                  */  .co_msb({co_msb,nc1}),
        /*  output  [01:00]                  */  .cmsb({cmsb,nc2}),
        /*  output  [01:00]                  */  .so(),
        /*  output  [01:00]                  */  .f0_bus_stat(),
        /*  output  [01:00]                  */  .f0_blk_stat(),
        /*  output  [01:00]                  */  .f1_bus_stat(),
        /*  output  [01:00]                  */  .f1_blk_stat()
);
	end /*end of else statement of 16 bit section of generate*/
    else if(BusWidth <= DDS_24_BIT) begin : sD24
    cy_psoc3_dp24 #(.cy_dpconfig_a (dpconfig0), .cy_dpconfig_b (dpconfig1), 
                    .cy_dpconfig_c (dpconfig1))
    DDSdp(
        /*  input                   */  .reset(res),
        /*  input                   */  .clk(op_clk),
        /*  input   [02:00]         */  .cs_addr(cs_addr),
        /*  input                   */  .route_si(1'b0),
        /*  input                   */  .route_ci(1'b0),
        /*  input                   */  .f0_load(1'b0),
        /*  input                   */  .f1_load(1'b0),
        /*  input                   */  .d0_load(1'b0),
        /*  input                   */  .d1_load(1'b0),
        /*  output  [02:00]                  */  .ce0(),
        /*  output  [02:00]                  */  .cl0(),
        /*  output  [02:00]                  */  .z0(),
        /*  output  [02:00]                  */  .ff0(),
        /*  output  [02:00]                  */  .ce1(),
        /*  output  [02:00]                  */  .cl1(),
        /*  output  [02:00]                  */  .z1(),
        /*  output  [02:00]                  */  .ff1(),
        /*  output  [02:00]                  */  .ov_msb(),
        /*  output  [02:00]                  */  .co_msb({co_msb,nc3,nc4}),
        /*  output  [02:00]                  */  .cmsb({cmsb,nc5,nc6}),
        /*  output  [02:00]                  */  .so(),
        /*  output  [02:00]                  */  .f0_bus_stat(),
        /*  output  [02:00]                  */  .f0_blk_stat(),
        /*  output  [02:00]                  */  .f1_bus_stat(),
        /*  output  [02:00]                  */  .f1_blk_stat()
);
	end /*end of else statement of 24 bit section of generate*/
    else if(BusWidth <= DDS_32_BIT) begin : sD32
    cy_psoc3_dp32 #(.cy_dpconfig_a (dpconfig0), .cy_dpconfig_b (dpconfig1), 
                    .cy_dpconfig_c (dpconfig1), .cy_dpconfig_d (dpconfig1))
    DDSdp(
        /*  input                   */  .reset(res),
        /*  input                   */  .clk(op_clk),
        /*  input   [02:00]         */  .cs_addr(cs_addr),
        /*  input                   */  .route_si(1'b0),
        /*  input                   */  .route_ci(1'b0),
        /*  input                   */  .f0_load(1'b0),
        /*  input                   */  .f1_load(1'b0),
        /*  input                   */  .d0_load(1'b0),
        /*  input                   */  .d1_load(1'b0),
        /*  output  [03:00]                  */  .ce0(),
        /*  output  [03:00]                  */  .cl0(),
        /*  output  [03:00]                  */  .z0(),
        /*  output  [03:00]                  */  .ff0(),
        /*  output  [03:00]                  */  .ce1(),
        /*  output  [03:00]                  */  .cl1(),
        /*  output  [03:00]                  */  .z1(),
        /*  output  [03:00]                  */  .ff1(),
        /*  output  [03:00]                  */  .ov_msb(),
        /*  output  [03:00]                  */  .co_msb({co_msb,nc7,nc8,nc9}),
        /*  output  [03:00]                  */  .cmsb({cmsb,nc10,nc11,nc12}),
        /*  output  [03:00]                  */  .so(),
        /*  output  [03:00]                  */  .f0_bus_stat(),
        /*  output  [03:00]                  */  .f0_blk_stat(),
        /*  output  [03:00]                  */  .f1_bus_stat(),
        /*  output  [03:00]                  */  .f1_blk_stat()
);
	end /*end of else statement of 32 bit section of generate*/
	endgenerate
endmodule
//`#start footer` -- edit after this line, do not edit this line
`endif /* DDS_v1_0_V_ALREADY_INCLUDED */
//`#end` -- edit above this line, do not edit this line






