Return-Path: <cgroups+bounces-8341-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CACAC2E58
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 11:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34A817A1A0
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 09:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C90D14A60C;
	Sat, 24 May 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OovVyCKe"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330142DCC0C;
	Sat, 24 May 2025 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748077701; cv=fail; b=DVZazL/QQjZZPrykTEYC+dbUsqkJ4lncFZj/UwSpPX8Qzp9Bf7zvpXAFw1VTlFAad+Nu7e9sFzaZa9PhnU1WDqEDBG+AV6rx4vrthXoQiwIhOKeeinJ+t0GHftKvhbOr5CUs4yn3rTHvqSBLtGPuBIXni3k9734UB9+j9yfB7UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748077701; c=relaxed/simple;
	bh=A/KWe9DjUirpVMrmj5l9ZSEXX8RuLbhsdDUQVSK0ZU4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DQe2Vy+ttQSAV/zUUO7IudU4uF6kImi+ByPJC94K6Dt2lVZRaSsOuqxrOBcFDzkGsLCKe7zFa8g2dasJLarQFbhSxpWDpF0E7z2PSyiUN1K6RgKnhG0Y2qT6HeYujXjnqBX0E1igN5HEPWiavEXsDPWeUIxSn+9Sy0mLlrBVX20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OovVyCKe; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748077700; x=1779613700;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A/KWe9DjUirpVMrmj5l9ZSEXX8RuLbhsdDUQVSK0ZU4=;
  b=OovVyCKeWN0T6ImrZ+4VeGw0nD0kPICUq5WSJ1n6FuhtcRyfdv5qvdZZ
   lx4LLvpxAAGZBWKeWWgFnEEJUnHSZ0Zlf3IBz0+Ea28Lcf8I3H42DX2EK
   CfsND8BcpuJahE60fvrjVojoWufYU0B0AdVfjeyLGlqs6G8npt3P+nlWs
   Sigl9Hh9fKBy1s9vvSt51PnyhW4x9OnZBhuoRbdxceEEv6cqKm3mo0t0j
   0PQyxZnxUvE0dQ/fhl52Idqrdml7ZOHDflJAM1Rg60oaQbz4s+uN+OlhN
   NOR040shwmTe9u/Yjc3bpuK70f8HTkbzDHuyvC+1BIVSOsYNcuLU3xEqT
   g==;
