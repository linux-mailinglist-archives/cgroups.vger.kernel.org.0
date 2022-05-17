Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500AB529AD2
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 09:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiEQHbX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 03:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiEQHbX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 03:31:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2023BB16;
        Tue, 17 May 2022 00:31:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id v11so16155427pff.6;
        Tue, 17 May 2022 00:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1f0Z9m+vbuD/qdSf6InzF9TURBzbVV0rFya1IWbNtOo=;
        b=NpF/ctrLv7ZXdNrGCvD0hg21ovh+HtPwfrjn2Vn5+Kaz9xxkY2bSYYX+jvXLILwQmK
         GNLyzcfB9p5vtLQyy080RlDn8BI/wOniIJePP1KfvLiFgwFrQd2W2jb1Gjn+tfUWmqSg
         oBuNRiQ/JvyIjvF86rQ94VnSC37y9e+rwNNOkVJr86rgx1kQ6N+DBrz75BSMppUymB4a
         8vIJ3KqS7hfl2k07Q0i8lZWEIxmNWOfhMWwhtEa/aH0p0X8X5hnj6QH0zvS7wnEo439v
         7pQqte7CIDeDmOeRajJft70DLqgo/e06I4kSUJW1Ztg9IyrJ/WQKDI2KPfQxXVjnbHgL
         hPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1f0Z9m+vbuD/qdSf6InzF9TURBzbVV0rFya1IWbNtOo=;
        b=zyW3g2G2h2u+w9s5Z7eI4WNhlAQ0MKGV6pfrTtEdtn2Ov4ubtqGBSZWZKrkrSTzoxt
         xLuu0MG5SnsAf5Pk5xT0D5VBQJJ04bUsNSjHP8kjm5uz7J8+73SHItvs8z6eVWT5bI0l
         00oQq/lgZTVNW21/OFG+sSPL2arWq1YuyGylPI4alW4ZxipVrn/FcVZ4PgMekVY+CyVK
         iu1s3DhvzLBYp/uV9sm0yPjA8407MClb3j8wEvfDdgYDL4qjgQWxd36wj6HxClCzjhac
         BNc3erEWubkq+0Y2tGFWCRJA8G0i9j69eTDl/4+PVN45WVK3WjSp1xbNRmr2nfaFQUKr
         qFxg==
X-Gm-Message-State: AOAM533xoHriCkdHJs0oa3y4qMUY/QG2sYliwAz1xVeb0fG0MRDrLXCo
        OOos9jctqbwvykXSkXrKyOI=
X-Google-Smtp-Source: ABdhPJwBwlRgEtz4CIsRDE4/P/1KoC5oYgFYvc/cOm0mBXaUY0xTLJMW8V47e9NdfQAaW9fdCky+9g==
X-Received: by 2002:a63:89c7:0:b0:3da:ee16:c84 with SMTP id v190-20020a6389c7000000b003daee160c84mr18727427pgd.320.1652772681611;
        Tue, 17 May 2022 00:31:21 -0700 (PDT)
Received: from localhost.localdomain ([103.197.71.140])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090ad91600b001df3d5a441bsm914186pjv.53.2022.05.17.00.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 00:31:21 -0700 (PDT)
From:   Shida Zhang <starzhangzsd@gmail.com>
X-Google-Original-From: Shida Zhang <zhangshida@kylinos.cn>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH] cgroup: fix potential null pointer risk
Date:   Tue, 17 May 2022 15:31:06 +0800
Message-Id: <20220517073106.1704628-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We previously assumed 'parent' could be null,
so null pointer judgment should be added.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 kernel/cgroup/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index adb820e98f24..7f230b0ab644 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5701,7 +5701,8 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	}
 	spin_unlock_irq(&css_set_lock);
 
-	cgroup1_check_for_release(parent);
+	if (parent)
+		cgroup1_check_for_release(parent);
 
 	cgroup_bpf_offline(cgrp);
 
-- 
2.25.1

