Return-Path: <cgroups+bounces-4955-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A13C9878E9
	for <lists+cgroups@lfdr.de>; Thu, 26 Sep 2024 20:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09B51F21945
	for <lists+cgroups@lfdr.de>; Thu, 26 Sep 2024 18:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17512165F19;
	Thu, 26 Sep 2024 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UIF7QQB7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7315FCE5
	for <cgroups@vger.kernel.org>; Thu, 26 Sep 2024 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374218; cv=none; b=WtKbXKhYgdAw3V09Ir4/ZmsYjfFcMa3hS5MI+L5peLxSUai45bPkIt67ekgHWn23mpoArWl2KJBJD5Vy8HIGxhPcFLcP5b3ZmcJ3mmROzoCwZSGSvi7KHvuy68wPjQmoF7NUfrXGuSfmSUl1w/q2vp4EPwn7+oOCcML4OLt0Kr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374218; c=relaxed/simple;
	bh=qpVU4XxBpLxpVoXpPAGlozVOH5+EVpvozVpRmm79Z30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbBohhIg9TkUEqb+oNbkYSf/Qi4AtYMr/tG7q9SDv+PLb53UayGb8UVHUvLfWhdH+MHbhei66aCLvinqBciUyue6t9eZZbpAWIEvSk7xK3HsiMQWKjn/BV88hVEMiFMiCovNddb78zRuUfjPH5MoQqih+LYTvBee6bfT73cPnqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UIF7QQB7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7aa086b077so172904066b.0
        for <cgroups@vger.kernel.org>; Thu, 26 Sep 2024 11:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727374215; x=1727979015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdLUqsRCgKs9xu0yc5QAq44cfc/XbnINgvpnk0KSrKU=;
        b=UIF7QQB7DlJMY+XWeGj40Vk+FCghvKNqq3JvBnuTBpdMP9mYk6lgwqGVCbTx7CdQca
         XNc4TdKfWDUFBs8eUI5ETyGA7bA+QHF0oT+OK4p4EavoFwDtchtp92dKMZ7N6imezmGo
         tCMEx4ToENa1znyrYCxFiSZqPm9hoLKcH8T4bfEvndylaSD5DUEdgsUjomKRFCQCgHj0
         sYfcxjq84qesc6LeyDK5GvrWXl54k45uoOu0vm7RRqhoiua1YIiPvXtjh1QhuGoTjkU0
         RSdmZi4PcuPRptWtxLUJaPXVPhjoLZgm6P8G/rvsYxwSAQ9IsMVW20/i5Pjm50GTRc6w
         +MVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727374215; x=1727979015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdLUqsRCgKs9xu0yc5QAq44cfc/XbnINgvpnk0KSrKU=;
        b=ZM1aQJbfI02w0kryOiRgo2bRuZ8AZbGuwjikq2gup4Mxw+xD3xHJvlZUUC/rC7KTkQ
         0MJoB50SpGW19SylRwVVXmC56Mr5U5tyjT93Z+EE21XnfW8hjIx3emttzNHssLQaltW4
         PnPCDg7RRwkaSBdG0kE9zYUtbHyUsfglZiNICcLMJF8j6syK4YHzJDfcHiB8uyuI8s4k
         Fm6SlZNaE0Kci/sUx/efdWAvKohoqW+vg14JDgir6JSda2frRzGbWzbNofPrpFspW83S
         l5DnLo7d+x5FiANaVRrps9Rf4500zBQj+KfyrJqABozS/IJN6zK+Zmc3AdG8NqjeBvDc
         MQkA==
X-Forwarded-Encrypted: i=1; AJvYcCX/E0Ow6T7Xam1IP8zoxok+KI6Q4kYsKQz4h/J47WvTrBJ355JLfZy7tujFsolpn7KcsEDdDCzC@vger.kernel.org
X-Gm-Message-State: AOJu0YxMb1X0FaZ4SLudyyKn43cJrt1XPAzTNYwlYXqdEl5/wXm96oah
	SYdX3qDBvyuL8FSpUyRtWQTu9UACZPAJOahryABPn1r3kOM/iBgmWVotrTQyEtqq8m3pjNir1FG
	dWoU=
