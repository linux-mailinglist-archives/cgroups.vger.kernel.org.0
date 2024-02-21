Return-Path: <cgroups+bounces-1733-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F8B85D6BF
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 12:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DD61F22D49
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD6A3FB3C;
	Wed, 21 Feb 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jr6jH9OP"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FBC3DB89;
	Wed, 21 Feb 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514587; cv=fail; b=Ev9J53RbipkBQDzxU7+RAjbQ121I9iOv2HILr7Plnmm/QTVu1PcXiostpP6LoqEcwfM5Mf3ApQZ9FN5n46xL8Pc2xRuWnNQorybEC8B6d2RtSPhcBe0SJoEGDfxwGIeERdlEa2P7cztc66qsfqqZhu6qyIp0FKJbq8PWgW88RB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514587; c=relaxed/simple;
	bh=pTPKFNUvU2JGSvMVclWhjJZ6ShLmC36tFu4wfc5oLFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hbADiBESiEDjC2S0ZK5B1LmAW4blKIIL7IBytp1+YlHsJpz72zcD3YECEQXNcluWDD8fysXKNBVxlzam5CkZkLxtbSN+hFfHSQv9SPO6Ikmqtj54/Gjm7tBq4FYi4B4M89D43oDYPkiyWceLjfCnepH6rky2AhgRVFr8aGPHdko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jr6jH9OP; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708514585; x=1740050585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pTPKFNUvU2JGSvMVclWhjJZ6ShLmC36tFu4wfc5oLFc=;
  b=Jr6jH9OPSQkMuC/zFIUH3oVWShQbxsvGG4dBpKiyQeSvy8ItvduIIeiT
   J9WzUvgck0a1wxL2hDmjCfgvT2zS3U2klyRKJgFEV8OFRObA6nAr93LoO
   zuPIHIG2HIN5701doGBubbcMOaRnQ3fM09WI0RjkTHJk7tX1NsnGDuZ23
   Y+GvHBDc5/Fk+nGPnZYeLygvRowqGoKBLj6t/CJDt1WUemkcl8n2P1eYx
   ejsSV/iq+FQCQu+RWYus5ls9tz43b9uBYwWkfC18YqkX96koljq/3QpC3
   JeA+s2UhKT64EMOsHmTojinj4WQdyvCvi3FI/OF2qlF5i+xohXtU23P5P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6483087"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="6483087"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 03:23:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="35886615"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 03:23:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 03:23:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 03:23:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 03:23:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 03:23:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtLCgysbnJFaci/4Kc/sWbIbdB7a3fG9saQlGHh4iHSuSxVyn2+NeKNrWFFpUwRjIyOLqm3v5eNXJsbuMy9y1LExLAu+qDCMyf/N85AyiZDO3uoaTlWbGwXWC/cgzCM72HCqqvjAgjugNqWeukA831amjh854ZJl4l9+f+lNClA6kbsHV581LzgmuZGFoGQPYt23JzKtzIdoAuDjDe1StH9PLVLVvpBygW4+dX3JVO7DyMXK3EXYoCewRqFDN7Fa4JdJbmDHBewWzFpoGDy2I3T5d1+J+RBSEiWE7WYkksFaF1+enjTZDSOThwgFL8oK+5Rt4bvsZdymL4JwM/vxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTPKFNUvU2JGSvMVclWhjJZ6ShLmC36tFu4wfc5oLFc=;
 b=CQbl/0Vz0Scd3Do/qMO8ffBnUbiYuquLLpWxE8ADYXhGDzFcpNfffz66nlxnGT1atGtP2FbjYk5e3Vx5XQ0Ia4/En4O9GcquHU8pRvCkV9t/M/hC7LTVdxvQiBwIsBdaIEJVFPril/4agM9xmQCYc3yS7SXg2We4qHUj8h3yIfqrgRFfp0VbR3ZLDhUOE+bOoHCsJ3bmODZXbBqxldDvXD7YjjJLfUgirc32Ret+MYHur0qKLawM6XYgzmvCKfXDmMsYjU4S6Qv2siUcJGvhJQhEwhBtCiGqGfxvnHqv8JNv4U2BLREznLegsXQ6SfQRHjKUHUoLziPq42pyUJwCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by LV2PR11MB5974.namprd11.prod.outlook.com (2603:10b6:408:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 11:23:00 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 11:23:00 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
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
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 13/15] x86/sgx: Turn on per-cgroup EPC reclamation
Thread-Topic: [PATCH v9 13/15] x86/sgx: Turn on per-cgroup EPC reclamation
Thread-Index: AQHaWH8Yu9jtTjWM9k+FKV3aD/A/m7EUv6YA
Date: Wed, 21 Feb 2024 11:23:00 +0000
Message-ID: <87a85645ef1661e54ae6e56f1e47db25c3f8d7af.camel@intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
	 <20240205210638.157741-14-haitao.huang@linux.intel.com>
