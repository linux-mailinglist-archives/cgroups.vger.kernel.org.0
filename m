Return-Path: <cgroups+bounces-11559-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED407C2F7E9
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 07:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E6774E9C64
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 06:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307EC2C21CB;
	Tue,  4 Nov 2025 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFJwpGZ7"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DE81E8337;
	Tue,  4 Nov 2025 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238999; cv=fail; b=CS3HvqOxL4He8DUdHkYQFSTOa4yt6fHfrw7PnHeMqUPLLopf8G49W7Ak75EeYWmD24Er6mreAfKcMOV7+9zupDCsUSJjUNyOFZ1JG9pg8MCMp2yphXxGOSu6EkCzxjO7EohXeMiW54XLP6iqqX5zvkiWayrcC1hMfud5sw94Zss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238999; c=relaxed/simple;
	bh=LPnaFKEI6/gDtS3dUYBUrbZwEXxCdPZ5am3zAOJq4yo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mU2M4Trs+ky1D/bHZQyohhyGlU8HoEkIDaHQ0w5+c4FpVOm+24WlJBtD1I9O2QYFWU8b7oSq/lbyEeb7WQ+9nPZrWveZ1fOR5oNT8EV+WcCnUStBULEYg+vFibchWLImYAV4mmd7uWMVo8kiA9gM1LIKcox9qlfKHiu3gcIXDec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFJwpGZ7; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762238997; x=1793774997;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=LPnaFKEI6/gDtS3dUYBUrbZwEXxCdPZ5am3zAOJq4yo=;
  b=DFJwpGZ7Ay4S8ORgFbwzcM1zPLo8raUp0SGBNuV9BUuyfMLybV6KbFYS
   kUebkAB6vZdGkq+2OLcRUr/vI7Opy4mc9rWvaQpqW2anjG0MpCCxhAtdL
   KdZwA1LlWrLGbpVI2b450qiUQB9Xx7Q6GGSa6epYxdanYGmS8Zhu2nrkr
   UlS7VIn6+98QIYPhu8v/sp9mv38fVs0aTC31QxZ5cfO30kSxkjL1H2K1Z
   pdzJBUrsO6T36AhPecFuHB9LE+J8tRfB6wUcs4HJcewj5PwnOWr6laooH
   4zImnouRxtq2PJ4+66RY+HMrDg27/AJH0kBzrAZG/v0mt0ZF54Sbp/st+
   g==;
X-CSE-ConnectionGUID: en8o6xQOS+GxD2FC5j4ffg==
X-CSE-MsgGUID: jQwuiOzzQxiqN0loCvgsMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75676451"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="75676451"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 22:49:56 -0800
X-CSE-ConnectionGUID: qFVYfoo3SQy+tk8ezVTR2g==
X-CSE-MsgGUID: R86ply4fSeOADjfeMHPqeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="217887979"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 22:49:56 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 22:49:56 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 22:49:56 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 22:49:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAJDvuifBrTmJpduceemvUHDGwae9T6Qjcx8ReMrVgAHBE3yp6dc9UnctK4IsE3FvKF2mkN+DU6kZPV78cBErOIIW0XY/LbEzfpBa9CbCKxm67g629n0qalsItKxEM32KZ9jIVhrLQlpzILIMdHUx4qJkB+qtWpxdtU1H3nWZ3y4nZfOq9YyQ1a8ajuaYYbEkZ+jNgKUGc54VmIVrO5zMD00uF7zAfpqqyP5hO1792k2RMSZdc2RIDyJSkoduc64rq/L+wyatcOCRJ3h2JF7R827mTil2HM7MOU9sjbH4RqERTxDXB9qR5RDfX7ieBSTJVaPzrC3HfRgGl2XQyXruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHwArUnIZA5y0ynGyOv+5KLOx3SwzAmIyCscGFabf5s=;
 b=VIJDgwf7mq+hz9F82Ukt6GsBiq9YwB0Tvz10zErQz+KzYgxUpGFX4GS22SvCZgD1jSAl5Pexly/ojkKb1dUOEVOzdlW0MQP6/CJvaScPdr2Uu4VOHwEPgLIahZcpQX+HPW8B1EqOmFpNVM583+TGyiLMf3NGiho+HVgh0thSmx6vBJjIMRZyIn1wDp0519FF2SGNQCxhn4DgYpzxs8ooqBGZ8+0QSNiiePWMYa5DERiuL+llqbD13OXCvtpTvm0dk0D3aworeQX+jQo+fY3ey2BnYM98aqYv0Tk7CNXpTrFaKcIxE/eqD0rrKgP/ppn0Gm3y5njOT2bSjR9sloEyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 06:49:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 06:49:51 +0000
