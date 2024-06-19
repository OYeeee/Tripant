package mclass.store.tripant.diary.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mclass.store.tripant.diary.domain.DiaryBoardEntity;

import mclass.store.tripant.diary.domain.WritePlanTitleEntity;
import mclass.store.tripant.diary.model.repository.DiaryRepository;

@Service
public class DiaryService {
	@Autowired
	private DiaryRepository diaryRepository;

	// 다이어리 리스트 가져오기
    public List<DiaryBoardEntity> selectDiaryList(String areaname) {
        return diaryRepository.selectDiaryList(areaname);
    }

    // 특정 ID의 다이어리 가져오기
    public DiaryBoardEntity findById(Long id) {
        return diaryRepository.findById(id);
    }

    // 다이어리 등록하기
    public DiaryBoardEntity save(DiaryBoardEntity diary) {
        diaryRepository.insertDiary(diary);
        return diary;
    }

    // 회원의 모든 여행 계획 가져오기
    public List<WritePlanTitleEntity> getAllPlans(String memberEmail) {
        return diaryRepository.selectPlanById(memberEmail);
    }

    // 다이어리 좋아요 수 증가하기
    public boolean incrementLikes(Long diaryId) {
        try {
            diaryRepository.incrementLikes(diaryId);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    //지역코드
    public List<DiaryBoardEntity> selectDiariesByAreaCode(String areaCode) {
		return diaryRepository.selectDiariesByAreaCode(areaCode);
	}

	
}