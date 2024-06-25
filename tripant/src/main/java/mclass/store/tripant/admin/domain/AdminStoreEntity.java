package mclass.store.tripant.admin.domain;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class AdminStoreEntity {

	//상품관리
		private String itemCode;
		private String itemName;
		private Integer itemPrice;
		private Integer itemDur;
		private Integer itemSale;
		private String itemColor;
		
		private String memNick;
		private String memEmail;
}
