Return-Path: <cgroups+bounces-10630-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA96BCC442
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F3224E2C26
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F4A26E6F9;
	Fri, 10 Oct 2025 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUcHKBHd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6226D4EB;
	Fri, 10 Oct 2025 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087695; cv=none; b=GDvinntdsO4xG0oGNvfq44J6En350h/yGekQXKOEhKWT3LwG6eLY0mDbTtkfvoT6YePHX/4yKaG9nxxyptvgl2QfpwloYHR+MrjxoAY7mNFj+8uBuzn8JVAJ3aSvpIZl//NBd10nist3ge47WWdRYqSwAMIqIkJ2ygKFU0o65ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087695; c=relaxed/simple;
	bh=u7SLgLBccucj039JaoAvEvFkT37dkHYadI9yOpx4Z1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3HkZX9Rw4sECi4bPjNQ5soJ5kUr+oiEdGnID6gLYpC2TbQkXO7lOlF3YWdZRD3+5/MlcvN8dOBqvicomA6hz8wNS+kUe7SyTFTygn7LTFyDQHODW2JTXjPLCUOnhocfifmOz8DCmFCSj9hzBmsCk7IxtY6oz3QWf/uLlKoYlOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUcHKBHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6362C4CEF8;
	Fri, 10 Oct 2025 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087695;
	bh=u7SLgLBccucj039JaoAvEvFkT37dkHYadI9yOpx4Z1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUcHKBHdKBlX+Vk6ZWgSSSlwaDTUs7m64gI4i572Ow6hKpG39/wGQyevudosdQyIx
	 moWPdYyRaID9tWXKn2C2qiRHzo2GJVDzDXQCT+8wFMqpXqVEAxfMWVV8s15aYO2EwK
	 W37Bnfp4HO8F0NHqqraIAiu3VbvfndhDG6t8x5T5nQYwkymSkOg8MDnClEJQ9x1ink
	 4LWftPKPvYgOT9B9glXvdQA+7kcWzuAi2bZuxvdtCKedq3qdpXjHOa6wxm7E3242Ag
	 9/EZXKMiVe4oE9TI3F2yKBVpbuv+6JxAKnUBiDPal7mghk9mdgR9CEJbPH9RgbSFHZ
	 PXeIGWshHyKBQ==
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
Subject: [PATCH v2 01/19] blk-cgroup: protect iterating blkgs with blkcg->lock in blkcg_print_stat()
Date: Fri, 10 Oct 2025 17:14:26 +0800
Message-ID: <20251010091446.3048529-2-yukuai@kernel.org>
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

blkcg_print_one_stat() will be called for each blkg:
- access blkg->iostat, which is freed from rcu callback
  blkg_free_workfn();
- access policy data from pd_stat_fn(), which is frred from
  pd_free_fn(), while pd_free_fn() can be called by removing blkcg or
  deactivating policy;

The blkcg->lock can make sure iterated blkgs are still online, and both
blkg->iostat and policy data for activated policy won't be freed.

Prepare to convert protecting blkgs from request_queue with mutex.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index f93de34fe87d..0f6039d468a6 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1242,13 +1242,10 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	else
 		css_rstat_flush(&blkcg->css);
 
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
-		spin_lock_irq(&blkg->q->queue_lock);
+	guard(spinlock)(&blkcg->lock);
+	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node)
 		blkcg_print_one_stat(blkg, sf);
-		spin_unlock_irq(&blkg->q->queue_lock);
-	}
-	rcu_read_unlock();
+
 	return 0;
 }
 
-- 
2.51.0


