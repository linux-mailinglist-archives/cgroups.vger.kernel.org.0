Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE688557E33
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 16:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiFWOvs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiFWOvn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 10:51:43 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C25447540
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:51:40 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s14so16870413ljs.3
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=fYBLg0GorDblKEye4tioxlFuzZ/2NCtjLKl9KE3W8YI=;
        b=ilILMVAcvthPkldn+Fa+LkoIG/WSsFH8M7YG6eZI6EykQ+3oB7c4PdbWYXjZqjJ+43
         FWPcHN93ez+UtYY/3FGn60gVrWz2wmHIsFXq/TFUle1S2965DVGnZ+G7T88vtlrYFmp+
         yXP01mugIN86XV+s+rNzVqBycfic42Rq5VXNV9DBPQH+yuwZrrP0STBifVHqjRAjGW7J
         uYweDn2FveDwN4KUNlAFLo/+FqPrpfOFrs2q/44dDgBdmYC7a4GXjqZwPQuqOjaHf6cx
         cJOheLE1U00l7XXoRAwkq1Qbu9NV/7vftEsfDxwdNHKeI9Z/sKkWD5mRMqV1KP3cgxL5
         p0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=fYBLg0GorDblKEye4tioxlFuzZ/2NCtjLKl9KE3W8YI=;
        b=OGmFXHh+p2gNZdVvsQsa7BVqyi68EF6BXkH60lPq3lkh/DgYdrzkQltGfxobpsxahk
         oV0DKEv679Y8mXHB5wlvNWIo9q9Wp4nlkn0gn70eL/Obho9vkdgvbZsDikCW0QtKM9iI
         Wm9LQp2S1ha9qZrU+Bg6Fi8OkAlp+d6P4LfjitFcGcscHIcF5Ui0PiBEIo0Ag2KmUaza
         5ppTEeMtOz+ndb6m8z4WDZBLPvuQVwWyBm+e7a2i7VyavRBZlFwX9Bd7a6tCF2EOCWbV
         l+4beV58TgpJFPAbYdlgi1fvSz2TZVYuDDObTDihwlwDBJfin9TYqWKrTLtpG2nDsMOg
         lb8Q==
X-Gm-Message-State: AJIora9PtUYwxPKhj98nZ0TASFjL4PlwZN9XKaB/mpujcn23i/ypAGUZ
        yjLAfLxP5yrFpHxVSgxAdyU+rQ==
X-Google-Smtp-Source: AGRyM1udS3E55vm1oyA4f9dG+HCY/f/metx7YC5LCY/7klXf+OChmEahji97QdNkhTvrkhGGH6yfag==
X-Received: by 2002:a2e:2418:0:b0:25a:662e:5051 with SMTP id k24-20020a2e2418000000b0025a662e5051mr5149208ljk.137.1655995898416;
        Thu, 23 Jun 2022 07:51:38 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id q5-20020a19f205000000b0047255d210easm3025736lfh.25.2022.06.23.07.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 07:51:38 -0700 (PDT)
Message-ID: <9c7957f8-ba89-4c9a-bd61-d86bca18a546@openvz.org>
Date:   Thu, 23 Jun 2022 17:51:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v5 6/9] memcg: enable accounting for percpu allocation of
 struct cgroup_rstat_cpu
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
Content-Language: en-US
In-Reply-To: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

struct cgroup_rstat_cpu is percpu allocated for each new cgroup and
can consume a significant portion of all allocated memory on nodes
with a large number of CPUs.

Common part of the cgroup creation:
Allocs  Alloc   $1*$2   Sum	Allocation
number  size
--------------------------------------------
16  ~   352     5632    5632    KERNFS
1   +   4096    4096    9728    (cgroup_mkdir+0xe4)
1       584     584     10312   (radix_tree_node_alloc.constprop.0+0x89)
1       192     192     10504   (__d_alloc+0x29)
2       72      144     10648   (avc_alloc_node+0x27)
2       64      128     10776   (percpu_ref_init+0x6a)
1       64      64      10840   (memcg_list_lru_alloc+0x21a)
percpu:
1   +   192     192     192     call_site=psi_cgroup_alloc+0x1e
1   +   96      96      288     call_site=cgroup_rstat_init+0x5f
2       12      24      312     call_site=percpu_ref_init+0x23
1       6       6       318     call_site=__percpu_counter_init+0x22

 '+' -- to be accounted,
 '~' -- partially accounted

Signed-off-by: Vasily Averin <vvs@openvz.org>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/cgroup/rstat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 24b5c2ab5598..2904b185b01b 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -257,7 +257,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 
 	/* the root cgrp has rstat_cpu preallocated */
 	if (!cgrp->rstat_cpu) {
-		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
+		cgrp->rstat_cpu = alloc_percpu_gfp(struct cgroup_rstat_cpu,
+						   GFP_KERNEL_ACCOUNT);
 		if (!cgrp->rstat_cpu)
 			return -ENOMEM;
 	}
-- 
2.36.1

