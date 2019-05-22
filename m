Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5B25D98
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2019 07:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbfEVFad (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 May 2019 01:30:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43280 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfEVFac (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 May 2019 01:30:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so389221wrr.10
        for <cgroups@vger.kernel.org>; Tue, 21 May 2019 22:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khAfVgyvdFpD+3BrbDMKT8RJLVGP4g3H+a67pFViOXc=;
        b=ZZ7LukV0216gLYaha22MBJ0hKw12PTjtcsOtESvqoFx2r8YXGyqNWCUCL45b1wedZD
         ZFNWVfSTZF3ZUou6Ksk4uYSJh+d2PC9HQrQiSG61+UoTKm1c9yaPNHD4fJTQWFZMRDO1
         pr1LvFbHpOEBHuWFtKevEqMDfMCiVnTOiK32GFFeU4bRc0EOQ9F0EUlN+nXzNlwHA2xB
         hQ+rsJCfg5ODxzSI7HUVjPStRo09JWJ9UWqRkFyoIqvsnPMHk9INdC3ytAPm5PWhOsph
         E3085FTjpiN+d9BzuykZ7awBQxQAum0qGAUnNW0nyIyMIH8p6w0wV2frQdhQNhhaStrI
         q/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khAfVgyvdFpD+3BrbDMKT8RJLVGP4g3H+a67pFViOXc=;
        b=N8BAVM7tv928QfBNAFr3qWOaA50L7X1KRKpA0zOLGNU9N9bWdxGf8+tOmdktuOI889
         EdcKZXTcq9EqTC2i3RF1n8sUNx80k6NL5FJ6/fvnelsdFZNhKf5r8kmizW6eemZ0jjP2
         TxU6BM0226SCT8HtZfirjhHm5cajeRdkeF6Zq7U4FwZCufKCnAFq+ofSKqaMW8PnRfX6
         zTAgGS2IbVowee9anoXS9f7Unud3KREnZoPOkQgWK0/zftVlaBgB8bKujq83ufrDON69
         Fz62qFIfo9vrSOR7fsaftRqkVn3B0joxvQ4McEQWCxMnmE1+9LtvrxZisEn5Pt7tH6of
         dc7A==
X-Gm-Message-State: APjAAAU8DourJa2+w3onHaS63j0rSG6dfwWpJ7edv90kDtcUnPIDA9pJ
        ULQ22iJoOiTwqFZCoPKdO/xmA/Oms4xOyRP9mobcK/cRFLc=
X-Google-Smtp-Source: APXvYqyHeIQKj0Z4wRld3Nv42dTU/iH3BbSC9pIZ0KcQpdW6gcf7eqXRf/Bm3IQyDDtmyAz5PGReJvK72TbhosnXntk=
X-Received: by 2002:adf:ab45:: with SMTP id r5mr26865834wrc.100.1558503029912;
 Tue, 21 May 2019 22:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190212224542.ZW63a%akpm@linux-foundation.org>
 <20190213124729.GI4525@dhcp22.suse.cz> <20190516175655.GA25818@cmpxchg.org>
 <20190516180932.GA13208@dhcp22.suse.cz> <20190516193943.GA26439@cmpxchg.org>
 <20190517123310.GI6836@dhcp22.suse.cz> <CALvZod6xErQ3AA+9oHSqB2bqtK9gKk4T0iPoGPkufBiJALko1Q@mail.gmail.com>
In-Reply-To: <CALvZod6xErQ3AA+9oHSqB2bqtK9gKk4T0iPoGPkufBiJALko1Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 21 May 2019 22:30:18 -0700
Message-ID: <CAJuCfpHW8ZM7OcHKjxAQWsXfrUDordtsKP2MT0oDTW5XxKb7Nw@mail.gmail.com>
Subject: Re: + mm-consider-subtrees-in-memoryevents.patch added to -mm tree
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 17, 2019 at 6:00 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Fri, May 17, 2019 at 5:33 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 16-05-19 15:39:43, Johannes Weiner wrote:
> > > On Thu, May 16, 2019 at 08:10:42PM +0200, Michal Hocko wrote:
> > > > On Thu 16-05-19 13:56:55, Johannes Weiner wrote:
> > > > > On Wed, Feb 13, 2019 at 01:47:29PM +0100, Michal Hocko wrote:
> > [...]
> > > > > > FTR: As I've already said here [1] I can live with this change as long
> > > > > > as there is a larger consensus among cgroup v2 users. So let's give this
> > > > > > some more time before merging to see whether there is such a consensus.
> > > > > >
> > > > > > [1] http://lkml.kernel.org/r/20190201102515.GK11599@dhcp22.suse.cz
> > > > >
> > > > > It's been three months without any objections.
> > > >
> > > > It's been three months without any _feedback_ from anybody. It might
> > > > very well be true that people just do not read these emails or do not
> > > > care one way or another.
> > >
> > > This is exactly the type of stuff that Mel was talking about at LSFMM
> > > not even two weeks ago. How one objection, however absurd, can cause
> > > "controversy" and block an effort to address a mistake we have made in
> > > the past that is now actively causing problems for real users.
> > >
> > > And now after stalling this fix for three months to wait for unlikely
> > > objections, you're moving the goal post. This is frustrating.
> >
> > I see your frustration but I find the above wording really unfair. Let me
> > remind you that this is a considerable user visible change in the
> > semantic and that always has to be evaluated carefuly. A change that would
> > clearly regress anybody who rely on the current semantic. This is not an
> > internal implementation detail kinda thing.
> >
> > I have suggested an option for the new behavior to be opt-in which
> > would be a regression safe option. You keep insisting that we absolutely
> > have to have hierarchical reporting by default for consistency reasons.
> > I do understand that argument but when I weigh consistency vs. potential
> > regression risk I rather go a conservative way. This is a traditional
> > way how we deal with semantic changes like this. There are always
> > exceptions possible and that is why I wanted to hear from other users of
> > cgroup v2, even from those who are not directly affected now.
> >
> > If you feel so stronly about this topic and the suggested opt-in is an
> > absolute no-go then you are free to override my opinion here. I haven't
> > Nacked this patch.
> >
> > > Nobody else is speaking up because the current user base is very small
> > > and because the idea that anybody has developed against and is relying
> > > on the current problematic behavior is completely contrived. In
> > > reality, the behavior surprises people and causes production issues.
> >
> > I strongly suspect users usually do not follow discussions on our
> > mailing lists. They only come up later when something breaks and that
> > is too late. I do realize that this makes the above call for a wider
> > consensus harder but a lack of upstream bug reports also suggests that
> > people do not care or simply haven't noticed any issues due to way how
> > they use the said interface (maybe deeper hierarchies are not that
> > common).
> >
>
> I suspect that FB is the only one using cgroup v2 in production and
> others (data center) users are still evaluating/exploring. Also IMHO
> the cgroup v2 users are on the bleeding edge. As new cgroup v2
> features and controllers are added, the users either switch to latest
> kernel or backport. That might be the reason no one objected. Also
> none of the distribution has defaulted to v2 yet, so, not many
> transparent v2 users yet.

In Android we are not using cgroups v2 yet (and that's why I was
refraining from commenting earlier), however when I was evaluating
them for future use I was disappointed that events do not propagate up
the hierarchy. One usecase that I was considering is to get a
notification when OOM kill happens. With cgroups v2 we would be forced
to use per-app hierarchy to avoid process migrations between memcgs
when an app changes its state (background/foreground). With such a
setup we would end up with many leaf cgroups. Polling each individual
leaf cgroup's memory.events file to detect OOM occurrence would
require lots of extra FDs registered with an epoll(). Having an
ability to poll a common parent cgroup to detect that one of the leafs
generated an OOM event would be way more frugal.
I realize this does not constitute a real-life usecase but hopefully
possible usecases can provide some value too.
Thanks,
Suren.

> Shakeel
>
