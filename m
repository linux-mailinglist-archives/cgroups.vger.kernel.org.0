Return-Path: <cgroups+bounces-2046-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCAA87A1E7
	for <lists+cgroups@lfdr.de>; Wed, 13 Mar 2024 04:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D858E281322
	for <lists+cgroups@lfdr.de>; Wed, 13 Mar 2024 03:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745F6C147;
	Wed, 13 Mar 2024 03:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="KaD2iefG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A610A11
	for <cgroups@vger.kernel.org>; Wed, 13 Mar 2024 03:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710300182; cv=none; b=JuoWkbbSsbCyL0tBHlztrUIxRQJWQEXRWn62I2y84utLfPCziBze4JNghz6MgrJ64xXU3HBC95En1p3oqLN7d00ZkIM+RgAxjH2NUBZtYIB/1djy3wBUkMIK44appwk0x1zecdqadVOGgp0l8/mRGgo94ZRwyCtm2YfzMOlcgOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710300182; c=relaxed/simple;
	bh=hl5ZoMuzUEmc9kv6s9BMU8R+ukkBxx61EIIgx8VCdAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUnkCA3d44dAlvLZK/BsjiJ8JU/8tjqbXRpTSEZPEBfizjOKAyC/pHO5ppIE3s9JVXV48WLHfG30bCcShmdVOYO4fkFYvFgC2wRJODN+AiV4PPbRbSh+JnVqOEJAmJRRo0f3QxdYiIklADQPYZZPx6wEwJlA/MwCEUkdFhRlrAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=KaD2iefG; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-690f50d0465so5216766d6.3
        for <cgroups@vger.kernel.org>; Tue, 12 Mar 2024 20:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710300178; x=1710904978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F3s4TTJvMJqkMSqpK1DSgijjltVsFyttY+B0U/uTxh8=;
        b=KaD2iefG1y5YKiLYx8EfXr9HnpM8mZzDFnP8/GJYMx87zIe7dCyoEg6h7BhXsi5puR
         0jTuvMW+9CQha2JjI/R/KeP+p8ah9ETac9ACL9WLdSVRSbJoyQC0htuz7myiuuAtZNG/
         P0WalgfZBEzFRhE/Z69KaElIY6RRa4X4nYvraxWsp2hyuEjCTIKO/9zw8NNrzbIh7t6W
         faCWAcbFnJVJwl6xkFxUIn0ZGhk/7nqjpqt1uNuUFUelySqgTbEC7vLfLSY0y5iTdnff
         tf3sn4YuXGUo4o2RFWJ7dgKZZiLa+rEYpUAkhywN3zGgoAJQVn/fsC4cZ/6dZf8D6zag
         F2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710300178; x=1710904978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3s4TTJvMJqkMSqpK1DSgijjltVsFyttY+B0U/uTxh8=;
        b=EhWISoVS4KwVc8P6XXkhLxIV0CAG5IIkF9oWd/PmeFwV+9EvEIVCRgmrmGEQ7zbCiX
         CfKgqUPuJ6NxwgZWKtLkObNl1SmlZB4jwWywOpatnKqQL4k1kWbvKv/F6sSKjTtH9dni
         L56UI91MrhHMZsCm7ypa66NED7Qb51re8sR5tvmILJORG+/3aDBehqJ2dWuGqjg4PlP6
         bbFCiSZiyO3KtMHvtGdtqGCdXVdv9gMKTqMbOZQ2FsuzkSF0C3ZhX5RxvGf2lW1cL4f0
         KXEFOLYyGKsQUCcZfcBcB+ZFb94OSvf4TC1q1WQbXYDJ166hvuyEV2tMkpJUEOwxxCi4
         TzkA==
X-Forwarded-Encrypted: i=1; AJvYcCXbtEqJOZZMd3tZ8alnKVhq/IqjXAXYzkZBPhu4lnqqKbb2oFM0GKqzq1JChFe5/213KX+WM7WTdfzMaG22QGdfw3OptFoOFg==
X-Gm-Message-State: AOJu0Yx+GmKIMjLaOtFoh0mBXcNamx8l80It7/uJiWTfgx8oAXfhhe62
	/tITRghbOx1XQkFYKhWLl+BchV+DHtlsJGbHrH8fD9UEqrwMEHnfsAau5IPXBVU=
X-Google-Smtp-Source: AGHT+IE25aWzB9YRFFO0A4gFZzCu3BbWwIOuemelHGf/0tverskxS3u0zwO6AT/bjd6L66vmac86kA==
X-Received: by 2002:ad4:4c04:0:b0:690:db76:9710 with SMTP id bz4-20020ad44c04000000b00690db769710mr5489122qvb.51.1710300178009;
        Tue, 12 Mar 2024 20:22:58 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id m18-20020a05621402b200b00690ce64c0a0sm2806862qvv.30.2024.03.12.20.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 20:22:57 -0700 (PDT)
Date: Tue, 12 Mar 2024 23:22:52 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org,
	kernel-team@fb.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: MGLRU premature memcg OOM on slow writes
