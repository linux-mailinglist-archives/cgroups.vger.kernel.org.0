Return-Path: <cgroups+bounces-12288-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 967F0CAD72E
	for <lists+cgroups@lfdr.de>; Mon, 08 Dec 2025 15:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A864301AD2D
	for <lists+cgroups@lfdr.de>; Mon,  8 Dec 2025 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FFD32AAAB;
	Mon,  8 Dec 2025 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WbYhK0vb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819732AAA8
	for <cgroups@vger.kernel.org>; Mon,  8 Dec 2025 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765204318; cv=none; b=NI1DpPEULbdGhG343MB1sOASow6AQMleYfgDxL/gW4SW3ZzmT9T57pX9CqAxQfmSWgzHhxADJJASO8vfni+bwuFqx1QQMYNtbQWsZxClsG3gEY7Sc0eMbCHfAuSap779uxVL4D3PYoc8YcN89kXGlkAEoUISPAwHKqH2T/5uozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765204318; c=relaxed/simple;
	bh=O3Uh3B4gYAOFneJgek3n7rIoT2td1Ad2IKeXnSRNodk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6KpmAnD9kFfiFv51vVZwrAivcxyD2DpA+ZOgONeCrkgF3YpvQ+F4tZDP5DVqkNbCAJCnANp2/Rp0WZwIreRzYo2282+mtlU6udcF4i3TdaO2lMLjfGXOQZabnx8ZNG+se6RMHUhle7TGw1hufzYxhqlYlqlUkR0MYTLNUmxCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WbYhK0vb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42e2e77f519so2894767f8f.2
        for <cgroups@vger.kernel.org>; Mon, 08 Dec 2025 06:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765204315; x=1765809115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zbS/TB8hAZ6DXQ0g6ryy+CyTpWKhfJVHRWKBtDSGFk0=;
        b=WbYhK0vbg68AsMM99gu2KpRcjgIib3jHGoJ1FhN5HlEHLdWOA0o279/RF5KNYmgWTa
         9fl1vpBN6CbdLsdmfxAvUdmij9oRUnyTPK3Z/UhB1muwLZcAn+TZJTURJvXLgi49uqaQ
         WeNA9aoiuZlgbnuShzd3A8FTp9hJAAtUTCqnaKQrrI6uQ16+Jyo7y5OmNuuz2/6VSqiP
         JeQnie9s5YehgKGXFhtOtvRTS/avzd3zZ5hqC8hVUaE+f1+X8S9YkKyGo53ovYKT3XNN
         Cu3gkGwKmPH3b4rhqTsS9hJ7aktWqb3c1eTfLSfoTGq9AmHQNBm+mok7EUuUZEhGsSRG
         Mw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765204315; x=1765809115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbS/TB8hAZ6DXQ0g6ryy+CyTpWKhfJVHRWKBtDSGFk0=;
        b=ZLXorMbJGlICfgBYS1NcuYJtBXurC2ISnkTk6a0cyhofH8Q37kZBniQpKEOaa0YXkF
         FnkLc3MfXu7IYZ6yr6W9+J2FNefqiS6a1t/Cy9FDpvJHcicIeq9TqLZ58OstkCEdt/+C
         u6lNqvBRKnIKQiJnuJoMdcLn2oJ3SEQz7dNrepNeWIV+/xWMMRdJcxhFg9R+LSK13pnh
         WzYtK79oynqlUO6kg/qA74FI1bmLX9V+6nJVgp/Rcvha5TCUCZ5JcwG4E+zc0D2BOcgm
         XJ4y4asnylAtkRh1FMa2DIxpOIZdwGrbW4+f5I+G0yqJorvcllBwB4lxNhhs10p1vluf
         E4lw==
X-Forwarded-Encrypted: i=1; AJvYcCVBNe6O48fH4TILO3MHHvtj/18Vx8hqHdvmKdT+X4VE2qku1dahWmJQAeBo2lU96GpMt+GEwPXG@vger.kernel.org
X-Gm-Message-State: AOJu0YxEOrrNKe/yU2fma5pi4TZQTO9lERaEhIZyyoHmTK2foXFdkvXl
	rxp4SAQZy2goS3I/cnfN/fqb4vSkhLhzjP9l+6KwJ6IbwRokWp4i6TiStam3uF09/TM=
