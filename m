Return-Path: <cgroups+bounces-6079-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5851A073A6
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2025 11:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3AAE3A601C
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2025 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166852594BA;
	Thu,  9 Jan 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J0IWlA9G"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91FF21506F
	for <cgroups@vger.kernel.org>; Thu,  9 Jan 2025 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736419623; cv=none; b=NI5MUqhfyL8bhNzU3tKPZXdR/lQos/8RJpgKEt4bmD8RRHPAjABTu0kIsa0CTwXNJGtaolcVnY8ppfSQ2RtttK/+Eval7xg24QXg+GOnUj8NWU9j5vp9++8jtWBu6ecF0m1gxTdw0NPDDxhHf0pvzQQaWkXqMW8LKzkAfsgwh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736419623; c=relaxed/simple;
	bh=YaTjFKHqb0eYCggzba+80j9ajP1gtBUKtQjjqOR6ol8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI2MBY0BjYAAuNRNmQfcvSGFE1Rl2mesyMIzslb09VsOKl+fZsvDs1WMhtCzbWSFsfDH+dGT1bcyTy3Ln7Rtdc+1hZKvV6eB8RoFtTMwFwIvpJKDRqe2+uvobhoR7hFMpkwww71Nf3zSq7lX8Qr8B9zqZdGqE0M44mmjju7azwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J0IWlA9G; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436281c8a38so5778365e9.3
        for <cgroups@vger.kernel.org>; Thu, 09 Jan 2025 02:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736419620; x=1737024420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PisggeSxz9WPsHynjIqyoNqe/mEw35ksLFMqnPG/2iI=;
        b=J0IWlA9GNruFbMP64CBH1c/IO76HQZHAgYRZA+8Tn71sNEF9nf1triFV2v4zBVeuXG
         coLapMCRO/AuhIsmK10dy4ejB4Fn5NIfON+dozmzriFmpTjgTVoNyobhqd9jRwmd12/y
         B1jmNYmXBfJ4DORynxavSz0TpRljjjvxEMO3rFTFK0N66z7PuMETUajsh2YVR+VpJpog
         jg6aCUVP9lysU2xBBH8LQ4mp0LlIH6TNOnyFFtgA6q2rNKViG3PqSaR116KfhVxoVAJB
         AmooRbSh8aAwlWrcM/WfyfUYkjOyJUyqlKseeFly8nn/sOKuj1qnXn54dPOgITClx+f8
         Digw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736419620; x=1737024420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PisggeSxz9WPsHynjIqyoNqe/mEw35ksLFMqnPG/2iI=;
        b=APUs3Zt5B6VZy5939JJioA04y7j5j5LQHyc2mZl/wFko3Vn2VEvCluT/SYj/LueH4C
         YIRcFwbLgxFf1gOFsxX5FkUQsP4u/tcyBtvMSIUrqHGRqRywE8mgcAsuX3z4N0y/mGC5
         gpEY+6NrdoCbKisEbYLoTWSOC/ovcRYtm5VjytIEjw/BfE0h51ctv3b9DfwLzYjx3pFL
         kriz2jsu/RkGsa3Rm0RO7f+yIPdU2+77ALqRoStjMujk3ewhbO8mRLWRP+BnPUeJr0Ux
         f6BB1/bsH3yhgMvpo03sOLSDcAhqiNO/VjX4UtLUKN/aLW/QXs3qiVyRj9EltE9feHRz
         Rh9g==
X-Forwarded-Encrypted: i=1; AJvYcCXtmax0j4fxFVkk9+TnK62wrwpwGuQvISun+GEpudSFAr60n6pQ/b/09QBMeJG6ytD029gYmpHE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RXu/sXaR0ODrmryIwAVGSruAL0jECI2N/6+0pwC4+/c6ZvKp
	8bvPhX3bF91WP1DjX/ul3jKcnuTrn5vMAiqvLSpvltWgsXIAqDXVVMPTJKMVWFo=
X-Gm-Gg: ASbGncuNVFS49lY0yx+Ugdy9OoRDZ3gKJo/MH80RY2R/rnzoIgtS8nm+gSNDBCCyXQl
	J24kLhKqCJ4ovUbnsCXTfJRKy+agyOczGDVXTl59shvCVZLsgVTYa/z+ZilPquSXjVNoMECB9et
	+rlH0+ng663Bny2eetrTisB+3r+RP8uJPZLrrW8nbSEAN2CaAl4kKyTrW/QampZpOGO3u+iRm2q
	sbtqBiNhsEHI54xfuVJ3bxJL9pQYFOYTU3uhER6ct2Nlpdwfc/v1ujf4PY=
