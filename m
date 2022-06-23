Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA54E557E3B
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 16:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiFWOvj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiFWOvh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 10:51:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15547473B3
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:51:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a2so33793596lfg.5
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=waMbR4Vj3d2Yx3tC82MaoYQ2maUSxBJAR+0Iakz5FDI=;
        b=YNvr4xo3AtwQzeXJO0a0Zs/pJf/cfhwOyUbueOMf0dW7rfYbzeNXzzeTckjXHZagnx
         IL85gF0d8dj8iu8D/NKKFFpKBqeU48c+utRpVkVyvj5DixZAKXeknlRq8N2LyZGOTi+R
         hGN8BepYHBGzguV4vsrHooHWcagsJSb29bCFzzGcw2QHmp3PiwCLs5lRYky96HtSBt7M
         EA4L0Sp+aBwKz/fZyvAIqFUTbxk9l9Tji0K20GNE67AGI98/zeiTxuFXgKawjUa1NN+o
         2Sces7CzSgUk2DMCdi7DOn11celMtSmNASSbOpBFHfM4AG9IAqxKziAlLGfROZMJkciM
         MZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=waMbR4Vj3d2Yx3tC82MaoYQ2maUSxBJAR+0Iakz5FDI=;
        b=hsS/oRX0F60A1IxPU1aOpOvxzkHmKsFB0G71tVQiVegFOXCaKwEI0XX8Z59U/+QAx9
         LwICU1gz4yuufOEPsob0G7on1DDWo1rKTTCqB3sUHacO1IwHf3P+tncAa5/YclUiJ8Ad
         +AR6FMv9+6RaudwedX8Uyt5/7fiJ21nK9qL1KIz6HlFq5EJICa7qlKkSgw4EBIA9geBB
         JXK4eKNunzqx0Z7y9rI/SpvM6KqIzQE158NLPTr6SP2kTMIxWHsvPNxf61uPmJft9gEH
         fbCgKVqOePMP28soa9ZvtviWZiGkfBHqXqb8Rrpvj1nMZvW9GlBJwdifmbcutiKJ8YJt
         ic7A==
X-Gm-Message-State: AJIora8g/Fr6xRRQrzqM93BmvPf/ph8KXExYI57nCymqwKZJ44BEZqOI
        ZRHeSDKTzah1fKAAayR99NohgA==
X-Google-Smtp-Source: AGRyM1vjQLvKYp0+eENX0/rDukz52soKH3xoEj53Z2BfUrKic9B7uCsBN+XLEWAdw3JqKLyNVVN0kA==
X-Received: by 2002:a05:6512:228c:b0:479:7a60:5e0c with SMTP id f12-20020a056512228c00b004797a605e0cmr5584521lfu.323.1655995890370;
        Thu, 23 Jun 2022 07:51:30 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512203000b0047fa40b5052sm354193lfs.62.2022.06.23.07.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 07:51:30 -0700 (PDT)
Message-ID: <b837e43e-f05c-9ae7-a582-c6d2d5907ea5@openvz.org>
Date:   Thu, 23 Jun 2022 17:51:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v5 5/9] memcg: enable accounting for percpu allocation of
 struct psi_group_cpu
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
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a337f3e35997..0da10159d3d9 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -957,7 +957,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 	if (static_branch_likely(&psi_disabled))
 		return 0;
 
-	cgroup->psi.pcpu = alloc_percpu(struct psi_group_cpu);
+	cgroup->psi.pcpu = alloc_percpu_gfp(struct psi_group_cpu, GFP_KERNEL_ACCOUNT);
 	if (!cgroup->psi.pcpu)
 		return -ENOMEM;
 	group_init(&cgroup->psi);
-- 
2.36.1

