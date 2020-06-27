Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DA420BF8D
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2020 09:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgF0Hce (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Jun 2020 03:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgF0Hce (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Jun 2020 03:32:34 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23067C03E979;
        Sat, 27 Jun 2020 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TqBMh8wKMnVF/qZj/bM6cnnHs8Yim2J3gFC2ELItu+s=; b=C+ZyH4XC/PkkkGo8OrL4qvcn92
        TnizwBndOG4NHHJpYFLRpu8LYRZqZAN2x6fPq3HSY0c0038FlIUnkfpTHi3Qt2VhrxPFglng/X4Cc
        aZdSwTUR1u/eINbQC2X9UvbpnjV1m7wgCSeWJCDjROxe87fuIzT0EQqaXmxcSmrm4yq1F+bzu8VUN
        1HvaMG5Z4RE93Payt3MIpxhHccumVWuOutqXqy60zCifApzwCB2YgfFIETkyIrT0uDpmMHAqwsDmS
        jmmV+CbyN7d3VFXs3yi5MBQmvswTJ9K17V+dHSM5wowN9H+wv4o0R17ejZHH5EoXtFjTRlYlOK53+
        nUeLzM7Q==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5Jo-0006m0-Ro; Sat, 27 Jun 2020 07:32:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 02/14] block: remove bio_disassociate_blkg
Date:   Sat, 27 Jun 2020 09:31:47 +0200
Message-Id: <20200627073159.2447325-3-hch@lst.de>
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

bio_disassociate_blkg has two callers, of which one immediately assigns
a new value to >bi_blkg.  Just open code the function in the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 27 ++++++++-------------------
 include/linux/bio.h |  2 --
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fb5533416fa670..8aef4460b32e0e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -234,8 +234,12 @@ struct bio_vec *bvec_alloc(gfp_t gfp_mask, int nr, unsigned long *idx,
 
 void bio_uninit(struct bio *bio)
 {
-	bio_disassociate_blkg(bio);
-
+#ifdef CONFIG_BLK_CGROUP
+	if (bio->bi_blkg) {
+		blkg_put(bio->bi_blkg);
+		bio->bi_blkg = NULL;
+	}
+#endif
 	if (bio_integrity(bio))
 		bio_integrity_free(bio);
 
@@ -1625,21 +1629,6 @@ EXPORT_SYMBOL(bioset_init_from_src);
 
 #ifdef CONFIG_BLK_CGROUP
 
-/**
- * bio_disassociate_blkg - puts back the blkg reference if associated
- * @bio: target bio
- *
- * Helper to disassociate the blkg from @bio if a blkg is associated.
- */
-void bio_disassociate_blkg(struct bio *bio)
-{
-	if (bio->bi_blkg) {
-		blkg_put(bio->bi_blkg);
-		bio->bi_blkg = NULL;
-	}
-}
-EXPORT_SYMBOL_GPL(bio_disassociate_blkg);
-
 /**
  * __bio_associate_blkg - associate a bio with the a blkg
  * @bio: target bio
@@ -1656,8 +1645,8 @@ EXPORT_SYMBOL_GPL(bio_disassociate_blkg);
  */
 static void __bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 {
-	bio_disassociate_blkg(bio);
-
+	if (bio->bi_blkg)
+		blkg_put(bio->bi_blkg);
 	bio->bi_blkg = blkg_tryget_closest(blkg);
 }
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 0282f8aa85935c..4cd229e175c058 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -497,13 +497,11 @@ static inline void bio_associate_blkg_from_page(struct bio *bio,
 #endif
 
 #ifdef CONFIG_BLK_CGROUP
-void bio_disassociate_blkg(struct bio *bio);
 void bio_associate_blkg(struct bio *bio);
 void bio_associate_blkg_from_css(struct bio *bio,
 				 struct cgroup_subsys_state *css);
 void bio_clone_blkg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
-static inline void bio_disassociate_blkg(struct bio *bio) { }
 static inline void bio_associate_blkg(struct bio *bio) { }
 static inline void bio_associate_blkg_from_css(struct bio *bio,
 					       struct cgroup_subsys_state *css)
-- 
2.26.2

