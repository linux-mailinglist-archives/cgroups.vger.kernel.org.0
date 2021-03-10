Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE57333A3B
	for <lists+cgroups@lfdr.de>; Wed, 10 Mar 2021 11:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhCJKlT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Mar 2021 05:41:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:46404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhCJKlQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Mar 2021 05:41:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615372875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZTPkVjV+mQdbkg1znHnpckUqBiD+p2S+HbVcCoP3kY=;
        b=bwZeSFYTFUaI6k5iEVR5XFMy1jPlekVWZKMv+nY/aKA6C+txpjGOWyhpx/j5aXqEg0ZQji
        57JZ+A9hVmISWq5KpmmR+Li43cWJMh4Y5jD9UtZz132HBk1cpZfQ1XYn5BEOOUvyy+mzPG
        /hk5kqKbchb70cq4l+HcBR/14KoqXwk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6160DAE42;
        Wed, 10 Mar 2021 10:41:15 +0000 (UTC)
Date:   Wed, 10 Mar 2021 11:41:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 0/9] memcg accounting from OpenVZ
Message-ID: <YEiiQ2TGnJcEtL3d@dhcp22.suse.cz>
References: <5affff71-e503-9fb9-50cb-f6d48286dd52@virtuozzo.com>
 <CALvZod5YOtqXcSqn2Zj2Nb_SKgDRKOMW4o5i-u_yj7CanQVtGQ@mail.gmail.com>
 <ad68d004-fa84-3d21-60b7-d4a342ad4007@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad68d004-fa84-3d21-60b7-d4a342ad4007@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 10-03-21 13:17:19, Vasily Averin wrote:
> On 3/10/21 12:12 AM, Shakeel Butt wrote:
> > On Tue, Mar 9, 2021 at 12:04 AM Vasily Averin <vvs@virtuozzo.com> wrote:
> >>
> >> OpenVZ many years accounted memory of few kernel objects,
> >> this helps us to prevent host memory abuse from inside memcg-limited container.
> >>
> > 
> > The text is cryptic but I am assuming you wanted to say that OpenVZ
> > has remained on a kernel which was still on opt-out kmem accounting
> > i.e. <4.5. Now OpenVZ wants to move to a newer kernel and thus these
> > patches are needed, right?
> 
> Something like this.
> Frankly speaking I badly understand which arguments should I provide to upstream
> to enable accounting for some new king of objects.
> 
> OpenVZ used own accounting subsystem since 2001 (i.e. since v2.2.x linux kernels) 
> and we have accounted all required kernel objects by using our own patches.
> When memcg was added to upstream Vladimir Davydov added accounting of some objects
> to upstream but did not skipped another ones.
> Now OpenVZ uses RHEL7-based kernels with cgroup v1 in production, and we still account
> "skipped" objects by our own patches just because we accounted such objects before.
> We're working on rebase to new kernels and we prefer to push our old patches to upstream. 

That is certainly an interesting information. But for a changelog it
would be more appropriate to provide information about how much memory
user can induce and whether there is any way to limit that memory by
other means. How practical those other means are and which usecases will
benefit from the containment.

-- 
Michal Hocko
SUSE Labs
