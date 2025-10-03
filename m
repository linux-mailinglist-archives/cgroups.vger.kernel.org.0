Return-Path: <cgroups+bounces-10530-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CA0BB7194
	for <lists+cgroups@lfdr.de>; Fri, 03 Oct 2025 16:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AB334E7F9C
	for <lists+cgroups@lfdr.de>; Fri,  3 Oct 2025 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361591F3B87;
	Fri,  3 Oct 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JqEbhZga"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6E01B6D06
	for <cgroups@vger.kernel.org>; Fri,  3 Oct 2025 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500030; cv=none; b=dX1t2+Ix1t12rXBNEnHdrlz65dY4FWaLd6rjChS7WLZm3PsODCKOwwo4xfaDWLGlzS/Cp0DwVTFIQpvbUm4L5TPQHwppgifS733/+FwcDYt76DK3lyozHzUY8Jfgn1nBYKH/3bytqbc7MYnn6jO0nMksivmOUdTmvleadcySzMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500030; c=relaxed/simple;
	bh=LE11OXTwtyH7n2SYHTG2RJk02Tg+uqHJe5QPkn3biIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvxUvQ51izpAFbpJ79GaX0LoS9WkTcHCxcagttm85SRpGWgkoCH5+lqB5b6WaY+LH2epSfMcXMHr2zNPevobgCkTEnw7kK0CQi0E2cXa2cfH9IV82HLFUS+kUtQ7tlVu3btxhswnMVHyjMiFZxwWCuBYsFaO9NBgaC8aY/339lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JqEbhZga; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so21697195e9.0
        for <cgroups@vger.kernel.org>; Fri, 03 Oct 2025 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759500025; x=1760104825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1I+/2p2JdPvoE9EVgO8OhJv/XxdkIcGTKg91hG0OSE=;
        b=JqEbhZgaQdygIuNVhqlUubpuMSsycDexi+Avoe3jInfl6GTCwHircYlpTOIcnJHrAI
         XjM3HVXiVc5zgVkKA/wrGBCTUXQ5kEMYgP4eYBHoyQAEvrNTCJxlBkpA5T8Zk4gzGq4p
         CXGqIAdTGQm4d0IwR7DTPqqp7Ar5CH5KiXLNsoE5TsOoCfSr8hXOQlInK13VblH+y652
         R500OY4/9oXu5LRyHwPvtJ1XAD2qZAEAi2NkO4TrbiW03ghSiXwGdY+quZuNml/ztfXY
         WJwZvGq/tx0VuzB6NTiol2pbTbitGb53B3KfUg4HvIx+gFbhd5+nBjbwQZV1TVPFmUA+
         iakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759500025; x=1760104825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1I+/2p2JdPvoE9EVgO8OhJv/XxdkIcGTKg91hG0OSE=;
        b=fRARmd+XPBKrEZaNlOPOj3w+366AYyTqhLzDx3jjcHnDmZ4uizec4t8ZufuqVgWs0Y
         bE8Yb50FkvbcXH8QYP+77f4m0/dJ3cn2Sbk3hGO+00aS5Lu86IvmIxTtJbtzvUI/Smj2
         aHBM1X8FcNMDESf/coQ6L6VratVoQxf6xLYt5sXG9WujKA9NFKN80z6ESSy7Wo/ElRq8
         oxYC03J2zeiB4U+cTNHjJO063jmS0CjFLioljUYkQFL9myTHZLcKSjdl0/lHig7D3sv2
         ZhZJyNFWRbFuFNdR/C1DyIO1eIkVB2YXefTH4sCBUg9/7KhHXV9602nXmQzAnmzDqcaS
         fOHg==
X-Forwarded-Encrypted: i=1; AJvYcCXkE2WTrZ+m1SMEHhKyazMpuwBar0qnATkBaqkxM9GTZ8Bawm1fA6Kj43AsRYSHtj0/C7ZkaXBx@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVFRkLCMe6yqjiTsfQB3ZZC9WL22yePYcnZk1HwDDIWMlVR57
	rusQrcFMKu/ENNE8FIh7J8fSck5nY4g4c7V3InaSw+AUxZclWh8xF3UWwZkW3+Vr12M=
