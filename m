Return-Path: <cgroups+bounces-8793-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53BEB0C74A
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 17:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F361817F98F
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411472D879E;
	Mon, 21 Jul 2025 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PRHasDFY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F843AB7
	for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110826; cv=none; b=KVpLQxMHs0OmQwbZHqEtPJoJ6VEvH1ltFJLd3o4NxKGtwKHUYDop1XkUFhjAautNu7Pevc6j80GTU/L1KB6BoJqMl2+OHqKTdLj+nWFEprp4jOmzktRihT2rSTgAkxmpbX/6Jt3yVtSZU2Lx3j5MhxDgNiJ0JAGJOebDZd4frq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110826; c=relaxed/simple;
	bh=xHPQTwQG7mFLfwo5EkTS/6rPgfldED8pi0g9XYelb8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7qfCDoAMlXgRGaJnkOBQrOYPCz4V6AhIBJg8e1KxxLsj4Za82z3InkbfHtOJZSI6zeQu0ZDTfTVHnGAu2UnDTZwHdRYcPByD6WVrMKk6SBVesMnmAy9GxtoHO7/3ox+vceHxyvudSNPu8ayJGWyrDMZm+B49yr1sYD3p+ZPbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PRHasDFY; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso7174752a12.0
        for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753110822; x=1753715622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IDu5pCrnQky8DFcKI/8huIUmu+sFGINoJFYgL412wT8=;
        b=PRHasDFY/Gt5HtImBa9mAKIFrT0BIjH9DKmXEGk/OQwiYfeWTz0ZJjThtKJf3rR2ZW
         veVmT0Q0+pEZAfvzOmHNvkIZKnpSag3Lq6IzVjB59HKKUd7B+dxUy9pcQ8uVMRIrXXi7
         Gf+OzGo8SkEws81jdE24oe+03rU1m7D568SECPZ+0gttWlsFwHt4u170EOQznLlPUrwO
         R+0o2MAcbiYeh59HHAtKnJZCmX6MfJk6Gc4Cgb6Jm/ycY8vPSavuYpz5IKugy9QCF920
         LldbV+CgjAIQUQSIxlqtvdxUrswnO2/B4zmxd7Q/iUv4ZeEHcV3KilL2o2Kbf7dFUPoY
         HvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753110822; x=1753715622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDu5pCrnQky8DFcKI/8huIUmu+sFGINoJFYgL412wT8=;
        b=pQ5ryBSAC7fVBEUBJEXsVZ4ZxFrPaoak+KYVQxnvaHjfo+4jFhI+8Mt9tjLCA/uSPm
         aE9kzYgoA0k02A08kadpYPeQBCzQrI+gwbIcSh+k3AQRn1oSvE71ea1yqV1XrdNjyEc+
         umNxoPN9vvVDs+5JqslCBQZJoKNu+su4ihDC2VvjyINiYxzvuDer7XauO8Pxxnn66V5d
         ajcAdQ51zNnRlJnf9S7QvR2pAqjk41rPsAR2I9WAtmxQglcTQ9yvFzKkNwRrh6dSyx1X
         8yFjGmq2p32Pz7rCe9wu0Z0tq0Lgh44GFdqRzhCSMTMN44XiNucEvGL9iQ6GkbfWloBw
         O5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWQH2fwCSz+K8tqM7lB6mLFEYIbc9J6pGFwiTzO640NupADIVkfrBrUY2Vh1f/oMg9j72ByrkyF@vger.kernel.org
X-Gm-Message-State: AOJu0YyRxgHlLPUjjobWbhdVIYvk/ny2THJPi14Z8cu+9qnRWI4bma3H
	URBTGsivqbJeG4eRpzZlMBvdRYLAngbpeMKcmyzry7ZztTYDPF/Lxu9pOCaHlajtx1s=
X-Gm-Gg: ASbGncur2JkNIaLaqhkLgBk0wIOQ1dtuwQcmxFWv3fL90i7EdH8ipIb3IJC7oSAI3u0
	zJWBA3nA7RPY4xCn/zcCaKZxUhvbvXRE87gxG5lLYYq7uFvZKNJQ0z+DiBqhE6xJUJsqeRn9snw
	vFabMk8cBTnFM4lr5TBekYRKWAtY57zHdshVQevZP0jL1oQXEq6eAP3WvDThgTtVZGd4u3erRnw
	u4Hl/vB1WUF9vEp6mY+dC0j3HlY0U1ImtvKJmISXzQsicpeds4ROtjGbRKPexCZ7P8sA4A2Y4Gd
	aPepxR5HcKoKzP3231k+RfIia0cF+L9C0KxYv4v7p1xpuNP0UMD6aRKUtU6FVZzoQhHcwpLxHz4
	vcxakCPZQ5qcXAMyFRsIvozlFB/TNkAUfpfD8xtWQLA==
X-Google-Smtp-Source: AGHT+IGQX1386Hp3pYdtGzBdxIsaDhI4e5Vtj1jwopX6vzTGNYVwJO/2WTIzr05hyS/FHF4oTrB6sw==
X-Received: by 2002:a17:907:e2c6:b0:ae0:c6fb:2140 with SMTP id a640c23a62f3a-ae9ce078f1amr1963318366b.32.1753110822267;
        Mon, 21 Jul 2025 08:13:42 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6cad3e58sm698880466b.147.2025.07.21.08.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:13:41 -0700 (PDT)
Date: Mon, 21 Jul 2025 17:13:40 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Chen Ridong <chenridong@huaweicloud.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v3] sched/core: Skip user_cpus_ptr masking if no online
 CPU left
Message-ID: <2vpxlzo6kruo23ljelerqkofybovtrxalinbz56wgpek6j47et@om6jyuyqecog>
References: <20250718164143.31338-1-longman@redhat.com>
 <20250718164857.31963-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e55t4h4uduv5pvba"
Content-Disposition: inline
In-Reply-To: <20250718164857.31963-1-longman@redhat.com>


--e55t4h4uduv5pvba
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] sched/core: Skip user_cpus_ptr masking if no online
 CPU left
MIME-Version: 1.0

On Fri, Jul 18, 2025 at 12:48:56PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> Chen Ridong reported that cpuset could report a kernel warning for a task
> due to set_cpus_allowed_ptr() returning failure in the corner case that:
>=20
> 1) the task used sched_setaffinity(2) to set its CPU affinity mask to
>    be the same as the cpuset.cpus of its cpuset,
> 2) all the CPUs assigned to that cpuset were taken offline, and
> 3) cpuset v1 is in use and the task had to be migrated to the top cpuset.

Does this make sense for cpuset v2 (or no cpuset at all for that matter)?
I'm asking whether this mask modification could only be extracted into
cpuset-v1.c (like cgroup_tranfer_tasks() or a new function)

Thanks,
Michal

--e55t4h4uduv5pvba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaH5ZIQAKCRB+PQLnlNv4
CKFHAQDFi9mv6NzskbkziLLzfB82XLMGRWyiIJE3OYIcBg6JZAD9Fb7PvTiLlkvY
t0OcJU7II1riGj6vZxhzrXF2abicMQY=
=uN1j
-----END PGP SIGNATURE-----

--e55t4h4uduv5pvba--

