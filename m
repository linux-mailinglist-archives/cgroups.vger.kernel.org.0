Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431821B48FA
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 17:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgDVPnZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 11:43:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56068 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgDVPnX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 11:43:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id e26so2894560wmk.5
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 08:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1oRxBMnlbBMPhg1L3MrHQ8H+9dmimSCtvmaiZgbijlY=;
        b=q1M3wScYJv8OYdqXs1+9NdcIdW04umVyOJ7YU8/mSrObu5bl6rY6jL9/Y/9fKh7jYu
         BI4s3CmzhCHhTJjPRJ6OtONPPROcZf6UCl2u5/zRSV9diowoOlmZFjUiGObK3eaiLkZn
         rW+C31HL/jlefokc+m+RhpHyvyaGbJlFgjjZaKFmT7pFklvmh/nIMGHJPqDizFvgTuxa
         J5rBbdJtSCRvu/udx/zhTgk1v06yJpk9ebH33d5DKO45v5eBlOE/Bngkx2Dr8VsXmY3R
         26BlzieXRfK2BQnn1RN0YOhaFAuezcG7HshxgZL59yFy3q16YLMsRlsc+F3LIS+KbHGp
         JsgQ==
X-Gm-Message-State: AGi0PuZind35ZVo4EGf3mx7eJut/NRHOCajaosv7oKYAGlMt41c1utU/
        qY7S0YUaWOpu2WvponhzzXI=
X-Google-Smtp-Source: APiQypLD5BLDakIwmSbPvkTKgrzmnmj6tvj/nRSOQHRq7MmLkYK7jQGjhOv9Lrx0tPKRsL9l1Kbq/g==
X-Received: by 2002:a1c:c30a:: with SMTP id t10mr10589958wmf.80.1587570200281;
        Wed, 22 Apr 2020 08:43:20 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id s18sm9424846wra.94.2020.04.22.08.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 08:43:19 -0700 (PDT)
Date:   Wed, 22 Apr 2020 17:43:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
Message-ID: <20200422154318.GK30312@dhcp22.suse.cz>
References: <CALvZod6M4OsM-t8m_KX9wCkEutdwUMgbP9682eHGQor9JvO_BQ@mail.gmail.com>
 <20200420164740.GF43469@mtj.thefacebook.com>
 <20200420170318.GV27314@dhcp22.suse.cz>
 <20200420170650.GA169746@mtj.thefacebook.com>
 <20200421110612.GD27314@dhcp22.suse.cz>
 <20200421142746.GA341682@cmpxchg.org>
 <20200421161138.GL27314@dhcp22.suse.cz>
 <20200421165601.GA345998@cmpxchg.org>
 <20200422132632.GG30312@dhcp22.suse.cz>
 <20200422141514.GA362484@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422141514.GA362484@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 22-04-20 10:15:14, Johannes Weiner wrote:
> On Wed, Apr 22, 2020 at 03:26:32PM +0200, Michal Hocko wrote:
> > That being said I believe our discussion is missing an important part.
> > There is no description of the swap.high semantic. What can user expect
> > when using it?
> 
> Good point, we should include that in cgroup-v2.rst. How about this?
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index bcc80269bb6a..49e8733a9d8a 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1370,6 +1370,17 @@ PAGE_SIZE multiple when read back.
>  	The total amount of swap currently being used by the cgroup
>  	and its descendants.
>  
> +  memory.swap.high
> +	A read-write single value file which exists on non-root
> +	cgroups.  The default is "max".
> +
> +	Swap usage throttle limit.  If a cgroup's swap usage exceeds
> +	this limit, allocations inside the cgroup will be throttled.

Hm, so this doesn't talk about which allocatios are affected. This is
good for potential future changes but I am not sure this is useful to
make any educated guess about the actual effects. One could expect that
only those allocations which could contribute to future memory.swap
usage. I fully realize that we do not want to be very specific but we
want to provide something useful I believe. I am sorry but I do not have
a good suggestion on how to make this better. Mostly because I still
struggle on how this should behave to be sane.

I am also missing some information about what the user can actually do
about this situation and call out explicitly that the throttling is
not going away until the swap usage is shrunk and the kernel is not
capable of doing that on its own without a help from the userspace. This
is really different from memory.high which has means to deal with the
excess and shrink it down in most cases. The following would clarify it
for me
	"Once the limit is exceeded it is expected that the userspace
	 is going to act and either free up the swapped out space
	 or tune the limit based on needs. The kernel itself is not
	 able to do that on its own.
	"

> +
> +	This slows down expansion of the group's memory footprint as
> +	it runs out of assigned swap space. Compare to memory.swap.max,
> +	which stops swapping abruptly and can provoke kernel OOM kills.
> +
>    memory.swap.max
>  	A read-write single value file which exists on non-root
>  	cgroups.  The default is "max".

-- 
Michal Hocko
SUSE Labs
