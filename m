Return-Path: <cgroups+bounces-6911-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE6CA58BBF
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 06:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A443188A2F1
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 05:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F141C57B2;
	Mon, 10 Mar 2025 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jk0zpx5a"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1E1624C0
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741585851; cv=fail; b=MWREvYXr8qknfNyqKPNk0Et6XzPLvBKlRchvQHF6l6bDxpZi3ug/xNPfBg1R0mdUzp/cD63b8ptanM/VmzyevT4cm206KpUTNvaQ4UZHY1itR2m/8NSshv04wWciOVWjsmd6873ak0Ci8+f27SIkN9Lkqji4rGVY85VqgggbfXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741585851; c=relaxed/simple;
	bh=VZtNJTPpp9YgGKlcXzrrkoIGkU11vjwSWha/RhCgSFk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=lZwZc8OtMCz4BtTz0pEHHuyPlTX6UGj9KAhGoUaaZhrb+Fl7OWOQeITk14xJX06Yqv5bxbrETkIAYfchcI5RyvZl8blKfXESVhHj+3avi014zP4k6MLQyLgeGYt6FzNRNaLDcPqpA16iVFR950eyvgFozlxzid4vFUXc+I1yGSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jk0zpx5a; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741585841; x=1773121841;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=VZtNJTPpp9YgGKlcXzrrkoIGkU11vjwSWha/RhCgSFk=;
  b=jk0zpx5aYgK75vtikkHjfDNFMNHovSGCcsB31TE+hIGT/WcmYaeQcGrg
   f7+w1inJ3kvSQ05CEXIaTrK+DjCn0sX+QmGF9PmdzbWAqMdHk7EOt2fcY
   uTQSTye4xiyom1CtJIMJzSzh2l5E0VTz59+d9jOADMVdI+0UgmrCkjX26
   yPawZu7O0OiGtlbanG+9CoDnxQnsm95gWWhXyo5pus7fLKs5164JVWMSt
   nteAq7hO/qrr8MhqCnDi+VIeW+Xm0fviBJVRY33cJKGXXVGp0GDxpqB72
   jLldFWgc15g6866UVH9q46vTQMUkhci8gMYw7sTdTI+dYyFUrPgqst6tQ
   A==;
X-CSE-ConnectionGUID: BU72zyqkTYiNggdSLok81g==
X-CSE-MsgGUID: TLtrhZ3xRICwGx316iXnhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42756967"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42756967"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 22:50:39 -0700
X-CSE-ConnectionGUID: 3QrGvbiHSV6NGqa5HmaeFA==
X-CSE-MsgGUID: Ft3m/Mj0QEWjMOU4tQWgWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124055576"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Mar 2025 22:50:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 9 Mar 2025 22:50:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 9 Mar 2025 22:50:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 9 Mar 2025 22:50:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LthpEnbK5uIhQp3Mjt/3m2M229y5PTOq0Eq2Q/i1Pzu0fSvlb3odkIHvQdEbXBEMyrlwVueMZZAYMOUCl6WKESwuFaFjsEH4MGaroREpaGMvBwtNBidRe1Bh5p7znOxdtHJ6XmLKCqfUI5KyA5ZeXQJffuq7zbWk25P0Wq5HA4HXZ8dQtrWbBx7zcmdToEkvCX40kZ8BN8JQmPbgFFsWylgfSIAXqUYfgRwySxxXgOMWd8CSNcmz6CWCrFiWfqyoIEO/ON0IuBIKqo+VQMa523T6sEiDVUSGDoKsU/vm9PEJMElPrWdJzwGvkKf/mWNeMbM5QW1waXXiUDF2x5hXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wl+DWIbovObKIR0QHACal/4xYbi3+t0gXFb4P0ipeE0=;
 b=hueacuhZN5CbvJLGiVihnxYMowf7NKcul9lh+4GR360PYLOptfBaRi5U8AvS2C68EHeqnzasAYfjWTSioiWJZEk2LJh+g9jix2oZMTe6OlkUmxq8UtKVBn/Cg5CO/5bVQZP1LbWh6LXx2qBBzKDmMVjCc5jfeqZBq7eAWuWm1eNe3pg2sqAtSMJCyjsX9tvrAHrN031nNzGKyWrUMg+CUoLLLgyvVL39pGa/R+MStzh+G9dpbhaJT1sbXd+PhEcSpuuuVxWO2AwOreoe/zHfuCfGZJGnsKblfTXdb3sJuTpxMCpsuIcJYZMiNDySGsbF6QVpIG4ikGZGJEmFqEVzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB7131.namprd11.prod.outlook.com (2603:10b6:806:2b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 05:50:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 05:50:19 +0000
Date: Mon, 10 Mar 2025 13:50:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Alexei Starovoitov <ast@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [memcg]  01d37228d3:  netperf.Throughput_Mbps
 37.9% regression
Message-ID: <202503101254.cfd454df-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dea938a-e411-424e-04dc-08dd5f977028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?AmalymfLThFLKGNqdU/JxMcIqOcBw9TbADMAyzH88ZpqDcpYBLuQKINbmH?=
 =?iso-8859-1?Q?TxVi5OPL8K2Jk6PEk5T6rHw8nSPo7PYI1Swqqyu51vAhTLq639+KMpljSh?=
 =?iso-8859-1?Q?GUJ96VBK2tB772HbzzbNGhyyP5T22bBeVw6mflaETyys+b85mTzbW5Z7gK?=
 =?iso-8859-1?Q?68s/5Sx5raIRwCMKA7gEsZBzIkqI3hbgZt4LijRMeZ3DcVR/zjEV9+kgGb?=
 =?iso-8859-1?Q?ppTC3ZH9mUZ6/nXcx2qL2ybbwjLXaWVremoHCivgyuI6HqzaPMMwy00MXQ?=
 =?iso-8859-1?Q?/IQGnQpGZucy672rAnNA40hQ4pvJJVOjxjlTMY2XiXOmdDNAPQgQqZwHbr?=
 =?iso-8859-1?Q?0ooPA4jlYPgZ/pAXMsH4lVhjFK8rC7IoQEETzt21XxjMp9LPMn8bE9ti7s?=
 =?iso-8859-1?Q?M8A3pUH6m3+uGL0ROf7/q8EOBnn7EJa7aRWTgDA0aFY283ChQauApK80gj?=
 =?iso-8859-1?Q?v5NKZk5wff1wTqh2/LatbYrw/VcucYs+VN/OEQtBi9GDl2Rgd0mi1c+txh?=
 =?iso-8859-1?Q?9u8BvMxsFhgG0G4f9hb75d2HxLn4HlT9phPOY+fGUVFs4qXW7WT0tRHyb+?=
 =?iso-8859-1?Q?ll7NlXyjr14pz1rm/gbN05jCGIMyV7GySpQO63UXsnTpG9g6F5knM0fjVN?=
 =?iso-8859-1?Q?1fu0QnT0Jcum6Q8vF8V6KzUvgQsSrY9NhnQX96gZHHVqVjB8G4i3YJ6fHo?=
 =?iso-8859-1?Q?9Crgtzw53vA5xhteHM0VbqRTjTxhT+wu6BpwNSTVozdXi1fYty1BZf5FY/?=
 =?iso-8859-1?Q?H0hf+LYZKgjv/yITe58V4Ob+FHFESFI6TC8If1NMNyKZSLzOeQt3HLdufP?=
 =?iso-8859-1?Q?imMSGMf7Q2zHl1qDDLm5tzin1bS6MTLDH+7+SINZm4gbsY0mK2qbzdbCX+?=
 =?iso-8859-1?Q?g177Oy6cjXyXghQeRMlZDPoly1ALYdx43ib/MfUoJ/OKqQ9rzoaRDSguvi?=
 =?iso-8859-1?Q?lvN4GwsbkNctmTYZc7/wrEGE47Sr8N+VSVmVcuZj5sWwq3k7PB8yg+McLW?=
 =?iso-8859-1?Q?5GODwFBvKGYa5FfAp/xlWvkLZDJeg5T1ovllRg4835PaR6CJH4wLYoV4kN?=
 =?iso-8859-1?Q?Lq0EnePSvG1lS4st3znJn+ke1dLwzuXV1CbdqjNl4fq1Z5HPjeM/RwsKrk?=
 =?iso-8859-1?Q?28CFPfflAwDjUzbEw41UAJuA0lzpryXt8Po+8VIdxQjFKKjVCfTLhT4PBR?=
 =?iso-8859-1?Q?MkapYfs9Wja2vOos5dHCqGC1oIkujPlNj+REnO4XEIMAWLTvcjBll5obCC?=
 =?iso-8859-1?Q?2oC+cp2azevNAvu+UOJRO26PZYOue3OUs2m0SNW/KuwT6JG1Pu9cGUtX74?=
 =?iso-8859-1?Q?+xPgOmDIT+R0dA39jMJa3HoT+nOz+/aMfuqlTomar4+pMhkztFvmw/wjfD?=
 =?iso-8859-1?Q?tQRcxgOyl6BFnIuEcCcnMXlwGkOpSq6A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RJD2XCmDftI1JVZzrCCT2YYmjauaCGS+aYcZsS0ggqpoRbKXK2qtdD+hmn?=
 =?iso-8859-1?Q?qvlhnKvaxl+PgQOacAhTd3W7WXbWhIr4IazYRK1C6Lp7hrTX7tz3XidvKp?=
 =?iso-8859-1?Q?REJbOIXT7drZBxvehWDPFwmA1bxv8rsScphD3hf1vGhuhfny2+jgMEN9kZ?=
 =?iso-8859-1?Q?Jf7QTwbSTIZEyWTDjlKHRAMjmvnNoXYOr+hfIHB+rK5EEpeAIS4Fu7gVkQ?=
 =?iso-8859-1?Q?Biw/qSIV/A3A64jFvuVy2tjgxBBodPQnW9aFhOnJHrz8AT0LGilCk7qi9z?=
 =?iso-8859-1?Q?YzajD7qcdxQF9K6PCvVb0unbOuQwi8u6uu58ZHdrlpy0cMEXGVNqKTThNJ?=
 =?iso-8859-1?Q?7yGakIRS4u+K0YE8oQBrrjct/DeAo8+vuGAWtIRiv59+px4zRgNciQsM/S?=
 =?iso-8859-1?Q?AU5LCzKkqj/WxnBNa/M1D0rfeMIs2w/oMS3gk6xsWZ6m4N/jiRnL2tGpSB?=
 =?iso-8859-1?Q?A6gHRiUyfNJ6ZVC/z7HRet6+yKbvJfS+VKeEeNaaG5DS+7MJMzS6LZtTcj?=
 =?iso-8859-1?Q?hHBqXWZtXmHoLFQRivgeCDEsKmcb2FwOVzwFm6g0SAtwRJ9wSznQW/YJDe?=
 =?iso-8859-1?Q?kWfre4CTyclXfko1T+S3DH5XRPjs/6fhNBYT7RV0sSBJBrCeC5DfoPZY52?=
 =?iso-8859-1?Q?1WlH9HKwLMINDgUnd927vU2IyLXe30s4MWhDT4soBtV+InIJojgS59yoAs?=
 =?iso-8859-1?Q?66CfpI+3eKwX80G8RB5HHwgRel06onVQRBG2kW3p5VMT4OIy7/NalnAr8o?=
 =?iso-8859-1?Q?R/wFA3AXpsZMXoEVdiopUXead3lipFsM4UqbfNdSTDa67zW42PKyhoxp9/?=
 =?iso-8859-1?Q?Y1z2KOQQ5hTEkD9hE9vx/z8mxgIla89BxKT+GbKfmMTdBx2F9UdRmlZ0t4?=
 =?iso-8859-1?Q?UJnw2WSTWwH5sThPMFrII81oO55poHeDdD/8ZPLsy+wft0zrv5qceE1brt?=
 =?iso-8859-1?Q?hpAzhwIB4BkLQYKjueWH6bo0JK5qIUhioN6lUtMjper5NkZA5FZM/YzBXy?=
 =?iso-8859-1?Q?g71/PnThBaoYgwWm857efKeAl5cS5LpxgmuZg78eeZsYLah5fNLW0JcQwG?=
 =?iso-8859-1?Q?CQ8WaTs30gwlZnkv0Ui4bf1CDXT40cnb9h58z+9JdgddY1Yi0pDdPOlRrt?=
 =?iso-8859-1?Q?CyZFv3iPdITA78u+pQI0FVuNDEVoiF+n1MUE0fmi/XtMi/RUfrIdP/Jq8h?=
 =?iso-8859-1?Q?RE+YpCDlohG6L/sznK+IWDOtvFd0IFoE5SNaazD4f4G2cbKBQlq5zWZaWB?=
 =?iso-8859-1?Q?hqALk/snGJxUJQJlyxvo/Bw3SVrDbMdz4eTbqkaX8fRP/RsFXO7aVpkjLA?=
 =?iso-8859-1?Q?7WaUQCnKj8YqKwAgUNd3aqnmGc9IZBHoJrXTBWELqZc4BJwpzh1fQkIXWb?=
 =?iso-8859-1?Q?ZPzVRIQ017/0GkA7tsGXnEJyeJKf5Wbe3dFzllt6KAd5aLrXWP4lRfPVeF?=
 =?iso-8859-1?Q?gHqzBctiNNOdj2RKne8pOi+uDn2BtvDKFXVizYqiDqokdSZFLh54PDQG0d?=
 =?iso-8859-1?Q?LATUi5gDoGVvHql1V3M0h0KZ+hbDAbVzLANJbfu6ePjcKFwFn+l1PfB60F?=
 =?iso-8859-1?Q?QzE1dt2ev8Z1rvXSqNcarrxnDjzTLetcq1/7qwieNGrIQM8ICOHJyWpb+E?=
 =?iso-8859-1?Q?M/69Uy2Y5fWXjpsh5Bnbt2fezIxjrpw51q7bshpn1LHGznUIsjK/Xn2A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dea938a-e411-424e-04dc-08dd5f977028
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 05:50:19.3494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8n1p7Q3Kp5euHPh730PVtJ/lCJ79PddpxR6ruugj2N74nPsYdOjjOADGgR4lQ0sUTsHCRp1x1N2pK1+klVINYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7131
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 37.9% regression of netperf.Throughput_Mbps on:


commit: 01d37228d331047a0bbbd1026cec2ccabef6d88d ("memcg: Use trylock to access memcg stock_lock.")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 7ec162622e66a4ff886f8f28712ea1b13069e1aa]

testcase: netperf
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 50%
	cluster: cs-localhost
	test: TCP_MAERTS
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.mmapfork.ops_per_sec  63.5% regression                                        |
| test machine     | 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 8592+ (Emerald Rapids) with 256G memory            |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | nr_threads=100%                                                                                    |
|                  | test=mmapfork                                                                                      |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput  26.6% regression                                                  |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory         |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | ipc=socket                                                                                         |
|                  | iterations=4                                                                                       |
|                  | mode=threads                                                                                       |
|                  | nr_threads=100%                                                                                    |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | lmbench3: lmbench3.TCP.socket.bandwidth.64B.MB/sec  33.0% regression                               |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory        |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=development                                                                                   |
|                  | nr_threads=100%                                                                                    |
|                  | test=TCP                                                                                           |
|                  | test_memory_size=50%                                                                               |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.throughput  86.8% regression                                        |
| test machine     | 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 8592+ (Emerald Rapids) with 256G memory            |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | runtime=300s                                                                                       |
|                  | size=1T                                                                                            |
|                  | test=lru-shm                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps 39.9% improvement                                                 |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory         |
| test parameters  | cluster=cs-localhost                                                                               |
|                  | cpufreq_governor=performance                                                                       |
|                  | ip=ipv4                                                                                            |
|                  | nr_threads=200%                                                                                    |
|                  | runtime=300s                                                                                       |
|                  | test=TCP_MAERTS                                                                                    |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops  68.8% regression                                      |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                                   |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=thread                                                                                        |
|                  | nr_task=100%                                                                                       |
|                  | test=fallocate1                                                                                    |
+------------------+----------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503101254.cfd454df-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250310/202503101254.cfd454df-lkp@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-9.4/50%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/TCP_MAERTS/netperf

commit: 
  8c57b687e8 ("mm, bpf: Introduce free_pages_nolock()")
  01d37228d3 ("memcg: Use trylock to access memcg stock_lock.")

