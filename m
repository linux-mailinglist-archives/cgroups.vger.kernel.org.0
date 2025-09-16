Return-Path: <cgroups+bounces-10130-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC51EB58AF2
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 03:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717112A853A
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 01:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52F41A9FA1;
	Tue, 16 Sep 2025 01:19:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5670808;
	Tue, 16 Sep 2025 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985581; cv=none; b=FK91xyo290OWjXJarP4L1cCFkCmmYGKHUpbXyCm7CVSld2C3xjLjZ6bqdlmo/uMGkpN7bvTuI51mr1JSx4iHzHRgafnPv7SAp/K1ESWkf16lMywC2hlASOIWvpoQkTDHxIjIOJQUqF3P4rZ+OlyU8ugLXoLRJK8/ICPrAmxK77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985581; c=relaxed/simple;
	bh=U8IR5UvODudAhu7jZXRZ8Pcm3iD0tyERJBfX+nm8YNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S/YqL6EN6cOB0CfaiZiLtBO9+Dd6lplqZpeOppTr2BrGF+VkT28oTunCyWhBPNlD9HPy4DUcAhuRcB1uxWK6eHFbLwCXoav2PyEGd+ExRHHZUX2mO3De7x/Twrs86QVuA/AbQKXmmHFxXe2NinDSCk8IWwhFYeP5ujqC4QG9Lrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cQkZv5sqZzKHLxP;
	Tue, 16 Sep 2025 09:19:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6ECFA1A0D19;
	Tue, 16 Sep 2025 09:19:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDXIY4ku8hoMgGcCg--.12643S4;
	Tue, 16 Sep 2025 09:19:34 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	liangjie@lixiang.com,
	yukuai3@huawei.com,
	hanguangjiang@lixiang.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH] blk-throttle: fix throtl_data leak during disk release
Date: Tue, 16 Sep 2025 09:09:47 +0800
Message-Id: <20250916010947.2891471-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXIY4ku8hoMgGcCg--.12643S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1xZrWrKr4rCFy5AFyxXwb_yoW8XF15pF
	W5Zw4UKry5CFnrWayUtr13uFW0ka97JryrJ3s0yr4SkrW2kw18twnFvw1UCF4kAFs2yF4f
	Zr1rtry0yF1qkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Tightening the throttle activation check in blk_throtl_activated() to
require both q->td presence and policy bit set introduced a memory leak
during disk release:

blkg_destroy_all() clears the policy bit first during queue deactivation,
causing subsequent blk_throtl_exit() to skip throtl_data cleanup when
blk_throtl_activated() fails policy check.

Fix by reordering operations in disk_release() to call blk_throtl_exit()
while throttle policy is still active. We avoid modifying blk_throtl_exit()
activation check because it's intuitive that blk-throtl start from
blk_throtl_init() and end in blk_throtl_exit().

Fixes: bd9fd5be6bc0 ("blk-throttle: fix access race during throttle policy activation")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs-p-ZwBEKigBj7T6hQCOo-H68-kVwCrV6ZvRovrr9Z+HA@mail.gmail.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 7246fc256315..64a56c8697f9 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1539,8 +1539,8 @@ int blkcg_init_disk(struct gendisk *disk)
 
 void blkcg_exit_disk(struct gendisk *disk)
 {
-	blkg_destroy_all(disk);
 	blk_throtl_exit(disk);
+	blkg_destroy_all(disk);
 }
 
 static void blkcg_exit(struct task_struct *tsk)
-- 
2.39.2


