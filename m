Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B688216C0A7
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2020 13:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgBYMUe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Feb 2020 07:20:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36161 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgBYMUd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Feb 2020 07:20:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so2951965wma.1;
        Tue, 25 Feb 2020 04:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=amk92U3UcxsrHm6N5J0I6q5dsvT99hQzwkL/foqerQs=;
        b=qxh08AFadHE03NTG18Kz0drwFdL/rGmbkwOtVUJioU+uCT/I7+PAiFyQRhayLscUCp
         0UWVA+Fn2KpeLCb6b5NEGm6jxXAQkbL042gGt3wC1jxQsLD667jEjQ9/JbcVo8vpzTXE
         4HtVkss6TOWxZ7F7dgdN1qxGfDOzC2LVhqEeReGZ68ty4gQHK+iz1OGHhH8DbKrmx+Hw
         DMyahZ92OInsXKHMT+QgMKNrREzN3ovAodOmgn+GJF41iS0VsDPtuEEIAzMvyonz3a/o
         6dtjs9dwszom9i9YlgS0ZBoAgUVhsSMZYqVVZ8pbg51AzdHdpVPChB2cera6N1oACTHi
         A/4w==
X-Gm-Message-State: APjAAAU47CkylGhl5PuMaKgMJHUTSi6b9+OJDRVRQSXaHLuLmf995o/r
        XTISdUD39ot6eZs9lN8r+8I=
X-Google-Smtp-Source: APXvYqzW7PptqG/eG1Uvb+n2D7V1Fts295o9GejhOs1aKkDOF1kwZ28ZJ9hMkrqHMUoFy66Vx0cyCg==
X-Received: by 2002:a05:600c:290e:: with SMTP id i14mr4991457wmd.24.1582633230894;
        Tue, 25 Feb 2020 04:20:30 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id h2sm23815782wrt.45.2020.02.25.04.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 04:20:29 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:20:28 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200225122028.GS22443@dhcp22.suse.cz>
References: <20200213163636.GH31689@dhcp22.suse.cz>
 <20200213165711.GJ88887@mtj.thefacebook.com>
 <20200214071537.GL31689@dhcp22.suse.cz>
 <20200214135728.GK88887@mtj.thefacebook.com>
 <20200214151318.GC31689@dhcp22.suse.cz>
 <20200214165311.GA253674@cmpxchg.org>
 <20200217084100.GE31531@dhcp22.suse.cz>
 <20200218195253.GA13406@cmpxchg.org>
 <20200221101147.GO20509@dhcp22.suse.cz>
 <20200221154359.GA70967@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221154359.GA70967@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Fri 21-02-20 10:43:59, Johannes Weiner wrote:
> On Fri, Feb 21, 2020 at 11:11:47AM +0100, Michal Hocko wrote:
[...]
> > I also have hard time to grasp what you actually mean by the above.
> > Let's say you have hiearchy where you split out low limit unevenly
> >               root (5G of memory)
> >              /    \
> >    (low 3G) A      D (low 1,5G)
> >            / \
> >  (low 1G) B   C (low 2G)
> >
> > B gets lower priority than C and D while C gets higher priority than
> > D? Is there any problem with such a configuration from the semantic
> > point of view?
> 
> No, that's completely fine.

How is B (low $EPS) C (low 3-$EPS) where $EPS->0 so much different
from the above. You prioritize C over B, D over B in both cases under
global memory pressure.

[...]

> > > However, that doesn't mean this usecase isn't supported. You *can*
> > > always split cgroups for separate resource policies.
> > 
> > What if the split up is not possible or impractical. Let's say you want
> > to control how much CPU share does your container workload get comparing
> > to other containers running on the system? Or let's say you want to
> > treat the whole container as a single entity from the OOM perspective
> > (this would be an example of the logical organization constrain) because
> > you do not want to leave any part of that workload lingering behind if
> > the global OOM kicks in. I am pretty sure there are many other reasons
> > to run related workload that doesn't really share the memory protection
> > demand under a shared cgroup hierarchy.
> 
> The problem is that your "pretty sure" has been proven to be very
> wrong in real life. And that's one reason why these arguments are so
> frustrating: it's your intuition and gut feeling against the
> experience of using this stuff hands-on in large scale production
> deployments.

I am pretty sure you have a lot of experiences from the FB workloads.
And I haven't ever questioned that. All I am trying to explore here is
what the consequences of the new proposed semantic are. I have provided
few examples of when an opt-out from memory protection might be
practical. You seem to disagree on relevance of those usecases and I can
live with that. Not that I am fully convinced because there is a
different between a very tight resource control which is your primary
usecase and a much simpler deployments focusing on particular resources
which tend to work most of the time and occasional failures are
acceptable.

That being said, the new interface requires an explicit opt-in via mount
option so there is no risk of regressions. So I can live with it. Please
make sure to document explicitly that the effective low limit protection
doesn't allow to opt-out even when the limit is set to 0 and the
propagated protection is fully assigned to a sibling memcg.

It would be also really appreciated if we have some more specific examples
of priority inversion problems you have encountered previously and place
them somewhere into our documentation. There is essentially nothing like
that in the tree.

Thanks!
-- 
Michal Hocko
SUSE Labs
