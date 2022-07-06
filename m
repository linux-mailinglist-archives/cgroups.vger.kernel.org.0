Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA118567CF2
	for <lists+cgroups@lfdr.de>; Wed,  6 Jul 2022 06:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiGFED3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Jul 2022 00:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiGFED2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Jul 2022 00:03:28 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A9DE1;
        Tue,  5 Jul 2022 21:03:27 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id 189so13961419vsh.2;
        Tue, 05 Jul 2022 21:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMOXU9KWNm3j8iYiYGllvra8fWrHwp8WY0VXFRlbzgk=;
        b=jixxLQE46gl5vVIhvX1Y6PvczVME2POiT22AeGVsZ54M4C7ru8ga21OpHfmLGi545I
         QNq9iYQ5tuGMMzAe4ybmIRglzba5nuW67V1AVkczeKjUPU0uudeCTbo4an5OZh0cnXfq
         QN4BJwIGiMVLyiQ8jeL7DrfQy7VshQgFrZ9XCOcJVQoNgW06w+9YYyU5z5W2SWBU66F6
         dUeEsOnHDadhYHDC/PLMQVJ2yDrzyhrMJ3Io9zeUPvgG6mMXJ23Ek19ANTv7Bn2cGpzm
         xl40SFD1GfFX/Dk7RT3tcugbpB7AwEUtzlN5cxYei5HehrgWJJ5BeeR9FQlRHOpg4YmO
         bmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMOXU9KWNm3j8iYiYGllvra8fWrHwp8WY0VXFRlbzgk=;
        b=yWT2pZn8QTRvzkcTf4/MzBqlik+cxQzmwn4htIGgeWpxloNFBwo4ZCRyAamD8LPeaG
         So5XFJYBvkLhSjA0+88gHz0kri3llT3eDqzqrN4kvjT6aptp2WQ2dV8Y+aeaD107DlnF
         cHXBuzPjaNu8/EVohgRly26dFZ+oPf4g64yrwUomKuP/v07tQm13VyYeAWIsLfVRKisX
         lAsWkJZfBDI/GMh1HGCeQjHLjQj1UEUtK8z31jOVQW4mm5kTSJPQKEosB2YFcFVXMQ9q
         7DdyZ6viXEwS+f5Ou6ve5cLfGtbM3hqFQdul2LhmenEvk9XyGqumUfsypAeMoxmwKYLQ
         Nxbg==
X-Gm-Message-State: AJIora/NUF4rFPodfEyPbhR7J9eyNDlCrXl46RPO5zifOtqbwJ0FKa7E
        OTkPqh/CFA13PlXVqI1ej9ZFS35zIF+87q8xBQk=
X-Google-Smtp-Source: AGRyM1vZX8KVbnxd1aaz6SUN8zHARsVwIVAagJtSGENonH3i8iR9bvGXJGJe+lHcRC9JTfptGkwO7bk4e2jYt/RCiwU=
X-Received: by 2002:a05:6102:cc6:b0:356:3c5c:beb5 with SMTP id
 g6-20020a0561020cc600b003563c5cbeb5mr21216824vst.80.1657080206548; Tue, 05
 Jul 2022 21:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
 <YsBmoqEBCa7ra7w2@castle> <YsMCMveSdiYX/2eH@dhcp22.suse.cz>
 <YsSj6rZmUkR8amT2@castle> <CALOAHbAb9DT6ihyxTm-4FCUiqiAzRSUHJw9erc+JTKVT9p8tow@mail.gmail.com>
 <YsUBQsTjVuXvt1Wr@castle> <CALOAHbDjRzySCHeMVHtVDe=Ji+qh=n0pT4CwiAM5Pahi2-QNCQ@mail.gmail.com>
 <YsUH7pgBVnWSkC1q@castle>
