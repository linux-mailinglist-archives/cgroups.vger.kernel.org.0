Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302485A170E
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243085AbiHYQnX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 12:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbiHYQnE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 12:43:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40209BB00D
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 09:42:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id c16-20020a17090aa61000b001fb3286d9f7so5833729pjq.1
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=OtUK9OLMWdL6AUc3ZfpyXK1kgh1agdbXcj5hc+979G8=;
        b=xHJiXgBT7PEkZdMevyBPSnrJlZZCDwl6ozciskiNf9lpSMP/BhlEA/uOVlntwEOMoP
         8AsYSYGjz+lts4hRawuyJ6l6j1hjlPAVOBqnpGUKXbtEw9ZdqEkFmWYzCoRhk5hEVMqd
         LookuDXfD+8p7qtuCBQ2Us57jbxcmrBlqm9sBNsMnW+PY5fnbQg7FmU8Pv54Ao1pZ+jO
         Qlv7oV81DA9EYTvqlGNwLjuuhXOAJPyHxTpLFABwb7wAi1ZGz+PtCwoQyKk7qJ6TBCwf
         YrTIDzukpS+oc/W+qzGWsltS5E3XkCXyR6vIOWTqg9xpCYf+3ygIVs+5KfRLmrQe7Qwx
         altQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=OtUK9OLMWdL6AUc3ZfpyXK1kgh1agdbXcj5hc+979G8=;
        b=3ChLLjM923l0jtKuGlpAarblz7YPcq8dGDQPJBI37T5yWlWMl5T734OGU42xx394pq
         fURnHl7Frnrs/OgfxB8Ym5KUi9JCvUGIOl3MDArIOi1/HvFAz24WDvAfM5/p3Z8TYNmU
         dkOp8mDWmVPeClcZlnkiYiRlrveQJE68Mqv3bBDqi90uDiwRknQTHTf+DLTmmSV6ODpW
         XDXb5BkiXIpkJKGfPxw0zX8bD4Tse6oqcNmDHeuH/WWwLeFlwUtkj9F0BmrH3URS6eWi
         P9GCLIkZHe65HOIJoL3C+IIbbFn/BpPeSSThbLDD1YPtKWIcSqNtMCMOOLDxJpUdnDMh
         RO7Q==
X-Gm-Message-State: ACgBeo0LnFxM6tz7H8Ez9ywHP/WS1gBnSY3tNRS76BqreH4Ev3IOs4ky
        0Poqp71fwwv1HFbROFfUq6+i6SztIsbqQg==
X-Google-Smtp-Source: AA6agR4gxE/7slArmuUtR05sZfHFLCh81St/simPA+TXbSjCOklqEF54v1qmnT+n3VjgviN6ahhCMg==
X-Received: by 2002:a17:902:f70f:b0:171:2572:4f5e with SMTP id h15-20020a170902f70f00b0017125724f5emr4422269plo.40.1661445754247;
        Thu, 25 Aug 2022 09:42:34 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id b18-20020a62a112000000b005362314bf80sm12779408pff.67.2022.08.25.09.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:42:33 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com,
        surenb@google.com
Cc:     mingo@redhat.com, peterz@infradead.org, gregkh@linuxfoundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 00/10] sched/psi: some optimizations and extensions
Date:   Fri, 26 Aug 2022 00:41:01 +0800
Message-Id: <20220825164111.29534-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

This patch series are some optimizations and extensions for PSI.

patch 1/10 fix periodic aggregation shut off problem introduced by earlier
commit 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups").

patch 2-4 are some misc optimizations, so put them in front of this series.

patch 5/10 optimize task switch inside shared cgroups when in_memstall status
of prev task and next task are different.

patch 6/10 remove NR_ONCPU task accounting to save 4 bytes in the first
cacheline to be used by the following patch 7/10, which introduce new
PSI resource PSI_IRQ to track IRQ/SOFTIRQ pressure stall information.

patch 8-9 cache parent psi_group in struct psi_group to speed up the
hot iteration path.

patch 10/10 introduce a per-cgroup interface "cgroup.pressure" to disable
or re-enable PSI in the cgroup level, and we implement hiding and unhiding
the pressure files per Tejun's suggestion[1], which depends on his work[2].

[1] https://lore.kernel.org/all/YvqjhqJQi2J8RG3X@slm.duckdns.org/
[2] https://lore.kernel.org/all/20220820000550.367085-1-tj@kernel.org/

