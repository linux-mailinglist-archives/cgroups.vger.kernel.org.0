Return-Path: <cgroups+bounces-8751-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E5DB08DA3
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 14:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F7B7BAF54
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 12:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E62D77F2;
	Thu, 17 Jul 2025 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RyXngj54"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7812BEC28
	for <cgroups@vger.kernel.org>; Thu, 17 Jul 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756981; cv=none; b=iw150bs8B1CoBBHM7zTTGD5o1Z63vSClooGKU833vZa2X6+NuUBaeMHiibk+aMxNqgdCG57wkqrfQSiwYbmCuzILm3uBxEzDVI+RJZnv4YQJXPAYgM+r4gZG07XG3o8SLmDX0Y3k5534ka/itHBqWTDG6QsxDF+l+M+S9wAzjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756981; c=relaxed/simple;
	bh=5C68isv16CT0CTBNXFFoBkmNFftxlWs2cMLo/GtIm0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEubdgyDYBZ0en4oWHAZTu7GH54qM7KfWlFzd6KNuQFqIHWeHa8XbQ2A0h0Nz6BoWipytm+vbTURllO5gUUrkirp07AwCwdsUvLgD6J92GH42GLOAPZDK/3P6KG0SUO7uuN5X6UGcH7n6l7Z2DMjmG2NHY2Xr+hJjs3kqUM1VWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RyXngj54; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acb5ec407b1so153429166b.1
        for <cgroups@vger.kernel.org>; Thu, 17 Jul 2025 05:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752756976; x=1753361776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WxaYrBDTVkKxfQbbC2Gba/aI7Id05pjU0f5koQSOkMA=;
        b=RyXngj540rAKNbNcyBykmgND9Ax+MQhbqPoAUpR8WyGpIlaAt1Ydtwr8NYdDAWbaFx
         T1xE6Li6jwYR+aj4GS985x2+Bjkp6smr3Eavx9gvAWL8H5rimkgqjfUvAqMEzBCo5K9b
         GFV/SW5dEJoJRAr+NBVYt0xxOOz6yDfeCZteSo7VIe5cYIa9cN0VrD1gpKrMHXyWXztG
         lDwuJ3HwP/ZvNahNwNXuW9akJ51VPIJjzsEaVwWv+Zu9fgjhVEyWPWVN+hMGfmA7UIQg
         sC/QP4S3Zr1yzGRSHaT2D/FsOqwZWsjcrs9vBkD/7Xlmsedtsr5KjKIg5goUmC/VbwK8
         CtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756976; x=1753361776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxaYrBDTVkKxfQbbC2Gba/aI7Id05pjU0f5koQSOkMA=;
        b=kT8bnQ+wug4m6zEJ+xrnuOJDEMaE6azPcn9FPgmUo61q2Ce6R1pzgDOheOmjg2q1wJ
         zHKk5xx+UFxgzAvgytXGKiKtQCtLtlFeQyLR1rduyr8wOAz38d2+mWxo0SvtNSHRf+nY
         d8SEzDmPD4C8uslQHQJv3Xu1YQAv2t1H6oYm5fmxrrpECxWGSTNELYlSTqdIkzPcU6gc
         wMq52D3CwDlQJe8mHk0inNTk1z3g5GHTHN9NbcX+w4AJ/sYLrks8U5livfl/RqJa3Q5p
         HJqPoD2YnGTPfyO5W4tY06ml3gW5cpt4sewDc9KWun8dCxwuB1U9sFWn03n//t2KhVPh
         aUSA==
X-Forwarded-Encrypted: i=1; AJvYcCVIVuxZ1P9avgfnqWxO2g/+5xdt4RsH6+BiPx75UBluXiKKHEG1ooFsE09iVTi+QI8RHYoXH321@vger.kernel.org
X-Gm-Message-State: AOJu0YwrgbKiuoQzWzoAj4Dx2wE+tB++7vYMJJTq2Dh8YdNrvD5ze7x7
	9SFSxTtcxqlP4xlhRPlPbP1rRVi+EqlUYXCjGxEvJgz+Zg7BRuzBv0LIND9KpNwTizk=
X-Gm-Gg: ASbGncuv6ogtjCUn+cHACuNByIUxMs4y10+hKekW5kZi7rMRyI4PZ5/aftzhHksmruL
	hWasQXV0Pv4dWLW44wqug2/2zl+IiXhE1a3XGXlzNvUOCPCB1+6CJWcliHi6+ud2c+hR8ZocWWy
	iaTZEnuoX72A9TORKqdiLnxmtU/A3SzkiR6ge0MzQoAkl9tCnEFdM43SLg85fl1M7XH/hcQSVxx
	lsRq11ogkl9aYyad0T3v3jdpo8OHgpa9lUyZJxiYsO8lyFUgbfwnuksun6URUoQ9EaeFHwgMJvp
	T6iCyp/qa2OXycIOjdYihSWGnMmv1a1HzCPIRIdoTfyy5NYW51a8f/K74KIIQjYNrBQZsXZ6SQB
	GNUey79iqCBJ7ThdH7ClQmUYokxSNZ5/dg0Anjd72jQ==
