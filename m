Return-Path: <cgroups+bounces-3022-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12AF8D1194
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 04:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91641F23234
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 02:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77655BA41;
	Tue, 28 May 2024 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mau1RjpY"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3E4683;
	Tue, 28 May 2024 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716861957; cv=fail; b=DszqZhu6iGGMob6GckuKqA58i+GYQuw/v/3DrPGHo7ILT+OfxR0ts3wP/regaUdpbndZws90hkjZ3mG+rlqRfn1gA3L6s2cbqYbAvAI/aB+D9JwXlmbywl2AvWJKKcMnxJIObrZxZYNLemfgkNVZfAstKVIpXQHraCMGAZxy/FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716861957; c=relaxed/simple;
	bh=6s4qGXpfpK0b0ioS7sXXm5dHm+ma46+QogMhiPNiHFY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=GSzL+q8rkVr97F8WQywTV5kfDURqlTikMuNuoiWBoghNzj33qCuGuwyqQ4qaaztRv0xk5107spfF2M4A7r+J3hz4sx7XCtYu29pbtzKm/3tvTlJxPJCYO/vY+io1avaLY8kuN93bPpaSy7MPaAkLqum05y8titCPXgZMz7s/tIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mau1RjpY; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716861951; x=1748397951;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=6s4qGXpfpK0b0ioS7sXXm5dHm+ma46+QogMhiPNiHFY=;
  b=Mau1RjpYU1wFHbn7pakj7wOtT+FCQ0KXUPoxV5pPbEGG0QKMy0RitXyR
   MWfIMH5Ym2L95SYq4kw9jMkmGYUJpsB/OW9/543GBVD4B1EJfNIJrppqO
   Rhd8sTTVQIxGEYHgpWosl43vu6FKfZdKOM3L27TQsaicXK6Y73uA5EkQ6
   bbxEDlXq1QfoiLO9t2jyA2d7jBDV9M3/go4w5jo5uMA8q1it7O0DPDtN4
   vxbDw8xgGpR59ckYgZPXjlrn2xWnNQspLSeEGl6eauGUs3xKeX4ltkTu8
   CDiuXspZJIrTnFtdyoWAhkjZCTl6u6j1bAz6/t+hhN6TURXsPMCTmAe22
   g==;
X-CSE-ConnectionGUID: ofk6ItgFTSKZXXfvFv6xmA==
X-CSE-MsgGUID: F83sa6RmS5+2plBBJDbOJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24603321"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="24603321"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 19:05:50 -0700
X-CSE-ConnectionGUID: 9dHLMmIGTgiVTzGEEIroHw==
X-CSE-MsgGUID: 3Hz943N4R42q3JS0I8tnaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="34803817"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 19:05:50 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 19:05:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 19:05:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 19:05:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQAoxzyeHWL4wYloJP3IPKLfLoSPUG/9u60Ft8719D4/xZRv+2ZRYjTZe/IwopUdNJKd000FiGkqVH0FYJ3Pt+CGaQM60yISMdtI9X7+Uy4lc06fmcMxRlo60Z/ZvDKhhJJiOjjfUB/NvKgSyxA01Aan6j8Nco/BLZsHk0yG54I+jVj+n87uzSVOrVf/+iW7pc/iExGR6vV/IRvV/FzlUC2tQeb1cTuGLgnr5lpPR08alvL/ZQS5xgncazf7XJ3EfA81p1FlCLg323K+uBYpfLggGxwIQETgmMtOeK2Gfa7tyU84/MI0ZqWtSD8FyoxZlS4S/8r/6hXkEY7v4uSqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgbIPHTZ2Pih/wLJzkX6ix5lsnm+CU/YoYJY0EAzjyI=;
 b=KxfpYe/y1N2mIQ1IaaPDmKUUogEJFPvKskPxuFBW+Ls4NZzQv8wcIOS3vUczAWtAjAiRA8gVevPWriM5PyKAzM8MTJD6v4YoUuWFM9+8SWAa6P0L8QSxUGqbAQhlXCZ3JikBQZCCkOQtPrIvFWqaK3Hghqsif4ACigKDKOA42AQXdmdNU8bE6FFTG+ScsBaQU7CtEjf/6YrfX9nykFDucL8YQOKKaliM0g/OyqEevpbC5AgPROrgC5V/zOF5Z+EKnfUp9Mg5qDMV36lhH1R1cYGG5QZNhIawjzC+FAL1tbi8mpcetSRcktKrbyEdkGWb+5R5VPoRyjoCveHQsbOxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB5251.namprd11.prod.outlook.com (2603:10b6:610:e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 02:05:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 02:05:44 +0000
Date: Tue, 28 May 2024 10:05:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed
	<yosryahmed@google.com>, "T.J. Mercier" <tjmercier@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [memcg]  70a64b7919:  stress-ng.shm.ops_per_sec -8.5%
 regression
Message-ID: <202405280931.d7606afc-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU1PR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:802:18::24) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 615cbf18-503a-4741-9cab-08dc7ebaae4f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?LWgIPqQb1Iq3/lK794FY3twmGX5BOmXgOnME8VjATm9PjLhqUy2JzHnMsY?=
 =?iso-8859-1?Q?mehVACzE/NypZlOCXjauVuePNWA66AgLpyfaQI8cLRIPexXJCil3WRR+Pq?=
 =?iso-8859-1?Q?GOXqfQ2M4Ffg1i4LLoYV29QadgqNNK23vSXyJrTNrRaG67by8pmrQjdZy4?=
 =?iso-8859-1?Q?05E+rMxFUHyruhXAsmmMZuk87uP3AyB3Yt3hwYdovc8KlUIakVELgsEmT7?=
 =?iso-8859-1?Q?cceGV9LygebJFi277L2fZrWL3vwRgnpfH0seWYjNIDJFEeLpSYtuc4Etye?=
 =?iso-8859-1?Q?ZcofHIt3M00rNwj3OAbOJ1NjB2c349+O2InovzEbfnlcfY/VV4Z+gY5sZ9?=
 =?iso-8859-1?Q?foxHDoRjyS9x1hm//qYeePjRuDdjTDZGk/+GqMrgH+OVr17G/242LCY+oW?=
 =?iso-8859-1?Q?/dxQDH/dTk3CMQVv95SRiS6C/oAz1GhUT/nc9HKbaQKuCR8WjVnAmPtEGG?=
 =?iso-8859-1?Q?bb5qgn6WZuFwJ7DzaHlWfjEwEgBMx4DZMbSIb4EtREoPDKESzNB8oanI8B?=
 =?iso-8859-1?Q?NwmrX5DGoFGcMadacKXPOsyoIsWbkljthttFXuWbXTxg2NQMc5QjIPSoTx?=
 =?iso-8859-1?Q?P+6AeY4nSApPdmNIQPPcbZJWggZDY0xszRPDACoMk9NIAk3EZhErrdvmo5?=
 =?iso-8859-1?Q?h7XnLuNC8FLz49Azf24HPw72PQbkwuXeCPCSZ5uhK//9z8p5DeWasVh6FN?=
 =?iso-8859-1?Q?+KkDiM2kAmDJ+LH+cU4CI56RCH3Ui50jmHy3Ewrd091B5Qgj+klBNCdP8H?=
 =?iso-8859-1?Q?u81Q5gu6lYOx/sZ2mH2aLWG/xry5goGw5nnaiKARdZl6YNbt7GPXAl3Y6Z?=
 =?iso-8859-1?Q?9Kttb6jr8frElAYBOdnCorKKAZZQ/4XfPv+qex4RauNved/fz+PIqHof3Q?=
 =?iso-8859-1?Q?gY1wVoeNU6tOs9qwJgv7ANBquu232w81HUYvYsZ0ISCupTRFE8Dg4DpniD?=
 =?iso-8859-1?Q?+iqhj71VuN3OBWfMA/FglWEpGLTpI9dKTHoAGH6bKfmblN6R3VS0MCLySs?=
 =?iso-8859-1?Q?12NoorxpzR0PIVZLr9qArvtS8texaSzlLfjw0iExeVE5pFNj+lHCPGSIbb?=
 =?iso-8859-1?Q?Cib+dWiZoZRSA6cnAw+/BOjTlHFw0FgdezLAF05UZgG4Pt1QKNmtHhgklY?=
 =?iso-8859-1?Q?ubrkp9juHzLFDK4Ep0W59ww/HZeRTzMNC5UI9JZZvUvj74lolYKeIDlvH5?=
 =?iso-8859-1?Q?/uXXGFOucp1lm7rJb0JmZ2FgX1t1s5ysDDfs7b9VO4FqARF4AHq5iMlZ18?=
 =?iso-8859-1?Q?a0JG8Soyb8ydvI1+Coe7Y10YzQ93MSiJ1p3FYo6iw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kym4hIpOcs7CtR+IzxmQ9pnRYkV3x9kObEvUUPi7Zi1VSSYN0KGwQziJIK?=
 =?iso-8859-1?Q?RqDE1YnloMnhlGt6NFAx3w8DW8F9u/nPqrtMugFntLUdomHdM/JT6u7nI7?=
 =?iso-8859-1?Q?nZzvFqVOWvXaFLmSEYtMU8RzqwRlGRfBqftjxuxy6F5VhqepS6wfE5A0xV?=
 =?iso-8859-1?Q?Pbvj6mtOZ+LRJY+vsYVsfgY3HNEnmY+VYiyiprkvb1Kp9ReLU7PNBynQjw?=
 =?iso-8859-1?Q?Com2PujrQTzmpBaFaGIfbuzIcC2sUeoigJpfmZg8kUCfv/6s3sqEksTFx7?=
 =?iso-8859-1?Q?jGDvMOJsaM7StTTpm3koTdLXbPyZ+HdUdL84XFd5S1rPEnQcIGShsElZ0L?=
 =?iso-8859-1?Q?Ya3gZ0R5/sMJLzS64E4A0b5q9rXcCoqCqh1lh0ywe1yXIGCpU+Cr1eWRAV?=
 =?iso-8859-1?Q?VenZmBitlOtlh5Azwf/4HdQgOv4V3JK+0atjw/uFMXONffMt7VhguR0poF?=
 =?iso-8859-1?Q?DamwKdloP7Ve9f4gSdmS8fSkDdf0uQxhy9j/GsZxzBogVhmzuK44UlzIW0?=
 =?iso-8859-1?Q?v5RAcF6pvK6Y8lno8oyE8skgjW/EKBq36riYLQfnfIUu4E5v6MRBQCjJwX?=
 =?iso-8859-1?Q?O24DLKy/XEQ/VG/Ui+3rs/kh9H9B0U/3yssJIrHv8DKxFie88FF9PixZse?=
 =?iso-8859-1?Q?t4WREfE8fjJSlj36AcYCR8nR4V/prK2YQpcPrbyMLyEgn2VKVNz6/OH/Yd?=
 =?iso-8859-1?Q?MXVUNFPtPIICw028ImKq0JsF9r3F46BEP04PQ3ijcVU/uxUBB8oOHKjpic?=
 =?iso-8859-1?Q?TVIJ5D8EF9nbheaRvdafHKviruJD2H1VJ9VdcKCLHCB4yTAUITK88tDI/5?=
 =?iso-8859-1?Q?+HD7VjEOZ/HfLCwi6zA5DufPr6IW3zgbLBEdTG7jpomfPIvTzye27DFurJ?=
 =?iso-8859-1?Q?YV3Xpi6+WUzwFbB8CHt2h7OsJ74EhqE9ngsicMl00GRMoSlgDU6ERWznPJ?=
 =?iso-8859-1?Q?MxAAd6ANP/ecQN7q+WY5ejjayMNMTXNEKN/uOVoYpn6/nwDNhaJG7x3l5t?=
 =?iso-8859-1?Q?1RBHu+0/QFbAbakRZFm+1VjXMGzcXGbG+tCm6XuiiD/ygOo66CdJW7x5T6?=
 =?iso-8859-1?Q?g0qGUtUNEAYzrgV6krV+u4snbitVMh5so4r9Wa3NSfHYEwNCzg2SClB/NT?=
 =?iso-8859-1?Q?uu/ycY+4tuRwDwLFUjyleVChWNwcVYiYhnA9lpIqzgfgzDadETHtW811fJ?=
 =?iso-8859-1?Q?+iNggV+P62T24kiFzF6ShPTs0vw6ZY8DfzVKFtF8oujsnwS430SIPqVFzz?=
 =?iso-8859-1?Q?aBzJxfXJaeg9mQLIIGMmgToZmclWLAt/rt6wZcaEahZTYhkYuLnLZfcVfN?=
 =?iso-8859-1?Q?jv/FnfEG+KT+jrYg8sx1Zf5pTUpePhTGWCKYJ+Pt32l+ROc+giU5Abv16Z?=
 =?iso-8859-1?Q?XfTWOB4Llx7MTC1EQmZ/VORy5IZ+YUxhUoIE4vVjkT1FFfatJep0eXLzS+?=
 =?iso-8859-1?Q?cKX00zjJxrLQ3bUXy3lgvs+TIjiiYK9zINP50Ol0oRcfmlYe/pDCV0lYmN?=
 =?iso-8859-1?Q?L/v54vTbZ86U46enw1/u3eutNWCO6RjZlGZLsj+mPN051MmPk90cYBqAqr?=
 =?iso-8859-1?Q?CzcOAHMZD9LVdcMqoMoPs7Xoo7FsDsJ7lo4vYkt2z54wJs2w9ZH/WqO73Z?=
 =?iso-8859-1?Q?fZcIq6G5NY5UDmYVIV5a5oJSN07rnztZFPqYABRB6psn36xgUPh+0lUw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 615cbf18-503a-4741-9cab-08dc7ebaae4f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 02:05:43.9703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIm7qydVlKxgh7EJRNAgdy03nLZHcdWDL92tX9k4QBLldTRYMAK/ka/jsVpoR8N/K8/XcSiEORRaHj2JGBrj6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5251
