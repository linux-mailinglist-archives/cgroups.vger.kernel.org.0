Return-Path: <cgroups+bounces-2642-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AFF8ABEBA
	for <lists+cgroups@lfdr.de>; Sun, 21 Apr 2024 09:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE528B20B66
	for <lists+cgroups@lfdr.de>; Sun, 21 Apr 2024 07:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83209D529;
	Sun, 21 Apr 2024 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJZPEz0O"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C93232;
	Sun, 21 Apr 2024 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713683910; cv=none; b=dfMAlWJJugfZJBKIrnL0kfmCdCR+Ru0z8TrtAH7+Msjb8gVcRuN6ok0h6rmVCfdGlsjz637ZTpVmRIPBgv7d+c9wf6gfN/u3T1kHqkXUIo2Tyj5BvOXiQ0xhntlFdYRO1OVh0VQyisSLVi76kSOdGAzS7Yx0X7C9SzJpiWcV5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713683910; c=relaxed/simple;
	bh=CBgucA0S133Z5gmCgirpyuah29eI+7G7hML2D/BTkQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXGGkcBTMfy+oc8oVG5xWpj6zzsjjuPcdiqeKZx/O7/39Z/Dcke06Q6Bw+igAlYMztKbtZrc/7cLkv9dUlI/zt3HF5YM+NoHYZvDOHH0o+7sbD4cTv/le3R/8I7lo+/Z2nfxCFahWS1O/UUnClCVuUozbdpMOi8IyD40DcHnoIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJZPEz0O; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso1618486b3a.1;
        Sun, 21 Apr 2024 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713683908; x=1714288708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBgucA0S133Z5gmCgirpyuah29eI+7G7hML2D/BTkQ4=;
        b=SJZPEz0Oz1XdMzMy6iS9EwVQiuj4qvmde7J/5GpeMF6faJCZaj3ibKQOO/F2TRXpFL
         XKzlUkkFeTA0fx+IBRb8jI/Kf6fmzJJK/0UdQwNKmLSBMhe4vpnd+JlVjAJ5tpZcYW4q
         jcLqc2J48svJNJXlxM+/hbJXNsgVB+phN/QwcDCRdQmlOYYb53ua/Ex6sHUljm30oTsi
         Cj38rHP9z1cTBSCMuQ1Sz1m2MIk0J2pbmPNE05Qu08Opz2SHdREBTPPJn99YPEbEhfho
         gJv0VGmIR/WqJ3gXWDYrKwBoE0eb7OZCA1492/ze5FC+PcZqON9FN9oNsQzKPg4gogKf
         qlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713683908; x=1714288708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBgucA0S133Z5gmCgirpyuah29eI+7G7hML2D/BTkQ4=;
        b=woW0HG69MG9YW3BuzSkdsaJT2HZmRzU0P5Asl1/xJr2jv3IiXWWfNB5lT5HW8ZEkxq
         TFtIbjadCu99ZHHnn/bAxE3FVQJAEYcX9jAiKhxJTPxXZzSPN3a7Ga+cHn+tIOF1ahVS
         /uEFkjUXO3UrxIA9sgD1YX5Gpf7y057KdjRCFvjditJoJ8HeZs53SSHJXkV11qOS5KbT
         tLI082lCOQPaMVO0E7/oMVEpRWMTyRERnTUz4VK3FmyuNHvbH9CK7BzCKOsXS/FukZDe
         gdzrgIw3f5/hyaDVrPS3CelyESQxXn/dSJ/UrLOpr7yO7VMrx0lXCxf+m/aSy6Me7EB/
         pk8w==
X-Forwarded-Encrypted: i=1; AJvYcCX3FekLcUhUIQitGNZ0A9iAvWSNCHOa0Tt83SkFPRFz+lB7atI+n8ry2vAodnNly6Ls8fw1UQ3AnyTjsfQBGgaWD25qnBnOK+7iMeFAADt28ToWP9Qx6c8vt9brL9jXGW3Z3ReOKibApSkGUOvpKFpKfJFUMsK+Yw1oO5MhxIp92w==
X-Gm-Message-State: AOJu0Yz5BRWQjQUArSa/cOW7cytTbC09Jkow0WCwOmflWgrSFkORK7Lz
	vEG+6AST4b4Mqv0CTGuWlNSG+HFT0HbreuUcsK3ws273fEd8dfTt
X-Google-Smtp-Source: AGHT+IEaASRVGHPgzkdeZOLFI6GTrwiHLWZSYvOIfTuHOycbJtI2qEkk5kB5/B5nmVmEc9uRThWJsw==
X-Received: by 2002:a05:6a20:72a2:b0:1a9:11e5:2915 with SMTP id o34-20020a056a2072a200b001a911e52915mr9764345pzk.27.1713683908163;
        Sun, 21 Apr 2024 00:18:28 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id c7-20020aa78e07000000b006ed048a7323sm5762102pfr.86.2024.04.21.00.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 00:18:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 451161849081A; Sun, 21 Apr 2024 14:18:25 +0700 (WIB)
Date: Sun, 21 Apr 2024 14:18:24 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Haitao Huang <haitao.huang@linux.intel.com>, jarkko@kernel.org,
	dave.hansen@linux.intel.com, kai.huang@intel.com, tj@kernel.org,
	mkoutny@suse.com, linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	sohil.mehta@intel.com, tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
	zhanb@microsoft.com, anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com, yangjie@microsoft.com,
	chrisyan@microsoft.com, Mao Zhu <zhumao001@208suo.com>,
	Ran Sun <sunran001@208suo.com>, Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>, Josh Don <joshdon@google.com>,
	YouHong Li <liyouhong@kylinos.cn>
Subject: Re: [PATCH v12 13/14] Docs/x86/sgx: Add description for cgroup
 support
Message-ID: <ZiS9wBvfU3VH5tCI@archie.me>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-14-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ViV3SWxb5xsN/it"
Content-Disposition: inline
In-Reply-To: <20240416032011.58578-14-haitao.huang@linux.intel.com>


--5ViV3SWxb5xsN/it
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 08:20:10PM -0700, Haitao Huang wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>=20
> Add initial documentation of how to regulate the distribution of
> SGX Enclave Page Cache (EPC) memory via the Miscellaneous cgroup
> controller.
>=20

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--5ViV3SWxb5xsN/it
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZiS9vQAKCRD2uYlJVVFO
oyuaAPwOYYTsCVsQVixfmg6tl/XnRifeSpkBSqxL8IPhmEoF4gD8CjyJFVn7ZYCA
TQBF7UTW7VlL6ie4XWBl3MfKntKw6ww=
=VYSs
-----END PGP SIGNATURE-----

--5ViV3SWxb5xsN/it--

