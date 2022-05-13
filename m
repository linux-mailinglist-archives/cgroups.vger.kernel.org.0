Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971E2526687
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 17:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382233AbiEMPvt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 11:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382243AbiEMPvp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 11:51:45 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5DC1CC983
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 08:51:43 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id g16so10790807lja.3
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 08:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=BfP2QbXgT8q1zmWgkJaryOzl/XyZ6at33g2N+Nc7zPk=;
        b=6txlcoWsI7zISUGe8NDPxDUvF4kxC8y2X+5UrIZhcNoNC4JYSC+cvbM3sadqCcowD5
         tBTAsgj2kyaKHkYS2MQXT3BnB/qshrnISvYN79+/iIGWgJJaJLjCM2zBwRoMUbxdcKbd
         YWtfJwqfhXXwkR+uTIjD8TZ0BDxmWa6rVDorB1nAFEXWNk6CeK2E6IW0ZLeYf8NgNPxX
         N+hEFX8HsYeMR9oALprdTIkHW+6sTaM1Z3Nrh/FOYbCU7ZQImBQ3NZRUPUoW7zp3Nvi6
         kb1HHi3tcQxLNSCyEGuVbibNfAS2WKstPOQgXJCqc5rLtsuiUof/D2Us/qfbG4/ITDwG
         oEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=BfP2QbXgT8q1zmWgkJaryOzl/XyZ6at33g2N+Nc7zPk=;
        b=zJLXZfE6EDyWKeDpm7/yeDNaqQ+APx/jilN2fKjo5Cn3c0h/XJbSjujsqVX5Bkfx8+
         6q0KSV5xJhuJl181G+1HjPYKfsNvgyeZgLzshUpbdgl4+IvWJ9SKZgriuecbh/d2SGNz
         q5+wqQO/DX8B5uGwqAW6oYgfWizc3kkFxqLih2vyEJoI8W7rVnvhlo1kCvzBKaDt18k+
         wqeacpflLK/rewrCUic0PR67I89juWbGsAiL+k/3xx8XzFKzcRUIjR6ep0NERFH4CcyR
         qs0ZLke9oINcjsEjiREq8zWNAiwlFn1BEYYWEPnHLUIE/9h0IIZbdopKmOrXVheoykZM
         GUnQ==
X-Gm-Message-State: AOAM530vJwvI3QzUcF/JvXZvDcFMZFlhxbDY19lKI9hugq53+dwIa2ae
        lSZBrlA/aEuPQnV8lcdx0rdR4g==
X-Google-Smtp-Source: ABdhPJxkmSE+IMS3ldUTKxPxE84CStz6Z6YAfSmdh4HrV4fjZiG7ldrJshdJ+SjCwTqbfEpNHmlVSQ==
X-Received: by 2002:a05:651c:887:b0:247:f630:d069 with SMTP id d7-20020a05651c088700b00247f630d069mr3526936ljq.514.1652457102115;
        Fri, 13 May 2022 08:51:42 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id b2-20020ac25e82000000b0047255d211dasm413459lfq.265.2022.05.13.08.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 08:51:41 -0700 (PDT)
Message-ID: <212f1b74-7d4e-29f2-9e92-2a1820beff61@openvz.org>
Date:   Fri, 13 May 2022 18:51:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH 1/4] memcg: enable accounting for large allocations in
 mem_cgroup_css_alloc
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup mkdir can be misused inside memcg limited container. It can allocate
a lot of host memory without memcg accounting, cause global memory shortage
and force OOM to kill random host process.

Below [1] is result of mkdir /sys/fs/cgroup/test tracing on VM with 4 cpus

number	bytes	$1*$2	sum	note	call_site
of	alloc
allocs
------------------------------------------------------------
1       14448   14448   14448   =       percpu_alloc_percpu:
1       8192    8192    22640           (mem_cgroup_css_alloc+0x54)
49      128     6272    28912           (__kernfs_new_node+0x4e)
49      96      4704    33616           (simple_xattr_alloc+0x2c)
49      88      4312    37928           (__kernfs_iattrs+0x56)
1       4096    4096    42024           (cgroup_mkdir+0xc7)
1       3840    3840    45864   =       percpu_alloc_percpu:
4       512     2048    47912           (alloc_fair_sched_group+0x166)
4       512     2048    49960           (alloc_fair_sched_group+0x139)
1       2048    2048    52008           (mem_cgroup_css_alloc+0x109)
	[smaller objects skipped]
---
Total			61728

'=' --  accounted allocations

This patch enabled accounting for one of the main memory hogs in this
experiment: allocation which are called inside mem_cgroup_css_alloc()

Signed-off-by: Vasily Averin <vvs@openvz.org>
Link: [1] https://lore.kernel.org/all/1aa4cd22-fcb6-0e8d-a1c6-23661d618864@openvz.org/
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
2.31.1

