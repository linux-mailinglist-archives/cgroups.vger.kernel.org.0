Return-Path: <cgroups+bounces-4756-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB10971B67
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 15:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501A3B20E63
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDDA1BA893;
	Mon,  9 Sep 2024 13:43:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05801B9B2B;
	Mon,  9 Sep 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889433; cv=none; b=C3dvcaj7Kfbllx5EA+GxYTKflca0JmsKg/oIQPmlxDdtzqR2IMK7mBdyZAmaEWgoD6PZVXPR3I8Mb3uWcdk9yI6qdOI/y2ER2Ddx9RJoDx78F5SFg6cVxp2bK9VuIcDeigoBNPcGZtiPuQpB2Cx3YUZRbm/tIdOY9yZQmrNfU/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889433; c=relaxed/simple;
	bh=kz97C6vMEy0VnAmFC3nPe0Wg3RqtVN/6B52RA6E6BIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/xCHafRHAZClE2J3hyi+Zw5XiV+d+FbpuisRPERrTcvhFBFuN0/TI2Oae6xh2RRxNRx4forPZ1/dGHBfa4QnibXZ//Uf5MVoUJD6hiRsU4d0VRFPfv5KnQQuGdKK9phPehwAYeOGaFrJ9S5TnLJ5TTilZ3i7GSV6GA4ftr5M6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X2Sj56xg4z4f3jss;
	Mon,  9 Sep 2024 21:43:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7EAD01A06D7;
	Mon,  9 Sep 2024 21:43:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn28eQ+95mhC1hAw--.55605S9;
	Mon, 09 Sep 2024 21:43:48 +0800 (CST)
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
Subject: [PATCH for-6.12 5/7] block, bfq: remove local variable 'split' in bfq_init_rq()
Date: Mon,  9 Sep 2024 21:41:52 +0800
Message-Id: <20240909134154.954924-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn28eQ+95mhC1hAw--.55605S9
X-Coremail-Antispam: 1UD129KBjvJXoWxJr45ZF13XFW3Xw4ftr4xJFb_yoW8urW5pw
	s3Ga1Y9a18JFs09r4rJ3y3tF9xWr4ru3srJr9Ig3s3tryDAwnIqayqyw15JFWIgrZ7Kw13
	Xr15Z39xAw4jqwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The local variable is used to call bfq_bfqq_resume_state() later,
since 'bfqd->lock' is held, and bfqq status will not change between
setting 'split' and calling bfq_bfqq_resume_state(), move forward
bfq_bfqq_resume_state() so that 'split' can be removed. There are no
functional chagnes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 17b0bf6b56bb..54f6eae2763d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6877,7 +6877,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	const int is_sync = rq_is_sync(rq);
 	struct bfq_queue *bfqq;
 	bool new_queue = false;
-	bool bfqq_already_existing = false, split = false;
+	bool bfqq_already_existing = false;
 	unsigned int a_idx = bfq_actuator_index(bfqd, bio);
 
 	if (unlikely(!rq->elv.icq))
@@ -6914,16 +6914,19 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 					true;
 
 			bfqq = bfq_split_bfqq(bic, bfqq);
-			split = true;
-
 			if (!bfqq) {
 				bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio,
 								 true, is_sync,
 								 NULL);
 				if (unlikely(bfqq == &bfqd->oom_bfqq))
 					bfqq_already_existing = true;
-			} else
+				else
+					bfq_bfqq_resume_state(bfqq, bfqd, bic,
+							      false);
+			} else {
 				bfqq_already_existing = true;
+				bfq_bfqq_resume_state(bfqq, bfqd, bic, true);
+			}
 
 			if (!bfqq_already_existing) {
 				bfqq->waker_bfqq = waker_bfqq;
@@ -6959,18 +6962,8 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	 * resume its state.
 	 */
 	if (likely(bfqq != &bfqd->oom_bfqq) && !bfqq->new_bfqq &&
-	    bfqq_process_refs(bfqq) == 1) {
+	    bfqq_process_refs(bfqq) == 1)
 		bfqq->bic = bic;
-		if (split) {
-			/*
-			 * The queue has just been split from a shared
-			 * queue: restore the idle window and the
-			 * possible weight raising period.
-			 */
-			bfq_bfqq_resume_state(bfqq, bfqd, bic,
-					      bfqq_already_existing);
-		}
-	}
 
 	/*
 	 * Consider bfqq as possibly belonging to a burst of newly
-- 
2.39.2


