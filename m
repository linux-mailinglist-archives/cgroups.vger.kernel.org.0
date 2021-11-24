Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC345C87B
	for <lists+cgroups@lfdr.de>; Wed, 24 Nov 2021 16:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhKXPW1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Nov 2021 10:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhKXPW1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Nov 2021 10:22:27 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D387EC061574;
        Wed, 24 Nov 2021 07:19:17 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g18so2976837pfk.5;
        Wed, 24 Nov 2021 07:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VQS9J9ET/JQ+uchySALu/6BIuoEYQrXpV1bknFuamdY=;
        b=fK7/ysA9q+3lIpsi3NA5igDoHT6nob2CncLewzRyhJj7GxHFWBpXYzZck1N0SWi4D6
         jaJ5RUL7SL3WnaYD2oDzS/379y4FSjRtBJaQbE7uAtQ4UZJ1L8ZB2USj7NZhSysju4Jo
         e8t/JSZ3LoDp648sz8zMfd25a3MWpAmxjIsSVuccbIxw7OK+vWsU511Z5CtAF5FbWDeJ
         2EmDdUiVBkvAN052YipJeEXp4N/xVe2RUtkJ4M50ba/10QPJyPw+ljEPP66VSvQhRHP3
         Uu23aHp7jPw5CexlF/OXPRWpfiZ3rckMpllum0MfYvpIqw2ylBOiUbKsYbS7sUaujoZ/
         YK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VQS9J9ET/JQ+uchySALu/6BIuoEYQrXpV1bknFuamdY=;
        b=H+0CNh0zXnIMOj8yECopSi8OaPnuHOau/OOg4wbU+n932Ji5Z3xvYXUm9m8bAtlwz0
         /rnDm2a6fihDuJGpuxAFHPXUxQaW579q2hytUW5GQuzkiCzczw59RlC4jPav2avy8tMC
         UR2ghHC09v385ygv9oCMl5tzDXEq5M82FXrhAamdawW8NqMByjWuJMi5hHaVI9+2/g2r
         RHFXUGKSmO00p86tf9bwE9YGd0Di2oDS1Cw6KisAc+S444fC5S7Kcyaq2M0v467u/X+n
         utTacd8Tr6GdL0gmEJl3lZ3Qr3NyK47v0doWEMuuv2wn/Ze7co/AIgPHvAwPzlBrDRuQ
         lQmg==
X-Gm-Message-State: AOAM53352ULGLzuXnEjfTYXpGutN297kwVviEAH6qF2yZGF3ibPhL63+
        8P6GSikjOX1sJdRcbw9KvS0=
X-Google-Smtp-Source: ABdhPJxqy8wKW5sCCer7X+ZQaKEjM1ckSJJiSykazVMZ/3aYiQWBkQmplN+NsBMwlKAszJYrFEPdsw==
X-Received: by 2002:a63:145d:: with SMTP id 29mr10609569pgu.264.1637767157332;
        Wed, 24 Nov 2021 07:19:17 -0800 (PST)
Received: from haolee.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id k129sm32590pgk.72.2021.11.24.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:19:16 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:19:15 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     linux-mm@kvack.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        shakeelb@google.com, haolee.swjtu@gmail.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: reduce spinlock contention in release_pages()
Message-ID: <20211124151915.GA6163@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When several tasks are terminated simultaneously, lots of pages will be
released, which can cause severe spinlock contention. Other tasks which
are running on the same core will be seriously affected. We can yield
cpu to fix this problem.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 include/linux/memcontrol.h | 26 ++++++++++++++++++++++++++
 mm/memcontrol.c            | 12 ++++++++++++
 mm/swap.c                  |  8 +++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c5c403f4be6..b06a5bcfd8f6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -800,6 +800,8 @@ struct lruvec *folio_lruvec_lock(struct folio *folio);
 struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
 struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 						unsigned long *flags);
+struct lruvec *folio_lruvec_trylock_irqsave(struct folio *folio,
+						unsigned long *flags);
 
 #ifdef CONFIG_DEBUG_VM
 void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio);
@@ -1313,6 +1315,17 @@ static inline struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 	return &pgdat->__lruvec;
 }
 
+static inline struct lruvec *folio_lruvec_trylock_irqsave(struct folio *folio,
+		unsigned long *flagsp)
+{
+	struct pglist_data *pgdat = folio_pgdat(folio);
+
+	if (spin_trylock_irqsave(&pgdat->__lruvec.lru_lock, *flagsp))
+		return &pgdat->__lruvec;
+	else
+		return NULL;
+}
+
 static inline struct mem_cgroup *
 mem_cgroup_iter(struct mem_cgroup *root,
 		struct mem_cgroup *prev,
@@ -1598,6 +1611,19 @@ static inline struct lruvec *folio_lruvec_relock_irqsave(struct folio *folio,
 	return folio_lruvec_lock_irqsave(folio, flags);
 }
 
+static inline struct lruvec *folio_lruvec_tryrelock_irqsave(struct folio *folio,
+		struct lruvec *locked_lruvec, unsigned long *flags)
+{
+	if (locked_lruvec) {
+		if (folio_matches_lruvec(folio, locked_lruvec))
+			return locked_lruvec;
+
+		unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
+	}
+
+	return folio_lruvec_trylock_irqsave(folio, flags);
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 781605e92015..b60ba54e2337 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1261,6 +1261,18 @@ struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 	return lruvec;
 }
 
+struct lruvec *folio_lruvec_trylock_irqsave(struct folio *folio,
+		unsigned long *flags)
+{
+	struct lruvec *lruvec = folio_lruvec(folio);
+
+	if (spin_trylock_irqsave(&lruvec->lru_lock, *flags)) {
+		lruvec_memcg_debug(lruvec, folio);
+		return lruvec;
+	}
+
+	return NULL;
+}
 /**
  * mem_cgroup_update_lru_size - account for adding or removing an lru page
  * @lruvec: mem_cgroup per zone lru vector
diff --git a/mm/swap.c b/mm/swap.c
index e8c9dc6d0377..91850d51a5a5 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -960,8 +960,14 @@ void release_pages(struct page **pages, int nr)
 		if (PageLRU(page)) {
 			struct lruvec *prev_lruvec = lruvec;
 
-			lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
+retry:
+			lruvec = folio_lruvec_tryrelock_irqsave(folio, lruvec,
 									&flags);
+			if (!lruvec) {
+				cond_resched();
+				goto retry;
+			}
+
 			if (prev_lruvec != lruvec)
 				lock_batch = 0;
 
-- 
2.31.1