X-Gm-Gg: ASbGncvP5gK4sZ9bBGRBj0iJrDztgu2B5Umn3SDGlb1ouCKrCvpaezyA/z5PPxakQk3
	vLTO1XMvitm1tZDBJW9vlVANsbgS4INcl8uvOYsGSNzsmLa0FyX7OvhU3K7bye2cG5xEhVWeJ3Z
	LGSSiao3r91/FMWSOQVdl+TN82vVuuVeCxEvs3zo50J9twM1j7mL8werN0W5i3nBIoafAOK9waV
	FgRjlIq73KnU2jbVTSMsKwioAph0tvNolWjeNtPnfY1YqYyqzMnmbHDDrnmPitjw9dNGJNraaN7
	WBeibSBv395FPzqv1Z3fmMhuokrM4BRQ6BwrCDMdPcj315TWq2rLt4Txpi2AVFOocLxRREROyX8
	c9OTFha7KG0ukvQ3WKRFnP/jcJ705O6DgsfEysAxTpBNXWOPXL1T20Nu3IQ1kYTy9y4UjQs2jR4
	YmK05swUApqNa36lmBnVwNL8Xq536gOa4=
X-Google-Smtp-Source: AGHT+IFE7vUIMGvCnJOjKOCQWrdf18Do3wS1MnUJq3sK9xI/Jc79nYC+PBM3L0+BYybJi+Ost3nvog==
X-Received: by 2002:a05:6000:2f88:b0:42b:30f9:79c9 with SMTP id ffacd0b85a97d-42f89f455c7mr8439244f8f.37.1765204314477;
        Mon, 08 Dec 2025 06:31:54 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222506sm27611266f8f.28.2025.12.08.06.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:31:53 -0800 (PST)
Date: Mon, 8 Dec 2025 15:31:52 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: chenridong@huaweicloud.com, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	llong@redhat.com, shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
Message-ID: <b3umm7mcucmztqqnp6x4e6ichqcml2r2bg7d2xairxajyqrzbt@3nshatmt2evo>
References: <45f5e2c6-42ec-4d77-9c2d-0e00472a05de@huaweicloud.com>
 <20251201094447.108278-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ji2b3cuc5ipyhw7r"
Content-Disposition: inline
In-Reply-To: <20251201094447.108278-1-sunshaojie@kylinos.cn>


--ji2b3cuc5ipyhw7r
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
MIME-Version: 1.0

Hello.

On Mon, Dec 01, 2025 at 05:44:47PM +0800, Sun Shaojie <sunshaojie@kylinos.c=
n> wrote:
> As for "different operation orders yield different results", Below is an
> example that is not a corner case.
>=20
>     root cgroup
>       /    \
>      A1    B1
>=20
>  #1> echo "0" > A1/cpuset.cpus
>  #2> echo "0-1" > B1/cpuset.cpus.exclusive --> return error
>=20
>  #1> echo "0-1" > B1/cpuset.cpus.exclusive
>  #2> echo "0" > A1/cpuset.cpus

Here it is a combination of remote cs local partitions.
I'd like to treat the two approaches separately and better not consider
their combination.

The idea (and permissions check AFACS) behind remote partitions is to
allow "stealing" CPU ownership so cpuset.cpus.exclusive has different
behavior.

> >   root cgroup
> >        |
> >       A1  //MK: A4 A5 here?
> >      /  \
> >    A2    A3... //MK: A4 A5 or here?
> >
> > #1> echo "0-1" > A1/cpuset.cpus
> > #2> echo "root" > A1/cpuset.cpus.partition
> > #3> echo "0-1" > A2/cpuset.cpus
> > #4> echo "root" > A2/cpuset.cpus.partition
> > mkdir A4
> > mkdir A5
> > echo "0" > A4/cpuset.cpus
> > echo $$ > A4/cgroup.procs
> > echo "1" > A5/cpuset.cpus
> > echo $$ > A5/cgroup.procs
> >
>=20
> If A2...A5 all belong to the same user, and that user wants both A4 and A=
5=20
> to have effective CPUs, then the user should also understand that A2 needs
> to be adjusted to "member" instead of "root".
>=20
> if A2...A5 belong to different users, must satisfying user A4=E2=80=99s r=
equirement
> come at the expense of user A2=E2=80=99s requirement? That is not fair.

If A4 is a sibling at the level of A1, then A2 must be stripped of its
CPUs to honor the hierarchy hence the apparent unfairness.

If A4 is a sibling at the level of A2 and they have different owning
users, their respective cpuset.cpus should only be writable by A1's user
(the one who distributes the cpus) so that any arbitration between the
siblings is avoided.

0.02=E2=82=AC,
Michal

--ji2b3cuc5ipyhw7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTbhSRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiR3QD/SGEhKmZeuPCjZm+gTCIO
JD8ZSy5Dy5ZU6hpXQCtRXvEBAKsTxFqdq+5hdMBQKpsxhCKKGYjnRsciVMJNZ1AA
ThYG
=qpLP
-----END PGP SIGNATURE-----

--ji2b3cuc5ipyhw7r--

