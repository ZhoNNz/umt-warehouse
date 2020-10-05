
function esyateslimat() {$.post('http://umt-newtablet/esyateslimat', JSON.stringify({}));};

  
function silahteslimat() {$.post('http://umt-newtablet/silahteslimat', JSON.stringify({}));};


function aracteslimat() {$.post('http://umt-newtablet/aracteslimat', JSON.stringify({}));};

  function methal(i, f) {$.post('http://umt-newtablet/methal', JSON.stringify({i:i, f:f}));
  $(".ray_f").hide();
  $(".container").hide();
  $.post('http://umt-newtablet/exit', JSON.stringify({}));
  };
