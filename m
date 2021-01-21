Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A7D2FE9AD
	for <lists+cgroups@lfdr.de>; Thu, 21 Jan 2021 13:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbhAUMLx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jan 2021 07:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbhAUMLr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jan 2021 07:11:47 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D87AC061575
        for <cgroups@vger.kernel.org>; Thu, 21 Jan 2021 04:11:06 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id j12so1358841pfj.12
        for <cgroups@vger.kernel.org>; Thu, 21 Jan 2021 04:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00EJOlGNqegMy5hWj3ItO3z7nmI6UcSXmhSyNLe26rA=;
        b=Tpb68P6eh9RtW9ZhJwuC5B/7Aj+ZcjD8RwvLQuwoYlLwq/++4HrqNwWBiByaQYuCm0
         5rJ6ffcjoutyckNMCnTx5L+fQNtdqgnu72Ps/43BQHDTXZ4Bh5Fp+vqsw9N5XxlsVs/R
         hAwEet96Bu1G3nmsVE5V4LDFNd988ALXH3K7+A/iVOn7cdZevK2tz7CxhKIGSs/dX206
         6hC9ekk9a+UaZ3Z6ryoi7bzoov1BnqdxC3X5LEIvjQ8JdL57Sf2/EJAKgD1/5zoZddFO
         tuK9zXzQ3TJJ6c9J0P7v6Gl+Nwb/68bNk4nmIBDQX1fJ2yDMBZXYw04MUxSd33dzsnQK
         jddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00EJOlGNqegMy5hWj3ItO3z7nmI6UcSXmhSyNLe26rA=;
        b=ZicQsjv84s0cYK0VFTvkxQpPPycZFQAiVrJXVzYH6B4R1M/hBouBPa2jdTjrjwta4R
         HetOqUy6E70NpRqD4WuFzxihhy4tWv+CbO7MVhkVRb9/ldS/9bkVEQUtE0fyaElHmmZV
         kvUJtuAaE1EFNgNfbTMG3yKCKip/YwbRP2Z9bGshtp8s4zYykxBW//0AoHGvczOwPT1o
         1BAhTj2vJ+zapd8beuEQQKi6LSQpTeN152zZMPjJhSiqky+Gn70cmBLqWTFj/NgaiVFZ
         ZsKO14vI5V/a9Eq1C6r4TdxjivLYkX/NadX2eeLad4BYTygV+kZztNCfgSunqQJxHaS3
         MHUw==
X-Gm-Message-State: AOAM5322IsEr7mW7uRRXRX1OOV7hv4f1JAKy01GCK5MfXh0ZvL9jSpPj
        snweC2C+oDpmNgAMZ/mXvTQ=
X-Google-Smtp-Source: ABdhPJyqxbcU99KoR1fsASF23wwPk/UuHSMnaag5YuU0LeKv386/1MGT4+6vgBaUZOfDQf3daVxsOg==
X-Received: by 2002:a63:e54f:: with SMTP id z15mr14172633pgj.247.1611231066153;
        Thu, 21 Jan 2021 04:11:06 -0800 (PST)
Received: from localhost.localdomain ([150.109.106.156])
        by smtp.gmail.com with ESMTPSA id i67sm5643467pfc.153.2021.01.21.04.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 04:11:05 -0800 (PST)
From:   wu860403@gmail.com
To:     tj@kernel.org, cgroups@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, 398776277@qq.com,
        Liming Wu <wu860403@gmail.com>
Subject: [PATCH V2] tg: add sched wait_count of a task group
Date:   Fri, 22 Jan 2021 04:11:57 +0800
Message-Id: <20210121201157.1933-1-wu860403@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Liming Wu <wu860403@gmail.com>

Now we can rely on PSI to reflect whether there is contention in
the task group, but it cannot reflect the details of the contention.
Through this metric, we can get avg latency of task group contention
 from the dimension of scheduling.
   delta(wait_usec)/delta(nr_waits)
Also change wait_sum to wait_usec.

Signed-off-by Liming Wu <wu860403@gmail.com>
---
 kernel/sched/core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7e453492..45e46114e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8146,12 +8146,17 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 
 	if (schedstat_enabled() && tg != &root_task_group) {
 		u64 ws = 0;
+		u64 wc = 0;
 		int i;
 
-		for_each_possible_cpu(i)
+		for_each_possible_cpu(i) {
 			ws += schedstat_val(tg->se[i]->statistics.wait_sum);
+			wc += schedstat_val(tg->se[i]->statistics.wait_count);
+		}
 
-		seq_printf(sf, "wait_sum %llu\n", ws);
+		do_div(ws, NSEC_PER_USEC);
+		seq_printf(sf, "wait_usec %llu\n"
+			   "nr_waits %llu\n", ws, wc);
 	}
 
 	return 0;
@@ -8255,6 +8260,20 @@ static int cpu_extra_stat_show(struct seq_file *sf,
 			   "throttled_usec %llu\n",
 			   cfs_b->nr_periods, cfs_b->nr_throttled,
 			   throttled_usec);
+		if (schedstat_enabled() && tg != &root_task_group) {
+			u64 ws = 0;
+			u64 wc = 0;
+			int i;
+
+			for_each_possible_cpu(i) {
+				ws += schedstat_val(tg->se[i]->statistics.wait_sum);
+				wc += schedstat_val(tg->se[i]->statistics.wait_count);
+			}
+
+			do_div(ws, NSEC_PER_USEC);
+			seq_printf(sf, "wait_usec %llu\n"
+				   "nr_waits %llu\n", ws, wc);
+		}
 	}
 #endif
 	return 0;
-- 
2.20.1

