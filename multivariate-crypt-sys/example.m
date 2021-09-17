clc
clear
warning off;



city_name = "Vancouver CA";
ascii = double(char(city_name));

% City name in ASCII
city = [86,97,110,99;
        111,117,118,101;
        114,32,67,65];

%Run Encryption on City Name
for i = 1:length(city(:,1))
        result = enc_func(city(i,:));
        result
end

%Encryption Function
function enc_out = enc_func(block_in)
   
    syms a b c d

%   Prime of Field
    prime_p = 457;

%Lambda 1 Matrix
    l1_mat = [4 20 8 1;
            7 4 6 6;
            16 2 17 1;
            5 39 3 6];
    d1 = det(l1_mat);
    b1 = [4 5 6 8];
        
%Lambda 2 Matrix
    l2_mat = [1 31 5 1; 
            10 7 8 10;
            22 4 6 2;
            4 6 7 38];
    d2 = det(l2_mat);
    b2 = [8 3 5 7];
        
%Tau Matrix
    t_mat = [12 7 11 5; 
            0 2 16 3; 
            0 0 19 4; 
            0 0 0 14];
    dt = det(t_mat);
    bt = [3 2 5 1];
        
%Tau
    ta_u = [ 12*a + 7*b*b + 11*c + 5*d*d + 3;
            2*b + 16*c + 3*d*d + 2;
            19*c + 4*d + 5;
            14*d + 1                         ];

    lamda_1 = l1_mat * transpose([a b c d])  + transpose(b1);
    lamda_2 = l2_mat * transpose([a b c d])  + transpose(b2);
    

    vars = [a,b,c,d];
    lambda1 = [lamda_1(1); lamda_1(2); lamda_1(3); lamda_1(4)];
    lambda2 = [lamda_2(1); lamda_2(2); lamda_2(3); lamda_2(4)];
    tau = [ta_u(1); ta_u(2); ta_u(3); ta_u(4)];

%Composition
    tau_lambda2 = subs(tau,  [a;b;c;d], lambda2);
    lambda1_tau_lambda2 = subs(lambda1, [a;b;c;d], tau_lambda2);

%Ensuring Polynomial Coefficients are in Finite Field
    for i = 1:length(vars)
        [c,x] = coeffs(lambda1_tau_lambda2(i));
        cMod = mod(c,prime_p);
        lambda1_tau_lambda2(i) = sum(cMod.*x);
    end

    a = block_in(1);
    b = block_in(2); 
    c = block_in(3);
    d = block_in(4);
    
    %lambda1_tau_lambda2
    enc_out = subs(lambda1_tau_lambda2);
end


%city_name = "Vancouver CA";

% City name in ASCII
%city = [86,97,110,99; 111,117,118,101; 114,32,67,65];

%Public Key 
%        424*a^2 + 448*a*b + 277*a*c + 215*a*d + 321*a + 139*b^2 + 259*b*c + 184*b*d + 122*b + 228*c^2 + 426*c*d + 366*c + 414*d^2 + 397*d + 363
%        168*a^2 + 433*a*b + 418*a*c + 324*a*d + 353*a + 437*b^2 + 296*b*c + 415*b*d + 280*b + 412*c^2 + 397*c*d + 131*c + 105*d^2 + 275*d + 57
%        237*a^2 + 157*a*b + 343*a*c + 102*a*d + 14*a + 358*b^2 + 117*b*c + 56*b*d + 416*b + 414*c^2 + 149*c*d + 276*c + 112*d^2 + 214*d + 89
%        288*a^2 + 291*a*b + 299*a*c + 355*a*d + 48*a + 429*b^2 + 310*b*c + 188*b*d + 130*b + 58*c^2 + 255*c*d + 129*c + 156*d^2 + 430*d + 122



% Encrytption output 
% 28737303 33259573 20153247 24639431 37342151 43427823 26560215 33115259 16652896 15399687 10790302 13290038
