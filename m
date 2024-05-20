Return-Path: <cgroups+bounces-2961-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0723B8C9801
	for <lists+cgroups@lfdr.de>; Mon, 20 May 2024 04:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7538E1F213AB
	for <lists+cgroups@lfdr.de>; Mon, 20 May 2024 02:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA009457;
	Mon, 20 May 2024 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcDCnGgK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4A6AB8
	for <cgroups@vger.kernel.org>; Mon, 20 May 2024 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716173034; cv=fail; b=Klj59ZSZeNp9eC5h9ah8GR/oM+ucTezQBaok53f7Mjdddt0lNkO3vMobqH55D+WRDyEgZP7GIQSSRZGcRw/zE+xtrViXyZqzOhbL342Vjjauk0DqvdNkr6Xl1cvwABVKClkMT1/jOyLHp9hP/tYgDV/Cr5TBY0B8prd6aAx8kII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716173034; c=relaxed/simple;
	bh=D5F4hQDvFO0pABdP+uQbteSKNSM2k2cUiotweapDTMU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GxyE4Oy4DCCuBwQdLMC62oOaF/C5ljX1zcag8y3gB+weASeC/Sx7ZlPmfcmuYbRzkfc452AUBMCsMPrw/vkL3LmL2RcnPhR5NKcdnkQvUvsRxj/BjgcqAxkONIxBSm1n1v/uFjgtCcXrc1QunK4KlSAoJPEH1YMji/eilw1yBkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcDCnGgK; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716173031; x=1747709031;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D5F4hQDvFO0pABdP+uQbteSKNSM2k2cUiotweapDTMU=;
  b=jcDCnGgKDL4jGdehLWBHpGBF5999ZLjHUWDyxncND9NanyFXqA9N7kTJ
   5ZXfX0ThK32L8lPSXFlj2cgJ6TEAFbXSYXMRhSt2b//Bjrz4BIJRaV6My
   OvW1O5iW23p8dw3XH+2Afie9gLucY+R+m6/fimQSRMreQTPTPdOksoinF
   C1pcXx6akF2pLsVQKGrZrlqYbi5PrRRoynDxLra/qm6oJhGMi5ExRjsN1
   Igb8z3AQdOm/GmNg3CHXgnAnyeYguVBFWyXQZO+vuWqb6/GQzg4s4m1Qv
   oDC2LR2pte0zPuODmel7WLhG5WR80QwTDL5mmYuuO645ZFlp83tFFm9FO
   g==;
X-CSE-ConnectionGUID: /6HKdmw2QL2HGqXIlthpmA==
X-CSE-MsgGUID: N+STOVAhTTqZQi+ZSU2x0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="29793657"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="29793657"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 19:43:51 -0700
X-CSE-ConnectionGUID: Hmlult42SnSH4CVMqflnqQ==
X-CSE-MsgGUID: yMLWvDVwT0yHhdm/uimFlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="36798339"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 19:43:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 19:43:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 19:43:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 19:43:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 19:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH++CZtZNLig9PJaZ4+txfntjd7w5NJGZfcLjJiV3eHAnYC9oncGBwXb5qjRMP1WdRZVo672t4OIOkQWs0O7Y1zHtaKjcfLzmxm3GEjbBiXKGd9cj4yEFo9l4XWDSzrUqOpN3uUfW/rQCBK8nwefBuxkao5pTGpG++oz4kyLCe0hZCWp/1RxIwaME3gN3PmY1QhTJPJrtuhjJ8lxh19nwPGeU+Sz9rSIHQb6v5VXnGafj57ApSv8VuuSRDIGMy6mQg3QHgUwee+FRiPy6L9SSLIAb3udyKpoMOMErsvKDR819dqxQAaRx24WpaZ0EpxU2FOMTzHRWDZK6FTxzrLIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBSSV7B442wsIyMD1KBRGIdVDSkiThYXGjSNKaInJPU=;
 b=F0U8z1TEJpe/OciIvoq/ERjK27fQNbJBR9ZYhcWVi9p4Hd2wqLjUWfsUIVnX+JhlBShDpOek/6nG4FMoYQpLmGdf7tC3bgUdxvhxPV+HnE7p9I1+m+ZGQ59CJc/i89HPisxKE2EY5vOLJUSSnOk+U2Sna3KYTLbr5C5uL+RTm4Wn1wYqFE5xfGWNvuXpFIuQQwNTxcodN2MT3elvGOah1nDw6F2SmBm4zGpO7xmAeIpvigT4y224SunKjpJ8pYg6vt1pFTGYwaCAG1QXTfrPUtJ76KnIkMgTqWwS8rRB3gmpUrcrOx/amPjNuzpfxYk+Jb0o+F15SFCx2zz6JX/H4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Mon, 20 May
 2024 02:43:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 02:43:46 +0000
