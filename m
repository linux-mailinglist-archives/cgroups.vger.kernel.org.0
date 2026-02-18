Return-Path: <cgroups+bounces-13991-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 19fwCzw/lWnBNgIAu9opvQ
	(envelope-from <cgroups+bounces-13991-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 05:25:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F73152F96
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 05:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5FA2300680A
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 04:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032B22F60A3;
	Wed, 18 Feb 2026 04:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkAmH6Lc"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F523ABA9;
	Wed, 18 Feb 2026 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771388726; cv=fail; b=IfAblVbWo2HXYtvnzj3ngFUtJdVscHSdYXo6zUhSvNN+vEshLBtDRvDJkg34Vqlq+KjwlZUvs2C3SvS5KoTMaKj5D7LUFqR/Ji/TH/n1RGMIi7f97EK6uYMIzwOvCgBfPFxdowO/tW8sH6mmot4HPd0EU9cPvqSEmFo49v4w20s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771388726; c=relaxed/simple;
	bh=U3jUGpIaItM+I8hFETjUfr3HI38irQ9bQaC2rvU5Gh8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LVs1rMf0DQODfUXhwvydgekGU7ov/Ng5td5OW4qNhOICnuQ56v3/lbKrPCBxWvcNK/NxbL7eIKUFBeN7xXsMqRRI+NtsE1MnvA0VWvuK2iKmJ76RW1cDQ8xipu1PZWvcaquStPG5XxLZ6LiunmAkPIM6G3ryxpT7QcteEbqBcM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkAmH6Lc; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771388725; x=1802924725;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=U3jUGpIaItM+I8hFETjUfr3HI38irQ9bQaC2rvU5Gh8=;
  b=kkAmH6LcO0His54xhVj4JEMvXFJaCrcNuZaB3RQ+J0dmMWC6siRoXrmP
   ST0SUh+ix6k3r1PZNPbsxEsTI54GaG6asufNmrGu/UR64ykWZ9ujzXyRx
   c60LMrvH9TvG+pnKxT7nCOGWegHNrqP5Dl355CcAT8biAYJeyS1qUBef4
   AIA+ueWrKgMDtgFSWMaUZEVk2t8R5dzc/JGlFGETK5rAHKwqfA10+KKow
   gXqcClXIgcuNtaE25CDXfQ8X7MB8V2d21HOweKMu+8l7vCJgTva2xY2HD
   sp9qBXDjVp2WuzqMMiP42eqsIL0d4Ygo4IP+38c1F0Xox3ob17z8EqUqx
   Q==;
X-CSE-ConnectionGUID: cQ1+rV3PR62DAl/TChTNCg==
X-CSE-MsgGUID: WSbbPM+FRTilO3wBHTFWGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="76302946"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="76302946"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 20:25:24 -0800
X-CSE-ConnectionGUID: gNrBv2xaRdiZMxKmNMHAeQ==
X-CSE-MsgGUID: 286qILBDQV6QWqtHEXHjYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="237093631"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 20:25:23 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 20:25:23 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 20:25:23 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 20:25:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6Kv5k526ZOqoHlxVGNhEeX5COMvJ9npbGLVpBBBRHD9reDZMPPTbKwwVBkY5D8ixUEvbpn98ucdIjHRLcZHTY5gNvWmoTCbAZGyjziYyJZ/79IvdkoUmqPI2VBFPdqJ0BrJsqfE/Oye/E7M/axxNW/2BaYLXb7Q5/++glDN+3ho8maUGJ7pV+GwKX0IcrnyFS+tqxDkL2pHmcz+5wMyhYf4yMBE2ce8hsY6gWrMP1jApMgy6T92TcTCVGJczOaHrv5e6morYMxs3pLofUZx6RREHu+VMxUAM3d6BZYDO2S8l9pKhnrmOKAk6M4bxynNKxQRSW0QSGwYSesO37WIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqgoXxNaqWEonxMBlyzt9tHuxmIuHprL2lN58Ta9pRs=;
 b=hAmIy1xKKsjouC+74yrBOFu6j/0dx1B4pa7PrhyrBThqk2aucr75yZZMnEn+a0YJvq8SfJNdvgm4n+7HvJGY9w1C+weZRkWL9cfZIeJLOK4BOOwytLc2BKMhJgaRT2sxLk7WoBDNm+rkLee6owVfrFiNRtnEVwhoB7DJjBABlMUBDv9meAUky1rGa0FSj45EVyPZZEsmOHO7mXrjQU2ZnN+BCDN/wL80hi8Ys/UrVrTyDN7whgttRlnfG8YYo+eFiAcTtRKhxUQrxgiLQ9BwFC6X5EG6ixK0kqRWoamvVB6fOb9Xy26ACBaxDHmfmrI13sOJNMGoow7SH3422ifLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4671.namprd11.prod.outlook.com (2603:10b6:806:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 04:25:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 04:25:19 +0000
Date: Wed, 18 Feb 2026 12:25:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: JP Kobryn <inwardvessel@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Johannes Weiner
	<hannes@cmpxchg.org>, <linux-mm@kvack.org>, <apopple@nvidia.com>,
	<akpm@linux-foundation.org>, <axelrasmussen@google.com>, <byungchul@sk.com>,
	<cgroups@vger.kernel.org>, <david@kernel.org>, <eperezma@redhat.com>,
	<gourry@gourry.net>, <jasowang@redhat.com>, <joshua.hahnjy@gmail.com>,
	<Liam.Howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<lorenzo.stoakes@oracle.com>, <matthew.brost@intel.com>, <mst@redhat.com>,
	<mhocko@suse.com>, <rppt@kernel.org>, <muchun.song@linux.dev>,
	<zhengqi.arch@bytedance.com>, <rakie.kim@sk.com>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <surenb@google.com>,
	<virtualization@lists.linux.dev>, <vbabka@suse.cz>, <weixugc@google.com>,
	<xuanzhuo@linux.alibaba.com>, <ying.huang@linux.alibaba.com>,
	<yuanchu@google.com>, <ziy@nvidia.com>, <kernel-team@meta.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
Message-ID: <202602181136.f66ba888-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260212045109.255391-2-inwardvessel@gmail.com>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4671:EE_
X-MS-Office365-Filtering-Correlation-Id: 52573a7f-fcd9-4d59-9c12-08de6ea5b965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?REp5/JhPU77INSQ4/YmYkkvbYDuh0aCdOioJojazNdwD32x9Eoh6FVJbim21?=
 =?us-ascii?Q?sYT+aUwoperJSgCP90A36sU8PXtkQYkIK7aW7yWnfGIStbViaD9Hg3yA5yE0?=
 =?us-ascii?Q?YPC+mSLuIhyz8Ibc0rd2ICdhXRrqi7Zs0kqze+o/PgCWbacsTVIYDI1j7g89?=
 =?us-ascii?Q?Fk4QA8sCzgco6B11G2pzyztzH0nG29sk7y012roz3ha/tPa1h9PMHG9nyBgK?=
 =?us-ascii?Q?RVLxdcFJ9xT31HmatV5Z5sUtj0SuQS3k4s6KQ4pDU3SZWs+w/p0fJc5R5KEi?=
 =?us-ascii?Q?3GYSQJzJfq7SCnx1ZhQaG1z95NsK28loTdOrS6WNtuR/5lGMtAq6PmqAhBcF?=
 =?us-ascii?Q?eNLhlXoO+Gx2hOThScnxb7u94XfLsgPOe4+q0q7YRWP49D8v99yqBNxImBPr?=
 =?us-ascii?Q?g9d3x1Tms4Yb3doTqKTvB64TYugchWfd29I/7i/Tx08uus4qF2MuKjSDSNjI?=
 =?us-ascii?Q?ucpGAlcgGly0JZuNuCDRpjLK5m/rtc5ZL837vbQ13aToHnw8vH00zH9uNwcZ?=
 =?us-ascii?Q?4opkYPT2BIjjzq6m0GjqPf8rCzLjwzC/kZV9r4H694GVX4MBG1W8T7UuH0Nl?=
 =?us-ascii?Q?IGjDyEL3TbGVeqlcyCAgvvWwv16yPVRHwvxfF/RWrf0kUisD46brcJ2PZuvO?=
 =?us-ascii?Q?yKYXUGmSUcWpWUIgU0dHN4Mw0SmFqVrUckc9CIo9UaOO7NabXNqWuy1jDgHL?=
 =?us-ascii?Q?iRB9R68i3qUSI2Yn2N0IatodnKxBlNl1HYmTQyp+PgPvYWZlbsx7WHMtYDpj?=
 =?us-ascii?Q?R833DwM/8PxzsQ0FQJlr0yafp9Sk8D5sEcphJvQXh9J/kFI7M5TEKzzIXFTC?=
 =?us-ascii?Q?g9Qzp6KsfNcdEgpg35OnUAFkeJR9XjAk+wo5BdX9ofoONb1TbYDNZJXiZG/H?=
 =?us-ascii?Q?MqXJo6/LbSQ/ipLtj7/ja9vfC2ZXiI0g1Ud0FVHZbG7kmYYheIbMRv8gZDBW?=
 =?us-ascii?Q?4VVqcrhmipKSyCbqTH6MF2jRF0jRZxOBZrMAhY6fkHxTUHdaVJVtxSEU1umn?=
 =?us-ascii?Q?Lm7M5umxRbrIYZIW4rmxZRga+GhGnwds32EecPQXuFIQUMGgPxBHQpyrVShK?=
 =?us-ascii?Q?PrUse1myHbkiDTbJAaG5f/kUBN3oFaC7qgdXm/hLuFYvmQ6fN2jIam01k4Um?=
 =?us-ascii?Q?ufnw1LYGfCM4D1H9SlQAVxcs3MMnXwSIHYOdVQM67J6GEZJmXq/rBBUxa8m3?=
 =?us-ascii?Q?RtEOnjTfrInFRDecimCg2ivj7wUBxq1V0r+8+Y/pzuUypQm2ofObMaGNfNNa?=
 =?us-ascii?Q?ZAXt7T0z9XsF6nIu8x6sWaAnF7pliBk1HX/Bn4t1FrFPhWA/9wWwWt7ELYHh?=
 =?us-ascii?Q?3iK6PhEF97AMXebdmpc1QJgrKL2A8XK7+fs32VXafGTALZ2CFvvNKWYeN/AB?=
 =?us-ascii?Q?TH9p97HRv7SIVTC4ffxUcP/r/OQEpEUgtYOJ6wZ5D+Lzsekmx1Rhjy5jZVJC?=
 =?us-ascii?Q?ci1SpZBJL6HuK/THggPquwCu256t+xpvjSZ69CoSPH6AlQkfUb+XBpjQQDtO?=
 =?us-ascii?Q?JYi9wCE9hc2nWSH+4ZwttJvFBp8dKyZ6ayGfutOJ5YnnH/+mTYU3DcZCkDth?=
 =?us-ascii?Q?jQ6yDu6IRk/lM0Fy/0UcXhSvypgdJ1ogy3unHo/Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wS4DsnWdUVSFU/lnVgQlNORuJ7ruLFnvNQ/lG8ZbLXn0duB23ZgmT8C8v1Kd?=
 =?us-ascii?Q?nVjSyU9Gewql6m0se75ujgPJWMm99B46JlMU8NYD6ULV6lX5ta/z/lbcPilS?=
 =?us-ascii?Q?7+RTw7Q+tJqoaIy+9sP/G4Vr30InLyZQizAeh0DaQJROuRQnIbwr56Noysw3?=
 =?us-ascii?Q?36xBujEiLOHennwHRy/JKRHkzvmohm/YQ1PwW+5X0WfvvNHsfDkwo4RRBH0D?=
 =?us-ascii?Q?JgFAl/1n9GRyyO2Jw+Uy7pxB5IdlWWcQcefYU0uYzydYq5BErP+BRoHxszbT?=
 =?us-ascii?Q?m1zQ/O94GjYNRSYhY75dsVaL6K4YSW8FOOsxRPE7ib2z+hOxsPBLZF8MxmPW?=
 =?us-ascii?Q?48NMGrlMRnHer7UIEWuRw0uQ0ho0fpN8aEr6H7IafE4MAmfNUOdooAozYACT?=
 =?us-ascii?Q?OZOdQK/8t4+G2DM3aYE/P0eQqbeWh/im4oAa9lSjG5lvNyDVJK4opBmo7ioS?=
 =?us-ascii?Q?HLrW2ixl9UBvD6aUPIgq1ltnGaXzTKEwQWRye6hqvGJno5rwLpUCRr+gQe+S?=
 =?us-ascii?Q?tNH7NKmO6edeEr9Kn4aCZrwHPfpZ4m1P/pFafQkjVpZiM+fnkZcbFetxVGlo?=
 =?us-ascii?Q?lFTUGmx1SCY1gLUpdjE/iFgTtBP0X7nQ94set0fMx7S3YJI0IMK6fYU53CTX?=
 =?us-ascii?Q?/tfyBPd7f4NFUfe5NbwvNRiFkQPvTECifO5HMbzPvOV8eODWMmFmJVMK6Zm0?=
 =?us-ascii?Q?0yQFdCbttJSPMZ4G3i2r5KoGzJPH7cESiwyvEaJXm//Mf7AL1XFfB2OP0Okw?=
 =?us-ascii?Q?6+8gRF8oz4g1la/2FAqQ/yYC6Imx8OHr0IBWVwkq7NugSI6FmiMhuC6ISNzt?=
 =?us-ascii?Q?g8GqhXOkUbvzKsLF6B2QiqSXYxl9IG1XRQMmVueEMteZxpsAjY+ODMoz7LU1?=
 =?us-ascii?Q?d1lWNx7SIlEBHjlLVKoaGidvMIsFauEu8aM06VmLBRU2cZqibjIIQoQAoW/H?=
 =?us-ascii?Q?+PjEjW0lxwFR5hBLWdhYNF3CyzE2tANukQeItXnHoQxEMBnW/1cTcYn7Gvmf?=
 =?us-ascii?Q?m6PP5ohS6xIC2qzo4iZPuv2MfPRUO1B0+03DDP7gaYKREd+h65X7rV8crIQ7?=
 =?us-ascii?Q?Pmy7NyUwlPUyza9oesXyhfNaG+arvIhIzakG2kM/BX52JwWnpFHrT/RdZurk?=
 =?us-ascii?Q?faIXXCG07j3A2wwG21Zovd5LUVodOi5LXXmAXJFskKhfhzeslKEeNxpo8E31?=
 =?us-ascii?Q?TSF3zrTt2OpYCkupT7RxaBL6uR6c8Wmx2W1IprpXxqbsDmNOTonNH63ZQndi?=
 =?us-ascii?Q?nQYx3lDM3pd0GWAbmBRvuAzFCcJMMGqIL/yJIGH3QXEC85pmrzQJHygzQ5iK?=
 =?us-ascii?Q?q7hh9dRzWDNjmikGtbTo5upmu4xpiSPQKcnQS5YPJOWlHtxAaOvYrB0/i0SX?=
 =?us-ascii?Q?TVZUGhbuz0iyGc6fS05Yy0xET2xShii6rWXk2sh2dMKrg5+mr4tekpfIyXtg?=
 =?us-ascii?Q?+/nav8Y/ZFrbgFKHRKMG//gCSL0zZpqj+4abKpCBkOdDiUh05VuYvCCZfEGc?=
 =?us-ascii?Q?oxvnEs8QzeY7ArRXoEHFdQ87BoJ8vXNbVN1MiVuVend9SOS54RDgURT9tV7a?=
 =?us-ascii?Q?1y/wYhHAIxInk/yNIW6p3MzJ9IntxTxqXUV3A2wvz/dp3n/hD058fJL0Zi4c?=
 =?us-ascii?Q?mrHI/7LWzRhDCpVcZ06LaSOFdkBMyyB+uKnVghrdgI4Vi8RcjKCXmX60Y/Pj?=
 =?us-ascii?Q?ah2bdg5l9aoa5Y2NUWcGCMYGyQZSXCuefVqkuHBm79uICwnecCmkyoF0635t?=
 =?us-ascii?Q?lYfPiO4FBg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52573a7f-fcd9-4d59-9c12-08de6ea5b965
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 04:25:19.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HYmxr2d2xF7a0dOd/lS9QLGKAP/2Q/pVuwzDitCmHWsMNoiNg3stuZnM4nuKBAbMxj1EelW5bXLl6BMyKW1Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,01.org:url];
	TAGGED_FROM(0.00)[bounces-13991-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,cmpxchg.org,kvack.org,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,gmail.com,oracle.com,suse.com,linux.dev,bytedance.com,suse.cz,linux.alibaba.com,meta.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A2F73152F96
X-Rspamd-Action: no action



Hello,

kernel test robot noticed "RIP:__mod_node_page_state" on:

commit: 4b5f69459c0988d3b292aceb74633e04eea84c7f ("[PATCH 1/2] mm/mempolicy: track page allocations per mempolicy")
url: https://github.com/intel-lab-lkp/linux/commits/JP-Kobryn/mm-mempolicy-track-page-allocations-per-mempolicy/20260212-142941
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20260212045109.255391-2-inwardvessel@gmail.com/
patch subject: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy

in testcase: boot

config: x86_64-randconfig-007-20250327
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------------------+------------+------------+
|                                                                  | 5cbf93e36f | 4b5f69459c |
+------------------------------------------------------------------+------------+------------+
| boot_successes                                                   | 244        | 0          |
| boot_failures                                                    | 0          | 244        |
| RIP:__mod_node_page_state                                        | 0          | 244        |
| BUG:using__this_cpu_read()in_preemptible                         | 0          | 244        |
| BUG:using__this_cpu_write()in_preemptible[#]code:kthreadd        | 0          | 244        |
| BUG:using__this_cpu_write()in_preemptible[#]code:swapper         | 0          | 187        |
| BUG:using__this_cpu_write()in_preemptible[#]code:kdevtmpfs       | 0          | 79         |
| BUG:using__this_cpu_write()in_preemptible[#]code:kworker/u8      | 0          | 229        |
| BUG:using__this_cpu_write()in_preemptible[#]code:udevd           | 0          | 62         |
| BUG:using__this_cpu_write()in_preemptible[#]code:tail            | 0          | 21         |
| BUG:using__this_cpu_write()in_preemptible[#]code:syslogd         | 0          | 54         |
| BUG:using__this_cpu_write()in_preemptible[#]code:klogd           | 0          | 113        |
| BUG:using__this_cpu_write()in_preemptible[#]code:sleep           | 0          | 98         |
| BUG:using__this_cpu_write()in_preemptible[#]code:post-run        | 0          | 39         |
| BUG:using__this_cpu_write()in_preemptible[#]code:rsync           | 0          | 9          |
| BUG:using__this_cpu_write()in_preemptible[#]code:modprobe        | 0          | 6          |
| BUG:using__this_cpu_write()in_preemptible[#]code                 | 0          | 32         |
| BUG:using__this_cpu_write()in_preemptible[#]code:udevadm         | 0          | 78         |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd         | 0          | 39         |
| BUG:using__this_cpu_write()in_preemptible[#]code:(udev-worker)   | 0          | 53         |
| RIP:rep_movs_alternative                                         | 0          | 5          |
| BUG:using__this_cpu_write()in_preemptible[#]code:cat             | 0          | 7          |
| BUG:using__this_cpu_write()in_preemptible[#]code:sed             | 0          | 98         |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-udevd   | 0          | 19         |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-journal | 0          | 54         |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-random  | 0          | 4          |
| BUG:using__this_cpu_write()in_preemptible[#]code:journalctl      | 0          | 8          |
| BUG:using__this_cpu_write()in_preemptible[#]code:start_getty     | 0          | 4          |
| RIP:__put_user_4                                                 | 0          | 24         |
| BUG:using__this_cpu_write()in_preemptible[#]code:wget            | 0          | 82         |
| BUG:using__this_cpu_write()in_preemptible[#]code:run-lkp         | 0          | 32         |
| BUG:using__this_cpu_write()in_preemptible[#]code:boot-#-yocto-i3 | 0          | 24         |
| BUG:using__this_cpu_write()in_preemptible[#]code:one-shot-monito | 0          | 4          |
| BUG:using__this_cpu_write()in_preemptible[#]code:vmstat          | 0          | 29         |
| BUG:using__this_cpu_write()in_preemptible[#]code:rs:main_Q:Reg   | 0          | 9          |
| RIP:rep_stos_alternative                                         | 0          | 11         |
| BUG:using__this_cpu_write()in_preemptible[#]code:lkp-setup-rootf | 0          | 21         |
| BUG:using__this_cpu_write()in_preemptible[#]code:stty            | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:tee             | 0          | 7          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-rc-loca | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:(exec-inner)    | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:groupadd        | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:(sd-exec-strv)  | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:rc              | 0          | 14         |
| BUG:using__this_cpu_write()in_preemptible[#]code:getty           | 0          | 18         |
| BUG:using__this_cpu_write()in_preemptible[#]code:boot-#-debian   | 0          | 4          |
| BUG:using__this_cpu_write()in_preemptible[#]code:monitor         | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-tmpfile | 0          | 6          |
| BUG:using__this_cpu_write()in_preemptible[#]code:lscpu           | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:dirname         | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-sysuser | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:(d-sysctl)      | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:mount           | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:ls              | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:pgrep           | 0          | 4          |
| BUG:using__this_cpu_write()in_preemptible[#]code:grep            | 0          | 8          |
| BUG:using__this_cpu_write()in_preemptible[#]code:S77lkp-bootstra | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:date            | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-sysctl  | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:find            | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:sshd            | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-system  | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-sysv-ge | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-hiberna | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:journal-offline | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:sysctl          | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:init            | 0          | 7          |
| BUG:using__this_cpu_write()in_preemptible[#]code:mkdir           | 0          | 6          |
| BUG:using__this_cpu_write()in_preemptible[#]code:mountpoint      | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-logind  | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:dmesg           | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-ssh-gen | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:cp              | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:wakeup          | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:dpkg-deb        | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:dpkg            | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:(modprobe)      | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:sync            | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-update  | 0          | 4          |
| BUG:using__this_cpu_write()in_preemptible[#]code:kmod            | 0          | 1          |
| RIP:strncpy_from_user                                            | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:sm-notify       | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-remount | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:blkmapd         | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:mkfifo          | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:ln              | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:sh              | 0          | 5          |
| BUG:using__this_cpu_write()in_preemptible[#]code:bootlogd        | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:run-test        | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:S07bootlogd     | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:hwclock.sh      | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:(sd-mkdcreds)   | 0          | 1          |
| RIP:filldir64                                                    | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:chmod           | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:ps              | 0          | 3          |
| BUG:using__this_cpu_write()in_preemptible[#]code:which           | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:ip              | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:start-stop-daem | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:S20syslog       | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-gpt-aut | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-debug-g | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:(rpcbind)       | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:seq             | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-run-gen | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:wait            | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:addgroup        | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:rm              | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:in:imklog       | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:basename        | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:touch           | 0          | 1          |
| RIP:ia32_setup_frame                                             | 0          | 2          |
| BUG:using__this_cpu_write()in_preemptible[#]code:no-stdout-monit | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:systemd-tpm#-ge | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:(mount)         | 0          | 1          |
| BUG:using__this_cpu_write()in_preemptible[#]code:ldconfig        | 0          | 1          |
+------------------------------------------------------------------+------------+------------+

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602181136.f66ba888-lkp@intel.com



[    0.624787][    T2] ------------[ cut here ]------------
[    0.625191][    T2] WARNING: mm/vmstat.c:396 at __mod_node_page_state+0x88/0x1c0, CPU#0: kthreadd/2
[    0.625887][    T2] Modules linked in:
[    0.626070][    T2] CPU: 0 UID: 0 PID: 2 Comm: kthreadd Tainted: G                T   6.19.0-rc6-00596-g4b5f69459c09 #1 PREEMPT(lazy)  a55f7fce8adbfb8e52612c1f0ea71f4db1a1df23
[    0.626084][    T2] Tainted: [T]=RANDSTRUCT
[    0.626402][    T2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    0.627150][    T2] RIP: 0010:__mod_node_page_state (mm/vmstat.c:396 (discriminator 34))
[    0.627592][    T2] Code: 8b 05 88 b9 73 02 48 c7 c7 d8 b0 b4 83 85 c0 89 45 d0 40 0f 95 c6 31 c9 31 d2 40 0f b6 f6 e8 3f 96 e4 ff 8b 45 d0 85 c0 74 1b <0f> 0b be 01 00 00 00 eb 14 31 c9 31 d2 31 f6 48 c7 c7 d8 b0 b4 83
All code
========
   0:	8b 05 88 b9 73 02    	mov    0x273b988(%rip),%eax        # 0x273b98e
   6:	48 c7 c7 d8 b0 b4 83 	mov    $0xffffffff83b4b0d8,%rdi
   d:	85 c0                	test   %eax,%eax
   f:	89 45 d0             	mov    %eax,-0x30(%rbp)
  12:	40 0f 95 c6          	setne  %sil
  16:	31 c9                	xor    %ecx,%ecx
  18:	31 d2                	xor    %edx,%edx
  1a:	40 0f b6 f6          	movzbl %sil,%esi
  1e:	e8 3f 96 e4 ff       	call   0xffffffffffe49662
  23:	8b 45 d0             	mov    -0x30(%rbp),%eax
  26:	85 c0                	test   %eax,%eax
  28:	74 1b                	je     0x45
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	be 01 00 00 00       	mov    $0x1,%esi
  31:	eb 14                	jmp    0x47
  33:	31 c9                	xor    %ecx,%ecx
  35:	31 d2                	xor    %edx,%edx
  37:	31 f6                	xor    %esi,%esi
  39:	48 c7 c7 d8 b0 b4 83 	mov    $0xffffffff83b4b0d8,%rdi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	be 01 00 00 00       	mov    $0x1,%esi
   7:	eb 14                	jmp    0x1d
   9:	31 c9                	xor    %ecx,%ecx
   b:	31 d2                	xor    %edx,%edx
   d:	31 f6                	xor    %esi,%esi
   f:	48 c7 c7 d8 b0 b4 83 	mov    $0xffffffff83b4b0d8,%rdi
[    0.629418][    T2] RSP: 0000:ffff88810039fa20 EFLAGS: 00010202
[    0.629869][    T2] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000000
[    0.630445][    T2] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    0.631089][    T2] RBP: ffff88810039fa50 R08: 0000000000000000 R09: 0000000000000000
[    0.631671][    T2] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88883ffe02c0
[    0.632247][    T2] R13: ffffffff83f18971 R14: ffffffff83f18940 R15: 0000000000000030
[    0.632746][    T2] FS:  0000000000000000(0000) GS:ffff88889bd1c000(0000) knlGS:0000000000000000
[    0.633394][    T2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.633875][    T2] CR2: ffff88883ffff000 CR3: 000000000343d000 CR4: 00000000000406b0
[    0.634478][    T2] Call Trace:
[    0.634723][    T2]  <TASK>
[    0.634951][    T2]  alloc_pages_mpol (mm/mempolicy.c:2513 (discriminator 1))
[    0.635326][    T2]  alloc_frozen_pages_noprof (mm/mempolicy.c:2584)
[    0.635746][    T2]  allocate_slab (mm/slub.c:3075 (discriminator 2) mm/slub.c:3248 (discriminator 2))
[    0.636086][    T2]  new_slab (mm/slub.c:3304)
[    0.636394][    T2]  ___slab_alloc (mm/slub.c:4657)
[    0.636749][    T2]  ? dup_task_struct (kernel/fork.c:184 (discriminator 2) kernel/fork.c:915 (discriminator 2))
[    0.637114][    T2]  __slab_alloc+0x8a/0x180
[    0.637519][    T2]  slab_alloc_node+0x189/0x340
[    0.637919][    T2]  ? dup_task_struct (kernel/fork.c:184 (discriminator 2) kernel/fork.c:915 (discriminator 2))
[    0.638285][    T2]  kmem_cache_alloc_node_noprof (mm/slub.c:5317 (discriminator 1))
[    0.638710][    T2]  dup_task_struct (kernel/fork.c:184 (discriminator 2) kernel/fork.c:915 (discriminator 2))
[    0.639058][    T2]  ? ftrace_likely_update (arch/x86/include/asm/smap.h:90 kernel/trace/trace_branch.c:223)
[    0.639416][    T2]  copy_process (kernel/fork.c:2052 (discriminator 1))
[    0.639773][    T2]  kernel_clone (include/linux/random.h:26 kernel/fork.c:2652)
[    0.640115][    T2]  ? kthread_fetch_affinity (kernel/kthread.c:412)
[    0.640552][    T2]  kernel_thread (kernel/fork.c:2713)
[    0.640892][    T2]  ? kthread_fetch_affinity (kernel/kthread.c:412)
[    0.641310][    T2]  kthreadd (kernel/kthread.c:486 kernel/kthread.c:844)
[    0.641621][    T2]  ? kthreadd (kernel/kthread.c:830 (discriminator 5))
[    0.641938][    T2]  ? kthread_is_per_cpu (kernel/kthread.c:816)
[    0.642316][    T2]  ret_from_fork (arch/x86/kernel/process.c:164)
[    0.642657][    T2]  ? kthread_is_per_cpu (kernel/kthread.c:816)
[    0.642744][    T2]  ? kthread_is_per_cpu (kernel/kthread.c:816)
[    0.643127][    T2]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[    0.643502][    T2]  </TASK>
[    0.643755][    T2] irq event stamp: 393
[    0.644054][    T2] hardirqs last  enabled at (401): __up_console_sem (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 arch/x86/include/asm/irqflags.h:159 kernel/printk/printk.c:345)
[    0.644730][    T2] hardirqs last disabled at (408): __up_console_sem (kernel/printk/printk.c:343 (discriminator 3))
[    0.645406][    T2] softirqs last  enabled at (54): handle_softirqs (kernel/softirq.c:469 (discriminator 1) kernel/softirq.c:650 (discriminator 1))
[    0.646077][    T2] softirqs last disabled at (49): __irq_exit_rcu (kernel/softirq.c:657 kernel/softirq.c:496 kernel/softirq.c:723)
[    0.646741][    T2] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260218/202602181136.f66ba888-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


