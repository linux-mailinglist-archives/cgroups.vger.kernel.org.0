Return-Path: <cgroups+bounces-7307-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7666A79A39
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 04:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AC6172AC2
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 02:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADA118DB17;
	Thu,  3 Apr 2025 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9shY6Nr"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0FE14386D;
	Thu,  3 Apr 2025 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743648863; cv=fail; b=I1O988WDl9YwFwIu0n7F76dTPbLDDA4H2+HacLtTWk3g25YsvLUdwp6CJ07zgl1kmYhJAaOjZKEKNRbGmQfRp8GPMz4SOcJfiSlWmqLBQbgs3yYzn7HdQ/0ebM3H6Xs8+0YqZkf2r745SKq4WnngDokQ/UYycY0036AsEfTpBsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743648863; c=relaxed/simple;
	bh=Aw1r/tSZmIg26oQjaRtRhBV5WJXFOVfMMKM+6Kh8wD0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q9Zf+JM6m8WoJYtWWbQfNHI5CoVd8SV2KjgvmwjREDFFLkVtZ4ppnttVlIBbtxnq8cho1em7pDJePGkqLDuc5E2HVY4oFt+r2uxWc/yyzMAswzS4Ne864PxRRTOSwnjguW44ktdl6ShyKHXVtCN4tBos/Ghxt1MEWYj5iMWSrB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9shY6Nr; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743648862; x=1775184862;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Aw1r/tSZmIg26oQjaRtRhBV5WJXFOVfMMKM+6Kh8wD0=;
  b=f9shY6NrnVAiEQaNCOSXaHMnOYGddSUTk42Y+OG9PULQiKB9DrrtZxxb
   hHHvzcQRkOc0/EuPeoVCBWJhibcBzjBJiRiqkZv8/f3NSFQMS+Lmeb7Fr
   0qguiVi+8UGyTmrBT2PS/h0js8QbBAokLWJVK+TvZFL2NdLo/GwYWVNRo
   ZxS6ETY2yoGxol+jWr2MZIY2AfhFdNNVdoG16wBcz7z+tiwsW4d9LD9gW
   c3YgAUM8SHA9mcPwSg2P1Q3TJBKlEsVuyeBLwO5KK44pPTSdIKpUn83Hv
   J55HJxH8INL5kkqAuV2GNOz6vgirEBrSVKggDmqYh550IhgGY087YSuWT
   A==;
