function filterProjects() {
            const filterValue = document.getElementById('add-sort').value;
            const projects = document.querySelectorAll('.funding-project');
            let filteredCount = 0;

            projects.forEach(project => {
                const percentage = project.getAttribute('data-percentage');
                let show = false;

                if (filterValue === 'added') {
                    show = true;
                } else if (filterValue === 'less_than_75' && percentage <= 75) {
                    show = true;
                } else if (filterValue === 'between_75_and_100' && percentage > 75 && percentage < 100) {
                    show = true;
                } else if (filterValue === 'more_than_100' && percentage >= 100) {
                    show = true;
                }

                if (show) {
                    project.style.display = 'block';
                    filteredCount++;
                } else {
                    project.style.display = 'none';
                }
            });

            // 필터링된 프로젝트 개수 업데이트
            document.getElementById('projectCount').innerText = filteredCount;
        }