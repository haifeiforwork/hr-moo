package com.moorim.hr.client.controller;

import java.net.URI;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;

import com.moorim.hr.client.service.JobService;
import com.moorim.hr.client.vo.RecruitCareerVO;
import com.moorim.hr.client.vo.RecruitCertVO;
import com.moorim.hr.client.vo.RecruitGradeVO;
import com.moorim.hr.client.vo.RecruitIntroVO;
import com.moorim.hr.client.vo.RecruitLanguageVO;
import com.moorim.hr.client.vo.RecruitNoticeOptionVO;
import com.moorim.hr.client.vo.RecruitSchoolVO;
import com.moorim.hr.client.vo.RecruitTrainingVO;
import com.moorim.hr.client.vo.RecruitVO;
import com.moorim.hr.common.AESCrypt;
import com.moorim.hr.common.CheckNull;
import com.moorim.hr.common.FileUtil;
import com.moorim.hr.common.TextUtil;
import com.moorim.hr.common.service.ComCodeService;
import com.moorim.hr.common.service.EmailSendService;
import com.moorim.hr.common.vo.EmailVO;
import com.moorim.hr.common.vo.PagingCommonVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import net.sf.json.JSONArray;

@Controller
@RequestMapping(value="/client/job")
public class JobController {

	private static Logger log = LoggerFactory.getLogger(JobController.class);

	@Autowired
	ComCodeService comCodeService;

	@Autowired
	private EmailSendService emailService;

	@Autowired
	private JobService jobService;

	@RequestMapping(value="/jobNotice")
	public String notice(	ModelMap model
							, @ModelAttribute("pCommon") PagingCommonVO vo
							, HttpServletRequest request) throws Exception {

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageNo());
		paginationInfo.setRecordCountPerPage(vo.getRows());
		paginationInfo.setPageSize(vo.getPageSize());

		int firstRecordIndex = paginationInfo.getFirstRecordIndex()+1;
		int lastRecordIndex = paginationInfo.getLastRecordIndex();
		vo.setFirstIndex(firstRecordIndex);
		vo.setLastIndex(lastRecordIndex);

		// 최상위 노출 리스트
		List<Map> topRsList = jobService.listTopJob(vo);

		int cnt = jobService.cntJob(vo);
		List<Map> rsList = jobService.listJob(vo);

		// 채용구분 공통코드
		List<Map> recGubunList = comCodeService.getCodeByGroup("40");

		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("topRsList", topRsList);
		model.addAttribute("rsList", rsList);
		model.addAttribute("recGubunList", recGubunList);

