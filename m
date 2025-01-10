Return-Path: <cgroups+bounces-6082-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24060A085C0
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 04:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1170B16905A
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 03:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C8E1E2614;
	Fri, 10 Jan 2025 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqYNW4UO"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC91A4F1F;
	Fri, 10 Jan 2025 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736478298; cv=fail; b=mjyrtrcwLPtInE0tytWIx6+FcR8XnpdyGWxG0Fxqll29sKw7zooFTmZVa5+Pc0q8nSsc1aqkxZFb65t148G1f3tEe0R6BL3A14PzIKCm9JiKtejHpIY193k0o29psPm1ff3H6QTzShh9S+kFRqlSBlAAIh7wR/k6FYlJFyHb9c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736478298; c=relaxed/simple;
	bh=WsaXrPfUTM51RNltrLTF466v4jqno559z7OFUYVujos=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sQH9ha1huV9wIS8IFuUgGBS8yA34C5ui5WcCMTetQjeyKFgLwyKZMmi0NdIJRM/hEwznAZ+52e2+2ZIh3PpE8/dVYObYKe/KGiF+h4aKSq9oOFgQ9yHB7RDKlqmC02xIIX3upbQqNq1ihwdRpu2aXe8oXIOFPNEk477fQ89LyAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqYNW4UO; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736478295; x=1768014295;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WsaXrPfUTM51RNltrLTF466v4jqno559z7OFUYVujos=;
  b=XqYNW4UOXg7KNOx4dCrK32X2PHusd+PsPGhEbs4b6IKlRp5hGjiZSCGM
   ao6AlQTbEG0y83T3d4yzo3na4Haj+pdm+/RY5rr7SulwXiESNBzJwzOsd
   DiDY1FY0rNBCUIgUDpFSISqBSwfh6DNLkNu1d4Sblg7jiNwErdxissrgS
   n9HYi+xSmVO5PFaoXK9BQUvFVDPgvbF+phzLBoSfSjOPLRSnP5Zrziw9Q
   DmjEoMQNGVAJOeZxqdCLrTs3+/jWaivbwhfGjNXAIDW+LSKFr/3AP11Nn
   CUFbq0wqz074K7Xu5biyWwEQloOPqIFdEkUROILIcCQVMXZIA7WwNtnkU
   A==;
X-CSE-ConnectionGUID: UP5Bw3nwRZ6PvNorW8ATcA==
X-CSE-MsgGUID: zxEmTA6LSIW6N7nxBnDscw==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="62135631"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="62135631"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 19:04:53 -0800
X-CSE-ConnectionGUID: u5n3urH1TSiqL5ZkF5vmfA==
X-CSE-MsgGUID: OnU7pp+USDSVSEmmAQOb0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104130329"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 19:04:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 19:04:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 19:04:51 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 19:04:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zh3MzcMHMOtWx/hydGSIizI++x9cwCh0OJlcXXvdI1KtWqLJqpcCLZ12WErJlfOMuR5qMbqhlbXD0lktt7Hj1gMZsjFHDcYCJiaQMoVAKRAWWYK+hd/ZrYsJ5S+qqUnUTHUKMkoslvFyOLLcguuGS2xOkf46/IVVyiQGZO+v12jpjw6sjhlECNOfTXYWmPdO/1jcjne1gHE15sm58x0LiG8Q3Co6eH1ElA8Mf0Jv/v5loTMU3Svr+GshLFfguqWnUB4pTMmYK5zZIVx+CZsGsUmkZHhq+ZT3P6hP5sVGeYIEyfJazLzXck3tkoT0VcNdfYvCIibV25+QNypckgG7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jygFxqrQKjUJUz/Q6yM1w9EPY6HqSsFhkFVibduiTFY=;
 b=PZRNcMC3oK5wY5ycrWNbukuKQDFyzqrpltVKYo234h9OWvCQ7RoD/4xDyZkwYcJo/citzcaE3y1XvXJHMZzjLN1TR6ZTRnJ7DEGEGoMT4jppYwXOjeltOUW/VBtEoaBc5Mdv8zsMUtvBSSnhDkYCO6aQFdPkAonneqHJUIOveXnnQ+M6DTjcSb+FCxK/lCUPwuuG6SYfr69RxyxEl2UbFoK2wKToui7ldpBqS4kDTYRywEZ2/zfIUoRdE0bpYA+sKDF6cCP8Z7d5yKpydFbicf2axOMmTgATsKiJCywAndfNZGbvYl32OJwZ5xPXKqjlwZoIT93SUNI1IahPCTQ++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN0PR11MB6256.namprd11.prod.outlook.com (2603:10b6:208:3c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 03:04:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 03:04:48 +0000
Date: Fri, 10 Jan 2025 11:04:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	<linux-kernel@vger.kernel.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <surenb@google.com>,
	<cgroups@vger.kernel.org>, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v8 4/4] sched: Fix cgroup irq time for
 CONFIG_IRQ_TIME_ACCOUNTING
