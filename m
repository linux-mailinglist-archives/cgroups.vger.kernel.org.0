Return-Path: <cgroups+bounces-5574-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9D59CE069
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 14:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B042887B4
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C011CEADB;
	Fri, 15 Nov 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bi38/vME"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B471CD214
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678110; cv=none; b=U4Gk6Y6MFXjI+zcjDyuFb6ZT8JyPNuAoGosNSu4ZFY6SB0Fl0oKxA6fSYf1anjqx9XHqln/wQ/0Vdkry3YSojiD5gXU/qJfY1AA4Ix06CYsfyB04R5z40og5b8MWkPaNB+S9gmNFxbYRwu4AJyiFWBvhqlmRACdO+jxvAJbgFpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678110; c=relaxed/simple;
	bh=b4OaTEz3T5Uhwk/Ra82qj5sL573WaPqkJnX3eHFAZIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkXpsdtyi1K+4RwW5EIi4EDWl5T/Gowb3WhSbt7irLu5jhLBrndKvORlZEtrq+NlwnWaNZgro7FvicHuQHho0rrFM1RQPZEIvFzOTZlCEhVdfVM/3qYty/mRFd8h9QPmPED7pHIuh4qV0CbFaKhrgCJ1ia4FHoh8pySLGDnVcLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bi38/vME; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so15156105e9.3
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 05:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731678107; x=1732282907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1smb8M8u3kZ9zTyhl0ig5iGFrkvBmbXBHd6InjP0eZM=;
        b=Bi38/vMEeZzBwRz7CL0ISBG82vPrAUi/OtU2s8EK6EjZfDekIYDFe/LGp+RzCsxE7X
         V5o8ydFTXryvRMnoKn8txwya9x0asTkIshgjDTQ9jWhqC/QpKz0WltYDJCn+Iep4P8He
         nN3O8dMrxIviRRtXSVIxw8axEUsH4EA9AymepzDhYDi6UwOS2XF5aVoxiNR6fDjGR0jy
         Sd3oPpYHTBMxjiL1aPfGNeG8CYIvxMIzIJPpzENBhQE6y6+DU51IyC+Z7/WF7sls/K9r
         hHkXnwj9vk8tnHgMY/cnwQPlv/wSMv9rhdMJRJtRpLhgmwx9ApqV92luMxXvwg2Gri3h
         rYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678107; x=1732282907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1smb8M8u3kZ9zTyhl0ig5iGFrkvBmbXBHd6InjP0eZM=;
        b=EN8/QPbhFaDAqpISMiXXlOj67kqTRblz7b/hqfvSLBbFBFxOuKuEGy/PGPS9hzPDG3
         ihmC4MHidV52rHeQZ9vABDDzvniJj5EGgmr2gpZVfV5btkd3OM0sxp+/LQRlEnr10M8D
         9t8Wi0ASI26HT7xv5a81eu+3J+tsnHQP519QnTUBqEKjyJJB6Nz1s9dD38m06GGYoACJ
         SoxXoFtvBsQxlagkAt3Dn0wh+74KixwE+ErOY35sv0HuWFBwgA603WzX5id5N+cFUJeH
         eoLUIGfnmF9HzDgF87IAAimYkXm3WrdKmINmA7EE4WDHV1317W3sdDyH7Pod9AfKTvAe
         Mr1w==
X-Forwarded-Encrypted: i=1; AJvYcCU8p+TGogaPKH+VAjLVNfFajNeT70Ux6sWX2FVher5gHLImIzgbB/hIocYJgfOWb3Prdi9f1gvc@vger.kernel.org
X-Gm-Message-State: AOJu0YyshUhkCZ5cHVnuOCNlLmsw2vvBRyzJgu6fxErKGBtBLg2VXuyS
	Mh74dP99lsV8CvDkEAIcWgm4Wyan5FvUX8j/o69wkSOnpydxoPmSw0vvdVIWO/o=
