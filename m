Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A453AB57
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 18:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353770AbiFAQxr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 12:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353699AbiFAQxq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 12:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C7BF34BA2
        for <cgroups@vger.kernel.org>; Wed,  1 Jun 2022 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654102424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nFWeyQp+SrczfCg3mcRu+wFEKALhsOXDeSMtjftZhiE=;
        b=UV+Y0ZhEk0K1EwxffGvae7oh/2tKKzRGxxOihVqqB9H1oxbNXLlP4Dhlsdx9bILW5X6q7B
        PPIfOlmQE1IhQ6718AHFQ9/8iQoQCPz9j/1rAvpvZVnHTjRJex9Lfq7ZypKMB6wV4w9Etv
        nnBv3rJ33zOdPZ6Mhi3rwTvGsDgrPNk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-UVh5-t9sNqO4A_FIvhKgRQ-1; Wed, 01 Jun 2022 12:53:39 -0400
X-MC-Unique: UVh5-t9sNqO4A_FIvhKgRQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB8F18032E5;
        Wed,  1 Jun 2022 16:53:38 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7574E1731B;
        Wed,  1 Jun 2022 16:53:38 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/2] blk-cgroup: Correctly free percpu iostat_cpu in blkg on error exit
Date:   Wed,  1 Jun 2022 12:53:23 -0400
Message-Id: <20220601165324.60892-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup
rstat") changes block cgroup IO stats to use the rstat APIs. It added
a new percpu iostat_cpu field into blkg. The blkg_alloc() was modified
to allocate the new percpu iostat_cpu but didn't free it when an error
happened. Fix this by freeing the percpu iostat_cpu on error exit.

Fixes: f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-cgroup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 40161a3f68d0..acd9b0aa8dc8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -219,11 +219,11 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 		return NULL;
 
 	if (percpu_ref_init(&blkg->refcnt, blkg_release, 0, gfp_mask))
-		goto err_free;
+		goto err_free_blkg;
 
 	blkg->iostat_cpu = alloc_percpu_gfp(struct blkg_iostat_set, gfp_mask);
 	if (!blkg->iostat_cpu)
-		goto err_free;
+		goto err_free_blkg;
 
 	if (!blk_get_queue(q))
 		goto err_free;
@@ -259,6 +259,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	return blkg;
 
 err_free:
+	free_percpu(blkg->iostat_cpu);
+
+err_free_blkg:
 	blkg_free(blkg);
 	return NULL;
 }
-- 
2.31.1

