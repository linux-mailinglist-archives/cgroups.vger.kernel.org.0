Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523192CD2A
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 19:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfE1RIf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 13:08:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34737 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfE1RIf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 13:08:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id v18so15212510lfi.1;
        Tue, 28 May 2019 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eSIxYkcdixCKshTAAgauoFvEH6o7/CVdQzS8JHWoXBo=;
        b=CxnItHnsesXuxSeLCbxyq9Qzebn6SCvY7q8rl4VSmEDy6OgJ33k/LviCwobWrOuX31
         8h3CjYytq2Qx3nRTG89frfKemk4goXBw00VmBONWrQm4RT9R44DJeELSUtXUNVUQI3Pi
         2h+Th+gatt1NdMJg2oX2E5N6sG2jpK7/koWX3EImvxbOcuDaGa2EUDwtGAhn6D64yBdi
         G06hZlGysibO+bGEz4LUuV0RdSzVDDDOBq8hKFKQbuF30D7KJNpyDfc3gXNtdFAZkWnT
         foF0Icqh0P0qkvbJiWMumfU8C+MFlL2P54vZ7Z2y3GUbEJiJ/8imYCJkKIAWN0Ic0y4G
         cojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eSIxYkcdixCKshTAAgauoFvEH6o7/CVdQzS8JHWoXBo=;
        b=gyhL12Hjfsehhbvof9a1/YstScdMNjn3JrquMMzdCNpieHN3b7Wi9S33/179CTDTRb
         9twFq4Br/MY5sMU5qlnY6KhB2Y6qlcYeMPzSqlLqe9EpZxjfV3pTFhOXYnvR/InaY7eE
         32HRfSjn5TROgm788vj1WSL3zPbcS8nLAqYdZuoJn0bWBKtk8iULd9pyUhw32OIls/6J
         UqQ3Wq/K4/Cia8R9lFkySmgRvTt2dm29VUIT34FgaxMLjcxtoxSlmEzQQeimYAevWAYB
         TSDX+3gwRVIc5513bTMEjQjZGWxQqFMhkgOeCa3aAz24zUoDEBmqitNsPnL2/POqzaK8
         UPPA==
X-Gm-Message-State: APjAAAWvGWsPtDJ1I8jTijhnr7gUPi+BKn7+FWSdwFBKDszdbRtClt6x
        kYtpCDUzkT9ceYQAu6j8Un8=
X-Google-Smtp-Source: APXvYqxpK6td1ccwuMiO7YgOHGdtIpb6u4hgHImxnQciGQnJ7u/EDJK4CjzzG/JnER3qRDJ8G+UnEw==
X-Received: by 2002:ac2:46ef:: with SMTP id q15mr6098737lfo.63.1559063312356;
        Tue, 28 May 2019 10:08:32 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id t13sm3006255lji.47.2019.05.28.10.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 10:08:31 -0700 (PDT)
Date:   Tue, 28 May 2019 20:08:28 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 5/7] mm: rework non-root kmem_cache lifecycle
 management
Message-ID: <20190528170828.zrkvcdsj3d3jzzzo@esperanza>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-6-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521200735.2603003-6-guro@fb.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Roman,

On Tue, May 21, 2019 at 01:07:33PM -0700, Roman Gushchin wrote:
> This commit makes several important changes in the lifecycle
> of a non-root kmem_cache, which also affect the lifecycle
> of a memory cgroup.
> 
> Currently each charged slab page has a page->mem_cgroup pointer
> to the memory cgroup and holds a reference to it.
> Kmem_caches are held by the memcg and are released with it.
> It means that none of kmem_caches are released unless at least one
> reference to the memcg exists, which is not optimal.
> 
> So the current scheme can be illustrated as:
> page->mem_cgroup->kmem_cache.
> 
> To implement the slab memory reparenting we need to invert the scheme
> into: page->kmem_cache->mem_cgroup.
> 
> Let's make every page to hold a reference to the kmem_cache (we
> already have a stable pointer), and make kmem_caches to hold a single
> reference to the memory cgroup.

Is there any reason why we can't reference both mem cgroup and kmem
cache per each charged kmem page? I mean,

  page->mem_cgroup references mem_cgroup
  page->kmem_cache references kmem_cache
  mem_cgroup references kmem_cache while it's online

