Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCDC2749BA
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIVUDC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVUDC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 16:03:02 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D004C061755;
        Tue, 22 Sep 2020 13:03:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o8so24607139ejb.10;
        Tue, 22 Sep 2020 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ux/FWhUKlfKba4R9gSVXh2d9U57fEhQO969QMh4dk+k=;
        b=gQf7T+W348/cUa7xWPDW9mvfpBriiULeP1ZiFwI/jDSAJXi3GsqBEJgVzaZkuZ3KCN
         DAYlg61fYR1XNjaNGtmQGHh+hKXwEWxOJ2n9Ghee/kUzRlnQLH4Zeu/fTNenx15m6XXp
         FX71AJvEK80xn0Xkbrrlt/6VoGll00mpOfki/B1Ag5oQTK/iMuyJLByVfKQai4xyvfj0
         6cq+Fp5kLtWHQ1iy4C4sDrTPsNplpHsgHhuCGhzzQTpVKI0kxMIqTs4NYwGmwWMehVua
         LE3pRNdZ19xyq6AwCiTwJBamQsck+Xhems9XXbzyJSxo7b4G4hWnCHQ+KzCpyQTnyven
         0LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ux/FWhUKlfKba4R9gSVXh2d9U57fEhQO969QMh4dk+k=;
        b=N+2KpZLN+5mB2r2CVLvgX29NKSq4cFmCKw3En9MlLy2gVt79c5YBCRXfmeFnCwMTQz
         SK/I3EK3fhChS2ounQCBU0V8PqwtV0I5qJc7MF9luUwIvuAsTAoknDMQdVDUAMK9Arym
         mBvicK9DTvGjxykBddhOAecy+lethJrVZzFIs6hp0bJSOcXd2O5OBON20+iIFnUVU8tG
         PUxkSLJAQLE3DtyVgtyXd5iAX7nxt3hfRdH+pza9uiRcqgUSkSVebGH6IrLJty7X5uEU
         QdF85RqYnFS/eWA+axAL+Gv68QgX1cCJ4kAEkXOLIYIbRv4ANJzzE+FW/tNvxYnvyItp
         XAVQ==
X-Gm-Message-State: AOAM530eYeqcujeIgTuo38XUxtdDlZlcf4qf1sG/h0fUv5hkQJgHE1mM
        xW/p+dbpI9RULXPr+3JD0wc9Yw+DHh9HKudM1xo=
X-Google-Smtp-Source: ABdhPJzrukxcqBwmPMNwZEfjF9bZU4xr+6NJgA7Fjwt063EvqbKJpTcRE4M8HENKWwjen25q8n7in1Ofle1X8HiQuYQ=
X-Received: by 2002:a17:906:fb8f:: with SMTP id lr15mr6669776ejb.25.1600804980354;
 Tue, 22 Sep 2020 13:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200909215752.1725525-1-shakeelb@google.com> <20200921163055.GQ12990@dhcp22.suse.cz>
 <CALvZod43VXKZ3StaGXK_EZG_fKcW3v3=cEYOWFwp4HNJpOOf8g@mail.gmail.com>
 <20200922114908.GZ12990@dhcp22.suse.cz> <CALvZod4FvE12o53BpeH5WB_McTdCkFTFXgc9gcT1CEHXzQLy_A@mail.gmail.com>
 <20200922165527.GD12990@dhcp22.suse.cz> <CALvZod7K9g9mi599c5+ayLeC4__kckv155QQGVMVy2rXXOY1Rw@mail.gmail.com>
 <20200922190859.GH12990@dhcp22.suse.cz>
In-Reply-To: <20200922190859.GH12990@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 22 Sep 2020 13:02:47 -0700
Message-ID: <CAHbLzkoBRAEWeDAh8Hd+3kNUMVUr-L79m4fpXoeez0wkBqUYxw@mail.gmail.com>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

This is exactly how our "per-memcg kswapd" works. The missing piece is
how to account the background worker (it is a kernel work thread)
properly as what we discussed before. You mentioned such work is WIP
in earlier email of this thread, I think once this is done the
per-memcg background worker could be supported easily.

>
> If we do not want to change the existing semantic of high and want a new
> api then I think having another limit for the background reclaim then
> that would make more sense to me. It would resemble the global reclaim
> and kswapd model and something that would be easier to reason about.
> Comparing to echo $N > reclaim which might mean to reclaim any number
> pages around N.
> --
> Michal Hocko
> SUSE Labs
