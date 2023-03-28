Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B2F6CCA8B
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 21:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjC1TZ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 15:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjC1TZ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 15:25:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148EE30FF
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 12:25:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ew6so54002401edb.7
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680031555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYVDDjmV6wnF+h+msRo3LvXGWbt+x6xaJ8ueYBE6V3E=;
        b=BaLdgM8sqhxXwzLNbWAseZe+RqH1V2Sxs6j8JzObpqe9YjEP8JsX8TXeaMf+tc9bym
         4pp1VtiAZrkxoLk2jEtPY08u49gPKMB4A0lOKXg2oLmI0TroEAp1axYyJ3B+ARJsLv+c
         mw/J0LkPXvTpu0NHSZ4T9irM+kQ2F5RGBgpTu41aaqfuGNoawCk7WRP7VaDojs2eXk+I
         Cm0w6GcKp0rzsvxN21JQV73VRADwsRLJd6t6qgfy7/KJ2DjGHz6fyMJf4qXPhjfQVBBe
         H4Xjep3XOfuuMGi+vysHQx0repx2BNbxM986ZzMl8QQEWv1tRFLZUpz6u5NU3aX1h0Co
         rTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680031555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYVDDjmV6wnF+h+msRo3LvXGWbt+x6xaJ8ueYBE6V3E=;
        b=N53qPtcby4q0rI4c/9OblIu3aQVVrcInohZ9xwSnC15Cy077QZS64bToo/TFAh26kJ
         scrXHC1geN21WoKntyKKc88LXoxl1EcMpIDV5MXxEjslax6HeL1L+iHd616x1I6GaW22
         rvO2CCFL8sGxXj4XdIXBRPC8CZfYemALIX+bs0Bjk7YQidWghgMhoHtLGt4r44NNVr/U
         9jQPoROwlHuiV7Vr/5LoCW6IRkGuYDQ5jMTrmmuPcr12Gvcq+NHORAa0TMTpCYFv8o2/
         KlucPaPe+R8tySz/utL7aK5czg+k6gMlXDYfs8YNeeg5GZODDPAryjMZFBK8/aa/Xjlr
         O9bQ==
X-Gm-Message-State: AAQBX9f7v2PzdgrnBwZZo4MmzVIcv7TEjncZ5PlX24PiSXDpHhNYzhFb
        tVRvN0cxNDij92oNNJaBG1BJodFr0RbchQQKNPGt8A==
X-Google-Smtp-Source: AKy350a+XaQ6DLWOMWjURrXcmWrXUq0p8PNs4UFXK/Io6RXnckoQfVquWqaoZZdAGBWkL1lVbbwbi6GclX+O0lCI1Ak=
X-Received: by 2002:a50:9f62:0:b0:4fa:d8aa:74ad with SMTP id
 b89-20020a509f62000000b004fad8aa74admr8151266edf.8.1680031555382; Tue, 28 Mar
 2023 12:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-8-yosryahmed@google.com> <CALvZod5_NVTrYUhLjc3Me=CC6y3R4bhA71mCt-jXo0rX+2zUxw@mail.gmail.com>
In-Reply-To: <CALvZod5_NVTrYUhLjc3Me=CC6y3R4bhA71mCt-jXo0rX+2zUxw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Mar 2023 12:25:19 -0700
Message-ID: <CAJD7tkY1cNcHpNdjXcG8EGCGLJP6+_kkkJYn-yGZ_hJLB6hGmA@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] workingset: memcg: sleep when flushing stats in workingset_refault()
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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

On Tue, Mar 28, 2023 at 8:18=E2=80=AFAM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > In workingset_refault(), we call mem_cgroup_flush_stats_ratelimited()
> > to flush stats within an RCU read section and with sleeping disallowed.
> > Move the call to mem_cgroup_flush_stats_ratelimited() above the RCU rea=
d
> > section and allow sleeping to avoid unnecessarily performing a lot of
> > work without sleeping.
> >
> > Since workingset_refault() is the only caller of
> > mem_cgroup_flush_stats_ratelimited(), just make it call the non-atomic
> > mem_cgroup_flush_stats().
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> A nit below:
>
> Acked-by: Shakeel Butt <shakeelb@google.com>
>
> > ---
> >  mm/memcontrol.c | 12 ++++++------
> >  mm/workingset.c |  4 ++--
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 57e8cbf701f3..0c0e74188e90 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -674,12 +674,6 @@ void mem_cgroup_flush_stats_atomic(void)
> >                 __mem_cgroup_flush_stats_atomic();
> >  }
> >
> > -void mem_cgroup_flush_stats_ratelimited(void)
> > -{
> > -       if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> > -               mem_cgroup_flush_stats_atomic();
> > -}
> > -
> >  /* non-atomic functions, only safe from sleepable contexts */
> >  static void __mem_cgroup_flush_stats(void)
> >  {
> > @@ -695,6 +689,12 @@ void mem_cgroup_flush_stats(void)
> >                 __mem_cgroup_flush_stats();
> >  }
> >
> > +void mem_cgroup_flush_stats_ratelimited(void)
> > +{
> > +       if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> > +               mem_cgroup_flush_stats();
> > +}
> > +
> >  static void flush_memcg_stats_dwork(struct work_struct *w)
> >  {
> >         __mem_cgroup_flush_stats();
> > diff --git a/mm/workingset.c b/mm/workingset.c
> > index af862c6738c3..7d7ecc46521c 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -406,6 +406,8 @@ void workingset_refault(struct folio *folio, void *=
shadow)
> >         unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset)=
;
> >         eviction <<=3D bucket_order;
> >
> > +       /* Flush stats (and potentially sleep) before holding RCU read =
lock */
>
> I think the only reason we use rcu lock is due to
> mem_cgroup_from_id(). Maybe we should add mem_cgroup_tryget_from_id().
> The other caller of mem_cgroup_from_id() in vmscan is already doing
> the same and could use mem_cgroup_tryget_from_id().

I think different callers of mem_cgroup_from_id() want different things.

(a) workingset_refault() reads the memcg from the id and doesn't
really care if the memcg is online or not.

(b) __mem_cgroup_uncharge_swap() reads the memcg from the id and drops
refs acquired on the swapout path. It doesn't need tryget as we should
know for a fact that we are holding refs from the swapout path. It
doesn't care if the memcg is online or not.

(c) mem_cgroup_swapin_charge_folio() reads the memcg from the id and
then gets a ref with css_tryget_online() -- so only if the refcount is
non-zero and the memcg is online.

So we would at least need mem_cgroup_tryget_from_id() and
mem_cgroup_tryget_online_from_id() to eliminate all direct calls of
mem_cgroup_from_id(). I am hesitant about (b) because if we use
mem_cgroup_tryget_from_id() the code will be getting a ref, then
dropping the ref we have been carrying from swapout, then dropping the
ref we just acquired.

 WDYT?


>
> Though this can be done separately to this series (if we decide to do
> it at all).
