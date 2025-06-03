Return-Path: <cgroups+bounces-8422-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FB6ACC975
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 16:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37E5188CEE9
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8B15624B;
	Tue,  3 Jun 2025 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1LBDhUm"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3317548;
	Tue,  3 Jun 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961986; cv=fail; b=o79DNErQBsNPWPQrKpT8QUQDIOhtoeKSyb5t2isNv+TXk2psrtLfkNigbUjPHJwbcfWVrOV8Zbxt7FPaAaWTBUcB7iALZlltmjOuIGtqn3w4vbShcqIqu8LLowCOXZMCYO8K13lViP50JXG0HgkWU90FML9PGfmOjGLf1TAURuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961986; c=relaxed/simple;
	bh=vIR+NCj7CWaH8lIOW9nbRSnXiUHGVPJl2Pu5ec+7DIE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cboeFWoRep9lykQ470l5eZuLw9JKdEZOlnF0Ue3NxXyTSWoI+Ry4dSS3vdGH17G5y+2Wh8moyvxnWZ1+cKU6ZLiTbB23ChFA4Q9l+AKdGsyLSiTx5TbIgwNicSjuETOXzZcQqvaPyB8BZ3bLJHVnNyXEmcqH/nkspqXo+3lQi4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1LBDhUm; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748961984; x=1780497984;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vIR+NCj7CWaH8lIOW9nbRSnXiUHGVPJl2Pu5ec+7DIE=;
  b=H1LBDhUmhEjUmXbmBj+oof4pggvhf2+eihlTsFHBUe9axlcWqWgx2ioV
   sHCSmRFXdSyRc+SPGLv6x65fqhb/X0YhTYS/VQZd0Y6Ky1xlNr16nW3Fd
   5U4ky8wAGIbeQgbug2X769iq9b5+g1NJ1J6I2q6T3S8YSPNdkIGRRgytv
   75rrTn5V1U7HPPZsWmAxLm7XODByPu/ToY/5urrm1mKLU5fYX2FNl+ZAd
   FyF2FGhVJCD19CuH3LtYcSsxw1025oC/IC8PKvzLyPIBOpOMKbIZexnfA
   cv18sYqnmo0hKibdmSOk0T0BVmD+EfFPxidRS0W6bJCp1+xUYactskHJ7
   g==;
X-CSE-ConnectionGUID: loy/ZQBzQoeHf6ADmrgpZA==
X-CSE-MsgGUID: XgGxTeR5SxWUPxitu72PlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62363125"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="62363125"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:46:23 -0700
X-CSE-ConnectionGUID: ReiGtT56QruIIcs1bTg6TQ==
X-CSE-MsgGUID: FQ57P5xLTCKW614MeY4UQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="144768840"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:46:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 07:46:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 07:46:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.66)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 07:46:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNCXNl/dbKw4afnviLcwQnRt/zuWY5WeCCMPNSBwC4Kis0AUUZmak/+moI1gLhJooUzgvIi6aS4gHRFhQFFmZJVoEUHWOD1eCf1nsWDLcB+n5E6IFrQhDRbt+nHeHUMGkh0Y2QS4ULRGkpruBIR5HWl1OYt6fuFMbOLiPu+19VY6i2Mxw+BEpQNqQtng1mCeVV8l4r1O0Q1FJ9kVKNJtP27t7oDOAiQjF3LchrLBpj46jlmbHeICuNxgsqEy3lUU49Qjk6hReDq4EvPx53c0UiZ3lhjxZkIYqpzVWdeEpL5PY27BDtsZse5PDxjoYUOVE5+T46SZ+ZF90FW1+nq8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b98TOIZ+2f6jo/0tksrjQSiI1JZnwud6rIvCxfg7Syk=;
 b=Y+RRMWq5gI0z1vlSpa/B7PT+g8THo1lJggGTog0iiU4WXiyBvnBeHCgpcOBPkOEhVWkvw8gp3ErSvFO5MZeMqHL716iCaruFNj0UewEykCxHO/qPFHtTyOYlZF35yu4dmXdY0FBDxFgvRtbYAcDuW/NCqu10mDLnlNYpaUSc4oyJoFuX8KjekDXLTvZxopJYQWN18QA5dRCjzi4/SzkUbeFMC54BTBrY0cxY/5RfmrbyrABmrtWF2FD1g+Hurp3W/CXfcgX1q1sL9gDusoYcUlpgCyAULeo0i0SziT4dxl8Yx1+Rm5YtVYNEtprPmc0/pZV3UKWVjUs5iDW8BiizsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Tue, 3 Jun 2025 14:46:18 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8769.029; Tue, 3 Jun 2025
 14:46:18 +0000
