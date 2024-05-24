Return-Path: <cgroups+bounces-2991-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804B28CE1B3
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 09:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E4C1F21D32
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26996FCC;
	Fri, 24 May 2024 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEf3Ow3X"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F01487BF
	for <cgroups@vger.kernel.org>; Fri, 24 May 2024 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536769; cv=fail; b=Rs25/tViqZg7WTAs5ZExBXRDurn3Z5tie5KmwbprsR08YCdbqoQ6Ecc4lwgpo0Acvuc5FUanytgFWOT+Hyb+RyEq+GJxsaVzEl8rnnqeXqAeR0wTW9UhsFiGzB/GqZj/3tn5K98h2TLKAeAJXmtLix9GXhP1SNs7NrCl4lEn4Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536769; c=relaxed/simple;
	bh=8qdlkXI4NqdmgDEJun2dvXGEDUiRKJ13jGd4/FD+7+8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DF82hVb9grgf3UJhLPYQ2VBoneZqtVnUXEWVnPBcQslFmi1EMOR12CfsJs8PSC7tnAH0HxTftZAFMjriITwu6os6jYa17JPC649IdiJx9+g3EpYqnqKGlydV76dLM36HQLFFn2K0KsXTJ0Gd9bMaD70S5nyPfeuqgSqFPILv77M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEf3Ow3X; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716536768; x=1748072768;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8qdlkXI4NqdmgDEJun2dvXGEDUiRKJ13jGd4/FD+7+8=;
  b=nEf3Ow3XS287r775Z7wIFkQdk34DBnEG7DObUbyz3/nIwa3vWI1RE0nd
   6n0D6hZcpfB+b3lfGojUhaLGj1EQPuidwMs9U1rJjw5PN+84gNPD0VVr0
   nRZKwRWP7LfNHaelgOlvZuvNLFIC1ai6ulPLtg3JkhuqnjWDEl5+UOGwu
   QzcHFZ7r1ZkmnQReh6moA/bS0M8/KT/3kcqRQJJBt4pUZGorvBf/z9b9O
   B6bFNuSkwRc1s0bT0QX3nOIGOgGmI6R0cOyfqOfheDteSJBkPr3ZKKHJ8
   ZC1cPuKiwgIk+5sGysyxb892Lej4tQsDM//SwTYAZ6oaqQGWPOCKbnWC5
   g==;
X-CSE-ConnectionGUID: kykkG2WZSQWXzz9tZMfT/A==
X-CSE-MsgGUID: PHAP7oBpT7KBcX3hLuZ7GQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="16692996"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="16692996"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 00:46:08 -0700
X-CSE-ConnectionGUID: JF/14TC5Q8iOpJECyyRNQw==
X-CSE-MsgGUID: KzlikJSIROGLtPOy6dxV+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="34433186"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 00:46:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 00:46:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 00:46:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 00:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnnCVK6AqCvykMgHTg6Cmd6asG7pcFRHluMweXx4M9u1glbb1YcWlp636FWrM6/6BUcUiFYTdXY7xJ2H+5pRQdyI6q9inLD0FpOZaO1Fm9fQxiE2KfF/vG+Sw7LvVN6hv7mDR+6EtesEiKO3QaHNbrKPhZkOTmnNBY0n7gk+OJB0Ew60Md50brCoJmaTyp2YYb5Y03AcH9GgGybdSIye8NeWYPiYD9SxyLgehKajWEBELe75yNXI/XQJxHf0xbVgFp8XifMqdla15Q7ao9HWZdTqAMmnrV1Xe/3IYVW1X0VdJhe51dg2nwXOqRvbWD65OfrMhZmTzQRgLKUGVZ+9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYPLoQ411lbLA7AWGBPCGIkHgmCg0VBAONlIojPa/0Y=;
 b=H8WOmLD4xHRkof78aN3XqDjD1E1YUusH1He2SIzjCL2fiP0WRVCvYEk6S/W9k6xBPuNm0b7/1bodiVX3FvO5+lk8rYFtwvQwia/agkz28iYozTX+ZYJ2/K/GeCPAAxM/tml7fymLYYLYfoIEcW57iYPhNeAnpuqz7mI4bCntNCZLtuIsFduPVAp2XC1UpWs/mew5+Jxc/cmj7UrKG3+ISkokt7wH8JFmDlwr5cwSn1mCK4jsmxI1yASinL5fogW+y/06TBD+MYNDr8zUCIBI0/NC0YMFy0rcx7fdrZ2+OjXw985Uc2pjE4bUfRdikKUrhzENU9s5jQQOZKteX1+EKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 07:46:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 07:46:04 +0000
