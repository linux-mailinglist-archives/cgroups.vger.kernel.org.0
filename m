Return-Path: <cgroups+bounces-2958-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839EE8C942F
	for <lists+cgroups@lfdr.de>; Sun, 19 May 2024 11:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297B028125E
	for <lists+cgroups@lfdr.de>; Sun, 19 May 2024 09:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E122A8CD;
	Sun, 19 May 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQVlTf18"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3115AC4
	for <cgroups@vger.kernel.org>; Sun, 19 May 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716110094; cv=fail; b=o306SWgLoq2rYKBQbZWQfnp59reUTfuYwVHasYqvteRP2zMBIj2qoygVYsN3SX4JhaZO3AlzPxZNTHtTfx7FElrqr2MJdvL5qmPzhb3rfhShUVTv+PM4cuglJuPIDq197eMt2ag/3EgOImv21/7QIfQlEAmOVR9XIaewpb8AgzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716110094; c=relaxed/simple;
	bh=iHxAMQA5L1JWLfJJXuk9ydb2cBFTdEffcev23qNtt2I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lNB3qfvNmMEK9LKRr2Z8VQpakpBgOx9BXE/CzDGdOqZU7crvoQiXj9+hO9ZHvscE9I5AnnNorVTPQ2vla1l0lZK+snLlvAtVmpSa4PI0eopt9IER9CbqzUjzTT1vKbIb/NuS8NAKv0J5HndTk2nAc+9e+9NDo5eXR7GNbqYvr1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQVlTf18; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716110093; x=1747646093;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iHxAMQA5L1JWLfJJXuk9ydb2cBFTdEffcev23qNtt2I=;
  b=TQVlTf18H4WNvVZvkonc1nQLjpDvo7wQJSqgV8qkJikL10jq0/EfKJak
   tlBI8755MMRhlqJVgKklSL8Op1mQizH1YuAkL+97Hz5ZBn6etfq9ac+mr
   /m69VocWw3tJCBm/nQRFpePS2srNw/90U1Tt1sDx4ANEYKeR2IHV1XOXj
   CGq7aqvFD/Vciw6aQKBuZtWL4MVQEjw1UvZIn5+F03GDzHhPtM465fEi9
   Edscxu93I6SS0LRg3iBOROI7eeqflMoBGDXSaKNyWHfAfIsj7UM0J368O
   J/lHUVb6A3JyirNMGgWOHwpbR3WOClPvIFU4NKy8HUUFTMCE5PoTff7dF
   Q==;
