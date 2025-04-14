Return-Path: <cgroups+bounces-7537-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9709A88D82
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 22:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF83217BAB3
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 20:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C831EA7D8;
	Mon, 14 Apr 2025 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3BJX9nD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D713F434
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664345; cv=none; b=RrCsv6cM0Shn5lZW0GilCZ8oBaIxSXHYq9w5qM+znJkKQ5/e5sgfGxd9tmMvedwlNTfWiOxxg4QCwJpA2St3Tc6udYq6LRuR32LJZ0gVSceAe47ijU3R6q0EoASxI3lLUs5ARRQmSaR16VHokZsVyOdM7lBovxSaZSkcaK6GcjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664345; c=relaxed/simple;
	bh=9ejjMn07q3wk5DOpmKww1OzOGy5oLn8w/R7DTprpKGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZY6Nat82M1GHqGKUNnibWkNhI7z7ym7lmXuu9DG957UAQRDksu9epeEkJTG4JnOtk+gk/WdopNa2EgX0XS/GxDynHJnSEc3Zj8H3LqL0oJF8LIjUYJEhKjNHRCw5CNYC3Um4+xOCopWy9GgOmLwuGtVi/pT3wVRcAuTL+6Ks3qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3BJX9nD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso6505e9.1
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744664342; x=1745269142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ejjMn07q3wk5DOpmKww1OzOGy5oLn8w/R7DTprpKGI=;
        b=B3BJX9nDYwoX+6DTieZc7lwMPltDZbfXvp9/XFJYonqv4+NYI4ash1/ZW1arJjfzJf
         KCBPYycwocsiA+Nw1YJX2R8tyl+tcGMeihLIA1RPm8R3CeFneF8PqbbwpVuDsOPqQ4Fi
         F040e+rfRjL0D7vLSo5ONPV6K9w4DZHGAeupuqPqfNZXa84p+wz/s2VGBboMCpwJxaIz
         Z7fHgBcUPS/9mEEnCouaU/OtRbOpfBBZHSo9GN3oVpAC4VY5b6wZyWdNpjcy9STl/xgQ
         p5PC2D2Nf6HFsIkjIJTw6wpsVEyRv/9f2o1l6ssvn9QNdv8E5ewPJv79rNheNsiauhFU
         eCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744664342; x=1745269142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ejjMn07q3wk5DOpmKww1OzOGy5oLn8w/R7DTprpKGI=;
        b=qhZBQbw+qJOrlv/ytseaQNLGJA/xBFrCaGr9ND2fAc9HX4T2O0+EzKBKFj8RxNHtu4
         +X9Cd9apIJrytbb/+3nBz9F+uWtgX2GWOjpyfFDVp3ZrRk2uJW/DAB6Yt4bS12yZBjoE
         C3vTJVfi+tHZDCk8xw0CNHjHAgLG2jwcPrsPd2Kkc+TbbFPzumCVAE3hv4HnefI08AY/
         LrvrLcxpsATsXqCQfJsx/LN9JAKWqrF1uT6GzLLKprwiF9S4fsvUGq+8bHqsU5Tsouks
         Rv4d5+oYfSMft0WhPi75LjOQnrY8MBRsF69zaMvuFNFDNmKqFylhboVUdzrYZB+NmagP
         ABBA==
X-Forwarded-Encrypted: i=1; AJvYcCUJg3XY5EO9p1h9TPvCZwS7nInPesm7sHzS5vtaytJnRzkt9E1z2vqDLVV+yGaEF8u1iUlmJ0DZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhuU9Go18EypGDjpijJy2Vx8uj2MN5PFh6N648IZJtxHebef9
	Tp7LjO6kRzlPxoPHETBnv6SG4DUyAdTtrThMElm/r6uoAAFvChJvKJEqz+sO/bq5n7BCsdngPpo
	atIpAkGhwoadc/XQNw5Le2orlsq0raLOaE7nG
X-Gm-Gg: ASbGncvjzK6CjtLSU/bMES+b0erkewQwAKVxmPI7Fp7IYzHqfNHCt13jMJDv3rWp+n8
	Lkz0EFH89Te9P84jjEsDzIRnds1FBCy6DoGEzEDdbfoNHMyZznUAp2kUNCT86v6tYiKcplc+92R
	EZvsRkfZTAO1AgokxI1Lzs
X-Google-Smtp-Source: AGHT+IH7/tHz61BTtVznTXE39ajUC59qQLOsJyegs8OyBm3GQR24klNXs7iqiSmYTd23qYN9tIZXtLkatallEk/5pSU=
X-Received: by 2002:a05:600c:1c82:b0:439:4a76:c246 with SMTP id
 5b1f17b1804b1-43ffe57ea31mr173715e9.6.1744664342022; Mon, 14 Apr 2025
 13:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414162842.3407796-1-tjmercier@google.com>
 <ysc4oguaisa7s5qvdevxyiqoerhmcvywhvfnmnpryaeookmjzc@667ethp4kp4p> <8ba51391-d4fc-41e7-8d71-cebc0feb6399@redhat.com>
In-Reply-To: <8ba51391-d4fc-41e7-8d71-cebc0feb6399@redhat.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 14 Apr 2025 13:58:49 -0700
X-Gm-Features: ATxdqUG00dp4x6Hri-Ods4PnDq3H-MWCK06nxn5fJWlwVPoVUZpSPZP1VYhzlsI
Message-ID: <CABdmKX2CX_S_bTc11SBJELmGRS=gwiC1gFbTGHk_GTndTYFa+A@mail.gmail.com>
Subject: Re: [PATCH] cgroup/cpuset-v1: Add missing support for cpuset_v2_mode
To: Waiman Long <llong@redhat.com>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:11=E2=80=AFPM Waiman Long <llong@redhat.com> wrot=
e:
>
>
> On 4/14/25 2:26 PM, Michal Koutn=C3=BD wrote:
> > Hello.
> >
> > On Mon, Apr 14, 2025 at 04:28:41PM +0000, "T.J. Mercier" <tjmercier@goo=
gle.com> wrote:
> >> Add cgroup v1 parameter parsing to the cpuset filesystem type so that =
it
> >> works like the cgroup filesystem type:
> > Nothing against 'cpuset_v2_mode' for the cpuset_fs_type (when it's
> > available on cgroup v1) but isn't it too benevolent reusing all of
> > cgroup1_fs_parameters? AFAICS, this would allow overriding release agen=
t
> > also for cpuset fs hierarchies among other options from
> > cgroup1_fs_parameters.
> >
> > (This would likely end up with a separate .parse_param callback but I
> > think that's better than adding so many extra features to cpuset fs.)
>
> I concur. It should be a separate cpuset_fs_parameters() to handle it
> instead of reusing cgroup1_fs_parameters() to allow so many other maybe
> irrelevant cgroup1 parameters.
>
> Cheers,
> Longman

Hi Michal and Longman,

Yes, that's fair. I'll send a v2 tomorrow.

Thanks,
T.J.

