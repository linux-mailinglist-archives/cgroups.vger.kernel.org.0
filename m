Return-Path: <cgroups+bounces-9746-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA579B46104
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 19:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C20A0433B
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 17:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD77932144A;
	Fri,  5 Sep 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RijEcKMp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783C3191DB
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094664; cv=none; b=KgXXanUoJWLIGC4NZzwI1Lx2Y2JpbuUMtZZn1lhlRhHMFzj8/9DIru4Nru4MDzT/x3ubtLL1uXiZtfUdcqhm3ArxtICclCMAJ/zOv6uHjH+SGPUBqsePiWcU3aMF8UyEru5o4rkLS4F/K8VH2lWPtyoFLKp+KYj+1X/vo+NHpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094664; c=relaxed/simple;
	bh=xnZs4CJraYZQ5wDbYLO6uLnEPPN/QIdzXCOFwkslhQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9Bm8FOI0X9Wc2LSXgAW5Vb7pfXJJn5FbOQje3Qqtep3Bj4qDX2IkSZaDORqvebOsogel8CdkeXNWzHA6T8skIKR4aDbectHfnm0PgG5JmvftoBSRlRZpWXS5zaJ/YSqei7B5+rD+G9vvW5vts5r0q1g2kTbCIK3wdJ5ieDAMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RijEcKMp; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f98e7782bso2903515e87.0
        for <cgroups@vger.kernel.org>; Fri, 05 Sep 2025 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757094661; x=1757699461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaXyfPMqwoi89bLGQQm9R1wibinvU7q12XwB+QMftqw=;
        b=RijEcKMpKZ0l18MgdTMdElLGaCAM6JF8JL80UrDqQYFy2Q34XWx+/TDQ5AeSp/bHi+
         HXJyF+A28Od0ayhZlX0m9NAKRF6oLYZq9lKfbKLMuGWTOrK7YYeHYu2ctQtOrLJAt/zj
         iiVE+yBeqGDYwiQ/sMSvOulGvRcpYOJgfene43VHGzCUNvH6vB4nFtwYGt+YlhfFnCFO
         Db+qGVbMt+93hZX9Oujee9Ms0b6MHs1M72F9eZ7A2Ic+erikPqn9r/BplLoBVpkedMfD
         WahPm64uRdohDNKORitbUXmoIB+9li7aKlSvnU/JOgXA6zVUKYXX4LPpYXK4F/81IZg4
         EW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757094661; x=1757699461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaXyfPMqwoi89bLGQQm9R1wibinvU7q12XwB+QMftqw=;
        b=sK6qiJ5981txNYLQCp3laTeRVaD/DT6EnDI8/0gLbHd+FATlqpZj7h+sI/5w+ZEhVk
         bbRTmtwqrIAB7a3ufLvy9J+QXa/93Lnh8Jh42fMTkSJg0xJtuu6i9+uoYJhuVoUn9ziB
         k7njkMjYrMdygQ+2H6U8j1wOjHQQUdUid4MvfhThKeeB0Q5pJNpwX0ewGtZY5yKAbdmI
         mT2eGZtCZlto7YXfNhSSatPLnxi+0xlfTAXlqcqJWn5lXTuWGggudc9zuY8aTRTgFvFR
         2Ufq2lw/2OBkUoLqhQtiS3PckAd2L6KINv2YdXerGp+OYNiNm+TLl0OlZfLt8bl7PKM7
         gTpg==
X-Forwarded-Encrypted: i=1; AJvYcCW57btj3imc+bYXkzPGXEOMR5so+le/yCTA1q3ZZxSasQxW3oSWJPEn+B7hBdtikJpFYMePYHfv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Z+D2f8QtoiW0ahYTpey8O7s7WuS8P3ye4+yBRCXwjPAJLS6W
	Tr9mu8n4fFMnYv7Q8DZXIB4Z2IFLCXUKxjGJwb3wMoOwOcyw+4vhZvvSAghoHd1EeJh8n7vETYs
	uCBIouU4zrs5uSSC6GaBLTq4zcvwSgI9hxJkPLO8mBmaABfEb+G9f
X-Gm-Gg: ASbGncthn3lPUPRy0VNiNUR9vYoOq0+fODyz5JdMzOuuFRu3Zyz2hmJHN8XHVg4OHkF
	vNYWhqoldn/xRyTSUD8Osq0S4o8fkGuqNB8jT+CxceZN1RXjMKkcbE3auGZd3ycLG1Gzil0d2yt
	ZR4ejviXrTGc0YVSADuZn5Cjr5NnI83UUKXx20YGSovdFIHO4iBkiKATAF0k11QflfnPAzMauTS
	AFCKlMgDpUKiz5GcfU9IJD1sX/kXBeZQqXu/unXkXU=
X-Google-Smtp-Source: AGHT+IHovfJi9UxsADA1y41PVTn87JQTAj3Hx1c4SPMGqx4uQRvjNmPj9yRmM3NVbenXyWcNvhGxjH9edA0XcuveD74=
X-Received: by 2002:a05:6512:b8f:b0:55f:4ac2:a59a with SMTP id
 2adb3069b0e04-560995d4d53mr1317878e87.22.1757094660686; Fri, 05 Sep 2025
 10:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv0mbEBVs0oTiM+H4X-y7ZCwYpfa0hGCQCeVkW2ufGD_w@mail.gmail.com>
In-Reply-To: <CA+G9fYv0mbEBVs0oTiM+H4X-y7ZCwYpfa0hGCQCeVkW2ufGD_w@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 5 Sep 2025 10:50:48 -0700
X-Gm-Features: Ac12FXzVJdbZI6etdAi_p7uTw8KZ7iah-8DwGxTzPcTMM_M3HAoZ1BASAyToy4g
Message-ID: <CANDhNCpWWNpBQfeGq_Bj1pEWTYULJGaubTuPJ2Yxjg4_ESzgBw@mail.gmail.com>
Subject: Re: arm64/juno-r2: Kernel panic in cgroup_fj_stress.sh on next-20250904
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Cgroups <cgroups@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 6:21=E2=80=AFAM Naresh Kamboju <naresh.kamboju@linar=
o.org> wrote:
>
> Kernel warnings and a panic were observed on Juno-r2 while running
> LTP controllers (cgroup_fj_stress.sh) on the Linux next-20250904 with
> SCHED_PROXY_EXEC=3Dy enabled build.
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> First seen on next-20250904
> Bad: next-20250904
> Good: next-20250822
>
> Test regression: next-20250904 juno-r2 cgroup_fj_stress.sh kernel panic
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thank you for the testing and the report here!

> Juno-r2:
>  * LTP controllers
>    * cgroup_fj_stress.sh
>
> Test crash:
> cgroup_fj_stress_net_cls_1_200_one:
> [  365.917504] /usr/local/bin/kirk[402]: cgroup_fj_stress_net_cls_1_200_o=
ne:
> start (command: cgroup_fj_stress.sh net_cls 1 200 one)
> [  374.230110] ------------[ cut here ]------------
> [  374.230132] WARNING: lib/timerqueue.c:55 at
> timerqueue_del+0x68/0x70, CPU#5: swapper/5/0

This looks like we are removing a timer that was already removed from the q=
ueue.

I don't see anything obvious right away in the delta that would clue
me into what's going on, but I'll try to reproduce this.

thanks
-john

