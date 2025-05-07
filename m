Return-Path: <cgroups+bounces-8053-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 389A8AAD3A1
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 04:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3766B3A68D7
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 02:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4F319D087;
	Wed,  7 May 2025 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fs0/i6Pr"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFB79E1
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746586567; cv=fail; b=TsFXLzfyklcIn8jRe9CF9AwfRHSGAUufhLifb0G6y/VjMPdpbCwBAEwBt0Ig4f9FA570ESDIWdgbkZuPlC0zblUCioEmfBhxaebv9U8N6sdBCHwVgfzkr+VZpZ7+5rdFH2F/l0S22vv6/Ypku0UzghhEeY8L5hYeaMv50jyD3b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746586567; c=relaxed/simple;
	bh=C3R2vrwlijeqGwNH3Jygw7g+B7BcwCSGkUIT44ttpiQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Z0RLm9uzBQ0Z51cOB3Ap4wf2z6V8C1XlhOgCkCMbXQD2KDQKGjro5EpR9EyKvrY1udCiw88BK8rhI+mLMrJOCuw136Y+ZSV2/edO+KZOrwvjsj06Xt8gC0a2h1xdKU6nJvc2w4/RdJ9VO0XA+wjp2S6ia9iJfwWazbpJU6Xs53U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fs0/i6Pr; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746586563; x=1778122563;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C3R2vrwlijeqGwNH3Jygw7g+B7BcwCSGkUIT44ttpiQ=;
  b=Fs0/i6Prpm3sqzMjQVYFDWz1aP9MGP3dr1GlwCK9gxlNnxzrWP+z96Ar
   VN3o6leemHNjMSmLO7mpKoko8Lk3GTtSyIrXW5U7pgvgEh1fd0e2PNHQt
   zWQE8sxbNyIqxWaX7PI9ZfwKjVAn9rf4xCsjA8KHVxTMdKT0aU+elW65s
   LP5FaHdFj28YOOQQc8Jhv/R7Wf+R7T6CfxpdecTfNL4YYsin5+ef1XIsy
   FacLC97X/+jkEFYZ6MNQAiGZgdU/KP9/Up5mhfT2lIl5qx6n6T3MpyiKu
   K3oCNAENGYMC9+7k7IodUrRNhHIj0o7fB/0hJ6ONaCX1Y484JglBHySCG
   w==;
X-CSE-ConnectionGUID: CQmPdLVFQEO41Ft6Qr4uXQ==
X-CSE-MsgGUID: vAFJdwT4TbWbyAQx+jl5Xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="52104746"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="52104746"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 19:56:02 -0700
X-CSE-ConnectionGUID: /WhwXWUZRGupkvAplMUfsA==
X-CSE-MsgGUID: kWeyu7GIQ5mPP7iruGtSdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="135814297"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 19:56:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 19:56:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 19:56:01 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 19:56:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeukmOzpeVrhs7H0eLxZRDRfTGlHfbc9EixPmcvRLJZF6HgG67rRqElOiXvLOkONx/nVMHRawFp7Uc6GO6nzRmc3ylN8UKikx2MYxoWe1Op5I1tAgVQZJ66x+4NyOElqf1Z4OHVRJhrbo5tzj3GtTUMiFVXSXh3Q8i+WUU7GdcbkIZwC4c4iz91GvoBbsgSQVyYNMiyRAO98pC7+1aV3T+dpFnR5hXxiwRUI7lSoESnvp3Ecui1qWRO66hyk94Gjn6HHPW6GkViuXaEjuD+t5GPFtH/I6XORtfzJ1QmQVh5FygIhFmO4uIXyEF/p9pMNaDt9RAYzVYaqsq1fHjTEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSVr5OaqtPHECuczIC4xjgYlN8A5guywsd3sXmz8qvw=;
 b=Q10LkbdNG/gIAPFVA91l9D7F8YRj++Ggedf0dAaLNQ04Ahr+NxRGYszFcw6mPSDKcrUJaucGU7uvzalQ+AQg2U9+KNX/IHqLAaDJePbmh2ig/r2DieFn7T0k4HwWABh3FUcehSJRQr97gWSD5BzLk2KrBcOTOFMy4C0Yd04uGHeWIYgfKjHfFw8djSqqt8QMnG957AtKg04DeyXpdfrTX0TXv04Ew5v1imiDfg/6nmNtar9cgOKeatQlgOwjqtgtyDbpagtV0fUOQkZS/+eyOHjIar7Gsj0NLBaOgixq8D2PWeuwXrz7Hs+joGJClp7RaOHOpgf2n7dXjVJRkP38wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 02:55:13 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 02:55:12 +0000
