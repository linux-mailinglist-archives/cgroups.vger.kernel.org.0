Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91203310935
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 11:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhBEKfU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 05:35:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:47602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231320AbhBEKdO (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 5 Feb 2021 05:33:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612521146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ACh5Vg4Vj3WoVaDbqs/kysUN1AfSYSlCpU+9KnbgM40=;
        b=hwvRcbTJ3MEj6IBdwwkoKfwd7NWUhfVRJzQxI0/0co73u9YtUF+1WTj6RZoYNiQiuFvlwE
        VdvkdMruE4nY0z5v8xMHShGJwr94gj1gcxWa9jf53SJAL8YbmRWCqt87qpQC/dLOpeMSF5
        pMYbJbatpZx7hig7uJJPRQjhHVUDU20=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05899ACBA;
        Fri,  5 Feb 2021 10:32:26 +0000 (UTC)
Date:   Fri, 5 Feb 2021 11:32:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: remove rcu_read_lock from
 get_mem_cgroup_from_page
Message-ID: <YB0euLiMU+T/9bMK@dhcp22.suse.cz>
References: <20210205062719.74431-1-songmuchun@bytedance.com>
 <YB0DnAlCaQza4Uf9@dhcp22.suse.cz>
 <CAMZfGtVhBrwgkJVwiah6eDsppSf8fYp+uZ=tZmHBLDFeTmQX3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVhBrwgkJVwiah6eDsppSf8fYp+uZ=tZmHBLDFeTmQX3w@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 05-02-21 17:14:30, Muchun Song wrote:
> On Fri, Feb 5, 2021 at 4:36 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 05-02-21 14:27:19, Muchun Song wrote:
> > > The get_mem_cgroup_from_page() is called under page lock, so the page
> > > memcg cannot be changed under us.
> >
> > Where is the page lock enforced?
> 
> Because it is called from alloc_page_buffers(). This path is under
> page lock.

I do not see any page lock enforecement there. There is not even a
comment requiring that. Can we grow more users where this is not the
case? There is no actual relation between alloc_page_buffers and
get_mem_cgroup_from_page except that the former is the only _current_
existing user. I would be careful to dictate locking based solely on
that.

> > > Also, css_get is enough because page
> > > has a reference to the memcg.
> >
> > tryget used to be there to guard against offlined memcg but we have
> > concluded this is impossible in this path. tryget stayed there to catch
> > some unexpected cases IIRC.
> 
> Yeah, it can catch some unexpected cases. But why is this path
> special so that we need a tryget?

I do not remember details and the changelog of that change is not
explicit but I suspect it was just because this one could trigger as
there are external callers to memcg. Is this protection needed? I am not
sure, this is for you to justify if you want to remove it.

> > > If we really want to make the get_mem_cgroup_from_page() suitable for
> > > arbitrary page, we should use page_memcg_rcu() instead of page_memcg()
> > > and call it after rcu_read_lock().
> >
> > What is the primary motivation to change this code? is the overhead of
> > tryget/RCU something that needs optimizing?
> 
> Actually, the rcu_read_lock() is not necessary here. So it is better to
> remove it (indeed reduce some code).

Please state your reasoning in the changelog including benefits we get
from it.
-- 
Michal Hocko
SUSE Labs
