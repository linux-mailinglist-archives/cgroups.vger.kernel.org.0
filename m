Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E451DCDE9
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgEUN2b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 09:28:31 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:42390 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgEUN2b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 09:28:31 -0400
Received: by mail-ej1-f66.google.com with SMTP id se13so8779301ejb.9;
        Thu, 21 May 2020 06:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jDCx2WxHF0tPV5ThYACQPXq1Ci/r8leV3iJmKPX73kw=;
        b=SprgTdyD8iQhXQ3t5vz3uVBkgY+9rSrtj3tRHoRH6rO78ryFHcqwyBlKubtihaYoBt
         UDqC+TTUw2VeHzY7LZp5OMfc8Q4FHy/xQhlIFbzX/X3KMxF2NrLswMCbOv9J+1ZiC5sq
         paEpxBBgX/hMcWpo98nte0MMzhxuMDgcwtS0z8vWVpAv+jAAW8CVqeEq8D9cNEj08zVE
         c2Zrn50A3Azip+9Z/WsaCPkrDuhW0KAkpy0U+zwB8SeJ1BLUcVyzSVw/6IgFLX1bWhAz
         hoR3liXgcldSH3kcVGFNMNm7/6+xL0rAsz0P4WgbfW/xNDMdLvH1U61YDVC1M4WOev7Y
         DZCg==
X-Gm-Message-State: AOAM531LWvLggeR9vapimZH4u3WCwXKWQ90EBUFC4+jZxpBMYILh/D2Y
        vXZ+HU8bRWbbwTLXY0f7aIk=
X-Google-Smtp-Source: ABdhPJxcg8Jgr6GoENH6kS+Ld5vOWysHqjKl+LyRLD/wTM/EcTsTUQWzPImWfcXO0JDudNQbEEsQ/Q==
X-Received: by 2002:a17:906:278e:: with SMTP id j14mr3487532ejc.270.1590067709162;
        Thu, 21 May 2020 06:28:29 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id bi7sm4745696edb.17.2020.05.21.06.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 06:28:27 -0700 (PDT)
Date:   Thu, 21 May 2020 15:28:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521132826.GS6462@dhcp22.suse.cz>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
 <20200521120455.GM6462@dhcp22.suse.cz>
 <20200521122327.GB990580@chrisdown.name>
 <20200521123742.GO6462@dhcp22.suse.cz>
 <20200521125759.GD990580@chrisdown.name>
 <20200521130530.GE990580@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521130530.GE990580@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-05-20 14:05:30, Chris Down wrote:
> Chris Down writes:
> > > I believe I have asked in other email in this thread. Could you explain
> > > why enforcint the requested target (memcg_nr_pages_over_high) is
> > > insufficient for the problem you are dealing with? Because that would
> > > make sense for large targets to me while it would keep relatively
> > > reasonable semantic of the throttling - aka proportional to the memory
> > > demand rather than the excess.
> > 
> > memcg_nr_pages_over_high is related to the charge size. As such, if
> > you're way over memory.high as a result of transient reclaim failures,
> > but the majority of your charges are small, it's going to hard to make
> > meaningful progress:
> > 
> > 1. Most nr_pages will be MEMCG_CHARGE_BATCH, which is not enough to help;
> > 2. Large allocations will only get a single reclaim attempt to succeed.
> > 
> > As such, in many cases we're either doomed to successfully reclaim a
> > paltry amount of pages, or fail to reclaim a lot of pages. Asking
> > try_to_free_pages() to deal with those huge allocations is generally not
> > reasonable, regardless of the specifics of why it doesn't work in this
> > case.
> 
> Oh, I somehow elided the "enforcing" part of your proposal. Still, there's
> no guarantee even if large allocations are reclaimed fully that we will end
> up going back below memory.high, because even a single other large
> allocation which fails to reclaim can knock us out of whack again.

Yeah, there is no guarantee and that is fine. Because memory.high is not
about guarantee. It is about a best effort and slowing down the
allocation pace so that the userspace has time to do something about
that.

That being said I would be really curious about how enforcing the
memcg_nr_pages_over_high target works in your setups where you see the
problem. If that doesn't work for some reason and the reclaim should be
more pro-active then I would suggest to scale it via memcg_nr_pages_over_high
rather than essentially keep it around and ignore it. Preserving at
least some form of fairness and predictable behavior is important IMHO
but if there is no way to achieve that then there should be a very good
explanation for that.

I hope that we it is more clear what is our thinking now. I will be FTO
for upcoming days trying to get some rest from email so my response time
will be longer. Will be back on Thursday.
-- 
Michal Hocko
SUSE Labs