		return "/client/job/jobNotice";

	}

	@RequestMapping(value="/jobDetail")
	public String detail(	ModelMap model
							, @ModelAttribute("pCommon") PagingCommonVO vo
							, HttpServletRequest request) throws Exception {

		jobService.updateHit(vo);

		Map rs = jobService.detailJob(vo);
		Vector realFileName = new Vector();
		Vector systemFileName = new Vector();

		if(rs != null){
			String realFile = (String)rs.get("R_REAL_FILE");
			String sysFile = (String)rs.get("R_SAVE_FILE");
			if(sysFile != null && realFile != null){
				realFileName.addElement(CheckNull.checkString(realFile));
				systemFileName.addElement(CheckNull.checkString(sysFile));
			}
		}

		model.addAttribute("rs", rs);
		model.addAttribute("fileView", TextUtil.getFileDownload(realFileName, systemFileName, null, "job", false) );

		return "/client/job/jobDetail";

	}

	@RequestMapping(value="/reclogin")
	public String login(ModelMap model
						, @ModelAttribute("pCommon") PagingCommonVO vo
						, HttpServletRequest request) throws Exception {

		Map rs = jobService.detailJob(vo);

		model.addAttribute("rs", rs);

		return "/client/job/myReclogin";

	}

	@RequestMapping(value="/recViewLogin")
	public String recViewLogin(	ModelMap model
								, HttpServletRequest request) throws Exception {

		// 공고 list
		List<Map> rsList = jobService.getCurrentNoticeList();

		model.addAttribute("rsList", rsList);

		return "/client/job/myRecViewlogin";

	}

	@RequestMapping(value="/appyCheckLogin")
	public ModelAndView appyCheckLogin(	HttpServletRequest request
										, @ModelAttribute("recruit") RecruitVO vo
										, ModelMap model) throws Exception {

		ModelAndView mav = new ModelAndView();

		// 비밀번호 암호화
		vo.setrPwd(AESCrypt.encrypt(vo.getrPwd()));

		String applyCode = jobService.getApplyCode(vo);

		mav.addObject("applyCode", applyCode);
		mav.setViewName("jsonView");

		return mav;

	}

	@RequestMapping(value="/appyExistCheck")
	public ModelAndView appyExistCheck(	HttpServletRequest request
										, @ModelAttribute("recruit") RecruitVO vo
										, ModelMap model) {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		int regCount = jobService.checkReg(vo);
		mav.addObject("regCount", regCount);

		return mav;

	}

	@RequestMapping(value="/myRecStep01")
	public String step01(	ModelMap model
							, @ModelAttribute("pCommon") PagingCommonVO CommonVo
							, @ModelAttribute("recruit") RecruitVO vo
							, HttpServletRequest request) throws Exception {

		Map rs = new HashMap();

		if(vo.getrApCode() == null || vo.getrApCode().length() < 1) {
			// 비밀번호 암호화
			vo.setrPwd(AESCrypt.encrypt(vo.getrPwd()));

			// 나이계산
			vo.setrAge(TextUtil.getAge(vo.getrBirth()));

			rs.put("R_IDX", vo.getrIdx());
			rs.put("R_NAME", vo.getrName());
			rs.put("R_PWD", vo.getrPwd());
			rs.put("R_GUBUN", vo.getrGubun());
			rs.put("R_BIRTH", vo.getrBirth());
			rs.put("R_AGE", vo.getrAge());

			rs.put("procType", "new");
		} else {
			rs = jobService.getPersonalInfo(vo);

			rs.put("procType", "mod");
		}

		// 보훈 공통코드 조회
		List<Map> bohunCodes = comCodeService.getCodeByGroup("02");

		// 군별 공통코드 조회
		List<Map> armyTypeCodes = comCodeService.getCodeByGroup("06");

		// 계급 공통코드 조회
		List<Map> armyClassCodes = comCodeService.getCodeByGroup("07");

		// 역종 공통코드 조회
		List<Map> armyKindCodes = comCodeService.getCodeByGroup("08");

		// 병과 공통코드 조회
		List<Map> armyBranchCodes = comCodeService.getCodeByGroup("09");

		model.addAttribute("rs", rs);

		model.addAttribute("bohunCodes", bohunCodes);
		model.addAttribute("armyTypeCodes", armyTypeCodes);
		model.addAttribute("armyClassCodes", armyClassCodes);
		model.addAttribute("armyKindCodes", armyKindCodes);
		model.addAttribute("armyBranchCodes", armyBranchCodes);

		return "/client/job/myRecStep01";

	}

	@RequestMapping(value="/getNoticeOptions")
	public ModelAndView getNoticeOptions(	HttpServletRequest request
											, RecruitNoticeOptionVO vo) throws Exception {

		List<Map> optionList = new ArrayList<Map>();
		ModelAndView mav = new ModelAndView("jsonView");

		String result = "success";
		String message = "";

		String depth = vo.getDepth();

		try {

			if(depth.equals("1")) {
				optionList = jobService.getKindOptions(vo);
			} else if(depth.equals("2")) {
				optionList = jobService.getPartOptions(vo);
			} else if(depth.equals("3")) {
				optionList = jobService.getAreaOptions(vo);
			} else {
				result = "fail";
				message = "유효하지 않은 값입니다.";
			}

		} catch (Exception ex) {
			result = "fail";
			message = "서버 에러가 발생하였습니다.";

			if(log.isErrorEnabled()) log.error(ex.getMessage());
		}

		mav.addObject("result", result);
		mav.addObject("message", message);
		mav.addObject("optionList", optionList);
    	mav.setViewName("jsonView");

    	return mav;

	}

	@RequestMapping(value = "/uploadFileReg", method = RequestMethod.POST)
    public ModelAndView uploadPhotoReg(	HttpServletRequest request
    									, @RequestParam("exts") String exts
    									, ModelMap model) throws Exception {

		ModelAndView mav = new ModelAndView("jsonView");

		String filePath = request.getSession().getServletContext().getRealPath("/") + "upload";
        String[] ext = exts.split("[|]");

        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

        Map<String, Object> returnMap = null;
        try{
        	returnMap = FileUtil.setFileMakeToList(multipartHttpServletRequest, filePath, ext);
        }catch(Exception e){
        	returnMap.put("result", "error");

        	if(log.isErrorEnabled()) log.error(e.getMessage());
        	e.printStackTrace();
        }

    	mav.addObject("json", returnMap);
    	mav.setViewName("jsonView");

    	return mav;

    }

	@RequestMapping(value="/getPic", method = RequestMethod.GET)
	public String getPic(	HttpServletRequest request
							, String pic_no) throws Exception {

		String path = request.getSession().getServletContext().getRealPath("/") + "upload/job/" + pic_no;
		request.setAttribute("path", path);

		return "/client/job/photo";

	}

	@RequestMapping(value="/saveApplyMaster", method=RequestMethod.POST)
	public ModelAndView saveApplyMaster(HttpServletRequest request
										, @Valid RecruitVO vo
										, BindingResult bindingResult) throws Exception {

		Map resultMap = new HashMap();
		ModelAndView mav = new ModelAndView("jsonView");

		if(bindingResult.hasErrors()) {
			log.error("saveApplyMaster Binding Result has error!");
			List<ObjectError> errors = bindingResult.getAllErrors();
			for(ObjectError error : errors) {
				log.error("{} : {}", error.getObjectName(), error.getDefaultMessage());
			}

			resultMap.put("errors", errors);
			resultMap.put("result", "fail");
		} else {
			// client IP
			String clientIp = request.getHeader("X-FORWARDED-FOR");
			if (clientIp == null) {
				clientIp = request.getRemoteAddr();
			}
			vo.setrIp(clientIp);

			resultMap = jobService.saveApplyMaster(vo);
		}

		mav.addObject("vo", vo);
		mav.addObject("json", resultMap);
    	mav.setViewName("jsonView");

    	return mav;

	}

	@RequestMapping(value="/myRecStep02")
	public String step02(	HttpServletRequest request
							, ModelMap model
							, @ModelAttribute("recruit") RecruitVO vo) throws Exception {

		List<Map> rsSchoolList = new ArrayList<Map>();
		List<Map> rsGradeList = new ArrayList<Map>();

		Map rsSchool = null;
		Map rsGrade = null;

		// 학력 등록여부 조회
		int regSchoolCount = jobService.checkSchoolReg(vo);
		if(regSchoolCount > 0) {
			rsSchoolList = jobService.getSchoolList(vo);

			int sIdx;
			for(Map rs : rsSchoolList) {
				rsSchool = new HashMap();
				sIdx = (int) rs.get("S_IDX");
				rsSchool = rs;

				model.addAttribute("rsSchool"+sIdx, rsSchool);
			}
		}

		// 성적 등록여부 조회
		int regGradeCount = jobService.checkGradeReg(vo);
		if(regGradeCount > 0) {
			rsGradeList = jobService.getGradeList(vo);

			int sIdx;
			for(Map rs : rsGradeList) {
				rsGrade = new HashMap();
				sIdx = (int) rs.get("S_IDX");
				rsGrade = rs;

				model.addAttribute("rsGrade"+sIdx, rsGrade);
			}
		}

		// 학교유형 공통코드 조회
		List<Map> schoolTypeCodes = comCodeService.getCodeByGroup("19");

		// 주/야구분 공통코드 조회
		List<Map> schoolDnCodes = comCodeService.getCodeByGroup("17");

		// 고등학교 계열 공통코드 조회
		List<Map> hMajorGroupCodes = comCodeService.getCodeByGroup("14");

		// 대학교 계열 공통코드 조회
		List<Map> uMajorGroupCodes = comCodeService.getCodeByGroup("15");

		// 졸업구분 계열 공통코드 조회
		List<Map> gradeTypeCodes = comCodeService.getCodeByGroup("16");

		model.addAttribute("schoolTypeCodes", schoolTypeCodes);
		model.addAttribute("schoolDnCodes", schoolDnCodes);
		model.addAttribute("hMajorGroupCodes", hMajorGroupCodes);
		model.addAttribute("uMajorGroupCodes", uMajorGroupCodes);
		model.addAttribute("gradeTypeCodes", gradeTypeCodes);

		return "/client/job/myRecStep02";

	}

	@RequestMapping(value="/searchSchool", method=RequestMethod.POST)
	public ModelAndView searchSchool(	HttpServletRequest request
										, @RequestParam(value="gubun", required=true) String gubun
										, @RequestParam(value="uType", required=false) String uType
										, @RequestParam(value="searchSchulNm", required=true) String searchSchulNm) throws Exception {

		ModelAndView mav = new ModelAndView("jsonView");

		String baseUrl = "www.career.go.kr";
		String svcKey = "8fb81aaab76514b297c88256e1fc8410";

		RestTemplate restTemplate = new RestTemplate();
		URI uri = UriComponentsBuilder.newInstance()
                .scheme("http")
                .host(baseUrl)
                .path("/cnet/openapi/getOpenApi.json")
                .queryParam("apiKey"   			, URLDecoder.decode(svcKey, "UTF-8"))
                .queryParam("svcType"     	, "api")
                .queryParam("svcCode"      	, "SCHOOL")
                .queryParam("contentType" 	, "json")
                .queryParam("gubun"  		, gubun)
                .queryParam("sch1"  		, uType)
                .queryParam("searchSchulNm" , searchSchulNm)
                .build()
                .encode()
                .toUri();

		String result = restTemplate.getForObject(uri, String.class);
		if(log.isDebugEnabled()) log.debug(result);

		mav.addObject("result", result);

		return mav;

	}

	@RequestMapping(value="/saveApplyEdu", method=RequestMethod.POST)
	public ModelAndView saveApplyEdu(	HttpServletRequest request
										, @Valid RecruitSchoolVO schoolVO
										, @Valid RecruitGradeVO gradeVO
										, BindingResult bindingResult) throws Exception {

		Map resultMap = new HashMap();
		ModelAndView mav = new ModelAndView("jsonView");

		if(bindingResult.hasErrors()) {
			log.error("saveApplyEdu Binding Result has error!");
			List<ObjectError> errors = bindingResult.getAllErrors();
			for(ObjectError error : errors) {
				log.error("{} : {}", error.getObjectName(), error.getDefaultMessage());
			}

			resultMap.put("errors", errors);
			resultMap.put("result", "fail");
		} else {
			// 학격 저장
			boolean isSuccess = jobService.saveApplySchool(schoolVO.getSchoolList());

			if(isSuccess) {
				// 성적 저장
				isSuccess = jobService.saveApplyGrade(gradeVO.getGradeList());
			}

			if(isSuccess) {
				resultMap.put("msg", "저장되었습니다.");
				resultMap.put("result", "success");
			} else {
				resultMap.put("msg", "저장에 실패하였습니다.");
				resultMap.put("result", "fail");
			}
		}

		mav.addObject("json", resultMap);
    	mav.setViewName("jsonView");

    	return mav;

	}

	@RequestMapping(value="/myRecStep03")
	public String step03(	HttpServletRequest request
							, @ModelAttribute("recruit") RecruitVO vo
							, ModelMap model) throws Exception {

		List<Map> rsCareerList = new ArrayList<Map>();
		List<Map> rsTrainingList = new ArrayList<Map>();
		List<Map> rsLanguageList = new ArrayList<Map>();
		List<Map> rsCertList = new ArrayList<Map>();

		// 경력 등록여부 조회
		int regCareerCount = jobService.checkCareerReg(vo);
		if(regCareerCount > 0) {
			rsCareerList = jobService.getCareerList(vo);
		}

		// 어학연수 등록여부 조회
		int regTrainingCount = jobService.checkTrainingReg(vo);
		if(regTrainingCount > 0) {
			rsTrainingList = jobService.getTrainingList(vo);
		}

		// 어학 등록여부 조회
		int regLanguageCount = jobService.checkLanguageReg(vo);
		if(regLanguageCount > 0) {
			rsLanguageList = jobService.getLanguageList(vo);
		}

		// 자격 등록여부 조회
		int regCertCount = jobService.checkCertReg(vo);
		if(regCertCount > 0) {
			rsCertList = jobService.getCertList(vo);
		}

		// 국가 공통코드 조회
		List<Map> natCodes = comCodeService.getCodeByGroup("20");
		JSONArray jsonNatCodes = JSONArray.fromObject(natCodes);

		// 외국어명 공통코드 조회
		List<Map> languageCodes = comCodeService.getCodeByGroup("10");
		JSONArray jsonLanguageCodes = JSONArray.fromObject(languageCodes);

		// 시험명 공통코드 조회
		List<Map> examCodes = comCodeService.getCodeByGroup("11");
		JSONArray jsonExamCodes = JSONArray.fromObject(examCodes);

		// 자격등급 공통코드 조회
		List<Map> certGradeCodes = comCodeService.getCodeByGroup("21");
		JSONArray jsonCertGradeCodes = JSONArray.fromObject(certGradeCodes);

		model.addAttribute("natCodes", natCodes);
		model.addAttribute("languageCodes", languageCodes);
		model.addAttribute("examCodes", examCodes);
		model.addAttribute("certGradeCodes", certGradeCodes);

		model.addAttribute("jsonNatCodes", jsonNatCodes);
		model.addAttribute("jsonLanguageCodes", jsonLanguageCodes);
		model.addAttribute("jsonExamCodes", jsonExamCodes);
		model.addAttribute("jsonCertGradeCodes", jsonCertGradeCodes);

		model.addAttribute("rsCareerList", rsCareerList);
		model.addAttribute("rsTrainingList", rsTrainingList);
		model.addAttribute("rsLanguageList", rsLanguageList);
		model.addAttribute("rsCertList", rsCertList);

		return "/client/job/myRecStep03";

	}

	@RequestMapping(value="/searchCert")
	public ModelAndView searchCert(	HttpServletRequest request
									, @RequestParam(value="searchTxt", required=true) String searchTxt) throws Exception {

		ModelAndView mav = new ModelAndView("jsonView");

		List<Map> certCodes = comCodeService.getCodeSearchByGroup("12", searchTxt);

		mav.addObject("result", certCodes);

		return mav;

	}

	@RequestMapping(value="/saveApplyCareer", method=RequestMethod.POST)
	public ModelAndView saveApplyCareer(HttpServletRequest request
										, RecruitVO recruitVO
										, @Valid RecruitCareerVO careerVO
										, @Valid RecruitTrainingVO trainingVO
										, @Valid RecruitLanguageVO languageVO
										, @Valid RecruitCertVO certVO
										, BindingResult bindingResult) throws Exception {

		Map resultMap = new HashMap();
		ModelAndView mav = new ModelAndView("jsonView");

		if(bindingResult.hasErrors()) {
			log.error("saveApplyCareer Binding Result has error!");
			List<ObjectError> errors = bindingResult.getAllErrors();
			for(ObjectError error : errors) {
				log.error("{} : {}", error.getObjectName(), error.getDefaultMessage());
			}

			resultMap.put("errors", errors);
			resultMap.put("result", "fail");
		} else {
			boolean isSuccess = true;

			try {
				// REC_APPLY_CAREER 저장
				jobService.saveApplyCareer(recruitVO, careerVO.getCareerList());

				// REC_APPLY_TRAINING 저장
				jobService.saveApplyTraining(recruitVO, trainingVO.getTrainingList());

				// REC_APPLY_LANGUAGE 저장
				jobService.saveApplyLanguage(recruitVO, languageVO.getLanguageList());

				// REC_APPLY_CERT 저장
				jobService.saveApplyCert(recruitVO, certVO.getCertList());
			} catch(Exception ex) {
				isSuccess = false;

				if(log.isErrorEnabled())log.error(ex.getMessage());
				ex.printStackTrace();
			}

			if(isSuccess) {
				resultMap.put("msg", "저장되었습니다.");
				resultMap.put("result", "success");
			} else {
				resultMap.put("msg", "저장에 실패하였습니다.");
				resultMap.put("result", "fail");
			}
		}

		mav.addObject("json", resultMap);
    	mav.setViewName("jsonView");

    	return mav;

	}

	@RequestMapping(value="/myRecStep04")
	public String step04(	HttpServletRequest request
							, ModelMap model
							, @ModelAttribute("recruit") RecruitVO vo) throws Exception {

		List<Map> rsIntroList = new ArrayList<Map>();
		List<Map> rsApplyIntroList = new ArrayList<Map>();
		Map rs = null;

		// 마스터 정보 조회
		rs = jobService.getPersonalInfo(vo);

		// 자기소개서 항목 조회
		vo.setrGubun((String)rs.get("R_GUBUN"));
		rsIntroList = jobService.getIntroList(vo);

		// 지원직군 조회
		String applyKindNm = jobService.getApplyKindNm(vo);

		// 자기소개서 등록여부 조회
		int regApplyIntroCount = jobService.checkApplyIntroReg(vo);
		if(regApplyIntroCount > 0) {
			rsApplyIntroList = jobService.getApplyIntroList(vo);
		}

		model.addAttribute("applyKindNm", applyKindNm);
		model.addAttribute("rsIntroList", rsIntroList);
		model.addAttribute("rsApplyIntroList", rsApplyIntroList);

		return "/client/job/myRecStep04";

	}

	@RequestMapping(value="/saveApplyIntro", method=RequestMethod.POST)
	public ModelAndView saveApplyIntro(	HttpServletRequest request
										, @Valid RecruitIntroVO vo
										, BindingResult bindingResult) throws Exception {

		Map resultMap = new HashMap();
		ModelAndView mav = new ModelAndView("jsonView");

		if(bindingResult.hasErrors()) {
			log.error("saveApplyIntro Binding Result has error!");
			List<ObjectError> errors = bindingResult.getAllErrors();
			for(ObjectError error : errors) {
				log.error("{} : {}", error.getObjectName(), error.getDefaultMessage());
			}

			resultMap.put("errors", errors);
			resultMap.put("result", "fail");
		} else {
			// REC_APPLY_INTRODUCTION 저장
			boolean isSuccess = jobService.saveApplyIntro(vo.getIntroList());

			if(isSuccess) {
				resultMap.put("msg", "자기소개서가 저장되었습니다.");
				resultMap.put("result", "success");
			} else {
				resultMap.put("msg", "저장에 실패하였습니다.");
				resultMap.put("result", "fail");
			}
		}

		mav.addObject("json", resultMap);
    	mav.setViewName("jsonView");

    	return mav;

	}

	@RequestMapping(value="/myRecStep05")
	public String step05(	HttpServletRequest request
							, ModelMap model
							, @ModelAttribute("recruit") RecruitVO vo) throws Exception {

		// 진행상태 update
		jobService.updateStatus(vo);

		// 지원서 정보 조회
		Map rs = jobService.getApplyInfo(vo);

		model.addAttribute("rs", rs);

		return "/client/job/myRecStep05";

	}

	@RequestMapping(value="/searchPwd")
	public String searchPwd(	HttpServletRequest request
							, ModelMap model
							, @RequestParam(value="rIdx", required=false) Integer rIdx
							) throws Exception {

		Map code = new HashMap();

		/***************************************
		 * 코드 세팅
		 * **************************************/
		code.put("code40", comCodeService.getCodeByGroup("40")); // 채용구분

		List<Map> rsList = jobService.getCurrentNoticeList();
		if(rIdx != null){
			for (Map map:rsList) {
				int idx = (int) map.get("IDX");
				if(rIdx == idx){
					model.addAttribute("rs", map);
				}
			}
		}

		model.addAttribute("code", code);
		model.addAttribute("rsList", rsList);
		return "/client/job/mySearchPwd";

	}

	@RequestMapping(value="/appyExistPwdCheck")
	public ModelAndView appyExistPwdCheck(	HttpServletRequest request
										, @ModelAttribute("recruit") RecruitVO vo
										, ModelMap model) {

		Map resultMap = new HashMap();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		try {
			int regCount = jobService.checkReg(vo);
			if(regCount >0){
				Map map = jobService.appySelectOneInfo(vo);
				sendPwdEmail(map);
			}else{
				resultMap.put("result", "fail");
			}
		} catch (Exception e) {
			resultMap.put("result", "error");
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}

		mav.addObject("json", resultMap);

		return mav;

	}

	/**
	 * 작성자. 김병식
	 * [TODO] 메일이 아직 개발이 안됨. 서비스만 태웠음.
	 *
	 */
	private void sendPwdEmail(Map map){
		try {

			EmailVO eVo = new EmailVO();
			String pwd =(String) map.get("R_PWD");
			System.out.println(AESCrypt.decrypt(pwd));

			String r_EMAIL = "the7070@naver.com";
			String s_EMAIL = "the7070@naver.com";
			String title   = "[비밀번호 발송]무림제지";

			String contents = "";
			contents += "비밀번호는 아래와 같습니다.";
			contents += pwd;
			contents += "감사합니다.";

			eVo.setR_EMAIL(r_EMAIL);
			eVo.setS_EMAIL(s_EMAIL);
			eVo.setTITLE(title);
			eVo.setCONTENTS(contents);

		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
	}
}
