function [derivative] = derive(f_handle,targetvalue,additive)
derivative = (f_handle(targetvalue+additive)-f_handle(targetvalue)) / additive;
return