Date: Tue, 4 Nov 2025 14:49:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qi Zheng <qi.zheng@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Qi Zheng
	<zhengqi.arch@bytedance.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <hannes@cmpxchg.org>, <hughd@google.com>,
	<mhocko@suse.com>, <roman.gushchin@linux.dev>, <shakeel.butt@linux.dev>,
	<muchun.song@linux.dev>, <david@redhat.com>, <lorenzo.stoakes@oracle.com>,
	<ziy@nvidia.com>, <harry.yoo@oracle.com>, <imran.f.khan@oracle.com>,
	<kamalesh.babulal@oracle.com>, <axelrasmussen@google.com>,
	<yuanchu@google.com>, <weixugc@google.com>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, Muchun Song <songmuchun@bytedance.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v1 21/26] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
Message-ID: <202511041421.784bbd5e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d5d72d101212e9fb82727c941d581c68728c7f53.1761658311.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b395d85-4d44-4f4e-7a53-08de1b6e5aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hzah36m9OFBSlRW+QWj+8fGKk2GQ9HFsdGRb0dcX5tVnVLiGLaayUWqFtxYK?=
 =?us-ascii?Q?EeV46PcVwEeG9lH1CeATDo7F2kyGK68ubaiQZEvX/rW4bf7l7RammKobM/+Y?=
 =?us-ascii?Q?G58x1kDXuzj1JwoVJAvpShyiIoFGqQqL+EVUJYHoieffABcOCPL3UT+tDaRv?=
 =?us-ascii?Q?L39Pz8aEjwXldFRZF5MZVMUG5YRScPmufgl8vyz9KvefVoM2b1skvLQ3Wdpz?=
 =?us-ascii?Q?aTj/UJt8n8Q0/SbPogJQF8gPjJ2V+i54L6KPYOMvj5EEg6Ysi4D0B1wQ4Y7c?=
 =?us-ascii?Q?FcyKIOJdBNhh2N0MR3mOqs8zQr6RwqkgXithEx91WXdVKxjGWbgyHkVKwMfL?=
 =?us-ascii?Q?VqxLiLejMEOBcfi4tDIk3W91LdCExZ3PcgRIX6a0RslJU3CgMwc3TI/0r2QQ?=
 =?us-ascii?Q?f8yz6xwYt8MLESIJcj+wpdx6zfgl2NS3ELT6EMamrkSPDoc0P5OND8cFouYp?=
 =?us-ascii?Q?Y3BnOIpvBg7llELfHmn0LWN7wrEbIyTVRZM+0wYQCLs7caYTfJUlWLSNGGJn?=
 =?us-ascii?Q?mJ0BSaQezQH1zdkKdlBT5ukcuEQkH/How/bAzgvJ5HvQhFRTYi/THVxp8ARI?=
 =?us-ascii?Q?QD1U1UEYhe0wiX95vJR+kjUO8ZowUKOHSnTNhkKS5ai/vMh3/zTzPiqXJk5j?=
 =?us-ascii?Q?cynvaURHc8UMXoQZGt7xJb/rmd2GkSQB04v1RtHX5pIWi/b7TT/LSAAeEq98?=
 =?us-ascii?Q?f85UkGDXKlCfI6hxNIvXx/pGHi0OocEcssndI461nauHAN3qPnmKkBijg+Z+?=
 =?us-ascii?Q?9MUS/guVC5MZYQMJwu2XE0wA3amKxyHzWxP80Abvb8IskcJClmkcZ5JMHVdN?=
 =?us-ascii?Q?91o177PAKSkcTl/s8mMyyxc56B3L3PbluDhCeOmAv5c86w+SFEFxCDqmrH0y?=
 =?us-ascii?Q?r2mFmX82iB3bfiNe5Lbs0iYBLjFoW4bc7IyL9k2GNp48EBWtXD0kMlwG3Kcq?=
 =?us-ascii?Q?E5kG4du/bheQCLNCGTsPaOWEnUXS5RARVWjBfxrsVxjOQrDS7PuQC/OiqQ/a?=
 =?us-ascii?Q?kAGXvxJYcf6XtbuYru3EL2GQdO4as/AA0C5VT3w/7vU/XNoO+/3R3ddxYOcz?=
 =?us-ascii?Q?ZAKuHa3kQmVMiZV/ni4brzefGvV/dYbcspC8aYMHhqo5EYf5ReyEDLgeP+h4?=
 =?us-ascii?Q?2XZD/wVplMlyeu1RzRwcyIzIk0+729FyKRNOD11xc5qjmXPBeylZ6woL8Cbv?=
 =?us-ascii?Q?lWi9skScj14ogdfqnyZ5uKmynupItnowd7z6HSNF5/qnwMdNEa1RAFm2PadH?=
 =?us-ascii?Q?t8CD3fq8eu3mW0C/eXuN3CV8o9o5rGj0qFd89CBmb8ObiaCl8kJHCNYwSdLA?=
 =?us-ascii?Q?UNLyah0CG+uHUtPECdprwfhZSIQXQ0a/H/JzLxdRxaqz3KxEYxDyp/MuWiC8?=
 =?us-ascii?Q?7CbzXhrQW7HQbhGO5N9Uk34AeIHhBGCNNRinUjg9PxV0iLiYYkFhL9ACRgo+?=
 =?us-ascii?Q?I7p0s25bSReZdzyd+vYktiAZ/wN9Hae6qKtD7XsGKX2onMk7dc2tvg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rj2E1s9+jXY/LK8Cpl6sPM2X7q6w/Kx39LvRbowWQdWMrTB3DxhaS3eBxFre?=
 =?us-ascii?Q?OERIo7smCBMIyNaSQWv253/kT2NYY7kVHSgsfASCTnCSJNOgbWh5D2kGvA9r?=
 =?us-ascii?Q?HIOt6XYvu2eq32Z+vFGkeBfKwDXpz8Opaa17+hQVyAmM3U35WotHjkQ65Wgh?=
 =?us-ascii?Q?cAYRKR3rWsSGdbxpyc4weQVbitH3Kr7Io6g0Y7I7yj7P/ZRL8vbf2QtQ7ywk?=
 =?us-ascii?Q?Aw40Go3j14cJsu6UtTf3V+5q61qQzZY2ITsl30K8R7iw0B9JQK7G2/iD0WB3?=
 =?us-ascii?Q?loTMrZG91aejBEWx6xzYFybD9GgsGCPwXuk8cG3gYKZTx834dlpXU3YCSShD?=
 =?us-ascii?Q?w85yfoe8jlIAsmUcCKDwKQ5D2CgVk5CRoe7Je2j96sNH64bHLM/DBiml2Pbe?=
 =?us-ascii?Q?//ejosEywEz/USOz8zdkehnpCDJ3ZCkCkzWkWsEEgdsHEyPsuphl0ziP5mqS?=
 =?us-ascii?Q?9Yw0TcPmyf1lI7CPtBeFfa0NT4M8MUFMwAYaNxjvCc4AOFnqZiTB7MkfRckW?=
 =?us-ascii?Q?B9ExNXg3Li2BldX/BG2nyhpt5HTBsGhxwfYcqTj5iAN7ze0G9qs3yzU1MNEi?=
 =?us-ascii?Q?xOF95F3yYEQqhyGVkEVYY0bsCp6jNo29p0w4wot/2gcP8R6GV9nVwTo3Oxmm?=
 =?us-ascii?Q?Ehi0unpx4Y2VwOfN58OBIvVAlkrHUk/Z0eLlGD44l0KDNEgyvqFvsB+NBLpK?=
 =?us-ascii?Q?HtiuMRKixJHpI+iNN7J85M3q/8wGVdE7bfqXUeY67ZyEFQfilOAdp3RzlA6h?=
 =?us-ascii?Q?exoVEHsqJhIMSg3hLBlu8zxvV57eV58tO5FzaBddDF5O4lThujhJtLtsUUNY?=
 =?us-ascii?Q?UlyZVPJIc3UP9t7nAuTTnoKL+NY1/Tuv8SWua2V3kZTUPlszFv1Js9aeEi3o?=
 =?us-ascii?Q?9+1Jut/HDOUi68IR//iH4K7KefLJhf3AyFFZ5zPjlzrERg0QguLGlkahbZAF?=
 =?us-ascii?Q?uAcZH6JTBpZQ3Yo6SWXASYW6DWbaD86yWM4Y+BdavqOuul9GnUXel/wfMakQ?=
 =?us-ascii?Q?sbKru3GtcEpdNOwcNIHJk1uSegiPn7oiPt+gbhNwWHEWTIufigyGIlnX7vun?=
 =?us-ascii?Q?pOaIjBQG7mreqXxhT0O6H8pp+98hjqOfB9Xuqs2K2nZmzYfNSX1Iksb6swLb?=
 =?us-ascii?Q?FNBleRiJRrvVbT1cVIzu+s3vypQoBGdy6BmiRm1VQAIKDkiw1HU+hngVo7iJ?=
 =?us-ascii?Q?xGoE+WWA65odXkngLlqRcUwZKTh3lzT20nlbYAnbr0Kz5PsHHwVIEJyyjj5h?=
 =?us-ascii?Q?Ui+mJKNUQaTsn1h9J+2XBB24o11yCtrJ9czyzYkLLhR3eYGmxxQKXNiaEU7Q?=
 =?us-ascii?Q?3ummvbShSpA4dAjiUpX708B8ZSj3hdUxsX6eK5+Ovog056xqggvC3DMl8IC5?=
 =?us-ascii?Q?DX1KTgLGJ8roDhPAUVhnGTWUYnwGM7Trd/Aw4TRa7ehTMRcBVVCqV7gigU2W?=
 =?us-ascii?Q?gkW6ceiLKROD7IPwfbHQgC+X97h0oY8RAs1olxXQ+qVwblyHIOoar5qjm0w9?=
 =?us-ascii?Q?oLnn/huoKWYvI1xsQ72HLrkJ0wFD6r9GKbomzdhTh4NDV6cWQx47koL6wtUy?=
 =?us-ascii?Q?xyCVSw+Cp9b7RPOu/gZUjCWWI/PI0ukeOpjHIHr5VLE+6SE1mdDafaqO2jaf?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b395d85-4d44-4f4e-7a53-08de1b6e5aa8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:49:51.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KNlKY7AJ5DJoGeVNu1D19ztI7HIOhtY0qpHnpOtDXMuQo0kYT6Q9t1CkAVCulpums8aRVaYRvPJm3j8YpCZUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:bad_unlock_balance_detected" on:

commit: dd9e066d9677ca28748a63b16b33c858af75164b ("[PATCH v1 21/26] mm: memcontrol: prepare for reparenting LRU pages for lruvec lock")
url: https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/mm-memcontrol-remove-dead-code-of-checking-parent-memory-cgroup/20251028-221021
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/d5d72d101212e9fb82727c941d581c68728c7f53.1761658311.git.zhengqi.arch@bytedance.com/
patch subject: [PATCH v1 21/26] mm: memcontrol: prepare for reparenting LRU pages for lruvec lock

in testcase: boot

config: i386-randconfig-141-20251031
compiler: gcc-14
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------------------------+------------+------------+
|                                                                                   | c856dae1f8 | dd9e066d96 |
+-----------------------------------------------------------------------------------+------------+------------+
| WARNING:bad_unlock_balance_detected                                               | 0          | 87         |
| is_trying_to_release_lock(rcu_read_lock)at                                        | 0          | 87         |
| calltrace:rcu_read_unlock                                                         | 0          | 87         |
| WARNING:at_kernel/rcu/tree_plugin.h:#__rcu_read_unlock                            | 0          | 87         |
| EIP:__rcu_read_unlock                                                             | 0          | 87         |
| BUG:sleeping_function_called_from_invalid_context_at_mm/filemap.c                 | 0          | 87         |
| WARNING:at_kernel/rcu/tree_plugin.h:#rcu_sched_clock_irq                          | 0          | 87         |
| EIP:rcu_sched_clock_irq                                                           | 0          | 87         |
| EIP:evm_inode_alloc_security                                                      | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_include/linux/percpu-rwsem.h | 0          | 84         |
| BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h     | 0          | 86         |
| BUG:workqueue_leaked_atomic,lock_or_RCU:kworker##[#]                              | 0          | 84         |
| BUG:sleeping_function_called_from_invalid_context_at_mm/slab_common.c             | 0          | 23         |
| BUG:sleeping_function_called_from_invalid_context_at_kernel/workqueue.c           | 0          | 60         |
| BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/rwsem.c       | 0          | 73         |
| BUG:sleeping_function_called_from_invalid_context_at_lib/strncpy_from_user.c      | 0          | 41         |
| BUG:sleeping_function_called_from_invalid_context_at_mm/mmap.c                    | 0          | 16         |
| BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c       | 0          | 70         |
| BUG:sleeping_function_called_from_invalid_context_at_include/linux/uaccess.h      | 0          | 40         |
| BUG:sleeping_function_called_from_invalid_context_at_mm/memory.c                  | 0          | 55         |
| EIP:kmem_cache_alloc_noprof                                                       | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_fs/dcache.c                  | 0          | 69         |
| BUG:sleeping_function_called_from_invalid_context_at_fs/file_table.c              | 0          | 32         |
| BUG:sleeping_function_called_from_invalid_context_at_kernel/task_work.c           | 0          | 25         |
| BUG:sleeping_function_called_from_invalid_context_at_arch/x86/entry/syscall_32.c  | 0          | 46         |
| WARNING:at_kernel/rcu/tree_exp.h:#rcu_exp_handler                                 | 0          | 58         |
| EIP:rcu_exp_handler                                                               | 0          | 58         |
| EIP:find_bug                                                                      | 0          | 13         |
| BUG:sleeping_function_called_from_invalid_context_at_fs/pidfs.c                   | 0          | 9          |
| EIP:_parse_integer_limit                                                          | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_lib/iov_iter.c               | 0          | 64         |
| EIP:ep_poll                                                                       | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_mm/mmu_gather.c              | 0          | 18         |
| BUG:sleeping_function_called_from_invalid_context_at_fs/select.c                  | 0          | 12         |
| BUG:sleeping_function_called_from_invalid_context_at_net/core/sock.c              | 0          | 15         |
| EIP:handle_bug                                                                    | 0          | 25         |
| BUG:sleeping_function_called_from_invalid_context_at_include/linux/pagemap.h      | 0          | 14         |
| EIP:inflate_fast                                                                  | 0          | 20         |
| EIP:zlib_inflate_table                                                            | 0          | 2          |
| BUG:sleeping_function_called_from_invalid_context_at_mm/shmem.c                   | 0          | 2          |
| EIP:unwind_get_return_address                                                     | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_mm/vma.c                     | 0          | 11         |
| EIP:kmem_cache_alloc_lru_noprof                                                   | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_mm/mprotect.c                | 0          | 2          |
| EIP:console_emit_next_record                                                      | 0          | 10         |
| EIP:dump_stack_lvl                                                                | 0          | 31         |
| BUG:sleeping_function_called_from_invalid_context_at_include/linux/mmu_notifier.h | 0          | 13         |
| BUG:sleeping_function_called_from_invalid_context_at_mm/vmalloc.c                 | 0          | 2          |
| BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c             | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_fs/exec.c                    | 0          | 1          |
| EIP:preempt_count_sub                                                             | 0          | 1          |
| EIP:kunmap_local_indexed                                                          | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_mm/gup.c                     | 0          | 2          |
| EIP:seqcount_lockdep_reader_access                                                | 0          | 1          |
| EIP:_raw_spin_unlock_irqrestore                                                   | 0          | 5          |
| BUG:sleeping_function_called_from_invalid_context_at_kernel/exit.c                | 0          | 2          |
| BUG:sleeping_function_called_from_invalid_context_at_mm/rmap.c                    | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_mm/truncate.c                | 0          | 1          |
| EIP:finish_task_switch                                                            | 0          | 2          |
| EIP:inode_init_once                                                               | 0          | 1          |
| EIP:check_lifetime                                                                | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_fs/namei.c                   | 0          | 3          |
| BUG:sleeping_function_called_from_invalid_context_at_fs/readdir.c                 | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_kernel/rcu/srcutree.c        | 0          | 1          |
| EIP:memset_no_sanitize_memory                                                     | 0          | 1          |
| EIP:lookup_one_qstr_excl                                                          | 0          | 1          |
| EIP:__up_read                                                                     | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_fs/file.c                    | 0          | 3          |
| EIP:ramfs_symlink                                                                 | 0          | 1          |
| EIP:do_dentry_open                                                                | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_kernel/printk/printk.c       | 0          | 1          |
| EIP:unwind_next_frame                                                             | 0          | 1          |
| EIP:handle_softirqs                                                               | 0          | 1          |
| EIP:bad_range                                                                     | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_include/linux/freezer.h      | 0          | 2          |
| EIP:security_file_open                                                            | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_kernel/fork.c                | 0          | 2          |
| EIP:kernel_init_pages                                                             | 0          | 1          |
| EIP:filemap_add_folio                                                             | 0          | 1          |
| EIP:update_stack_state                                                            | 0          | 1          |
| EIP:folio_nr_pages                                                                | 0          | 1          |
| EIP:mntput                                                                        | 0          | 1          |
| BUG:sleeping_function_called_from_invalid_context_at_kernel/sched/completion.c    | 0          | 1          |
| EIP:__alloc_frozen_pages_noprof                                                   | 0          | 1          |
| EIP:unwind_get_return_address_ptr                                                 | 0          | 1          |
| EIP:copy_folio_from_iter_atomic                                                   | 0          | 1          |
| EIP:filp_flush                                                                    | 0          | 1          |
| EIP:__put_user_4                                                                  | 0          | 2          |
| EIP:balance_dirty_pages_ratelimited_flags                                         | 0          | 1          |
| EIP:zlib_updatewindow                                                             | 0          | 1          |
+-----------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511041421.784bbd5e-lkp@intel.com