X-CSE-ConnectionGUID: x2mJa5feSdGYhAuZ7sjzjg==
X-CSE-MsgGUID: f+EpYTXZS7+/4cicQhq80g==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="22920030"
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="22920030"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 02:14:53 -0700
X-CSE-ConnectionGUID: 4JcS+747Td6i6H73dAC+KQ==
X-CSE-MsgGUID: SpRAFT5tSPGSyr5i+5UwNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="32659805"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 02:14:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 02:14:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 02:14:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 02:14:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acK7ByCI70Jei10HnMlIK6cgIon2hv3E2I/4rn+BdK/A1wt5HQ8TC9ZQeIE7z48mnzDT3HQpVw2/E2Xqm6xes29RHGTcS25ONN0ntoD6PQwMRa3vMABTRuWsLVDczjj1z/HRaMCDI1GH78uDvpy3JmQPCubt/Y3tCSo0rXdNeaVrzjoenSycvSKtPXZ2QmpERHpLdn5+7mL8wbaxn+QcX+g2pK4YU3HJHcIRzWoGG+joVi0YSP1zxRpX0/mb+CHHLXjYd0KRbb/2cf6nj1ooPFGAwaq8xaWBavokVKxFdN3m4dakA9DVU5wLqSihO6tPA3dyhQz0UdjSLO4Y3aJeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vve5aFLRCG71VAew9yxc3ZIO7wOcxkasj2BMDs1l7rM=;
 b=cBV6bKkCY+juCouw2ylceIKJT8dvkQh3+5tSvCmN7RXVYRa3EMg1+QjaLaV5gjDsnz75kKbD17HhGgC5JkddJjlJpKcP2FFmTRL0iGxOdRowGpIKcXHvpZEwgQ+H7i+twjptRxSzoyDfC3m9xQsU+Ttm9111YQsGP+9l5ghKtGTqedBYWjGjCTmYEhgu3QP+AL83a8iJFv9IrvOL/sudZOUDz8pqRbLcRUhb5fwrRsQ0fcaEgIvrnqLy9HokVH6ft64tI485dtMYNoearT5pQJ3uwQWTzUeSR+wVyKEukdXC7vA77Lnr/WdPXUKE29gBVjTZIhJHIkYBVOhOc9W5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8326.namprd11.prod.outlook.com (2603:10b6:806:379::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Sun, 19 May
 2024 09:14:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 09:14:50 +0000
Date: Sun, 19 May 2024 17:14:39 +0800
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
Message-ID: <ZknC/xjryN0sxOWB@xsang-OptiPlex-9020>
References: <202405171353.b56b845-oliver.sang@intel.com>
 <pdfcrrgqz6vy6xarsw6gswtoa32wjd2gpcagmreh7ksuy66i63@dowfkmloe37q>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <pdfcrrgqz6vy6xarsw6gswtoa32wjd2gpcagmreh7ksuy66i63@dowfkmloe37q>
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 249ae106-c01d-4688-cb17-08dc77e422bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vwRVMoBeIYIA6VnBDf4fvSNbVhqTIg7Q1b+ET8BfYcXkdKzd+/qw9u0dmda2?=
 =?us-ascii?Q?SAB3mDE56Nh9luHg9bp/UP3TaqxAwblqGVbSGP8R9JkT7FEJ6OG0sK134u6J?=
 =?us-ascii?Q?n4jJ0BFu6W+UP7+OFnTAB2wvBOFb30mZclWQxfFZGv53syRl5ZyedsWkq5C9?=
 =?us-ascii?Q?/y55Q99u5vtK9km1oeZ6bqdtouO/MG9jPWM+Lhg3UC65I0yJN6fum3/bTp1V?=
 =?us-ascii?Q?nF5WDvTUBk/WpEL0Fc3beSj6dbJ7GHXu+iY2++6KPfvlFFqbxA2THi1iKdD3?=
 =?us-ascii?Q?BIGxC84T51LlB8ODRpBDmfvf0V3NTRXubqo+jiSQDcNVCYF3DDbU1Apmcl0Z?=
 =?us-ascii?Q?/DUBpCkJeOLuCCI87eRL2CxyHYwHOu19jfUIV4bV5TEY38ZdLDL/nd/snPZH?=
 =?us-ascii?Q?x64TE4sOtdaPeLXGmIgs3RR3E930cEP8R++xZqz2/dtdZgGVSlPZNeRPSBWq?=
 =?us-ascii?Q?GLPSM8KD4ePnyCi4IlyLXQCpmQAiFcrD/tuuWTaxrJIjwCm7cX1xsL7L9nWP?=
 =?us-ascii?Q?x9vrENpiwpdvBSbYpvW/Wi93HBV+fL0DQ4BGrsziw1F2j7lgkvO+Wy7lSeS9?=
 =?us-ascii?Q?UUzNrsChTlBSodNlEqTWKDWMrJP1mK4rz9EUg+ldJcC39H5JM61RX0JdcYpe?=
 =?us-ascii?Q?BSTOP4XK9+Um81xULWQlFr5Z7jgiZGyy1Ng39XP1quJifYL2cCVT539DPTWk?=
 =?us-ascii?Q?wSVAKQGNLPjQuBUSGHuQOzjiVcyuwYSACX3ikdh8xnwWudDSv3ZHkTkThWKu?=
 =?us-ascii?Q?PLLU0XnCgsOa0aqmn5bbitZgIkboCJ7StttcxcwH4fJPmOuuH2FuaEHuavto?=
 =?us-ascii?Q?re47849ZsNwVRkH+h7TGxpAeY08q3HtUk8C1AlvRG+FF+S4LsQxmxk21cyV2?=
 =?us-ascii?Q?+QGawEHUMNAcGoi6Bmq3XgFdCViZO9SaRx93xnYScdUlm2E1+W5JGrhTf3hk?=
 =?us-ascii?Q?bSjtsnpbMf+QF55VNPlqQuXbKIbb/pajQQybLTeJNIDbcu2k4bka7aHc2RTT?=
 =?us-ascii?Q?5+IfPvs3AO9mYWgRiNATxmIE2N/gxWaQM7qVrk23YFr+hH34fG3b4fcKnh6/?=
 =?us-ascii?Q?WJdvLNTo9V6Yu9J+ye9Mkc27HI2ySo/0D/A7ojkhez0tu6OzuptvJFOwmJor?=
 =?us-ascii?Q?njffSJ69Dx+jdq/rOK4SbtmS19vwP7hYMYWs3bemleBNLhYlCzr62/OTYlGt?=
 =?us-ascii?Q?m4ulEYdfzTCXSfRecceaai0DEuiIQa52Tct6veC9tWmXMUmn7pBMiGvjcek?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DdYDyyLZob2k1mnO6TKFspUQt5vUSp+fmKBC2SlxxTc36YleqKBK2ePY+PKZ?=
 =?us-ascii?Q?YwaVHv0/DJrKcqty6d1eyvnB/juBVfpfC6bRKpN836uOBn1Wv7GlLySytC8M?=
 =?us-ascii?Q?wE5Lb53s/r6pvdI54AqZlQbvg8aXBHSoYhWwN9qXOEwlXaPxO/zrTCPYbAqA?=
 =?us-ascii?Q?LP5Oi1GP8UuK+tL0C7J3ktvDHmC0BVy9f7l/Z3wHUb5oflSNLRDOBOa4rsEf?=
 =?us-ascii?Q?u2vHiS/BfLs9ZVvXLjKEi0aHh2E2pcRQ+ZrUMQ2kkqfng4sTiFpWvFiqntxa?=
 =?us-ascii?Q?3YZDVtA3YK1/Fv5e4LTP4wSiLmfHLP4wvTxTTN5Vi9vykXJox4e80mWc8sGZ?=
 =?us-ascii?Q?O0Mc71SVyY8FKSAdWfItrWEt8MYqhgt/mmO3gicY9Hd9zLTjVhl2MZn3QdYk?=
 =?us-ascii?Q?/Znmd2wdak2sPpt59BPbEhvKY9QYca1pO+ETXmUuGgK13PtfvhxGHGKYTwkT?=
 =?us-ascii?Q?vElBttO87M2ICIQ+zckW6ZoZJW52f3mtzSXB+XK6wpeIplrC/0G4QiqEGBz5?=
 =?us-ascii?Q?wzoNQoA74ohfAa/Xg/jB/Y7hWLMzaaUGIXCEhBqnOGE6010rryA75XVFUaJB?=
 =?us-ascii?Q?kMtqwYpjKRnnPTCeMClUn/fkf+mK2mCTpGuGGlt6PlUvseAum1A3JanPJwnB?=
 =?us-ascii?Q?1pPnrjyrjE8tkmSwCqC3HiiS70lYOqveTD+UiFB0bJ3bmP3Ymwnj1BqBYKup?=
 =?us-ascii?Q?ci5p6ATzUjhPDxynK81Eif+/vIk3kp5O5rf+mUuFUhT8UIJgl947+VcUyrBU?=
 =?us-ascii?Q?ciu5DdRYzb8zyFMCavpwOQR/M0OGLpO3KTJ3kO2ZEBp78QLp7fm96m3X41TV?=
 =?us-ascii?Q?eWnJIFOykgVESo4c0SMLj3DytAvKHTzVpxxRHN0Nh5YCX96+0lmITQEOsesZ?=
 =?us-ascii?Q?X8HNDXUFId9wG8VGonJU9ajnWD6SxhNNTzCasfVON3UQ/F4Hsqo8Tm5lyS/A?=
 =?us-ascii?Q?fwlZfsLmlzexa3Dj4HXmPqgUMUwmhwhKRv3Y9VVXs8+zbsbYDQFFTt6vrkt8?=
 =?us-ascii?Q?WAYyIKzXSZVu+KTM5V5dF8WTVsiSqAtdavOLELAylUwXyhmBQvyrK82rDsfd?=
 =?us-ascii?Q?PpDYFI7N2DN+RVVN1ik7gBbZBoBa1lB4rV2ZDJZhtqlLNOWtXnLCzCL2u/KP?=
 =?us-ascii?Q?EJCdBsF6IskZBxD/dkdTlkMkkYafBw6uj3AmFworym6i4pTfP6ndaXth+96e?=
 =?us-ascii?Q?Cr4AgaC3Urj83Hcj26TD8m7i94q/BuQDUhlck0ehWZNn5qgyuiUanRU68Jd+?=
 =?us-ascii?Q?36h7IT89GKWxuRczbJ01ilkDsBlk1I6Mb2RvEbdrVhALjmTFkBY37Zu8+MNZ?=
 =?us-ascii?Q?33E7fpOZPWA/1pCb3wVIOc8Vp2K9eIW1WHJclQI6xIKhA/rqAfdZWNLxSYDq?=
 =?us-ascii?Q?v76qFQVRcQ7KVL7ZXHorK7Z4HdJZoU0DPbJGXsFaYIznR/CZUzh/aFL8y7aO?=
 =?us-ascii?Q?1i98a623xmLC1NJfWkApytBZourmseCPUKPUJBMjfZlttrJFKLh34cX2W5rB?=
 =?us-ascii?Q?Gc2AC4YkV/6zWA+en1seLMMPhxN4N8+Tv9NATIyD1A+vP+7whhjpVIeT3yAW?=
 =?us-ascii?Q?/gqjiDt7x8cRx217bxNFj88Ra17x0T8E2xwgPTPNdDqn4PZO0Tetqy9Zio14?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 249ae106-c01d-4688-cb17-08dc77e422bf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2024 09:14:50.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/dwW/BnhAdJ3w7GO/v3tDClOVEsqWeYTMyWaki5Sec/tAoe17AsTv+7HpAPaP2MWZlvf3Z4UmsnZYdT6Z/2Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8326
X-OriginatorOrg: intel.com

hi, Shakeel,

On Fri, May 17, 2024 at 11:28:10PM -0700, Shakeel Butt wrote:
> On Fri, May 17, 2024 at 01:56:30PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a -11.9% regression of will-it-scale.per_process_ops on:
> > 
> > 
> > commit: 70a64b7919cbd6c12306051ff2825839a9d65605 ("memcg: dynamically allocate lruvec_stats")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> 
> Thanks for the report. Can you please run the same benchmark but with
> the full series (of 8 patches) or at least include the ff48c71c26aa
> ("memcg: reduce memory for the lruvec and memcg stats").

while this bisect, ff48c71c26aa has been checked. it has silimar data as
70a64b7919 (a little worse actually)

59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 ff48c71c26aaefb090c108d8803
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
     91713           -11.9%      80789           -13.2%      79612        will-it-scale.per_process_ops


ok, we will run tests on tip of the series which should be below if I understand
it correctly.

* a94032b35e5f9 memcg: use proper type for mod_memcg_state


> 
> thanks,
> Shakeel
> 

