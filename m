Return-Path: <cgroups+bounces-14590-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANk4AnXhp2mrlAAAu9opvQ
	(envelope-from <cgroups+bounces-14590-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 08:38:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B641FBB19
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 08:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B79A630495B8
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 07:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B14370D54;
	Wed,  4 Mar 2026 07:38:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FD35CB7A;
	Wed,  4 Mar 2026 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609902; cv=none; b=G0Mn4nVd7Rp1172F93wqzE25c7vHHa+p/+nBBSnHpclsHoKGk0Jmb6OJZCRbbVFJJys3DPhrfRykwIYI2k3H1HQx/2XDmhIZan3oHPuz3wv0dQdX5wzUfU6TNQLJQ/2kEGNIv/29elhwRMT1Oy9QzvZ3B3vgwHGN/ropHnLVdcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609902; c=relaxed/simple;
	bh=mfoop8ZFZvTQ70rW8k+bwTmcnWPolUFqyPFaLre1q6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk24XrR5up3c2jPZbSm5NthIk5LlPkfsrUc0mb7VgThUJp+uTFXqMYmO3VMINE/11WeG5ka3JEB+8uOlx3OQI9lbVu/WpNUMWy8igLJI/Yk1TtiIWGMDYyZseQH0f41/2m3vjgMhhulo64afnsa2zVHePcxPOgDeyoGKwq7XZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2F7C2BCB1;
	Wed,  4 Mar 2026 07:38:19 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zheng Qixing <zhengqixing@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 3/7] blk-cgroup: fix race between policy activation and blkg destruction
Date: Wed,  4 Mar 2026 15:38:04 +0800
Message-ID: <20260304073809.3438679-4-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304073809.3438679-1-yukuai@fnnas.com>
References: <20260304073809.3438679-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C9B641FBB19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14590-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[fnnas.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:mid,fnnas.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Action: no action

From: Zheng Qixing <zhengqixing@huawei.com>

When switching an IO scheduler on a block device, blkcg_activate_policy()
allocates blkg_policy_data (pd) for all blkgs attached to the queue.
However, blkcg_activate_policy() may race with concurrent blkcg deletion,
leading to use-after-free and memory leak issues.

The use-after-free occurs in the following race:

T1 (blkcg_activate_policy):
  - Successfully allocates pd for blkg1 (loop0->queue, blkcgA)
  - Fails to allocate pd for blkg2 (loop0->queue, blkcgB)
  - Enters the enomem rollback path to release blkg1 resources

T2 (blkcg deletion):
  - blkcgA is deleted concurrently
  - blkg1 is freed via blkg_free_workfn()
  - blkg1->pd is freed

T1 (continued):
  - Rollback path accesses blkg1->pd->online after pd is freed
  - Triggers use-after-free

In addition, blkg_free_workfn() frees pd before removing the blkg from
q->blkg_list. This allows blkcg_activate_policy() to allocate a new pd
for a blkg that is being destroyed, leaving the newly allocated pd
unreachable when the blkg is finally freed.

Fix these races by extending blkcg_mutex coverage to serialize
blkcg_activate_policy() rollback and blkg destruction, ensuring pd
lifecycle is synchronized with blkg list visibility.

Link: https://lore.kernel.org/all/20260108014416.3656493-3-zhengqixing@huaweicloud.com/
Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0bc7b19399b6..a6ac6ba9430d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1599,6 +1599,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 	if (queue_is_mq(q))
 		memflags = blk_mq_freeze_queue(q);
+
+	mutex_lock(&q->blkcg_mutex);
 retry:
 	spin_lock_irq(&q->queue_lock);
 
@@ -1661,6 +1663,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 	spin_unlock_irq(&q->queue_lock);
 out:
+	mutex_unlock(&q->blkcg_mutex);
 	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q, memflags);
 	if (pinned_blkg)
-- 
2.51.0


