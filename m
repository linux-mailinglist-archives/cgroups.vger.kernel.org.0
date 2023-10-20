Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B717D13E1
	for <lists+cgroups@lfdr.de>; Fri, 20 Oct 2023 18:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377814AbjJTQSY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Oct 2023 12:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTQSX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Oct 2023 12:18:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEA1D51;
        Fri, 20 Oct 2023 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697818696; x=1729354696;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=slKwIIYfVhJFvR7zzt7TZRtKLHd83kWrfvM+GXYYapA=;
  b=X1WOEGIhlvApD1YE+KT+k3r3p8939mrjbpGGjkqXmRc+droc2JzRaCrS
   ZVWVgTHIRflc64nQxiLKoGoCtesVmYsROc6t3TKA3IrOfbkwZ5wyMphr1
   upHLTucZGN986caMIb3688zye0X24oo6JgAchDcFLzJ5FzsqDbqnn+EaC
   nNY9M+fAhMGUHnuofhpSdMtU5nTuLTAUhvUAsXl3LRWhnqFW+Kg1GlOIe
   AiU3ga1m7RmwC8wSUlvZ5ellA544mi1adbE+ywftFEkxkiVYtYxqJWyTp
   D3PdtJYfQCYYUOGOUa4aD8H6E8eCnUtyy3oEWZNzlBEsc+89TgNrpp8Mm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="385412836"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="385412836"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 09:18:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="786841566"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="786841566"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 09:18:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 09:18:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 09:18:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 09:18:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfYZo/EXJ6Yz1yk9qB1cg+Tcipj5VP26UCkWBb7IpHWT6S6N4rvfxZ7CaBKCaPVm5Ivi/1FUNcNqEIBCnNzrzY0hqfECh7r0NJkLIV/oVq6lPpQUSau/cOiSaF47poYp5qlYSZYZ/g8zqUG6PAe+S/H3djEAlnVCmgIU/zmkkDXNyB+B1uc2m5o9WZIu0C6I9BzWwr0mT+vlx42dxqLRMsj1bXHw3qm7hMsH0GzCgZYGGdWUj+CCYG3jKJVInLcfSIjqcdVQfZOiqrNEK3O4/8Pg7geydLCJVrKkiim2jtOy9cozFbl1DZ8k5WfguiNKuQFE0vj9pzuLN3V29tJ5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6I1YQ7VBxLfaFo/bnG9qcOTfPiCHx3um64xe6zDO2Y=;
 b=kjWVUi3t1ECZrWf1pYT+5JyH3Gq9Ngp0eg3zs0pk0mOfxwzoHI+VJNg9uunaZUBAvh3Te8mjagoqoFEb2RBnoI9nhiIlTfPJ/P3rzX/7gwFC7Yfuvaqmpfz3PWKvwFNjcEt9UMsFj4QkfWRh1p3ra8Uo3luVmlxBeM4xd4+ecwiQpFwHIAAvTMrX5+stfCZhPY0tJRAbhH6Fm3usT52QE92G1pdt/s2jtwKrzR1chyyHwivoKJq5P2QhwNk6ulFkUCmzjs9GMrSO38jGexkbV4Ho0biVkGXP2lnZ40CDad7f8FgdemllOu34CytTlJu2X06jyKz71FEVAlC3yGz1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ1PR11MB6107.namprd11.prod.outlook.com (2603:10b6:a03:48a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Fri, 20 Oct
 2023 16:18:08 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Fri, 20 Oct 2023
 16:18:08 +0000
Date:   Sat, 21 Oct 2023 00:17:56 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "Waiman Long" <longman@redhat.com>, <kernel-team@cloudflare.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        <linux-kernel@vger.kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
Message-ID: <202310202303.c68e7639-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010032117.1577496-4-yosryahmed@google.com>
X-ClientProxiedBy: KL1PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::25) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ1PR11MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d0d28d-c672-45d9-ab45-08dbd188255c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O02Enj+FeYQ+l6bxt9kp7p98873PlFGMQPZ+NWew+Yf6HR+Vfnnic+0s2p+Pg4m9AZsBSzTU6me6RvhWVsCA2lzMGdDVJNdyFDNE542OR1WdBgC3Jjjxj5hyJ9kBamReHCPIGCUfBTCfVkt+ELc4YhbpYLHZ0uVF6V2ZftXWgNCLBbbY+FQbJuH1HFV3ODspdZr6YdCiNIIz3oDoGTMlerU0DQqlZcq8QFXDgSsN+onOjstPLlijJsw4U+eGAIM6sfV0/UTo9J8YCnkgnD+3+wFBcrt35B8T8rcU5SFhKXS0PgeWhihzIiPNFsTCeIw9zAmmdRXfp99rN4bgmf2d1GLGUdsV2hh2Ljti5zXJFV8uu+qsaAWFlMe3qsaTLGfLf/SVp3mVYKH4+ahvPLhJsJ4assJ6BC9nOXxgvoFmAs2qY1gxb1ZD3EDHCPZkeF4V7nVDF5tYSvwF2OgML0E/IhPx5LJFf6Bw0L+MRRBYCeH7oen3MX/vGS8iULay1FvUQKQ8IUfUHY1dGD6wXQcOYf4LPyQ3P3it0Gu2cwywqpOpP4cCUHh2LtRSmQOf6jVHagLFCFgq6fHrBc+nbMImdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6916009)(30864003)(2906002)(6666004)(107886003)(2616005)(1076003)(6506007)(54906003)(66556008)(478600001)(66476007)(41300700001)(86362001)(966005)(6486002)(66946007)(83380400001)(82960400001)(26005)(38100700002)(7416002)(5660300002)(316002)(4326008)(36756003)(8676002)(8936002)(6512007)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RTccDGTK6u+3TH0vzWxzaPo+i22K/Fv/rS45tmURM+ZIrQyjBow6H2SfI2?=
 =?iso-8859-1?Q?fh6S18uNxC29SFd3i5/Mo6syl0VmsiJWQqaHwP6g6rLqQNp9ThzD4Hqw1Z?=
 =?iso-8859-1?Q?CbH6RD+Czu8EGYiHaVBw6NqYRrh6/JoRcsjj75Gc4RsiDHSs0LpefA4xsI?=
 =?iso-8859-1?Q?oTTW3ptKkH/HxFt73s6c0Sw8RdJNJYoJX9hF89RoFAPzv+kb2TKozroBhm?=
 =?iso-8859-1?Q?AoQ8oSYh+iCzJLqlMeSzcolnxOGlQ2AaMbF2c7ECel6vrExnbCrKLPHTbV?=
 =?iso-8859-1?Q?VmSlUsuQP0Xqu/CK6y4xS0hesKyftrvwWyx+Y/fj0PSYoORGPBz/VCv42A?=
 =?iso-8859-1?Q?cTIjtMISqy/jH+bbKqI2tR9vHZzyFvxr8xIwzKMVadex7yYkC9F15N+iLg?=
 =?iso-8859-1?Q?Rw+iLlu129NrZGQZYidFpzgQ4cJNNLLQ7dlQO564gM5HVPjyFBXMtR8f1y?=
 =?iso-8859-1?Q?qfunYk+9xNU9SoSpetVjCSffx1uZbAcS2FaDVfBIzwos388Sp9UfKWDheW?=
 =?iso-8859-1?Q?y0BJiLssvx54p0CU9jS3VfoNwDROaQv0ZRrpbb/yh3qOUFJnf0TTLz2fcI?=
 =?iso-8859-1?Q?jrRVSYqjuEGw2Ben7pHtP/GEJ0Fj2xI8mfkO57/BA9FYm0jI9oojxmt23k?=
 =?iso-8859-1?Q?VOdzFVFQ6p7Cgehn4TADZE+oC5O8+8gzA2DApSmiDEgPDy5zi6UP7pz8in?=
 =?iso-8859-1?Q?mwvcBj7ICedw612Jmtc9/fNNvWGwwrgkevqogaAZJ8iDg9mLs1iEiP0x3n?=
 =?iso-8859-1?Q?9g9EZcZ/LTOcguMQDyctGYdAbYk19pBUc07i8fbvmOR1B/cQ0CVqOZh8HO?=
 =?iso-8859-1?Q?q05nJe2Zz4XUqAZppNrBwCu2uRO1E6SIe85IMl63LN65GadwF0TTkvsbkV?=
 =?iso-8859-1?Q?SfveAa2rcht5gGUpB+zayTKXqRGix5uVDV8H1ou5YmrEkW3Gc01nRPRRw3?=
 =?iso-8859-1?Q?JzA/QIHKuoFtJMd8a4horj6LhPNnhS7KZ4xm+bJJXm/kxJGcrLIeSsLQ+L?=
 =?iso-8859-1?Q?R4PXXM33CQ/mVwluq5KRZX3HpzBwSPX7fG+6LOduK2ynY11802CRZbaCZk?=
 =?iso-8859-1?Q?t1STbOW/CJo+aob2MrmahOX6PW6hg3xaBzICW3M1G3Q9HnVXdXzWswmKds?=
 =?iso-8859-1?Q?8WkHLdcVB+5dsbNCaKAEmNaDVMRdOndYZwcB+LtfgmoN7UWXZvimgsZkl5?=
 =?iso-8859-1?Q?PaiZ9h1iPq+8bSY+7KJLnM2NAORcqfA/WEOADffEBx7lLAFZPYcFu27D67?=
 =?iso-8859-1?Q?Os1yEWnP2qdc/xtxknvTVT5uROHYb88zk4znsX85QNs7yryd3Ube9nr4wD?=
 =?iso-8859-1?Q?d9YdB1pOQk/87oYd1F3T9X5DeZnfs5SWTMdI0HLqWN+Smk1cMHptZ+AG8b?=
 =?iso-8859-1?Q?TwqkdcTXasN2ZVlrP6dbiFdA9HwxEEmJjvg2Wm9rWeqveb6qVF1es+HTpz?=
 =?iso-8859-1?Q?7YH7BlcLI9GNGYEqFQRfr/lqhi1KOranmS+OqQRffeJFB1ISMozh9Gr2Ak?=
 =?iso-8859-1?Q?9FpUhx0oTybgJ2Nedkiq4WwjDpxrF6P9hsYyPfSK/8p63sBDKVe9zkQ4mI?=
 =?iso-8859-1?Q?V8zK8VeHIwJOg7yQCAjO2DM57OcVn6AV9SONPck4KRoKuj6xdOf26DmbVR?=
 =?iso-8859-1?Q?ig6te0EYprImjoFZ44Nmfr4m+nibAHi1BjHuBmGLZnOrMvpFC7/7oqBg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d0d28d-c672-45d9-ab45-08dbd188255c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:18:08.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcIwdOou6M75/uJ6p+BcKRdUObD4Dw8d7718QbwPcYwbKxMBANnuS48pf9J4b+EpQ3mwu4+fkhzeN4M6AXWxLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6107
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Hello,

