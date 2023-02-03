Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ADF68A2D6
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 20:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjBCTUG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 14:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjBCTTl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 14:19:41 -0500
Received: from out-22.mta1.migadu.com (out-22.mta1.migadu.com [IPv6:2001:41d0:203:375::16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D828311F
        for <cgroups@vger.kernel.org>; Fri,  3 Feb 2023 11:19:39 -0800 (PST)
Date:   Fri, 3 Feb 2023 11:19:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675451977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBM6UGsWSc/J+v73pZDrkX8oGGd9uvbvRutgj4g0VrU=;
        b=DCWeQAu8NfpO8qhLsTfLFhJ+J7jUlaMIrWlZ6kB/ZDrVTx+o3KY5ABEu2/giYvWnxD8hvG
        vZgj9rde9D3RjMBYR9cUSVlDI72LbrlYTtjC+Izg9jaDCkfBiauCBkEkTdsAjBX0rHa4AD
        q/AXyR4KuBP2dFpdEQCnlJVQs/2vP9c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] mm: memcontrol: don't account swap failures not due
 to cgroup limits
Message-ID: <Y91eRKKutWBZwmSG@P9FQF9L96D.corp.robot.car>
References: <20230202155626.1829121-1-hannes@cmpxchg.org>
 <Y91ZsDSIr2oFHu3E@P9FQF9L96D.corp.robot.car>
 <CAHbLzkpk+6+kzsxmJ_MK+708rpCEjB2njnarLkzfzXX-MUyG7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpk+6+kzsxmJ_MK+708rpCEjB2njnarLkzfzXX-MUyG7g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 03, 2023 at 11:07:30AM -0800, Yang Shi wrote:
> On Fri, Feb 3, 2023 at 11:00 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Thu, Feb 02, 2023 at 10:56:26AM -0500, Johannes Weiner wrote:
> > > Christian reports the following situation in a cgroup that doesn't
> > > have memory.swap.max configured:
> > >
> > >   $ cat memory.swap.events
> > >   high 0
> > >   max 0
> > >   fail 6218
> > >
> > > Upon closer examination, this is an ARM64 machine that doesn't support
> > > swapping out THPs.
> >
> > Do we expect it to be added any time soon or it's caused by some system
> > limitations?
> 
> AFAIK, it has been supported since 6.0. See commit d0637c505f8a1

Great, thank you for the link!
Then it looks like we have even fewer reasons to change the interface.

Thanks!
