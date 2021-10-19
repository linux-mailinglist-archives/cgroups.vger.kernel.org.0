Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC733433F79
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhJSTyD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Oct 2021 15:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhJSTyD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 19 Oct 2021 15:54:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D30336113B;
        Tue, 19 Oct 2021 19:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634673110;
        bh=jGj86H0JaCzg0FpU/IIjOqXur5MOCHmg5HVDErAlS9c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TE+8q5G6fg7FTvw+yGNn9m1udm/EaXQQxjSdnl2DK2j9ru/LUmoehpNnHbrC3ahjC
         L3ozhy5L4vY9OfwgTE/VfwTdlx7EA2Oi0pPjdAPUIGoqSfE9cYyVqOgIumoSSkTTZc
         rqu3KbK+HyM8WLPftcSg3LwtyGTSq5mEdyEezJdg=
Date:   Tue, 19 Oct 2021 12:51:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v3] memcg, kmem: further deprecate kmem.limit_in_bytes
Message-Id: <20211019125147.0ad010f318bbd8233cadcdae@linux-foundation.org>
In-Reply-To: <20211019153408.2916808-1-shakeelb@google.com>
References: <20211019153408.2916808-1-shakeelb@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 19 Oct 2021 08:34:08 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> The deprecation process of kmem.limit_in_bytes started with the commit
> 0158115f702 ("memcg, kmem: deprecate kmem.limit_in_bytes") which also
> explains in detail the motivation behind the deprecation. To summarize,
> it is the unexpected behavior on hitting the kmem limit. This patch
> moves the deprecation process to the next stage by disallowing to set
> the kmem limit. In future we might just remove the kmem.limit_in_bytes
> file completely.
> 
> ...
>
> @@ -3791,10 +3766,8 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
>  			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
>  			break;
>  		case _KMEM:
> -			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
> -				     "Please report your usecase to linux-mm@kvack.org if you "
> -				     "depend on this functionality.\n");
> -			ret = memcg_update_kmem_max(memcg, nr_pages);
> +			/* kmem.limit_in_bytes is deprecated. */
> +			ret = -ENOTSUPP;
>  			break;
>  		case _TCP:
>  			ret = memcg_update_tcp_max(memcg, nr_pages);

checkpatch said "ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP"?
