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

    it 'returns true if the instructor is assigned to the course of the assignment' do
      instructor1 = build(:instructor, id: 20)
      instructor1.save!

      course = build(:course, id: 40, instructor_id: 20)
      course.save!

      assignment = build(:assignment, id: 1, course_id: 40)
      assignment.save!

      stub_current_user(instructor1, instructor1.role.name, instructor1.role)
      expect(current_user_teaching_staff_of_assignment?(assignment.id)).to be true
    end

    it 'returns false if the instructor is not assigned to the course of the assignment' do
      instructor1 = build(:instructor, name: "Lucy", id: 27)
      instructor1.save!

      instructor2 = build(:instructor, name: "Jeb", id: 20)
      instructor2.save!

      course = build(:course, id: 41, instructor_id: 20)
      course.save!

      assignment = build(:assignment, id: 1, course_id: 41)
      assignment.save!

      stub_current_user(instructor1, instructor1.role.name, instructor1.role)
      expect(current_user_teaching_staff_of_assignment?(assignment.id)).to be false
    end

    it 'returns true if the instructor is associated with the assignment' do
      instructor1 = build(:instructor, name: "Lucy", id: 27)
      instructor1.save!

      assignment = build(:assignment, id: 1, instructor_id: 27)
      assignment.save!

      stub_current_user(instructor1, instructor1.role.name, instructor1.role)
      expect(current_user_teaching_staff_of_assignment?(assignment.id)).to be true
    end

    it 'returns false if the instructor is not associated with the assignment' do
      instructor1 = build(:instructor, name: "Lucy", id: 13)
      instructor1.save!

      instructor2 = build(:instructor, name: "Jeb", id: 27)
      instructor2.save!

      assignment = build(:assignment, id: 1, instructor_id: 27)
      assignment.save!

      stub_current_user(instructor1, instructor1.role.name, instructor1.role)
      expect(current_user_teaching_staff_of_assignment?(assignment.id)).to be false
    end

    it 'returns true if the teaching assistant is associated with the course of the assignment' do
      teaching_assistant1 = build(:teaching_assistant, id: 13, name: "Lillian")
      teaching_assistant1.save!

      course = build(:course, id: 41)
      course.save!

      assignment = build(:assignment, id: 1 )
      assignment.save!

      ta_mapping = TaMapping.new(ta_id: 13, course_id: 41)
      ta_mapping.save!

      stub_current_user(teaching_assistant1, teaching_assistant1.role.name, teaching_assistant1.role)
      expect(current_user_teaching_staff_of_assignment?(assignment.id)).to be true
    end

    it 'returns false if the teaching assistant is not associated with the course of the assignment' do
      instructor1 = build(:instructor, name: "Lucy", id: 33)
      instructor1.save!

      teaching_assistant1 = build(:teaching_assistant, id: 13, name: "Lillian")
      teaching_assistant1.save!

      assignment = build(:assignment, id: 1, instructor_id: 33)
      assignment.save!

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

end
