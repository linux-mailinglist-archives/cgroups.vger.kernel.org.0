Return-Path: <cgroups+bounces-10176-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD033B7CC70
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 14:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A87188675E
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 05:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CB7205AB6;
	Wed, 17 Sep 2025 05:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrKRE2Dy"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5CBA945
	for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 05:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758085310; cv=fail; b=sZI/z7vrSbEJyiQ64sCKmudK3QQm2zMT0nRBa0LVjqvIS79/vo1rZZ3nB4j+P0NvKReU4s4Kf7k4GK2QzlmZ7VWON6lzvKAUxde+k1icIb7mmTn7+UOMc4UgVeCiXaIIDXtjBILDSWYz3Jy+sYKLKM0uXGTfSNlXO3GwKSEjF9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758085310; c=relaxed/simple;
	bh=du7Us7r4FQiH6TArOCG/PUpBC6JijYhWDyZ70YyCg48=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LhCZQ6WUYM8kPR42mDBuFJOYrYhDJUywkz3PxeumxMDdQsMnEQC+bpf97PuOjYpn8jY/vUtgYP72jfPOt+PLm3cUVwwvMW8iMA0F+PNPsqijINxv0F7tf/fPbRh6oZXcg+/WRBVXd6uhGA2KhzFJS7QXWQq+jpAmqkf38U/Rn14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrKRE2Dy; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758085309; x=1789621309;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=du7Us7r4FQiH6TArOCG/PUpBC6JijYhWDyZ70YyCg48=;
  b=OrKRE2Dyw2g/jVULZdFYQ2D4s+I0UgwsrYGV0hhCmC+rKVn1a5BhOcsq
   0Gsem4WRmodV4+LLznz/QPQxzeaDXCYY2f0qdMvgBtK4DjTFq3xC2ZUVA
   9XrMdU7zrg2zG3dgABruN66c3X4/R2MngR+nY79zajyej7XGRD930hpiO
   oufVf2TIUq0B7btOEowHQO5PQB7cX4ml3VT8SflV8QcYcr/axEMCEvKtD
   lXrHPAsXJUXAururu2qL5LbO/9X84hDA9/nCZacm2Ldt9HyJjIhz8zahM
   kXEdL193+X+HSXJ4MgVHB3OV/du1SU0Ot8yF151RlghxqvMDrz913llun
   w==;
X-CSE-ConnectionGUID: BmR7cqmITkKDhrkNY2XgaQ==
X-CSE-MsgGUID: BEuNrMkMSoqmXkBOD+Qh8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64181196"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64181196"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 22:01:48 -0700
X-CSE-ConnectionGUID: mlx5w1ORTS6IhkPD0xNiwA==
X-CSE-MsgGUID: 7zZiHBWySsGHiOMDMZWbLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="174752068"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 22:01:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 22:01:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 22:01:47 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 22:01:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCaZCNW5wJuy6YIjCydu0oF+52dBA+LyeBjulN7CkqU/GF6+g27uhYzZl59Iqyvfr7nu2QWniUosJodkDIZ+WwVZ8HWzFlAplQlX2Mx8HJlc6SCaxJo29QB326DLCPFKgfdXl+qb5WlqU9YS+ofk9BJV+OSbPVsVBODCIysA0x70K3723MTo+uYwQoeoEy0fRu3vlW5lBvRM5SqhXWY1KD+0YMbz1fLD9VoBSL0sZk0yijHCNmZAVYH27ihfeD/6OI1lybvcc8ghHU6N9dKLSbyCHRt87Qk2rxiHixQRL6vaSKFrB6QDmaMqM1IRldrAqL5YWoYAFx8KtepRYVf0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhpyuXh0iCiCgyANr7TXzRXVOsypmB/kJJdN4f92m4Q=;
 b=XFi2ivSiav9WOZNq8MuVfWYTi4Kvoe8ABTNrrTmQkLnjKnjbZfCzRHrBe7Dj2NxGzvYRp3nc91/fBIH27w14p0qOStG9WBrV0R+dm2wWTun5kOx0h4Zsn1lwKiPcTXCKoYiv6tt/Aw/Wqhpoex6K5VkBf2da1Q5u2PFAPhtrRoyEkO+RHhXT6KEm4y89oW4PQouQkbSR8L+PpZbcA5LGgqQEGR4+rp86uf3BlCUy4GLJnEXzbQC7A0RzIpaW/DBb5NsQgdHGYOF4Fc5KzJ9ngoyQxBwJDzu4ch8lptRWjtDqDKPXyST/ZvEXtI3vjwVFD3GI+uuTwIFA8GYayjO46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 05:01:42 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%5]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 05:01:42 +0000
