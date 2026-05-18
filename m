Return-Path: <cgroups+bounces-16025-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g1G5M/5nCmoj1AQAu9opvQ
	(envelope-from <cgroups+bounces-16025-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 03:14:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F6F564B4A
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 03:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CABD8300231A
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 01:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AC92147F9;
	Mon, 18 May 2026 01:14:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCB01FECBA;
	Mon, 18 May 2026 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779066876; cv=none; b=sPvijy9EuSfk5Kwzv00bMBKKrwdrihJlICgji6IWSWRfmJhmp4+jnU41yBUcgLmfVYZ+5jub0DELcjyiiYyXTthTKkBlEllBhw2RJJBRYq0VVPiKLUbleE5w++EK7OB6q+G7zLYChzt6Ljljp+Tp4Otz5c8knqIAJDBi/tJLl+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779066876; c=relaxed/simple;
	bh=k+8nZs+E882US7hblQn4br6HhSehbAQcgwObve8Uggk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbAwJbLAGJWihB0rOI0silB90Au3A/o2439kQOC9OG1Kx60xYgvh9WvtXM+RnstbqX95Yd0Z26Do+UUk1saluNJhyU4xfnUH0m5mNjXLIBWLstJhhCoXbESjeMJv9RQcavGySIFafjwpYXGRh6NvIjL4l8YHcuSxPw+50P4qx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gJfv60rC0zKHMtq;
	Mon, 18 May 2026 09:13:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6647F40574;
	Mon, 18 May 2026 09:14:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgCXX1vtZwpq_HnICg--.8878S4;
	Mon, 18 May 2026 09:14:23 +0800 (CST)
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
Subject: [PATCH] blk-cgroup: defer blkcg css_put until blkg is unlinked from queue
Date: Mon, 18 May 2026 09:09:32 +0800
Message-ID: <20260518010932.633707-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXX1vtZwpq_HnICg--.8878S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1kZF4kXF1fKr15Jw4xWFg_yoW5Ar18pF
	ZxGrWSy3srKryIvan8WF17X34F9a1rKF15GrZ5Gw4Ykr45Zrn2qF1UArWkXFWY9FZ7Ar4Y
	yrW0qrZrtF4UCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/
X-Rspamd-Queue-Id: 70F6F564B4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16025-lists,cgroups=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wozizhi@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Action: no action

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

Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 block/blk-cgroup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 554c87bb4a86..7b7677d022d0 100644
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
-- 
2.52.0


