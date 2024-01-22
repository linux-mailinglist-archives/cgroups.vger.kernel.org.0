Return-Path: <cgroups+bounces-1182-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956A835CD3
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 09:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448051F23172
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 08:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8FB22092;
	Mon, 22 Jan 2024 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzkLaOO0"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCEB2134B;
	Mon, 22 Jan 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912771; cv=fail; b=MmpEe09Xjr6M0hUQpdWo8zvUZxfSvLWO88WPgyfDiDP7EuynwDcKRgBKcWixSSWVlP1eq6mTtVyr3P41EtMo2bLV2xYlFPm0j1BRW9K7Gi8z0RzwVqyvcVkK8JIPoqFFfFJs60zyEESjWxuzhPd9o9XvqJdV0C9ZFN56g4oXpng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912771; c=relaxed/simple;
	bh=i+p7XXZ93edTbx5HJT+Kt+MzxlnEs9mzfrL/Pqi32ZE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=J2bDoLdWqC0CR+XY1oknPDig9tDyVY0uBT3GS0PKLDUS+E2NPK41wVIHNK1neDxIkLaCZz1cz99onPMET2dnzYR1n28B9+dw1PK5gWQ7+azcksK1niz2aKHg53pa6f0VTTgtMwP99TqZEG8tjs6cDh7ut0qA0x8jgL1+pR2oPIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzkLaOO0; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705912767; x=1737448767;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=i+p7XXZ93edTbx5HJT+Kt+MzxlnEs9mzfrL/Pqi32ZE=;
  b=bzkLaOO0heA3nTBlfvQcOIDTgh9BZ2X1FsCvYftOMFe4HKytJckhUX/u
   dALqJe9mWWEwgfDOY73LaidErW9/TX0LZJ+tTqwxGYGt8uZY1Xz6qeoSs
   /QUaIXp3efXPV3G3d8snl+Ek1F/LenD/zxOXrfb4lpqf4kXFlrYRCgMbB
   JosFenWoudi0MiN9C1F8yhB6xmbHyH8X1KciCVegqIo0VWJ87rqQqg+qP
   f71M/Iw9YalIKRQllEq2W7bpxGIPYjjfVhL2m0kG2C9HwriDqizHemzyg
   JeE8skD0aZuPTq2CqLWixRnt71j9IuM+iM/jZMp0pyMidfO4h3+MZa9sf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="19707775"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="19707775"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 00:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1222116"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 00:39:25 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 00:39:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 00:39:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 00:39:23 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 00:39:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEis6T7bhfs5XvYDnt4BtJgRdBzfHZo5HYH4TO4Wv4hgij2ZdhWXG/JdObwx4fgDkgvC1oDlGlvdXfaBirghlIaY5jIAqs6AWsYsocHSfg2zVhuCLwJbzDJTLBO8ju6AnRsJ7WFuMmbivz+Siap3DoCla0nDWjonezqKqLLMMoyPSfXeSpdn2Zlrju5ylxZFD+RW7Fuk/ZoXS+827LucaztHk/oupzpCIbjIhMOQ243ZEaGq4ixliexy4qKPK4FaWE2ZtZb2PhHj6putMqAqbCGPMqZr19ASe8A0GIVAnI9nNA+Tlx6dcL1agtP99q+fiRi4vFimX45fl9Rw3YbX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IjRtHpVoYJDagfwCKQwtVDkb0AciA5Uvzm0WyVWQB4=;
 b=PmXMpNxOya8TnfixhZSV2ZpV6TnjwemNg8YGGRb9y+z3bkHA2MS7LEEajzJiI0zNZANgM7KLATV5o7W87OiHvuJHb4CdvlsChARdKA5qREdBEYmXj4DO1nZwDW5Owy7rEeUbGxnfuL7dWqE7kHIzaM/3oUWWrNwPFqpv1bJfQEVir422If7NpGlucGR2hleE3fOCMT8aEP67hdryYrjqhlfZkWRcdzWSoUTGy2j7xHsTFYdNz72hzQCnnDNUDww+jxiquEeYSZw8EAzNusFm+Yh2pXhD88rBrR0lRhCCZmAIHqvoriChF5m92y0zn55qi2T3YM8D4IejuWrfTa/msg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6567.namprd11.prod.outlook.com (2603:10b6:806:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 08:39:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 08:39:18 +0000
Date: Mon, 22 Jan 2024 16:39:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	Shakeel Butt <shakeelb@google.com>, Chris Li <chrisl@kernel.org>, Greg Thelen
	<gthelen@google.com>, Ivan Babrou <ivan@cloudflare.com>, Michal Hocko
	<mhocko@kernel.org>, Michal Koutny <mkoutny@suse.com>, Muchun Song
	<muchun.song@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Tejun Heo
	<tj@kernel.org>, Waiman Long <longman@redhat.com>, Wei Xu
	<weixugc@google.com>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [mm]  8d59d2214c:  vm-scalability.throughput -36.6%
 regression
Message-ID: <202401221624.cb53a8ca-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3f5d3d-6272-4afa-46f6-08dc1b259f31
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hme9X37jCCgc4EgUSm7HODTvGONH2w5sGJi5DTnsi/b2hRsxL20O2GGnyasV9vVXdPSyu/oASNkaL71Kl3gZc/8ZsRqpmOYS+MA+5iXK2XkkRQ+tOMq4eoA70TvFrKprLeIvB24phGJjRiVUo6eH7kxYC0NNOc3q6UmEYsrIZkVaJbhlHtTc4in+cjki0TQnjVdnA93atU9fG2566lPQTyW7cFWzgk9y86Fwvn/1GPovsQBSZ94NjWk/91bKVgjizakr68/+87+uLoQZRfpcuNwGnUMEaHxpdfdK6ViFVTRCxokS9umV5mIzzd0jMHXLfjhWV0GR7co1uxujr/nmMHxJfN+RQB4uTSVa+Li3rz9pDxB/EDNWhdLmY9Iahq9OQx1R68SV+z//j58YORmUyqD5Sx4aoDOkDKyefU2X+NBDDEW0Qbwx+bjhKk74D5IwlrZaZCd8Bl7lORa/njiGPz29mUsXpjXNYnVL3Xg76kR2jGFE8zoWPW8xyTZjqXYo/+eq9m/dMEZx3CiwjG+/u3Fo6EqR2eRbvl5YmZCQ163j2RVJ9voM32ktXYq7DoCyJCX7WSZ+FyMryuBgShvOem5W24uzT/dWH5C0qHhxyNWYZsVmrrhtI5XDZck59rPNmCfczSjWXwVBp3RQ+GYeL2xHc3tnaVqQfUV0O6yQPVTzBP7XSeyM+mwgGDxMLl0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(230373577357003)(230473577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6666004)(6512007)(107886003)(26005)(2616005)(1076003)(6506007)(86362001)(38100700002)(82960400001)(36756003)(41300700001)(83380400001)(7416002)(478600001)(30864003)(2906002)(5660300002)(66476007)(19627235002)(966005)(6486002)(4326008)(8936002)(66556008)(8676002)(66946007)(316002)(6916009)(54906003)(559001)(579004)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/LQJSVAIy2VydkBnH5zgckymzYsBHcFbsoo2z4geA5sKs8v8Wd/XdGKUVb?=
 =?iso-8859-1?Q?qnvNTRBl9rr6rotexHtUk2EhRuXvFZGDs76yTjonziO8gecoXm274B7As7?=
 =?iso-8859-1?Q?M3g8lpi4Q8s+rtIe+EkmUkD+RjCpdTXUFyBqInunzcdBrpA+24vZ+9fhnk?=
 =?iso-8859-1?Q?CnZBRmOgmuU5Sk2z1umHj0ejcYeC4pCP3EhXiXCPLtdc9qiPaktsPb7ry7?=
 =?iso-8859-1?Q?Dfy81PG/yw8d925z6nkEh+PCEpA89uVJ/XvD2ppPBS0NnXmgswyXwRd6Gf?=
 =?iso-8859-1?Q?mpkpWT9MgDLCTp7Ctej1l3aUA0QD3GCFBK6V76FGpZ/hpLPawWwJAF4M/n?=
 =?iso-8859-1?Q?i+8ywM07N+eI16pYv7yVWcnt3MCezIJrMkV7VTrlXA4WGyvNSFyHzX//Up?=
 =?iso-8859-1?Q?h2SWcvDryE2R9RyfR69QZW2EqYiItMQRqGFwQbnExWtvaqo21S+Zg1Zrh1?=
 =?iso-8859-1?Q?A9FlZiTZPQ1vSry1zaHdC57PNWHaTttOXJZaXImDGyKz9cx2bRBXDDqeTN?=
 =?iso-8859-1?Q?Sw4OGsILeLtDPsq/h4iEZ5XAICm7aMvIjcd3HqDf/c4KmanaYzCPnCiv7N?=
 =?iso-8859-1?Q?unhaWOTI3t/w3cNXMODlASDoFHOH2MY83AR8/gH4c1cUgsLhVhkQ0TXblt?=
 =?iso-8859-1?Q?rY+SLEnA45qH3caUk5ip5tHnNsKnGHShiDxPZCqSyRWt0HkyUTV9VbZ9Lw?=
 =?iso-8859-1?Q?ltyerOLf88rY5bfLWAWXJrUYviRW9WJnyGjqW0MImJPhQQGWFNNbD7l0XW?=
 =?iso-8859-1?Q?DuRbDuhZPk/Q90Z6X8XbIqjRUo7OiWQQapMNXMf+tX684iEHs6xf2u7O/a?=
 =?iso-8859-1?Q?/qcEG+4l/pjVId3Rnum5JLEpClOBSCN6MFa1yPbEUXG65ymZFcTody+Bek?=
 =?iso-8859-1?Q?4Bh7zTokBumpXk91N7JLf27kBUfNBwnI6f/zMyzXgfoKWm7AwtvmY36Mb/?=
 =?iso-8859-1?Q?zcnMLQsyCGaf1kB3C6qj/D2R0di8FL/JsbP9b1khu81sgbITidtwRmM7/G?=
 =?iso-8859-1?Q?tBIxJGrtK/jzZ/T6xWMleQ51yT4yLWPxq/nj30gaF7jfcpIMAdc5eTBFKa?=
 =?iso-8859-1?Q?DNNE5e5C4rKa4NYtUfdDwNKE0CFct9RrhVOIfYp6nHGZkFsqCbdulS6zGT?=
 =?iso-8859-1?Q?Rkv2PpzTsW8zEvS1eY8P9PjA+eCv0NMsojRyE4/X1qkpOY91nq3Hx3OEaY?=
 =?iso-8859-1?Q?ZnkKqYhOOTk70MqB2LMTkkh7cS7++TgBYB75PWjU7R/9lMOfrBJf/47icz?=
 =?iso-8859-1?Q?+S47mW7myhm1Sk+KOsvONw5JndsuDCTcMQJKcKF4vl0sXgkufGNFc2XixD?=
 =?iso-8859-1?Q?W5cNL5ja7zG7yHdhEfSn9KN8w2Z7YS2fuDEnN5xJax08C/s/E7WJWVMSFq?=
 =?iso-8859-1?Q?SYm1TxK1cjdspgVogk32nJrTdGzi/tOAf71tCz3Ld/92uQjXaEXNiDmy8V?=
 =?iso-8859-1?Q?7I6gGCHn6Zg3AaQ8i/3GlY2So///sCen+dGsgpMSR7fUWejaiEOCKMFKcP?=
 =?iso-8859-1?Q?mGDQo7X+JgyQ0i2kyLAnm4DmMLt61p3OKz/4yER+r0cyciJy/Gov0imfAg?=
 =?iso-8859-1?Q?x8/CvLd2bt/9evHYGSRAbug6X5Ute8RLNXp2hsWfwXvCeKBPqR1zUnVMEE?=
 =?iso-8859-1?Q?GkakqcJfYQ86PAbVv1C/whDBotl4aqQG9vQqdOWos8/OgePg3dRQV3EA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3f5d3d-6272-4afa-46f6-08dc1b259f31
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:39:18.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCr1whbhX3Otz+Q5Bt8qWua6FJvNRHIDZ1bR/zDo/KtyqUTHuujnyS5cu5t8xvJbGLJuuwZx8T4GZ1oHrQq5qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6567
X-OriginatorOrg: intel.com



hi, Yosry Ahmed,

per your suggestion in
https://lore.kernel.org/all/CAJD7tkameJBrJQxRj+ibKL6-yd-i0wyoyv2cgZdh3ZepA1p7wA@mail.gmail.com/
"I think it would be useful to know if there are
regressions/improvements in other microbenchmarks, at least to
investigate whether they represent real regressions."

we still report below two regressions to you just FYI what we observed in our
microbenchmark tests.
(we still captured will-it-scale::fallocate regression but ignore here per
your commit message)


Hello,

kernel test robot noticed a -36.6% regression of vm-scalability.throughput on:


commit: 8d59d2214c2362e7a9d185d80b613e632581af7b ("mm: memcg: make stats flushing threshold per-memcg")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: vm-scalability
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	runtime: 300s
	size: 1T
	test: lru-shm
	cpufreq_governor: performance

test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/

In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops -32.3% regression                                     |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                                   |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=process                                                                                       |
|                  | nr_task=50%                                                                                        |
|                  | test=tlb_flush2                                                                                    |
+------------------+----------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401221624.cb53a8ca-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240122/202401221624.cb53a8ca-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/300s/1T/lkp-cpl-4sp2/lru-shm/vm-scalability

commit: 
  e0bf1dc859 ("mm: memcg: move vmstats structs definition above flushing code")
  8d59d2214c ("mm: memcg: make stats flushing threshold per-memcg")

e0bf1dc859fdd08e 8d59d2214c2362e7a9d185d80b6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.01           +86.7%       0.02        vm-scalability.free_time
    946447           -37.8%     588327        vm-scalability.median
 2.131e+08           -36.6%  1.351e+08        vm-scalability.throughput
    284.74            +6.3%     302.62        vm-scalability.time.elapsed_time
    284.74            +6.3%     302.62        vm-scalability.time.elapsed_time.max
     30485           +14.8%      34987        vm-scalability.time.involuntary_context_switches
      1893           +43.6%       2718        vm-scalability.time.percent_of_cpu_this_job_got
      3855           +67.7%       6467        vm-scalability.time.system_time
      1537           +14.5%       1760        vm-scalability.time.user_time
    120009            -5.6%     113290        vm-scalability.time.voluntary_context_switches
      6.46            +3.5        9.95        mpstat.cpu.all.sys%
     21.22           +38.8%      29.46        vmstat.procs.r
      0.01 ± 20%   +1887.0%       0.18 ±203%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 28%     +63.3%       0.01 ± 29%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    113624 ±  5%     +14.0%     129566 ±  3%  meminfo.Active
    113476 ±  5%     +14.0%     129417 ±  3%  meminfo.Active(anon)
   3987746           +46.0%    5821636        meminfo.Mapped
     16345           +14.6%      18729        meminfo.PageTables
    474.17 ±  3%     -88.9%      52.50 ±125%  perf-c2c.DRAM.local
    483.17 ±  5%     -79.3%      99.83 ± 70%  perf-c2c.DRAM.remote
      1045 ±  5%     -71.9%     294.00 ± 63%  perf-c2c.HITM.local
    119.50 ± 10%     -78.8%      25.33 ± 20%  perf-c2c.HITM.remote
    392.33           +35.4%     531.17        turbostat.Avg_MHz
     10.35            +3.7       14.00        turbostat.Busy%
     90.56            -3.7       86.86        turbostat.C1%
      0.28 ±  5%     -31.5%       0.19        turbostat.IPC
    481.33            +2.5%     493.38        turbostat.PkgWatt
    999019 ±  3%     +44.4%    1442651 ±  2%  numa-meminfo.node0.Mapped
   1005687 ±  4%     +44.1%    1449402 ±  3%  numa-meminfo.node1.Mapped
      3689 ±  3%     +21.7%       4490 ±  7%  numa-meminfo.node1.PageTables
    980589 ±  2%     +42.3%    1395777 ±  2%  numa-meminfo.node2.Mapped
     96484 ±  5%     +22.0%     117715 ±  4%  numa-meminfo.node3.Active
     96430 ±  5%     +22.1%     117694 ±  4%  numa-meminfo.node3.Active(anon)
    991367 ±  3%     +42.7%    1414337 ±  4%  numa-meminfo.node3.Mapped
    251219 ±  3%     +44.8%     363745 ±  2%  numa-vmstat.node0.nr_mapped
    253252 ±  2%     +44.6%     366087 ±  3%  numa-vmstat.node1.nr_mapped
    927.67 ±  3%     +21.9%       1130 ±  7%  numa-vmstat.node1.nr_page_table_pages
    248171 ±  2%     +42.5%     353541 ±  4%  numa-vmstat.node2.nr_mapped
     24188 ±  5%     +21.6%      29410 ±  4%  numa-vmstat.node3.nr_active_anon
    245825 ±  2%     +45.5%     357622 ±  3%  numa-vmstat.node3.nr_mapped
      1038 ± 11%     +17.8%       1224 ±  6%  numa-vmstat.node3.nr_page_table_pages
     24188 ±  5%     +21.6%      29410 ±  4%  numa-vmstat.node3.nr_zone_active_anon
     28376 ±  5%     +14.0%      32338 ±  3%  proc-vmstat.nr_active_anon
    993504           +46.6%    1456136        proc-vmstat.nr_mapped
      4060           +15.5%       4691        proc-vmstat.nr_page_table_pages
     28376 ±  5%     +14.0%      32338 ±  3%  proc-vmstat.nr_zone_active_anon
 1.066e+09            -2.0%  1.045e+09        proc-vmstat.numa_hit
 1.065e+09            -2.0%  1.044e+09        proc-vmstat.numa_local
      5659            +5.6%       5978        proc-vmstat.unevictable_pgs_culled
  34604288            +3.7%   35898496        proc-vmstat.unevictable_pgs_scanned
   1223376 ± 14%    +119.1%    2680582 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.avg
   1673909 ± 14%     +97.6%    3308254 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.max
    810795 ± 15%    +145.8%    1993289 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.min
    156233 ±  8%     +55.1%     242331 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.stddev
   1223376 ± 14%    +119.1%    2680582 ±  9%  sched_debug.cfs_rq:/.min_vruntime.avg
   1673909 ± 14%     +97.6%    3308254 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
    810795 ± 15%    +145.8%    1993289 ±  9%  sched_debug.cfs_rq:/.min_vruntime.min
    156233 ±  8%     +55.1%     242331 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
    126445 ±  3%     -11.0%     112493 ±  4%  sched_debug.cpu.avg_idle.stddev
      1447 ± 15%     +32.0%       1910 ±  9%  sched_debug.cpu.nr_switches.min
      0.71           +13.4%       0.80        perf-stat.i.MPKI
 2.343e+10            -7.9%  2.157e+10        perf-stat.i.branch-instructions
      0.36            -0.0        0.35        perf-stat.i.branch-miss-rate%
  30833194            -7.3%   28584190        perf-stat.i.branch-misses
     26.04            -1.4       24.66        perf-stat.i.cache-miss-rate%
  51345490 ±  3%     +40.7%   72258633 ±  3%  perf-stat.i.cache-misses
 1.616e+08 ±  6%     +58.6%  2.562e+08 ±  6%  perf-stat.i.cache-references
      1.29            +9.4%       1.42        perf-stat.i.cpi
 8.394e+10           +33.7%  1.122e+11        perf-stat.i.cpu-cycles
    505.77            -2.6%     492.52        perf-stat.i.cpu-migrations
      0.03            +0.0        0.03 ±  2%  perf-stat.i.dTLB-load-miss-rate%
 2.335e+10            -7.4%  2.162e+10        perf-stat.i.dTLB-loads
      0.03            +0.0        0.03        perf-stat.i.dTLB-store-miss-rate%
   3948344            -8.0%    3633633        perf-stat.i.dTLB-store-misses
 6.549e+09            -7.0%   6.09e+09        perf-stat.i.dTLB-stores
  17546602           -22.8%   13551001        perf-stat.i.iTLB-load-misses
   2552560            -2.6%    2485876        perf-stat.i.iTLB-loads
 8.367e+10            -7.5%  7.737e+10        perf-stat.i.instructions
      4706            +7.7%       5070        perf-stat.i.instructions-per-iTLB-miss
      0.81           -12.0%       0.72        perf-stat.i.ipc
      1.59 ±  3%     -22.3%       1.23 ±  4%  perf-stat.i.major-faults
      0.37           +34.2%       0.49        perf-stat.i.metric.GHz
    233.98            -6.9%     217.90        perf-stat.i.metric.M/sec
   3619177            -9.5%    3276556        perf-stat.i.minor-faults
     74.28            +4.8       79.04        perf-stat.i.node-load-miss-rate%
   2898733 ±  4%     +49.0%    4320557        perf-stat.i.node-load-misses
   1928237 ±  4%     -11.9%    1698426        perf-stat.i.node-loads
  13383344 ±  2%      +4.7%   14013398 ±  3%  perf-stat.i.node-stores
   3619179            -9.5%    3276558        perf-stat.i.page-faults
      0.61 ±  3%     +52.5%       0.94 ±  3%  perf-stat.overall.MPKI
     31.95 ±  2%      -3.6       28.34 ±  3%  perf-stat.overall.cache-miss-rate%
      1.00           +45.0%       1.45        perf-stat.overall.cpi
      0.07            +0.0        0.08 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
     87.62            -2.6       85.05        perf-stat.overall.iTLB-load-miss-rate%
      4778           +20.2%       5745        perf-stat.overall.instructions-per-iTLB-miss
      1.00           -31.0%       0.69        perf-stat.overall.ipc
     59.75 ±  3%     +11.8       71.59        perf-stat.overall.node-load-miss-rate%
      5145            +1.8%       5239        perf-stat.overall.path-length
 2.405e+10            -6.3%  2.252e+10        perf-stat.ps.branch-instructions
  31203502            -6.4%   29219514        perf-stat.ps.branch-misses
  52696784 ±  3%     +43.4%   75547948 ±  3%  perf-stat.ps.cache-misses
 1.652e+08 ±  6%     +61.7%  2.672e+08 ±  7%  perf-stat.ps.cache-references
 8.584e+10           +36.3%   1.17e+11        perf-stat.ps.cpu-cycles
    506.29            -2.0%     496.05        perf-stat.ps.cpu-migrations
 2.395e+10            -5.9%  2.254e+10        perf-stat.ps.dTLB-loads
   4059043            -6.2%    3806002        perf-stat.ps.dTLB-store-misses
 6.688e+09            -5.7%  6.308e+09        perf-stat.ps.dTLB-stores
  17944396           -21.8%   14028927        perf-stat.ps.iTLB-load-misses
   2534093            -2.7%    2465233        perf-stat.ps.iTLB-loads
 8.575e+10            -6.0%  8.059e+10        perf-stat.ps.instructions
      1.60 ±  3%     -23.2%       1.23 ±  4%  perf-stat.ps.major-faults
   3726053            -7.7%    3439511        perf-stat.ps.minor-faults
   2942507 ±  4%     +52.0%    4472428        perf-stat.ps.node-load-misses
   1980077 ±  4%     -10.4%    1774633        perf-stat.ps.node-loads
  13780660 ±  2%      +6.8%   14716100 ±  3%  perf-stat.ps.node-stores
   3726055            -7.7%    3439513        perf-stat.ps.page-faults
     37.11            -6.7       30.40 ±  6%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     21.14            -3.8       17.36 ±  7%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     21.05            -3.8       17.29 ±  7%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     21.05            -3.8       17.29 ±  7%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     21.05            -3.8       17.29 ±  7%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     21.00            -3.8       17.25 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     20.70            -3.7       17.00 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     20.69            -3.7       16.99 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     20.64            -3.7       16.95 ±  7%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      9.51 ±  3%      -1.9        7.57 ±  2%  perf-profile.calltrace.cycles-pp.do_rw_once
      4.54            -1.4        3.19        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      2.83            -0.9        1.96        perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      3.90            -0.6        3.34 ±  5%  perf-profile.calltrace.cycles-pp.clear_page_erms.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault
      4.44 ±  6%      -0.5        3.98 ±  3%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      1.17 ±  3%      -0.4        0.73 ±  6%  perf-profile.calltrace.cycles-pp.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
      1.42 ±  2%      -0.4        0.99 ±  2%  perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
      1.32 ±  2%      -0.4        0.91        perf-profile.calltrace.cycles-pp.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      1.19 ±  2%      -0.4        0.82        perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.96 ±  2%      -0.3        0.65 ±  2%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
      0.98 ±  2%      -0.3        0.68 ±  4%  perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.do_access
      1.21            +0.5        1.69 ±  5%  perf-profile.calltrace.cycles-pp.__munmap
      1.21            +0.5        1.69 ±  5%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.21            +0.5        1.69 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.21            +0.5        1.69 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.21            +0.5        1.69 ±  5%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      1.21            +0.5        1.69 ±  5%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.21            +0.5        1.69 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      1.20            +0.5        1.68 ±  5%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.20            +0.5        1.68 ±  5%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.20            +0.5        1.68 ±  5%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      1.20            +0.5        1.69 ±  5%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      1.18            +0.5        1.67 ±  6%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      0.84 ±  2%      +0.6        1.43 ±  5%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.58 ±  3%      +0.6        1.18 ±  5%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.8        0.79 ±  4%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.page_remove_rmap.zap_pte_range.zap_pmd_range
      0.00            +1.0        1.02 ±  5%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      0.00            +1.1        1.08 ±  4%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range
      0.00            +1.5        1.46 ±  5%  perf-profile.calltrace.cycles-pp.__count_memcg_events.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.29 ±  3%      +1.9        5.19        perf-profile.calltrace.cycles-pp.finish_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      3.02 ±  4%      +2.0        5.00        perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_read_fault.do_fault.__handle_mm_fault
      2.84 ±  4%      +2.0        4.86        perf-profile.calltrace.cycles-pp.folio_add_file_rmap_range.set_pte_range.finish_fault.do_read_fault.do_fault
      2.73 ±  4%      +2.0        4.77        perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_add_file_rmap_range.set_pte_range.finish_fault.do_read_fault
      1.48 ±  4%      +2.1        3.56 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.folio_add_file_rmap_range.set_pte_range.finish_fault
      0.57 ±  4%      +2.8        3.35 ±  2%  perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.96 ±  5%      +2.9        4.86 ±  2%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      3.65 ±  2%      +3.1        6.77 ±  2%  perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
      0.80 ±  4%      +3.1        3.92 ±  3%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      2.68 ±  3%      +3.4        6.08 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      7.71 ±  6%      +3.9       11.66 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
     67.18            +6.3       73.46 ±  3%  perf-profile.calltrace.cycles-pp.do_access
      1.46 ±  9%      +7.1        8.57 ± 16%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      1.50 ±  9%      +7.1        8.61 ± 16%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.38 ± 10%      +7.1        8.51 ± 16%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     51.46            +7.6       59.08 ±  3%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
      2.98 ±  5%      +7.7       10.66 ± 14%  perf-profile.calltrace.cycles-pp.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
      2.84 ±  6%      +7.7       10.56 ± 14%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
     34.18            +8.5       42.68 ±  4%  perf-profile.calltrace.cycles-pp.__do_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
     34.14            +8.5       42.64 ±  4%  perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_read_fault.do_fault.__handle_mm_fault
     33.95            +8.6       42.51 ±  4%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault.do_fault
     42.88            +8.8       51.70 ±  4%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     42.34            +9.0       51.30 ±  4%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     42.29            +9.0       51.28 ±  4%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     45.07            +9.6       54.62 ±  4%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     44.95            +9.6       54.53 ±  4%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     43.72            +9.9       53.64 ±  4%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     17.28 ±  2%     +13.8       31.05 ±  6%  perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault
     21.14            -3.8       17.36 ±  7%  perf-profile.children.cycles-pp.cpu_startup_entry
     21.14            -3.8       17.36 ±  7%  perf-profile.children.cycles-pp.do_idle
     21.14            -3.8       17.36 ±  7%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     21.09            -3.8       17.33 ±  7%  perf-profile.children.cycles-pp.cpuidle_idle_call
     21.05            -3.8       17.29 ±  7%  perf-profile.children.cycles-pp.start_secondary
     20.79            -3.7       17.07 ±  7%  perf-profile.children.cycles-pp.cpuidle_enter
     20.78            -3.7       17.07 ±  7%  perf-profile.children.cycles-pp.cpuidle_enter_state
     20.72            -3.7       17.02 ±  7%  perf-profile.children.cycles-pp.acpi_idle_enter
     20.71            -3.7       17.01 ±  7%  perf-profile.children.cycles-pp.acpi_safe_halt
     20.79            -3.6       17.19 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     11.52            -3.1        8.42        perf-profile.children.cycles-pp.do_rw_once
      4.62            -1.4        3.24        perf-profile.children.cycles-pp.filemap_map_pages
      2.89            -0.9        2.00        perf-profile.children.cycles-pp.next_uptodate_folio
      3.98            -0.6        3.39 ±  5%  perf-profile.children.cycles-pp.clear_page_erms
      4.46 ±  6%      -0.5        3.99 ±  3%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      1.18 ±  4%      -0.4        0.74 ±  6%  perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      1.44 ±  2%      -0.4        1.00 ±  2%  perf-profile.children.cycles-pp.shmem_alloc_folio
      1.40            -0.4        0.99        perf-profile.children.cycles-pp.alloc_pages_mpol
      1.27            -0.4        0.90        perf-profile.children.cycles-pp.__alloc_pages
      1.01 ±  2%      -0.3        0.68        perf-profile.children.cycles-pp.get_page_from_freelist
      1.02 ±  2%      -0.3        0.70 ±  4%  perf-profile.children.cycles-pp.sync_regs
      0.77 ±  2%      -0.3        0.51        perf-profile.children.cycles-pp.rmqueue
      0.81 ±  2%      -0.2        0.60        perf-profile.children.cycles-pp.__perf_sw_event
      0.53 ±  3%      -0.2        0.34 ±  2%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.68 ±  2%      -0.2        0.50 ±  5%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.65 ±  6%      -0.2        0.47 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.47 ±  3%      -0.2        0.29 ±  2%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.65 ±  2%      -0.2        0.49        perf-profile.children.cycles-pp.___perf_sw_event
      0.64 ±  4%      -0.1        0.49 ±  5%  perf-profile.children.cycles-pp.xas_load
      0.54            -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.49 ±  2%      -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.54 ±  5%      -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.xas_find
      0.39 ±  4%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.39 ±  3%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.xas_descend
      0.32 ±  4%      -0.1        0.22 ±  8%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.30 ±  3%      -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.mas_walk
      0.20 ± 13%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.shmem_recalc_inode
      0.26 ±  2%      -0.1        0.19 ±  3%  perf-profile.children.cycles-pp.filemap_get_entry
      0.18 ±  5%      -0.1        0.12 ±  5%  perf-profile.children.cycles-pp.xas_find_conflict
      0.28 ±  4%      -0.1        0.22 ±  8%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.28 ±  4%      -0.1        0.22 ±  8%  perf-profile.children.cycles-pp.do_execveat_common
      0.28 ±  4%      -0.1        0.22 ±  8%  perf-profile.children.cycles-pp.execve
      0.29 ±  3%      -0.1        0.24 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.16 ±  5%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.error_entry
      0.14 ±  5%      -0.0        0.09 ±  8%  perf-profile.children.cycles-pp.__percpu_counter_limited_add
      0.15 ±  5%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.inode_add_bytes
      0.07 ±  6%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.__folio_throttle_swaprate
      0.10            -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.18 ±  7%      -0.0        0.14 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.16 ±  5%      -0.0        0.12        perf-profile.children.cycles-pp.handle_pte_fault
      0.17 ±  7%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.xas_start
      0.14 ±  6%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map
      0.07 ±  5%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.policy_nodemask
      0.16 ±  4%      -0.0        0.13 ± 12%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.19 ±  4%      -0.0        0.16 ±  8%  perf-profile.children.cycles-pp.bprm_execve
      0.11 ±  9%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.down_read_trylock
      0.16 ±  6%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.11 ±  6%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.up_read
      0.15 ±  7%      -0.0        0.12 ± 13%  perf-profile.children.cycles-pp.folio_unlock
      0.10 ±  4%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__libc_fork
      0.07 ±  6%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.ksys_read
      0.10 ±  3%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.kernel_clone
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.09 ±  5%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.08 ±  8%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.do_filp_open
      0.08 ±  8%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.path_openat
      0.07            -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.vfs_read
      0.09 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__do_sys_clone
      0.10 ±  6%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.08 ±  8%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.do_sys_openat2
      0.07 ±  5%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.copy_process
      0.16 ±  5%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.exec_binprm
      0.10 ±  6%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.16 ±  4%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.search_binary_handler
      0.08            -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.09 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp._compound_head
      0.15 ±  5%      -0.0        0.13 ±  7%  perf-profile.children.cycles-pp.xas_create
      0.15 ±  4%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.load_elf_binary
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.05 ±  8%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.25 ±  2%      +0.0        0.30 ±  4%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.mod_objcg_state
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.tlb_finish_mmu
      1.25            +0.5        1.72 ±  5%  perf-profile.children.cycles-pp.unmap_vmas
      1.24            +0.5        1.71 ±  5%  perf-profile.children.cycles-pp.zap_pte_range
      1.24            +0.5        1.71 ±  5%  perf-profile.children.cycles-pp.unmap_page_range
      1.24            +0.5        1.71 ±  5%  perf-profile.children.cycles-pp.zap_pmd_range
      1.21            +0.5        1.69 ±  5%  perf-profile.children.cycles-pp.__munmap
      1.22            +0.5        1.71 ±  5%  perf-profile.children.cycles-pp.__vm_munmap
      1.21            +0.5        1.70 ±  5%  perf-profile.children.cycles-pp.__x64_sys_munmap
      1.25            +0.5        1.74 ±  5%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      1.25            +0.5        1.74 ±  5%  perf-profile.children.cycles-pp.do_vmi_munmap
      1.22            +0.5        1.72 ±  5%  perf-profile.children.cycles-pp.unmap_region
      0.85 ±  2%      +0.6        1.44 ±  5%  perf-profile.children.cycles-pp.lru_add_fn
      0.60 ±  3%      +0.6        1.20 ±  4%  perf-profile.children.cycles-pp.page_remove_rmap
      3.30 ±  3%      +1.9        5.20        perf-profile.children.cycles-pp.finish_fault
      3.04 ±  4%      +2.0        5.01        perf-profile.children.cycles-pp.set_pte_range
      2.85 ±  4%      +2.0        4.87        perf-profile.children.cycles-pp.folio_add_file_rmap_range
      1.97 ±  5%      +2.9        4.88 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      3.69 ±  2%      +3.1        6.80 ±  2%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      7.74 ±  6%      +3.9       11.69 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.80 ±  4%      +4.0        4.85 ±  3%  perf-profile.children.cycles-pp.__count_memcg_events
      6.12 ±  3%      +6.1       12.18        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      2.99 ±  3%      +6.6        9.56 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
     61.44            +6.7       68.11 ±  3%  perf-profile.children.cycles-pp.do_access
      1.58 ±  9%      +7.1        8.72 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.45 ±  9%      +7.2        8.63 ± 16%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.53 ±  9%      +7.2        8.72 ± 16%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      2.98 ±  5%      +7.7       10.67 ± 14%  perf-profile.children.cycles-pp.folio_add_lru
      2.86 ±  6%      +7.8       10.63 ± 14%  perf-profile.children.cycles-pp.folio_batch_move_lru
     49.12            +8.3       57.47 ±  3%  perf-profile.children.cycles-pp.asm_exc_page_fault
     34.19            +8.5       42.68 ±  4%  perf-profile.children.cycles-pp.__do_fault
     34.15            +8.5       42.65 ±  4%  perf-profile.children.cycles-pp.shmem_fault
     33.99            +8.6       42.54 ±  4%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
     43.06            +8.8       51.84 ±  4%  perf-profile.children.cycles-pp.__handle_mm_fault
     42.43            +8.9       51.37 ±  4%  perf-profile.children.cycles-pp.do_fault
     42.38            +9.0       51.34 ±  4%  perf-profile.children.cycles-pp.do_read_fault
     45.26            +9.5       54.78 ±  4%  perf-profile.children.cycles-pp.exc_page_fault
     45.15            +9.5       54.69 ±  4%  perf-profile.children.cycles-pp.do_user_addr_fault
     43.91            +9.9       53.80 ±  4%  perf-profile.children.cycles-pp.handle_mm_fault
     17.31 ±  2%     +13.8       31.07 ±  5%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
     12.24            -4.5        7.76 ±  3%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
     17.96            -3.3       14.66 ±  4%  perf-profile.self.cycles-pp.acpi_safe_halt
     10.95            -3.2        7.74        perf-profile.self.cycles-pp.do_rw_once
      5.96            -1.4        4.58 ±  2%  perf-profile.self.cycles-pp.do_access
      2.40            -0.8        1.64        perf-profile.self.cycles-pp.next_uptodate_folio
      3.92            -0.6        3.36 ±  5%  perf-profile.self.cycles-pp.clear_page_erms
      4.40 ±  6%      -0.5        3.95 ±  3%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      1.52 ±  2%      -0.4        1.10 ±  2%  perf-profile.self.cycles-pp.filemap_map_pages
      1.02 ±  2%      -0.3        0.70 ±  4%  perf-profile.self.cycles-pp.sync_regs
      0.50 ±  7%      -0.2        0.27 ±  5%  perf-profile.self.cycles-pp.shmem_inode_acct_blocks
      0.63 ±  5%      -0.2        0.46 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.42 ±  2%      -0.1        0.27 ±  2%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.52            -0.1        0.38 ±  4%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.56 ±  2%      -0.1        0.42        perf-profile.self.cycles-pp.___perf_sw_event
      0.31 ±  3%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.38 ±  4%      -0.1        0.28        perf-profile.self.cycles-pp.__handle_mm_fault
      0.36 ±  4%      -0.1        0.26 ±  2%  perf-profile.self.cycles-pp.xas_descend
      0.30 ±  2%      -0.1        0.22 ±  2%  perf-profile.self.cycles-pp.mas_walk
      0.33 ±  3%      -0.1        0.26 ± 10%  perf-profile.self.cycles-pp.lru_add_fn
      0.20 ±  3%      -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.21 ±  5%      -0.1        0.15 ±  6%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.26 ±  9%      -0.1        0.20 ± 15%  perf-profile.self.cycles-pp.xas_store
      0.16 ±  7%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.__perf_sw_event
      0.18 ±  2%      -0.1        0.13 ±  5%  perf-profile.self.cycles-pp.__alloc_pages
      0.22 ±  4%      -0.1        0.17 ±  4%  perf-profile.self.cycles-pp.handle_mm_fault
      0.20 ±  8%      -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.xas_find
      0.15 ±  6%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.error_entry
      0.17 ±  2%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.17 ±  6%      -0.0        0.13 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.22 ±  4%      -0.0        0.18 ±  9%  perf-profile.self.cycles-pp.xas_load
      0.23 ±  4%      -0.0        0.19 ± 10%  perf-profile.self.cycles-pp.zap_pte_range
      0.12 ±  7%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.__percpu_counter_limited_add
      0.14 ±  3%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.rmqueue
      0.15 ±  6%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.15 ±  2%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.12 ±  7%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.folio_add_lru
      0.16 ±  7%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.xas_start
      0.06 ±  7%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.finish_fault
      0.16 ±  4%      -0.0        0.12 ± 12%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.11 ±  8%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.13 ±  6%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__pte_offset_map
      0.11 ±  9%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.down_read_trylock
      0.12 ±  3%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.do_read_fault
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.16 ±  4%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.11 ±  6%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.shmem_alloc_and_add_folio
      0.08 ±  8%      -0.0        0.05        perf-profile.self.cycles-pp.xas_find_conflict
      0.12 ±  4%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.folio_add_file_rmap_range
      0.10 ±  6%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.up_read
      0.12 ±  4%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.09 ±  4%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.exc_page_fault
      0.13 ±  6%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.page_remove_rmap
      0.08            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.19 ±  5%      -0.0        0.17 ±  5%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.09 ±  6%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.set_pte_range
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp._compound_head
      0.08            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.05 ±  8%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.propagate_protected_usage
      2.93 ±  4%      +0.4        3.35 ±  3%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.77 ±  7%      +1.5        2.23 ±  3%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.75 ±  4%      +4.0        4.80 ±  3%  perf-profile.self.cycles-pp.__count_memcg_events
      2.83 ±  3%      +6.6        9.40 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      1.45 ±  9%      +7.2        8.63 ± 16%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/tlb_flush2/will-it-scale

commit: 
  e0bf1dc859 ("mm: memcg: move vmstats structs definition above flushing code")
  8d59d2214c ("mm: memcg: make stats flushing threshold per-memcg")

e0bf1dc859fdd08e 8d59d2214c2362e7a9d185d80b6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4.05            -1.2        2.81        mpstat.cpu.all.usr%
    193.83 ±  6%     +69.3%     328.17 ±  8%  perf-c2c.DRAM.local
      1216 ±  8%     +27.1%       1546 ±  6%  perf-c2c.DRAM.remote
    150.33 ± 13%     -40.0%      90.17 ± 13%  perf-c2c.HITM.remote
      0.04           -25.0%       0.03        turbostat.IPC
    316.16            -1.5%     311.47        turbostat.PkgWatt
     30.54            +4.9%      32.04        turbostat.RAMWatt
   2132437           -32.3%    1444430        will-it-scale.52.processes
     41008           -32.3%      27776        will-it-scale.per_process_ops
   2132437           -32.3%    1444430        will-it-scale.workload
 3.113e+08 ±  3%     -31.7%  2.125e+08 ±  4%  numa-numastat.node0.local_node
 3.114e+08 ±  3%     -31.7%  2.126e+08 ±  4%  numa-numastat.node0.numa_hit
 3.322e+08 ±  2%     -32.5%  2.243e+08 ±  3%  numa-numastat.node1.local_node
 3.323e+08 ±  2%     -32.5%  2.243e+08 ±  3%  numa-numastat.node1.numa_hit
 3.114e+08 ±  3%     -31.7%  2.126e+08 ±  4%  numa-vmstat.node0.numa_hit
 3.113e+08 ±  3%     -31.7%  2.125e+08 ±  4%  numa-vmstat.node0.numa_local
 3.323e+08 ±  2%     -32.5%  2.243e+08 ±  3%  numa-vmstat.node1.numa_hit
 3.322e+08 ±  2%     -32.5%  2.243e+08 ±  3%  numa-vmstat.node1.numa_local
      0.00 ± 19%     -61.1%       0.00 ± 31%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    217.07 ± 11%     -46.4%     116.39 ± 23%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    218.50 ±  6%     +19.1%     260.33 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
    217.06 ± 11%     -46.4%     116.38 ± 23%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
 6.436e+08           -32.1%  4.369e+08        proc-vmstat.numa_hit
 6.435e+08           -32.1%  4.368e+08        proc-vmstat.numa_local
 6.432e+08           -32.1%  4.368e+08        proc-vmstat.pgalloc_normal
 1.286e+09           -32.1%  8.726e+08        proc-vmstat.pgfault
 6.432e+08           -32.1%  4.367e+08        proc-vmstat.pgfree
    170696 ±  8%      +3.4%     176515 ±  8%  sched_debug.cpu.clock.avg
    170703 ±  8%      +3.4%     176522 ±  8%  sched_debug.cpu.clock.max
    170689 ±  8%      +3.4%     176508 ±  8%  sched_debug.cpu.clock.min
    169431 ±  8%      +3.4%     175248 ±  8%  sched_debug.cpu.clock_task.avg
    169630 ±  8%      +3.4%     175429 ±  8%  sched_debug.cpu.clock_task.max
    162542 ±  8%      +3.5%     168260 ±  8%  sched_debug.cpu.clock_task.min
    170690 ±  8%      +3.4%     176508 ±  8%  sched_debug.cpu_clk
    170117 ±  8%      +3.4%     175938 ±  8%  sched_debug.ktime
    171259 ±  8%      +3.4%     177078 ±  8%  sched_debug.sched_clk
      4.06           +80.8%       7.34        perf-stat.i.MPKI
 4.066e+09           -23.3%   3.12e+09        perf-stat.i.branch-instructions
      0.57            -0.0        0.55        perf-stat.i.branch-miss-rate%
  23478297           -25.0%   17605102        perf-stat.i.branch-misses
     17.25            +7.0       24.27        perf-stat.i.cache-miss-rate%
  82715093 ±  2%     +35.9%  1.124e+08        perf-stat.i.cache-misses
 4.795e+08 ±  2%      -3.4%   4.63e+08        perf-stat.i.cache-references
      7.14           +32.9%       9.49        perf-stat.i.cpi
    134.85            -1.2%     133.29        perf-stat.i.cpu-migrations
      1760 ±  2%     -26.5%       1294        perf-stat.i.cycles-between-cache-misses
      0.26            -0.0        0.24        perf-stat.i.dTLB-load-miss-rate%
  13461491           -31.7%    9190211        perf-stat.i.dTLB-load-misses
 5.141e+09           -24.1%  3.902e+09        perf-stat.i.dTLB-loads
      0.45            -0.0        0.44        perf-stat.i.dTLB-store-miss-rate%
  12934403           -32.2%    8773143        perf-stat.i.dTLB-store-misses
 2.841e+09           -29.9%  1.992e+09        perf-stat.i.dTLB-stores
     14.76            +1.4       16.18 ±  4%  perf-stat.i.iTLB-load-miss-rate%
   7454399 ±  2%     -22.7%    5760387 ±  4%  perf-stat.i.iTLB-load-misses
  43026423           -30.6%   29840650        perf-stat.i.iTLB-loads
 2.042e+10           -24.7%  1.538e+10        perf-stat.i.instructions
      0.14           -24.6%       0.11        perf-stat.i.ipc
    815.65           -20.2%     651.03        perf-stat.i.metric.K/sec
    120.43           -24.3%      91.11        perf-stat.i.metric.M/sec
   4264808           -32.2%    2892980        perf-stat.i.minor-faults
  11007315 ±  2%     +39.7%   15375516        perf-stat.i.node-load-misses
   1459152 ±  6%     +45.1%    2116827 ±  5%  perf-stat.i.node-loads
   7872989 ±  2%     -26.2%    5812458        perf-stat.i.node-store-misses
   4264808           -32.2%    2892980        perf-stat.i.page-faults
      4.05           +80.4%       7.31        perf-stat.overall.MPKI
      0.58            -0.0        0.57        perf-stat.overall.branch-miss-rate%
     17.25            +7.0       24.27        perf-stat.overall.cache-miss-rate%
      7.13           +32.7%       9.46        perf-stat.overall.cpi
      1759 ±  2%     -26.5%       1294        perf-stat.overall.cycles-between-cache-misses
      0.26            -0.0        0.23        perf-stat.overall.dTLB-load-miss-rate%
      0.45            -0.0        0.44        perf-stat.overall.dTLB-store-miss-rate%
     14.77            +1.4       16.18 ±  4%  perf-stat.overall.iTLB-load-miss-rate%
      0.14           -24.7%       0.11        perf-stat.overall.ipc
   2882666           +11.2%    3206246        perf-stat.overall.path-length
 4.052e+09           -23.3%   3.11e+09        perf-stat.ps.branch-instructions
  23421504           -25.0%   17574476        perf-stat.ps.branch-misses
  82419384 ±  2%     +35.9%   1.12e+08        perf-stat.ps.cache-misses
 4.778e+08 ±  2%      -3.4%  4.614e+08        perf-stat.ps.cache-references
    134.44            -1.1%     132.98        perf-stat.ps.cpu-migrations
  13415064           -31.7%    9160067        perf-stat.ps.dTLB-load-misses
 5.124e+09           -24.1%   3.89e+09        perf-stat.ps.dTLB-loads
  12889609           -32.2%    8744145        perf-stat.ps.dTLB-store-misses
 2.831e+09           -29.9%  1.986e+09        perf-stat.ps.dTLB-stores
   7428050 ±  2%     -22.7%    5741276 ±  4%  perf-stat.ps.iTLB-load-misses
  42877049           -30.6%   29741122        perf-stat.ps.iTLB-loads
 2.035e+10           -24.7%  1.533e+10        perf-stat.ps.instructions
   4250034           -32.2%    2883410        perf-stat.ps.minor-faults
  10968228 ±  2%     +39.7%   15322266        perf-stat.ps.node-load-misses
   1454274 ±  6%     +45.1%    2109746 ±  5%  perf-stat.ps.node-loads
   7845298 ±  2%     -26.2%    5792864        perf-stat.ps.node-store-misses
   4250034           -32.2%    2883410        perf-stat.ps.page-faults
 6.147e+12           -24.7%  4.631e+12        perf-stat.total.instructions
     26.77            -1.8       24.93 ±  3%  perf-profile.calltrace.cycles-pp.intel_idle_ibrs.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     26.75            -1.8       24.92 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     26.75            -1.8       24.92 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     26.84            -1.8       25.00 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     26.75            -1.8       24.92 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     26.75            -1.8       24.92 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     26.75            -1.8       24.92 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     27.05            -1.8       25.29 ±  3%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     13.02 ±  2%      -1.4       11.60 ±  4%  perf-profile.calltrace.cycles-pp.testcase
      5.54 ±  5%      -1.0        4.52 ±  3%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_list.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.zap_page_range_single
      1.37 ±  2%      -0.9        0.51 ± 58%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__madvise
     10.38 ±  3%      -0.8        9.54 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
      2.38 ±  2%      -0.8        1.63 ±  3%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_list.release_pages.tlb_batch_pages_flush
      4.02 ±  3%      -0.7        3.32 ±  3%  perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge_list.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
      1.92 ±  4%      -0.4        1.49 ±  2%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.testcase
      1.36 ±  2%      -0.4        0.99        perf-profile.calltrace.cycles-pp.__irqentry_text_end.testcase
      1.30 ± 10%      -0.4        0.94 ±  6%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      1.50 ± 11%      -0.3        1.19 ±  5%  perf-profile.calltrace.cycles-pp.uncharge_folio.__mem_cgroup_uncharge_list.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
      1.13 ±  3%      -0.3        0.83        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise
      0.71 ±  3%      -0.3        0.43 ± 44%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__madvise
      1.02 ±  3%      -0.3        0.75        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior
      0.97 ±  3%      -0.3        0.72        perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single
      0.77 ±  2%      -0.2        0.58 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.71 ±  2%      -0.1        0.60 ±  3%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_list.release_pages
      1.20            +0.1        1.34        perf-profile.calltrace.cycles-pp.unmap_page_range.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      1.10 ±  2%      +0.2        1.28        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.zap_page_range_single.madvise_vma_behavior.do_madvise
      1.04 ±  2%      +0.2        1.24        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single.madvise_vma_behavior
      0.83            +0.2        1.07 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.zap_page_range_single
      0.81 ±  2%      +0.3        1.08        perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single
      0.88 ± 10%      +0.3        1.16 ±  4%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.71 ±  2%      +0.3        1.00        perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range
      0.76 ±  3%      +0.3        1.09 ±  2%  perf-profile.calltrace.cycles-pp.folio_add_new_anon_rmap.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.73 ±  3%      +0.3        1.07 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_add_new_anon_rmap.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.00            +0.6        0.55 ±  2%  perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault
      6.60 ±  4%      +0.6        7.18 ±  3%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
      6.54 ±  4%      +0.6        7.13 ±  3%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.00            +0.7        0.74 ±  3%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.zap_page_range_single
      0.00            +0.8        0.79 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.page_remove_rmap.zap_pte_range.zap_pmd_range
      0.00            +0.8        0.79 ±  3%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.lru_add_fn.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain
      0.00            +0.8        0.80 ±  3%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.folio_add_new_anon_rmap.do_anonymous_page.__handle_mm_fault
      5.80 ±  5%      +0.8        6.60 ±  3%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.00            +0.8        0.82        perf-profile.calltrace.cycles-pp.__count_memcg_events.uncharge_batch.__mem_cgroup_uncharge_list.release_pages.tlb_batch_pages_flush
      0.69 ±  4%      +0.9        1.59 ±  2%  perf-profile.calltrace.cycles-pp.__count_memcg_events.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     30.43            +1.1       31.57        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
     29.22            +1.5       30.69        perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise
     29.05            +1.5       30.56        perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior
     22.56 ±  2%      +2.3       24.87        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.zap_page_range_single
     22.36 ±  2%      +2.3       24.70        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
     22.11 ±  2%      +2.4       24.55        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush
     22.70            +2.6       25.35        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.zap_page_range_single
     22.38            +2.7       25.08        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain
     24.10            +2.7       26.82        perf-profile.calltrace.cycles-pp.lru_add_drain.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
     24.09            +2.7       26.82        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.zap_page_range_single.madvise_vma_behavior.do_madvise
     24.07            +2.7       26.79        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.zap_page_range_single.madvise_vma_behavior
     22.14            +2.8       24.93        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
     59.76            +2.9       62.64        perf-profile.calltrace.cycles-pp.__madvise
     57.63            +3.5       61.10        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
     57.27            +3.6       60.85        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     56.41            +3.8       60.20        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     56.37            +3.8       60.17        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     55.94            +3.9       59.88        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     55.85            +4.0       59.82        perf-profile.calltrace.cycles-pp.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
     26.75            -1.8       24.92 ±  2%  perf-profile.children.cycles-pp.start_secondary
     26.98            -1.8       25.22 ±  3%  perf-profile.children.cycles-pp.intel_idle_ibrs
     27.05            -1.8       25.29 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
     27.05            -1.8       25.29 ±  3%  perf-profile.children.cycles-pp.do_idle
     27.05            -1.8       25.29 ±  3%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     27.05            -1.8       25.29 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
     27.05            -1.8       25.29 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
     27.05            -1.8       25.29 ±  3%  perf-profile.children.cycles-pp.cpuidle_idle_call
     13.66 ±  2%      -1.3       12.38        perf-profile.children.cycles-pp.testcase
      5.55 ±  5%      -1.0        4.52 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      2.39 ±  2%      -0.8        1.63 ±  3%  perf-profile.children.cycles-pp.page_counter_uncharge
      4.03 ±  3%      -0.7        3.32 ±  3%  perf-profile.children.cycles-pp.uncharge_batch
      1.96 ±  4%      -0.4        1.52 ±  2%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      1.30            -0.4        0.94 ±  2%  perf-profile.children.cycles-pp.error_entry
      1.36 ±  2%      -0.4        0.99        perf-profile.children.cycles-pp.__irqentry_text_end
      1.30 ± 10%      -0.4        0.94 ±  6%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      1.51 ± 11%      -0.3        1.19 ±  5%  perf-profile.children.cycles-pp.uncharge_folio
      1.14 ±  3%      -0.3        0.84        perf-profile.children.cycles-pp.flush_tlb_mm_range
      1.02 ±  3%      -0.3        0.75        perf-profile.children.cycles-pp.flush_tlb_func
      0.98 ±  3%      -0.3        0.72        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.73 ±  2%      -0.2        0.52 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.69 ±  2%      -0.2        0.50 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.79 ±  2%      -0.2        0.60 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.51 ±  2%      -0.1        0.38 ±  2%  perf-profile.children.cycles-pp.sync_regs
      0.41 ±  3%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.__perf_sw_event
      0.44 ±  2%      -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.72 ±  2%      -0.1        0.61 ±  3%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.39            -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.35 ±  3%      -0.1        0.25 ±  3%  perf-profile.children.cycles-pp.__alloc_pages
      0.34 ±  2%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.30 ±  3%      -0.1        0.21 ±  5%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.32 ±  2%      -0.1        0.24        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.12 ±  4%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.down_read
      0.25 ±  3%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.mas_walk
      0.25 ±  3%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.17 ±  4%      -0.1        0.11 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.14 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.clear_page_erms
      0.17 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.find_vma_prev
      0.13 ±  2%      -0.0        0.09        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.11 ±  4%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.__cond_resched
      0.13 ±  2%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.unmap_vmas
      0.11 ±  3%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.free_unref_page_list
      0.06            -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.09 ±  7%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.free_swap_cache
      0.09 ±  7%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__munmap
      0.09 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock
      0.09 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.handle_pte_fault
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.07 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.rmqueue
      0.07 ±  9%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.unmap_region
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__vm_munmap
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.try_charge_memcg
      1.27            +0.1        1.40        perf-profile.children.cycles-pp.unmap_page_range
      1.17            +0.2        1.32        perf-profile.children.cycles-pp.zap_pmd_range
      1.12            +0.2        1.29        perf-profile.children.cycles-pp.zap_pte_range
      0.84            +0.2        1.07 ±  2%  perf-profile.children.cycles-pp.lru_add_fn
      0.81 ±  2%      +0.3        1.08        perf-profile.children.cycles-pp.page_remove_rmap
      0.89 ± 10%      +0.3        1.16 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.77 ±  3%      +0.3        1.09 ±  2%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      6.62 ±  4%      +0.6        7.19 ±  3%  perf-profile.children.cycles-pp.exc_page_fault
      6.56 ±  4%      +0.6        7.14 ±  3%  perf-profile.children.cycles-pp.do_user_addr_fault
      1.44 ±  2%      +0.6        2.08 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      5.80 ±  5%      +0.8        6.61 ±  3%  perf-profile.children.cycles-pp.handle_mm_fault
     30.44            +1.1       31.58        perf-profile.children.cycles-pp.tlb_finish_mmu
     29.23            +1.5       30.69        perf-profile.children.cycles-pp.tlb_batch_pages_flush
     29.19            +1.5       30.66        perf-profile.children.cycles-pp.release_pages
      1.63 ±  5%      +1.5        3.13 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.32 ±  4%      +1.6        2.97 ±  2%  perf-profile.children.cycles-pp.__count_memcg_events
     24.12            +2.7       26.84        perf-profile.children.cycles-pp.lru_add_drain
     24.12            +2.7       26.84        perf-profile.children.cycles-pp.lru_add_drain_cpu
     24.09            +2.7       26.81        perf-profile.children.cycles-pp.folio_batch_move_lru
     59.80            +2.9       62.68        perf-profile.children.cycles-pp.__madvise
     57.82            +3.4       61.26        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     57.44            +3.5       60.99        perf-profile.children.cycles-pp.do_syscall_64
     56.41            +3.8       60.20        perf-profile.children.cycles-pp.__x64_sys_madvise
     56.37            +3.8       60.17        perf-profile.children.cycles-pp.do_madvise
     55.94            +3.9       59.88        perf-profile.children.cycles-pp.madvise_vma_behavior
     55.85            +4.0       59.82        perf-profile.children.cycles-pp.zap_page_range_single
     45.26            +5.0       50.23        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     44.75            +5.0       49.80        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     44.26            +5.2       49.50        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     26.98            -1.8       25.22 ±  3%  perf-profile.self.cycles-pp.intel_idle_ibrs
      1.67 ±  3%      -0.6        1.02 ±  3%  perf-profile.self.cycles-pp.page_counter_uncharge
      1.92 ±  5%      -0.4        1.49 ±  2%  perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      1.47 ±  2%      -0.4        1.06 ±  2%  perf-profile.self.cycles-pp.testcase
      1.36 ±  2%      -0.4        0.99        perf-profile.self.cycles-pp.__irqentry_text_end
      1.30            -0.4        0.94        perf-profile.self.cycles-pp.error_entry
      1.30 ± 10%      -0.4        0.94 ±  6%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      1.18 ±  8%      -0.3        0.86 ±  6%  perf-profile.self.cycles-pp.uncharge_batch
      1.50 ± 11%      -0.3        1.19 ±  5%  perf-profile.self.cycles-pp.uncharge_folio
      0.98 ±  3%      -0.3        0.72        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.71 ±  2%      -0.2        0.51 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.69 ±  2%      -0.2        0.50 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.50 ±  4%      -0.2        0.30 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.75 ±  2%      -0.2        0.56 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.51 ±  2%      -0.1        0.38 ±  2%  perf-profile.self.cycles-pp.sync_regs
      0.35 ±  3%      -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.36 ±  5%      -0.1        0.24 ±  2%  perf-profile.self.cycles-pp.lru_add_fn
      0.39 ±  2%      -0.1        0.27 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.72 ±  2%      -0.1        0.61 ±  3%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.45            -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.release_pages
      0.54 ±  4%      -0.1        0.45 ±  4%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.30 ±  2%      -0.1        0.21 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.52 ±  5%      -0.1        0.43 ±  5%  perf-profile.self.cycles-pp.folio_lruvec_lock_irqsave
      0.28 ±  3%      -0.1        0.21        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.25 ±  3%      -0.1        0.18 ±  4%  perf-profile.self.cycles-pp.mas_walk
      0.24 ±  2%      -0.1        0.17 ±  4%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.16 ±  4%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.zap_pte_range
      0.14 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.clear_page_erms
      0.08 ±  6%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.__cond_resched
      0.13            -0.0        0.09        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.14 ±  5%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.handle_mm_fault
      0.11 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.08 ±  6%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__perf_sw_event
      0.07 ± 10%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.tlb_finish_mmu
      0.09 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.free_swap_cache
      0.08 ±  7%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.09 ±  8%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock
      0.07 ±  7%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.10 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.page_remove_rmap
      0.08 ±  6%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.08 ±  6%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.do_anonymous_page
      0.08 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.unmap_page_range
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__alloc_pages
      0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.do_madvise
      0.07 ± 10%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.up_read
      1.58 ±  6%      +1.5        3.09 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      1.27 ±  5%      +1.7        2.93 ±  2%  perf-profile.self.cycles-pp.__count_memcg_events
     44.25            +5.2       49.50        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


