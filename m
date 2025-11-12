Return-Path: <cgroups+bounces-11866-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB95C52980
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 15:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C344134BE43
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983D4246BA7;
	Wed, 12 Nov 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ARbnSoR1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC51ADC83
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956135; cv=none; b=BWd1PA9/5Lo3lSx44jYqRE8XQsqP+b1Odv/NCkyToYtMi3OUORWYFBV0kFcdkwIVpx/M4Y3exDKl/EKdKh/pA9jr/qja1nUVCG0pTMui5yQuNvPUXW2E7G620oKYc+DuODTeQiT+Wcykwq3pG1cMl/uym+rqf5QzlwaQY4/WT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956135; c=relaxed/simple;
	bh=hhaiEJCK8eTAN1k0/yDDRPi3ZY6cafDGrtKd0G+aZE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYzMc1E73A5Bp9maSx5eHCFTUi1YCK9zF6jkCX+8MWNvGI1AAGnGPnPQm76tDqI5pi+ryZcZghA8EZqtAKL2+HyAdmKKqUfTbqeyayfLh+XL4PCSCU/S9y1G291afQtzgX/WeN7Lnasa0IZnDeZ0eR1iA/qNiV7q0Htg4fDMdbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ARbnSoR1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47789cd2083so3907775e9.2
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 06:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762956132; x=1763560932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WOeUMdFLrARgOFLb1t2AnuzeStuy1JBycaUsDP/wyV8=;
        b=ARbnSoR1Nr+HjwG9Lv8sC18gr+fpb8MIBNs7/go6rcbQw1/ivs01jtIGIyAtZjsE4X
         pvu6PowI+oo1rKE8UdTg4C47+72oQIGo6GTyaWbDNLcu1KAMXvOx7u9PXXsh4jzE+bOG
         Rf+swwgpHyCQrL4odfcSk1H8GIaVIlY0JSd49O045T1Gh4fPds4G1Sii4e29r+IOqc5h
         f2f3btewh+P+BX4hwJMoFPeQjI0RHsdyhokEwyF9UaU1pXJGa4MAuCJQRxlUvZyqz5wT
         X3hf8Z6pXdtL73NK6nKFlIJYlnuqUPMsWIODWfOO20kyIM2lfrCn8rujw9DSqGSowPIe
         nGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956132; x=1763560932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOeUMdFLrARgOFLb1t2AnuzeStuy1JBycaUsDP/wyV8=;
        b=MW1Ng4lvgoNs5DOnew69ky9x15/m9W9rv09sWHr4ultz7SeHjyDzAkgNa34chHYi1I
         knVhlyKC/C+Czs9WcdcI1yANYtUqhPN8m3nSPN+Y/CGKwy7Qxy7R6Yr4J5Ci5XQhO5yu
         xl22fSD/idOTAQDmFVOqfYuSqwaIXdMmdoygRpY9ae5BkrcOlE0WNTvT5W+eaQKstRd+
         kkJ0C2wJMJyYp/ygWhg3Pk4/kAzUEgnmpVB7scTvIt9zwhs01cxNfQOtyc3aaTVNRw+t
         RnpgOowHjEdB+hjTuT875U1TULwBTQ4AXvRoE53VzfLmycBpUhNwMCEfWEHQ88GTWzP1
         5twA==
X-Forwarded-Encrypted: i=1; AJvYcCVPRr41wTLwycu5iwoLG3lBpYFvAmIDh6nsfPJzmOXFjZJIUfczCxsiWL096E5CWZymSOK5Z/Bh@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5NpjApc8f0cwdVp5VA9yaY+eujDHFUWtX396bGun/wTSnpoH
	JieaKNPtWf+VQt8djf5p0AGbVv7nvPw9GUdkv/XF94S8/sUGOfKp/WNw/KmpZCMGO3U=
