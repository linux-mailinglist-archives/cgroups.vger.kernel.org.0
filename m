Return-Path: <cgroups+bounces-3731-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C57EC933E54
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 16:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514031F21F26
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 14:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34A7181329;
	Wed, 17 Jul 2024 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="XpxxXqBh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFAF1802DC
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226262; cv=none; b=X5xlzwPCEQ9elQEA2zv9PY+jR3YH0zhKoe2i1nmNz4xTVc8zAiXWuIb+yg7pTi5CqlClM71WJUcvHFRMsXmK05Mi3qBfUYnPVOMgxWk1MB0trg9gS3jgwiYAi+uLOmr4ouK6rKsFgKVK7Nnbea3Am6tlv39CZvfKF9N2+5auLC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226262; c=relaxed/simple;
	bh=Hj+0meFYGMBzJH7JTeMBoz5trc0iefK5H1vFgRRUTkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEpVpUjHxkIMoPP6/3oi3L312yVFMtIWjzw+XzvNnJC7pQkitmhkhdFqfTj5vsp2qUjEXuUdNG0OI9O+IUQkeafJVc86KU36u3tZx88nfj6RlreWQAejCRI2UqpdGoovLLfXNID3QAf56I+cwUwFx7RAvQiRc6/nW8cL5VAlmxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=XpxxXqBh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af0684c2bso4531898b3a.0
        for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721226259; x=1721831059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj+0meFYGMBzJH7JTeMBoz5trc0iefK5H1vFgRRUTkQ=;
        b=XpxxXqBhDsUTmKfsCyuw0AZ88lK18ksfBE52vLWcLUqCGnAwwleaJpsFCbm7WobFMk
         X2zXmgCXxRVxvVdmiIJDs/t4FUCqE+jvdxNE1Hzw+YeLBzukyLZ5PIh6L593NSMkBFuk
         saAExX57MONXfGTU8VmoJHVl1sQ9LPpS4Ov0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721226259; x=1721831059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hj+0meFYGMBzJH7JTeMBoz5trc0iefK5H1vFgRRUTkQ=;
        b=J2HVyia/E7OvNavGPvp76lb9N05of7YXzpEz24+0VYH5fpef3i/hO/sPCX03JqFd4q
         Vy0M+SZYLTVSVJOiRTHvu8x3PHleDXZK8QzZnOUZT4iZ5/oiOTRx1PSjRFd67J8e1hjw
         cyUi1A9VKbw2lKIQZXmtVDNl+foJCAel3UnbZTqz4Pd56LRdxBmH2FudJiTepUTajZUv
         REw4o6pj6kE/n1CpK8It5sxwjsBXz/gH6bs/66LPcCH0aP8tEHJkTnql+ooZR5+piCgw
         YODVXq422XhgUZ/u+vVUCFTJhh7dMjgHXDW25NeeUmga8vbacWUDzxIvCwRrm6mB5aQ0
         XvMg==
X-Forwarded-Encrypted: i=1; AJvYcCUyGgoJrAv2sWO7NjObqZIpMKSTEnCJ7Kz3Hjc61ZRF/GKZLnqKaAO18ydPK3U9gZaI+mgYfPs3X5To54xpj9HgsfV3Kgv+ow==
X-Gm-Message-State: AOJu0YyLwU7yM+e3o9jE9tYTAikyZIPqitVWtWxY33GYIHofEn74QtaT
	6EPJPxX3L/58mWacOckHYasCICrA0llO8wADhkB7+OMxi8jWE3V7cZ0+/zSMiyJeAK/8+AASi+Q
	kCeDGXc+08Cclu5TYJ2XW9o+eGaYJwcc5xzKPPg==
