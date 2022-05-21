Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9961252FE31
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 18:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiEUQi1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 12:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbiEUQi0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 12:38:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DD661616
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:38:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bu29so19079119lfb.0
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=Wb/V91Pwh4wB3EAs6xgX+enNMi2t+13tZlysFcCX1i4=;
        b=EhsaiP3edvHWkF6iZ/g4kbDdoucu2Hg9/DwUaWCO1Iu39vG/HSh7DpGYTKIBa8nltX
         7fjwk8jAcmjbcbZJLhP95KzdEjzefrc50ViZXA78q+dlaTqNOQqO/F7nOOFKaFVThoOP
         dU7Wj/9rE6xQZzw0Y2K39AqL7cUZtdLf1QAu1TaSF/Ooh8+2Q74tSwpYs/aw/RKVFDBv
         iDwRJwtQ0zedkl8HFdOeziMW5IH+3q55Nzg0+/Ec12EsHwr+57XmAqP66tl5ItbXKpDQ
         g1/J1VMpu7IVTmXkHN7siOvn389e2ft7AgNIpbEelIf2PqHCdv7vJ9n/x3Yk81guXbQR
         9hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=Wb/V91Pwh4wB3EAs6xgX+enNMi2t+13tZlysFcCX1i4=;
        b=CbAyReeXLTIK5J4PR33jjADrNKVKRTPQ1jLOGxSYKyHVcpiWefzmmVADJQxRzbrVIJ
         j9OVT5/wKbydqsTh4VJRY7bd2O+DCoLg1Zlh+4JJIGIyoFeJQ/3T4VFlLIOuFNdGc1Pf
         6AiCzMpG/hrLTLWMlrGuoYUQHJeUGeEwiz6XCGhg0AipWKgwV3PLfENMIfdJClqdByxc
         j5QRt4c04qu2+koZN0Gin+oHT5kqOx8sRvtAhjM1OhQlZ6yTUwh32uFS6NDjbjzlQnex
         7NEjkeKYARW56dHPvVbpGKEAaIvzuB+fNJE+cdU7cXl/wARJfcMPlJXWD3FcAkzqPt5B
         jeQA==
X-Gm-Message-State: AOAM531wolkDAqxPhcLzgqJYV0445XfvySINwtkLYflEuhFmmSOvCkda
        7EbmVpTO5TacS7XO98fnQNo9gg==
X-Google-Smtp-Source: ABdhPJycYdcmWtOeexBDTeDN18dVHF6RUwKxUM2Ot0xLt2OS/9K5EOP0DVYoEuoz4+XoaRxHeoumVg==
X-Received: by 2002:a19:7104:0:b0:474:d376:2cd3 with SMTP id m4-20020a197104000000b00474d3762cd3mr10438574lfc.175.1653151102636;
        Sat, 21 May 2022 09:38:22 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id bf16-20020a056512259000b00477cb9b8762sm960850lfb.50.2022.05.21.09.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:38:22 -0700 (PDT)
Message-ID: <16f17021-61a3-c6f4-f60c-1acd3a0b66b9@openvz.org>
Date:   Sat, 21 May 2022 19:38:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v2 5/9] memcg: enable accounting for percpu allocation of
 struct psi_group_cpu
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

struct pci_group_cpu is percpu allocated for each new cgroup and can
consume a significant portion of all allocated memory on nodes with
a large number of CPUs.

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

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 kernel/sched/psi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a4fa3aadfcba..f0b25380cb12 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -957,7 +957,8 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 	if (static_branch_likely(&psi_disabled))
 		return 0;
 
-	cgroup->psi.pcpu = alloc_percpu(struct psi_group_cpu);
+	cgroup->psi.pcpu = alloc_percpu_gfp(struct psi_group_cpu,
+					    GFP_KERNEL_ACCOUNT);
 	if (!cgroup->psi.pcpu)
 		return -ENOMEM;
 	group_init(&cgroup->psi);
-- 
2.36.1

