Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C680619FB9
	for <lists+cgroups@lfdr.de>; Fri,  4 Nov 2022 19:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiKDSXN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Nov 2022 14:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiKDSWy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Nov 2022 14:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FE04B98A
        for <cgroups@vger.kernel.org>; Fri,  4 Nov 2022 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667586061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fsF/w+s1hazC7fbvdAgtahejdx2Z7prb6bJ8RwO66qE=;
        b=dI1cmkJ5t8mDhuwSAUEXOgNrX5FWBQmzuiFVmOK/IwniC5Ox/voCiJpsru61wcPHQrh6qX
        6KlV8geKivoKhWU/HK2ZPg/FtVAmL1QGR1lMpD7ES15nihmUeavXHJAzDvtenxg98uisdu
        NXxFLbTspuX/ikzPYnXHDB2av5SXt2U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-wMiRFWXmPxejMKYYvjH6vg-1; Fri, 04 Nov 2022 14:20:57 -0400
X-MC-Unique: wMiRFWXmPxejMKYYvjH6vg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11297811E67;
        Fri,  4 Nov 2022 18:20:57 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 940ADC15BA5;
        Fri,  4 Nov 2022 18:20:56 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 1/3] blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
Date:   Fri,  4 Nov 2022 14:20:48 -0400
Message-Id: <20221104182050.342908-2-longman@redhat.com>
In-Reply-To: <20221104182050.342908-1-longman@redhat.com>
References: <20221104182050.342908-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For blkcg_css_alloc(), the only error that will be returned is -ENOMEM.
Simplify error handling code by returning this error directly instead
of setting an intermediate "ret" variable.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 6a5c849ee061..af8a4d2d1fd1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1139,7 +1139,6 @@ static struct cgroup_subsys_state *
 blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct blkcg *blkcg;
-	struct cgroup_subsys_state *ret;
 	int i;
 
 	mutex_lock(&blkcg_pol_mutex);
@@ -1148,10 +1147,8 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 		blkcg = &blkcg_root;
 	} else {
 		blkcg = kzalloc(sizeof(*blkcg), GFP_KERNEL);
-		if (!blkcg) {
-			ret = ERR_PTR(-ENOMEM);
+		if (!blkcg)
 			goto unlock;
-		}
 	}
 
 	for (i = 0; i < BLKCG_MAX_POLS ; i++) {
@@ -1168,10 +1165,9 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 			continue;
 
 		cpd = pol->cpd_alloc_fn(GFP_KERNEL);
-		if (!cpd) {
-			ret = ERR_PTR(-ENOMEM);
+		if (!cpd)
 			goto free_pd_blkcg;
-		}
+
 		blkcg->cpd[i] = cpd;
 		cpd->blkcg = blkcg;
 		cpd->plid = i;
@@ -1200,7 +1196,7 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 		kfree(blkcg);
 unlock:
 	mutex_unlock(&blkcg_pol_mutex);
-	return ret;
+	return ERR_PTR(-ENOMEM);
 }
 
 static int blkcg_css_online(struct cgroup_subsys_state *css)
-- 
2.31.1

