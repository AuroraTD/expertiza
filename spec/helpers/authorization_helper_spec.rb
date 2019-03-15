describe AuthorizationHelper do

  # E1915 TODO each and every method defined in app/helpers/authorization_helper.rb should be thoroughly tested here

  # Set up some dummy users
  # Inspired by spec/controllers/users_controller_spec.rb
  # Makes use of spec/factories/factories.rb
  # Use create instead of build so that these users get IDs
  # https://stackoverflow.com/questions/41149787/how-do-i-create-an-user-id-for-a-factorygirl-build
  let(:student) { create(:student) }
  let(:teaching_assistant) { create(:teaching_assistant) }
  let(:instructor) { create(:instructor) }
  let(:admin) { create(:admin) }
  let(:superadmin) { create(:superadmin) }
  let(:assignment_team) {create(:assignment_team)}

  # The global before(:each) in spec/spec_helper.rb establishes roles before each test runs

  # TESTS

  # HAS PRIVILEGES (Super Admin --> Admin --> Instructor --> TA --> Student)

  describe ".current_user_has_super_admin_privileges?" do

    it 'returns false if there is no current user' do
      expect(current_user_has_super_admin_privileges?).to be false
    end

    it 'returns false for a student' do
      stub_current_user(student, student.role.name, student.role)
      expect(current_user_has_super_admin_privileges?).to be false
    end

    it 'returns false for a TA' do
      stub_current_user(teaching_assistant, teaching_assistant.role.name, teaching_assistant.role)
      expect(current_user_has_super_admin_privileges?).to be false
    end

    it 'returns false for an instructor' do
      stub_current_user(instructor, instructor.role.name, instructor.role)
      expect(current_user_has_super_admin_privileges?).to be false
    end

    it 'returns false for an admin' do
      stub_current_user(admin, admin.role.name, admin.role)
      expect(current_user_has_super_admin_privileges?).to be false
    end

    it 'returns true for a super admin' do
      stub_current_user(superadmin, superadmin.role.name, superadmin.role)
      expect(current_user_has_super_admin_privileges?).to be true
    end

  end

  describe ".current_user_has_admin_privileges?" do

    it 'returns false if there is no current user' do
      expect(current_user_has_admin_privileges?).to be false
    end

    it 'returns false for a student' do
      stub_current_user(student, student.role.name, student.role)
      expect(current_user_has_admin_privileges?).to be false
    end

    it 'returns false for a TA' do
      stub_current_user(teaching_assistant, teaching_assistant.role.name, teaching_assistant.role)
      expect(current_user_has_admin_privileges?).to be false
    end

    it 'returns false for an instructor' do
      stub_current_user(instructor, instructor.role.name, instructor.role)
      expect(current_user_has_admin_privileges?).to be false
    end

    it 'returns true for an admin' do
      stub_current_user(admin, admin.role.name, admin.role)
      expect(current_user_has_admin_privileges?).to be true
    end

    it 'returns true for a super admin' do
      stub_current_user(superadmin, superadmin.role.name, superadmin.role)
      expect(current_user_has_admin_privileges?).to be true
    end

  end

  describe ".current_user_has_instructor_privileges?" do

    it 'returns false if there is no current user' do
      expect(current_user_has_instructor_privileges?).to be false
    end

    it 'returns false for a student' do
      stub_current_user(student, student.role.name, student.role)
      expect(current_user_has_instructor_privileges?).to be false
    end

    it 'returns false for a TA' do
      stub_current_user(teaching_assistant, teaching_assistant.role.name, teaching_assistant.role)
      expect(current_user_has_instructor_privileges?).to be false
    end

    it 'returns true for an instructor' do
      stub_current_user(instructor, instructor.role.name, instructor.role)
      expect(current_user_has_instructor_privileges?).to be true
    end

    it 'returns true for an admin' do
      stub_current_user(admin, admin.role.name, admin.role)
      expect(current_user_has_instructor_privileges?).to be true
    end

    it 'returns true for a super admin' do
      stub_current_user(superadmin, superadmin.role.name, superadmin.role)
      expect(current_user_has_instructor_privileges?).to be true
    end

  end

  describe ".current_user_has_ta_privileges?" do

    it 'returns false if there is no current user' do
      expect(current_user_has_ta_privileges?).to be false
    end

    it 'returns false for a student' do
      stub_current_user(student, student.role.name, student.role)
      expect(current_user_has_ta_privileges?).to be false
    end

    it 'returns true for a TA' do
      stub_current_user(teaching_assistant, teaching_assistant.role.name, teaching_assistant.role)
      expect(current_user_has_ta_privileges?).to be true
    end

    it 'returns true for an instructor' do
      stub_current_user(instructor, instructor.role.name, instructor.role)
      expect(current_user_has_ta_privileges?).to be true
    end

    it 'returns true for an admin' do
      stub_current_user(admin, admin.role.name, admin.role)
      expect(current_user_has_ta_privileges?).to be true
    end

    it 'returns true for a super admin' do
      stub_current_user(superadmin, superadmin.role.name, superadmin.role)
      expect(current_user_has_ta_privileges?).to be true
    end

  end

  describe ".current_user_has_student_privileges?" do

    it 'returns false if there is no current user' do
      expect(current_user_has_student_privileges?).to be false
    end

    it 'returns true for a student' do
      stub_current_user(student, student.role.name, student.role)
      expect(current_user_has_student_privileges?).to be true
    end

    it 'returns true for a TA' do
      stub_current_user(teaching_assistant, teaching_assistant.role.name, teaching_assistant.role)
      expect(current_user_has_student_privileges?).to be true
    end

    it 'returns true for an instructor' do
      stub_current_user(instructor, instructor.role.name, instructor.role)
      expect(current_user_has_student_privileges?).to be true
    end

    it 'returns true for an admin' do
      stub_current_user(admin, admin.role.name, admin.role)
      expect(current_user_has_student_privileges?).to be true
    end

    it 'returns true for a super admin' do
      stub_current_user(superadmin, superadmin.role.name, superadmin.role)
      expect(current_user_has_student_privileges?).to be true
    end

  end

  describe ".teaching_staff_of_assignment?" do

    # Rather than specifying IDs explicitly for instructor, TA, course, etc.
    # Use factory create method to auto generate IDs.
    # In this way we have less risk of making a mistake (e.g. duplication) in the ID numbers.

    it 'returns true if the instructor is assigned to the course of the assignment' do

      # To be on the safe side (avoid passing this test when there might be some problem)
      # Create 2 instructors and associate the 2nd one with the assignment
      # See comments in other tests of this method
      # Briefly: There is some implicit automatic association to 1st instructor via factory

      instructor1 = create(:instructor)
      instructor2 = create(:instructor)
      course = create(:course, instructor_id: instructor2.id)
      assignment = create(:assignment, course_id: course.id)
      stub_current_user(instructor2, instructor2.role.name, instructor2.role)

      expect(current_user_teaching_staff_of_assignment?(assignment.id)).to be true

    end

    it 'returns false if the instructor is not assigned to the course of the assignment' do

      # This test requires some extra care
      # The assignment factory will associate the created assignment with the first course
      # (or will create a course if needed)
      # The assignment factory in will ALSO associate the assignment with the first instructor
      # (or will create an instructor if needed)
      # Therefore, with no extra care, the assignment will end up associated with the first instructor
      # Therefore, we must take care that we specify both the course and the instructor for the assignment

      instructor1 = create(:instructor)
      instructor2 = create(:instructor)
      course = create(:course, instructor_id: instructor2.id)
      assignment = create(:assignment, course_id: course.id, instructor_id: instructor2.id)
      stub_current_user(instructor1, instructor1.role.name, instructor1.role)

      expect(current_user_teaching_staff_of_assignment?(assignment.id)).to be false

    end

    it 'returns true if the instructor is associated with the assignment' do

      # To be on the safe side (avoid passing this test when there might be some problem)
      # Create 2 instructors and associate the 2nd one with the assignment
      # See comments in other tests of this method
      # Briefly: There is some implicit automatic association to 1st instructor via factory

      instructor1 = create(:instructor)
      instructor2 = create(:instructor)
      assignment = create(:assignment, instructor_id: instructor2.id)
      stub_current_user(instructor2, instructor2.role.name, instructor2.role)

      expect(current_user_teaching_staff_of_assignment?(assignment.id)).to be true

    end

    it 'returns false if the instructor is not associated with the assignment' do

      # This test requires some extra care
      # The assignment factory will associate the created assignment with the first course
      # (or will create a course if needed)
      # The course factory in turn will associate the course with the first instructor
      # (or will create an instructor if needed)
      # Therefore, with no extra care, the assignment will end up associated indirectly with the first instructor
      # Therefore, we must take care that the current user we stub here is NOT the first instructor

      instructor1 = create(:instructor)
      instructor2 = create(:instructor)
      assignment = create(:assignment, instructor_id: instructor1.id)
      stub_current_user(instructor2, instructor2.role.name, instructor2.role)

      expect(current_user_teaching_staff_of_assignment?(assignment.id)).to be false

    end

    it 'returns true if the teaching assistant is associated with the course of the assignment' do

      teaching_assistant1 = create(:teaching_assistant)
      course = create(:course)
      assignment = create(:assignment)
      ta_mapping = TaMapping.new(ta_id: teaching_assistant1.id, course_id: course.id)
      stub_current_user(teaching_assistant1, teaching_assistant1.role.name, teaching_assistant1.role)

      expect(current_user_teaching_staff_of_assignment?(assignment.id)).to be true

    end

    it 'returns false if the teaching assistant is not associated with the course of the assignment' do

      instructor1 = create(:instructor)
      teaching_assistant1 = create(:teaching_assistant)
      assignment = create(:assignment, instructor_id: instructor1.id)
      stub_current_user(teaching_assistant1, teaching_assistant1.role.name, teaching_assistant1.role)

      expect(current_user_teaching_staff_of_assignment?(assignment.id)).to be false

    end

  end

  # OTHER HELPER METHODS

  describe ".current_user_is_assignment_participant?" do
    # Makes use of existing :assignment_team and :participant factories
    # Both factories point to Assignment.first

    it 'returns false if there is no current user' do
      create(:participant, user: session[:user])
      expect(current_user_is_assignment_participant?(assignment_team.id)).to be false
    end

    it 'returns false if an erroneous id is passed in' do
      stub_current_user(student, student.role.name, student.role)
      create(:participant, user: session[:user])
      expect(current_user_is_assignment_participant?(-1)).to be false
    end

    it 'returns false if the current user does not participate in the assignment' do
      stub_current_user(student, student.role.name, student.role)
      expect(current_user_is_assignment_participant?(assignment_team.id)).to be false
    end

    it 'returns true if current user is a student and participates in assignment' do
      stub_current_user(student, student.role.name, student.role)
      create(:participant, user: session[:user])
      expect(current_user_is_assignment_participant?(assignment_team.id)).to be true
    end

    it 'returns true if current user is a TA and participates in assignment' do
      stub_current_user(teaching_assistant, teaching_assistant.role.name, teaching_assistant.role)
      create(:participant, user: session[:user])
      expect(current_user_is_assignment_participant?(assignment_team.id)).to be true
    end

    it 'returns true if current user is an instructor and participates in assignment' do
      stub_current_user(instructor, instructor.role.name, instructor.role)
      create(:participant, user: session[:user])
      expect(current_user_is_assignment_participant?(assignment_team.id)).to be true
    end

    it 'returns true if current user is an admin and participates in assignment' do
      stub_current_user(admin, admin.role.name, admin.role)
      create(:participant, user: session[:user])
      expect(current_user_is_assignment_participant?(assignment_team.id)).to be true
    end

    it 'returns true if current user is a super-admin and participates in assignment' do
      stub_current_user(superadmin, superadmin.role.name, superadmin.role)
      create(:participant, user: session[:user])
      expect(current_user_is_assignment_participant?(assignment_team.id)).to be true
    end

  end

  describe ".current_user_created_bookmark_id?" do

    it 'returns false if there is no current user' do
      create(:bookmark, user: student)
      expect(current_user_created_bookmark_id?(Bookmark.first.id)).to be false
    end

    it 'returns false if there is no bookmark' do
      stub_current_user(student, student.role.name, student.role)
      expect(current_user_created_bookmark_id?(12345678)).to be false
    end

    it 'returns false if the current user did not create the bookmark' do
      stub_current_user(student, student.role.name, student.role)
      create(:bookmark, user: teaching_assistant)
      expect(current_user_created_bookmark_id?(Bookmark.first.id)).to be false
    end

    it 'returns true if the current user did create the bookmark' do
      stub_current_user(student, student.role.name, student.role)
      create(:bookmark, user: student)
      expect(current_user_created_bookmark_id?(Bookmark.first.id)).to be true
    end

  end

  describe ".current_user_is_a?" do

    it 'returns false if there is no current user' do
      expect(current_user_is_a? 'Student').to be false
    end

    it 'returns false if there is a current user no role' do
      random_user = build(:teaching_assistant, role_id: nil)
      session[:user] = random_user
      expect(current_user_is_a? 'Teaching Assistant').to be false
    end

    it 'returns false if an erroneous role is passed in' do
      expect(current_user_is_a? 'Random Role').to be false
    end

    it 'returns true if current user and parameter are both Student' do
      stub_current_user(student, student.role.name, student.role)
      expect(current_user_is_a? 'Student').to be true
    end

    it 'returns true if current user and parameter are both Teaching Assistant' do
      stub_current_user(teaching_assistant, teaching_assistant.role.name, teaching_assistant.role)
      expect(current_user_is_a? 'Teaching Assistant').to be true
    end

    it 'returns true if current user and parameter are both Instructor' do
      stub_current_user(instructor, instructor.role.name, instructor.role)
      expect(current_user_is_a? 'Instructor').to be true
    end

    it 'returns true if current user and parameter are both Administrator' do
      stub_current_user(admin, admin.role.name, admin.role)
      expect(current_user_is_a? 'Administrator').to be true
    end

    it 'returns true if current user and parameter are both Super-Administrator' do
      stub_current_user(superadmin, superadmin.role.name, superadmin.role)
      expect(current_user_is_a? 'Super-Administrator').to be true
    end

  end

  describe ".current_user_has_id?" do

    it 'returns false if there is no current user' do
      expect(current_user_has_id? -1).to be false
    end

    it 'returns false if current user exists but an erroneous id is passed in' do
      stub_current_user(admin, admin.role.name, admin.role)
      expect(current_user_has_id? -1).to be false
    end

    it 'returns false if passed in id does not match current user id' do
      stub_current_user(student, student.role.name, student.role)
      expect(current_user_has_id? student.id + 1).to be false
    end

    it 'returns true if passed in id matches the current user id' do
      stub_current_user(instructor, instructor.role.name, instructor.role)
      expect(current_user_has_id? instructor.id).to be true
    end

    it 'returns true if passed in id is the string version of current user id' do
      stub_current_user(instructor, instructor.role.name, instructor.role)
      expect(current_user_has_id? instructor.id.to_s).to be true
    end

  end

end
