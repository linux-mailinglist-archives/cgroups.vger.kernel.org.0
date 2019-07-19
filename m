Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90476E712
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2019 16:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfGSOAb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Jul 2019 10:00:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54870 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbfGSOAa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Jul 2019 10:00:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so28904329wme.4
        for <cgroups@vger.kernel.org>; Fri, 19 Jul 2019 07:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1v9Wyn7iwUdwNAPe/wicZ1s65Wur1rKRI0dtWQllWvE=;
        b=ZH1EPyFuhd3eaynzBXgcDx4WUKnTktJWMRrHHwpzVsBCiPO7crOzJGzfECxRJVKSri
         WrxXytqRC2LtA18Y9ncCAd1PUaW74G+D/Sv+xTXrlphhZxNvMI5YMxdX0Be6C6cpDklE
         w+rLjtUv+5lC83RilExJoLsnVlZBOUKs/QNS5f/9o0AhT+2BPApjCZ5J6LMzS9X8pGHp
         LvZFl3XeBHp1qck6Bgox1K3ObrKDlGxQ7a7xutpNZRE7jILQOhUc4hb5g0cmQQQMH6BD
         KJsFiRW+vIwk0ako2syz+x42YnbX/NMBSAFiRDMtvUuI0X+vRO9E1gwBYl5Yko8UYJh8
         yoHw==
X-Gm-Message-State: APjAAAXrDyQ6K8vFYJZ0mHH4WoaCoMzsrUnRTmDKGXpA9Y1QVCM+bkDY
        CY0JH01ndufs7Axz8UELomAw8g==
X-Google-Smtp-Source: APXvYqxlDiOmAaFd2Cg1EI75A3NKa/pF6D06AuO71ssB6z21VU9mUEXZkL345zWuGf9AnGKZqdVG1w==
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr50358433wmg.164.1563544828940;
        Fri, 19 Jul 2019 07:00:28 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id f10sm21276926wrs.22.2019.07.19.07.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 07:00:28 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org
Subject: [PATCH v9 2/8] sched/core: Streamlining calls to task_rq_unlock()
Date:   Fri, 19 Jul 2019 15:59:54 +0200
Message-Id: <20190719140000.31694-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190719140000.31694-1-juri.lelli@redhat.com>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Calls to task_rq_unlock() are done several times in function
__sched_setscheduler().  This is fine when only the rq lock needs to be
handled but not so much when other locks come into play.

This patch streamlines the release of the rq lock so that only one
location need to be modified when dealing with more than one lock.

No change of functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..acd6a9fe85bc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4222,8 +4222,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	 * Changing the policy of the stop threads its a very bad idea:
 	 */
 	if (p == rq->stop) {
-		task_rq_unlock(rq, p, &rf);
-		return -EINVAL;
+		retval = -EINVAL;
+		goto unlock;
 	}
 
 	/*
@@ -4239,8 +4239,8 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
-		task_rq_unlock(rq, p, &rf);
-		return 0;
+		retval = 0;
+		goto unlock;
 	}
 change:
 
@@ -4253,8 +4253,8 @@ static int __sched_setscheduler(struct task_struct *p,
 		if (rt_bandwidth_enabled() && rt_policy(policy) &&
 				task_group(p)->rt_bandwidth.rt_runtime == 0 &&
 				!task_group_is_autogroup(task_group(p))) {
-			task_rq_unlock(rq, p, &rf);
-			return -EPERM;
+			retval = -EPERM;
+			goto unlock;
 		}
 #endif
 #ifdef CONFIG_SMP
@@ -4269,8 +4269,8 @@ static int __sched_setscheduler(struct task_struct *p,
 			 */
 			if (!cpumask_subset(span, &p->cpus_allowed) ||
 			    rq->rd->dl_bw.bw == 0) {
-				task_rq_unlock(rq, p, &rf);
-				return -EPERM;
+				retval = -EPERM;
+				goto unlock;
 			}
 		}
 #endif
@@ -4289,8 +4289,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	 * is available.
 	 */
 	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
-		task_rq_unlock(rq, p, &rf);
-		return -EBUSY;
+		retval = -EBUSY;
+		goto unlock;
 	}
 
 	p->sched_reset_on_fork = reset_on_fork;
@@ -4346,6 +4346,10 @@ static int __sched_setscheduler(struct task_struct *p,
 	preempt_enable();
 
 	return 0;
+
+unlock:
+	task_rq_unlock(rq, p, &rf);
+	return retval;
 }
 
 static int _sched_setscheduler(struct task_struct *p, int policy,
-- 
2.17.2

