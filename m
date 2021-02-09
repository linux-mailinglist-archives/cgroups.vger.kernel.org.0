Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A3D3158D9
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 22:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhBIVnY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 16:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbhBIU47 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 15:56:59 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F2CC0613D6
        for <cgroups@vger.kernel.org>; Tue,  9 Feb 2021 11:01:29 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id t18so1260128qvn.8
        for <cgroups@vger.kernel.org>; Tue, 09 Feb 2021 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMKTZdgN+ApLkWCndc7XhEgCcK+nIdQXAhjOxRLrovs=;
        b=1ILh68/NP5l/G7S16U0oxNfUCDuypDgiZHfAby/Q3FDossuYdKi04IofVJrtdlUv3h
         J0JpwX/TkNjlZGRKE+v4SQyd6HTyGJ+lQIjFzAR63oks20pvihdIuKhyJYeBRSQqiFxd
         Wacz1OSJzE1wMnzew7eaZevYCSl7JMJ3IYXqiv57tVrsDpyF6Usj44DuF1a9VpyHRkpn
         /zb/ySXsLtTjvZKa6CyMcXz73uizRxGZENJq8xXvS89p9JUYp4ALknig//YQ2rWUNaeK
         O3+Tx3bGp9of0fC3u3z7tw+/odYHMlkyR6e7Fy79ytBjXf1LVlo/3rmcJ1U17GfWrhjj
         jl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMKTZdgN+ApLkWCndc7XhEgCcK+nIdQXAhjOxRLrovs=;
        b=KLhaXqHG8u3PSUv7b7xUYsXEkV5RMh8ukPX8B1/Iy0wZapeQXFRvIPoe54cUGHCb0n
         AhlCAjVRlrK/DBH5/mheeV8vCkArjYbb5m0tHGLQ3Jm8aXY+tIbO9XSPTiaPVHNCNi1T
         idH/vCoyhjKHmf52Xl3Jrs0ICnNYZ3cg7O7SL+1wQN0ytFI0dOtSn0t9vOFdgELowEJ6
         +xBGy5/WvY7kHq5m5qH0Ih7a6Gyl5p2czQjOXEcl4ni63+3Wy4CV1aIG4AUpjImgx77V
         fPoA41nBjfjMb8/IRDbGSaCUHslztYtjMap6bBr65MHFKEr0oaE/M+fYoeox4hJUOHj7
         buXA==
X-Gm-Message-State: AOAM533ySTTklG9/HHganljZHElSUmfCE+pwA1UNWFtvmP+d3IA8eylw
        arZP82a/ymy+yXbKTuR3wCK8bg==
X-Google-Smtp-Source: ABdhPJzE1oxrOQvVokLNs2sj/ZfJYA4/9hHzo0LXS4aCsZyDz6uiaCLCjdEkUPcQzGEHcpTOPhQfqA==
X-Received: by 2002:a0c:f986:: with SMTP id t6mr22149242qvn.15.1612897288164;
        Tue, 09 Feb 2021 11:01:28 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 82sm2656726qkd.48.2021.02.09.11.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:01:27 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] fs: buffer: use raw page_memcg() on locked page
Date:   Tue,  9 Feb 2021 14:01:26 -0500
Message-Id: <20210209190126.97842-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

alloc_page_buffers() currently uses get_mem_cgroup_from_page() for
charging the buffers to the page owner, which does an rcu-protected
page->memcg lookup and acquires a reference. But buffer allocation has
the page lock held throughout, which pins the page to the memcg and
thereby the memcg - neither rcu nor holding an extra reference during
the allocation are necessary. Use a raw page_memcg() instead.

This was the last user of get_mem_cgroup_from_page(), delete it.

Reported-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/buffer.c                |  4 ++--
 include/linux/memcontrol.h |  7 -------
 mm/memcontrol.c            | 23 -----------------------
 3 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 96c7604f69b3..dc5d3e22c493 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -847,7 +847,8 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 	if (retry)
 		gfp |= __GFP_NOFAIL;
 
-	memcg = get_mem_cgroup_from_page(page);
+	/* The page lock pins the memcg */
+	memcg = page_memcg(page);
 	old_memcg = set_active_memcg(memcg);
 
 	head = NULL;
@@ -868,7 +869,6 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 	}
 out:
 	set_active_memcg(old_memcg);
-	mem_cgroup_put(memcg);
 	return head;
 /*
  * In case anything failed, we just free everything we got.
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a8c7a0ccc759..a44b2d51aecc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -687,8 +687,6 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
 
-struct mem_cgroup *get_mem_cgroup_from_page(struct page *page);
-
 struct lruvec *lock_page_lruvec(struct page *page);
 struct lruvec *lock_page_lruvec_irq(struct page *page);
 struct lruvec *lock_page_lruvec_irqsave(struct page *page,
@@ -1169,11 +1167,6 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	return NULL;
 }
 
-static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
-{
-	return NULL;
-}
-
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 51778fa9b462..9e455815fb7a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1048,29 +1048,6 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(get_mem_cgroup_from_mm);
 
-/**
- * get_mem_cgroup_from_page: Obtain a reference on given page's memcg.
- * @page: page from which memcg should be extracted.
- *
- * Obtain a reference on page->memcg and returns it if successful. Otherwise
- * root_mem_cgroup is returned.
- */
-struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
-{
-	struct mem_cgroup *memcg = page_memcg(page);
-
-	if (mem_cgroup_disabled())
-		return NULL;
-
-	rcu_read_lock();
-	/* Page should not get uncharged and freed memcg under us. */
-	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
-		memcg = root_mem_cgroup;
-	rcu_read_unlock();
-	return memcg;
-}
-EXPORT_SYMBOL(get_mem_cgroup_from_page);
-
 static __always_inline struct mem_cgroup *active_memcg(void)
 {
 	if (in_interrupt())
-- 
2.30.0

