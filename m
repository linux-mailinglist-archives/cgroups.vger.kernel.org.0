Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9556D4ED05C
	for <lists+cgroups@lfdr.de>; Thu, 31 Mar 2022 01:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242691AbiC3Xte (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Mar 2022 19:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351869AbiC3Xtc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Mar 2022 19:49:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2F165D34
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 16:47:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so44589990ejc.7
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 16:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6FJnqnKyYiDxw5+zHvmYhDEIHbsPH/AeIDmnSnqcv8U=;
        b=o5aWz+8c0XSKHv66RUMiIoR/ArVLQsHrsbZ9viJiWDel0QYolsZo+3P9o/TlWTdErM
         VM6LJrjtXVstBK+E+JwFdt37ex4X7hoR19Pnhxcnckr3VmFzG6JzVC6Fw+zBSi490HwX
         ZYiKTzS5tmQa16DJPiF7Dl5GiNAHQnXVF/DOUdjlxt/zPutCxvoWRnB2tsDK1yPy9gRu
         xU3yvDN9PThnJQVF2S053ymA5I4eqRir0mck8ma8Y8JW3FMWOU1adRcAFqn5DxCl4an1
         glGeCvdWJOYmXzxxyc5qx08I1hzkYp2UtU+6l+Ah+4sc/q/Bad87aiQ4K4JliZ2OyhJj
         5yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6FJnqnKyYiDxw5+zHvmYhDEIHbsPH/AeIDmnSnqcv8U=;
        b=Sb7wDondXUXd1bqw3olUJtzstYLxPOX1C4ohCsFWoo2IRjIf2DkZBs4kNIde9fjxTt
         emb+O/o77N5fAL/6YBcgJdNgxNyyMLPM1gJrFbuSD3N4BY0neVmzroAIIaWVnUnbnIXr
         beZQz8b4Zy4tg/XupO6nruJn4VE+iuNyTZG4lsZS112j7hoFc6E/A8DXZECCl5kTxhrx
         5AqWpGXmNfLQFyqwhTYxNwFGBGk9xgYeQDjJuzIliDFGjB2+NCSJX9cVBY+3mg64/dDN
         APZ3pdK4+kTtpMS0a/IvjVdMGT+0Vmlrtwe+74Wu/ubLxenTKiZkO6te0tF5lmnfob04
         +ihw==
X-Gm-Message-State: AOAM531f4GYPtkqslU3INYY8SInewdYi5tgDD2mBSNloTIEuzdQ1sPKB
        yEDMl37uJFxJQ5cBn7LLCKI=
X-Google-Smtp-Source: ABdhPJxYEItkqfh9mvC3TLsa/vajXERsHMYaAPlapmfd0q/6wb4IpuO77RspaKpXhGMU7MJtoQQUOw==
X-Received: by 2002:a17:907:2d88:b0:6e4:9a7f:9175 with SMTP id gt8-20020a1709072d8800b006e49a7f9175mr2316911ejc.584.1648684063395;
        Wed, 30 Mar 2022 16:47:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id b3-20020aa7d483000000b00419209d4c85sm10271351edr.66.2022.03.30.16.47.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Mar 2022 16:47:43 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 2/3] mm/memcg: set pos explicitly for reclaim and !reclaim
Date:   Wed, 30 Mar 2022 23:47:18 +0000
Message-Id: <20220330234719.18340-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220330234719.18340-1-richard.weiyang@gmail.com>
References: <20220330234719.18340-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During mem_cgroup_iter, there are two ways to get iteration position:
reclaim vs non-reclaim mode.

Let's do it explicitly for reclaim vs non-reclaim mode.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2: split into two explicit part as suggested by Johannes
---
 mm/memcontrol.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index eed9916cdce5..5d433b79ba47 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1005,9 +1005,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	if (!root)
 		root = root_mem_cgroup;
 
-	if (prev && !reclaim)
-		pos = prev;
-
 	rcu_read_lock();
 
 	if (reclaim) {
@@ -1033,6 +1030,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 			 */
 			(void)cmpxchg(&iter->position, pos, NULL);
 		}
+	} else if (prev) {
+		pos = prev;
 	}
 
 	if (pos)
-- 
2.33.1

