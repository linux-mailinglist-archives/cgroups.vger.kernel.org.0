Return-Path: <cgroups+bounces-6022-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9289D9FFB4C
	for <lists+cgroups@lfdr.de>; Thu,  2 Jan 2025 17:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A7F162845
	for <lists+cgroups@lfdr.de>; Thu,  2 Jan 2025 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3202043173;
	Thu,  2 Jan 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ehSjfcMp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148E2114
	for <cgroups@vger.kernel.org>; Thu,  2 Jan 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735833781; cv=none; b=bDzlSnfzbGkHq37BVmJiV92PxPlAY3S4AEWxLBakF1Y/o3rpC6lM8xXpTLbnP4+cwG6NZD1xqspHk8sfG6w4r7aJf2rpgnOKNhMdRQZgKTINI1bdvPRLKJCymShyZYbENWyUC5HDyGEk0zNI6vds1jadEqXI235XPk1Qz2WMWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735833781; c=relaxed/simple;
	bh=/RW7prpTHN7WDx36+D46lC+dmB6ORfznyq0Y92CxYPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7hrj9qi/rX2yBg/DmMZjHgn9NJrjF9b5yhp8f0Df7b7r3Ln7zLwm/93ObfClZ9R6kpUisp4xPgW+yh3uuF9ctRMyGFNj96Nb8f1OoMVTSva92VarpPHsUZa5vZQVDCkVDLwp7bFP11bbP3mCWNCH/j3tH4WnH2jMvXDgJ/JulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ehSjfcMp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436249df846so79632985e9.3
        for <cgroups@vger.kernel.org>; Thu, 02 Jan 2025 08:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735833777; x=1736438577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUjSUQGZeWN1HqMrYWxMArVEBVbbHAmSHPeKCa7tUTE=;
        b=ehSjfcMpI7NLgwiPPE2V+ohnRfQ20CqkjT0Sb5DyDxQb+aymyhFq0//JuVZS4PaIj/
         xTQLgOPv4S8NpN/umx5Hou2g5/W6Fy9+1I3dVNPuaanz0p/h86IUOEd/MfIzLwdRcEJp
         fbG/27d+dKcb2HISrJOtijPiXSaFIK6ghxw4Ezxk6V4qRmqoazrWvdjSdQqfQSVIf63s
         RFXNrvzNGW2jbUKND9+oAW4FipIJ6qU21cSE4zec6tZSuHHosQgFhMN/StOxMlPPpewb
         d7f9VfYsInWmsBVZhWljyGA4Ap9Bfen7tXyLFLC4BjTNAtkMQBy9rtd9vt/XiRD2vgG5
         xugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735833777; x=1736438577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUjSUQGZeWN1HqMrYWxMArVEBVbbHAmSHPeKCa7tUTE=;
        b=PZ4DrDH+gR8/Up91By6QWmzJEIrzzCAf+9SrfjklPyKs8R56H93Cus+C3gYDJ6Aecz
         PdJNuxEMhYL17vvsBMTNNNuUrqJ/XrG+hKVYfXbJ9CakQRfDnrTTE+Acn3CWfzithUHG
         LtfNLUnXnR5Abbb2tABMyGFkwb/E4aE5ADc6+5fmHHBtl+IWMBrbs1eSbGfaWsJeYCTg
         IgYKHHBntXQMBouQ/gT9ciregY7gj5iTdYr+5IYD9StaYdtmtLqe4SkV+TKVeNcYpXcU
         vlPJqzVCQBgzGsjaAluSS1Qet7ZK01Qkroa20qZiOWTme9QRbvevaBouu8vkCyCnB90Z
         b3hw==
X-Forwarded-Encrypted: i=1; AJvYcCWxaaAxysHtY0FF92TgdvA3Mt7WpumYwkQo9fs4vhw59En3B+hf/yR6KRtTUH1ZBfki903OMfl/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7sH5DfWAhFz26+/Xf15hJaJrl0s0lqLUOcyicR9oHmjvR2Zyp
	kln1Tp6MBVf7jJhakrdd6dgS/h2dfPtlLq6xnXClq8RWJTmXV//CZ2nyiyb/+q0HXF0LSot9kkr
	s
