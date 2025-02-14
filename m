Return-Path: <cgroups+bounces-6551-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EF1A35B15
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2025 11:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF159188F64E
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2025 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6593F24BBFD;
	Fri, 14 Feb 2025 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUqVeDlm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8B12236F8;
	Fri, 14 Feb 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527473; cv=none; b=K2kdiqTaAslXq0OOYf3SaUJ+JscV1MT2M//SycMVP9L9IyKfRFjmZ7Q6OgRUT2Q2MoAOYu6h6Zvt5iHXU7akkIbdOuAIDZk3Wlr+w94aG2mgH4GEF6CvMx0vVRUwKF4SXTZfsNkwbuFM9+8eL9kfc83YXkL1THUES1S/kdg0oIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527473; c=relaxed/simple;
	bh=O5+hvzeUVTaanAFr7pzPUiUCZtR0kLvDBOjS27pRU9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEqMFXcpI+Xux7f4OPf3Lw0q+FSS8izF26+pQBRsMmxjAl1Ktal6PKLStI1p6ZA43H0a1JM1Mv/XZCLul9p4PLU22agE5qfnu59c1RooAW/3iIL9Z80j3pva9NdOZBdQZkWWo2MNMXq/ociCw4460gjklganHtEeWZfZGXplcrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUqVeDlm; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4bbf5c10865so560469137.3;
        Fri, 14 Feb 2025 02:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739527470; x=1740132270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vctiJ5pJJIOhGH+h0e2tZwQ96eqyBSN4JZq19MvB2XA=;
        b=PUqVeDlmpenP3WHtXwhJRdY6zw+7tLXHzvhAU5EkxLpn+bXLnrTY7K/BpxAUfx0phK
         sbXFa0dsTWLeXvBlcGtdtTIzE1gejSOYy8wgcrdWTSRSiQ0Rafegnlcd9oeMVWXk8SAP
         nmJBd52NFSbZaWAgwe5pJYrlLiL6qrdZcsehZ7scfaI9c6Cs9eONTHTM9Vv5SN7wjBjd
         NSdwQZbCLzg7xE8zf6e190MMfaQkZucw5oTfhrpJPu7JJlHQ93ebAEgNp6n2kqivU50v
         tQphbefGMfw7E7Nq5Usnym+CFav7y777MmvLKwC/wWvaLbGJvTUUq9H1mG1VOGBBOSDz
         GETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739527470; x=1740132270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vctiJ5pJJIOhGH+h0e2tZwQ96eqyBSN4JZq19MvB2XA=;
        b=J91jp5aIg5fo6Yh8XK0GAkk4rJLwxaUSdCsVveJm+HmFpbKWYWp3uCi+lw1lRBHqoO
         kUZ6sAkiTUFwEMj3qDrYCG8lSchkB3FyHX+/MBs4xWbFmy3ZJoEc148+mVdCLPZepCvW
         o0JJxzYw5XJ28sg489siXIE07aYLPcczg2p4AlWtRYafc96ZSDEtKpyUMwRRQsKt6pm/
         xiCN8DS6OkeIvcmUrjA1ssUFkhFWJIe4AtD6qbKcNB6gKaPtCAKnnkNc9Ym9SBoctqhY
         T79SnnOdRHuXZq8mdgALPYMarjgEvNLgLrHLl/Q6uS2AP8fGJpOa7jOi+Ycf1Ury+s8C
         Mbrw==
X-Forwarded-Encrypted: i=1; AJvYcCX3D3yJPfu+pT+Jtxn3NA1WUu4zb2ZP3oPrEq5dRpzVVH3KNDff8xMsISw/UXllFi4pIolsoXGj37zrgrYb@vger.kernel.org, AJvYcCXR5SMV3l3PeZigBPiceqKFeqD3fqybLZ1Sg5YcHT6WvVj/0zIS6mJbO6LpfJdEbM6iDf8QrbdB@vger.kernel.org
X-Gm-Message-State: AOJu0YzmbAieXzRXsiR/lEaqMrsvzzuwOhvo8STW/4foV3W7HmtKNvp6
	0BAJf6MtCvJI24wRuXEzY2iklgfWDN2phQ4J2h+oVSZIvp/ExcFnHAJyx1u0I5yOh10GQ3kUQ5w
	qbQCyP+z6a7pN+VUnSP7wsm8w3/4=
X-Gm-Gg: ASbGnctNYPj3XPs63DtmG5zm1lC+rAwtJ7RqkTDr1RlRfx3u6RXeI2Lt5BSygbyORG0
	1ExmzdK4kO0qouhQ/sDAL9pOxpgfnTfpUumRfmF8pajZ0FtKvbHrYqS75mWsQzp8uUT/AVsHW4g
	==
X-Google-Smtp-Source: AGHT+IF7vSJeurvUbicM8qXUojUD37VLd4CrYZ3E32Pklvi89crD5IDYQiF2aB1zmhIk5MUk1UwFw0l6Y6dGjDfiwtY=
X-Received: by 2002:a05:6102:2d03:b0:4af:be6e:f0aa with SMTP id
 ada2fe7eead31-4bc0382036cmr5869332137.25.1739527470467; Fri, 14 Feb 2025
 02:04:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a5337f9-9f86-4723-837e-de86504c2094.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYQD2K0Vz_jHD_YNnnTcH08_+N=_xRBb7qfvgyxx-wPbiw@mail.gmail.com> <pl23stfp4qgojauntrgbfutmrstky3azcoiweddseii52vgns4@6446nbhq2zl6>
In-Reply-To: <pl23stfp4qgojauntrgbfutmrstky3azcoiweddseii52vgns4@6446nbhq2zl6>
From: Jin Guojie <guojie.jin@gmail.com>
Date: Fri, 14 Feb 2025 18:04:18 +0800
X-Gm-Features: AWEUYZmwMiEXWXSo10bYEaqj5lstQHVTw3HsKqWlOAZClry7ZPsEIwM-0BlsbJM
Message-ID: <CA+B+MYQuz9ue1ZogpEGb8J+F8UA5P0dD-R1cRUp-4EgDBnPS+Q@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup/cpuset: call fmeter_init() when
 cpuset.memory_pressure disabled
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 7:01=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Wed, Jan 15, 2025 at 01:05:21PM +0800, Jin Guojie <guojie.jin@gmail.co=
m> wrote:
> > V2:
> > * call fmeter_init() when writing 0 to the memory_pressure_enabled
>
> Thanks for taking into account the feedback.
>
> I'm still curious -- is this:
>         a) a new LTP test,
>         b) a new failure,
>         c) an old failure, new look
> or anything else?

For the three situations a, b, and c you mentioned, none of them is true.
In fact, this "case cpuset_memory_pressure" has been in LTP for a long time=
,
and the same error will occur when running in multiple kernel versions.

The method to reproduce the error is provided in the description of patch v=
1.

https://lore.kernel.org/cgroups/CA+B+MYRNsdKcYxC8kbyzVrdH9fT8c2if5UxGguKep3=
6ZHe6HMQ@mail.gmail.com/T/#u

The fmeter_getrate() function in the kernel has not been modified for
a long time,
so currently LTP "case cpuset_memory_pressure" still produces the same erro=
r.

>
> Michal