[    1.392214][   T45] WARNING: bad unlock balance detected!
[    1.393285][   T45] 6.18.0-rc3-00251-gdd9e066d9677 #1 Not tainted
[    1.394579][   T45] -------------------------------------
[    1.395442][   T45] kworker/u9:1/45 is trying to release lock (rcu_read_lock) at:
[    1.396977][   T45] rcu_read_unlock (include/linux/rcupdate.h:341 include/linux/rcupdate.h:897)
[    1.398160][   T45] but there are no more locks to release!
[    1.399337][   T45]
[    1.399337][   T45] other info that might help us debug this:
[    1.399707][   T45] 5 locks held by kworker/u9:1/45:
[    1.399707][   T45]  #0: c01ad6c4 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3238)
[    1.399707][   T45]  #1: c08e9f18 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3239)
[    1.399707][   T45]  #2: c02ed27c (sb_writers#2){.+.+}-{0:0}, at: file_start_write+0x1e/0x30
[    1.399707][   T45]  #3: c042e0ec (&sb->s_type->i_mutex_key){++++}-{4:4}, at: generic_file_write_iter (mm/filemap.c:4404)
[    1.399707][   T45]  #4: eaa771a0 (lock#3){+.+.}-{3:3}, at: local_lock_acquire (include/linux/local_lock_internal.h:40)
[    1.399707][   T45]
[    1.399707][   T45] stack backtrace:
[    1.399707][   T45] CPU: 0 UID: 0 PID: 45 Comm: kworker/u9:1 Not tainted 6.18.0-rc3-00251-gdd9e066d9677 #1 PREEMPT(none)
[    1.399707][   T45] Workqueue: async async_run_entry_fn
[    1.399707][   T45] Call Trace:
[    1.399707][   T45]  dump_stack_lvl (lib/dump_stack.c:122)
[    1.399707][   T45]  ? rcu_read_unlock (include/linux/rcupdate.h:341 include/linux/rcupdate.h:897)
[    1.399707][   T45]  dump_stack (lib/dump_stack.c:130)
[    1.399707][   T45]  print_unlock_imbalance_bug (kernel/locking/lockdep.c:5300 kernel/locking/lockdep.c:5272)
[    1.399707][   T45]  ? rcu_read_unlock (include/linux/rcupdate.h:341 include/linux/rcupdate.h:897)
[    1.399707][   T45]  __lock_release+0x5e/0x150
[    1.399707][   T45]  ? rcu_read_unlock (include/linux/rcupdate.h:341 include/linux/rcupdate.h:897)
[    1.399707][   T45]  lock_release (kernel/locking/lockdep.c:470 kernel/locking/lockdep.c:5891 kernel/locking/lockdep.c:5875)
[    1.399707][   T45]  ? lru_deactivate_file (mm/swap.c:119)
[    1.399707][   T45]  rcu_read_unlock (include/linux/rcupdate.h:899)
[    1.399707][   T45]  lruvec_unlock_irqrestore (include/linux/memcontrol.h:1522)
[    1.399707][   T45]  folio_batch_move_lru (include/linux/mm.h:1501 mm/swap.c:179)
[    1.399707][   T45]  __folio_batch_add_and_move (mm/swap.c:196 (discriminator 2))
[    1.399707][   T45]  ? lru_deactivate_file (mm/swap.c:119)
[    1.399707][   T45]  folio_add_lru (mm/swap.c:514)
[    1.399707][   T45]  filemap_add_folio (mm/filemap.c:996)
[    1.399707][   T45]  __filemap_get_folio (mm/filemap.c:2023)
[    1.399707][   T45]  simple_write_begin (fs/libfs.c:932 (discriminator 1))
[    1.399707][   T45]  generic_perform_write (mm/filemap.c:4263)
[    1.399707][   T45]  __generic_file_write_iter (mm/filemap.c:4380)
[    1.399707][   T45]  generic_file_write_iter (mm/filemap.c:4406)
[    1.399707][   T45]  __kernel_write_iter (fs/read_write.c:619)
[    1.399707][   T45]  __kernel_write (fs/read_write.c:640)
[    1.399707][   T45]  kernel_write (fs/read_write.c:660 fs/read_write.c:650)
[    1.399707][   T45]  xwrite+0x27/0x80
[    1.399707][   T45]  do_copy (init/initramfs.c:417 (discriminator 1))
[    1.399707][   T45]  write_buffer (init/initramfs.c:470 (discriminator 1))
[    1.399707][   T45]  flush_buffer (init/initramfs.c:482 (discriminator 1))
[    1.399707][   T45]  __gunzip+0x21d/0x2c0
[    1.399707][   T45]  ? bunzip2 (lib/decompress_inflate.c:39)
[    1.399707][   T45]  ? __gunzip+0x2c0/0x2c0
[    1.399707][   T45]  gunzip (lib/decompress_inflate.c:208)
[    1.399707][   T45]  ? write_buffer (init/initramfs.c:476)
[    1.399707][   T45]  ? initrd_load (init/initramfs.c:64)
[    1.399707][   T45]  unpack_to_rootfs (init/initramfs.c:553)
[    1.399707][   T45]  ? write_buffer (init/initramfs.c:476)
[    1.399707][   T45]  ? initrd_load (init/initramfs.c:64)
[    1.399707][   T45]  ? reserve_initrd_mem (init/initramfs.c:719)
[    1.399707][   T45]  do_populate_rootfs (init/initramfs.c:734)
[    1.399707][   T45]  async_run_entry_fn (kernel/async.c:136 (discriminator 1))
[    1.399707][   T45]  ? async_schedule_node (kernel/async.c:118)
[    1.399707][   T45]  process_one_work (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 include/trace/events/workqueue.h:110 kernel/workqueue.c:3268)
[    1.399707][   T45]  process_scheduled_works (kernel/workqueue.c:3346)
[    1.399707][   T45]  worker_thread (include/linux/list.h:381 (discriminator 2) kernel/workqueue.c:952 (discriminator 2) kernel/workqueue.c:3428 (discriminator 2))
[    1.399707][   T45]  kthread (kernel/kthread.c:465)
[    1.399707][   T45]  ? process_scheduled_works (kernel/workqueue.c:3373)
[    1.399707][   T45]  ? kthread_is_per_cpu (kernel/kthread.c:412)
[    1.399707][   T45]  ret_from_fork (arch/x86/kernel/process.c:164)
[    1.399707][   T45]  ? kthread_is_per_cpu (kernel/kthread.c:412)
[    1.399707][   T45]  ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[    1.399707][   T45]  entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[    1.467118][   T32] Callback from call_rcu_tasks() invoked.
[    1.468370][   T45] ------------[ cut here ]------------
[    1.469508][   T45] WARNING: CPU: 0 PID: 45 at kernel/rcu/tree_plugin.h:443 __rcu_read_unlock (kernel/rcu/tree_plugin.h:443)
[    1.471711][   T45] Modules linked in:
[    1.472490][   T45] CPU: 0 UID: 0 PID: 45 Comm: kworker/u9:1 Not tainted 6.18.0-rc3-00251-gdd9e066d9677 #1 PREEMPT(none)
[    1.474777][   T45] Workqueue: async async_run_entry_fn
[    1.475823][   T45] EIP: __rcu_read_unlock (kernel/rcu/tree_plugin.h:443)
[    1.476872][   T45] Code: 0c d0 56 c2 ff 8b a4 02 00 00 75 11 8b 83 a8 02 00 00 85 c0 74 07 89 d8 e8 7c fe ff ff 8b 83 a4 02 00 00 3d ff ff ff 3f 76 02 <0f> 0b 5b 5d 31 c0 c3 2e 8d b4 26 00 00 00 00 55 89 e5 57 56 89 c6
All code
========
   0:	0c d0                	or     $0xd0,%al
   2:	56                   	push   %rsi
   3:	c2 ff 8b             	ret    $0x8bff
   6:	a4                   	movsb  %ds:(%rsi),%es:(%rdi)
   7:	02 00                	add    (%rax),%al
   9:	00 75 11             	add    %dh,0x11(%rbp)
   c:	8b 83 a8 02 00 00    	mov    0x2a8(%rbx),%eax
  12:	85 c0                	test   %eax,%eax
  14:	74 07                	je     0x1d
  16:	89 d8                	mov    %ebx,%eax
  18:	e8 7c fe ff ff       	call   0xfffffffffffffe99
  1d:	8b 83 a4 02 00 00    	mov    0x2a4(%rbx),%eax
  23:	3d ff ff ff 3f       	cmp    $0x3fffffff,%eax
  28:	76 02                	jbe    0x2c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	5b                   	pop    %rbx
  2d:	5d                   	pop    %rbp
  2e:	31 c0                	xor    %eax,%eax
  30:	c3                   	ret
  31:	2e 8d b4 26 00 00 00 	cs lea 0x0(%rsi,%riz,1),%esi
  38:	00 
  39:	55                   	push   %rbp
  3a:	89 e5                	mov    %esp,%ebp
  3c:	57                   	push   %rdi
  3d:	56                   	push   %rsi
  3e:	89 c6                	mov    %eax,%esi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	5b                   	pop    %rbx
   3:	5d                   	pop    %rbp
   4:	31 c0                	xor    %eax,%eax
   6:	c3                   	ret
   7:	2e 8d b4 26 00 00 00 	cs lea 0x0(%rsi,%riz,1),%esi
   e:	00 
   f:	55                   	push   %rbp
  10:	89 e5                	mov    %esp,%ebp
  12:	57                   	push   %rdi
  13:	56                   	push   %rsi
  14:	89 c6                	mov    %eax,%esi
