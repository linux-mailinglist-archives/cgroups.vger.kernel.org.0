Return-Path: <cgroups+bounces-17185-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cdX2OiGQOmquAAgAu9opvQ
	(envelope-from <cgroups+bounces-17185-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 15:54:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D676B7A5B
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 15:54:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=ADOSpobz;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17185-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17185-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 580C130D8FC6
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48A737E317;
	Tue, 23 Jun 2026 13:52:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E037E2EB
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 13:52:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222756; cv=none; b=Vi7noo2a6+8XU+fymmTHrb0d4u0L6G0s0H1BPl0DP0PbAEjsRAjhOvYai3NuoxjznKbdnFOY9mG//9vcLx4EXvHDbCu8Nu3++4n/cq9kanZ2loxTAFQxGTu6EaX8fBtntGmSRNBQ3Z6SLg9pd4aru89Y5W3Wm8rSdKyl0CBg9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222756; c=relaxed/simple;
	bh=qQDzdCIM36hTAqOEAnWir+7wrUqqW1kd9jhGVeFV15I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsjWH8azOkHjqZTXj65OfZFpimFtW+oAmaNJWbEjfxHkxqBII6Krp9ieCKmnMtjIkZG+bBMY5jq68v3yYhDpA73+HdUpYE9z5JA8y44BlKg1e4wd3hVRDfJrtAedwTcMwXmOaHyDSI5J7kTOAYYu0AgNC5F7xb+IsWOZ7u2eJEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ADOSpobz; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490ac357c55so61256325e9.1
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782222753; x=1782827553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PHObhepawfnCQqRNz4R+JkWCcyuhA+vOquuYLNzbdAc=;
        b=ADOSpobzjcEHMkYS/sXIZQVl12XUJxZyCde6NbG569ry62GsvfZJQbNIabmCIXW0c6
         WTjV7ynnXngK/dxEitSDCKJbdG7zjJv2XH1NLDpXqs2XZexUN0Q22p8Yx1FZXv/uoT9d
         T/ixCXEyGiH7t7+cr94+LJYCD6Xjp3vOAEgNXyrP2DfWeBwRa8BoRojdKIZJ0SALOY3V
         SLqj00yV936CMBQZecJ2hXJ9Sx/vC1Q21TWGjMYiQADpE8K7Ja7H+PwVlfLVOvJkMGN3
         lpIKPP+H92mjgMti9Af3DKaF74AAGaxkFBqyaKGotAGSuknI1/YH6vk/y6vaY2xiSB+n
         nTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782222753; x=1782827553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHObhepawfnCQqRNz4R+JkWCcyuhA+vOquuYLNzbdAc=;
        b=a5g+Hi8XCLJOTHJ9DSiBfFnDehR4PxtjruLuvDF7VPWVabJ8dA6YnNT8pRo3sPOeO4
         W3kaC58MYvaNuJnpg1o0NhTF12Luom9+Hqtd1//BXvCzDm13Jhfje38Et63cX+9B1ElI
         u2YOUhZgKhqIWcysNPbVuKdpPx+qrzZETE8lzMchZPNasvudnD2KJRV+Fd4UiSExaZ84
         ZEf2SMqoL+O5lK3v0u3QwqvXfX/RBfFAurpaSnl1Y5cL+H5yzwWfHDcvVM75e96/6zn/
         NuqvCnYSKYxD6iJlBiOc/lOya4qIPO8qii150Unf8t2VPInT++0mEeAQGD+ZAxBTHpjy
         lk3w==
X-Forwarded-Encrypted: i=1; AFNElJ/Sah9xYVQThj43bHGNaCDDHoGh5/UjUm9YiO1mmURCSA97nzs+L0HlgBovUEk23nxe7ZZ8B0KN@vger.kernel.org
X-Gm-Message-State: AOJu0YwXnKMEcOLGYTHIOs9/n2OIe6SryTcOJ28xkkhFXKvsvapjRgIQ
	oWR76WrveSXPnLqrzCSKmZClttdDOzhFjNSAd+U8KkLnBGirP4A4ZwzCj0iEuE6uJiea6A1K2Fo
	yvY7ypwg=
X-Gm-Gg: AfdE7cltiHTV7KY7gsfCQPbWaH7vrkb0eex+3GKPzwyN7WAciGv1i8IIZ72KmNZlu02
	YB0q0pzNhXyeo8W7Dy++rjLWcv7zA8Q6Zr7NfOaFjBl8a1vTWH67XTAQjXDfHRh29gEv2G9OvaN
	WgtE5KidGz+X+YVaxfDLvCsOllUl0l8/hiDc18NCxCti22Opniywef/kFwJhGfoHSYQ2N7a7vsX
	zxm/cIjOE0ifQVfy1Wo+UhW61T5ole9UYeAdr/B1fqNMzMOmDloEF0e+PMgHL5XyhusB0XZr/Ec
	CLaM4L1lvoewPsLjTNU4H7qHtmfJdOHQpyRrVblBlA2lva2/oAXHE9mpIeFJ1ShNIrUYK+UQ4Br
	6IwZDnNoHuFTGC02TnemmCraVlVYPECK52xR5kiXFvLR2gROEymL6Y8E2nixmxFBH+FV9QazPyS
	YW8q8BBVevuf2wyEwwFA==
X-Received: by 2002:a05:600c:1d1e:b0:492:4ca9:a46d with SMTP id 5b1f17b1804b1-4924ca9a4e8mr212679495e9.5.1782222753308;
        Tue, 23 Jun 2026 06:52:33 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd15470sm438068605e9.2.2026.06.23.06.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 06:52:32 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:52:30 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Joe Simmons-Talbott <joest@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH v2] selftests/cgroup: Adjust cpu.max quota based on HZ
