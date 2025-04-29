Return-Path: <cgroups+bounces-7889-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 828B0AA0967
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 13:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81B31A85416
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 11:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FAF2BD5B0;
	Tue, 29 Apr 2025 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1R9zHcK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB541E515;
	Tue, 29 Apr 2025 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745925531; cv=fail; b=YQP0DLLHQIsKtz+4zd3JbZPA5bDfBgg5JKf5HoBPYNZQEoekxa3AQKd7bPB9mJYDLcpdV5YS/AQZ0mkrq/58zZ5G6/N7FiZ/EOQ4XNmlQTNugDyj1IK0dqvFmNxAucdwApfCHrmf/t8EEMfSHTsPMQ1DVNUQxz7eGwcWIj11SMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745925531; c=relaxed/simple;
	bh=oW7pO8/QjlvYqD6SrOsPFtUhBX7fsBDTo1t+6Bis9AU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DPA0Cocxl7blVVoUzRWUmVhyCw0QTDi5ir0KxI+EJF7flfsCKbHxf7kpHJVHawhtvJIe8VaL+ux3iau8OMov6/3nLwB04usifHlQ7Qi9ZRHdZ2nE18MBKOio7bCuaxkp3k4oDjSGMe48rygzLFC6I9a2hxKHLIB4teugZIIKmnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1R9zHcK; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745925530; x=1777461530;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oW7pO8/QjlvYqD6SrOsPFtUhBX7fsBDTo1t+6Bis9AU=;
  b=H1R9zHcKn9+Yhk4Zn4goE/ItVc+qkS7y/nR9KY7SMApsQuzM1uslNyUG
   AQGtCY/WiEYf5yWG0N7uzWItEB05oH9kDP7KdagPFuyy9hjMM+FhNvU+B
   P/Slc6JW0e43Oe0NVNhXDmAPhdt0vmjJhW2bUavJqxTetpAA38WacrCF8
   ltKnH6GvEpYIuUtW77MdShYtIVPRqd9BXma4nO9nUuQ3VZ5FCg6lhdQP2
   rqsHH/MVkUaeMXmBHqk+7QeCuzn/KBNJKzhhNcZiN2ur/n7+ag9qf/iDC
   7fN+vWjAGuiUckluc1H8xDc0oUr107cJOiU+AwpYtsCqSGfvlFl6+Ye9u
   w==;
