Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E2231B717
	for <lists+cgroups@lfdr.de>; Mon, 15 Feb 2021 11:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBOKZ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Feb 2021 05:25:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:35018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhBOKZS (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Feb 2021 05:25:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613384672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S/uXPqP/TPAc7XRGUiDHNcqY2NlR0ZY7sWeSVPIWRdU=;
        b=byxFEEer+FNeRJefGNaijsTv6q5BgfdLMmDFs1e5b857DcUUx1kH37qGAJaiZMlddjghyP
        v/1T9hEEquxK4/1h+tm8tkcdDWZSzsP2N4T6I6up164j8+LGl2u6O9G5c5eob7Wgm8P00B
        kRekUTvPEJESkt1i5RxABRMr6shqbVE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 394E5AC32;
        Mon, 15 Feb 2021 10:24:32 +0000 (UTC)
Date:   Mon, 15 Feb 2021 11:24:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH 4/4] mm: memcontrol: fix swap uncharge on
 cgroup v2
Message-ID: <YCpL357b8GFRYo1T@dhcp22.suse.cz>
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-4-songmuchun@bytedance.com>
 <YCpDSnLSDoE/FHK5@dhcp22.suse.cz>
 <CAMZfGtVSXG5BRR9R3_+eeoCCWBW87GLVNLPwZCyDUHNeAPrXUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVSXG5BRR9R3_+eeoCCWBW87GLVNLPwZCyDUHNeAPrXUw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 15-02-21 18:15:36, Muchun Song wrote:
> On Mon, Feb 15, 2021 at 5:47 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Sat 13-02-21 01:01:59, Muchun Song wrote:
> > > The swap charges the actual number of swap entries on cgroup v2.
> > > If a swap cache page is charged successful, and then we uncharge
> > > the swap counter. It is wrong on cgroup v2. Because the swap
> > > entry is not freed.
> >
> > Is there any actual problem though? Can you describe the specific
> > scenario please? Swap cache charge life time is a bit tricky and I have
> > to confess I have to relearn it every time I need to understand it. The
> > patch would be much more easier to review if the changelog was much more
> > specific.
> 
> I copied the reply to Shakeel here. :-)

Not helpful much. I have seen that reply before answering your patch.
I really have to say I find it rather annoying to constantly get unclear
and cryptic responses from you. This is a subtle area! Make your claims
clear and specific so they can be verified.

-- 
Michal Hocko
SUSE Labs
