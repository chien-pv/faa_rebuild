namespace :db do
  desc "Seeding course ruby"
  task course_ruby: :environment do
    Course.create! name: "Lập trình Ruby",
      description: "Tự hào là đơn vị đứng thứ 11 trong bản đồ xếp hạng các " \
      "công ty phát triển mạnh về ngôn ngữ Ruby trên thế giới, với .... " \
      "chuyên gia về Ruby có chứng chỉ Ruby Silver được cấp bởi Ruby Association, " \
      "Framgia Viet Nam đang ngày càng khẳng định được vị thế của mình trong cộng đồng Ruby " \
      "tại Việt Nam nói riêng và quốc tế nói chung. Đến với khóa học này, " \
      "các học viên sẽ được chính những chuyên gia về lập trình Ruby với hơn 05 kinh nghiệm, " \
      "đã nhận được chứng chỉ coach Agile của tổ chức IC Agile trực tiếp giảng dạy " \
      "và chia sẻ những bài học bổ ích và thú vị",
      cost: 10730000,
      technique: "Ruby",
      content: "#### Nội dung khóa học\n" \
        "* Lập trình hướng đối tượng với Ruby\n" \
        "* Tổng quan và thực hành về GIT\n" \
        "* Xây dựng website với framework Ruby on Rails\n" \
        "* Lập trình nâng cao với Ruby on Rails trong hai dự án thực tế. \n\n" \
        "#### Bạn sẽ làm được gì sau khóa học này?\n" \
        "* Nắm vững lập trình hướng đối tượng với ngôn ngữ Ruby. \n" \
        "* Thành thao lập trình framework Ruby on Rails thông qua dự án thực tế (OJT)\n" \
        "* Hiểu rõ và triển khai hệ thống web theo mô hình MVC\n" \
        "* Tối ưu ứng dụng, cải thiện performance dự án sử dụng caching, background job, cronjob\n" \
        "* Áp dụng và hiểu các thư viện phổ biến giúp đẩy nhanh quá trình phát triển bằng Ruby on Rails.\n" \
        "* Thực hành cơ bản về CSS, HTML, Javascript, Twitter Bootstrap\n" \
        "* Lập trình web service RESTfull\n" \
        "* Tự tin với các kiến thức đã được giảng dạy để sẵn sàng vượt qua kì" \
        "thi nhận chứng chỉ Ruby Silver được cấp bởi Ruby Association  \n\n" \
        "#### Học phí khóa học Ruby tại Framgia Awesome Academy ? \n" \
        "Chỉ với 10.730.000 (VNĐ) cho một khóa học Ruby tại Framgia Awsome Academy," \
        "đồng nghĩa với việc bạn đã cùng lúc hoàn thành những khóa học khác nhau, bao gồm: \n\n" \
        "* Chứng nhận Agile Fundametals được cấp bởi tổ chức quốc tế ICAgile. (tương đương một khóa học 4.000.000 VNĐ) \n" \
        "* Hoàn thiện các kỹ năng mềm cần có cho một lập trình viên" \
        "(tương đương một khóa đào tạo các kỹ năng mềm: Problem Solving, Brainstorming, Professionalism có giá trị 2.500.000 VNĐ )\n\n" \
        "#### Khóa học sẽ diễn ra trong bao lâu? \n" \
        "Tổng thời gian đào tạo: 06 tháng. \n" \
        "Một tuần 03 buổi, mỗi buổi 3 tiếng. \n\n" \
        "* Ca 1: 08:30 ~ 11:30;\n" \
        "* Ca 2: 14:00 ~ 17:00;\n" \
        "* Ca 3: 18:00 – 21:00;\n\n" \
        "Thời gian học tập linh hoạt, phù hợp với từng đối tượng học\n\n" \
        "#### Ai có thể  tham gia khóa học? \n" \
        "Sinh viên đang theo học ngành Công nghệ thông tin (từ năm 2 trở lên)," \
        "hoặc người đã và đang làm việc trong lĩnh vực công nghệ thông tin có quan tâm " \
        "và mong muốn học thêm ngôn ngữ lập trình mới. "
  end
end
