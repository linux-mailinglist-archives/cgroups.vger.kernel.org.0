Return-Path: <cgroups+bounces-3697-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9536A932183
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 09:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BEFF1C20B20
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 07:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C093BB32;
	Tue, 16 Jul 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9ReoNYw"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE8224DD
	for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116426; cv=fail; b=aLAzOsgwRQYJhjPRghPw+XRcKoRUzXWqbX1LdkrQsDpN5iS59Vatwb3t5qS5hexYiBmxOrcf30865XAuNg0yUDRU06UVnYoZE23G3NOP1OO0a3ztmM7qiKuPUFtL+RnIlWX3pnG1Kl55YQDeZYTzAc+XCk3gUwreMDNRXFdwi70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116426; c=relaxed/simple;
	bh=E1HRZTKh5d8cEYSRQQc2V4kVE2jkplg/+a0p5n4JtlQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rbft8wamUr+p+fkHq2AOYsqAQWFwydbUGC5e/Bf43UEdKOBwF52WxkxUsHbATj6cUiCs5YnD0nbnWHTVDM+qrpBkd1nbLmvSJntrT/+CU09oioHLzeBmrcy+laMEUyjO9Xd1d2fDHDdIZQWO2uAFL2/3zi48UxN1ltJ8ZDdzHm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9ReoNYw; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721116422; x=1752652422;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=E1HRZTKh5d8cEYSRQQc2V4kVE2jkplg/+a0p5n4JtlQ=;
  b=H9ReoNYwUTvCJUgifvZcrBf6x4UJHF77HP7P3/kY/LKGXn2U3gQcQW/y
   jJO7eHGRwTE1kdb4yGsFxP/iDsvMvmqoypeTfLt7Mo+wARPpfxOkeOqaI
   WYK+MCAANk6yam/wgPf8zluKdSq4MEfjuB8gqBnTSh5JSu9hwV+tLasj6
   9BcJhpxTQUcxtm64dOppcO67hAmZdr5Yb31oS7hmhCwZ1/SEMPEiSU3UO
   XBJGxRmIifVmkbRnJNzlG1q1FWA8zlGCGi6OQ+LleurSnzJjN0/9azqqk
   P8suWSv8F8Tgsn3yyATedEx323YJGf2ikwKKMTr6ltKmBlfWMQXM7UcWh
   g==;
