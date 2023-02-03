Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442DA68A6DB
	for <lists+cgroups@lfdr.de>; Sat,  4 Feb 2023 00:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjBCXYV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 18:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjBCXYU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 18:24:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A355A07ED;
        Fri,  3 Feb 2023 15:24:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 222D2B82C3E;
        Fri,  3 Feb 2023 23:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFECEC433D2;
        Fri,  3 Feb 2023 23:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675466656;
        bh=DPCD11U3iraVLwoI0ZmoNtXTwzpTxLUsmQXJIlJGVSE=;
        h=From:To:Cc:Subject:Date:From;
        b=iYsRI9WEJSXvQrf3WdnsJctWyoYSHpJ9XXhS6XfxCe9MFaOWmzH9nklIEiPNAFzk8
         pgm2UXKuqznGQ9qmSaKceq8HGb2NVkuTjU9EHO047NuRFGkIkK7AlwYph4NuaW6CQu
         Yfv4Tt5Kmfs5Ph+phIQd92418JDtLA37TmbbZntv5WKDNeGCmoA3lLPfpheDROYOBy
         lex84MWnpMjkDQaUxDAy4Gg9ssjU4vP/ZmUrpgKdpkwdhD6w39f63rijUzdbVrr8Su
         QF5e33ZTIhClNBvjwku0s/7M1KOLWbStucstrSvrrl6/K6UOTQnzktd7t6vVSWSsLw
         Wg9XHpLFpy0LA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/2] sched/isolation: Prep work for pcp cache draining isolation
Date:   Sat,  4 Feb 2023 00:24:07 +0100
Message-Id: <20230203232409.163847-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For reference: https://lore.kernel.org/lkml/20230125073502.743446-1-leobras@redhat.com/
And the latest proposal: https://lore.kernel.org/lkml/Y90mZQhW89HtYfT9@dhcp22.suse.cz/

Pcp cache draining isolation needs a function that abstracts checking
if a CPU is isolated through isolcpus= or nohz_full=. Take advantage
of that to do some cleanups.

Frederic Weisbecker (2):
  sched/isolation: Merge individual nohz_full features into a common
    housekeeping flag
  sched/isolation: Add cpu_is_isolated() API

 arch/x86/kvm/x86.c              |  2 +-
 drivers/char/random.c           |  2 +-
 drivers/pci/pci-driver.c        |  2 +-
 include/linux/sched/isolation.h | 13 +++++++------
 include/net/ip_vs.h             |  4 ++--
 kernel/cpu.c                    |  4 ++--
 kernel/kthread.c                |  4 ++--
 kernel/rcu/tasks.h              |  2 +-
 kernel/rcu/tree_plugin.h        |  6 +++---
 kernel/sched/core.c             | 12 ++++++------
 kernel/sched/fair.c             |  6 +++---
 kernel/sched/isolation.c        | 22 ++++++----------------
 kernel/watchdog.c               |  2 +-
 kernel/workqueue.c              |  2 +-
 net/core/net-sysfs.c            |  2 +-
 net/netfilter/ipvs/ip_vs_ctl.c  |  2 +-
 16 files changed, 39 insertions(+), 48 deletions(-)

-- 
2.34.1

