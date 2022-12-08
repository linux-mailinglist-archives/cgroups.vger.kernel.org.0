Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA44E647889
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 23:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiLHWEZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 17:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiLHWED (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 17:04:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC7B80A13
        for <cgroups@vger.kernel.org>; Thu,  8 Dec 2022 14:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670536919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s3VQJPU/3HC+t8N1wzyewiUON5nIdBJkilNRlkYPV+o=;
        b=Cmd286drxpAqixfM4Cs5CXpjqjC/8Bg3pBG5dEQWkgiJYza5w5IzE1UBC5AwcnXo+pkJn+
        guMRAWJXrfxjiK/q1TINAYBtn6Zmp/L9uIXpm44VgsBMUVLj3Jts3TumNc3ufy3g2vI9/+
        POjrNjXDIBeZItvCaRZjPyAtjnC6LuA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-RBCKYMz_NCKOObEEZe_ADg-1; Thu, 08 Dec 2022 17:01:52 -0500
X-MC-Unique: RBCKYMz_NCKOObEEZe_ADg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE113806001;
        Thu,  8 Dec 2022 22:01:51 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6968842222;
        Thu,  8 Dec 2022 22:01:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-block 2/3] blk-cgroup: Don't flush a blkg if destroyed
Date:   Thu,  8 Dec 2022 17:01:40 -0500
Message-Id: <20221208220141.2625775-3-longman@redhat.com>
In-Reply-To: <20221208220141.2625775-1-longman@redhat.com>
References: <20221208220141.2625775-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Before commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()"),
blkg's stats is only flushed if they are online. In addition, the
stat flushing of blkgs in blkcg_rstat_flush() includes propagating
the rstat data to its parent. However, if a blkg has been destroyed
(offline), the validity of its parent may be questionable. For safety,
revert back to the old behavior by ignoring offline blkg's.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 21cc88349f21..c466aef0d467 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -885,6 +885,12 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 
 		WRITE_ONCE(bisc->lqueued, false);
 
+		/* Don't flush its stats if blkg is offline */
+		if (unlikely(!blkg->online)) {
+			percpu_ref_put(&blkg->refcnt);
+			continue;
+		}
+
 		/* fetch the current per-cpu values */
 		do {
 			seq = u64_stats_fetch_begin(&bisc->sync);
-- 
2.31.1

