Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0111A547F1A
	for <lists+cgroups@lfdr.de>; Mon, 13 Jun 2022 07:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiFMFg1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jun 2022 01:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiFMFf5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jun 2022 01:35:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF15C11476
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:35:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p18so7152838lfr.1
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=fYBLg0GorDblKEye4tioxlFuzZ/2NCtjLKl9KE3W8YI=;
        b=zIUP7XJmmGybhomix4qhj4dsvVJz3qpTtmJxAHZo+FS3qMKA29sQ0rVxITb06XZqrD
         nZC+ARODXgb3uW8IID/NoPvHZF9I+vmsgg6S2S3doreOAfToddHYk1Xvd8rWktSA8nfW
         ahOnjls08LK/iVwueICAsn0ZIC7TfutQY9y1bJsENsR5gcnyHgUNUiHtMrbOcicbvOE2
         QVKi01RzoRWCS8SpdjYkxAJRvKM/V18mk3VtVZeCBa7GBMjYuZ9WMAr51wHQPnrptMvn
         8xgK0UlON2cwUtsy7uUQEVj443cXKJL8OSjA3MdZI+qOZ/kfjJeo689lqFDEg/SHaxHZ
         d7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=fYBLg0GorDblKEye4tioxlFuzZ/2NCtjLKl9KE3W8YI=;
        b=JlmjvgYnNT29ZdQvjQlPllrDYTaqG00gsh8LEvl8o7gzMQ4hcrc6zdTrsYj/mBfZ5W
         GlPUg3ZIZJxVp7wDx6nimbMTL43BNo6ElaRP6plceDSxUIItITRd7cANlIgWLchN3XvZ
         0wqnYfzdNIJTAOHbkkVaHnzPeA1P/AN8eiVHfy41ttF2390fxYBtIvXCg47Nd0OPFCMB
         fXk/h22xGr/fpKe38x8LqMJ81pX/T6CFln+Pty+hGVDMoU4KTdKIJ/30ARi4EObFp+IO
         fAFkM1AZzTJMoOcioL8T4A2JC1dvlRC9Lmxl83KQVXC7Lamr5HE7sIGRRtXH3h/y+E/e
         Gujg==
X-Gm-Message-State: AOAM532XTjqFFqtnm7VvikKkEdlkquU+1UNjamsDcnNftBsfWfsqjvix
        lPaNpxnX8sEybPz6mJ84v2ovHw==
X-Google-Smtp-Source: ABdhPJzvN/XuMilatlDTG99FEYXRhOvXWQuq2fWz3UrzAYP/w/zAkDHEQehBYIW4xnHBlzBchtcVjQ==
X-Received: by 2002:a05:6512:2614:b0:47d:c632:896b with SMTP id bt20-20020a056512261400b0047dc632896bmr5177459lfb.532.1655098527149;
        Sun, 12 Jun 2022 22:35:27 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id j21-20020a05651231d500b00478f3bb79d6sm845297lfe.194.2022.06.12.22.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 22:35:26 -0700 (PDT)
Message-ID: <05bcd9df-970c-f8f8-0577-9dbb164b1180@openvz.org>
Date:   Mon, 13 Jun 2022 08:35:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v4 6/9] memcg: enable accounting for percpu allocation of
 struct cgroup_rstat_cpu
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
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/cgroup/rstat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 24b5c2ab5598..2904b185b01b 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -257,7 +257,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 
 	/* the root cgrp has rstat_cpu preallocated */
 	if (!cgrp->rstat_cpu) {
-		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
+		cgrp->rstat_cpu = alloc_percpu_gfp(struct cgroup_rstat_cpu,
+						   GFP_KERNEL_ACCOUNT);
 		if (!cgrp->rstat_cpu)
 			return -ENOMEM;
 	}
-- 
2.36.1

