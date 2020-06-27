Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9242520BFB4
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2020 09:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgF0Hcf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Jun 2020 03:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF0Hce (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Jun 2020 03:32:34 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C4BC03E97E;
        Sat, 27 Jun 2020 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=te67Kz6q7FtaNJUJ111t8gsYne197tgP/jW4K8xX9vA=; b=NllTbXB2YDFcVqcI043iyFsHwr
        tt77jKmSatOzYm5rqro2913myOlHulKnX4dt+8MOfTpepgR6TO2fYBzD4y3xZLLq57sFsuQKwjUn/
        lLsBuzEeKDXVHq14z0Y+4mUXx0ae20B6us+olRYV4IeSBgdmadhqE/mKZGOP0xLqG7DAOykeARTW8
        Vjwxz8hyIJzVL46ScOCngCuMa5pAPZ9e4ExDnntp/DtIrhC5V8t0SDq3ssA0P/EEZesARi7JZ4vl/
        YcKpLXYo8gmWNoJberB6ct7R0JEf97ic7E/wfDM/BF56/51DV1p8WH5aKgRth6mdXE0o4D8tMK60/
        N0hDQYQg==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5Jr-0006mC-8O; Sat, 27 Jun 2020 07:32:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 03/14] block: really clone the block cgroup in bio_clone_blkg_association
Date:   Sat, 27 Jun 2020 09:31:48 +0200
Message-Id: <20200627073159.2447325-4-hch@lst.de>
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

bio_clone_blkg_association is supposed to clone the associatation, but
actually ends up doing a search with a tryget.  As we know we have a
reference on the source cgroup just get an unconditional additional
reference to it and call it a day.  That also removes the need for
a RCU critical section.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8aef4460b32e0e..e1d01acce8070c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1737,12 +1737,12 @@ EXPORT_SYMBOL_GPL(bio_associate_blkg);
  */
 void bio_clone_blkg_association(struct bio *dst, struct bio *src)
 {
-	rcu_read_lock();
-
-	if (src->bi_blkg)
-		__bio_associate_blkg(dst, src->bi_blkg);
-
-	rcu_read_unlock();
+	if (src->bi_blkg) {
+		if (dst->bi_blkg)
+			blkg_put(dst->bi_blkg);
+		blkg_get(src->bi_blkg);
+		dst->bi_blkg = src->bi_blkg;
+	}
 }
 EXPORT_SYMBOL_GPL(bio_clone_blkg_association);
 #endif /* CONFIG_BLK_CGROUP */
-- 
2.26.2

