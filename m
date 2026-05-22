Return-Path: <cgroups+bounces-16212-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKS1JWWAEGrdXwYAu9opvQ
	(envelope-from <cgroups+bounces-16212-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 18:12:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F370B5B76CC
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 18:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 620DF301702D
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E6337998A;
	Fri, 22 May 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cE6EXJ2P"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E13148D8
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466103; cv=none; b=B8g+q4IyKVds/it0/PAXgOvpG/Bsf5wlxX9aZ74T6IlEkdf5FNc+OK7jVY/BLoLY+q48G7BYZvpeQzMiK/ImLzMCrsFIct2pVv3+qvR+SipdHNVrEBhXPwnUPZsi8+pH63gXYijxFQicxUDmPFkfkVS30+0XdUxJgyScfi7vOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466103; c=relaxed/simple;
	bh=dgFcTwwHgZbu0ShW/XSgzvTFCf4IH5Whe+IwGXcKHms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxonubraMgoM2D0oTVi4zv/DBtWrv8cFvGq7r7TsrPypyAFEJ/059fb1EKKjpNEwNO6wUKoUIWjsOZGoOVgc3i4f6oeiN1/d7yctxJzJt+AhmbRIp0I6Hf6Ut8NHzm4dnGziv/oVE6++liP2jB6UhG5Z6NYmjMhVJXIYMkrpqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cE6EXJ2P; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so14560315e9.1
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779466100; x=1780070900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rU23XY7n5jv5JNpVtXVCjODWXeYBfaDkDfjvBRX0m2E=;
        b=cE6EXJ2PEAg4xWCzw1HCiJDSF8xOkbqcD02oTFs1uIM7gu5ADynhqED6NXfNQcK18u
         9qMsG1BJoZdbm4orpYXa8Xv1q7XaJuCVYKYqvuArjZMvCi0IgGgsmorrHEu8oW0G/fel
         i2shnJbRsv4ulzf4pxf7NvSSJyCivOd4bIW1+m9w9/B1KI9xGvGlqMexNwSWExDQim9s
         386BA+uhyVF8ApQ8INumz141rCtDj7xavFTEqdqA2utk7sX1KKuOTbPc/ClVkd/dVun3
         IbIJaQDMYSv8tL4ZIcQT9ceRHuQS0CUxNU4wYdrJnzy9nnEZ20zrXrYjZtwtFEYqdlKB
         wF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779466100; x=1780070900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU23XY7n5jv5JNpVtXVCjODWXeYBfaDkDfjvBRX0m2E=;
        b=RU4c5zc2qhWhNspd1wCKNNrZ7dNSiG5yvBQ66cArnAmcG2KGimBoo8Iwlj3o8bBd0j
         Q5VLwiWow6kf8lfTW4iaZDjxH3hmbLojS2+j2XJcUPY+cFQneW1ecEBsi0PwisSqNhPS
         jv3TDz65hqzBuz81s9smMtsc9JB/TF8CqFnX6yUUiPA3MYlcrnLedlMsl0JsNBDw+Xth
         YoKrGZD94rBwtJqILixJBfzXXNm/9OZ7qpYBWQEdzQN+6yN/os0CqmtasvY9oFaaLTb+
         Dgkdftqk+5F1b8Xojf5KXHyETNkSoBsquWENz1vv3CXt9XFCgaF+6I7jAJFLJTDIXzBD
         Nukg==
X-Forwarded-Encrypted: i=1; AFNElJ+cBntWxQSDji2k29dz+K8UBYdgpBgFtsHSw1xeH6rWOnjsQZ4BM9QpY5gTsYMVxUcC5oJiDlP8@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZCTzFiXrGDGncvQCy49fGdVqjMrivU3OEU6PqtbReqLz3MVb
	+kcXB5G2a2UQSW16KDGeZLxVKedApLEndOr9rQTZD3pSWdXlR7T2rlfC0hdyrvVOsgZno2AS6gn
	Ylk/l
X-Gm-Gg: Acq92OErHPW8/4kaS6+97uZzttVKPtdWPULC4H3aytncaLnCEP9ROx5+CCTs+PDVXvC
	44k8JqRBHo9cA2HZsulalT1X/IAWW+RbqL2rYZHFbNJZwolKCvNcl4QFfYwuy7SAQv5TnEodEEd
	1lIVjtwWYT331nBzWQHZNJLTXNY3TXTO1wIweW/HMJV6xo+96O4QWM1Fn3kc2paAfXKfiSkFmLV
	0VWEZmTIGtt9MPIPZPOvp4ADdf67sH9ff56+BdmTIwgGCFGXAQ0Nrj6wAF+IqYyCMHhTQdd7rME
	S0aLhfxC8dMeO4MoI1EPrRA5efttbUMYtW8kgbAGUvuAv7xJHfKqnEk0qylXoAfEsatqTFveGlC
	g0eA5cZTWn2x9kVdaKte/J06OXqGsXg9UsbgReAdXNTyoks5olR/adg9wRgzJ2C1RbxuO0WKvVZ
	ENYXsc9kjCZkRLiS/HrLwhTSDZvqmn9kvghqxtN0PZcm+S+d17zrsG56k64dA=
X-Received: by 2002:a05:600c:8a0a:20b0:490:3ec9:8711 with SMTP id 5b1f17b1804b1-490426cda2amr46625325e9.18.1779466100500;
        Fri, 22 May 2026 09:08:20 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490469f61b0sm13807065e9.5.2026.05.22.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 09:08:19 -0700 (PDT)
Date: Fri, 22 May 2026 18:08:18 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cgroup/rstat: convert rstat lock from spinlock to
 rwlock
Message-ID: <ahB7dSLFZp3_9Kcu@localhost.localdomain>
References: <20260519173134.1486365-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ndjsbbbdcldyger7"
Content-Disposition: inline
In-Reply-To: <20260519173134.1486365-1-thomas.falcon@intel.com>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16212-lists,cgroups=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: F370B5B76CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ndjsbbbdcldyger7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] cgroup/rstat: convert rstat lock from spinlock to
 rwlock
