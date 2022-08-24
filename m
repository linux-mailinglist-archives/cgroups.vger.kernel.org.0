Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AF259F4F3
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 10:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiHXIUN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 04:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiHXIUL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 04:20:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B5685F9E
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 01:20:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f21so16339682pjt.2
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 01:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=h1njInj6+0OhDb5dvpxX7bRUejwiRI98B8XQXql9WZQ=;
        b=6yf8wi5zNwzZEIkCgVGTFObmPAniOIiQplzYcLSqdfynQw4Vz6bS6N+/FmuzSny6ig
         IbyW0Ll7Ib5/jwQy0MXG8EzqmWCb3Z+6uOTpaat+70mhVmkKwAycfew2QvqpBorPYVpn
         j8UXv3nEOdb0xJXxSQbqLZu2SGvwDIRpmeOsvG6Meij2IOzxPdRcyTYoyp4tnOaBvrG0
         ij0kKjV6+2yUcfuz5jgsZTb1l8Je8MXPyvvGRgtN8nbzcgBCzC+9q+XiNo6ZvIudhAV+
         C3bE3iISnulIycKcpmRz9qXnmLn7bqfELsePToRk1Ibz7O2hAhd646bBzd+ws075cyUU
         k5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=h1njInj6+0OhDb5dvpxX7bRUejwiRI98B8XQXql9WZQ=;
        b=z+gcJa/LFz/s5g0EMOE5vEyIrFzgdXxC6wwXp/qffUa67VCvB8S6JCXa8o7lE6Wd/+
         0HnSLMvUVyvlkOaxw1N2D82VYW7z1/Vgcp2tpQV/f4mudW+567o64vfxcbBVmSTj3kDN
         Z6eDI01HWK30WhYAgfcNqtMEhMndD3sW71L8g9wilIqIO543gKF6ZVK9yHuUlVlVaTW9
         c3LlZI4O1iMNxEBewZNkB8KxgnIv2JG6lpaIQAIH+3znQlLNlXekfRvxNCtJL3RgqCaa
         Nt40HA1/OVwxWrhgB3qJyj9A4EIiVRofPKBu4LimGmqnWW3EjD6YXoUfu6TDHIUy9fAl
         m6ng==
X-Gm-Message-State: ACgBeo07+hDMrGGI42PPR1uLc190wnG6S7jLL1rp/x+F73H33YZdn6oL
        cboZGzcM797B+Wl94eeTgrp4+Q==
X-Google-Smtp-Source: AA6agR5rrAy3gZcaFBGnbostM2BwS4dc/C5F1+ZodDYHXjtFDsV/x7DOwZWdoQqDtcedLKMDeBp79A==
X-Received: by 2002:a17:902:cec1:b0:16d:c4f2:66c5 with SMTP id d1-20020a170902cec100b0016dc4f266c5mr27326630plg.20.1661329209524;
        Wed, 24 Aug 2022 01:20:09 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id q31-20020a635c1f000000b00421841943dfsm10486587pgb.12.2022.08.24.01.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 01:20:09 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
        surenb@google.com
Cc:     gregkh@linuxfoundation.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 05/10] sched/psi: optimize task switch inside shared cgroups again
Date:   Wed, 24 Aug 2022 16:18:24 +0800
Message-Id: <20220824081829.33748-6-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824081829.33748-1-zhouchengming@bytedance.com>
References: <20220824081829.33748-1-zhouchengming@bytedance.com>
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
index 77d53c03a76f..26c03bd56b9c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -820,8 +820,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	u64 now = cpu_clock(cpu);
 
 	if (next->pid) {
-		bool identical_state;
-
 		psi_flags_change(next, 0, TSK_ONCPU);
 		/*
 		 * When switching between tasks that have an identical
@@ -829,11 +827,9 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
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
@@ -880,7 +876,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
 		 * with dequeuing too, finish that for the rest of the hierarchy.
 		 */
-		if (sleep) {
+		if (sleep || unlikely(prev->in_memstall != next->in_memstall)) {
 			clear &= ~TSK_ONCPU;
 			for (; group; group = iterate_groups(prev, &iter))
 				psi_group_change(group, cpu, clear, set, now, wake_clock);
-- 
2.37.2

