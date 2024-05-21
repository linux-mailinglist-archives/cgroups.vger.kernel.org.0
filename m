Return-Path: <cgroups+bounces-2964-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DDA8CA650
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 04:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8280EB22209
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 02:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5911078B;
	Tue, 21 May 2024 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVAitjkM"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592A517548
	for <cgroups@vger.kernel.org>; Tue, 21 May 2024 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259446; cv=fail; b=rQhDMRfKtHKnZ3DzilwCynjWA1phww28GVFnmEZLKYX72hY7lixTING7s0uPmjqXLSAxtdAJbE6ND1OjNDc6riX5IdhGeyEMa2hv1g4BO9bakE4i0ykyaBOFPPvqfvOZEXtlFo+emMHnbquPmq8wdWiyg7D9pcnZaitNjT6dZj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259446; c=relaxed/simple;
	bh=GUMqQX8fTOtdaODdBCvrsv8pnuGxdPXv5Z9pc+qJ+WA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qg34mVpZ20vjwLfS/eTedtsVnZLs/D7qsJ+zcdzrMukZ6dd1ZYmrrHtHZ/ZcDhUxxqImdQSe2/foBXuXEQCKOWcG/3ETJbV50nWsJ5zpC4fK4La2/QaBdErGbGEOlv2JHEQMennGlGm2wj5w3K/PbXN2FbjggTWrNVt8PgpQuE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVAitjkM; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716259442; x=1747795442;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GUMqQX8fTOtdaODdBCvrsv8pnuGxdPXv5Z9pc+qJ+WA=;
  b=mVAitjkMyteMJAEJ8j9J3rrAM3oObBHilx/WGA1uh8Urrkx/wfiWoP+6
   k3il7whJO1yM6FvdFxrHOT4XjiYQk0agV4arTnbtptRDhBYgoNp3Qn0Vh
   7G/Rs5wF+gFGRjsejjC1pfeVAQN+j4r/rdB+AdiNP8w0LGDFzfEBUcb0f
   8hN45T1Y0YGUxxzmtYZTVz/Is3nutREytixXwwm192jI+kekj0GcFkGf3
   toYYufpb9tYwkT88O3MfnLjF8tTHSdyKWqU8/Uqxf0hawEPHzp4j1+uOl
   ASV3sBy/kVO1Ln6rIHr1l4oKwHHhMyLoaFdY78vwIrOyIGca/eVieD5m2
   g==;