8c57b687e8331eb8 01d37228d331047a0bbbd1026ce 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     88798 ±  2%     +11.3%      98788        perf-c2c.HITM.total
     11324 ±  9%     +29.0%      14612        uptime.idle
 5.698e+09           +62.0%  9.228e+09        cpuidle..time
 6.409e+08 ±  2%     -13.9%  5.517e+08 ±  4%  cpuidle..usage
     12.79 ±  2%     +10.0       22.80        mpstat.cpu.all.idle%
      2.92 ±  2%      -0.4        2.55        mpstat.cpu.all.irq%
     68.81            -8.5       60.34        mpstat.cpu.all.sys%
      2.75            -1.1        1.61 ±  2%  mpstat.cpu.all.usr%
 8.542e+08           -36.5%  5.424e+08        numa-numastat.node0.local_node
 8.541e+08           -36.5%  5.425e+08        numa-numastat.node0.numa_hit
 8.262e+08           -39.5%  4.995e+08 ±  3%  numa-numastat.node1.local_node
 8.262e+08           -39.5%  4.996e+08 ±  3%  numa-numastat.node1.numa_hit
     13.41 ±  2%     +73.9%      23.32        vmstat.cpu.id
    110.55           -13.7%      95.45        vmstat.procs.r
   4461013 ±  2%     -12.9%    3883497 ±  4%  vmstat.system.cs
   2363200 ±  2%     -12.3%    2073470 ±  4%  vmstat.system.in
   6829101 ±  4%     -59.5%    2765741 ±  7%  numa-meminfo.node1.Active
   6829101 ±  4%     -59.5%    2765741 ±  7%  numa-meminfo.node1.Active(anon)
   7426985 ± 22%     -32.0%    5051150 ± 27%  numa-meminfo.node1.FilePages
   2764830 ± 11%     -92.4%     209706 ± 21%  numa-meminfo.node1.Mapped
   8991931 ± 18%     -29.4%    6351136 ± 20%  numa-meminfo.node1.MemUsed
     14170 ±  8%     -41.4%       8302 ±  5%  numa-meminfo.node1.PageTables
   6214806 ±  3%     -63.5%    2266447 ±  7%  numa-meminfo.node1.Shmem
   7077695 ±  2%     -57.6%    2999270 ±  5%  meminfo.Active
   7077695 ±  2%     -57.6%    2999270 ±  5%  meminfo.Active(anon)
   9791069           -41.0%    5777962 ±  2%  meminfo.Cached
   7238271 ±  2%     -56.5%    3151650 ±  5%  meminfo.Committed_AS
   2812962 ± 11%     -92.1%     223137 ± 10%  meminfo.Mapped
  12548272           -35.9%    8045050 ±  2%  meminfo.Memused
     22784 ±  3%     -27.4%      16539        meminfo.PageTables
   6286416 ±  2%     -63.8%    2273611 ±  7%  meminfo.Shmem
  12766197           -32.4%    8626151 ±  2%  meminfo.max_used_kB
 8.541e+08           -36.5%  5.427e+08        numa-vmstat.node0.numa_hit
 8.542e+08           -36.5%  5.425e+08        numa-vmstat.node0.numa_local
   1707145 ±  4%     -59.5%     691093 ±  7%  numa-vmstat.node1.nr_active_anon
   1856614 ± 22%     -32.0%    1262417 ± 27%  numa-vmstat.node1.nr_file_pages
    691174 ± 11%     -92.3%      52918 ± 21%  numa-vmstat.node1.nr_mapped
      3544 ±  8%     -41.3%       2080 ±  5%  numa-vmstat.node1.nr_page_table_pages
   1553569 ±  3%     -63.6%     566242 ±  7%  numa-vmstat.node1.nr_shmem
   1707145 ±  4%     -59.5%     691093 ±  7%  numa-vmstat.node1.nr_zone_active_anon
 8.262e+08           -39.5%  4.997e+08 ±  3%  numa-vmstat.node1.numa_hit
 8.262e+08           -39.5%  4.997e+08 ±  3%  numa-vmstat.node1.numa_local
     22880           -37.9%      14205 ±  2%  netperf.ThroughputBoth_Mbps
   1464367           -37.9%     909168 ±  2%  netperf.ThroughputBoth_total_Mbps
     22880           -37.9%      14205 ±  2%  netperf.Throughput_Mbps
   1464367           -37.9%     909168 ±  2%  netperf.Throughput_total_Mbps
     94030 ± 15%    +799.5%     845847 ± 16%  netperf.time.involuntary_context_switches
     35098           +11.3%      39072 ±  3%  netperf.time.minor_page_faults
      3619           -30.6%       2511        netperf.time.percent_of_cpu_this_job_got
     10591           -31.1%       7296        netperf.time.system_time
    307.43           -12.8%     268.12        netperf.time.user_time
 6.797e+08 ±  2%     -12.9%  5.922e+08 ±  4%  netperf.time.voluntary_context_switches
 3.352e+09           -37.9%  2.081e+09 ±  2%  netperf.workload
   1768827 ±  2%     -57.6%     749641 ±  5%  proc-vmstat.nr_active_anon
    198757            -8.2%     182368        proc-vmstat.nr_anon_pages
   6242276            +1.8%    6354594        proc-vmstat.nr_dirty_background_threshold
  12499816            +1.8%   12724725        proc-vmstat.nr_dirty_threshold
   2447152           -41.0%    1444280 ±  2%  proc-vmstat.nr_file_pages
  62798979            +1.8%   63923764        proc-vmstat.nr_free_pages
    703005 ± 11%     -92.0%      56220 ± 12%  proc-vmstat.nr_mapped
      5711 ±  3%     -27.3%       4153        proc-vmstat.nr_page_table_pages
   1570988 ±  2%     -63.8%     568192 ±  7%  proc-vmstat.nr_shmem
     33010            -7.1%      30660        proc-vmstat.nr_slab_reclaimable
     70932            -3.7%      68338        proc-vmstat.nr_slab_unreclaimable
   1768827 ±  2%     -57.6%     749641 ±  5%  proc-vmstat.nr_zone_active_anon
    351363 ± 32%     -79.4%      72278 ± 16%  proc-vmstat.numa_hint_faults
    337005 ± 34%     -82.9%      57525 ± 24%  proc-vmstat.numa_hint_faults_local
 1.679e+09           -37.9%  1.042e+09 ±  2%  proc-vmstat.numa_hit
 1.679e+09           -37.9%  1.042e+09 ±  2%  proc-vmstat.numa_local
    411756 ± 21%     -63.5%     150280 ± 34%  proc-vmstat.numa_pte_updates
  1.34e+10           -37.9%  8.324e+09 ±  2%  proc-vmstat.pgalloc_normal
   1393623 ±  8%     -23.4%    1067508        proc-vmstat.pgfault
  1.34e+10           -37.9%  8.323e+09 ±  2%  proc-vmstat.pgfree
  11265047           -21.1%    8884763        sched_debug.cfs_rq:/.avg_vruntime.avg
  13067285 ±  2%     -26.3%    9630862 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
  10675424           -23.9%    8119367 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.78           -13.5%       0.67 ±  2%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.37           +13.0%       0.42 ±  2%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.77           -13.5%       0.67 ±  2%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      0.37 ±  2%     +12.8%       0.42 ±  2%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
      8980 ± 10%     -14.6%       7667 ±  7%  sched_debug.cfs_rq:/.load.avg
  11265047           -21.1%    8884763        sched_debug.cfs_rq:/.min_vruntime.avg
  13067285 ±  2%     -26.3%    9630862 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
  10675424           -23.9%    8119367 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
      0.75           -11.7%       0.66        sched_debug.cfs_rq:/.nr_queued.avg
      0.33 ±  3%     +23.5%       0.40 ±  2%  sched_debug.cfs_rq:/.nr_queued.stddev
    265.16 ±  2%     +18.4%     313.92        sched_debug.cfs_rq:/.util_avg.stddev
    628.03           -17.3%     519.63 ±  2%  sched_debug.cfs_rq:/.util_est.avg
    313.28 ±  2%     +20.2%     376.59        sched_debug.cfs_rq:/.util_est.stddev
      5339 ±  5%     +79.9%       9606 ±  3%  sched_debug.cpu.avg_idle.min
      1441 ±  7%     -17.8%       1185 ± 17%  sched_debug.cpu.clock_task.stddev
      2929           -10.2%       2632        sched_debug.cpu.curr->pid.avg
      1380 ±  2%     +17.9%       1628        sched_debug.cpu.curr->pid.stddev
      0.76           -14.0%       0.66 ±  2%  sched_debug.cpu.nr_running.avg
      0.39 ±  2%     +11.2%       0.43        sched_debug.cpu.nr_running.stddev
   5279363           -14.3%    4526246 ±  3%  sched_debug.cpu.nr_switches.avg
 2.297e+10           -28.9%  1.634e+10 ±  2%  perf-stat.i.branch-instructions
      0.81            +0.1        0.93        perf-stat.i.branch-miss-rate%
 1.832e+08           -18.4%  1.495e+08 ±  2%  perf-stat.i.branch-misses
      1.64 ±  7%      +0.6        2.27 ± 13%  perf-stat.i.cache-miss-rate%
 6.943e+09           -34.2%   4.57e+09 ±  2%  perf-stat.i.cache-references
   4494744 ±  2%     -13.0%    3911893 ±  4%  perf-stat.i.context-switches
      2.51           +36.1%       3.42 ±  2%  perf-stat.i.cpi
 2.932e+11            -4.2%   2.81e+11        perf-stat.i.cpu-cycles
      2907 ± 16%   +1723.9%      53022 ± 13%  perf-stat.i.cpu-migrations
 1.167e+11           -29.3%  8.249e+10 ±  2%  perf-stat.i.instructions
      0.40           -25.8%       0.30 ±  2%  perf-stat.i.ipc
      0.04 ± 37%     -81.0%       0.01 ± 47%  perf-stat.i.major-faults
     35.11 ±  2%     -12.9%      30.57 ±  4%  perf-stat.i.metric.K/sec
      4270 ±  8%     -25.2%       3195        perf-stat.i.minor-faults
      4270 ±  8%     -25.2%       3195        perf-stat.i.page-faults
      0.80            +0.1        0.92        perf-stat.overall.branch-miss-rate%
      1.58 ±  7%      +0.6        2.20 ± 13%  perf-stat.overall.cache-miss-rate%
      2.51           +35.7%       3.41 ±  2%  perf-stat.overall.cpi
      0.40           -26.3%       0.29 ±  2%  perf-stat.overall.ipc
     10488           +13.8%      11937        perf-stat.overall.path-length
 2.289e+10           -28.9%  1.628e+10 ±  2%  perf-stat.ps.branch-instructions
 1.826e+08           -18.4%   1.49e+08 ±  2%  perf-stat.ps.branch-misses
  6.92e+09           -34.2%  4.555e+09 ±  2%  perf-stat.ps.cache-references
   4479829 ±  2%     -13.0%    3898858 ±  4%  perf-stat.ps.context-switches
 2.923e+11            -4.2%    2.8e+11        perf-stat.ps.cpu-cycles
      2901 ± 16%   +1721.9%      52859 ± 13%  perf-stat.ps.cpu-migrations
 1.164e+11           -29.3%  8.222e+10 ±  2%  perf-stat.ps.instructions
      0.04 ± 36%     -81.1%       0.01 ± 47%  perf-stat.ps.major-faults
      4246 ±  8%     -25.2%       3175        perf-stat.ps.minor-faults
      4246 ±  8%     -25.2%       3175        perf-stat.ps.page-faults
 3.515e+13           -29.3%  2.484e+13 ±  2%  perf-stat.total.instructions
      0.01 ± 36%   +4025.9%       0.37 ±133%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.sk_wait_data.tcp_recvmsg_locked
      0.10 ± 30%    +275.0%       0.38 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      0.21 ±134%  +26130.2%      54.60 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      0.13 ± 11%   +4401.2%       6.02 ± 34%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.19 ±150%  +29283.8%      54.51 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      0.02 ± 42%   +1730.4%       0.35 ± 60%  perf-sched.sch_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      0.09 ± 61%  +83629.3%      76.33 ± 49%  perf-sched.sch_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      2.00 ± 67%   +2740.7%      56.88 ± 93%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.06 ± 57%  +1.6e+05%      97.93 ± 48%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.37 ± 89%   +4177.4%      15.90 ± 19%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.61 ± 87%  +12221.9%      75.25 ± 56%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
      0.01 ± 21%    +289.8%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      3.12 ±102%   +5221.9%     166.03 ±  7%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.15 ±121%   +4038.3%       6.25 ± 10%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     62.06 ± 52%    +247.8%     215.86 ± 46%  perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.__sk_flush_backlog.tcp_recvmsg_locked.tcp_recvmsg
      0.03 ± 64%  +22004.8%       6.93 ±136%  perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.sk_wait_data.tcp_recvmsg_locked
     36.09 ± 57%    +524.7%     225.47 ± 52%  perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
    146.95 ± 33%    +643.8%       1092 ± 27%  perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      3.47 ± 33%  +29240.5%       1019        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.56 ± 65%     -88.1%       0.07 ±136%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
    173.81 ± 42%    +538.7%       1110 ± 46%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      0.89 ± 92%   +3331.6%      30.64 ± 72%  perf-sched.sch_delay.max.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      3.17 ±107%  +20724.1%     660.12 ± 82%  perf-sched.sch_delay.max.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      0.04 ± 17%     -62.0%       0.01 ± 48%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.01 ± 52%  +74985.5%       1509 ± 33%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     63.02 ±125%    +610.9%     448.01 ±  7%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    138.54 ± 15%    +265.7%     506.70 ± 15%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    783.25 ± 33%    +317.5%       3269 ± 31%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    437.71 ± 91%    +197.5%       1302 ± 34%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 44%   +1817.5%       0.26 ±  6%  perf-sched.total_sch_delay.average.ms
      1168 ± 33%    +265.4%       4269 ± 14%  perf-sched.total_sch_delay.max.ms
      0.27 ±  4%    +239.8%       0.93 ±  8%  perf-sched.total_wait_and_delay.average.ms
   6426495 ±  3%     -66.1%    2178159 ±  8%  perf-sched.total_wait_and_delay.count.ms
      4156 ±  6%     +97.9%       8227 ± 21%  perf-sched.total_wait_and_delay.max.ms
      0.26 ±  4%    +159.1%       0.68 ±  9%  perf-sched.total_wait_time.average.ms
      4156 ±  6%     +29.0%       5361 ±  6%  perf-sched.total_wait_time.max.ms
      0.34 ± 18%    +351.4%       1.53 ± 18%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      0.37 ±168%  +29845.0%     109.35 ± 12%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      5.01 ± 24%    +307.2%      20.41 ± 18%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.33 ±181%  +32588.3%     109.02 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      0.25 ± 77%  +60202.8%     152.67 ± 49%  perf-sched.wait_and_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
     37.01 ±  5%    +185.4%     105.64 ± 37%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     22.34 ± 59%   +1096.8%     267.33 ± 51%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.51 ± 11%    +657.4%     215.92 ± 65%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.47 ±111%   +5490.8%     305.70 ± 37%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    491.64 ±  7%    +244.5%       1693 ± 60%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      5.44 ± 13%    +581.2%      37.03 ± 16%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.37 ± 79%  +10884.8%     150.49 ± 56%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
      0.02 ± 14%    +561.9%       0.16 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    182.37 ±  9%    +210.0%     565.41 ±  6%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.44 ±113%   +2996.3%      13.52 ± 10%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    696.96 ±  6%     +47.1%       1025 ± 24%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1078 ± 73%    +218.9%       3438 ± 14%  perf-sched.wait_and_delay.count.__cond_resched.__release_sock.__sk_flush_backlog.tcp_recvmsg_locked.tcp_recvmsg
      5253 ± 23%     -64.0%       1891 ± 13%  perf-sched.wait_and_delay.count.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
    663.00 ±  8%     -54.6%     301.17 ± 19%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     12.50 ± 22%     -82.7%       2.17 ± 90%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.83 ±  7%     -79.3%       1.00 ±100%  perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.67 ±  8%     -79.4%       1.17 ±104%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    115.50 ±  5%     -78.9%      24.33 ± 13%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
    117.50 ±  4%     -73.8%      30.83 ±  8%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.33 ± 26%     -88.2%       1.33 ±141%  perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    123.83 ± 49%    +136.5%     292.83 ± 22%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      2233 ±  9%     -85.5%     323.17 ± 94%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     22.67 ±  4%     -63.2%       8.33 ± 49%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     12.50 ±  6%     -61.3%       4.83 ± 36%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     82.50 ±  4%     -71.5%      23.50 ± 17%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     19.17 ±  3%     -77.4%       4.33 ± 17%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      1001 ±  6%     -73.0%     270.67 ± 15%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1790 ± 32%     -99.6%       8.00 ± 19%  perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
   6330659 ±  3%     -65.9%    2157272 ±  8%  perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      5075 ± 13%     -64.9%       1781 ±  9%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     38453 ± 49%     -73.5%      10206 ± 16%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    766.67 ±  6%     -70.7%     224.33 ± 17%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    108.98 ± 77%    +421.4%     568.27 ± 31%  perf-sched.wait_and_delay.max.ms.__cond_resched.__release_sock.__sk_flush_backlog.tcp_recvmsg_locked.tcp_recvmsg
     73.56 ± 54%    +619.8%     529.51 ± 35%  perf-sched.wait_and_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
    163.67 ±108%   +1235.6%       2185 ± 27%  perf-sched.wait_and_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      1001          +103.6%       2038        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    174.95 ±126%   +1169.0%       2220 ± 46%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      6.13 ±115%  +21438.1%       1320 ± 82%  perf-sched.wait_and_delay.max.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      2788 ± 25%     -62.0%       1058 ±102%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    741.28 ± 14%    +125.8%       1673 ± 14%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1003          +251.0%       3523 ± 61%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    342.95 ±136%    +927.4%       3523 ± 39%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1008 ± 40%    +374.8%       4787 ± 65%  perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    207.61 ± 65%    +333.7%     900.49 ±  7%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    277.11 ± 15%    +268.2%       1020 ± 15%  perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      4119 ±  8%     +73.3%       7139 ± 26%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3146 ± 20%     +89.9%       5976 ± 18%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.37 ±104%    +369.8%       1.76 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.__sk_flush_backlog.tcp_recvmsg_locked.tcp_recvmsg
      0.02 ± 35%   +9586.0%       1.61 ±149%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.sk_wait_data.tcp_recvmsg_locked
      0.24 ± 13%    +383.1%       1.15 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      0.23 ±128%  +23772.2%      54.75 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      4.88 ± 24%    +195.1%      14.39 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.20 ±144%  +26532.7%      54.51 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      0.07 ± 35%   +2174.0%       1.58 ± 52%  perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      0.23 ± 29%  +33379.5%      76.33 ± 49%  perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
     37.01 ±  5%    +185.4%     105.64 ± 37%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     22.28 ± 59%    +765.9%     192.89 ± 46%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.39 ±101%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
     26.50 ± 12%    +500.0%     159.04 ± 67%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    498.82 ±  9%     -70.4%     147.68 ±114%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      5.41 ±112%   +3742.6%     207.76 ± 43%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    473.69 ±  3%    +177.8%       1315 ± 45%  perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      5.06 ±  7%    +317.1%      21.12 ± 13%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.76 ± 72%   +9807.3%      75.25 ± 56%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
      0.02 ± 10%    +690.9%       0.13 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    179.25 ±  8%    +122.8%     399.39 ±  5%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.29 ±108%   +2447.1%       7.27 ± 10%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     63.71 ± 51%    +604.4%     448.79 ± 18%  perf-sched.wait_time.max.ms.__cond_resched.__release_sock.__sk_flush_backlog.tcp_recvmsg_locked.tcp_recvmsg
      0.09 ±130%  +36184.9%      33.26 ±175%  perf-sched.wait_time.max.ms.__cond_resched.__release_sock.release_sock.sk_wait_data.tcp_recvmsg_locked
     38.34 ± 49%    +782.5%     338.36 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
    146.97 ± 33%    +643.7%       1092 ± 27%  perf-sched.wait_time.max.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      0.62 ± 57%     -89.2%       0.07 ±136%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
    173.81 ± 42%    +538.7%       1110 ± 46%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      1.41 ± 42%  +10955.3%     155.36 ± 76%  perf-sched.wait_time.max.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      4.70 ± 52%  +13934.8%     660.12 ± 82%  perf-sched.wait_time.max.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      2788 ± 25%     -62.0%       1058 ±102%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    741.28 ± 14%    +125.8%       1673 ± 14%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1002          +151.0%       2515 ± 44%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.55 ± 78%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      1688 ± 27%     +98.5%       3350 ± 22%  perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    341.76 ±136%    +587.1%       2348 ± 31%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    840.47 ± 28%    +309.7%       3443 ± 44%  perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    167.71 ± 40%    +174.9%     460.98 ±  6%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    138.56 ± 15%    +284.4%     532.69 ± 12%  perf-sched.wait_time.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      4119 ±  8%     +20.5%       4965 ±  7%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2922 ± 15%     +75.6%       5133 ± 10%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm


