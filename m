Return-Path: <cgroups+bounces-4752-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 995BA971B5B
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 15:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4488D1F2333E
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 13:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179A11BA261;
	Mon,  9 Sep 2024 13:43:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFFC1B9B37;
	Mon,  9 Sep 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889431; cv=none; b=fkeWoVpJ5D+2nqQp7xUL3d4HTlNCbOaG0irvOefoQqja9TGTzUwLRuhaL3Rpo0gq4OL0be77Ue0nkIdYrqA5gLCnyhOCEuRHGFc5ZHvY03rZKvNERiWWmtKLDEUjw36Het3cNjU8j+d+7rh0+siwO/mh6v2fg11wZX33Xmm7nzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889431; c=relaxed/simple;
	bh=car5VoO7KQM9TK3ZD9b5Vqo8D3t1zQm1Kq0SVkAOf24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HmE/IMmt1CY5q0HluNl+COnMrrcyMFFuwOXvJgNwsYUpiw+JsqDoQFBNxmkLfeTjdK4unNoohBDiXX7Hppc/YwFx6hHzF8RrxQTS29ynd6Pt85zudeBS+26LEKCRPApQ+g/BfPwOHrFZZRBezNDKQgqG7J5Uq7DtMQwDKBQnDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X2Sj40hqCz4f3jss;
	Mon,  9 Sep 2024 21:43:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9CAE51A07B6;
	Mon,  9 Sep 2024 21:43:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn28eQ+95mhC1hAw--.55605S5;
	Mon, 09 Sep 2024 21:43:46 +0800 (CST)
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
Subject: [PATCH for-6.12 1/7] block, bfq: fix uaf for accessing waker_bfqq after splitting
Date: Mon,  9 Sep 2024 21:41:48 +0800
Message-Id: <20240909134154.954924-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn28eQ+95mhC1hAw--.55605S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4DGFyrWw1DZFW5GF1xKrg_yoW5XF17pF
	43Kw4Yga1xJr43Wr4fGr4UA3W3tr1rWr9xGr4fJ34UtF17tw1IvFn09w1Fqw1fWr48Ar43
	Zr1Fv3yqkr4DJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU2dgAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

After commit 42c306ed7233 ("block, bfq: don't break merge chain in
bfq_split_bfqq()"), if the current procress is the last holder of bfqq,
the bfqq can be freed after bfq_split_bfqq(). Hence recored the bfqq and
then access bfqq->waker_bfqq may trigger UAF. What's more, the waker_bfqq
may in the merge chain of bfqq, hence just recored waker_bfqq is still
not safe.

Fix the problem by adding a helper bfq_waker_bfqq() to check if
bfqq->waker_bfqq is in the merge chain, and current procress is the only
holder.

Fixes: 42c306ed7233 ("block, bfq: don't break merge chain in bfq_split_bfqq()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d1bf2b8a3576..d5d39974c674 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6825,6 +6825,31 @@ static void bfq_prepare_request(struct request *rq)
 	rq->elv.priv[0] = rq->elv.priv[1] = NULL;
 }
 
+static struct bfq_queue *bfq_waker_bfqq(struct bfq_queue *bfqq)
+{
+	struct bfq_queue *new_bfqq = bfqq->new_bfqq;
+	struct bfq_queue *waker_bfqq = bfqq->waker_bfqq;
+
+	if (!waker_bfqq)
+		return NULL;
+
+	while (new_bfqq) {
+		if (new_bfqq == waker_bfqq) {
+			/*
+			 * If waker_bfqq is in the merge chain, and current
+			 * is the only procress.
+			 */
+			if (bfqq_process_refs(waker_bfqq) == 1)
+				return NULL;
+			break;
+		}
+
+		new_bfqq = new_bfqq->new_bfqq;
+	}
+
+	return waker_bfqq;
+}
+
 /*
  * If needed, init rq, allocate bfq data structures associated with
  * rq, and increment reference counters in the destination bfq_queue
@@ -6886,7 +6911,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 		/* If the queue was seeky for too long, break it apart. */
 		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
 			!bic->bfqq_data[a_idx].stably_merged) {
-			struct bfq_queue *old_bfqq = bfqq;
+			struct bfq_queue *waker_bfqq = bfq_waker_bfqq(bfqq);
 
 			/* Update bic before losing reference to bfqq */
 			if (bfq_bfqq_in_large_burst(bfqq))
@@ -6906,7 +6931,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 				bfqq_already_existing = true;
 
 			if (!bfqq_already_existing) {
-				bfqq->waker_bfqq = old_bfqq->waker_bfqq;
+				bfqq->waker_bfqq = waker_bfqq;
 				bfqq->tentative_waker_bfqq = NULL;
 
 				/*
@@ -6916,7 +6941,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 				 * woken_list of the waker. See
 				 * bfq_check_waker for details.
 				 */
-				if (bfqq->waker_bfqq)
+				if (waker_bfqq)
 					hlist_add_head(&bfqq->woken_list_node,
 						       &bfqq->waker_bfqq->woken_list);
 			}
-- 
2.39.2


