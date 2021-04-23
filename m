Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AFB368D0B
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 08:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhDWGVQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 02:21:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:60268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhDWGVP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 23 Apr 2021 02:21:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619158839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gWQ/jtCp4l7XsOhkZSQRBGSW2Rsfk3107+x/NpXeseg=;
        b=A7byGxZJ2VZ7pDkLkKRG2KnUM7W0zOh0/5akvuiizh9QecTv8EvXb6ZXZgQ400875Yyrw1
        ULG9Ds0Q250X6OQ9pboXIPqa/ec2Zt05L4I49u1ONzGQqQTtXVHCGRNj7T9dctJ8Vq/hWA
        7VY6pYf2p3cVDgQMosqCCZnv7oUa98U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E1CF9B187;
        Fri, 23 Apr 2021 06:20:38 +0000 (UTC)
Date:   Fri, 23 Apr 2021 08:20:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Borislav Petkov <bp@alien8.de>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 16/16] memcg: enable accounting for ldt_struct objects
Message-ID: <YIJnNfBgp3FK9A0z@dhcp22.suse.cz>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <94dd36cb-3abb-53fc-0f23-26c02094ddf4@virtuozzo.com>
 <20210422122615.GA7021@zn.tnic>
 <29fe6b29-d56a-6ea1-2fe7-2b015f6b74ef@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29fe6b29-d56a-6ea1-2fe7-2b015f6b74ef@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 23-04-21 06:13:30, Vasily Averin wrote:
> On 4/22/21 3:26 PM, Borislav Petkov wrote:
> > On Thu, Apr 22, 2021 at 01:38:01PM +0300, Vasily Averin wrote:
> > 
> > You have forgotten to Cc LKML on your submission.
> I think it's OK, patch set is addressed to cgroups subsystem amiling list.
> Am I missed something and such patches should be sent to LKML anyway?

Yes, it is preferable to CC all patches to lkml. These patches are not
cgroup specit much. A specific subsystem knowledge is require to judge
them and most people are not subscribed to the cgroup ML.

> >> @@ -168,9 +168,10 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
> >>  	 * than PAGE_SIZE.
> >>  	 */
> >>  	if (alloc_size > PAGE_SIZE)
> >> -		new_ldt->entries = vzalloc(alloc_size);
> >> +		new_ldt->entries = __vmalloc(alloc_size,
> >> +					     GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> > 
> > You don't have to break that line - just let it stick out.
> Hmm. I missed that allowed line limit was increased up to 100 bytes,
> Thank you, I will fix it in next patch version. 

Line limits are more of a guidance than a hard rule. Also please note
that different subsystems' maintainers insist on this guidance
differently.
-- 
Michal Hocko
SUSE Labs
