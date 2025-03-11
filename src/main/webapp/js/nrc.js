document.addEventListener("DOMContentLoaded", () => {
    const regionSelect = document.getElementById("region");
    const stateSelect = document.getElementById("state");
    const typeSelect = document.getElementById("type");
    const nrcInput = document.getElementById("nrc_number");
    const nrcHiddenInput = document.getElementById("nrc");

    // Region-to-State Mapping (Adjust according to your actual data)
    const regionStateMap = {
		
	"1": [
	    { "value": "MAKANA", "label": "MAKANA (မရက)" },
	    { "value": "WAMANA", "label": "WAMANA (ဝမန)" },
	    { "value": "KHAPHANA", "label": "KHAPHANA (ခဖန)" },
	    { "value": "SALANA", "label": "SALANA (ဆလန)" },
	    { "value": "TANANA", "label": "TANANA (တနန)" },
	    { "value": "AHGAYA", "label": "AHGAYA (အဂယ)" },
	    { "value": "MANYANA", "label": "MANYANA (မညန)" },
	    { "value": "MAKANA", "label": "MANYANA (မကန)" },
	    { "value": "KAMANA", "label": "KAMANA (ကမန)" },
	    { "value": "BAMANA", "label": "BAMANA (ဗမန)" },
	    { "value": "YAKANA", "label": "YAKANA (ရကန)" },
	    { "value": "MASANA", "label": "MASANA (မစန)" },
	    { "value": "MAMANA", "label": "MAMANA (မမန)" },
	    { "value": "PATAAH", "label": "PATAAH (ပတအ)" },
	    { "value": "SAPABA", "label": "SAPABA (ဆပဘ)" },
	    { "value": "MAKHABA", "label": "MAKHABA (မခဘ)" },
	    { "value": "KHABADA", "label": "KHABADA (ခဘဒ)" },
	    { "value": "NAMANA", "label": "NAMANA (နမန)" }
	],

	"2": [
	    { "value": "LAKANA", "label": "LAKANA (လကန)" },
	    { "value": "DAMASA", "label": "DAMASA (ဒမဆ)" },
	    { "value": "PHAYASA", "label": "PHAYASA (ဖရစ)" },
	    { "value": "YATANA", "label": "YATANA (ရတန)" },
	    { "value": "BALAKHA", "label": "BALAKHA (ဘလခ)" },
	    { "value": "MASANA", "label": "MASANA (မစန)" },
	    { "value": "PHASANA", "label": "PHASANA (ဖဆန)" }
	],
    
	    "3": [
	    { "value": "BAAHNA", "label": "BAAHNA (ဘအန)" },
	    { "value": "LABANA", "label": "LABANA (လဘန)" },
	    { "value": "THATANA", "label": "THATANA (သတန)" },
	    { "value": "KAKAYA", "label": "KAKAYA (ကကယ)" },
	    { "value": "KASAKA", "label": "KASAKA (ကစက)" },
	    { "value": "MAWATA", "label": "MAWATA (မဝတ)" },
	    { "value": "PHAPANA", "label": "PHAPANA (ဖပန)" }
	],
		"4": [
	    { "value": "HAKHANA", "label": "HAKHANA (ဟခန)" },
	    { "value": "HTATALA", "label": "HTATALA (ထတလ)" },
	    { "value": "MATANA", "label": "MATANA (မတန)" },
	    { "value": "PALAWA", "label": "PALAWA (ပလဝ)" },
	    { "value": "MATAPA", "label": "MATAPA (မတပ)" },
	    { "value": "KAPALA", "label": "KAPALA (ကပလ)" },
	    { "value": "PHALANA", "label": "PHALANA (ဖလန)" },
	    { "value": "TATANA", "label": "TATANA (တတန)" },
	    { "value": "TAZANA", "label": "TAZANA (တဇန)" }
	],

		"5": [
	    { "value": "MAYANA", "label": "MAYANA (မရန)" },
	    { "value": "AHYATA", "label": "AHYATA (အရတ)" },
	    { "value": "KHAOUTA", "label": "KHAOUTA (ခဥတ)" },
	    { "value": "BATALA", "label": "BATALA (ဘတလ)" },
	    { "value": "SAKANA", "label": "SAKANA (စကန)" },
	    { "value": "MAMANA", "label": "MAMANA (မမာန)" },
	    { "value": "MAMATA", "label": "MAMATA (မမတ)" },
	    { "value": "KALAHTA", "label": "KALAHTA (ကလထ)" },
	    { "value": "KALAWA", "label": "KALAWA (ကလဝ)" },
	    { "value": "MAKANA", "label": "MAKANA (မကန)" },
	    { "value": "KATHANA", "label": "KATHANA (ကသန)" },
	    { "value": "AHTANA", "label": "AHTANA (အတန)" },
	    { "value": "BAMANA", "label": "BAMANA (ဗမာန)" },
	    { "value": "KALATA", "label": "KALATA (ကလတ)" },
	    { "value": "PALABA", "label": "PALABA (ပလဘ)" },
	    { "value": "WATHANA", "label": "WATHANA (ဝတန)" },
	    { "value": "HTAKHANA", "label": "HTAKHANA (ထခန)" },
	    { "value": "KHATANA", "label": "KHATANA (ခတန)" },
	    { "value": "HAMALA", "label": "HAMALA (ဟမလ)" },
	    { "value": "LAYANA", "label": "LAYANA (လရန)" },
	    { "value": "NAYANA", "label": "NAYANA (နယန)" },
	    { "value": "LAHANA", "label": "LAHANA (လဟန)" },
	    { "value": "MALANA", "label": "MALANA (မလန)" },
	    { "value": "PHAPANA", "label": "PHAPANA (ဖပန)" },
	    { "value": "YAMAPA", "label": "YAMAPA (ယမပ)" },
	    { "value": "SALAKA", "label": "SALAKA (ဆလက)" },
	    { "value": "PALANA", "label": "PALANA (ပလန)" },
	    { "value": "YABANA", "label": "YABANA (ရဘန)" },
	    { "value": "DAPAYA", "label": "DAPAYA (ဒပယ)" },
	    { "value": "KABALA", "label": "KABALA (ကဘလ)" },
	    { "value": "KHAOUNA", "label": "KHAOUNA (ခဥန)" },
	    { "value": "KALANA", "label": "KALANA (ကလန)" },
	    { "value": "TASANA", "label": "TASANA (တဆန)" },
	    { "value": "YAOUNA", "label": "YAOUNA (ရဥန)" },
	    { "value": "WALANA", "label": "WALANA (ဝလန)" },
	    { "value": "TAMANA", "label": "TAMANA (တမန)" }
	],

		"6": [
	    { "value": "HTAWANA", "label": "HTAWANA (ထဝန)" },
	    { "value": "LALANA", "label": "LALANA (လလန)" },
	    { "value": "THAYAKHA", "label": "THAYAKHA (သရခ)" },
	    { "value": "YAPHANA", "label": "YAPHANA (ရဖန)" },
	    { "value": "MAMANA", "label": "MAMANA (မမန)" },
	    { "value": "TATHAYA", "label": "TATHAYA (တသရ)" },
	    { "value": "KASANA", "label": "KASANA (ကစန)" },
	    { "value": "PALANA", "label": "PALANA (ပလန)" },
	    { "value": "KATHANA", "label": "KATHANA (ကသန)" },
	    { "value": "BAPANA", "label": "BAPANA (ဘပန)" }
	],
		
		"7": [
	    { "value": "PAKHANA", "label": "PAKHANA (ပခန)" },
	    { "value": "DAOUNA", "label": "DAOUNA (ဒဥန)" },
	    { "value": "KATAKHA", "label": "KATAKHA (ကတခ)" },
	    { "value": "KAWANA", "label": "KAWANA (ကဝန)" },
	    { "value": "NYALAPA", "label": "NYALAPA (ညလပ)" },
	    { "value": "YAKANA", "label": "YAKANA (ရကန)" },
	    { "value": "THANAPA", "label": "THANAPA (သနပ)" },
	    { "value": "WAMANA", "label": "WAMANA (ဝမန)" },
	    { "value": "PAMANA", "label": "PAMANA (ပမန)" },
	    { "value": "PATANA", "label": "PATANA (ပတန)" },
	    { "value": "THAKANA", "label": "THAKANA (သကန)" },
	    { "value": "PAKHATA", "label": "PAKHATA (ပခတ)" },
	    { "value": "PATATA", "label": "PATATA (ပတတ)" },
	    { "value": "YATANA", "label": "YATANA (ရတန)" },
	    { "value": "THAWATA", "label": "THAWATA (သဝတ)" },
	    { "value": "MANYANA", "label": "MANYANA (မညန)" },
	    { "value": "AHPHANA", "label": "AHPHANA (အဖန)" },
	    { "value": "LAPATA", "label": "LAPATA (လပတ)" },
	    { "value": "MALANA", "label": "MALANA (မလန)" },
	    { "value": "NATALA", "label": "NATALA (နတလ)" },
	    { "value": "ZAKANA", "label": "ZAKANA (ဇကန)" },
	    { "value": "KAPAKA", "label": "KAPAKA (ကပက)" },
	    { "value": "TANGANA", "label": "TANGANA (တငန)" },
	    { "value": "HTATAPA", "label": "HTATAPA (ထတပ)" },
	    { "value": "PHAMANA", "label": "PHAMANA (ဖမန)" },
	    { "value": "AHTANA", "label": "AHTANA (အတန)" },
	    { "value": "YATAYA", "label": "YATAYA (ရတရ)" },
	    { "value": "KAKANA", "label": "KAKANA (ကကန)" }
	],
		
		"8": [
	    { "value": "MAKANA", "label": "MAKANA (မကန)" },
	    { "value": "NAMANA", "label": "NAMANA (နမန)" },
	    { "value": "MATHANA", "label": "MATHANA (မသန)" },
	    { "value": "TATAKA", "label": "TATAKA (တတက)" },
	    { "value": "YANAKHA", "label": "YANAKHA (ရနခ)" },
	    { "value": "KHAMANA", "label": "KHAMANA (ခမန)" },
	    { "value": "MABANA", "label": "MABANA (မဘန)" },
	    { "value": "PAPHANA", "label": "PAPHANA (ပဖန)" },
	    { "value": "NGAPHANA", "label": "NGAPHANA (ငဖန)" },
	    { "value": "SALANA", "label": "SALANA (စလန)" },
	    { "value": "SATAYA", "label": "SATAYA (စတရ)" },
	    { "value": "GAGANA", "label": "GAGANA (ဂဂန)" },
	    { "value": "HTALANA", "label": "HTALANA (ထလန)" },
	    { "value": "SAMANA", "label": "SAMANA (ဆမန)" },
	    { "value": "THAYANA", "label": "THAYANA (သရန)" },
	    { "value": "SAPAWA", "label": "SAPAWA (ဆပဝ)" },
	    { "value": "MATANA", "label": "MATANA (မတန)" },
	    { "value": "AHLANA", "label": "AHLANA (အလန)" },
	    { "value": "KAMANA", "label": "KAMANA (ကမန)" },
	    { "value": "PAKHAKA", "label": "PAKHAKA (ပခက)" },
	    { "value": "SAPHANA", "label": "SAPHANA (ဆဖန)" },
	    { "value": "PAMANA", "label": "PAMANA (ပမန)" },
	    { "value": "MAMANA", "label": "MAMANA (မမန)" },
	    { "value": "YASAKA", "label": "YASAKA (ရစက)" }
	],
		
		"9": [
	    { "value": "AHMAZA", "label": "AHMAZA (အမဇ)" },
	    { "value": "KHAAHZA", "label": "KHAAHZA (ခအဇ)" },
	    { "value": "KHAMASA", "label": "KHAMASA (ခမစ)" },
	    { "value": "MAHAMA", "label": "MAHAMA (မဟမ)" },
	    { "value": "PAKAKHA", "label": "PAKAKHA (ပကခ)" },
	    { "value": "PATHAKA", "label": "PATHAKA (ပသက)" },
	    { "value": "AHMAYA", "label": "AHMAYA (အမရ)" },
	    { "value": "KASANA", "label": "KASANA (ကဆန)" },
	    { "value": "MATHANA", "label": "MATHANA (မသန)" },
	    { "value": "SAKATA", "label": "SAKATA (စကတ)" },
	    { "value": "TATAOU", "label": "TATAOU (တတဥ)" },
	    { "value": "MAHTALA", "label": "MAHTALA (မထလ)" },
	    { "value": "MALANA", "label": "MALANA (မလန)" },
	    { "value": "THASANA", "label": "THASANA (သစန)" },
	    { "value": "WATANA", "label": "WATANA (ဝတန)" },
	    { "value": "MAKHANA", "label": "MAKHANA (မခန)" },
	    { "value": "NAHTAKA", "label": "NAHTAKA (နထက)" },
	    { "value": "NGAZANA", "label": "NGAZANA (ငဇန)" },
	    { "value": "TATHANA", "label": "TATHANA (တသန)" },
	    { "value": "NYAOUNA", "label": "NYAOUNA (ညဥန)" },
	    { "value": "KAPATA", "label": "KAPATA (ကပတ)" },
	    { "value": "PAOULA", "label": "PAOULA (ပဥလ)" },
	    { "value": "MAKANA", "label": "MAKANA (မကန)" },
	    { "value": "SAKANA", "label": "SAKANA (စကန)" },
	    { "value": "THAPAKA", "label": "THAPAKA (သပက)" },
	    { "value": "MATAYA", "label": "MATAYA (မတရ)" },
	    { "value": "YAMATHA", "label": "YAMATHA (ရမသ)" },
	    { "value": "PABANA", "label": "PABANA (ပဘန)" },
	    { "value": "DAKHATHA", "label": "DAKHATHA (ဒခသ)" },
	    { "value": "LAWANA", "label": "LAWANA (လဝန)" },
	    { "value": "PAMANA", "label": "PAMANA (ပမန)" },
	    { "value": "ZABATHA", "label": "ZABATHA (ဇဗသ)" },
	    { "value": "OUTATHA", "label": "OUTATHA (ဥတသ)" },
	    { "value": "PABATHA", "label": "PABATHA (ပဗသ)" },
	    { "value": "TAKANA", "label": "TAKANA (တကန)" },
	    { "value": "ZAYATHA", "label": "ZAYATHA (ဇယသ)" }
	  ],
		"10": [
		    { "value": "MALAMA", "label": "MALAMA (မလမ)" },
		    { "value": "YAMANA", "label": "YAMANA (ရမန)" },
		    { "value": "KHASANA", "label": "KHASANA (ခဆန)" },
		    { "value": "KAMAYA", "label": "KAMAYA (ကမရ)" },
		    { "value": "MADANA", "label": "MADANA (မဒန)" },
		    { "value": "THAPHAYA", "label": "THAPHAYA (သဖရ)" },
		    { "value": "THAHTANA", "label": "THAHTANA (သထန)" },
		    { "value": "BALANA", "label": "BALANA (ဘလန)" },
		    { "value": "KAHTANA", "label": "KAHTANA (ကထန)" },
		    { "value": "PAMANA", "label": "PAMANA (ပမန)" }
		],

		"11": [
	    { "value": "SATANA", "label": "SATANA (စတန)" },
	    { "value": "PATANA", "label": "PATANA (ပတန)" },
	    { "value": "PANATA", "label": "PANATA (ပဏတ)" },
	    { "value": "YATHATA", "label": "YATHATA (ရသတ)" },
	    { "value": "KAPHANA", "label": "KAPHANA (ကဖန)" },
	    { "value": "YABANA", "label": "YABANA (ရဗန)" },
	    { "value": "AHMANA", "label": "AHMANA (အမန)" },
	    { "value": "MAAHNA", "label": "MAAHNA (မအန)" },
	    { "value": "MAOUNA", "label": "MAOUNA (မဥန)" },
	    { "value": "MAPATA", "label": "MAPATA (မပတ)" },
	    { "value": "KATANA", "label": "KATANA (ကတန)" },
	    { "value": "TAKANA", "label": "TAKANA (တကန)" },
	    { "value": "GAMANA", "label": "GAMANA (ဂမန)" },
	    { "value": "MATANA", "label": "MATANA (မတန)" },
	    { "value": "BATHATA", "label": "BATHATA (ဘသတ)" }
	],
	"12": [
	    { "value": "TAMANA", "label": "TAMANA (တမန)" },
	    { "value": "OUKATA", "label": "OUKATA (ဥကတ)" },
	    { "value": "DAGASA", "label": "DAGASA (ဒဂဆ)" },
	    { "value": "DAGATA", "label": "DAGATA (ဒဂတ)" },
	    { "value": "DAGAMA", "label": "DAGAMA (ဒဂမ)" },
	    { "value": "DAGAYA", "label": "DAGAYA (ဒဂရ)" },
	    { "value": "DAPANA", "label": "DAPANA (ဒပန)" },
	    { "value": "PAZATA", "label": "PAZATA (ပဇတ)" },
	    { "value": "BATAHTA", "label": "BATAHTA (ဗထတ)" },
	    { "value": "OUKAMA", "label": "OUKAMA (ဥကမ)" },
	    { "value": "YAKANA", "label": "YAKANA (ရကန)" },
	    { "value": "THAGATA", "label": "THAGATA (သဃက)" },
	    { "value": "TAHKATA", "label": "TAHKATA (သကတ)" },
	    { "value": "MAGATA", "label": "MAGATA (မဂတ)" },
	    { "value": "TAKANA", "label": "TAKANA (တကန)" },
	    { "value": "HTATAPA", "label": "HTATAPA (ထတပ)" },
	    { "value": "MAGADA", "label": "MAGADA (မဂဒ)" },
	    { "value": "MABANA", "label": "MABANA (မဘန)" },
	    { "value": "YAPATHA", "label": "YAPATHA (ရပသ)" },
	    { "value": "LAKANA", "label": "LAKANA (လကန)" },
	    { "value": "LATHAYA", "label": "LATHAYA (လသယ)" },
	    { "value": "AHSANA", "label": "AHSANA (အစန)" },
	    { "value": "KATANA", "label": "KATANA (ကတန)" },
	    { "value": "KAKHAKA", "label": "KAKHAKA (ကခက)" },
	    { "value": "KAKAKA", "label": "KAKAKA (ကကက)" },
	    { "value": "KAMANA", "label": "KAMANA (ကမန)" },
	    { "value": "KHAYANA", "label": "KHAYANA (ခရန)" },
	    { "value": "SAKAKHA", "label": "SAKAKHA (ဆခခ)" },
	    { "value": "TATANA", "label": "TATANA (တတန)" },
	    { "value": "DALANA", "label": "DALANA (ဒလန)" },
	    { "value": "THALANA", "label": "THALANA (သလန)" },
	    { "value": "THAKHANA", "label": "THAKHANA (သခန)" },
	    { "value": "KAMAYA", "label": "KAMAYA (ကမရ)" },
	    { "value": "KATATA", "label": "KATATA (ကတတ)" },
	    { "value": "KAMATA", "label": "KAMATA (ကမတ)" },
	    { "value": "SAKHANA", "label": "SAKHANA (စခန)" },
	    { "value": "SAKANA", "label": "SAKANA (ဆကန)" },
	    { "value": "DAGANA", "label": "DAGANA (ဒဂန)" },
	    { "value": "BAHANA", "label": "BAHANA (ဗဟန)" },
	    { "value": "MAYAKA", "label": "MAYAKA (မရက)" },
	    { "value": "LAMATA", "label": "LAMATA (လမတ)" },
	    { "value": "LATHANA", "label": "LATHANA (လသန)" },
	    { "value": "LAMANA", "label": "LAMANA (လမန)" },
	    { "value": "AHLANA", "label": "AHLANA (အလန)" },
	    { "value": "PABATA", "label": "PABATA (ပဘတ)" }
	],
		
		"13": [
	    { "value": "TAKANA", "label": "TAKANA (တကန)" },
	    { "value": "SASANA", "label": "SASANA (ဆဆန)" },
	    { "value": "KALANA", "label": "KALANA (ကလန)" },
	    { "value": "YASANA", "label": "YASANA (ရစန)" },
	    { "value": "NYAYANA", "label": "NYAYANA (ညရန)" },
	    { "value": "PATAYA", "label": "PATAYA (ပတယ)" },
	    { "value": "PALANA", "label": "PALANA (ပလန)" },
	    { "value": "YANGANA", "label": "YANGANA (ရငန)" },
	    { "value": "PHAKHANA", "label": "PHAKHANA (ဖခန)" },
	    { "value": "HAPANA", "label": "HAPANA (ဟပန)" },
	    { "value": "KATANA", "label": "KATANA (ကတန)" },
	    { "value": "MAKHANA", "label": "MAKHANA (မခန)" },
	    { "value": "MAYANA", "label": "MAYANA (မယန)" },
	    { "value": "MAPATA", "label": "MAPATA (မပတ)" },
	    { "value": "TAKHALA", "label": "TAKHALA (တခလ)" },
	    { "value": "MAPHANA", "label": "MAPHANA (မဖန)" },
	    { "value": "MAYATA", "label": "MAYATA (မယတ)" },
	    { "value": "PAYANA", "label": "PAYANA (ပယန)" },
	    { "value": "MAMATA", "label": "MAMATA (မမတ)" },
	    { "value": "MABANA", "label": "MABANA (မပန)" },
	    { "value": "MASANA", "label": "MASANA (မဆန)" },
	    { "value": "MATANA", "label": "MATANA (မတန)" },
	    { "value": "MASATA", "label": "MASATA (မဆတ)" },
	    { "value": "KAKHANA", "label": "KAKHANA (ကခန)" },
	    { "value": "NAKHANA", "label": "NAKHANA (နခန)" },
	    { "value": "LAKHATA", "label": "LAKHATA (လခတ)" },
	    { "value": "MANANA", "label": "MANANA (မနန)" },
	    { "value": "MAPANA", "label": "MAPANA (မပန)" },
	    { "value": "MAMANA", "label": "MAMANA (မမန)" },
	    { "value": "LALANA", "label": "LALANA (လလန)" },
	    { "value": "KAHANA", "label": "KAHANA (ကဟန)" },
	    { "value": "LAKHANA", "label": "LAKHANA (လခန)" },
	    { "value": "MAKANA", "label": "MAKANA (မကန)" },
	    { "value": "MAYANA", "label": "MAYANA (မရန)" },
	    { "value": "KATHANA", "label": "KATHANA (ကသန)" },
	    { "value": "NASANA", "label": "NASANA (နစန)" },
	    { "value": "LAYANA", "label": "LAYANA (လရန)" },
	    { "value": "THANANA", "label": "THANANA (သနန)" },
	    { "value": "KALANA", "label": "KALANA (ကလန)" },
	    { "value": "MAYATA", "label": "MAYATA (မရတ)" },
	    { "value": "TAYANA", "label": "TAYANA (တယန)" },
	    { "value": "KAMANA", "label": "KAMANA (ကမန)" },
	    { "value": "THAPANA", "label": "THAPANA (သပန)" },
	    { "value": "MATATA", "label": "MATATA (မတတ)" },
	    { "value": "NASANA", "label": "NASANA (နဆန)" },
	    { "value": "NAMATA", "label": "NAMATA (နမတ)" },
	    { "value": "NAKHATA", "label": "NAKHATA (နခတ)" },
	    { "value": "LAKANA", "label": "LAKANA (လကန)" },
	    { "value": "KAKANA", "label": "KAKANA (ကကန)" },
	    { "value": "HAPANA", "label": "HAPANA (ဟပန)" }
	],
	"14": [
	    { "value": "PATHANA", "label": "PATHANA (ပသန)" },
	    { "value": "KAKAHTA", "label": "KAKAHTA (ကကထ)" },
	    { "value": "KAPANA", "label": "KAPANA (ကပန)" },
	    { "value": "NGAPATA", "label": "NGAPATA (ငပတ)" },
	    { "value": "THAPANA", "label": "THAPANA (သပန)" },
	    { "value": "KAKANA", "label": "KAKANA (ကကန)" },
	    { "value": "YAKANA", "label": "YAKANA (ရကန)" },
	    { "value": "MAAHPA", "label": "MAAHPA (မအပ)" },
	    { "value": "DANAPHA", "label": "DANAPHA (ဓနဖ)" },
	    { "value": "PATANA", "label": "PATANA (ပတန)" },
	    { "value": "NYATANA", "label": "NYATANA (ညာတန)" },
	    { "value": "HATHATA", "label": "HATHATA (ဟသတ)" },
	    { "value": "ZALANA", "label": "ZALANA (ဇလန)" },
	    { "value": "KAKHANA", "label": "KAKHANA (ကခန)" },
	    { "value": "MAAHNA", "label": "MAAHNA (မအန)" },
	    { "value": "AHGAPA", "label": "AHGAPA (အဂပ)" },
	    { "value": "LAMANA", "label": "LAMANA (လမန)" },
	    { "value": "MAMANA", "label": "MAMANA (မမန)" },
	    { "value": "WAKHAMA", "label": "WAKHAMA (ဝခမ)" },
	    { "value": "AHMANA", "label": "AHMANA (အမန)" },
	    { "value": "PHAPANA", "label": "PHAPANA (ဖပန)" },
	    { "value": "BAKALA", "label": "BAKALA (ဘကလ)" },
	    { "value": "DADAYA", "label": "DADAYA (ဒဒရ)" },
	    { "value": "KALANA", "label": "KALANA (ကလန)" },
	    { "value": "LAPATA", "label": "LAPATA (လပတ)" },
	    { "value": "MAMAKA", "label": "MAMAKA (မမက)" }
	]	
		 };

    // Function to update state dropdown
    function updateStateDropdown() {
        const selectedRegion = regionSelect.value;
        stateSelect.innerHTML = '<option value="" disabled selected>-Select-</option>'; // Reset states

        if (regionStateMap[selectedRegion]) {
            regionStateMap[selectedRegion].forEach(state => {
                const option = document.createElement("option");
                option.value = state.value; // Set the value
                option.textContent = state.label; // Display the label
                stateSelect.appendChild(option);
            });
        }

        updateCombinedNrc(); // Ensure NRC updates dynamically
    }

    // Function to update the combined NRC value
    function updateCombinedNrc() {
        const selectedRegion = regionSelect.value;
        const selectedState = stateSelect.value;
        const selectedType = typeSelect.value;
        const nrcValue = nrcInput.value;

        if (selectedRegion && selectedState && selectedType && nrcValue.length === 6) {
            const combinedValue = `${selectedRegion} / ${selectedState} ${selectedType} ${nrcValue}`;
            nrcHiddenInput.value = combinedValue;
        } else {
            nrcHiddenInput.value = ''; // Clear hidden field if input is incomplete
        }
    }

    // Attach event listeners
    regionSelect.addEventListener("change", updateStateDropdown);
    stateSelect.addEventListener("change", updateCombinedNrc);
    typeSelect.addEventListener("change", updateCombinedNrc);
    nrcInput.addEventListener("input", updateCombinedNrc);
});
