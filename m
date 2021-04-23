Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3763690B0
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 12:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhDWK6K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 06:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhDWK6J (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 23 Apr 2021 06:58:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8617161461;
        Fri, 23 Apr 2021 10:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619175453;
        bh=QwPNCCBwlne5k1vVEgLnUAp8OWXGGJbWMK3sscYCoOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zClMRVibFXTHHAlqv6HDb6lcSjkQuRAiykNCox1hCxkDmSCh37IvFpos0VnU3sTu4
         WL5wMnEE6ne5PYDied/qpECZn+OsanB6O9ASqTASBWRlwdA6ZmQHO+RlfSwxamKZRu
         ZyzB4AeCOOaUiQJYzvuvzAX7IGJEq1kEUU5wFhnE=
Date:   Fri, 23 Apr 2021 12:57:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 15/16] memcg: enable accounting for tty-related objects
Message-ID: <YIKoGr/IFLyWiiRW@kroah.com>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <da450388-2fbc-1bb8-0839-b6480cb0eead@virtuozzo.com>
 <YIFcqcd4dCiNcILj@kroah.com>
 <YIFhuwlXKaAaY3IU@dhcp22.suse.cz>
 <YIFjI3zHVQr4BjHc@kroah.com>
 <6e697a1f-936d-5ffe-d29f-e4dcbe099799@virtuozzo.com>
 <03cb1ce9-143a-1cd0-f34b-d608c3bbc66c@virtuozzo.com>
 <YIKMMSf1uPrWmT2V@dhcp22.suse.cz>
 <31c49c60-44db-0363-3d07-5febe0048e86@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31c49c60-44db-0363-3d07-5febe0048e86@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 23, 2021 at 01:29:53PM +0300, Vasily Averin wrote:
> On 4/23/21 11:58 AM, Michal Hocko wrote:
> > On Fri 23-04-21 10:53:55, Vasily Averin wrote:
> >> On 4/22/21 4:59 PM, Vasily Averin wrote:
> >>> On 4/22/21 2:50 PM, Greg Kroah-Hartman wrote:
> >>>> On Thu, Apr 22, 2021 at 01:44:59PM +0200, Michal Hocko wrote:
> >>>>> On Thu 22-04-21 13:23:21, Greg KH wrote:
> >>>>>> On Thu, Apr 22, 2021 at 01:37:53PM +0300, Vasily Averin wrote:
> >>>>>>> At each login the user forces the kernel to create a new terminal and
> >>>>>>> allocate up to ~1Kb memory for the tty-related structures.
> >>>>>>
> >>>>>> Does this tiny amount of memory actually matter?
> >>>>>
> >>>>> The primary question is whether an untrusted user can trigger an
> >>>>> unbounded amount of these allocations.
> >>>>
> >>>> Can they?  They are not bounded by some other resource limit?
> >>>
> >>> I'm not ready to provide usecase right now,
> >>> but on the other hand I do not see any related limits.
> >>> Let me take time out to dig this question.
> >>
> >> By default it's allowed to create up to 4096 ptys with 1024 reserve for initns only
> >> and the settings are controlled by host admin. It's OK.
> >> Though this default is not enough for hosters with thousands of containers per node.
> >> Host admin can be forced to increase it up to NR_UNIX98_PTY_MAX = 1<<20.
> >>
> >> By default container is restricted by pty mount_opt.max = 1024, but admin inside container 
> >> can change it via remount. In result one container can consume almost all allowed ptys 
> >> and allocate up to 1Gb of unaccounted memory.
> >>
> >> It is not enough per-se to trigger OOM on host, however anyway, it allows to significantly
> >> exceed the assigned memcg limit and leads to troubles on the over-committed node.
> >> So I still think it makes sense to account this memory.
> > 
> > This is a very valuable information to have in the changelog. It is not
> > my call but if all the above is correct then the accounting is worth
> > IMO.
> 
> If Greg doesn't have any objections, I'll add this explanation to the next version of the patch.
> 

I object to the current text you submitted, so something has to change
in order for me to be able to accept the patch :)

Seriously, yes, the above information is great, please include that and
all should be fine.

thanks,

greg k-h
