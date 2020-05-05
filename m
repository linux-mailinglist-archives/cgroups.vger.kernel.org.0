Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555AF1C5A6D
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2020 17:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgEEPDb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 May 2020 11:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729470AbgEEPDb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 May 2020 11:03:31 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B826FC061A0F
        for <cgroups@vger.kernel.org>; Tue,  5 May 2020 08:03:30 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x73so1636315lfa.2
        for <cgroups@vger.kernel.org>; Tue, 05 May 2020 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5HI11tS+yKnZwbaq8TtL0vEO4XhsA9qTOxtb1zDBVc=;
        b=NedESV1mf2KEGbnGwBXjkNGi7R9SVO/NUVnBR/MIIA4ksHkYG9Y0BOJUSO7cPfF101
         DhqLvXmcnRAqIon/UhQwhmdhaRJTFMRbqv7rnUrFiiLplm7OYMLhdbiEBbtARuNhVV8D
         LTzgdGvjzWUJX1UQL/oIjMDuzzQetiMjcVkKOHZidnk7VXhouvnvChgf89k1EWSMWRjT
         FhIwRnMbbr/4G57qwJzkX9wXI0g0aGrRDYcsPodwxKY6npl93JABKfVo0PFuu+LIkLAx
         gWRTkTusvXUAXg8/Xmo6bq3CqbG9PEAZT5/liY82/n294mGhWG9jm1kwV8U5Yd9K6Gur
         9WEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5HI11tS+yKnZwbaq8TtL0vEO4XhsA9qTOxtb1zDBVc=;
        b=OYw0Uq2vVMEBRAXuRmbJS+2PfD5uRz6Qf8nkse9QqxZ55Tdr+WerP840dXDIasA7LU
         9oSyMpxY14whiw61SHNMYrMzV9mL34oWgYliiN+srkvlWWEt5hDfH42Mk1/wzigmOYKI
         bq+mibOfnUhu2kq7x6zXz1br04uCIHrWWSVJAHZP0dUBT2BTzKA+imIgel8ron6XshwK
         sjhjTu+nCo+3K6YS18ES6tNyZwngnyJktlx4k3aprzEPmFJTHtT+NZ+0h8aiHEKnTu0v
         YCpy2UYJygH2mAuj5DNJig16qpfPeMXaqr3p/1tgvtgPZXDq8xomPwtfLE7bxLr+Ti9Y
         4bEw==
X-Gm-Message-State: AGi0PuYYwXhLe4Al1V6bo8YCFx8zhW2lS/3Kr25QK4TP5tNoSa38qFoU
        NeJUtvuVzMAwjDyMHFIZKpdiWmEGSIK1eoQLT83ENw==
X-Google-Smtp-Source: APiQypIYjYUvEtVGNd27c1+JwM3UC4JdspvxdSp2uB6/Zn/IP6HBQYr4Yxw+YKakR94PGo55lnU3ndTA9L+bkjrGVfM=
X-Received: by 2002:a19:c85:: with SMTP id 127mr1421149lfm.189.1588691008811;
 Tue, 05 May 2020 08:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <20200504141136.GR22838@dhcp22.suse.cz> <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
 <20200504150052.GT22838@dhcp22.suse.cz> <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
 <20200504160613.GU22838@dhcp22.suse.cz> <CALvZod79hWns9366B+8ZK2Roz8c+vkdA80HqFNMep56_pumdRQ@mail.gmail.com>
 <20200505071324.GB16322@dhcp22.suse.cz>
In-Reply-To: <20200505071324.GB16322@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 5 May 2020 08:03:17 -0700
Message-ID: <CALvZod5H-fDbvu73=hkzN0Man_+03ZW0d5zc1N0YObVHSiy0Tw@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 5, 2020 at 12:13 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 04-05-20 12:23:51, Shakeel Butt wrote:
> [...]
> > *Potentially* useful for debugging versus actually beneficial for
> > "sweep before tear down" use-case.
>
> I definitely do not want to prevent you from achieving what you
> want/need. Let's get back to your argument on why you cannot use
> memory.high for this purpose and what is the actual difference from
> memory.max on the "sweep before removal". You've said
>
> : Yes that would work but remote charging concerns me. Remote charging
> : can still happen after the memcg is offlined and at the moment, high
> : reclaim does not work for remote memcg and the usage can go till max
> : or global pressure. This is most probably a misconfiguration and we
> : might not receive the warnings in the log ever. Setting memory.max to
> : 0 will definitely give such warnings.
>
> So essentially the only reason you are not using memory.high which would
> effectively achieve the same level of reclaim for your usecase is that
> potential future remote charges could get unnoticed.

Yes.

> I have proposed to
> warn when charging to an offline memcg because that looks like a sign of
> bug to me.

Instead of a bug, I would say misconfiguration but there is at least a
genuine user i.e. buffer_head. It can be allocated in reclaim and
trigger remote charging but it should be fine as the page it is
attached to will possibly get freed soon. So, I don't think we want to
warn for all remote charges to an offlined memcg.

> Having the hard limit clamped to 0 (or some other small
> value) would complain loud by the oom report and no eligible tasks
> message but it will unlikely help to stop such a usage because, well,
> there is nothing reclaimable and we force the charge in that case. So
> you are effectively in the memory.high like situation.

Yes, effectively it will be similar to memory.high but at least we
will get early warnings.

Now rethinking about the remote charging of buffer_head to an offlined
memcg with memory.max=0. It seems like it is special in the sense that
it is using __GFP_NOFAIL and will skip the oom-killer and thus
warnings. Maybe the right approach is, as you suggested, always warn
for charging an offline memcg unless
(__GFP_NOFAIL|__GFP_RETRY_MAYFAIL). Though I am not sure if this is
doable without code duplication.

>
> So instead of potentially removing a useful information can we focus on
> the remote charging side of the problem and deal with it in a sensible
> way? That would make memory.high usable for your usecase and I still
> believe that this is what you should be using in the first place.

We talked about this at LSFMM'19 and I think the decision was to not
fix high reclaim for remote memcg until it will be an actual issue. I
suppose now we can treat it as an actual issue.

There are a couple of open questions:
1) Should the remote chargers be throttled and do the high reclaim?
2) There can be multiple remote charges to multiple memcgs in a single
kernel entry. Should we handle such scenarios?

Shakeel
