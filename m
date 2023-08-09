Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D877606F
	for <lists+cgroups@lfdr.de>; Wed,  9 Aug 2023 15:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjHINR5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Aug 2023 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjHINR4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Aug 2023 09:17:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F22103
        for <cgroups@vger.kernel.org>; Wed,  9 Aug 2023 06:17:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bcfe28909so936161966b.3
        for <cgroups@vger.kernel.org>; Wed, 09 Aug 2023 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691587074; x=1692191874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r7GQah3LR29pNwUlAFsHmzB3/MgA9amRpVJYquX5jX0=;
        b=j2xSiU48lAhLr6GSJ/DFJP5FmUuUSjaBQhgGtPkSEPls0F47OUNh8TIbrSr5UMunMZ
         uM2ZUT0AV6Yl9Qlwub03wbHBRZjf4OaV9YYJm/YEXekUy4vO6Sjeybnabl5D10LLVSjn
         swU57o/MSbPRGeE+ljLde+9aziPyf0+7ZdSzgtsDh6skzxrYO/yjzQ+Pj0y2dU1pdUdr
         2y6VTAnLM4T3A1v5je6mTuQx7nD+wKUg0/0kJJk3EZnC32WVXkdj0Q0Sk5PC/EHZ4xgU
         8lISujnCVovjWP5Jh+CduFXCDAJVx2O+ylOXE2UnEchucJ2qS+wwVmDkpuWz7YVTBaqW
         /Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691587074; x=1692191874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7GQah3LR29pNwUlAFsHmzB3/MgA9amRpVJYquX5jX0=;
        b=Gl3Ed4mYn5OavyBsYQIMjfQ/0JsCXOrA4xSTpTwXuqQGCHxbx+WpePa2/45m4UAOxk
         encxv7vH1Op69Hlu0BCfxtnT3uUg7sS9MWfLa4IJ/eGsEHyGOHperW90nZ7EMUs1CY1X
         gDlhPCdfiWRxvCcXmETodjNIopTIM8B1cCixC6tpEJZosNqcqTHGklcutOdCBzy+1AEG
         MK6hhdj+AO8N8ryRMGdP4q0TXKly011hXiuC7tOsmGI7/cQyP36TXmxu9t8Cu1blPwLs
         1MqAtaAOhsCCwYTlF4jo5x7mV6OZxeVfjFvp3PzI415c5D1PxGX/FhumzS2NdT9ZJfJx
         b+Mw==
X-Gm-Message-State: AOJu0YzMyiMS/tSp5+hq6aNPGkjgXQ7onjSXbcdP4/9IvrFQa6dFBGXX
        p1qmMYXhcCmBVS6agfxNy7LvJPE6f8wAaCHP/M5ROA==
X-Google-Smtp-Source: AGHT+IGIzc/TMK7NNoqOzdlb2frVhrYUSFPRNGS6tLA/DRsJVToruJ1YAinbznO7/6EkrahVfqFaeMRaWmgFTbKkw9M=
X-Received: by 2002:a17:906:220e:b0:99b:f3d1:7735 with SMTP id
 s14-20020a170906220e00b0099bf3d17735mr2206402ejs.29.1691587074277; Wed, 09
 Aug 2023 06:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230809045810.1659356-1-yosryahmed@google.com>
 <ZNNTgZVPZipTL/UM@dhcp22.suse.cz> <CAJD7tkYhxbd2e+4HMZVKUfD4cx6oDauna3vLmttNPLCmFNtpgA@mail.gmail.com>
 <ZNONgeoytpkchHga@dhcp22.suse.cz>
In-Reply-To: <ZNONgeoytpkchHga@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 9 Aug 2023 06:17:18 -0700
Message-ID: <CAJD7tkaPPcMsq-pbu26H332xBJP-m=v1aBbU_NJQQn+7motX9g@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

<snip>
> > > [...]
> > > > @@ -639,17 +639,24 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
> > > >       }
> > > >  }
> > > >
> > > > -static void do_flush_stats(void)
> > > > +static void do_flush_stats(bool full)
> > > >  {
> > > > +     if (!atomic_read(&stats_flush_ongoing) &&
> > > > +         !atomic_xchg(&stats_flush_ongoing, 1))
> > > > +             goto flush;
> > > > +
> > > >       /*
> > > > -      * We always flush the entire tree, so concurrent flushers can just
> > > > -      * skip. This avoids a thundering herd problem on the rstat global lock
> > > > -      * from memcg flushers (e.g. reclaim, refault, etc).
> > > > +      * We always flush the entire tree, so concurrent flushers can choose to
> > > > +      * skip if accuracy is not critical. Otherwise, wait for the ongoing
> > > > +      * flush to complete. This avoids a thundering herd problem on the rstat
> > > > +      * global lock from memcg flushers (e.g. reclaim, refault, etc).
> > > >        */
> > > > -     if (atomic_read(&stats_flush_ongoing) ||
> > > > -         atomic_xchg(&stats_flush_ongoing, 1))
> > > > -             return;
> > > > -
> > > > +     while (full && atomic_read(&stats_flush_ongoing) == 1) {
> > > > +             if (!cond_resched())
> > > > +                     cpu_relax();
> > >
> > > You are reinveting a mutex with spinning waiter. Why don't you simply
> > > make stats_flush_ongoing a real mutex and make use try_lock for !full
> > > flush and normal lock otherwise?
> >
> > So that was actually a spinlock at one point, when we used to skip if
> > try_lock failed.
>
> AFAICS cgroup_rstat_flush is allowed to sleep so spinlocks are not
> really possible.

Sorry I hit the send button too early, didn't get to this part.

We were able to use a spinlock because we used to disable sleeping
when flushing the stats then, which opened another can of worms :)

>
> > We opted for an atomic because the lock was only used
> > in a try_lock fashion. The problem here is that the atomic is used to
> > ensure that only one thread actually attempts to flush at a time (and
> > others skip/wait), to avoid a thundering herd problem on
> > cgroup_rstat_lock.
> >
> > Here, what I am trying to do is essentially equivalent to "wait until
> > the lock is available but don't grab it". If we make
> > stats_flush_ongoing a mutex, I am afraid the thundering herd problem
> > will be reintroduced for stats_flush_ongoing this time.
>
> You will have potentially many spinners for something that might take
> quite a lot of time (sleep) if there is nothing else to schedule. I do
> not think this is a proper behavior. Really, you shouldn't be busy
> waiting for a sleeper.
>
> > I am not sure if there's a cleaner way of doing this, but I am
> > certainly open for suggestions. I also don't like how the spinning
> > loop looks as of now.
>
> mutex_try_lock for non-critical flushers and mutex_lock of syncing ones.
> We can talk a custom locking scheme if that proves insufficient or
> problematic.

I have no problem with this. I can send a v2 following this scheme,
once we agree on the importance of this patch :)

> --
> Michal Hocko
> SUSE Labs
