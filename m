Return-Path: <cgroups+bounces-2947-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE88C80BD
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 07:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A026282E42
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 05:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813B71118D;
	Fri, 17 May 2024 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTdTVIJR"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F4B125C7
	for <cgroups@vger.kernel.org>; Fri, 17 May 2024 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715925410; cv=fail; b=VLbJ3yaaHnaUB+a8hYU3lbdHUdeA/nhqAQPdduk2AYSdDjlIsBfoinB/oFj2jFaU28M+Jx+Ofn0sRBy5ZbjJL5ckToswliKwXW6t0bQNrW9X5BY5Sy6r4IutQNU4CMIpFES+eJqpS3pBHRDCoE4G7iS/VHysyYcU4U3zKVmnqIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715925410; c=relaxed/simple;
	bh=EZ3/xTihuufB0hLoZ+ANEpdamAkna1M5Z4yTc12q38Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hQW3gHIhb1xWEzKIS987i70VogZgvc/hmYH2GOrHpBX4pROESDtJJ/5v1Un9d5iPoS3eJIO8eEEP5i+bzt5vAq2g+s+6Yb7CKT3OyWctxLOoccInWH42KDrUqZGL1/qEGxXirzoWXohkJ8OH2zls0J9rGBCDD9IdbEH5mKAjgMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YTdTVIJR; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715925408; x=1747461408;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=EZ3/xTihuufB0hLoZ+ANEpdamAkna1M5Z4yTc12q38Y=;
  b=YTdTVIJRKmfozU6EYzqJ97j9JOI7HTFdCzhui5MGvYkrEoNLacRez6Kj
   XDG2apBXK9IfcAC2jowI5pi9Gr4k/urPXWxqeIAO1bOKtemT1RIELol7K
   vtm+1/pLttUulgbJR6dvL6K4vjAIzDo2em1XY1tdNncNqtsTObk+ISKPp
   Xk6vj6Vo5je3EJSyWdod8V7sYlfoG7JwrqZUBOT7hOXt3Sb3+i/TTtzSM
   8SOKAC33Mj7DManOkaVrdWebMfIx9J4ixiCncgSuDVFWJqcPkkaRjgK5U
   93/qWf9SNiWkCEbn7WSFbtt+yyhgkR5rwqFRyAAqikJNZh2+Q8ehqLVx/
   Q==;
