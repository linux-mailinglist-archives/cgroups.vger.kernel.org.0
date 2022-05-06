Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846CF51DFA4
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 21:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390745AbiEFTdN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 15:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390743AbiEFTdN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 15:33:13 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AAA6D94D
        for <cgroups@vger.kernel.org>; Fri,  6 May 2022 12:29:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 16so10367731lju.13
        for <cgroups@vger.kernel.org>; Fri, 06 May 2022 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=KWAb658hWnEyrNgr/yyrfE4nucb98F+3qRmQt1CMXNA=;
        b=G/TjzTQMF1GsQTZOCwfujliBF5HfJ5GxX8JkT7vDeyvg5KUQUOMV7XEtC6MmaPQGPx
         vhCqL1NN0ajISS2f5/HLS0G4JOZ6J0ehLRpNWgpeo3/byghb7omWCXJKirrgPdRi4h+G
         elmvcOwiVB0KrZMyC6FV+JiyRVKQY667j3Vl70wZnt6RZJwD7IIHdFX0mrzOo/FuDgz5
         /ViZkoq02gVCwy3ERveiYb6XZe0GEe1DdKy2aiPGKGAUo38kAuG+rBL50vxkpDyaMyos
         G9bVpgU0U8+7maS6R2RLUVPa1mK/ghZnh2yhqf+bP6IvFBrl9Ll2C1tJYNMQDzvMvr82
         tMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=KWAb658hWnEyrNgr/yyrfE4nucb98F+3qRmQt1CMXNA=;
        b=OGfTb5Ogm1k/Y3to+KvTh5t38+HvfcLdnn9cnbsnEgsAuL8kJe5EHLAfOPDGqVl/yB
         fdwJJ+xk6uMivRtQDEWSyL99+V2pXdUsn2NCjwje5kz+ziZZWwxGXZsL7lbj4NdZiNIG
         YEpXvXtsvKLsfQ6xCPTy3+bPedoGfIcikYkEQ3fUr1Bas0P8KmiKzx6yhwa3lDCCVh8z
         OspbT4uKED2ktLAqXZgbRa7IqqPAQOf8A3I5d/oIK+Kdb3bG903sPjggWJaj3+SQ6zJ3
         4MBudUbwnXNKfvUVkWjmplQSVmoIZqunYYOeXI1ztLVaol2qFYUV6g6aWJF+15lUuDk8
         aTQA==
X-Gm-Message-State: AOAM531k2HNQ+pzNz9qa5odf4BTHoSuJKW8MdN+BQqnPAEbGnCU3n754
        JfxMcdLtLr6wMDtr1Xi7An59Hw==
X-Google-Smtp-Source: ABdhPJyWWGiCkdIxMCIxqsLpBldxBZhSAlwBUjCRBsmjDFAzoM8XzNWYWeUahljwmbUXpjrOAeyuEg==
X-Received: by 2002:a2e:a794:0:b0:250:5de1:1ec5 with SMTP id c20-20020a2ea794000000b002505de11ec5mr2859520ljf.270.1651865367120;
        Fri, 06 May 2022 12:29:27 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id u24-20020a196a18000000b0047255d21180sm791507lfu.175.2022.05.06.12.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 12:29:26 -0700 (PDT)
Message-ID: <a07be858-c8a3-7851-9086-e3262cbcf707@openvz.org>
Date:   Fri, 6 May 2022 22:29:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v2] percpu: improve percpu_alloc_percpu event trace
To:     Shakeel Butt <shakeelb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org
References: <2b388d09-940e-990f-1f8a-2fdaa9210fa0@openvz.org>
Content-Language: en-US
In-Reply-To: <2b388d09-940e-990f-1f8a-2fdaa9210fa0@openvz.org>
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

Added call_site, bytes_alloc and gfp_flags fields to the output
of the percpu_alloc_percpu ftrace event:

mkdir-4393  [001]   169.334788: percpu_alloc_percpu:
 call_site=mem_cgroup_css_alloc+0xa6 reserved=0 is_atomic=0 size=2408 align=8
  base_addr=0xffffc7117fc00000 off=402176 ptr=0x3dc867a62300 bytes_alloc=14448
   gfp_flags=GFP_KERNEL_ACCOUNT

This is required to track memcg-accounted percpu allocations.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
v2: added call_site, improved patch description
---
 include/trace/events/percpu.h | 23 +++++++++++++++++------
 mm/percpu-internal.h          |  8 ++++----
 mm/percpu.c                   |  5 +++--
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/include/trace/events/percpu.h b/include/trace/events/percpu.h
index df112a64f6c9..e989cefc0def 100644
--- a/include/trace/events/percpu.h
+++ b/include/trace/events/percpu.h
@@ -6,15 +6,20 @@
 #define _TRACE_PERCPU_H
 
 #include <linux/tracepoint.h>
