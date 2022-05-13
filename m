Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69D3526693
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 17:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382294AbiEMPwb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382287AbiEMPwa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 11:52:30 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAD01F2D76
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 08:52:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id v4so10755536ljd.10
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=B97ovzBTCo6Rpt8pan1l5/t89Mv44hmEDRujwkHt9Ic=;
        b=Gn8g+5fjv7e1DNvpLJ5tu50Zc48R9MGuaEXQSp7RNvhogmOV11JQQefjUfc1WAIjlK
         dJ/Lin0vXk+AFC5NAEVYN2uyQ/gVoUsQbdGSNQXxKRCPgLwfFI/l9Bdy731b3hcb9sZ0
         M9Y0mpjbO9Uy/K1xvNR9RdgPtgC2prB26Xi8anmhW3UIQ1yx1q2nGP5nymZuPcIO4zAl
         d9HNvFH9D6xBd+fZ9EhSkrrOJCdp0ME9jdlh24Az1mJ3jeZXcyBhCoUXZDDqEuirAx5s
         UJSJC4S+K2fYuUMqxdXQJbU8gdSPCbignrbxY+XB/Xjch9vQJ0hN6qZ0RIGgOcOB1QxS
         TuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=B97ovzBTCo6Rpt8pan1l5/t89Mv44hmEDRujwkHt9Ic=;
        b=PvyQ8FjgfuiJs2utNnV68kCZWOP/HnHLmGpFnMId8jTQDIArdPaMbzuUyHy7FmCtFs
         nzbCqWCEFCXtogGVMBY9FQPBYbHms73E/LDjCr8y5tr1NCnOd4ErRUvCgWI9C58LvaDG
         rReHkoDLY12gOKrvu+wMR/gqYlamfJjLbr9O5oundF3p+lHaLvnnkjYvsqha4VvQDcpC
         hsO+gF7shmzTWFClAd/U+DII67NbUUftFefAYV5HXtTZegZP+wbjcEFSYBZjOcVk2NnF
         s2ygEFeLjcQcAqGZaOFYanTGjVuUrE5V/smgQzpLS/uWzDJ+T+DFFptlLYsXqAVQvATf
         A7kA==
X-Gm-Message-State: AOAM531J7bXdE4z1KJ/YXL6OaWGSLbSIqFHasQFadltsEJsWiSctJZOH
        TKFfhcwN7Ieyvt9aMl/FBlXv0g==
X-Google-Smtp-Source: ABdhPJyBUY+emFFcq7o19hSvSlbPeDw+klHuHk2REYp1lLwANVqC7PgqaSFoQ9tA4IAQP6U1Mlbbeg==
X-Received: by 2002:a2e:3217:0:b0:250:896d:f894 with SMTP id y23-20020a2e3217000000b00250896df894mr3436894ljy.283.1652457141899;
        Fri, 13 May 2022 08:52:21 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id j17-20020a056512345100b0047255d21152sm418647lfr.129.2022.05.13.08.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 08:52:21 -0700 (PDT)
Message-ID: <30f5b95a-db87-3924-6ad0-4c302c924ff0@openvz.org>
Date:   Fri, 13 May 2022 18:52:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH 4/4] memcg: enable accounting for allocations in
 alloc_fair_sched_group
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
References: <Ynv7+VG+T2y9rpdk@carbon>
Content-Language: en-US
In-Reply-To: <Ynv7+VG+T2y9rpdk@carbon>
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

Creating of each new cpu cgroup allocates two 512-bytes kernel objects
per CPU. This is especially important for cgroups shared parent memory
cgroup. In this scenario, on nodes with multiple processors, these
allocations become one of the main memory consumers.

Accounting for this memory helps to avoid misuse inside memcg-limited
contianers.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a68482d66535..46e66acf7475 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11529,12 +11529,12 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 	for_each_possible_cpu(i) {
 		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
-				      GFP_KERNEL, cpu_to_node(i));
+				      GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!cfs_rq)
 			goto err;
 
 		se = kzalloc_node(sizeof(struct sched_entity_stats),
-				  GFP_KERNEL, cpu_to_node(i));
+				  GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!se)
 			goto err_free_rq;
 
-- 
2.31.1