X-CSE-ConnectionGUID: zbTp2wTzTCyOFywqbbFDpQ==
X-CSE-MsgGUID: OZtNm0f2QqSsHCn9ZIjrYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="16213217"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="16213217"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 19:44:01 -0700
X-CSE-ConnectionGUID: mGhahNviR7igWPXJkiOgMQ==
X-CSE-MsgGUID: OE4g1HG6Rzm8BYd38yZOog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="37349003"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2024 19:44:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 19:44:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 19:44:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 19:44:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 19:43:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQFnrpfYeK8O6EqCznjPeWeR+j6UD2YpBmu/SX8Q+AeiYeR5SJ0Pq1Dmf5DdIlorKZ8//cfOEVswcGmLDescsnO25aJuDzoXrN2/Puu7e22V/PmtQZJz3r2D7jw2Xj8J6yZFUX/nz1rd02Nj3Tv8XYkAaAmednyZAyHW4nyC+HWPIdBE4mnFZjdr0BRSxxiFRVA4iT6ptsufwrjRCVL/Cp4dZZnash8PB+plCk4gZ6u6lCXqtxTRzaraUleyhOVkxTx90q3FTvlie2cumfz5lt+TD1SesINQ7A6++vCm4+aASK+nbN8ou1l6Jl1UEgs1e/8WSrG8tCsbQJK1hcGVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAXEzLQVl8xnct64iQS7OjaDhOXRV6LN0ncgjDSlJ+8=;
 b=PK3w7lJspAiFbV8dPmM2l7RzEDv4IKHoyP1WvUPeVrAq4kQ/Ckt9Yrk/JLY/6UobifL9j0oYSiShTAmjpe+K5XDhLcnPkuWq3NxCU0H43wzzLWzkq9FOMhatLri9KOKTVslYfEX3Ymoa8ykCP4Lx23dytwoXiv01j+dK3+n1Ng3uBGx28teQCpK4/Gkw8gQcqD9btGaZRWogH9mABdSp6M84bu+ENJr/AhVY6wUn54/aBYqDIwPVKM9czqZWzNllzSsdaokys2bo+2y1RKCkqOvQUaw8Vu3VOk6QQgs7KSijWdYzxlzWKajr5NKYuFc4IqRgIc8B2iS8s9ZxXMNhnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB7064.namprd11.prod.outlook.com (2603:10b6:806:2b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 02:43:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 02:43:27 +0000
Date: Tue, 21 May 2024 10:43:16 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed
	<yosryahmed@google.com>, "T.J. Mercier" <tjmercier@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	<cgroups@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [memcg]  70a64b7919:
 will-it-scale.per_process_ops -11.9% regression
Message-ID: <ZkwKRH0Oc1S7r2LP@xsang-OptiPlex-9020>
References: <202405171353.b56b845-oliver.sang@intel.com>
 <pdfcrrgqz6vy6xarsw6gswtoa32wjd2gpcagmreh7ksuy66i63@dowfkmloe37q>
 <ZknC/xjryN0sxOWB@xsang-OptiPlex-9020>
 <jg2rpsollyfck5drndajpxtqbjtigtuxql4j5s66egygfrcjqa@okdilkpx5v5e>
 <Zkq41w8YKCaKQAGk@xsang-OptiPlex-9020>
 <20240520034933.wei3dffiuhq7uxhv@linux.dev>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240520034933.wei3dffiuhq7uxhv@linux.dev>
X-ClientProxiedBy: SG2PR06CA0195.apcprd06.prod.outlook.com (2603:1096:4:1::27)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c145a8-2505-43dd-ef0d-08dc793fcabc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5pAwLYG1azp7wVEHHPF/jddL+EfN5W56V1EF+zklQKSAawZR2V3OB0QXKL?=
 =?iso-8859-1?Q?jW1oA0VDMF2oknGWBNaPw7k6Kd2n8TlE33XDsdGj5K6CK7wOO40CsnUtpP?=
 =?iso-8859-1?Q?adfy5XIMCM0J5BJZO5bICjRmgzJ7XrNxN9BqCcizAutYUG10ErbDBhkwEM?=
 =?iso-8859-1?Q?5Ragjeo4UiBtpHmXEb1KYHQ9jHEHqI+Mty+PK52G22lkTlyoNfBLxYQ6bi?=
 =?iso-8859-1?Q?ooCpk6c37R7d1d5M+gdUR3QX9anYNvtLCMFesdMOtKf1rv61k4TASAp5Bf?=
 =?iso-8859-1?Q?Pr8cv6NfP4GZ0diOAJyAlzRM/H45BSo3eZ2aASFtVQsj4kGX5ns8SwOL+m?=
 =?iso-8859-1?Q?CkCLSFJjtf2IlIJb4q5OZnVfCKapfICW/A/svBusjIWV6CoxN8PcmC2QqU?=
 =?iso-8859-1?Q?oudswLf3G2lpAKsCYeuwceH4trorDbr7BdkXO+T5n6epvxDzOm0Cnfq774?=
 =?iso-8859-1?Q?Lfcg3YxqCmh/qfxPYfb5gCokQTn+7i3QEdQeIJnL1A7ytHI18ToTKsesey?=
 =?iso-8859-1?Q?QOhNtYL7miydx0u5stTCuY0b4O6KPPI4HYjD6BiwqFHIz/574QJtP9Xo/p?=
 =?iso-8859-1?Q?YlHBFryeem52GTbGaFTq8qihOdZruhzFSCVq6Dmh3kUD4c8SwZM3m9mhGn?=
 =?iso-8859-1?Q?QQQs/gD+dMGj4Cdv7g43h9T7cuGRNB+2j1yv/0UH6IzXOGYpzfXXVNMJJr?=
 =?iso-8859-1?Q?9nBJdAZk6e66U3NQxG+Pr7kexLPzODspUJcG49oalwBcVGLzVbiAJO5HM8?=
 =?iso-8859-1?Q?oWecjKmOQLpBgsXnubMehbPfHEchZCrvjxs0QkbAbin2mz87C/E8GOc54x?=
 =?iso-8859-1?Q?Xw7f3M4AZg+a7dt+JGdATIrDNt/5TFSL1Br9LWpVxT16rcOJw7wuGEjc4+?=
 =?iso-8859-1?Q?WoSnaEceveVLeShmndDcQpGRQ1TQIriYrskzEwX20Id+QrGJQSzGbKNuSc?=
 =?iso-8859-1?Q?KPyxEr8Z277dxTdJNCqr8iGsi6kmGPugo0TNKTFMNWMhh/936Jh3eppclb?=
 =?iso-8859-1?Q?+IGHZRUG6tUFee0y2BAw8CUI7WZ5vDPosAa31adauqB1D14LxEsjD0LzH8?=
 =?iso-8859-1?Q?KcUqkjmCzfCVu8fHUQ6qv31N4sXwYA5Rl96FIfa8Kff4tl7e5I2k4kshUu?=
 =?iso-8859-1?Q?ZVi7uK3vtC3q7LtqMiK6Aq4koauGeRrzubIuar5uq5R3Zmy8LfTXxJ1OuH?=
 =?iso-8859-1?Q?w7DwuqX/SsDbYDeiPw1HnZ1wStjKwJnkM7V1wCLv51YBtYI5lQob3BTOdb?=
 =?iso-8859-1?Q?Rqtss+ggL7oWEg4KsBwk6IA+9hKHT44Koff/6nYRk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?X3nCpGb+Yt5wTyCJ9Lh+sUKNlOu4hvN/7O+y7SK+dWEDs5YU4E/vGE5DnJ?=
 =?iso-8859-1?Q?11D+oCCgDnBB16fVUKNPDDeCQ/7dINv2zNz+KR6J9by+JZaeKHe4ILU3yU?=
 =?iso-8859-1?Q?xb7KFBiIPfkPakCTt2BWhT5NHzYahh/AI/YktLKCCfBxBbLz36W4TShB31?=
 =?iso-8859-1?Q?z08iWcSZUrEBkpQyLehJohJhaaRw0bSPaZDAb7LeIkL+rTP7jQEJIXHvYl?=
 =?iso-8859-1?Q?V084ZlLT1y/43eb7XSd3gh6LNMEQf5pphfoVSVe24jm9mgP0nmm/jtu/Sy?=
 =?iso-8859-1?Q?hqp9YbPl4TT5nu/Vt0icd2V61ysrYMzHnzyVjVVqZYxIqbHf73R/13ztRY?=
 =?iso-8859-1?Q?Gw3IhzBIHv4AYllxOYaKEMaIwA7gjr8ZPTxcx74jGnoQVLZCphR5V2NpOh?=
 =?iso-8859-1?Q?NuJHGJHF+l2o6UylMryCYvpoqqbHHCIRDSXtLLwUZN1E0VP0yt7Hg2ztuO?=
 =?iso-8859-1?Q?Wcbk+kIMEpzi7VAFPjPlNj64e9L4OWTlqnIzfBSLxJw7DRz5+/9FoWaT80?=
 =?iso-8859-1?Q?vEQjNGlWKZHRhjsD6XxhZyy7P9hBx2iWT4l+qvyLBtrnFxfeSHGecy7Ryy?=
 =?iso-8859-1?Q?stx/s1ezbxUucXQmqD7XVRIylHPLZEoiW88idSQC1+3/ToswL718xhGpL+?=
 =?iso-8859-1?Q?N3NFsmGKSRhDgBAHyPnanciE9bfQLE7weUBr6qJzQuwRTjtRSOmK+3JDqA?=
 =?iso-8859-1?Q?JP/U6BFkelIw9W860TReujsCeFDX4m2OlCyz6186u3SVJMKfviDpqvUPR5?=
 =?iso-8859-1?Q?y0rTZZ3nvmHK3KyP9J65Oo06yRBVDgFFGUkdKLZpbx0lzK6GaSm1vhW88I?=
 =?iso-8859-1?Q?SRbcxwUEKvOyheLjECMcjTD1coBiKtSYHhPy2AxKnd9mcip6gwfu2xURvd?=
 =?iso-8859-1?Q?xfFOPHf8L4oDv/sjPlfsV3Y1i0/3Lbsm4iJzf80LgdY8hqDRewfqqj2zbT?=
 =?iso-8859-1?Q?Q7W8DCyeNbeeqrNzv9fmrxW3d7A+Vy8sNMOrZNKxGmFEotAnBhi/8qmdyT?=
 =?iso-8859-1?Q?uoboAikUSo0GI7hoO0ZM4ccKkA37dc51tXoEaLXFTVFFEKGEj1AghrpER6?=
 =?iso-8859-1?Q?3GYqmoe63F9I4VIsb2GB/iPgWNOs2JCRakhQyhQDyeGB4hGaTsMRsVuXdc?=
 =?iso-8859-1?Q?3gxc1cBejQ8vRERtT84NgT09lH4PE3VKPjaCjYTJTgSDCWFcKa3xL0x9Vs?=
 =?iso-8859-1?Q?Eb1HVBHicpqPQ80/uIc5pzvBLKjP5rnXOXe/nWvM5ER0MXRsRFPDOoSNim?=
 =?iso-8859-1?Q?BpbmFAv+dRggm6V8XKBBcGA3jgGjzKK/CdPGRcA7kmg7X7TrHH5RB9wTX8?=
 =?iso-8859-1?Q?Ip4TUmSqGB6OdlO4eJlKV1soJ/uQ5KmmHDH5RFtV02vHA/7Fr1/CqBTeMM?=
 =?iso-8859-1?Q?oOd3/eSG/6GVW5dIceWCmAuouSR2lUl88Ti9tpy4Af2izYfRWlhxlrQBhy?=
 =?iso-8859-1?Q?KY6iDij7XkafYUgu7pD6aTpOZxJQ6pT54kZ98LWISCjdBlGjPCylJUncBw?=
 =?iso-8859-1?Q?P2Auch6Z+oj2FiSMwzeuEJTsDnKkPcDZytBj8/vf0kalM71LU6u/uJTujm?=
 =?iso-8859-1?Q?EHc4IAoLhUiDUdtWgj/nf+GiKfKWQ5EiikCLlXhY8fH19q0OcBecmIZwvp?=
 =?iso-8859-1?Q?Ld3lg9/ykDa93GJKKa0NvtN/9ll+yC5vENvcSm4vEAR5hwfZP6eJc/CQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c145a8-2505-43dd-ef0d-08dc793fcabc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 02:43:27.7301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ct98E2HM0KHhU1dyM7PE/OAq7BFVRtJjIT5xbVCdHFUsdctdj4qvAlROGapTd4d+wrfUdCnYR/tDD+qmLiBY4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7064
X-OriginatorOrg: intel.com

hi, Shakeel,

On Sun, May 19, 2024 at 08:49:33PM -0700, Shakeel Butt wrote:
> On Mon, May 20, 2024 at 10:43:35AM +0800, Oliver Sang wrote:
> > hi, Shakeel,
> > 
> > On Sun, May 19, 2024 at 10:20:28AM -0700, Shakeel Butt wrote:
> > > On Sun, May 19, 2024 at 05:14:39PM +0800, Oliver Sang wrote:
> > > > hi, Shakeel,
> > > > 
> > > > On Fri, May 17, 2024 at 11:28:10PM -0700, Shakeel Butt wrote:
> > > > > On Fri, May 17, 2024 at 01:56:30PM +0800, kernel test robot wrote:
> > > > > > 
> > > > > > 
> > > > > > Hello,
> > > > > > 
> > > > > > kernel test robot noticed a -11.9% regression of will-it-scale.per_process_ops on:
> > > > > > 
> > > > > > 
> > > > > > commit: 70a64b7919cbd6c12306051ff2825839a9d65605 ("memcg: dynamically allocate lruvec_stats")
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > > > 
> > > > > 
> > > > > Thanks for the report. Can you please run the same benchmark but with
> > > > > the full series (of 8 patches) or at least include the ff48c71c26aa
> > > > > ("memcg: reduce memory for the lruvec and memcg stats").
> > > > 
> > > > while this bisect, ff48c71c26aa has been checked. it has silimar data as
> > > > 70a64b7919 (a little worse actually)
> > > > 
> > > > 59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 ff48c71c26aaefb090c108d8803
> > > > ---------------- --------------------------- ---------------------------
> > > >          %stddev     %change         %stddev     %change         %stddev
> > > >              \          |                \          |                \
> > > >      91713           -11.9%      80789           -13.2%      79612        will-it-scale.per_process_ops
> > > > 
> > > > 
> > > > ok, we will run tests on tip of the series which should be below if I understand
> > > > it correctly.
> > > > 
> > > > * a94032b35e5f9 memcg: use proper type for mod_memcg_state
> > > > 
> > > > 
> > > 
> > > Thanks a lot Oliver. One question: what is the filesystem mounted at
> > > /tmp on your test machine? I just wanted to make sure I run the test
> > > with minimal changes from your setup.
> > 
> > we don't have specific partition for /tmp, just use tmpfs
> > 
> > tmp on /tmp type tmpfs (rw,relatime)
> > 
> > 
> > BTW, the test on a94032b35e5f9 finished, still have similar score to 70a64b7919
> > 
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
> >   gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/page_fault2/will-it-scale
> > 
> > 59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 ff48c71c26aaefb090c108d8803 a94032b35e5f97dc1023030d929
> > ---------------- --------------------------- --------------------------- ---------------------------
> >          %stddev     %change         %stddev     %change         %stddev     %change         %stddev
> >              \          |                \          |                \          |                \
> >      91713           -11.9%      80789           -13.2%      79612           -13.0%      79833        will-it-scale.per_process_ops
> > 
> 
> Thanks again. I am not sure if you have a single node machine but if you
> have, can you try to repro this issue on such machine. At the moment, I
> don't have access to such machine but I will try to repro myself as
> well.

we reported regression on a 2-node Skylake server. so I found a 1-node Skylake
desktop (we don't have 1 node server) to check.

model: Skylake
nr_node: 1
nr_cpu: 36
memory: 32G
brand: Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz

but cannot reproduce this regression:

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-d08/page_fault2/will-it-scale

59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 ff48c71c26aaefb090c108d8803 a94032b35e5f97dc1023030d929
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
    136040            -0.2%     135718            -0.2%     135829            -0.1%     135881        will-it-scale.per_process_ops


then I tried on 2-node servers with other models

for
model: Ice Lake
nr_node: 2
nr_cpu: 64
memory: 256G
brand: Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz

similar regression
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp9/page_fault2/will-it-scale

59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 ff48c71c26aaefb090c108d8803 a94032b35e5f97dc1023030d929
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
    240373           -14.4%     205702           -14.1%     206368           -12.9%     209394        will-it-scale.per_process_ops

full data is as below [1]


for
model: Sapphire Rapids
nr_node: 2
nr_cpu: 224
memory: 512G
brand: Intel(R) Xeon(R) Platinum 8480CTDX

the regression is smaller but still exists.

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/page_fault2/will-it-scale

59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 ff48c71c26aaefb090c108d8803 a94032b35e5f97dc1023030d929
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
     78072            -3.4%      75386            -6.0%      73363            -5.6%      73683        will-it-scale.per_process_ops


full data is as below [2]

hope these data are useful.



[1]
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp9/page_fault2/will-it-scale

59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 ff48c71c26aaefb090c108d8803 a94032b35e5f97dc1023030d929
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
      0.27 ±  3%      -0.0        0.24 ±  3%      -0.0        0.23 ±  3%      -0.0        0.24 ±  2%  mpstat.cpu.all.irq%
      3.83            -0.7        3.17 ±  2%      -0.6        3.23 ±  3%      -0.6        3.21        mpstat.cpu.all.usr%
     62547           -10.1%      56227           -10.8%      55807            -8.9%      56984        perf-c2c.DRAM.local
    194.40 ±  9%     -11.5%     172.00 ±  4%     -11.5%     172.00 ±  5%     -13.9%     167.40 ±  2%  perf-c2c.HITM.remote
  15383898           -14.4%   13164951           -14.1%   13207631           -12.9%   13401271        will-it-scale.64.processes
    240373           -14.4%     205702           -14.1%     206368           -12.9%     209394        will-it-scale.per_process_ops
  15383898           -14.4%   13164951           -14.1%   13207631           -12.9%   13401271        will-it-scale.workload
 2.359e+09           -12.9%  2.055e+09           -14.2%  2.023e+09           -12.8%  2.057e+09        numa-numastat.node0.local_node
 2.359e+09           -12.9%  2.055e+09           -14.2%  2.023e+09           -12.8%  2.057e+09        numa-numastat.node0.numa_hit
 2.346e+09           -16.1%  1.967e+09           -14.2%  2.013e+09           -13.2%  2.035e+09 ±  2%  numa-numastat.node1.local_node
 2.345e+09           -16.1%  1.967e+09           -14.2%  2.013e+09           -13.2%  2.036e+09 ±  2%  numa-numastat.node1.numa_hit
    567382 ±  8%      +2.1%     579061 ± 10%      -9.5%     513215 ±  5%      +1.2%     574201 ±  9%  numa-vmstat.node0.nr_anon_pages
  2.36e+09           -12.9%  2.055e+09           -14.3%  2.023e+09           -12.9%  2.056e+09        numa-vmstat.node0.numa_hit
  2.36e+09           -12.9%  2.055e+09           -14.3%  2.023e+09           -12.9%  2.056e+09        numa-vmstat.node0.numa_local
 2.346e+09           -16.2%  1.966e+09           -14.2%  2.012e+09           -13.3%  2.035e+09 ±  2%  numa-vmstat.node1.numa_hit
 2.347e+09           -16.2%  1.967e+09           -14.2%  2.013e+09           -13.3%  2.034e+09 ±  2%  numa-vmstat.node1.numa_local
   1137116            -1.9%    1115597            -1.5%    1119624            -1.8%    1116759        proc-vmstat.nr_anon_pages
      4575            +2.1%       4673            +2.1%       4671            +1.7%       4654        proc-vmstat.nr_page_table_pages
 4.705e+09           -14.5%  4.022e+09           -14.2%  4.036e+09           -13.0%  4.093e+09        proc-vmstat.numa_hit
 4.706e+09           -14.5%  4.023e+09           -14.2%  4.037e+09           -13.0%  4.092e+09        proc-vmstat.numa_local
 4.645e+09           -14.3%  3.979e+09           -14.1%  3.991e+09           -12.8%   4.05e+09        proc-vmstat.pgalloc_normal
 4.631e+09           -14.3%  3.967e+09           -14.1%  3.979e+09           -12.8%  4.038e+09        proc-vmstat.pgfault
 4.643e+09           -14.3%  3.978e+09           -14.1%   3.99e+09           -12.8%  4.049e+09        proc-vmstat.pgfree
     29780 ± 54%     -49.0%      15173 ± 50%     -87.2%       3818 ±199%     -33.2%      19878 ±112%  sched_debug.cfs_rq:/.left_deadline.avg
   1905931 ± 54%     -49.1%     971033 ± 50%     -87.2%     244356 ±199%     -33.2%    1272254 ±112%  sched_debug.cfs_rq:/.left_deadline.max
    236372 ± 54%     -49.1%     120428 ± 50%     -87.2%      30306 ±199%     -33.2%     157784 ±112%  sched_debug.cfs_rq:/.left_deadline.stddev
     29779 ± 54%     -49.0%      15172 ± 50%     -87.2%       3818 ±199%     -33.2%      19878 ±112%  sched_debug.cfs_rq:/.left_vruntime.avg
   1905916 ± 54%     -49.1%     971025 ± 50%     -87.2%     244349 ±199%     -33.2%    1272236 ±112%  sched_debug.cfs_rq:/.left_vruntime.max
    236371 ± 54%     -49.1%     120427 ± 50%     -87.2%      30304 ±199%     -33.2%     157782 ±112%  sched_debug.cfs_rq:/.left_vruntime.stddev
     12745 ±  8%      +2.4%      13045            -9.7%      11510 ± 11%      -6.0%      11984 ± 10%  sched_debug.cfs_rq:/.load.min
    253.83 ± 24%     +56.9%     398.30 ± 27%     +58.4%     402.13 ± 56%     +23.8%     314.20 ± 23%  sched_debug.cfs_rq:/.load_avg.max
     22.93 ±  4%     -12.2%      20.14 ± 17%     -12.0%      20.17 ± 17%     -18.5%      18.68 ± 15%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     22.93 ±  4%     -13.0%      19.94 ± 16%     -12.1%      20.16 ± 17%     -19.9%      18.35 ± 14%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     29779 ± 54%     -49.0%      15172 ± 50%     -87.2%       3818 ±199%     -33.2%      19878 ±112%  sched_debug.cfs_rq:/.right_vruntime.avg
   1905916 ± 54%     -49.1%     971025 ± 50%     -87.2%     244349 ±199%     -33.2%    1272236 ±112%  sched_debug.cfs_rq:/.right_vruntime.max
    236371 ± 54%     -49.1%     120427 ± 50%     -87.2%      30304 ±199%     -33.2%     157782 ±112%  sched_debug.cfs_rq:/.right_vruntime.stddev
    149.50 ± 33%     -81.3%      28.00 ±180%     -71.2%      43.03 ±120%     -70.9%      43.57 ±125%  sched_debug.cfs_rq:/.util_est.min
      1930 ±  4%     -15.5%       1631 ±  7%     -18.1%       1581 ±  5%     -10.5%       1729 ± 16%  sched_debug.cpu.nr_switches.min
      0.79 ± 98%     +89.1%       1.49 ± 48%    +147.8%       1.96 ± 16%     -12.4%       0.69 ± 91%  sched_debug.rt_rq:.rt_time.avg
     50.52 ± 98%     +89.2%      95.60 ± 48%    +147.8%     125.19 ± 17%     -12.3%      44.29 ± 91%  sched_debug.rt_rq:.rt_time.max
      6.27 ± 98%     +89.2%      11.86 ± 48%    +147.8%      15.53 ± 17%     -12.3%       5.49 ± 91%  sched_debug.rt_rq:.rt_time.stddev
     21.14           -10.1%      19.00           -10.1%      19.01 ±  2%      -9.9%      19.05        perf-stat.i.MPKI
 1.468e+10            -9.4%   1.33e+10            -9.0%  1.336e+10            -7.9%  1.351e+10        perf-stat.i.branch-instructions
  14349180            -7.8%   13236560            -6.6%   13407521            -6.2%   13464962        perf-stat.i.branch-misses
     69.58            -5.1       64.51            -4.8       64.81            -4.6       64.96        perf-stat.i.cache-miss-rate%
  1.57e+09           -19.5%  1.263e+09 ±  2%     -18.9%  1.273e+09 ±  3%     -17.8%  1.291e+09        perf-stat.i.cache-misses
 2.252e+09           -13.2%  1.955e+09           -12.9%  1.961e+09           -11.9%  1.985e+09        perf-stat.i.cache-references
      3.00           +12.8%       3.39           +12.0%       3.36           +10.6%       3.32        perf-stat.i.cpi
     99.00            -0.9%      98.11            -1.1%      97.90            -0.9%      98.13        perf-stat.i.cpu-migrations
    143.06           +25.2%     179.10 ±  2%     +24.5%     178.15 ±  3%     +22.4%     175.18        perf-stat.i.cycles-between-cache-misses
 7.403e+10           -10.4%  6.634e+10            -9.8%  6.679e+10            -8.7%   6.76e+10        perf-stat.i.instructions
      0.34           -11.4%       0.30           -10.7%       0.30            -9.7%       0.30        perf-stat.i.ipc
    478.41           -14.3%     410.14           -14.0%     411.31           -12.7%     417.50        perf-stat.i.metric.K/sec
  15310132           -14.3%   13125768           -14.0%   13162999           -12.7%   13361235        perf-stat.i.minor-faults
  15310132           -14.3%   13125768           -14.0%   13163000           -12.7%   13361235        perf-stat.i.page-faults
     21.21           -28.4%      15.17 ± 50%     -10.2%      19.05 ±  2%     -28.3%      15.20 ± 50%  perf-stat.overall.MPKI
      0.10            -0.0        0.08 ± 50%      +0.0        0.10            -0.0        0.08 ± 50%  perf-stat.overall.branch-miss-rate%
     69.71           -18.2       51.52 ± 50%      -4.8       64.89           -17.9       51.83 ± 50%  perf-stat.overall.cache-miss-rate%
      3.01            -9.7%       2.72 ± 50%     +11.9%       3.37           -11.4%       2.67 ± 50%  perf-stat.overall.cpi
    141.98            +1.0%     143.41 ± 50%     +24.6%     176.94 ±  3%      -1.2%     140.33 ± 50%  perf-stat.overall.cycles-between-cache-misses
      0.33           -29.1%       0.24 ± 50%     -10.6%       0.30           -27.7%       0.24 ± 50%  perf-stat.overall.ipc
   1453908           -16.2%    1217875 ± 50%      +4.9%    1524841           -16.2%    1218410 ± 50%  perf-stat.overall.path-length
 1.463e+10           -27.6%  1.059e+10 ± 50%      -9.0%  1.332e+10           -26.4%  1.077e+10 ± 50%  perf-stat.ps.branch-instructions
  14253731           -25.8%   10569701 ± 50%      -6.6%   13307817           -25.1%   10681742 ± 50%  perf-stat.ps.branch-misses
 1.565e+09           -36.0%  1.002e+09 ± 50%     -18.9%  1.269e+09 ±  3%     -34.6%  1.023e+09 ± 50%  perf-stat.ps.cache-misses
 2.245e+09           -30.7%  1.556e+09 ± 50%     -12.9%  1.954e+09           -29.6%  1.579e+09 ± 50%  perf-stat.ps.cache-references
     98.42           -20.7%      78.08 ± 50%      -1.0%      97.40           -20.6%      78.12 ± 50%  perf-stat.ps.cpu-migrations
 7.378e+10           -28.4%  5.281e+10 ± 50%      -9.8%  6.656e+10           -27.0%  5.385e+10 ± 50%  perf-stat.ps.instructions
  15260342           -31.6%   10437993 ± 50%     -14.0%   13119215           -30.3%   10633461 ± 50%  perf-stat.ps.minor-faults
  15260342           -31.6%   10437993 ± 50%     -14.0%   13119215           -30.3%   10633461 ± 50%  perf-stat.ps.page-faults
 2.237e+13           -28.5%  1.599e+13 ± 50%     -10.0%  2.014e+13           -27.2%  1.629e+13 ± 50%  perf-stat.total.instructions
     75.68            -6.2       69.50            -6.1       69.63            -5.4       70.26        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     72.31            -5.8       66.56            -5.6       66.68            -5.1       67.25        perf-profile.calltrace.cycles-pp.testcase
     63.50            -4.4       59.13            -4.4       59.13            -3.9       59.64        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     63.32            -4.4       58.97            -4.4       58.97            -3.8       59.48        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     61.04            -4.1       56.99            -4.1       56.98            -3.6       57.49        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     21.29            -3.9       17.43 ±  3%      -3.6       17.67 ±  3%      -3.5       17.77 ±  2%  perf-profile.calltrace.cycles-pp.copy_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     59.53            -3.8       55.69            -3.9       55.68            -3.3       56.21        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     58.35            -3.7       54.65            -3.7       54.65            -3.2       55.17        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      5.31            -0.9        4.40 ±  2%      -0.9        4.44 ±  2%      -0.8        4.50        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      4.97            -0.8        4.13 ±  2%      -0.8        4.15 ±  2%      -0.8        4.21        perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault
      4.40            -0.7        3.72 ±  3%      -0.6        3.79 ±  3%      -0.6        3.78 ±  2%  perf-profile.calltrace.cycles-pp.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      2.63            -0.4        2.23 ±  2%      -0.4        2.26 ±  2%      -0.3        2.29        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      1.82            -0.4        1.44 ±  2%      -0.4        1.47 ±  2%      -0.3        1.49        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      2.21            -0.3        1.89 ±  2%      -0.3        1.88 ±  2%      -0.3        1.90        perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      2.01            -0.3        1.69 ±  4%      -0.2        1.76 ±  5%      -0.3        1.73 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      1.80            -0.3        1.52 ±  2%      -0.3        1.52 ±  2%      -0.3        1.54        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault
      1.74            -0.2        1.50 ±  3%      -0.2        1.51 ±  3%      -0.2        1.52 ±  2%  perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.55            -0.2        1.31 ±  2%      -0.2        1.30 ±  2%      -0.2        1.33        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault
      1.60            -0.2        1.37 ±  3%      -0.2        1.39 ±  3%      -0.2        1.39 ±  2%  perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.29            -0.2        1.08 ±  3%      -0.2        1.14 ±  4%      -0.2        1.11 ±  3%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault
      1.42            -0.2        1.21 ±  3%      -0.2        1.23 ±  3%      -0.2        1.24 ±  2%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault.__handle_mm_fault
      1.50            -0.2        1.31 ±  2%      -0.1        1.41 ±  2%      -0.1        1.36 ±  3%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.set_pte_range.finish_fault.do_fault.__handle_mm_fault
      1.12            -0.2        0.93 ±  3%      -0.2        0.93 ±  2%      -0.2        0.95 ±  2%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc
      0.92            -0.1        0.78 ±  4%      -0.1        0.80 ±  3%      -0.1        0.81 ±  3%  perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
      0.74            -0.1        0.61 ±  2%      -0.1        0.65 ±  2%      -0.1        0.64        perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      0.98            -0.1        0.86 ±  2%      -0.1        0.87 ±  2%      -0.1        0.87 ±  2%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.72 ±  2%      -0.1        0.61 ±  2%      -0.1        0.61 ±  2%      -0.1        0.60 ±  3%  perf-profile.calltrace.cycles-pp.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.63 ±  2%      -0.1        0.53            -0.1        0.53 ±  2%      -0.2        0.41 ± 50%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.15            -0.1        1.05            -0.1        1.08            -0.1        1.07        perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      0.66            -0.1        0.56 ±  2%      -0.1        0.56 ±  2%      -0.1        0.56 ±  2%  perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.64            -0.1        0.55 ±  4%      -0.1        0.54 ±  3%      -0.1        0.56 ±  2%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof
      0.66            -0.1        0.58 ±  2%      -0.1        0.59 ±  3%      -0.1        0.58 ±  2%  perf-profile.calltrace.cycles-pp.mas_walk.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.71            +0.7        3.39            +0.7        3.36            +0.6        3.31 ±  2%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      2.71            +0.7        3.39            +0.7        3.36            +0.6        3.31 ±  2%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      2.71            +0.7        3.39            +0.7        3.37            +0.6        3.31 ±  2%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      2.65            +0.7        3.34            +0.7        3.32            +0.6        3.26 ±  2%  perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region
      2.44            +0.7        3.15            +0.7        3.13            +0.6        3.07 ±  2%  perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
     24.39            +2.2       26.56 ±  5%      +1.8       26.19 ±  4%      +2.1       26.54 ±  3%  perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
     22.46            +2.4       24.88 ±  5%      +2.0       24.41 ±  5%      +2.3       24.81 ±  4%  perf-profile.calltrace.cycles-pp.folio_add_lru_vma.set_pte_range.finish_fault.do_fault.__handle_mm_fault
     22.25            +2.5       24.70 ±  5%      +2.0       24.24 ±  5%      +2.4       24.63 ±  4%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault.do_fault
     20.38            +2.5       22.90 ±  6%      +2.0       22.42 ±  5%      +2.5       22.84 ±  4%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
     20.37            +2.5       22.89 ±  6%      +2.0       22.41 ±  5%      +2.5       22.83 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range
     20.30            +2.5       22.83 ±  6%      +2.0       22.35 ±  5%      +2.5       22.77 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma
     22.59            +5.3       27.93            +5.3       27.84            +4.7       27.29 ±  2%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     22.59            +5.3       27.93            +5.3       27.84            +4.7       27.29 ±  2%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     22.59            +5.3       27.93            +5.3       27.84            +4.7       27.29 ±  2%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
     22.58            +5.3       27.92            +5.3       27.83            +4.7       27.28 ±  2%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     20.59            +5.8       26.34            +5.6       26.22            +5.1       25.64 ±  2%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     20.59            +5.8       26.34            +5.6       26.22            +5.1       25.64 ±  2%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
     20.56            +5.8       26.32            +5.6       26.20            +5.1       25.62 ±  2%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     20.07            +5.9       25.95            +5.8       25.83            +5.2       25.23 ±  3%  perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
     18.73            +6.0       24.73            +5.9       24.63            +5.3       24.01 ±  3%  perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu
     25.34            +6.0       31.36            +5.9       31.24            +5.3       30.64 ±  2%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     25.34            +6.0       31.36            +5.9       31.24            +5.3       30.64 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     25.34            +6.0       31.36            +5.9       31.24            +5.3       30.64 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     25.34            +6.0       31.36            +5.9       31.24            +5.3       30.64 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     25.34            +6.0       31.36            +5.9       31.24            +5.3       30.64 ±  2%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.33            +6.0       31.36            +5.9       31.24            +5.3       30.64 ±  2%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     25.34            +6.0       31.37            +5.9       31.25            +5.3       30.65 ±  2%  perf-profile.calltrace.cycles-pp.__munmap
     25.33            +6.0       31.36            +5.9       31.24            +5.3       30.64 ±  2%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     20.35            +6.7       27.09            +6.6       26.96            +5.9       26.29 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
     20.36            +6.7       27.11            +6.6       26.98            +5.9       26.30 ±  3%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
     20.28            +6.8       27.04            +6.6       26.91            +6.0       26.24 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     74.49            -6.0       68.46            -5.9       68.59            -5.3       69.18        perf-profile.children.cycles-pp.testcase
     71.15            -5.5       65.63            -5.4       65.72            -4.8       66.30        perf-profile.children.cycles-pp.asm_exc_page_fault
     63.55            -4.4       59.16            -4.4       59.17            -3.9       59.68        perf-profile.children.cycles-pp.exc_page_fault
     63.38            -4.4       59.03            -4.4       59.03            -3.8       59.54        perf-profile.children.cycles-pp.do_user_addr_fault
     61.10            -4.1       57.04            -4.1       57.03            -3.6       57.54        perf-profile.children.cycles-pp.handle_mm_fault
     21.32            -3.9       17.45 ±  3%      -3.6       17.70 ±  3%      -3.5       17.80 ±  2%  perf-profile.children.cycles-pp.copy_page
     59.57            -3.9       55.72            -3.9       55.72            -3.3       56.24        perf-profile.children.cycles-pp.__handle_mm_fault
     58.44            -3.7       54.74            -3.7       54.74            -3.2       55.25        perf-profile.children.cycles-pp.do_fault
      5.36            -0.9        4.44 ±  2%      -0.9        4.48 ±  2%      -0.8        4.54        perf-profile.children.cycles-pp.__pte_offset_map_lock
      5.02            -0.9        4.16 ±  2%      -0.8        4.19 ±  2%      -0.8        4.25        perf-profile.children.cycles-pp._raw_spin_lock
      4.45            -0.7        3.76 ±  3%      -0.6        3.83 ±  3%      -0.6        3.82 ±  2%  perf-profile.children.cycles-pp.folio_prealloc
      2.64            -0.4        2.24 ±  2%      -0.4        2.27 ±  2%      -0.3        2.30        perf-profile.children.cycles-pp.sync_regs
      1.89            -0.4        1.49 ±  2%      -0.4        1.52 ±  2%      -0.3        1.55        perf-profile.children.cycles-pp.zap_present_ptes
      2.42            -0.4        2.04 ±  2%      -0.3        2.08 ±  3%      -0.3        2.09 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      2.24            -0.3        1.91 ±  2%      -0.3        1.91 ±  2%      -0.3        1.93        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      2.07            -0.3        1.74 ±  3%      -0.3        1.80 ±  5%      -0.3        1.77 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.89            -0.3        1.61 ±  2%      -0.3        1.60 ±  2%      -0.3        1.62        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      2.04            -0.3        1.77 ±  2%      -0.1        1.90 ±  2%      -0.2        1.83 ±  3%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.64            -0.3        1.39 ±  2%      -0.3        1.39 ±  2%      -0.2        1.41        perf-profile.children.cycles-pp.__alloc_pages_noprof
      1.77            -0.2        1.52 ±  3%      -0.2        1.53 ±  3%      -0.2        1.54 ±  2%  perf-profile.children.cycles-pp.__do_fault
      1.62            -0.2        1.39 ±  3%      -0.2        1.41 ±  3%      -0.2        1.41 ±  2%  perf-profile.children.cycles-pp.shmem_fault
      1.32            -0.2        1.10 ±  3%      -0.2        1.16 ±  4%      -0.2        1.13 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      1.42            -0.2        1.21 ±  2%      -0.2        1.20 ±  2%      -0.2        1.19 ±  2%  perf-profile.children.cycles-pp.__perf_sw_event
      1.47            -0.2        1.27 ±  3%      -0.2        1.28 ±  3%      -0.2        1.29 ±  2%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      1.13 ±  2%      -0.2        0.93 ±  4%      -0.1        1.06 ±  2%      -0.1        1.03 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.17            -0.2        0.98 ±  2%      -0.2        0.98 ±  2%      -0.2        1.00 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.25            -0.2        1.06 ±  2%      -0.2        1.06 ±  2%      -0.2        1.05 ±  2%  perf-profile.children.cycles-pp.___perf_sw_event
      0.84            -0.2        0.67 ±  3%      -0.2        0.68 ±  4%      -0.2        0.69 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.61            -0.2        0.44 ±  3%      -0.2        0.43 ±  3%      -0.2        0.46 ±  2%  perf-profile.children.cycles-pp._compound_head
      0.65            -0.1        0.51 ±  2%      -0.1        0.53 ±  4%      -0.1        0.53 ±  2%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.94            -0.1        0.80 ±  4%      -0.1        0.82 ±  4%      -0.1        0.82 ±  3%  perf-profile.children.cycles-pp.filemap_get_entry
      1.02            -0.1        0.89 ±  2%      -0.1        0.90 ±  3%      -0.1        0.90 ±  2%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.76            -0.1        0.63 ±  2%      -0.1        0.67 ±  2%      -0.1        0.66        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      1.20            -0.1        1.10            -0.1        1.13            -0.1        1.11        perf-profile.children.cycles-pp.lru_add_fn
      0.69            -0.1        0.59 ±  4%      -0.1        0.58 ±  2%      -0.1        0.60 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.47            -0.1        0.38 ±  2%      -0.1        0.37 ±  2%      -0.1        0.38        perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.59            -0.1        0.49 ±  2%      -0.1        0.49            -0.1        0.50        perf-profile.children.cycles-pp.free_unref_folios
      0.54            -0.1        0.45 ±  4%      -0.1        0.46 ±  3%      -0.1        0.47 ±  3%  perf-profile.children.cycles-pp.xas_load
      0.67            -0.1        0.58 ±  3%      -0.1        0.60 ±  3%      -0.1        0.59 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.63 ±  3%      -0.1        0.55 ±  3%      -0.0        0.61 ±  4%      -0.1        0.55 ±  3%  perf-profile.children.cycles-pp.__count_memcg_events
      0.27 ±  3%      -0.1        0.21 ±  3%      -0.1        0.21 ±  3%      -0.1        0.21        perf-profile.children.cycles-pp.uncharge_batch
      0.38            -0.1        0.32 ±  5%      -0.0        0.33            -0.0        0.33        perf-profile.children.cycles-pp.try_charge_memcg
      0.22 ±  3%      -0.1        0.17 ±  4%      -0.1        0.17 ±  4%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.32            -0.1        0.27            -0.0        0.28            -0.1        0.26        perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.26 ±  3%      -0.0        0.21 ±  4%      -0.0        0.22 ±  2%      -0.0        0.23 ±  5%  perf-profile.children.cycles-pp.__pte_offset_map
      0.30            -0.0        0.26 ±  2%      -0.0        0.26            -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.handle_pte_fault
      0.28            -0.0        0.24 ±  2%      -0.0        0.25 ±  3%      -0.0        0.25        perf-profile.children.cycles-pp.error_entry
      0.31            -0.0        0.27            -0.0        0.26 ±  5%      -0.0        0.26        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.31 ±  2%      -0.0        0.27 ±  6%      -0.0        0.27 ±  4%      -0.0        0.27 ±  3%  perf-profile.children.cycles-pp.get_vma_policy
      0.22            -0.0        0.19 ±  2%      -0.0        0.19 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.22 ±  2%      -0.0        0.19 ±  3%      -0.0        0.19            -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.26 ±  2%      -0.0        0.22 ±  9%      -0.0        0.22 ±  4%      -0.0        0.23 ±  5%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.28 ±  2%      -0.0        0.25 ±  3%      -0.0        0.25            -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.32 ±  2%      -0.0        0.29 ±  4%      -0.0        0.28 ±  2%      -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.26 ±  3%      -0.0        0.22 ±  4%      -0.0        0.22 ±  3%      -0.0        0.23        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.25 ±  3%      -0.0        0.21 ±  4%      -0.0        0.21 ±  2%      -0.0        0.22        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.22 ±  2%      -0.0        0.19 ±  3%      -0.0        0.19 ±  2%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.17 ±  2%      -0.0        0.14 ±  4%      -0.0        0.14 ±  5%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.folio_unlock
      0.14 ±  2%      -0.0        0.11            -0.0        0.11 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.__mod_zone_page_state
      0.19 ±  2%      -0.0        0.16 ±  2%      -0.0        0.17 ±  2%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.down_read_trylock
      0.18            -0.0        0.15 ±  3%      -0.0        0.15 ±  4%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.14 ±  2%      -0.0        0.11 ±  6%      -0.0        0.11 ±  8%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.14 ±  3%      -0.0        0.12 ±  3%      -0.0        0.12 ±  5%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.perf_exclude_event
      0.19 ±  2%      -0.0        0.17 ±  4%      -0.0        0.17 ±  2%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.16 ±  2%      -0.0        0.14            -0.0        0.13 ±  3%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.uncharge_folio
      0.12 ±  3%      -0.0        0.10 ±  5%      -0.0        0.09 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.18 ±  3%      -0.0        0.16 ±  4%      -0.0        0.16 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.13 ±  3%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.16            -0.0        0.14 ±  2%      -0.0        0.14 ±  4%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.folio_put
      0.18 ±  2%      -0.0        0.16 ±  3%      -0.0        0.16 ±  3%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.18 ±  2%      -0.0        0.16 ±  5%      -0.0        0.16 ±  4%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.up_read
      0.14            -0.0        0.12            -0.0        0.12            -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.policy_nodemask
      0.16 ±  2%      -0.0        0.14 ±  3%      -0.0        0.14 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.11 ±  3%      -0.0        0.09 ±  8%      -0.0        0.09 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.xas_start
      0.13 ±  3%      -0.0        0.11            -0.0        0.11 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.access_error
      0.09 ±  4%      -0.0        0.08 ±  5%      -0.0        0.08 ±  5%      -0.0        0.08        perf-profile.children.cycles-pp.__irqentry_text_end
      0.07 ±  5%      -0.0        0.05 ±  9%      -0.0        0.06 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.vm_normal_page
      0.06 ±  7%      -0.0        0.05 ±  7%      -0.0        0.05            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.__tlb_remove_folio_pages_size
      0.08            -0.0        0.07 ±  5%      -0.0        0.07 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.memcg_check_events
      0.12 ±  3%      -0.0        0.11 ±  6%      -0.0        0.11 ±  4%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.perf_swevent_event
      0.06            -0.0        0.05 ±  7%      -0.0        0.05            -0.0        0.05        perf-profile.children.cycles-pp.pte_alloc_one
      0.06            -0.0        0.05 ±  7%      -0.0        0.05            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.irqentry_enter
      0.06            -0.0        0.05 ±  7%      -0.0        0.05            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.vmf_anon_prepare
      0.05            +0.0        0.06 ±  8%      +0.0        0.06            +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.write
      0.05            +0.0        0.06            +0.0        0.06            +0.0        0.06        perf-profile.children.cycles-pp.perf_mmap__push
      0.19 ±  2%      +0.2        0.40 ±  6%      +0.2        0.37 ±  7%      +0.2        0.35 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      2.72            +0.7        3.40            +0.7        3.38            +0.6        3.32 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
     24.44            +2.2       26.60 ±  5%      +1.8       26.23 ±  4%      +2.1       26.58 ±  3%  perf-profile.children.cycles-pp.set_pte_range
     22.47            +2.4       24.89 ±  5%      +2.0       24.42 ±  5%      +2.3       24.81 ±  4%  perf-profile.children.cycles-pp.folio_add_lru_vma
     22.31            +2.5       24.77 ±  5%      +2.0       24.30 ±  5%      +2.4       24.70 ±  4%  perf-profile.children.cycles-pp.folio_batch_move_lru
     22.59            +5.3       27.93            +5.2       27.84            +4.7       27.29 ±  2%  perf-profile.children.cycles-pp.zap_pmd_range
     22.59            +5.3       27.93            +5.3       27.84            +4.7       27.29 ±  2%  perf-profile.children.cycles-pp.unmap_page_range
     22.59            +5.3       27.93            +5.3       27.84            +4.7       27.29 ±  2%  perf-profile.children.cycles-pp.zap_pte_range
     22.59            +5.3       27.93            +5.3       27.84            +4.7       27.29 ±  2%  perf-profile.children.cycles-pp.unmap_vmas
     20.59            +5.8       26.34            +5.6       26.22            +5.1       25.64 ±  2%  perf-profile.children.cycles-pp.tlb_flush_mmu
     25.34            +6.0       31.36            +5.9       31.24            +5.3       30.64 ±  2%  perf-profile.children.cycles-pp.__x64_sys_munmap
     25.34            +6.0       31.36            +5.9       31.24            +5.3       30.64 ±  2%  perf-profile.children.cycles-pp.__vm_munmap
     25.34            +6.0       31.37            +5.9       31.25            +5.3       30.65 ±  2%  perf-profile.children.cycles-pp.__munmap
     25.33            +6.0       31.36            +5.9       31.24            +5.3       30.64 ±  2%  perf-profile.children.cycles-pp.unmap_region
     25.34            +6.0       31.37            +5.9       31.25            +5.3       30.65 ±  2%  perf-profile.children.cycles-pp.do_vmi_align_munmap
     25.34            +6.0       31.37            +5.9       31.25            +5.3       30.65 ±  2%  perf-profile.children.cycles-pp.do_vmi_munmap
     25.46            +6.0       31.49            +5.9       31.37            +5.3       30.77 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     25.46            +6.0       31.49            +5.9       31.37            +5.3       30.77 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     23.30            +6.4       29.74            +6.3       29.59            +5.7       28.96 ±  2%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
     23.29            +6.4       29.73            +6.3       29.58            +5.7       28.95 ±  2%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
     23.00            +6.5       29.52            +6.4       29.38            +5.7       28.73 ±  2%  perf-profile.children.cycles-pp.folios_put_refs
     21.22            +6.7       27.93            +6.6       27.81            +5.9       27.13 ±  3%  perf-profile.children.cycles-pp.__page_cache_release
     40.79            +9.3       50.07 ±  2%      +8.7       49.46 ±  2%      +8.4       49.20        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     40.78            +9.3       50.06 ±  2%      +8.7       49.44 ±  2%      +8.4       49.19        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     40.64            +9.3       49.96 ±  2%      +8.7       49.34 ±  2%      +8.4       49.09        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     21.23            -3.9       17.38 ±  3%      -3.6       17.63 ±  3%      -3.5       17.73 ±  2%  perf-profile.self.cycles-pp.copy_page
      4.99            -0.8        4.14 ±  2%      -0.8        4.17 ±  2%      -0.8        4.22        perf-profile.self.cycles-pp._raw_spin_lock
      5.21            -0.8        4.45 ±  2%      -0.7        4.49 ±  2%      -0.7        4.53        perf-profile.self.cycles-pp.testcase
      2.63            -0.4        2.24 ±  2%      -0.4        2.26 ±  2%      -0.3        2.29        perf-profile.self.cycles-pp.sync_regs
      2.42            -0.4        2.04 ±  2%      -0.3        2.08 ±  3%      -0.3        2.09 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.58 ±  2%      -0.2        0.42 ±  3%      -0.2        0.40 ±  2%      -0.1        0.43 ±  3%  perf-profile.self.cycles-pp._compound_head
      0.93 ±  2%      -0.2        0.77 ±  5%      -0.0        0.89 ±  2%      -0.1        0.86 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      1.00            -0.1        0.85            -0.2        0.85 ±  2%      -0.2        0.83 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.93 ±  2%      -0.1        0.78 ±  3%      -0.1        0.79 ±  4%      -0.1        0.80 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.61            -0.1        0.48 ±  3%      -0.1        0.50 ±  4%      -0.1        0.50 ±  3%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.51            -0.1        0.38            -0.1        0.38 ±  2%      -0.1        0.40 ±  2%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.80            -0.1        0.70 ±  2%      -0.1        0.69 ±  3%      -0.1        0.70 ±  2%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.61 ±  2%      -0.1        0.51            -0.1        0.51 ±  2%      -0.1        0.51        perf-profile.self.cycles-pp.lru_add_fn
      0.47            -0.1        0.38            -0.1        0.38            -0.1        0.39 ±  2%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.45            -0.1        0.37 ±  2%      -0.1        0.37 ±  2%      -0.1        0.38        perf-profile.self.cycles-pp.zap_present_ptes
      0.44            -0.1        0.36 ±  4%      -0.1        0.37 ±  4%      -0.1        0.38 ±  3%  perf-profile.self.cycles-pp.xas_load
      0.65            -0.1        0.57 ±  2%      -0.1        0.58 ±  2%      -0.1        0.58 ±  2%  perf-profile.self.cycles-pp.mas_walk
      0.46            -0.1        0.39 ±  2%      -0.1        0.40 ±  2%      -0.1        0.41 ±  3%  perf-profile.self.cycles-pp.handle_mm_fault
      0.44            -0.1        0.38 ±  2%      -0.1        0.38 ±  2%      -0.1        0.39        perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.52 ±  3%      -0.1        0.46 ±  3%      -0.0        0.51 ±  6%      -0.1        0.46 ±  5%  perf-profile.self.cycles-pp.__count_memcg_events
      0.89 ±  2%      -0.1        0.84            -0.0        0.88 ±  3%      -0.1        0.83 ±  3%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.32            -0.1        0.26            -0.1        0.26            -0.0        0.27        perf-profile.self.cycles-pp.__page_cache_release
      0.39            -0.1        0.34 ±  4%      -0.0        0.35 ±  4%      -0.0        0.35 ±  3%  perf-profile.self.cycles-pp.filemap_get_entry
      0.20 ±  4%      -0.1        0.15 ±  5%      -0.1        0.15 ±  3%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.24            -0.0        0.19            -0.0        0.20 ±  2%      -0.0        0.20        perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.34 ±  3%      -0.0        0.29 ±  2%      -0.0        0.29 ±  2%      -0.0        0.29 ±  3%  perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.27            -0.0        0.23 ±  3%      -0.0        0.23 ±  3%      -0.0        0.23 ±  2%  perf-profile.self.cycles-pp.free_unref_folios
      0.27 ±  3%      -0.0        0.23 ±  2%      -0.0        0.23 ±  2%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.rmqueue
      0.30            -0.0        0.26            -0.0        0.26            -0.0        0.26        perf-profile.self.cycles-pp.do_user_addr_fault
      0.26            -0.0        0.22 ±  2%      -0.0        0.22 ±  2%      -0.0        0.22 ±  4%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.23 ±  3%      -0.0        0.19 ±  4%      -0.0        0.20 ±  5%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.22 ±  3%      -0.0        0.19 ±  2%      -0.0        0.19 ±  3%      -0.0        0.20 ±  4%  perf-profile.self.cycles-pp.__pte_offset_map
      0.29            -0.0        0.26            -0.0        0.25 ±  5%      -0.0        0.25        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.19 ±  2%      -0.0        0.16 ±  2%      -0.0        0.16 ±  4%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.21 ±  3%      -0.0        0.17 ±  2%      -0.0        0.18 ±  2%      -0.0        0.19 ±  4%  perf-profile.self.cycles-pp.finish_fault
      0.25            -0.0        0.21            -0.0        0.21 ±  3%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.error_entry
      0.24            -0.0        0.21 ±  3%      -0.0        0.22            -0.0        0.22        perf-profile.self.cycles-pp.try_charge_memcg
      0.21 ±  2%      -0.0        0.18 ±  4%      -0.0        0.18 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.folio_add_new_anon_rmap
      0.22            -0.0        0.19 ±  2%      -0.0        0.19 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.set_pte_range
      0.24 ±  3%      -0.0        0.21 ±  7%      -0.0        0.20 ±  4%      -0.0        0.21 ±  6%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.06            -0.0        0.03 ± 81%      -0.0        0.04 ± 50%      -0.0        0.05        perf-profile.self.cycles-pp.vm_normal_page
      0.23 ±  2%      -0.0        0.20 ±  2%      -0.0        0.20 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.do_fault
      0.18            -0.0        0.15 ±  2%      -0.0        0.15 ±  2%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.15 ±  2%      -0.0        0.12            -0.0        0.12 ±  6%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.13 ±  3%      -0.0        0.10 ±  4%      -0.0        0.11 ±  4%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.18            -0.0        0.15 ±  2%      -0.0        0.16 ±  3%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.down_read_trylock
      0.11 ±  3%      -0.0        0.08 ±  4%      -0.0        0.09            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.19 ±  2%      -0.0        0.17 ±  2%      -0.0        0.16 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.folio_add_lru_vma
      0.19 ±  2%      -0.0        0.17 ±  8%      -0.0        0.17 ±  3%      -0.0        0.17 ±  3%  perf-profile.self.cycles-pp.get_vma_policy
      0.16 ±  2%      -0.0        0.13 ±  3%      -0.0        0.13 ±  5%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.folio_unlock
      0.12 ±  3%      -0.0        0.10 ±  6%      -0.0        0.10 ±  6%      -0.0        0.10        perf-profile.self.cycles-pp.perf_exclude_event
      0.19 ±  2%      -0.0        0.17            -0.0        0.17 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.15 ±  2%      -0.0        0.13 ±  3%      -0.0        0.13 ±  3%      -0.0        0.13        perf-profile.self.cycles-pp.folio_put
      0.14 ±  2%      -0.0        0.12            -0.0        0.12 ±  3%      -0.0        0.12        perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.17 ±  2%      -0.0        0.14 ±  5%      -0.0        0.14 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.__perf_sw_event
      0.10 ±  3%      -0.0        0.08 ±  7%      -0.0        0.08 ± 11%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      0.15 ±  2%      -0.0        0.13            -0.0        0.13 ±  3%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.uncharge_folio
      0.12 ±  3%      -0.0        0.10            -0.0        0.10 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.alloc_pages_mpol_noprof
      0.11 ±  3%      -0.0        0.09 ±  8%      -0.0        0.09 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.page_counter_try_charge
      0.17 ±  4%      -0.0        0.15 ±  4%      -0.0        0.15 ±  2%      -0.0        0.15        perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.17 ±  2%      -0.0        0.15 ±  3%      -0.0        0.16 ±  3%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.up_read
      0.11            -0.0        0.09 ±  4%      -0.0        0.09 ±  5%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.zap_pte_range
      0.10            -0.0        0.08 ±  4%      -0.0        0.08 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.16 ±  2%      -0.0        0.15 ±  5%      -0.0        0.15 ±  3%      -0.0        0.15 ±  5%  perf-profile.self.cycles-pp.shmem_fault
      0.10 ±  4%      -0.0        0.08 ±  4%      -0.0        0.08 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__do_fault
      0.12 ±  3%      -0.0        0.10 ±  7%      -0.0        0.10 ±  7%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.exc_page_fault
      0.12 ±  3%      -0.0        0.10 ±  3%      -0.0        0.10 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.access_error
      0.12 ±  4%      -0.0        0.10            -0.0        0.10            -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.vma_alloc_folio_noprof
      0.11            -0.0        0.10 ±  5%      -0.0        0.09 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.perf_swevent_event
      0.09 ±  5%      -0.0        0.08            -0.0        0.08            -0.0        0.08        perf-profile.self.cycles-pp.policy_nodemask
      0.09            -0.0        0.08 ± 13%      -0.0        0.08 ±  5%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.xas_start
      0.10 ±  4%      -0.0        0.09 ±  4%      -0.0        0.09            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.pte_offset_map_nolock
      0.08 ±  4%      -0.0        0.07            -0.0        0.07 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.10            -0.0        0.09            -0.0        0.09 ±  5%      -0.0        0.09        perf-profile.self.cycles-pp.folio_prealloc
      0.09            -0.0        0.08            -0.0        0.08            -0.0        0.08        perf-profile.self.cycles-pp.__cond_resched
      0.38 ±  2%      +0.1        0.47 ±  2%      +0.1        0.46            +0.1        0.44        perf-profile.self.cycles-pp.folio_batch_move_lru
      0.18 ±  2%      +0.2        0.38 ±  6%      +0.2        0.35 ±  7%      +0.2        0.34 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
     40.64            +9.3       49.96 ±  2%      +8.7       49.34 ±  2%      +8.4       49.08        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


[2]
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/page_fault2/will-it-scale

59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 ff48c71c26aaefb090c108d8803 a94032b35e5f97dc1023030d929
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
  17488267            -3.4%   16886777            -6.0%   16433590            -5.6%   16505101        will-it-scale.224.processes
     78072            -3.4%      75386            -6.0%      73363            -5.6%      73683        will-it-scale.per_process_ops
  17488267            -3.4%   16886777            -6.0%   16433590            -5.6%   16505101        will-it-scale.workload
 5.296e+09            -3.4%  5.116e+09            -6.0%  4.977e+09            -5.6%  4.998e+09        proc-vmstat.numa_hit
 5.291e+09            -3.4%  5.111e+09            -6.0%  4.973e+09            -5.6%  4.995e+09        proc-vmstat.numa_local
 5.285e+09            -3.4%  5.105e+09            -6.0%  4.968e+09            -5.6%  4.989e+09        proc-vmstat.pgalloc_normal
 5.264e+09            -3.4%  5.084e+09            -6.0%  4.947e+09            -5.6%  4.969e+09        proc-vmstat.pgfault
 5.283e+09            -3.4%  5.104e+09            -6.0%  4.967e+09            -5.6%  4.989e+09        proc-vmstat.pgfree
      3067           +20.1%       3685 ±  8%     +19.5%       3665 ±  8%      -0.4%       3056        sched_debug.cfs_rq:/.load.min
      0.07 ± 19%     -12.8%       0.06 ± 14%     -31.1%       0.05 ± 14%      -8.8%       0.06 ± 14%  sched_debug.cfs_rq:/.nr_running.stddev
   1727628 ± 22%      +2.3%    1767491 ± 32%      +8.6%    1876362 ± 25%     -24.1%    1310525 ±  7%  sched_debug.cpu.avg_idle.max
      6058 ± 41%     +71.5%      10389 ±118%     +96.1%      11878 ± 66%     -47.9%       3156 ± 43%  sched_debug.cpu.max_idle_balance_cost.stddev
     17928 ± 11%    +133.0%      41768 ± 36%     +39.4%      24992 ± 57%      +6.3%      19052 ± 15%  sched_debug.cpu.nr_switches.max
      2270 ±  6%     +70.6%       3874 ± 28%     +21.4%       2756 ± 37%      +0.5%       2282 ±  4%  sched_debug.cpu.nr_switches.stddev
   4369255            -9.9%    3934784 ±  8%      -3.0%    4238563 ±  6%      -3.0%    4239325 ±  7%  numa-vmstat.node0.nr_file_pages
     20526 ±  3%     -25.8%      15236 ± 22%     -11.5%      18161 ± 16%      -6.4%      19205 ± 16%  numa-vmstat.node0.nr_mapped
     35617 ±  5%     -27.8%      25727 ± 20%     -12.1%      31303 ± 13%      -9.1%      32375 ± 21%  numa-vmstat.node0.nr_slab_reclaimable
     65089 ± 16%      -8.1%      59820 ± 19%     -19.8%      52215 ±  3%     -18.3%      53200 ±  3%  numa-vmstat.node0.nr_slab_unreclaimable
    738801 ±  3%     -59.2%     301176 ±113%     -17.7%     608173 ± 48%     -18.0%     605778 ± 49%  numa-vmstat.node0.nr_unevictable
    738801 ±  3%     -59.2%     301176 ±113%     -17.7%     608173 ± 48%     -18.0%     605778 ± 49%  numa-vmstat.node0.nr_zone_unevictable
   4024866           +10.9%    4465333 ±  7%      +3.2%    4152344 ±  7%      +3.4%    4163009 ±  7%  numa-vmstat.node1.nr_file_pages
     19132 ± 10%     +51.8%      29044 ± 18%     +22.2%      23371 ± 18%     +17.3%      22446 ± 30%  numa-vmstat.node1.nr_slab_reclaimable
     45845 ± 24%     +12.0%      51337 ± 23%     +28.7%      58982 ±  2%     +26.8%      58122 ±  3%  numa-vmstat.node1.nr_slab_unreclaimable
     30816 ± 81%   +1420.1%     468441 ± 72%    +423.9%     161444 ±184%    +431.7%     163839 ±184%  numa-vmstat.node1.nr_unevictable
     30816 ± 81%   +1420.1%     468441 ± 72%    +423.9%     161444 ±184%    +431.7%     163839 ±184%  numa-vmstat.node1.nr_zone_unevictable
    142458 ±  5%     -27.7%     102968 ± 20%     -12.1%     125181 ± 13%      -9.1%     129506 ± 21%  numa-meminfo.node0.KReclaimable
     81201 ±  3%     -25.4%      60607 ± 21%     -11.8%      71622 ± 16%      -6.6%      75868 ± 16%  numa-meminfo.node0.Mapped
    142458 ±  5%     -27.7%     102968 ± 20%     -12.1%     125181 ± 13%      -9.1%     129506 ± 21%  numa-meminfo.node0.SReclaimable
    260359 ± 16%      -8.1%     239286 ± 19%     -19.8%     208866 ±  3%     -18.3%     212806 ±  3%  numa-meminfo.node0.SUnreclaim
    402817 ± 12%     -15.0%     342254 ± 18%     -17.1%     334047 ±  6%     -15.0%     342313 ±  9%  numa-meminfo.node0.Slab
   2955204 ±  3%     -59.2%    1204704 ±113%     -17.7%    2432692 ± 48%     -18.0%    2423114 ± 49%  numa-meminfo.node0.Unevictable
  16107004           +11.0%   17872044 ±  7%      +3.0%   16587232 ±  7%      +3.3%   16635393 ±  7%  numa-meminfo.node1.FilePages
     76509 ± 10%     +51.9%     116237 ± 18%     +22.1%      93450 ± 18%     +17.4%      89791 ± 30%  numa-meminfo.node1.KReclaimable
     76509 ± 10%     +51.9%     116237 ± 18%     +22.1%      93450 ± 18%     +17.4%      89791 ± 30%  numa-meminfo.node1.SReclaimable
    183385 ± 24%     +12.0%     205353 ± 23%     +28.7%     235933 ±  2%     +26.8%     232488 ±  3%  numa-meminfo.node1.SUnreclaim
    259894 ± 20%     +23.7%     321590 ± 19%     +26.7%     329384 ±  6%     +24.0%     322280 ± 10%  numa-meminfo.node1.Slab
    123266 ± 81%   +1420.1%    1873767 ± 72%    +423.9%     645778 ±184%    +431.7%     655357 ±184%  numa-meminfo.node1.Unevictable
     20.16            -1.4%      19.89            -2.9%      19.57            -2.9%      19.58        perf-stat.i.MPKI
 2.501e+10            -1.7%   2.46e+10            -2.6%  2.436e+10            -2.4%   2.44e+10        perf-stat.i.branch-instructions
  18042153            -0.3%   17981852            -1.9%   17692517            -2.8%   17539874        perf-stat.i.branch-misses
 2.382e+09            -3.3%  2.304e+09            -5.8%  2.244e+09            -5.6%  2.249e+09        perf-stat.i.cache-misses
 2.561e+09            -3.2%  2.479e+09            -5.5%   2.42e+09            -5.3%  2.424e+09        perf-stat.i.cache-references
      5.49            +1.9%       5.59            +3.1%       5.66            +2.8%       5.64        perf-stat.i.cpi
    274.25            +2.9%     282.07            +5.7%     289.98            +5.4%     289.07        perf-stat.i.cycles-between-cache-misses
 1.177e+11            -1.9%  1.155e+11            -2.9%  1.143e+11            -2.7%  1.145e+11        perf-stat.i.instructions
      0.19            -1.9%       0.18            -3.0%       0.18            -2.7%       0.18        perf-stat.i.ipc
    155.11            -3.3%     150.03            -5.9%     145.89            -5.5%     146.59        perf-stat.i.metric.K/sec
  17405977            -3.4%   16819060            -5.9%   16378605            -5.5%   16441964        perf-stat.i.minor-faults
  17405978            -3.4%   16819060            -5.9%   16378606            -5.5%   16441964        perf-stat.i.page-faults
      4.41 ± 50%     +27.3%       5.61            +3.1%       4.54 ± 50%     +28.5%       5.66        perf-stat.overall.cpi
    217.50 ± 50%     +29.2%     280.93            +6.3%     231.09 ± 50%     +32.4%     287.87        perf-stat.overall.cycles-between-cache-misses
   1623235 ± 50%     +26.9%    2060668            +3.4%    1677714 ± 50%     +29.0%    2093187        perf-stat.overall.path-length
      5.48            -0.3        5.15            -0.4        5.10            -0.4        5.11        perf-profile.calltrace.cycles-pp.copy_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     57.55            -0.3       57.24            -0.4       57.15            -0.3       57.20        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     56.14            -0.2       55.94            -0.3       55.86            -0.2       55.90        perf-profile.calltrace.cycles-pp.testcase
      1.86            -0.1        1.73 ±  2%      -0.1        1.72            -0.2        1.71        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.77            -0.1        1.64 ±  2%      -0.1        1.63            -0.1        1.63        perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault
      1.17            -0.1        1.10            -0.1        1.09            -0.1        1.10        perf-profile.calltrace.cycles-pp.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     52.55            -0.1       52.49            -0.1       52.42            -0.1       52.47        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     52.62            -0.1       52.56            -0.1       52.48            -0.1       52.54        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
      0.96            -0.0        0.91            -0.0        0.91            -0.0        0.91        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      0.71            -0.0        0.68            -0.0        0.67            -0.0        0.67        perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
     51.87            -0.0       51.84            -0.1       51.76            -0.0       51.82        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.60            -0.0        0.57            -0.0        0.56            -0.0        0.57        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault
      4.87            +0.0        4.90            +0.0        4.91            +0.0        4.91        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      4.85            +0.0        4.88            +0.0        4.90            +0.0        4.90        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region
      4.86            +0.0        4.90            +0.0        4.91            +0.0        4.91        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      4.86            +0.0        4.89            +0.1        4.91            +0.0        4.91        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      4.77            +0.0        4.80            +0.1        4.83            +0.1        4.82        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
     37.74            +0.2       37.98            +0.3       38.04            +0.3       38.01        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     37.74            +0.2       37.98            +0.3       38.04            +0.3       38.01        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     37.74            +0.2       37.98            +0.3       38.04            +0.3       38.01        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
     37.73            +0.2       37.97            +0.3       38.04            +0.3       38.01        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     37.27            +0.3       37.53            +0.3       37.60            +0.3       37.57        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     37.28            +0.3       37.54            +0.3       37.61            +0.3       37.58        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     37.28            +0.3       37.54            +0.3       37.61            +0.3       37.58        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
     36.72            +0.3       36.98            +0.4       37.08            +0.3       37.04        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu
     37.15            +0.3       37.41            +0.3       37.49            +0.3       37.46        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
     42.65            +0.3       42.92            +0.4       43.00            +0.3       42.97        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     42.65            +0.3       42.92            +0.4       43.00            +0.3       42.97        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     42.65            +0.3       42.92            +0.4       43.00            +0.3       42.97        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     42.65            +0.3       42.92            +0.4       43.00            +0.3       42.97        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     42.65            +0.3       42.92            +0.4       43.00            +0.3       42.97        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     42.65            +0.3       42.92            +0.4       43.00            +0.3       42.97        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     42.65            +0.3       42.92            +0.4       43.00            +0.3       42.97        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     42.65            +0.3       42.92            +0.4       43.00            +0.3       42.97        perf-profile.calltrace.cycles-pp.__munmap
     41.26            +0.3       41.56            +0.4       41.68            +0.4       41.64        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
     41.26            +0.3       41.56            +0.4       41.68            +0.4       41.63        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
     41.23            +0.3       41.53            +0.4       41.66            +0.4       41.61        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     43.64            +0.5       44.09            +0.4       44.05            +0.5       44.12        perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     41.57            +0.6       42.17            +0.6       42.14            +0.6       42.22        perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
     40.93            +0.6       41.56            +0.6       41.53            +0.7       41.59        perf-profile.calltrace.cycles-pp.folio_add_lru_vma.set_pte_range.finish_fault.do_fault.__handle_mm_fault
     40.84            +0.6       41.48            +0.6       41.44            +0.7       41.50        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault.do_fault
     40.16            +0.7       40.83            +0.6       40.80            +0.7       40.87        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma
     40.19            +0.7       40.85            +0.6       40.83            +0.7       40.89        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range
     40.19            +0.7       40.85            +0.6       40.83            +0.7       40.89        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      5.49            -0.3        5.16            -0.4        5.12            -0.4        5.12        perf-profile.children.cycles-pp.copy_page
     57.05            -0.3       56.79            -0.4       56.70            -0.3       56.75        perf-profile.children.cycles-pp.testcase
     55.66            -0.2       55.44            -0.3       55.36            -0.2       55.41        perf-profile.children.cycles-pp.asm_exc_page_fault
      1.88            -0.1        1.75 ±  2%      -0.1        1.74            -0.2        1.73        perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.79            -0.1        1.66 ±  2%      -0.1        1.64            -0.1        1.64        perf-profile.children.cycles-pp._raw_spin_lock
      1.19            -0.1        1.11            -0.1        1.11            -0.1        1.11        perf-profile.children.cycles-pp.folio_prealloc
     52.64            -0.1       52.57            -0.1       52.49            -0.1       52.55        perf-profile.children.cycles-pp.exc_page_fault
      0.96            -0.1        0.91            -0.1        0.91            -0.1        0.91        perf-profile.children.cycles-pp.sync_regs
     52.57            -0.0       52.52            -0.1       52.44            -0.1       52.50        perf-profile.children.cycles-pp.do_user_addr_fault
      0.73            -0.0        0.69            -0.0        0.68            -0.0        0.68        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.63            -0.0        0.60            -0.0        0.59            -0.0        0.59        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.55            -0.0        0.52            -0.0        0.51            -0.0        0.51        perf-profile.children.cycles-pp.__alloc_pages_noprof
     51.89            -0.0       51.86            -0.1       51.78            -0.0       51.84        perf-profile.children.cycles-pp.handle_mm_fault
      1.02            -0.0        0.99            -0.0        0.99            -0.0        0.98        perf-profile.children.cycles-pp.native_irq_return_iret
      0.46            -0.0        0.43 ±  2%      -0.0        0.44            -0.0        0.43        perf-profile.children.cycles-pp.shmem_fault
      0.39            -0.0        0.36 ±  2%      -0.0        0.36            -0.0        0.38        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.51            -0.0        0.48 ±  2%      -0.0        0.49            -0.0        0.48        perf-profile.children.cycles-pp.__do_fault
      0.38            -0.0        0.36            -0.0        0.35            -0.0        0.36        perf-profile.children.cycles-pp.lru_add_fn
      0.51            -0.0        0.49            -0.0        0.50            -0.0        0.48        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.36            -0.0        0.34            -0.0        0.34            -0.0        0.34        perf-profile.children.cycles-pp.___perf_sw_event
      0.42            -0.0        0.40 ±  2%      -0.0        0.40            -0.0        0.39        perf-profile.children.cycles-pp.__perf_sw_event
      0.41            -0.0        0.39            -0.0        0.39            -0.0        0.39        perf-profile.children.cycles-pp.get_page_from_freelist
      0.25 ±  2%      -0.0        0.23            -0.0        0.24 ±  2%      -0.0        0.23        perf-profile.children.cycles-pp.filemap_get_entry
      0.42            -0.0        0.41            -0.0        0.40            -0.0        0.40        perf-profile.children.cycles-pp.zap_present_ptes
      0.14 ±  2%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%      -0.0        0.13        perf-profile.children.cycles-pp.xas_load
      0.21 ±  2%      -0.0        0.20            -0.0        0.19 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.26            -0.0        0.25            -0.0        0.24            -0.0        0.24        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.27            -0.0        0.26 ±  2%      -0.0        0.26            -0.0        0.26        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.11            -0.0        0.10            -0.0        0.09 ±  5%      -0.0        0.10        perf-profile.children.cycles-pp._compound_head
      0.23 ±  2%      -0.0        0.22 ±  2%      -0.0        0.22            -0.0        0.21        perf-profile.children.cycles-pp.rmqueue
      0.09            -0.0        0.08            -0.0        0.08            -0.0        0.08        perf-profile.children.cycles-pp.scheduler_tick
      0.12            -0.0        0.11            -0.0        0.11            -0.0        0.11        perf-profile.children.cycles-pp.tick_nohz_handler
      0.21            -0.0        0.20            -0.0        0.20            -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.16            -0.0        0.15 ±  2%      -0.0        0.15            -0.0        0.15        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.11            -0.0        0.10 ±  3%      -0.0        0.10            -0.0        0.10        perf-profile.children.cycles-pp.update_process_times
      0.14 ±  3%      -0.0        0.14 ±  3%      -0.0        0.13            -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.try_charge_memcg
      0.15            -0.0        0.14 ±  2%      -0.0        0.14 ±  2%      -0.0        0.14        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.06            -0.0        0.06 ±  8%      -0.0        0.05 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.task_tick_fair
      0.16 ±  2%      -0.0        0.16            -0.0        0.15            -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.07            +0.0        0.08 ±  6%      +0.0        0.08            +0.0        0.08        perf-profile.children.cycles-pp.folio_add_lru
      4.88            +0.0        4.91            +0.0        4.93            +0.0        4.93        perf-profile.children.cycles-pp.tlb_finish_mmu
     37.74            +0.2       37.98            +0.3       38.04            +0.3       38.01        perf-profile.children.cycles-pp.unmap_page_range
     37.74            +0.2       37.98            +0.3       38.04            +0.3       38.01        perf-profile.children.cycles-pp.unmap_vmas
     37.74            +0.2       37.98            +0.3       38.04            +0.3       38.01        perf-profile.children.cycles-pp.zap_pmd_range
     37.74            +0.2       37.98            +0.3       38.04            +0.3       38.01        perf-profile.children.cycles-pp.zap_pte_range
     37.28            +0.3       37.54            +0.3       37.61            +0.3       37.58        perf-profile.children.cycles-pp.tlb_flush_mmu
     42.65            +0.3       42.92            +0.3       43.00            +0.3       42.97        perf-profile.children.cycles-pp.__vm_munmap
     42.65            +0.3       42.92            +0.3       43.00            +0.3       42.97        perf-profile.children.cycles-pp.__x64_sys_munmap
     42.65            +0.3       42.92            +0.4       43.00            +0.3       42.97        perf-profile.children.cycles-pp.__munmap
     42.65            +0.3       42.92            +0.4       43.00            +0.3       42.97        perf-profile.children.cycles-pp.unmap_region
     42.65            +0.3       42.93            +0.4       43.01            +0.3       42.98        perf-profile.children.cycles-pp.do_vmi_align_munmap
     42.65            +0.3       42.93            +0.4       43.01            +0.3       42.98        perf-profile.children.cycles-pp.do_vmi_munmap
     42.86            +0.3       43.14            +0.4       43.22            +0.3       43.18        perf-profile.children.cycles-pp.do_syscall_64
     42.86            +0.3       43.14            +0.4       43.22            +0.3       43.19        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     42.15            +0.3       42.44            +0.4       42.54            +0.3       42.50        perf-profile.children.cycles-pp.free_pages_and_swap_cache
     42.12            +0.3       42.41            +0.4       42.50            +0.3       42.46        perf-profile.children.cycles-pp.folios_put_refs
     42.15            +0.3       42.45            +0.4       42.54            +0.3       42.50        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
     41.51            +0.3       41.80            +0.4       41.93            +0.4       41.89        perf-profile.children.cycles-pp.__page_cache_release
     43.66            +0.5       44.12            +0.4       44.08            +0.5       44.15        perf-profile.children.cycles-pp.finish_fault
     41.59            +0.6       42.19            +0.6       42.16            +0.6       42.24        perf-profile.children.cycles-pp.set_pte_range
     40.94            +0.6       41.57            +0.6       41.53            +0.7       41.59        perf-profile.children.cycles-pp.folio_add_lru_vma
     40.99            +0.6       41.63            +0.6       41.60            +0.7       41.66        perf-profile.children.cycles-pp.folio_batch_move_lru
     81.57            +1.0       82.53            +1.1       82.62            +1.1       82.65        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     81.60            +1.0       82.56            +1.1       82.66            +1.1       82.68        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     81.59            +1.0       82.56            +1.1       82.66            +1.1       82.68        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      5.47            -0.3        5.14            -0.4        5.10            -0.4        5.10        perf-profile.self.cycles-pp.copy_page
      1.77            -0.1        1.65 ±  2%      -0.1        1.63            -0.1        1.63        perf-profile.self.cycles-pp._raw_spin_lock
      2.19            -0.1        2.08            -0.1        2.08            -0.1        2.07        perf-profile.self.cycles-pp.testcase
      0.96            -0.0        0.91            -0.0        0.91            -0.0        0.91        perf-profile.self.cycles-pp.sync_regs
      1.02            -0.0        0.99            -0.0        0.99            -0.0        0.98        perf-profile.self.cycles-pp.native_irq_return_iret
      0.28 ±  2%      -0.0        0.26 ±  2%      +0.0        0.29 ±  2%      +0.0        0.30 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.19 ±  2%      -0.0        0.17 ±  2%      -0.0        0.17 ±  2%      -0.0        0.17        perf-profile.self.cycles-pp.get_page_from_freelist
      0.20            -0.0        0.19            -0.0        0.18 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.28            -0.0        0.27 ±  3%      -0.0        0.27            -0.0        0.26        perf-profile.self.cycles-pp.___perf_sw_event
      0.16 ±  2%      -0.0        0.15 ±  2%      -0.0        0.15            -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.handle_mm_fault
      0.06            -0.0        0.05            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp.down_read_trylock
      0.09            -0.0        0.08            -0.0        0.08            -0.0        0.08        perf-profile.self.cycles-pp.folio_add_new_anon_rmap
      0.11            -0.0        0.10 ±  3%      -0.0        0.10            -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.xas_load
      0.16            -0.0        0.15 ±  2%      -0.0        0.15 ±  2%      -0.0        0.15        perf-profile.self.cycles-pp.mas_walk
      0.12 ±  4%      -0.0        0.11 ±  3%      +0.0        0.12            -0.0        0.10        perf-profile.self.cycles-pp.filemap_get_entry
      0.11 ±  3%      -0.0        0.11 ±  4%      -0.0        0.10 ±  4%      -0.0        0.10        perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.11            -0.0        0.11 ±  4%      -0.0        0.10            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.error_entry
      0.09 ±  4%      -0.0        0.09            -0.0        0.08            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp._compound_head
      0.21            +0.0        0.21            -0.0        0.20            -0.0        0.20        perf-profile.self.cycles-pp.folios_put_refs
      0.12            +0.0        0.12            -0.0        0.11            +0.0        0.12        perf-profile.self.cycles-pp.do_fault
      0.00            +0.0        0.00            +0.1        0.05            +0.0        0.00        perf-profile.self.cycles-pp.folio_unlock
     81.57            +1.0       82.53            +1.1       82.62            +1.1       82.65        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


> 
> Shakeel

