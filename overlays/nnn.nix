final: prev: {
	nnn = prev.nnn.override{ 
	      		withNerdIcons=true; 
			extraMakeFlags=["O_CTX8=1"];
	};
  }