X-CSE-ConnectionGUID: DBG5pfWYQbmvVA8NI+Vg9Q==
X-CSE-MsgGUID: M4hvMeZ+RDW5VOK6J8Gkew==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61476444"
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="61476444"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 02:08:18 -0700
X-CSE-ConnectionGUID: bjkM2u5lTPqfNEKcXWHv7g==
X-CSE-MsgGUID: KMJUVqmBRz6XwrEpXlaz7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="146364031"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 02:08:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 24 May 2025 02:08:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sat, 24 May 2025 02:08:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.44)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sat, 24 May 2025 02:08:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UK19ODxBc4g8IkeF0EOhhdjbGy5wGfOy20QRcR2rDVuPilzoCw949q8OFcupJVL324nsTbsnVL/SRRoJ7B5oLHVfqZ+/N87K+AM+ehmR7sgA1gxlBcMp6uQecBNmr7gsZXhlWeQU9uapgY6+CXkR08jnxagmENEp3ge2Rgsdk1hF7acbDNQK5+TcumGjPkaoxusv8Q/elh7DnMWvMee4e2YMfkPGIT/rz7jbEi4m3a9oYmOjTUyC1FZ1bOCcRwWzmEviweZbxWom6ci3+kPxkLjR658wsLQYpqiRP8megzxjKNdeufYX2l12l0qLy6Kv0zR+IT51kkghl7FGogfIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zQai5rTKVcXdKLn8/fMq/W0/uC2xyXslgkhlmsucF0=;
 b=wqD3dK8KGbQPcnM8iwdR/2ffUjstgc6OygEW804faQcF7XsxUuBRw5Fx6e38sppcWVSFSOua9Sa48I5QBv5c+FZwl8mmMsdJ2W5dWQeMXdmDKxCcf2JocmJam3oNYC7zVqFUUwzqWUdAESxoRQ6FhpEUGI5lYpqYDzhqkwM4JW+PMUz1Kxm9Frm2x3XkTmgBxVLSHDdkd9muoR9EvQIK9jbUMDMKVAgUcOVbYc/Qul05ZeFD2SC5DjUvgJSGX+O56E9xxx/hRW5qr3YuQ8BQY142s/scsRCDL2K9iQdkk5uqCQV6DedWiJF84SFxUtEzOjP7vQL5o3W1adZRxr+Ikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH0PR11MB5218.namprd11.prod.outlook.com (2603:10b6:610:e1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.23; Sat, 24 May 2025 09:08:11 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8722.027; Sat, 24 May 2025
 09:08:11 +0000
Message-ID: <ad9f8af5-6bac-48c0-924b-498863370079@intel.com>
Date: Sat, 24 May 2025 17:07:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: <peterz@infradead.org>, <akpm@linux-foundation.org>, <mkoutny@suse.com>,
	<mingo@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>, <corbet@lwn.net>,
	<mgorman@suse.de>, <mhocko@kernel.org>, <muchun.song@linux.dev>,
	<roman.gushchin@linux.dev>, <tim.c.chen@intel.com>, <aubrey.li@intel.com>,
	<libo.chen@oracle.com>, <kprateek.nayak@amd.com>, <vineethr@linux.ibm.com>,
	<venkat88@linux.ibm.com>, <ayushjai@amd.com>, <cgroups@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <yu.chen.surf@foxmail.com>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
 <cx4s4pnw5ymr4bxxmvrkhc457krq46eh6zamlr4ikp7tn3jsno@xzchjlnnawe5>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <cx4s4pnw5ymr4bxxmvrkhc457krq46eh6zamlr4ikp7tn3jsno@xzchjlnnawe5>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0082.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::11) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH0PR11MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fbfd0e-7b14-4c4e-a2ba-08dd9aa281df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3F5QlE5QnRuOG41TktldEZQdUR3WFFxQ3lCVFhWYS8vclQ4bVJ0ejZuWjNz?=
 =?utf-8?B?YWVQTWJ6cGticUZUUGlQM0NTZVZoc1Y0TXM5SkNYK0thNGZhTE5Qbzl2dTlL?=
 =?utf-8?B?Ky9zcjZxbkZDd2dPbm90NmJETlhJTzM1Ui9ZRXRXVXZtV3A4NFJvQXBVbUNV?=
 =?utf-8?B?aEkzWE9ZTk4zeC9BTGZackpYbk5QaGdyNnNmWmNFaUVBZjBkN01xbDM1ZTVm?=
 =?utf-8?B?aWlZVkd3Z281dFJHQXdmcldSOGtLejFBM0hVc0g1TzVLcndXcG5RM2tzMnlO?=
 =?utf-8?B?aDlKQnZ2eDRxZUQydXB3alVvMGE2b0dIc0RDUXlKOENhR1EvUkU5MC9LTm9F?=
 =?utf-8?B?ZGRsbk1YZ2lUTFhLdlo2NGVzeUh3bzVZTmp3M2MzZVhHNC9vVzhya2hUd29r?=
 =?utf-8?B?dDNxSVpBdmNHM3QzdFFGL2Yyb0hzUmVSUlQxQTVuaUNqWVlUZGRGM3dhZDhI?=
 =?utf-8?B?ckpFeWg4STdTYkJqQkUzeDVOWlh1NVlpZEVDNnRNMjlCSXZjNmF1Y1hUTURR?=
 =?utf-8?B?WlE2WVJDZ0gzVGo0TEtRYmo4SmhVWmNpaG1EZm9YYkw0eWFoWkRCRnNacGpH?=
 =?utf-8?B?bFFzb0N5R1VHaTRLQVhGaDB5VjhTZ2dPY1lvcmg1emN2SDVWT0F1T3luTnlJ?=
 =?utf-8?B?ZlVnM25MTzBUbTlkc05pVzRqS2RLanB6RytBYk04QmJyS3hWQTBqeWtmRzFx?=
 =?utf-8?B?OWFwUi83NmhHaE02MU9HWlFZZUFFRWhudlhsd2RlenV5bk5MOHBIMC9LS1h3?=
 =?utf-8?B?WFNZdUNLbkZ2M3Iyd2prN1dYUnpHN2xGVWVDdXRZWlFaL1cwb2hEeWVadTha?=
 =?utf-8?B?c3JNcmx2dWFzSVJxYmpaNG5Rb3RlTytPOUI1QzI4clNqUkFjbjFYcFlZWUN5?=
 =?utf-8?B?SHl3TXBPQkZaZnREdUd1ck45UEVRYlc5bjU2WUM1dFVqM3U3ajkrRElQeHRR?=
 =?utf-8?B?OW9SUnl6Yy9QNFpRTERvY0xyajJ2UDFsOUJZbnl0N280QzkwV3o4OW9saDds?=
 =?utf-8?B?TEVYSHo5YWNsRWJObG50cW01cmkvMjVYNk1mVnlocnBlbnNEWXo2VWxTeXRz?=
 =?utf-8?B?emQ2cFllM0h4MFRYK1ZOckdTbmRrL1BwWWVuaFZ5U1BzcElodEZ6K1lKME01?=
 =?utf-8?B?QmFJLy9FUHZXZnhlVnkyWTAvTVA0Tkh1WGFXSnRNTFdvUkpRUFdET1pjNmYw?=
 =?utf-8?B?bW0yK0Fmc2c2cUJmYXI1aEZsQlhGTXY0M0tHRXBHbStSR0l2dDZDcndEMGtI?=
 =?utf-8?B?TS80bVdaaGVXRVlmd2pwYkRSc3liRVRBdXlCZXVTOG5WaWd2czVEc0Y5czZm?=
 =?utf-8?B?TFZZVHlwVms4Z3IzTXh5dERKUDZPenVtNDVjM3I3M1IzbXFNZ0EyVDNiUWo2?=
 =?utf-8?B?TjJVNUxwTHRQcVAxRVdZQzlMcW5YU1hYL3QzU1V6bndJcWFYL09rTk9HS2RE?=
 =?utf-8?B?U2RGbHMwVVYyRFhLZGhLbWx5WExNQzFzMy83b2ZXNXVRKzdmbm1BaVgwbyt0?=
 =?utf-8?B?OUdlaHlka1lIR3pNVTN2RVE4empKYnA4WG1TZ1YyMnBWZVlCaXRoWmpTcG1N?=
 =?utf-8?B?OG9mZkZYVHNDTXNMNjNMSmFISkd1STVOTXAyb3ZvU0dyS3d2VjlsbTU2UzFx?=
 =?utf-8?B?cFhqdVdQZlZQc2xXakM0djlXTXNqekRRUzZwY20yeVFnSTV3OEc4Sm1mUHJT?=
 =?utf-8?B?dXRrTENxaEg5TmxOZEIyTjRiLy9rd011VUV6clR4MG9FUWlnWjByT1dJTHZD?=
 =?utf-8?B?ZEczMStaU3VRTTJDVnBhRjBBWHIxTFIwTk9EWVNFNVkrMnF1VlZ5RnI3VkFw?=
 =?utf-8?B?TW81aHRPL1FTOTJRQjBqK0xnK2cwRTlvMXl4aGd6UFZmZ1g1MHo5Q0wxN0Nz?=
 =?utf-8?B?WWV0VHpqd0ZUVmxXdnYwajhhVjZJcXoyZjNpNDRrN1JXekkyNUE0RHF3YWNX?=
 =?utf-8?Q?4MZLAQLJUYQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y01GTE1VT3I3ZnlHWDR1ZjBSMDFXc1NVdlNuQS9NY2pqbmdBNkNyOHFNdTh5?=
 =?utf-8?B?d0ljS3RZdzcvTUw4WkI2VGVwU1RtUE5JWm9nTFMwQ1g2a0cycnVJT0h0YU53?=
 =?utf-8?B?VURaQjEvYVlWd3gvSnNQTVNYWXIwM2gwU3g5VERydlBnTVdMV25UWlVodSt0?=
 =?utf-8?B?aS9Hc21EUWl6bWVxQzdOd3pxV055ZEc0YWtuTG11SHZybERneW9PeTExNmVs?=
 =?utf-8?B?Zm1Tdjk4ME10TlhQSUJzZEphbU82TElkTklMM3hXUThQbGJiS0ZMbUZIaTF1?=
 =?utf-8?B?bFpMdVFYNlJhdVRsK2h0L1habjRxeHhjY1N2MHBQRWVUQ0FpeXdkSTBORVpU?=
 =?utf-8?B?Q016djg0TFEvQUhYQUk5UHF2U2U3bVBoNGFNOFBCenUyYmVoYlJ3VGtyNHBp?=
 =?utf-8?B?MlZybnF3MEYrRUo1M0ZtVm9NejJ6WEdoeXpjL3E4NTNHMllHRFVTaUNKNW1M?=
 =?utf-8?B?dXpKZ24wdVZrZnZ0REZxcjVPNmx4OUcrTG56TENXWDEwSGdCRFNZc1hwMG0v?=
 =?utf-8?B?cVp3c2RiTnVpdjduUVlhZmZYNUxTSVNYQ2lqMlNlUWZqY2NxaXo3and4cUJj?=
 =?utf-8?B?ak8zVXMzVUZ0NldLRURyWENtUnhFeWhYMnNKeUNsLzhwbGtBR0U1cEI3WXVm?=
 =?utf-8?B?THpjbWdaWVdzM0ladTVCbmF1S0RoNVdYeVRBUWVxa2w5YnZHQXh1T01DUk52?=
 =?utf-8?B?RkJ1TklIaGNNSjBGU0xPcmtUNHdXUjdxL1VCWlN6ZEU0bzNXY0NVcldSNEVL?=
 =?utf-8?B?NUM0RlQ4N0VkYVcyV3dTZ0M4NmtMaG1jSHU3NmZ5YStGdVlVTHBKbktPVTl6?=
 =?utf-8?B?RFNJQzZmNzNDVnZKcER5dEFuYXIzN0drRGttSmx3UVJVMVBqQm53VHJQK3dC?=
 =?utf-8?B?RHgreW10bzZlb01QTzhjMWNjbEJadHJ6SnJGaHIzV0tZd1FOK3BBTG9OenI3?=
 =?utf-8?B?S3Q1dmJGaVJUVU9WeGU2VlMzQXR0bklTNldFYk5ra09TRlRxajZ6bHlzQWN6?=
 =?utf-8?B?aEd2NStWNi8ySmFNRDNaTUt1emRxSnF3bHZXQnhTa2JaWXBCL3MvdFRGTzB4?=
 =?utf-8?B?RTR3TEozalh3L2hmNEFNL2ZLMThEUjQxTDVFcnh0VTkyZEYvRWtyV2NDRitR?=
 =?utf-8?B?YXN2d2JSM0xESWwvSnNWVmY3ZlhDeFl5V1JZSDNSOUJoRFRNVlVVRmZ0WnE3?=
 =?utf-8?B?dHlaRVBvNzhEcFRSMDV2SStBMHJXaEx3ejZIWGU5S2RMSGtRVmoxdEdhZzFT?=
 =?utf-8?B?SXhNUUY5ejBlMUs2WmozMEZ1Z3ZrczdaanhiV0FoSW51NmQ1NTNHSEtKT1I0?=
 =?utf-8?B?RlVielZ1V1AraVNvamZGRzlnRHRyQWhNaGhtR2ZySTlQSlBtTkdiZU1LU21q?=
 =?utf-8?B?Rk5HaHRld0RIdDVEMmlNVHhpVXRYVHRPaFJaSVY0bnBXYXNIRFlMNFFYNHND?=
 =?utf-8?B?SDIxRzc2UnQxcEx3Mm1LL1RKbkxFWXNseVdhOVQrN1pZYzhya2FjcmJKMmx0?=
 =?utf-8?B?QVJRMHRjMEhZTW1pekx4VEZCaHAwWUZuUElUUm9LblBMNC9hekJYYmFxV296?=
 =?utf-8?B?Y004R1ZDR2VYZ2dKb3NHR0dra0dobEViYzJVZjFWYkMrdlQ1SGJhS3FUeUYr?=
 =?utf-8?B?T01wamVMbW5zbmpnOVdhcUlleVZiODIweGpHeWI4RnB2L2pyOGVVQlIxK21G?=
 =?utf-8?B?ekZORkNZbDVsNlJaT2JUZ2JxT0RJTlBTK0sxcHQvY2pua29hSEtKcG1BTXZ4?=
 =?utf-8?B?U1BYZUI5ZzBiQ2h5amdUSW5mTC83ZDlDaGJkL1BETTQ0Yk8vMno5RzhnZ3ls?=
 =?utf-8?B?a1VoeW0wSW92U0IxTE1WUlFRcmxoc2U2c3NtSThXOTdVY1UxcUpURmZMZDFn?=
 =?utf-8?B?WnBVVXYwMHVBZ3AwTVlmN3p5ZTdVN3FHaitJaHdKNlJVVXFsamo1UWJtWW9Z?=
 =?utf-8?B?bjhRejljTGVTa1FVWSs4SFZKT0hKc3JFMU51RDhRSnpycC9yWWE3Vkc0SlJD?=
 =?utf-8?B?RWdSQ2ZQRlVyTlRDbDFBYkE0OWVtdlpUK1ZzNDYxNGtFajRrSUhZWElCR2VJ?=
 =?utf-8?B?dWh3c0RrNnZNNUFRK1pkRjgrMkNhMTRkWGprbGoxUEcyNkhIV2Y2eHNmV1c5?=
 =?utf-8?Q?fA+I3pEragl0yG3+ck+hG68pO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fbfd0e-7b14-4c4e-a2ba-08dd9aa281df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 09:08:11.4317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPJccHZP0biuvg2fIMIifpj38alLGYzCpbYIld8OOtq7sTgVPvDvfB5LKfaNsefc8ppaSVXe6eLIEuoT2+Hwqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5218
