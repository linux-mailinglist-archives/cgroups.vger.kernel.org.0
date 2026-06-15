Return-Path: <cgroups+bounces-16967-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XJ4kJEDtL2qsJAUAu9opvQ
	(envelope-from <cgroups+bounces-16967-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 14:17:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDBE686170
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 14:17:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16967-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16967-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0068B3020EC7
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3F03E4C6E;
	Mon, 15 Jun 2026 12:02:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060537DEA8;
	Mon, 15 Jun 2026 12:02:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524955; cv=none; b=eFCu9I0PXZ043O+LEsXTwWQKKTUoBrgqWgiUhbto/KdfzPKNXi+Zsrk5sbNLKX9/+aw8WYku4O29QmX879zYI8AZUlCuOB47C5oZ4eKqx8BvavvLfVtwIeoIrR3atBPrB2t/ipLND3JVL4sBFNQQGZ81bB1aMLy+b4ROCbG0jp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524955; c=relaxed/simple;
	bh=hDXEzZqbtAzr/uSpgHSfGFAWMMKzIXHwxmJ+XLj8vr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DaqEDKLJS8yLxKVjCfWAGxDbpGv91cZmO/VuebiKlSXSveBZTfXIXR6MenoNQ+pzyFUNlN66XxsQe4PpqV0V2/0w6PkOZ6/cWL2/1Xql0EbxxgU8OW4jZsrGoNxgmJejLfJexHVUVQAm/jlLE0HhfsQxk9Zvu8eO22s71ZOG28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gf7yG35D8zKHMRX;
	Mon, 15 Jun 2026 20:01:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8601F4058D;
	Mon, 15 Jun 2026 20:02:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with SMTP id cCh0CgA3hzzQ6S9qu2+JBw--.21839S4;
	Mon, 15 Jun 2026 20:02:25 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	yukuai@fnnas.com,
	houtao1@huawei.com,
	wozizhi@huaweicloud.com
Subject: [PATCH V2] blk-cgroup: defer blkcg css_put until blkg is unlinked from queue
Date: Mon, 15 Jun 2026 19:55:56 +0800
Message-ID: <20260615115556.1225472-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3hzzQ6S9qu2+JBw--.21839S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWfAr4DJF47Ww1fKFWrGrg_yoW7CFyDpF
	ZxWrZay3yxKry2qa15Xr17X34Fvw48tr1rGrW8Gw4Y9F4ayr92qF1UurWkZFWxZFZ7Ar43
	Ar4vqF1qyF48CwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:mid,huaweicloud.com:from_mime];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16967-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:yangerkun@huawei.com,m:chengzhihao1@huawei.com,m:yukuai@fnnas.com,m:houtao1@huawei.com,m:wozizhi@huaweicloud.com,s:lists@lfdr.de];
	GREYLIST(0.00)[pass,body];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[wozizhi@huaweicloud.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wozizhi@huaweicloud.com,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email,vger.kernel.org:from_smtp,huaweicloud.com:mid,huaweicloud.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBDBE686170

From: Zizhi Wo <wozizhi@huawei.com>

[BUG]
Our fuzz testing triggered a blkcg use-after-free issue:

  BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x75/0xe0
  Call Trace:
  ...
  blkcg_deactivate_policy+0x244/0x4d0
  ioc_rqos_exit+0x44/0xe0
  rq_qos_exit+0xba/0x120
  __del_gendisk+0x50b/0x800
  del_gendisk+0xff/0x190
  ...

[CAUSE]
process1						process2
cgroup_rmdir
...
  css_killed_work_fn
    offline_css
    ...
      blkcg_destroy_blkgs
      ...
        __blkg_release
	  css_put(&blkg->blkcg->css)
          blkg_free
	    INIT_WORK(xxx, blkg_free_workfn)
	    schedule_work
    css_put
    ...
      blkcg_css_free
        kfree(blkcg)--------blkcg has been freed!!!
====================================schedule_work
              blkg_free_workfn
							__del_gendisk
							  rq_qos_exit
							    ioc_rqos_exit
							      blkcg_deactivate_policy
							        mutex_lock(&q->blkcg_mutex)
								spin_lock_irq(&q->queue_lock)
							        list_for_each_entry(blkg, xxx)
								  blkcg = blkg->blkcg
								  spin_lock(&blkcg->lock)-------UAF!!!
	        mutex_lock(&q->blkcg_mutex)
	        spin_lock_irq(&q->queue_lock)
	        /* Only then is the blkg removed from the list */
	        list_del_init(&blkg->q_node)

As a result, a blkg can still be reachable through q->blkg_list while
its ->blkcg has already been freed.

[Fix]
Fix this by deferring the blkcg css_put() until after the blkg has been
unlinked from q->blkg_list in blkg_free_workfn(). This ensures that the
blkcg outlives every blkg still reachable through q->blkg_list, so any
iterator holding q->queue_lock is guaranteed to observe a valid
blkg->blkcg.

While at it, move css_tryget_online() from blkg_create() into blkg_alloc()
so that the css reference is owned by the alloc/free pair rather than
straddling layers:
blkg_alloc()  <-> blkg_free()
blkg_create() <-> blkg_destroy()

Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
v2:
 - Move css_tryget_online() from blkg_create() into blkg_alloc() so the
   css reference follows the blkg's own lifetime, making the put in
   blkg_free_workfn() symmetric with the get in blkg_alloc().

v1: https://lore.kernel.org/all/20260518010932.633707-1-wozizhi@huaweicloud.com/

 block/blk-cgroup.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bc63bd220865..27414c291e49 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -132,10 +132,15 @@ static void blkg_free_workfn(struct work_struct *work)
 	if (blkg->parent)
 		blkg_put(blkg->parent);
 	spin_lock_irq(&q->queue_lock);
 	list_del_init(&blkg->q_node);
 	spin_unlock_irq(&q->queue_lock);
+	/*
+	 * Release blkcg css ref only after blkg is removed from q->blkg_list,
+	 * so concurrent iterators won't see a blkg with a freed blkcg.
+	 */
+	css_put(&blkg->blkcg->css);
 	mutex_unlock(&q->blkcg_mutex);
 
 	blk_put_queue(q);
 	free_percpu(blkg->iostat_cpu);
 	percpu_ref_exit(&blkg->refcnt);
@@ -177,12 +182,10 @@ static void __blkg_release(struct rcu_head *rcu)
 	 * blkg_stat_lock is for serializing blkg stat update
 	 */
 	for_each_possible_cpu(cpu)
 		__blkcg_rstat_flush(blkcg, cpu);
 
-	/* release the blkcg and parent blkg refs this blkg has been holding */
-	css_put(&blkg->blkcg->css);
 	blkg_free(blkg);
 }
 
 /*
  * A group is RCU protected, but having an rcu lock does not mean that one
@@ -311,10 +314,13 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	blkg->iostat_cpu = alloc_percpu_gfp(struct blkg_iostat_set, gfp_mask);
 	if (!blkg->iostat_cpu)
 		goto out_exit_refcnt;
 	if (!blk_get_queue(disk->queue))
 		goto out_free_iostat;
+	/* blkg holds a reference to blkcg */
+	if (!css_tryget_online(&blkcg->css))
+		goto out_put_queue;
 
 	blkg->q = disk->queue;
 	INIT_LIST_HEAD(&blkg->q_node);
 	blkg->blkcg = blkcg;
 	blkg->iostat.blkg = blkg;
