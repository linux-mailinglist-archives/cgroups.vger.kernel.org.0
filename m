Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D28120BFA9
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2020 09:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgF0HdS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Jun 2020 03:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgF0HdR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Jun 2020 03:33:17 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94F2C03E979;
        Sat, 27 Jun 2020 00:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vmpoA1D7dyjV06bzwDyN/+k+GU++bNP7VnywwlpIVGc=; b=cbYqXmVeSoBvWX/9hZmJT+Lpgl
        l5Y6Vcm2ctIJzcPBTMX3VolpG677Sf4JJWJZfg14gMcYc1m3NFSPX26I/Vdufl8Wj4OJD/jl2Umzw
        27pEigOY5nvjxvYMvM49rAPEbxY55yRTlPi3Lbfj1+TngLfjOcWXmlbk3hcRzSGoz6hhvGr0okR7W
        GCJr60AtGTdEOj8PSSltng1UW/O17eCtnu6LH/wkHVpdPf76uXKO6uYRjV3pBB02z8yKJ9PAQx81q
        mu+xZlNzRT5mjjmmiZE8tNwZpxaMdqqkKx8I//a0cFfvkQn/kdUEIwH5bGq7AXsO0yq6LLvd29UPA
        2/yaXMOg==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5KY-0006qv-AN; Sat, 27 Jun 2020 07:32:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 14/14] blk-cgroup: remove a dead check in blk_throtl_bio
Date:   Sat, 27 Jun 2020 09:31:59 +0200
Message-Id: <20200627073159.2447325-15-hch@lst.de>
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

bios must have a valid block group by the time they are submitted.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 9d00f62c05ecdf..ad37043297ed58 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2163,7 +2163,7 @@ bool blk_throtl_bio(struct bio *bio)
 	struct request_queue *q = bio->bi_disk->queue;
 	struct blkcg_gq *blkg = bio->bi_blkg;
 	struct throtl_qnode *qn = NULL;
-	struct throtl_grp *tg = blkg_to_tg(blkg ?: q->root_blkg);
+	struct throtl_grp *tg = blkg_to_tg(blkg);
 	struct throtl_service_queue *sq;
 	bool rw = bio_data_dir(bio);
 	bool throttled = false;
-- 
2.26.2

