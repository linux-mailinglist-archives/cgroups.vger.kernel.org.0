Return-Path: <cgroups+bounces-4170-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A494B64A
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 07:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC5AFB20BB7
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 05:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97FC13BACE;
	Thu,  8 Aug 2024 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3n4dyU3"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D07E1;
	Thu,  8 Aug 2024 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095142; cv=fail; b=fUjPo5oQzLgdH83pE8I21pK8QwFKBknBjV6X47/D0XASwCdkExYwk5W69cHfqWG7OZnNIDSq/bXzz16PJWRaQnb5f1pocQ3kyZjH1PrZsS/4cDo2+SQQ4eJsLKfA7UWjK+fAFGpJPZiMVsFYBVklwMo4y00WrQVZL4g8ytOSk1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095142; c=relaxed/simple;
	bh=oXqp7SaetaGvWAPDs+v55eyLlwnalHLgRqxR46RQHTM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=r4P9TcLUCiZ3blLiS2ZJ2rh3aokriAYHY03RqSMSTh965CJW3SIC8HHiUO2jEWY3/z/9TuKZNpA0Rz0GcMruR7LFuuw71T/t1Ieyz1k10YNRgpCpuXwcf+ucVhPohR2XlRsLeT5EgJ0WYJLPMyz2q2w2nwBSwfG3K1/l7gAAzYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3n4dyU3; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723095140; x=1754631140;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=oXqp7SaetaGvWAPDs+v55eyLlwnalHLgRqxR46RQHTM=;
  b=f3n4dyU3yixPtgf1UoTNK4+pBCN1GsOiqrwpdBq3q+cguIK5XC9m9xf/
   U1MLOKFi1XRtsyuYmPe+wd3TZRu3ILXaY1yoCqmNYAY3+HQbIRrazqbRH
   DBEI+4KkWAysEH+p+N0B/4c/4U62br9pQb7kYv2PpMdw7V8Dlt+YUL+sn
   xgZx2agF/MqimfHIHuBer79G/+Dn4mzCaMzoUUqPaFEgytKCo5eCJo1fu
   PUBflwrMuHzEbxMNVVFdiFfp3w/D1wjkwPHjMbxrHiC8j8ANdXTYfrOwR
   J/W5jd5NngzlWnATeBA2FnGDLZzBDubi+XarqhOBCV2uS6X2cT5uRtxiV
   A==;
