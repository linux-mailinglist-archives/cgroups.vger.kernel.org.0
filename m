Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6357C7BA3
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 04:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjJMCde (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 22:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJMCdd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 22:33:33 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CB9E0
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 19:33:31 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7741c2e76a3so104415785a.1
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 19:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1697164410; x=1697769210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HQBjX16wvpXqrz4aN4i3iIOyZKlCqR0jktD0mRwUDK8=;
        b=v+v6xCwCyJXsXnt60GuPHdcfffRgm9LBKFXYPKOw55RzZnySUIzBr1/6fAtDyi+O2L
         CwZu9zfrX/NkMaX1H8BsF7nct8aZMeCqRI3G883dnE5T+QeAIX4kO2SkGLIt+N8qLGov
         sOxwNwu8BAX2zJAzk9OfAY8cAjEAtoSQwCux3HPqd17TRB3SQJx7R/4pVb+Fuo4Xe1F1
         7UAHbhN2LaNYqmKrM60UDxuIoqrmNNPkJOGyYu0ZjSgb0N7hR8e0V0GSWvmp/scH1Gf+
         IOQ30cTT6RDPNGx5JtqYRrExN/UKfci9BGH3wkUIsm00iql6UpDNSk4sPLQ7NtZLE+WJ
         Efhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697164410; x=1697769210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQBjX16wvpXqrz4aN4i3iIOyZKlCqR0jktD0mRwUDK8=;
        b=VaPdISBskyn8UTBHCggNqUCQGePjPl0+4Zx4FD9dk7W/fkAWdh8ump6ORP+OKQcNFG
         jmzsb3NxHZ6kjnUjjSwqBXB7kOStOZ7WJOm8VrmhuV1AovcSqooz6p4fmA6L37kPMO97
         L/ZcDOOzJ29WvWPcMFAV5tFrB7DCiBN5oX0Xo5oHtWHVTVX4WfDABlJQlnQSpv6cjwAz
         meBC9bZ3Cr/pyHBDEh+sCb3j4YMP6gccN2r2knTdnhRon0T24enOenDjS4Gklze/EVsf
         IkVe/vFtGXpq2hv3dg0t3+WsFnAql4ZLLZQfKCacNlRs4En+NeNcjC14jFSGqnc+uIab
         K5Qg==
X-Gm-Message-State: AOJu0YxEGjMSujlJiGpdvlFeo+FEHXyMOW3jQLX9QI24hYkuK2GmoPXb
        nrnllL0fF20s4WQBcRoG6AGtng==
X-Google-Smtp-Source: AGHT+IHce1yeyufcNiwtojg097ZByIxT0sqkyjp7IUQBwixMQxEAA1gP7NZxZR02opFmmqgWe9qyng==
X-Received: by 2002:a0c:f194:0:b0:66c:ff4f:a35f with SMTP id m20-20020a0cf194000000b0066cff4fa35fmr9751346qvl.51.1697164410198;
        Thu, 12 Oct 2023 19:33:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:66a6])
        by smtp.gmail.com with ESMTPSA id e9-20020a056214162900b00656329bb3b1sm304909qvw.10.2023.10.12.19.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 19:33:29 -0700 (PDT)
Date:   Thu, 12 Oct 2023 22:33:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
Message-ID: <20231013023329.GG470544@cmpxchg.org>
References: <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com>
 <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
 <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
 <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
 <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
 <20231012132946.GA470544@cmpxchg.org>
 <CAJD7tkbrR=6SmVxo4pVKHVu4eGBYN+xXuu5+zFPh6LSqt8vGcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbrR=6SmVxo4pVKHVu4eGBYN+xXuu5+zFPh6LSqt8vGcw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 12, 2023 at 04:28:49PM -0700, Yosry Ahmed wrote:
> [..]
> > > >
> > > > Using next-20231009 and a similar 44 core machine with hyperthreading
> > > > disabled, I ran 22 instances of netperf in parallel and got the
> > > > following numbers from averaging 20 runs:
> > > >
> > > > Base: 33076.5 mbps
> > > > Patched: 31410.1 mbps
> > > >
> > > > That's about 5% diff. I guess the number of iterations helps reduce
> > > > the noise? I am not sure.
> > > >
> > > > Please also keep in mind that in this case all netperf instances are
> > > > in the same cgroup and at a 4-level depth. I imagine in a practical
> > > > setup processes would be a little more spread out, which means less
> > > > common ancestors, so less contended atomic operations.
> > >
> > >
> > > (Resending the reply as I messed up the last one, was not in plain text)
> > >
> > > I was curious, so I ran the same testing in a cgroup 2 levels deep
> > > (i.e /sys/fs/cgroup/a/b), which is a much more common setup in my
> > > experience. Here are the numbers:
> > >
> > > Base: 40198.0 mbps
> > > Patched: 38629.7 mbps
> > >
> > > The regression is reduced to ~3.9%.
> > >
> > > What's more interesting is that going from a level 2 cgroup to a level
> > > 4 cgroup is already a big hit with or without this patch:
> > >
> > > Base: 40198.0 -> 33076.5 mbps (~17.7% regression)
> > > Patched: 38629.7 -> 31410.1 (~18.7% regression)
> > >
> > > So going from level 2 to 4 is already a significant regression for
> > > other reasons (e.g. hierarchical charging). This patch only makes it
> > > marginally worse. This puts the numbers more into perspective imo than
> > > comparing values at level 4. What do you think?
> >
> > I think it's reasonable.
> >
> > Especially comparing to how many cachelines we used to touch on the
> > write side when all flushing happened there. This looks like a good
> > trade-off to me.
> 
> Thanks.
> 
> Still wanting to figure out if this patch is what you suggested in our
> previous discussion [1], to add a
> Suggested-by if appropriate :)
> 
> [1]https://lore.kernel.org/lkml/20230913153758.GB45543@cmpxchg.org/

Haha, sort of. I suggested the cgroup-level flush-batching, but my
proposal was missing the clever upward propagation of the pending stat
updates that you added.

You can add the tag if you're feeling generous, but I wouldn't be mad
if you don't!
