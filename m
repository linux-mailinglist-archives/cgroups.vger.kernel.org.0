Return-Path: <cgroups+bounces-10516-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A384BB3428
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2538C19C194D
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4273002CD;
	Thu,  2 Oct 2025 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T1M3p26X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CBA3002C4
	for <cgroups@vger.kernel.org>; Thu,  2 Oct 2025 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393689; cv=none; b=H7ziVoeny8fSvmW6UScwIQmpKIVEcU16Pdf4Bekh1S1/CfY6VMpPgCLLFVMPAs5Q1kDJ9bDvxuO4lyzydQ15Jhskxl3E+X+JZRkVSdmub5rpCNONhi721zPuNU5q+n5OJRKzpTMkvFcGmjB7PnyjGubQGZhMGwRLIqm3KtryEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393689; c=relaxed/simple;
	bh=jBbJl1AjRG2VxRd4ZYUTAwB4pnyvbgugskoI/z/uBOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnxRblaEquCe50Be4fR9AEIAucNSe6rXWJ46ndssSwKkH3OksxywXn513C3t0hJPwYsphh06e7Q7BUCEKaRyyeSdhCuzlWQdcWWLKyC/jzwyLYOeqU80RxEC4gpIoJOJCDtWgG1O1jhLT4B42Jv3dndAQil97Ke2+LE3xBpecpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T1M3p26X; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so416552f8f.1
        for <cgroups@vger.kernel.org>; Thu, 02 Oct 2025 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759393686; x=1759998486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVDhg4/L7xBIfNP97EJSnQJG3YmsVSKM5wAeKg19HcE=;
        b=T1M3p26XuYnKslv7BuR7Dj6+3Gx9mHwYnlMXOiixSSrWw5UnGKKr4dcLjWURdQjmjj
         axsBMKzbkV7SmHnDULHf7A9Q3VLCP/YxkcDK8U6+pTuhYjoC6cqu0aLhr7ydDFTPCgBo
         VYFJHCICjnS94OtjkDw4jT6vgRaqiZkKaJuBtC94tFyOgiH7abLRJGG8vxbf3T5BFlMf
         JFg9yz6DdgaGWxAWBkEqxjKHWMC12nn/LXUXazZC6ldH+/j+3ewTVpmHnbP1pbzHTJ/t
         LXeqL7la4osXXFKxZ6UbQ3nLa+eJ6yf+hFlatjTltcJnW0FE2hWK9tumW9gRuLYIsto4
         XD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759393686; x=1759998486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVDhg4/L7xBIfNP97EJSnQJG3YmsVSKM5wAeKg19HcE=;
        b=TU5361qxZSJN0d59ZYhn8DgqoNAjKMhNQjWcaPqn5IaziiOU2mDGEOcFBIxU19/IAV
         BuNxZeQlzT2sheN06rjUSUKjv46w3WiLZ1vi5hSfQLigeQsLDueMOaprHlJEPsRQQdIq
         ogf9dVI3YZILqGpi9BFu93kaIk67Bd7gd5B7eAlhu+QsLj7Ke0eGlfHDqtZzxQmC3pUs
         m/gWcOLbJxQMhpGM7oEv1mCtqzC2rYobCV00LIFqCBvxOeRD/Io4sEiI55t7RT6yXK/i
         7p48OFN9wAcaVVuNPpXZPTc58SgTqz6aOniTdpL3pQbVQf8PFo1lOwdM/y3AU3MpP59r
         Vrig==
X-Forwarded-Encrypted: i=1; AJvYcCXpMNg0iHJdI/0bpTi+jiJwje3WaxD9I8Z4XGe71Vqy5KDFLirQyjMiyqprgvfnS2MSfbkz+Hwf@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsvtdQUnmPH8tkKm/FiW1zozE8uQE2ws00/tKUDID3nwAewO+
	VdpDZShcI+bGZTw2OFhQB3c0Rn6bXI/iCLR7nAe+snJzOOKG7Awxuu7MhsPEeZ9/+go=
X-Gm-Gg: ASbGncsqOCurnHKSxnrtyuhvEApRl6z55pWmnczPNYCVRdxHW0v5PuQT5mCNiH+NNX3
	Bja4dq5hM8/qHzxiaJ06kHl/4APASF+6Ecvrmka0kc/SPeuNZfC16kbWU1nIhVMpknICo8nJyU6
	pYM15Khr5pEvvgyROm9G26Rb71U2n0faEXYHph7Y5KMNaAFyAG6GRo8R3kAi5wmkvZI0437tEvb
	LL8HsClg69JYaqyOBA+nZ7LvDq2HSHhTDjIVZGqHwqxdq24idiHtUUSp7v1WtRcoghGKRvL19S+
	lXUvDCLfLIV3abdlmmyvXZo5ds/JsWuD2xPQdv0l0UjVzLEx1CvYo/i+H3PUG/v/4OFFqSvx32B
	tecejsmFf4fAbpscL249Xm8X56V0dDf879JCDV7GbsvR5wjRBuQaAPJAegg+4E79SAzk=
X-Google-Smtp-Source: AGHT+IF1S+CcnvbeXf66MSf7FcnB6dlBrYPMQf41lK3ANrq9TshhzWTtTWA6dJqkme/KOgZ70cPDQg==
X-Received: by 2002:a5d:5d12:0:b0:3ee:126a:7aab with SMTP id ffacd0b85a97d-425578219femr4466590f8f.57.1759393685922;
        Thu, 02 Oct 2025 01:28:05 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab909sm2591846f8f.19.2025.10.02.01.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:28:05 -0700 (PDT)
Date: Thu, 2 Oct 2025 10:28:03 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tiffany Yang <ynaffit@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
Message-ID: <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
References: <20251002052215.1433055-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="burn2oh7hadlsqsf"
Content-Disposition: inline
In-Reply-To: <20251002052215.1433055-1-kuniyu@google.com>


--burn2oh7hadlsqsf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
MIME-Version: 1.0

Hello.

Thanks for looking into this Kuniyuki.

On Thu, Oct 02, 2025 at 05:22:07AM +0000, Kuniyuki Iwashima <kuniyu@google.com> wrote:
> The writer side is under spin_lock_irq(), but the section is still
> preemptible with CONFIG_PREEMPT_RT=y.

I see similar construction in other places, e.g.
	mems_allowed_seq in set_mems_allowed
	period_seqcount in ioc_start_period
	pidmap_lock_seq in alloc_pid/pidfs_add_pid
(where their outer lock becomes preemptible on PREEMPT_RT.)

> Let's wrap the section with preempt_{disable,enable}_nested().

Is it better to wrap them all (for CONFIG_PREEMPT_RT=y) or should they
become seqlock_t on CONFIG_PREEMPT_RT=y?

Thanks,
Michal

--burn2oh7hadlsqsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaN43iBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgJ4gEAsLu6RZfLPNZtrX9B33q1
+BNsRWF4AircIO6oJPBwB2IA/1NWvLTbgf7AeTK3VtiRcHlrBQjw9pKutmCZQKEj
zJoH
=8SvZ
-----END PGP SIGNATURE-----

--burn2oh7hadlsqsf--

