Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D924B7B01B2
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 12:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjI0KVD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 06:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjI0KUz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 06:20:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666D59CD;
        Wed, 27 Sep 2023 03:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695809730; x=1727345730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QyykobWy8hhu10HtRDNj5hhSGyt6lb7pi4yabtQJzMw=;
  b=Qtwg5nlttQFx7CpcYpb18TpMujigVmP5S5F5kFxJjacCkvF+L/Bq3Vj0
   oc+BEQaYMzqGjL76/5r64vnisitjU1LkKRMqQVfRU+Jy26IOukgIO4GHs
   8VTlG7Cf2s9YPTCxi2/aIADFzmcSgMrLNATEMeMmWwYGXfjh4hr2R2GN1
   v0zH1WMxJlUSWBw6OeQ7KveOX0DdzMCXrQ9aIlkPCnI3OPvmnrQEFjvyP
   Mm+sIOt9u6veQpQ/ClsHnY21TpvjrVBaDVxxzu5lVmqRdOe7JsvoJ8wOF
   LZS3xRXiTJwa34tHRQ/+teuMHq50ut1tT+UOJeT/ajt9SGfk2DNR0kmDl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="380661887"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="380661887"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 03:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="784268219"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="784268219"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 03:14:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 03:14:49 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 03:14:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 03:14:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 03:14:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4NH4UYYR+my6uOhSN4JSEnR+AoEXqyzECDpH/YQUp0yz9Tv3sJlfqKhNKFImivjEwxscQL06N+xW0i6QX0vXwWSDR4zT6bnZoDPCly0wrTx99dO9xF6L3OYpn3oVyoDKXXIT7fAzStbOLihhfehMZ+RkX7+DmsPFZaeX1f/Upk+Lcbqq3dGQ4Rc8SRC2CsRF9ND7p7ct5tpkApzL+3k9ceG9TJIzLqLQUkhbYAm7D0dkRLFR0kUXPznI10yDmuzBBr0J+Yx7Y3opmh0jbklaAgL/hP5nHnb2SOk0CxKI+XSkCY0yxeiKVsN0QAA0gZvupAhM2XuNAb1at45WXfS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyykobWy8hhu10HtRDNj5hhSGyt6lb7pi4yabtQJzMw=;
 b=e0s+f9cHmC0s3mGSzynU8kWSLlLq4f+CHCvQXFa0KP2jjRIkO458BJaGI5xDHZgnbvNQxPZtUSl0frQHnTLE/5HTVuLI+tkWc1qQtAyjcIP5b//3gWtL38DNgtveq4hL1d5LfB9Vq8EUztxqQIFcXn5piZYO+21Dc9+yzDpmIeI9hq92XTt9b77KVhUF2zmK+eLQJZjOl7B6LkW/IX7JLqzx8I5QDZoRM7043bMnTGPKamNrztvx4cXUZpiCH8qUryChRmbkV3I83HlEBC98HPwZxUNE9EU+LcCmrZod/rQHyK7NvtEsaPj2DcBNG47eBlQWt4juAwjCAm+tfj9pDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 27 Sep
 2023 10:14:41 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 10:14:41 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v5 05/18] x86/sgx: Store reclaimable EPC pages in
 sgx_epc_lru_lists
Thread-Topic: [PATCH v5 05/18] x86/sgx: Store reclaimable EPC pages in
 sgx_epc_lru_lists
