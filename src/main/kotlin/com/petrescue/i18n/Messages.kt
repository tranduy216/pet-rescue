package com.petrescue.i18n

object Messages {

    private val vi: Map<String, String> = mapOf(
        // Site-wide
        "site_name" to "Trạm Cứu Hộ",
        "nav_pets" to "Thú Cưng",
        "nav_blog" to "Tin Tức",
        "nav_donate" to "Đóng Góp",
        "nav_rescue" to "Báo Cứu Hộ",
        "nav_adoptions" to "Nhận Nuôi",
        "nav_finance" to "Tài Chính",
        "nav_users" to "Người Dùng",
        "nav_donations" to "Mạnh Thường Quân",
        "nav_config" to "Cấu Hình",
        "nav_profile" to "Hồ Sơ",
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
        "station_cta" to "Tham Gia Cùng Chúng Tôi",

        // Recent rescued pets
        "recent_pets_title" to "Các Bé Vừa Được Giải Cứu",
        "recent_pets_subtitle" to "Những chú thú cưng mới nhất đang cần sự quan tâm của bạn.",
        "recent_pets_view_detail" to "Xem chi tiết →",

        // Config page
        "config_title" to "Cấu Hình Trang Chủ",
        "config_homepage_title" to "Tiêu Đề Chính",
        "config_homepage_subtitle" to "Nội Dung Giới Thiệu",
        "config_homepage_video_url" to "URL Video Nhúng (YouTube Embed)",
        "config_save" to "Lưu Thay Đổi",
        "config_saved" to "Đã lưu cấu hình thành công!",
        "config_video_url_error" to "URL video không hợp lệ. Chỉ chấp nhận URL nhúng YouTube (https://www.youtube.com/embed/...)",

        // Profile page
        "profile_title" to "Hồ Sơ Của Tôi",
        "profile_fullname" to "Họ Và Tên",
        "profile_email" to "Email",
        "profile_phone" to "Số Điện Thoại",
        "profile_save" to "Lưu Thay Đổi",
        "profile_saved" to "Đã cập nhật hồ sơ thành công!",
        "profile_email_taken" to "Email này đã được sử dụng bởi tài khoản khác.",

        // User roles
        "role_user" to "Người Dùng",
        "role_volunteer" to "Tình Nguyện Viên",
        "role_admin" to "Quản Trị Viên",

        // User active status
        "status_active" to "Đang Hoạt Động",
        "status_inactive" to "Không Hoạt Động",

        // Pet types
        "pet_type_all" to "Tất Cả Loại",
        "pet_type_dog" to "🐕 Chó",
        "pet_type_cat" to "🐈 Mèo",
        "pet_type_other" to "🐾 Khác",

        // Pet statuses
        "pet_status_all" to "Tất Cả Trạng Thái",
        "pet_status_available" to "Sẵn Sàng",
        "pet_status_adopted" to "Đã Được Nhận",
        "pet_status_rescued" to "Đã Được Cứu",

        // Pet genders
        "pet_gender_unknown" to "Không Rõ",
        "pet_gender_male" to "Đực",
        "pet_gender_female" to "Cái",

        // Rescue statuses
        "rescue_status_reported" to "Đã Báo Cáo",
        "rescue_status_in_progress" to "Đang Xử Lý",
        "rescue_status_rescued" to "Đã Cứu",
        "rescue_status_failed" to "Thất Bại",

        // Finance types
        "finance_type_income" to "Thu Nhập",
        "finance_type_expense" to "Chi Tiêu",

        // Adoption statuses
        "adoption_status_requested" to "Đã Yêu Cầu",
        "adoption_status_approved" to "Đã Duyệt",
        "adoption_status_cancelled" to "Đã Hủy",

        // Common buttons
        "btn_save" to "Lưu",
        "btn_cancel" to "Hủy",
        "btn_delete" to "Xóa",
        "btn_edit" to "Chỉnh Sửa",
        "btn_update" to "Cập Nhật",
        "btn_approve" to "Duyệt",
        "btn_confirm" to "Xác Nhận",
        "btn_add_entry" to "+ Thêm Giao Dịch",
        "btn_view" to "Xem",
        "btn_adopt" to "Nhận Nuôi",
        "confirm_delete" to "Bạn có chắc muốn xóa không?",
        "blog_views" to "lượt xem",

        // Pet form
        "pet_form_add" to "Thêm Thú Cưng",
        "pet_form_edit" to "Chỉnh Sửa Thú Cưng",
        "pet_field_name" to "Tên",
        "pet_field_type" to "Loại",
        "pet_field_status" to "Trạng Thái",
        "pet_field_breed" to "Giống",
        "pet_field_age" to "Tuổi (năm)",
        "pet_field_gender" to "Giới Tính",
        "pet_field_description" to "Mô Tả",
        "pet_field_photos" to "Ảnh",
        "pet_search_placeholder" to "Tìm theo tên...",
        "pet_add_btn" to "+ Thêm Thú Cưng",
        "pet_back" to "← Quay Lại Danh Sách",
        "pet_detail_type" to "Loại:",
        "pet_detail_breed" to "Giống:",
        "pet_detail_age" to "Tuổi:",
        "pet_detail_gender" to "Giới Tính:",
        "pet_request_adoption" to "🏠 Yêu Cầu Nhận Nuôi",
        "pet_empty" to "Không có thú cưng nào.",
        "pet_delete_confirm" to "Xóa thú cưng này?",
        "pet_detail_about" to "Giới Thiệu Về",

        // Blog
        "blog_form_new" to "Bài Viết Mới",
        "blog_form_edit" to "Chỉnh Sửa Bài Viết",
        "blog_field_title" to "Tiêu Đề",
        "blog_field_content" to "Nội Dung",
        "blog_field_tags" to "Thẻ",
        "blog_field_publish" to "Xuất Bản Ngay",
        "blog_back" to "← Quay Lại Blog",
        "blog_add_btn" to "+ Bài Viết Mới",
        "blog_read_more" to "Đọc Thêm →",
        "blog_draft" to "Bản Nháp",
        "blog_empty" to "Chưa có bài viết nào.",
        "blog_delete_confirm" to "Xóa bài viết này?",

        // Rescues
        "rescue_form_title" to "🚨 Báo Cáo Cứu Hộ",
        "rescue_field_location" to "Địa Điểm",
        "rescue_field_location_placeholder" to "Địa chỉ hoặc địa danh",
        "rescue_field_description" to "Mô Tả",
        "rescue_field_description_placeholder" to "Mô tả con vật và tình huống...",
        "rescue_field_contact" to "Thông Tin Liên Hệ",
        "rescue_field_contact_placeholder" to "Số điện thoại hoặc liên hệ khác",
        "rescue_submit" to "Gửi Báo Cáo",
        "rescue_add_btn" to "+ Báo Cáo Cứu Hộ",
        "rescue_contact_label" to "Liên Hệ:",
        "rescue_empty" to "Chưa có báo cáo cứu hộ nào.",
        "rescue_delete_confirm" to "Xóa báo cáo này?",
        "rescue_page_title" to "🚨 Báo Cáo Cứu Hộ",

        // Adoptions
        "adoption_form_title" to "Yêu Cầu Nhận Nuôi",
        "adoption_pet_label" to "Thú Cưng:",
        "adoption_field_phone" to "Số Điện Thoại",
        "adoption_field_facebook" to "Link Facebook",
        "adoption_field_notes" to "Ghi Chú",
        "adoption_field_notes_placeholder" to "Hãy cho chúng tôi biết về bạn và lý do muốn nhận nuôi...",
        "adoption_submit" to "Gửi Yêu Cầu",
        "adoption_col_pet_id" to "Mã Thú Cưng",
        "adoption_col_phone" to "Điện Thoại",
        "adoption_col_facebook" to "Facebook",
        "adoption_col_status" to "Trạng Thái",
        "adoption_col_date" to "Ngày",
        "adoption_col_actions" to "Thao Tác",
        "adoption_empty" to "Chưa có yêu cầu nhận nuôi nào.",
        "adoption_page_title" to "🏠 Nhận Nuôi",

        // Donate form
        "donate_title" to "💚 Đóng Góp",
        "donate_subtitle" to "Sự hỗ trợ của bạn giúp chúng tôi cứu hộ và chăm sóc động vật.",
        "donate_success_title" to "💚 Cảm ơn bạn đã đóng góp!",
        "donate_success_text" to "Đóng góp của bạn đã được ghi lại. Chúng tôi sẽ xác nhận sớm.",
        "donate_return_home" to "Về Trang Chủ",
        "donate_field_name" to "Tên Của Bạn",
        "donate_field_email" to "Email",
        "donate_field_amount" to "Số Tiền (VNĐ)",
        "donate_field_message" to "Tin Nhắn (tùy chọn)",
        "donate_field_message_placeholder" to "Gửi lời động viên tới các bạn tình nguyện...",
        "donate_btn" to "💚 Đóng Góp Ngay",
        "donate_btn_send" to "💌 Gửi Lời Chúc",
        "donate_wish_sent" to "Lời chúc của bạn đã được gửi! Cảm ơn bạn 💚",
        "donate_wish_title" to "Gửi Lời Chúc",
        "donate_wish_subtitle" to "Gửi lời động viên đến trạm cứu hộ",
        "donate_field_name_placeholder" to "Nguyễn Văn A",
        "donate_field_message" to "Lời Nhắn",
        "donate_qr1_title" to "Ủng Hộ Trạm Cứu Hộ",
        "donate_qr1_subtitle" to "Quét mã để chuyển khoản hỗ trợ trạm",
        "donate_qr2_title" to "Ủng Hộ Website",
        "donate_qr2_subtitle" to "Quét mã để chuyển khoản duy trì website",

        // Donate list
        "donate_page_title" to "📋 Đóng Góp",
        "donate_total" to "Tổng Đã Xác Nhận:",
        "donate_col_donor" to "Người Đóng Góp",
        "donate_col_email" to "Email",
        "donate_col_amount" to "Số Tiền",
        "donate_col_message" to "Tin Nhắn",
        "donate_col_status" to "Trạng Thái",
        "donate_col_date" to "Ngày",
        "donate_col_actions" to "Thao Tác",
        "donate_empty" to "Chưa có đóng góp nào.",

        // Users
        "user_form_add" to "Thêm Người Dùng",
        "user_form_edit" to "Chỉnh Sửa Người Dùng",
        "user_field_username" to "Tên Đăng Nhập",
        "user_field_password" to "Mật Khẩu",
        "user_field_fullname" to "Họ Và Tên",
        "user_field_email" to "Email",
        "user_field_phone" to "Điện Thoại",
        "user_field_role" to "Vai Trò",
        "user_field_active" to "Hoạt Động",
        "user_add_btn" to "+ Thêm Người Dùng",
        "user_col_name" to "Họ Tên",
        "user_col_username" to "Tên Đăng Nhập",
        "user_col_email" to "Email",
        "user_col_role" to "Vai Trò",
        "user_col_status" to "Trạng Thái",
        "user_col_actions" to "Thao Tác",
        "user_delete_confirm" to "Xóa người dùng này?",
        "user_page_title" to "👥 Người Dùng",

        // Finance
        "finance_form_title" to "Thêm Giao Dịch",
        "finance_field_type" to "Loại",
        "finance_field_amount" to "Số Tiền",
        "finance_field_description" to "Mô Tả",
        "finance_field_category" to "Danh Mục",
        "finance_field_category_placeholder" to "vd: Thức ăn, Thú y, Đóng góp",
        "finance_field_date" to "Ngày",
        "finance_total_income" to "Tổng Thu Nhập",
        "finance_total_expense" to "Tổng Chi Tiêu",
        "finance_balance" to "Số Dư",
        "finance_overview" to "Tổng Quan 30 Ngày",
        "finance_col_date" to "Ngày",
        "finance_col_type" to "Loại",
        "finance_col_amount" to "Số Tiền",
        "finance_col_category" to "Danh Mục",
        "finance_col_description" to "Mô Tả",
        "finance_col_actions" to "Thao Tác",
        "finance_delete_confirm" to "Xóa giao dịch này?",
        "finance_page_title" to "💰 Tài Chính",
        "finance_add_btn" to "+ Thêm Giao Dịch",

        // Auth
        "auth_login_title" to "🌿 Đăng Nhập",
        "auth_field_username" to "Tên Đăng Nhập",
        "auth_field_password" to "Mật Khẩu",
        "auth_btn_login" to "Đăng Nhập",
        "auth_no_account" to "Chưa có tài khoản?",
        "auth_register_link" to "Đăng Ký",
        "auth_register_title" to "🌿 Đăng Ký",
        "auth_field_fullname" to "Họ Và Tên",
        "auth_field_email" to "Email",
        "auth_field_phone" to "Số Điện Thoại",
        "auth_btn_register" to "Đăng Ký",
        "auth_have_account" to "Đã có tài khoản?",
        "auth_login_link" to "Đăng Nhập",

        // Bilingual homepage config
        "config_homepage_title_vi" to "Tiêu Đề Tiếng Việt",
        "config_homepage_title_en" to "Tiêu Đề Tiếng Anh",
        "config_homepage_subtitle_vi" to "Mô Tả Tiếng Việt",
        "config_homepage_subtitle_en" to "Mô Tả Tiếng Anh",
        "config_homepage_title_vi_hint" to "Tiêu đề lớn hiển thị ở đầu trang chủ (ngôn ngữ Tiếng Việt).",
        "config_homepage_title_en_hint" to "Tiêu đề lớn hiển thị ở đầu trang chủ (ngôn ngữ Tiếng Anh).",
        "config_homepage_subtitle_vi_hint" to "Mô tả ngắn hiển thị bên dưới tiêu đề (ngôn ngữ Tiếng Việt).",
        "config_homepage_subtitle_en_hint" to "Mô tả ngắn hiển thị bên dưới tiêu đề (ngôn ngữ Tiếng Anh)."
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
        "nav_donations" to "Patrons",
        "nav_config" to "Configuration",
        "nav_profile" to "Profile",
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
        "station_cta" to "Join Us",

        // Recent rescued pets
        "recent_pets_title" to "Recently Rescued Animals",
        "recent_pets_subtitle" to "The newest pets that need your attention.",
        "recent_pets_view_detail" to "View Details →",

        // Config page
        "config_title" to "Homepage Configuration",
        "config_homepage_title" to "Main Title",
        "config_homepage_subtitle" to "Introduction Content",
        "config_homepage_video_url" to "Embedded Video URL (YouTube Embed)",
        "config_save" to "Save Changes",
        "config_saved" to "Configuration saved successfully!",
        "config_video_url_error" to "Invalid video URL. Only YouTube embed URLs are accepted (https://www.youtube.com/embed/...)",

        // Profile page
        "profile_title" to "My Profile",
        "profile_fullname" to "Full Name",
        "profile_email" to "Email",
        "profile_phone" to "Phone Number",
        "profile_save" to "Save Changes",
        "profile_saved" to "Profile updated successfully!",
        "profile_email_taken" to "This email is already used by another account.",

        // User roles
        "role_user" to "User",
        "role_volunteer" to "Volunteer",
        "role_admin" to "Administrator",

        // User active status
        "status_active" to "Active",
        "status_inactive" to "Inactive",

        // Pet types
        "pet_type_all" to "All Types",
        "pet_type_dog" to "🐕 Dog",
        "pet_type_cat" to "🐈 Cat",
        "pet_type_other" to "🐾 Other",

        // Pet statuses
        "pet_status_all" to "All Status",
        "pet_status_available" to "Available",
        "pet_status_adopted" to "Adopted",
        "pet_status_rescued" to "Rescued",

        // Pet genders
        "pet_gender_unknown" to "Unknown",
        "pet_gender_male" to "Male",
        "pet_gender_female" to "Female",

        // Rescue statuses
        "rescue_status_reported" to "Reported",
        "rescue_status_in_progress" to "In Progress",
        "rescue_status_rescued" to "Rescued",
        "rescue_status_failed" to "Failed",

        // Finance types
        "finance_type_income" to "Income",
        "finance_type_expense" to "Expense",

        // Adoption statuses
        "adoption_status_requested" to "Requested",
        "adoption_status_approved" to "Approved",
        "adoption_status_cancelled" to "Cancelled",

        // Common buttons
        "btn_save" to "Save",
        "btn_cancel" to "Cancel",
        "btn_delete" to "Delete",
        "btn_edit" to "Edit",
        "btn_update" to "Update",
        "btn_approve" to "Approve",
        "btn_confirm" to "Confirm",
        "btn_add_entry" to "+ Add Entry",
        "btn_view" to "View",
        "btn_adopt" to "Adopt",
        "confirm_delete" to "Are you sure you want to delete?",
        "blog_views" to "views",

        // Pet form
        "pet_form_add" to "Add Pet",
        "pet_form_edit" to "Edit Pet",
        "pet_field_name" to "Name",
        "pet_field_type" to "Type",
        "pet_field_status" to "Status",
        "pet_field_breed" to "Breed",
        "pet_field_age" to "Age (years)",
        "pet_field_gender" to "Gender",
        "pet_field_description" to "Description",
        "pet_field_photos" to "Photos",
        "pet_search_placeholder" to "Search by name...",
        "pet_add_btn" to "+ Add Pet",
        "pet_back" to "← Back to List",
        "pet_detail_type" to "Type:",
        "pet_detail_breed" to "Breed:",
        "pet_detail_age" to "Age:",
        "pet_detail_gender" to "Gender:",
        "pet_request_adoption" to "🏠 Request Adoption",
        "pet_empty" to "No pets found.",
        "pet_delete_confirm" to "Delete this pet?",
        "pet_detail_about" to "About",

        // Blog
        "blog_form_new" to "New Post",
        "blog_form_edit" to "Edit Post",
        "blog_field_title" to "Title",
        "blog_field_content" to "Content",
        "blog_field_tags" to "Tags",
        "blog_field_publish" to "Publish immediately",
        "blog_back" to "← Back to Blog",
        "blog_add_btn" to "+ New Post",
        "blog_read_more" to "Read more →",
        "blog_draft" to "Draft",
        "blog_empty" to "No blog posts yet.",
        "blog_delete_confirm" to "Delete this post?",

        // Rescues
        "rescue_form_title" to "🚨 Report Animal Rescue",
        "rescue_field_location" to "Location",
        "rescue_field_location_placeholder" to "Address or landmark",
        "rescue_field_description" to "Description",
        "rescue_field_description_placeholder" to "Describe the animal and situation...",
        "rescue_field_contact" to "Contact Info",
        "rescue_field_contact_placeholder" to "Phone or other contact",
        "rescue_submit" to "Submit Report",
        "rescue_add_btn" to "+ Report Rescue",
        "rescue_contact_label" to "Contact:",
        "rescue_empty" to "No rescue reports found.",
        "rescue_delete_confirm" to "Delete this rescue report?",
        "rescue_page_title" to "🚨 Rescue Reports",

        // Adoptions
        "adoption_form_title" to "Request Adoption",
        "adoption_pet_label" to "Pet:",
        "adoption_field_phone" to "Phone Number",
        "adoption_field_facebook" to "Facebook Link",
        "adoption_field_notes" to "Notes",
        "adoption_field_notes_placeholder" to "Tell us about yourself and why you want to adopt...",
        "adoption_submit" to "Submit Request",
        "adoption_col_pet_id" to "Pet ID",
        "adoption_col_phone" to "Phone",
        "adoption_col_facebook" to "Facebook",
        "adoption_col_status" to "Status",
        "adoption_col_date" to "Date",
        "adoption_col_actions" to "Actions",
        "adoption_empty" to "No adoptions found.",
        "adoption_page_title" to "🏠 Adoptions",

        // Donate form
        "donate_title" to "💚 Make a Donation",
        "donate_subtitle" to "Your support helps us rescue and care for animals in need.",
        "donate_success_title" to "💚 Thank you for your donation!",
        "donate_success_text" to "Your contribution has been recorded. We will confirm it shortly.",
        "donate_return_home" to "Return to Home",
        "donate_field_name" to "Your Name",
        "donate_field_email" to "Email",
        "donate_field_amount" to "Amount (USD)",
        "donate_field_message" to "Message (optional)",
        "donate_field_message_placeholder" to "Send your encouragement to the volunteers...",
        "donate_btn" to "💚 Donate Now",
        "donate_btn_send" to "💌 Send Wishes",
        "donate_wish_sent" to "Your wishes have been sent! Thank you 💚",
        "donate_wish_title" to "Send Wishes",
        "donate_wish_subtitle" to "Send your encouragement to the rescue station",
        "donate_field_name_placeholder" to "Your name",
        "donate_field_message" to "Message",
        "donate_qr1_title" to "Support the Station",
        "donate_qr1_subtitle" to "Scan to transfer and support the rescue station",
        "donate_qr2_title" to "Support the Website",
        "donate_qr2_subtitle" to "Scan to transfer and help maintain the website",

        // Donate list
        "donate_page_title" to "📋 Donations",
        "donate_total" to "Total Confirmed:",
        "donate_col_donor" to "Donor",
        "donate_col_email" to "Email",
        "donate_col_amount" to "Amount",
        "donate_col_message" to "Message",
        "donate_col_status" to "Status",
        "donate_col_date" to "Date",
        "donate_col_actions" to "Actions",
        "donate_empty" to "No donations yet.",

        // Users
        "user_form_add" to "New User",
        "user_form_edit" to "Edit User",
        "user_field_username" to "Username",
        "user_field_password" to "Password",
        "user_field_fullname" to "Full Name",
        "user_field_email" to "Email",
        "user_field_phone" to "Phone",
        "user_field_role" to "Role",
        "user_field_active" to "Active",
        "user_add_btn" to "+ New User",
        "user_col_name" to "Name",
        "user_col_username" to "Username",
        "user_col_email" to "Email",
        "user_col_role" to "Role",
        "user_col_status" to "Status",
        "user_col_actions" to "Actions",
        "user_delete_confirm" to "Delete this user?",
        "user_page_title" to "👥 Users",

        // Finance
        "finance_form_title" to "Add Finance Entry",
        "finance_field_type" to "Type",
        "finance_field_amount" to "Amount",
        "finance_field_description" to "Description",
        "finance_field_category" to "Category",
        "finance_field_category_placeholder" to "e.g., Food, Vet, Donation",
        "finance_field_date" to "Date",
        "finance_total_income" to "Total Income",
        "finance_total_expense" to "Total Expense",
        "finance_balance" to "Balance",
        "finance_overview" to "30-Day Overview",
        "finance_col_date" to "Date",
        "finance_col_type" to "Type",
        "finance_col_amount" to "Amount",
        "finance_col_category" to "Category",
        "finance_col_description" to "Description",
        "finance_col_actions" to "Actions",
        "finance_delete_confirm" to "Delete this entry?",
        "finance_page_title" to "💰 Finance Dashboard",
        "finance_add_btn" to "+ Add Entry",

        // Auth
        "auth_login_title" to "🌿 Login",
        "auth_field_username" to "Username",
        "auth_field_password" to "Password",
        "auth_btn_login" to "Login",
        "auth_no_account" to "Don't have an account?",
        "auth_register_link" to "Register",
        "auth_register_title" to "🌿 Register",
        "auth_field_fullname" to "Full Name",
        "auth_field_email" to "Email",
        "auth_field_phone" to "Phone Number",
        "auth_btn_register" to "Register",
        "auth_have_account" to "Already have an account?",
        "auth_login_link" to "Login",

        // Bilingual homepage config
        "config_homepage_title_vi" to "Vietnamese Title",
        "config_homepage_title_en" to "English Title",
        "config_homepage_subtitle_vi" to "Vietnamese Description",
        "config_homepage_subtitle_en" to "English Description",
        "config_homepage_title_vi_hint" to "Main title displayed at the top of the homepage (Vietnamese).",
        "config_homepage_title_en_hint" to "Main title displayed at the top of the homepage (English).",
        "config_homepage_subtitle_vi_hint" to "Short description displayed below the title (Vietnamese).",
        "config_homepage_subtitle_en_hint" to "Short description displayed below the title (English)."
    )

    fun forLang(lang: String): Map<String, String> = if (lang == "en") en else vi
}

fun io.ktor.server.application.ApplicationCall.lang(): String =
    request.cookies["lang"] ?: "vi"

fun io.ktor.server.application.ApplicationCall.messages(): Map<String, String> =
    Messages.forLang(lang())
