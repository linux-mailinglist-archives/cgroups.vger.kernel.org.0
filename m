Return-Path: <cgroups+bounces-7309-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F4CA79A42
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 04:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99461887BEE
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 02:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC0218CBFB;
	Thu,  3 Apr 2025 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLYJfdIc"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7A18CC08;
	Thu,  3 Apr 2025 02:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743648976; cv=fail; b=uQ4swB5CH+k8BkZYziSB83L7WLWlq6AY3lU0JT66++faDIr9AYiLztF7kwrjvVJ/Wb9R1N29yKEMNirthQZHeiSaGlPR6BaRMCOn20nCocSxZHzrMRxk3PRiTMqWtu7QmPcbQGeIekcgoHSksfrii2QG8Msy1VBxWU+jjhgU5nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743648976; c=relaxed/simple;
	bh=BKAJTdBdKDj6NXlBBtu9hnXxXXsvJ+uMjqVTnT7L7xc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J+Z7+F/b4ZWA2TSNrCY/rHWnPoNtrfNoCdj5MRSZc3OLK9TK8OKOFKxhjJwAGPLnxQXI5/s46AmL56+98UGM63rjxqoNEeEAwsg+EqJb29GadycLdmte8xN6xM4hWPwxzHz8GA+wWf6Jm3IX5jaAqpxrB2ouJJ2efPVvywgvqlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLYJfdIc; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743648975; x=1775184975;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BKAJTdBdKDj6NXlBBtu9hnXxXXsvJ+uMjqVTnT7L7xc=;
  b=aLYJfdIcvPVV0zvu5GpK4vqJi8/GstS2DZowgec2elqIP1CUphvkDYK/
   phUMZyGBC8r9fi/wKwJ47nF/6Gaim9B2428vItexPxFvsIzgoE4ewTO+u
   BTlrfoYRuLPLrAq3JmFr+Cpu9466Rge2Syzq82PaYlV/AZVWfSDVGGanS
   RO9K6XBVmPHjFVy9OT2zYz4wWV2884qKh/pO2Q4SOP9xTeIzNnid5MWJ/
   K8f4YeiT70uOXZR8JBnFa1tx0GrGDJpLv8219TCluP2//fC7CmIggogGL
   WODpVrf9gSLbu5oOWHTtb6zGO4Vga6YfsIHEPGo8a4kkDIpTPkhLKgvTZ
   w==;
