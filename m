Return-Path: <cgroups+bounces-10637-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B656FBCC4A6
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3985F406F0D
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51174277CBD;
	Fri, 10 Oct 2025 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGV9ww9a"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A7276028;
	Fri, 10 Oct 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087715; cv=none; b=ZMzfRxyO8QC9gfPosZoCzVwb2jsIX+lRKsc9lZSK6HLralAfMepuMkX8csV4d1ZT9w/gw96+8uz+YPuwcXWcHLh/2dpvQeFFzP5zIiYnmqJD7+Q/oPGXKOHNEzsiwCVT6vVo2qLSYddeNa/Q+AAcSNpNTrwx0ZxGPj7tsrvKYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087715; c=relaxed/simple;
	bh=FQQXZUoa9Daug55CdrLq0FNeKqBX+4W3fszrTzKrPg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQpb1+fBeLNyHtudaPYqLmsdyuMy4kLjdvs9Z99NYKIT3caiNHDFJUx8syL8UcCeJYvpfmWtg+m6QuWlXf+Bh/al0dOVQfPGMEXZHEkOSMv4kkd76qrmZ4NUVVEHOGAL8kZNescM88GorZ86CLnXxZvDi+F/EBibnYsz7kwk5mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGV9ww9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48269C4CEF1;
	Fri, 10 Oct 2025 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087714;
	bh=FQQXZUoa9Daug55CdrLq0FNeKqBX+4W3fszrTzKrPg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGV9ww9amy7L2IZtikL5KwF7RQkikyDgY9LUEikN4xPuXjov5yy+ryuu/G963y3bT
	 9yhnWFC3EIKBqp697+/6qlFrjCkSXxyf9GkVtORzsCVlKRC3dNQNha7DadwmsxZCIy
	 1Ucs832Z92hEvwd8D/16KRJ4hGYX4AzSFDZ4PKk8XLait2SgFbtZkuNJyg91s6NaMA
	 4e3nviEL2OYaYIwi4q6PVyj/mkGTHFcn4pkmx3kzFRH8Dq5uxE8997wJaxa+FPsCCL
	 YmwTlT1OB5RqQ2KBKg0TMfcxAxdHYh/Di5ibYO0LTrYOB748FS6dxVs7eC0zFbMQf6
	 aVJ5FN6tOBLNA==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	tj@kernel.org,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v2 08/19] block, bfq: don't grab queue_lock to initialize bfq
Date: Fri, 10 Oct 2025 17:14:33 +0800
Message-ID: <20251010091446.3048529-9-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010091446.3048529-1-yukuai@kernel.org>
References: <20251010091446.3048529-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

Request_queue is freezed and quiesced during elevator init_sched()
method, there is no point to hold queue_lock for protection.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9e0eee9aba5c..86309828e235 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7203,10 +7203,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 		return -ENOMEM;
 
 	eq->elevator_data = bfqd;
-
-	spin_lock_irq(&q->queue_lock);
 	q->elevator = eq;
-	spin_unlock_irq(&q->queue_lock);
 
 	/*
 	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
@@ -7239,7 +7236,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 	 * If the disk supports multiple actuators, copy independent
 	 * access ranges from the request queue structure.
 	 */
-	spin_lock_irq(&q->queue_lock);
 	if (ia_ranges) {
 		/*
 		 * Check if the disk ia_ranges size exceeds the current bfq
@@ -7265,7 +7261,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 		bfqd->sector[0] = 0;
 		bfqd->nr_sectors[0] = get_capacity(q->disk);
 	}
-	spin_unlock_irq(&q->queue_lock);
 
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
-- 
2.51.0


