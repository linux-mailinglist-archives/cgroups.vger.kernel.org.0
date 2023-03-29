Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5156CF26C
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 20:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjC2Spq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 14:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjC2Spp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 14:45:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20DE10D3
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 11:45:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so67260886edo.2
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 11:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680115542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4XQWEx4XOGTRmpxqiJA9FV6OjtgnooLELcFguOwH/M=;
        b=R3c1c79qcrryGJME0k5/voHe0ocIUyrzrRPmUzruWW9wKNc8R8igTjgfbKp4SmPAPk
         BYWMOuubOojwlh56NX2+nnpobhHFMpG8DbUfXcQrzIcQ4rhvXqyMp9KnhpDZz8vMyLAP
         PEs4t/Yq6YU2tDXdbeIZF434Mnei5A/Jh0vHupc8PxKvuioxFAav7YUQLftfo6DeMceG
         arjRixDMAzpupyhw9a1IUbUYrtEZ16QymkaC8lz4/bxm+6fybvtHp8GLtJap9i4E1Zte
         fcOxcxVMTyptd2iyg+syEW1Ay8m4s5oUnfITXxW63g8aW7yJOEQoA7X0Z8+cF6Q8x4Aj
         pQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4XQWEx4XOGTRmpxqiJA9FV6OjtgnooLELcFguOwH/M=;
        b=gFmwXvqmHccL0iAmpgnhvds7Q/PjUcH4PGKXhb4vKJxFfeOP6gEsOfsy+IrKMiICA6
         aY/W+pHZG3vr+GqHNro7qrkFtxvEZRgEYaNP2kDR8Anwc8f4kfm/7MpgeXQawgI9rTYU
         OBO4kcxeDQUYmbw2Jhe4IEFeUupLysIjDXZsHfYbePnuiSxKuebYQF5OE1QOX809WTer
         KrSAvTEKSDeNdCigbfIllOYZkXRlSRO3CvNp1b82vXRmMpBbp7+uIdM7Ve8PoB8qDf+/
         O2zAKoRdqKeTsW1Q3YewPIS58jUKwLDimRKcPXLiUYFJ3V/TwVoY7Egulwm9LIYzgSJ1
         SgGw==
X-Gm-Message-State: AAQBX9cxCm9JIRrrqsJ8U0akK3WYXdFI/IroEEj2Pj8mq9FmHBkF/M+w
        olnLsOzlUupgVhaFKAq+UuWvykQPwOGykh/UeNS3AQ==
X-Google-Smtp-Source: AKy350ZrEgPF5oQCtQlpBo35h5Arle98ynmscmO8msEzRRNXHdagSlX+LoJxPCZUEUNFNCVZX3A4CPoqgeNqTMC2C44=
X-Received: by 2002:a17:906:a86:b0:933:f6e8:26d9 with SMTP id
 y6-20020a1709060a8600b00933f6e826d9mr10670607ejf.15.1680115541997; Wed, 29
 Mar 2023 11:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-6-yosryahmed@google.com> <ZCRgQHtDuWN6xp7z@dhcp22.suse.cz>
In-Reply-To: <ZCRgQHtDuWN6xp7z@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 29 Mar 2023 11:45:05 -0700
Message-ID: <CAJD7tkaTa8XTVjga0jijjajXzRAGFN4QMvEspiJ8M1f9YA_yBA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] memcg: replace stats_flush_lock with an atomic
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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

