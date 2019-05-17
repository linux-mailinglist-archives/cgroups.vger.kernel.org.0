Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A010A218BA
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2019 15:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfEQNAb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 09:00:31 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35399 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbfEQNAa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 May 2019 09:00:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id k128so489826ywf.2
        for <cgroups@vger.kernel.org>; Fri, 17 May 2019 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1Yjx9G9Kz0lAC4Y66vJlqEx5sunA3IfD/gaYb8FYZg=;
        b=MFTlhXiTud3V1AxxK2rZ5o5zpilyu81HAboG8GjjYlTyRXOAGY+30B+tlGH/9k5QK6
         ooVhXJWOGpXm2w0ayEc3NzoZrx+FCfNv3raolPiPxi58q6nIgYJEHqWmXEQ5tHS4DwE+
         XsOCMusbwFDKhP1yrjwO7HnGDj5jD0D1p+Ucw/m3scGKT60QjoxsSnvXR1dccOZkZd4+
         M+YQD+Ry0gv1Weoql/hAMb9EaW5YLu2LFgL/SIFFNrykQ4cF8aSCtrf3E4fqvlbwxEyF
         T1rgPtWgEcFYMISlUJW0eKCR4iuLcj8t5EBLTXGlj9WTNGMhVWKTVgg4GhaV/5XfrNit
         Wc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1Yjx9G9Kz0lAC4Y66vJlqEx5sunA3IfD/gaYb8FYZg=;
        b=hYus5F088C2zzRGC8i2snkIV8GZMmUZVEqy62a5qcYCbJ8eCJhXXIoLVZDih1Kvwgm
         5fNHLlZby/Wg63GPPj6ge6lJRypCKrgvSGKt+7fwDOSUbFQKgnTgWtjXEVnUQm8BnhvS
         7PvAFrbMCsTNKpUtDpQ8QQt6rvSZkjycJOjnv+tZgBaBVF5hoyKyk4J9rHRHiYrGxNlm
         K1Pw7lcbIoJf6aOVk3r033TXvCLMfLO49+ArDn9iU4iM6rK4pgP1R+3y5bg3oisT9Qn8
         w0+PetAblLydXSwfqtAffo/dpFhkZUk9lLYY8lwqwUbql3dRDDC+3l5UwRiXGZgjD4iC
         byTg==
X-Gm-Message-State: APjAAAWgKbbWTjBa9xcYQWSfZZmz2OcGCs0HeWMf+48kHad1kSxwiT1Z
        O4ddH9QKcGhztdZx/6vTsdPxmg7oWgEKUuU7adTf7w==
X-Google-Smtp-Source: APXvYqy3YDHyKFiBF5MyJ5W3EVNngA6meDmel8s+TXbnXyXy5tgKxYfP/M3jWgeR37q9rAiyPOS/NvUTJrKLZl67WCA=
X-Received: by 2002:a81:5ec3:: with SMTP id s186mr27762147ywb.308.1558098029521;
 Fri, 17 May 2019 06:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190212224542.ZW63a%akpm@linux-foundation.org>
 <20190213124729.GI4525@dhcp22.suse.cz> <20190516175655.GA25818@cmpxchg.org>
 <20190516180932.GA13208@dhcp22.suse.cz> <20190516193943.GA26439@cmpxchg.org> <20190517123310.GI6836@dhcp22.suse.cz>
In-Reply-To: <20190517123310.GI6836@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 May 2019 06:00:18 -0700
Message-ID: <CALvZod6xErQ3AA+9oHSqB2bqtK9gKk4T0iPoGPkufBiJALko1Q@mail.gmail.com>
Subject: Re: + mm-consider-subtrees-in-memoryevents.patch added to -mm tree
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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

On Fri, May 17, 2019 at 5:33 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 16-05-19 15:39:43, Johannes Weiner wrote:
> > On Thu, May 16, 2019 at 08:10:42PM +0200, Michal Hocko wrote:
> > > On Thu 16-05-19 13:56:55, Johannes Weiner wrote:
> > > > On Wed, Feb 13, 2019 at 01:47:29PM +0100, Michal Hocko wrote:
> [...]
> > > > > FTR: As I've already said here [1] I can live with this change as long
> > > > > as there is a larger consensus among cgroup v2 users. So let's give this
> > > > > some more time before merging to see whether there is such a consensus.
> > > > >
> > > > > [1] http://lkml.kernel.org/r/20190201102515.GK11599@dhcp22.suse.cz
> > > >
> > > > It's been three months without any objections.
> > >
> > > It's been three months without any _feedback_ from anybody. It might
> > > very well be true that people just do not read these emails or do not
> > > care one way or another.
> >
> > This is exactly the type of stuff that Mel was talking about at LSFMM
> > not even two weeks ago. How one objection, however absurd, can cause
> > "controversy" and block an effort to address a mistake we have made in
> > the past that is now actively causing problems for real users.
> >
> > And now after stalling this fix for three months to wait for unlikely
> > objections, you're moving the goal post. This is frustrating.
>
> I see your frustration but I find the above wording really unfair. Let me
> remind you that this is a considerable user visible change in the
> semantic and that always has to be evaluated carefuly. A change that would
> clearly regress anybody who rely on the current semantic. This is not an
> internal implementation detail kinda thing.
>
> I have suggested an option for the new behavior to be opt-in which
> would be a regression safe option. You keep insisting that we absolutely
> have to have hierarchical reporting by default for consistency reasons.
> I do understand that argument but when I weigh consistency vs. potential
> regression risk I rather go a conservative way. This is a traditional
> way how we deal with semantic changes like this. There are always
> exceptions possible and that is why I wanted to hear from other users of
> cgroup v2, even from those who are not directly affected now.
>
> If you feel so stronly about this topic and the suggested opt-in is an
> absolute no-go then you are free to override my opinion here. I haven't
> Nacked this patch.
>
> > Nobody else is speaking up because the current user base is very small
> > and because the idea that anybody has developed against and is relying
> > on the current problematic behavior is completely contrived. In
> > reality, the behavior surprises people and causes production issues.
>
> I strongly suspect users usually do not follow discussions on our
> mailing lists. They only come up later when something breaks and that
> is too late. I do realize that this makes the above call for a wider
> consensus harder but a lack of upstream bug reports also suggests that
> people do not care or simply haven't noticed any issues due to way how
> they use the said interface (maybe deeper hierarchies are not that
> common).
>

I suspect that FB is the only one using cgroup v2 in production and
others (data center) users are still evaluating/exploring. Also IMHO
the cgroup v2 users are on the bleeding edge. As new cgroup v2
features and controllers are added, the users either switch to latest
kernel or backport. That might be the reason no one objected. Also
none of the distribution has defaulted to v2 yet, so, not many
transparent v2 users yet.

Shakeel
