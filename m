Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9735A1F03
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 04:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244643AbiHZCog (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 22:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiHZCof (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 22:44:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CC9CCD41;
        Thu, 25 Aug 2022 19:44:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t5so399637pjs.0;
        Thu, 25 Aug 2022 19:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=RHgqZb2XQveY9G/sJMRmpzdx+tOdeQ4iM+KusnEyRoY=;
        b=Pb3YzDPspbBnUW3qH117ZXq0J6MB5B7vyjogOalJat+W8jYnbkqOQmZKmQXSrSMupU
         8+kgv305Qpxb6/tniUToXHZSlc/AET1thtBvLtPRxkEdAPkY0ykBUrdhR8QMTBlTs6H9
         igIxdfupYdjQbH5yv8D+3AfaH79ZrSyF64Ux5Hxv1BjssyNRhsU+V7IB1/+zjpDA8r0b
         oDnB5/Nq6ymuDeZXNi1ar0XiVSpLiT1L6JPS8DTd11KP17pofDLEpzGWZfWsCL6yssAq
         GOI6sABvOCFYY4wPvVzQ0vZrwtC3nD7Z+QZ/95DPX7FpVRROdAqroybtH0oBTdcUW0el
         8FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=RHgqZb2XQveY9G/sJMRmpzdx+tOdeQ4iM+KusnEyRoY=;
        b=2GXdH/TYfTr8s7aobY7uKB9cmnOzRhEN3ndrMwSE0Tjt2EkVjYDAIpl09px22QS8d6
         GsH0hXcn29G2Q3UAy2EC37uSHcrwhs/iWbU1oO+vrXKjTGzL5aKi7vCwBQ6mYzbIiZuG
         v/8+BQJbV4jb9tha9b3tBABUqCc7TMi0ybHCEfBgUF7/HYexnGvnqN5KYdpPnNwWlo5P
         8v58RRfs4t4qirX6qXi/1qYRlFqIKUITEqcCxqbx8K3YPXmtUzzcdOstEOu4OoYtqbv2
         vYaMIoB/KhKmpYPeG4KLNOiGh8mUOzxAt15cCOT6ndxer3N5opw3TCC5F42YPiLAExu/
         fvEA==
X-Gm-Message-State: ACgBeo1pSgT9ajylfChQS1PyTEGgZ/U9DgNi84f1k1dnd4Y8hVJ3CsMW
        wh5hpT5SPepO/odcFkZn5f8nbWPgWV0=
X-Google-Smtp-Source: AA6agR6/mZIc51xeKyzCEubIDIr7nj3XWgCoAHMnse7l9ViUyaiGY+7eDf8YHsYdtsZzHXQFDvj0ew==
X-Received: by 2002:a17:90a:3ee2:b0:1fb:71a9:698f with SMTP id k89-20020a17090a3ee200b001fb71a9698fmr2055049pjc.127.1661481874144;
        Thu, 25 Aug 2022 19:44:34 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b00173cfb184c0sm294212pla.32.2022.08.25.19.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 19:44:33 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lu.fengchang@zte.com.cn
To:     tj@kernel.org
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        lufengchang <lu.fengchang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] admin-guide: cgroup: fix a typo in description
Date:   Fri, 26 Aug 2022 02:05:54 +0000
Message-Id: <20220826020552.239407-1-lu.fengchang@zte.com.cn>
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

From: lufengchang <lu.fengchang@zte.com.cn>

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: lufengchang <lu.fengchang@zte.com.cn>
---
 Documentation/admin-guide/cgroup-v1/cgroups.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cgroups.rst b/Documentation/admin-guide/cgroup-v1/cgroups.rst
index b0688011ed06..fa747466e304 100644
--- a/Documentation/admin-guide/cgroup-v1/cgroups.rst
+++ b/Documentation/admin-guide/cgroup-v1/cgroups.rst
@@ -573,7 +573,7 @@ cgroup_for_each_descendant_pre() for details.
 ``void css_offline(struct cgroup *cgrp);``
 (cgroup_mutex held by caller)
 
-This is the counterpart of css_online() and called iff css_online()
+This is the counterpart of css_online() and called if css_online()
 has succeeded on @cgrp. This signifies the beginning of the end of
 @cgrp. @cgrp is being removed and the subsystem should start dropping
 all references it's holding on @cgrp. When all references are dropped,
-- 
2.25.1

