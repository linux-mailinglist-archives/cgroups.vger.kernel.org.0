Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD42539614
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 20:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346937AbiEaSSh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 May 2022 14:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiEaSSh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 May 2022 14:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C8558DDE8
        for <cgroups@vger.kernel.org>; Tue, 31 May 2022 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654021115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hCTUSkWIIHgNixKuY/6iwCz6DbkjCFmwTBRc2bIkHG8=;
        b=egSCP6eDOmNhwU7e5Kxy+kQo+p/9TxlMnWDfcHMbyMD0PK0Zq+OGK5tYtTcwuJJP/08AJW
        RaZNLvW1kf3kK4ZRXxJs6FqG8dqMnKJotIzcCgmPNoEBjskVVplohIOSkLm8gTQOlMMwTw
        6TVVro9x6uojzRRW2xUQJBmKkwLhv8w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-RcwvDlI7Oo-e2aD7g-9seQ-1; Tue, 31 May 2022 14:18:33 -0400
X-MC-Unique: RcwvDlI7Oo-e2aD7g-9seQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3401939F9CA9;
        Tue, 31 May 2022 18:18:33 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F31FEC27E92;
        Tue, 31 May 2022 18:18:32 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] blk-cgroup: Optimize blkcg_rstat_flush()
Date:   Tue, 31 May 2022 14:18:21 -0400
Message-Id: <20220531181821.187834-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For a system with many CPUs and block devices, the time to do
blkcg_rstat_flush() from cgroup_rstat_flush() can be rather long. It
can be especially problematic as interrupt is disabled during the flush.
It was reported that it might take seconds in some extreme cases leading
to hard lockup messages.

As it is likely that not all the percpu blkg_iostat_set's has been
updated since the last flush, those stale blkg_iostat_set's don't need
to be flushed in this case. This patch optimizes blkcg_rstat_flush()
by checking the current sequence number against the one recorded since
the last flush and skip the blkg_iostat_set if the sequence number
hasn't changed. There is a slight chance that it may miss an update
that is being done in parallel, the new update will just have to wait
until the next flush.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-cgroup.c | 18 +++++++++++++++---
 block/blk-cgroup.h |  1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 40161a3f68d0..79b89af61ef2 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -864,11 +864,23 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		unsigned long flags;
 		unsigned int seq;
 
+		seq = u64_stats_fetch_begin(&bisc->sync);
+		/*
+		 * If the sequence number hasn't been updated since the last
+		 * flush, we can skip this blkg_iostat_set though we may miss
+		 * an update that is happening in parallel.
+		 */
+		if (seq == bisc->last_seq)
+			continue;
+
 		/* fetch the current per-cpu values */
-		do {
-			seq = u64_stats_fetch_begin(&bisc->sync);
+		while (true) {
+			bisc->last_seq = seq;
 			blkg_iostat_set(&cur, &bisc->cur);
-		} while (u64_stats_fetch_retry(&bisc->sync, seq));
+			if (!u64_stats_fetch_retry(&bisc->sync, seq))
+				break;
+			seq = u64_stats_fetch_begin(&bisc->sync);
+		}
 
 		/* propagate percpu delta to global */
 		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index d4de0a35e066..22b4ea139b93 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -45,6 +45,7 @@ struct blkg_iostat_set {
 	struct u64_stats_sync		sync;
 	struct blkg_iostat		cur;
 	struct blkg_iostat		last;
+	unsigned int			last_seq;
 };
 
 /* association between a blk cgroup and a request queue */
-- 
2.31.1

