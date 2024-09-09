Return-Path: <cgroups+bounces-4758-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F20971B6C
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 15:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113FF1F22D32
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 13:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556BC1BAEDC;
	Mon,  9 Sep 2024 13:43:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC01BA263;
	Mon,  9 Sep 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889434; cv=none; b=n7wX2CqVkQIWkZTWmJ/DQHCGNcXpfbpK0Y6kTTBuTz4MWD9WrnoRtsslFLzvmcRQWO/UCVDeKv+yvQSfY9hmXkhQzYt7WoHC8GNilrwJzv9PvseiuOO7Nmbp++gWDb/XL36tevbtI7dePVnUeLM6MpTtnSLNex+0qNnhc+9JMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889434; c=relaxed/simple;
	bh=Y6TWkZzkr6fJXfIzW5ghH0ju77NoPXhsGSxEbjnHY70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aH3wRSZZ+zeA/4z5cIU8/4SXMTumHUok4iajgEDqbOdEAUWmeVOXnLnqnzOsbFuDABhoFfRKGoujkrnm9Grqvw67MsENu9Te2lRg7wMnXcqLFw8/KVd+Ai5BcgZDbeOqevaiCHjpNK6RYi8P4SgsDrCPQmm6AhNWq8vWqaQAqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X2Sj20t8vz4f3jdh;
	Mon,  9 Sep 2024 21:43:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6E77C1A161E;
	Mon,  9 Sep 2024 21:43:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn28eQ+95mhC1hAw--.55605S11;
	Mon, 09 Sep 2024 21:43:49 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai3@huawei.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH for-6.12 7/7] block, bfq: factor out a helper to split bfqq in bfq_init_rq()
Date: Mon,  9 Sep 2024 21:41:54 +0800
Message-Id: <20240909134154.954924-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909134154.954924-1-yukuai1@huaweicloud.com>
References: <20240909134154.954924-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn28eQ+95mhC1hAw--.55605S11
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4Uur4DGr4fCw4rWr1rJFb_yoWrurW3p3
	W3Kw43Zr48JF4Ygr45J3W5Aw1fKr4fW3sxKrWfX34rJryDJwnavFn0yw1rXF4S9rWkJrnx
	Zr1Fq3yDCr4xJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Make code cleaner, there are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 109 +++++++++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 51 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7936e8bc166a..0747d9d0e48c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6737,11 +6737,10 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq)
 	return NULL;
 }
 
-static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
-						   struct bfq_io_cq *bic,
-						   struct bio *bio,
-						   bool split, bool is_sync,
-						   bool *new_queue)
+static struct bfq_queue *
+__bfq_get_bfqq_handle_split(struct bfq_data *bfqd, struct bfq_io_cq *bic,
+			    struct bio *bio, bool split, bool is_sync,
+			    bool *new_queue)
 {
 	unsigned int act_idx = bfq_actuator_index(bfqd, bio);
 	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync, act_idx);
@@ -6845,6 +6844,59 @@ static struct bfq_queue *bfq_waker_bfqq(struct bfq_queue *bfqq)
 	return waker_bfqq;
 }
 
+static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
+						   struct bfq_io_cq *bic,
+						   struct bio *bio,
+						   unsigned int idx,
+						   bool is_sync)
+{
+	struct bfq_queue *waker_bfqq;
+	struct bfq_queue *bfqq;
+	bool new_queue = false;
+
+	bfqq = __bfq_get_bfqq_handle_split(bfqd, bic, bio, false, is_sync,
+					   &new_queue);
+	if (unlikely(new_queue))
+		return bfqq;
+
+	/* If the queue was seeky for too long, break it apart. */
+	if (!bfq_bfqq_coop(bfqq) || !bfq_bfqq_split_coop(bfqq) ||
+	    bic->bfqq_data[idx].stably_merged)
+		return bfqq;
+
+	waker_bfqq = bfq_waker_bfqq(bfqq);
+
+	/* Update bic before losing reference to bfqq */
+	if (bfq_bfqq_in_large_burst(bfqq))
+		bic->bfqq_data[idx].saved_in_large_burst = true;
+
+	bfqq = bfq_split_bfqq(bic, bfqq);
+	if (bfqq) {
+		bfq_bfqq_resume_state(bfqq, bfqd, bic, true);
+		return bfqq;
+	}
+
+	bfqq = __bfq_get_bfqq_handle_split(bfqd, bic, bio, true, is_sync, NULL);
+	if (unlikely(bfqq == &bfqd->oom_bfqq))
+		return bfqq;
+
+	bfq_bfqq_resume_state(bfqq, bfqd, bic, false);
+	bfqq->waker_bfqq = waker_bfqq;
+	bfqq->tentative_waker_bfqq = NULL;
+
+	/*
+	 * If the waker queue disappears, then new_bfqq->waker_bfqq must be
+	 * reset. So insert new_bfqq into the
+	 * woken_list of the waker. See
+	 * bfq_check_waker for details.
+	 */
+	if (waker_bfqq)
+		hlist_add_head(&bfqq->woken_list_node,
+			       &bfqq->waker_bfqq->woken_list);
+
+	return bfqq;
+}
+
 /*
  * If needed, init rq, allocate bfq data structures associated with
  * rq, and increment reference counters in the destination bfq_queue
@@ -6876,7 +6928,6 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	struct bfq_io_cq *bic;
 	const int is_sync = rq_is_sync(rq);
 	struct bfq_queue *bfqq;
-	bool new_queue = false;
 	unsigned int a_idx = bfq_actuator_index(bfqd, bio);
 
 	if (unlikely(!rq->elv.icq))
@@ -6893,53 +6944,9 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 		return RQ_BFQQ(rq);
 
 	bic = icq_to_bic(rq->elv.icq);
-
 	bfq_check_ioprio_change(bic, bio);
-
 	bfq_bic_update_cgroup(bic, bio);
-
-	bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio, false, is_sync,
-					 &new_queue);
-
-	if (likely(!new_queue)) {
-		/* If the queue was seeky for too long, break it apart. */
-		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
-			!bic->bfqq_data[a_idx].stably_merged) {
-			struct bfq_queue *waker_bfqq = bfq_waker_bfqq(bfqq);
-
-			/* Update bic before losing reference to bfqq */
-			if (bfq_bfqq_in_large_burst(bfqq))
-				bic->bfqq_data[a_idx].saved_in_large_burst =
-					true;
-
-			bfqq = bfq_split_bfqq(bic, bfqq);
-			if (!bfqq) {
-				bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio,
-								 true, is_sync,
-								 NULL);
-				if (likely(bfqq != &bfqd->oom_bfqq)) {
-					bfq_bfqq_resume_state(bfqq, bfqd, bic,
-							      false);
-					bfqq->waker_bfqq = waker_bfqq;
-					bfqq->tentative_waker_bfqq = NULL;
-
-					/*
-					 * If the waker queue disappears, then
-					 * new_bfqq->waker_bfqq must be
-					 * reset. So insert new_bfqq into the
-					 * woken_list of the waker. See
-					 * bfq_check_waker for details.
-					 */
-					if (waker_bfqq)
-						hlist_add_head(
-							&bfqq->woken_list_node,
-							&bfqq->waker_bfqq->woken_list);
-				}
-			} else {
-				bfq_bfqq_resume_state(bfqq, bfqd, bic, true);
-			}
-		}
-	}
+	bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio, a_idx, is_sync);
 
 	bfqq_request_allocated(bfqq);
 	bfqq->ref++;
-- 
2.39.2


