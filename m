Return-Path: <cgroups+bounces-6759-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6665A4C4D3
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 16:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7881885180
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 15:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6E12147F3;
	Mon,  3 Mar 2025 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B7dsJBsi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B92153D8
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015167; cv=none; b=lRgHnUsadKSK5MFGMfuODv0xpsJ9Ucwgscd0tsZFZOwhdGgckJObdkXiojrZ1+ok4ZhbcxqeihJNUuKYLYFD1Rr147MtcAIqkHul/69rgLtZpMnBdtb0smXrsDOLphY9155evTn5qvYHIEQUqcTn66MoYreMtaAqkjEcRjCCN1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015167; c=relaxed/simple;
	bh=lNfCdxr5lvVw/ufHNBbgA+yvKn5lmO39pQOwmTbxaiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slzhz6ZtrfWHbcb3OHnBYlSjtbN79Yd4v32NsVeRMWHruPWcnroBgI3GG7Gk7R+7OpSSsJZMqsKnLuJ3Wusxll9FBupQ0hdgg2unguhhFgwpVhEiYtpCNjjKpSwgwcOQo7ihn3Ym8Qd9tZkim1sgfNet3DJHWS2/AAxFEhZbPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B7dsJBsi; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390eebcc371so1636334f8f.0
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 07:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741015164; x=1741619964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKFppOwg0uMRAdpNAovXQCNWA/tqXocPE3Airj8rpdM=;
        b=B7dsJBsiBNT+to3IFDQSMaQUCqEsXDVd65dYcsuvdeQwpqjIYeSmJcS2tLOWl3EJNh
         zYY5ZSpJFYAzVajI9Ka9MJyhDnuLIPvER0+0ta9XQjidgSw/0uX0NvDM1m/r+CC9vOqx
         0or7Vehf34GCtp5UHuYMV4jZ85gggp5NTe8uo8jolkuRlxvJjZVAMSz+g0dafHO3FApl
         QavrqlFDv1zH3r5nEj7rXjFOX87zdLi+aJKZxbPA6iY2NGKAyoz2ZNF2HFuJMLjJqjGj
         kpJwnFuJF4cAiKekFp54WJ8q4leJTxDFiQ0YbaH47Dquny2tcEpevfeKtwOCno4beTyG
         huqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015164; x=1741619964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKFppOwg0uMRAdpNAovXQCNWA/tqXocPE3Airj8rpdM=;
        b=ftKYkAqttBEY4ngFGEIlUIIoxr+d8F9pvOcaUZ3/TVIUZ31wsSs0pFadUMWwlrkliu
         jWJGqEKITyDSM3yT4kH2Gg0BMDBm3upAKPsPHa+wMm4TWzVUgxFAPbHO5X978XXiRrFm
         7tpEP8tTIL5qQw8pzQ5NM5xnH6qPLBS61BWZvyOAwBr8ZciZ5reZeL1TPH8sXitAzXS3
         jERSv9oM4xMEW3jjD2zffQsDa0wSMJjW6jCk6sV/S6+hVdPOIU+ytF3NSvvJLERpPiRB
         kXMi/Jep0tl5YZe5N9sByzOxYJIzXPvVQbg2v3YXkPV2W5tS3p6bpl7seZ6rwWDQ5KuK
         RCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfCKMcG2/tHHRRY8cps5iCtxnB5B+perqRTcWRLQeMIqs0kkhCh0suZbRPvFoAwNdV3v2mcNDs@vger.kernel.org
X-Gm-Message-State: AOJu0YyMsv8PlCKPCLy92nD9DJKB4u4H7nbeCtrzNCcwzZNahuf0QhUi
	hqgW7kNgi+zXhfOJ/9gzyQ0MjIPWx93lwk7hM8Wj/tOrLbhl2708hPQfPNzIfak=
X-Gm-Gg: ASbGnctDO//j3vtU1Dek/Q07/EwtivflpwYaVjbxPiifkZbWhxIFvhGcrJrz0zpUwSA
	wlidofnTotxaVRX0Ka3wqyAvPAUSougouZgslQkqFP3yTjwyX9dtwAnZ8+e4+TF3OchUVle+R1D
	fK75ykoCf+VbRyx0flFXiMqFtbfnGEXRb93cKRt6pHHJp5BUYHcjQF5i/hkK0kK7USB1Oa/qwd9
	sJ+gXkow313zltbV96gH9ZF8LY16Kr8osYW6h5+Lk88pp1o17UkBTN3SFDO8E4T1RC+uceOysL2
	P5E/fh2/ann1hxBSsS96Ot4beYC64Q2TGLqNQC4pR5e+E60=
X-Google-Smtp-Source: AGHT+IF4ZJDwFWyjZ0Z3M7N1ufBGR7VNTMRXLhtz8p3NUCTDInJgzI8NFEHLq1pQ7XZz0Rw+6zSK3A==
X-Received: by 2002:a05:6000:1a88:b0:391:78a:33de with SMTP id ffacd0b85a97d-391078a34d7mr4047609f8f.12.1741015163582;
        Mon, 03 Mar 2025 07:19:23 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e484451fsm15057087f8f.63.2025.03.03.07.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:19:23 -0800 (PST)
