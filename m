Return-Path: <cgroups+bounces-10736-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 62289BD9FC4
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 16:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA6F3354751
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C927AC57;
	Tue, 14 Oct 2025 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AD2rxaCU"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA10239E91;
	Tue, 14 Oct 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451963; cv=fail; b=HnW/r3t/ahdIIEO3naAIxl56dXPl0qeLMlKH3qJjOlrEG8vC0gnr7Q2pyIskkFzX4od4RloNE6cU51+6S9Th/jEQBmNPmIwd2LdBpVpzeFPRXrgFa55Vxy5oSNoxe2eP8Tk3zWPT73whIAst/FcQdnEYL01iAmynQt58D037HiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451963; c=relaxed/simple;
	bh=4p1XskoxcZFXnyiNCsSa05h3Ngcgg5knVgXHNs/55sc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S8lJRZ2+o7rEH8dIMihr+gkWn8NnJ9GlCuIPlU59PtbCMFSIlfVKIavqGIpdbT5R4iAMByNVkLIPpMMaBPWO3j+GIKJGpc0wLUVr9Tw/tcSU2fbZkudjdOtP2zaq1pd2//E3iWTnlxuWGbqSEbSkAnRDR7KK4Wcixk8PgMzPw/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AD2rxaCU; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760451961; x=1791987961;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=4p1XskoxcZFXnyiNCsSa05h3Ngcgg5knVgXHNs/55sc=;
  b=AD2rxaCUBgBqNnJvwzOK5WAKXbXmqAGJU74GHn3bapstG5d7hrf7PbpF
   TymcXh+t0n8p5vNCQUKkxOlz5lOmLDjm6QVOHwnP9JzRrIR9/Jsgu7bZN
   svAoxKTQ+beQQpZBbT4d37MYCX/XE7jAuSzEF+2k7r07onbQRAXJdp5nv
   R66jYDwColQVmImnGxfJVmraz5C1M2s6jeeKo7/q/zqHJ46Wy5HFsdIuU
   ic4uQi02vRK7lY3O6gM3JuAEwMWfevPoO+l1GdNXcCY8cgFvs0H0hN59S
   CNjtq0NiUohRmvh21rbBwEsIm4G8GM9HOUhywczG+JdqGddPkclXnM5lg
   g==;