X-Google-Smtp-Source: AGHT+IE/3oI4O4I+mkLYx/mRZ1mvnUF9eVOGFBiOib2xyb9Swwsg7/9DcDdSA3l1+BWSUIkfL+ONZg==
X-Received: by 2002:a05:6000:788:b0:37d:4389:e9de with SMTP id ffacd0b85a97d-3822590b85bmr1972047f8f.1.1731678107177;
        Fri, 15 Nov 2024 05:41:47 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbeb7dsm4337049f8f.58.2024.11.15.05.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:41:46 -0800 (PST)
Date: Fri, 15 Nov 2024 14:41:45 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, 
	surenb@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] sched: Fix missing irq time when
 CONFIG_IRQ_TIME_ACCOUNTING is enabled
Message-ID: <dmibxkog4sdbuddotjslmyv6zgyptgbq5voujhfnitdag2645m@bl4jphfz3xzg>
References: <20241108132904.6932-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6k67xk3cawa3ll3a"
Content-Disposition: inline
In-Reply-To: <20241108132904.6932-1-laoar.shao@gmail.com>


--6k67xk3cawa3ll3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Yafang.

On Fri, Nov 08, 2024 at 09:29:00PM GMT, Yafang Shao <laoar.shao@gmail.com> =
wrote:
> After enabling CONFIG_IRQ_TIME_ACCOUNTING to track IRQ pressure in our
> container environment, we encountered several user-visible behavioral
> changes:
>=20
> - Interrupted IRQ/softirq time is excluded in the cpuacct cgroup
>=20
>   This breaks userspace applications that rely on CPU usage data from
>   cgroups to monitor CPU pressure. This patchset resolves the issue by
>   ensuring that IRQ/softirq time is included in the cgroup of the
>   interrupted tasks.
>=20
> - getrusage(2) does not include time interrupted by IRQ/softirq
>=20
>   Some services use getrusage(2) to check if workloads are experiencing C=
PU
>   pressure. Since IRQ/softirq time is no longer included in task runtime,
>   getrusage(2) can no longer reflect the CPU pressure caused by heavy
>   interrupts.
=20
I understand that IRQ/softirq time is difficult to attribute to an
"accountable" entity and it's technically simplest to attribute it
everyone/noone, i.e. to root cgroup (or through a global stat w/out
cgroups).

> This patchset addresses the first issue, which is relatively
> straightforward. Once this solution is accepted, I will address the second
> issue in a follow-up patchset.

Is the first issue about cpuacct data or irq.pressure?

It sounds kind of both and I noticed the docs for irq.pressure is
lacking in Documentation/accounting/psi.rst. When you're touching this,
could you please add a paragraph or sentence explaining what does this
value represent?

(Also, there is same change both for cpuacct and
cgroup_base_stat_cputime_show(), right?)

>                    ----------------
>                    | Load Balancer|
>                    ----------------
>                 /    |      |        \
>                /     |      |         \=20
>           Server1 Server2 Server3 ... ServerN
>=20
> Although the load balancer's algorithm is complex, it follows some core
> principles:
>=20
> - When server CPU utilization increases, it adds more servers and deploys
>   additional instances to meet SLA requirements.
> - When server CPU utilization decreases, it scales down by decommissioning
>   servers and reducing the number of instances to save on costs.

A server here references to a whole node (whole kernel) or to a cgroup
(i.e. more servers on top of one kernel)?

> The load balancer is malfunctioning due to the exclusion of IRQ time from
> CPU utilization calculations.

Could this be fixed by subtracting (global) IRQ time from (presumed
total) system capacity that the balancer uses for its decisions? (i.e.
without exact per-cgroup breakdown of IRQ time)

Thanks,
Michal

--6k67xk3cawa3ll3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZzdPlgAKCRAt3Wney77B
SQHeAQDXtJObG5fsVenK4tykTYooC4DGP5Zvc55ewS/GJ2SgSAEA3xaZ6007r4gD
So/70wGjjcIUsDNFl3SjVFAoIcXxRQk=
=MuN9
-----END PGP SIGNATURE-----

--6k67xk3cawa3ll3a--