X-Google-Smtp-Source: AGHT+IHJZBeekHgr7X9DA5qBFzdYNArZCU54b3MrC0kMa86cbA2OIJe831SInjKuuTIFIbuoYzNQug==
X-Received: by 2002:adf:9793:0:b0:385:f631:612 with SMTP id ffacd0b85a97d-38a87303f9dmr4489293f8f.17.1736419620103;
        Thu, 09 Jan 2025 02:47:00 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38f176sm1488264f8f.63.2025.01.09.02.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 02:46:59 -0800 (PST)
Date: Thu, 9 Jan 2025 11:46:58 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, hannes@cmpxchg.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	lkp@intel.com
Subject: Re: [PATCH v8 4/4] sched: Fix cgroup irq time for
 CONFIG_IRQ_TIME_ACCOUNTING
Message-ID: <z2s55zx724rsytuyppikxxnqrxt23ojzoovdpkrk3yc4nwqmc7@of7dq2vj7oi3>
References: <20250103022409.2544-1-laoar.shao@gmail.com>
 <20250103022409.2544-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ghv2oajmipitqsyp"
Content-Disposition: inline
In-Reply-To: <20250103022409.2544-5-laoar.shao@gmail.com>


--ghv2oajmipitqsyp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 4/4] sched: Fix cgroup irq time for
 CONFIG_IRQ_TIME_ACCOUNTING
MIME-Version: 1.0

Hello Yafang.

I consider the runtimization you did in the first three patches
sensible, however, this fourth patch is a hard sell.

On Fri, Jan 03, 2025 at 10:24:09AM +0800, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> However, despite adding more threads to handle an increased workload,
> the CPU usage could not be raised.=20

(Is that behavior same in both CONFIG_IRQ_TIME_ACCOUNTING and
!CONFIG_IRQ_TIME_ACCOUNTING cases?)

> In other words, even though the container=E2=80=99s CPU usage appeared lo=
w, it
> was unable to process more workloads to utilize additional CPU
> resources, which caused issues.

Hm, I think this would be worth documenting in the context of
CONFIG_IRQ_TIME_ACCOUNTING and irq.pressure.

> The CPU usage of the cgroup is relatively low at around 55%, but this usa=
ge
> doesn't increase, even with more netperf tasks. The reason is that CPU0 is
> at 100% utilization, as confirmed by mpstat:
>=20
>   02:56:22 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %stea=
l  %guest  %gnice   %idle
>   02:56:23 PM    0    0.99    0.00   55.45    0.00    0.99   42.57    0.0=
0    0.00    0.00    0.00
>=20
>   02:56:23 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %stea=
l  %guest  %gnice   %idle
>   02:56:24 PM    0    2.00    0.00   55.00    0.00    0.00   43.00    0.0=
0    0.00    0.00    0.00
>=20
> It is clear that the %soft is excluded in the cgroup of the interrupted
> task. This behavior is unexpected. We should include IRQ time in the
> cgroup to reflect the pressure the group is under.

What is irq.pressure shown in this case?

> The system metric in cpuacct.stat is crucial in indicating whether a
> container is under heavy system pressure, including IRQ/softirq activity.
> Hence, IRQ/softirq time should be included in the cpuacct system usage,
> which also applies to cgroup2=E2=80=99s rstat.

But this only works for you where cgroup's workload induces IRQ on
itself but generally it'd be confusing (showing some sys time that
originates out of the cgroup). irq.pressure covers this universally (or
it should).

On Fri, Jan 03, 2025 at 10:24:05AM +0800, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> The load balancer is malfunctioning due to the exclusion of IRQ time from
> CPU utilization calculations. What's worse, there is no effective way to
> add the irq time back into the CPU utilization based on current
> available metrics. Therefore, we have to change the kernel code.

That's IMO what irq.pressure (PSI) should be useful for. Adjusting
cgroup's CPU usage with irq.pressue (perhaps not as simple as
multiplication, Johannes may step in here) should tell you info for load
balancer.

Regards,
Michal

--ghv2oajmipitqsyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ3+pHwAKCRAt3Wney77B
ScWgAQC6xfF9zln4v3fJDZI3N68Wfy+1lAK1yGVyMts7qjrnZAEA/LwTfgVja5RS
zrKtzC5hysNvKAnmUD7EN/lW6KB9aQk=
=qx/H
-----END PGP SIGNATURE-----

--ghv2oajmipitqsyp--

