Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178285929ED
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 08:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbiHOG5v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 02:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiHOG5u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 02:57:50 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5DC10552;
        Sun, 14 Aug 2022 23:57:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f65so5821370pgc.12;
        Sun, 14 Aug 2022 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=gMw/e7nL3q8loyP6pDu1lcY4dhvsIg+AhMS6bilhZas=;
        b=SIQSKrhy7gSmBOGc2IwKJZ2KWeUd3CxvB6oVpapceFGs7jdaDf2mvBy2KNPEYXeA67
         oRtotJEWrCBkFc984f9vjq77D1b+ZSxmMaot5fqUAWhq3s3xwiX6v+Da1A17HfIH/P3c
         3vVa02JZO1ainbWvo1sTC6F5v9iSJMmqEuPdwIG0RulYObUbghvid9GOgBLRwWXyXiKw
         PqFhTTnjPeWTK5TZvrvDHNPIdIeXQKOH5HzEL/zp47iY+d6pGOFQ4PMqJ5N0KEscZmeZ
         qTJlixioi05WPAGs/gt82s4MIxqv1lOMI79IADTY9Y8+GNDD134BV6XaG5u3ryahqBdS
         V00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=gMw/e7nL3q8loyP6pDu1lcY4dhvsIg+AhMS6bilhZas=;
        b=JbFGqNwy0CPF8YwgOK6n5f3xurYa82Te77HjLGO8WpPZFlqpbb2Yhmb4zg/9mS9QYd
         ZL2PTgTiXG0mxffhpymtqS43iMsgap4zUTGmco97TnDwfEA39IBKLQnlaWSjWJjbv4yG
         VMPWTMrYbaa9mv6SwX3i2h496F9zEFqGmJXx1kh66Co26fmVexO2GMbxhHKzL41vkU5F
         cb5Pb30OAS1RKUIXfg8Nkr4eZqWYVStF6wHWGHyBSAl1Npl7Jr949TqyrEoE8J3FZY+R
         C3nnif98bG8UyH4N4Q6O0T496Ze3sijYRtdSpIkJT3dIdFaHPrqTKZAXPS92QznhFLp0
         El9Q==
X-Gm-Message-State: ACgBeo3wZ1b481GxTQXtV4GEN/XBugzDZFddHvzklxAb/aR4hES7IrCP
        YoPU9gUtSb01/OOKrOotHWI=
X-Google-Smtp-Source: AA6agR4Gj5H2V5smEr+ke8WMabYxe5zWD4CPihq3mkCVEAsQNXUIBdgL3M9RloEgbv8qau4PKcy9/Q==
X-Received: by 2002:a63:88c8:0:b0:41d:260c:ea29 with SMTP id l191-20020a6388c8000000b0041d260cea29mr12644539pgd.284.1660546669131;
        Sun, 14 Aug 2022 23:57:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id dw3-20020a17090b094300b001f312e7665asm3981501pjb.47.2022.08.14.23.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:57:48 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     hannes@cmpxchg.org
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xupanda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH v2 linux-next] mm: memcontrol: Fix a typo in comment
Date:   Mon, 15 Aug 2022 06:51:04 +0000
Message-Id: <20220815065102.74347-1-xu.panda@zte.com.cn>
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

From: xupanda <xu.panda@zte.com.cn>

Fix a spelling mistake in comment.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xupanda <xu.panda@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>

---
Change for v2:
 - fix wrong title
---

 mm/memcontrol.c     |  2 +-
 1 files changed, 1 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ced5..4dddd8be320a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1143,7 +1143,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 	} while ((memcg = parent_mem_cgroup(memcg)));
 
 	/*
-	 * When cgruop1 non-hierarchy mode is used,
+	 * When cgroup1 non-hierarchy mode is used,
 	 * parent_mem_cgroup() does not walk all the way up to the
 	 * cgroup root (root_mem_cgroup). So we have to handle
 	 * dead_memcg from cgroup root separately.
-- 
2.25.1

