Return-Path: <cgroups+bounces-8308-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32479AC0273
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 04:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FAA9E4B2C
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 02:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312F86352;
	Thu, 22 May 2025 02:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SyCgdMxe"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8CA76025;
	Thu, 22 May 2025 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747881000; cv=fail; b=mx/vUGasFHTAzlQqKEGQk9GProwq7814dwHMCzVjWA0xKd4ypeFEf9GIF2rRBZaQ52Ll/caFKgzvTe+zXq0P7zPHXi4oCLefdHoS3x1GoBnEmbD49qW+Ci5bsWQtiH+QZimPcfh1rvMzpENpFBXS2oJ/XmIYfMzulmRW1pG4BnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747881000; c=relaxed/simple;
	bh=FHKApG5/IB5zUPUQXGO5HvnvAb25dUoz10XsYm5B4BM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=seXI+h3+LwvGhCaeala7+6jHUigGFZguaZ3W0aCkxUE8PetYeG3OWvLEpYUSkuroRnMzIrUT4H+sp5p0kfw/lQZyaB50xa9r7I9QmdzH+vISfC+duSXms//MxRmdBwtAiyH/etIGza/ISU1XzwvwQ1b/Getv5xBVuUxJu0/fte8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SyCgdMxe; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747880999; x=1779416999;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FHKApG5/IB5zUPUQXGO5HvnvAb25dUoz10XsYm5B4BM=;
  b=SyCgdMxeDc5kfkDfHlOblRuThXPHW3LMFHb8dJG5sdM4ysvM9C+k8v3A
   yVz93dGwn0KpjFZdYZFs/XD08Q5xoV9nNE32fzVY4Ms5FiPPa+kqG7a/t
   h8pKCHZe+NbMYip+ukcfkbT5gdUI49PMoSeS/2EAb059CnPOO2bHnWgmv
   GVb5EAzcuvzyCmQCkTx1LYiQwpPm2/ECWcSK4ndb2SiBGUu5LFLLboriB
   uRFcX03I8xrGOvuGWZ83CnwGo0D65ogcAAoaZ4RAsOmz6EshHcK2MQ16W
   yu25w6B6DFxjCb/BvVQ29txTkKDr/waEDf9uAQxhyHsraxTcCGoE/S3Dw
   w==;
