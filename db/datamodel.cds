namespace maneesh.db;

type guid : String(32);

context master {

    entity vendor {
        key NODE_KEY      : guid;
            BP_ROLE       : String(2);
            EMAIL_ADDRESS : String(64);
            PHONE_NUMBER  : String(14);
            FAX_NUMBER    : String(14);
            WEB_ADDRESS   : String(64);
            ADDRESS_GUID  : Association to address;
            BP_ID         : String(16);
            COMPANY_NAME  : String(80);

    }

    entity address {
        key NODE_KEY       : guid;
            CITY           : String(64);
            POSTAL_CODE    : String(14);
            STREET         : String(64);
            BUILDING       : String(64);
            COUNTRY        : String(2);
            VAL_START_DATE : Date;
            VAL_END_DATE   : Date;
            LATITUDE       : Decimal;
            LONGITUDE      : Decimal;
            busspartner    : Association to one vendor
                                 on busspartner.ADDRESS_GUID = $self;
    }

    entity prodtext {
        key NODE_KEY   : guid;
            PARENT_KEY : guid;
            LANGUAGE   : String(2);
            TEXT       : String(256);

    }

    entity product {

        key NODE_KEY       : guid;
            PRODUCT_ID     : String(10);
            TYPE_CODE      : String(2);
            CATEGORY       : String(32);
            DESC_GUID      : Association to prodtext;
            SUPPLIER_GUID  : Association to vendor;
            TAX_TARIF_CODE : Integer;
            MEASURE_UNIT   : String(2);
            WEIGHT_MEASURE : Decimal;
            WEIGHT_UNIT    : String(2);
            CURRENCY_CODE  : String(4);
            PRICE          : Decimal;
            WIDTH          : Decimal;
            DEPTH          : Decimal;
            HEIGHT         : Decimal;
            DIM_UNIT       : String(2);

    }

}

context transation {

    entity purchaseorder {
        key NODE_KEY         : guid;
            PO_ID            : String(24);
            PARTNER_GUID     : Association to master.vendor;
            CURRENCY_CODE    : String(4);
            GROSS_AMOUNT     : Decimal;
            NET_AMOUNT       : Decimal;
            TAX_AMOUNT       : Decimal;
            LIFECYCLE_STATUS : String(1);
            OVERALL_STATUS   : String(1);
            items            : Association to many poitems
                                   on items.PARENT_KEY = $self;

    }

    entity poitems {
        key NODE_KEY      : guid;
            PARENT_KEY    : Association to purchaseorder;
            PO_ITEM_POS   : Integer;
            PRODUCT_GUID  : Association to master.product;
            CURRENCY_CODE : String(4);
            GROSS_AMOUNT  : Decimal;
            NET_AMOUNT    : Decimal;
            TAX_AMOUNT    : Decimal;

    }

}
