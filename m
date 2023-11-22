Return-Path: <cgroups+bounces-517-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB767F4857
	for <lists+cgroups@lfdr.de>; Wed, 22 Nov 2023 14:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015C1B20CC4
	for <lists+cgroups@lfdr.de>; Wed, 22 Nov 2023 13:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED7B4E620;
	Wed, 22 Nov 2023 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TA69XBTu"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E593197;
	Wed, 22 Nov 2023 05:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700661287; x=1732197287;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=peaZF8D4TksSgcHz7+DTzftqNvxd+MC7VkAQxQbWiwA=;
  b=TA69XBTuHzLxnq2JKWps4jncuG1fZrLU+kitz9Ry4PZtMs3+4f99IHzh
   rn7K9ZkwOpizzPNkuSp4S9c8quDtTd+q1tuBDW18/pM/zIEozt4/KWucn
   sNF4xAUtuxsxDXCoU9LuZbalGdTjFmB6tWWef0+QiQ/26kwpWQwVGsPcm
   51/cO+xdcQX/uyOwE4tIqXTga+eYzZCTngFdAe8NjUzxcJiC21Z6xfymw
   V0Cl4lIEmdm2nmEIBn7YiXC9l+oerwHEboZTJTKSdV8yCrPI80godEhbO
   qz2regukmpdo2IpyC9mIbQEOazxwZ5wZcfoHQp1E8mS4UoW23gKKZPTGy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="423146890"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="423146890"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 05:54:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910805328"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="910805328"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 05:54:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 05:54:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 05:54:45 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 05:54:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jn174oOJTrQiYMus2GenIF3qdb+RX/xfBxxALAU4V4yBkszR2MA3trthLOpGdMZjHMEEp4hRda5Emv9uO7yiw6zehkZ9v0nO+kiqedqh6gg4GE2k4fwWsCRPdhN59sEMhW2sLID5CCGWmA/2fiLqtLZig9JMkPXDEO45lssbUBPgEU4SoGB+uqcIck8+kLXCFCiWxdtPlxui6Ail3OvbYuDhtJVmFA/o0cM5ZhZ1qjKAM3N6zsOqqIMsBXOy37jxh1RNe9Cv/SwW0iKav1is1Jpx/tpgL7zuPHWXiMBRx/6hH30yDRBgSfV/AWkn/64Ptk5gvgSAGbrCAz/biKLfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwFr26lPRBpF22IpT0Elf9TIBefeFuu+3eBh+1G0ma0=;
 b=nPXUu2EIsW4/n69RdWCx8L66xr+rOS3g1KEFngoaHyIAhd1us5184SGHvfoQSFXA8YE/6yUAVsP8d2VkyiUtMRCx4GypgwpvntkeFSZa4UaGt7fEzkz9j4RNbSX8iPDQkWNwrvSoO/6PazRSuFC9vy4uMaMxM0P6Ws+GEHadLuth+x+JJd4kvzsiHbhcC4cbjEf2710zVJKcsDmDUg1ts7qFLJxT05Vn1/ndHEpjAPVImE9aKN6ovfasO/LXER7UJa1ROBBTI1g70mI+QCS4JbtnQ8b5giHAAcgEtcGv+fHxQ5LCtDpY+zPb7q/ieDmvQ5hOo+sKsqsZlbqQLw1/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB5218.namprd11.prod.outlook.com (2603:10b6:610:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:54:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 13:54:42 +0000
Date: Wed, 22 Nov 2023 21:54:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, Muchun Song
	<muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo
	<tj@kernel.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, "Waiman
 Long" <longman@redhat.com>, <kernel-team@cloudflare.com>, Wei Xu
	<weixugc@google.com>, Greg Thelen <gthelen@google.com>,
	<linux-kernel@vger.kernel.org>, Yosry Ahmed <yosryahmed@google.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/5] mm: memcg: make stats flushing threshold per-memcg
