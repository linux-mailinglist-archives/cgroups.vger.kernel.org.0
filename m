Return-Path: <cgroups+bounces-8746-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F115FB088D1
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 11:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 617977A4791
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68BF288CA1;
	Thu, 17 Jul 2025 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MGizRLMW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25163288CA3
	for <cgroups@vger.kernel.org>; Thu, 17 Jul 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743003; cv=none; b=fHF8xEECCdS4Q4wrRSpUVeHtWQF+z5EaaEuq3XhKFLh6i7i9hbQw7YxiJtpH6a6DKGx0sSqvb9TGyVwlA0f0q/zOzh5/tT0iJsQdJVDwze129k3G3oz4IHqbPrO6zpNaetYgj/fAIqbLeUg+oOkodmtuzSEz//DqPTRN2Trbuoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743003; c=relaxed/simple;
	bh=Z5nzWSuaRPisfayNMOK/rRJBdS6Apn8ClY5PeebPILc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKViHFzv4rrxj81z8hsqP3FcSoaPzpCjQdtWmQxeggaT/2SNKL3WGDmD3CpScAAGH3iIzoicvpv5XoYCriTWinZIA08N7YSAfQjqBJ7c6mVPR0ud3R6wIvP/8KSfahUc139LrhqnA1oOkQVD7hTEe9i6Vrvr6dMGZ492yMGJ9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MGizRLMW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so1075726a12.1
        for <cgroups@vger.kernel.org>; Thu, 17 Jul 2025 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752742999; x=1753347799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtJBS2lEjHHaRhpVxxSRBXYFYmBr3Ltbr/mf09JOLRE=;
        b=MGizRLMWaee8kvvVF4Jz8FxTVbJFoksfTZI3e+XPGDcnNBj/UyrEK7EVCMHSO1zYyW
         a5FfcidMwNR0LqJgm0HtL3d4YAx6Ymg2P8CUYZmq2OXeseeRB1KP/OjHJwYJISIAagiN
         MAVS/1DJsRrWVqRzhcy0gwwMUBJ/Ocu57lEXNoYIWilV8Ekl3pP0DkICDEAoyuxMhfQK
         Jdk1WbXukXZwB1U1GEt7+PIMxRokucH7NQYurUUyWFFthJO+BV642sbnyOIJz09dDqub
         AIunaqN673OiUES447CHDjKDszRAx+NbcVeH4XJLeI1qau8B+FlDxXwVLoKyUfsMXSoO
         6NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752742999; x=1753347799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtJBS2lEjHHaRhpVxxSRBXYFYmBr3Ltbr/mf09JOLRE=;
        b=DYrO74szKGIYgz3TXOxFE5GLpkc+cGu5ihE0sq375gwe6ur4SXzbZPH+65qVdGi1OJ
         DEWNxrwHM94zOY7hxBzUqVDivoI5nJiX3f8JayRAnLfIvJxLsFPv0G1gjaRfqmvj/PB/
         wgXwo1l4quUq8KExxq3ac22CiBFolKNpwcyzES8n5wJYEfL5NIuh4rR4ChgPl3y96kGu
         OW5QoeHsAzbSCDm9PZdhsCqaqJ330gynewagaVM5ziBA9v267VXBiCGsUqTITpYkWtvb
         YB+kBUj6bu3R+SgkXTWchLda9RliBxSEd1FQyALbBU5tF8SYdvL4kOmaZ90Ye9AXMOV+
         zHIA==
X-Forwarded-Encrypted: i=1; AJvYcCWLJN3kk5jWV+Z9dDvRQZOKMXfI+UEkdxHDrEOfE29OPq7xsF/dGB3Yjp0qwvTgoW5kpdurOxXS@vger.kernel.org
X-Gm-Message-State: AOJu0YypwjyWKl5jT/g6+YDVb1QvbuZRAFInk21sF6dj3BnYbL6C+BmY
	vG22xoYFUornvELBD64qMKMM8Omfvo0Twitx7+Rw/Rbox8u8Qvw7r7tLqBIlD4pZW16c5PUcScI
	6g0z9
