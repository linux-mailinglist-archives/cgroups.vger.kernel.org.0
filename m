Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8653C38D
	for <lists+cgroups@lfdr.de>; Fri,  3 Jun 2022 06:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiFCETy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jun 2022 00:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiFCETw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jun 2022 00:19:52 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E901340E4
        for <cgroups@vger.kernel.org>; Thu,  2 Jun 2022 21:19:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a2so10798285lfc.2
        for <cgroups@vger.kernel.org>; Thu, 02 Jun 2022 21:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=pSYwMXTiWYFCbMo+OGvlkKXlgdvtI08BWksfEz9zHwI=;
        b=1CODD47VWyN69Es67Z6riONBZqKuEEgP78VqiQGl2vKLYNexE0WZpG6O9FiSYe5iqv
         ijkoUB7PQI50ZeSmOFMjjVRjN1uCRNQXm7HLQA+/dGdta3BuKcLeph449pqL+xmCSxUv
         ibISQ35Y02uC1uLE9hupFlNAZMJ9BQwJK0pZTp4HF75l7144MaPFHMt5uG35vmDjpQNW
         kbLx6otbwcZRihC9aa5yGdkhFBxOFsqZsj4TksediRwyE5kp6Qys6pnfLGbOAfLN/KMD
         gHtYVUcq0tFXMMbbM2SCeXnfJQKJ/DE0whVWFW5GaBPAHWVqtc4NOjG1/TuG585ZbJzB
         2w0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=pSYwMXTiWYFCbMo+OGvlkKXlgdvtI08BWksfEz9zHwI=;
        b=Skls1AyFDKIJRFoKxmK3h6lcNMRhOO/IM4scGnl6pty9xMYGZNG1LVNY+maX5ipofO
         Z5s20ejNsup8zAsvzIQ1ABdnvibu4vc4b0f7ALCCEgCBbejo8zOZCQ0ow3GSygtMpUKX
         aqLQVpwzkI4fb2eVhTkElAFN7FM0M4FfN1kgNpevgTJebVZAo0xj8APkn9/u5InahtP0
         3suZZ3lQpEsUwBZmjYcaPV8E2jeR+VHt7NX7G5xEdaxz/Wk70LU2pZpWp9G1OdM+9Wxm
         +6ybvjpkAn2Ac0Ikp9oWlcibgbbQWIm/wSfAbK9BUKqjdHjznvh5IeGT6dsW4UFdIL/f
         HdIQ==
X-Gm-Message-State: AOAM5315fdVGJD7Qj+q+EFBkeaPIWLilJuvU5HE9Ifr6EVquGt5JpXaD
        hXFUcyQXJHzV8/Ev0ZxQkJMh6w==
X-Google-Smtp-Source: ABdhPJxtEa4AvS+hff4wNUG2MVhq15kAG6mG6ooeCyhAFC5bOY6AHAoxBiLjCvSRTrPc/4VOHRUfdw==
X-Received: by 2002:a05:6512:118a:b0:478:a8b3:e1ee with SMTP id g10-20020a056512118a00b00478a8b3e1eemr32562601lfr.391.1654229985403;
        Thu, 02 Jun 2022 21:19:45 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id s17-20020a197711000000b0047255d211fasm617383lfc.297.2022.06.02.21.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 21:19:44 -0700 (PDT)
Message-ID: <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org>
Date:   Fri, 3 Jun 2022 07:19:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH memcg v6] net: set proper memcg for net_init hooks allocations
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, cgroups@vger.kernel.org
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
Content-Language: en-US
In-Reply-To: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
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

__register_pernet_operations() executes init hook of registered
pernet_operation structure in all existing net namespaces.

Typically, these hooks are called by a process associated with
the specified net namespace, and all __GFP_ACCOUNT marked
allocation are accounted for corresponding container/memcg.

However __register_pernet_operations() calls the hooks in the same
context, and as a result all marked allocations are accounted
to one memcg for all processed net namespaces.