MIME-Version: 1.0

Hi Thomas.

On Tue, May 19, 2026 at 12:31:34PM -0500, Thomas Falcon <thomas.falcon@inte=
l.com> wrote:
> @@ -414,7 +427,7 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys=
_state *css)
>  		struct cgroup_subsys_state *pos;
> =20
>  		/* Reacquire for each CPU to avoid disabling IRQs too long */
> -		__css_rstat_lock(css, cpu);
> +		__css_rstat_lock(css, cpu, true);
>  		pos =3D css_rstat_updated_list(css, cpu);
>  		for (; pos; pos =3D pos->rstat_flush_next) {
>  			if (is_self) {
> @@ -424,7 +437,7 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys=
_state *css)
>  			} else
>  				pos->ss->css_rstat_flush(pos, cpu);
>  		}
> -		__css_rstat_unlock(css, cpu);
> +		__css_rstat_unlock(css, cpu, true);
>  		if (!cond_resched())
>  			cpu_relax();
>  	}


> @@ -717,11 +730,11 @@ void cgroup_base_stat_cputime_show(struct seq_file =
*seq)
> =20
>  	if (cgroup_parent(cgrp)) {
>  		css_rstat_flush(&cgrp->self);
> -		__css_rstat_lock(&cgrp->self, -1);
> +		__css_rstat_lock(&cgrp->self, -1, false);
>  		bstat =3D cgrp->bstat;
>  		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
>  			       &bstat.cputime.utime, &bstat.cputime.stime);
> -		__css_rstat_unlock(&cgrp->self, -1);
> +		__css_rstat_unlock(&cgrp->self, -1, false);

I was wondering where these distinctions of readers vs writers stem from
and here I see that it's mainly the per-subsys vs rstat_base_lock.
Given that cputime_adjust() is here only modifying the local bstat
value, the read-like lock makes sense.

However, there's still the cgroup's flush right above which would take
the per-subsys locks in write-mode anyway.
Can you add some more explanation why this works?

More generally, I'm wondering where are the opportunities for replacing
per-subsys lock with an RW lock (or seqcount).

Thanks for looking into cpu.stat scalability,
Michal

--ndjsbbbdcldyger7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahB/bhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Aj2vwD/XhOVsLGNHHeMHlUYshr3
5m/WFWsTx45yB2kgTvVqEpwBAKpWlMeU2J7pwzelKK7NyxLTvfcqZ9vZnDn2EDP6
FP8L
=eRJj
-----END PGP SIGNATURE-----

--ndjsbbbdcldyger7--