X-Gm-Gg: ASbGncu91ee87N7ArokxmkVdTo1UVwgkSVyX3CCNXgUmAzds7IpDHpxFCFo0wg45Ren
	eC/E1XJMpLkhLQ2GanW0W+SAG55kKN5yJe4RL8xnhuvaiGe8GVREG/Obwvnwz+oRRvs8BrNP+x2
	XaUMjBmYSJEHOLegZMJTB3nxT0KI9jEOnWofaawcgJra4xbwRJhVRolSuVDw0RzBP5HSmlc/ic0
	Ux3fgWk1zB33W4Dbtw+oWt7r+qAPP0mGnbbXmlWPPGeI4/nUyyqSHmzNio=
X-Google-Smtp-Source: AGHT+IHf5gbQBJp/pMHNxyXZQliw8SbNw/rx4/zChE5cpleeGKug3XnJka5pmnvjS6uNnfkCY5WVdg==
X-Received: by 2002:a05:6000:2a7:b0:385:ef2f:9282 with SMTP id ffacd0b85a97d-38a221f321dmr43992612f8f.5.1735833777159;
        Thu, 02 Jan 2025 08:02:57 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219578sm461403955e9.20.2025.01.02.08.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 08:02:56 -0800 (PST)
Date: Thu, 2 Jan 2025 17:02:54 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, longman@redhat.com, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v1] cgroup/cpuset: remove kernfs active break
Message-ID: <6zxqs3ms52uvgsyryubna64xy5a6zxogssomsgiyhzishwmfbd@lylwjd6cdkli>
References: <20241220013106.3603227-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q5pfjqkiaj7cdu2h"
Content-Disposition: inline
In-Reply-To: <20241220013106.3603227-1-chenridong@huaweicloud.com>


--q5pfjqkiaj7cdu2h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] cgroup/cpuset: remove kernfs active break
MIME-Version: 1.0

On Fri, Dec 20, 2024 at 01:31:06AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> RIP: 0010:kernfs_should_drain_open_files+0x1a1/0x1b0

I assume it's this
	WARN_ON_ONCE(atomic_read(&kn->active) !=3D KN_DEACTIVATED_BIAS);

> It can be explained by:
> rmdir 				echo 1 > cpuset.cpus
> 				kernfs_fop_write_iter // active=3D0
> cgroup_rm_file
> kernfs_remove_by_name_ns	kernfs_get_active // active=3D1
> __kernfs_remove					  // active=3D0x80000002
> kernfs_drain			cpuset_write_resmask
> wait_event
> //waiting (active =3D=3D 0x80000001)
> 				kernfs_break_active_protection
> 				// active =3D 0x80000001
> // continue
> 				kernfs_unbreak_active_protection
> 				// active =3D 0x80000002
> ...
> kernfs_should_drain_open_files
> // warning occurs
> 				kernfs_put_active

Thanks for this breakdown.

> To avoid deadlock. the commit 76bb5ab8f6e3 ("cpuset:
> break kernfs active protection in cpuset_write_resmask()") added
> 'kernfs_break_active_protection' in the cpuset_write_resmask. This could
> lead to this warning.

The deadlock cycle included cpuset_hotplug_work and since that was
removed in the said commit, there shouldn't be same deadlock possible.

Ridong, have you run your patch with CONFIG_LOCKDEP to check that
eventuality?

> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
> processing synchronous"), the cpuset_write_resmask no longer needs to
> wait the hotplug to finish, which means that cpuset_write_resmask won't
> grab the cgroup_mutex. So the deadlock doesn't exist anymore. Therefore,
> remove kernfs_break_active_protection operation in the
> 'cpuset_write_resmask'
>=20
> Fixes: 76bb5ab8f6e3 ("cpuset: break kernfs active protection in cpuset_wr=
ite_resmask()")

This commit alone isn't sufficient to cause the warning you observed,
right?

As I read kernfs_break_active_protection() comment, I don't see cpuset
code violating its conditions:
a) it's broken/unbroken from withing a kernfs file operation handler,
b) it pins the needed struct cpuset independently of kernfs_node (it's
   ok to be removed)

All in all -- I think the particular break/unbreak pair is unncecessary
nowadays and the warning implemented with hiding/showing kernfs files
didn't take temporary breakage into account (only based on quick
searching and vague memories).

Thanks,
Michal

--q5pfjqkiaj7cdu2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ3a4rAAKCRAt3Wney77B
SfQXAQDQ2ZQJNtjSLxUqSR0QEdFcS0VSrh2iZLKCe0WZ3leHUgEAqQK7ZXJx72+u
S10JZHolaU4fWxvAyMfezHDwOvHSJwY=
=et6F
-----END PGP SIGNATURE-----

--q5pfjqkiaj7cdu2h--

