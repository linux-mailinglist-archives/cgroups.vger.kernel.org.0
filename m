Return-Path: <cgroups+bounces-3031-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9258D2823
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2024 00:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF54283825
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 22:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A113F01A;
	Tue, 28 May 2024 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y7NQPIRV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6E13EFE0
	for <cgroups@vger.kernel.org>; Tue, 28 May 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935907; cv=none; b=t4RccAGqEqym/dfmk/2Ulgyv0w8IXMXNsMKXG+hMga3C/KxNv5R9w5gpVDt1FO93SJIJZ90cgCJ7pLVqdRj3AeB+r02v6LHzXGq7EIVMDlRvb08Wox3HUN6zkCoCKMAWKETfaWOusJA8KIiGFOx3GjB3sI2rjOKSIady3Pmos+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935907; c=relaxed/simple;
	bh=2WvRjYFaFMZKL47YHVHy7KxFsHaztdsVymExOIYR4NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gc7pezqJGSKY6hBfLhandMmBpluj6MljkD9n1dysDZfMvodImugIe+npHYV6xXw0Mo/NRvhl+zphksL/G4aIZCwNv+wDSnYZ5IWYdo1275DHH9njrsh1IWnoDK8mPG+z8ckEV5LAQ8ekKdbG9OuRByObB/LwDk8GUWaGq/21seY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y7NQPIRV; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52388d9ca98so2238765e87.0
        for <cgroups@vger.kernel.org>; Tue, 28 May 2024 15:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716935902; x=1717540702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WvRjYFaFMZKL47YHVHy7KxFsHaztdsVymExOIYR4NI=;
        b=y7NQPIRVYB4BtV+SuyMm0IZN2LVZFod8MkXyAb5QjRq572C5rPbGkYA5NN9Ji4b5Qn
         ovtnkSDb7QFBVi+ao+J37Tivrs+vEwQgAmzVURqfFmDe7PCr5aK7SYH9v1ChW6ffqRpC
         u5SEc95zzG6qG2q6fxDqm8d+Q9n9HTLV2+qcjL/XJ9Bs3IvM+W9/Gd3c04FWKPqGTFA3
         1xxZDn9oI5dMGRSsIUxKrJ0TD2hd01QXH+vOBWzXRuBAloiu6Ojqf1sdKrmcMkRT86aB
         x9F8B8EeH4aCPb0SpYe5F9cV4lGZ3P+sIGjtgqsnjCJyB/k49xXhTpcqC+r5iFFrPsXD
         SRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716935902; x=1717540702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WvRjYFaFMZKL47YHVHy7KxFsHaztdsVymExOIYR4NI=;
        b=Qe1OU/oIVd9ksvKwzw3QMg2xH9NvRYqsAiA0IMyBjA/hULEnfzJ5tyhehnsdE3722I
         cDxTRaxMvb5oNVx/K8pbITWt93gGGQ/MdRp0BpvoTHrvmfTBSsd7/mpLBi24Ae+qvqcf
         MEPHh8IeGlAkqGqcYvspktvonwMcx8KHuWXw387g8YGbtOPa3rIS7FhWNwa1dN1WBapw
         Ingxdie0uodCYv4gZzLQg2CdM64i6s0gAW+comkvrc9lZBMoEVQIKFcFYPv8US6uRF+L
         BzOzYQaDeLHR49A25mGmnRTVY9W+0yzoKkuk/npestDewqkjKgG5tdy9b/yPmIEgarpY
         1yOw==
X-Forwarded-Encrypted: i=1; AJvYcCXLeltnOGAlnUbUlS8C9d3EUtyV6zgTcSiK+6H6VPQAFyxSeHuTdXVZ9aNw8Ii+00Ex/JxkZMiA5iBvV6CPPF0cRiaKt5h5nw==
X-Gm-Message-State: AOJu0YxXP4B3JtdcPce5HmNJ6XNcHVE1kubf7EQoPGjfSt+4MPhIuL6b
	n4VbVqDeuzHpcplvAog15VKK8gtJUmTVgEmXj8qn85RrCgAu0vhV4HXEAexki+GN8P6x7ueyKvG
	WJi2RQKmicEhdpoqwnTpiu6+lkLTT0VjAJPVF
X-Google-Smtp-Source: AGHT+IE1o5Dipkov01x4ZrjguurfGe0R3sBkf6gcSIgXWq5AbRYVESf5uPGZq0vDyweh1nYEo9sFpaswlKhRItdM7WA=
X-Received: by 2002:a05:6512:224c:b0:516:d232:2516 with SMTP id
 2adb3069b0e04-529652903a6mr13891084e87.6.1716935902153; Tue, 28 May 2024
 15:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528163713.2024887-1-tjmercier@google.com>
 <ZlYzzFYd0KgUnlso@slm.duckdns.org> <zrvsmkowongdaqcy3yqb6abh76utimen5ejrnkczd4uq3etesl@jv3xb4uso4yk>
 <ZlZa-j3Q8UqL84Zh@slm.duckdns.org>
In-Reply-To: <ZlZa-j3Q8UqL84Zh@slm.duckdns.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 28 May 2024 15:38:07 -0700
Message-ID: <CABdmKX1fPYjkA2S90NntVFjcoMRvQZY1FjHt780S6KZCsBSRJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Fix /proc/cgroups count for v2
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 3:30=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, May 28, 2024 at 11:42:13PM +0200, Michal Koutn=C4=B1 wrote:
> > On Tue, May 28, 2024 at 09:43:08AM GMT, Tejun Heo <tj@kernel.org> wrote=
:
> > > I agree that this can be a useful metric but am not sure /proc/cgroup=
s is
> > > the right place to put it. Its use of v1 controller names, listing of
> > > controllers that don't exist in v2 and the unnecessary column are rat=
her
> > > ugly and unnecessary.
> >
> > At the same time, the info provided currently is incorrect or at least
> > misleading (when only v2 hierarchy is mounted, it mixes the counts) --
> > that's what T.J.'s patch attempts to rectify in my understanding.
>
> Yeah, I was hoping to phase out that file once folks are all on v2.

I'll buy a round of drinks when that happens, but aren't we a few
years out from that? :)

>
> Thanks.
>
> --
> tejun

