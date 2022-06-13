Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D026547F35
	for <lists+cgroups@lfdr.de>; Mon, 13 Jun 2022 07:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiFMFgH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jun 2022 01:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiFMFfb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jun 2022 01:35:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A301054C
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:35:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y32so7115142lfa.6
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=buhJIxm8AqBO3bD99fC3A2PxIb9sSGllubXvwSLnjxI=;
        b=poLeG6zhCv/e/uvaonfvqyZcWLUQoZKI6x1zrBYzR8yEcLqX5MJjRu0DpBmK0UieGM
         9s8GkMwlIhLIZoQPjVePmWg9+eHaw3B/mxAbv92cla9k0nTwF0/t7OND21vBl/jnCbIU
         IRCipafuU6E/GhmoUqu9xNvZBtbB5Z528WMihwahUcILGFkidaBexjc14Cq8pW8Z7Pvj
         N7AfutKNP8hBX8d3mBRFD1w6M6/KhKiGE+zL5Mh/NHBVYzb1srbsoyGopRzu/uGFFuO0
         9CT6RkUDfugqIiBXyVg6DD3bipqyjO7hrVYqc1/pWq903VKpx9vz96zgU+w6o/ZlFCvC
         9x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=buhJIxm8AqBO3bD99fC3A2PxIb9sSGllubXvwSLnjxI=;
        b=yxOIv5x9XeJOvPCj990npLQFqfuxJRdtHBJjl6tZn0blkCwKkRW9UpO+cWahWhKVKO
         ZrQQXMdzfJWqLi3jPUB+B98lXr1am3nc33vHW9H+EUFQuDhtdFAd0QRQO18loDfv5Zfp
         x1P0tvlvalZunh7CpTadKHmk+P77aBSSj32U4p83ast50XAZQH/LK58Iv1WS89A+qhqb
         5FlpR9INmiVMWJpoZC7VBMSelQ0v0b8xznjhuI7J6MN0nGaw9UrgOfkDGSDdn3fvFQds
         o+v/kX9R6YhTs0Qb2L9ndXEnkoSTYeK/KtOM7HeQo3f1uVErGNdg/r26ixaZpldk+ytB
         DkVA==
X-Gm-Message-State: AOAM531N9SpghCrQFoIcOPesSDxlX7AunhlOplk0MND1si7MqK2t99YT
        xc8bVwPLHcsWTd/UT3zDHXZnLJUxzikXrw==
X-Google-Smtp-Source: ABdhPJz8mC+oy5QTxd+FVDFv22laevGRjje04Lf2wVUa8G+vhmhElanXbHdoiJIbuGw58hKsSQKOWg==
X-Received: by 2002:a05:6512:2249:b0:478:f926:ad7 with SMTP id i9-20020a056512224900b00478f9260ad7mr38742258lfu.511.1655098500094;
        Sun, 12 Jun 2022 22:35:00 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id j2-20020a2e6e02000000b002555c9d5d7fsm894992ljc.11.2022.06.12.22.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 22:34:59 -0700 (PDT)
Message-ID: <647143fa-2521-10ae-2c4d-41dbb74d00cf@openvz.org>
Date:   Mon, 13 Jun 2022 08:34:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v4 3/9] memcg: enable accounting for kernfs iattrs
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

Allocs  Alloc    Allocation
number  size
--------------------------------------------
1   +  128      (__kernfs_new_node+0x4d)        kernfs node
1   +   88      (__kernfs_iattrs+0x57)          kernfs iattrs
1   +   96      (simple_xattr_alloc+0x28)       simple_xattr, can grow over 4Kb
1       32      (simple_xattr_set+0x59)
1       8       (__kernfs_new_node+0x30)

'+' -- to be accounted

This patch enables accounting for kernfs_iattrs_cache slab cache

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/kernfs/mount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 3ac4191b1c40..40e896c7c86b 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -397,5 +397,6 @@ void __init kernfs_init(void)
 	/* Creates slab cache for kernfs inode attributes */
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
 					      sizeof(struct kernfs_iattrs),
-					      0, SLAB_PANIC, NULL);
+					      0, SLAB_PANIC | SLAB_ACCOUNT,
+					      NULL);
 }
-- 
2.36.1