This patch adjusts active memcg for each net namespace and helps
to account memory allocated inside ops_init() into the proper memcg.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
v6: re-based to current upstream (v5.18-11267-gb00ed48bb0a7)

v5: documented get_mem_cgroup_from_obj() and for mem_cgroup_or_root()
    functions, asked by Shakeel.

v4: get_mem_cgroup_from_kmem() renamed to get_mem_cgroup_from_obj(),
    get_net_memcg() renamed to mem_cgroup_or_root(), suggested by Roman.

v3: put_net_memcg() replaced by an alreay existing mem_cgroup_put()
    It checks memcg before accessing it, this is required for
    __register_pernet_operations() called before memcg initialization.
    Additionally fixed leading whitespaces in non-memcg_kmem version
    of mem_cgroup_from_obj().

v2: introduced get/put_net_memcg(),
    new functions are moved under CONFIG_MEMCG_KMEM
    to fix compilation issues reported by Intel's kernel test robot

v1: introduced get_mem_cgroup_from_kmem(), which takes the refcount
    for the found memcg, suggested by Shakeel
---
 include/linux/memcontrol.h | 47 +++++++++++++++++++++++++++++++++++++-
 net/core/net_namespace.c   |  7 ++++++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9ecead1042b9..dad16b484cd5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1755,6 +1755,42 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }
 
+/**
+ * get_mem_cgroup_from_obj - get a memcg associated with passed kernel object.
+ * @p: pointer to object from which memcg should be extracted. It can be NULL.
+ *
+ * Retrieves the memory group into which the memory of the pointed kernel
+ * object is accounted. If memcg is found, its reference is taken.
+ * If a passed kernel object is uncharged, or if proper memcg cannot be found,
+ * as well as if mem_cgroup is disabled, NULL is returned.
+ *
+ * Return: valid memcg pointer with taken reference or NULL.
+ */
+static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	do {
+		memcg = mem_cgroup_from_obj(p);
+	} while (memcg && !css_tryget(&memcg->css));
+	rcu_read_unlock();
+	return memcg;
+}
+
+/**
+ * mem_cgroup_or_root - always returns a pointer to a valid memory cgroup.
+ * @memcg: pointer to a valid memory cgroup or NULL.
+ *
+ * If passed argument is not NULL, returns it without any additional checks
+ * and changes. Otherwise, root_mem_cgroup is returned.
+ *
+ * NOTE: root_mem_cgroup can be NULL during early boot.
+ */
+static inline struct mem_cgroup *mem_cgroup_or_root(struct mem_cgroup *memcg)
+{
+	return memcg ? memcg : root_mem_cgroup;
+}
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1798,7 +1834,7 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 
 static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
 {
-       return NULL;
+	return NULL;
 }
 
 static inline void count_objcg_event(struct obj_cgroup *objcg,
@@ -1806,6 +1842,15 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 {
 }
 
+static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
+{
+	return NULL;
+}
+
+static inline struct mem_cgroup *mem_cgroup_or_root(struct mem_cgroup *memcg)
+{
+	return NULL;
+}
 #endif /* CONFIG_MEMCG_KMEM */
 
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 0ec2f5906a27..6b9f19122ec1 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -18,6 +18,7 @@
 #include <linux/user_namespace.h>
 #include <linux/net_namespace.h>
 #include <linux/sched/task.h>
+#include <linux/sched/mm.h>
 #include <linux/uidgid.h>
 #include <linux/cookie.h>
 
@@ -1143,7 +1144,13 @@ static int __register_pernet_operations(struct list_head *list,
 		 * setup_net() and cleanup_net() are not possible.
 		 */
 		for_each_net(net) {
+			struct mem_cgroup *old, *memcg;
+
+			memcg = mem_cgroup_or_root(get_mem_cgroup_from_obj(net));
+			old = set_active_memcg(memcg);
 			error = ops_init(ops, net);
+			set_active_memcg(old);
+			mem_cgroup_put(memcg);
 			if (error)
 				goto out_undo;
 			list_add_tail(&net->exit_list, &net_exit_list);
-- 
2.36.1