TBO it seems to me that not taking a reference to mem cgroup per charged
kmem page makes the code look less straightforward, e.g. as you
mentioned in the commit log, we have to use mod_lruvec_state() for memcg
pages and mod_lruvec_page_state() for root pages.

> 
> To make this possible we need to introduce a new percpu refcounter
> for non-root kmem_caches. The counter is initialized to the percpu
> mode, and is switched to atomic mode after deactivation, so we never
> shutdown an active cache. The counter is bumped for every charged page
> and also for every running allocation. So the kmem_cache can't
> be released unless all allocations complete.
> 
> To shutdown non-active empty kmem_caches, let's reuse the
> infrastructure of the RCU-delayed work queue, used previously for
> the deactivation. After the generalization, it's perfectly suited
> for our needs.
> 
> Since now we can release a kmem_cache at any moment after the
> deactivation, let's call sysfs_slab_remove() only from the shutdown
> path. It makes deactivation path simpler.

But a cache can be dangling for quite a while after cgroup was taken
down, even after this patch, because there still can be pages charged to
it. The reason why we call sysfs_slab_remove() is to delete associated
files from sysfs ASAP. I'd try to preserve the current behavior if
possible.

> 
> Because we don't set the page->mem_cgroup pointer, we need to change
> the way how memcg-level stats is working for slab pages. We can't use
> mod_lruvec_page_state() helpers anymore, so switch over to
> mod_lruvec_state().

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 4e5b4292a763..8d68de4a2341 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -727,9 +737,31 @@ static void kmemcg_schedule_work_after_rcu(struct rcu_head *head)
>  	queue_work(memcg_kmem_cache_wq, &s->memcg_params.work);
>  }
>  
> +static void kmemcg_cache_shutdown_after_rcu(struct kmem_cache *s)
> +{
> +	WARN_ON(shutdown_cache(s));
> +}
> +
> +static void kmemcg_queue_cache_shutdown(struct percpu_ref *percpu_ref)
> +{
> +	struct kmem_cache *s = container_of(percpu_ref, struct kmem_cache,
> +					    memcg_params.refcnt);
> +
> +	spin_lock(&memcg_kmem_wq_lock);

This code may be called from irq context AFAIU so you should use
irq-safe primitive.

> +	if (s->memcg_params.root_cache->memcg_params.dying)
> +		goto unlock;
> +
> +	WARN_ON(s->memcg_params.work_fn);
> +	s->memcg_params.work_fn = kmemcg_cache_shutdown_after_rcu;
> +	call_rcu(&s->memcg_params.rcu_head, kmemcg_schedule_work_after_rcu);

I may be totally wrong here, but I have a suspicion we don't really need
rcu here.

As I see it, you add this code so as to prevent memcg_kmem_get_cache
from dereferencing a destroyed kmem cache. Can't we continue using
css_tryget_online for that? I mean, take rcu_read_lock() and try to get
css reference. If you succeed, then the cgroup must be online, and
css_offline won't be called until you unlock rcu, right? This means that
the cache is guaranteed to be alive until then, because the cgroup holds
a reference to all its kmem caches until it's taken offline.

> +unlock:
> +	spin_unlock(&memcg_kmem_wq_lock);
> +}
> +
>  static void kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
>  {
>  	__kmemcg_cache_deactivate_after_rcu(s);
> +	percpu_ref_kill(&s->memcg_params.refcnt);
>  }
>  
>  static void kmemcg_cache_deactivate(struct kmem_cache *s)
> @@ -854,8 +861,15 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
>  
>  static void flush_memcg_workqueue(struct kmem_cache *s)
>  {
> +	/*
> +	 * memcg_params.dying is synchronized using slab_mutex AND
> +	 * memcg_kmem_wq_lock spinlock, because it's not always
> +	 * possible to grab slab_mutex.
> +	 */
>  	mutex_lock(&slab_mutex);
> +	spin_lock(&memcg_kmem_wq_lock);
>  	s->memcg_params.dying = true;
> +	spin_unlock(&memcg_kmem_wq_lock);

I would completely switch from the mutex to the new spin lock -
acquiring them both looks weird.

>  	mutex_unlock(&slab_mutex);
>  
>  	/*
