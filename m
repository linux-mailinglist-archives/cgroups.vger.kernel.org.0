Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD3459F4E7
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 10:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiHXITn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 04:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiHXITl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 04:19:41 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E602B8A1F8
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 01:19:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c13-20020a17090a4d0d00b001fb6921b42aso788577pjg.2
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 01:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=sIwNmqerjqaiTdP/9SuVUBFcXcyvJnbToq4VHqojaB8=;
        b=Om+ippFq5VDjfampfj8skRptXpd8NK2EmMp93WkO1WFM2P+9cmvM50W9OIQ8PYKZ3Z
         V7YaOExX88F5cnsKw+Yx6nnJ1spX+YL2qWPVeXJyCeECldNQm/Yy9dajP8ZBfunV0mZT
         VKAK8TXVEQs6Bso6BAxV40s72baz1S0t1fRI77xf4iTajYadAHra4Z6LEo6mexc/KEVH
         TZ7EcwSaIQtHsiCvDWxTC6jHbBxc8LbvGRrhqGsgCDqPIHrTyUhZpFm2DX48W6DSAFxL
         NsRG6zAsn4cyfoRZjvWKOHogMQwNFHla7+6OrD+EXHdzhEuSDeoOqq+igUU8PuC2KTTV
         SmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=sIwNmqerjqaiTdP/9SuVUBFcXcyvJnbToq4VHqojaB8=;
        b=FqXzCQmaHiFrcnDAjFXBeN6oPpIFq5gM70C6VLN5MQ2qkiQkiGGs03w1JHDKbstktT
         q0jLYPkf5QXUlEY/3XcwV2/nTXQjyQFIey8Z92mLW3UzxPcUhmlHL+TexGBhfgWcx6j5
         84k2eteVBGRlW5uckKu8tBBvYXeyj+ZSldAsPg54bi+Csq4rhuGW+nMJr3iddrdhFKOd
         xEVk1E/QiSMl0bpByy84by9SCvO/kiL5r+OC6wWwq327oFeWAa7T50BL3sOsD0Hah/5L
         BEdzPMaOQzTgZfJURvY/U2sdkE27DcdtJMl0o8x5K3O3tBdlvtaT5XMjpNM26Jpjbp9Z
         quKw==
X-Gm-Message-State: ACgBeo0k4+xe5zFe+a3cOZAPTmcJH91YHnxT2XtdlH5lC0L5xDVdCpN5
        hLmBaY2jb2qAv+KZXiflJLAAXg==
X-Google-Smtp-Source: AA6agR4NpnRl7tswuvOVEEShny7ZGZFjiBpQFwhiy6DYHpH87TljkmO6cvTMvAAr/laPHWUTA38cbA==
X-Received: by 2002:a17:90a:e7ce:b0:1fb:3f8b:95ee with SMTP id kb14-20020a17090ae7ce00b001fb3f8b95eemr7301543pjb.110.1661329179179;
        Wed, 24 Aug 2022 01:19:39 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id q31-20020a635c1f000000b00421841943dfsm10486587pgb.12.2022.08.24.01.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 01:19:38 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
        surenb@google.com
Cc:     gregkh@linuxfoundation.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 00/10] sched/psi: some optimization and extension
Date:   Wed, 24 Aug 2022 16:18:19 +0800
Message-Id: <20220824081829.33748-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

patch 8-9 cache parent psi_group in struct psi_group to speed up
the hot iteration path.

patch 10/10 introduce a per-cgroup interface "cgroup.pressure" to disable
or re-enable PSI in the cgroup level, and we implement hiding and unhiding
the pressure files per Tejun's suggestion[1], which depends on his work[2].

[1] https://lore.kernel.org/all/YvqjhqJQi2J8RG3X@slm.duckdns.org/
[2] https://lore.kernel.org/all/20220820000550.367085-1-tj@kernel.org/

Performance test using mmtests/config-scheduler-perfpipe in /user.slice/user-0.slice/session-4.scope

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

Thanks!

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

 Documentation/admin-guide/cgroup-v2.rst |  23 +++
 include/linux/cgroup-defs.h             |   3 +
 include/linux/cgroup.h                  |   5 -
 include/linux/psi.h                     |  12 +-
 include/linux/psi_types.h               |  29 ++-
 kernel/cgroup/cgroup.c                  |  94 ++++++++-
 kernel/sched/core.c                     |   1 +
 kernel/sched/psi.c                      | 256 +++++++++++++++++-------
 kernel/sched/stats.h                    |   6 +
 9 files changed, 338 insertions(+), 91 deletions(-)

-- 
2.37.2