X-OriginatorOrg: intel.com


hi, Shakeel,

besided what we reported will-it-scale regression in
https://lore.kernel.org/all/202405171353.b56b845-oliver.sang@intel.com/

after this commit is merged into mainline, we noticed stress-ng regression.
so report again FYI. (still including will-it-scale results)



Hello,

kernel test robot noticed a -8.5% regression of stress-ng.shm.ops_per_sec on:


commit: 70a64b7919cbd6c12306051ff2825839a9d65605 ("memcg: dynamically allocate lruvec_stats")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: shm
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.bigheap.ops_per_sec -11.3% regression                                |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_threads=100%                                                                           |
|                  | test=bigheap                                                                              |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops -12.2% regression                            |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                          |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | mode=process                                                                              |
|                  | nr_task=100%                                                                              |
|                  | test=page_fault2                                                                          |
+------------------+-------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405280931.d7606afc-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240528/202405280931.d7606afc-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/shm/stress-ng/60s

commit: 
  59142d87ab ("memcg: reduce memory size of mem_cgroup_events_index")
  70a64b7919 ("memcg: dynamically allocate lruvec_stats")

59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    290976 ±  3%     -38.0%     180490 ±  7%  cpuidle..usage
     93366            -4.3%      89376        vmstat.system.cs
      3.01 ± 24%      -0.4        2.58 ± 27%  mpstat.cpu.all.idle%
      0.48 ±  2%      -0.1        0.38 ±  2%  mpstat.cpu.all.irq%
      0.52            -0.1        0.44 ±  2%  mpstat.cpu.all.soft%
    127332 ± 31%     +40.4%     178800 ±  9%  numa-meminfo.node1.Active
    127326 ± 31%     +40.4%     178794 ±  9%  numa-meminfo.node1.Active(anon)
    279592 ± 16%     -22.4%     217063 ± 11%  numa-meminfo.node1.Mapped
    196447 ± 24%     +36.6%     268401 ±  3%  meminfo.Active
    196433 ± 24%     +36.6%     268387 ±  3%  meminfo.Active(anon)
    472994 ± 11%     -23.1%     363663 ±  3%  meminfo.Mapped
   9883270           +17.2%   11586120 ±  2%  meminfo.Memused
  10574212 ±  2%     +16.1%   12279086 ±  2%  meminfo.max_used_kB
     27640 ± 20%     -31.3%      19002 ± 38%  sched_debug.cfs_rq:/.load.avg
     19.33 ±136%    +747.4%     163.83 ± 42%  sched_debug.cfs_rq:/.util_avg.min
    372.93 ±  2%     +19.5%     445.50 ±  5%  sched_debug.cfs_rq:/.util_est.avg
    534759 ±  3%     +12.2%     600066        sched_debug.cpu.avg_idle.avg
    188443 ±  5%     +22.0%     229955 ±  4%  sched_debug.cpu.avg_idle.stddev
    144250 ± 11%     -30.0%     101019 ± 15%  sched_debug.cpu.curr->pid.avg
    220371 ±  3%     -16.3%     184362 ±  5%  sched_debug.cpu.curr->pid.stddev
     36627 ±  4%     -11.1%      32573 ±  2%  sched_debug.cpu.nr_switches.min
    983984            -8.5%     900386        stress-ng.shm.ops
     16396            -8.5%      15003        stress-ng.shm.ops_per_sec
   1536757           +15.4%    1773289        stress-ng.time.involuntary_context_switches
  2.74e+08            -8.5%  2.506e+08        stress-ng.time.minor_page_faults
      4427            +8.0%       4781        stress-ng.time.percent_of_cpu_this_job_got
      2598            +8.4%       2817        stress-ng.time.system_time
     62.33           -10.4%      55.84        stress-ng.time.user_time
   2634052           -11.3%    2335241        stress-ng.time.voluntary_context_switches
     48684 ± 22%     +37.9%      67159 ±  3%  proc-vmstat.nr_active_anon
    442588            -1.9%     434297        proc-vmstat.nr_anon_pages
   1217100            -1.4%    1199925        proc-vmstat.nr_file_pages
    839615            -5.2%     795974        proc-vmstat.nr_inactive_anon
    118891 ± 11%     -24.0%      90355 ±  3%  proc-vmstat.nr_mapped
    446886            -3.8%     429735        proc-vmstat.nr_shmem
     45874            -1.8%      45039        proc-vmstat.nr_slab_unreclaimable
     48684 ± 22%     +37.9%      67159 ±  3%  proc-vmstat.nr_zone_active_anon
    839617            -5.2%     795977        proc-vmstat.nr_zone_inactive_anon
 8.167e+08            -8.5%  7.477e+08        proc-vmstat.numa_hit
 8.171e+08            -8.5%  7.477e+08        proc-vmstat.numa_local
 8.076e+08            -8.5%  7.393e+08        proc-vmstat.pgalloc_normal
 3.091e+08            -8.6%  2.826e+08        proc-vmstat.pgfault
 8.073e+08            -8.5%   7.39e+08        proc-vmstat.pgfree
      4.80           -16.5%       4.01        perf-stat.i.MPKI
 2.328e+10            -6.3%  2.182e+10        perf-stat.i.branch-instructions
  96670548            -7.9%   89077364        perf-stat.i.branch-misses
     36.03            -5.3       30.75        perf-stat.i.cache-miss-rate%
 5.708e+08           -22.5%  4.425e+08        perf-stat.i.cache-misses
 1.581e+09            -9.0%  1.438e+09        perf-stat.i.cache-references
     98504            -6.0%      92575        perf-stat.i.context-switches
      1.89            +7.3%       2.02        perf-stat.i.cpi
     29312           -37.2%      18409 ±  6%  perf-stat.i.cpu-migrations
    394.14           +28.5%     506.46 ±  2%  perf-stat.i.cycles-between-cache-misses
  1.18e+11            -7.1%  1.097e+11        perf-stat.i.instructions
      0.54            -6.7%       0.50        perf-stat.i.ipc
    142.85            -8.6%     130.53        perf-stat.i.metric.K/sec
   4576909            -9.4%    4144779        perf-stat.i.minor-faults
   4576909            -9.4%    4144779        perf-stat.i.page-faults
      4.85           -16.7%       4.05        perf-stat.overall.MPKI
      0.40            -0.0        0.38        perf-stat.overall.branch-miss-rate%
     36.09            -5.4       30.70        perf-stat.overall.cache-miss-rate%
      1.90            +7.3%       2.04        perf-stat.overall.cpi
    391.94           +28.7%     504.55 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.53            -6.8%       0.49        perf-stat.overall.ipc
  2.25e+10            -4.9%   2.14e+10        perf-stat.ps.branch-instructions
  89317517            -7.9%   82263320        perf-stat.ps.branch-misses
 5.537e+08           -21.4%  4.352e+08 ±  2%  perf-stat.ps.cache-misses
 1.534e+09            -7.6%  1.418e+09        perf-stat.ps.cache-references
     94911            -4.3%      90839        perf-stat.ps.context-switches
     28713           -36.5%      18224 ±  6%  perf-stat.ps.cpu-migrations
 1.141e+11            -5.7%  1.076e+11        perf-stat.ps.instructions
   4440766            -8.0%    4085492        perf-stat.ps.minor-faults
   4440766            -8.0%    4085493        perf-stat.ps.page-faults
 7.027e+12            -6.0%  6.602e+12        perf-stat.total.instructions
     21.75            -5.7       16.07 ±  3%  perf-profile.calltrace.cycles-pp._Fork
     21.36            -5.6       15.73 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     21.36            -5.6       15.73 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
     21.34            -5.6       15.72 ±  3%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     21.34            -5.6       15.72 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     21.09            -5.6       15.51 ±  3%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.44            -5.5       14.99 ±  3%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     20.12            -5.4       14.73 ±  3%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
     24.90            -5.1       19.77 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.90            -5.1       19.77 ±  2%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.90            -5.1       19.77 ±  2%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.91            -5.1       19.78 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.91            -5.1       19.78 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     24.35            -5.0       19.36 ±  2%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     24.34            -5.0       19.35 ±  2%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
     24.29            -5.0       19.31 ±  2%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     13.37            -4.2        9.15 ±  4%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
     13.01            -4.1        8.89 ±  4%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
     12.90            -4.1        8.78 ±  4%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
     12.50            -4.1        8.39 ±  4%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     12.78            -4.1        8.67 ±  4%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
     11.55            -3.7        7.81 ±  3%  perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
     11.48            -3.7        7.75 ±  3%  perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mmap.dup_mm.copy_process
     11.13            -3.7        7.47 ±  4%  perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      9.52            -3.4        6.14 ±  4%  perf-profile.calltrace.cycles-pp.copy_present_ptes.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      3.65 ±  2%      -2.9        0.74 ± 80%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages_noprof
      6.09 ±  3%      -2.7        3.34 ± 10%  perf-profile.calltrace.cycles-pp._compound_head.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      3.74 ±  2%      -2.7        1.05 ± 37%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof
      6.60            -1.9        4.66 ±  3%  perf-profile.calltrace.cycles-pp.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      4.44 ±  3%      -1.9        2.56 ±  6%  perf-profile.calltrace.cycles-pp._compound_head.copy_present_ptes.copy_pte_range.copy_p4d_range.copy_page_range
      2.96            -1.8        1.16 ± 19%  perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      4.38            -1.6        2.75 ±  4%  perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      4.28            -1.6        2.66 ±  5%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
      4.21            -1.6        2.59 ±  5%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page
      4.08            -1.6        2.48 ±  5%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio
      2.35 ±  2%      -1.3        1.03 ± 10%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      2.27 ±  2%      -1.3        0.96 ± 10%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      2.14 ±  2%      -1.3        0.85 ± 12%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio
      1.97 ±  2%      -1.3        0.69 ± 14%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof
      2.01 ±  2%      -1.3        0.74 ± 13%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.shmem_alloc_folio
      3.40            -1.2        2.21 ±  4%  perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      5.12            -0.9        4.19 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
      4.58            -0.9        3.71 ±  2%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      3.81            -0.7        3.15 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      3.45            -0.6        2.84 ±  2%  perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
      0.99 ±  4%      -0.5        0.54 ± 45%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      0.71 ±  4%      -0.4        0.35 ± 70%  perf-profile.calltrace.cycles-pp.pte_alloc_one.__pte_alloc.copy_pte_range.copy_p4d_range.copy_page_range
      0.57            -0.3        0.25 ±100%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      1.46            -0.3        1.17 ±  2%  perf-profile.calltrace.cycles-pp.vm_area_dup.dup_mmap.dup_mm.copy_process.kernel_clone
      1.90            -0.3        1.62 ±  2%  perf-profile.calltrace.cycles-pp.clear_page_erms.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof
      1.90            -0.3        1.62 ±  2%  perf-profile.calltrace.cycles-pp.clear_page_erms.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      2.16            -0.3        1.88 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      1.72            -0.2        1.48 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      1.29            -0.2        1.06 ±  2%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.28            -0.2        1.06 ±  2%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.28            -0.2        1.06 ±  2%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      1.27            -0.2        1.05 ±  2%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      0.88            -0.2        0.67 ±  3%  perf-profile.calltrace.cycles-pp.find_lock_entries.shmem_undo_range.shmem_evict_inode.evict.do_unlinkat
      1.79            -0.2        1.59 ±  2%  perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.73 ±  4%      -0.2        0.53 ±  4%  perf-profile.calltrace.cycles-pp.__pte_alloc.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      1.04            -0.2        0.86 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm.copy_process
      1.06 ±  5%      -0.2        0.88 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.96            -0.2        0.78 ±  2%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.98 ±  5%      -0.2        0.81 ±  2%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      1.29            -0.2        1.12 ±  2%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
      0.97 ±  5%      -0.2        0.81 ±  2%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.16            -0.2        1.00 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      1.06            -0.1        0.93        perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page
      1.20            -0.1        1.08        perf-profile.calltrace.cycles-pp.truncate_inode_folio.shmem_undo_range.shmem_evict_inode.evict.do_unlinkat
      0.65            -0.1        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
      1.17            -0.1        1.06 ±  2%  perf-profile.calltrace.cycles-pp.truncate_inode_folio.shmem_undo_range.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      0.78 ±  5%      -0.1        0.67 ±  3%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.72            -0.1        0.61 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap
      0.97            -0.1        0.88 ±  2%  perf-profile.calltrace.cycles-pp.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_evict_inode.evict
      0.82            -0.1        0.73 ±  2%  perf-profile.calltrace.cycles-pp.cgroup_rstat_updated.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.alloc_anon_folio
      0.65 ±  5%      -0.1        0.56 ±  3%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.64 ±  5%      -0.1        0.56 ±  3%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.94            -0.1        0.86 ±  2%  perf-profile.calltrace.cycles-pp.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_fallocate.vfs_fallocate
      0.79            -0.1        0.72 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_evict_inode
      0.67            -0.1        0.61 ±  2%  perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.stress_run
      0.75            -0.1        0.69 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_fallocate
      0.81            +0.0        0.85        perf-profile.calltrace.cycles-pp.__get_user_pages.faultin_page_range.do_madvise.__x64_sys_madvise.do_syscall_64
      0.68            +0.1        0.74        perf-profile.calltrace.cycles-pp.handle_mm_fault.__get_user_pages.faultin_page_range.do_madvise.__x64_sys_madvise
      0.66            +0.1        0.72        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__get_user_pages.faultin_page_range.do_madvise
      0.62            +0.1        0.68        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.__get_user_pages.faultin_page_range
      0.84            +0.1        0.92        perf-profile.calltrace.cycles-pp.faultin_page_range.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.57            +0.1       11.69        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_run
     11.52            +0.1       11.64        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_run
      1.00            +0.1        1.13        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise.stress_run
      1.00            +0.1        1.12        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      1.00            +0.1        1.13        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise.stress_run
      1.00            +0.1        1.13        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise.stress_run
      1.01            +0.1        1.14        perf-profile.calltrace.cycles-pp.__madvise.stress_run
     10.85            +0.2       11.05        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_run
      4.58            +0.3        4.86        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      4.55            +0.3        4.83        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      4.46            +0.3        4.75        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      9.28            +0.3        9.58        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +0.6        0.57 ±  6%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.unmap_region.do_vmi_align_munmap
      0.00            +0.6        0.57 ±  6%  perf-profile.calltrace.cycles-pp.lru_add_drain.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00            +0.6        0.57 ±  6%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      0.34 ± 70%      +0.8        1.15 ±  6%  perf-profile.calltrace.cycles-pp.ftruncate64.stress_run
      0.25 ±100%      +0.9        1.14 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64.stress_run
      0.25 ±100%      +0.9        1.14 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ftruncate64.stress_run
      2.56 ±  2%      +1.0        3.56 ±  3%  perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap
      0.08 ±223%      +1.0        1.13 ±  6%  perf-profile.calltrace.cycles-pp.do_truncate.do_ftruncate.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.08 ±223%      +1.1        1.14 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64.stress_run
      0.08 ±223%      +1.1        1.14 ±  6%  perf-profile.calltrace.cycles-pp.do_ftruncate.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
      0.00            +1.1        1.11 ±  6%  perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_setattr.notify_change.do_truncate.do_ftruncate
      0.00            +1.1        1.12 ±  6%  perf-profile.calltrace.cycles-pp.shmem_setattr.notify_change.do_truncate.do_ftruncate.__x64_sys_ftruncate
      0.00            +1.1        1.13 ±  6%  perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_ftruncate.__x64_sys_ftruncate.do_syscall_64
      1.24 ±  2%      +2.3        3.50 ±  7%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.do_anonymous_page.__handle_mm_fault
      1.24 ±  2%      +2.3        3.50 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.do_anonymous_page
      1.22 ±  2%      +2.3        3.48 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma
      1.74 ±  2%      +2.3        4.05 ±  6%  perf-profile.calltrace.cycles-pp.folio_add_lru_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.69 ±  2%      +2.3        4.00 ±  6%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      5.48            +2.4        7.84 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink.stress_run
      5.48            +2.4        7.84 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink.stress_run
      5.47            +2.4        7.83 ±  2%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      5.48            +2.4        7.84 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink.stress_run
      5.48            +2.4        7.84 ±  2%  perf-profile.calltrace.cycles-pp.unlink.stress_run
      5.30            +2.4        7.68 ±  3%  perf-profile.calltrace.cycles-pp.evict.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.27            +2.4        7.64 ±  3%  perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_evict_inode.evict.do_unlinkat.__x64_sys_unlink
      5.29            +2.4        7.67 ±  3%  perf-profile.calltrace.cycles-pp.shmem_evict_inode.evict.do_unlinkat.__x64_sys_unlink.do_syscall_64
      5.00            +2.4        7.43 ±  3%  perf-profile.calltrace.cycles-pp.syscall
      4.99            +2.4        7.43 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      4.99            +2.4        7.43 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      4.99            +2.4        7.43 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      4.99            +2.4        7.43 ±  3%  perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      3.08 ±  2%      +2.7        5.81 ±  4%  perf-profile.calltrace.cycles-pp.folios_put_refs.shmem_undo_range.shmem_evict_inode.evict.do_unlinkat
     16.79            +2.9       19.69        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      3.58 ±  2%      +2.9        6.52 ±  4%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      3.59 ±  2%      +2.9        6.53 ±  4%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      3.57 ±  2%      +2.9        6.51 ±  4%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      3.53 ±  2%      +2.9        6.47 ±  4%  perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region
      1.83 ±  3%      +3.0        4.80 ±  6%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.shmem_undo_range.shmem_evict_inode
      2.08 ±  3%      +3.0        5.06 ±  6%  perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.shmem_undo_range.shmem_evict_inode.evict
      1.77 ±  2%      +3.0        4.81 ±  6%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.shmem_undo_range.shmem_fallocate
      5.40            +3.0        8.44 ±  3%  perf-profile.calltrace.cycles-pp.__munmap.stress_run
      5.31            +3.0        8.36 ±  3%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      5.31            +3.0        8.36 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap.stress_run
      5.31            +3.1        8.36 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap.stress_run
      5.30            +3.1        8.35 ±  3%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      5.31            +3.1        8.36 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap.stress_run
      2.00 ±  2%      +3.1        5.06 ±  6%  perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.shmem_undo_range.shmem_fallocate.vfs_fallocate
      5.30            +3.1        8.36 ±  3%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.13            +3.1        8.20 ±  3%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      2.43            +3.1        5.52 ±  6%  perf-profile.calltrace.cycles-pp.folios_put_refs.shmem_undo_range.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      4.16            +3.2        7.38 ±  4%  perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     16.84            +3.6       20.43        perf-profile.calltrace.cycles-pp.fallocate64
     16.76            +3.6       20.36        perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     16.77            +3.6       20.36        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     16.77            +3.6       20.36        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fallocate64
     16.76            +3.6       20.35        perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     11.47            +3.6       15.10 ±  2%  perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      3.03 ±  3%      +4.6        7.65 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
      3.04 ±  3%      +4.6        7.66 ±  6%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      3.33 ±  3%      +4.6        7.97 ±  5%  perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      3.02 ±  2%      +5.4        8.41 ±  6%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      3.00 ±  2%      +5.4        8.40 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      2.96 ±  2%      +5.4        8.37 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
      4.14 ±  2%      +5.5        9.66 ±  6%  perf-profile.calltrace.cycles-pp.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      4.01 ±  2%      +5.5        9.54 ±  6%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
     27.80            +5.9       33.66        perf-profile.calltrace.cycles-pp.stress_run
     21.69            +6.0       27.72 ±  2%  perf-profile.calltrace.cycles-pp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.59 ±  3%      +6.3        9.86 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.shmem_undo_range
      6.52 ±  3%     +10.9       17.44 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     21.78            -5.7       16.09 ±  3%  perf-profile.children.cycles-pp._Fork
     21.34            -5.6       15.72 ±  3%  perf-profile.children.cycles-pp.kernel_clone
     21.34            -5.6       15.72 ±  3%  perf-profile.children.cycles-pp.__do_sys_clone
     21.09            -5.6       15.51 ±  3%  perf-profile.children.cycles-pp.copy_process
     20.44            -5.5       14.99 ±  3%  perf-profile.children.cycles-pp.dup_mm
     20.14            -5.4       14.76 ±  3%  perf-profile.children.cycles-pp.dup_mmap
     25.17            -5.2       19.99 ±  2%  perf-profile.children.cycles-pp.do_group_exit
     25.17            -5.2       19.99 ±  2%  perf-profile.children.cycles-pp.__x64_sys_exit_group
     25.17            -5.2       19.99 ±  2%  perf-profile.children.cycles-pp.do_exit
     24.36            -5.0       19.37 ±  2%  perf-profile.children.cycles-pp.exit_mm
     24.34            -5.0       19.35 ±  2%  perf-profile.children.cycles-pp.__mmput
     24.30            -5.0       19.32 ±  2%  perf-profile.children.cycles-pp.exit_mmap
     10.66 ±  3%      -4.5        6.18 ±  6%  perf-profile.children.cycles-pp._compound_head
     14.66            -4.4       10.22 ±  4%  perf-profile.children.cycles-pp.unmap_vmas
     14.30            -4.3        9.95 ±  4%  perf-profile.children.cycles-pp.unmap_page_range
     14.19            -4.3        9.85 ±  4%  perf-profile.children.cycles-pp.zap_pmd_range
     14.11            -4.3        9.78 ±  4%  perf-profile.children.cycles-pp.zap_pte_range
     12.80            -4.1        8.66 ±  4%  perf-profile.children.cycles-pp.zap_present_ptes
     11.55            -3.7        7.82 ±  4%  perf-profile.children.cycles-pp.copy_page_range
     11.49            -3.7        7.76 ±  3%  perf-profile.children.cycles-pp.copy_p4d_range
     11.18            -3.7        7.52 ±  4%  perf-profile.children.cycles-pp.copy_pte_range
      8.89            -3.6        5.34 ±  5%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      8.67            -3.6        5.12 ±  5%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      7.92            -3.5        4.46 ±  6%  perf-profile.children.cycles-pp.get_page_from_freelist
      9.72            -3.4        6.33 ±  4%  perf-profile.children.cycles-pp.copy_present_ptes
      4.90 ±  2%      -3.0        1.92 ± 12%  perf-profile.children.cycles-pp.rmqueue
      4.48 ±  2%      -2.9        1.55 ± 15%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      4.34 ±  2%      -2.9        1.42 ± 16%  perf-profile.children.cycles-pp.rmqueue_bulk
      7.12            -2.0        5.08 ±  3%  perf-profile.children.cycles-pp.alloc_anon_folio
      5.04            -1.9        3.18 ±  4%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      2.99            -1.4        1.59 ±  6%  perf-profile.children.cycles-pp.shmem_alloc_folio
      3.90            -1.3        2.61 ±  4%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      5.13            -0.9        4.20 ±  2%  perf-profile.children.cycles-pp.anon_vma_fork
      4.62            -0.9        3.74 ±  2%  perf-profile.children.cycles-pp.free_pgtables
      1.76            -0.7        1.04 ±  7%  perf-profile.children.cycles-pp.free_unref_folios
      1.61            -0.7        0.89 ±  8%  perf-profile.children.cycles-pp.free_unref_page_commit
      1.40            -0.7        0.72 ± 10%  perf-profile.children.cycles-pp.free_pcppages_bulk
      4.45            -0.7        3.79 ±  2%  perf-profile.children.cycles-pp.clear_page_erms
      3.84            -0.7        3.18 ±  2%  perf-profile.children.cycles-pp.anon_vma_clone
      1.47 ±  4%      -0.6        0.83 ± 23%  perf-profile.children.cycles-pp.perf_session__process_events
      1.44 ±  4%      -0.6        0.82 ± 24%  perf-profile.children.cycles-pp.reader__read_event
      3.49            -0.6        2.87 ±  2%  perf-profile.children.cycles-pp.unlink_anon_vmas
      2.63            -0.6        2.02 ±  4%  perf-profile.children.cycles-pp.down_write
      2.96            -0.5        2.48 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      3.84            -0.5        3.37        perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.01 ±  4%      -0.4        0.58 ± 28%  perf-profile.children.cycles-pp.process_simple
      1.00 ±  5%      -0.4        0.57 ± 28%  perf-profile.children.cycles-pp.ordered_events__queue
      0.99 ±  4%      -0.4        0.57 ± 28%  perf-profile.children.cycles-pp.queue_event
      2.31            -0.4        1.92 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.88            -0.3        0.54 ±  8%  perf-profile.children.cycles-pp.__free_one_page
      1.32            -0.3        0.98 ±  6%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.26            -0.3        0.93 ±  6%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      1.49            -0.3        1.19 ±  2%  perf-profile.children.cycles-pp.vm_area_dup
      1.54            -0.3        1.26 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      1.59            -0.3        1.32 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
     14.40            -0.3       14.14        perf-profile.children.cycles-pp.asm_exc_page_fault
      1.18            -0.3        0.93 ±  2%  perf-profile.children.cycles-pp.find_lock_entries
      1.74            -0.2        1.50 ±  2%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      2.40            -0.2        2.16 ±  2%  perf-profile.children.cycles-pp.truncate_inode_folio
      1.85            -0.2        1.64 ±  2%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.83            -0.2        0.62 ±  3%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.66            -0.2        0.46 ±  4%  perf-profile.children.cycles-pp.__schedule
      0.79 ±  3%      -0.2        0.58 ±  4%  perf-profile.children.cycles-pp.pte_alloc_one
      2.38            -0.2        2.17 ±  3%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.75 ±  4%      -0.2        0.55 ±  3%  perf-profile.children.cycles-pp.__pte_alloc
      0.41 ± 12%      -0.2        0.22 ± 13%  perf-profile.children.cycles-pp.__ordered_events__flush
      2.14            -0.2        1.96        perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.40 ± 11%      -0.2        0.22 ± 13%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.86 ±  2%      -0.2        0.68 ±  2%  perf-profile.children.cycles-pp.up_write
      1.94            -0.2        1.76 ±  2%  perf-profile.children.cycles-pp.filemap_remove_folio
      1.47            -0.2        1.29        perf-profile.children.cycles-pp.__count_memcg_events
      0.38 ± 11%      -0.2        0.20 ± 13%  perf-profile.children.cycles-pp.perf_session__deliver_event
      1.42            -0.2        1.25 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.96            -0.2        0.79 ±  2%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.53            -0.2        0.36 ±  4%  perf-profile.children.cycles-pp.schedule
      0.93            -0.2        0.76 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.91            -0.2        0.74 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.90 ±  2%      -0.2        0.74 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     13.40            -0.2       13.23        perf-profile.children.cycles-pp.exc_page_fault
      1.12            -0.2        0.96 ±  3%  perf-profile.children.cycles-pp.mod_objcg_state
     13.34            -0.2       13.18        perf-profile.children.cycles-pp.do_user_addr_fault
      1.35            -0.2        1.20 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.89 ±  3%      -0.2        0.74 ±  4%  perf-profile.children.cycles-pp.try_charge_memcg
      1.58            -0.1        1.44 ±  2%  perf-profile.children.cycles-pp.__filemap_remove_folio
      0.87            -0.1        0.74 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.34            -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.30            -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.newidle_balance
      0.40            -0.1        0.27 ±  4%  perf-profile.children.cycles-pp.wait4
      0.90            -0.1        0.78        perf-profile.children.cycles-pp.__slab_free
      0.28            -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.load_balance
      0.98            -0.1        0.86        perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      0.66 ±  2%      -0.1        0.54 ±  5%  perf-profile.children.cycles-pp.__do_softirq
      0.65            -0.1        0.53 ±  3%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.99 ±  2%      -0.1        0.88 ±  3%  perf-profile.children.cycles-pp.do_fault
      0.99 ±  2%      -0.1        0.88 ±  3%  perf-profile.children.cycles-pp.do_read_fault
      0.34            -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.34 ±  2%      -0.1        0.23 ±  5%  perf-profile.children.cycles-pp.kernel_wait4
      0.32            -0.1        0.22 ±  5%  perf-profile.children.cycles-pp.do_wait
      0.55            -0.1        0.45        perf-profile.children.cycles-pp.__vm_area_free
      0.92 ±  2%      -0.1        0.82 ±  3%  perf-profile.children.cycles-pp.filemap_map_pages
      0.54            -0.1        0.44 ±  3%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.34 ±  3%      -0.1        0.25 ± 17%  perf-profile.children.cycles-pp.osq_lock
      0.60 ±  3%      -0.1        0.50 ±  6%  perf-profile.children.cycles-pp.rcu_core
      0.58 ±  3%      -0.1        0.48 ±  6%  perf-profile.children.cycles-pp.rcu_do_batch
      0.33            -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.read
      0.39            -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.unlink_file_vma
      0.48            -0.1        0.39        perf-profile.children.cycles-pp.irq_exit_rcu
      0.24 ±  2%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.ksys_read
      0.82            -0.1        0.74        perf-profile.children.cycles-pp.xas_store
      0.23            -0.1        0.15 ±  6%  perf-profile.children.cycles-pp.vfs_read
      0.21            -0.1        0.13 ±  8%  perf-profile.children.cycles-pp.pipe_read
      0.30 ±  2%      -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.___slab_alloc
      1.10            -0.1        1.03        perf-profile.children.cycles-pp.wp_page_copy
      0.41 ±  2%      -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.40 ±  2%      -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.35 ±  2%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.78            -0.1        0.71 ±  2%  perf-profile.children.cycles-pp.sync_regs
      0.44            -0.1        0.38 ±  2%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.41            -0.1        0.35        perf-profile.children.cycles-pp.mas_find
      0.32 ±  2%      -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.15 ±  2%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      0.29            -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.dup_task_struct
      0.36            -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.__put_anon_vma
      0.15 ±  2%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.09 ± 11%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.evlist__parse_sample
      0.56            -0.1        0.50 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.38            -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.28            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.mm_init
      0.16 ±  2%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.get_free_pages_noprof
      0.30 ±  2%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.75 ±  2%      -0.1        0.69 ±  3%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.28            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp._exit
      0.16            -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.34            -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.mas_next_slot
      0.13 ± 13%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.machine__process_fork_event
      0.13 ±  2%      -0.1        0.07 ±  9%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.61            -0.1        0.55 ±  2%  perf-profile.children.cycles-pp.vm_normal_page
      0.21 ±  2%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.__wake_up_sync_key
      0.53 ±  3%      -0.1        0.48 ±  6%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.20 ±  2%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
      0.36            -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.__tlb_remove_folio_pages_size
      0.34            -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.34            -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
      0.24            -0.1        0.19        perf-profile.children.cycles-pp.acct_collect
      0.10 ± 10%      -0.1        0.05 ± 45%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.32 ±  5%      -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.51 ±  3%      -0.1        0.46 ±  6%  perf-profile.children.cycles-pp.ret_from_fork
      0.50 ±  4%      -0.1        0.45 ±  4%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.18 ±  2%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.exit_notify
      0.35            -0.0        0.30 ±  3%  perf-profile.children.cycles-pp.__open64_nocancel
      0.20 ±  3%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.__wake_up_common
      0.28            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.31            -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.path_openat
      0.23 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.08 ± 14%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.nsinfo__new
      0.72            -0.0        0.67        perf-profile.children.cycles-pp.native_irq_return_iret
      0.31            -0.0        0.27 ±  4%  perf-profile.children.cycles-pp.do_filp_open
      0.09 ± 12%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.thread__new
      0.08 ± 11%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.vfs_fstatat
      0.46            -0.0        0.42 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.19 ±  2%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.42            -0.0        0.37 ±  2%  perf-profile.children.cycles-pp.___perf_sw_event
      0.37 ±  2%      -0.0        0.33        perf-profile.children.cycles-pp.__dquot_alloc_space
      0.44            -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.__perf_sw_event
      0.15            -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.__put_partials
      0.15            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.activate_task
      0.29            -0.0        0.25 ±  3%  perf-profile.children.cycles-pp.folio_unlock
      0.24            -0.0        0.20        perf-profile.children.cycles-pp.wake_up_new_task
      0.30 ±  2%      -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.32            -0.0        0.27 ±  2%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.25            -0.0        0.21 ±  4%  perf-profile.children.cycles-pp.__mmdrop
      0.12 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.do_task_dead
      0.24            -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.remove_vma
      0.14 ±  2%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.down_read_trylock
      0.14 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.unmap_single_vma
      0.18 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      0.23            -0.0        0.19 ±  2%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.10            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.pgd_alloc
      0.17 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.14 ±  2%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.mas_dup_build
      0.16 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.18 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.pipe_write
      0.21 ±  4%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.14 ±  2%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__mt_dup
      0.12            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.22            -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.open_last_lookups
      0.24            -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.schedule_tail
      0.29            -0.0        0.26        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.11 ± 12%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.__pmd_alloc
      0.15 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.18 ±  2%      -0.0        0.15        perf-profile.children.cycles-pp.find_idlest_cpu
      0.17 ±  2%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.__mmap
      0.12 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.mas_next_node
      0.13 ±  2%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.17 ±  5%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.17 ±  2%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.__rb_erase_color
      0.08 ±  4%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.do_notify_parent
      0.18 ±  2%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.fput
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.memset_orig
      0.13 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.task_tick_fair
      0.18 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.lookup_open
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.shmem_recalc_inode
      0.18            -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.15 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.13 ±  2%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.08            -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.dequeue_entity
      0.16 ±  2%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.10 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.free_pgd_range
      0.48            -0.0        0.46 ±  2%  perf-profile.children.cycles-pp.filemap_get_entry
      0.16 ±  3%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.inode_add_bytes
      0.24            -0.0        0.22        perf-profile.children.cycles-pp.ksys_write
      0.32 ±  2%      -0.0        0.30        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.24            -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.vfs_write
      0.30            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.xas_clear_mark
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.xas_find
      0.23 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.10            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.15 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.do_mmap
      0.09 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.release_task
      0.16 ±  2%      -0.0        0.14        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.20 ±  3%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.14 ±  4%      -0.0        0.12        perf-profile.children.cycles-pp.pcpu_alloc_noprof
      0.17            -0.0        0.15        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.33 ±  2%      -0.0        0.31 ±  2%  perf-profile.children.cycles-pp.write
      0.15 ±  2%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.xas_create
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.xas_init_marks
      0.06 ±  6%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.alloc_pages_bulk_noprof
      0.08 ±  6%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.get_partial_node
      0.16            -0.0        0.14        perf-profile.children.cycles-pp.find_idlest_group
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.update_curr
      0.10            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.10 ±  3%      -0.0        0.08        perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.08 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk_noprof
      0.10 ±  3%      -0.0        0.08        perf-profile.children.cycles-pp.shmem_is_huge
      0.14 ±  2%      -0.0        0.12        perf-profile.children.cycles-pp.shmem_mknod
      0.06            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.__exit_signal
      0.06            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.mas_copy_node
      0.11            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__split_vma
      0.09 ±  7%      -0.0        0.07        perf-profile.children.cycles-pp.free_p4d_range
      0.16 ±  2%      -0.0        0.14        perf-profile.children.cycles-pp.xas_find_conflict
      0.46            -0.0        0.45 ±  2%  perf-profile.children.cycles-pp.xas_load
      0.14 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.handle_pte_fault
      0.10            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.__memcpy
      0.07 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.free_pud_range
      0.16 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.mas_store
      0.11            -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.mmap_region
      0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.uncharge_folio
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.13 ±  2%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.filemap_free_folio
      0.11 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.munmap@plt
      0.10            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.16 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.xas_start
      0.07 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__vmalloc_area_node
      0.07 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.enqueue_entity
      0.08            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.06 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.11 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.noop_dirty_folio
      0.14 ±  3%      -0.0        0.13        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.08            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__put_user_4
      0.10            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.14            -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.policy_nodemask
      0.10 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.__percpu_counter_sum
      0.11            -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.follow_page_mask
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.error_entry
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.get_vma_policy
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.mas_wr_walk
      0.10            -0.0        0.09        perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.stress_mwc32modn
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.up_read
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.__shmem_get_inode
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.arch_dup_task_struct
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.mas_erase
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.mas_store_prealloc
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.xas_alloc
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.record__pushfn
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.writen
      1.02            +0.0        1.04        perf-profile.children.cycles-pp.lru_add_fn
      0.81            +0.0        0.85        perf-profile.children.cycles-pp.__get_user_pages
      0.02 ±141%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.13            +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.madvise_vma_behavior
      0.84            +0.1        0.92        perf-profile.children.cycles-pp.faultin_page_range
      1.00            +0.1        1.12        perf-profile.children.cycles-pp.do_madvise
      1.01            +0.1        1.14        perf-profile.children.cycles-pp.__madvise
      1.00            +0.1        1.13        perf-profile.children.cycles-pp.__x64_sys_madvise
      0.19 ±  2%      +0.2        0.40 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      9.95            +0.3       10.29        perf-profile.children.cycles-pp.do_anonymous_page
      0.40 ±  2%      +0.6        1.01 ±  6%  perf-profile.children.cycles-pp.__folio_batch_release
      0.48 ±  2%      +0.6        1.10 ± 17%  perf-profile.children.cycles-pp.lru_add_drain
      0.51 ±  2%      +0.6        1.15 ±  6%  perf-profile.children.cycles-pp.notify_change
      0.48 ±  2%      +0.6        1.13 ±  6%  perf-profile.children.cycles-pp.shmem_setattr
      0.49 ±  2%      +0.6        1.14 ±  6%  perf-profile.children.cycles-pp.__x64_sys_ftruncate
      0.48 ±  2%      +0.6        1.13 ±  6%  perf-profile.children.cycles-pp.do_truncate
      0.49 ±  3%      +0.6        1.14 ±  6%  perf-profile.children.cycles-pp.do_ftruncate
      0.50 ±  2%      +0.6        1.15 ±  6%  perf-profile.children.cycles-pp.ftruncate64
     82.28            +1.1       83.36        perf-profile.children.cycles-pp.do_syscall_64
     82.28            +1.1       83.37        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.88 ±  2%      +1.2        2.10 ± 10%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      5.47            +2.4        7.83 ±  2%  perf-profile.children.cycles-pp.do_unlinkat
      5.48            +2.4        7.84 ±  2%  perf-profile.children.cycles-pp.__x64_sys_unlink
      5.48            +2.4        7.84 ±  2%  perf-profile.children.cycles-pp.unlink
      5.30            +2.4        7.68 ±  3%  perf-profile.children.cycles-pp.evict
      5.29            +2.4        7.67 ±  3%  perf-profile.children.cycles-pp.shmem_evict_inode
      5.00            +2.4        7.44 ±  3%  perf-profile.children.cycles-pp.syscall
      2.01 ±  2%      +2.6        4.65 ±  6%  perf-profile.children.cycles-pp.folio_add_lru_vma
     16.84            +2.9       19.75        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      5.41            +3.0        8.46 ±  3%  perf-profile.children.cycles-pp.__munmap
      5.31            +3.1        8.36 ±  3%  perf-profile.children.cycles-pp.__vm_munmap
      5.31            +3.1        8.37 ±  3%  perf-profile.children.cycles-pp.__x64_sys_munmap
      5.31            +3.1        8.37 ±  3%  perf-profile.children.cycles-pp.do_vmi_munmap
      5.30            +3.1        8.36 ±  3%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      5.13            +3.1        8.21 ±  3%  perf-profile.children.cycles-pp.unmap_region
      8.17            +3.2       11.39 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      8.13            +3.2       11.36 ±  3%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      8.12            +3.2       11.35 ±  3%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
     16.85            +3.6       20.44        perf-profile.children.cycles-pp.fallocate64
     11.52            +3.6       15.17 ±  2%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      4.15 ±  2%      +5.5        9.68 ±  6%  perf-profile.children.cycles-pp.folio_add_lru
     27.20            +5.9       33.09        perf-profile.children.cycles-pp.stress_run
     21.72            +6.0       27.75 ±  2%  perf-profile.children.cycles-pp.shmem_fallocate
     21.75            +6.0       27.78 ±  2%  perf-profile.children.cycles-pp.__x64_sys_fallocate
     21.74            +6.0       27.78 ±  2%  perf-profile.children.cycles-pp.vfs_fallocate
      9.89            +6.3       16.15 ±  3%  perf-profile.children.cycles-pp.shmem_undo_range
      6.84 ±  2%      +9.4       16.28 ±  6%  perf-profile.children.cycles-pp.folio_batch_move_lru
     12.04 ±  2%     +10.1       22.12 ±  4%  perf-profile.children.cycles-pp.folios_put_refs
      7.63 ±  2%     +11.0       18.64 ±  6%  perf-profile.children.cycles-pp.__page_cache_release
     16.10 ±  2%     +17.3       33.40 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     15.84 ±  2%     +17.4       33.20 ±  5%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     12.04 ±  2%     +20.2       32.23 ±  6%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     10.39 ±  3%      -4.4        5.98 ±  6%  perf-profile.self.cycles-pp._compound_head
      4.98            -1.5        3.52 ±  3%  perf-profile.self.cycles-pp.copy_present_ptes
      3.60            -1.3        2.35 ±  4%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      1.86            -0.7        1.15 ±  6%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      4.41            -0.7        3.76 ±  2%  perf-profile.self.cycles-pp.clear_page_erms
      0.99 ±  4%      -0.4        0.56 ± 29%  perf-profile.self.cycles-pp.queue_event
      2.79            -0.4        2.38 ±  2%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.86            -0.3        0.52 ±  8%  perf-profile.self.cycles-pp.__free_one_page
      0.71            -0.3        0.40 ±  9%  perf-profile.self.cycles-pp.rmqueue_bulk
      1.17            -0.2        0.92 ±  3%  perf-profile.self.cycles-pp.down_write
      2.11            -0.2        1.87        perf-profile.self.cycles-pp.folios_put_refs
      1.72            -0.2        1.49 ±  2%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      1.04            -0.2        0.80 ±  3%  perf-profile.self.cycles-pp.find_lock_entries
      0.82            -0.2        0.61 ±  3%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      2.10            -0.2        1.90        perf-profile.self.cycles-pp.zap_present_ptes
      0.77            -0.2        0.58 ±  3%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.84 ±  2%      -0.2        0.67 ±  2%  perf-profile.self.cycles-pp.up_write
      0.74            -0.2        0.56 ±  2%  perf-profile.self.cycles-pp.anon_vma_clone
      0.95            -0.2        0.78 ±  2%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      1.15            -0.2        0.98 ±  2%  perf-profile.self.cycles-pp.zap_pte_range
      0.86            -0.2        0.70 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      1.29            -0.2        1.14 ±  2%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      1.18            -0.1        1.03 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.77            -0.1        0.63 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.74 ±  4%      -0.1        0.61 ±  4%  perf-profile.self.cycles-pp.try_charge_memcg
      0.56            -0.1        0.44 ±  2%  perf-profile.self.cycles-pp.dup_mmap
      0.87            -0.1        0.75 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.61            -0.1        0.50 ±  3%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.41            -0.1        0.30 ±  3%  perf-profile.self.cycles-pp.vm_area_dup
      0.53            -0.1        0.42 ±  2%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.34 ±  3%      -0.1        0.24 ± 17%  perf-profile.self.cycles-pp.osq_lock
      0.87            -0.1        0.77 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
      0.33            -0.1        0.25 ±  2%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.78            -0.1        0.71 ±  2%  perf-profile.self.cycles-pp.sync_regs
      0.47            -0.1        0.41 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.28 ±  2%      -0.1        0.22 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.46            -0.1        0.40 ±  2%  perf-profile.self.cycles-pp.__count_memcg_events
      0.59 ±  3%      -0.1        0.53 ±  4%  perf-profile.self.cycles-pp.copy_pte_range
      0.16 ±  3%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.78            -0.1        0.72        perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.37            -0.1        0.32 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.32            -0.1        0.27 ±  2%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.35            -0.1        0.30        perf-profile.self.cycles-pp.kmem_cache_free
      0.11            -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.52            -0.0        0.47 ±  2%  perf-profile.self.cycles-pp.vm_normal_page
      0.72            -0.0        0.67        perf-profile.self.cycles-pp.native_irq_return_iret
      0.33            -0.0        0.29        perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.54            -0.0        0.50        perf-profile.self.cycles-pp.lru_add_fn
      0.27            -0.0        0.23 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.28            -0.0        0.23 ±  3%  perf-profile.self.cycles-pp.folio_unlock
      0.17 ±  2%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp.acct_collect
      0.14 ±  3%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.unmap_vmas
      0.30 ±  2%      -0.0        0.26 ±  3%  perf-profile.self.cycles-pp.mas_walk
      0.44 ±  4%      -0.0        0.40 ±  5%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.41            -0.0        0.36 ±  2%  perf-profile.self.cycles-pp.xas_store
      0.34            -0.0        0.31 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.18 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
      0.09            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.14 ±  2%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.down_read_trylock
      0.16 ±  5%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.anon_vma_fork
      0.34            -0.0        0.31        perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.14 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.unmap_single_vma
      0.21            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.28            -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.filemap_map_pages
      0.30            -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.14 ±  3%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.get_partial_node
      0.30            -0.0        0.27 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.20 ±  3%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.shmem_inode_acct_blocks
      0.21            -0.0        0.18 ±  3%  perf-profile.self.cycles-pp.filemap_get_entry
      0.26            -0.0        0.23 ±  3%  perf-profile.self.cycles-pp.shmem_fallocate
      0.06            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.14 ±  3%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.memset_orig
      0.17            -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.fput
      0.08 ±  4%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.update_load_avg
      0.12 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.mas_next_slot
      0.15 ±  2%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__rb_erase_color
      0.18            -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.08            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.mas_next_node
      0.24            -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.__tlb_remove_folio_pages_size
      0.19 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.stress_shm
      0.26            -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.xas_clear_mark
      0.25            -0.0        0.23 ±  3%  perf-profile.self.cycles-pp.free_unref_folios
      0.24 ±  2%      -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.rmqueue
      0.21 ±  3%      -0.0        0.19        perf-profile.self.cycles-pp.__dquot_alloc_space
      0.13            -0.0        0.11        perf-profile.self.cycles-pp.__folio_cancel_dirty
      0.18 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.do_anonymous_page
      0.28 ±  2%      -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.06            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.mas_copy_node
      0.32 ±  2%      -0.0        0.30 ±  2%  perf-profile.self.cycles-pp.__page_cache_release
      0.15 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.uncharge_folio
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.14            -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.shmem_alloc_and_add_folio
      0.11 ±  4%      -0.0        0.09 ±  6%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.11 ±  3%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.noop_dirty_folio
      0.17 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.09            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.shmem_is_huge
      0.13 ±  2%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.10            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.12            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.folio_add_lru
      0.12 ±  4%      -0.0        0.11        perf-profile.self.cycles-pp.xas_find_conflict
      0.12 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.filemap_free_folio
      0.07 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.__memcpy
      0.08 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.__percpu_counter_sum
      0.07            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.up_read
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.13            -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.alloc_pages_mpol_noprof
      0.10 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.15            -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.refill_obj_stock
      0.08            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.xas_create
      0.12            -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.xas_find
      0.12            -0.0        0.11        perf-profile.self.cycles-pp.__filemap_remove_folio
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.error_entry
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.__mod_memcg_state
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.copy_page_range
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.30            +0.2        0.47 ±  3%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.18 ±  2%      +0.2        0.38 ±  6%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
     15.83 ±  2%     +17.4       33.20 ±  5%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/bigheap/stress-ng/60s

