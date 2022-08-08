Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBC958C719
	for <lists+cgroups@lfdr.de>; Mon,  8 Aug 2022 13:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242230AbiHHLE0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Aug 2022 07:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiHHLEZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Aug 2022 07:04:25 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9A355B8
        for <cgroups@vger.kernel.org>; Mon,  8 Aug 2022 04:04:24 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f11so8251983pgj.7
        for <cgroups@vger.kernel.org>; Mon, 08 Aug 2022 04:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZuKaLhLa5tbyftaj2zqrE8vh2E3RCbHj+YPIfBePDGE=;
        b=JAQoR2JLXXcFnQ+8VpKRcSa7MZKg44EUwQQjW+f+SUR7Y8Few/TDsJ9Ogq4yvpQkwW
         8+B3YBQuZUiDJnBaB5UNAWggMNoZ5zgoDgeNyV5SWJhDp7xaX+a3KRoq2sdt5+pGHiJj
         J2lXpcXgMUPbB1AC9mG57fI+Sxg38YAQJhb1DOd5BCeB9F7C40I8dXP1YsPOmieLh+oC
         TSHR6XDNtwsjfy9f8dKalMpr+LlGpfkvb+jfGp7y1I7JyLeohHqLtXJ1fuyNgJ5n8XZR
         wOvzJ5RUbwKdSolOiqm1o2NHdMgOAtOgCOcdsIUM5E6c85XAzgaTHhj3kM8MH6J13fKI
         xeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZuKaLhLa5tbyftaj2zqrE8vh2E3RCbHj+YPIfBePDGE=;
        b=rjqgWMdFdjcy30EoelqK6Mg1MP1Ibjzxb9rPKJ39Uo2nYshgem47yXKmjgYHqlvQDK
         W3ZOrQOFhVL9i2bafHRD7Sa+NuRxIQKmHmAPqkbB1yqcaLxlt9rS9Qv/ubBm8c2b7NaZ
         CVqY2wayLLfO5xIT7woTUrkZEfWQJ3ugKYNL4UTqup2mgfu0OKwhwmTaNs3SxkJw+ifF
         +C/IkbAB4FV/Id7qWcAHa7wGUviURR0rf27xHI+3qm1KCTIL2iP2/8KlTunIenPwimco
         qPB6BxcKtAUkM6VA32p6jqPD6B9qll2SaXsnAcTGMgispZIVu3JW83DYhce/bSUosUbC
         s5wQ==
X-Gm-Message-State: ACgBeo0ljWLAZ79cV44z1CHr7wj0hpUuzZkHNBKcO8qtQ75pfzXleRkp
        AkXIYHWcrUU4XOAyJU8yvh09iA==
X-Google-Smtp-Source: AA6agR6zDPXQY3Pw1hQQ2D5P5qZ7Io4Bha6vxRoupYISbJY9B7ar2YM4dAemZajGV+OvlSLIWAZBog==
X-Received: by 2002:a05:6a00:a08:b0:52b:fd6e:b198 with SMTP id p8-20020a056a000a0800b0052bfd6eb198mr18177801pfh.53.1659956663580;
        Mon, 08 Aug 2022 04:04:23 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7978c000000b0052dbad1ea2esm8393180pfp.6.2022.08.08.04.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:04:22 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 00/10] sched/psi: some optimization and extension
Date:   Mon,  8 Aug 2022 19:03:31 +0800
Message-Id: <20220808110341.15799-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

This patch series are some optimization and extension for PSI, based on
the tip/sched/core branch.

patch 1/10 fix periodic aggregation shut off problem introduced by earlier
commit 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups").

patch 2/10 optimize task switch inside shared cgroups when in_memstall status
of prev task and next task are different.

patch 3-4 optimize and simplify PSI status tracking by don't change task
psi_flags when migrate CPU/cgroup.

patch 7/10 remove NR_ONCPU task accounting to save 4 bytes in the first
cacheline to be used by the following patch 8/10, which introduce new
PSI resource PSI_IRQ to track IRQ/SOFTIRQ pressure stall information.

patch 9/10 introduce a per-cgroup interface "cgroup.psi" to disable
or re-enable PSI stats accounting in the cgroup level.

patch 10/10 cache parent psi_group in struct psi_group to speed up
the hot iteration path.

Thanks!

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
  sched/psi: optimize task switch inside shared cgroups again
  sched/psi: move private helpers to sched/stats.h
  sched/psi: don't change task psi_flags when migrate CPU/group
  sched/psi: don't create cgroup PSI files when psi_disabled
  sched/psi: save percpu memory when !psi_cgroups_enabled
  sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
  sched/psi: per-cgroup PSI stats disable/re-enable interface
  sched/psi: cache parent psi_group to speed up groups iterate

Johannes Weiner (1):
  sched/psi: remove NR_ONCPU task accounting

 Documentation/admin-guide/cgroup-v2.rst |  13 ++
 include/linux/psi.h                     |   6 +-
 include/linux/psi_types.h               |  25 +--
 include/linux/sched.h                   |   3 -
 kernel/cgroup/cgroup.c                  |  73 +++++++
 kernel/sched/core.c                     |   2 +
 kernel/sched/psi.c                      | 247 +++++++++++++++++-------
 kernel/sched/stats.h                    |  60 +++---
 8 files changed, 313 insertions(+), 116 deletions(-)

-- 
2.36.1

