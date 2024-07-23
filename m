Return-Path: <cgroups+bounces-3857-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E296F9398BB
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 05:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB351C21977
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2024 03:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF3113B5B4;
	Tue, 23 Jul 2024 03:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRbbJX/C"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1B2C9D
	for <cgroups@vger.kernel.org>; Tue, 23 Jul 2024 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721706176; cv=fail; b=DqTlv4gkxAF97GPOMTXpxY1dkL6oKoEVWqNzPLTcN6MXFKMkUM7KwIr0fLuZh9vSbqMeRhXrlnzrTK9DdvUy/PTZTmzqhKpCGvZ7steKX2MAFdZaI+YX5GcuGiIXycSlYezH7ZLaSWVGR6ZieGjkA7+Gjhd6NjYxMVZX6zqzyls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721706176; c=relaxed/simple;
	bh=NVfb/pRDwO5iU+GLpKMmdva4B9gSkipMJKJfHNKzKLQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LR2/bjJ5bTmMnPaEXgt2phXu/tm/7IbFjOJItp54wVRx3zYtpZZQCo+ujkEDETIc1RU6GdEWE9GaM/1INlsublQwoAE95/MrS87Y8QYaRvsLl4ZLJzZ6Rnmf+I7q6i31FriqR2/OLBvsfqpL7MCqRaE75UFHLiBWn2QtAlKAyuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRbbJX/C; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721706172; x=1753242172;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NVfb/pRDwO5iU+GLpKMmdva4B9gSkipMJKJfHNKzKLQ=;
  b=ZRbbJX/CY7ohNqnTWa2vLnxbKglMk/ebDY8xCi9DtwdbYR5sqpqNTR5p
   OWtD9BmxzOxw30fgxtIk9mIOCahcGHWPxO+8dj4SCly2AOgj0EOZtVzbD
   oUJqfhY6sA6Ah8r0fw2p8LFJqYmW8VjOK0RIzS3H1yuU+3k4a9TLsL0OC
   xrDQyuG4TTYBXXe9eUbzDQL9gTSZ9kbndoHxYjjiLgtNiwuEsCj2HP3Fu
   2vFdG6PFwQ65oW5aeSNRtHtytYceH400WP154R2WHjlLqqXh3X8ccbkwQ
   X1z1084+gc5IFFrk9oQK1yBjKRNR4S+qmQ8R6ZxnuL7pl6FlcS03MgGWe
   w==;
