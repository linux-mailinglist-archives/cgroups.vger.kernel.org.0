Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEFE1BB23C
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2020 01:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgD0X4x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Apr 2020 19:56:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34905 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726398AbgD0X4w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Apr 2020 19:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588031811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=qCIbPd4z+LsfKk+IqgZJljs6Wparbj+tB3otWihkQ10=;
        b=Bx3jM5Mcv+ejkUcUJsMHp79kfoeQ1CXgBM2qcLexgKkcbfv0crGVy2cIzoYIv9XjS7PV7X
        11Bq/FxJpXNOhv6UsiY53pOrChnuycYdYdaXvxluVITKJ5nSNJaHpPkZu8/f+uh9XfaITA
        HPhXhABHKa0paY6B7YFgFVsdq9FelbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-t_m2IxUVOyyRbN5EYA7WrQ-1; Mon, 27 Apr 2020 19:56:49 -0400
X-MC-Unique: t_m2IxUVOyyRbN5EYA7WrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E899C180F12C;
        Mon, 27 Apr 2020 23:56:47 +0000 (UTC)
Received: from llong.com (ovpn-112-176.rdu2.redhat.com [10.10.112.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A89D60C81;
        Mon, 27 Apr 2020 23:56:46 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Qian Cai <cai@lca.pw>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/4] mm/slub: Fix sysfs shrink circular locking dependency
Date:   Mon, 27 Apr 2020 19:56:21 -0400
Message-Id: <20200427235621.7823-5-longman@redhat.com>
In-Reply-To: <20200427235621.7823-1-longman@redhat.com>
References: <20200427235621.7823-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A lockdep splat is observed by echoing "1" to the shrink sysfs file
and then shutting down the system:

[  167.473392] Chain exists of:
[  167.473392]   kn->count#279 --> mem_hotplug_lock.rw_sem --> slab_mutex
[  167.473392]
[  167.484323]  Possible unsafe locking scenario:
[  167.484323]
[  167.490273]        CPU0                    CPU1
[  167.494825]        ----                    ----
[  167.499376]   lock(slab_mutex);
[  167.502530]                                lock(mem_hotplug_lock.rw_sem);
[  167.509356]                                lock(slab_mutex);
[  167.515044]   lock(kn->count#279);
[  167.518462]
[  167.518462]  *** DEADLOCK ***

It is because of the get_online_cpus() and get_online_mems() calls in
kmem_cache_shrink() invoked via the shrink sysfs file. To fix that, we
have to use trylock to get the memory and cpu hotplug read locks. Since
hotplug events are rare, it should be fine to refuse a kmem caches
shrink operation when some hotplug events are in progress.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/memory_hotplug.h |  2 ++
 mm/memory_hotplug.c            |  5 +++++
 mm/slub.c                      | 19 +++++++++++++++----
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 93d9ada74ddd..4ec4b0a2f0fa 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -231,6 +231,7 @@ extern void get_page_bootmem(unsigned long ingo, struct page *page,
 
 void get_online_mems(void);
 void put_online_mems(void);
+int  tryget_online_mems(void);
 
 void mem_hotplug_begin(void);
 void mem_hotplug_done(void);
@@ -274,6 +275,7 @@ static inline int try_online_node(int nid)
 
 static inline void get_online_mems(void) {}
 static inline void put_online_mems(void) {}
+static inline int  tryget_online_mems(void) { return 1; }
 
 static inline void mem_hotplug_begin(void) {}
 static inline void mem_hotplug_done(void) {}
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fc0aad0bc1f5..38f9ccec9259 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -59,6 +59,11 @@ void get_online_mems(void)
 	percpu_down_read(&mem_hotplug_lock);
 }
 
+int tryget_online_mems(void)
+{
+	return percpu_down_read_trylock(&mem_hotplug_lock);
+}
+
 void put_online_mems(void)
 {
 	percpu_up_read(&mem_hotplug_lock);
diff --git a/mm/slub.c b/mm/slub.c
index cf2114ca27f7..c4977ac3271b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5343,10 +5343,20 @@ static ssize_t shrink_show(struct kmem_cache *s, char *buf)
 static ssize_t shrink_store(struct kmem_cache *s,
 			const char *buf, size_t length)
 {
-	if (buf[0] == '1')
-		kmem_cache_shrink(s);
-	else
+	if (buf[0] != '1')
 		return -EINVAL;
+
+	if (!cpus_read_trylock())
+		return -EBUSY;
+	if (!tryget_online_mems()) {
+		length = -EBUSY;
+		goto cpus_unlock_out;
+	}
+	kasan_cache_shrink(s);
+	__kmem_cache_shrink(s);
+	put_online_mems();
+cpus_unlock_out:
+	cpus_read_unlock();
 	return length;
 }
 SLAB_ATTR(shrink);
@@ -5654,7 +5664,8 @@ static ssize_t slab_attr_store(struct kobject *kobj,
 
 		for (idx = 0; idx < cnt; idx++) {
 			c = pcaches[idx];
-			attribute->store(c, buf, len);
+			if (attribute->store(c, buf, len) == -EBUSY)
+				err = -EBUSY;
 			percpu_ref_put(&c->memcg_params.refcnt);
 		}
 		kfree(pcaches);
-- 
2.18.1

