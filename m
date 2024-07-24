Return-Path: <cgroups+bounces-3876-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC56493AD92
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 09:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF9C284346
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 07:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C24312AAFD;
	Wed, 24 Jul 2024 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKxq9T7j"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A167A0D;
	Wed, 24 Jul 2024 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807870; cv=fail; b=qEh1vOfbrYocgzh1GiDocXBgcbj86D8fMh8SpYDd+0Oc6OMspUgtS4uFf7lXGx6CScW08QRtwpDJ1yWrd3/KrMeg4YjFyXbFZEuJGhMlHfNqU5uFZHjBQ0/h1VswQt9tTuOQYWw2isPzQkPQwsRkEvViJo8n6CdCyVfWT9e44mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807870; c=relaxed/simple;
	bh=HhmLJcYzYK4Zfxx07AHB8rdgnao7hcisDlC1PP/2L0s=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Mc/Fv5coC8fdxrZsVruU+80FsAIMOqRhF5J+hsWdIsys6ZBkL9ARgDDPu1PXu8I96fBhP19dOizgtqVP833Is053U/Q23Cq2W8BIEXTNTGpSz2aZmNICBAa3OB/8Yh3cx/7qf36z4qss2cAe3W83r7PjI7d5W8LbK2RFc7AnyrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKxq9T7j; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721807866; x=1753343866;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=HhmLJcYzYK4Zfxx07AHB8rdgnao7hcisDlC1PP/2L0s=;
  b=BKxq9T7jiOE3RgPR6OxOxFlQJZzsS7N6oMN/8wBxuC8c4IaRBuUYEPme
   ZiGj6rrkXV3JirVDGYjxTiPfXXulYt360h6m/82WARptwD6Cz0Gfa4Ui3
   pmTPL3Z2k0gf8C7JVnMiIU6SdbM4IlJh84yx4nGApn4qLJpn1Q6bpF0sK
   QMj0zAzi/4yV5m/1/dDpdxeZotyR3LmaB3QFbnh3nRbfMNY0y6uGDOFaS
   Q82aeXo4uty5tupy6s/IVVdwzrQm0X0zyR3EtgtF96KaeoRy3atP6zUzq
   LzZgK77vfC9EOWoeJZFmXOZQ+RkWu37zr3Vj3ksnBn3bmgVMKpUTgFYqo
   g==;