***************************************************************************************************
lkp-emr-2sp1: 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 8592+ (Emerald Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-emr-2sp1/mmapfork/stress-ng/60s

commit: 
  8c57b687e8 ("mm, bpf: Introduce free_pages_nolock()")
  01d37228d3 ("memcg: Use trylock to access memcg stock_lock.")

8c57b687e8331eb8 01d37228d331047a0bbbd1026ce 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  61300134 ±  4%     -11.2%   54464501 ±  3%  meminfo.max_used_kB
    100.42           +12.5%     112.99 ±  4%  uptime.boot
      1.93 ± 13%      -1.8        0.16 ± 14%  mpstat.cpu.all.soft%
     17.02 ±  2%      -5.5       11.49 ±  2%  mpstat.cpu.all.usr%
      5510 ± 48%    +195.8%      16296 ± 23%  perf-c2c.DRAM.remote
      1484 ± 49%    +138.9%       3545 ± 24%  perf-c2c.HITM.remote
     16.52 ±  2%     -32.4%      11.16 ±  2%  vmstat.cpu.us
     79660           -17.3%      65897 ±  4%  vmstat.system.cs
 3.332e+08 ±  2%     -54.9%  1.502e+08 ± 22%  numa-numastat.node0.local_node
 3.337e+08           -54.9%  1.504e+08 ± 22%  numa-numastat.node0.numa_hit
 3.329e+08           -72.4%   92005595 ± 52%  numa-numastat.node1.local_node
 3.335e+08           -72.4%   92128084 ± 52%  numa-numastat.node1.numa_hit
 3.205e+08           -51.8%  1.546e+08 ± 16%  numa-numastat.node2.local_node
 3.208e+08           -51.8%  1.547e+08 ± 16%  numa-numastat.node2.numa_hit
 3.173e+08 ±  2%     -73.1%   85455746 ± 45%  numa-numastat.node3.local_node
 3.176e+08 ±  2%     -73.1%   85574085 ± 45%  numa-numastat.node3.numa_hit
     12219           -63.1%       4511 ±  6%  stress-ng.mmapfork.ops
    202.59           -63.5%      73.93 ±  6%  stress-ng.mmapfork.ops_per_sec
     64.01           +19.7%      76.59 ±  7%  stress-ng.time.elapsed_time
     64.01           +19.7%      76.59 ±  7%  stress-ng.time.elapsed_time.max
   4100955           +10.0%    4509134 ±  4%  stress-ng.time.involuntary_context_switches
   1.3e+09           -63.1%  4.801e+08 ±  7%  stress-ng.time.minor_page_faults
     24509            +1.4%      24848        stress-ng.time.percent_of_cpu_this_job_got
     12906           +30.3%      16810 ±  6%  stress-ng.time.system_time
      2783 ±  2%     -20.4%       2216 ±  7%  stress-ng.time.user_time
    464362           -60.5%     183317 ±  5%  stress-ng.time.voluntary_context_switches
   5361967            +1.5%    5440921        proc-vmstat.nr_dirty_background_threshold
  10737045            +1.5%   10895145        proc-vmstat.nr_dirty_threshold
   7335955            -7.4%    6793970 ±  6%  proc-vmstat.nr_file_pages
  53947071            +1.4%   54723190        proc-vmstat.nr_free_pages
   6453955 ±  2%      -8.4%    5911969 ±  7%  proc-vmstat.nr_shmem
     60752            -5.1%      57679        proc-vmstat.nr_slab_reclaimable
    210937            -7.3%     195559 ±  3%  proc-vmstat.nr_slab_unreclaimable
 1.306e+09           -63.0%   4.83e+08 ±  7%  proc-vmstat.numa_hit
 1.305e+09           -63.0%  4.824e+08 ±  7%  proc-vmstat.numa_local
 1.505e+09           -63.0%  5.563e+08 ±  7%  proc-vmstat.pgalloc_normal
 1.301e+09           -63.0%  4.807e+08 ±  7%  proc-vmstat.pgfault
 1.504e+09           -63.1%   5.55e+08 ±  7%  proc-vmstat.pgfree
    616613 ± 23%     -54.7%     279591 ± 21%  proc-vmstat.pgreuse
    389483           -63.3%     142929 ±  6%  proc-vmstat.thp_fault_alloc
   5489228 ± 29%     +62.7%    8928447 ± 38%  numa-meminfo.node0.FilePages
  10213877 ± 31%     -50.5%    5060225 ± 37%  numa-meminfo.node3.Active
  10213877 ± 31%     -50.5%    5060225 ± 37%  numa-meminfo.node3.Active(anon)
   1849516 ± 31%     -58.7%     764271 ± 49%  numa-meminfo.node3.AnonHugePages
   2103284 ± 26%     -54.3%     961145 ± 33%  numa-meminfo.node3.AnonPages
   4500176 ± 30%     -62.0%    1708987 ± 31%  numa-meminfo.node3.AnonPages.max
   8719420 ± 29%     -52.1%    4173994 ± 41%  numa-meminfo.node3.FilePages
     28893 ± 23%     -38.5%      17773 ± 19%  numa-meminfo.node3.KernelStack
   6264266 ± 35%     -49.9%    3139363 ± 52%  numa-meminfo.node3.Mapped
  52318919 ±  6%     +11.7%   58419737 ±  3%  numa-meminfo.node3.MemFree
  13602300 ± 23%     -44.9%    7501482 ± 28%  numa-meminfo.node3.MemUsed
    146208 ± 31%     -56.0%      64374 ± 39%  numa-meminfo.node3.PageTables
    217141 ± 16%     -33.3%     144858 ± 12%  numa-meminfo.node3.SUnreclaim
   8085495 ± 33%     -49.3%    4097432 ± 39%  numa-meminfo.node3.Shmem
    279175 ± 13%     -32.4%     188683 ± 16%  numa-meminfo.node3.Slab
 3.341e+08           -55.0%  1.504e+08 ± 22%  numa-vmstat.node0.numa_hit
 3.335e+08 ±  2%     -55.0%  1.502e+08 ± 22%  numa-vmstat.node0.numa_local
 3.338e+08           -72.4%   92136512 ± 52%  numa-vmstat.node1.numa_hit
 3.332e+08           -72.4%   92014024 ± 52%  numa-vmstat.node1.numa_local
 3.211e+08           -51.8%  1.547e+08 ± 16%  numa-vmstat.node2.numa_hit
 3.208e+08           -51.8%  1.546e+08 ± 16%  numa-vmstat.node2.numa_local
   2548625 ± 32%     -50.5%    1261365 ± 41%  numa-vmstat.node3.nr_active_anon
    526621 ± 27%     -54.4%     239946 ± 36%  numa-vmstat.node3.nr_anon_pages
    904.50 ± 32%     -59.0%     370.93 ± 53%  numa-vmstat.node3.nr_anon_transparent_hugepages
   2173840 ± 30%     -52.2%    1040058 ± 45%  numa-vmstat.node3.nr_file_pages
  13073386 ±  6%     +11.8%   14619853 ±  4%  numa-vmstat.node3.nr_free_pages
     28795 ± 23%     -38.2%      17795 ± 20%  numa-vmstat.node3.nr_kernel_stack
     35596 ± 33%     -54.7%      16125 ± 43%  numa-vmstat.node3.nr_page_table_pages
   2015361 ± 33%     -49.3%    1020916 ± 44%  numa-vmstat.node3.nr_shmem
     53949 ± 16%     -32.8%      36254 ± 14%  numa-vmstat.node3.nr_slab_unreclaimable
   2548649 ± 32%     -50.5%    1261287 ± 41%  numa-vmstat.node3.nr_zone_active_anon
 3.179e+08 ±  2%     -73.1%   85558747 ± 45%  numa-vmstat.node3.numa_hit
 3.176e+08 ±  2%     -73.1%   85440409 ± 45%  numa-vmstat.node3.numa_local
  12034713 ±  2%     +27.0%   15288847 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.max
   1438718 ± 32%    +154.6%    3662687 ± 29%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     70491 ±190%     -95.0%       3512 ± 44%  sched_debug.cfs_rq:/.load.avg
    743319 ±202%     -97.4%      19566 ±124%  sched_debug.cfs_rq:/.load.stddev
  12034713 ±  2%     +27.0%   15288847 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
   1438712 ± 32%    +154.6%    3662687 ± 29%  sched_debug.cfs_rq:/.min_vruntime.stddev
    222.33 ±  6%     -11.2%     197.52 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
     60.33 ± 23%     -50.9%      29.61 ± 22%  sched_debug.cfs_rq:/.util_est.avg
    139547 ± 15%     +69.7%     236820 ± 23%  sched_debug.cpu.avg_idle.stddev
    179893 ±  2%     -65.7%      61761 ±  3%  sched_debug.cpu.curr->pid.avg
    192433           -64.8%      67681 ±  4%  sched_debug.cpu.curr->pid.max
     38238 ± 26%     -72.7%      10420 ±  8%  sched_debug.cpu.curr->pid.stddev
    868454 ± 22%     +35.9%    1180661 ± 19%  sched_debug.cpu.max_idle_balance_cost.max
     29004 ± 42%    +201.6%      87490 ± 36%  sched_debug.cpu.max_idle_balance_cost.stddev
     10283           -12.3%       9017 ±  3%  sched_debug.cpu.nr_switches.avg
      8342 ±  4%     -24.6%       6290 ±  4%  sched_debug.cpu.nr_switches.min
      1412 ± 47%     +60.5%       2267 ± 35%  sched_debug.cpu.nr_switches.stddev
     57.00 ± 39%     -50.0%      28.50 ± 49%  sched_debug.cpu.nr_uninterruptible.max
      7.07 ±  7%     -34.3%       4.65 ± 18%  sched_debug.cpu.nr_uninterruptible.stddev
 4.289e+10           -70.6%  1.263e+10 ±  2%  perf-stat.i.branch-instructions
      0.27            +0.1        0.40 ±  4%  perf-stat.i.branch-miss-rate%
  86292456 ±  2%     -49.7%   43436183 ±  6%  perf-stat.i.branch-misses
     52.01            -8.7       43.30 ±  5%  perf-stat.i.cache-miss-rate%
  1.09e+09           -72.1%  3.043e+08 ± 15%  perf-stat.i.cache-misses
 2.089e+09           -66.0%  7.105e+08 ± 20%  perf-stat.i.cache-references
     81002           -21.4%      63704 ±  5%  perf-stat.i.context-switches
      3.27          +240.9%      11.16 ±  2%  perf-stat.i.cpi
  7.08e+11            +1.7%    7.2e+11        perf-stat.i.cpu-cycles
      7221 ±  5%     -73.5%       1917 ±  5%  perf-stat.i.cpu-migrations
    642.37          +274.4%       2404 ± 18%  perf-stat.i.cycles-between-cache-misses
 2.136e+11           -70.2%  6.365e+10 ±  2%  perf-stat.i.instructions
      0.32           -63.8%       0.12 ±  3%  perf-stat.i.ipc
      1.64 ± 59%     -94.6%       0.09 ± 88%  perf-stat.i.major-faults
      2.34 ±  4%    -100.0%       0.00        perf-stat.i.metric.K/sec
    314368 ±  2%     -68.1%     100262 ±  2%  perf-stat.i.minor-faults
    314370 ±  2%     -68.1%     100263 ±  2%  perf-stat.i.page-faults
      0.20 ±  2%      +0.1        0.32 ±  9%  perf-stat.overall.branch-miss-rate%
     51.98            -8.5       43.45 ±  5%  perf-stat.overall.cache-miss-rate%
      3.33          +241.0%      11.35 ±  2%  perf-stat.overall.cpi
    651.94          +273.2%       2432 ± 18%  perf-stat.overall.cycles-between-cache-misses
      0.30           -70.7%       0.09 ±  2%  perf-stat.overall.ipc
   4.2e+10           -70.2%  1.251e+10 ±  2%  perf-stat.ps.branch-instructions
  83007046 ±  2%     -52.3%   39570947 ±  8%  perf-stat.ps.branch-misses
 1.068e+09           -71.6%   3.03e+08 ± 16%  perf-stat.ps.cache-misses
 2.054e+09           -65.7%  7.048e+08 ± 20%  perf-stat.ps.cache-references
     79568           -19.1%      64350 ±  3%  perf-stat.ps.context-switches
 6.961e+11            +2.7%  7.152e+11        perf-stat.ps.cpu-cycles
      7079 ±  5%     -73.2%       1894 ±  5%  perf-stat.ps.cpu-migrations
 2.091e+11           -69.9%  6.303e+10 ±  2%  perf-stat.ps.instructions
      1.56 ± 59%     -97.0%       0.05 ± 74%  perf-stat.ps.major-faults
    305825 ±  3%     -68.3%      97054        perf-stat.ps.minor-faults
    305826 ±  3%     -68.3%      97054        perf-stat.ps.page-faults
 1.349e+13           -64.1%  4.846e+12 ±  8%  perf-stat.total.instructions
     28.19 ± 10%    +366.8%     131.59 ± 88%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pmd_alloc
     34.75 ± 15%     +77.7%      61.75 ± 36%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pud_alloc
     34.03 ± 29%     +54.9%      52.72 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pgd_alloc
     24.31 ±  9%    +198.8%      72.64 ± 33%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
     25.40 ±110%    +244.6%      87.53 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.allocate_slab.___slab_alloc
     41.64 ± 10%     +41.3%      58.86 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
     33.33 ±  8%    +213.7%     104.54 ± 68%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
     35.00 ± 28%     +67.7%      58.69 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_node_noprof.__get_vm_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
      6.70 ± 98%    +367.0%      31.28 ± 71%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
     31.30 ± 30%    +619.1%     225.07 ±179%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
     34.75 ± 19%    +198.6%     103.76 ± 94%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     38.41 ± 10%     +65.4%      63.55 ± 24%  perf-sched.sch_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
     44.17 ±  6%     +57.3%      69.45 ± 25%  perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
     30.30 ± 17%     +41.9%      43.00 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node.dup_task_struct
      1.48 ± 33%    +818.4%      13.56 ±109%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     32.02 ± 28%     +98.3%      63.48 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
     33.07 ± 11%    +184.3%      94.01 ± 52%  perf-sched.sch_delay.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
     30.00 ±  9%    +239.8%     101.93 ± 52%  perf-sched.sch_delay.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      6.51 ± 31%    +348.8%      29.20 ± 40%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.__mm_populate.vm_mmap_pgoff.do_syscall_64
      1.37 ±123%    +609.8%       9.72 ± 70%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
     31.18 ±  6%    +197.2%      92.68 ± 52%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
     30.95 ± 10%    +282.4%     118.34 ± 67%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
     33.18 ±  9%    +166.0%      88.25 ± 41%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
     39.63 ±  6%     +67.8%      66.50 ± 21%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
     38.72 ±  9%     +62.3%      62.86 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
     37.73 ± 12%     +62.0%      61.14 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_file_vma_batch_add.free_pgtables.exit_mmap
      8.30 ± 50%    +275.7%      31.20 ± 43%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_link_file.__mmap_new_vma.__mmap_region
      0.67 ± 50%    +290.9%       2.61 ± 46%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      4.39 ±101%    +698.1%      35.06 ± 49%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.18 ± 25%     +60.7%      61.36 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.path_put.exit_fs.do_exit
      0.48 ±135%   +2338.4%      11.59 ± 64%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.60 ±152%   +1831.8%      11.56 ± 89%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     42.64 ±  7%     +52.1%      64.85 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
     21.22 ± 35%     -47.9%      11.05 ± 56%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     35.21 ± 16%    +339.5%     154.78 ±119%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_dup_alloc.isra.0
      8.71 ± 54%    +270.1%      32.24 ± 40%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
      7.82 ± 51%    +285.6%      30.14 ± 40%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.__shmem_file_setup
      1.73 ±141%    +785.8%      15.36 ± 63%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
     35.74 ± 31%    +484.4%     208.89 ±103%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
     31.90 ± 10%    +214.3%     100.25 ± 54%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
     25.61 ± 29%    +644.5%     190.67 ±164%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.copy_signal.copy_process.kernel_clone
     37.35 ± 13%     +61.0%      60.16 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.dup_mm.constprop.0
      0.75 ±223%   +1417.4%      11.45 ±120%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      9.62 ± 46%    +243.7%      33.06 ± 36%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
     27.94 ± 13%    +207.2%      85.84 ± 27%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
      7.69 ± 48%    +288.3%      29.87 ± 34%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
      8.08 ± 23%    +264.7%      29.45 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      1.21 ±172%   +1936.5%      24.64 ± 77%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
     32.66 ±  9%    +184.8%      93.02 ± 44%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
     38.89 ± 11%     +85.5%      72.16 ± 34%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      4.15 ±223%   +1063.1%      48.31 ± 33%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
     32.51 ± 17%    +291.0%     127.10 ± 66%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
     44.38 ± 16%    +262.6%     160.91 ±101%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.mm_init.dup_mm
     35.49 ± 15%     +67.2%      59.34 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
     48.78 ± 10%     +24.2%      60.57 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
     45.39 ±  8%     +53.8%      69.81 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
     42.58 ± 30%    +283.5%     163.28 ±140%  perf-sched.sch_delay.avg.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
     14.92 ±101%    +260.8%      53.85 ± 29%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     35.61 ± 16%    +140.7%      85.71 ± 76%  perf-sched.sch_delay.avg.ms.__cond_resched.uprobe_start_dup_mmap.dup_mm.constprop.0
     29.84 ± 17%     +83.0%      54.61 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     46.38 ±  7%     +35.6%      62.87 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
     11.27 ± 11%    +933.5%     116.43 ±119%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.15 ± 11%    +459.2%      62.34 ± 58%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     34.39 ±  9%     +59.8%      54.95 ±  9%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     30.52 ± 18%     +41.8%      43.27 ± 10%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      2.28 ± 49%   +1270.2%      31.31 ±114%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      7.76 ± 35%    +144.3%      18.95 ± 31%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     38.01 ± 23%    +151.3%      95.53 ± 46%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
     29.46 ± 14%    +201.3%      88.77 ± 63%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
     29.91 ± 10%    +134.2%      70.04 ± 23%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
     32.15 ± 24%    +102.8%      65.18 ± 23%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
     36.21 ± 20%     +56.2%      56.56 ± 27%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
     14.35 ± 96%    +344.7%      63.80 ± 23%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final
      0.08 ± 57%   +5932.7%       4.71 ±121%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     37.96 ± 13%     +84.3%      69.97 ± 37%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.77 ± 39%     -70.7%       1.40 ± 99%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown]
    111.67 ± 20%     +60.7%     179.44 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pgd_alloc
    445.63 ± 20%    +632.3%       3263 ± 57%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
     99.05 ± 17%     +72.4%     170.81 ± 24%  perf-sched.sch_delay.max.ms.__cond_resched.__dentry_kill.dput.__fput.task_work_run
    483.91 ± 16%    +592.2%       3349 ± 56%  perf-sched.sch_delay.max.ms.__cond_resched.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff
    148.35 ± 21%   +1202.9%       1932 ±113%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_node_noprof.__get_vm_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
    362.40 ± 14%    +921.6%       3702 ± 62%  perf-sched.sch_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
    257.63 ±145%   +1627.8%       4451 ±147%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    260.06 ± 33%   +4874.0%      12935 ±112%  perf-sched.sch_delay.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
    271.64 ± 21%   +5159.3%      14286 ±101%  perf-sched.sch_delay.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
     33.52 ± 39%    +228.4%     110.08 ± 37%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.__mm_populate.vm_mmap_pgoff.do_syscall_64
    104.84 ± 33%    +577.7%     710.49 ±173%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      1.80 ±104%   +2305.8%      43.38 ± 67%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
     19.72 ± 46%    +391.9%      97.03 ± 42%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
    222.08 ± 11%   +5794.4%      13090 ±108%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
    274.25 ±  5%   +5170.7%      14454 ±111%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
     73.44 ± 48%    +113.6%     156.88 ± 21%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_file_vma_batch_final.free_pgtables.exit_mmap
     23.85 ± 50%    +249.4%      83.33 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_link_file.__mmap_new_vma.__mmap_region
     92.73 ± 29%     +71.5%     159.00 ± 24%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      4.07 ± 36%    +430.7%      21.62 ± 42%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      5.62 ±121%   +1304.8%      78.91 ± 39%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.01 ±140%   +5492.8%      56.59 ± 42%  perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.75 ±163%   +5258.4%      40.24 ± 77%  perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     34.61 ± 78%    +215.9%     109.35 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
     44.21 ± 76%    +252.4%     155.83 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.dup_task_struct.copy_process.kernel_clone
      1.78 ± 95%    +591.1%      12.30 ± 60%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.__khugepaged_enter.do_huge_pmd_anonymous_page.__handle_mm_fault
     35.91 ± 77%    +159.0%      93.00 ± 31%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.__shmem_file_setup
      3.16 ±154%   +1390.5%      47.14 ± 53%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
    330.41 ± 24%   +4614.7%      15577 ±102%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      0.75 ±223%   +4317.2%      33.33 ±110%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
     37.23 ± 75%    +142.7%      90.36 ± 33%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
    145.93 ± 24%   +9241.3%      13631 ±108%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
     43.53 ± 79%    +166.1%     115.84 ± 31%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      3.38 ±203%   +1420.1%      51.46 ± 60%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
    224.58 ± 18%    +681.9%       1755 ±105%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      4.15 ±223%   +2488.3%     107.50 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
    411.45 ±112%   +3129.7%      13288 ±108%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
    428.93 ± 16%    +707.9%       3465 ± 50%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
     40.64 ± 80%    +240.6%     138.43 ± 54%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_inode_unacct_blocks.shmem_undo_range.shmem_evict_inode.evict
    459.95 ± 14%    +804.7%       4161 ± 57%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
     91.90 ± 34%    +659.5%     697.98 ±177%  perf-sched.sch_delay.max.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
     45.16 ± 95%    +176.9%     125.05 ± 37%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     56.92 ± 47%    +144.0%     138.85 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap.__mmput
    319.32 ± 23%    +445.2%       1740 ± 63%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
    348.62 ± 21%    +721.6%       2864 ± 53%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
     27.43 ± 75%   +1687.1%     490.13 ±145%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1363 ± 60%   +1094.4%      16281 ±102%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    317.08 ± 29%    +578.7%       2151 ± 82%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    451.54 ± 16%    +831.0%       4203 ± 54%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    142.47 ± 23%     +50.7%     214.69 ± 26%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
    298.70 ± 20%    +754.7%       2553 ± 53%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    717.11 ± 59%   +1529.8%      11687 ±127%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     39.28 ± 45%    +302.2%     158.00 ±122%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     17.73 ±112%    +561.1%     117.22 ± 58%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final
     58.28 ± 53%   +2240.3%       1363 ± 71%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     47.17 ± 95%  +15545.3%       7379 ±104%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    314.10 ± 16%   +4088.0%      13154 ±100%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     36.28 ± 78%    +123.3%      81.01 ± 32%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     35.75 ±  9%     +58.8%      56.76 ±  4%  perf-sched.total_sch_delay.average.ms
      1769 ± 70%    +860.7%      17004 ± 96%  perf-sched.total_sch_delay.max.ms
     81.84 ±  8%     +61.4%     132.10 ±  9%  perf-sched.total_wait_and_delay.average.ms
    446898 ±  7%     +98.4%     886795 ± 17%  perf-sched.total_wait_and_delay.count.ms
      3840 ± 62%    +804.8%      34745 ± 92%  perf-sched.total_wait_and_delay.max.ms
     46.09 ±  6%     +63.5%      75.34 ± 13%  perf-sched.total_wait_time.average.ms
      3062 ± 25%    +607.8%      21677 ± 69%  perf-sched.total_wait_time.max.ms
     32.02 ±141%    +823.3%     295.64 ± 79%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pmd_alloc
     81.86 ± 10%     +41.9%     116.16 ±  9%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
     28.49 ±141%    +696.0%     226.79 ± 53%  perf-sched.wait_and_delay.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      9.67 ± 17%    +170.4%      26.14 ± 56%  perf-sched.wait_and_delay.avg.ms.__cond_resched.folio_zero_user.vma_alloc_anon_folio_pmd.__do_huge_pmd_anonymous_page.__handle_mm_fault
     80.77 ± 79%    +507.2%     490.43 ±109%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
     14.65 ±223%   +1421.7%     222.99 ± 55%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
     42.27 ±100%    +374.5%     200.59 ± 42%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
     31.22 ±141%    +755.9%     267.22 ± 63%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
    384.40 ± 40%     -75.2%      95.38 ±145%  perf-sched.wait_and_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
     96.32 ± 10%     +24.3%     119.73 ± 13%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
     90.77 ±  8%     +50.2%     136.29 ± 11%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
     37.70 ±  7%    +544.1%     242.86 ± 52%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.15 ±  4%    +572.3%       0.98 ± 56%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
    133.70 ±  9%    +250.2%     468.27 ± 64%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    571.39 ±  7%    +162.7%       1501 ± 69%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
    457.45           +55.6%     711.90 ± 45%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    114.14 ±  4%    +453.2%     631.37 ± 45%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     83.38 ± 10%     +86.2%     155.25 ± 39%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     70.48 ±  2%    +337.6%     308.40 ± 49%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     29.17 ±142%   +1403.4%     438.50 ± 28%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pmd_alloc
      5278 ± 11%     -88.4%     610.67 ±141%  perf-sched.wait_and_delay.count.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
    304.50 ±142%    +923.2%       3115 ± 18%  perf-sched.wait_and_delay.count.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      3084 ± 17%     -83.9%     495.67 ±142%  perf-sched.wait_and_delay.count.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      5591 ± 21%    +132.7%      13007 ± 16%  perf-sched.wait_and_delay.count.__cond_resched.folio_zero_user.vma_alloc_anon_folio_pmd.__do_huge_pmd_anonymous_page.__handle_mm_fault
    286.67 ±223%   +1574.3%       4799 ± 17%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
    192.50 ±100%    +938.4%       1998 ± 18%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
     97.50 ±142%    +386.3%     474.17 ± 15%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
    483.83 ± 26%     -55.7%     214.50 ± 46%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.mm_init.dup_mm
     31620 ± 11%   +1464.8%     494787 ± 16%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
     74608 ±  7%     -60.6%      29368 ± 25%  perf-sched.wait_and_delay.count.__cond_resched.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
    690.50 ± 17%     -59.6%     279.17 ±102%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      1929 ± 20%     -59.0%     790.50 ±104%  perf-sched.wait_and_delay.count.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
     34736 ±  7%     -27.1%      25322 ± 17%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     11.00 ±  9%     +87.9%      20.67 ± 17%  perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     24.17 ±  9%     +98.6%      48.00 ± 15%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     13.50 ±  9%    +300.0%      54.00 ±102%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     43.50 ±  8%    +139.8%     104.33 ± 16%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
     20294 ± 11%     -31.3%      13937 ± 19%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    762.80 ±145%   +2865.9%      22623 ±136%  perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pmd_alloc
    891.25 ± 20%    +511.4%       5448 ± 47%  perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
    967.82 ± 16%    +556.8%       6356 ± 57%  perf-sched.wait_and_delay.max.ms.__cond_resched.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff
    724.81 ± 14%    +848.3%       6873 ± 59%  perf-sched.wait_and_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
    772.30 ±145%   +3714.2%      29456 ± 96%  perf-sched.wait_and_delay.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
    762.95 ±223%   +4012.3%      31374 ±101%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      1069 ±132%   +2709.8%      30059 ± 96%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
    512.94 ±188%   +5166.8%      27015 ±107%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
    857.86 ± 16%    +679.2%       6684 ± 55%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
    919.89 ± 14%    +764.9%       7956 ± 59%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
    914.96 ± 12%   +2199.9%      21043 ± 88%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    321.23 ± 19%    +594.3%       2230 ± 74%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      2838 ± 53%   +1052.5%      32709 ±102%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    903.08 ± 16%   +1170.0%      11469 ± 67%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1727 ± 17%   +1533.4%      28221 ± 97%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1050         +1308.0%      14792 ±118%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      1567 ±  8%   +1368.0%      23016 ± 87%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1730 ± 53%   +1443.6%      26709 ± 97%  perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2200 ± 22%   +1164.5%      27827 ±105%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     53.28 ± 19%    +207.9%     164.05 ± 72%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pmd_alloc
     35.30 ± 12%    +208.9%     109.06 ± 48%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
     23.94 ±107%    +265.6%      87.53 ± 42%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.allocate_slab.___slab_alloc
     40.22 ± 10%     +42.5%      57.29 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      1.32 ±206%   +2168.2%      29.87 ± 74%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
     38.38 ± 10%     +59.5%      61.24 ± 23%  perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
     45.35 ±  9%     +45.5%      65.96 ± 24%  perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      4.21 ± 15%    +280.3%      16.00 ± 91%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     49.28 ±  9%    +132.5%     114.60 ± 61%  perf-sched.wait_time.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
     49.10 ±  7%    +154.3%     124.87 ± 53%  perf-sched.wait_time.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.47 ±107%   +5995.1%      28.58 ± 39%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.__mm_populate.vm_mmap_pgoff.do_syscall_64
      0.60 ±177%   +5535.0%      33.81 ± 48%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
     56.26 ± 18%     +95.3%     109.85 ± 54%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
     45.90 ± 12%    +198.5%     137.01 ± 62%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
     50.84 ±  9%    +114.6%     109.07 ± 45%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
     40.23 ±  7%     +60.7%      64.65 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
     39.00 ±  8%     +57.8%      61.55 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
     37.73 ± 12%     +56.6%      59.08 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_file_vma_batch_add.free_pgtables.exit_mmap
      1.15 ±196%   +2575.9%      30.79 ± 44%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_link_file.__mmap_new_vma.__mmap_region
      0.19 ± 64%    +303.8%       0.76 ± 28%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     38.18 ± 25%     +60.7%      61.36 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.exit_fs.do_exit
      0.46 ±140%   +1957.9%       9.55 ± 63%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.14 ±202%   +7445.0%      10.61 ± 94%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     43.32 ±  7%     +44.6%      62.65 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.75 ± 30%   +1444.8%      11.62 ± 63%  perf-sched.wait_time.avg.ms.__cond_resched.folio_zero_user.vma_alloc_anon_folio_pmd.__do_huge_pmd_anonymous_page.__handle_mm_fault
     49.62 ± 32%     -77.7%      11.05 ± 56%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.48 ± 95%   +6560.8%      32.08 ± 40%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
      4.89 ±174%    +564.9%      32.54 ± 43%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.shmem_alloc_inode.alloc_inode.new_inode
      2.54 ±147%   +1068.9%      29.69 ± 41%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.__shmem_file_setup
      0.59 ±138%   +2094.7%      12.94 ± 81%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
     50.54 ±  9%    +142.8%     122.73 ± 56%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
     28.71 ± 37%    +576.9%     194.34 ±165%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.copy_signal.copy_process.kernel_clone
      0.52 ±130%   +6185.7%      32.63 ± 36%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
     41.66 ± 25%    +150.9%     104.53 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
      1.48 ±147%   +1847.1%      28.80 ± 35%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
      0.81 ± 48%   +3501.5%      29.20 ± 42%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.31 ±172%   +7598.9%      24.05 ± 81%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
     50.76 ±  8%    +111.9%     107.57 ± 40%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
     38.89 ± 11%     +79.6%      69.87 ± 36%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      4.15 ±223%   +1063.1%      48.31 ± 33%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
     51.54 ± 18%    +171.9%     140.12 ± 61%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
    384.38 ± 40%     -67.3%     125.66 ± 96%  perf-sched.wait_time.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
     35.52 ± 15%     +67.0%      59.33 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
     47.53 ± 10%     +24.5%      59.17 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
     45.37 ±  8%     +46.5%      66.48 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
     37.68 ±  7%    +541.9%     241.86 ± 52%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     42.58 ± 30%    +283.5%     163.28 ±140%  perf-sched.wait_time.avg.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      5.03 ±115%    +947.4%      52.66 ± 29%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     31.31 ± 18%     +82.2%      57.03 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     46.45 ±  6%     +29.1%      59.95 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.15 ±  4%    +572.3%       0.98 ± 56%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
    122.43 ±  9%    +187.4%     351.84 ± 46%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.72 ± 52%   +3352.8%      59.24 ± 60%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     32.83 ±  9%     +63.7%      53.76 ± 10%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     12.22 ± 20%    +183.3%      34.61 ± 33%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     30.44 ± 18%     +35.2%      41.15 ± 13%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    563.63 ±  7%    +163.0%       1482 ± 70%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     38.02 ± 23%    +151.3%      95.54 ± 46%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
     45.48 ± 12%     +83.7%      83.53 ± 26%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
     46.77 ± 14%    +134.7%     109.78 ± 67%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
     14.35 ± 96%    +344.7%      63.80 ± 23%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final
     28.53 ± 31%    +752.9%     243.34 ±109%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    457.42           +55.6%     711.84 ± 45%  perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      5.01 ±  3%    +105.7%      10.31 ± 60%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    114.07 ±  4%    +452.5%     630.20 ± 45%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     45.42 ±  8%     +87.8%      85.28 ± 40%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.09 ± 77%    +416.8%      10.82 ± 56%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     70.30 ±  2%    +335.3%     306.05 ± 49%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    974.31 ± 50%   +1374.0%      14360 ±104%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
    445.63 ± 20%    +511.4%       2724 ± 47%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
     99.05 ± 17%     +72.4%     170.81 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.__fput.task_work_run
    483.91 ± 16%    +556.8%       3178 ± 57%  perf-sched.wait_time.max.ms.__cond_resched.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff
      5.26 ±206%   +1212.1%      69.05 ± 45%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
     35.48 ±172%  +15060.6%       5378 ±205%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.vmstat_start.seq_read_iter.proc_reg_read_iter
    362.40 ± 14%    +848.3%       3436 ± 59%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
      1433 ± 86%    +864.9%      13835 ±102%  perf-sched.wait_time.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      1520 ± 41%    +969.1%      16259 ± 90%  perf-sched.wait_time.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      6.37 ± 99%   +1535.9%     104.18 ± 31%  perf-sched.wait_time.max.ms.__cond_resched.down_read.__mm_populate.vm_mmap_pgoff.do_syscall_64
    104.84 ± 33%    +577.7%     710.49 ±173%  perf-sched.wait_time.max.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      3.60 ±177%   +2595.0%      97.03 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
      1546 ± 50%    +953.2%      16284 ±100%  perf-sched.wait_time.max.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
     73.44 ± 48%    +113.6%     156.88 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_file_vma_batch_final.free_pgtables.exit_mmap
      5.75 ±183%   +1348.7%      83.33 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_link_file.__mmap_new_vma.__mmap_region
     92.73 ± 29%     +71.5%     159.00 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      3.00 ± 54%    +545.4%      19.38 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      1.00 ±143%   +5554.3%      56.59 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.27 ±210%  +13877.5%      38.00 ± 86%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      1935 ± 67%     -87.7%     238.19 ±173%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      6.59 ±123%   +1558.4%     109.35 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
     44.21 ± 76%    +269.4%     163.33 ± 33%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.dup_task_struct.copy_process.kernel_clone
     26.78 ±122%    +247.2%      93.00 ± 31%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.__shmem_file_setup
      0.89 ±150%   +4891.0%      44.44 ± 64%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      0.75 ±223%   +2718.3%      21.27 ±180%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      4.17 ±127%   +2067.1%      90.36 ± 33%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
    228.57 ± 45%   +5935.1%      13794 ±106%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
     13.81 ± 36%    +738.7%     115.84 ± 31%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.49 ±137%  +10424.4%      51.41 ± 60%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
    224.58 ± 18%    +604.8%       1582 ±108%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      4.15 ±223%   +2488.3%     107.50 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
    428.93 ± 16%    +679.2%       3342 ± 55%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
     40.64 ± 80%    +240.6%     138.43 ± 54%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_unacct_blocks.shmem_undo_range.shmem_evict_inode.evict
    459.95 ± 14%    +764.9%       3978 ± 59%  perf-sched.wait_time.max.ms.__cond_resched.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
    914.95 ± 12%   +1849.7%      17838 ± 86%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     91.90 ± 34%    +659.5%     697.98 ±177%  perf-sched.wait_time.max.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
     24.81 ±116%    +384.4%     120.21 ± 37%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    270.14 ± 19%   +2674.2%       7494 ±140%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     56.92 ± 47%    +144.0%     138.85 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap.__mmput
    549.17 ± 71%    +379.4%       2632 ± 89%  perf-sched.wait_time.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
    319.32 ± 23%    +361.3%       1472 ± 62%  perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
    481.60 ± 52%    +448.7%       2642 ± 55%  perf-sched.wait_time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
    321.23 ± 19%    +594.3%       2230 ± 74%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      2179 ± 38%    +675.4%      16899 ± 97%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    317.08 ± 29%    +599.1%       2216 ± 85%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    451.54 ± 16%   +1653.3%       7916 ±102%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    277.33 ± 11%    +804.4%       2508 ± 56%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      1523 ± 12%   +1227.5%      20227 ± 69%  perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1025         +1338.8%      14757 ±118%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
    645.52 ± 69%    +473.8%       3703 ±157%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
     17.73 ±112%    +561.1%     117.22 ± 58%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final
    242.29 ± 40%   +4359.2%      10804 ±131%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     54.15 ± 66%  +14372.4%       7836 ±106%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1567 ±  8%   +1116.1%      19067 ± 84%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1711 ± 54%    +841.3%      16107 ± 85%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     32.68 ± 96%    +147.9%      81.01 ± 32%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      2200 ± 22%    +728.3%      18226 ± 83%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/socket/4/x86_64-rhel-9.4/threads/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/hackbench

