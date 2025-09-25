Return-Path: <cgroups+bounces-10439-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF64BB9E092
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 10:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4A4420629
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856402773C0;
	Thu, 25 Sep 2025 08:25:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2726FA4B;
	Thu, 25 Sep 2025 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788754; cv=none; b=t/FARhupy6H4bQ2yFccGpcQSvqHpo5GllKPXgc7RasSz5vXaTSvc1a3kI0WNrcZ0/oyCKnZ6w0K3EXX1YpYN8rZy/FjoiiXZkCHIN+9Lt+jrz4J/MWDHDhM8pXgVIhPedsGO29cXYl1EKh9t1fARl3V/AX9CWTYxgl5DnSyYzWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788754; c=relaxed/simple;
	bh=eNC4lIXvcONQK8mkp+8DNTHITjCwhh5y9Jsy9BfsANU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=umv8tv5QKXz4AgzTeltL10qnituINAgYiqHw+FD3/4UdRvqhs85IL6Mr6fyss9vc2fh0/FCWCe1FOoAZpS9FWeJs5BqKxu5SmwWpdO/wiM5fCrKpc1pndZcMoRK3HN3Sq9GXMQLaaNkmjqVbREThJU30td0U/liXsRkVkHmDWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cXRcQ26wPzKHN4T;
	Thu, 25 Sep 2025 16:25:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 25D021A0F41;
	Thu, 25 Sep 2025 16:25:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCna2OH_NRodTcIAw--.12615S10;
	Thu, 25 Sep 2025 16:25:49 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: tj@kernel.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	hch@lst.de,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	akpm@linux-foundation.org,
	vgoyal@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 06/10] block, bfq: don't grab queue_lock to initialize bfq
Date: Thu, 25 Sep 2025 16:15:21 +0800
Message-Id: <20250925081525.700639-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250925081525.700639-1-yukuai1@huaweicloud.com>
References: <20250925081525.700639-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCna2OH_NRodTcIAw--.12615S10
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4DWr1rWr4ftFW5Cw4rKrg_yoW8GrWDpF
	Z5Wa1Y9w10gr4DZryDJFnrXwnrGa929rWxtrWxtr45Kry2qrn3W3W8Aa4xXF4Sqrs7Aan5
	ur45K392yr17t37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Request_queue is freezed and quiesced during elevator init_sched()
method, there is no point to hold queue_lock for protection.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4a8d3d96bfe4..a77b98187370 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7213,10 +7213,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 		return -ENOMEM;
 
 	eq->elevator_data = bfqd;
-
-	spin_lock_irq(&q->queue_lock);
 	q->elevator = eq;
-	spin_unlock_irq(&q->queue_lock);
 
 	/*
 	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
@@ -7249,7 +7246,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 	 * If the disk supports multiple actuators, copy independent
 	 * access ranges from the request queue structure.
 	 */
-	spin_lock_irq(&q->queue_lock);
 	if (ia_ranges) {
 		/*
 		 * Check if the disk ia_ranges size exceeds the current bfq
@@ -7275,7 +7271,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 		bfqd->sector[0] = 0;
 		bfqd->nr_sectors[0] = get_capacity(q->disk);
 	}
-	spin_unlock_irq(&q->queue_lock);
 
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
-- 
2.39.2


