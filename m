Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FF17A01BD
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 12:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbjINKdM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 06:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjINKdK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 06:33:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA51BEB;
        Thu, 14 Sep 2023 03:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694687586; x=1726223586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2Owvua4yneqVHPmYiEmZQcd+wgUKZQ+AJl+tMK9s4wY=;
  b=W3c6CtIlNLlkb4K9Ke+E4b20+HnH0R3l1IfyAqS3SWKys3WFieS/MXcM
   P8kC1VgrNC7QT+jzWfsAhMs44c+yAquwkxc2w6aI9eS0OG9bPS+Misewh
   qWx08Z1HwDEC9LttP4wihMyLedWlTlovxjHz4UIzu0c5yibiJzOgPJ7s1
   Q8Az0xG848rokpMsq0sOxm1k1AT1HREv8HbDJu6z14lYB2yAHrLRoqx7f
   7FKNP79Z6cXr0Aw4FXv8sNY3LHDbHKXyx6iU+EOMtafP4XMIGHP7AczT3
   kw7WfqRQoBJdhtuijasVPv4HTzxUFGCmdEM7/fFFBNYsJGMS0+f22Ld0T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="445337292"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="445337292"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 03:33:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="810009018"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="810009018"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 03:31:32 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 03:31:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 03:31:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 03:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyvkmKALv9JynRxROrvo9Lc7ZbFgM/e4x90QW3jfX0UBkZ1GoPUk9Ptg2VPpOhwjEEu/CYNbDDbhkOs/iT2myl9FBcTBj0yVKLJqUw0kQmT/7tPmtUs9CVBijNsNq8bZgRdh6js6dgnNKb5WekyYnXYFojLhCquEHUJrlPV1C+7hm+5KDiMLhkbDnZFzq735jjguFL3YJsqWZ48ZwOpP/zfB1fu5RvHNSAnVOlR1iLRuDpQ21D9b1mTqEGdY86Au42yOBSdxPAQqYiM/X5jKO3yRBZ3yfhRFzmaJXMkiTvlbPdAQpyyVXuSZqlJqmVWPFp8/hj66fEEhwkps1KncDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Owvua4yneqVHPmYiEmZQcd+wgUKZQ+AJl+tMK9s4wY=;
 b=Mjxv/WbVXJTMuZuXzNkLCNJrmrqPZjd/zO+5Uqn9PLzuMmTEHbWjJAFrsUCxcwlRXfNlal3PUo4RHO+pGt5ZWC55+Qq/tENSgZSmOH9eVweeEMH0K5nDIzIFDzMbOmWMJVQJUV6B0txa0z7ebAZTXXe3i5FsWKipUZAIU6M0nWc5gWpFqb5IQxXZGAnqETGyO5QafzGcfRNBGAJpexWMtsffGAEQB6psMujoYL9e4YpIzQ18KiIFhynCmyVmiWr8PKuzLPzI4zdwVS5xyqOgl7qQoI/oXyDDOLxcLvk5AGdiQDUYoDZbIPM9qqkmRgnrB+2CDUKVS08bCmaLZ/hFZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4543.namprd11.prod.outlook.com (2603:10b6:806:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 10:31:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6768.036; Thu, 14 Sep 2023
 10:31:30 +0000
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
Subject: Re: [PATCH v4 03/18] x86/sgx: Add sgx_epc_lru_lists to encapsulate
 LRU lists
Thread-Topic: [PATCH v4 03/18] x86/sgx: Add sgx_epc_lru_lists to encapsulate
 LRU lists
Thread-Index: AQHZ5fiVZxBqcFwEwk2nCHykoP0dm7AaIUsA
Date:   Thu, 14 Sep 2023 10:31:30 +0000
Message-ID: <851f9b3043732c17cd8f86a77ccee0b7c6caa22f.camel@intel.com>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
         <20230913040635.28815-4-haitao.huang@linux.intel.com>
In-Reply-To: <20230913040635.28815-4-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA0PR11MB4543:EE_
x-ms-office365-filtering-correlation-id: f55a6621-b761-4574-aa2c-08dbb50dc286
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJwT9eTK1WL12IBHoKC6+bGp2cpV4VAulJkavrUZouAFMtOGPZe2YJTyyYO1rKh0A6OnBIAL3NndPMKqT1JUiedkZrJiltFHYyVOeJae0xunc52WOa0J7DjI6UDDO8iWp5EQ1h9ezB/i+8zWlRal9c3PhYSsTTeaHxCwO0xs2d8xoQXzmu28kes3mzPxB12JoguTsUatH/r+owv+OIxG1xivUKUzzq89FSJxcY7H0OrVHMNLc36MOnXP+GSMq8fZT2LG75W6VXredU8XTe0aFXoEESiM1m94UQySpQ4uj4NOuJLH/jjZScFltbu0y8PoNkPnNAUvZVYFxCnuF1VyR2BbCVM8N1pTkuNjxep0W68N8EmUGcWBQ3Dikj40GNawl1N7ojE4zRBsUi2X0gyvS+4R6odW8vQJ89Ws18rmMMmc1mjxbBzr/Fco8/XqoRP5eaiPdeVt9oOesGZUQpVLDsHuPff4TaC/7tJRHPRUG+15w0kwEISG89l27rnvMKR5rCisFbTZo7ar8c39Isi2ySdlZ0Lj8wWnakZGLhsrSc8w2KZK+8y2Yeu3pmCgiKabaEioujSrshE88hHutWhyO72sj1EgT64hNtOwDoUl6NjvbzG8qc/ZCas4FNGbdet/GRe1HNxbIKWRirBLFqHL4B25cN9u34/mUveWlhAEsbQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(66899024)(2906002)(6512007)(966005)(86362001)(26005)(2616005)(36756003)(478600001)(6506007)(71200400001)(6486002)(83380400001)(38100700002)(38070700005)(122000001)(82960400001)(921005)(7416002)(41300700001)(91956017)(8936002)(8676002)(4326008)(5660300002)(54906003)(316002)(66446008)(76116006)(64756008)(66556008)(66476007)(66946007)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW1OemV5N0Q3bVJnMUxCYkpjN2x4UnlaVG1FRmkwaGdHc1RueDBGNmNZRktk?=
 =?utf-8?B?dEpWNGFkYlVQUW16Qk10OU5zMTdYUUpvMFdyb3I1UzJ5RVoyQzY2Sk1sS096?=
 =?utf-8?B?M1ZpYlF4NE4xTnNzQ2prNkRLcnQrQ2Evei82ZDhLZWxYYXltV0piYUtoa1p5?=
 =?utf-8?B?VGswK3JkSlZSb0pUQlVmdWw1U29rQ2sxREtPT2xoYjJaM3NuUU1XckVTaG9v?=
 =?utf-8?B?YTNIY3p1NlM0MmdmOVNRUlBOTHNkUmNMSzkzcnhKaUltamRXcENtRlpSYnFa?=
 =?utf-8?B?U0ovbEU2MjF3Y1lmQ3JnbUdPRTIvZFk1NDJHU0RrQmMybmIxQ2lBbEVnVFZy?=
 =?utf-8?B?UzJiblgwVjI0OVlZOEJjUnJsSWNVUmNZVk5jTm44UzljbDNtcFYwKy9uMjBQ?=
 =?utf-8?B?OG5RMmo1WkNpLzIzcW5lSEVVbHFTSVJHOFNEK1dzMnd5TU5vRHc4VHJ0NHVn?=
 =?utf-8?B?TEJMak5Vb3VkanA0RWhhdlZrRXZ0ek10azVoTzVFUXp5OEhscDVGREQ3MDVn?=
 =?utf-8?B?SVc3QnlPVkxjUU4rYnVPckFuNjQwbTNJV29XZnRadEEzbWFvcFFySG0rTThC?=
 =?utf-8?B?Rm8yN3ZtMkVQQThzaWkzSWh3L1QyclY1VVBLZi9sZ2VyL1Rtd1h6NHF2a3U2?=
 =?utf-8?B?dmpXd3pqS2ZrS2FHS2hST0U3aFJNVUNXUVRYbHhUd2lIVlZ5ZStGMHJMNEN5?=
 =?utf-8?B?REZpTWZrWXRuMjVSYis5dG02NDVWU09pdXIra2xsU0tQZ3pUOWN3MWJ3OGk3?=
 =?utf-8?B?eitEK01sdXorUytOdE9ISVRRcEVBMDYxWHBKT21GOS9ibStaSUlpeVkweU9C?=
 =?utf-8?B?YVlremUyRmhueUpPQThWVGptQjEvMTE2azE1RXcrelkvb3paV2RzTk1VMjlx?=
 =?utf-8?B?YWIrTXpva1NUMHlBVGdIUEVMbjdCZnlMY3Ira2YrUyt6Lzc5SGVPK0ZZQUh4?=
 =?utf-8?B?YTZDd0xnSDZIa3JCWG8wbkZONDI3L3VBYkJMTWh4WGFOMnBKUWhJS010UmlH?=
 =?utf-8?B?Y1JBT3krVnVsazRtR04vWk8waFpRU0phUTBMQk9mTWxWUGF6aDRzNk9HTFBl?=
 =?utf-8?B?UTdFd3EyUmljRkVrSlFuYlZjWnVBaTROR3BrZWlGTlg5T04zM0ZheC9RRUx0?=
 =?utf-8?B?OVd2eFR5ZnV4Z3pUTEdCTWxpQnJtN0w5MDlqbWQ1Y214NUdkNHdBM1dJTjBp?=
 =?utf-8?B?UnpCTlFBSTUveXMyUjQ1ZFJvT1A0Q0lkdHR1VnVOa0huVkhZV1JCY29IeXpZ?=
 =?utf-8?B?dGZVd2JKYUFMVDBkYzk5Mktad3oya2lCaE1LZm1ZU3luNDNqc1NuWnMrZ1hk?=
 =?utf-8?B?aVhuVEZ2TUFvK1RpaTV3SUM1b3FVNXJ0ZXpwMi93MmcvbjJndFQvMEVFZnk3?=
 =?utf-8?B?Qnl0Wm1OMXE5aGpZMUJrYlpjdE9neUgxUUdiNmpxbUN5d1VwUFM1c1hWMkFG?=
 =?utf-8?B?dGoyQzVKSzFzUm5oRzBZeEpLRnhtRFFZcUNHeWg4WTZVUmFCVkdNMlEyS0xK?=
 =?utf-8?B?blhpZDNhdVoySGY2Vi92RkZpeTdoODVHbW5TcEZUZmdjcmUzdm5YNFAvQ0xF?=
 =?utf-8?B?Z0pmZ2hDWHI1OVB1ejUrWlg2alRHb1RMYzM5cjV3d0hzTGM2dXlLeXhkdkZG?=
 =?utf-8?B?YzIrSVVXbFNGT0laOVYvMW41bjlqWlBTdnZHR0YrMTVTT3dvV1F6ZFJxR1Ux?=
 =?utf-8?B?VHJxMTRmbVVxL1RoUEQzeHJ3bXhDc01MRzNWamNkdk9Ub0g4SEhqMVFGRm82?=
 =?utf-8?B?dTlFTnlOS053RGRYSnZKTEgyRU5TU1RiNjZqOHUrcEtKNkhkeCtaNzFJRzRj?=
 =?utf-8?B?OFlxK2Y3VDlVQ2dDL1FyckkrTTQzc21VcFFrRUNCbjBrVjA5VG04aVZRUGF2?=
 =?utf-8?B?Q2ZWQnRWajdIS2VVUklKZ1RDNTJxejdJS3d4QlhQVTBlVUFpVVBaR3o2dXky?=
 =?utf-8?B?YXhXWGt2c2N3SzlOWlk5cXdrRHhmb3BKV1RiU2loUDF6OEtwSHZaa3lwZ2ti?=
 =?utf-8?B?aCtIejZ4VmVLRXJza24rT1VwMlhoK3F1ZHRJNmlLYUM3Vy9VKyticSs1azUy?=
 =?utf-8?B?dlArNk5TdHFQWGNJWUZNMUNKMElvWEZHRGRLVEVpUjBxVmZOdVRiR2RpVGlZ?=
 =?utf-8?B?clpkeWxoM05iSlpnb3NsNHNQMCszYk5EWUZkWENEV0dJeFZsY0pTMU9vcmor?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C14CE13B6833DC4AB8BF7D824DC048CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55a6621-b761-4574-aa2c-08dbb50dc286
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 10:31:30.5378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +S0LLx0vEou83RSW+QnKiLOGuaMJwe85vKwq6IF/kKztvP9a/SU4uDTW8bW4TFRT1RahZLZxgFbj31e9Hv4d6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4543
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

U29tZSBub24tdGVjaG5pY2FsIHN0YWZmOg0KDQpPbiBUdWUsIDIwMjMtMDktMTIgYXQgMjE6MDYg
LTA3MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gRnJvbTogS3Jpc3RlbiBDYXJsc29uIEFjY2Fy
ZGkgPGtyaXN0ZW5AbGludXguaW50ZWwuY29tPg0KDQpUaGUgcGF0Y2ggd2FzIGZyb20gS3Jpc3Rl
biwgYnV0IC4uLg0KDQo+IA0KPiBJbnRyb2R1Y2UgYSBkYXRhIHN0cnVjdHVyZSB0byB3cmFwIHRo
ZSBleGlzdGluZyByZWNsYWltYWJsZSBsaXN0IGFuZCBpdHMNCj4gc3BpbmxvY2suIEVhY2ggY2dy
b3VwIGxhdGVyIHdpbGwgaGF2ZSBvbmUgaW5zdGFuY2Ugb2YgdGhpcyBzdHJ1Y3R1cmUgdG8NCj4g
dHJhY2sgRVBDIHBhZ2VzIGFsbG9jYXRlZCBmb3IgcHJvY2Vzc2VzIGFzc29jaWF0ZWQgd2l0aCB0
aGUgc2FtZSBjZ3JvdXAuDQo+IEp1c3QgbGlrZSB0aGUgZ2xvYmFsIFNHWCByZWNsYWltZXIgKGtz
Z3hkKSwgYW4gRVBDIGNncm91cCByZWNsYWltcyBwYWdlcw0KPiBmcm9tIHRoZSByZWNsYWltYWJs
ZSBsaXN0IGluIHRoaXMgc3RydWN0dXJlIHdoZW4gaXRzIHVzYWdlIHJlYWNoZXMgbmVhcg0KPiBp
dHMgbGltaXQuDQo+IA0KPiBDdXJyZW50bHksIGtzZ3hkIGRvZXMgbm90IHRyYWNrIHRoZSBWQSwg
U0VDUyBwYWdlcy4gVGhleSBhcmUgY29uc2lkZXJlZA0KPiBhcyAndW5yZWNsYWltYWJsZScgcGFn
ZXMgdGhhdCBhcmUgb25seSBkZWFsbG9jYXRlZCB3aGVuIHRoZWlyIHJlc3BlY3RpdmUNCj4gb3du
aW5nIGVuY2xhdmVzIGFyZSBkZXN0cm95ZWQgYW5kIGFsbCBhc3NvY2lhdGVkIHJlc291cmNlcyBy
ZWxlYXNlZC4NCj4gDQo+IFdoZW4gYW4gRVBDIGNncm91cCBjYW4gbm90IHJlY2xhaW0gYW55IG1v
cmUgcmVjbGFpbWFibGUgRVBDIHBhZ2VzIHRvDQo+IHJlZHVjZSBpdHMgdXNhZ2UgYmVsb3cgaXRz
IGxpbWl0LCB0aGUgY2dyb3VwIG11c3QgYWxzbyByZWNsYWltIHRob3NlDQo+IHVucmVjbGFpbWFi
bGVzIGJ5IGtpbGxpbmcgdGhlaXIgb3duaW5nIGVuY2xhdmVzLiBUaGUgVkEgYW5kIFNFQ1MgcGFn
ZXMNCj4gbGF0ZXIgYXJlIGFsc28gdHJhY2tlZCBpbiBhbiAndW5yZWNsYWltYWJsZScgbGlzdCBh
ZGRlZCB0byB0aGlzIHN0cnVjdHVyZQ0KPiB0byBzdXBwb3J0IHRoaXMgT09NIGtpbGxpbmcgb2Yg
ZW5jbGF2ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFu
LmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBLcmlzdGVuIENh
cmxzb24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5pbnRlbC5jb20+DQoNCi4uLiBpdCB3YXMgZmly
c3RseSBzaWduZWQgYnkgU2VhbiBhbmQgdGhlbiBLcmlzdGVuLCB3aGljaCBkb2Vzbid0IHNvdW5k
IHJpZ2h0Lg0KDQpJZiB0aGUgcGF0Y2ggd2FzIGZyb20gS3Jpc3RlbiwgdGhlbiBlaXRoZXIgU2Vh
bidzIFNvQiBzaG91bGQgY29tZSBhZnRlcg0KS3Jpc3RlbidzICh3aGljaCBtZWFucyBTZWFuIHRv
b2sgS3Jpc3RlbidzIHBhdGNoIGFuZCBzaWduZWQgaXQpLCBvciB5b3UgbmVlZCB0bw0KaGF2ZSBh
IENvLWRldmVsb3BlZC1ieSB0YWcgZm9yIFNlYW4gcmlnaHQgYmVmb3JlIGhpcyBTb0IgKHdoaWNo
IGluZGljYXRlcyBTZWFuDQpwYXJ0aWNpcGF0ZWQgaW4gdGhlIGRldmVsb3BtZW50IG9mIHRoZSBw
YXRjaCBidXQgbGlrZWx5IGhlIHdhc24ndCB0aGUgbWFpbg0KZGV2ZWxvcGVyKS4NCg0KQnV0IEkg
X2d1ZXNzXyB0aGUgcGF0Y2ggd2FzIGp1c3QgZnJvbSBTZWFuLg0KDQo+IFNpZ25lZC1vZmYtYnk6
IEhhaXRhbyBIdWFuZyA8aGFpdGFvLmh1YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IFNlYW4g
Q2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KDQpZb3UgZG9uJ3QgbmVlZCAnQ2M6
JyBTZWFuIGlmIHRoZSBwYXRjaCBoYXMgU2VhbidzIFNvQi4NCg0KTW9yZSBpbmZvcm1hdGlvbiBw
bGVhc2UgcmVmZXIgdG8gIldoZW4gdG8gdXNlIEFja2VkLWJ5OiwgQ2M6LCBhbmQgQ28tZGV2ZWxv
cGVkLQ0KYnkiIHNlY3Rpb24gaGVyZTrCoA0KDQpodHRwczovL2RvY3Mua2VybmVsLm9yZy9wcm9j
ZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sDQoNCkFsc28gYW4gZXhwbGFuYXRpb24gb2Ygd2hl
biB0byB1c2UgJ0NjOicgZnJvbSBTZWFuIChpZ25vcmUgdGVjaG5pY2FsIHN0YWZmKToNCg0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9aT1p0ZU94SnZxOXY2MDlHQGdvb2dsZS5jb20vDQoN
CihBbmQgcGxlYXNlIGNoZWNrIG90aGVyIHBhdGNoZXMgdG9vLikNCg0KDQo=