Date: Wed, 7 May 2025 10:55:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumaze <edumazet@google.com>, "Jakub
 Kacinski" <kuba@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Michal
 Hocko" <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Soheil Hassas Yeganeh
	<soheil@google.com>, Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins
	<hughd@google.com>, Michal Hocko <mhocko@suse.com>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [memcg]  314315f970:
 WARNING:at_mm/page_counter.c:#page_counter_cancel
Message-ID: <202505071038.5b0f43cd-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d460a3-d385-4aed-ae7b-08dd8d129655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fzU92nSNdkcvgSwb86ztNuB13/xxs3p2i6ErudLTzDHgjuSverweX1mCBqLi?=
 =?us-ascii?Q?vs13SD6eXDMam1/mVYRXAOWyJqbdJKJOdlzVh7zYMwsEvMqZdYlVbhs4dfcW?=
 =?us-ascii?Q?DIEnCtRS0PTmTfElweD5YxOHmZ+mQ6P8ycHbGU7yf9gAT2vW6b+jDZfAe2lo?=
 =?us-ascii?Q?hPGIaGQ41/K0oH9euWbakQZRynOdbqlhCZcjexQbLPUHO6sALcP+XZlzmsOY?=
 =?us-ascii?Q?PI3coD3B8E/H4pz0MVIZnFsNyPYqWWsB8ahDSOUqRq2yd2KmAvLgrQgBurEw?=
 =?us-ascii?Q?shH7idoNWVsE1ojIfJfXbOemjyFUPzWbF7MmTRnsAMXN5D5RsdjY0YME4vFf?=
 =?us-ascii?Q?JbRrdDtiaGRNVAH/YlqHp0FFqBGU3h1Ctc+0IbaFKBtWvXO8eat88u+82Q7r?=
 =?us-ascii?Q?ygAfOPTl4rIYrvlZVMNmN97pUbwVsWmhS051JhL3LhJNZHPQK02SEQ2tcHP7?=
 =?us-ascii?Q?g+tN1/B4KO6uhbkFbHiENpc5pXaMyUYnh+zuL0/Bp7fvh5R8xBk15IbHf8/J?=
 =?us-ascii?Q?sBRO+cSi6wC12HQmiANOQ/9HdQk88FNPtoCC+Cnq3AEVZrsk4Uwc+MNhIOps?=
 =?us-ascii?Q?pI+fB3ONNqfrLRBt0HXmitSygAmv034bsJSn83cyqYxsvlygbEs9FWk6yl1z?=
 =?us-ascii?Q?d/2D1xGB+e/uEClw7bFo+sqQ27ND07+SST1ZSltXpoqBoZ70BeEgS1bAyMc1?=
 =?us-ascii?Q?gziBrdXpsf10mCHFf86DAwRALH4321S7AnbTi8F80hkyqLF4sqar4qXLPSSJ?=
 =?us-ascii?Q?IcPPNxBHyu5TD41/RzbPfIp00n+slBuj3vVDq2zM9hVO74tNvUEXDxUjiWru?=
 =?us-ascii?Q?H4AtrKe76UipwKiB5l7cGHD155hZDa/5x+bq4RoNc1GcSVt46fyeFyLJx31x?=
 =?us-ascii?Q?tMn0TAeZg6T9S59zgHnygJlv2HFuwXhht27bV+gb+Cs1YQc2V9FVLlRby0vq?=
 =?us-ascii?Q?EDeaqnjeaPHyTkSq4qEcZR3ayarhMowQOucDHHBEO6gau3Tg//gcSfJkeoOR?=
 =?us-ascii?Q?WHAKkQb+mblyJs83MZK7zgemupsQnF4/Rw0ml/zVuHVAFuewaTb+5qvMXkgP?=
 =?us-ascii?Q?yLHVq+3MMESqkt4i/ukhLifz7uQyZAT9zMRnNWyabt06sT7bAc1tiToXquMe?=
 =?us-ascii?Q?ESswh5vMjhQ9cJ5oBqB9VbjsZVn8EjHhgNd5KXGeXtCJCnO3ZmLySo4XEauk?=
 =?us-ascii?Q?JNKCMRhO7NdhyVsZVpB8vhr8W4DSqLzscLZN2lsdw+7PlLvdN0FWrWis7xaq?=
 =?us-ascii?Q?6XexSVYCrBh4LHFopa9+b79icqQT57lcVRfzLWKQxPVI93PHsqsQjS0I+1AX?=
 =?us-ascii?Q?99NKjlGG6qqV6Rg2+8mcUdBHWmDTPSEpeseSf6GrgpEbFKKnyYqFHH4+29kh?=
 =?us-ascii?Q?w7DBN9GP5DAidZngUbQwtgbO/ccq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UIKBxEmPhqdQXWdzfO8JAsvXpWGHDwiwIkl+gcVf2FQPdYiuZUZqSjqECYsN?=
 =?us-ascii?Q?+7dHJKLSDOfhnlfu6/eKV5hKVCI2oOzNNKRbusWh9+U9m2t4jWt8ivlxcd4S?=
 =?us-ascii?Q?YFYR6GzSwKTiY+RmdkI+ql+XwpRAG40G78H2Vw5907H/6BkAPqqE6z9m6EeB?=
 =?us-ascii?Q?rZM/z7in3OqVJWRdJuB+H3buQCTfToStHkBeFgcMrEJoV4Y8Zbqj5nNaMjZL?=
 =?us-ascii?Q?nKGM71yaQUld7/aTewahqR87XA86QDh26AWKWFNvGtzlENsD14r2dNLR5sOD?=
 =?us-ascii?Q?Cuqzy21xNAoyKg32bq4NuzEAthAlKK5o2NivdNDYzrXGivB5i0ED5GnjVgm/?=
 =?us-ascii?Q?BnIEbRCkeAfj8X/ALqgFqMa8UcdHIcMscG5l9I3MPv2X0DNU1LW/qhe8vQM7?=
 =?us-ascii?Q?nJRFGhOQJ3KyCXQnKaohIwC4B23zW/iZ49It+eO0m/qAt1xjbHK/JxcRr1oL?=
 =?us-ascii?Q?7vgLLjTmGJpBSymX/9/5Y6fMhBwTMFTBfgsS2WgdTnEI8XvSE4bEJiBJnnkn?=
 =?us-ascii?Q?DrNvSSPfwj6Tbz7Gfc9sCowD+hw+rsX9s9YaLkSZwMAWitOqKQCW98oSa8WE?=
 =?us-ascii?Q?L0bCKFHtbkFCuSxUG0XN1ucyE4LYkSNtRB3SKHZiOzfLS6BWsqb1bZLUPpBH?=
 =?us-ascii?Q?+8PWcfEFhPfrnxNAK13s0gl36yZsFFrufFjWnoQpG7bXKdl4gY8Zfmof4JWM?=
 =?us-ascii?Q?nA6mzAYnNJCvvjWilnLHrRjRjjmDp8yZNvmHAyf9/VXGs/Wf7bBHjRZppp1N?=
 =?us-ascii?Q?gDOCYb+UidULM56pBlz3SmvOgZA5UdSFmV+Vzu5Rj3cUsFHdPoj/n720AT1j?=
 =?us-ascii?Q?VxWQqxznz1KH3hAvmzMMx8BdjjBS2w5Y/fikVC2cuho2zQWBAuafgW3twaGM?=
 =?us-ascii?Q?IwtI9FxEyeFNvDi5uEkcDilebQh2ibpgbwXsNn/5L8k9O+aGFC6hUD3me6cx?=
 =?us-ascii?Q?T5/Q8qrK+nWivGvNlmvvCC/1Gc0XZemdHr6td03QRAlI8++coz5KaLOGbXjb?=
 =?us-ascii?Q?TgqhpvBZRZaK7LCpKaqyubLY1Jy6HK76Cw1pgn3bZZowcpWIsoeQ0sW9tyS9?=
 =?us-ascii?Q?s8Z/6q9Lxiw3cVxUxBVHQgGW15LDVRrWx9nsNjKBoobavskfr8F/SZSqNO7N?=
 =?us-ascii?Q?lEe6kJqG5smMl1/3xlPOFMQh173/877T20JDXh42VSia3YiREQQZqlll+nAk?=
 =?us-ascii?Q?Vsvzb1QkHych4/zoiA3+2916Xm0TMuyZwt88Ytel19NKnOaA0U1FAOQHBWVd?=
 =?us-ascii?Q?dby2OlpsuL2FufD2uvFq44QqfwyZt9udwIIxPtx2V2ddDBM/78f9oh7FpGrk?=
 =?us-ascii?Q?rVRfjXHVH8RKraSFoCzL1ANjm6bQHnCmOJz3xRCBnLrjnNEhlhu6AFpiXmU+?=
 =?us-ascii?Q?rReGHY5xHdYIpmOVS4B1ThHtsDUgaIougDUPZwfEvA+bw2Xg6xef3dBlaQ3J?=
 =?us-ascii?Q?OUYCC+nsLIIRA9Ows3Bb4ZUmXGSSvGhq887ASJrH78x0s8ekMcJAARNCGplz?=
 =?us-ascii?Q?LDmstnewUsUq/if4FuUBILYS3PXvVzGM0Gs0C9eK9W/xAe6Un0cg2MnRnQzQ?=
 =?us-ascii?Q?RwfmHNerjORTJvS1VcU5ZCdSvvIf9to+tnLY4xagTfGmiOQ8X4fPdaUIs9+s?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d460a3-d385-4aed-ae7b-08dd8d129655
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:55:12.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrruAb9emUaAyb3aM0WgEyWgqNYEzxAqtugUtL71eQdtWfatOCbrsREPWu64jrSgr4fiLHcJegGKRSwl11cVcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_mm/page_counter.c:#page_counter_cancel" on:

