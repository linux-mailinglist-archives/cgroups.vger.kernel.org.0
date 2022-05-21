Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71D452FE33
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351436AbiEUQis (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 12:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353549AbiEUQir (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 12:38:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448D362BCC
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:38:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v8so17061745lfd.8
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=eKY7dBXMF+LF1efr4OS98ZF9YSsGHBm760SPqeFCaAs=;
        b=Vg+HXKWzRy6K6ypOrMl5as2kxnq+YSAo0DuRJ7Kcacy6m36tH68eCqgWBMhwtoeZ1G
         tv4yq7SeY3Q0gN7YPHnBgcPqW9hYj1tXlfNleVIA9e9hvddDiOXmhlurzFJt1ZzTBOqd
         nBL2/f0rtnmLOOsYpRbzlMbLW46vEqgqyEF8zXqk1bnGWP98l5gvlyPbc0JiExSdKRCC
         W4GK+RqAmZ+4i/O+SQj1HybVQeWSucsi+kYj2to2yRsjZtjtzwph2nvugbzHRVt5UiJW
         NquvazqC8mbbKdg6OLw0b2uuP3N4dkrHb/7+XItkGdRL78b7YH4uivPmV86g1mgBoygC
         CCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=eKY7dBXMF+LF1efr4OS98ZF9YSsGHBm760SPqeFCaAs=;
        b=maA2mn9midPttByMxHQhq4YcKnRSdCysFdsCv02y4ytJe21mGJQkjXjjspWNerX4JG
         BFPdytA/zUmL6VkaTOK7ZRN5QCUdVJuxiirZgxSgmM58UfEMMiSBkRw8BXXvojtsRF4p
         /XScaELj1GeNdF09yPsPpFq67kvgIxcoBKLZ0IFQNU83qOP97LaOnQRKAY0tVv+o6r25
         Q5wOnTPzXXsRuqMPTcNZ1gtzPiDxWgHOUIdd73bNPi2wgkufiXUpoHU5v1LECD8VcHYi
         G9z21i20iqzvRZyhZkS+Te4O929n1x49VoIpc0QlakzXOYitZvHeyIYluQJ8jUeV5OCn
         dRVQ==
X-Gm-Message-State: AOAM530Dre70eADciELPYz+uX9ZjPFUuQlOAkq0uiEgk689gxdUxuQwQ
        k3Bsoo+UIGzOUz3gn0LRNm++gw==
X-Google-Smtp-Source: ABdhPJz6RwKLYkIBZ0TvoP0/coGiVSE/H503LHOtW37hqWvK0llSh1Zjmp5RX3Iz9TJhAqsjcEJKsQ==
X-Received: by 2002:a05:6512:260d:b0:448:35d2:f72a with SMTP id bt13-20020a056512260d00b0044835d2f72amr10926563lfb.515.1653151121595;
        Sat, 21 May 2022 09:38:41 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id x7-20020ac24887000000b004742b9065c4sm1113439lfc.230.2022.05.21.09.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:38:41 -0700 (PDT)
Message-ID: <9925d0ba-40d7-e3a8-1fef-054968b26ce6@openvz.org>
Date:   Sat, 21 May 2022 19:38:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v2 7/9] memcg: enable accounting for large allocations in
 mem_cgroup_css_alloc
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

Creation of each memory cgroup allocates few huge objects in
mem_cgroup_css_alloc(). Its size exceeds the size of memory
accounted in common part of cgroup creation:

common part: 	~11Kb	+  318 bytes percpu
memcg: 		~17Kb	+ 4692 bytes percpu

memory:
------
Allocs  Alloc   $1*$2   Sum     Allocation
number  size
--------------------------------------------
1   +   8192    8192    8192    (mem_cgroup_css_alloc+0x4a) <NB
14  ~   352     4928    13120   KERNFS
1   +   2048    2048    15168   (mem_cgroup_css_alloc+0xdd) <NB
1       1024    1024    16192   (alloc_shrinker_info+0x79)
1       584     584     16776   (radix_tree_node_alloc.constprop.0+0x89)
2       64      128     16904   (percpu_ref_init+0x6a)
1       64      64      16968   (mem_cgroup_css_online+0x32)

1   =   3684    3684    3684    call_site=mem_cgroup_css_alloc+0x9e
1   =   984     984     4668    call_site=mem_cgroup_css_alloc+0xfd
2       12      24      4692    call_site=percpu_ref_init+0x23

     '=' -- already accounted,
     '+' -- to be accounted,
     '~' -- partially accounted

Accounting for this memory helps to avoid misuse inside memcg-limited
contianers.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 598fece89e2b..52c6163ba6dc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5031,7 +5031,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
 
-	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
+	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL_ACCOUNT, node);
 	if (!pn)
 		return 1;
 
@@ -5083,7 +5083,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	int __maybe_unused i;
 	long error = -ENOMEM;
 
-	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
+	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL_ACCOUNT);
 	if (!memcg)
 		return ERR_PTR(error);
 
-- 
2.36.1

