Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C82517A3
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2019 17:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbfFXPuW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jun 2019 11:50:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42989 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730993AbfFXPuW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jun 2019 11:50:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so13986371otn.9
        for <cgroups@vger.kernel.org>; Mon, 24 Jun 2019 08:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=g7SeDWVCJ8EIBUNOCPrNemk+yV65sZFM9h29PN2LZx0=;
        b=yG5UXB03/IrJRyiU10SAWztzkbmLfNTtyCoBXKb7Sa0ikLAOdOSDcRABxlZXhy7t/f
         qWp1J7376WXJvj1S9LLl5mOiaLp5PhRFFVqAXN2YyLWV2WuBaYYiYatq7AtawG6u8ylL
         Z38b1Nx8POJoiokCtjnLILdBbWdZwB5IeFnnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=g7SeDWVCJ8EIBUNOCPrNemk+yV65sZFM9h29PN2LZx0=;
        b=EuiIZYkgGAX2cb2RJnXSL5cLyKharV5QAW5tNdUa/0uFFWNuloCiniI083DS8PrFoi
         kJTjxFFwBW398RNaheOZ0eq0MgiCKorIilAC86UoPurkWLKmMmPoqEO8qslW7VNCnK+Y
         QU6vwYnaYKNsxgSlED7uE30kgX50TwV6wuJIm4NPmIx6D5C2rUelBiPjFAFScHSOd5gM
         bkXGwCIEcqFCgBSIdWqX++4+iqEevBzcA/rKrKyPD8xoMmHoWmGy1hgbvRo+Jtz66uuB
         koLkEGr7adkSm34dIzJSXaUaKgjs/4FOdoBRYYesOqn82AYY7vC+1peP6cx8IQK5/ZBx
         HUiA==
X-Gm-Message-State: APjAAAUIZdb56RWjsQd05gD6o2eiXHJDy5LcKJinWPeDm9LcAxY6Fmn9
        gEjWQtb2m5QWyVHdqPhsBpp1Gw==
X-Google-Smtp-Source: APXvYqweqHB/m++oeLT8Uza1GfI1KtUuJkbSV9iCDBBWOpZXvTSYS8BosHfB9UO11Vr3Zxj1YqlXIA==
X-Received: by 2002:a9d:7ccb:: with SMTP id r11mr49437066otn.80.1561391421494;
        Mon, 24 Jun 2019 08:50:21 -0700 (PDT)
Received: from cando.ausoff.indeed.net ([97.105.47.162])
        by smtp.gmail.com with ESMTPSA id x88sm4237710ota.56.2019.06.24.08.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 08:50:21 -0700 (PDT)
From:   Dave Chiluk <chiluk+linux@indeed.com>
To:     Ben Segall <bsegall@google.com>, Phil Auld <pauld@redhat.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH v4 1/1] sched/fair: Return all runtime when cfs_b has very little remaining.
Date:   Mon, 24 Jun 2019 10:50:04 -0500
Message-Id: <1561391404-14450-2-git-send-email-chiluk+linux@indeed.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561391404-14450-1-git-send-email-chiluk+linux@indeed.com>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
 <1561391404-14450-1-git-send-email-chiluk+linux@indeed.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It has been observed, that highly-threaded, user-interactive
applications running under cpu.cfs_quota_us constraints can hit a high
percentage of periods throttled while simultaneously not consuming the
allocated amount of quota. This impacts user-interactive non-cpu bound
applications, such as those running in kubernetes or mesos when run on
multiple cores.

This has been root caused to threads being allocated per cpu bandwidth
slices, and then not fully using that slice within the period. This
results in min_cfs_rq_runtime remaining on each per-cpu cfs_rq. At the
end of the period this remaining quota goes unused and expires. This
expiration of unused time on per-cpu runqueues results in applications
under-utilizing their quota while simultaneously hitting throttling.

The solution is to return all spare cfs_rq->runtime_remaining when
cfs_b->runtime nears the sched_cfs_bandwidth_slice. This balances the
desire to prevent cfs_rq from always pulling quota with the desire to
allow applications to fully utilize their quota.

Fixes: 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift condition")
Signed-off-by: Dave Chiluk <chiluk+linux@indeed.com>
---
 kernel/sched/fair.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f..4894eda 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4695,7 +4695,9 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 	return 1;
 }
 
-/* a cfs_rq won't donate quota below this amount */
+/* a cfs_rq won't donate quota below this amount unless cfs_b has very little
+ * remaining runtime.
+ */
 static const u64 min_cfs_rq_runtime = 1 * NSEC_PER_MSEC;
 /* minimum remaining period time to redistribute slack quota */
 static const u64 min_bandwidth_expiration = 2 * NSEC_PER_MSEC;
@@ -4743,16 +4745,27 @@ static void start_cfs_slack_bandwidth(struct cfs_bandwidth *cfs_b)
 static void __return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-	s64 slack_runtime = cfs_rq->runtime_remaining - min_cfs_rq_runtime;
+	s64 slack_runtime = cfs_rq->runtime_remaining;
 
+	/* There is no runtime to return. */
 	if (slack_runtime <= 0)
 		return;
 
 	raw_spin_lock(&cfs_b->lock);
 	if (cfs_b->quota != RUNTIME_INF &&
 	    cfs_rq->runtime_expires == cfs_b->runtime_expires) {
-		cfs_b->runtime += slack_runtime;
+		/* As we near 0 quota remaining on cfs_b start returning all
+		 * remaining runtime. This avoids stranding and then expiring
+		 * runtime on per-cpu cfs_rq.
+		 *
+		 * cfs->b has plenty of runtime leave min_cfs_rq_runtime of
+		 * runtime on this cfs_rq.
+		 */
+		if (cfs_b->runtime >= sched_cfs_bandwidth_slice() * 3 &&
+		    slack_runtime > min_cfs_rq_runtime)
+			slack_runtime -= min_cfs_rq_runtime;
 
+		cfs_b->runtime += slack_runtime;
 		/* we are under rq->lock, defer unthrottling using a timer */
 		if (cfs_b->runtime > sched_cfs_bandwidth_slice() &&
 		    !list_empty(&cfs_b->throttled_cfs_rq))
-- 
1.8.3.1

