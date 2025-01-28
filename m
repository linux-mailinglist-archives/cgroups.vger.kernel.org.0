Return-Path: <cgroups+bounces-6356-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB56A2071D
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 10:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171E7168A1B
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB2E1F76C1;
	Tue, 28 Jan 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wpum4YqR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC51F76B6
	for <cgroups@vger.kernel.org>; Tue, 28 Jan 2025 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738055818; cv=none; b=bFO6vvu+9j0rFq+v4TTAqZyKzJcIn5nV8yAJ5+I2d/IBGilehWAB9zlVRudC8JrcJ9RqxpjqCleIrzGLlPrN80xHfCmUhnaoh52f1OHgxpCB7BS4EVAfKGUpZHdjANb2jgMoXAEFPVmsV8L+ODzS0Jik1rSGo1f2M5AYKFVdaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738055818; c=relaxed/simple;
	bh=hwP9YzLbjeqUhQqHf84hDh2Rku2vfkZT4z1/7mJ77UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLU65M91HQ2VrPaXqXl8SeMHG2i7iBBaeQxqc4K1R7ejhJ3lR313PWTdERtHcbcPwvbCmBAr1yhf7WdsnKvrx7t6BcCtn/+F7F5U7nNXw/m4EQaZRLo3oSJqqNS+Ka4KGscBnyp81l0MO9tPmCK9Z+KhlRo4K3NdvlaelKP/5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wpum4YqR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43621d27adeso35692685e9.2
        for <cgroups@vger.kernel.org>; Tue, 28 Jan 2025 01:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738055814; x=1738660614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VX5ZJlhZysoP40bJCjyiyaJ04EwsYMPXplD4Ebgs3GY=;
        b=Wpum4YqR5qPdakfvnZWqS94qV+Hk2E7KAWwWNiqRJt3A71fKFHHRRuxxwFtDruVC82
         Ipo4x8S5hxC6fwz84eu13PorNOQFkYPKIf5oG1krheye30bH80iMpSbVduzOXCzhqR4X
         B+fa3qscS3KcbK7kdkyx0kn6IsyC/K5bUnaoUBgXOQRH9QOMNjRWRyZYMXE3xbwTT9Sd
         Onq1VVAb/6d+orijszsc5//t19X0xOfQ+JuU1D0S/Aef5sUOd9TcbZ2GbFtZvmOMVA1p
         t81kQ+F9BGKspmmlxZcoJxPff5pLHNKoHPYdQFZpVDRzlumt6xe6bXYKXdHXfOqVUYmF
         qo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738055814; x=1738660614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VX5ZJlhZysoP40bJCjyiyaJ04EwsYMPXplD4Ebgs3GY=;
        b=Lu6YGvh+0rlwxVNz2c5ofoPF4SJjexO7nilSTkQx9rxckaSfQTsAbjWScgVSmZIAMU
         uIKI1Wg/gCznP91hOThPHXCAD5pfrr/6t9nd921PtHhI0LG9jUyVeJe7yJylZviVWBRy
         yOzyh+/GxuPUKE+vBCZjFphABqJLIEIhdea7LleF9pjej+vkhYoZyiGB71yv8yl0/+gL
         rmlSNtANalihl7zfyTcRVMm4IUp6IecE1KowbFTFRfczN8J3qofzbtcB4E4m5lUO+bh5
         y5Tze0BJ9C9gTqMOh7T54WBj+jDorgJ4OZ+nfM2p95rFdpSuy4EpqP075bAPxu3yLbXR
         wIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAQOG7WmhkytNkZLDK023Jyq/oWoi2mF3r2EYsb0ujiqbM8UmE46AA7HAN6ejIO0k8aq8Kz5//@vger.kernel.org
X-Gm-Message-State: AOJu0YyblkwEG8hLk0+9HuNLBvH1ygrYns97/kP/kCZ56BPOAe8PS/7O
	MvG8Sbme4uYm6q0nBq6ZZXmKIngDSXRfW2u6HaiN03uwre1X/Yqz6wOJsx2c/yDj+6SJnFAhcv4
	P
X-Gm-Gg: ASbGnctjj+6dfQdLEDhoQ2AUjkHhjQyDUsRUjMy6YGwg8qOIzmWgRU2c6QfbMkzk2Qx
	v9nya7nwxqGHBWDApi4lzNcsSt1k22jBLiN6XJ3h3S31L21gMZm+kGhfE+RJe0fDFliJCT/N9eQ
	b9I9e87AWsY9umP3hg2j1/UxW78OpYqX2fuo/9xanLRt1ysy96Xz245c73CoYvIOQySOeVtB3oG
	9p/bLBq87HreOQIy7FaEJE/iQuSJ8hOsz0EKcssCaZT63Ttn5FyPz+4ATVFz9saTDX+fVzXE8tn
	Tp4kHVmDlpLfr246FQ==
X-Google-Smtp-Source: AGHT+IF6tnfWH3JAx6zXlQnkGP4HTlO2tbMDCBVW3UBNVZobWqGBzp6phgNemBSGDjzFjKpNWV9tCw==
X-Received: by 2002:a05:600c:35d6:b0:431:5aea:95f with SMTP id 5b1f17b1804b1-438913ed550mr457621265e9.16.1738055813762;
        Tue, 28 Jan 2025 01:16:53 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f367sm161867605e9.7.2025.01.28.01.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 01:16:53 -0800 (PST)
Date: Tue, 28 Jan 2025 10:16:51 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: linux@treblig.org
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/misc: Remove unused misc_cg_res_total_usage
Message-ID: <5tkx5474kjy52pyqixevmujksaj7sdgrmk4fdodmo7j6qbravp@5iscohcabedf>
References: <20250127235214.277512-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qpbb4tfhoreouqal"
Content-Disposition: inline
In-Reply-To: <20250127235214.277512-1-linux@treblig.org>


--qpbb4tfhoreouqal
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/misc: Remove unused misc_cg_res_total_usage
MIME-Version: 1.0

On Mon, Jan 27, 2025 at 11:52:14PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>=20
> misc_cg_res_total_usage() was added in 2021 by
> commit a72232eabdfc ("cgroup: Add misc cgroup controller")
>=20
> but has remained unused.

It can be used by out-of-tree modules in theory.
But the information is more likely used by userspace than internal
consumers as of
  e973dfe929944 ("cgroup/misc: Expose misc.current on cgroup v2 root") v6.5=
-rc1~187^2~1

> Remove it.

I think it's fine to remove it now.

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

Michal

--qpbb4tfhoreouqal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ5igdQAKCRAt3Wney77B
SZKbAQDJ0YzoBqYdbhS+TCkEGUrxIiHTyWBCPaoxMUO8Hs5bvQEA7WPSJQ9JSRoU
U15hH2ZME3++dX9osejNjWsdZZcnCAw=
=G4xR
-----END PGP SIGNATURE-----

--qpbb4tfhoreouqal--

