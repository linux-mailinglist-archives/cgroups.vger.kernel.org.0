Return-Path: <cgroups+bounces-4031-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B097594291A
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 10:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C511C20F39
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 08:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E9F1A7F95;
	Wed, 31 Jul 2024 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKYb1eU1"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618D1A6166
	for <cgroups@vger.kernel.org>; Wed, 31 Jul 2024 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414357; cv=fail; b=D7v3pfSlGovmrQdl6MxpcAtbMOvx8E+rUJQTpesagJXAw2hWftG9FYUCAqWyxdlVYcptrDHJesQLzPWpfkuVsRm2lc8XAusw/oRSQQDOIG6EZc4XC2w9pa+XxNsBQNpCnuvqZDqDzDE3HVTc4B35WTGPEjMNBVJchJqnc1+UPSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414357; c=relaxed/simple;
	bh=ScWyxCRpBgJ0pvyUdJPD6CGw4J7BWp2wAElIY41vkJs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=I83oVDvsT7cocxOXyt+Qgd7WQgC01gaKoCVh6YFF0UO4n3y/hk84IrzxsjfeevEUOMKA63FlBBIAVZqOsYrQUvT0ywA62T4KvFsc4ZBx7+0LkrAqENEmR4QCErrbc0Dwm4BclR/2GJby2Wj/0e9M7a0hGMhz8Mex4KSJcePhgWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKYb1eU1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722414354; x=1753950354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ScWyxCRpBgJ0pvyUdJPD6CGw4J7BWp2wAElIY41vkJs=;
  b=jKYb1eU1YPRoGavE9tTfrkfpKRafYquCEL8czRcyl264SLOEpEfQUcUP
   wv3Vt5UlAmDRv3jWjPir1A0vsmSL5TIGJzlDqFojakf5epUOFLErWvKSx
   F2OwZBVXBO1RhHOJQ6aYP09wNEs9iW/Q+vns6LPL5oYJbtkcI7CQDid7y
   D2VlMRCoPdxQqPhs5hv97s+CaWoeiP/ilIXq/4FbeQMmZlAmCIggubZUb
   QhGsglRglDLANVRJOfhfscUqHVg9jE0sdkibQ7fYAFeY/Ga30KhlRJDS4
   gVij3CzvKgHeTItiX0jO2TpxI5AGBd/pbuS93OGCe3yAm1FSBVq3vSQIY
   g==;
