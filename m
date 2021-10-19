Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DB3433185
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 10:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhJSItZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Oct 2021 04:49:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50906 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbhJSItY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Oct 2021 04:49:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2D7F51FC9E;
        Tue, 19 Oct 2021 08:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634633231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0QHVkjPX9VWQRCDOqIEsYscNDDX26IKKHuDWyHZH10w=;
        b=obAil+Lvy/jiFKcRq+daqcHuy3BlO8iF3QBGc7EhSR8cyxH3Al4LqUe4xHFm073qBhTry1
        nUBXAVFNa1/pxddYSY/AxT1ZnUX9i+lzvHm1IYcMGNka7Y+t5RUid2t95S0HGVjKREu3BF
        dBkp2OQGxxF2IifpgqYPxxS2OyJ64iw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AC166A3B8D;
        Tue, 19 Oct 2021 08:47:10 +0000 (UTC)
Date:   Tue, 19 Oct 2021 10:47:09 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
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
Message-ID: <YW6GDYayGogxSq1v@dhcp22.suse.cz>
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
 <YW04jWSv6pQb2Goe@dhcp22.suse.cz>
 <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
 <YW1gRz0rTkJrvc4L@dhcp22.suse.cz>
 <27dc0c49-a0d6-875b-49c6-0ef5c0cc3ac8@virtuozzo.com>
 <YW1oMxNkUCaAimmg@dhcp22.suse.cz>
 <CALvZod42uwgrg83CCKn6JgYqAQtR1RLJSuybNYjtkFo4wVgT1w@mail.gmail.com>
 <153f7aa6-39ef-f064-8745-a9489e088239@virtuozzo.com>
 <CALvZod5Kut63MLVfCkEW5XemqN4Jnd1iEQD_Gk0w5=fPffL8Bg@mail.gmail.com>
 <25120323-d222-cc5e-fe08-6471bce13bd6@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25120323-d222-cc5e-fe08-6471bce13bd6@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 19-10-21 09:42:38, Vasily Averin wrote:
> On 19.10.2021 08:33, Shakeel Butt wrote:
> > On Mon, Oct 18, 2021 at 11:52 AM Vasily Averin <vvs@virtuozzo.com> wrote:
> >>
> >> On 18.10.2021 18:07, Shakeel Butt wrote:
> >>> On Mon, Oct 18, 2021 at 5:27 AM Michal Hocko <mhocko@suse.com> wrote:
> >>>>
> >>>> [restore the cc list]
> >>>>
> >>>> On Mon 18-10-21 15:14:26, Vasily Averin wrote:
> >>>>> On 18.10.2021 14:53, Michal Hocko wrote:
> >>>>>> On Mon 18-10-21 13:05:35, Vasily Averin wrote:
> >>>>>>> On 18.10.2021 12:04, Michal Hocko wrote:
> >>>>>>> Here we call try_charge_memcg() that return success and approve the allocation,
> >>>>>>> however then we hit into kmem limit and fail the allocation.
> >>>>>>
> >>>>>> Just to make sure I understand this would be for the v1 kmem explicit
> >>>>>> limit, correct?
> >>>>>
> >>>>> yes, I mean this limit.
> >>>>
> >>>> OK, thanks for the clarification. This is a known problem. Have a look
> >>>> at I think we consider that one to 0158115f702b ("memcg, kmem: deprecate
> >>>> kmem.limit_in_bytes"). We are reporting the deprecated and to-be removed
> >>>> status since 2019 without any actual report sugested by the kernel
> >>>> message. Maybe we should try and remove it and see whether that prompts
> >>>> some pushback.
> >>>
> >>> Yes, I think now should be the right time to take the next step for
> >>> deprecation of kmem limits:
> >>> https://lore.kernel.org/all/20201118175726.2453120-1-shakeelb@google.com/
> >>
> >> Are you going to push it to stable kernels too?
> > 
> > Not really. Is there a reason I should? More exposure to catch breakage?
> 
> There is a problem: kmem limit can trigger fake global OOM.
> To fix it in upstream you can remove kmem controller.
> 
> However how to handle this problem in stable and LTS kernels?

I do not see any bug reports coming in and I strongly suspect this is
because the functionality is simply not used wildly enough or in the
mode where it would matter (U != 0, K < U from our documentation).
If there are relevant usecases for this setup then we really want to
hear about those because we do not want to break userspace. Handling
that setup would far from trivial and the global oom killer is not the
only one of those.

> My current patch resolves the problem too, and it can be backported.
> However I afraid nobody will do it if teh patch will not be approved in upsteam.

I do not think your current approach is the right one. We do not really
want yet another flag to tell we are in a memcg OOM. We already have
one.

A proper way is to deal with the pagefault oom killer trigger but that
might be just too risky for stable kernels. 
-- 
Michal Hocko
SUSE Labs