commit: 
  8c57b687e8 ("mm, bpf: Introduce free_pages_nolock()")
  01d37228d3 ("memcg: Use trylock to access memcg stock_lock.")

8c57b687e8331eb8 01d37228d331047a0bbbd1026ce 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   2931589 ± 14%     -29.8%    2059056 ± 12%  cpuidle..usage
    274766 ±  4%     -17.8%     225885 ± 13%  numa-meminfo.node0.SUnreclaim
    200.50           +26.2%     253.04 ±  2%  uptime.boot
   1992153          +114.3%    4268815 ±  4%  vmstat.system.cs
      1.88 ± 16%      -0.5        1.36 ±  8%  mpstat.cpu.all.idle%
      0.02 ±  3%      +0.0        0.02 ±  4%  mpstat.cpu.all.soft%
    128556           +31.8%     169412        meminfo.AnonHugePages
    485113           -15.1%     411686        meminfo.SUnreclaim
    614406           -12.0%     540564        meminfo.Slab
    538737 ± 13%    +114.5%    1155509 ± 13%  numa-numastat.node0.local_node
    615940 ± 15%     +95.7%    1205124 ± 11%  numa-numastat.node0.numa_hit
   1008187 ± 19%     +45.5%    1466818 ±  5%  numa-numastat.node1.local_node
   1063633 ± 18%     +45.7%    1549639 ±  4%  numa-numastat.node1.numa_hit
     68502 ±  4%     -17.6%      56417 ± 14%  numa-vmstat.node0.nr_slab_unreclaimable
    615163 ± 15%     +95.9%    1204843 ± 11%  numa-vmstat.node0.numa_hit
    537960 ± 13%    +114.7%    1155228 ± 13%  numa-vmstat.node0.numa_local
   1062574 ± 18%     +45.8%    1548926 ±  4%  numa-vmstat.node1.numa_hit
   1007129 ± 19%     +45.6%    1466105 ±  5%  numa-vmstat.node1.numa_local
     40153 ± 27%     -83.8%       6498 ± 24%  perf-c2c.DRAM.local
      5474 ± 28%     -45.5%       2981 ± 20%  perf-c2c.DRAM.remote
     73336 ± 26%     -74.2%      18885 ± 20%  perf-c2c.HITM.local
      1539 ± 39%     -42.5%     884.83 ± 26%  perf-c2c.HITM.remote
     74875 ± 26%     -73.6%      19769 ± 21%  perf-c2c.HITM.total
    121167           -15.0%     102975        proc-vmstat.nr_slab_unreclaimable
   1682677 ±  9%     +63.9%    2757090 ±  5%  proc-vmstat.numa_hit
   1550029 ± 10%     +69.3%    2624651 ±  5%  proc-vmstat.numa_local
   3252894 ±  7%    +209.5%   10068916 ±  7%  proc-vmstat.pgalloc_normal
   2648888 ±  9%    +262.9%    9612330 ±  8%  proc-vmstat.pgfree
    415614           -26.6%     304910        hackbench.throughput
    405261           -25.9%     300194        hackbench.throughput_avg
    415614           -26.6%     304910        hackbench.throughput_best
    386952           -24.9%     290681        hackbench.throughput_worst
    149.14           +34.8%     201.02        hackbench.time.elapsed_time
    149.14           +34.8%     201.02        hackbench.time.elapsed_time.max
  58196111 ±  6%    +286.5%  2.249e+08 ±  7%  hackbench.time.involuntary_context_switches
    134003 ±  5%     -16.3%     112130        hackbench.time.minor_page_faults
     17596           +35.8%      23894        hackbench.time.system_time
      1136           +28.7%       1463        hackbench.time.user_time
 2.372e+08          +167.5%  6.346e+08 ±  3%  hackbench.time.voluntary_context_switches
      1.42           -34.8%       0.92 ± 13%  perf-stat.i.MPKI
 4.477e+10           -17.2%  3.707e+10        perf-stat.i.branch-instructions
      0.41            +0.1        0.50        perf-stat.i.branch-miss-rate%
 1.744e+08            +3.0%  1.796e+08        perf-stat.i.branch-misses
     23.68            -8.5       15.20 ±  7%  perf-stat.i.cache-miss-rate%
 3.098e+08           -46.4%  1.661e+08 ± 11%  perf-stat.i.cache-misses
 1.318e+09           -16.2%  1.105e+09 ±  4%  perf-stat.i.cache-references
   1972433          +116.9%    4278376 ±  4%  perf-stat.i.context-switches
      1.48           +22.1%       1.81        perf-stat.i.cpi
 3.239e+11            +1.3%  3.283e+11        perf-stat.i.cpu-cycles
     47350 ± 13%     +65.3%      78248 ± 19%  perf-stat.i.cpu-migrations
      1064           +91.4%       2037 ± 12%  perf-stat.i.cycles-between-cache-misses
 2.186e+11           -16.9%  1.816e+11        perf-stat.i.instructions
      0.68           -18.0%       0.56        perf-stat.i.ipc
     15.69          +115.3%      33.79 ±  3%  perf-stat.i.metric.K/sec
      4400 ±  6%     -18.0%       3607        perf-stat.i.minor-faults
      4400 ±  6%     -18.0%       3607        perf-stat.i.page-faults
      1.42           -35.3%       0.92 ± 13%  perf-stat.overall.MPKI
      0.39            +0.1        0.48        perf-stat.overall.branch-miss-rate%
     23.53            -8.5       15.00 ±  7%  perf-stat.overall.cache-miss-rate%
      1.48           +21.9%       1.81        perf-stat.overall.cpi
      1046           +91.4%       2004 ± 11%  perf-stat.overall.cycles-between-cache-misses
      0.67           -17.9%       0.55        perf-stat.overall.ipc
 4.448e+10           -17.0%  3.691e+10        perf-stat.ps.branch-instructions
  1.73e+08            +3.2%  1.786e+08        perf-stat.ps.branch-misses
 3.075e+08           -46.3%  1.653e+08 ± 11%  perf-stat.ps.cache-misses
 1.307e+09           -15.9%  1.099e+09 ±  4%  perf-stat.ps.cache-references
   1958509          +116.8%    4245688 ±  4%  perf-stat.ps.context-switches
 3.219e+11            +1.5%  3.266e+11        perf-stat.ps.cpu-cycles
     46201 ± 13%     +68.6%      77874 ± 19%  perf-stat.ps.cpu-migrations
 2.172e+11           -16.7%  1.808e+11        perf-stat.ps.instructions
      4287 ±  6%     -17.1%       3552        perf-stat.ps.minor-faults
      4287 ±  6%     -17.1%       3552        perf-stat.ps.page-faults
 3.263e+13           +12.0%  3.653e+13        perf-stat.total.instructions
   7909525 ±  2%     +52.6%   12071802        sched_debug.cfs_rq:/.avg_vruntime.avg
  10481951 ±  9%     +61.8%   16959043 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.max
   7141207           +52.0%   10853360 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
     22.46           +13.0%      25.38        sched_debug.cfs_rq:/.h_nr_queued.avg
      5.93 ±  5%     +19.3%       7.08 ±  3%  sched_debug.cfs_rq:/.h_nr_queued.stddev
     22.20           +14.1%      25.33        sched_debug.cfs_rq:/.h_nr_runnable.avg
      6.03 ±  5%     +17.9%       7.11 ±  3%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
    355.83           -22.8%     274.75        sched_debug.cfs_rq:/.load_avg.max
   7909525 ±  2%     +52.6%   12071802        sched_debug.cfs_rq:/.min_vruntime.avg
  10481951 ±  9%     +61.8%   16959043 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
   7141207           +52.0%   10853360 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
      0.69           +11.8%       0.78        sched_debug.cfs_rq:/.nr_queued.avg
      0.44 ± 35%     +59.4%       0.71 ± 13%  sched_debug.cfs_rq:/.nr_queued.min
      0.12 ± 17%     -28.0%       0.08 ± 14%  sched_debug.cfs_rq:/.nr_queued.stddev
    341.39           -25.0%     256.00        sched_debug.cfs_rq:/.removed.load_avg.max
    174.00           -24.7%     131.00 ±  2%  sched_debug.cfs_rq:/.removed.runnable_avg.max
    174.00           -24.7%     131.00 ±  2%  sched_debug.cfs_rq:/.removed.util_avg.max
    198071 ±125%    +348.4%     888081 ± 62%  sched_debug.cfs_rq:/.runnable_avg.avg
   1977052 ±141%    +219.2%    6310648 ± 51%  sched_debug.cfs_rq:/.runnable_avg.stddev
      1871           +20.4%       2253        sched_debug.cfs_rq:/.util_est.avg
    577483 ±  2%     -12.5%     505023 ±  8%  sched_debug.cpu.avg_idle.avg
    113708           +27.4%     144846 ±  2%  sched_debug.cpu.clock.avg
    115037           +26.7%     145757 ±  2%  sched_debug.cpu.clock.max
    112235           +28.2%     143890 ±  2%  sched_debug.cpu.clock.min
    113310           +27.3%     144279 ±  2%  sched_debug.cpu.clock_task.avg
    114742           +26.6%     145320 ±  2%  sched_debug.cpu.clock_task.max
    103500           +30.2%     134733 ±  2%  sched_debug.cpu.clock_task.min
     12338           +15.5%      14254        sched_debug.cpu.curr->pid.avg
     15248           +12.6%      17174        sched_debug.cpu.curr->pid.max
     22.46           +13.0%      25.37        sched_debug.cpu.nr_running.avg
      5.94 ±  5%     +19.1%       7.07 ±  3%  sched_debug.cpu.nr_running.stddev
    944460 ±  2%    +212.8%    2954732 ±  3%  sched_debug.cpu.nr_switches.avg
   1384690 ±  9%    +173.0%    3780143 ±  3%  sched_debug.cpu.nr_switches.max
    779137 ±  2%    +198.7%    2327029 ±  9%  sched_debug.cpu.nr_switches.min
     94939 ± 18%    +274.7%     355703 ± 41%  sched_debug.cpu.nr_switches.stddev
    112191           +28.2%     143862 ±  2%  sched_debug.cpu_clk
    111036           +28.5%     142706 ±  2%  sched_debug.ktime
    113021           +28.0%     144688 ±  2%  sched_debug.sched_clk
     55.02 ± 69%   +1310.2%     775.94 ± 89%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof
     38.12 ± 77%    +943.0%     397.61 ± 59%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     65.04 ± 17%    +653.0%     489.75 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     20.05 ± 24%    +288.4%      77.88 ± 34%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     10.24 ± 95%     -99.5%       0.05 ±191%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     47.60 ± 34%    +735.2%     397.53 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     19.81 ±109%     -75.7%       4.81 ± 60%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
     55.61 ± 32%   +1002.8%     613.30 ± 20%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.37 ±217%  +2.4e+05%     895.65 ±222%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     27.14 ± 39%    +347.6%     121.45 ± 42%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     66.58 ± 18%   +1020.4%     745.92 ± 18%  perf-sched.sch_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
      5.48 ± 17%    +213.6%      17.19 ± 16%  perf-sched.sch_delay.avg.ms.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
      8.61 ± 22%    +385.3%      41.78 ± 10%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    330.55 ±116%   +2270.5%       7835 ± 55%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      5574 ± 16%    +211.6%      17370 ±  8%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     17.26 ± 88%     -99.7%       0.05 ±191%  perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      5162 ± 15%    +236.2%      17354 ± 12%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      4727 ± 24%    +239.1%      16028 ± 13%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    209.42 ±202%   +3332.2%       7187 ±117%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      1343 ± 39%    +152.0%       3384 ± 42%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      5830 ± 16%    +212.2%      18205 ±  8%  perf-sched.sch_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
      5836 ± 15%    +202.9%      17679 ±  8%  perf-sched.sch_delay.max.ms.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
      5816 ± 15%    +212.2%      18162 ±  8%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     10.88 ± 19%    +232.3%      36.16 ± 11%  perf-sched.total_sch_delay.average.ms
      5942 ± 13%    +206.8%      18228 ±  8%  perf-sched.total_sch_delay.max.ms
     27.55 ± 19%    +232.7%      91.65 ± 12%  perf-sched.total_wait_and_delay.average.ms
     11902 ± 13%    +206.3%      36457 ±  8%  perf-sched.total_wait_and_delay.max.ms
     16.67 ± 19%    +232.9%      55.49 ± 12%  perf-sched.total_wait_time.average.ms
      6456 ±  4%    +182.5%      18242 ±  8%  perf-sched.total_wait_time.max.ms
    113.95 ± 69%   +1316.6%       1614 ± 82%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof
     79.96 ± 73%   +1082.3%     945.34 ± 57%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
    143.75 ± 16%    +611.5%       1022 ± 27%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     42.41 ± 20%    +275.0%     159.04 ± 32%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    101.84 ± 33%    +721.9%     837.03 ± 41%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
    124.93 ± 34%    +929.0%       1285 ± 20%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     74.56 ± 60%    +705.1%     600.29 ± 41%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     76.07 ± 36%    +330.8%     327.70 ± 26%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    146.24 ± 18%    +989.6%       1593 ± 18%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
     16.40 ± 18%    +229.2%      54.00 ± 16%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
    739.69 ± 13%    +254.3%       2621 ± 44%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     19.70 ± 23%    +353.8%      89.38 ±  9%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    837.21 ± 24%    +166.9%       2234 ± 13%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     36.50 ± 86%     -96.3%       1.33 ±223%  perf-sched.wait_and_delay.count.__cond_resched.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
    132.83 ± 58%     -60.0%      53.17 ± 27%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    101624 ± 38%     -81.9%      18404 ± 17%  perf-sched.wait_and_delay.count.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
    733.10 ± 64%     -84.4%     114.45 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
    661.77 ±116%   +2433.4%      16765 ± 49%  perf-sched.wait_and_delay.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     11149 ± 16%    +211.6%      34740 ±  8%  perf-sched.wait_and_delay.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     10324 ± 15%    +236.2%      34709 ± 12%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      9455 ± 24%    +239.0%      32056 ± 13%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    646.51 ± 59%    +503.5%       3902 ± 68%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      2745 ± 39%    +175.6%       7565 ± 33%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     11661 ± 16%    +212.2%      36412 ±  8%  perf-sched.wait_and_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
     11674 ± 15%    +203.0%      35373 ±  8%  perf-sched.wait_and_delay.max.ms.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
      6384 ±  4%    +184.5%      18161 ±  7%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     11633 ± 15%    +212.2%      36324 ±  8%  perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      6098 ±  9%    +192.4%      17831 ±  7%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     58.92 ± 68%   +1322.7%     838.26 ± 76%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof
     41.83 ± 69%   +1209.3%     547.73 ± 62%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     78.71 ± 15%    +577.2%     533.02 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     22.36 ± 17%    +263.0%      81.16 ± 29%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      8.84 ±109%     -99.5%       0.05 ±191%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     54.24 ± 33%    +710.2%     439.49 ± 40%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     69.31 ± 35%    +869.9%     672.25 ± 21%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     51.67 ± 62%    +784.1%     456.81 ± 40%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     48.93 ± 35%    +321.5%     206.25 ± 19%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     79.66 ± 18%    +963.8%     847.45 ± 18%  perf-sched.wait_time.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
     10.92 ± 19%    +237.0%      36.81 ± 16%  perf-sched.wait_time.avg.ms.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
    739.68 ± 13%    +254.3%       2621 ± 44%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     11.09 ± 23%    +329.3%      47.60 ±  8%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    833.25 ± 24%    +136.5%       1970 ±  7%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    331.23 ±116%   +2838.5%       9733 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      5575 ± 16%    +212.8%      17440 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     11.46 ± 79%     -99.6%       0.05 ±191%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      5162 ± 15%    +236.2%      17354 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      4850 ± 25%    +230.4%      16028 ± 13%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    216.39 ±194%   +3253.6%       7256 ±115%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    386.99 ± 62%    +582.5%       2641 ± 54%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1402 ± 39%    +198.2%       4181 ± 27%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      5830 ± 16%    +212.3%      18206 ±  8%  perf-sched.wait_time.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
      5840 ± 15%    +204.1%      17759 ±  8%  perf-sched.wait_time.max.ms.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
      6384 ±  4%    +184.5%      18161 ±  7%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5818 ± 15%    +212.2%      18162 ±  8%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      6098 ±  9%    +192.4%      17831 ±  7%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     55.29 ±  2%     -16.0       39.24        perf-profile.calltrace.cycles-pp.read
     50.80 ±  2%     -14.9       35.91        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     47.07 ±  3%     -14.9       32.19        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     50.53 ±  2%     -14.8       35.71        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     48.63 ±  3%     -14.8       33.86        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     45.80 ±  3%     -14.6       31.18        perf-profile.calltrace.cycles-pp.sock_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     44.98 ±  3%     -14.5       30.52        perf-profile.calltrace.cycles-pp.sock_recvmsg.sock_read_iter.vfs_read.ksys_read.do_syscall_64
     44.54 ±  3%     -14.4       30.17        perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_recvmsg.sock_read_iter.vfs_read.ksys_read
     44.16 ±  3%     -14.3       29.87        perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter.vfs_read
     13.28 ± 10%      -6.2        7.10 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
     16.20 ±  8%      -5.9       10.30 ±  2%  perf-profile.calltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
     12.86 ± 11%      -5.2        7.64 ±  3%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
     11.84 ± 11%      -4.7        7.19 ±  3%  perf-profile.calltrace.cycles-pp.kfree.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      7.28 ± 23%      -4.6        2.64 ±  5%  perf-profile.calltrace.cycles-pp.__put_partials.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      7.06 ± 23%      -4.5        2.53 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__put_partials.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      6.92 ± 23%      -4.5        2.45 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__put_partials.kmem_cache_free.unix_stream_read_generic
      7.38 ± 21%      -4.1        3.27 ±  8%  perf-profile.calltrace.cycles-pp.__put_partials.kfree.skb_release_data.consume_skb.unix_stream_read_generic
      7.17 ± 21%      -4.0        3.16 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__put_partials.kfree.skb_release_data.consume_skb
      7.03 ± 22%      -3.9        3.08 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__put_partials.kfree.skb_release_data
      5.59 ± 20%      -3.4        2.22 ±  4%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      7.82 ±  2%      -3.4        4.45 ±  2%  perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      7.75 ±  2%      -3.4        4.40 ±  2%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      7.60 ±  2%      -3.3        4.28 ±  2%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
      4.94 ± 22%      -3.2        1.70 ±  5%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags
      4.53 ± 23%      -3.0        1.51 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.kmem_cache_alloc_node_noprof.__alloc_skb
      4.50 ± 23%      -3.0        1.50 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.kmem_cache_alloc_node_noprof
      5.74 ± 19%      -2.9        2.80 ±  7%  perf-profile.calltrace.cycles-pp.___slab_alloc.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      5.05 ± 21%      -2.9        2.19 ±  7%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb
      4.64 ± 22%      -2.7        1.99 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmalloc_node_track_caller_noprof.kmalloc_reserve
      4.61 ± 22%      -2.6        1.96 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmalloc_node_track_caller_noprof
      3.91 ±  3%      -1.8        2.12 ±  2%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      3.03 ±  3%      -1.2        1.79        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      2.85 ±  3%      -1.2        1.64        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      2.15 ±  4%      -1.0        1.11 ±  2%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      2.25 ± 14%      -0.7        1.57 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      3.24 ±  4%      -0.6        2.59        perf-profile.calltrace.cycles-pp.skb_release_head_state.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      2.67 ±  3%      -0.6        2.03 ±  2%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      3.10 ±  4%      -0.6        2.48        perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      1.53 ±  2%      -0.6        0.92 ± 28%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      1.52 ±  3%      -0.6        0.92 ± 28%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      2.90 ±  4%      -0.6        2.32        perf-profile.calltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.consume_skb.unix_stream_read_generic
      2.98 ±  4%      -0.6        2.43 ± 11%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      1.97 ±  3%      -0.5        1.48 ±  2%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      1.96 ±  2%      -0.4        1.53 ±  2%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      1.32 ±  5%      -0.4        0.95 ±  2%  perf-profile.calltrace.cycles-pp.__slab_free.kfree.skb_release_data.consume_skb.unix_stream_read_generic
      1.23 ±  3%      -0.3        0.91 ±  2%  perf-profile.calltrace.cycles-pp._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write
      1.11 ±  3%      -0.3        0.84 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write
      0.60 ±  3%      +0.1        0.69        perf-profile.calltrace.cycles-pp.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      0.61 ±  5%      +0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      1.09 ±  5%      +0.4        1.47 ±  8%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.43 ±100%      +0.5        0.91 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.skb_queue_tail.unix_stream_sendmsg.sock_write_iter.vfs_write
      0.29 ±100%      +0.5        0.78 ±  5%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.schedule_timeout
      0.30 ±100%      +0.5        0.80 ±  4%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.schedule_timeout.unix_stream_data_wait
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      0.08 ±223%      +0.5        0.60        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      0.00            +0.6        0.56 ±  6%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule
      0.00            +0.6        0.63 ± 12%  perf-profile.calltrace.cycles-pp.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.65 ± 12%  perf-profile.calltrace.cycles-pp.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.17 ±141%      +0.7        0.83 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up
      0.00            +0.7        0.67 ±  2%  perf-profile.calltrace.cycles-pp.mutex_unlock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      0.78 ± 27%      +0.7        1.45 ±  5%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      0.35 ±100%      +0.7        1.04 ±  4%  perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
      0.36 ±100%      +0.7        1.08 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.schedule_timeout
      0.38 ±100%      +0.7        1.12 ±  3%  perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.schedule_timeout.unix_stream_data_wait
      0.39 ±100%      +0.8        1.15 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      0.40 ±100%      +0.8        1.18 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.68 ± 46%      +1.1        2.81 ±  8%  perf-profile.calltrace.cycles-pp.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg.sock_write_iter.vfs_write
      1.44 ± 42%      +1.2        2.63 ±  7%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable
      1.51 ± 42%      +1.2        2.70 ±  7%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg.sock_write_iter
      1.47 ± 42%      +1.2        2.67 ±  7%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg
      1.59 ± 29%      +1.3        2.89 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic
      2.29 ± 45%      +1.3        3.61 ±  7%  perf-profile.calltrace.cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      1.63 ± 29%      +1.3        2.96 ±  3%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
      1.68 ± 28%      +1.4        3.02 ±  3%  perf-profile.calltrace.cycles-pp.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      1.96 ± 29%      +1.7        3.65 ±  3%  perf-profile.calltrace.cycles-pp.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      0.00            +4.8        4.85 ±  2%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.try_charge_memcg.obj_cgroup_charge.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof
      8.90 ± 12%      +5.0       13.87 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      2.16 ±  3%      +8.6       10.80 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.00            +8.7        8.70 ±  2%  perf-profile.calltrace.cycles-pp.try_charge_memcg.obj_cgroup_charge.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof.__alloc_skb
      0.44 ± 44%      +8.8        9.20 ±  2%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags
      0.00            +9.5        9.52 ±  2%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.try_charge_memcg.obj_cgroup_charge.__memcg_slab_post_alloc_hook.__kmalloc_node_track_caller_noprof
      9.94 ± 10%     +13.6       23.50        perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      9.38 ± 11%     +13.8       23.19        perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     43.95           +15.4       59.35        perf-profile.calltrace.cycles-pp.write
     37.71           +16.6       54.29        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     35.73           +16.6       52.34        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     39.75           +16.7       56.48        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     39.48           +16.8       56.28        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.49 ±  3%     +16.9       19.37 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     34.47           +16.9       51.41        perf-profile.calltrace.cycles-pp.sock_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.70 ±  2%     +17.1       17.82 ±  2%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__memcg_slab_post_alloc_hook.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb
      0.00           +17.1       17.13 ±  2%  perf-profile.calltrace.cycles-pp.try_charge_memcg.obj_cgroup_charge.__memcg_slab_post_alloc_hook.__kmalloc_node_track_caller_noprof.kmalloc_reserve
     33.13           +17.3       50.43        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_64
     23.11 ±  7%     +17.7       40.82        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
     20.87 ±  9%     +17.9       38.78        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write
     20.58 ±  9%     +18.0       38.56        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
     55.43 ±  2%     -15.6       39.81        perf-profile.children.cycles-pp.read
     47.13 ±  3%     -14.9       32.23        perf-profile.children.cycles-pp.vfs_read
     48.70 ±  3%     -14.8       33.92        perf-profile.children.cycles-pp.ksys_read
     45.85 ±  3%     -14.6       31.21        perf-profile.children.cycles-pp.sock_read_iter
     45.04 ±  3%     -14.5       30.57        perf-profile.children.cycles-pp.sock_recvmsg
     44.58 ±  3%     -14.4       30.20        perf-profile.children.cycles-pp.unix_stream_recvmsg
     44.36 ±  3%     -14.3       30.02        perf-profile.children.cycles-pp.unix_stream_read_generic
     23.88 ± 19%     -14.1        9.79 ±  5%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     25.27 ± 18%     -13.7       11.62 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     14.68 ± 21%      -8.8        5.92 ±  6%  perf-profile.children.cycles-pp.__put_partials
     11.33 ± 19%      -6.3        5.03 ±  5%  perf-profile.children.cycles-pp.___slab_alloc
     13.34 ± 10%      -6.2        7.14 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
     16.27 ±  8%      -5.9       10.35 ±  2%  perf-profile.children.cycles-pp.consume_skb
     10.21 ± 21%      -5.9        4.35 ±  6%  perf-profile.children.cycles-pp.get_partial_node
     12.90 ± 11%      -5.2        7.66 ±  3%  perf-profile.children.cycles-pp.skb_release_data
     11.90 ± 11%      -4.7        7.23 ±  3%  perf-profile.children.cycles-pp.kfree
      7.86 ±  2%      -3.4        4.48 ±  2%  perf-profile.children.cycles-pp.unix_stream_read_actor
      7.78 ±  2%      -3.4        4.42 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      7.65 ±  2%      -3.3        4.32 ±  2%  perf-profile.children.cycles-pp.__skb_datagram_iter
      3.93 ±  3%      -1.8        2.14 ±  2%  perf-profile.children.cycles-pp._copy_to_iter
      4.23 ±  3%      -1.5        2.70        perf-profile.children.cycles-pp.__check_object_size
      3.07 ±  3%      -1.3        1.82        perf-profile.children.cycles-pp.simple_copy_to_iter
      2.82 ±  4%      -1.2        1.62        perf-profile.children.cycles-pp.check_heap_object
      3.96 ±  2%      -0.9        3.04 ±  2%  perf-profile.children.cycles-pp.clear_bhb_loop
      2.75 ±  3%      -0.7        2.08 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
      3.28 ±  4%      -0.7        2.62        perf-profile.children.cycles-pp.skb_release_head_state
      3.16 ±  4%      -0.6        2.53        perf-profile.children.cycles-pp.unix_destruct_scm
      2.93 ±  4%      -0.6        2.34        perf-profile.children.cycles-pp.sock_wfree
      2.40 ±  5%      -0.5        1.94        perf-profile.children.cycles-pp.__slab_free
      1.74 ±  2%      -0.4        1.35 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.34 ±  2%      -0.3        1.01 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.25 ±  3%      -0.3        0.93 ±  2%  perf-profile.children.cycles-pp._copy_from_iter
      1.08 ±  3%      -0.3        0.79 ±  3%  perf-profile.children.cycles-pp.rw_verify_area
      0.62 ±  3%      -0.3        0.36        perf-profile.children.cycles-pp.__build_skb_around
      0.73 ±  3%      -0.2        0.55 ±  2%  perf-profile.children.cycles-pp.__check_heap_object
      0.63 ±  3%      -0.1        0.48        perf-profile.children.cycles-pp.__cond_resched
      0.40 ±  5%      -0.1        0.28 ±  5%  perf-profile.children.cycles-pp.fsnotify_pre_content
      0.20 ±  6%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.put_cpu_partial
      0.41 ±  3%      -0.1        0.31        perf-profile.children.cycles-pp.x64_sys_call
      0.53 ±  3%      -0.1        0.43 ±  4%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.61 ±  4%      -0.1        0.52        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.27 ±  2%      -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.28 ±  3%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.__scm_recv_common
      0.23 ±  3%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.security_file_permission
      0.30 ±  3%      -0.0        0.25 ±  3%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.21 ±  5%      -0.0        0.16 ±  6%  perf-profile.children.cycles-pp.kmalloc_size_roundup
      0.16 ±  5%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.maybe_add_creds
      0.16 ±  4%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.17 ±  4%      -0.0        0.13        perf-profile.children.cycles-pp.put_pid
      0.15 ±  2%      -0.0        0.11        perf-profile.children.cycles-pp.security_socket_recvmsg
      0.14 ±  3%      -0.0        0.10        perf-profile.children.cycles-pp.security_socket_getpeersec_dgram
      0.21 ±  5%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.13 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.18 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.14 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.manage_oob
      0.17 ±  4%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.check_stack_object
      0.11 ±  3%      -0.0        0.08        perf-profile.children.cycles-pp.wait_for_unix_gc
      0.17 ±  3%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.unix_scm_to_skb
      0.13 ±  5%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.09 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.skb_put
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.__x64_sys_read
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.__x64_sys_write
      0.09 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.skb_free_head
      0.07 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.kfree_skbmem
      0.08 ± 21%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.__get_user_8
      0.07 ± 27%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.avg_vruntime
      0.09 ± 23%      +0.0        0.13 ±  7%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.08 ± 16%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.os_xsave
      0.07 ± 25%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.sched_clock
      0.08 ± 35%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.place_entity
      0.02 ± 99%      +0.0        0.07 ±  8%  perf-profile.children.cycles-pp.__put_user_8
      0.02 ± 99%      +0.0        0.07 ±  8%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.06 ± 19%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.___perf_sw_event
      0.08 ± 29%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.25 ±  9%      +0.0        0.30 ±  5%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.01 ±223%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.ktime_get
      0.04 ±100%      +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.update_entity_lag
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.01 ±223%      +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.clockevents_program_event
      0.04 ±100%      +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
      0.09 ± 31%      +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.06 ± 14%      +0.1        0.13 ±  9%  perf-profile.children.cycles-pp.vruntime_eligible
      0.08 ± 26%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.put_prev_entity
      0.04 ±101%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.finish_wait
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.charge_memcg
      0.10 ± 18%      +0.1        0.17 ±  9%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      0.04 ± 72%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.64 ±  3%      +0.1        0.72        perf-profile.children.cycles-pp.skb_unlink
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.set_next_buddy
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.shmem_write_begin
      0.65 ±  5%      +0.1        0.74        perf-profile.children.cycles-pp.mutex_lock
      0.14 ± 31%      +0.1        0.22 ±  7%  perf-profile.children.cycles-pp.wakeup_preempt
      0.05            +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.cmd_record
      0.17 ± 22%      +0.1        0.26 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.05 ±  7%      +0.1        0.15 ±  9%  perf-profile.children.cycles-pp.handle_internal_command
      0.05 ±  7%      +0.1        0.15 ±  9%  perf-profile.children.cycles-pp.main
      0.14 ± 22%      +0.1        0.24 ±  6%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.05 ±  7%      +0.1        0.15 ±  9%  perf-profile.children.cycles-pp.run_builtin
      0.13 ± 25%      +0.1        0.23 ±  9%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.31 ± 13%      +0.1        0.42 ±  5%  perf-profile.children.cycles-pp.switch_fpu_return
      0.00            +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.generic_perform_write
      0.19 ± 11%      +0.1        0.30 ±  7%  perf-profile.children.cycles-pp.__dequeue_entity
      0.00            +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.05 ±100%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.00            +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.record__pushfn
      0.00            +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.writen
      0.00            +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.perf_mmap__push
      0.18 ± 15%      +0.1        0.32 ±  6%  perf-profile.children.cycles-pp.__enqueue_entity
      0.16 ± 22%      +0.1        0.30 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
      0.00            +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.14 ± 21%      +0.1        0.27 ±  5%  perf-profile.children.cycles-pp.__switch_to
      0.21 ± 23%      +0.2        0.37 ±  6%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.35 ± 19%      +0.2        0.52 ±  9%  perf-profile.children.cycles-pp.__switch_to_asm
      0.29 ± 15%      +0.2        0.47 ±  6%  perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.2        0.18 ±  4%  perf-profile.children.cycles-pp.page_counter_cancel
      0.00            +0.2        0.19 ±  4%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.00            +0.2        0.19 ±  3%  perf-profile.children.cycles-pp.drain_stock
      0.15 ± 16%      +0.2        0.36 ±  8%  perf-profile.children.cycles-pp.pick_eevdf
      0.22 ± 25%      +0.2        0.45 ±  7%  perf-profile.children.cycles-pp.pick_task_fair
      0.34 ± 31%      +0.2        0.59 ±  6%  perf-profile.children.cycles-pp.dequeue_entity
      0.21 ± 44%      +0.3        0.47 ± 11%  perf-profile.children.cycles-pp.get_any_partial
      0.47 ± 28%      +0.3        0.74 ±  7%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.3        0.29 ±  3%  perf-profile.children.cycles-pp.refill_stock
      0.39 ±  6%      +0.3        0.68        perf-profile.children.cycles-pp.mutex_unlock
      0.37 ± 34%      +0.3        0.68 ±  8%  perf-profile.children.cycles-pp.update_curr
      0.69 ±  6%      +0.3        1.03        perf-profile.children.cycles-pp.fput
      0.48 ± 25%      +0.4        0.86 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
      0.39 ±  4%      +0.4        0.82 ± 28%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      2.39 ±  9%      +0.4        2.82 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.61 ± 32%      +0.5        1.07 ±  4%  perf-profile.children.cycles-pp.dequeue_entities
      0.72 ± 31%      +0.5        1.18 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.76 ± 31%      +0.5        1.22 ±  5%  perf-profile.children.cycles-pp.enqueue_task
      0.72 ± 25%      +0.5        1.19 ±  6%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.74 ± 25%      +0.5        1.21 ±  6%  perf-profile.children.cycles-pp.__pick_next_task
      0.62 ± 31%      +0.5        1.10 ±  4%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.64 ± 29%      +0.5        1.14 ±  4%  perf-profile.children.cycles-pp.try_to_block_task
      0.32 ±  8%      +0.5        0.84 ± 53%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.29 ±  6%      +0.5        0.82 ± 62%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.90 ± 30%      +0.6        1.48 ±  5%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +0.7        0.67 ± 11%  perf-profile.children.cycles-pp.propagate_protected_usage
      1.58 ± 41%      +1.1        2.68 ±  7%  perf-profile.children.cycles-pp.try_to_wake_up
      1.65 ± 41%      +1.1        2.74 ±  8%  perf-profile.children.cycles-pp.__wake_up_common
      1.60 ± 41%      +1.1        2.71 ±  7%  perf-profile.children.cycles-pp.autoremove_wake_function
      1.87 ± 28%      +1.2        3.08 ±  3%  perf-profile.children.cycles-pp.schedule_timeout
      2.31 ± 44%      +1.3        3.63 ±  7%  perf-profile.children.cycles-pp.sock_def_readable
      2.11 ± 29%      +1.5        3.65 ±  4%  perf-profile.children.cycles-pp.__schedule
      2.10 ± 28%      +1.6        3.69 ±  4%  perf-profile.children.cycles-pp.schedule
      1.96 ± 29%      +1.7        3.67 ±  3%  perf-profile.children.cycles-pp.unix_stream_data_wait
     90.76            +1.9       92.65        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     90.24            +2.0       92.23        perf-profile.children.cycles-pp.do_syscall_64
      8.98 ± 12%      +5.0       13.93 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
     10.02 ± 10%     +13.5       23.56        perf-profile.children.cycles-pp.kmalloc_reserve
      9.60 ± 10%     +13.6       23.25        perf-profile.children.cycles-pp.__kmalloc_node_track_caller_noprof
      0.00           +14.4       14.44 ±  2%  perf-profile.children.cycles-pp.page_counter_try_charge
     44.12           +15.9       60.04        perf-profile.children.cycles-pp.write
     37.81           +16.6       54.46        perf-profile.children.cycles-pp.ksys_write
     35.82           +16.7       52.50        perf-profile.children.cycles-pp.vfs_write
     34.55           +16.9       51.46        perf-profile.children.cycles-pp.sock_write_iter
     33.40           +17.2       50.62        perf-profile.children.cycles-pp.unix_stream_sendmsg
     23.17 ±  7%     +17.7       40.86        perf-profile.children.cycles-pp.sock_alloc_send_pskb
     20.93 ±  9%     +17.9       38.82        perf-profile.children.cycles-pp.alloc_skb_with_frags
     20.68 ±  9%     +17.9       38.63        perf-profile.children.cycles-pp.__alloc_skb
      4.77 ±  3%     +25.5       30.26 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      1.29 ±  3%     +25.8       27.07 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.13 ±  3%     +25.8       25.92 ±  2%  perf-profile.children.cycles-pp.try_charge_memcg
     23.87 ± 19%     -14.1        9.78 ±  5%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      3.89 ±  3%      -1.8        2.12 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      3.22 ±  6%      -1.3        1.92 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      2.44 ±  3%      -1.1        1.39 ±  2%  perf-profile.self.cycles-pp.unix_stream_read_generic
      2.13 ±  4%      -1.1        1.07        perf-profile.self.cycles-pp.check_heap_object
      3.92 ±  2%      -0.9        3.00 ±  2%  perf-profile.self.cycles-pp.clear_bhb_loop
      1.89 ±  4%      -0.9        1.02        perf-profile.self.cycles-pp.kmem_cache_free
      2.29 ±  3%      -0.6        1.66        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      2.34 ±  3%      -0.6        1.78        perf-profile.self.cycles-pp.sock_wfree
      0.92 ±  6%      -0.5        0.38 ±  3%  perf-profile.self.cycles-pp.skb_release_data
      1.46 ± 16%      -0.5        0.97 ±  5%  perf-profile.self.cycles-pp.unix_stream_sendmsg
      1.11 ±  4%      -0.5        0.63        perf-profile.self.cycles-pp.___slab_alloc
      2.35 ±  5%      -0.4        1.90        perf-profile.self.cycles-pp.__slab_free
      0.76 ± 10%      -0.4        0.38 ±  5%  perf-profile.self.cycles-pp.get_partial_node
      1.28 ±  3%      -0.4        0.92 ±  2%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller_noprof
      1.30 ±  2%      -0.3        0.98 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.21 ±  2%      -0.3        0.90 ±  2%  perf-profile.self.cycles-pp._copy_from_iter
      1.10 ±  3%      -0.3        0.81 ±  2%  perf-profile.self.cycles-pp.__alloc_skb
      0.68 ±  3%      -0.3        0.39 ±  2%  perf-profile.self.cycles-pp.__skb_datagram_iter
      1.05 ±  3%      -0.3        0.77 ±  2%  perf-profile.self.cycles-pp.sock_write_iter
      0.99            -0.3        0.72 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      0.58 ±  3%      -0.3        0.33        perf-profile.self.cycles-pp.__build_skb_around
      0.92 ±  2%      -0.2        0.70 ±  2%  perf-profile.self.cycles-pp.read
      0.92 ±  2%      -0.2        0.70 ±  2%  perf-profile.self.cycles-pp.write
      1.34 ±  3%      -0.2        1.14        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.39 ±  8%      -0.2        0.21 ±  3%  perf-profile.self.cycles-pp.__put_partials
      0.88 ±  2%      -0.2        0.71 ±  4%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.69 ±  3%      -0.2        0.52 ±  2%  perf-profile.self.cycles-pp.__check_heap_object
      0.70 ±  6%      -0.2        0.54 ±  2%  perf-profile.self.cycles-pp.vfs_write
      0.80 ±  2%      -0.2        0.64 ±  2%  perf-profile.self.cycles-pp.sock_read_iter
      0.79 ±  3%      -0.1        0.65 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.53 ±  3%      -0.1        0.39 ±  2%  perf-profile.self.cycles-pp.rw_verify_area
      0.57 ±  3%      -0.1        0.44 ±  2%  perf-profile.self.cycles-pp.__check_object_size
      0.77 ±  3%      -0.1        0.64 ±  2%  perf-profile.self.cycles-pp.vfs_read
      0.47 ±  5%      -0.1        0.36 ±  2%  perf-profile.self.cycles-pp.kfree
      0.58 ±  3%      -0.1        0.47        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.34 ±  5%      -0.1        0.24        perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.51 ±  3%      -0.1        0.41 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.33 ±  6%      -0.1        0.23 ±  6%  perf-profile.self.cycles-pp.fsnotify_pre_content
      0.20 ±  6%      -0.1        0.10 ±  3%  perf-profile.self.cycles-pp.put_cpu_partial
      0.48 ±  3%      -0.1        0.39 ±  4%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.20 ±  3%      -0.1        0.11 ± 18%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.36 ±  3%      -0.1        0.28 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
      0.34 ±  2%      -0.1        0.26 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.28 ±  3%      -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.ksys_write
      0.43 ±  3%      -0.1        0.35 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.24 ±  3%      -0.1        0.18 ±  5%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.27 ±  3%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.30 ±  3%      -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.skb_copy_datagram_from_iter
      0.33 ±  3%      -0.1        0.27 ±  3%  perf-profile.self.cycles-pp.sock_recvmsg
      0.29 ±  3%      -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.ksys_read
      0.21 ±  3%      -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.22 ±  4%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.unix_stream_recvmsg
      0.19 ±  3%      -0.0        0.14        perf-profile.self.cycles-pp.security_file_permission
      0.25 ±  3%      -0.0        0.21 ±  3%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.21 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.__scm_recv_common
      0.17 ±  6%      -0.0        0.13 ±  7%  perf-profile.self.cycles-pp.kmalloc_size_roundup
      0.14 ±  3%      -0.0        0.10        perf-profile.self.cycles-pp.skb_unlink
      0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.skb_queue_tail
      0.12 ±  7%      -0.0        0.09        perf-profile.self.cycles-pp.maybe_add_creds
      0.18 ±  4%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.13 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.skb_copy_datagram_iter
      0.13 ±  2%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.consume_skb
      0.18 ±  3%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.unix_destruct_scm
      0.12 ±  5%      -0.0        0.09        perf-profile.self.cycles-pp.is_vmalloc_addr
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.security_socket_getpeersec_dgram
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.check_stack_object
      0.10 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.security_socket_sendmsg
      0.17 ±  5%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.06            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.kfree_skbmem
      0.09 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.wait_for_unix_gc
      0.12 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.security_socket_recvmsg
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.unix_scm_to_skb
      0.12 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.manage_oob
      0.10 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.skb_release_head_state
      0.12 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.put_pid
      0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.skb_put
      0.08 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.skb_free_head
      0.09            -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.simple_copy_to_iter
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.unix_stream_read_actor
      0.07 ± 16%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.__get_user_8
      0.08 ± 19%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.05 ± 47%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.unix_stream_data_wait
      0.02 ± 99%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.08 ± 14%      +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.os_xsave
      0.02 ±141%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.place_entity
      0.07 ± 32%      +0.0        0.12 ± 12%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.03 ±100%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.___perf_sw_event
      0.05 ± 74%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.avg_vruntime
      0.06 ± 13%      +0.1        0.11 ± 11%  perf-profile.self.cycles-pp.vruntime_eligible
      0.25 ±  8%      +0.1        0.30 ±  5%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.check_preempt_wakeup_fair
      0.02 ±141%      +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.01 ±223%      +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.schedule
      0.02 ±141%      +0.1        0.07 ±  8%  perf-profile.self.cycles-pp.__put_user_8
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.04 ±100%      +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.native_sched_clock
      0.04 ±100%      +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.dequeue_entity
      0.09 ± 21%      +0.1        0.15 ±  7%  perf-profile.self.cycles-pp.dequeue_entities
      0.04 ± 72%      +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.refill_stock
      0.43 ±  4%      +0.1        0.50 ±  2%  perf-profile.self.cycles-pp.unix_write_space
      0.00            +0.1        0.08 ±  9%  perf-profile.self.cycles-pp.set_next_buddy
      0.04 ±100%      +0.1        0.12 ±  5%  perf-profile.self.cycles-pp.switch_fpu_return
      0.15 ± 22%      +0.1        0.24 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.10 ± 24%      +0.1        0.19 ±  4%  perf-profile.self.cycles-pp.prepare_task_switch
      0.15 ± 11%      +0.1        0.24 ±  7%  perf-profile.self.cycles-pp.__dequeue_entity
      0.13 ± 34%      +0.1        0.22 ±  9%  perf-profile.self.cycles-pp.update_curr
      0.12 ± 23%      +0.1        0.21 ±  9%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.04 ±100%      +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.04 ±100%      +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.prepare_to_wait
      0.28 ± 24%      +0.1        0.40 ±  5%  perf-profile.self.cycles-pp.__schedule
      0.18 ± 14%      +0.1        0.32 ±  6%  perf-profile.self.cycles-pp.__enqueue_entity
      0.13 ± 19%      +0.1        0.27 ±  5%  perf-profile.self.cycles-pp.__switch_to
      0.40 ±  6%      +0.1        0.54 ±  2%  perf-profile.self.cycles-pp.mutex_lock
      0.11 ± 20%      +0.2        0.28 ±  7%  perf-profile.self.cycles-pp.pick_eevdf
      0.35 ± 18%      +0.2        0.52 ±  9%  perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.2        0.18 ±  4%  perf-profile.self.cycles-pp.page_counter_cancel
      0.37 ±  6%      +0.3        0.67        perf-profile.self.cycles-pp.mutex_unlock
      0.65 ±  6%      +0.3        0.99        perf-profile.self.cycles-pp.fput
      1.68 ± 14%      +0.4        2.08 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.27 ±  9%      +0.5        0.80 ± 56%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.22 ±  7%      +0.5        0.77 ± 66%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.7        0.65 ± 11%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.10 ±  4%     +11.3       11.43 ±  3%  perf-profile.self.cycles-pp.try_charge_memcg
      0.00           +13.7       13.72 ±  2%  perf-profile.self.cycles-pp.page_counter_try_charge



