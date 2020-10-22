Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B34E2964A7
	for <lists+cgroups@lfdr.de>; Thu, 22 Oct 2020 20:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369687AbgJVS34 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Oct 2020 14:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369316AbgJVS3z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Oct 2020 14:29:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98346C0613CE
        for <cgroups@vger.kernel.org>; Thu, 22 Oct 2020 11:29:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id A992C1F462F6
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, khazhy@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH] blk-cgroup: Pre-allocate tree node on blkg_conf_prep
Date:   Thu, 22 Oct 2020 14:29:45 -0400
Message-Id: <20201022182945.1679730-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Similarly to commit 457e490f2b741 ("blkcg: allocate struct blkcg_gq
outside request queue spinlock"), blkg_create can also trigger
occasional -ENOMEM failures at the radix insertion because any
allocation inside blkg_create has to be non-blocking, making it more
likely to fail.  This causes trouble for userspace tools trying to
configure io weights who need to deal with this condition.

This patch reduces the occurrence of -ENOMEMs on this path by preloading
the radix tree element on a GFP_KERNEL context, such that we guarantee
the later non-blocking insertion won't fail.

A similar solution exists in blkcg_init_queue for the same situation.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 block/blk-cgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index f9b55614d67d..bbf848604089 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -612,6 +612,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	struct gendisk *disk;
 	struct request_queue *q;
 	struct blkcg_gq *blkg;
+	bool preloaded = false;
 	int ret;
 
 	disk = blkcg_conf_get_disk(&input);
@@ -657,6 +658,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto fail;
 		}
 
+		preloaded = !radix_tree_preload(GFP_KERNEL);
+
 		rcu_read_lock();
 		spin_lock_irq(&q->queue_lock);
 
@@ -676,6 +679,9 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			}
 		}
 
+		if (preloaded)
+			radix_tree_preload_end();
+
 		if (pos == blkcg)
 			goto success;
 	}
@@ -688,6 +694,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 fail_unlock:
 	spin_unlock_irq(&q->queue_lock);
 	rcu_read_unlock();
+	if (preloaded)
+		radix_tree_preload_end();
 fail:
 	put_disk_and_module(disk);
 	/*
-- 
2.28.0

