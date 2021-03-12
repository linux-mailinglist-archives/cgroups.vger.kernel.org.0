Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED19C338B2E
	for <lists+cgroups@lfdr.de>; Fri, 12 Mar 2021 12:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhCLLJX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Mar 2021 06:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbhCLLJH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Mar 2021 06:09:07 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412AFC061574;
        Fri, 12 Mar 2021 03:09:07 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w7so8280248pll.8;
        Fri, 12 Mar 2021 03:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FSKEpSWVHV20pfrPvKA6p9/HfL/MH8Y0LwmULwrkplM=;
        b=Q69wXyuREdBCG9JuoDz6E0QKQmNabsXXZeI4+0yjvDeqW2TyfrRepIb7+5SyGkOyag
         oCPUq6Ru1g6ZcxAfAr37vgU4MT1BVD5TUp6r3X+ztdKAPNiA9DMVDqcAMASIXwM/2OCp
         ICVOraK3udBH4Sa4UCaRDyujHXwQ643iSCSJwAeQeaWnpzQruEh/cYto65VfGdn7MIX+
         56tn4/STBGaSBEEpxoZfxbzSjfEyzlTT/ZHd0dy6J6up/pHrAPy4Ax9PvL8gVCnHw6uj
         DVT//4Apv0RyFN8M4orNaskY4xlmDo6WHq0GJSutyfxtdnk09owdMM/DMTVEUfVb3p5z
         hrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FSKEpSWVHV20pfrPvKA6p9/HfL/MH8Y0LwmULwrkplM=;
        b=l4MCQq2QeWL5QFZxQEqTn2BEjzEooeftIxCyeLwl71FFKUN3nErGwBWdaoXcplPWzO
         im/6tkDexTLvcuqhHzpVIPOnHjyOF03P2xqMxJn5OrGnha7m9OqPcopQUdgW96boZy7g
         A2rQj5tlkeZYhSFCbaHXeqUw6/VmWfsPCDEOUgpGRAv02DIqF/b3wYA4r4v9kRAgHGEn
         plKp2ybYyQ/N5FDErSoqSUBJBWL3DsOueK+zpUjSbsdHJvuODgUs78FrVzjBoXUxnHEk
         g6Jp2guvg9Yw8Of4DCRGWBwATBrMMlbSh15pSwmQcK6BTQOmFsld6IAdPiUkkm7PzynG
         W1cg==
X-Gm-Message-State: AOAM533f+SfxRzkcBfY/+qQK4k/VIeuDU29w91U+i6iraKpYwLBHYOln
        qSDzRT8djIfN/qqe6RnrJvI=
X-Google-Smtp-Source: ABdhPJyJS+HrsBGaoUngHYzYoqZw/LwkTp6RyL/fBdi2wr/UDePrQEHmtHFrNydAglWJS4A3Ddkxrg==
X-Received: by 2002:a17:902:8482:b029:e6:325b:5542 with SMTP id c2-20020a1709028482b02900e6325b5542mr13136879plo.70.1615547346902;
        Fri, 12 Mar 2021 03:09:06 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id t5sm4942181pgl.89.2021.03.12.03.09.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:09:06 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 08/11] bfq: disallow idle if CLASS_RT waiting for service
Date:   Fri, 12 Mar 2021 19:08:42 +0800
Message-Id: <157b97d7bda348b657b09e9c5a294305cfe29329.1615527324.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615517202.git.brookxu@tencent.com>
References: <cover.1615517202.git.brookxu@tencent.com>
In-Reply-To: <cover.1615527324.git.brookxu@tencent.com>
References: <cover.1615527324.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

if CLASS_RT is waiting for service，queues belong
to other class disallow idle, so that a schedule
can be invoked in time.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a5f13589df79..9330043cdd53 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4263,6 +4263,11 @@ static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 	if (unlikely(bfqd->strict_guarantees))
 		return true;
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	if (!bfq_class_rt(bfqq) && bfqd->busy_groups[0])
+		return false;
+#endif
+
 	/*
 	 * Idling is performed only if slice_idle > 0. In addition, we
 	 * do not idle if
-- 
2.30.0

