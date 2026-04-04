package com.petrescue.i18n

object Messages {

    private val vi: Map<String, String> = mapOf(
        // Site-wide
        "site_name" to "Trạm Cứu Hộ Thú Cưng",
        "nav_pets" to "Thú Cưng",
        "nav_blog" to "Tin Tức",
        "nav_donate" to "Đóng Góp",
        "nav_rescue" to "Báo Cứu Hộ",
        "nav_adoptions" to "Nhận Nuôi",
        "nav_finance" to "Tài Chính",
        "nav_users" to "Người Dùng",
        "nav_donations" to "Danh Sách Đóng Góp",
        "nav_login" to "Đăng Nhập",
        "nav_register" to "Đăng Ký",
        "nav_logout" to "Đăng Xuất",
        "footer_text" to "Trạm Cứu Hộ Thú Cưng – Cứu từng sinh linh nhỏ bé 🐾",
        "lang_toggle" to "English",

        // Home page – hero
        "home_hero_title" to "Yêu Thương & Bảo Vệ",
        "home_hero_subtitle" to "Chúng tôi giải cứu, chữa trị và tìm mái ấm cho những thú cưng cần giúp đỡ. Hãy đồng hành cùng chúng tôi bằng cách nhận nuôi, tình nguyện hoặc quyên góp.",
        "home_btn_volunteer" to "Tình Nguyện Viên",
        "home_btn_donate" to "Đóng Góp",
        "home_btn_browse_pets" to "Ngắm Các Bé",
        "home_btn_stats" to "Thống Kê",

        // Stats
        "stats_available" to "Thú cưng đang có",
        "stats_adopted" to "Thú cưng đã được nhận nuôi",
        "stats_treated" to "Thú cưng đã được chữa trị",
        "stats_donors" to "Người đã đóng góp",

        // Pets slider
        "slider_title" to "Những Bé Đang Chờ Bạn",
        "slider_view_all" to "Xem Tất Cả",
        "pet_years_old" to "tuổi",

        // Video story
        "video_title" to "Câu Chuyện Của Các Bé",
        "video_subtitle" to "Mỗi thú cưng đều có một câu chuyện. Hãy xem hành trình của các bé từ khi được giải cứu đến khi tìm được mái ấm.",

        // Station intro
        "station_title" to "Về Trạm Cứu Hộ Của Chúng Tôi",
        "station_text" to "Chúng tôi là trạm cứu hộ thú cưng phi lợi nhuận, hoạt động với sứ mệnh giải cứu, chăm sóc và tìm mái ấm cho những con vật bị bỏ rơi hoặc lạc đường. Với đội ngũ tình nguyện viên tận tâm và sự hỗ trợ của cộng đồng, chúng tôi cam kết mang lại cuộc sống tốt đẹp hơn cho mọi thú cưng.",
        "station_mission_title" to "Sứ Mệnh",
        "station_mission_text" to "Giải cứu, chữa trị và tìm mái ấm yêu thương cho mọi thú cưng cần giúp đỡ.",
        "station_vision_title" to "Tầm Nhìn",
        "station_vision_text" to "Một xã hội nơi không có thú cưng nào bị bỏ rơi hay ngược đãi.",
        "station_volunteer_title" to "Tình Nguyện Viên",
        "station_volunteer_text" to "Hơn 50 tình nguyện viên tận tâm đang làm việc mỗi ngày để chăm sóc và bảo vệ các bé.",
        "station_cta" to "Tham Gia Cùng Chúng Tôi"
    )

    private val en: Map<String, String> = mapOf(
        // Site-wide
        "site_name" to "Pet Rescue Station",
        "nav_pets" to "Pets",
        "nav_blog" to "Blog",
        "nav_donate" to "Donate",
        "nav_rescue" to "Report Rescue",
        "nav_adoptions" to "Adoptions",
        "nav_finance" to "Finance",
        "nav_users" to "Users",
        "nav_donations" to "Donations",
        "nav_login" to "Login",
        "nav_register" to "Register",
        "nav_logout" to "Logout",
        "footer_text" to "Pet Rescue Station – Saving lives one paw at a time 🐾",
        "lang_toggle" to "Tiếng Việt",

        // Home page – hero
        "home_hero_title" to "Love & Protect",
        "home_hero_subtitle" to "We rescue, treat, and rehome pets in need. Join us by adopting, volunteering, or donating.",
        "home_btn_volunteer" to "Volunteer",
        "home_btn_donate" to "Donate",
        "home_btn_browse_pets" to "Browse Pets",
        "home_btn_stats" to "Statistics",

        // Stats
        "stats_available" to "Pets currently available",
        "stats_adopted" to "Pets successfully adopted",
        "stats_treated" to "Pets treated & cared for",
        "stats_donors" to "Generous donors",

        // Pets slider
        "slider_title" to "Pets Waiting for You",
        "slider_view_all" to "View All",
        "pet_years_old" to "years old",

        // Video story
        "video_title" to "Their Stories",
        "video_subtitle" to "Every pet has a story. Watch the journey from rescue to forever home.",

        // Station intro
        "station_title" to "About Our Rescue Station",
        "station_text" to "We are a non-profit pet rescue station dedicated to rescuing, caring for, and rehoming abandoned or stray animals. With a devoted team of volunteers and community support, we are committed to giving every pet a better life.",
        "station_mission_title" to "Mission",
        "station_mission_text" to "Rescue, treat, and find loving homes for every pet in need.",
        "station_vision_title" to "Vision",
        "station_vision_text" to "A society where no pet is abandoned or mistreated.",
        "station_volunteer_title" to "Volunteers",
        "station_volunteer_text" to "More than 50 dedicated volunteers working every day to care for and protect the animals.",
        "station_cta" to "Join Us"
    )

    fun forLang(lang: String): Map<String, String> = if (lang == "en") en else vi
}
