Return-Path: <cgroups+bounces-3849-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458E79394AA
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 22:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC74928214F
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 20:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F181CF96;
	Mon, 22 Jul 2024 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USgNB1AN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6F1CA8D
	for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721679195; cv=none; b=GLaYD0nfo+IfW3nMI8htkpoE5Aknwg4e+6D30tTDvwqJDDng5ql58pzet8U+YIMkFbqe5g/xIGGdcVsy0z0Q8YP8DpxoS1tmR4fQfM/2Wesm50gs5Z7BidkGkYXsj/SpXTBMOs6/JbkbZVAe0ISMujY5PlUlv0hsBygbzVTu/+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721679195; c=relaxed/simple;
	bh=2DLshzPVIVPJzHaNLihZvokorjuIGDPme5uHAlgV1PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6e6OzbosVi3X3M6/RWAjXZ5KPREL4wCjWcWpBVEI8d5aPubcPIIsxWsBROYD2C835ibW3A9azvTwiKucR/jElb8GyyAmN3G49H0v3lTENkqaINKh+XWVDqfKY92hRWnc6NU6mnJXqj6ouxvIYT2nCQDs2zRA9EdGYbfHiNfa3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USgNB1AN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77c1658c68so511507866b.0
        for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721679192; x=1722283992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJd3T01oYiu8j24gOC/Fh6PQsujZog8KkMGblRRhmrY=;
        b=USgNB1ANsd/80P2vvqoaDhTbCX7W8WtAbGDLAf3FrrbWA87jjuoa8bPMjLyu7Pdabv
         xtXZwPvEzf+rdM2pZ/baNOACDYUBdeg9GA5l9i8o1PADAZnDOWqI18UtX46r554RyIqs
         S17t2Zwqnn4ZDK5ktzbaj+tT/FiLPl41dC6r0O0N/Ac5fZ/xBqdmb3HVnikoEQJWqOax
         uPIBAoST557QxAColNB3H9+H5vZNG0b53Q7bnnUu40hvIpRZ9k2VkAOMnTv+NadVRa02
         jT60Qlm3pPeUYe+yBiuh9KZ4fA9cAihkgXHHkXUtiLXAvC9GfDDBUWQtrA3XaNpRpVvq
         7UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721679192; x=1722283992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJd3T01oYiu8j24gOC/Fh6PQsujZog8KkMGblRRhmrY=;
        b=hVCBmDA73fzojm/JIFQqqxWJ0F/hIXhc1WqC6UzYLJdrN7lqoc7UUyJWNGEVn6zdLP
         zgszdItaqLeEqlsO2cMc5FoqIIIWMEuQRr6YhTsQPgtG474m8oOhEOlvPMcUlk142qLa
         46d/0IZirKh0SufoQZdR61dsHpouz5s8g7woIPJz9QAWRpwhIiDJ4S7HpEn6gAVrL2tc
         XuJa2cQBPEwfGl3o6KIUSqXvV8xi0z1Lvpq+OcsNjbp56Cwpi3uPHwf/K/vKGJ5qTF0i
         BCPT1Z0NlL7JcW+R58G4QjKZpB8R11CadEgbjqQBU7GuREgAE+QfpyX65UG8oHDzi5Ry
         7R/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjQpk/r2puka40upN+Efvp0DjYtuVahEhuh+d9hv2VvXdnZLu7M87K4IIeCcCprLMUgz+RdEpgS5WuC8CAOl1mm2FOJda1RQ==
X-Gm-Message-State: AOJu0YwRwrPv0PwFQEJ39Xp/Gdcv14bmp2UNVzKAwtXw/fnaLSq/cnE4
	lclJSqNlBXYI0lhu4oZNZXtFdU9nh1/1ONxZuEfuRGUeC0ufLBnGRQ1RC6Tn/00JZnEvOTb2qKi
	J2opYTcK+QrwJvIMhigpRI9+rRtO62AGeUMbf
