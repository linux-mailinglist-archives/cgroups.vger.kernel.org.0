Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC76B53C361
	for <lists+cgroups@lfdr.de>; Fri,  3 Jun 2022 05:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiFCDV5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 23:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiFCDV5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 23:21:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03DA25CF
        for <cgroups@vger.kernel.org>; Thu,  2 Jun 2022 20:21:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a2so10673082lfc.2
        for <cgroups@vger.kernel.org>; Thu, 02 Jun 2022 20:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=nA2vYDFSYSSwoYQE6V2jqo7JnZXuaAizEZ2DGF4wzHU=;
        b=TkgpTfm92o2m1O29bDR5bk6O0skeQ39jC1Zil8uMsqEgedyXmpW05gXJZsUckiCN9t
         R27nnFW/c0nteIXipd2KNmiE3PrfyG7Oiwrkm9ZSGawjLcQ3Id1jRyLspSeZmKcBdbqs
         Osy4a6Byh2KOqnUDRSGzRV7hHimSIVrzFFsfsU3+gtB9vTRIB5MqF+Kwc3lIYbeTQ+tM
         uXjhDqp8XABYkmJEoWSoDvP7vfs3o6giet3i0pSwiHBvUwpBTpN2d28mNZRSmtI3xp6P
         BCoNW25bluKPRFyWDj1srnHGlJiYuAQZtk83AjkimdfiHsxRDPoFaZA9w0ZvBSRt3ath
         MALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=nA2vYDFSYSSwoYQE6V2jqo7JnZXuaAizEZ2DGF4wzHU=;
        b=DjBFqhFKX1Ie7rwFrK4K3ozgeUncApSXjd3oZvVvnrIhLdthocAqwAaeDs5DW90SiP
         +wIS+EUfziNoctdXePp5R4zTO1hb4AoPmDcaNtncfEB3Buy0ma5uUS9BpXztbAwzAQJi
         CHXOTGpGhCf+kY8JEoR3G3cSXSivhQQ1b3JtA4N/jo5KxOD+1P1tSNqIBL/+f6KrYwbB
         hcfUWRzVRReertuC/fYtugecucwYfMoBE0ELCHP+9UbJ1yhjd4xKX5VVbukYZjyRwuqL
         P09hQxaVGKrmZfFLO0CL0JtcKhJWzp0DzvItaXAWEPcktvglniB2GK0VenVNvzXn+gBa
         CMrw==
X-Gm-Message-State: AOAM531AG8BuHeuP7PJLzpZ1zECq8f0bQuAjL9a/LcDnCKVDpICkz6ba
        +YuKhaMfDQM4hhfkBh63vsj1VXJLe+jBkA==
X-Google-Smtp-Source: ABdhPJwJYU3aCxlmXOxv5b+RdvztNQrgzH04ylOyV7SC6F4bbI9ujJpAnHuL89zgLcRUMBhndLpe/Q==
X-Received: by 2002:a05:6512:3a8e:b0:479:d8f:1a0c with SMTP id q14-20020a0565123a8e00b004790d8f1a0cmr4890590lfu.227.1654226510938;
        Thu, 02 Jun 2022 20:21:50 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id f16-20020ac251b0000000b00477be83c446sm1333661lfk.299.2022.06.02.20.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 20:21:50 -0700 (PDT)
Message-ID: <c418ed25-65fe-f623-fbf8-1676528859ed@openvz.org>
Date:   Fri, 3 Jun 2022 06:21:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v6] mm/tracing: add 'accounted' entry into output of
 allocation tracepoints
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, cgroups@vger.kernel.org
References: <c1676616-1405-5bcb-af02-c1e9cc83dace@openvz.org>
Content-Language: en-US
In-Reply-To: <c1676616-1405-5bcb-af02-c1e9cc83dace@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Slab caches marked with SLAB_ACCOUNT force accounting for every
allocation from this cache even if __GFP_ACCOUNT flag is not passed.
Unfortunately, at the moment this flag is not visible in ftrace output,
and this makes it difficult to analyze the accounted allocations.

