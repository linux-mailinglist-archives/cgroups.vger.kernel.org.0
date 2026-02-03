Return-Path: <cgroups+bounces-13626-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNyrG8WsgWn0IQMAu9opvQ
	(envelope-from <cgroups+bounces-13626-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 09:07:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0810DD5FE8
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 09:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FC373075975
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA84F366834;
	Tue,  3 Feb 2026 08:06:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E618C33;
	Tue,  3 Feb 2026 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105974; cv=none; b=J1iMrvU9Hql8vhjNrj60MS+RcW5YsGjVabqX2SLp9rHeWKvaYLX2Q5ojtJPVjcoRVlHxVsQ0wYcxAZpY9rc7rzaO47ZcqUmeiIFpUn+B+ZzSUkPQy0+OaD7vHAaCQcnBSSTFEePr1BfvCQyN74uiGbCt9tKMkAm9AuoW2FRHTRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105974; c=relaxed/simple;
	bh=Vih18Xe9KeKt3GE0oQ19dCug6WMbvjG6ZdMvBqVFTTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MluqKORB9axIOKYir7W+wN/W3ddrP3VDOWpqnqI2ihoXHlcmyBYwLaOfctX6a2xx+iKgiDCsbKJ2kmJucs4Gh1kLPLm6NAKMC20OO/5008NwyiJOU48zeH7/fBBnye2hgApgrZrqNnWLQsHonAgY2JZp4nD2XJQ6CJ+uIKD/Y2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E86CC116D0;
	Tue,  3 Feb 2026 08:06:11 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai@fnnas.com,
	zhengqixing@huawei.com,
	mkoutny@suse.com,
	hch@infradead.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com
Subject: [PATCH v2 2/7] bfq: protect q->blkg_list iteration in bfq_end_wr_async() with blkcg_mutex
Date: Tue,  3 Feb 2026 16:05:57 +0800
Message-ID: <20260203080602.726505-3-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260203080602.726505-1-yukuai@fnnas.com>
References: <20260203080602.726505-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13626-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[fnnas.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0810DD5FE8
X-Rspamd-Action: no action

bfq_end_wr_async() iterates q->blkg_list while only holding bfqd->lock,
but not blkcg_mutex. This can race with blkg_free_workfn() that removes
blkgs from the list while holding blkcg_mutex.

Add blkcg_mutex protection in bfq_end_wr() before taking bfqd->lock to
ensure proper synchronization when iterating q->blkg_list.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/bfq-cgroup.c  | 3 ++-
 block/bfq-iosched.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 6a75fe1c7a5c..839d266a6aa6 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -940,7 +940,8 @@ void bfq_end_wr_async(struct bfq_data *bfqd)
 	list_for_each_entry(blkg, &bfqd->queue->blkg_list, q_node) {
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
 
-		bfq_end_wr_async_queues(bfqd, bfqg);
+		if (bfqg)
+			bfq_end_wr_async_queues(bfqd, bfqg);
 	}
 	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
 }
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3ebdec40e758..617633be8abc 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2645,6 +2645,7 @@ static void bfq_end_wr(struct bfq_data *bfqd)
 	struct bfq_queue *bfqq;
 	int i;
 
+	mutex_lock(&bfqd->queue->blkcg_mutex);
 	spin_lock_irq(&bfqd->lock);
 
 	for (i = 0; i < bfqd->num_actuators; i++) {
@@ -2656,6 +2657,7 @@ static void bfq_end_wr(struct bfq_data *bfqd)
 	bfq_end_wr_async(bfqd);
 
 	spin_unlock_irq(&bfqd->lock);
+	mutex_unlock(&bfqd->queue->blkcg_mutex);
 }
 
 static sector_t bfq_io_struct_pos(void *io_struct, bool request)
-- 
2.51.0