X-CSE-ConnectionGUID: eRYDuOqVRYSk6+asKa7JuA==
X-CSE-MsgGUID: vW2SEjekSVuZpXFN45EPcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="70407141"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="70407141"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 19:52:22 -0700
X-CSE-ConnectionGUID: HA1diOnvSJe8mpGOqQ6Pcw==
X-CSE-MsgGUID: RSZ/MUIDQhW7cFumovo6Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="131004843"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 19:52:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 19:52:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 19:52:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 19:52:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwIOOK++zLF607tlowPlmASzOAgq3bFLLGkSQyUdtIIJzakY5YIRs7JGXlSW8cBq/grrzBfClnbcoLuuRTczL6WdN0zn8yyu0pYRc3jLsikaa1ZeE/goxhgRXNi6orxnBOSA/d/iFpiqPsrFX7T0uB/qhbsnPa4dE9D4Yo59HkxcDcSmfqxy3niH80EPiBYcDTwuTYFAfx+P56QpePwCne8q6ux3VD2G4dr9Jos2AmwBetwEoF6ygPQc+NdGXfe7t0YzFlblAW0t8HqJRHmeEmfSVgc0AEqWX4X5BZUVDtAE8ISbu1ATk5uMGZJNOlrC0cp6EJvepX7MFu1dObzAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q6yhMYA0omH0MfoqHQ1gifOdzlkKT5ERJRByfEzWLM=;
 b=E4wpmjrLOhaISGM9tLqI/KIxKwnVg1yp4g6Icfz1bdfLsPR9pm0VrRu/ILOs+uaEBgOxnSQAciJ1O0lXfZ9se67m+027V4EIdnWBKjv/n3vg31q1oU4efl6c1/q2d2fTSCCainIWxszJMjWCy7Jb3nizbCCPJEeuTw8Bjq+Yw+ztcd7QTfk9ylnQZiVrpvWOMN/fRQz5UF7Gg57uVWDlMqPXXE5MF73gFNXpylv5vF8z5ZoJhtBENemH/ygJHWzJ/92oP7q/t/ePPWfz4r7anUT353rFK3VOAsbU9OS/4ehnlfMQwyQ0LldWt+P3BMPvBoLDNGxkoySN4YSB6qBe2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CYYPR11MB8357.namprd11.prod.outlook.com (2603:10b6:930:c5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.42; Thu, 3 Apr 2025 02:52:19 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.8534.048; Thu, 3 Apr 2025
 02:52:19 +0000
Message-ID: <1922ee95-cecd-43c6-8396-18ad952ba6b9@intel.com>
Date: Thu, 3 Apr 2025 10:52:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/numa: Add statistics of numa balance task migration
 and swap
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>, Johannes Weiner
	<hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, "Muchun
 Song" <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
	"Tim Chen" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>, Rik van
 Riel <riel@surriel.com>, Raghavendra K T <raghavendra.kt@amd.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Xunlei Pang" <xlpang@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, Chen Yu
	<yu.chen.surf@foxmail.com>
References: <20250402010611.3204674-1-yu.c.chen@intel.com>
 <44b7d213-cca6-45d6-a48a-a3f358e7bca3@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <44b7d213-cca6-45d6-a48a-a3f358e7bca3@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CYYPR11MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b75e034-ed78-4149-552a-08dd725a8c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHd1Q21vUFQwMHVidXpJWm5TWjNCRjVlYndJaFFScm5ub3dPQytyUEFGcHRD?=
 =?utf-8?B?TVRBM0QyTlJYcWdGYitqVVU5bXdtQ2ZyVCs1eEZISm85VUxsSm94cHpBbTVn?=
 =?utf-8?B?Z3MyY3RUdkw5dlI2Syt3VFVnZFAvZDFNdkZWMWJBQTg4QTViY0UvWnMvbnRM?=
 =?utf-8?B?amVuaWxiSlJrckpxS05jQTErODAyN2w3MlQ5WWdwT1RLWnRFMW9ZK0N6RUp3?=
 =?utf-8?B?Vk1jNm9vY3JUbDNGdVc3bm1adlUyaFMzZUJjZmpXU0tSSDdGOG5ZQVRVWEtT?=
 =?utf-8?B?WElweTdTSFpMUFRyU0xWK3FjY3lTNTIvMnFZREdkMnZ1bWVnYTBhMDdVcy9v?=
 =?utf-8?B?cktPRnlqQ2VYQ1BOLzNqUWZnWmg4OVJNRmdVRzJSWkorZHVpWHRFWkhmczk1?=
 =?utf-8?B?L0x4cWNUWUlZYjEyUXZ4Z1FDN2dTblE0ZC9vSW9xSSt2a3FnK0lNaG56LytB?=
 =?utf-8?B?MkVuUGhad2tGQWhURDRQUXU0UHhNY2JkajFJTUhmNTJjU0x0KzM0dFI1dkNE?=
 =?utf-8?B?cTdYUlJFOU9Vcjl6b0xjMmYvL0M3UTR6T0M0QmpEVXZxcGUxV3VxekJVbURh?=
 =?utf-8?B?RlNpUTdtVy9EZ0QxcElQYjNkdHhrYXA5UXZ2S2NEZmhzRGRmWmRxRjlVUGJj?=
 =?utf-8?B?Y1Z5eVdpc1ZlYmZyYVJmeG5VeWJoN0poalhhUVNkUVBMdGZIMkJHNFlKR2Rq?=
 =?utf-8?B?b1VlNVc0eTJsa3RSN21CMVRHVXIwbnNlTUpPcW1qeFVaQk9odVdnQThYUHJL?=
 =?utf-8?B?ejF1ZkRja0U4eWpjb3BOTE1qc1FiWEh2Vkl1Q2VzVjlZQlpIaXdDYk9qQ2Z4?=
 =?utf-8?B?NDM1UG84dGNGdEE1bHpIM2ZHQ3RVU09xMXJpL2xIdFBwMUFtTU5OSFNOKzhn?=
 =?utf-8?B?Yk50YUtEVTk4VExvN1pxV3hyN2FWUnJnRVFyMGp2QW1qbTd0ejkxSHNhQ2NT?=
 =?utf-8?B?MHFsdlUvUHdQQm9iL2pwTFdSUTI0dkQ5UytmN0RLN0FUVTQzanFpbUVRTUpi?=
 =?utf-8?B?MFMwSkFyVEhnRWdDSmxieldXc3ZkNVBrdGdZM3c0TDBGOTRYQWR0NXZpMnlQ?=
 =?utf-8?B?ZXBxQUwxRU04VnNWNks3M0tWcjcrL3BpaGI5TU02ZnFOejdhczZKZFFMbFVD?=
 =?utf-8?B?c3U1MEhEd2tack9MSHZJVmt5bDM1c0RMSWdicEQweVlob3BQeUNJZE0zZ1RK?=
 =?utf-8?B?UTRieWxNa2lTcGRUdlZVWlcrWWd6SXIwbEROdUQxeWp3Sk0wR0tPWVFNb2RX?=
 =?utf-8?B?YzAxdnlPc1lqWERCTkNXNlYwRE90RTZoYWZRcDBzaVpwTG8wQVgwSys4OU9O?=
 =?utf-8?B?TnhnNXAxOTdoS1pJbzhvYkRsMjR6UnBYbDY0d3dTZnBobk1INjlSN09EMUJy?=
 =?utf-8?B?eG1aNHFDK0h1aDMvY2JIZW9rNERBbUtIeG1iTTIyYXNDeEZESHZLMHR3YlJW?=
 =?utf-8?B?Vi9hNWtlQ0kwVC9MTWt4SzB3QnlqVVlBaVJ1ZDlKcTdleXZpcnQrN21Uam9p?=
 =?utf-8?B?QVF1dm14UnNkM094Q3dlRk1xdW1xS3FGUXFHeXVYc3RqQnNrSTVQUnJHbkxQ?=
 =?utf-8?B?M2J2NkhraE5lTTl4WE5QMmI5eHg5SUQvSEhaSWZDVGhoWVhQa2FkTnRvZkhV?=
 =?utf-8?B?WFJhUG10TW9UKzRyK1Z3czFnUit0a3lZbGErK0xXWEdGVWFFNXE4ZG1TVytU?=
 =?utf-8?B?clp6cU9KUGxLa0xsMDZ0bERkcDZxbW9MSytoQnY0VXYvMUpuSTdPUXh5NGVJ?=
 =?utf-8?B?YmVZUnpWa0d5dDRkdFBwZUpDZHdIMkV1TnJCUlh6VWdzOEtoWEJJUEZ5QW9I?=
 =?utf-8?B?S0phL3Q5NEpZNnNxUVVwUURjemNmTEdGMlhwQ2ROS0dBUWJacnF0V1R1czdB?=
 =?utf-8?Q?coNYz/ThLD4qx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUg1MGQ1d1I0Y0JPQXpGbEVFVmZDR3BKUDZtbnltNk1FQ2todWd4U3ZRR2JF?=
 =?utf-8?B?aSt2VkJVM2pkblFNS2w1a3ZtMExmQVMzYm42d3NkcTV4QjBvM3ozempWaG5W?=
 =?utf-8?B?eUpLTDR4MjhXMUtzNjM1ZnF2aFBMSXl1cVdpMzgrVEV2OWxXbWFtK1VjWHdV?=
 =?utf-8?B?YUptYTN3OURPbmFBRnRFdDFiVm1HU05zUDJtajlHNm1KbnI5REZkeEkrc2p0?=
 =?utf-8?B?OVlpeXpoTFVVVHVIYWIvVlNYcUkxQlBxUnJpVVhxQ2hDUnRwR0VQVy9QZlJh?=
 =?utf-8?B?WmRTNmFXVGszVTZPTE1HM1JlZWJJbW1uZlVWdkVqWlg2T0JUUklLbU02VkRr?=
 =?utf-8?B?VGlsdVZXcC9hS3kzVC9Qakd2K1Zaalo3aFRIcDdzVllhQlozcWU1NGduMENS?=
 =?utf-8?B?QXkwbkFWWWtteDlKK25keXlOb3BoM0RldHhoZ2xGUnpwK3k4YXMxQTJoRDdr?=
 =?utf-8?B?U2l1M0R1WkcrcnZacmFhNXl6TUNmSXBFY2ZNMHpOQ0xjaFF1UW8reDhSZHlI?=
 =?utf-8?B?RTl5cXBjcm4vNW41WkVBL3VSK0o5ZzBjZlVaYXN6T2YyeDkrUlAvYTR6WTlS?=
 =?utf-8?B?S2hibmYxdmJKcFJoM2FNY3pDYWNRSlNnSHBLRTlUWkNYQm1oYTZBc0cvQVRr?=
 =?utf-8?B?RXNkRFRqcWNZelFTVEJlUW9KV3JGdzZkYjI3U3NTekdMMk15b2tzUnExRlhm?=
 =?utf-8?B?VXpzRjIvMGhFRGFNTkRhcDdsSlZjL2F2NWxFWFI3eW1mQkpwNkdHWHlDODA5?=
 =?utf-8?B?T2diYWM1ODZJVDhtSzZjOWNUQThDR0RTbCtkNGkyKy9SYmU5dTFtVU84enM5?=
 =?utf-8?B?UjBzeE1Mazl5NS8rejJnY0RIc0FQdStpcU0rcWI2dFdkemdmV1B0NmdNNlZN?=
 =?utf-8?B?aTJER3VUTzBGWmpDM0dQaTByUEN4dUkvYUE1cFNTNUxLai9vRzBDbzRhTHNH?=
 =?utf-8?B?V3A3TXpXSnVKL0pjNEE3MFlaTlZraXcxb0xRMi9tOEpZWW9naHR3aURQLzc1?=
 =?utf-8?B?YWJWc1dMT2k2SjRrRy9XWTJrOU81K096dStwb3ZicFJ0Q3hKRHJuZzdzaURu?=
 =?utf-8?B?ajMvbFVvR2t1Wm5Ic3YvMk9ZbllNWHozb29vOWZBM1pUejBacjlVVGNIRzIw?=
 =?utf-8?B?d1lJUFpIN3YyRVorQVY1ck1YRFNoK1U2dmlxcnRvOEFrZkFPVXEyaXRteUNX?=
 =?utf-8?B?aU9xNzB0WjM0SnRxemdHZkxMUUsxaXJsZjFHZmkrblh3c1VuK3A4Vm1qMHNI?=
 =?utf-8?B?bTdKNks1dXYxQ1UvZ3FiS1ZFY1pmQkNNNnIreDJabFBXUlgyMVlxQ3V1OWhH?=
 =?utf-8?B?endwajJnRlZsc1FHaE5oZ1czVnBlMll5d0YxUTdTVU94d3JOcTJCeHU2VG1R?=
 =?utf-8?B?Wjc0MzRWN1J5VlJHV0pTT2FXQmttSkQyUXZ0amRpRmdHQng3b1dlNVd6RW9O?=
 =?utf-8?B?VnVMZHBaM2hNTEVGNkYwTFdJNmN5SlRUU2FrYlRQTU9JRFJhd2gwWUsxemNj?=
 =?utf-8?B?cmEwSlh0QllnaDJtY1BkQi9FUkdNOXNCQUNxWElMb3ByQkRwd1lvNVpEMTFB?=
 =?utf-8?B?SU5mUDZsLzVlbWZHVW82WGtUa2tkeGFCUHpDRmhUREtrOFI4QVplT2RFbVpD?=
 =?utf-8?B?TWJDeG5wTXE2bng1NU9odndJMXV4SDR3Rk1hK2twZnM3N2FYUGtPRk5zR0JJ?=
 =?utf-8?B?amY5QS9nWnlEaEZ1L0xmcnJjcmpsNnNQdUFXeHcxT0Y2allvK2llUnBMdlRj?=
 =?utf-8?B?SzBldmZuUzB1TmlGSjhtTm5pOFBXRi84MkpCSTBzY29uZzZZZjdJYmlIajhF?=
 =?utf-8?B?eGRlWUYyeVBtRmthYjcvbk55NW1kd3FqVklhS1d4UU4vYXBwQXVOVWJ4K01t?=
 =?utf-8?B?UjFOQjZJMWhicUNqa3draUIwTmQrTzdWRmxXbDl4VDZSZWVXamNmbkd0aTVw?=
 =?utf-8?B?RWhEZEhacWxBWXdGL3RjQkI3SmpFN1Z1anRDK0IzOURlcmZYbm03b2hadHRL?=
 =?utf-8?B?ZjRRQVhPLytYbE1WVFNzelluU3NWWHpTV0d2Y0packdUWS85SHIxNWRHWmVa?=
 =?utf-8?B?WVNONlJPbWFDUjhnUjJTSlQ4MUh6Smo4MmE5VWcwTmhMZVV3Q21NSXQ3dGRm?=
 =?utf-8?Q?6p4s1KlH4gENsPdRxBqoYlkjK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b75e034-ed78-4149-552a-08dd725a8c97
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 02:52:19.0803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYJ4tyO3czW+vIrbdgvjgswEsopMfqOnqEvTdbBxuuDqEYlw1HHq1htyAjRKw9i4ATf3N1pp0u5t5EvK77GOzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8357
X-OriginatorOrg: intel.com

On 4/3/2025 2:50 AM, Madadi Vineeth Reddy wrote:
> Hi Chen Yu,
> 
> On 02/04/25 06:36, Chen Yu wrote:
>> On system with NUMA balancing enabled, it is found that tracking
>> the task activities due to NUMA balancing is helpful. NUMA balancing
>> has two mechanisms for task migration: one is to migrate the task to
>> an idle CPU in its preferred node, the other is to swap tasks on
>> different nodes if they are on each other's preferred node.
>>
>> The kernel already has NUMA page migration statistics in
>> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched.
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
> 
> I was able to see the fields and their corresponding values for schbench:
> 
> numa_task_swapped                            :                    2
> numa_task_migrated                           :                    0
> numa_task_swapped                            :                    1
> numa_task_migrated                           :                    0
> numa_task_swapped                            :                    0
> numa_task_migrated                           :                    0
> numa_task_swapped                            :                    1
> 
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> 

Yes, the sysfs schedstat has to be enabled. Thanks for your test, Madadi!

thanks,
Chenyu

> Thanks,
> Madadi Vineeth Reddy
> 
>> Previous RFC version can be found here:
>> https://lore.kernel.org/lkml/1847c5ef828ad4835a35e3a54b88d2e13bce0eea.1740483690.git.yu.c.chen@intel.com/
>>
>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>> ---
>> RFC->v1: Rename the nr_numa_task_migrated to
>>           numa_task_migrated, and nr_numa_task_swapped
>>           numa_task_swapped in /proc/{PID}/sched,
>>           so both cgroup's memory.stat and task's
>>           sched have the same field name.
>> ---
>>   include/linux/sched.h         |  4 ++++
>>   include/linux/vm_event_item.h |  2 ++
>>   kernel/sched/core.c           | 10 ++++++++--
>>   kernel/sched/debug.c          |  4 ++++
>>   mm/memcontrol.c               |  2 ++
>>   mm/vmstat.c                   |  2 ++
>>   6 files changed, 22 insertions(+), 2 deletions(-)