Message-ID: <202501101033.b66070d2-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250103022409.2544-5-laoar.shao@gmail.com>
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN0PR11MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 899733d0-9e4b-4bd7-10e2-08dd31238ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?noODdJz1te0m5ox4wrkYPb+4/Ob5bzpYjgkIG9fyWINWs06SUVVyDey8mB?=
 =?iso-8859-1?Q?78HSvAlzqBf2ZH4dNADIpCyH3GcJP4T40dnwf1x8DGdWq8L+J9/K8cclo9?=
 =?iso-8859-1?Q?9Cm0jVHjj6Cjj/mokBeTyLu7LJQNuskcZ0TTyijVY7QJU47XxdWPOcyYRN?=
 =?iso-8859-1?Q?F/Eoi6mOTY7ZQhs8U6Zi7/16teq7kj3Fu/w80au5THAJSy9lj0zHrmhoO2?=
 =?iso-8859-1?Q?fKUwOxStusv63e6iRPLeJTC9PDbYUA9DTm2qDC5W56K0SNKN6nkqu8Ro7V?=
 =?iso-8859-1?Q?XQbDLLLpIFgp31mT4ddt4rkTqZj1bdtMfqQXyKYqpDhsLTlAkGjudbE5P5?=
 =?iso-8859-1?Q?jSONMbypsyFqW5I8T/t6vmsEMtbBE6CQddJJAwjqXi0ICaithvsbuvkahj?=
 =?iso-8859-1?Q?VZybL+SWQhbjT0n7iuXgQJpbrTwcpBOX5WOpZcTdU1+wX83/+nabqAI1dO?=
 =?iso-8859-1?Q?856DqaTfmZFCu1MpIpMq11caXtOnz8nCk5/o5sZyTVS+xFLYKRTMZIX3SZ?=
 =?iso-8859-1?Q?VT0RHiQQOKh9lUsHalZTml3bcS3NuFUtHzxmyNtvXEUKn4+ahqkCIWbN4u?=
 =?iso-8859-1?Q?JAelifwavjvv1oZ53/q/MdtoDPeLq9aaNzP3jIb385kyziSNuEgR62VtXe?=
 =?iso-8859-1?Q?71OkiVQSMbNTXVBa0YzQGHMB0iYmraTD+Zc1linsZez708oxkOLsJyltGR?=
 =?iso-8859-1?Q?+eblnpBeyjIvz2B5tdDFeESsq6O2LqggG7620IoEAFXPEXiVFFO8rjON7+?=
 =?iso-8859-1?Q?Nk4I7IyaEB31IZhRjy5I/VkZ20SOqX8vXA88exX1nlGs8jkFmFkLTCD1hp?=
 =?iso-8859-1?Q?QMzX8PfdawXa8PEk7PTFOPtj5N+qwlfX2D+/vU1Uk9tM+LrRBUE8FCdSWr?=
 =?iso-8859-1?Q?qX3zuv669rXO7phomr1qofRj21WaLkaCqtoe9mCGB94S64hnTEIH0q93k9?=
 =?iso-8859-1?Q?FSL3933Tpwa6/7f51QAXaGH8oZNDgKuLYY8EyFOXbml9SoadnTScgHICoU?=
 =?iso-8859-1?Q?mVsktEzRJlxOE7NmZekp77mgxZi0EAROBPdbKFuloO+JxB20cl2Zg/XETJ?=
 =?iso-8859-1?Q?D65usi0sWlTPFgY30U6BDZV0WSYGgcvcS9kXyp+b1wZpYX8qKPlyfH1kBb?=
 =?iso-8859-1?Q?NwOljeB9/ElfwBbTgdnHXo8AgB4jr1vNXks9hdShx3UHG48uB7tB1L3STl?=
 =?iso-8859-1?Q?zXP4kEBqCsCrGqLC4sn9m58hjrNSdJGiZmnNimqnmD+GYx8BEFjyAHmrs6?=
 =?iso-8859-1?Q?L0rAyQNYfRq+CzDCyImFkeOPjiXwSP2HbSopuazIqeMcITMaaXMqeiUjW4?=
 =?iso-8859-1?Q?KJ7rVTu+LQKZJcJhr87B5ivBSm/e4d4IsYMYYHTV0o7dmlCdF+LCCij1By?=
 =?iso-8859-1?Q?1qjnhUm04cBYMbzRHx0TQ2nYygkjR/Wg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?i6RSOYY5sf6xa7kolfDO249pf3gzaKdTiHepQMdBwT3lPx6aTXQWNcGM5b?=
 =?iso-8859-1?Q?D/RSm562GilW9hJBArWkZxBooRG4aKhxqtLjjkrvO0uGGZXzSsoFooGJEK?=
 =?iso-8859-1?Q?LHWXVutAhs2tg2LhqKNppOULcApB2ofv2iB/IDMHU0fSQ+wZTQZxruBqdS?=
 =?iso-8859-1?Q?R/yugExB50q7+WwasVJGfa9Cg7Dth87Z81sqbJyv4rL6aa2WSyNGSgat38?=
 =?iso-8859-1?Q?Dviy45K82PJcGT3Dcbpj4ov+C0RhNnzlQkR6WRY8+LjixkuWMSPu1EsDzw?=
 =?iso-8859-1?Q?rON0vKHyKKM7eyxTZP4lwhjnZ7CKtyDo6OQfjh860ylo8i/QzuUKy7xt4n?=
 =?iso-8859-1?Q?nmwRUKmgTkuu9O/SUqMfrrEmndoCVIXef+T+Aw7X+0BLaTkR+Q+huv7okw?=
 =?iso-8859-1?Q?ruOZ1PFVdFkkPySu4JeBFyU0u3aqYO//+KBzjZYeHc4PF7RmmtCB0ZhinO?=
 =?iso-8859-1?Q?H10ERIVW4YZm6Bn4aH2+HytWeIyltWplwL1xlXQSVpTMRBWgK3r0kNIeqg?=
 =?iso-8859-1?Q?hVEuZ5JKikurAuWuM8NQ5DxQjgbneWJv8hzGzk1JbLiRPLLHCO/2JRD+HY?=
 =?iso-8859-1?Q?tIGW/ZYraLvaBZLylY57+SAC6OFukZpuVd/xohkIh5K/4oAxAov+2vXQ1O?=
 =?iso-8859-1?Q?a0YdHm/YdA5gwqTWH4Ia+ZvygkwZRb0ym4x2rWM/Y15vjpOFezW0pyyMTr?=
 =?iso-8859-1?Q?XSi5CGrhMLl6BRMB+u5fy42M0QY6FaTtB1DLgj6QtXyk1DtvLC6Yp9ir/k?=
 =?iso-8859-1?Q?ay1UdprsHxZDvi6+gzqE+NCpc0UbhayrSq3Yy8rVb43x4rNEeHcVQASOne?=
 =?iso-8859-1?Q?DPgjoCsY//15h69k5gAfXRwHJp1sfpn09ph6vWKUUZEyIaqwY88wGDtH2l?=
 =?iso-8859-1?Q?3IxWjXbz1Le15R7Gs3kZQIsXfpe7DeEYBRp9F60rQcGSHhu0SO2FKqcD9d?=
 =?iso-8859-1?Q?W6jeTMIACapn3WgkjwCgwa+cXMJtEl+11EURow/ke/Gg41sFjq/tuGzNbi?=
 =?iso-8859-1?Q?yaTlWpmU1w6dmLueT4RkvSwNGaKl1mVFTYUTjbIw5UtJBpdi7C+Gkeu1lX?=
 =?iso-8859-1?Q?zrFcJJ+5g+KjYX7iFeynFoVYXNQQyAuSYJE7VGtTu4ggyKYtBX3zbo5yh5?=
 =?iso-8859-1?Q?biwSFf5p7K7BqdzL3rmjdHmL8c1Vx27QnPeCEn9O32LYK/wq0VpEidssms?=
 =?iso-8859-1?Q?j9k8jlDyma4Ja8fpvk/A8TmIZ3Lswy5Vk6NZHVEoeuLwqxCcqbZQJCIdpS?=
 =?iso-8859-1?Q?bPLR+AxoSHnY+5+hkuRLvReZHqlwix7l0nyAL73aZRTDFYVjPsUtw7kdUr?=
 =?iso-8859-1?Q?ezJip1KRq/JKmqCFuIjesla51HyJbONXFsA+q3+k/+zotrzFGN74ek+8o/?=
 =?iso-8859-1?Q?FU6yoLhZOXN2O6Y8AXDwbzugXF8OrIkGEnv8xj6/J7wamE9ClzbjR8qzSf?=
 =?iso-8859-1?Q?5ZE4K6ac6U9u53BPbFVXfGP6dWjSG2MK7hXqF8L5YMzPLGokxBUku5mE7I?=
 =?iso-8859-1?Q?1enaPrqCPw11ofQNs+IIXOLSgFgE0OwM6nqQPHdGBqgLj0DjnHWyjB1NMO?=
 =?iso-8859-1?Q?6TANHpZCUxNbk+zuiy5gENQ7DTc95C5Oc3/ZPgEr5r7Tcb1cvy7etfwMa1?=
 =?iso-8859-1?Q?E356rw1e+DG6sYg2WSholgwNwJmb7ukTXNJklobTx5t7pJBBTws6hoiA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 899733d0-9e4b-4bd7-10e2-08dd31238ae6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 03:04:48.4631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eGYPcgsHkJUyOzagCpEDWJWbCRfEx8Biw8/aoWFvBnfvz7qftNyzaHNL8GO6RlTAS9ntqhX4A0bEiWqTKOwYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6256
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 2.3% regression of will-it-scale.per_process_ops on:


commit: efcf26d77a358557d9d847fdca09ccd0690e6831 ("[PATCH v8 4/4] sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING")
url: https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/sched-Define-sched_clock_irqtime-as-static-key/20250103-102726
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 7c8cd569ff66755f17b0c0c03a9d8df1b6f3e9ed
patch link: https://lore.kernel.org/all/20250103022409.2544-5-laoar.shao@gmail.com/
patch subject: [PATCH v8 4/4] sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: context_switch1
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501101033.b66070d2-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250110/202501101033.b66070d2-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/context_switch1/will-it-scale

commit: 
  278e29c10e ("sched, psi: Don't account irq time if sched_clock_irqtime is disabled")
  efcf26d77a ("sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING")

278e29c10e4553fa efcf26d77a358557d9d847fdca0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.01 ±  5%     +20.0%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
  20608395            -2.4%   20105294        vmstat.system.cs
  20905845            -2.3%   20428184        will-it-scale.104.processes
    201017            -2.3%     196424        will-it-scale.per_process_ops
  20905845            -2.3%   20428184        will-it-scale.workload
      1.42            -0.0        1.39        perf-stat.i.branch-miss-rate%
 3.348e+08            -3.3%  3.237e+08        perf-stat.i.branch-misses
  20793493            -2.5%   20282595        perf-stat.i.context-switches
    199.94            -2.5%     195.03        perf-stat.i.metric.K/sec
      1.40            -0.0        1.37        perf-stat.overall.branch-miss-rate%
   1728376            +1.9%    1761726        perf-stat.overall.path-length
 3.336e+08            -3.3%  3.226e+08        perf-stat.ps.branch-misses
  20722198            -2.5%   20214311        perf-stat.ps.context-switches
      2.55            -0.4        2.12 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.read
      8.10            -0.4        7.70        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
      7.35            -0.3        7.00        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write
      7.60            -0.3        7.25        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write.ksys_write
      6.96            -0.3        6.63        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write
      2.68            -0.3        2.35        perf-profile.calltrace.cycles-pp.wakeup_preempt.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      2.29            -0.3        2.00        perf-profile.calltrace.cycles-pp.check_preempt_wakeup_fair.wakeup_preempt.try_to_wake_up.autoremove_wake_function.__wake_up_common
      7.85            -0.3        7.56        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
     14.42            -0.2       14.19        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.99            -0.2        1.78        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.write
     13.40            -0.2       13.20        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.34            -0.2        1.17        perf-profile.calltrace.cycles-pp.update_curr.check_preempt_wakeup_fair.wakeup_preempt.try_to_wake_up.autoremove_wake_function
      1.42            -0.2        1.27        perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_entities.dequeue_task_fair.try_to_block_task
      2.49            -0.1        2.37        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      2.30            -0.1        2.20        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      0.80            -0.1        0.72        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.94            -0.0        1.90        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.pipe_read.vfs_read
      0.89            -0.0        0.85        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.99            -0.0        0.96        perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.79            -0.0        0.76        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      0.71            -0.0        0.69        perf-profile.calltrace.cycles-pp.fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.72            -0.0        0.70        perf-profile.calltrace.cycles-pp.__switch_to_asm.read
      0.70 ±  2%      +0.0        0.73 ±  2%  perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_write.ksys_write
      0.80            +0.0        0.84        perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.62            +0.1        0.69        perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_entities.dequeue_task_fair.try_to_block_task
      1.48            +0.1        1.57        perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__pick_next_task.__schedule.schedule
      1.29            +0.1        1.40        perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.05            +0.1        1.17        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      2.19            +0.1        2.32        perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__pick_next_task.__schedule.schedule
      3.22            +0.1        3.34        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.syscall_exit_to_user_mode
      3.37            +0.1        3.51        perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64
      0.34 ± 70%      +0.2        0.55 ±  3%  perf-profile.calltrace.cycles-pp.update_load_avg.requeue_delayed_entity.enqueue_task.try_to_wake_up.autoremove_wake_function
      3.82            +0.2        4.03        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.pipe_read
      4.01            +0.2        4.23        perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.pipe_read.vfs_read
     48.03            +0.2       48.27        perf-profile.calltrace.cycles-pp.write
     25.66            +0.4       26.03        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     30.22            +0.4       30.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     29.31            +0.4       29.69        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     26.54            +0.4       26.92        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.17 ±141%      +0.4        0.61        perf-profile.calltrace.cycles-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
     19.76            +0.5       20.22        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.07            +0.5       22.57        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     20.96            +0.5       21.46        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.current_time.inode_needs_update_time.file_update_time.pipe_write.vfs_write
      7.25            +0.5        7.77        perf-profile.calltrace.cycles-pp.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      7.04            +0.5        7.58        perf-profile.calltrace.cycles-pp.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.97            +0.6       13.56        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
     10.18            +0.6       10.78        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     12.68            +0.6       13.29        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      6.83            -0.5        6.29        perf-profile.children.cycles-pp.entry_SYSCALL_64
      8.12            -0.4        7.71        perf-profile.children.cycles-pp.__wake_up_sync_key
      7.36            -0.4        7.00        perf-profile.children.cycles-pp.autoremove_wake_function
      7.08            -0.4        6.73        perf-profile.children.cycles-pp.try_to_wake_up
      7.62            -0.4        7.27        perf-profile.children.cycles-pp.__wake_up_common
     15.19            -0.3       14.86        perf-profile.children.cycles-pp.syscall_return_via_sysret
      2.72            -0.3        2.39        perf-profile.children.cycles-pp.wakeup_preempt
      4.36            -0.3        4.04        perf-profile.children.cycles-pp.update_curr
      2.51            -0.3        2.19        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      2.33            -0.3        2.04        perf-profile.children.cycles-pp.check_preempt_wakeup_fair
     14.46            -0.2       14.22        perf-profile.children.cycles-pp.ksys_write
     13.44            -0.2       13.24        perf-profile.children.cycles-pp.vfs_write
     51.15            -0.2       50.96        perf-profile.children.cycles-pp.read
      0.44            -0.1        0.35 ± 24%  perf-profile.children.cycles-pp.reader__read_event
      1.22            -0.1        1.14        perf-profile.children.cycles-pp.mutex_lock
      1.09            -0.1        1.02        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.16            -0.1        1.09        perf-profile.children.cycles-pp.pick_eevdf
      0.49 ±  3%      -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.update_curr_dl_se
      3.47            -0.1        3.41        perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.00            -0.1        0.94        perf-profile.children.cycles-pp.__switch_to
      0.74            -0.1        0.68        perf-profile.children.cycles-pp.__enqueue_entity
      0.50            -0.0        0.46        perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.90            -0.0        0.86        perf-profile.children.cycles-pp.prepare_to_wait_event
      0.13 ±  2%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__x64_sys_read
      1.00            -0.0        0.97        perf-profile.children.cycles-pp.copy_page_to_iter
      0.38            -0.0        0.34        perf-profile.children.cycles-pp.testcase
      0.65            -0.0        0.61        perf-profile.children.cycles-pp.mutex_unlock
      0.49            -0.0        0.46 ±  3%  perf-profile.children.cycles-pp.rep_movs_alternative
      0.85            -0.0        0.82        perf-profile.children.cycles-pp._copy_to_iter
      1.38            -0.0        1.35        perf-profile.children.cycles-pp.__switch_to_asm
      0.06            -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.psi_account_irqtime
      0.63            -0.0        0.60        perf-profile.children.cycles-pp.___perf_sw_event
      0.15 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__resched_curr
      0.56            -0.0        0.54        perf-profile.children.cycles-pp.__cond_resched
      0.44            -0.0        0.42        perf-profile.children.cycles-pp.finish_task_switch
      0.37            -0.0        0.35        perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.36            -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.child
      0.09 ±  4%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.mm_cid_get
      0.22 ±  2%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.dl_scaled_delta_exec
      0.08 ±  6%      +0.0        0.09        perf-profile.children.cycles-pp.__x64_sys_write
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.read@plt
      0.66            +0.0        0.68        perf-profile.children.cycles-pp.update_rq_clock
      0.22 ±  2%      +0.0        0.25        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.16 ±  3%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.dequeue_task
      0.21            +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.__calc_delta
      0.11 ±  6%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.blkcg_maybe_throttle_current
      0.32            +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.x64_sys_call
      0.71 ±  2%      +0.0        0.74        perf-profile.children.cycles-pp.vruntime_eligible
      0.70 ±  2%      +0.0        0.74 ±  2%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.82            +0.0        0.86        perf-profile.children.cycles-pp.file_update_time
      0.08 ±  4%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.sched_update_worker
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.arch_scale_cpu_capacity
      0.07            +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.__set_next_task_fair
      0.82            +0.1        0.89        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.cpuacct_account_field
      1.54            +0.1        1.64        perf-profile.children.cycles-pp.set_next_entity
      2.35            +0.1        2.46        perf-profile.children.cycles-pp.put_prev_entity
      1.30            +0.1        1.41        perf-profile.children.cycles-pp.touch_atime
      1.08            +0.1        1.19        perf-profile.children.cycles-pp.atime_needs_update
      0.58            +0.1        0.70 ±  2%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.27 ±  8%      +0.1        0.40 ±  5%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.07 ± 11%      +0.1        0.21 ±  5%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.26 ±  6%      +0.2        0.41 ±  8%  perf-profile.children.cycles-pp.cpuacct_charge
      1.01            +0.2        1.16        perf-profile.children.cycles-pp.current_time
      3.00            +0.2        3.17        perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.2        0.19 ±  4%  perf-profile.children.cycles-pp.__cgroup_account_cputime_field
     48.50            +0.2       48.74        perf-profile.children.cycles-pp.write
      7.40            +0.3        7.75        perf-profile.children.cycles-pp.__pick_next_task
      7.20            +0.4        7.55        perf-profile.children.cycles-pp.pick_next_task_fair
     19.93            +0.5       20.39        perf-profile.children.cycles-pp.pipe_read
     22.09            +0.5       22.59        perf-profile.children.cycles-pp.ksys_read
     20.98            +0.5       21.49        perf-profile.children.cycles-pp.vfs_read
     13.69            +0.6       14.25        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     52.30            +0.8       53.06        perf-profile.children.cycles-pp.do_syscall_64
     60.19            +0.8       60.96        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.78        perf-profile.children.cycles-pp.account_irqtime
     20.22            +1.1       21.35        perf-profile.children.cycles-pp.schedule
     19.84            +1.1       20.98        perf-profile.children.cycles-pp.__schedule
      6.15            -0.5        5.64        perf-profile.self.cycles-pp.entry_SYSCALL_64
     14.70            -0.3       14.36        perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.98            -0.2        1.78        perf-profile.self.cycles-pp.update_curr
      0.54            -0.1        0.43        perf-profile.self.cycles-pp.check_preempt_wakeup_fair
      1.68            -0.1        1.59        perf-profile.self.cycles-pp.pipe_read
      1.45            -0.1        1.37        perf-profile.self.cycles-pp.do_syscall_64
      1.06            -0.1        0.99        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.72            -0.1        0.64        perf-profile.self.cycles-pp.pick_eevdf
      0.61 ±  2%      -0.1        0.55        perf-profile.self.cycles-pp.try_to_wake_up
      3.45            -0.1        3.38        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.28 ±  3%      -0.0        0.23 ±  2%  perf-profile.self.cycles-pp.update_curr_dl_se
      0.09            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__x64_sys_read
      0.92            -0.0        0.87        perf-profile.self.cycles-pp.__switch_to
      0.49            -0.0        0.44        perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.50            -0.0        0.46        perf-profile.self.cycles-pp.prepare_to_wait_event
      0.53            -0.0        0.50        perf-profile.self.cycles-pp.update_rq_clock_task
      0.69            -0.0        0.66        perf-profile.self.cycles-pp.__enqueue_entity
      0.62            -0.0        0.58        perf-profile.self.cycles-pp.mutex_unlock
      0.28            -0.0        0.25 ±  2%  perf-profile.self.cycles-pp.testcase
      1.37            -0.0        1.34        perf-profile.self.cycles-pp.__switch_to_asm
      0.76            -0.0        0.73        perf-profile.self.cycles-pp.mutex_lock
      0.39            -0.0        0.37 ±  3%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.37            -0.0        0.35        perf-profile.self.cycles-pp.__cond_resched
      0.14 ±  3%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.__resched_curr
      0.32 ±  2%      -0.0        0.29        perf-profile.self.cycles-pp.finish_task_switch
      0.50            -0.0        0.48        perf-profile.self.cycles-pp.__get_user_8
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.mm_cid_get
      0.37            -0.0        0.35        perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.21            -0.0        0.20        perf-profile.self.cycles-pp.wakeup_preempt
      0.30            -0.0        0.28        perf-profile.self.cycles-pp.dequeue_task_fair
      0.08            +0.0        0.09        perf-profile.self.cycles-pp.kill_fasync
      0.14 ±  3%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.update_rq_clock
      0.08 ±  4%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.read@plt
      0.09            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.raw_spin_rq_unlock
      0.19            +0.0        0.22 ±  2%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.09 ±  7%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.blkcg_maybe_throttle_current
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.dequeue_task
      0.30            +0.0        0.32 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
      0.32            +0.0        0.34        perf-profile.self.cycles-pp.copy_page_from_iter
      0.12 ±  7%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.enqueue_task
      0.22            +0.0        0.25        perf-profile.self.cycles-pp.rseq_ip_fixup
      0.20            +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.__calc_delta
      0.24 ±  2%      +0.0        0.27 ±  7%  perf-profile.self.cycles-pp.perf_tp_event
      0.66            +0.0        0.69        perf-profile.self.cycles-pp.vruntime_eligible
      0.42 ±  2%      +0.0        0.46        perf-profile.self.cycles-pp.current_time
      0.42 ±  3%      +0.0        0.46 ±  2%  perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.cpuacct_account_field
      0.63 ±  3%      +0.1        0.69 ±  2%  perf-profile.self.cycles-pp.pick_task_fair
      0.05 ±  7%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__set_next_task_fair
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__x64_sys_write
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.arch_scale_cpu_capacity
      0.08 ±  6%      +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.sched_update_worker
      0.65            +0.1        0.71        perf-profile.self.cycles-pp.vfs_read
      0.76            +0.1        0.83        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.29            +0.1        0.36        perf-profile.self.cycles-pp.set_next_entity
      1.25 ±  2%      +0.1        1.33 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.20 ±  8%      +0.1        0.28 ±  6%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.36 ±  2%      +0.1        0.44        perf-profile.self.cycles-pp.put_prev_entity
      0.77            +0.1        0.87        perf-profile.self.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.11 ± 18%  perf-profile.self.cycles-pp.__cgroup_account_cputime_field
      0.56 ±  2%      +0.1        0.68 ±  2%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64_mg
      1.24 ±  3%      +0.1        1.36 ±  3%  perf-profile.self.cycles-pp.write
      0.07 ± 11%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      1.56            +0.1        1.70        perf-profile.self.cycles-pp.pipe_write
      0.25 ±  6%      +0.1        0.39 ±  8%  perf-profile.self.cycles-pp.cpuacct_charge
      0.00            +0.4        0.38 ±  3%  perf-profile.self.cycles-pp.account_irqtime




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


