Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9C13376A4
	for <lists+cgroups@lfdr.de>; Thu, 11 Mar 2021 16:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhCKPPN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Mar 2021 10:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhCKPO7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Mar 2021 10:14:59 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D41C061574
        for <cgroups@vger.kernel.org>; Thu, 11 Mar 2021 07:14:59 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f1so40360969lfu.3
        for <cgroups@vger.kernel.org>; Thu, 11 Mar 2021 07:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CelhTZTNo0tbpqSt2Sqgz71NShqrngcVDLph+CUo5CY=;
        b=gD/OAtHHjk1a+K+VhVVssr/6+LSb2m7YfCWg6rrdG2i8Trb1elLbsNJNtE4qJ4tbnl
         a+K0lhsiZb/SUdZRzOQdHoNwYrlyT6MU5rCYFX0ENyGUdmjTtlGsnG4LpUkdWWswAdXF
         NkMpSo4pdUGuh2spZF3FNOfKpXgga0EeRoeF4I7evS6n1/2vJCs4xZmNyITsVUfCzmmb
         xeieIb1wz2paeWPSThNMWAydadH+f6hyH47u6cP3swA6Va+axYIdl3pJ/3n7Jes9zcTr
         VncnHI9qhkYghY7yNzEW6n/CpCGsOQieTzlmnCuO1oVHMnCTwy/dfrbcl/LDPP6R7z3Z
         0jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CelhTZTNo0tbpqSt2Sqgz71NShqrngcVDLph+CUo5CY=;
        b=He3oTZxr4a+4uiGY1039C/5A1cRg9USp9CMTo/NeGGqXKA+JnFm+kCKOgbOS5nuVBO
         aXdCIZ2rGIuIO3HujF2qTCU/8blGCerAqgM73Rs/WSTpUiluz9tmXd/3GeeU7bjLrDTW
         VBVNrZQdw6o75RRLBg+ocXz/paqr50A/w8pLUbLO2rRE/ZUMTXMdMcvgQbnSa1pKMO4M
         gzd+A41nz70H299zATxlwh8UZaxseOdm5iwcXWAgrOjTsZIKtcO24bSP3aLNh+ITK/SE
         MTHrfyrWWzgqprLy7WymekD7CIfApAb25stRzfkpE7WP2dVge9tmdbDjEvFHIZyb6byD
         +kIw==
X-Gm-Message-State: AOAM533w8bOlGryAqZA8nWvZRdeg5lvc8eBy9OjQmxZjQ5H1bOmuA9tt
        JQtwv0AVfBWaHaB7BSpbn0ZcFPeQhO1MWcv36n2TZA==
X-Google-Smtp-Source: ABdhPJyCLMLr/TnwzGAp6VToQf4LEk9+TSoYqjrRZUAg7/4gpPCA1hnLHCrGhPspDgSwZiCnOfU3j0ZUTBbEDkB1+U4=
X-Received: by 2002:a19:ee19:: with SMTP id g25mr2457540lfb.83.1615475697434;
 Thu, 11 Mar 2021 07:14:57 -0800 (PST)
MIME-Version: 1.0
References: <5affff71-e503-9fb9-50cb-f6d48286dd52@virtuozzo.com>
 <CALvZod5YOtqXcSqn2Zj2Nb_SKgDRKOMW4o5i-u_yj7CanQVtGQ@mail.gmail.com>
 <ad68d004-fa84-3d21-60b7-d4a342ad4007@virtuozzo.com> <YEiiQ2TGnJcEtL3d@dhcp22.suse.cz>
 <24a416f7-9def-65c9-599e-d56f7c328d33@virtuozzo.com>
In-Reply-To: <24a416f7-9def-65c9-599e-d56f7c328d33@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 11 Mar 2021 07:14:45 -0800
Message-ID: <CALvZod5hHp-M=+BD8joLmzfRcj9v_sxLReyA=gAp9gVTffy-mQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] memcg accounting from OpenVZ
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@suse.com>, Cgroups <cgroups@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 10, 2021 at 11:00 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> On 3/10/21 1:41 PM, Michal Hocko wrote:
> > On Wed 10-03-21 13:17:19, Vasily Averin wrote:
> >> On 3/10/21 12:12 AM, Shakeel Butt wrote:
> >>> On Tue, Mar 9, 2021 at 12:04 AM Vasily Averin <vvs@virtuozzo.com> wrote:
> >>>>
> >>>> OpenVZ many years accounted memory of few kernel objects,
> >>>> this helps us to prevent host memory abuse from inside memcg-limited container.
> >>>
> >>> The text is cryptic but I am assuming you wanted to say that OpenVZ
> >>> has remained on a kernel which was still on opt-out kmem accounting
> >>> i.e. <4.5. Now OpenVZ wants to move to a newer kernel and thus these
> >>> patches are needed, right?
> >>
> >> Something like this.
> >> Frankly speaking I badly understand which arguments should I provide to upstream
> >> to enable accounting for some new king of objects.
> >>
> >> OpenVZ used own accounting subsystem since 2001 (i.e. since v2.2.x linux kernels)
> >> and we have accounted all required kernel objects by using our own patches.
> >> When memcg was added to upstream Vladimir Davydov added accounting of some objects
> >> to upstream but did not skipped another ones.
> >> Now OpenVZ uses RHEL7-based kernels with cgroup v1 in production, and we still account
> >> "skipped" objects by our own patches just because we accounted such objects before.
> >> We're working on rebase to new kernels and we prefer to push our old patches to upstream.
> >
> > That is certainly an interesting information. But for a changelog it
> > would be more appropriate to provide information about how much memory
> > user can induce and whether there is any way to limit that memory by
> > other means. How practical those other means are and which usecases will
> > benefit from the containment.
>
> Right now I would like to understand how should I argument my requests about
> accounting of new kind of objects.
>
> Which description it enough to enable object accounting?
> Could you please specify some edge rules?
> Should I push such patches trough this list?
> Is it probably better to send them to mailing lists of according subsystems?
> Should I notify them somehow at least?
>
> "untrusted netadmin inside memcg-limited container can create unlimited number of routing entries, trigger OOM on host that will be unable to find the reason of memory  shortage and  kill huge"
>
> "each mount inside memcg-limited container creates non-accounted mount object,
>  but new mount namespace creation consumes huge piece of non-accounted memory for cloned mounts"
>
> "unprivileged user inside memcg-limited container can create non-accounted multi-page per-thread kernel objects for LDT"
>
> "non-accounted multi-page tty objects can be created from inside memcg-limited container"
>
> "unprivileged user inside memcg-limited container can trigger creation of huge number of non-accounted fasync_struct objects"
>

I think the above reasoning is good enough. Just resend your patches
with the corresponding details.
