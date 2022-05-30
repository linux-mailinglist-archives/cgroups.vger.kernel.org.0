Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3771D5379DB
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 13:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiE3L1a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 07:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiE3L1O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 07:27:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B57E4CD51
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 04:27:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id l13so16186444lfp.11
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=ZH9yvId2NMAw4oN1iqMKqU61/DZ/rIDZexlE6dKv8SU=;
        b=qSiaNr2ftUqSRvmOy75IJeNCKAVgq/jO6yIuIwj9lTeotjFVJ4+oMFaIk5uft9Qvbs
         l+4EitDawXs9/hDAY1ZW4DMfHukqi6UArXkOO1Fsh++NpRhYgntK5BVNeajvyod0xNbd
         /yEKhndXFUITINHf3AsuCHklX308rL2W0TxU0lyGgS31a7Um1/qC8RkNmyIWqmdjEZqv
         sBD3tvK7pX9DrDUQh/vJKdquM5bFHwtxZMMOdowmUVGdozFLqM96xAnlkIXWMx6XY71P
         q0W2yFeBw4MsVyY5vKggC//seES0ntiWnGoRO7EkwhlnsldeBMzNk5fW75QX3HKgwNYo
         7OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=ZH9yvId2NMAw4oN1iqMKqU61/DZ/rIDZexlE6dKv8SU=;
        b=pBEW1FkKmFbu+tZtJx98dQKZPXjA4APOthB7m18uTONmknSx72cwDLRE1jakV7IOgK
         9O7KhhDFK0sflYwahVo0+Go1qOroW8UX3M4JKRgZRrvkKPw41yNMq1idpcjI1T68xLHF
         6q2GHRw1e4ImBB/Rj6+Ktwef6SDxZh/cVVkOEM+RbWpoqYGTVtiO1XkrSRsZSqPpHg7l
         tqWkXfbHoj16FMmKkdpFuEN11XewWnM8MXN+f0QURZAJPfjv4pjB0aTCt9IIBti6TSxA
         YsNeuQDU1TdJHcYgqfo010Jtv+YCDwkEtFv3d/HehP92PE1yRl4iAIkKy+VAaqsRcYtG
         E93Q==
X-Gm-Message-State: AOAM532+OasS4DnTwKezLF/bw6aX1bL4+FMsLMjA42Fph3iEFkwGNNLc
        SrBLUCNwhlpQY2jxEPJHrc6K3Q==
X-Google-Smtp-Source: ABdhPJxWZqPdDmaExmQ+szJPGiMjUbrO/s6wpfxiy7JGg6o16TpJ95IhHVKm74g0zXeSMO1rmg/5jg==
X-Received: by 2002:a05:6512:22cb:b0:478:d66d:f750 with SMTP id g11-20020a05651222cb00b00478d66df750mr5768811lfu.291.1653910028823;
        Mon, 30 May 2022 04:27:08 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id a2-20020a19e302000000b0047255d211bfsm2253577lfh.238.2022.05.30.04.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:27:08 -0700 (PDT)
Message-ID: <a1fcdab2-a208-0fad-3f4e-233317ab828f@openvz.org>
Date:   Mon, 30 May 2022 14:27:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v3 9/9] memcg: enable accounting for perpu allocation of
 struct rt_rq
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If enabled in config, alloc_rt_sched_group() is called for each new
cpu cgroup and allocates a huge (~1700 bytes) percpu struct rt_rq.
This significantly exceeds the size of the percpu allocation in the
common part of cgroup creation.

Memory allocated during new cpu cgroup creation
(with enabled RT_GROUP_SCHED):
common part:    ~11Kb   +   318 bytes percpu
cpu cgroup:     ~2.5Kb  + ~2800 bytes percpu

Accounting for this memory helps to avoid misuse inside memcg-limited
containers.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8c9ed9664840..44a8fc096e33 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -256,7 +256,7 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 
 	for_each_possible_cpu(i) {
 		rt_rq = kzalloc_node(sizeof(struct rt_rq),
-				     GFP_KERNEL, cpu_to_node(i));
+				     GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!rt_rq)
 			goto err;
 
-- 
2.36.1