Thread-Index: AQHZ7csRtGAfUkK4dUedWW3EqxZKFbAue0EA
Date:   Wed, 27 Sep 2023 10:14:41 +0000
Message-ID: <0f6d88414ad6609575bfdd21b93fbf8ba92c3a14.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-6-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-6-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CO1PR11MB4978:EE_
x-ms-office365-filtering-correlation-id: 5c4847aa-75a6-490c-7321-08dbbf42907b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K1xHeO7Cw3sDph8EuFmFtxvJxZXF5Ass4KCNVLMIhOvmDi4TPz+zujEKfPjOAPJN1heRYU7Sm/bWGWclYxy3aRW/NwcUURFLdeZP0ljtvAs84I77ulMBEhPn/LHIRVBXK7hTU0hNONJVz8Ls4kXte5IJEdIHHaqSsWioCCcRneYmZEdVmJbUsPFq2F8TjJdw4lokq5qDsbJdF5BLSJpX5XfOHPSeHZugRsDuBjfp0DkaexOXRBDoIYZ8+eTRjxollZakv+BPUJrBYpNpl3WTo1x7ahliG8vngkJXU/nTKM1Gawk0QIkIBEh63F7rWNJ/3e9tCGQYbF1KbjGzX9OlzyctrUuH/+6zjvtBBcDIc4YI3/BYYlZ7vFGdNhGOs6dx/tmTu4W47qQBQdf9UKN8sXN3qPggMz47aR24SNlZrAFKavvO4kvbf4cRjeAOTUnj5zSElYiNlx3aaSzRv0W4IHLOmtBtxozxSAp1UItaZopKHbFxn0FjTtrICzt9IgoNzx9kHWV+C0ozRvbbGbOuMw4dy0F2G8K3AeRrP9RyeySx4wdwf7yCgUa6pmf9tZ649ntcdxElrb4yCx0H7O3FxhvumM9X/cbtYQa81MhggWwz0b5ssGWpuFZu9F9DcgX+5rZziiMSGQu+q4KdS+7DaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(38070700005)(86362001)(4326008)(2616005)(6512007)(6506007)(316002)(66946007)(110136005)(122000001)(76116006)(91956017)(478600001)(38100700002)(26005)(921005)(66476007)(66446008)(66556008)(71200400001)(8676002)(82960400001)(8936002)(2906002)(5660300002)(4744005)(36756003)(64756008)(6486002)(7416002)(54906003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmJMaXNaTEVHTHFuMUFQWDI5dGx0eURWcGtCWCtDTlh0NkthSm9QUXZTU3hP?=
 =?utf-8?B?RnlVUmw4dmtjQWJkSUZmc211YmxuNDJPZlFlWklrS3Y2U3VEY3BLQ1NqQW9t?=
 =?utf-8?B?TVhybld6eDFvVU5PRGxSZmF1bFdBTnBnL0wzTFZQelE0aXJPQU0xZ0U2Y3Nh?=
 =?utf-8?B?RTZvSUszNkVlSE5xaWswMWxSZ1VQaTBCMkN1SG9RaEc1WHlJR2tQazJpa0ox?=
 =?utf-8?B?dFVON0NsSE0xUkpjbUd6dWV3RzF3eWxYN0pOWUVUS2Z4K0ROOGExNXhrMXlo?=
 =?utf-8?B?c2E3UU9kYXFGMVUyMFF0ZmxIbVI0eXJPOEJIV1pmakZ4RVc0Z1JjTjBoTU15?=
 =?utf-8?B?M05oamdMUVNCb3R2T1NuUm9OM2o1NS93U2Rzcm1SZXNGZWF0dGZFZUNGbWhM?=
 =?utf-8?B?S1dlU0U3YlhIZENLQWhHM1lPYmhuemVqOE81S1R0cjZkWExtSUd4MDUzNklV?=
 =?utf-8?B?c1ljd3U4SGhyV2MraDlZNW5OTmE5MERDVUlMYWJJRnVXTkNZQXkxVTAreGwr?=
 =?utf-8?B?aFZLbVdxNXhKa1lIZkUxUkx1c3ZHV2FvMjIwenBpOXhpTjc5Um9QSU9ZUjBG?=
 =?utf-8?B?NURKakhUWTJtNzV3OWZsc2s4RUxZcEVHSzFXK2ZWNkIvYnVWd0xVTVg5RWt2?=
 =?utf-8?B?ck9rSlFlRVcxTkFDaC9VSnowTENtZ0RiSDhXUXcyc3pmaFUzckQrWmFyeGFI?=
 =?utf-8?B?allFOFloMXNqYWpURTl5QWNZdGVBUmIrNFhzVXQ1R1U4eHkxWEpTbml5eDRO?=
 =?utf-8?B?SEh3Y2o4aUFHcnU1M2szTEYvTUdPQzZIZWlub2VkMURuMk9uR1kvUjNUei9k?=
 =?utf-8?B?YUNFOHJyUUFzRURFVy9TQVpXNmdvTmswSEFTRWhOT1F3RDRscUhvdEpjZ2s0?=
 =?utf-8?B?eHNFT1NaZGdaY1lPSUFqeXJRT1hnYmRQeWVBUG5RY2hkZUtJbEZvaDVOSWpo?=
 =?utf-8?B?U21QWmVnYlo5ZEM4ci9lZURJVVpHTHZScDFPQ3RTNUZaMGIxbWFtOFhqaVdi?=
 =?utf-8?B?ZXl2WGw3OEtneGZDZzhkZWlpWE4yRTlBRldBaFFlRmpCOTZjaXVTbzlSRDMx?=
 =?utf-8?B?cEdac25nYUlseVd5eDN2ZEg1NHRzY3A2Z2ZoZzVxRVpUMW1nVzZkYzU5RmhK?=
 =?utf-8?B?S1IzU1UyVnF6NGtXemdaeDJjZ2RSUU9BQmdocEkzWEJOTWNYdDF6a3ZoejhB?=
 =?utf-8?B?RkVwUUs4NEc4bTFIK0YxQXVldll1T1JxODRDWkVMMW9IMGdTMk9UM1BsVk1F?=
 =?utf-8?B?d3BWUHk5d285NGZDMnVHNURSSW9hbkxUYXNyVU5UTkdseDFLaGtiZVFmWVB0?=
 =?utf-8?B?ajZJM0JrdEg3aFF2Q2g3TWVzWEUvNDlEcTFiNWtaYWdzaENnYmI0QXRjU1p1?=
 =?utf-8?B?NGR3MHNKeE9vZytSVTFWM2syeUwzL0cvbm9HR3VqT29xMWJLUzNUc21wQkMz?=
 =?utf-8?B?bjBKeHZhV2NNK2JZRlI1TEF6L0xjUnUxWjlTcWJhQjU1OUJxcGlJRnB2T2dX?=
 =?utf-8?B?c2xrbGxjMzlWQzhQN0ZtTmgxbGxVT2ErdGp0QmlOLzZySk9QT2tzY2FhMUlT?=
 =?utf-8?B?TFQrZXBKM3k2TEhWM3d2YU95cDA4TFk0N0JqT1RmWDBEcEVOVDhzb3hTME5D?=
 =?utf-8?B?dVQvNy8rZ05LYzBMMVVMdUYrQW9Remc3M3JqeWJ1Rldrb1Q4SGlnRUl6MkpL?=
 =?utf-8?B?U0tOWTVMR0RmYXhTUjI4dzRLMk0vOTdENk4vQXE3S0FYODJhTml4M0JFY1ZE?=
 =?utf-8?B?bWdXSEVYK3BybytWRkl2eEdENHJQZEp1WHNqdDdETWJnN0I3OVRYWmlmU2JQ?=
 =?utf-8?B?STRteVhaM0tuSWJ6dmpaTjIrekpHT0RTOHZQbVFEZHhaQTRMQWRPRmlRRjhj?=
 =?utf-8?B?eHZFMUFNMmsvcDhqdFh6bzdvUkdCYUtzeW9kbmU0MS9GM1puTnB5eVJPdVUv?=
 =?utf-8?B?Q1BKcnQxRG5ULzZJSXJXMGZzMFI5L3p3Yzd5SzhEUVlXYlZKVlY1WGd5WTNF?=
 =?utf-8?B?WE15eHpYMHFETlBmM2R5MjJoQ0NHaHU3azBTbGtkUGNiZWFtQTArMFh1YXlN?=
 =?utf-8?B?ZFdOalYzdDM1WHAxMlkwWDI2TC9CTDBsekFNVnNzNHFxUWJiVzRRL0xHSFNY?=
 =?utf-8?B?c1lMN3BvcnVpODVPdFhVQmE0T0puczIwTUN0N1BlOTJYVlpkSVpTaGFlakdX?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE6341413654C54699EE86A93C53A1E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4847aa-75a6-490c-7321-08dbbf42907b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 10:14:41.5255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Owjrt/htLr1AM4NADTxkDAWPaKp0CK13e5x4g8dBzRmtisugPezhcEZEm63xN6NTwRIgdHogBb4OJ78KaB69Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDIwOjA2IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4uYw0KPiArKysgYi9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L3NneC9tYWluLmMNCj4gQEAgLTI2OCw3ICsyNjgsNiBAQCBzdGF0aWMgdm9pZCBz
Z3hfcmVjbGFpbWVyX3dyaXRlKHN0cnVjdCBzZ3hfZXBjX3BhZ2UgKmVwY19wYWdlLA0KPiDCoAkJ
CWdvdG8gb3V0Ow0KPiDCoA0KPiDCoAkJc2d4X2VuY2xfZXdiKGVuY2wtPnNlY3MuZXBjX3BhZ2Us
ICZzZWNzX2JhY2tpbmcpOw0KPiAtDQo+IMKgCQlzZ3hfZW5jbF9mcmVlX2VwY19wYWdlKGVuY2wt
PnNlY3MuZXBjX3BhZ2UpOw0KPiDCoAkJZW5jbC0+c2Vjcy5lcGNfcGFnZSA9IE5VTEw7DQo+IMKg
DQoNCk5pdDogcGVyaGFwcyB1bmludGVuZGVkIGNoYW5nZS4NCg==