X-CSE-ConnectionGUID: /VEBblnJQRWnF1z1pXm6hw==
X-CSE-MsgGUID: 9NWuCUYhQnKxC2vyVQ+Bvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60936779"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="60936779"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 19:29:59 -0700
X-CSE-ConnectionGUID: XOxKy/OARnK75r+XgMrHfA==
X-CSE-MsgGUID: yhmVYi55Q12gerZNgRtIMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="163629413"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 19:29:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 19:29:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 19:29:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 19:29:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOU8B5hMiJCk+HwTKJZTfKBMzdY99qKt6+dwN1qH0HtY5YyZdztRVRcDHlOwuDnjGR1YETYwWLQxNM5mhdFZ/NoZt0wu10SHYJGCWXGpHC33LiFgQMJjv44mwdP/+BNzr+h873bP/k/+H17Zhc79lrao640F3DiHgQBKG1RqoECjoRTIVxRFGyHge5NxyPghpq3c/STHxvKYkIvq3PC0Re9YDIuExg8Yr/yPw1VuvEBEvj5knW9Ivy4R96wa6sg7PExJgjIuonmX8njJQgNtKiaUBYHbKwqenm48XkJot232qTF8HekgPRDUY5tUy352h8LKV8ZIzMDl9X0A3EoDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eihFRJ036WGABsZ0jfbhurra47veuZJ5ZRyGHBQSkwk=;
 b=TpamW+Y4AIqVW9d+vJ5noCMDnirGPPftkD39+HVMZ1W4EYBQs0MsfU4fD669B/Ie1EgBscZcfgqXGsX7X3sPxzoFoYADHR7JLMndmwIhupMrepqvIA7b9gn/icQIoNEzW9EN86YjZrz5WKjHSEGoaeIJArO2VzOMe1FfsnEBRnrbSKVwtc9Eatrf0CE797rjsU+1/2Uo/OR6zQUypJP9zmz/aj4lRy5D2U3/ixHLUQH92RqlhY5AjNFdbQdEjSaDzdDah4KyQTJhr/PMzlDJJEnndCSOji361s5o8psdc8laoKLrNuSe4ZURJWI0ssFZt23xs5DY5O+sNV+nkfvMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5245.namprd11.prod.outlook.com (2603:10b6:5:388::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 02:29:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 02:29:21 +0000
Date: Thu, 22 May 2025 10:29:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke
	<hare@suse.de>, Ming Lei <ming.lei@redhat.com>, <cgroups@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [block]  245618f8e4: stress-ng.fpunch.fail
Message-ID: <202505221030.760980df-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5245:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffb24e0-5450-4fd8-1600-08dd98d8760a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PrsRTF7jxbxkGHkRTCPkpnVqcnj2VQ/ktAyNxpnH30LYjpcqYTRtgM2ORmDc?=
 =?us-ascii?Q?AhlfDu7eOiWtXIZ6vYXpni6M8lD2s9EPDk3DxcRrKrsFFfHrZ7Kdp6dT9aF8?=
 =?us-ascii?Q?Pzwn24uSmHfP0o8Asqq5PlxD2jg19UA5VHEZnRlQ6qX53qKHeOfj9+Fqnuu6?=
 =?us-ascii?Q?sLYg9fhuyNBeqdm0mQB37cQtj2tRUITVr2B755QqY6FtKM23fDM3fsQvDDwD?=
 =?us-ascii?Q?2P/07Cdae3vqYPyBebJ62h7mhrD3nEh15uYIQDVPnCWReeNGAegWrZphEl33?=
 =?us-ascii?Q?/p7y6t1awu0gXgpH8gjwy9CpOSij2zINgKmmfKjIOOqTfQmuT/Y62G+7psll?=
 =?us-ascii?Q?KcQp37eem2gqSqUUEvFWhWjajXnNyQIgFN3sERnE4y8GnqfQTbW0XcVRFACz?=
 =?us-ascii?Q?eWZQvOnJRD2tuPSYJ7hI5eJrW5oKcuhmsGKa7GKrTWFnNneR6xEDCR3GOk0x?=
 =?us-ascii?Q?rYVwtd/rw54Gr0e3YtrM0utv6RFsWlxXLJ666XBbOqvJpXjyClBIl7h/+OBy?=
 =?us-ascii?Q?0nv+WIxRNmgp9Zu9bQTT4zkMuNJBnlVmkqAvSmZHK11yojmsjLuoV83lVsgH?=
 =?us-ascii?Q?7ICNKSDhKLZ3MXDDUyunswh2I4u5O5hg3WGgE5SjoPG906bY7f/AgqS0O5jM?=
 =?us-ascii?Q?UNRnHUtKFgZfPKHplegc84JMDsuHNx3KXgt4lrcFRV3a9qCt4x0hIJpAMfu+?=
 =?us-ascii?Q?5OiA4wcoiTFWAGU+oBkNUwW5RUp5ymKGsdm3v2zqyR0K78oVec+9noN5HTi7?=
 =?us-ascii?Q?HdRgU3+CK6GPORPK1o7PrBhvp/zic4VQu1uxAZiey2nIJnuScd+sTgQNdwUt?=
 =?us-ascii?Q?w9MWacjA+jUuFkPuvWzCXZRygMn29ehsv3yJfXIoOnWLDad/CkiQUJvnJbkt?=
 =?us-ascii?Q?/X5kjMiTrJZ2hWL3dJdGXq92Ocx24gMaohilXyGyjVuAB3beiHoYE4MJYjyw?=
 =?us-ascii?Q?u6nAGaaotBra/R4lS8YhbPWC0eqUkS8Cn6okeCY+nUvscRUcYAzZZHMxw8Nj?=
 =?us-ascii?Q?NpAV2SfhmtfblVnb16qHGiYjrlqWLCfZxHF8I1a3GhheLRoiXQnZsTCNx19K?=
 =?us-ascii?Q?q4UT/5kq0TR5RlPsh44dRxPWvQjIG08Am0w+IGlEAAd3d8orVOVCxYuHkxN8?=
 =?us-ascii?Q?HmVyruq3ZCv63T8xE8MF7gJqguGtEdEEPBjOMPgTf13AvPoYtQa+HMlKMCdy?=
 =?us-ascii?Q?fd69UIXn/RDGXOYku1Mek7nzLlhFVD7LmhosuOgsBrsnYmwu7Iug42FkR2jm?=
 =?us-ascii?Q?Udj4DXV1zyzadMOQzkhuDTb6rPObfzFZzNa/8K4BOdiLU0M6ZXqxWh2TBR91?=
 =?us-ascii?Q?0OGoF0e1w6VbiK+RnHWu+YWNMHw6Txl3Xs1jW8rgEvnPjXR7UuSuVV2ppH4v?=
 =?us-ascii?Q?r5Uas1F9OF8OWgQxyVSL2Ltgl3hg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PfYt4oPHPyIYIyLXdKimvePUJhkiXljtz0j3IgM5YB+hCXubNUg4Lxh/ZoKD?=
 =?us-ascii?Q?TZyXUOOlqLdtEt8Nm5WEBwAGLVz+vzNuYJ4LMqS8lRQ3W9v+gbVPTh7skMU5?=
 =?us-ascii?Q?/gZ5kZZT+y2lMB3rRQOKxXNWj5ilhONb6bTb5Kvd1IjDV7bDROi7uxSEY/Yr?=
 =?us-ascii?Q?IIOoAQ/ylKXtB+1LU4XdVYDFN3znq1tnoXrZA2NlkVItbnC/nslHt4UiujcN?=
 =?us-ascii?Q?UJELNC515SwXzvlojNfMbAdPCJWb3cYlleDM+5pv+xzbjB7VeLEtLKE3EtDK?=
 =?us-ascii?Q?2RiKPaczYqsL0TMKRaSAZY7lm+o/LTii4cOx0mym5/8iXiwzprgXgOWiVDzw?=
 =?us-ascii?Q?4KpQ23Wn0AK8iFxFEgE94FU5CNG4JxR7W3bokKrK7R51cQ/mxq+enJ+t3qxz?=
 =?us-ascii?Q?f3NLAK5ZPQB8OtND1x3Gn4C7DTu3jDqcySxb6g5LI3lPMav93YjX8dfm9LbR?=
 =?us-ascii?Q?A/LDgrWQASmKnVURrkiOS4l0f7TEbJmuF0YAhR5Zv8CMxLES8MFUmK5frl2K?=
 =?us-ascii?Q?kY+1VY3gfCfYVmN4aI203X+Dhs9qc8tPwY0JLjJetzwNP8nH8srr0/qd44Nz?=
 =?us-ascii?Q?CqSoQI+aB2NuRZuTxyol9bIowSiujVkYzVwwtRuyonzLLmhhPVK1G29K7uMe?=
 =?us-ascii?Q?Icf6euFmeoYcGMiW1yo2PxXQbopxQ+z3bCT+gjP23C9DM/XA+j7jb/zqw+6F?=
 =?us-ascii?Q?YZt6uWd3CYmZ5Y51gkTkdqhIZHN2PywlbZkuWf5IxB6FQZwoary3j3tpvWAx?=
 =?us-ascii?Q?t5pCpXLsLSf2KdsI+6kW7n7oQuSESv+/OyoQNiTulpagMjHEhcWaaHJ4C5yr?=
 =?us-ascii?Q?eA5hwvatXDx2w1MveWqIceY+hYbJhwLrFlOqmwYu5UU89ZVu6xe9iJca3/KX?=
 =?us-ascii?Q?IOcG0cYwYktYcMPSBjuCQLwvWezZ+Ng4fmzRGc3dmh/WT1GyEWVszviCD/lT?=
 =?us-ascii?Q?goFrIMIwE3qbppuzQEceTg+QUnJ850XMCU9MneE5zgy1LA2rz21zIIKkMmhL?=
 =?us-ascii?Q?o4K5XsrZ8S0QTtqZFjAW3y80p+DcFL73UUCyBLmxXoFEirFP5RYh9gCT0/Jj?=
 =?us-ascii?Q?ssAXoOaOL0JXydu9Dk47jIDRKzw8yme/LwpSiFaE63X+4N0NWYFgTaKpuX8Q?=
 =?us-ascii?Q?mJMhKhg+7emYGn9D4QOcz+CWbLxJv5h/o/yikOfz9Q42EuF5E4VYu9pMexxw?=
 =?us-ascii?Q?OZloUH4eK2eeAU/7XxGGmux2SV60Sj1uK1jkhoVWobQkHh+3hJZe4XqZExRE?=
 =?us-ascii?Q?su/2/RR06hvWzK4EMeqNbco0Rx2vaGwsFvrCJXi/acs0+7Nm2Zv6kCUgBlX4?=
 =?us-ascii?Q?1eigd6jfAsG6RhG7LRt+gExt//8A8U695/UCfabioM1zBFZmUHfXcV8NolzM?=
 =?us-ascii?Q?O9EElJDxEr9L/PudCl3RJU9nB3oP/VQnZc2FKSrhF5t3Xil/QImBOndGjE7x?=
 =?us-ascii?Q?lJyP8fwqiHE7Ui4soyWgex+HzQrvy+FGdtts2kWPq/CLVkv2PG/3+Mh5ycds?=
 =?us-ascii?Q?NXBO4MK2HcsvZGCIEQ7sBTpRuxLielBrV7o1ZakkoP+pPfPXGzkvh3ZJeyuS?=
 =?us-ascii?Q?hTU+5Cr6FfBq7eybTJvv5DwtEGSw/+O+B1x+WDFZb5sGIDf96kA5v8vdTzu4?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffb24e0-5450-4fd8-1600-08dd98d8760a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 02:29:21.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3E54juvIqyBKoL5zqQBgazmvS4KWKmZDSdYJOjCRj/Ilu5xX+Z4n2k14ydnTP2LzQKIZDdOJZNL2W6CDBu2x5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5245
X-OriginatorOrg: intel.com



Hello,


we don't have enough knowledge if this is a kernel issue or test case issue.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/disk/testtime/fs/test/cpufreq_governor:
  lkp-icl-2sp4/stress-ng/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4/gcc-12/100%/1HDD/60s/xfs/fpunch/performance

3efe7571c3ae2b64 245618f8e45ff4f79327627b474
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     stress-ng.fpunch.fail

since the failure is persistent, just report what we observed in our tests FYI.


kernel test robot noticed "stress-ng.fpunch.fail" on:

commit: 245618f8e45ff4f79327627b474b563da71c2c75 ("block: protect wbt_lat_usec using q->elevator_lock")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      b36ddb9210e6812eb1c86ad46b66cc46aa193487]
[test failed on linux-next/master 8566fc3b96539e3235909d6bdda198e1282beaed]
[test failed on fix commit        9730763f4756e32520cb86778331465e8d063a8f]

