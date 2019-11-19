Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA771102798
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 16:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfKSPFJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Nov 2019 10:05:09 -0500
Received: from m15-113.126.com ([220.181.15.113]:52604 "EHLO m15-113.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfKSPFJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 19 Nov 2019 10:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ECh/gxGvyp9KSqXajL
        yZib+zF6gPBMDIeYZREp09BV4=; b=lI9rukbzWZ6xgpv1+CFDPY6+fj9Ivfp2JU
        Bljz1Y6yJsW4Bcj8k8VczsLLdQpMwGQ22GX9Yl1/cPzGzMCJx1tnt63brEUshgqx
        LAhZV1mMpc0A5dHWeW/+El2RKQchrLG2Y861Grsq55zDUEXLDnp6nv+iAVTRBs9p
        zd1pGJbcg=
Received: from 192.168.137.246 (unknown [112.10.75.10])
        by smtp3 (Coremail) with SMTP id DcmowADHg_UDBNRdRsnDAw--.8869S3;
        Tue, 19 Nov 2019 23:02:29 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bfq: Replace kmalloc_node with kzalloc_node
Date:   Tue, 19 Nov 2019 10:02:26 -0500
Message-Id: <1574175746-8809-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DcmowADHg_UDBNRdRsnDAw--.8869S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrXr45Zr15Xw4UCr4rXF1kXwb_yoWxXFc_G3
        ykGr1I9ryUAryfCrnY9F9xWFZ0kFWxWwnY93W3Cr13ZF15Ja1kA3sxXr47GrsxuFWxCry3
        X34qgrnrJFn7tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8KNt7UUUUU==
X-Originating-IP: [112.10.75.10]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbiHgVypF16FasP8gAAsp
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Replace kmalloc_node with kzalloc_node

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 block/bfq-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 86a607c..9a84d79 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1385,7 +1385,7 @@ struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 	struct bfq_group *bfqg;
 	int i;
 
-	bfqg = kmalloc_node(sizeof(*bfqg), GFP_KERNEL | __GFP_ZERO, node);
+	bfqg = kzalloc_node(sizeof(*bfqg), GFP_KERNEL, node);
 	if (!bfqg)
 		return NULL;
 
-- 
1.8.3.1

