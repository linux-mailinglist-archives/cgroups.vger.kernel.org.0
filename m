Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4B6CCA2C
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 20:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjC1SqA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 14:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjC1Sp6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 14:45:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F4B1FEC
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 11:45:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eg48so53536838edb.13
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680029155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDPpGTUcAigUdKyxJFj5FSviALfqo1wtwcjHPt+uS1s=;
        b=hybc48zyKPXEpWZviFjaAJ9WSBFVr1MfoVcaRbhXnniFqrgKcZURpL2D66EDfe2Tom
         2enWNHJvfeVMeYKAokqAFAXfZky705CgievqgDkFCxw4bPSTAK2Jp0CTqI7/9FVShpJy
         vR3o+VqgifbVaYRySVqKDxmaMMNXgAKvJzO0kZxGOm+jjAPdvnHtk7pGDo7cExEnhjW/
         0fQi9SbN5MXhL+Y1R6QN/IJLbl9GreFFGWUTl+AvpY5hoTt68q4RTl/M0g27vj36Yw30
         3H/+tfUlSanDAmXpy+sxacjiLYAoaymmPVTxzgAnJ/Lsg5sj0Yw2/MQpjUuiaHO+/Ydn
         R6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680029155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDPpGTUcAigUdKyxJFj5FSviALfqo1wtwcjHPt+uS1s=;
        b=sTzFOjN4RFH/9UPIvMrbjo6mlx4RxmvtumHPgmz7cFOXWU5NlqrCvBX9To3hBdIH2d
         aN1mOq0mP/lW6ZlHjrhwYlnxevkV/deAD6KxDNxRLx3NkuKVx0pMdRuzbX2gyIc1/nsz
         3rpzpiQmSBR/eW2vRhgm7jex9AgyIA2EcbtJRQt3W3af4IOJWK/eCYLJw81Nq6XCUrXn
         ieqtGWmI3Jk60+npfjc4IVaD+4fT/YsRp1jkNkG7tmJSxCKxZGwaoqcer/JaPp5UKjMI
         QzJcliHiIQmoMPrDJyWoEli3YGCQNh0mVoiiBjRCQ5uwP6OPrBzkIrz+8D+OWfjWdszW
         oO7w==
X-Gm-Message-State: AAQBX9cXntbkLMV5jVUbb5x2PsbYkVcsTZUvNLBrjUMchiS797PZJifm
        IbcjvzIeZROazixavpGt10DkWNQRxRtFW2FaOqaCoA==
X-Google-Smtp-Source: AKy350Y0H1o8UGlIOfaueUA1+ITobbazVG++kPK+R45KzkjvS4CMUy84hYIf5MOC6prSXxfzvLslyCUom9GAmiX0YTY=
X-Received: by 2002:a17:907:7b8a:b0:931:6e39:3d0b with SMTP id
 ne10-20020a1709077b8a00b009316e393d0bmr8548276ejc.15.1680029155457; Tue, 28
 Mar 2023 11:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-7-yosryahmed@google.com> <ZCMzfQuo9IhWVzRA@cmpxchg.org>
In-Reply-To: <ZCMzfQuo9IhWVzRA@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Mar 2023 11:45:19 -0700
Message-ID: <CAJD7tkZxEEcVZ9G7NSM56q_uOyL7e353NT06kD0mY5DyNmKTpw@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] memcg: sleep during flushing stats in safe contexts
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 28, 2023 at 11:35=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Tue, Mar 28, 2023 at 06:16:35AM +0000, Yosry Ahmed wrote:
> > @@ -642,24 +642,57 @@ static void __mem_cgroup_flush_stats(void)
> >        * from memcg flushers (e.g. reclaim, refault, etc).
> >        */
> >       if (atomic_xchg(&stats_flush_ongoing, 1))
> > -             return;
> > +             return false;
> >
> >       WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
> > -     cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
> > +     return true;
> > +}
> > +
> > +static void mem_cgroup_post_stats_flush(void)
> > +{
> >       atomic_set(&stats_flush_threshold, 0);
> >       atomic_set(&stats_flush_ongoing, 0);
> >  }
> >
> > -void mem_cgroup_flush_stats(void)
> > +static bool mem_cgroup_should_flush_stats(void)
> >  {
> > -     if (atomic_read(&stats_flush_threshold) > num_online_cpus())
> > -             __mem_cgroup_flush_stats();
> > +     return atomic_read(&stats_flush_threshold) > num_online_cpus();
> > +}
> > +
> > +/* atomic functions, safe to call from any context */
> > +static void __mem_cgroup_flush_stats_atomic(void)
> > +{
> > +     if (mem_cgroup_pre_stats_flush()) {
> > +             cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
> > +             mem_cgroup_post_stats_flush();
> > +     }
> > +}
>
> I'm afraid I wasn't very nuanced with my complaint about the bool
> parameter in the previous version. In this case, when you can do a
> common helper for a couple of API functions defined right below it,
> and the callers don't spread throughout the codebase, using bools
> makes things simpler while still being easily understandable:

