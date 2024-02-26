Return-Path: <cgroups+bounces-1862-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5B08683B2
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 23:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CF528B560
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 22:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3022F1369BC;
	Mon, 26 Feb 2024 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGrgzw/Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200D13699D;
	Mon, 26 Feb 2024 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986289; cv=fail; b=Ufm3JxbxEWR2r+3LgtvdJ5/zic2DUn9hrnKipxMy4vIfI2mqixM9Irlk6a6BWQFYZrgj2TlrWGauR96u8d7afm78xtZ4P4HbmgIvVBd+rkpTCbkbS32Dyv/6LbkWJVf/7krxzQAzWPrm7kczCe70+4VeMqantfhI70bQe/SczRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986289; c=relaxed/simple;
	bh=A/bgilMZpawx2fDsW+6xypgzz+A4C2NN34oloUv2WPc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i4JFe3FAVF+kDaeyzsbN4xfZ+/4c8rKcBd6TNkii0GAEN/WA3ceGMgsrDsLPt41ogeUDgk34oarM9kcZ3ejfGuYKphuve7mSR2lhY1bFm5AQa4FqS4AAEnUZycX8HdBiZN/VwcPIVEky4KGekVRbZnW/37QqN7N3cR4sY1PL4DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGrgzw/Y; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708986287; x=1740522287;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A/bgilMZpawx2fDsW+6xypgzz+A4C2NN34oloUv2WPc=;
  b=CGrgzw/Yru0pTAryOe0nzAN/OZU7PxDPlWs7uIcBCBFmeZj4XXgCbjlq
   ba1nLze77T2z07ThpkAAgb+VsV7wR3wwerUCnTQxdnkewpWoRG7KSpyRl
   kBcauiywu/BDrs5R/RQv2D83lNwm7ZdNqZqvHuiJanmxCsqFdJjpJV081
   TnXPYDvQembulXZTDVOJcs3dD5scrLx2E+NqRhw8iG/1yW424IsVDKGp4
   brPq/dyHDnvJGxvo0m3/F4Y4pArgKpm6pYCLY4NEqNDF4L0otQ4dHI2pi
   12xCh3fPf1oLHSMLnoEvCouBWX5WmWRAAXAS24Wc5svbSLZ2tkf+zObgr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3463912"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="3463912"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 14:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6955508"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 14:24:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 14:24:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 14:24:45 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 14:24:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4y3ezRhl4effKIJsf2MYqpItdHU1spL99sOnHloIU0jsZ5b+BSME7sMhcEXAtuY4ESXGDCHIXRE1mbofJ1SIkku0QTPt9Pkh8Dvf86hK9gJNU/vU3TknoYwrAlq6RKbmksEgXk64m5t8XtEQ6mN0/+Ri976IxZpz2xFvrap54kVeOIK2Zz7Q6ifT6U3/348qs3Szu1fvp/u20JTu4XcQ+uQfntzjSGq3KQ0gyjF3MLjU7mEU5BhgyJkViXPevjUSGI85YMeR5j0sebbESyXo6kmx9RS9B+1p5SxVxzm420zeRXTJXXWVs85iJs0qp3boGra4wtnvEZs1o7I5YIMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNrTMnHCFZ5PosKNZ1qzQ+24EAADbzP5fHTE0GL7An8=;
 b=iFc3W7CeLnb308E0roKtkkk8mYPLF0KVTaA7GkQv+9o7nV40n7ZCAcdhMkDWqw5NeQhAlqt6oQKEfxBCrP/ezK6Qym1a/JCVy2Owh9b0wLwQ8J1pevS9Jqx+2XXvvBBgksgZ+psrnjpkuF92er27HjmTSsyOiB58y4qWsr8UrjaMtrXGF1cv7Z34S+YSg/RmDkLraPx69e44WpwxpzsvS0dZ4xWsi1pScZpU3iLzUDvL6YAEF6y0766zf/NJur4d+kpEpD03TDFYVponLFnV0gZfClT/RVodD0hC1ZlkGZ9MXdM+UwzWvb5oSWsLAUHgi5z1GgnGEHJx8hXv7p1gPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8776.namprd11.prod.outlook.com (2603:10b6:610:1c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Mon, 26 Feb
 2024 22:24:42 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Mon, 26 Feb 2024
 22:24:42 +0000
Message-ID: <010f5c8e-6e63-4b37-82d7-ba755f989755@intel.com>
Date: Tue, 27 Feb 2024 11:24:28 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
Content-Language: en-US
To: Haitao Huang <haitao.huang@linux.intel.com>, "tj@kernel.org"
	<tj@kernel.org>, "jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "mkoutny@suse.com" <mkoutny@suse.com>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-11-haitao.huang@linux.intel.com>
 <c5d03171473821ebc9cb79e3dad4d1bf0074e674.camel@intel.com>
 <op.2jjzaqdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4db8493b-35a2-474f-997c-5e6ac1b8bd11@intel.com>
 <op.2jkfeezjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <c913193c0560c4372d2fdb31e9edb28bcb419f50.camel@intel.com>
 <op.2jlti6g9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <7b53e155-2622-4acb-b7c9-d22e623e4cb3@intel.com>
 <op.2jqdjjd8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <48faaea8b24f032baa6a858a2909a5b4ace769c6.camel@intel.com>
 <op.2jrpgcufwjvjmi@hhuan26-mobl.amr.corp.intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <op.2jrpgcufwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CH3PR11MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: d518a8f3-a99a-4957-47e8-08dc3719ba3f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqY0G1+1pSNNXbN6IdMD10L7iT9RLNSKywSABQaaY5Zd7orGvz5lMoEmBkhqsZYGYxFCponKuqOYDWejy3p3/Pe+iTNGXwsj9PtKOeOvscMFeyNEXcsURyUkHm8Rm8jrVaCejdkUVG9nMTxIat1fxFMowd9FwuttZwHXOde64RKqSQuLD9gRXqOy1ajEZ75gSbUyFsv06ieJ7Gi+5LWpNknpusli/KtUl1oaSN1JqUzr/PAolKYuN54tktbjR67awmB/de61b6UiS0cFxWpTVZ79D1ST2PEuiuhkhr2jL1zQDuiLktIcaRC+Xnn/yKs2x6d8gNswv7T7AL1aio6FP7jFRgQbl0gDoCNV8bAz65E+VnU+Wcu6BDdEJHnfLmotDNOMfNjevsXVUFnGoh595h292s5IoVBrr18wgBg8pOZrud2I5qp/ZxuM3bW3rBAYaxtJ0QO4QGSbJefjRqnx0bowSaf4gAs76ZQ5ZnrdornCy6RbteYS93i4PeKi/dmdVuUBBNM9eO1w79IorX/CyWSxvbSx2vpchXBZE8x4/JXO3RbJjO0tOJZH5nB5q1X05cCP7OR2TUTEej9w3ECxe5gbkyrojoMmpKNb9PcxqHsv0kTwAgTwO1887DtqKOQvHtdxYHjEFErdlh1+9FeB96DhWY5nmD80t2A5yCuFG69yAb2spCiLRQFdREpTSbl8oft1toByIPswwompU8ODOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZExsVXZYNWpJRlY2OEtEejAwZlBPYjhDVk14QjV4SUIyaklkU1lhbEV0eVly?=
 =?utf-8?B?dGFmVFkvR3BaQXk5V2pKMUlYRENXRHpVenlCNm5LVGZaSU1HTGRlM0JHa3ZO?=
 =?utf-8?B?cWowZERCdTBIZWpRUFo2djBXV0xCUTEvVlNVbWNGNXRDU0RMSHIrQmVyWi9M?=
 =?utf-8?B?Y2NsRDQ2ZG9ZOXB6aXlnamNPZkhYSFZ0WnpmVGNlcGtpNFhub3hhc1hWWGMv?=
 =?utf-8?B?VDdmYjRNbm9yRUFmTWROZy9iVUE0aHhOR083Y1JuTFlIaS9wQmgxUmc3RTc3?=
 =?utf-8?B?b3MvT2FTYU9sd2NsM1dRMGNGNEJOMkVwK0gycVZQYTE3bmd5UG50emZQTzdJ?=
 =?utf-8?B?TjVpaEVFRURucHhBNkg1c1F5cjFhZEwwZk9FSXBqOHFsNzlzbTBTbmM5L3h0?=
 =?utf-8?B?cEVKeUhhVzRJbjlZYzJCNEpoV2JGSkZVOWtPUU1tbnE5QWFMM0d3c1JManZM?=
 =?utf-8?B?RlV6eFdBQ3d0MVlmSng0N2w4UXF5cDZCVmN1NzJVSWYzZ1dCbHdqelJKTWJ5?=
 =?utf-8?B?TkZJaTBlQmM3L3hGUWdmRFkvWlM3cmNFSjNqblVoY0x3Nm83OFhJK0ZwcFVJ?=
 =?utf-8?B?cWRCV09nTWo0N0NUdjhiRlVab08zMEpQL2dISW8zK3lRU09VRkdsaHl6SE1q?=
 =?utf-8?B?cWZySU0weUdOTDF3Unp2ajEvWVRQZnRkcUpXbkFaWGhJNWRWeUFxdncvZTUz?=
 =?utf-8?B?S05Vejh1OWR4VkNFVGlUcVowYlZOTTJZU3lYZ25IVXNvMEdrYkJYbnNrbEFw?=
 =?utf-8?B?ODJLZHg0YWF4TWNMSnRNbklqM0pMNm5IdmNtQUJHRlFVRlFxUXdBVzRqSTRQ?=
 =?utf-8?B?U09HQU0yZXBoYlp3VEpZU05GVENVVG9DcnhqK0czcjREUDNFeThXeUh2aGhy?=
 =?utf-8?B?aWFXRjlna1h3UFBtOTJROWR4dzRjUFJhTmVZMnJ6ZWQ4UFVmWXJVV0dMMXc3?=
 =?utf-8?B?OU9tS3ZZMjIzWkNmbVRpYjJMTXJmT0k0R2NBSHJCT2NIdkZpRjVxRkRreGhq?=
 =?utf-8?B?amhHOUp4eDFTb3lMK3hwaHNmdFM0NHBQVEt1MWp0QXpyaSszWlh0NTVoYmhm?=
 =?utf-8?B?YTJJVjhYNVRUcWVzS3dXMDZMOTVSMUpSWTFrZnQ2WjFwbkNEdG8yVE4yQ0M0?=
 =?utf-8?B?TTJ2L0R5K3lQbXFENXdHbzV3Uks1c1JZV29XUTE0SmlXeU8rR2pqRzlJN0M5?=
 =?utf-8?B?bFJoV0NZQVg5ckhsVDdxdzFjUkJ0Q2hPclBub0liZWQvSkxZMldubDhmNUZE?=
 =?utf-8?B?UnFGR0ZMckFIdjZpbmNUZVdSTVNkWGNsZ0JGUmdweEEzYlFJdU8vaGM5OHpQ?=
 =?utf-8?B?U1V3L2RkNHgrM0VSdWFVVlBQTGhnWlpRY3BqYUp0a2xjTmpQWXh5UUtKR1Bj?=
 =?utf-8?B?RXdhQmV3QU9lQ1JKVitPd1ZXQ24vdWxjWloxejIzOWlRUDA2cDVZS3lhTFo2?=
 =?utf-8?B?eXUvNHpSMHRSMUxSZHlYR0lBdWd5bnNQYmFGTXVZa3Y3TkdHR1BBakJEWUV6?=
 =?utf-8?B?OWVFT1lJY1BnZ0g3d1VjL2UyZjZQRlQ0TWNpM09jUldHUzJkRis1MGs3Rm1H?=
 =?utf-8?B?OE90cUtsV29RL09QdktZaWdPSm5iVXVjN3p3dHhrVlh5WVA5ckpBLzBmZkU4?=
 =?utf-8?B?alVEeDZBTjdoVG9KTUpMcFBCdUhQNlVheXl6MTB6UWp3QXBBLzFHQVdMeUZ5?=
 =?utf-8?B?MUZUN1FVNWlPaW52ZllMV2p1NS8vbGFUNEQrOENSdDRGdjIxL2hQam1LVTFj?=
 =?utf-8?B?RWdSdG5YQVNTSmF4TnhvMDVnc2FSN0VNd2h6KzIyREpxUnNMTjV4Wi9WdzlD?=
 =?utf-8?B?VjVQVEJmK1MrWWF1OGNFQVBEeVgzSHd3bHNoMzcwMkh3YWVueFpXbDB5ZDJw?=
 =?utf-8?B?WFJaeksrM1g3cnZHcVF6MGdGUmJTRU9EcmZKVG9wNFR3ZFlIRXYyZ2ROM0Fy?=
 =?utf-8?B?cVYwNlBLRFZpRkRqY0hhTityampxMm5wZkJzU28zU0RIeTMzdWdnWThON3c5?=
 =?utf-8?B?aGZzS1ZNNEZ1YXhZY0NoU2hQUWpHaGtJSHdTWkJSZ215SlhqcG1CaXhJR3BS?=
 =?utf-8?B?dnYzQm50aGFtYXNUTjlWRWVQdHpLai9paldtQ0VLZi9IS1VPMkZoK3paa2Vy?=
 =?utf-8?Q?su18AmIDhO9/jT6/aI31Rryu4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d518a8f3-a99a-4957-47e8-08dc3719ba3f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 22:24:42.0093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HM/rCV/qzjfe45CgfkTohcN2NO379hvwKGLSXZHfS46Z0RUmLEMa6zpXCEbljaA6AQTn5W0Yo4d4sjPH91KPGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8776
X-OriginatorOrg: intel.com



On 27/02/2024 10:18 am, Haitao Huang wrote:
> On Mon, 26 Feb 2024 05:36:02 -0600, Huang, Kai <kai.huang@intel.com> wrote:
> 
>> On Sun, 2024-02-25 at 22:03 -0600, Haitao Huang wrote:
>>> On Sun, 25 Feb 2024 19:38:26 -0600, Huang, Kai <kai.huang@intel.com> 
>>> wrote:
>>>
>>> >
>>> >
>>> > On 24/02/2024 6:00 am, Haitao Huang wrote:
>>> > > On Fri, 23 Feb 2024 04:18:18 -0600, Huang, Kai <kai.huang@intel.com>
>>> > > wrote:
>>> > >
>>> > > > > >
>>> > > > > Right. When code reaches to here, we already passed reclaim per
>>> > > > > cgroup.
>>> > > >
>>> > > > Yes if try_charge() failed we must do pre-cgroup reclaim.
>>> > > >
>>> > > > > The cgroup may not at or reach limit but system has run out of
>>> > > > > physical
>>> > > > > EPC.
>>> > > > >
>>> > > >
>>> > > > But after try_charge() we can still choose to reclaim from the 
>>> current
>>> > > > group,
>>> > > > but not necessarily have to be global, right?  I am not sure 
>>> whether I
>>> > > > am
>>> > > > missing something, but could you elaborate why we should choose to
>>> > > > reclaim from
>>> > > > the global?
>>> > > >
>>> > >  Once try_charge is done and returns zero that means the cgroup 
>>> usage
>>> > > is charged and it's not over usage limit. So you really can't 
>>> reclaim
>>> > > from that cgroup if allocation failed. The only  thing you can do 
>>> is to
>>> > > reclaim globally.
>>> >
>>> > Sorry I still cannot establish the logic here.
>>> >
>>> > Let's say the sum of all cgroups are greater than the physical EPC, 
>>> and
>>> > elclave(s) in each cgroup could potentially fault w/o reaching 
>>> cgroup's
>>> > limit.
>>> >
>>> > In this case, when enclave(s) in one cgroup faults, why we cannot
>>> > reclaim from the current cgroup, but have to reclaim from global?
>>> >
>>> > Is there any real downside of the former, or you just want to 
>>> follow the
>>> > reclaim logic w/o cgroup at all?
>>> >
>>> > IIUC, there's at least one advantage of reclaim from the current 
>>> group,
>>> > that faults of enclave(s) in one group won't impact other enclaves in
>>> > other cgroups.  E.g., in this way other enclaves in other groups may
>>> > never need to trigger faults.
>>> >
>>> > Or perhaps I am missing anything?
>>> >
>>> The use case here is that user knows it's OK for group A to borrow some
>>> pages from group B for some time without impact much performance, vice
>>> versa. That's why the user is overcomitting so system can run more
>>> enclave/groups. Otherwise, if she is concerned about impact of A on 
>>> B, she
>>> could lower limit for A so it never interfere or interfere less with B
>>> (assume the lower limit is still high enough to run all enclaves in A),
>>> and sacrifice some of A's performance. Or if she does not want any
>>> interference between groups, just don't over-comit. So we don't really
>>> lose anything here.
>>
>> But if we reclaim from the same group, seems we could enable a user 
>> case that
>> allows the admin to ensure certain group won't be impacted at all, while
>> allowing other groups to over-commit?
>>
>> E.g., let's say we have 100M physical EPC.  And let's say the admin 
>> wants to run
>> some performance-critical enclave(s) which costs 50M EPC w/o being 
>> impacted.
>> The admin also wants to run other enclaves which could cost 100M EPC 
>> in total
>> but EPC swapping among them is acceptable.
>>
>> If we choose to reclaim from the current EPC cgroup, then seems to 
>> that the
>> admin can achieve the above by setting up 2 groups with group1 having 
>> 50M limit
>> and group2 having 100M limit, and then run performance-critical 
>> enclave(s) in
>> group1 and others in group2?  Or am I missing anything?
>>
> 
> The more important groups should have limits higher than or equal to 
> peak usage to ensure no impact.

Yes.  But if you do global reclaim there's no guarantee of this 
regardless of the limit setting.  It depends on setting of limits of 
other groups.

> The less important groups should have lower limits than its peak usage 
> to avoid impacting higher priority groups.

Yeah, but depending on how low the limit is, the try_charge() can still 
succeed but physical EPC is already running out.

Are you saying we should always expect the admin to set limits of groups 
not exceeding the physical EPC?

> The limit is the maximum usage allowed.
> 
> By setting group2 limit to 100M, you are allowing it to use 100M. So as 
> soon as it gets up and consume 100M, group1 can not even load any 
> enclave if we only reclaim per-cgroup and do not do global reclaim.

I kinda forgot, but I think SGX supports swapping out EPC of an enclave 
before EINIT?  Also, with SGX2 the initial enclave can take less EPC to 
be loaded.

> 
>> If we choose to do global reclaim, then we cannot achieve that.
> 
> 
> You can achieve this by setting group 2 limit to 50M. No need to 
> overcommiting to the system.
> Group 2 will swap as soon as it hits 50M, which is the maximum it can 
> consume so no impact to group 1.

Right.  We can achieve this by doing so.  But as said above, you are 
depending on setting up the limit to do per-cgorup reclaim.

So, back to the question:

What is the downside of doing per-group reclaim when try_charge() 
succeeds for the enclave but failed to allocate EPC page?

Could you give an complete answer why you choose to use global reclaim 
for the above case?

