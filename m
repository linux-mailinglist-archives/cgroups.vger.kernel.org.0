Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF74A112541
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2019 09:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfLDIfT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Dec 2019 03:35:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43511 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLDIfS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Dec 2019 03:35:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so2804122wre.10;
        Wed, 04 Dec 2019 00:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qV8BnIZcKdGe8g/B3hjF/qhzHGhiwqhh1CS3JHi7+oY=;
        b=dJ+iOk0nrjo08ouSvTi9Phu9bYVfP8B8lGOK/FxWccFa2S09GSt6sHQiSJDY6in7o5
         NToXPggo/i+sF+YzJiwmccXWyU+Nwx9BjbqbIt0WMJtYpj9FMaSf2LWoiCJ7bBKk+s+1
         l3uNBaMfXJ4dRGOuTYXJv/10g0JbwUAtA+DJFdWRDi3J/OAW7STpDI3BYwRDopvI3TFD
         utOyn4i/biUJEO6L3RcgQFatG/yOPY9NZ8Tf/m4jo4V5OJCPPyEiq0QqAi1YFjn2xjf9
         t53xVNVBrBnXNoGaay+S2E9Zw47aeJKCia6EA1t4MVsOZipgiEeDhpUosN8Y25K2232K
         y4zg==
X-Gm-Message-State: APjAAAUIrOt11L1Fbxzp80aAYKzvADJKdr4um+qZ3F2u1bphyq4cgagH
        gvUcxW5vYkJrnhSnxDv7ZHE=
X-Google-Smtp-Source: APXvYqzFdwhcGWtledJWcOOqneG+EdFvBn9gWujUMfZNGoZusAuGEFf87XEmN8KRoxRmuwTOLCbijA==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr2622697wrm.131.1575448515963;
        Wed, 04 Dec 2019 00:35:15 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id w13sm7529074wru.38.2019.12.04.00.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 00:35:15 -0800 (PST)
Date:   Wed, 4 Dec 2019 09:35:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH] mm: fix hanging shrinker management on long
 do_shrink_slab
Message-ID: <20191204083514.GC25242@dhcp22.suse.cz>
References: <20191129214541.3110-1-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129214541.3110-1-ptikhomirov@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 30-11-19 00:45:41, Pavel Tikhomirov wrote:
> We have a problem that shrinker_rwsem can be held for a long time for
> read in shrink_slab, at the same time any process which is trying to
> manage shrinkers hangs.
> 
> The shrinker_rwsem is taken in shrink_slab while traversing shrinker_list.
> It tries to shrink something on nfs (hard) but nfs server is dead at
> these moment already and rpc will never succeed. Generally any shrinker
> can take significant time to do_shrink_slab, so it's a bad idea to hold
> the list lock here.

Yes, this is a known problem and people have already tried to address it
in the past. Have you checked previous attempts? SRCU based one
http://lkml.kernel.org/r/153365347929.19074.12509495712735843805.stgit@localhost.localdomain
but I believe there were others (I only had this one in my notes).
Please make sure to Cc Dave Chinner when posting a next version because
he had some concerns about the change of the behavior.

> We have a similar problem in shrink_slab_memcg, except that we are
> traversing shrinker_map+shrinker_idr there.
> 
> The idea of the patch is to inc a refcount to the chosen shrinker so it
> won't disappear and release shrinker_rwsem while we are in
> do_shrink_slab, after that we will reacquire shrinker_rwsem, dec
> the refcount and continue the traversal.

The reference count part makes sense to me. RCU role needs a better
explanation. Also do you have any reason to not use completion for
the final step? Openconding essentially the same concept sounds a bit
awkward to me.

> We also need a wait_queue so that unregister_shrinker can wait for the
> refcnt to become zero. Only after these we can safely remove the
> shrinker from list and idr, and free the shrinker.
[...]
>   crash> bt ...
>   PID: 18739  TASK: ...  CPU: 3   COMMAND: "bash"
>    #0 [...] __schedule at ...
>    #1 [...] schedule at ...
>    #2 [...] rpc_wait_bit_killable at ... [sunrpc]
>    #3 [...] __wait_on_bit at ...
>    #4 [...] out_of_line_wait_on_bit at ...
>    #5 [...] _nfs4_proc_delegreturn at ... [nfsv4]
>    #6 [...] nfs4_proc_delegreturn at ... [nfsv4]
>    #7 [...] nfs_do_return_delegation at ... [nfsv4]
>    #8 [...] nfs4_evict_inode at ... [nfsv4]
>    #9 [...] evict at ...
>   #10 [...] dispose_list at ...
>   #11 [...] prune_icache_sb at ...
>   #12 [...] super_cache_scan at ...
>   #13 [...] do_shrink_slab at ...

Are NFS people aware of this? Because this is simply not acceptable
behavior. Memory reclaim cannot be block indefinitely or for a long
time. There must be a way to simply give up if the underlying inode
cannot be reclaimed.

I still have to think about the proposed solution. It sounds a bit over
complicated to me.
-- 
Michal Hocko
SUSE Labs
