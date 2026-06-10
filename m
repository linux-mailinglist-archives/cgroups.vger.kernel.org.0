Return-Path: <cgroups+bounces-16804-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qgJQIHJmKWoBWQMAu9opvQ
	(envelope-from <cgroups+bounces-16804-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:28:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7451D669B9A
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:28:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=RZXSgILB;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16804-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16804-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C03C7300728A
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD3E408622;
	Wed, 10 Jun 2026 13:28:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F9E3E1694
	for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 13:28:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098084; cv=none; b=IlrLXXA+hgDZPqqvrPv+qv0fh527V7o3i1Tbi0j0Jkerlp9ahArEwKq5RzhgOTdDhq869QBpUX1mGMxCOXy9/E0KA2u0N2jyDAikL2hNYoh6ZjDuuWz5wSHuofCZvNmFLpeJUfmSXcX6rRg6N5DJIISobbl7oLuim4kK2vhBaUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098084; c=relaxed/simple;
	bh=HS+FH64zLQNsudHDz3jLULxZEOQWVWpRd3c3zpAQ0BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVrV2l7XDOEJH3kxSgf3ezEo83Ex41qX2TYdHq5GEtcxsis9vJIG1OvXDelR1IsiuakZNgDQvN4RFeR/rbpwaF9jE4cMf4NPuCCVdnNAB8Pu7m2V8Pc5n+ICRtlYmRNBW8jevMLqqJSl/kO8sRPgQ/T70kIAVxbB3jz/d3s0FmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RZXSgILB; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490d1e54b3bso30390405e9.1
        for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781098081; x=1781702881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=efd1Ki3Xll6aAtagX/sOTYLRXZ/KBI1Zi4co95bvGTw=;
        b=RZXSgILBBxZo2aE+M1XC+AfreYJo4MF3wB5A/LQ8K3/nkxG2avNXfXUrM2UeNESmro
         jpCKPZN5Fiqc3viV6DkWKVrGhpY7WoLvxyJOfIWcN3PUTgVK3m60A5LLkQgGW29gLAZr
         uY5CW/8lDJM9fc/HPKkth3baoxLiv5BPFX9c/VffKLKTR6e+HTziND+gnX5FrVkoKb4S
         UhBMJjOSlKUhHwot2nNYtuMgPcE8pPleQ4QfcgMufpxRMQPvgWYFl91K5weM8Z96YvAA
         j9jyxd93OeZg/fEhQK8U0UbJsG1AwTrhd1zY1kvQl1csxGI6pym7i7YYO+xIewbCnA7a
         6Lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098081; x=1781702881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efd1Ki3Xll6aAtagX/sOTYLRXZ/KBI1Zi4co95bvGTw=;
        b=jQ/8krcmM6KabRj5gGon+/wrNwRU3TcO/7q6jGnCs2sAonm+yMMF8y6krmqMMMPmng
         mWepH8Q2W9fn8AgwfagPO1nYH6vRXDQ1+PFcwTuA4JWLAUM/PlbCxYQXB7/Ty6U5SdLm
         w/+57Uh9Ds/H6ZJ9fyBbQMVlSb74H/AsVwR2C0KL7o6YdISBlXvtr5WWSOX7oVM2NKD3
         4jQwJF5agpTIhomreas0A4DExBVKeZs25Ylw6fL+c2Y1mjeNCBv+WAkG8LwSqIygjwgs
         fF3Z7EQuJsFN7rEJBvL0yPYl57BochnJrnfevpyL2dM+se1cLpDrsRGdjRlrCVaAPygv
         wo0A==
X-Forwarded-Encrypted: i=1; AFNElJ+LwHs1qlvhVPyKWOiyQIzxFAw9WkvbEMUJMo9Cq1/OBNUNvLf144ZG/WwDNdT2+uIJJg5XIlp5@vger.kernel.org
X-Gm-Message-State: AOJu0YzgzHLW/y/V8w8CVl/oAvqYuk9KnMJAwBGpAepsftQx4SrC+W2P
	/71jpfN4gIV7xF7zcdAp6uCnE3FistSJbxdZSl053F+X3VDXx2Eu+f13eax9//OIpbY=
X-Gm-Gg: Acq92OGAGH6dR4074DIp5c5NvNlwRRqG6i2HV9132cHtUz8rlOeP2EAEyQvgk4KTLnr
	2nVMc5zqymiYJQp4AhudbK+3Km9nbegQQsNoF5Ol5odyhhJrO1U0olOruDWa6tSoIA7qmZWXtXl
	eknA7T4egEQYdQEl3npi6d25w5Q9Yv1jA9ceSzZ0MD6p6wYKE1QZlhDgC+ztCw1XMUf+7OxCrB+
	X/5H+MLUw+ss9T/sSq3jCA4ar1pkIkWSxRV8Z3jXas+HHUDdz28JzBLAY3A3tdKkIesoJBMO/XN
	o1MahoTzZHYVLDEfbKKdgPWi+2QfAH1ol3FTvpGRwC0k8qdtnLn6Wf1o+blqcTEQBj/SNHoqRvu
	qWd+j8YNSUZFkcSC1laq7J1VOsWSV3Rf4V+mw0LLAUEh1G5lX6nUyrfJDRUofSGyc82A9ixpXp1
	58XtzzI5Z8pfLw4q1LMevfMkuwTGI2V1uQPfcQhRs=
X-Received: by 2002:a05:600c:5248:b0:48f:d612:3c4a with SMTP id 5b1f17b1804b1-490c25604demr402628155e9.1.1781098081015;
        Wed, 10 Jun 2026 06:28:01 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39e024sm754067145e9.4.2026.06.10.06.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:28:00 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:27:58 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Longxing Li <coregee2000@gmail.com>
Cc: syzkaller@googlegroups.com, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Kernel Bug] INFO: task hung in cgroup_drain_dying
Message-ID: <ailmCVEqnnQZ7ClA@localhost.localdomain>
References: <CAHPqNmxGfjsKGEJJaSCrJqoU9WHY3q8CX1oTA7GV5BBHvDzgpg@mail.gmail.com>
 <aigMzVNsQpz_J0oQ@localhost.localdomain>
 <CAHPqNmwdh5Je=hrvEVzK90j91h2kOqXDmF1vz9UTtfcn1LUO1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w4tp5jy54e7czoz5"