Message-ID: <ajqBjmJ-VT3UDPMr@localhost.localdomain>
References: <20260622194305.601392-1-joest@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xyyzzujscooqtqev"
Content-Disposition: inline
In-Reply-To: <20260622194305.601392-1-joest@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17185-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS(0.00)[m:joest@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebastian.chlad@suse.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,localhost.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50D676B7A5B


--xyyzzujscooqtqev
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] selftests/cgroup: Adjust cpu.max quota based on HZ
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 03:43:04PM -0400, Joe Simmons-Talbott <joest@redhat=
=2Ecom> wrote:
> +static long
> +_get_config_hz(void)
> +{
> +	long hz =3D -1;
> +	FILE *f;
> +	char cmd[256] =3D "zcat /proc/config.gz 2>/dev/null | grep '^CONFIG_HZ=
=3D'";
> +
> +	f =3D popen(cmd, "r");
> +
> +	if (!f)
> +		goto out;
> +
> +	fscanf(f, "CONFIG_HZ=3D%ld", &hz);
> +
> +out:
> +	pclose(f);
> +	return hz;
> +}

I like that you voiced this dependency on CONFIG_HZ and also that
_SC_CLK_TCK is useless in this regards.
(I see that BPF selftests have similar infra for this.)


> +
>  /*
>   * This test creates a cgroup with some maximum value within a period, a=
nd
>   * verifies that a process in the cgroup is not overscheduled.
> @@ -646,7 +669,8 @@ test_cpucg_nested_weight_underprovisioned(const char =
*root)
>  static int test_cpucg_max(const char *root)
>  {
>  	int ret =3D KSFT_FAIL;
> -	long quota_usec =3D 1000;
> +	long hz =3D _get_config_hz();
> +	long quota_usec;
>  	long default_period_usec =3D 100000; /* cpu.max's default period */
>  	long duration_seconds =3D 1;

I would not bend the tested value but it's expectation (so that
approximately same quantity is tested acroos configs).

I reckon the problem might be tasks that overrun the quota due to long
tick, fortunately, we can assume this is compensated over multiple
periods, so _on average_ quota should be honored (more) precisely.
But the test duration may be not well aligned with all the compensation
periods, to that must be accounted for in the expectation.

When I write it all down, I get this:

--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -651,7 +651,9 @@ static int test_cpucg_max(const char *root)
        long duration_seconds =3D 1;

        long duration_usec =3D duration_seconds * USEC_PER_SEC;
-       long usage_usec, n_periods, remainder_usec, expected_usage_usec;
+       long usage_usec, expected_usage_usec;
+       long n_periods, spread_periods, unaligned;
+       long tick_usec, low_usage, high_usage;
        char *cpucg;
        char quota_buf[32];

@@ -687,9 +689,16 @@ static int test_cpucg_max(const char *root)
         * the cpu hog is set to run as per wall-clock time
         */
        n_periods =3D duration_usec / default_period_usec;
-       remainder_usec =3D duration_usec - n_periods * default_period_usec;
-       expected_usage_usec
-               =3D n_periods * quota_usec + MIN(remainder_usec, quota_usec=
);
+       tick_usec =3D USEC_PER_SEC / hz;
+       /* Up to tick_usec (over)run is compensated over multiple periods */
+       spread_periods =3D MAX(1, tick_usec / quota_usec);
+       low_usage =3D n_periods / spread_periods;
+       high_usage =3D (n_periods + spread_periods - 1) / spread_periods;
+       unaligned =3D n_periods % spread_periods;
+
+       expected_usage_usec =3D quota_usec * (
+               unaligned * high_usage +
+               (spread_periods - unaligned) * low_usage);

        if (!values_close_report(usage_usec, expected_usage_usec, 10))
                goto cleanup;


(I neglected (and dropped) remainder_usec because it is zero with
default values)

However, not all preemptions are tick-based, so there'd be noise=20
and one has to tune the values_clone_report(,,err) anyway.

Then to reduce noise, the simpler solution is to let the test run
longer

duration_usec =3D duration_seconds * USEC_PER_SEC * 1000 / hz;

(where 1000 is the CONFIG_HZ=3D1000 where the test runs sufficiently [1] we=
ll.)

Joe, how do to the two variants above (unalignment account and prolonged
duration) affect test_cpu behavior on your setup?

(I'm personally wondering what is bigger quantity: systemic error due to
HZ quantization or random (SMP) error.)

Thanks,
Michal

[1] Even there one runs into noise depending on nr_cpus, thus even that
    fixed err=3D10 is not ideal.

--xyyzzujscooqtqev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajqPlBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjYkwEAkanTs6Oe4Wq8RbfJGWwj
wfOgF9zepsGbVUE/9eQ+9FkBAIPJFLYaGnMSkGMcL8dWTL+iRmaz7E8a+o4mmZjT
mKEM
=5cZS
-----END PGP SIGNATURE-----

--xyyzzujscooqtqev--

