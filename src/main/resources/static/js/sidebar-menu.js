document.addEventListener("DOMContentLoaded", function () {
    "use strict";

    // 모든 <a> 태그 클릭 이벤트 처리
    document.querySelectorAll("a").forEach(function (link) {
        link.addEventListener("click", function (e) {
            e.preventDefault(); // 기본 동작 방지
            const href = link.getAttribute("href");
            console.log(href); // 링크 주소 확인
            if (href) window.location.href = href; // 페이지 이동
        });
    });

    // URL에서 드롭다운 상태 읽기
    const urlParams = new URLSearchParams(window.location.search);
    const dropdownIndex = urlParams.get("dropdownIndex");
    const selectedIndex = urlParams.get("selectedIndex");

    // 페이지 로드 시 드롭다운 상태 복원
    if (dropdownIndex !== null) {
        const dropD = document.querySelectorAll(".dropD")[parseInt(dropdownIndex, 10)];
        if (dropD) {
            const dropMenu = dropD.querySelector(".dropD-menu");
            const icon = dropD.querySelector("a > .fa-solid");

            if (dropMenu) dropMenu.classList.add("show");
            if (icon) {
                icon.classList.remove("fa-angle-right");
                icon.classList.add("fa-angle-down");
            }
        }
    }

    // 페이지 로드 시 선택된 항목 복원
    if (selectedIndex !== null) {
        const selectedItem = document.querySelectorAll(".dropD-menu > li")[parseInt(selectedIndex, 10)];
        if (selectedItem) selectedItem.classList.add("selected");
    }

    // 드롭다운 클릭 이벤트
    document.querySelectorAll(".dropD").forEach(function (dropD, index) {
        dropD.addEventListener("click", function (e) {
            e.stopPropagation(); // 이벤트 전파 방지

            const dropMenu = dropD.querySelector(".dropD-menu");
            const icon = dropD.querySelector(".fa-solid");
            const isOpen = dropMenu && dropMenu.classList.contains("show");

            // 다른 드롭다운 초기화
            document.querySelectorAll(".dropD-menu").forEach(function (menu) {
                menu.classList.remove("show");
            });
            document.querySelectorAll(".fa-solid").forEach(function (icon) {
                icon.classList.remove("fa-angle-down");
                icon.classList.add("fa-angle-right");
            });

            // 현재 드롭다운 열기
            if (!isOpen && dropMenu) {
                dropMenu.classList.add("show");
                if (icon) {
                    icon.classList.remove("fa-angle-right");
                    icon.classList.add("fa-angle-down");
                }
            }

            // URL 쿼리 파라미터에 상태 저장
            const currentUrl = new URL(window.location.href);
            currentUrl.searchParams.set("dropdownIndex", index);
            window.history.replaceState({}, "", currentUrl); // URL 갱신
        });
    });

    // 드롭다운 내부 링크 클릭 이벤트
    document.querySelectorAll(".dropD-menu > li > a").forEach(function (link) {
        link.addEventListener("click", function (e) {
            e.preventDefault(); // 기본 동작 방지
            const listItem = link.closest("li");
            const dropdownIndex = Array.from(document.querySelectorAll(".dropD")).indexOf(listItem.closest(".dropD"));
            const selectedIndex = Array.from(document.querySelectorAll(".dropD-menu > li")).indexOf(listItem);

            // 모든 항목에서 selected 클래스 제거
            document.querySelectorAll(".dropD-menu > li").forEach(function (item) {
                item.classList.remove("selected");
            });

            // 현재 항목에 selected 클래스 추가
            if (listItem) listItem.classList.add("selected");

            // URL에 상태 저장
            const currentUrl = new URL(link.getAttribute("href"), window.location.href);
            currentUrl.searchParams.set("dropdownIndex", dropdownIndex);
            currentUrl.searchParams.set("selectedIndex", selectedIndex);
            window.location.href = currentUrl.toString(); // 페이지 이동
        });
    });

    // 외부 클릭 시 모든 드롭다운 닫기
    document.addEventListener("click", function () {
        document.querySelectorAll(".dropD-menu").forEach(function (menu) {
            menu.classList.remove("show");
        });
        document.querySelectorAll(".fa-solid").forEach(function (icon) {
            icon.classList.remove("fa-angle-down");
            icon.classList.add("fa-angle-right");
        });
    });

    // 사이드바 메뉴 초기화 함수
    function sidebarMenu(menu) {
        const animationSpeed = 300; // 애니메이션 속도
        const subMenuSelector = ".sidebar-submenu";

        menu.querySelectorAll("li > a").forEach(function (link) {
            link.addEventListener("click", function (e) {
                const checkElement = link.nextElementSibling;

                if (checkElement && checkElement.matches(subMenuSelector)) {
                    e.preventDefault(); // 기본 동작 방지

                    if (checkElement.style.display === "block") {
                        checkElement.style.display = "none";
                        checkElement.classList.remove("menu-open");
                        link.closest("li").classList.remove("active");
                    } else {
                        const parent = link.closest("ul");

                        // 다른 서브메뉴 닫기
                        parent.querySelectorAll(subMenuSelector).forEach(function (submenu) {
                            submenu.style.display = "none";
                            submenu.classList.remove("menu-open");
                        });

                        parent.querySelectorAll("li.active").forEach(function (activeLi) {
                            activeLi.classList.remove("active");
                        });

                        // 현재 서브메뉴 열기
                        checkElement.style.display = "block";
                        checkElement.classList.add("menu-open");
                        link.closest("li").classList.add("active");
                    }
                }
            });
        });
    }

    // 사이드바 메뉴 초기화
    const sidebar = document.querySelector(".sidebar-menu");
    if (sidebar) {
        sidebarMenu(sidebar);
    }
});