X-CSE-ConnectionGUID: gE2ltR/jSS2UpJy6UGcodg==
X-CSE-MsgGUID: +354nPlbTB+A6PAScW3m2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58912320"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="58912320"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 04:18:48 -0700
X-CSE-ConnectionGUID: cQ1iDvWrTAu2a8MdmU8tLQ==
X-CSE-MsgGUID: W/Tv//7QSg+XediYhXPbgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="138604030"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 04:18:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 04:18:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 04:18:46 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 04:18:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlEw1pQOc58YGWn/JPmMzqixrCxhtFzCHoDMeUDsobcthbGdS791ETbqi2c9wIhB7bmxERUXy7dig48jcVKGj91Q/1GQWWZpk0Os7pu9N7TIyGZZOREYOD57bXWYkxIohpyIiq79PMvbwv0e0gSlTBsII0jT+ds2GMlJBptuwIYNBJxSuIwlXOCYD3S9MWlMxw1rjVNTtAajp53CxcM5LwmrqVKEGu7bvluQAT25JDwr+u+8cvVvz/3B721jAkFirdmQWfQP0xTnpqEI6bqqOedc2xvnUj1KtOBDyXKXlflP9wiUbdejN7I1UnJm5G6WhplLq2r3vDQEm2+4CldU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9HnegRDUii8P+G0Nj+EjWJ2sfplHLJgVf6OzF0y1V0=;
 b=dLvI5m3CJhH9sGXMepPEaPGezzrhex4CcRTP9J2Ol/01q1olWcy0g0HSMBlq599jFRiCIv/WdyrxLyj7sMWprnHB/gzsitMauQ+YzBZP9avoev7eh8Fy77WQov021GQvoRkWK0llFIStiLYE+rAb2MHDhm1m663e93KzrwOrTh4yRHuJpzZKKb8rAqBbCbdUJxZBm3qY1klhzvjLcq+sPCrQ+eNOxM1b9bNYRBjE/PVHESjxMrZEcIPKZf08uuJEK6CkZ/0F+NSA/ZalbfpKCDHtdpx8loOmRU/LUwFyEaWN0IgSgG4C6GRxTlRnJ21HG8IoRoFk9d6glq3Qw+5tYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB5094.namprd11.prod.outlook.com (2603:10b6:510:3f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.19; Tue, 29 Apr 2025 11:18:43 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 11:18:43 +0000
Message-ID: <8caab4ad-4525-4d11-8512-bf83f607bd76@intel.com>
Date: Tue, 29 Apr 2025 19:18:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/numa: Add statistics of numa balance task
 migration and swap
To: Libo Chen <libo.chen@oracle.com>
CC: <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Tim Chen
	<tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>, Chen Yu
	<yu.chen.surf@foxmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>, Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Jonathan Corbet <corbet@lwn.net>, "Johannes
 Weiner" <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, Tejun Heo
	<tj@kernel.org>, Ingo Molnar <mingo@redhat.com>, Shakeel Butt
	<shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, "Peter
 Zijlstra" <peterz@infradead.org>
References: <20250408101444.192519-1-yu.c.chen@intel.com>
 <9b64be76-b5b1-4695-97c2-bd2af777ec71@oracle.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <9b64be76-b5b1-4695-97c2-bd2af777ec71@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af9904e-8b38-4f47-49b3-08dd870f99e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czB4cnpEZjFFVWQ1eDdPVUxUSTlxUnppVjlkMFNKQXp5Qm5MVXpySTJQUEVS?=
 =?utf-8?B?VjlRS2lXZmZKbFd5b2tMNkhIODZYSGI0Q2JuOGdyMW56ajNkV0pMU1FSZnJD?=
 =?utf-8?B?blVqZzlRSUNVd2pHalVUYktLdnRpS0xPcmphRmdXS0VHNThtYlVYZXZubkRI?=
 =?utf-8?B?ZnYyalRlVVRBUWFEWUxybDE3RWdSZ1BadW54WkdsQU9ubGgrRm5STTlLMkc5?=
 =?utf-8?B?aE1QOVZ2UTR1VjB3dTI0RXhIWEZvNCtlTVJvT3JpZklFWm5pTWRrYmk5c05K?=
 =?utf-8?B?TnpEbENHdkJEenpQNkM1T2N1MXNYalJSZFdjMVZkd2lQT3RCNTlsR0d1T1pp?=
 =?utf-8?B?d2J4bnc4alRqRnRFNkg2a2orRFk1RHlrS0VKM081YUVUalBmc3B2L25EMmsw?=
 =?utf-8?B?ZjAvRHVyajFvdm9WdytTclBReUZPQ1NrSWNXQ3VjVzdzZTJZRWdlc1hSN3Nm?=
 =?utf-8?B?bFJLUFp6SHNoZ0xzSkFuQ1dFYXA0MnN1d24vd2k1UUJMOVFidzRmZDllN2RE?=
 =?utf-8?B?MkFLUW0xVWJDWnhnNG5QOWx2MnhpZWltbmZYaFFocGZNTTFWSXovalZoU0RX?=
 =?utf-8?B?MFZKdElvajlndW93c1ZsUlg0YVR1THVkcGVMa2h0MHhPMmRSU1JsZ1NwNXJX?=
 =?utf-8?B?Z2paM0llZFJpNDhOQlJuY3hCcHV4NFBkck42RmppQUNQNlIzMGxWdXBuVWQ1?=
 =?utf-8?B?eEFGdmdxSFc4VkQxVFQ4MWs1NS8remtoS3hxSmN1MzJ3SVBIL21HZDlUT3hW?=
 =?utf-8?B?RWpUcG5HTlY3aUMraU5yMERVSVh4cy9WQktjQytIbEFoWXJBaGIwSkEyUnlV?=
 =?utf-8?B?Yks1My9sTk4vQnpxUmpqVHMwdDhGQjg0MVEwZDYxMmJGT3B1ZnJBRmtoMFVt?=
 =?utf-8?B?dzc3U0F2cFhtaFpQaVZsaDhqM1ZWaktPUGVhZmhsRkxPbzFFVnRvbld4WWJj?=
 =?utf-8?B?SnBaR3VITk9ERzNHaW02WVUvcFhXNUxYYVF0eE9uWUpiMUZuNEFsRUs1dUZi?=
 =?utf-8?B?MDVmY1psSEdOQXNmcjZ4Zi9BQ3Vjam81WkdDbCtFcVIrMm0vT3pWaDlrT3Bv?=
 =?utf-8?B?Q0RHS0t5aHBzQkNVVk9SUkNWRkZmODRLeEE4Wm8wUitIck9SR3dFMWVxbkR2?=
 =?utf-8?B?THMrQ05sRnRaeFQwd2lJQm5WTW1Ob0Y4czRnU2ZjU3JKSURyRFMvWVo5Z3k1?=
 =?utf-8?B?OHdKUmlycDcweU9Hc2dYbWdzRzhyVWhvRzB1SjFsZUZiSDVFallLeFgyUUdq?=
 =?utf-8?B?NTh5WUZ6eEMrM2Y1YWFYb3o5dXRtYzhDSDBJZVk3Y1VuTjEzb0VuMTJBbjlL?=
 =?utf-8?B?ekk1dGVVMnJlNy9PbytEc1BzYk1yb0hVblh5bHEveVRDd2VPbUNJU1gwYVVH?=
 =?utf-8?B?dkRGZUovWmltMnF1Q2FKVm9LMncvOTNrK1FCMTIrYmlTaXkrenZwL2ZVTDNM?=
 =?utf-8?B?Y2Q4dnczWC9LYjlXSDAvNnp1S1N4a1kxdW9xU2FCdGlaSjJGWFVnRnF6Tnk1?=
 =?utf-8?B?OEpvRVVCRFk0cTBkdS9uTGFMNEdyOEFLTVNCTFB1UllTempmWHJLOW1tZTNh?=
 =?utf-8?B?disyTEVtbkltS05HL1pWYTFDUk9GNm5GTGpFL1lOdjNpYzM4UVBScHJkbTBW?=
 =?utf-8?B?dXlDYkIwcmpmNko0aEFTSGl0RGF1L0NGU3ZNVlNacWZhelROQVFnWHNzNE1k?=
 =?utf-8?B?QU5PQ0tXTWM3L1RCQnFqUVNqTFNOWFNycWliZzNoY0dYaUpQb1h3ZlZDRFRB?=
 =?utf-8?B?S3RLUFFQQzRKMy92QnBVZE1DeEpuVnpZcDhla3ZmY3N1aUVDakZZbDFsRTNn?=
 =?utf-8?B?RkV3OENVa1MvT1RQNjY3SklSRDFDUlVPNEdRNFBmSGZGaUpES2kzMFArS21a?=
 =?utf-8?B?Y1k1TlVYMmJObGpoSlQySDN0Ym0xaE1EK2ozak5idFppdTBNM1VUbjN3NWY0?=
 =?utf-8?Q?H9rJ7aYhbCQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2loaGRKdTNQTVFRc1ZOREw1MWdFYWc4WXVQQkN5dWlLMWcydFBIWjZha2Jq?=
 =?utf-8?B?M1ZkTy8zckU2dXcyNmJJU0FBMDlLcmFlemJBUGRUOElDS2JCZUY0RXdKZkkr?=
 =?utf-8?B?aHBFdmY3K1hYKzJGV015aStYTW9tdzhZM0k1NjZKSHByU0QybU1WdkhrbmVu?=
 =?utf-8?B?eTdxdnp2d2RnOTZZQ2dvckxDTkxtMkNZOVBZeC9NV2hKdGtldHMyUUdIdEpL?=
 =?utf-8?B?N0xraVNvN29RZE1yazdRek9SZmJIYnpVMVVJRTZUUVA2Zkg1QVQxdk0xTmQv?=
 =?utf-8?B?dW8zOWtYYXRNdXhWQi9VMU8yZjF6NzBuelBPL1BYaUkyeVlTeWVDc2lTaTl5?=
 =?utf-8?B?cXcwQmxHTFpHYkRoV1ZxZFdKTmlPYStYM05VbXdSdUtjZG0yRjZlNnQwOERT?=
 =?utf-8?B?TXdaQWlRcXpNUUVIamFreFg3K0NFZi84WGpNME1oUVhTWFVrc3NqR2x5S0pL?=
 =?utf-8?B?MmdaMnZkZk5qcDc4WWdpU0VlUThQUnd5N1c1Z3NzaHFDZ1FtMm9oNnNzT3Vi?=
 =?utf-8?B?Z0lONDVoVStaNitzbHVxK1docW93c2N4RmFZRFE5ZklBUXBKR0ZLQml3RVVG?=
 =?utf-8?B?TnFwcmE0S3ZzL1JqRWlsUVZhS3RWTGtnekxjSW5SdlF0TDhkMGFBTTRYTDFF?=
 =?utf-8?B?NHRyWS9JQzgxelh0d1hOTFNMZ0cybFo1STRwOUNUZVU0dEJYV0N3eTlvN21P?=
 =?utf-8?B?SUU5WHlCaHE3c1JPcGlmYlVxZ3BGc01GNCtqQnJQeDlBMFNpZUk4WUdkenly?=
 =?utf-8?B?RFlHS1NnWnRXY2MrQ3RzeWh5WU1aUGRwam5WbHNzUHY2QnErK1VyREViQXFs?=
 =?utf-8?B?RGl4RllxcFNyK0Mxa2lmZmQ5WjB1RnA0bHJCekdYS09wTC9MOUJkc3c2cUp4?=
 =?utf-8?B?QnhYVW1VaHZHQUVmTUQrZHFhenZmeG9aSW1FWHdwVzJzeFR3QmxrWno3Zmh1?=
 =?utf-8?B?RVFSUy83VmtiTm0vbzRGek54U21kTXRsVURjcVJhdFVaRytaVXlVaVBhWEdM?=
 =?utf-8?B?SVFRLzZHU0Z6NHNBNjcxN1NyUHlxd3ZtZ0NZZytOcjVWdkZpclNnK0JBNnVH?=
 =?utf-8?B?RElCcjRHZXdhQzdZMDh1RHdWQkltYnUvd1k3a2E1VE00azkzc1VZZ0NTRGtz?=
 =?utf-8?B?QjNnaEExZVF4VmhCaXFIOUFjYVBReVdOOUZoVWtMOFovenNpWjFiMWU4RHF6?=
 =?utf-8?B?VE1rcXdqNFJXcWd2T2trY0t4UmNlbXVNdlZDRWt1RWJQdzVtT1V5cUozaWRp?=
 =?utf-8?B?NzEyclR2VWV5MCtIU3I5ZitTTlUycDIvb091aElSQ292MGZTWVhZVmtXS2lV?=
 =?utf-8?B?QXpZN0NvUWhteUNDdy8raVc4dXMrWUJYMVpSZ3d1cHNPQVFWUWgvT0thbWxT?=
 =?utf-8?B?ak1iUmFaU2xpcXcwcTVIS0FLdnY4TnkwRU9ZSmR5Tnp4MWhCalFoSHlFTWEx?=
 =?utf-8?B?eFlxUXE1OVNKZDduSVlMUldPdUJMRGovdHFoQUlqc0poanlobG9vWVRFKyt6?=
 =?utf-8?B?VWNMMmFWSFV6eEw2SXRFa3c5Uzl1M2RwVGQweSs3NzEwQ1JhMU5TdmQ4OGxD?=
 =?utf-8?B?U3h1Z25DMEMrNXRLOWJrc0dhTTU2dmpuT3M4VHFqK2Y0NE1MK1Vtb0tDbVVL?=
 =?utf-8?B?dUdIanNVeUNxNzkyQ3ZHWWphbjFpSXdYL2FIRC9hK1o5bmp3bGg3WkRncUQ3?=
 =?utf-8?B?TzJoYXpPSVM1MzNLRnlCVlBNbzdiMEhoVDArNkN3b0Vja05Bb2t2YWx1QUor?=
 =?utf-8?B?MTFPS25jUk12T0dCUmRZUk9CREQ4cXNQdWRFQlB5Z3FRMGNsT002dDNINDg4?=
 =?utf-8?B?c0IrVXhZek9sTzVSRTZra0JTZkw3MkVGVEZ1OGlYL2RsM3EvOWZKbzFndTE3?=
 =?utf-8?B?UE1FcEVqSG1hZU8yYWdQNGZBVXorRE9DTW1tVlNPTnN0aWZGdTUzVUx5dE1R?=
 =?utf-8?B?TXBmQ0FvRU1MU3h1QUZ5ZlJuNVFBanJhaG5zOEtvN2FncFNaNTVDRFpQdnpS?=
 =?utf-8?B?Y3RJVHRxTEt6WEkrTm9yUjVCTEw0WWl3QitxSUJKRlgzK1RZS1Qzc1k1T1dC?=
 =?utf-8?B?a0UrRHBmQWVlYWJ3VzBkaXI0UzlYZGtQVmFlSWtxaDRFS0xOMXRvSFhPcUxJ?=
 =?utf-8?Q?VGHasQE+C518WruTmY8H9Jx/W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af9904e-8b38-4f47-49b3-08dd870f99e0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 11:18:43.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84PlLJMdF+EyEPRcWLC4GKC+S2b0xJHTEVRvIXM4zyL3ZXcplYWIw7hPmyblJihT2w95YDg4UpIWWc3TzH7Uaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5094
X-OriginatorOrg: intel.com

Hi Libo,

On 4/29/2025 7:10 AM, Libo Chen wrote:
> Hi Chen Yu,
> 
> I think this is quite useful! I hope it can be picked up.
> 
> I have one comment below
> 
> On 4/8/25 03:14, Chen Yu wrote:
>> On systems with NUMA balancing enabled, it is found that tracking
>> the task activities due to NUMA balancing is helpful. NUMA balancing
>> has two mechanisms for task migration: one is to migrate the task to
>> an idle CPU in its preferred node, the other is to swap tasks on
>> different nodes if they are on each other's preferred node.
>>
>> The kernel already has NUMA page migration statistics in
>> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched,
>> but does not have statistics for task migration/swap.
>> Add the task migration and swap count accordingly.
>>
>> The following two new fields:
>>
>> numa_task_migrated
>> numa_task_swapped
>>
>> will be displayed in both
>> /sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched
>>
>> Introducing both pertask and permemcg NUMA balancing statistics helps
>> to quickly evaluate the performance and resource usage of the target
>> workload. For example, the user can first identify the container which
>> has high NUMA balance activity and then narrow down to a specific task
>> within that group, and tune the memory policy of that task.
>> In summary, it is plausible to iterate the /proc/$pid/sched to find the
>> offending task, but the introduction of per memcg tasks' Numa balancing
>> aggregated  activity can further help users identify the task in a
>> divide-and-conquer way.
>>
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>> ---
>> v1->v2:
>> Update the Documentation/admin-guide/cgroup-v2.rst. (Michal)
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst |  6 ++++++
>>   include/linux/sched.h                   |  4 ++++
>>   include/linux/vm_event_item.h           |  2 ++
>>   kernel/sched/core.c                     | 10 ++++++++--
>>   kernel/sched/debug.c                    |  4 ++++
>>   mm/memcontrol.c                         |  2 ++
>>   mm/vmstat.c                             |  2 ++
>>   7 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index f293a13b42ed..b698be14942c 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1652,6 +1652,12 @@ The following nested keys are defined.
>>   	  numa_hint_faults (npn)
>>   		Number of NUMA hinting faults.
>>   
>> +	  numa_task_migrated (npn)
>> +		Number of task migration by NUMA balancing.
>> +
>> +	  numa_task_swapped (npn)
>> +		Number of task swap by NUMA balancing.
>> +
>>   	  pgdemote_kswapd
>>   		Number of pages demoted by kswapd.
>>   
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 56ddeb37b5cd..2e91326c16ec 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -549,6 +549,10 @@ struct sched_statistics {
>>   	u64				nr_failed_migrations_running;
>>   	u64				nr_failed_migrations_hot;
>>   	u64				nr_forced_migrations;
>> +#ifdef CONFIG_NUMA_BALANCING
>> +	u64				numa_task_migrated;
>> +	u64				numa_task_swapped;
>> +#endif
>>   
>>   	u64				nr_wakeups;
>>   	u64				nr_wakeups_sync;
>> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
>> index 5a37cb2b6f93..df8a1b30930f 100644
>> --- a/include/linux/vm_event_item.h
>> +++ b/include/linux/vm_event_item.h
>> @@ -64,6 +64,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>>   		NUMA_HINT_FAULTS,
>>   		NUMA_HINT_FAULTS_LOCAL,
>>   		NUMA_PAGE_MIGRATE,
>> +		NUMA_TASK_MIGRATE,
>> +		NUMA_TASK_SWAP,
>>   #endif
>>   #ifdef CONFIG_MIGRATION
>>   		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index b434c2f7e3c1..54e7d63f7785 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3352,6 +3352,11 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>>   #ifdef CONFIG_NUMA_BALANCING
>>   static void __migrate_swap_task(struct task_struct *p, int cpu)
>>   {
>> +	__schedstat_inc(p->stats.numa_task_swapped);
>> +
>> +	if (p->mm)
>> +		count_memcg_events_mm(p->mm, NUMA_TASK_SWAP, 1);
>> +
> 
> Is p->mm check necessary? I am pretty sure a !p->mm task cannot reach to this point,
> task_tick_numa() will filter out those tasks, no hinting page fault on such ones.

Right, kernel thread is not supposed to reach here.

The swap task is obtained from env->best_task, which is assigned by the 
functions task_numa_compare() and task_numa_assign(), iff that task has
a valid numa_preferred_nid . In other words, only when the swap task is 
a non-kernel thread will it possess a valid numa_preferred_nid.

Let me remove these checks both in __migrate_swap_task and 
migrate_task_to().

Thanks,
Chenyu

> We can add a likely() macro here to minimize the overhead if there is a reason to
> keep that check.
> 
> Same comment to the other one in migrate_task_to().
> 
> 



