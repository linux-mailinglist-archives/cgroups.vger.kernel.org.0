Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFDF6CF498
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC2UjB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 16:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC2UjA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 16:39:00 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217A25FE7
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 13:38:59 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id n125so20995064ybg.7
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680122338;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=roQ4I8SfNlurAVA2gUW8YNCdvD/U9UP1h39JPEDCNrw=;
        b=NU/yfcrc8ryHQhIAObFNbURZYYwBhWTiQcib7OVvY/80Set4ojSk/egyVrcxg9WBQ1
         8yqI244zT3XrggWqoMHveuVVPk8Z2LeSgnN6ROSj4fKFcZHCArk6iGNr7q9j5X17Ny23
         gmo9mEp/to3tEwTte/8Z7bDTyJtCMtNYFbADW39rzX3kLuRLCJcFYk0CzDahs3JND0r7
         f96lCJylAr51Qw4wmj36DwO90YcGV7yvS8D1S6nqpocow0tu6wu3TqawKx9gnwEmZBip
         jOPhjsfHq3YLAiBGrnnBXaxJLVQ+N5Er/HmS5eE2sSr/k3DgDVkRF8MlpE+6XIDw6pC4
         ZMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680122338;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=roQ4I8SfNlurAVA2gUW8YNCdvD/U9UP1h39JPEDCNrw=;
        b=DUY2mbORf5GyyFxpDg2IoP7PmVXLj4FgIyFDCGT/so84LirlSaXxmtMPTxOiEfF83B
         0QJf7vaVPFwgTM5IYS5yRxMHOy5qxsdqmvT62QeJLhpMlycOogLgR8L3tmbaYoNtk6rn
         YAZ+49zSWM96ZawNUOyqsSLAAYXBaFhlrLMuPm1j6TUnNBwwVWSZWc/RY74VdRurukJv
         +2pH4DaAlMbYQzcE0TvRr0A+bUv4He6X1DnvPJkXPVOejWgmtsXVLxLya4EKVrIo4JS5
         WndE4qdfrTEp2uZ6lihfZvHfypWmv/WLBJNnm5sGF+Zo2TUMbwPqyDw+4nOnvYhpD9eM
         Rh0A==
X-Gm-Message-State: AAQBX9dT6G30NOTLaL0p5y1nZIOqb+i8aXGLVlYxE42gjcP5n/q6JvCB
        Q4CCX2pO/Y21Tiz0hY6E8ttCAg==
X-Google-Smtp-Source: AKy350awy+iqFFLhoWPnPqScJw2eCrMSToUYrqptA8NQ5i6yrQSWWA49k/VEwxmPQNxTIvIjhwOwcA==
X-Received: by 2002:a25:6d08:0:b0:a8a:4380:e073 with SMTP id i8-20020a256d08000000b00a8a4380e073mr17114309ybc.53.1680122338180;
        Wed, 29 Mar 2023 13:38:58 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b125-20020a256783000000b00b7767ca748dsm3732036ybc.42.2023.03.29.13.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 13:38:57 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:38:48 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Tejun Heo <tj@kernel.org>
cc:     Hugh Dickins <hughd@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
In-Reply-To: <ZCSY8l/jVwszF6iA@slm.duckdns.org>
Message-ID: <98cb3ce-7ed9-3d17-9015-ef7193d6627@google.com>
References: <ZBz/V5a7/6PZeM7S@slm.duckdns.org> <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com> <ZB5UalkjGngcBDEJ@slm.duckdns.org> <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com> <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com>
 <CAJD7tkY_ESpMYMw72bsATpp6tPphv8qS6VbfEUjpKZW6vUqQSQ@mail.gmail.com> <CALvZod41ecuCKmuFBNtAjoKJjQgWYzoe4_B8zRK37HYk-rYDkA@mail.gmail.com> <CAJD7tkZrp=4zWvjE9_010TAG1T_crCbf9P64UzJABspgcrGPKg@mail.gmail.com> <ZCSJDpPPOVvBYfOy@slm.duckdns.org>
 <f9b6410-ee17-635f-a35d-559fa0191dc3@google.com> <ZCSY8l/jVwszF6iA@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 29 Mar 2023, Tejun Heo wrote:

> Hello, Hugh. How have you been?
> 
> On Wed, Mar 29, 2023 at 12:22:24PM -0700, Hugh Dickins wrote:
> > Hi Tejun,
> > Butting in here, I'm fascinated.  This is certainly not my area, I know
> > nothing about rstat, but this is the first time I ever heard someone
> > arguing for more disabling of interrupts rather than less.
> > 
> > An interrupt coming in while holding a contended resource can certainly
> > add to latencies, that I accept of course.  But until now, I thought it
> > was agreed best practice to disable irqs only regretfully, when strictly
> > necessary.
> > 
> > If that has changed, I for one want to know about it.  How should we
> > now judge which spinlocks should disable interrupts and which should not?
> > Page table locks are currently my main interest - should those be changed?
> 
> For rstat, it's a simple case because the global lock here wraps around
> per-cpu locks which have to be irq-safe, so the only difference we get
> between making the global irq-unsafe and keeping it so but releasing
> inbetween is:
> 
>  Global lock held: G
>  IRQ disabled: I
>  Percpu lock held: P
>  
> 1. IRQ unsafe
> 
>  GGGGGGGGGGGGGGG~~GGGGG
>  IIII IIII IIII ~~ IIII
>  PPPP PPPP PPPP ~~ PPPP
> 
> 2. IRQ safe released inbetween cpus
> 
>  GGGG GGGG GGGG ~~ GGGG
>  IIII IIII IIII ~~ IIII
>  PPPP PPPP PPPP ~~ PPPP
> 
> #2 seems like the obvious thing to do here given how the lock is used and
> each P section may take a bit of time.

Many thanks for the detailed response.  I'll leave it to the rstat folks,
to agree or disagree with your analysis there.

> 
> So, in the rstat case, the choice is, at least to me, obvious, but even for
> more generic cases where the bulk of actual work isn't done w/ irq disabled,
> I don't think the picture is as simple as "use the least protected variant
> possible" anymore because the underlying hardware changed.
> 
> For an SMP kernel running on an UP system, "the least protected variant" is
> the obvious choice to make because you don't lose anything by holding a
> spinlock longer than necessary. However, as you increase the number of CPUs,
> there rises a tradeoff between local irq servicing latency and global lock
> contention.
> 
> Imagine a, say, 128 cpu system with a few cores servicing relatively high
> frequency interrupts. Let's say there's a mildly hot lock. Usually, it shows
> up in the system profile but only just. Let's say something happens and the
> irq rate on those cores went up for some reason to the point where it
> becomes a rather common occurrence when the lock is held on one of those
> cpus, irqs are likely to intervene lengthening how long the lock is held,
> sometimes, signficantly. Now because the lock is on average held for much
> longer, it become a lot hotter as more CPUs would stall on it and depending
> on luck or lack thereof these stalls can span many CPUs on the system for
> quite a while. This is actually something we saw in production.
> 
> So, in general, there's a trade off between local irq service latency and
> inducing global lock contention when using unprotected locks. With more and
> more CPUs, the balance keeps shifting. The balance still very much depends
> on the specifics of a given lock but yeah I think it's something we need to
> be a lot more careful about now.

And this looks a very plausible argument to me: I'll let it sink in.

But I hadn't heard that the RT folks were clamouring for more irq disabling:
perhaps they partition their machines with more care, and are not devotees
of high CPU counts.

What I hope is that others will chime in one way or the other -
it does sound as if a reappraisal of the balances is overdue.

Thanks,
Hugh (disabling interrupts for as long as he can)
