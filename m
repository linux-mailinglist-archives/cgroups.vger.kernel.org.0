Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC6D7C7BA6
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 04:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjJMCi4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 22:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMCiz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 22:38:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB49B7
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 19:38:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso264903066b.1
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 19:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697164731; x=1697769531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phWhzj3KBeGp1S5QdijAT03d7GpdmyxZnvI+iabRGkI=;
        b=fWB4iZBil+1kbMTO6AIZ/wkkCjmJr0Asyd8KO15pDrGn1RFN0GUyYp9lBJZvMEvNS4
         KQuQpSXo9ABRchkuov6SC/MBpGLCtmUHlXQS19KxFbwooZsy+w7zRXTmu2GJ7l56cK/z
         ldZrb/vYSmNRHcLV8X0hE+V6KIk0D6O6D/8cmTdGuu1BIaPVVm8m5pf5t5ZZKlRY9MK7
         YxlB96+Qdg0kza6xn/AwKe20w4hkcVNGvN4mrH5QIYBFMiwCB8jkZ4B67QK9dbcib3/j
         17IkxPFKsASrJKPrH46VkdWOVRAHTG1iugKAO4G6o/hSchZaZ/XE2N7VzxK+4QRgxkZf
         qFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697164731; x=1697769531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phWhzj3KBeGp1S5QdijAT03d7GpdmyxZnvI+iabRGkI=;
        b=cJPiIiO7A+zwKZj/WL5DAAilivNFSlVonQ8GdXIkX760fYxpWd/TJx0AqQhAd6HdRM
         TEPAX1yjp42TmydyuLq1O69SQwSZ/pAcSutxYlzvMdaJSzp/b++Wx9IO0Fyaidfkwb51
         YwpQ45GGwJZwQ6/cKAueaIdUnEKupEwVA0icJcyVXvZovsN1xTzxK/KCnHN1H6dU3Tis
         3YpgBTL78KEW3fLlQHOVNsCjBH9MELQHxFtmBK6llTPvvS4fBC4IQRwX/n1W3B37RULB
         dNInFVRvf9HqNBZg4ziLjVj6qXRx84HTpMN2/Gp6qj1nPX4LcygLXKgM3VHrxUrQfvef
         F4Jg==
X-Gm-Message-State: AOJu0Yw76zyAMaRSZWKwzi9hzb4b0Ku3NCJ0dIsn5OyMDyl0KPLSVsxc
        fpfNBIpbv5qn0Q3v6DMT6IJ+FXRsf9ZmywGVQ5reSQ==
X-Google-Smtp-Source: AGHT+IGRXCZ+TRpCk0/Kqrt/KCkKlF9/hfbFXcuhNnmWZ2bqjM1/An4E7omja7b+DsDYbZ66D5RfxOj4ExmFVPGXpOE=
X-Received: by 2002:a17:906:8467:b0:9ae:62ec:f4a1 with SMTP id
 hx7-20020a170906846700b009ae62ecf4a1mr22417903ejc.33.1697164731128; Thu, 12
 Oct 2023 19:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com> <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
 <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
 <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
 <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
 <20231012132946.GA470544@cmpxchg.org> <CAJD7tkbrR=6SmVxo4pVKHVu4eGBYN+xXuu5+zFPh6LSqt8vGcw@mail.gmail.com>
 <20231013023329.GG470544@cmpxchg.org>
In-Reply-To: <20231013023329.GG470544@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 12 Oct 2023 19:38:12 -0700
Message-ID: <CAJD7tkajkCBDLBOATv3b5C1vBE_yWe1YUMdaoaHW4rtnR9_-8A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
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

On Thu, Oct 12, 2023 at 7:33=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Oct 12, 2023 at 04:28:49PM -0700, Yosry Ahmed wrote:
> > [..]
> > > > >
> > > > > Using next-20231009 and a similar 44 core machine with hyperthrea=
ding
> > > > > disabled, I ran 22 instances of netperf in parallel and got the
> > > > > following numbers from averaging 20 runs:
> > > > >
> > > > > Base: 33076.5 mbps
> > > > > Patched: 31410.1 mbps
> > > > >
> > > > > That's about 5% diff. I guess the number of iterations helps redu=
ce
> > > > > the noise? I am not sure.
> > > > >
> > > > > Please also keep in mind that in this case all netperf instances =
are
> > > > > in the same cgroup and at a 4-level depth. I imagine in a practic=
al
> > > > > setup processes would be a little more spread out, which means le=
ss
> > > > > common ancestors, so less contended atomic operations.
> > > >
> > > >
> > > > (Resending the reply as I messed up the last one, was not in plain =
text)
> > > >
> > > > I was curious, so I ran the same testing in a cgroup 2 levels deep
> > > > (i.e /sys/fs/cgroup/a/b), which is a much more common setup in my
> > > > experience. Here are the numbers:
> > > >
> > > > Base: 40198.0 mbps
> > > > Patched: 38629.7 mbps
> > > >
> > > > The regression is reduced to ~3.9%.
> > > >
> > > > What's more interesting is that going from a level 2 cgroup to a le=
vel
> > > > 4 cgroup is already a big hit with or without this patch:
> > > >
> > > > Base: 40198.0 -> 33076.5 mbps (~17.7% regression)
> > > > Patched: 38629.7 -> 31410.1 (~18.7% regression)
> > > >
> > > > So going from level 2 to 4 is already a significant regression for
> > > > other reasons (e.g. hierarchical charging). This patch only makes i=
t
> > > > marginally worse. This puts the numbers more into perspective imo t=
han
> > > > comparing values at level 4. What do you think?
> > >
> > > I think it's reasonable.
> > >
> > > Especially comparing to how many cachelines we used to touch on the
> > > write side when all flushing happened there. This looks like a good
> > > trade-off to me.
> >
> > Thanks.
> >
> > Still wanting to figure out if this patch is what you suggested in our
> > previous discussion [1], to add a
> > Suggested-by if appropriate :)
> >
> > [1]https://lore.kernel.org/lkml/20230913153758.GB45543@cmpxchg.org/
>
> Haha, sort of. I suggested the cgroup-level flush-batching, but my
> proposal was missing the clever upward propagation of the pending stat
> updates that you added.
>
> You can add the tag if you're feeling generous, but I wouldn't be mad
> if you don't!

I like to think that I am a generous person :)

Will add it in the next respin.
