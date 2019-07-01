Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA45C42E
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2019 22:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfGAUPs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Jul 2019 16:15:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39458 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfGAUPs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Jul 2019 16:15:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so6532701pgc.6
        for <cgroups@vger.kernel.org>; Mon, 01 Jul 2019 13:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pUF1T8YosBJ3xSBN/42gppxPrNAbk2wJaDAAwR8fY4o=;
        b=loyuPKYLikazGc5HJLPsKrOh6SiuV2L2ADgtcqoTgA2KJrZ6hkNMReykxDO0Edw116
         f2TsgRnGSFbOJwg7rCfZuGuBqr+bXFWCg0OhrZTUsY58zhaQpHbLQ2pJTWBOkSggUhEh
         th/EXNtrbcsvXx7loxWS4sE1HCe4yQieZ4CHw6c+Gis8o2/AKIFykZ5BpzSfBRe5oABH
         40+tiMfaiaT16ZrAzcGGQSZjrWxZMEYQRp0IP/q4G2NASX65BQqpgU1BTP5ZGPquwTdg
         1+Ifd81E69xN0pCAwHkBjX2YvyyJfJGLdGYnORLxAGxI52t4+a+xsaEJxAJMtuRpd7YB
         V7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=pUF1T8YosBJ3xSBN/42gppxPrNAbk2wJaDAAwR8fY4o=;
        b=cQXt9kO0YsJO7bOF8n2mpmB2iCu/HXwf4XFjgNlJtLIq42BeTp0DxXtxoaTaFytDF1
         yCjTMVi9nhAxQJRLtQBFqKnRF/V2VSux8Jfr6uMZavF9WcH4KfMbopb0yxSKFHyM+CkJ
         gx4Ol7hcSpcsP+9qYgXotYgt8fl63oL5gln2DC1NzxzIT7cYMj55MLbT1ERuibBD92bq
         90eNs7p0mQIJcT7iZkTbBDysYv/6DNsNYExm0z7ca9M5A2PbzorFAdnr4NDbyvZpK++k
         +fpWplpqI3ZqwIN4b8omFcx3dtWkzUfmsEF5Cxdgz7VgP8zxk7TZfk0AyyBUp7V98RhK
         Mrog==
X-Gm-Message-State: APjAAAUM1mhO1UxMlHSb1b8RT3IuJzMmAQd2D6rPiDR5AIAgjcy33sHK
        KhP6CkUPPpJKvDP1x1JQBt82YQ==
X-Google-Smtp-Source: APXvYqz/f5okR0/1uArrmL95QeBoc/0K9RJuEaqe9lJG32VRI0BmZ5htaBEYKSq6Ovvx9xCTCG2JVw==
X-Received: by 2002:a63:b46:: with SMTP id a6mr212520pgl.235.1562012146904;
        Mon, 01 Jul 2019 13:15:46 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id q63sm21742450pfb.81.2019.07.01.13.15.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 13:15:45 -0700 (PDT)
From:   bsegall@google.com
To:     Dave Chiluk <chiluk+linux@indeed.com>
Cc:     Pqhil Auld <pauld@redhat.com>, Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v5 1/1] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
        <1561664970-1555-1-git-send-email-chiluk+linux@indeed.com>
        <1561664970-1555-2-git-send-email-chiluk+linux@indeed.com>