Date: Fri, 24 May 2024 15:45:54 +0800
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
Message-ID: <ZlBFskeX3Wj3UGYJ@xsang-OptiPlex-9020>
References: <202405171353.b56b845-oliver.sang@intel.com>
 <pdfcrrgqz6vy6xarsw6gswtoa32wjd2gpcagmreh7ksuy66i63@dowfkmloe37q>
 <ZknC/xjryN0sxOWB@xsang-OptiPlex-9020>
 <jg2rpsollyfck5drndajpxtqbjtigtuxql4j5s66egygfrcjqa@okdilkpx5v5e>
 <Zkq41w8YKCaKQAGk@xsang-OptiPlex-9020>
 <20240520034933.wei3dffiuhq7uxhv@linux.dev>
 <ZkwKRH0Oc1S7r2LP@xsang-OptiPlex-9020>
 <gpkpq3r3e7wxi6d7hbysfvg6chmuysluogsy47ifgm55d5ypy3@bs3kcqfgyxgp>
 <Zk702CrvXpE6P8fy@xsang-OptiPlex-9020>
 <k2ohfxhpt73n5vdumctrarrit2cmzctougtbnupd4onjy4kbbd@tenjl3mucikh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <k2ohfxhpt73n5vdumctrarrit2cmzctougtbnupd4onjy4kbbd@tenjl3mucikh>
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: b95fd3d5-0b4c-453a-be1d-08dc7bc5904e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bSjfmf5ofxi3UGF1w9MYcwaTB+SYeTX2ROnaI3G6bLsqX+u6t9/XK0HrfZ+y?=
 =?us-ascii?Q?2aUQHBblMWTJ2k72V/uu5N4bYog+ypIWwlR23V95pTix2jtc1PlfTqHnTen2?=
 =?us-ascii?Q?3vFLU7INXlCvLIuPc2UeXwGYP1H6aYqCbQ32If8vaTJJ1IgUG2no6aRqpwkB?=
 =?us-ascii?Q?o95c5zq79GB0kZiIV4Ln1BsZu1KYg8MYqjaN0qMGECdealsXRGiyVjKi9gdJ?=
 =?us-ascii?Q?BCQKolnKiMaZtGU+m5TrjYkgDUoiM/iqKnBCqFHYXkWft9W5zccjuiPVUPg2?=
 =?us-ascii?Q?dojWnP2G4d9kmmA6vcuRRK4FUceULmfwTDvWavIKxcDYgHTYlHr2YzaBkVRd?=
 =?us-ascii?Q?JeRThBEn4N2FQeJ+1E7DQoOtKJamv34kN9ta2XdIkpkVzx1pP0+lVxEKZfqd?=
 =?us-ascii?Q?+ZXEAHG5QD9gY52irc5GrWvpzhkoC/0XyYNsndaUhlhs+czXoPIWAaeY7oU6?=
 =?us-ascii?Q?oDlRHgYYiM7Bn0FDRpfBd8Q8774Vgpn65tNbUVjV+QMGJvw5Ah4qyS7hGTpV?=
 =?us-ascii?Q?rbB6+sDGpAgX1A2tR8P5j448a5pSzBtpvrMhWR2ZLlaXvgKuPNBXRj1m6cOF?=
 =?us-ascii?Q?JLTlh6Rs0RGRY0EQjeCzQbiCZYrHKe/gfunwnX5vyKrZqJWOJqyrxIRvm9XF?=
 =?us-ascii?Q?Cnni6dd+gdJRlbXKNBL8tzVLPs0D1Xs6rPa0JTkBCyS3U5M5TKyqDXcoLrg/?=
 =?us-ascii?Q?jNBX1jU+GWrjH8NeDrXzpRrfWX6odhxVRrl97IvXKlUcNV4uSUYEL8Mb4auw?=
 =?us-ascii?Q?6F1mr6WBN39JaXm0+m0kvDjwD+mvi5AYRd0oAZGZ2XSa3RDbAhbx3NTvV48D?=
 =?us-ascii?Q?LpWLOwClNTnX3/muo28Nro12f94yn/25bah2X5+f5c0GCJ8xV/eU6IOoAV+W?=
 =?us-ascii?Q?AOPIY9V6pZcimVpendUeGqbeHOjp0KLkx8vcsAVnunQvOrCVlPToffSSEWgz?=
 =?us-ascii?Q?Tm+NUGKzgdJsN/IN0OWegL/dECslReH+nGtU+PFd2LtoIGG6U3YIgTcKIrz0?=
 =?us-ascii?Q?7BUcwsHRTRsobSejKK0Ro01cH/MAJz1bBd8OKYc16kogg36yhGrbWz0rp39v?=
 =?us-ascii?Q?LcH6or6ZUdk/Rk7p0LFt2lKM2/YEB/K+2Dyggq5pb6FylyVqUCLJOzTqNOsl?=
 =?us-ascii?Q?2pMeMgOgHVXsAbGd3czByiHBrClQ2yotVVylhtBlod/ONS9mn65jcXL3OjjI?=
 =?us-ascii?Q?V38JWGpnzt3Ia0hNLD6Qi+Dsgwn6wp4hyI9/Q4vc91Iyp2btSiHvVw40esw?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QiG3rZsHTrmw0Pxex4Q99Hl8kId1MX875z1IUfPbW1rlOhlwPk05uYkO47Ae?=
 =?us-ascii?Q?O3/6lczrbx6nV7XM1hr8b00VIDfLPTCzfFKM39r4AIqQm5efD7g4iQFT9NRn?=
 =?us-ascii?Q?2MhHZ//ybCaPjDyIMnosaziTra/fiaZeHtCYh3BETFQCNEl6w9xrJZeCNcEd?=
 =?us-ascii?Q?g0tYz2K+29lCMXCvpR1iarmqrr1L4x5nW/LSKybmWkYwN8MQIkVfXR0rI5zk?=
 =?us-ascii?Q?dlENN9TD45IFdt5UIfrwyK3ka5OGzSKRaz1GKG5cWGOZBliypQ5zUvk0nKZr?=
 =?us-ascii?Q?QeYcXpM8P2Pm/O9IYj6i+DGQHsEWTGCsW8QDvhFfDGWqHvzYnqAi6yzISrM/?=
 =?us-ascii?Q?sjFRA5PcF6WwsdrPrSS90zLNtOAla+6sjUsFfQT13nPAXkndzvvjcoljeqkB?=
 =?us-ascii?Q?JeyqtbD7L3Iw2ayffNiApkzZUlLw9jJjnyqYfwXCZ/srsv8xSRDxJpv3+QsM?=
 =?us-ascii?Q?jgT8N+JPz2vrP16fBBu+nqYY9zBLd6xCUlt0wXevsoqKB5+xrlZSMOdGIjuC?=
 =?us-ascii?Q?FcUlerJA8ndlqd2u5fMXoAv+7Pc0Zz+XuzA7Lxd2952G+BzH+z7vmjSkvP3z?=
 =?us-ascii?Q?68XGk8Q/50Kp03n07IDpvUe34Swn4lSjFiD/o0b9jeuMFYKShES2sOuuCbjG?=
 =?us-ascii?Q?8AMIudbonOxKvxbDyOVARVwLZjjDz292/YLfEiU+bdV4eiN2SD0FPrm6mcdA?=
 =?us-ascii?Q?koZwEy44v7LzDhE1+8qHvvWv4NjVJ4Hd0ZSV7NfEnoCmeeXTzZiGlLXLd0ES?=
 =?us-ascii?Q?fsIFbSwOZRG88KV0xteds/p5NDYbvFlr5DTob7l/5nPi6avFoyg0AywnKKGM?=
 =?us-ascii?Q?+iouM5AQ9UheVhUFm53bDDyv1RcydnxOKRs2PCYQwYb2fPnGxn0yB1g2m8c1?=
 =?us-ascii?Q?kK4QSVBa4ZiaQitVltU5KKOlzLeHoTfrKw/acfKVqVZBDH3fLmf2UKE2io62?=
 =?us-ascii?Q?Lz7eUjltP3UGTknDZ2/dDfWi1I0BZqfVGURnqGDdULzZcEUSWpymYSRk+/V5?=
 =?us-ascii?Q?2GTSdnwh0BMkBot2zCHK0xSLcbMCLHYCLS4soBZ/wV6ccgYm+mZ4V2UQh5yI?=
 =?us-ascii?Q?T8J4b3qpYzQDset4XP+2RHmL2MrggitaTvityY/P/BDBWdrcxACTk1adHxj4?=
 =?us-ascii?Q?IOO1OFC0l3JeMvdoVaYVSPson/E/SMGPTrNM5/8n5/5/srcD48VsEjNbIndQ?=
 =?us-ascii?Q?/3AxtWk8zTMEAZ3uNJX+rpx1NxqgOhl+rI4XOz+d9EmK7VbfYjtrvoQ3ngKG?=
 =?us-ascii?Q?zvwUNHmt9otvN+frGlul8G4TaDMFWTomvWBWPvVGdDl/zlcO4HipzbGGnIyo?=
 =?us-ascii?Q?FCaMvYHU3qvRARj1neQAkJ35+1VGvE71xKxWCcspBwh/2ns3C3muJN+pi96R?=
 =?us-ascii?Q?3jV/E7xX73bFIW/IlLdkQTCm+k6TDWuvyppP+BVrmufq3YF2BMHblrMtnTBn?=
 =?us-ascii?Q?YrxNnqQu9/aLTkw3SFpz4lzf9TG2vQMt/r/2gUEyq9k0nuElGCQuu+mfGtJs?=
 =?us-ascii?Q?HXgdgZI50vYVICyYC3hLh/5u53FcwvLWZ4sLo8jMVGlE9OjoporcinbUDKX3?=
 =?us-ascii?Q?/aiHETur14injzjP77B+y/xzcfZfa2eWiOeQ2MrORQQi8QCtLjyAknWQ8++P?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b95fd3d5-0b4c-453a-be1d-08dc7bc5904e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 07:46:04.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byGO19AF22iLTRIjqk3q5Ja8eBu69F54htB2zJXV6xRsRdbXePkI2EOESgsPWPLWZdDp0A46Iqh6SHV4+1rABg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5140
