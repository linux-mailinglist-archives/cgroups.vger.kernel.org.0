Return-Path: <cgroups+bounces-12290-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1434DCADC82
	for <lists+cgroups@lfdr.de>; Mon, 08 Dec 2025 17:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E107C302C22E
	for <lists+cgroups@lfdr.de>; Mon,  8 Dec 2025 16:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30244219301;
	Mon,  8 Dec 2025 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M1xzyeNg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9313AA2F
	for <cgroups@vger.kernel.org>; Mon,  8 Dec 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765212533; cv=none; b=SZ1hHgm4clb7r0s5zX3jphg8L5pfUmJBbgbtKHgekIl5R36E5JuWy/R2s3c/jgZwcikPI8EJfMvGg96aidcn5Zq0LC3i7EhR7SHn9nRma0n28DDcXTf8MsUPSCGQHWXnFQ2ZMLP5w14py0Kz6gWI1WnHgy5yOtmG4rmlHG/ZuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765212533; c=relaxed/simple;
	bh=NGTtmc49qGm8JmqTcihsC/mRcolGTztLq1MYlXidkeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9hlwSiSHcrFiYMmPqTPpe3wmVa8i73Sll/IA5YTNHbuUgDG+Q6w1sqWUWhgEpHndZiVdHYGxsGyak8H0xX9Yg9F5xqx9w3OAnRnWf/91sGAqqXhPBlhPJWkZcdPIAVefDVQ2PFLyLi0aG22ae7+YP8KTBUPKrm2bLPjeQp3TFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M1xzyeNg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775895d69cso23421005e9.0
        for <cgroups@vger.kernel.org>; Mon, 08 Dec 2025 08:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765212529; x=1765817329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGTtmc49qGm8JmqTcihsC/mRcolGTztLq1MYlXidkeo=;
        b=M1xzyeNg1qdBDLmQSIcJW/0LctwD5atkNCH+PY3SZYzBB9GPEugIcVSSW9U/YGoPol
         xE/VYOreEATv98Fixgoc0bffXVTRt2jeIRNbRVA8u3yAdsbag2hjPO5YNDjU12j+B3Dn
         kVrPyoNq9UII0pVZ8X8IAO/eqRmia3re0S3ajad/pLj8UKZaX8HdXgjaNovcIlo3gGiY
         A+4W3ZAtQFPLNhkp13hmi3uHJWDZL+MLYULrwJ14LC4eBxi8thT68CSlWxF+UJV9PlMh
         StKLBzqrLvrRB9zrko+ZOnvzvymldYW3hMY1SYTCxDkWP7RX1Tc04iOVtjTgwBV3YtmG
         acvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765212529; x=1765817329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGTtmc49qGm8JmqTcihsC/mRcolGTztLq1MYlXidkeo=;
        b=RyQDZXcxGIjl6C2SyO6bANRwz+Ez28QArfOo7EPRFa2rzr69a2hOFS+NudMHsoKE/e
         SDqvNXXx5HVA8vX+X4HVcJMWUbZ9CWoGmhnZHUPNzqn5jbkyh+wSMh/lzHdEDpLKB3R7
         51uODR5M2bX8KpEApY8kPAYIFIWV0VVfKxDO4WmX7cdboIuY6Z9M983K9R/gb+jECIB+
         ecrpa29gtwjoX81uVa1y3sZvaaWDJCydzVfwdL6JG4e9CIvEkoz0TvIbbbiAWtpjc+sf
         ltQValc31Gx8oxd8pAccqsLDMGRj2azQZpQnh5R5byFRnf+f0VxwdKQ5OF18Up79XBKp
         BQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUIP4oS6hWpbFeAjKtdgaaW+gmFwiMCQD15y02WHWv1nAVNxumBCttKLWLZzT3mRb4LCuShL6we@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6L7s+PTFrFnnVGTaNuTezLeEcQlIvS4k88MIp1QVBqolbK57m
	a4QPb3RX1FpTa+uq6eDx8+E+0jp2AWhmcxzm6vPg9BoWEWesaNOxfuOjVSM/se7XTCQ=
