Return-Path: <cgroups+bounces-10524-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60449BB4A4C
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 19:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B162A2519
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7762BD03;
	Thu,  2 Oct 2025 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sm50b3YV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE042A99
	for <cgroups@vger.kernel.org>; Thu,  2 Oct 2025 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425460; cv=none; b=BTcuFIkz1CUVGgHgsPhquvIW255VopViLffMkoRd7/EZeyyudrHQdVvyG2pOx0z1YMSXfb/4d4AFqIETM/tkQqHfrowAwLANASj3K6JIkr7AJRwS9NK/v7p4wkFFooT/Joeyk2JnJyQmNGgAU/ezgYF1A+MkWyjdnJTNUKWjtlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425460; c=relaxed/simple;
	bh=jvFZrFn5e7n6PhwcbhBV7Smq4LwxWDGpJHOfXtGaf3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScP9heqgructeWu5OvhfZAerRicXkO16utqVol+opBiron91a2BqhKG6AOZuDPcFSbzokleuxNS7q9M/gWwNyScYdCdJgpjGw0KvYaoXOvO9ldZfsWDLdhhrp4RxptczNa7R1psw5NH8jhS5+yl22vHchUH39MGlVv9EsfGn8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sm50b3YV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso11360075e9.3
        for <cgroups@vger.kernel.org>; Thu, 02 Oct 2025 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759425457; x=1760030257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nEqi5LiDufQ4XizIhNMHWocMl1nEMNZ4fHJRUgvpBfw=;
        b=Sm50b3YV9CByaKrnHkwKfxNX/YoXxn9N41S+PW+9az7RnqrKPShYh5m/CpXv2eWcjZ
         bbpxbQD/EYW102jHEh6WsVaGmySlmmkj7MmfhIywkfUW3OWLnAdl7PjFXZ2RKJLX4A4/
         IDZu7poqtwMtnm1ZTuTZCkjSXjng1FOa27r+FJfmT2ProktwNjLABFQzjFkJZlJITI07
         wFz0+MSnHvcbRC3PQrcvixL5xcruednP9aYdehJEm1WNEE4B2lj55bGI9FVK1yBNvD+f
         mdRoATlBBIfOR43XvCF6T0+LMcwzpfuYzy7hhW4Hcj3ST+TXlh7V2AYUz87St573N9Me
         Vl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425457; x=1760030257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEqi5LiDufQ4XizIhNMHWocMl1nEMNZ4fHJRUgvpBfw=;
        b=cOsPV8d6yHy9ehQkJz0ScYV24WJwILVtWRb8bYZDddakYaomi8axsMvTiGcxmhHM2h
         v/wEzgltfqMttLHf6CPgALC+xlHYACZTqtmakDFaaGcXBIpC4UR+m++wiTcHSjbg8Abf
         ELv5WTchYMNVMOeRXuBEK9Bm95tqDNbhcO8v/YC/+NwfcAItd5Sc6mPUhdHvxLMdJFtE
         m+2vpC//b/QjP4MTGYcWzpyitONSpXzP/BNlC57ai/bcsqeGisLNUyGjY1b1tc1oaNeD
         3bS/jp8xko/Wa77BO2lueL5geU2PhGkr5TCR45elOmR2bbeYsFSNofsDdm+jPXg6WSnI
         ptWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJg4MJ0h0/jfOUzhdB+GA63vuWTAPy6ZN9sMO2ZXAFUBVMkAz8x00DOyp26Qw650o6rQdSpj5A@vger.kernel.org
X-Gm-Message-State: AOJu0YzOGoORytLvK6ML3lMT/Metxz8ditONstUzk4Z+r3ZnfRmLXvzC
	DimaZG29o+PoDvAFpi/mpUYNAptbBIyvoKBY+cnQAaEIl2OeSyD6DVJD+2OnKp0WfL0=
X-Gm-Gg: ASbGncsJm+qpF5OYpa0oI7V9wfdynWTVLAHvGmfoiLui/ydgsh/ml53ZbYx5bDzLKmd
	VBPIIWT1YqKKBeSROpJPkNTIHV3fbHqYUmjpap8AhZpZ/8rxjZQg7Lc2IDrCYx2WP/clHGjV81i
	W2a2k6v9RuknlkZ/YdeQTc7J0soqXttAdpXrz/R9S9XB8MHR4kpbLdbCoGM92NxzReNgU7mLv/a
	/w5aI4A+e5KlCbcTEHw5Szq9TUaKzRPHfSBdnWUE4d6u+915VufgYSQZDyoCAl2mGMvXydd9E1D
	iLJtiibqo3AGqLI3L9rD811Bmew0X+PTf0zgOL0gJibzDaWPe90E84j3iT067ni/WrfT1nojwZ7
	giHGgiW6GpS4jcpqj1Hf+VhtduPgqnPA6xL+P8MWQeevGqYxVLRH8Hmy77RoSTQ9ZC2M=
X-Google-Smtp-Source: AGHT+IFVIFNSt0EkPwbXYMRmsUgvjGJ90zoP3cCqPOxCOQ7syB49MVnAQ0tTwadDuJJr+K2gGskVDg==
X-Received: by 2002:a05:600c:1384:b0:46e:19f8:88d8 with SMTP id 5b1f17b1804b1-46e7115c5cfmr202265e9.34.1759425457072;
        Thu, 02 Oct 2025 10:17:37 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a16e13sm92087335e9.15.2025.10.02.10.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:17:36 -0700 (PDT)
Date: Thu, 2 Oct 2025 19:17:34 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tiffany Yang <ynaffit@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
Message-ID: <3ecuzzwx73xti3hhm6aoolpodpvntdw3b56cq6au63luodhbmo@bwgm4v5rxobo>
References: <20251002052215.1433055-1-kuniyu@google.com>
 <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
 <CAAVpQUCQaGbV1fUnHWCTqrFmXntpKfg7Gduf+Ezi2e-QMFUTRQ@mail.gmail.com>
 <20251002165510.KtY3IT--@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hrmmohwe7ivs4hnr"
Content-Disposition: inline
In-Reply-To: <20251002165510.KtY3IT--@linutronix.de>


--hrmmohwe7ivs4hnr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
MIME-Version: 1.0

On Thu, Oct 02, 2025 at 06:55:10PM +0200, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> Nope. period_seqcount is a seqcount_spinlock_t. So is pidmap_lock_seq.

Oops, I didn't check that write_seqcount_{being,end} are macros that may
accept different types and mistakenly assumed seqcount_t too.

>  	/* Freeze time data consistency protection */
> -	seqcount_t freeze_seq;
> +	seqcount_spinlock_t freeze_seq;
...
> While former works, too this is way nicer. Not sure if it compiles but
> it should.

Thanks! (It's therefore also better aligned with the other occurences.)

Michal

--hrmmohwe7ivs4hnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaN6zrBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ai/IAEAtKwPeHVDsi3iKGHvJSrT
1RUKf3glL+87w6uXTAAE4v0A/2tUcS+rEgj2/ukWAn1K2FmmP4bHQUMytwfBuB+8
SFUM
=AgIL
-----END PGP SIGNATURE-----

--hrmmohwe7ivs4hnr--