Content-Disposition: inline
In-Reply-To: <CAHPqNmwdh5Je=hrvEVzK90j91h2kOqXDmF1vz9UTtfcn1LUO1A@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16804-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:coregee2000@gmail.com,m:syzkaller@googlegroups.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:dkim,suse.com:from_mime,localhost.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7451D669B9A


--w4tp5jy54e7czoz5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Kernel Bug] INFO: task hung in cgroup_drain_dying
MIME-Version: 1.0

On Wed, Jun 10, 2026 at 03:11:41PM +0800, Longxing Li <coregee2000@gmail.co=
m> wrote:
> sorry for not containing full information in last email. the config[1]
> and report[2] are as follows. CONFIG_PROVE_LOCKING is not enabled in
> our config.

Thanks.

> INFO: task systemd:1 blocked for more than 143 seconds.
>       Not tainted 7.0.6 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:systemd         state:D stack:20616 pid:1     tgid:1     ppid:0
>    task_flags:0x400100 flags:0x00080001
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5298 [inline]
>  __schedule+0x1006/0x5f00 kernel/sched/core.c:6911
>  __schedule_loop kernel/sched/core.c:6993 [inline]
>  schedule+0xe7/0x3a0 kernel/sched/core.c:7008
>  cgroup_drain_dying+0x1ed/0x360 kernel/cgroup/cgroup.c:6294
>  cgroup_rmdir+0x38/0x300 kernel/cgroup/cgroup.c:6309
>  kernfs_iop_rmdir+0x10a/0x180 fs/kernfs/dir.c:1311
>  vfs_rmdir fs/namei.c:5344 [inline]
>  vfs_rmdir+0x340/0x860 fs/namei.c:5317
>  filename_rmdir+0x3be/0x510 fs/namei.c:5399
>  __do_sys_rmdir fs/namei.c:5422 [inline]
>  __se_sys_rmdir fs/namei.c:5419 [inline]
>  __x64_sys_rmdir+0x47/0x90 fs/namei.c:5419
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x11b/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Hm, hm, this kinds fits 93618edf75383 ("cgroup: Defer css percpu_ref
kill on rmdir until cgroup is depopulated")=20
which got into stable 7.0.9.
Can you reproduce even with that (or newer) kernel?

Michal

--w4tp5jy54e7czoz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCailmWhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ai+RwD+KgjxjaFYvdaedvEs/Vba
72UxvBJX1p8Drk7TVCmg79MBAMhMnWaO7V+jqBFg3SUY7mXWwWtLU7lfL3JAzJLw
v40B
=LwIs
-----END PGP SIGNATURE-----

--w4tp5jy54e7czoz5--