X-CSE-ConnectionGUID: ExrBDuUrS+GogCvsZfC/gQ==
X-CSE-MsgGUID: 5nbnCse+TLS95WTWMLlOXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="80245418"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="80245418"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:25:36 -0700
X-CSE-ConnectionGUID: 1ZjpvNArSw6QGqweEkfyig==
X-CSE-MsgGUID: ZmnEK+G6SoOAtFhV7hE83w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="205601965"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:25:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:25:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 07:25:34 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:25:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvo+Bz9wjLXDPbeGKaH6esnwGj3cnNWWnFljSh2ovYnPxPmyHDy+DblLo477JN90IyXZAqjZLSx7msAA6LtKXxMcCMyBcFijITKbxqQnhUqhKat7WRdCHemQzObFIMzzFRSkwi+6SYByy4F6DEOd+OCZ1+xBnwJ9q7+rja9OcRMON1Ye+nhVxFVmOsmkjUbcP6+PDW13kmNO9ya+6JXXuZliQO4pMnIZquA/wzGieDCK5uF0ZsVwBN+fKR8h7o4P5AQJT/x3lgMUbk4PsILf+PoV9QcKPDCyMpFSR2hx4sC05zrQvE+k342nu+dxsAZoohg8OHQClN8AaOdZ1ITPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udeDWYEdWG3m8GqhSsIbOUYZNcF5YFF1NJzEE0xdNnw=;
 b=CiuLWgPX/Vmjo8OvZDZZxA6ItKkwxSXeroAU2AXrPsVO4MHcUW2WLtO645IDszkIMjP2PSx7YX3aDCdrEVnrS+tVGiaV1zF8OjA/q+xjz8gtELb0X7r27nyd2OLks2KHM4khBNRUZigqyonQ2+H54Yb0bs+5HoGoFUyGClOgjRM5r7AanfwCWu28tjo+MulMmyM8V0NEKDGp3WCB758/8i8csaKmt95mDKi3wUKjtkU+Nte419ufm0JEJbNneJPjbFijTUcC4LZj2AMmVrlB6N4B9NFPDBV3XmxOmdwvcWRiGG9pie5ysevlTZvX1xrOCuQyJcoKcCu6jeyeM8h0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7970.namprd11.prod.outlook.com (2603:10b6:8:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 14:25:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 14:25:26 +0000
Date: Tue, 14 Oct 2025 22:25:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qi Zheng <qi.zheng@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Qi Zheng
	<zhengqi.arch@bytedance.com>, Zi Yan <ziy@nvidia.com>, David Hildenbrand
	<david@redhat.com>, <linux-mm@kvack.org>, <hannes@cmpxchg.org>,
	<hughd@google.com>, <mhocko@suse.com>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<lorenzo.stoakes@oracle.com>, <harry.yoo@oracle.com>,
	<baolin.wang@linux.alibaba.com>, <Liam.Howlett@oracle.com>,
	<npache@redhat.com>, <ryan.roberts@arm.com>, <dev.jain@arm.com>,
	<baohua@kernel.org>, <lance.yang@linux.dev>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>, Muchun Song
	<songmuchun@bytedance.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v4 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
Message-ID: <202510142245.b857a693-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <304df1ad1e8180e102c4d6931733bcc77774eb9e.1759510072.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a693972-894f-4782-d756-08de0b2d84b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NtaOKGuqpW5/dHcML35x6SOb/Xk5c3AdAGDstsb+oPjfA9J3jHz5cVTukgxM?=
 =?us-ascii?Q?r1+hdsqFFYBtqUV/zL/8ZxBsNaN3CjLr1BRKIwBZHNRfiMsXDB69AaWsd/u8?=
 =?us-ascii?Q?5YxMh9C6gWANPHYyH9F8hVMHbUvPK09Y+jYh6t7CE+Joz3/A2eKRmlMUyT5O?=
 =?us-ascii?Q?1nSIJKg5YtwuMvpe5ErWbfDKF+W2oNSfJwClUXy1BNkKupotlbSpW/oMJMgo?=
 =?us-ascii?Q?D7vPakYmjBceIUdknO3MFARyN/uBRUedIFM20eDK7ydH4bJvpFie5XqNn8fm?=
 =?us-ascii?Q?Z9oGnyDC9yCkOBfWlzQ2j+GvFpdtxGEPhFJIriOeYe+19f5zBdjFsflZuxf+?=
 =?us-ascii?Q?9XHrG8Qir9V9CEYpMynsFibLc6/zku7An6IP7qttuaqnICI+7AklPt3s2DqO?=
 =?us-ascii?Q?T8zP7JEXFT8EMoFXBTjP3FfIzP9E8tJ5Sa6KOQ4MLvfow/gK/5L9jyp/mXmV?=
 =?us-ascii?Q?iWyYsp2Coo4RxukLA+Si/+sds2jHoKzFms/D8fB+Ntkt+yFhBdoP/foN1exz?=
 =?us-ascii?Q?qdqxFDBq1Qm0dudq8hRVIF+T4iQiAqPBNVGKROIlf+1iLY98PAHWQJEgFRxe?=
 =?us-ascii?Q?NNdxcJvAffjNw2NRX0R2GnYKUSzbuYAcDUbUeRb/HMrJ38cZYKltueyNplRO?=
 =?us-ascii?Q?o0/j0fskEwIIwt63N5/dmzsU0gxKU04jO480Ngy21BvT5Ualy69CVXIQtxx0?=
 =?us-ascii?Q?R/8DhDo8cx+y2wmtHaD35Ez4ue0dmq759OFlMkIRs4GTU2sJCyqKs9Tma95e?=
 =?us-ascii?Q?rmWwVxz7J/ONc6HhOoS0SJd7nBN13lFQXTDVljvt1jFwrdVfjFZAbBHeTtB3?=
 =?us-ascii?Q?cDU++heC4LlE8/ZCZ/Ud5Uh6XHSf61ZnI9GJfyCutgo4dgiFUaOeyppADpd2?=
 =?us-ascii?Q?DFHSKt4q1L+ybeybROfGV1COEKBUm7hwfKjo4jVU/MiUYLCZLI+7g3oPUths?=
 =?us-ascii?Q?ddV2ECIjMW3RTHO+YCnsNKAzcdaeQAqmcBumR8jaAJUztihpVOoG4mhyObd4?=
 =?us-ascii?Q?4XOOa42GDFPoExQZ58ftWJMGq4f/5VtLpWWYcM1vWXVM9f8ydJBSCZQSZ6gg?=
 =?us-ascii?Q?B+1U9edFIrs1DhoPwvHDI3Gd2JIRczZQAMo/MJ3/lg8LhUx8D2d6vTyya2mb?=
 =?us-ascii?Q?IXZ0EIQI2rImWpK80edxBchsNvnepAipqCgm/k5LF5lzffgSeppBbjO3SiGt?=
 =?us-ascii?Q?pPn7ef07yJw3lxIC6aMjW6/aDtqzRvPFqBUj1+DuWya0SQGIKtbhmMu1i9QL?=
 =?us-ascii?Q?oqDBTU6uNCuWdGlNveqg/0qpKYg7glC51JR/skqokiPGZkudFphxoSLYoSFu?=
 =?us-ascii?Q?e7KRAJjoo5r6xFbBcKb3vmyymd+Nb/pCe987z9PryxwIb7hTBZx5vb16z08s?=
 =?us-ascii?Q?pxiYoCSMRSpFhIwYKOI5KvfKTg1WND+GCr/ksi6jhaxqFaMoZz7GTMukR3a1?=
 =?us-ascii?Q?mEzsplzy7A4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pM6x6FeyZ0Xxn9Fnw/UOYuXV8mkKb0JGW8wG26abGGb6924zRs6HiC/6CY8W?=
 =?us-ascii?Q?rsFEjDaONqp+C0dAB1IqyfxV0CClujuo8b5qaL/Z/CEDjS4xUj2SY1S3SfTR?=
 =?us-ascii?Q?Y/KG/XM2lKdkZf2bWrYBco1hM0opdx/IOgNi8EC39D7pliOfhcnzsA5EV6K5?=
 =?us-ascii?Q?t1dsXo09LY+7ufi+mXLTXPos9HmxEgHReFUOn85ZuN2dkV8AlWhCRKY1/BNF?=
 =?us-ascii?Q?Hh0fRDbimbZphMaFvhQfhfOTeZlw0aHBwCK2xbSKI8I9A+qLagWiN4BnQrmG?=
 =?us-ascii?Q?WUFH5YN/NAMxeul0nFmIYb/leTC+lr4VqbEBFqSNNeOIwKg2o48f+CZXrfje?=
 =?us-ascii?Q?vNQ501ZyYKhaAWEdwTXNcXa5gPu3ZYX01PZKEi2hNkYQrhGikxw35h1dKHbL?=
 =?us-ascii?Q?7FXdb4bXerYdLO8fGohzJAjiJWRD2OKGnMPzKjXLmNlW9Rby6xWjYWUp2NbF?=
 =?us-ascii?Q?W3+0jiNhcBE2hMsjF+3I7hKK7K4/CqIeThafgjc/v8N4X5l4DAefqIUwKxKq?=
 =?us-ascii?Q?37jf5ShRxmmuNKkJrbgTMzi0pBSsKGjPiNgDyky09tkrDaj+HF87MSzlvqG8?=
 =?us-ascii?Q?6Ky3JrL0dMZCqovAYDpSun6awm9rikskfgwF7UlobbXlEQ/hIvf8T8TScvBx?=
 =?us-ascii?Q?YsRtoO4oVUNmX5EdlSQ06Z7/KT+VmqNHjc4QZ9xDhPmTSl9kt9qFd4AlRLGB?=
 =?us-ascii?Q?3vGk1ejjhJhUPL3DN8Z+3ZxwfiM7i22Quj2kl3zjw3di/tV4cidQR1Jofxnd?=
 =?us-ascii?Q?A8q7W2nBqOI3t91+f7wGN0qQlcf4/3KCkFRFrCjNgQ6gj0t4+EflmTJxSkUQ?=
 =?us-ascii?Q?7iT9WWTOTQhA7AYjFbtQhaItQHCWF+FkZEnikfBwEIF2fUUKtWg4WXU12h8i?=
 =?us-ascii?Q?KaoyZAV2rKBAH4d5KQBHs49oYjhPWT7mzTcsakTMtlFeWU+y+29owFQzDrwc?=
 =?us-ascii?Q?tO9+4ZQRA6B8nDH01qhsAnYq2kYHj/DIz6O4ANEcWW+qlunwKRtrWpFvNadV?=
 =?us-ascii?Q?4uKbtQy+GQpxpqXxNPazH4WHt2sjzBWxgTEoolFqyIpvARe4Uhj6AAcepnAd?=
 =?us-ascii?Q?fjmrQaQy2wOrU5bZzSRaNRLGezzQET6KD5XVQIVpaDiLNRUc8JgRx3aLYuvN?=
 =?us-ascii?Q?Mw0OjZr9T9vLEomZgBwPPUys76V1IEuN3LR87RWi10p9hdwIfZnLtj5er3IK?=
 =?us-ascii?Q?l7OBzN+o90JTmCDRncE+CfEanuDkeO2gxdPzlXb4KiI4bIlO/1MjninoeLxp?=
 =?us-ascii?Q?X0VmFKX0AbxUJ0kwWJZSNd4Fdw1LCEnf4e//HQm55QTIspD3GY0b6lE7PW0s?=
 =?us-ascii?Q?6OBCWKA/3I7NzCDYHFA7W9IKovJsAw0etGE8O3e8RyhNHwz/j9glLWx3xfNl?=
 =?us-ascii?Q?EnbiZ0rAWGdRX6iPt452iikGPYabD4IspruJlwi69O+S8uPJ9it+4LCcJt7d?=
 =?us-ascii?Q?wdS8AcqX11jUphKrJQ1yZX/P0pIF2HvzHp2883cr+5LfyboFHWr6CVdewc93?=
 =?us-ascii?Q?TtZQYWLYqpRivx/xESWwVlwhkkxdDJm9LCWOmKCl1c3F8DzdYibyVF/Ekovr?=
 =?us-ascii?Q?TUDwIne2g4H7/x+M6jh+AP0GAqBcb/lhswzJHZoH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a693972-894f-4782-d756-08de0b2d84b5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:25:26.5048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS+M7hSkKL/DNasssnshBVtWbND4lNal/Jx1tqgk22MQ3++OX2rFJpocBtB+heX52PMMIcAMq87wf1fTvRnJqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7970
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![#:#]" on:

commit: 9d46e7734bc76dcb83ab0591de7f7ba94234140a ("[PATCH v4 3/4] mm: thp: use folio_batch to handle THP splitting in deferred_split_scan()")
url: https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/mm-thp-replace-folio_memcg-with-folio_memcg_charged/20251004-005605
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git e406d57be7bd2a4e73ea512c1ae36a40a44e499e
patch link: https://lore.kernel.org/all/304df1ad1e8180e102c4d6931733bcc77774eb9e.1759510072.git.zhengqi.arch@bytedance.com/
patch subject: [PATCH v4 3/4] mm: thp: use folio_batch to handle THP splitting in deferred_split_scan()

in testcase: xfstests
version: xfstests-x86_64-5a9cd3ef-1_20250910
with following parameters:

	disk: 4HDD
	fs: f2fs
	test: generic-group-39



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510142245.b857a693-lkp@intel.com


[  102.427367][    C6] watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [391:4643]
[  102.427373][    C6] Modules linked in: dm_mod f2fs binfmt_misc btrfs snd_hda_codec_intelhdmi blake2b_generic snd_hda_codec_hdmi xor zstd_compress intel_rapl_msr intel_rapl_common snd_ctl_led raid6_pq snd_hda_codec_alc269 snd_hda_scodec_component x86_pkg_temp_thermal snd_hda_codec_realtek_lib intel_powerclamp snd_hda_codec_generic coretemp sd_mod snd_hda_intel kvm_intel sg snd_soc_avs snd_soc_hda_codec snd_hda_ext_core i915 snd_hda_codec kvm intel_gtt snd_hda_core drm_buddy snd_intel_dspcfg ttm snd_intel_sdw_acpi snd_hwdep drm_display_helper snd_soc_core irqbypass cec ghash_clmulni_intel drm_client_lib snd_compress mei_wdt drm_kms_helper snd_pcm ahci rapl wmi_bmof mei_me libahci snd_timer intel_cstate i2c_i801 video snd libata soundcore pcspkr intel_uncore mei serio_raw i2c_smbus intel_pmc_core intel_pch_thermal pmt_telemetry pmt_discovery pmt_class wmi intel_pmc_ssram_telemetry acpi_pad intel_vsec drm fuse nfnetlink
[  102.427441][    C6] CPU: 6 UID: 0 PID: 4643 Comm: 391 Tainted: G S                  6.17.0-09102-g9d46e7734bc7 #1 PREEMPT(voluntary)
[  102.427446][    C6] Tainted: [S]=CPU_OUT_OF_SPEC
[  102.427448][    C6] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  102.427449][    C6] RIP: 0010:_raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152 (discriminator 2) kernel/locking/spinlock.c:194 (discriminator 2))
[  102.427456][    C6] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 c6 07 00 0f 1f 00 f7 c6 00 02 00 00 74 01 fb 65 ff 0d 65 de 2d 03 <74> 05 c3 cc cc cc cc 0f 1f 44 00 00 c3 cc cc cc cc 0f 1f 40 00 90
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  14:	c6 07 00             	movb   $0x0,(%rdi)
  17:	0f 1f 00             	nopl   (%rax)
  1a:	f7 c6 00 02 00 00    	test   $0x200,%esi
  20:	74 01                	je     0x23
  22:	fb                   	sti
  23:	65 ff 0d 65 de 2d 03 	decl   %gs:0x32dde65(%rip)        # 0x32dde8f
  2a:*	74 05                	je     0x31		<-- trapping instruction
  2c:	c3                   	ret
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  36:	c3                   	ret
  37:	cc                   	int3
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	cc                   	int3
  3b:	0f 1f 40 00          	nopl   0x0(%rax)
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	74 05                	je     0x7
   2:	c3                   	ret
   3:	cc                   	int3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   c:	c3                   	ret
   d:	cc                   	int3
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	0f 1f 40 00          	nopl   0x0(%rax)
  15:	90                   	nop
