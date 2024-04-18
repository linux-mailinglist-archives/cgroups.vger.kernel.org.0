Return-Path: <cgroups+bounces-2578-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9408A940B
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 09:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D415B22437
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 07:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A3A57334;
	Thu, 18 Apr 2024 07:32:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33894EB45;
	Thu, 18 Apr 2024 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425557; cv=none; b=RDZowdvyT5tQ+r72HtqpbWoysihIxuynTU1Dg4/M10bCrbIy7do5vgG/4Zj24GMHwUwMkvATDbcO+DblC5XvTchYsydJ1Ss+KN705ZvXOPudXXid51qSnvxnXhe7AhutQoDSrZZyfm+cFjzme56gf362LwMeedNyV4Iu7FHLI/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425557; c=relaxed/simple;
	bh=h7PVw/s5YkA2E6D/+aBzDZKszhArG5Oeh3JVPlHIBSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r3XEftZ7kDOOl90od4ifQE5nUYYmY4gcHUbNysmZUYwNMTxFnIFNSSGAK6wAfzyCNHxEakiFQDwwnpD4u1jwW+Z4KM9pIANLDg1oAC38/VTqgTqCoiv6q2qrwg5e65WdfKTpsHI83VoC6TpoEY0izMCdjXztV55+q1V9WxC8LiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VKqHD6cJ3z4f3kFb;
	Thu, 18 Apr 2024 15:32:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 27D831A0175;
	Thu, 18 Apr 2024 15:32:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxCOzCBmBygqKQ--.12535S4;
	Thu, 18 Apr 2024 15:32:31 +0800 (CST)
From: linan666@huaweicloud.com
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: hch@lst.de,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] blk-iocost: do not WARNING if iocg has already offlined
Date: Thu, 18 Apr 2024 15:23:40 +0800
Message-Id: <20240418072340.2090877-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxCOzCBmBygqKQ--.12535S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WryxtrW3tryUXFWxJr4rGrg_yoW8WFWDpF
	4agwnFkF1jqr13KF4kK3Z2q348uan5Wws3Jw4fWrZ8Za4fur1xX3Z7Zr4YyFySqrn5AFs3
	ZF48G3y7Aa1UWaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBSoJUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

In iocg_pay_debt(), warn is triggered if 'active_list' is empty, which
is intended to confirm iocg is avitve when it has debt. However, warn
can be triggered during removing cgroup controller, as
iocg_waitq_timer_fn() is awakened at that time.

  WARNING: CPU: 0 PID: 2344971 at block/blk-iocost.c:1402 iocg_pay_debt+0x14c/0x190
  Call trace:
  iocg_pay_debt+0x14c/0x190
  iocg_kick_waitq+0x438/0x4c0
  iocg_waitq_timer_fn+0xd8/0x130
  __run_hrtimer+0x144/0x45c
  __hrtimer_run_queues+0x16c/0x244
  hrtimer_interrupt+0x2cc/0x7b0

The warn in this situation is meaningless. Since this iocg is being
removed, the state of the 'active_list' is irrelevant, and 'waitq_timer'
is canceled after removing 'active_list' in ioc_pd_free(), which ensure
iocg is freed after iocg_waitq_timer_fn() returns.

Therefore, add the check if iocg has already offlined to avoid warn
when removing cgroup controller.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index baa20c85799d..2e109c016a39 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1440,7 +1440,7 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
 	lockdep_assert_held(&iocg->waitq.lock);
 
 	/* make sure that nobody messed with @iocg */
-	WARN_ON_ONCE(list_empty(&iocg->active_list));
+	WARN_ON_ONCE(list_empty(&iocg->active_list) && iocg->pd.online);
 	WARN_ON_ONCE(iocg->inuse > 1);
 
 	iocg->abs_vdebt -= min(abs_vpay, iocg->abs_vdebt);
-- 
2.39.2


