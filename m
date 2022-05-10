Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81827520A57
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 02:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiEJAsW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 May 2022 20:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiEJAsV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 May 2022 20:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C391D8129;
        Mon,  9 May 2022 17:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5F336155D;
        Tue, 10 May 2022 00:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B28C385C5;
        Tue, 10 May 2022 00:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652143465;
        bh=K0UKY0ySeiFuDmMGhu1CLNh5evnfc+t09/RQFlXE1vQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r2fDG/los3M43jggaD960JLHPjml0wyQki6J5AgpUG5+3V7pGIF2guVWMjqM9WMGM
         rby7uK5PK+FbhWL9YT2LyKZeKJbPyfOYDGhIL8Nel5V7s9/Iz+sTuzDkyD8wZvLufl
         pr0HgM3+XMRD6oT3RVYI9q7E9pjzf57vpAKMman8=
Date:   Mon, 9 May 2022 17:44:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     David Vernet <void@manifault.com>,
        Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, mhocko@kernel.org, shakeelb@google.com,
        kernel-team@fb.com, Richard Palethorpe <rpalethorpe@suse.com>
Subject: Re: [PATCH v2 2/5] cgroup: Account for memory_recursiveprot in
 test_memcg_low()
Message-Id: <20220509174424.e43e695ffe0f7333c187fba8@linux-foundation.org>
In-Reply-To: <Ynkum8DeJIAtGi9y@cmpxchg.org>
References: <20220423155619.3669555-1-void@manifault.com>
        <20220423155619.3669555-3-void@manifault.com>
        <20220427140928.GD9823@blackbody.suse.cz>
        <20220429010333.5rt2jwpiumnbuapf@dev0025.ash9.facebook.com>
        <20220429092620.GA23621@blackbody.suse.cz>
        <20220506164015.fsdsuv226nhllos5@dev0025.ash9.facebook.com>
        <Ynkum8DeJIAtGi9y@cmpxchg.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 9 May 2022 11:09:15 -0400 Johannes Weiner <hannes@cmpxchg.org> wrot=
e:

> On Fri, May 06, 2022 at 09:40:15AM -0700, David Vernet wrote:
> > Sorry for the delayed reply, Michal. I've been at LSFMM this week.
> >=20
> > On Fri, Apr 29, 2022 at 11:26:20AM +0200, Michal Koutn=FD wrote:
> > > I still think that the behavior when there's no protection left for t=
he
> > > memory.low =3D=3D 0 child, there should be no memory.low events (not =
just
> > > uncounted but not happening) and test should not accept this (even
> > > though it's the current behavior).
> >
> > That's fair. I think part of the problem here is that in general, the
> > memcontroller itself is quite heuristic, so it's tough to write tests t=
hat
> > provide useful coverage while also being sufficiently flexible to avoid
> > flakiness and over-prescribing expected behavior. In this case I think =
it's
> > probably correct that the memory.low =3D=3D 0 child shouldn't inherit
> > protection from its parent under any circumstances due to its siblings
> > overcommitting the parent's protection, but I also wonder if it's really
> > necessary to enforce that. If you look at how much memory A/B/E gets at=
 the
> > end of the reclaim, it's still far less than 1MB (though should it be 0=
?).
> > I'd be curious to hear what Johannes thinks.
>=20
> We need to distinguish between what the siblings declare and what they
> consume.
>=20
> My understanding of the issue you're raising, Michal, is that
> protected siblings start with current > low, then get reclaimed
> slightly too much and end up with current < low. This results in a
> tiny bit of float that then gets assigned to the low=3D0 sibling; when
> that sibling gets reclaimed regardless, it sees a low event. Correct
> me if I missed a detail or nuance here.
>=20
> But unused float going to siblings is intentional. This is documented
> in point 3 in the comment above effective_protection(): if you use
> less than you're legitimately claiming, the float goes to your
> siblings. So the problem doesn't seem to be with low accounting and
> event generation, but rather it's simply overreclaim.
>=20
> It's conceivable to make reclaim more precise and then tighten up the
> test. But right now, David's patch looks correct to me.

So I think we're OK with [2/5] now.  Unless there be objections, I'll
be looking to get this series into mm-stable later this week.

