Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3D1535E0
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2020 18:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgBERDy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Feb 2020 12:03:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42699 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgBERDy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Feb 2020 12:03:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id w21so1249574pgl.9
        for <cgroups@vger.kernel.org>; Wed, 05 Feb 2020 09:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BpKT67FLDttHow1r3K4wuKV8cB597M2lQmxM3PivZvk=;
        b=brNPJ8bc7c6wFuqJgrS1FFBkILkxYNu0YhqjEyJ1g6cXJT7J7RE1XxdExWiWTzVNQ2
         O16cxlFkBHFKZAdktZey/jmg6fFkZ393oJzaucgu9b8RGTBsTVlIHogCWnIw61Sg2yGu
         OdKiBSAx+cx2fGz9i5Lny5MWk+HwwyxwAicOtQ27Jf3PVoy21aOiJPxGG7qvtx805Ixi
         b+m5JOOUL1SI5HIQ5rhWj5JDMJXGEoTwcU7gSB5RKAmN6y09v+pYZtUyqmjzgI2NnutI
         eAadYYs8sScqxUHq1dOfRz6EMyFO8F/qMMatvhbXRCInJZcGuKBfleOiEc0lCCzbgcsJ
         /G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BpKT67FLDttHow1r3K4wuKV8cB597M2lQmxM3PivZvk=;
        b=cSVFyLppxF/IVtyffldroCdmZvIbX9xHRpT/wsLK4ffeFxXoyfNnVg6t588mrJ8AZi
         6xbhvfxdpORFEggyj7Hoe/184S/ZCBRV7FPcW0dsjJK/UPSy9cJlS6ii138EhlqCv1Uo
         vDMsf97UCafqrW/eS6OASID/FcdiJclZczOxCllQxWDEcn02SrCyhZNVsTNz65O409s3
         b4m2NDNFD4VqDr1mVjVufacND8DKrgTCKpcAgFNW1GA3Wrl8nzOTt/P9BhPDj+Gk+Gly
         VmB4zUcAXsghqdeLyn1iU/+MAwRh4UaMQ/v8OSgiBMXHYjf3af0JvKAhrKXJiTggdffw
         WAYw==
X-Gm-Message-State: APjAAAUOfwzv6Lk6ygAw7Va+4tPv4NDv5S+tedhQ4jne6W8qy63KzUlm
        H04U0IZdl+ap+X1HE493Z+0=
X-Google-Smtp-Source: APXvYqxn6FeaB04gqdT1mPp5BP8n4x4iJSO9O3ISmNzIV2riJ/yQZ+OASfMH90A2V1+KNeE4TTkVuA==
X-Received: by 2002:a63:d658:: with SMTP id d24mr23059303pgj.73.1580922233345;
        Wed, 05 Feb 2020 09:03:53 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id i3sm51209pfg.94.2020.02.05.09.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 09:03:51 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tj@kernel.org, vdavydov.dev@gmail.com
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, akpm@linux-foundation.org,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] mm, memcg: fix build error around the usage of kmem_caches
Date:   Wed,  5 Feb 2020 12:03:35 -0500
Message-Id: <1580922215-5272-1-git-send-email-laoar.shao@gmail.com>
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
 mm/memcontrol.c  | 2 ++
 mm/slab_common.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6f6dc8712e39..43f0125b45bb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4723,6 +4723,7 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
+#ifdef CONFIG_MEMCG_KMEM
 #if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
 	{
 		.name = "kmem.slabinfo",
@@ -4731,6 +4732,7 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.seq_stop = memcg_slab_stop,
 		.seq_show = memcg_slab_show,
 	},
+#endif
 #endif
 	{
 		.name = "kmem.tcp.limit_in_bytes",
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

