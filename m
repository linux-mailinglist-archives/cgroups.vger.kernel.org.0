Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F68A77C468
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 02:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjHOA3Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 20:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjHOA3B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 20:29:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F37610DE
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 17:29:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bccc9ec02so689634866b.2
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 17:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692059339; x=1692664139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1lKc8UCS20HXuR6dZ0rRLPXdPOi2Gp9kpdm+wPioZA=;
        b=MMfQ/rxhV+SsA65fGuBjuQe0apk2cIeqwqBhMkO+8zOqb5kPwPqW9O3Zb/4RzJVlwf
         ic+ugnVvM/Jgs29lFDzYaYGp6IsQx7LrQTKlPaeaRDyNDCvCAzfanGOhQQfKSzQsBB13
         3e/YVG6A9CbUlf8V5a3jAlnuOFRYse+svOjPsaBEhK9RhWzg8ua9loRuGHQlTWaH44vg
         nbyNPZbFGZO/I30U8nrkBrs3llTa2l4HtNWN2KwrsUFPYx1ZXHw3i9W2bNveRZxUKzgs
         IG2O/dIiKNAgfU/voy1SjkaBYfrfyRM/nQzsiF2r7WR2+WhXcXfL8w3PjZ9uJUK9pwDq
         KBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692059339; x=1692664139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1lKc8UCS20HXuR6dZ0rRLPXdPOi2Gp9kpdm+wPioZA=;
        b=kvcL/Mnv0gc9akKbG3kt45G4rYPful/UjVEeiJecaRE/jk2vd0/zwxfRkWAjB0hGge
         g779cUM4Ui1PUF3Xo8DGFcleP8sAxuSz4AtB8yUCeGQHhaNudy+C4msDvzMeeXvFOZFR
         BRXK0AwvwpEyOB/7UocnYVQHCc3/lqaLxmk/lDRKsgycMe3b+CXI3b2UesSJL2KieT8b
         2Oro82VLKNCLJac1iyhhlRIaMypLuP7rNjXiyxcIXpoFwnvRnvODySA6wtlMsIotAPM8
         luv3dCrVD7uGMNkVaXwU0ZE+azV7lIuhKGQrft+3wKcJDnCv3qPo/j/+V2zaugLsLcSD
         HRRQ==
X-Gm-Message-State: AOJu0YxcdPunnZz8REtuG4sHTLQFE/IO/lRzOg7r+IXgwXBsdrZx7DkX
        7K9pQJgBHefJ4m+DEeIpBor7vOc3VgaiJ9wbdBQfgg==
X-Google-Smtp-Source: AGHT+IHzmE288zdevCwMqYYaWsmxRvV8FyIxGkMeUXfc3+nTin6UrBX+Yo5BFt164qJKfgmaUmrSvfMdnaEsHW961ZA=
X-Received: by 2002:a17:906:5307:b0:994:673:8af6 with SMTP id
 h7-20020a170906530700b0099406738af6mr9551032ejo.29.1692059338726; Mon, 14 Aug
 2023 17:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbJ1fnMDudtsS2xubKn0RTWz7t0Hem=PSRQQp3sGf-iOw@mail.gmail.com>
 <ZNaLGVUtPu7Ua/jL@dhcp22.suse.cz> <CAJD7tkbF1tNi8v0W4Mnqs0rzpRBshOFepxFTa1SiSvmBEBUEvw@mail.gmail.com>
 <CALvZod55S3XeK-MquTq0mDuipq8j0vFymQeX_XnPb_HuPK+oGQ@mail.gmail.com>
 <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
 <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
 <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
 <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com>
 <ZNdEaw2nktq1NfmH@dhcp22.suse.cz> <CAJD7tkaFHgc3eN1K1wYsQFWMLu4+Frf9DJ-5HOja2nC20Es9Dw@mail.gmail.com>
 <ZNrDWqfjXtAYhnvT@slm.duckdns.org>
