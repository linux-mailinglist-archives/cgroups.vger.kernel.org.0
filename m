Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621135379C9
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 13:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiE3L0b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 07:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbiE3L0b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 07:26:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5957E1EF
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 04:26:29 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s21so2565145ljd.4
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 04:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=xFFlfL4fe1ilOdXrhQDtJsKH7Nsk6vFtTN8mntfqwUg=;
        b=34zCQZXlG6JFBzjyCw0P2LGetND/flm33L/Fc6uf6jHK6/jEfMO96WNnf7hXhsDOas
         vlwNhLfTkafo3h9lT+WD69MjpNURqriIr07F8QtefHyBUTaEmU8U483Y1ln8oOuRxbpp
         LR4GsOA+lHlX1CBAj+3X99k3UES9/06Fbi80YUczOu5arE7/vqr02S58TZWW8WtAQnxc
         YuucM1hIVCx2HLssP7y2ZKkHD0uS5v6R2fTS4ubTc1FG6IRG4hxPb/nYOG7cDQglfeiH
         mC930GXFgsHBQqKKrjUzfs6TUJacEj78xhRipAbhjT0duobsK209zKxFbdiBs/Dxk7hO
         dPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=xFFlfL4fe1ilOdXrhQDtJsKH7Nsk6vFtTN8mntfqwUg=;
        b=rA0tVUaSmQ0pYTsgiuqdjQzzWH9dRvkzHSbDxADp3X/F8F7aDhwDH6PV9LO7+wsoZc
         ZEKIi0wJC3BNAqYPkOKrbplN2PtnGQJdcODBh8EKZnqs58HjsmAO4QH2FgrkMNC8BS7S
         YzIU6ofMpt+0vsFqxQ9gSow6cvFlvGnOGw8jIOXAdOrhbq7QcyGD5t3MHmf1OvEzRrYB
         wS+TInCf/DbfaiugZIBT9Ev71LNTExlTfgxrjRY7F1t/R/008Q2THFHZC/JSFl7sqzbd
         xoltpenrSROfzmffN7Li9xXSXnd0ZlCxCUl4K0/I7EY2u96PG2EjngGBTP600nUmXPWH
         ZX5Q==
X-Gm-Message-State: AOAM530+pVXhZAjanhjtqUKZ3MlUUTmV8vikTgBIwNIz1JP4Y74Cuza+
        6y+uvi9ZKbp7yrBkRY2Ew3ebkA==
X-Google-Smtp-Source: ABdhPJxCJ6sTGconlZ2JSDy56+27tW1S0trFz6oyj8F6Kf0ZuWKb+glnsL7hOcGAu4nGq2JRmyyVxg==
X-Received: by 2002:a05:651c:98c:b0:253:cc50:4374 with SMTP id b12-20020a05651c098c00b00253cc504374mr32878860ljq.274.1653909987912;
        Mon, 30 May 2022 04:26:27 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id e28-20020a19501c000000b0047255d21130sm2259269lfb.95.2022.05.30.04.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:26:27 -0700 (PDT)
Message-ID: <14a70615-1240-9538-8be9-b2aedcb0fc11@openvz.org>
Date:   Mon, 30 May 2022 14:26:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v3 5/9] memcg: enable accounting for percpu allocation of
 struct psi_group_cpu
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
 kernel/sched/psi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a337f3e35997..f3ec8553283e 100644
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

