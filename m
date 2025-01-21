Return-Path: <cgroups+bounces-6244-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A2A18538
	for <lists+cgroups@lfdr.de>; Tue, 21 Jan 2025 19:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02F2166C53
	for <lists+cgroups@lfdr.de>; Tue, 21 Jan 2025 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE88D1F7076;
	Tue, 21 Jan 2025 18:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CBVjj374"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87B1C1741
	for <cgroups@vger.kernel.org>; Tue, 21 Jan 2025 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737484194; cv=none; b=XEnoritQ1Osfm7O3MvlAK3e5HlL6eKZ5h531Q4TQuDqejroC0XSIDrJxtlqtMi/8wHjNExzqGXBXYljzJJSXDvOCCCGZptroxEuK+tvABIxcTUt5B0xcW9rJPx4ycg58BbU19poabZMpOkkc4eHreEjBAmPVjh+5P2VZPetsk/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737484194; c=relaxed/simple;
	bh=jqDzj+eTPBIMLC2SCvL3JbqmPEgXso2MiJ7GoqGTJng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wdmk0mKskk2JUOVw/TLV/Qa+C72GQEMxA7ulBXlXpeK0iw5fHu8PtWYw0l41qdQo3t8YOi/oXfMk07xztaPHSmi9x5AdbFMLeSwziqZrBc4Y9zVlkrsppErbOQ/lkj1988xer7Jwyc5r6Xw6nmSVNsd3cyAf+VPB5lncqSn6e5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CBVjj374; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so59421925e9.3
        for <cgroups@vger.kernel.org>; Tue, 21 Jan 2025 10:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737484190; x=1738088990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkAKeDcaoc8aic3fG+NCS5mGcWlbtV39f2bpcRLuxIs=;
        b=CBVjj374ySgZoWRqkz/ZOjaeJC02SUgJTl3e5wOoWNU4ivRFj6CtucAn/Eun3JucxH
         FQ+FKYQ6uK7khIZhR14Nw+5pJs/VzBdsbL9EXArk7eQGBALQ7nw+g7BnOhvTluVhD/E6
         kHX63P1iDAXceWcKVtKMJ9sqHFLsOYa+8b/skB9njTq53rClIVnqZQBrH/VJC9WDuKb/
         bXCPPVoajZGv92bDycH2b9RAJL0cEIdeDPnhLCbCtk8sAxbBVmJdHA1IP1JKVi42gJMB
         6v9navO29kRkaeLf0+a9NpT5s+gS8wVxsctQEkidvjqSKc7hu3KR/tm1iealqp+Ik6ct
         vuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737484190; x=1738088990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkAKeDcaoc8aic3fG+NCS5mGcWlbtV39f2bpcRLuxIs=;
        b=qlkO+iJyAxLxcYXrHY+edVyBSKKLkB92m+J14vXiAdYxcBdBTDGH1gUI51sx82kVsX
         yGAEzJ3IMnQSLWz2MOJV8P+w9gUowZGbajRPWlv4XBTDvkkUF+OE1FuAJeemTQ9q4h5g
         Oef/UcGNv1lUTnQ+NQ5ildUM6O3yQrZXjlwQxiZLDZqYosa/HKBUOy1g58tBkNbEV9Az
         1z7oAxVf43rCEVitY2Nmn+X8gLihxPAQJi9NJ2U0f9mQ0k+Tde+GpT6RDEFvnbWPOh0b
         Kj1VbuUjl1DEBG/D0ZtnWg4VOFiv95ZYp0Qizm8ZsE0uIcYtkgJN0KVcGCBGwLlQ+uUs
         nfbA==
X-Forwarded-Encrypted: i=1; AJvYcCUL8i7oEv/fGEhrERVCAMRMmUdAmA0WTAQJEX4V4RLcSqitrThDRvmC/vuJRVvmJrzrtYwjytFE@vger.kernel.org
X-Gm-Message-State: AOJu0YwopUD9tvXc9Px3ytAprPGHX9rjeBTeNtehDUnWAzaXR8z/6dSn
	ejucY+8SKD4gPcyMdg7Vo5ZnsksGyUN3Cf1De48Et1ih/W8WcBJ4Cq09x4uHm6M=