***************************************************************************************************
lkp-spr-2sp4: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_threads/rootfs/tbox_group/test/test_memory_size/testcase:
  gcc-12/performance/x86_64-rhel-9.4/development/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/TCP/50%/lmbench3

commit: 
  8c57b687e8 ("mm, bpf: Introduce free_pages_nolock()")
  01d37228d3 ("memcg: Use trylock to access memcg stock_lock.")

8c57b687e8331eb8 01d37228d331047a0bbbd1026ce 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1594 ±  3%     +19.3%       1901        meminfo.Mlocked
    149.67 ±  4%      +8.9%     163.00 ±  5%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    969.96 ±  6%     +48.3%       1438 ±  2%  uptime.boot
 6.042e+08            -9.6%   5.46e+08 ±  4%  numa-numastat.node0.local_node
 6.043e+08            -9.6%  5.462e+08 ±  4%  numa-numastat.node0.numa_hit
 6.043e+08            -9.6%  5.462e+08 ±  4%  numa-vmstat.node0.numa_hit
 6.042e+08            -9.6%   5.46e+08 ±  4%  numa-vmstat.node0.numa_local
   4526689 ±  6%    +310.8%   18596060 ±  2%  vmstat.system.cs
    303047            -8.1%     278503        vmstat.system.in
     12.93 ±  5%      -4.2        8.72 ±  3%  mpstat.cpu.all.idle%
      4.39 ±  4%      +9.4       13.80 ±  2%  mpstat.cpu.all.soft%
      5.33 ±  3%      -1.1        4.22        mpstat.cpu.all.usr%
    184478           -34.4%     121014 ±  2%  lmbench3.TCP.socket.bandwidth.10MB.MB/sec
     12082 ±  4%     -33.0%       8091        lmbench3.TCP.socket.bandwidth.64B.MB/sec
    915.46 ±  7%     +50.8%       1380 ±  2%  lmbench3.time.elapsed_time
    915.46 ±  7%     +50.8%       1380 ±  2%  lmbench3.time.elapsed_time.max
  44831013 ±  7%     -44.1%   25067866 ±  3%  lmbench3.time.involuntary_context_switches
     11254 ±  4%     -27.5%       8155 ±  3%  lmbench3.time.percent_of_cpu_this_job_got
      6453 ±  6%      +9.1%       7040 ±  2%  lmbench3.time.user_time
 1.802e+09 ±  5%    +597.6%  1.257e+10 ±  2%  lmbench3.time.voluntary_context_switches
    397.85 ±  3%     +19.4%     474.88        proc-vmstat.nr_mlock
      8096            +2.9%       8335        proc-vmstat.nr_page_table_pages
 1.205e+09            -8.9%  1.098e+09        proc-vmstat.numa_hit
 1.205e+09            -8.9%  1.097e+09        proc-vmstat.numa_local
 9.615e+09            -8.9%  8.756e+09        proc-vmstat.pgalloc_normal
   3414882 ±  3%     +32.2%    4513062 ±  2%  proc-vmstat.pgfault
 9.614e+09            -8.9%  8.755e+09        proc-vmstat.pgfree
    146555 ±  3%     +30.1%     190716 ±  4%  proc-vmstat.pgreuse
      0.65 ± 77%      +0.6        1.21 ± 21%  perf-profile.calltrace.cycles-pp.__tcp_cleanup_rbuf.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      0.58 ± 80%      +1.7        2.23 ±  8%  perf-profile.calltrace.cycles-pp.release_sock.tcp_recvmsg.inet_recvmsg.sock_recvmsg.sock_read_iter
      0.23 ± 51%      +0.1        0.36 ±  2%  perf-profile.children.cycles-pp.record__pushfn
      0.23 ± 51%      +0.1        0.36 ±  2%  perf-profile.children.cycles-pp.writen
      0.21 ± 53%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.21 ± 52%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.generic_perform_write
      0.78 ± 49%      +0.5        1.25 ± 21%  perf-profile.children.cycles-pp.__tcp_cleanup_rbuf
      0.17 ± 78%      +0.3        0.45 ± 24%  perf-profile.self.cycles-pp.__tcp_cleanup_rbuf
      0.33 ± 99%      +1.7        2.02 ± 10%  perf-profile.self.cycles-pp.release_sock
  83660333 ±  7%     +37.1%  1.147e+08 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.avg
  97337639 ±  9%     +37.5%  1.338e+08 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
  71425435 ±  6%     +42.3%  1.016e+08 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.42 ±  4%     +16.7%       0.50 ±  3%  sched_debug.cfs_rq:/.h_nr_queued.stddev
  83660333 ±  7%     +37.1%  1.147e+08 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
  97337639 ±  9%     +37.5%  1.338e+08 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
  71425435 ±  6%     +42.3%  1.016e+08 ±  5%  sched_debug.cfs_rq:/.min_vruntime.min
    104.29 ± 40%     -41.8%      60.70 ± 40%  sched_debug.cfs_rq:/.removed.load_avg.max
    271.46 ±  7%     +17.4%     318.60 ±  4%  sched_debug.cfs_rq:/.util_est.stddev
    839790 ±  5%     -13.7%     724828 ±  3%  sched_debug.cpu.avg_idle.avg
     94203 ± 36%     -46.8%      50142 ± 55%  sched_debug.cpu.avg_idle.min
    312614 ±  8%     +28.3%     401108 ±  3%  sched_debug.cpu.avg_idle.stddev
    500309 ±  5%     +45.6%     728380        sched_debug.cpu.clock.avg
    500675 ±  5%     +45.5%     728646        sched_debug.cpu.clock.max
    499891 ±  5%     +45.7%     728091        sched_debug.cpu.clock.min
    472701 ±  5%     +33.6%     631669 ±  2%  sched_debug.cpu.clock_task.avg
    480686 ±  5%     +34.3%     645473 ±  2%  sched_debug.cpu.clock_task.max
    459106 ±  5%     +33.2%     611651 ±  2%  sched_debug.cpu.clock_task.min
      2864 ±  8%     +95.5%       5599 ± 13%  sched_debug.cpu.clock_task.stddev
     17343 ±  6%     +30.8%      22685 ±  3%  sched_debug.cpu.curr->pid.avg
     20079 ±  3%     +28.2%      25732        sched_debug.cpu.curr->pid.max
     66128 ± 16%     -32.6%      44587 ±  7%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.42 ±  4%     +17.4%       0.50 ±  3%  sched_debug.cpu.nr_running.stddev
  12746739 ±  6%    +370.9%   60025838        sched_debug.cpu.nr_switches.avg
  16962002 ±  6%    +296.5%   67251221 ±  2%  sched_debug.cpu.nr_switches.max
   7092180 ± 12%    +582.2%   48379329 ±  6%  sched_debug.cpu.nr_switches.min
   1956675 ± 10%     +72.0%    3365465 ± 26%  sched_debug.cpu.nr_switches.stddev
    499883 ±  5%     +45.7%     728085        sched_debug.cpu_clk
    498838 ±  5%     +45.7%     727039        sched_debug.ktime
    500718 ±  5%     +45.6%     728919        sched_debug.sched_clk
 7.122e+10 ±  4%      +9.8%  7.823e+10 ±  2%  perf-stat.i.branch-instructions
      0.33 ±  3%      +0.0        0.37        perf-stat.i.branch-miss-rate%
 1.092e+08 ±  3%    +107.4%  2.265e+08 ±  2%  perf-stat.i.branch-misses
     13.88 ±  3%      +7.1       20.93 ±  2%  perf-stat.i.cache-miss-rate%
  2.94e+08 ±  8%     -33.3%  1.962e+08 ±  3%  perf-stat.i.cache-misses
 1.297e+09 ±  4%     -56.4%  5.652e+08 ±  3%  perf-stat.i.cache-references
   4741398 ±  5%    +304.2%   19164589 ±  2%  perf-stat.i.context-switches
 5.582e+11            +5.5%  5.891e+11        perf-stat.i.cpu-cycles
    443841 ±  4%     -36.7%     281171 ±  6%  perf-stat.i.cpu-migrations
     35296 ±  8%     -26.9%      25797 ±  4%  perf-stat.i.cycles-between-cache-misses
  3.65e+11 ±  4%     +10.9%  4.047e+11 ±  2%  perf-stat.i.instructions
      0.65 ±  8%     -42.8%       0.37 ± 24%  perf-stat.i.major-faults
     23.04 ±  5%    +276.7%      86.77 ±  2%  perf-stat.i.metric.K/sec
      3611 ±  4%     -12.8%       3149        perf-stat.i.minor-faults
      3612 ±  4%     -12.8%       3149        perf-stat.i.page-faults
      0.79 ±  5%     -38.0%       0.49 ±  4%  perf-stat.overall.MPKI
      0.15 ±  2%      +0.1        0.29        perf-stat.overall.branch-miss-rate%
     22.67 ±  4%     +12.4       35.07 ±  2%  perf-stat.overall.cache-miss-rate%
      2022 ± 10%     +50.6%       3046 ±  4%  perf-stat.overall.cycles-between-cache-misses
 6.892e+10 ±  4%     +10.9%   7.64e+10 ±  2%  perf-stat.ps.branch-instructions
 1.043e+08 ±  4%    +110.3%  2.194e+08 ±  2%  perf-stat.ps.branch-misses
 2.803e+08 ±  9%     -30.8%   1.94e+08 ±  4%  perf-stat.ps.cache-misses
 1.234e+09 ±  5%     -55.2%  5.533e+08 ±  3%  perf-stat.ps.cache-references
   4509001 ±  6%    +311.1%   18537174 ±  2%  perf-stat.ps.context-switches
 5.613e+11            +5.1%    5.9e+11        perf-stat.ps.cpu-cycles
    412889 ±  4%     -35.3%     267257 ±  6%  perf-stat.ps.cpu-migrations
 3.533e+11 ±  4%     +11.9%  3.952e+11 ±  2%  perf-stat.ps.instructions
      0.69 ±  7%     -41.4%       0.40 ± 23%  perf-stat.ps.major-faults
      3548 ±  4%     -11.9%       3125        perf-stat.ps.minor-faults
      3549 ±  4%     -11.9%       3126        perf-stat.ps.page-faults
 3.226e+14 ±  2%     +69.2%  5.459e+14        perf-stat.total.instructions



