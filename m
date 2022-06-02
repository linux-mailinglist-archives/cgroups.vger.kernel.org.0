Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4EB53B9E3
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 15:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiFBNgM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 09:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiFBNgB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 09:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4954B78EEE
        for <cgroups@vger.kernel.org>; Thu,  2 Jun 2022 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654176959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXLuT1Yk9DAXTYl5NoX/oMeS35ik4rQo8uu3jun7bK8=;
        b=Rbmd30rFN3vWagLRSD2IevPrUjKBb0Inr3v+UZRMxKozIr9VTWBVMG6bynByfShvEETdR4
        Tki1zAf+T3t10Lfq7/aOXo0irNj+FsL9S4OmXxGHu2ig135oGvFLZZgAa+hvZjeEFPBiIr
        H9LA7CzGCwY+l+uJ02DYdAo3zSv1u/Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-kEgn3EQiObSe0z98QPm7CQ-1; Thu, 02 Jun 2022 09:35:52 -0400
X-MC-Unique: kEgn3EQiObSe0z98QPm7CQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F00B3C7B139;
        Thu,  2 Jun 2022 13:35:52 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD7D02166B26;
        Thu,  2 Jun 2022 13:35:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 1/3] blk-cgroup: Correctly free percpu iostat_cpu in blkg on error exit
Date:   Thu,  2 Jun 2022 09:35:41 -0400
Message-Id: <20220602133543.128088-2-longman@redhat.com>
In-Reply-To: <20220601211824.89626-1-longman@redhat.com>
References: <20220601211824.89626-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
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
Acked-by: Tejun Heo <tj@kernel.org>
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

