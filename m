Return-Path: <cgroups+bounces-516-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250A97F480B
	for <lists+cgroups@lfdr.de>; Wed, 22 Nov 2023 14:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479BD1C2096E
	for <lists+cgroups@lfdr.de>; Wed, 22 Nov 2023 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E3C5676A;
	Wed, 22 Nov 2023 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBR9nxZt"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1E3D4A;
	Wed, 22 Nov 2023 05:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700660622; x=1732196622;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=K36d5zVWQjR+Q0eqQkwcaa0IrngCa+j7JhoccIM7wHs=;
  b=cBR9nxZtmAA63kgPKd+107uR8aXSAzZWSzbf3/WCo3NmULdoG82JxeT/
   3a7PREn6UwCG1XssrjeXN7LKnc0F4IzvtjwrXNeM5U/W9LDeGiCozPX+N
   N2YCDWgKQMdpsctJp1dQ2ShJrjirOaOyKOCK8FBodl6ORfUSbQe+fQ+N6
   MWDLHSb/4QPf7X2DLP2u+u+Dhm+vrRggsxj7bHAq0Xp5Zfj1fnTxIhYcw
   mbJMCdpN7006mu+YMPqzgHNF1q+qJHZyzi2wEoU962rBGzhIvCO5cFGxD
   Prq5DedSuFJNmPesZmCYHkDrxWIWT/Tvz/85ysQDAqtmxJHF5XUU4X8Up
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391824699"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="391824699"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 05:43:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910803147"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="910803147"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 05:43:21 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 05:43:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 05:43:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 05:43:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 05:43:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtmzDFxFW3hTz9J36pEpdFmRoNi36C8c06uMYpgP/10g3NBGqDnPWWPjBnGRRboC8vMX3tbUuWYidZb+95aQ6DnECYgl/VXZphWN8fhAtRJG+gGjOpAHGR4KVnYd+Y7x7jdkZk2oLOGzSYI5mSlWneo0lsu6mxai5WrwH7WS2gigzE5pylJ53bw2slkLMXyoJRPA40mzhSmMTS14cFDAPvumaeR+TZE5PQjWohD7OTFfzWFuD0SMhvs1zn/jiDP1dEr9tHeD9imMDtn6mWIiMyje7+QDQ0Oo1fb/+m4XDdos6aUYmjiWrIVRz9iDzApmosH2J/kvLm0Rkplkn7EiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIlPySyaepQQ4JrMQnd1aO0nRutKj/juClGZ6tOHp7g=;
 b=P50ormTdLU/mftcVsJHi/r+oBRg7ee/zU+IVa5vmkAUjFSe/L4vqD18OtuGkYTtp141kyGPhtTz6LDa4rSwwa2ziCNZSvghpR4QZffUM9ALMtBE2jrTjCgJW4pnnYB/ym0ez6FiKHWwVGQF9/Utjq+I0ZIgfW86BVmSbM2KmQKOUufGvZ12/A+l2JDxadNBCDh/Yn5nSQ0lboFiPOnXuCOr3v9fIFBxIeZp+mUacu4aZ351JLVmHo4BX7FpksPJftFwHyH2bVDZrmLCKApVlRZWyi+uHt2xcBC8oYticDC9gWDCMdjX+aBQYMiE+2ICOgLPJhMr7mHoNRqXjRkKM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7843.namprd11.prod.outlook.com (2603:10b6:610:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:43:12 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 13:43:12 +0000
Date: Wed, 22 Nov 2023 21:42:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Domenico Cerasuolo
	<cerasuolodomenico@gmail.com>, <linux-kernel@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, "Michal
 Hocko" <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, Ivan
 Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, Michal
 =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Waiman Long
	<longman@redhat.com>, <kernel-team@cloudflare.com>, Wei Xu
	<weixugc@google.com>, Greg Thelen <gthelen@google.com>, Yosry Ahmed
	<yosryahmed@google.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3 5/5] mm: memcg: restore subtree stats flushing