X-CSE-ConnectionGUID: CnwResuUQCW68Qll4biMNA==
X-CSE-MsgGUID: VqTTuovNRxCXcy4BmsimQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21012586"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21012586"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 22:32:19 -0700
X-CSE-ConnectionGUID: KTpaIjDWTwqQ8CATCKSDhQ==
X-CSE-MsgGUID: cKX5gG6yTVG1OZpdIeVcTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="61506209"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 22:32:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 22:32:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 22:32:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 22:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9umfJ/34kDjKK2t4dL+KGj46Sa9Lqq0G8pTwi/SWwcZa+GHMHVRtMiXScu4CKSahGSMDXsZrtyW+WDhFB/TsdIdFe2CBu4tpPGRKz3VCB7ViPQNgRWer7w2+kBJ/vupf3umf2YKMHZQKkBXYSX8/Ajd5LuyPKN2DUL4qQqd/QZHl22cTouEsTaldkTPNLay+t8r2w36xEcppw3ROjNC8yqLgMBm4/vkUSopT8imRqWot7TdGW89LrBx3SGk17c/UzVGckiFGg0AF0jHSB12NTyiLzd/0IAOi13zqevZ2/gaZv18yP55zQg7Hq9C0K7ur41Sk7qySs+uPJEkEw7Ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPUEhn6eDuKQvq/sqUYS82wcYfQLFbw05R6AqgbMQ0M=;
 b=fNP7HTYUGCpElinrzzmtucUaCPYKbUYVGkFEUXreAWVa69sTlDYV9hiLdQh/fH2FwyTc5rEpKiE+HYcwb/ng+AJM12sh+3olrqS0Z2zgyURXJ93N7XzKomSdPeYTxFbW0Sn8LIiW8S2DthXTShbWcGzRYBQmqgPBts0cnHLC14rXGVECTkkauS4qqplm/03p+BamFLHr6wll6NSEat4O298ytEtUk6oQCWtzTs+cNMC/Fb/aT8mGhYYpivv0/xG/KFP+tVj8uK8eJG441iKnaQKOg410BaQvva1/4AATkL/4FJDZzHmwI4EuBV6E54NHfCwvg+zMoBYJOZxWnFWAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7753.namprd11.prod.outlook.com (2603:10b6:208:421::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Thu, 8 Aug
 2024 05:32:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 05:32:14 +0000
Date: Thu, 8 Aug 2024 13:32:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, kernel test robot
	<oliver.sang@intel.com>, Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin
	<roman.gushchin@linux.dev>, Feng Tang <feng.tang@intel.com>, "Huang, Ying"
	<ying.huang@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko
	<mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, Yin Fengwei
	<fengwei.yin@intel.com>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [linus:master] [memcg]  fefc6e6631:  will-it-scale.per_thread_ops
 12.7% improvement
Message-ID: <202408081325.cba32176-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 27069f85-185b-44fb-f436-08dcb76b75cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?y8dQ6kB0g4LCefZdJS/sEcwcbkZvFpn3c1w5naF3TUtI5mTKjyzsrIVQOt?=
 =?iso-8859-1?Q?pzRzSK1m6C5c4tnpsEaYY2QcBBXeXP6ngEfFDuzyhglR+v+HhtLC1Rvik4?=
 =?iso-8859-1?Q?I2qOtFJs4btOGeylp75XQp9NMqxMadnGuIZMfEWXPIbQygOFJOwn6fLz12?=
 =?iso-8859-1?Q?7/tkXtSrfaLqSJFEnzm++pJyzMb3YRQ33jjeEy7EZ+EoJ68JRtsaUOUq+p?=
 =?iso-8859-1?Q?TaZjw9AYci0+CZbQEgojazQPNWhQjQSEULFXdzptXF6xMVqYimQqIe0XgW?=
 =?iso-8859-1?Q?v1ksiaCMery9Zi9krTrmR7wv+SQ5d8wzjkiYJF1sGYfxhEC1Cc664Pcc1c?=
 =?iso-8859-1?Q?vYmZrguDzZXhylkBnooeNS2uBGFynwDWZ8aYO+czuar5+BoQAx1yAKPlqr?=
 =?iso-8859-1?Q?VTK5KGlgf6nOo3j0HfL3lGi90m5XrIUhEWGGfPD7gOYMT9Pm8wguHhwV5d?=
 =?iso-8859-1?Q?d/Y0zClOZxpid32o0OYx5rqwdd8VQL3VC52JOZtQ5he1Sv8ObdzVLT7i7L?=
 =?iso-8859-1?Q?eQVUvN1l56Yh2OvVtL40A9/iQTdL3upA2OqmzsWgf1iG70YRrxxBDQLBty?=
 =?iso-8859-1?Q?dkBo3bz/wW64NVEwW8KZN2vciV0HchgiQRAHCIV/lvu0TsXHbz4j1Pe1xh?=
 =?iso-8859-1?Q?/6Cj3vIggeh/58jtPhg85aYV3ZeR455Gicc8t78AcbjHINRHNh9dCJbrpV?=
 =?iso-8859-1?Q?uWKsQVk2goJ27EwHUEJygJdQYsLFy25bc/lBEk1Rg/QZhpUpy2E52gEtsM?=
 =?iso-8859-1?Q?GGWM0REqa4NZlx5PbLbQC09RGRw9HFXdqt1FVQXZxok/3/mTQ6k0f8mZTI?=
 =?iso-8859-1?Q?TIbwaNCW8oh/Jpd9ZwF/McnKu2+oFcFtCnRisVJSnCBLj+Ku1SWu+P7I7t?=
 =?iso-8859-1?Q?gyaj/aaZ3PMUoioUMBAZOpIdnm7DhWyWPvNdYWumzrusZxMQmLA9eC545y?=
 =?iso-8859-1?Q?+XqcKWEFFX9BwtKnfNyp9QFQGQZUA/FBA4HTnBiLc6K8lU6tDXyKO4XBw3?=
 =?iso-8859-1?Q?UuXGrqysiF27JhDWVRTqtMYDPc5qTIbJpZ8whahh4u8h4fVG5EY6GWUyTG?=
 =?iso-8859-1?Q?ind/L7IxtiVvHutnXohb+jRcn93+pVdY1NMTbWHU8t99MpU3sak+hLulyD?=
 =?iso-8859-1?Q?EDyZLrDSkq6yBOitK8WI/dij5fhBdU4zdh3EAIgYK6iilVuHliySqzVx5N?=
 =?iso-8859-1?Q?m/c+wnVmPWJUwMNCOxF+QJgF3flIngxqO9hTvG9sGcBmi/ivSJM3SKfcAX?=
 =?iso-8859-1?Q?OEixmUXd94dB+AgxY0m72/A14tPDJRTuiSC7W8ygsi6ofIrUK3l70AmLMh?=
 =?iso-8859-1?Q?7hNuPvF4xTtbBFcbIv/yTwR1emBwGmfHl5bguDhmuOUsP/uUv8rfgRqzcn?=
 =?iso-8859-1?Q?ZBRoFUSHy3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3lujnsXfASYroft8CI0iFkF1+qJwhD6UR82i2jX8tm7PYGAVsAk1p8D/Ep?=
 =?iso-8859-1?Q?aQdGC0DfUji3XgQYHGGLH2xI0YmJmVKoD1HhdabuO+a1eonFmLyevUW+25?=
 =?iso-8859-1?Q?9wSKzBm+7mHZxiysRpYEibkIEwc/4IjA08PP74SD1N/MDg5l+T82slehqn?=
 =?iso-8859-1?Q?A7ew0PYkmkEW6etd1fOzDJworNZlVk7j3jzcBE8BhLxazto0RSiH+jTkbG?=
 =?iso-8859-1?Q?eDf9WI5qIQRR77KuVf9je9j/FAokuORFK4fBtMq0xPv8eGD9uptYg6dg4K?=
 =?iso-8859-1?Q?MQh9dPzItYDik+6Quzb4m+HcgDEtqcDnayBcrSZxT9iUACoiSMdPHre9cF?=
 =?iso-8859-1?Q?M/QB7+VmMb9RnUw0fcdTe9dTyOG/aZanJ8AlhAUiNucXZyjhejGuigzel5?=
 =?iso-8859-1?Q?YhGfgfRU1dAGD7GZ48REM4nb5iJaQ/TPzJ5IkyLiavP1JuDxftvfeG5q7J?=
 =?iso-8859-1?Q?BCU+WvnQd7mzLxd52Lhbt2XqmhUOQGTSJFrggZN87Qx7obk3p110s2ZN+N?=
 =?iso-8859-1?Q?LgKdS0D83sqjEGKW6NBM4mu6Mug2oU45NAhxS3fausgbjCvxD3GrO8k0xN?=
 =?iso-8859-1?Q?UrMCbITipiiadpTVI0KyAOLiO4fWRIQw2+Uby+n1pNseFxvsJR/w8tY4T1?=
 =?iso-8859-1?Q?4czOIbctSAf6PBz6JaxnUIoVcJTUm3J7csDDmyqyDncKdgCwODne8HQ4+1?=
 =?iso-8859-1?Q?mDK5U476VThkAPQ+CLPH+GdxLciJxJHnAk1II2MNYExd9TNfPZo0RxWDdD?=
 =?iso-8859-1?Q?gpjpUzdDDVoo3T3IMYNR1nkJxmnlyvaCS/HKz6+R1iZBuzp78cQNMZxjox?=
 =?iso-8859-1?Q?Q3+IzEG+TXIH3PYZ0c3OigLpGzQE273ypBt8I22vNhhyWnwTr0pV25NDij?=
 =?iso-8859-1?Q?4b91jFVGRTAytfWfjpawZwAwafgzDa9Z0sNJHtO8sW8duxbLajIslj+9CJ?=
 =?iso-8859-1?Q?ED9loXqXsWTdXKP0XZpR3RA4rllf3suMM9J98hrBP02jWd6XkM7m+f1+sZ?=
 =?iso-8859-1?Q?jXPTqaAzumnhexETywy9oHMb89sloccLbpgCEAO3h6VVuQHYzw8AlVrMew?=
 =?iso-8859-1?Q?LEXvDe3e8sW7Yod6Rp79SMg6q5pxEB626lZZZB/UsguMTZHJJKLl15/Q/k?=
 =?iso-8859-1?Q?czd8W9iYxMtTKypLR1Q5jFff+VWo7BvPlMwQlgeyaFLh4tIROPv0aHerdW?=
 =?iso-8859-1?Q?uZtGXoPgl62dJuzeFLR+jDvm6pvHblRbMWSgi7sxnbJn612XMrdwCmamev?=
 =?iso-8859-1?Q?eS2PAseItHpPPcLI+Jdaivh9Q/zMlwzEB7MARCExCf8RIyN+ti8derGTlF?=
 =?iso-8859-1?Q?pSzGBw6+4rr3edaxXLkHBumdbZ0eAfpC2FIhBjT47lzvsD0fhmlgYu7vjV?=
 =?iso-8859-1?Q?JoTkc1EZ8mNGwaY86gGUlo1cMkvdnbrfMzTqUwW6QRlxPNw10xuG5Iasxb?=
 =?iso-8859-1?Q?x1SNszbMkjMW9pLKfnW5GxcJ7/GfJfnuSp/RfAcL95DvoKISORlFpZbR53?=
 =?iso-8859-1?Q?DuEMYsAYD1IWLA/2kods9xIUHTWlhzLUPQIFkrqF4sKQpRlRmZtfxjDLdH?=
 =?iso-8859-1?Q?9uRScRaB+6oOQEgP0FA1hDNqMV7Ra5rX0hA3WEA5a5Ryx1sEaeCUToIvmr?=
 =?iso-8859-1?Q?m0LuL12pkWqi9yhdh6cW1DLakiUeOGM4nLTQBrPvb5gvRBaggAzhuwBA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27069f85-185b-44fb-f436-08dcb76b75cd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 05:32:14.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KcE/fE4qRyJ5NA/yCoBu1Qck/UhkCkEvbQdJxJafuE4aX81ndrR/P9LXMKV1wuyfXvLKdMMFJM0e7rwnDSoew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7753
X-OriginatorOrg: intel.com


hi, Shakeel Butt,

below report is just FYI that we observed expected performance improvement
by this commit when it merges into mainline.


Hello,

kernel test robot noticed a 12.7% improvement of will-it-scale.per_thread_ops on:


commit: fefc6e6631ff43427e81f08c8e49f7787ff0213a ("memcg: rearrange fields of mem_cgroup_per_node")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: thread
	test: fallocate1
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240808/202408081325.cba32176-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/thread/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/fallocate1/will-it-scale

commit: 
  16540dae95 ("mm/hugetlb: mm/memory_hotplug: use a folio in scan_movable_pages()")
  fefc6e6631 ("memcg: rearrange fields of mem_cgroup_per_node")

16540dae959d8629 fefc6e6631ff43427e81f08c8e4 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3379            +3.7%       3505        vmstat.system.cs
      0.03            +0.0        0.03        mpstat.cpu.all.soft%
      2.43 ±  2%      +0.3        2.74        mpstat.cpu.all.usr%
 1.175e+09 ±  4%     +12.7%  1.324e+09 ±  2%  numa-numastat.node1.local_node
 1.176e+09 ±  4%     +12.7%  1.325e+09 ±  2%  numa-numastat.node1.numa_hit
 1.176e+09 ±  4%     +12.7%  1.325e+09 ±  2%  numa-vmstat.node1.numa_hit
 1.175e+09 ±  4%     +12.7%  1.324e+09 ±  2%  numa-vmstat.node1.numa_local
    512.33 ±  7%     +18.1%     605.00 ±  4%  perf-c2c.DRAM.remote
     11617 ±  3%     -36.0%       7432 ±  3%  perf-c2c.HITM.local
     11729 ±  3%     -35.5%       7560 ±  3%  perf-c2c.HITM.total
   3888543 ±  2%     +12.7%    4381027        will-it-scale.104.threads
     37389 ±  2%     +12.7%      42124        will-it-scale.per_thread_ops
   3888543 ±  2%     +12.7%    4381027        will-it-scale.workload
    108778            +1.9%     110794        proc-vmstat.nr_active_anon
    125909            +1.6%     127870        proc-vmstat.nr_shmem
    108778            +1.9%     110794        proc-vmstat.nr_zone_active_anon
 2.346e+09 ±  2%     +12.7%  2.645e+09        proc-vmstat.numa_hit
 2.346e+09 ±  2%     +12.7%  2.644e+09        proc-vmstat.numa_local
 2.344e+09 ±  2%     +12.7%  2.642e+09        proc-vmstat.pgalloc_normal
 2.344e+09 ±  2%     +12.7%  2.642e+09        proc-vmstat.pgfree
      0.38 ±  3%     +14.5%       0.44 ±  3%  perf-stat.i.MPKI
  9.03e+09 ±  2%      +9.8%  9.913e+09        perf-stat.i.branch-instructions
  62094186 ±  2%      +9.4%   67900586        perf-stat.i.branch-misses
      9.12 ± 12%      +3.4       12.55 ±  4%  perf-stat.i.cache-miss-rate%
  16493860 ±  4%     +26.3%   20825485 ±  3%  perf-stat.i.cache-misses
      3351            +3.8%       3478        perf-stat.i.context-switches
      6.65 ±  2%      -9.4%       6.02        perf-stat.i.cpi
     17670 ±  4%     -21.0%      13968 ±  3%  perf-stat.i.cycles-between-cache-misses
 4.357e+10 ±  2%     +10.3%  4.806e+10        perf-stat.i.instructions
      0.15 ±  2%     +10.2%       0.17        perf-stat.i.ipc
      0.38 ±  3%     +14.6%       0.43 ±  4%  perf-stat.overall.MPKI
      9.08 ± 12%      +3.4       12.53 ±  4%  perf-stat.overall.cache-miss-rate%
      6.65 ±  2%      -9.4%       6.03        perf-stat.overall.cpi
     17578 ±  4%     -20.9%      13910 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.15 ±  2%     +10.3%       0.17        perf-stat.overall.ipc
   3381489            -2.1%    3309583        perf-stat.overall.path-length
 8.999e+09 ±  2%      +9.8%  9.879e+09        perf-stat.ps.branch-instructions
  61855583 ±  2%      +9.4%   67639923        perf-stat.ps.branch-misses
  16442095 ±  4%     +26.3%   20763410 ±  3%  perf-stat.ps.cache-misses
      3339            +3.8%       3465        perf-stat.ps.context-switches
 4.343e+10 ±  2%     +10.3%   4.79e+10        perf-stat.ps.instructions
 1.315e+13 ±  2%     +10.3%   1.45e+13        perf-stat.total.instructions
     41.20            -2.4       38.78        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.shmem_undo_range.shmem_setattr
     41.17            -2.4       38.76        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     41.18            -2.4       38.78        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.shmem_undo_range
     42.62            -2.4       40.24        perf-profile.calltrace.cycles-pp.folios_put_refs.shmem_undo_range.shmem_setattr.notify_change.do_truncate
     50.27            -2.3       47.96        perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_setattr.notify_change.do_truncate.do_ftruncate
     50.30            -2.3       47.99        perf-profile.calltrace.cycles-pp.do_ftruncate.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     50.29            -2.3       47.98        perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_ftruncate.__x64_sys_ftruncate.do_syscall_64
     50.28            -2.3       47.98        perf-profile.calltrace.cycles-pp.shmem_setattr.notify_change.do_truncate.do_ftruncate.__x64_sys_ftruncate
     50.30            -2.3       47.99        perf-profile.calltrace.cycles-pp.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     50.30            -2.3       48.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ftruncate64
     50.29            -2.3       47.99        perf-profile.calltrace.cycles-pp.do_truncate.do_ftruncate.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     50.30            -2.3       48.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     50.33            -2.3       48.03        perf-profile.calltrace.cycles-pp.ftruncate64
     41.67            -2.3       39.39        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.shmem_undo_range.shmem_setattr.notify_change
      4.78            -0.2        4.60        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range
      4.77            -0.2        4.60        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
      4.77            -0.2        4.60        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      4.83            -0.2        4.66        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change
      4.83            -0.2        4.67        perf-profile.calltrace.cycles-pp.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      4.82            -0.2        4.66        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr
      0.58            +0.1        0.68 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio
      1.90 ±  3%      +0.1        2.00 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr
      0.74            +0.1        0.86 ±  2%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.76            +0.1        0.89 ±  2%  perf-profile.calltrace.cycles-pp.folio_alloc_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      2.12 ±  3%      +0.1        2.26        perf-profile.calltrace.cycles-pp.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr.notify_change
      0.74            +0.1        0.88 ±  2%  perf-profile.calltrace.cycles-pp.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.88            +0.1        1.02        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.fallocate64
      0.91            +0.2        1.06 ±  2%  perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      1.24            +0.2        1.40 ±  2%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.97            +0.2        1.14 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.fallocate64
      2.42 ±  3%      +0.2        2.60        perf-profile.calltrace.cycles-pp.truncate_inode_folio.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      1.87            +0.3        2.14        perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.93 ±  4%      +0.4        1.32 ±  3%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.17 ±141%      +0.5        0.64        perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.08 ±223%      +0.6        0.64 ±  5%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.08 ±223%      +0.6        0.73 ±  7%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__lruvec_stat_mod_folio.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio
      0.00            +0.8        0.76 ±  3%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__lruvec_stat_mod_folio.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp
     44.65            +1.5       46.16        perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
     45.05            +1.6       46.62        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     45.84            +1.7       47.56        perf-profile.calltrace.cycles-pp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.08            +1.7       47.83        perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     46.28            +1.8       48.05        perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     46.42            +1.8       48.20        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     46.96            +1.9       48.83        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fallocate64
     49.32            +2.3       51.59        perf-profile.calltrace.cycles-pp.fallocate64
     42.73            -2.4       40.38        perf-profile.children.cycles-pp.folios_put_refs
     50.30            -2.3       47.99        perf-profile.children.cycles-pp.do_ftruncate
     50.29            -2.3       47.98        perf-profile.children.cycles-pp.notify_change
     50.28            -2.3       47.98        perf-profile.children.cycles-pp.shmem_setattr
     50.27            -2.3       47.96        perf-profile.children.cycles-pp.shmem_undo_range
     50.30            -2.3       47.99        perf-profile.children.cycles-pp.__x64_sys_ftruncate
     50.29            -2.3       47.99        perf-profile.children.cycles-pp.do_truncate
     50.33            -2.3       48.03        perf-profile.children.cycles-pp.ftruncate64
     41.70            -2.3       39.43        perf-profile.children.cycles-pp.__page_cache_release
     84.80            -2.3       82.54        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     84.78            -2.2       82.54        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     84.77            -2.2       82.53        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     96.84            -0.5       96.31        perf-profile.children.cycles-pp.do_syscall_64
     97.39            -0.4       96.95        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.85            -0.2        4.68        perf-profile.children.cycles-pp.lru_add_drain_cpu
      4.83            -0.2        4.67        perf-profile.children.cycles-pp.__folio_batch_release
      0.41 ±  3%      -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.rcu_all_qs
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.07            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xas_create
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__errno_location
      0.09 ±  4%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.08 ±  4%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.file_modified
      0.08 ±  8%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.security_file_permission
      0.09 ±  4%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.inode_add_bytes
      0.12 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.folio_unlock
      0.10 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.xas_find_conflict
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.uncharge_folio
      0.10 ±  5%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.xas_start
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.try_charge_memcg
      0.12            +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.noop_dirty_folio
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__fdget
      0.12 ±  4%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.shmem_recalc_inode
      0.17 ±  5%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.xas_init_marks
      0.08 ± 17%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.16 ±  2%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.14 ±  3%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.uncharge_batch
      0.22 ±  5%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.xas_clear_mark
      0.10 ±  8%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.18 ±  3%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.filemap_get_entry
      0.18 ± 14%      +0.0        0.21        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.21 ±  4%      +0.0        0.24        perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.13 ±  5%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.29 ±  4%      +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.free_unref_folios
      0.29 ±  3%      +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.find_lock_entries
      0.27 ±  2%      +0.0        0.32 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.16 ±  3%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.24 ±  2%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.22 ±  3%      +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.rmqueue
      0.25 ±  2%      +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.xas_load
      0.25 ±  4%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.15 ±  3%      +0.1        0.20 ±  5%  perf-profile.children.cycles-pp.__count_memcg_events
      0.34 ±  2%      +0.1        0.40        perf-profile.children.cycles-pp.get_page_from_freelist
      0.40 ±  2%      +0.1        0.47 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.61 ±  2%      +0.1        0.71 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      1.91 ±  3%      +0.1        2.02 ±  2%  perf-profile.children.cycles-pp.__filemap_remove_folio
      0.65 ±  2%      +0.1        0.76 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.29            +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.75 ±  2%      +0.1        0.87 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.77 ±  2%      +0.1        0.90 ±  2%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      2.41            +0.1        2.54 ±  2%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      2.13 ±  3%      +0.1        2.27        perf-profile.children.cycles-pp.filemap_remove_folio
      0.76            +0.2        0.91 ±  2%  perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      0.92            +0.2        1.08 ±  2%  perf-profile.children.cycles-pp.shmem_alloc_folio
      0.94            +0.2        1.10 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.99            +0.2        1.16 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.51 ±  5%      +0.2        0.67        perf-profile.children.cycles-pp.lru_add_fn
      2.42 ±  3%      +0.2        2.60        perf-profile.children.cycles-pp.truncate_inode_folio
      0.43 ±  9%      +0.2        0.64 ±  5%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      1.90            +0.3        2.18        perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.94 ±  4%      +0.4        1.33 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.28 ±  4%      +0.7        2.01 ±  5%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
     44.72            +1.5       46.24        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
     45.09            +1.6       46.66        perf-profile.children.cycles-pp.shmem_get_folio_gfp
     45.86            +1.7       47.57        perf-profile.children.cycles-pp.shmem_fallocate
     46.09            +1.7       47.83        perf-profile.children.cycles-pp.vfs_fallocate
     46.28            +1.8       48.06        perf-profile.children.cycles-pp.__x64_sys_fallocate
     49.38            +2.3       51.66        perf-profile.children.cycles-pp.fallocate64
     84.78            -2.2       82.54        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.19 ±  5%      -0.4        0.76 ±  6%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.40 ±  2%      -0.2        0.22 ±  2%  perf-profile.self.cycles-pp.folios_put_refs
      0.48 ±  3%      -0.0        0.44        perf-profile.self.cycles-pp.folio_batch_move_lru
      0.13 ±  5%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.09            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.alloc_pages_mpol_noprof
      0.10 ±  3%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.10 ±  4%      +0.0        0.11        perf-profile.self.cycles-pp.__folio_cancel_dirty
      0.08 ±  6%      +0.0        0.09        perf-profile.self.cycles-pp.xas_find_conflict
      0.09 ±  5%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.09 ±  5%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.rmqueue
      0.08            +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.folio_add_lru
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.08 ±  4%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.shmem_alloc_folio
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.12            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.09            +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.xas_start
      0.06 ±  6%      +0.0        0.08        perf-profile.self.cycles-pp.__mod_zone_page_state
      0.14 ±  3%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.free_unref_folios
      0.13 ±  4%      +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.vfs_fallocate
      0.11 ±  4%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.folio_unlock
      0.14 ±  2%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.__fdget
      0.13 ±  4%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.fallocate64
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.uncharge_folio
      0.12            +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.noop_dirty_folio
      0.15 ±  4%      +0.0        0.18 ±  5%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.10 ±  9%      +0.0        0.12 ±  7%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.07 ± 25%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.shmem_alloc_and_add_folio
      0.24 ±  4%      +0.0        0.27 ±  3%  perf-profile.self.cycles-pp.find_lock_entries
      0.13 ±  3%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.17 ±  4%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.xas_load
      0.14 ±  5%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.__filemap_remove_folio
      0.20 ±  2%      +0.0        0.24 ±  3%  perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.14 ±  3%      +0.0        0.18 ±  6%  perf-profile.self.cycles-pp.shmem_inode_acct_blocks
      0.26 ±  2%      +0.0        0.30 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.12 ±  4%      +0.0        0.17 ±  6%  perf-profile.self.cycles-pp.__count_memcg_events
      0.10 ±  3%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.27 ±  3%      +0.0        0.32 ±  3%  perf-profile.self.cycles-pp.shmem_fallocate
      0.15 ±  5%      +0.1        0.20        perf-profile.self.cycles-pp.__page_cache_release
      0.24 ±  2%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.36 ±  3%      +0.1        0.41        perf-profile.self.cycles-pp.xas_store
      0.35 ±  2%      +0.1        0.41 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.12 ±  3%      +0.1        0.19 ±  7%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.22 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.lru_add_fn
      0.56            +0.1        0.65        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.93            +0.2        1.09        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.99            +0.2        1.16 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.42 ±  9%      +0.2        0.64 ±  5%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      1.18 ±  5%      +0.7        1.88 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


