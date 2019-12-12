Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E9811CF60
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2019 15:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfLLOJE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Dec 2019 09:09:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36582 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfLLOJD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Dec 2019 09:09:03 -0500
Received: by mail-ed1-f65.google.com with SMTP id j17so1925138edp.3;
        Thu, 12 Dec 2019 06:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g2DYtG1fBQ6px3ecWGYXwRbrai1LWXOdFTpOAsDGfMA=;
        b=IcKACO99Ks3RgKSrUbaA0GGiGyKBCvFovRFwVe1pDl/xs3Zyc7TrdApXSxyW7ME2K5
         OfzIv2ettywGHllWbr6/IEz4wxv6cpmAWZwf40u94HMrbipL9toeyAXJe76IBU+6efRu
         BpYF5khnUbidCdQZ5DMIkmDo6LCiDfbQyhuJlnEjs+VMdMasXRCaGr5vz6vZDH5ra4aJ
         raC8HX7N04zpKHlF7CHPB1I538t1geYpw5wHPRW2Om08sQtpVKFeSd4R8NZ+oTKPI+Fh
         J7xsbn91E74q/1SGkitYFRznDUbFrrG4pstFjlHCjSMvkbJMlrbP8qz9+QDaxSo7xBd6
         mcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g2DYtG1fBQ6px3ecWGYXwRbrai1LWXOdFTpOAsDGfMA=;
        b=PSiwiCcc6HK2bmIQNwadte6HxpQtoHgLDU4/UqnNO1Bzsw12j8CCfGXzzSiQNvNwSs
         0nVbw4fx0sroERD6DNaORWvaupICneW4wa7lq+ut2x+hl/ZxwtQYzl4m+wC7/QrAZCpu
         PjWmoL13bTO8ppcgMBKanXKt3sQdEpSmSEdEX5durGgqCNFcPLgnxqecgifQrMlY2xIU
         0qFm2L5t0vgfEtl3J1Pl1441tY8kFZmDuvI5J6zD+mVERY/uHmL/N/6andrv5igWYIQ1
         aRaYHChNCJ31cXzbCgiNaysK6QsxSfjTN9Rw3dnDj5Am9AvGlVxIQYY+Pe+4RhBLORZf
         5zwA==
X-Gm-Message-State: APjAAAVs0pGEhzrrLIuqx5TLNVAETJ/LkUzu1nQR2T2fAIKGH0BWdkiX
        S5l2WxemUGlOyvQakXJkfL4=
X-Google-Smtp-Source: APXvYqzNyuKExjH6wzzsVG/QW2WyQAYOCJrKIfhXr3uRP0h9cMPnVR5DfEkhn6LaZDdCYEsXz77dRQ==
X-Received: by 2002:a50:ac71:: with SMTP id w46mr9724440edc.27.1576159741910;
        Thu, 12 Dec 2019 06:09:01 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:1467:8db0:560a:58ea])
        by smtp.gmail.com with ESMTPSA id cw10sm157774ejb.56.2019.12.12.06.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 06:09:01 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] blk-cgroup: remove blkcg_drain_queue
Date:   Thu, 12 Dec 2019 15:08:51 +0100
Message-Id: <20191212140851.19107-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Since blk_drain_queue had already been removed, so this function
is not needed anymore.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-cgroup.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 708dea92dac8..a229b94d5390 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1061,26 +1061,6 @@ int blkcg_init_queue(struct request_queue *q)
 	return PTR_ERR(blkg);
 }
 
-/**
- * blkcg_drain_queue - drain blkcg part of request_queue
- * @q: request_queue to drain
- *
- * Called from blk_drain_queue().  Responsible for draining blkcg part.
- */
-void blkcg_drain_queue(struct request_queue *q)
-{
-	lockdep_assert_held(&q->queue_lock);
-
-	/*
-	 * @q could be exiting and already have destroyed all blkgs as
-	 * indicated by NULL root_blkg.  If so, don't confuse policies.
-	 */
-	if (!q->root_blkg)
-		return;
-
-	blk_throtl_drain(q);
-}
-
 /**
  * blkcg_exit_queue - exit and release blkcg part of request_queue
  * @q: request_queue being released
-- 
2.17.1

