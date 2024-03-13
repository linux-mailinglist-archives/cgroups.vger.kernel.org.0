Return-Path: <cgroups+bounces-2045-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C143887A160
	for <lists+cgroups@lfdr.de>; Wed, 13 Mar 2024 03:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5108A1F222F9
	for <lists+cgroups@lfdr.de>; Wed, 13 Mar 2024 02:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50FCBA3F;
	Wed, 13 Mar 2024 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+SFhrBm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22CBA27
	for <cgroups@vger.kernel.org>; Wed, 13 Mar 2024 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295734; cv=none; b=GBFxcXgNOmjJXkonvUGR865Q8rwZkF6R6rO/D8UyJGnhXqRSowj2m6LN2PQOE+f/7UQCnxLI1f1QXvBBvfka+D2Rxd2jFY3T/m9PNRLmASHJE50UvBrVF5QDN4zTR8XtzLTa8JvmdYt1ojlhRMuBJYsevTpP7bfNck+fCwMnaEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295734; c=relaxed/simple;
	bh=ZX2eHyPyf4WlgykQVje6yiqVGnJt1S5l/nmDOWfN6UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLeV7MCJJ//0QnK+WJD2u4cprPIQxZb+ZFde0y04ecbhFn3557slPbyb2RIRyhbA2mW4GSSrVb4QGZ+b3+M7L45rt8FgvqKQQiEaOaVh0ciOwHi1PG3VhVjDeRu1elujwrzHpmBQGykMpq+u1T4r4ImO3Wat28jjNdEwUtQWyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+SFhrBm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412d84ffbfaso45515e9.0
        for <cgroups@vger.kernel.org>; Tue, 12 Mar 2024 19:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710295731; x=1710900531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NhuLx8Hd3VM7u/rZLXcaWHkS4clRr3sag751o8/rg4=;
        b=j+SFhrBmQUJo4LlKLIcFCNy/1DPfou1GzzTWQKZWGJ4MDARvJpjdXox4ay5PiRZo1o
         deExWP/S6LfoD5Lh2OuSpU3vUCbwe3TQTuXlLyWjxWf15jeEzjGYf6EvIStdVvTBczor
         PJcbRTYbb0Yd+iZTzuOS3rP8O65hdXGDHrw6VAtIlWRKE6nPJlBE7Nqi4CkvUzwyMa8v
         lTTXmnyfYtuYVkMMTLSYjbGvmd3NiSeBS1DBEIh3y3MWn5+7ZGF+8D7IazUtMG9CVkh9
         zLdTSSorxniR1GDiXpV8W4hXOSIzTpLUVttCJhYLkp3R0lHx8ZOKeNnq/R+xqGxF//sX
         xKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710295731; x=1710900531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NhuLx8Hd3VM7u/rZLXcaWHkS4clRr3sag751o8/rg4=;
        b=XkllXEXZMLgU3ymbyhBhzDFVdTOcsxuTmb3rT7jB9sBnEwL3lcw8Zhu8VjyQa7vnXh
         M6xdAuCBm/tsdfQ0tcYv5T3npauWC5jhiAwwznmzh3Eiw6bPczNlTrC92s0opqnXX9aH
         9UM1PzQldWto9Q/C1xETgRLlb9IWNUeolC7uSeHeJPXGzntxr8A+05XVZxwZo8g3aDTA
         PIvJsTeD1HTmsrhHFCOJ9G1lFNPVDBMI0ukgVCPK8xKv09VQv4IVgNsEaPO4lI8apPJy
         9MpS62iCraFxbzTO9agMe8g/BmAIWL1MHGlTuXjK1zOXnOG9ylzVAydlKB93HgpwMN3E
         godA==
X-Forwarded-Encrypted: i=1; AJvYcCUAUg2Ja4DXpRSRtWbzZnJmdUROflquyvvHooicdZk36cofRRHY5BukSz2S9Od+azAyiSz85Py6MWAWhBBZ6G2WDCFxFOW37w==
X-Gm-Message-State: AOJu0YxAFvFOKP3RFx2H97VuE8sxhj9uIyXy/sWlub/C9dvccrf9/CYq
	vdRjwf8JVLfyEeeJJkHPd5m+nFWs40CXv4uRk6SuBOWTzzZrliMrXQ8w+947RvThjBQ8QoteP5z
	G1JDgLaK3ErTvzNnWlanByHK+gddaAJ1wPAL+
X-Google-Smtp-Source: AGHT+IE22TKRWGA/6PaqMQKmQT2rQFAdr8rQqytN9on+vBz0f5TKP19RwLycd+OGxliog1WsIbUL3rhPAZw/TnTsIEY=
X-Received: by 2002:a05:600c:3d18:b0:412:f547:e3e0 with SMTP id
 bh24-20020a05600c3d1800b00412f547e3e0mr76860wmb.4.1710295730982; Tue, 12 Mar
 2024 19:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcWOh9u3uqZjNFMa@chrisdown.name> <20240229235134.2447718-1-axelrasmussen@google.com>
 <ZeEhvV15IWllPKvM@chrisdown.name> <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
 <CALOAHbBupMYBMWEzMK2xdhnqwR1C1+mJSrrZC1L0CKE2BMSC+g@mail.gmail.com>
 <CAJHvVcjhUNx8UP9mao4TdvU6xK7isRzazoSU53a4NCcFiYuM-g@mail.gmail.com>
 <ZfC16BikjhupKnVG@google.com> <20240312210822.GB65481@cmpxchg.org>
