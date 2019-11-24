require_relative 'repository'

class Repository::Syllabus < Repository
  attr_accessor :title,
                :link_title,
                :course_overview,
                :keyword,
                :learning_objectives,
                :weekly_syllabus,
                :outside_of_class,
                :notes,
                :target_course,
                :target_year,
                :timetable_code,
                :numbering,
                :subject_area,
                :teacher,
                :time,
                :credits
end