Performance test using mmtests/config-scheduler-perfpipe in
/user.slice/user-0.slice/session-4.scope:

                                 next                patched       patched/only-leaf
Min       Time        8.82 (   0.00%)        8.49 (   3.74%)        8.00 (   9.32%)
1st-qrtle Time        8.90 (   0.00%)        8.58 (   3.63%)        8.05 (   9.58%)
2nd-qrtle Time        8.94 (   0.00%)        8.61 (   3.65%)        8.09 (   9.50%)
3rd-qrtle Time        8.99 (   0.00%)        8.65 (   3.75%)        8.15 (   9.35%)
Max-1     Time        8.82 (   0.00%)        8.49 (   3.74%)        8.00 (   9.32%)
Max-5     Time        8.82 (   0.00%)        8.49 (   3.74%)        8.00 (   9.32%)
Max-10    Time        8.84 (   0.00%)        8.55 (   3.20%)        8.04 (   9.05%)
Max-90    Time        9.04 (   0.00%)        8.67 (   4.10%)        8.18 (   9.51%)
Max-95    Time        9.04 (   0.00%)        8.68 (   4.03%)        8.20 (   9.26%)
Max-99    Time        9.07 (   0.00%)        8.73 (   3.82%)        8.25 (   9.11%)
Max       Time        9.12 (   0.00%)        8.89 (   2.54%)        8.27 (   9.29%)
Amean     Time        8.95 (   0.00%)        8.62 *   3.67%*        8.11 *   9.43%*

Big thanks to Johannes Weiner, Tejun Heo and Michal Koutný for your
suggestions and review!


Changes in v4:
 - Collect Acked-by tags from Johannes Weiner.
 - Add many clear comments and changelogs per Johannes Weiner.
 - Replace for_each_psi_group() with better open-code.
 - Change to use better names cgroup_pressure_show() and
   cgroup_pressure_write().
 - Change to use better name psi_cgroup_restart() and only
   call it on enabling.

Changes in v3:
 - Rebase on linux-next and reorder patches to put misc optimizations
   patches in the front of this series.
 - Drop patch "sched/psi: don't change task psi_flags when migrate CPU/group"
   since it caused a little performance regression and it's just
   code refactoring, so drop it.
 - Don't define PSI_IRQ and PSI_IRQ_FULL when !CONFIG_IRQ_TIME_ACCOUNTING,
   in which case they are not used.
 - Add patch 8/10 "sched/psi: consolidate cgroup_psi()" make cgroup_psi()
   can handle all cgroups including root cgroup, make patch 9/10 simpler.
 - Rename interface to "cgroup.pressure" and add some explanation
   per Michal's suggestion.
 - Hide and unhide pressure files when disable/re-enable cgroup PSI,
   depends on Tejun's work.

Changes in v2:
 - Add Acked-by tags from Johannes Weiner. Thanks for review!
 - Fix periodic aggregation wakeup for common ancestors in
   psi_task_switch().
 - Add patch 7/10 from Johannes Weiner, which remove NR_ONCPU
   task accounting to save 4 bytes in the first cacheline.
 - Remove "psi_irq=" kernel cmdline parameter in last version.
 - Add per-cgroup interface "cgroup.psi" to disable/re-enable
   PSI stats accounting in the cgroup level.


Chengming Zhou (9):
  sched/psi: fix periodic aggregation shut off
  sched/psi: don't create cgroup PSI files when psi_disabled
  sched/psi: save percpu memory when !psi_cgroups_enabled
  sched/psi: move private helpers to sched/stats.h
  sched/psi: optimize task switch inside shared cgroups again
  sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
  sched/psi: consolidate cgroup_psi()
  sched/psi: cache parent psi_group to speed up groups iterate
  sched/psi: per-cgroup PSI accounting disable/re-enable interface

Johannes Weiner (1):
  sched/psi: remove NR_ONCPU task accounting

 Documentation/admin-guide/cgroup-v2.rst |  23 ++
 include/linux/cgroup-defs.h             |   3 +
 include/linux/cgroup.h                  |   5 -
 include/linux/psi.h                     |  12 +-
 include/linux/psi_types.h               |  29 ++-
 kernel/cgroup/cgroup.c                  | 106 ++++++++-
 kernel/sched/core.c                     |   1 +
 kernel/sched/psi.c                      | 280 +++++++++++++++++-------
 kernel/sched/stats.h                    |   6 +
 9 files changed, 362 insertions(+), 103 deletions(-)

-- 
2.37.2

