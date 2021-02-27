module uart(        
	    input clk_12m,
	    output DEV_TX);

wire rxclk_en, txclk_en;
reg TX_BUSY;
reg [7:0] MY_DATA [12:0];
reg MY_WR_EN;
reg [7:0] current_data;
reg [4:0] word_pos;

initial begin
    MY_DATA[0] = "H";    
    MY_DATA[1] = "e";    
    MY_DATA[2] = "l";    
    MY_DATA[3] = "l";    
    MY_DATA[4] = "o";    
    MY_DATA[5] = " ";    
    MY_DATA[6] = "w";    
    MY_DATA[7] = "o";    
    MY_DATA[8] = "r";    
    MY_DATA[9] = "l";    
    MY_DATA[10] = "d";    
    MY_DATA[11] = "!";    
    MY_WR_EN = 0;
    word_pos = 4'h0;
end

baud_rate_gen uart_baud(.clk_12m(clk_12m),
			.rxclk_en(rxclk_en),
			.txclk_en(txclk_en));	


transmitter uart_tx(.din(current_data),
		    .wr_en(MY_WR_EN),
		    .clk_12m(clk_12m),
		    .clken(txclk_en),
		    .tx(DEV_TX),
		    .tx_busy(TX_BUSY));		
		    
always @(posedge clk_12m) begin
    if (!TX_BUSY) begin                
        if (word_pos == 4'hc)
             word_pos = 4'h0;
        current_data = MY_DATA[word_pos];        
        word_pos = word_pos + 4'h1;                        
        MY_WR_EN = 1;                
    end
end		        
/*		    
led led_debuger(.clk(txclk_en),
                .LED_R(LED_R),
                .LED_G(LED_G),
                .LED_B(LED_B));				    
  */
/*
receiver uart_rx(.rx(rx),
		 .rdy(rdy),
		 .rdy_clr(rdy_clr),
		 .clk_50m(clk_50m),
		 .clken(rxclk_en),
		 .data(dout));
*/		 

endmodule

