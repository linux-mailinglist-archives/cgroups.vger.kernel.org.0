Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542261AF233
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2020 18:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgDRQSD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Apr 2020 12:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgDRQSD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Apr 2020 12:18:03 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E9CC061A0C
        for <cgroups@vger.kernel.org>; Sat, 18 Apr 2020 09:18:03 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m2so4316781lfo.6
        for <cgroups@vger.kernel.org>; Sat, 18 Apr 2020 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z4OTNUJkzQtYUty1sAa6R81HMXYdIuuIp9Q+IqWjDtA=;
        b=NXZvRArVIZGm0xOMHJ1AxybeCL5vwEl7QGKrNf5KPO4fo/pLYoqHTrS+QYklCrr/tJ
         kjmK52K679KLevGapTyPPSjNgma/HF5WRfjVY1kMECVHYitPVWUMuoVn50ijtVyavVUK
         +1oqBVnAmjI/tVx8jbW4O3g4rs9jNbTqFetSVxQEjs5232HwDkp26HInIOsF4whyDjDS
         alyNAAT1cntk9I75q4GJ1fDeCBLD4CQeiOom9OLWsa+Rpo6Q+rpuVHnmGbRPMcSVI6HU
         22r4lWdGBKNm9/AUcT+o+ZlpH3uU4XFQz+tRxacIbbFJRhnf2SISVeo0Vx1bttX/VUyJ
         tt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z4OTNUJkzQtYUty1sAa6R81HMXYdIuuIp9Q+IqWjDtA=;
        b=MYBThOf71RCkuFALifeJpVIrn2kJEyEyt42WaQqBMMp/XppqcgcYLWqRvt+jV3JPnm
         hrILnrwzCJHsNF6L8PVCK2yIR8IuT4H+uMxknxTs5IoITPM8+IzmAx3N0Vx+VM+MxY6q
         TARmoobzOeepiiGXOrv/yIh2PIkXSdiJVEjs6s9wRqHAbSZCXI62GsX/vRqC0NRJC1VF
         9CRBhqH2cQnd5pjrRlPrAjlKyNbBv5TajhbOkZrM8nY1kt17+elM1P9zQ4qDTTjQVNya
         u8hNgN9qj2G1XO8N7OHXOryZnMe5ol8M6GWjSEh5aiwj7RGIwqkUasWehISN/81zd0bj
         XTaw==
X-Gm-Message-State: AGi0PuY95A6wxx0YQLveTP25d+OLFeSnnVgsoIV01ArLhgOz96HD626E
        abLafU9DmtApgoTWaiqSM1YIROwb927liLlcxmA27Y0O
X-Google-Smtp-Source: APiQypJIyZ3j5vmsp3fSr0Pr+YmBi9i1LK4GRlc5vUqryl2lPjuK/9v4ZdtzK52kZiG5AyJxiCs41FYPVrrKRZnOCWY=
X-Received: by 2002:a19:5206:: with SMTP id m6mr5272610lfb.33.1587226681359;
 Sat, 18 Apr 2020 09:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <1587134624-184860-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200417155317.GS26707@dhcp22.suse.cz> <CALvZod7Xa4Xs=7zC8OZ7GOfvfDBv+yNbGCzBxeoMgAeRGRtw0A@mail.gmail.com>
 <20200417165442.GT26707@dhcp22.suse.cz> <caa13db1-3094-0aae-bfb9-c3534949fa21@linux.alibaba.com>
In-Reply-To: <caa13db1-3094-0aae-bfb9-c3534949fa21@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 18 Apr 2020 09:17:50 -0700
Message-ID: <CALvZod4vwjLjgF0wWPmZK5uD2kiea+JQtAU284gD0jEuXb0LQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] memcg: folding CONFIG_MEMCG_SWAP as default
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Apr 18, 2020 at 6:45 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
>
>
> =E5=9C=A8 2020/4/18 =E4=B8=8A=E5=8D=8812:54, Michal Hocko =E5=86=99=E9=81=
=93:
> > On Fri 17-04-20 09:41:04, Shakeel Butt wrote:
> >> On Fri, Apr 17, 2020 at 9:03 AM Michal Hocko <mhocko@kernel.org> wrote=
:
> >>>
> >>> On Fri 17-04-20 22:43:43, Alex Shi wrote:
> >>>> This patch fold MEMCG_SWAP feature into kernel as default function. =
That
> >>>> required a short size memcg id for each of page. As Johannes mention=
ed
> >>>>
> >>>> "the overhead of tracking is tiny - 512k per G of swap (0.04%).'
> >>>>
> >>>> So all swapout page could be tracked for its memcg id.
> >>>
> >>> I am perfectly OK with dropping the CONFIG_MEMCG_SWAP. The code that =
is
> >>> guarded by it is negligible and the resulting code is much easier to
> >>> read so no objection on that front. I just do not really see any real
> >>> reason to flip the default for cgroup v1. Why do we want/need that?
> >>>
> >>
> >> Yes, the changelog is lacking the motivation of this change. This is
> >> proposed by Johannes and I was actually expecting the patch from him.
> >> The motivation is to make the things simpler for per-memcg LRU locking
> >> and workingset for anon memory (Johannes has described these really
> >> well, lemme find the email). If we keep the differentiation between
> >> cgroup v1 and v2, then there is actually no point of this cleanup as
> >> per-memcg LRU locking and anon workingset still has to handle the
> >> !do_swap_account case.
> >
> > All those details really have to go into the changelog. I have to say
> > that I still do not understand why the actual accounting swap or not
> > makes any difference for per per-memcg LRU. Especially when your patch
> > keeps the kernel command line parameter still in place.
> >
> > Anyway, it would be much more simpler to have a patch that drops the
> > CONFIG_MEMCG_SWAP and a separate one which switches the default
> > beahvior. I am not saying I am ok with the later but if the
> > justification is convincing then I might change my mind.
> >
>
> Hi Shakeel & Michal,
>
> Thanks for all comments!
>
> Yes, we still need to remove swapaccount from cmdline and keep swap_cgrou=
p.id
> permanently. Just I don't know if this patch could fit into the details o=
f
> Johannes new solution.
>
> Anyway, I will send out v2 for complete memcg id record patch, just in ca=
se
> if they are useful.
>

I would recommend waiting for Johannes patch series. The cleanup this
patch is doing makes more sense to be part of Johannes's lrucare
cleanup series.

thanks,
Shakeel
