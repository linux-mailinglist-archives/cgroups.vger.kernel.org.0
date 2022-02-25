Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17E34C3A60
	for <lists+cgroups@lfdr.de>; Fri, 25 Feb 2022 01:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiBYAfP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Feb 2022 19:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiBYAfN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Feb 2022 19:35:13 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A17029F435
        for <cgroups@vger.kernel.org>; Thu, 24 Feb 2022 16:34:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w3so5204760edu.8
        for <cgroups@vger.kernel.org>; Thu, 24 Feb 2022 16:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S87rTjKN5bfLSWPPikhQAx5WdDBuNstKMGrhVDOGPDk=;
        b=PN2wcsqgc+wbNZTHug2Cw1wY8pOFK7Hpan6j6WTlSX5V9URldyHCNJkFFGWSZ7PlJ/
         A/DzETsq2Ts1WOB3cSzjv61qGt7yBLz0RfXfRgiACddXKDki8cq8tDbYZXwgxe8vpgLX
         uv3kB74ECDqTy3bLUkKnRSNnRo0fYx+lp3rrO6f0kzyZr2JInCpgHY9TrZcDOLznVzIr
         mIm2ZnByOOX4kpajylS6pPLOqY8zXihSAtBDBLE5NZX4ieRcM8CSRg0xEzPhfbzyT+mM
         oiJZDXxDbZbjj/I1PNYWkgY8BNjz6s7i1T6cfxQNoodJgX9z9AoOX7Bg9PvjBlbtAb47
         gCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S87rTjKN5bfLSWPPikhQAx5WdDBuNstKMGrhVDOGPDk=;
        b=wC0Am7ca4E0cIwEBSF7B7Y+bbaBl+Z3CTgFzznLNKzUJgwixO7mWB/cgzo2Y1eGaJq
         VVlYyDTKL/g6c39JJqrvVa8LJCI3KsaYM1MFpRa/W7Qgx4/RPcqs6JYYE7zIysAZP24Y
         WBP1M90CgFXBn9VNoCuSm9kvuorNM+4cADem7O4hW8UEFNORV35J/GoehlzyiwsziEi2
         FBykN1Q81AAxVd9FK1IBmB5ShMRkVi8XR9Q1YeZ+9jCozutzP967c7vOrP0L40EmOVqB
         /QHk9yeK6dPESDrCK798hL054M6Iyjjm0THFQtnFjRb/97SG/Z4hheXobOgvJGg3zXz4
         6iKA==
X-Gm-Message-State: AOAM533yWXesWMElvZFMg3ZV2MMVaMJJs0i7HBs+j5KbdHys7q40DT1m
        Q/m/2WrCoBURDcT3uh0sUlg=
X-Google-Smtp-Source: ABdhPJyO23TMTH2aYds++piBZiCTWAzo1M4Tw77mM4ZTQSZeiryiZ5eLosIY3YK/+g8vi+5AEs+81Q==
X-Received: by 2002:a50:bf0f:0:b0:410:c512:cb6f with SMTP id f15-20020a50bf0f000000b00410c512cb6fmr4702289edk.262.1645749281060;
        Thu, 24 Feb 2022 16:34:41 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id j18-20020a50d012000000b0040e3ea64d4asm524845edf.31.2022.02.24.16.34.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Feb 2022 16:34:40 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/3] mm/memcg: set memcg after css verified and got reference
Date:   Fri, 25 Feb 2022 00:34:35 +0000
Message-Id: <20220225003437.12620-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220225003437.12620-1-richard.weiyang@gmail.com>
References: <20220225003437.12620-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Instead of reset memcg when css is either not verified or not got
reference, we can set it after these process.

No functional change, just simplified the code a little.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/memcontrol.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 36e9f38c919d..9464fe2aa329 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1040,15 +1040,10 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 * is provided by the caller, so we know it's alive
 		 * and kicking, and don't take an extra reference.
 		 */
-		memcg = mem_cgroup_from_css(css);
-
-		if (css == &root->css)
-			break;
-
-		if (css_tryget(css))
+		if (css == &root->css || css_tryget(css)) {
+			memcg = mem_cgroup_from_css(css);
 			break;
-
-		memcg = NULL;
+		}
 	}
 
 	if (reclaim) {
-- 
2.33.1