X-Google-Smtp-Source: AGHT+IGmCGE/i+JFILHa3yjqtTV+kluEfiMhkPeizaGTvt5XqMP2gjydr2tNH35RxMZLV0xAGbCITA==
X-Received: by 2002:a17:907:3a96:b0:ae3:cb50:2c6b with SMTP id a640c23a62f3a-ae9ce0b930emr443038966b.38.1752756975732;
        Thu, 17 Jul 2025 05:56:15 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82e3a8csm1366209566b.154.2025.07.17.05.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:56:15 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:56:13 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, kernel-team@android.com, 
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
Message-ID: <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
References: <20250714050008.2167786-2-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q6g6m5syrpxykbo6"
Content-Disposition: inline
In-Reply-To: <20250714050008.2167786-2-ynaffit@google.com>


--q6g6m5syrpxykbo6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
MIME-Version: 1.0

Hello Tiffany.

On Sun, Jul 13, 2025 at 10:00:09PM -0700, Tiffany Yang <ynaffit@google.com>=
 wrote:
=20
> Other sources of delay can cause similar issues, but this change focuses
> on allowing frozen time to be accounted for in particular because of how
> large it can grow and how unevenly it can affect applications running on
> the system.

I'd like to incorporate the reason from your other mail:
| Since there isn't yet a clear way to identify a set of "lost" time
| that everyone (or at least a wider group of users) cares about, it
| seems like iterating over components of interest is the best way=20
into this commit message (because that's a stronger ponit that your use
case alone).


> Any feedback would be much appreciated!

I can see benefits of this new stat field conceptually, I have some
remarks to implementation and suggestions to conventions below.

> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1018,6 +1018,14 @@ All cgroup core files are prefixed with "cgroup."
>  	it's possible to delete a frozen (and empty) cgroup, as well as
>  	create new sub-cgroups.
> =20
> +  cgroup.freeze.stat

With the given implementation (and use scenario), this'd better exposed
in
  cgroup.freeze.stat.local

I grok the hierarchical summing would make little sense and it'd make
implementaion more complex. With that I'm thinking about formulation:

	Cumulative time that cgroup has spent between freezing and
	thawing, regardless of whether by self or ancestor cgroups. NB
	(not) reaching "frozen" state is not accounted here.

> +	A read-only flat-keyed file which exists in non-root cgroups.
> +	The following entry is defined:
> +
> +	  freeze_time_total_ns
> +		Cumulative time that this cgroup has spent in the freezing
> +		state, regardless of whether or not it reaches "frozen".
> +

Rather use microseconds, it's the cgroup API convention and I'm not
sure nanosecods exposed here are the needed precision.

       1    _____
frozen 0 __/     \__
          ab    cd

Yeah, I find the mesurent between a and c the sanest.


> +static int cgroup_freeze_stat_show(struct seq_file *seq, void *v)
> +{
> +	struct cgroup *cgrp =3D seq_css(seq)->cgroup;
> +	u64 freeze_time =3D 0;
> +
> +	spin_lock_irq(&css_set_lock);
> +	if (test_bit(CGRP_FREEZE, &cgrp->flags))
> +		freeze_time =3D ktime_get_ns() - cgrp->freezer.freeze_time_start_ns;
> +
> +	freeze_time +=3D cgrp->freezer.freeze_time_total_ns;
> +	spin_unlock_irq(&css_set_lock);

I don't like taking this spinlock only for the matter of reading this
attribute. The intention should be to keep the (un)freezeing mostly
unaffected at the expense of these readers (seqcount or u64 stats?).

Alternative approach: either there's outer watcher who can be notified
by cgroup.events:frozen or it's an inner watcher who couldn't actively
read the field anyway. So the field could only show completed
freeze/thaw cycles from the past (i.e. not substitute clock_gettime(2)
when the cgroup is frozen), which could simplify querying the flag too.

> @@ -5758,6 +5780,7 @@ static struct cgroup *cgroup_create(struct cgroup *=
parent, const char *name,
>  	 * if the parent has to be frozen, the child has too.
>  	 */
>  	cgrp->freezer.e_freeze =3D parent->freezer.e_freeze;
> +	cgrp->freezer.freeze_time_total_ns =3D 0;

struct cgroup is kzalloc'd, this is unnecessary


--q6g6m5syrpxykbo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaHjy2wAKCRB+PQLnlNv4
CH7EAQDY/o6R+lacKfz1+91E3EVQCP4sdVNh+dNpbxVSWafRfwEA5NxSlz0R5PDl
pbF5wGiWALd3rY8lxnwtBYZjwJODJAY=
=sEiS
-----END PGP SIGNATURE-----

--q6g6m5syrpxykbo6--

