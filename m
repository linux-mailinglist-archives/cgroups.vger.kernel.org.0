Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6C7636D13
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 23:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKWWaf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 17:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKWWae (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 17:30:34 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39ECFF418
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 14:30:31 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id d8so13451694qki.13
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 14:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PsyXXA9CudTt1GF7QXo+ry29gXPUEu+QzCWmZI6Zig=;
        b=XMfsHKwK6gxd9tt2hChYTe5pQ25W+G022dNNp25j8jGYTdJNaF40WrrHzq8fOVjvNQ
         6oCZ7b3jr+K2sYCzBFxmbnk24Ep4ujNlf4doTSuQkHNDrqeL5ghS/4l4Xl148Unxbptt
         iHkxYQ0vlJAVtsjKS2tOCk6WFNQGGe/k97tPlHGzXftZ9/eWz1QepcoTWTyk0oklY6S3
         h+08Iq4aqap3gfcMhOfLp5DkiOX/fswAoTFAJQKh2cvH3o9OTCQAUIuAGNpMkSmNnicN
         S2SqUR1boFkW3FREVyDD/Sx6b827THmq1YMvB30nC/aeRC118qw2xmUFWjVSv1lxqE1J
         J+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PsyXXA9CudTt1GF7QXo+ry29gXPUEu+QzCWmZI6Zig=;
        b=7kL6u3GQr4zblgGzygZuKQSTD6H1Y77aTlObCmvDzLBnAdfoi3hsI8V1GM91PhHLL2
         ySbxkhL1gSSqMEibwcY+BhbgbDpjhkz7Dx5NhYHJoAODmibv1IMUKB38vj2HXjHXegaH
         C6NVPGHpEBXQACWs4GMCBN8g6zTQpu16RXCnVjqZvwmr+UI+SPLDiXxCzVV7AvXHV7B2
         oxt6Z0wDqdzs0eKyPouCTuUEUEBtxNUnO46NGRe35JQYo5rhRM1h3Cq1zf4D6w8Udfwv
         UD+rk4pmim1viVxKHSzS6AeVylTZnuqf7BLVGYs8aOZtCnIuxfdZf8wVx/dnJUK0q/vT
         KyBg==
X-Gm-Message-State: ANoB5pnqKDc4bJO+ti21k7qYZXRWFZUB+6mpAOee7gD4Qp78bojaItHA
        chTMna4zYxeVGPMcneWdKvA4sQ==
X-Google-Smtp-Source: AA0mqf7i13+gr+nV4F+Pz1qThWBzQ5ZvPLsujUe0vIKUyAVKNbj+hpveo1MQ3Y6HRoXfeC9fe2BM7w==
X-Received: by 2002:a05:620a:1310:b0:6f9:ffc6:45d1 with SMTP id o16-20020a05620a131000b006f9ffc645d1mr18525732qkj.663.1669242631003;
        Wed, 23 Nov 2022 14:30:31 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id fg22-20020a05622a581600b003a580cd979asm10695213qtb.58.2022.11.23.14.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:30:30 -0800 (PST)
Date:   Wed, 23 Nov 2022 17:30:56 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
Message-ID: <Y36fIGFCFKiocAd6@cmpxchg.org>
References: <20221122203850.2765015-1-almasrymina@google.com>
 <Y35fw2JSAeAddONg@cmpxchg.org>
 <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
 <CAJD7tkZNW=u1TD-Fd_3RuzRNtaFjxihbGm0836QHkdp0Nn-vyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZNW=u1TD-Fd_3RuzRNtaFjxihbGm0836QHkdp0Nn-vyQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 01:35:13PM -0800, Yosry Ahmed wrote:
> On Wed, Nov 23, 2022 at 1:21 PM Mina Almasry <almasrymina@google.com> wrote:
> >
> > On Wed, Nov 23, 2022 at 10:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > Hello Mina,
> > >
> > > On Tue, Nov 22, 2022 at 12:38:45PM -0800, Mina Almasry wrote:
> > > > Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > > > reclaim""), the proactive reclaim interface memory.reclaim does both
> > > > reclaim and demotion. This is likely fine for us for latency critical
> > > > jobs where we would want to disable proactive reclaim entirely, and is
> > > > also fine for latency tolerant jobs where we would like to both
> > > > proactively reclaim and demote.
> > > >
> > > > However, for some latency tiers in the middle we would like to demote but
> > > > not reclaim. This is because reclaim and demotion incur different latency
> > > > costs to the jobs in the cgroup. Demoted memory would still be addressable
> > > > by the userspace at a higher latency, but reclaimed memory would need to
> > > > incur a pagefault.
> > > >
> > > > To address this, I propose having reclaim-only and demotion-only
> > > > mechanisms in the kernel. There are a couple possible
> > > > interfaces to carry this out I considered:
> > > >
> > > > 1. Disable demotion in the memory.reclaim interface and add a new
> > > >    demotion interface (memory.demote).
> > > > 2. Extend memory.reclaim with a "demote=<int>" flag to configure the demotion
> > > >    behavior in the kernel like so:
> > > >       - demote=0 would disable demotion from this call.
> > > >       - demote=1 would allow the kernel to demote if it desires.
> > > >       - demote=2 would only demote if possible but not attempt any
> > > >         other form of reclaim.
> > >
> > > Unfortunately, our proactive reclaim stack currently relies on
> > > memory.reclaim doing both. It may not stay like that, but I'm a bit
> > > wary of changing user-visible semantics post-facto.
> > >
> > > In patch 2, you're adding a node interface to memory.demote. Can you
> > > add this to memory.reclaim instead? This would allow you to control
> > > demotion and reclaim independently as you please: if you call it on a
> > > node with demotion targets, it will demote; if you call it on a node
> > > without one, it'll reclaim. And current users will remain unaffected.
> >
> > Hello Johannes, thanks for taking a look!
> >
> > I can certainly add the "nodes=" arg to memory.reclaim and you're
> > right, that would help in bridging the gap. However, if I understand
> > the underlying code correctly, with only the nodes= arg the kernel
> > will indeed attempt demotion first, but the kernel will also merrily
> > fall back to reclaiming if it can't demote the full amount. I had
> > hoped to have the flexibility to protect latency sensitive jobs from
> > reclaim entirely while attempting to do demotion.
> >
> > There are probably ways to get around that in the userspace. I presume
> > the userspace can check if there is available memory on the node's
> > demotion targets, and if so, the kernel should demote-only. But I feel
> > that wouldn't be reliable as the demotion logic may change across
> > kernel versions. The userspace may think the kernel would demote but
> > instead demotion failed due to whatever heuristic introduced into the
> > new kernel version.
> >
> > The above is just one angle of the issue. Another angle (which Yosry
> > would care most about I think) is that at Google we call
> > memory.reclaim mainly when memory.current is too close to memory.max
> > and we expect the memory usage of the cgroup to drop as a result of a
> > success memory.reclaim call. I suspect once we take in commit
> > 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg reclaim""),
> > we would run into that regression, but I defer to Yosry here, he may
> > have a solution for that in mind already.
> 
> We don't exactly rely on memory.current, but we do have a separate
> proactive reclaim policy today from demotion, and we do expect
> memory.reclaim to reclaim memory and not demote it. So it is important
> that we can control reclaim vs. demotion separately. Having
> memory.reclaim do demotions by default is not ideal for our current
> setup, so at least having a demote= argument to control it (no
> demotions, may demote, only demote) is needed.

With a nodemask you should be able to only reclaim by specifying
terminal memory tiers that do that, and leave out higher tiers that
demote.

That said, it would actually be nice if reclaim policy wouldn't have
to differ from demotion policy longer term. Ultimately it comes down
to mapping age to memory tier, right? Such that hot pages are in RAM,
warm pages are in CXL, cold pages are in storage. If you apply equal
presure on all tiers, it's access frequency that should determine
which RAM pages to demote, and which CXL pages to reclaim. If RAM
pages are hot and refuse demotion, and CXL pages are cold in
comparison, CXL should clear out. If RAM pages are warm, they should
get demoted to CXL but not reclaimed further from there (and rotate
instead).

Do we know what's preventing this from happening today? What's the
reason you want to control them independently?
