Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CEA4D1349
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 10:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240030AbiCHJ1k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Mar 2022 04:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiCHJ1k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Mar 2022 04:27:40 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E117140930;
        Tue,  8 Mar 2022 01:26:43 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0V6e-ti7_1646731589;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6e-ti7_1646731589)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 17:26:38 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
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
        Tianchen Ding <dtcccc@linux.alibaba.com>,
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
Subject: [RFC PATCH v2 0/4] Introduce group balancer
Date:   Tue,  8 Mar 2022 17:26:25 +0800
Message-Id: <20220308092629.40431-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Modern platform are growing fast on CPU numbers. To achieve better
utility of CPU resource, multiple apps are starting to sharing the CPUs.

What we need is a way to ease confliction in share mode,
make groups as exclusive as possible, to gain both performance
and resource efficiency.

The main idea of group balancer is to fulfill this requirement
by balancing groups of tasks among groups of CPUs, consider this
as a dynamic demi-exclusive mode. Task trigger work to settle it's
group into a proper partition (minimum predicted load), then try
migrate itself into it. To gradually settle groups into the most
exclusively partition.

GB can be seen as an optimize policy based on load balance,
it obeys the main idea of load balance and makes adjustment
based on that.

Our test on ARM64 platform with 128 CPUs shows that,
throughput of sysbench memory is improved about 25%,
and redis-benchmark is improved up to about 10%.

See each patch for detail:
The 1st patch introduces infrastructure.
The 2nd patch introduces detail about partition info.
The 3rd patch is the main part of group balancer.
The 4th patch is about stats.

v2:
Put partition info and period settings to cpuset subsys of cgroup_v2.

v1: https://lore.kernel.org/all/98f41efd-74b2-198a-839c-51b785b748a6@linux.alibaba.com/

Michael Wang (1):
  sched: Introduce group balancer

Tianchen Ding (3):
  sched, cpuset: Introduce infrastructure of group balancer
  cpuset: Handle input of partition info for group balancer
  cpuset, gb: Add stat for group balancer

 include/linux/cpuset.h   |   5 +
 include/linux/sched.h    |   5 +
 include/linux/sched/gb.h |  70 ++++++
 init/Kconfig             |  12 +
 kernel/cgroup/cpuset.c   | 405 +++++++++++++++++++++++++++++++-
 kernel/sched/Makefile    |   1 +
 kernel/sched/core.c      |   5 +
 kernel/sched/debug.c     |  10 +-
 kernel/sched/fair.c      |  26 ++-
 kernel/sched/gb.c        | 487 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h     |  14 ++
 11 files changed, 1037 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/sched/gb.h
 create mode 100644 kernel/sched/gb.c

-- 
2.27.0

