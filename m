Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7C1DCC91
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 14:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgEUMFA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 08:05:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41730 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgEUMFA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 08:05:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id g9so6481243edr.8;
        Thu, 21 May 2020 05:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SwZpALLAQeyKdCeabWUvdFsJgTC5XhIBMoJbc1saxP8=;
        b=gPInm6fHMz9LqHYXBXkaBSM3grWGP2GnpJHlVBK3CnXkn00vELC9wWvY6XavdRcmC4
         gwRIYSEbb+jH81Yb8MNUQDEienLBEnRmfqXQH3K4xuj2vznEcr8fMQSqPvzpWR9h+3dw
         FX29hcjGNRlNbzQT8LY5mpAowXjwkyKKxq5YTzwaOj47RiGS8KVpSYNwLWB9HR3hWQsj
         26hV7gQAFlArdZOE1nzladOI/1LGgdlR124N3ORPwTgyXig5Q0mcOQMtP2UpUgo07SFw
         7XtcBMLwHeEuKzmWUJqS7VsTKhVBXObD1IWn4pLM7UKhOqVSmNskLNFI8IM/YgIMywix
         6eag==
X-Gm-Message-State: AOAM531TX0SMZQ1Y9FBxTpTLvAMH6yGAfIdttGq12/bzU6MYRzwZZBxL
        fu2ksIvnsOsXhmKZLlVhcq4=
X-Google-Smtp-Source: ABdhPJxcJU3YYlU6FupEZNcOtfXj4LB04jwem+8NjPjBlLO3RJdPWnW3l+WShSuHCKKHdCiixcsfrg==
X-Received: by 2002:a50:f40d:: with SMTP id r13mr7180291edm.93.1590062697963;
        Thu, 21 May 2020 05:04:57 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id o21sm4645166ejb.31.2020.05.21.05.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 05:04:56 -0700 (PDT)
Date:   Thu, 21 May 2020 14:04:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521120455.GM6462@dhcp22.suse.cz>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521112711.GA990580@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-05-20 12:27:11, Chris Down wrote:
> Michal Hocko writes:
> > On Wed 20-05-20 21:26:50, Chris Down wrote:
> > > Michal Hocko writes:
> > > > Let me try to understand the actual problem. The high memory reclaim has
> > > > a target which is proportional to the amount of charged memory. For most
> > > > requests that would be SWAP_CLUSTER_MAX though (resp. N times that where
> > > > N is the number of memcgs in excess up the hierarchy). I can see to be
> > > > insufficient if the memcg is already in a large excess but if the
> > > > reclaim can make a forward progress this should just work fine because
> > > > each charging context should reclaim at least the contributed amount.
> > > >
> > > > Do you have any insight on why this doesn't work in your situation?
> > > > Especially with such a large inactive file list I would be really
> > > > surprised if the reclaim was not able to make a forward progress.
> > > 
> > > Reclaim can fail for any number of reasons, which is why we have retries
> > > sprinkled all over for it already. It doesn't seem hard to believe that it
> > > might just fail for transient reasons and drive us deeper into the hole as a
> > > result.
> > 
> > Reclaim can certainly fail. It is however surprising to see it fail with
> > such a large inactive lru list and reasonably small reclaim target.
> 
> Why do you think the reclaim target is small? In the case of generating tons
> of dirty pages, current->memcg_nr_pages_over_high can grow to be huge (on
> the order of several tens of megabytes or more).

Because from my experience there are not tons of charges inside one
syscall usually. Yeah, some syscalls can generate a lot of them but that
shouldn't be a majority.

> > Having the full LRU of dirty pages sounds a bit unusual, IO throttling
> > for v2 and explicit throttling during the reclaim for v1 should prevent
> > from that. If the reclaim gives up too easily then this should be
> > addressed at the reclaim level.
> 
> I'm not sure I agree. Reclaim knows what you asked it to do: reclaim N
> pages, but what to do about the situation when it fails to satisfy that is a
> job for the caller. In this case, we are willing to even tolerate a little
> bit of overage up to the 10ms throttle threshold. In other cases, we want to
> do other checks first before retrying, because the tradeoffs are different.
> Putting all of this inside the reclaim logic seems unwieldy.

That is not what I meant. We do have some throttling inside the reclaim
because failing reclaim too quickly can easily lead to pre mature OOMs.
If that doesn't work then we should have a look why. E.g. it is quite
unexpected to have large LRU full of dirty pages because this suggests
that dirty throttling doesn't work properly.

> > The main problem I see with that approach is that the loop could easily
> > lead to reclaim unfairness when a heavy producer which doesn't leave the
> > kernel (e.g. a large read/write call) can keep a different task doing
> > all the reclaim work. The loop is effectivelly unbound when there is a
> > reclaim progress and so the return to the userspace is by no means
> > proportional to the requested memory/charge.
> 
> It's not unbound when there is reclaim progress, it stops when we are within
> the memory.high throttling grace period. Right after reclaim, we check if
> penalty_jiffies is less than 10ms, and abort and further reclaim or
> allocator throttling:

Just imagine that you have parallel producers increasing the high limit
excess while somebody reclaims those. Sure in practice the loop will be
bounded but the reclaimer might perform much more work on behalf of
other tasks.
-- 
Michal Hocko
SUSE Labs