Date: Wed, 17 Sep 2025 13:01:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Alexei Starovoitov <ast@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Vlastimil Babka
	<vbabka@suse.cz>, <kasan-dev@googlegroups.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [slab]  db93cdd664:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202509171214.912d5ac-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|CY5PR11MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d2cc52-1325-4a97-9f73-08ddf5a74afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?USMeaV7qTrvI3H/7TB/PvbpnYN/lpZRnIrY8TpJc7dQmAEd5ctOH6O4U/Xol?=
 =?us-ascii?Q?RJdQqBpXgVJLun8Lt9AZ6Zn4c6euNi2w6eUMNDhJ9AnCvh+8PaExg5keShgs?=
 =?us-ascii?Q?8DZkyG+76pboJiD5pVovFQ1zfFOajLlq7816XEBgir8dgRsqdSYMtv4iVsfv?=
 =?us-ascii?Q?QOjcXO+03qMr64J+keivIspTkNRYpq4VzHeqHRd6eb2F2Y5QC4vC0zSr7Ve3?=
 =?us-ascii?Q?zMib/sYXc5g2NdvZBY9Jldzc0hB1ckPAO5+nGglRMqniNSR8MgS/UD0ajMKW?=
 =?us-ascii?Q?GCDdncL5Pm5LMZHdhlcyZNWUZwnOymVS6iPkNMVrG0meMbUsdt/NKxSLD2jQ?=
 =?us-ascii?Q?ZYzu8iC96yykU1q8XMjEh0E04+nngp4lP+ZlYFtQzSlm+58FemTsT2riYHAp?=
 =?us-ascii?Q?toLQcU7PrF6QF9u4YnRtVwxOKcBjpxSf6bqhE91c9XDikJO4Z8wlBGsMD0fH?=
 =?us-ascii?Q?mMfCfxrxR6aYUkx4waEjCSmHjfBuup6sgdU1p6u73pgMw73a5gVErQuR475F?=
 =?us-ascii?Q?bu1CicnEyxl1gPpnLXZn5CokxUezLmZ734Yrzm7rSwVjtLwQnBHkU6DluOPV?=
 =?us-ascii?Q?LBsISsL80LD2BMQ7KHiF2kFs0VHAzGnW6GHvVIDA9GskCusgrx9ZeIT/pIzy?=
 =?us-ascii?Q?0+x/79tD2Zjsv7TPKDvyFHTmJx0Fk07fyNnP8WklC3mCZ0kNTMHCIv1Aa9y7?=
 =?us-ascii?Q?phM/s+6VE1JpAJWwCtjZi9ZHXEftEeXM4cGKjoSW8KHTY0tKfTa+4Sl7kZdk?=
 =?us-ascii?Q?LqLbbLM9ET4HkbtOq66BhZtkywTHmutA4ihrMrJL++4IyT6KjiYoUpyns8Yh?=
 =?us-ascii?Q?Q349opfolVdVFMwZ6P2kZxgJ4oLxZSf7kem2j3LI8UCREF8gJ58KtqXLgtBD?=
 =?us-ascii?Q?n4RfujFEXqc/ogCYDuC56JSgVa8Pe2hY0aKI6ltnJuAYZsxBeW3376JNPp6P?=
 =?us-ascii?Q?aAYCZFcI084THgG2iBFr4QCAsCIA61P47DB1t01GVF+fpw791wAf1edVM0hO?=
 =?us-ascii?Q?d5rFWiYlGG1r1ocpQiJ2UkYhgqNucBwTRrS9AER2VvDQrVMUaz/R053uRw/s?=
 =?us-ascii?Q?XQwujeIFbIlqoMxZKDHvlljQgsQbmSQ9dCNJIaGN4c+ihpLIvlbiOQ7Tn5/K?=
 =?us-ascii?Q?acF7CcuDdT60s50Nb+er8EnivSaFE5RpOWFu6MUgwvgnXgkXvnLTOZHsro3O?=
 =?us-ascii?Q?5UyGPBHE5aEMiwRNawb07l5FMr1exC9t36iPqgC1rVHD7+B9n4LT/jdNY3dU?=
 =?us-ascii?Q?Pv+obc6xxMniNXwoKlR6U6OBcII32IqJ0lJ2maG6j5SdnKpfuczw8KvYJmGD?=
 =?us-ascii?Q?ZukKLeULTSdgQJAhgOv6o58dzHA0uerjLJ0txBAkR9bzV/i2RCGIajzXQf11?=
 =?us-ascii?Q?zRriBGp0leNsIIC/RafwJfqBdk/E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ffnI7wKFEHERYtFU3tRMzOdj63kwWunJQbYHGNkkbXiv+lzoeHiv04vUoGCH?=
 =?us-ascii?Q?PLH0Xodjk+LP5ieCzwcsh80gULJDikbaueq4/R/6/BWqBnrpC3wP/J+F1/mY?=
 =?us-ascii?Q?39XAkqfYiYBRUdiZdl0GGSJNUI5CS2/uMQ2bow5U9T+vGiVkpLvlC3LMTTJn?=
 =?us-ascii?Q?w0b3VF8IwvvyhZKgaJXqkH5z2mmz78Z8Vv8kZnOEGYfjPKDLT8YSmNgoU0Ll?=
 =?us-ascii?Q?HgDQ1ue2cDjdTLVoc153TgfirqgCLEKJPzIR82C8jdXc2rilDUcvnYkIfvWp?=
 =?us-ascii?Q?wVK1BlUXuvRQH1ycT8n1TlpOjbwR5dZoIJmdJT82pL6ji/PDVeLge/dKxoAt?=
 =?us-ascii?Q?/sKsGv53xBFfu5vg6yGzUAUtrxRarHRk37ujKOC8TAghSB42b70OQ43owL5/?=
 =?us-ascii?Q?mBRZxCsXKTt7We1eGbACdxb3ynK3AqZNwNIo8MNT3WoDfe++Or3m8tu8LJ6x?=
 =?us-ascii?Q?jFqt/gx/3x0RSKI0eh5Bqj5VFogxk/tPmCej01TTCPED/P8TPSYQoplzigk6?=
 =?us-ascii?Q?5L3VYG7miIR0FW63v5+AM+3Oby+2EMPrtTQcIL6pgC1Igh8vNSfRaA3loI4h?=
 =?us-ascii?Q?TVZE5wjDLKMrYNuaIG7QA/B7a/jZQFV7IX8TrU+R6peUTZf7tV612UrupjaX?=
 =?us-ascii?Q?ziuZlOrjqRLf7q5JYUmvZJFByjuY0uF80juF7kdjiOPBrDSMbasPX4pl9Q55?=
 =?us-ascii?Q?hTnLLVfDcy3iJMDxOXzrbcOg3vDQc9D9cdF/nyQZbjtA2w4emafQwZSIDqz+?=
 =?us-ascii?Q?U0J1lMWBu3aHidR23865SysurfKb2x6+V2U1dCgezSN2nlAQzOszSe0GaK9P?=
 =?us-ascii?Q?5o8liPOv2KMlkTkAvwtHJu7S2TIJN6SJqPozXHh/31WOGCTHBvVPvPBw7WXH?=
 =?us-ascii?Q?mO5n+WHJ63SxIjnBGgZJT2qlbXsqBD1Ovv/pTxVZnKQf5RMesU88IVuSncpq?=
 =?us-ascii?Q?V03p4DfH+OwDvb9zvhFwPx/wt1rLLV4IIXiCTQ5fHnSwHumBN7bTxXVapwkj?=
 =?us-ascii?Q?rquIGNwBTu6/7wCLvtUacd4gQP6I6b16ki9/539fE38kxLU6A0bETkPQaAv8?=
 =?us-ascii?Q?kLRB+si8u3M90ozpjfjKyqo+BmYgZJ7pJjB22RrAyiT3n2TcSG1B+7up7NZR?=
 =?us-ascii?Q?CP26UhHjCob7VLkmEgWCVV7cr/42oOwumqc4SB6Y3jLG/ZzjvuJsAsdTx8Vb?=
 =?us-ascii?Q?hi83myJikOXG5/u2cK7Bz4gTLKI6cGci8rThfundsZH0Lt+s53f6NaDgBtZb?=
 =?us-ascii?Q?W2EFB6NNjzVDPAMmnOarHctEFj6Wu2WpcpjGkm6B4yUpgFOij4oU2eQC7aos?=
 =?us-ascii?Q?SBJ0WzSv1Ze6vOApK90HAgTH3Zexk4HOKaTc47QyPU4HjR3TB0+HxoxtJM4B?=
 =?us-ascii?Q?cuMOvAygPbBqMNf4Cp7MM/azRIXS9V1y+RUECJS4/XTpTKzSIFhIyl+HkLR8?=
 =?us-ascii?Q?sVo45+V/93m72Y3Qlaw0AK271UeM+2F+Laq5Yi+F+luOp9FMBVH20/s0o1DM?=
 =?us-ascii?Q?eOY0g2OeubegN3hcGbb5xjWK/75a2c4STfIXUV3pU/24y8VjYCG6HApnyoLN?=
 =?us-ascii?Q?novzXVE5c442EH7M7sjqtAWj1x3FtIpnBha3Mvt/7bd99ZLzJ/9gKbNS7Tsw?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d2cc52-1325-4a97-9f73-08ddf5a74afd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 05:01:42.5522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMwd3llPKZM1TQZfnlZU9waLiMufdnJGeFiHfjzYGb5i85BmIY1ovrhEMgNY0tKvR6yaAJ5HixCIMnlksB3uoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6258
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: db93cdd664fa02de9be883dd29343b21d8fc790f ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: boot

