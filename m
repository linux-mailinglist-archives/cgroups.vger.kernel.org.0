Return-Path: <cgroups+bounces-8008-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 326B7AA96FC
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 17:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAC1189F74C
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62DF25D525;
	Mon,  5 May 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfB67pwf"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C07A17B425;
	Mon,  5 May 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457557; cv=fail; b=prehHEX9nRuh9lo/Dx0t9L8rPhruvxpioE4YAoOWJ8PBherVOtTXf9a3wcU1MWLtWGeZt5V5sTYw2Ff63BHF0A9/bxlpt8/g0x+3MEgPrmNf4OZ7xsTGK3Aj6lYbRSMvoYhtpCkzso3vbvpRDP7BdeBx7p1vOjMR4MB3VMMYE1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457557; c=relaxed/simple;
	bh=cecpNvad3KhiZmGk3Wo+2X0Cl21ma+4Tguu84qjiIls=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PR+VEgRENMB08VTtucpR+t6htdFLhteZcSVehL3n1ZkwsX/8fJtuwdQ55HdTtPZiuMzXCMKOiZGmIxUi+MDNH+u3Rx7YuMDuURVb0mA1rF95cFEM2bVKaDnYElvzB8xgTuvDtS1EY3runj3a4psRcRvsfGUwLt6TmkpdGHOpLPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfB67pwf; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746457556; x=1777993556;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cecpNvad3KhiZmGk3Wo+2X0Cl21ma+4Tguu84qjiIls=;
  b=BfB67pwf8IbRKGpxyTLsODp1z/55VWl8W7at+v+LoGBVrxNYmbdlZn5S
   nvf0u/R7554GVWreeVz+3zlYtyF8l/YYGBb/2J7XOgVo8MkP/Cp+4KQ17
   hdO3hle25IRlh1d/AkZGxkfoVw5H/DdjOtzFp+7Oi0yoBSm/ZTGWEAQAy
   i8MYJu94Vqx3ocS4iTbjpJtLRL6r/2AEF0vomT9aOFpjGs4vA7bD6d6kG
   Zks3ISg3Ba7rfCYWc5BdhS53sHcvwMLw7PrXqn2nU9V24mLM1SO/d0af4
   hKAcy0Cx6PeEA4EddYM6s6YNkHR4C/zs9ruKQDApfz8WcdzSE2NAhBNlt
   Q==;
X-CSE-ConnectionGUID: eRd6Hnn2RHKKcM3ONgq/Wg==
X-CSE-MsgGUID: SWYr8zoURkqFK1m7MhzpTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="35691518"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="35691518"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 08:05:54 -0700
X-CSE-ConnectionGUID: mjtiSBvlSeCK5FFT8pXFvw==
X-CSE-MsgGUID: Ug/dOuPLQtaorUG0AVpktQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135013778"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 08:05:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 08:05:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 5 May 2025 08:05:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 5 May 2025 08:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJKejSp+eKWhA5kcLYlu+dGD+2J/sEHcp8Z1H7f1gZnG3aj40pttkHc+W2q2xssS2tco/9EKfwNc5fHQfvVvvXQJnBMp8XsetwaYA6Fs/K1SSRcXzJJ74RPB91Vh50k5ZXEqQeARvwYG/T1LsVG6e+ZzUxc+A3kDPSdoS8zD+t65U2k5JaHgjl9eNkEJNMldEloIshaXNM1gmkU/fojYc0apI9JWzNbJ7Njw/emFZMmxGhoSx3VdskdRrcGIvg/b2kIunQ5K2oVDlvdUShiYpOY4iOw7VULRaFRd1W9xT+5VI49GocRsJa+gqYGe3Y9G3TbZUm0oJJ8y55q7RmgQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpZuVtCUwfIYC9QizyHsBpNfFO88BC944QeIfEWy6f4=;
 b=DqHm6+rxU1BUL8mn24l+Sek9UPx0e1376fWXYfqenRYHL4IBOZNskJlusd63iQkyiLDxccnjbAqlb6bOv6V+JsDWWoCFs8HDhZSxflF/scihgp9QupjsPrQzOGSkeGWnV4aQqLRza8dFlcplVviTBVyM48lL7shr3VYke/9YL1VIx07iwG5Q75KiiWzAtF7IGYT7m5aYikCHHh+y2llYnJRropwai1oyYAvWrrmbutlaBaZS5AKQh/Hz9jjibL9e9C2wPH6iaVbvS+3nWp+dVCC3y/PEamrY854S9jou6jRz4//zLRkYpHYy+eN8wFCjk71s6jJWndssUH1cjoDi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Mon, 5 May
 2025 15:03:24 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 15:03:24 +0000