X-CSE-ConnectionGUID: unQ1lfl9Sv6ejLGI0qCy5g==
X-CSE-MsgGUID: bPLSP363TUyCMQRLJP58PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="22374163"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="22374163"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 00:57:46 -0700
X-CSE-ConnectionGUID: isjWq/FHSTueaKuaijLGTg==
X-CSE-MsgGUID: HIYhrqeLQyuT3CLx1GTZ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="56652382"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 00:57:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 00:57:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 00:57:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 00:57:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 00:57:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXiye8AemFfm+A2y7oKDz2m8T9w6GnP3IVoQ9ED3fQs0xisSipyRmNvZTSCkKSmJafvE1sIlWiEY5NQ+krYyNgEK0vkQwHig5aBAIsmkxg7RGhvfHJ7N+nd1cgREdH3ZIyNjUIZyyHPxtX1QnLq0GeApn5pm6wmo46u2N3VdQpjIRHdKthBEVXYWMArUOmPyNV9MzAqS0AbiHp0ABqOKdgspMZ0d7soXZ3UkNOJzjEfJU89kRiPM9thKw/ScB0HFrfgKs+lX4SDbCUPA5Vop5qmtWaDSsVT/uShciLP0QDn3MgnbGpx1ZQP8c5AZBN0VtMxCA4tJhvKFc7Y6rPseSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oe5SteNPMso86r3c+vevmOKe+bvIw2rVj5WRUIQI9p8=;
 b=htQQRmxKVvVBlAHXv4rm8fI++FPc9ENOrrtsF7SCinRrIt3aJS3M8s6fMizndUiqsi61CUvIhOPTHG8OCLeeuoHdQ5huzmX/2d8D+2vlNc7AgSCowZWw8AkuUadHVwRDoY3t7WTBhU4z5FtXimbMWPPFn52C/l41pNmwLTeHTK/xtOlWZh58r1qm9FlWVy/KFuluIPSD2nhL7MMTzWMiSGGpHRPtUabq5pvl+VSOMz7r8iRBUHIaeZqbbd1nNxcxUUr7OWHLdHOZFatifbDDmir6GiCfZiEUKJQ6JUGDJGJbZDuyUsb+3FABRwYa3+1p+d0jwEXbl1p+J2HZgmwZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL1PR11MB5272.namprd11.prod.outlook.com (2603:10b6:208:30a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 07:57:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 07:57:41 +0000
Date: Wed, 24 Jul 2024 15:57:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [cgroup/rstat]  21c38a3bd4: stress-ng.msg.ops_per_sec
 -17.7% regression
Message-ID: <202407241523.14878db1-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0123.apcprd03.prod.outlook.com
 (2603:1096:4:91::27) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL1PR11MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc9d64f-af0a-47e1-fa57-08dcabb64b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Yu9MYQb8evobZ2naGVo4FWQgPbBcIpKpluLxftKte5+bJMB3Q/sIXpJW/Z?=
 =?iso-8859-1?Q?EsFOC1wHoFUJ/go0YSGupXuoOFugYy1/rUP7A++Gd/krBdIyvqrzJc/IBF?=
 =?iso-8859-1?Q?28eZpiEy9SAoFg/+XXEzi3J0OiU2iTSZpbyYHlfofzfbOCnnFlnIpYSNX4?=
 =?iso-8859-1?Q?EaH4o0bKyxTv1XAq+OAYwoX5VkwvyypZyVrink8AtzraWvrw6zfxEZHy4r?=
 =?iso-8859-1?Q?ucpdaCxJpnBdkTkzHBDKZ6XqcandY5Fo65c7LjWef+YwCjK0lVs3Q73rwD?=
 =?iso-8859-1?Q?lrUiY4XiaurcqdY/Xa5+oLYgLwL7h4wrgE1gnzNC67u0klit5eaNjuDwir?=
 =?iso-8859-1?Q?XfIY1HpAOrNOCVWWq8VSo4o3AuEB9gjDAiLJnmbgfif6zxRuZjbd27NwER?=
 =?iso-8859-1?Q?fyr4/KIdMYfobNSOeEFa48qcxDtbwqWb9k96vEc2RfWUbpHf99K+Age+ll?=
 =?iso-8859-1?Q?HAdtys9WqbSaF2XtHl9nsD36SzGrT9Ht2xlNIXposX3Xv8uNJHWLRKkfh1?=
 =?iso-8859-1?Q?kstqyCl9dnqVulKnWp8O0XyDe+ktDrEb71SSCrtwtB7KuQcc9YrWC1YTDB?=
 =?iso-8859-1?Q?fMZjuWLAgeuB7ClqpB2+R2V4hAID+E29GcFU0G4EGD5yRGVU2dRpFt8vm+?=
 =?iso-8859-1?Q?FdS6r5Mm/UAnQ7ekHC3LriAsC7u0dtNx43OezOW2bNHPS60gpZ3e8xnfKW?=
 =?iso-8859-1?Q?rirNWFwx5DFNE/H2Jr/euB/p0JYUvQ3bo6Tx1jkZ1/IzPFXy3y9yzWZ67f?=
 =?iso-8859-1?Q?Qo+zqrEfI9xOfcGOIqsAB/blpXo0Z3vuF9LNeiqPt1E5asIZQYaow0InE+?=
 =?iso-8859-1?Q?fkUS033EF29hcR3sB4aoZ3J0nCMQtwhw1UHtpDFEtD4Kl5fBoajHaLci6f?=
 =?iso-8859-1?Q?7qWA96sBoMxy7sLuva/zONQ3ofs1DTQj6xHm5ydYRDJswkW8XqYm5a9HZe?=
 =?iso-8859-1?Q?pa1QHR2t7iDqjAZbOUBfFPzgpQi3d0bSg38J4/IYvEucXYK1hG9mXgKtHl?=
 =?iso-8859-1?Q?ALtDucOAMPMbZW22cEWLTRn4duQxMX8EiK8vGF04Or2nFfBbu+ygV18Wqa?=
 =?iso-8859-1?Q?IaowSurT+7joWleyhEPFbAZPpl7W42LYQNx0Fk99rvMj0+67QEu67dWPOI?=
 =?iso-8859-1?Q?P1UxhNogrKNkuzGNZLsxiJ/MpYwUh7RWf87D5Kwqiu4rQwxy0uGhNjY2o8?=
 =?iso-8859-1?Q?pTTIyId5hpvo8wR7DEqoXCFgToHaFVqqdZFFgzE1qOlmc+pTJewpJ+A7sr?=
 =?iso-8859-1?Q?cfOY4NsNidfiOVlZurvpqgXpZGORbvuzClZd6L0KlJg/1moCj9Z7glLMou?=
 =?iso-8859-1?Q?EOUKKJHOf5Vjsb7fr+asqAbyrv+J0qP7wJDTi+MDaCsI23Y425Nm8Suhkl?=
 =?iso-8859-1?Q?VdWfMQHmdF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?I3SMs+g/tIhvSgFQl6jxT81sr/OPTYhpWbj+Lo48y0rh6dugwZYi4h1Lhk?=
 =?iso-8859-1?Q?sWJkSWTNxNuzW7dyzgNgNFKtsY4V2e1zvBdEJFSrb/13pLmd8qE0kSFxQg?=
 =?iso-8859-1?Q?JXMCLeEhWdORuW4mjQpdGhPdwGCUoE/B8hrZxIy7M3vRrLQ0U9BVEqaZMS?=
 =?iso-8859-1?Q?R2LEwxgj7a1mhyvKCwc/sW1U/VfjpVkYJ1qrAVudljmPcKInJUe4ICJOGT?=
 =?iso-8859-1?Q?AH1R1FXny5HZ3q6grTN+OQbwir28EdGsCEFTFRE6okTJZ/VDxTVsqHFGYa?=
 =?iso-8859-1?Q?zg/bmtCEwg4KxJkln3Yb4WEQNoymVH0EM6Q9xe91oHAWJtrGc0eOZcXw7m?=
 =?iso-8859-1?Q?YEhbBqsAHhGb+QWUyjBIWL7mF76QQcjJbewGTpBnL3eVrnmGP3waCmwEr7?=
 =?iso-8859-1?Q?e8H+LTu3AVSwOwQkurm5fxnpTu+FU5vIGDW3UMJgupfswktbwp/WBxHfqJ?=
 =?iso-8859-1?Q?zvuJs3/0YNpicr1MHLLOMidhJSYn7g5b22afnTvSB7AVcl9lIv9JrneGdc?=
 =?iso-8859-1?Q?3jbVbNoRLxQNlxVGnQBgho2yO6RUxmu/LLY5mPqhNWwoUMwHa0+ZjTwJ0t?=
 =?iso-8859-1?Q?UWge+N7OJltz4waGl2mRKD0oGVlVPHCwCd9iVUZtL0sROV+pPKbu6QZ8SI?=
 =?iso-8859-1?Q?QC2BCROP4JNs0VuHRFVV5AzsNYwMaUpFmk3mYEttZiUpz8vGVTNk/bZAkE?=
 =?iso-8859-1?Q?g9OiyW1qdDEfisnklPdPTVJf7c/yWzVsHovGjdhR7N6PI/f40dmUXyitWU?=
 =?iso-8859-1?Q?DdGroSEqz1ayP6arxMguQkMhiNCT6DT/RyBJG8eT2+/8Q1iDovaXnxxUgU?=
 =?iso-8859-1?Q?T6FmcYZks5aY6VRxERocyJDBEUJVrsLnm53/spjK35OtPdIN6R1fvPB6Lt?=
 =?iso-8859-1?Q?iPgxdTaWsHa3/j1pTVyNc5Ttw+ZU7xKbRiPlAAI2q5fU6wQwExP77cePyP?=
 =?iso-8859-1?Q?w6RgHGpSR+1SgmZoVjOPHs1dzEHOcd75qPugf+Z4ThBybjlAzfvE6W5k+3?=
 =?iso-8859-1?Q?CXmZyT4PwLJ5WED+thuiDP0Ds9Qn5Rf94Br1wjO6Fp4GJg31b27W6Gi0PR?=
 =?iso-8859-1?Q?oEpAHWFpQcCPckEqgtLvSGcryNhyLPaOriEwjM4oDPzXVF/zVNAHjrqEAL?=
 =?iso-8859-1?Q?2etDMOMr7o4pz+dbNcsLgIwBVTKbDBneIyIDqKOuszp5TjFbpTshInhQrr?=
 =?iso-8859-1?Q?cPGHG7yF3ENXLGjrGm/G/zXwjkvxwmkwnQkgsLTzhi7jwaJ4pKOjEEdbr1?=
 =?iso-8859-1?Q?VyBBZLFQoYisqTs5tH3FbPsixHQDIVjMsr7FcmhK0uBITF3KQNsgxNYJ/8?=
 =?iso-8859-1?Q?l0tqWzXKAJsdWPmK5+9fHUXQ6U4MwK7yH6X18ssqZDwKFBRQZ7mktB+wJh?=
 =?iso-8859-1?Q?RjDLVpXs3+VCkhclF6Ix6m6QHA6w40cc1/MfgcNhlPxFV04PqWcQuQognH?=
 =?iso-8859-1?Q?XRZDfFYomiIkLQqRvd2TTcSrqvBN8hJrzqlL7lG/LCbeRFVFQpZwSROBCa?=
 =?iso-8859-1?Q?wmwv0Y7vAAuqYcYTQjg9QseiR97riKHoN1YuEAqMCqFuDyP8V3rI5L2RBy?=
 =?iso-8859-1?Q?6eP0fgx0eoWq/x+tqhCIno6bTmNeXO5Zf5ucZpy/CdrROg9zci5tuv6aaQ?=
 =?iso-8859-1?Q?dpWJLuwGs9AWFAEOAmnIHvOafjgeRRSMcs/hiJE50RRfOZCYrWXUM0DQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc9d64f-af0a-47e1-fa57-08dcabb64b3f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 07:57:41.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2NqlZ2MmYHZFKjb4gL1aM0CE0lONRMLvx0H+d7ehEXRV4VaGenzrzplupmPDCzL9/zRKEZeXYfFJV6QNn2Lgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5272
X-OriginatorOrg: intel.com


hi, Jesper Dangaard Brouer, and all,

we made some investigation for this regression and confirmed the code change
in 21c38a3bd4 is irrelevant to stress-ng performance regression, instead, it's
a code alignment issue.

if we applied below patch for both this commit and parent, the regression will
disappear.

diff --git a/Kbuild b/Kbuild
index 464b34a08f51..829d13a010b7 100644
--- a/Kbuild
+++ b/Kbuild
@@ -80,11 +80,11 @@ obj-y                       += init/
 obj-y                  += usr/
 obj-y                  += arch/$(SRCARCH)/
 obj-y                  += $(ARCH_CORE)
+obj-y                  += ipc/
 obj-y                  += kernel/
 obj-y                  += certs/
 obj-y                  += mm/
 obj-y                  += fs/
-obj-y                  += ipc/
 obj-y                  += security/
 obj-y                  += crypto/
 obj-$(CONFIG_BLOCK)    += block/


we still make out below formal report FYI. and Feng Tang (Cced) is working on a
patch to mitigate this kind of less meaningful performance changes due to code
alignment.


Hello,

kernel test robot noticed a -17.7% regression of stress-ng.msg.ops_per_sec on:


commit: 21c38a3bd4ee3fb7337d013a638302fb5e5f9dc2 ("cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: msg
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240724/202407241523.14878db1-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp1/msg/stress-ng/60s

commit: 
  c1457d9aad ("selftests/cgroup: Drop define _GNU_SOURCE")
  21c38a3bd4 ("cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints")

c1457d9aad5ee2fe 21c38a3bd4ee3fb7337d013a638 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  11013328           -14.0%    9475268        cpuidle..usage
    338790 ±  2%     -11.5%     299752 ±  2%  meminfo.Active
    338760 ±  2%     -11.5%     299723 ±  2%  meminfo.Active(anon)
    300946 ±  3%     -20.9%     238050 ± 26%  numa-meminfo.node1.Active
    300932 ±  3%     -20.9%     238045 ± 26%  numa-meminfo.node1.Active(anon)
    611478 ± 14%     -21.7%     478711 ± 21%  numa-meminfo.node1.Shmem
     75304 ±  3%     -21.4%      59175 ± 26%  numa-vmstat.node1.nr_active_anon
    153254 ± 14%     -21.8%     119804 ± 21%  numa-vmstat.node1.nr_shmem
     75303 ±  3%     -21.4%      59175 ± 26%  numa-vmstat.node1.nr_zone_active_anon
     71.66            +8.9%      78.05        vmstat.cpu.id
     68.36 ± 12%     -20.3%      54.46 ±  8%  vmstat.procs.r
    250061           -18.3%     204251        vmstat.system.cs
    287875           -18.4%     235023        vmstat.system.in
      0.50            -0.1        0.43 ±  3%  mpstat.cpu.all.irq%
      0.12 ±  2%      -0.0        0.10        mpstat.cpu.all.soft%
     27.05            -6.3       20.79        mpstat.cpu.all.sys%
      1.58            -0.3        1.31        mpstat.cpu.all.usr%
     33.01           -23.2%      25.34        mpstat.max_utilization_pct
    831.17 ±  5%     -23.7%     634.00 ±  7%  perf-c2c.DRAM.local
     27497           -26.4%      20232 ±  2%  perf-c2c.DRAM.remote
     95989           -22.4%      74505        perf-c2c.HITM.local
     22829           -27.2%      16620 ±  2%  perf-c2c.HITM.remote
    118818           -23.3%      91125        perf-c2c.HITM.total
 7.763e+08           -17.7%  6.391e+08        stress-ng.msg.ops
  12937976           -17.7%   10650694        stress-ng.msg.ops_per_sec
     20708           -25.9%      15335        stress-ng.time.involuntary_context_switches
      7333           -22.5%       5682        stress-ng.time.percent_of_cpu_this_job_got
      4240           -22.7%       3279        stress-ng.time.system_time
    195.77           -19.8%     157.09        stress-ng.time.user_time
   7897285           -18.3%    6450672        stress-ng.time.voluntary_context_switches
     84383 ±  3%     -11.6%      74585 ±  3%  proc-vmstat.nr_active_anon
    947441            -1.6%     932675        proc-vmstat.nr_file_pages
    270183            -2.2%     264202        proc-vmstat.nr_inactive_anon
    141423 ±  3%      -8.4%     129608 ±  2%  proc-vmstat.nr_mapped
    180981            -8.2%     166203        proc-vmstat.nr_shmem
     84383 ±  3%     -11.6%      74585 ±  3%  proc-vmstat.nr_zone_active_anon
    270183            -2.2%     264202        proc-vmstat.nr_zone_inactive_anon
   2030924            -7.1%    1886998        proc-vmstat.numa_hit
   1766802            -8.1%    1622970        proc-vmstat.numa_local
   2118829            -7.0%    1971226        proc-vmstat.pgalloc_normal
   1014503            -5.2%     961850        proc-vmstat.pgfault
   1776085 ±  2%      -6.8%    1655949 ±  2%  proc-vmstat.pgfree
    658538 ±  2%     -40.3%     392887        sched_debug.cfs_rq:/.avg_vruntime.avg
   1004627 ±  2%     -38.4%     618736 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.max
    463772 ±  8%     -34.4%     304006        sched_debug.cfs_rq:/.avg_vruntime.min
     55077 ±  4%     -25.7%      40920        sched_debug.cfs_rq:/.avg_vruntime.stddev
    658538 ±  2%     -40.3%     392887        sched_debug.cfs_rq:/.min_vruntime.avg
   1004627 ±  2%     -38.4%     618736 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
    463772 ±  8%     -34.4%     304006        sched_debug.cfs_rq:/.min_vruntime.min
     55077 ±  4%     -25.7%      40920        sched_debug.cfs_rq:/.min_vruntime.stddev
    193.88 ±  5%     -19.0%     156.99 ±  6%  sched_debug.cfs_rq:/.runnable_avg.avg
    156.63 ±  6%     -11.0%     139.47 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    193.51 ±  5%     -19.0%     156.69 ±  6%  sched_debug.cfs_rq:/.util_avg.avg
    156.53 ±  6%     -11.2%     139.06 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
     29.90 ± 11%     -28.2%      21.48 ± 17%  sched_debug.cfs_rq:/.util_est.avg
    155612 ±  8%     -14.5%     133052 ±  3%  sched_debug.cpu.avg_idle.stddev
     31373           -17.6%      25848        sched_debug.cpu.nr_switches.avg
     24963 ±  5%     -16.7%      20782 ±  6%  sched_debug.cpu.nr_switches.min
    141.42 ±  6%     -57.2%      60.50 ± 21%  sched_debug.cpu.nr_uninterruptible.max
     -1239           -81.4%    -230.33        sched_debug.cpu.nr_uninterruptible.min
     81.43 ±  8%     -77.5%      18.29 ± 11%  sched_debug.cpu.nr_uninterruptible.stddev
      0.96            -4.7%       0.91 ±  2%  perf-stat.i.MPKI
 8.823e+09           -20.0%   7.06e+09        perf-stat.i.branch-instructions
      1.59            +0.0        1.64        perf-stat.i.branch-miss-rate%
 1.394e+08           -16.9%  1.158e+08        perf-stat.i.branch-misses
      9.60            -0.8        8.76 ±  2%  perf-stat.i.cache-miss-rate%
  42966024           -23.0%   33093243 ±  2%  perf-stat.i.cache-misses
 4.653e+08           -16.0%  3.908e+08        perf-stat.i.cache-references
    261124           -18.2%     213609        perf-stat.i.context-switches
      4.44            -3.0%       4.31        perf-stat.i.cpi
 2.038e+11           -22.2%  1.585e+11        perf-stat.i.cpu-cycles
     41405           -34.6%      27075        perf-stat.i.cpu-migrations
 4.563e+10           -19.5%  3.672e+10        perf-stat.i.instructions
      0.23            +2.8%       0.23        perf-stat.i.ipc
      0.94           -98.3%       0.02 ± 44%  perf-stat.i.metric.K/sec
     15289 ±  2%      -8.2%      14035 ±  2%  perf-stat.i.minor-faults
     15290 ±  2%      -8.2%      14036 ±  2%  perf-stat.i.page-faults
      1.56            +0.1        1.63        perf-stat.overall.branch-miss-rate%
      9.04            -0.7        8.36 ±  2%  perf-stat.overall.cache-miss-rate%
      4.46            -3.2%       4.32        perf-stat.overall.cpi
      0.22            +3.4%       0.23        perf-stat.overall.ipc
 8.733e+09           -20.3%  6.963e+09        perf-stat.ps.branch-instructions
 1.364e+08           -17.0%  1.132e+08        perf-stat.ps.branch-misses
  42281735           -23.1%   32530958 ±  2%  perf-stat.ps.cache-misses
 4.676e+08           -16.8%   3.89e+08        perf-stat.ps.cache-references
    257335           -18.3%     210344        perf-stat.ps.context-switches
 2.016e+11           -22.4%  1.564e+11        perf-stat.ps.cpu-cycles
     40985           -34.9%      26692        perf-stat.ps.cpu-migrations
 4.517e+10           -19.8%  3.622e+10        perf-stat.ps.instructions
     14314 ±  2%      -6.2%      13432 ±  2%  perf-stat.ps.minor-faults
     14315 ±  2%      -6.2%      13432        perf-stat.ps.page-faults
 2.764e+12           -19.5%  2.225e+12        perf-stat.total.instructions
     35.46           -10.8       24.66        perf-profile.calltrace.cycles-pp.__percpu_counter_sum.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     33.85 ±  2%     -10.7       23.11        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__percpu_counter_sum.msgctl_info.ksys_msgctl.do_syscall_64
     33.74 ±  2%     -10.7       23.01        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__percpu_counter_sum.msgctl_info.ksys_msgctl
     38.54            -9.0       29.55        perf-profile.calltrace.cycles-pp.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      2.99            -0.8        2.23 ±  8%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      2.19 ±  6%      -0.7        1.44 ± 11%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.74 ±  7%      -0.5        2.24        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      3.26            -0.3        2.97        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.90            -0.3        3.63        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      0.68 ±  6%      +0.1        0.74        perf-profile.calltrace.cycles-pp._copy_from_user.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.90            +0.1        1.03        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.55 ± 44%      +0.2        0.70        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__libc_msgsnd.stress_msg
      0.96 ±  5%      +0.2        1.14 ±  3%  perf-profile.calltrace.cycles-pp._copy_to_user.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      1.32            +0.2        1.55        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.36            +0.2        1.59        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.42 ± 44%      +0.2        0.66        perf-profile.calltrace.cycles-pp.rwsem_wake.up_write.msgctl_down.ksys_msgctl.do_syscall_64
      0.46 ± 44%      +0.3        0.72        perf-profile.calltrace.cycles-pp.up_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.12            +0.3        2.40        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.85            +0.3        4.19        perf-profile.calltrace.cycles-pp.common_startup_64
      3.59            +0.3        3.94        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      3.58            +0.3        3.93        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.59            +0.3        3.94        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      2.60 ±  6%      +0.4        3.00 ±  2%  perf-profile.calltrace.cycles-pp.store_msg.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.37            +0.4        3.81 ±  2%  perf-profile.calltrace.cycles-pp.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.43 ± 44%      +0.5        0.98        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl
      0.78 ±  6%      +0.6        1.34 ±  3%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      0.79 ±  6%      +0.6        1.35 ±  3%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.78 ±  6%      +0.6        1.34 ±  3%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.65 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.sysvipc_proc_start.seq_read_iter.seq_read
      0.00            +0.7        0.67 ±  4%  perf-profile.calltrace.cycles-pp.down_read.sysvipc_proc_start.seq_read_iter.seq_read.vfs_read
      0.70 ± 44%      +0.7        1.37 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read.stress_msg
      0.68 ± 44%      +0.7        1.35 ±  3%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_msg
      0.69 ± 44%      +0.7        1.37 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_msg
      0.70 ± 44%      +0.7        1.38 ±  2%  perf-profile.calltrace.cycles-pp.read.stress_msg
      0.00            +0.7        0.69 ±  4%  perf-profile.calltrace.cycles-pp.sysvipc_proc_start.seq_read_iter.seq_read.vfs_read.ksys_read
      0.67 ±  9%      +0.9        1.56        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl
      0.00            +0.9        0.90        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_write_slowpath.down_write.msgctl_down
      0.00            +1.2        1.19 ±  2%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.msgctl_down
      1.52 ±  8%      +1.4        2.94        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl.do_syscall_64
      1.58 ±  8%      +1.5        3.03        perf-profile.calltrace.cycles-pp.down_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.24 ±  7%      +1.7        3.89        perf-profile.calltrace.cycles-pp.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      2.58 ±  7%      +1.8        4.34        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.msgctl_info.ksys_msgctl.do_syscall_64
      1.34 ±  8%      +1.8        3.12 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.msgctl_info
      1.43 ±  8%      +1.8        3.25 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.msgctl_info.ksys_msgctl
      2.70 ±  7%      +1.8        4.52        perf-profile.calltrace.cycles-pp.down_read.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.07 ±  3%      +2.1       21.20 ±  3%  perf-profile.calltrace.cycles-pp.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     19.33 ±  3%      +2.2       21.49 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     19.39 ±  3%      +2.2       21.56 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     20.22 ±  3%      +2.2       22.43 ±  3%  perf-profile.calltrace.cycles-pp.__libc_msgrcv
      8.31 ±  2%      +3.5       11.79        perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.97 ±  2%      +3.5       11.46        perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.10            +3.6       13.66        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      9.71            +3.6       13.30        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     18.24 ± 36%      +5.8       24.05        perf-profile.calltrace.cycles-pp.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_msg
     18.98 ± 36%      +6.0       24.96        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_msg
     19.08 ± 36%      +6.0       25.07        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_msg
     20.09 ± 36%      +6.2       26.33        perf-profile.calltrace.cycles-pp.__libc_msgsnd.stress_msg
     35.49           -10.8       24.68        perf-profile.children.cycles-pp.__percpu_counter_sum
     34.24 ±  2%     -10.6       23.68        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     38.54            -9.0       29.55        perf-profile.children.cycles-pp.msgctl_info
     41.48            -8.8       32.65        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     41.12            -7.4       33.76        perf-profile.children.cycles-pp.ksys_msgctl
     41.44            -7.3       34.09        perf-profile.children.cycles-pp.msgctl
      5.82            -1.3        4.56        perf-profile.children.cycles-pp.percpu_counter_add_batch
     89.95            -0.8       89.17        perf-profile.children.cycles-pp.do_syscall_64
     90.24            -0.8       89.48        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      7.07            -0.7        6.36        perf-profile.children.cycles-pp._raw_spin_lock
      1.54 ±  2%      -0.4        1.16        perf-profile.children.cycles-pp.newidle_balance
      1.58            -0.4        1.21        perf-profile.children.cycles-pp.pick_next_task_fair
      2.58            -0.4        2.23        perf-profile.children.cycles-pp.__schedule
      1.48 ±  2%      -0.4        1.12        perf-profile.children.cycles-pp.load_balance
      2.01            -0.4        1.66        perf-profile.children.cycles-pp.schedule
      1.27            -0.3        1.00 ±  2%  perf-profile.children.cycles-pp.find_busiest_group
      1.27            -0.3        0.99 ±  2%  perf-profile.children.cycles-pp.update_sd_lb_stats
      1.22            -0.3        0.96 ±  2%  perf-profile.children.cycles-pp.update_sg_lb_stats
      1.19            -0.2        0.98        perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.13 ±  6%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.32 ±  2%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.32            -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.idle_cpu
      0.32            -0.0        0.29 ±  4%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.09 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.find_busiest_queue
      0.19 ±  3%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.update_blocked_averages
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.ss_wakeup
      0.08 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.cmd_record
      0.35            -0.0        0.33 ±  2%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.main
      0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.run_builtin
      0.10 ±  4%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.31            +0.0        0.32        perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.12            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.26            +0.0        0.27        perf-profile.children.cycles-pp.sysvipc_msg_proc_show
      0.13 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.14 ±  3%      +0.0        0.16        perf-profile.children.cycles-pp.quiet_vmstat
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.rebalance_domains
      0.14 ±  2%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.osq_unlock
      0.31            +0.0        0.33        perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.38            +0.0        0.40        perf-profile.children.cycles-pp.__get_user_8
      0.38            +0.0        0.40        perf-profile.children.cycles-pp.__x64_sys_msgsnd
      0.61            +0.0        0.63        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.09 ±  4%      +0.0        0.11 ± 19%  perf-profile.children.cycles-pp._find_next_and_bit
      0.30            +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.ipcperms
      0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.12 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.therm_throt_process
      0.20 ±  2%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.msgctl_stat
      0.38            +0.0        0.42        perf-profile.children.cycles-pp.__put_user_8
      0.27            +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.31 ±  3%      +0.0        0.35 ±  7%  perf-profile.children.cycles-pp.nohz_balance_exit_idle
      0.28            +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.menu_select
      0.72            +0.0        0.77        perf-profile.children.cycles-pp._copy_from_user
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ipcctl_obtain_check
      0.21 ±  3%      +0.1        0.27        perf-profile.children.cycles-pp.task_work_run
      0.46            +0.1        0.52 ±  2%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.20 ±  2%      +0.1        0.26        perf-profile.children.cycles-pp.task_mm_cid_work
      0.48            +0.1        0.54        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.32 ±  2%      +0.1        1.38 ±  2%  perf-profile.children.cycles-pp.stress_msg_receiver
      0.26            +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.intel_thermal_interrupt
      0.17 ±  4%      +0.1        0.23        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.26 ±  2%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.__sysvec_thermal
      0.19 ±  2%      +0.1        0.26 ±  9%  perf-profile.children.cycles-pp.kick_ilb
      1.11            +0.1        1.19        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.24 ±  3%      +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.up_read
      1.35            +0.1        1.44        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.34 ±  2%      +0.1        0.43 ±  2%  perf-profile.children.cycles-pp.sysvec_thermal
      1.10 ±  2%      +0.1        1.19 ±  4%  perf-profile.children.cycles-pp.update_process_times
      1.15 ±  2%      +0.1        1.25 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.14 ±  2%      +0.1        1.24 ±  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.38 ±  2%      +0.1        0.48        perf-profile.children.cycles-pp.asm_sysvec_thermal
      1.20            +0.1        1.31 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.21 ±  2%      +0.1        1.32 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.36            +0.1        1.49 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.41            +0.1        1.54 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.13 ±  3%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.idr_get_next
      0.12 ±  4%      +0.1        0.25 ±  3%  perf-profile.children.cycles-pp.idr_get_next_ul
      0.21 ±  2%      +0.1        0.34 ±  4%  perf-profile.children.cycles-pp.sysvipc_proc_next
      0.92            +0.1        1.05        perf-profile.children.cycles-pp.intel_idle
      0.61            +0.2        0.78        perf-profile.children.cycles-pp.rwsem_wake
      0.56            +0.2        0.72        perf-profile.children.cycles-pp.up_write
      1.49            +0.2        1.71        perf-profile.children.cycles-pp.cpuidle_enter_state
      1.50            +0.2        1.72        perf-profile.children.cycles-pp.cpuidle_enter
      1.36            +0.3        1.62        perf-profile.children.cycles-pp._copy_to_user
      2.27            +0.3        2.54        perf-profile.children.cycles-pp.cpuidle_idle_call
      3.85            +0.3        4.18        perf-profile.children.cycles-pp.do_idle
      3.85            +0.3        4.19        perf-profile.children.cycles-pp.common_startup_64
      3.85            +0.3        4.19        perf-profile.children.cycles-pp.cpu_startup_entry
      3.59            +0.3        3.94        perf-profile.children.cycles-pp.start_secondary
      0.30 ±  2%      +0.4        0.69 ±  4%  perf-profile.children.cycles-pp.sysvipc_proc_start
      2.97            +0.4        3.38 ±  2%  perf-profile.children.cycles-pp.store_msg
      3.39            +0.4        3.83 ±  2%  perf-profile.children.cycles-pp.do_msg_fill
      0.81            +0.5        1.35 ±  3%  perf-profile.children.cycles-pp.seq_read_iter
      0.80            +0.5        1.34 ±  3%  perf-profile.children.cycles-pp.seq_read
      0.82            +0.5        1.37 ±  2%  perf-profile.children.cycles-pp.ksys_read
      0.82            +0.5        1.36 ±  3%  perf-profile.children.cycles-pp.vfs_read
      0.85            +0.6        1.40 ±  2%  perf-profile.children.cycles-pp.read
      0.41 ±  6%      +0.8        1.19 ±  2%  perf-profile.children.cycles-pp.osq_lock
      0.70 ±  4%      +0.9        1.57        perf-profile.children.cycles-pp.rwsem_optimistic_spin
      1.56 ±  2%      +1.4        2.94        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.63 ±  2%      +1.4        3.03        perf-profile.children.cycles-pp.down_write
      2.30 ±  2%      +1.6        3.89        perf-profile.children.cycles-pp.msgctl_down
      2.93 ±  2%      +2.1        5.00        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      3.06 ±  2%      +2.1        5.19        perf-profile.children.cycles-pp.down_read
      2.13 ±  3%      +2.6        4.74        perf-profile.children.cycles-pp._raw_spin_lock_irq
     21.15            +2.9       24.08        perf-profile.children.cycles-pp.do_msgsnd
     25.40            +3.0       28.43        perf-profile.children.cycles-pp.do_msgrcv
     23.62            +3.1       26.71        perf-profile.children.cycles-pp.__libc_msgsnd
     27.24            +3.2       30.40        perf-profile.children.cycles-pp.__libc_msgrcv
     16.41 ±  2%      +7.0       23.42        perf-profile.children.cycles-pp.idr_find
     19.91            +7.2       27.10        perf-profile.children.cycles-pp.ipc_obtain_object_check
     41.36            -8.8       32.54        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      5.70            -1.2        4.46        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.93            -0.2        0.72 ±  2%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.32            -0.0        0.29        perf-profile.self.cycles-pp.idle_cpu
      0.08 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.find_busiest_queue
      0.13 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.ss_wakeup
      0.09            +0.0        0.10        perf-profile.self.cycles-pp.prepare_task_switch
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.06 ±  6%      +0.0        0.07        perf-profile.self.cycles-pp.cpuidle_enter_state
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.menu_select
      0.28            +0.0        0.30 ±  2%  perf-profile.self.cycles-pp.ipcperms
      0.05            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.osq_unlock
      0.07 ±  5%      +0.0        0.09        perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.10 ±  5%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.kick_ilb
      0.38            +0.0        0.40        perf-profile.self.cycles-pp.__get_user_8
      0.36            +0.0        0.38        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.46            +0.0        0.49        perf-profile.self.cycles-pp.__libc_msgsnd
      0.38            +0.0        0.41        perf-profile.self.cycles-pp.__put_user_8
      0.12 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.therm_throt_process
      0.07 ±  7%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.down_write
      0.47            +0.0        0.50        perf-profile.self.cycles-pp.__libc_msgrcv
      0.13 ±  3%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.intel_thermal_interrupt
      0.35 ±  2%      +0.0        0.38        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.31 ±  3%      +0.0        0.35 ±  7%  perf-profile.self.cycles-pp.nohz_balance_exit_idle
      0.67            +0.0        0.71        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.08 ±  5%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.23 ±  3%      +0.0        0.28 ±  4%  perf-profile.self.cycles-pp.__check_object_size
      0.71            +0.1        0.76        perf-profile.self.cycles-pp._copy_from_user
      0.46            +0.1        0.51        perf-profile.self.cycles-pp.__radix_tree_lookup
      0.13 ±  5%      +0.1        0.19        perf-profile.self.cycles-pp.down_read
      0.20 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.task_mm_cid_work
      1.27 ±  2%      +0.1        1.34 ±  3%  perf-profile.self.cycles-pp.stress_msg_receiver
      1.45            +0.1        1.51        perf-profile.self.cycles-pp._raw_spin_lock
      0.16 ±  2%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.15 ±  3%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.14 ±  2%      +0.1        0.21        perf-profile.self.cycles-pp.up_read
      0.27 ±  2%      +0.1        0.34        perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      1.11            +0.1        1.19        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.38            +0.1        0.49 ±  4%  perf-profile.self.cycles-pp.store_msg
      1.05            +0.1        1.17 ±  2%  perf-profile.self.cycles-pp.do_msgsnd
      0.11 ±  3%      +0.1        0.23 ±  4%  perf-profile.self.cycles-pp.idr_get_next_ul
      1.65            +0.1        1.78 ±  2%  perf-profile.self.cycles-pp.do_msgrcv
      3.05            +0.1        3.18 ±  2%  perf-profile.self.cycles-pp.ipc_obtain_object_check
      0.92            +0.1        1.05        perf-profile.self.cycles-pp.intel_idle
      1.34            +0.3        1.59        perf-profile.self.cycles-pp._copy_to_user
      0.40 ±  6%      +0.8        1.17 ±  2%  perf-profile.self.cycles-pp.osq_lock
     16.08 ±  2%      +6.9       22.94        perf-profile.self.cycles-pp.idr_find




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


