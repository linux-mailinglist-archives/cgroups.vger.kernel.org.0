Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E8A52FE2D
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 18:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245735AbiEUQhz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 12:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245753AbiEUQhx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 12:37:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E53A2DA91
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:37:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r3so5780920ljd.7
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=IVDqiXzI4dIEBMTsaaQRM7ta9ARirhRNc6apB4FJmT4=;
        b=EtLP8pxVwmIKt66WFCvOclrJgEDpp4X1B1T1JnZ7B39hZcHA/QLCYXBWJxjJd8pcIn
         lPowuGK/5K7RomQjyNJyh25sw01fJiLswg8uBKe7UwNYxrTR/UYqixFMFH9Kg3zSr8o0
         kA5sXr7Clen8UoGgs9FvZsKN2VPvgHy2ziuaqbmxMaS7uHK1gl8pK6fP/ymVim8sU6Zr
         BKqoipnZGWxy1V2JtyXxotPu0Iycs57GEAoUef3xEuleqmg+XkokIek+j2p/XY6v1PAK
         zkwFtJ4C3Tkwhu0SAOsQv0JgOS6cceETuFVTySGKI/A/j54qwu1CQneG+vRqOvOqUVA1
         cJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=IVDqiXzI4dIEBMTsaaQRM7ta9ARirhRNc6apB4FJmT4=;
        b=Xr/vVxJq3lEJjJf13/LnLT8ndA+HRw2vY09eKjl/hk7hmLBi/gukOcrNEpPH9AW3MU
         1tM0hTEt1/1exuZnNfnE4VEKN/7KeSLbbESppZOgPW3Mj4CONmsF/kfiInwtkL6PJukf
         yyxA4E2KljQVdg0B5O3YneTO1yqV3ZuIqIzH+LfwjCHinoJmACkKq9chpWPqmDFtD8o8
         CiwRI/5Rgx34Ae0xQ/9sni8izpGUTHowxBQLi33PyB2UmxYGwKyiIWZ+yIndTlRstQOU
         dFs/KVwMARlufQzfQ8xtrvdK/NDamdq5Qb+60v6bkLZiq86gnWcRJZganGe8E1ORSchr
         uNnA==
X-Gm-Message-State: AOAM5330YcGMUh8A/ikjLoEYC2fpLz7cMOBSh4KFuYs34GAt0DvA/51l
        rstgJ8q7aP7cxXFBOmdg7zkYOA==
X-Google-Smtp-Source: ABdhPJwTeHS4NovOhmuXmVJAEPnop69XY0S2sk+u6JhnkIHtEODDGFf4FcjmtHxM/Xhv4BUHh0QVsQ==
X-Received: by 2002:a2e:96d2:0:b0:253:d8f1:66f8 with SMTP id d18-20020a2e96d2000000b00253d8f166f8mr6552746ljj.321.1653151070521;
        Sat, 21 May 2022 09:37:50 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id w11-20020a05651c102b00b0024f3d1daebasm749238ljm.66.2022.05.21.09.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:37:50 -0700 (PDT)
Message-ID: <4f129690-88fe-18f2-2142-b179a804924b@openvz.org>
Date:   Sat, 21 May 2022 19:37:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v2 2/9] memcg: enable accounting for kernfs nodes
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