This patch adds boolean "accounted" entry into trace output,
and set it to 'true' for calls used __GFP_ACCOUNT flag and
for allocations from caches marked with SLAB_ACCOUNT.
Set it to 'false' if accounting is disabled in configs.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

---
v6:
 1) subject changed from "tracing:" to "mm/tracing:"
 2) set flag to 'false' if accounting is disabled in configs
 3) added approvals from Muchun Song and Hyeonggon Yoo

v5:
 1) re-based to current upstream (v5.18-11267-gb00ed48bb0a7)
 2) added "Acked-by" from Roman
 3) re-addressed to slab maintaiers

v4:
 1) replaced in patch descripion: "accounted" instead of "allocated"
 2) added "Acked-by" from Shakeel,
 3) re-addressed to akpm@

v3:
 1) rework kmem_cache_alloc* tracepoints once again,
    added struct kmem_cache argument into existing templates,
        thanks to Matthew Wilcox
 2) updated according trace_* calls
 3) added boolean "allocated" entry into trace output,
        thanks to Roman
 4) updated patch subject and description

v2:
 1) handle kmem_cache_alloc_node(), thanks to Shakeel
 2) rework kmem_cache_alloc* tracepoints to use cachep instead
    of current cachep->*size parameters.
    NB: kmem_cache_alloc_node tracepoint in SLOB cannot use cachep,
        and therefore it was replaced by kmalloc_node.
---
 include/trace/events/kmem.h | 39 ++++++++++++++++++++++++-------------
 mm/slab.c                   | 10 +++++-----
 mm/slab_common.c            |  9 ++++-----
 mm/slob.c                   |  8 ++++----
 mm/slub.c                   | 20 +++++++++----------
 5 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index f76668305ac5..97f60ad82453 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -13,11 +13,12 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 
 	TP_PROTO(unsigned long call_site,
 		 const void *ptr,
+		 struct kmem_cache *s,
 		 size_t bytes_req,
 		 size_t bytes_alloc,
 		 gfp_t gfp_flags),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags),
+	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	call_site	)
@@ -25,6 +26,7 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		__field(	size_t,		bytes_req	)
 		__field(	size_t,		bytes_alloc	)
 		__field(	unsigned long,	gfp_flags	)
+		__field(	bool,		accounted	)
 	),
 
 	TP_fast_assign(
@@ -33,42 +35,47 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		__entry->bytes_req	= bytes_req;
 		__entry->bytes_alloc	= bytes_alloc;
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
+		__entry->accounted	= IS_ENABLED(CONFIG_MEMCG_KMEM) ?
+					  ((gfp_flags & __GFP_ACCOUNT) ||
+					  (s && s->flags & SLAB_ACCOUNT)) : false;
 	),
 
-	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s accounted=%s",
 		(void *)__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
 		__entry->bytes_alloc,
-		show_gfp_flags(__entry->gfp_flags))
+		show_gfp_flags(__entry->gfp_flags),
+		__entry->accounted ? "true" : "false")
 );
 
 DEFINE_EVENT(kmem_alloc, kmalloc,
 
-	TP_PROTO(unsigned long call_site, const void *ptr,
+	TP_PROTO(unsigned long call_site, const void *ptr, struct kmem_cache *s,
 		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
+	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags)
 );
 
 DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
 
-	TP_PROTO(unsigned long call_site, const void *ptr,
+	TP_PROTO(unsigned long call_site, const void *ptr, struct kmem_cache *s,
 		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
+	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags)
 );
 
 DECLARE_EVENT_CLASS(kmem_alloc_node,
 
 	TP_PROTO(unsigned long call_site,
 		 const void *ptr,
+		 struct kmem_cache *s,
 		 size_t bytes_req,
 		 size_t bytes_alloc,
 		 gfp_t gfp_flags,
 		 int node),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node),
+	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	call_site	)
@@ -77,6 +84,7 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__field(	size_t,		bytes_alloc	)
 		__field(	unsigned long,	gfp_flags	)
 		__field(	int,		node		)
