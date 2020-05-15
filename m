Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3110E1D46DD
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgEOHPC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 03:15:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52909 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgEOHPC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 03:15:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id z4so29871wmi.2
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 00:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wNnbDR/fnRC/T2e1j8iCp/maHR2CWtyzsflthlgO73c=;
        b=LmDAX+wVi3FiqJtsqLC72IhA/Eua6yuXz2A0np1GvhFp1g++dmtcY1N7eIaml4ahln
         9neWvng0thfDwGBlCqVeotq/Zz+LkWbaVIic7VmJ15eOV1Rrt60gp20YURWRbK6it7h1
         OcXBPzetx4IMasXzLlfp0B5xf6DYzru6lBEKobdM0E2E5+l40UwY6wqFGfMKg6ZWBYC9
         8wUad/01D/pCFw/7lFft5YaP9pjFjqsWYz3Yu8daax5KJW8LUN4Ew5gueDshEv35UwVB
         qJLH8t7tOFr3Lgq187gnw3DGhsnnV4+PTb2wVMls4Q7d1A1Im6Co0rUo3jsPQskofv/D
         JAjw==
X-Gm-Message-State: AOAM533of+HJGGprBq25LnqBxx33oyANGx4BBki0l2HAhzaFMACxI8/o
        tKPXUZi4KO9PL/FXalsWCtM=
X-Google-Smtp-Source: ABdhPJxOi6ZJ3DWHzJFEGKoPBDChDxIBiY+1Z+h895njnpdO+If8ji/zOjDRRm9zZ69E0ZSe2MWGGA==
X-Received: by 2002:a05:600c:14c6:: with SMTP id i6mr2407088wmh.58.1589526900148;
        Fri, 15 May 2020 00:15:00 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id t7sm2204827wrq.39.2020.05.15.00.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 00:14:59 -0700 (PDT)
Date:   Fri, 15 May 2020 09:14:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        chris@chrisdown.name, cgroups@vger.kernel.org, shakeelb@google.com
Subject: Re: [PATCH mm v2 3/3] mm: automatically penalize tasks with high
 swap use
Message-ID: <20200515071458.GE29153@dhcp22.suse.cz>
References: <20200511225516.2431921-1-kuba@kernel.org>
 <20200511225516.2431921-4-kuba@kernel.org>
 <20200512072634.GP29153@dhcp22.suse.cz>
 <20200512105536.748da94e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200513083249.GS29153@dhcp22.suse.cz>
 <20200513113623.0659e4c4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200514074246.GZ29153@dhcp22.suse.cz>
 <20200514202130.GA591266@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514202130.GA591266@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 14-05-20 16:21:30, Johannes Weiner wrote:
> On Thu, May 14, 2020 at 09:42:46AM +0200, Michal Hocko wrote:
> > On Wed 13-05-20 11:36:23, Jakub Kicinski wrote:
> > > On Wed, 13 May 2020 10:32:49 +0200 Michal Hocko wrote:
> > > > On Tue 12-05-20 10:55:36, Jakub Kicinski wrote:
> > > > > On Tue, 12 May 2020 09:26:34 +0200 Michal Hocko wrote:  
> > > > > > On Mon 11-05-20 15:55:16, Jakub Kicinski wrote:  
> > > > > > > Use swap.high when deciding if swap is full.    
> > > > > > 
> > > > > > Please be more specific why.  
> > > > > 
> > > > > How about:
> > > > > 
> > > > >     Use swap.high when deciding if swap is full to influence ongoing
> > > > >     swap reclaim in a best effort manner.  
> > > > 
> > > > This is still way too vague. The crux is why should we treat hard and
> > > > high swap limit the same for mem_cgroup_swap_full purpose. Please
> > > > note that I am not saying this is wrong. I am asking for a more
> > > > detailed explanation mostly because I would bet that somebody
> > > > stumbles over this sooner or later.
> > > 
> > > Stumbles in what way?
> > 
> > Reading the code and trying to understand why this particular decision
> > has been made. Because it might be surprising that the hard and high
> > limits are treated same here.
> 
> I don't quite understand the controversy.

I do not think there is any controversy. All I am asking for is a
clarification because this is non-intuitive.
 
> The idea behind "swap full" is that as long as the workload has plenty
> of swap space available and it's not changing its memory contents, it
> makes sense to generously hold on to copies of data in the swap
> device, even after the swapin. A later reclaim cycle can drop the page
> without any IO. Trading disk space for IO.
> 
> But the only two ways to reclaim a swap slot is when they're faulted
> in and the references go away, or by scanning the virtual address space
> like swapoff does - which is very expensive (one could argue it's too
> expensive even for swapoff, it's often more practical to just reboot).
> 
> So at some point in the fill level, we have to start freeing up swap
> slots on fault/swapin. Otherwise we could eventually run out of swap
> slots while they're filled with copies of data that is also in RAM.
> 
> We don't want to OOM a workload because its available swap space is
> filled with redundant cache.

Thanks this is a useful summary.
 
> That applies to physical swap limits, swap.max, and naturally also to
> swap.high which is a limit to implement userspace OOM for swap space
> exhaustion.
> 
> > > Isn't it expected for the kernel to take reasonable precautions to
> > > avoid hitting limits?
> > 
> > Isn't the throttling itself the precautious? How does the swap cache
> > and its control via mem_cgroup_swap_full interact here. See? This is
> > what I am asking to have explained in the changelog.
> 
> It sounds like we need better documentation of what vm_swap_full() and
> friends are there for. It should have been obvious why swap.high - a
> limit on available swap space - hooks into it.

Agreed. The primary source for a confusion is the naming here. Because
vm_swap_full doesn't really try to tell that the swap is full. It merely
tries to tell that it is getting full and so duplicated data should be
dropped.

-- 
Michal Hocko
SUSE Labs