Message-ID: <202311221505.65236274-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231116022411.2250072-6-yosryahmed@google.com>
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6bd3ff-bb47-477a-5ac6-08dbeb60f7ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJjunwn7Y1eEfwN3P/lJjHh/mARYFJSXHYZ563gLOGU0dGbyoBX5cvT79LmXlJdiz9q2Ot3Vd59gjTUUdBJ26Kd0iCk2mo1GpQ4O9cER0v2c8anCPPNpB49mbjl/KeDtiaoXZcFO4Qipb8LMLtSUMb88ha3EHEuH4Dea+7nNRa0zfamBL1BSUTonuImWQn9A0fXVoXHD2f0D13ZfuVhLhEka1YtDwjjdcwjmhqbd1TG7wi99CbYfMQPOtcDzp3awd2Xz8LSAsX75ha/Kb7/jiHURPP6gtb7cBiO+HbGIn7m+pOvRgWw1DTCgbvJU7cIiJyWC+G+YEhc1U2pDnFZeBrhjC5oz48Y1RKGJr+bV3YpFWM7evsjY4py5qUKqvXp31lKQeogQBz78HbtNb6pBBJ9gxyQDkhAe0HkuVeNMgcP1MJ6+ujf+rqQeTTpCZrBLHc7CiouF1jVn6FsN8JFU/5jO2behEre5++/fswWKZA1toF3IfGLPC6uAVgpzCR3YFwo5VFq8RhFCNRTwqXmOQ1kUlrkQXPcj+pX4XiljeAhIO/9+LstQdGWiz3UEHoAjZVDpwzmSwf3UahVCJRMhEQ37X9K8iMZ9+Q5plZcThDDveNlpftOhlhCrWZjWpOVh/ozKm3tkEJJEJRHnyeWnJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230473577357003)(230373577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(7416002)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(30864003)(66556008)(316002)(54906003)(6916009)(66946007)(66476007)(478600001)(966005)(26005)(107886003)(6486002)(1076003)(36756003)(6512007)(6666004)(6506007)(2616005)(86362001)(83380400001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NPpBGm46l+PJrJDhS2/qsBB2nfKrgukhDoFkemb2QvVHGCl4jVOSzjRT4c?=
 =?iso-8859-1?Q?D6fQiHUeaielkStoHNdEMu29Uq3Xq6btBGp7DJn8ecB6ZWKnNj+jVzvbVt?=
 =?iso-8859-1?Q?UDB0SY3T0cO3BNU4OlB7QG4snwCMgqD/eF/PNZBod+XGUAusDq+bhaE4P0?=
 =?iso-8859-1?Q?8y0XaX9J7FNbAj0gsbwvGR5gR5j9rOHPq2Sii6LAnYobSTJKZDHN3RTEXx?=
 =?iso-8859-1?Q?7a4Ki+OqLOvOpa4dGUOfbe6HtXR83IsrMUfXh47TyrCdRoMPwA/5n3bs4h?=
 =?iso-8859-1?Q?olEuLhmVWRoTYABTFLS2Dt57PMta4j8bSvPp7SZXuiVsnAO97Z5zlNJPlW?=
 =?iso-8859-1?Q?NvHWyd1dVDJ9KuwJVQMWI43o9KDMzwhC14a29nKGJDE51pfqFduEoVM6H2?=
 =?iso-8859-1?Q?pNcm1Jx9Pv2vc3KsUIew2rcuVYvkwgUddtFu9YI/pFYR012eZ+m/z1X7PQ?=
 =?iso-8859-1?Q?RRbflByW8hjtZXvXCP/f/L+J18D/a3nEWncQGFwyH80CI+wlXMQGUqv6Bx?=
 =?iso-8859-1?Q?GjQO9zWe6F8i9bibbuOJK65i5JsjTtSVyLOnFbV0KWPA+zJwQZcicD6g0/?=
 =?iso-8859-1?Q?5Vz94IRUB204CyhYyFqXOOYaEwGzqz5KnQNNChm7/47SEgG1cHuqphAMk2?=
 =?iso-8859-1?Q?2SlSfOaiF93EUdGJhb97hcD0/n9/Bd12yBYAZLRwAOhoSiNLzGh1hs5tyF?=
 =?iso-8859-1?Q?hh0Eh7oiPbVjEfwguL5rxmtntvXxWVUTeT0Xabbk9opYZ8njTU9ppuC2LT?=
 =?iso-8859-1?Q?omc1/nNysvioBIV4593/+y2i7T/13Aqx7HkumXNFIbueHK81nB5tIh2z2i?=
 =?iso-8859-1?Q?GAwBJjB4nClN/2wvVUyBiUVvgx0RBAtlgXnRu38LOJ35mADs3zkVyR5RT5?=
 =?iso-8859-1?Q?pu2+UsfijIitWOCGeDsbA9UXexZ9/9TylCcJjWSQte77BHenkZwKKfuNhu?=
 =?iso-8859-1?Q?UU1vG4qmw0UqFCWyLVtxLhM9Ra1dZEAcMus6pP6AtVPv0iiZQ/ZL2US709?=
 =?iso-8859-1?Q?khqyFPX+eu2bpOsjXcyKATYa/DXeto763r7pNyRdh/gVjfIqYrG1HJ+eIT?=
 =?iso-8859-1?Q?OfwQO2DbHYwsGK+plfnLd080pFemy3Pm35ar1ETq4NIKYp5piGuhqhCTa5?=
 =?iso-8859-1?Q?wdcwsaKXKWU12nSzPkMgFp+mGTibalDzK5XN2Wp8ZVgVMELkf+c8r30Nv9?=
 =?iso-8859-1?Q?F+YtK0BLziDWZdC/QEtUops8pNy1SqwRk2Skzy5OOFZJ4ghLOzSpHVsV8Y?=
 =?iso-8859-1?Q?yrvQkfWWUNvusNvsHHsWwvwHL2Kc8yUNLoO1LwlWEBscV3zKf023XdKsyr?=
 =?iso-8859-1?Q?gNJO8eVmBUHSRpQUjp7OJaf+PH3/C0JIxeukojWUucSMwzvsa/zEDeGyng?=
 =?iso-8859-1?Q?6tIC/wjy9Q7L8dRkKG07WTG8WMlOxi1KslQ8zeJcv13atmPXoXxTKyc+cE?=
 =?iso-8859-1?Q?pwUSlU+KOXqU5WHm4QG0bwqtOXgCyKusZZ7BHsp1UdIYeN252XIFqRQHdi?=
 =?iso-8859-1?Q?r8RfIYcgtyO8mGYK5yjQdv3dgb50KAcdr0TmbZa0+dka3uQjzMCd8L7AGH?=
 =?iso-8859-1?Q?pKsGBcw+1AMSYxX3W3Lmb4RCnCerVHgxSvJ7tWH26cnsbh7GzHYtV4faoj?=
 =?iso-8859-1?Q?PhNoW4FrVF3kQ/FPU5jY4bEgkqXR8WCE+t/JrKwyX5iYIn+yia/+Yeuw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6bd3ff-bb47-477a-5ac6-08dbeb60f7ff
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:43:11.6974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4MSlOGl2rNXXEk3hBa20AIOmxfxNPJ0VDyJBzAEftVbfh7OYhs7eFezwqCPKvs0PAgtlIvd7RT7SpD76ZecUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7843
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -3.7% regression of aim7.jobs-per-min on:


commit: f6eccb430010201d3c155b73035f3bf755fe7697 ("[PATCH v3 5/5] mm: memcg: restore subtree stats flushing")
url: https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-memcg-change-flush_next_time-to-flush_last_time/20231116-103300
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20231116022411.2250072-6-yosryahmed@google.com/
patch subject: [PATCH v3 5/5] mm: memcg: restore subtree stats flushing

testcase: aim7
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	disk: 1BRD_48G
	fs: ext4
	test: disk_rr
	load: 3000
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311221505.65236274-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231122/202311221505.65236274-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1BRD_48G/ext4/x86_64-rhel-8.3/3000/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp2/disk_rr/aim7

commit: 
  4c86da8ea2 ("mm: workingset: move the stats flush into workingset_test_recent()")
  f6eccb4300 ("mm: memcg: restore subtree stats flushing")

4c86da8ea2d2f784 f6eccb430010201d3c155b73035 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     15513 ± 14%     +17.4%      18206 ±  7%  numa-vmstat.node1.nr_mapped
    616938            -3.7%     593885        aim7.jobs-per-min
    149804 ±  4%     +17.6%     176189 ±  6%  aim7.time.involuntary_context_switches
      2310            +6.3%       2455        aim7.time.system_time
  24960256 ±  9%     -14.1%   21429987 ±  7%  perf-stat.i.branch-misses
   1357010 ± 14%     -22.6%    1050646 ± 10%  perf-stat.i.dTLB-load-misses
      0.20 ±  8%      -0.0        0.16 ±  7%  perf-stat.overall.branch-miss-rate%
      2.80            +5.7%       2.96        perf-stat.overall.cpi
      1506            +7.9%       1624 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.36            -5.4%       0.34        perf-stat.overall.ipc
  24383919 ±  8%     -14.5%   20853721 ±  7%  perf-stat.ps.branch-misses
      0.00 ±223%   +2700.0%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 35%   +1454.2%       0.06 ± 54%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 13%   +3233.3%       0.18 ± 41%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ± 30%   +5900.0%       0.31 ± 47%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00 ±141%    +337.5%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.00 ±  9%   +2843.5%       0.11 ±116%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00 ±223%    +660.0%       0.01 ± 16%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  9%     -41.3%       0.00 ± 11%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.20 ±206%   +3311.9%       6.66 ± 72%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.02 ± 41%  +1.8e+05%      28.67 ± 53%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ± 52%  +41275.8%       2.28 ± 72%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.01 ± 23%  +2.8e+05%      20.56 ± 65%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.01 ± 11%    +142.9%       0.01 ± 76%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.00 ±141%    +412.5%       0.01 ± 15%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.01 ± 42%    +177.3%       0.02 ± 66%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 20%  +1.3e+05%      12.95 ±105%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.07 ±131%    +289.2%       0.27 ± 55%  perf-sched.total_sch_delay.average.ms
      0.39 ±  5%    +307.4%       1.58 ± 22%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.33 ± 46%   +5674.0%      18.79 ± 73%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.83 ±223%  +41660.0%     348.00 ± 74%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     11.25 ± 64%    +225.6%      36.62 ± 45%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.81 ± 44%  +1.1e+05%     912.56 ± 92%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.61 ±223%  +11430.9%      69.86 ± 55%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.44 ± 50%   +1120.7%      17.58 ± 49%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.06 ±204%   +6992.9%       4.16 ± 91%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.38 ±  5%    +265.2%       1.40 ± 21%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.57 ±141%   +1413.0%       8.59 ±110%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.00 ±223%  +3.8e+06%      25.42 ±143%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.35 ± 24%   +5215.2%      18.72 ± 73%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1.03 ± 70%   +1610.0%      17.59 ± 49%  perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      2.82 ±223%   +6949.3%     198.44 ± 60%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.69 ± 45%   +4345.1%     119.46 ± 71%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.10 ±212%  +10364.1%      10.59 ±106%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      1.14 ±141%   +6549.1%      75.53 ±137%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.00 ±223%  +6.5e+06%      76.30 ±141%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.91 ± 15%    +1e+05%     912.19 ± 92%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2.06 ± 70%   +5708.3%     119.46 ± 71%  perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      2.59            -0.1        2.45        perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      2.10            -0.1        1.99        perf-profile.calltrace.cycles-pp.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.70 ±  2%      -0.1        0.59        perf-profile.calltrace.cycles-pp.workingset_activation.folio_mark_accessed.filemap_read.vfs_read.ksys_read
      1.75            -0.1        1.65        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
      1.41            -0.1        1.32        perf-profile.calltrace.cycles-pp.llseek
      1.66            -0.1        1.57        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
      1.75            -0.1        1.67        perf-profile.calltrace.cycles-pp.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      1.66            -0.1        1.58        perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter
      0.84            -0.1        0.78        perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.86            -0.1        0.80        perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.94            -0.1        0.89        perf-profile.calltrace.cycles-pp.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.92            -0.1        0.86        perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.71            -0.1        0.66 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      0.86            -0.0        0.81        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.60            -0.0        0.56        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.94            -0.0        0.90        perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write
      0.85            -0.0        0.82        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.71            -0.0        0.69        perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read.ksys_read
      0.94            -0.0        0.91        perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      1.08            -0.0        1.05        perf-profile.calltrace.cycles-pp.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict
      0.70            -0.0        0.68        perf-profile.calltrace.cycles-pp.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_do_write_end
      1.35            -0.0        1.34        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release
      1.39            -0.0        1.37        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      1.35            -0.0        1.34        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range
      1.35            -0.0        1.34        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      0.53            -0.0        0.51        perf-profile.calltrace.cycles-pp.folio_alloc.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     28.25            +0.2       28.47        perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
     25.49            +0.2       25.73        perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
     24.68            +0.3       24.94        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release
     24.70            +0.3       24.96        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range
     24.70            +0.3       24.97        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
     33.66            +0.3       33.95        perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.80            +0.3       24.11        perf-profile.calltrace.cycles-pp.folio_mark_accessed.filemap_read.vfs_read.ksys_read.do_syscall_64
     32.63            +0.3       32.97        perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
     22.93            +0.4       23.35        perf-profile.calltrace.cycles-pp.folio_activate.folio_mark_accessed.filemap_read.vfs_read.ksys_read
     22.08            +0.4       22.50        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed.filemap_read
     22.07            +0.4       22.49        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed
     22.06            +0.4       22.48        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate
     22.88            +0.4       23.31        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_activate.folio_mark_accessed.filemap_read.vfs_read
     27.90            +0.6       28.49        perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
     25.00            +0.8       25.76        perf-profile.calltrace.cycles-pp.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
     23.72            +0.8       24.54        perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     22.56            +0.8       23.39        perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
     22.52            +0.8       23.34        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
     21.97            +0.8       22.81        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio
     21.94            +0.8       22.79        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     21.96            +0.8       22.80        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio
      0.41            -0.2        0.24 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_css_rstat_flush
      0.54            -0.2        0.37 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
      0.55            -0.2        0.38        perf-profile.children.cycles-pp.cgroup_rstat_flush
      2.60            -0.1        2.46        perf-profile.children.cycles-pp.ext4_block_write_begin
      1.66            -0.1        1.56        perf-profile.children.cycles-pp.llseek
      0.70 ±  2%      -0.1        0.59        perf-profile.children.cycles-pp.workingset_activation
      2.12            -0.1        2.02        perf-profile.children.cycles-pp.ext4_da_do_write_end
      0.52 ±  3%      -0.1        0.42        perf-profile.children.cycles-pp.workingset_age_nonresident
      1.76            -0.1        1.66        perf-profile.children.cycles-pp.copy_page_to_iter
      1.67            -0.1        1.58        perf-profile.children.cycles-pp._copy_to_iter
      1.78            -0.1        1.69        perf-profile.children.cycles-pp.block_write_end
      1.67            -0.1        1.59        perf-profile.children.cycles-pp.__block_commit_write
      1.00            -0.1        0.94        perf-profile.children.cycles-pp.__entry_text_start
      0.86            -0.1        0.81        perf-profile.children.cycles-pp.ext4_da_get_block_prep
      0.60            -0.1        0.54 ±  2%  perf-profile.children.cycles-pp.__fdget_pos
      0.79            -0.1        0.73 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.87            -0.1        0.82        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.95            -0.1        0.89        perf-profile.children.cycles-pp.zero_user_segments
      0.85            -0.1        0.80        perf-profile.children.cycles-pp.ext4_da_map_blocks
      0.95            -0.1        0.90        perf-profile.children.cycles-pp.memset_orig
      0.43            -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.__fget_light
      0.50            -0.0        0.46        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.47 ±  2%      -0.0        0.42        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.41 ±  3%      -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.40 ±  3%      -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.37 ±  2%      -0.0        0.33 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.64            -0.0        0.60        perf-profile.children.cycles-pp.xas_load
      0.74            -0.0        0.70        perf-profile.children.cycles-pp.filemap_get_read_batch
      0.95            -0.0        0.92        perf-profile.children.cycles-pp.mark_buffer_dirty
      0.44            -0.0        0.41        perf-profile.children.cycles-pp.file_modified
      0.98            -0.0        0.94        perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.87            -0.0        0.84        perf-profile.children.cycles-pp.filemap_get_pages
      0.43            -0.0        0.40        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.31 ±  6%      -0.0        0.28        perf-profile.children.cycles-pp.disk_rr
      0.41            -0.0        0.38        perf-profile.children.cycles-pp.touch_atime
      0.38            -0.0        0.35        perf-profile.children.cycles-pp.fault_in_readable
      0.32 ±  2%      -0.0        0.30        perf-profile.children.cycles-pp.xas_descend
      0.37            -0.0        0.34 ±  3%  perf-profile.children.cycles-pp.ksys_lseek
      0.34            -0.0        0.32        perf-profile.children.cycles-pp.atime_needs_update
      1.08            -0.0        1.06        perf-profile.children.cycles-pp.try_to_free_buffers
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.22 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.34 ±  2%      -0.0        0.32        perf-profile.children.cycles-pp.__cond_resched
      0.44            -0.0        0.42        perf-profile.children.cycles-pp.filemap_get_entry
      0.23 ±  2%      -0.0        0.21        perf-profile.children.cycles-pp.inode_needs_update_time
      0.71            -0.0        0.69        perf-profile.children.cycles-pp.__folio_mark_dirty
      0.37            -0.0        0.36        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.24 ±  2%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.24            -0.0        0.22        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.40            -0.0        0.38        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.14            -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.up_write
      0.50            -0.0        0.49        perf-profile.children.cycles-pp.alloc_pages_mpol
      0.14            -0.0        0.13        perf-profile.children.cycles-pp.current_time
      0.10            -0.0        0.09        perf-profile.children.cycles-pp.__es_insert_extent
      0.25 ±  3%      +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.19 ±  3%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__mod_node_page_state
      1.12            +0.1        1.20        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.99            +0.1        1.09 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.mutex_spin_on_owner
     30.58            +0.1       30.72        perf-profile.children.cycles-pp.dput
      0.64            +0.1        0.79 ±  4%  perf-profile.children.cycles-pp.cgroup_rstat_updated
     30.44            +0.2       30.60        perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.00            +0.2        0.18 ±  3%  perf-profile.children.cycles-pp.__mutex_lock
     97.33            +0.2       97.51        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     97.11            +0.2       97.31        perf-profile.children.cycles-pp.do_syscall_64
     28.25            +0.2       28.47        perf-profile.children.cycles-pp.__folio_batch_release
     25.74            +0.2       25.96        perf-profile.children.cycles-pp.release_pages
     33.71            +0.3       33.99        perf-profile.children.cycles-pp.ext4_buffered_write_iter
     23.82            +0.3       24.12        perf-profile.children.cycles-pp.folio_mark_accessed
     32.74            +0.3       33.09        perf-profile.children.cycles-pp.generic_perform_write
     22.94            +0.4       23.36        perf-profile.children.cycles-pp.folio_activate
     27.94            +0.6       28.53        perf-profile.children.cycles-pp.ext4_da_write_begin
     25.04            +0.8       25.80        perf-profile.children.cycles-pp.__filemap_get_folio
     23.73            +0.8       24.54        perf-profile.children.cycles-pp.filemap_add_folio
     22.61            +0.8       23.44        perf-profile.children.cycles-pp.folio_add_lru
     48.23            +1.2       49.47        perf-profile.children.cycles-pp.folio_batch_move_lru
     71.67            +1.5       73.13        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     71.80            +1.5       73.29        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     71.64            +1.5       73.14        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.40 ±  2%      -0.2        0.23 ±  2%  perf-profile.self.cycles-pp.mem_cgroup_css_rstat_flush
      0.52 ±  2%      -0.1        0.42 ±  2%  perf-profile.self.cycles-pp.workingset_age_nonresident
      1.65            -0.1        1.56        perf-profile.self.cycles-pp._copy_to_iter
      0.86            -0.1        0.81        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.94            -0.1        0.89        perf-profile.self.cycles-pp.memset_orig
      0.76            -0.0        0.71 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.52 ±  4%      -0.0        0.47        perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.40            -0.0        0.36 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.53 ±  2%      -0.0        0.50        perf-profile.self.cycles-pp.vfs_write
      0.63            -0.0        0.59        perf-profile.self.cycles-pp.filemap_read
      0.66            -0.0        0.62        perf-profile.self.cycles-pp.__block_commit_write
      0.37            -0.0        0.34 ±  2%  perf-profile.self.cycles-pp.fault_in_readable
      0.43            -0.0        0.41        perf-profile.self.cycles-pp.vfs_read
      0.26 ±  4%      -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.28            -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.xas_descend
      0.28            -0.0        0.26        perf-profile.self.cycles-pp.read
      0.28            -0.0        0.25        perf-profile.self.cycles-pp.__filemap_get_folio
      0.17            -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.27            -0.0        0.25        perf-profile.self.cycles-pp.do_syscall_64
      0.46            -0.0        0.44        perf-profile.self.cycles-pp.filemap_get_read_batch
      0.22 ±  2%      -0.0        0.20 ±  4%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.26            -0.0        0.25 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      0.24            -0.0        0.22        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.21 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.filemap_get_entry
      0.13            -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.down_write
      0.22 ±  2%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.ext4_da_do_write_end
      0.20 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.17            -0.0        0.16        perf-profile.self.cycles-pp.folio_mark_accessed
      0.10            -0.0        0.09        perf-profile.self.cycles-pp.ksys_write
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12            -0.0        0.11        perf-profile.self.cycles-pp.find_lock_entries
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.16            +0.0        0.19 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.54 ±  2%      +0.2        0.72 ±  4%  perf-profile.self.cycles-pp.cgroup_rstat_updated
     71.67            +1.5       73.13        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