Message-ID: <c6bfa201-ed88-47df-9402-ead65d7be475@intel.com>
Date: Tue, 3 Jun 2025 22:46:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Shakeel Butt
	<shakeel.butt@linux.dev>
CC: <peterz@infradead.org>, <akpm@linux-foundation.org>, <mingo@redhat.com>,
	<tj@kernel.org>, <hannes@cmpxchg.org>, <corbet@lwn.net>, <mgorman@suse.de>,
	<mhocko@kernel.org>, <muchun.song@linux.dev>, <roman.gushchin@linux.dev>,
	<tim.c.chen@intel.com>, <aubrey.li@intel.com>, <libo.chen@oracle.com>,
	<kprateek.nayak@amd.com>, <vineethr@linux.ibm.com>, <venkat88@linux.ibm.com>,
	<ayushjai@amd.com>, <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<yu.chen.surf@foxmail.com>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
 <cx4s4pnw5ymr4bxxmvrkhc457krq46eh6zamlr4ikp7tn3jsno@xzchjlnnawe5>
 <uuhyie7udxyvbdpccwi7dl5cy26ygkkuxjixpl247u5nqwpcqm@5whxlt5ddswo>
 <a8314889-f036-49ff-9cda-01367ddccf51@intel.com>
 <fpa42ohp54ewxxymaclnmiafdlfs7lbddnqhtv7haksdd5jq6z@mb6jxk3pl2m2>
 <djkzirwswrvhuuloyitnhxcm3sh7ebk6i22tvq2zzm4cb6pl45@t64jvtpl3ys6>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <djkzirwswrvhuuloyitnhxcm3sh7ebk6i22tvq2zzm4cb6pl45@t64jvtpl3ys6>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA1PR11MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0d37cb-dc70-4256-a4de-08dda2ad6604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MExKYjRGRG8yWWk2RFNoVGN2TkVka0dja3d1UXZ1b0ZIY1JPUGsvdUo2dFBW?=
 =?utf-8?B?c3ZySmN3QjhWOEhaT0FqRVhpdlNPaWZrRTdHejY5ZU1mRkFlZmVSaEFOUEhx?=
 =?utf-8?B?ZTZDWGVkRE1LNnRBV2RNVlpRSVR4cXkrVnJBYzQzd3p3WENBRE12d0xKSzZK?=
 =?utf-8?B?OEhvY3lRUTlKK1ZXOGFwZG5rSkJuOE9CZW12SFpwSEVBckFjK01jNCtGNHFE?=
 =?utf-8?B?NU4rMkVzQXhud1BhcWgwb3BCeWFqWUFESjFMczBWRnY5V1JHU3RPSzRsbW1K?=
 =?utf-8?B?cGJpVi9KU2tsUUVwSGxDb0YyRnNjTURDb1RRemY1TGpzYUJkbXlOMExrdWc5?=
 =?utf-8?B?YitoT05Ec2lvdGV5cys4RTNMWGhqdS9LQWdpdk9DTXdLVjdnTWpzTEJwOU0w?=
 =?utf-8?B?MUV1WmZCZUJvMlYrZFA2M2dNcXBrS2JhQkl4VUJlbTZET3RhbXVJZThGdWVz?=
 =?utf-8?B?aXU0ZjJOU0N2bFlNNk9iVnN6cGtJOXVoQkRKeUE3RDBERFlpV3IvOUhJb0Vw?=
 =?utf-8?B?ampQWG5qazVZRnFEQXVIcVpaT0docCtxd0U0MUswMFFQbVltT1FQKzJycjk1?=
 =?utf-8?B?NjQwQ2xLSUFyODMxTWJBYjdlMnU3Q1Azb3NMYjdlRjg0UEFndncwL1dLdUdy?=
 =?utf-8?B?blJVWmIxMi9kcGR5U01va1VzTnJFU1JvQi94d2RrVzZXV1JuL2VOM0xIY2hz?=
 =?utf-8?B?NWNad2FBVnBid01xOVA5Q2x1M2VVVUVycU9tVjZBVUsveVhPblRWQ1NPbHQ4?=
 =?utf-8?B?N3ViUVFjNnd4MUg3NGt5ekVReFJjNDhGSE83U01XWlczWEUva01WM1Q0RHFT?=
 =?utf-8?B?aE8vL29uV1RYK0dqZ2E2OWp2aGh4T1dPU1F5eXQzQmlXKzhka2pkN00zZXhD?=
 =?utf-8?B?TUtwVEdzcWlINzV5dmc0VjBJc0J1QjB2UUh1bVJvU0kxbE9GOVdtLzBEL3RV?=
 =?utf-8?B?YTBPYTBzR0s1N3I2RjVTS1pNbjJLdi9CWVdjVndaSnlMcWJjWVFRRWhoVEMy?=
 =?utf-8?B?YVY0LzU1d2FSMkpIem5YYUlnUVJiV2VSY2Fta1pvUlB3T2t2WnhMZklld2JJ?=
 =?utf-8?B?ejNIdmxNYnloeVpoRmZwM0xEbG02NHhzbDdQUktoTm9NcFVQdnV1d25uTkVj?=
 =?utf-8?B?UlRwNmdIVFRyZk9xQXAyend4Y1VPZkNnVWE1Zi9NNEdlVDZvWDlUM3pTeW1F?=
 =?utf-8?B?ME9Wd09wemhiZm81eW4zVFB4WU04Wk5xWUcrTGxoSVdNenNMWXdSdXczSzBO?=
 =?utf-8?B?NDA4V3NxTURNRmpqZHFsaFZCNTZrTHRYNXBsWm9oRnFUUncxcVM2QUQ4MUV6?=
 =?utf-8?B?QmNrOC9uL0s4OEk4N0hrV3hka1k1SVJzVTlEMlIwK0J3MzVHNzYvKzNzeUFt?=
 =?utf-8?B?RElYR1B3TVIvZWpqd3dCRkNlZmhpZG1OckFtRGVLY0lVTDJKcEROUlZJSm54?=
 =?utf-8?B?QmVCSjVoQnFjWWI3QTNocFdaakNVZ3BTTjJrY3oyQUJUSXBxZHV3Tm96bGNm?=
 =?utf-8?B?OXo1ZFBDbThsdFc5TXpjamVrRURyWEVaL1dQNGV3RVJFd0FBcit0VzV4cGlZ?=
 =?utf-8?B?TzJjME5wQXBjcVRhNnQ0eTRrWk8zWUVla0pwdVhIZE1LRTc5UmV6Vnk2LzdP?=
 =?utf-8?B?VkhnaW9FeVMxdFY4ZVFCTkV5QjNjblMrbTl1dXhHbGM2QlRLcENhTVlZRUta?=
 =?utf-8?B?TVprUlJMd3pvaVUwOGNRRmt3RmJ3L0ZGR3R6K0diRlR4aXNtU0lvRm9sLytr?=
 =?utf-8?B?bE83M3Q1L0hUSkpwdzNEYnJOV09Rblk1MUVNbkxEbmpscmZYQmRUQ0YxZVcv?=
 =?utf-8?B?TGFoODJFR3M2cVptYzN1WGdhNDMwakl3MU1COWhTUXN4QmFPOUtIa21leTYz?=
 =?utf-8?B?cS9VQTYvSlpnRHBwdXpRMXI3OFF2UnBmc3gyRXY0OHhja2hsRUo0RXYwTWhC?=
 =?utf-8?Q?mfCRf9Y8dIA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjVtbStyKzBTTnVlY1ZQOHFQY3plb1N3cVRDdzlmT1B2bUhqM0U0L2tLWmll?=
 =?utf-8?B?SDBHOWsxZGlyZG9LRDhOR2tFM2k2eGZXRkZOcGYvd1cwVStpOTc1QjlzbDF3?=
 =?utf-8?B?OUQ5QnhJeWxPMm1HdDRJKzFaR2JNcGR6dk1rbmdmR3Ntcmpjc1U2eEs2Qk1k?=
 =?utf-8?B?WW0xTStOWnNvQ1JYa3lvRHAxM01hckM1d2ZqZ2xRcXMrL1Zoa0crazZEaVlI?=
 =?utf-8?B?NzlMU2IvMFc1MDZMM0tPVzBvQWNPbUFhRUpvVjFQZ25ZZUNneEZIVlF0U1lP?=
 =?utf-8?B?dzRsR0ZTQTBEVW4vTGRZNFJYU2dheUFqOFUrQmJUN0hrVmhxN3RheDNndVVP?=
 =?utf-8?B?NkVtYjNZUHZoVi80aXNPWFlRSVZudWhjMndzVVk4TmNMMGpxTWxQcXFoSHBJ?=
 =?utf-8?B?T3gxb3lVSnpBMXc5OHhYam1FTG1lclVSVWpaNmdKUHpMMmcyZ0lRcStSY2tF?=
 =?utf-8?B?L2hXdlI2Tk9PRDllOWI1WlplQlRMdWFScFdhdXlOU3ZzVTBzcjZJY0ZEd0hS?=
 =?utf-8?B?UEhJeW9oRmo1MUZ2L1pKcldtWEV6QVMyQUV5T3FoYU5ZSCtMVlVCQ1lhdmEv?=
 =?utf-8?B?bHBZdFFXdDlVMytSd0JaSE9oVFZsVm5WN2l6QnJDWEV5NmxxRUM3c2xYMS9N?=
 =?utf-8?B?ZUFwcVJaTys0Y1VBVW5RMTJRbHVSOXd6VURXUHFUTWJUYzZQUDdINWpweDRB?=
 =?utf-8?B?KytUOU1HKytvejd2aUUyL290Ti85ZjNERVRkeS93SSt0V3NZM0lGdk1OYzRR?=
 =?utf-8?B?WDlweW9kQktjemRkcFloUEZ3MG5mK3BDeUp1M25uVGFBc0FGeWYxaXNtcWdL?=
 =?utf-8?B?OGdwVWRrQkVYVWw4Uk1mbWhqcmRtdkg5R0ltcjh0cVBSWlNjc0l4QkhORSs2?=
 =?utf-8?B?UTd5OG8wSkxWY2J3U3hKU3N3SXdhamY1VTVhSUEyNjZtKzlTVmszZ0h2U1J2?=
 =?utf-8?B?MmY1NTZRRWxEQk4xcS9jLzYyOWhySWFVSmlRcThML3lPZWU5WGM3WmU3SE5s?=
 =?utf-8?B?NmxNZ2xzZ0RlbGtnUEg4bW1LclhQTlFHSExraEtoM1RGSmhYSHdHUGdoLzdw?=
 =?utf-8?B?S2lRc253QUJiMUo1YlZCLzIyaFZ0V3R6d2pNMFFHTm1CR0FWcDIyTUFpWXpa?=
 =?utf-8?B?V21KM3hCU1I3WEYrdTNCNUdUNmtxdWg4OHpsSGRyWlJnTWZ6bDhzZEdkRXp2?=
 =?utf-8?B?MGlKYit4NHYzUnFzbzc2TVd2cDdKNVBjb0kvTCt5U095QUhCZDBHOG9SSUgx?=
 =?utf-8?B?Zk1tUDBEWE9ZWTFWUnhPVnFuUVB4Qjd1Tm93czdjeXBmN1luQ2Q5VXJDK3B3?=
 =?utf-8?B?c3ZHaGFWdHVaNnJ2cmFWYllHcHhGYlhheVlkeWdYSENockZiU0pIOEZKVmlj?=
 =?utf-8?B?ZFpFNS8wSTFuVUJOVkRITXJzQUpSdHQwMXljd2dXeTVaUlhNUjd4bVNMbkRO?=
 =?utf-8?B?WlFuT0N4eGxJRGZjVEIzMHQ2eWZoNzBvU1Z6WEVGbFBXMS90QTZBYVFNaDZX?=
 =?utf-8?B?Mzc1TjM5M2FBNXZhUXJyakpBVGx4TG05VDExV2daZjJxMFdNbE9aUStRSXR4?=
 =?utf-8?B?aERUZmd4Qk9KNDJpVVcwZ3crdGJrWExCb0oxeGY1RUdtSmQvQ0pkcHUxc0Zs?=
 =?utf-8?B?RXVRL25nZE0xcEF0Wi9HRDRzRDhFM0kvVzdkN21vc05tRERVWStCU3NKaFkv?=
 =?utf-8?B?N0RoVlYyMXpJc0dPcHJuYktXZGREWTBJLzVJSHhxNTZuNTR1cXRUbXdUUFJI?=
 =?utf-8?B?VERCdGpNOUlMVC9iTnlSbGttRXUyVUhHRGttQ0VyZGwvSEsxYkxyTERwVjNP?=
 =?utf-8?B?c0JiY095VFlWQjlMQmxiM09JYzg4ZVhiaWlLVVdRSHdpb0N5V1JsZjlHWVBp?=
 =?utf-8?B?NE9VNEw0UGxEQzVtblhEdmQ4WHdBVFJQbzEvUFNGYXVnK3pBQ1hIdFZmbm1n?=
 =?utf-8?B?R0NwUkpNakZJY3NrT081dTMzcnZhZ2V3YWtDcmorSXJiVDZkRE9pOXVkeHR3?=
 =?utf-8?B?SDR4MzIxVDZvMnFndG5zZlp0NzYvc1QzWFg0Y1NUaFAxUUw5VW4yMkhlcXhY?=
 =?utf-8?B?K0FMZ01mUllaTjlDYXNDazR1RVVxTnk4OXZtM0FuakFYcDc5TXN4cmx5WkFr?=
 =?utf-8?Q?y+dsvHtpPUOB8Mv4d5tDX4jnU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0d37cb-dc70-4256-a4de-08dda2ad6604
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 14:46:18.5657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkMGIRJpXhomsbKqKTvRMrp4SD2hH0n3cOcC8oQ61pPicdNWilzf5VfGDcgWguDGxpYGj1MDZ+tgHrwUdZd3IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8200
X-OriginatorOrg: intel.com