X-Gm-Gg: ASbGncuhHprr0cbWXUQPEcfNE6Y7OeD2QYlHbTpmk2VzA4crIpZx5b46EC6m/Lp9ylm
	boxGfrXbEnh+1iyh1/MfmfGXiNbH5mFJeW/e8jUOV9kbNxuMopB1Rf3AS3D4/7q5vyzVDfPgQ+p
	kUqGwBHIY12wZBXEB59VxUFR/2Uihz/wh3/C0iYUunPY5sQyl9x7kBxqOwInOz7G8MflulqXV1P
	GFGd2UcAcGUs3HCd2rS47wZH+ZHNgsrgzFk83zHemlbfQoTluszfw6GHuJ1uwv4/mGfgvlx
X-Google-Smtp-Source: AGHT+IHfUrUKD19ckbGWZSAxbod4Fwp6AvvMqNG6Dkq6zkY1uEsGnMGxwAgZfueRaa6lpWJgnlQp+Q==
X-Received: by 2002:a05:600c:350b:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-438914671fdmr193243775e9.31.1737484190523;
        Tue, 21 Jan 2025 10:29:50 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904621cdsm187778135e9.27.2025.01.21.10.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 10:29:50 -0800 (PST)
Date: Tue, 21 Jan 2025 19:29:48 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: syzbot <syzbot+622acb507894a48b2ce9@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, elic@nvidia.com, 
	gregkh@linuxfoundation.org, hannes@cmpxchg.org, hawk@kernel.org, jasowang@redhat.com, 
	jirislaby@kernel.org, john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org, 
	kuba@kernel.org, len.brown@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, mingo@redhat.com, mst@redhat.com, 
	netdev@vger.kernel.org, parav@nvidia.com, pavel@ucw.cz, rafael@kernel.org, 
	rostedt@goodmis.org, songliubraving@fb.com, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org, yhs@fb.com
Subject: Re: [syzbot] [cgroups?] possible deadlock in
 console_lock_spinning_enable (5)
Message-ID: <6pdxz7oqr6442cczbec7n3cqtldrrpfsdk7ynqjguiqp6d5ucv@sibkx2lfldvu>
References: <0000000000001e66f5061fe3b883@google.com>
 <678a4e3b.050a0220.303755.0005.GAE@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="flx2psaakqlkzlmd"
Content-Disposition: inline
In-Reply-To: <678a4e3b.050a0220.303755.0005.GAE@google.com>


--flx2psaakqlkzlmd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [syzbot] [cgroups?] possible deadlock in
 console_lock_spinning_enable (5)
MIME-Version: 1.0

On Fri, Jan 17, 2025 at 04:34:03AM -0800, syzbot <syzbot+622acb507894a48b2c=
e9@syzkaller.appspotmail.com> wrote:
> syzbot has bisected this issue to:
>=20
> commit bc0d90ee021f1baecd6aaa010d787eb373aa74dd
> Author: Parav Pandit <parav@nvidia.com>
> Date:   Tue Jan 5 10:32:02 2021 +0000
>=20
>     vdpa: Enable user to query vdpa device info
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1440c2b058=
0000

syzbot got this somehow wrong, it started with the lockdep bug but then
switched to a different
| crash: BUG: unable to handle kernel paging request in bpf_trace_run3
so the bisecting session yielded (I believe) random commit, didn't it?

(The lockdep appears valid, with PSI enabled and the fault injection at
unfortunate place (with BPF'd tracepoint).)

Michal

--flx2psaakqlkzlmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ4/nmgAKCRAt3Wney77B
SfWDAQD9atuzOG3FHcpa9TZop/UV7vy3rJ7Nt2Jbeo9pTOreKgEAoQlnyi+4Metp
9vIjKtqdXgf9fmKryAgGyrYpKRkNAws=
=bsM8
-----END PGP SIGNATURE-----

--flx2psaakqlkzlmd--

