Return-Path: <cgroups+bounces-7308-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1062A79A3E
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 04:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7551894E41
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 02:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966718CC08;
	Thu,  3 Apr 2025 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmg6aPiw"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FAB14386D;
	Thu,  3 Apr 2025 02:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743648959; cv=fail; b=dJiTmgFCYEcyu2lTLy2t89sHAD3pF1I/3QhXlYEf58+wq0737P1ARaCY2B1LZbAJV+ukK0QdUZkv9xeknSYzp4ReKYCLXPsU+YIB/cavMQO5XPLIygRwkohsZCckrQ8Xn/d3OzndgVToHf1dY+VXCFqd5sxI/jEpVq5Db7ZgOII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743648959; c=relaxed/simple;
	bh=QUfMw2x3cu70sWYAuymv6ri+Eavcz4gEMi9cqE06gfs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H/uXU2S2Xf9nLIkIcor/DRdN/62ya7iceI84t9wbTnKvSFT1qry2sO7HHnANNYB6DxqivGzGmZQs9j1E/StJAR+14fpvGmGco7+5xMhbOfui65TqNdDLHGRDmZcxhzrLsuQz9/z7N7+ftzEQ0tn86GcbhmFPZVTangEsqftayQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmg6aPiw; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743648958; x=1775184958;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QUfMw2x3cu70sWYAuymv6ri+Eavcz4gEMi9cqE06gfs=;
  b=mmg6aPiwOMnl3bQeqj/RMB2jFm3Ti2Fz82z1+TsnUdGgc0QIhMOMTBMj
   aV716lfErkAyxBnc4dOs7upxlFTqLXK1DTO0Q5lk+hRXyEqoNaZEoABw6
   VfMklk/pWDgfg9zG5OJwxyBfe8+eV9ytvW+jQOb/QJD2Kh+uK4YmV4CeO
   UswWJqF4PZYhNumr66yIyHQ6YQ19liFKEb7TiQeCUKT700z0djuIM6298
   SIbze2quiVay79Zc4at6IUbFaDaoI6+anxayt2txBj62e9jp7G33x5GG4
   WevGcAL0wIWO3bIzGIvqFPJ6qym5IpZIJffqs9uNtOWktLL7MjsqXE0cl
   A==;