in testcase: stress-ng
version: stress-ng-x86_64-1c71921fd-1_20250212
with following parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: xfs
	test: fpunch
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505221030.760980df-lkp@intel.com

2025-03-20 08:33:52 mkdir -p /mnt/stress-ng
2025-03-20 08:33:52 mount /dev/sdc1 /mnt/stress-ng
2025-03-20 08:33:52 cd /mnt/stress-ng
  File: "/mnt/stress-ng"
    ID: 82100000000 Namelen: 255     Type: xfs
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 78604800   Free: 78518242   Available: 78518242
Inodes: Total: 157286400  Free: 157286397
2025-03-20 08:33:52 stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --fpunch 128
stress-ng: info:  [4680] setting to a 1 min run per stressor
stress-ng: info:  [4680] dispatching hogs: 128 fpunch
stress-ng: info:  [4680] note: /proc/sys/kernel/sched_autogroup_enabled is 1 and this can impact scheduling throughput for processes not attached to a tty. Setting this to 0 may improve performance metrics
stress-ng: warn:  [4680] metrics-check: all bogo-op counters are zero, data may be incorrect
stress-ng: metrc: [4680] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [4680]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [4680] fpunch                0    557.92      0.40     19.56         0.00           0.00         0.03          3180
stress-ng: metrc: [4680] miscellaneous metrics:
stress-ng: metrc: [4680] fpunch              2049.12 extents per file (geometric mean of 128 instances)
stress-ng: info:  [4680] for a 620.45s run time:
stress-ng: info:  [4680]   79418.05s available CPU time
stress-ng: info:  [4680]       0.40s user time   (  0.00%)
stress-ng: info:  [4680]      19.59s system time (  0.02%)
stress-ng: info:  [4680]      19.99s total time  (  0.03%)
stress-ng: info:  [4680] load average: 250.69 349.62 213.80
stress-ng: info:  [4680] skipped: 0
stress-ng: info:  [4680] passed: 128: fpunch (128)
stress-ng: info:  [4680] failed: 0
stress-ng: info:  [4680] metrics untrustworthy: 0
stress-ng: info:  [4680] successful run completed in 10 mins, 20.45 secs


