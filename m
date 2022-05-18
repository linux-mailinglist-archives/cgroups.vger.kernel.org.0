Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B518A52AFF7
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 03:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiERBht (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 21:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiERBhs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 21:37:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E531340;
        Tue, 17 May 2022 18:37:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w17-20020a17090a529100b001db302efed6so568464pjh.4;
        Tue, 17 May 2022 18:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xx6rePJGi7UaKhXkXrJAOBEtEBFBD4Xp8h1aCNNQ5pk=;
        b=UQsNDu+K3TL0RoWiqYU8aJzPlG4KoKs+NqzgTjzA9gmgB35p+OeNfvgvxiT+Otn5ux
         jI5s5WqirBU7Jhbz2L+2B+EJXfZ2e4Cs3jAZ/A0cQMHaqEnA96dxbK2nCn7UlGNwaamT
         vImHt36Kj+bSNIwtjD+WJcqbXUskciCiPM1BbywHDZQvN8JxmTzU2MFyqB3E1OqyDLPZ
         vO8A3/HfT0FQ0B2vxv1qWYmZKph3LyIe5s/jDZcMgrwyx4sty97N81e32k6rigUqWKIh
         CeBuaUr31rQy/LHnS/aJHG3hlw7k5cwRtGBd4X70mYiDYzbWzv3/zupNOkklKPlQW7CU
         Cu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xx6rePJGi7UaKhXkXrJAOBEtEBFBD4Xp8h1aCNNQ5pk=;
        b=QNrypGJioS2wh1rQyD/XJJ7IyZk6OEy2imJo+dhDHvDMAJBxGli1tJ4mopcFxOGsdz
         k3FANd7i6pOuSJKrU+E1FnYwuGGRmYA2nvu5wB6d3fMvz7Ob3z3aM1sZV170ietiJXAd
         EO4gOcN90sPWAl5YHAI9g2KLQxNzG+QPVKOnZHV+8C/FlZn4Ej5Zo73wai5tUiIs5iTE
         kjCBAIcoSqZUE8Zpg6/nkEkUclBC6OU3DS8oGEQmQog51G0hlpjk3lamQ0LWXnTzUDeV
         BKBqL0/tMzRFQBe3xQUF3fS8jR45qOW+arVyFIidcLG+Ii5nvhNqaC450dYA7kkjSBAD
         CKPg==
X-Gm-Message-State: AOAM532rEpfPac5CNgyEXuuXJzxQUiOXWuxZsFV8PuLfG44NP5PY5sSI
        vOWPejxX1IryvCJHXK47S0I=
X-Google-Smtp-Source: ABdhPJzL1j+HlqKCklCP1DJ3aVsnn6tiCC6/9z58A4PyGRc11yVUV/wuFWJ20A+4USqxe2a+Et2nYQ==
X-Received: by 2002:a17:90a:c48:b0:1df:6210:48a0 with SMTP id u8-20020a17090a0c4800b001df621048a0mr12119030pje.119.1652837867447;
        Tue, 17 May 2022 18:37:47 -0700 (PDT)
Received: from localhost.localdomain ([103.197.71.140])
        by smtp.gmail.com with ESMTPSA id u191-20020a6385c8000000b003c14af50627sm200052pgd.63.2022.05.17.18.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 18:37:46 -0700 (PDT)
From:   Shida Zhang <starzhangzsd@gmail.com>
X-Google-Original-From: Shida Zhang <zhangshida@kylinos.cn>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v2] cgroup: remove the superfluous judgment
Date:   Wed, 18 May 2022 09:36:47 +0800
Message-Id: <20220518013647.1749568-1-zhangshida@kylinos.cn>
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

Remove the superfluous judgment since the function is
never called for a root cgroup, as suggested by Tejun.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 Changes from v1:
 - Just remove the superfluous judgment instead.

 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index adb820e98f24..7d8a463c461b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5685,7 +5685,7 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	css_clear_dir(&cgrp->self);
 	kernfs_remove(cgrp->kn);
 
-	if (parent && cgroup_is_threaded(cgrp))
+	if (cgroup_is_threaded(cgrp))
 		parent->nr_threaded_children--;
 
 	spin_lock_irq(&css_set_lock);
-- 
2.25.1