X-Gm-Gg: ASbGncv8sEbS/cLc2dlsMe68kU6CGv48S1bRolwW2VwR0E50crwMM/+kL5L3nKHQrxQ
	xGV8jvChMwDXryXtMiuEr9ZD/PLBXOfacIP2QYZ9orOCE+1w85DEUpxIrGsIYsUZYJyFXmpH7G0
	dHNhBRUBZSpBYMdH3KJUjB8xKt6rU8QEG/p2wKSPbHHG0IO8jGjMpMeJPYoQQo6te4G4De10LMs
	wKtWmUqD//VI2oIXxGw7M2sHS/pkeAoGxSctnatz+vW7FUedCvKIOf8bMzZszMlhWP1xgyxntcb
	nrCmAUBjZYm6DTG/ii0fMlpywaew4UrQzYVrbiULIWgBakW7EVlioflDbgL9FYHA6pzbAMPvfu+
	sal9njHeBvrPN1SatvEqTPXCgx4pRAs6LB9bYa+bPvcbisNDPvN+0VgPcDzfMLWi8joqTCHvoGT
	ENxcZ82KwHDUZzfy/L0e3fIaW438pwhtqfUPWl22Hq6Q==
X-Google-Smtp-Source: AGHT+IEsJ/iSaDvwNh18lu2wFHnkomxJ8Hvg1XZtgMMg6hpjOz1LIBWnTk3op1li+CYOfSPEkMphCw==
X-Received: by 2002:a05:600c:1552:b0:477:73cc:82c2 with SMTP id 5b1f17b1804b1-47939dfbb50mr84510895e9.9.1765212529294;
        Mon, 08 Dec 2025 08:48:49 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331e62sm26750068f8f.35.2025.12.08.08.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:48:48 -0800 (PST)
Date: Mon, 8 Dec 2025 17:48:47 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Andrei Vagin <avagin@gmail.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, 
	Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	criu@lists.linux.dev, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/3] cgroup/misc: Add hwcap masks to the misc controller
Message-ID: <6dmgfe5vbbuqw7ycsm4l2ecpv4eppdsau4t22kitjcjglg2gna@dyjlwhfhviif>
References: <20251205005841.3942668-1-avagin@google.com>
 <57a7d8c3-a911-4729-bc39-ba3a1d810990@huaweicloud.com>
 <CANaxB-x5qVv_yYR7aYYdrd26uFRk=Zsd243+TeBWMn47wi++eA@mail.gmail.com>
 <bc10cdcb-840f-400e-85b8-3e8ae904f763@huaweicloud.com>
 <CANaxB-yOfS1KPZaZJ_4WG8XeZnB9M_shtWOOONTXQ2CW4mqsSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qhatuyfusoefghqk"
Content-Disposition: inline
In-Reply-To: <CANaxB-yOfS1KPZaZJ_4WG8XeZnB9M_shtWOOONTXQ2CW4mqsSA@mail.gmail.com>


--qhatuyfusoefghqk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/3] cgroup/misc: Add hwcap masks to the misc controller
MIME-Version: 1.0

Hello Andrei.

On Fri, Dec 05, 2025 at 12:19:04PM -0800, Andrei Vagin <avagin@gmail.com> wrote:
> If we are talking about C/R use cases, it should be configured when
> container is started. It can be adjusted dynamically, but all changes
> will affect only new processes. The auxiliary vectors are set on execve.

The questions by Ridong are getting at the reasons why cgroup API
doesn't sound like a good match for these values.
I understand it's tempting to implement this by simply copying some
masks from the enclosing cgroup but since there's little to be done upon
(dynamic) change or a process migration it's overkill.

So I'd look at how other [1] adjustments between fork-exec are done and
fit it with them. I guess prctl would be an option as a substitute for
non-existent setauxval().

Thanks,
Michal

[1] Yes, I admit cgroup migration is among them too. Another one is
setns(2) which is IMO a closer concept for this modified view of HW, I'm
not sure whether hardware namespaces had been brought up (and rejected)
in the past.


--qhatuyfusoefghqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTcBbBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ai8MAEAyeSN6KCarnIABEa5QMqm
oISbZ1p14CvmHATzKA1bOyEBALyv5+on7iSaLxmoTq8ygkMxgB3VKwZP81DcFFDB
DEQF
=v5da
-----END PGP SIGNATURE-----

--qhatuyfusoefghqk--

