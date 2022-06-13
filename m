Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E54547F2E
	for <lists+cgroups@lfdr.de>; Mon, 13 Jun 2022 07:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiFMFhA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jun 2022 01:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiFMFgZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jun 2022 01:36:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6222D12AF2
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:35:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s6so7074289lfo.13
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=GpreIe1vVrFK0GRTTTBCrmu4K38+/AoKp6X51SotBdU=;
        b=pOR7O1t5o1xCznms3YZVoDk//h+f8/fV4zwbTF71juOxY1C62zNSCCgDsAvK4WX+hN
         wsAJDy6ZwBwLoUy5BIB1oRNm4wHPLlfZ8DY1WmWTBalya5YxORe+47B+QWkq1whgFSPE
         NALVRGhpOBGJ8npvVljSdkejj7UwD33OQ3IXaaMzsb2YhN9Vd+x0GS1QdHn11aYnQdbh
         j81zIPiB/Y6l0WXfdX+sWHlsuHGnoM1TO/QbZl7dZQxj68I7nAVGUydJvYKOvwTV3L55
         15XFDDiDYb79xpH1rJssMF4rPQd99yM34z3FIvgplvSdziiZXPCcdj7IYtwxn7W+CSWX
         tHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=GpreIe1vVrFK0GRTTTBCrmu4K38+/AoKp6X51SotBdU=;
        b=C0/OmezGws5LEuS0ABXtdjQGvih2hbRVbHCI+PrReKJEpJ7yG0ce4fDeuojLU4Jfle
         xXF7bFccF40NqbIhv06GXkFOEoNhZPJXQwgRqmbRWvCzyHYRH0DMaqrZdhTmHuXSFzmX
         cf37s/P3ft6KF/CvEbUEORhAJsL8pqaWugDLCJLnR2ym6Ar71vjyjTs2POcwA63WF2BR
         pp0AUghSvkaKCG5VUiTsDQCup5H75ue0GG0P2/HFTiE/+LJ7jPy3OBexBlVkSMd3UZbk
         eOfrL3SOlY3z4+c3VH8YOOjRrDTjNQTxNgjn808IEpr5oaLRg61seIP9RKT5K4+QrSne
         22Sw==
X-Gm-Message-State: AOAM530guEJYCA/sPO6oIZ3B+bxUC17RBZQrmQsu92MZsu5sEofcOmOF
        fkEqw8Szij1O4jxUW1eQg2oUZQ==
X-Google-Smtp-Source: ABdhPJxPvSt6k8AUnB6ZJ3SMXvAsv5IjtCPcbXB6Mfc+ct6OavP454s3ddoBvVuHhuA2+bplOYHLag==
X-Received: by 2002:a05:6512:3dab:b0:479:56a9:d513 with SMTP id k43-20020a0565123dab00b0047956a9d513mr20487427lfv.531.1655098551395;
        Sun, 12 Jun 2022 22:35:51 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id m14-20020a056512358e00b00478ed80852dsm847592lfr.58.2022.06.12.22.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 22:35:51 -0700 (PDT)
Message-ID: <fe741e8a-b729-1efa-ff63-137cc29adb6e@openvz.org>
Date:   Mon, 13 Jun 2022 08:35:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v4 9/9] memcg: enable accounting for perpu allocation of
 struct rt_rq
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <3e1d6eab-57c7-ba3d-67e1-c45aa0dfa2ab@openvz.org>
Content-Language: en-US
In-Reply-To: <3e1d6eab-57c7-ba3d-67e1-c45aa0dfa2ab@openvz.org>
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

