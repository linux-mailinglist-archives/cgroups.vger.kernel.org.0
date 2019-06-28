Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB3CF595A2
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2019 10:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfF1IGm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jun 2019 04:06:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37286 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfF1IGl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jun 2019 04:06:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so5260924wrr.4
        for <cgroups@vger.kernel.org>; Fri, 28 Jun 2019 01:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VKh5F3gMwRtIY8LwPbQ4AcnY8aG7rL1fZSwNVcviJak=;
        b=BuRE4OZkU5dA3i53OyRfDHjhr5sl/OH54pFQRlvtDgr50muPY9VhJxjYafqSrUm5b1
         1XfFttBUmSdrwzWjj+7UMGgldbKCosZdcyHIDb5ZDdn9Wt0NMdfhCE8ZDd8izEi632VB
         7B3hNzNB62O6uYJ+Q+pX4VpyvjoTBXLINziUSxxYfvsSM5ze3OlLooX5SV49CuP0XFju
         +CProACXiSB7yGjZO5xWFu6dsPuEz3kDSB0p2/PKrThQ2daN4TOnmu/9/P0rPGJk9Y69
         WBhgqoNqAyxtT7VYXBZ6UyJRTqyO6xeoFxOO+V5aF8Q9FOPGO//7dyNzvPYL/tb6x8RG
         lIaQ==
X-Gm-Message-State: APjAAAVKbaiC6tP0+twzcebiYyoF2XLgwkjqPx0pLsvNW88e2xvKHskQ
        UOGSJy2lEJmDl9xy6FrXJRD2Vg==
X-Google-Smtp-Source: APXvYqwqaR+6SHjUOrSOTMzqAVWw/LWe+Zbj2HUY3As6S8bpLqgpYmCZb9UESb8O7jB+pWWBLx/YcQ==
X-Received: by 2002:adf:ee0a:: with SMTP id y10mr1473056wrn.169.1561709199948;
        Fri, 28 Jun 2019 01:06:39 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.165.245])
        by smtp.gmail.com with ESMTPSA id z19sm1472774wmi.7.2019.06.28.01.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 01:06:39 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v8 4/8] sched/deadline: Fix bandwidth accounting at all levels after offline migration
Date:   Fri, 28 Jun 2019 10:06:14 +0200
Message-Id: <20190628080618.522-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190628080618.522-1-juri.lelli@redhat.com>
References: <20190628080618.522-1-juri.lelli@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If a task happens to be throttled while the CPU it was running on gets
hotplugged off, the bandwidth associated with the task is not correctly
migrated with it when the replenishment timer fires (offline_migration).

Fix things up, for this_bw, running_bw and total_bw, when replenishment
timer fires and task is migrated (dl_task_offline_migration()).

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4cedcf8d6b03..f0166ab8c6b4 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -529,6 +529,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq);
 static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p)
 {
 	struct rq *later_rq = NULL;
+	struct dl_bw *dl_b;
 
 	later_rq = find_lock_later_rq(p, rq);
 	if (!later_rq) {
@@ -557,6 +558,38 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 		double_lock_balance(rq, later_rq);
 	}
 
+	if (p->dl.dl_non_contending || p->dl.dl_throttled) {
+		/*
+		 * Inactive timer is armed (or callback is running, but
+		 * waiting for us to release rq locks). In any case, when it
+		 * will file (or continue), it will see running_bw of this
+		 * task migrated to later_rq (and correctly handle it).
+		 */
+		sub_running_bw(&p->dl, &rq->dl);
+		sub_rq_bw(&p->dl, &rq->dl);
+
+		add_rq_bw(&p->dl, &later_rq->dl);
+		add_running_bw(&p->dl, &later_rq->dl);
+	} else {
+		sub_rq_bw(&p->dl, &rq->dl);
+		add_rq_bw(&p->dl, &later_rq->dl);
+	}
+
+	/*
+	 * And we finally need to fixup root_domain(s) bandwidth accounting,
+	 * since p is still hanging out in the old (now moved to default) root
+	 * domain.
+	 */
+	dl_b = &rq->rd->dl_bw;
+	raw_spin_lock(&dl_b->lock);
+	__dl_sub(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
+	raw_spin_unlock(&dl_b->lock);
+
+	dl_b = &later_rq->rd->dl_bw;
+	raw_spin_lock(&dl_b->lock);
+	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(later_rq->rd->span));
+	raw_spin_unlock(&dl_b->lock);
+
 	set_task_cpu(p, later_rq->cpu);
 	double_unlock_balance(later_rq, rq);
 
-- 
2.17.2

