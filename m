Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FC850C81C
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 09:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiDWH7f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 03:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiDWH7e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 03:59:34 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410D63B2A1
        for <cgroups@vger.kernel.org>; Sat, 23 Apr 2022 00:56:38 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bj36so12100677ljb.13
        for <cgroups@vger.kernel.org>; Sat, 23 Apr 2022 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=mif/hptMttckx/mJ2yjacwOwrfg6csXHsP1C0SeWPl4=;
        b=Jh3EjOr+fbFSxsWWXzKZ1dLFWdYWIgAT+OvVwnM/YGyDQ7mBB2EepGX50xPrhenMRy
         1u2x0E0gGW9XabiMiNEXr83wUcsgtzGlaWKoPNL4DichQ32o6WBMLLJm5WsseIYsGBM6
         bpJDaCTTtsHJGcYtnnYYiY5zbPsAe9vWmAk3/b2eHsr7dOgmStQfhoy132T/YObSkjYC
         rcqowhNPmMq6tcJiN9k+xWNYvmBBNXVUGzvkel+WVoExNr+k2Vgl9IvU7FAzkQyzrQL4
         sJq5PQfF02ZAr6M/man+jrRycFRNHpEDaLYAi8IRdb/B4kMJEt1pBYbsZgVDAKSASN1C
         zIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=mif/hptMttckx/mJ2yjacwOwrfg6csXHsP1C0SeWPl4=;
        b=B+ab+AyW01Tq4jOX9O3PQAmjMclFlY9AmXCeN0MSTJ6BrgBr+ntppqq1Ko69TmdIh/
         1/Ki6k2uduVrl5wm8RjyvtR0cS+Ex3KfSfldWV0/xHr+MStvB0RogBUgnMdEaBjaOKv+
         yvSCDRI/jEp/T5h6KjPKh+iABhIBMoHceNI3MEGx96Ebi6V6nmqqkbQrDhObHhbviJlt
         7/BlUEH3pRs1Z07Pi2sZe711ZevQg6XjJ/4+iaZKKMN3JjllLK+iZlW7X9lEH4OAP2U8
         K9Lj3o3D3ORNzWRQs8ADHff1uBDUy9nnkIVsSgW43bcBRURqCffX1PlyyevC5UdE/xHL
         3SvA==
X-Gm-Message-State: AOAM532qzpdBxZsVvd0f/WUZWygZcy2N2eokk5I4IS36T0iKASRvBMuh
        IYRM+lOBqlPOGiAAKNgJ/1o7dw==
X-Google-Smtp-Source: ABdhPJzwOxJDiUT+mxVE2gdeqnTfab1zeDWAizki2WmGRG2zg3Ej+gEKUwuqGX9Bc50MTmsxtY5imA==
X-Received: by 2002:a2e:9182:0:b0:24f:66f:7ca9 with SMTP id f2-20020a2e9182000000b0024f066f7ca9mr615846ljg.397.1650700596565;
        Sat, 23 Apr 2022 00:56:36 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id m5-20020a194345000000b0046e951e34b3sm525140lfj.24.2022.04.23.00.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 00:56:35 -0700 (PDT)
Message-ID: <6f38e02b-9af3-4dcf-9000-1118a04b13c7@openvz.org>
Date:   Sat, 23 Apr 2022 10:56:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH] net: set proper memcg for net_init hooks allocations
To:     Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>
Cc:     kernel@openvz.org, Florian Westphal <fw@strlen.de>,
        linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <CALvZod7ys1SNrQhbweCoCKVyfN1itE16jhC97TqjWtHDFh1RpQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALvZod7ys1SNrQhbweCoCKVyfN1itE16jhC97TqjWtHDFh1RpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

__register_pernet_operations() executes init hook of registered
pernet_operation structure in all existing net namespaces.

Typically, these hooks are called by a process associated with
the specified net namespace, and all __GFP_ACCOUNTING marked
allocation are accounted for corresponding container/memcg.

However __register_pernet_operations() calls the hooks in the same
context, and as a result all marked allocations are accounted
to one memcg for all processed net namespaces.

This patch adjusts active memcg for each net namespace and helps
to account memory allocated inside ops_init() into the proper memcg.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
v1: introduced get_mem_cgroup_from_kmem(), which takes the refcount
    for the found memcg, suggested by Shakeel
---
 include/linux/memcontrol.h | 11 +++++++++++
 net/core/net_namespace.c   |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0abbd685703b..16b157852a8c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1768,4 +1768,15 @@ static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
 
 #endif /* CONFIG_MEMCG_KMEM */
 
+static inline struct mem_cgroup *get_mem_cgroup_from_kmem(void *p)
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
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index a5b5bb99c644..56608f56bed6 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -26,6 +26,7 @@
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 
+#include <linux/sched/mm.h>
 /*
  *	Our network namespace constructor/destructor lists
  */
@@ -1147,7 +1148,15 @@ static int __register_pernet_operations(struct list_head *list,
 		 * setup_net() and cleanup_net() are not possible.
 		 */
 		for_each_net(net) {
+			struct mem_cgroup *old, *memcg;
+
+			memcg = get_mem_cgroup_from_kmem(net);
+			if (!memcg)
+				memcg = root_mem_cgroup;
+			old = set_active_memcg(memcg);
 			error = ops_init(ops, net);
+			set_active_memcg(old);
+			css_put(&memcg->css);
 			if (error)
 				goto out_undo;
 			list_add_tail(&net->exit_list, &net_exit_list);
-- 
2.31.1