Hi Michal,

On 6/3/2025 12:53 AM, Michal Koutný wrote:
> On Tue, May 27, 2025 at 11:15:33AM -0700, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>> I am now more inclined to keep these new stats in memory.stat as the
>> current version is doing because:
>>
>> 1. Relevant stats are exposed through the same interface and we already
>>     have numa balancing stats in memory.stat.
>>
>> 2. There is no single good home for these new stats and exposing them in
>>     cpu.stat would require more code and even if we reuse memcg infra, we
>>     would still need to flush the memcg stats, so why not just expose in
>>     the memory.stat.
>>
>> 3. Though a bit far fetched, I think we may add more stats which sit at
>>     the boundary of sched and mm in future. Numa balancing is one
>>     concrete example of such stats. I am envisioning for reliable memory
>>     reclaim or overcommit, there might be some useful events as well.
>>     Anyways it is still unbaked atm.
>>
>>
>> Michal, let me know your thought on this.
> 
> I reckon users may be little bit more likely to look that info in
> memory.stat.
> 
> Which would be OK unless threaded subtrees are considered (e.g. cpuset
> (NUMA affinity) has thread granularity) and these migration stats are
> potentially per-thread relevant.
> 
> 
> I was also pondering why cannot be misplaced container found by existing
> NUMA stats. Chen has explained task vs page migration in NUMA balancing.
> I guess mere page migration number (especially when stagnating) may not
> point to the the misplaced container. OK.
> 
> Second thing is what is the "misplaced" container. Is it because of
> wrong set_mempolicy(2) or cpuset configuration?
> If it's the former (i.e.
> it requires enabled cpuset controller), it'd justify exposing this info
> in cpuset.stat, if it's the latter, the cgroup aggregation is not that
> relevant (hence /proc/<PID>/sched) is sufficient. Or is there another
> meaning of a misplaced container? Chen, could you please clarify?

