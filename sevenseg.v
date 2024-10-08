module sevenseg(input clk, output [6:0] display, output [3:0] digit_select);

reg [18:0] digit_change_counter = 0;
reg [25:0] number_change_counter = 0;
reg [1:0] led_counter = 0;
reg [3:0] digit_extracted;
reg [11:0] number = 0;

always @ (posedge clk) begin

    digit_change_counter <= digit_change_counter + 1;
    number_change_counter <= number_change_counter + 1;

if (digit_change_counter == 135000) begin

    digit_change_counter <= 0;
    led_counter <= led_counter + 1;

end

if (number_change_counter == 2700000) begin

        number_change_counter <= 0;
        number = number + 1;
        
end

if (number == 1000) begin

    number <= 0;

end


if (led_counter == 3) begin

    led_counter <= 0;

end


    case (led_counter)
    2'b00: begin
        digit_select <= 4'b0001;
        digit_extracted <= number / 100 % 10;
    end
    2'b01: begin
        digit_select <= 4'b0010;
        digit_extracted <= number / 10 % 10;
    end
    2'b10: begin
        digit_select <= 4'b0100;
        digit_extracted <= number % 10;
    end
    2'b11: begin
        digit_select <= 4'b0110;
        digit_extracted <= number % 10;
    end
    endcase

    

    case (digit_extracted)
    0: 
    display <= 7'b0000001;
    1:
    display <= 7'b1001111;
    2: 
    display <= 7'b0010010;
    3:
    display <= 7'b0000110;
    4: 
    display <= 7'b1001100;
    5:
    display <= 7'b0100100;
    6: 
    display <= 7'b0100000;
    7:
    display <= 7'b0001111;
    8: 
    display <= 7'b0000000;
    9:
    display <= 7'b0000100;
    
    endcase
end

endmodule


module top(input clk, output [6:0] display, output [3:0] digit_select);

sevenseg disp(
    .clk(clk),
    .display(display),
    .digit_select(digit_select)
);

endmodule