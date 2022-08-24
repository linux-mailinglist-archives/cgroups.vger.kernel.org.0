Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3358959F7AF
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 12:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiHXK17 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 06:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiHXK1k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 06:27:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F4E80B75;
        Wed, 24 Aug 2022 03:27:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AF57A34169;
        Wed, 24 Aug 2022 10:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661336821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=svip1HnOF9D7Fl9aKofEvyk0pEgENUVlEuB1mZtboTA=;
        b=BSwbM9o5a63Dsl3aydVUid7PDlzXWhAjXTXwpvHPRto/Y+Z4jx+DSo3SpxBtt/QERnMVCr
        Bsy6tdYVt8qrRFwuly1qta1c5/YJ/QwiiPW6MwVlDOnVjadS+2kc3loarhh3eYS9c9OEfd
        Ry2BcmegFWJQ3RRPza792trSufbhx4o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A0F413AC0;
        Wed, 24 Aug 2022 10:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HCidH/X8BWMvGwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 24 Aug 2022 10:27:01 +0000
Date:   Wed, 24 Aug 2022 12:27:00 +0200
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
Message-ID: <YwX89JCQCKMMYdG9@dhcp22.suse.cz>
References: <YwNpI1ydy0yDnBH0@dhcp22.suse.cz>
 <CAGWkznEB+R0YBaBFBL7dPqs8R=qKC6+ixTWEGCYy2PaczXkaPA@mail.gmail.com>
 <YwRjyx6wFLk8WTDe@dhcp22.suse.cz>
 <CAGWkznGaYTv4u4kOo-rupfyWzDNJXNKTchwP6dbUK-=UXWm47w@mail.gmail.com>
 <YwSQ4APOu/H7lYGL@dhcp22.suse.cz>
 <CAGWkznGd6mgareABseMKY5p0f1=5dkfVkj=NS7_B6OkXBYSwyw@mail.gmail.com>
 <YwS/S9Sd1OWnT81Q@dhcp22.suse.cz>
 <CAGWkznGYLyF+njUB0gFF3JVdThnK9JaNsqxXYFhbdSwEQpCxvA@mail.gmail.com>
 <YwXYVjRpXQjQMsxr@dhcp22.suse.cz>
 <CAGWkznEqX3DwHW_owiK+HuuQ-HsUYK4vKmLhSxgzGn20Vzid2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEqX3DwHW_owiK+HuuQ-HsUYK4vKmLhSxgzGn20Vzid2A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 24-08-22 17:34:42, Zhaoyang Huang wrote:
> On Wed, Aug 24, 2022 at 3:50 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 24-08-22 10:23:14, Zhaoyang Huang wrote:
> > > On Tue, Aug 23, 2022 at 7:51 PM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > One way to achieve that would be shaping the hierarchy the following way
> > > >             root
> > > >         /         \
> > > > no_memcg[1]      memcg[2]
> > > > ||||||||         |||||
> > > > app_cgroups     app_cgroups
> > > >
> > > > with
> > > > no_memcg.subtree_control = ""
> > > > memcg.subtree_control = memory
> > > >
> > > > no?
> > > According to my understanding, No as there will be no no_memcg. All
> > > children groups under root would have its cgroup.controllers = memory
> > > as long as root has memory enabled.
> >
> > Correct
> >
> > > Under this circumstance, all
> > > descendants group under 'no_memcg' will charge memory to its parent
> > > group.
> >
> > Correct. And why is that a problem? I thought you main concern was a per
> > application LRUs. With the above configuration all app_cgroups which do
> > not require an explicit memory control will share the same (no_memcg)
> > LRU and they will be aged together.
> I can't agree since this indicates the processes want memory free
> depending on a specific hierarchy which could have been determined by
> other subsys.

I really fail to understand your requirements.

> IMHO, charging the pages which out of explicitly memory
> enabled group to root could solve all of the above constraints with no
> harm.

This would break the hierarchical property of the controller. So a
strong no no. Consider the following example

       root
	|
	A
controllers="memory"
memory.max = 1G
subtree_control=""
|      |      |
A1     A2     A3

althought A1,2,3 do not have their memory controller enabled explicitly
they are still constrained by the A memcg limit. If you just charge to
the root because it doesn't have memory controller enabled explicitly
then you just evade that constrain. I hope you understand why that is a
problem.
-- 
Michal Hocko
SUSE Labs