Date: Mon, 20 May 2024 10:43:35 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed
	<yosryahmed@google.com>, "T.J. Mercier" <tjmercier@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	<cgroups@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [memcg]  70a64b7919:
 will-it-scale.per_process_ops -11.9% regression
Message-ID: <Zkq41w8YKCaKQAGk@xsang-OptiPlex-9020>
References: <202405171353.b56b845-oliver.sang@intel.com>
 <pdfcrrgqz6vy6xarsw6gswtoa32wjd2gpcagmreh7ksuy66i63@dowfkmloe37q>
 <ZknC/xjryN0sxOWB@xsang-OptiPlex-9020>
 <jg2rpsollyfck5drndajpxtqbjtigtuxql4j5s66egygfrcjqa@okdilkpx5v5e>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <jg2rpsollyfck5drndajpxtqbjtigtuxql4j5s66egygfrcjqa@okdilkpx5v5e>
X-ClientProxiedBy: KU1PR03CA0042.apcprd03.prod.outlook.com
 (2603:1096:802:19::30) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bca993-6ce8-47a3-1f6a-08dc7876abcd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wFvOpJYtAy3fj3uKmoWvB8Oe2UO0rJFxTlX9sXLBHQ7mk7eUBb/HGsVQ/iZB?=
 =?us-ascii?Q?7F/U+nw46BtRPJhYJnh1ZvmAGZjPGPKCh5UaV2CzYf1RQHAeWV9Zgy+f2wML?=
 =?us-ascii?Q?/yWxlcDKiPKK1hkEwCeBMD9y0AMhM2kpaPg5pD1pS5MYzGHUYa7hMaPdr10c?=
 =?us-ascii?Q?FxgG8KS+h2V8UVYv//WnlcZeYyYkALb3p/EeSOv2RILugW62uQ5eeW3JdLfR?=
 =?us-ascii?Q?MVBSQHZoOv/OHMfWxA9L9Q5V2brZtwkd7Js+OcTLzpGnEt4o4qH8ItyZadOI?=
 =?us-ascii?Q?qyAjT3G0jawIcrVIiP1GGRyEUBHWAkE4vJJKORM5lV7u93luVKxId9Sbb/mr?=
 =?us-ascii?Q?1e5SqxVK1mb8J4GVGzYDZYcRbQNHIQkiw/gj7ADg0w4zBVZfXiKgTN+ThYG9?=
 =?us-ascii?Q?Ne4pYMWoX8OGNs8FyHABscJ1djsC384QJZkRkpwyqTphdCBRw3vBXxDXn1E3?=
 =?us-ascii?Q?3r1sahhO5x5xQM4GuKayk4c0K7SDZXeceMB9abRentUizXIXa3LuoXWxaxV0?=
 =?us-ascii?Q?3F45ISI187Pj66oDkF7hTvouT1PstR3Q/DFvferB6AcV11ma4u4Abbu9USi5?=
 =?us-ascii?Q?T1tu65YkSlDE47YJugsdsvLH5Osay5ROlnGby/iaOvJ6VvjPNIqy5aR+hqlY?=
 =?us-ascii?Q?D+a0WMp0sHnB0XfI5oeNEcY99+7GFWDv+6PQP5agJTZqP9pCYOx2LcaIlRsr?=
 =?us-ascii?Q?m4PvJntJ8SFUh/+RZJW0bXoKKr0I4/HxfK2OWQ7uZhkQWNBsdRv5GEcxfIK0?=
 =?us-ascii?Q?MZEINfjU/NqLHdplBu87/uYEg1LeKNc9Hn3giVSbb3lJefZxlH7j2hSrBnpz?=
 =?us-ascii?Q?z5cF+ONEI0Wu21LWlJN3BNDPiIIuReORESRSMon4VgZTfC3CF+TqDzDO4b7s?=
 =?us-ascii?Q?/eXq9D4ETglRyUT+8YVetK9Aetbtj62QkQikH6KS5ggOTfvsdkS9dUsx85t6?=
 =?us-ascii?Q?IZWOhg7SfVWYyctVfVJVsgr10OgXV1gh4T5iFh3wNtny9EPs/mINb4J8DtbH?=
 =?us-ascii?Q?xggDKu2Feijz7DxXtI6Zjp/XxhrO+uzySn85dEDTeKGRJiH4RBJpRA7eWKZL?=
 =?us-ascii?Q?RKMrS71OKYn87pxm0h9lTPuuzrMcBlGniYkrFkb+y1rBdJzcnhWTJ3/voUUV?=
 =?us-ascii?Q?02vA620SHZBkh+Um8vlquR4PDhLfhGxfk6QrTqrZ66HE3blKJtPXFMMFc5my?=
 =?us-ascii?Q?Npc6EBf9xV7SbVm+LjAV5WjUK7oZquXF+pskK+fLmjsIVoIqTjcL8RFsFf4?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X5XBJ9VTf4ehy73hwRytVAnH32PWclntfY3nopgy4mbmXIcUkCf5JGA9mofF?=
 =?us-ascii?Q?zgdbS6lumZBx5VCPybmP/6lL6JGiJiSTp4EfEzaa8hlVn9RKsOfKjnMFRs2x?=
 =?us-ascii?Q?YMzACgcwro8ZLHsdojqoyf50b84TwzylMzqyejE3YTxJZ5mCTWF09BpUMw/f?=
 =?us-ascii?Q?tM7HcpoI4+uKX/e7JneuvrF/KdRrkpE1OS5hYIfbvBe3b3JAyvFVF2sR+xyz?=
 =?us-ascii?Q?VAxRFKuqqRzCilyMDcO+qosatarJAkggvh9XdCie2UXb0re090aag1CyuKC3?=
 =?us-ascii?Q?nZV0qN5eKnatyis9409LGyrSLkneuQmjrsGkCVyuYROqUDo67x6eEna3kV0V?=
 =?us-ascii?Q?GEarDQkjpz/DaI+TtOoOEYwXlJZ4B13r0sJu0C6zoZ3HW73R3Z3jxbPFGhlN?=
 =?us-ascii?Q?47iC+l/pxIvDdeSkUIp44N9eE/VPI24qoh6L/YRziUQ9pYo08zg200XpMcwo?=
 =?us-ascii?Q?GZvjCAvKK9gs7e/JdTbNci38ZsvrzTVwInlnaEL30NLZKqDNCRiFGeY04D4V?=
 =?us-ascii?Q?UibBEL+5mmtmVIJfTN6fP7cnHjLsTaUHK93qgd9PmuOTPsVnG+flk8GMKT/Z?=
 =?us-ascii?Q?H4bk8jD7euPYoU224Tow1O32gDZdR8Y8l8FzI034b2rQ4JyrC5yGQpV19Zoe?=
 =?us-ascii?Q?9HmmOKhqxCRbiVVHvKOMIVLVa8MKMUxXVvwvsYVeZFSYu77Lx6smglBoR06x?=
 =?us-ascii?Q?w5/xpvqqI8ZaJefSPBxTQe81Krj9M9mJzc4yiUl3jUnpAyuyG+Efr4X+YBRv?=
 =?us-ascii?Q?h23LhewZ7TcjxGgmpzTmP/1R7gqmsMYXlhWgVU9+PpP2pAm5K8Ho/SnZzBNK?=
 =?us-ascii?Q?HKkL/pbFBAnbbtXkjFOnH3RU8M+SmLpjEgErW8uqcwfg4Yef5eGKK5/qPjzX?=
 =?us-ascii?Q?lyZZAthETcZs79Gj1A9X2QFs64oiVb35aXgoEvMns74HxelopHe03F93hRP/?=
 =?us-ascii?Q?NirAiD048o9i4nOJUp1WKghEUfQAigOLbw/LoD/y0t2m46hniTYqvIWUAsQA?=
 =?us-ascii?Q?zM5m/zdLo6CMLF71ee88Cv10HipXrkI5shUk0dEpeD6QrIJZ3Vq2e1ZDsxDB?=
 =?us-ascii?Q?F7KJbD2AaQUwNaR6PkE/I6fwBbXWy9qsZijEjpH3L5VKhNgBfzkX/RXgp680?=
 =?us-ascii?Q?NI73/cfK/wPfDTL6FwifPt8bghbhSVhNsN2a1YQtn7V/wzwk1F4tjI8oXGCf?=
 =?us-ascii?Q?dK3tHqCQ+vGLL67rJIOUyPNGs7R+/Qn1y7Tsbsnampg136v2x3QiknqVJ2Wg?=
 =?us-ascii?Q?RTXNyoDE9HEDnpn2J2bNwq64wtFTDuzZWfblzm910+zk+GzQzXmEUUBxQqJb?=
 =?us-ascii?Q?Mf7kJiSwbVhtsXirupwYsP+xTk5U+f+1lutTuX1ze5btvANV6mgWN9bfHWHX?=
 =?us-ascii?Q?D4m9UiTpA4XCCtHQFx1FNTzbupPwB/Q61VZY3hMnw5dvphJADalJ+81hLBBW?=
 =?us-ascii?Q?HWLVOt9TbkzBL79sQJGiVgRfAOGlVMhF+ZddN58YsQsy6gImmiaougbS3Wh0?=
 =?us-ascii?Q?Z7NApZWs768NcHr4Xlnm1gOsLnjqM15RLdaD1LbIolqSZoxzsTPf6uM0hmCO?=
 =?us-ascii?Q?HA0WsC0OOUOUjm1w9SoCCb16omi2ZnpkSBovvYM4sQszNzgPGYdTpZfrDCmv?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bca993-6ce8-47a3-1f6a-08dc7876abcd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 02:43:46.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGynRG2j4MgJusy90xUpNHanhm/0iKDKnBUtMKN7nAR1BSxCopmswI5tDcGy8IA+e1PxZYlmU6FXYpsUSfHmXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com

