Return-Path: <cgroups+bounces-15959-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EtEIdG8BmqMnQIAu9opvQ
	(envelope-from <cgroups+bounces-15959-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 08:27:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B706549FC7
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 08:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53C5A3027F44
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 06:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEFA37CD5F;
	Fri, 15 May 2026 06:20:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C66C34846A;
	Fri, 15 May 2026 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778826016; cv=none; b=OS3sd4juuQIAOUpd6DQw7osKSMZm7sW9ARvfG9X252ayZgDLzJ7S340Mq+u3TeQDGrU03sQGOIdpyxu7tVEMtcWsEaaV9d6xMrI+awDOEQHXUr0w6XgWbVXXXQUJBV2N9V5pZbxXXQMGK+nmLw+0YjMPGmTNbNqbgCL5PtPj7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778826016; c=relaxed/simple;
	bh=3yPrfoANyQmKeJuhJDp9wwM8WcOIh7n+6swmluYjRIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucWL/QhmKfBTe0IpG72T7K3oaBvE74OAF+BqJ9FDjn8gqIBm8mhvluXadhWuXBVPeJpvjpRlZIvn8yt1TmjSFvuyCVm5vcGyhY87tnu7Ovd+CWbnQXylvdtK15Rd52B34uYpiWMKuUeyUqH86ZqHQL1jJgEDIcDWcJsuaNOAU0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gGxqZ32fnzYQtp3;
	Fri, 15 May 2026 14:19:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D064540593;
	Fri, 15 May 2026 14:19:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHz1oMuwZqGVhxCQ--.2903S4;
	Fri, 15 May 2026 14:19:57 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	yukuai@fnnas.com,
	linux-block@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huaweicloud.com
Subject: [PATCH] blk-cgroup: Fix UAF in blkcg_activate_policy() by using blkg_tryget()
Date: Fri, 15 May 2026 14:15:16 +0800
Message-ID: <20260515061516.3461291-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHz1oMuwZqGVhxCQ--.2903S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1fZw18XFy7Gw45GFy3Arb_yoW5AF4xpF
	Z8GrZayrykXryq9an09a47X34Fga10gr4rtFWxGrZIkF43Zw13XF1DCrWDurZ7uFsrArs0
	yF45J3yjkF48Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUU
	UU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/
X-Rspamd-Queue-Id: 5B706549FC7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-15959-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_NA(0.00)[huaweicloud.com];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wozizhi@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.976];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,huaweicloud.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

[BUG]
Our fuzz testing triggered a blkg use-after-free issue:

  BUG: KASAN: slab-use-after-free in percpu_ref_put_many.constprop.0+0xbe/0xe0
  Call Trace:
  ...
  blkcg_activate_policy+0x347/0xfa0
  bfq_create_group_hierarchy+0x5b/0x140
  bfq_init_queue+0xc1b/0x1470
  ? mutex_init_generic+0x9f/0x100
  ? elevator_alloc+0x166/0x2b0
  blk_mq_init_sched+0x2b0/0x730
  elevator_switch+0x188/0x450
  elevator_change+0x290/0x470
  elv_iosched_store+0x30a/0x3a0
  ...

[CAUSE]
process1						process2
cgroup_rmdir
...
  blkcg_destroy_blkgs
    spin_trylock(&q->queue_lock)
    blkg_destroy
      percpu_ref_kill(&blkg->refcnt)
      ...
        blkg_free
	  INIT_WORK(xxx, blkg_free_workfn)
	  schedule_work
    spin_unlock(&q->queue_lock)
====================================schedule_work
            blkg_free_workfn
							elevator_change
							...
							  bfq_create_group_hierarchy
							    blkcg_activate_policy
							      spin_lock_irq(&q->queue_lock)
							      blkg_get		// get dead ref !!
							      pinned_blkg = blkg
							      spin_unlock_irq(&q->queue_lock)
	      spin_lock_irq(&q->queue_lock)
	      list_del_init(&blkg->q_node)
	      spin_unlock_irq(&q->queue_lock)
	      kfree(blkg)
							      blkg_put(pinned_blkg)	// UAF !!

A blkg killed by blkg_destroy() stays on q->blkg_list until
blkg_free_workfn() grabs queue_lock and unlinks it. blkg_get() on a dead
percpu_ref does not resurrect the blkg, so the later blkg_put() hits freed
memory and triggers this issue.

[Fix]
Replace blkg_get() with blkg_tryget(), which fails on a dead ref and lets
the loop skip dying blkgs.

Also hoist the ref acquisition to the top of the loop so dying blkgs are
filtered out before a pd is allocated and attached. Otherwise a pd attached
to an already-destroyed blkg would never called pd_offline_fn().

Fixes: 9d179b865449 ("blkcg: Fix multiple bugs in blkcg_activate_policy()")
Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
---
 block/blk-cgroup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 554c87bb4a86..03b6ce934848 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1621,6 +1621,10 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 		if (blkg->pd[pol->plid])
 			continue;
 
+		/* a destroyed blkg may still be on q->blkg_list; skip it via tryget */
+		if (!blkg_tryget(blkg))
+			continue;
+
 		/* If prealloc matches, use it; otherwise try GFP_NOWAIT */
 		if (blkg == pinned_blkg) {
 			pd = pd_prealloc;
@@ -1637,7 +1641,6 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 			 */
 			if (pinned_blkg)
 				blkg_put(pinned_blkg);
-			blkg_get(blkg);
 			pinned_blkg = blkg;
 
 			spin_unlock_irq(&q->queue_lock);
@@ -1666,6 +1669,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 		pd->online = true;
 
 		spin_unlock(&blkg->blkcg->lock);
+
+		blkg_put(blkg);
 	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
-- 
2.52.0