[    1.480862][   T45] EAX: ffffffff EBX: c0bfd640 ECX: 00000000 EDX: 00000000
[    1.482292][   T45] ESI: eaa771c0 EDI: c119e160 EBP: c08e9c0c ESP: c08e9c08
[    1.483721][   T45] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
[    1.485350][   T45] CR0: 80050033 CR2: ffbff000 CR3: 026c6000 CR4: 000006f0
[    1.486725][   T45] Call Trace:
[    1.487465][   T45]  rcu_read_unlock (include/linux/rcupdate.h:900)
[    1.488404][   T45]  lruvec_unlock_irqrestore (include/linux/memcontrol.h:1522)
[    1.489570][   T45]  folio_batch_move_lru (include/linux/mm.h:1501 mm/swap.c:179)
[    1.491100][   T45]  __folio_batch_add_and_move (mm/swap.c:196 (discriminator 2))
[    1.492318][   T45]  ? lru_deactivate_file (mm/swap.c:119)
[    1.493827][   T45]  folio_add_lru (mm/swap.c:514)
[    1.494817][   T45]  filemap_add_folio (mm/filemap.c:996)
[    1.495891][   T45]  __filemap_get_folio (mm/filemap.c:2023)
[    1.497735][   T45]  simple_write_begin (fs/libfs.c:932 (discriminator 1))
[    1.498813][   T45]  generic_perform_write (mm/filemap.c:4263)
[    1.500292][   T45]  __generic_file_write_iter (mm/filemap.c:4380)
[    1.501552][   T45]  generic_file_write_iter (mm/filemap.c:4406)
[    1.502790][   T45]  __kernel_write_iter (fs/read_write.c:619)
[    1.504090][   T45]  __kernel_write (fs/read_write.c:640)
[    1.505377][   T45]  kernel_write (fs/read_write.c:660 fs/read_write.c:650)
[    1.506306][   T45]  xwrite+0x27/0x80
[    1.507429][   T45]  do_copy (init/initramfs.c:417 (discriminator 1))
[    1.508361][   T45]  write_buffer (init/initramfs.c:470 (discriminator 1))
[    1.509300][   T45]  flush_buffer (init/initramfs.c:482 (discriminator 1))
[    1.510307][   T45]  __gunzip+0x21d/0x2c0
[    1.511424][   T45]  ? bunzip2 (lib/decompress_inflate.c:39)
[    1.512312][   T45]  ? __gunzip+0x2c0/0x2c0
[    1.513515][   T45]  gunzip (lib/decompress_inflate.c:208)
[    1.514359][   T45]  ? write_buffer (init/initramfs.c:476)
[    1.515304][   T45]  ? initrd_load (init/initramfs.c:64)
[    1.516217][   T45]  unpack_to_rootfs (init/initramfs.c:553)
[    1.517220][   T45]  ? write_buffer (init/initramfs.c:476)
[    1.518175][   T45]  ? initrd_load (init/initramfs.c:64)
[    1.519172][   T45]  ? reserve_initrd_mem (init/initramfs.c:719)
[    1.520375][   T45]  do_populate_rootfs (init/initramfs.c:734)
[    1.521401][   T45]  async_run_entry_fn (kernel/async.c:136 (discriminator 1))
[    1.522378][   T45]  ? async_schedule_node (kernel/async.c:118)
[    1.523492][   T45]  process_one_work (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 include/trace/events/workqueue.h:110 kernel/workqueue.c:3268)
[    1.526446][   T45]  process_scheduled_works (kernel/workqueue.c:3346)
[    1.527578][   T45]  worker_thread (include/linux/list.h:381 (discriminator 2) kernel/workqueue.c:952 (discriminator 2) kernel/workqueue.c:3428 (discriminator 2))
[    1.528573][   T45]  kthread (kernel/kthread.c:465)
[    1.529483][   T45]  ? process_scheduled_works (kernel/workqueue.c:3373)
[    1.530780][   T45]  ? kthread_is_per_cpu (kernel/kthread.c:412)
[    1.531779][   T45]  ret_from_fork (arch/x86/kernel/process.c:164)
[    1.532664][   T45]  ? kthread_is_per_cpu (kernel/kthread.c:412)
[    1.533736][   T45]  ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[    1.534846][   T45]  entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[    1.536182][   T45] irq event stamp: 2161
[    1.536994][   T45] hardirqs last  enabled at (2161): _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
[    1.538763][   T45] hardirqs last disabled at (2160): _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:109 kernel/locking/spinlock.c:162)
[    1.540674][   T45] softirqs last  enabled at (1956): handle_softirqs (kernel/softirq.c:469 (discriminator 2) kernel/softirq.c:650 (discriminator 2))
[    1.542454][   T45] softirqs last disabled at (1949): __do_softirq (kernel/softirq.c:657)
[    1.544105][   T45] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251104/202511041421.784bbd5e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