Date:   Mon, 01 Jul 2019 13:15:44 -0700
In-Reply-To: <1561664970-1555-2-git-send-email-chiluk+linux@indeed.com> (Dave
        Chiluk's message of "Thu, 27 Jun 2019 14:49:30 -0500")
Message-ID: <xm26lfxhwlxr.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Alright, this prototype of "maybe we should just 100% avoid stranding
runtime for a full period" appears to fix the fibtest synthetic example,
and seems like a theoretically-reasonable approach.

Things that may want improvement or at least thought (but it's a holiday
week in the US and I wanted any opinions on the basic approach):

- I don't like cfs_rq->slack_list, since logically it's mutually
  exclusive with throttled_list, but we have to iterate without
  locks, so I don't know that we can avoid it.

- I previously was using _rcu for the slack list, like throttled, but
  there is no list_for_each_entry_rcu_safe, so the list_del_init would
  be invalid and we'd have to use another flag or opencode the
  equivalent.

- (Actually, this just made me realize that distribute is sorta wrong if
  the unthrottled task immediately runs and rethrottles; this would just
  mean that we effectively restart the loop)

- We unconditionally start the slack timer, even if nothing is
  throttled. We could instead have throttle start the timer in this case
  (setting the timeout some definition of "appropriately"), but this
  bookkeeping would be a big hassle.

- We could try to do better about deciding what cfs_rqs are idle than
  "nr_running == 0", possibly requiring that to have been true for N<5
  ms, and restarting the slack timer if we didn't clear everything.

- Taking up-to-every rq->lock is bad and expensive and 5ms may be too
  short a delay for this. I haven't tried microbenchmarks on the cost of
  this vs min_cfs_rq_runtime = 0 vs baseline.

- runtime_expires vs expires_seq choice is basically rand(), much like
  the existing code. (I think the most consistent with existing code
  would be runtime_expires, since cfs_b lock is held; I think most
  consistent in general would change most of the existing ones as well
  to be seq)


-- >8 --
Subject: [PATCH] sched: avoid stranding cfs_bandwidth runtime

We avoid contention on the per-tg cfs_b->lock by keeping 1ms of runtime on a
cfs_rq even when all tasks in that cfs_rq dequeue. This way tasks doing frequent
wake/sleep can't hit this cross-cpu lock more than once per ms. This however
means that up to 1ms of runtime per cpu can be lost if no task does wake up on
that cpu, which is leading to issues on cgroups with low quota, many available
cpus, and a combination of threads that run for very little time and ones that
want to run constantly.

This was previously hidden by runtime expiration being broken, which allowed
this stranded runtime to be kept indefinitely across period resets. Thus after
an initial period or two any long-running tasks could use an appropriate portion
of their group's quota. The issue was that the group could also potentially
burst for 1ms * cpus more than their quota allowed, and in these situations this
is a significant increase.

Fix this by having the group's slack timer (which runs at most once per 5ms)
remove all runtime from empty cfs_rqs, not just redistribute any runtime above
that 1ms that was returned immediately.

Signed-off-by: Ben Segall <bsegall@google.com>
---
 kernel/sched/fair.c  | 66 +++++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h |  2 ++
 2 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 300f2c54dea5..80b2198d9b29 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4745,23 +4745,32 @@ static void __return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	s64 slack_runtime = cfs_rq->runtime_remaining - min_cfs_rq_runtime;
 
-	if (slack_runtime <= 0)
+	if (cfs_rq->runtime_remaining <= 0)
+		return;
+
+	if (slack_runtime <= 0 && !list_empty(&cfs_rq->slack_list))
 		return;
 
 	raw_spin_lock(&cfs_b->lock);
 	if (cfs_b->quota != RUNTIME_INF &&
-	    cfs_rq->runtime_expires == cfs_b->runtime_expires) {
-		cfs_b->runtime += slack_runtime;
+	    cfs_rq->expires_seq == cfs_b->expires_seq) {
+		if (slack_runtime > 0)
+			cfs_b->runtime += slack_runtime;
+		if (list_empty(&cfs_rq->slack_list))
+			list_add(&cfs_rq->slack_list, &cfs_b->slack_cfs_rq);
 
-		/* we are under rq->lock, defer unthrottling using a timer */
-		if (cfs_b->runtime > sched_cfs_bandwidth_slice() &&
-		    !list_empty(&cfs_b->throttled_cfs_rq))
-			start_cfs_slack_bandwidth(cfs_b);
+		/*
+		 * After a timeout, gather our remaining runtime so it can't get
+		 * stranded. We need a timer anyways to distribute any of the
+		 * runtime due to locking issues.
+		 */
+		start_cfs_slack_bandwidth(cfs_b);
 	}
 	raw_spin_unlock(&cfs_b->lock);
 
-	/* even if it's not valid for return we don't want to try again */
-	cfs_rq->runtime_remaining -= slack_runtime;
+	if (slack_runtime > 0)
+		/* even if it's not valid for return we don't want to try again */
+		cfs_rq->runtime_remaining -= slack_runtime;
 }
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
@@ -4781,12 +4790,41 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
  */
 static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 {
-	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
+	u64 runtime = 0;
 	unsigned long flags;
 	u64 expires;
+	struct cfs_rq *cfs_rq, *temp;
+	LIST_HEAD(temp_head);
+
+	local_irq_save(flags);
+
+	raw_spin_lock(&cfs_b->lock);
+	cfs_b->slack_started = false;
+	list_splice_init(&cfs_b->slack_cfs_rq, &temp_head);
+	raw_spin_unlock(&cfs_b->lock);
+
+
+	/* Gather all left over runtime from all rqs */
+	list_for_each_entry_safe(cfs_rq, temp, &temp_head, slack_list) {
+		struct rq *rq = rq_of(cfs_rq);
+		struct rq_flags rf;
+
+		rq_lock(rq, &rf);
+
+		raw_spin_lock(&cfs_b->lock);
+		list_del_init(&cfs_rq->slack_list);
+		if (!cfs_rq->nr_running && cfs_rq->runtime_remaining > 0 &&
+		    cfs_rq->runtime_expires == cfs_b->runtime_expires) {
+			cfs_b->runtime += cfs_rq->runtime_remaining;
+			cfs_rq->runtime_remaining = 0;
+		}
+		raw_spin_unlock(&cfs_b->lock);
+
+		rq_unlock(rq, &rf);
+	}
 
 	/* confirm we're still not at a refresh boundary */
-	raw_spin_lock_irqsave(&cfs_b->lock, flags);
+	raw_spin_lock(&cfs_b->lock);
 	cfs_b->slack_started = false;
 	if (cfs_b->distribute_running) {
 		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
@@ -4798,7 +4836,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 		return;
 	}
 
-	if (cfs_b->quota != RUNTIME_INF && cfs_b->runtime > slice)
+	if (cfs_b->quota != RUNTIME_INF)
 		runtime = cfs_b->runtime;
 
 	expires = cfs_b->runtime_expires;
@@ -4946,6 +4984,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
+	INIT_LIST_HEAD(&cfs_b->slack_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
 	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
@@ -4958,6 +4997,7 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->runtime_enabled = 0;
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
+	INIT_LIST_HEAD(&cfs_rq->slack_list);
 }
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b08dee29ef5e..3b272ee894fb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -345,6 +345,7 @@ struct cfs_bandwidth {
 	struct hrtimer		period_timer;
 	struct hrtimer		slack_timer;
 	struct list_head	throttled_cfs_rq;
+	struct list_head	slack_cfs_rq;
 
 	/* Statistics: */
 	int			nr_periods;
@@ -566,6 +567,7 @@ struct cfs_rq {
 	int			throttled;
 	int			throttle_count;
 	struct list_head	throttled_list;
+	struct list_head	slack_list;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

