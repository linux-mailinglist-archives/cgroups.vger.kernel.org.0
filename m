Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC94F5A07
	for <lists+cgroups@lfdr.de>; Wed,  6 Apr 2022 11:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiDFJbq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Apr 2022 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581107AbiDFJVY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Apr 2022 05:21:24 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7113115CB75;
        Tue,  5 Apr 2022 19:48:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0V9JnNS5_1649213273;
Received: from 30.39.96.171(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V9JnNS5_1649213273)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Apr 2022 10:47:55 +0800
Message-ID: <b8c08e6f-bb34-7266-0dbc-1e673b6a965c@linux.alibaba.com>
Date:   Wed, 6 Apr 2022 10:47:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v2 0/4] Introduce group balancer
Content-Language: en-US
To:     Zefan Li <lizefan.x@bytedance.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michael Wang <yun.wang@linux.alibaba.com>,
        Cruz Zhao <cruzzhao@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Vipin Sharma <vipinsh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20220308092629.40431-1-dtcccc@linux.alibaba.com>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <20220308092629.40431-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Ping~
Any idea for this patchset? :-)

On 2022/3/8 17:26, Tianchen Ding wrote:
> Modern platform are growing fast on CPU numbers. To achieve better
> utility of CPU resource, multiple apps are starting to sharing the CPUs.
> 
> What we need is a way to ease confliction in share mode,
> make groups as exclusive as possible, to gain both performance
> and resource efficiency.
> 
> The main idea of group balancer is to fulfill this requirement
> by balancing groups of tasks among groups of CPUs, consider this
> as a dynamic demi-exclusive mode. Task trigger work to settle it's
> group into a proper partition (minimum predicted load), then try
> migrate itself into it. To gradually settle groups into the most
> exclusively partition.
> 
> GB can be seen as an optimize policy based on load balance,
> it obeys the main idea of load balance and makes adjustment
> based on that.
> 
> Our test on ARM64 platform with 128 CPUs shows that,
> throughput of sysbench memory is improved about 25%,
> and redis-benchmark is improved up to about 10%.
> 
> See each patch for detail:
> The 1st patch introduces infrastructure.
> The 2nd patch introduces detail about partition info.
> The 3rd patch is the main part of group balancer.
> The 4th patch is about stats.
> 
> v2:
> Put partition info and period settings to cpuset subsys of cgroup_v2.
> 
> v1: https://lore.kernel.org/all/98f41efd-74b2-198a-839c-51b785b748a6@linux.alibaba.com/
> 
> Michael Wang (1):
>    sched: Introduce group balancer
> 
> Tianchen Ding (3):
>    sched, cpuset: Introduce infrastructure of group balancer
>    cpuset: Handle input of partition info for group balancer
>    cpuset, gb: Add stat for group balancer
> 
>   include/linux/cpuset.h   |   5 +
>   include/linux/sched.h    |   5 +
>   include/linux/sched/gb.h |  70 ++++++
>   init/Kconfig             |  12 +
>   kernel/cgroup/cpuset.c   | 405 +++++++++++++++++++++++++++++++-
>   kernel/sched/Makefile    |   1 +
>   kernel/sched/core.c      |   5 +
>   kernel/sched/debug.c     |  10 +-
>   kernel/sched/fair.c      |  26 ++-
>   kernel/sched/gb.c        | 487 +++++++++++++++++++++++++++++++++++++++
>   kernel/sched/sched.h     |  14 ++
>   11 files changed, 1037 insertions(+), 3 deletions(-)
>   create mode 100644 include/linux/sched/gb.h
>   create mode 100644 kernel/sched/gb.c
> 

