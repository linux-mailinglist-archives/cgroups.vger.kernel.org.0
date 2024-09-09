Return-Path: <cgroups+bounces-4759-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6691B971B6E
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 15:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934D61C23215
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E5E1BAEF2;
	Mon,  9 Sep 2024 13:43:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F1C1B9B28;
	Mon,  9 Sep 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889434; cv=none; b=XeadWlKhMClZUfQGDLDIWKpEJVT23yD8yLj4nfJ9yT8xzrvqr9qOAgyLGBdW6H7K0s4yoD0cSXwyhQ9Bx/o1L7fv2JrcYDWekH7suiSLBYvOGFWn3Cbygs1Ou+aXVlH9OyZAdJqC4Mb2JFTRf1hRkenVJBUZEVYbQzNcAEo0a7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889434; c=relaxed/simple;
	bh=n9hQlGWaEXWjn+plniNZuHsgtaHGbGyA+9xgiuq2yuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqLE3IQhzUnc/NmaCW8ALLsL76GvSjgNBmmuNxqu9EqsloKwk8OhQAzl8K81q9q8uiE8Vqi4aIr/kvJo5UbSFCNQ3pzJ0bujgEas55rw+N7XhGcs670B3exs6+IyJk4FtGbsbOlTayp5owHpxX3x952kpGe2LiGDsz/qr4XA+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X2Sj50Flkz4f3jtC;
	Mon,  9 Sep 2024 21:43:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8BC861A0359;
	Mon,  9 Sep 2024 21:43:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn28eQ+95mhC1hAw--.55605S7;
	Mon, 09 Sep 2024 21:43:47 +0800 (CST)
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
Subject: [PATCH for-6.12 3/7] block, bfq: merge bfq_release_process_ref() into bfq_put_cooperator()
Date: Mon,  9 Sep 2024 21:41:50 +0800
Message-Id: <20240909134154.954924-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn28eQ+95mhC1hAw--.55605S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyDtr1kKr4fur1xGF45Jrb_yoW8WF4fpw
	sFqw4qkF18GFn0qr4UAa1DX3WxJFn5G3srtry0q342vr9rAw12qFs0vw1FvF4Fqrs5Awsx
	ZryvkrWvyr1xWrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	vjDU0xZFpf9x0JUHWlkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Because bfq_put_cooperator() is always followed by
bfq_release_process_ref().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  | 1 -
 block/bfq-iosched.c | 6 ++----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fb9f3533150..e831aedb4643 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -736,7 +736,6 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
 		 */
 		bfq_put_cooperator(sync_bfqq);
 		bic_set_bfqq(bic, NULL, true, act_idx);
-		bfq_release_process_ref(bfqd, sync_bfqq);
 	}
 }
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f4192d5411d2..17b0bf6b56bb 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5434,6 +5434,8 @@ void bfq_put_cooperator(struct bfq_queue *bfqq)
 		bfq_put_queue(__bfqq);
 		__bfqq = next;
 	}
+
+	bfq_release_process_ref(bfqq->bfqd, bfqq);
 }
 
 static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
@@ -5446,8 +5448,6 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_log_bfqq(bfqd, bfqq, "exit_bfqq: %p, %d", bfqq, bfqq->ref);
 
 	bfq_put_cooperator(bfqq);
-
-	bfq_release_process_ref(bfqd, bfqq);
 }
 
 static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync,
@@ -6734,8 +6734,6 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq)
 	bic_set_bfqq(bic, NULL, true, bfqq->actuator_idx);
 
 	bfq_put_cooperator(bfqq);
-
-	bfq_release_process_ref(bfqq->bfqd, bfqq);
 	return NULL;
 }
 
-- 
2.39.2