X-Gm-Gg: ASbGncs/KNz7+Yi4KZ28ZKgbpy6iqReB83dtDsVEpT39lPvmubyHqXApI0rdi2yBqU0
	bmGkRuPoCICFYJQfIH51cr2h7o6s22GbVPOhpAwDM06fANglgUOd3r7AFBD8zkBzYsQVpd1tztS
	pJl44PFwJbipH5wTqxIeMBAxiIlbnqsNjzUQxyO9PV3DOUUqvaejUW5KTO8X9NvOZyQQotaVpoO
	ho+uLQbyjnhHZhv1qhPh0R1iwYcQbeCrk10EnzLoUozYCpjwE1QurTkb0Ph6ABYM2Fa6Fdy/cXu
	QTgZDyj/MWy6lG/fVgXRk6n6RYIRivpaUXcaLsJS/CK7H89xKSVzaxHDREnhZ6Wa305JWXGuTs2
	OHn+i5Zj6upVv8Wy8vOp7jJSUZmAdver/IDKidanF1A==
X-Google-Smtp-Source: AGHT+IHtm4KCrQuR9JbK9MgY5VxWRCkv31xXdyq+Qhq5kWG3gk6gKkGV+hb2neJpu+S9WLS12s2D7w==
X-Received: by 2002:a17:907:a588:b0:ae1:f1e0:8730 with SMTP id a640c23a62f3a-ae9ce1c2d25mr665972866b.57.1752742999384;
        Thu, 17 Jul 2025 02:03:19 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae9cabc0b6dsm297466266b.111.2025.07.17.02.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:03:18 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:03:17 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Xuancong Wang <xuancong84@gmail.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, cgroups@vger.kernel.org
Subject: Re: kernel defect causing "freezing user space tasks failed after 20
 seconds" upon deep sleep
Message-ID: <3bcpr5mq4fnlg2ezwzion5mmlsqaloovuqweky7bwma2tpuarq@dovpsotdxi7s>
References: <CA+prNOqAG31+AfgmchEMbeA=JpegKM946MZPm4TG0hEXDDRUag@mail.gmail.com>
 <b9a3d8da-9fd8-4ffe-b01e-4b3ecef5e7a6@huaweicloud.com>
 <CA+prNOqPXJUHV4fM9NR991=zySXhLhbYFjCSDevq7Yz4opjf0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="icijpnvywbxpultt"
Content-Disposition: inline
In-Reply-To: <CA+prNOqPXJUHV4fM9NR991=zySXhLhbYFjCSDevq7Yz4opjf0A@mail.gmail.com>


--icijpnvywbxpultt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: kernel defect causing "freezing user space tasks failed after 20
 seconds" upon deep sleep
MIME-Version: 1.0

Hello.

On Mon, Jul 14, 2025 at 12:10:03PM +0800, Xuancong Wang <xuancong84@gmail.com> wrote:
> Linux wxc-moht-aero 6.8.0-60-generic #63~22.04.1-Ubuntu SMP
> PREEMPT_DYNAMIC Tue Apr 22 19:00:15 UTC 2 x86_64 x86_64 x86_64
> GNU/Linux
> ~$ lsb_release -a
> No LSB modules are available.
> Distributor ID:    Ubuntu
> Description:    Ubuntu 22.04.5 LTS
> Release:    22.04
> Codename:    jammy

So this Ubuntu uses systemd version v249 and user session (cgroup)
freezing was introduced only in 256.
Xuguang, with this piece of information, I'd say your bug is not related
to cgroups (which the [1] is originally about).

Do you have full message "Freezing user space processes failed after"
including number and list of refusing processes? (If cgroup freezing
isn't involved, this would IMO be some generic freezer/FS/FUSE
deadlock.)

Thanks,
Michal

[1] https://github.com/systemd/systemd/issues/37590

--icijpnvywbxpultt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaHi8UwAKCRB+PQLnlNv4
CKu1AQDg5sKtwsuP3ov+wSgcD+C+U46lmoX3RUt9nUgB5rsAFQEA4VceMkerprAV
l/+Ov0HcOYPMPhA/mS39qXuBFq/W6wA=
=v92i
-----END PGP SIGNATURE-----

--icijpnvywbxpultt--

