Return-Path: <cgroups+bounces-4928-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DE997E098
	for <lists+cgroups@lfdr.de>; Sun, 22 Sep 2024 10:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED93628158F
	for <lists+cgroups@lfdr.de>; Sun, 22 Sep 2024 08:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362019309D;
	Sun, 22 Sep 2024 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFvGKrsx"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8982E657;
	Sun, 22 Sep 2024 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726994397; cv=fail; b=TBqmoW1BT7FD/LF65s997K8waD2syj1Dl/yoDQtq6/fkDf/UCiutzgqgzs7EH0l/7DJy4WsO+HF/rYgik3C1wl8FExHVHGnf01WZ2y5btx3gwYKy4fe1We66RfR7jeYm6nKRGv4mom0TSblhllYWb7VuSzfWjpEjFI7agMxu/4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726994397; c=relaxed/simple;
	bh=9I55bYLfGc1lz3X6xMlH6fMfcWCZV/dA85TY9BaTRbE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JsPJSXGq572/c1PRoWLU68PNAff0lnCx7JXtOvZNotMhW2kbx6Noj8fobD7dpHWCWVWBJXyrG6ZGl4NdOJfiW3h7ziPptLnDgA92F3xwN2aWAtm2aHPpzV+DZxb/e5DG2yPth2nbndkqFpAN4i/gNrmCXbCxsnTcTr8ZtphyguA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFvGKrsx; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726994395; x=1758530395;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=9I55bYLfGc1lz3X6xMlH6fMfcWCZV/dA85TY9BaTRbE=;
  b=SFvGKrsxazp3Dgozuctgh000ieCQaZ/PqKcpALpyF6VNXvPrLRTbiMVo
   QKUaEF2D74P8IymhvlFWCFx+gAKPetNUb/8QjN17zgT3TH/I/BTjRLGUB
   KIMY5g4buNcTLdVsYXVtZQ06E+BhCG1WLPe2bdEEpuzjTWlfK8DOaxtFP
   BBmld3S6eioaJX8siNNcAuB5PlkVeOSEYnHbik925nrHAf4mQ33cB+jli
   FqJuRt3gTgyNk7y0xBHS5BxeG7mnDBvC4Vx2eChm+MUga/3+ZVsQhxNVm
   fDn3csjIQXHOu0hXIiFs9vv6HgLpaFBzwE8e114NiZZFo80uHGHqL64SH
   g==;
X-CSE-ConnectionGUID: /eUjgYMZTg6g6dCBrR6B5g==
X-CSE-MsgGUID: wIKmLj/uRlmXuzq98YenXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="28850178"
X-IronPort-AV: E=Sophos;i="6.10,249,1719903600"; 
   d="scan'208";a="28850178"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 01:39:54 -0700