X-CSE-ConnectionGUID: 82yc1hTATXCAm2PZ4IPA3w==
X-CSE-MsgGUID: tMR1la5eRGq1ljirEvHI5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="70406796"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="70406796"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 19:50:31 -0700
X-CSE-ConnectionGUID: xAHLkZKhSj+xSuo7ebPmkg==
X-CSE-MsgGUID: g0gwN9BlSLSSEjqqr5VHeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="131004049"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 19:48:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 19:48:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 19:48:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 19:48:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZpxkS6MafBc+h+h14Lli1Vz8ytcJEmzRMLBwW7AxD/YZCKkDxXYZc2tkS33SGGijPPbYz5wmafcfmja45bPCE7OCLCdKkpK+slVgLvy7HvjLtgXzUgNgCmYgmda+AS47yrojvkuzLV+/g9Pl6g2TGV5MQKiBohlBJ7/8AkSNbLWIAYMI57+Y64v5tCE9OOQZdyjQRKQBiUJyGe1bwX0EOo8+EhUKUT6t9vyizgpeKLKAxPW6ZqA0rYxS204RAx0LJqVUw1THzH9Wp439eTFJiupZlv6iP2bUaJVBLO4VNd1svCYcpLF+ZQlmh0kBZw8BcZPLgKVUzSTIqNuE8+SqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYoHj2iA6XXS8DZTwkpYUmGi84Pf5lWRIwqD5JMYHd8=;
 b=GPJq/pLMfLnPZzwPrsmdsetN6fPY0IByekM5+TSKWD0V1xdg13gWm5EcGTeJt6Nf1wpVLSrmBzM3+MHbaVFK6RTS6ix1Ma+YCitJeRsBUbwur902bsGlg0emRaAp25ofqaDeezXvtNKAoqF+/Ff/3xnzJqErQvox37jAkxljD1PoafvhA0ymNUlf/3Cjf0qgeRbP1XiBh9mLRtGHmWOawMwSKQ5op67jmGmwuZQi8pde7evVCnVUTfWPt6G6PAsNJO+FunA/Ya5plg3EysphSl54vRseOZHYsoT+axoD7PCkug7W9mOkRbeD0WuG3dWf8nySyrU40Fk6x6WY2NtKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CYYPR11MB8357.namprd11.prod.outlook.com (2603:10b6:930:c5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.42; Thu, 3 Apr 2025 02:47:58 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.8534.048; Thu, 3 Apr 2025
 02:47:58 +0000
Message-ID: <7cbbbd8f-a4b4-491d-bb60-97defff6007c@intel.com>
Date: Thu, 3 Apr 2025 10:47:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/numa: Add statistics of numa balance task migration
 and swap
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
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
 <ufu5fuhwzzdhjoltgt5bpoqaonqur4t44phmz4oninzqlqpop7@hbwza7jri3ly>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <ufu5fuhwzzdhjoltgt5bpoqaonqur4t44phmz4oninzqlqpop7@hbwza7jri3ly>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CYYPR11MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 49cf8ff4-cef6-49e0-4a97-08dd7259f14d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkRheTNENWp0c2JsR2RvcFJJMkNSQjNUTUxDaGpWakJpd0Rxd1NLTkhOeTVm?=
 =?utf-8?B?elFSZDA5STZrZVdsLzNOckljLzY1NTZrWEtEbUhqNGRJWHpBcUQwdHFjTDNN?=
 =?utf-8?B?WUcySGhFWUd5Y1ppV1FFditpK0JmWnN3Zkx3ZGlncVhOVDJzdkR6c2kvV1RB?=
 =?utf-8?B?d1lmQnRDZjlDNTVPUE5ERjJvVlhOdjFXNEp5d0FOa2t5bGUvU2FySlZ3cUxt?=
 =?utf-8?B?RUtRQTR2QU9UVWppWi9xWGo2QmpvMmgrUS9jSUR2dXB0S05KYXdnMURYVjIr?=
 =?utf-8?B?ajdSaDc0Q2RIcWY2M09BVGxUSm5ZZXNxUkg2VmhHVHRGc0laY2QzSDNrRktU?=
 =?utf-8?B?UnlYcmFQSUdQNW5LSWlVSHVyR0dIeEJKbEdCOWU4b3RiaUtoUzcvWW05ZUFM?=
 =?utf-8?B?c25hVGYvSWpJN2pUaGV4bW5xWG5aZmd1elAwNzFXak14Z2J1OWczako1NHVn?=
 =?utf-8?B?alNBYUhFczNPNWxaNldNYjNWd05zcGFteUMvNGdES09scm84VHgzZ0dPN0Qx?=
 =?utf-8?B?a3dzei9ndldKbVp4OTVnVGhZeDRzcmQzN3dzWEpGVGRETWIwMDZsN0JXWFJF?=
 =?utf-8?B?SWgwSXYzdVJrRnhrYlRVK3pkZnZDNEsra2pWWjhXRUpzTHcwSGk2c2ZXTXB3?=
 =?utf-8?B?bFVVOHpzL0JGSzdrdHFOVlF6WE1JTlFXQk5ueUJYNEFrOWVhVS9Rdjl5MHRo?=
 =?utf-8?B?cElQTlRENlZvdXVSVy9panhSZlJRR0NTOG41dlRRZ3lkNjk2Q3BDcHd1YkpK?=
 =?utf-8?B?U0ZaK01lU3VDWmtaN2NBdlRoWGh1SGsxSHJKNzhEaTAwZW5RdzJGeWg5dHNn?=
 =?utf-8?B?TURvTGczM0RxTW0rMXhIYUhqenV0MnpsSjNRWFlrbnhOL2FmenVaSGpoNGJs?=
 =?utf-8?B?M29ad25nUmNOOE1FRHdxQzh0TE9KZDdIcGx0Y0NWOFdrRkcrUEI3eGFBaS8v?=
 =?utf-8?B?Y3BiRGdNcU9PeHNxWXd5OHRCZzhKUE1OVW1NcGpzUmZ1L1ZVTlRJdFFlWldV?=
 =?utf-8?B?QWdKeG9ZUXA1RVFuYTRwUW5wUGNJWXFMalhaRHhuYTMxc2Zwek15aWVrV1Mv?=
 =?utf-8?B?YUJidzZ4WTVZNWdOdDdLYVlDLzlXZldla0lFUjJkWXJoWlYxTmVYamUyRklI?=
 =?utf-8?B?bk5JRkVybi91TVVaU2dpbmFqdjJIWmFzUTE4SC9teW5RQTBtNVNJUDN6cmZM?=
 =?utf-8?B?elBHR2xWby9hbE1iRys4MWFJbWJ6WDU5dWNCRWhGWk1YeHk0STRGa1Q1VVBo?=
 =?utf-8?B?VVREZDZnb1dMbUd5d2VpdHUzQ3o5a1VPbXZRQmZ0eUJ3dXlkWE1CeDloVkV5?=
 =?utf-8?B?YVhVeEV6SS91anJTdWFhenRhUldPSWtTWWUxSGZBVC9iLy94Sk01S1VaMEUw?=
 =?utf-8?B?NjBOMzRDdENMb1daNUlaWmtQWWV5dkxnYVpqYmhEKytxOHJESlh5QVFEUXJJ?=
 =?utf-8?B?VHI4am9GcDVEdkVXejZnZXd4Y1o2WS9JRzN4bE53ZWxEaDJ5M29oZklhZTlj?=
 =?utf-8?B?SDJJRHJOb0oyeW5yYmFHNWlnbXN1S0lveXUrRHUyWjZ1VnI4NVI4QThCeWZj?=
 =?utf-8?B?b3JpZDhYWkhoVGM3NTQ5bk1XRm1heHNQQzhTZ09EMjVxWWNwTUZqRitFei9U?=
 =?utf-8?B?c3V0MHRHb2dxNURkSmxCK0hVZnRkNGdjSGFRQURqeW9GbTRMWEpodXNDQVpk?=
 =?utf-8?B?ellodjg1eGM5NHA3WGRYRDlkMi9mRWJPMXV4QTZ1ZGxsZGN3YkxFSk1Hajh0?=
 =?utf-8?B?V1YrZElSN2xLbmZlbUFnRUh0RXY0QWM1c3NRVmh2bG9XckUyTjJtR05oZDlU?=
 =?utf-8?B?QU9sVDdFbklNTUd3T0VreXA3T1FuQUZUdU5QTDdhek53QWNCM2FmNytjdFV5?=
 =?utf-8?Q?Ppcf1QZa7MyxP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVlDaVg4MFlvdHA5aEVPUjJ1OStBNEJrdE4xTEw0VlhYUHZsYXlqV2d6T0k5?=
 =?utf-8?B?M3FjYjl5cVNJY1AxU25sTWE2cENYbVRFckZlV28vbE4rUmEzZXRpYUJheFJm?=
 =?utf-8?B?dGswczZkckVteVpJVURvVVNqODRLZHByM2RSZmtiYXRNc2NyeXgrYWdLUFRH?=
 =?utf-8?B?UU9GV3YwUUZ5K3lWL0psMXdjYnBBS1pndzJTUGhab3N1ZWtEYXJFZ2RMYmpN?=
 =?utf-8?B?Z2VJZGxQTTVpNE1kandqYlBqQzhZN2FsdWU5ZDNTVXB6SnhtWEFCemdPMUM3?=
 =?utf-8?B?KzBFV29uOFZtWTNjWTEzODQzd29YWks3dDg2M1VrZEp6ZUNCVkxsK3FhdFcx?=
 =?utf-8?B?VkJTdStoNWlCYk0xSzVjRnYwTzgxNUlCK2JuMUNhdUdsLzFYQnN6VjVGQmxT?=
 =?utf-8?B?eCtTTnJWYi93Q2tyK1N5YmUza2JXT3JLQW5xTVJDSUVvMEhFR1FHcHl0bXJn?=
 =?utf-8?B?aHlkTVBrL1VYUjZZaWNvcFA4VVpERHBDZFdFUm5NK21NS3o1Uzg1djlxS1kz?=
 =?utf-8?B?d0tRb3I0ejljaldGZ0s5SGFBam8ybjZSS09ybXRLcGVEaWdFYWFtcmp3OGQr?=
 =?utf-8?B?NmZoQ1NhSHRNU3ZHU0dLTHc5YzJLL0Y0Wk9jYUh4RkI3NDkvMEdMQ0pCbzR6?=
 =?utf-8?B?dXRqcHZBd2hsbEhhT2VsdVZlM2haS1dlZWM0c0Q0Vy9GN0Z0TFp5cHFjbFMv?=
 =?utf-8?B?MFpBallReE5EVVdvbVJlRGJKQmowUXM2a0ZCOXVNY3Q4TmdYOFlHcHhDNmg2?=
 =?utf-8?B?emtOekkvOXlnZjNSSGZjcElwUTVLZXoyT2VWMkYyaWZEbDdNbnp4SVNYeXg2?=
 =?utf-8?B?RUwxVksxSEpRUzdHUkxaZDR0emtGTHpJUEtxWkJRaHliVGJzMitrL2ZoMlBC?=
 =?utf-8?B?Mkw4NE5rczcvU1kyK3JGL1hJNHUzZERGQnFRN1ZOa0crNlNkbnpNS3VXZFlN?=
 =?utf-8?B?UFNmemZQR1lkZFVGeG40N2tkT0xPd3FPSUJFKzV0RHZNbldjQ0w3TkJFSEpi?=
 =?utf-8?B?WnVNaDdyRjZ5RzMwQ3hXdmVEcmtNYUVPaEdNR2ZlK21wWjE1VDk5M3cyQmxw?=
 =?utf-8?B?VXNudTdIc3VwclVZTWZBdjRtWm9pcVhUdTdyeERMMjRwblprN1d5aFFWeUlT?=
 =?utf-8?B?b045SG1MOUJlcDRNVk1iMlcwZHBlVTkrTGw3RXpoN0tJSS9QRzFocUpBU2Zs?=
 =?utf-8?B?MGFiNFFIZWl1Z0NMVWdTSmljMWt4Wk90WDFicFVPZURZL2xRQ2J4am51UGhZ?=
 =?utf-8?B?N1FML1MxRndqcUFLSkIwNFBJN0Y4Vmg2NFluMTRlUlpic0xjc29RVjRxSnlo?=
 =?utf-8?B?d1FHYk9BOStMcFRhN2ZTZmdsVHlZN1hweFZEaUM5d1hnMVNvOU5MWWw1bytx?=
 =?utf-8?B?clFRTmt1WjU5VzZwZ3hLMit6dE1xUmFkamphNG1vWTNvSjhudWNIWUhldVpz?=
 =?utf-8?B?UHBMUnV5dVdGQVMzRVdPZEtGbFdxSkQ4Ym5DcUNBVlNqVWxrTXQ0dC84dTVt?=
 =?utf-8?B?bHRuck04RUd3T1FHQ21rS0xiODMwdDd2MGJudmhwNFJGdHFIbUx4Rm82RFNw?=
 =?utf-8?B?bmtEbi9NQXhCaFh6aFFpYk8zV1o3b3dYYkhtQ3IwN3RES0NtKy8vWlRaNExJ?=
 =?utf-8?B?RzVXNzRLamJuRHloM0pTUUxmY1RyZ3Jjcm9vZnhyVmd5Qy8wRzRGMWkvVUNC?=
 =?utf-8?B?aW95ampiVnZJWG1hSDZEQzZ1cHVEN28zejlvMkNoY3RNYXZHZDNHNWkvN2VP?=
 =?utf-8?B?cWJCbFV6R25ycndVenVIZzJtMjZrUFZaUGgzMHUzNTNZeGVFbkpnaEZFVnVv?=
 =?utf-8?B?S3J2RTcyL1ZveWJ6ZGxqOFAySGJQM2NIL0g3ZkpXWit3S1BZZDEzTmRaQXAv?=
 =?utf-8?B?NzNSUHdyTEZqeUU1cTBHa1RkUzBGeDJGOG1WVm9YRDJTMTVoRFkrbFZOb0R2?=
 =?utf-8?B?RVBMWDREbko4R1ZtTUsrck43dHNYWnJkU3d5blZaOVhMUXZpY2ZaY2JsaGpy?=
 =?utf-8?B?dnkrV05MbHF3dmNvMDBRdVQwbUcrMzdSRml2a0xzYmdKZWd2aER2T1FEYU9m?=
 =?utf-8?B?NUx4SDhMd2dFQmxCOHdsUmtmcTRESUlZQjVOZWVWM2NWcXB3amVwa2d2cEpI?=
 =?utf-8?Q?RJGq+2UbsKrk5cjukW8LfBQ6Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cf8ff4-cef6-49e0-4a97-08dd7259f14d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 02:47:58.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGVDukPJgy6b6nszXMasJD6CvVAYbdq1H+5B2wPMnQXOVU904mYE44TwE50LZOq3tqLPnEGP9QVUd4qxlHv9Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8357
X-OriginatorOrg: intel.com

Hi Michal,

thanks for taking a look at this,

On 4/2/2025 9:24 PM, Michal Koutný wrote:
> Hello Chen.
> 
> On Wed, Apr 02, 2025 at 09:06:11AM +0800, Chen Yu <yu.c.chen@intel.com> wrote:
>> On system with NUMA balancing enabled, it is found that tracking
>> the task activities due to NUMA balancing is helpful.
> ...
>> The following two new fields:
>>
>> numa_task_migrated
>> numa_task_swapped
>>
>> will be displayed in both
>> /sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched
> 
> Why is the field /proc/$pid/sched not enough?
> 

In the context of NUMA balancing, it would be helpful to not only 
monitor on the activities of individual task/thread but also the 
resource usage and task migrations at the group level - which helps us 
quickly evaluate the performance and resource usage of the container - 
like per memcg numa_pages_migrated, numa_pte_updates introduced in
commit f77f0c751478 ("mm,memcg: provide per-cgroup counters for NUMA 
balancing operations"). Yes, we can iterate the /proc/$pid/sched to
find the accumulated NUMA stat, and the introduction of per - cgroup 
numa stat can help users more conveniently track the overall data of the 
workload.

Besides, I'm considering evaluating the per - cgroup NUMA balance 
control[1] to help users do fine - grain control per workload. This per 
- cgroup NUMA balance stat could be used to evaluate the efficiency of 
per - cgroup NUMA balance.

> Also, you may want to update Documentation/admin-guide/cgroup-v2.rst
> too.

Got it, will do in next version.

[1] 
https://lore.kernel.org/lkml/b3f1f6c478127a38b9091a8341374ba160d25c5a.1740483690.git.yu.c.chen@intel.com/

thanks,
Chenyu

> 
> Thanks,
> Michal