X-OriginatorOrg: intel.com

Hi Shakeel,

On 5/24/2025 7:42 AM, Shakeel Butt wrote:
> On Fri, May 23, 2025 at 08:51:15PM +0800, Chen Yu wrote:
>> On systems with NUMA balancing enabled, it has been found
>> that tracking task activities resulting from NUMA balancing
>> is beneficial. NUMA balancing employs two mechanisms for task
>> migration: one is to migrate a task to an idle CPU within its
>> preferred node, and the other is to swap tasks located on
>> different nodes when they are on each other's preferred nodes.
>>
>> The kernel already provides NUMA page migration statistics in
>> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched. However,
>> it lacks statistics regarding task migration and swapping.
>> Therefore, relevant counts for task migration and swapping should
>> be added.
>>
>> The following two new fields:
>>
>> numa_task_migrated
>> numa_task_swapped
>>
>> will be shown in /sys/fs/cgroup/{GROUP}/memory.stat, /proc/{PID}/sched
>> and /proc/vmstat
> 
> Hmm these are scheduler events, how are these relevant to memory cgroup
> or vmstat? 
> Any reason to not expose these in cpu.stat?
> 

I understand that in theory they are scheduling activities.
The reason for including these statistics here was mainly that
I assumed there is a close relationship between page migration
and task migration in Numa Balance. Specifically, task migration
is triggered when page migration fails.
Placing these statistics closer to the existing Numa Balance page
statistics in /sys/fs/cgroup/{GROUP}/memory.stat and /proc/vmstat
may help users query relevant data from a single file, avoiding
the need to search through scattered files.
Notably, these events are associated with a task’s working set
(footprint) rather than pure CPU cycles IMO. I took a look at
the cpu_cfs_stat_show() for cpu.stat, it seems that a lot of
code is needed if we want to expose them in cpu.stat, while
reusing existing interface of count_memcg_event_mm() is simpler.

thanks,
Chenyu





