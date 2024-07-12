Return-Path: <cgroups+bounces-3648-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E5E92F54E
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 08:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F9F1F21979
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 06:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0EA8F49;
	Fri, 12 Jul 2024 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrtQ/NY5"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983217BBF
	for <cgroups@vger.kernel.org>; Fri, 12 Jul 2024 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720764339; cv=fail; b=pVLvUM5qiF5gCjzI1A1I8wxam0bV5yClaeAxoklfpFHjnyp9hxQvgBck+0vY2KpqIkeOqxNq3BJUCIoMGwMfPDViYLVvbmL6dXUIMTeHjHeQMwPY/Set0W/d3T77au3mnaDyVijJeQXj83jxPjswiYx83wAGoX3LMpLIQrtZfBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720764339; c=relaxed/simple;
	bh=ErrKUVMcP6AuBnvIIWuJXy82JkZbTrKdXBO3ZMgTGfQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=DRzSmmyzI1CMdW9SZ2Xz/Bn1CQ6v/Nqo43fxCBcEskzaWdlQYAUCTN3UKdKQuaHZyL65kUpYAIaP3wAsId0QoEwbLvRCqVk6D0ilwvVOJ5hFcKvvDzG1EuZAH+ROSODNiHt1MHOwLUd0qtkR8aqk/KSZTHRpOUzH3YoZPQ7/pcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrtQ/NY5; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720764337; x=1752300337;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=ErrKUVMcP6AuBnvIIWuJXy82JkZbTrKdXBO3ZMgTGfQ=;
  b=KrtQ/NY5fd2pyDQ9pg3zbb7T0xkvtiDvSHGz/QZt/8l7n60awJBbRdUV
   3L+aE7djsKr84zfHWsMULT1x7YRY/MNzJbi4vRLl8T4O7AtImkFtDX8o8
   odoa0wpJSreqRP+NFrLXvBt3H9163UjPoNVYI27suZ1xzC726ljsfFUFy
   0U3k9nKqsHAWmGVQpo0bZ/LKva3v0rKPe3dRsI5PqnXmVsTGNjPnNTSH0
   KOc4qGIrnLseR4SNvZpL8ElU14dVlEAOZHYMrptSWYvgIRUbBntwuFo0m
   Nruff/AUGsaTvfqb5LTJSgQkUB5KTmdoRTFvvJ01wOYbHv2P0mbv2NaDS
   Q==;
