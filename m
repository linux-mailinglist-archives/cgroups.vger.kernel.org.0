Return-Path: <cgroups+bounces-8580-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7CCADE4BE
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 09:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0677418988A3
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E695C1EF092;
	Wed, 18 Jun 2025 07:45:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C51E27726;
	Wed, 18 Jun 2025 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750232747; cv=none; b=n4bP3Vq+ywgI6L4kpIEZNA3mRnEtW1SpiO/aK5W5ICTAVflfS7cU6zK+tngKT4yAj/TZKZ1ESGTiee4wpFuuKVv1HxCbDhPD0Q4N5e2Im/sqKkBEtCTssEn4sAu6RBqp5/x7B20sVfUsQEZn02Y+kWUP0jB1KsKILsoMmlU5sdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750232747; c=relaxed/simple;
	bh=s3stRVI86PiNtFalnZP+84R5foygh190H1muvOIo1pI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B2nbXlQH7qziWsMl/xD2XPIFaP0x2N4Sf+a8w8qgvsJF5AEuu9EikheFCpxkYzghku4kGzsI6kjDMYUu+SIAkOKasQag0ArPLV3FUOME0LK0IIezsK+XxLQwrDfkK/JLOFWZToZdb5XO1cRo/Vi3Hp6tA+yZDctSi9az30DGHQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bMbPy0hmxzYQvtL;
	Wed, 18 Jun 2025 15:45:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 100501A093A;
	Wed, 18 Jun 2025 15:45:41 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCXoWSTblJo+pwEPw--.55813S2;
	Wed, 18 Jun 2025 15:45:40 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	rafael.j.wysocki@intel.com,
	mingo@kernel.org,
	peterz@infradead.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [next] cgroup,freezer: fix incomplete freezing when attaching tasks
Date: Wed, 18 Jun 2025 07:32:17 +0000
Message-Id: <20250618073217.2983275-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXoWSTblJo+pwEPw--.55813S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJryUCFyrAry3AF17Gw1xZrb_yoW8Wryxpw
	s8Xw4UWw4FkF1jyryDZ3W0gr95KFs7Ar4UGFyjqr18XF1fXa4qvr4xC345WayUJFWIqrWU
	Ja1YvryIk34DA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

An issue was found:

	# cd /sys/fs/cgroup/freezer/
	# mkdir test
	# echo FROZEN > test/freezer.state
	# cat test/freezer.state
	FROZEN
	# sleep 1000 &
	[1] 863
	# echo 863 > test/cgroup.procs
	# cat test/freezer.state
	FREEZING

When tasks are migrated to a frozen cgroup, the freezer fails to
immediately freeze the tasks, causing the cgroup to remain in the
"FREEZING".

The freeze_task() function is called before clearing the CGROUP_FROZEN
flag. This causes the freezing() check to incorrectly return false,
preventing __freeze_task() from being invoked for the migrated task.

To fix this issue, clear the CGROUP_FROZEN state before calling
freeze_task().

Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
Reported-by: Zhong Jiawei <zhongjiawei1@huawei.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/legacy_freezer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 039d1eb2f215..507b8f19a262 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -188,13 +188,12 @@ static void freezer_attach(struct cgroup_taskset *tset)
 		if (!(freezer->state & CGROUP_FREEZING)) {
 			__thaw_task(task);
 		} else {
-			freeze_task(task);
-
 			/* clear FROZEN and propagate upwards */
 			while (freezer && (freezer->state & CGROUP_FROZEN)) {
 				freezer->state &= ~CGROUP_FROZEN;
 				freezer = parent_freezer(freezer);
 			}
+			freeze_task(task);
 		}
 	}
 
-- 
2.34.1


