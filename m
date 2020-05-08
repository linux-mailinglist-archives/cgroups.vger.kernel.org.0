Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1AF1CBA52
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2020 00:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgEHWAZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 18:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727838AbgEHWAY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 18:00:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404E9C05BD43
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 15:00:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x17so3647574wrt.5
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oe6VUiTYsko1zxoPYCZbsMKvQCAiAXB7o0u5C4C7os8=;
        b=UIKZzo7pCejAlakM2hiG4HdCLnh0Hv+FZak8KGCaKM+kGnJAwThVANiEyWdglZLM+S
         5mMMkwn71jUD6RsAml4EzcgJ6KiNqgGjzZHgiQ3yVAUfZmhk8CrdxHId4nqZTZ0AhusB
         StxzkUdXJGP90As1TH59dsDkU+Nrq4j85tT9qfl/s+RXqPSkcO381Gpj4ufneSi7JSsj
         6Hgfboph161R+bTtlnhprm7PnzNrFFpD8mpHtUaJ+sC10PfTO9AtpKULFOz6gU2NsA8S
         wnhytYR/j1dkQ/aZI6QfE3zD9FrytikTvcrT/u7ruPZpXgS3Mhi17hOn0A3i3q+V52Gq
         8cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oe6VUiTYsko1zxoPYCZbsMKvQCAiAXB7o0u5C4C7os8=;
        b=r1uPpyHuxSMdST5iKpvz6CYBYpJ4zB0WuVWevdUYWnEMzMUYUXKI4y1pwTwrdlW0HR
         kUwTUd6T3Pqu6bPSXjcXhxXJPcPxTwQl/X+DT4OYps/PI/+eLIx974x9qt6nViYiJImp
         3THx6ERMg+QR9GGV3f0B5FsrU1Z0YtwNEAHz9wbzZyQhKQMtnY8V4PThT5Cy9VxjTCFe
         BgalEbLwGbvDSyUpcij+iALf1y1CQ4a+uQ90OIPu8szkc+8O5pvdazu2eY4Qv9WhElhn
         YNA2ckeTD9PJWM+J78voMUe3a6Onm6W1df+0fy0r5Es/ErkvESH/IVN76UUZCLnWNcQu
         T7NA==
X-Gm-Message-State: AGi0PuaYHtXkVVGeEYWD9LV4pezUp0+24Whu/2bgf3kCgFUG5HXGNxKd
        UQ0YgGcdazR3AJIG/ocL5aGOUj6W/TpcYQ==
X-Google-Smtp-Source: APiQypJmQon21vzDnJA1qjvuqx/qUdbW7qPUG+u5CBe/BtuOAuVSHxiYsvGhy/tK+NKaUFy6zMbGqg==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr4748201wrt.195.1588975221983;
        Fri, 08 May 2020 15:00:21 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:7d6e:af57:ffe:3087])
        by smtp.gmail.com with ESMTPSA id h6sm14646878wmf.31.2020.05.08.15.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 15:00:21 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 2/4] blk-throttle: remove tg_drain_bios
Date:   Sat,  9 May 2020 00:00:13 +0200
Message-Id: <20200508220015.11528-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
References: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

After blk_throtl_drain is removed, there is no caller of tg_drain_bios,
so remove it as well.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-throttle.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 0b2ce7fb77a7..209fdd8939fb 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2358,28 +2358,6 @@ void blk_throtl_bio_endio(struct bio *bio)
 }
 #endif
 
-/*
- * Dispatch all bios from all children tg's queued on @parent_sq.  On
- * return, @parent_sq is guaranteed to not have any active children tg's
- * and all bios from previously active tg's are on @parent_sq->bio_lists[].
- */
-static void tg_drain_bios(struct throtl_service_queue *parent_sq)
-{
-	struct throtl_grp *tg;
-
-	while ((tg = throtl_rb_first(parent_sq))) {
-		struct throtl_service_queue *sq = &tg->service_queue;
-		struct bio *bio;
-
-		throtl_dequeue_tg(tg);
-
-		while ((bio = throtl_peek_queued(&sq->queued[READ])))
-			tg_dispatch_one_bio(tg, bio_data_dir(bio));
-		while ((bio = throtl_peek_queued(&sq->queued[WRITE])))
-			tg_dispatch_one_bio(tg, bio_data_dir(bio));
-	}
-}
-
 int blk_throtl_init(struct request_queue *q)
 {
 	struct throtl_data *td;
-- 
2.17.1

