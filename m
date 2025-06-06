Return-Path: <cgroups+bounces-8451-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35C5AD0098
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 12:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5BA3AE35F
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0148C286893;
	Fri,  6 Jun 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="YibZ/noB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3872A20C03E
	for <cgroups@vger.kernel.org>; Fri,  6 Jun 2025 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206577; cv=none; b=fBRmKc+oTtWJSjtJeLIxTXhie/TcKlNLo/XaAZUCn6RwhiNxlt4zmFWnNjG44PCyQ1bPDCtNFMFNGgoGMwRW1YRSpqU0BnNnjZEOqXKFnLlf2p40iLmU5UzTFzFVooxevWAcDpRC9L+m9dZ1kqh7Zjy1RkibUJunWM29NyV1aqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206577; c=relaxed/simple;
	bh=vkmochM2SrgurI2OOeUhLIqKvSLPLxHe2qx4RPVkYM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFFPQrjSgJ4xmAurNrPDwIY/ZwBwEhSuHjtuhzd4ZmI+X6ERy3/FObbULAljMTEbume8QeyV5Tx9BJQPpZjQraulWnzIOopZQlQMdv2p7QaPSN/WGkf0csLohgrUfByTXpfaE0L7pivybZ+P24ZAKfhDMc/rVP/hTW4e8EXZzag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=YibZ/noB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a53359dea5so251582f8f.0
        for <cgroups@vger.kernel.org>; Fri, 06 Jun 2025 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1749206573; x=1749811373; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y+nokHFtXpu0WDXP27AgjIbn53JQRm7K0yzN0KncLEM=;
        b=YibZ/noBW9p5fbTljedjX37/LW/rNg2zIH6cr8A6m9dgCxyI/m2NBw1zs8mQZRGboO
         6LcQyjx1+X76kagCCIGGm8/grQR4hBJuAJ6+UR1rdLXT0W3dzk02Wzk281wQclxppJ6x
         FoPB95Z76o3ajldDZ4xQDn+QXazOexsRrOYD/01ICMknb6tGRTFpvXzJtmdMchDC9x4i
         hxG+SRAQ7fdav9+ofvxi4tRHytVAGHVZpIO5z5+UmoXOYi/AtxiNunHlEdA9UwRe6Pp+
         ul9bWJehKOO2uc3BGMJXjUS7C7YLrHB1zsRwb8lHSp0jybyOwUyWspHPG46U8Jezp1qx
         V3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749206573; x=1749811373;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+nokHFtXpu0WDXP27AgjIbn53JQRm7K0yzN0KncLEM=;
        b=CEe1H1AC+SR8p0a5T23xahPJQD5IGhGiBjWTBUXzUBSciZJOJefEa+wWS/UDkihmgB
         uohC6Zzam1z38XI4Tp8zdgDZTyWQaCF8QmJLxGvS1FGAIRp9PV0l1FgvQ+mRSqsRuMZs
         +jEUoNJvtJoBL+KQGwgqneH2orBQ1jEQEDnyQ13XkYY71KeMo/BsUuZxYYVZLQ0QkLt2
         VNtCJ5IEaJD02qMczCQ5rzgtbihI/Z7yCz+ouTyKREw/W5tTKoXjiCjfWwSkrZhgbeBq
         BDlaoyDZDvOlrS96SXPeu3NVaB50NRi5mYf7hiwmFeZyqTE1U0HId4MNlju7NX2/xM9b
         +aeg==
X-Forwarded-Encrypted: i=1; AJvYcCVLci8bwzmlmJQdE338YosvNrefENXR6WDAwMK4ClGfqnu+zvq2YO6PE5Y1jfZVo0/kzwBvLYM/@vger.kernel.org
X-Gm-Message-State: AOJu0YyA+j9NU0SSLccxQIpBA6jlFxzIy2k+3g1Lte+G9h90EDB+50EH
	mQ8ANdQ/pbFNBbBiVLS2iFlHuKEqBQTi7RD+1YTzBDKEZQVzzJzxbizEJFcUgYQZBcs=
X-Gm-Gg: ASbGncuvaOWbgaT4plhRiUwwvaGSD1LPoIEXKE9aZYcCb35xrvXrwyREnjvvw8GfnMN
	PBGO6EqWZqETOH2TxF7K7h8brWlya+YUfEER+yGEpELPL8k7td7I82Z2p+aPl9xbsg286kRfQYN
	hhCWeL9TDs5iiJwt7Xn5DpV5A9T28wGWm3YVXCtYU3pceWatgq5nHEUcrrVfmaaPmh+AIA9+QHE
	nfIHZ3QSVC1QDKcVHC6f1yNkE8FzYL41+bjaLWXXC947OvrciEfPtSsgmMpVM62fynJqIb0B11h
	JRE6VF/eVM68KYLiQuQKvrU037TU9PCneYbao8Adbkuv5zAK
X-Google-Smtp-Source: AGHT+IEtx3a0U8v1fBCckXwCRNLbBtPgODWu90k6CS+zdoTBmpVDSFh/aW2UVu82FYy50xGmDq3LCA==
X-Received: by 2002:a05:6000:2dc9:b0:3a3:6415:96c8 with SMTP id ffacd0b85a97d-3a5319a78fcmr2195820f8f.41.1749206573116;
        Fri, 06 Jun 2025 03:42:53 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:da11:6260:39d6:12c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a5324361ffsm1461768f8f.47.2025.06.06.03.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 03:42:52 -0700 (PDT)
Date: Fri, 6 Jun 2025 12:42:48 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jemmy Wong <jemmywong512@gmail.com>, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v0] cgroup: Add lock guard support
Message-ID: <20250606104248.GA1118@cmpxchg.org>
References: <20250605211053.19200-1-jemmywong512@gmail.com>
 <CAADnVQJyATTb9GFyBhOy5V_keAO5NZ6+zucLRyN27Cmg2FGPVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJyATTb9GFyBhOy5V_keAO5NZ6+zucLRyN27Cmg2FGPVA@mail.gmail.com>

On Thu, Jun 05, 2025 at 05:54:15PM -0700, Alexei Starovoitov wrote:
> On Thu, Jun 5, 2025 at 2:11 PM Jemmy Wong <jemmywong512@gmail.com> wrote:
> >
> > This change replaces manual lock acquisition and release with lock guards
> > to improve code robustness and reduce the risk of lock mismanagement.
> > No functional changes to the cgroup logic are introduced.
> >
> > Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>
> >
> > ---
> >  include/linux/cgroup.h     |   7 +
> >  kernel/bpf/cgroup.c        |  96 +++---
> >  kernel/bpf/local_storage.c |  12 +-
> 
> Nack for bpf bits.
> It only uglifies the code.

I agree with this.

The extra indentation from scoped guard is unfortunate.

The guard with implicit unlock gives me the heebeejeebees - it's
asymmetric and critical sections don't stand out visually at all.

Adjusting critical section boundaries with guard means either:
* indentation churn to convert to scoped guard,
* forcing abstraction splits along critical sections (non-API
  _locked functions), which makes the code flow harder to follow,
* or straight-up violating abstraction layering and adding
  non-critical stuff to callers where it doesn't make sense.

I don't remember the last production bug from forgetting to drop a
lock. Meanwhile, the things that people actually seem to struggle with
when it comes to locks appear to become harder with those primitives.

