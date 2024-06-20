Return-Path: <cgroups+bounces-3250-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDAD910628
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 15:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9025AB260C5
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04DD1AD486;
	Thu, 20 Jun 2024 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaYRIvYP"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9A1AD3F9;
	Thu, 20 Jun 2024 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890144; cv=fail; b=m95aqOmoG0t7Y27CYdhM4XhaqDvP7zo5zfErbtVkWlFhyOHa2L1Ws8+nmy+zE3XebJ+LCu/MPoeaEQiEXtNjcJ8Eeo6dRjJakPPINPUANIx0RaVr6pqWjmrqhTwKLWrBhWfBQLTm877EPTDDmybJd05wtUBh2Hz98H3wCMjLjfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890144; c=relaxed/simple;
	bh=nqlBqWtBDbuvB6+UytzKj1Nu3MtFYSCpTAreDJWpS9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HPL8ZEv3fUGVc9uXQXbaqo6OXUoGEQY/DK79IB8aKAYNPraVaOrifsH5R6G+0A4wBvStjYaIKzCEhi5VENzWfutHLP/Gvo/N20A/N3YNLmUwVASJ08PGBE5XLGN5BRk25eaxrLc94Ap0Sr6zmW69mAoyGrM16yj6E7B9wjMIHrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eaYRIvYP; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718890143; x=1750426143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nqlBqWtBDbuvB6+UytzKj1Nu3MtFYSCpTAreDJWpS9I=;
  b=eaYRIvYPvDGR+l/jndPQgsTxA0+yek4HSdlZWtVOT3cPnYIzxfc/bxhc
   Dp2mdxtLhzjmNnYQHLYbRGXL7NbQwMwDGGXIlloiClipYEiZiIfbg6MCn
   8g22uaxrPFTuuKbwYLnuQQZ2FwCOtaJup1uix3xiTItAnEa+NmeJm4Jkg
   j5Zh7Y0cNEEvq/x80eCQ4ziFS/wf0fa6AMENFbmQv8+3sOIqwE0+xDsYx
   LJt7AXoFFQE2ia7jg1fxBhS6z2JZtxhtMfATsEMiuljYS9dhLZdVdcuyI
   SP/GYecMh1NPKbDqo7fiDmrcn4qgGwwIgySNIl9iFg+Oat2CiNMwMd4Ik
   Q==;