X-CSE-ConnectionGUID: WOfWy8MfRoGveqCWWMxqPA==
X-CSE-MsgGUID: rkdoPQWzRvOh9FtPep05SA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15908844"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="15908844"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 22:56:47 -0700
X-CSE-ConnectionGUID: WW/0ymcySOagcp8C9LleZg==
X-CSE-MsgGUID: ILn7mecQSX2nVXDOxRKXkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="32283829"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 22:56:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 16 May 2024 22:56:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 16 May 2024 22:56:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 22:56:46 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 22:56:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JY2KBK0rmkGE2uYQKWYvQPasjxaGDjO6YOA/SGF43mahp5T1S89QKyLDe05Rj6GGTgiQ9H2SB7j3Owh6j/kYBpZsDYhJXQ2dxHHI0VtdZ8YwfBLlW7fKku570KGTAzWM/xWRULlUhWFmcraMRLw8D37kGrsgTXBgBH1aR0Hn3ujnTUlD/kQVY++s0tx5gYTYeDynAv4UB9Uln9P28RkZS7+H3uh8eS3mpjqi8asneS+/ySplr2hbZsIgmj+YIwwzrf2W90WVbgzhEE4lMA64SXQ/qm8P62KvsZzx+3QHsl2xqOFq0eQYbcsqV42zzd14OynAq9HmLLFOWusSlEpKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlLW2Z1pTQtBAoHKVww5Q0eyeAwWSfyKRvtHx/JVHJk=;
 b=m8y/p2S+YMwokdi+TDlaoZEscn7e4dqoCfFvqRuwe5jF0ocrI+cROI+xWtwxjs3kd7S2ggHh62UU1bm1UOZ221HDf5SU1qCm6KSdk/wW2KY5sk+yXZUMbgrX2VMBr0p0eQ/wnbJAluAmHOknXR2izbaaunhmrAzXxzsGXPuJGv8D7EetCRaKk4F7k8iaxVJjMEyVBPLi6Dq9rGTDkMcLSvfxvYGIskLzuITCybt3qqgZ7ISF++Um0tRD+NlLWeuzDPJPPnI/zhyy4xWHuPeFqsG1filz2buIYtOp60dW6ZsXuJJWIoi5niGq02Ien39GVv0dXTLu/db3hzWFr9/RoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4557.namprd11.prod.outlook.com (2603:10b6:806:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 05:56:43 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 05:56:43 +0000
Date: Fri, 17 May 2024 13:56:30 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed
	<yosryahmed@google.com>, "T.J. Mercier" <tjmercier@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	<cgroups@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [memcg]  70a64b7919:
 will-it-scale.per_process_ops -11.9% regression
Message-ID: <202405171353.b56b845-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: 023af5dc-aff9-46d6-5063-08dc763620e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?g5nZKNVgdnq35Es1lYM5UxRdNZ0+K3DZQ3oHUwBI6iQsMc8gw1IUqJhMwL?=
 =?iso-8859-1?Q?sSeZr6y8+vGbw/s2OLVlDsIdECJSOYJCc5phK1Izm6evSjxQBy2//bli9Z?=
 =?iso-8859-1?Q?GqDCdioiWM+SOcLRgC0yGWgoKOSVb8c1xPGkngPoPE+OJAUEbz4WwCAUtZ?=
 =?iso-8859-1?Q?Sj23oZemI3707zVCm7R+VaPifDd7DCu/Rbeo3GBa1CV8GFdbWTVyoac/IV?=
 =?iso-8859-1?Q?3w9uVM3PbYYMiS+qqoCsLJ5D7LZqF/fnz+roQpreliZGMnM1gJSFihFLY/?=
 =?iso-8859-1?Q?6qhR1WjFX5BgoNu8oVaF2aEsG0k3ODoJ/FOcr+Kypx5/131qKRcA/UTuQ8?=
 =?iso-8859-1?Q?fZP3bpnboeD8gLTG1o/hf8XNiMZ8xnbYxxlhrV7equikrwdq9UIeaQINJM?=
 =?iso-8859-1?Q?dplZEhnuDcG4MPTyJx7TXD5EeyU6k7TvD5rM2SoJjW9jtkZ/ooQOfEBZ+r?=
 =?iso-8859-1?Q?TYt2h/H/I13Y4r5a/A2HD40gnbTX5xvNLbJ26IHIQ5JbLgZtmg4VJqybGr?=
 =?iso-8859-1?Q?lkV8NEOZ97tRyovjkLcRS/Q0fnWKD5Xc+jiBXXdyUubeHdV78EiyX5PYJI?=
 =?iso-8859-1?Q?FrnzAa46sgXTrbOAIodIEx9p1VmTAa/YKHuffNjOkM+4TyuTyuvidQq+9l?=
 =?iso-8859-1?Q?k/qr/iUQx68Ar1SagYSGnq61V3hA588T/TIbo9nUFNTw18tN8RQd4+OkSv?=
 =?iso-8859-1?Q?rQt590pjJojYWxNBjdK3UP5j7rCA6Ha+kBv07Ut+j8LHWZ4cOwks4zPRrw?=
 =?iso-8859-1?Q?vcfwfrAf18BWao8dj5O4dqdBab4S0Rq2cx3BePtSVauF2m9yuNPd193MiK?=
 =?iso-8859-1?Q?gcxCXsVzOHJdxPQICCuDWAbbvplFKzZ3xc5NW2tx3CdC+dIxAYdQ4P70A3?=
 =?iso-8859-1?Q?OPE3jPOz1Dv1wUfkHrGYLcFN1TKSAEamJq40kvHt7CnZHnr4381jwwtc/T?=
 =?iso-8859-1?Q?JyiNnLmXoTJ58cPhWbf1DzCGwWINvV5qAve8Lt/spzIRcjrFR7ey7c040Q?=
 =?iso-8859-1?Q?IOIv9x62a6XPV+/U6Cy3r6akisfmhlASSWmvW5VrmFKe80EYBxI9PCvpRB?=
 =?iso-8859-1?Q?/jOLGV6WXoKv6So1dCX8JTSoEY+5NGUEst+7lklEQHtc4bewXBq1W4uAaJ?=
 =?iso-8859-1?Q?V+4g77ObO37Fq9b/8knYiOJif/QWqT1l4EfUkd+3pb0X0FSIBB1NUzqkda?=
 =?iso-8859-1?Q?uAQnXCbhqu4PZ98kdr7kQRqeCJA/2eZ+mPoy7/jrotm96uXsoH6utDOFc4?=
 =?iso-8859-1?Q?4GR/dZc2fW2CUxW0FIIE0ILtZDltaksd6T00DBWZc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dIdaNkelZZ+hyazVSYhvAdaEfzr2lQaiPha/XxjrBu7MTjqVxYAwjaGEbd?=
 =?iso-8859-1?Q?h6Up/1aqgVXXw0Hf1YNmwm1qJQhA9yeEf/QcogYhscehocp2ICn3aQz817?=
 =?iso-8859-1?Q?rxc7gfT44S0ocQ9KY4CnYNbWJpig3e1pBW6RQlR1elJ6Nk098S+ox2b30j?=
 =?iso-8859-1?Q?SpxD2bVk8aEwM0aF35K/V8od3Z2FI6TtgW6rBvrM0h0F+GrC/KKLvVHX6D?=
 =?iso-8859-1?Q?Lt3oN85+J5e6I7STGxzB/WR/xW7+KE6gtE7q8yv7fvfrMU5UN6W6OeUWBu?=
 =?iso-8859-1?Q?j7HxFqtz1aqEZotZYYvTxO4ixco8oSz4E0tE0LjLZj6teR2vwe+h+HJEvt?=
 =?iso-8859-1?Q?G5p8ubcHkB0Jnf9upRIXRwGJmpjopAnH8hnMJ+BQYlmgx8TiO70Hya8GtM?=
 =?iso-8859-1?Q?I7v6pd9X/6R+iBl4lAAa0EZHuSspVL6MwHqE19V1Q0L2+aB1vwgcECIFvd?=
 =?iso-8859-1?Q?yfw+xFP++aJlkGhLJYfauvozWyy6BNQAYfNfB002j7qRTWrYphS7u4Qa3S?=
 =?iso-8859-1?Q?fT8sVEsIMkWbWgl/xYDN71F9ZobheuDkt4Rkrqu1Ig0fAd8+QT9UJyue7I?=
 =?iso-8859-1?Q?j9uPF5Fhp8MTJVf/5mdzfBAXZEUeivDj6g0I+cWbVpMIaxqk8iTGnHUd+w?=
 =?iso-8859-1?Q?a5fo8N2qtPol5iaW7E5IM9U4YHCNsyHDqJdtjWNhaqzvGruTNUio7d5oiv?=
 =?iso-8859-1?Q?KtEhTv9nQugeMlK1XwTJDLgImtgjEDW757bK5AxbaqcMpDO7iE5FDMbEjn?=
 =?iso-8859-1?Q?MdxM7R5Kaqjnq88VopuZ9w5yqYw5UxWqjlbd7lX1XWD+xMPS+9b6MBZ3Ni?=
 =?iso-8859-1?Q?TjposXRt5lwhgYWs5/DJqodgTt8WZxO6d03slG4nZRsuWLLNdV7uzH5EIY?=
 =?iso-8859-1?Q?0JIqDFCw1eap/zYKujWBaxoGxbPPNPVKyQzLg3AUV8RV+ZGDfQxcdtPuXv?=
 =?iso-8859-1?Q?Y/4z/+6lODigq1Fa2IQ7aT2rrGMc3E+VF3Gi187DFbnOjMUBHdL2VbfRk3?=
 =?iso-8859-1?Q?nWda8lhBPztDpF9fjOvBK/rQC6VADbKI4yMs1ApUoJwSgtq+16TSYk3Wob?=
 =?iso-8859-1?Q?SmxTKAQhx1rrfuCjYIovyo+OO580R5ERJWpBAI94ZcECVtUQemAEPpH6eN?=
 =?iso-8859-1?Q?3XB7tf9SAroSuRr/drL+R/FC+NxjtJLchSz0WLKh3KetN5hwKoSMfzMkXS?=
 =?iso-8859-1?Q?AuzTCPZ1jnmy326vfdlY16sOPeQ1jiV+9amBXGMCeYUuvNy0YOMzQmIhE4?=
 =?iso-8859-1?Q?VOSibZ8plD5uPaj/mMze/SIdo2wpV/iceKMleZ2wQUjyRGFqOrtYU8yC9A?=
 =?iso-8859-1?Q?pRbbY3GPbqnSZ8n7Hzp5of/QkLFvT/Tmfe2hbML0feRHwJPUcjiDip1mjp?=
 =?iso-8859-1?Q?+EDDFmBTPPyJjgmZwlTdPktFlX0ioAyS1/gmyE5EJZ2+G1RrKFbrGO4Osz?=
 =?iso-8859-1?Q?V8MXr9/Z+aAr1infzpKil3aFdGTPhb9ejWS8GWZi2VX4kQjLDshuVZFuKB?=
 =?iso-8859-1?Q?EYaqsNEA9h9oVBpS2N2mhKbRgrDHIrwqDUBPdj1M7rKBo2NBzjc53TYiHp?=
 =?iso-8859-1?Q?KQCKfgGShqFAl/U3Kno3KdssKWwG9B18GlH6EeKFowl4beNDdJGpuCD+rP?=
 =?iso-8859-1?Q?Xf3tf3ba9DFuJpJNbCbiRljNy/O9CO+SlFVzPtl/LhhEHMi6bvs8JyOA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 023af5dc-aff9-46d6-5063-08dc763620e9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 05:56:43.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzFf6e7w9rSLzLC4cQvafl+X2nf30t1zVFqh13i/xEUVQ/8WDiHzR2CKOko/3C8pwHhOcQVVhavFe6Zfj/C8tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4557
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -11.9% regression of will-it-scale.per_process_ops on:


commit: 70a64b7919cbd6c12306051ff2825839a9d65605 ("memcg: dynamically allocate lruvec_stats")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: page_fault2
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405171353.b56b845-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240517/202405171353.b56b845-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/page_fault2/will-it-scale

commit: 
  59142d87ab ("memcg: reduce memory size of mem_cgroup_events_index")
  70a64b7919 ("memcg: dynamically allocate lruvec_stats")

59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      7.14            -0.8        6.32        mpstat.cpu.all.usr%
    245257 ±  7%     -13.8%     211354 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    245258 ±  7%     -13.8%     211353 ±  4%  sched_debug.cfs_rq:/.min_vruntime.stddev
     21099 ±  5%     -14.9%      17946 ±  5%  perf-c2c.DRAM.local
      4025 ±  2%     +29.1%       5197 ±  3%  perf-c2c.HITM.local
    105.17 ±  8%     -12.7%      91.83 ±  6%  perf-c2c.HITM.remote
   9538291           -11.9%    8402170        will-it-scale.104.processes
     91713           -11.9%      80789        will-it-scale.per_process_ops
   9538291           -11.9%    8402170        will-it-scale.workload
 1.438e+09           -11.2%  1.276e+09        numa-numastat.node0.local_node
  1.44e+09           -11.3%  1.278e+09        numa-numastat.node0.numa_hit
     83001 ± 15%     -68.9%      25774 ± 34%  numa-numastat.node0.other_node
 1.453e+09           -12.5%  1.271e+09        numa-numastat.node1.local_node
 1.454e+09           -12.5%  1.272e+09        numa-numastat.node1.numa_hit
     24752 ± 51%    +230.9%      81910 ± 10%  numa-numastat.node1.other_node
  1.44e+09           -11.3%  1.278e+09        numa-vmstat.node0.numa_hit
 1.438e+09           -11.3%  1.276e+09        numa-vmstat.node0.numa_local
     83001 ± 15%     -68.9%      25774 ± 34%  numa-vmstat.node0.numa_other
 1.454e+09           -12.5%  1.272e+09        numa-vmstat.node1.numa_hit
 1.453e+09           -12.5%  1.271e+09        numa-vmstat.node1.numa_local
     24752 ± 51%    +230.9%      81910 ± 10%  numa-vmstat.node1.numa_other
     14952            -3.2%      14468        proc-vmstat.nr_mapped
 2.894e+09           -11.9%   2.55e+09        proc-vmstat.numa_hit
 2.891e+09           -11.9%  2.548e+09        proc-vmstat.numa_local
  2.88e+09           -11.8%  2.539e+09        proc-vmstat.pgalloc_normal
 2.869e+09           -11.9%  2.529e+09        proc-vmstat.pgfault
  2.88e+09           -11.8%  2.539e+09        proc-vmstat.pgfree
     17.51            -2.6%      17.05        perf-stat.i.MPKI
 9.457e+09            -9.2%  8.585e+09        perf-stat.i.branch-instructions
  45022022            -8.2%   41340795        perf-stat.i.branch-misses
     84.38            -4.9       79.51        perf-stat.i.cache-miss-rate%
 8.353e+08           -12.1%  7.345e+08        perf-stat.i.cache-misses
 9.877e+08            -6.7%  9.216e+08        perf-stat.i.cache-references
      6.06           +10.8%       6.72        perf-stat.i.cpi
    136.25            -1.2%     134.59        perf-stat.i.cpu-migrations
    348.56           +13.9%     396.93        perf-stat.i.cycles-between-cache-misses
 4.763e+10            -9.7%  4.302e+10        perf-stat.i.instructions
      0.17            -9.6%       0.15        perf-stat.i.ipc
    182.56           -11.9%     160.88        perf-stat.i.metric.K/sec
   9494393           -11.9%    8368012        perf-stat.i.minor-faults
   9494393           -11.9%    8368012        perf-stat.i.page-faults
     17.54            -2.6%      17.08        perf-stat.overall.MPKI
      0.47            +0.0        0.48        perf-stat.overall.branch-miss-rate%
     84.57            -4.9       79.71        perf-stat.overall.cache-miss-rate%
      6.07           +10.8%       6.73        perf-stat.overall.cpi
    346.33           +13.8%     393.97        perf-stat.overall.cycles-between-cache-misses
      0.16            -9.7%       0.15        perf-stat.overall.ipc
   1503802            +2.6%    1542599        perf-stat.overall.path-length
 9.424e+09            -9.2%  8.553e+09        perf-stat.ps.branch-instructions
  44739120            -8.3%   41034189        perf-stat.ps.branch-misses
 8.326e+08           -12.1%  7.321e+08        perf-stat.ps.cache-misses
 9.846e+08            -6.7%  9.185e+08        perf-stat.ps.cache-references
    134.98            -1.3%     133.26        perf-stat.ps.cpu-migrations
 4.747e+10            -9.7%  4.286e+10        perf-stat.ps.instructions
   9463902           -11.9%    8339836        perf-stat.ps.minor-faults
   9463902           -11.9%    8339836        perf-stat.ps.page-faults
 1.434e+13            -9.6%  1.296e+13        perf-stat.total.instructions
     64.15            -2.4       61.72        perf-profile.calltrace.cycles-pp.testcase
     58.30            -1.9       56.41        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     52.64            -1.4       51.28        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     52.50            -1.3       51.16        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     50.81            -1.0       49.86        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     49.86            -0.8       49.02        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      9.27            -0.8        8.45 ±  3%  perf-profile.calltrace.cycles-pp.copy_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     49.21            -0.8       48.43        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      5.15            -0.5        4.68        perf-profile.calltrace.cycles-pp.__irqentry_text_end.testcase
      3.24            -0.5        2.77        perf-profile.calltrace.cycles-pp.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.82            -0.3        0.51        perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      1.68            -0.3        1.42        perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      2.52            -0.2        2.28        perf-profile.calltrace.cycles-pp.error_entry.testcase
      1.50 ±  2%      -0.2        1.30        perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      1.85            -0.1        1.70 ±  3%  perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.68            -0.1        0.55 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      1.55            -0.1        1.44 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault
      0.55            -0.1        0.43 ± 44%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc
      1.07            -0.1        0.98        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault
      0.90            -0.1        0.81        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      0.89            -0.0        0.86        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault
      1.00            +0.1        1.05        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      3.85            +0.2        4.10        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      3.85            +0.2        4.10        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      3.85            +0.2        4.10        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      3.82            +0.3        4.07        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region
      3.68            +0.3        3.94        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.83            +0.3        1.10 ±  2%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.set_pte_range.finish_fault.do_fault.__handle_mm_fault
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range
      0.00            +0.7        0.66        perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
     32.87            +0.7       33.62        perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
     29.54            +2.3       31.80        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
     29.54            +2.3       31.80        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     29.53            +2.3       31.80        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     30.66            +2.3       32.93        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     30.66            +2.3       32.93        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     30.66            +2.3       32.93        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
     30.66            +2.3       32.93        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     29.26            +2.3       31.60        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
     28.41            +2.4       30.78        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu
     34.56            +2.5       37.08        perf-profile.calltrace.cycles-pp.__munmap
     34.56            +2.5       37.08        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     34.56            +2.5       37.08        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     34.55            +2.5       37.07        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     34.55            +2.5       37.08        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     34.55            +2.5       37.08        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     34.55            +2.5       37.08        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     34.55            +2.5       37.08        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.41            +2.8       34.20        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
     31.42            +2.8       34.23        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
     31.38            +2.8       34.19        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     65.26            -2.5       62.73        perf-profile.children.cycles-pp.testcase
     56.09            -1.7       54.41        perf-profile.children.cycles-pp.asm_exc_page_fault
     52.66            -1.4       51.30        perf-profile.children.cycles-pp.exc_page_fault
     52.52            -1.3       51.18        perf-profile.children.cycles-pp.do_user_addr_fault
     50.83            -1.0       49.88        perf-profile.children.cycles-pp.handle_mm_fault
     49.87            -0.8       49.02        perf-profile.children.cycles-pp.__handle_mm_fault
      9.35            -0.8        8.53 ±  3%  perf-profile.children.cycles-pp.copy_page
     49.23            -0.8       48.45        perf-profile.children.cycles-pp.do_fault
      5.15            -0.5        4.68        perf-profile.children.cycles-pp.__irqentry_text_end
      3.27            -0.5        2.80        perf-profile.children.cycles-pp.folio_prealloc
      0.82            -0.3        0.52        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.57            -0.3        0.32        perf-profile.children.cycles-pp.mas_walk
      1.69            -0.3        1.43        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      2.54            -0.2        2.30        perf-profile.children.cycles-pp.error_entry
      1.52 ±  2%      -0.2        1.31        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.95            -0.2        0.79 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.87            -0.2        1.72 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.60 ±  4%      -0.1        0.46 ±  6%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.70            -0.1        0.56 ±  2%  perf-profile.children.cycles-pp.lru_add_fn
      1.57            -0.1        1.45 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      1.16            -0.1        1.04        perf-profile.children.cycles-pp.native_irq_return_iret
      1.12            -0.1        1.01        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.44            -0.1        0.35        perf-profile.children.cycles-pp.get_vma_policy
      0.94            -0.1        0.85        perf-profile.children.cycles-pp.sync_regs
      0.96            -0.1        0.87        perf-profile.children.cycles-pp.__perf_sw_event
      0.43            -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.free_unref_folios
      0.21 ±  3%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp._compound_head
      0.75            -0.1        0.68        perf-profile.children.cycles-pp.___perf_sw_event
      0.31            -0.1        0.25        perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.94            -0.0        0.90        perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.41 ±  4%      -0.0        0.37 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.44 ±  5%      -0.0        0.40 ±  5%  perf-profile.children.cycles-pp.__count_memcg_events
      0.17 ±  2%      -0.0        0.13 ±  4%  perf-profile.children.cycles-pp.uncharge_batch
      0.57            -0.0        0.53 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.13 ±  2%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.19 ±  3%      -0.0        0.16 ±  6%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.15 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.10 ±  3%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.08            -0.0        0.05        perf-profile.children.cycles-pp.policy_nodemask
      0.13 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.32 ±  3%      -0.0        0.30 ±  2%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.17 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.16 ±  2%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.shmem_get_policy
      0.16            -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.handle_pte_fault
      0.16 ±  4%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.__pte_offset_map
      0.09            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.uncharge_folio
      0.36            -0.0        0.34        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.10 ±  3%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.30            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.09 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.down_read_trylock
      0.08            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.folio_unlock
      0.40            +0.0        0.43        perf-profile.children.cycles-pp.__mod_lruvec_state
      1.02            +0.0        1.06        perf-profile.children.cycles-pp.zap_present_ptes
      0.47            +0.2        0.67        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      3.87            +0.3        4.12        perf-profile.children.cycles-pp.tlb_finish_mmu
      1.17            +0.5        1.71 ±  2%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
     32.88            +0.8       33.63        perf-profile.children.cycles-pp.set_pte_range
     29.54            +2.3       31.80        perf-profile.children.cycles-pp.tlb_flush_mmu
     30.66            +2.3       32.93        perf-profile.children.cycles-pp.zap_pte_range
     30.66            +2.3       32.94        perf-profile.children.cycles-pp.unmap_page_range
     30.66            +2.3       32.94        perf-profile.children.cycles-pp.zap_pmd_range
     30.66            +2.3       32.94        perf-profile.children.cycles-pp.unmap_vmas
     33.41            +2.5       35.92        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
     33.40            +2.5       35.92        perf-profile.children.cycles-pp.free_pages_and_swap_cache
     34.56            +2.5       37.08        perf-profile.children.cycles-pp.__munmap
     34.56            +2.5       37.08        perf-profile.children.cycles-pp.__vm_munmap
     34.56            +2.5       37.08        perf-profile.children.cycles-pp.__x64_sys_munmap
     34.56            +2.5       37.09        perf-profile.children.cycles-pp.do_vmi_munmap
     34.56            +2.5       37.09        perf-profile.children.cycles-pp.do_vmi_align_munmap
     34.67            +2.5       37.20        perf-profile.children.cycles-pp.do_syscall_64
     34.67            +2.5       37.20        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     34.56            +2.5       37.09        perf-profile.children.cycles-pp.unmap_region
     33.22            +2.6       35.80        perf-profile.children.cycles-pp.folios_put_refs
     32.12            +2.6       34.75        perf-profile.children.cycles-pp.__page_cache_release
     61.97            +3.3       65.27        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     61.94            +3.3       65.26        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     61.98            +3.3       65.30        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      9.32            -0.8        8.49 ±  3%  perf-profile.self.cycles-pp.copy_page
      5.15            -0.5        4.68        perf-profile.self.cycles-pp.__irqentry_text_end
      0.56            -0.3        0.31        perf-profile.self.cycles-pp.mas_walk
      2.58            -0.2        2.33        perf-profile.self.cycles-pp.testcase
      2.53            -0.2        2.30        perf-profile.self.cycles-pp.error_entry
      0.60 ±  4%      -0.2        0.44 ±  6%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.85            -0.1        0.71 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      1.54            -0.1        1.43 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      1.15            -0.1        1.04        perf-profile.self.cycles-pp.native_irq_return_iret
      0.94            -0.1        0.85        perf-profile.self.cycles-pp.sync_regs
      0.20 ±  3%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp._compound_head
      0.27 ±  3%      -0.1        0.20 ±  3%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.26            -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.get_vma_policy
      0.26            -0.1        0.19 ±  2%  perf-profile.self.cycles-pp.__page_cache_release
      0.16            -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.vma_alloc_folio_noprof
      0.28 ±  2%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.zap_present_ptes
      0.66            -0.1        0.60        perf-profile.self.cycles-pp.___perf_sw_event
      0.32            -0.1        0.27 ±  5%  perf-profile.self.cycles-pp.lru_add_fn
      0.47            -0.0        0.43 ±  2%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.16 ±  4%      -0.0        0.12        perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.20            -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.free_unref_folios
      0.30            -0.0        0.26        perf-profile.self.cycles-pp.handle_mm_fault
      0.10 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.zap_pte_range
      0.09 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.14 ±  2%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.12 ±  4%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.alloc_pages_mpol_noprof
      0.11            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.22 ±  2%      -0.0        0.19        perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.21            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__perf_sw_event
      0.21            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.31 ±  2%      -0.0        0.29        perf-profile.self.cycles-pp.__mod_node_page_state
      0.16 ±  2%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.17 ±  2%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.11            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.09            -0.0        0.07        perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.28 ±  2%      -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.xas_load
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.12            -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.uncharge_folio
      0.16 ±  4%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__pte_offset_map
      0.20 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.shmem_get_policy
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.do_fault
      0.08            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.folio_unlock
      0.12 ±  3%      -0.0        0.11        perf-profile.self.cycles-pp.folio_add_new_anon_rmap
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.down_read_trylock
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.folio_prealloc
      0.38 ±  2%      +0.0        0.42 ±  3%  perf-profile.self.cycles-pp.filemap_get_entry
      0.26            +0.1        0.36        perf-profile.self.cycles-pp.folios_put_refs
      0.33            +0.1        0.44 ±  3%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.40 ±  5%      +0.6        0.98        perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
     61.94            +3.3       65.26        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