Message-ID: <bd936eba-e536-4825-ae64-d1bd23c6eb4c@intel.com>
Date: Mon, 5 May 2025 23:03:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
To: "Jain, Ayush" <ayushjai@amd.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, Mel Gorman
	<mgormanmgorman@suse.de>, Michal Hocko <mhocko@kernel.org>, Michal Koutny
	<mkoutny@suse.com>, Muchun Song <muchun.song@linux.dev>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, "Chen, Tim
 C" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>, Libo Chen
	<libo.chen@oracle.com>, <cgroups@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>, <Neeraj.Upadhyay@amd.com>,
	Peter Zijlstra <peterz@infradead.org>
References: <20250430103623.3349842-1-yu.c.chen@intel.com>
 <8b248ff3-43ae-4e40-9fa4-ba4a04f3c18b@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <8b248ff3-43ae-4e40-9fa4-ba4a04f3c18b@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0033.apcprd03.prod.outlook.com
 (2603:1096:802:19::21) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH8PR11MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1ac87d-2e8d-40d7-bd18-08dd8be5fb5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEVCa1lWYXkySzQweFRna016cjhRMVdFZllaZ3N5KzAzTlBBOXFtdE9Gc2J6?=
 =?utf-8?B?aWU5NytkaGpxWUVhVXVTaEVXUHl1V3JZZnkvZ1I5S2lkcm83NUMwZG4rcnhY?=
 =?utf-8?B?eUdPSzRNSWpQUlQ0dHBkeVk3WEVqVXA5ZWQwYnB6RHBOTm5aVG1vcmdUc21X?=
 =?utf-8?B?OGFYM2dEZnl1ZC9iMkZrSEkvdnhIUlFNWk40MEZTakJsaEM1RzA0QU9adVVP?=
 =?utf-8?B?bWE4TUdYNWoyVDlKTFZ4eFVqNURISkhBbDh6Z042MFMya2xpY3lJQnZnbFlW?=
 =?utf-8?B?aGdRZzQvUHFCMFZmd3JDM2Y0WDBqaENlWkdjYStKU2c2Z1V3MTQ1TFhWZEpF?=
 =?utf-8?B?WCs2MXVTdUp3MHAxZ09wREdlZXlWNFVYRTlia0dLOFRNUHBEY2ZqMTFkMW1S?=
 =?utf-8?B?SEtSWmNUZ3dQY3A3S2h1U3RYTlBabmErZXRmdUtrSmVWelFLOENmVDM2dlVr?=
 =?utf-8?B?aitaakV6bTBRUmdXZDJvd1ZDdUJWemxvdzBLeVIyYzlscUU2bjFPK0lCL09G?=
 =?utf-8?B?YVNBaFhpcnZId01lNmNoa0w1Y20xdHNVeWNmZml3UkZ6ajJwZHNzbG53U2lL?=
 =?utf-8?B?SkJKY0J0bFd0VVo2YStqSm9QajVKeVRoVFRINzRYdGRDdGFBV2dHMklsMDkx?=
 =?utf-8?B?SWsyNEc0V2dtLzhpSVRVMUxCOVl5dzV2UnN5cGxrMlhpbEZ4cE1VTzBBRG1y?=
 =?utf-8?B?c3B2aWZiK3BqM3RrU0Flb0JDanZjY2pkVjJDb2tjT2cyaFRXS2Vlc0FINEVG?=
 =?utf-8?B?cDFaNEc2MWZ0QlB2VGljUmlIQXJKbXdYaWNwZHZ5VDVJWFpqcndrTnc3d2dz?=
 =?utf-8?B?VE1CRWdvT0hmcXRHY0I3L0FEM0hwSUdLUXVORU9icnNuRjg1UjhMcU9kMFJL?=
 =?utf-8?B?MjVSWm5DMkV6elZNSmFyS1NKeXBmSWJMdjVyZDB4cGZySFAvN2FqVktqWU9L?=
 =?utf-8?B?bUY1b3kraUt5LysxaHhkQVM2Y0xodUcvSTMvQVhiZzhWaWc3VGFzVjh6b2Mz?=
 =?utf-8?B?Rk84aUJpeVd0RUw1WXVBMmNwRjhLQ0NPOUdmQnNzeUlhQ0M2SGd5bC9HMkdq?=
 =?utf-8?B?V3lOZ2lteUdFdjVVSXE3bWtPVlVXQVI0UmZ0NWNLMkNRRXQvWGdyb3ZRK0NR?=
 =?utf-8?B?dTBTOXNNai9VRUFnaXlxODV2ZmIwUGRuMVFHV1RYcCt3ZjY1SlVkdDN1bGZw?=
 =?utf-8?B?QnNXbmJqZGdndFlrY2EweG5XMy8vS1J2b04zSkFKR2pXdTdxZkRVZHNCVm5o?=
 =?utf-8?B?bXFGdEE1RUdXSkhDM20rQUtiNmg1QlVwdFBnS3FHdC84bkJGazY1NHM0Z0Er?=
 =?utf-8?B?bDJZUkwvSVlVUGo0VmlsZGJqcnhDNmlNb0kxSHlVL2t0dnVQRGZYaXRnTGRp?=
 =?utf-8?B?MzBqZFJmY2NYZUN2c3dzZ2pFcytOQWVZMWErTm9WQ0twY0dVWlZSSmpCU2VN?=
 =?utf-8?B?a1d0NkV4eEdqK2IyK3lmN0VvL292dFhuS3VDYytiZzR0Q1UvYytpU1U4ZFFW?=
 =?utf-8?B?cmFPaHhwTmdjUUJmdEprTWVPb0llU2tpZEVnVGtxVXhVSUdtek9relA5NktD?=
 =?utf-8?B?Tlh5eTA3dkhLV0ZnYjBZNElIVmtoYnNVc0RjcXNKbjREc0FjdUlkMHpNUENU?=
 =?utf-8?B?M1plQytxek94WXhrRUcvTVlBTnV2WE1VNkZ1Sk1ibURCM2ZMcWZMdVFsYkJ1?=
 =?utf-8?B?UGpxakI2dG1La3pIM1FMaXVqa0VjZVlQaE82SEtkUjFmYWdWQi96VWtlNGpO?=
 =?utf-8?B?cC92eXBKcDZKOWNSRVRhQWp4SFVTWmZoL3l5R0dIWFhTck1URncxZklEK0dz?=
 =?utf-8?B?SmVIU0oyQ1g0R3lZQTVxVmRaK2dMaEgvQXFKSXpOMG9pcy9nVW8rd1g2U1V2?=
 =?utf-8?B?UEVvUWFBaFlQVlYvY3ZScmp6bWZtVWhiZ3RGaW5rbnRhcHFnVlNsR0xwSFpH?=
 =?utf-8?Q?nomaNlDs8bg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWpmQnY0VlBickEvTnRucjFRcmNBcTlLdHY2TmJCdkllS0l3cDdTOFNQNDhz?=
 =?utf-8?B?dm9NQlZwdVE5WG1aZmFoWVV5T1IyTHRUQzNRTXkvSGc3aTlGSElKQkxxZnhh?=
 =?utf-8?B?UDBvbmlZQmJzYmdpK2VxNmtzZmF4a1pGVjY0QmdlalNCb2dBRGc0eUdWWTFx?=
 =?utf-8?B?TG9UOThDY1I1NXdQWmVka3puSGxrNUF0TFVSL20wZS9ORWNZaVZMMjZ0YlFm?=
 =?utf-8?B?c2xjQ3poK1hGakxmemJ2RitMTDZ3Yk5RUHBoWjFGT0s1WTdrNHozVGpJbFlN?=
 =?utf-8?B?VGRhdDd2dmNuRXhvbmZOQkNBWmF6T2F0Vi92azR0YkFOUUhZQmRpbXF0ZTNY?=
 =?utf-8?B?WW5BMFRPam1qSXFDaGpJenhkSktZdEdRdUljb0pncURaa3ZkL3ZBb3p0UkpG?=
 =?utf-8?B?alJVR3JwZmNjTFZjaFgweEhZZ3h1WDIyYmpyN0YvUFVRN3JvWHlTcHJpNEtE?=
 =?utf-8?B?VjVCaW5hdDRtbmJEVkNZbUNPTWJya2tOVFRrcVAzbEh2dzRENEtEekF2NHNm?=
 =?utf-8?B?b1BiRlA0SmFEY2o0MzVvTU9ReE5ucjNtR0F4V0g4NWJIZ24xQzlkTnZTL3ZB?=
 =?utf-8?B?M0dNZkRtY1k1c0ZhRVBqQ3VFV3E4WEkvS2VDOGxXb0x4dmQxVTB5WjJRck1G?=
 =?utf-8?B?SDNzOEZzUkYxZEg5QzJoR2tFSnpaSk1YUjNCTlVLREE5M1Z5azZiODZyVkRu?=
 =?utf-8?B?UTFEYklRaUVvRkpmeVdibEFxOVdGZHd3WEY4b3lzblJTMFhPU3VSdWRxejMv?=
 =?utf-8?B?YVpqT2ttZStiQ2VVQ2VLRjQvTXhpY2w1ckdXcEJkQi95dmNuc1hEQzhoNGt2?=
 =?utf-8?B?TVFuS05VeG03RjBscHpIbWoranVubXRJckE2aERheDJaZU0ydDladGRscXl3?=
 =?utf-8?B?eGNNSys3L29nMEJFMDlFb3RsN2UyS2dLTy9YTGpjcUJRSUpRUnpYdWY2UlY5?=
 =?utf-8?B?NUoxMjNmeHkvakdiZ3dEaUV3ckR5MUpOeU00VVdNWmRFc2VaUUYzTjNQNmZL?=
 =?utf-8?B?ZU02TmcyckRiTXdZem1WLzBlaG16Mm1NMTVHSUNMdTBMWHFRMTU0eVZoOFVM?=
 =?utf-8?B?dTlrVEFMK3drejV5SXRKMHVpbHk1ckc3YlZObG5KdWhDVE9lL0oxOFJEcTli?=
 =?utf-8?B?ZTVrTWFRVVhVSFQvRnhEOEduYU8vT0lkNGl2V2h2cnNzUHF0REhPT1JIcE1Q?=
 =?utf-8?B?U3o2SUwydDltRjJTOUhUWlZQL1JmT2VwTFJmcjZ6ZGd5ZHZuTmZyUHZRMlNv?=
 =?utf-8?B?NUV1VFMwV3NuSm9BTUE4UVhsRmJCblhiWkpzL0MyOERuelVLeTd2UWFTL05k?=
 =?utf-8?B?MDR6MlhBT3ZpbkFBYWlVZnRzVkVzUHBsNVBGYVZXU3BDUXZSanRvcWNIVnRN?=
 =?utf-8?B?Nll4TTBRRjVEdDBGZ3Z1blpzUGNqUWlXYWk4Uk5wL2Jwb2hNQ1hrTCtuVE9R?=
 =?utf-8?B?V0VpTWg1YmpCM012TjlKNW1KS0g5dWZUam5xUXpsNEhWWXVvZFNTT3d1eEhT?=
 =?utf-8?B?WFVLRU92Ti9RTnBmdnIxeE0wSFRqMG5xOURwOEYxTWNLWGJjeHVmSitlcHRa?=
 =?utf-8?B?N1RSL21hbStOUy8rQjVHMGE0aHN3b0JFdjhFS1d0Tjh2MUJ5aGprcHhMZGFR?=
 =?utf-8?B?WUNYdGN4YW1idFQwUTYrNnZCYitoajBUNTAyNUdlRTllQkJqemxUUG9nZ2Qy?=
 =?utf-8?B?SGEwdkFUZm9NNlQxcTcwcE9KMUJNUGR3WlNkaGFwUEk1TU9PQVRyVm9oRDhF?=
 =?utf-8?B?czVyNHk3VjZzNVVhdFBqU2pQQ3BiN003T2s4Qzk4RWxnUlpHUldWWmp6U0tk?=
 =?utf-8?B?OVpiVUpNVGxmak5Ma3dkdEdzK1kwUDA1cGhYTDh0Nyt3R2p0dkhYM0U4MW1s?=
 =?utf-8?B?VGtsTVppbDRxb2grZ1hpaXA3Qm5PR3RJRE5IcnhqUDJsemFwTmRJbWZYSVps?=
 =?utf-8?B?aGpqUlR5ODQyNzJYRUwzcSt5OGZJek93a2cwTFdHYVV5eVM2czRkNmx2ZGsx?=
 =?utf-8?B?OWxJNHVXMytKb0dQZnhialZQNm9OeEpZWjNzdzc5NUpJVW5CSjQ5UkJ6cDYv?=
 =?utf-8?B?RUNLTHV4Vk4yWk5wY3dxKzMzTUlYUjgxd3hwczRvYW1PdHR1ZDJNRzQ0RlVR?=
 =?utf-8?Q?7tSFkLDvq8WSvXXCGXKGpC2Yh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1ac87d-2e8d-40d7-bd18-08dd8be5fb5a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:03:24.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+rZoOiRdTcHqOdDKG8bGNjpavV7vGLVOe59HiYe5q625QCfnbKe5Jg90fBO6uI27clE9rEvgeo+70stOI9rQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731