@@ -351,10 +357,12 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 
 out_free_pds:
 	while (--i >= 0)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
+	css_put(&blkcg->css);
+out_put_queue:
 	blk_put_queue(disk->queue);
 out_free_iostat:
 	free_percpu(blkg->iostat_cpu);
 out_exit_refcnt:
 	percpu_ref_exit(&blkg->refcnt);
@@ -379,32 +387,26 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 	if (blk_queue_dying(disk->queue)) {
 		ret = -ENODEV;
 		goto err_free_blkg;
 	}
 
-	/* blkg holds a reference to blkcg */
-	if (!css_tryget_online(&blkcg->css)) {
-		ret = -ENODEV;
-		goto err_free_blkg;
-	}
-
 	/* allocate */
 	if (!new_blkg) {
 		new_blkg = blkg_alloc(blkcg, disk, GFP_NOWAIT);
 		if (unlikely(!new_blkg)) {
 			ret = -ENOMEM;
-			goto err_put_css;
+			goto err_free_blkg;
 		}
 	}
 	blkg = new_blkg;
 
 	/* link parent */
 	if (blkcg_parent(blkcg)) {
 		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk->queue);
 		if (WARN_ON_ONCE(!blkg->parent)) {
 			ret = -ENODEV;
-			goto err_put_css;
+			goto err_free_blkg;
 		}
 		blkg_get(blkg->parent);
 	}
 
 	/* invoke per-policy init */
@@ -440,12 +442,10 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 
 	/* @blkg failed fully initialized, use the usual release path */
 	blkg_put(blkg);
 	return ERR_PTR(ret);
 
-err_put_css:
-	css_put(&blkcg->css);
 err_free_blkg:
 	if (new_blkg)
 		blkg_free(new_blkg);
 	return ERR_PTR(ret);
 }
-- 
2.52.0