+#include <trace/events/mmflags.h>
 
 TRACE_EVENT(percpu_alloc_percpu,
 
-	TP_PROTO(bool reserved, bool is_atomic, size_t size,
-		 size_t align, void *base_addr, int off, void __percpu *ptr),
+	TP_PROTO(unsigned long call_site,
+		 bool reserved, bool is_atomic, size_t size,
+		 size_t align, void *base_addr, int off,
+		 void __percpu *ptr, size_t bytes_alloc, gfp_t gfp_flags),
 
-	TP_ARGS(reserved, is_atomic, size, align, base_addr, off, ptr),
+	TP_ARGS(call_site, reserved, is_atomic, size, align, base_addr, off,
+		ptr, bytes_alloc, gfp_flags),
 
 	TP_STRUCT__entry(
+		__field(	unsigned long,		call_site	)
 		__field(	bool,			reserved	)
 		__field(	bool,			is_atomic	)
 		__field(	size_t,			size		)
@@ -22,9 +27,11 @@ TRACE_EVENT(percpu_alloc_percpu,
 		__field(	void *,			base_addr	)
 		__field(	int,			off		)
 		__field(	void __percpu *,	ptr		)
+		__field(	size_t,			bytes_alloc	)
+		__field(	gfp_t,			gfp_flags	)
 	),
-
 	TP_fast_assign(
+		__entry->call_site	= call_site;
 		__entry->reserved	= reserved;
 		__entry->is_atomic	= is_atomic;
 		__entry->size		= size;
@@ -32,12 +39,16 @@ TRACE_EVENT(percpu_alloc_percpu,
 		__entry->base_addr	= base_addr;
 		__entry->off		= off;
 		__entry->ptr		= ptr;
+		__entry->bytes_alloc	= bytes_alloc;
+		__entry->gfp_flags	= gfp_flags;
 	),
 
-	TP_printk("reserved=%d is_atomic=%d size=%zu align=%zu base_addr=%p off=%d ptr=%p",
+	TP_printk("call_site=%pS reserved=%d is_atomic=%d size=%zu align=%zu base_addr=%p off=%d ptr=%p bytes_alloc=%zu gfp_flags=%s",
+		  (void *)__entry->call_site,
 		  __entry->reserved, __entry->is_atomic,
 		  __entry->size, __entry->align,
-		  __entry->base_addr, __entry->off, __entry->ptr)
+		  __entry->base_addr, __entry->off, __entry->ptr,
+		  __entry->bytes_alloc, show_gfp_flags(__entry->gfp_flags))
 );
 
 TRACE_EVENT(percpu_free_percpu,
diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 411d1593ef23..70b1ea23f4d2 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -113,7 +113,6 @@ static inline int pcpu_chunk_map_bits(struct pcpu_chunk *chunk)
 	return pcpu_nr_pages_to_map_bits(chunk->nr_pages);
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 /**
  * pcpu_obj_full_size - helper to calculate size of each accounted object
  * @size: size of area to allocate in bytes
@@ -123,13 +122,14 @@ static inline int pcpu_chunk_map_bits(struct pcpu_chunk *chunk)
  */
 static inline size_t pcpu_obj_full_size(size_t size)
 {
-	size_t extra_size;
+	size_t extra_size = 0;
 
-	extra_size = size / PCPU_MIN_ALLOC_SIZE * sizeof(struct obj_cgroup *);
+#ifdef CONFIG_MEMCG_KMEM
+	extra_size += size / PCPU_MIN_ALLOC_SIZE * sizeof(struct obj_cgroup *);
+#endif
 
 	return size * num_possible_cpus() + extra_size;
 }
-#endif /* CONFIG_MEMCG_KMEM */
 
 #ifdef CONFIG_PERCPU_STATS
 
diff --git a/mm/percpu.c b/mm/percpu.c
index ea28db283044..3633eeefaa0d 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1884,8 +1884,9 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 	ptr = __addr_to_pcpu_ptr(chunk->base_addr + off);
 	kmemleak_alloc_percpu(ptr, size, gfp);
 
-	trace_percpu_alloc_percpu(reserved, is_atomic, size, align,
-			chunk->base_addr, off, ptr);
+	trace_percpu_alloc_percpu(_RET_IP_, reserved, is_atomic, size, align,
+				  chunk->base_addr, off, ptr,
+				  pcpu_obj_full_size(size), gfp);
 
 	pcpu_memcg_post_alloc_hook(objcg, chunk, off, size);
 
-- 
2.31.1

