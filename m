Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866CC153EB6
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2020 07:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgBFGYp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Feb 2020 01:24:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44949 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgBFGYp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Feb 2020 01:24:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id g3so2208638pgs.11
        for <cgroups@vger.kernel.org>; Wed, 05 Feb 2020 22:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/1bdNiZJIydaWvbrtyH2cphn9JXElXk4UNnoRdYAoVM=;
        b=S6UT1M/BpxTAsLy7VAYYrV0XE+HCnpjf5/tIb0M/BJzc81azLQsQPDULX4l0jBQ+x+
         knwojt+ABNutej6LLsdLCsKPksWVNt2QlTOXd6+WbqV9WIVBSIFD7y431wcnyqsAfJMx
         9AodrNAaKaHcGtFzrH5aix931reqqGQ1AWMObD+kF23tdZ9kGKmaI4mtRdHo6wtyxFj5
         ueUJh4NEMVWAyRS3+o9fmYyrTda2YfgThtZZrOPbEGrWxUPLbgH7W2MyivYCaa6TG7g3
         9u21VuOWj88Qb6P54JNHEtviAFqUaydn47sxv8sOdFEr1bUdBU1MVv2aJQhPIx1MJFkB
         FRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/1bdNiZJIydaWvbrtyH2cphn9JXElXk4UNnoRdYAoVM=;
        b=r+ivLTSDeSh3JZXcf7bYuWoKzjYk3bIrIg53F5113WcdwiCTz6pkqwQw28OCWcoAhw
         8oiFuAYXuk1OQWERK5PRxE5NGYVzpoPAQySHRkrM3KFLJDiSXABG3X2iZ9wTd2GdfEPH
         TIZIguJJcN1BMF7MzvbHCOvLSWiyuTUJMUoyFbJL8XAMeTRYAMcXZZSrJknZ7wS2PhZ0
         /4p+7sTr8xpXUB66PJHukEwT4iUhVXEE7//e5Tyvfy5vbsZYDdwd91bsMz+mohv8odB/
         8mNM9AsmNPSDyDYFUv1MO7fvNcr1t2/aE15gHg+hSJd+dcBwvD+4PlgNw8Mgd2YMbYxK
         bZhQ==
X-Gm-Message-State: APjAAAWxt03pX9an06ML6onjJb3JcKS2VXk8QI7McX4NUwSHmNc+aup5
        kpOxg0FnJrh1Zk9kvALRUQM=
X-Google-Smtp-Source: APXvYqwIakWMoDr+aJ+5xLAxwuk0XHTwsxRnX3XgoW2voWoUAyyMSlo5Ll/Q/fokLjEGKMb+jxXcLg==
X-Received: by 2002:a63:2782:: with SMTP id n124mr1940907pgn.188.1580970284570;
        Wed, 05 Feb 2020 22:24:44 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id i68sm1644186pfe.173.2020.02.05.22.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 22:24:43 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@redhat.com, tj@kernel.org, vdavydov.dev@gmail.com
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, akpm@linux-foundation.org,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2] mm, memcg: fix build error around the usage of kmem_caches
Date:   Thu,  6 Feb 2020 01:24:20 -0500
Message-Id: <1580970260-2045-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When I manually set default n to MEMCG_KMEM in init/Kconfig, bellow error
occurs,

mm/slab_common.c: In function 'memcg_slab_start':
mm/slab_common.c:1530:30: error: 'struct mem_cgroup' has no member named
'kmem_caches'
  return seq_list_start(&memcg->kmem_caches, *pos);
                              ^
mm/slab_common.c: In function 'memcg_slab_next':
mm/slab_common.c:1537:32: error: 'struct mem_cgroup' has no member named
'kmem_caches'
  return seq_list_next(p, &memcg->kmem_caches, pos);
                                ^
mm/slab_common.c: In function 'memcg_slab_show':
mm/slab_common.c:1551:16: error: 'struct mem_cgroup' has no member named
'kmem_caches'
  if (p == memcg->kmem_caches.next)
                ^
  CC      arch/x86/xen/smp.o
mm/slab_common.c: In function 'memcg_slab_start':
mm/slab_common.c:1531:1: warning: control reaches end of non-void function
[-Wreturn-type]
 }
 ^
mm/slab_common.c: In function 'memcg_slab_next':
mm/slab_common.c:1538:1: warning: control reaches end of non-void function
[-Wreturn-type]
 }
 ^

That's because kmem_caches is defined only when CONFIG_MEMCG_KMEM is set,
while memcg_slab_start() will use it no matter CONFIG_MEMCG_KMEM is defined
or not.

By the way, the reason I mannuly undefined CONFIG_MEMCG_KMEM is to verify
whether my some other code change is still stable when CONFIG_MEMCG_KMEM is
not set. Unfortunately, the existing code has been already unstable since
v4.11.

Fixes: bc2791f857e1 ("slab: link memcg kmem_caches on their associated memory cgroup")
Cc: Tejun Heo <tj@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/memcontrol.c  | 3 ++-
 mm/slab_common.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6f6dc8712e39..a94b1a737bc0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4723,7 +4723,8 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
-#if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
+#if defined(CONFIG_MEMCG_KMEM) && \
+	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
 	{
 		.name = "kmem.slabinfo",
 		.seq_start = memcg_slab_start,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1907cb2903c7..5282f881d2f5 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1521,7 +1521,7 @@ void dump_unreclaimable_slab(void)
 	mutex_unlock(&slab_mutex);
 }
 
-#if defined(CONFIG_MEMCG)
+#if defined(CONFIG_MEMCG_KMEM)
 void *memcg_slab_start(struct seq_file *m, loff_t *pos)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-- 
2.14.1

