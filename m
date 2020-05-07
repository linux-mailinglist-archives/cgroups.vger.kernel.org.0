Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E97A1C9697
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2020 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgEGQdI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 May 2020 12:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727029AbgEGQdH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 May 2020 12:33:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981EFC05BD09
        for <cgroups@vger.kernel.org>; Thu,  7 May 2020 09:33:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i62so7615367ybc.11
        for <cgroups@vger.kernel.org>; Thu, 07 May 2020 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=og154mHT7Z9uD6j2lwCYPmDrJ+/s5VY2aDAgiLM9b98=;
        b=IJMyIUePnVZdYSUnoiGNaJBp9FENwv0hX7vYYnUYT9c3x9pjUNSefNv7zPpGkB1FGs
         jtm5oQCFAXilKW/JLjhFJ9J6o6Ih+udUlq94zoxdyzFJzvJ+Y+UbEwtqhbqboeSnC7le
         P1Ump5crq6Gh2lH86YAQmM3MW83uJ8t7ZVDJ9NFDI2OhqYo+vAlCL/5uBgejtqdApLbm
         zWDhL6oJfOGt7HQjc0LVEI4I6rW+dOuvXZyTGxfQZPnGc8du64GCVs38fn0954HxEhl1
         0Mzs5kzurd/aoze7EFOKg5UsEGNqqkZ0I9HbMpmQdNxrtu1q7M+rNNKPw7ajXFWF5xFm
         H3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=og154mHT7Z9uD6j2lwCYPmDrJ+/s5VY2aDAgiLM9b98=;
        b=piFjpJDOL4tXRvjEyWtDt5FSMfqWNc8yXtihiHNl8vLx8LA5V8gncfzwsV36LiHnjr
         1XlwaKYOWoiWOYrk1+GH3OrH9iW/6uugYt2yIDSpFV+TnlqzIm3nSbuZAsxHxFQv7Ei3
         GJiURHrBasszSiIUJJZEpTnx8UAhlwOyRwT96xiY43+vL4goAu4AUl4BMnbeZjTkdCWa
         tVJQvrVZ/WOyrSdTRcLjHNS5XBGSgyhKa4V3vFgwy/fxZgLu9rQUzUNFw0YM8gkdpGFW
         vUODJPOE+iucNNMvQ1wLbBju3yj8X8hny4wrVE0Vupk2THurNND1yHc6MnyqwKF1/CW0
         QQcw==
X-Gm-Message-State: AGi0PuZdFYd2qyR652//L7U40Arvh35gJw7rYnlFcCfSC7Mx3wGbA/kI
        CdYVoEP+t8hqTd6gZR3GfxrnBWlO3dBQ6g==
X-Google-Smtp-Source: APiQypK06BpXu5zFNpBIZOjw1SyVUbCuz1lprj+aT7oBFGoFI4w3VvF2wjp0Qoon8PqGO/Ce9Xd2LKgv+fIEzw==
X-Received: by 2002:a25:b10a:: with SMTP id g10mr23931305ybj.220.1588869185637;
 Thu, 07 May 2020 09:33:05 -0700 (PDT)
Date:   Thu,  7 May 2020 09:33:01 -0700
Message-Id: <20200507163301.229070-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH] memcg: effective memory.high reclaim for remote charging
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently the reclaim of excessive usage over memory.high is scheduled
to run on returning to the userland. The main reason behind this
approach was simplicity i.e. always reclaim with GFP_KERNEL context.
However the underlying assumptions behind this approach are: the current
task shares the memcg hierarchy with the given memcg and the memcg of
the current task most probably will not change on return to userland.

With the remote charging, the first assumption breaks and it allows the
usage to grow way beyond the memory.high as the reclaim and the
throttling becomes ineffective.

This patch forces the synchronous reclaim and potentially throttling for
the callers with context that allows blocking. For unblockable callers
or whose synch high reclaim is still not successful, a high reclaim is
scheduled either to return-to-userland if current task shares the
hierarchy with the given memcg or to system work queue.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 63 +++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 317dbbaac603..7abb762f26cd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2387,23 +2387,13 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
 	return min(penalty_jiffies, MEMCG_MAX_HIGH_DELAY_JIFFIES);
 }
 
