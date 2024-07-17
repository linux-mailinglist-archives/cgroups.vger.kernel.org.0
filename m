Return-Path: <cgroups+bounces-3739-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEF79340C5
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 18:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A146C1C20C94
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 16:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD42181D02;
	Wed, 17 Jul 2024 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnGQ3ZL9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D0F181CFA
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235037; cv=none; b=CGWHjAKu99rZVPaUSeS+7g+S9UuqIqMY5hEdCH4SSslbc9adz4GHN7YFp+5xPO45IIGiuNw3J8r3b8ihzKgXOctZFeL1P/sZAlVWMILAGfCVyZXckJwTNK+DXpFd1RhqCOlR3PBUnF7m5lc2i5pDZLYITj+m08FqrpyRRJp4d78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235037; c=relaxed/simple;
	bh=brMoMeNLF25cQ84wJRpgrYCmQeirKUbdzKcB39u7okY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faDWOd3+aKXHY9/dxkUWpE79FgWWVe3lERWIG6R/IuU6/NGZhpv2rqsjFxWVy4z4P3haoNLdHvXtIWrlYbdeLkeOifwRpgQxwINdfjmskxcChD6yzRGXjRYDHr388dkH/lReE21NhfmQRZMoYOJ+iiOnk3/sPuGJzGsRkZmwMRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnGQ3ZL9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so701026a12.0
        for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721235033; x=1721839833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTNGHnvQ6RG3vz/xqvoqZtrVCx1QoR7aN9z9QUd/56U=;
        b=wnGQ3ZL9zMkQNxejkYrlTO0dQ9R3qjI0W9ghbVcB17X+OFkZuZnSGsWEHXIotc431z
         0HjHzFF/DNzCuqGgJmRC39+i1VR3s0xPaDvBwMlMQWAyJFaJXI6XdLqKfnlOn8Xeu0xK
         Bq0S4q3ecq/lytqbKcQz8/Jv5NBuDaEjzzuzaPn7FoyQEDnS2e8GV7gtR/eYGYR4isE5
         NXvqTsKNw/UBmIS3Na8sgXPcK1+GjYE2CUz59XvwWZl8ZSKVWRN98bmaJULNAmnjPt6m
         ERWDBOMhWhTQWUMjRGPCIskFBGSN/QAidWByC5/rzf+uqy/7Yhw4SB/IxMfh9a11vlzB
         rPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235033; x=1721839833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTNGHnvQ6RG3vz/xqvoqZtrVCx1QoR7aN9z9QUd/56U=;
        b=qq2R+uTKcsTQGGfATKqkGVgnCmsGgQHK9tniPcGsoTJKImtjCakVnvys9QooLvQtP9
         nFiZlJtDEsfLuPDn93g5h+Qt/Byowqmh0Mras6gL2GLqxUA3XoZ653v6m6/FSznrsP+P
         BUyqDvpNjzBWpMnbDKU3L+UhgjFFYTm8Zo96KgVJnvsr8pgm3Ah3S9PRzbsvJXPysJi4
         iAbPgoo1yFyZE5lzCgTaMQ2+cetjYdwISH4FcZhFaJ7B47u6LsbT4J8vb21r4ylfipwX
         EHBpNFl7Hrfjjd6GN/OZAfFbkpvjcfZkvNO7llul6Kfnab1oznEsrToJ35mOk8+NUANn
         yCeg==
X-Forwarded-Encrypted: i=1; AJvYcCW1KcFiEy1lq0jq0xQEU+9hbRIHlxBl0LNw5X+yh3ZAOrLv/Tc9QMWbJcL85io7wZ6ohOzpkTP5Ibsk0I1TfKvz0vuOYDqEFg==
X-Gm-Message-State: AOJu0Yy3TfsAAKULzd2Yfm93pFAQ5yja3QIMeTHXioW5u8j5UwxHpVj+
	wGN55ZEk50L3yzpwNboL5a6yrdORH4ZfFKqtB4FX4YVAm1MzE+g2kILq9QyeQMEAHlPDOfqz++w
	8wcwxwpM2nmBlktbcdrax9NYNQ9n8zg7VV/pT