Message-ID: <20240313032252.GC65481@cmpxchg.org>
References: <ZcWOh9u3uqZjNFMa@chrisdown.name>
 <20240229235134.2447718-1-axelrasmussen@google.com>
 <ZeEhvV15IWllPKvM@chrisdown.name>
 <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
 <CALOAHbBupMYBMWEzMK2xdhnqwR1C1+mJSrrZC1L0CKE2BMSC+g@mail.gmail.com>
 <CAJHvVcjhUNx8UP9mao4TdvU6xK7isRzazoSU53a4NCcFiYuM-g@mail.gmail.com>
 <ZfC16BikjhupKnVG@google.com>
 <20240312210822.GB65481@cmpxchg.org>
 <CAOUHufa4zgWtA_XyWZUcQ7pqbarC2VpJd-=J--gy8tCGQin+yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufa4zgWtA_XyWZUcQ7pqbarC2VpJd-=J--gy8tCGQin+yQ@mail.gmail.com>

On Tue, Mar 12, 2024 at 10:08:13PM -0400, Yu Zhao wrote:
> On Tue, Mar 12, 2024 at 5:08 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Mar 12, 2024 at 02:07:04PM -0600, Yu Zhao wrote:
> > > Yes, these two are among the differences between the active/inactive
> > > LRU and MGLRU, but their roles, IMO, are not as important as the LRU
> > > positions of dirty pages. The active/inactive LRU moves dirty pages
> > > all the way to the end of the line (reclaim happens at the front)
> > > whereas MGLRU moves them into the middle, during direct reclaim. The
> > > rationale for MGLRU was that this way those dirty pages would still
> > > be counted as "inactive" (or cold).
> >
> > Note that activating the page is not a statement on the page's
> > hotness. It's simply to park it away from the scanner. We could as
> > well have moved it to the unevictable list - this is just easier.
> >
> > folio_end_writeback() will call folio_rotate_reclaimable() and move it
> > back to the inactive tail, to make it the very next reclaim target as
> > soon as it's clean.
> >
> > > This theory can be quickly verified by comparing how much
> > > nr_vmscan_immediate_reclaim grows, i.e.,
> > >
> > >   Before the copy
> > >     grep nr_vmscan_immediate_reclaim /proc/vmstat
> > >   And then after the copy
> > >     grep nr_vmscan_immediate_reclaim /proc/vmstat
> > >
> > > The growth should be trivial for MGLRU and nontrivial for the
> > > active/inactive LRU.
> > >
> > > If this is indeed the case, I'd appreciate very much if anyone could
> > > try the following (I'll try it myself too later next week).
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 4255619a1a31..020f5d98b9a1 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -4273,10 +4273,13 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
> > >       }
> > >
> > >       /* waiting for writeback */
> > > -     if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> > > -         (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
> > > -             gen = folio_inc_gen(lruvec, folio, true);
> > > -             list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
> > > +     if (folio_test_writeback(folio) || (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
> > > +             DEFINE_MAX_SEQ(lruvec);
> > > +             int old_gen, new_gen = lru_gen_from_seq(max_seq);
> > > +
> > > +             old_gen = folio_update_gen(folio, new_gen);
> > > +             lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> > > +             list_move(&folio->lru, &lrugen->folios[new_gen][type][zone]);
> > >               return true;
> >
> > Right, because MGLRU sorts these pages out before calling the scanner,
> > so they never get marked for immediate reclaim.
> >
> > But that also implies they won't get rotated back to the tail when
> > writeback finishes.
> 
> Those dirty pages are marked by PG_reclaim either by
> 
>   folio_inc_gen()
>   {
>     ...
>     if (reclaiming)
>       new_flags |= BIT(PG_reclaim);
>     ...
>   }
> 
> or [1], which I missed initially. So they should be rotated on writeback
> finishing up.
> 
> [1] https://lore.kernel.org/linux-mm/ZfC2612ZYwwxpOmR@google.com/

Ah, I missed that! Thanks.

> > Doesn't that mean that you now have pages that
> >
> > a) came from the oldest generation and were only deferred due to their
> >    writeback state, and
> >
> > b) are now clean and should be reclaimed. But since they're
> >    permanently advanced to the next gen, you'll instead reclaim pages
> >    that were originally ahead of them, and likely hotter.
> >
> > Isn't that an age inversion?
> >
> > Back to the broader question though: if reclaim demand outstrips clean
> > pages and the only viable candidates are dirty ones (e.g. an
> > allocation spike in the presence of dirty/writeback pages), there only
> > seem to be 3 options:
> >
> > 1) sleep-wait for writeback
> > 2) continue scanning, aka busy-wait for writeback + age inversions
> > 3) find nothing and declare OOM
> >
> > Since you're not doing 1), it must be one of the other two, no? One
> > way or another it has to either pace-match to IO completions, or OOM.
> 
> Yes, and in this case, 2) is possible but 3) is very likely.
> 
> MGLRU doesn't do 1) for sure (in the reclaim path of course). I didn't
> find any throttling on dirty pages for cgroup v2 either in the
> active/inactive LRU -- I assume Chris was on v2, and hence my take on
> throttling on dirty pages in the reclaim path not being the key for
> his case.

It's kind of spread out, but it's there:

shrink_folio_list() will bump nr_dirty on dirty pages, and
nr_congested if immediate reclaim folios cycle back around.

shrink_inactive_list() will wake the flushers if all the dirty pages
it encountered are still unqueued.

shrink_node() will set LRUVEC_CGROUP_CONGESTED, and then call
reclaim_throttle() on it. (As Chris points out, though, the throttle
call was not long ago changed from VMSCAN_THROTTLE_WRITEBACK to
VMSCAN_THROTTLE_CONGESTED, and appears a bit more fragile now than it
used to be. Probably worth following up on this.)

