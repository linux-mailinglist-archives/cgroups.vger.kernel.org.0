Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B6645FF80
	for <lists+cgroups@lfdr.de>; Sat, 27 Nov 2021 16:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243723AbhK0PEx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Nov 2021 10:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhK0PCw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Nov 2021 10:02:52 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28992C06173E;
        Sat, 27 Nov 2021 06:59:38 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y13so51142216edd.13;
        Sat, 27 Nov 2021 06:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DUa+iyqQFoJCh85Xx5S5yIjQywwrD3DfTPEYMfJnePI=;
        b=IV8FhjwGkFzEgsoXII9eGrWzVHjEaXWRN69iJiFJjhAX/kTN5xHcBw2Iqw4sKvP7gO
         rbTgoaOSEo/d2JeSeOLnmIWox4CRXLhvsYOeASh3JUaed10kfpGtRmCKHDKG6lQDuGGm
         7om0B3fYCm/W3gkkWo4VY8yklz3w0/BuBNBE/bfF4vmI3qXhy7C4nToQJc34NLBPRC/l
         W8mT+ify/i4Oe+enAYROQcr5kM5eWKU6lCh5Jjq+ojAlkx5abgm2b13nV0L2U3MfwHyQ
         5Z7KQWlzP1kGiHbSUCFgocXai/PX+r5mZbTJ1tZiXRM8hN0ne/ApMxPuztPDdqa7AO7n
         u3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DUa+iyqQFoJCh85Xx5S5yIjQywwrD3DfTPEYMfJnePI=;
        b=eCxfnqESa5JHXTfbVMtwld+ujQZFjwCj8Y2Nil5XTtrNpATq/PiUzhxlKPPJi+rgol
         lZFYAVWNT3xqjFv2Kw8qS40PQt9esbGTHJzZceyBp/XeFw4MMNc1p7MQHp/nM+/nhU+5
         858uZfJT9HD4D2Wzgpzh8Tls56hh/iBNxlrP7e7FDaJrJOdvTxN0vQM40yJuMKByqQkn
         1C7/7jNSTlWMHDolkfid9SJONAGR81lFfOS2bD84W7JfM6rSyxBo9gVyhKKFB8rFxycp
         UIW0cLH+37et/EwUWcfn7pSgguzTD3qVG/vSXwxr7/3CFoXueZVIazpYaV/s+PWSaX4J
         2eKQ==
X-Gm-Message-State: AOAM533/HUh/a1ZGdp7JVk9D/5NR1pfp/H6+4yfd3YhUe7m+auBgAzHb
        YwW+xwE4VAtNMkGUMT0HLKQ=
X-Google-Smtp-Source: ABdhPJyQO83LGR4Jszg8uEaH7ZR2GyUi/R6JtEhsXiiiWvGFj14g9bShIaNszzhbPTsQB01LmQKBhA==
X-Received: by 2002:aa7:c78f:: with SMTP id n15mr57798879eds.344.1638025176706;
        Sat, 27 Nov 2021 06:59:36 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id w24sm4568159ejk.0.2021.11.27.06.59.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Nov 2021 06:59:36 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/2] cgroup: get the wrong css for css_alloc() during cgroup_init_subsys()
Date:   Sat, 27 Nov 2021 14:59:19 +0000
Message-Id: <20211127145919.31159-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211127145919.31159-1-richard.weiyang@gmail.com>
References: <20211127145919.31159-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

css_alloc() needs the parent css, while cgroup_css() gets current
cgropu's css. So we are getting the wrong css during
cgroup_init_subsys().

Fortunately, cgrp_dfl_root.cgrp's css is not set yet, so the value we
pass to css_alloc() doesn't harm to the system.

Let's pass NULL directly during init, since we know there is no parent
yet.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dffef5836ff7..452a723d4a36 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5709,7 +5709,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	/* Create the root cgroup state for this subsystem */
 	ss->root = &cgrp_dfl_root;
-	css = ss->css_alloc(cgroup_css(&cgrp_dfl_root.cgrp, ss));
+	css = ss->css_alloc(NULL);
 	/* We don't handle early failures gracefully */
 	BUG_ON(IS_ERR(css));
 	init_and_link_css(css, ss, &cgrp_dfl_root.cgrp);
-- 
2.33.1

