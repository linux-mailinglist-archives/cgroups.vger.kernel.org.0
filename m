Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DC9557E4A
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiFWOwT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiFWOwH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 10:52:07 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE794833C
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:52:04 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id n15so11989730ljg.8
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=GpreIe1vVrFK0GRTTTBCrmu4K38+/AoKp6X51SotBdU=;
        b=2uzehPa+7Yh1/1yI1Z5UrlQSBeyJcy6RsaVimJTiqlPLLRwUTOoHga1Wb1egu6p0wr
         H4yVijZAlfpr1xU4lEH1LNys0LFqKbKhTvHcKfJN0QQnqLklYEEUW4JNuFdZP9h1Zlmu
         pgUzAi4h5gzZMlV5HEAx9NHHw8mHh72qr5FZF9tx+uUOCdvUuPNtzgsxyZItchwHqvwc
         27BKuqvxrJvJkYcdvswWerNHUVfq4ecN5rBvXuLkqYoXEhXdLKw9vWYgZvIb6gFgw7Ec
         QNjDw3kOBNAZtq1hleAu9lG2BqZJu4Y1MITm+G0yIj7c0AYmDdz9vRi8wuTMvlSLeK+8
         uS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=GpreIe1vVrFK0GRTTTBCrmu4K38+/AoKp6X51SotBdU=;
        b=LfxRR1zaLx4vH43t8+iIiPk8BOUVvIWfYbsUt9lh3eJ/+Ou3LK1kzy1zCiE2mLXdn5
         Qy4QOC6pFgpxNRinNlIc03ly6Z5+vdcQ6/ikPJkRf73Sj5ipd4u3xJENZbWRJylTA+5Q
         Ixiza5uMyfljVWFaeOWzy6qT5UwqeZUUoyQ5d8TVk30kXQ4FDYaMcwzIpGRUO1o75N3a
         fFp0ftUyUGXzYIy07ertX7qEaW7L/VVOT11wzKLi+nPYDDWDSltITZ4PJp0ovY37JBoj
         J7GoekDBFsaTR7NFqfSUNHajyw++A8N6D5Z45LmWVmcXqU/8OxaXNOtonOOFwdbzVSW0
         X9FQ==
X-Gm-Message-State: AJIora9upTZiRv4IWIh8fsrMuQAjtislQ7RvWkviwk65gAtFkjvuO1np
        KDPL0AbmIeT4L5/YX8VSivC5mQ==
X-Google-Smtp-Source: AGRyM1tPC+bd/t6EAqAmy50rsGPhX0wzCtEVeqe8450OaAKfA0Mm3KD6F91h0GbMVpg/lGxD+y3qSw==
X-Received: by 2002:a2e:2e07:0:b0:25a:4bb3:a2c2 with SMTP id u7-20020a2e2e07000000b0025a4bb3a2c2mr5083546lju.450.1655995922945;
        Thu, 23 Jun 2022 07:52:02 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id n16-20020a2e7210000000b0025a6f7000c0sm1547457ljc.11.2022.06.23.07.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 07:52:02 -0700 (PDT)
Message-ID: <a4d96dd1-63ec-7a14-3039-9901d7e38244@openvz.org>
Date:   Thu, 23 Jun 2022 17:52:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v5 9/9] memcg: enable accounting for perpu allocation of
 struct rt_rq
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
Acked-by: Muchun Song <songmuchun@bytedance.com>
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

