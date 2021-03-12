Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC32338B2A
	for <lists+cgroups@lfdr.de>; Fri, 12 Mar 2021 12:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhCLLJX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Mar 2021 06:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbhCLLJJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Mar 2021 06:09:09 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E21BC061574;
        Fri, 12 Mar 2021 03:09:09 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so10590412pjq.5;
        Fri, 12 Mar 2021 03:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SiVV6EtJZFIFkG/CEJdYUnLYJ8IcYQwEYTMUZJ4BL9Q=;
        b=YC4HWpCJruAgTzfDhVZNQ6U66EvejBlEQQyydGG0jwfqwp9h3Dr3L7Y3WwGt+Hex6X
         1Xcts7hqe3FXHQ5RbBV8FvZRFmKl+KXUbSGbNxR8oXPH/I4mU8cymvoEujoTS12WgP88
         uCNoDsD3/sCxjRs62AaH/We1Ys/QfFTEWsYgxmzEW3w6M8mS9HRiy4lCLZMH3Jch0/27
         1XLqZyIDbyok6EfcrmOhMjs8IkA9a51KFbeksGzEi+8TtCNyVeWMkJ4a0fVBzsZ6EIrC
         gs7q7HeVTxkD/6x3/YUNQg1mIkOxjx8rqVDk6IY5ry+ruSeK5RW/HS/SSlQ4YZTawn/Z
         3OYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SiVV6EtJZFIFkG/CEJdYUnLYJ8IcYQwEYTMUZJ4BL9Q=;
        b=PHmT+zNby/NWifMyTrExJP0lPDvmOxXtKSDaX9hG3IypAciQbIp2v/LrRzjsSFp23s
         rmwwYh4SodxYFwvxRPRoLho6T14N9O6FJkTbGAx3I9D9SnJcaF2Mm9iAXiGUkOpEYwFY
         W+KohNtHN8BYDYu0qY+Zf2HQkfF/XKcyRLQ0OAfZ6IlsDQ1OcpfvmyKqHjU5hCE1p4hr
         iqNLHI/lF6ZotNpN4SGzqpcmYlMdzty3sSEuqh9+3adjYkhUgUgMcPyLJqQBAtXi0VpZ
         /38ShFXRP557y75uaN7edn7bbCeHj2OU6erlfUJpMBbva+RjE9P9hPKtGn4Uzot3nJPI
         c4MQ==
X-Gm-Message-State: AOAM531G9vIQ409ZuIKS6p8ofiLG7sZllYGIy08AAWvmxKZLtWSxZTGP
        kpBQJczae9KqxrxPzmkhFS8=
X-Google-Smtp-Source: ABdhPJwBs2BSLFhpEfC6/U4aNhlZ0ug3jSui6YDmWiHRb6gjqtsFFYiMX+WabYyEtJTzDFyhZ3TcUw==
X-Received: by 2002:a17:902:e8cb:b029:e2:9906:45a6 with SMTP id v11-20020a170902e8cbb02900e2990645a6mr13043416plg.41.1615547349036;
        Fri, 12 Mar 2021 03:09:09 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id t5sm4942181pgl.89.2021.03.12.03.09.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:09:08 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 09/11] bfq: disallow merge CLASS_RT with other class
Date:   Fri, 12 Mar 2021 19:08:43 +0800
Message-Id: <9b3b89cf193896f459b5c59f58b65783df0f490c.1615527324.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615517202.git.brookxu@tencent.com>
References: <cover.1615517202.git.brookxu@tencent.com>
In-Reply-To: <cover.1615527324.git.brookxu@tencent.com>
References: <cover.1615527324.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In EMQ, perhaps we should not merge the CLASS_RT queue
with other class queues. Otherwise, the delay of
CLASS_RT IO will increase.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9330043cdd53..bb6cc8c9ddf5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2623,6 +2623,9 @@ static bool bfq_may_be_close_cooperator(struct bfq_queue *bfqq,
 	if (!bfq_bfqq_sync(bfqq) || !bfq_bfqq_sync(new_bfqq))
 		return false;
 
+	if (bfq_class_rt(bfqq) && !bfq_class_rt(new_bfqq))
+		return false;
+
 	return true;
 }
 
-- 
2.30.0

