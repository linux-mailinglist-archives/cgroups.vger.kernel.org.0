Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD7EB4C415
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2019 01:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbfFSXZZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Jun 2019 19:25:25 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:47108 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSXZY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Jun 2019 19:25:24 -0400
Received: by mail-yb1-f201.google.com with SMTP id u9so1066945ybb.14
        for <cgroups@vger.kernel.org>; Wed, 19 Jun 2019 16:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2Xe5CNu50mksX/zEQQqGlLiWQgOuxvE/hS5GIpxigKA=;
        b=g1it1EteZ/NGeK69zsjfHOTg9qZMabcBis5hFjOrlB2l+EFid2XH43a/H1Q98WQaN4
         EuaSsBaTPlqXmMYUHUth9G/bMVvlH6pFOoOKmzO5ypBeVy38P7a0Es8xFNAKHTRaabbw
         8raai+S+rVgHmvNm9WwaNFbh3CDbHzBDR0yc8D2i20C+AGY93ETkj7ecEaSTfenjJLSd
         fcu2WQVp0NMDR3iKV/rnrn6v8WivwS78j6PGG20RxN0RiXWs5GoTqxJGDi9W1+QRi9g4
         d0z67gIh/nncaGZD0tfYFyUqwU/UD9ePElOit5dKhGB4YOjiUpRTPlAbsW+SCWdDRbSB
         Q3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2Xe5CNu50mksX/zEQQqGlLiWQgOuxvE/hS5GIpxigKA=;
        b=Hz69gaKWrPAJVh9/XiqAXAl3gkbhF5uv+1DNDuASnmBkR46ma1EvngTKNSvbNUds9i
         oqam9LO5BaKfqLk0HG+qQC8zTiupKAKuFzwNx4ansXJaZ8CxBWYc6UQtRSTsWh19hDu3
         pBPwts+hwj7VeHN+i7w8KbZ8d6R1d+usRLiyMzXvI6QV+zpsvrUy8bYpaXuKRW9EYM/E
         XP0xY+HdnBMhd1F1sznm2vMWR6U1IjCJRZYe01YX9K/ghr3SvW5XF2Yl+OOwFWkfpqNT
         p7v4F/K1w1KYxb7BeRD0bJhFi4C1RxflW9pV9/07FN4uAt95bbK0+7rJkZz8IZOevj3L
         dcXw==
X-Gm-Message-State: APjAAAWvjvtFxPZUgbLKd2xC6j7S9VkYvjmbqOumhuICJbf/s66gF8Ml
        cqZ9Kaytr9uKIme1D015g7ICDezAh8KlRg==
X-Google-Smtp-Source: APXvYqx0Ajd3n7T85uM4Bzn0REZs50Wj6xVympn1t8+jBERmV3VKWhN1SE1iCxw29OAeOkbSedQJqpGRdieoww==
X-Received: by 2002:a0d:c485:: with SMTP id g127mr43382535ywd.405.1560986723899;
 Wed, 19 Jun 2019 16:25:23 -0700 (PDT)
Date:   Wed, 19 Jun 2019 16:25:14 -0700
Message-Id: <20190619232514.58994-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] slub: Don't panic for memcg kmem cache creation failure
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently for CONFIG_SLUB, if a memcg kmem cache creation is failed and
the corresponding root kmem cache has SLAB_PANIC flag, the kernel will
be crashed. This is unnecessary as the kernel can handle the creation
failures of memcg kmem caches. Additionally CONFIG_SLAB does not
implement this behavior. So, to keep the behavior consistent between
SLAB and SLUB, removing the panic for memcg kmem cache creation
failures. The root kmem cache creation failure for SLAB_PANIC correctly
panics for both SLAB and SLUB.

Reported-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/slub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6a5174b51cd6..84c6508e360d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3640,10 +3640,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 
 	free_kmem_cache_nodes(s);
 error:
-	if (flags & SLAB_PANIC)
-		panic("Cannot create slab %s size=%u realsize=%u order=%u offset=%u flags=%lx\n",
-		      s->name, s->size, s->size,
-		      oo_order(s->oo), s->offset, (unsigned long)flags);
 	return -EINVAL;
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

