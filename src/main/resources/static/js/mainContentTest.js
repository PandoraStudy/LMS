function initMainContentTest() {
	$(".search_btn").click(
		function(e) {
			alert("d");
			e.preventDefault();
			$.ajax({
				url : "/search",
				type : "POST",
				dataType : "json",
				data : $("#search-form").serialize(),
				success : function(data) {
					$('#tableBody').empty();
					$('#cnt').empty();
					var result = data;
					var str = "";
					$.each(result, function(i, info) {
						str += '<tr><td>' + info.procedure
								+ '</td><td>' + info.admission
								+ '</td><td>' + info.student_no
								+ '</td><td>' + info.name
								+ '</td><td>' + info.birth
								+ '</td><td>' + info.gender
								+ '</td><td>' + info.department
								+ '</td><td>' + info.day_and_night
								+ '</td><td>' + info.grade
								+ '</td><td>' + info.division
								+ '</td><td>' + info.academic_status
								+ '</td><td>' + info.date_of_admission
								+ '</td></tr>';
					});
					$('#tableBody').append(str);
					$('#cnt').append(result.length);
				}
			});
		});
	};
