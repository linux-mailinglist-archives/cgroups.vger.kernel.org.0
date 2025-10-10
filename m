Return-Path: <cgroups+bounces-10632-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA76BCC451
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED98A4FB42F
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E933275B09;
	Fri, 10 Oct 2025 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHx+Wzhf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5462749EA;
	Fri, 10 Oct 2025 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087701; cv=none; b=duFjJKRGU3Kw9uInLR8WNU+Il7t36RSG/B8x+ux0DnlO/lXpospXx0+p4lgZlT3nM1EoL8g0YiQxQ9Xfg12A15Y+olmy6M9np9nWUdsbxvEFThU3036mAq7RwhInjnQujd2wM1dl/4RPQllYlRs6vGjXBe4H6B9p7Sbb0rusMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087701; c=relaxed/simple;
	bh=zxYNGcr/gnHPy/XjyyXryLP2IO0Ih75dPQi3DbjxTS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNrTPhiQZ+EGviLGOXGrqvavxiLGspIMkEHcvtieNjCkJYdGKhUGmJGpu97iMqxTWwpTeacRAwbPvaf0CKqJGnSgyNHr42Ep9b1+fOv+PQpdUrkBFMu7t10f5n7sW9gMlqccyyVxxspGU3PKY9rCwVxevelvw3YvNVX8s2NZYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHx+Wzhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EBFC113D0;
	Fri, 10 Oct 2025 09:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087700;
	bh=zxYNGcr/gnHPy/XjyyXryLP2IO0Ih75dPQi3DbjxTS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FHx+WzhfvwgIB/L6ZwCuYp/ZgVO6D8PCdJBtKCuBXjKbQv9OJ8mYr5datTGm/V3eJ
	 8gWxN/n/V2NHeuX+W3k5tykZXGfzPLZ3vpvJG8eLoxURf16tu0Dda4on8ibwJwp3cF
	 9c872FeKoObv1QVbOZ4mJmRFk0ISPP2Huu8en/gBacCoOCv+QM0EggB47v8pKEgPkB
	 u9d2hPCr9XWOz+nvc7igdYUZxiBlOXW5VRkMWAWNzp5X1bc8tUfy65ZrxDFNJKcXgg
	 /p4p7QhfAY9dM4UMOY+4nOZMMStRyQHdefbLOIt0+SKcO5lBZNYrD8yQuzwZskGMvk
	 putjHMwbpzTVw==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	tj@kernel.org,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v2 03/19] blk-cgroup: don't nest queue_lock under rcu in blkcg_print_blkgs()
Date: Fri, 10 Oct 2025 17:14:28 +0800
Message-ID: <20251010091446.3048529-4-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010091446.3048529-1-yukuai@kernel.org>
References: <20251010091446.3048529-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

With previous modification to delay freeing policy data after rcu grace
period, now it's safe to protect prfill() with rcu directly because
it's guaranteed policy_data won't be freed by concurrent deactivating
policy.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup-rwstat.c | 4 +---
 block/blk-cgroup.c        | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
index a55fb0c53558..b8ab8c0063a3 100644
--- a/block/blk-cgroup-rwstat.c
+++ b/block/blk-cgroup-rwstat.c
@@ -101,10 +101,9 @@ void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
 	struct cgroup_subsys_state *pos_css;
 	unsigned int i;
 
-	lockdep_assert_held(&blkg->q->queue_lock);
+	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	memset(sum, 0, sizeof(*sum));
-	rcu_read_lock();
 	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
 		struct blkg_rwstat *rwstat;
 
@@ -119,6 +118,5 @@ void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
 		for (i = 0; i < BLKG_RWSTAT_NR; i++)
 			sum->cnt[i] += blkg_rwstat_read_counter(rwstat, i);
 	}
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(blkg_rwstat_recursive_sum);
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0f6039d468a6..fb40262971c9 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -713,10 +713,8 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
-		spin_lock_irq(&blkg->q->queue_lock);
 		if (blkcg_policy_enabled(blkg->q, pol))
 			total += prfill(sf, blkg->pd[pol->plid], data);
-		spin_unlock_irq(&blkg->q->queue_lock);
 	}
 	rcu_read_unlock();
 
-- 
2.51.0


