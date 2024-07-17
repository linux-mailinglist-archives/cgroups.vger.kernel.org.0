Return-Path: <cgroups+bounces-3721-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604059334C1
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 02:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E0E1C225E5
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 00:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88DBA29;
	Wed, 17 Jul 2024 00:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2jJXj+ti"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0144B80B
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721176545; cv=none; b=cBzCJ4fwStLyZL5MUHQtF2wfg7meiCLc+c77frvA8jByYlE/fh0CufZUmzjwyCA//9bsPRm+fR3y1nqwoXbLuTMHoOSfbJtwCw6c0QGlQp/fUhcirKid9ZdG1w6i5ejJ9oj1lpZe7EfOgmO1pEVXct8J/sGudg/WI359+NT7iEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721176545; c=relaxed/simple;
	bh=Wb79OtW6uScFhvym2d+2YAP6S+i0E7YPHJH9culBFtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlbLItHaRSqJrRmIf1jcruaHtFALNpIo7KUTwG878QoAJeuA2fcDUiaZHCsN1hYycPupqW79bKnB8Rvxxzt2hx8CrgcyZOyTUg7xofmVLTmvPqtjvjjGDzsBLcGCZtlu54rGwIiG6QarAAsIxbVdY/K5j8OxUS/OWadEQ9wMEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2jJXj+ti; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77d9217e6fso701528466b.2
        for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 17:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721176542; x=1721781342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kZOLEhWcSugL9jWcDFo6UjLtBBhBK7znFAbXRiiM8Gk=;
        b=2jJXj+tiwFJRK4jUxoxayc4eR7tEuW8+mtqXbniCQYPzjqIYFE9K1d8sbc3mUSjf76
         hjhFOO6JLIWs82/M9J2akU5F495QB4XiB/uueba+zUiItqSAl0Cq+tW1IKtn/aJ8looj
         BOxPbzLabEUQ5uqltO66WH2wIWyMyujNp0XeMd8rebNW9YSgzfohmguaN8/BucwKRvlN
         elHWTOx2p589avBCj+1bzss1x463a/qrY0+HdpDodI2slgbhvH7gj3TkDXzmBRma2guo
         so/w7m2stD7D81IqRFrVeLYUDGu9qFLUFX0uYWjsuueaAM6fhK24lYOhZrFLKAFfXJQR
         HYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721176542; x=1721781342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZOLEhWcSugL9jWcDFo6UjLtBBhBK7znFAbXRiiM8Gk=;
        b=IBBzajW4gGK4Ubjp5FH+3+gTMKAcd63PjN/4jZjsGQaudc6+eZlUgyKVBCsdC3cvrn
         0Iu48ftIsmKyiJ7BypPGsQdCILdp60kJTWoD5WD1TpvHaNeuzc8oPBJJveSetjuEM0ls
         Ljy+K9mQcQF5msSCnFjoOmKxz2JtAutZzGgczd/J/XfAVAgmAqo1sjljC+fWQIU4GyxC
         fuS+LMtENmIswpMnEmu/TwV3qoWA03zcMGGajONnGIZgj/BWIgjyKC0ad0I1mofMicok
         cey7447410G9pBYfPPFy2KDriJV/KgSt+yUlnUQcJv4V9cEm5wk1fuV9K6zJfaizKUDY
         6Zxw==
X-Forwarded-Encrypted: i=1; AJvYcCWP+fspjxyATdmcpiL1O2zOkYV9TWGpIZVPqL8/fQXBi5RlQYhD6/Em3pgdSinI084/GYNYxSJ3jGPMWbKCxYeSOa+qaLZf2g==
X-Gm-Message-State: AOJu0YypZg2x1YN/XGOl/3bDcYcbmJ8v02ch/fQSdhP8G+RaFp7jtFH+
	r9PU0AUcwesrG7/bbRS9gJZdQ2O1fkfEmM/xkyweAV1cLoFcGxX4VaLoxuDYySQ71P2HPJWFWuv
	+okdXmb9N2Z2kMYgYsFGNlcQz/yw1SNYd6FqG
X-Google-Smtp-Source: AGHT+IEeiJjVWnfGxXRp1KifDtA+B2Z8NQMSOG282CtueHBrfRgF1czwTM1JwyHa7kQGYSf/1HYMuKo4hzFqB2yjINs=
X-Received: by 2002:a17:906:7f0d:b0:a77:e7cb:2979 with SMTP id
 a640c23a62f3a-a7a0130e68amr4186266b.51.1721176541759; Tue, 16 Jul 2024
 17:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul> <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
In-Reply-To: <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 16 Jul 2024 17:35:05 -0700
Message-ID: <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
>
>
> This is a clean (meaning no cadvisor interference) example of kswapd
> starting simultaniously on many NUMA nodes, that in 27 out of 98 cases
> hit the race (which is handled in V6 and V7).
>
> The BPF "cnt" maps are getting cleared every second, so this
> approximates per sec numbers.  This patch reduce pressure on the lock,
> but we are still seeing (kfunc:vmlinux:cgroup_rstat_flush_locked) full
> flushes approx 37 per sec (every 27 ms). On the positive side
> ongoing_flusher mitigation stopped 98 per sec of these.
>
> In this clean kswapd case the patch removes the lock contention issue
> for kswapd. The lock_contended cases 27 seems to be all related to
> handled_race cases 27.
>
> The remaning high flush rate should also be addressed, and we should
> also work on aproaches to limit this like my ealier proposal[1].

I honestly don't think a high number of flushes is a problem on its
own as long as we are not spending too much time flushing, especially
when we have magnitude-based thresholding so we know there is
something to flush (although it may not be relevant to what we are
doing).

If we keep observing a lot of lock contention, one thing that I
thought about is to have a variant of spin_lock with a timeout. This
limits the flushing latency, instead of limiting the number of flushes
(which I believe is the wrong metric to optimize).

It also seems to me that we are doing a flush each 27ms, and your
proposed threshold was once per 50ms. It doesn't seem like a
fundamental difference.

I am also wondering how many more flushes could be skipped if we
handle the case of multiple ongoing flushers (whether by using a
mutex, or making it a per-cgroup property as I suggested earlier).

