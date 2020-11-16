Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93CC2B3CB1
	for <lists+cgroups@lfdr.de>; Mon, 16 Nov 2020 06:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgKPFu4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Nov 2020 00:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgKPFuz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Nov 2020 00:50:55 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D888C0613CF;
        Sun, 15 Nov 2020 21:50:55 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f23so22759889ejk.2;
        Sun, 15 Nov 2020 21:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bMCt60rqT+zbnmmu8mIiXqNzcowO0BqJlZFilJ3Doeo=;
        b=l2N6UPXztssB0BIvdQTVtoH2uBhHn7UeL7GZOqiJHymxU/o40kBJboG/xwwJ0dZ+cw
         n1KO2j8bOsgqGfSu/Gks3g2zXimC/L45Zq1Vtw6IBhErbes7kYBG5Z4+iwogQJxm56yX
         8eJtxaKvCz6uHpp/6j8Ow/A7n9mAFktsHac1tWj8Ihzt3aglcMo9yjTlUknFm5aaH2nW
         P3zfAIHUMuCP7T4vWeYCZL/dh4UbYvnzwzQrRAg97uqoMX4cfjg4Y+Rvz/Mx5rPpLvon
         KKdJ0tN6fWaK8sA144XP8eVvWUUAA4FY8HKz+VyprSzyZ8VqEozquOocB26xYFvnFQj+
         OvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bMCt60rqT+zbnmmu8mIiXqNzcowO0BqJlZFilJ3Doeo=;
        b=rqG7jxH8bLfItl64K/bp49UdV9xrcswWePumTqdPM3kgOTZ5Owy4EMUFiXI0rp2AF1
         D3rzzLD9aBlFC4e6CCv/iPWpozkpH94oXzQmrQOrQmB21TVO4C0OK5AcH13XoCGGDXnV
         Bk3StGw08CMVRDrh9Y2jD7IYphpHIAtX+OZMXKi+G15hdbuQZoWjee0i5CreFVA9aKu8
         RXcGYVyDCn3Q7ZEj4D8bT+utjYi9qzcD9jjnDIWroqSTi61rjzqBp7Ipy513oNjLGN1p
         0mvo+DXZmPzbLQ5ZtNok0doKfIYWv9BL3CcRcb6atMUpW/ZsTwLOVPnmGLfwajN3Dlug
         LWvQ==
X-Gm-Message-State: AOAM532COiRhhp+K1DUK2H9yVLFF1laFz5KXMC/1V84lBXBl9/9GjPHJ
        rl7EwKOUKHzPmIAZKHmfQb8=
X-Google-Smtp-Source: ABdhPJxZbKUtzcgQIOuCyBy7CGfW5JkOEuHKZALohI5J1FH2WeJ62lL9BDzOSL78BB+LKiR25Ex7Hg==
X-Received: by 2002:a17:906:3294:: with SMTP id 20mr13143545ejw.239.1605505853911;
        Sun, 15 Nov 2020 21:50:53 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de6:ad00:939:47a9:70b9:fe5b])
        by smtp.gmail.com with ESMTPSA id h24sm9907059ejg.15.2020.11.15.21.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 21:50:53 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] mm: memcg: remove obsolete memcg_has_children()
Date:   Mon, 16 Nov 2020 06:50:43 +0100
Message-Id: <20201116055043.20886-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit 2ef1bf118c40 ("mm: memcg: deprecate the non-hierarchical mode")
removed the only use of memcg_has_children() in
mem_cgroup_hierarchy_write() as part of the feature deprecation.

Hence, since then, make CC=clang W=1 warns:

  mm/memcontrol.c:3421:20:
    warning: unused function 'memcg_has_children' [-Wunused-function]

Simply remove this obsolete unused function.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20201113, not on current master

Roman, please ack.

Andrew, please pick this minor non-urgent patch into your -next tree.

 mm/memcontrol.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f95ddb3e9898..d49d7c507284 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3415,19 +3415,6 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 	return nr_reclaimed;
 }
 
-/*
- * Test whether @memcg has children, dead or alive.
- */
-static inline bool memcg_has_children(struct mem_cgroup *memcg)
-{
-	bool ret;
-
-	rcu_read_lock();
-	ret = css_next_child(NULL, &memcg->css);
-	rcu_read_unlock();
-	return ret;
-}
-
 /*
  * Reclaims as many pages from the given memcg as possible.
  *
-- 
2.17.1