In-Reply-To: <ZNrDWqfjXtAYhnvT@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 14 Aug 2023 17:28:22 -0700
Message-ID: <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 14, 2023 at 5:14=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Sat, Aug 12, 2023 at 04:04:32AM -0700, Yosry Ahmed wrote:
> > Taking a step back though, and considering there have been other
> > complaints about unified flushing causing expensive reads from
> > memory.stat [1], I am wondering if we should tackle the fundamental
> > problem.
> >
> > We have a single global rstat lock for flushing, which protects the
> > global per-cgroup counters as far as I understand. A single lock means
> > a lot of contention, which is why we implemented unified flushing on
> > the memcg side in the first place, where we only let one flusher
> > operate and everyone else skip, but that flusher needs to flush the
> > entire tree.
> >
> > This can be unnecessarily expensive (see [1]), and to avoid how
> > expensive it is we sacrifice accuracy (what this patch is about). I am
> > exploring breaking down that lock into per-cgroup locks, where a
> > flusher acquires locks in a top down fashion. This allows for some
> > concurrency in flushing, and makes unified flushing unnecessary. If we
> > retire unified flushing we fix both accuracy and expensive reads at
> > the same time, while not sacrificing performance for concurrent
> > in-kernel flushers.
> >
> > What do you think? I am prototyping something now and running some
> > tests, it seems promising and simple-ish (unless I am missing a big
> > correctness issue).
>
> So, the original design used mutex for synchronize flushing with the idea
> being that updates are high freq but reads are low freq and can be
> relatively slow. Using rstats for mm internal operations changed this
> assumption quite a bit and we ended up switching that mutex with a lock.

Naive question, do mutexes handle thundering herd problems better than
spinlocks? I would assume so but I am not sure.

>
> Here are some suggestions:
>
> * Update-side, per-cpu lock should be fine. I don't think splitting them
>   would buy us anything meaningful.

I agree, I was mainly concerned with the global flushing lock.

>
> * Flush-side, maybe we can break flushing into per-cpu or whatnot but
>   there's no avoiding the fact that flushing can take quite a while if th=
ere
>   are a lot to flush whether locks are split or not. I wonder whether it'=
d
>   be possible to go back to mutex for flushing and update the users to
>   either consume the cached values or operate in a sleepable context if
>   synchronous read is necessary, which is the right thing to do anyway gi=
ven
>   how long flushes can take.

Unfortunately it cannot be broken down into per-cpu as all flushers
update the same per-cgroup counters, so we need a bigger locking
scope. Switching to atomics really hurts performance. Breaking down
the lock to be per-cgroup is doable, but since we need to lock both
the parent and the cgroup, flushing top-level cgroups (which I assume
is most common) will lock the root anyway.

All flushers right now operate in sleepable context, so we can go
again to the mutex if you think this will make things better. The
slowness problem reported recently is in a sleepable context, it's
just too slow for userspace if I understand correctly.

+Ivan Babrou

What I am thinking about now is that since all flushers are sleepable,
perhaps the thundering herd problem would be less severe, since we may
release the lock (or mutex) at the cpu boundaries. I wonder if would
be better if we retire the unified flushing on the memcg side, so that
not all flushers need to flush the entire tree, and we allow
concurrent flushing.

This should address the slowness in reads (as proven by a patch by
Ivan [1]), and it should also address the inaccuracy addressed by this
thread, since no flushers will skip if someone else is flushing.

I am trying to test if there are any regressions by running some
synthetic stress testing (reclaim, refault, read stats, repeat), so
far I can't see any.

Two things that we will need to figure out if we retire unified flushing:
(a) We now have a global "stats_flush_threshold" variable to know when
to flush and when to skip. If flushing is not global, we need to make
this per-cgroup or retire it as well. If we make it per-cgroup it may
affect the update-side, and we will need to move it to the rstat code
I think.

(b) We now have a global "flush_next_time" to know whether the
ratelimited flusher should run or not. If we keep it, only the global
async flusher will kill it forward, sync flushers will not. Otherwise
we can also make it per-cgroup and update it during flushes.

[1]https://github.com/bobrik/linux/commit/50b627811d54
>
> Thanks.
>
> --
> tejun
