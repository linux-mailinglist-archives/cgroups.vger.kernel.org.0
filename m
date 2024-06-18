Return-Path: <cgroups+bounces-3223-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDBE90C27A
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 05:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13963285131
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 03:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C72619D06C;
	Tue, 18 Jun 2024 03:28:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C07119CD1F;
	Tue, 18 Jun 2024 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718681330; cv=none; b=D8HpJ4T4G459Wq9wequ4ODGDc3c9sxmeFcErzXm0ZDY/0QGEaJQcHp2DaxER4g2kpsvXu37ixY0i6v6w3BY/CR6eXriWvb/J86P5qJoCko5wrphe6K5cETYF2m53bQyuWNYfiGXJQ+Pvmxt1Jyzd4PcxaV+BQy4hxDVkeaa2/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718681330; c=relaxed/simple;
	bh=E6v+KD9p8R6kimPj3jrgbH1H5pXJ3EeJibShbrpzaq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N35l9x6F0ct8AwoivnYwCyE6uSOEDGJkgeW/sbxzO43eMMS+AfuvXizSBNusXyDCHmehDDhEw8HvpJK5LGQGzj1QD8oPQv65k66OJABzrehR2+aFF0vLKJn/McdGFPk4d/riz2+V9JV9nJ5YyszH/dHsWN9neS2qxuBie3zrc/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W3Bzj3VfFz4f3jHh;
	Tue, 18 Jun 2024 11:28:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CCB951A0181;
	Tue, 18 Jun 2024 11:28:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgC3agjm_nBmV0P9AA--.2852S4;
	Tue, 18 Jun 2024 11:28:43 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	paolo.valente@unimore.it,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next] block, bfq: remove blkg_path()
Date: Tue, 18 Jun 2024 11:27:53 +0800
Message-Id: <20240618032753.3502528-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3agjm_nBmV0P9AA--.2852S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyDZF13JFW3uw1fCF1DGFg_yoWrur1Dpa
	sIgr17G3s8KF1Iqw10g340qryrAa1rZryUK3yjgrWFkryavrn2vF1Yyws5XFySvF9ayr42
	vr1Y934UC3WqkFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUva14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
	uYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

After commit 35fe6d763229 ("block: use standard blktrace API to output
cgroup info for debug notes"), the field 'bfqg->blkg_path' is not used
and hence can be removed, and therefor blkg_path() is not used anymore
and can be removed.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  | 51 ---------------------------------------------
 block/bfq-iosched.h |  3 ---
 block/blk-cgroup.h  | 13 ------------
 3 files changed, 67 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index d442ee358fc2..b758693697c0 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -797,57 +797,6 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
 	 */
 	bfq_link_bfqg(bfqd, bfqg);
 	__bfq_bic_change_cgroup(bfqd, bic, bfqg);
-	/*
-	 * Update blkg_path for bfq_log_* functions. We cache this
-	 * path, and update it here, for the following
-	 * reasons. Operations on blkg objects in blk-cgroup are
-	 * protected with the request_queue lock, and not with the
-	 * lock that protects the instances of this scheduler
-	 * (bfqd->lock). This exposes BFQ to the following sort of
-	 * race.
-	 *
-	 * The blkg_lookup performed in bfq_get_queue, protected
-	 * through rcu, may happen to return the address of a copy of
-	 * the original blkg. If this is the case, then the
-	 * bfqg_and_blkg_get performed in bfq_get_queue, to pin down
-	 * the blkg, is useless: it does not prevent blk-cgroup code
-	 * from destroying both the original blkg and all objects
-	 * directly or indirectly referred by the copy of the
-	 * blkg.
-	 *
-	 * On the bright side, destroy operations on a blkg invoke, as
-	 * a first step, hooks of the scheduler associated with the
-	 * blkg. And these hooks are executed with bfqd->lock held for
-	 * BFQ. As a consequence, for any blkg associated with the
-	 * request queue this instance of the scheduler is attached
-	 * to, we are guaranteed that such a blkg is not destroyed, and
-	 * that all the pointers it contains are consistent, while we
-	 * are holding bfqd->lock. A blkg_lookup performed with
-	 * bfqd->lock held then returns a fully consistent blkg, which
-	 * remains consistent until this lock is held.
-	 *
-	 * Thanks to the last fact, and to the fact that: (1) bfqg has
-	 * been obtained through a blkg_lookup in the above
-	 * assignment, and (2) bfqd->lock is being held, here we can
-	 * safely use the policy data for the involved blkg (i.e., the
-	 * field bfqg->pd) to get to the blkg associated with bfqg,
-	 * and then we can safely use any field of blkg. After we
-	 * release bfqd->lock, even just getting blkg through this
-	 * bfqg may cause dangling references to be traversed, as
-	 * bfqg->pd may not exist any more.
-	 *
-	 * In view of the above facts, here we cache, in the bfqg, any
-	 * blkg data we may need for this bic, and for its associated
-	 * bfq_queue. As of now, we need to cache only the path of the
-	 * blkg, which is used in the bfq_log_* functions.
-	 *
-	 * Finally, note that bfqg itself needs to be protected from
-	 * destruction on the blkg_free of the original blkg (which
-	 * invokes bfq_pd_free). We use an additional private
-	 * refcounter for bfqg, to let it disappear only after no
-	 * bfq_queue refers to it any longer.
-	 */
-	blkg_path(bfqg_to_blkg(bfqg), bfqg->blkg_path, sizeof(bfqg->blkg_path));
 	bic->blkcg_serial_nr = serial_nr;
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 467e8cfc41a2..08ddf2cfae5b 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1003,9 +1003,6 @@ struct bfq_group {
 	/* must be the first member */
 	struct blkg_policy_data pd;
 
-	/* cached path for this blkg (see comments in bfq_bic_update_cgroup) */
-	char blkg_path[128];
-
 	/* reference counter (see comments in bfq_bic_update_cgroup) */
 	refcount_t ref;
 
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 25833221a12b..6dcaf63c560a 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -301,19 +301,6 @@ static inline struct blkcg *cpd_to_blkcg(struct blkcg_policy_data *cpd)
 	return cpd ? cpd->blkcg : NULL;
 }
 
-/**
- * blkg_path - format cgroup path of blkg
- * @blkg: blkg of interest
- * @buf: target buffer
- * @buflen: target buffer length
- *
- * Format the path of the cgroup of @blkg into @buf.
- */
-static inline int blkg_path(struct blkcg_gq *blkg, char *buf, int buflen)
-{
-	return cgroup_path(blkg->blkcg->css.cgroup, buf, buflen);
-}
-
 /**
  * blkg_get - get a blkg reference
  * @blkg: blkg to get
-- 
2.39.2


