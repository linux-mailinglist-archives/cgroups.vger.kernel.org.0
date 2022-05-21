Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E408452FE32
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 18:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344944AbiEUQii (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351652AbiEUQii (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 12:38:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DFB62BDB
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:38:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q1so2972442ljb.5
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=ubEdKOLxNSsh97bDo7kpC8y1FqAK+i/uT0ov6eXAI2o=;
        b=VGOpXYtocMKIeshgklWD1Zo9cIZadjw/jBv0T7SITGnfSw+kY7kyswsQG+yKDOPdIL
         lgbOfYW4tytV2kcy9vuPjd1SIFXGAdT0RBbbSvFh+vlWmikbE0fhup438dTlu81UrMd1
         2ZjPKcME4smlcKI0In8IqM6w/ffUsdXEjJ3xK1yYr0BPOerlii2ms/hIZixBjf8jwAue
         EFgO8Mj9dhK4TkCHLycE1wR2gkSB23Tgxtl612CMU+p9bfxBlIpcRplIQ7eMihOoZbvx
         Iple/oQOgga471BAYxfPyoTU+4ZAAVOP71yOR9Cudi0h3whHn+xwG1XL52goc/glgHsH
         fSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=ubEdKOLxNSsh97bDo7kpC8y1FqAK+i/uT0ov6eXAI2o=;
        b=38P1BzRkZEXXWdCoFWZkIG+fpzRqK5CkSr0jtQApV2mPKFvnGqFW0J89mwa6Jvlf9i
         x96lZEUmyRxkgdTGM95IBOGCQbQoOlknHJcTFEL7M7RX+pbQAdUcYi4PyDhsBkAn+KSp
         V1LF2YbfCLDen4VAZNyfA3RzW4fStG158JC8PSSFJ8Als9tereX/uZaINKZWc7xbIjPQ
         FTiMbJbHr1OZ8B94rHR4i/bxu8CaGxg4mUMe9lqjGdOiHTTuP16ogOqiG1731pC9SGcQ
         u2vXqpoGOQtUhyacyyjEYkfNoIU9E9GZoIG5siiO6O5mANKekkWESfj+ty5lq5tmMb96
         bzrA==
X-Gm-Message-State: AOAM533SNqr4Fzahq4D4ZCPPitQHudHxvrO5WhYUVZLfaOfrzesb4I1Z
        jlkGmOOaTkxxX5Aq75ijWiPBAQ==
X-Google-Smtp-Source: ABdhPJzocSGKezCk9kwFPkKlXP5XOqvNaFEMyyKnjUP6VYzzkVVlmn1aqPy6DwNNJlGzTduXCzbs1w==
X-Received: by 2002:a2e:b053:0:b0:253:dd50:b93f with SMTP id d19-20020a2eb053000000b00253dd50b93fmr4948944ljl.277.1653151113204;
        Sat, 21 May 2022 09:38:33 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id h7-20020ac250c7000000b0047255d21174sm1116566lfm.163.2022.05.21.09.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:38:32 -0700 (PDT)
Message-ID: <c0d01d6e-530c-9be3-1c9b-67a7f8ea09be@openvz.org>
Date:   Sat, 21 May 2022 19:38:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v2 6/9] memcg: enable accounting for percpu allocation of
 struct cgroup_rstat_cpu
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

struct cgroup_rstat_cpu is percpu allocated for each new cgroup and
can consume a significant portion of all allocated memory on nodes
with a large number of CPUs.

Common part of the cgroup creation:
Allocs  Alloc   $1*$2   Sum	Allocation
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
---
 kernel/cgroup/rstat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 24b5c2ab5598..f76cb63ae2e0 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -257,7 +257,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 
 	/* the root cgrp has rstat_cpu preallocated */
 	if (!cgrp->rstat_cpu) {
-		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
+		cgrp->rstat_cpu = alloc_percpu_gfp(struct cgroup_rstat_cpu
+						   GFP_KERNEL_ACCOUNT);
 		if (!cgrp->rstat_cpu)
 			return -ENOMEM;
 	}
-- 
2.36.1

