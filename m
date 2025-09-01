Return-Path: <cgroups+bounces-9528-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D746B3D799
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 05:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C263216B480
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C2723C8A1;
	Mon,  1 Sep 2025 03:41:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF820C461;
	Mon,  1 Sep 2025 03:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698080; cv=none; b=ECFUp93t4zBnFz5YX/fezkK1qruWi4V54kgPv1k5ygKb4NXRgwRw9g4pI8urwm0ci+jX7XXlKu4BBycONf+4gWi3BpBdhLWO3an0tq/u80sIAQCagULyBNhtK8KCt3T3sBbTACF2RtpxX3VJk91QJGYhE7jO3sl+MgbGvAsBQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698080; c=relaxed/simple;
	bh=WocAxZYZxzHYr79diAFydaY6JXd45C/1I3t8kuUpdBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iO4lJ7a6hRfUsh2tiJXXmEz0PqiSBw6WdZN8393SQalqzyFiqEsd+YTgw4Ctrop18s3XZXSQkOgaxLRJW1G/N5luxq0L33r0GtAqIanmIeZ7DdOr6HiuGYuhqwFx6/h20edHwd/CAgf8UH3UEuMLPvBy2j+XUfYk3LNtYJPNi80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cFZRL0kPNzYQvQH;
	Mon,  1 Sep 2025 11:41:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 93BC61A0E64;
	Mon,  1 Sep 2025 11:41:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzWFbVotmf1Aw--.38057S8;
	Mon, 01 Sep 2025 11:41:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	kmo@daterainc.com,
	satyat@google.com,
	ebiggers@google.com,
	neil@brown.name,
	akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC v3 04/15] blk-crypto: fix missing processing for split bio
Date: Mon,  1 Sep 2025 11:32:09 +0800
Message-Id: <20250901033220.42982-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250901033220.42982-1-yukuai1@huaweicloud.com>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIzWFbVotmf1Aw--.38057S8
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWkCF4xCF47Gw48urWruFg_yoWDJrX_WF
	WfWr1kJrWkG3Z7CFnYkFyvyw4kK34rZryUWFW7Ja4UAF4fGFWvkF43WFZ8urs2kFWxWa43
	Ca1DZFy8Kw1SqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbvAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7sRRtCztUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

1) trace_block_split() is missing and blktrace can't catch split events;
2) blkcg_bio_issue_init() is missing, and io-latency will not work
   correctly for split bio.

Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-crypto-fallback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 005c9157ffb3..cae11c2f96c5 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -231,7 +231,10 @@ static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
 			bio->bi_status = BLK_STS_RESOURCE;
 			return false;
 		}
+
+		blkcg_bio_issue_init(split_bio);
 		bio_chain(split_bio, bio);
+		trace_block_split(split_bio, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		*bio_ptr = split_bio;
 	}
-- 
2.39.2


