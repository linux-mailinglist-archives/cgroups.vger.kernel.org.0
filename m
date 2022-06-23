Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5A3557E3F
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiFWOu7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 10:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiFWOu6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 10:50:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA79146679
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:50:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z13so3298780lfj.13
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=gx5BulmdWVt1E6J23Q6sWTUkZpDqVLFQzvPT6hFPLlw=;
        b=zFPWnFhORhhkx+K6C2WQvQM0YSy+ZbfRPmzcQLsty0RSOgd+5dgld9MCRIQ56cNSRK
         BCnClixQqpL7OFP/+tRWG1VBGjAlAcE8nDR1yKu9FAfO39DLsaWvqo7E8phYLKhdHn5x
         /OnNOgxfX3uytsUOosIdIHz6LvZu6wTX+qQEK1PEN6Py9mGCUTJEWhQ827qs34DAAMD7
         lNFvFBB1BJqKZEBaIHQJG/Ip0/M4QLNQdIh00w//KELVSTh4dbSVMXiXkhuSlhcBwSyp
         OdEG1BVxEEkxeYlEP/S71/GXCS8L542kaiqVa6Ghai1qeB/4D4YZWX3qHzUD0YsJcJ/M
         aSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=gx5BulmdWVt1E6J23Q6sWTUkZpDqVLFQzvPT6hFPLlw=;
        b=7mXm0PclfxUzEIGS2BSOzaAOnLZN4tAJzBALkfY4WXdR1BrSNQ5vXoN7Wp+ewQMMIr
         erO4dAxOGGsWws4lYMAe70IbhMu6rVqQ1ZmAsTZzogPmXs7PZHq0yrp4lnxNZQcTRSmb
         ultsvHotbVQT4w72EKEzA9WW8KxvM0q3xyYDJf0uQEx41L/zSxzV+2nJ2bIGseUF9nwj
         GXnJsjlBO6NZajzlK2xMly0ScQgjaJJbpvQPs8qXdwgve8tpONA2AgrRuWhvSp7V+uKi
         N4tm3B4EgbAqpvmcHJA92z2tLwfBSx5qS7kHjpNRWVX22+TDjIswvUR07hsjphVXJt6T
         qveg==
X-Gm-Message-State: AJIora87y4g0ltIQvcZmdBh3VuNLz6kTiopAGihS2fpXfp87XLuzQFNC
        8TzyQRWN1nfflYiQ94miF26xCQ==
X-Google-Smtp-Source: AGRyM1uTnBSEDsDu11OjnHjb3FojldgzsC1VUsNRLNFNCtzVtvGbYs9IJOhajOCoRwBTb/baBFXjSQ==
X-Received: by 2002:a05:6512:3b21:b0:47f:665a:bf50 with SMTP id f33-20020a0565123b2100b0047f665abf50mr5720843lfv.673.1655995857250;
        Thu, 23 Jun 2022 07:50:57 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id i8-20020a2ea228000000b0025a59470621sm490327ljm.26.2022.06.23.07.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 07:50:56 -0700 (PDT)
Message-ID: <58cbf16e-ae4a-b6c5-f2ef-ab9fb3d29baf@openvz.org>
Date:   Thu, 23 Jun 2022 17:50:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v5 2/9] memcg: enable accounting for kernfs nodes
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

