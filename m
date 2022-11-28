Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AED63A020
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 04:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiK1Dcd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 27 Nov 2022 22:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiK1Dcc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 27 Nov 2022 22:32:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AAE13CC0
        for <cgroups@vger.kernel.org>; Sun, 27 Nov 2022 19:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669606292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mh8+HZNMN2F6HzSwmWPr16ecpqC3Mw7WO0DSOHuRXuQ=;
        b=JD1i+j+QXnc1HbipMzQVoy70Q7r2FqnP54sOXtsrQmDNrJYY8FhPMvAPYDDPkRkEkBnvGN
        kdW0JcwqJFKbAynjcX2aZ8pdq0uyjfV+qt/sQ/TrZ7msaY2wB419SA3L+0Po3ODOqsTDVy
        O0NlNcKEyNaQMH4wBTuSK854fI/wc2g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-HrKrfLHKPnuPTFPzc0qKUA-1; Sun, 27 Nov 2022 22:31:28 -0500
X-MC-Unique: HrKrfLHKPnuPTFPzc0qKUA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4C43811E67;
        Mon, 28 Nov 2022 03:31:27 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5A17492B08;
        Mon, 28 Nov 2022 03:31:26 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>,
        Waiman Long <longman@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH-block] blk-cgroup: Use css_tryget() in blkcg_destroy_blkgs()
Date:   Sun, 27 Nov 2022 22:30:57 -0500
Message-Id: <20221128033057.1279383-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction
path") incorrectly assumes that css_get() will always succeed. That may
not be true if there is no blkg associated with the blkcg. If css_get()
fails, the subsequent css_put() call may lead to data corruption as
was illustrated in a test system that it crashed on bootup when that
commit was included. Also blkcg may be freed at any time leading to
use-after-free. Fix it by using css_tryget() instead and bail out if
the tryget fails.

Fixes: 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction path")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-cgroup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 57941d2a8ba3..74fefc8cbcdf 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1088,7 +1088,12 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 
 	might_sleep();
 
-	css_get(&blkcg->css);
+	/*
+	 * If css_tryget() fails, there is no blkg to destroy.
+	 */
+	if (!css_tryget(&blkcg->css))
+		return;
+
 	spin_lock_irq(&blkcg->lock);
 	while (!hlist_empty(&blkcg->blkg_list)) {
 		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
-- 
2.31.1

