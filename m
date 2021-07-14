Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3ECD3C7E8C
	for <lists+cgroups@lfdr.de>; Wed, 14 Jul 2021 08:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbhGNGed (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Jul 2021 02:34:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:34486 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238003AbhGNGed (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Jul 2021 02:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=CmW4WEPrBYc9JkO1ZpHwc4AZ/QqQIR1GbHwoX4kgVJY=; b=o6m5sOcYtTchWFIWd
        TJWZ1yyazhKhz8n6I4Mzq8WRrP5nncMBYc4zFUWIYbiTxTH7Ggl7xiv/7LteuVnDqRbTsUdZd+E0o
        dgPq+uUl7Y4KhHVL6YmNtWaNe/uNpa865AZKZ+sqKfeq73BLmfg/ZQHSUyLCLQU8wEFCuWjR5H5HI
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m3YQh-003uXN-Pc; Wed, 14 Jul 2021 09:31:35 +0300
Subject: Re: [PATCH v2 1/1] memcg: enable accounting for pids in nested pid
 namespaces
From:   Vasily Averin <vvs@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Serge Hallyn <serge@hallyn.com>, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
References: <7b777e22-5b0d-7444-343d-92cbfae5f8b4@virtuozzo.com>
 <8b6de616-fd1a-02c6-cbdb-976ecdcfa604@virtuozzo.com>
Message-ID: <21db0c2c-45ea-fded-9633-7b76ab2b1083@virtuozzo.com>
Date:   Wed, 14 Jul 2021 09:31:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8b6de616-fd1a-02c6-cbdb-976ecdcfa604@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear Andrew,
could you please pick up this patch and add
 Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thank you,
	Vasily Averin

On 4/24/21 2:54 PM, Vasily Averin wrote:
> Commit 5d097056c9a0 ("kmemcg: account certain kmem allocations to memcg")
> enabled memcg accounting for pids allocated from init_pid_ns.pid_cachep,
> but forgot to adjust the setting for nested pid namespaces.
> As a result, pid memory is not accounted exactly where it is really needed,
> inside memcg-limited containers with their own pid namespaces.
> 
> Pid was one the first kernel objects enabled for memcg accounting.
> init_pid_ns.pid_cachep marked by SLAB_ACCOUNT and we can expect that
> any new pids in the system are memcg-accounted.
> 
> Though recently I've noticed that it is wrong. nested pid namespaces creates 
> own slab caches for pid objects, nested pids have increased size because contain 
> id both for all parent and for own pid namespaces. The problem is that these slab
> caches are _NOT_ marked by SLAB_ACCOUNT, as a result any pids allocated in 
> nested pid namespaces are not memcg-accounted.
> 
> Pid struct in nested pid namespace consumes up to 500 bytes memory, 
> 100000 such objects gives us up to ~50Mb unaccounted memory,
> this allow container to exceed assigned memcg limits.
> 
> Fixes: 5d097056c9a0 ("kmemcg: account certain kmem allocations to memcg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> ---
>  kernel/pid_namespace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 6cd6715..a46a372 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -51,7 +51,8 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
>  	mutex_lock(&pid_caches_mutex);
>  	/* Name collision forces to do allocation under mutex. */
>  	if (!*pkc)
> -		*pkc = kmem_cache_create(name, len, 0, SLAB_HWCACHE_ALIGN, 0);
> +		*pkc = kmem_cache_create(name, len, 0,
> +					 SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT, 0);
>  	mutex_unlock(&pid_caches_mutex);
>  	/* current can fail, but someone else can succeed. */
>  	return READ_ONCE(*pkc);
> 

