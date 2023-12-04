Return-Path: <cgroups+bounces-788-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD37803EC9
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 20:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088E51C20ABC
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 19:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E133307D;
	Mon,  4 Dec 2023 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBCB65ta"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684CDD2
	for <cgroups@vger.kernel.org>; Mon,  4 Dec 2023 11:52:07 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54bf9a54fe3so6236855a12.3
        for <cgroups@vger.kernel.org>; Mon, 04 Dec 2023 11:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701719526; x=1702324326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eYidRuFuyjgtGaepFNp4s5KekmZ8R0Vv2VOTsdlcvvk=;
        b=bBCB65tagxMbJm06o9N432XeCR4VFyR9V1b1/flkMi76CJewjryEFwrNwis8LdAway
         xBGd7K+a5+beoo5qj5238UhxJqhuGHR39kCM548IyOsgRhTSJQcf9WYqH7UmW9l2h2e1
         zfVBu/b1Pp5AB5k/52q3MO2ENFRjuTWWdeD2Z1AHmTttlJi8CQn/HL+5q7AsZiOmub02
         F6d0U8Ps5HqtAHDXPOOOkRVULiPIGqqB4+4ugBoKedUnnyJfNYJn/aYojZhHCQEmsFqI
         /KOdQIY8iDqW8cRBSPmY4evBCUhgVa5OucGoa1JpQ1OTdxYjI8PPR6rGf4Xiem+l4zp+
         G/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701719526; x=1702324326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYidRuFuyjgtGaepFNp4s5KekmZ8R0Vv2VOTsdlcvvk=;
        b=cV78oygdCwCui2otGlDXqiLrcdF6DgrR0ul/K6F6fqfii5Mlmp7QHw/hk7Ih/TtXH8
         5jZqLBuIKxfXaEC624nco+bkfopD8COalisODKeUp3grCd1MlRzy3Pe8k9Mb95O5pv04
         kSv9WOK5UWphOIhNQfcDxJPdXJjAo+ZUB3Z6ydPatzVhV1x+iObkii/vMpXeMKVBubHD
         o3u3EuVzKJbmlgbGeUGCEFZJ0r7hXYj+O6V+uCgEVfsx+zo9BAYqTtxwIig/9vhahSiH
         qD/O0raCA/5goSW48L+V043oTaYqBkYi4pC71jKl1neAlAhBmMGQPnGlASxHAyDgzq/i
         g2TQ==
X-Gm-Message-State: AOJu0Yz/hW8XI9Ip6JIaPNkFtP8sUMN3FxzT98klAi2zWoQcEOiprQ3R
	Z7wUOHXufPu2bdMzzZj6Z32a5McBtrgA/OndC6Yodw==
X-Google-Smtp-Source: AGHT+IFlwZwLSTjml6GJX9pmadhYbMF7fdFHsa20v/3WIXVEPDjbDlUP+SUIT8iByELIZI3zCmeFa5ieAkvSDn1t5m8=
X-Received: by 2002:a17:906:2207:b0:a16:37ce:f81a with SMTP id
 s7-20020a170906220700b00a1637cef81amr3789708ejs.8.1701719525571; Mon, 04 Dec
 2023 11:52:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <ZWqPBHCXz4nBIQFN@archie.me>
In-Reply-To: <ZWqPBHCXz4nBIQFN@archie.me>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 4 Dec 2023 11:51:29 -0800
Message-ID: <CAJD7tkbk=AUfjuq+6HiPwNeoUi===h99rbJ2RkhN6dCk2E2xdg@mail.gmail.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Attreyee M <tintinm2017@gmail.com>, 
	Linux Memory Management List <linux-mm@kvack.org>, Linux CGroups <cgroups@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

[..]
> > diff --git a/mm/workingset.c b/mm/workingset.c
> > index dce41577a49d2..7d3dacab8451a 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -464,8 +464,12 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
> >
> >       rcu_read_unlock();
> >
> > -     /* Flush stats (and potentially sleep) outside the RCU read section */
> > -     mem_cgroup_flush_stats_ratelimited();
> > +     /*
> > +      * Flush stats (and potentially sleep) outside the RCU read section.
> > +      * XXX: With per-memcg flushing and thresholding, is ratelimiting
> > +      * still needed here?
> > +      */
> > +     mem_cgroup_flush_stats_ratelimited(eviction_memcg);
>
> What if flushing is not rate-limited (e.g. above line is commented)?
>

Hmm I think I might be misunderstanding the question. The call to
mem_cgroup_flush_stats_ratelimited() does not ratelimit other
flushers, it is rather a flush call that is itself ratelimited. IOW,
it may or may not flush based on when was the last time someone else
flushed.

This was introduced because flushing in the fault path was expensive
in some cases, so we wanted to avoid flushing if someone else recently
did a flush, as we don't expect a lot of pending changes in this case.
However, that was when flushing was always on the root level. Now that
we are flushing on the memcg level, it may no longer be needed as:
- The flush is more scoped, there should be less work to do.
- There is a per-memcg threshold now such that we only flush when
there are pending updates in this memcg.

This is why I added a comment that the ratelimited flush here may no
longer be needed. I didn't want to investigate this as part of this
series, especially that I do not have a reproducer for the fault
latency introduced by the flush before ratelimiting. Hence, I am
leaving the comment such that people know that this ratelimiting may
no longer be needed with this patch.

> >
> >       eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
> >       refault = atomic_long_read(&eviction_lruvec->nonresident_age);
> > @@ -676,7 +680,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
> >               struct lruvec *lruvec;
> >               int i;
> >
> > -             mem_cgroup_flush_stats();
> > +             mem_cgroup_flush_stats(sc->memcg);
> >               lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
> >               for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
> >                       pages += lruvec_page_state_local(lruvec,
>
> Confused...

Which part is confusing? The call to mem_cgroup_flush_stats() now
receives a memcg argument as flushing is scoped to that memcg only to
avoid doing unnecessary work to flush other memcgs with global
flushing.