kernel test robot noticed a -25.8% regression of will-it-scale.per_thread_ops on:


commit: 51d74c18a9c61e7ee33bc90b522dd7f6e5b80bb5 ("[PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg")
url: https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-memcg-change-flush_next_time-to-flush_last_time/20231010-112257
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20231010032117.1577496-4-yosryahmed@google.com/
patch subject: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: thread
	test: fallocate1
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops -30.0% regression |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory              |
| test parameters  | cpufreq_governor=performance                                  |
|                  | mode=thread                                                   |
|                  | nr_task=50%                                                   |
|                  | test=fallocate1                                               |
+------------------+---------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310202303.c68e7639-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231020/202310202303.c68e7639-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/fallocate1/will-it-scale

commit: 
  130617edc1 ("mm: memcg: move vmstats structs definition above flushing code")
  51d74c18a9 ("mm: memcg: make stats flushing threshold per-memcg")

130617edc1cd1ba1 51d74c18a9c61e7ee33bc90b522 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.09            -0.5        1.61 ±  2%  mpstat.cpu.all.usr%
     27.58            +3.7%      28.59        turbostat.RAMWatt
      3324           -10.0%       2993        vmstat.system.cs
      1056          -100.0%       0.00        numa-meminfo.node0.Inactive(file)
      6.67 ±141%  +15799.3%       1059        numa-meminfo.node1.Inactive(file)
    120.83 ± 11%     +79.6%     217.00 ±  9%  perf-c2c.DRAM.local
    594.50 ±  6%     +43.8%     854.83 ±  5%  perf-c2c.DRAM.remote
   3797041           -25.8%    2816352        will-it-scale.104.threads
     36509           -25.8%      27079        will-it-scale.per_thread_ops
   3797041           -25.8%    2816352        will-it-scale.workload
 1.142e+09           -26.2%  8.437e+08        numa-numastat.node0.local_node
 1.143e+09           -26.1%  8.439e+08        numa-numastat.node0.numa_hit
 1.148e+09           -25.4%  8.563e+08 ±  2%  numa-numastat.node1.local_node
 1.149e+09           -25.4%  8.564e+08 ±  2%  numa-numastat.node1.numa_hit
     32933            -2.6%      32068        proc-vmstat.nr_slab_reclaimable
 2.291e+09           -25.8%    1.7e+09        proc-vmstat.numa_hit
 2.291e+09           -25.8%    1.7e+09        proc-vmstat.numa_local
  2.29e+09           -25.8%  1.699e+09        proc-vmstat.pgalloc_normal
 2.289e+09           -25.8%  1.699e+09        proc-vmstat.pgfree
      1.00 ± 93%    +154.2%       2.55 ± 16%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    191.10 ±  2%     +18.0%     225.55 ±  2%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    385.50 ± 14%     +39.6%     538.17 ± 12%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
    118.67 ± 11%     -62.6%      44.33 ±100%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      5043 ±  2%     -13.0%       4387 ±  6%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    167.12 ±222%    +200.1%     501.48 ± 99%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    191.09 ±  2%     +18.0%     225.53 ±  2%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    293.46 ±  4%     +12.8%     330.98 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    199.33          -100.0%       0.00        numa-vmstat.node0.nr_active_file
    264.00          -100.0%       0.00        numa-vmstat.node0.nr_inactive_file
    199.33          -100.0%       0.00        numa-vmstat.node0.nr_zone_active_file
    264.00          -100.0%       0.00        numa-vmstat.node0.nr_zone_inactive_file
 1.143e+09           -26.1%  8.439e+08        numa-vmstat.node0.numa_hit
 1.142e+09           -26.2%  8.437e+08        numa-vmstat.node0.numa_local
      1.67 ±141%  +15799.3%     264.99        numa-vmstat.node1.nr_inactive_file
      1.67 ±141%  +15799.3%     264.99        numa-vmstat.node1.nr_zone_inactive_file
 1.149e+09           -25.4%  8.564e+08 ±  2%  numa-vmstat.node1.numa_hit
 1.148e+09           -25.4%  8.563e+08 ±  2%  numa-vmstat.node1.numa_local
      0.59 ±  3%    +125.2%       1.32 ±  2%  perf-stat.i.MPKI
 9.027e+09           -17.9%  7.408e+09        perf-stat.i.branch-instructions
      0.64            -0.0        0.60        perf-stat.i.branch-miss-rate%
  58102855           -23.3%   44580037 ±  2%  perf-stat.i.branch-misses
     15.28            +7.0       22.27        perf-stat.i.cache-miss-rate%
  25155306 ±  2%     +82.7%   45953601 ±  3%  perf-stat.i.cache-misses
 1.644e+08           +25.4%  2.062e+08 ±  2%  perf-stat.i.cache-references
      3258           -10.3%       2921        perf-stat.i.context-switches
      6.73           +23.3%       8.30        perf-stat.i.cpi
    145.97            -1.3%     144.13        perf-stat.i.cpu-migrations
     11519 ±  3%     -45.4%       6293 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.04            -0.0        0.03        perf-stat.i.dTLB-load-miss-rate%
   3921408           -25.3%    2929564        perf-stat.i.dTLB-load-misses
 1.098e+10           -18.1%  8.993e+09        perf-stat.i.dTLB-loads
      0.00 ±  2%      +0.0        0.00 ±  4%  perf-stat.i.dTLB-store-miss-rate%
 5.606e+09           -23.2%  4.304e+09        perf-stat.i.dTLB-stores
     95.65            -1.2       94.49        perf-stat.i.iTLB-load-miss-rate%
   3876741           -25.0%    2905764        perf-stat.i.iTLB-load-misses
 4.286e+10           -18.9%  3.477e+10        perf-stat.i.instructions
     11061            +8.2%      11969        perf-stat.i.instructions-per-iTLB-miss
      0.15           -18.9%       0.12        perf-stat.i.ipc
     48.65 ±  2%     +46.2%      71.11 ±  2%  perf-stat.i.metric.K/sec
    247.84           -18.9%     201.05        perf-stat.i.metric.M/sec
   3138385 ±  2%     +77.7%    5578401 ±  2%  perf-stat.i.node-load-misses
    375827 ±  3%     +69.2%     635857 ± 11%  perf-stat.i.node-loads
   1343194           -26.8%     983668        perf-stat.i.node-store-misses
     51550 ±  3%     -19.0%      41748 ±  7%  perf-stat.i.node-stores
      0.59 ±  3%    +125.1%       1.32 ±  2%  perf-stat.overall.MPKI
      0.64            -0.0        0.60        perf-stat.overall.branch-miss-rate%
     15.30            +7.0       22.28        perf-stat.overall.cache-miss-rate%
      6.73           +23.3%       8.29        perf-stat.overall.cpi
     11470 ±  2%     -45.3%       6279 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.04            -0.0        0.03        perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  2%      +0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
     95.56            -1.4       94.17        perf-stat.overall.iTLB-load-miss-rate%
     11059            +8.2%      11967        perf-stat.overall.instructions-per-iTLB-miss
      0.15           -18.9%       0.12        perf-stat.overall.ipc
   3396437            +9.5%    3718021        perf-stat.overall.path-length
 8.997e+09           -17.9%  7.383e+09        perf-stat.ps.branch-instructions
  57910417           -23.3%   44426577 ±  2%  perf-stat.ps.branch-misses
  25075498 ±  2%     +82.7%   45803186 ±  3%  perf-stat.ps.cache-misses
 1.639e+08           +25.4%  2.056e+08 ±  2%  perf-stat.ps.cache-references
      3247           -10.3%       2911        perf-stat.ps.context-switches
    145.47            -1.3%     143.61        perf-stat.ps.cpu-migrations
   3908900           -25.3%    2920218        perf-stat.ps.dTLB-load-misses
 1.094e+10           -18.1%  8.963e+09        perf-stat.ps.dTLB-loads
 5.587e+09           -23.2%  4.289e+09        perf-stat.ps.dTLB-stores
   3863663           -25.0%    2895895        perf-stat.ps.iTLB-load-misses
 4.272e+10           -18.9%  3.466e+10        perf-stat.ps.instructions
   3128132 ±  2%     +77.7%    5559939 ±  2%  perf-stat.ps.node-load-misses
    375403 ±  3%     +69.0%     634300 ± 11%  perf-stat.ps.node-loads
   1338688           -26.8%     980311        perf-stat.ps.node-store-misses
     51546 ±  3%     -19.1%      41692 ±  7%  perf-stat.ps.node-stores
  1.29e+13           -18.8%  1.047e+13        perf-stat.total.instructions
      0.96            -0.3        0.70 ±  2%  perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.97            -0.3        0.72        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.fallocate64
      0.76 ±  2%      -0.2        0.54 ±  3%  perf-profile.calltrace.cycles-pp.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.82            -0.2        0.60 ±  2%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.91            -0.2        0.72        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      0.68            +0.1        0.76 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.67            +0.1        1.77        perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      1.78 ±  2%      +0.1        1.92 ±  2%  perf-profile.calltrace.cycles-pp.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr.notify_change
      0.69 ±  5%      +0.1        0.84 ±  4%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      1.56 ±  2%      +0.2        1.76 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr
      0.85 ±  4%      +0.4        1.23 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.78 ±  4%      +0.4        1.20 ±  3%  perf-profile.calltrace.cycles-pp.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range
      0.73 ±  4%      +0.4        1.17 ±  3%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio
     48.39            +0.8       49.14        perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      0.00            +0.8        0.77 ±  4%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
     40.24            +0.8       41.03        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
     40.22            +0.8       41.01        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      0.00            +0.8        0.79 ±  3%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp
     40.19            +0.8       40.98        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
      1.33 ±  5%      +0.8        2.13 ±  4%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
     48.16            +0.8       48.98        perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      0.00            +0.9        0.88 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio
     47.92            +0.9       48.81        perf-profile.calltrace.cycles-pp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     47.07            +0.9       48.01        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     46.59            +1.1       47.64        perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      0.99            -0.3        0.73 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.96            -0.3        0.70 ±  2%  perf-profile.children.cycles-pp.shmem_alloc_folio
      0.78 ±  2%      -0.2        0.56 ±  3%  perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      0.83            -0.2        0.61 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.92            -0.2        0.73        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.74 ±  2%      -0.2        0.55 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.67            -0.2        0.50 ±  3%  perf-profile.children.cycles-pp.__alloc_pages
      0.43            -0.1        0.31 ±  2%  perf-profile.children.cycles-pp.__entry_text_start
      0.41 ±  2%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.free_unref_page_list
      0.35            -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.xas_load
      0.35 ±  2%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.39            -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.27 ±  2%      -0.1        0.19 ±  4%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.32 ±  3%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.find_lock_entries
      0.23 ±  2%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.xas_descend
      0.28 ±  3%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.25 ±  3%      -0.1        0.18 ±  3%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.16 ±  3%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.xas_find_conflict
      0.26 ±  2%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.filemap_get_entry
      0.26            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.20 ±  3%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.19 ±  5%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.xas_clear_mark
      0.17 ±  5%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.xas_init_marks
      0.15 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.18 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.xas_find
      0.13 ±  2%      -0.0        0.09        perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.14 ±  4%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.__fget_light
      0.06 ±  6%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.12 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xas_start
      0.08 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.__folio_throttle_swaprate
      0.12            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.folio_unlock
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.try_charge_memcg
      0.12 ±  6%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.12 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.noop_dirty_folio
      0.20 ±  2%      -0.0        0.17 ±  5%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.10            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.09 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.inode_add_bytes
      0.06 ±  6%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.filemap_free_folio
      0.06 ±  6%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.12 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.12 ±  3%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.shmem_recalc_inode
      0.09 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.08 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.08 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.security_file_permission
      0.08 ±  6%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.09 ±  4%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.__percpu_counter_limited_add
      0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.07 ±  8%      -0.0        0.05        perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.14 ±  3%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.policy_nodemask
      0.24 ±  2%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.08            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.xas_create
      0.69            +0.1        0.78        perf-profile.children.cycles-pp.lru_add_fn
      1.72 ±  2%      +0.1        1.80        perf-profile.children.cycles-pp.shmem_add_to_page_cache
      1.79 ±  2%      +0.1        1.93 ±  2%  perf-profile.children.cycles-pp.filemap_remove_folio
      0.13 ±  5%      +0.1        0.28        perf-profile.children.cycles-pp.file_modified
      0.69 ±  5%      +0.1        0.84 ±  3%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.09 ±  7%      +0.2        0.24 ±  2%  perf-profile.children.cycles-pp.inode_needs_update_time
      1.58 ±  3%      +0.2        1.77 ±  2%  perf-profile.children.cycles-pp.__filemap_remove_folio
      0.15 ±  3%      +0.4        0.50 ±  3%  perf-profile.children.cycles-pp.__count_memcg_events
      0.79 ±  4%      +0.4        1.20 ±  3%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.36 ±  5%      +0.4        0.77 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
     98.33            +0.5       98.78        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     97.74            +0.6       98.34        perf-profile.children.cycles-pp.do_syscall_64
     48.39            +0.8       49.15        perf-profile.children.cycles-pp.__x64_sys_fallocate
      1.34 ±  5%      +0.8        2.14 ±  4%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.61 ±  4%      +0.8        2.42 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
     48.17            +0.8       48.98        perf-profile.children.cycles-pp.vfs_fallocate
     47.94            +0.9       48.82        perf-profile.children.cycles-pp.shmem_fallocate
     47.10            +0.9       48.04        perf-profile.children.cycles-pp.shmem_get_folio_gfp
     84.34            +0.9       85.28        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     84.31            +0.9       85.26        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     84.24            +1.0       85.21        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     46.65            +1.1       47.70        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      1.23 ±  4%      +1.4        2.58 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.98            -0.3        0.73 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.88            -0.2        0.70        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.60            -0.2        0.45        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.41 ±  3%      -0.1        0.27 ±  3%  perf-profile.self.cycles-pp.release_pages
      0.41            -0.1        0.30 ±  3%  perf-profile.self.cycles-pp.xas_store
      0.41 ±  3%      -0.1        0.29 ±  2%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.30 ±  3%      -0.1        0.18 ±  5%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.38 ±  2%      -0.1        0.27 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      0.30 ±  3%      -0.1        0.20 ±  6%  perf-profile.self.cycles-pp.lru_add_fn
      0.28 ±  2%      -0.1        0.20 ±  5%  perf-profile.self.cycles-pp.shmem_fallocate
      0.26 ±  2%      -0.1        0.18 ±  5%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.27 ±  3%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.21 ±  2%      -0.1        0.15 ±  4%  perf-profile.self.cycles-pp.__alloc_pages
      0.20 ±  2%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.xas_descend
      0.26 ±  3%      -0.1        0.20 ±  4%  perf-profile.self.cycles-pp.find_lock_entries
      0.18 ±  4%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.xas_clear_mark
      0.15 ±  7%      -0.0        0.10 ± 11%  perf-profile.self.cycles-pp.shmem_inode_acct_blocks
      0.16 ±  4%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.13 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.13            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.16 ±  4%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.shmem_alloc_and_add_folio
      0.13 ±  5%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.__filemap_remove_folio
      0.13 ±  2%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.12 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.vfs_fallocate
      0.06 ±  7%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.13 ±  3%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.fallocate64
      0.11 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.xas_start
      0.07 ±  5%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.shmem_alloc_folio
      0.14 ±  4%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.__fget_light
      0.10 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.rmqueue
      0.12 ±  3%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.xas_load
      0.11 ±  4%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.folio_unlock
      0.10 ±  4%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.alloc_pages_mpol
      0.15 ±  2%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.10            -0.0        0.07        perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.16 ±  2%      -0.0        0.13 ±  6%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.12 ±  5%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.06 ±  6%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.filemap_free_folio
      0.12 ±  3%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.free_unref_page_list
      0.12            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.noop_dirty_folio
      0.10 ±  3%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.filemap_remove_folio
      0.10 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.try_charge_memcg
      0.12 ±  3%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.09 ±  4%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__folio_cancel_dirty
      0.08 ±  4%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.08 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp._raw_spin_trylock
      0.08            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.folio_add_lru
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.07 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.xas_find_conflict
      0.08 ± 10%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.07 ± 10%      -0.0        0.05        perf-profile.self.cycles-pp.xas_init_marks
      0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__percpu_counter_limited_add
      0.07 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.07 ±  5%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.uncharge_batch
      0.21 ±  9%      +0.1        0.31 ±  7%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.69 ±  5%      +0.1        0.83 ±  4%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.06 ±  6%      +0.2        0.22 ±  2%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.14 ±  8%      +0.3        0.42 ±  7%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.13 ±  7%      +0.4        0.49 ±  3%  perf-profile.self.cycles-pp.__count_memcg_events
     84.24            +1.0       85.21        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.12 ±  5%      +1.4        2.50 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state


