package com.dongseo.card.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dongseo.card.model.card.CardService;
import com.dongseo.card.model.card.CardVO;
import com.dongseo.card.model.user.UserService;
import com.dongseo.card.model.user.UserVO;
import com.google.gson.Gson;
import com.mysql.cj.Session;

@Controller
public class CardController {
	
	@Autowired
	CardService cardService;
	
	@Autowired 
	UserService userService;

	static final Logger log = Logger.getLogger(String.valueOf(CardController.class));
	
	// ������ �̵��� ����
	@GetMapping(value="/card/insert")
	public String insertcard() {
		return "cardInsert";
	}
	@GetMapping(value="/card/select")
	public String Selectcard() {
		return "cardSelect";
	}@GetMapping(value="/card/select2")
	public String Selectcard2() {
		return "cardSelect2";
	}
	@GetMapping(value="/store")
	public String SelectStore() {
		log.info("store");
		return "storeSelect";
	}
	@GetMapping(value="/store/{name}")
	public String SelectStore2() {
		log.info("store ����");
		return "storeSelect2";
	}
	
	// REST ���⼭ ���� �ʿ�
	// ī�� ���
	@PostMapping(value = "/card", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String insert(@RequestBody CardVO vo)throws Exception {
		log.info("ī�� ���"+vo.getCARD_CARD_NAME() + "\n" + vo.getUSER_USER_ID() );
		log.info(vo.toString());
		cardService.insertCard(vo);
	
		return "T";
	}
	//����� ī�� select 
	@PostMapping(value="/card/select")
	@ResponseBody
	public List<CardVO> cardSelect(@RequestBody Map<String,String> id){
		log.info("����� ī�� ����" + id.get("id"));
		List<CardVO> vo =cardService.selectUserCard(id.get("id"));
		log.info(vo.toString());
		for(CardVO t : vo) {
			log.info(t.toString());
		}
		return vo;
		
		
	}//ī�� ��ü ����
	@PostMapping(value="/card/select2")
	@ResponseBody
	public List<CardVO> cardSelect2(){
		Map<String, String> obj = new HashMap<String, String>();
		List<CardVO> vo =cardService.selectCard();
		
		return vo;
		
	}
	//���� ����
	@PostMapping(value="/store")
	@ResponseBody
	public List<CardVO> store(){
		log.info("���� ����");
		List<CardVO> vo =cardService.selectStore();
		return vo;
		
	}//����� ���忡 ���� ī����� 
	@PostMapping(value="/store/{name}")
	@ResponseBody
	public List<CardVO> store(@PathVariable String name, @RequestParam Map<String, String> param){
		int T = Integer.parseInt((userService.money(param.get("id"))));
		log.info(String.valueOf(T)+"��������������������������������������������������������������������������������������");
		log.info("����� ����");
		log.info(name);
		log.info(param.get("id"));
		List<CardVO> result = new ArrayList<CardVO>();
		List<CardVO> vo =cardService.selectStoreCard(name, param.get("id"));
	
		CardVO t[] = new CardVO[vo.size()];
		int i =0 ;
		
		//ī�� ��� ����Ʈ ȣ��
		for(CardVO card: vo) {
			if(card.getSTORE_CARD_PERSENT_SALE() !=0) {
				card.setResult(T-(T* card.getSTORE_CARD_PERSENT_SALE()/100));
			}
			else {
				card.setResult(T-card.getSTORE_CARD_CASH_SALE());
			}

			log.info("������ :" +card.getCARD_NAME());
			t[i]=card;
			i++;
		}
		//ī�� �켱���� ����
		for( i=0; i<t.length; i++) {
			int tem = i;
			for (int j=i+1; j<t.length; j++) {
				if(t[tem].getResult() > t[j].getResult()) tem = j;
			}
			CardVO x = t[tem];
			t[tem] = t[i];
			t[i] = x;
			result.add(t[i]);
			log.info(t[i].getCARD_NAME());
		}
		return result;
		
	}
}
