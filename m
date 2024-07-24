Return-Path: <cgroups+bounces-3882-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F5E93B4A6
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 18:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF63281A8B
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 16:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884615ECC3;
	Wed, 24 Jul 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="PcVixm1C"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00A915ECC1
	for <cgroups@vger.kernel.org>; Wed, 24 Jul 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837516; cv=none; b=HDlmpw1J2zaynOn3foMpwZ9xbSuddj8cxtgzDXTOtXrz/R9MMXvrAHz98f2puC6F4KoV/6sLVJYPYVDFo9CDxzYg7jrvQJJMEzZvlA7SvhLGh2LVf9PAbm589Pc5IW6WWbWn2urYSzsBG3kQK/kBCDzszvUcYU2QjLCBDLaBun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837516; c=relaxed/simple;
	bh=qhtyapTbsggYtY42G73TnJUgJLWCx+iLeJg6LE2bXmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plNlt+mGStYpHCZEyNw/GA0ZETsZNNT9L/U5cMrxURwgMMiby2SzFA/Bhi9jUwU177TPYB2arblIlC2i5o8Nvc5MyoAfVGdAkS9wSiB/cXdWFdR3QEL99sraGY2HMZOxZTC1SA3oxgFfTjjmPNIojgwg/988IM0jU9uLvO7/DUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=PcVixm1C; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d150e8153so4158b3a.0
        for <cgroups@vger.kernel.org>; Wed, 24 Jul 2024 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721837513; x=1722442313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukA2Zx3b8wZGOkUcJ2HRKI3kn32vcEPpsjBc+UAQhVc=;
        b=PcVixm1C3HESsKeDfpE9iGembUDBREu5olz9z8eGpMb+59Ngq0an86maZiYT7Pf7Xx
         Unk1yb66ROCpJL6eWh2tY7qaSTg7bH3h+rue4lfFyG3nDACHATVs+Ka6EF0iFx2xfAWt
         Advy1+BfpABscHxbnh7tYAc4qO1odR+tdY5dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837513; x=1722442313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukA2Zx3b8wZGOkUcJ2HRKI3kn32vcEPpsjBc+UAQhVc=;
        b=pFIB3L1NCItztXco4a3z8DVAjPXMsmc67u84K4wrA0RJhTQVgPbFR9hWhc2Jm/eFBb
         T/k7PtkEATAdNDeDLW4j4Bcq46ZgBnsmMfhRWDQAgB4q3m9oAMY6SwRbgsxHrLceKnWR
         4Pmqchsa85ErqF/uVz/nVDJb6h0AK4e2pXcls48D2OVso5lJld2mRsKYORFQYAAjfr1l
         M9xicx3T4jTXODl0OpTBNyoya7+Sk7YoogzbQ5kzFn23CGhHXLtjsQBy/+4MoqIOKwMs
         SkuwiC4bDB3Mb/7oJp4+2p6HSftMBfVqcm0p2FiCkj8fFq8Gu4jgxblrC92L6LjfrA/7
         JaCA==
X-Forwarded-Encrypted: i=1; AJvYcCUQPhR5NwqOTiMjIh1aZHPM9BM7COFlcKBNWC5+PaXVRxxtQ0hvoV73xlB66vsV4k2kqB6r0goCCtr4Mq/6+dMzoLsbVYEz2g==
X-Gm-Message-State: AOJu0YwiGJVbIF8DR3gxqVPh4PUqzZ52fNHLGNjF7EQDxqxK5PGjOsPA
	R/b6C9mz/62FkElpWO2s/eyzxE7adlu6e8IZTAInZ9o+nu0Jv3t5vjmpaDEP2fWOiZt71RWdbKq
	sx4gIBQGX2zpHfdzpoBhH70OYyXijtWOxoKo9Ag==
X-Google-Smtp-Source: AGHT+IFft/rd5GJFaDCp1Z+xZGOXG6YGzwJeUwPo+FT5WjcIvrkdnSROQL9L0yZcM6+GlwIV+LphZ/daRpk+t+KK0sM=
X-Received: by 2002:a05:6a00:6f60:b0:708:41c4:8849 with SMTP id
 d2e1a72fcca58-70eaa220707mr165997b3a.9.1721837512611; Wed, 24 Jul 2024
 09:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723233149.3226636-1-davidf@vimeo.com> <20240723233149.3226636-2-davidf@vimeo.com>
 <22a95c76-4e9e-482e-b95d-cb0f01971d98@redhat.com> <20240724114905.GB389003@cmpxchg.org>
