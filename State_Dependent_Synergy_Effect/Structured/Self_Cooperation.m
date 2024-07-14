function proportion=Self_Cooperation(p,q)
distribution=Stationary_Distribution(p,q,p,q);
proportion=distribution(1)+1/2*(distribution(2)+distribution(3));
end