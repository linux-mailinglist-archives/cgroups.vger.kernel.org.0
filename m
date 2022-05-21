Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4170E52FE25
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 18:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245698AbiEUQhn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 12:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245664AbiEUQhl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 12:37:41 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A5961616
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:37:39 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 27so7696009ljw.0
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=xrngHl+k++nVK8AbvZFVt0lPwWgRKfDuqq3cdMG2V38=;
        b=f1PXoIqYpQV8rPyrcOXuJMO+8R6A7YB7wOl2JgT1Hf6DAW3jEWx8DiwYevJN9foxuT
         xqiD1JUsuSwtjJZzckPQ3HIyQb9qTI5GEoRhiia9vtQ1x5RRZdszPcxAfZwYVEI5c33b
         VjnW9ysQLT9rOXQIiehcO96AGCYWBcl4Amg6kyIghtr3Q0+4ub1xxGeYiUIjoUksEB7o
         X/6VCEapIUnJBuwQ/DxpPiakNFhwFkl9PWhuGlK64PbQVDgPjgD5RGN8Q/2bPlNgcAPY
         6q7Eymqt7gNxIWnXR/Qc5Ho3xK7NewmCD2fraMyhTaUzx2AQl+FnXT2wNDTbKpRYFgAj
         gQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=xrngHl+k++nVK8AbvZFVt0lPwWgRKfDuqq3cdMG2V38=;
        b=lmvFMl4PiDeLSWmtgWsTthzZzLVhefHTUxsB3GMFAztYJ/00J1Tx1bG+Rl47aAoSSt
         G70E7y5Frb8asuglyneRFJzRo0SINZtFG6RWy9M1qWfj1sCPDSezRmcwPJiuA+QBfXmq
         0H4E9j7XQ7qduyau/uedUeRXzAnREDePs2657ahFsXJ5CnMEVgxhdeZNLBTXCvMoyasI
         oRIhW14hdj+tyZXdRU2qhBujFVwiFK2xoushpbdsOAwob8PUye5Fsz+BTK8foVdANfEY
         3RoE9sgxZXXMtBc+6eBcACwGQPEwsFgnSGzdzgMTjqfUSePh2CWVU7jlfyFI783jYFJA
         AnMQ==
X-Gm-Message-State: AOAM5326BmfWwo2voxeP49onrK2bL3ZJB2s1ZxbeZxUs+eDgYBEBpuy+
        CTLPzdwoGNU+ZfcO/Kiu9D/gCA==
X-Google-Smtp-Source: ABdhPJyK+2dAF2mDmvzbdrtAY2ubkJvsKXq+zufNECKywzZuKACWqwQFPtM6ejdRbkkXoekoqH7oSw==
X-Received: by 2002:a2e:a493:0:b0:253:d23f:16d9 with SMTP id h19-20020a2ea493000000b00253d23f16d9mr8212181lji.446.1653151058102;
        Sat, 21 May 2022 09:37:38 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id f5-20020ac24e45000000b0047255d21141sm1116573lfr.112.2022.05.21.09.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:37:37 -0700 (PDT)
Message-ID: <a76dc143-68d9-41f4-81d1-85ec15135b1e@openvz.org>
Date:   Sat, 21 May 2022 19:37:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v2 1/9] memcg: enable accounting for struct cgroup
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
References: <Yn6aL3cO7VdrmHHp@carbon>
Content-Language: en-US
In-Reply-To: <Yn6aL3cO7VdrmHHp@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Creating each new cgroup allocates 4Kb for struct cgroup. This is the
largest memory allocation in this scenario and is epecially important
for small VMs with 1-2 CPUs.

Common part of the cgroup creation:
Allocs  Alloc   $1*$2   Sum     Allocation
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

Accounting of this memory helps to avoid misuse inside memcg-limited
containers.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index adb820e98f24..7595127c5b3a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5353,7 +5353,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 
 	/* allocate the cgroup and its ID, 0 is reserved for the root */
 	cgrp = kzalloc(struct_size(cgrp, ancestor_ids, (level + 1)),
-		       GFP_KERNEL);
+		       GFP_KERNEL_ACCOUNT);
 	if (!cgrp)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.36.1

