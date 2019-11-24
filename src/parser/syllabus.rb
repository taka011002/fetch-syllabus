require_relative 'Parser'

class Parser::Syllabus < Parser
  attr_accessor :syllabus

  def fetch
    super(syllabus.url)
  end

  def parse
    syllabus.timetable_code = doc.xpath('//*[@id="ctl00_phContents_sylSummary_txtLctCd_lbl"]').text
    syllabus.numbering = doc.xpath('//*[@id="ctl00_phContents_sylSummary_txtNumbering_lbl"]').text
    syllabus.subject_area = doc.xpath('//*[@id="ctl00_phContents_sylSummary_txtSbjArea_lbl"]').text
    syllabus.teacher = doc.xpath('//*[@id="ctl00_phContents_sylSummary_txtStaffName_link_lbl"]').text
    syllabus.target_year = doc.xpath('//*[@id="ctl00_phContents_sylSummary_txtPeriod_lbl"]').text
    syllabus.target_course = doc.xpath('//*[@id="ctl00_phContents_sylSummary_txtTermName_lbl"]').text
    syllabus.time = doc.xpath('//*[@id="ctl00_phContents_sylSummary_txtDayPeriod_lbl"]').text
    syllabus.credits = doc.xpath('//*[@id="ctl00_phContents_sylSummary_txtCredits_lbl"]').text
    syllabus.title = doc.xpath('//*[@id="ctl00_phContents_ucSylContents_cateTitle_lblNormal"]').text
    syllabus.course_overview = doc.xpath('//*[@id="ctl00_phContents_ucSylContents_cateOutLine_lblNormal"]').text
    syllabus.keyword = doc.xpath('//*[@id="ctl00_phContents_ucSylContents_cateKeyWord_lblNormal"]').text
    syllabus.learning_objectives = doc.xpath('//*[@id="ctl00_phContents_ucSylContents_cateTarget_lblNormal"]').text
    syllabus.weekly_syllabus = doc.xpath('//*[@id="ctl00_phContents_ucSylContents_catePlan_lblNormal"]').text
    syllabus.outside_of_class = doc.xpath('//*[@id="ctl00_phContents_ucSylContents_cateOurSideInfo_lblNormal"]').text
    syllabus.notes = doc.xpath('//*[@id="ctl00_phContents_ucSylContents_CateNotes_lblNormal"]').text
  end
end