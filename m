Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2060B1706C3
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2020 18:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgBZR5C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Feb 2020 12:57:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37129 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgBZR5C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Feb 2020 12:57:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so4248673wrx.4;
        Wed, 26 Feb 2020 09:57:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XYuTT4oBJKWXgeE5+ImMK08MUo+U41eFHMUsFDzXC3g=;
        b=oCBGomjXEa7q8nPGNu7vagNdWegtPdLdnxeYOwHu5TroqG2ftTPC6TRvZvwgPJG4zY
         C+FRJ7VF5lL/Pe1kjf16LAH7X2EM9ZNmkVnEwyuXrEwc5l4SMalfykXW5aEkAc3d4mWX
         VxKTTJQUTLxx34UUoFLFNNSw9eAaLWd5am1H5J8ZWKY20QlNixh2KXJdnEg1rVQzMJsE
         lWmAoCEeaR0CahfVkUU0LgjpA4iQTiLjJ+E3woGNjvoPnTlFUtWlAuThwGY+bLU8IxCw
         Df3H0BXD2Tabzi6VvfS3h13pw4rtrd3aMBVoeghmd0996ltY9Y9O+excqd+VtbkHN1OP
         l9Tg==
X-Gm-Message-State: APjAAAVCAXGuvPURGjQ5ngTZYy1OqaihAlK5p9L88QZ1f7HJQSQMGR/K
        7Dq7eruq9kcqApkcPdsIxqPaY2V2
X-Google-Smtp-Source: APXvYqxn+dTMcNHRegTc1CqQ9KKb5lg3/pc5LpPja6Ha7fAC/Me4YB7FHlZVtun3Ul4E652e35RqQw==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr6714677wrm.70.1582739820112;
        Wed, 26 Feb 2020 09:57:00 -0800 (PST)
Received: from localhost (ip-37-188-190-100.eurotel.cz. [37.188.190.100])
        by smtp.gmail.com with ESMTPSA id w7sm3622305wmi.9.2020.02.26.09.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:56:59 -0800 (PST)
Date:   Wed, 26 Feb 2020 18:56:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200226175658.GP3771@dhcp22.suse.cz>
References: <20200214071537.GL31689@dhcp22.suse.cz>
 <20200214135728.GK88887@mtj.thefacebook.com>
 <20200214151318.GC31689@dhcp22.suse.cz>
 <20200214165311.GA253674@cmpxchg.org>
 <20200217084100.GE31531@dhcp22.suse.cz>
 <20200218195253.GA13406@cmpxchg.org>
 <20200221101147.GO20509@dhcp22.suse.cz>
 <20200221154359.GA70967@cmpxchg.org>
 <20200225122028.GS22443@dhcp22.suse.cz>
 <20200225181755.GB10257@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225181755.GB10257@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 25-02-20 13:17:55, Johannes Weiner wrote:
> On Tue, Feb 25, 2020 at 01:20:28PM +0100, Michal Hocko wrote:
> > 
> > On Fri 21-02-20 10:43:59, Johannes Weiner wrote:
> > > On Fri, Feb 21, 2020 at 11:11:47AM +0100, Michal Hocko wrote:
> > [...]
> > > > I also have hard time to grasp what you actually mean by the above.
> > > > Let's say you have hiearchy where you split out low limit unevenly
> > > >               root (5G of memory)
> > > >              /    \
> > > >    (low 3G) A      D (low 1,5G)
> > > >            / \
> > > >  (low 1G) B   C (low 2G)
> > > >
> > > > B gets lower priority than C and D while C gets higher priority than
> > > > D? Is there any problem with such a configuration from the semantic
> > > > point of view?
> > > 
> > > No, that's completely fine.
> > 
> > How is B (low $EPS) C (low 3-$EPS) where $EPS->0 so much different
> > from the above. You prioritize C over B, D over B in both cases under
> > global memory pressure.
> 
> You snipped the explanation for the caveat / the priority inversion
> that followed; it would be good to reply to that instead.

OK, I have misread your response then. Because you were saying that the
above example is perfectly fine while it actually matches your example
of low, mid, high prio example so I was confused.

[...]

I am skipping the large part of your response mostly because I believe
it would make it easier to move this forward.

> > It would be also really appreciated if we have some more specific examples
> > of priority inversion problems you have encountered previously and place
> > them somewhere into our documentation. There is essentially nothing like
> > that in the tree.
> 
> Of course, I wouldn't mind doing that in a separate patch. How about a
> section in cgroup-v2.rst, at "Issues with v1 and Rationales for v2"?

Yes, makes sense. A subsection about examples/best practices/Lessons
learned where we can add more sounds like a very good thing in general.
Because regardless of what tends to work for some deployments it is
always good to give examples of what hasn't worked for others and was
non trivial to find out. This can save countless of hourse for other
people.
-- 
Michal Hocko
SUSE Labs
