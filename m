Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D3920BFAC
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2020 09:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgF0Hc7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Jun 2020 03:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgF0Hc7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Jun 2020 03:32:59 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7A3C03E979;
        Sat, 27 Jun 2020 00:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nSd3C/DSNsC2O/2jsqExpsnu1gd7FF5TZdmvZuWRNPs=; b=Pg+uD5ySHobKze+G3z72vgMqje
        I3LI6dZfO3nOCLTW9PT7d6ugzTiNDCEtNY0mB8yeFck0uVAD2NK5kK59O4flLxaLCnECUhOYCji/N
        23QiHSqYjFn0jgYdIdjxCpjH5iZhuxzwRMC4wcK+4Twctub06mZx70N39Cbqk/hfMBAkUlPxfTQ2g
        31pSU1TgdBefiv2HiZm9UGCDAiZyPFWA+BRsBAHsiC++udMAeoOwBhV/B6DEPUDWSu+2pKW9N+h9T
        9oxhhPsi7vxIWB8qxOh9/U4FNAjdd0QkyaliIKRQ+QJF/o7aLfD7PoAqxpk6jCQ1OXTSVMnAoGcrS
        q7oYemlA==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5KD-0006nj-M4; Sat, 27 Jun 2020 07:32:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 10/14] blk-cgroup: remove the !bio->bi_blkg check in blkcg_bio_issue_check
Date:   Sat, 27 Jun 2020 09:31:55 +0200
Message-Id: <20200627073159.2447325-11-hch@lst.de>
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

This is purely a sanity check for grave programming errors.  Remove it
to simplify further work in this area.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk-cgroup.h | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 60df97202314c7..8e86b598316c10 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -543,24 +543,11 @@ static inline void blkcg_bio_issue_init(struct bio *bio)
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio)
 {
-	struct blkcg_gq *blkg;
+	struct blkcg_gq *blkg = bio->bi_blkg;
 	bool throtl = false;
 
 	rcu_read_lock();
-
-	if (!bio->bi_blkg) {
-		char b[BDEVNAME_SIZE];
-
-		WARN_ONCE(1,
-			  "no blkg associated for bio on block-device: %s\n",
-			  bio_devname(bio, b));
-		bio_associate_blkg(bio);
-	}
-
-	blkg = bio->bi_blkg;
-
 	throtl = blk_throtl_bio(q, blkg, bio);
-
 	if (!throtl) {
 		struct blkg_iostat_set *bis;
 		int rwd, cpu;
-- 
2.26.2

