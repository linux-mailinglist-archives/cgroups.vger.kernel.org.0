Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDCE7189B5
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2019 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEIMZa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 08:25:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41512 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEIMZa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 May 2019 08:25:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so1822364lja.8;
        Thu, 09 May 2019 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bgwFcpr4h0CqLDwaKDRvVqsaxrlGDdYtmYdrXixSeUQ=;
        b=fXxBmE7ze/Z+gLUgPusLSOjeC8DPRni8xSXs72THlqUgvZ+YkB7C2X2joI2yabhZE3
         8p3jL+zSxjqkE6WDx9RdpWMHV1BE+w1kk8V/mtEhJpgbCLjSPVymx2kjkrzPGSAIjr7D
         w45LanlpZrGomO0jnZvIOzl4VSSIY4E3z+gyzmExHr1o6buuZO0GHkOYXoWSCeqrQLSb
         FlCkYEZRTrKaSU02Al80SESzb5ftUvtSa4dEV1Il4KRbvvZUIkjl7K++UhJMBcIliYoC
         xFLukUi+LA2L9H8oQGAQXR71a6J/JTXgKcmL1WnzuE5ndqFELwKSjnp7ngbqhxZBf77S
         RirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bgwFcpr4h0CqLDwaKDRvVqsaxrlGDdYtmYdrXixSeUQ=;
        b=WG29ONTy+8hNEIqp57vq9kuI696SZwTlSrJv2O5qYfvzU5IRGYFKwSPhaBhjOSQBoa
         KaxKVRz7N2nup9BcW6gZagaIH9iA0xKSDAts0s44PlMFYuQyf/uySqfaKnGKaDV6+tUf
         lDzgt2HPDwf5/manucZ54R8EZRO8cZq3iTZkvmF5AD1c/oIffbTpzqP/Qz2maZWbChPo
         XzlRcGHAPGOCyPm7f00ai1x30GWC64zOTf9f8Bes25iIb5cOM9dXkcGU+TJW+/5a+On7
         bucRI7xMOdt+lr00iW+vhMni2dOrRaL+qyZTQznJFE+xtXU9U1Y9lgcCaJsN4JfeXU2n
         TknA==
X-Gm-Message-State: APjAAAUEZznMV7vnYefTRwKBufiZvKskb5cf/rYPU54xY0V4ViLF2Yol
        9gmCtkp9gQ5Wx4CNOOJL/S/3YJ3+
X-Google-Smtp-Source: APXvYqwy62cie0c9VYiWdxvOgL2dz0bVljr6TDZHfH9f2UgG36OiRDna8QWxOvWyDUp4EYX5rZFmew==
X-Received: by 2002:a2e:814e:: with SMTP id t14mr2163558ljg.25.1557404728231;
        Thu, 09 May 2019 05:25:28 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id y7sm306917ljj.34.2019.05.09.05.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 05:25:27 -0700 (PDT)
Date:   Thu, 9 May 2019 15:25:26 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH] memcg: make it work on sparse non-0-node systems
Message-ID: <20190509122526.ck25wscwanooxa3t@esperanza>
References: <359d98e6-044a-7686-8522-bdd2489e9456@suse.cz>
 <20190429105939.11962-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429105939.11962-1-jslaby@suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 29, 2019 at 12:59:39PM +0200, Jiri Slaby wrote:
> We have a single node system with node 0 disabled:
>   Scanning NUMA topology in Northbridge 24
>   Number of physical nodes 2
>   Skipping disabled node 0
>   Node 1 MemBase 0000000000000000 Limit 00000000fbff0000
>   NODE_DATA(1) allocated [mem 0xfbfda000-0xfbfeffff]
> 
> This causes crashes in memcg when system boots:
>   BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
>   #PF error: [normal kernel read fault]
> ...
>   RIP: 0010:list_lru_add+0x94/0x170
> ...
>   Call Trace:
>    d_lru_add+0x44/0x50
>    dput.part.34+0xfc/0x110
>    __fput+0x108/0x230
>    task_work_run+0x9f/0xc0
>    exit_to_usermode_loop+0xf5/0x100
> 
> It is reproducible as far as 4.12. I did not try older kernels. You have
> to have a new enough systemd, e.g. 241 (the reason is unknown -- was not
> investigated). Cannot be reproduced with systemd 234.
> 
> The system crashes because the size of lru array is never updated in
> memcg_update_all_list_lrus and the reads are past the zero-sized array,
> causing dereferences of random memory.
> 
> The root cause are list_lru_memcg_aware checks in the list_lru code.
> The test in list_lru_memcg_aware is broken: it assumes node 0 is always
> present, but it is not true on some systems as can be seen above.
> 
> So fix this by checking the first online node instead of node 0.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: <cgroups@vger.kernel.org>
> Cc: <linux-mm@kvack.org>
> Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
>  mm/list_lru.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 0730bf8ff39f..7689910f1a91 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -37,11 +37,7 @@ static int lru_shrinker_id(struct list_lru *lru)
>  
>  static inline bool list_lru_memcg_aware(struct list_lru *lru)
>  {
> -	/*
> -	 * This needs node 0 to be always present, even
> -	 * in the systems supporting sparse numa ids.
> -	 */
> -	return !!lru->node[0].memcg_lrus;
> +	return !!lru->node[first_online_node].memcg_lrus;
>  }
>  
>  static inline struct list_lru_one *

Yep, I didn't expect node 0 could ever be unavailable, my bad.
The patch looks fine to me:

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>

However, I tend to agree with Michal that (ab)using node[0].memcg_lrus
to check if a list_lru is memcg aware looks confusing. I guess we could
simply add a bool flag to list_lru instead. Something like this, may be:

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index aa5efd9351eb..d5ceb2839a2d 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -54,6 +54,7 @@ struct list_lru {
 #ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
 	int			shrinker_id;
+	bool			memcg_aware;
 #endif
 };
 
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0730bf8ff39f..8e605e40a4c6 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -37,11 +37,7 @@ static int lru_shrinker_id(struct list_lru *lru)
 
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
-	/*
-	 * This needs node 0 to be always present, even
-	 * in the systems supporting sparse numa ids.
-	 */
-	return !!lru->node[0].memcg_lrus;
+	return lru->memcg_aware;
 }
 
 static inline struct list_lru_one *
@@ -451,6 +447,7 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 {
 	int i;
 
+	lru->memcg_aware = memcg_aware;
 	if (!memcg_aware)
 		return 0;
 