X-CSE-ConnectionGUID: uZ6LJKcoQAC64/pwHAN+tQ==
X-CSE-MsgGUID: Fk0Vdp3cQTaxByBjJZKoiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="33405576"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="33405576"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 06:29:02 -0700
X-CSE-ConnectionGUID: yUKi8yrnQYy6yU10VurNKQ==
X-CSE-MsgGUID: NKcmpWrlTCCYXo2zJjgAjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42346312"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 06:29:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 06:29:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 06:29:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 06:29:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVxyKnZzKvbvE1pI168f4aQM7+Gnax+MOB8wQWHX2UFSi8aZ39T41X//KCa0AyBZEq9B2f1BlK3ajyAdnF1bRsd11ado925+KU6uiuR4pDUCY9UAW1a2sTg4bJBnuGhy8Kb8OV/IcCqhQhXYHNdwfmJL1zw/PmKm9XFW4HeVryc7YyP6uV1YvhzaZoPwnn9KDhYOnmQsQN2K8lUNNd49WZHHpumaeCnmrvNwDPuFxU+lMxbOMnzLQbWVoo61QOjRHYyKT5orInwhqKWAKTJehUe3dH6NprD3KOpZQ7mGIFLaJqlQOKv+H9mSzgMbtsL+/PQnGBZ/9b27EACnVTJRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqlBqWtBDbuvB6+UytzKj1Nu3MtFYSCpTAreDJWpS9I=;
 b=LNsGBMDQHq2TfWtgFnDwbLRem3IUvdZZbE5nDUGq0R+nILHWupJkjMgm2lXQo0fPCUG8UzEO3m9oALxS8WaWX5uOfB2KfycOs3rKdXJmvsXh2XWEr70YnNt+s6LeTHetZ5ZkqNysyENUrLMYhKGIWlmlACQHpdzsGugn01ZUMLQTkc0B/2Vq9nhsIq81bVAAEtdqVGjAUgcXdh5+urKSBAI0k+Hp+ly3g9YM2hlStiFahMkLMjGtsJ2fYBPGNWgfMJLDw6EdAAtB6Xv0Juc2x2wQhfqeZ18RCEtjA3Bbi168igIdKKdTYnX9VcmmarR6tMgrO1XcSOw6elA5Nj2drw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 13:28:57 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 13:28:57 +0000
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
Subject: Re: [PATCH v15 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
Thread-Topic: [PATCH v15 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
Thread-Index: AQHawLVo9nYUca8jtkaZUluHas/j4rHQqiuA
Date: Thu, 20 Jun 2024 13:28:57 +0000
Message-ID: <ecaab6953b36adb278c98b01f5eb647ff0cc9aab.camel@intel.com>
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
	 <20240617125321.36658-9-haitao.huang@linux.intel.com>
In-Reply-To: <20240617125321.36658-9-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL3PR11MB6435:EE_
x-ms-office365-filtering-correlation-id: d043b80d-89db-428a-e1e8-08dc912cf03f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|7416011|376011|366013|38070700015|921017;
x-microsoft-antispam-message-info: =?utf-8?B?RUVYOTEzVnJXOExPS0tMQnY3aVFZVHFhbGRoK2JwUGtUYmVKQ0NsM1hyeU5x?=
 =?utf-8?B?NHdwVEUyamdjdEZFcnpwS2ZoYVFPZnVLcXBrcnU2ZWJvWGJzQkh0Rk9RTkJD?=
 =?utf-8?B?MkxUbThmTGZrSmhOZjJwTDdIVUVoR2pUNzg0bktxRnYxMUFVdzBDaXVSTW01?=
 =?utf-8?B?aGQzaEU3VmYxc2ZwSE03TThoNy9zYnMxdEdNcFdhc1M0ZHdId3ltWXgvMmFw?=
 =?utf-8?B?dWt2M2VVN1BtOWx3VVJEb0xjd2tJZk05R1p2a3AxeFp0ZzlzNkM5R2ZWSnll?=
 =?utf-8?B?M2RYVGNTVG52L3VpcXBsT1p3WkxFYzFuUEJtWHp2aVZTOGd5UlFwODVMQ0l3?=
 =?utf-8?B?dXovMVlIYURQME4vMDdtSnFWM1AvSTNTYnRZR3hpa0lDaFU0czVXKytJWXN5?=
 =?utf-8?B?Y0krTEl3a0ZrOFgrQnE5dGhCMm1Fc01MaUU4alRKWGVMdmYxV3o4ZW9PZTVI?=
 =?utf-8?B?OEYrNEtJSE42K3ZoenJoeVBtWVlqajB6cFlSQ0xiSkN0WGg3VjBZeklPZTUw?=
 =?utf-8?B?MlZCWXRxMDNtdTIwNFp4elJTRDhZVmJ4bS8wZlptZGRESzZMVXRlMElzL3J6?=
 =?utf-8?B?R0p0Q2tNSkFRYlBDU01DV2JNMHNTejBxZzc0NkpjZTgzSENjUldlOHg4V3Vn?=
 =?utf-8?B?dVM3S0pkMlJLMHZNSmpWSVpNV0VwcExkVUZXcHF5N01zeDlGWTRPWVJ1cHhz?=
 =?utf-8?B?em96YS9tTzlqZVJJTkg5a09mMUhFSUlQN0Vaa0dvbUxCMmtrcGQrYkdtQWxz?=
 =?utf-8?B?UERGYmNsUDZ4QUoreUh6NllPVUVjTnhYL3k3OUkyTkIzaWFtTXU4WGFMNUIv?=
 =?utf-8?B?U2ZvV2U1TkNPeHU0UFF5L0VTc1JnSXpJQkpULzBzbXdNeExsNVBHdlBHc0kv?=
 =?utf-8?B?bXlFdVlOZVJLWFdJYUg1RTlKOFU0K2JzcHJkM1p0dUtWTjlQWTRhWUFMK0Zv?=
 =?utf-8?B?eU9WeUlzWC9HODdmOFFzZHlWaDN5c3NjeDZzc3hpMnJLWDJ3d3pJTHcwSmxk?=
 =?utf-8?B?UER3TTBwRElldklha3UyVUxCTnhqeHFOM2FHVHJkZS8yOHFpRGptU1FQMlVv?=
 =?utf-8?B?QzJDWHF2QUNsQjFCOWtxKytPWjRPeG5tVVZRSEUyRXI1YXJ2RjVjcnczOVJ6?=
 =?utf-8?B?a01SU3MzZ0tsVUlDYVRka09XOWVOSUV3bEkzVnpsa0hQeW9yVVUxaXdvSitn?=
 =?utf-8?B?NW1hd3FOS3NhOXVzRnowbGFwTXUyMnhwTXpqeXlpRG1obTJJVlp5UHcxTXlI?=
 =?utf-8?B?dTFOSnhiakVHdmFoOGhVanluSnlVSy9HTy8veUJmem40LzFnSlNJUnE1R2lT?=
 =?utf-8?B?UnMrRzVZWTlKZ0EwWERodm92cE0xTndGaVNQaVo0aCs2dlpZQjVIbnNWQSta?=
 =?utf-8?B?U1NickxrcU9WcVBjN21lUVNOSVpkTW9hZE02L0xWd2lVa0MrUWZsOEo0dGRR?=
 =?utf-8?B?VW9qSUhJUmhTalNTa2FaSUduNzZZbFNYTnZId1lEWjFjTWFQM3J0bDh6V0xN?=
 =?utf-8?B?TFYyRWJmcFhvMmRnc0tJYzFRR3VrL3hNdFhoanl1OUluMVdaeFhvUWo3RW03?=
 =?utf-8?B?WkdlcFlWMEEwYVM5VUgyOFZINkhRYVI3U3FxaVhuMkMvckJjTDY4eG1uaDh0?=
 =?utf-8?B?dzdkY3R4cVA1U0N5K1RBTGpkeWJhWGhSWUtFWGRyeFZrVGZ4anV6OXc3ZWgx?=
 =?utf-8?B?dlVkZmloMGdURVVSVHN5UlJ0N1NmMzBIN0o1ZlUvdm5FTnljTlNtYkVXSnEw?=
 =?utf-8?B?SmtxZy9ST2Y5TXhGcWQzc3hUNVpwZ01HS1JpRExDdEl2T3RBQjM4VFdZdEVh?=
 =?utf-8?B?cnlhaG9pTi8vTmxXa3NFWHZJcUlkLzZMWWxMMzJUVG40cUlFWUtqSGsxc3Rs?=
 =?utf-8?Q?9LKByHTLv5YZ8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0thWjE3a3krRkpERDI0L2MybXdCbW5EcUJuRS9xUE9QNGlVb1dEUVYyckJ1?=
 =?utf-8?B?a2VhTmhHR3FjS2dQVWtXWGhTaDlqSzBGbUhweTRWOFlOZFdBeHorR1RkdDVo?=
 =?utf-8?B?WFk3SlhMc0t0RWhobXVLSW5QYTdIeFMzM2ZUa2hxc1FSaUdpZkF0NXNURk53?=
 =?utf-8?B?YnRkUmFlQWwrL0dvWXpDYW9oTVhlaWFPalZxSTdCdzdXM1hpRFB6Q0w3aldB?=
 =?utf-8?B?aXVpVXExeUVITGo4MDlsU3B3RTZIZFZWK1hweFgyL2NyQWRhNGJ4di90aHMx?=
 =?utf-8?B?UnhSWlRxaGpwTGFXNXQzK2pGM2ZHbXkva0kzUnFwKzZKc05yclNLNGp1Tkxm?=
 =?utf-8?B?MjRkQkZRT3NWSVZjaWl4SU9hVHY0QVNlNnMwVjFpY3RLNHgydlJhOUgzYXVs?=
 =?utf-8?B?TXBpa2NTU082STd2WFd5OC9TdGJVNVB2WmNNYldtM2lFa2Y4bTJHMCtHL3hB?=
 =?utf-8?B?R3pyQWxwd1h2YTNFakRSdnNsaVpJTmtzNzhCVXllNGlpaHl2Q3pTN3hIdDhv?=
 =?utf-8?B?eGRDcnJLZmNnRWpiQWZERmFqMlRZM0NtZnhIcENLNEh6RStiRXQ3YWdvbFBC?=
 =?utf-8?B?MkFHUFpoQ1FaRU1FTUJpdTZBMEhyeElxY3ptK2ZhcVd0NTZCaVpuSTh5L2ZH?=
 =?utf-8?B?VWdBeU1yanFRVkNBYkdxQkJydE1HRkxINjBoZmZ3RkNQTmxqZnQ0VGgzY2Y2?=
 =?utf-8?B?K2tYSkU0OWJrOUQ2OEUxOHRhT3FaMG5BTTdpSjEwQlloaG42VDBSVUtNbmFW?=
 =?utf-8?B?TDFNTS9Kb0RySk5oZzI5WFhQcnpocUExT1VoMW9NczhTcTVWOVFjR3EvZVVW?=
 =?utf-8?B?R2N4VVpKZVRUZWlBVWNGbEdMRy9zTzhOTXFNRmVvS2QrMmFDWWh0Uy8wdndz?=
 =?utf-8?B?MmNOd1NTWmUvLzlrb2RHWjdubnI5WXJaQko5RVkxOGk3emREa0R4UURXMDRB?=
 =?utf-8?B?L28raVQxWWlwSkIwbUg3OWp4RkdCUkwvdFhaUTFqOVNqOUFWM1RkNFhHM0xm?=
 =?utf-8?B?cndwZzZST1hjTnRndG5ZZStpTDRrZ1VSeGNvb0kxM0xEbUF6K09qdVFLL0Vn?=
 =?utf-8?B?VUZMK2llSjVNRnQ0SUFERGJRcGxOSUZPOGZhR1M5MlRuRkxoeHBEOWs4S3Y5?=
 =?utf-8?B?ZWt5cWhtRmtrLzdsYzNvNWxCTWNZUGg1QWxHK3ljL0h3d2JIZWIvL252OExN?=
 =?utf-8?B?RURMa2w3MjZHQ0pxZzNFWUVyMDF0aDRFbEFVeGh5a3VYVDRuRVc5dmVURDI4?=
 =?utf-8?B?WWVuQlptTjIybEJCd29kZEJqb2NGYmtQYURlT0tOdHhheTRwTm5rcG1Yc2Jv?=
 =?utf-8?B?YUFyeThBdExHaXMwVFM5c2Fvb00waUFkNWUzMDRyK3hLZEViVVpFMEVqMThH?=
 =?utf-8?B?c1lLOFlzOWpzdWFDeGcvZ0NIOGpINXZOTUZOV1FKY2M1bXo0eFRueE5RSzRM?=
 =?utf-8?B?YWQreis3Q3JDTDJjSDR4QkF0TXY1aHBIcnI5TmRJWUtDOWtWNzVhdUdHUG5J?=
 =?utf-8?B?Wko2bG5ia214Z052QWUycEEzSjZFUXRBaGxSQkpFdFFQYlRhY2RwZkx1aVF1?=
 =?utf-8?B?ZjMzK3NNU0doTFE3L0RpTTlGL2VCSzM2SEFtTFVkNzVSSHJycGh5aGhzcWlH?=
 =?utf-8?B?d1NYTjBEVVVTOWJiWENqakxlcmt5amV5SmRWNFVYdUpoYndQOHhDL3Ztb1Z2?=
 =?utf-8?B?WE15WVFZZyt4NHk1ZlZxRytsWndCT2FCdEZkSnZIdjF3Tktjd2lybGhyUEl1?=
 =?utf-8?B?MVZFcy9SdGlXY01GSm9BOHNBeVlnVXd4K1ZBQ1l3d2o2UXMzQjNqekxZTklD?=
 =?utf-8?B?S0MyK3RMcEdHOTlPdHpzS2dMb2FSMkQ4QUhzUEFpK2FBYlFmK0lNZWpNSkE5?=
 =?utf-8?B?YVlWVDYxdi9IeEUwZXVGVzl4SzJQWHRNcC9waE1ydjlMYXIwY2lFYmpzL3lR?=
 =?utf-8?B?SURCNTduWk9vK2VmS3VKdkthbmtlSDJhZWVGZ3hwOW9FRm1vVzhDVGNBT1Ri?=
 =?utf-8?B?Y2VsTyt2UGY0L1A1cmRIV291MDhTZ0JiS2lOWDcwWThydzRnRU4wcFpkTTE5?=
 =?utf-8?B?VjRvYzRyZ2VsWm9aTGtZZDFRMG5ySmtlTndsRnpzQkpERjJRUlRxeE1kYzRl?=
 =?utf-8?Q?6j6PQe9pDNfMoKYCFk3f5JHBo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E88B6BC44C10F4583ADE8D3B5238398@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d043b80d-89db-428a-e1e8-08dc912cf03f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 13:28:57.5024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8oZWX1P/MftrGqJXfTPKj08Wm9re//mW6KzQkzh3eQMn+082b4FdeIWyrtKIyLZwq+6gEviiOApEYc8Lpt2Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6435
X-OriginatorOrg: intel.com

DQpPbiAxOC8wNi8yMDI0IDEyOjUzIGFtLCBIdWFuZywgSGFpdGFvIHdyb3RlOg0KPiBGcm9tOiBL
cmlzdGVuIENhcmxzb24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5pbnRlbC5jb20+DQo+IA0KPiBD
dXJyZW50bHkgaW4gdGhlIEVQQyBwYWdlIGFsbG9jYXRpb24sIHRoZSBrZXJuZWwgc2ltcGx5IGZh
aWxzIHRoZQ0KPiBhbGxvY2F0aW9uIHdoZW4gdGhlIGN1cnJlbnQgRVBDIGNncm91cCBmYWlscyB0
byBjaGFyZ2UgZHVlIHRvIGl0cyB1c2FnZQ0KPiByZWFjaGluZyBsaW1pdC4gIFRoaXMgaXMgbm90
IGlkZWFsLiBXaGVuIHRoYXQgaGFwcGVucywgYSBiZXR0ZXIgd2F5IGlzDQo+IHRvIHJlY2xhaW0g
RVBDIHBhZ2UocykgZnJvbSB0aGUgY3VycmVudCBFUEMgY2dyb3VwIChhbmQvb3IgaXRzDQo+IGRl
c2NlbmRhbnRzKSB0byByZWR1Y2UgaXRzIHVzYWdlIHNvIHRoZSBuZXcgYWxsb2NhdGlvbiBjYW4g
c3VjY2VlZC4NCj4gDQo+IEFkZCB0aGUgYmFzaWMgYnVpbGRpbmcgYmxvY2tzIHRvIHN1cHBvcnQg
cGVyLWNncm91cCByZWNsYW1hdGlvbi4NCj4gDQo+IEN1cnJlbnRseSB0aGUga2VybmVsIG9ubHkg
aGFzIG9uZSBwbGFjZSB0byByZWNsYWltIEVQQyBwYWdlczogdGhlIGdsb2JhbA0KPiBFUEMgTFJV
IGxpc3QuICBUbyBzdXBwb3J0IHRoZSAicGVyLWNncm91cCIgRVBDIHJlY2xhaW0sIG1haW50YWlu
IGFuIExSVQ0KPiBsaXN0IGZvciBlYWNoIEVQQyBjZ3JvdXAsIGFuZCBpbnRyb2R1Y2UgYSAiY2dy
b3VwIiB2YXJpYW50IGZ1bmN0aW9uIHRvDQo+IHJlY2xhaW0gRVBDIHBhZ2VzIGZyb20gYSBnaXZl
biBFUEMgY2dyb3VwIGFuZCBpdHMgZGVzY2VuZGFudHMuDQo+IA0KPiBDdXJyZW50bHkgdGhlIGtl
cm5lbCBkb2VzIHRoZSBnbG9iYWwgRVBDIHJlY2xhaW0gaW4gc2d4X3JlY2xhaW1fcGFnZSgpLg0K
PiBJdCBhbHdheXMgdHJpZXMgdG8gcmVjbGFpbSBFUEMgcGFnZXMgaW4gYmF0Y2ggb2YgU0dYX05S
X1RPX1NDQU4gKDE2KQ0KPiBwYWdlcy4gIFNwZWNpZmljYWxseSwgaXQgYWx3YXlzICJzY2FucyIs
IG9yICJpc29sYXRlcyIgU0dYX05SX1RPX1NDQU4NCj4gcGFnZXMgZnJvbSB0aGUgZ2xvYmFsIExS
VSwgYW5kIHRoZW4gdHJpZXMgdG8gcmVjbGFpbSB0aGVzZSBwYWdlcyBhdCBvbmNlDQo+IGZvciBi
ZXR0ZXIgcGVyZm9ybWFuY2UuDQo+IA0KPiBJbXBsZW1lbnQgdGhlICJjZ3JvdXAiIHZhcmlhbnQg
RVBDIHJlY2xhaW0gaW4gYSBzaW1pbGFyIHdheSwgYnV0IGtlZXANCj4gdGhlIGltcGxlbWVudGF0
aW9uIHNpbXBsZTogMSkgY2hhbmdlIHNneF9yZWNsYWltX3BhZ2VzKCkgdG8gdGFrZSBhbiBMUlUN
Cj4gYXMgaW5wdXQsIGFuZCByZXR1cm4gdGhlIHBhZ2VzIHRoYXQgYXJlICJzY2FubmVkIiBhbmQg
YXR0ZW1wdGVkIGZvcg0KPiByZWNsYW1hdGlvbiAoYnV0IG5vdCBuZWNlc3NhcmlseSByZWNsYWlt
ZWQgc3VjY2Vzc2Z1bGx5KTsgMikgbG9vcCB0aGUNCj4gZ2l2ZW4gRVBDIGNncm91cCBhbmQgaXRz
IGRlc2NlbmRhbnRzIGFuZCBkbyB0aGUgbmV3IHNneF9yZWNsYWltX3BhZ2VzKCkNCj4gdW50aWwg
U0dYX05SX1RPX1NDQU4gcGFnZXMgYXJlICJzY2FubmVkIi7CoA0KPiANCj4gVGhpcyBpbXBsZW1l
bnRhdGlvbiwgZW5jYXBzdWxhdGVkIGluIHNneF9jZ3JvdXBfcmVjbGFpbV9wYWdlcygpLCBhbHdh
eXMNCj4gdHJpZXMgdG8gcmVjbGFpbSBTR1hfTlJfVE9fU0NBTiBwYWdlcyBmcm9tIHRoZSBMUlUg
b2YgdGhlIGdpdmVuIEVQQw0KPiBjZ3JvdXAsIGFuZCBvbmx5IG1vdmVzIHRvIGl0cyBkZXNjZW5k
YW50cyB3aGVuIHRoZXJlJ3Mgbm8gZW5vdWdoDQo+IHJlY2xhaW1hYmxlIEVQQyBwYWdlcyB0byAi
c2NhbiIgaW4gaXRzIExSVS4gIEl0IHNob3VsZCBiZSBlbm91Z2ggZm9yDQo+IG1vc3QgY2FzZXMu
IA0KDQpbLi4uXQ0KDQo+IEluIG90aGVyIGNhc2VzLCB0aGUgY2FsbGVyIG1heSBpbnZva2UgdGhp
cyBmdW5jdGlvbiBpbiBhDQo+IGxvb3AgdG8gZW5zdXJlIGVub3VnaCBwYWdlcyByZWNsYWltZWQg
Zm9yIGl0cyB1c2FnZS4gVG8gZW5zdXJlIGFsbA0KPiBkZXNjZW5kYW50IGdyb3VwcyBzY2FubmVk
IGluIGEgcm91bmQtcm9iaW4gZmFzaGlvbiBpbiB0aG9zZSBjYXNlcywNCj4gc2d4X2Nncm91cF9y
ZWNsYWltX3BhZ2VzKCkgdGFrZXMgaW4gYSBzdGFydGluZyBjZ3JvdXAgYW5kIHJldHVybnMgdGhl
DQo+IG5leHQgY2dyb3VwIHRoYXQgdGhlIGNhbGxlciBjYW4gcGFzcyBpbiBhcyB0aGUgbmV3IHN0
YXJ0aW5nIGNncm91cCBmb3IgYQ0KPiBzdWJzZXF1ZW50IGNhbGwuDQoNCg0KQUZBSUNUIHRoaXMg
cGFydCBpcyBuZXcsIGFuZCBJIGJlbGlldmUgdGhpcyAicm91bmQtcm9iaW4iIHRoaW5nIGlzIGp1
c3QgDQpmb3IgdGhlICJnbG9iYWwgcmVjbGFpbSI/ICBPciBpcyBpdCBhbHNvIGZvciBwZXItY2dy
b3VwIHJlY2xhaW0gd2hlcmUgbW9yZQ0KdGhhbiBTR1hfTlJfVE9fU0NBTiBwYWdlcyBuZWVkcyB0
byBiZSByZWNsYWltZWQ/DQoNCkkgd2lzaCB0aGUgY2hhbmdlbG9nIHNob3VsZCBqdXN0IHBvaW50
IG91dCB3aGF0IGNvbnN1bWVycyB3aWxsIHVzZSB0aGlzDQpuZXcgc2d4X2Nncm91cF9yZWNsYWlt
X3BhZ2VzKCksIGxpa2U6DQoNClRoZSBzZ3hfY2dyb3VwX3JlY2xhaW1fcGFnZXMoKSB3aWxsIGJl
IHVzZWQgaW4gdGhyZWUgY2FzZXM6DQoNCiAxKSBkaXJlY3Qvc3luYyBwZXItY2dyb3VwIHJlY2xh
aW0gaW4gdHJ5X2NoYXJnZSgpDQogMikgaW5kaXJlY3QvYXN5bmMgcGVyLWNncm91cCByZWNsYWlt
IHRyaWdnZXJlZCBpbiB0cnlfY2hhcmdlKCkNCiAzKSBnbG9iYWwgcmVjbGFpbQ0KDQpBbmQgdGhl
biBkZXNjcmliZSBob3cgd2lsbCB0aGV5IHVzZSBzZ3hfY2dyb3VwX3JlY2xhaW1fcGFnZXMoKToN
Cg0KQm90aCAxKSBhbmQgMikgY2FuIHJlc3VsdCBpbiBuZWVkaW5nIHRvIHJlY2xhaW0gbW9yZSB0
aGFuIFNHWF9OUl9UT19TQ0FODQpwYWdlcywgaW4gd2hpY2ggY2FzZSB3ZSBzaG91bGQgPGZpbGwg
aW4gaG93IHRvIHJlY2xhaW0+Lg0KDQpGb3IgMyksIHRoZSBuZXcgZ2xvYmFsIHJlY2xhaW0gc2hv
dWxkIHRyeSB0b3QgbWF0Y2ggdGhlIGV4aXN0aW5nIGdsb2JhbA0KcmVjbGFpbSBiZWhhdmlvdXIs
IHRoYXQgaXMgdG8gdHJ5IHRvIHRyZWF0IGFsbCBFUEMgcGFnZXMgZXF1YWxseS4gDQo8Y29udGlu
dWUgdG8gZXhwbGFpbiBob3cgY2FuIHNneF9jZ3JvdXBfcmVjbGFpbV9wYWdlcygpIGFjaGlldmUg
dGhpcy4+DQoNCldpdGggYWJvdmUgY29udGV4dCwgd2UgY2FuIGp1c3RpZnkgd2h5IHRvIG1ha2Ug
c2d4X2Nncm91cF9yZWNsYWltX3BhZ2VzKCkNCmluIHRoaXMgZm9ybS4NCg0KPiANCj4gTm90ZSwg
dGhpcyBzaW1wbGUgaW1wbGVtZW50YXRpb24gZG9lc24ndCBfZXhhY3RseV8gbWltaWMgdGhlIGN1
cnJlbnQNCj4gZ2xvYmFsIEVQQyByZWNsYWltICh3aGljaCBhbHdheXMgdHJpZXMgdG8gZG8gdGhl
IGFjdHVhbCByZWNsYWltIGluIGJhdGNoDQo+IG9mIFNHWF9OUl9UT19TQ0FOIHBhZ2VzKTogd2hl
biBMUlVzIGhhdmUgbGVzcyB0aGFuIFNHWF9OUl9UT19TQ0FODQo+IHJlY2xhaW1hYmxlIHBhZ2Vz
LCB0aGUgYWN0dWFsIHJlY2xhaW0gb2YgRVBDIHBhZ2VzIHdpbGwgYmUgc3BsaXQgaW50bw0KPiBz
bWFsbGVyIGJhdGNoZXMgX2Fjcm9zc18gbXVsdGlwbGUgTFJVcyB3aXRoIGVhY2ggYmVpbmcgc21h
bGxlciB0aGFuDQo+IFNHWF9OUl9UT19TQ0FOIHBhZ2VzLg0KPiANCj4gQSBtb3JlIHByZWNpc2Ug
d2F5IHRvIG1pbWljIHRoZSBjdXJyZW50IGdsb2JhbCBFUEMgcmVjbGFpbSB3b3VsZCBiZSB0bw0K
PiBoYXZlIGEgbmV3IGZ1bmN0aW9uIHRvIG9ubHkgInNjYW4iIChvciAiaXNvbGF0ZSIpIFNHWF9O
Ul9UT19TQ0FOIHBhZ2VzDQo+IF9hY3Jvc3NfIHRoZSBnaXZlbiBFUEMgY2dyb3VwIF9BTkRfIGl0
cyBkZXNjZW5kYW50cywgYW5kIHRoZW4gZG8gdGhlDQo+IGFjdHVhbCByZWNsYWltIGluIG9uZSBi
YXRjaC4gIEJ1dCB0aGlzIGlzIHVubmVjZXNzYXJpbHkgY29tcGxpY2F0ZWQgYXQNCj4gdGhpcyBz
dGFnZS4NCj4gDQo+IEFsdGVybmF0aXZlbHksIHRoZSBjdXJyZW50IHNneF9yZWNsYWltX3BhZ2Vz
KCkgY291bGQgYmUgY2hhbmdlZCB0bw0KPiByZXR1cm4gdGhlIGFjdHVhbCAicmVjbGFpbWVkIiBw
YWdlcywgYnV0IG5vdCAic2Nhbm5lZCIgcGFnZXMuIEhvd2V2ZXIsDQo+IHRoZSByZWNsYW1hdGlv
biBpcyBhIGxlbmd0aHkgcHJvY2VzcywgZm9yY2luZyBhIHN1Y2Nlc3NmdWwgcmVjbGFtYXRpb24N
Cj4gb2YgcHJlZGV0ZXJtaW5lZCBudW1iZXIgb2YgcGFnZXMgbWF5IGJsb2NrIHRoZSBjYWxsZXIg
Zm9yIHRvbyBsb25nLiBBbmQNCj4gdGhhdCBtYXkgbm90IGJlIGFjY2VwdGFibGUgaW4gc29tZSBz
eW5jaHJvbm91cyBjb250ZXh0cywgZS5nLiwgaW4NCj4gc2VydmluZyBhbiBpb2N0bCgpLg0KPiAN
Cj4gV2l0aCB0aGlzIGJ1aWxkaW5nIGJsb2NrIGluIHBsYWNlLCBhZGQgc3luY2hyb25vdXMgcmVj
bGFtYXRpb24gc3VwcG9ydA0KPiBpbiBzZ3hfY2dyb3VwX3RyeV9jaGFyZ2UoKTogdHJpZ2dlciBh
IGNhbGwgdG8NCj4gc2d4X2Nncm91cF9yZWNsYWltX3BhZ2VzKCkgaWYgdGhlIGNncm91cCByZWFj
aGVzIGl0cyBsaW1pdCBhbmQgdGhlDQo+IGNhbGxlciBhbGxvd3Mgc3luY2hyb25vdXMgcmVjbGFp
bSBhcyBpbmRpY2F0ZWQgYnkgcyBuZXdseSBhZGRlZA0KPiBwYXJhbWV0ZXIuDQo+IA0KPiBBIGxh
dGVyIHBhdGNoIHdpbGwgYWRkIHN1cHBvcnQgZm9yIGFzeW5jaHJvbm91cyByZWNsYW1hdGlvbiBy
ZXVzaW5nDQo+IHNneF9jZ3JvdXBfcmVjbGFpbV9wYWdlcygpLg0KDQpJdCBzZWVtcyB5b3UgYWxz
byBzaG91bGQgbWVudGlvbiB0aGUgbmV3IGdsb2JhbCByZWNsYWltIHdpbGwgYWxzbyB1c2UgDQp0
aGlzIHNneF9jZ3JvdXBfcmVjbGFpbV9wYWdlcygpPw0KDQpbLi4uXQ0KDQo+ICsvKioNCj4gKyAq
IHNneF9jZ3JvdXBfcmVjbGFpbV9wYWdlcygpIC0gcmVjbGFpbSBFUEMgZnJvbSBhIGNncm91cCB0
cmVlDQo+ICsgKiBAcm9vdDoJVGhlIHJvb3Qgb2YgY2dyb3VwIHRyZWUgdG8gcmVjbGFpbSBmcm9t
Lg0KPiArICogQHN0YXJ0OglUaGUgZGVzY2VuZGFudCBjZ3JvdXAgZnJvbSB3aGljaCB0byBzdGFy
dCB0aGUgdHJlZSB3YWxraW5nLg0KPiArICoNCj4gKyAqIFRoaXMgZnVuY3Rpb24gcGVyZm9ybXMg
YSBwcmUtb3JkZXIgd2FsayBpbiB0aGUgY2dyb3VwIHRyZWUgdW5kZXIgdGhlIGdpdmVuDQo+ICsg
KiByb290LCBzdGFydGluZyBmcm9tIHRoZSBub2RlICVzdGFydCwgb3IgZnJvbSB0aGUgcm9vdCBp
ZiAlc3RhcnQgaXMgTlVMTC4gVGhlDQo+ICsgKiBmdW5jdGlvbiB3aWxsIGF0dGVtcHQgdG8gcmVj
bGFpbSBwYWdlcyBhdCBlYWNoIG5vZGUgdW50aWwgYSBmaXhlZCBudW1iZXIgb2YNCj4gKyAqIHBh
Z2VzICglU0dYX05SX1RPX1NDQU4pIGFyZSBhdHRlbXB0ZWQgZm9yIHJlY2xhbWF0aW9uLiBObyBn
dWFyYW50ZWUgb2YNCj4gKyAqIHN1Y2Nlc3Mgb24gdGhlIGFjdHVhbCByZWNsYW1hdGlvbiBwcm9j
ZXNzLiBJbiBleHRyZW1lIGNhc2VzLCBpZiBhbGwgcGFnZXMgaW4NCj4gKyAqIGZyb250IG9mIHRo
ZSBMUlVzIGFyZSByZWNlbnRseSBhY2Nlc3NlZCwgaS5lLiwgY29uc2lkZXJlZCAidG9vIHlvdW5n
IiB0bw0KPiArICogcmVjbGFpbSwgbm8gcGFnZSB3aWxsIGFjdHVhbGx5IGJlIHJlY2xhaW1lZCBh
ZnRlciB3YWxraW5nIHRoZSB3aG9sZSB0cmVlLg0KPiArICoNCj4gKyAqIEluIHNvbWUgY2FzZXMs
IGEgY2FsbGVyIG1heSB3YW50IHRvIGVuc3VyZSBlbm91Z2ggcmVjbGFtYXRpb24gdW50aWwgaXRz
DQo+ICsgKiBzcGVjaWZpYyBuZWVkIGlzIG1ldC4gSW4gdGhvc2UgY2FzZXMsIHRoZSBjYWxsZXIg
c2hvdWxkIGludm9rZSB0aGlzIGZ1bmN0aW9uDQo+ICsgKiBpbiBhIGxvb3AsIGFuZCBhdCBlYWNo
IGl0ZXJhdGlvbiBwYXNzZXMgaW4gdGhlIHNhbWUgcm9vdCBhbmQgdGhlIG5leHQgbm9kZQ0KPiAr
ICogcmV0dXJuZWQgZnJvbSB0aGUgcHJldmlvdXMgY2FsbCBhcyB0aGUgbmV3ICVzdGFydC4NCj4g
KyAqDQo+ICsgKiBSZXR1cm46IFRoZSBuZXh0IG1pc2MgY2dyb3VwIGluIHRoZSBzdWJ0cmVlIHRv
IGNvbnRpbnVlIHRoZSBzY2FubmluZyBhbmQNCj4gKyAqIGF0dGVtcHQgZm9yIG1vcmUgcmVjbGFt
YXRpb24gZnJvbSB0aGlzIHN1YnRyZWUgaWYgbmVlZGVkLiDCoA0KPiANCg0KWy4uLl0NCg0KPiBD
YWxsZXIgbXVzdA0KPiArICogcmVsZWFzZSB0aGUgcmVmZXJlbmNlIGlmIHRoZSByZXR1cm5lZCBp
cyBub3QgdXNlZCBhcyAlc3RhcnQgZm9yIGEgc3Vic2VxdWVudA0KPiArICogY2FsbC4NCj4gDQoN
ClRoaXMgc2VudGVuY2UgaXNuJ3QgY2xlYXIgdG8gbWUuDQoNCkZpcnN0IG9mIGFsbCwgcmVsZWFz
ZSB0aGUgcmVmZXJlbmNlICJvZiB3aGF0Ij8gIFRoZSAlc3RhcnQsIG9yIHRoZSBvbmUNCnJldHVy
bmVkIGJ5IHRoaXMgZnVuY3Rpb24/DQoNCkFuZCBpcyBpdCBiZWNhdXNlIG9mIC4uLg0KDQo+ICsg
Ki8NCj4gK3N0YXRpYyBzdHJ1Y3QgbWlzY19jZyAqc2d4X2Nncm91cF9yZWNsYWltX3BhZ2VzKHN0
cnVjdCBtaXNjX2NnICpyb290LCBzdHJ1Y3QgbWlzY19jZyAqc3RhcnQpDQo+ICt7DQo+ICsJc3Ry
dWN0IGNncm91cF9zdWJzeXNfc3RhdGUgKmNzc19yb290LCAqcG9zOw0KPiArCXN0cnVjdCBjZ3Jv
dXBfc3Vic3lzX3N0YXRlICpuZXh0ID0gTlVMTDsNCj4gKwlzdHJ1Y3Qgc2d4X2Nncm91cCAqc2d4
X2NnOw0KPiArCXVuc2lnbmVkIGludCBjbnQgPSAwOw0KPiArDQo+ICsJIC8qIENhbGxlciBtdXN0
IGVuc3VyZSBjc3Nfcm9vdCBhbmQgc3RhcnQgcmVmJ3MgYWNxdWlyZWQgKi8NCg0KLi4uIHRoZSBj
YWxsZXIgbXVzdCBhY3F1aXJlIHRoZSByZWYgb2YgYm90aCBAY3NzX3Jvb3QgYW5kIEBjc3Nfc3Rh
cnQsIGFuZA0KLi4uDQoNCj4gKwljc3Nfcm9vdCA9ICZyb290LT5jc3M7DQo+ICsJaWYgKHN0YXJ0
KQ0KPiArCQlwb3MgPSAmc3RhcnQtPmNzczsNCj4gKwllbHNlDQo+ICsJCXBvcyA9IGNzc19yb290
Ow0KPiArDQo+ICsJd2hpbGUgKGNudCA8IFNHWF9OUl9UT19TQ0FOKSB7DQo+ICsJCXNneF9jZyA9
IHNneF9jZ3JvdXBfZnJvbV9taXNjX2NnKGNzc19taXNjKHBvcykpOw0KPiArCQljbnQgKz0gc2d4
X3JlY2xhaW1fcGFnZXMoJnNneF9jZy0+bHJ1KTsNCj4gKw0KPiArCQlyY3VfcmVhZF9sb2NrKCk7
DQo+ICsNCj4gKwkJbmV4dCA9IGNzc19uZXh0X2Rlc2NlbmRhbnRfcHJlKHBvcywgY3NzX3Jvb3Qp
Ow0KPiArDQo+ICsJCWlmIChwb3MgIT0gY3NzX3Jvb3QpDQo+ICsJCQljc3NfcHV0KHBvcyk7DQoN
Ci4uLiB0aGUgcmVmIGlzIGRlY3JlYXNlZCBpbnRlcm5hbGx5Pw0KDQo+ICsNCj4gKwkJaWYgKCFu
ZXh0IHx8ICFjc3NfdHJ5Z2V0KG5leHQpKSB7DQo+ICsJCQkvKiBXZSBhcmUgZG9uZSBpZiBuZXh0
IGlzIE5VTEwgb3Igbm90IHNhZmUgdG8gY29udGludWUNCj4gKwkJCSAqIHRoZSB3YWxrIGlmIG5l
eHQgaXMgZGVhZC4gUmV0dXJuIE5VTEwgYW5kIHRoZSBjYWxsZXINCj4gKwkJCSAqIGRldGVybWlu
ZXMgd2hldGhlciB0byByZXN0YXJ0IGZyb20gcm9vdC4NCj4gKwkJCSAqLw0KDQpJbmNvcnJlY3Qg
Y29tbWVudCBzdHlsZS4NCg0KPiArCQkJcmN1X3JlYWRfdW5sb2NrKCk7DQo+ICsJCQlyZXR1cm4g
TlVMTDsNCj4gKwkJfQ0KPiArDQo+ICsJCXJjdV9yZWFkX3VubG9jaygpOw0KPiArCQlwb3MgPSBu
ZXh0Ow0KDQpUaGVyZSdzIG5vIHJlZiBncmFiIGhlcmUsIHdvdWxkbid0IHRoZSBhYm92ZSAuLi4N
Cg0KCQlpZiAocG9zICE9IGNzc19yb290KQ0KCQkJY3NzX3B1dChwb3MpOw0KDQouLi4gZGVjcmVh
c2UgdGhlIHJlZiB3L28gaGF2aW5nIGl0IGJlZW4gaW5jcmVhc2VkPw0KDQo+ICsJfQ0KPiArDQo+
ICsJcmV0dXJuIGNzc19taXNjKG5leHQpOw0KDQpIZXJlIEFGQUlDVCB0aGUgcmVmIGlzbid0IGlu
Y3JlYXNlZCwgYnV0IC4uLg0KDQpbLi4uXQ0KDQoNCj4gKy8qKg0KPiArICogc2d4X2Nncm91cF90
cnlfY2hhcmdlKCkgLSB0cnkgdG8gY2hhcmdlIGNncm91cCBmb3IgYSBzaW5nbGUgRVBDIHBhZ2UN
Cj4gICAgKiBAc2d4X2NnOglUaGUgRVBDIGNncm91cCB0byBiZSBjaGFyZ2VkIGZvciB0aGUgcGFn
ZS4NCj4gKyAqIEByZWNsYWltOglXaGV0aGVyIG9yIG5vdCBzeW5jaHJvbm91cyBFUEMgcmVjbGFp
bSBpcyBhbGxvd2VkLg0KPiAgICAqIFJldHVybjoNCj4gICAgKiAqICUwIC0gSWYgc3VjY2Vzc2Z1
bGx5IGNoYXJnZWQuDQo+ICAgICogKiAtZXJybm8gLSBmb3IgZmFpbHVyZXMuDQo+ICAgICovDQo+
IC1pbnQgc2d4X2Nncm91cF90cnlfY2hhcmdlKHN0cnVjdCBzZ3hfY2dyb3VwICpzZ3hfY2cpDQo+
ICtpbnQgc2d4X2Nncm91cF90cnlfY2hhcmdlKHN0cnVjdCBzZ3hfY2dyb3VwICpzZ3hfY2csIGVu
dW0gc2d4X3JlY2xhaW0gcmVjbGFpbSkNCj4gICB7DQo+IC0JcmV0dXJuIG1pc2NfY2dfdHJ5X2No
YXJnZShNSVNDX0NHX1JFU19TR1hfRVBDLCBzZ3hfY2ctPmNnLCBQQUdFX1NJWkUpOw0KPiArCWlu
dCByZXQ7DQo+ICsJc3RydWN0IG1pc2NfY2cgKmNnX25leHQgPSBOVUxMOw0KPiArDQo+ICsJZm9y
ICg7Oykgew0KPiArCQlyZXQgPSBfX3NneF9jZ3JvdXBfdHJ5X2NoYXJnZShzZ3hfY2cpOw0KPiAr
DQo+ICsJCWlmIChyZXQgIT0gLUVCVVNZKQ0KPiArCQkJZ290byBvdXQ7DQo+ICsNCj4gKwkJaWYg
KHJlY2xhaW0gPT0gU0dYX05PX1JFQ0xBSU0pIHsNCj4gKwkJCXJldCA9IC1FTk9NRU07DQo+ICsJ
CQlnb3RvIG91dDsNCj4gKwkJfQ0KPiArDQo+ICsJCWNnX25leHQgPSBzZ3hfY2dyb3VwX3JlY2xh
aW1fcGFnZXMoc2d4X2NnLT5jZywgY2dfbmV4dCk7DQo+ICsJCWNvbmRfcmVzY2hlZCgpOw0KPiAr
CX0NCj4gKw0KPiArb3V0Og0KPiArCWlmIChjZ19uZXh0ICE9IHNneF9jZy0+Y2cpDQo+ICsJCXB1
dF9taXNjX2NnKGNnX25leHQpOw0KDQouLi4gaWYgSSBhbSByZWFkaW5nIGNvcnJlY3RseSwgaGVy
ZSB5b3UgZG9lcyB0aGUgcHV0IGFueXdheS4NCg0KPiArCXJldHVybiByZXQ7DQo+ICAgfQ0KPiAg
IA0KDQpBbmQgd2hlbiB0aGVyZSBhcmUgbW9yZSB0aGFuIFNHWF9OUl9UT19TQ0FOIHBhZ2VzIHRo
YXQgbmVlZCB0byByZWNsYWltLA0KdGhlIGFib3ZlwqAuLi4NCg0KCWZvciAoOzspIHsNCgkJY2df
bmV4dCA9IHNneF9jZ3JvdXBfcmVjbGFpbV9wYWdlcyhzZ3hfY2ctPmNnLCBjZ19uZXh0KTsNCgl9
DQoNCi4uLiBhY3R1YWxseSB0cmllcyB0byByZWNsYWltIHRob3NlIHBhZ2VzIGZyb20gQHNneF9j
ZyBfQU5EXyBpdCdzDQpkZXNjZW5kYW50cywgYW5kIHRyaWVzIHRvIGRvIGl0IF9FUVVBTExZXy4N
Cg0KSXMgdGhpcyBkZXNpcmVkLCBvciBzaG91bGQgd2UgYWx3YXlzIHRyeSB0byByZWNsYWltIGZy
b20gdGhlIEBzZ3hfY2cNCmZpcnN0LCBidXQgb25seSBtb3ZlcyB0byB0aGUgZGVzZW5kYW50cyB3
aGVuIHRoZSBAc2d4X2NnIHNob3VsZG4ndCBiZQ0KcmVjbGFpbWVkIGFueW1vcmU/DQoNCkFueXdh
eSwgaXQncyBkaWZmZXJlbnQgZnJvbSB0aGUgcHJldmlvdXMgYmVoYXZpb3VyLg0KDQpbLi4uXQ0K
DQo+IC1zdGF0aWMgYm9vbCBzZ3hfc2hvdWxkX3JlY2xhaW0odW5zaWduZWQgbG9uZyB3YXRlcm1h
cmspDQo+ICtzdGF0aWMgYm9vbCBzZ3hfc2hvdWxkX3JlY2xhaW1fZ2xvYmFsKHVuc2lnbmVkIGxv
bmcgd2F0ZXJtYXJrKQ0KPiAgIHsNCj4gICAJcmV0dXJuIGF0b21pY19sb25nX3JlYWQoJnNneF9u
cl9mcmVlX3BhZ2VzKSA8IHdhdGVybWFyayAmJg0KPiAgIAkgICAgICAgIWxpc3RfZW1wdHkoJnNn
eF9nbG9iYWxfbHJ1LnJlY2xhaW1hYmxlKTsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgdm9pZCBz
Z3hfcmVjbGFpbV9wYWdlc19nbG9iYWwodm9pZCkNCj4gK3sNCj4gKwlzZ3hfcmVjbGFpbV9wYWdl
cygmc2d4X2dsb2JhbF9scnUpOw0KPiArfQ0KPiArDQo+ICAgLyoNCj4gICAgKiBzZ3hfcmVjbGFp
bV9kaXJlY3QoKSBzaG91bGQgYmUgY2FsbGVkICh3aXRob3V0IGVuY2xhdmUncyBtdXRleCBoZWxk
KQ0KPiAgICAqIGluIGxvY2F0aW9ucyB3aGVyZSBTR1ggbWVtb3J5IHJlc291cmNlcyBtaWdodCBi
ZSBsb3cgYW5kIG1pZ2h0IGJlDQo+IEBAIC0zOTQsOCArNDA1LDggQEAgc3RhdGljIGJvb2wgc2d4
X3Nob3VsZF9yZWNsYWltKHVuc2lnbmVkIGxvbmcgd2F0ZXJtYXJrKQ0KPiAgICAqLw0KPiAgIHZv
aWQgc2d4X3JlY2xhaW1fZGlyZWN0KHZvaWQpDQo+ICAgew0KPiAtCWlmIChzZ3hfc2hvdWxkX3Jl
Y2xhaW0oU0dYX05SX0xPV19QQUdFUykpDQo+IC0JCXNneF9yZWNsYWltX3BhZ2VzKCk7DQo+ICsJ
aWYgKHNneF9zaG91bGRfcmVjbGFpbV9nbG9iYWwoU0dYX05SX0xPV19QQUdFUykpDQo+ICsJCXNn
eF9yZWNsYWltX3BhZ2VzX2dsb2JhbCgpOw0KPiAgIH0NCj4gICANCg0KSSB3aXNoIHRoZSByZW5h
bWUgd2FzIG1lbnRpb25lZCBpbiB0aGUgY2hhbmdlbG9nIHRvby4NCg0K

