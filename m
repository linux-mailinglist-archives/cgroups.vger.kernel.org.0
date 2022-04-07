Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB534F77DD
	for <lists+cgroups@lfdr.de>; Thu,  7 Apr 2022 09:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbiDGHmk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Apr 2022 03:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242001AbiDGHm0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Apr 2022 03:42:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C57E5AA;
        Thu,  7 Apr 2022 00:40:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A15501F85A;
        Thu,  7 Apr 2022 07:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649317223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7tdKrRRhBcgriuTuifhqw7ASOmfz1N4EF+9FSFvKM0E=;
        b=r6Fua2gzlgwm1Hp5y5shaiTcDw1GVtrXgPXQb3p55UEWWygcN+jDp11/05+NYmm1vYKIPm
        7lKd36aXjuqVnfrCXhRi1YOIr/f0RG7VdejwUm/BA3RtBxq+NH8LIxlM76mVrvdJ9L4eTi
        qlUYyggclZvcVPbb3HDCBf6Y35i3cPo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DF5F4A3B82;
        Thu,  7 Apr 2022 07:40:18 +0000 (UTC)
Date:   Thu, 7 Apr 2022 09:40:22 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
Message-ID: <Yk6VZlGnB48RqnYW@dhcp22.suse.cz>
References: <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com>
 <YkqxpEW4m6iU3zMq@dhcp22.suse.cz>
 <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
 <CAGWkznGMRohE2_at4Qh8KbwSqNmNqOAG2N1EM+7uE9wKqzRm0A@mail.gmail.com>
 <Ykq7KUleuAg5QnNU@dhcp22.suse.cz>
 <CAGWkznGbd5TOTHZE8uUhak3SnHqEWx_9QCJVtUFUSg9rk3xYEQ@mail.gmail.com>
 <Ykrkx4JML4c81gBV@dhcp22.suse.cz>
 <CAGWkznEaEavCz9GeiYuTqsox2qZK43iQKevt8njkzaHv6KiW-A@mail.gmail.com>
 <YkwxNaJIg6ptJOYT@dhcp22.suse.cz>
 <CAGWkznG=QH3HRSzgum0sQBkyQAahqgiWf8nXCv1qXstxrn7e8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznG=QH3HRSzgum0sQBkyQAahqgiWf8nXCv1qXstxrn7e8w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 06-04-22 10:11:19, Zhaoyang Huang wrote:
> On Tue, Apr 5, 2022 at 8:08 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 04-04-22 21:14:40, Zhaoyang Huang wrote:
> > [...]
> > > Please be noticed that this patch DOES protect the memcg when external
> > > pressure is 1GB as fixed low does.
> >
> > This is getting more and more confusing (at least to me). Could you
> > describe the behavior of the reclaim for the following setups/situations?
> >
> > a) mostly reclaiming a clean page cache - via kswapd
> > b) same as above but the direct reclaim is necessary but very
> >    lightweight
> > c) direct reclaim makes fwd progress but not enough to satisfy the
> >    allocation request (so the reclaim has to be retried)
> > d) direct reclaim not making progress and low limit protection is
> >    ignored.
> >
> > Say we have several memcgs and only some have low memory protection
> > configured. What is the user observable state of the protected group and
> > when and how much the protection can be updated?
> I am not sure if I understand you right. Do you have suspicions on the
> test result as you think protected memcg has no chance to update the
> protection or the global reclaim should have been satisfied with the
> reclaiming(step d is hard to reach?). Let me try to answer it under my
> understanding, please give me feedback if you need more info. The
> protection is updated while mem_cgroup_calculate_protection is called
> during either kswapd or direct reclaim for each round of the priority
> reclaiming and then the memcg's lruvec will be reached in step d.

This means that limits are altered even if there is memory to be
reclaimed from other memcgs. Why? How does this line up with the
basic property of the low limit to act as a protection from the reclaim?

> > I think it would be also helpful to describe the high level semantic of
> > this feature.

Please focus on this part. Without a high level semantic explained we
will not move forward.
-- 
Michal Hocko
SUSE Labs