In-Reply-To: <20240312210822.GB65481@cmpxchg.org>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 12 Mar 2024 22:08:13 -0400
Message-ID: <CAOUHufa4zgWtA_XyWZUcQ7pqbarC2VpJd-=J--gy8tCGQin+yQ@mail.gmail.com>
Subject: Re: MGLRU premature memcg OOM on slow writes
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org, kernel-team@fb.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 5:08=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Mar 12, 2024 at 02:07:04PM -0600, Yu Zhao wrote:
> > Yes, these two are among the differences between the active/inactive
> > LRU and MGLRU, but their roles, IMO, are not as important as the LRU
> > positions of dirty pages. The active/inactive LRU moves dirty pages
> > all the way to the end of the line (reclaim happens at the front)
> > whereas MGLRU moves them into the middle, during direct reclaim. The
> > rationale for MGLRU was that this way those dirty pages would still
> > be counted as "inactive" (or cold).
>
> Note that activating the page is not a statement on the page's
> hotness. It's simply to park it away from the scanner. We could as
> well have moved it to the unevictable list - this is just easier.
>
> folio_end_writeback() will call folio_rotate_reclaimable() and move it
> back to the inactive tail, to make it the very next reclaim target as
> soon as it's clean.
>
> > This theory can be quickly verified by comparing how much
> > nr_vmscan_immediate_reclaim grows, i.e.,
> >
> >   Before the copy
> >     grep nr_vmscan_immediate_reclaim /proc/vmstat
> >   And then after the copy
> >     grep nr_vmscan_immediate_reclaim /proc/vmstat
> >
> > The growth should be trivial for MGLRU and nontrivial for the
> > active/inactive LRU.
> >
> > If this is indeed the case, I'd appreciate very much if anyone could
> > try the following (I'll try it myself too later next week).
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 4255619a1a31..020f5d98b9a1 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4273,10 +4273,13 @@ static bool sort_folio(struct lruvec *lruvec, s=
truct folio *folio, struct scan_c
> >       }
> >
> >       /* waiting for writeback */
> > -     if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> > -         (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> > -             gen =3D folio_inc_gen(lruvec, folio, true);
> > -             list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
> > +     if (folio_test_writeback(folio) || (type =3D=3D LRU_GEN_FILE && f=
olio_test_dirty(folio))) {
> > +             DEFINE_MAX_SEQ(lruvec);
> > +             int old_gen, new_gen =3D lru_gen_from_seq(max_seq);
> > +
> > +             old_gen =3D folio_update_gen(folio, new_gen);
> > +             lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> > +             list_move(&folio->lru, &lrugen->folios[new_gen][type][zon=
e]);
> >               return true;
>
> Right, because MGLRU sorts these pages out before calling the scanner,
> so they never get marked for immediate reclaim.
>
> But that also implies they won't get rotated back to the tail when
> writeback finishes.

Those dirty pages are marked by PG_reclaim either by

  folio_inc_gen()
  {
    ...
    if (reclaiming)
      new_flags |=3D BIT(PG_reclaim);
    ...
  }

or [1], which I missed initially. So they should be rotated on writeback
finishing up.

[1] https://lore.kernel.org/linux-mm/ZfC2612ZYwwxpOmR@google.com/

> Doesn't that mean that you now have pages that
>
> a) came from the oldest generation and were only deferred due to their
>    writeback state, and
>
> b) are now clean and should be reclaimed. But since they're
>    permanently advanced to the next gen, you'll instead reclaim pages
>    that were originally ahead of them, and likely hotter.
>
> Isn't that an age inversion?
>
> Back to the broader question though: if reclaim demand outstrips clean
> pages and the only viable candidates are dirty ones (e.g. an
> allocation spike in the presence of dirty/writeback pages), there only
> seem to be 3 options:
>
> 1) sleep-wait for writeback
> 2) continue scanning, aka busy-wait for writeback + age inversions
> 3) find nothing and declare OOM
>
> Since you're not doing 1), it must be one of the other two, no? One
> way or another it has to either pace-match to IO completions, or OOM.

Yes, and in this case, 2) is possible but 3) is very likely.

MGLRU doesn't do 1) for sure (in the reclaim path of course). I didn't
find any throttling on dirty pages for cgroup v2 either in the
active/inactive LRU -- I assume Chris was on v2, and hence my take on
throttling on dirty pages in the reclaim path not being the key for
his case.

With the above change, I'm hoping balance_dirty_pages() will wake up
the flusher, again for Chris' case, so that MGLRU won't have to call
wakeup_flusher_threads(), since it can wake up the flusher too often
and in turn cause excessive IOs when considering SSD wearout.