On Wed, Mar 29, 2023 at 8:58=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 28-03-23 22:16:40, Yosry Ahmed wrote:
> > As Johannes notes in [1], stats_flush_lock is currently used to:
> > (a) Protect updated to stats_flush_threshold.
> > (b) Protect updates to flush_next_time.
> > (c) Serializes calls to cgroup_rstat_flush() based on those ratelimits.
> >
> > However:
> >
> > 1. stats_flush_threshold is already an atomic
> >
> > 2. flush_next_time is not atomic. The writer is locked, but the reader
> >    is lockless. If the reader races with a flush, you could see this:
> >
> >                                         if (time_after(jiffies, flush_n=
ext_time))
> >         spin_trylock()
> >         flush_next_time =3D now + delay
> >         flush()
> >         spin_unlock()
> >                                         spin_trylock()
> >                                         flush_next_time =3D now + delay
> >                                         flush()
> >                                         spin_unlock()
> >
> >    which means we already can get flushes at a higher frequency than
> >    FLUSH_TIME during races. But it isn't really a problem.
> >
> >    The reader could also see garbled partial updates, so it needs at
> >    least READ_ONCE and WRITE_ONCE protection.
>
> Just a nit. Sounds more serious than it is actually. This would only
> happen if compiler decides to split the write.

Thanks for the note, Michal. I honestly quoted Johannes here as I do
not have much expertise when it comes to this. I will add "if the
compiler decides to split the write" to the commit log if I respin.

>
> > 3. Serializing cgroup_rstat_flush() calls against the ratelimit
> >    factors is currently broken because of the race in 2. But the race
> >    is actually harmless, all we might get is the occasional earlier
> >    flush. If there is no delta, the flush won't do much. And if there
> >    is, the flush is justified.
> >
> > So the lock can be removed all together. However, the lock also served
> > the purpose of preventing a thundering herd problem for concurrent
> > flushers, see [2]. Use an atomic instead to serve the purpose of
> > unifying concurrent flushers.
> >
> > [1]https://lore.kernel.org/lkml/20230323172732.GE739026@cmpxchg.org/
> > [2]https://lore.kernel.org/lkml/20210716212137.1391164-2-shakeelb@googl=
e.com/
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> > ---
> >  mm/memcontrol.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index ff39f78f962e..65750f8b8259 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -585,8 +585,8 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgrou=
p_tree_per_node *mctz)
> >   */
> >  static void flush_memcg_stats_dwork(struct work_struct *w);
> >  static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dw=
ork);
> > -static DEFINE_SPINLOCK(stats_flush_lock);
> >  static DEFINE_PER_CPU(unsigned int, stats_updates);
> > +static atomic_t stats_flush_ongoing =3D ATOMIC_INIT(0);
> >  static atomic_t stats_flush_threshold =3D ATOMIC_INIT(0);
> >  static u64 flush_next_time;
> >
> > @@ -636,15 +636,19 @@ static inline void memcg_rstat_updated(struct mem=
_cgroup *memcg, int val)
> >
> >  static void __mem_cgroup_flush_stats(void)
> >  {
> > -     unsigned long flag;
> > -
> > -     if (!spin_trylock_irqsave(&stats_flush_lock, flag))
> > +     /*
> > +      * We always flush the entire tree, so concurrent flushers can ju=
st
> > +      * skip. This avoids a thundering herd problem on the rstat globa=
l lock
> > +      * from memcg flushers (e.g. reclaim, refault, etc).
> > +      */
> > +     if (atomic_read(&stats_flush_ongoing) ||
> > +         atomic_xchg(&stats_flush_ongoing, 1))
> >               return;
> >
> > -     flush_next_time =3D jiffies_64 + 2*FLUSH_TIME;
> > +     WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
> >       cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
> >       atomic_set(&stats_flush_threshold, 0);
> > -     spin_unlock_irqrestore(&stats_flush_lock, flag);
> > +     atomic_set(&stats_flush_ongoing, 0);
> >  }
> >
> >  void mem_cgroup_flush_stats(void)
> > @@ -655,7 +659,7 @@ void mem_cgroup_flush_stats(void)
> >
> >  void mem_cgroup_flush_stats_ratelimited(void)
> >  {
> > -     if (time_after64(jiffies_64, flush_next_time))
> > +     if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> >               mem_cgroup_flush_stats();
> >  }
> >
> > --
> > 2.40.0.348.gf938b09366-goog
>
> --
> Michal Hocko
> SUSE Labs