+		__field(	bool,		accounted	)
 	),
 
 	TP_fast_assign(
@@ -86,33 +94,36 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__entry->bytes_alloc	= bytes_alloc;
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 		__entry->node		= node;
+		__entry->accounted	= (gfp_flags & __GFP_ACCOUNT) ||
+					  (s && s->flags & SLAB_ACCOUNT);
 	),
 
-	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
 		(void *)__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
 		__entry->bytes_alloc,
 		show_gfp_flags(__entry->gfp_flags),
-		__entry->node)
+		__entry->node,
+		__entry->accounted ? "true" : "false")
 );
 
 DEFINE_EVENT(kmem_alloc_node, kmalloc_node,
 
 	TP_PROTO(unsigned long call_site, const void *ptr,
-		 size_t bytes_req, size_t bytes_alloc,
+		 struct kmem_cache *s, size_t bytes_req, size_t bytes_alloc,
 		 gfp_t gfp_flags, int node),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
+	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node)
 );
 
 DEFINE_EVENT(kmem_alloc_node, kmem_cache_alloc_node,
 
 	TP_PROTO(unsigned long call_site, const void *ptr,
-		 size_t bytes_req, size_t bytes_alloc,
+		 struct kmem_cache *s, size_t bytes_req, size_t bytes_alloc,
 		 gfp_t gfp_flags, int node),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
+	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node)
 );
 
 TRACE_EVENT(kfree,
diff --git a/mm/slab.c b/mm/slab.c
index f8cd00f4ba13..1f7864ff41e3 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3478,7 +3478,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
 {
 	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret,
+	trace_kmem_cache_alloc(_RET_IP_, ret, cachep,
 			       cachep->object_size, cachep->size, flags);
 
 	return ret;
@@ -3567,7 +3567,7 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 	ret = slab_alloc(cachep, NULL, flags, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc(_RET_IP_, ret,
+	trace_kmalloc(_RET_IP_, ret, cachep,
 		      size, cachep->size, flags);
 	return ret;
 }
@@ -3592,7 +3592,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, flags, nodeid, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret,
+	trace_kmem_cache_alloc_node(_RET_IP_, ret, cachep,
 				    cachep->object_size, cachep->size,
 				    flags, nodeid);
 
@@ -3611,7 +3611,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 	ret = slab_alloc_node(cachep, flags, nodeid, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc_node(_RET_IP_, ret,
+	trace_kmalloc_node(_RET_IP_, ret, cachep,
 			   size, cachep->size,
 			   flags, nodeid);
 	return ret;
@@ -3694,7 +3694,7 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
 	ret = slab_alloc(cachep, NULL, flags, size, caller);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc(caller, ret,
+	trace_kmalloc(caller, ret, cachep,
 		      size, cachep->size, flags);
 
 	return ret;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 77c3adf40e50..6c9aac5d8f4a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -26,13 +26,12 @@
 #include <linux/memcontrol.h>
 #include <linux/stackdepot.h>
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/kmem.h>
-
 #include "internal.h"
-
 #include "slab.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/kmem.h>
+
 enum slab_state slab_state;
 LIST_HEAD(slab_caches);
 DEFINE_MUTEX(slab_mutex);
@@ -959,7 +958,7 @@ EXPORT_SYMBOL(kmalloc_order);
 void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
 {
 	void *ret = kmalloc_order(size, flags, order);
-	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
+	trace_kmalloc(_RET_IP_, ret, NULL, size, PAGE_SIZE << order, flags);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_order_trace);
diff --git a/mm/slob.c b/mm/slob.c
index f47811f09aca..56421fe461c4 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -507,7 +507,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 		*m = size;
 		ret = (void *)m + minalign;
 
-		trace_kmalloc_node(caller, ret,
+		trace_kmalloc_node(caller, ret, NULL,
 				   size, size + minalign, gfp, node);
 	} else {
 		unsigned int order = get_order(size);
@@ -516,7 +516,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 			gfp |= __GFP_COMP;
 		ret = slob_new_pages(gfp, order, node);
 
-		trace_kmalloc_node(caller, ret,
+		trace_kmalloc_node(caller, ret, NULL,
 				   size, PAGE_SIZE << order, gfp, node);
 	}
 
@@ -616,12 +616,12 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 
 	if (c->size < PAGE_SIZE) {
 		b = slob_alloc(c->size, flags, c->align, node, 0);
-		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
+		trace_kmem_cache_alloc_node(_RET_IP_, b, NULL, c->object_size,
 					    SLOB_UNITS(c->size) * SLOB_UNIT,
 					    flags, node);
 	} else {
 		b = slob_new_pages(flags, get_order(c->size), node);
-		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
+		trace_kmem_cache_alloc_node(_RET_IP_, b, NULL, c->object_size,
 					    PAGE_SIZE << get_order(c->size),
 					    flags, node);
 	}
diff --git a/mm/slub.c b/mm/slub.c
index e5535020e0fd..c323dd916b08 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3228,7 +3228,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 {
 	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
+	trace_kmem_cache_alloc(_RET_IP_, ret, s, s->object_size,
 				s->size, gfpflags);
 
 	return ret;
@@ -3251,7 +3251,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_lru);
 void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
 	void *ret = slab_alloc(s, NULL, gfpflags, _RET_IP_, size);
-	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags);
+	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags);
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
@@ -3263,7 +3263,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret,
+	trace_kmem_cache_alloc_node(_RET_IP_, ret, s,
 				    s->object_size, s->size, gfpflags, node);
 
 	return ret;
@@ -3277,7 +3277,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(_RET_IP_, ret,
+	trace_kmalloc_node(_RET_IP_, ret, s,
 			   size, s->size, gfpflags, node);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
@@ -4412,7 +4412,7 @@ void *__kmalloc(size_t size, gfp_t flags)
 
 	ret = slab_alloc(s, NULL, flags, _RET_IP_, size);
 
-	trace_kmalloc(_RET_IP_, ret, size, s->size, flags);
+	trace_kmalloc(_RET_IP_, ret, s, size, s->size, flags);
 
 	ret = kasan_kmalloc(s, ret, size, flags);
 
@@ -4446,7 +4446,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = kmalloc_large_node(size, flags, node);
 
-		trace_kmalloc_node(_RET_IP_, ret,
+		trace_kmalloc_node(_RET_IP_, ret, NULL,
 				   size, PAGE_SIZE << get_order(size),
 				   flags, node);
 
@@ -4460,7 +4460,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 
 	ret = slab_alloc_node(s, NULL, flags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(_RET_IP_, ret, size, s->size, flags, node);
+	trace_kmalloc_node(_RET_IP_, ret, s, size, s->size, flags, node);
 
 	ret = kasan_kmalloc(s, ret, size, flags);
 
@@ -4919,7 +4919,7 @@ void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
 	ret = slab_alloc(s, NULL, gfpflags, caller, size);
 
 	/* Honor the call site pointer we received. */
-	trace_kmalloc(caller, ret, size, s->size, gfpflags);
+	trace_kmalloc(caller, ret, s, size, s->size, gfpflags);
 
 	return ret;
 }
@@ -4935,7 +4935,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = kmalloc_large_node(size, gfpflags, node);
 
-		trace_kmalloc_node(caller, ret,
+		trace_kmalloc_node(caller, ret, NULL,
 				   size, PAGE_SIZE << get_order(size),
 				   gfpflags, node);
 
@@ -4950,7 +4950,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	ret = slab_alloc_node(s, NULL, gfpflags, node, caller, size);
 
 	/* Honor the call site pointer we received. */
-	trace_kmalloc_node(caller, ret, size, s->size, gfpflags, node);
+	trace_kmalloc_node(caller, ret, s, size, s->size, gfpflags, node);
 
 	return ret;
 }
-- 
2.36.1