In-Reply-To: <YsUH7pgBVnWSkC1q@castle>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 6 Jul 2022 12:02:49 +0800
Message-ID: <CALOAHbA+C2nM4qSj2yPfbdzbqZ-UdCpg5QP0+f5HbEtpi0ZZGQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for enforced allocations
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 6, 2022 at 11:56 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Wed, Jul 06, 2022 at 11:42:50AM +0800, Yafang Shao wrote:
> > On Wed, Jul 6, 2022 at 11:28 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > >
> > > On Wed, Jul 06, 2022 at 10:46:48AM +0800, Yafang Shao wrote:
> > > > On Wed, Jul 6, 2022 at 4:49 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > >
> > > > > On Mon, Jul 04, 2022 at 05:07:30PM +0200, Michal Hocko wrote:
> > > > > > On Sat 02-07-22 08:39:14, Roman Gushchin wrote:
> > > > > > > On Fri, Jul 01, 2022 at 10:50:40PM -0700, Shakeel Butt wrote:
> > > > > > > > On Fri, Jul 1, 2022 at 8:35 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > > > > > >
> > > > > > > > > Yafang Shao reported an issue related to the accounting of bpf
> > > > > > > > > memory: if a bpf map is charged indirectly for memory consumed
> > > > > > > > > from an interrupt context and allocations are enforced, MEMCG_MAX
> > > > > > > > > events are not raised.
> > > > > > > > >
> > > > > > > > > It's not/less of an issue in a generic case because consequent
> > > > > > > > > allocations from a process context will trigger the reclaim and
> > > > > > > > > MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> > > > > > > > > memory cgroup, so it might never happen.
> > > > > > > >
> > > > > > > > The patch looks good but the above sentence is confusing. What might
> > > > > > > > never happen? Reclaim or MAX event on dying memcg?
> > > > > > >
> > > > > > > Direct reclaim and MAX events. I agree it might be not clear without
> > > > > > > looking into the code. How about something like this?
> > > > > > >
> > > > > > > "It's not/less of an issue in a generic case because consequent
> > > > > > > allocations from a process context will trigger the direct reclaim
> > > > > > > and MEMCG_MAX events will be raised. However a bpf map can belong
> > > > > > > to a dying/abandoned memory cgroup, so there will be no allocations
> > > > > > > from a process context and no MEMCG_MAX events will be triggered."
> > > > > >
> > > > > > Could you expand little bit more on the situation? Can those charges to
> > > > > > offline memcg happen indefinetely?
> > > > >
> > > > > Yes.
> > > > >
> > > > > > How can it ever go away then?
> > > > >
> > > > > Bpf map should be deleted by a user first.
> > > > >
> > > >
> > > > It can't apply to pinned bpf maps, because the user expects the bpf
> > > > maps to continue working after the user agent exits.
> > > >
> > > > > > Also is this something that we actually want to encourage?
> > > > >
> > > > > Not really. We can implement reparenting (probably objcg-based), I think it's
> > > > > a good idea in general. I can take a look, but can't promise it will be fast.
> > > > >
> > > > > In thory we can't forbid deleting cgroups with associated bpf maps, but I don't
> > > > > thinks it's a good idea.
> > > > >
> > > >
> > > > Agreed. It is not a good idea.
> > > >
> > > > > > In other words shouldn't those remote charges be redirected when the
> > > > > > target memcg is offline?
> > > > >
> > > > > Reparenting is the best answer I have.
> > > > >
> > > >
> > > > At the cost of increasing the complexity of deployment, that may not
> > > > be a good idea neither.
> > >
> > > What do you mean? Can you please elaborate on it?
> > >
> >
> >                    parent memcg
> >                          |
> >                     bpf memcg   <- limit the memory size of bpf
> > programs
> >                         /           \
> >          bpf user agent     pinned bpf program
> >
> > After bpf user agents exit, the bpf memcg will be dead, and then all
> > its memory will be reparented.
> > That is okay for preallocated bpf maps, but not okay for
> > non-preallocated bpf maps.
> > Because the bpf maps will continue to charge, but as all its memory
> > and objcg are reparented, so we have to limit the bpf memory size in
> > the parent as follows,
>
> So you're relying on the memory limit of a dying cgroup?

No. I didn't say it.  What I said is you can't use a dying cgroup to
limit it, that's why I said that we have to use parant memcg to limit
it.

> Sorry, but I don't think we can seriously discuss such a design.
> A dying cgroup is invisible for a user, a user can't change any tunables,
> they have zero visibility into any stats or charges. Why would you do this?
>
> If you want the cgroup to be an active part of the memory management
> process, don't delete it. There are exactly zero guarantees about what
> happens with a memory cgroup after being deleted by a user, it's all
> implementation details.
>
> Anyway, here is the patch for reparenting bpf maps:
> https://github.com/rgushchin/linux/commit/f57df8bb35770507a4624fe52216b6c14f39c50c
>
> I gonna post it to bpf@ after some testing.
>

I will take a look at it.
But AFAIK the reparenting can't resolve the problem of non-preallocated maps.


-- 
Regards
Yafang
