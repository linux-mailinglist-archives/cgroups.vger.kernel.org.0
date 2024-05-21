Return-Path: <cgroups+bounces-2965-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3393E8CAA5A
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 10:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EFB1C20370
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 08:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21C75478B;
	Tue, 21 May 2024 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBMwhBWK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEA94CDE0;
	Tue, 21 May 2024 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281419; cv=fail; b=JjXV/funLewSiG3xRoAdr0clMQFhhr54M/NAHyXUBOk7sDFWEDHhFIf36XkmkLN9mRvglcjiaQnP31V2+KU2raaQQ2HhLKO7PkXxh0YuQlM8JOFgdNkl3bxoXB2jS37Px1+ffmJBHzS4UXETAhLI3+a7S4IdsDEH6lIm9OLktEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281419; c=relaxed/simple;
	bh=/H4nF+ohEKCpXhLiayO3OrtEVH44yo/m1T7+v+sBJ60=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iMkBaIy0QQi2IPL8bXGqE7scrMSC4meBQrJW2jLTJ3mDUtQJeaN9gy7x84EXxgosAkrpC7qy+lGiQgDK0EhHA9TnqkpBJkGefecnh5XKyHOnQ7zbSXly3v65AbIuxrGqcw131erjs2yJrSHnP1v9H0ovQhBI8KQD/KcXEXvR7Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBMwhBWK; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716281417; x=1747817417;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/H4nF+ohEKCpXhLiayO3OrtEVH44yo/m1T7+v+sBJ60=;
  b=nBMwhBWKMPZ8TfRR9m3ppuLvCYmWqArM9ndXYl6qGu5lDVaRCmG2FVZE
   2KVDc3Bxki3FCN/JsPKtRa6OJsMFGzz47f6nl1noEfu7SmNIPhfRc4D9L
   xIfCezdi1lzqQLUdM5ynUAcXNHM5Ub3CCDVDGQCyV2oOgQrfFZfz4bWWf
   2pnBBDw0Uv6X8U3kwuoAX/RJaJ8JOF3aYUlAJ6Q5wGDEnkzsXGXNMXP1e
   YRBfPXGxARzrmkXYlQLLYuffv3xwR8NvNKlyxoD7XfvC1dUI9OYcOcefV
   0+DRcXlKlusRuwEjT0EL12ETXwKc2YUuKmLpuPRJViw6YCVYafv8zVS4J
   g==;
X-CSE-ConnectionGUID: 7SnSZ6OdSBmKrF2jEd5rMg==
X-CSE-MsgGUID: aKTJ+b+CTMq1WnDrTu3sjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23861219"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="23861219"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 01:50:17 -0700
X-CSE-ConnectionGUID: A8UAQ+I9RxaTGF9VhvxCsQ==
X-CSE-MsgGUID: nAOXLrMzRpuTaf6ppSMtzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="32966365"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 May 2024 01:50:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 01:50:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 01:50:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 01:50:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMVpaCafJsBQ3wWDJbssqVU/jcUH4YpOij909s+DUaP2UP3hhwIdgyz8DaS4gFMItFZOh22BtSDELpO+S+/Z4IMcYBurMhr3XBRuuLtrTk7W9238anlmG50vm4s8Rnb6Hq9VsBj6Uin5kdXrJYtusL7aD4ZRv/SNiipRmGMFDkbci1UeDV1x+jIlGDBx0ZRkIdHh//kuxrowO9qwap5y8fjUeAC5+rq7T1mMHoGCpV6OI0MRD+uw/WVA+Cvza04JQBZjYcWiEaXHe8F/fUEwUN88N9uk/bCgXAd7++Ex94UGsaAzvJa85SogJ+nAblTydqxWMIZVI47FAeW4wQoD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkkTuLYvjQcAkE8mxgP/rv3Agj+/Rtc9jYrLK+3jlig=;
 b=BOojMnk0y/hBXicoiqaa/RlNHOiID5M81JbwquXnP1tJWnJzDe2num+Fx+u5rNT67sLwuQWOc0UuHwSqOap7KqMA42AYOwAXPgkJ3nZkDAAfOXIX3W3aRbXHka0RAm0p9FjEoXHDAV0kwT7q4gpHmoWF81ebBZkmWvtfqk7X9AnH9MmTLKoEMjVY8sbPs8PbEmnvfYOwuCAR64TwZA/O7IM6KNWU7M4k4GeBpefwB8sHaLXEpFHqaFdhdYk9Z0H88uQkmvq8Ni0rEob26Q5inDEdo5wph44vpPB+Xl2XNoGN/n7LKCrOCPZy/u5+V3O7Sj4Adn9c/rvfNRuAjeDAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 08:50:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 08:50:13 +0000
