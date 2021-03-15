Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B507E33C395
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 18:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhCORJy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 13:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234153AbhCORJo (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Mar 2021 13:09:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C141600CD;
        Mon, 15 Mar 2021 17:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615828184;
        bh=zcAvAGDwBXL4yn9+QAipdGh2ahuWzmm+14R4I24+RkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g6Iu0CEZAFaH5Jg9ZoCgtWqgWKonb1NUFHkQBS+M3GiQKDr1/V6urCCfAQusUacWg
         9IEoYmTBriW3L1iLGoMQh2ng98CeiB7GT/qpZofsexz8wcH6gvisOU2jD2eAplAtwL
         tvvDVOYwUEK+SvCMDpY+hA+Yi6q4KV4Mapbp6Ucwe2s8nzGdNn/GKT6uq0EXtFKNzo
         +ejhdyR3aultI9g8H7wVlV7YZMKr5CLOEXJKDHKrK5Ag/yYSyY5suey7dsE0njPUx7
         NkDKeAQ8MzgpRtH80v5cxNtdnVLw8+yLToIOKa9Fk44xUGUlAjzRc/N+F423u/jgac
         zuQYZjBJXc+Rw==
Date:   Mon, 15 Mar 2021 10:09:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH v2 1/8] memcg: accounting for fib6_nodes cache
Message-ID: <20210315100942.3cc98bb4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <85b5f428-294b-af57-f496-5be5fddeeeea@virtuozzo.com>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
        <85b5f428-294b-af57-f496-5be5fddeeeea@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 15 Mar 2021 15:23:00 +0300 Vasily Averin wrote:
> An untrusted netadmin inside a memcg-limited container can create a
> huge number of routing entries. Currently, allocated kernel objects
> are not accounted to proper memcg, so this can lead to global memory
> shortage on the host and cause lot of OOM kiils.
> 
> One such object is the 'struct fib6_node' mostly allocated in
> net/ipv6/route.c::__ip6_ins_rt() inside the lock_bh()/unlock_bh() section:
> 
>  write_lock_bh(&table->tb6_lock);
>  err = fib6_add(&table->tb6_root, rt, info, mxc);
>  write_unlock_bh(&table->tb6_lock);
> 
> It this case is not enough to simply add SLAB_ACCOUNT to corresponding
> kmem cache. The proper memory cgroup still cannot be found due to the
> incorrect 'in_interrupt()' check used in memcg_kmem_bypass().
> To be sure that caller is not executed in process contxt
> '!in_task()' check should be used instead

Sorry for a random question, I didn't get the cover letter. 

What's the overhead of adding SLAB_ACCOUNT?

Please make sure you CC netdev on series which may impact networking.
