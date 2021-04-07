Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35B3578A6
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 01:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhDGXuS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Apr 2021 19:50:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:48428 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhDGXuP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 7 Apr 2021 19:50:15 -0400
IronPort-SDR: 28xAqn8aaRDR/yMT9ICIZj+hLGOd2klJaP34cWZVU+egjriEWsqnQB9fil521wpX9xn6ckhkRm
 3WbgiUPTOEpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="257407379"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="257407379"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 16:50:04 -0700
IronPort-SDR: Y0o8EL9cG83F2J96RvIGMEHRr1ZbEfHHSYw7dIClSEnpVaNwxK9JNfRQq5ZhyCnUoAAGzMV9G1
 ixPlHoeOSucA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="380022587"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 07 Apr 2021 16:50:03 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 16:50:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 7 Apr 2021 16:50:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 7 Apr 2021 16:50:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEudpd3t8pGh+FgjXJDOnCkuEqT/DEYGv0qI+RQ6UtDtmtqlyUlqi2u8QgKwgkBAtrO8bLIr2u6n/AvKDSiINT32GpnT8+49IIeeOQQXscRkVYSk742YHjc0A88P92w8vP8fQcI+dr+Gbu+XEqz7rMQZRi43znxPYD5zSfp2SkhErTpxZ092GrPWRg47Qn4A77cn190GX89lUZY6q6WzEJDjAImmPmcaI1AaaqjAB4V9RSQO3vxRrW5Jxs4fwHjmSO3lTPWh+q6CV+TAhihRQyN/obqGZXireOhWHbpZ+/u9lBwRBT6u25R7PKv2tRr6ak7p91BoPoAsuP9fnAc8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72aMzgHYkJPFhSqIJLHWPhwCiZNQvAP+LnWwCgGGmCA=;
 b=lO1gr2cOvnVSefPtiFeNnnqgm7punBn+uR4I6gbwwmGubwAS9Pifp5jAn/R9TBXsUvduAFFflRwCcibonimWaTU482bUDqAr7NwwDTE1vsHGWJsZaBmmyAuiblOlfytVw85x3xzPiTFx1fYZqf8p55NUhUEWn3JVEPsWiDFLCuz/JO8co1iljf0duKRrk60RQe//Ef10x+y8kOP3gy7//lzFpUIzmcQvaq3ZKnroKwBs3EwBerSdwj3qn+s19C6A3tgmi/+2A9qdBA2XgFpUDmZI148peft2z66h6ApXoeQ3i8Oxj1fecVHWbfUlDqFUdMk+hrlj2JCJCKGQMZr/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72aMzgHYkJPFhSqIJLHWPhwCiZNQvAP+LnWwCgGGmCA=;
 b=QZW/6RFpPfezEl8zmRceshOUrJuyQxYoWZg/2LN7fYkqYCW/rmsWiUKla0C5IaYIUFnSjZ4SHzajhZMjCCRvLbmIKUcrKIcqY7j6jYbjSqHryDquTeHbVqMW8NBeAYS6SYQcEsdqKfkUBboqlH56GivGlVYYh7jLB9KUHshG2lM=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5156.namprd11.prod.outlook.com (2603:10b6:303:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 23:50:02 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4020.016; Wed, 7 Apr 2021
 23:50:02 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Li Zefan" <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACABFtkwIAFviUAgAAWTgCAAMF9gIAA2thwgACziQCAAL3IkA==
Date:   Wed, 7 Apr 2021 23:50:02 +0000
Message-ID: <MWHPR11MB1886AEAE97A9E6972C63CACF8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder> <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <MWHPR11MB1886CF7C11ECE0396A0215078C769@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210406123451.GN7405@nvidia.com>
 <MWHPR11MB1886CB8F558C6C17F921F77F8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210407122042.GF7405@nvidia.com>
In-Reply-To: <20210407122042.GF7405@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.88.226.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 484575c9-4941-4cab-1e0e-08d8fa1fdc8a
x-ms-traffictypediagnostic: CO1PR11MB5156:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB5156A1399A3ECD1E8660BB2C8C759@CO1PR11MB5156.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PE9TasX8J/zvcgBQgToRlduqPOAAq6uB5tcQO0CLEX/vOqRN0Rj4LozcpTjYV+domuaOHb+B6JNkTRShXN3SSzkeYr829SeyNunHJUwKfzeKChSlw5ExRuHInCOR4YcFZnAGTJliJjdXqZwXN2AHxt4wvyof55Q4NcnN3m62WAC08Voevb5f3M4/V4UV+VMEU6xlBDW5QAYm8En97c5wg7IeWEvgQsxbWFWX/5n5yNLykjlFLFtpRf4VIymax3I3Fdi8H4FLSdE71zDLRN/j4ofXNTqHIiGaZynWp2CteBGmT87a7nBuoUeNpLgdJ2eDOiwrAAz/le0lGa+cqgfI8QjfPQwLNFclQ8XUljdds/XPcopev3/J01B++z3z5KLkF65MOxeSTZmeQX9KbLTr/D0aaOW5Uh2HdV/iLRuiAbt3LPF2xmbRKTD0dHDY4sveKtK+HSgwqEj6Qb6KSbowMw/KNMKcel0fughSxRkBmXcrZdwqEtaCTC/qFGQdxYL9/vxHBQ6QTudK1ecBEhg44o2XUcWFHgjmUTEAs/qkw6d4JbXaEuTIPgcrK89G8Wxr7cfBckNPgMLb2UJF/lVluA0eYAmueM7Y4axOdTpV+sygX1BGBwwd3hQuLRVMK4eJxAc06eNVi3AELIJvAGp6Rs7wIj7w6Mhx+utVYfOnVqs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(136003)(346002)(396003)(38100700001)(54906003)(316002)(83380400001)(8936002)(66946007)(4326008)(52536014)(86362001)(5660300002)(55016002)(8676002)(71200400001)(76116006)(9686003)(26005)(7416002)(186003)(64756008)(33656002)(66476007)(66446008)(2906002)(478600001)(66556008)(6916009)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SHJQYjhvWmVhaG1Yc2ZQVUwzQTNnRE9uTnFlcXdsSTVhTG5KL2VHejVVeE9J?=
 =?utf-8?B?UlJER2lSbndIbWhlbEpwOXRmMHlIdWJxWE80MjhJV0c1amNtZi9PTnJpaUpq?=
 =?utf-8?B?L0JWWm9aMEFlV2hqMjNpMUk0WlJ4UjFOS3NDaW9uank3Y0txd0dyUzVReVM4?=
 =?utf-8?B?V1FxV29xbXYwYTVVb1BCTVZBMGVyb0R0dnIrSFRsR3hselB4dDl6MDdad3ZV?=
 =?utf-8?B?MTJaTlJTMW40T1ZMNHoxd1ExOHU4Q2RCNXY2ZlNwbkxGY0M3K0FHYkN4MHVT?=
 =?utf-8?B?Q1FmRDFac0hUblNTUVdlaHZhRHdSaklvWC9TeFdvaTdqUnhuM216ZDVDTzAx?=
 =?utf-8?B?Vkhtb05yV2pYY09kWXIrRW5pNGtQQ1FVWG1Ndktsem5ibWVLRUlCVXJMT09X?=
 =?utf-8?B?NlErWnR4R3o2b3R3UnRNRCtBYngrM1pkbkkvL3FRckVieW5kUFhDeEZNVVRz?=
 =?utf-8?B?S0VXcWpkV2I5RVlaeWdINGsxVFlUN1FBZU1aaXUvLy9GbWhtVTNXMHBzTWoy?=
 =?utf-8?B?S2tiQXYwTC96NkFuQ3Q1ejJ6cFJTenpiT1o0MlU3eWNleXN1aGVzTVdKUmEr?=
 =?utf-8?B?OHFtb1FiejdiRXZ6Wk9mOXRCOVlHTWF6SUdDTFlKYktRYjROMHBkVGJsUW9o?=
 =?utf-8?B?Ly8wTHdOS1Y1bk5DeHVpVzJ1Z1BHVTN3Y2ZDbkx6a1QrWEhGRnlnZVY5b0g5?=
 =?utf-8?B?WENqNDhlVnZOUjN3aXlsd2o2UmZkRVNwWXVtdWY5d2EwZCtSNlg3V3RFeFc4?=
 =?utf-8?B?TS9RTDdZcGFLS04zYmtGLzFEa1VsUExjNjNZMGZLSGVCWmtwS2QrZW1wTFdl?=
 =?utf-8?B?bkNkWGdVRzlQY2loMVF6NzZpOHJjUzBkZ2twT0JmT3NSRCtzeWtmdVZ2NXpB?=
 =?utf-8?B?VlNTSU5NRXdxSVZ5b2hsTkVMRlJuRXgzWVc5dFlDSG9uSWRsM2pTdFJGa2dR?=
 =?utf-8?B?S3JqaGYvcG9ZZ2lLR3FXNDJPZ3I4TEx4bkJpOU1MNmpSS0piNnE0a1pBbHJ0?=
 =?utf-8?B?MW96Y3d6Y1VjUUthMGNqZFFROUZQcEJNSTFCZFNSVVYrRUtnbTdINVR4WHU3?=
 =?utf-8?B?Z3lIcWtLTVZjV01QSUhHay9YTFQ4SGV3WTV5b2hqOGlxY2pQZ0RwTS9sbWtU?=
 =?utf-8?B?bWdkUmJKRmZXTGtWWmxlbmFvNEhrY2xxZW9oWTh3cDg5bHNnRDRwUEVIMnk5?=
 =?utf-8?B?bzcxMjZhYUNXVDZRcGFZOVlsdURqZ3dtUUgzdjZuM1B1N1pOL1R4K05tWFJy?=
 =?utf-8?B?RzRIa2tGWWxHeHpPL0ZQWFdqV1ljMVlIZk5CTm5FTE1WeEoyRHpJY1JjZnEy?=
 =?utf-8?B?S0FvOWdhd2ZkUDFadVZiejErUWRxREpWZ1MrTWIxMUFKU1A4SGpYeWNEUDV6?=
 =?utf-8?B?d0IwcTdHZ3Z5L0JjZ0NNV080MVk1N2hNRW1tVlJ5TzhqZVU0YVM2SGxwMUt6?=
 =?utf-8?B?SWxzc2EwNW12MEk1SDZHR3J6cmpSTzVWa2J6NkN1UFdxVStNR3diZGtOeTRl?=
 =?utf-8?B?T3dNVmlQbktXYjRXd2ZaRE5UV1duVi9udkJEckZhWHA3dkZXeEdYRk8xTWs0?=
 =?utf-8?B?UXFUZjg1Sk5pVXFLcHNpZStGc3RYZGMxcVBBam51ZjN1N2lwS2hhejQ3WGI1?=
 =?utf-8?B?UGFEWGpDU1JYT2xLNUNnazl0cHc2cEswNExkQTF2a2RFU0hTa1V2L1lDMVlj?=
 =?utf-8?B?MVVLQlE0UEs0YzFsVkw5enI1eVBDWjU3enVoTGxhMUJrSWNVUmg1dUFyYnJI?=
 =?utf-8?Q?p8EWhpAjIipBc+QhrmnNWpd/szG1fccrt6KxuLC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484575c9-4941-4cab-1e0e-08d8fa1fdc8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 23:50:02.2355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+yYQxRIZX74ev/9CFpb+d2VHm8eCdqrBhP37d4SLamRIHeomrjZrRKLGFo2FRyXa+xS+6uTbpGn/Tzj2AUHqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5156
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEFwcmlsIDcsIDIwMjEgODoyMSBQTQ0KPiANCj4gT24gV2VkLCBBcHIgMDcsIDIwMjEgYXQg
MDI6MDg6MzNBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+IA0KPiA+ID4gQmVjYXVzZSBp
ZiB5b3UgZG9uJ3QgdGhlbiB3ZSBlbnRlciBpbnNhbmUgd29ybGQgd2hlcmUgYSBQQVNJRCBpcyBi
ZWluZw0KPiA+ID4gY3JlYXRlZCB1bmRlciAvZGV2L2lvYXNpZCBidXQgaXRzIHRyYW5zbGF0aW9u
IHBhdGggZmxvd3MgdGhyb3VnaCBzZXR1cA0KPiA+ID4gZG9uZSBieSBWRklPIGFuZCB0aGUgd2hv
bGUgdXNlciBBUEkgYmVjb21lcyBhbiBpbmNvbXByZWhlbnNpYmxlDQo+IG1lc3MuDQo+ID4gPg0K
PiA+ID4gSG93IHdpbGwgeW91IGV2ZW4gYXNzb2NpYXRlIHRoZSBQQVNJRCB3aXRoIHRoZSBvdGhl
ciB0cmFuc2xhdGlvbj8/DQo+ID4NCj4gPiBQQVNJRCBpcyBhdHRhY2hlZCB0byBhIHNwZWNpZmlj
IGlvbW11IGRvbWFpbiAoY3JlYXRlZCBieSBWRklPL1ZEUEEpLA0KPiB3aGljaA0KPiA+IGhhcyBH
UEEtPkhQQSBtYXBwaW5ncyBhbHJlYWR5IGNvbmZpZ3VyZWQuIElmIHdlIHZpZXcgdGhhdCBtYXBw
aW5nIGFzIGFuDQo+ID4gYXR0cmlidXRlIG9mIHRoZSBpb21tdSBkb21haW4sIGl0J3MgcmVhc29u
YWJsZSB0byBoYXZlIHRoZSB1c2Vyc3BhY2UtDQo+IGJvdW5kDQo+ID4gcGd0YWJsZSB0aHJvdWdo
IC9kZXYvaW9hc2lkIHRvIG5lc3Qgb24gaXQuDQo+IA0KPiBBIHVzZXIgY29udHJvbGxlZCBwYWdl
IHRhYmxlIHNob3VsZCBhYnNvbHV0ZWx5IG5vdCBiZSBhbiBhdHRyaWJ1dGUgb2YNCj4gYSBoaWRk
ZW4ga2VybmVsIG9iamVjdCwgbm9yIHNob3VsZCB0d28gcGFydHMgb2YgdGhlIGtlcm5lbCBzaWxl
bnRseQ0KPiBjb25uZWN0IHRvIGVhY2ggb3RoZXIgdmlhIGEgaGlkZGVuIGludGVybmFsIG9iamVj
dHMgbGlrZSB0aGlzLg0KPiANCj4gU2VjdXJpdHkgaXMgaW1wb3J0YW50IC0gdGhlIGtpbmQgb2Yg
Y29ubmVjdGlvbiBtdXN0IHVzZSBzb21lIGV4cGxpY2l0DQo+IEZEIGF1dGhvcml6YXRpb24gdG8g
YWNjZXNzIHNoYXJlZCBvYmplY3RzLCBub3QgYmUgbWFkZSBpbXBsaWNpdCENCj4gDQo+IElNSE8g
dGhpcyBkaXJlY3Rpb24gaXMgYSBkZWFkIGVuZCBmb3IgdGhpcyByZWFzb24uDQo+IA0KDQpDb3Vs
ZCB5b3UgZWxhYm9yYXRlIHdoYXQgZXhhY3Qgc2VjdXJpdHkgcHJvYmxlbSBpcyBicm91Z2h0IHdp
dGggdGhpcyANCmFwcHJvYWNoPyBJc24ndCBBTExPV19QQVNJRCB0aGUgYXV0aG9yaXphdGlvbiBp
bnRlcmZhY2UgZm9yIHRoZSANCmNvbm5lY3Rpb24/DQoNCkJhc2VkIG9uIGFsbCB5b3VyIHJlcGxp
ZXMgbm93IEkgc2VlIHdoYXQgeW91IGFjdHVhbGx5IHdhbnQgaXMgZ2VuZXJhbGl6aW5nDQphbGwg
SU9NTVUgcmVsYXRlZCBzdHVmZiB0aHJvdWdoIC9kZXYvaW9hc2lkIChzb3J0IG9mIC9kZXYvaW9t
bXUpLCB3aGljaA0KcmVxdWlyZXMgZmFjdG9yaW5nIG91dCB0aGUgdmZpb19pb21tdV90eXBlMSBp
bnRvIHRoZSBnZW5lcmFsIHBhcnQuIFRoaXMgaXMNCmEgaHVnZSB3b3JrLg0KDQpJcyBpdCByZWFs
bHkgdGhlIG9ubHkgcHJhY3RpY2UgaW4gTGludXggdGhhdCBhbnkgbmV3IGZlYXR1cmUgaGFzIHRv
IGJlDQpibG9ja2VkIGFzIGxvbmcgYXMgYSByZWZhY3RvcmluZyB3b3JrIGlzIGlkZW50aWZpZWQ/
IERvbid0IHBlb3BsZSBhY2NlcHQNCmFueSBiYWxhbmNlIGJldHdlZW4gZW5hYmxpbmcgbmV3IGZl
YXR1cmVzIGFuZCBjb21wbGV0aW5nIHJlZmFjdG9yaW5nDQp3b3JrIHRocm91Z2ggYSBzdGFnaW5n
IGFwcHJvYWNoLCBhcyBsb25nIGFzIHdlIGRvbid0IGludHJvZHVjZSBhbiB1QVBJDQpzcGVjaWZp
Y2FsbHkgZm9yIHRoZSBzdGFnaW5nIHB1cnBvc2U/IOKYuQ0KDQpUaGFua3MNCktldmluDQo=
