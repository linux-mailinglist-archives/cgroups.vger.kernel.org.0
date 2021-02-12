Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BD331A334
	for <lists+cgroups@lfdr.de>; Fri, 12 Feb 2021 18:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBLRDL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Feb 2021 12:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhBLRDE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Feb 2021 12:03:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9ACC061788
        for <cgroups@vger.kernel.org>; Fri, 12 Feb 2021 09:02:24 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d2so757882pjs.4
        for <cgroups@vger.kernel.org>; Fri, 12 Feb 2021 09:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uMiCMlqqsGt4v3DIDBbc5Tzpa+oMrTR3N8I/PD9p2nk=;
        b=NmStyGwgQEnVNrqN5Ubtgd25sYfpL8IXtOClOXbtc4s/sjMIQFqvb31t0DYjJZidM1
         gCU3y8v0DWb3bByea+46x2tO/zxaZI0DLjF8Y1CVsBZu6wD68sRHZXdAlzW5+0pqOwTT
         TM3Jb8qnl9xOL4mWSIZj8Q1QL2ERlMxEY4F9uzUa1wjlotEQZKxZVjviz3OXd8WsF/Rg
         jFVabi1XtYlsOwbqnSNgovnWpCfmsOpZKBCmrxZU1f8vkqYrTp2sVvrX738HsEIw8MFn
         blBu6Yfthn9vxzvgemOvsKgO0ZWZHZw99ZIC5oXvfM3NPLKZaY4jXeVvJfxkeLuu24Wy
         6/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uMiCMlqqsGt4v3DIDBbc5Tzpa+oMrTR3N8I/PD9p2nk=;
        b=JUvqSa7Xi6CiNhPwRDyvujsHROJ8M5Ipy9dfsB7ov2W70AOxzBs3pBinVWgafhVgZ0
         6nLNlXHO/dgirf96N9BSKgCrfvOrsJKeAayeXv7hWzMEroO7i6x/+lP8tr+pButZMMlH
         07MHrJ2Q5jivgscKrR7AefX/V4OpXm4dnHnOCobE7u3au4sRRi3QZvmWytR2eBdpUeLY
         3ofu7hND/BQSfqBSHba9RlqCfCFUNvNK5UPJiCRFG4BzH87Y+0cYVyAnd8rtSAnFy38F
         ozzNbeywLIuBsIRI4uhe2pxezbwwLhOvn820ATq+E1Rwhjaq1vqBnv6xUOptxOt/Jf4Z
         tJSg==
X-Gm-Message-State: AOAM5316HyhJi+rIzeUK5vfj0y7jUCP3GOvAHJyidE8n+Jd4YaG/4J8M
        A4Fr7Gn26E8DNoQiX1weYLniwQ==
X-Google-Smtp-Source: ABdhPJzNZ8r1f8u/Wzepj9mLIFlxDAW2JOdq6rVUNEpN5TjGRjw0rdpCvkeGjJveQHXo8f+etJVqEw==
X-Received: by 2002:a17:902:d886:b029:e1:7784:4db5 with SMTP id b6-20020a170902d886b02900e177844db5mr3677168plz.72.1613149344235;
        Fri, 12 Feb 2021 09:02:24 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id e21sm9317815pgv.74.2021.02.12.09.02.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 09:02:23 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/4] mm: memcontrol: bail out early when id is zero
Date:   Sat, 13 Feb 2021 01:01:58 +0800
Message-Id: <20210212170159.32153-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210212170159.32153-1-songmuchun@bytedance.com>
References: <20210212170159.32153-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The memcg ID cannot be zero, but we can pass zero to mem_cgroup_from_id,
so idr_find() is pointless and wastes CPU cycles.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a3f26522765a..68ed4b297c13 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5173,6 +5173,9 @@ static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
 struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
+	/* The memcg ID cannot be zero. */
+	if (id == 0)
+		return NULL;
 	return idr_find(&mem_cgroup_idr, id);
 }
 
-- 
2.11.0