Date: Tue, 21 May 2024 16:50:03 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt
	<shakeel.butt@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, "T.J. Mercier"
	<tjmercier@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko
	<mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  aab6103b97:
 kernel-selftests.cgroup.test_kmem.test_percpu_basic.fail
Message-ID: <202405211653.efc447b0-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL1PR11MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: aae8b710-af7f-4812-ec2e-08dc79730772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DF4N0YLdtdi3gw8H+fp5I8iUsGI6Vmw1Wwb/t/Cei1ZCHCZLRYwc604GwPkp?=
 =?us-ascii?Q?GUc4AYPiuzQJFtQyc+tPlbSdYyikVnDYAcvS7D1psbAGQTtkPjpB0kgIgBPS?=
 =?us-ascii?Q?P4uGTH10QJt0X8Px19NY/auI119m1T6OqlHvRdafx8OxZ9JyyhxX0XGRlIl8?=
 =?us-ascii?Q?Bs0UZrjCRwBMNz1giiypb5w9NAt8Za6p+ntdH7NjW85ipk2tGcWNUfJrGRav?=
 =?us-ascii?Q?pGMl9k/6MZXhQXIctWZmqTvS4wEKQOqPQdJooDc7mOSARKrZ9siwthcSY0F2?=
 =?us-ascii?Q?Jo1IDEWoiolE8nzrqYADRp1SZM9IcPSGPTMeT31cz2z6L47GrqWW+lsdN+cB?=
 =?us-ascii?Q?bWoRjTYTG96FrjETE1eluVWJqCjynXQ77AUDwd4yhKXDy+UOmuJO/gCzGBWd?=
 =?us-ascii?Q?Ql9KJYASl+KS5Z0BcIoANwRnlbd5f3o2SCP5JP5smoUPW3157Oeml4evtnFm?=
 =?us-ascii?Q?L0fiEZLJzyxng3joStl3TVKlqTET0Bp9Y4UDCRmJiaY6Z5RVOGe968KbKMjE?=
 =?us-ascii?Q?tZt+lONbJKMxbqfHChCccir/4hIEQFYTeqNLvPWX82qzGeFVUzm8LWmPQEy8?=
 =?us-ascii?Q?lEbj+EByL8WGelHdsJ92T5WoZ6Pdugs4RzdHVRBuv9+pDcLRGGzMjYL3t5Jr?=
 =?us-ascii?Q?zk0zWd14LQzAn5zWVQPiIMWRKQZqr6vzx9lwYY5iuuJGUeZKFh0HdhbkzfIz?=
 =?us-ascii?Q?rHe/iAN/XkgWoq4w7GUk+m+ENbJwbRhjylr2Vq1lziNC5ENzlcy4Qjh0Pwcs?=
 =?us-ascii?Q?0vxRIAr1Ta6r1zvHphisK8UM4+9R4kIeyqUmc4yMTQP/0TwzdPYy+DGqFlHp?=
 =?us-ascii?Q?88tvICfu7ZcvLCALESmhVfb3Vk3H8l4Ma2GrUx5iJd2XvcS8uhUm5PxwsKhb?=
 =?us-ascii?Q?tCtBtcSN89hZqmR94sPnLgtsWQN/BS3JQ/kojWiyXUqkKLROY+iLq4fJqZW5?=
 =?us-ascii?Q?THFnXyNmb9jSmc/6HHwvH484IibVlPpNGdhK6LDUrZ1z4u2Uy/H/PpEspRAz?=
 =?us-ascii?Q?R8Kzr6WljX5jS4u5sEovsQa0bNN4qhOnt6KEWOvQGnarkCDau6Jfl3kkyvVm?=
 =?us-ascii?Q?txfQynTQ5DLsiUbXYeFxdRxQIACzVExsx+0ZqAtyEz5eFTvlhWpxP9yWtMZu?=
 =?us-ascii?Q?d0HPTqtHjrrdWGSwCR/3Ec1etFwzfaBQyw4hPmSYHINF5zZP4tn11L3oiSmT?=
 =?us-ascii?Q?Gd5KUduIAnz2gascqU8YRIkoJ5ELlwanFE2XE0ioLJ3Bq/JnXzq8yLUvvAc?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQxIImQv6CLXMLtvZlrPsoE3rj47jxA0vGepG2XsZTN00tQv/ib7bQKJmcq+?=
 =?us-ascii?Q?2sQYnrMamVY7nezq9z45jLA5MgBin1zfr4Ut83Mp4wjH10Ybg6scPrKzqeCr?=
 =?us-ascii?Q?2p4VOZzTrYXKUCmKK37asDCznPvKb1rCyeEJ+to95YFTLIUEGw6h2AxsMk8O?=
 =?us-ascii?Q?yV/hAYZMZx/h3n+vsRBmeADovBjOxfgKzB1mOMU4PxnCV+fdUnrXF2X5RJTr?=
 =?us-ascii?Q?zuPrz13SL4ZF9+AeQLShb3pVtTp2O1+glyAx51D6LyFBC5R0v3sDktzFYYO2?=
 =?us-ascii?Q?Jv66oMZuJa1pmUTnFkBtQexpfIZ28losTctwryYnSaFS/VDRMebm9ON9iKyl?=
 =?us-ascii?Q?S/gK9cyOhnV2srYfs2bfVj1vDT0VOXwEQ737HaRv29zkOnREzpOmFc2twxDN?=
 =?us-ascii?Q?sKYB0jctkVxuLWy9w0T/IBeBoRbGJQ3djijf7JtJUcob74gsvEQCQPo5utCK?=
 =?us-ascii?Q?clkXspB+LaxV+pPQzocXoFsILJT5R83NJ2511I2bas/9ydnexPj/4/bgezui?=
 =?us-ascii?Q?aBmvIUrp/12ZhR6YkNpimMeeAbmXtItmJ9336JfNKjFqoFKN7AjRpMHXC5Ah?=
 =?us-ascii?Q?ijV2qEMgApbQOK1m8UYGe9ESxAPkUFJhyD6D496NTNibGb66s9QmVqIYgjhj?=
 =?us-ascii?Q?B6G38O1memH6QMGRC2BKLYnWnbe1sdirTieqwUfd9PQIARNCSN5ZUSxevcpZ?=
 =?us-ascii?Q?vsLox3URJCfFphV1zmstyUpRDaFB9Gi0znCs0GYtOGG4VrTgY9cL7GIG9BRY?=
 =?us-ascii?Q?N2nKOFdMnCtYlN+tX+sWkv5YRushFNiTL29p1H5LaHhijwD/6Ml9Ultx6ih7?=
 =?us-ascii?Q?gsQuu1lxzPc2BOv7J2ZLXGA+qLApWwbtnrtYX5ihkHJTVng6R2N9R3JPg9my?=
 =?us-ascii?Q?bzrREV/Fi92Act0q1flEABXd1Qs/lc0vyA/kvlE0hFmzb3n+vPq4le1j6cZe?=
 =?us-ascii?Q?EvF4fStaJ+JloZoOUcAeMRYRMmtWZ3gGqhoaxyr+RCNk1JH6sDUwBZy5WpAN?=
 =?us-ascii?Q?7BpfCH18AH5ZAE+pqhmkrsFDDrXwgKQto8UKoTSjgC9Ztks0uYAD8ALlWAUW?=
 =?us-ascii?Q?Ew258H9UfBL7UTufSEAueZxuS4a2QXJteLwiMGmL4dJhDqDMq3wWMbEhjjP3?=
 =?us-ascii?Q?I8IWYaa1s1KonVodN29u6Yi5KZNfQQlDCRGVdVQz4Lq3pGSwEmQCV2DXpmze?=
 =?us-ascii?Q?gaHPp483Cxg7xxoQ1Bq6kGaArNmXfwLuAQ7+HBmRNfHP0t385AlQrFytHCkn?=
 =?us-ascii?Q?QL8/ZQplILVv2xMx1SfDn4DUhGevAO8++8HzmA1eJyfEUl1e4llL2i04zVq2?=
 =?us-ascii?Q?b3t8CHQixGQxTQFYCgg4Yohozof3dslbyqEvVciFfFBH2Yc5GiocT7CDDiqD?=
 =?us-ascii?Q?cFlWeKsUgC+wJ+lrK4LMC4KrUT/SZWaj209so8VeJhjluc3iEVDXiCnr0umS?=
 =?us-ascii?Q?OJP2rqOEPcsTLevBDffTxgyTE3OU+II2fYbQgDEojkh9XscKnefo/WiAF7te?=
 =?us-ascii?Q?Tyftlejl6hug/pOuvyVt3Wc/Lv/+mlU4fDD56VNL3DOv3128yhtM9KnztxiD?=
 =?us-ascii?Q?og4LYgvz3H36QJ48PCCrAvpWRlpriJ+DDN17mXZQCFrfoX7yX1PN8f3i+mPL?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aae8b710-af7f-4812-ec2e-08dc79730772
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 08:50:13.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLo/88JiHeyVsppKHGoz7YT79umBnxLv/HrTCxpCc+Wzdasd7quCaA0j30TXra0BRTMYZpiFOe5B3rH4FmzVYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.cgroup.test_kmem.test_percpu_basic.fail" on:

