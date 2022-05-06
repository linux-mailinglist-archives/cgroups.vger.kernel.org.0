Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF7A51D05B
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 06:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiEFEt4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 00:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiEFEtz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 00:49:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A8264BDF
        for <cgroups@vger.kernel.org>; Thu,  5 May 2022 21:46:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s27so7944960ljd.2
        for <cgroups@vger.kernel.org>; Thu, 05 May 2022 21:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=ebHe35Gmk78WMJgIfckhHfMIdVOvsLMOAu74q+t4BFo=;
        b=KYIakOzZUhch4ffbH6b7quOPssgj49bX0KU5QOiFBnElxbHq2FdwP3vT+3h5CcxPwX
         IrixwIa75q2T+acquFnGzfIdts4a13ILh1TU87vipuJT/zbgQcpdDqgCFu0tnC5cpz6U
         Y9+dMdFiT+jzafaqB6FpGOzcc4Z3a7vhJ2VOl8ItlzGx194twpwlWA7dyR24EkXKFnPB
         zFT7GXJaHWZNWdZv7dpJ8UsvZjA67mhWtFEbSSN8OH20bsRBiduvCnEfZEAj+wGvDOo3
         cOv1n4hJHPM42jtT8AG9DivNuYUg5sH8DJ2TZVNjmADImTQVCElvyU9y7swBwazZ+gPH
         Cgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=ebHe35Gmk78WMJgIfckhHfMIdVOvsLMOAu74q+t4BFo=;
        b=ubicoAQIAhZG6muSTMwr3XsA2i5ut8T8JEHUOp4jdmOUU/Ob4kRW/K9sDWZShULT9g
         aRaJ3dJMGYn9qdYjInLOhqFmO8dV8aNTiy8R4ObMi1qs1vQa9Chcsfb63mefM56232Pk
         aMxWwJiX18CI7kHr55TRCtD9U0zh8RHK3r9UmWgpZUlgYgOzsZAmj3MrwcTK9qp8Og3z
         ypsOlLxzSYlvSRVgjYluv8bMS4ro2jbKXGeD9nRR38QrArrBBlcJpNvKGOnGNFzpB3kN
         dtX8h1EMxNRw/d5VmxT9UPsRQFCVo9jX7x8DYKpLfiU+4vpkt0/Djw4JOEyUlERZqMXj
         SuiQ==
X-Gm-Message-State: AOAM531r31i3UvQtIAD7uBzOkfWwtJOAsvaWT8RYxgUuzAFJAy2iZYmI
        Bdg/jRn08hjJMmqBYZq0Uw2L/h1vr2MCuos5
X-Google-Smtp-Source: ABdhPJysZR7I61em7Nku7O7OMh143wwbx4uLJtwInXf9AfARWyaAi3ljUGgzzrWjTCGkldCsvVEqYA==
X-Received: by 2002:a2e:bd86:0:b0:24f:16a6:8c0e with SMTP id o6-20020a2ebd86000000b0024f16a68c0emr919502ljq.450.1651812370252;
        Thu, 05 May 2022 21:46:10 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id m10-20020a056512114a00b0047255d2117bsm509649lfg.170.2022.05.05.21.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 21:46:09 -0700 (PDT)
Message-ID: <8d627f02-183f-c4e7-7c15-77b2b438536b@openvz.org>
Date:   Fri, 6 May 2022 07:46:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH] percpu: improve percpu_alloc_percpu event trace
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
Content-Language: en-US
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

Added bytes_alloc and gfp_flags fields to the output of the
percpu_alloc_percpu ftrace event. This is required to track
memcg-accounted percpu allocations.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 include/trace/events/percpu.h | 17 ++++++++++++-----
 mm/percpu-internal.h          |  8 ++++----
 mm/percpu.c                   |  3 ++-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/percpu.h b/include/trace/events/percpu.h
index df112a64f6c9..a6d640d2cb8b 100644
--- a/include/trace/events/percpu.h
+++ b/include/trace/events/percpu.h
@@ -6,13 +6,16 @@
 #define _TRACE_PERCPU_H
 
 #include <linux/tracepoint.h>
+#include <trace/events/mmflags.h>
 
 TRACE_EVENT(percpu_alloc_percpu,
 
 	TP_PROTO(bool reserved, bool is_atomic, size_t size,
-		 size_t align, void *base_addr, int off, void __percpu *ptr),
+		 size_t align, void *base_addr, int off,
+		 void __percpu *ptr, size_t bytes_alloc, gfp_t gfp_flags),
 
-	TP_ARGS(reserved, is_atomic, size, align, base_addr, off, ptr),
+	TP_ARGS(reserved, is_atomic, size, align, base_addr, off, ptr,
+		bytes_alloc, gfp_flags),
 
 	TP_STRUCT__entry(
 		__field(	bool,			reserved	)
@@ -22,8 +25,9 @@ TRACE_EVENT(percpu_alloc_percpu,
 		__field(	void *,			base_addr	)
 		__field(	int,			off		)
 		__field(	void __percpu *,	ptr		)
+		__field(	size_t,			bytes_alloc	)
+		__field(	gfp_t,			gfp_flags	)
 	),
-
 	TP_fast_assign(
 		__entry->reserved	= reserved;
 		__entry->is_atomic	= is_atomic;
@@ -32,12 +36,15 @@ TRACE_EVENT(percpu_alloc_percpu,
 		__entry->base_addr	= base_addr;
 		__entry->off		= off;
 		__entry->ptr		= ptr;
+		__entry->bytes_alloc	= bytes_alloc;
+		__entry->gfp_flags	= gfp_flags;
 	),
 
-	TP_printk("reserved=%d is_atomic=%d size=%zu align=%zu base_addr=%p off=%d ptr=%p",
+	TP_printk("reserved=%d is_atomic=%d size=%zu align=%zu base_addr=%p off=%d ptr=%p bytes_alloc=%zu gfp_flags=%s",
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
index ea28db283044..cbeb380c359d 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1885,7 +1885,8 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 	kmemleak_alloc_percpu(ptr, size, gfp);
 
 	trace_percpu_alloc_percpu(reserved, is_atomic, size, align,
-			chunk->base_addr, off, ptr);
+			chunk->base_addr, off, ptr,
+			pcpu_obj_full_size(size), gfp);
 
 	pcpu_memcg_post_alloc_hook(objcg, chunk, off, size);
 
-- 
2.31.1

