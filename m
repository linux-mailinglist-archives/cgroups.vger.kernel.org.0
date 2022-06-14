Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FD854ADE6
	for <lists+cgroups@lfdr.de>; Tue, 14 Jun 2022 12:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiFNKGX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jun 2022 06:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242144AbiFNKGH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jun 2022 06:06:07 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3152D1F1;
        Tue, 14 Jun 2022 03:06:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655201164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GTMScp+nfQrh9LZR7Rnix9tWdvmjglsycVb9AO//NiI=;
        b=ohrUS6cI+TdOOoC7vg7EsWgZfarq4Fbd6sazsDnmVsMnwPryoLRA63EWd6S4bA/RbOKWJ1
        6ngjdFhrFlixB6SUDdwg+DL8ZUGtQ3262duv4Xh4xrhjlqManyQmc7MF+ERVxTDDG/80Xf
        Vr/66fEpj6JFDgtjaOySUGph8xaFArI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] block: update comment for blkcg_init_queue
Date:   Tue, 14 Jun 2022 18:05:56 +0800
Message-Id: <20220614100556.20899-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It was called from __alloc_disk_node since commit 1059699f87eb ("block:
move blkcg initialization/destroy into disk allocation/release handler).
Let's change the comment accordingly.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 764e740b0c0f..48ea9919e3ce 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1256,7 +1256,7 @@ static int blkcg_css_online(struct cgroup_subsys_state *css)
  * blkcg_init_queue - initialize blkcg part of request queue
  * @q: request_queue to initialize
  *
- * Called from blk_alloc_queue(). Responsible for initializing blkcg
+ * Called from __alloc_disk_node(). Responsible for initializing blkcg
  * part of new request_queue @q.
  *
  * RETURNS:
-- 
2.31.1

