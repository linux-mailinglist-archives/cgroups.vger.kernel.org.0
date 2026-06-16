Return-Path: <cgroups+bounces-16986-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4NoFLaunMGrYVwUAu9opvQ
	(envelope-from <cgroups+bounces-16986-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 03:32:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB968B46D
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 03:32:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16986-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16986-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 062C0301A153
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 01:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C755A2C2374;
	Tue, 16 Jun 2026 01:24:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A4430C142;
	Tue, 16 Jun 2026 01:24:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573065; cv=none; b=JOzuJ7tCEoMrBMdWnqr0Wpm7NWq8uhZL0serdTZnBtRoSWAPTrrdqJG7b/GemI7yR0nkQ8sgz6Rpm766pUpvwf92POoZvEuw/nXzgIaoqqJ/acnBB4NfTrz48nIctlF8tjt/yjSdmqJAWlh/3sMYfJk2kYAMSsEfDXWxp4jHjKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573065; c=relaxed/simple;
	bh=VBMxJNYKSgfy+l3N8H4JB7xrmZETlPO+f4u4NPGG6Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+TaFs7vSdm5gZjDzQ52iA/ck+HaTz50tbipnSec259ENvybU44f708fDXTKHxGeOmdSkGKVi8pUeD8Rdof57SLZoGshIQ6TnlAEcYBexPeyMHNljbKwSJ94S2tbzZppmm+rzWTYxGJBjzmelDj63v75efjfJ5eTJ5EJmZeDHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gfTlT41xJzKHMXB;
	Tue, 16 Jun 2026 09:23:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 915B74056F;
	Tue, 16 Jun 2026 09:24:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with SMTP id cCh0CgAXGj_ApTBq8HzMBw--.59587S4;
	Tue, 16 Jun 2026 09:24:17 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	houtao1@huawei.com,
	yukuai@fygo.io,
	wozizhi@huaweicloud.com
Subject: [PATCH V3] blk-cgroup: defer blkcg css_put until blkg is unlinked from queue
Date: Tue, 16 Jun 2026 09:17:46 +0800
Message-ID: <20260616011746.2451461-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXGj_ApTBq8HzMBw--.59587S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWfAr4DJF47Ww1fKFWrGrg_yoW7GFy5pF
	ZxGrZav397Kr9Fqan8Xr17X34Svw40qF1rGrWkGw4a9r4avr92qF1jkrWkZFWxZFZ7Ar13
	Ar40qF1DtF48CwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-16986-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:yangerkun@huawei.com,m:chengzhihao1@huawei.com,m:houtao1@huawei.com,m:yukuai@fygo.io,m:wozizhi@huaweicloud.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER(0.00)[wozizhi@huaweicloud.com,cgroups@vger.kernel.org];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wozizhi@huaweicloud.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huaweicloud.com:mid,huaweicloud.com:from_mime,fygo.io:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BAB968B46D

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
Reviewed-by: Yu Kuai <yukuai@fygo.io>
---
v3:
 - move css_put() after mutex_unlock() in blkg_free_workfn().

v2:
 - Move css_tryget_online() from blkg_create() into blkg_alloc() so the
   css reference follows the blkg's own lifetime, making the put in
   blkg_free_workfn() symmetric with the get in blkg_alloc().

v1: https://lore.kernel.org/all/20260518010932.633707-1-wozizhi@huaweicloud.com/
 block/blk-cgroup.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bc63bd220865..3ac41f766caf 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -136,6 +136,11 @@ static void blkg_free_workfn(struct work_struct *work)
 	spin_unlock_irq(&q->queue_lock);
 	mutex_unlock(&q->blkcg_mutex);
 
+	/*
+	 * Release blkcg css ref only after blkg is removed from q->blkg_list,
+	 * so concurrent iterators won't see a blkg with a freed blkcg.
+	 */
+	css_put(&blkg->blkcg->css);
 	blk_put_queue(q);
 	free_percpu(blkg->iostat_cpu);
 	percpu_ref_exit(&blkg->refcnt);
@@ -179,8 +184,6 @@ static void __blkg_release(struct rcu_head *rcu)
 	for_each_possible_cpu(cpu)
 		__blkcg_rstat_flush(blkcg, cpu);
 
-	/* release the blkcg and parent blkg refs this blkg has been holding */
-	css_put(&blkg->blkcg->css);
 	blkg_free(blkg);
 }
 
@@ -313,6 +316,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 		goto out_exit_refcnt;
 	if (!blk_get_queue(disk->queue))
 		goto out_free_iostat;
+	/* blkg holds a reference to blkcg */
+	if (!css_tryget_online(&blkcg->css))
+		goto out_put_queue;
 
 	blkg->q = disk->queue;
 	INIT_LIST_HEAD(&blkg->q_node);
@@ -353,6 +359,8 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	while (--i >= 0)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
+	css_put(&blkcg->css);
+out_put_queue:
 	blk_put_queue(disk->queue);
 out_free_iostat:
 	free_percpu(blkg->iostat_cpu);
@@ -381,18 +389,12 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
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
@@ -402,7 +404,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk->queue);
 		if (WARN_ON_ONCE(!blkg->parent)) {
 			ret = -ENODEV;
-			goto err_put_css;
+			goto err_free_blkg;
 		}
 		blkg_get(blkg->parent);
 	}
@@ -442,8 +444,6 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 	blkg_put(blkg);
 	return ERR_PTR(ret);
 
-err_put_css:
-	css_put(&blkcg->css);
 err_free_blkg:
 	if (new_blkg)
 		blkg_free(new_blkg);
-- 
2.52.0