Date: Mon, 3 Mar 2025 16:19:21 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: inwardvessel <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	mhocko@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/4 v2] cgroup: separate rstat trees
Message-ID: <ee4zdir4nikgzh2zdyfqic7b5lapsuimoeal7p26xsanitzwqo@rrjfhevoywpz>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kjq6t4ilt444tubi"
Content-Disposition: inline
In-Reply-To: <20250227215543.49928-1-inwardvessel@gmail.com>


--kjq6t4ilt444tubi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4 v2] cgroup: separate rstat trees
MIME-Version: 1.0

Hello JP.

On Thu, Feb 27, 2025 at 01:55:39PM -0800, inwardvessel <inwardvessel@gmail.=
com> wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
>=20
> The current design of rstat takes the approach that if one subsystem is
> to be flushed, all other subsystems with pending updates should also be
> flushed. It seems that over time, the stat-keeping of some subsystems
> has grown in size to the extent that they are noticeably slowing down
> others. This has been most observable in situations where the memory
> controller is enabled. One big area where the issue comes up is system
> telemetry, where programs periodically sample cpu stats. It would be a
> benefit for programs like this if the overhead of having to flush memory
> stats (and others) could be eliminated. It would save cpu cycles for
> existing cpu-based telemetry programs and improve scalability in terms
> of sampling frequency and volume of hosts.
=20
> This series changes the approach of "flush all subsystems" to "flush
> only the requested subsystem".
=2E..

> before:
> sizeof(struct cgroup_rstat_cpu) =3D~ 176 bytes /* can vary based on confi=
g */
>=20
> nr_cgroups * sizeof(struct cgroup_rstat_cpu)
> nr_cgroups * 176 bytes
>=20
> after:
=2E..
> nr_cgroups * (176 + 16 * 2)
> nr_cgroups * 208 bytes
=20
~ 32B/cgroup/cpu

> With regard to validation, there is a measurable benefit when reading
> stats with this series. A test program was made to loop 1M times while
> reading all four of the files cgroup.stat, cpu.stat, io.stat,
> memory.stat of a given parent cgroup each iteration. This test program
> has been run in the experiments that follow.

Thanks for looking into this and running experiments on the behavior of
split rstat trees.

> The first experiment consisted of a parent cgroup with memory.swap.max=3D0
> and memory.max=3D1G. On a 52-cpu machine, 26 child cgroups were created
> and within each child cgroup a process was spawned to frequently update
> the memory cgroup stats by creating and then reading a file of size 1T
> (encouraging reclaim). The test program was run alongside these 26 tasks
> in parallel. The results showed a benefit in both time elapsed and perf
> data of the test program.
>=20
> time before:
> real    0m44.612s
> user    0m0.567s
> sys     0m43.887s
>=20
> perf before:
> 27.02% mem_cgroup_css_rstat_flush
>  6.35% __blkcg_rstat_flush
>  0.06% cgroup_base_stat_cputime_show
>=20
> time after:
> real    0m27.125s
> user    0m0.544s
> sys     0m26.491s

So this shows that flushing rstat trees one by one (as the test program
reads *.stat) is quicker than flushing all at once (+idle reads of
*.stat).
Interesting, I'd not bet on that at first but that is convincing to
favor the separate trees approach.

> perf after:
> 6.03% mem_cgroup_css_rstat_flush
> 0.37% blkcg_print_stat
> 0.11% cgroup_base_stat_cputime_show

I'd understand why the series reduces time spent in
mem_cgroup_flush_stats() but what does the lower proportion of
mem_cgroup_css_rstat_flush() show?


> Another experiment was setup on the same host using a parent cgroup with
> two child cgroups. The same swap and memory max were used as the
> previous experiment. In the two child cgroups, kernel builds were done
> in parallel, each using "-j 20". The perf comparison of the test program
> was very similar to the values in the previous experiment. The time
> comparison is shown below.
>=20
> before:
> real    1m2.077s
> user    0m0.784s
> sys     1m0.895s

This is 1M loops of stats reading program like before? I.e. if this
should be analogous to 0m44.612s above why isn't it same? (I'm thinking
of more frequent updates in the latter test.)

> after:
> real    0m32.216s
> user    0m0.709s
> sys     0m31.256s

What was impact on the kernel build workloads (cgroup_rstat_updated)?

(Perhaps the saved 30s of CPU work (if potentially moved from readers to
writers) would be spread too thin in all of two 20-parallel kernel
builds, right?)

=2E..
> For the final experiment, perf events were recorded during a kernel
> build with the same host and cgroup setup. The builds took place in the
> child node. Control and experimental sides both showed similar in cycles
> spent on cgroup_rstat_updated() and appeard insignificant compared among
> the events recorded with the workload.

What's the change between control vs experiment? Runnning in root cg vs
nested? Or running without *.stat readers vs with them against the
kernel build?
(This clarification would likely answer my question above.)


Michal

--kjq6t4ilt444tubi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8XIdgAKCRAt3Wney77B
SQlPAQCeynpWgAPt0el8l5KJlZ99IpKQrie9PgCZTQHF0ABO4QD8Di7HgP246Tve
151ZUABaRzz1VVGavOKpFTtGSx3YdAk=
=K93X
-----END PGP SIGNATURE-----

--kjq6t4ilt444tubi--