X-CSE-ConnectionGUID: 4oCXuN3HTpK314x2KH9VSQ==
X-CSE-MsgGUID: hboqHPuOQyC+w2pYL+xgIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,249,1719903600"; 
   d="scan'208";a="70340181"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2024 01:39:54 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 22 Sep 2024 01:39:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 22 Sep 2024 01:39:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 22 Sep 2024 01:39:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS94WKR2+VxdOGT9dRAnYjyvFnWbRQEVBjPl2NY7J5lsJsiJOVqj9Zd4S01jK+bJtV6wGo0Grku892le7gyzmZx5PX9WUDotBoA/YUdJtmMww0vfjBLhQ4Kwe0zNeGL754SoBbTdtqTGkrtV2M3Wl1jWVjqDLr6WH8J3s4z8M/+KvrlBt9ui1wNj1GHpU00h66CNKhDjlx0EUOIFWTV6PZGuKz+x9vjy8DXcvUEr4r4hZztr4XYWXDhAqCg+RBLhEW1avtDIj5ajGT3TkR7ptmwQb3NQtZbB94/Ktfu0bboKWf6p6lKkj077pTsMVSmznNEx1a/AOZFEOiTCg+dFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XN2GuO8iy0oIH9lpn6vOkJhRSi64LHXBvMoRWAZrNlo=;
 b=nABWNsFIUybkcQ08V++g63e9fTF3JqOOT83DXSV/aDDZe8j9wtqEwAOu97oWF/1U8x5gI6WgjbvewTapnPqBg78N146YgKUI1yzuP1GyOFhjweLjw91Zt9yvdsiD+a4zpYddVADktmVqvAKsDjIQCvuzwVemjO5q9SmzBzJGpME8kVkR9yFE5IgsRDOUKh3uwS9bE0iGKLxXrZTGe8erfTxLxhSwlyDGrsCQdHXPCCAqV9bF/hBJQSZ5YLR+OHGcfhPc3YLtL2BeKen6TUZ9JoZsFFlTu7BrYkzQBPgq+YocfIPVYG3iBoBzn5XAGwFYe4w8nq60YMwKRUc/9kPDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6557.namprd11.prod.outlook.com (2603:10b6:806:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Sun, 22 Sep
 2024 08:39:49 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Sun, 22 Sep 2024
 08:39:48 +0000
Date: Sun, 22 Sep 2024 16:39:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <kaiyang2@cs.cmu.edu>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <cgroups@vger.kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <mhocko@kernel.org>, <nehagholkar@meta.com>,
	<abhishekd@meta.com>, <hannes@cmpxchg.org>, <weixugc@google.com>,
	<rientjes@google.com>, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	<oliver.sang@intel.com>
Subject: Re: [RFC PATCH 2/4] calculate memory.low for the local node and
 track its usage
Message-ID: <202409221625.1e974ac-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240920221202.1734227-3-kaiyang2@cs.cmu.edu>
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: ff28a374-4c96-4f7e-2a12-08dcdae21e44
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3sxulw/J1Y0MWZLDHpDSHdhzR2mWn0OAxRhaj4zFj1n3NJTC1xJdssde68Tg?=
 =?us-ascii?Q?PgM1GcoDwvHoulQ9DwKDR6EcUvXAd9n3dFOm0aicTU4vCWAiPjBKp3P/P2nn?=
 =?us-ascii?Q?jymynibhZr6zX74gzzExtN8QG48aKzNvLsYr8KK4fqXBj/Gqf4D4XeWAy2AC?=
 =?us-ascii?Q?sa3fujgWfGy+HkkehrZC3VCK/WScWD5psOptneWLzPmpS9HDB3f3TgBuIe62?=
 =?us-ascii?Q?q/ol4XpcfvDf8rQwwWL+zgXrDHt5rmPVoh5Ev54hMts5Z7zEyzt6KgS4Q/M6?=
 =?us-ascii?Q?irJPyuNOcMBB5uoCs531snmneN/i1vpnyppHjc093H/fErQVS8iQmRhhOefm?=
 =?us-ascii?Q?hssVPN6KGwbtNbccTbYURCpeB54H0qYzptzBo4JynOSFAdc7b1m8sTE9rF2I?=
 =?us-ascii?Q?rfWaCr1ZUEZFWeXmQXFfqS6rdtiB9HcXL4EpLCvPHyNCExEhWbtvrXOaA1LG?=
 =?us-ascii?Q?sksRcobBI9rMnWKiddiukKKLIXHTeO31gmEUEsnpFlXWZkn+JKJmi52h2alT?=
 =?us-ascii?Q?nFYFn6yz5LWtz9PhQIIB4d5HCdZ2ZT/VqplqodLFcIcCGBQwtY9E39jhtw2W?=
 =?us-ascii?Q?VcD7xzvDcQKX2SAClV2z5vIs7DikOboHgSKHfaAnkelosUtVq/G2KjcAdnFL?=
 =?us-ascii?Q?XOsi1ylrLedynvHhroM0Q0X/lYegKBotH29QHuMVYIQ9kLoy/aqPfX9oBrS2?=
 =?us-ascii?Q?zuD1BItT5mTv6pI8SE/ucaBhv3ThoMbUCu0ECbO5zRzjsmfuDMbaYUyeLDNq?=
 =?us-ascii?Q?jzM7MuykvndXDDCijq0wOeQA1La/n3pkGFmEeD6AtRFxL1h1+i5sOJo7TJgd?=
 =?us-ascii?Q?ZNMHWjVwXFUP0C+rS+xwICpI56ndr6myPP+Y6F/A6uyYwuzQmH6stfPslMP2?=
 =?us-ascii?Q?jGTegzNavZ5rKY5aYuEuxuWmbRl7nRVDqTrXZ4XzoAo+6YzJbG9Tr9TtRRob?=
 =?us-ascii?Q?aYETdMgVGFcjbQtHgHdvbmHf+bvuFdEhUrc9H4O+LLzag5Ol9iCU7wJr9Gs3?=
 =?us-ascii?Q?aEGXOCFl3A71ZTROCu0O0evJc1QzZIpKk5r4vAOYT41yuNl/6kuT3YqbhqNe?=
 =?us-ascii?Q?1C2swd6fajWSQbYze5auxV28rvOO4gKLHciFVCUGfELYfk5fos/qg0nD/nsd?=
 =?us-ascii?Q?SeFHGwHIaf2m/ZX6bUBkf8Lq+IFudt9DZgq+5lxqPcyEKXmwQVOWYJgcmOFu?=
 =?us-ascii?Q?tLDcX6QhRTRTNOmIxSzJK95S/qO35lTuXN0z33Yv6hBuXoACaYViKLLqq4bc?=
 =?us-ascii?Q?Nub9LkPVEW2b7L9gv0FfZ4dKcG1WZPTMpWDAnd0TprZv2Jr8QcNRb9oKCR0a?=
 =?us-ascii?Q?5rN5j+88kDnMK2G+qdiXtelTxFUOxHaT674MGd5LG/uy/evI9qVpQnagcmSF?=
 =?us-ascii?Q?nm7OcqI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ANUMlp3fWgabQP07gkPbWv/f5QWdlk4q8oijasV4Gd3UjIy3Wq26Ubbj2RHw?=
 =?us-ascii?Q?njdjg8CBTP38b/SI8Qj2q6nJwNKOKGEzqJthPO3AIR2FD1i3ZtRLgql6zxva?=
 =?us-ascii?Q?N/8kBWVe8INotuHNXV71YYcfSnPbMu88bwIk3rnjXOTQ4W7UEntF0fjGLIPz?=
 =?us-ascii?Q?lodUZJtVrGUUbJEHHDShIdmACjRO41sbO0Xl7tGrUnjBFEQTPw2pecaZICOZ?=
 =?us-ascii?Q?zPC2aT5pfFQejI/vk1U4HEnV2RB7m06Gxj0finD83+Dgq20ehvQ8dfTUeb+E?=
 =?us-ascii?Q?bUgrJJHCqi1D+zB6LotI34897Gt4BcI6m/B0Vrm+DmeebqJSKs67NhVZXB+t?=
 =?us-ascii?Q?YTlR0VNP826LtVdqZXEisskpOa0KP4RF2agKK867uyULCTTRSjNh9142I9zP?=
 =?us-ascii?Q?s6vUSmSrCFkfEMtcX8AhoQYLQZxg+zTOBYuar6szgdHOj7zKylkhhGZFKorK?=
 =?us-ascii?Q?JOP6Cniu+8Hl78U5yItMXnS4JWNhm5Wwywt20ceHc5wVJH+l8I9oXHaQKcQb?=
 =?us-ascii?Q?SLb6/9rx2wQ1ZGIaQN0QHgYPzRsmJVKeO4ZVTcO1cvprI5RcZYd8K61f6IVK?=
 =?us-ascii?Q?xGr5eTm1qhHimkI2md8vexx7KoH53EJrOZx/MDVKH50jmlYRaIw4C5p+1R0O?=
 =?us-ascii?Q?LcxljO2+p5ho4t+6Lurwb2epg+mGYi4VIxEIOip7yaXSmB9/axFyIrVhwsgN?=
 =?us-ascii?Q?qHgBRe9ySGVJoUz/1Qow9AvMLvyCEjg2IfjfEp79Ie4hag2PQVEnwollmEXf?=
 =?us-ascii?Q?NG+ypdO9b4Ttahyiz5ikzTS37IHH382IgCmY12iou7jOPncBwuTt3pxJHvRU?=
 =?us-ascii?Q?D/gc641EblpppVyDsGLgsrYhjhDVWx81c+8gFohwvoW2ffcHnRw+FUw9PX43?=
 =?us-ascii?Q?Us3LKwjwTnCLlREGwsLsAyPw++22CxIqLu1JgfyGawIWR+u6dExHwo9pG9MA?=
 =?us-ascii?Q?rXAPEvsgfYTTjjU7sJT5hcVGHxE6wCbW+IdyLQVnwboK8t1aNu3dNHg7OVyC?=
 =?us-ascii?Q?5kC4JdNt7l7LMYFOLfb5n4Kw0O6JjmtTcreRNZ8Ztnph4iwPiB0X6xCLoUMk?=
 =?us-ascii?Q?ajZAmhMX/ptiuu9QnsU8GdBbXQ8cR3eOQAjZiHYP8paMieu10By0PRrQZh3p?=
 =?us-ascii?Q?K3golElIbT1vj6qw34cvKKqBtA6O9G7Fq8om15V1sTrWOPNr1bda3/gWkdRg?=
 =?us-ascii?Q?jwbMr288hGUYieRC6cuYQXhEW+PIfBHL7dBoeVudsrDmLS5XGAy//myPBnCL?=
 =?us-ascii?Q?qmGQjk73NZ+/glEn2cQ3x6QBTNRbsm3PM3KgShH4YG8c8/wZ8fVFQvwvEtZ/?=
 =?us-ascii?Q?JABNUxxi+5i3vug9YFMSnOsc7mqgfiDkrIJbCBJVmTChcrxvWjZkB/ECbjgl?=
 =?us-ascii?Q?Y6JruOKSpTuh/Xik6JEyjlC8z/ARpPN56xCx4Is9AtvGe2qpltHZgXuPSEk6?=
 =?us-ascii?Q?z1R6/jXsUz1j+lMKyIeol6pZSq5fgF/NDKAjwXVQyZqGo0i03LCy1VrhQqei?=
 =?us-ascii?Q?5dg85yFMBmkuLtbQGKNFBlWq74Zh1ggt009ap5s1560eG8acmKDcyC7/R5yU?=
 =?us-ascii?Q?yLmaC+wcWgQb7OkfUV8xeCYg2W3wLBQD20pq9eer?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff28a374-4c96-4f7e-2a12-08dcdae21e44
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 08:39:48.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcSo+jMBhdyXT9CpFoiP7U/T0bwKI7X81vabK3GoSnjrb6u9Gm/8zVUPg8XrRWdkM77H9nNUKWD9hCXxEMyGrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6557
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 6f4c005a5f8b8ff1ce674731545b302af5f28f3f ("[RFC PATCH 2/4] calculate memory.low for the local node and track its usage")
url: https://github.com/intel-lab-lkp/linux/commits/kaiyang2-cs-cmu-edu/Add-get_cgroup_local_usage-for-estimating-the-top-tier-memory-usage/20240921-061404
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20240920221202.1734227-3-kaiyang2@cs.cmu.edu/
patch subject: [RFC PATCH 2/4] calculate memory.low for the local node and track its usage

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 0af685cc17 | 6f4c005a5f |
+---------------------------------------------+------------+------------+
| boot_successes                              | 12         | 0          |
| boot_failures                               | 0          | 12         |
| BUG:kernel_NULL_pointer_dereference,address | 0          | 12         |
| Oops                                        | 0          | 12         |
| RIP:si_meminfo_node                         | 0          | 12         |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 12         |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409221625.1e974ac-oliver.sang@intel.com


[   14.204830][    T1] BUG: kernel NULL pointer dereference, address: 0000000000000090
[   14.206729][    T1] #PF: supervisor read access in kernel mode
[   14.208090][    T1] #PF: error_code(0x0000) - not-present page
[   14.209393][    T1] PGD 0 P4D 0
[   14.210212][    T1] Oops: Oops: 0000 [#1] SMP PTI
[   14.211269][    T1] CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.11.0-rc6-00570-g6f4c005a5f8b #1
[   14.213284][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 14.215290][ T1] RIP: 0010:si_meminfo_node (arch/x86/include/asm/atomic64_64.h:15 (discriminator 3) include/linux/atomic/atomic-arch-fallback.h:2583 (discriminator 3) include/linux/atomic/atomic-long.h:38 (discriminator 3) include/linux/atomic/atomic-instrumented.h:3189 (discriminator 3) include/linux/mmzone.h:1042 (discriminator 3) mm/show_mem.c:98 (discriminator 3)) 
[ 14.216523][ T1] Code: 90 90 66 0f 1f 00 0f 1f 44 00 00 48 63 c6 55 31 d2 4c 8b 04 c5 c0 a7 fb 8c 53 48 89 c5 48 89 fb 4c 89 c0 49 8d b8 00 1e 00 00 <48> 8b 88 90 00 00 00 48 05 00 06 00 00 48 01 ca 48 39 f8 75 eb 48
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	66 0f 1f 00          	nopw   (%rax)
   6:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   b:	48 63 c6             	movslq %esi,%rax
   e:	55                   	push   %rbp
   f:	31 d2                	xor    %edx,%edx
  11:	4c 8b 04 c5 c0 a7 fb 	mov    -0x73045840(,%rax,8),%r8
  18:	8c 
  19:	53                   	push   %rbx
  1a:	48 89 c5             	mov    %rax,%rbp
  1d:	48 89 fb             	mov    %rdi,%rbx
  20:	4c 89 c0             	mov    %r8,%rax
  23:	49 8d b8 00 1e 00 00 	lea    0x1e00(%r8),%rdi
  2a:*	48 8b 88 90 00 00 00 	mov    0x90(%rax),%rcx		<-- trapping instruction
  31:	48 05 00 06 00 00    	add    $0x600,%rax
  37:	48 01 ca             	add    %rcx,%rdx
  3a:	48 39 f8             	cmp    %rdi,%rax
  3d:	75 eb                	jne    0x2a
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 8b 88 90 00 00 00 	mov    0x90(%rax),%rcx
   7:	48 05 00 06 00 00    	add    $0x600,%rax
   d:	48 01 ca             	add    %rcx,%rdx
  10:	48 39 f8             	cmp    %rdi,%rax
  13:	75 eb                	jne    0x0
  15:	48                   	rex.W
[   14.220364][    T1] RSP: 0018:ffffb14b40013d68 EFLAGS: 00010246
[   14.221717][    T1] RAX: 0000000000000000 RBX: ffffb14b40013d88 RCX: 00000000003a19a2
[   14.223496][    T1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000001e00
[   14.225170][    T1] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000008
[   14.226964][    T1] R10: 0000000000000008 R11: 0fffffffffffffff R12: ffffb14b40013d88
[   14.228774][    T1] R13: 00000000003e7ac3 R14: ffffb14b40013e88 R15: ffff98ab0434f7a0
[   14.230421][    T1] FS:  00007f9569ae9940(0000) GS:ffff98adefd00000(0000) knlGS:0000000000000000
[   14.234569][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.235900][    T1] CR2: 0000000000000090 CR3: 0000000100072000 CR4: 00000000000006f0
[   14.237620][    T1] Call Trace:
[   14.238502][    T1]  <TASK>
[ 14.239254][ T1] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 14.240189][ T1] ? page_fault_oops (arch/x86/mm/fault.c:715) 
[ 14.241254][ T1] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 14.242297][ T1] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 14.243313][ T1] ? si_meminfo_node (arch/x86/include/asm/atomic64_64.h:15 (discriminator 3) include/linux/atomic/atomic-arch-fallback.h:2583 (discriminator 3) include/linux/atomic/atomic-long.h:38 (discriminator 3) include/linux/atomic/atomic-instrumented.h:3189 (discriminator 3) include/linux/mmzone.h:1042 (discriminator 3) mm/show_mem.c:98 (discriminator 3)) 
[ 14.244443][ T1] ? si_meminfo_node (mm/show_mem.c:114) 
[ 14.245460][ T1] memory_low_write (mm/memcontrol.c:4088) 
[ 14.246547][ T1] kernfs_fop_write_iter (fs/kernfs/file.c:338) 
[ 14.247804][ T1] vfs_write (fs/read_write.c:497 fs/read_write.c:590) 
[ 14.248830][ T1] ksys_write (fs/read_write.c:643) 
[ 14.249783][ T1] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 14.250800][ T1] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   14.252260][    T1] RIP: 0033:0x7f956a64b240
[ 14.253276][ T1] Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
All code
========
   0:	40 00 48 8b          	add    %cl,-0x75(%rax)
   4:	15 c1 9b 0d 00       	adc    $0xd9bc1,%eax
   9:	f7 d8                	neg    %eax
   b:	64 89 02             	mov    %eax,%fs:(%rdx)
   e:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  15:	eb b7                	jmp    0xffffffffffffffce
  17:	0f 1f 00             	nopl   (%rax)
  1a:	80 3d a1 23 0e 00 00 	cmpb   $0x0,0xe23a1(%rip)        # 0xe23c2
  21:	74 17                	je     0x3a
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 58                	ja     0x8a
  32:	c3                   	retq   
  33:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  3a:	48 83 ec 28          	sub    $0x28,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 58                	ja     0x60
   8:	c3                   	retq   
   9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10:	48 83 ec 28          	sub    $0x28,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   14.257195][    T1] RSP: 002b:00007ffcc66594e8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   14.259009][    T1] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f956a64b240