Message-ID: <202311221542.973f16ad-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231116022411.2250072-4-yosryahmed@google.com>
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df399fa-79bb-41cb-de6b-08dbeb6293c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctokmkSZKP3EQMJdp9x87NdV4AVsIVEZ2KzMr/DwI6+FNGntQ/9CUkC4UFoBvpEFwSwHCjElpdGH9FIm8ijH21lACzqRWeK4eYpSK/65yjzKNkBkEi8s6yLWLe0fMeS02u7QmngscnRYxFWvLTeVbQlA/pTKOysFIRA6IM1x/2gvVj8aCI02IqUKpwWWwKYd5MkGyq4RPJ3FQzAGSzmBxoRlUVLE2vaaepV/r8B9dP/9hWQZzF59g4IBYOBQT5w0NzGKPXS4WjOMuj4vbBC7HFG0ikrx4dBZpKuF63KGjmBud8x4op3D0Iqwvfhz8j01UUWpOu9jNtn5tFdU4KsOpwLRyAp1xKV7nCBSgfJV4jBVxM9fC950xxN++IXpZJP84HHFe/h7sH/6lfJLCd4+uzXWMouxIFSmC8ubHDEqAmWsg+NWhwTqgyTjE8HtweVZbBnNXqST+7IOqPcRMOIKdK1+Yt5Wfv4o8F4et3ZvsPhksGg9KJ0DH0ocAVDFYbrshDsnaLo7glcoEUFp4soj7DyNGDQjUzZUDVXkoOy68EWojK46KB5IW+EsiWQO+JPFofMKQNwyNr/uxqUcd/vK4UOmnWlvYEY2Z0PpjqF1gzOZTft/geU/S6e0nLp8nzeVJgM08K9r1EZJmk84s0aSrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(230473577357003)(230373577357003)(1800799012)(186009)(451199024)(64100799003)(7416002)(8676002)(5660300002)(8936002)(41300700001)(4326008)(2906002)(30864003)(316002)(54906003)(6916009)(66556008)(66476007)(66946007)(86362001)(26005)(107886003)(6486002)(6666004)(6512007)(36756003)(2616005)(6506007)(1076003)(478600001)(966005)(83380400001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?b4R4tx4N9Blik7T5dwUo9LPr5qkSSVcTFslcXnUBusa7I2W+6T72q1LUb5?=
 =?iso-8859-1?Q?6vlKLyMdeEWolVxI0iKxq8wodZuGWQyRH9kuyOxLmtbIak/OeTn0BAZHKo?=
 =?iso-8859-1?Q?+A5ACTWQ5u0zjVVHyRvLdgrULsK0ehkb5UT/qF6SHEv/dmmH1DhgCTyeLU?=
 =?iso-8859-1?Q?iXnUquUy/Zu8//AQvww0PTHPIejBH80nm0ER/pFuZwVRbFVVNeKnoO+eDm?=
 =?iso-8859-1?Q?TBwAoZ58sOlEZ9ncJZa7QC77bluMuUXk9n3aiZtQ02Y+JhPcYyhShiPDBr?=
 =?iso-8859-1?Q?xSCuSAxHGdos78t0+2MCOAqsS/MbbfGCYsmdYmW9iA1iggOx6juk8YHILs?=
 =?iso-8859-1?Q?HMxlRGZjiufK/SftIIPl2QplwVIP466j/TJiB7VvoZmQOrCJeGNVDI33FW?=
 =?iso-8859-1?Q?sQgC+xz6V7ULLmrgwmPSaBn0yvnwMRomwhDkND6xcBWyJA4QXbeRO5dIOY?=
 =?iso-8859-1?Q?3hk9BCfZdtFLOn4sF2n1Hs5Gm1uEjpV89kC7n0VqxBf11WbqniehtKUVke?=
 =?iso-8859-1?Q?If7265wVdIBcUN4SymHGom8eQkn4ypU+Es/ms9fFvwrWiO+6scm75Q6U8M?=
 =?iso-8859-1?Q?YIPc6VBaXl3AhFVYiFlywuzfK276re2/gzA33cEZPp1FcDaU52RgOokvU8?=
 =?iso-8859-1?Q?pMqAvto440HRn8GZW1uVTNBF2aq7YeJAt5BkfQ5XNTeHKjYufES5a2iVt7?=
 =?iso-8859-1?Q?7/hG9VSD0P8Qe5ARjKxXgh3JGPKympkCIx2+GVtvpmIQaUVoICSdUlJLap?=
 =?iso-8859-1?Q?ANUkHp+oe5Q8DPzvnqFEM3ZDrmHzCqMvNVu9R9exrloAARbF/S01F1NDfZ?=
 =?iso-8859-1?Q?KLFi9qGNJMLTrS656Aej46CB47bd1o79XSjpZ/0QAiWcFv5gvUt4TvLJ0A?=
 =?iso-8859-1?Q?OvwrGNNwEF5GIO0I4hP0LuAiGp9E+tws2sVuz1Xclq8trhXSgGSq0VQYm9?=
 =?iso-8859-1?Q?dhYYfE2gd+ylelg9uU92DRrsXWEVdgSraEKwKMJWREgKw+bWiJNEFn5kSW?=
 =?iso-8859-1?Q?dhP5dHFGQPS9YHEVrw9owdGTXzFwZubJJ6EO9Y9JzeLTjBegeUzuHq3bS3?=
 =?iso-8859-1?Q?+tP3sSqfo83QpatUSc1eUUAAd6mYaoNVDVR9+dRMY7HzPay7u+sDnQyzXD?=
 =?iso-8859-1?Q?eNecuWMgvY6JNERshegbnV+lhI7DdW6hqkwr8P1ufwgO8QMpo/dqw52I5J?=
 =?iso-8859-1?Q?WQo4XjnYbmwrl1gvhftY7OOq0u3xJJ/9qf0GIm4IAsZRk2MW8OMUCEItUK?=
 =?iso-8859-1?Q?VqbvlaOqYY5SAlmhVVQBQSQjJ9rJqc7TmljIQH4e+uHjZnbYeVCOP9hpPn?=
 =?iso-8859-1?Q?7ObEphElBYiOSMUhD939x5VWpYVAu3Y7mVvxdh6V4ZhN5B6q2ez2acTCN2?=
 =?iso-8859-1?Q?A0l9Sv9KbK5yZ4nO+FFT/9S+H705Q5lD7e/ZgjdpzfyoBJrCqF/DaBoFS1?=
 =?iso-8859-1?Q?BLVtDQJTleaHUhobztn00f739I9KnsStrTwdM+V63Mx7EUPHIr+VJd9FV2?=
 =?iso-8859-1?Q?2tK7rGUOFjgBF+NDsgWAL28gcMO/S+FmWVSUWoFniessKjsQSDLl7YUsxu?=
 =?iso-8859-1?Q?pXaUrbLjTrZICCuNxirWOb8MRqKu3HG4Pd2ihz7M0he8VTp2ndIfWlj7kd?=
 =?iso-8859-1?Q?kepl3u26D7g6rERSl19grh0ZZt4cAD0d3jUKr4akS/pFYWRB6HuE3r0w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df399fa-79bb-41cb-de6b-08dbeb6293c7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:54:42.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O11+85cqs8btpUNseNNsD/Q47e3BlwsJS+obuZmZT+bb+Xv6D/taB65Su3nexRAyVEeeUXX2GClrFNT2P7l5Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5218
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -30.2% regression of will-it-scale.per_thread_ops on:


commit: c7fbfc7b4e089c4a9b292b1973a42a5761c1342f ("[PATCH v3 3/5] mm: memcg: make stats flushing threshold per-memcg")
url: https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-memcg-change-flush_next_time-to-flush_last_time/20231116-103300
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20231116022411.2250072-4-yosryahmed@google.com/
patch subject: [PATCH v3 3/5] mm: memcg: make stats flushing threshold per-memcg

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 50%
	mode: thread
	test: fallocate2
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311221542.973f16ad-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231122/202311221542.973f16ad-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/fallocate2/will-it-scale

commit: 
  c5caa5bb03 ("mm: memcg: move vmstats structs definition above flushing code")
  c7fbfc7b4e ("mm: memcg: make stats flushing threshold per-memcg")

c5caa5bb0376e3e5 c7fbfc7b4e089c4a9b292b1973a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.84            -0.5        1.37 ±  9%  mpstat.cpu.all.usr%
      0.08           -25.0%       0.06        turbostat.IPC
      3121            -9.2%       2835 ±  5%  vmstat.system.cs
     78.17 ± 12%     +96.6%     153.67 ± 18%  perf-c2c.DRAM.local
    504.17 ±  6%     +34.4%     677.50 ±  4%  perf-c2c.DRAM.remote
   3980762           -30.2%    2777359        will-it-scale.52.threads
     76552           -30.2%      53410        will-it-scale.per_thread_ops
   3980762           -30.2%    2777359        will-it-scale.workload
 1.192e+09 ±  2%     -30.2%  8.324e+08 ±  3%  numa-numastat.node0.local_node
 1.192e+09 ±  2%     -30.2%  8.324e+08 ±  3%  numa-numastat.node0.numa_hit
 1.215e+09 ±  2%     -30.3%  8.471e+08 ±  3%  numa-numastat.node1.local_node
 1.215e+09 ±  2%     -30.3%  8.474e+08 ±  3%  numa-numastat.node1.numa_hit
 1.192e+09 ±  2%     -30.2%  8.324e+08 ±  3%  numa-vmstat.node0.numa_hit
 1.192e+09 ±  2%     -30.2%  8.324e+08 ±  3%  numa-vmstat.node0.numa_local
 1.215e+09 ±  2%     -30.3%  8.474e+08 ±  3%  numa-vmstat.node1.numa_hit
 1.215e+09 ±  2%     -30.3%  8.471e+08 ±  3%  numa-vmstat.node1.numa_local
     31404            -1.6%      30913        proc-vmstat.nr_slab_reclaimable
 2.408e+09           -30.2%   1.68e+09        proc-vmstat.numa_hit
 2.407e+09           -30.2%   1.68e+09        proc-vmstat.numa_local
 2.404e+09           -30.2%  1.678e+09        proc-vmstat.pgalloc_normal
 2.403e+09           -30.2%  1.678e+09        proc-vmstat.pgfree
      0.05 ±  8%     -27.3%       0.04 ±  4%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.05 ± 10%     -24.9%       0.04 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.05 ±  8%     -27.2%       0.04 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      1.14           +14.1%       1.30        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    198.38 ±  3%     +16.5%     231.12 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1563 ±  5%     -11.4%       1384 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      1677 ±  5%     -18.7%       1364 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      3815 ±  2%     -14.5%       3260 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.51 ±  5%     -32.3%       0.35 ± 16%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.47 ± 11%     -33.3%       0.31 ± 20%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      2.37           +13.0%       2.68 ±  2%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.05 ±  8%     -27.3%       0.04 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.05 ± 10%     -24.9%       0.04 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.05 ±  8%     -27.2%       0.04 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      1.14           +14.1%       1.30        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    198.37 ±  3%     +16.5%     231.11 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.39 ± 31%     -72.9%       0.11 ± 28%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
      0.51 ±  5%     -32.3%       0.35 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.47 ± 11%     -33.3%       0.31 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      2.37           +13.1%       2.68 ±  2%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.82 ± 14%    +174.7%       2.24 ± 30%  perf-stat.i.MPKI
 8.476e+09           -27.7%  6.127e+09 ± 10%  perf-stat.i.branch-instructions
  55486131           -28.1%   39884260 ±  6%  perf-stat.i.branch-misses
     14.80 ±  2%      +6.2       20.96 ±  7%  perf-stat.i.cache-miss-rate%
  30690945 ±  3%     +79.9%   55207216 ± 10%  perf-stat.i.cache-misses
 2.066e+08           +24.2%  2.567e+08 ±  7%  perf-stat.i.cache-references
      3070            -9.7%       2772 ±  5%  perf-stat.i.context-switches
      3.58 ±  2%     +39.7%       5.00 ± 11%  perf-stat.i.cpi
      4688 ±  3%     -47.9%       2442 ±  4%  perf-stat.i.cycles-between-cache-misses
   4098916           -29.7%    2879809        perf-stat.i.dTLB-load-misses
 1.052e+10           -27.5%   7.63e+09 ± 10%  perf-stat.i.dTLB-loads
 5.845e+09           -30.7%  4.051e+09 ± 10%  perf-stat.i.dTLB-stores
     77.61            -6.0       71.56        perf-stat.i.iTLB-load-miss-rate%
   4058819           -32.5%    2739054 ±  8%  perf-stat.i.iTLB-load-misses
 4.089e+10           -28.3%  2.932e+10 ± 10%  perf-stat.i.instructions
      0.28           -26.8%       0.21 ±  5%  perf-stat.i.ipc
    240.84           -27.9%     173.57 ± 10%  perf-stat.i.metric.M/sec
   3814721 ±  3%     +72.2%    6569712 ± 10%  perf-stat.i.node-load-misses
    407308 ±  7%     +72.0%     700502 ± 18%  perf-stat.i.node-loads
   1323090 ±  2%     -28.1%     951590 ± 12%  perf-stat.i.node-store-misses
     36568 ±  2%     -20.7%      29014 ± 12%  perf-stat.i.node-stores
      0.75 ±  3%    +151.0%       1.88        perf-stat.overall.MPKI
     14.85 ±  2%      +6.6       21.47 ±  3%  perf-stat.overall.cache-miss-rate%
      3.53           +33.8%       4.72        perf-stat.overall.cpi
      4704 ±  3%     -46.8%       2505        perf-stat.overall.cycles-between-cache-misses
     77.62            -6.2       71.39        perf-stat.overall.iTLB-load-miss-rate%
      0.28           -25.3%       0.21        perf-stat.overall.ipc
   3121462            +7.4%    3353425        perf-stat.overall.path-length
 8.451e+09           -27.6%  6.119e+09 ± 10%  perf-stat.ps.branch-instructions
  55320195           -28.0%   39804925 ±  6%  perf-stat.ps.branch-misses
  30594557 ±  3%     +80.2%   55116821 ±  9%  perf-stat.ps.cache-misses
 2.059e+08           +24.4%  2.561e+08 ±  6%  perf-stat.ps.cache-references
      3059            -9.6%       2765 ±  5%  perf-stat.ps.context-switches
   4085949           -29.7%    2871251        perf-stat.ps.dTLB-load-misses
 1.049e+10           -27.4%   7.62e+09 ± 10%  perf-stat.ps.dTLB-loads
 5.828e+09           -30.6%  4.046e+09 ± 10%  perf-stat.ps.dTLB-stores
   4046367           -32.4%    2734227 ±  7%  perf-stat.ps.iTLB-load-misses
 4.077e+10           -28.2%  2.928e+10 ± 10%  perf-stat.ps.instructions
   3802900 ±  3%     +72.5%    6559980 ± 10%  perf-stat.ps.node-load-misses
    406123 ±  7%     +72.2%     699397 ± 17%  perf-stat.ps.node-loads
   1319155 ±  2%     -28.0%     950261 ± 12%  perf-stat.ps.node-store-misses
     36542 ±  2%     -20.6%      29007 ± 11%  perf-stat.ps.node-stores
 1.243e+13           -25.0%  9.313e+12        perf-stat.total.instructions
      1.26 ±  2%      -0.4        0.91        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.fallocate64
      1.22            -0.3        0.88 ±  2%  perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.92 ±  2%      -0.3        0.62 ±  3%  perf-profile.calltrace.cycles-pp.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      1.04            -0.3        0.76 ±  2%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.80            -0.2        0.58 ±  3%  perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.25 ±  2%      -0.2        1.07        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr
      1.25 ±  2%      -0.2        1.07        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change
      1.23 ±  2%      -0.2        1.06        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range
      1.23 ±  2%      -0.2        1.06        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
      1.23 ±  2%      -0.2        1.05        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      1.16 ±  2%      -0.1        1.02 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      0.68            +0.1        0.75 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_list.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr
      1.07            +0.1        1.18 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      2.95            +0.3        3.21 ±  2%  perf-profile.calltrace.cycles-pp.truncate_inode_folio.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      2.60            +0.4        2.95        perf-profile.calltrace.cycles-pp.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr.notify_change
      2.27            +0.4        2.71 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr
      1.38 ±  3%      +0.5        1.85 ±  5%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      2.29 ±  2%      +0.6        2.90 ±  2%  perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.00            +0.6        0.63 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr
      0.00            +0.7        0.74 ±  3%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      1.30            +0.8        2.07 ±  3%  perf-profile.calltrace.cycles-pp.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range
      0.73 ±  2%      +0.8        1.53 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio
      1.23            +0.8        2.04 ±  3%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio
      0.00            +0.8        0.82 ±  2%  perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.39 ±  2%      +0.9        2.32 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.59 ±  2%      +0.9        1.53 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp
     38.12            +1.0       39.16        perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      0.62 ±  4%      +1.1        1.71 ±  3%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
     37.61            +1.2       38.80        perf-profile.calltrace.cycles-pp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     36.54            +1.5       38.02        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     35.97            +1.6       37.60        perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      2.48 ±  3%      +2.3        4.80 ±  4%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      1.28 ±  2%      -0.4        0.92        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.23            -0.3        0.88 ±  2%  perf-profile.children.cycles-pp.shmem_alloc_folio
      0.95 ±  2%      -0.3        0.64 ±  3%  perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      1.07            -0.3        0.77 ±  3%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.86 ±  2%      -0.3        0.58 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.84            -0.2        0.61 ±  3%  perf-profile.children.cycles-pp.__alloc_pages
      1.26 ±  2%      -0.2        1.08        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.61 ±  3%      -0.2        0.43        perf-profile.children.cycles-pp.__entry_text_start
      0.56 ±  2%      -0.2        0.40 ±  3%  perf-profile.children.cycles-pp.free_unref_page_list
      0.26 ±  7%      -0.2        0.11 ±  5%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      1.19 ±  2%      -0.1        1.04 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.45 ±  4%      -0.1        0.31        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.48 ±  2%      -0.1        0.35 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.38 ±  5%      -0.1        0.27 ±  2%  perf-profile.children.cycles-pp.xas_load
      0.38 ±  2%      -0.1        0.27 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.33 ±  4%      -0.1        0.23 ±  2%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.42 ±  2%      -0.1        0.32 ±  5%  perf-profile.children.cycles-pp.find_lock_entries
      0.32 ±  2%      -0.1        0.23 ±  2%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.33 ±  2%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.rmqueue
      0.24 ±  3%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.xas_descend
      0.23 ±  3%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.xas_init_marks
      0.25 ±  3%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.xas_clear_mark
      0.23 ±  2%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.__cond_resched
      0.28 ±  5%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.filemap_get_entry
      0.24 ±  3%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.16 ±  4%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.xas_find_conflict
      0.09 ±  7%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.18            -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.shmem_recalc_inode
      0.18 ±  2%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.folio_unlock
      0.17 ±  4%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.16 ±  6%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.security_file_permission
      0.13 ±  7%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.20 ±  4%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.16 ±  5%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.noop_dirty_folio
      0.15 ±  5%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.file_modified
      0.12 ± 10%      -0.0        0.08        perf-profile.children.cycles-pp.__percpu_counter_limited_add
      0.19 ±  5%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.11 ± 12%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.14 ±  5%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.__fget_light
      0.14 ±  7%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.14 ±  2%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.12 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.11 ± 10%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.11 ±  8%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xas_start
      0.11 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.18 ±  2%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.08 ±  6%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.__get_file_rcu
      0.12 ±  7%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.inode_add_bytes
      0.11 ±  4%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.08 ±  6%      -0.0        0.05 ± 45%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.10            -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.09 ±  7%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.07 ±  6%      -0.0        0.05 ± 45%  perf-profile.children.cycles-pp.shmem_is_huge
      0.09 ±  7%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.08 ±  4%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.policy_nodemask
      0.19 ±  3%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.try_charge_memcg
      0.08 ±  8%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.down_write
      0.09 ±  7%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.xas_create
      0.09 ±  7%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.filemap_free_folio
      0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.xas_find
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.25            +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.uncharge_folio
      0.43 ±  2%      +0.0        0.47 ±  2%  perf-profile.children.cycles-pp.uncharge_batch
      0.69            +0.1        0.75 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      1.10            +0.1        1.20 ±  2%  perf-profile.children.cycles-pp.lru_add_fn
      2.96            +0.3        3.21        perf-profile.children.cycles-pp.truncate_inode_folio
      2.60            +0.4        2.96        perf-profile.children.cycles-pp.filemap_remove_folio
      2.29            +0.4        2.73 ±  2%  perf-profile.children.cycles-pp.__filemap_remove_folio
      1.39 ±  3%      +0.5        1.85 ±  5%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      2.34 ±  2%      +0.6        2.93 ±  2%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.18 ±  5%      +0.7        0.92 ±  2%  perf-profile.children.cycles-pp.__count_memcg_events
      1.32            +0.8        2.07 ±  3%  perf-profile.children.cycles-pp.filemap_unaccount_folio
     38.14            +1.0       39.17        perf-profile.children.cycles-pp.vfs_fallocate
      0.64 ±  4%      +1.1        1.72 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
     37.63            +1.2       38.81        perf-profile.children.cycles-pp.shmem_fallocate
     36.57            +1.5       38.05        perf-profile.children.cycles-pp.shmem_get_folio_gfp
     36.04            +1.6       37.65        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      2.66            +1.7        4.38 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      2.49 ±  2%      +2.3        4.80 ±  4%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.99 ±  2%      +2.5        4.46        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.28 ±  2%      -0.4        0.92        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.69 ±  2%      -0.2        0.50 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.54 ±  2%      -0.2        0.36 ±  2%  perf-profile.self.cycles-pp.release_pages
      0.47 ±  2%      -0.2        0.31 ±  2%  perf-profile.self.cycles-pp.xas_store
      0.53 ±  3%      -0.2        0.37 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      0.36 ±  3%      -0.2        0.21 ±  2%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.26 ±  8%      -0.2        0.11 ±  5%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      1.14 ±  2%      -0.1        1.01 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.40 ±  4%      -0.1        0.28 ±  4%  perf-profile.self.cycles-pp.lru_add_fn
      0.37 ±  2%      -0.1        0.26        perf-profile.self.cycles-pp._raw_spin_lock
      0.32 ±  3%      -0.1        0.22 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.35 ±  3%      -0.1        0.25 ±  2%  perf-profile.self.cycles-pp.shmem_fallocate
      0.50 ±  2%      -0.1        0.40 ±  3%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.34 ±  3%      -0.1        0.26 ±  5%  perf-profile.self.cycles-pp.find_lock_entries
      0.28 ±  2%      -0.1        0.20 ±  5%  perf-profile.self.cycles-pp.__alloc_pages
      0.22 ±  2%      -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.xas_clear_mark
      0.21 ±  3%      -0.1        0.15 ±  4%  perf-profile.self.cycles-pp.shmem_alloc_and_add_folio
      0.18 ±  3%      -0.1        0.12 ±  5%  perf-profile.self.cycles-pp.free_unref_page_list
      0.22 ±  3%      -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.xas_descend
      0.20 ±  6%      -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.18 ±  4%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.shmem_inode_acct_blocks
      0.21 ±  5%      -0.1        0.15 ±  5%  perf-profile.self.cycles-pp.vfs_fallocate
      0.18 ±  2%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__filemap_remove_folio
      0.17 ±  4%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.folio_unlock
      0.20 ±  3%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.16 ±  5%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.__cond_resched
      0.17 ±  5%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.14 ±  4%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.xas_load
      0.15 ±  2%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.16 ±  4%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.alloc_pages_mpol
      0.12 ±  6%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.rmqueue
      0.13 ±  6%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.13 ±  8%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.15 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.noop_dirty_folio
      0.10 ± 10%      -0.0        0.06 ± 17%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.07 ±  8%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.12 ± 10%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__percpu_counter_limited_add
      0.12 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.folio_add_lru
      0.10 ±  3%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.xas_init_marks
      0.10 ±  9%      -0.0        0.07        perf-profile.self.cycles-pp.xas_start
      0.13 ±  3%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.filemap_remove_folio
      0.11 ±  6%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.16 ±  4%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.12 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.11 ±  3%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.fallocate64
      0.08 ±  6%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.__get_file_rcu
      0.11 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__folio_cancel_dirty
      0.11 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.11 ±  6%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.__fget_light
      0.17 ±  3%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.filemap_get_entry
      0.22 ±  6%      -0.0        0.19 ±  3%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.09 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.08 ±  5%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.07 ± 11%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.shmem_is_huge
      0.08 ±  6%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.__x64_sys_fallocate
      0.08 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.09 ±  7%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.filemap_free_folio
      0.08 ±  8%      -0.0        0.06        perf-profile.self.cycles-pp.shmem_alloc_folio
      0.12 ±  6%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.try_charge_memcg
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.24            +0.0        0.27 ±  3%  perf-profile.self.cycles-pp.uncharge_folio
      0.46 ±  4%      +0.4        0.86 ±  5%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      1.38 ±  3%      +0.5        1.84 ±  5%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.16 ±  3%      +0.7        0.90 ±  2%  perf-profile.self.cycles-pp.__count_memcg_events
      0.28 ±  3%      +0.8        1.06 ±  5%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      1.86 ±  2%      +2.5        4.36        perf-profile.self.cycles-pp.__mod_memcg_lruvec_state




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