X-Google-Smtp-Source: AGHT+IHCjnNfOg3AA/xVJEkipAdE4qARcHS7Iri9W3Xj51is2F8E2h6wLQ5Ncs2KJuGZQiG6jIsE2XCmE+iY3tHppiY=
X-Received: by 2002:a17:907:97cd:b0:a6e:d339:c095 with SMTP id
 a640c23a62f3a-a7a8847a8f6mr69961866b.47.1721679191779; Mon, 22 Jul 2024
 13:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org> <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org> <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
 <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org> <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
 <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com> <t5vnayr43kpi2nn7adjgbct4ijfganbowoubfcxynpewiixvei@7kprlv6ek7vd>
In-Reply-To: <t5vnayr43kpi2nn7adjgbct4ijfganbowoubfcxynpewiixvei@7kprlv6ek7vd>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 22 Jul 2024 13:12:35 -0700
Message-ID: <CAJD7tkZV3PF7TR2HWxXxkhhS8oajOwX1VG7czdTQb8tRY9Jwpw@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 1:02=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Jul 19, 2024 at 09:52:17PM GMT, Yosry Ahmed wrote:
> > On Fri, Jul 19, 2024 at 3:48=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Fri, Jul 19, 2024 at 09:54:41AM GMT, Jesper Dangaard Brouer wrote:
> > > >
> > > >
> > > > On 19/07/2024 02.40, Shakeel Butt wrote:
> > > > > Hi Jesper,
> > > > >
> > > > > On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wr=
ote:
> > > > > >
> > > > > [...]
> > > > > >
> > > > > >
> > > > > > Looking at the production numbers for the time the lock is held=
 for level 0:
> > > > > >
> > > > > > @locked_time_level[0]:
> > > > > > [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        =
       |
> > > > > > [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@|
> > > > > > [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                            =
       |
> > > > > > [32M, 64M)   275 |@@@@@@@@@@@@@@@@                             =
       |
> > > > > >
> > > > >
> > > > > Is it possible to get the above histogram for other levels as wel=
l?
> > > >
> > > > Data from other levels available in [1]:
> > > >  [1]
> > > > https://lore.kernel.org/all/8c123882-a5c5-409a-938b-cb5aec9b9ab5@ke=
rnel.org/
> > > >
> > > > IMHO the data shows we will get most out of skipping level-0 root-c=
group
> > > > flushes.
> > > >
> > >
> > > Thanks a lot of the data. Are all or most of these locked_time_level[=
0]
> > > from kswapds? This just motivates me to strongly push the ratelimited
> > > flush patch of mine (which would be orthogonal to your patch series).
> >
> > Jesper and I were discussing a better ratelimiting approach, whether
> > it's measuring the time since the last flush, or only skipping if we
> > have a lot of flushes in a specific time frame (using __ratelimit()).
> > I believe this would be better than the current memcg ratelimiting
> > approach, and we can remove the latter.
> >
> > WDYT?
>
> The last statement gives me the impression that you are trying to fix
> something that is not broken. The current ratelimiting users are ok, the
> issue is with the sync flushers. Or maybe you are suggesting that the new
> ratelimiting will be used for all sync flushers and current ratelimiting
> users and the new ratelimiting will make a good tradeoff between the
> accuracy and potential flush stall?

The latter. Basically the idea is to have more informed and generic
ratelimiting logic in the core rstat flushing code (e.g. using
__ratelimit()), which would apply to ~all flushers*. Then, we ideally
wouldn't need mem_cgroup_flush_stats_ratelimited() at all.

*The obvious exception is the force flushing case we discussed for
cgroup_rstat_exit().

In fact, I think we need that even with the ongoing flusher
optimization, because I think there is a slight chance that a flush is
missed. It wouldn't be problematic for other flushers, but it
certainly can be for cgroup_rstat_exit() as the stats will be
completely dropped.

The scenario I have in mind is:
- CPU 1 starts a flush of cgroup A. Flushing complete, but waiters are
not woke up yet.
- CPU 2 updates the stats of cgroup A after it is flushed by CPU 1.
- CPU 3 calls cgroup_rstat_exit(), sees the ongoing flusher and waits.
- CPU 1 wakes up the waiters.
- CPU 3 proceeds to destroy cgroup A, and the updates made by CPU 2 are los=
t.