commit: 
  59142d87ab ("memcg: reduce memory size of mem_cgroup_events_index")
  70a64b7919 ("memcg: dynamically allocate lruvec_stats")

59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    210127 ±  3%     +10.1%     231433 ±  3%  meminfo.Mapped
    173449            -3.6%     167274        vmstat.system.in
      2445 ±  3%     -14.9%       2081 ±  3%  perf-c2c.DRAM.remote
      1285 ±  5%     -27.8%     928.17 ±  5%  perf-c2c.HITM.remote
     12214 ± 23%     +46.0%      17831 ± 39%  sched_debug.cfs_rq:/.load.avg
      3.47 ±  9%     +16.7%       4.05 ±  9%  sched_debug.cpu.clock.stddev
      0.36 ±  2%      -0.1        0.31 ±  3%  mpstat.cpu.all.irq%
      0.01 ±  7%      -0.0        0.01 ±  7%  mpstat.cpu.all.soft%
      6.86 ±  4%      -1.2        5.63 ±  5%  mpstat.cpu.all.usr%
 4.672e+08           -11.2%  4.148e+08        numa-numastat.node0.local_node
 4.677e+08           -11.3%   4.15e+08        numa-numastat.node0.numa_hit
 4.697e+08           -10.8%  4.189e+08        numa-numastat.node1.local_node
 4.701e+08           -10.9%  4.188e+08        numa-numastat.node1.numa_hit
 4.678e+08           -11.3%   4.15e+08        numa-vmstat.node0.numa_hit
 4.673e+08           -11.3%  4.148e+08        numa-vmstat.node0.numa_local
 4.702e+08           -10.9%  4.188e+08        numa-vmstat.node1.numa_hit
 4.698e+08           -10.8%  4.189e+08        numa-vmstat.node1.numa_local
  58108348           -10.8%   51824962        stress-ng.bigheap.ops
    963931           -11.3%     854675        stress-ng.bigheap.ops_per_sec
   1065940            +7.0%    1140389        stress-ng.bigheap.realloc_calls_per_sec
 9.304e+08           -10.8%  8.298e+08        stress-ng.time.minor_page_faults
      3554            +2.0%       3626        stress-ng.time.system_time
    231.49 ±  5%     -19.4%     186.58 ±  6%  stress-ng.time.user_time
     54271 ±  3%      +6.6%      57872 ±  2%  proc-vmstat.nr_mapped
     84119            -2.8%      81797        proc-vmstat.nr_page_table_pages
 9.378e+08           -11.1%  8.338e+08        proc-vmstat.numa_hit
 9.368e+08           -11.0%  8.336e+08        proc-vmstat.numa_local
 9.322e+08           -10.8%  8.315e+08        proc-vmstat.pgalloc_normal
 9.305e+08           -10.8%  8.302e+08        proc-vmstat.pgfault
 9.249e+08           -10.1%  8.315e+08        proc-vmstat.pgfree
      9.07           -14.5%       7.75 ±  2%  perf-stat.i.MPKI
 1.577e+10            -7.0%  1.466e+10        perf-stat.i.branch-instructions
      0.32            +0.0        0.32        perf-stat.i.branch-miss-rate%
  44619004            -4.7%   42531475        perf-stat.i.branch-misses
     55.70            -7.2       48.50        perf-stat.i.cache-miss-rate%
 7.806e+08           -21.8%  6.101e+08 ±  2%  perf-stat.i.cache-misses
 1.276e+09           -10.6%   1.14e+09        perf-stat.i.cache-references
      2.79            +8.8%       3.03        perf-stat.i.cpi
    689.18 ± 11%     +28.8%     887.61 ±  4%  perf-stat.i.cycles-between-cache-misses
 8.069e+10            -7.9%  7.431e+10        perf-stat.i.instructions
      0.37            -8.1%       0.34        perf-stat.i.ipc
    483.04           -12.4%     423.35        perf-stat.i.metric.K/sec
  15458873           -12.3%   13551131        perf-stat.i.minor-faults
  15458873           -12.3%   13551132        perf-stat.i.page-faults
      9.63           -14.7%       8.21 ±  2%  perf-stat.overall.MPKI
     61.14            -7.6       53.51        perf-stat.overall.cache-miss-rate%
      2.76            +9.1%       3.01        perf-stat.overall.cpi
    287.04           +27.9%     367.00 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.36            -8.3%       0.33        perf-stat.overall.ipc
 1.548e+10            -6.9%  1.441e+10        perf-stat.ps.branch-instructions
  43599293            -5.5%   41194014        perf-stat.ps.branch-misses
 7.627e+08           -21.3%  6.002e+08 ±  2%  perf-stat.ps.cache-misses
 1.248e+09           -10.1%  1.122e+09        perf-stat.ps.cache-references
 7.924e+10            -7.8%  7.306e+10        perf-stat.ps.instructions
  15094804           -11.7%   13330187        perf-stat.ps.minor-faults
  15094805           -11.7%   13330188        perf-stat.ps.page-faults
 4.884e+12            -7.3%  4.527e+12        perf-stat.total.instructions
     25.91            -5.7       20.22 ±  2%  perf-profile.calltrace.cycles-pp.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     13.09            -2.8       10.31 ±  2%  perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
     37.66 ±  2%      -2.8       34.90 ±  3%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     37.66 ±  2%      -2.8       34.90 ±  3%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     37.66 ±  2%      -2.8       34.90 ±  3%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
     37.65 ±  2%      -2.8       34.89 ±  3%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     12.72            -2.7        9.98 ±  2%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
     37.88 ±  2%      -2.7       35.16 ±  3%  perf-profile.calltrace.cycles-pp.__munmap
     37.88 ±  2%      -2.7       35.16 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     37.88 ±  2%      -2.7       35.16 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     37.88 ±  2%      -2.7       35.16 ±  3%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     37.88 ±  2%      -2.7       35.16 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     37.88 ±  2%      -2.7       35.16 ±  3%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     37.88 ±  2%      -2.7       35.16 ±  3%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.88 ±  2%      -2.7       35.16 ±  3%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     12.30            -2.7        9.58 ±  3%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
     12.40            -2.7        9.70 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page
     11.78            -2.6        9.20 ±  2%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio
     36.19 ±  2%      -2.6       33.62 ±  3%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     36.19 ±  2%      -2.6       33.62 ±  3%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
     36.17 ±  2%      -2.6       33.60 ±  3%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     36.02 ±  2%      -2.5       33.47 ±  3%  perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
      3.81 ±  2%      -2.2        1.61 ±  9%  perf-profile.calltrace.cycles-pp.sysinfo
      3.66 ±  2%      -2.2        1.48 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sysinfo
      3.67 ±  2%      -2.2        1.49 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sysinfo
      3.62 ±  2%      -2.2        1.45 ± 10%  perf-profile.calltrace.cycles-pp.__do_sys_sysinfo.do_syscall_64.entry_SYSCALL_64_after_hwframe.sysinfo
      3.56 ±  2%      -2.2        1.40 ± 10%  perf-profile.calltrace.cycles-pp.do_sysinfo.__do_sys_sysinfo.do_syscall_64.entry_SYSCALL_64_after_hwframe.sysinfo
      9.22            -2.1        7.14 ±  2%  perf-profile.calltrace.cycles-pp.clear_page_erms.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof
      2.99 ±  2%      -1.9        1.06 ± 13%  perf-profile.calltrace.cycles-pp.si_meminfo.do_sysinfo.__do_sys_sysinfo.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.83 ±  2%      -1.9        0.93 ± 14%  perf-profile.calltrace.cycles-pp.nr_blockdev_pages.si_meminfo.do_sysinfo.__do_sys_sysinfo.do_syscall_64
      2.64 ±  3%      -1.8        0.80 ± 15%  perf-profile.calltrace.cycles-pp._raw_spin_lock.nr_blockdev_pages.si_meminfo.do_sysinfo.__do_sys_sysinfo
      2.47 ±  3%      -1.8        0.68 ± 17%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.nr_blockdev_pages.si_meminfo.do_sysinfo
      7.25            -1.5        5.71 ±  2%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
      5.82            -1.2        4.62 ±  2%  perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page
      3.14 ±  6%      -0.8        2.29 ±  4%  perf-profile.calltrace.cycles-pp.try_charge_memcg.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
      4.31 ±  3%      -0.8        3.50 ±  2%  perf-profile.calltrace.cycles-pp.cgroup_rstat_updated.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.alloc_anon_folio
      2.04 ± 26%      -0.6        1.47 ±  7%  perf-profile.calltrace.cycles-pp.free_unref_folios.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu
      1.73 ± 31%      -0.5        1.21 ±  8%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_folios.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      1.53 ± 34%      -0.5        1.05 ± 10%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_folios.folios_put_refs.free_pages_and_swap_cache
      2.82 ±  2%      -0.4        2.42 ±  2%  perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.stress_bigheap_child
      1.57 ±  2%      -0.3        1.27 ±  4%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof
      0.60 ±  2%      -0.2        0.35 ± 70%  perf-profile.calltrace.cycles-pp.__free_one_page.free_pcppages_bulk.free_unref_page_commit.free_unref_folios.folios_put_refs
      1.10 ±  3%      -0.2        0.86 ±  5%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof
      1.53            -0.2        1.30 ±  2%  perf-profile.calltrace.cycles-pp.mremap
      0.92 ±  4%      -0.2        0.71 ±  6%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages_noprof
      0.62 ±  4%      -0.2        0.43 ± 44%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.41 ±  3%      -0.2        1.22 ±  3%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.30            -0.2        1.14 ±  3%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      1.09            -0.2        0.92 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mremap
      1.04            -0.2        0.88 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      1.08            -0.2        0.91 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      1.01 ±  2%      -0.2        0.85 ±  2%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_bigheap_child
      0.72 ±  3%      -0.1        0.60 ±  2%  perf-profile.calltrace.cycles-pp.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.66 ±  2%      -0.1        0.55 ±  2%  perf-profile.calltrace.cycles-pp.mas_walk.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.77 ±  2%      -0.1        0.67 ±  3%  perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      0.68 ±  2%      -0.1        0.58 ±  2%  perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_bigheap_child
      1.12 ±  2%      +0.1        1.22        perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru_vma.do_anonymous_page.__handle_mm_fault
     54.36            +5.4       59.72 ±  2%  perf-profile.calltrace.cycles-pp.stress_bigheap_child
     55.17 ±  2%      +5.4       60.59 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_bigheap_child
     43.01 ±  2%      +7.1       50.15 ±  2%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_bigheap_child
     42.82 ±  2%      +7.2       49.99 ±  2%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_bigheap_child
     40.42 ±  2%      +7.5       47.96 ±  2%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_bigheap_child
     38.94 ±  2%      +7.8       46.72 ±  2%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     37.51 ±  2%      +8.0       45.50 ±  2%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      6.25 ±  5%     +13.8       20.03 ±  6%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.do_anonymous_page.__handle_mm_fault
      6.24 ±  5%     +13.8       20.02 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.do_anonymous_page
      6.17 ±  5%     +13.8       19.97 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma
      8.24 ±  4%     +14.1       22.31 ±  6%  perf-profile.calltrace.cycles-pp.folio_add_lru_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      8.03 ±  4%     +14.1       22.13 ±  6%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault
     26.14            -5.7       20.47 ±  2%  perf-profile.children.cycles-pp.alloc_anon_folio
     42.92 ±  2%      -5.0       37.88 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     42.90 ±  2%      -5.0       37.87 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
     12.76            -2.8        9.91 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_charge
     13.13            -2.8       10.34 ±  2%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
     37.67 ±  2%      -2.8       34.90 ±  3%  perf-profile.children.cycles-pp.unmap_page_range
     37.67 ±  2%      -2.8       34.90 ±  3%  perf-profile.children.cycles-pp.unmap_vmas
     37.67 ±  2%      -2.8       34.90 ±  3%  perf-profile.children.cycles-pp.zap_pmd_range
     37.66 ±  2%      -2.8       34.90 ±  3%  perf-profile.children.cycles-pp.zap_pte_range
     12.83            -2.8       10.07 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
     37.88 ±  2%      -2.7       35.16 ±  3%  perf-profile.children.cycles-pp.__munmap
     37.88 ±  2%      -2.7       35.16 ±  3%  perf-profile.children.cycles-pp.__x64_sys_munmap
     37.88 ±  2%      -2.7       35.16 ±  3%  perf-profile.children.cycles-pp.__vm_munmap
     12.52            -2.7        9.80 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
     37.90 ±  2%      -2.7       35.18 ±  3%  perf-profile.children.cycles-pp.do_vmi_munmap
     37.90 ±  2%      -2.7       35.19 ±  3%  perf-profile.children.cycles-pp.do_vmi_align_munmap
     37.90 ±  2%      -2.7       35.18 ±  3%  perf-profile.children.cycles-pp.unmap_region
     11.87            -2.6        9.28 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
     36.26 ±  2%      -2.6       33.71 ±  3%  perf-profile.children.cycles-pp.tlb_flush_mmu
     36.41 ±  2%      -2.5       33.88 ±  3%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
     36.41 ±  2%      -2.5       33.88 ±  3%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
     36.49 ±  2%      -2.5       33.97 ±  3%  perf-profile.children.cycles-pp.folios_put_refs
      3.83 ±  2%      -2.2        1.63 ±  9%  perf-profile.children.cycles-pp.sysinfo
      3.62 ±  2%      -2.2        1.45 ± 10%  perf-profile.children.cycles-pp.__do_sys_sysinfo
      3.56 ±  2%      -2.2        1.40 ± 10%  perf-profile.children.cycles-pp.do_sysinfo
      9.34            -2.1        7.24 ±  2%  perf-profile.children.cycles-pp.clear_page_erms
      3.31 ±  3%      -2.1        1.22 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock
      2.99 ±  2%      -1.9        1.06 ± 13%  perf-profile.children.cycles-pp.si_meminfo
      2.83 ±  2%      -1.9        0.93 ± 14%  perf-profile.children.cycles-pp.nr_blockdev_pages
      7.38            -1.6        5.81 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      6.12            -1.3        4.86 ±  2%  perf-profile.children.cycles-pp.__count_memcg_events
      3.17 ±  6%      -0.9        2.31 ±  4%  perf-profile.children.cycles-pp.try_charge_memcg
      4.58 ±  3%      -0.8        3.73 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      2.09 ± 25%      -0.6        1.51 ±  7%  perf-profile.children.cycles-pp.free_unref_folios
      1.75 ± 30%      -0.5        1.23 ±  8%  perf-profile.children.cycles-pp.free_unref_page_commit
      2.63 ±  2%      -0.4        2.21 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      2.84 ±  2%      -0.4        2.44 ±  2%  perf-profile.children.cycles-pp.sync_regs
      1.62 ±  2%      -0.3        1.31 ±  3%  perf-profile.children.cycles-pp.rmqueue
      2.01 ±  2%      -0.3        1.74 ±  2%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.12 ±  3%      -0.2        0.88 ±  5%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      1.44 ±  2%      -0.2        1.21 ±  2%  perf-profile.children.cycles-pp.__perf_sw_event
      1.55            -0.2        1.32 ±  2%  perf-profile.children.cycles-pp.mremap
      0.96 ±  3%      -0.2        0.74 ±  6%  perf-profile.children.cycles-pp.rmqueue_bulk
      1.26 ±  2%      -0.2        1.06 ±  2%  perf-profile.children.cycles-pp.___perf_sw_event
      0.45 ±  4%      -0.2        0.24 ±  4%  perf-profile.children.cycles-pp.si_swapinfo
      1.37            -0.2        1.20 ±  3%  perf-profile.children.cycles-pp.zap_present_ptes
      1.05            -0.2        0.89 ±  2%  perf-profile.children.cycles-pp.__do_sys_mremap
      1.05 ±  2%      -0.2        0.88 ±  2%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      1.04            -0.2        0.89 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.71 ±  2%      -0.1        0.60 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.77            -0.1        0.66        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.79 ±  2%      -0.1        0.68 ±  3%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.56            -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.vma_merge_extend
      0.56            -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.vma_merge
      0.57            -0.1        0.48        perf-profile.children.cycles-pp.__mod_node_page_state
      0.62 ±  3%      -0.1        0.54 ±  3%  perf-profile.children.cycles-pp.__free_one_page
      0.48 ± 11%      -0.1        0.41 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.40            -0.1        0.34        perf-profile.children.cycles-pp.__mod_zone_page_state
      0.35 ±  4%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.37 ±  2%      -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.31 ±  3%      -0.1        0.25 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.29 ±  4%      -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.28 ±  5%      -0.1        0.22 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.23 ±  3%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.25 ±  2%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.16 ±  5%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.21 ±  3%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.24 ±  3%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.32            -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.handle_pte_fault
      0.20 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.20 ±  2%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.uncharge_batch
      0.37 ±  2%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.18 ±  5%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.19 ±  4%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.up_read
      0.24 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.28 ±  2%      -0.0        0.25        perf-profile.children.cycles-pp.error_entry
      0.24 ±  2%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map
      0.14 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.mas_store_prealloc
      0.14 ±  3%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.uncharge_folio
      0.21 ±  2%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.down_read_trylock
      0.16 ±  3%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.perf_exclude_event
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.13 ±  2%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.perf_swevent_event
      0.06            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.__tlb_remove_folio_pages_size
      0.10 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.10 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.mt_find
      0.07            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__pte_alloc
      0.12 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.mtree_load
      0.10 ±  3%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.14 ±  5%      -0.0        0.13        perf-profile.children.cycles-pp.policy_nodemask
      0.10 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.06 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.pte_alloc_one
      0.06 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.stress_low_memory
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.__get_unmapped_area
      0.12 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.mas_wr_slot_store
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.find_vma_intersection
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.realloc
      0.25 ±  2%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.main
      0.25 ±  2%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.run_builtin
      0.25            +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.__cmd_record
      0.25            +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.cmd_record
      0.20            +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.record__pushfn
      0.21 ±  2%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.perf_mmap__push
      0.19 ±  2%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.ksys_write
      0.20            +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.writen
      0.21 ±  2%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.18 ±  2%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.20            +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.write
      0.18 ±  2%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.generic_perform_write
      0.19            +0.0        0.22        perf-profile.children.cycles-pp.vfs_write
      0.07 ±  5%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.06 ±  8%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.07            +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.shmem_write_begin
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.folio_add_lru
      1.17 ±  2%      +0.1        1.28        perf-profile.children.cycles-pp.lru_add_fn
      0.18 ±  2%      +0.2        0.37 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
     56.53            +5.1       61.64 ±  2%  perf-profile.children.cycles-pp.stress_bigheap_child
     51.09 ±  2%      +6.0       57.08 ±  2%  perf-profile.children.cycles-pp.asm_exc_page_fault
     43.06 ±  2%      +7.1       50.20 ±  2%  perf-profile.children.cycles-pp.exc_page_fault
     42.90 ±  2%      +7.2       50.06 ±  2%  perf-profile.children.cycles-pp.do_user_addr_fault
     40.49 ±  2%      +7.5       48.02 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
     38.98 ±  2%      +7.8       46.75 ±  2%  perf-profile.children.cycles-pp.__handle_mm_fault
     37.65 ±  2%      +8.0       45.62 ±  2%  perf-profile.children.cycles-pp.do_anonymous_page
     42.65            +9.7       52.32 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     40.01 ±  2%     +11.6       51.60 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     38.94 ±  2%     +12.1       51.00 ±  2%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      8.25 ±  4%     +14.1       22.32 ±  6%  perf-profile.children.cycles-pp.folio_add_lru_vma
      8.09 ±  4%     +14.2       22.24 ±  6%  perf-profile.children.cycles-pp.folio_batch_move_lru
      9.28            -2.1        7.19 ±  2%  perf-profile.self.cycles-pp.clear_page_erms
      7.27 ±  3%      -1.1        6.17 ±  5%  perf-profile.self.cycles-pp.stress_bigheap_child
      4.51 ±  3%      -0.8        3.68 ±  2%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      2.80 ±  6%      -0.8        2.05 ±  4%  perf-profile.self.cycles-pp.try_charge_memcg
      2.63 ±  2%      -0.4        2.21 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      1.66 ±  8%      -0.4        1.24 ±  3%  perf-profile.self.cycles-pp.__count_memcg_events
      2.83 ±  2%      -0.4        2.42 ±  2%  perf-profile.self.cycles-pp.sync_regs
      1.35 ±  2%      -0.3        1.03 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      1.14 ±  3%      -0.3        0.84 ±  3%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.93 ±  2%      -0.2        0.74 ±  2%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.94 ±  2%      -0.2        0.78 ±  3%  perf-profile.self.cycles-pp.__handle_mm_fault
      1.02 ±  2%      -0.2        0.86 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.56 ±  7%      -0.1        0.43 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.85            -0.1        0.72 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.70 ±  2%      -0.1        0.59 ±  2%  perf-profile.self.cycles-pp.mas_walk
      0.50            -0.1        0.40 ±  3%  perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.54 ±  2%      -0.1        0.44 ±  4%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.98 ±  3%      -0.1        0.88 ±  3%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.54            -0.1        0.45 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.55 ±  3%      -0.1        0.48 ±  4%  perf-profile.self.cycles-pp.__free_one_page
      0.61 ±  2%      -0.1        0.54 ±  2%  perf-profile.self.cycles-pp.do_anonymous_page
      0.48 ±  2%      -0.1        0.42 ±  2%  perf-profile.self.cycles-pp.handle_mm_fault
      0.19 ±  3%      -0.1        0.13 ± 10%  perf-profile.self.cycles-pp.nr_blockdev_pages
      0.34            -0.1        0.29        perf-profile.self.cycles-pp.__mod_zone_page_state
      0.42 ±  2%      -0.1        0.36 ±  4%  perf-profile.self.cycles-pp.zap_present_ptes
      0.32 ±  2%      -0.1        0.27 ±  3%  perf-profile.self.cycles-pp.__page_cache_release
      0.21 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.26 ±  2%      -0.0        0.22 ±  4%  perf-profile.self.cycles-pp.free_unref_folios
      0.32 ±  3%      -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.28 ±  2%      -0.0        0.24 ±  3%  perf-profile.self.cycles-pp.rmqueue
      0.22 ±  3%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.12 ±  5%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      0.23 ±  3%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.folio_add_new_anon_rmap
      0.16 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.si_meminfo
      0.18 ±  3%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.20 ±  2%      -0.0        0.17 ±  3%  perf-profile.self.cycles-pp.folio_add_lru_vma
      0.23            -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.18 ±  3%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.up_read
      0.58 ±  2%      -0.0        0.56        perf-profile.self.cycles-pp.lru_add_fn
      0.18 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.25            -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.error_entry
      0.22 ±  3%      -0.0        0.19 ±  4%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.35 ±  3%      -0.0        0.32        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.18 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.alloc_pages_mpol_noprof
      0.12 ±  4%      -0.0        0.10        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.19 ±  2%      -0.0        0.17 ±  3%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.18 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.__perf_sw_event
      0.19 ±  2%      -0.0        0.17 ±  3%  perf-profile.self.cycles-pp.down_read_trylock
      0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.perf_exclude_event
      0.22 ±  3%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__pte_offset_map
      0.17 ±  8%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.uncharge_folio
      0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.vma_alloc_folio_noprof
      0.13 ±  2%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.access_error
      0.16 ±  3%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.11 ±  3%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.perf_swevent_event
      0.11 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.pte_offset_map_nolock
      0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.mtree_load
      0.09            -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.09 ±  5%      -0.0        0.08        perf-profile.self.cycles-pp.mt_find
      0.12 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.11 ±  4%      -0.0        0.10        perf-profile.self.cycles-pp.exc_page_fault
      0.07            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.do_sysinfo
      0.06 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.stress_low_memory
      0.10 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.zap_pte_range
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.realloc
      0.16 ±  2%      +0.2        0.35 ±  2%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.37 ±  2%      +0.2        0.57 ±  2%  perf-profile.self.cycles-pp.folio_batch_move_lru
     42.63            +9.7       52.32 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/page_fault2/will-it-scale