X-CSE-ConnectionGUID: 4tcpLjyzTPOvinKoW7vhoA==
X-CSE-MsgGUID: W1IOLG5TQSCW9EgM4TBrWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="70407033"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="70407033"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 19:51:54 -0700
X-CSE-ConnectionGUID: HdSEzftYRBS1h2TJ1Fvi9g==
X-CSE-MsgGUID: TCiuTu+iSSevOUCFoJekOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="131004406"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 19:49:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 19:49:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 19:49:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 19:49:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mc89PHPWhwJVjGZgyySomIR29MWpUW5Hz4xlpMu4hEq5UFf7oH7js9HPMZ3YUjgsaCy2HgDDXcqPH+zWTrh3UqA5ODJI0UI7085VDtFOv79itLpJeYXIgNYXi+t6MFhmp4i/OI8VtOEEl4610m42cwLeym2xTMxPEAE1MbKBgqssXfPOAXSj/MLHbm1ydDkBVXB/KeGVlAfw50Pk3Y6tp0CEq6NYguOM5TIJDBPLgDUxI8fmRRe1Lqi4okSF51HRIEniF527V2Sa1XqhnVkL/cFWCmwgYJc4c5Aa5R6kxXNLaErYPQLD7hC+W2v+44mJ39Z163HJ3/rCooURBqaF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hC8/S4GD3x7uvEn9VgGhGZjX8r9Gn/6LPGti2GfnEh8=;
 b=xcn2t4s5HYbg04w3jZ4vIETHT/0ZI8c5r255md9Xm8gr/ZhgEJjCcNwKqAS49bOBVUnygQEYLLwdo00i2LPR9rVjNYNgSg6xyQ1id78PxG6gBF7SwZfuplF/T82mbHCnqakeZwxton3Pu0TFjABk7nGYYhzJKddrxe0Xd9ZEn2+Mk++qF+BzPE7a8qwmKYNxcjIEzoYatFyA17p22xur+M6gL1iNpeMtXs41saEtlKP8gp7A0LI7W8hOYUuzx7/SzOqvfdYrz5poCVUpLB34ADYUqY3dLJES3XJo5v9eJvxtUvF7MrgjZrapDHTz5/wjXDSuJM3SPdjZ2AV4fAOCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CYYPR11MB8357.namprd11.prod.outlook.com (2603:10b6:930:c5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.42; Thu, 3 Apr 2025 02:49:43 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.8534.048; Thu, 3 Apr 2025
 02:49:43 +0000
Message-ID: <f078db9c-e557-408e-a1ee-73f2bc89e915@intel.com>
Date: Thu, 3 Apr 2025 10:49:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/numa: Add statistics of numa balance task migration
 and swap
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Mel
 Gorman" <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko
	<mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
	<shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Tim Chen <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>, "Rik van
 Riel" <riel@surriel.com>, Raghavendra K T <raghavendra.kt@amd.com>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, Xunlei Pang
	<xlpang@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, Chen Yu
	<yu.chen.surf@foxmail.com>
References: <20250402010611.3204674-1-yu.c.chen@intel.com>
 <fff4f53b-eec6-409a-840a-0e8be64fe1a2@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <fff4f53b-eec6-409a-840a-0e8be64fe1a2@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CYYPR11MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a75ec14-c867-4f2d-3db6-08dd725a2f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnhJSzlzd21NWTExcU5rRW9YbFZ1WThBck4xNDh3UGZrekNaZFd6L08wZE1h?=
 =?utf-8?B?dU9rZ2lUemtMbGh4QXdvRTV1ZXM1U0dNWnFMY2p3WEh1b0VtdXl5RmtwVUwz?=
 =?utf-8?B?ZDJ3amhTVzhhc2d5WGNQZWNHUWpHL3VLUHZKTGJ4VS8xVGQ2aWRmUW9ia1dn?=
 =?utf-8?B?MXZqaUZ4OWdPVFlPaUpueVowQnhjbnB2NmJ2dDg1K1YzdXQzUWMzekNiVk5Z?=
 =?utf-8?B?dHlHSkNqbEYrTjBVanRqSytXUFdxd1ZzM0dqckNrWlBnWW9DZVJjeW5oaEtY?=
 =?utf-8?B?a2x4WERqUGtVdk84ZGlxVDI0TVh2aXZvaTJLNFhpVlVqT2tNWmYwVVM0YXkz?=
 =?utf-8?B?VVVsQUQ0MHdSbEZFSFJYek1WVFY0SjI1VE12UkJCNUR0c2xsK1BFV2dEM3RZ?=
 =?utf-8?B?ZUlvU0FrSEFObFl3ZlpRNytEWC9rKzh4dExKWWFRaFBmUHBwTnVGS3VDSlo3?=
 =?utf-8?B?UDkyQUlKcUNNWWJUMWZuZDBZNERTT1NlMHUrVUpLdUZ0SlRxNTg2aHlZNmZF?=
 =?utf-8?B?bzJSK0FuQVFHL1VoekdMOSsyZnBvaEYvU2MyYzNTTENwMjkrNHNwRFBiak45?=
 =?utf-8?B?Rkl6ZGN4clhFREdTZW1ERHBNOFJLZy9XNk0wRk9aeHFZUFR1NE5JTXQ5OGdn?=
 =?utf-8?B?TmFPWHczekVOQXJoVjExS3NTd1NkcG54WmVXKzNVd3V4eXVGL0tyTkcxZXpr?=
 =?utf-8?B?b0VsMW9McTFrK3k4MkxTQ3U2SG81M3hHUlR6UTRvNjZiTDhGaFVnQUJnV1Y3?=
 =?utf-8?B?TFk4MlZFL2pYVGowUGxWbWx1dnMzeG40SjJ4czVWRFJ1cnQzbHljcVZLTGpn?=
 =?utf-8?B?ajNtdWZHcWt1cytlMTJ5TzB3ZEFmcERkZ0lyUGRYSUJCOWV5aDJNTTV1bzFB?=
 =?utf-8?B?emV1ODYzTU1XOXk1cHZZdTlzTnZXSkRtUGM5a2MxLzVMU0lSR2FST3YraXdj?=
 =?utf-8?B?MFNhTDVRV0VIeEUwZys4ODhJQ1FlY0lTazYwekNaRmdUZDFlZ2djZ1REbGFP?=
 =?utf-8?B?eDRYaVg1c1N4WTh5RXF6THMvUHdZMjdXZWRXSXZnZWZTSkg2bGdxVWcyMDJI?=
 =?utf-8?B?b1VLZ3NpelgxZ0pKeGs3SjllOXczSjJtL0NHOVFBUjQ4TXFTNTV5UFEwVG1C?=
 =?utf-8?B?R0JCQnNQdllGRDVtczJBaDY4a0E3NWRGVzB2UFZVOEFtQTcwZ0tzc3A2TGJV?=
 =?utf-8?B?UUF3RUVTRnJLb0FOYUhNODVCUlBseW5RRjRYb3lPcGNhWVNsRWp2WkxaQTJT?=
 =?utf-8?B?aUt6U0ovYVVFUjViQ2tQVFdlcWFsbkQwMVF3SWhwWWNEZlRudUJqZVcyZTl1?=
 =?utf-8?B?V0twcjZwV0pNK29Icm5sMWwxYzBBclJ3RG5YSHEzWSt1bkdhVmZ5b1JHdmhZ?=
 =?utf-8?B?SnlWK1ZhMjY3bWlhSlNkTUJ2WUdYYzcvMHhQY2d3S05pTWZBQStRTysrNFdo?=
 =?utf-8?B?V2tFWTRRd3R0c2dkZmdhcFgvZXp6dEJGTlIxSHNXajRPbDExKzBXZjd5dTcz?=
 =?utf-8?B?a2RQTGVEOTAxWDE1UTNuWXplTnIxMmE5TXB1RW5YWTBneExxalRWTDZ6RnFt?=
 =?utf-8?B?WFpmMEZqajl1NUo2VStkWmV5OTNKRUJPNEFxaThVd3B6TkF5djhTUlZnVkhT?=
 =?utf-8?B?SEh5SmpGeGJjQnM5SW1qdWpzN1BRUXI0QU95RzA1T21xZ1ZyTGtyUzQxSklw?=
 =?utf-8?B?dkFURnVsTlhQdXI0cGlTZDBXT1ltc1BGQ2poSkRPVGdNVHdmbmlyNjR6Vy8r?=
 =?utf-8?B?cHI0TGFFdUcwczROZmVPcTJsOXlXVUlHWE9xcis2eVNua3B2TlA0bUpCeG5Q?=
 =?utf-8?Q?DXwzofp4acPx/nQ55T38K5pNEX6wO16fPMpYQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjZtMGFuWHJWNmhnMzd5bzZQM3MzVUVOb3RRYzBpaTY3eWZJZEVzQ3ZFZHh5?=
 =?utf-8?B?cFE3UlFPbHhiVEJMYW9oejRkeGJiSzgwaHhzWEI3RGVOQTk0VTRWZ2RmQTJv?=
 =?utf-8?B?QmxsR1N2OXp3RlA2OTJSNnB6NEdINm1RRGZ0a3h5OWdzWjZ3TWZoRnU5UTNZ?=
 =?utf-8?B?M2o5UG93TGRVdExMaVEzN080RjB2Zm9kbE9oWFZWK1IvVmF6bXV1VittRGlR?=
 =?utf-8?B?Sm41YTNRMVA0KzI5bzFDYlRQWHF1NDRleHQxMmJwMjJZRHo1UmxMM0ZHeE16?=
 =?utf-8?B?YnIyek5wRW5wcnl2WmJ1KzNCVE11SjBhd1pQQUpPbkkrRVB1WnVlYzRWbVU5?=
 =?utf-8?B?MEErWDFUQVZBcUxYaUh2RXp5RTJEaHF6dmdLeWFVaWM1QlJzcktCTUxBQzZq?=
 =?utf-8?B?YnRhcUdGdXdobzlJM25RQ0tmb3EyVk9zRVNYU0lmb1YyR0k4NFBxRnR1NEtG?=
 =?utf-8?B?Y2srU0pjVDF3V3pMSGNQUVBjTmN0N0lqNWNlWS9oc29HUGhOZDR6SHFMU0dD?=
 =?utf-8?B?Wkt2eWU3Unl5d2hycHFYYW9YT214ZmRvVmtzU0lKek1Zb0dmYWQzNG16ZWM3?=
 =?utf-8?B?VEh1RnZ5WUVnN09aQTBPUEU4Y1ZVbjRlY09pU2ZWYkVSM2w2MmkwYTlZK0xK?=
 =?utf-8?B?MEZBOHVPV1NlWVd6b3U3L0tJQlN4Y0N5d2lXNU12TzZ2RURLZ0o5L3NSRXg2?=
 =?utf-8?B?NlFyTXJrbVN4S3VGUGkyNlRZbThmcTVSZDliVU1Pdkd0RG4vclFCcm1IRDZy?=
 =?utf-8?B?a2RWS0NIY1M0bkRNVGFXaUh0bkNlNnZ6dGdNY0N2cVpqL25mLzVhTHFSSkRs?=
 =?utf-8?B?WFhLMTloSGlaNVlseGl5SWhHSHpHdW5xYmxac0ZzbTdISnVyZzhsY0lzYnFH?=
 =?utf-8?B?em1vQldnUlpEWWxsRmVjTFFQSCtzdDA3MUVRTUxoNHl6NTJaaENzUVpHUnp5?=
 =?utf-8?B?dTJRTEQ5TUl0V29xTks1TDFYRURGTStJMm1ZODd3bGdqbDhZZGhMZVpoTVh3?=
 =?utf-8?B?cFVrdldCVGU2Snp5Yi9XM0FDVVVOazhnbDRwbXhCK0F6WVU5NzBJYUlRU3dX?=
 =?utf-8?B?SVZ5V3lJVGl1SEx5cy9WY2dGVmVCZGNraVlaNlBIRTVLTEFzd3B3U3lUZ1N6?=
 =?utf-8?B?UFB4bzM4Zkl0czFUSVVib3JySmo0UTlSVFB3L2hjYm9xOHpkSkNVV0NQdm1S?=
 =?utf-8?B?U29xNW9RZ2pJWGE1KzM2Rkt0Tk50VXdPNnJWWE5ta0RXbjZQVHpZZTNHM3do?=
 =?utf-8?B?TjhKV3VjSSsvbXRKM1o1K1RzZjVjSUFmVzRHK1RCVFIwNzVwVVJZRklYSjhO?=
 =?utf-8?B?OFdoK1p0d2RtL0lhT29NUHowSWtuclUvazR2SXVTNDVFMkp4dUJWYUlONm1B?=
 =?utf-8?B?cVM5ZktVYks3N3pBUHFaZlFydTFwQWZvb1BBNFJ4S3RCUmpCOHA5NjgyYUJl?=
 =?utf-8?B?clFMNm82ZDR3cUpKMFMrQnFaZ2R4dEJhb3h1d1FVdjA2MlBtbjdiU3J3TkQ5?=
 =?utf-8?B?SXN6VXI3aG5LVTMwTzNZaUxXYjJxOHBTQ2xFbXBKUi9VeVA0OCtnOEc5a1Ft?=
 =?utf-8?B?eUpSVzh4SUNXRm1yYnQ0Slo1OEZPb0tYK3FPR3NGOHNxT2I3b2NpbDRUbVgv?=
 =?utf-8?B?SE11MmpKT21uZU0wenJ6T0kxWURabTVlc3BOcFNtc3dNMXI0ZCtlUjB1ekJn?=
 =?utf-8?B?TE56am4vQjdsVTJnTERURTZ6UU1EZXNvOC83b0t3LzVNY05VdTRiVE1aNzQ0?=
 =?utf-8?B?WTBwZmRDSDRrTGFqd1hHbW1tamxMeWpWSi84ZGovN2tEbDNOR21CWS9XMTdt?=
 =?utf-8?B?TkwvZXliZ1ZxbHJjZ0FUVFdrOGZRWW1tZlZLZ1ViblBMaWk0cGNQT1MvcHdy?=
 =?utf-8?B?YTI5UkZ2L3R1N2dwWERpeHFmMFpycEQyT3hzRXE3eWwzY0FxT3NEUGVjVXJj?=
 =?utf-8?B?SmFiemJpZ1VJYzc2MDMxczliZkJrNkxnTUhpNjV6Z003UVErZ0VZeGd5WHpC?=
 =?utf-8?B?blBRTnF6cSs5MW51eHpMbFJzdmVUQWV6eUl3R2d1REVNZ1krYkdja1Q4S1No?=
 =?utf-8?B?eTNuQXJiVlVraFh4WWtHZllKQ3djR3BUd2NhVmRvdnp6NGpCY3JoRFBJODZC?=
 =?utf-8?Q?L2sacCggShIv+OZuz1wv7MKcn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a75ec14-c867-4f2d-3db6-08dd725a2f88
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 02:49:43.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfkusr7RT0mFd2Pp8rRhbfeLSAmXF93mULAPekUcmQK13x7vhyqXsuZnt7fv7bbafcMNpNDLFMQwE19CSoY81A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8357
X-OriginatorOrg: intel.com

On 4/3/2025 1:35 AM, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 4/2/2025 6:36 AM, Chen Yu wrote:
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
> Running sched-messaging with schedstats enabled, I could see both
> "numa_task_migrated" and "numa_task_swapped" being populated for the
> sched-messaging threads:
> 
> $ for i in $(ls /proc/4030/task/); do grep "numa_task_migrated" /proc/ 
> $i/sched; done | tr -s ' ' | cut -d ' ' -f3 | sort | uniq -c
>      400 0
>      231 1
>       10 2
> 
> $ for i in $(ls /proc/4030/task/); do grep "numa_task_swapped" /proc/$i/ 
> sched; done | tr -s ' ' | cut -d ' ' -f3 | sort | uniq -c
>      389 0
>      193 1
>       47 2
>       11 3
>        1 4
> 
>>
>> Previous RFC version can be found here:
>> https://lore.kernel.org/ 
>> lkml/1847c5ef828ad4835a35e3a54b88d2e13bce0eea.1740483690.git.yu.c.chen@intel.com/
>>
>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> Feel free to add:
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 


Thanks Prateek!

Thanks,
Chenyu

