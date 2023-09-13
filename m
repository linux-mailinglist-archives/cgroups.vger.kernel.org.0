Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA79E79E0F8
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 09:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjIMHi7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 03:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbjIMHi7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 03:38:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0F71729
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 00:38:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59285f1e267so12868837b3.0
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 00:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694590734; x=1695195534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zT0hHZy8cis/iWPUQS68SvJSs9nRfkwgZ1RrbYh+5w=;
        b=z8BsSMMkcpxomBbaPryW+olQ3UQVLbWNQ4fOr1/+MTIUMoQH4cQsV+oiqV4atmjOW0
         iedsLMwd2fKtBeVG3fovUWiTkONwJ9bGazl6w+jRxcRGbWl58plni/H6lz1w+ehkYUp/
         9Y2DCfAAA5cvmwu485N+09B1zAZBefpR28YqMqsEyVCNiUqupmfcZtMwJar/oheTRJEb
         J2/3RtWTQdUjBMKHzFjwpWomkyIpvKscHcQk0nkkxRwY/m/b9ATqZw7u1HyN4OZrIDro
         vpRhi6cCZuULcSRNLz5KDJ1TLOPz3GKy0zMEES4ni0bW2WIZYwpIWXQnqprL2MBfhBli
         Gs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694590734; x=1695195534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zT0hHZy8cis/iWPUQS68SvJSs9nRfkwgZ1RrbYh+5w=;
        b=Hol0Z65tgskxERXW7tLq8jKyhm2VU3BlAyZWlg3WazbHuEJ3Eb1VZhEV9bT3A8A1P6
         Ev7l2BM78wVF2GNpM7nkANVPD7TYJz5DM1WTimz0zC4FBg1vEbAHYidBeUcQvof08en0
         z5To/nW0A/EO7MJvxEqNnqxC1+ZCf0mSKdv4fA2U/wciXbNsKkY1+gtQaUprv7pzGu/a
         NXqUTm/rHZJWaQx9HT2hSEW8FyMS6Y6qAz25ka4Vny6Drlo+6yJKIxerSUZfCORJCqFu
         AUWHeTAegmezUeY7SZIIa3mjeBD/h/gsgOR05S+Y9XzL+Aa45gga76+yjGUNJGuMBfxi
         8rDw==
X-Gm-Message-State: AOJu0YyKNaVDhX/593xjv952RcTxt0szbK5ptp+pskEBrCQus5vVjrPX
        1Qg8JIIVqOdRXkDOOhpLLg3sChglOgwzhvtk
X-Google-Smtp-Source: AGHT+IG3xAxVjeVugRkb9w85c4h3IHyzBTJ6cMwknrJlaNgvG0fGdTwmuzoswAYft+iKkPbWy/xXuohXtxPiB5qL
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:d2d5:0:b0:d78:28d0:15bc with SMTP
 id j204-20020a25d2d5000000b00d7828d015bcmr54189ybg.4.1694590734274; Wed, 13
 Sep 2023 00:38:54 -0700 (PDT)
Date:   Wed, 13 Sep 2023 07:38:45 +0000
In-Reply-To: <20230913073846.1528938-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913073846.1528938-3-yosryahmed@google.com>
Subject: [PATCH 2/3] mm: memcg: rename stats_flush_threshold to stats_updates_order
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

stats_flush_threshold is a misnomer. It is not actually a threshold, but
rather a number that represents the amount of updates that we have. It
is counted in multiples of MEMCG_CHARGE_BATCH. When this value reaches
num_online_cpus(), we flush the stats.

Hence, num_online_cpus() is the actual threshold, and
stats_flush_threshold is actually an order of the stats updates
magnitude. Rename stats_flush_threshold to stats_updates_order, and
define a STATS_FLUSH_THRESHOLD constant that resolves to
num_online_cpus().

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 35a9c013d755..d729870505f1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -589,10 +589,12 @@ static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
 static DEFINE_PER_CPU(unsigned int, stats_updates);
 static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
-static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
+/* stats_updates_order is in multiples of MEMCG_CHARGE_BATCH */
+static atomic_t stats_updates_order = ATOMIC_INIT(0);
 static u64 flush_last_time;
 
 #define FLUSH_TIME (2UL*HZ)
+#define STATS_FLUSH_THRESHOLD num_online_cpus()
 
 /*
  * Accessors to ensure that preemption is disabled on PREEMPT_RT because it can
@@ -628,13 +630,11 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	x = __this_cpu_add_return(stats_updates, abs(val));
 	if (x > MEMCG_CHARGE_BATCH) {
 		/*
-		 * If stats_flush_threshold exceeds the threshold
-		 * (>num_online_cpus()), cgroup stats update will be triggered
-		 * in __mem_cgroup_flush_stats(). Increasing this var further
-		 * is redundant and simply adds overhead in atomic update.
+		 * Incrementing stats_updates_order beyond the threshold is
+		 * redundant. Avoid the overhead of the atomic update.
 		 */
-		if (atomic_read(&stats_flush_threshold) <= num_online_cpus())
-			atomic_add(x / MEMCG_CHARGE_BATCH, &stats_flush_threshold);
+		if (atomic_read(&stats_updates_order) <= STATS_FLUSH_THRESHOLD)
+			atomic_add(x / MEMCG_CHARGE_BATCH, &stats_updates_order);
 		__this_cpu_write(stats_updates, 0);
 	}
 }
@@ -654,13 +654,13 @@ static void do_flush_stats(void)
 
 	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
 
-	atomic_set(&stats_flush_threshold, 0);
+	atomic_set(&stats_updates_order, 0);
 	atomic_set(&stats_flush_ongoing, 0);
 }
 
 void mem_cgroup_flush_stats(void)
 {
-	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
+	if (atomic_read(&stats_updates_order) > STATS_FLUSH_THRESHOLD)
 		do_flush_stats();
 }
 
@@ -674,8 +674,8 @@ void mem_cgroup_flush_stats_ratelimited(void)
 static void flush_memcg_stats_dwork(struct work_struct *w)
 {
 	/*
-	 * Always flush here so that flushing in latency-sensitive paths is
-	 * as cheap as possible.
+	 * Deliberately ignore stats_updates_order here so that flushing in
+	 * latency-sensitive paths is as cheap as possible.
 	 */
 	do_flush_stats();
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
-- 
2.42.0.283.g2d96d420d3-goog

