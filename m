Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2C3547F1F
	for <lists+cgroups@lfdr.de>; Mon, 13 Jun 2022 07:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiFMFgY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jun 2022 01:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiFMFf4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jun 2022 01:35:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7BE12A87
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:35:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a15so7097461lfb.9
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=B3zm8wtF1vA2GYm2+mdF7egB2sMmmpE2kcaPBaO2eto=;
        b=aNTN9ecStVPQ2d3BHO8r2ERVbHTttzP8TpBGu400gwgeTcHpH5cOc8cGKcJF5B4VSG
         Pl404daaNaSR+XfYhnMPIJuJDZNnXll9sSKc8Bl7DpIBinOElRj9Cdogfo8nhbIPgz6H
         LEhnRv6PLI/1q4OQhQVbZHRXsvpYNjKANwS6bgzq+oxPSUzB7Oijv5PyZP6r2dUx8G0b
         5/U0JAHLUzb4KnI6Ev9AKyFvBj77iQEV+KqIkwQ1NbPYXEy0SxOYw8Yaln47mLwPQ3Ko
         TdBRQtjCGU4GK/9EIclgy8Gop96FJszFi5oVXiUUTrnqwe52akMXbhog8arLPS0+Gyux
         fXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=B3zm8wtF1vA2GYm2+mdF7egB2sMmmpE2kcaPBaO2eto=;
        b=AtSsRJh+eM89d0dOc6YuLAkqCU2jpd/jBeMxKrtezms4VmunDT43fBACCB7ANEo51c
         y5/v4BlsI6QeAK9KtC+9YM9gT9KSoSz1qp8MdkKBGhA3oymuimVwthBHRxpfOxrmOzYR
         ZgPVZe/gD2WEYK1hPGVABx4Av3TDOBlNH/0UQRcGs0H7A6qxyN1N7lSIH3WsSJ7GGOYb
         JVfyGrJOpJzJcSmSvPLu/JL9XwI01YHSpmp04wACf9pmCPv67JSPPuIsX0P3mh1uifye
         9t5Ekw3ypF8llHWAeNiWJHTRipAvSCaJAYj/Y7sTeGujbwkbjlQCRfDKK8Ng6jnCSG38
         YPLQ==
X-Gm-Message-State: AOAM532hXPpu+M1vKsn7qmvCAE5QcAsnvfTn6EB7M0dzLWw2WEGNQFTr
        n5cBQdJYLtbGdmws3pGBCYAh+A==
X-Google-Smtp-Source: ABdhPJyFjrBYaSumRmMWd09J6whp9J9igWSZ+y3nTisSme3IrGUsLbSkT5Qvc8TfA25hMj3+GYM3JQ==
X-Received: by 2002:a05:6512:1595:b0:479:1e0a:283b with SMTP id bp21-20020a056512159500b004791e0a283bmr28839782lfb.141.1655098518177;
        Sun, 12 Jun 2022 22:35:18 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id s7-20020a2eb8c7000000b002556a17e193sm875735ljp.38.2022.06.12.22.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 22:35:17 -0700 (PDT)
Message-ID: <33151594-4168-d01b-56b6-dc996d226a7d@openvz.org>
Date:   Mon, 13 Jun 2022 08:35:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v4 5/9] memcg: enable accounting for percpu allocation of
 struct psi_group_cpu
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/sched/psi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ec66b40bdd40..c95e87269fc5 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -957,11 +957,12 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 	if (static_branch_likely(&psi_disabled))
 		return 0;
 
-	cgroup->psi = kmalloc(sizeof(struct psi_group), GFP_KERNEL);
+	cgroup->psi = kmalloc(sizeof(struct psi_group), GFP_KERNEL_ACCOUNT);
 	if (!cgroup->psi)
 		return -ENOMEM;
 
-	cgroup->psi->pcpu = alloc_percpu(struct psi_group_cpu);
+	cgroup->psi->pcpu = alloc_percpu_gfp(struct psi_group_cpu,
+					     GFP_KERNEL_ACCOUNT);
 	if (!cgroup->psi->pcpu) {
 		kfree(cgroup->psi);
 		return -ENOMEM;
-- 
2.36.1