X-CSE-ConnectionGUID: eONfWSTuRqStIVTkKXh0Bg==
X-CSE-MsgGUID: rmjEywZ1Tealuq4Re9hOcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20160442"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20160442"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 01:25:53 -0700
X-CSE-ConnectionGUID: LPZUm3t+R4O+L//PMmf5gg==
X-CSE-MsgGUID: pOjyBQcTRCi4KRwSXFSN+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54299339"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 01:25:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 01:25:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 01:25:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 01:25:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUkzkDoIbozPvKXk4GBJMGrHNX4K6tkDwi06TIPMB0rkMvJS7mAv/heAJnzjmIGcOi49NwgVjIf2jp9na8n+O9ycyZxW9rJrOjKcbxxFHqaqDB719CvBEQyykF7q5vMn57NHLDlS3oI4/H9DtvDrKhMDPKcZdqvVNvpYF0LggHzMnyYBSyO+wsO6aWKzm+SpxJVRF9iFE14zJRQaRxfgIx6b41JIj2cuXbPLKJuK9seAX2I6dPsYOR9k/tfpLrELiWBOzJYF1mxVBR0qXA9UkmQ2bwluvXBjb12oU2yOZsSMkqJhT+umy81pTGilEt2CzeT14FQJkGMUNvSgFiM1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLHckToP4BHXIebK/mZsZR6hIcZUA1BRlwEHGCfig7o=;
 b=F768S3cRRuIBNuex4lpLKFrl70wpYbdaejlEpIeyKvX1g/OMPXv0WxedEHu4CH3+W30aDSUnrnhex9ZAUm0iEwiHSNv0SvfhKT5swr54229uHnOl3xG4OOw1Gcj4h70D/GF5A4ma1IOrOy4VZ7w25viMqjb6WgJRxWXAu13w+54fadh0TVSVFU82kXdeRhx/OzneQUqz1gjp5nVEsS0ZSGALM1ijAvVQ2YQII9f6wgJIVm5z3iaKsU+39nMTdj0Qu974dIZkA3Njl63Cu+DocbWLFE+P5pbR96YtIGVtqrUxItt5DX/c8gjhjDl2dFTVeMXybW/++J7WcAACkCmIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8543.namprd11.prod.outlook.com (2603:10b6:806:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 08:25:49 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 08:25:49 +0000
Date: Wed, 31 Jul 2024 16:25:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Muchun Song <songmuchun@bytedance.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt
	<shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>,
	"Johannes Weiner" <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	<cgroups@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [mm]  230b2f1f31:
 WARNING:at_include/linux/memcontrol.h:#mem_cgroup_from_slab_obj
Message-ID: <202407311639.4cc7f719-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGAP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::25)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 31036852-50a5-4262-fd96-08dcb13a6263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NnVx3idGL/OxZ+z04pCL2tqb4TPAlzRrbVAepHg0fQtupWfhQ6ypjO8bdwf/?=
 =?us-ascii?Q?kpU5pCLBb8DAjydU4HHKNRGqQLdqYp9RQyS2uBO900tVnOzzMoR8em6v14X3?=
 =?us-ascii?Q?WCS0UrIAziZA3lSmHaHp2whemYwLFhdMDVMOAwymEYehgQaUhcEskD7nndq2?=
 =?us-ascii?Q?HmiDdTgHW8pNP9tC2qD52AnLdNBL54jeHkGV8T7EGca2KP40ZcrMRzn3M+/I?=
 =?us-ascii?Q?VVsCl1gakkCtMOROpLp/kp2IzDFp1qSLCDkrODGzUL64i3qhrGkgiCpzZ6pK?=
 =?us-ascii?Q?/ntmAkWiwmW7f6yP47hSID0XNWCz4SXhB6IJR3sD4I02/B0LIfkFkfmjz+7Y?=
 =?us-ascii?Q?Vr7XDh5eYJgDG9AJTgamSVAhuf46nh1MozRFSF25yh5qESQMZabLO9WTi+Ay?=
 =?us-ascii?Q?uqG5rzJgW568dUSIGVvevw4K2d7MUe0I8HkhGJ6tIOyLJAGn/lkzJHcmHxrG?=
 =?us-ascii?Q?ekgQSliaLn8J12dvmyTcis1KD+IaiO88i4vgrMOJthkQ2wMvSXkZmkuCeWxD?=
 =?us-ascii?Q?TCoPEqCquNSDGq2NhLTj6YcBJRiEmpHAuGMc3bRnQRiK0TersGQolaGwuNxO?=
 =?us-ascii?Q?1R9GHAI1fQIQyUaxPkuZDLGE1hRF+Ipi2hZoljjNcpnyoV9NPqBpdbvR/CpW?=
 =?us-ascii?Q?T3J0s4Lk82VKQjBATTe81LUK5p/Fvao9Xa7EDB9smpkLNJQsTdwFAJmDIFm3?=
 =?us-ascii?Q?unQu9jjtieI7HVNDAqRwE5IFy2igpr79ObJijif/i8hQu+3PkL3aHjexaUv1?=
 =?us-ascii?Q?sfJh1sH4av+AcPMX8HFWN+aBC5zBxo5hvlVDSBnLGsvKhhKomux3Q+JITQGa?=
 =?us-ascii?Q?qit19NV+PKjDFbtsMkQEwHacIhQMjoUeFVvt9y7k19lGADdQnOuTZzc03/q3?=
 =?us-ascii?Q?kGp0v+8pKhghY3QIVRqLwkgXjPI3+dB6QY09IDL2VrnyFk7esqMPHh5++muw?=
 =?us-ascii?Q?qacwe/rP2WU+2yk2DDFyXZdySPQ4Goh44thwedcIXeHk2ODq03GN4MLWInBI?=
 =?us-ascii?Q?aOn1UdNabpKRmXQVZTDjyZHm4TLzPaP/VAj2IiCk3du/CbolQsl9cpzmU8SI?=
 =?us-ascii?Q?2KRPqXOkPUlqcCLZ3cZTtVWTJsbvYYi9uRMbQ29rbOYqqYdjcRSyKEuMzN0y?=
 =?us-ascii?Q?4MDjZqwEsVClmRcUedEDyZbW4SAL7MvRlnJWAHzrNPwQobz+mQtpC6C1g6M/?=
 =?us-ascii?Q?2mcIXs2WGkIhD0+R5jOsPgNaSGMZn1ZbRj1SU2epWZ5X5JXvpTw4X7PP2Fwl?=
 =?us-ascii?Q?fcw10EYSrGAs8W/pZJ9CVPAqrSPOmAZOHvb2QptrFocJ7GhHE4NSus7UaJC3?=
 =?us-ascii?Q?XRGYMECySNv4V8MrnfcetpQd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U77gOYWGphtykhQjVp/ibaZSwk54SufYR4Hi95TJWvb4wWDrnaAlchEnLecS?=
 =?us-ascii?Q?Y3YSKLzj7uXjNpHXnn+ZgYiqlHoixRyhDUoKoXr/HVxzqqLLCs9gPRGGthn/?=
 =?us-ascii?Q?8F9DBLlniKKhpiT+yQTMDPTjqv7Ocr2pcERgfhybz53mQAcbWcwGlF/gmhq+?=
 =?us-ascii?Q?HBBG+Slz/dagoDOftRIm5uRBIzoNcGmPyvU1N6n6Lr9do7hWcA6eQp+S2YFg?=
 =?us-ascii?Q?PdZHTvexc6goWj7TiVEiH6+Fm8+Go8pte2YqaOuOEYQT2TxHY3yaFyuWuG/s?=
 =?us-ascii?Q?vCx/eNqkelYFQXKLXc8Gct7ccLXt5fmFQDti/ZIVecKEn9bQK1KoNc9Fdiud?=
 =?us-ascii?Q?1ButWAjLdtSLPj4sVeUU0FIa8eo8IbRnTlbbP1H7dX4OklYRQgzNSFB0jcJv?=
 =?us-ascii?Q?GwPtl1eK/GGeQRDDVqTTpwL/YhVW9W59O9rOegyRCcFEyvOLT7Uz+RrVoeL7?=
 =?us-ascii?Q?3YnyWgrskwfyIH360wYuvSV4jcBmR4x/gOwMu710hX95XoUSrI991zhD+25+?=
 =?us-ascii?Q?Tr+hwr9IOasJypwcVnto/wQtahn8bQEBwL/BvBlU0vYCcQlW78+cl8qrggyV?=
 =?us-ascii?Q?GhsiDd4HZNUFbmjR/Ksj/7gCk7suN9YvmaudbbCn0mG/p8xo2hHnJrHaN8xT?=
 =?us-ascii?Q?eubeJT7Mi0cqhxOA3L9SBGOIv8wlzc0fNAjdtPfSGtcbHOp2LGojcx3mZdyh?=
 =?us-ascii?Q?nqHBUAarDaFLLoUsP9Oo7G5S4ftj+26BgpvGqLMccv6yskC3XBxgWKK6LuqE?=
 =?us-ascii?Q?ERDbzBttCOamHJaGpRQyHfP1i9Z8FfQxO4YtjphKZsWP2zBw00PAR36um4ku?=
 =?us-ascii?Q?+xKrkz5R6czep9Gu4ieyFMGf4+8RLZZl7C++W1ZsG8a93Hw7tEbW59TlBLvt?=
 =?us-ascii?Q?tv952PyOuTDzz2QuE6bvc5zHMGRWsb3RFUGtaIVz75c//PIV85jsxPfRvkmf?=
 =?us-ascii?Q?c/m1J+v/rulaHBDOMM+RQW8c7AYwhiODmKjOZhl1xJm82J5Ndynpcy7ihB/b?=
 =?us-ascii?Q?65OeXHbnh5JYvdbX3adFm5b+PtcbxN7AxserXdhBt/mzZEJwL6dbz4b2C56P?=
 =?us-ascii?Q?ijJsEmdJFSZH6XN3lQ7Vff7otM8T2qGD5N3M+COQilP+mQBWu8EDK7i0iUC3?=
 =?us-ascii?Q?6bSiUuCVC6DDaUKwC2MkxkABPSN/2ndexkHDe1Ts3rZeebE2PxRTbdBwiU3V?=
 =?us-ascii?Q?fIXGUBBBfqM8JDp5lduraZ3Rq70+u59GBBDDX5YjFRvm06aKZhwrNaXfJDul?=
 =?us-ascii?Q?KCe3zTkbdX1hKGu20laTokFB24JP85uxeho33hY1EYAaSxwc13Mt3QSy181I?=
 =?us-ascii?Q?wxIad+xKhncYgUMY5ZAvEkmdBQa7F3Ol69HI6B3JdofqtVy6KwqCN45+g3Nv?=
 =?us-ascii?Q?0jrbBX6khWAQWwAgvTo/KzLOq0zkavF6z+cdEedz4raol0is8IPNQ3c9gSqP?=
 =?us-ascii?Q?LXya49l7CMWv8qhM0FuwxLvE1uVUBqsezPHtoDL+p73vWbDAMZHWBV0bMVSE?=
 =?us-ascii?Q?ehMO/C4GL8s+PGD1cyaG5UmIdT2YCyHacxi0ur2Yms2BSOQaiAbIsjze916b?=
 =?us-ascii?Q?KMznvQ3ChjwawJjIe7+hluI9P3CRnaDCaXnSvypVaYiMGBAWabfYOrzB/JJn?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31036852-50a5-4262-fd96-08dcb13a6263
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:25:49.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZOQACaivJc4THPlyTWdN1J8afqBkzx2l3o6lofUFdWS//mbcdjd1jXHXJ90v/tf2/Y1RV5e1u4s4vunOvYvWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8543
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_include/linux/memcontrol.h:#mem_cgroup_from_slab_obj" on:

commit: 230b2f1f31b978958ba3c50f5bc3f04fc7abb8cd ("mm: kmem: add lockdep assertion to obj_cgroup_memcg")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master cd19ac2f903276b820f5d0d89de0c896c27036ed]

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------+------------+------------+
|                                                                 | bfe1f729fa | 230b2f1f31 |
+-----------------------------------------------------------------+------------+------------+
| WARNING:at_include/linux/memcontrol.h:#mem_cgroup_from_slab_obj | 0          | 6          |
| RIP:mem_cgroup_from_slab_obj                                    | 0          | 6          |
+-----------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407311639.4cc7f719-oliver.sang@intel.com


[   28.951470][    T1] ------------[ cut here ]------------
[ 28.952578][ T1] WARNING: CPU: 0 PID: 1 at include/linux/memcontrol.h:373 mem_cgroup_from_slab_obj (include/linux/memcontrol.h:373 mm/memcontrol.c:2440 mm/memcontrol.c:2469) 
[   28.954150][    T1] Modules linked in:
[   28.954834][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Tainted: G                T  6.10.0-12994-g230b2f1f31b9 #1
[   28.956386][    T1] Tainted: [T]=RANDSTRUCT
[   28.957111][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 28.958700][ T1] RIP: 0010:mem_cgroup_from_slab_obj (include/linux/memcontrol.h:373 mm/memcontrol.c:2440 mm/memcontrol.c:2469) 
[ 28.959692][ T1] Code: 00 0f 84 96 00 00 00 e8 c7 6c ba ff 85 c0 0f 85 89 00 00 00 48 c7 c7 c8 38 b6 86 be ff ff ff ff e8 ae 6e e0 02 85 c0 75 74 90 <0f> 0b 90 eb 6e 49 83 c6 38 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74
All code
========
   0:	00 0f                	add    %cl,(%rdi)
   2:	84 96 00 00 00 e8    	test   %dl,-0x18000000(%rsi)
   8:	c7                   	(bad)  
   9:	6c                   	insb   (%dx),%es:(%rdi)
   a:	ba ff 85 c0 0f       	mov    $0xfc085ff,%edx
   f:	85 89 00 00 00 48    	test   %ecx,0x48000000(%rcx)
  15:	c7 c7 c8 38 b6 86    	mov    $0x86b638c8,%edi
  1b:	be ff ff ff ff       	mov    $0xffffffff,%esi
  20:	e8 ae 6e e0 02       	callq  0x2e06ed3
  25:	85 c0                	test   %eax,%eax
  27:	75 74                	jne    0x9d
  29:	90                   	nop
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	90                   	nop
  2d:	eb 6e                	jmp    0x9d
  2f:	49 83 c6 38          	add    $0x38,%r14
  33:	4c 89 f0             	mov    %r14,%rax
  36:	48 c1 e8 03          	shr    $0x3,%rax
  3a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  3f:	74                   	.byte 0x74

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	90                   	nop
   3:	eb 6e                	jmp    0x73
   5:	49 83 c6 38          	add    $0x38,%r14
   9:	4c 89 f0             	mov    %r14,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  15:	74                   	.byte 0x74
[   28.962395][    T1] RSP: 0018:ffff888101aa7958 EFLAGS: 00010246
[   28.963315][    T1] RAX: 0000000000000000 RBX: ffff8881599d9680 RCX: ffff8881012d8000
[   28.964489][    T1] RDX: dffffc0000000000 RSI: ffffffff86b638c8 RDI: ffff8881012d9578
[   28.965626][    T1] RBP: 00000000000001bb R08: ffffffff88b2662f R09: 1ffffffff1164cc5
[   28.966839][    T1] R10: dffffc0000000000 R11: fffffbfff1164cc6 R12: dffffc0000000000
[   28.968142][    T1] R13: ffff8881599ed080 R14: 0000000000000008 R15: 0000000000000801
[   28.969425][    T1] FS:  00007f7d28623940(0000) GS:ffffffff864cc000(0000) knlGS:0000000000000000
[   28.970782][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.971768][    T1] CR2: 00007f7d29447fb0 CR3: 000000015583a000 CR4: 00000000000406f0
[   28.973094][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   28.974386][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   28.975693][    T1] Call Trace:
[   28.976303][    T1]  <TASK>
[ 28.976878][ T1] ? __warn (kernel/panic.c:735) 
[ 28.977572][ T1] ? mem_cgroup_from_slab_obj (include/linux/memcontrol.h:373 mm/memcontrol.c:2440 mm/memcontrol.c:2469) 
[ 28.978575][ T1] ? report_bug (lib/bug.c:? lib/bug.c:219) 
[ 28.979355][ T1] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 28.980099][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
[ 28.980897][ T1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 28.981686][ T1] ? mem_cgroup_from_slab_obj (include/linux/memcontrol.h:373 mm/memcontrol.c:2440 mm/memcontrol.c:2469) 
[ 28.982597][ T1] ? mem_cgroup_from_slab_obj (include/linux/memcontrol.h:373 mm/memcontrol.c:2440 mm/memcontrol.c:2469) 
[ 28.983537][ T1] list_lru_del_obj (mm/list_lru.c:144) 
[ 28.984379][ T1] d_lru_del (fs/dcache.c:448) 
[ 28.985113][ T1] ? dput (include/linux/rcupdate.h:326 include/linux/rcupdate.h:838 fs/dcache.c:845) 
[ 28.985820][ T1] __dentry_kill (include/linux/list_bl.h:54 include/linux/dcache.h:354 fs/dcache.c:514 fs/dcache.c:608) 
[ 28.986603][ T1] ? dput (include/linux/rcupdate.h:326 include/linux/rcupdate.h:838 fs/dcache.c:845) 
[ 28.987295][ T1] dput (fs/dcache.c:853) 
[ 28.987981][ T1] lookup_fast (fs/namei.c:1685) 
[ 28.988813][ T1] walk_component (fs/namei.c:2035) 
[ 28.989617][ T1] path_lookupat (fs/namei.c:2542 fs/namei.c:2566) 
[ 28.990445][ T1] filename_lookup (fs/namei.c:2595) 
[ 28.991317][ T1] user_path_at (fs/namei.c:3002) 
[ 28.992100][ T1] __se_sys_name_to_handle_at (fs/fhandle.c:110 fs/fhandle.c:94) 
[ 28.993021][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:466 kernel/locking/lockdep.c:4359) 
[ 28.994034][ T1] do_syscall_64 (arch/x86/entry/common.c:?) 
[ 28.994856][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:466 kernel/locking/lockdep.c:4359) 
[ 28.995771][ T1] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 28.996278][ T1] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 28.996768][ T1] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 28.997262][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:466 kernel/locking/lockdep.c:4359) 
[ 28.997857][ T1] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 28.998355][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:466 kernel/locking/lockdep.c:4359) 
[ 28.998981][ T1] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 28.999494][ T1] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 28.999985][ T1] ? exc_page_fault (arch/x86/mm/fault.c:1543) 
[ 29.000460][ T1] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   29.001018][    T1] RIP: 0033:0x7f7d2919709a
[ 29.001463][ T1] Code: 48 8b 0d 69 7d 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 2f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 36 7d 0c 00 f7 d8 64 89 01 48
All code
========
   0:	48 8b 0d 69 7d 0c 00 	mov    0xc7d69(%rip),%rcx        # 0xc7d70
   7:	f7 d8                	neg    %eax
   9:	64 89 01             	mov    %eax,%fs:(%rcx)
   c:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  10:	c3                   	retq   
  11:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  18:	00 00 00 
  1b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  20:	49 89 ca             	mov    %rcx,%r10
  23:	b8 2f 01 00 00       	mov    $0x12f,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 36 7d 0c 00 	mov    0xc7d36(%rip),%rcx        # 0xc7d70
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 36 7d 0c 00 	mov    0xc7d36(%rip),%rcx        # 0xc7d46
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240731/202407311639.4cc7f719-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


