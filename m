Return-Path: <cgroups+bounces-8932-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA04B15AC4
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 10:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB0C87A7341
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 08:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394162698A2;
	Wed, 30 Jul 2025 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gG9bbBOn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C50264638
	for <cgroups@vger.kernel.org>; Wed, 30 Jul 2025 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864620; cv=none; b=fFuZC/sXM32QRPibMze/F/ZNWO7tLzKjz27WgRIpR1uUYnkAxW+0hhVzktSI0QFdDgbd4KBJQfdVbIpI0yi6rwAxTb+wX6TehQisQS/XtIyjeB4djd4yzJP6+08h5iZ2GvgUwEYvucHO8PKs4lhNPlbSRn09oWYIuwlqEVZEB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864620; c=relaxed/simple;
	bh=OpYddu2AvhEbaNSY2WtUA+cMA8xkL+q9yIBHo3KOW+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDz37tU/7aooCuywxn/dpfi9olxx+DupwjfkE6mGykf7nut1hkAd+ooulBOnMwGeeLW/a1BH1jA393a76D0x0TJQpGZhgA4yKJIAMIy+XXzPrJfeDdXqbOxRWCv36rzzpkOxj9vfGdBUBAK98Pr+WYbVdy1k96mhUASGThek1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gG9bbBOn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a588da60dfso3176074f8f.1
        for <cgroups@vger.kernel.org>; Wed, 30 Jul 2025 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753864615; x=1754469415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OpYddu2AvhEbaNSY2WtUA+cMA8xkL+q9yIBHo3KOW+w=;
        b=gG9bbBOnvBLc+luXtgeD+Uo5PRziSzD4bxS3On7MQqQz7H/mu9g5d4PZr00Kdf70QH
         kojgteu6PJexNfmWCjBfBw8SqZape3AEVh6izNsShhsy9YKhI32OKgRBzAMZQeysJBYF
         TJizJtN8TVeWtLZaG9GdRDMWDKkFhtd7DwQe8wJpChbox9ZjDlmbZJ4J9Grf45IbcYgC
         V6XExpCU9jTq1e/ZER5nCdWHrYAWv4Z43DYEFUkLVnlz1DbZPG7Mt5h/GrBThBWFzfN/
         1WBF3HHK2xDDCC4h9W3yW1AA4p9BIpi+nZsqP5AfjhHkXKE6dRtockt+p7c+dLiSLxL7
         GkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864615; x=1754469415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpYddu2AvhEbaNSY2WtUA+cMA8xkL+q9yIBHo3KOW+w=;
        b=qZDx4yzeVo3vhIyaoszlhTL4BmSIN9bessfK+cyQ8YtW9MGppvju69uAlWr64Ut9fc
         Z588rpFg2G/Wh11Tysq8gjIKSG4Ofv/6ctfP3eC+/OMNRDKWlUxUL9n5qHOED0F54LJo
         S2ujT3cvw65fCdedqZLzSxVkTw77c7NKgq4Zi2PfsYTpSbCiSAumds7ZU4sD/uijwXlP
         mPc1IHfAqSBe+nP/w4pGjq1e78GEh9PUNiih5gSS9OSHsD+uBhsC2m1Mq0K4sM2dAf3M
         I9nlfR4Z4Cw9WM+QH0PaB3ypM7TQd+Ok3MIAe+iyqtHCXo1vACs9219sVitZW5EJy1JO
         9mjA==
X-Forwarded-Encrypted: i=1; AJvYcCUTZm0XmZ38z4CROEiOZRAAnfMHQlNxBgK20whm3558mjvdGls3jKppyhNcSCbKbJ9Xn6Q39d68@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+Lx2OOc+wvf9gTs+oaJ3Qu2eboRSkpkmT5wedjDRdMQch27t
	pXm4xJGxGIrLMhVWX+KZT1rY1GrWgpwtm/NNDOnktTdSkBQOTcFFfKqiBwi8EeYs2UP+ccKOdcq
	O3DnU
X-Gm-Gg: ASbGncscelcnH4PzDudao28jMfs28YHhYz8FtSlNe/D3GPOhkvuiskqlWdpekyhDc4J
	3fFzwIo+UT9kBBVXlPAi2WBkU3HkTV+J9PG0qvEFOOC1TiCZ6qYJOEGbvv5UAWx/9ecpuE6EVsd
	0tymwLcJLuAx5PRUoVBYtnlFAJXb+QAW1v9i+vuzzFB54BRWdD+zpbnCXmbBkeb/knZPCDpfGV1
	oKsVNsgiIWECBm0G0ZhSmQUTW8EQx7rS/rnR5XPnv0pX+TBm3+Jd9/vWD7xIHVTKLsTn1i1ml3P
	e4RjiRTr9TOg1YVaOpj2nJEcaB4Pm4Vsy12eI8gL7jXROQDKMcUfd9UKX10pZ1Ey+6uoT4kBW85
	3ozRM/o2kEah5KrYBGYhiJ7pq/RnYyTSADXQRA5JFhg==
X-Google-Smtp-Source: AGHT+IHVOUFrFhz5+cYlGN5+6SItNnpwfmXd02Jwn4fXVm8o+QOu6m2z+ScY0HMxfZpikiUFnrJwxA==
X-Received: by 2002:a05:6000:3101:b0:3a4:dfc2:bb60 with SMTP id ffacd0b85a97d-3b794fd3f6cmr1878193f8f.26.1753864614945;
        Wed, 30 Jul 2025 01:36:54 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eb284fsm15346538f8f.12.2025.07.30.01.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:36:54 -0700 (PDT)
Date: Wed, 30 Jul 2025 10:36:52 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: Simplify cgroup_disable loop given limited count
Message-ID: <uoktojnix3n27c2xfszt4ktp4hwb5gxhwat3bgor3ltbwl653x@hp7xnirufeun>
References: <20250730081015.910435-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cnmpivdyfnfqfyof"
Content-Disposition: inline
In-Reply-To: <20250730081015.910435-1-zhen.ni@easystack.cn>


--cnmpivdyfnfqfyof
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup: Simplify cgroup_disable loop given limited count
MIME-Version: 1.0

On Wed, Jul 30, 2025 at 04:10:15PM +0800, Zhen Ni <zhen.ni@easystack.cn> wrote:
> This patch refactors the cgroup_disable loop in cgroup_disable() to
> leverage the fact that OPT_FEATURE_COUNT can only be 0 or 1, making
> the loop structure unnecessary complex.

(The complexity measure here is subjective.)
But this rework would make the parsing subtly broken when enum
cgroup_opt_features is expandded in the future, it should be generic not
crafted for a particular value.

Michal

--cnmpivdyfnfqfyof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaInZoQAKCRB+PQLnlNv4
CPuHAQDUGuaObbSJnhmJ97IpPGK6ouqrAC/A5QeheMmspO5ujQEAgl5gD8RAwKbf
VXn/IXxf2yykNKJMrnSIXo2ajozkkQ8=
=XHtE
-----END PGP SIGNATURE-----

--cnmpivdyfnfqfyof--

