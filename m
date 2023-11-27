Return-Path: <cgroups+bounces-566-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C427F9CF5
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 10:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B691C20B7C
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A65117982;
	Mon, 27 Nov 2023 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2IaF94u"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46D4E1;
	Mon, 27 Nov 2023 01:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701079034; x=1732615034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n6Y4TVSnL11Z5WDdGLPYVk3xfaWoq9bgqCyx7rTGlQ4=;
  b=c2IaF94u0ki36ZiihcyUc+z6xs4HbKzceX8OEPVnHc4cusmu/7viDHWV
   GVlc4N0ojJudXv0F9XNZ+GQlHvIgLbxPUy9Z4D7vM/GejUoK1zc88cCm9
   Z/HCFWY9kgMJHXLZ9Bw3tf7Wbw+CE6m6XkU2cBDS4qI6vPatPyYgBk/mq
   MMveM9oNK/uJZsnsotQiVW5lIDlNHDQOQ7okDKCxTL8X2SHmRxvOwe770
   Nz4MmcW36F9gE9yKF7AHxXfIFFd7pO3xyKJAjihM3ItEXorq9l9ZsK0zo
   ke27p1k/Ib7m2QgvU/IaORpCajKX1azXG0+H3KVjb7FBs9ZIkZL4J0DKk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="392421807"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="392421807"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 01:57:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="717981557"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="717981557"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 01:57:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 01:57:12 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 01:57:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 01:57:12 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 01:57:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSNMpdKz3ES197dH0tFVUQskOG8V2D7rDlTFAn5d4CvNDU1Xof6hmYvYvO/ez5d5SIVS68Q01SKnk3wJ4IkBN6KjjaZ90WRp+xmFWHdfigDaIy475To23+bAlnkvj1K7t41uzfSjEGVsAkgWtY7SDP2o1ajGvyFDywlCOFEa+hpqD8sCINr1FgxtFqNB0ac63ng+oprYp/Et8/9Da/7QzU8hDiO4Vlg3WypI/bS9yG8lT6Tn3pqcCnA8Ehp9SsowntvSq7lPsx0NhAfrrLorWxO92Kp0BIEw7VPbH4vEhCu74WTZtQeoiEZDnSI9XcPQRQ/joa882TZLm8IsNEe5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6Y4TVSnL11Z5WDdGLPYVk3xfaWoq9bgqCyx7rTGlQ4=;
 b=STF0HiCfZExZGhb+Lx/hLjxxwy0i/cVZskSc3IxQGVSVkb4LG+WOC8RUXxxhhgGVraj2Bq+mFOnP1jfjeqIo3IexcmxDddcyJGSjvcZsNomo9dnW4g3D+FNMe8YxCsJKQfz+TEuaBXVgTSgfkQqiG1qukmlsAN/QuXXsde2PZFTZIjU50EWKYhLeahuJrzk64tV3t/mWX9DxeDtedRi3SLe7RYWsnPcLDWq54mQkeXY5QmPmMv1DvCE0wmNH1Eemudu2y1+iXCNO2gqQ8bGtOSgr9tg/gq/80T5OhYSaPlg4wpsQyVssUpS2NjhDt/bOWyYlI3kZ5WnGk3dtCvNFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB7606.namprd11.prod.outlook.com (2603:10b6:510:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 09:57:04 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 09:57:04 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "mingo@redhat.com" <mingo@redhat.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org" <tj@kernel.org>,
	"Mehta, Sohil" <sohil.mehta@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "sean.j.christopherson@intel.com"
	<sean.j.christopherson@intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"yangjie@microsoft.com" <yangjie@microsoft.com>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
Thread-Topic: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
Thread-Index: AQHaC13fVBhlQReaAU+BOIqG+a/nT7CCsVeAgApC3oCAASUwAA==
Date: Mon, 27 Nov 2023 09:57:03 +0000
Message-ID: <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
	 <20231030182013.40086-10-haitao.huang@linux.intel.com>
	 <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
	 <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB7606:EE_
x-ms-office365-filtering-correlation-id: 15c90f1b-ad63-4d9a-9c5a-08dbef2f34f7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LxYDTMRL0BttkzIy8vO4ZJj5n5wCMa11PvxKEyzthxqKZsWZCaHDesKDbfRtUyBNjaCKwBJ01FuSsybbF3QaH17ouW0AbjYhcq76UsS4krMZbiW3bRN66YVawcYMZVs4zgFiltIwyV0Zogi58WM3jZ1e5M9eJQ86aT+uMfhvQ/lPWzJMePEQ61LtYvTzbC4O3roQWFRPIzMtroRcu+vhyu2gOaM9lpkACW8QAbsbVyTWEb9OV9svMC0dDzy/dATaCWceHfNilgEUxZJFYLVp+BKAHBSIwlegO+9T9LujRDswuKGEpG1pROvqxWX3UfSBRz7KPGj1oxmKPOne4qT5ngbyJuC+UEpVSH2SlDDjNA5BuwlmtDXDeeP6AWpnP4f6CHRDcb9erhHEX2gJs4A0YLH6In9Nxq0BXzypd4KcQ3M4I4QrHsHTXKNKN6ICEBm+wEzyJvTJbAeVrlXXxGgZ4A6KBJyPdsvwz+Hb5gIYgLOIQdbGS7pX3CHeZzKJ3z2ydVKCTpYuhtgElywkCKmnVY5SfPPVa1kh8I071mmeyCaEex/0TCYMohjVLWPgsbgZRUUbsCmQob8LoN9mEBgbXxdXLk7OZoEd/Z9adglDjzRE8aJWJZlTJ/78cRZydRRDjUSO3jNMpTFM7DnDucuKHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(41300700001)(36756003)(921008)(86362001)(4001150100001)(38070700009)(122000001)(2906002)(83380400001)(5660300002)(82960400001)(7416002)(26005)(2616005)(6512007)(6506007)(71200400001)(8676002)(4326008)(8936002)(478600001)(6486002)(66446008)(66946007)(91956017)(64756008)(110136005)(76116006)(54906003)(66476007)(66556008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aktZcGhORUJuRUVFanJKcEJZVDd6M2NqdDUyWEhSVUQxK1RxczAzOXhZNy9S?=
 =?utf-8?B?ZEI4SWVvK0RpZytzRE9kOUgzU0o4UUJwU09YTzJSbWNjT1FzY1p2VEl2Mjdr?=
 =?utf-8?B?eko4S2I5NnVjR1dXYmZCWkV4cEsyVXRWM0E0RzdkVlVpd2NBa3Z1VFUrdEI4?=
 =?utf-8?B?RDIvaFg2cHpxa2ZjRFhMSmtqZkFOWHZYVFNTaFljSjdnS3NjOHpzZHRkRXpS?=
 =?utf-8?B?Vkp5aXVJcGlFK051czFLWWdWK2RySWRER1B4TnY4SjRldTFKYTQ2Smp5NnlP?=
 =?utf-8?B?dXkxc01Gbm1tZnREdll4VDB3Q1hZVzJ3Q21GVnlqVmVBOGx6UGpOaHhtdUdQ?=
 =?utf-8?B?Wm1VcjBkVkE2Rm5SRzVkanJ0MnEvVG14aERXRTBKbmhLdVNtbU9lL24xZzNH?=
 =?utf-8?B?TFpudTJ1alMwT1lweG5LaWo2eWhHSnJKRzlFV0liOUhHSm9sUTR3dEdFSXIr?=
 =?utf-8?B?Qkx4djRyWFlBTUhBdXJaVFBmditrc2NDL0J4OWcwN0hob0VNR096L2k3K2Vh?=
 =?utf-8?B?S1RWSnR2TW1IUUUxQUhhSVlyNFhjQ0VDUE1McFpoZXgwQzZvZE05dytCdDc3?=
 =?utf-8?B?VFhwemR1QWFDRjBwUVRyMElnNXRpaWQ1Zk0vWnQ2MitRc3paUkdSR2Nnd05w?=
 =?utf-8?B?RTh4RWYwVlZITGRNQmNyeUR1V3lGdHd1S3F4Wk5Tc0d3ZWE3YjhqeFBQbThi?=
 =?utf-8?B?ckVGazlGZUFoRFVBWXQ1eTc5cHFpcVhNbjJsUEVEMnU0VU5ReVg2aVRlT1RQ?=
 =?utf-8?B?emVUc3BGQ0JDWExsSzNMV25OTE11TGpObXhMT04yU3ZFOFJjTjFXVjlicWJW?=
 =?utf-8?B?SktBa28zYkV4OVJJRXJVWXBzNFZOeVVIQlRSc0NHN3p3TXhDYjVVazVveSsw?=
 =?utf-8?B?QlFESGRvRDkzTTJRZFlVV0ZUcXI1UTQyTW1KQ0tBUzU2ZVhoVjh3aktUMGU5?=
 =?utf-8?B?bHFmckxFQ2VSUWw1QW0wZ0ZGVTZCNWZFYWFIYlJkTHowY041VzZSL1Z1N2p4?=
 =?utf-8?B?VC9HeXFVaEhqMHN0RmJqdE1xcWtQQTR5cEhhSmJDc2x2UzVaL1VJaWw4QTVC?=
 =?utf-8?B?bE5BdC9qTEJlYnJQZUhaajY1NzhBSFUrRVVYazlaSmpHSGkvVU9kZ1I3MC95?=
 =?utf-8?B?YVVZeFRBclpwdlZsajc0NlR0V0phQXh5L2RkeE9HbXJ1VjhiWk1HVHRJVGhY?=
 =?utf-8?B?VForaklNVlJpYWlNejlzajV0cmhJdlhhVmNWM3ZCUU1sN3NESUdXNERrYVdT?=
 =?utf-8?B?WHBIMzVpcXhqa1IyeVlYd09XRjZrUThXQVpPTTVwQTdlakxCRkt3OUhzV1Js?=
 =?utf-8?B?WVE2N1FmOFNXUlFvZnpvQ3N1Tm5mN3doQ21oSy9UOUZTQ0M0SWpXVHBUUFpC?=
 =?utf-8?B?bkhzbWE1aUh2OXNjeGdHVFRFMUQvME0rdElaM2pVeFR4UVpzRlFodWVQQUk0?=
 =?utf-8?B?MDErZ1FoNXFDWk9OTTdUV3hOVWhkcUE3MjFFYXRqY005M0tEUUR4cVNFWjh6?=
 =?utf-8?B?WDYrL3NZblUzUDA3VE1YZmlUNlhSSC9EUFlMTHhsTWhXakZSdE0zTXBkSHV6?=
 =?utf-8?B?ZEVzOGVQNmxyUllMWXNZRXVQdFk0cGRIMWhWWFRDU2gwQW4vcU1xQzNHWkxh?=
 =?utf-8?B?OTNiWGc5dFUwZk5MemMxYzdPRTA3djBpUmtBb0FDYS9mWTlIOEpvRkg1TStu?=
 =?utf-8?B?M08zU2JIZ0QvbkZqMk1EOFZvL3RDZGpTa1U5UEFEK0pnOC9mbHJoQ01ET290?=
 =?utf-8?B?TkZzaWtUK0k3M24rSTZQMTBacVMxd3dFTW9JQ2s5Mk11YU5SUVBYZ044R0Jt?=
 =?utf-8?B?dXlUd3VoajJTeVFsOHRpQU9sSkdPeVVLWjJaVFdId1dqQUJyQUdtdDRvZ0FM?=
 =?utf-8?B?MG9TbU9WSUY1djVNbVhIQzQvKzdOdnJtT0dYdE9DQXVTSGp2bU1JU1MxNDZF?=
 =?utf-8?B?NkcxckFMNWg4Q1NYOG9lNFZzNHNoQ01GWTNZZXdLTGp1Y1hHcHgwZmQyVmFx?=
 =?utf-8?B?RGgyb3hxUXFOdExNalhvZFB5QlZFbVRJZWdIL2c4ZlNJeGlaQ1Vtd3RkMnUr?=
 =?utf-8?B?TjdFMnpxS2MybExpZVR3NzFpMzN1MWh6WlhaZVRRN09iQWRMR1psdEVHK1g5?=
 =?utf-8?B?SEFPYlp2VE9GWG1yNVpaS3dOUTYydmZqQW9hK3Nrb1cwVnFnU3ZDakZjNWFH?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E363DB3DA99A942B72408EEBBF56810@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c90f1b-ad63-4d9a-9c5a-08dbef2f34f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 09:57:03.3819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aH6O9fNhyGFulk6cFmYypvREHwSFXge8s31FfLJuYVpJ86ehHpQ9MqW1UtG4OPwbEg+ga82Uu1oAOzdXr9vHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7606
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDIzLTExLTI3IGF0IDAwOjI3ICswODAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIE1vbiwgMjAgTm92IDIwMjMgMTE6NDU6NDYgKzA4MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBNb24sIDIwMjMtMTAtMzAgYXQgMTE6MjAg
LTA3MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+IEZyb206IFNlYW4gQ2hyaXN0b3BoZXJz
b24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5jb20+DQo+ID4gPiANCj4gPiA+IFRvIHBy
ZXBhcmUgZm9yIHBlci1jZ3JvdXAgcmVjbGFtYXRpb24sIHNlcGFyYXRlIHRoZSB0b3AtbGV2ZWwg
cmVjbGFpbQ0KPiA+ID4gZnVuY3Rpb24sIHNneF9yZWNsYWltX2VwY19wYWdlcygpLCBpbnRvIHR3
byBzZXBhcmF0ZSBmdW5jdGlvbnM6DQo+ID4gPiANCj4gPiA+IC0gc2d4X2lzb2xhdGVfZXBjX3Bh
Z2VzKCkgc2NhbnMgYW5kIGlzb2xhdGVzIHJlY2xhaW1hYmxlIHBhZ2VzIGZyb20gYSAgDQo+ID4g
PiBnaXZlbiBMUlUgbGlzdC4NCj4gPiA+IC0gc2d4X2RvX2VwY19yZWNsYW1hdGlvbigpIHBlcmZv
cm1zIHRoZSByZWFsIHJlY2xhbWF0aW9uIGZvciB0aGUgIA0KPiA+ID4gYWxyZWFkeSBpc29sYXRl
ZCBwYWdlcy4NCj4gPiA+IA0KPiA+ID4gQ3JlYXRlIGEgbmV3IGZ1bmN0aW9uLCBzZ3hfcmVjbGFp
bV9lcGNfcGFnZXNfZ2xvYmFsKCksIGNhbGxpbmcgdGhvc2UgdHdvDQo+ID4gPiBpbiBzdWNjZXNz
aW9uLCB0byByZXBsYWNlIHRoZSBvcmlnaW5hbCBzZ3hfcmVjbGFpbV9lcGNfcGFnZXMoKS4gVGhl
DQo+ID4gPiBhYm92ZSB0d28gZnVuY3Rpb25zIHdpbGwgc2VydmUgYXMgYnVpbGRpbmcgYmxvY2tz
IGZvciB0aGUgcmVjbGFtYXRpb24NCj4gPiA+IGZsb3dzIGluIGxhdGVyIEVQQyBjZ3JvdXAgaW1w
bGVtZW50YXRpb24uDQo+ID4gPiANCj4gPiA+IHNneF9kb19lcGNfcmVjbGFtYXRpb24oKSByZXR1
cm5zIHRoZSBudW1iZXIgb2YgcmVjbGFpbWVkIHBhZ2VzLiBUaGUgRVBDDQo+ID4gPiBjZ3JvdXAg
d2lsbCB1c2UgdGhlIHJlc3VsdCB0byB0cmFjayByZWNsYWltaW5nIHByb2dyZXNzLg0KPiA+ID4g
DQo+ID4gPiBzZ3hfaXNvbGF0ZV9lcGNfcGFnZXMoKSByZXR1cm5zIHRoZSBhZGRpdGlvbmFsIG51
bWJlciBvZiBwYWdlcyB0byBzY2FuDQo+ID4gPiBmb3IgY3VycmVudCBlcG9jaCBvZiByZWNsYW1h
dGlvbi4gVGhlIEVQQyBjZ3JvdXAgd2lsbCB1c2UgdGhlIHJlc3VsdCB0bw0KPiA+ID4gZGV0ZXJt
aW5lIGlmIG1vcmUgc2Nhbm5pbmcgdG8gYmUgZG9uZSBpbiBMUlVzIGluIGl0cyBjaGlsZHJlbiBn
cm91cHMuDQo+ID4gDQo+ID4gVGhpcyBjaGFuZ2Vsb2cgc2F5cyBub3RoaW5nIGFib3V0ICJ3aHki
LCBidXQgb25seSBtZW50aW9ucyB0aGUgIA0KPiA+ICJpbXBsZW1lbnRhdGlvbiIuDQo+ID4gDQo+
ID4gRm9yIGluc3RhbmNlLCBhc3N1bWluZyB3ZSBuZWVkIHRvIHJlY2xhaW0gQG5wYWdlc190b19y
ZWNsYWltIGZyb20gdGhlDQo+ID4gQGVwY19jZ3JwX3RvX3JlY2xhaW0gYW5kIGl0cyBkZXNjZW5k
YW50cywgd2h5IGNhbm5vdCB3ZSBkbzoNCj4gPiANCj4gPiAJZm9yX2VhY2hfY2dyb3VwX2FuZF9k
ZXNjZW5kYW50cygmZXBjX2NncnBfdG9fcmVjbGFpbSwgJmVwY19jZ3JwKSB7DQo+ID4gCQlpZiAo
bnBhZ2VzX3RvX3JlY2xhaW0gPD0gMCkNCj4gPiAJCQlyZXR1cm47DQo+ID4gDQo+ID4gCQlucGFn
ZXNfdG9fcmVjbGFpbSAtPSBzZ3hfcmVjbGFpbV9wYWdlc19scnUoJmVwY19jZ3JwLT5scnUsDQo+
ID4gCQkJCQlucGFnZXNfdG9fcmVjbGFpbSk7DQo+ID4gCX0NCj4gPiANCj4gPiBJcyB0aGVyZSBh
bnkgZGlmZmVyZW5jZSB0byBoYXZlICJpc29sYXRlIiArICJyZWNsYWltIj8NCj4gPiANCj4gDQo+
IFRoaXMgaXMgdG8gb3B0aW1pemUgInJlY2xhaW0iLiBTZWUgaG93IGV0cmFjayB3YXMgZG9uZSBp
biBzZ3hfZW5jbF9ld2IuDQo+IEhlcmUgd2UganVzdCBmb2xsb3cgdGhlIHNhbWUgZGVzaWduIGFz
IGtzZ3hkIGZvciBlYWNoIHJlY2xhbWF0aW9uIGN5Y2xlLg0KDQpJIGRvbid0IHNlZSBob3cgZGlk
IHlvdSAiZm9sbG93IiBrc2d4ZC4gIElmIEkgYW0gZ3Vlc3NpbmcgY29ycmVjdGx5LCB5b3UgYXJl
DQphZnJhaWQgb2YgdGhlcmUgbWlnaHQgYmUgbGVzcyB0aGFuIDE2IHBhZ2VzIGluIGEgZ2l2ZW4g
RVBDIGNncm91cCwgdGh1cyB3L28NCnNwbGl0dGluZyBpbnRvICJpc29sYXRlIiArICJyZWNsYWlt
IiB5b3UgbWlnaHQgZmVlZCB0aGUgInJlY2xhaW0iIGxlc3MgdGhhbiAxNg0KcGFnZXMsIHdoaWNo
IG1pZ2h0IGNhdXNlIHNvbWUgcGVyZm9ybWFuY2UgZGVncmFkZT8NCg0KQnV0IGlzIHRoaXMgYSBj
b21tb24gY2FzZT8gIFNob3VsZCB3ZSBldmVuIHdvcnJ5IGFib3V0IHRoaXM/DQoNCkkgc3VwcG9z
ZSBmb3Igc3VjaCBuZXcgZmVhdHVyZSB3ZSBzaG91bGQgYnJpbmcgZnVuY3Rpb25hbGl0eSBmaXJz
dCBhbmQgdGhlbg0Kb3B0aW1pemF0aW9uIGlmIHlvdSBoYXZlIHJlYWwgcGVyZm9ybWFuY2UgZGF0
YSB0byBzaG93Lg0KDQo+IA0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlz
dG9waGVyc29uIDxzZWFuLmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPg0KPiA+ID4gQ28tZGV2
ZWxvcGVkLWJ5OiBLcmlzdGVuIENhcmxzb24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5pbnRlbC5j
b20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLcmlzdGVuIENhcmxzb24gQWNjYXJkaSA8a3Jpc3Rl
bkBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiBDby1kZXZlbG9wZWQtYnk6IEhhaXRhbyBIdWFuZyA8
aGFpdGFvLmh1YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEhhaXRh
byBIdWFuZyA8aGFpdGFvLmh1YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IENjOiBTZWFuIENo
cmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gDQo+ID4g
DQo+ID4gWy4uLl0NCj4gPiANCj4gPiA+ICsvKioNCj4gPiA+ICsgKiBzZ3hfZG9fZXBjX3JlY2xh
bWF0aW9uKCkgLSBQZXJmb3JtIHJlY2xhbWF0aW9uIGZvciBpc29sYXRlZCBFUEMgIA0KPiA+ID4g
cGFnZXMuDQo+ID4gPiArICogQGlzbzoJCUxpc3Qgb2YgaXNvbGF0ZWQgcGFnZXMgZm9yIHJlY2xh
bWF0aW9uDQo+ID4gPiArICoNCj4gPiA+ICsgKiBUYWtlIGEgbGlzdCBvZiBFUEMgcGFnZXMgYW5k
IHJlY2xhaW0gdGhlbSB0byB0aGUgZW5jbGF2ZSdzIHByaXZhdGUgIA0KPiA+ID4gc2htZW0gZmls
ZXMuICBEbyBub3QNCj4gPiA+ICsgKiByZWNsYWltIHRoZSBwYWdlcyB0aGF0IGhhdmUgYmVlbiBh
Y2Nlc3NlZCBzaW5jZSB0aGUgbGFzdCBzY2FuLCBhbmQgIA0KPiA+ID4gbW92ZSBlYWNoIG9mIHRo
b3NlIHBhZ2VzDQo+ID4gPiArICogdG8gdGhlIHRhaWwgb2YgaXRzIHRyYWNraW5nIExSVSBsaXN0
Lg0KPiA+ID4gKyAqDQo+ID4gPiArICogTGltaXQgdGhlIG51bWJlciBvZiBwYWdlcyB0byBiZSBw
cm9jZXNzZWQgdXAgdG8gU0dYX05SX1RPX1NDQU5fTUFYICANCj4gPiA+IHBlciBjYWxsIGluIG9y
ZGVyIHRvDQo+ID4gPiArICogZGVncmFkZSBhbW91bnQgb2YgSVBJJ3MgYW5kIEVUUkFDSydzIHBv
dGVudGlhbGx5IHJlcXVpcmVkLiAgDQo+ID4gPiBzZ3hfZW5jbF9ld2IoKSBkb2VzIGRlZ3JhZGUg
YSBiaXQNCj4gPiA+ICsgKiBhbW9uZyB0aGUgSFcgdGhyZWFkcyB3aXRoIHRocmVlIHN0YWdlIEVX
QiBwaXBlbGluZSAoRVdCLCBFVFJBQ0sgKyAgDQo+ID4gPiBFV0IgYW5kIElQSSArIEVXQikgYnV0
IG5vdA0KPiA+ID4gKyAqIHN1ZmZpY2llbnRseS4gUmVjbGFpbWluZyBvbmUgcGFnZSBhdCBhIHRp
bWUgd291bGQgYWxzbyBiZSAgDQo+ID4gPiBwcm9ibGVtYXRpYyBhcyBpdCB3b3VsZCBpbmNyZWFz
ZQ0KPiA+ID4gKyAqIHRoZSBsb2NrIGNvbnRlbnRpb24gdG9vIG11Y2gsIHdoaWNoIHdvdWxkIGhh
bHQgZm9yd2FyZCBwcm9ncmVzcy4NCj4gPiANCj4gPiBUaGlzIGlzIGtpbmRhIG9wdGltaXphdGlv
biwgY29ycmVjdD8gIElzIHRoZXJlIGFueSByZWFsIHBlcmZvcm1hbmNlIGRhdGEgIA0KPiA+IHRv
DQo+ID4ganVzdGlmeSB0aGlzPw0KPiANCj4gVGhlIGFib3ZlIHNlbnRlbmNlcyB3ZXJlIHRoZXJl
IG9yaWdpbmFsbHkuIFRoaXMgb3B0aW1pemF0aW9uIHdhcyBqdXN0aWZpZWQuDQoNCkkgYW0gdGFs
a2luZyBhYm91dCAxNiAtPiAzMi4NCg0KPiANCj4gPiBJZiB0aGlzIG9wdGltaXphdGlvbiBpcyB1
c2VmdWwsIHNob3VsZG4ndCB3ZSBicmluZyB0aGlzDQo+ID4gb3B0aW1pemF0aW9uIHRvIHRoZSBj
dXJyZW50IHNneF9yZWNsYWltX3BhZ2VzKCkgaW5zdGVhZCwgZS5nLiwganVzdCAgDQo+ID4gaW5j
cmVhc2UNCj4gPiBTR1hfTlJfVE9fU0NBTiAoMTYpIHRvIFNHWF9OUl9UT19TQ0FOX01BWCAoMzIp
Pw0KPiA+IA0KPiANCj4gU0dYX05SX1RPX1NDQU5fTUFYIG1pZ2h0IGJlIGRlc2lnbmVkIGVhcmxp
ZXIgZm9yIG90aGVyIHJlYXNvbnMgSSBkb24ndCAgDQo+IGtub3cuIEN1cnJlbnRseSBpdCBpcyBy
ZWFsbHkgdGhlIGJ1ZmZlciBzaXplIGFsbG9jYXRlZCBpbiAgDQo+IHNneF9yZWNsYWltX3BhZ2Vz
KCkuIEJvdGggY2dyb3VwIGFuZCBrc2d4ZCBzY2FuIDE2IHBhZ2VzIGEgdGltZS5NYXliZSB3ZSAg
DQo+IHNob3VsZCBqdXN0IHVzZSBTR1hfTlJfVE9fU0NBTi4gTm8gX01BWCBuZWVkZWQuIFRoZSBw
b2ludCB3YXMgdG8gYmF0Y2ggIA0KPiByZWNsYW1hdGlvbiB0byBjZXJ0YWluIG51bWJlciB0byBt
aW5pbWl6ZSBpbXBhY3Qgb2YgRVdCIHBpcGVsaW5lLiAxNiB3YXMgIA0KPiB0aGUgb3JpZ2luYWwg
ZGVzaWduLg0KPiANCg0KUGxlYXNlIGRvbid0IGxlYXZlIHdoeSB5b3UgYXJlIHRyeWluZyB0byBk
byB0aGlzIHRvIHRoZSByZXZpZXdlcnMuICBJZiB5b3UgZG9uJ3QNCmtub3csIHRoZW4ganVzdCBk
cm9wIHRoaXMuDQoNCg==

