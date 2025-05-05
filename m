Return-Path: <cgroups+bounces-8016-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A999CAA9CD2
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 21:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B92189D49F
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 19:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FEF26C3AC;
	Mon,  5 May 2025 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="T1BThIWV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE7D2040BF
	for <cgroups@vger.kernel.org>; Mon,  5 May 2025 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746474794; cv=none; b=nx62jDW9b4C/Je8E5dgtFU37KOhl4U8I+sc5V3RcwOtF+TZwLUs6m9EOwtyy3Tgf60D179MoOV/pCwdh5ppOuyE27IniZ19Fq8qoONodZhU+DARkPwh+D3PYGabquLpGJAMUAkH4z/8nkxB6LHmHJXFwOjdwyc0p9NNqGuAm6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746474794; c=relaxed/simple;
	bh=bWuLzuA0lPi8wdRunBFZxJiQtKP0aTUHi+Ph9oxFZbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L89XUHRKZUMmgZ6ICwAlgQzeqPQ2q1Tkpw7CR1M7uMqH709+jpy0NMSg620M2LuZZyz5yGkjSI0dL4Tlp5gqWhko0skRhL1eHEtFpIIvW9QXt/DkDKPIqO4XmP493QQbYBT780Lfgexdj9XeAHJDYfnEEMj0n4Cy60uvceHa8Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=T1BThIWV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f6214f189bso9184334a12.2
        for <cgroups@vger.kernel.org>; Mon, 05 May 2025 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1746474790; x=1747079590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWuLzuA0lPi8wdRunBFZxJiQtKP0aTUHi+Ph9oxFZbk=;
        b=T1BThIWV/kLUrt1jEybhwsVh9pnXlIkyLKkkJdm4Ao2z8FlvTX2N10SjVhQA8hx7f8
         6f09o8K5I1Muox/LOjB4zTxDHTS/YQiUTN/1gD8LX6MQy0z4fTrcT7kc/GDAwTnSLDKW
         Y7qdm6jhsW7CIgVhZQKPp53f5PSdRW4F8Y79Mrf7g6DXOMKcCJeOaEOwQH9JBcN+biB7
         nr+N0+yVDHUx5hH/MgRL33iLji1lUNsfx7EK3UFpv8mZTTY23UYYH33B4SG2srzM3Mvr
         WXwRh/dCBQDHZW1CPCQXKA41v0NeLVR+6nzV/xT7aZGlF2CauEVNxQ2yovZlg49lCNRg
         7cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746474790; x=1747079590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWuLzuA0lPi8wdRunBFZxJiQtKP0aTUHi+Ph9oxFZbk=;
        b=jfvm8L8J3VQQp22U9n2rVIsWZ5QUtzLLR9lgJz5mNU04jCAgZyGIIpZ164/Z0i0imK
         CXWTydKPm1JoGKhntNnbrlwjEWO2H/b25suNBC4FXHjg+4GbQ7bIeNSEZq0dseNnoW80
         5aczqyz83syDtRRAHmLniYz2Af9QLDtbtmi4/V3LO7ACoOccx9/7G3TEMHHfS318ZTPj
         RNwUed9YSdN7R0bAlUzgYzapCZ0sY8q7f2VRhn1aiflsShLbWayc8UmdPA4VDRO4JP0j
         Kvratnd9aDKrkq2gV58S8n2JH6QcMFLGLsjpXs8oeNjSbhggdFQJPWAp2hFElGX9NCNq
         eCgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY45Pi4qdtwS7t9rSGgOwAANCuMdRU8OU0ocK+yVi/zm5D6h3Wy5yKG8MDOvqJkjBkNeT5Mev2@vger.kernel.org
X-Gm-Message-State: AOJu0YxCauY9Kz08GlHcVSTQpU0wwg5FPzSXsJAT9x1ouh3oY1gmEbu9
	6yWOqCIVhjf0jH+J2yUrTKDRpJ4mo0VzJO8tXzMz6whQlOjD6a3rlVUbK6FULPiML9NSrTCC0g8
	ManXhhyXt6tuBfKso+TURMqrUMCOturJRyvLbQQ==
X-Gm-Gg: ASbGncsINNKfgG30TkHcOpHP/EXOSDBAMsFyecTvu1mLKxjdwjHYlzAu2Tc0fU0+6Fd
	5zV2YpDvjHMqPSKViM4ABABwksKZ3OfKnxY/+89F4xchqkz27y3xpi9HRycMvqQ2r6lfwrwwUhM
	ta43jE8L5gsor8hcEYggTQZ76g2366Uj79m1Us4SLPCOJNJGEGdEw=
X-Google-Smtp-Source: AGHT+IG5hWi3FfX8lJ+iMuuUnevjeaYHnFvKSVnklVHydgyLPn9+uZivupbrTRvbcTMSPnSnG1+SvUsbCPOpWxKkju0=
X-Received: by 2002:a17:907:7f88:b0:ace:c3a9:81bb with SMTP id
 a640c23a62f3a-ad17b471cb7mr1272782466b.5.1746474790496; Mon, 05 May 2025
 12:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502121930.4008251-1-max.kellermann@ionos.com>
 <bbublxzpnqrzjq5rmmbp772w2darjoahlewqky7caanaknglbx@6wuy5nidsnu3>
 <CAKPOu+_8cbUk=8d41GQGOvUrmG9OuaNVuSQrksDcUQMyFc4tiA@mail.gmail.com>
 <aBUQ7EzmeWYCyLwB@slm.duckdns.org> <CAKPOu+_Dk7rLgc+5YbMd4xpcjz74XKnR1jkgaTxu81EvE-q1-g@mail.gmail.com>
 <aBjn8epxUXDOomiu@slm.duckdns.org>
In-Reply-To: <aBjn8epxUXDOomiu@slm.duckdns.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 5 May 2025 21:52:59 +0200
X-Gm-Features: ATxdqUGExFAHhUbeqZjmp15fYcgaM8Nh_HRMR0HhPIVPqj4_RSm9xDoPJ9-Guhw
Message-ID: <CAKPOu+-DoznsDeAn+AvyPkKyUW33ouLCv18QAO_0_42yXSk-3w@mail.gmail.com>
Subject: Re: [PATCH] kernel/cgroup/pids: add "pids.forks" counter
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 6:31=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> Oh, it's not specific to the cpu controller. The cpu part is just special=
.
> Please see e.g. how blkcg or memcg uses rstat.

Ah right. I have started implementing it that way, but it turns my
simple 20 line patch into a 300 line monster. I still doubt this is
worth the complexity, but if that's what you'll merge, fine!

Max

