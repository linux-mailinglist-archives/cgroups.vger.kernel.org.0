Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD82437C11A
	for <lists+cgroups@lfdr.de>; Wed, 12 May 2021 16:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhELO4r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 May 2021 10:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232168AbhELOze (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 May 2021 10:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620831266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SWpKC9JIophhOJfSAOpwo9ri4mX92NQqXeS4GIIdLL0=;
        b=gXhD6TJnCys8o1nXL2b3ZiAt1U4OuiXDL5LqIGy6C1yGTw0LU0qRNwzNtd/WDzySSARGDc
        jsgk/JeoM2SIVgc4+VpVTowsWR53rlTEGMiA0kZHrMq2JVw3i5mCDHgxfjNxYJ3wPac7aH
        RgrCYmDLjVb+11Th6g8VwCJZmKQqfoo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-ng67tJfyPTOOZkg6OTw8pQ-1; Wed, 12 May 2021 10:54:24 -0400
X-MC-Unique: ng67tJfyPTOOZkg6OTw8pQ-1
Received: by mail-qk1-f200.google.com with SMTP id s68-20020a372c470000b0290305f75a7cecso2775543qkh.8
        for <cgroups@vger.kernel.org>; Wed, 12 May 2021 07:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SWpKC9JIophhOJfSAOpwo9ri4mX92NQqXeS4GIIdLL0=;
        b=VsHcCEjD7prTwaF6Waq8qNbfTKbTablBiqc4aRZgxAbyTHjHfh/HjcBUVYR+j3j+Tb
         M5uB9Fan1o5s4gKvW/14cedbWOyKHaN3GQ7YYrnPK0esiWtun9xWzwjCSqR9fZISY/Fu
         OU6+ZfXFOlzvd8PWfJm7Ro/ikOO4hbHHgW1Z/HESn9hpTumfh93xXNrOf1jcEOo7ODyg
         LwA5AVezI3dYGUkcMGOaFXKAyd0YQoae9BVoldPvaABDsBEviKhrdKEotg7dPAS+nen5
         Sj9L5/zv4VS1LQkW0mOOEFL7W6YMSAN5agMhGMob58IoBYklvJOr/c9CfTdu6Jx3Tmu1
         DLPg==
X-Gm-Message-State: AOAM530mB0Uyx8nOCbogrXvU0hOr7tFbJzvpC6u+h9Yifl1Kv9D/D+N3
        eBpKs/UZz1RNpgNFHw49JHzafvAWVu+yX/CbEHsxNOw5+n8zcQBGnpzTcpqpAY6WGm17l2HuEW7
        uH15vkmcZKVgyAKTygQ==
X-Received: by 2002:a05:620a:c0e:: with SMTP id l14mr24851142qki.412.1620831264200;
        Wed, 12 May 2021 07:54:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxH+jPwrKP0yv0MxyEF1dPob8sCiBz+ZLYo2X8hu2Y0zomLvphdBaJMFhPfkm2N3VNTozX87A==
X-Received: by 2002:a05:620a:c0e:: with SMTP id l14mr24851118qki.412.1620831263957;
        Wed, 12 May 2021 07:54:23 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id r125sm214893qkf.24.2021.05.12.07.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 07:54:23 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 2/3] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505200610.13943-1-longman@redhat.com>
 <20210512145107.6208-1-longman@redhat.com>
Message-ID: <0919aaab-cc08-f86d-1f9a-8ddfeed7bb31@redhat.com>
Date:   Wed, 12 May 2021 10:54:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210512145107.6208-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/12/21 10:51 AM, Waiman Long wrote:
> There are currently two problems in the way the objcg pointer array
> (memcg_data) in the page structure is being allocated and freed.
>
> On its allocation, it is possible that the allocated objcg pointer
> array comes from the same slab that requires memory accounting. If this
> happens, the slab will never become empty again as there is at least
> one object left (the obj_cgroup array) in the slab.
>
> When it is freed, the objcg pointer array object may be the last one
> in its slab and hence causes kfree() to be called again. With the
> right workload, the slab cache may be set up in a way that allows the
> recursive kfree() calling loop to nest deep enough to cause a kernel
> stack overflow and panic the system.
>
> One way to solve this problem is to split the kmalloc-<n> caches
> (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
> (KMALLOC_NORMAL) caches for unaccounted objects only and a new set of
> kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
> the other caches can still allow a mix of accounted and unaccounted
> objects.
>
> With this change, all the objcg pointer array objects will come from
> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> both the recursive kfree() problem and non-freeable slab problem are
> gone.
>
> Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer have
> mixed accounted and unaccounted objects, this will slightly reduce the
> number of objcg pointer arrays that need to be allocated and save a bit
> of memory. On the other hand, creating a new set of kmalloc caches does
> have the effect of reducing cache utilization. So it is properly a wash.
>
> The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
> KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
> will include the newly added caches without change.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> ---
>   include/linux/slab.h | 42 +++++++++++++++++++++++++++++++++---------
>   mm/slab_common.c     | 25 +++++++++++++++++--------
>   2 files changed, 50 insertions(+), 17 deletions(-)

The following are the diff's from previous version. It turns out that 
the previous patch doesn't work if CONFIG_ZONE_DMA isn't defined.

diff --git a/include/linux/slab.h b/include/linux/slab.h
index a51cad5f561c..aa7f6c222a60 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -312,16 +312,17 @@ static inline void __check_heap_object(const void 
*ptr, un
signed long n,
   */
  enum kmalloc_cache_type {
      KMALLOC_NORMAL = 0,
-#ifdef CONFIG_MEMCG_KMEM
-    KMALLOC_CGROUP,
-#else
+#ifndef CONFIG_ZONE_DMA
+    KMALLOC_DMA = KMALLOC_NORMAL,
+#endif
+#ifndef CONFIG_MEMCG_KMEM
      KMALLOC_CGROUP = KMALLOC_NORMAL,
+#else
+    KMALLOC_CGROUP,
  #endif
      KMALLOC_RECLAIM,
  #ifdef CONFIG_ZONE_DMA
      KMALLOC_DMA,
-#else
-    KMALLOC_DMA = KMALLOC_NORMAL,
  #endif
      NR_KMALLOC_TYPES
  };

Cheers,
Longman

