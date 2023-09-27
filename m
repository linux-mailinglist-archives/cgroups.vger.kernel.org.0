Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015AA7B0AFC
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 19:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjI0RXI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 13:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjI0RXH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 13:23:07 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525ABA1;
        Wed, 27 Sep 2023 10:23:06 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fe87cd74eso104219139f.3;
        Wed, 27 Sep 2023 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695835385; x=1696440185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITQru/E0afH4eUP13Yo8ylvgWGIZ/FGUSo6bojPrfr8=;
        b=f+NknJndaoziuDw8F39Uo5GtbgvIs76z7UPFZPBApPTRvoL347uP0FRvFOfOehPWg5
         IDi7xoOUPMf/ELDFGYLbihUmRdhxjMcV92w1xSP5c7KuUQ3M4NET4GOt+hV80SZHoUCc
         86GB0wVTkaJo44e8AtRnPk8XLgCl8rwgt8Xncbq8Vi0uZ221l7BEjgkFSz/FPZ597dGR
         Cc3UTuK7Wqkft0zcATivdS2rYwd10yd/cgQHb306PWl7QvKz1jKo4vTeaAS0hKqw6mO7
         /mBRIDlec7fmWnIKmOZW7fFm6Y8AOCxJJc+LUWk6JiwnrwqkCddFQadwA74Ol4pu1j1f
         FWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695835385; x=1696440185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITQru/E0afH4eUP13Yo8ylvgWGIZ/FGUSo6bojPrfr8=;
        b=B7ZdZApfBgUt3GooHeb8K/EV6Iw7HOGoWXiiiNiwYKASyuc8Z8kkWWG4w7bffZ1R+v
         nNJOfhIxw4YZM2jsjmS9Za5lHHKGcs+0uvdIudWThj35iXZLZMCS70LTJ/r+xJeViG/W
         pw/VApbbAEBiBABqT3Z2kNU1vIYxj5K8fZuv5SQKCnTO0DW9NPzIDNeA6V8kJwvGYV2U
         Lix1RrmHBNnH7Vc20ZypkE+h9RkJRDrtKuinmMQ0YOV+LJPAyjwY6NaSI+XfLzSjgtQm
         L1LLWKYVdY91cBK2GI9rQXiKV99cUfgjrObA8TjfV1cqu2ho62HxVdsX2WghNUNt7yK0
         q4RQ==
X-Gm-Message-State: AOJu0YzsrvvtUtG2v/xmYbT7fvNu7diOLC4mVYjWWWlO6HX+NpU9S49F
        uAblA9EKli1xOcIpDdLkPG6PwnBQ6jGCrs/ds8I=
X-Google-Smtp-Source: AGHT+IELucLgfpevu8e20YGpQ2B1sf+MJt22Q/LCtXTXOAXfKnYqkMCOV1D+lNvNhmRGx9P+8C8rdTpyTGM3bzDSJXU=
X-Received: by 2002:a6b:d00d:0:b0:798:3e95:274f with SMTP id
 x13-20020a6bd00d000000b007983e95274fmr2549080ioa.19.1695835385557; Wed, 27
 Sep 2023 10:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194949.2637078-1-nphamcs@gmail.com> <CAPTztWY8eDSa1qKx35hTm5ef+e13SDnRHDrevc-1V1v7-pEP3w@mail.gmail.com>
 <20230926221414.GD348484@cmpxchg.org> <ZRQlAgDs5W/Lct4k@dhcp22.suse.cz> <20230927164430.GB365513@cmpxchg.org>
In-Reply-To: <20230927164430.GB365513@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 27 Sep 2023 10:22:54 -0700
Message-ID: <CAKEwX=Ocm_Zn=3P0gBdJKSwyqWq3fX37OEGAjCA5vKgJb+QGvw@mail.gmail.com>
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Frank van der Linden <fvdl@google.com>,
        akpm@linux-foundation.org, riel@surriel.com,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 27, 2023 at 9:44=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Sep 27, 2023 at 02:50:10PM +0200, Michal Hocko wrote:
> > On Tue 26-09-23 18:14:14, Johannes Weiner wrote:
> > [...]
> > > The fact that memory consumed by hugetlb is currently not considered
> > > inside memcg (host memory accounting and control) is inconsistent. It
> > > has been quite confusing to our service owners and complicating thing=
s
> > > for our containers team.
> >
> > I do understand how that is confusing and inconsistent as well. Hugetlb
> > is bringing throughout its existence I am afraid.
> >
> > As noted in other reply though I am not sure hugeltb pool can be
> > reasonably incorporated with a sane semantic. Neither of the regular
> > allocation nor the hugetlb reservation/actual use can fallback to the
> > pool of the other. This makes them 2 different things each hitting thei=
r
> > own failure cases that require a dedicated handling.
> >
> > Just from top of my head these are cases I do not see easy way out from=
:
> >       - hugetlb charge failure has two failure modes - pool empty
> >         or memcg limit reached. The former is not recoverable and
> >         should fail without any further intervention the latter might
> >         benefit from reclaiming.
> >       - !hugetlb memory charge failure cannot consider any hugetlb
> >         pages - they are implicit memory.min protection so it is
> >           impossible to manage reclaim protection without having a
> >           knowledge of the hugetlb use.
> >       - there is no way to control the hugetlb pool distribution by
> >         memcg limits. How do we distinguish reservations from actual
> >         use?
> >       - pre-allocated pool is consuming memory without any actual
> >         owner until it is actually used and even that has two stages
> >         (reserved and really used). This makes it really hard to
> >         manage memory as whole when there is a considerable amount of
> >         hugetlb memore preallocated.
>
> It's important to distinguish hugetlb access policy from memory use
> policy. This patch isn't about hugetlb access, it's about general
> memory use.
>
> Hugetlb access policy is a separate domain with separate
> answers. Preallocating is a privileged operation, for access control
> there is the hugetlb cgroup controller etc.
>
> What's missing is that once you get past the access restrictions and
> legitimately get your hands on huge pages, that memory use gets
> reflected in memory.current and exerts pressure on *other* memory
> inside the group, such as anon or optimistic cache allocations.
>
> Note that hugetlb *can* be allocated on demand. It's unexpected that
> when an application optimistically allocates a couple of 2M hugetlb
> pages those aren't reflected in its memory.current. The same is true
> for hugetlb_cma. If the gigantic pages aren't currently allocated to a
> cgroup, that CMA memory can be used for movable memory elsewhere.
>
> The points you and Frank raise are reasons and scenarios where
> additional hugetlb access control is necessary - preallocation,
> limited availability of 1G pages etc. But they're not reasons against
> charging faulted in hugetlb to the memcg *as well*.
>
> My point is we need both. One to manage competition over hugetlb,
> because it has unique limitations. The other to manage competition
> over host memory which hugetlb is a part of.
>
> Here is a usecase from our fleet.
>
> Imagine a configuration with two 32G containers. The machine is booted
> with hugetlb_cma=3D6G, and each container may or may not use up to 3
> gigantic page, depending on the workload within it. The rest is anon,
> cache, slab, etc. You set the hugetlb cgroup limit of each cgroup to
> 3G to enforce hugetlb fairness. But how do you configure memory.max to
> keep *overall* consumption, including anon, cache, slab etc. fair?
>
> If used hugetlb is charged, you can just set memory.max=3D32G regardless
> of the workload inside.
>
> Without it, you'd have to constantly poll hugetlb usage and readjust
> memory.max!

Yep, and I'd like to add that this could and have caused issues in
our production system, when there is a delay in memory limits
(low or max) correction. The userspace agent in charge of correcting
these only runs periodically, and within consecutive runs the system
could be in an over/underprotected state. An instantaneous charge
towards the memory controller would close this gap.

I think we need both a HugeTLB controller and memory controller
accounting.
