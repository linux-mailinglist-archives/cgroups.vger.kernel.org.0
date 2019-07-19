Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C246E706
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2019 16:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfGSOAd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Jul 2019 10:00:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53254 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbfGSOAd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Jul 2019 10:00:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so28929087wmj.3
        for <cgroups@vger.kernel.org>; Fri, 19 Jul 2019 07:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VKh5F3gMwRtIY8LwPbQ4AcnY8aG7rL1fZSwNVcviJak=;
        b=DaPp9Pl7yO41BIKzESKa2H/4mGqS3xhwaGutErUCjPUBwoLGJpt3jVlV0hrKhSRy6Z
         SNrKc3CrKbqhcR/SdXm/FjYl9pGGhVmDGBaC2VrJ0IGXrIFBFBMbqepsf5Byhihf4T16
         R80rl2IzKFNPjbEBFFv+uBYg9NdTzw6eOZKKE0dqCP9jRTlHR+gOcQef0TllDLUuM5sF
         HG6dk/kagYGUAqVIXVrLROXVJKgfC4+Wr/dkzRBNYDup8GLd71TwHQwy1oWQwvKSLiUT
         +sKqFvMr5PZ6yrrCAFRSV+A9Jl+lNQX5he4uLP6yExvNfct8gB8ZFufXpBr5uGIlNBEx
         7PxQ==
X-Gm-Message-State: APjAAAWVVxCuJJgeSWn+5xW8v04r0BNGv9u7P9mPi9lA+vbp3bZT1ey6
        EY1JH4iX5G2yMvVZKlmxINaZ0A==
X-Google-Smtp-Source: APXvYqzIf60Lf9aSNAxg/yPyPA5RbNqgMkBFA3RSc1Y0RpcRDM61RivofduFeNa3XkVhrhm+B/NHYA==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr48579844wmc.19.1563544831694;
        Fri, 19 Jul 2019 07:00:31 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id f10sm21276926wrs.22.2019.07.19.07.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 07:00:30 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v9 4/8] sched/deadline: Fix bandwidth accounting at all levels after offline migration
Date:   Fri, 19 Jul 2019 15:59:56 +0200
Message-Id: <20190719140000.31694-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190719140000.31694-1-juri.lelli@redhat.com>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
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