commit: aab6103b97f1c7ca6cf33e78d5e6916e53fc265c ("mm: memcg: account memory used for memcg vmstats and lruvec stats")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: kernel-selftests
version: kernel-selftests-x86_64-977d51cf-1_20240508
with following parameters:

	group: cgroup



compiler: gcc-13
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405211653.efc447b0-oliver.sang@intel.com



# timeout set to 300
# selftests: cgroup: test_kmem
# not ok 1 test_kmem_basic
# ok 2 test_kmem_memcg_deletion
# ok 3 test_kmem_proc_kpagecgroup
# ok 4 test_kmem_kernel_stacks
# ok 5 test_kmem_dead_cgroups
# memory.current 20549632
# percpu 12096000
# not ok 6 test_percpu_basic     <------
not ok 2 selftests: cgroup: test_kmem # exit=1


the case always pass on parent

70a64b7919cbd6c1 aab6103b97f1c7ca6cf33e78d5e
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     kernel-selftests.cgroup.test_kmem.test_percpu_basic.fail


below is the log from one parent run:

# timeout set to 300
# selftests: cgroup: test_kmem
# not ok 1 test_kmem_basic
# ok 2 test_kmem_memcg_deletion
# ok 3 test_kmem_proc_kpagecgroup
# ok 4 test_kmem_kernel_stacks
# ok 5 test_kmem_dead_cgroups
# ok 6 test_percpu_basic     <-------
not ok 2 selftests: cgroup: test_kmem # exit=1


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240521/202405211653.efc447b0-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


