Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264302F72E3
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 07:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbhAOG3f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 01:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbhAOG3e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 01:29:34 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2356DC061575
        for <cgroups@vger.kernel.org>; Thu, 14 Jan 2021 22:28:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e9so25367plh.3
        for <cgroups@vger.kernel.org>; Thu, 14 Jan 2021 22:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbRVLfFTFl245PvcYNPKPfmfRYJ/Oj1+0NVhnOPy8iU=;
        b=Ghj6FPYnkt4QNhyG8f5qpS/3xRNhmYk713fFOsUclYgV8W6X3ODPPvTONsfAE6Ns99
         PWmhEPT+kRkE847fTjGxhm9VGvvIAl/1vKEYQNXtfwI31sGqkhuuAu5egc01RkRYISi8
         ZLCYv1WoFL8s2wB/JYT5lIGi9/VxJRobm/S6qy3vWc0/Bpc44+XpB1Pf0Lkoe1xQonHv
         /VCTtKiOtfuFkxwEjLZDaRg46tG5hqU26y3hTiP/jK5rDQF9IXA65YV/BAgrfWuj7Zi1
         TVdobsmszfGP3oojf0UHV7Dez0UcIw0gqqJUtpfQ175lqtTiIWAUmNaFgS8fME/9YoFK
         0Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbRVLfFTFl245PvcYNPKPfmfRYJ/Oj1+0NVhnOPy8iU=;
        b=kYl1oQd4mfKg6hsl6Xs8aM5oUgbdq8anU2EpmbDFzofjiK3tGUwCYAdVf3Ej8hqlFA
         iutsjr2yxPuS35xMl2uRkfgy9vgoLpU78OF+Xxt6tdlLuqojDbKX6yVUX/9Bj+KRtuJC
         HvZMAoQzMyzBfBSJnHyVr/qhklVFvwAx+yQ2xYb9njkrhyQFUhJ4k031l1UG4+K7+I3h
         qG6VSW9i6xZH30nzjQE1cVlrZjPDbl/oyZVODfIXSVSlaZmjinklD3+D/NJSh5FC4foU
         rR75ciEjVAIG8qoSRC5ptbJfmbKqzyV2EOd/BJ/6sr7ZCUtspwemeLycc6EHgc95nLMF
         7pzQ==
X-Gm-Message-State: AOAM531khQBWfg5nxH0i6uU40/TKrQRyyN1nNb5PzpZ7DFyqmgJlk4BB
        YpMIXAv4gaFFzXJ1/yVUucc=
X-Google-Smtp-Source: ABdhPJwGD2Ls/6HuiKLKY7eh9bEAt/vnx8w8bZwjh9mS73eXEVaEvifmLoNaXTnLK+lGcpwR/wRhzg==
X-Received: by 2002:a17:90a:cb8d:: with SMTP id a13mr8847425pju.155.1610692133757;
        Thu, 14 Jan 2021 22:28:53 -0800 (PST)
Received: from localhost.localdomain ([150.109.106.156])
        by smtp.gmail.com with ESMTPSA id 145sm7174051pge.88.2021.01.14.22.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 22:28:53 -0800 (PST)
From:   wu860403@gmail.com
To:     tj@kernel.org, cgroups@vger.kernel.org, 398776277@qq.com
Cc:     Liming Wu <wu860403@gmail.com>
Subject: [PATCH] tg: add cpu's wait_count of a task group
Date:   Fri, 15 Jan 2021 22:30:05 +0800
Message-Id: <20210115143005.7071-1-wu860403@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Liming Wu <wu860403@gmail.com>

Now we can rely on PSI to reflect whether there is contention in
the task group, but it cannot reflect the details of the contention.
Through this metric, we can get details of task group contention
 from the dimension of scheduling.
   delta(wait_sum)/delta(wait_count)

Also unified the cpu.stat output of cgroup v1 and v2

Signed-off-by Liming Wu <19092205@suning.com>
---
 kernel/sched/core.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7e453492..e7ff47436 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8139,19 +8139,29 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 {
 	struct task_group *tg = css_tg(seq_css(sf));
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
+	u64 throttled_usec;
 
-	seq_printf(sf, "nr_periods %d\n", cfs_b->nr_periods);
-	seq_printf(sf, "nr_throttled %d\n", cfs_b->nr_throttled);
-	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
+	throttled_usec = cfs_b->throttled_time;
+	do_div(throttled_usec, NSEC_PER_USEC);
+
+	seq_printf(sf, "nr_periods %d\n"
+		   "nr_throttled %d\n"
+		   "throttled_usec %llu\n",
+		   cfs_b->nr_periods, cfs_b->nr_throttled,
+		   throttled_usec);
 
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
+		seq_printf(sf, "wait_sum %llu\n"
+			"wait_count %llu\n", ws, wc);
 	}
 
 	return 0;
@@ -8255,6 +8265,19 @@ static int cpu_extra_stat_show(struct seq_file *sf,
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
+			seq_printf(sf, "wait_sum %llu\n"
+				"wait_count %llu\n", ws, wc);
+		}
 	}
 #endif
 	return 0;
-- 
2.20.1

