Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50FA57C319
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 06:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiGUEE5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 00:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGUEEz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 00:04:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BBA78DD4
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:04:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c139so651636pfc.2
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlT8dJ+SuEpxWbwnTjcmhPJvri3/6RijHoI8W5wIpvE=;
        b=H9ztJ4r8ShB6bSUSZJFMPYUxMNR8vvrsj1vt/lH9VHmmw3uBP3eIA2PcKWgSk5Q1wl
         K+NcysZKOjHUbek7EISv8xVcQMPs1sTGj0HW5Mfd629xhyR5bdeMHK63uPa4P2L57oRK
         6WRaAi3FgUrKi1UIeYRSKabGyZ6TMQgKrXM4l13lAGR8uJx+QHl866OES1by3VoRC9ru
         H5964XviIHKzcr7Dvga63vKjgndZr+u73X1sTIUnWg55XCH3s9pI7mpxugcuy8bS6bnY
         YBlNIFVCvfxb09i/hJX0Po+LEWPjkjU+RGGh8/5HLywFC3w4wf7/4dARlKHJlXwqtQFN
         jVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlT8dJ+SuEpxWbwnTjcmhPJvri3/6RijHoI8W5wIpvE=;
        b=z6/bnYy4Od+QrcfSB45gymMBRcibnzSIpZu6Rv0rEbEcn9gaHpghAdgSNmX1EWEsUp
         Qm1SOpiPHV3cM6lcZP/Gkxsf4oY7O1/hxqdVqK1ugnYDmmuodXFrnNFJzridcivzZtdj
         ccKG6EAYIOXXtKt2Emx6JA1PXQm9NpSMFL+dyT39rzEgdN/gCRbB5LLEktnwUBiaHrRf
         PKf94KXFykCv6/Is/X0q3kcxkgtaiMdGO8VX7/+Pn72nCJh56BH0+UewWnfLjE/fU/6U
         CJRgujTxtp+YCKVRKvYqjOX5gQHy/+Utli/zF1mj8nGOL96PsfLWng7/b+C3nbE+KQmg
         qqcw==
X-Gm-Message-State: AJIora+EQnIcnX330D+pA48laezrf5J3YKdaXK2Jh4Z1B4jlxbkueik8
        5OsZF7iEn9/dxrKJER8Mv8JdrA==
X-Google-Smtp-Source: AGRyM1sBch0MsWSENaHyUgonMPLodkwYZhzX4W5iVZPf7/0S9iIdmJFM115fFOAFhzSInW+UExWjfQ==
X-Received: by 2002:a62:b617:0:b0:52b:3246:ad98 with SMTP id j23-20020a62b617000000b0052b3246ad98mr33466080pff.3.1658376293466;
        Wed, 20 Jul 2022 21:04:53 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm384368pln.110.2022.07.20.21.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:04:53 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, tj@kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 0/9] sched/psi: some optimization and extension
Date:   Thu, 21 Jul 2022 12:04:30 +0800
Message-Id: <20220721040439.2651-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

This patch series are some optimization and extension for PSI.

patch 1/9 fix periodic aggregation shut off problem introduced by earlier
commit 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups").

patch 2/9 optimize task switch inside shared cgroups when in_memstall status
of prev task and next task are different.

patch 3-4 optimize and simplify PSI status tracking by don't change task
psi_flags when migrate CPU/cgroup.

patch 7-8 introduce new kernel cmdline parameter "psi_inner_cgroup=" to
configure whether or not to track PSI stall information for inner cgroups.

patch 9/9 introduce new PSI resource PSI_IRQ to track IRQ/SOFTIRQ pressure
stall information when CONFIG_IRQ_TIME_ACCOUNTING.

Performance test on Intel Xeon Platinum with 3 levels of cgroup, in which
run mmtests config-scheduler-perfpipe:

                                  tip                    tip                    tip                patched                patched                patched                patched
                               default   cgroup_disable=pressure  IRQ_TIME_ACCOUNTING              default      psi_inner_cgroup=off             PSI_IRQ    PSI_IRQ + psi_inner_cgroup=off