we don't observe any abnormal output in dmesg. below is an example from parent
commit.

2025-03-20 09:12:39 mkdir -p /mnt/stress-ng
2025-03-20 09:12:39 mount /dev/sdc1 /mnt/stress-ng
2025-03-20 09:12:39 cd /mnt/stress-ng
  File: "/mnt/stress-ng"
    ID: 82100000000 Namelen: 255     Type: xfs
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 78604800   Free: 78518242   Available: 78518242
Inodes: Total: 157286400  Free: 157286397
2025-03-20 09:12:39 stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --fpunch 128
stress-ng: info:  [4689] setting to a 1 min run per stressor
stress-ng: info:  [4689] dispatching hogs: 128 fpunch
stress-ng: info:  [4689] note: /proc/sys/kernel/sched_autogroup_enabled is 1 and this can impact scheduling throughput for processes not attached to a tty. Setting this to 0 may improve performance metrics
stress-ng: metrc: [4689] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [4689]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [4689] fpunch             1166     60.31      0.11     34.66        19.33          33.54         0.45          3164
stress-ng: metrc: [4689] miscellaneous metrics:
stress-ng: metrc: [4689] fpunch              2051.97 extents per file (geometric mean of 128 instances)
stress-ng: info:  [4689] for a 60.91s run time:
stress-ng: info:  [4689]    7796.93s available CPU time
stress-ng: info:  [4689]       0.11s user time   (  0.00%)
stress-ng: info:  [4689]      34.68s system time (  0.44%)
stress-ng: info:  [4689]      34.79s total time  (  0.45%)
stress-ng: info:  [4689] load average: 325.78 93.83 32.28
stress-ng: info:  [4689] skipped: 0
stress-ng: info:  [4689] passed: 128: fpunch (128)
stress-ng: info:  [4689] failed: 0
stress-ng: info:  [4689] metrics untrustworthy: 0
stress-ng: info:  [4689] successful run completed in 1 min


from above, parent can finish run in 1 min, then has "bogo ops" and "bogo ops/s"

for 245618f8e4, the test seems run much longer, and the results for "bogo ops"
and "bogo ops/s" are all 0.



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250522/202505221030.760980df-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


