Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41341D3EEC
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2020 22:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgENUVx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 May 2020 16:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725975AbgENUVx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 May 2020 16:21:53 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E936C061A0C
        for <cgroups@vger.kernel.org>; Thu, 14 May 2020 13:21:52 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id a136so242532qkg.6
        for <cgroups@vger.kernel.org>; Thu, 14 May 2020 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1meGT6deW+cm9r8U3rKE8gfgbUmpVzugGQGtQegwdek=;
        b=aKK0TMX0pk/9RwZizRVuCVDWyUUYYIdGUZsQ3V3UYrJ8W8B6lNV5sx2CubAcVsG8hc
         Rl1vSghEPrTJDWEjzRewOEZ64O38ezkj0i8OOdIkSLHJKm4G8y4aPtMAgimCBKmJrdba
         OdnwfJAENAkztepkCyRUKYWzsC7RivQaER7BnzHaQX9VRr9yF4gosz/2dYsOy9cUyVGG
         rGEXF/YJWG1AQcp0T8qDPxP2f+bS7ynZ5cTEsjnl59JjI3iTBGIExouBn/YBp6aQPzcy
         XSTTGUGO60bHVhouy90AULrVPXM1Kz4bfF2F9j04uQH3dGasqaTkzhhtpe/QuOpyyA6G
         oiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1meGT6deW+cm9r8U3rKE8gfgbUmpVzugGQGtQegwdek=;
        b=hW4tvNpXoRB+jhQfK29mssPbXw3pSZR+uOuF7f2O/it+JEA8t6zpTPcVP7avfdl8i6
         /fjZwrU/yERV+okRheFWkR7nA5iLAgvohG/SDfiohievf3EAKTbfwYeBOv8LNeKkiwsd
         PUt+6law7kAPOlbThQzmGt07kkXhvKDnbIreWqOvPTMOmHo5zXfk3SC53KpDliR/LPLO
         KfUoVlQVMvI9buUsF+0fBL9/lpSkVyyk9zLh3RuKc+caDp66r3oRFM2wyGLKOmdmWHfx
         JXzG22QlhAJOYceZa8nmG8+gJ93Hsj4jsYF7kaHXa0rojJy58xvk2udpK0ZrVfzqNlAT
         Ek8g==
X-Gm-Message-State: AOAM530j85qCq0gIe48PezA9uzjH7o8SMKEbRtzzFMJ9kvyBa22fw6S/
        SMtoVDzjC//fCTEwrthDMATFzHgQjqQ=
X-Google-Smtp-Source: ABdhPJzaFYb27bl/M3yoVbFr1TCUkNx6D0KkFYvK+5552SlWk8CCZ+kLIIyCkcMytjVKZIiOOol7VA==
X-Received: by 2002:a05:620a:1326:: with SMTP id p6mr98877qkj.373.1589487711123;
        Thu, 14 May 2020 13:21:51 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id t21sm181498qtb.0.2020.05.14.13.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:21:50 -0700 (PDT)
Date:   Thu, 14 May 2020 16:21:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        chris@chrisdown.name, cgroups@vger.kernel.org, shakeelb@google.com
Subject: Re: [PATCH mm v2 3/3] mm: automatically penalize tasks with high
 swap use
Message-ID: <20200514202130.GA591266@cmpxchg.org>
References: <20200511225516.2431921-1-kuba@kernel.org>
 <20200511225516.2431921-4-kuba@kernel.org>
 <20200512072634.GP29153@dhcp22.suse.cz>
 <20200512105536.748da94e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200513083249.GS29153@dhcp22.suse.cz>
 <20200513113623.0659e4c4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200514074246.GZ29153@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514074246.GZ29153@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 14, 2020 at 09:42:46AM +0200, Michal Hocko wrote:
> On Wed 13-05-20 11:36:23, Jakub Kicinski wrote:
> > On Wed, 13 May 2020 10:32:49 +0200 Michal Hocko wrote:
> > > On Tue 12-05-20 10:55:36, Jakub Kicinski wrote:
> > > > On Tue, 12 May 2020 09:26:34 +0200 Michal Hocko wrote:  
> > > > > On Mon 11-05-20 15:55:16, Jakub Kicinski wrote:  
> > > > > > Use swap.high when deciding if swap is full.    
> > > > > 
> > > > > Please be more specific why.  
> > > > 
> > > > How about:
> > > > 
> > > >     Use swap.high when deciding if swap is full to influence ongoing
> > > >     swap reclaim in a best effort manner.  
> > > 
> > > This is still way too vague. The crux is why should we treat hard and
> > > high swap limit the same for mem_cgroup_swap_full purpose. Please
> > > note that I am not saying this is wrong. I am asking for a more
> > > detailed explanation mostly because I would bet that somebody
> > > stumbles over this sooner or later.
> > 
> > Stumbles in what way?
> 
> Reading the code and trying to understand why this particular decision
> has been made. Because it might be surprising that the hard and high
> limits are treated same here.

I don't quite understand the controversy.

The idea behind "swap full" is that as long as the workload has plenty
of swap space available and it's not changing its memory contents, it
makes sense to generously hold on to copies of data in the swap
device, even after the swapin. A later reclaim cycle can drop the page
without any IO. Trading disk space for IO.

But the only two ways to reclaim a swap slot is when they're faulted
in and the references go away, or by scanning the virtual address space
like swapoff does - which is very expensive (one could argue it's too
expensive even for swapoff, it's often more practical to just reboot).

So at some point in the fill level, we have to start freeing up swap
slots on fault/swapin. Otherwise we could eventually run out of swap
slots while they're filled with copies of data that is also in RAM.

We don't want to OOM a workload because its available swap space is
filled with redundant cache.

That applies to physical swap limits, swap.max, and naturally also to
swap.high which is a limit to implement userspace OOM for swap space
exhaustion.

> > Isn't it expected for the kernel to take reasonable precautions to
> > avoid hitting limits?
> 
> Isn't the throttling itself the precautious? How does the swap cache
> and its control via mem_cgroup_swap_full interact here. See? This is
> what I am asking to have explained in the changelog.

It sounds like we need better documentation of what vm_swap_full() and
friends are there for. It should have been obvious why swap.high - a
limit on available swap space - hooks into it.