X-CSE-ConnectionGUID: Q6eFRFGKRbKnWNPrcWVFgA==
X-CSE-MsgGUID: DQ7a+e8qS4WUOQ3zdvbR9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="35971150"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="35971150"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 00:53:41 -0700
X-CSE-ConnectionGUID: AZOieSSzSL6ayNGbdzjasQ==
X-CSE-MsgGUID: +mTCnrTCSi6P8PTd1VFL8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54747652"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 00:53:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 00:53:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 00:53:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 00:53:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 00:53:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiqIts0LFEQo8ToaGgM2TvcyCn6kCLtfRt8zk7n6SHvzf2z2PpFuoAmP/Qfd/gN8Nx9YWMWUdvLMLBYABomJwnW40aTWHS8pCYO0jPzk54eMmjhqLYG+n6spdj043zhfs8kiGAN47YHO8STFDGh9iGsS0sdcC4hWlT3unIAyMcRi3J2npP6eYCVnr7XWKwVCbdsXx4WbwFCJotpdnCDZU+seSYKyTShkwRs2p+r+ieerRd0SjiE7aE04c7xquq7lZmGhnKROzVYmRVbHC/O4Ftg4eKWeU74eDGUeKAGfLNSCHxsBZJEOUkLJUIR0eXC4HxhTRKq79Vs7OXN6MpiCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J31ZbvijWzJCm4cSZRWpRnd7RnreryWcxKsFTObT+Bc=;
 b=rMK54uGGiy+jinmR/A7ccHLhmiU8xLS9JQgUMrpWtytjDEZNm0/9IsZ99IV+iJvx/D9cwJJf11SNl/vPxb/PgpBDG/TH1NKBlLMCou/eLUYhH05VGfyWFFnygGSAC2laVPmk1tE2r5hBSdBh2ZEMWBnoVykOIC1n3PETd/WODvgDFyDu4a04j2RAWhCODVEHXETcYQOw1+c6r6cvg39U3TZYHqqCvrXWendsMUnGXWO5p2hnOxMSPzU5/Ac5VjoaXjYglq0/1lE3zW4OeZ0HYYLFJ7aTXx8e04nxh+Cp2YMD/TfHxjFR90AlLqat9TbVR2x3JyLfIdGRSC8RNBzI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB4939.namprd11.prod.outlook.com (2603:10b6:806:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 07:53:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 07:53:37 +0000
Date: Tue, 16 Jul 2024 15:53:25 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt
	<shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko
	<mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	<cgroups@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [mm]  98c9daf5ae:  aim7.jobs-per-min -29.4%
 regression
Message-ID: <ZpYm9clw/f8f/tEj@xsang-OptiPlex-9020>
References: <202407121335.31a10cb6-oliver.sang@intel.com>
 <ZpF-A9rl8TiuZJPZ@google.com>
 <ZpUux8bvpL8ARYDE@xsang-OptiPlex-9020>
 <ZpWgP-h5X7GKj1ay@google.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZpWgP-h5X7GKj1ay@google.com>
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: b81b0119-bb10-4637-233b-08dca56c6613
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?JYys0hj4a88T2MP4rNzSr7uldYpBcwj0KV5/02tkEtPrnOK4WpT5MJ2pMg?=
 =?iso-8859-1?Q?DbkmpCwr7iyH0pbml4Z3djHsGzU5wAE6ZdENL7sKj1PhpI2FQN3F/MKG8n?=
 =?iso-8859-1?Q?MxFH4zYRy42ku/9okywqddGgOhxeWpXqbK63KUgSlOFoGgmkzPFf5sxFRo?=
 =?iso-8859-1?Q?d+OFaORXRXNd1GMS2GIekVGQTY6dW2fDB098T2wSNAEzROzUsdnjWkkxRV?=
 =?iso-8859-1?Q?5gqzaiefNSo8FSWZ1pWqa/yV01Ce+Rc3slFFwt7oVZ0ovA36r3pfcWMkOh?=
 =?iso-8859-1?Q?DoA8fTacjNbFyOvyS/eoBUo4qcroKo52L+7lcdWro8nAzuwBmryhD8Zx43?=
 =?iso-8859-1?Q?gqN75a/0kRsJrYNpOFwqBQzhwHUGfCt/kmURMMZmM9iDQlLlAROWrrseGc?=
 =?iso-8859-1?Q?QHl/bD4WNja+b+b3gaxmWO/GOLwhC0DPI8+RLzhzOtXpNUmqulKuqqrvG2?=
 =?iso-8859-1?Q?1zLXplDj7ZX3A7n/dtu+FkHA8DLwuUWXykNMEPJEp2Qq57oRzzMjfYnoZi?=
 =?iso-8859-1?Q?/5FhduRjCus9NsjnxApEGvBC6EPecOTpw2i6pl26Jk0UY5d8s0RuNm7upZ?=
 =?iso-8859-1?Q?9djwEs66rBnK56idhfYg2Z2wh4fpA6AUyl3EHK+cwxv3apf2w1pkM5bDm6?=
 =?iso-8859-1?Q?GoAq78P5H8gaJ/a/OvcW+paFPy24SvEOV0mio+ILCRnWmKg9kwyhUbh1L/?=
 =?iso-8859-1?Q?ko+Vke/8x81lNLdJMfU6EpRESbhB3+iwlRPZCAtWrwODqakNXDvZ0qMI+t?=
 =?iso-8859-1?Q?ocNXzeGI5scXBp1A+atsI2p7gvTGmoQLGF/UK5oYT7xI5JsRTM2O9z5FGn?=
 =?iso-8859-1?Q?0hw9Upem7Dmu5Rw4NQTd9vjO8dmLGjXgSm8gc0kNCzC1BFX2B3XxcQbpj0?=
 =?iso-8859-1?Q?dnJSA0IfBAAorjQvKameJf6eUU7O5Tiae3+nyRXl1fR6JB3XlyRQexwtA5?=
 =?iso-8859-1?Q?3uJorZW/j5OOUrgd4tP4IYpy2H8qarevs0LCJ5YWuS++aZPK9iWCFuhxLF?=
 =?iso-8859-1?Q?0DsQOYz7QgpBQsLnDcDTe7Lvhy7bIvET++5GbLYBcXbdZQ6qOjgRacmC8b?=
 =?iso-8859-1?Q?fvHm624nw1zuFlY7MeaX48maFvjuPLuluBi0URDeZjeRp7zqu8zX6aK2MD?=
 =?iso-8859-1?Q?i8pwsU6TE4Gyu+wpgzgl8gkzwHETyd0RCH+wrrjz2z76YT7kkgI+AHFtin?=
 =?iso-8859-1?Q?Wq+vjxGgHVB2dt2WtUdXwhXDJKDO4UmMgRoBRBJCzZCZ65Yp7z95zWmMdV?=
 =?iso-8859-1?Q?oeirkPlFHk9K4VcH6s+Lqezr2LgtqpxwP9jQSTbmYNharX/q6+XKJ9HjkE?=
 =?iso-8859-1?Q?j1fLTBh3460Z5V5C6lcwldwTZneVw0gobRSKNJHAQp+pTQ5wlaTsx7lHNx?=
 =?iso-8859-1?Q?AnymQWsEkU/Nro4JwT2gxB/TNvMPZlpW9QU/hVak2jkUEb80ynLQw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZRjI3x/rhshk0F9/qFPbrE4RUYDcgNK6VMhtBvM/BKsQ93UbLUfolfhU/8?=
 =?iso-8859-1?Q?LJV2fGITgDo1Pbuh9vRVqJYQOvqzDQ/3LGijoPqK5TWo2x73HEJmhN4QFx?=
 =?iso-8859-1?Q?5yMmJBhKAEPwPbewWwBhKZSu8dk0gWPUILA0x6Kj9+7TLfjZ7+bMT0kos2?=
 =?iso-8859-1?Q?g6uWC4rw+4JNXbolxkqmcniyWN+6C0wRXveqCh9xhCVZAXosYYGF2/5qnG?=
 =?iso-8859-1?Q?JEnLDfbz1ywb7EnqlkJHvpOmLldCspUu6yMAS65+l3DZ5UPmQ7n8I8bXk6?=
 =?iso-8859-1?Q?kC/CKUgXG8Pn0qADCCAbWH8q+Hwn8bpe3mPYGoicXuju/V/nfIaqSabX0R?=
 =?iso-8859-1?Q?rF49xCtrcEYGP+V/3LYQUfycD86PlvtdUGAB8zfblTn9InPtZPkpz3D/of?=
 =?iso-8859-1?Q?iN3JFiPU+l9B2fjTKhgFlF+oRNLxkLnFhR/V5hgwBwvQhHM65MSFRYUZev?=
 =?iso-8859-1?Q?FJMbd0j1VSIBcpYCIwF340KxAAs+lTkE8XXar7M5aEGBo5pUvHPZJ6HOHD?=
 =?iso-8859-1?Q?GoVWoV+nO+4NUiXsfS6nJKE2+jsjsVpvw26/J69FT344nXcGYdXj6gO3cH?=
 =?iso-8859-1?Q?zIKuhDgRSpDvRd7Lotmqwkn1ggvj6WzrLxZLjcknazKnUqCDrAD75Cu7zr?=
 =?iso-8859-1?Q?JjWkyAAaXzcvzZP7zdiYhX5feJGOl0WNn3SPdzmfAabSWXhyzTk6ScIjPU?=
 =?iso-8859-1?Q?6y8s7l24nqgR47FKvASYyPPN9hEtCQ5p3/x+O+gTDqzCSOLCnpwqRigO6H?=
 =?iso-8859-1?Q?vcHrRyTZpbJnv7pQJu882dvVxe4W2+qwe5uANBeuZU3MELvXgzmJM+nkH0?=
 =?iso-8859-1?Q?5bAGhZ2dwNeBGS36dpcDgSwcNu/ia4WhRRVgBxJ/k6KI7RNv/BjwsVHyeV?=
 =?iso-8859-1?Q?XCrVpA5D8RVVdJtrX5ihhOOpSbpFUNPWrU1/1VMTChPPnihtNHz4H/db8U?=
 =?iso-8859-1?Q?tIO5vkmX7hBHiDS3xqTIjsI4EyqW65jCzaDJ7W2JM6zyclDpyJv7DGjr50?=
 =?iso-8859-1?Q?+Tq9KTFKa6voBKfLftFh0u1oFQdd7HvaxyI1FpFXz59Qi9nomhPrjAOBT9?=
 =?iso-8859-1?Q?k52wOGEU0hLU5y6XRZUNTIjxSkdhsMtnHPh5Nh2s5o7ecw1xOHsuGfUdLm?=
 =?iso-8859-1?Q?eJ3qVb9ZgciOXbYlDjcKCSPbKZ7DYsaOl416abc90ov0iicPBf05leAG4j?=
 =?iso-8859-1?Q?g9mhLnhzjvKtvK6XzaYID/c06oJzkh23kikga66AmL1CdGKmNYRRYN+luQ?=
 =?iso-8859-1?Q?mCe8GAB03DcXeEB2Kz4S2sYZYA01Dcl8+dpHSyRRnL0he2t7kM8htocUeU?=
 =?iso-8859-1?Q?cPjMsnkkFGl9cFq++sUMGe43iYyA3EyCaXFo69UjUuFYqiTny9/uKuOKmD?=
 =?iso-8859-1?Q?qraHxiuKViuROywubLjXE+TWKaJtuPeVdDTnIeMp77imbdoP0xOTq+JBtz?=
 =?iso-8859-1?Q?wO2k4m660c0/xV+LNe87RTgMTltKezepTBYOqx25oh1Yw3Ym4HiI7YW6lK?=
 =?iso-8859-1?Q?0exOaxjlyQh4+cQlOJxbtfwLBWICs5o9xNNt/kupRng4VLbuctMAsVweqU?=
 =?iso-8859-1?Q?hQkuHV8cEH0a0D8x1whvYsEK7hCisPF4FTIc0rcuDlPe2UU9uS4vBlPswu?=
 =?iso-8859-1?Q?eVpuDtQ8tluzzLP5Mo4jzsL9ra7wVCHGLQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b81b0119-bb10-4637-233b-08dca56c6613
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 07:53:37.2733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4aHlOpWHNnzdoHWRk79aicC5eFwnn5ou/sn+XWD5T28T0S5AHvrfXNSwZ0jtlGVskUWJCbczEKF72lc1xZG4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4939
X-OriginatorOrg: intel.com

hi, Roman,

On Mon, Jul 15, 2024 at 10:18:39PM +0000, Roman Gushchin wrote:
> On Mon, Jul 15, 2024 at 10:14:31PM +0800, Oliver Sang wrote:
> > hi, Roman Gushchin,
> > 
> > On Fri, Jul 12, 2024 at 07:03:31PM +0000, Roman Gushchin wrote:
> > > On Fri, Jul 12, 2024 at 02:04:48PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > kernel test robot noticed a -29.4% regression of aim7.jobs-per-min on:
> > > > 
> > > > 
> > > > commit: 98c9daf5ae6be008f78c07b744bcff7bcc6e98da ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > 
> > > Hello,
> > > 
> > > thank you for the report!
> > > 
> > > I'd expect that the regression should be fixed by the commit
> > > "mm: memcg: add cache line padding to mem_cgroup_per_node".
> > > 
> > > Can you, please, confirm that it's not the case?
> > > 
> > > Thank you!
> > 
> > in our this aim7 test, we found the performance partially recovered by
> > "mm: memcg: add cache line padding to mem_cgroup_per_node" but not fully
> 
> Thank you for providing the detailed information!
> 
> Can you, please, check if the following patch resolves the regression entirely?

no. in our tests, the following patch has little impact.
I directly apply it upon 6df13230b6 (if this is not the proper applyment, please
let me know, thanks)

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-13/performance/1BRD_48G/ext4/x86_64-rhel-8.3/3000/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/disk_rr/aim7

commit:
  94b7e5bf09 ("mm: memcg: put memcg1-specific struct mem_cgroup's members under CONFIG_MEMCG_V1")
  98c9daf5ae ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
  6df13230b6 ("mm: memcg: add cache line padding to mem_cgroup_per_node")
  7b3274adca <---- your "_pad2_" patch

94b7e5bf09b08aa4 98c9daf5ae6be008f78c07b744b 6df13230b612af81ce04f20bb37 7b3274adcaac12369e13ac32e46
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
    210696 ±  6%      -3.0%     204465 ±  7%      -8.3%     193107 ±  3%     -12.9%     183521 ±  2%  cpuidle..usage
     76.42           +15.1%      87.99 ±  3%      +3.1%      78.77            +3.4%      79.00 ±  2%  uptime.boot
     53.28 ±  2%     -27.5%      38.65 ±  2%      -9.1%      48.45 ±  2%     -10.3%      47.81 ±  2%  iostat.cpu.idle
     44.58 ±  2%     +33.6%      59.58           +11.2%      49.57 ±  2%     +12.6%      50.22 ±  2%  iostat.cpu.system
      2.13           -17.0%       1.77            -7.1%       1.98            -7.5%       1.97        iostat.cpu.user
     49.85 ±  2%     -14.7       35.17 ±  2%      -5.2       44.66 ±  3%      -5.7       44.18 ±  2%  mpstat.cpu.all.idle%
      0.15 ±  7%      +0.0        0.15 ±  3%      -0.0        0.13 ±  4%      -0.0        0.13 ±  3%  mpstat.cpu.all.irq%
     47.74 ±  2%     +15.1       62.82            +5.4       53.14 ±  2%      +5.9       53.63 ±  2%  mpstat.cpu.all.sys%
      2.23            -0.4        1.82            -0.2        2.04            -0.2        2.04        mpstat.cpu.all.usr%
     53.29 ±  2%     -27.4%      38.70 ±  2%      -9.4%      48.28 ±  2%     -10.2%      47.86 ±  2%  vmstat.cpu.id
 2.242e+08            -0.0%  2.242e+08            +0.0%  2.243e+08           +14.7%  2.572e+08        vmstat.memory.free
     65.83 ±  4%     +59.1%     104.76 ±  3%     +19.0%      78.35 ±  3%     +19.0%      78.36 ±  3%  vmstat.procs.r
      8385 ±  4%     +34.6%      11284 ±  3%     +20.5%      10101 ±  8%     +12.7%       9450 ±  5%  vmstat.system.cs
    245966 ±  2%      +8.1%     265964           +19.3%     293498 ±  2%     +19.6%     294290 ±  2%  vmstat.system.in
      4752 ± 13%     -18.1%       3890 ± 11%      -9.0%       4322 ± 19%      -1.8%       4666 ± 16%  sched_debug.cpu.avg_idle.min
    552896 ± 10%      +8.5%     599623 ± 10%      +6.6%     589455 ± 16%     +68.1%     929486 ± 18%  sched_debug.cpu.max_idle_balance_cost.max
      5295 ±109%    +102.4%      10720 ± 68%     +69.7%       8987 ±112%    +796.0%      47452 ± 41%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 32%     -49.2%       0.00 ±171%     -62.3%       0.00 ± 99%     -80.7%       0.00 ±173%  sched_debug.rt_rq:.rt_time.avg
      0.19 ± 32%     -49.2%       0.10 ±171%     -62.3%       0.07 ± 99%     -80.7%       0.04 ±173%  sched_debug.rt_rq:.rt_time.max
      0.02 ± 32%     -49.2%       0.01 ±171%     -62.3%       0.01 ± 99%     -80.7%       0.00 ±173%  sched_debug.rt_rq:.rt_time.stddev
    778685           -29.4%     549435           -10.3%     698378           -10.8%     694234        aim7.jobs-per-min
     23.31           +41.4%      32.96           +11.4%      25.96           +12.1%      26.12        aim7.time.elapsed_time
     23.31           +41.4%      32.96           +11.4%      25.96           +12.1%      26.12        aim7.time.elapsed_time.max
     47890 ±  7%    +338.5%     210000 ±  3%    +117.1%     103949 ±  7%    +107.4%      99316 ±  3%  aim7.time.involuntary_context_switches
      6674           +26.7%       8455           +10.5%       7372           +11.2%       7423        aim7.time.percent_of_cpu_this_job_got
      1510           +81.7%       2744 ±  2%     +23.8%       1869           +25.5%       1894        aim7.time.system_time
     19454 ±  3%      +9.1%      21223 ±  3%      -3.5%      18782 ±  4%      -1.1%      19246 ±  3%  aim7.time.voluntary_context_switches
     23.31           +41.4%      32.96           +11.4%      25.96           +12.1%      26.12        time.elapsed_time
     23.31           +41.4%      32.96           +11.4%      25.96           +12.1%      26.12        time.elapsed_time.max
     47890 ±  7%    +338.5%     210000 ±  3%    +117.1%     103949 ±  7%    +107.4%      99316 ±  3%  time.involuntary_context_switches
      6674           +26.7%       8455           +10.5%       7372           +11.2%       7423        time.percent_of_cpu_this_job_got
      1510           +81.7%       2744 ±  2%     +23.8%       1869           +25.5%       1894        time.system_time
     45.72            -4.9%      43.47            -1.7%      44.96            -2.6%      44.53        time.user_time
     19454 ±  3%      +9.1%      21223 ±  3%      -3.5%      18782 ±  4%      -1.1%      19246 ±  3%  time.voluntary_context_switches
     49345 ±  6%    +108.4%     102820 ± 10%     +32.3%      65261 ±  5%     +31.2%      64743 ±  3%  meminfo.Active
     22670 ± 11%    +182.6%      64065 ± 15%     +57.3%      35667 ± 11%     +55.9%      35345 ±  5%  meminfo.Active(anon)
     26674 ±  4%     +45.3%      38754 ±  4%     +10.9%      29594 ±  5%     +10.2%      29398 ±  4%  meminfo.Active(file)
     33695           +18.6%      39973 ±  3%      +3.8%      34971            +3.5%      34889        meminfo.AnonHugePages
 1.154e+08            +0.0%  1.154e+08            +0.0%  1.154e+08           +14.3%  1.319e+08        meminfo.CommitLimit
 2.244e+08            -0.1%  2.241e+08            -0.4%  2.236e+08           +14.4%  2.568e+08        meminfo.DirectMap1G
   1360098 ±  3%     +14.0%    1551107 ±  2%      +1.6%    1381539 ±  3%      -0.4%    1355108 ±  3%  meminfo.Inactive
    803759           +15.0%     924519            +4.7%     841839            +4.8%     842104        meminfo.Inactive(anon)
     66977 ±  3%    +115.7%     144485 ±  7%     +21.0%      81015 ±  3%     +20.8%      80939 ±  4%  meminfo.Mapped
 2.216e+08            -0.1%  2.214e+08            -0.1%  2.214e+08           +14.8%  2.544e+08        meminfo.MemAvailable
 2.221e+08            -0.1%  2.219e+08            -0.0%   2.22e+08           +14.8%  2.551e+08        meminfo.MemFree
 2.307e+08            +0.0%  2.307e+08            +0.0%  2.307e+08           +14.3%  2.637e+08        meminfo.MemTotal
     78152 ±  9%    +188.4%     225431 ±  5%     +64.5%     128567 ±  5%     +65.1%     129035 ±  5%  meminfo.Shmem
     15327 ±  8%     +52.6%      23389 ± 11%     +29.5%      19853 ± 14%     +23.5%      18923 ±  6%  numa-meminfo.node0.Active
     13455 ±  9%     +46.0%      19642 ± 10%     +18.7%      15975 ± 13%     +11.0%      14929 ±  6%  numa-meminfo.node0.Active(file)
     19657 ± 14%    +111.2%      41510 ± 18%     +76.5%      34690 ± 37%     +25.3%      24630 ±  3%  numa-meminfo.node0.Mapped
      6081 ± 16%     +84.9%      11247 ± 42%     +38.8%       8442 ± 13%     +31.3%       7984 ± 16%  numa-meminfo.node0.Shmem
     33647 ±  8%    +134.3%      78825 ± 15%     +35.8%      45703 ±  9%     +40.3%      47191 ±  3%  numa-meminfo.node1.Active
     20790 ± 14%    +188.7%      60020 ± 18%     +52.8%      31760 ± 14%     +50.9%      31364 ±  6%  numa-meminfo.node1.Active(anon)
     12857 ±  7%     +46.3%      18805 ±  9%      +8.4%      13942 ±  8%     +23.1%      15827 ±  5%  numa-meminfo.node1.Active(file)
    485228 ± 23%     +85.5%     899983 ± 21%     +85.5%     900160 ± 25%     +58.5%     768931 ± 35%  numa-meminfo.node1.Inactive
    202089 ± 50%    +192.9%     591917 ± 32%    +215.8%     638153 ± 34%    +153.9%     513101 ± 51%  numa-meminfo.node1.Inactive(anon)
     47991 ±  7%    +112.0%     101755 ±  8%      -2.6%      46748 ± 32%     +18.4%      56799 ±  4%  numa-meminfo.node1.Mapped
  93326924            +0.8%   94106109            +1.2%   94466709           +35.5%  1.265e+08        numa-meminfo.node1.MemFree
  99028084            +0.0%   99028084            +0.0%   99028084           +33.4%  1.321e+08        numa-meminfo.node1.MemTotal
     72431 ±  8%    +194.1%     213055 ±  4%     +65.2%     119653 ±  5%     +67.5%     121337 ±  5%  numa-meminfo.node1.Shmem
    467.96 ± 53%     +99.5%     933.35 ± 29%    +107.2%     969.49 ± 31%    +113.4%     998.53 ± 25%  numa-vmstat.node0.nr_active_anon
      3290 ± 10%     +50.9%       4965 ± 10%     +20.2%       3956 ±  7%     +11.0%       3652 ±  7%  numa-vmstat.node0.nr_active_file
      4793 ± 17%    +113.8%      10249 ± 20%     +84.1%       8827 ± 36%     +30.5%       6255 ±  3%  numa-vmstat.node0.nr_mapped
      1519 ± 16%     +72.6%       2622 ± 33%     +38.8%       2110 ± 13%     +31.3%       1995 ± 16%  numa-vmstat.node0.nr_shmem
    467.96 ± 53%     +99.4%     933.32 ± 29%    +107.2%     969.49 ± 31%    +113.4%     998.53 ± 25%  numa-vmstat.node0.nr_zone_active_anon
      3294 ±  9%     +50.9%       4970 ± 10%     +20.4%       3967 ±  7%     +11.0%       3655 ±  7%  numa-vmstat.node0.nr_zone_active_file
      4955 ± 11%    +202.3%      14980 ± 18%     +61.8%       8017 ± 16%     +59.8%       7921 ±  9%  numa-vmstat.node1.nr_active_anon
      3376 ±  8%     +40.1%       4729 ±  7%      +7.0%       3611 ± 13%     +10.2%       3720 ±  8%  numa-vmstat.node1.nr_active_file
  23331085            +0.8%   23527208            +1.2%   23617254           +35.5%   31624945        numa-vmstat.node1.nr_free_pages
     50152 ± 51%    +194.6%     147731 ± 32%    +218.6%     159767 ± 34%    +155.9%     128355 ± 51%  numa-vmstat.node1.nr_inactive_anon
     12101 ±  7%    +109.5%      25357 ±  8%      -1.6%      11908 ± 33%     +18.9%      14390 ±  4%  numa-vmstat.node1.nr_mapped
    393216            +0.0%     393216            +0.0%     393216           +33.3%     524288        numa-vmstat.node1.nr_memmap_boot
     17201 ±  7%    +208.3%      53026 ±  4%     +75.7%      30214 ±  8%     +77.7%      30558 ±  4%  numa-vmstat.node1.nr_shmem
      4955 ± 11%    +202.3%      14980 ± 18%     +61.8%       8017 ± 16%     +59.8%       7921 ±  9%  numa-vmstat.node1.nr_zone_active_anon
      3352 ±  8%     +41.1%       4729 ±  7%      +7.8%       3612 ± 13%     +11.0%       3721 ±  8%  numa-vmstat.node1.nr_zone_active_file
     50150 ± 51%    +194.6%     147730 ± 32%    +218.6%     159766 ± 34%    +155.9%     128353 ± 51%  numa-vmstat.node1.nr_zone_inactive_anon
      5776 ± 11%    +175.1%      15893 ± 16%     +55.0%       8953 ± 11%     +51.7%       8765 ±  8%  proc-vmstat.nr_active_anon
      6595 ±  8%     +46.7%       9677 ±  3%     +12.6%       7424 ±  5%     +12.8%       7440 ±  3%  proc-vmstat.nr_active_file
    187950            +2.0%     191760            +0.1%     188193            +0.1%     188115        proc-vmstat.nr_anon_pages
   5532779            -0.1%    5528733            -0.0%    5530018           +14.8%    6353558        proc-vmstat.nr_dirty_background_threshold
  11079086            -0.1%   11070986            -0.0%   11073558           +14.8%   12722652        proc-vmstat.nr_dirty_threshold
    945653            +6.0%    1002646            +1.0%     955008            +0.3%     948831        proc-vmstat.nr_file_pages
  55532095            -0.1%   55470389            -0.0%   55507767           +14.8%   63777563        proc-vmstat.nr_free_pages
    201118           +14.8%     230842            +4.7%     210479            +4.6%     210383        proc-vmstat.nr_inactive_anon
     17214 ±  3%    +108.2%      35836 ±  6%     +20.0%      20660 ±  3%     +18.7%      20433 ±  3%  proc-vmstat.nr_mapped
    916480            +0.0%     916480            +0.0%     916480           +14.3%    1047552        proc-vmstat.nr_memmap_boot
     19951 ±  8%    +180.4%      55933 ±  4%     +61.5%      32218 ±  5%     +60.6%      32031 ±  4%  proc-vmstat.nr_shmem
     40267            +2.7%      41335            -0.7%      39991            -1.1%      39828        proc-vmstat.nr_slab_reclaimable
     86277            +1.8%      87792            +0.1%      86326            -0.1%      86210        proc-vmstat.nr_slab_unreclaimable
      5776 ± 11%    +175.1%      15893 ± 16%     +55.0%       8953 ± 11%     +51.7%       8765 ±  8%  proc-vmstat.nr_zone_active_anon
      6595 ±  8%     +46.7%       9677 ±  3%     +12.6%       7424 ±  5%     +12.8%       7440 ±  3%  proc-vmstat.nr_zone_active_file
    201118           +14.8%     230842            +4.7%     210479            +4.6%     210383        proc-vmstat.nr_zone_inactive_anon
    312.12 ±241%   +1618.1%       5362 ±125%    +521.3%       1939 ±171%    +317.0%       1301 ±218%  proc-vmstat.numa_pages_migrated
    369792           +19.6%     442285 ±  3%      +2.9%     380386            +3.7%     383301        proc-vmstat.pgfault
    312.12 ±241%   +1618.1%       5362 ±125%    +521.3%       1939 ±171%    +317.0%       1301 ±218%  proc-vmstat.pgmigrate_success
      2426 ±  2%     +29.2%       3135 ±  3%     +16.3%       2821 ±  3%     +15.3%       2798 ±  4%  proc-vmstat.pgpgout
      1515            +3.8%       1572            +1.3%       1535            +8.5%       1643 ± 17%  proc-vmstat.unevictable_pgs_culled
      0.63 ±  3%     +36.5%       0.85 ±  2%     +19.4%       0.75 ±  2%     +14.4%       0.72 ±  3%  perf-stat.i.MPKI
 1.885e+10           -23.7%  1.437e+10            -7.4%  1.745e+10 ±  2%      -8.3%  1.729e+10        perf-stat.i.branch-instructions
      2.78 ±  2%      -0.5        2.29 ±  4%      -0.2        2.55 ±  4%      -0.1        2.65 ±  2%  perf-stat.i.branch-miss-rate%
  67232899           -17.4%   55553782 ±  3%      -5.8%   63348903            -6.0%   63198323        perf-stat.i.branch-misses
     13.70 ±  3%      +2.5       16.17 ±  3%      +1.1       14.84 ±  2%      +0.8       14.45 ±  3%  perf-stat.i.cache-miss-rate%
  72591570 ±  2%      +0.6%   73035167           +10.8%   80408900 ±  3%      +7.0%   77651016 ±  2%  perf-stat.i.cache-misses
 5.483e+08           -24.9%  4.118e+08            -5.7%   5.17e+08 ±  2%      -6.8%  5.109e+08        perf-stat.i.cache-references
      8605 ±  4%     +34.7%      11593 ±  4%     +23.4%      10618 ±  7%     +13.6%       9772 ±  6%  perf-stat.i.context-switches
      1.35           +65.4%       2.22 ±  3%     +20.9%       1.63           +19.8%       1.61        perf-stat.i.cpi
 1.616e+11           +22.1%  1.973e+11           +10.5%  1.785e+11 ±  2%     +10.3%  1.782e+11        perf-stat.i.cpu-cycles
    659.92 ±  3%      -3.5%     636.65 ±  2%      -5.9%     620.91 ±  3%      -6.8%     615.12 ±  3%  perf-stat.i.cpu-migrations
 8.537e+10           -24.8%  6.416e+10            -8.0%  7.852e+10 ±  2%      -8.8%  7.783e+10        perf-stat.i.instructions
      0.96           -22.2%       0.75 ±  2%      -9.4%       0.87            -7.8%       0.89 ±  2%  perf-stat.i.ipc
     13455           -15.4%      11379 ±  3%      -7.6%      12438            -6.7%      12554        perf-stat.i.minor-faults
     13489           -15.5%      11396 ±  3%      -7.6%      12465            -6.6%      12595        perf-stat.i.page-faults
      0.85 ±  3%     +34.8%       1.15           +20.2%       1.02 ±  3%     +17.1%       1.00        perf-stat.overall.MPKI
      0.34            +0.0        0.36 ±  2%      +0.0        0.35            +0.0        0.35        perf-stat.overall.branch-miss-rate%
     13.23 ±  3%      +4.6       17.78            +2.3       15.52 ±  2%      +1.9       15.16        perf-stat.overall.cache-miss-rate%
      1.90           +62.8%       3.08           +20.1%       2.28           +20.9%       2.29        perf-stat.overall.cpi
      2231 ±  3%     +20.6%       2690 ±  2%      -0.2%       2227 ±  2%      +3.2%       2302        perf-stat.overall.cycles-between-cache-misses
      0.53           -38.5%       0.32           -16.7%       0.44           -17.3%       0.44        perf-stat.overall.ipc
  1.86e+10           -23.0%  1.433e+10            -7.6%  1.719e+10            -8.4%  1.704e+10        perf-stat.ps.branch-instructions
  64095803           -19.1%   51843320 ±  2%      -5.7%   60421424            -5.8%   60408153        perf-stat.ps.branch-misses
  71639076 ±  2%      +2.3%   73304464 ±  2%     +10.4%   79092736 ±  3%      +6.6%   76347758 ±  2%  perf-stat.ps.cache-misses
 5.417e+08           -23.9%  4.124e+08            -5.9%  5.096e+08 ±  2%      -7.0%  5.036e+08        perf-stat.ps.cache-references
      8220 ±  4%     +33.3%      10962 ±  4%     +23.9%      10184 ±  8%     +13.9%       9360 ±  5%  perf-stat.ps.context-switches
 1.597e+11           +23.5%  1.972e+11 ±  2%     +10.2%  1.761e+11 ±  2%     +10.0%  1.757e+11        perf-stat.ps.cpu-cycles
    643.07 ±  2%      -4.9%     611.59 ±  2%      -5.6%     607.27 ±  3%      -7.4%     595.33 ±  3%  perf-stat.ps.cpu-migrations
 8.426e+10           -24.1%  6.394e+10            -8.2%  7.737e+10 ±  2%      -9.0%  7.668e+10        perf-stat.ps.instructions
     12730           -18.7%      10354 ±  3%      -7.2%      11811            -6.7%      11877        perf-stat.ps.minor-faults
     12762           -18.8%      10369 ±  3%      -7.3%      11836            -6.6%      11915        perf-stat.ps.page-faults
      4.35 ± 10%      -4.4        0.00            -3.5        0.81 ± 20%      -3.5        0.84 ± 11%  perf-profile.calltrace.cycles-pp.unlink
      4.35 ± 10%      -4.3        0.00            -3.5        0.81 ± 19%      -3.5        0.84 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.35 ± 10%      -4.3        0.00            -3.5        0.81 ± 19%      -3.5        0.84 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      4.34 ± 10%      -4.3        0.00            -3.5        0.80 ± 19%      -3.5        0.84 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.34 ± 10%      -4.3        0.00            -3.5        0.80 ± 20%      -3.5        0.83 ± 11%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.14 ± 10%      -4.1        0.00            -3.5        0.65 ± 24%      -3.5        0.68 ± 13%  perf-profile.calltrace.cycles-pp.down_write.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.14 ± 10%      -4.1        0.00            -3.5        0.65 ± 24%      -3.5        0.68 ± 13%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      4.14 ± 10%      -4.1        0.00            -3.6        0.58 ± 45%      -3.5        0.68 ± 13%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_unlinkat.__x64_sys_unlink
      3.99 ± 11%      -4.0        0.00            -3.6        0.40 ± 83%      -3.4        0.54 ± 40%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_unlinkat
      3.53 ±  6%      -3.4        0.10 ±212%      -2.4        1.12 ± 17%      -2.3        1.22 ±  8%  perf-profile.calltrace.cycles-pp.down_write.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      3.53 ±  6%      -3.4        0.10 ±212%      -2.4        1.12 ± 17%      -2.3        1.22 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat.do_filp_open
      3.52 ±  6%      -3.4        0.10 ±212%      -2.4        1.12 ± 17%      -2.3        1.22 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat
      3.30 ±  7%      -3.3        0.00            -2.3        0.98 ± 19%      -2.2        1.08 ±  9%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups
      3.93 ±  6%      -3.2        0.69 ±  8%      -2.5        1.44 ± 13%      -2.4        1.54 ±  7%  perf-profile.calltrace.cycles-pp.creat64
      3.93 ±  6%      -3.2        0.69 ±  8%      -2.5        1.44 ± 13%      -2.4        1.54 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      3.93 ±  6%      -3.2        0.69 ±  8%      -2.5        1.44 ± 13%      -2.4        1.54 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      3.92 ±  6%      -3.2        0.68 ±  8%      -2.5        1.43 ± 13%      -2.4        1.53 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      3.92 ±  6%      -3.2        0.68 ±  8%      -2.5        1.43 ± 13%      -2.4        1.53 ±  7%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      3.91 ±  6%      -3.2        0.68 ±  8%      -2.5        1.42 ± 13%      -2.4        1.52 ±  7%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64
      3.91 ±  6%      -3.2        0.68 ±  8%      -2.5        1.42 ± 13%      -2.4        1.52 ±  7%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.87 ±  6%      -3.2        0.65 ±  9%      -2.5        1.39 ± 14%      -2.4        1.49 ±  7%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      3.66            -1.7        1.99 ±  2%      -0.6        3.06            -0.7        3.01        perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      3.31            -1.5        1.77 ±  2%      -0.6        2.73            -0.6        2.69        perf-profile.calltrace.cycles-pp.llseek
      2.87            -1.3        1.62 ±  2%      -0.5        2.33            -0.6        2.28        perf-profile.calltrace.cycles-pp.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      2.25            -1.0        1.29 ±  2%      -0.4        1.83            -0.5        1.80        perf-profile.calltrace.cycles-pp.block_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      2.17            -0.9        1.25 ±  2%      -0.4        1.76            -0.4        1.73        perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
      0.86 ±  4%      -0.9        0.00            -0.2        0.62 ±  4%      -0.3        0.61 ±  3%  perf-profile.calltrace.cycles-pp.workingset_age_nonresident.workingset_activation.folio_mark_accessed.filemap_read.vfs_read
      0.79            -0.8        0.00            -0.1        0.74            -0.1        0.72        perf-profile.calltrace.cycles-pp.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.93            -0.8        1.14 ±  2%      -0.3        1.66            -0.3        1.61        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.76            -0.8        0.00            -0.2        0.58            -0.2        0.56 ±  2%  perf-profile.calltrace.cycles-pp.file_modified.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
      1.99            -0.8        1.23 ±  2%      -0.4        1.63            -0.4        1.59        perf-profile.calltrace.cycles-pp.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.74            -0.7        0.00            -0.2        0.58            -0.2        0.57        perf-profile.calltrace.cycles-pp.folio_alloc_noprof.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.79            -0.7        1.07 ±  2%      -0.2        1.55            -0.3        1.50        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
      0.72 ±  2%      -0.7        0.00            -0.2        0.54 ±  4%      -0.2        0.52 ±  3%  perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.69            -0.7        0.00            -0.2        0.54            -0.2        0.53        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_noprof.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.68            -0.7        0.00            -0.2        0.53            -0.2        0.52        perf-profile.calltrace.cycles-pp.touch_atime.filemap_read.vfs_read.ksys_read.do_syscall_64
      1.34            -0.7        0.68 ±  3%      -0.3        1.05            -0.3        1.04        perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.65 ±  2%      -0.7        0.00            -0.1        0.52            -0.1        0.52 ±  2%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      1.30            -0.6        0.66 ±  3%      -0.3        1.02            -0.3        1.00        perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.61            -0.6        0.00            -0.0        0.59            -0.0        0.58        perf-profile.calltrace.cycles-pp.folio_alloc_buffers.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      1.22            -0.6        0.65 ±  2%      -0.2        0.99            -0.2        0.98        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      1.17            -0.5        0.63 ±  2%      -0.2        1.00            -0.2        0.98        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.54 ±  2%      -0.5        0.00            -0.0        0.52            -0.1        0.44 ± 37%  perf-profile.calltrace.cycles-pp.alloc_buffer_head.folio_alloc_buffers.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin
      1.21            -0.5        0.67 ±  2%      -0.3        0.91            -0.3        0.90        perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_write_end.generic_perform_write
      0.96            -0.5        0.43 ± 47%      -0.1        0.83            -0.1        0.81        perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read.ksys_read
      1.08            -0.5        0.57 ±  3%      -0.2        0.86            -0.2        0.84        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      1.08            -0.5        0.57 ±  2%      -0.2        0.88            -0.2        0.86        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      1.20            -0.5        0.70 ±  3%      -0.2        1.02            -0.2        1.00        perf-profile.calltrace.cycles-pp.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.05            -0.5        0.56 ±  2%      -0.2        0.85            -0.2        0.83        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.91            -0.5        0.42 ± 47%      -0.2        0.67            -0.2        0.66        perf-profile.calltrace.cycles-pp.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_write_end
      1.15            -0.5        0.68 ±  2%      -0.2        0.99            -0.2        0.97        perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      1.02            -0.5        0.55 ±  2%      -0.2        0.86            -0.2        0.84        perf-profile.calltrace.cycles-pp.clear_bhb_loop.llseek
      1.30            -0.5        0.83 ±  2%      -0.2        1.05            -0.3        1.03        perf-profile.calltrace.cycles-pp.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict
      0.98            -0.5        0.53 ±  2%      -0.2        0.82            -0.2        0.81        perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      1.10 ±  3%      -0.4        0.67 ±  3%      -0.3        0.80 ±  3%      -0.3        0.79 ±  3%  perf-profile.calltrace.cycles-pp.workingset_activation.folio_mark_accessed.filemap_read.vfs_read.ksys_read
     30.65            -0.4       30.25            +0.7       31.31            +0.7       31.35        perf-profile.calltrace.cycles-pp.read
      0.98            -0.3        0.69 ±  2%      -0.4        0.61            -0.4        0.59        perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      2.39            +0.2        2.61            +0.1        2.47            +0.1        2.50        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
      2.42            +0.2        2.64            +0.1        2.50            +0.1        2.53        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      2.39            +0.2        2.61            +0.1        2.48            +0.1        2.50        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range
      2.42            +0.2        2.64            +0.1        2.50            +0.1        2.53        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      2.38            +0.2        2.61            +0.1        2.47            +0.1        2.50        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      2.44            +0.4        2.89            +0.2        2.62            +0.2        2.63        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      2.38            +0.5        2.84            +0.2        2.56            +0.2        2.58        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      2.38            +0.5        2.84            +0.2        2.56            +0.2        2.58        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range
      2.38            +0.5        2.84            +0.2        2.56            +0.2        2.57        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release
     28.52            +0.6       29.11            +1.0       29.54            +1.1       29.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     28.38            +0.7       29.04            +1.0       29.42            +1.1       29.49        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.86            +0.7        5.54            +0.3        5.13            +0.3        5.16        perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
     27.89            +0.9       28.77            +1.1       29.02            +1.2       29.09        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     27.47            +1.1       28.54            +1.2       28.67            +1.3       28.75        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     25.90            +1.9       27.78            +1.5       27.42            +1.6       27.54        perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.26            +4.0       34.31            +3.9       34.16            +3.8       34.05        perf-profile.calltrace.cycles-pp.write
     21.06            +4.1       25.14            +2.3       23.39            +2.5       23.59        perf-profile.calltrace.cycles-pp.folio_mark_accessed.filemap_read.vfs_read.ksys_read.do_syscall_64
     19.70            +4.6       24.33            +2.7       22.38            +2.9       22.60        perf-profile.calltrace.cycles-pp.folio_activate.folio_mark_accessed.filemap_read.vfs_read.ksys_read
     19.63            +4.7       24.29            +2.7       22.32            +2.9       22.54        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_activate.folio_mark_accessed.filemap_read.vfs_read
     18.85            +4.7       23.52            +2.7       21.52            +2.9       21.74        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed.filemap_read
     18.84            +4.7       23.51            +2.7       21.52            +2.9       21.73        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed
     18.83            +4.7       23.51            +2.7       21.51            +2.9       21.73        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate
     28.38            +5.0       33.33            +4.3       32.65            +4.2       32.56        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     28.23            +5.0       33.25            +4.3       32.53            +4.2       32.45        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     27.72            +5.3       32.99            +4.4       32.13            +4.3       32.05        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     27.25            +5.5       32.74            +4.5       31.75            +4.4       31.68        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     25.87            +5.6       31.48            +2.2       28.03            +2.2       28.02        perf-profile.calltrace.cycles-pp.__close
     25.86            +5.6       31.46            +2.2       28.01            +2.2       28.01        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.86            +5.6       31.47            +2.2       28.02            +2.2       28.02        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.86            +5.6       31.47            +2.2       28.02            +2.2       28.02        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     25.84            +5.6       31.45            +2.2       28.00            +2.2       28.00        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.82            +5.6       31.44            +2.2       27.99            +2.2       27.98        perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.81            +5.6       31.44            +2.2       27.98            +2.2       27.98        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.__x64_sys_close.do_syscall_64
     25.79            +5.6       31.43            +2.2       27.96            +2.2       27.96        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.__x64_sys_close
     25.78            +5.6       31.42            +2.2       27.95            +2.2       27.95        perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dput.__fput
     25.63            +5.7       31.33            +2.2       27.83            +2.2       27.83        perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dput
     17.98            +6.1       24.07            +2.4       20.42            +2.5       20.43        perf-profile.calltrace.cycles-pp.folios_put_refs.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
     17.57            +6.2       23.81            +2.5       20.06            +2.5       20.08        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.truncate_inode_pages_range.ext4_evict_inode.evict
     17.33            +6.3       23.66            +2.5       19.86            +2.5       19.88        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.truncate_inode_pages_range
     17.34            +6.3       23.66            +2.5       19.86            +2.5       19.88        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.truncate_inode_pages_range.ext4_evict_inode
     17.32            +6.3       23.65            +2.5       19.85            +2.6       19.87        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     25.47            +6.5       31.92            +4.9       30.41            +4.9       30.37        perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.72 ±  2%      +7.3       31.06            +5.3       29.06            +5.3       29.04        perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
     17.89 ±  3%     +10.1       27.95            +6.5       24.39            +6.6       24.46        perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
     13.68 ±  4%     +12.1       25.73            +7.3       20.95            +7.4       21.07        perf-profile.calltrace.cycles-pp.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
     11.76 ±  5%     +13.0       24.76            +7.7       19.42            +7.8       19.56        perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      9.80 ±  6%     +13.4       23.16            +8.1       17.87            +8.2       18.03        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio
      9.81 ±  6%     +13.4       23.17            +8.1       17.87            +8.2       18.04        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio
      9.79 ±  6%     +13.4       23.16            +8.1       17.86            +8.2       18.02        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     10.38 ±  6%     +13.5       23.85            +8.1       18.48            +8.3       18.65        perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
     10.32 ±  6%     +13.5       23.82            +8.1       18.43            +8.3       18.60        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
      8.04 ±  8%      -7.2        0.84 ±  9%      -6.0        2.06 ± 17%      -5.8        2.20 ±  9%  perf-profile.children.cycles-pp.down_write
      7.67 ±  8%      -7.0        0.65 ± 12%      -5.9        1.77 ± 19%      -5.8        1.91 ± 10%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      7.66 ±  8%      -7.0        0.64 ± 12%      -5.9        1.76 ± 19%      -5.8        1.90 ± 10%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      7.28 ±  9%      -6.8        0.53 ± 14%      -5.7        1.54 ± 21%      -5.6        1.68 ± 11%  perf-profile.children.cycles-pp.osq_lock
      4.35 ± 10%      -4.1        0.30 ±  8%      -3.5        0.81 ± 19%      -3.5        0.84 ± 11%  perf-profile.children.cycles-pp.unlink
      4.34 ± 10%      -4.0        0.29 ±  8%      -3.5        0.80 ± 19%      -3.5        0.84 ± 11%  perf-profile.children.cycles-pp.__x64_sys_unlink
      4.34 ± 10%      -4.0        0.29 ±  8%      -3.5        0.80 ± 20%      -3.5        0.83 ± 11%  perf-profile.children.cycles-pp.do_unlinkat
      3.97 ±  6%      -3.3        0.71 ±  8%      -2.5        1.47 ± 13%      -2.4        1.57 ±  7%  perf-profile.children.cycles-pp.do_sys_openat2
      3.95 ±  6%      -3.2        0.70 ±  8%      -2.5        1.45 ± 13%      -2.4        1.55 ±  7%  perf-profile.children.cycles-pp.path_openat
      3.95 ±  6%      -3.2        0.70 ±  8%      -2.5        1.45 ± 13%      -2.4        1.55 ±  7%  perf-profile.children.cycles-pp.do_filp_open
      3.93 ±  6%      -3.2        0.69 ±  8%      -2.5        1.44 ± 13%      -2.4        1.54 ±  7%  perf-profile.children.cycles-pp.creat64
      3.92 ±  6%      -3.2        0.68 ±  8%      -2.5        1.43 ± 13%      -2.4        1.53 ±  7%  perf-profile.children.cycles-pp.__x64_sys_creat
      3.87 ±  6%      -3.2        0.66 ±  8%      -2.5        1.39 ± 14%      -2.4        1.49 ±  7%  perf-profile.children.cycles-pp.open_last_lookups
      3.70            -1.7        1.98 ±  2%      -0.7        3.05            -0.7        3.01        perf-profile.children.cycles-pp.llseek
      3.68            -1.7        2.00 ±  2%      -0.6        3.08            -0.7        3.03        perf-profile.children.cycles-pp.ext4_block_write_begin
      3.12            -1.4        1.67 ±  2%      -0.5        2.57            -0.6        2.53        perf-profile.children.cycles-pp.clear_bhb_loop
      2.90            -1.3        1.64 ±  2%      -0.5        2.36            -0.6        2.31        perf-profile.children.cycles-pp.ext4_da_write_end
      2.29            -1.0        1.31 ±  2%      -0.4        1.85            -0.5        1.82        perf-profile.children.cycles-pp.block_write_end
      2.20            -0.9        1.26 ±  2%      -0.4        1.78            -0.4        1.75        perf-profile.children.cycles-pp.__block_commit_write
      1.95            -0.8        1.15 ±  2%      -0.3        1.68            -0.3        1.63        perf-profile.children.cycles-pp.copy_page_to_iter
      1.99            -0.8        1.24 ±  2%      -0.4        1.64            -0.4        1.59        perf-profile.children.cycles-pp.truncate_cleanup_folio
      1.80            -0.7        1.08 ±  2%      -0.2        1.56            -0.3        1.51        perf-profile.children.cycles-pp._copy_to_iter
      1.54            -0.7        0.82 ±  2%      -0.3        1.27            -0.3        1.25        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.34            -0.7        0.68 ±  3%      -0.3        1.06            -0.3        1.04        perf-profile.children.cycles-pp.ext4_da_get_block_prep
      1.32            -0.7        0.67 ±  3%      -0.3        1.04            -0.3        1.02        perf-profile.children.cycles-pp.ext4_da_map_blocks
     31.04            -0.6       30.46            +0.6       31.63            +0.6       31.66        perf-profile.children.cycles-pp.read
      1.19            -0.6        0.64 ±  2%      -0.2        1.01            -0.2        1.00        perf-profile.children.cycles-pp.filemap_get_pages
      1.18            -0.5        0.63 ±  2%      -0.2        0.97            -0.2        0.96        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.22            -0.5        0.68 ±  2%      -0.3        0.92            -0.3        0.90        perf-profile.children.cycles-pp.mark_buffer_dirty
      1.20            -0.5        0.70 ±  2%      -0.2        1.02            -0.2        1.00        perf-profile.children.cycles-pp.zero_user_segments
      1.20            -0.5        0.71 ±  2%      -0.2        1.03            -0.2        1.01        perf-profile.children.cycles-pp.memset_orig
      1.07            -0.5        0.58 ±  2%      -0.2        0.87            -0.2        0.85        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.95            -0.5        0.46 ±  3%      -0.2        0.78 ±  4%      -0.2        0.74 ±  2%  perf-profile.children.cycles-pp.rw_verify_area
      1.32            -0.5        0.84 ±  2%      -0.3        1.06            -0.3        1.04        perf-profile.children.cycles-pp.try_to_free_buffers
      0.98            -0.5        0.53 ±  2%      -0.1        0.85            -0.1        0.84        perf-profile.children.cycles-pp.filemap_get_read_batch
      0.98 ±  2%      -0.4        0.53 ±  3%      -0.2        0.80            -0.2        0.79        perf-profile.children.cycles-pp.__fdget_pos
      0.77 ±  2%      -0.4        0.34 ±  3%      -0.2        0.58 ±  4%      -0.2        0.56 ±  3%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      1.10 ±  3%      -0.4        0.67 ±  3%      -0.3        0.80 ±  3%      -0.3        0.79 ±  2%  perf-profile.children.cycles-pp.workingset_activation
      0.80            -0.4        0.37 ±  2%      -0.2        0.60            -0.2        0.59 ±  2%  perf-profile.children.cycles-pp.file_modified
      0.86 ±  4%      -0.4        0.46 ±  3%      -0.2        0.62 ±  3%      -0.2        0.61 ±  3%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.77 ±  2%      -0.4        0.37 ±  3%      -0.1        0.64 ±  5%      -0.2        0.60 ±  2%  perf-profile.children.cycles-pp.security_file_permission
      0.92            -0.4        0.52 ±  2%      -0.2        0.68            -0.2        0.67        perf-profile.children.cycles-pp.__folio_mark_dirty
      0.80            -0.4        0.42 ±  2%      -0.1        0.65            -0.2        0.64        perf-profile.children.cycles-pp.xas_load
      0.74            -0.4        0.37 ±  3%      -0.2        0.58            -0.2        0.57        perf-profile.children.cycles-pp.folio_alloc_noprof
      0.70            -0.4        0.33 ±  3%      -0.2        0.54            -0.2        0.54        perf-profile.children.cycles-pp.touch_atime
      0.60 ±  2%      -0.4        0.24 ±  4%      -0.2        0.42            -0.2        0.42 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.71            -0.4        0.35 ±  3%      -0.2        0.55            -0.2        0.54        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.80            -0.4        0.45 ±  2%      -0.1        0.74            -0.1        0.72        perf-profile.children.cycles-pp.create_empty_buffers
      0.68 ±  2%      -0.3        0.36 ±  3%      -0.1        0.54            -0.1        0.55 ±  2%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.62            -0.3        0.30 ±  3%      -0.1        0.48            -0.1        0.48        perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.59 ±  2%      -0.3        0.28 ±  3%      -0.1        0.48 ±  7%      -0.1        0.45 ±  2%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.62            -0.3        0.32 ±  3%      -0.1        0.49 ±  2%      -0.1        0.49        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.64            -0.3        0.34 ±  3%      -0.1        0.52            -0.1        0.52        perf-profile.children.cycles-pp.ksys_lseek
      1.01            -0.3        0.71 ±  2%      -0.4        0.62            -0.4        0.61        perf-profile.children.cycles-pp.__filemap_add_folio
      0.62            -0.3        0.32 ±  3%      -0.1        0.51            -0.1        0.50        perf-profile.children.cycles-pp.filemap_get_entry
      0.57            -0.3        0.28 ±  3%      -0.1        0.45            -0.1        0.44        perf-profile.children.cycles-pp.atime_needs_update
      0.69            -0.3        0.40 ±  2%      -0.2        0.50            -0.2        0.48        perf-profile.children.cycles-pp.folio_account_dirtied
      0.61            -0.3        0.32 ±  2%      -0.1        0.50 ±  3%      -0.1        0.49 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.60 ±  2%      -0.3        0.32 ±  3%      -0.1        0.48            -0.1        0.48 ±  2%  perf-profile.children.cycles-pp.fault_in_readable
      0.62            -0.3        0.35 ±  2%      -0.0        0.59            -0.0        0.58        perf-profile.children.cycles-pp.folio_alloc_buffers
      0.58            -0.3        0.32 ±  2%      -0.1        0.48            -0.1        0.47        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.37 ±  3%      -0.3        0.11 ±  4%      -0.2        0.22 ±  6%      -0.2        0.22 ±  3%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.40 ±  6%      -0.3        0.14 ±  3%      -0.1        0.26 ±  5%      -0.1        0.25 ±  6%  perf-profile.children.cycles-pp.ext4_file_write_iter
      0.51 ±  3%      -0.2        0.27 ±  3%      -0.1        0.40 ±  2%      -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.disk_rr
      0.59            -0.2        0.34 ±  2%      -0.1        0.49            -0.1        0.47        perf-profile.children.cycles-pp.kmem_cache_free
      0.46            -0.2        0.22 ±  2%      -0.1        0.36            -0.1        0.35        perf-profile.children.cycles-pp.get_page_from_freelist
      0.55 ±  2%      -0.2        0.31 ±  3%      -0.0        0.52            -0.0        0.51        perf-profile.children.cycles-pp.alloc_buffer_head
      0.53            -0.2        0.30 ±  2%      -0.0        0.51            -0.0        0.50        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.36 ±  3%      -0.2        0.14 ±  4%      -0.1        0.25 ±  2%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.36 ±  6%      -0.2        0.14 ±  5%      -0.1        0.25 ±  4%      -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.ext4_file_read_iter
      0.40            -0.2        0.20 ±  2%      -0.1        0.33 ±  2%      -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.44            -0.2        0.25 ±  3%      -0.1        0.34            -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.39            -0.2        0.19 ±  3%      -0.1        0.31 ±  3%      -0.1        0.30        perf-profile.children.cycles-pp.inode_needs_update_time
      0.52            -0.2        0.33 ±  2%      -0.1        0.42            -0.1        0.42        perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.29 ±  4%      -0.2        0.10 ±  6%      -0.1        0.19 ±  3%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.generic_update_time
      0.36 ±  2%      -0.2        0.18 ±  4%      -0.1        0.28            -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.57 ±  2%      -0.2        0.40 ±  3%      -0.1        0.44            -0.1        0.44        perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.34 ±  2%      -0.2        0.18 ±  3%      -0.1        0.29 ±  2%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.25 ±  4%      -0.2        0.09 ±  5%      -0.1        0.16 ±  4%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.ext4_dirty_inode
      0.33            -0.2        0.17 ±  2%      -0.1        0.25            -0.1        0.25        perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.34            -0.2        0.18 ±  2%      -0.1        0.27 ±  2%      -0.1        0.26        perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.22 ±  5%      -0.2        0.06 ±  9%      -0.1        0.13 ±  3%      -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.jbd2__journal_start
      0.21 ±  5%      -0.2        0.06 ±  8%      -0.1        0.12 ±  5%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.start_this_handle
      0.31            -0.1        0.17 ±  3%      -0.1        0.25 ±  2%      -0.1        0.24 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.40            -0.1        0.25 ±  2%      -0.1        0.30 ±  2%      -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.30 ±  2%      -0.1        0.17 ±  3%      -0.0        0.30 ±  3%      -0.0        0.29        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.31 ±  2%      -0.1        0.18 ±  2%      -0.1        0.26 ±  2%      -0.1        0.26        perf-profile.children.cycles-pp.block_invalidate_folio
      0.29 ±  2%      -0.1        0.16 ±  2%      -0.0        0.24 ±  2%      -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.x64_sys_call
      0.49            -0.1        0.36 ±  3%      -0.1        0.38            -0.1        0.37        perf-profile.children.cycles-pp.folio_account_cleaned
      0.32            -0.1        0.19 ±  2%      -0.1        0.25 ±  2%      -0.1        0.25        perf-profile.children.cycles-pp.lookup_open
      0.27            -0.1        0.14 ±  2%      -0.1        0.22 ±  2%      -0.1        0.21        perf-profile.children.cycles-pp.generic_write_checks
      0.26 ±  3%      -0.1        0.13 ±  3%      -0.1        0.21 ±  3%      -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.26 ±  2%      -0.1        0.13 ±  4%      -0.1        0.20            -0.1        0.20        perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.27 ±  2%      -0.1        0.14 ±  4%      -0.1        0.22 ±  2%      -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.up_write
      0.27            -0.1        0.14 ±  3%      -0.0        0.22            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.xas_start
      0.35 ±  2%      -0.1        0.22            -0.1        0.27 ±  2%      -0.1        0.27 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.17 ±  4%      -0.1        0.06 ±  6%      -0.1        0.12 ±  4%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.ext4_nonda_switch
      0.23            -0.1        0.12 ±  3%      -0.0        0.18            -0.0        0.18        perf-profile.children.cycles-pp.folio_unlock
      0.22 ±  2%      -0.1        0.12 ±  3%      -0.0        0.18 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.current_time
      0.27            -0.1        0.16 ±  3%      -0.0        0.23 ±  2%      -0.0        0.22        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.27 ±  2%      -0.1        0.17 ±  3%      -0.1        0.20 ±  2%      -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.18            -0.1        0.08 ±  5%      -0.0        0.14 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.node_dirty_ok
      0.21 ±  2%      -0.1        0.12 ±  4%      -0.0        0.17            -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.26 ±  3%      -0.1        0.16 ±  2%      -0.1        0.20 ±  2%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.93 ±  2%      -0.1        0.84 ±  3%      -0.2        0.72 ±  2%      -0.2        0.70        perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.18 ±  2%      -0.1        0.09 ±  3%      -0.0        0.15 ±  3%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.19 ±  2%      -0.1        0.10 ±  5%      -0.0        0.14 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.aa_file_perm
      0.20            -0.1        0.11 ±  2%      -0.0        0.16 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.21            -0.1        0.12 ±  2%      -0.0        0.16 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.ext4_create
      0.18            -0.1        0.09 ±  4%      -0.0        0.14            -0.0        0.14        perf-profile.children.cycles-pp.rmqueue
      0.20 ±  2%      -0.1        0.12 ±  4%      -0.0        0.17            -0.0        0.17        perf-profile.children.cycles-pp.find_lock_entries
      0.17 ±  5%      -0.1        0.08 ±  5%      -0.0        0.14 ±  7%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.19 ±  2%      -0.1        0.10 ±  4%      -0.0        0.15 ±  3%      -0.0        0.15        perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.17            -0.1        0.09 ±  4%      -0.0        0.13 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.08            -0.1        0.00            -0.0        0.06 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.__mod_zone_page_state
      0.08 ±  5%      -0.1        0.00 ±316%      -0.0        0.06 ± 10%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.write@plt
      0.21 ±  2%      -0.1        0.13 ±  3%      -0.1        0.16            -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.08 ±  5%      -0.1        0.00            -0.0        0.06 ±  7%      -0.0        0.06 ±  5%  perf-profile.children.cycles-pp._raw_read_lock
      0.08 ±  5%      -0.1        0.00            -0.0        0.06            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.rcu_core
      0.17            -0.1        0.09 ±  4%      -0.0        0.14 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.free_unref_folios
      0.09 ±  3%      -0.1        0.01 ±163%      -0.0        0.07 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.generic_file_llseek_size
      0.08 ±  6%      -0.1        0.00            -0.0        0.06 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.rcu_do_batch
      0.20 ±  3%      -0.1        0.13 ±  3%      -0.0        0.15 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.16 ±  2%      -0.1        0.09 ±  4%      -0.0        0.13 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.vfs_unlink
      0.08 ±  4%      -0.1        0.00 ±316%      -0.0        0.06 ±  5%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.xas_create
      0.09 ±  5%      -0.1        0.01 ±163%      -0.0        0.07 ±  4%      -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.generic_file_read_iter
      0.19            -0.1        0.12 ±  4%      -0.0        0.16 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.14 ±  3%      -0.1        0.07 ±  6%      -0.0        0.11 ±  4%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__es_insert_extent
      0.16 ±  3%      -0.1        0.08 ±  5%      -0.0        0.12 ±  2%      -0.0        0.12 ±  2%  perf-profile.children.cycles-pp.__ext4_unlink
      0.14 ±  2%      -0.1        0.07            -0.0        0.11            -0.0        0.11        perf-profile.children.cycles-pp.__radix_tree_lookup
      0.14 ±  4%      -0.1        0.07            -0.0        0.11 ±  2%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__count_memcg_events
      0.07 ±  4%      -0.1        0.00            -0.0        0.06 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.__es_remove_extent
      0.07 ±  4%      -0.1        0.00            -0.0        0.06 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.read@plt
      0.16 ±  3%      -0.1        0.09 ±  5%      -0.0        0.12 ±  2%      -0.0        0.12 ±  2%  perf-profile.children.cycles-pp.ext4_unlink
      0.08 ±  6%      -0.1        0.00 ±316%      -0.0        0.06 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.xas_clear_mark
      0.08 ±  5%      -0.1        0.01 ±163%      -0.0        0.07 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.folio_mapping
      0.07            -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.children.cycles-pp.node_page_state
      0.07            -0.1        0.00            -0.0        0.06            -0.0        0.06        perf-profile.children.cycles-pp.ext4_fill_raw_inode
      0.18 ±  2%      -0.1        0.12 ±  4%      -0.0        0.14            -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.15 ±  3%      -0.1        0.08 ±  3%      -0.0        0.12 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.jbd2_journal_try_to_free_buffers
      0.12 ±  5%      -0.1        0.05 ±  8%      -0.0        0.09 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.ext4_claim_free_clusters
      0.07 ±  7%      -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.children.cycles-pp.folio_wait_stable
      0.07 ±  7%      -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.children.cycles-pp.free_unref_page_commit
      0.06 ±  7%      -0.1        0.00            -0.0        0.05 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.balance_dirty_pages
      0.13            -0.1        0.07 ±  7%      -0.0        0.10 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.12 ±  4%      -0.1        0.06 ±  7%      -0.0        0.10            -0.0        0.10        perf-profile.children.cycles-pp.__xa_set_mark
      0.12 ±  2%      -0.1        0.06            -0.0        0.10 ±  5%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.file_remove_privs_flags
      0.13 ±  3%      -0.1        0.07 ±  7%      -0.0        0.10 ±  3%      -0.0        0.10        perf-profile.children.cycles-pp.ext4_llseek
      0.07            -0.1        0.01 ±212%      -0.0        0.06 ±  9%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.06            -0.1        0.00            -0.0        0.04 ± 37%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.add_dirent_to_buf
      0.06            -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.children.cycles-pp._raw_spin_trylock
      0.06            -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.children.cycles-pp.bdev_getblk
      0.06            -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.15 ±  2%      -0.1        0.09 ±  4%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      0.12            -0.1        0.06 ±  6%      -0.0        0.10 ±  4%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.amd_clear_divider
      0.12 ±  2%      -0.1        0.06 ±  6%      -0.0        0.09 ±  5%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.jbd2_journal_grab_journal_head
      0.11 ±  5%      -0.1        0.06 ±  6%      -0.0        0.09 ±  5%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.inode_to_bdi
      0.09 ±  5%      -0.1        0.04 ± 47%      -0.0        0.07            -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.handle_softirqs
      0.50            -0.1        0.45 ±  3%      +0.0        0.55            +0.1        0.56        perf-profile.children.cycles-pp.folio_activate_fn
      0.11 ±  2%      -0.1        0.06            -0.0        0.09            -0.0        0.09        perf-profile.children.cycles-pp.__ext4_new_inode
      0.12 ±  2%      -0.1        0.07            -0.0        0.10            -0.0        0.10        perf-profile.children.cycles-pp.try_charge_memcg
      0.11 ±  4%      -0.1        0.06 ±  4%      -0.0        0.09 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.timestamp_truncate
      0.12 ±  3%      -0.1        0.07 ±  6%      -0.0        0.10 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12 ±  3%      -0.1        0.07 ±  6%      -0.0        0.10 ±  3%      -0.0        0.10        perf-profile.children.cycles-pp.drop_buffers
      0.13 ±  3%      -0.0        0.08 ±  3%      -0.0        0.10 ±  3%      -0.0        0.10        perf-profile.children.cycles-pp.__ext4_find_entry
      0.11 ±  3%      -0.0        0.06 ±  6%      -0.0        0.09 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      0.12 ±  8%      -0.0        0.08 ±  6%      +0.1        0.20 ±  3%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.12            -0.0        0.08 ±  5%      -0.0        0.10 ±  5%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.ext4_dx_find_entry
      0.13 ±  3%      -0.0        0.09            -0.0        0.11 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.sched_tick
      0.10 ±  4%      -0.0        0.06 ±  7%      -0.0        0.08 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.ext4_do_update_inode
      0.09            -0.0        0.05            -0.0        0.07            -0.0        0.07        perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.08 ±  4%      -0.0        0.04 ± 47%      -0.0        0.06 ±  7%      -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      0.17            -0.0        0.13 ±  3%      -0.0        0.13 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.09 ±  4%      -0.0        0.05 ±  9%      -0.0        0.07 ±  4%      -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.ext4_lookup
      0.09 ±  4%      -0.0        0.06            -0.0        0.07            -0.0        0.07        perf-profile.children.cycles-pp.task_tick_fair
      0.09 ±  3%      -0.0        0.06 ±  8%      -0.0        0.07            -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.ext4_add_nondir
      0.24 ±  2%      -0.0        0.22 ±  2%      -0.2        0.06            -0.2        0.06        perf-profile.children.cycles-pp.xas_find_conflict
      0.08 ±  4%      -0.0        0.05            -0.0        0.06            -0.0        0.06        perf-profile.children.cycles-pp.ext4_add_entry
      0.08 ±  5%      -0.0        0.05            -0.0        0.06            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.ext4_dx_add_entry
      0.13 ±  3%      -0.0        0.11 ±  5%      -0.0        0.11            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.07            -0.0        0.05 ± 31%      -0.0        0.05 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.ext4_search_dir
      0.26 ±  3%      -0.0        0.24 ±  8%      +0.1        0.36 ±  4%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.26 ±  3%      -0.0        0.24 ±  8%      +0.1        0.36 ±  4%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.do_group_exit
      0.26 ±  3%      -0.0        0.24 ±  9%      +0.1        0.36 ±  3%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.do_exit
      0.24 ±  4%      -0.0        0.24 ±  8%      +0.1        0.35 ±  4%      +0.1        0.34 ±  5%  perf-profile.children.cycles-pp.exit_mm
      0.25 ±  3%      -0.0        0.25 ±  8%      +0.1        0.35 ±  4%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.__mmput
      0.25 ±  3%      -0.0        0.25 ±  8%      +0.1        0.35 ±  4%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.exit_mmap
      0.20 ±  3%      +0.0        0.22 ±  9%      +0.1        0.30 ±  4%      +0.1        0.30 ±  5%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.20 ±  3%      +0.0        0.22 ±  9%      +0.1        0.30 ±  4%      +0.1        0.30 ±  5%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.20 ±  3%      +0.0        0.22 ±  9%      +0.1        0.31 ±  4%      +0.1        0.30 ±  5%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.34 ±  2%      +0.0        0.37            -0.0        0.32            -0.0        0.31        perf-profile.children.cycles-pp.lru_add_fn
      0.00            +0.1        0.05 ±  5%      +0.1        0.05            +0.1        0.05        perf-profile.children.cycles-pp.lru_add_drain
      0.08 ±  5%      +0.1        0.15 ±  4%      +0.0        0.11            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__cmd_record
      0.08 ±  5%      +0.1        0.15 ±  4%      +0.0        0.11            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.cmd_record
      0.08 ±  4%      +0.1        0.14 ±  4%      +0.0        0.10 ±  4%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.09 ±  3%      +0.1        0.15 ±  4%      +0.0        0.11 ±  2%      +0.0        0.11 ±  2%  perf-profile.children.cycles-pp.main
      0.09 ±  3%      +0.1        0.15 ±  4%      +0.0        0.11 ±  2%      +0.0        0.11 ±  2%  perf-profile.children.cycles-pp.run_builtin
      0.08 ±  6%      +0.1        0.14 ±  4%      +0.0        0.10            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.perf_mmap__push
      0.07 ±  4%      +0.1        0.13 ±  3%      +0.0        0.09 ±  3%      +0.0        0.09 ±  3%  perf-profile.children.cycles-pp.record__pushfn
      0.07 ±  4%      +0.1        0.13 ±  3%      +0.0        0.09 ±  3%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.writen
      0.06            +0.1        0.13 ±  5%      +0.0        0.09 ±  4%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.00            +0.1        0.10 ±  4%      +0.1        0.06 ±  6%      +0.1        0.06 ±  5%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.00            +0.1        0.11 ±  6%      +0.1        0.07 ±  7%      +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.00            +0.1        0.11 ±  6%      +0.1        0.07 ±  7%      +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.shmem_write_begin
      2.45            +0.2        2.70            +0.1        2.55            +0.1        2.58        perf-profile.children.cycles-pp.lru_add_drain_cpu
      4.86            +0.7        5.54            +0.3        5.13            +0.3        5.16        perf-profile.children.cycles-pp.__folio_batch_release
     27.93            +0.9       28.79            +1.1       29.05            +1.2       29.12        perf-profile.children.cycles-pp.ksys_read
     27.50            +1.1       28.56            +1.2       28.70            +1.3       28.77        perf-profile.children.cycles-pp.vfs_read
     25.97            +1.8       27.81            +1.5       27.48            +1.6       27.59        perf-profile.children.cycles-pp.filemap_read
     92.83            +3.3       96.09            +1.3       94.11            +1.4       94.19        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     92.42            +3.5       95.88            +1.4       93.79            +1.5       93.87        perf-profile.children.cycles-pp.do_syscall_64
     30.73            +3.9       34.66            +3.8       34.58            +3.7       34.46        perf-profile.children.cycles-pp.write
     21.08            +4.1       25.15            +2.3       23.40            +2.5       23.61        perf-profile.children.cycles-pp.folio_mark_accessed
     19.70            +4.6       24.33            +2.7       22.38            +2.9       22.60        perf-profile.children.cycles-pp.folio_activate
     27.83            +5.3       33.14            +4.4       32.25            +4.3       32.17        perf-profile.children.cycles-pp.ksys_write
     27.36            +5.5       32.89            +4.5       31.87            +4.4       31.80        perf-profile.children.cycles-pp.vfs_write
     25.87            +5.6       31.48            +2.2       28.03            +2.2       28.03        perf-profile.children.cycles-pp.__close
     25.86            +5.6       31.46            +2.2       28.01            +2.2       28.01        perf-profile.children.cycles-pp.__x64_sys_close
     25.84            +5.6       31.46            +2.2       28.00            +2.2       28.00        perf-profile.children.cycles-pp.__fput
     25.83            +5.6       31.45            +2.2       27.99            +2.2       27.99        perf-profile.children.cycles-pp.dput
     25.82            +5.6       31.44            +2.2       27.98            +2.2       27.98        perf-profile.children.cycles-pp.__dentry_kill
     25.79            +5.6       31.43            +2.2       27.96            +2.2       27.96        perf-profile.children.cycles-pp.evict
     25.78            +5.6       31.42            +2.2       27.95            +2.2       27.95        perf-profile.children.cycles-pp.ext4_evict_inode
     25.64            +5.7       31.34            +2.2       27.83            +2.2       27.83        perf-profile.children.cycles-pp.truncate_inode_pages_range
     18.31            +6.0       24.35            +2.5       20.82            +2.5       20.84        perf-profile.children.cycles-pp.folios_put_refs
     17.78            +6.3       24.04            +2.6       20.37            +2.6       20.39        perf-profile.children.cycles-pp.__page_cache_release
     25.54            +6.4       31.96            +4.9       30.47            +4.9       30.43        perf-profile.children.cycles-pp.ext4_buffered_write_iter
     23.87 ±  2%      +7.4       31.23            +5.3       29.21            +5.3       29.20        perf-profile.children.cycles-pp.generic_perform_write
     17.93 ±  3%     +10.0       27.97            +6.5       24.43            +6.6       24.49        perf-profile.children.cycles-pp.ext4_da_write_begin
     13.75 ±  4%     +12.0       25.77            +7.3       21.00            +7.4       21.12        perf-profile.children.cycles-pp.__filemap_get_folio
     11.78 ±  5%     +13.0       24.77            +7.7       19.43            +7.8       19.57        perf-profile.children.cycles-pp.filemap_add_folio
     10.41 ±  6%     +13.5       23.96            +8.1       18.54            +8.3       18.71        perf-profile.children.cycles-pp.folio_add_lru
     34.89 ±  2%     +18.9       53.82           +11.1       46.00           +11.5       46.42        perf-profile.children.cycles-pp.folio_batch_move_lru
     51.11           +25.1       76.23           +13.7       64.78           +14.1       65.22        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     51.02           +25.2       76.18           +13.7       64.70           +14.1       65.14        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     50.98           +25.3       76.24           +13.7       64.69           +14.2       65.15        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      7.25 ±  9%      -6.7        0.53 ± 14%      -5.7        1.54 ± 21%      -5.6        1.67 ± 11%  perf-profile.self.cycles-pp.osq_lock
      3.09            -1.4        1.65 ±  2%      -0.5        2.55            -0.6        2.50        perf-profile.self.cycles-pp.clear_bhb_loop
      1.79            -0.7        1.07 ±  2%      -0.2        1.54            -0.3        1.50        perf-profile.self.cycles-pp._copy_to_iter
      1.14            -0.5        0.61 ±  2%      -0.2        0.94            -0.2        0.92        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.20            -0.5        0.70 ±  2%      -0.2        1.02            -0.2        1.00        perf-profile.self.cycles-pp.memset_orig
      1.06            -0.5        0.57 ±  2%      -0.2        0.86            -0.2        0.84        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.97            -0.5        0.51 ±  2%      -0.2        0.79            -0.2        0.78        perf-profile.self.cycles-pp.filemap_read
      0.94 ±  2%      -0.4        0.51 ±  3%      -0.2        0.78            -0.2        0.76        perf-profile.self.cycles-pp.__fdget_pos
      0.86 ±  4%      -0.4        0.45 ±  3%      -0.2        0.62 ±  4%      -0.2        0.61 ±  3%  perf-profile.self.cycles-pp.workingset_age_nonresident
      0.75 ±  2%      -0.4        0.38 ±  3%      -0.2        0.59            -0.2        0.58 ±  2%  perf-profile.self.cycles-pp.vfs_write
      0.89            -0.3        0.55 ±  2%      -0.1        0.80            -0.1        0.78        perf-profile.self.cycles-pp.__block_commit_write
      0.54 ±  3%      -0.3        0.21 ±  4%      -0.2        0.38            -0.2        0.37 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.50 ±  3%      -0.3        0.20 ±  3%      -0.1        0.37 ±  6%      -0.1        0.35 ±  5%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.63            -0.3        0.33 ±  2%      -0.1        0.52            -0.1        0.51        perf-profile.self.cycles-pp.vfs_read
      0.57            -0.3        0.29 ±  2%      -0.1        0.46            -0.1        0.45        perf-profile.self.cycles-pp.do_syscall_64
      0.61            -0.3        0.33 ±  2%      -0.1        0.54            -0.1        0.53        perf-profile.self.cycles-pp.filemap_get_read_batch
      0.58 ±  2%      -0.3        0.31 ±  3%      -0.1        0.46            -0.1        0.47 ±  3%  perf-profile.self.cycles-pp.fault_in_readable
      0.37 ±  3%      -0.3        0.10 ±  4%      -0.2        0.22 ±  6%      -0.2        0.22 ±  3%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.56            -0.3        0.29 ±  3%      -0.1        0.45 ±  2%      -0.1        0.45        perf-profile.self.cycles-pp.xas_load
      0.38 ±  6%      -0.3        0.13 ±  4%      -0.1        0.25 ±  6%      -0.1        0.24 ±  6%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.48 ±  2%      -0.2        0.24 ±  4%      -0.1        0.37 ±  2%      -0.1        0.37        perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.35 ±  5%      -0.2        0.13 ±  5%      -0.1        0.24 ±  4%      -0.1        0.24 ±  2%  perf-profile.self.cycles-pp.ext4_file_read_iter
      0.46 ±  2%      -0.2        0.24 ±  2%      -0.1        0.36 ±  3%      -0.1        0.36 ±  2%  perf-profile.self.cycles-pp.write
      0.45 ±  2%      -0.2        0.23 ±  6%      -0.1        0.35 ±  4%      -0.1        0.34 ±  5%  perf-profile.self.cycles-pp.disk_rr
      0.39 ±  3%      -0.2        0.18 ±  4%      -0.1        0.33 ± 10%      -0.1        0.30 ±  4%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.36 ±  4%      -0.2        0.15 ±  4%      -0.1        0.26 ±  3%      -0.1        0.26 ±  2%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.44            -0.2        0.23 ±  2%      -0.1        0.37            -0.1        0.35        perf-profile.self.cycles-pp.ext4_da_write_end
      0.44            -0.2        0.23 ±  2%      -0.1        0.36            -0.1        0.35        perf-profile.self.cycles-pp.__filemap_get_folio
      0.42            -0.2        0.21 ±  2%      -0.1        0.34            -0.1        0.33        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.42 ±  2%      -0.2        0.22 ±  3%      -0.1        0.33 ±  2%      -0.1        0.33        perf-profile.self.cycles-pp.generic_perform_write
      0.40            -0.2        0.20 ±  2%      -0.1        0.33 ±  2%      -0.1        0.32        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.43 ±  2%      -0.2        0.24 ±  3%      -0.1        0.36 ±  2%      -0.1        0.35 ±  2%  perf-profile.self.cycles-pp.read
      0.40 ±  2%      -0.2        0.21 ±  3%      -0.1        0.32 ±  2%      -0.1        0.32        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.41            -0.2        0.22 ±  3%      -0.1        0.34            -0.1        0.34        perf-profile.self.cycles-pp.llseek
      0.33            -0.2        0.17 ±  2%      -0.1        0.26 ±  2%      -0.1        0.25        perf-profile.self.cycles-pp.ext4_block_write_begin
      0.33 ±  2%      -0.2        0.17 ±  3%      -0.1        0.26            -0.1        0.26        perf-profile.self.cycles-pp.__cond_resched
      0.28 ±  2%      -0.2        0.13 ±  3%      -0.1        0.22 ±  2%      -0.1        0.21        perf-profile.self.cycles-pp.atime_needs_update
      0.30 ±  2%      -0.1        0.16 ±  3%      -0.1        0.24            -0.1        0.24        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.30            -0.1        0.16 ±  4%      -0.1        0.25            -0.1        0.25        perf-profile.self.cycles-pp.filemap_get_entry
      0.30            -0.1        0.16 ±  3%      -0.1        0.24 ±  2%      -0.1        0.23 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.28            -0.1        0.14 ±  4%      -0.1        0.22            -0.1        0.22        perf-profile.self.cycles-pp.folio_mark_accessed
      0.27            -0.1        0.14 ±  2%      -0.1        0.22 ±  2%      -0.1        0.21        perf-profile.self.cycles-pp.mark_buffer_dirty
      0.12 ±  5%      -0.1        0.00            -0.0        0.07 ±  5%      -0.1        0.07 ±  9%  perf-profile.self.cycles-pp.start_this_handle
      0.26            -0.1        0.14 ±  3%      -0.1        0.21 ±  3%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.ext4_da_map_blocks
      0.25            -0.1        0.13 ±  3%      -0.1        0.19 ±  2%      -0.1        0.19 ±  3%  perf-profile.self.cycles-pp.down_write
      0.25            -0.1        0.14 ±  2%      -0.0        0.21 ±  2%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
      0.27 ±  2%      -0.1        0.16 ±  2%      -0.0        0.22 ±  2%      -0.1        0.22        perf-profile.self.cycles-pp.block_invalidate_folio
      0.24 ±  2%      -0.1        0.12 ±  3%      -0.0        0.19 ±  3%      -0.0        0.19        perf-profile.self.cycles-pp.up_write
      0.16 ±  4%      -0.1        0.06 ±  7%      -0.1        0.11 ±  4%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.ext4_nonda_switch
      0.20 ±  2%      -0.1        0.10            -0.0        0.16 ±  2%      -0.1        0.15 ±  2%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.21 ±  2%      -0.1        0.11            -0.0        0.17            -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.folio_unlock
      0.23            -0.1        0.13 ±  3%      -0.1        0.17            -0.1        0.17        perf-profile.self.cycles-pp.xas_store
      0.21 ±  2%      -0.1        0.11            -0.0        0.18 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.xas_start
      0.20 ±  2%      -0.1        0.10 ±  4%      -0.0        0.16 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.filemap_get_pages
      0.20 ±  2%      -0.1        0.10 ±  4%      -0.0        0.16 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.security_file_permission
      0.20 ±  4%      -0.1        0.10 ±  4%      -0.0        0.16 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.22            -0.1        0.12 ±  3%      -0.0        0.19            -0.0        0.19 ±  3%  perf-profile.self.cycles-pp.folios_put_refs
      0.20 ±  2%      -0.1        0.11 ±  3%      -0.0        0.16 ±  2%      -0.0        0.16        perf-profile.self.cycles-pp.__slab_free
      0.18            -0.1        0.09 ±  3%      -0.0        0.13            -0.0        0.13        perf-profile.self.cycles-pp.__filemap_add_folio
      0.17 ±  2%      -0.1        0.09 ±  4%      -0.0        0.13 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.ext4_buffered_write_iter
      0.18 ±  2%      -0.1        0.09 ±  5%      -0.0        0.14 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.rw_verify_area
      0.08 ±  4%      -0.1        0.00            -0.0        0.07 ±  6%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.fault_in_iov_iter_readable
      0.08            -0.1        0.00            -0.0        0.06            -0.0        0.06        perf-profile.self.cycles-pp.__es_insert_extent
      0.08            -0.1        0.00            -0.0        0.06            -0.0        0.06        perf-profile.self.cycles-pp.ext4_es_insert_delayed_block
      0.08            -0.1        0.00            -0.0        0.06            -0.0        0.06        perf-profile.self.cycles-pp.rmqueue
      0.08 ±  8%      -0.1        0.00            -0.0        0.06 ±  6%      -0.0        0.06 ±  5%  perf-profile.self.cycles-pp.inode_to_bdi
      0.17            -0.1        0.09 ±  4%      -0.0        0.13 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.08 ±  6%      -0.1        0.00            -0.0        0.05 ±  9%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp._raw_read_lock
      0.08 ±  6%      -0.1        0.00            -0.0        0.06            -0.0        0.06        perf-profile.self.cycles-pp.generic_file_llseek_size
      0.16 ±  3%      -0.1        0.08 ±  3%      -0.0        0.12 ±  2%      -0.0        0.12        perf-profile.self.cycles-pp.aa_file_perm
      0.15            -0.1        0.07 ±  6%      -0.0        0.12            -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.16 ±  2%      -0.1        0.09 ±  3%      -0.0        0.13 ±  3%      -0.0        0.13        perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.07 ±  6%      -0.1        0.00            -0.0        0.06            -0.0        0.06        perf-profile.self.cycles-pp.__mark_inode_dirty
      0.07 ±  6%      -0.1        0.00            -0.0        0.06            -0.0        0.06        perf-profile.self.cycles-pp.generic_file_read_iter
      0.15 ±  3%      -0.1        0.08 ±  4%      -0.0        0.12 ±  2%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.current_time
      0.15 ±  3%      -0.1        0.08 ±  3%      -0.0        0.12 ±  2%      -0.0        0.12 ±  2%  perf-profile.self.cycles-pp.ksys_write
      0.15 ±  6%      -0.1        0.07 ±  6%      -0.0        0.12 ±  8%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.15 ±  2%      -0.1        0.08            -0.0        0.12 ±  2%      -0.0        0.12        perf-profile.self.cycles-pp.generic_write_checks
      0.15 ±  4%      -0.1        0.08 ±  6%      +0.0        0.16 ±  5%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.15 ±  3%      -0.1        0.08 ±  4%      -0.0        0.12 ±  3%      -0.0        0.12 ±  2%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.15 ±  3%      -0.1        0.08 ±  4%      -0.0        0.12            -0.0        0.12 ±  2%  perf-profile.self.cycles-pp.ksys_read
      0.07 ±  6%      -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp.__folio_cancel_dirty
      0.07 ±  6%      -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp.ext4_generic_write_checks
      0.07 ±  6%      -0.1        0.00            -0.0        0.05 ±  8%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.08            -0.1        0.01 ±163%      -0.0        0.07 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.free_unref_folios
      0.18 ±  2%      -0.1        0.11 ±  3%      -0.0        0.15 ±  3%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.mod_objcg_state
      0.13            -0.1        0.06 ±  7%      -0.0        0.10            -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.13 ±  3%      -0.1        0.06 ±  4%      -0.0        0.10            -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.06 ±  7%      -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.06 ±  7%      -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp.folio_activate
      0.06 ±  7%      -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.06 ±  7%      -0.1        0.00            -0.0        0.05 ±  9%      -0.0        0.05        perf-profile.self.cycles-pp.xas_clear_mark
      0.15 ±  2%      -0.1        0.09 ±  5%      -0.0        0.13 ±  2%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.find_lock_entries
      0.14            -0.1        0.08 ±  6%      -0.0        0.12 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.06 ±  7%      -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp.amd_clear_divider
      0.06 ±  7%      -0.1        0.00            -0.0        0.05 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.folio_mapping
      0.13 ±  5%      -0.1        0.07 ±  7%      -0.0        0.13 ±  9%      -0.0        0.13 ±  7%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.06 ±  6%      -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp.try_to_free_buffers
      0.12 ±  2%      -0.1        0.06            -0.0        0.09 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.node_dirty_ok
      0.06            -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp.__mod_zone_page_state
      0.06            -0.1        0.00            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.12            -0.1        0.06 ±  6%      -0.0        0.10 ±  4%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.ksys_lseek
      0.09            -0.1        0.03 ± 75%      -0.0        0.07            -0.0        0.07        perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.12            -0.1        0.06 ±  7%      -0.0        0.10 ±  4%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.create_empty_buffers
      0.12 ±  4%      -0.1        0.06            -0.0        0.09            -0.0        0.09 ±  3%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.10 ±  3%      -0.1        0.05 ± 31%      -0.0        0.08 ±  6%      -0.0        0.07        perf-profile.self.cycles-pp.folio_account_dirtied
      0.12 ±  4%      -0.1        0.06 ±  4%      -0.0        0.09 ±  5%      -0.0        0.09        perf-profile.self.cycles-pp.jbd2_journal_grab_journal_head
      0.09            -0.1        0.04 ± 61%      -0.0        0.07            -0.0        0.07        perf-profile.self.cycles-pp.file_modified
      0.11 ±  4%      -0.1        0.05 ±  8%      -0.0        0.08 ±  5%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.ext4_llseek
      0.10 ±  4%      -0.1        0.05            -0.0        0.08 ±  6%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__count_memcg_events
      0.11 ±  4%      -0.1        0.06 ±  8%      -0.0        0.08 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.10 ±  5%      -0.1        0.05            -0.0        0.08 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.file_remove_privs_flags
      0.10            -0.1        0.05            -0.0        0.08            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.10 ±  5%      -0.1        0.05            -0.0        0.08            -0.0        0.08        perf-profile.self.cycles-pp.block_write_end
      0.12 ±  4%      -0.0        0.07 ±  6%      -0.0        0.10 ±  4%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12            -0.0        0.07 ±  5%      -0.0        0.10            -0.0        0.10        perf-profile.self.cycles-pp.drop_buffers
      0.10 ±  5%      -0.0        0.05            -0.0        0.08 ±  6%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.timestamp_truncate
      0.10 ±  5%      -0.0        0.05 ±  5%      -0.0        0.08            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.folio_account_cleaned
      0.10 ±  4%      -0.0        0.06 ±  8%      -0.0        0.08            -0.0        0.08        perf-profile.self.cycles-pp.kmem_cache_free
      0.11 ±  9%      -0.0        0.07 ±  8%      +0.1        0.20 ±  3%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.10 ±  4%      -0.0        0.07            -0.0        0.10 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.09 ±  5%      -0.0        0.06 ±  4%      -0.0        0.08 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.try_charge_memcg
      0.10 ±  4%      -0.0        0.07 ±  5%      -0.0        0.08 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.__page_cache_release
      0.23 ±  3%      -0.0        0.21 ±  2%      -0.2        0.05            -0.2        0.05        perf-profile.self.cycles-pp.xas_find_conflict
      0.23 ±  2%      -0.0        0.22 ±  3%      -0.0        0.18 ±  3%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.workingset_activation
      0.25 ±  2%      +0.0        0.28 ±  4%      +0.0        0.30            +0.0        0.30        perf-profile.self.cycles-pp.folio_activate_fn
      0.17 ±  3%      +0.1        0.26            -0.0        0.13            -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.lru_add_fn
      0.51 ±  2%      +0.1        0.63 ±  3%      -0.1        0.40 ±  2%      -0.1        0.38        perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.30 ±  5%      +0.2        0.51 ±  2%      +0.0        0.34 ±  3%      +0.0        0.35 ±  2%  perf-profile.self.cycles-pp.folio_batch_move_lru
     50.97           +25.3       76.24           +13.7       64.69           +14.2       65.15        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


> 
> Thanks,
> Roman
> 
> --
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 60418934827c..3aae347cda09 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -110,6 +110,7 @@ struct mem_cgroup_per_node {
>         /* Fields which get updated often at the end. */
>         struct lruvec           lruvec;
>         unsigned long           lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
> +       CACHELINE_PADDING(_pad2_);
>         struct mem_cgroup_reclaim_iter  iter;
>  };

