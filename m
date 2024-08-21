Return-Path: <cgroups+bounces-4400-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E48795929E
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 04:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BCBB22D07
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 02:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CF074040;
	Wed, 21 Aug 2024 02:12:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753A41E504;
	Wed, 21 Aug 2024 02:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724206359; cv=none; b=qBcAXAjmTYaGNViFGjbL5tM4G2pL+lWWPaUZZDCRkYTaCcdmIgPac/VzYomPI4Xm+E1JIu3fj+cAzV6jJZoNo55UfYyilhqUcG5uiKx4HQKV+xhYL7/NeQ3WocVI/VbMHsEUn38xEtMV+biOcSs6ST3fy5Odi46qOa2c+0X8TGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724206359; c=relaxed/simple;
	bh=MjpTp1ZODTdGKNSpjCNCTSun6lOzgM7szJ2wdA4i85s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NwQmoA3W3kTNBjjM1GCQp+2IKkict2kV2acf9ytIUOLf5NNFywZeN3q/pt+FdpI6feb9dVpDZ8JJLe9N0klHJfCTuKpinsMz940/YCF8TnC03YJ+U62Nw8SsZI8A3Jevi12Pz/3mL34tpmecdpx1fPj5QLDTxuIAfdUmfWD6qw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WpVGC05dJz4f3jMX;
	Wed, 21 Aug 2024 10:12:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2B2F11A198F;
	Wed, 21 Aug 2024 10:12:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UPTcVmjacWCQ--.62842S4;
	Wed, 21 Aug 2024 10:12:32 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	hch@lst.de,
	axboe@kernel.dk,
	longman@redhat.com,
	ming.lei@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH v2] blk-cgroup: don't clear stat in blkcg_reset_stats()
Date: Wed, 21 Aug 2024 10:07:56 +0800
Message-Id: <20240821020756.786000-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4UPTcVmjacWCQ--.62842S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWxZr4DGr17try7uF17KFg_yoW5JFW7pr
	WYkwnIk3yDKF4kZF1Ygay2qryF9w4vyry5JrWDW3yrKF1jyrySvF1qy395AFW5CFyIvr45
	Xr4YvrWDGw4jk3JanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiNtx3UU
	UUU==
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

The list corruption described in commit 6da668063279 ("blk-cgroup: fix
list corruption from resetting io stat") has no effect. It's unnecessary
to fix it.

As for cgroup v1, it does not use iostat any more after commit
ad7c3b41e86b("blk-throttle: Fix io statistics for cgroup v1"), so using
memset to clear iostat has no real effect.
As for cgroup v2, it will not call blkcg_reset_stats() to corrupt the
list.

The list of root cgroup can be used by both cgroup v1 and v2 while
non-root cgroup can't since it must be removed before switch between
cgroup v1 and v2.
So it may has effect if the list of root used by cgroup v2 was corrupted
after switching to cgroup v1, and switch back to cgroup v2 to use the
corrupted list again.
However, the root cgroup will not use the list any more after commit
ef45fe470e1e("blk-cgroup: show global disk stats in root cgroup io.stat").

Although this has no negative effect, it is not necessary. Remove the
related code for cleanup. No function change.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
  v1->v2: remove the fix tag and mark this as cleanup.
 block/blk-cgroup.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 69e70964398c..6d091fa55b8c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -629,29 +629,6 @@ static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
 	}
 }
 
-static void __blkg_clear_stat(struct blkg_iostat_set *bis)
-{
-	struct blkg_iostat cur = {0};
-	unsigned long flags;
-
-	flags = u64_stats_update_begin_irqsave(&bis->sync);
-	blkg_iostat_set(&bis->cur, &cur);
-	blkg_iostat_set(&bis->last, &cur);
-	u64_stats_update_end_irqrestore(&bis->sync, flags);
-}
-
-static void blkg_clear_stat(struct blkcg_gq *blkg)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		struct blkg_iostat_set *s = per_cpu_ptr(blkg->iostat_cpu, cpu);
-
-		__blkg_clear_stat(s);
-	}
-	__blkg_clear_stat(&blkg->iostat);
-}
-
 static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 			     struct cftype *cftype, u64 val)
 {
@@ -668,7 +645,6 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	 * anyway.  If you get hit by a race, retry.
 	 */
 	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
-		blkg_clear_stat(blkg);
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
 
-- 
2.39.2


