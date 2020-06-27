Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10BB20BFB3
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2020 09:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgF0Hcp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Jun 2020 03:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgF0Hco (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Jun 2020 03:32:44 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484C2C03E97A;
        Sat, 27 Jun 2020 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Xpio8MsBnjn0ZZX6kn1sCcutxgSaexamcwAr94sVSxo=; b=lXKR3KOvyolkJvQ5vU5UcEIzmG
        NYPk7kN3ZRmanvN7d8Wa79vMwEVXOCKwhA5cRXqxRnIzRaQKFfeyijCzahSTeBwTtWxQdOXhVpyO/
        YuHacuqeUBjX3qf3iAdjhLyYUt1l/IQAcaFJsrw2gxdW0HYASxszrpqF1yn41OUOea6/fVJZr/T6K
        60U+ok5Yg/ke/5eSyH/QCSPyx1bDiWE8jYVYGCoahVg4SZqCwkcX6+WR85l+0dHx4s82sh1IT7KeT
        P3vou1PSNgXzRlYwf4Fvs1JsOZLLoK4ZGYC11tzwf5gfVLbj7i+vGui4+co9JaY7GjpfoIjre4B5O
        CO34+0jQ==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5Jw-0006me-CB; Sat, 27 Jun 2020 07:32:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 05/14] block: move bio_associate_blkg_from_page to mm/page_io.c
Date:   Sat, 27 Jun 2020 09:31:50 +0200
Message-Id: <20200627073159.2447325-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627073159.2447325-1-hch@lst.de>
References: <20200627073159.2447325-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

bio_associate_blkg_from_page is a special purpose helper for swap bios
that doesn't need access to bio internals.  Move it to the swap code
instead of having it in bio.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 26 --------------------------
 include/linux/bio.h |  7 -------
 mm/page_io.c        | 17 +++++++++++++++++
 3 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index bc8de2432e3645..901d22715dd4f3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1659,32 +1659,6 @@ void bio_associate_blkg_from_css(struct bio *bio,
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
 
-#ifdef CONFIG_MEMCG
-/**
- * bio_associate_blkg_from_page - associate a bio with the page's blkg
- * @bio: target bio
- * @page: the page to lookup the blkcg from
- *
- * Associate @bio with the blkg from @page's owning memcg and the respective
- * request_queue.  If cgroup_e_css returns %NULL, fall back to the queue's
- * root_blkg.
- */
-void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
-{
-	struct cgroup_subsys_state *css;
-
-	if (!page->mem_cgroup)
-		return;
-
-	rcu_read_lock();
-
-	css = cgroup_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
-	bio_associate_blkg_from_css(bio, css);
-
-	rcu_read_unlock();
-}
-#endif /* CONFIG_MEMCG */
-
 /**
  * bio_associate_blkg - associate a bio with a blkg
  * @bio: target bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 4cd229e175c058..c6d76538292644 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -489,13 +489,6 @@ do {						\
 #define bio_dev(bio) \
 	disk_devt((bio)->bi_disk)
 
-#if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
-void bio_associate_blkg_from_page(struct bio *bio, struct page *page);
-#else
-static inline void bio_associate_blkg_from_page(struct bio *bio,
-						struct page *page) { }
-#endif
-
 #ifdef CONFIG_BLK_CGROUP
 void bio_associate_blkg(struct bio *bio);
 void bio_associate_blkg_from_css(struct bio *bio,
diff --git a/mm/page_io.c b/mm/page_io.c
index e8726f3e3820bf..ccda7679008851 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -277,6 +277,23 @@ static inline void count_swpout_vm_event(struct page *page)
 	count_vm_events(PSWPOUT, hpage_nr_pages(page));
 }
 
+#if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
+static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
+{
+	struct cgroup_subsys_state *css;
+
+	if (!page->mem_cgroup)
+		return;
+
+	rcu_read_lock();
+	css = cgroup_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
+	bio_associate_blkg_from_css(bio, css);
+	rcu_read_unlock();
+}
+#else
+#define bio_associate_blkg_from_page(bio, page)		do { } while (0)
+#endif /* CONFIG_MEMCG && CONFIG_BLK_CGROUP */
+
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		bio_end_io_t end_write_func)
 {
-- 
2.26.2

