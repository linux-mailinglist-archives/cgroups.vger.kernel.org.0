Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D607F557E39
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiFWOvS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 10:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiFWOvR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 10:51:17 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D717C47078
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:51:13 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bn8so6269524ljb.2
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=k8OfFf3zteeGV4NoXsW7mYQBRm/UT3jxMOm3SilJFI0=;
        b=hsg2w+abNmxBuNt4Iv4r+V21/tVetnU4U/D2SV+gm392hJCFDklntUJOdfxD3yiiPB
         MvGH3he8zMgV8AYjS8QEzaWnf3xrJB9UhPqWdSpP+22GycMOwBSKrGK7aJI0AfhBEPL2
         2NAxJyMQ816jqIBDzXSq4r4bLuH82L0hneLKdzdBxFx3SI+2TxhhWeT7s/0YEabpfnTG
         6MBUo28BBuCeUwV6cMOrM0zubkHeEB1KFTTA4V0riTQBjXFDcFelIFctLJlb4yTs7sM7
         XEx9XLZ9Sh20UTK7vVfDEkaniIvsLVt0dL4fjbigg+OME17vZ4F8f7WcUs3ubT10zDlJ
         FNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=k8OfFf3zteeGV4NoXsW7mYQBRm/UT3jxMOm3SilJFI0=;
        b=5sX6pa3fgBJBNQg+aRlr3YH7OtWDJtHizxqM6DLmSf2BQQl8scwILAWfT+H0sXl+Rx
         LdE7MyOfCcAqJVJtXKYI1FY3mOODW9jhMRRKxc+3XRYErIE2J1x22ctSxeAQ6UnZ+9g1
         UttWjap8uSo7FOFZlETuVQj0aSvNNTrp9HpncIl/O1HAVfV/uPSODC3hGzw6XNYcMBNu
         TNcPRxY8E783o+tQfAor40nwLVl10IsQ8/2Anlr/wdqzrY46xpklT3I1MLTNX/zYDQmG
         khxOzPqqfJntRB+qM8C0qasBWhec8xwl4hy99XWt4izTCqpvVIQOGrRxYwHGPpFyX8j2
         CqXA==
X-Gm-Message-State: AJIora9FqnBflUZg+x8msryONEY+OXnp5GgJ/VMwLg52rBcE5zZ0sUMW
        454sD4QhI8G4W6k4q82rPq1TFQ==
X-Google-Smtp-Source: AGRyM1vQgmT9L5cc+RG2sEr65xPeqzzwssWUnhh/SDAvla0mPtj3N0Dc6e5uRv4S9hq2r/hbwJI8Ug==
X-Received: by 2002:a05:651c:11c1:b0:25a:8968:b834 with SMTP id z1-20020a05651c11c100b0025a8968b834mr4871877ljo.212.1655995872261;
        Thu, 23 Jun 2022 07:51:12 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id a4-20020a19ca04000000b0047255d210dcsm2247637lfg.11.2022.06.23.07.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 07:51:11 -0700 (PDT)
Message-ID: <97e05495-d74e-275c-0739-8abff974cdc5@openvz.org>
Date:   Thu, 23 Jun 2022 17:51:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v5 4/9] memcg: enable accounting for struct simple_xattr
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
1   +  128      (__kernfs_new_node+0x4d)        kernfs node
1   +   88      (__kernfs_iattrs+0x57)          kernfs iattrs
1   +   96      (simple_xattr_alloc+0x28)       simple_xattr
1       32      (simple_xattr_set+0x59)
1       8       (__kernfs_new_node+0x30)

'+' -- to be accounted

This patch enables accounting for struct simple_xattr. Size of this
structure depends on userspace and can grow over 4Kb.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index e8dd03e4561e..98dcf6600bd9 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1001,7 +1001,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
 	if (len < sizeof(*new_xattr))
 		return NULL;
 
-	new_xattr = kvmalloc(len, GFP_KERNEL);
+	new_xattr = kvmalloc(len, GFP_KERNEL_ACCOUNT);
 	if (!new_xattr)
 		return NULL;
 
-- 
2.36.1