commit: 314315f97034a4235a92c49d8d250273064a0b04 ("memcg: multi-memcg percpu charge cache - fix 2")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: boot

config: i386-randconfig-054-20250505
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------------------+------------+------------+
|                                                                  | 706e1bbb16 | 314315f970 |
+------------------------------------------------------------------+------------+------------+
| WARNING:at_mm/page_counter.c:#page_counter_cancel                | 0          | 6          |
| EIP:page_counter_cancel                                          | 0          | 6          |
+------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505071038.5b0f43cd-lkp@intel.com


[   12.841558][    T1] ------------[ cut here ]------------
[   12.842138][    T1] page_counter underflow: -191 nr_pages=255
[ 12.842688][ T1] WARNING: CPU: 0 PID: 1 at mm/page_counter.c:61 page_counter_cancel (kbuild/obj/consumer/i386-randconfig-054-20250505/mm/page_counter.c:60) 
[   12.843497][    T1] Modules linked in: autofs4
[   12.843977][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Tainted: G                T   6.15.0-rc2-00483-g314315f97034 #1 PREEMPT(undef)
[   12.845080][    T1] Tainted: [T]=RANDSTRUCT
[   12.849671][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 12.850748][ T1] EIP: page_counter_cancel (kbuild/obj/consumer/i386-randconfig-054-20250505/mm/page_counter.c:60) 
[ 12.851328][ T1] Code: c2 01 74 0c 85 c9 78 24 80 78 28 01 74 2c eb 68 c6 05 6a d4 e3 c2 01 52 51 68 1a 52 75 c2 89 c6 e8 37 9c d4 ff 89 f0 83 c4 0c <0f> 0b c7 00 00 00 00 00 31 c9 80 78 28 01 75 3e 83 78 3c 00 74 38
All code
========
   0:	c2 01 74             	ret    $0x7401
   3:	0c 85                	or     $0x85,%al
   5:	c9                   	leave
   6:	78 24                	js     0x2c
   8:	80 78 28 01          	cmpb   $0x1,0x28(%rax)
   c:	74 2c                	je     0x3a
   e:	eb 68                	jmp    0x78
  10:	c6 05 6a d4 e3 c2 01 	movb   $0x1,-0x3d1c2b96(%rip)        # 0xffffffffc2e3d481
  17:	52                   	push   %rdx
  18:	51                   	push   %rcx
  19:	68 1a 52 75 c2       	push   $0xffffffffc275521a
  1e:	89 c6                	mov    %eax,%esi
  20:	e8 37 9c d4 ff       	call   0xffffffffffd49c5c
  25:	89 f0                	mov    %esi,%eax
  27:	83 c4 0c             	add    $0xc,%esp
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  32:	31 c9                	xor    %ecx,%ecx
  34:	80 78 28 01          	cmpb   $0x1,0x28(%rax)
  38:	75 3e                	jne    0x78
  3a:	83 78 3c 00          	cmpl   $0x0,0x3c(%rax)
  3e:	74 38                	je     0x78

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   8:	31 c9                	xor    %ecx,%ecx
   a:	80 78 28 01          	cmpb   $0x1,0x28(%rax)
   e:	75 3e                	jne    0x4e
  10:	83 78 3c 00          	cmpl   $0x0,0x3c(%rax)
  14:	74 38                	je     0x4e
[   12.853232][    T1] EAX: eb6cd0b0 EBX: c2d13838 ECX: 00000000 EDX: 00000000
[   12.853946][    T1] ESI: eb6cd0b0 EDI: eb6cd0b0 EBP: c3973dac ESP: c3973da8
[   12.854647][    T1] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00210092
[   12.855440][    T1] CR0: 80050033 CR2: b7e1eb80 CR3: 2b908000 CR4: 00040690
[   12.856143][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   12.856867][    T1] DR6: fffe0ff0 DR7: 00000400
[   12.857404][    T1] Call Trace:
[ 12.857816][ T1] page_counter_uncharge (kbuild/obj/consumer/i386-randconfig-054-20250505/mm/page_counter.c:183) 
[ 12.858419][ T1] drain_stock (kbuild/obj/consumer/i386-randconfig-054-20250505/mm/memcontrol.c:1868) 
[ 12.858872][ T1] refill_stock (kbuild/obj/consumer/i386-randconfig-054-20250505/mm/memcontrol.c:1958) 
[ 12.859323][ T1] obj_cgroup_uncharge_pages (kbuild/obj/consumer/i386-randconfig-054-20250505/include/linux/cgroup_refcnt.h:78 kbuild/obj/consumer/i386-randconfig-054-20250505/mm/memcontrol.c:2743) 
[ 12.859837][ T1] refill_obj_stock (kbuild/obj/consumer/i386-randconfig-054-20250505/mm/memcontrol.c:?) 
[ 12.860313][ T1] __memcg_slab_free_hook (kbuild/obj/consumer/i386-randconfig-054-20250505/mm/memcontrol.c:3169) 
[ 12.860829][ T1] kmem_cache_free (kbuild/obj/consumer/i386-randconfig-054-20250505/mm/slub.c:?) 
[ 12.861305][ T1] ? seq_release (kbuild/obj/consumer/i386-randconfig-054-20250505/fs/seq_file.c:357) 
[ 12.861752][ T1] seq_release (kbuild/obj/consumer/i386-randconfig-054-20250505/fs/seq_file.c:357) 
[ 12.862225][ T1] kernfs_fop_release (kbuild/obj/consumer/i386-randconfig-054-20250505/fs/kernfs/file.c:767) 
[ 12.862777][ T1] __fput (kbuild/obj/consumer/i386-randconfig-054-20250505/fs/file_table.c:466) 
[ 12.863259][ T1] fput_close_sync (kbuild/obj/consumer/i386-randconfig-054-20250505/fs/file_table.c:571) 
[ 12.863792][ T1] __ia32_sys_close (kbuild/obj/consumer/i386-randconfig-054-20250505/fs/open.c:?) 
[ 12.864347][ T1] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-054-20250505/./arch/x86/include/generated/asm/syscalls_32.h:9) 
[ 12.864927][ T1] __do_fast_syscall_32 (kbuild/obj/consumer/i386-randconfig-054-20250505/arch/x86/entry/syscall_32.c:?) 
[ 12.865539][ T1] ? up_read (kbuild/obj/consumer/i386-randconfig-054-20250505/kernel/locking/rwsem.c:1621) 
[ 12.866048][ T1] ? irqentry_exit_to_user_mode (kbuild/obj/consumer/i386-randconfig-054-20250505/kernel/entry/common.c:234) 
[ 12.866692][ T1] do_fast_syscall_32 (kbuild/obj/consumer/i386-randconfig-054-20250505/arch/x86/entry/syscall_32.c:331) 
[ 12.867263][ T1] do_SYSENTER_32 (kbuild/obj/consumer/i386-randconfig-054-20250505/arch/x86/entry/syscall_32.c:369) 
[ 12.867774][ T1] entry_SYSENTER_32 (kbuild/obj/consumer/i386-randconfig-054-20250505/arch/x86/entry/entry_32.S:836) 
[   12.868328][    T1] EIP: 0xb7f9a539
[ 12.868770][ T1] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 58 b8 77 00 00 00 cd 80 90 90 90
All code
========
   0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   4:	10 07                	adc    %al,(%rdi)
   6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   a:	10 08                	adc    %cl,(%rax)
   c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:*	55                   	push   %rbp		<-- trapping instruction
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250507/202505071038.5b0f43cd-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


