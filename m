Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7BF52FE38
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 18:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352121AbiEUQjM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 12:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352898AbiEUQjK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 12:39:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3001162A20
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:39:06 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h8so12646487ljb.6
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=6jvwz9W+Iz8zAbRj3RpjaqWTb9wfhWcoLKf0WgDlxvc=;
        b=z+7zb9+IXLxjeouRHXJcNV0+xrS40uzvpcAPCutozFR8IWdb2KWc/t9yiKX/jyzhj7
         ihKo6se9s6Vpj74Ev9988DNbDjBpqQ9URssroOdAgjND0KNPrfzja3+LfQqRSt211upy
         XTHVRdiyknklG9q0+EsRKSJ61ETF6Vql14xb+CJcmFGQ6vie5QKGaRXPmWr/J2nKoaI/
         nT3hsQNrJRvfvxSOrCUyudJPIkr1d3kKz/0mUU1OdsImWpQO6lswnLjdQeCY2UJCxDIl
         V742mWQPrgdj8a5cPsG23+DzDiB7dOIBqa2RBnHd2qrPzm5ObIXJCp6x/9A4wJfH953N
         D8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=6jvwz9W+Iz8zAbRj3RpjaqWTb9wfhWcoLKf0WgDlxvc=;
        b=i73qElgubmU+0UcqdXWxzMKEGNKbRN8h4rOuhZurKv3IXQAidCPjSGsQaqTAMW78C6
         YIDYpVlkr3lV/M+LOA+XVCabj4PWUz/QpF7GxVkTYQyDaLlJLwMA8LmviGg/aDGXrFpu
         yclZj2wRp2LDBXkVoDyycY2n3bcO1fJY10e3LSnqc2cz+89hs7vQYchi16FqKcXCqu+J
         0xQlZr6VLaa9Xy85oZPWMJ1OwPfpODdR6sZAxvbiSrNZSpjRCWfjEZkpTHfKAd8TVf16
         DcA2ZW0/1mtVwW83TEPSR4y8MBEhh1m08eWnq0qFKCY46psi97o7xXd1rTl7xW76UXi+
         heuw==
X-Gm-Message-State: AOAM532uo9rOWJ83L239RSu+1n/R5bNNF4Rs9iSxIqBAEqGKyNOM1spD
        AzQoxkaZW+vy0KuRMCtIzZEEjBNEX06OKg==
X-Google-Smtp-Source: ABdhPJwESwCRKsT3SE0KVf1P6qFBGEENgiZhi4z+Brhr2mpq4ABVXurNZOp7vhcqPQJa/mmmwXhvBg==
X-Received: by 2002:a2e:8e78:0:b0:253:c31b:d059 with SMTP id t24-20020a2e8e78000000b00253c31bd059mr8065091ljk.393.1653151144466;
        Sat, 21 May 2022 09:39:04 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id s22-20020a2e2c16000000b00253cb98580esm769593ljs.132.2022.05.21.09.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:39:04 -0700 (PDT)
Message-ID: <d7094aa2-1cd0-835c-9fb7-d76003c47dad@openvz.org>
Date:   Sat, 21 May 2022 19:39:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v2 9/9] memcg: enable accounting for percpu allocation of
 struct rt_rq
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

If enabled in config, alloc_rt_sched_group() is called for each new
cpu cgroup and allocates a huge (~1700 bytes) percpu struct rt_rq.
This significantly exceeds the size of the percpu allocation in the
common part of cgroup creation.

Memory allocated during new cpu cgroup creation
(with enabled RT_GROUP_SCHED):
common part:    ~11Kb   +   318 bytes percpu
cpu cgroup:     ~2.5Kb  + ~2800 bytes percpu

Accounting for this memory helps to avoid misuse inside memcg-limited
contianers.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a32c46889af8..2639d6dcebe6 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -206,7 +206,7 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 
 	for_each_possible_cpu(i) {
 		rt_rq = kzalloc_node(sizeof(struct rt_rq),
-				     GFP_KERNEL, cpu_to_node(i));
+				     GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!rt_rq)
 			goto err;
 
-- 
2.36.1