X-OriginatorOrg: intel.com

On 5/5/2025 2:43 PM, Jain, Ayush wrote:
> 
> Hello,
> 
> Hitting Kernel Panic on latest-next while running rcutorture tests
> 
> 37ff6e9a2ce3 ("Add linux-next specific files for 20250502")
> 
> reverting this patch fixes it
> 3b2339eeb032 ("sched-numa-add-statistics-of-numa-balance-task-migration-v3")
> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/kernel/sched/core.c?id=3b2339eeb032627e9329daf70a4ba8cd62c9cc8d
> 
> by looking at RIP pointer
> 
> $ ./scripts/faddr2line vmlinux __migrate_swap_task+0x2e/0x180
> __migrate_swap_task+0x2e/0x180:
> count_memcg_events_mm at include/linux/memcontrol.h:987
> (inlined by) count_memcg_events_mm at include/linux/memcontrol.h:978
> (inlined by) __migrate_swap_task at kernel/sched/core.c:3356
> 
> memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> mm->owner -> NULL
> 
> Attaching kernel logs below:
> 
> [ 1070.635450] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1074.047617] BUG: kernel NULL pointer dereference, address:
> 0000000000000498

Thanks Ayush,

According to this address,
    4c 8b af 50 09 00 00    mov    0x950(%rdi),%r13  <--- r13 = p->mm;
    49 8b bd 98 04 00 00    mov    0x498(%r13),%rdi  <--- p->mm->owner
It seems that this task to be swapped has NULL mm_struct.

Does the following help?

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 96db6947bc92..0cb8cc4d551d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3353,7 +3353,8 @@ void set_task_cpu(struct task_struct *p, unsigned 
int new_cpu)
  static void __migrate_swap_task(struct task_struct *p, int cpu)
  {
         __schedstat_inc(p->stats.numa_task_swapped);
-       count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
+       if (p->mm)
+               count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);

         if (task_on_rq_queued(p)) {
                 struct rq *src_rq, *dst_rq;



Hi Andrew,
May I know if we can hold this patch and not merge it for now,
besides this regression, Libo has another comment related to
this patch and I'll address it in next version. Sorry for
inconvenience.

thanks,
Chenyu

