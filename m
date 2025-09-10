Return-Path: <cgroups+bounces-9972-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05DDB524AB
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 01:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C8C1B25E6F
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 23:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC813019C1;
	Wed, 10 Sep 2025 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDZjflnT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B4026E708
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757546826; cv=none; b=NMpO4lks9qcekc4FoQLczgRU/OIMudi/j7zt50BkXp7148MoSsRSeW3nB+k2AIYXUF5XTZyK4yDBMOO7FMaWb2hmrbytTVRG1SA0ZyPtnKsOu4xKuK2klHyZzqGt/zu3fj+tkJLWjCtUrlf3liA93uoN1eJ+2I6QyweDy3wRZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757546826; c=relaxed/simple;
	bh=Rso4kMNY++0mX+1Zk731FKkeDHtrEi4q28Veb4zHENY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRlQxBgmg5FgE9SfGpYxI+HCCeScAc2T6oTkzetd0oHpV6kcRVGxyKMXYHSIjZ2WUzJ6eY7OmnhNGotDsMi/invu/ePOz1PQa5RYlejIX6qi6QQ2ZqMYxXq9wxHsV7dVVL82KqKfUQue9LAWnfc89fIMt5UApbWxXYIgvbBoP3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDZjflnT; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772481b2329so149492b3a.2
        for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 16:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757546824; x=1758151624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z00uyoYaPpbnnyjTQiKQAeAb5AJf67lVttafJphDMJg=;
        b=XDZjflnTJn4qE5VdkvpfubzrBvIxzx5tJhsrqJYv6IvCWhH+pAwALxZErqNkzPuTrL
         ojtHVlFS1w3dCINqZPDK0sz9IIBHRMga9V1mLk1AKnIJkLC0iQ4enoqrn75GbcssgsT3
         oXcH7ZDAyuJ/OrtpyDTIc+nNhKdnpT9FSf59QQuza3FXaeOulu4oYyPMPF8S1ITrJ17Y
         l0uMzoBKq/muNdYfYrsEoCP5qCA0nxgvZXP5T5lu3loDXMMuJxuJQUULB8dBZ84Im2aQ
         J50JtYlnQIURqXs7wyZ9eiu8a9WFEkV7IFefBhDHLRWH9eTZKmhk08/P3A2Tp60ZYPzO
         U1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757546824; x=1758151624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z00uyoYaPpbnnyjTQiKQAeAb5AJf67lVttafJphDMJg=;
        b=vGibw4Dd5CppRl10XHybonBbQst5dGcvMSiCYaym0RoxMLA4vIAmwOq3aOqInR5lOl
         n1YOz4+uPN38dxYYVCGSoC6w7bTC72YiVgfNmjQxkggN6EeSA7a4h+iVI0Ks8eYLdePR
         nzQFE2T3dzcwKeNHkyDOkWX5J22XJK21CoFiiURyIWg8M1O3T4iO3e28rI+bsqas11Xf
         965XKee8JmeizF7IWl15AiAXkqSG3aii6PwTmTBgFPGCJ+xkGuR7tQBqn+rKQ+lwe3Xb
         uVaTCXrkMLM/CUyNA2WDQsryCKahu3ViacdJchXndSYPD7K7DRkRa8qrFVyy2Waus2r/
         da3w==
X-Forwarded-Encrypted: i=1; AJvYcCUjetgiZVndCOZqu9klHRyJCEfdX9Ob4mAc26GLU92DQQwHhdswS7GSfGBluChZNerZ7nDkQWVU@vger.kernel.org
X-Gm-Message-State: AOJu0YxYOsieeoDODkux4oUa9fT6W3QN1ISZ5S1unOSLuL9vj7yu7mNS
	iujBZSbOwTW6cguxH+28stVY2Oi91bhpYj++0huZFZ1kZ5SLxdpaKbl5
X-Gm-Gg: ASbGncsy9RLXVyxiD6AU1rEs+saIt2wzqg+GH80g9vpiEteCT/VzX28OlkNNxG+bR5K
	hUMskfU8BygR2Szi42r2gqdOP0d23OjtlV+izI6nHglYwITYVcomciOuVcCCGrVS0FD+gmNbzfd
	4Fe3ueaguvl66tJRB1uHK/XmND6/0CY8wZl67nbjHJUMRKD3sHtoL3Ui9cHcruTogyPn9KnLeEo
	SId4fOYuiacmYrRiAPG9K2XwnEjjGWa7HJPvz65i+rdUV/NCYWvIyimcjv+T/ErvV/ptZBNRrMs
	PoccgIqhQq9668WhkmfzyPankz58Id5OAdzxaoyZgIgqba8QDxuOk/KmeyX/C+DTPnDmi9HSycd
	42d7FrKKwSFroeQt6rR1o+9DsdQ==
X-Google-Smtp-Source: AGHT+IGSdFMet7QzaqJU44i0rtMUiewSHAuR0CqaJljLhbdxhTDCAcDD4IqcG5WSei/TU75yGs6IqA==
X-Received: by 2002:a05:6a00:8c11:b0:775:fab1:18ba with SMTP id d2e1a72fcca58-775fab11ae4mr3595184b3a.26.1757546824265;
        Wed, 10 Sep 2025 16:27:04 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662d2395sm6288491b3a.88.2025.09.10.16.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 16:27:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C7DC941FA3A1; Thu, 11 Sep 2025 06:27:00 +0700 (WIB)
Date: Thu, 11 Sep 2025 06:27:00 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>
Subject: Re: [PATCH 2/2] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
Message-ID: <aMIJRB2-G6zZDZMV@archie.me>
References: <20250910072334.30688-1-bagasdotme@gmail.com>
 <20250910072334.30688-3-bagasdotme@gmail.com>
 <6geggl3iu2hffdop43rtd6yp2ivd26ytfn4xdclurwce6mapal@4ve46y652dbj>
 <875xdqtp7m.fsf@trenco.lwn.net>
 <aMGq5tNNAk5DsJWo@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dLjR6Upv5iA7nyab"
Content-Disposition: inline
In-Reply-To: <aMGq5tNNAk5DsJWo@slm.duckdns.org>


--dLjR6Upv5iA7nyab
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 06:44:22AM -1000, Tejun Heo wrote:
> Hello,
>=20
> On Wed, Sep 10, 2025 at 07:24:45AM -0600, Jonathan Corbet wrote:
> ...
> > I fairly routinely get patches fixing manual TOCs that are not updated
> > to match changes elsewhere.  We have a nice system that can manage the
> > TOC automatically for us, it seems best to me to use it.
> >=20
> > That said, if having the TOC in the plain-text version of the document
> > is deemed to be important, then it needs to be kept and manually
> > maintained.
>=20
> Wouldn't it be better to have some automated script which triggers on
> mismatching TOC so that these get fixed up. I think people (including me)=
 do
> read the plain text version, so it'd be a shame if we lose TOC in the sou=
rce
> file.

In that case, I think we need to standardize these manual toctrees (perhaps
using custom directive?).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--dLjR6Upv5iA7nyab
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMIJQAAKCRD2uYlJVVFO
o46MAP95YJS79Vxocx2+Wr21CjPGuK8+il4Kna7PGwSba9gVPQD8DKHHYG83I+XS
vgMpfToA++8RL+VVaRxBn/3LsveIfAg=
=iQTb
-----END PGP SIGNATURE-----

--dLjR6Upv5iA7nyab--