In-Reply-To: <20240205210638.157741-14-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|LV2PR11MB5974:EE_
x-ms-office365-filtering-correlation-id: c1560e96-55f1-47db-61f0-08dc32cf7669
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mwGmvSTJK1jAF0Sb6xNsDj2QwoEHfVrAoyse3fhAg2Rwks3pyDPVgwQ4BRGuhFJrTJQp8TBcgaJ8jm/0yWxuyPBAnUwytT2YQfd3bQugDAXOH9YMuHMy0NYOt0aIZPZ72jKo3dVsLNBzHtOrir23kmcAGtWaf7M9j42iddv5qobO0+LvX9+Ye6f6FCodDbL557Kr+2vUJZgVCBgUm7Cg423Tt835PEBC4HBKg7RirpKH2XSHHJOEWzQOGArgA8CKBV3mpXzqTSrtwxeHaYdAC6yfaUuNrCZyX2qm9R66ShcKb7+G+KiDfuJog+n7ygWzjiXJy0hzoy9+jYnv3SIgQem3NZnVKNCvSLoCNIKs57AVQBQit57R1b/jDbzId4/nxMEt7zJHnKWonAUXg+TcQcp7NO+YAlELClTFWrvjnCjoOktdQrX+nHNJHwQ+p0w2u0cG7hekO+9ZEtVWvAiwNIZfu8vBuUIu09W//Rcw7OkeHvqh/K0i+JW9xqPcXKLzbu0iCQkq4f5ZKz1GHWnRHsYupg7MqXx8UgcRTHb9L5SLPFLG66Rw8WLhauljVtnzAJDsK77BOWsObVXorwAvuzrLEpgLBHf3lP2nTAX74T5x9hoU2OefvZdqzJCYMbWj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1JSZnJaK0dLWC9nQnpIMHl2djJwWkxBajZFbXYwYmFrSWZLVHdFWTRKVEd5?=
 =?utf-8?B?WEw2cUpISENIaTM0c3BBTHFHSkNXdGJxWk9zdWZlZ3RQbnlpbytTdUh1UE1X?=
 =?utf-8?B?TnhKa3RpeGMyK01LVTYvMldsRkhTTmFJWDdNVVh2YWQ1d2tKVThEem5NTW5Q?=
 =?utf-8?B?RURhLy9UcWlJcEV3RTFhdmhSaXpFcGMrSkFUYXRyM2dPTVU4OElTdDcrUTVO?=
 =?utf-8?B?ODY1V3N2S01Fd0NXcW9vQ3daNGFqUFRMWFl6d0NtVXVyRStnb2V3cmN0cjVF?=
 =?utf-8?B?OFRlS29BR3hReEFvK0FMRFZkdjQ5S1Z5LzlZRUlSTCt0ZEdDOUlIZzJBNGRW?=
 =?utf-8?B?Z0tzRmllajFJSDJJcSswMko2eDltNzQvaDJQSVhpNnovZWE0a1Y2emcyb3dW?=
 =?utf-8?B?blptYXZBZ3lnYUFtcDBndWJCVnVUZmdSdFhXdHBHYVlEWmRwYlRMU2xNeWs2?=
 =?utf-8?B?T05nRkV1b28xV0trSFhra01iTEg0M3M0QW9nTnFOdTZLN2ZzWjV6eldwd0F2?=
 =?utf-8?B?OG80S0QwamhqRUsxQnd5SWlJYmhJbzVhajkrZDZGR3ZqWTFRRGlNZ0pPNCtS?=
 =?utf-8?B?Ri9STUxtNFVkckk1RjM2VlBndVEzWG5Uc1ErODYwV2h1NmRCbGJPOGU3U2ht?=
 =?utf-8?B?Y3NZQ3FmNFBsNEI2QksxSG5udGd4ZlpEeTFiblhaOVFVNUVDc2w4T0lCdWRz?=
 =?utf-8?B?aVQ3bk82eU41ZTNkemRvcENEdHhydVlmNHBsRFh1VGk5MmFmYXFhWS9JbGYv?=
 =?utf-8?B?bGJCejRocHJ4ME5jZVdVSkt1THljQUR3MWliYmFocGdoNFRGVFJBSlJIMjJv?=
 =?utf-8?B?MWFUdnNaNVJDK21ITTNpWUJzNXlSZFB5RDhiN3NkbFlibEJLV1NTQ0RISThn?=
 =?utf-8?B?VFRnRmo3b2JzbThacjIreXFFUC9lUWJ6WVcwUkwya243VHVEMXY2VFBDR0Zr?=
 =?utf-8?B?VDBJaGpBNWY0MUJHSFlnZWlhd25SZFVoSE9MWTFYdGVPeUhhdzg0Y2poVjdw?=
 =?utf-8?B?M2RQdXU0TEhkWWJvaHJwV3RRU3BwdlhPZjdnZmU3ZHhCT0lTWTdtZm1ZbVZ5?=
 =?utf-8?B?ZFNvTXllTk1pUFFtazhtdkxtK0sreWR3bHRMYWNadVJYVmIrc21VOWQ0VUxX?=
 =?utf-8?B?RDRzRlVld0ZmQ1dRS0U4Znd5Q2FJWFoySko0YVdPbUJ4NnU4RUNkMXQvY1pa?=
 =?utf-8?B?RXhNVTh4QmF5eWZvZjRNR0k5cXdtWlkybEZVR29McmRyOW1ld1ArQ1pWOTFv?=
 =?utf-8?B?czVzWlZRVFBhZlBmbTUremdQVmpERHIxaEhKUmw0L2J5VkRLVEhiYVgySHc3?=
 =?utf-8?B?TE9zb1N3MlFkQ1d0Qy9jMkdaM0N0MkF3enZoMi9yU3p3enN1UkNrNWpnSG9O?=
 =?utf-8?B?clBjc2FwZkxDRTUxblBmdDZCYlhzT2VuNEhIdm5mczZPT0paZjlKVWpNcnYr?=
 =?utf-8?B?ZHRoNG02QkVqT3BZUENEdXRqNGpVSUo4WG1LdHdJazU0ZVdjWHp5V1NBUWg4?=
 =?utf-8?B?MkNEbjRlYjFWRDhyTFFySTBIV2NPODkyek8vUTNiMUhaK0hjbHlCdnhJSDEr?=
 =?utf-8?B?eWZUblJoalZ1MUhQU3VTZDdxb05ZTUZwNGRUOHpYRWtHbFo5NXluK2xSRUx5?=
 =?utf-8?B?dUh2OG1LWk52WDcxVEc4UmNxVkZTRW9XTXBENVBHRkVENi9EOEhuNjAvM1lV?=
 =?utf-8?B?YmRNVXhwU1luRFZvMkZIMHJEbE9CVXBobERkMEoySVVuY1M5cUpkM0M2aWRQ?=
 =?utf-8?B?SHR5eGVabjJ1SG93aTJlSkRJU3JMcTFxbDk0K1Vrb3BpUHJoY2RSUUVNSHd2?=
 =?utf-8?B?RnlLOThNVStwZmIrM2J5L0U4NnRGWk9mZkVQR2tTd1BtazlRd2l5RlFFMUJu?=
 =?utf-8?B?bE04MmswZm4vRWEvaExBbXhIVWtaNnhxYk5Qb2JjTE03ZXc5ckVLZU40UlU5?=
 =?utf-8?B?N2ExL1VqUlZWeDg5ODZRbjJ6cUs0R25ER3hjMHVFaGVTVHhEOGtxMXdScWJk?=
 =?utf-8?B?OXQ5cWVTVWdDMzBRTVkwRjY5ZTI2bGthbDAveW13S0NyMVViZThYS09PNzRq?=
 =?utf-8?B?RzZ2OCtIMkJVSVVnY0k4ZVB6K2FaZTlyUWo1bFlDenBPa3pFcld6eUxzMmpW?=
 =?utf-8?B?cm1PTCtLRGlRMS91dDFJNjlCeXRsN2ZucDc0VG1HNWs5OWRQeWlWTEJDME1D?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1C3B602601CAB489E6052CBD45CCCB8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1560e96-55f1-47db-61f0-08dc32cf7669
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 11:23:00.5654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QO4iBGOsgV0TMSOT46u+fcUcljaN7D1m/o9MOkbB/kQh+FHxYV/mVrW9jIa5Pm0JJZdB0VrKefhU+uRTO+XREw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5974
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAyLTA1IGF0IDEzOjA2IC0wODAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4N
Cj4gDQo+IFByZXZpb3VzIHBhdGNoZXMgaGF2ZSBpbXBsZW1lbnRlZCBhbGwgaW5mcmFzdHJ1Y3R1
cmUgbmVlZGVkIGZvcg0KPiBwZXItY2dyb3VwIEVQQyBwYWdlIHRyYWNraW5nIGFuZCByZWNsYWlt
aW5nLiBCdXQgYWxsIHJlY2xhaW1hYmxlIEVQQw0KPiBwYWdlcyBhcmUgc3RpbGwgdHJhY2tlZCBp
biB0aGUgZ2xvYmFsIExSVSBhcyBzZ3hfbHJ1X2xpc3QoKSByZXR1cm5zIGhhcmQNCj4gY29kZWQg
cmVmZXJlbmNlIHRvIHRoZSBnbG9iYWwgTFJVLg0KPiANCj4gQ2hhbmdlIHNneF9scnVfbGlzdCgp
IHRvIHJldHVybiB0aGUgTFJVIG9mIHRoZSBjZ3JvdXAgaW4gd2hpY2ggdGhlIGdpdmVuDQo+IEVQ
QyBwYWdlIGlzIGFsbG9jYXRlZC4NCj4gDQo+IFRoaXMgbWFrZXMgYWxsIEVQQyBwYWdlcyB0cmFj
a2VkIGluIHBlci1jZ3JvdXAgTFJVcyBhbmQgdGhlIGdsb2JhbA0KPiByZWNsYWltZXIgKGtzZ3hk
KSB3aWxsIG5vdCBiZSBhYmxlIHRvIHJlY2xhaW0gYW55IHBhZ2VzIGZyb20gdGhlIGdsb2JhbA0K
PiBMUlUuIEhvd2V2ZXIsIGluIGNhc2VzIG9mIG92ZXItY29tbWl0dGluZywgaS5lLiwgc3VtIG9m
IGNncm91cCBsaW1pdHMNCj4gZ3JlYXRlciB0aGFuIHRoZSB0b3RhbCBjYXBhY2l0eSwgY2dyb3Vw
cyBtYXkgbmV2ZXIgcmVjbGFpbSBidXQgdGhlIHRvdGFsDQo+IHVzYWdlIGNhbiBzdGlsbCBiZSBu
ZWFyIHRoZSBjYXBhY2l0eS4gVGhlcmVmb3JlIGdsb2JhbCByZWNsYW1hdGlvbiBpcw0KPiBzdGls
bCBuZWVkZWQgaW4gdGhvc2UgY2FzZXMgYW5kIGl0IHNob3VsZCByZWNsYWltIGZyb20gdGhlIHJv
b3QgY2dyb3VwLg0KPiANCj4gTW9kaWZ5IHNneF9yZWNsYWltX3BhZ2VzX2dsb2JhbCgpLCB0byBy
ZWNsYWltIGZyb20gdGhlIHJvb3QgRVBDIGNncm91cA0KPiB3aGVuIGNncm91cCBpcyBlbmFibGVk
LCBvdGhlcndpc2UgZnJvbSB0aGUgZ2xvYmFsIExSVS4NCj4gDQo+IFNpbWlsYXJseSwgbW9kaWZ5
IHNneF9jYW5fcmVjbGFpbSgpLCB0byBjaGVjayBlbXB0aW5lc3Mgb2YgTFJVcyBvZiBhbGwNCj4g
Y2dyb3VwcyB3aGVuIEVQQyBjZ3JvdXAgaXMgZW5hYmxlZCwgb3RoZXJ3aXNlIG9ubHkgY2hlY2sg
dGhlIGdsb2JhbCBMUlUuDQo+IA0KPiBXaXRoIHRoZXNlIGNoYW5nZXMsIHRoZSBnbG9iYWwgcmVj
bGFtYXRpb24gYW5kIHBlci1jZ3JvdXAgcmVjbGFtYXRpb24NCj4gYm90aCB3b3JrIHByb3Blcmx5
IHdpdGggYWxsIHBhZ2VzIHRyYWNrZWQgaW4gcGVyLWNncm91cCBMUlVzLg0KPiANCj4gQ28tZGV2
ZWxvcGVkLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuLmouY2hyaXN0b3BoZXJzb25AaW50
ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuLmouY2hy
aXN0b3BoZXJzb25AaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBLcmlzdGVuIENhcmxzb24g
QWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5pbnRlbC5jb20+DQo+IENvLWRldmVsb3BlZC1ieTogSGFp
dGFvIEh1YW5nIDxoYWl0YW8uaHVhbmdAbGludXguaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBIYWl0YW8gSHVhbmcgPGhhaXRhby5odWFuZ0BsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiBW
NzoNCj4gLSBTcGxpdCB0aGlzIG91dCBmcm9tIHRoZSBiaWcgcGF0Y2gsICMxMCBpbiBWNi4gKERh
dmUsIEthaSkNCj4gLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9tYWluLmMgfCAxNiAr
KysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21h
aW4uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4uYw0KPiBpbmRleCA2YjBjMjZjYWM2
MjEuLmQ0MjY1YTM5MGJhOSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gv
bWFpbi5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4uYw0KPiBAQCAtMzQs
MTIgKzM0LDIzIEBAIHN0YXRpYyBzdHJ1Y3Qgc2d4X2VwY19scnVfbGlzdCBzZ3hfZ2xvYmFsX2xy
dTsNCj4gIA0KPiAgc3RhdGljIGlubGluZSBzdHJ1Y3Qgc2d4X2VwY19scnVfbGlzdCAqc2d4X2xy
dV9saXN0KHN0cnVjdCBzZ3hfZXBjX3BhZ2UgKmVwY19wYWdlKQ0KPiAgew0KPiArI2lmZGVmIENP
TkZJR19DR1JPVVBfU0dYX0VQQw0KPiArCWlmIChlcGNfcGFnZS0+ZXBjX2NnKQ0KPiArCQlyZXR1
cm4gJmVwY19wYWdlLT5lcGNfY2ctPmxydTsNCj4gKw0KPiArCS8qIFRoaXMgc2hvdWxkIG5vdCBo
YXBwZW4gaWYga2VybmVsIGlzIGNvbmZpZ3VyZWQgY29ycmVjdGx5ICovDQo+ICsJV0FSTl9PTl9P
TkNFKDEpOw0KPiArI2VuZGlmDQo+ICAJcmV0dXJuICZzZ3hfZ2xvYmFsX2xydTsNCj4gIH0NCg0K
SG93IGFib3V0IHdoZW4gRVBDIGNncm91cCBpcyBlbmFibGVkLCBidXQgb25lIGVuY2xhdmUgZG9l
c24ndCBiZWxvbmcgdG8gYW55IEVQQw0KY2dyb3VwPyAgSXMgaXQgT0sgdG8gdHJhY2sgRVBDIHBh
Z2VzIGZvciB0aGVzZSBlbmNsYXZlcyB0byB0aGUgcm9vdCBFUEMgY2dyb3VwJ3MNCkxSVSBsaXN0
IHRvZ2V0aGVyIHdpdGggb3RoZXIgZW5jbGF2ZXMgYmVsb25ncyB0byB0aGUgcm9vdCBjZ3JvdXA/
DQoNCg0KVGhpcyBzaG91bGQgYmUgYSB2YWxpZCBjYXNlLCByaWdodD8NCg==