config: i386-randconfig-062-20250913
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509171214.912d5ac-lkp@intel.com


[    7.101117][    T0] BUG: kernel NULL pointer dereference, address: 00000010
[    7.102290][    T0] #PF: supervisor read access in kernel mode
[    7.103219][    T0] #PF: error_code(0x0000) - not-present page
[    7.104161][    T0] *pde = 00000000
[    7.104762][    T0] Thread overran stack, or stack corrupted
[    7.105726][    T0] Oops: Oops: 0000 [#1]
[    7.106410][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G                T   6.17.0-rc3-00014-gdb93cdd664fa #1 NONE  40eff3b43e4f0000b061f2e660abd0b2911f31b1
[    7.108712][    T0] Tainted: [T]=RANDSTRUCT
[    7.109368][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 7.110952][ T0] EIP: kmalloc_nolock_noprof (mm/slub.c:5607) 
[ 7.112838][ T0] Code: 90 90 90 90 90 89 45 bc 0f bd 75 bc 75 05 be ff ff ff ff 46 83 fe 0e 0f 83 b6 01 00 00 6b c7 38 8b 84 b0 b4 79 d0 b2 89 45 ec <8b> 40 10 a9 00 00 01 00 75 1b 8b 0d ec 28 db b3 31 f6 a9 87 04 00
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	89 45 bc             	mov    %eax,-0x44(%rbp)
   8:	0f bd 75 bc          	bsr    -0x44(%rbp),%esi
   c:	75 05                	jne    0x13
   e:	be ff ff ff ff       	mov    $0xffffffff,%esi
  13:	46 83 fe 0e          	rex.RX cmp $0xe,%esi
  17:	0f 83 b6 01 00 00    	jae    0x1d3
  1d:	6b c7 38             	imul   $0x38,%edi,%eax
  20:	8b 84 b0 b4 79 d0 b2 	mov    -0x4d2f864c(%rax,%rsi,4),%eax
  27:	89 45 ec             	mov    %eax,-0x14(%rbp)
  2a:*	8b 40 10             	mov    0x10(%rax),%eax		<-- trapping instruction
  2d:	a9 00 00 01 00       	test   $0x10000,%eax
  32:	75 1b                	jne    0x4f
  34:	8b 0d ec 28 db b3    	mov    -0x4c24d714(%rip),%ecx        # 0xffffffffb3db2926
  3a:	31 f6                	xor    %esi,%esi
  3c:	a9                   	.byte 0xa9
  3d:	87 04 00             	xchg   %eax,(%rax,%rax,1)

Code starting with the faulting instruction
===========================================
   0:	8b 40 10             	mov    0x10(%rax),%eax
   3:	a9 00 00 01 00       	test   $0x10000,%eax
   8:	75 1b                	jne    0x25
   a:	8b 0d ec 28 db b3    	mov    -0x4c24d714(%rip),%ecx        # 0xffffffffb3db28fc
  10:	31 f6                	xor    %esi,%esi
  12:	a9                   	.byte 0xa9
  13:	87 04 00             	xchg   %eax,(%rax,%rax,1)
[    7.115899][    T0] EAX: 00000000 EBX: 00000101 ECX: 00000200 EDX: 00000000
[    7.116940][    T0] ESI: 00000009 EDI: 0000000e EBP: b2d07d18 ESP: b2d07cd4
[    7.118013][    T0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210002
[    7.119201][    T0] CR0: 80050033 CR2: 00000010 CR3: 03672000 CR4: 00000090
[    7.120263][    T0] Call Trace:
[    7.120791][    T0] Modules linked in:
[    7.121455][    T0] CR2: 0000000000000010
[    7.122145][    T0] ---[ end trace 0000000000000000 ]---
[ 7.123070][ T0] EIP: kmalloc_nolock_noprof (mm/slub.c:5607) 
[ 7.123973][ T0] Code: 90 90 90 90 90 89 45 bc 0f bd 75 bc 75 05 be ff ff ff ff 46 83 fe 0e 0f 83 b6 01 00 00 6b c7 38 8b 84 b0 b4 79 d0 b2 89 45 ec <8b> 40 10 a9 00 00 01 00 75 1b 8b 0d ec 28 db b3 31 f6 a9 87 04 00
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	89 45 bc             	mov    %eax,-0x44(%rbp)
   8:	0f bd 75 bc          	bsr    -0x44(%rbp),%esi
   c:	75 05                	jne    0x13
   e:	be ff ff ff ff       	mov    $0xffffffff,%esi
  13:	46 83 fe 0e          	rex.RX cmp $0xe,%esi
  17:	0f 83 b6 01 00 00    	jae    0x1d3
  1d:	6b c7 38             	imul   $0x38,%edi,%eax
  20:	8b 84 b0 b4 79 d0 b2 	mov    -0x4d2f864c(%rax,%rsi,4),%eax
  27:	89 45 ec             	mov    %eax,-0x14(%rbp)
  2a:*	8b 40 10             	mov    0x10(%rax),%eax		<-- trapping instruction
  2d:	a9 00 00 01 00       	test   $0x10000,%eax
  32:	75 1b                	jne    0x4f
  34:	8b 0d ec 28 db b3    	mov    -0x4c24d714(%rip),%ecx        # 0xffffffffb3db2926
  3a:	31 f6                	xor    %esi,%esi
  3c:	a9                   	.byte 0xa9
  3d:	87 04 00             	xchg   %eax,(%rax,%rax,1)

Code starting with the faulting instruction
===========================================
   0:	8b 40 10             	mov    0x10(%rax),%eax
   3:	a9 00 00 01 00       	test   $0x10000,%eax
   8:	75 1b                	jne    0x25
   a:	8b 0d ec 28 db b3    	mov    -0x4c24d714(%rip),%ecx        # 0xffffffffb3db28fc
  10:	31 f6                	xor    %esi,%esi
  12:	a9                   	.byte 0xa9
  13:	87 04 00             	xchg   %eax,(%rax,%rax,1)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250917/202509171214.912d5ac-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


