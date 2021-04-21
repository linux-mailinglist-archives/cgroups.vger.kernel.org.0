Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4460B366CC4
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbhDUN1Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 09:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbhDUN1Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Apr 2021 09:27:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4481C06138A
        for <cgroups@vger.kernel.org>; Wed, 21 Apr 2021 06:26:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n138so66983022lfa.3
        for <cgroups@vger.kernel.org>; Wed, 21 Apr 2021 06:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZywKeowOaZ5VjiR6Xyl1lA10hFbmQYAWAA2LZ4rnjYw=;
        b=CK1O++Mtfpi16+3yujCdkCfBGjU4sVfzcD13bBfsUdBy4QfY5X0LGDdVSJi7h59uGE
         CAbgTBgagVouDpUaWZMzdF9CN6uKvmqX57EAYp9CPdLIm2iwV3lrOhiMPNnXnS1UAc3U
         VOjJ9diIXc6gRimHPoCeH9Hiqca0KFQ/WE/zg2xuxmv7LyUlzY+T+aZvjN/dULKrWWGN
         AtQZCyKcPiVpNk7gB9XIYbHiTdQe2wVPftF0ZEMKDc8lqANKKd2tbwSEwcHIzZdonz3B
         mcNDmd8/vG/gsoS8jfvtZABzkpzTRy1JgaOM1Emh/D0bKwhc4dtv2LM7QlFYVIRXeY3A
         Ulog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZywKeowOaZ5VjiR6Xyl1lA10hFbmQYAWAA2LZ4rnjYw=;
        b=CHiaVZalYPuyBrS6KeT7n/OdSzOAi8B54bpmvTxkuCButEOTCzsXVYzpjJhT8XbWJ9
         cYZUkcx3bAj2vaXxtvduhCYzXHOfDhYjk0VMkfuCOIqYsxJtkGJy2XwGDtTEXlMO7cud
         0wzqfkHDxkXR/+sV3692fjj9os3qrwIXvBPBkP5j0wmXRx4hYCLdr78KMgOXLzLshf1G
         74/c3my9qfqCsdQZh/2md9Asszqe36xlgX9mhHcUnXOIbBRbH3klQchY0QMfJoEwNhNJ
         UZnO3CjM2AtfR7VnKHms65aZGs9vycutejjijrWVLJYvaEKSgoFSz0NertUzKjTI4kmL
         RovA==
X-Gm-Message-State: AOAM530PaIiVVPh/U1BLo6fTN4A+3TwUEnpMUTyM674fyXj+4OojRZr9
        S4KEuzcwp99QDUnRBGaiiBlqtLISHwU7qbeVueBnVw==
X-Google-Smtp-Source: ABdhPJxOMLDAmh/+OEeo8HE3aBbSOrP23NrZqB40yujPGlQ1kz99f3Qw13cMpn/RLMC5fZO5jwg4a6o5Pylj2lXp574=
X-Received: by 2002:a05:6512:2037:: with SMTP id s23mr19213599lfs.358.1619011608927;
 Wed, 21 Apr 2021 06:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH8o5iIau85FaeLw@carbon.DHCP.thefacebook.com> <CALvZod7dXuFPeMv5NGu96uCosFpWY_Gy07iDsfSORCA0dT_zsA@mail.gmail.com>
 <YH+U4X8PKWZpOpAA@carbon.dhcp.thefacebook.com>
In-Reply-To: <YH+U4X8PKWZpOpAA@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 21 Apr 2021 06:26:37 -0700
Message-ID: <CALvZod7x=QR=p73BAxWPbFm+V8KFwYCcxNp-bOBvGaAttxjm7g@mail.gmail.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 20, 2021 at 7:58 PM Roman Gushchin <guro@fb.com> wrote:
>
[...]
> >
> > Michal has suggested ALLOC_OOM which is less risky.
>
> The problem is that even if you'll serve the oom daemon task with pages
> from a reserve/custom pool, it doesn't guarantee anything, because the task
> still can wait for a long time on some mutex, taken by another process,
> throttled somewhere in the reclaim.

I am assuming here by mutex you are referring to locks which
oom-killer might have to take to read metrics or any possible lock
which oom-killer might have to take which some other process can take
too.

Have you observed this situation happening with oomd on production?

> You're basically trying to introduce a
> "higher memory priority" and as always in such cases there will be priority
> inversion problems.
>
> So I doubt that you can simple create a common mechanism which will work
> flawlessly for all kinds of allocations, I anticipate many special cases
> requiring an individual approach.
>
[...]
>
> First, I need to admit that I didn't follow the bpf development too close
> for last couple of years, so my knowledge can be a bit outdated.
>
> But in general bpf is great when there is a fixed amount of data as input
> (e.g. skb) and a fixed output (e.g. drop/pass the packet). There are different
> maps which are handy to store some persistent data between calls.
>
> However traversing complex data structures is way more complicated. It's
> especially tricky if the data structure is not of a fixed size: bpf programs
> have to be deterministic, so there are significant constraints on loops.
>
> Just for example: it's easy to call a bpf program for each task in the system,
> provide some stats/access to some fields of struct task and expect it to return
> an oom score, which then the kernel will look at to select the victim.
> Something like this can be done with cgroups too.
>
> Writing a kthread, which can sleep, poll some data all over the system and
> decide what to do (what oomd/... does),  will be really challenging.
> And going back, it will not provide any guarantees unless we're not taking
> any locks, which is already quite challenging.
>

Thanks for the info and I agree this direction needs much more thought
and time to be materialized.

thanks,
Shakeel
