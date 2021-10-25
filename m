Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFBB4390C9
	for <lists+cgroups@lfdr.de>; Mon, 25 Oct 2021 10:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhJYIG3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Oct 2021 04:06:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45486 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhJYIG2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Oct 2021 04:06:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AC29C1FD34;
        Mon, 25 Oct 2021 08:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635149045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l21SlX/9kh43Ic37AW53KRYg/QWXqmopDdPfmAH/kdc=;
        b=eMrOCgSaFdI3lzR7WkVsSne/0Whu14mXXOGHTE5EXC7LHFchVV5T3UBKFzMCbaDaY613w1
        ikdq4RNXE7zyGDMnT3jKdP2gKvt6jH33g8ZZPjWfjj8njf3MaNH5I51wDnqQYTCASz7FRd
        r6Jz1WJWiRfnNmBh7Dku+xmZFCp0kl0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 09D93A3B81;
        Mon, 25 Oct 2021 08:04:04 +0000 (UTC)
Date:   Mon, 25 Oct 2021 10:04:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Vasily Averin <vvs@virtuozzo.com>, Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH memcg v3 2/3] mm, oom: do not trigger out_of_memory from
 the #PF
Message-ID: <YXZk9Lr217e+saSM@dhcp22.suse.cz>
References: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
 <cover.1634994605.git.vvs@virtuozzo.com>
 <f5fd8dd8-0ad4-c524-5f65-920b01972a42@virtuozzo.com>
 <e2a847a2-a414-2535-e3d1-b100a023b9d1@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2a847a2-a414-2535-e3d1-b100a023b9d1@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun 24-10-21 00:01:07, Tetsuo Handa wrote:
> On 2021/10/23 22:20, Vasily Averin wrote:
> >  /*
> > - * The pagefault handler calls here because it is out of memory, so kill a
> > - * memory-hogging task. If oom_lock is held by somebody else, a parallel oom
> > - * killing is already in progress so do nothing.
> > + * The pagefault handler calls here because some allocation has failed. We have
> > + * to take care of the memcg OOM here because this is the only safe context without
> > + * any locks held but let the oom killer triggered from the allocation context care
> > + * about the global OOM.
> >   */
> 
> Excuse me for a stupid question. I consider
> 
>   if (!mutex_trylock(&oom_lock))
>     return;
>   out_of_memory(&oc);
>   mutex_unlock(&oom_lock);
> 
> here as the last resort (safeguard) when neither __alloc_pages_may_oom()
> nor mem_cgroup_out_of_memory() can make progress. This patch says
> 
>   let the oom killer triggered from the allocation context care
>   about the global OOM.
> 
> but what if the OOM killer cannot be invoked from the allocation context?
> Is there a guarantee that all memory allocations which might result in
> VM_FAULT_OOM can invoke the OOM killer?

I do not think there is any guarantee. This code has meant to be a
safeguard but it turns out to be adding more harm than a safety. There
are several scenarios mentioned in this thread where this would be
counter productive or outright wrong thing to do.

On the other hand it is hard to imagine any legitimate situation where
this would be a right thing to do. Maybe you have something more
specific in mind? What would be the legit code to rely on OOM handling
out of the line (where the details about the allocation scope is lost)?
-- 
Michal Hocko
SUSE Labs
