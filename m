Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D395A0BDD
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiHYIuq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 04:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiHYIup (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 04:50:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3D48F941;
        Thu, 25 Aug 2022 01:50:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 29B9634CB5;
        Thu, 25 Aug 2022 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661417442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zP6YQmZN7163OEbBczeU7FAkSDwVdl5LC3HTPoybyrM=;
        b=FXgUGZB+osz5E4JAckwNcEMAP2NfQm322eTKa+A9/pgC4y/sgW0XuNYetBenNlNDIxO/fw
        vWwoqK/wBxIIugpIEItM7OO/MDtdysSicXWJ68yqmO/LCq9pJTk8VfZAR9VnTVJV5y6C7h
        8JbaOXXlGeGJ4aCK+1vxzqr2MxONwPg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 083BA13517;
        Thu, 25 Aug 2022 08:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NoP0OuE3B2PPNgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 25 Aug 2022 08:50:41 +0000
Date:   Thu, 25 Aug 2022 10:50:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
Message-ID: <Ywc34ci5XUMXOSYA@dhcp22.suse.cz>
References: <YwSQ4APOu/H7lYGL@dhcp22.suse.cz>
 <CAGWkznGd6mgareABseMKY5p0f1=5dkfVkj=NS7_B6OkXBYSwyw@mail.gmail.com>
 <YwS/S9Sd1OWnT81Q@dhcp22.suse.cz>
 <CAGWkznGYLyF+njUB0gFF3JVdThnK9JaNsqxXYFhbdSwEQpCxvA@mail.gmail.com>
 <YwXYVjRpXQjQMsxr@dhcp22.suse.cz>
 <CAGWkznEqX3DwHW_owiK+HuuQ-HsUYK4vKmLhSxgzGn20Vzid2A@mail.gmail.com>
 <YwX89JCQCKMMYdG9@dhcp22.suse.cz>
 <CAGWkznF+dBjLzAxMMXWYSZ_5q3KA-ou0P7XM7jSYN7JSRp8N0w@mail.gmail.com>
 <YwcZctA2S3Sd0LBN@dhcp22.suse.cz>
 <CAGWkznH5gQXigdLx=fwdL0uqdGx4WE9QP8b8cbWFxr=Rdg-CZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznH5gQXigdLx=fwdL0uqdGx4WE9QP8b8cbWFxr=Rdg-CZQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 25-08-22 16:34:04, Zhaoyang Huang wrote:
> On Thu, Aug 25, 2022 at 2:40 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 25-08-22 08:43:52, Zhaoyang Huang wrote:
> > > On Wed, Aug 24, 2022 at 6:27 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Wed 24-08-22 17:34:42, Zhaoyang Huang wrote:
> > [...]
> > > > > IMHO, charging the pages which out of explicitly memory
> > > > > enabled group to root could solve all of the above constraints with no
> > > > > harm.
> > > >
> > > > This would break the hierarchical property of the controller. So a
> > > > strong no no. Consider the following example
> > > >
> > > >        root
> > > >         |
> > > >         A
> > > > controllers="memory"
> > > > memory.max = 1G
> > > > subtree_control=""
> > > > |      |      |
> > > > A1     A2     A3
> > > >
> > > > althought A1,2,3 do not have their memory controller enabled explicitly
> > > > they are still constrained by the A memcg limit. If you just charge to
> > > > the root because it doesn't have memory controller enabled explicitly
> > > > then you just evade that constrain. I hope you understand why that is a
> > > > problem.
> > > IMO, A1-A3 should be explicitly enabled via echo "+memory" >
> > > A/subtree_control since memory.max has been set.
> >
> > You seem to be missing the point I've triedy to make here. It is not
> > about how the respective subtree should or shouldn't be configured. It
> > is about the hierarchical behavior. Configuration at a higher level should be
> > enforced under subtree no matter how that subtree decides to
> > enabled/disable controllers. Such subtree might have beeb delegated
> > and configured differently yet the constrain should be still applied.
> > See the point?
> >
> > What you seem to be proposing is similar to cgroup v1 use_hierarchy
> > configuration. It has been decided that this is undesirable very early
> > in the cgroup v2 development because it make delegation impossible
> > (among other reasons).
> Ok, I would like to know how AA3 achieve the goal of competing with A1
> and A2 for cpu but keep memory out of control under current policy?
>         root
>          |
>          A
>  controllers="memory,cpu"
>  memory.max = 1G
>  subtree_control="memory,cpu"
>  |      |            |
>  A1     A2     A3 subtree_control="cpu"
>                       |      |
>                     AA3   AA4 controllers="cpu"

I cannot really give you configuration you want without understanding
what you are trying to achieve and why do you need it that way. Really,
you can construct arbitrary hierarchies and only a very small subset of
them actually makes sense. So far you have been very terse at your goals
and intentions but rather demanding on the underlying mechanisms. This
doesn't really makes the discussion productive.

I hope you have at least understood that hierarchical property of the
cgroup v2 is a must and it won't change. If you need a help to construct
hierarchy for your specific workload I would recommend to clearly state
your final goal and reasoning behind. Maybe you will get a more specific
help that way. Good luck!
-- 
Michal Hocko
SUSE Labs
