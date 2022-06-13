Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20D2547F28
	for <lists+cgroups@lfdr.de>; Mon, 13 Jun 2022 07:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiFMFgA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jun 2022 01:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiFMFf2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jun 2022 01:35:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AC1E09C
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:34:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a15so7097461lfb.9
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=gx5BulmdWVt1E6J23Q6sWTUkZpDqVLFQzvPT6hFPLlw=;
        b=LHjwdf838XwqeAg8Nc229RaNa822fvU0tfolsDGvnGxgxaJJuYInYiO0Y1/se6H3N6
         eSoUNfXTq9ViSfUVk2pQROnPmYKfyqjdabi2PzdI6GG3YDyJ5KbeVprN7xizrKfczl27
         oOY7dL2b1sgAGsJuu4L85fjavdMcXTonfnkDG0f5Jzl1kQ0sCxoscdmXVUTlU68okhJ9
         DA2ifBo1oc1LVvm7vn9bzJDoKJzCFuVoyuYtsarZnQ2xx/H/7LiOz4uBg3Y+Rt39vvxR
         KoGRxRNLkoNOToIZ57RKjPfuqae0oHimGFLyGLLEXdqDL//s5b3jDkGgcS6OD1N4fHA/
         ob2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=gx5BulmdWVt1E6J23Q6sWTUkZpDqVLFQzvPT6hFPLlw=;
        b=6etO8v9nDYtbqGG0g9IpociYm4UkBayTQ+UKsC0U82ZsGuHlg76hzO14O2Euwm5MlK
         kh9eQheYXL+rOOWlm6u1FvC3f+LeS7gRpzC9+LdjvISSJ98RWh9umc6IE3fsmHHP/H6l
         EPxKXmX/eA2rebMpU8BngT96yV5C/rNdbI/WmgUym6cgZl7D78w9esdSwSp5K0WJCT+/
         bEF40uBdOSWhlFmdHNwSdTrMq78/R4sV7v6gU79HYD4AL0XATKNmbO4jP3O3Ivu1J3NG
         wgOs89jMhbvyc9JWqfH+dgn+a7gvMEI9/V8w02xWEIMgZcN/ldjqhzOd75PNGbhNqLgL
         YKlA==
X-Gm-Message-State: AOAM5330isDj0kDPMciLkH4wmJrHyJ96eLeZwpoZ6uZxBW04pg9LJgaX
        qThjBWoS+NSkmNRkU+ozojFSkA==
X-Google-Smtp-Source: ABdhPJxwvjjFC+nbS7k4Hx0PfOGges13cDVPl80sm9xEZjEmzUcmZNS/oNjeKVJPRMV+PlaFVGkQxw==
X-Received: by 2002:a05:6512:130c:b0:477:e2ea:396e with SMTP id x12-20020a056512130c00b00477e2ea396emr78241747lfu.489.1655098490971;
        Sun, 12 Jun 2022 22:34:50 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id d22-20020a05651c089600b002553768424esm879156ljq.112.2022.06.12.22.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 22:34:50 -0700 (PDT)
Message-ID: <c1f76e20-8075-7133-a446-97d980516f71@openvz.org>
Date:   Mon, 13 Jun 2022 08:34:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v4 2/9] memcg: enable accounting for kernfs nodes
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

kernfs nodes are quite small kernel objects, however there are few
scenarios where it consumes significant piece of all allocated memory:

1) creating a new netdevice allocates ~50Kb of memory, where ~10Kb
   was allocated for 80+ kernfs nodes.

2) cgroupv2 mkdir allocates ~60Kb of memory, ~10Kb of them are kernfs
   structures.

3) Shakeel Butt reports that Google has workloads which create 100s
   of subcontainers and they have observed high system overhead
   without memcg accounting of kernfs.

Usually new kernfs node creates few other objects:

Allocs  Alloc   Allocation
number  size
--------------------------------------------
1   +  128      (__kernfs_new_node+0x4d)	kernfs node
1   +   88      (__kernfs_iattrs+0x57)		kernfs iattrs
1   +   96      (simple_xattr_alloc+0x28)	simple_xattr, can grow over 4Kb
1       32      (simple_xattr_set+0x59)
1       8       (__kernfs_new_node+0x30)

'+' -- to be accounted

This patch enables accounting for kernfs nodes slab cache.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/kernfs/mount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index cfa79715fc1a..3ac4191b1c40 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -391,7 +391,8 @@ void __init kernfs_init(void)
 {
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
 					      sizeof(struct kernfs_node),
-					      0, SLAB_PANIC, NULL);
+					      0, SLAB_PANIC | SLAB_ACCOUNT,
+					      NULL);
 
 	/* Creates slab cache for kernfs inode attributes */
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
-- 
2.36.1