X-CSE-ConnectionGUID: NNr0LMnlQ0ac1bMGSyVj8A==
X-CSE-MsgGUID: wz8j6EFFRrmabikoUCLMew==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18033377"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18033377"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 23:05:36 -0700
X-CSE-ConnectionGUID: 062a2SSQQsWG4RKD+qlPsA==
X-CSE-MsgGUID: +Pw5TJRIS9q4jzuTtPtBAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48775365"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 23:05:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 23:05:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 23:05:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 23:05:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 23:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncf8TerkzGC3PhJp7841x/ItQjXPhS+Rbs+W+CAwQqRY7RI2em6JIQcYjqmhfouRccqylRRNi3K8JnwJsjwjg/DvZhT5p4vfkjXZh4xNu1KlFIAf4xql5zympjqRt5bk6OZQlBvSYX5ESqHgaV6ATf3+rGOOH7o44YBaX+yFkRIdwA9oCRqVR0IW3MIxVSw8gS6wHKHSx20hH+gbdX8zR8Hua03JyFSVG+ljK4VgAVcm00SrrGZ8uyOgG/LMMDUn8NAfUlAR6q1Z44ffBIpB1dKo7G4QfYW35pUGlB5xKA091JECOmp2x3OroS9yq7Di7lbAi3lsTf1bjewaZEtaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UySLUJf4G2whs96Dd1Sxf3sjkRjlakBfD9DXlVUUKo0=;
 b=GuTeCNJTZxSAz3r56vDDEfi+kWYWsI96BqQ8u+p+ZIlPSbdAcYApId54Jtye21Tj4KAA2yutESmmmVR20J4Bk90D/4MrClty44sOW88NRna/OSH+wTBm6pD6VVYNCLPhUpte0W9yzoR/lJLU7kIDtd0SOCZn0mZSCB3+zdz+cPuuaePgTKtmB8J2yuzYMmZiyl8ZLcYyNX3B6EzDaUccMwfpfLSF9UbGKfEFaXB2q8UAslz3avC1LIq8AkAtZJRp5VGhr0Zf+/o44VzsfxO6S2r39mj26aNgcQwAUuUf492G2yT9KSEvy2yP0FFsgnP4MPDaWCoOeDdb3ax+Q+CFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB7039.namprd11.prod.outlook.com (2603:10b6:806:2b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 06:05:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 06:05:01 +0000
Date: Fri, 12 Jul 2024 14:04:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt
	<shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko
	<mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	<cgroups@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [mm]  98c9daf5ae:  aim7.jobs-per-min -29.4%
 regression
Message-ID: <202407121335.31a10cb6-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc79754-0c91-4d50-c8fb-08dca23890d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?IsQHIYYnwSa8KPHYaAHRSLeugF7TODj0lI4ubSG9F/bMud7I/Q+Nagp1Hc?=
 =?iso-8859-1?Q?72S/0LTJAMAWAQDD7jC/Bb9Fak6cSa2O71Uod1NEFMi1SMaiIVeFI20fQS?=
 =?iso-8859-1?Q?vTH4dP+E2zI01eVX8qjpbxqytUncIwzypbi5dYrSgUzdNE9V3Xf1E3VEiU?=
 =?iso-8859-1?Q?Qj7dTzyhk75qMQC+jBpWO+SLY4DISN+L3H2eAwVBvL4EqVF2wH02UCO7j6?=
 =?iso-8859-1?Q?oBd2j20QVhjifjJ1jiEYyIg5lqsKPSOl25jYOvXhqRdotvKdjGPsMUBrbB?=
 =?iso-8859-1?Q?kqMD65Zfk6m+DKUB7TemE1fTEIMLt+hmi0Gr14BPhWSLWFnM23TlelB0ts?=
 =?iso-8859-1?Q?RSMwwLcjfWaoj+nhibWKbhZzF5rj6z1PW5ElVXlYGMttesdFMg9N/rhK9g?=
 =?iso-8859-1?Q?6V9Oq7KAK6qnp0q6IyJpc2gZ53RZ2stbJmPgpxsPRidfvW0bJfaHj6rMa2?=
 =?iso-8859-1?Q?MrBTTQUZb3jKNdq/qxwBLQVdmhY2HDv1L6OmxgoS0/0EnEWuktY9q4Dxl4?=
 =?iso-8859-1?Q?FRxp5HuDBzfuZTInkMY+6reN6X497H+QaRoXJZxrbbBV7x2rOHutjRNozN?=
 =?iso-8859-1?Q?f1qtp+ilJLYsSRjyEnePnM52MBKtS0VLhTFIT41QtkYSUgs5iC8vymB092?=
 =?iso-8859-1?Q?V9bJdqL/gDE2zDzDPq4H/ObEnAM+jAHWp9cJX9JdEt79+R4toN1vFcmSl/?=
 =?iso-8859-1?Q?0Z1BYAPKXXNF/hVWXuPzQWSQ0R1nlV2marol7gGq5g4Ql7nJDU6RyXzG/G?=
 =?iso-8859-1?Q?FuZupkJpapIgAeRrewoPkooInEwO5nHy3sW6FvjS9Yv8lCcqRcBpWrmgfT?=
 =?iso-8859-1?Q?SG72p8xWCFUFvFFJoTKAW+D2tih09m1uohwRNWaytYGbTZVkBwH3dZnhck?=
 =?iso-8859-1?Q?mbgeQAVbrfjBQVfdkzRUcesM1RQfh1O6Xl1vUNwRFpfaeDYsKifSAynHtA?=
 =?iso-8859-1?Q?9v+1EI0NeuAsI810R1lmHrfQa2m0FHz4NhqwsvBl6pCQjfVLpUWUwJb6rc?=
 =?iso-8859-1?Q?56r+lkwJXf8GwcwVkdvPhjurxP8kPxu9dfz8HEJDcwmfrb/j2EBiIR4haU?=
 =?iso-8859-1?Q?aSVBS36D+2cUHEjGt37JCsufJJgK+CMBZYCQ93pHIWGCyeVAW07kIQJQAq?=
 =?iso-8859-1?Q?pnUzksam7Uhk8zGD8k6fuNsJF++JUn5dMO7GyUYsINHtQ+++R5o6ep6ZnH?=
 =?iso-8859-1?Q?gSJk1IYbohLai4fyxKh6O4nMfgO1d3GL+vkwG17/R3k1X6WJMMkbEmOaYH?=
 =?iso-8859-1?Q?jnysIBsArQX4H8KeTAposavxx53YJUweughVTWhPMphy+pAIe7224w9kJ5?=
 =?iso-8859-1?Q?IuGpHgKvPhwBOnXpyc2i/EAGl79EBQjEw/IDD4owp7aoxt6EFXgmrvK+Px?=
 =?iso-8859-1?Q?Tjz4a+ELfP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AxCyg/SPBi4rtDp1DbCih84XaPsSpoVlZc/JcYR+leqHrzly8CdG+7Y9sF?=
 =?iso-8859-1?Q?68Jyq6F2mes1Prrw3etFk2pmfjPFw9E/W7YtmhSXQLAyiXpDTQ3f4ndGOT?=
 =?iso-8859-1?Q?JBJMObmpOi2oKx8P9CqRBYdkPUEPIQa8YkNAE2gXVUCu/KbHCanITndlnd?=
 =?iso-8859-1?Q?Ec0wd+tcIQKOLhmhfSNuymRAmyJ+/Aq173mUOmCnAG0ZqiTjjRjsSHYCps?=
 =?iso-8859-1?Q?YQvLVFETD5keAwxsrJ7bJeS6La6McO71VGbUnknHe8t5m1zxDRR1ECYBys?=
 =?iso-8859-1?Q?YuG0IQQ/ybkSVLGxBydlCv4swiLfDphYcHlat+CHztW6JBOEKvIEbjW9Ry?=
 =?iso-8859-1?Q?iH8CJ0Wp9fxf6W1FdkktYCxZjdvaiV55RAg6Wpi3MAlY8tH6XXhY56A/1b?=
 =?iso-8859-1?Q?2DxckhnyKMaLqY0Q06EGlKb0kJmJjA0ugOqgXUBj4YwxA9SJxSuFSD5DcT?=
 =?iso-8859-1?Q?Nj1ysfvwu0tFlAf+SQOI6PlmRiFXkqC+vEZo3Askk49N2b2nvVU74rcubv?=
 =?iso-8859-1?Q?//PAHLwxB/OutxS9VQtKbjxRIOlCigygq3VTDjnJ2IfJQbU9v60jbTEDG2?=
 =?iso-8859-1?Q?v0nG6y2xGVaxRXsWl46zFZ90rnnfjAXy6prQnfHT1uLnFPp/daBpUvQdpc?=
 =?iso-8859-1?Q?CY7foIDjvdJY8E6ySHgmdlVMQgw+EIy152Dusx5nU9StRGWCXxUUnyuSi8?=
 =?iso-8859-1?Q?s2eyquxBZW/qP3fix56cq7YqfX1HIcL0c7b9N5LpWmtIE6KrY7P4F0PUrT?=
 =?iso-8859-1?Q?AbZApCCHlX94rrhh/PQhZK0++SApmtknLzJCCrLWik6IPfE7fW+X706IK1?=
 =?iso-8859-1?Q?RlGJd8OFKVjMek49bhOdAA8e4LuXvfCEo6KsBq2d+NIwm9huXmUgdnoV1+?=
 =?iso-8859-1?Q?9E+zWt6AP4wK5Rn/2xeLHQaqvENYijgf3KYkWZ0Ax1KnSaVW0Y1DK+wbe2?=
 =?iso-8859-1?Q?SCoLqYDV6mSK6pZorU27JBECQXCjM1JsKcwEqxUJXt2LdylbiyTcIxXQGd?=
 =?iso-8859-1?Q?oNMANcDYQsaX1y+1FxoRWPU3ojq+g0CPDbK0AvFMuwjrxSED/qbG2mNkk8?=
 =?iso-8859-1?Q?Py8He5hnof6XkjTqtoMFSaoKKT3pPAJ24oZAp+1TzbycveKof430WjLKEa?=
 =?iso-8859-1?Q?c86P1/Aoj/NnFoYcYHASvGRFT4CCkzZF7csxyiPWAS7yAOThjRkd8ge8hU?=
 =?iso-8859-1?Q?5vPTzdt7trTNmYEKveqVp+vEPvIswLgqXSEW/BGehADwW2YJq6WS5ZZWuh?=
 =?iso-8859-1?Q?RrssCYpHy+L14mDj0gR5njzMGAprf4brZyz0etJJwLFadLS1K8XFjeIKMy?=
 =?iso-8859-1?Q?3gUMwsgrH+9V7EAwRGssNaSIk1wLErmxxnD2D3wUYp6L+3LajeNkC/3sGZ?=
 =?iso-8859-1?Q?5UBiHzPanbVy5QoiGAK6qbmwEnmT3r/F9ALmLarljo2tiESqAtD64GbM/i?=
 =?iso-8859-1?Q?QzCy6KAe0q5Y0EP6Q6q4xhO+G9BeXehg6AwKxNofP/9kyvkq8HYprTpj9U?=
 =?iso-8859-1?Q?tt5xAr38nAiS/gIXJCC0naPUSy2mRuIW8M8q420LMA4kQvCzjrDpgL+k88?=
 =?iso-8859-1?Q?uoDvuAQuHanWkyg/yKKwDSViVKlw+KUvxtnlh2YtLJ8ng9PWmsbVAvjlHw?=
 =?iso-8859-1?Q?5xbGbL2tpwAlLzexrIrssOFtYP6Zr9yAfexLaRMXYJbHsMDJp7ogv8pw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc79754-0c91-4d50-c8fb-08dca23890d6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 06:05:01.5688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rImrwR/yTtd24lYb5XZ4IG47XmODHnLwt7R4l9fZzUT2CSnCU13yND9Ux6CdT5wpqQT5MDxjl3SSef0vekzFmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7039
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -29.4% regression of aim7.jobs-per-min on:


commit: 98c9daf5ae6be008f78c07b744bcff7bcc6e98da ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: aim7
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	disk: 1BRD_48G
	fs: ext4
	test: disk_rr
	load: 3000
	cpufreq_governor: performance


some further information.

we don't have CONFIG_MEMCG_V1 in our config which is uploaded to [1]
# CONFIG_MEMCG_V1 is not set

we also tried to capturing perf-c2c data in the whole process of this benchmark.
got below:

94b7e5bf09b08aa4 98c9daf5ae6be008f78c07b744b
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
      5252 ±  4%     +86.6%       9801 ±  3%  perf-c2c.DRAM.local
    149160 ±  3%     +95.7%     291886 ±  2%  perf-c2c.DRAM.remote
     98978          +114.6%     212395        perf-c2c.HITM.local
     10458 ±  2%     +47.2%      15397 ±  2%  perf-c2c.HITM.remote
    109437          +108.1%     227793        perf-c2c.HITM.total



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407121335.31a10cb6-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


[1]
The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240712/202407121335.31a10cb6-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-13/performance/1BRD_48G/ext4/x86_64-rhel-8.3/3000/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/disk_rr/aim7

commit: 
  94b7e5bf09 ("mm: memcg: put memcg1-specific struct mem_cgroup's members under CONFIG_MEMCG_V1")
  98c9daf5ae ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")

94b7e5bf09b08aa4 98c9daf5ae6be008f78c07b744b 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4752 ± 13%     -18.1%       3890 ± 11%  sched_debug.cpu.avg_idle.min
     76.42           +15.1%      87.99 ±  3%  uptime.boot
     53.28 ±  2%     -27.5%      38.65 ±  2%  iostat.cpu.idle
     44.58 ±  2%     +33.6%      59.58        iostat.cpu.system
      2.13           -17.0%       1.77        iostat.cpu.user
     49.85 ±  2%     -14.7       35.17 ±  2%  mpstat.cpu.all.idle%
     47.74 ±  2%     +15.1       62.82        mpstat.cpu.all.sys%
      2.23            -0.4        1.82        mpstat.cpu.all.usr%
     53.29 ±  2%     -27.4%      38.70 ±  2%  vmstat.cpu.id
     65.83 ±  4%     +59.1%     104.76 ±  3%  vmstat.procs.r
      8385 ±  4%     +34.6%      11284 ±  3%  vmstat.system.cs
    245966 ±  2%      +8.1%     265964        vmstat.system.in
    778685           -29.4%     549435        aim7.jobs-per-min
     23.31           +41.4%      32.96        aim7.time.elapsed_time
     23.31           +41.4%      32.96        aim7.time.elapsed_time.max
     47890 ±  7%    +338.5%     210000 ±  3%  aim7.time.involuntary_context_switches
      6674           +26.7%       8455        aim7.time.percent_of_cpu_this_job_got
      1510           +81.7%       2744 ±  2%  aim7.time.system_time
     19454 ±  3%      +9.1%      21223 ±  3%  aim7.time.voluntary_context_switches
     49345 ±  6%    +108.4%     102820 ± 10%  meminfo.Active
     22670 ± 11%    +182.6%      64065 ± 15%  meminfo.Active(anon)
     26674 ±  4%     +45.3%      38754 ±  4%  meminfo.Active(file)
     33695           +18.6%      39973 ±  3%  meminfo.AnonHugePages
   1360098 ±  3%     +14.0%    1551107 ±  2%  meminfo.Inactive
    803759           +15.0%     924519        meminfo.Inactive(anon)
     66977 ±  3%    +115.7%     144485 ±  7%  meminfo.Mapped
     78152 ±  9%    +188.4%     225431 ±  5%  meminfo.Shmem
     15327 ±  8%     +52.6%      23389 ± 11%  numa-meminfo.node0.Active
     13455 ±  9%     +46.0%      19642 ± 10%  numa-meminfo.node0.Active(file)
     19657 ± 14%    +111.2%      41510 ± 18%  numa-meminfo.node0.Mapped
      6081 ± 16%     +84.9%      11247 ± 42%  numa-meminfo.node0.Shmem
     33647 ±  8%    +134.3%      78825 ± 15%  numa-meminfo.node1.Active
     20790 ± 14%    +188.7%      60020 ± 18%  numa-meminfo.node1.Active(anon)
     12857 ±  7%     +46.3%      18805 ±  9%  numa-meminfo.node1.Active(file)
    485228 ± 23%     +85.5%     899983 ± 21%  numa-meminfo.node1.Inactive
    202089 ± 50%    +192.9%     591917 ± 32%  numa-meminfo.node1.Inactive(anon)
     47991 ±  7%    +112.0%     101755 ±  8%  numa-meminfo.node1.Mapped
     72431 ±  8%    +194.1%     213055 ±  4%  numa-meminfo.node1.Shmem
      3290 ± 10%     +50.9%       4965 ± 10%  numa-vmstat.node0.nr_active_file
      4793 ± 17%    +113.8%      10249 ± 20%  numa-vmstat.node0.nr_mapped
      1519 ± 16%     +72.6%       2622 ± 33%  numa-vmstat.node0.nr_shmem
      3294 ±  9%     +50.9%       4970 ± 10%  numa-vmstat.node0.nr_zone_active_file
      4955 ± 11%    +202.3%      14980 ± 18%  numa-vmstat.node1.nr_active_anon
      3376 ±  8%     +40.1%       4729 ±  7%  numa-vmstat.node1.nr_active_file
     50152 ± 51%    +194.6%     147731 ± 32%  numa-vmstat.node1.nr_inactive_anon
     12101 ±  7%    +109.5%      25357 ±  8%  numa-vmstat.node1.nr_mapped
     17201 ±  7%    +208.3%      53026 ±  4%  numa-vmstat.node1.nr_shmem
      4955 ± 11%    +202.3%      14980 ± 18%  numa-vmstat.node1.nr_zone_active_anon
      3352 ±  8%     +41.1%       4729 ±  7%  numa-vmstat.node1.nr_zone_active_file
     50150 ± 51%    +194.6%     147730 ± 32%  numa-vmstat.node1.nr_zone_inactive_anon
      5776 ± 11%    +175.1%      15893 ± 16%  proc-vmstat.nr_active_anon
      6595 ±  8%     +46.7%       9677 ±  3%  proc-vmstat.nr_active_file
    187950            +2.0%     191760        proc-vmstat.nr_anon_pages
    945653            +6.0%    1002646        proc-vmstat.nr_file_pages
    201118           +14.8%     230842        proc-vmstat.nr_inactive_anon
     17214 ±  3%    +108.2%      35836 ±  6%  proc-vmstat.nr_mapped
     19951 ±  8%    +180.4%      55933 ±  4%  proc-vmstat.nr_shmem
     40267            +2.7%      41335        proc-vmstat.nr_slab_reclaimable
     86277            +1.8%      87792        proc-vmstat.nr_slab_unreclaimable
      5776 ± 11%    +175.1%      15893 ± 16%  proc-vmstat.nr_zone_active_anon
      6595 ±  8%     +46.7%       9677 ±  3%  proc-vmstat.nr_zone_active_file
    201118           +14.8%     230842        proc-vmstat.nr_zone_inactive_anon
    312.12 ±241%   +1618.1%       5362 ±125%  proc-vmstat.numa_pages_migrated
    369792           +19.6%     442285 ±  3%  proc-vmstat.pgfault
    312.12 ±241%   +1618.1%       5362 ±125%  proc-vmstat.pgmigrate_success
      2426 ±  2%     +29.2%       3135 ±  3%  proc-vmstat.pgpgout
      1515            +3.8%       1572        proc-vmstat.unevictable_pgs_culled
      0.63 ±  3%     +36.5%       0.85 ±  2%  perf-stat.i.MPKI
 1.885e+10           -23.7%  1.437e+10        perf-stat.i.branch-instructions
      2.78 ±  2%      -0.5        2.29 ±  4%  perf-stat.i.branch-miss-rate%
  67232899           -17.4%   55553782 ±  3%  perf-stat.i.branch-misses
     13.70 ±  3%      +2.5       16.17 ±  3%  perf-stat.i.cache-miss-rate%
 5.483e+08           -24.9%  4.118e+08        perf-stat.i.cache-references
      8605 ±  4%     +34.7%      11593 ±  4%  perf-stat.i.context-switches
      1.35           +65.4%       2.22 ±  3%  perf-stat.i.cpi
 1.616e+11           +22.1%  1.973e+11        perf-stat.i.cpu-cycles
 8.537e+10           -24.8%  6.416e+10        perf-stat.i.instructions
      0.96           -22.2%       0.75 ±  2%  perf-stat.i.ipc
     13455           -15.4%      11379 ±  3%  perf-stat.i.minor-faults
     13489           -15.5%      11396 ±  3%  perf-stat.i.page-faults
      0.85 ±  3%     +34.8%       1.15        perf-stat.overall.MPKI
      0.34            +0.0        0.36 ±  2%  perf-stat.overall.branch-miss-rate%
     13.23 ±  3%      +4.6       17.78        perf-stat.overall.cache-miss-rate%
      1.90           +62.8%       3.08        perf-stat.overall.cpi
      2231 ±  3%     +20.6%       2690 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.53           -38.5%       0.32        perf-stat.overall.ipc
  1.86e+10           -23.0%  1.433e+10        perf-stat.ps.branch-instructions
  64095803           -19.1%   51843320 ±  2%  perf-stat.ps.branch-misses
 5.417e+08           -23.9%  4.124e+08        perf-stat.ps.cache-references
      8220 ±  4%     +33.3%      10962 ±  4%  perf-stat.ps.context-switches
 1.597e+11           +23.5%  1.972e+11 ±  2%  perf-stat.ps.cpu-cycles
 8.426e+10           -24.1%  6.394e+10        perf-stat.ps.instructions
     12730           -18.7%      10354 ±  3%  perf-stat.ps.minor-faults
     12762           -18.8%      10369 ±  3%  perf-stat.ps.page-faults
      3.93 ±  6%      -3.2        0.69 ±  8%  perf-profile.calltrace.cycles-pp.creat64
      3.93 ±  6%      -3.2        0.69 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      3.93 ±  6%      -3.2        0.69 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      3.92 ±  6%      -3.2        0.68 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      3.92 ±  6%      -3.2        0.68 ±  8%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      3.91 ±  6%      -3.2        0.68 ±  8%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64
      3.91 ±  6%      -3.2        0.68 ±  8%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.87 ±  6%      -3.2        0.65 ±  9%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      3.66            -1.7        1.99 ±  2%  perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      3.31            -1.5        1.77 ±  2%  perf-profile.calltrace.cycles-pp.llseek
      2.87            -1.3        1.62 ±  2%  perf-profile.calltrace.cycles-pp.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      2.25            -1.0        1.29 ±  2%  perf-profile.calltrace.cycles-pp.block_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      2.17            -0.9        1.25 ±  2%  perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
      1.93            -0.8        1.14 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
      1.99            -0.8        1.23 ±  2%  perf-profile.calltrace.cycles-pp.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      1.79            -0.7        1.07 ±  2%  perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
      1.34            -0.7        0.68 ±  3%  perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.30            -0.6        0.66 ±  3%  perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      1.22            -0.6        0.65 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      1.17            -0.5        0.63 ±  2%  perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
      1.21            -0.5        0.67 ±  2%  perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_write_end.generic_perform_write
      0.96            -0.5        0.43 ± 47%  perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read.ksys_read
      1.08            -0.5        0.57 ±  3%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      1.08            -0.5        0.57 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      1.20            -0.5        0.70 ±  3%  perf-profile.calltrace.cycles-pp.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.05            -0.5        0.56 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.91            -0.5        0.42 ± 47%  perf-profile.calltrace.cycles-pp.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_write_end
      1.15            -0.5        0.68 ±  2%  perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      1.02            -0.5        0.55 ±  2%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.llseek
      1.30            -0.5        0.83 ±  2%  perf-profile.calltrace.cycles-pp.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict
      0.98            -0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      1.10 ±  3%      -0.4        0.67 ±  3%  perf-profile.calltrace.cycles-pp.workingset_activation.folio_mark_accessed.filemap_read.vfs_read.ksys_read
     30.65            -0.4       30.25        perf-profile.calltrace.cycles-pp.read
      0.98            -0.3        0.69 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      2.39            +0.2        2.61        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
      2.42            +0.2        2.64        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      2.39            +0.2        2.61        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range
      2.42            +0.2        2.64        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      2.38            +0.2        2.61        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      2.44            +0.4        2.89        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      2.38            +0.5        2.84        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      2.38            +0.5        2.84        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range
      2.38            +0.5        2.84        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release
     28.52            +0.6       29.11        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     28.38            +0.7       29.04        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.86            +0.7        5.54        perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
     27.89            +0.9       28.77        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     27.47            +1.1       28.54        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     25.90            +1.9       27.78        perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.26            +4.0       34.31        perf-profile.calltrace.cycles-pp.write
     21.06            +4.1       25.14        perf-profile.calltrace.cycles-pp.folio_mark_accessed.filemap_read.vfs_read.ksys_read.do_syscall_64
     19.70            +4.6       24.33        perf-profile.calltrace.cycles-pp.folio_activate.folio_mark_accessed.filemap_read.vfs_read.ksys_read
     19.63            +4.7       24.29        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_activate.folio_mark_accessed.filemap_read.vfs_read
     18.85            +4.7       23.52        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed.filemap_read
     18.84            +4.7       23.51        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed
     18.83            +4.7       23.51        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate
     28.38            +5.0       33.33        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     28.23            +5.0       33.25        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     27.72            +5.3       32.99        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     27.25            +5.5       32.74        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     25.87            +5.6       31.48        perf-profile.calltrace.cycles-pp.__close
     25.86            +5.6       31.46        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.86            +5.6       31.47        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.86            +5.6       31.47        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     25.84            +5.6       31.45        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.82            +5.6       31.44        perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.81            +5.6       31.44        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.__x64_sys_close.do_syscall_64
     25.79            +5.6       31.43        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.__x64_sys_close
     25.78            +5.6       31.42        perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dput.__fput
     25.63            +5.7       31.33        perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dput
     17.98            +6.1       24.07        perf-profile.calltrace.cycles-pp.folios_put_refs.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
     17.57            +6.2       23.81        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.truncate_inode_pages_range.ext4_evict_inode.evict
     17.33            +6.3       23.66        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.truncate_inode_pages_range
     17.34            +6.3       23.66        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.truncate_inode_pages_range.ext4_evict_inode
     17.32            +6.3       23.65        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     25.47            +6.5       31.92        perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.72 ±  2%      +7.3       31.06        perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
     17.89 ±  3%     +10.1       27.95        perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
     13.68 ±  4%     +12.1       25.73        perf-profile.calltrace.cycles-pp.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
     11.76 ±  5%     +13.0       24.76        perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      9.80 ±  6%     +13.4       23.16        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio
      9.81 ±  6%     +13.4       23.17        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio
      9.79 ±  6%     +13.4       23.16        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     10.38 ±  6%     +13.5       23.85        perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
     10.32 ±  6%     +13.5       23.82        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
      8.04 ±  8%      -7.2        0.84 ±  9%  perf-profile.children.cycles-pp.down_write
      7.67 ±  8%      -7.0        0.65 ± 12%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      7.66 ±  8%      -7.0        0.64 ± 12%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      7.28 ±  9%      -6.8        0.53 ± 14%  perf-profile.children.cycles-pp.osq_lock
      4.35 ± 10%      -4.1        0.30 ±  8%  perf-profile.children.cycles-pp.unlink
      4.34 ± 10%      -4.0        0.29 ±  8%  perf-profile.children.cycles-pp.__x64_sys_unlink
      4.34 ± 10%      -4.0        0.29 ±  8%  perf-profile.children.cycles-pp.do_unlinkat
      3.97 ±  6%      -3.3        0.71 ±  8%  perf-profile.children.cycles-pp.do_sys_openat2
      3.95 ±  6%      -3.2        0.70 ±  8%  perf-profile.children.cycles-pp.path_openat
      3.95 ±  6%      -3.2        0.70 ±  8%  perf-profile.children.cycles-pp.do_filp_open
      3.93 ±  6%      -3.2        0.69 ±  8%  perf-profile.children.cycles-pp.creat64
      3.92 ±  6%      -3.2        0.68 ±  8%  perf-profile.children.cycles-pp.__x64_sys_creat
      3.87 ±  6%      -3.2        0.66 ±  8%  perf-profile.children.cycles-pp.open_last_lookups
      3.70            -1.7        1.98 ±  2%  perf-profile.children.cycles-pp.llseek
      3.68            -1.7        2.00 ±  2%  perf-profile.children.cycles-pp.ext4_block_write_begin
      3.12            -1.4        1.67 ±  2%  perf-profile.children.cycles-pp.clear_bhb_loop
      2.90            -1.3        1.64 ±  2%  perf-profile.children.cycles-pp.ext4_da_write_end
      2.29            -1.0        1.31 ±  2%  perf-profile.children.cycles-pp.block_write_end
      2.20            -0.9        1.26 ±  2%  perf-profile.children.cycles-pp.__block_commit_write
      1.95            -0.8        1.15 ±  2%  perf-profile.children.cycles-pp.copy_page_to_iter
      1.99            -0.8        1.24 ±  2%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      1.80            -0.7        1.08 ±  2%  perf-profile.children.cycles-pp._copy_to_iter
      1.54            -0.7        0.82 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.34            -0.7        0.68 ±  3%  perf-profile.children.cycles-pp.ext4_da_get_block_prep
      1.32            -0.7        0.67 ±  3%  perf-profile.children.cycles-pp.ext4_da_map_blocks
     31.04            -0.6       30.46        perf-profile.children.cycles-pp.read
      1.19            -0.6        0.64 ±  2%  perf-profile.children.cycles-pp.filemap_get_pages
      1.18            -0.5        0.63 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.22            -0.5        0.68 ±  2%  perf-profile.children.cycles-pp.mark_buffer_dirty
      1.20            -0.5        0.70 ±  2%  perf-profile.children.cycles-pp.zero_user_segments
      1.20            -0.5        0.71 ±  2%  perf-profile.children.cycles-pp.memset_orig
      1.07            -0.5        0.58 ±  2%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.95            -0.5        0.46 ±  3%  perf-profile.children.cycles-pp.rw_verify_area
      1.32            -0.5        0.84 ±  2%  perf-profile.children.cycles-pp.try_to_free_buffers
      0.98            -0.5        0.53 ±  2%  perf-profile.children.cycles-pp.filemap_get_read_batch
      0.98 ±  2%      -0.4        0.53 ±  3%  perf-profile.children.cycles-pp.__fdget_pos
      0.77 ±  2%      -0.4        0.34 ±  3%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      1.10 ±  3%      -0.4        0.67 ±  3%  perf-profile.children.cycles-pp.workingset_activation
      0.80            -0.4        0.37 ±  2%  perf-profile.children.cycles-pp.file_modified
      0.86 ±  4%      -0.4        0.46 ±  3%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.77 ±  2%      -0.4        0.37 ±  3%  perf-profile.children.cycles-pp.security_file_permission
      0.92            -0.4        0.52 ±  2%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.80            -0.4        0.42 ±  2%  perf-profile.children.cycles-pp.xas_load
      0.74            -0.4        0.37 ±  3%  perf-profile.children.cycles-pp.folio_alloc_noprof
      0.70            -0.4        0.33 ±  3%  perf-profile.children.cycles-pp.touch_atime
      0.60 ±  2%      -0.4        0.24 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.71            -0.4        0.35 ±  3%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.80            -0.4        0.45 ±  2%  perf-profile.children.cycles-pp.create_empty_buffers
      0.68 ±  2%      -0.3        0.36 ±  3%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.62            -0.3        0.30 ±  3%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.59 ±  2%      -0.3        0.28 ±  3%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.62            -0.3        0.32 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.64            -0.3        0.34 ±  3%  perf-profile.children.cycles-pp.ksys_lseek
      1.01            -0.3        0.71 ±  2%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.62            -0.3        0.32 ±  3%  perf-profile.children.cycles-pp.filemap_get_entry
      0.57            -0.3        0.28 ±  3%  perf-profile.children.cycles-pp.atime_needs_update
      0.69            -0.3        0.40 ±  2%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.61            -0.3        0.32 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.60 ±  2%      -0.3        0.32 ±  3%  perf-profile.children.cycles-pp.fault_in_readable
      0.62            -0.3        0.35 ±  2%  perf-profile.children.cycles-pp.folio_alloc_buffers
      0.58            -0.3        0.32 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.37 ±  3%      -0.3        0.11 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.40 ±  6%      -0.3        0.14 ±  3%  perf-profile.children.cycles-pp.ext4_file_write_iter
      0.51 ±  3%      -0.2        0.27 ±  3%  perf-profile.children.cycles-pp.disk_rr
      0.59            -0.2        0.34 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      0.46            -0.2        0.22 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.55 ±  2%      -0.2        0.31 ±  3%  perf-profile.children.cycles-pp.alloc_buffer_head
      0.53            -0.2        0.30 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.36 ±  3%      -0.2        0.14 ±  4%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.36 ±  6%      -0.2        0.14 ±  5%  perf-profile.children.cycles-pp.ext4_file_read_iter
      0.40            -0.2        0.20 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.44            -0.2        0.25 ±  3%  perf-profile.children.cycles-pp.xas_store
      0.39            -0.2        0.19 ±  3%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.52            -0.2        0.33 ±  2%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.29 ±  4%      -0.2        0.10 ±  6%  perf-profile.children.cycles-pp.generic_update_time
      0.36 ±  2%      -0.2        0.18 ±  4%  perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.57 ±  2%      -0.2        0.40 ±  3%  perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.34 ±  2%      -0.2        0.18 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.25 ±  4%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.ext4_dirty_inode
      0.33            -0.2        0.17 ±  2%  perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.34            -0.2        0.18 ±  2%  perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.22 ±  5%      -0.2        0.06 ±  9%  perf-profile.children.cycles-pp.jbd2__journal_start
      0.21 ±  5%      -0.2        0.06 ±  8%  perf-profile.children.cycles-pp.start_this_handle
      0.31            -0.1        0.17 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.40            -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.30 ±  2%      -0.1        0.17 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.31 ±  2%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.block_invalidate_folio
      0.29 ±  2%      -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.x64_sys_call
      0.49            -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.folio_account_cleaned
      0.32            -0.1        0.19 ±  2%  perf-profile.children.cycles-pp.lookup_open
      0.27            -0.1        0.14 ±  2%  perf-profile.children.cycles-pp.generic_write_checks
      0.26 ±  3%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.rcu_all_qs
      0.26 ±  2%      -0.1        0.13 ±  4%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.27 ±  2%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.up_write
      0.27            -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.xas_start
      0.35 ±  2%      -0.1        0.22        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.17 ±  4%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.ext4_nonda_switch
      0.23            -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.folio_unlock
      0.22 ±  2%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.current_time
      0.27            -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.27 ±  2%      -0.1        0.17 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.18            -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.node_dirty_ok
      0.21 ±  2%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__slab_free
      0.26 ±  3%      -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.93 ±  2%      -0.1        0.84 ±  3%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.18 ±  2%      -0.1        0.09 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.19 ±  2%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.aa_file_perm
      0.20            -0.1        0.11 ±  2%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.21            -0.1        0.12 ±  2%  perf-profile.children.cycles-pp.ext4_create
      0.18            -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.rmqueue
      0.20 ±  2%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.find_lock_entries
      0.17 ±  5%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.19 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.17            -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.21 ±  2%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.17            -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.free_unref_folios
      0.20 ±  3%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.16 ±  2%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.vfs_unlink
      0.19            -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.mod_objcg_state
      0.14 ±  3%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__es_insert_extent
      0.16 ±  3%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__ext4_unlink
      0.14 ±  4%      -0.1        0.07        perf-profile.children.cycles-pp.__count_memcg_events
      0.14 ±  2%      -0.1        0.07        perf-profile.children.cycles-pp.__radix_tree_lookup
      0.16 ±  3%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.ext4_unlink
      0.18 ±  2%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.15 ±  3%      -0.1        0.08 ±  3%  perf-profile.children.cycles-pp.jbd2_journal_try_to_free_buffers
      0.12 ±  5%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.ext4_claim_free_clusters
      0.13            -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.12 ±  4%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__xa_set_mark
      0.12 ±  2%      -0.1        0.06        perf-profile.children.cycles-pp.file_remove_privs_flags
      0.13 ±  3%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.ext4_llseek
      0.15 ±  2%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      0.12            -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.amd_clear_divider
      0.12 ±  2%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.jbd2_journal_grab_journal_head
      0.11 ±  5%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.inode_to_bdi
      0.09 ±  5%      -0.1        0.04 ± 47%  perf-profile.children.cycles-pp.handle_softirqs
      0.50            -0.1        0.45 ±  3%  perf-profile.children.cycles-pp.folio_activate_fn
      0.11 ±  2%      -0.1        0.06        perf-profile.children.cycles-pp.__ext4_new_inode
      0.12 ±  2%      -0.1        0.07        perf-profile.children.cycles-pp.try_charge_memcg
      0.11 ±  4%      -0.1        0.06 ±  4%  perf-profile.children.cycles-pp.timestamp_truncate
      0.12 ±  3%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12 ±  3%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.drop_buffers
      0.13 ±  3%      -0.0        0.08 ±  3%  perf-profile.children.cycles-pp.__ext4_find_entry
      0.11 ±  3%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      0.12 ±  8%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.12            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.ext4_dx_find_entry
      0.13 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.sched_tick
      0.10 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.ext4_do_update_inode
      0.09            -0.0        0.05        perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.08 ±  4%      -0.0        0.04 ± 47%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      0.17            -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.09 ±  4%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.ext4_lookup
      0.09 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.task_tick_fair
      0.09 ±  3%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.ext4_add_nondir
      0.24 ±  2%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.xas_find_conflict
      0.08 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.ext4_add_entry
      0.08 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.ext4_dx_add_entry
      0.13 ±  3%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.07            -0.0        0.05 ± 31%  perf-profile.children.cycles-pp.ext4_search_dir
      0.34 ±  2%      +0.0        0.37        perf-profile.children.cycles-pp.lru_add_fn
      0.00            +0.1        0.05 ±  5%  perf-profile.children.cycles-pp.lru_add_drain
      0.08 ±  5%      +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.__cmd_record
      0.08 ±  5%      +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.cmd_record
      0.08 ±  4%      +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.09 ±  3%      +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.main
      0.09 ±  3%      +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.run_builtin
      0.08 ±  6%      +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.perf_mmap__push
      0.07 ±  4%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.record__pushfn
      0.07 ±  4%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.writen
      0.06            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.00            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.00            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.shmem_write_begin
      2.45            +0.2        2.70        perf-profile.children.cycles-pp.lru_add_drain_cpu
      4.86            +0.7        5.54        perf-profile.children.cycles-pp.__folio_batch_release
     27.93            +0.9       28.79        perf-profile.children.cycles-pp.ksys_read
     27.50            +1.1       28.56        perf-profile.children.cycles-pp.vfs_read
     25.97            +1.8       27.81        perf-profile.children.cycles-pp.filemap_read
     92.83            +3.3       96.09        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     92.42            +3.5       95.88        perf-profile.children.cycles-pp.do_syscall_64
     30.73            +3.9       34.66        perf-profile.children.cycles-pp.write
     21.08            +4.1       25.15        perf-profile.children.cycles-pp.folio_mark_accessed
     19.70            +4.6       24.33        perf-profile.children.cycles-pp.folio_activate
     27.83            +5.3       33.14        perf-profile.children.cycles-pp.ksys_write
     27.36            +5.5       32.89        perf-profile.children.cycles-pp.vfs_write
     25.87            +5.6       31.48        perf-profile.children.cycles-pp.__close
     25.86            +5.6       31.46        perf-profile.children.cycles-pp.__x64_sys_close
     25.84            +5.6       31.46        perf-profile.children.cycles-pp.__fput
     25.83            +5.6       31.45        perf-profile.children.cycles-pp.dput
     25.82            +5.6       31.44        perf-profile.children.cycles-pp.__dentry_kill
     25.79            +5.6       31.43        perf-profile.children.cycles-pp.evict
     25.78            +5.6       31.42        perf-profile.children.cycles-pp.ext4_evict_inode
     25.64            +5.7       31.34        perf-profile.children.cycles-pp.truncate_inode_pages_range
     18.31            +6.0       24.35        perf-profile.children.cycles-pp.folios_put_refs
     17.78            +6.3       24.04        perf-profile.children.cycles-pp.__page_cache_release
     25.54            +6.4       31.96        perf-profile.children.cycles-pp.ext4_buffered_write_iter
     23.87 ±  2%      +7.4       31.23        perf-profile.children.cycles-pp.generic_perform_write
     17.93 ±  3%     +10.0       27.97        perf-profile.children.cycles-pp.ext4_da_write_begin
     13.75 ±  4%     +12.0       25.77        perf-profile.children.cycles-pp.__filemap_get_folio
     11.78 ±  5%     +13.0       24.77        perf-profile.children.cycles-pp.filemap_add_folio
     10.41 ±  6%     +13.5       23.96        perf-profile.children.cycles-pp.folio_add_lru
     34.89 ±  2%     +18.9       53.82        perf-profile.children.cycles-pp.folio_batch_move_lru
     51.11           +25.1       76.23        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     51.02           +25.2       76.18        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     50.98           +25.3       76.24        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      7.25 ±  9%      -6.7        0.53 ± 14%  perf-profile.self.cycles-pp.osq_lock
      3.09            -1.4        1.65 ±  2%  perf-profile.self.cycles-pp.clear_bhb_loop
      1.79            -0.7        1.07 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      1.14            -0.5        0.61 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.20            -0.5        0.70 ±  2%  perf-profile.self.cycles-pp.memset_orig
      1.06            -0.5        0.57 ±  2%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.97            -0.5        0.51 ±  2%  perf-profile.self.cycles-pp.filemap_read
      0.94 ±  2%      -0.4        0.51 ±  3%  perf-profile.self.cycles-pp.__fdget_pos
      0.86 ±  4%      -0.4        0.45 ±  3%  perf-profile.self.cycles-pp.workingset_age_nonresident
      0.75 ±  2%      -0.4        0.38 ±  3%  perf-profile.self.cycles-pp.vfs_write
      0.89            -0.3        0.55 ±  2%  perf-profile.self.cycles-pp.__block_commit_write
      0.54 ±  3%      -0.3        0.21 ±  4%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.50 ±  3%      -0.3        0.20 ±  3%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.63            -0.3        0.33 ±  2%  perf-profile.self.cycles-pp.vfs_read
      0.57            -0.3        0.29 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.61            -0.3        0.33 ±  2%  perf-profile.self.cycles-pp.filemap_get_read_batch
      0.58 ±  2%      -0.3        0.31 ±  3%  perf-profile.self.cycles-pp.fault_in_readable
      0.37 ±  3%      -0.3        0.10 ±  4%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.56            -0.3        0.29 ±  3%  perf-profile.self.cycles-pp.xas_load
      0.38 ±  6%      -0.3        0.13 ±  4%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.48 ±  2%      -0.2        0.24 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.35 ±  5%      -0.2        0.13 ±  5%  perf-profile.self.cycles-pp.ext4_file_read_iter
      0.46 ±  2%      -0.2        0.24 ±  2%  perf-profile.self.cycles-pp.write
      0.45 ±  2%      -0.2        0.23 ±  6%  perf-profile.self.cycles-pp.disk_rr
      0.39 ±  3%      -0.2        0.18 ±  4%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.36 ±  4%      -0.2        0.15 ±  4%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.44            -0.2        0.23 ±  2%  perf-profile.self.cycles-pp.ext4_da_write_end
      0.44            -0.2        0.23 ±  2%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.42            -0.2        0.21 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.42 ±  2%      -0.2        0.22 ±  3%  perf-profile.self.cycles-pp.generic_perform_write
      0.40            -0.2        0.20 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.43 ±  2%      -0.2        0.24 ±  3%  perf-profile.self.cycles-pp.read
      0.40 ±  2%      -0.2        0.21 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.41            -0.2        0.22 ±  3%  perf-profile.self.cycles-pp.llseek
      0.33            -0.2        0.17 ±  2%  perf-profile.self.cycles-pp.ext4_block_write_begin
      0.33 ±  2%      -0.2        0.17 ±  3%  perf-profile.self.cycles-pp.__cond_resched
      0.28 ±  2%      -0.2        0.13 ±  3%  perf-profile.self.cycles-pp.atime_needs_update
      0.30 ±  2%      -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.30            -0.1        0.16 ±  4%  perf-profile.self.cycles-pp.filemap_get_entry
      0.30            -0.1        0.16 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.28            -0.1        0.14 ±  4%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.27            -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.mark_buffer_dirty
      0.26            -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.ext4_da_map_blocks
      0.25            -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.down_write
      0.25            -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
      0.27 ±  2%      -0.1        0.16 ±  2%  perf-profile.self.cycles-pp.block_invalidate_folio
      0.24 ±  2%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.up_write
      0.16 ±  4%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.ext4_nonda_switch
      0.20 ±  2%      -0.1        0.10        perf-profile.self.cycles-pp.inode_needs_update_time
      0.21 ±  2%      -0.1        0.11        perf-profile.self.cycles-pp.folio_unlock
      0.23            -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.xas_store
      0.21 ±  2%      -0.1        0.11        perf-profile.self.cycles-pp.xas_start
      0.20 ±  2%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.filemap_get_pages
      0.20 ±  2%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.security_file_permission
      0.20 ±  4%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.rcu_all_qs
      0.22            -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.folios_put_refs
      0.20 ±  2%      -0.1        0.11 ±  3%  perf-profile.self.cycles-pp.__slab_free
      0.18            -0.1        0.09 ±  3%  perf-profile.self.cycles-pp.__filemap_add_folio
      0.17 ±  2%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.ext4_buffered_write_iter
      0.18 ±  2%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.rw_verify_area
      0.17            -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.16 ±  3%      -0.1        0.08 ±  3%  perf-profile.self.cycles-pp.aa_file_perm
      0.15            -0.1        0.07 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.16 ±  2%      -0.1        0.09 ±  3%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.15 ±  3%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.current_time
      0.15 ±  3%      -0.1        0.08 ±  3%  perf-profile.self.cycles-pp.ksys_write
      0.15 ±  6%      -0.1        0.07 ±  6%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.15 ±  2%      -0.1        0.08        perf-profile.self.cycles-pp.generic_write_checks
      0.15 ±  4%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.15 ±  3%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.15 ±  3%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.ksys_read
      0.18 ±  2%      -0.1        0.11 ±  3%  perf-profile.self.cycles-pp.mod_objcg_state
      0.13            -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.13 ±  3%      -0.1        0.06 ±  4%  perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.15 ±  2%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.find_lock_entries
      0.14            -0.1        0.08 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.13 ±  5%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.12 ±  2%      -0.1        0.06        perf-profile.self.cycles-pp.node_dirty_ok
      0.12            -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.ksys_lseek
      0.09            -0.1        0.03 ± 75%  perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.12            -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.create_empty_buffers
      0.12 ±  4%      -0.1        0.06        perf-profile.self.cycles-pp.__dquot_alloc_space
      0.10 ±  3%      -0.1        0.05 ± 31%  perf-profile.self.cycles-pp.folio_account_dirtied
      0.12 ±  4%      -0.1        0.06 ±  4%  perf-profile.self.cycles-pp.jbd2_journal_grab_journal_head
      0.09            -0.1        0.04 ± 61%  perf-profile.self.cycles-pp.file_modified
      0.11 ±  4%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.ext4_llseek
      0.10 ±  4%      -0.1        0.05        perf-profile.self.cycles-pp.__count_memcg_events
      0.11 ±  4%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.10 ±  5%      -0.1        0.05        perf-profile.self.cycles-pp.block_write_end
      0.10 ±  5%      -0.1        0.05        perf-profile.self.cycles-pp.file_remove_privs_flags
      0.10            -0.1        0.05        perf-profile.self.cycles-pp.get_page_from_freelist
      0.12 ±  4%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.drop_buffers
      0.10 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.timestamp_truncate
      0.10 ±  5%      -0.0        0.05 ±  5%  perf-profile.self.cycles-pp.folio_account_cleaned
      0.10 ±  4%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.kmem_cache_free
      0.11 ±  9%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.10 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.09 ±  5%      -0.0        0.06 ±  4%  perf-profile.self.cycles-pp.try_charge_memcg
      0.10 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__page_cache_release
      0.23 ±  3%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.xas_find_conflict
      0.25 ±  2%      +0.0        0.28 ±  4%  perf-profile.self.cycles-pp.folio_activate_fn
      0.17 ±  3%      +0.1        0.26        perf-profile.self.cycles-pp.lru_add_fn
      0.51 ±  2%      +0.1        0.63 ±  3%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.30 ±  5%      +0.2        0.51 ±  2%  perf-profile.self.cycles-pp.folio_batch_move_lru
     50.97           +25.3       76.24        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


