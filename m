Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A97BF0B3
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 04:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjJJCMm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 22:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441818AbjJJCMl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 22:12:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BA9A4;
        Mon,  9 Oct 2023 19:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696903959; x=1728439959;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=762sOdgdgcnEFHEJgaY5QkxzD8ut8shi4OVLiFbABxk=;
  b=cx4UdtNHBCulFSH6TeOovc1T9y5PEOTOY+/1l3DOB1h9eTUlMzqi3NK7
   amOl95bo8rQhirssmqRi46S2PFJZ4S+n2mgc14WVVIGRnN3f5pq/2A9/Z
   mynh76hviG4tVrZpjuENW8lQYMiC9gWJlZsNFDg63zhrxRBekQPpuJFbJ
   QlxaTCfcAJ+eZf2vBJv17JF6O2LACaQlVOqc6sDhDAwuZ2yJut+yCdKg5
   155AE5c45OSPNRHaCdHL9rMOcLcoisGUS0yisCMLi/sRzje8UjepYAg4U
   2UZ7BJsPkbC0sBU+iavW3E3sfS/ltYZopvaP20897FGm1hE24rAIX8Cb9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374635938"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="374635938"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 19:12:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="896986649"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="896986649"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 19:10:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 19:12:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 19:12:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 19:12:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 19:12:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hosW19tkKHKfg0dRnD8qr6KGFbdGF1kvAK2L0+TBIpiXGG7Nritucvqi/MSJcLGUNFOHa/vQv/sKDos7y4W4mOW1I3zlpjG26nyhEL9a53PDcuENPrtIGaT8gRkKy+/q08nmpRoHugL8+2HzUwDbHnG6xECKK7vpb6cLIRb8t5rxSgsPhj58CTp+92q1CA6T3kmGSs3Q4TOBhtLki+03X+P3l6ng39RGAHhQ7IFV5BXJJ4aI5GyG3Y6dZi0IQcrAj+8NwjQbd/9VAiSlD+d9JI5ORJPC/IVdFjuxpvzwv36PJDbpWahAYfufCSJdeIcLHncDqmSbmdwpN88L0WsF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=762sOdgdgcnEFHEJgaY5QkxzD8ut8shi4OVLiFbABxk=;
 b=OX/eVMJQ8Fh38vP1NiUTRuBqPYFlXDH4DcSMugTpOIYmZcP0VyaYMlyIG10NQf8rI8DIyzb8QpYel48PyyK/6GHxPLbQEq8D7AQAgvVC4OpdSshAKPNawFbDnzgE0bV9pwNQZ4tlsTy5wUS5O/SPy3LfcndGRjtROM2YqxP7x6KMp9CaI/tGzapTPZM+4Z0FA3KshnXPwqzthm7zapadh5EmocNz4sc9x/k7ynMn5X2wxKFbmIRU9wh9qtVPDVZsZaTV3mjyQag0XURo+C9zNNPc+KtN9Aus6YJYXUBZqiMsosyq/DRJl7kFl+oaljk1t6TTKgj5aacN52pO7XwOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB4780.namprd11.prod.outlook.com (2603:10b6:806:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 02:12:27 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 02:12:27 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "tj@kernel.org" <tj@kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Topic: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Index: AQHZ7csZABE+dkJZZkCdCB4gngYcNbBCOacAgAAWUQCAAAOmAIAABagAgAAJjYA=
Date:   Tue, 10 Oct 2023 02:12:27 +0000
Message-ID: <badbe0da60a2b35e8eace98714c6f7d4bcd6f202.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-13-haitao.huang@linux.intel.com>
         <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
         <op.2ckqmgs9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <fc6aa778ddbde9536cafe48b847cf6c45b640ea4.camel@intel.com>
         <op.2ckr5yetwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2ckr5yetwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB4780:EE_
x-ms-office365-filtering-correlation-id: 9d2425f4-08e2-41c2-8a3c-08dbc93659ad
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yuFIMU1fJ6iHJnia8Z2TGcd0HiXhw5CjcB9K7cnDHg6SYf+ZQqRm2vQx4gb/3Q8WWnl6mDsf4eFO/GuPp+xbWUVtpA5EVL8ONKnB6uQ7sEWVEuV30wW0Esqq28e2WpZNZaIU6ZQXoYZ8CmH0eYTM4DDG60lr1NQUe3Qvj9bdbUogx+O2akS2qmI8qxRL2dbe6OfrE3L234LNkEEWbDPcKsetSYP/WnjUNKa0hxkU0EB9wsB4K+UlsvN45/sdhPK59yV5GB8CFu2WAFE0f2QuygXLFj4APgj7i4MV0vv21Q0vDndXndTwzJwaX6k8V7QCP24IFvgGVYmFw/HZ4mmeMJfd8wKDUQjmGoDBGFHvPvrstkDRsNBaX3ScjllMYFArz7NgQM15mTs5PX0FN14hsYpR9AKSAf8TUa0QY2/79nPLuyyJ5NVK5Ym7naz+gk2PzkY3LPeWL4oW6zQvFDA34AcKAe4piM3Fe1c5o7i/2CvWxhfT/XTNgXKcardSLoNDe6u81lxwHB4kg0YJyv6I6nVXLelkw2j08P6umNRMJk3gMySI+nX6/OZXkqQ0fCzZ0XrQHlQVP7q2Ev0gVsVoHJtlJrvxxSx5shaYp0NK+hwv226z57CP7nisbZlC+3P9GKIEiSCFztHf4wDa0J/Y287FdXlDjG0SvzR/21VdeBg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6506007)(6636002)(26005)(82960400001)(122000001)(921005)(38100700002)(8936002)(8676002)(4326008)(64756008)(76116006)(66476007)(7416002)(478600001)(66556008)(66946007)(54906003)(316002)(66446008)(5660300002)(91956017)(6512007)(4744005)(2616005)(41300700001)(2906002)(110136005)(71200400001)(6486002)(966005)(36756003)(38070700005)(86362001)(87590200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlZiSEV5RGxYM0tMYWZkYjQ4S0Y2Snd4a2JvZGVKWVVQRnZaZjNxM3Yzd1VK?=
 =?utf-8?B?VFhmZWRZVjMxOTBxNjNWYU1xMk9HaUxJZWRmRHh6Unh1TjEwclZDOXpSTmVM?=
 =?utf-8?B?TDNCcGI0a2RGUnc2S0ZnV3pXUGVzdjJmWE5vbHZ5bko3QWpmSXM4TXUvMFJK?=
 =?utf-8?B?TXRhdVVNY01Jak5rOWxjMlZ4ekExVUpsUUxTVWw5T05lQ0ZEeFhkcGxVVldJ?=
 =?utf-8?B?SXR3akpXbjlPTEllY1BIQUtVbFI5TUs1WnU5b05ab0FPM3ovS2ErYlVhZHNx?=
 =?utf-8?B?NnNOcFRMODZpTnlNUk84SzFvL1VtQzRDUkFtSTgyaE0yYnBaNTBlN0hPdG9J?=
 =?utf-8?B?SHZCK2pCVkFaWEJBK3E3a3EzOVNoSy9GRXdIeDBRNW9taXlLWmFiUVFMSFpN?=
 =?utf-8?B?cUZJWjYzcTN3UHFVYVU0ZUgzdUZmaXViT3dBLzQ1QWc0bWpva2NHZ2R3cThM?=
 =?utf-8?B?NHZKTS9kSDNWdlQzSU9ueFhlbldSZngzWWZIMHJxTndtQXRaNjJaOUpQL1Zm?=
 =?utf-8?B?SHdOaldVc0ZySFRHZmM0T1RrUVNMOWlFNUM5ZHpXWXVvRmV1dXFrRkJrU255?=
 =?utf-8?B?ZXNucnVXUWkyeXRrVHBkemxQL3lzMFBMQWd3SGxjQkZvdDZUakI1MkdEbURy?=
 =?utf-8?B?bUNXditBeHRYM1lDSkRQWDd5cEZDMFl2OE1jSzdNdSs1cVQ5ajNNaGs5WUVP?=
 =?utf-8?B?RURkeHNCdGpFZGtsdDk2cEJLTVdQQ0VmenE2SU8rNSt6ZnNwVS8vRUhGSE9h?=
 =?utf-8?B?NTNudXJrYnFoYmxRWHZiOTFuYWhOdUlEbmtlM1V5Y2s2TFpqQ2VVekVvQXJt?=
 =?utf-8?B?cEl6eU5wRWQ3TUN0VEIzTFNtUmhoRFlZdVhDNG1JWjRIczZ3TjlhNUFsQ3Zs?=
 =?utf-8?B?UThpMWVzcmRDUUFyTTRpUEhUZVJlNVRMTlJjRXYwSVNxY3hzOHFnWlpaU3hH?=
 =?utf-8?B?c25MV0IzaXFPOFBBOVhsdXJFa1lLYnkxWCtVTWpwTEVscXhMdEVndnllaERi?=
 =?utf-8?B?dHQ1dlZWOWRWTkcrWUdBZ1ExZm9sSVJSUXA2a2JtK3BOWVUwUDd0MVQxWlNS?=
 =?utf-8?B?VjlReWNuWXU3dEdlYmpFempNZGoyaXQrUTBQSWV1VEFLVVdFODg3cGN2eXIx?=
 =?utf-8?B?N1IrVm9HTFhGNVUrUmRmUXk1T0NsTzB5M0VvVCs2cFQ3anZTVGNINkU4ajVK?=
 =?utf-8?B?dzl3Mm1PcFliMjVEbjN1TDR3V0gydHlVd3YwOG04MkUzUG5WRjN6MU0yVzZs?=
 =?utf-8?B?U3FzWldFZ3NONU92VXM5MTNsbXBrZ1pKVS9CRElSYVBpcmdsb2tvYXdKdVNy?=
 =?utf-8?B?MmdLaEllVDJ5YUlDbnMydER3cWNRVkJWUVhPV0ZtUjViWHNwVXdBbzU1SVdE?=
 =?utf-8?B?ZVhjS1doV2pnM0FYR3kyVDA1VmxuVDcxT3IrUzhtbitLU2tUVVBMbHNHOFps?=
 =?utf-8?B?THpNLzdzTE95bi8zdEkrL0Ntd1BxcDVmbnoxc09MbERWYU5PSG9ZNWkzWG9y?=
 =?utf-8?B?eDhIU3pjUStXVjJFOGRkdzVub2NjRnloQ2g5STRIN0VqL25OTDF3T3NCYzJR?=
 =?utf-8?B?Ry9uRURyRFYvbnF1WkZTZytQV1pFUUNHSWV6dW1OTzB4UGJoYXR3c2RGSFVr?=
 =?utf-8?B?NEUxVVI4V0dHY2RQTmJqVlJuYTkwZk1aYkVVZnhBUWdzTEhGSHVYb09sZWJT?=
 =?utf-8?B?UmVQeWVNWmNQMW9TVkQ5ekgvQnBvalB3YzNHRjFYSngxTmlvaG1lZitwNnNq?=
 =?utf-8?B?WGFhWFhqYmxhbEI1TkIvU0ZrN3JPdjVjdWdQWEQ2eG9PanV3WlkwbmVjOWFK?=
 =?utf-8?B?TUxqT0cvb3krWm9iaVU3UTY0emJzOGpVNE8xZjQzRG1rN2xuUWw5ODRBMmtP?=
 =?utf-8?B?bVJkZWVvQUhydkorRjBpZEJlNjJwMWx6VG5aNEp5T2ROZkYyb2llTkJFYXly?=
 =?utf-8?B?aHRwQ0FqS2VKc0tXNXFJVVRNQWRFb3pKRGxoTnZ6YTBWbXY0MnhMR3F4blZ5?=
 =?utf-8?B?NmwyOE12TTVNUXExT1p4TU5wY01yNnIvb0YxVUs0QTA4cllkKy84ZFRXUUN1?=
 =?utf-8?B?U3BZNzRjSndpclJyVWZidzBmdnFLd0hkQ0R0NXRWZmpYajFMaUNXN2F4dk1a?=
 =?utf-8?B?dHIvZ0ZmMUlyMmE2NmJJc3cwUFU0OFp2aFpPQkxyamZwdXF0cE16U3NWMVNW?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ED06407BC62894390C6A6018D0C9272@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2425f4-08e2-41c2-8a3c-08dbc93659ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 02:12:27.2881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgZYlIvrQ+BiXOm0fF9Uaz0AP2H9B52rdyaKtBvBtc6NR+8r0eOxYkht3dKZ2G+vCQ4a1JUlPCKS9ZfiJW5RBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4780
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

DQo+ID4gPiA+IA0KPiA+ID4gTGF0ZXIgdGhlIGhvc3RpbmcgcHJvY2VzcyBjb3VsZCBtaWdyYXRl
ZC9yZWFzc2lnbmVkIHRvIGFub3RoZXIgY2dyb3VwPw0KPiA+ID4gV2hhdCB0byBkbyB3aGVuIHRo
ZSBuZXcgY2dyb3VwIGlzIE9PTT8NCj4gPiA+IA0KPiA+IA0KPiA+IFlvdSBhZGRyZXNzZWQgaW4g
dGhlIGRvY3VtZW50YXRpb24sIG5vPw0KPiA+IA0KPiA+ICtNaWdyYXRpb24NCj4gPiArLS0tLS0t
LS0tDQo+ID4gKw0KPiA+ICtPbmNlIGFuIEVQQyBwYWdlIGlzIGNoYXJnZWQgdG8gYSBjZ3JvdXAg
KGR1cmluZyBhbGxvY2F0aW9uKSwgaXQNCj4gPiArcmVtYWlucyBjaGFyZ2VkIHRvIHRoZSBvcmln
aW5hbCBjZ3JvdXAgdW50aWwgdGhlIHBhZ2UgaXMgcmVsZWFzZWQNCj4gPiArb3IgcmVjbGFpbWVk
LiAgTWlncmF0aW5nIGEgcHJvY2VzcyB0byBhIGRpZmZlcmVudCBjZ3JvdXAgZG9lc24ndA0KPiA+
ICttb3ZlIHRoZSBFUEMgY2hhcmdlcyB0aGF0IGl0IGluY3VycmVkIHdoaWxlIGluIHRoZSBwcmV2
aW91cyBjZ3JvdXANCj4gPiArdG8gaXRzIG5ldyBjZ3JvdXAuDQo+IA0KPiBTaG91bGQgd2Uga2ls
bCB0aGUgZW5jbGF2ZSB0aG91Z2ggYmVjYXVzZSBzb21lIFZBIHBhZ2VzIG1heSBiZSBpbiB0aGUg
bmV3ICANCj4gZ3JvdXA/DQo+IA0KDQpJIGd1ZXNzIGFjY2VwdGFibGU/DQoNCkFuZCBhbnkgZGlm
ZmVyZW5jZSBpZiB5b3Uga2VlcCBWQS9TRUNTIHRvIHVucmVjbGFpbWFiZSBsaXN0PyBJZiB5b3Ug
bWlncmF0ZSBvbmUNCmVuY2xhdmUgdG8gYW5vdGhlciBjZ3JvdXAsIHRoZSBvbGQgRVBDIHBhZ2Vz
IHN0YXkgaW4gdGhlIG9sZCBjZ3JvdXAgd2hpbGUgdGhlDQpuZXcgb25lIGlzIGNoYXJnZWQgdG8g
dGhlIG5ldyBncm91cCBJSVVDLg0KDQpJIGFtIG5vdCBjZ3JvdXAgZXhwZXJ0LCBidXQgYnkgc2Vh
cmNoaW5nIHNvbWUgb2xkIHRocmVhZCBpdCBhcHBlYXJzIHRoaXMgaXNuJ3QgYQ0Kc3VwcG9ydGVk
IG1vZGVsOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL1lFeVI5MTgxUWd6dCtQczlA
bXRqLmR1Y2tkbnMub3JnLw0KDQo=