X-Google-Smtp-Source: AGHT+IG7yfd9wMsTrpYq2tjdl/HBfFyDLsGQd9C65Mbwb0yGSE141RG5ss4fh1fsiJLtmZCVzC5HF2vflKzGMjOVuGw=
X-Received: by 2002:a05:6a00:2d9a:b0:706:74b7:9d7d with SMTP id
 d2e1a72fcca58-70ce500d58fmr2233034b3a.25.1721226259125; Wed, 17 Jul 2024
 07:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203625.1462309-1-davidf@vimeo.com> <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka> <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <Zpa1VGL5Mz63FZ0Z@tiehlicka> <ZpbRSv_dxcNNfc9H@slm.duckdns.org>
 <CAFUnj5MTRsFzd_EHJ7UcyjrWWUicg7wRrs2XdnVnvGiG3KmULQ@mail.gmail.com> <Zpdj-DVZ5U5EdvqL@tiehlicka>
In-Reply-To: <Zpdj-DVZ5U5EdvqL@tiehlicka>
From: David Finkel <davidf@vimeo.com>
Date: Wed, 17 Jul 2024 10:24:07 -0400
Message-ID: <CAFUnj5OxBSVJjjsSA1E58K4F1GH_P7tYKfpMmtFrNtGgEkngtw@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Michal Hocko <mhocko@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <roman.gushchin@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 2:26=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 16-07-24 18:06:17, David Finkel wrote:
> > On Tue, Jul 16, 2024 at 4:00=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote=
:
> > >
> > > Hello,
> > >
> > > On Tue, Jul 16, 2024 at 08:00:52PM +0200, Michal Hocko wrote:
> > > ...
> > > > > If we want to allow peak measurement of time periods, I wonder wh=
ether we
> > > > > could do something similar to pressure triggers - ie. let users r=
egister
> > > > > watchers so that each user can define their own watch periods. Th=
is is more
> > > > > involved but more useful and less error-inducing than adding rese=
t to a
> > > > > single counter.
> > > >
> > > > I would rather not get back to that unless we have many more users =
that
> > > > really need that. Absolute value of the memory consumption is a lon=
g
> > > > living concept that doesn't make much sense most of the time. Peopl=
e
> > > > just tend to still use it because it is much simpler to compare two=
 different
> > > > values rather than something as dynamic as PSI similar metrics.
> > >
> > > The initial justification for adding memory.peak was that it's mostly=
 to
> > > monitor short lived cgroups. Adding reset would make it used more wid=
ely,
> > > which isn't necessarily a bad thing and people most likely will find =
ways to
> > > use it creatively. I'm mostly worried that that's going to create a m=
ess
> > > down the road. Yeah, so, it's not widely useful now but adding reset =
makes
> > > it more useful and in a way which can potentially paint us into a cor=
ner.
> >
> > This is a pretty low-overhead feature as-is, but we can reduce it furth=
er by
> > changing it so instead of resetting the watermark on any non-empty stri=
ng,
> > we reset only on one particular string.
> >
> > I'm thinking of something like "global_reset\n", so if we do something =
like the
> > PSI interface later, users can write "fd_local_reset\n", and get that
> > nicer behavior.
> >
> > This also has the benefit of allowing "echo global_reset >
> > /sys/fs/cgroup/.../memory.peak" to do the right thing.
> > (better names welcome)
>
> This would be a different behavior than in v1 and therefore confusing
> for those who rely on this in v1 already. So I wouldn't overengineer it
> and keep the semantic as simple as possible. If we decide to add PSI
> triggers they are completely independent on peak value because that is
> reclaim based interface which by definition makes peak value very
> dubious.

That's fair.

My only thought is that "write any non-empty string", is a very wide interf=
ace
to support, and limits other possible behaviors later.

FWIW, I have patches with and without this narrowed interface ready to re-m=
ail
pending the outcome of this discussion. (both include additional
use-case info in the changelog)

Keeping the "all non-empty writes" behavior:
https://github.com/dfinkel/linux/commit/5edb21882a88693024a95bbd76b4a8d4561=
348da

With the narrowed interface:
https://github.com/dfinkel/linux/commit/f341c8c0cf5fbdcf7af30e20b334e532df7=
4906d

> --
> Michal Hocko
> SUSE Labs


Thanks,
--=20
David Finkel
Senior Principal Software Engineer, Core Services

