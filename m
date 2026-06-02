Return-Path: <cgroups+bounces-16552-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE0XKcSLHmr0kgkAu9opvQ
	(envelope-from <cgroups+bounces-16552-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 09:52:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7C6629F1E
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 09:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26F6F3001841
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 07:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B523B4432;
	Tue,  2 Jun 2026 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SUInKtFH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83BB3B389D
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386411; cv=none; b=rNNIrFTWtbEHP7WbdzzFIOPnRM9pRj9xzCOWGgaHMwtS+k5gTavku8mDXJCN554JR2wWcIQiRNGpLwYisGejvFYM4AyYZr9rO1Tv5ryaz0MNGqp5EjWXbTuzfN6m+rOVJzW1s46O2426eqzm8sUWHX4lHyQZfX6jUXMM4Jbt500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386411; c=relaxed/simple;
	bh=bG5+ntsuzHhvF2YAu3aATq6uBI9GdV7PFk7TOgR1ZEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqqkx9a2xNVU0zDpWC8RaNFbkHpZQnF+dU3Y/dWUo6qO7YEn39YOECa9hL5VMt9TPUaFTloFxcf7l5gebLVV+oIoV+dG4li+a+OfLBNyDA3eQ+Rg3CL14t19O/6m7pW4uNNSCHQQYdYcRU6u4+xdICo+tiU7ehIjmcHtfTpqEk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SUInKtFH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45eea68dd6fso2558429f8f.2
        for <cgroups@vger.kernel.org>; Tue, 02 Jun 2026 00:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780386408; x=1780991208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bG5+ntsuzHhvF2YAu3aATq6uBI9GdV7PFk7TOgR1ZEs=;
        b=SUInKtFHPDasfGGFmbknZWojOv9SVcqiqi+t1lqHOPSKBD/EEtzoLIqWzlNrrSIctx
         DMUq6ZifvlbB7o7ahbEfHeNLEj+oFWrIrXLmWZEez8i/DOWU4JsMNgDzkPXmfgVDjelb
         0lKDRepz50NI742uQH/2qOPdb5Zec4WOrcw/e9147de6JkpGBD767O9s8wljDX4LPOMe
         IJ+BHxwA4qJ1OPrdajUrm0dVgCDL9Y5aJQmGVfK4zBZJR2wDn7UH2h3CQ3tGJk/Tkvqo
         qbprlDOJUyGwH9sKXfmGh1YkKklWsvi0SYUHYyTkj2JsTAx/Un1ZLn+REHwDBChHlT+w
         Tu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780386408; x=1780991208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bG5+ntsuzHhvF2YAu3aATq6uBI9GdV7PFk7TOgR1ZEs=;
        b=bYsLH3W24FBlrKsmh1C81Ul9/DwkLHXltxXUWYpvGS37sFlJ1GGcbQEA507kJ0iKVM
         5fDh7ZHijAWaR/ZHYFCpfEPOklEsxONE5rZDuHllmfBVGbJvay2R9WSPBAn11b+kfcTG
         07uLoULBw16eX4UImNiJmys8SuTJrGQQWElolww3017r/tcwBA4J9nLrrQoqmA5qL6J+
         l6/WdZfsKxEPEjDudm8XnH1q1oSCzVH1tg0WBXZ7t0T+nyWyjul5lJcycDfktnnK+NxU
         WMd2ouwGx2VfxufqaKJhk7mmfYrJ/vKBCnE7sVbJcr/JBwaWf7GhqzGpRE0dGYsROnn1
         7jvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3mg5C77iGZmkw1nCUErfnHNidqDu4mWTrQE4FVVGdw4pgIAfn0jRdJYhDl58lyWFvykYVG9sY@vger.kernel.org
X-Gm-Message-State: AOJu0YyacnBz6q5zgQRdtY7NgS+2sga/Pz0uNKMrpGPNDqjfYAzc4iPT
	2mCEmo2fYtLmFMpA7u6WwzhBlL877RzuzT6R+09PccRvH99rEMvwD03gkkpsWDhs8sQ=
X-Gm-Gg: Acq92OEbuhD6wDbX7J0OGKMq4PBTwjRf3RsQnsXmcDN02a98lrwlFU/m04CZU4o51+X
	taRDN8+zQIotV0KbsMGr9qIORwyIViMV5+ePa4yAbfDFQM4zSn+146KUTgnQUsQdZYqe9cPFEHu
	CqDl0SyyEe3EaeZ9isxCLEBcQWFud/SeVIGDj9hget/Pnv+ut6sQ/MJIcR9WUxthhTezm3sXsaF
	vAJrVhwAv2sarF7AEPufX9/HPeZvSmPy6J8ttdbrup60EiAdgCZQl0xMV0CgWfYQEiQNcBZ2H7J
	ur1m1BsMxp9tHR2XAApLl4VkLZ7f1MHMbwDxtgJ9lUEGH9uiLWHZSp/k5XtigNGOj7jxUejHdRK
	UL0kmKqQzaCbKSqVY1pe+o8AorigmDHUQthnLyrbQ3wly6ot0bN80UoNReSx9lffr9JZfEnOczy
	FtzwIyQlbV6BVPV2uog+91zNpPMo0O/9Pu270BXdo=
X-Received: by 2002:adf:fd47:0:b0:456:b23d:e57 with SMTP id ffacd0b85a97d-45ef6a90f4bmr19144874f8f.0.1780386408263;
        Tue, 02 Jun 2026 00:46:48 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a0403sm32524322f8f.6.2026.06.02.00.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 00:46:47 -0700 (PDT)
Date: Tue, 2 Jun 2026 09:46:46 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: longman@redhat.com, chenridong@huaweicloud.com, tj@kernel.org, 
	hannes@cmpxchg.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2] cgroup/cpuset: Fix update_prstate() always returning
 0 on partition errors
Message-ID: <ah6JpNvdO7vaBmjS@localhost.localdomain>
References: <20260602045521.2381230-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c6nksd6npnwlpzzk"
Content-Disposition: inline
In-Reply-To: <20260602045521.2381230-1-cui.tao@linux.dev>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-16552-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,suse.com:dkim,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0D7C6629F1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--c6nksd6npnwlpzzk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2] cgroup/cpuset: Fix update_prstate() always returning
 0 on partition errors
MIME-Version: 1.0

Hi.

On Tue, Jun 02, 2026 at 12:55:21PM +0800, Tao Cui <cui.tao@linux.dev> wrote:
> update_prstate() stores the error code in cs->prs_err and transitions
> the partition to an invalid state, but always returns 0. The caller
> cpuset_partition_write() uses "return retval ?: nbytes", so the write
> syscall always appears to succeed from userspace even when the partition
> became invalid.
> Return -EINVAL when err is set so userspace can detect
> the failure immediately.

This is quite a visible UAPI change (a write can succeed to invalidate a
partition) and users are meant to watch for cpuset.cpus.partition state
anyway for asynchronous changes.

I'd not change this gratuitously.

Michal


--c6nksd6npnwlpzzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCah6KVxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjvVgD/a0sQ0ojzfnQ8pMsAB4WK
YApLD0myeE5QcV5AUhxmKpwA/1o+JW3f/JiZAF9d9XM2arm7yaOS7PBOfyl+CV5D
6yoJ
=cGY4
-----END PGP SIGNATURE-----

--c6nksd6npnwlpzzk--