X-OriginatorOrg: intel.com

hi, Shakeel,

On Thu, May 23, 2024 at 09:47:30AM -0700, Shakeel Butt wrote:
> On Thu, May 23, 2024 at 03:48:40PM +0800, Oliver Sang wrote:
> > hi, Shakeel,
> > 
> > On Tue, May 21, 2024 at 09:18:19PM -0700, Shakeel Butt wrote:
> > > On Tue, May 21, 2024 at 10:43:16AM +0800, Oliver Sang wrote:
> > > > hi, Shakeel,
> > > > 
> > > [...]
> > > > 
> > > > we reported regression on a 2-node Skylake server. so I found a 1-node Skylake
> > > > desktop (we don't have 1 node server) to check.
> > > > 
> > > 
> > > Please try the following patch on both single node and dual node
> > > machines:
> > 
> > 
> > the regression is partially recovered by applying your patch.
> > (but one even more regression case as below)
> > 
> > details:
> > 
> > since you mentioned the whole patch-set behavior last time, I applied the
> > patch upon
> >   a94032b35e5f9 memcg: use proper type for mod_memcg_state
> > 
> > below fd2296741e2686ed6ecd05187e4 = a94032b35e5f9 + patch
> > 
> 
> Thanks a lot Oliver. I have couple of questions and requests:

you are welcome!

> 
> 1. What is the baseline kernel you are using? Is it linux-next or linus?
> If linux-next, which one specifically?

base is just 59142d87ab03b, which is in current linux-next/master,
and is already merged into linus/master now.

linux$ git rev-list linux-next/master | grep 59142d87ab03b
59142d87ab03b8ff969074348f65730d465f42ee

linux$ git rev-list linus/master | grep 59142d87ab03b
59142d87ab03b8ff969074348f65730d465f42ee


the data for it is the first column in the tables we supplied.

I just applied your patch upon a94032b35e5f9, so:

linux$ git log --oneline --graph fd2296741e2686ed6ecd05187e4
* fd2296741e268 fix for 70a64b7919 from Shakeel  <----- your fix patch
* a94032b35e5f9 memcg: use proper type for mod_memcg_state   <--- patch-set tip, I believe
* acb5fe2f1aff0 memcg: warn for unexpected events and stats
* 4715c6a753dcc mm: cleanup WORKINGSET_NODES in workingset
* 0667c7870a186 memcg: cleanup __mod_memcg_lruvec_state
* ff48c71c26aae memcg: reduce memory for the lruvec and memcg stats
* aab6103b97f1c mm: memcg: account memory used for memcg vmstats and lruvec stats
* 70a64b7919cbd memcg: dynamically allocate lruvec_stats   <--- we reported this as 'fbc' in original report
* 59142d87ab03b memcg: reduce memory size of mem_cgroup_events_index   <--- base


> 
> 2. What is the cgroup hierarchy where the workload is running? Is it
> running in the root cgroup?

Our test system uses systemd from the distribution (debian-12). The workload is
automatically assigned to a specific cgroup by systemd which is in the
sub-hierarchy of root, so it is not directly running in the root cgroup.

> 
> 3. For the followup experiments when needed, can you please remove the
> whole series (including 59142d87ab03b8ff) for the base numbers.

I cannot understand this very well, if the patch is to fix the regression
cause by this series, seems to me the best way is to apply this patch on top
of the series. anything I misunderstood here?

anyway, I could do that, do you mean such like v6.9, which doesn't include this
serial yet? I could use it as base, then apply your patch onto it. then check
the diff between v6.9 and v6.9+patch.

but I still have some concern that, what a big improvement show in this test
cannot guarantee there will be same improvement if comparing the series and
the series+patch

> 
> 4. My experiment [1] on Cooper Lake (2 node) and Skylake (1 node) shows
> significant improvement but I noticed that I am directly running
> page_fault2_processes with -t equal nr_cpus but you are running through
> runtest.py. Also it seems like lkp has modified runtest.py. I will try
> to run the same setup as yours to repro.
> 
> 
> [1] https://lore.kernel.org/all/20240523034824.1255719-1-shakeel.butt@linux.dev
> 
> thanks,
> Shakeel