***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/fallocate1/will-it-scale

commit: 
  130617edc1 ("mm: memcg: move vmstats structs definition above flushing code")
  51d74c18a9 ("mm: memcg: make stats flushing threshold per-memcg")

130617edc1cd1ba1 51d74c18a9c61e7ee33bc90b522 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.87            -0.4        1.43 ±  3%  mpstat.cpu.all.usr%
      3171            -5.3%       3003 ±  2%  vmstat.system.cs
     84.83 ±  9%     +55.8%     132.17 ± 16%  perf-c2c.DRAM.local
    484.17 ±  3%     +37.1%     663.67 ± 10%  perf-c2c.DRAM.remote
     72763 ±  5%     +14.4%      83212 ± 12%  turbostat.C1
      0.08           -25.0%       0.06        turbostat.IPC
     27.90            +4.6%      29.18        turbostat.RAMWatt
   3982212           -30.0%    2785941        will-it-scale.52.threads
     76580           -30.0%      53575        will-it-scale.per_thread_ops
   3982212           -30.0%    2785941        will-it-scale.workload
 1.175e+09 ±  2%     -28.6%  8.392e+08 ±  2%  numa-numastat.node0.local_node
 1.175e+09 ±  2%     -28.6%  8.394e+08 ±  2%  numa-numastat.node0.numa_hit
 1.231e+09 ±  2%     -31.3%  8.463e+08 ±  3%  numa-numastat.node1.local_node
 1.232e+09 ±  2%     -31.3%  8.466e+08 ±  3%  numa-numastat.node1.numa_hit
 1.175e+09 ±  2%     -28.6%  8.394e+08 ±  2%  numa-vmstat.node0.numa_hit
 1.175e+09 ±  2%     -28.6%  8.392e+08 ±  2%  numa-vmstat.node0.numa_local
 1.232e+09 ±  2%     -31.3%  8.466e+08 ±  3%  numa-vmstat.node1.numa_hit
 1.231e+09 ±  2%     -31.3%  8.463e+08 ±  3%  numa-vmstat.node1.numa_local
 2.408e+09           -30.0%  1.686e+09        proc-vmstat.numa_hit
 2.406e+09           -30.0%  1.685e+09        proc-vmstat.numa_local
 2.404e+09           -29.9%  1.684e+09        proc-vmstat.pgalloc_normal
 2.404e+09           -29.9%  1.684e+09        proc-vmstat.pgfree
      0.04 ±  9%     -19.3%       0.03 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.04 ±  8%     -22.3%       0.03 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      0.91 ±  2%     +11.3%       1.01 ±  5%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ± 13%     -90.3%       0.00 ±223%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.14           +15.1%       1.31        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    189.94 ±  3%     +18.3%     224.73 ±  4%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1652 ±  4%     -13.4%       1431 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     83.67 ±  7%     -87.6%      10.33 ±223%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      3827 ±  4%     -13.0%       3328 ±  3%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.71 ±165%     -83.4%       0.28 ± 21%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.43 ± 17%     -43.8%       0.24 ± 26%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.46 ± 17%     -36.7%       0.29 ± 12%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      0.30 ± 34%     -90.7%       0.03 ±223%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.04 ±  9%     -19.3%       0.03 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.04 ±  8%     -22.3%       0.03 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      0.04 ± 11%     -33.1%       0.03 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.90 ±  2%     +11.5%       1.00 ±  5%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ± 13%     -26.6%       0.03 ± 12%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.13           +15.2%       1.30        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    189.93 ±  3%     +18.3%     224.72 ±  4%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.71 ±165%     -83.4%       0.28 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.43 ± 17%     -43.8%       0.24 ± 26%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.46 ± 17%     -36.7%       0.29 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      0.75          +142.0%       1.83 ±  2%  perf-stat.i.MPKI
  8.47e+09           -24.4%  6.407e+09        perf-stat.i.branch-instructions
      0.66            -0.0        0.63        perf-stat.i.branch-miss-rate%
  56364992           -28.3%   40421603 ±  3%  perf-stat.i.branch-misses
     14.64            +6.7       21.30        perf-stat.i.cache-miss-rate%
  30868184           +81.3%   55977240 ±  3%  perf-stat.i.cache-misses
 2.107e+08           +24.7%  2.627e+08 ±  2%  perf-stat.i.cache-references
      3106            -5.5%       2934 ±  2%  perf-stat.i.context-switches
      3.55           +33.4%       4.74        perf-stat.i.cpi
      4722           -44.8%       2605 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.04            -0.0        0.04        perf-stat.i.dTLB-load-miss-rate%
   4117232           -29.1%    2917107        perf-stat.i.dTLB-load-misses
 1.051e+10           -24.1%  7.979e+09        perf-stat.i.dTLB-loads
      0.00 ±  3%      +0.0        0.00 ±  6%  perf-stat.i.dTLB-store-miss-rate%
 5.886e+09           -27.5%  4.269e+09        perf-stat.i.dTLB-stores
     78.16            -6.6       71.51        perf-stat.i.iTLB-load-miss-rate%
   4131074 ±  3%     -30.0%    2891515        perf-stat.i.iTLB-load-misses
 4.098e+10           -25.0%  3.072e+10        perf-stat.i.instructions
      9929 ±  2%      +7.0%      10627        perf-stat.i.instructions-per-iTLB-miss
      0.28           -25.0%       0.21        perf-stat.i.ipc
     63.49           +43.8%      91.27 ±  3%  perf-stat.i.metric.K/sec
    241.12           -24.6%     181.87        perf-stat.i.metric.M/sec
   3735316           +78.6%    6669641 ±  3%  perf-stat.i.node-load-misses
    377465 ±  4%     +86.1%     702512 ± 11%  perf-stat.i.node-loads
   1322217           -27.6%     957081 ±  5%  perf-stat.i.node-store-misses
     37459 ±  3%     -23.0%      28826 ±  5%  perf-stat.i.node-stores
      0.75          +141.8%       1.82 ±  2%  perf-stat.overall.MPKI
      0.67            -0.0        0.63        perf-stat.overall.branch-miss-rate%
     14.65            +6.7       21.30        perf-stat.overall.cache-miss-rate%
      3.55           +33.4%       4.73        perf-stat.overall.cpi
      4713           -44.8%       2601 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.04            -0.0        0.04        perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  3%      +0.0        0.00 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
     78.14            -6.7       71.47        perf-stat.overall.iTLB-load-miss-rate%
      9927 ±  2%      +7.0%      10624        perf-stat.overall.instructions-per-iTLB-miss
      0.28           -25.0%       0.21        perf-stat.overall.ipc
   3098901            +7.1%    3318983        perf-stat.overall.path-length
 8.441e+09           -24.4%  6.385e+09        perf-stat.ps.branch-instructions
  56179581           -28.3%   40286337 ±  3%  perf-stat.ps.branch-misses
  30759982           +81.3%   55777812 ±  3%  perf-stat.ps.cache-misses
   2.1e+08           +24.6%  2.618e+08 ±  2%  perf-stat.ps.cache-references
      3095            -5.5%       2923 ±  2%  perf-stat.ps.context-switches
   4103292           -29.1%    2907270        perf-stat.ps.dTLB-load-misses
 1.048e+10           -24.1%  7.952e+09        perf-stat.ps.dTLB-loads
 5.866e+09           -27.5%  4.255e+09        perf-stat.ps.dTLB-stores
   4117020 ±  3%     -30.0%    2881750        perf-stat.ps.iTLB-load-misses
 4.084e+10           -25.0%  3.062e+10        perf-stat.ps.instructions
   3722149           +78.5%    6645867 ±  3%  perf-stat.ps.node-load-misses
    376240 ±  4%     +86.1%     700053 ± 11%  perf-stat.ps.node-loads
   1317772           -27.6%     953773 ±  5%  perf-stat.ps.node-store-misses
     37408 ±  3%     -23.2%      28748 ±  5%  perf-stat.ps.node-stores
 1.234e+13           -25.1%  9.246e+12        perf-stat.total.instructions
      1.28            -0.4        0.90 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.fallocate64
      1.26 ±  2%      -0.4        0.90 ±  3%  perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      1.08 ±  2%      -0.3        0.77 ±  3%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.92 ±  2%      -0.3        0.62 ±  3%  perf-profile.calltrace.cycles-pp.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.84 ±  3%      -0.2        0.61 ±  3%  perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.26            -0.2        1.08        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr
      1.26            -0.2        1.08        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change
      1.24            -0.2        1.06        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range
      1.24            -0.2        1.06        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
      1.23            -0.2        1.06        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      1.20            -0.2        1.04 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      0.68 ±  3%      +0.0        0.72 ±  4%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_list.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr
      1.08            +0.1        1.20        perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      2.91            +0.3        3.18 ±  2%  perf-profile.calltrace.cycles-pp.truncate_inode_folio.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      2.56            +0.4        2.92 ±  2%  perf-profile.calltrace.cycles-pp.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr.notify_change
      1.36 ±  3%      +0.4        1.76 ±  9%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      2.22            +0.5        2.68 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr
      0.00            +0.6        0.60 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr
      2.33            +0.6        2.94        perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.00            +0.7        0.72 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      0.69 ±  4%      +0.8        1.47 ±  3%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio
      1.24 ±  2%      +0.8        2.04 ±  2%  perf-profile.calltrace.cycles-pp.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range
      0.00            +0.8        0.82 ±  4%  perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.17 ±  2%      +0.8        2.00 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio
      0.59 ±  4%      +0.9        1.53        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.38            +1.0        2.33 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.62 ±  3%      +1.0        1.66 ±  5%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
     38.70            +1.2       39.90        perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     38.34            +1.3       39.65        perf-profile.calltrace.cycles-pp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.24            +1.6       38.86        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     36.64            +1.8       38.40        perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      2.47 ±  2%      +2.1        4.59 ±  8%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      1.30            -0.4        0.92 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.28 ±  2%      -0.4        0.90 ±  3%  perf-profile.children.cycles-pp.shmem_alloc_folio
      1.10 ±  2%      -0.3        0.78 ±  3%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.96 ±  2%      -0.3        0.64 ±  3%  perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      0.88            -0.3        0.58 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.88 ±  3%      -0.2        0.64 ±  3%  perf-profile.children.cycles-pp.__alloc_pages
      0.61 ±  2%      -0.2        0.43 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      1.26            -0.2        1.09        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.56            -0.2        0.39 ±  4%  perf-profile.children.cycles-pp.free_unref_page_list
      1.22            -0.2        1.06 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.46            -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.41 ±  3%      -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.xas_load
      0.44 ±  4%      -0.1        0.31 ±  4%  perf-profile.children.cycles-pp.find_lock_entries
      0.50 ±  3%      -0.1        0.37 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.24 ±  7%      -0.1        0.12 ±  5%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.34 ±  2%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.38 ±  3%      -0.1        0.28 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      0.32 ±  2%      -0.1        0.22 ±  5%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.26 ±  2%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.xas_descend
      0.22 ±  3%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.25            -0.1        0.17 ±  3%  perf-profile.children.cycles-pp.xas_clear_mark
      0.32 ±  4%      -0.1        0.25 ±  3%  perf-profile.children.cycles-pp.rmqueue
      0.23 ±  2%      -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.xas_init_marks
      0.24 ±  2%      -0.1        0.17 ±  5%  perf-profile.children.cycles-pp.__cond_resched
      0.25 ±  4%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.30 ±  3%      -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.filemap_get_entry
      0.20 ±  2%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.folio_unlock
      0.16 ±  4%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.xas_find_conflict
      0.19 ±  3%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.17 ±  5%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.noop_dirty_folio
      0.13 ±  4%      -0.1        0.08 ±  9%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.18 ±  8%      -0.1        0.13 ±  4%  perf-profile.children.cycles-pp.shmem_recalc_inode
      0.16 ±  2%      -0.1        0.11 ±  3%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.09 ±  5%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.10 ±  7%      -0.0        0.05 ± 45%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.14 ±  5%      -0.0        0.10        perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.14 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.security_file_permission
      0.10 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.xas_find
      0.15 ±  4%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__fget_light
      0.14 ±  5%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.file_modified
      0.12 ±  3%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.12 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.12 ±  3%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xas_start
      0.09            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__folio_throttle_swaprate
      0.12 ±  6%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.12 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__percpu_counter_limited_add
      0.12 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.inode_add_bytes
      0.20 ±  2%      -0.0        0.17 ±  7%  perf-profile.children.cycles-pp.try_charge_memcg
      0.10 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.policy_nodemask
      0.09 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.09 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.filemap_free_folio
      0.07 ±  6%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.down_write
      0.08 ±  4%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.get_task_policy
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.xas_create
      0.09 ±  7%      -0.0        0.07        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.09 ±  7%      -0.0        0.07        perf-profile.children.cycles-pp.inode_needs_update_time
      0.16 ±  2%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.08 ±  7%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.08 ± 10%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.shmem_is_huge
      0.07 ±  6%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.43 ±  3%      +0.0        0.46 ±  5%  perf-profile.children.cycles-pp.uncharge_batch
      0.68 ±  3%      +0.0        0.73 ±  4%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      1.11            +0.1        1.22        perf-profile.children.cycles-pp.lru_add_fn
      2.91            +0.3        3.18 ±  2%  perf-profile.children.cycles-pp.truncate_inode_folio
      2.56            +0.4        2.92 ±  2%  perf-profile.children.cycles-pp.filemap_remove_folio
      1.37 ±  3%      +0.4        1.76 ±  9%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      2.24            +0.5        2.70 ±  2%  perf-profile.children.cycles-pp.__filemap_remove_folio
      2.38            +0.6        2.97        perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.18 ±  4%      +0.7        0.91 ±  4%  perf-profile.children.cycles-pp.__count_memcg_events
      1.26            +0.8        2.04 ±  2%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.63 ±  2%      +1.0        1.67 ±  5%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
     38.71            +1.2       39.91        perf-profile.children.cycles-pp.vfs_fallocate
     38.37            +1.3       39.66        perf-profile.children.cycles-pp.shmem_fallocate
     37.28            +1.6       38.89        perf-profile.children.cycles-pp.shmem_get_folio_gfp
     36.71            +1.7       38.45        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      2.58            +1.8        4.36 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      2.48 ±  2%      +2.1        4.60 ±  8%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.93 ±  3%      +2.4        4.36 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.30            -0.4        0.92 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.73            -0.2        0.52 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.54 ±  2%      -0.2        0.36 ±  3%  perf-profile.self.cycles-pp.release_pages
      0.48            -0.2        0.30 ±  3%  perf-profile.self.cycles-pp.xas_store
      0.54 ±  2%      -0.2        0.38 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      1.17            -0.1        1.03 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.36 ±  2%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.43 ±  5%      -0.1        0.30 ±  7%  perf-profile.self.cycles-pp.lru_add_fn
      0.24 ±  7%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.38 ±  4%      -0.1        0.27 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.52 ±  3%      -0.1        0.41        perf-profile.self.cycles-pp.folio_batch_move_lru
      0.32 ±  2%      -0.1        0.22 ±  4%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.36 ±  4%      -0.1        0.26 ±  4%  perf-profile.self.cycles-pp.find_lock_entries
      0.36 ±  2%      -0.1        0.26 ±  2%  perf-profile.self.cycles-pp.shmem_fallocate
      0.28 ±  3%      -0.1        0.20 ±  5%  perf-profile.self.cycles-pp.__alloc_pages
      0.24 ±  2%      -0.1        0.16 ±  4%  perf-profile.self.cycles-pp.xas_descend
      0.23 ±  2%      -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.xas_clear_mark
      0.18 ±  3%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.18 ±  3%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.shmem_inode_acct_blocks
      0.21 ±  3%      -0.1        0.15 ±  2%  perf-profile.self.cycles-pp.shmem_alloc_and_add_folio
      0.18 ±  2%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__filemap_remove_folio
      0.18 ±  7%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.vfs_fallocate
      0.20 ±  2%      -0.1        0.14 ±  6%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.18 ±  2%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.folio_unlock
      0.18 ±  2%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.15 ±  3%      -0.1        0.10 ±  7%  perf-profile.self.cycles-pp.xas_load
      0.17 ±  3%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.__cond_resched
      0.17 ±  2%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.17 ±  5%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.noop_dirty_folio
      0.10 ±  7%      -0.0        0.05 ± 45%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.12 ±  3%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.rmqueue
      0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.xas_find
      0.13 ±  3%      -0.0        0.09 ±  6%  perf-profile.self.cycles-pp.alloc_pages_mpol
      0.07 ±  6%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.xas_find_conflict
      0.16 ±  2%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.free_unref_page_list
      0.12 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.fallocate64
      0.20 ±  4%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.06 ±  7%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.shmem_recalc_inode
      0.13 ±  3%      -0.0        0.09        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.22 ±  3%      -0.0        0.19 ±  6%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.14 ±  3%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.filemap_remove_folio
      0.15 ±  5%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.12 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.__folio_cancel_dirty
      0.11 ±  4%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.12 ±  3%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.11 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.11 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__percpu_counter_limited_add
      0.11 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.xas_start
      0.10 ±  6%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.xas_init_marks
      0.09 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.11            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.folio_add_lru
      0.09 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.filemap_free_folio
      0.09 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.shmem_alloc_folio
      0.14 ±  5%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.07 ±  7%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.policy_nodemask
      0.07 ± 11%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.shmem_is_huge
      0.08 ±  4%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.get_task_policy
      0.08 ±  6%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__x64_sys_fallocate
      0.12 ±  3%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.try_charge_memcg
      0.07            -0.0        0.05        perf-profile.self.cycles-pp.free_unref_page_prepare
      0.07 ±  6%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.08 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.09 ±  7%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.filemap_get_entry
      0.07 ±  9%      +0.0        0.09 ± 10%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.96 ±  2%      +0.2        1.12 ±  7%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.45 ±  4%      +0.4        0.82 ±  8%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      1.36 ±  3%      +0.4        1.75 ±  9%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.29            +0.7        1.00 ± 10%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.16 ±  4%      +0.7        0.90 ±  4%  perf-profile.self.cycles-pp.__count_memcg_events
      1.80 ±  2%      +2.5        4.26 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