X-Gm-Gg: ASbGncsG2r0geb1U42jSZUpkrNilsmrNpIsZ/o8Ui3uyPC9TvfbbugvjtSyl8pZBD8C
	YSXuchEpHE+Qm+K3y0ORLNx1/nynXdYuclX9teHHVh4+oBrEaROvB9Yf+W1qo4w6FGWBPkSRLda
	rm8YuT5t+k6NiEl3+DXG6mSXw4EojtRD3iOysCVfBxMJX6fbKIJ1/ZuFvg26KJ7R3FtZYY/sbk5
	OFUDS8AdFFdPyVXdGJ6qiMVvhgF/ZeWNaBTORM5vTyWS6ibA4V+tzogjTb55vNY0HJlaJtjpBqD
	Rf2AWmkjCRPJWvXZYXn/jgQ3g/81gao56j5cylsha3YkWoXDImU0bbG3ou7+bKuLpckLui5WIJ+
	SE48q7Z2Eb0cmvzIkxuCM0/+Z4B5CxyBn0KgzfumiC8oMCF/812PEm4MNnFzypw70j2aHpyerQW
	+yhnh+oJVIB2IExAUc8ryK
X-Google-Smtp-Source: AGHT+IHr7c4ZnrhLQZ/bB6CXbwoEkep3GrU2Tc3liHlu3o2VJH0vMGReTx6XLb+PoXt92HxE5gNWUw==
X-Received: by 2002:a05:600c:3114:b0:477:1bb6:17e5 with SMTP id 5b1f17b1804b1-477871c4b45mr28509875e9.30.1762956130143;
        Wed, 12 Nov 2025 06:02:10 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e85a94sm37157975e9.13.2025.11.12.06.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:02:09 -0800 (PST)
Date: Wed, 12 Nov 2025 15:02:08 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Waiman Long <llong@redhat.com>, 
	Leon Huang Fu <leon.huangfu@shopee.com>, linux-mm@kvack.org, tj@kernel.org, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	akpm@linux-foundation.org, joel.granados@kernel.org, jack@suse.cz, laoar.shao@gmail.com, 
	mclapinski@google.com, kyle.meyer@hpe.com, corbet@lwn.net, lance.yang@linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <ew7opa4vqangjafwfthroe7d37ovvvmlekzc6clbqia7od4v6y@344cuiqiduc2>
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
 <9a9a2ede-af6e-413a-97a0-800993072b22@redhat.com>
 <aROS7yxDU6qFAWzp@tiehlicka>
 <061cdd9e-a70b-4d45-909a-6d50f4da8ef3@redhat.com>
 <aROkMU-OFAmYPBgo@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jtcwccftag6wk3eh"
Content-Disposition: inline
In-Reply-To: <aROkMU-OFAmYPBgo@tiehlicka>


--jtcwccftag6wk3eh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
MIME-Version: 1.0

On Tue, Nov 11, 2025 at 10:01:37PM +0100, Michal Hocko <mhocko@suse.com> wr=
ote:
> How does that differ from writing a limit that would cause a constant
> memory reclaim from a worklad that you craft and cause a constant CPU
> activity and even worse lock contention?
>=20
> I guess the answer is that you do not let untrusted entities to create
> cgroup hierarchies and allow to modify or generally have a write access
> to control files. Or am I missing something?

This used to apply in cgroup v1 but the v2 controller APIs are meant to
be available to anyone (e.g. rootless containers).

So yes, if it turns out that the isolation may be substantially bypassed
by reclaim, I think it should be solved by some rework.

The memory.stat_refresh is different because it doesn't exist yet so its
impact on isolation needn't be even potentially solved :-p (not more
than memory.stat).

---

That's also why memory.stat_refresh is different from one global
vm/stat_refresh (easily constrained to root's monitoring tools).
And despite this precedent, I don't like the approach of two independent
invocations (write(2)+read(2)) when the intention [1] is to obtain
precise data (at least) at the time of the read(2).

Cheers,
Michal

[1] I guess. I'd still wait for what the actual usefulness besides
    fixing LTP here is.


--jtcwccftag6wk3eh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRSTXRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgYtAD/c+S8KG22icAY+D5u/Hw+
IaaTSOoxlnotS8mWtF9Q37kA/Rx/AJ5T2cm0Z5vyBpqCrcQhSgksn4AhdUXvWv8t
O8AL
=ff7K
-----END PGP SIGNATURE-----

--jtcwccftag6wk3eh--

