Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5667F557E41
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiFWOu4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiFWOuz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 10:50:55 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6A846C92
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:50:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b7so23621393ljr.6
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=gJ3rDFLPy4ULApkBUxHTk0EGt0vcK2KI8AydJnC3/9g=;
        b=0PHpaI3mugQcy26zKnEijg+MR8dK+awqtL8Wh5kFKIsrSTwwRJvE7JcyHOvgXYn1RM
         38tko6Dj+NDRhGYQXtJO4BM5KB5cdLN8o5NV2kW27IQBAGnwtM7vRO+fscUUh+vbGm3T
         sqEmCuZbvBmr08aDz2zH5ucV4HFxXPFo2KUehHwPVXJXAKxuqYV78ktJviXMuNgs9U+M
         17Db3nxxr+xFLTbpTNSuCRw+VP06vz+9Dk8stamcHShhCcdE1OmgwJXp9t5kEMq8g9MF
         IAMUaayL75UjHfaw9plqDRmZCXW+u/16I9LZyz9bWBSkyVDguBFHqNaqKUMEejQhmXy3
         brMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=gJ3rDFLPy4ULApkBUxHTk0EGt0vcK2KI8AydJnC3/9g=;
        b=UTnk9yMGRSthFmz2LX0Qk9VwIi4JUR4GJRx+xp5bctpwYPX5/didaKfjxHPUMT6gTs
         AHZJM2MLDIvN5McBAi8NDAxlIbzJ84Q+rdcHv3OYGwf9TDv0RJ13yBJogJ+jPTW64iU7
         aoDoy2zJRw7PyOwhbbDAbKNSWDiqzPZxRMsnOFZ+478RKhv2mr3RcWDjZUIUOOqn0cEI
         87LnLjFAwMszvd/9d3R1X8elHZVP1KyRwaZiAnRi5XrSBkutPKa77LgWXRVkl1m80WJn
         0E101y38bYcENJHwo+KcrnWSjT2adj84k9UTU0qSAuNOHKt13KSKei7lvZiL8dwv1E5G
         tyew==
X-Gm-Message-State: AJIora+wjC5+JEAhsNP3WSpSx7cywXRqOf8xyBp1xeWmbbzqEnf4NvHg
        sCYEHAer8S8fM4dPaO3PNHXUbA==
X-Google-Smtp-Source: AGRyM1vCXz1nYuxbK9EdnwlJRDs/Af+uT4YncjrwcBwC+7+RyvwRka/8mQzhi9po2lTKCsWceGmUXQ==
X-Received: by 2002:a2e:8e98:0:b0:255:9d3d:bac3 with SMTP id z24-20020a2e8e98000000b002559d3dbac3mr4809904ljk.103.1655995851256;
        Thu, 23 Jun 2022 07:50:51 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id q9-20020a194309000000b0047255d21171sm3024207lfa.160.2022.06.23.07.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 07:50:50 -0700 (PDT)
Message-ID: <96263f32-ff9b-c0e0-3af1-1c9f810861b3@openvz.org>
Date:   Thu, 23 Jun 2022 17:50:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v5 1/9] memcg: enable accounting for struct cgroup
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