[   14.260848][    T1] RDX: 0000000000000002 RSI: 00007ffcc6659740 RDI: 000000000000001b
[   14.262500][    T1] RBP: 00007ffcc6659740 R08: 0000000000000000 R09: 0000000000000001
[   14.264147][    T1] R10: 00007f956a6c4820 R11: 0000000000000202 R12: 0000000000000002
[   14.265934][    T1] R13: 000055fd63872c10 R14: 0000000000000002 R15: 00007f956a7219e0
[   14.267589][    T1]  </TASK>
[   14.268340][    T1] Modules linked in: ip_tables
[   14.269410][    T1] CR2: 0000000000000090
[   14.270478][    T1] ---[ end trace 0000000000000000 ]---
[ 14.271717][ T1] RIP: 0010:si_meminfo_node (arch/x86/include/asm/atomic64_64.h:15 (discriminator 3) include/linux/atomic/atomic-arch-fallback.h:2583 (discriminator 3) include/linux/atomic/atomic-long.h:38 (discriminator 3) include/linux/atomic/atomic-instrumented.h:3189 (discriminator 3) include/linux/mmzone.h:1042 (discriminator 3) mm/show_mem.c:98 (discriminator 3)) 
[ 14.272874][ T1] Code: 90 90 66 0f 1f 00 0f 1f 44 00 00 48 63 c6 55 31 d2 4c 8b 04 c5 c0 a7 fb 8c 53 48 89 c5 48 89 fb 4c 89 c0 49 8d b8 00 1e 00 00 <48> 8b 88 90 00 00 00 48 05 00 06 00 00 48 01 ca 48 39 f8 75 eb 48
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	66 0f 1f 00          	nopw   (%rax)
   6:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   b:	48 63 c6             	movslq %esi,%rax
   e:	55                   	push   %rbp
   f:	31 d2                	xor    %edx,%edx
  11:	4c 8b 04 c5 c0 a7 fb 	mov    -0x73045840(,%rax,8),%r8
  18:	8c 
  19:	53                   	push   %rbx
  1a:	48 89 c5             	mov    %rax,%rbp
  1d:	48 89 fb             	mov    %rdi,%rbx
  20:	4c 89 c0             	mov    %r8,%rax
  23:	49 8d b8 00 1e 00 00 	lea    0x1e00(%r8),%rdi
  2a:*	48 8b 88 90 00 00 00 	mov    0x90(%rax),%rcx		<-- trapping instruction
  31:	48 05 00 06 00 00    	add    $0x600,%rax
  37:	48 01 ca             	add    %rcx,%rdx
  3a:	48 39 f8             	cmp    %rdi,%rax
  3d:	75 eb                	jne    0x2a
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 8b 88 90 00 00 00 	mov    0x90(%rax),%rcx
   7:	48 05 00 06 00 00    	add    $0x600,%rax
   d:	48 01 ca             	add    %rcx,%rdx
  10:	48 39 f8             	cmp    %rdi,%rax
  13:	75 eb                	jne    0x0
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240922/202409221625.1e974ac-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


