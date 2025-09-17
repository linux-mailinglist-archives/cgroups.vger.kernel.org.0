Return-Path: <cgroups+bounces-10192-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8B6B7E9EF
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 14:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D16463E79
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33896306B19;
	Wed, 17 Sep 2025 08:05:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08430596F;
	Wed, 17 Sep 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096342; cv=none; b=c4VQEsxddr9D84FkBtPhfki5LAwn70d9DEFxo8sGsTPI8ZvyTSw2/FYLtEvP9qi8Lp9oEDjHMrIcuglzf89DWqoKVakWOSR95PM5IBiEX+5T5UFRFACtIQNBC49X4mtIjshPcD9siObO3QNul201JoWgHTqGugnSTZtrYrE94p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096342; c=relaxed/simple;
	bh=y+CRfgW7PTzAGIICvfpS0/piQt86ehpc+tS0P4KHzKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DT5aCblWR7TqWi+UVfvyZE9nLNSkZfNYvxOGLOPm/zdR8ErLiLYeudf5VH3gAT4nq0xLjzS/+t4A9yPbjy/ZiL/X1ctAqL9Dcbu0DRjmTU879KxqZOCENbjuUA/vbq9EJ5dS9rcurfdVdP5l0LhrI19b0DAvcrninzvU92mOGKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cRWXq6KzzzYQvfr;
	Wed, 17 Sep 2025 16:05:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 794CB1A0B13;
	Wed, 17 Sep 2025 16:05:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY7Ia8poAvUtCw--.48684S4;
	Wed, 17 Sep 2025 16:05:29 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: yi.zhang@redhat.com,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	hanguangjiang@lixiang.com,
	liangjie@lixiang.com,
	yukuai3@huawei.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2] blk-throttle: fix throtl_data leak during disk release
Date: Wed, 17 Sep 2025 15:55:39 +0800
Message-Id: <20250917075539.62003-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY7Ia8poAvUtCw--.48684S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1xZrWrKr4rAFy5uFyDZFb_yoW8ur18pF
	W3Zr4jkry7WrnrW3y5JF13XFWYka97Ar4rJ3s8Ar4fArWIvw1kJwn0vr1UuaykAFsakF4r
	Zr1rtr4kA3WUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Tightening the throttle activation check in blk_throtl_activated() to
require both q->td presence and policy bit set introduced a memory leak
during disk release:

blkg_destroy_all() clears the policy bit first during queue deactivation,
causing subsequent blk_throtl_exit() to skip throtl_data cleanup when
blk_throtl_activated() fails policy check.

Idealy we should avoid modifying blk_throtl_exit() activation check because
it's intuitive that blk-throtl start from blk_throtl_init() and end in
blk_throtl_exit(). However, call blk_throtl_exit() before
blkg_destroy_all() will make a long term deadlock problem easier to
trigger[1], hence fix this problem by checking if q->td is NULL from
blk_throtl_exit(), and remove policy deactivation as well since it's
useless.

[1] https://lore.kernel.org/all/CAHj4cs9p9H5yx+ywsb3CMUdbqGPhM+8tuBvhW=9ADiCjAqza9w@mail.gmail.com/#t
Fixes: bd9fd5be6bc0 ("blk-throttle: fix access race during throttle policy activation")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs-p-ZwBEKigBj7T6hQCOo-H68-kVwCrV6ZvRovrr9Z+HA@mail.gmail.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v2:
 - fix the problem by checking q->td directly;

 block/blk-throttle.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f510ae072868..2c5b64b1a724 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1842,12 +1842,15 @@ void blk_throtl_exit(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 
-	if (!blk_throtl_activated(q))
+	/*
+	 * blkg_destroy_all() already deactivate throtl policy, just check and
+	 * free throtl data.
+	 */
+	if (!q->td)
 		return;
 
 	timer_delete_sync(&q->td->service_queue.pending_timer);
 	throtl_shutdown_wq(q);
-	blkcg_deactivate_policy(disk, &blkcg_policy_throtl);
 	kfree(q->td);
 }
 
-- 
2.39.2


