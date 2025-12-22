Return-Path: <cgroups+bounces-12589-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59259CD6885
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 16:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 811A9304B00E
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 15:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F5932C33E;
	Mon, 22 Dec 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WJQI3p3Z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64232AAB0
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417203; cv=none; b=OfZwgTGB/69hqKlgGy7rB5w51apGOo6l3TQR+V0e6xRF9tfVScebmDLFVhWsNlrBqaeqCXilVQh35+9s/cGagppbFcCXMPJ8AvnrykMLChAxz+Aj/plwLkHDQF2GuP29zBZ0K+3rMat9zI1SEbheth6tUb4CLmFTPLAtzyNNS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417203; c=relaxed/simple;
	bh=pwNdHHpa/mgCoIpKqTkujCQuzfwTh0JljZB8DKCH2/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFGf+QNG4fkFbGfADMlDGEKwu0Dx61imB6PiNbL2lA7cxk3lqqaqWqABLr5gGQYO7pictsP0D2pMQ3/FFKhgR2UdwdWPFe8CUhrja0R7MTqcci9CCniEClO7htbQY+r5m/kMTujZPv2vWKkk25Nb9A2MJpySEuFisXhO+WRFedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WJQI3p3Z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so25734405e9.0
        for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 07:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766417200; x=1767022000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjy1Kjs3/ZvkfmJuAkFjz2P1LbrD8XoaWU4C0z0fF0Y=;
        b=WJQI3p3ZBuwR32N916ckAsnefzTxY32fwEC4yHDoQZwu36RqmiWPzknpQhkpeZvJUa
         zOf71E+k+AF3jbNSKe8dij+NXC7kPYj9VvBEVgo/wTm2RfQU+tmoSlbUVL/BIWGyYp3b
         nPaRFflxvL26qvTKOaWnnCwhK7AK/yn62sVjRLR+9FROSjVsomQpIBo6jEHFStfAO87C
         fj2OSNh2eVGFCJdDY52ac0vmwFJy93KzRzCqP4KgOekIYonsPfhoP7CJLP9KTt5dFUix
         6y8vMrt5aGAnNjBc4v7DdPsQPzXB1tNL5neq5mTeo5hHe3tuSgRgtWsjocSVdC+9YCpb
         F8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766417200; x=1767022000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjy1Kjs3/ZvkfmJuAkFjz2P1LbrD8XoaWU4C0z0fF0Y=;
        b=bYHUFXyq2HrH8Fk7Q1Lm9CX3u6ghOpv2VTgBQp4yWOUro7nPo6Ch+WUzPo3d6El67K
         78yXUweAhGx3EzXscOPhGXZPUalznw7tJenD2AoQf3wnKh+sf2BAaATM6J/EuZhm79pG
         yh1NShAtyPtIHftv6pjf/ErCRNn/hjRvmrkBOSferiYxmEmCNaKRcWulR0TuwZmeyb9Y
         t6PTpSX9iQt0NeBfEGAfzMmkyBA6tLFE5PR4GS/GtKrLEh55E99LrmuNT6KpnqoIZFYy
         ++Ekf3G+geHHcmKLP837ZWVgm6Pxw0o26gzZ12LB0ACeuLb+jYSrfpqAfyT/YONb0od6
         JeiA==
X-Forwarded-Encrypted: i=1; AJvYcCUTL5xTwYdAYXHPQvgar56pKV2fxu3QELVgFaAPxfWbEfKbY7wOfiXAbW+vkYpXFt/S+eLvkJuH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6N2vplJ1CFYVaU45C3xngf3mC6GnUmNpqOzUqY82WXZ35tLo
	62B7rqj1i/aBq4V5bfB0nuLlV6oEbA64/XGVa1PWRh9HuOyqCDuDEwq6LyuLTV/w8S2qpQ8imfF
	OJRtk
X-Gm-Gg: AY/fxX6Ip2Vi0+0jmURWetqtGRoragGu5G8mndLWhZD75f1X384eTnHx0DndlWaGg40
	fup+Hc1+//uz6H2gxLKb7epmbonkE6dydNRW4ayH2iZtagC4jQ4gA6otLWghZzQp47FX+mwVAdU
	1gPdlh0iWQb6TdQ4gIoYV38PeI38N1/+gNJWGo0jqz43TmGyPkCEYOiCWmBakY5HU8Yjcx1/NCb
	EEW4GQY+A5fVDytVbdXCbf3SalnPXjFlRs0a2PsvqIno7rPR/zxTM+NGIzioe6r8F8K/OzszilI
	2e4U5iZXW+2RGpw2qWKENn3tV2ZiuDVbJmDgf9N/3MOWxevGB50tROKXtpj/cd6g8RGx+8PWwym
	PwTmMaI9fIHKzmFbKj9WhRMWQrhX3Rj/Jg8EO7RT7JoYes24Tos9SpZuwuYhBJJHCyKbV6sHo2r
	vs42UBIxQE6+9N55olFU/VSLyAVwLFsZ4=
