Return-Path: <cgroups+bounces-475-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8657F0B24
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 04:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05D9280C32
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 03:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D4F1FDF;
	Mon, 20 Nov 2023 03:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4EgFOKG"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F76BC;
	Sun, 19 Nov 2023 19:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700451957; x=1731987957;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5xV2Xn9BtxkKIX95xI4AodrPPrrswNE0XnY7sjSQ/wI=;
  b=E4EgFOKGvCIChkSOHbMbkAteubbNSYhQi46dCEDHr9jBGV9YdyW1ASzX
   X8Y4xKAyit9VRXWtxj6qVyIUHjpzNYGujlRaZ996dJ8c99Ttkyrrgmlqs
   kpZsoE2aXXYsUMViPoV5UbukNnUUp8JEUPVGWlWSbbq5AfAmonzPOl2ED
   bGgcEvY7oQCdfPDlLdQHVvBJhmmGqPm3BQJJ8V54b8827yDriYELOE1gZ
   42dW1U/4J0b3tGO47NI7edSsBcRNwCh8u8ORtaqWpE+NsPJ6jW2OZhv2v
   dwECIqzhs3JTvhESxpUaQFkm63PnCIoJUpwQNGUSauEQK7kxIcjFv7RM5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="371722577"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="371722577"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 19:45:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="939670746"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="939670746"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2023 19:45:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 19:45:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 19:45:51 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 19 Nov 2023 19:45:51 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 19 Nov 2023 19:45:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3gFx8NhA+qXnRzgxYcFWhgl+Z9WIxb9vcdLskrSnBnMjdj2bFGy7W2zbTMfrRgxH4fR18FmQmUwSqt4UTGmEA9kJsiGd13HsPJUh6zay2ZpOwY3L6Oz0oyvrMam/7M6+t3/IO+EQDja8/nsbmQ2hLYZ5swk0bfKtYdx0bq4Re/1MkuSN50vlGEAB4eOnwHfg3ABjQUPyTNyW+syG7YCBFKu/2pJ0VBy9g9jW8pILwm2vIg36sLWQrxm63g3g7XyoXvqmCEAJcRCY4rTy8KBaz9y3XzdidKw2lYwpksIqkZnFUDD1jGZaZPzG/rW3KNHS7vabBJ99FzDuq7jh5AaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xV2Xn9BtxkKIX95xI4AodrPPrrswNE0XnY7sjSQ/wI=;
 b=Vikps50VZymxQYv6fc+YEKX3xGecq5CGATb0S2cJY0lz62hzJaFQDL2fEd0/VMJ05PRevTFfUXaAKaQFB1fhpktQaE64pWCdbC3LVJ+ldEpH7ruLlOQHgkAsltSVVcouIDPQeebviguyvXnRTYsphDocB/ly/ZqRgli1T+RLmEWytw567Lh5X+/YWpNWCHmjNeeLratNHZiyG6puFllvrFpP/0Zy8I05W/R1KPDQJgDjCb6pC29HSJqls7UJusqkiZjVCsJ9qNTik/rvEYbf54fBYcExu9SXp9yUsARmFdcfopS4MdmtsI/e5Jj+K2u4xlu+lY80VrmYyhszjPx4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BY1PR11MB8056.namprd11.prod.outlook.com (2603:10b6:a03:533::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 03:45:48 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 03:45:48 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "hpa@zytor.com" <hpa@zytor.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "sean.j.christopherson@intel.com"
	<sean.j.christopherson@intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
Thread-Topic: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
Thread-Index: AQHaC13fVBhlQReaAU+BOIqG+a/nT7CCsVeA
Date: Mon, 20 Nov 2023 03:45:46 +0000
Message-ID: <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
	 <20231030182013.40086-10-haitao.huang@linux.intel.com>
In-Reply-To: <20231030182013.40086-10-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BY1PR11MB8056:EE_
x-ms-office365-filtering-correlation-id: e52c7cff-7461-49f6-5fb8-08dbe97b2e47
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oGGaNgdP/i8FvCraJVZFnz0vxwH2J+h3zMtuP8BKN9z4XBqnaBuRlDK5S6Z9kM3SeFRnaFcvTu7VSqGTEWBGZxOWKzIWnQ7Q93QG2MXkU8jULH5lt27JeXota+TzerZwOvK3R6beZ16FenqaLZMuEFIwB+klhTDwtQNs3HJp3W0kFTJ/dkjyYSYkpfJWfDVuYVKimu9J0/KAfMjXX9DlSb/dDQYIrNuMsXCFR9L83o0D6nPyG0iDQ6loFaljz9vRuS7OGLemrOXmiD9hzNEMuOeKxyib7C8rwxpTtAZnDonAyJWjLR+8tNTQ6mqF2FElN5wxIeZ4/UWzRDKp8KNIhxJjnfEJWoSMVIjloMtuBWJQPjOBiF/tO3ChigKwpNpDD9HHG1KfjtQLzrbkHBdrheCLoc2eO+uThQ+jEcvTLtXKBMj/JxnkOPCSjp9mqOslM7GQzl18/ryIfTM7eVTryOZuZabe9CKxa5YeibABtVLxsjXhuXVpcaXxZs7cezFJ/SY8a40jnq6QaSMQ3qaIiuTEIW+6korU4Aqdd2NqPzqCVaoXNbCvzipKVdoo0YS5+xlIesUAjm/NgsrBi5cGUgLD5lPw2b6EgaBlWQZ5I4Xd8rsP+1MCz06IcuErw+ISrd//UnfrU9NDBxtnnyR5JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(4001150100001)(2906002)(8936002)(41300700001)(4326008)(8676002)(7416002)(5660300002)(316002)(54906003)(64756008)(66556008)(66946007)(66476007)(66446008)(76116006)(91956017)(110136005)(86362001)(478600001)(6486002)(26005)(38070700009)(71200400001)(6512007)(36756003)(2616005)(6506007)(122000001)(83380400001)(38100700002)(921008)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU9JYjU3OHNKenRUTXZlUHkyNklCa3hqeWREUVlTSmZRZnRMNTlrZ2UrcFcv?=
 =?utf-8?B?TGNqUG1GQlZnQW4yamJDYUZaUDNGT2drRU9ORlpieUtiMUFsdWZFSXR2Z1o4?=
 =?utf-8?B?NVhUTFdua05Nam42WSt3T3IrMHpSUzNMUy9rYmdsaEU5VmZUTTlETDZnaVNa?=
 =?utf-8?B?eGRDRThqaTk1R1BiQm9KUWRJVmN4RXNzbkkyN1c5V0Q4TUdCeFAzdG9iVEUv?=
 =?utf-8?B?YzFvdGFGRE43OG1jNUZLTk5abXRUWEdrdUhaNjl4VEtoUWhmZDcvVktIc1ZP?=
 =?utf-8?B?REdWRGpOME10VHBCSFplQmV3OU5hSHJNT3ZybDdFQmpTSjNmRmppc3lIM2Vp?=
 =?utf-8?B?UG14QlhicEdIV3NGV2ZQNmdSaEh0VE81TzBHbk5kUE5tQmJId1d1SkUySU9r?=
 =?utf-8?B?eU96clllY0F6T1JPRHQzS0JBaUZCTFU5RXFSRzg0bDM0bjVldm91ZzlQRUl1?=
 =?utf-8?B?MURYTlhtUGdDcmVINDlETjJES01hNVBnVmxkZUlYTDN1N1lwM1NEcTVBVDQw?=
 =?utf-8?B?ak1ncU5FaFFsdy9DRy9Zd3RRbzZPaHV2Vmg5M29wT3BvWnVOUXgyR2hORlNz?=
 =?utf-8?B?NktJcmVtWlRSSld4aGpvallJa2dEVXNaZjJWeGppdzlUZ0VNY0JZdG9KVEFM?=
 =?utf-8?B?YVJMeGNyTVdwWkVPaHBLK3ZLOWtJZWE5c3RXOWlYZGdBeUxtZzNkOFhoNTVt?=
 =?utf-8?B?VHJvT1ZmaXNUV0FMMFRpcnRPekJ5U2pwNnpZUEV5clJOdllnRFF0QW1Fbm9X?=
 =?utf-8?B?d1dyb2NWaERJN0VaUHA4OU1sL3VPc25wNnBxVHgyaGNERUxCQ09yV29KVm5K?=
 =?utf-8?B?dHpjV3NlQ2pQT0VSRm5yTlJJYTBXUDdhcjNTZFR1R2hYQURQOUQrbUZxMUcz?=
 =?utf-8?B?SHk0NGlIdkk4SEVlVlJJSFJvMDRZSWd2YkcvdUVhcmxaMm1KWVlKck5oOUd1?=
 =?utf-8?B?UTBNM3lieW01SE9lTlJqbHpzeWsvSFRWdW9EUlpRRjJqYXBlNWpMYnhianU1?=
 =?utf-8?B?WGVlMmRyNXF6SFVvQ2JwMXBHckxsbFQ1Yi9lUE52Sjg1RG1NUUdxMWlIUUZ1?=
 =?utf-8?B?WHdpSkVqeFpVVE5SVzJnV09JZFk2NUszdW92RFo5blRCY3BKM2JJcXkrK3Na?=
 =?utf-8?B?ZVFWcGJSN0NMQXpDNnFFQlhMQ2k1Ly9XUWNJWUNYLzZ0b3AxOWlzMkJpekVC?=
 =?utf-8?B?dVRkcVE2SzBXY2x2eGE4S2RzaFc1WWVFRjcxUmQrMW9vSks1VWNubGh0dDlD?=
 =?utf-8?B?RFI5cERPSkdpSnl4bEhpbmdwaEhidW8xS2NZUFIwS0VKQThyMnNoLy90Smd6?=
 =?utf-8?B?TzFBdmdwWHZHWjE4Q1JKYWFwWHR2Nk9FVm1XNTdNdUpxd2lzYVQzWVIxNDFx?=
 =?utf-8?B?anQyWGthS29pV0ZBbFE3UGNwbndKNVdnTzFNV2gvMGJaam4zYW1KNTF3U096?=
 =?utf-8?B?Rm84Z2F5cHlZOUdxZFVsOTRQWU5wSkkxb2NiV2lmNytPZlN2QjlmNjI0dzNH?=
 =?utf-8?B?dHQrQUxXTWdKWDF2bHBka01ITVI3R3ZFQko2VTVVTklvWWxaakdOeTN6WGl3?=
 =?utf-8?B?clRaejN4ekd3REVPbGYwZ1p2cVNpMmw4SHNnVnQ5QXBoTW53QXlZc1pRbklu?=
 =?utf-8?B?eHVhamsyYjhhaDh2KzRhOVRHZk1qY1FlandDN05jSk1VSDJmcDNKc055RWhh?=
 =?utf-8?B?cVo3RVNpSGxQWmhDdTNxRmR5d1VOZ1BEdm8rU3RsT1A5aVZmSVNPVW10YnQx?=
 =?utf-8?B?d1c3L0daR3FQMHBGdkxPQmpEb0p2enIrekxuWjVoTXFMS21XczJ3UDJTRUZi?=
 =?utf-8?B?aUtTajRYWUtXR3IwbGVhbU9PY1ZCODZMclR6TUgwbFByMG1tQjU1eWxqcUR5?=
 =?utf-8?B?RnU2K2ZjUEY2bXZPWnZtTVJSUW9jaHQrMkltVWF4ZSsyNDEvUndma1A3VGpm?=
 =?utf-8?B?QkxGcVZ0cW1PdzhKL2w5VThleFNseFhreHF2ejVZKzFuaE9WNUlXN3liNmht?=
 =?utf-8?B?SmlndURDVCtRdEoyVkdUNFY1b0Y1cjdDcmlKdDJWOEprdkdaQWQ1a3cydWNJ?=
 =?utf-8?B?OGl6Z1Y5NEw0QlBCS3AwUlNwTGxYQ216K2p1L2hHbFgxZngzODdsdnVWbTdZ?=
 =?utf-8?B?ODFuckphcmJzSVFGNFlraEdLNGJURjVSNEFsUUpVWFlMR21IQ2dmNkN1WlNN?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E7A26EBCDCFF047A73D2EAF29CE7A01@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52c7cff-7461-49f6-5fb8-08dbe97b2e47
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 03:45:46.9716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NP8IejtbsC8qvZygkp5aFrc+VJ2vXbpC2Jq3ikOsKPVVdO27sMfKW4ggcaTOLb0k8B3Yos5lW7S9h8CdVz+eTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8056
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDIzLTEwLTMwIGF0IDExOjIwIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5j
b20+DQo+IA0KPiBUbyBwcmVwYXJlIGZvciBwZXItY2dyb3VwIHJlY2xhbWF0aW9uLCBzZXBhcmF0
ZSB0aGUgdG9wLWxldmVsIHJlY2xhaW0NCj4gZnVuY3Rpb24sIHNneF9yZWNsYWltX2VwY19wYWdl
cygpLCBpbnRvIHR3byBzZXBhcmF0ZSBmdW5jdGlvbnM6DQo+IA0KPiAtIHNneF9pc29sYXRlX2Vw
Y19wYWdlcygpIHNjYW5zIGFuZCBpc29sYXRlcyByZWNsYWltYWJsZSBwYWdlcyBmcm9tIGEgZ2l2
ZW4gTFJVIGxpc3QuDQo+IC0gc2d4X2RvX2VwY19yZWNsYW1hdGlvbigpIHBlcmZvcm1zIHRoZSBy
ZWFsIHJlY2xhbWF0aW9uIGZvciB0aGUgYWxyZWFkeSBpc29sYXRlZCBwYWdlcy4NCj4gDQo+IENy
ZWF0ZSBhIG5ldyBmdW5jdGlvbiwgc2d4X3JlY2xhaW1fZXBjX3BhZ2VzX2dsb2JhbCgpLCBjYWxs
aW5nIHRob3NlIHR3bw0KPiBpbiBzdWNjZXNzaW9uLCB0byByZXBsYWNlIHRoZSBvcmlnaW5hbCBz
Z3hfcmVjbGFpbV9lcGNfcGFnZXMoKS4gVGhlDQo+IGFib3ZlIHR3byBmdW5jdGlvbnMgd2lsbCBz
ZXJ2ZSBhcyBidWlsZGluZyBibG9ja3MgZm9yIHRoZSByZWNsYW1hdGlvbg0KPiBmbG93cyBpbiBs
YXRlciBFUEMgY2dyb3VwIGltcGxlbWVudGF0aW9uLg0KPiANCj4gc2d4X2RvX2VwY19yZWNsYW1h
dGlvbigpIHJldHVybnMgdGhlIG51bWJlciBvZiByZWNsYWltZWQgcGFnZXMuIFRoZSBFUEMNCj4g
Y2dyb3VwIHdpbGwgdXNlIHRoZSByZXN1bHQgdG8gdHJhY2sgcmVjbGFpbWluZyBwcm9ncmVzcy4N
Cj4gDQo+IHNneF9pc29sYXRlX2VwY19wYWdlcygpIHJldHVybnMgdGhlIGFkZGl0aW9uYWwgbnVt
YmVyIG9mIHBhZ2VzIHRvIHNjYW4NCj4gZm9yIGN1cnJlbnQgZXBvY2ggb2YgcmVjbGFtYXRpb24u
IFRoZSBFUEMgY2dyb3VwIHdpbGwgdXNlIHRoZSByZXN1bHQgdG8NCj4gZGV0ZXJtaW5lIGlmIG1v
cmUgc2Nhbm5pbmcgdG8gYmUgZG9uZSBpbiBMUlVzIGluIGl0cyBjaGlsZHJlbiBncm91cHMuDQoN
ClRoaXMgY2hhbmdlbG9nIHNheXMgbm90aGluZyBhYm91dCAid2h5IiwgYnV0IG9ubHkgbWVudGlv
bnMgdGhlICJpbXBsZW1lbnRhdGlvbiIuDQoNCkZvciBpbnN0YW5jZSwgYXNzdW1pbmcgd2UgbmVl
ZCB0byByZWNsYWltIEBucGFnZXNfdG9fcmVjbGFpbSBmcm9tIHRoZQ0KQGVwY19jZ3JwX3RvX3Jl
Y2xhaW0gYW5kIGl0cyBkZXNjZW5kYW50cywgd2h5IGNhbm5vdCB3ZSBkbzoNCg0KCWZvcl9lYWNo
X2Nncm91cF9hbmRfZGVzY2VuZGFudHMoJmVwY19jZ3JwX3RvX3JlY2xhaW0sICZlcGNfY2dycCkg
ew0KCQlpZiAobnBhZ2VzX3RvX3JlY2xhaW0gPD0gMCkNCgkJCXJldHVybjsNCg0KCQlucGFnZXNf
dG9fcmVjbGFpbSAtPSBzZ3hfcmVjbGFpbV9wYWdlc19scnUoJmVwY19jZ3JwLT5scnUsDQoJCQkJ
CW5wYWdlc190b19yZWNsYWltKTsNCgl9DQoNCklzIHRoZXJlIGFueSBkaWZmZXJlbmNlIHRvIGhh
dmUgImlzb2xhdGUiICsgInJlY2xhaW0iPw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENo
cmlzdG9waGVyc29uIDxzZWFuLmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPg0KPiBDby1kZXZl
bG9wZWQtYnk6IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogS3Jpc3RlbiBDYXJsc29uIEFjY2FyZGkgPGtyaXN0ZW5AbGlu
dXguaW50ZWwuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IEhhaXRhbyBIdWFuZyA8aGFpdGFvLmh1
YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGFpdGFvIEh1YW5nIDxoYWl0
YW8uaHVhbmdAbGludXguaW50ZWwuY29tPg0KPiBDYzogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2Vh
bmpjQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiANCg0KWy4uLl0NCg0KPiArLyoqDQo+ICsgKiBzZ3hf
ZG9fZXBjX3JlY2xhbWF0aW9uKCkgLSBQZXJmb3JtIHJlY2xhbWF0aW9uIGZvciBpc29sYXRlZCBF
UEMgcGFnZXMuDQo+ICsgKiBAaXNvOgkJTGlzdCBvZiBpc29sYXRlZCBwYWdlcyBmb3IgcmVjbGFt
YXRpb24NCj4gKyAqDQo+ICsgKiBUYWtlIGEgbGlzdCBvZiBFUEMgcGFnZXMgYW5kIHJlY2xhaW0g
dGhlbSB0byB0aGUgZW5jbGF2ZSdzIHByaXZhdGUgc2htZW0gZmlsZXMuICBEbyBub3QNCj4gKyAq
IHJlY2xhaW0gdGhlIHBhZ2VzIHRoYXQgaGF2ZSBiZWVuIGFjY2Vzc2VkIHNpbmNlIHRoZSBsYXN0
IHNjYW4sIGFuZCBtb3ZlIGVhY2ggb2YgdGhvc2UgcGFnZXMNCj4gKyAqIHRvIHRoZSB0YWlsIG9m
IGl0cyB0cmFja2luZyBMUlUgbGlzdC4NCj4gKyAqDQo+ICsgKiBMaW1pdCB0aGUgbnVtYmVyIG9m
IHBhZ2VzIHRvIGJlIHByb2Nlc3NlZCB1cCB0byBTR1hfTlJfVE9fU0NBTl9NQVggcGVyIGNhbGwg
aW4gb3JkZXIgdG8NCj4gKyAqIGRlZ3JhZGUgYW1vdW50IG9mIElQSSdzIGFuZCBFVFJBQ0sncyBw
b3RlbnRpYWxseSByZXF1aXJlZC4gc2d4X2VuY2xfZXdiKCkgZG9lcyBkZWdyYWRlIGEgYml0DQo+
ICsgKiBhbW9uZyB0aGUgSFcgdGhyZWFkcyB3aXRoIHRocmVlIHN0YWdlIEVXQiBwaXBlbGluZSAo
RVdCLCBFVFJBQ0sgKyBFV0IgYW5kIElQSSArIEVXQikgYnV0IG5vdA0KPiArICogc3VmZmljaWVu
dGx5LiBSZWNsYWltaW5nIG9uZSBwYWdlIGF0IGEgdGltZSB3b3VsZCBhbHNvIGJlIHByb2JsZW1h
dGljIGFzIGl0IHdvdWxkIGluY3JlYXNlDQo+ICsgKiB0aGUgbG9jayBjb250ZW50aW9uIHRvbyBt
dWNoLCB3aGljaCB3b3VsZCBoYWx0IGZvcndhcmQgcHJvZ3Jlc3MuDQoNClRoaXMgaXMga2luZGEg
b3B0aW1pemF0aW9uLCBjb3JyZWN0PyAgSXMgdGhlcmUgYW55IHJlYWwgcGVyZm9ybWFuY2UgZGF0
YSB0bw0KanVzdGlmeSB0aGlzPyAgSWYgdGhpcyBvcHRpbWl6YXRpb24gaXMgdXNlZnVsLCBzaG91
bGRuJ3Qgd2UgYnJpbmcgdGhpcw0Kb3B0aW1pemF0aW9uIHRvIHRoZSBjdXJyZW50IHNneF9yZWNs
YWltX3BhZ2VzKCkgaW5zdGVhZCwgZS5nLiwganVzdCBpbmNyZWFzZQ0KU0dYX05SX1RPX1NDQU4g
KDE2KSB0byBTR1hfTlJfVE9fU0NBTl9NQVggKDMyKT8NCg0KDQo=