X-Gm-Gg: ASbGnctcvpP3j//rR4u+zEvw2wIk18ECARi/FozSfauxpu5Wuc1NbpbSiSiObxMehk4
	5Ywo2ZjtQAYedn2sIN/le+2PJACkB89R8CMarXlIYQt//KEYHk7whdbWo2iLlyW4tErdSaGW2Na
	vV683wTKOTIg7mD+ruIuCxAegPsuJjJX2kuXbllTghlzOKM1znnigiLW9My8t1lkSawjODXB8I4
	/kpTnXqMWv7Kf3hS0A9WGJ8i2S6xphSKXN5tCYifMmnDVQpjHu5G/AEUeU+8x+hzTPph64W+msW
	TdZhvjBOr78h4KTaVxtKYC1S1xaMh4LE6QuZ8v1UggP2S9PtFo2aa+8uy8nAJVKLvj5cQH//AyW
	iPGysedMihEjLyBASnzzpgJhYxcvLqkZtDpf89KKzGP/4QBWKNrg2bz5TfcvEDjw2ygk=
X-Google-Smtp-Source: AGHT+IGxLyC2md5Jx51m9HM2p3j5fCUCQApXbhQWufGaXIfDffbKLaJKFwko+zfFqgwUdARWXwlQ8Q==
X-Received: by 2002:a05:6000:25c6:b0:3f5:d7c0:8e20 with SMTP id ffacd0b85a97d-425671c53f0mr2152207f8f.59.1759500025479;
        Fri, 03 Oct 2025 07:00:25 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723431f5sm31917445e9.2.2025.10.03.07.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:00:24 -0700 (PDT)
Date: Fri, 3 Oct 2025 16:00:22 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tiffany Yang <ynaffit@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
Message-ID: <nbtofen2pwqmp7r5odbyc4en6vv54rpznyaanxlb6tbx5yyg25@jx2re5hdmt5e>
References: <20251003114555.413804-1-nirbhay.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="twwjz6pyzgqr4kbn"
Content-Disposition: inline
In-Reply-To: <20251003114555.413804-1-nirbhay.lkd@gmail.com>


--twwjz6pyzgqr4kbn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
MIME-Version: 1.0

On Fri, Oct 03, 2025 at 05:15:55PM +0530, Nirbhay Sharma <nirbhay.lkd@gmail=
=2Ecom> wrote:
> The commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> introduced a seqcount to track freeze timing but initialized it as a
> plain seqcount_t using seqcount_init().
>=20
> However, the write-side critical section in cgroup_do_freeze() holds
> the css_set_lock spinlock while calling write_seqcount_begin(). On
> PREEMPT_RT kernels, spinlocks do not disable preemption, causing the
> lockdep assertion for a plain seqcount_t, which checks for preemption
> being disabled, to fail.
>=20
> This triggers the following warning:
>   WARNING: CPU: 0 PID: 9692 at include/linux/seqlock.h:221
>=20
> Fix this by changing the type to seqcount_spinlock_t and initializing
> it with seqcount_spinlock_init() to associate css_set_lock with the
> seqcount. This allows lockdep to correctly validate that the spinlock
> is held during write operations, resolving the assertion failure on all
> kernel configurations.
>=20
> Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D27a2519eb4dad86d0156
> Fixes: afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>

Link: https://lore.kernel.org/r/20251002165510.KtY3IT--@linutronix.de/

Yes, this is what was discussed yesterday. Thanks.

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--twwjz6pyzgqr4kbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaN/W9BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgskQD/VZYTSgJV8TksM06o+G+A
UVtyHkxTmx7U6OUOjRKT7lEA/i5BQk7/GJc2WflFnRYc7WUQqlTYbotjwBZ2vWgK
dSMB
=4Bm5
-----END PGP SIGNATURE-----

--twwjz6pyzgqr4kbn--

