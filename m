Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5164EEDB7
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 15:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346119AbiDANFE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Apr 2022 09:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245752AbiDANFB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Apr 2022 09:05:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5962706E5;
        Fri,  1 Apr 2022 06:03:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0CD4E1FCFF;
        Fri,  1 Apr 2022 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648818191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8Fv6ZDQ8m+qPC8dDpr3Y/+f6kvNVrRdMcIsE+f6ZEU=;
        b=lubng6AuK16ZqODySVuFbAIiNelcW5AfzZgr4sNsal07K8TvFn3bNcchUYwkoBlOMOeKLp
        BtLjH2snjDWIO1W3RF9RbkPDG+a/s+0v1MjSq4/BODP/3y/3mddKI4fF4Hxdnm1mZcB+1b
        hW0uhc+1XDp1BKTMZ1QPAnz025krtu8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 59DE7A3B87;
        Fri,  1 Apr 2022 13:03:10 +0000 (UTC)
Date:   Fri, 1 Apr 2022 15:03:09 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
Message-ID: <Ykb4DVt0eKrstDWv@dhcp22.suse.cz>
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <20220331173350.1fe09370479a4a6f916b477d@linux-foundation.org>
 <CAAPL-u-_Da0qe7h_o70HCz4gPtjT8_bjx4rVNdgKZh3KNruzpA@mail.gmail.com>
 <CAJD7tkarUYM6fjty8FXn9gtR=RVWgksa3LNwswi1Ug1LPnLt4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkarUYM6fjty8FXn9gtR=RVWgksa3LNwswi1Ug1LPnLt4g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 01-04-22 02:17:28, Yosry Ahmed wrote:
> On Thu, Mar 31, 2022 at 8:38 PM Wei Xu <weixugc@google.com> wrote:
> >
> > On Thu, Mar 31, 2022 at 5:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Thu, 31 Mar 2022 08:41:51 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -6355,6 +6355,38 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
> > > >       return nbytes;
> > > >  }
> > > >
> > > > +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > > > +                           size_t nbytes, loff_t off)
> > > > +{
> > > > +     struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > > > +     unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > > > +     unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > > > +     int err;
> > > > +
> > > > +     buf = strstrip(buf);
> > > > +     err = page_counter_memparse(buf, "", &nr_to_reclaim);
> > > > +     if (err)
> > > > +             return err;
> > > > +
> > > > +     while (nr_reclaimed < nr_to_reclaim) {
> > > > +             unsigned long reclaimed;
> > > > +
> > > > +             if (signal_pending(current))
> > > > +                     break;
> > > > +
> > > > +             reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > > > +                                             nr_to_reclaim - nr_reclaimed,
> > > > +                                             GFP_KERNEL, true);
> > > > +
> > > > +             if (!reclaimed && !nr_retries--)
> > > > +                     break;
> > > > +
> > > > +             nr_reclaimed += reclaimed;
> > > > +     }
> > >
> > > Is there any way in which this can be provoked into triggering the
> > > softlockup detector?
> >
> > memory.reclaim is similar to memory.high w.r.t. reclaiming memory,
> > except that memory.reclaim is stateless, while the kernel remembers
> > the state set by memory.high.  So memory.reclaim should not bring in
> > any new risks of triggering soft lockup, if any.

Memory reclaim already has cond_resched even if there is nothing
reclaimable. See shrink_node_memcgs

> > > Is it optimal to do the MAX_RECLAIM_RETRIES loop in the kernel?
> > > Would additional flexibility be gained by letting userspace handle
> > > retrying?
> >
> > I agree it is better to retry from the userspace.
> 
> Thanks Andrew and Wei for looking at this. IIUC the
> MAX_RECLAIM_RETRIES loop was modeled after the loop in memory.high as
> well. Is there a reason why it should be different here?

No, I would go with the same approach other interfaces use. I am not a
great fan of MAX_RECLAIM_RETRIES - especially when we have a bail out on
signals - but if we are to change this then let's do it consisently.

-- 
Michal Hocko
SUSE Labs
