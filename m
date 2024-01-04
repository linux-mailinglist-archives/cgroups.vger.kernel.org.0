Return-Path: <cgroups+bounces-1077-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAF78247E4
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 19:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1630CB2175D
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E7228DB8;
	Thu,  4 Jan 2024 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWsokt0/"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4716028DB0
	for <cgroups@vger.kernel.org>; Thu,  4 Jan 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704391242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eu5YlIQJDTB29F9zBZ6QeUpQq4Hsfh0LpNOdwuB2ABY=;
	b=DWsokt0/4B46TDZoy9dpogWVquYyrEGyXKasD0ZfBinD5MESWeYP5hi1LrkgYom9kJPQ2I
	LMCdKmFevfJKNx4Owz9i04lq+b6t1Vxbib6dIXpWAcFADZ7EoYgJg4AunReQmbI+3HH8Vm
	gyorhzcy08rCh3AKwSwQWrsTQ5QSk7Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-dDr8HvIjMzSUfG-Lahkm_w-1; Thu,
 04 Jan 2024 13:00:38 -0500
X-MC-Unique: dDr8HvIjMzSUfG-Lahkm_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E32323806739;
	Thu,  4 Jan 2024 18:00:37 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.224.239])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5E0661121306;
	Thu,  4 Jan 2024 18:00:36 +0000 (UTC)
From: Daniel Vacek <neelx@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Daniel Vacek <neelx@redhat.com>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] blk-cgroup: clean up after commit f1c006f1c685
Date: Thu,  4 Jan 2024 19:00:30 +0100
Message-ID: <20240104180031.148148-1-neelx@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Commit f1c006f1c685 moved deletion of the list blkg->q_node
from blkg_destroy() to blkg_free_workfn(). Clean up the now
useless variable.

Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 block/blk-cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4b48c2c440981..2f39bd7cb6db5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -575,13 +575,13 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 static void blkg_destroy_all(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
-	struct blkcg_gq *blkg, *n;
+	struct blkcg_gq *blkg;
 	int count = BLKG_DESTROY_BATCH_SIZE;
 	int i;
 
 restart:
 	spin_lock_irq(&q->queue_lock);
-	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
+	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
 		if (hlist_unhashed(&blkg->blkcg_node))
-- 
2.43.0