X-Google-Smtp-Source: AGHT+IFniY8fmaUhZ/fnujb4SqS4NPVhEDpJ1jgTM0BVn+LDEqv2jyzNVfGZ7xDl1iKSQOvNI8Ys0g==
X-Received: by 2002:a17:907:9444:b0:a8f:f799:e7db with SMTP id a640c23a62f3a-a93c49180a3mr38338966b.16.1727374215173;
        Thu, 26 Sep 2024 11:10:15 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2948fd6sm23625566b.101.2024.09.26.11.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:10:14 -0700 (PDT)
Date: Thu, 26 Sep 2024 20:10:13 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, lizefan.x@bytedance.com, 
	shuah@kernel.org
Subject: Re: [PATCH v3 2/2] cgroup/rstat: Selftests for niced CPU statistics
Message-ID: <xmayvi6p6brlx3whqcgv2wzniggrfdfqq7wnl3ojzme5kvfwpy@65ijmy7s2tye>
References: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
 <20240923142006.3592304-3-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t2f3kmuusie7grq4"
Content-Disposition: inline
In-Reply-To: <20240923142006.3592304-3-joshua.hahnjy@gmail.com>


--t2f3kmuusie7grq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2024 at 07:20:06AM GMT, Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> +/*
> + * Creates a nice process that consumes CPU and checks that the elapsed
> + * usertime in the cgroup is close to the expected time.
> + */
> +static int test_cpucg_nice(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	int status;
> +	long user_usec, nice_usec;
> +	long usage_seconds = 2;
> +	long expected_nice_usec = usage_seconds * USEC_PER_SEC;
> +	char *cpucg;
> +	pid_t pid;
> +
> +	cpucg = cg_name(root, "cpucg_test");
> +	if (!cpucg)
> +		goto cleanup;
> +
> +	if (cg_create(cpucg))
> +		goto cleanup;
> +
> +	user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
> +	nice_usec = cg_read_key_long(cpucg, "cpu.stat", "nice_usec");
> +	if (user_usec != 0 || nice_usec != 0)
> +		goto cleanup;

Can you please distinguish a check between non-zero nice_usec and
non-existent nice_usec (KSFT_FAIL vs KSFT_SKIP)? So that the selftest is
usable on older kernels too.

> +
> +	/*
> +	 * We fork here to create a new process that can be niced without
> +	 * polluting the nice value of other selftests
> +	 */
> +	pid = fork();
> +	if (pid < 0) {
> +		goto cleanup;
> +	} else if (pid == 0) {
> +		struct cpu_hog_func_param param = {
> +			.nprocs = 1,
> +			.ts = {
> +				.tv_sec = usage_seconds,
> +				.tv_nsec = 0,
> +			},
> +			.clock_type = CPU_HOG_CLOCK_PROCESS,
> +		};
> +
> +		/* Try to keep niced CPU usage as constrained to hog_cpu as possible */
> +		nice(1);
> +		cg_run(cpucg, hog_cpus_timed, (void *)&param);

Notice that cg_run() does fork itself internally.
So you can call hog_cpus_timed(cpucg, (void *)&param) directly, no
need for the fork with cg_run(). (Alternatively substitute fork in this
test with the fork in cg_run() but with extension of cpu_hog_func_params
with the nice value.)


Thanks,
Michal

--t2f3kmuusie7grq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvWjggAKCRAt3Wney77B
SXAPAPwLI2zDUVdxqbLYo39+smefNll+tXGO41EZkNjzc/aAmAD/cC0yuzrf+NQ/
v/jEJxSx3OpRtUzyq9zehnGulc5RhgA=
=VLNq
-----END PGP SIGNATURE-----

--t2f3kmuusie7grq4--

