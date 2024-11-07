Return-Path: <cgroups+bounces-5468-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB45B9C09A4
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 16:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D79DB24022
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0F42101BE;
	Thu,  7 Nov 2024 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP9pm2RE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABE12B63;
	Thu,  7 Nov 2024 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992068; cv=none; b=FDOJYNJGUz3BRTp2PYYDzyQS7xz7RALTZhndsnLR/K/ggIbL9dnaBNknVhv2YX/EM21uBFAS6RpgohNSNYfx10x7LzwnmK+5gefUxCHJst4OgEUAJRrLuR+UOVC5BGubifukBEzx0xEGNYmVoUrCb0MlRdpgbUIsyD1ExYpjmLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992068; c=relaxed/simple;
	bh=xKOvUerPn3VyDbYr7zXvyUQ+2qoxobuGQiEwrpAJ5QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWe/2mY5WuYLRckDmXNq37CUQgNQKD//Rbg4ONOBuRsgPUOQon5scTCAhLcE5qfbyXw+lzvJ94z5Ke+WqiL8AguBdce9mMwfSk7ggCi4H68fAszYwTMjaz0AuNMNEZpQiVyyJJivXG0Tr0ak0UuGvXgkX126cn/kP5qUkjPzw1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP9pm2RE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cec7cde922so1361373a12.3;
        Thu, 07 Nov 2024 07:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730992065; x=1731596865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xut5uANNdDtOjyzKg93iapEPx9+ZuQl96I2xXgY4mz4=;
        b=dP9pm2RE9NpojkdxcDC8vPpXXHdvVJkKt3J3WsKFN5FWa5LSv8OK5IHnpx9p/166R0
         BEY/gLoWz4X9PKSizSoBib8xp2NFCH24Y9QTPZdsP/KgUG/7xFiaCFVQjefyP5kW1hXy
         rODjXCWAw49tx2ytsi/aoTWm58M/kUIzJzXV4AqyV4ra9tgseiUthi9Lrke5BQRsWP+q
         wCSaeVD/88oqIeoIbLhE4UZhNFL88Lz2Al/PQPu5lsPo9Rtu1R4wZiIhFsu3dL5wePsy
         4xo9GP254Z/XD3dPSCekTLs0u0f/tuaNVhcCKcuJfWLxoxMkLwfgBAqxYmXFQttODBHL
         7Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730992065; x=1731596865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xut5uANNdDtOjyzKg93iapEPx9+ZuQl96I2xXgY4mz4=;
        b=Fo39z7AMfIHPpXR66itDSjx0AYoeDyfoPsGB4wDUE9Xo1RlNbx4V/pooO2Skl5pPUJ
         ewXFeN2JxGlGeL94zC4KjDdnWYvZeXvBbIk9hd9fcVXkIx0Bk2/fUwd91iocnidRbhcP
         vJxuOfEES/jCMc+timVBMBz4RMolktbfhNQuEFzyTummYX+8QS1V7Gzj1SiaEx51jGr5
         UYWKm0vIGUoD3U9Nn9hV5UrMLANoRXOAdvAnjRXlAA9QNwH5XBcIkJB7nA5JvajHaCF4
         MVaWXB4oB1B7uADCt90cr40hL0nUSr+LpNPwx8gc1H/orKYhQ6ETF5WGHnYSnw+Indw2
         Oj3w==
X-Forwarded-Encrypted: i=1; AJvYcCV+qYlRVAFpWQWby1cyiS7FdlkN92eWA35MEurUs6qqKOLtyB4NJ0PdytJX183ka+NuEiKorZoK@vger.kernel.org, AJvYcCXqma+nfnw4wmDUtqT8rnyo9I94U6Y2qecId9e7NoNwEOF4MMVJ+Y+Ou8Av/z6Xmr6RXVsK5bDv4ra6OAn7@vger.kernel.org
X-Gm-Message-State: AOJu0YyKoA7eyYhvhjKX4LWBjNT9Z61BhkD79z+036EP85lI5PkYysLO
	Atjm6WOPGHxvMEdNA9/yHt9dZllZhs7h6NFZF9ySd7XfEiTSQdu3LF1b4FNQliFFxpZLiqBSQCu
	4ceKXstHDbZ2NBHoe/PnKCvTXxMU=
X-Google-Smtp-Source: AGHT+IHmGFSGfQ19WWaaxQ8Z0FpbGEFwrYlrC9WBxC2VmqQTxw7OQltGqVjgjpwBcW+5Em/5bWm/biBsiRRby+lK1qU=
X-Received: by 2002:a05:6402:270b:b0:5ce:bb37:c2e1 with SMTP id
 4fb4d7f45d1cf-5cf08c0d7dbmr231474a12.19.1730992065265; Thu, 07 Nov 2024
 07:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106221434.2029328-2-joshua.hahnjy@gmail.com> <20241107002116.55528-1-sj@kernel.org>
In-Reply-To: <20241107002116.55528-1-sj@kernel.org>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Thu, 7 Nov 2024 10:07:34 -0500
Message-ID: <CAN+CAwMoac3P5BwSq0jc=Vq79wwZFcV2SzRDmBY+pvm1NYnTyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] memcg/hugetlb: Introduce memcg_accounts_hugetlb
To: SeongJae Park <sj@kernel.org>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 7:21=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> On Wed, 6 Nov 2024 14:14:33 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> w=
rote:
> >
> > Signed-of-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>
> Nit.  s/of/off/
>
>
> Thanks,
> SJ

Thank you for the catch SJ, I'll include this in my v2.

Have a great day!
Joshua