[  102.427458][    C6] RSP: 0018:ffffc900028cf6c8 EFLAGS: 00000246
[  102.427461][    C6] RAX: ffff88810cb32900 RBX: ffffc900028cfa38 RCX: ffff88810cb32910
[  102.427463][    C6] RDX: ffff88810cb32900 RSI: 0000000000000246 RDI: ffff88810cb328f8
[  102.427465][    C6] RBP: ffff88810cb32870 R08: 0000000000000001 R09: fffff52000519ece
[  102.427467][    C6] R10: 0000000000000003 R11: ffffc900028cf770 R12: ffffea0008400034
[  102.427469][    C6] R13: dffffc0000000000 R14: ffff88810cb32900 R15: ffff88810cb32870
[  102.427470][    C6] FS:  00007f2303266740(0000) GS:ffff8883f6bb8000(0000) knlGS:0000000000000000
[  102.427473][    C6] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  102.427475][    C6] CR2: 00005651624c9c70 CR3: 00000001e42c6002 CR4: 00000000003726f0
[  102.427477][    C6] Call Trace:
[  102.427478][    C6]  <TASK>
[  102.427480][    C6]  deferred_split_scan (mm/huge_memory.c:4166 mm/huge_memory.c:4240)
[  102.427485][    C6]  ? __list_lru_walk_one (include/linux/spinlock.h:392 mm/list_lru.c:110 mm/list_lru.c:331)
[  102.427490][    C6]  ? __pfx_deferred_split_scan (mm/huge_memory.c:4195)
[  102.427495][    C6]  ? list_lru_count_one (mm/list_lru.c:263 (discriminator 1))
[  102.427498][    C6]  ? super_cache_scan (fs/super.c:232)
[  102.427501][    C6]  ? super_cache_count (fs/super.c:265 (discriminator 1))
[  102.427504][    C6]  do_shrink_slab (mm/shrinker.c:438)
[  102.427509][    C6]  shrink_slab_memcg (mm/shrinker.c:551)
[  102.427513][    C6]  ? __pfx_shrink_slab_memcg (mm/shrinker.c:471)
[  102.427517][    C6]  ? do_shrink_slab (mm/shrinker.c:384)
[  102.427521][    C6]  shrink_slab (mm/shrinker.c:628)
[  102.427524][    C6]  ? __pfx_shrink_slab (mm/shrinker.c:616)
[  102.427528][    C6]  ? mem_cgroup_iter (include/linux/percpu-refcount.h:338 include/linux/percpu-refcount.h:351 include/linux/cgroup_refcnt.h:79 include/linux/cgroup_refcnt.h:76 mm/memcontrol.c:1084)
[  102.427531][    C6]  drop_slab (mm/vmscan.c:435 (discriminator 1) mm/vmscan.c:452 (discriminator 1))
[  102.427534][    C6]  drop_caches_sysctl_handler (include/linux/vmstat.h:68 (discriminator 1) fs/drop_caches.c:69 (discriminator 1) fs/drop_caches.c:51 (discriminator 1))
[  102.427538][    C6]  proc_sys_call_handler (fs/proc/proc_sysctl.c:606)
[  102.427542][    C6]  ? __pfx_proc_sys_call_handler (fs/proc/proc_sysctl.c:555)
[  102.427545][    C6]  ? __pfx_handle_pte_fault (mm/memory.c:6134)
[  102.427548][    C6]  ? rw_verify_area (fs/read_write.c:473)
[  102.427552][    C6]  vfs_write (fs/read_write.c:594 (discriminator 1) fs/read_write.c:686 (discriminator 1))
[  102.427556][    C6]  ? __pfx_vfs_write (fs/read_write.c:667)
[  102.427559][    C6]  ? __pfx_css_rstat_updated (kernel/cgroup/rstat.c:71)
[  102.427563][    C6]  ? fdget_pos (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/file_ref.h:215 fs/file.c:1204 fs/file.c:1230)
[  102.427566][    C6]  ? count_memcg_events (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 mm/memcontrol.c:560 mm/memcontrol.c:583 mm/memcontrol.c:564 mm/memcontrol.c:846)
[  102.427568][    C6]  ksys_write (fs/read_write.c:738)
[  102.427572][    C6]  ? __pfx_ksys_write (fs/read_write.c:728)
[  102.427575][    C6]  ? handle_mm_fault (mm/memory.c:6360 mm/memory.c:6513)
[  102.427579][    C6]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[  102.427583][    C6]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  102.427586][    C6] RIP: 0033:0x7f23032f8687
[  102.427589][    C6] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
All code
========
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	4c 89 df             	mov    %r11,%rdi
   6:	e8 58 b3 00 00       	call   0xb363
   b:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  11:	59                   	pop    %rcx
  12:	5e                   	pop    %rsi
  13:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
  17:	74 1a                	je     0x33
  19:	5b                   	pop    %rbx
  1a:	c3                   	ret
  1b:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  22:	00 
  23:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  28:	0f 05                	syscall
  2a:*	5b                   	pop    %rbx		<-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  33:	83 e2 39             	and    $0x39,%edx
  36:	83 fa 08             	cmp    $0x8,%edx
  39:	75 de                	jne    0x19
  3b:	e8 23 ff ff ff       	call   0xffffffffffffff63

Code starting with the faulting instruction
===========================================
   0:	5b                   	pop    %rbx
   1:	c3                   	ret
   2:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   9:	83 e2 39             	and    $0x39,%edx
   c:	83 fa 08             	cmp    $0x8,%edx
   f:	75 de                	jne    0xffffffffffffffef
  11:	e8 23 ff ff ff       	call   0xffffffffffffff39


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251014/202510142245.b857a693-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


