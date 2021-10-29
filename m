Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE643F7FB
	for <lists+cgroups@lfdr.de>; Fri, 29 Oct 2021 09:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhJ2Hsr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Oct 2021 03:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232253AbhJ2Hsq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 29 Oct 2021 03:48:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4418D61130;
        Fri, 29 Oct 2021 07:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635493578;
        bh=CmRFDCkM+5+pmJyXLBO216K+Ezk6KWp7TPmW78qsJGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gp6Cc2HU1a8QNtbNxiSGoY3igMOXEd6afDTEJNnaMinOJK5AR9NA2fs2ga1qGoTD/
         CDyxRzdSb3VpwHi4N+coZss6O1S0hj9Uld35ZI2dpq5sjLgXvX0W1AvkOePCe1k6Ot
         fiEm76PEnRlwWhI8VvKz5OsWVts1V8Yd3s83maT4=
Date:   Fri, 29 Oct 2021 09:46:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH memcg v3 3/3] memcg: prohibit unconditional exceeding the
 limit of dying tasks
Message-ID: <YXumyHT5GusoZOY8@kroah.com>
References: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
 <cover.1634994605.git.vvs@virtuozzo.com>
 <8f5cebbb-06da-4902-91f0-6566fc4b4203@virtuozzo.com>
 <YXZ6qaMJBomVfV8O@dhcp22.suse.cz>
 <20211027153608.9910f7db99d5ef574045370e@linux-foundation.org>
 <ea14200f-ad2c-6901-25da-54900fe2ce14@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea14200f-ad2c-6901-25da-54900fe2ce14@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 28, 2021 at 10:22:56AM +0300, Vasily Averin wrote:
> On 28.10.2021 01:36, Andrew Morton wrote:
> > On Mon, 25 Oct 2021 11:36:41 +0200 Michal Hocko <mhocko@suse.com> wrote:
> > 
> >> My view on stable backport is similar to the previous patch. If we want
> >> to have it there then let's wait for some time to see whether there are
> >> any fallouts as this patch depends on the PF_OOM change.
> > 
> > It's strange that [1/3] doesn't have cc:stable, but [2/3] and [3/3] do
> > not.  What is the thinking here?
> 
> My fault, I missed it.
> All 3 patches should be backported,
> I did it already to stables kernels since 4.4 and I'm ready to submit it in demand.
> 
> > I expect we'd be OK with merging these into 5.16-rc1.  This still gives
> > another couple of months in -rc to shake out any problems.  But I
> > suspect the -stable maintainers will merge and release the patches
> > before they are released in 5.16.
> > 
> > In which case an alternative would be not to mark these patches
> > cc:stable and to somehow remember to ask the -stable maintainers to
> > merge them after 5.16 has been on the streets for a suitable period.
> > 
> > Greg, thoughts?
> 
> If you wish I can remind Greg in a month or even after 5.17 release.

Please remind us then, otherwise I will not remember :)

thanks,

greg k-h
