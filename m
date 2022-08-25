Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32DA5A08FE
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 08:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiHYGkz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 02:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiHYGkx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 02:40:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAB9E03F;
        Wed, 24 Aug 2022 23:40:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D76AE5BE15;
        Thu, 25 Aug 2022 06:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661409650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8tP0U7uO6jkjoWoaVJTMGffTLHsMTAeM7ZO+0Ttzpnc=;
        b=Rlq2EbXz/KoWktPrNnKN7AIXIeIrydmCssc+ZXhRb8K/2E3gz3XlPnDJOGqi2IIcPcmtAO
        /gA127K196XnzQb58YhLdftTVYTGJzLNuLnqgaP2dPun3n3mKuze7iKY/qiq73UzJvHzsO
        XCPRI/PrCt8PtA7mhOsqkjocr6NW3hs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8D2C13A47;
        Thu, 25 Aug 2022 06:40:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SRPaKnIZB2OIOwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 25 Aug 2022 06:40:50 +0000
Date:   Thu, 25 Aug 2022 08:40:50 +0200
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
Message-ID: <YwcZctA2S3Sd0LBN@dhcp22.suse.cz>
References: <YwRjyx6wFLk8WTDe@dhcp22.suse.cz>
 <CAGWkznGaYTv4u4kOo-rupfyWzDNJXNKTchwP6dbUK-=UXWm47w@mail.gmail.com>
 <YwSQ4APOu/H7lYGL@dhcp22.suse.cz>
 <CAGWkznGd6mgareABseMKY5p0f1=5dkfVkj=NS7_B6OkXBYSwyw@mail.gmail.com>
 <YwS/S9Sd1OWnT81Q@dhcp22.suse.cz>
 <CAGWkznGYLyF+njUB0gFF3JVdThnK9JaNsqxXYFhbdSwEQpCxvA@mail.gmail.com>
 <YwXYVjRpXQjQMsxr@dhcp22.suse.cz>
 <CAGWkznEqX3DwHW_owiK+HuuQ-HsUYK4vKmLhSxgzGn20Vzid2A@mail.gmail.com>
 <YwX89JCQCKMMYdG9@dhcp22.suse.cz>
 <CAGWkznF+dBjLzAxMMXWYSZ_5q3KA-ou0P7XM7jSYN7JSRp8N0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznF+dBjLzAxMMXWYSZ_5q3KA-ou0P7XM7jSYN7JSRp8N0w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 25-08-22 08:43:52, Zhaoyang Huang wrote:
> On Wed, Aug 24, 2022 at 6:27 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 24-08-22 17:34:42, Zhaoyang Huang wrote:
[...]
> > > IMHO, charging the pages which out of explicitly memory
> > > enabled group to root could solve all of the above constraints with no
> > > harm.
> >
> > This would break the hierarchical property of the controller. So a
> > strong no no. Consider the following example
> >
> >        root
> >         |
> >         A
> > controllers="memory"
> > memory.max = 1G
> > subtree_control=""
> > |      |      |
> > A1     A2     A3
> >
> > althought A1,2,3 do not have their memory controller enabled explicitly
> > they are still constrained by the A memcg limit. If you just charge to
> > the root because it doesn't have memory controller enabled explicitly
> > then you just evade that constrain. I hope you understand why that is a
> > problem.
> IMO, A1-A3 should be explicitly enabled via echo "+memory" >
> A/subtree_control since memory.max has been set.

You seem to be missing the point I've triedy to make here. It is not
about how the respective subtree should or shouldn't be configured. It
is about the hierarchical behavior. Configuration at a higher level should be
enforced under subtree no matter how that subtree decides to
enabled/disable controllers. Such subtree might have beeb delegated
and configured differently yet the constrain should be still applied.
See the point?

What you seem to be proposing is similar to cgroup v1 use_hierarchy
configuration. It has been decided that this is undesirable very early
in the cgroup v2 development because it make delegation impossible
(among other reasons).

-- 
Michal Hocko
SUSE Labs
