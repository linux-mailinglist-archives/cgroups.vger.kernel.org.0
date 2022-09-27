Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802625EBF26
	for <lists+cgroups@lfdr.de>; Tue, 27 Sep 2022 12:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiI0KCf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Sep 2022 06:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiI0KCa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Sep 2022 06:02:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55076956AF;
        Tue, 27 Sep 2022 03:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5C1861793;
        Tue, 27 Sep 2022 10:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407F0C433D6;
        Tue, 27 Sep 2022 10:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664272948;
        bh=dlgt8sTUOCFvaKMGVG7jt6xOPr5SYmh1UhVPSKkYzV8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SzSGGrMbrYCeDjltNrgrL3VG2omylsDXXWGmFRuKYPFnG2Xtt63azHAsuGowYidFD
         vuXsb1OH/s/KwBRrtO4U7PShzKeRUQ6r0e13xxx6bq+NTHfByi71P4P6tQvc7Z8p1W
         QQu/R2CHgWE0QRLqrRl6ANwMMZJClkApkeRIMNC7efj90M4T9lKE5uoFewIOEQmM/3
         Y6fCSR/7GnG+tEUZB8N1wSz/PUN49XvesX2YiFyZr2dYXU2ZRmA2geaiWFJLkpAPQk
         H1I6zN0LGrV0YwBi4275HtG2my1Kuu0KK1SzWnQ3lUfAapmKTlFxrXh+RWDZrb4ars
         KrO+qSy8Z1aVA==
Message-ID: <54078150-3c22-3563-7731-5c7fda85987d@kernel.org>
Date:   Tue, 27 Sep 2022 12:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] Revert "net: set proper memcg for net_init hooks
 allocations"
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anatoly Pugachev <matorola@gmail.com>,
        Vasily Averin <vvs@openvz.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sparclinux@vger.kernel.org, regressions@lists.linux.dev
References: <20220926195931.2497968-1-shakeelb@google.com>
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20220926195931.2497968-1-shakeelb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/26/22 21:59, Shakeel Butt wrote:
> This reverts commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9.
> 
> Anatoly Pugachev reported that the commit 1d0403d20f6c ("net: set proper
> memcg for net_init hooks allocations") is somehow causing the sparc64
> VMs failed to boot and the VMs boot fine with that patch reverted. So,
> revert the patch for now and later we can debug the issue.
> 

Link: https://lore.kernel.org/all/20220918092849.GA10314@u164.east.ru/

(mainly for regzbot reading this thread but should be valid usage for
the report anyway)

Fixes: 1d0403d20f6c ("net: set proper memcg for net_init hooks allocations")

> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Vasily Averin <vvs@openvz.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/memcontrol.h | 45 --------------------------------------
>  net/core/net_namespace.c   |  7 ------
>  2 files changed, 52 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ef479e554253..e1644a24009c 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1787,42 +1787,6 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
>  	rcu_read_unlock();
>  }
>  
> -/**
> - * get_mem_cgroup_from_obj - get a memcg associated with passed kernel object.
> - * @p: pointer to object from which memcg should be extracted. It can be NULL.
> - *
> - * Retrieves the memory group into which the memory of the pointed kernel
> - * object is accounted. If memcg is found, its reference is taken.
> - * If a passed kernel object is uncharged, or if proper memcg cannot be found,
> - * as well as if mem_cgroup is disabled, NULL is returned.
> - *
> - * Return: valid memcg pointer with taken reference or NULL.
> - */
> -static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
> -{
> -	struct mem_cgroup *memcg;
> -
> -	rcu_read_lock();
> -	do {
> -		memcg = mem_cgroup_from_obj(p);
> -	} while (memcg && !css_tryget(&memcg->css));
> -	rcu_read_unlock();
> -	return memcg;
> -}
> -
> -/**
> - * mem_cgroup_or_root - always returns a pointer to a valid memory cgroup.
> - * @memcg: pointer to a valid memory cgroup or NULL.
> - *
> - * If passed argument is not NULL, returns it without any additional checks
> - * and changes. Otherwise, root_mem_cgroup is returned.
> - *
> - * NOTE: root_mem_cgroup can be NULL during early boot.
> - */
> -static inline struct mem_cgroup *mem_cgroup_or_root(struct mem_cgroup *memcg)
> -{
> -	return memcg ? memcg : root_mem_cgroup;
> -}
>  #else
>  static inline bool mem_cgroup_kmem_disabled(void)
>  {
> @@ -1879,15 +1843,6 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
>  {
>  }
>  
> -static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
> -{
> -	return NULL;
> -}
> -
> -static inline struct mem_cgroup *mem_cgroup_or_root(struct mem_cgroup *memcg)
> -{
> -	return NULL;
> -}
>  #endif /* CONFIG_MEMCG_KMEM */
>  
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 6b9f19122ec1..0ec2f5906a27 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -18,7 +18,6 @@
>  #include <linux/user_namespace.h>
>  #include <linux/net_namespace.h>
>  #include <linux/sched/task.h>
> -#include <linux/sched/mm.h>
>  #include <linux/uidgid.h>
>  #include <linux/cookie.h>
>  
> @@ -1144,13 +1143,7 @@ static int __register_pernet_operations(struct list_head *list,
>  		 * setup_net() and cleanup_net() are not possible.
>  		 */
>  		for_each_net(net) {
> -			struct mem_cgroup *old, *memcg;
> -
> -			memcg = mem_cgroup_or_root(get_mem_cgroup_from_obj(net));
> -			old = set_active_memcg(memcg);
>  			error = ops_init(ops, net);
> -			set_active_memcg(old);
> -			mem_cgroup_put(memcg);
>  			if (error)
>  				goto out_undo;
>  			list_add_tail(&net->exit_list, &net_exit_list);

