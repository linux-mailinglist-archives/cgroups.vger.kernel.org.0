Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74C77F6E
	for <lists+cgroups@lfdr.de>; Sun, 28 Jul 2019 14:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfG1M3m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Jul 2019 08:29:42 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:43330 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfG1M3m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 28 Jul 2019 08:29:42 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 2691F2E0ACA;
        Sun, 28 Jul 2019 15:29:39 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id dss6TXipDP-TcNGG9RB;
        Sun, 28 Jul 2019 15:29:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1564316979; bh=EObxK8dqWVVRvRBsEeGGtpDlfj4a0yOhIWWPIED/x3I=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=1whsAqWuYKUJOXIPmma8+5xsd/DouCy6BjR807Y4R+wzUZD3rwTnOdzO8+z9EzdNm
         DhYxNS7unEDB0vVeMJeEVb0CTUOUtgKtNd7Qx+hfo0Mic5/s1HJS79olmnfDG17l7a
         0AqyBOkOz+M6pGmoVhyanJQEcgC735AjJsBq5x6M=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:9005::1:7])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id uMle0XeyLh-TcAq4Ce2;
        Sun, 28 Jul 2019 15:29:38 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit in
 get_user_pages loop
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Sun, 28 Jul 2019 15:29:38 +0300
Message-ID: <156431697805.3170.6377599347542228221.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

High memory limit in memory cgroup allows to batch memory reclaiming and
defer it until returning into userland. This moves it out of any locks.

Fixed gap between high and max limit works pretty well (we are using
64 * NR_CPUS pages) except cases when one syscall allocates tons of
memory. This affects all other tasks in cgroup because they might hit
max memory limit in unhandy places and\or under hot locks.

For example mmap with MAP_POPULATE or MAP_LOCKED might allocate a lot
of pages and push memory cgroup usage far ahead high memory limit.

This patch uses halfway between high and max limits as threshold and
in this case starts memory reclaiming if mem_cgroup_handle_over_high()
called with argument only_severe = true, otherwise reclaim is deferred
till returning into userland. If high limits isn't set nothing changes.

Now long running get_user_pages will periodically reclaim cgroup memory.
Other possible targets are generic file read/write iter loops.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/memcontrol.h |    4 ++--
 include/linux/tracehook.h  |    2 +-
 mm/gup.c                   |    5 ++++-
 mm/memcontrol.c            |   17 ++++++++++++++++-
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 44c41462be33..eca2bf9560f2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -512,7 +512,7 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 	return mz->lru_zone_size[zone_idx][lru];
 }
 
-void mem_cgroup_handle_over_high(void);
+void mem_cgroup_handle_over_high(bool only_severe);
 
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
@@ -969,7 +969,7 @@ static inline void unlock_page_memcg(struct page *page)
 {
 }
 
-static inline void mem_cgroup_handle_over_high(void)
+static inline void mem_cgroup_handle_over_high(bool only_severe)
 {
 }
 
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 36fb3bbed6b2..8845fb65353f 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -194,7 +194,7 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
 	}
 #endif
 
-	mem_cgroup_handle_over_high();
+	mem_cgroup_handle_over_high(false);
 	blkcg_maybe_throttle_current();
 }
 
diff --git a/mm/gup.c b/mm/gup.c
index 98f13ab37bac..42b93fffe824 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -847,8 +847,11 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 			ret = -ERESTARTSYS;
 			goto out;
 		}
-		cond_resched();
 
+		/* Reclaim memory over high limit before stocking too much */
+		mem_cgroup_handle_over_high(true);
+
+		cond_resched();
 		page = follow_page_mask(vma, start, foll_flags, &ctx);
 		if (!page) {
 			ret = faultin_page(tsk, vma, start, &foll_flags,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cdbb7a84cb6e..15fa664ce98c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2317,11 +2317,16 @@ static void high_work_func(struct work_struct *work)
 	reclaim_high(memcg, MEMCG_CHARGE_BATCH, GFP_KERNEL);
 }
 
+#define MEMCG_SEVERE_OVER_HIGH	(1 << 31)
+
 /*
  * Scheduled by try_charge() to be executed from the userland return path
  * and reclaims memory over the high limit.
+ *
+ * Long allocation loops should call periodically with only_severe = true
+ * to reclaim memory if usage already over halfway to the max limit.
  */
-void mem_cgroup_handle_over_high(void)
+void mem_cgroup_handle_over_high(bool only_severe)
 {
 	unsigned int nr_pages = current->memcg_nr_pages_over_high;
 	struct mem_cgroup *memcg;
@@ -2329,6 +2334,11 @@ void mem_cgroup_handle_over_high(void)
 	if (likely(!nr_pages))
 		return;
 
+	if (nr_pages & MEMCG_SEVERE_OVER_HIGH)
+		nr_pages -= MEMCG_SEVERE_OVER_HIGH;
+	else if (only_severe)
+		return;
+
 	memcg = get_mem_cgroup_from_mm(current->mm);
 	reclaim_high(memcg, nr_pages, GFP_KERNEL);
 	css_put(&memcg->css);
@@ -2493,6 +2503,11 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 				schedule_work(&memcg->high_work);
 				break;
 			}
+			/* Mark as severe if over halfway to the max limit */
+			if (page_counter_read(&memcg->memory) >
+			    (memcg->high >> 1) + (memcg->memory.max >> 1))
+				current->memcg_nr_pages_over_high |=
+						MEMCG_SEVERE_OVER_HIGH;
 			current->memcg_nr_pages_over_high += batch;
 			set_notify_resume(current);
 			break;