Min       Time        9.89 (   0.00%)        8.99 (   9.12%)       10.04 (  -1.53%)        9.63 (   2.58%)        9.27 (   6.22%)       10.09 (  -2.04%)        9.45 (   4.41%)
1st-qrtle Time       10.01 (   0.00%)        9.15 (   8.66%)       10.16 (  -1.45%)        9.72 (   2.89%)        9.35 (   6.61%)       10.20 (  -1.81%)        9.54 (   4.77%)
2nd-qrtle Time       10.07 (   0.00%)        9.25 (   8.12%)       10.19 (  -1.21%)        9.79 (   2.73%)        9.38 (   6.78%)       10.24 (  -1.75%)        9.59 (   4.68%)
3rd-qrtle Time       10.14 (   0.00%)        9.30 (   8.32%)       10.23 (  -0.88%)        9.84 (   3.00%)        9.44 (   6.92%)       10.27 (  -1.21%)        9.62 (   5.18%)
Max-1     Time        9.89 (   0.00%)        8.99 (   9.12%)       10.04 (  -1.53%)        9.63 (   2.58%)        9.27 (   6.22%)       10.09 (  -2.04%)        9.45 (   4.41%)
Max-5     Time        9.89 (   0.00%)        8.99 (   9.12%)       10.04 (  -1.53%)        9.63 (   2.58%)        9.27 (   6.22%)       10.09 (  -2.04%)        9.45 (   4.41%)
Max-10    Time        9.92 (   0.00%)        9.09 (   8.33%)       10.11 (  -1.97%)        9.67 (   2.51%)        9.29 (   6.29%)       10.15 (  -2.30%)        9.48 (   4.46%)
Max-90    Time       10.20 (   0.00%)        9.33 (   8.53%)       10.33 (  -1.24%)        9.87 (   3.29%)        9.49 (   6.99%)       10.29 (  -0.85%)        9.66 (   5.32%)
Max-95    Time       10.23 (   0.00%)        9.34 (   8.70%)       10.37 (  -1.39%)        9.94 (   2.83%)        9.53 (   6.88%)       10.30 (  -0.65%)        9.67 (   5.51%)
Max-99    Time       10.23 (   0.00%)        9.37 (   8.43%)       10.40 (  -1.63%)        9.99 (   2.41%)        9.76 (   4.57%)       10.31 (  -0.74%)        9.69 (   5.25%)
Max       Time       10.34 (   0.00%)        9.46 (   8.50%)       10.43 (  -0.83%)       17.04 ( -64.80%)        9.79 (   5.36%)       10.32 (   0.20%)        9.71 (   6.07%)
Amean     Time       10.08 (   0.00%)        9.23 *   8.39%*       10.21 *  -1.33%*       10.03 (   0.47%)        9.41 *   6.59%*       10.23 *  -1.53%*        9.59 *   4.87%*

Thanks!

Chengming Zhou (9):
  sched/psi: fix periodic aggregation shut off
  sched/psi: optimize task switch inside shared cgroups again
  sched/psi: move private helpers to sched/stats.h
  sched/psi: don't change task psi_flags when migrate CPU/group
  sched/psi: don't create cgroup PSI files when psi_disabled
  sched/psi: save percpu memory when !psi_cgroups_enabled
  sched/psi: cache parent psi_group to speed up groups iterate
  sched/psi: add kernel cmdline parameter psi_inner_cgroup
  sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure

 .../admin-guide/kernel-parameters.txt         |  11 +
 include/linux/psi.h                           |   5 +-
 include/linux/psi_types.h                     |   9 +-
 include/linux/sched.h                         |   3 -
 kernel/cgroup/cgroup.c                        |  30 +++
 kernel/sched/core.c                           |   2 +
 kernel/sched/psi.c                            | 194 +++++++++++++-----
 kernel/sched/stats.h                          |  71 ++++---
 8 files changed, 232 insertions(+), 93 deletions(-)

-- 
2.36.1