-/*
- * Scheduled by try_charge() to be executed from the userland return path
- * and reclaims memory over the high limit.
- */
-void mem_cgroup_handle_over_high(void)
+static void reclaim_over_high(struct mem_cgroup *memcg, gfp_t gfp_mask,
+			      unsigned long nr_pages)
 {
 	unsigned long penalty_jiffies;
 	unsigned long pflags;
-	unsigned int nr_pages = current->memcg_nr_pages_over_high;
-	struct mem_cgroup *memcg;
 
-	if (likely(!nr_pages))
-		return;
-
-	memcg = get_mem_cgroup_from_mm(current->mm);
-	reclaim_high(memcg, nr_pages, GFP_KERNEL);
-	current->memcg_nr_pages_over_high = 0;
+	reclaim_high(memcg, nr_pages, gfp_mask);
 
 	/*
 	 * memory.high is breached and reclaim is unable to keep up. Throttle
@@ -2418,7 +2408,7 @@ void mem_cgroup_handle_over_high(void)
 	 * been aggressively reclaimed enough yet.
 	 */
 	if (penalty_jiffies <= HZ / 100)
-		goto out;
+		return;
 
 	/*
 	 * If we exit early, we're guaranteed to die (since
@@ -2428,8 +2418,23 @@ void mem_cgroup_handle_over_high(void)
 	psi_memstall_enter(&pflags);
 	schedule_timeout_killable(penalty_jiffies);
 	psi_memstall_leave(&pflags);
+}
 
-out:
+/*
+ * Scheduled by try_charge() to be executed from the userland return path
+ * and reclaims memory over the high limit.
+ */
+void mem_cgroup_handle_over_high(void)
+{
+	unsigned int nr_pages = current->memcg_nr_pages_over_high;
+	struct mem_cgroup *memcg;
+
+	if (likely(!nr_pages))
+		return;
+
+	memcg = get_mem_cgroup_from_mm(current->mm);
+	reclaim_over_high(memcg, GFP_KERNEL, nr_pages);
+	current->memcg_nr_pages_over_high = 0;
 	css_put(&memcg->css);
 }
 
@@ -2584,15 +2589,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (batch > nr_pages)
 		refill_stock(memcg, batch - nr_pages);
 
-	/*
-	 * If the hierarchy is above the normal consumption range, schedule
-	 * reclaim on returning to userland.  We can perform reclaim here
-	 * if __GFP_RECLAIM but let's always punt for simplicity and so that
-	 * GFP_KERNEL can consistently be used during reclaim.  @memcg is
-	 * not recorded as it most likely matches current's and won't
-	 * change in the meantime.  As high limit is checked again before
-	 * reclaim, the cost of mismatch is negligible.
-	 */
 	do {
 		if (page_counter_read(&memcg->memory) > READ_ONCE(memcg->high)) {
 			/* Don't bother a random interrupted task */
@@ -2600,8 +2596,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 				schedule_work(&memcg->high_work);
 				break;
 			}
-			current->memcg_nr_pages_over_high += batch;
-			set_notify_resume(current);
+
+			if (gfpflags_allow_blocking(gfp_mask))
+				reclaim_over_high(memcg, gfp_mask, batch);
+
+			if (page_counter_read(&memcg->memory) <=
+			    READ_ONCE(memcg->high))
+				break;
+			/*
+			 * The above reclaim might not be able to do much. Punt
+			 * the high reclaim to return to userland if the current
+			 * task shares the hierarchy.
+			 */
+			if (current->mm && mm_match_cgroup(current->mm, memcg)) {
+				current->memcg_nr_pages_over_high += batch;
+				set_notify_resume(current);
+			} else
+				schedule_work(&memcg->high_work);
 			break;
 		}
 	} while ((memcg = parent_mem_cgroup(memcg)));
-- 
2.26.2.526.g744177e7f7-goog

