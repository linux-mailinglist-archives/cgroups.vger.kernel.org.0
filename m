Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067E3286D56
	for <lists+cgroups@lfdr.de>; Thu,  8 Oct 2020 05:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgJHDwr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Oct 2020 23:52:47 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44209 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbgJHDwn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Oct 2020 23:52:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UBG9jYw_1602129160;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UBG9jYw_1602129160)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Oct 2020 11:52:40 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] blk-throttle: Move the list operation after list validation
Date:   Thu,  8 Oct 2020 11:52:26 +0800
Message-Id: <48232fffcfb16d40aa0fedc455a0f69f1f7c45f4.1602128837.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
References: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
References: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We should move the list operation after validation.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-throttle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 0649bce..f1bcb5c 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -423,12 +423,13 @@ static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
  */
 static struct bio *throtl_peek_queued(struct list_head *queued)
 {
-	struct throtl_qnode *qn = list_first_entry(queued, struct throtl_qnode, node);
+	struct throtl_qnode *qn;
 	struct bio *bio;
 
 	if (list_empty(queued))
 		return NULL;
 
+	qn = list_first_entry(queued, struct throtl_qnode, node);
 	bio = bio_list_peek(&qn->bios);
 	WARN_ON_ONCE(!bio);
 	return bio;
@@ -451,12 +452,13 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
 static struct bio *throtl_pop_queued(struct list_head *queued,
 				     struct throtl_grp **tg_to_put)
 {
-	struct throtl_qnode *qn = list_first_entry(queued, struct throtl_qnode, node);
+	struct throtl_qnode *qn;
 	struct bio *bio;
 
 	if (list_empty(queued))
 		return NULL;
 
+	qn = list_first_entry(queued, struct throtl_qnode, node);
 	bio = bio_list_pop(&qn->bios);
 	WARN_ON_ONCE(!bio);
 
-- 
1.8.3.1

