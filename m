Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D096274C31
	for <lists+cgroups@lfdr.de>; Wed, 23 Sep 2020 00:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIVWiQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 18:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVWiP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 18:38:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8B5C061755
        for <cgroups@vger.kernel.org>; Tue, 22 Sep 2020 15:38:15 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d15so19813888lfq.11
        for <cgroups@vger.kernel.org>; Tue, 22 Sep 2020 15:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kz1r3HryQXkqiHLbeEAR38DUzaGNclbO2eXYvZIA+ds=;
        b=PEveOPJ4f+0wPNEXIsHG8QLe8dbfpf8OdIEE6qNAO3XlrxzsUHAu74xNxac3EcBv9t
         dwEq57/jrqdVV/9aTw+Th/XfWtRdyXU6PKI3/dnPQxVV2LGqgvaOgOJv5OqTMymOVSsy
         WdVlHiF28s/uN7WlQsIHt0hHAcWAF+djM4/XWns9QU/+dfQwFJMwSDmyLmZV7LHrGHfL
         BkPhiggvEhn1Flrys0yzy4GOf3iZkydCMQmK9XKRAzArQmezqLJgaZaHSd34Ti50coa2
         Nv4uQ3TAP3SKcOC5xbevm8k2P32aTTvTD2nCMQbFnwfCjdFPsCm9OOKvfE/fxbqDL7s7
         2/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kz1r3HryQXkqiHLbeEAR38DUzaGNclbO2eXYvZIA+ds=;
        b=iB+KM1nig1pQGqNXYAYMVMR3a2AD/GvYdc70FVGbCjyhMAWcvPF/NW1ayjjVHEBuRW
         DypEXMpIlG/HZzuEIM5Ik6wAoHJTxdFI+roFOMw8bwkn+m9aTgx6Vb0BGZ2XCQ3TyP5R
         VWQ+H1wypUJASTxsyLcXOX2WR/mustEFakOZv2mE/4mEAgpC2vsWcaJQgCn74teqbqRk
         H8eWo85Upx8K513+GSH+FhTKxbzsDJ/glkaEMqdOJqmcd0aa8d/8D0PFIIR7hL2zm9ov
         qB2GJW45NNJdldY98FMBchZz0mdBBZM66BAhH5Hv9w1ZHsRkOhJS4DXxzGF7cLajTwQa
         sy2Q==
X-Gm-Message-State: AOAM530bm3hmMqacyKx3wIusD+gCBHUzm4IAVwl0IlrleJKyuT32+Pmo
        isw8TVTSCu8hoY/ObJQfd/xpVoik6EOaWKyT3WfEyA==
X-Google-Smtp-Source: ABdhPJwuNBY+V7rXksw9rccGS9KOhgYhQGlDxwn1zsa6nipKGdB1CZnNacLxI1SucX6x2HYPz3onbdDT2ECfYkUj9Ds=
X-Received: by 2002:a19:4084:: with SMTP id n126mr2186902lfa.54.1600814293613;
 Tue, 22 Sep 2020 15:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200909215752.1725525-1-shakeelb@google.com> <20200921163055.GQ12990@dhcp22.suse.cz>
 <CALvZod43VXKZ3StaGXK_EZG_fKcW3v3=cEYOWFwp4HNJpOOf8g@mail.gmail.com>
 <20200922114908.GZ12990@dhcp22.suse.cz> <CALvZod4FvE12o53BpeH5WB_McTdCkFTFXgc9gcT1CEHXzQLy_A@mail.gmail.com>
 <20200922165527.GD12990@dhcp22.suse.cz> <CALvZod7K9g9mi599c5+ayLeC4__kckv155QQGVMVy2rXXOY1Rw@mail.gmail.com>
 <20200922190859.GH12990@dhcp22.suse.cz>
In-Reply-To: <20200922190859.GH12990@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 22 Sep 2020 15:38:01 -0700
Message-ID: <CALvZod5fi51AHhhTCftDfzK-3duCuiJxH0MkGazVLxXkem=XpA@mail.gmail.com>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
To:     Michal Hocko <mhocko@suse.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 22, 2020 at 12:09 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 22-09-20 11:10:17, Shakeel Butt wrote:
> > On Tue, Sep 22, 2020 at 9:55 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > Last but not least the memcg
> > > background reclaim is something that should be possible without a new
> > > interface.
> >
> > So, it comes down to adding more functionality/semantics to
> > memory.high or introducing a new simple interface. I am fine with
> > either of one but IMO convoluted memory.high might have a higher
> > maintenance cost.
>
> One idea would be to schedule a background worker (which work on behalf
> on the memcg) to do the high limit reclaim with high limit target as
> soon as the high limit is reached. There would be one work item for each
> memcg. Userspace would recheck the high limit on return to the userspace
> and do the reclaim if the excess is larger than a threshold, and sleep
> as the fallback.
>
> Excessive consumers would get throttled if the background work cannot
> keep up with the charge pace and most of them would return without doing
> any reclaim because there is somebody working on their behalf - and is
> accounted for that.
>
> The semantic of high limit would be preserved IMHO because high limit is
> actively throttled. Where that work is done shouldn't matter as long as
> it is accounted properly and memcg cannot outsource all the work to the
> rest of the system.
>
> Would something like that (with many details to be sorted out of course)
> be feasible?
>

Well what about the proactive reclaim use-case? You are targeting only
uswapd/background-reclaim use-case.

> If we do not want to change the existing semantic of high and want a new
> api then I think having another limit for the background reclaim then
> that would make more sense to me. It would resemble the global reclaim
> and kswapd model and something that would be easier to reason about.
> Comparing to echo $N > reclaim which might mean to reclaim any number
> pages around N.
> --

I am not really against the approach you are proposing but "echo $N >
reclaim" allows more flexibility and enables more use-cases.
