Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE295379D1
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 13:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiE3L0B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 07:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbiE3LZ5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 07:25:57 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE307CDDD
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 04:25:55 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id v9so11261514lja.12
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 04:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=gJ3rDFLPy4ULApkBUxHTk0EGt0vcK2KI8AydJnC3/9g=;
        b=qqG593hJBCUB/gBVGHwV+mSoLplrSbhyFYq3PDBSf9ltBe5cbhiDVTixDWLmpRgpSF
         iwnEYJ3CldnWOW++RbsHRj1dDdnf1ACIBj4U5pFXbGUTGG3PIfMCkkFZ4O9pmyMTQZdr
         +bkD/2gvyOgyI32Tq9RvL0Gk7HXu5G8aGokuVFTqDri1kgWoFxAnzbvNkMZGwJ7X0pC/
         Vo4Yib/yG+2PfVpjYrCniWHVoDRH8VE4U4ratzu+Ki+d0mlBS/uoNAO/pkdhAlbDd9zT
         0FEfj/BPuCe07LV8OQdVYc8sBe4VAlfFQn8tOtL08gUYChTRAO+LzL4aGvw7Uv/RDEi4
         vNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=gJ3rDFLPy4ULApkBUxHTk0EGt0vcK2KI8AydJnC3/9g=;
        b=vkUIOfg820Mtf7Hj3E3MXVsI8gTjOKvx61J7qJ321CsKmLuYdVZbDVM7cxCu2AMIzQ
         NFRBSaEmrbagVs1UVaCak4tTXMn9e/iYp02NBZjggOFi85T7VCMhB51NS4qWKBdVAkDk
         WYEswHcsFIFr8/yReNBSPeAMuBaU4h7c1F8DwBLSbGIzOyGQMCTZgjftszytVskqz8aP
         U4BjQjVoK1HvWh8uOWQPWG+B7EkmGkqewk5Pi0b/dlAhJMjss2wZ/NS8X0TvOOdjgf3g
         nlF7uu8fhejPawWqvvNM2TcCtOfdDAuDrd1jyzJ+oT2VGDSUFOk2dJUEE1rsVSaPXCDI
         yLWQ==
X-Gm-Message-State: AOAM533tgcMb8q9eMOAiQCuA2FORoGTg+wOTiWGGYBqmUKD2/r0M7AKL
        onZRle8LPTvY2SBon4i85A+/DetQjaLUIw==
X-Google-Smtp-Source: ABdhPJwmjz88tGcrOrlUOP44xp6aECdhqP3RDzmVcmv4VYqMwXbCOzQjYnYmz7JSR3oN8WHm8UMpkw==
X-Received: by 2002:a2e:81cf:0:b0:253:bbe0:c047 with SMTP id s15-20020a2e81cf000000b00253bbe0c047mr33677010ljg.311.1653909953751;
        Mon, 30 May 2022 04:25:53 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id bq3-20020a056512150300b004787c77fcebsm2246335lfb.289.2022.05.30.04.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:25:53 -0700 (PDT)
Message-ID: <8d20322e-928b-e995-bd5d-0695841c526f@openvz.org>
Date:   Mon, 30 May 2022 14:25:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v3 1/9] memcg: enable accounting for struct cgroup
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <06505918-3b8a-0ad5-5951-89ecb510138e@openvz.org>
 <cover.1653899364.git.vvs@openvz.org>
Content-Language: en-US
In-Reply-To: <cover.1653899364.git.vvs@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccddb734..1be0f81fe8e1 100644
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

