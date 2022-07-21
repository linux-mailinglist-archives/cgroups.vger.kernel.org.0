Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCCD57C31E
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 06:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiGUEFM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 00:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiGUEFF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 00:05:05 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBB8278
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:04 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bf13so502619pgb.11
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTUtciELDeUFP9YP7rSaShsOCbzI7poCIUEZlQHjgPU=;
        b=X7slEwVNzOA4SvR6+UzacobU5Ug/dz94gOEN7pAFTdSNd9xZdz08+zlSKHsdwOLoRt
         iNyy6n95zaI/xRzVsBx3OCK/CTa5pJqYfIYD5e9q+1R6fVh51E5EZrqDYAx7mP4hCYm4
         MWPqJeGu0OLiIahmXD4tNDzAmeTYF+OdFLenYGIDq5uqoUPy7gXO8lRzmABO9Va4i/GI
         2+1ExmHAKB+79axJoSXTeCQWRcBoMO40LGYC1IbEn6N3pXe2R14PnVUwO5ocDeGDO42o
         p6FPyugaUju6EfK1YwI+UYIBih58EYtCIRrNp/BsqYBsp1HfDTfujG7dgK6PxPbGb4UE
         9ZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTUtciELDeUFP9YP7rSaShsOCbzI7poCIUEZlQHjgPU=;
        b=CmIWBh2bHfhEk3OkSQoY64cfGEF3HEHS+wYuo3xc88AAXofG9VXIqBBNGkk4aKYosH
         xPomG5e3ui9bNYGBWzgaSZvYL3lkY6t0yQGwg7ZebW5UCtgweoYgIdZOludALBAKo6Yr
         pFqr2/nmnERFPVevnGpGsqCBbQybc8cz0/NIgaeXm/bQTE7iISocOvAg40Uq6FsmT+Yq
         aQsvVNroZyJVSTTHpL8LzxB0Xs3IEKV++jTU/y2lEtAN8mqDOrIgwC+Kgqj0APNWNmgr
         wGsVGYw+ewQ3ZISILRRIphTOSXg7QMSBY0C5y309phAkTyh4+4VuSSgfEuV6Nj32v5jn
         4DAQ==
X-Gm-Message-State: AJIora8/PCoLMHNVKW47BkI8Ac83FrVHl/2pjX2rueOUccVfvhRfYyo7
        xIdLw0PRh521Sd0ngHk97ZebKQ==
X-Google-Smtp-Source: AGRyM1smn8TNFzzfVUfamTsiOL5mupljniycDdAUTBCeuA1EAjNOQSsmxlk+4rCRs4MVfn5XtRN4Eg==
X-Received: by 2002:a63:c15:0:b0:411:f92a:8ec7 with SMTP id b21-20020a630c15000000b00411f92a8ec7mr36026236pgl.86.1658376303964;
        Wed, 20 Jul 2022 21:05:03 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm384368pln.110.2022.07.20.21.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:05:03 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, tj@kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 2/9] sched/psi: optimize task switch inside shared cgroups again
Date:   Thu, 21 Jul 2022 12:04:32 +0800
Message-Id: <20220721040439.2651-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721040439.2651-1-zhouchengming@bytedance.com>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

commit 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
defer prev task sleep handling to psi_task_switch(), so we don't need
to clear and set TSK_ONCPU state for common cgroups.

    A
    |
    B
   / \
  C   D
 /     \
prev   next

After that commit psi_task_switch() do:
1. psi_group_change(next, .set=TSK_ONCPU) for D
2. psi_group_change(prev, .clear=TSK_ONCPU | TSK_RUNNING) for C
3. psi_group_change(prev, .clear=TSK_RUNNING) for B, A

But there is a limitation "prev->psi_flags == next->psi_flags" that
if not satisfied, will make this cgroups optimization unusable for both
sleep switch or running switch cases. For example:

prev->in_memstall != next->in_memstall when sleep switch:
1. psi_group_change(next, .set=TSK_ONCPU) for D, B, A
2. psi_group_change(prev, .clear=TSK_ONCPU | TSK_RUNNING) for C, B, A

prev->in_memstall != next->in_memstall when running switch:
1. psi_group_change(next, .set=TSK_ONCPU) for D, B, A
2. psi_group_change(prev, .clear=TSK_ONCPU) for C, B, A

The reason why this limitation exist is that we consider a group is
PSI_MEM_FULL if the CPU is actively reclaiming and nothing productive
could run even if it were runnable. So when CPU curr changed from prev
to next and their in_memstall status is different, we have to change
PSI_MEM_FULL status for their common cgroups.

This patch remove this limitation by making psi_group_change() change
PSI_MEM_FULL status depend on CPU curr->in_memstall status.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/psi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index c8a4e644cd2c..e04041d8251b 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -823,8 +823,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	u64 now = cpu_clock(cpu);
 
 	if (next->pid) {
-		bool identical_state;
-
 		psi_flags_change(next, 0, TSK_ONCPU);
 		/*
 		 * When switching between tasks that have an identical
@@ -832,11 +830,9 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 * we reach the first common ancestor. Iterate @next's
 		 * ancestors only until we encounter @prev's ONCPU.
 		 */
-		identical_state = prev->psi_flags == next->psi_flags;
 		iter = NULL;
 		while ((group = iterate_groups(next, &iter))) {
-			if (identical_state &&
-			    per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
+			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
 				common = group;
 				break;
 			}
@@ -883,7 +879,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
 		 * with dequeuing too, finish that for the rest of the hierarchy.
 		 */
-		if (sleep) {
+		if (sleep || unlikely(prev->in_memstall != next->in_memstall)) {
 			clear &= ~TSK_ONCPU;
 			for (; group; group = iterate_groups(prev, &iter))
 				psi_group_change(group, cpu, clear, set, now, true);
-- 
2.36.1