X-Google-Smtp-Source: AGHT+IHCWwWWu16oace00eetULfbyQ1yeoAIFkHbV1aagHIcMBr/qJSFaMSGj9gXlACcTBlm/9/a5w==
X-Received: by 2002:a05:600c:4686:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-47d1954ea05mr132516445e9.15.1766417199600;
        Mon, 22 Dec 2025 07:26:39 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b36fsm22585186f8f.5.2025.12.22.07.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:26:38 -0800 (PST)
Date: Mon, 22 Dec 2025 16:26:37 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: llong@redhat.com, cgroups@vger.kernel.org, chenridong@huaweicloud.com, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v6] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
Message-ID: <bzu7va4de6ylaww2xbq67hztyokpui7qm2zcqtiwjlniyvx7dt@wf47lg6etmas>
References: <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
 <20251201093806.107157-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jhs6khkmokqkwfrw"
Content-Disposition: inline
In-Reply-To: <20251201093806.107157-1-sunshaojie@kylinos.cn>


--jhs6khkmokqkwfrw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
MIME-Version: 1.0

Hello Shaojie.

On Mon, Dec 01, 2025 at 05:38:06PM +0800, Sun Shaojie <sunshaojie@kylinos.c=
n> wrote:
> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
> with its sibling partition, the sibling's partition state becomes invalid.
> However, this invalidation is often unnecessary.
>=20
> For example: On a machine with 128 CPUs, there are m (m < 128) cpusets
> under the root cgroup. Each cpuset is used by a single user(user-1 use
> A1, ... , user-m use Am), and the partition states of these cpusets are
> configured as follows:
>=20
>                            root cgroup
>         /             /                  \                 \
>        A1            A2        ...       An                Am
>      (root)        (root)      ...     (root) (root/root invalid/member)
>=20
> Assume that A1 through Am have not set cpuset.cpus.exclusive. When
> user-m modifies Am's cpuset.cpus to "0-127", it will cause all partition
> states from A1 to An to change from root to root invalid, as shown
> below.
>=20
>                            root cgroup
>         /              /                 \                 \
>        A1             A2       ...       An                Am
>  (root invalid) (root invalid) ... (root invalid) (root invalid/member)
>=20
> This outcome is entirely undeserved for all users from A1 to An.

s/cpuset.cpus/memory.max/=20

When the permissions are such that the last (any) sibling can come and
claim so much to cause overcommit, then it can set up large limit and
(potentially) reclaim from others.

s/cpuset.cpus/memory.min/

Here is the overcommit approached by recalculating effective values of
memory.min, again one sibling can skew toward itself and reduce every
other's effective value.

Above are not exact analogies because first of them is Limits, the
second is Protections and cpusets are Allocations (refering to Resource
Distribution Models from Documentation/admin-guide/cgroup-v2.rst).

But the advice to get some guarantees would be same in all cases -- if
some guarantees are expected, the permissions (of respective cgroup
attributes) should be configured so that it decouples the owner of the
cgroup from the owner of the resource (i.e. Ai/cpuset.cpus belongs to
root or there's a middle level cgroup that'd cap each of the siblings
individually).


> After applying this patch, the first party to set "root" will maintain
> its exclusive validity. As follows:
>=20
>  Step                                       | A1's prstate | B1's prstate=
 |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      =
 |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      =
 |
>  #3> echo "1-2" > B1/cpuset.cpus            | root         | member      =
 |
>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root invalid=
 |
>=20
>  Step                                       | A1's prstate | B1's prstate=
 |
>  #1> echo "0-1" > B1/cpuset.cpus            | member       | member      =
 |
>  #2> echo "root" > B1/cpuset.cpus.partition | member       | root        =
 |
>  #3> echo "1-2" > A1/cpuset.cpus            | member       | root        =
 |
>  #4> echo "root" > A1/cpuset.cpus.partition | root invalid | root        =
 |

I'm worried that the ordering dependency would lead to situations where
users may not be immediately aware their config is overcommitting the syste=
m.
Consider that CPUs are vital for A1 but B1 can somehow survive the
degraded state, depending on the starting order the system may either
run fine (A1 valid) or fail because of A1.

I'm curious about Waiman's take.

Thanks,
Michal

--jhs6khkmokqkwfrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaUljKxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjK4gEAnmAgBR1zluxVRUWU0Xru
zJo9m6L+TLwXGPFVZC4ECHIA/0oinQGJZ9xsp1tBSb/gmb/xtN+FH6zyZye1Eppu
e1YL
=XUDG
-----END PGP SIGNATURE-----

--jhs6khkmokqkwfrw--