commit: 
  59142d87ab ("memcg: reduce memory size of mem_cgroup_events_index")
  70a64b7919 ("memcg: dynamically allocate lruvec_stats")

59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      7.14            -0.8        6.30        mpstat.cpu.all.usr%
    245257 ±  7%     -13.4%     212405 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    245258 ±  7%     -13.4%     212404 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
     21099 ±  5%     -15.2%      17886 ±  5%  perf-c2c.DRAM.local
    344.83 ±  5%     -13.5%     298.40 ±  5%  perf-c2c.DRAM.remote
      4025 ±  2%     +30.5%       5253 ±  3%  perf-c2c.HITM.local
   9538291           -12.2%    8375564        will-it-scale.104.processes
     91713           -12.2%      80533        will-it-scale.per_process_ops
   9538291           -12.2%    8375564        will-it-scale.workload
 1.438e+09           -11.3%  1.276e+09        numa-numastat.node0.local_node
  1.44e+09           -11.3%  1.278e+09        numa-numastat.node0.numa_hit
 1.453e+09           -13.1%  1.263e+09        numa-numastat.node1.local_node
 1.454e+09           -13.1%  1.264e+09        numa-numastat.node1.numa_hit
  1.44e+09           -11.3%  1.278e+09        numa-vmstat.node0.numa_hit
 1.438e+09           -11.3%  1.276e+09        numa-vmstat.node0.numa_local
 1.454e+09           -13.1%  1.264e+09        numa-vmstat.node1.numa_hit
 1.453e+09           -13.1%  1.263e+09        numa-vmstat.node1.numa_local
      7175            +1.0%       7248        proc-vmstat.nr_page_table_pages
 2.894e+09           -12.2%  2.542e+09        proc-vmstat.numa_hit
 2.891e+09           -12.2%  2.539e+09        proc-vmstat.numa_local
  2.88e+09           -12.1%  2.531e+09        proc-vmstat.pgalloc_normal
 2.869e+09           -12.1%  2.521e+09        proc-vmstat.pgfault
  2.88e+09           -12.1%  2.531e+09        proc-vmstat.pgfree
     17.51            -2.6%      17.04        perf-stat.i.MPKI
 9.457e+09            -9.4%  8.564e+09        perf-stat.i.branch-instructions
  45022022            -8.5%   41216509        perf-stat.i.branch-misses
     84.38            -5.2       79.17        perf-stat.i.cache-miss-rate%
 8.353e+08           -12.3%  7.324e+08        perf-stat.i.cache-misses
 9.877e+08            -6.6%   9.23e+08        perf-stat.i.cache-references
      6.06           +11.1%       6.74        perf-stat.i.cpi
    136.25            -1.2%     134.55        perf-stat.i.cpu-migrations
    348.56           +14.2%     398.07        perf-stat.i.cycles-between-cache-misses
 4.763e+10            -9.9%  4.291e+10        perf-stat.i.instructions
      0.17            -9.8%       0.15        perf-stat.i.ipc
    182.56           -12.2%     160.36        perf-stat.i.metric.K/sec
   9494393           -12.1%    8341139        perf-stat.i.minor-faults
   9494393           -12.1%    8341139        perf-stat.i.page-faults
     17.54            -2.6%      17.08        perf-stat.overall.MPKI
      0.47            +0.0        0.48        perf-stat.overall.branch-miss-rate%
     84.57            -5.2       79.36        perf-stat.overall.cache-miss-rate%
      6.07           +11.1%       6.75        perf-stat.overall.cpi
    346.33           +14.1%     395.10        perf-stat.overall.cycles-between-cache-misses
      0.16           -10.0%       0.15        perf-stat.overall.ipc
   1503802            +2.7%    1544704        perf-stat.overall.path-length
 9.424e+09            -9.5%  8.532e+09        perf-stat.ps.branch-instructions
  44739120            -8.5%   40915825        perf-stat.ps.branch-misses
 8.326e+08           -12.3%    7.3e+08        perf-stat.ps.cache-misses
 9.846e+08            -6.6%  9.199e+08        perf-stat.ps.cache-references
    134.98            -1.3%     133.27        perf-stat.ps.cpu-migrations
 4.747e+10            -9.9%  4.275e+10        perf-stat.ps.instructions
   9463902           -12.2%    8313073        perf-stat.ps.minor-faults
   9463902           -12.2%    8313073        perf-stat.ps.page-faults
 1.434e+13            -9.8%  1.294e+13        perf-stat.total.instructions
     64.15            -2.5       61.68        perf-profile.calltrace.cycles-pp.testcase
     58.30            -1.9       56.38        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     52.64            -1.4       51.27        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     52.50            -1.4       51.14        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     50.81            -1.0       49.84        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      9.27            -0.9        8.37 ±  3%  perf-profile.calltrace.cycles-pp.copy_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     49.86            -0.9       49.00        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     49.21            -0.8       48.42        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      5.15            -0.5        4.66        perf-profile.calltrace.cycles-pp.__irqentry_text_end.testcase
      3.24            -0.5        2.76        perf-profile.calltrace.cycles-pp.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.82            -0.3        0.51        perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      1.68            -0.3        1.42        perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      2.52            -0.2        2.28        perf-profile.calltrace.cycles-pp.error_entry.testcase
      1.50 ±  2%      -0.2        1.29 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault
      1.85            -0.2        1.68 ±  3%  perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.68            -0.1        0.55 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      0.55            -0.1        0.41 ± 50%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc
      1.55            -0.1        1.42 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault
      1.07            -0.1        0.97        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault.__handle_mm_fault
      0.90            -0.1        0.81        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      0.89            -0.0        0.85        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.vma_alloc_folio_noprof.folio_prealloc.do_fault
      1.00            +0.1        1.05        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      3.85            +0.3        4.11        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      3.85            +0.3        4.11        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      3.85            +0.3        4.11        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      0.83            +0.3        1.09 ±  2%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.set_pte_range.finish_fault.do_fault.__handle_mm_fault
      3.82            +0.3        4.08        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.unmap_region
      3.68            +0.3        3.95        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.00            +0.5        0.55        perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range
      0.00            +0.7        0.66        perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
     32.87            +0.8       33.72        perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
     29.54            +2.3       31.84        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     29.54            +2.3       31.84        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
     29.53            +2.3       31.83        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     30.66            +2.3       32.96        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     30.66            +2.3       32.96        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     30.66            +2.3       32.96        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
     30.66            +2.3       32.96        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     29.26            +2.4       31.63        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
     28.41            +2.4       30.82        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu
     34.56            +2.6       37.12        perf-profile.calltrace.cycles-pp.__munmap
     34.56            +2.6       37.12        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     34.56            +2.6       37.12        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     34.55            +2.6       37.11        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     34.55            +2.6       37.12        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     34.55            +2.6       37.12        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     34.55            +2.6       37.12        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     34.55            +2.6       37.12        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.41            +2.8       34.24        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
     31.42            +2.8       34.27        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
     31.38            +2.8       34.23        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     65.26            -2.6       62.68        perf-profile.children.cycles-pp.testcase
     56.09            -1.7       54.39        perf-profile.children.cycles-pp.asm_exc_page_fault
     52.66            -1.4       51.28        perf-profile.children.cycles-pp.exc_page_fault
     52.52            -1.4       51.16        perf-profile.children.cycles-pp.do_user_addr_fault
     50.83            -1.0       49.86        perf-profile.children.cycles-pp.handle_mm_fault
      9.35            -0.9        8.45 ±  3%  perf-profile.children.cycles-pp.copy_page
     49.87            -0.9       49.01        perf-profile.children.cycles-pp.__handle_mm_fault
     49.23            -0.8       48.44        perf-profile.children.cycles-pp.do_fault
      3.27            -0.5        2.78        perf-profile.children.cycles-pp.folio_prealloc
      5.15            -0.5        4.66        perf-profile.children.cycles-pp.__irqentry_text_end
      0.82            -0.3        0.52        perf-profile.children.cycles-pp.lock_vma_under_rcu
      1.69            -0.3        1.42        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.57            -0.3        0.31 ±  2%  perf-profile.children.cycles-pp.mas_walk
      2.54            -0.2        2.30        perf-profile.children.cycles-pp.error_entry
      1.52 ±  2%      -0.2        1.30 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.87            -0.2        1.70 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.95            -0.2        0.79 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.60 ±  4%      -0.1        0.46 ±  6%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.70            -0.1        0.56 ±  2%  perf-profile.children.cycles-pp.lru_add_fn
      1.57            -0.1        1.44 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      1.16            -0.1        1.04        perf-profile.children.cycles-pp.native_irq_return_iret
      1.12            -0.1        1.01        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.44            -0.1        0.35 ±  2%  perf-profile.children.cycles-pp.get_vma_policy
      0.94            -0.1        0.85        perf-profile.children.cycles-pp.sync_regs
      0.96            -0.1        0.87        perf-profile.children.cycles-pp.__perf_sw_event
      0.43            -0.1        0.34        perf-profile.children.cycles-pp.free_unref_folios
      0.21 ±  3%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp._compound_head
      0.75            -0.1        0.68        perf-profile.children.cycles-pp.___perf_sw_event
      0.31            -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.94            -0.1        0.89        perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.41 ±  4%      -0.0        0.36 ±  5%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.44 ±  5%      -0.0        0.39 ±  5%  perf-profile.children.cycles-pp.__count_memcg_events
      0.17 ±  2%      -0.0        0.13 ±  4%  perf-profile.children.cycles-pp.uncharge_batch
      0.57            -0.0        0.53 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.19 ±  3%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.13 ±  2%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.10 ±  3%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.08            -0.0        0.05        perf-profile.children.cycles-pp.policy_nodemask
      0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.15 ±  2%      -0.0        0.12 ±  2%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.32 ±  3%      -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.shmem_get_policy
      0.17 ±  2%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.16            -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.handle_pte_fault
      0.36 ±  2%      -0.0        0.34 ±  3%  perf-profile.children.cycles-pp.xas_load
      0.12 ±  3%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.uncharge_folio
      0.16 ±  4%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map
      0.36            -0.0        0.34        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.09            -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.08            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.folio_unlock
      0.30            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.10 ±  3%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.40            +0.0        0.43 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      1.02            +0.0        1.06        perf-profile.children.cycles-pp.zap_present_ptes
      0.47            +0.2        0.67        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      3.87            +0.3        4.13        perf-profile.children.cycles-pp.tlb_finish_mmu
      1.17            +0.5        1.70 ±  2%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
     32.88            +0.8       33.73        perf-profile.children.cycles-pp.set_pte_range
     29.54            +2.3       31.84        perf-profile.children.cycles-pp.tlb_flush_mmu
     30.66            +2.3       32.96        perf-profile.children.cycles-pp.zap_pte_range
     30.66            +2.3       32.97        perf-profile.children.cycles-pp.unmap_page_range
     30.66            +2.3       32.97        perf-profile.children.cycles-pp.zap_pmd_range
     30.66            +2.3       32.97        perf-profile.children.cycles-pp.unmap_vmas
     33.41            +2.6       35.96        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
     33.40            +2.6       35.96        perf-profile.children.cycles-pp.free_pages_and_swap_cache
     34.56            +2.6       37.12        perf-profile.children.cycles-pp.__munmap
     34.56            +2.6       37.12        perf-profile.children.cycles-pp.__x64_sys_munmap
     34.56            +2.6       37.12        perf-profile.children.cycles-pp.__vm_munmap
     34.56            +2.6       37.13        perf-profile.children.cycles-pp.do_vmi_munmap
     34.56            +2.6       37.13        perf-profile.children.cycles-pp.do_vmi_align_munmap
     34.56            +2.6       37.13        perf-profile.children.cycles-pp.unmap_region
     34.67            +2.6       37.24        perf-profile.children.cycles-pp.do_syscall_64
     34.67            +2.6       37.24        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     33.22            +2.6       35.84        perf-profile.children.cycles-pp.folios_put_refs
     32.12            +2.7       34.80        perf-profile.children.cycles-pp.__page_cache_release
     61.97            +3.5       65.42        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     61.98            +3.5       65.44        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     61.94            +3.5       65.42        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      9.32            -0.9        8.42 ±  3%  perf-profile.self.cycles-pp.copy_page
      5.15            -0.5        4.66        perf-profile.self.cycles-pp.__irqentry_text_end
      0.56            -0.3        0.31        perf-profile.self.cycles-pp.mas_walk
      2.58            -0.3        2.32        perf-profile.self.cycles-pp.testcase
      2.53            -0.2        2.29        perf-profile.self.cycles-pp.error_entry
      0.60 ±  4%      -0.1        0.45 ±  6%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.85            -0.1        0.72 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      1.54            -0.1        1.42 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      1.15            -0.1        1.04        perf-profile.self.cycles-pp.native_irq_return_iret
      0.94            -0.1        0.84        perf-profile.self.cycles-pp.sync_regs
      0.20 ±  3%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp._compound_head
      0.27 ±  3%      -0.1        0.20 ±  3%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.26            -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.get_vma_policy
      0.26            -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.__page_cache_release
      0.16            -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.vma_alloc_folio_noprof
      0.28 ±  2%      -0.1        0.22 ±  2%  perf-profile.self.cycles-pp.zap_present_ptes
      0.66            -0.1        0.60        perf-profile.self.cycles-pp.___perf_sw_event
      0.32            -0.1        0.27 ±  4%  perf-profile.self.cycles-pp.lru_add_fn
      0.47            -0.0        0.42 ±  2%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.37 ±  5%      -0.0        0.33 ±  6%  perf-profile.self.cycles-pp.__count_memcg_events
      0.16 ±  4%      -0.0        0.12        perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.30            -0.0        0.25        perf-profile.self.cycles-pp.handle_mm_fault
      0.20            -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.free_unref_folios
      0.10 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.zap_pte_range
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.12 ±  4%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.alloc_pages_mpol_noprof
      0.14 ±  2%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.31 ±  2%      -0.0        0.29 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.16 ±  2%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.21            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__perf_sw_event
      0.11            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.22 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.11            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.17 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.21            -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.09            -0.0        0.07        perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.shmem_get_policy
      0.12            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.uncharge_folio
      0.16 ±  4%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__pte_offset_map
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.28 ±  2%      -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.xas_load
      0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.folio_unlock
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.do_fault
      0.07            -0.0        0.06 ±  5%  perf-profile.self.cycles-pp.folio_prealloc
      0.38 ±  2%      +0.0        0.42 ±  2%  perf-profile.self.cycles-pp.filemap_get_entry
      0.26            +0.1        0.36        perf-profile.self.cycles-pp.folios_put_refs
      0.33            +0.1        0.45 ±  3%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.40 ±  5%      +0.6        0.97        perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
     61.94            +3.5       65.42        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


