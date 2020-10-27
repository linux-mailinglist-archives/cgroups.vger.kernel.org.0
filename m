Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5A29A630
	for <lists+cgroups@lfdr.de>; Tue, 27 Oct 2020 09:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501979AbgJ0IGu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Oct 2020 04:06:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43684 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508672AbgJ0IDb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Oct 2020 04:03:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id r10so311077pgb.10
        for <cgroups@vger.kernel.org>; Tue, 27 Oct 2020 01:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWIAYpPs9+svXY8PEtGZ5WZ0CNEgBLTQowd7Fmk6Ks0=;
        b=0mmq9zynkfizT4Ql1IxpOGnGDMmXfmaRO/jTjmX5y5xzgLSWldW1D0OmZmiaqfd3Jj
         uTnV/2ojetEMYoqEy6o95NADBO7FFfWXq+J8lRdeuLuCL+w6GFggpi1WoXcq7Ai0Ouln
         kMd+2CMAl09mrojtd/edMDGXtdwUoq2EPfkdkJl8IJ42pR927Gy1+02gSJnULXNN7/AR
         Tin3noEy1hSSySrqkHSsnkchL+m1SAd/NAdjV9jF1hVqVfziOhHfoalcTD5MZA+F0CcN
         Wsvz53aafL+3Nhw88pYQat+6bd/CjXTZhks3P7F+G145xKZfz8Ji/eNFy8hAV5ap0QgC
         lJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWIAYpPs9+svXY8PEtGZ5WZ0CNEgBLTQowd7Fmk6Ks0=;
        b=m0Ka3g7ExeaPiBdbW/dJ1bd9Diz4z8c1GGi2Yp3IYiJqSnSjZb8Z9BkEblRK+tvZFb
         9DBFEh7vH8MkDrkXkoOHUu8nvwTlfMfsdbBCnxyF0yeINr9EoJS76sTzEGdrH56T3Z48
         sUaMSyb0i8JuMI0IjmJZZ8a6qn7IN08Ei1sb3zdgkzFgDq5N5xJmfBO9z23KJFvf1g0S
         jCi76B0Jll2ycKeBkblYtPmzM13fMGC4d45pWUXikeJeYB3Wd941ec/I/KqPTCyyXs8P
         rFxpVhSSSVnNzGMR6UxKEseP9f64qr+zHIfE+sq+U2vC2SOiX0ibRqvP6/zJOXofHkoe
         1oqg==
X-Gm-Message-State: AOAM530ZTYY3F9PS7V3L6zl9UULsh6Q9baY5KumJJVtIP7DYx57+wrAt
        95N6aLJybpwXZhtxxPz+mu1pmA==
X-Google-Smtp-Source: ABdhPJz1hfXJG1lmVYIhQsXjHZGILbCTSJSIyuvmPZNDlDiLd4f3AkFLLlZK7QOTjOFm2stL4K/P9g==
X-Received: by 2002:a63:5421:: with SMTP id i33mr938048pgb.316.1603785810689;
        Tue, 27 Oct 2020 01:03:30 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id p8sm1039580pgs.34.2020.10.27.01.03.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:03:30 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        iamjoonsoo.kim@lge.com, laoar.shao@gmail.com, chris@chrisdown.name,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, keescook@chromium.org, tglx@linutronix.de,
        esyr@redhat.com, surenb@google.com, areber@redhat.com,
        elver@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/5] mm: memcg/slab: Fix use after free in obj_cgroup_charge
Date:   Tue, 27 Oct 2020 16:02:53 +0800
Message-Id: <20201027080256.76497-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201027080256.76497-1-songmuchun@bytedance.com>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The rcu_read_lock/unlock only can guarantee that the memcg will
not be freed, but it cannot guarantee the success of css_get to
memcg. This can be happened when we reparent the memcg. So using
css_tryget instead of css_get.

Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fcbd79c5023e..c0c27bee23ad 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3223,8 +3223,10 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 	 * independently later.
 	 */
 	rcu_read_lock();
+retry:
 	memcg = obj_cgroup_memcg(objcg);
-	css_get(&memcg->css);
+	if (!css_tryget(&memcg->css))
+		goto retry;
 	rcu_read_unlock();
 
 	nr_pages = size >> PAGE_SHIFT;
-- 
2.20.1