hi, Shakeel,

On Sun, May 19, 2024 at 10:20:28AM -0700, Shakeel Butt wrote:
> On Sun, May 19, 2024 at 05:14:39PM +0800, Oliver Sang wrote:
> > hi, Shakeel,
> > 
> > On Fri, May 17, 2024 at 11:28:10PM -0700, Shakeel Butt wrote:
> > > On Fri, May 17, 2024 at 01:56:30PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > kernel test robot noticed a -11.9% regression of will-it-scale.per_process_ops on:
> > > > 
> > > > 
> > > > commit: 70a64b7919cbd6c12306051ff2825839a9d65605 ("memcg: dynamically allocate lruvec_stats")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > 
> > > 
> > > Thanks for the report. Can you please run the same benchmark but with
> > > the full series (of 8 patches) or at least include the ff48c71c26aa
> > > ("memcg: reduce memory for the lruvec and memcg stats").
> > 
> > while this bisect, ff48c71c26aa has been checked. it has silimar data as
> > 70a64b7919 (a little worse actually)
> > 
> > 59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 ff48c71c26aaefb090c108d8803
> > ---------------- --------------------------- ---------------------------
> >          %stddev     %change         %stddev     %change         %stddev
> >              \          |                \          |                \
> >      91713           -11.9%      80789           -13.2%      79612        will-it-scale.per_process_ops
> > 
> > 
> > ok, we will run tests on tip of the series which should be below if I understand
> > it correctly.
> > 
> > * a94032b35e5f9 memcg: use proper type for mod_memcg_state
> > 
> > 
> 
> Thanks a lot Oliver. One question: what is the filesystem mounted at
> /tmp on your test machine? I just wanted to make sure I run the test
> with minimal changes from your setup.

we don't have specific partition for /tmp, just use tmpfs

tmp on /tmp type tmpfs (rw,relatime)


BTW, the test on a94032b35e5f9 finished, still have similar score to 70a64b7919

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/page_fault2/will-it-scale

59142d87ab03b8ff 70a64b7919cbd6c12306051ff28 ff48c71c26aaefb090c108d8803 a94032b35e5f97dc1023030d929
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
     91713           -11.9%      80789           -13.2%      79612           -13.0%      79833        will-it-scale.per_process_ops



> 
> > > 
> > > thanks,
> > > Shakeel
> > > 