X-Google-Smtp-Source: AGHT+IGqZ84dAhFoS4O9crcKXggKs4NB/xqx5YRXOru5heEmpY3ot7CFAr2+9x16/lLYK/bZsph4bqXikfqjRlzPzDs=
X-Received: by 2002:a17:906:1c12:b0:a77:cca9:b216 with SMTP id
 a640c23a62f3a-a7a011bc7d4mr147771066b.33.1721235033083; Wed, 17 Jul 2024
 09:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org> <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org>
In-Reply-To: <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jul 2024 09:49:54 -0700
Message-ID: <CAJD7tkaBKTiMzSkXfaKO5EO58aN708L4XBS3cX85JvxVpcNkQQ@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 9:36=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
>
> On 17/07/2024 02.35, Yosry Ahmed wrote:
> > [..]
> >>
> >>
> >> This is a clean (meaning no cadvisor interference) example of kswapd
> >> starting simultaniously on many NUMA nodes, that in 27 out of 98 cases
> >> hit the race (which is handled in V6 and V7).
> >>
> >> The BPF "cnt" maps are getting cleared every second, so this
> >> approximates per sec numbers.  This patch reduce pressure on the lock,
> >> but we are still seeing (kfunc:vmlinux:cgroup_rstat_flush_locked) full
> >> flushes approx 37 per sec (every 27 ms). On the positive side
> >> ongoing_flusher mitigation stopped 98 per sec of these.
> >>
> >> In this clean kswapd case the patch removes the lock contention issue
> >> for kswapd. The lock_contended cases 27 seems to be all related to
> >> handled_race cases 27.
> >>
> >> The remaning high flush rate should also be addressed, and we should
> >> also work on aproaches to limit this like my ealier proposal[1].
> >
> > I honestly don't think a high number of flushes is a problem on its
> > own as long as we are not spending too much time flushing, especially
> > when we have magnitude-based thresholding so we know there is
> > something to flush (although it may not be relevant to what we are
> > doing).
> >
>
> We are "spending too much time flushing" see below.
>
> > If we keep observing a lot of lock contention, one thing that I
> > thought about is to have a variant of spin_lock with a timeout. This
> > limits the flushing latency, instead of limiting the number of flushes
> > (which I believe is the wrong metric to optimize).
> >
> > It also seems to me that we are doing a flush each 27ms, and your
> > proposed threshold was once per 50ms. It doesn't seem like a
> > fundamental difference.
> >
>
>
> Looking at the production numbers for the time the lock is held for level=
 0:
>
> @locked_time_level[0]:
> [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
> [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                   |
> [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                    |
>
> The time is in nanosec, so M corresponds to ms (milliseconds).
>
> With 36 flushes per second (as shown earlier) this is a flush every
> 27.7ms.  It is not unreasonable (from above data) that the flush time
> also spend 27ms, which means that we spend a full CPU second flushing.
> That is spending too much time flushing.
>
> This around 1 sec CPU usage for kswapd is also quite clear in the
> attached grafana graph for when server was rebooted into this V7 kernel.
>
> I choose 50ms because at the time I saw flush taking around 30ms, and I
> view the flush time as queue service-time.  When arrival-rate is faster
> than service-time, then a queue will form.  So, choosing 50ms as
> arrival-rate gave me some headroom.  As I mentioned earlier, optimally
> this threshold should be dynamically measured.

Thanks for the data. Yeah this doesn't look good.

Does it make sense to just throttle flushers at some point to increase
the chances of coalescing multiple flushers?

Otherwise I think it makes sense in this case to ratelimit flushing in
general. Although instead of just checking how much time elapsed since
the last flush, can we use something like __ratelimit()?

This will make sure that we skip flushes when we actually have a high
rate of flushing over a period of time, not because two flushes
happened to be requested in close succession and the flushing rate is
generally low.

>
> --Jesper