Looking at your suggestion now, it seems fairly obvious that this is
what I should have gone for. Will do that for v2. Thanks!

>
> static void do_flush_stats(bool may_sleep)
> {
>         if (atomic_xchg(&stats_flush_ongoing, 1))
>                 return;
>
>         WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
>         atomic_set(&stats_flush_threshold, 0);
>
>         if (!may_sleep)
>                 cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
>         else
>                 cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
>
>         atomic_set(&stats_flush_ongoing, 0);
> }
>
> void mem_cgroup_flush_stats(void)
> {
>         if (atomic_read(&stats_flush_threshold) > num_online_cpus())
>                 do_flush_stats(true);
> }
>
> void mem_cgroup_flush_stats_atomic(void)
> {
>         if (atomic_read(&stats_flush_threshold) > num_online_cpus())
>                 do_flush_stats(false);
> }
>
> >  void mem_cgroup_flush_stats_ratelimited(void)
> >  {
> >       if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> > -             mem_cgroup_flush_stats();
> > +             mem_cgroup_flush_stats_atomic();
> > +}
>
> This should probably be mem_cgroup_flush_stats_atomic_ratelimited().
>
> (Whee, kinda long, but that's alright. Very specialized caller...)

It should, but the following patch makes it non-atomic anyway, so I
thought I wouldn't clutter the diff by renaming it here and then
reverting it back in the next patch.

There is an argument for maintaining a clean history tho in case the
next patch is reverted separately (which is the reason I put it in a
separate patch to begin with) -- so perhaps I should rename it here to
mem_cgroup_flush_stats_atomic_ratelimited () and back to
mem_cgroup_flush_stats_ratelimited() in the next patch, just for
consistency?

>
> Btw, can you guys think of a reason against moving the threshold check
> into the common function? It would then apply to the time-limited
> flushes as well, but that shouldn't hurt anything. This would make the
> code even simpler:

I think the point of having the threshold check outside the common
function is that the periodic flusher always flushes, regardless of
the threshold, to keep rstat flushing from critical contexts as cheap
as possible.

If you think it's not worth it, I can make that change. It is a
separate functional change tho, so maybe in a separate patch.

>
> static void do_flush_stats(bool may_sleep)
> {
>         if (atomic_read(&stats_flush_threshold) <=3D num_online_cpus())
>                 return;
>
>         if (atomic_xchg(&stats_flush_ongoing, 1))
>                 return;
>
>         WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
>         atomic_set(&stats_flush_threshold, 0);
>
>         if (!may_sleep)
>                 cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
>         else
>                 cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
>
>         atomic_set(&stats_flush_ongoing, 0);
> }
>
> void mem_cgroup_flush_stats(void)
> {
>         do_flush_stats(true);
> }
>
> void mem_cgroup_flush_stats_atomic(void)
> {
>         do_flush_stats(false);
> }
>
> void mem_cgroup_flush_stats_atomic_ratelimited(void)
> {
>         if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
>                 do_flush_stats(false);
> }
>
> > @@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, =
struct scan_control *sc)
> >        * Flush the memory cgroup stats, so that we read accurate per-me=
mcg
> >        * lruvec stats for heuristics.
> >        */
> > -     mem_cgroup_flush_stats();
> > +     mem_cgroup_flush_stats_atomic();
>
> I'm thinking this one could be non-atomic as well. It's called fairly
> high up in reclaim without any locks held.

A later patch does exactly that. I put making the reclaim and refault
paths non-atomic in separate patches to easily revert them if we see a
regression. Let me know if this is too defensive and if you'd rather
have them squashed.

Thanks!