X-CSE-ConnectionGUID: 4LupnLLfQYO4yhg8EHdIGw==
X-CSE-MsgGUID: EUlZDyP7TR+sCgYU5KvfBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="23110878"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="23110878"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 20:42:51 -0700
X-CSE-ConnectionGUID: vczGZeLmTR6b2fvkdzHiDg==
X-CSE-MsgGUID: inUN19zOTIKA0nwHX0nc/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="56650750"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jul 2024 20:42:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 20:42:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 20:42:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 20:42:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 20:42:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O68uWDY9+/uaZwSFr3/dodEC4SrQnpEWzaKXUgPWGTYeG+18DxcGlwO0qupalujcb8fc2+wASLxqrEfA7J+qEIerrOBGeLu3S7/nFi4yFy+yVCh+NTSty1J26Qtn8iM5J5pxgFloqyIjB5Gn6x+AuyNbscTvEcBJRdFCozEDonIRuat8XGHA4YRpCjaMGISfcn2+ggFECBgGBxhV1q9V/ESy2Lbu02KdAOuUmDF3hgWMd3yM/uZeKASiNLTea5XVKUuXEQWbrQk68VN5spIzf7JNIigIMNFOyz/bJbGKDtBzwl5aQFKFxvuYBiWtTuW6E8t8Kto9w3CNyGLpx2kWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyT8E0qplgtLBtjWEdPXExayPraU51Esx9SJ67A+/ZE=;
 b=G12/TksC77cf/D6qUrT4S3kAH+9k4E1lqifIyq/gywfXsrS/CFK0TlCUXekS7r3TAntyH6EjvUHcXhKVKyVJVfKhVvIzezuMtgopyNE7peb5m0xsvqRDc2DUpXWEET0x6ucf2lfDw8IYnOAxP/FarRplhfUd/FeGQ7D6PLXvLX9r6zX+dXbc+HIhfDYgPVt1Cagk93g1DPanlp/9ckXWRknUppEJlahYqQ/ys/dmICQyKN2ZEosXZmrQoFbdagSYEAdVt7y2S/Y+1u3ARXjV7TWwxtIDV24KmDIZozv2E+JnqJiZR1N9Z2ZFdMrzUMsbFooCRLf/q3yLeGzYyMMU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6973.namprd11.prod.outlook.com (2603:10b6:510:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 03:42:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 03:42:45 +0000
Date: Tue, 23 Jul 2024 11:42:33 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
CC: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>,
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, "Johannes
 Weiner" <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Muchun Song
	<muchun.song@linux.dev>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>, "Tang, Feng" <feng.tang@intel.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [mm]  :  aim7.jobs-per-min -29.4% regression
Message-ID: <Zp8mqTnJN7VJZ/C/@xsang-OptiPlex-9020>
References: <202407121335.31a10cb6-oliver.sang@intel.com>
 <ZpF-A9rl8TiuZJPZ@google.com>
 <ZpUux8bvpL8ARYDE@xsang-OptiPlex-9020>
 <ZpWgP-h5X7GKj1ay@google.com>
 <ZpYm9clw/f8f/tEj@xsang-OptiPlex-9020>
 <Zpqe6NSVBQGiS86m@google.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zpqe6NSVBQGiS86m@google.com>
X-ClientProxiedBy: SGAP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 7388f0ef-cf6e-4f58-943a-08dcaac9835b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?LdWdez2Htm5x0bt3/OBrrijD0almrfepZkBG1pVNVJYUAElz2iM+0FOLGF?=
 =?iso-8859-1?Q?6jUP2YXzAe1Yh154m4bkGFCzAP8PMoz+g7qkN7HVvi5m5sfK848OGKSIzh?=
 =?iso-8859-1?Q?vGJKH8PpzMIaDRNU/Lu6U7Jjh8d2vxbRGRlWvZ2MrUyomQ/trhykD4NaPq?=
 =?iso-8859-1?Q?caWIV54nZOFjn9j0wzj6XG6Sct4UAk8h+k0hJIkGe9iHf4+uI3Oynt3cDO?=
 =?iso-8859-1?Q?4qY9MBVlKNmEnbWQIHrupvhvIc/myYSngFXuufjZLGQ7TB/nsaowDu/Ysh?=
 =?iso-8859-1?Q?tTHEjHrls4C/BsxPCOZ0txzE9sZpqHOLras/N5zrGvNx7KTjrGnOajnYLz?=
 =?iso-8859-1?Q?2T6DWiYKEwbBRlFQhNbCvSo+RJ++ssZcDTVAj0WDrQq8m5Cxi9f+wRv8mW?=
 =?iso-8859-1?Q?Embczu+eUMDs6H91fGY2c8MSQ/V/s4wRkvzCd4M01dVjJ9zh4CobSLdM0l?=
 =?iso-8859-1?Q?NLRXiY8E0sTO9TxiNBXmEqHoWCtxXcPITvHGLi0Km4gaNuwgjn+csdKXN+?=
 =?iso-8859-1?Q?tqNue+9w/alpfMZzf0fGfbM361xiCuL8jPPDHnB/3bM6zQMCfsmztZLxtq?=
 =?iso-8859-1?Q?Vi7/J5PagtzZiBj8+8D/9cPZXmKCezCCyksR4lUR7jfGIkw5QAhunqIuuO?=
 =?iso-8859-1?Q?dPXIWFjynauUGQAR9T/2CJbksHP3RJhJ4PNcAw4Ul559BazGBl6V9EcyeV?=
 =?iso-8859-1?Q?rBR0nWbSJMnMF0+P5BB/6WiOd7U88fR75JZaqqIN95tTjyp6FzgSrl1Dsm?=
 =?iso-8859-1?Q?0PiH/RFBEtss8EXuAP7DMZWTQQ2F0+5tkdNO1Bz4xmYkxQ5q4+rZ9DdNvp?=
 =?iso-8859-1?Q?vHfElg4CtagvzHtzBw4MB6sV03+vMjIodUnCux0nAWTTBARrTsTLOKtJyF?=
 =?iso-8859-1?Q?rQoYTR4cy8G9AIbdsQJNzJGmpZHVc9JYg+h0xpvpUyrp1thfgUFmidUSpa?=
 =?iso-8859-1?Q?mC63r1aGPMo6t64q9tgzIObbRMVp0uUg5APfnplmVyYQ+OsXMe1/25qzNn?=
 =?iso-8859-1?Q?EX799TxG6BBzTyHalb4nnyRccMvIyu/R9+7Ue0u97mU5/8DJJ+zb2yvAog?=
 =?iso-8859-1?Q?pyivPwuDWkaYdWfW1vIvMZGPEvdSlIAPx0YmGwO4fjAsbZwJzKeaQTTsJz?=
 =?iso-8859-1?Q?ejerRGfbv60y7EyABmjc8VrpZGy0Njbi7RnR+KMaQ74iKScgruOAPufRWX?=
 =?iso-8859-1?Q?dB/RrU9SQj7FRskCfnursS0ayfVrCDIBVtVc04eCGDHZ9DHPQ+bgXaiDBh?=
 =?iso-8859-1?Q?pgfM5wtWh0RpVzXEdeod/v3hjjJGTgdL4GSXMRmpHM+BjDmMmilOQSTux8?=
 =?iso-8859-1?Q?4lXN3yHiuWvcN0kkQ7fk7LWz2ZkY4+ZdY9YTk9CRSSq5xK/+EP4sMOQzUi?=
 =?iso-8859-1?Q?8ML30HnCehg7i00AotyzFNUO7gwka9RCNt5mcNSK3Q036Ii5kltlY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1lDXTGwpy3Hsulso5C+fMk3/BluRWuiybjPeYccFKod+gX5grsquy1EmK+?=
 =?iso-8859-1?Q?06jEXd3plG/IthmRtNruYh2qFddon2HVjWrQXlNlXvl4QfZFXtjGQyo7+n?=
 =?iso-8859-1?Q?CfgvtcrcA1JQ4GGffZk+A7qKc0yUok+KogVWJn7g4L/70PpbOfu/OzzJZp?=
 =?iso-8859-1?Q?IyvXRChjGu4DGdjOJO88ShTYbGH0KO0j4OrgurGD9JqJkPbYedyJ+WRgoI?=
 =?iso-8859-1?Q?A2D1tJC1lR6muLqsHXuQmHwmZCRcI08Ev1OLUN2ppR4DgqfbRl/FLo15mF?=
 =?iso-8859-1?Q?Ll8XwofwTtlCY7VtTpdKwTWIipdIcuq/9kiMvZ8KDimGrZp47UL8x/gUeN?=
 =?iso-8859-1?Q?zoJx3xwMSbEV8q8qn0WOZyhb/BsS9NhNTipBVJY1a3vMsOSuRBlXFkS1LM?=
 =?iso-8859-1?Q?Lr0PSwVfb4wXh9dqyCZfTvFJN4ioLnk12kpc+Jbtg3g8cRHvHYG1X3/3lx?=
 =?iso-8859-1?Q?3TQdZ1HaE9zHpp6hO0tFzrMtSzl1TgR3EM195zw+UUEknsI9r6SCo+QY4y?=
 =?iso-8859-1?Q?YkV2/zWYtpSiZhg4YgXv/2hABYSBbh5gW/JAmsap17YqWy/whq0BTdJ92d?=
 =?iso-8859-1?Q?eUzuQabuZJ2hraG6JJcaEtzCfzCYD7sRG5DrTjLR6uvEngOXsC9CIDUIFP?=
 =?iso-8859-1?Q?5CXKDQ2zo48iJTDeSdCWeSUb8JdI73wbB4quO0ySbXkAtgtq4W33+E/Nw6?=
 =?iso-8859-1?Q?pAEwZYV3OFn0X1o8ylkkYrXfPbOKkEHPAG2Pef6wHfFIEC80nFLf+hSCTo?=
 =?iso-8859-1?Q?6c83QUKU5k+V0GyDlC93Q9gzB5M6MM5QJJLJImOacEVdNqX6LHvXr5vseR?=
 =?iso-8859-1?Q?mtILqxnOAdUFWuqta4LazYb6+6F8qJHNSoo/k32FxtqiKBeaVztv01+g5X?=
 =?iso-8859-1?Q?+uSZV9yVmumJ2LXNs43gplC9dGvLthkeHLxCsRuHOhcv9le8AN5acc0FA4?=
 =?iso-8859-1?Q?WYJwrt2VgU4EJv0ADrNqQYVIDwMbkRzzUW4FizYmcCXgDiyB+UK3NSwtxb?=
 =?iso-8859-1?Q?h+csxS3s1lw9chmee9+1zpI6jP88qu9Kip/lB8U7WWEdABSeZzuDBDY762?=
 =?iso-8859-1?Q?gpT3vm6N3Cu+bByEuRqObkyBE83byNimBJWl7pEqAPbnd5BwfarO4K/omK?=
 =?iso-8859-1?Q?egyKngKZVQDBGR3zem+tTYJgJ80dJOqYq0Ms8Qna+4rz6lTqVcnHLNpW5F?=
 =?iso-8859-1?Q?l/Rrvjvy24XpU3yCrdQoJUCdAvm0tWwSTVGxOS1jNT7LqX0vAwIB1KOPjL?=
 =?iso-8859-1?Q?xRwoqFT2L/B5bchRteJLDH8lsWtPC35kehAvk14wXdQiCidPblR8sT1cyv?=
 =?iso-8859-1?Q?dPff1LYDrszw+GQSsrt+EGFG98/4tMRMpa3Exz5vJLVImK9AXOsSD00EOG?=
 =?iso-8859-1?Q?9g2sPxAOOp0sG6erstGSfXEi5cS3gdGO+ZR5wrzR5ZfW3KvJb2dgydOr2m?=
 =?iso-8859-1?Q?md4wXwq1ImwYbG9TvzYuoysLxnvXsIbNY06bYl6YXHskEYGhj/55JcLcW2?=
 =?iso-8859-1?Q?HyT1k+IUhE7kvHqjYBGQvS9ttJAGhsu007xSFZOJmGC///+Bg5EjsPALcU?=
 =?iso-8859-1?Q?jrh263oxHl8lh1dujMdgbB6w3SV3GOBBSSwH7HiGmpJQu7lq8b7xvzcwb2?=
 =?iso-8859-1?Q?Q+tBz87BjSEUBwQ9lwWTXaG/YsJCdPTyCJtkdh0n94i5LbEqFJt0cnTA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7388f0ef-cf6e-4f58-943a-08dcaac9835b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 03:42:45.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UD8yK80IdhyhMgXcJkBZUJuzQ6EoMMS9ELfJq7KZpTeqrZPrxHwThH4afezIr1Ixqi1VqLd2gTriezGu1xsG8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6973
X-OriginatorOrg: intel.com

hi, Roman,

On Sat, Jul 20, 2024 at 01:14:16AM +0800, Roman Gushchin wrote:
> On Tue, Jul 16, 2024 at 03:53:25PM +0800, Oliver Sang wrote:
> > hi, Roman,
> > 
> > On Mon, Jul 15, 2024 at 10:18:39PM +0000, Roman Gushchin wrote:
> > > On Mon, Jul 15, 2024 at 10:14:31PM +0800, Oliver Sang wrote:
> > > > hi, Roman Gushchin,
> > > > 
> > > > On Fri, Jul 12, 2024 at 07:03:31PM +0000, Roman Gushchin wrote:
> > > > > On Fri, Jul 12, 2024 at 02:04:48PM +0800, kernel test robot wrote:
> > > > > > 
> > > > > > 
> > > > > > Hello,
> > > > > > 
> > > > > > kernel test robot noticed a -29.4% regression of aim7.jobs-per-min on:
> > > > > > 
> > > > > > 
> > > > > > commit: 98c9daf5ae6be008f78c07b744bcff7bcc6e98da ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > > 
> > > > > Hello,
> > > > > 
> > > > > thank you for the report!
> > > > > 
> > > > > I'd expect that the regression should be fixed by the commit
> > > > > "mm: memcg: add cache line padding to mem_cgroup_per_node".
> > > > > 
> > > > > Can you, please, confirm that it's not the case?
> > > > > 
> > > > > Thank you!
> > > > 
> > > > in our this aim7 test, we found the performance partially recovered by
> > > > "mm: memcg: add cache line padding to mem_cgroup_per_node" but not fully
> > > 
> > > Thank you for providing the detailed information!
> > > 
> > > Can you, please, check if the following patch resolves the regression entirely?
> > 
> > no. in our tests, the following patch has little impact.
> > I directly apply it upon 6df13230b6 (if this is not the proper applyment, please
> > let me know, thanks)
> 
> Hm, interesting. And thank you for the confirmation, you did everything correct.
> Because the only thing the original patch did was a removal of few fields from
> the mem_cgroup_per_node struct, there are not many options left here.
> Would you mind to try the following patch?
> 
> Thank you and really appreciate your help!

you are welcome!

though we saw there are further discussions, we still share our test results to
you.

in our tests, by your new version patch, the regression is entirely resoloved.

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-13/performance/1BRD_48G/ext4/x86_64-rhel-8.3/3000/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/disk_rr/aim7

commit:
  94b7e5bf09 ("mm: memcg: put memcg1-specific struct mem_cgroup's members under CONFIG_MEMCG_V1")
  98c9daf5ae ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
  6df13230b6 ("mm: memcg: add cache line padding to mem_cgroup_per_node")
  981204d280 <--- your v2 "_pad2_" patch

94b7e5bf09b08aa4 98c9daf5ae6be008f78c07b744b 6df13230b612af81ce04f20bb37 981204d28033e8b3a33c3f18861
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
     76.42           +15.1%      87.99 ±  3%      +3.1%      78.77            +1.2%      77.31 ±  3%  uptime.boot
     53.28 ±  2%     -27.5%      38.65 ±  2%      -9.1%      48.45 ±  2%      -0.4%      53.06        iostat.cpu.idle
     44.58 ±  2%     +33.6%      59.58           +11.2%      49.57 ±  2%      +0.5%      44.80        iostat.cpu.system
      2.13           -17.0%       1.77            -7.1%       1.98            +0.4%       2.14        iostat.cpu.user
     49.85 ±  2%     -14.7       35.17 ±  2%      -5.2       44.66 ±  3%      -0.4       49.48        mpstat.cpu.all.idle%
      0.15 ±  7%      +0.0        0.15 ±  3%      -0.0        0.13 ±  4%      -0.0        0.15 ±  4%  mpstat.cpu.all.irq%
     47.74 ±  2%     +15.1       62.82            +5.4       53.14 ±  2%      +0.4       48.10        mpstat.cpu.all.sys%
      2.23            -0.4        1.82            -0.2        2.04            +0.0        2.24        mpstat.cpu.all.usr%
      4752 ± 13%     -18.1%       3890 ± 11%      -9.0%       4322 ± 19%      +5.5%       5014 ± 44%  sched_debug.cpu.avg_idle.min
      0.00 ± 32%     -49.2%       0.00 ±171%     -62.3%       0.00 ± 99%     -34.2%       0.00 ± 89%  sched_debug.rt_rq:.rt_time.avg
      0.19 ± 32%     -49.2%       0.10 ±171%     -62.3%       0.07 ± 99%     -34.2%       0.13 ± 89%  sched_debug.rt_rq:.rt_time.max
      0.02 ± 32%     -49.2%       0.01 ±171%     -62.3%       0.01 ± 99%     -34.2%       0.01 ± 89%  sched_debug.rt_rq:.rt_time.stddev
     53.29 ±  2%     -27.4%      38.70 ±  2%      -9.4%      48.28 ±  2%      -0.4%      53.07        vmstat.cpu.id
 2.242e+08            -0.0%  2.242e+08            +0.0%  2.243e+08           +14.7%  2.573e+08        vmstat.memory.free
     65.83 ±  4%     +59.1%     104.76 ±  3%     +19.0%      78.35 ±  3%      -0.7%      65.39 ±  4%  vmstat.procs.r
      8385 ±  4%     +34.6%      11284 ±  3%     +20.5%      10101 ±  8%      +2.2%       8573 ±  6%  vmstat.system.cs
    245966 ±  2%      +8.1%     265964           +19.3%     293498 ±  2%      +0.2%     246520        vmstat.system.in
    778685           -29.4%     549435           -10.3%     698378            +0.2%     779959        aim7.jobs-per-min
     23.31           +41.4%      32.96           +11.4%      25.96            -0.2%      23.27        aim7.time.elapsed_time
     23.31           +41.4%      32.96           +11.4%      25.96            -0.2%      23.27        aim7.time.elapsed_time.max
     47890 ±  7%    +338.5%     210000 ±  3%    +117.1%     103949 ±  7%      +4.6%      50095 ±  6%  aim7.time.involuntary_context_switches
      6674           +26.7%       8455           +10.5%       7372            -0.2%       6657        aim7.time.percent_of_cpu_this_job_got
      1510           +81.7%       2744 ±  2%     +23.8%       1869            -0.4%       1504        aim7.time.system_time
     19454 ±  3%      +9.1%      21223 ±  3%      -3.5%      18782 ±  4%      -2.0%      19067 ±  3%  aim7.time.voluntary_context_switches
     23.31           +41.4%      32.96           +11.4%      25.96            -0.2%      23.27        time.elapsed_time
     23.31           +41.4%      32.96           +11.4%      25.96            -0.2%      23.27        time.elapsed_time.max
     47890 ±  7%    +338.5%     210000 ±  3%    +117.1%     103949 ±  7%      +4.6%      50095 ±  6%  time.involuntary_context_switches
      6674           +26.7%       8455           +10.5%       7372            -0.2%       6657        time.percent_of_cpu_this_job_got
      1510           +81.7%       2744 ±  2%     +23.8%       1869            -0.4%       1504        time.system_time
     45.72            -4.9%      43.47            -1.7%      44.96            -0.4%      45.53        time.user_time
     19454 ±  3%      +9.1%      21223 ±  3%      -3.5%      18782 ±  4%      -2.0%      19067 ±  3%  time.voluntary_context_switches
     49345 ±  6%    +108.4%     102820 ± 10%     +32.3%      65261 ±  5%      -4.1%      47303 ±  3%  meminfo.Active
     22670 ± 11%    +182.6%      64065 ± 15%     +57.3%      35667 ± 11%      -6.2%      21274 ±  7%  meminfo.Active(anon)
     26674 ±  4%     +45.3%      38754 ±  4%     +10.9%      29594 ±  5%      -2.4%      26028 ±  5%  meminfo.Active(file)
     33695           +18.6%      39973 ±  3%      +3.8%      34971            -1.2%      33306        meminfo.AnonHugePages
 1.154e+08            +0.0%  1.154e+08            +0.0%  1.154e+08           +14.3%  1.319e+08        meminfo.CommitLimit
 2.244e+08            -0.1%  2.241e+08            -0.4%  2.236e+08           +14.7%  2.573e+08        meminfo.DirectMap1G
   1360098 ±  3%     +14.0%    1551107 ±  2%      +1.6%    1381539 ±  3%      +3.3%    1405172 ±  3%  meminfo.Inactive
    803759           +15.0%     924519            +4.7%     841839            -0.5%     799481        meminfo.Inactive(anon)
     66977 ±  3%    +115.7%     144485 ±  7%     +21.0%      81015 ±  3%      -3.8%      64423 ±  2%  meminfo.Mapped
 2.216e+08            -0.1%  2.214e+08            -0.1%  2.214e+08           +14.9%  2.545e+08        meminfo.MemAvailable
 2.221e+08            -0.1%  2.219e+08            -0.0%   2.22e+08           +14.8%  2.551e+08        meminfo.MemFree
 2.307e+08            +0.0%  2.307e+08            +0.0%  2.307e+08           +14.3%  2.637e+08        meminfo.MemTotal
     78152 ±  9%    +188.4%     225431 ±  5%     +64.5%     128567 ±  5%      -9.6%      70624 ±  6%  meminfo.Shmem
     15327 ±  8%     +52.6%      23389 ± 11%     +29.5%      19853 ± 14%     +16.0%      17781 ± 10%  numa-meminfo.node0.Active
      1872 ± 53%    +100.1%       3747 ± 29%    +107.1%       3877 ± 31%    +127.8%       4264 ±  7%  numa-meminfo.node0.Active(anon)
     13455 ±  9%     +46.0%      19642 ± 10%     +18.7%      15975 ± 13%      +0.5%      13516 ± 12%  numa-meminfo.node0.Active(file)
    601453 ± 17%     -45.5%     327882 ± 59%     -66.4%     202373 ±109%     -52.6%     285131 ± 71%  numa-meminfo.node0.AnonPages
    875888 ± 10%     -25.8%     649771 ± 29%     -45.1%     480842 ± 47%     -32.6%     590166 ± 35%  numa-meminfo.node0.Inactive
    602152 ± 17%     -44.9%     331923 ± 58%     -66.2%     203431 ±109%     -52.6%     285685 ± 71%  numa-meminfo.node0.Inactive(anon)
     19657 ± 14%    +111.2%      41510 ± 18%     +76.5%      34690 ± 37%     +24.3%      24440 ± 48%  numa-meminfo.node0.Mapped
      6081 ± 16%     +84.9%      11247 ± 42%     +38.8%       8442 ± 13%     +38.5%       8422 ±  6%  numa-meminfo.node0.Shmem
     33647 ±  8%    +134.3%      78825 ± 15%     +35.8%      45703 ±  9%     -10.2%      30214 ±  3%  numa-meminfo.node1.Active
     20790 ± 14%    +188.7%      60020 ± 18%     +52.8%      31760 ± 14%     -16.7%      17318 ±  9%  numa-meminfo.node1.Active(anon)
     12857 ±  7%     +46.3%      18805 ±  9%      +8.4%      13942 ±  8%      +0.3%      12896 ± 10%  numa-meminfo.node1.Active(file)
    150990 ± 70%    +190.9%     439229 ± 44%    +264.7%     550716 ± 40%    +210.3%     468571 ± 43%  numa-meminfo.node1.AnonPages
    180780 ± 55%    +160.4%     470756 ± 41%    +220.7%     579702 ± 39%    +173.1%     493698 ± 42%  numa-meminfo.node1.AnonPages.max
    485228 ± 23%     +85.5%     899983 ± 21%     +85.5%     900160 ± 25%     +67.6%     813028 ± 26%  numa-meminfo.node1.Inactive
    202089 ± 50%    +192.9%     591917 ± 32%    +215.8%     638153 ± 34%    +154.3%     513982 ± 39%  numa-meminfo.node1.Inactive(anon)
     47991 ±  7%    +112.0%     101755 ±  8%      -2.6%      46748 ± 32%     -15.0%      40769 ± 26%  numa-meminfo.node1.Mapped
  93326924            +0.8%   94106109            +1.2%   94466709           +36.2%  1.271e+08        numa-meminfo.node1.MemFree
  99028084            +0.0%   99028084            +0.0%   99028084           +33.4%  1.321e+08        numa-meminfo.node1.MemTotal
     72431 ±  8%    +194.1%     213055 ±  4%     +65.2%     119653 ±  5%     -12.7%      63207 ±  6%  numa-meminfo.node1.Shmem
    467.96 ± 53%     +99.5%     933.35 ± 29%    +107.2%     969.49 ± 31%    +127.9%       1066 ±  7%  numa-vmstat.node0.nr_active_anon
      3290 ± 10%     +50.9%       4965 ± 10%     +20.2%       3956 ±  7%      -0.4%       3277 ± 10%  numa-vmstat.node0.nr_active_file
    150399 ± 17%     -45.5%      82004 ± 59%     -66.3%      50675 ±109%     -52.7%      71196 ± 71%  numa-vmstat.node0.nr_anon_pages
    150570 ± 17%     -45.0%      82828 ± 59%     -66.2%      50936 ±108%     -52.6%      71333 ± 71%  numa-vmstat.node0.nr_inactive_anon
      4793 ± 17%    +113.8%      10249 ± 20%     +84.1%       8827 ± 36%     +31.7%       6311 ± 48%  numa-vmstat.node0.nr_mapped
      1519 ± 16%     +72.6%       2622 ± 33%     +38.8%       2110 ± 13%     +38.5%       2105 ±  6%  numa-vmstat.node0.nr_shmem
    467.96 ± 53%     +99.4%     933.32 ± 29%    +107.2%     969.49 ± 31%    +127.9%       1066 ±  7%  numa-vmstat.node0.nr_zone_active_anon
      3294 ±  9%     +50.9%       4970 ± 10%     +20.4%       3967 ±  7%      +0.1%       3296 ±  9%  numa-vmstat.node0.nr_zone_active_file
    150570 ± 17%     -45.0%      82827 ± 59%     -66.2%      50936 ±108%     -52.6%      71333 ± 71%  numa-vmstat.node0.nr_zone_inactive_anon
      4955 ± 11%    +202.3%      14980 ± 18%     +61.8%       8017 ± 16%     -10.0%       4458 ±  9%  numa-vmstat.node1.nr_active_anon
      3376 ±  8%     +40.1%       4729 ±  7%      +7.0%       3611 ± 13%      -4.1%       3238 ±  8%  numa-vmstat.node1.nr_active_file
     38044 ± 69%    +188.6%     109788 ± 44%    +261.9%     137690 ± 40%    +207.9%     117122 ± 43%  numa-vmstat.node1.nr_anon_pages
  23331085            +0.8%   23527208            +1.2%   23617254           +36.2%   31785125        numa-vmstat.node1.nr_free_pages
     50152 ± 51%    +194.6%     147731 ± 32%    +218.6%     159767 ± 34%    +156.6%     128700 ± 39%  numa-vmstat.node1.nr_inactive_anon
     12101 ±  7%    +109.5%      25357 ±  8%      -1.6%      11908 ± 33%     -13.7%      10445 ± 27%  numa-vmstat.node1.nr_mapped
    393216            +0.0%     393216            +0.0%     393216           +33.3%     524288        numa-vmstat.node1.nr_memmap_boot
     17201 ±  7%    +208.3%      53026 ±  4%     +75.7%      30214 ±  8%      -6.1%      16157 ±  5%  numa-vmstat.node1.nr_shmem
      4955 ± 11%    +202.3%      14980 ± 18%     +61.8%       8017 ± 16%     -10.0%       4458 ±  9%  numa-vmstat.node1.nr_zone_active_anon
      3352 ±  8%     +41.1%       4729 ±  7%      +7.8%       3612 ± 13%      -3.7%       3228 ±  7%  numa-vmstat.node1.nr_zone_active_file
     50150 ± 51%    +194.6%     147730 ± 32%    +218.6%     159766 ± 34%    +156.6%     128700 ± 39%  numa-vmstat.node1.nr_zone_inactive_anon
      5776 ± 11%    +175.1%      15893 ± 16%     +55.0%       8953 ± 11%      -5.9%       5433 ±  7%  proc-vmstat.nr_active_anon
      6595 ±  8%     +46.7%       9677 ±  3%     +12.6%       7424 ±  5%      -1.4%       6506 ±  7%  proc-vmstat.nr_active_file
    187950            +2.0%     191760            +0.1%     188193            +0.2%     188345        proc-vmstat.nr_anon_pages
   5532779            -0.1%    5528733            -0.0%    5530018           +14.9%    6354839        proc-vmstat.nr_dirty_background_threshold
  11079086            -0.1%   11070986            -0.0%   11073558           +14.9%   12725216        proc-vmstat.nr_dirty_threshold
    945653            +6.0%    1002646            +1.0%     955008            +1.1%     956077        proc-vmstat.nr_file_pages
  55532095            -0.1%   55470389            -0.0%   55507767           +14.8%   63769166        proc-vmstat.nr_free_pages
    201118           +14.8%     230842            +4.7%     210479            -0.6%     199886        proc-vmstat.nr_inactive_anon
     17214 ±  3%    +108.2%      35836 ±  6%     +20.0%      20660 ±  3%      -3.9%      16541 ±  2%  proc-vmstat.nr_mapped
    916480            +0.0%     916480            +0.0%     916480           +14.3%    1047552        proc-vmstat.nr_memmap_boot
     19951 ±  8%    +180.4%      55933 ±  4%     +61.5%      32218 ±  5%      -9.8%      17996 ±  5%  proc-vmstat.nr_shmem
     40267            +2.7%      41335            -0.7%      39991            +0.9%      40618        proc-vmstat.nr_slab_reclaimable
     86277            +1.8%      87792            +0.1%      86326            +0.8%      86995        proc-vmstat.nr_slab_unreclaimable
      5776 ± 11%    +175.1%      15893 ± 16%     +55.0%       8953 ± 11%      -5.9%       5433 ±  7%  proc-vmstat.nr_zone_active_anon
      6595 ±  8%     +46.7%       9677 ±  3%     +12.6%       7424 ±  5%      -1.3%       6506 ±  7%  proc-vmstat.nr_zone_active_file
    201118           +14.8%     230842            +4.7%     210479            -0.6%     199886        proc-vmstat.nr_zone_inactive_anon
    312.12 ±241%   +1618.1%       5362 ±125%    +521.3%       1939 ±171%     -88.9%      34.75 ±131%  proc-vmstat.numa_pages_migrated
    369792           +19.6%     442285 ±  3%      +2.9%     380386            -1.8%     363217        proc-vmstat.pgfault
    312.12 ±241%   +1618.1%       5362 ±125%    +521.3%       1939 ±171%     -88.9%      34.75 ±131%  proc-vmstat.pgmigrate_success
      2426 ±  2%     +29.2%       3135 ±  3%     +16.3%       2821 ±  3%      +1.3%       2457        proc-vmstat.pgpgout
      1515            +3.8%       1572            +1.3%       1535            -0.2%       1512        proc-vmstat.unevictable_pgs_culled
      0.63 ±  3%     +36.5%       0.85 ±  2%     +19.4%       0.75 ±  2%      -0.7%       0.62 ±  5%  perf-stat.i.MPKI
 1.885e+10           -23.7%  1.437e+10            -7.4%  1.745e+10 ±  2%      -0.8%  1.869e+10        perf-stat.i.branch-instructions
      2.78 ±  2%      -0.5        2.29 ±  4%      -0.2        2.55 ±  4%      +0.1        2.84 ±  4%  perf-stat.i.branch-miss-rate%
  67232899           -17.4%   55553782 ±  3%      -5.8%   63348903            -0.5%   66913803        perf-stat.i.branch-misses
     13.70 ±  3%      +2.5       16.17 ±  3%      +1.1       14.84 ±  2%      -0.3       13.40 ±  4%  perf-stat.i.cache-miss-rate%
  72591570 ±  2%      +0.6%   73035167           +10.8%   80408900 ±  3%      +0.5%   72971231 ±  3%  perf-stat.i.cache-misses
 5.483e+08           -24.9%  4.118e+08            -5.7%   5.17e+08 ±  2%      -0.8%  5.441e+08        perf-stat.i.cache-references
      8605 ±  4%     +34.7%      11593 ±  4%     +23.4%      10618 ±  7%      +2.7%       8834 ±  8%  perf-stat.i.context-switches
      1.35           +65.4%       2.22 ±  3%     +20.9%       1.63            -1.2%       1.33        perf-stat.i.cpi
 1.616e+11           +22.1%  1.973e+11           +10.5%  1.785e+11 ±  2%      -1.5%  1.592e+11        perf-stat.i.cpu-cycles
 8.537e+10           -24.8%  6.416e+10            -8.0%  7.852e+10 ±  2%      -0.8%  8.465e+10        perf-stat.i.instructions
      0.96           -22.2%       0.75 ±  2%      -9.4%       0.87            +1.5%       0.98 ±  2%  perf-stat.i.ipc
     13455           -15.4%      11379 ±  3%      -7.6%      12438            +0.3%      13496        perf-stat.i.minor-faults
     13489           -15.5%      11396 ±  3%      -7.6%      12465            +0.2%      13522        perf-stat.i.page-faults
      0.85 ±  3%     +34.8%       1.15           +20.2%       1.02 ±  3%      +1.2%       0.86 ±  3%  perf-stat.overall.MPKI
      0.34            +0.0        0.36 ±  2%      +0.0        0.35            +0.0        0.35        perf-stat.overall.branch-miss-rate%
     13.23 ±  3%      +4.6       17.78            +2.3       15.52 ±  2%      +0.2       13.38 ±  2%  perf-stat.overall.cache-miss-rate%
      1.90           +62.8%       3.08           +20.1%       2.28            -0.7%       1.88        perf-stat.overall.cpi
      2231 ±  3%     +20.6%       2690 ±  2%      -0.2%       2227 ±  2%      -1.9%       2189 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.53           -38.5%       0.32           -16.7%       0.44            +0.7%       0.53        perf-stat.overall.ipc
  1.86e+10           -23.0%  1.433e+10            -7.6%  1.719e+10            -0.9%  1.844e+10        perf-stat.ps.branch-instructions
  64095803           -19.1%   51843320 ±  2%      -5.7%   60421424            -0.3%   63895014        perf-stat.ps.branch-misses
  71639076 ±  2%      +2.3%   73304464 ±  2%     +10.4%   79092736 ±  3%      +0.3%   71888849 ±  3%  perf-stat.ps.cache-misses
 5.417e+08           -23.9%  4.124e+08            -5.9%  5.096e+08 ±  2%      -0.8%  5.372e+08        perf-stat.ps.cache-references
      8220 ±  4%     +33.3%      10962 ±  4%     +23.9%      10184 ±  8%      +2.4%       8418 ±  7%  perf-stat.ps.context-switches
 1.597e+11           +23.5%  1.972e+11 ±  2%     +10.2%  1.761e+11 ±  2%      -1.5%  1.573e+11        perf-stat.ps.cpu-cycles
 8.426e+10           -24.1%  6.394e+10            -8.2%  7.737e+10 ±  2%      -0.9%  8.353e+10        perf-stat.ps.instructions
     12730           -18.7%      10354 ±  3%      -7.2%      11811            +0.2%      12756        perf-stat.ps.minor-faults
     12762           -18.8%      10369 ±  3%      -7.3%      11836            +0.1%      12781        perf-stat.ps.page-faults
      4.35 ± 10%      -4.4        0.00            -3.5        0.81 ± 20%      -0.2        4.14 ± 11%  perf-profile.calltrace.cycles-pp.unlink
      4.35 ± 10%      -4.3        0.00            -3.5        0.81 ± 19%      -0.2        4.13 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.35 ± 10%      -4.3        0.00            -3.5        0.81 ± 19%      -0.2        4.13 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      4.34 ± 10%      -4.3        0.00            -3.5        0.80 ± 19%      -0.2        4.12 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.34 ± 10%      -4.3        0.00            -3.5        0.80 ± 20%      -0.2        4.12 ± 11%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.14 ± 10%      -4.1        0.00            -3.5        0.65 ± 24%      -0.2        3.93 ± 11%  perf-profile.calltrace.cycles-pp.down_write.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.14 ± 10%      -4.1        0.00            -3.5        0.65 ± 24%      -0.2        3.92 ± 11%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      4.14 ± 10%      -4.1        0.00            -3.6        0.58 ± 45%      -0.2        3.92 ± 11%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_unlinkat.__x64_sys_unlink
      3.99 ± 11%      -4.0        0.00            -3.6        0.40 ± 83%      -0.2        3.76 ± 12%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_unlinkat
      3.53 ±  6%      -3.4        0.10 ±212%      -2.4        1.12 ± 17%      -0.2        3.37 ±  8%  perf-profile.calltrace.cycles-pp.down_write.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      3.53 ±  6%      -3.4        0.10 ±212%      -2.4        1.12 ± 17%      -0.2        3.37 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat.do_filp_open
      3.52 ±  6%      -3.4        0.10 ±212%      -2.4        1.12 ± 17%      -0.2        3.36 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat
      3.30 ±  7%      -3.3        0.00            -2.3        0.98 ± 19%      -0.2        3.13 ±  8%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups
      3.93 ±  6%      -3.2        0.69 ±  8%      -2.5        1.44 ± 13%      -0.2        3.76 ±  7%  perf-profile.calltrace.cycles-pp.creat64
      3.93 ±  6%      -3.2        0.69 ±  8%      -2.5        1.44 ± 13%      -0.2        3.76 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      3.93 ±  6%      -3.2        0.69 ±  8%      -2.5        1.44 ± 13%      -0.2        3.76 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      3.92 ±  6%      -3.2        0.68 ±  8%      -2.5        1.43 ± 13%      -0.2        3.75 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      3.92 ±  6%      -3.2        0.68 ±  8%      -2.5        1.43 ± 13%      -0.2        3.75 ±  7%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      3.91 ±  6%      -3.2        0.68 ±  8%      -2.5        1.42 ± 13%      -0.2        3.74 ±  7%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64
      3.91 ±  6%      -3.2        0.68 ±  8%      -2.5        1.42 ± 13%      -0.2        3.74 ±  7%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.87 ±  6%      -3.2        0.65 ±  9%      -2.5        1.39 ± 14%      -0.2        3.70 ±  7%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      3.66            -1.7        1.99 ±  2%      -0.6        3.06            +0.0        3.70        perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      3.31            -1.5        1.77 ±  2%      -0.6        2.73            +0.1        3.36        perf-profile.calltrace.cycles-pp.llseek
      2.87            -1.3        1.62 ±  2%      -0.5        2.33            +0.0        2.87        perf-profile.calltrace.cycles-pp.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      2.25            -1.0        1.29 ±  2%      -0.4        1.83            +0.0        2.26        perf-profile.calltrace.cycles-pp.block_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      2.17            -0.9        1.25 ±  2%      -0.4        1.76            +0.0        2.18        perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
      0.86 ±  4%      -0.9        0.00            -0.2        0.62 ±  4%      +0.0        0.87 ±  3%  perf-profile.calltrace.cycles-pp.workingset_age_nonresident.workingset_activation.folio_mark_accessed.filemap_read.vfs_read
      0.79            -0.8        0.00            -0.1        0.74            +0.1        0.85        perf-profile.calltrace.cycles-pp.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.93            -0.8        1.14 ±  2%      -0.3        1.66            -0.0        1.92        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.76            -0.8        0.00            -0.2        0.58            -0.0        0.76 ±  2%  perf-profile.calltrace.cycles-pp.file_modified.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
      1.99            -0.8        1.23 ±  2%      -0.4        1.63            +0.0        2.00        perf-profile.calltrace.cycles-pp.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.74            -0.7        0.00            -0.2        0.58            +0.0        0.74        perf-profile.calltrace.cycles-pp.folio_alloc_noprof.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.79            -0.7        1.07 ±  2%      -0.2        1.55            -0.0        1.78        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
      0.72 ±  2%      -0.7        0.00            -0.2        0.54 ±  4%      -0.0        0.70        perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.69            -0.7        0.00            -0.2        0.54            +0.0        0.70        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_noprof.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.68            -0.7        0.00            -0.2        0.53            +0.0        0.69        perf-profile.calltrace.cycles-pp.touch_atime.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.67            -0.7        0.00            -0.7        0.00            -0.0        0.65        perf-profile.calltrace.cycles-pp.folio_account_dirtied.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end
      1.34            -0.7        0.68 ±  3%      -0.3        1.05            -0.0        1.34        perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.65 ±  2%      -0.7        0.00            -0.1        0.52            -0.0        0.65 ±  2%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      1.30            -0.6        0.66 ±  3%      -0.3        1.02            -0.0        1.30        perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.61            -0.6        0.00            -0.0        0.59            +0.1        0.67        perf-profile.calltrace.cycles-pp.folio_alloc_buffers.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      1.22            -0.6        0.65 ±  2%      -0.2        0.99            +0.0        1.24        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      1.17            -0.5        0.63 ±  2%      -0.2        1.00            +0.0        1.21        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.54 ±  2%      -0.5        0.00            -0.0        0.52            +0.0        0.59        perf-profile.calltrace.cycles-pp.alloc_buffer_head.folio_alloc_buffers.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin
      1.21            -0.5        0.67 ±  2%      -0.3        0.91            -0.0        1.19        perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_write_end.generic_perform_write
      0.96            -0.5        0.43 ± 47%      -0.1        0.83            +0.0        1.00        perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read.ksys_read
      1.08            -0.5        0.57 ±  3%      -0.2        0.86            -0.0        1.06        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      1.08            -0.5        0.57 ±  2%      -0.2        0.88            +0.0        1.09        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      1.20            -0.5        0.70 ±  3%      -0.2        1.02            -0.0        1.19        perf-profile.calltrace.cycles-pp.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.05            -0.5        0.56 ±  2%      -0.2        0.85            -0.0        1.05        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.91            -0.5        0.42 ± 47%      -0.2        0.67            -0.0        0.89        perf-profile.calltrace.cycles-pp.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_write_end
      1.15            -0.5        0.68 ±  2%      -0.2        0.99            -0.0        1.14        perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      1.02            -0.5        0.55 ±  2%      -0.2        0.86            +0.0        1.05        perf-profile.calltrace.cycles-pp.clear_bhb_loop.llseek
      1.30            -0.5        0.83 ±  2%      -0.2        1.05            +0.0        1.30        perf-profile.calltrace.cycles-pp.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict
      0.98            -0.5        0.53 ±  2%      -0.2        0.82            +0.0        1.00        perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      1.10 ±  3%      -0.4        0.67 ±  3%      -0.3        0.80 ±  3%      +0.0        1.10 ±  2%  perf-profile.calltrace.cycles-pp.workingset_activation.folio_mark_accessed.filemap_read.vfs_read.ksys_read
     30.65            -0.4       30.25            +0.7       31.31            +0.1       30.71        perf-profile.calltrace.cycles-pp.read
      0.98            -0.3        0.69 ±  2%      -0.4        0.61            -0.2        0.77        perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.13 ±173%      -0.1        0.00            -0.1        0.00            +0.4        0.53        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.alloc_buffer_head.folio_alloc_buffers.create_empty_buffers.ext4_block_write_begin
      2.39            +0.2        2.61            +0.1        2.47            +0.0        2.39        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
      2.42            +0.2        2.64            +0.1        2.50            -0.0        2.42        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      2.39            +0.2        2.61            +0.1        2.48            +0.0        2.39        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range
      2.42            +0.2        2.64            +0.1        2.50            +0.0        2.42        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      2.38            +0.2        2.61            +0.1        2.47            +0.0        2.39        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      2.44            +0.4        2.89            +0.2        2.62            +0.0        2.45        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      2.38            +0.5        2.84            +0.2        2.56            +0.0        2.39        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      2.38            +0.5        2.84            +0.2        2.56            +0.0        2.39        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range
      2.38            +0.5        2.84            +0.2        2.56            +0.0        2.39        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release
     28.52            +0.6       29.11            +1.0       29.54            +0.0       28.55        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     28.38            +0.7       29.04            +1.0       29.42            +0.0       28.40        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.86            +0.7        5.54            +0.3        5.13            +0.0        4.87        perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
     27.89            +0.9       28.77            +1.1       29.02            +0.0       27.90        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     27.47            +1.1       28.54            +1.2       28.67            +0.0       27.48        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     25.90            +1.9       27.78            +1.5       27.42            -0.0       25.90        perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.26            +4.0       34.31            +3.9       34.16            +0.1       30.37        perf-profile.calltrace.cycles-pp.write
     21.06            +4.1       25.14            +2.3       23.39            -0.0       21.02        perf-profile.calltrace.cycles-pp.folio_mark_accessed.filemap_read.vfs_read.ksys_read.do_syscall_64
     19.70            +4.6       24.33            +2.7       22.38            -0.0       19.66        perf-profile.calltrace.cycles-pp.folio_activate.folio_mark_accessed.filemap_read.vfs_read.ksys_read
     19.63            +4.7       24.29            +2.7       22.32            -0.0       19.59        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_activate.folio_mark_accessed.filemap_read.vfs_read
     18.85            +4.7       23.52            +2.7       21.52            -0.1       18.80        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed.filemap_read
     18.84            +4.7       23.51            +2.7       21.52            -0.0       18.79        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed
     18.83            +4.7       23.51            +2.7       21.51            -0.0       18.78        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate
     28.38            +5.0       33.33            +4.3       32.65            +0.1       28.49        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     28.23            +5.0       33.25            +4.3       32.53            +0.1       28.34        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     27.72            +5.3       32.99            +4.4       32.13            +0.1       27.83        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     27.25            +5.5       32.74            +4.5       31.75            +0.1       27.35        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     25.87            +5.6       31.48            +2.2       28.03            +0.1       26.02        perf-profile.calltrace.cycles-pp.__close
     25.86            +5.6       31.47            +2.2       28.02            +0.1       26.01        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.86            +5.6       31.47            +2.2       28.02            +0.1       26.01        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     25.86            +5.6       31.46            +2.2       28.01            +0.1       26.00        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.84            +5.6       31.45            +2.2       28.00            +0.2       25.99        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.82            +5.6       31.44            +2.2       27.99            +0.1       25.97        perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.81            +5.6       31.44            +2.2       27.98            +0.1       25.96        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.__x64_sys_close.do_syscall_64
     25.79            +5.6       31.43            +2.2       27.96            +0.1       25.94        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.__x64_sys_close
     25.78            +5.6       31.42            +2.2       27.95            +0.1       25.93        perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dput.__fput
     25.63            +5.7       31.33            +2.2       27.83            +0.1       25.78        perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dput
     17.98            +6.1       24.07            +2.4       20.42            +0.1       18.10        perf-profile.calltrace.cycles-pp.folios_put_refs.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
     17.57            +6.2       23.81            +2.5       20.06            +0.1       17.69        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.truncate_inode_pages_range.ext4_evict_inode.evict
     17.33            +6.3       23.66            +2.5       19.86            +0.1       17.45        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.truncate_inode_pages_range
     17.34            +6.3       23.66            +2.5       19.86            +0.1       17.45        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.truncate_inode_pages_range.ext4_evict_inode
     17.32            +6.3       23.65            +2.5       19.85            +0.1       17.44        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     25.47            +6.5       31.92            +4.9       30.41            +0.1       25.58 ±  2%  perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.72 ±  2%      +7.3       31.06            +5.3       29.06            +0.1       23.84 ±  2%  perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
     17.89 ±  3%     +10.1       27.95            +6.5       24.39            +0.2       18.04 ±  3%  perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
     13.68 ±  4%     +12.1       25.73            +7.3       20.95            +0.1       13.79 ±  4%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
     11.76 ±  5%     +13.0       24.76            +7.7       19.42            +0.1       11.85 ±  5%  perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      9.80 ±  6%     +13.4       23.16            +8.1       17.87            +0.3       10.09 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio
      9.81 ±  6%     +13.4       23.17            +8.1       17.87            +0.3       10.10 ±  6%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio
      9.79 ±  6%     +13.4       23.16            +8.1       17.86            +0.3       10.08 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     10.38 ±  6%     +13.5       23.85            +8.1       18.48            +0.3       10.67 ±  5%  perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
     10.32 ±  6%     +13.5       23.82            +8.1       18.43            +0.3       10.61 ±  5%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
      8.04 ±  8%      -7.2        0.84 ±  9%      -6.0        2.06 ± 17%      -0.4        7.66 ±  9%  perf-profile.children.cycles-pp.down_write
      7.67 ±  8%      -7.0        0.65 ± 12%      -5.9        1.77 ± 19%      -0.4        7.29 ± 10%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      7.66 ±  8%      -7.0        0.64 ± 12%      -5.9        1.76 ± 19%      -0.4        7.28 ± 10%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      7.28 ±  9%      -6.8        0.53 ± 14%      -5.7        1.54 ± 21%      -0.4        6.90 ± 10%  perf-profile.children.cycles-pp.osq_lock
      4.35 ± 10%      -4.1        0.30 ±  8%      -3.5        0.81 ± 19%      -0.2        4.14 ± 11%  perf-profile.children.cycles-pp.unlink
      4.34 ± 10%      -4.0        0.29 ±  8%      -3.5        0.80 ± 19%      -0.2        4.12 ± 11%  perf-profile.children.cycles-pp.__x64_sys_unlink
      4.34 ± 10%      -4.0        0.29 ±  8%      -3.5        0.80 ± 20%      -0.2        4.12 ± 11%  perf-profile.children.cycles-pp.do_unlinkat
      3.97 ±  6%      -3.3        0.71 ±  8%      -2.5        1.47 ± 13%      -0.2        3.80 ±  7%  perf-profile.children.cycles-pp.do_sys_openat2
      3.95 ±  6%      -3.2        0.70 ±  8%      -2.5        1.45 ± 13%      -0.2        3.78 ±  7%  perf-profile.children.cycles-pp.path_openat
      3.95 ±  6%      -3.2        0.70 ±  8%      -2.5        1.45 ± 13%      -0.2        3.78 ±  7%  perf-profile.children.cycles-pp.do_filp_open
      3.93 ±  6%      -3.2        0.69 ±  8%      -2.5        1.44 ± 13%      -0.2        3.76 ±  7%  perf-profile.children.cycles-pp.creat64
      3.92 ±  6%      -3.2        0.68 ±  8%      -2.5        1.43 ± 13%      -0.2        3.75 ±  7%  perf-profile.children.cycles-pp.__x64_sys_creat
      3.87 ±  6%      -3.2        0.66 ±  8%      -2.5        1.39 ± 14%      -0.2        3.70 ±  7%  perf-profile.children.cycles-pp.open_last_lookups
      3.70            -1.7        1.98 ±  2%      -0.7        3.05            +0.1        3.76        perf-profile.children.cycles-pp.llseek
      3.68            -1.7        2.00 ±  2%      -0.6        3.08            +0.0        3.72        perf-profile.children.cycles-pp.ext4_block_write_begin
      3.12            -1.4        1.67 ±  2%      -0.5        2.57            +0.0        3.14        perf-profile.children.cycles-pp.clear_bhb_loop
      2.90            -1.3        1.64 ±  2%      -0.5        2.36            -0.0        2.90        perf-profile.children.cycles-pp.ext4_da_write_end
      2.29            -1.0        1.31 ±  2%      -0.4        1.85            +0.0        2.29        perf-profile.children.cycles-pp.block_write_end
      2.20            -0.9        1.26 ±  2%      -0.4        1.78            +0.0        2.20        perf-profile.children.cycles-pp.__block_commit_write
      1.95            -0.8        1.15 ±  2%      -0.3        1.68            -0.0        1.94        perf-profile.children.cycles-pp.copy_page_to_iter
      1.99            -0.8        1.24 ±  2%      -0.4        1.64            +0.0        2.00        perf-profile.children.cycles-pp.truncate_cleanup_folio
      1.80            -0.7        1.08 ±  2%      -0.2        1.56            -0.0        1.79        perf-profile.children.cycles-pp._copy_to_iter
      1.54            -0.7        0.82 ±  2%      -0.3        1.27            +0.0        1.56        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.34            -0.7        0.68 ±  3%      -0.3        1.06            +0.0        1.35        perf-profile.children.cycles-pp.ext4_da_get_block_prep
      1.32            -0.7        0.67 ±  3%      -0.3        1.04            -0.0        1.32        perf-profile.children.cycles-pp.ext4_da_map_blocks
     31.04            -0.6       30.46            +0.6       31.63            +0.1       31.10        perf-profile.children.cycles-pp.read
      1.19            -0.6        0.64 ±  2%      -0.2        1.01            +0.0        1.24        perf-profile.children.cycles-pp.filemap_get_pages
      1.18            -0.5        0.63 ±  2%      -0.2        0.97            +0.0        1.20        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.22            -0.5        0.68 ±  2%      -0.3        0.92            -0.0        1.20        perf-profile.children.cycles-pp.mark_buffer_dirty
      1.20            -0.5        0.70 ±  2%      -0.2        1.02            -0.0        1.19        perf-profile.children.cycles-pp.zero_user_segments
      1.20            -0.5        0.71 ±  2%      -0.2        1.03            -0.0        1.20        perf-profile.children.cycles-pp.memset_orig
      1.07            -0.5        0.58 ±  2%      -0.2        0.87            -0.0        1.07        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.95            -0.5        0.46 ±  3%      -0.2        0.78 ±  4%      +0.0        0.97 ±  4%  perf-profile.children.cycles-pp.rw_verify_area
      1.32            -0.5        0.84 ±  2%      -0.3        1.06            +0.0        1.32        perf-profile.children.cycles-pp.try_to_free_buffers
      0.98            -0.5        0.53 ±  2%      -0.1        0.85            +0.1        1.04        perf-profile.children.cycles-pp.filemap_get_read_batch
      0.98 ±  2%      -0.4        0.53 ±  3%      -0.2        0.80            +0.0        1.00        perf-profile.children.cycles-pp.__fdget_pos
      0.77 ±  2%      -0.4        0.34 ±  3%      -0.2        0.58 ±  4%      -0.0        0.74        perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      1.10 ±  3%      -0.4        0.67 ±  3%      -0.3        0.80 ±  3%      +0.0        1.11 ±  2%  perf-profile.children.cycles-pp.workingset_activation
      0.80            -0.4        0.37 ±  2%      -0.2        0.60            -0.0        0.79        perf-profile.children.cycles-pp.file_modified
      0.86 ±  4%      -0.4        0.46 ±  3%      -0.2        0.62 ±  3%      +0.0        0.87 ±  3%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.77 ±  2%      -0.4        0.37 ±  3%      -0.1        0.64 ±  5%      +0.0        0.79 ±  6%  perf-profile.children.cycles-pp.security_file_permission
      0.92            -0.4        0.52 ±  2%      -0.2        0.68            -0.0        0.90        perf-profile.children.cycles-pp.__folio_mark_dirty
      0.80            -0.4        0.42 ±  2%      -0.1        0.65            +0.0        0.80        perf-profile.children.cycles-pp.xas_load
      0.74            -0.4        0.37 ±  3%      -0.2        0.58            +0.0        0.75        perf-profile.children.cycles-pp.folio_alloc_noprof
      0.70            -0.4        0.33 ±  3%      -0.2        0.54            +0.0        0.71        perf-profile.children.cycles-pp.touch_atime
      0.60 ±  2%      -0.4        0.24 ±  4%      -0.2        0.42            -0.0        0.59 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.71            -0.4        0.35 ±  3%      -0.2        0.55            -0.0        0.71        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.80            -0.4        0.45 ±  2%      -0.1        0.74            +0.1        0.86        perf-profile.children.cycles-pp.create_empty_buffers
      0.68 ±  2%      -0.3        0.36 ±  3%      -0.1        0.54            -0.0        0.68        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.62            -0.3        0.30 ±  3%      -0.1        0.48            +0.0        0.62        perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.59 ±  2%      -0.3        0.28 ±  3%      -0.1        0.48 ±  7%      +0.0        0.60 ±  8%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.62            -0.3        0.32 ±  3%      -0.1        0.49 ±  2%      -0.0        0.62        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.64            -0.3        0.34 ±  3%      -0.1        0.52            +0.0        0.65 ±  2%  perf-profile.children.cycles-pp.ksys_lseek
      1.01            -0.3        0.71 ±  2%      -0.4        0.62            -0.2        0.79        perf-profile.children.cycles-pp.__filemap_add_folio
      0.62            -0.3        0.32 ±  3%      -0.1        0.51            +0.0        0.64        perf-profile.children.cycles-pp.filemap_get_entry
      0.57            -0.3        0.28 ±  3%      -0.1        0.45            +0.0        0.58        perf-profile.children.cycles-pp.atime_needs_update
      0.69            -0.3        0.40 ±  2%      -0.2        0.50            -0.0        0.67        perf-profile.children.cycles-pp.folio_account_dirtied
      0.61            -0.3        0.32 ±  2%      -0.1        0.50 ±  3%      +0.0        0.61        perf-profile.children.cycles-pp.__cond_resched
      0.60 ±  2%      -0.3        0.32 ±  3%      -0.1        0.48            -0.0        0.59 ±  2%  perf-profile.children.cycles-pp.fault_in_readable
      0.62            -0.3        0.35 ±  2%      -0.0        0.59            +0.1        0.67        perf-profile.children.cycles-pp.folio_alloc_buffers
      0.58            -0.3        0.32 ±  2%      -0.1        0.48            +0.0        0.59        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.37 ±  3%      -0.3        0.11 ±  4%      -0.2        0.22 ±  6%      -0.0        0.37 ±  3%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.40 ±  6%      -0.3        0.14 ±  3%      -0.1        0.26 ±  5%      -0.0        0.38 ±  5%  perf-profile.children.cycles-pp.ext4_file_write_iter
      0.51 ±  3%      -0.2        0.27 ±  3%      -0.1        0.40 ±  2%      -0.0        0.51        perf-profile.children.cycles-pp.disk_rr
      0.59            -0.2        0.34 ±  2%      -0.1        0.49            +0.0        0.60        perf-profile.children.cycles-pp.kmem_cache_free
      0.46            -0.2        0.22 ±  2%      -0.1        0.36            +0.0        0.46        perf-profile.children.cycles-pp.get_page_from_freelist
      0.55 ±  2%      -0.2        0.31 ±  3%      -0.0        0.52            +0.0        0.59        perf-profile.children.cycles-pp.alloc_buffer_head
      0.53            -0.2        0.30 ±  2%      -0.0        0.51            +0.0        0.58        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.36 ±  3%      -0.2        0.14 ±  4%      -0.1        0.25 ±  2%      -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.36 ±  6%      -0.2        0.14 ±  5%      -0.1        0.25 ±  4%      -0.0        0.36 ±  4%  perf-profile.children.cycles-pp.ext4_file_read_iter
      0.40            -0.2        0.20 ±  2%      -0.1        0.33 ±  2%      +0.0        0.42 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.44            -0.2        0.25 ±  3%      -0.1        0.34            -0.0        0.42        perf-profile.children.cycles-pp.xas_store
      0.39            -0.2        0.19 ±  3%      -0.1        0.31 ±  3%      -0.0        0.39 ±  2%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.52            -0.2        0.33 ±  2%      -0.1        0.42            +0.0        0.52        perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.29 ±  4%      -0.2        0.10 ±  6%      -0.1        0.19 ±  3%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.generic_update_time
      0.36 ±  2%      -0.2        0.18 ±  4%      -0.1        0.28            +0.0        0.37        perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.57 ±  2%      -0.2        0.40 ±  3%      -0.1        0.44            +0.0        0.57        perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.34 ±  2%      -0.2        0.18 ±  3%      -0.1        0.29 ±  2%      +0.0        0.36        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.25 ±  4%      -0.2        0.09 ±  5%      -0.1        0.16 ±  4%      -0.0        0.25 ±  3%  perf-profile.children.cycles-pp.ext4_dirty_inode
      0.33            -0.2        0.17 ±  2%      -0.1        0.25            -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.34            -0.2        0.18 ±  2%      -0.1        0.27 ±  2%      +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.22 ±  5%      -0.2        0.06 ±  9%      -0.1        0.13 ±  3%      -0.0        0.21 ±  6%  perf-profile.children.cycles-pp.jbd2__journal_start
      0.21 ±  5%      -0.2        0.06 ±  8%      -0.1        0.12 ±  5%      -0.0        0.20 ±  6%  perf-profile.children.cycles-pp.start_this_handle
      0.31            -0.1        0.17 ±  3%      -0.1        0.25 ±  2%      +0.0        0.31        perf-profile.children.cycles-pp._raw_spin_lock
      0.40            -0.1        0.25 ±  2%      -0.1        0.30 ±  2%      +0.0        0.40 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.30 ±  2%      -0.1        0.17 ±  3%      -0.0        0.30 ±  3%      +0.0        0.34        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.31 ±  2%      -0.1        0.18 ±  2%      -0.1        0.26 ±  2%      +0.0        0.31        perf-profile.children.cycles-pp.block_invalidate_folio
      0.29 ±  2%      -0.1        0.16 ±  2%      -0.0        0.24 ±  2%      +0.0        0.30        perf-profile.children.cycles-pp.x64_sys_call
      0.49            -0.1        0.36 ±  3%      -0.1        0.38            -0.0        0.48        perf-profile.children.cycles-pp.folio_account_cleaned
      0.32            -0.1        0.19 ±  2%      -0.1        0.25 ±  2%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.lookup_open
      0.27            -0.1        0.14 ±  2%      -0.1        0.22 ±  2%      -0.0        0.27 ±  2%  perf-profile.children.cycles-pp.generic_write_checks
      0.26 ±  3%      -0.1        0.13 ±  3%      -0.1        0.21 ±  3%      -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.26 ±  2%      -0.1        0.13 ±  4%      -0.1        0.20            +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.27 ±  2%      -0.1        0.14 ±  4%      -0.1        0.22 ±  2%      +0.0        0.27        perf-profile.children.cycles-pp.up_write
      0.27            -0.1        0.14 ±  3%      -0.0        0.22            +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.xas_start
      0.35 ±  2%      -0.1        0.22            -0.1        0.27 ±  2%      +0.0        0.35 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.17 ±  4%      -0.1        0.06 ±  6%      -0.1        0.12 ±  4%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.ext4_nonda_switch
      0.23            -0.1        0.12 ±  3%      -0.0        0.18            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.folio_unlock
      0.22 ±  2%      -0.1        0.12 ±  3%      -0.0        0.18 ±  2%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.current_time
      0.27            -0.1        0.16 ±  3%      -0.0        0.23 ±  2%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.27 ±  2%      -0.1        0.17 ±  3%      -0.1        0.20 ±  2%      -0.0        0.27 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.18            -0.1        0.08 ±  5%      -0.0        0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.node_dirty_ok
      0.21 ±  2%      -0.1        0.12 ±  4%      -0.0        0.17            -0.0        0.21        perf-profile.children.cycles-pp.__slab_free
      0.26 ±  3%      -0.1        0.16 ±  2%      -0.1        0.20 ±  2%      +0.0        0.26 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.93 ±  2%      -0.1        0.84 ±  3%      -0.2        0.72 ±  2%      -0.0        0.92        perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.18 ±  2%      -0.1        0.09 ±  3%      -0.0        0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.19 ±  2%      -0.1        0.10 ±  5%      -0.0        0.14 ±  3%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.aa_file_perm
      0.20            -0.1        0.11 ±  2%      -0.0        0.16 ±  2%      +0.0        0.20        perf-profile.children.cycles-pp.__mod_node_page_state
      0.21            -0.1        0.12 ±  2%      -0.0        0.16 ±  2%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.ext4_create
      0.18            -0.1        0.09 ±  4%      -0.0        0.14            +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.20 ±  2%      -0.1        0.12 ±  4%      -0.0        0.17            +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.find_lock_entries
      0.17 ±  5%      -0.1        0.08 ±  5%      -0.0        0.14 ±  7%      -0.0        0.17 ±  5%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.19 ±  2%      -0.1        0.10 ±  4%      -0.0        0.15 ±  3%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.17            -0.1        0.09 ±  4%      -0.0        0.13 ±  3%      +0.0        0.17        perf-profile.children.cycles-pp.__dquot_alloc_space
      0.08            -0.1        0.00            -0.0        0.06 ±  5%      +0.0        0.08        perf-profile.children.cycles-pp.__mod_zone_page_state
      0.21 ±  2%      -0.1        0.13 ±  3%      -0.1        0.16            +0.0        0.21 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.08 ±  5%      -0.1        0.00            -0.0        0.06 ±  7%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp._raw_read_lock
      0.08 ±  5%      -0.1        0.00            -0.0        0.06            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.rcu_core
      0.17            -0.1        0.09 ±  4%      -0.0        0.14 ±  2%      +0.0        0.17        perf-profile.children.cycles-pp.free_unref_folios
      0.09 ±  3%      -0.1        0.01 ±163%      -0.0        0.07 ±  4%      +0.0        0.09 ±  3%  perf-profile.children.cycles-pp.generic_file_llseek_size
      0.08 ±  6%      -0.1        0.00            -0.0        0.06 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.rcu_do_batch
      0.20 ±  3%      -0.1        0.13 ±  3%      -0.0        0.15 ±  2%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.16 ±  2%      -0.1        0.09 ±  4%      -0.0        0.13 ±  3%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.vfs_unlink
      0.08 ±  4%      -0.1        0.00 ±316%      -0.0        0.06 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.xas_create
      0.09 ±  5%      -0.1        0.01 ±163%      -0.0        0.07 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.generic_file_read_iter
      0.19            -0.1        0.12 ±  4%      -0.0        0.16 ±  2%      +0.0        0.19        perf-profile.children.cycles-pp.mod_objcg_state
      0.14 ±  3%      -0.1        0.07 ±  6%      -0.0        0.11 ±  4%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__es_insert_extent
      0.16 ±  3%      -0.1        0.08 ±  5%      -0.0        0.12 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__ext4_unlink
      0.14 ±  2%      -0.1        0.07            -0.0        0.11            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.14 ±  4%      -0.1        0.07            -0.0        0.11 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__count_memcg_events
      0.07 ±  4%      -0.1        0.00            -0.0        0.06 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.__es_remove_extent
      0.07 ±  4%      -0.1        0.00            -0.0        0.06 ±  5%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.read@plt
      0.16 ±  3%      -0.1        0.09 ±  5%      -0.0        0.12 ±  2%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.ext4_unlink
      0.08 ±  6%      -0.1        0.00 ±316%      -0.0        0.06 ±  5%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xas_clear_mark
      0.08 ±  5%      -0.1        0.01 ±163%      -0.0        0.07 ±  7%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.folio_mapping
      0.07            -0.1        0.00            -0.0        0.05            +0.0        0.07        perf-profile.children.cycles-pp.node_page_state
      0.07            -0.1        0.00            -0.0        0.06            +0.0        0.07        perf-profile.children.cycles-pp.ext4_fill_raw_inode
      0.18 ±  2%      -0.1        0.12 ±  4%      -0.0        0.14            +0.0        0.19 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.15 ±  3%      -0.1        0.08 ±  3%      -0.0        0.12 ±  4%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.jbd2_journal_try_to_free_buffers
      0.12 ±  5%      -0.1        0.05 ±  8%      -0.0        0.09 ±  3%      +0.0        0.12 ±  2%  perf-profile.children.cycles-pp.ext4_claim_free_clusters
      0.07 ±  7%      -0.1        0.00            -0.0        0.05            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.folio_wait_stable
      0.07 ±  7%      -0.1        0.00            -0.0        0.05            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.07 ±  7%      -0.1        0.00            -0.0        0.06 ±  5%      +0.0        0.08        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.06 ±  7%      -0.1        0.00            -0.0        0.05 ±  6%      -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.13            -0.1        0.07 ±  7%      -0.0        0.10 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.12 ±  4%      -0.1        0.06 ±  7%      -0.0        0.10            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__xa_set_mark
      0.12 ±  2%      -0.1        0.06            -0.0        0.10 ±  5%      +0.0        0.12 ±  2%  perf-profile.children.cycles-pp.file_remove_privs_flags
      0.13 ±  3%      -0.1        0.07 ±  7%      -0.0        0.10 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.ext4_llseek
      0.07            -0.1        0.01 ±212%      -0.0        0.06 ±  9%      +0.0        0.07 ±  4%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.06            -0.1        0.00            -0.0        0.04 ± 37%      +0.0        0.06 ±  5%  perf-profile.children.cycles-pp.add_dirent_to_buf
      0.06            -0.1        0.00            -0.0        0.05            +0.0        0.06        perf-profile.children.cycles-pp._raw_spin_trylock
      0.06            -0.1        0.00            -0.0        0.05            +0.0        0.06        perf-profile.children.cycles-pp.bdev_getblk
      0.06            -0.1        0.00            -0.0        0.05            +0.0        0.06        perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.15 ±  2%      -0.1        0.09 ±  4%      -0.0        0.12 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      0.12            -0.1        0.06 ±  6%      -0.0        0.10 ±  4%      +0.0        0.12        perf-profile.children.cycles-pp.amd_clear_divider
      0.12 ±  2%      -0.1        0.06 ±  6%      -0.0        0.09 ±  5%      +0.0        0.12 ±  2%  perf-profile.children.cycles-pp.jbd2_journal_grab_journal_head
      0.11 ±  5%      -0.1        0.06 ±  6%      -0.0        0.09 ±  5%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.inode_to_bdi
      0.09 ±  5%      -0.1        0.04 ± 47%      -0.0        0.07            -0.0        0.09 ±  3%  perf-profile.children.cycles-pp.handle_softirqs
      0.50            -0.1        0.45 ±  3%      +0.0        0.55            +0.0        0.51        perf-profile.children.cycles-pp.folio_activate_fn
      0.11 ±  2%      -0.1        0.06            -0.0        0.09            -0.0        0.11        perf-profile.children.cycles-pp.__ext4_new_inode
      0.12 ±  2%      -0.1        0.07            -0.0        0.10            -0.0        0.12        perf-profile.children.cycles-pp.try_charge_memcg
      0.11 ±  4%      -0.1        0.06 ±  4%      -0.0        0.09 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.timestamp_truncate
      0.12 ±  3%      -0.1        0.07 ±  6%      -0.0        0.10 ±  3%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12 ±  3%      -0.1        0.07 ±  6%      -0.0        0.10 ±  3%      -0.0        0.12 ±  2%  perf-profile.children.cycles-pp.drop_buffers
      0.13 ±  3%      -0.0        0.08 ±  3%      -0.0        0.10 ±  3%      +0.0        0.13 ±  4%  perf-profile.children.cycles-pp.__ext4_find_entry
      0.11 ±  3%      -0.0        0.06 ±  6%      -0.0        0.09 ±  3%      +0.0        0.11        perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      0.12 ±  8%      -0.0        0.08 ±  6%      +0.1        0.20 ±  3%      -0.0        0.12 ±  9%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.12            -0.0        0.08 ±  5%      -0.0        0.10 ±  5%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.ext4_dx_find_entry
      0.13 ±  3%      -0.0        0.09            -0.0        0.11 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.sched_tick
      0.10 ±  4%      -0.0        0.06 ±  7%      -0.0        0.08 ±  4%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.ext4_do_update_inode
      0.09            -0.0        0.05            -0.0        0.07            +0.0        0.09 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.08 ±  4%      -0.0        0.04 ± 47%      -0.0        0.06 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      0.17            -0.0        0.13 ±  3%      -0.0        0.13 ±  3%      -0.0        0.17        perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.09 ±  4%      -0.0        0.05 ±  9%      -0.0        0.07 ±  4%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.ext4_lookup
      0.09 ±  4%      -0.0        0.06            -0.0        0.07            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.task_tick_fair
      0.09 ±  3%      -0.0        0.06 ±  8%      -0.0        0.07            +0.0        0.09 ±  3%  perf-profile.children.cycles-pp.ext4_add_nondir
      0.24 ±  2%      -0.0        0.22 ±  2%      -0.2        0.06            -0.2        0.08 ±  5%  perf-profile.children.cycles-pp.xas_find_conflict
      0.08 ±  4%      -0.0        0.05            -0.0        0.06            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.ext4_add_entry
      0.08 ±  5%      -0.0        0.05            -0.0        0.06            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.ext4_dx_add_entry
      0.13 ±  3%      -0.0        0.11 ±  5%      -0.0        0.11            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.07            -0.0        0.05 ± 31%      -0.0        0.05 ±  6%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.ext4_search_dir
      0.26 ±  3%      -0.0        0.24 ±  8%      +0.1        0.36 ±  4%      +0.0        0.26 ±  6%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.26 ±  3%      -0.0        0.24 ±  8%      +0.1        0.36 ±  4%      +0.0        0.26 ±  6%  perf-profile.children.cycles-pp.do_group_exit
      0.26 ±  3%      -0.0        0.24 ±  9%      +0.1        0.36 ±  3%      +0.0        0.27 ±  5%  perf-profile.children.cycles-pp.do_exit
      0.24 ±  4%      -0.0        0.24 ±  8%      +0.1        0.35 ±  4%      +0.0        0.25 ±  6%  perf-profile.children.cycles-pp.exit_mm
      0.25 ±  3%      -0.0        0.25 ±  8%      +0.1        0.35 ±  4%      +0.0        0.26 ±  6%  perf-profile.children.cycles-pp.__mmput
      0.25 ±  3%      -0.0        0.25 ±  8%      +0.1        0.35 ±  4%      +0.0        0.26 ±  6%  perf-profile.children.cycles-pp.exit_mmap
      0.20 ±  3%      +0.0        0.22 ±  9%      +0.1        0.30 ±  4%      +0.0        0.21 ±  7%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.20 ±  3%      +0.0        0.22 ±  9%      +0.1        0.30 ±  4%      +0.0        0.21 ±  7%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.20 ±  3%      +0.0        0.22 ±  9%      +0.1        0.31 ±  4%      +0.0        0.21 ±  7%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.34 ±  2%      +0.0        0.37            -0.0        0.32            +0.0        0.34        perf-profile.children.cycles-pp.lru_add_fn
      0.00            +0.1        0.05 ±  5%      +0.1        0.05            +0.0        0.00        perf-profile.children.cycles-pp.lru_add_drain
      0.08 ±  5%      +0.1        0.15 ±  4%      +0.0        0.11            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__cmd_record
      0.08 ±  5%      +0.1        0.15 ±  4%      +0.0        0.11            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.cmd_record
      0.08 ±  4%      +0.1        0.14 ±  4%      +0.0        0.10 ±  4%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.09 ±  3%      +0.1        0.15 ±  4%      +0.0        0.11 ±  2%      +0.0        0.09 ±  3%  perf-profile.children.cycles-pp.main
      0.09 ±  3%      +0.1        0.15 ±  4%      +0.0        0.11 ±  2%      +0.0        0.09 ±  3%  perf-profile.children.cycles-pp.run_builtin
      0.08 ±  6%      +0.1        0.14 ±  4%      +0.0        0.10            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.perf_mmap__push
      0.07 ±  4%      +0.1        0.13 ±  3%      +0.0        0.09 ±  3%      +0.0        0.07 ±  4%  perf-profile.children.cycles-pp.record__pushfn
      0.07 ±  4%      +0.1        0.13 ±  3%      +0.0        0.09 ±  3%      +0.0        0.07 ±  4%  perf-profile.children.cycles-pp.writen
      0.06            +0.1        0.13 ±  5%      +0.0        0.09 ±  4%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.00            +0.1        0.10 ±  4%      +0.1        0.06 ±  6%      +0.0        0.00        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.00            +0.1        0.11 ±  6%      +0.1        0.07 ±  7%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.00            +0.1        0.11 ±  6%      +0.1        0.07 ±  7%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.shmem_write_begin
      2.45            +0.2        2.70            +0.1        2.55            +0.0        2.45        perf-profile.children.cycles-pp.lru_add_drain_cpu
      4.86            +0.7        5.54            +0.3        5.13            +0.0        4.87        perf-profile.children.cycles-pp.__folio_batch_release
     27.93            +0.9       28.79            +1.1       29.05            +0.0       27.95        perf-profile.children.cycles-pp.ksys_read
     27.50            +1.1       28.56            +1.2       28.70            +0.0       27.51        perf-profile.children.cycles-pp.vfs_read
     25.97            +1.8       27.81            +1.5       27.48            -0.0       25.96        perf-profile.children.cycles-pp.filemap_read
     92.83            +3.3       96.09            +1.3       94.11            -0.1       92.76        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     92.42            +3.5       95.88            +1.4       93.79            -0.1       92.35        perf-profile.children.cycles-pp.do_syscall_64
     30.73            +3.9       34.66            +3.8       34.58            +0.1       30.85        perf-profile.children.cycles-pp.write
     21.08            +4.1       25.15            +2.3       23.40            -0.0       21.04        perf-profile.children.cycles-pp.folio_mark_accessed
     19.70            +4.6       24.33            +2.7       22.38            -0.0       19.66        perf-profile.children.cycles-pp.folio_activate
     27.83            +5.3       33.14            +4.4       32.25            +0.1       27.94        perf-profile.children.cycles-pp.ksys_write
     27.36            +5.5       32.89            +4.5       31.87            +0.1       27.46        perf-profile.children.cycles-pp.vfs_write
     25.87            +5.6       31.48            +2.2       28.03            +0.1       26.02        perf-profile.children.cycles-pp.__close
     25.86            +5.6       31.46            +2.2       28.01            +0.1       26.00        perf-profile.children.cycles-pp.__x64_sys_close
     25.84            +5.6       31.46            +2.2       28.00            +0.1       25.99        perf-profile.children.cycles-pp.__fput
     25.83            +5.6       31.45            +2.2       27.99            +0.1       25.98        perf-profile.children.cycles-pp.dput
     25.82            +5.6       31.44            +2.2       27.98            +0.1       25.96        perf-profile.children.cycles-pp.__dentry_kill
     25.79            +5.6       31.43            +2.2       27.96            +0.1       25.94        perf-profile.children.cycles-pp.evict
     25.78            +5.6       31.42            +2.2       27.95            +0.1       25.93        perf-profile.children.cycles-pp.ext4_evict_inode
     25.64            +5.7       31.34            +2.2       27.83            +0.1       25.78        perf-profile.children.cycles-pp.truncate_inode_pages_range
     18.31            +6.0       24.35            +2.5       20.82            +0.1       18.43        perf-profile.children.cycles-pp.folios_put_refs
     17.78            +6.3       24.04            +2.6       20.37            +0.1       17.90        perf-profile.children.cycles-pp.__page_cache_release
     25.54            +6.4       31.96            +4.9       30.47            +0.1       25.66 ±  2%  perf-profile.children.cycles-pp.ext4_buffered_write_iter
     23.87 ±  2%      +7.4       31.23            +5.3       29.21            +0.1       24.00 ±  2%  perf-profile.children.cycles-pp.generic_perform_write
     17.93 ±  3%     +10.0       27.97            +6.5       24.43            +0.2       18.08 ±  3%  perf-profile.children.cycles-pp.ext4_da_write_begin
     13.75 ±  4%     +12.0       25.77            +7.3       21.00            +0.1       13.86 ±  4%  perf-profile.children.cycles-pp.__filemap_get_folio
     11.78 ±  5%     +13.0       24.77            +7.7       19.43            +0.1       11.86 ±  5%  perf-profile.children.cycles-pp.filemap_add_folio
     10.41 ±  6%     +13.5       23.96            +8.1       18.54            +0.3       10.71 ±  5%  perf-profile.children.cycles-pp.folio_add_lru
     34.89 ±  2%     +18.9       53.82           +11.1       46.00            +0.3       35.15 ±  2%  perf-profile.children.cycles-pp.folio_batch_move_lru
     51.11           +25.1       76.23           +13.7       64.78            +0.4       51.49        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     51.02           +25.2       76.18           +13.7       64.70            +0.4       51.40        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     50.98           +25.3       76.24           +13.7       64.69            +0.4       51.36        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      7.25 ±  9%      -6.7        0.53 ± 14%      -5.7        1.54 ± 21%      -0.4        6.87 ± 10%  perf-profile.self.cycles-pp.osq_lock
      3.09            -1.4        1.65 ±  2%      -0.5        2.55            +0.0        3.11        perf-profile.self.cycles-pp.clear_bhb_loop
      1.79            -0.7        1.07 ±  2%      -0.2        1.54            -0.0        1.77        perf-profile.self.cycles-pp._copy_to_iter
      1.14            -0.5        0.61 ±  2%      -0.2        0.94            +0.0        1.16        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.20            -0.5        0.70 ±  2%      -0.2        1.02            -0.0        1.19        perf-profile.self.cycles-pp.memset_orig
      1.06            -0.5        0.57 ±  2%      -0.2        0.86            -0.0        1.05        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.97            -0.5        0.51 ±  2%      -0.2        0.79            +0.0        0.97        perf-profile.self.cycles-pp.filemap_read
      0.94 ±  2%      -0.4        0.51 ±  3%      -0.2        0.78            +0.0        0.96        perf-profile.self.cycles-pp.__fdget_pos
      0.86 ±  4%      -0.4        0.45 ±  3%      -0.2        0.62 ±  4%      +0.0        0.87 ±  3%  perf-profile.self.cycles-pp.workingset_age_nonresident
      0.75 ±  2%      -0.4        0.38 ±  3%      -0.2        0.59            +0.0        0.76        perf-profile.self.cycles-pp.vfs_write
      0.89            -0.3        0.55 ±  2%      -0.1        0.80            +0.0        0.91        perf-profile.self.cycles-pp.__block_commit_write
      0.54 ±  3%      -0.3        0.21 ±  4%      -0.2        0.38            -0.0        0.54 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.50 ±  3%      -0.3        0.20 ±  3%      -0.1        0.37 ±  6%      -0.0        0.48 ±  2%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.63            -0.3        0.33 ±  2%      -0.1        0.52            +0.0        0.64        perf-profile.self.cycles-pp.vfs_read
      0.57            -0.3        0.29 ±  2%      -0.1        0.46            +0.0        0.58        perf-profile.self.cycles-pp.do_syscall_64
      0.61            -0.3        0.33 ±  2%      -0.1        0.54            +0.0        0.65        perf-profile.self.cycles-pp.filemap_get_read_batch
      0.58 ±  2%      -0.3        0.31 ±  3%      -0.1        0.46            -0.0        0.58 ±  2%  perf-profile.self.cycles-pp.fault_in_readable
      0.37 ±  3%      -0.3        0.10 ±  4%      -0.2        0.22 ±  6%      +0.0        0.37 ±  3%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.56            -0.3        0.29 ±  3%      -0.1        0.45 ±  2%      +0.0        0.56        perf-profile.self.cycles-pp.xas_load
      0.38 ±  6%      -0.3        0.13 ±  4%      -0.1        0.25 ±  6%      -0.0        0.37 ±  5%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.48 ±  2%      -0.2        0.24 ±  4%      -0.1        0.37 ±  2%      -0.0        0.47        perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.35 ±  5%      -0.2        0.13 ±  5%      -0.1        0.24 ±  4%      -0.0        0.35 ±  4%  perf-profile.self.cycles-pp.ext4_file_read_iter
      0.46 ±  2%      -0.2        0.24 ±  2%      -0.1        0.36 ±  3%      -0.0        0.46 ±  2%  perf-profile.self.cycles-pp.write
      0.45 ±  2%      -0.2        0.23 ±  6%      -0.1        0.35 ±  4%      -0.0        0.44 ±  3%  perf-profile.self.cycles-pp.disk_rr
      0.39 ±  3%      -0.2        0.18 ±  4%      -0.1        0.33 ± 10%      +0.0        0.40 ± 11%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.36 ±  4%      -0.2        0.15 ±  4%      -0.1        0.26 ±  3%      -0.0        0.36 ±  3%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.44            -0.2        0.23 ±  2%      -0.1        0.37            -0.0        0.44        perf-profile.self.cycles-pp.ext4_da_write_end
      0.44            -0.2        0.23 ±  2%      -0.1        0.36            +0.0        0.45        perf-profile.self.cycles-pp.__filemap_get_folio
      0.42            -0.2        0.21 ±  2%      -0.1        0.34            +0.0        0.42        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.42 ±  2%      -0.2        0.22 ±  3%      -0.1        0.33 ±  2%      +0.0        0.42        perf-profile.self.cycles-pp.generic_perform_write
      0.40            -0.2        0.20 ±  2%      -0.1        0.33 ±  2%      +0.0        0.42        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.43 ±  2%      -0.2        0.24 ±  3%      -0.1        0.36 ±  2%      +0.0        0.44 ±  2%  perf-profile.self.cycles-pp.read
      0.40 ±  2%      -0.2        0.21 ±  3%      -0.1        0.32 ±  2%      +0.0        0.41        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.41            -0.2        0.22 ±  3%      -0.1        0.34            +0.0        0.41        perf-profile.self.cycles-pp.llseek
      0.33            -0.2        0.17 ±  2%      -0.1        0.26 ±  2%      -0.0        0.32 ±  2%  perf-profile.self.cycles-pp.ext4_block_write_begin
      0.33 ±  2%      -0.2        0.17 ±  3%      -0.1        0.26            -0.0        0.33        perf-profile.self.cycles-pp.__cond_resched
      0.28 ±  2%      -0.2        0.13 ±  3%      -0.1        0.22 ±  2%      +0.0        0.28 ±  2%  perf-profile.self.cycles-pp.atime_needs_update
      0.30 ±  2%      -0.1        0.16 ±  3%      -0.1        0.24            +0.0        0.31        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.30            -0.1        0.16 ±  4%      -0.1        0.25            +0.0        0.32 ±  2%  perf-profile.self.cycles-pp.filemap_get_entry
      0.30            -0.1        0.16 ±  3%      -0.1        0.24 ±  2%      -0.0        0.29 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.28            -0.1        0.14 ±  4%      -0.1        0.22            -0.0        0.27        perf-profile.self.cycles-pp.folio_mark_accessed
      0.27            -0.1        0.14 ±  2%      -0.1        0.22 ±  2%      +0.0        0.27        perf-profile.self.cycles-pp.mark_buffer_dirty
      0.12 ±  5%      -0.1        0.00            -0.0        0.07 ±  5%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.start_this_handle
      0.26            -0.1        0.14 ±  3%      -0.1        0.21 ±  3%      +0.0        0.26        perf-profile.self.cycles-pp.ext4_da_map_blocks
      0.25            -0.1        0.13 ±  3%      -0.1        0.19 ±  2%      -0.0        0.24        perf-profile.self.cycles-pp.down_write
      0.25            -0.1        0.14 ±  2%      -0.0        0.21 ±  2%      +0.0        0.26        perf-profile.self.cycles-pp.x64_sys_call
      0.27 ±  2%      -0.1        0.16 ±  2%      -0.0        0.22 ±  2%      -0.0        0.27        perf-profile.self.cycles-pp.block_invalidate_folio
      0.24 ±  2%      -0.1        0.12 ±  3%      -0.0        0.19 ±  3%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.up_write
      0.16 ±  4%      -0.1        0.06 ±  7%      -0.1        0.11 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.ext4_nonda_switch
      0.20 ±  2%      -0.1        0.10            -0.0        0.16 ±  2%      -0.0        0.20        perf-profile.self.cycles-pp.inode_needs_update_time
      0.21 ±  2%      -0.1        0.11            -0.0        0.17            +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.folio_unlock
      0.23            -0.1        0.13 ±  3%      -0.1        0.17            -0.0        0.21        perf-profile.self.cycles-pp.xas_store
      0.21 ±  2%      -0.1        0.11            -0.0        0.18 ±  2%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.xas_start
      0.20 ±  2%      -0.1        0.10 ±  4%      -0.0        0.16 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.filemap_get_pages
      0.20 ±  2%      -0.1        0.10 ±  4%      -0.0        0.16 ±  2%      +0.0        0.21 ±  4%  perf-profile.self.cycles-pp.security_file_permission
      0.20 ±  4%      -0.1        0.10 ±  4%      -0.0        0.16 ±  3%      -0.0        0.20        perf-profile.self.cycles-pp.rcu_all_qs
      0.22            -0.1        0.12 ±  3%      -0.0        0.19            +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.folios_put_refs
      0.20 ±  2%      -0.1        0.11 ±  3%      -0.0        0.16 ±  2%      -0.0        0.20        perf-profile.self.cycles-pp.__slab_free
      0.18            -0.1        0.09 ±  3%      -0.0        0.13            -0.0        0.17        perf-profile.self.cycles-pp.__filemap_add_folio
      0.17 ±  2%      -0.1        0.09 ±  4%      -0.0        0.13 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.ext4_buffered_write_iter
      0.18 ±  2%      -0.1        0.09 ±  5%      -0.0        0.14 ±  2%      +0.0        0.18        perf-profile.self.cycles-pp.rw_verify_area
      0.08 ±  4%      -0.1        0.00            -0.0        0.07 ±  6%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.fault_in_iov_iter_readable
      0.08            -0.1        0.00            -0.0        0.06            -0.0        0.07        perf-profile.self.cycles-pp.ext4_es_insert_delayed_block
      0.08            -0.1        0.00            -0.0        0.06            +0.0        0.08        perf-profile.self.cycles-pp.__es_insert_extent
      0.08            -0.1        0.00            -0.0        0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.rmqueue
      0.08 ±  8%      -0.1        0.00            -0.0        0.06 ±  6%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.inode_to_bdi
      0.17            -0.1        0.09 ±  4%      -0.0        0.13 ±  3%      +0.0        0.17        perf-profile.self.cycles-pp.__mod_node_page_state
      0.08 ±  6%      -0.1        0.00            -0.0        0.05 ±  9%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp._raw_read_lock
      0.08 ±  6%      -0.1        0.00            -0.0        0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.generic_file_llseek_size
      0.16 ±  3%      -0.1        0.08 ±  3%      -0.0        0.12 ±  2%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.aa_file_perm
      0.15            -0.1        0.07 ±  6%      -0.0        0.12            +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.16 ±  2%      -0.1        0.09 ±  3%      -0.0        0.13 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.07 ±  6%      -0.1        0.00            -0.0        0.06            -0.0        0.07 ±  4%  perf-profile.self.cycles-pp.generic_file_read_iter
      0.07 ±  6%      -0.1        0.00            -0.0        0.06            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.15 ±  3%      -0.1        0.08 ±  4%      -0.0        0.12 ±  2%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.current_time
      0.15 ±  3%      -0.1        0.08 ±  3%      -0.0        0.12 ±  2%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.ksys_write
      0.15 ±  6%      -0.1        0.07 ±  6%      -0.0        0.12 ±  8%      +0.0        0.15 ±  6%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.15 ±  2%      -0.1        0.08            -0.0        0.12 ±  2%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.generic_write_checks
      0.15 ±  4%      -0.1        0.08 ±  6%      +0.0        0.16 ±  5%      +0.0        0.17 ±  3%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.07            -0.1        0.00            -0.0        0.07 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.folio_alloc_buffers
      0.15 ±  3%      -0.1        0.08 ±  4%      -0.0        0.12 ±  3%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.15 ±  3%      -0.1        0.08 ±  4%      -0.0        0.12            +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.ksys_read
      0.07 ±  6%      -0.1        0.00            -0.0        0.05            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__folio_cancel_dirty
      0.07 ±  6%      -0.1        0.00            -0.0        0.05            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.ext4_generic_write_checks
      0.07 ±  6%      -0.1        0.00            -0.0        0.05 ±  8%      +0.0        0.07 ±  4%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.08            -0.1        0.01 ±163%      -0.0        0.07 ±  6%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.free_unref_folios
      0.18 ±  2%      -0.1        0.11 ±  3%      -0.0        0.15 ±  3%      +0.0        0.18        perf-profile.self.cycles-pp.mod_objcg_state
      0.13            -0.1        0.06 ±  7%      -0.0        0.10            +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.13 ±  3%      -0.1        0.06 ±  4%      -0.0        0.10            -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.06 ±  7%      -0.1        0.00            -0.0        0.05            -0.0        0.06        perf-profile.self.cycles-pp.folio_activate
      0.06 ±  7%      -0.1        0.00            -0.0        0.05            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.06 ±  7%      -0.1        0.00            -0.0        0.05            +0.0        0.07 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.06 ±  7%      -0.1        0.00            -0.0        0.05 ±  9%      +0.0        0.07 ±  4%  perf-profile.self.cycles-pp.xas_clear_mark
      0.15 ±  2%      -0.1        0.09 ±  5%      -0.0        0.13 ±  2%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.find_lock_entries
      0.14            -0.1        0.08 ±  6%      -0.0        0.12 ±  3%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.06 ±  7%      -0.1        0.00            -0.0        0.05            -0.0        0.06        perf-profile.self.cycles-pp.amd_clear_divider
      0.13 ±  5%      -0.1        0.07 ±  7%      -0.0        0.13 ±  9%      +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.06 ±  6%      -0.1        0.00            -0.0        0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.try_to_free_buffers
      0.12 ±  2%      -0.1        0.06            -0.0        0.09 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.node_dirty_ok
      0.06            -0.1        0.00            -0.0        0.05            +0.0        0.06        perf-profile.self.cycles-pp.__mod_zone_page_state
      0.06            -0.1        0.00            -0.0        0.05            +0.0        0.06        perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.12            -0.1        0.06 ±  6%      -0.0        0.10 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.ksys_lseek
      0.09            -0.1        0.03 ± 75%      -0.0        0.07            +0.0        0.09        perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.12            -0.1        0.06 ±  7%      -0.0        0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.create_empty_buffers
      0.12 ±  4%      -0.1        0.06            -0.0        0.09            -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.10 ±  3%      -0.1        0.05 ± 31%      -0.0        0.08 ±  6%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.folio_account_dirtied
      0.12 ±  4%      -0.1        0.06 ±  4%      -0.0        0.09 ±  5%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.jbd2_journal_grab_journal_head
      0.09            -0.1        0.04 ± 61%      -0.0        0.07            +0.0        0.09        perf-profile.self.cycles-pp.file_modified
      0.11 ±  4%      -0.1        0.05 ±  8%      -0.0        0.08 ±  5%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.ext4_llseek
      0.10 ±  4%      -0.1        0.05            -0.0        0.08 ±  6%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__count_memcg_events
      0.05 ±  8%      -0.1        0.00            -0.0        0.05 ±  6%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.11 ±  4%      -0.1        0.06 ±  8%      -0.0        0.08 ±  5%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.10 ±  5%      -0.1        0.05            -0.0        0.08 ±  4%      +0.0        0.10        perf-profile.self.cycles-pp.file_remove_privs_flags
      0.10 ±  5%      -0.1        0.05            -0.0        0.08            +0.0        0.10        perf-profile.self.cycles-pp.block_write_end
      0.10            -0.1        0.05            -0.0        0.08            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.12 ±  4%      -0.0        0.07 ±  6%      -0.0        0.10 ±  4%      +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12            -0.0        0.07 ±  5%      -0.0        0.10            +0.0        0.12        perf-profile.self.cycles-pp.drop_buffers
      0.10 ±  5%      -0.0        0.05            -0.0        0.08 ±  6%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.timestamp_truncate
      0.10 ±  5%      -0.0        0.05 ±  5%      -0.0        0.08            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.folio_account_cleaned
      0.10 ±  4%      -0.0        0.06 ±  8%      -0.0        0.08            +0.0        0.10        perf-profile.self.cycles-pp.kmem_cache_free
      0.11 ±  9%      -0.0        0.07 ±  8%      +0.1        0.20 ±  3%      -0.0        0.11 ± 10%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.10 ±  4%      -0.0        0.07            -0.0        0.10 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.09 ±  5%      -0.0        0.06 ±  4%      -0.0        0.08 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.try_charge_memcg
      0.10 ±  4%      -0.0        0.07 ±  5%      -0.0        0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__page_cache_release
      0.23 ±  3%      -0.0        0.21 ±  2%      -0.2        0.05            -0.2        0.06        perf-profile.self.cycles-pp.xas_find_conflict
      0.23 ±  2%      -0.0        0.22 ±  3%      -0.0        0.18 ±  3%      -0.0        0.23        perf-profile.self.cycles-pp.workingset_activation
      0.25 ±  2%      +0.0        0.28 ±  4%      +0.0        0.30            +0.0        0.25        perf-profile.self.cycles-pp.folio_activate_fn
      0.17 ±  3%      +0.1        0.26            -0.0        0.13            -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.lru_add_fn
      0.51 ±  2%      +0.1        0.63 ±  3%      -0.1        0.40 ±  2%      -0.0        0.50        perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.30 ±  5%      +0.2        0.51 ±  2%      +0.0        0.34 ±  3%      +0.0        0.30 ±  3%  perf-profile.self.cycles-pp.folio_batch_move_lru
     50.97           +25.3       76.24           +13.7       64.69            +0.4       51.36        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath

> 
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7e2eb091049a..0e5bf25d324f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -109,6 +109,7 @@ struct mem_cgroup_per_node {
> 
>         /* Fields which get updated often at the end. */
>         struct lruvec           lruvec;
> +       CACHELINE_PADDING(_pad2_);
>         unsigned long           lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
>         struct mem_cgroup_reclaim_iter  iter;
>  };
> 
> 
> 

