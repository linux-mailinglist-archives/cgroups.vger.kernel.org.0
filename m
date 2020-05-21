Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84AD1DCEC9
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 15:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgEUN6n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 09:58:43 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46745 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgEUN6n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 09:58:43 -0400
Received: by mail-ej1-f67.google.com with SMTP id e2so8868439eje.13;
        Thu, 21 May 2020 06:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ddLwWOZufRU83kRzWZ3D0JojQ9PBPAMnKhIGdw1eqxU=;
        b=WbOXbFCSWjft7Ng2ADu2WKBfjERG2CTA2/jRwV6A9zNf1awDiMrYI/S1Oug27a7/bj
         /7J0Q+mFp3zjpZzoESJDZDY6MJTAqNI/fjlLl8fwHsb+izk42rGysQBqskhlF83KQPbd
         khDp9Tnei59SJxQ+qE93pupcWqdgCQWcSHVbSs0Ao8GnTyGE6evGa77V2WuxzWa1GN0Z
         CIGybn05+6aRQhXGRdIhJB04AF6x0kGpIDqbLsKsxMBv1uHL8b2lnvDEd/RqGDLNVnsw
         juYYzo7W1u8GQjYnDiorrIGRLB7TpEsKsaojW8B9+QtcT8oKyjxRNlnYU9vucelbgK/l
         tmWw==
X-Gm-Message-State: AOAM533YmapjcbEp0GRJj5h5/Hu56Kmuma8P2EWqWgm1VEj9+ZOVNODa
        Fg01e8ZcGktHl1cr/jrWTkdSDyHh
X-Google-Smtp-Source: ABdhPJzPRBFDa0mlq1OwZfH77wBLvsLKgpZD9t/9lF1bGNYWZapDHrzDtDAUg1eAZDj0WFY3c0IPrg==
X-Received: by 2002:a17:906:6951:: with SMTP id c17mr3607034ejs.112.1590069521064;
        Thu, 21 May 2020 06:58:41 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id c7sm4755917edj.54.2020.05.21.06.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 06:58:40 -0700 (PDT)
Date:   Thu, 21 May 2020 15:58:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521135838.GT6462@dhcp22.suse.cz>
References: <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
 <20200521120455.GM6462@dhcp22.suse.cz>
 <20200521122327.GB990580@chrisdown.name>
 <20200521123742.GO6462@dhcp22.suse.cz>
 <20200521125759.GD990580@chrisdown.name>
 <20200521132120.GR6462@dhcp22.suse.cz>
 <20200521133324.GF990580@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521133324.GF990580@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-05-20 14:41:47, Chris Down wrote:
> Michal Hocko writes:
> > On Thu 21-05-20 13:57:59, Chris Down wrote:
[...]
> > > If you're talking about reclaim, trying to reason about whether the overage
> > > is the result of some other task in this cgroup or the task that's
> > > allocating right now is something that we already know doesn't work well
> > > (eg. global OOM).
> > 
> > I am not sure I follow you here.
> 
> Let me rephrase: your statement is that it's not desirable "that some task
> would be throttled unexpectedly too long because of [the activity of another
> task also within that cgroup]" (let me know if that's not what you meant).
> But trying to avoid that requires knowing which activity abstractly
> instigates this entire mess in the first place, which we have nowhere near
> enough context to determine.

Yeah, if we want to be really precise then you are right, nothing like
that is really feasible for the reclaim. Reclaiming 1 page might be much
more expensive than 100 pages because LRU order doesn't reflect the
cost of the reclaim at all. What, I believe, we want is a best effort,
really. If the reclaim target is somehow bound to the requested amount
of memory then we can at least say that more memory hungry consumers are
reclaiming more. Which is something people can wrap their head around
much easier than a free competition on the reclaim with some hard to
predict losers who do all the work and some lucky ones which just happen
to avoid throttling by a better timing. Really think of the direct
reclaim and how the unfairness suck there.

-- 
Michal Hocko
SUSE Labs