My understanding is that the "misplaced" container is not strictly tied
to set_mempolicy or cpuset configuration, but is mainly caused by the
scheduler's generic load balancer. The generic load balancer spreads
tasks across different nodes to fully utilize idle CPUs, while NUMA
balancing tries to pull misplaced tasks/pages back to honor NUMA locality.

Regarding the threaded subtrees mode, I was previously unfamiliar with
it and have been trying to understand it better. If I understand correctly,
if threads within a single process are placed in different cgroups via 
cpuset,
we might need to scan /proc/<PID>/sched to collect NUMA task migration/swap
statistics. If threaded subtrees are disabled for that process, we can query
memory.stat.

I agree with your prior point that NUMA balancing task activity is not 
directly
associated with either the Memory controller or the CPU controller. Although
showing this data in cpu.stat might seem more appropriate, we expose it in
memory.stat due to the following trade-offs(or as an exception for
NUMA balancing):

1.It aligns with existing NUMA-related metrics already present in 
memory.stat.
2.It simplifies code implementation.

thanks,
Chenyu

> 
> Because memory controller doesn't control NUMA, it needn't be enabled
> to have this statistics and it cannot be enabled in threaded groups, I'm
> having some doubts whether memory.stat is a good home for this field.
> 
> Regards,
> Michal

