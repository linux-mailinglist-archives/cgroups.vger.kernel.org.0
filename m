Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FE87B64AC
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 10:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbjJCIuE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 04:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjJCIuC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 04:50:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF3AAF
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 01:49:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so105218066b.3
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 01:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696322998; x=1696927798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0JTpNHaoGiA988EVZvIhjeIbRusRoOXVDRZstAjXHc=;
        b=Crs1iIu6w7O//RXyGvoZLrFqNciD74xeXoBcdT6kCH+F6n0xMErEtnFrOJWHRCgz7r
         06OEwMI+qnZ/tVmusTCC+yJz/TFvRmYRK40c7N379zy3zZ2crF12AoOVF6ijkhjxBmJY
         l7XslEUqkAY2JgH8hR3CMTMF6Aak2HxD6Nyg93VDobK1jvTz7p4cHIyf2I8pXJkfaKSs
         +qEetTRI2tUJM/IjmKTRr4os95Hsgq9D86fPSsomtFNc4aOQP7YQEQeFIIjd2R2Ih9K2
         B7+bNxKln3jL3xPVmXoImA5cqis8tnC/n3JQfZ0/EWEJhmsXjMm/5EL0lV1k2TgrFqNU
         t4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696322998; x=1696927798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0JTpNHaoGiA988EVZvIhjeIbRusRoOXVDRZstAjXHc=;
        b=VTwZllw1O+KwBWHo1Fm6WEtkAr/Q56lyDnnbmE1PWXsAMsOC9biDiorP8uWQHOkreC
         6guNE/NKQAsC3Afw81uiooSvuBDVzZirMhJZ8tV2Fcoh3ivjpT2jZ9xwgOY4SVUzW1hD
         vBYnt5TF276YVnBaFVHo1TqPf3ayX3W2JncVD7D74N/E3CV0YbshJNmH4VksVLiHmW4N
         sXQG3NBXhL/VPFIu7zwoQvAqBpcvnrEYRgspEt3mYPq/f2Lm+YDYQSlZk0mTP4wRd+b/
         spMdS3kRSF2SZcEwdHcLiYnIu1twubOYZzb9kYFt3CkX1ri7/BDjWHspQVU9vwg9vuqA
         aR3Q==
X-Gm-Message-State: AOJu0YwM/ZozE48j+LR5UdM82GCsqknXh/AQ5hkymZmcQ+sYzsOsfJtT
        O6SktdDpoyXN+6CQnPfw/DhcdpPwoUiZneCbzjHA0g==
X-Google-Smtp-Source: AGHT+IE/rRUq2nOuhn7JqQ2cqMxNW59rUeB4tBcbgslLSABRUEhuhdcBREiy64prQ88LyzMxrnIQeWLA6K/I8PudtWQ=
X-Received: by 2002:a17:907:2e01:b0:9ae:6389:911 with SMTP id
 ig1-20020a1709072e0100b009ae63890911mr12233677ejc.31.1696322997687; Tue, 03
 Oct 2023 01:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175741.635002-1-yosryahmed@google.com>
 <ZRGQIhWF02SRzN4D@dhcp22.suse.cz> <CAJD7tkbWz7mx6mUrvFQHP10ncqL-iVwD4ymHTm=oXW5qGgrZtA@mail.gmail.com>
 <ZRvJa1Hza1RS28+G@dhcp22.suse.cz> <CAJD7tkaOfsKC=F1inymxz8C0UT5=Sjo830bYLsoPd6WOOShyDQ@mail.gmail.com>
 <ZRvMTBEg4Vf63Uao@dhcp22.suse.cz>
In-Reply-To: <ZRvMTBEg4Vf63Uao@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 3 Oct 2023 01:49:19 -0700
Message-ID: <CAJD7tkZYd1u1s_s8hK4LHktWfPOFjPYdqhyXmsLEdY6KAeYuXA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: memcg: fix tracking of pending stats updates values
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 3, 2023 at 1:09=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Tue 03-10-23 01:03:53, Yosry Ahmed wrote:
> > On Tue, Oct 3, 2023 at 12:57=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Mon 25-09-23 10:11:05, Yosry Ahmed wrote:
> > > > On Mon, Sep 25, 2023 at 6:50=E2=80=AFAM Michal Hocko <mhocko@suse.c=
om> wrote:
> > > > >
> > > > > On Fri 22-09-23 17:57:38, Yosry Ahmed wrote:
> > > > > > While working on adjacent code [1], I realized that the values =
passed
> > > > > > into memcg_rstat_updated() to keep track of the magnitude of pe=
nding
> > > > > > updates is consistent. It is mostly in pages, but sometimes it =
can be in
> > > > > > bytes or KBs. Fix that.
> > > > >
> > > > > What kind of practical difference does this change make? Is it wo=
rth
> > > > > additional code?
> > > >
> > > > As explained in patch 2's commit message, the value passed into
> > > > memcg_rstat_updated() is used for the "flush only if not worth it"
> > > > heuristic. As we have discussed in different threads in the past fe=
w
> > > > weeks, unnecessary flushes can cause increased global lock contenti=
on
> > > > and/or latency.
> > > >
> > > > Byte-sized paths (percpu, slab, zswap, ..) feed bytes into the
> > > > heuristic, but those are interpreted as pages, which means we will
> > > > flush earlier than we should. This was noticed by code inspection. =
How
> > > > much does this matter in practice? I would say it depends on the
> > > > workload: how many percpu/slab allocations are being made vs. how m=
any
> > > > flushes are requested.
> > > >
> > > > On a system with 100 cpus, 25M of stat updates are needed for a flu=
sh
> > > > usually, but ~6K of slab/percpu updates will also (mistakenly) caus=
e a
> > > > flush.
> > >
> > > This surely depends on workload and that is understandable. But it wo=
uld
> > > be really nice to provide some numbers for typical workloads which
> > > exercise slab heavily.
> >
> > If you have a workload in mind I can run it and see how many flushes
> > we get with/without this patch. The first thing that pops into my head
> > is creating a bunch of empty files but I don't know if that's the best
> > thing to get numbers from.
>
> Let me remind you that you are proposing a performance optimization and
> such a change requires some numbers to actually show it is benefitial.
> There are cases where the resulting code is clearly an improvement and
> the performance benefit is just a nice side effect. I do not consider
> this to be the case. The whole thing is quite convoluted even without
> a better precision you are proposing. And let me be clear, I am not
> opposing your patch but I would rather see it based on more than just
> hand waving.

It is purely based on code inspection, and honestly I don't have
numbers to support it. I saw something wrong with the code and I tried
to fix it, I was working on something else when I noticed it. That
being said, I acknowledge it's not making the code any prettier :)

Feel free to suggest improvements to the code to make it more
bearable, otherwise if you don't like it I will just leave it to be
honest.

Thanks for taking a look!

> --
> Michal Hocko
> SUSE Labs
