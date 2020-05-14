Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7145C1D28F8
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2020 09:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgENHmy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 May 2020 03:42:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41922 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgENHmy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 May 2020 03:42:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id h17so2528654wrc.8
        for <cgroups@vger.kernel.org>; Thu, 14 May 2020 00:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VHNZT24uTNtfNyYXFFh3soVdVgG050h0Qkwne9a9wt8=;
        b=qwBcKvlR8plQoGqA3UlINa9+QEoA4ebw2FAk79SMWb3YzE10+SBMM95zTXfv2sOmGP
         lfZRjp1WgNGQ26UMDM136lHiC+DjrzFsiErZB6XiQLl9YCmC0mxnxg6qfBM6kduPIMlp
         MRbCiD8j5s+Eu1tEhbXeFo2MJDRdtCJZPXIlzyO6JpY5gDJytSfNeMgcg4BWzYAwAwZU
         rpY2Flz142AS2Qr5oCuW7/ZGVFC3r1Lt8XOsIXZ5dbFSsVpQsZU56CA26/UhgfSIa93T
         UNpF8IxkLclUYCvgqs/vRaRoHTOKbMGpcpKJaB7mJMZbzZ2cvDlogeA0sZ5+6bmwaNky
         lhag==
X-Gm-Message-State: AOAM530qmI0SFFTFR8+U2J7AU9zm7Q5c7/KdiOseNZTTidzDk17prfVn
        KAxwOuYU1azVopH1m01idp8=
X-Google-Smtp-Source: ABdhPJxMkwkAsCAmgteaP0XMHDnqfPTr1N0HSDLobVclLm37TM8NtbRjbpdn4VjRgRk4/na8bVt1Rg==
X-Received: by 2002:adf:b786:: with SMTP id s6mr3671207wre.287.1589442172038;
        Thu, 14 May 2020 00:42:52 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id q74sm33043455wme.14.2020.05.14.00.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 00:42:51 -0700 (PDT)
Date:   Thu, 14 May 2020 09:42:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        cgroups@vger.kernel.org, shakeelb@google.com
Subject: Re: [PATCH mm v2 3/3] mm: automatically penalize tasks with high
 swap use
Message-ID: <20200514074246.GZ29153@dhcp22.suse.cz>
References: <20200511225516.2431921-1-kuba@kernel.org>
 <20200511225516.2431921-4-kuba@kernel.org>
 <20200512072634.GP29153@dhcp22.suse.cz>
 <20200512105536.748da94e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200513083249.GS29153@dhcp22.suse.cz>
 <20200513113623.0659e4c4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513113623.0659e4c4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 13-05-20 11:36:23, Jakub Kicinski wrote:
> On Wed, 13 May 2020 10:32:49 +0200 Michal Hocko wrote:
> > On Tue 12-05-20 10:55:36, Jakub Kicinski wrote:
> > > On Tue, 12 May 2020 09:26:34 +0200 Michal Hocko wrote:  
> > > > On Mon 11-05-20 15:55:16, Jakub Kicinski wrote:  
> > > > > Use swap.high when deciding if swap is full.    
> > > > 
> > > > Please be more specific why.  
> > > 
> > > How about:
> > > 
> > >     Use swap.high when deciding if swap is full to influence ongoing
> > >     swap reclaim in a best effort manner.  
> > 
> > This is still way too vague. The crux is why should we treat hard and
> > high swap limit the same for mem_cgroup_swap_full purpose. Please
> > note that I am not saying this is wrong. I am asking for a more
> > detailed explanation mostly because I would bet that somebody
> > stumbles over this sooner or later.
> 
> Stumbles in what way?

Reading the code and trying to understand why this particular decision
has been made. Because it might be surprising that the hard and high
limits are treated same here.

> Isn't it expected for the kernel to take reasonable precautions to
> avoid hitting limits?

Isn't the throttling itself the precautious? How does the swap cache
and its control via mem_cgroup_swap_full interact here. See? This is
what I am asking to have explained in the changelog.

[...]
> > > > I would also suggest to explain or ideally even separate the swap
> > > > penalty scaling logic to a seprate patch. What kind of data it is
> > > > based on?  
> > > 
> > > It's a hard thing to get production data for since, as we mentioned
> > > we don't expect the limit to be hit. It was more of a process of
> > > experimentation and finding a gradual slope that "felt right"...
> > > 
> > > Is there a more scientific process we can follow here? We want the
> > > delay to be small at first for a first few pages and then grow to
> > > make sure we stop the task from going too much over high. The square
> > > function works pretty well IMHO.  
> > 
> > If there is no data to showing this to be an improvement then I would
> > just not add an additional scaling factor. Why? Mostly because once we
> > have it there it would be extremely hard to change. MM is full of
> > these little heuristics that are copied over because nobody dares to
> > touch them. If a different scaling is really needed it can always be
> > added later with some data to back that.
> 
> Oh, I misunderstood the question, you were asking about the scaling
> factor.. The allocation of swap is in larger batches, according to 
> my tests, example below (AR - after reclaim, swap overage changes 
> after memory reclaim). 
>                                     mem overage AR
>      swap pages over_high AR        |    swap overage AR
>  swap pages over at call.   \       |    |      . mem sleep
>    mem pages over_high.  \   \      |    |     /  . swap sleep
>                        v  v   v     v    v    v  v
>  [   73.360533] sleep (32/10->67) [-35|13379] 0+253
>  [   73.631291] sleep (32/ 3->54) [-18|13430] 0+205
>  [   73.851629] sleep (32/22->35) [-20|13443] 0+133
>  [   74.021396] sleep (32/ 3->60) [-29|13500] 0+230
>  [   74.263355] sleep (32/28->79) [-44|13551] 0+306
>  [   74.585689] sleep (32/29->91) [-17|13627] 0+355
>  [   74.958675] sleep (32/27->79) [-31|13679] 0+311
>  [   75.293021] sleep (32/29->86) [ -9|13750] 0+344
>  [   75.654218] sleep (32/22->72) [-24|13800] 0+290
>  [   75.962467] sleep (32/22->73) [-39|13865] 0+296
> 
> That's for a process slowly leaking memory. Swap gets over the high by
> about 2.5x MEMCG_CHARGE_BATCH on average. Hence to keep the same slope
> I was trying to scale it back.
> 
> But you make a fair point, someone more knowledgeable can add the
> heuristic later if it's really needed.

Or just make it a separate patch with all that information. This would
allow anybody touching that code in the future to understand the initial
motivation.

I am still not sure this scaling is a good fit in general (e.g. how does
it work with THP swapping?) though but this can be discussed separately
at least.

-- 
Michal Hocko
SUSE Labs
