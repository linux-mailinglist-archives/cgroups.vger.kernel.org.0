Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B921432435
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 18:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhJRQyH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 12:54:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43788 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhJRQxh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 12:53:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1406121966;
        Mon, 18 Oct 2021 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634575885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6d1q+ubZusaXumuE3riMUHm2jTbTP959W22zG60KItg=;
        b=fKu+qOYXhZzEp+4Webr7Gz5rjCvBK4A8tlusIDpeSd3E8XdtJaNxr8PAFbK6W9yO+rJ8pN
        oVQLPo5TxdQHL4pK+LLbCl4u0Z1E4/d/0cwHIYBJh+eMmFEbE4ldAJ0nwZHCPEYUZBx6J/
        E8Tohc07y3OCyC2sRGMX3CMeUir1HFw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C44B3A3B83;
        Mon, 18 Oct 2021 16:51:24 +0000 (UTC)
Date:   Mon, 18 Oct 2021 18:51:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@openvz.org
Subject: Re: [PATCH memcg 0/1] false global OOM triggered by memcg-limited
 task
Message-ID: <YW2mDDYRkXkQbZAR@dhcp22.suse.cz>
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
 <YW04jWSv6pQb2Goe@dhcp22.suse.cz>
 <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
 <YW1gRz0rTkJrvc4L@dhcp22.suse.cz>
 <27dc0c49-a0d6-875b-49c6-0ef5c0cc3ac8@virtuozzo.com>
 <YW1oMxNkUCaAimmg@dhcp22.suse.cz>
 <CALvZod42uwgrg83CCKn6JgYqAQtR1RLJSuybNYjtkFo4wVgT1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod42uwgrg83CCKn6JgYqAQtR1RLJSuybNYjtkFo4wVgT1w@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 18-10-21 08:07:20, Shakeel Butt wrote:
> On Mon, Oct 18, 2021 at 5:27 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > [restore the cc list]
> >
> > On Mon 18-10-21 15:14:26, Vasily Averin wrote:
> > > On 18.10.2021 14:53, Michal Hocko wrote:
> > > > On Mon 18-10-21 13:05:35, Vasily Averin wrote:
> > > >> On 18.10.2021 12:04, Michal Hocko wrote:
> > > >> Here we call try_charge_memcg() that return success and approve the allocation,
> > > >> however then we hit into kmem limit and fail the allocation.
> > > >
> > > > Just to make sure I understand this would be for the v1 kmem explicit
> > > > limit, correct?
> > >
> > > yes, I mean this limit.
> >
> > OK, thanks for the clarification. This is a known problem. Have a look
> > at I think we consider that one to 0158115f702b ("memcg, kmem: deprecate
> > kmem.limit_in_bytes"). We are reporting the deprecated and to-be removed
> > status since 2019 without any actual report sugested by the kernel
> > message. Maybe we should try and remove it and see whether that prompts
> > some pushback.
> >
> 
> Yes, I think now should be the right time to take the next step for
> deprecation of kmem limits:
> https://lore.kernel.org/all/20201118175726.2453120-1-shakeelb@google.com/

I completely forgot about your patch.  Anyway, it usually takes us years
to deprecate something so let's stick with it and consider 2 years as
years ;)

-- 
Michal Hocko
SUSE Labs
