Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121F51DC779
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 09:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEUHTe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 03:19:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46254 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgEUHTd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 03:19:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id f13so5318869edr.13;
        Thu, 21 May 2020 00:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dn0yp+M8pDTS/BMQHfDmlIcD8nK1n9G9HT0uq2RMC+I=;
        b=iXJqWoxPnsj2ZphK+y4Ls6m/A7NMEQYnNwl9512CuR/JrH8SesnKMk1DB1qpaVOFwe
         z8vuND5NNtsuA8zZCsQ1RieSp4cnygCn2KuGAe3BFLCAbSBLR8tiMRU/QAxMS/Oot6Q4
         kPtDr8VpEev2jwHldPa7Of4sLpeIFdJWVMeUHexJ24csK3/NIwBzlM+yYpw/WPWAd63E
         ov0IShcGIWWWvLdLXmaX7Tw/oaSsX2HRPM2AconUiGo2CxHQMDmMfIy7xndzb0nv//b+
         zSwgLiTom/mIPVXTO+iLCKMezCtumRRN+bMWnqi3gSGTpJA3oyCX18eOExKIp0OXBkjo
         NX9Q==
X-Gm-Message-State: AOAM533HYOurfSCqILGLNZtxnMPL8PcM4kHKL0qILF54XcyIdoVzGEyf
        dImh3XbAt3QKrkvem1nkM78=
X-Google-Smtp-Source: ABdhPJyWCoyi6jQRuJ/5H5jy56KynMgozJYzWwRIK2sM6SOw6/OHWD4BJMo9eRmUsz/NSr84X4T00g==
X-Received: by 2002:a50:8b42:: with SMTP id l60mr6576276edl.55.1590045571294;
        Thu, 21 May 2020 00:19:31 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id w4sm3932025edx.66.2020.05.21.00.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 00:19:30 -0700 (PDT)
Date:   Thu, 21 May 2020 09:19:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521071929.GH6462@dhcp22.suse.cz>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520202650.GB558281@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 20-05-20 21:26:50, Chris Down wrote:
> Michal Hocko writes:
> > Let me try to understand the actual problem. The high memory reclaim has
> > a target which is proportional to the amount of charged memory. For most
> > requests that would be SWAP_CLUSTER_MAX though (resp. N times that where
> > N is the number of memcgs in excess up the hierarchy). I can see to be
> > insufficient if the memcg is already in a large excess but if the
> > reclaim can make a forward progress this should just work fine because
> > each charging context should reclaim at least the contributed amount.
> > 
> > Do you have any insight on why this doesn't work in your situation?
> > Especially with such a large inactive file list I would be really
> > surprised if the reclaim was not able to make a forward progress.
> 
> Reclaim can fail for any number of reasons, which is why we have retries
> sprinkled all over for it already. It doesn't seem hard to believe that it
> might just fail for transient reasons and drive us deeper into the hole as a
> result.

Reclaim can certainly fail. It is however surprising to see it fail with
such a large inactive lru list and reasonably small reclaim target.
Having the full LRU of dirty pages sounds a bit unusual, IO throttling
for v2 and explicit throttling during the reclaim for v1 should prevent
from that. If the reclaim gives up too easily then this should be
addressed at the reclaim level.

> In this case, a.) the application is producing tons of dirty pages, and b.)
> we have really heavy systemwide I/O contention on the affected machines.
> This high load is one of the reasons that direct and kswapd reclaim cannot
> keep up, and thus nr_pages can become a number of orders of magnitude larger
> than SWAP_CLUSTER_MAX. This is trivially reproducible on these machines,
> it's not an edge case.

Please elaborate some more. memcg_nr_pages_over_high shouldn't really
depend on the system wide activity. It should scale with the requested
charges. So yes it can get large for something like a large read/write
which does a lot of allocations in a single syscall before returning to
the userspace.
 
But ok, let's say that the reclaim target is large and then a single
reclaim attempt might fail. Then I am wondering why your patch is not
really targetting to reclaim memcg_nr_pages_over_high pages and instead
push for reclaim down to the high limit.

The main problem I see with that approach is that the loop could easily
lead to reclaim unfairness when a heavy producer which doesn't leave the
kernel (e.g. a large read/write call) can keep a different task doing
all the reclaim work. The loop is effectivelly unbound when there is a
reclaim progress and so the return to the userspace is by no means
proportional to the requested memory/charge.
-- 
Michal Hocko
SUSE Labs
