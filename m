Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2345F420796
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 10:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJDIv2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 04:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhJDIv1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 04:51:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD540C061746;
        Mon,  4 Oct 2021 01:49:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v18so60920491edc.11;
        Mon, 04 Oct 2021 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U+CztsD4lUTfyz/9KUwv0lAPbgM6DhNn+yw+6hcN6o8=;
        b=Dbjki+3nMY172s6qwBDLQhjVjWRsINQvJ6c/Y1HBr6z7e/LkaWJLejV73MWWBxYFC4
         Aj32cwVL2nb3FX5N1xoiWMNd7RiSVvIX6z9cEBBU9s3q5976Xc0taZo18Guvw7unbUcf
         HYB2dK5zMMgfBrqCtoiF4gUDPUVgQWWikxNBU3NlTgLOm8+3DEzKkJo5fo4N+GjnbUmo
         qqW3LyR2pvr9b9WNzAtnPGCJrl5jzX9Ua/GQvaQVPESXpmHtbPHqnwDSwTzg8OKFeIW3
         1my4tSBVH89PkNpEiusb0eTDpfTI2br07hu9fAsHwOktH9deXdCMnzDQXnHk+P4nN28r
         7NLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U+CztsD4lUTfyz/9KUwv0lAPbgM6DhNn+yw+6hcN6o8=;
        b=Wm/WwxJ7yNQBXpcW5eL2mbAJsjirKgkeVt3ROHSHHMK9GGjYLJVTUQefLgTYf8dX6q
         zS29xy6+T57IEF6LXt+WHiGF8n1n/EaUFQ4WmdeqCHyMF7xnhNsasKTQPmy6ddTmwbZl
         ktNLLotJIi2JLTxYHUflJOdPGzu2yKHxp2qmybqzXOG99wk+nW6Xqm72BaOrDFfGgdUp
         xPjn2LQcwxmg1IQh/NPRNS7kmdKBjUJfYG6YDqh2WiuzFfbdW/Vn8OxWlQc3UrSxLCaO
         yk0f9RTMOFXyoajkuYQYZvoiaNv3Wo01S4FnT9yQ/q25ojddm+eeaE7LCfhRu1TBuMzL
         uIbA==
X-Gm-Message-State: AOAM530T9gScmqSnJzrqC8t60pEmL+tIWKpI93cNeHRZWWUgdjPpqzoX
        TRKwhYpQi0xiKumvJQ0vHMM=
X-Google-Smtp-Source: ABdhPJxL00+oKEP0I5vZCtIR6Sz8csGZAeIHzC5GrLF2U7RP71mCtnDYbLdR8u4bwLS5hutmzWSRMA==
X-Received: by 2002:a17:906:7ac4:: with SMTP id k4mr16388755ejo.430.1633337374959;
        Mon, 04 Oct 2021 01:49:34 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id r3sm209311ejr.79.2021.10.04.01.49.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Oct 2021 01:49:34 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 3/4] cgroup: simplify the cgroup descendant helper
Date:   Mon,  4 Oct 2021 08:49:27 +0000
Message-Id: <20211004084928.17622-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211004084928.17622-1-richard.weiyang@gmail.com>
References: <20211004084928.17622-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup_for_each_live_descendant_[pre|post] use cgroup_css() to get the
root. While since the 2nd parameter is NULL, cgroup_css() always return
cgrp->self.

Let's simplify this a little.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 570b0c97392a..457353aeb0ca 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -732,7 +732,7 @@ EXPORT_SYMBOL_GPL(of_css);
 
 /* walk live descendants in pre order */
 #define cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp)		\
-	css_for_each_descendant_pre((d_css), cgroup_css((cgrp), NULL))	\
+	css_for_each_descendant_pre((d_css), &(cgrp)->self)		\
 		if (({ lockdep_assert_held(&cgroup_mutex);		\
 		       (dsct) = (d_css)->cgroup;			\
 		       cgroup_is_dead(dsct); }))			\
@@ -741,7 +741,7 @@ EXPORT_SYMBOL_GPL(of_css);
 
 /* walk live descendants in postorder */
 #define cgroup_for_each_live_descendant_post(dsct, d_css, cgrp)		\
-	css_for_each_descendant_post((d_css), cgroup_css((cgrp), NULL))	\
+	css_for_each_descendant_post((d_css), &(cgrp)->self)		\
 		if (({ lockdep_assert_held(&cgroup_mutex);		\
 		       (dsct) = (d_css)->cgroup;			\
 		       cgroup_is_dead(dsct); }))			\
-- 
2.23.0

