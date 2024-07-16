Return-Path: <cgroups+bounces-3710-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD904932EFC
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB20B22E7A
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 17:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8476A19F48C;
	Tue, 16 Jul 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="PPx/N/dl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C631F171
	for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721150462; cv=none; b=qIupDFVc9GyHkSZdRgIXb4yWNMJ6fEpGKkY3GMN1flqqQjFIzwTtESx4tExC1p+43S5/G45LZKieShH6UwHMW94bcFoYcpV06PYWSB/HjguxKxHyeBK8Mp7uN/Hih7ZL0llWXX4hEVMwn9Jl/wd61QgyVQ4MhNRgj5KZGA9vcHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721150462; c=relaxed/simple;
	bh=1sv+QNc/DGMhPMVsZ2FxSdhckTqknm0RzzQv130owTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+sigpksnGV6xV7moosC8u7ySyPTXHVqAerq+oZUBBqfziISCIBYoDN83C47nlCxka3+dKdk4zI7uq6ud930JPywDKd+yErwUJRkhXLZHWr4HKQggaMxjjLwpiYFC0CI9IS/Fpr9cyi24XPSTLLORHW2YOHDmxNqSMTzgQdAZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=PPx/N/dl; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-71871d5e087so4283269a12.1
        for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721150460; x=1721755260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sv+QNc/DGMhPMVsZ2FxSdhckTqknm0RzzQv130owTc=;
        b=PPx/N/dl4nc/iPKwhzJnMr8F7jmHQU2IeCfojlCZ4plhnHeqePoMjId55lRYLL8+AK
         fFcmA++DEiWyXhXpVV4EL3gRhVwRO5RnmO1FfTPd5YV/0yOM5/HZLRt/F2pkPGMDld8B
         ex6YqAVPEdFBiz84S83pNu0GAQM66dXD2THG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721150460; x=1721755260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sv+QNc/DGMhPMVsZ2FxSdhckTqknm0RzzQv130owTc=;
        b=C3RiNMd9/Uc5mxLstP5d5ssMSmev0UVpX9kXMFIIi8qLqIMWCN9VYsXkjcNRgG1ogF
         b743soXFWqkQUABUbb2GEpT3ubZSaiOUFmjnH8N8sGMlZThLjcd2cH4JkAYkzJVTvYZR
         GyvBtx6mAgLY5/8GQjhBOBNYKeYfOFj9M8oYnqbjyVjFaefw0KI2Kujgp7L34A4hedQL
         xAxOD/cjNZAvYSJlxNJXSDlpGwW0+ZB0gmTqZni2HI7umPCykv0MXUjtHjb/TgzyvHmn
         52KUOWuYooI38pNhxAxTX4mkIWLvJXVkNjSl17KoGwiGzK3pmzBCk9rGvK8FvO+SWB9f
         bg8g==
X-Forwarded-Encrypted: i=1; AJvYcCV4ISse/OZbtMubqOQHMHqpG6w9nYEbIng00Lc65/KXEpd94tMvquw5F1di5AipZCkGSysXB48foxEixktqjT3z1sFy+BlAyA==
X-Gm-Message-State: AOJu0YxDeMgHz8JeJ9cKiAc+c3bkIcmcAtCh1GAfq0zT8KYin2Tpq/Km
	o7hRe4Q9GW4kGojRWHkryCk/oexsGoL44Kdqz9LsvHyDXu6LJE2ObJ9K/kI7hfgTQLzDkAMmcg/
	HXsYfq17kdjcGKxOMcs+r70nhL2X/mANPJNnqJA==
X-Google-Smtp-Source: AGHT+IE0jogasMR5Vo1zc09nO8WrQEH9BAm8Vis6rzWXoOwDzxBtbsrDWTNwvTcelBY4lZmxg6D9GIcINCHKQHMTUNA=
X-Received: by 2002:a05:6a20:430b:b0:1c0:f594:198c with SMTP id
 adf61e73a8af0-1c3f11f7552mr3997701637.11.1721150460103; Tue, 16 Jul 2024
 10:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203625.1462309-1-davidf@vimeo.com> <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka> <ZpajW9BKCFcCCTr-@slm.duckdns.org> <ZpanW41dQ8DimbA3@google.com>
In-Reply-To: <ZpanW41dQ8DimbA3@google.com>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 16 Jul 2024 13:20:48 -0400
Message-ID: <CAFUnj5PeQ-FefK+ja0BtwHZFF0QyJdN9imZQESOj+tRjHSmvow@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 1:01=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Tue, Jul 16, 2024 at 06:44:11AM -1000, Tejun Heo wrote:
> > Hello,
> >
> > On Tue, Jul 16, 2024 at 03:48:17PM +0200, Michal Hocko wrote:
> > ...
> >
> > The removal of resets was intentional. The problem was that it wasn't c=
lear
> > who owned those counters and there's no way of telling who reset what w=
hen.
> > It was easy to accidentally end up with multiple entities that think th=
ey
> > can get timed measurement by resetting.
> >
> > So, in general, I don't think this is a great idea. There are shortcomi=
ngs
> > to how memory.peak behaves in that its meaningfulness quickly declines =
over
> > time. This is expected and the rationale behind adding memory.peak, IIR=
C,
> > was that it was difficult to tell the memory usage of a short-lived cgr=
oup.
> >
> > If we want to allow peak measurement of time periods, I wonder whether =
we
> > could do something similar to pressure triggers - ie. let users registe=
r
> > watchers so that each user can define their own watch periods. This is =
more
> > involved but more useful and less error-inducing than adding reset to a
> > single counter.
>
> It's definitely a better user interface and I totally agree with you rega=
rding
> the shortcomings of the proposed interface with a global reset. But if yo=
u let
> users to register a (potentially large) number of watchers, it might be q=
uite
> bad for the overall performance, isn't it? To mitigate it, we'll need to =
reduce
> the accuracy of peak values. And then the question is why not just poll i=
t
> periodically from userspace?

FWIW, as a stop-gap, we did implement periodic polling from userspace for
the system that motivated this change, but that is unlikely to catch
memory-usage
spikes that have shorter timescales than the polling interval. For
now, we're keeping
it on cgroups v1, but that's looking like a long-term untenable position.


Thanks,


--=20
David Finkel
Senior Principal Software Engineer, Core Services

