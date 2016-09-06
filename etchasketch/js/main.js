function createGrid(rows, cols) {
	$("#boxContainer").empty();
	for (var i = 0; i < rows*cols; i++) {
		$('#boxContainer').append('<div class="newBox"></div>');
	};
	$('.newBox').height(100/rows + "%");
	$('.newBox').width(100/cols + "%");
	$('.newBox').mouseenter(function() {
		$(this).css("background-color","pink");
	});
	$('.newBox').css("background-color","black");
	return;
};

$(document).ready(function() {
	createGrid(30,30);
	$('#goButton').click(function() {
		var h = $('#heightBox').val();
		var w = $('#widthBox').val()
		if (h >= 1 && h <= 90 &&
			w >= 1 && w <= 90) {
			createGrid(Math.floor(w), Math.floor(h));
		}
	});
	$('#resetButton').click(function() {
		$('.newBox').css("background-color","black");
	});
});