***************************************************************************************************
lkp-emr-2sp1: 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 8592+ (Emerald Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/300s/1T/lkp-emr-2sp1/lru-shm/vm-scalability

commit: 
  8c57b687e8 ("mm, bpf: Introduce free_pages_nolock()")
  01d37228d3 ("memcg: Use trylock to access memcg stock_lock.")

8c57b687e8331eb8 01d37228d331047a0bbbd1026ce 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 4.666e+10           +12.1%  5.231e+10 ±  2%  cpuidle..time
   4452013          +145.5%   10928419 ±  4%  cpuidle..usage
    233.91           +46.5%     342.71        uptime.boot
     54574           +10.4%      60225        uptime.idle
     65451 ± 28%     +86.7%     122214 ± 35%  meminfo.AnonHugePages
   4653322 ±  4%    +338.3%   20396688 ±  6%  meminfo.Mapped
     22987 ±  2%    +150.5%      57574 ±  5%  meminfo.PageTables
      1.00 ±100%  +66550.0%     666.50 ±138%  perf-c2c.DRAM.local
     58.17 ± 21%  +15319.8%       8969 ±127%  perf-c2c.DRAM.remote
     11.83 ± 80%  +14446.5%       1721 ±138%  perf-c2c.HITM.local
     19.17 ± 32%  +11917.4%       2303 ±125%  perf-c2c.HITM.remote
     91.76           -27.2%      66.77 ±  2%  vmstat.cpu.id
     22.81 ±  2%    +280.7%      86.82 ±  3%  vmstat.procs.r
      6701            -9.9%       6040 ±  3%  vmstat.system.cs
     47395 ±  5%    +192.6%     138675 ±  5%  vmstat.system.in
     91.77           -25.2       66.53 ±  2%  mpstat.cpu.all.idle%
      0.07 ± 10%      +0.2        0.24 ± 42%  mpstat.cpu.all.irq%
      0.03            +0.0        0.06 ± 25%  mpstat.cpu.all.soft%
      5.84           +25.4       31.28 ±  4%  mpstat.cpu.all.sys%
      2.29            -0.4        1.89 ±  3%  mpstat.cpu.all.usr%
     45.47          +100.8%      91.30 ±  7%  mpstat.max_utilization_pct
   1186980          +334.3%    5154770 ± 10%  numa-meminfo.node0.Mapped
      6229 ± 11%    +131.7%      14432 ±  3%  numa-meminfo.node0.PageTables
   1183346 ±  4%    +317.9%    4945218 ±  6%  numa-meminfo.node1.Mapped
      5409 ± 14%    +154.5%      13769 ±  4%  numa-meminfo.node1.PageTables
   1213253 ±  5%    +323.8%    5142208 ±  7%  numa-meminfo.node2.Mapped
      6317 ± 17%    +129.9%      14522 ±  6%  numa-meminfo.node2.PageTables
   1219782 ±  4%    +311.7%    5022404 ± 10%  numa-meminfo.node3.Mapped
      5915 ± 10%    +143.6%      14409 ±  9%  numa-meminfo.node3.PageTables
    293807 ±  5%    +333.7%    1274238 ± 10%  numa-vmstat.node0.nr_mapped
      1529 ± 11%    +134.5%       3587 ±  4%  numa-vmstat.node0.nr_page_table_pages
    293261 ±  2%    +316.8%    1222310 ±  6%  numa-vmstat.node1.nr_mapped
      1356 ± 12%    +152.5%       3424 ±  5%  numa-vmstat.node1.nr_page_table_pages
    300064 ±  5%    +324.0%    1272313 ±  6%  numa-vmstat.node2.nr_mapped
      1566 ± 15%    +130.9%       3617 ±  7%  numa-vmstat.node2.nr_page_table_pages
    299769 ±  5%    +317.7%    1252275 ± 10%  numa-vmstat.node3.nr_mapped
      1466 ± 14%    +145.5%       3600 ±  9%  numa-vmstat.node3.nr_page_table_pages
     43026            +4.4%      44910        proc-vmstat.nr_kernel_stack
   1205005 ±  2%    +321.4%    5077813 ±  6%  proc-vmstat.nr_mapped
      5917          +142.4%      14340 ±  5%  proc-vmstat.nr_page_table_pages
     79171            -3.6%      76354        proc-vmstat.nr_slab_reclaimable
     21575 ± 22%    +109.8%      45270 ±  8%  proc-vmstat.numa_hint_faults
 1.071e+09           -12.1%  9.412e+08 ±  4%  proc-vmstat.numa_hit
 1.063e+09           -11.6%  9.402e+08 ±  4%  proc-vmstat.numa_local
    198294 ± 27%    +104.9%     406310 ± 37%  proc-vmstat.numa_pte_updates
 1.063e+09           -11.4%  9.423e+08 ±  4%  proc-vmstat.pgalloc_normal
  1.06e+09           -11.4%  9.389e+08 ±  4%  proc-vmstat.pgfault
 1.063e+09           -11.4%  9.421e+08 ±  4%  proc-vmstat.pgfree
    396442            -5.6%     374046 ±  3%  proc-vmstat.pgreuse
      5826 ±  3%     +42.1%       8276 ±  9%  proc-vmstat.unevictable_pgs_culled
      0.01           +65.2%       0.01 ±  4%  vm-scalability.free_time
   1315486           -86.6%     175811 ±  4%  vm-scalability.median
      0.85 ± 17%      +5.3        6.19 ± 57%  vm-scalability.median_stddev%
      1.24 ± 22%      +4.7        5.92 ± 58%  vm-scalability.stddev%
 3.401e+08           -86.8%   45006220 ±  5%  vm-scalability.throughput
    197.44           +55.0%     305.97        vm-scalability.time.elapsed_time
    197.44           +55.0%     305.97        vm-scalability.time.elapsed_time.max
     30562          +186.6%      87583 ±  7%  vm-scalability.time.involuntary_context_switches
 1.059e+09           -11.5%  9.375e+08 ±  4%  vm-scalability.time.minor_page_faults
      1964          +326.5%       8377 ±  4%  vm-scalability.time.percent_of_cpu_this_job_got
      2761          +777.9%      24242 ±  4%  vm-scalability.time.system_time
      1117           +24.6%       1393 ±  4%  vm-scalability.time.user_time
    107496           -12.3%      94315 ±  6%  vm-scalability.time.voluntary_context_switches
 4.742e+09           -11.5%  4.199e+09 ±  4%  vm-scalability.workload
 3.489e+10           -43.5%  1.972e+10 ±  5%  perf-stat.i.branch-instructions
      0.27            -0.1        0.19 ±  3%  perf-stat.i.branch-miss-rate%
  26446125           -31.2%   18182985 ±  2%  perf-stat.i.branch-misses
 1.417e+08 ±  2%     -39.7%   85414690 ± 11%  perf-stat.i.cache-misses
 3.788e+08           -45.6%   2.06e+08 ± 17%  perf-stat.i.cache-references
      6654           -10.2%       5975 ±  3%  perf-stat.i.context-switches
      0.69 ±  7%    +239.3%       2.34 ±  5%  perf-stat.i.cpi
 6.799e+10          +259.9%  2.447e+11 ±  5%  perf-stat.i.cpu-cycles
    588.49 ±  3%     -16.5%     491.20 ±  4%  perf-stat.i.cpu-migrations
    524.75 ±  9%    +285.2%       2021 ± 13%  perf-stat.i.cycles-between-cache-misses
 1.258e+11           -43.1%  7.162e+10 ±  5%  perf-stat.i.instructions
      1.56 ±  3%     -50.9%       0.77 ±  4%  perf-stat.i.ipc
      1.02 ±  6%     -53.4%       0.47 ± 10%  perf-stat.i.major-faults
     41.68           -44.5%      23.14 ±  6%  perf-stat.i.metric.K/sec
   5383984           -44.8%    2971563 ±  6%  perf-stat.i.minor-faults
   5383985           -44.8%    2971564 ±  6%  perf-stat.i.page-faults
      0.08            +0.0        0.09 ±  2%  perf-stat.overall.branch-miss-rate%
     37.40            +4.6       41.96 ±  8%  perf-stat.overall.cache-miss-rate%
      0.54          +542.1%       3.47 ±  3%  perf-stat.overall.cpi
    480.08          +516.6%       2960 ± 13%  perf-stat.overall.cycles-between-cache-misses
      1.85           -84.4%       0.29 ±  3%  perf-stat.overall.ipc
      5222            +2.4%       5350        perf-stat.overall.path-length
 3.465e+10           -41.7%  2.019e+10 ±  4%  perf-stat.ps.branch-instructions
  26086104           -30.8%   18041050 ±  2%  perf-stat.ps.branch-misses
 1.408e+08 ±  2%     -38.1%   87092040 ± 12%  perf-stat.ps.cache-misses
 3.763e+08           -44.1%  2.104e+08 ± 17%  perf-stat.ps.cache-references
      6606            -9.6%       5969 ±  3%  perf-stat.ps.context-switches
 6.754e+10          +275.5%  2.536e+11 ±  3%  perf-stat.ps.cpu-cycles
    584.17 ±  3%     -16.0%     490.74 ±  4%  perf-stat.ps.cpu-migrations
  1.25e+11           -41.5%  7.316e+10 ±  4%  perf-stat.ps.instructions
      1.01 ±  6%     -53.0%       0.48 ±  9%  perf-stat.ps.major-faults
   5346919           -42.8%    3057237 ±  4%  perf-stat.ps.minor-faults
   5346920           -42.8%    3057238 ±  4%  perf-stat.ps.page-faults
 2.476e+13            -9.3%  2.246e+13 ±  4%  perf-stat.total.instructions
    931893 ± 12%    +892.4%    9248299 ± 18%  sched_debug.cfs_rq:/.avg_vruntime.avg
   1446903 ± 12%    +687.3%   11391069 ± 16%  sched_debug.cfs_rq:/.avg_vruntime.max
    481792 ± 17%   +1257.4%    6539912 ± 25%  sched_debug.cfs_rq:/.avg_vruntime.min
    204874 ± 10%    +338.4%     898146 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.09 ± 67%    +287.2%       0.36 ± 16%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.09 ± 70%    +296.6%       0.36 ± 16%  sched_debug.cfs_rq:/.h_nr_runnable.avg
    708874 ± 42%    +532.5%    4483644 ± 67%  sched_debug.cfs_rq:/.left_deadline.max
     63364 ± 46%    +468.8%     360399 ± 72%  sched_debug.cfs_rq:/.left_deadline.stddev
    708816 ± 42%    +532.5%    4483542 ± 67%  sched_debug.cfs_rq:/.left_vruntime.max
     63359 ± 46%    +468.8%     360393 ± 72%  sched_debug.cfs_rq:/.left_vruntime.stddev
    931893 ± 12%    +892.4%    9248299 ± 18%  sched_debug.cfs_rq:/.min_vruntime.avg
   1446903 ± 12%    +687.3%   11391069 ± 16%  sched_debug.cfs_rq:/.min_vruntime.max
    481792 ± 17%   +1257.4%    6539912 ± 25%  sched_debug.cfs_rq:/.min_vruntime.min
    204874 ± 10%    +338.4%     898146 ±  8%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.10 ± 64%    +278.4%       0.36 ± 16%  sched_debug.cfs_rq:/.nr_queued.avg
    708816 ± 42%    +532.5%    4483542 ± 67%  sched_debug.cfs_rq:/.right_vruntime.max
     63359 ± 46%    +468.8%     360393 ± 72%  sched_debug.cfs_rq:/.right_vruntime.stddev
    103.73 ± 59%    +264.8%     378.38 ± 16%  sched_debug.cfs_rq:/.util_avg.avg
    195.87 ± 22%     +53.5%     300.66 ± 13%  sched_debug.cfs_rq:/.util_avg.stddev
     31.73 ± 86%    +384.5%     153.73 ± 17%  sched_debug.cfs_rq:/.util_est.avg
     82.97 ± 51%     +78.2%     147.83 ± 10%  sched_debug.cfs_rq:/.util_est.stddev
    183331 ± 20%     +37.5%     252021 ± 19%  sched_debug.cpu.avg_idle.min
    120841 ±  9%     +41.6%     171158 ±  8%  sched_debug.cpu.clock.avg
    120861 ±  9%     +41.7%     171224 ±  8%  sched_debug.cpu.clock.max
    120779 ±  9%     +41.6%     171052 ±  8%  sched_debug.cpu.clock.min
     13.07 ± 15%    +239.4%      44.36 ± 49%  sched_debug.cpu.clock.stddev
    120651 ±  9%     +41.5%     170689 ±  8%  sched_debug.cpu.clock_task.avg
    120788 ±  9%     +41.6%     171006 ±  8%  sched_debug.cpu.clock_task.max
    105855 ± 10%     +45.7%     154255 ±  9%  sched_debug.cpu.clock_task.min
      2562 ± 99%    +325.1%      10895 ± 17%  sched_debug.cpu.curr->pid.avg
      4577 ± 51%     +81.1%       8289 ± 16%  sched_debug.cpu.curr->pid.stddev
     19843 ± 57%    +640.0%     146849 ±124%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 65%    +146.2%       0.00 ± 53%  sched_debug.cpu.next_balance.stddev
      0.08 ± 72%    +313.0%       0.35 ± 17%  sched_debug.cpu.nr_running.avg
      0.20 ± 21%     +48.7%       0.30 ± 11%  sched_debug.cpu.nr_running.stddev
      2694 ± 10%     +29.2%       3482 ± 10%  sched_debug.cpu.nr_switches.avg
    946.51 ± 11%     +27.7%       1208 ± 13%  sched_debug.cpu.nr_switches.min
      2562 ±  8%     +40.0%       3586 ± 22%  sched_debug.cpu.nr_switches.stddev
    120822 ±  9%     +41.6%     171065 ±  8%  sched_debug.cpu_clk
    119783 ±  9%     +41.9%     170023 ±  8%  sched_debug.ktime
    122204 ±  9%     +41.1%     172446 ±  8%  sched_debug.sched_clk
      0.19 ± 12%    +115.1%       0.40 ± 40%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.05 ± 41%    +346.6%       0.21 ± 27%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      0.01 ± 59%    +577.5%       0.05 ± 30%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 92%    +167.9%       0.12 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.01 ± 14%    +623.5%       0.10 ± 74%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ±  5%    +798.7%       0.12 ± 21%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.02 ± 38%    +525.5%       0.16 ± 52%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 20%    +223.8%       0.04 ± 47%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ± 38%    +852.4%       0.36 ± 66%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.02 ± 18%    +771.7%       0.14 ± 65%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.15 ± 11%     -36.6%       0.10 ± 28%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.03 ± 21%    +865.9%       0.28 ± 82%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.15 ± 17%     -66.0%       0.05 ± 35%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.20 ± 50%  +24616.3%      50.38 ± 80%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      0.02 ± 97%   +1023.3%       0.17 ± 38%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.42 ± 12%    +101.3%       6.88 ± 61%  perf-sched.sch_delay.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
      0.11 ± 74%    +483.3%       0.62 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.02 ± 15%   +1525.2%       0.29 ± 68%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 15%   +2244.7%       0.40 ± 51%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1.02 ±103%   +1337.3%      14.66 ±118%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.02 ± 25%    +418.0%       0.11 ± 54%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.68 ±101%   +6041.8%      41.46 ±129%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      1.12 ± 60%  +49035.6%     551.87 ± 84%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.42 ± 71%  +12165.4%      50.94 ±116%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.27 ± 32%  +31119.3%      84.55 ±221%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1.98 ± 14%    +800.7%      17.87 ± 72%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.10 ± 18%     +70.7%       0.18 ± 14%  perf-sched.total_sch_delay.average.ms
    120.83 ±144%    +528.3%     759.23 ± 51%  perf-sched.total_sch_delay.max.ms
      0.12 ±109%    +533.6%       0.74 ± 43%  perf-sched.wait_and_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.51 ± 43%    +568.9%       3.44 ± 49%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.06 ±101%   +1002.8%       0.66 ± 57%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      1.39 ± 20%    +425.5%       7.30 ± 12%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1.48 ±100%    +754.1%      12.63 ± 13%  perf-sched.wait_and_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     77.50 ±108%    +341.7%     342.33 ± 10%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     70.33 ±100%    +189.6%     203.67 ± 17%  perf-sched.wait_and_delay.count.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1209 ± 34%     +46.0%       1766 ±  4%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.84 ±101%   +1408.4%      12.67 ± 56%  perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      1006 ± 36%     -73.0%     272.14 ± 55%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1.16 ±129%   +5576.0%      66.07 ±143%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     12.52 ±101%    +426.3%      65.90 ± 75%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     10.40 ±102%    +926.8%     106.78 ± 31%  perf-sched.wait_and_delay.max.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.05 ± 36%    +196.2%       0.16 ± 27%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.05 ± 31%    +196.0%       0.16 ± 25%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      0.16 ± 57%    +311.3%       0.65 ± 43%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     11.56 ±122%    +807.8%     104.94 ± 93%  perf-sched.wait_time.avg.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
      0.49 ± 46%    +570.7%       3.29 ± 50%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ±129%    +403.4%       0.05 ± 36%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.05 ± 40%    +494.9%       0.29 ± 50%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      1.36 ± 21%    +416.0%       7.02 ±  9%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1.45 ±100%    +768.6%      12.57 ± 13%  perf-sched.wait_time.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.37 ± 52%    +362.9%       1.72 ± 37%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.23 ± 46%   +4734.9%      11.31 ± 81%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      1.14 ± 46%    +951.6%      12.02 ± 60%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     92.03 ± 49%    +336.8%     402.04 ± 64%  perf-sched.wait_time.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
      1006 ± 36%     -73.0%     272.14 ± 55%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.05 ±121%    +406.2%       0.24 ± 54%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.76 ± 85%   +3220.5%      25.09 ±190%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     10.39 ±102%    +927.7%     106.76 ± 31%  perf-sched.wait_time.max.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-9.4/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/TCP_MAERTS/netperf

commit: 
  8c57b687e8 ("mm, bpf: Introduce free_pages_nolock()")
  01d37228d3 ("memcg: Use trylock to access memcg stock_lock.")

8c57b687e8331eb8 01d37228d331047a0bbbd1026ce 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 4.421e+08 ±  2%     +22.9%  5.434e+08 ±  6%  numa-numastat.node0.local_node
 4.421e+08 ±  2%     +22.9%  5.435e+08 ±  6%  numa-numastat.node0.numa_hit
     15990 ± 95%     -97.3%     437.17 ± 20%  perf-c2c.DRAM.local
      9053 ±  9%     -34.0%       5974 ± 20%  perf-c2c.HITM.local
      9888 ±  9%     -31.2%       6799 ± 20%  perf-c2c.HITM.total
    462.20           -23.0%     355.75        vmstat.procs.r
     70900 ±  2%   +9238.1%    6620774        vmstat.system.cs
    172829           +22.5%     211697 ±  2%  vmstat.system.in
      0.71 ±  3%      -0.2        0.46 ±  7%  mpstat.cpu.all.irq%
      5.89 ±  4%     +11.9       17.74        mpstat.cpu.all.soft%
     90.68           -12.1       78.54        mpstat.cpu.all.sys%
      1.76 ± 10%      +0.6        2.37 ±  2%  mpstat.cpu.all.usr%
   1502311 ± 10%     +50.7%    2263993 ± 13%  meminfo.Active
   1502311 ± 10%     +50.7%    2263993 ± 13%  meminfo.Active(anon)
   4135865 ±  3%     +18.9%    4915987 ±  5%  meminfo.Cached
   1777441 ±  9%     +42.6%    2534680 ± 11%  meminfo.Committed_AS
    305395 ± 16%     -31.8%     208208 ± 14%  meminfo.Mapped
    631369 ± 24%    +123.6%    1411635 ± 20%  meminfo.Shmem
    113990 ± 48%     -78.4%      24658 ±134%  numa-meminfo.node0.Mapped
   4394098 ± 35%     -43.4%    2485612 ± 63%  numa-meminfo.node0.MemUsed
    178139 ± 70%     -94.8%       9344 ± 30%  numa-meminfo.node0.Shmem
   1013397 ± 22%     +92.7%    1952777 ± 19%  numa-meminfo.node1.Active
   1013397 ± 22%     +92.7%    1952777 ± 19%  numa-meminfo.node1.Active(anon)
   1654163 ± 81%    +121.6%    3665933 ± 45%  numa-meminfo.node1.FilePages
    452337 ± 52%    +210.1%    1402518 ± 20%  numa-meminfo.node1.Shmem
     28672 ± 48%     -78.2%       6247 ±135%  numa-vmstat.node0.nr_mapped
     44638 ± 70%     -94.8%       2335 ± 30%  numa-vmstat.node0.nr_shmem
 4.422e+08 ±  2%     +22.9%  5.434e+08 ±  6%  numa-vmstat.node0.numa_hit
 4.421e+08 ±  2%     +22.9%  5.434e+08 ±  6%  numa-vmstat.node0.numa_local
    253743 ± 23%     +92.3%     488048 ± 19%  numa-vmstat.node1.nr_active_anon
    413918 ± 81%    +121.4%     916363 ± 45%  numa-vmstat.node1.nr_file_pages
    113461 ± 52%    +208.9%     350509 ± 20%  numa-vmstat.node1.nr_shmem
    253743 ± 23%     +92.3%     488048 ± 19%  numa-vmstat.node1.nr_zone_active_anon
      3009 ±  2%     +39.9%       4209        netperf.ThroughputBoth_Mbps
    770338 ±  2%     +39.9%    1077702        netperf.ThroughputBoth_total_Mbps
      3009 ±  2%     +39.9%       4209        netperf.Throughput_Mbps
    770338 ±  2%     +39.9%    1077702        netperf.Throughput_total_Mbps
   6400961 ±  3%     -88.6%     729834 ±  8%  netperf.time.involuntary_context_switches
    110445 ±  3%      -9.0%     100508 ±  2%  netperf.time.minor_page_faults
      6907           -62.3%       2601        netperf.time.percent_of_cpu_this_job_got
     20894           -64.5%       7412        netperf.time.system_time
    102.48          +346.5%     457.58 ±  3%  netperf.time.user_time
   4016592 ± 11%  +25096.8%  1.012e+09        netperf.time.voluntary_context_switches
 1.763e+09 ±  2%     +39.9%  2.467e+09        netperf.workload
    375497 ± 10%     +50.7%     565977 ± 12%  proc-vmstat.nr_active_anon
   1033912 ±  3%     +18.9%    1228968 ±  5%  proc-vmstat.nr_file_pages
     76489 ± 16%     -31.5%      52364 ± 14%  proc-vmstat.nr_mapped
    157787 ± 24%    +123.6%     352879 ± 20%  proc-vmstat.nr_shmem
     78136            -1.9%      76672        proc-vmstat.nr_slab_unreclaimable
    375497 ± 10%     +50.7%     565977 ± 12%  proc-vmstat.nr_zone_active_anon
  8.82e+08 ±  2%     +11.7%  9.854e+08        proc-vmstat.numa_hit
 8.819e+08 ±  2%     +11.7%  9.853e+08        proc-vmstat.numa_local
 7.042e+09 ±  2%     +11.7%  7.868e+09        proc-vmstat.pgalloc_normal
   1045876            +3.9%    1086806        proc-vmstat.pgfault
 7.042e+09 ±  2%     +11.7%  7.867e+09        proc-vmstat.pgfree
     55939 ±  3%      -7.1%      51982 ±  2%  proc-vmstat.pgreuse
  20348384           -15.8%   17136384        sched_debug.cfs_rq:/.avg_vruntime.avg
  32341494 ±  2%     -23.6%   24701136 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.max
  16723296 ±  3%     -25.4%   12475358        sched_debug.cfs_rq:/.avg_vruntime.min
   2336769 ±  9%     +58.2%    3697913 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      3.08           -22.1%       2.40        sched_debug.cfs_rq:/.h_nr_queued.avg
      5.39 ±  4%     -20.1%       4.31 ±  5%  sched_debug.cfs_rq:/.h_nr_queued.max
      1.01 ±  2%     -24.6%       0.76 ±  3%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      4.89 ±  3%     -12.5%       4.28 ±  5%  sched_debug.cfs_rq:/.h_nr_runnable.max
      0.95 ±  2%     -20.3%       0.76 ±  3%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
  20348384           -15.8%   17136384        sched_debug.cfs_rq:/.min_vruntime.avg
  32341494 ±  2%     -23.6%   24701136 ±  3%  sched_debug.cfs_rq:/.min_vruntime.max
  16723296 ±  3%     -25.4%   12475358        sched_debug.cfs_rq:/.min_vruntime.min
   2336769 ±  9%     +58.2%    3697913 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
    709.08 ± 33%     +59.9%       1134 ± 12%  sched_debug.cfs_rq:/.runnable_avg.min
    128.48 ±  8%     -13.5%     111.13 ±  3%  sched_debug.cfs_rq:/.util_avg.stddev
      1775 ±  2%     -20.0%       1420 ±  2%  sched_debug.cfs_rq:/.util_est.avg
      3785 ±  3%     -32.8%       2545 ±  3%  sched_debug.cfs_rq:/.util_est.max
    197.58 ± 45%    +137.3%     468.89 ±  3%  sched_debug.cfs_rq:/.util_est.min
    705.82 ±  3%     -41.9%     410.12 ±  3%  sched_debug.cfs_rq:/.util_est.stddev
    454866 ±  2%     -40.2%     271876 ±  5%  sched_debug.cpu.avg_idle.avg
     36878 ±  7%     -76.2%       8790 ±  7%  sched_debug.cpu.avg_idle.min
    266282 ±  3%     -10.9%     237226 ±  5%  sched_debug.cpu.avg_idle.stddev
     65.17 ± 31%     -50.7%      32.10 ± 13%  sched_debug.cpu.clock.stddev
    192576           -10.0%     173278        sched_debug.cpu.clock_task.avg
    183688           -10.2%     164932        sched_debug.cpu.clock_task.min
    860.66 ±  3%     +39.5%       1200 ± 17%  sched_debug.cpu.clock_task.stddev
      0.00 ± 29%     -44.2%       0.00 ± 12%  sched_debug.cpu.next_balance.stddev
      3.08           -22.8%       2.38        sched_debug.cpu.nr_running.avg
      5.42 ±  3%     -20.5%       4.31 ±  5%  sched_debug.cpu.nr_running.max
      1.00 ±  2%     -23.6%       0.77 ±  4%  sched_debug.cpu.nr_running.stddev
     73412 ±  2%  +10555.4%    7822363        sched_debug.cpu.nr_switches.avg
    127466 ± 11%   +8550.4%   11026390        sched_debug.cpu.nr_switches.max
     61589         +7830.8%    4884533 ±  4%  sched_debug.cpu.nr_switches.min
      8655 ± 12%  +23368.3%    2031246 ±  7%  sched_debug.cpu.nr_switches.stddev
     59.31           -81.0%      11.29 ±  2%  perf-stat.i.MPKI
 7.435e+09 ±  3%    +194.0%  2.186e+10        perf-stat.i.branch-instructions
      0.73            +0.3        1.00        perf-stat.i.branch-miss-rate%
  54199426 ±  3%    +291.1%   2.12e+08        perf-stat.i.branch-misses
     60.28           -12.6       47.65 ±  2%  perf-stat.i.cache-miss-rate%
 2.227e+09 ±  2%     -44.8%  1.228e+09 ±  2%  perf-stat.i.cache-misses
 3.682e+09 ±  2%     -30.3%  2.566e+09        perf-stat.i.cache-references
     68267 ±  5%   +9653.1%    6658139        perf-stat.i.context-switches
      8.72 ±  2%     -65.8%       2.98        perf-stat.i.cpi
    684.12 ±  9%     +84.7%       1263 ±  7%  perf-stat.i.cpu-migrations
    151.44           +80.1%     272.70 ±  2%  perf-stat.i.cycles-between-cache-misses
  3.76e+10 ±  2%    +195.0%  1.109e+11        perf-stat.i.instructions
      0.12 ±  2%    +184.1%       0.35        perf-stat.i.ipc
      0.04 ± 36%     -86.1%       0.01 ± 82%  perf-stat.i.major-faults
      0.07 ± 29%  +73057.1%      51.98        perf-stat.i.metric.K/sec
      3130            +3.6%       3244        perf-stat.i.minor-faults
      3130            +3.6%       3244        perf-stat.i.page-faults
     59.27           -81.3%      11.08 ±  2%  perf-stat.overall.MPKI
      0.73            +0.2        0.97        perf-stat.overall.branch-miss-rate%
     60.49           -12.6       47.88 ±  2%  perf-stat.overall.cache-miss-rate%
      8.72 ±  2%     -66.3%       2.94        perf-stat.overall.cpi
    147.03 ±  2%     +80.5%     265.35 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.11 ±  2%    +196.4%       0.34        perf-stat.overall.ipc
      6473          +110.0%      13594        perf-stat.overall.path-length
 7.398e+09 ±  2%    +194.3%  2.177e+10        perf-stat.ps.branch-instructions
  53832186 ±  3%    +292.2%  2.111e+08        perf-stat.ps.branch-misses
 2.217e+09 ±  2%     -44.8%  1.224e+09 ±  2%  perf-stat.ps.cache-misses
 3.665e+09           -30.3%  2.556e+09        perf-stat.ps.cache-references
     67640 ±  4%   +9705.3%    6632391        perf-stat.ps.context-switches
    679.53 ± 10%     +84.9%       1256 ±  7%  perf-stat.ps.cpu-migrations
 3.741e+10 ±  2%    +195.4%  1.105e+11        perf-stat.ps.instructions
      0.04 ± 36%     -86.0%       0.01 ± 82%  perf-stat.ps.major-faults
      3080            +4.6%       3223        perf-stat.ps.minor-faults
      3080            +4.6%       3223        perf-stat.ps.page-faults
 1.141e+13 ±  2%    +193.8%  3.353e+13        perf-stat.total.instructions
      4.32 ± 95%    -100.0%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      4.98 ±  6%     -92.3%       0.38 ±116%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      2.74 ± 28%     -59.9%       1.10 ± 21%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      0.59 ±  3%   +5402.4%      32.50 ± 48%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.79 ± 60%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      1.36 ± 38%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      3.70 ±  6%     -71.5%       1.05 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      1.57 ± 54%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      7.59 ±  5%     -96.3%       0.28 ±129%  perf-sched.sch_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      3.45 ± 55%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mmput.m_stop.seq_read_iter.seq_read
      7.85 ± 13%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      1.80 ± 93%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.__mmap_region.do_mmap
      1.04 ± 16%     -85.5%       0.15 ±216%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      2.26 ± 53%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      3.58 ± 26%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      3.26 ± 37%     -99.7%       0.01 ±223%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.38 ± 10%     -88.4%       0.51 ±223%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1.51 ± 11%     -98.4%       0.02 ±145%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.08 ± 23%     -91.8%       0.01 ±143%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.61 ± 64%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      1.98 ± 31%     -98.8%       0.02 ±223%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      5.98 ± 81%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      3.48 ± 67%     -97.9%       0.07 ±195%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.27 ± 10%   +6194.5%      16.97 ±193%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.25 ± 14%     -97.9%       0.03 ±138%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.06 ± 12%     -76.3%       0.01 ± 54%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.11 ± 87%  +98576.8%     104.10 ± 72%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3.68 ±  2%   +1523.9%      59.75 ± 36%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
      7.44 ±  3%     -92.5%       0.55 ± 21%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      5.16 ±  7%     -76.7%       1.20 ± 23%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.47 ± 18%     -89.8%       0.15 ±196%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      6.65 ± 57%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
     48.97 ± 17%     -87.5%       6.12 ±176%  perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
     29.59 ± 49%  +22847.2%       6789 ± 21%  perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
     12.47 ± 31%   +8381.5%       1057        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.85 ± 63%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      1.89 ± 34%     -86.5%       0.26 ±105%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      2.91 ± 45%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.link_path_walk.part
     44.99 ± 27%  +14850.3%       6726 ± 27%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
     14.01 ± 12%     -29.2%       9.92 ± 46%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.tcp_stream_alloc_skb
      2.25 ± 44%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
     20.58 ±  6%     -93.4%       1.35 ±137%  perf-sched.sch_delay.max.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
     19.88 ± 29%  +10263.8%       2060 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      4.85 ± 54%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mmput.m_stop.seq_read_iter.seq_read
     11.41 ± 20%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      2.78 ± 71%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.__mmap_region.do_mmap
      4.15 ± 16%     -92.8%       0.30 ±218%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      4.57 ± 32%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      6.25 ± 35%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      6.35 ± 20%     -99.9%       0.01 ±223%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      7.68 ± 18%     -93.4%       0.51 ±223%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      7.37 ± 18%     -98.1%       0.14 ±136%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.19 ± 37%     -95.6%       0.01 ±141%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      4.31 ± 65%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      6.15 ± 49%     -99.6%       0.02 ±223%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      8.42 ± 62%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      8.41 ± 66%     -99.1%       0.07 ±192%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
     10.83 ± 36%     -87.0%       1.41 ±149%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      8.83 ± 15%     -99.1%       0.08 ±128%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.16 ± 21%     -87.1%       0.02 ± 61%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     33.75 ±193%   +4375.3%       1510 ± 74%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    129.45 ±106%   +5168.2%       6819 ± 26%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
     61.49 ± 28%  +11976.0%       7425 ± 20%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    180.09 ±145%   +4079.9%       7527 ± 26%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.14 ± 21%     -96.7%       0.17 ±169%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      4.61 ±  2%     -79.7%       0.93 ± 19%  perf-sched.total_sch_delay.average.ms
    201.76 ±126%   +3741.3%       7750 ± 22%  perf-sched.total_sch_delay.max.ms
     17.32 ±  2%     -82.6%       3.01 ± 19%  perf-sched.total_wait_and_delay.average.ms
    298061 ±  3%    +450.2%    1640034 ± 23%  perf-sched.total_wait_and_delay.count.ms
      2725 ± 27%    +468.8%      15500 ± 22%  perf-sched.total_wait_and_delay.max.ms
     12.71 ±  3%     -83.6%       2.08 ± 19%  perf-sched.total_wait_time.average.ms
      2725 ± 27%    +198.3%       8130 ± 19%  perf-sched.total_wait_time.max.ms
      8.84 ±  7%     -76.2%       2.11 ± 20%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
    359.01 ±198%     -99.1%       3.30 ±223%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
    370.11 ± 37%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    229.06 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    422.68 ± 21%     -92.2%      32.86 ±174%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     11.18 ±  2%    +969.4%     119.55 ± 36%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
     15.98 ±  4%     -86.3%       2.19 ± 19%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     10.75 ±  7%     -77.4%       2.42 ± 23%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      9037 ± 14%     -99.9%       4.67 ±223%  perf-sched.wait_and_delay.count.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      5102 ± 29%   +3851.2%     201595 ± 23%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
     11.17 ± 71%     -98.5%       0.17 ±223%  perf-sched.wait_and_delay.count.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      1.00 ±141%    +816.7%       9.17 ± 26%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     18.33 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    649.83 ± 20%     -96.9%      19.83 ± 85%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     28.83 ± 11%     -78.6%       6.17 ± 49%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     19.67 ±  2%     -89.8%       2.00 ± 76%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
    122545           -98.2%       2193 ± 30%  perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
     37034 ± 21%   +2124.3%     823774 ± 23%  perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      7013 ± 11%     -41.7%       4087 ± 22%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    109813 ±  2%    +271.1%     407480 ± 23%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    732.33           -89.7%      75.50 ± 30%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     62.30 ± 24%  +21492.3%      13452 ± 27%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
    521.50 ±141%     -99.4%       3.30 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      1007          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    915.75 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    228.64 ±127%   +5865.5%      13639 ± 26%  perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
     97.53 ± 50%  +15128.8%      14851 ± 20%  perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      1840 ± 10%    +340.7%       8112 ± 19%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1098 ± 17%   +1271.0%      15055 ± 26%  perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2293 ± 25%    +218.7%       7309 ± 27%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      4.06 ±105%    -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      3.65 ± 28%     -69.8%       1.10 ± 21%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      5.89 ±  6%    +605.9%      41.54 ± 24%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      7.37 ± 57%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.32 ± 71%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.99 ± 53%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      5.14 ±  8%     -79.5%       1.06 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      5.59 ±  9%     -64.1%       2.01 ± 80%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.tcp_stream_alloc_skb
      1.48 ± 61%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      7.85 ±  5%     -88.2%       0.93 ±141%  perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      3.45 ± 55%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mmput.m_stop.seq_read_iter.seq_read
      8.04 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      1.69 ±103%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.__mmap_region.do_mmap
    350.00 ±205%     -99.5%       1.65 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      1.93 ± 77%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      3.56 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
    366.85 ± 37%    -100.0%       0.01 ±223%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     59.19 ±133%     -99.1%       0.51 ±223%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      4.25 ±  9%     -74.7%       1.08 ± 81%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    228.98 ±  4%    -100.0%       0.07 ±141%  perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.78 ± 35%     -98.6%       0.02 ±223%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      5.98 ± 81%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      4.51 ± 66%     -98.2%       0.08 ±175%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
    422.15 ± 21%     -95.0%      21.25 ±214%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      7.55 ±  7%   +1856.9%     147.84 ± 40%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      7.50 ±  3%    +697.4%      59.80 ± 36%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
      8.53 ±  5%     -80.8%       1.64 ± 19%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      5.59 ±  6%     -78.2%       1.22 ± 23%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.06 ± 28%     -98.6%       0.02 ±138%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    130.58 ±116%     -88.6%      14.92 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      6.44 ± 63%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
     26.97 ± 35%  +25069.5%       6789 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
     10.50 ± 46%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      1.68 ± 49%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      2.87 ± 47%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.part
    531.77 ± 89%     -96.1%      20.68 ± 37%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     31.98 ± 26%  +20930.2%       6726 ± 27%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
     16.76 ± 28%     -40.7%       9.94 ± 46%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.tcp_stream_alloc_skb
      2.23 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
     20.58 ±  6%     -77.6%       4.62 ±138%  perf-sched.wait_time.max.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
     20.91 ± 16%   +9755.3%       2060 ± 71%  perf-sched.wait_time.max.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      4.85 ± 54%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mmput.m_stop.seq_read_iter.seq_read
     12.63 ± 32%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      2.78 ± 71%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.__mmap_region.do_mmap
    513.55 ±144%     -99.7%       1.65 ±223%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      3.68 ± 64%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      6.25 ± 35%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      1001          -100.0%       0.01 ±223%  perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    339.35 ±138%     -99.9%       0.51 ±223%  perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     21.71 ± 47%     -87.3%       2.75 ± 88%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    915.66 ±  9%    -100.0%       0.14 ±141%  perf-sched.wait_time.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      6.15 ± 49%     -99.6%       0.02 ±223%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      8.42 ± 62%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      9.31 ± 65%     -99.1%       0.08 ±173%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
     11.32 ± 34%     -87.5%       1.41 ±149%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    283.33 ± 21%    +484.6%       1656 ± 66%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    121.31 ±117%   +5522.0%       6819 ± 26%  perf-sched.wait_time.max.ms.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
     54.73 ± 45%  +14104.3%       7773 ± 22%  perf-sched.wait_time.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      1840 ± 10%    +337.4%       8051 ± 18%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1008          +646.1%       7527 ± 26%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.09 ± 22%     -99.3%       0.04 ±129%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      2293 ± 25%    +218.7%       7309 ± 27%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm



***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/fallocate1/will-it-scale

commit: 
  8c57b687e8 ("mm, bpf: Introduce free_pages_nolock()")
  01d37228d3 ("memcg: Use trylock to access memcg stock_lock.")

8c57b687e8331eb8 01d37228d331047a0bbbd1026ce 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    125406           -10.4%     112308        meminfo.KReclaimable
    125406           -10.4%     112308        meminfo.SReclaimable
      0.03            -0.0        0.02 ± 10%  mpstat.cpu.all.soft%
      2.85 ±  3%      -1.6        1.27 ± 26%  mpstat.cpu.all.usr%
      3597           -42.0%       2086 ±  5%  vmstat.system.cs
    119319            -1.1%     117948        vmstat.system.in
   4530881 ±  3%     -68.8%    1411930 ± 12%  will-it-scale.104.threads
     43565 ±  3%     -68.8%      13575 ± 12%  will-it-scale.per_thread_ops
   4530881 ±  3%     -68.8%    1411930 ± 12%  will-it-scale.workload
 1.375e+09 ±  3%     -64.9%  4.824e+08 ± 23%  numa-numastat.node0.local_node
 1.376e+09 ±  3%     -64.9%  4.826e+08 ± 23%  numa-numastat.node0.numa_hit
 1.356e+09 ±  3%     -72.8%   3.69e+08 ± 19%  numa-numastat.node1.local_node
 1.357e+09 ±  3%     -72.8%  3.691e+08 ± 19%  numa-numastat.node1.numa_hit
 1.376e+09 ±  3%     -64.9%  4.824e+08 ± 23%  numa-vmstat.node0.numa_hit
 1.375e+09 ±  3%     -64.9%  4.823e+08 ± 23%  numa-vmstat.node0.numa_local
 1.357e+09 ±  3%     -72.8%   3.69e+08 ± 19%  numa-vmstat.node1.numa_hit
 1.356e+09 ±  3%     -72.8%  3.689e+08 ± 19%  numa-vmstat.node1.numa_local
      3542 ± 89%  +1.7e+05%    6202792 ±222%  sched_debug.cfs_rq:/.runnable_avg.max
      6301           -34.5%       4126 ±  3%  sched_debug.cpu.nr_switches.avg
      4167 ±  2%     -62.6%       1558 ± 14%  sched_debug.cpu.nr_switches.min
      2174 ±  7%     +10.9%       2410 ±  6%  sched_debug.cpu.nr_switches.stddev
    136.67 ± 26%    +803.4%       1234 ± 10%  perf-c2c.DRAM.local
    366.17 ± 21%   +1413.7%       5542 ± 10%  perf-c2c.DRAM.remote
      6364 ±  6%    +208.8%      19652 ±  2%  perf-c2c.HITM.local
    154.83 ±  6%    +834.1%       1446 ±  5%  perf-c2c.HITM.remote
      6519 ±  6%    +223.7%      21099 ±  2%  perf-c2c.HITM.total
    300086            -2.3%     293262        proc-vmstat.nr_active_anon
    129160            -5.6%     121896        proc-vmstat.nr_shmem
     31344           -10.4%      28076        proc-vmstat.nr_slab_reclaimable
    300085            -2.3%     293262        proc-vmstat.nr_zone_active_anon
 2.733e+09 ±  3%     -68.8%  8.517e+08 ± 12%  proc-vmstat.numa_hit
 2.732e+09 ±  3%     -68.8%  8.514e+08 ± 12%  proc-vmstat.numa_local
  2.73e+09 ±  3%     -68.8%  8.514e+08 ± 12%  proc-vmstat.pgalloc_normal
  2.73e+09 ±  3%     -68.8%  8.513e+08 ± 12%  proc-vmstat.pgfree
      0.18 ± 39%   +3637.9%       6.73 ± 23%  perf-stat.i.MPKI
 1.074e+10 ±  3%     -57.2%  4.591e+09 ±  5%  perf-stat.i.branch-instructions
  66071729 ±  3%     -55.2%   29625865 ±  8%  perf-stat.i.branch-misses
     11.40 ± 27%     +21.7       33.11 ±  7%  perf-stat.i.cache-miss-rate%
   9285062 ± 35%   +1457.0%  1.446e+08 ± 27%  perf-stat.i.cache-misses
  79584428 ±  8%    +454.4%  4.412e+08 ± 30%  perf-stat.i.cache-references
      3563           -42.6%       2043 ±  5%  perf-stat.i.context-switches
      5.51 ±  3%    +146.8%      13.60 ±  6%  perf-stat.i.cpi
    148.01            -6.4%     138.61        perf-stat.i.cpu-migrations
     35747 ± 29%     -94.1%       2107 ± 18%  perf-stat.i.cycles-between-cache-misses
 5.253e+10 ±  3%     -59.2%  2.144e+10 ±  6%  perf-stat.i.instructions
      0.18 ±  3%     -58.7%       0.08 ±  6%  perf-stat.i.ipc
      0.18 ± 39%   +3650.7%       6.72 ± 23%  perf-stat.overall.MPKI
      0.62            +0.0        0.64 ±  4%  perf-stat.overall.branch-miss-rate%
     11.42 ± 26%     +21.7       33.11 ±  7%  perf-stat.overall.cache-miss-rate%
      5.52 ±  3%    +145.9%      13.57 ±  5%  perf-stat.overall.cpi
     34676 ± 28%     -93.9%       2109 ± 18%  perf-stat.overall.cycles-between-cache-misses
      0.18 ±  3%     -59.2%       0.07 ±  6%  perf-stat.overall.ipc
   3496124           +31.6%    4602126 ±  6%  perf-stat.overall.path-length
  1.07e+10 ±  3%     -57.3%  4.571e+09 ±  5%  perf-stat.ps.branch-instructions
  65846459 ±  3%     -55.3%   29454957 ±  8%  perf-stat.ps.branch-misses
   9255594 ± 35%   +1455.7%   1.44e+08 ± 27%  perf-stat.ps.cache-misses
  79350913 ±  8%    +453.9%  4.395e+08 ± 30%  perf-stat.ps.cache-references
      3551           -42.6%       2038 ±  5%  perf-stat.ps.context-switches
    147.51            -6.6%     137.73        perf-stat.ps.cpu-migrations
 5.236e+10 ±  3%     -59.2%  2.135e+10 ±  6%  perf-stat.ps.instructions
      2724            -1.8%       2676        perf-stat.ps.minor-faults
      2724            -1.8%       2676        perf-stat.ps.page-faults
 1.584e+13 ±  3%     -59.3%   6.45e+12 ±  6%  perf-stat.total.instructions
      0.07 ±164%    +606.2%       0.52 ± 34%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.83 ± 11%    +182.4%       2.35 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      0.06 ±179%   +2166.3%       1.29 ± 48%  perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      0.19 ± 20%    +154.9%       0.49 ± 44%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.02 ±223%   +8165.9%       1.25 ±138%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.47 ±  9%    +111.3%       0.99 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.50 ±  6%     +92.8%       0.97 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      0.12 ± 13%    +189.9%       0.33 ± 27%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.19 ±104%    +505.3%       1.13 ± 47%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.28 ± 68%    +249.6%       0.97 ± 27%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.19 ± 52%    +355.0%       0.86 ± 52%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.05 ± 57%    +557.6%       0.30 ±107%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.16 ± 14%     +80.9%       0.30 ±  7%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     17.11 ±108%     -99.9%       0.02 ±223%  perf-sched.sch_delay.avg.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      0.02 ± 14%    +109.3%       0.04 ± 15%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      6.68 ± 62%     -49.1%       3.40 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.12 ±179%    +518.2%       0.76 ± 43%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      3.87 ±  7%     +69.2%       6.54 ± 47%  perf-sched.sch_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      0.06 ±169%   +3507.7%       2.19 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      0.02 ±223%   +9304.4%       1.43 ±119%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      3.19 ± 48%     -78.0%       0.70 ±158%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      0.26 ±132%    +953.7%       2.71 ± 40%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.61 ± 64%    +559.5%       4.03 ± 35%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.18 ± 48%   +1582.7%       3.00 ±133%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     17.11 ±108%     -99.9%       0.02 ±223%  perf-sched.sch_delay.max.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      0.35 ±  6%     +87.0%       0.66 ±  7%  perf-sched.total_sch_delay.average.ms
     75.94 ±  3%     +41.9%     107.78 ±  6%  perf-sched.total_wait_and_delay.average.ms
     20535 ±  4%     -41.7%      11978 ±  9%  perf-sched.total_wait_and_delay.count.ms
     75.58 ±  3%     +41.7%     107.13 ±  6%  perf-sched.total_wait_time.average.ms
      0.94 ±  9%    +111.4%       1.98 ± 10%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      1.00 ±  6%     +92.7%       1.93 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
     87.71 ± 50%    +365.7%     408.48 ± 14%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.97 ± 30%     -76.5%       0.23 ±141%  perf-sched.wait_and_delay.avg.ms.__cond_resched.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.03 ±147%    +782.6%      26.71 ± 21%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      2.05 ± 17%     +94.1%       3.98 ± 15%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    175.25 ±  3%    +199.2%     524.30 ± 11%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3879 ±  5%     -47.8%       2024 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
    328.67 ± 16%    +181.5%     925.17 ± 29%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      4765 ±  3%     -52.5%       2262 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
    154.83 ± 13%     -87.0%      20.17 ±141%  perf-sched.wait_and_delay.count.__cond_resched.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
    551.67 ± 10%     -29.9%     386.83 ± 11%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      5573 ±  6%     -75.9%       1341 ± 22%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    297.16 ± 49%    +551.6%       1936 ± 28%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     34.48 ±114%     -91.8%       2.84 ±141%  perf-sched.wait_and_delay.max.ms.__cond_resched.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
    370.78 ±148%    +321.1%       1561 ± 48%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1077 ±  3%    +230.9%       3566 ± 10%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.07 ±162%    +641.0%       0.50 ± 33%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.77 ± 11%    +569.6%       5.18 ±125%  perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      0.05 ±190%   +2300.0%       1.29 ± 48%  perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      0.02 ±223%   +7438.5%       1.14 ±156%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.47 ±  9%    +111.3%       0.99 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.50 ±  6%     +92.8%       0.97 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
     99.70 ± 24%    +309.7%     408.42 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.03 ±147%    +782.6%      26.71 ± 21%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1.93 ± 18%     +88.5%       3.64 ± 14%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.13 ± 82%    +634.0%       0.93 ± 68%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.16 ±129%    +455.8%       0.88 ± 31%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.19 ± 52%    +355.0%       0.86 ± 52%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      4.61 ± 13%     +90.0%       8.76 ± 23%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     17.15 ±108%     -99.9%       0.02 ±223%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
    175.21 ±  3%    +199.2%     524.18 ± 11%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.68 ± 62%     -49.1%       3.40 ± 41%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.12 ±179%    +518.2%       0.76 ± 43%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      3.87 ±  7%   +4323.6%     171.00 ±216%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      0.06 ±169%   +3507.7%       2.19 ± 49%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      0.02 ±223%   +8481.3%       1.30 ±134%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      3.19 ± 48%     -78.0%       0.70 ±158%  perf-sched.wait_time.max.ms.__cond_resched.down_write.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
    329.79 ± 26%    +487.1%       1936 ± 28%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    370.78 ±148%    +321.1%       1561 ± 48%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.19 ±108%   +1175.5%       2.48 ± 51%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.36 ±121%   +1007.0%       4.03 ± 35%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     17.15 ±108%     -99.9%       0.02 ±223%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      5.22           +11.9%       5.85 ±  4%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1077 ±  3%    +230.9%       3566 ± 10%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     50.56            -6.0       44.54 ± 10%  perf-profile.calltrace.cycles-pp.ftruncate64
     50.54            -6.0       44.53 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ftruncate64
     50.52            -6.0       44.53 ± 10%  perf-profile.calltrace.cycles-pp.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     50.52            -6.0       44.53 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     50.52            -6.0       44.52 ± 10%  perf-profile.calltrace.cycles-pp.do_ftruncate.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     50.52            -6.0       44.52 ± 10%  perf-profile.calltrace.cycles-pp.do_truncate.do_ftruncate.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     50.52            -6.0       44.52 ± 10%  perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_ftruncate.do_sys_ftruncate.do_syscall_64
     50.51            -6.0       44.52 ± 10%  perf-profile.calltrace.cycles-pp.shmem_setattr.notify_change.do_truncate.do_ftruncate.do_sys_ftruncate
     50.48            -6.0       44.51 ± 10%  perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_setattr.notify_change.do_truncate.do_ftruncate
     41.58            -5.3       36.26 ± 11%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.shmem_undo_range
     41.59            -5.3       36.26 ± 11%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.shmem_undo_range.shmem_setattr
     41.56            -5.3       36.25 ± 12%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     43.12            -5.2       37.90 ± 11%  perf-profile.calltrace.cycles-pp.folios_put_refs.shmem_undo_range.shmem_setattr.notify_change.do_truncate
     42.26            -5.2       37.05 ± 11%  perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.shmem_undo_range.shmem_setattr.notify_change
      4.64 ±  2%      -0.5        4.13 ±  9%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change
      4.65 ±  2%      -0.5        4.13 ±  9%  perf-profile.calltrace.cycles-pp.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      4.64 ±  2%      -0.5        4.13 ±  9%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr
      4.58 ±  2%      -0.5        4.08 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
      4.58 ±  2%      -0.5        4.08 ±  9%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range
      4.57 ±  2%      -0.5        4.08 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      0.63 ±  3%      +0.2        0.82 ±  7%  perf-profile.calltrace.cycles-pp.lru_gen_add_folio.lru_add.folio_batch_move_lru.__folio_batch_add_and_move.shmem_alloc_and_add_folio
      0.00            +0.6        0.63 ± 19%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      1.47 ±  2%      +0.8        2.23 ± 15%  perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.00            +0.8        0.82 ± 32%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_try_charge.try_charge_memcg.charge_memcg.__mem_cgroup_charge
      0.00            +0.9        0.92 ±  9%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__lruvec_stat_mod_folio.shmem_update_stats.shmem_add_to_page_cache.shmem_alloc_and_add_folio
      0.66 ± 10%      +1.0        1.69 ± 14%  perf-profile.calltrace.cycles-pp.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range
      0.59 ± 12%      +1.1        1.68 ± 14%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio
      0.09 ±223%      +1.2        1.28 ±  7%  perf-profile.calltrace.cycles-pp.shmem_update_stats.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.08 ±223%      +1.2        1.31 ± 18%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__lruvec_stat_mod_folio.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio
      0.00            +1.3        1.27 ±  7%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.shmem_update_stats.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp
     49.10            +5.9       55.01 ±  8%  perf-profile.calltrace.cycles-pp.fallocate64
     46.15            +7.7       53.86 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fallocate64
     45.49            +8.1       53.55 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      0.00            +8.1        8.09 ± 56%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.try_charge_memcg.charge_memcg.__mem_cgroup_charge.shmem_alloc_and_add_folio
     45.32            +8.2       53.49 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     45.09            +8.3       53.41 ±  7%  perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     44.92            +8.4       53.36 ±  7%  perf-profile.calltrace.cycles-pp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     43.94            +9.0       52.96 ±  7%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     43.39            +9.4       52.79 ±  7%  perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      0.00           +11.7       11.68 ± 57%  perf-profile.calltrace.cycles-pp.try_charge_memcg.charge_memcg.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.00           +12.7       12.68 ± 50%  perf-profile.calltrace.cycles-pp.charge_memcg.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.34 ±103%     +14.2       14.51 ± 39%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
     83.55            -9.1       74.42 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     83.55            -9.1       74.44 ±  9%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     83.52            -9.0       74.51 ±  9%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     50.56            -6.0       44.54 ± 10%  perf-profile.children.cycles-pp.ftruncate64
     50.52            -6.0       44.52 ± 10%  perf-profile.children.cycles-pp.do_ftruncate
     50.52            -6.0       44.53 ± 10%  perf-profile.children.cycles-pp.do_sys_ftruncate
     50.52            -6.0       44.52 ± 10%  perf-profile.children.cycles-pp.do_truncate
     50.52            -6.0       44.52 ± 10%  perf-profile.children.cycles-pp.notify_change
     50.51            -6.0       44.52 ± 10%  perf-profile.children.cycles-pp.shmem_setattr
     50.50            -6.0       44.52 ± 10%  perf-profile.children.cycles-pp.shmem_undo_range
     43.26            -5.2       38.02 ± 11%  perf-profile.children.cycles-pp.folios_put_refs
     42.30            -5.2       37.12 ± 11%  perf-profile.children.cycles-pp.__page_cache_release
      1.22 ±  6%      -0.8        0.39 ± 18%  perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      1.16 ±  5%      -0.8        0.38 ± 16%  perf-profile.children.cycles-pp.shmem_alloc_folio
      1.20 ±  6%      -0.8        0.44 ± 23%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.22 ±  5%      -0.7        0.54 ± 34%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.99 ±  6%      -0.7        0.32 ± 15%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      0.96 ±  6%      -0.6        0.32 ± 16%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.80 ±  4%      -0.5        0.27 ± 19%  perf-profile.children.cycles-pp.xas_store
      0.78 ±  6%      -0.5        0.26 ± 18%  perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      4.65 ±  2%      -0.5        4.13 ±  9%  perf-profile.children.cycles-pp.__folio_batch_release
      4.64 ±  2%      -0.5        4.13 ±  9%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.54 ±  6%      -0.4        0.16 ± 10%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.50 ±  6%      -0.3        0.16 ± 13%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.48 ±  5%      -0.3        0.17 ± 18%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.36            -0.3        0.11 ± 16%  perf-profile.children.cycles-pp.free_unref_folios
      0.32 ±  4%      -0.2        0.10 ± 15%  perf-profile.children.cycles-pp.xas_load
      0.38 ±  2%      -0.2        0.16 ± 28%  perf-profile.children.cycles-pp.find_lock_entries
      0.31 ±  6%      -0.2        0.11 ± 20%  perf-profile.children.cycles-pp.rmqueue
      0.24 ±  3%      -0.2        0.07 ± 16%  perf-profile.children.cycles-pp.xas_clear_mark
      0.23 ±  4%      -0.2        0.07 ± 16%  perf-profile.children.cycles-pp.filemap_get_entry
      0.21 ±  4%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.xas_init_marks
      0.16 ±  4%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.19 ±  7%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.__cond_resched
      0.20 ±  4%      -0.1        0.08 ± 41%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.18 ±  3%      -0.1        0.06 ± 23%  perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.15 ±  7%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.fdget
      0.16 ±  8%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.file_modified
      0.15 ±  6%      -0.1        0.05 ±111%  perf-profile.children.cycles-pp.noop_dirty_folio
      0.17 ±  4%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.04 ± 44%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.handle_internal_command
      0.04 ± 44%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.main
      0.04 ± 44%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.run_builtin
      0.08 ±  5%      +0.1        0.20 ± 62%  perf-profile.children.cycles-pp.page_counter_cancel
      0.00            +0.1        0.12 ± 20%  perf-profile.children.cycles-pp.shmem_write_begin
      0.00            +0.1        0.13 ± 19%  perf-profile.children.cycles-pp.generic_perform_write
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.vfs_write
      0.01 ±223%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.__cmd_record
      0.01 ±223%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.cmd_record
      0.00            +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.ksys_write
      0.00            +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.record__pushfn
      0.00            +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.writen
      0.00            +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.perf_mmap__push
      0.00            +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.00            +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.write
      0.09 ±  8%      +0.1        0.23 ± 55%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.10 ±  9%      +0.2        0.26 ± 46%  perf-profile.children.cycles-pp.uncharge_batch
      0.66 ±  3%      +0.2        0.86 ±  7%  perf-profile.children.cycles-pp.lru_gen_add_folio
      0.23 ±  8%      +0.4        0.58 ± 19%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      1.50 ±  2%      +0.7        2.24 ± 15%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.46 ±  6%      +0.8        1.28 ±  7%  perf-profile.children.cycles-pp.shmem_update_stats
      0.34 ± 36%      +0.8        1.18 ± 39%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.00            +0.9        0.85 ± 32%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.67 ± 10%      +1.0        1.69 ± 14%  perf-profile.children.cycles-pp.filemap_unaccount_folio
     96.78            +1.8       98.62        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     96.10            +2.2       98.31        perf-profile.children.cycles-pp.do_syscall_64
      1.31 ±  8%      +2.3        3.59 ± 11%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.14 ± 15%      +2.8        3.97 ± 14%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
     49.17            +5.9       55.03 ±  8%  perf-profile.children.cycles-pp.fallocate64
      0.00            +8.1        8.14 ± 56%  perf-profile.children.cycles-pp.page_counter_try_charge
     45.32            +8.2       53.49 ±  7%  perf-profile.children.cycles-pp.__x64_sys_fallocate
     45.09            +8.3       53.41 ±  7%  perf-profile.children.cycles-pp.vfs_fallocate
     44.94            +8.4       53.36 ±  7%  perf-profile.children.cycles-pp.shmem_fallocate
     43.99            +9.1       53.08 ±  7%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
     43.48            +9.5       52.93 ±  7%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.14 ±  6%     +11.6       11.74 ± 57%  perf-profile.children.cycles-pp.try_charge_memcg
      0.20 ±  9%     +12.5       12.72 ± 50%  perf-profile.children.cycles-pp.charge_memcg
      0.58 ± 24%     +14.0       14.54 ± 39%  perf-profile.children.cycles-pp.__mem_cgroup_charge
     83.52            -9.0       74.51 ±  9%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.19 ±  6%      -0.8        0.44 ± 23%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.21 ±  5%      -0.7        0.54 ± 35%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.68 ±  6%      -0.4        0.32 ± 38%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.46 ±  5%      -0.3        0.13 ± 16%  perf-profile.self.cycles-pp.xas_store
      0.44 ±  6%      -0.3        0.14 ± 13%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.40 ±  8%      -0.2        0.15 ± 47%  perf-profile.self.cycles-pp.lru_gen_add_folio
      0.35 ±  2%      -0.2        0.14 ± 34%  perf-profile.self.cycles-pp.lru_gen_del_folio
      0.31 ±  6%      -0.2        0.10 ± 22%  perf-profile.self.cycles-pp.shmem_fallocate
      0.28 ±  5%      -0.2        0.09 ± 13%  perf-profile.self.cycles-pp.security_vm_enough_memory_mm
      0.31 ±  4%      -0.2        0.14 ± 29%  perf-profile.self.cycles-pp.find_lock_entries
      0.30 ±  7%      -0.2        0.12 ± 63%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.24 ±  7%      -0.2        0.08 ± 12%  perf-profile.self.cycles-pp.__alloc_frozen_pages_noprof
      0.22 ±  5%      -0.2        0.07 ± 14%  perf-profile.self.cycles-pp.xas_load
      0.22 ±  3%      -0.2        0.07 ± 17%  perf-profile.self.cycles-pp.xas_clear_mark
      0.26 ±  9%      -0.1        0.11 ± 49%  perf-profile.self.cycles-pp.lru_add
      0.26            -0.1        0.11 ± 30%  perf-profile.self.cycles-pp.folios_put_refs
      0.19 ±  7%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.shmem_alloc_and_add_folio
      0.17 ±  6%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.18 ±  2%      -0.1        0.05 ± 47%  perf-profile.self.cycles-pp.free_unref_folios
      0.18 ±  7%      -0.1        0.06 ± 16%  perf-profile.self.cycles-pp.shmem_inode_acct_blocks
      0.15 ±  7%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.fdget
      0.15 ±  5%      -0.1        0.05 ± 47%  perf-profile.self.cycles-pp.fallocate64
      0.16 ±  3%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.08 ±  5%      +0.1        0.20 ± 61%  perf-profile.self.cycles-pp.page_counter_cancel
      0.40 ±  3%      +0.5        0.87 ± 53%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.04 ± 44%      +0.6        0.65 ± 60%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.00            +0.8        0.84 ± 32%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.33 ± 37%      +0.8        1.18 ± 39%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.03 ±141%      +1.0        1.01 ± 44%  perf-profile.self.cycles-pp.charge_memcg
      0.98 ± 17%      +2.9        3.90 ± 15%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.10 ±  8%      +3.5        3.60 ± 60%  perf-profile.self.cycles-pp.try_charge_memcg
      0.00            +7.3        7.30 ± 59%  perf-profile.self.cycles-pp.page_counter_try_charge



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