In-Reply-To: <20240724114905.GB389003@cmpxchg.org>
From: David Finkel <davidf@vimeo.com>
Date: Wed, 24 Jul 2024 12:11:41 -0400
Message-ID: <CAFUnj5O6f2NFitEX0R505ydTsfQnLpgVk4dzMdkf-3GTLfCUDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Waiman Long <longman@redhat.com>, Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 7:49=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Jul 23, 2024 at 09:55:19PM -0400, Waiman Long wrote:
> > Could you use the "-v <n>" option of git-format-patch to add a version
> > number to the patch title? Without that, it can be confusing as to
> > whether the patch is new or a resend of the previous one.
>
> +1

Sorry, I forgot that that flag exists.
I'll use that with the next patch. (which I'll send out shortly)

>
> > > @@ -775,6 +775,11 @@ struct cgroup_subsys {
> > >
> > >   extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
> > >
> > > +struct cgroup_of_peak {
> > > +   long                    value;
> > > +   struct list_head        list;
> > > +};
> > The name "cgroup_of_peak" is kind of confusing. Maybe local_peak?
>
> It's the peak associated with an 'of' (which is a known concept in
> cgroup code), and it pairs up nicely with of_peak(). I'd prefer
> keeping that over local_peak.
>
> > > @@ -26,6 +26,7 @@ struct page_counter {
> > >     atomic_long_t children_low_usage;
> > >
> > >     unsigned long watermark;
> > > +   unsigned long local_watermark; /* track min of fd-local resets */
> > track "min"? I thought it is used to track local maximum after a reset.
>
> Yeah, the comment doesn't sound quite right.
Yeah, it's not explicitly the min. At reset-time, it's the current
value at reset-time, and all the fd-local
watermarks will all be greater than or equal.
Which does effectively make it the min of watermarks at the time it's
being set by the reset code.

However, yeah, the page-charging code will increase it, which makes it
not a min.

>
> However, I think we'd be hard-pressed to explain correctly and
> comprehensively what this thing does in <40 characters.
>
> I'd just remove the comment tbh.
Yeah, I definitely didn't think that comment through.
Deleting.
>
> > > @@ -78,7 +79,10 @@ int page_counter_memparse(const char *buf, const c=
har *max,
> > >
> > >   static inline void page_counter_reset_watermark(struct page_counter=
 *counter)
> > >   {
> > > -   counter->watermark =3D page_counter_read(counter);
> > > +   unsigned long usage =3D page_counter_read(counter);
> > > +
> > > +   counter->watermark =3D usage;
> > > +   counter->local_watermark =3D usage;
> > >   }
> > >
> >
> > Could you set the local_watermark first before setting watermark? There
> > is a very small time window that the invariant "local_watermark <=3D
> > watermark" is not true.
>
> Does it matter? Only cgroup1 supports global resets; only cgroup2
> supports local peaks watching. This doesn't add anything to the race
> that already exists between reset and global watermark update on cg1.
>
Hmm, since the global watermark update is now conditional on both watermark=
s
being <=3D the current usage, it does make sense.
Witht that said, since we're assigning without any barriers, as-is,
the CPU and compiler are quite free to re-order them anyway.

I've swapped them and added a comment.
> > > @@ -3950,12 +3955,90 @@ static u64 memory_current_read(struct cgroup_=
subsys_state *css,
> > >     return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
> > >   }
> > >
> > > -static u64 memory_peak_read(struct cgroup_subsys_state *css,
> > > -                       struct cftype *cft)
> > > +static int peak_show(struct seq_file *sf, void *v, struct page_count=
er *pc)
> > >   {
> > > -   struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
> > > +   struct cgroup_of_peak *ofp =3D of_peak(sf->private);
> > > +   s64 fd_peak =3D ofp->value, peak;
> > > +
> > > +   /* User wants global or local peak? */
> > > +   if (fd_peak =3D=3D -1)
> > > +           peak =3D pc->watermark;
> > > +   else
> > > +           peak =3D max(fd_peak, (s64)pc->local_watermark);
> > Should you save the local_watermark value into ofp->value if
> > local_watermark is bigger? This will ensure that each successive read o=
f
> > the fd is monotonically increasing. Otherwise the value may go up or
> > down if there are multiple resets in between.
>
> The reset saves local_watermark into ofp->value if it's bigger..?
>
> I do see another problem, though. The compiler might issue multiple
> reads to ofp->value in arbitrary order. We could print max(-1, ...)
> which is nonsense. Saving ofp->value into a local variable is the
> right idea, but the compiler might still issue two reads anyway. It
> needs a READ_ONCE() to force a single read.
Thanks, I didn't realize the compiler had the latitude to decide to
read from that
struct field a second time when referencing the local variable.

Added.
>
> I'd use unsigned long for fd_peak. This way the "specialness" is on
> the -1UL comparison. The max() must be between two positive numbers,
> so the (s64) there is confusing.
I've switched fd_peak to `u64`.

Thanks again,

--
David Finkel
Senior Principal Software Engineer, Core Services

