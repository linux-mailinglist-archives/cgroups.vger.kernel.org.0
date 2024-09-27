Return-Path: <cgroups+bounces-4977-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F988988C36
	for <lists+cgroups@lfdr.de>; Sat, 28 Sep 2024 00:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3267F1C210F3
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 22:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85CF18C024;
	Fri, 27 Sep 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8d4K7nq"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C315A862;
	Fri, 27 Sep 2024 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474474; cv=none; b=oat5tTDoa/QxagznIc0HqNZ1il7ZxfLHIAR2FkZtMdSdLx6G1aodbOn+SBvWIQdgNYw5GW7cZho2o+GK7q5KCtoiPNmMX4MJRoLTsp+zmwej3zs/vXI8hKAtFvxkpPdsawdZCiSVHTSCy3MPtFIT5Wz47siMcr9ChxV6+uKaCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474474; c=relaxed/simple;
	bh=9X0fzPXpuWY6uETermwFXp9kKFGKXlOJI12bjA1yJX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzKxRSmMXNypGeMB9c6GmdpGNG56R6Yo78vJCZItGkOi9tR5b7h8Yd8fs0FZ+6PUJKktIHQEk8t6J2aos4lD9hduBO2UA6abT6NpI7tc2ZnzOJCrXl2VNO2S7CIyGzsT3x35WdaCe1Kcal8nGc6bKbFaikTXkLKv7Mxj5rym4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8d4K7nq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727474473; x=1759010473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9X0fzPXpuWY6uETermwFXp9kKFGKXlOJI12bjA1yJX4=;
  b=X8d4K7nqlF5hzWK1UjHE/fmuLQ7zr7ThR6KKh0SZ2fxSmkrHi5cV9kqn
   ASIddT9FJvXDGDoC3Y5rm8aa4Z5bJfxR7IoSYZZp9n1k3fDfAEBfJp2ny
   07mcIKey02JZLd5cAa3iDxrvCx9QVDuO7LIAej8UxdtEtM/TVFS07XNT/
   ynga8Y3E1nMrkofRiYqXXAcRLNJmx7NIOJKI2PdRJLkZ3RN8WIaLdDeHd
   GRhYomSVNFd83aEycM61AeIJHXR2oylVpMFPEn38Mpu0kDahBKgxNiSj0
   CiIrykDk9I6btaBa95nvt7EuwtoQ0tCtD3EFB5NOi1qexcinDB54OKtVH
   w==;
X-CSE-ConnectionGUID: QaX1WJk9R4mz2LGKQmRytg==
X-CSE-MsgGUID: eqet00APSrKWUY4DHdH+Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="52048356"
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="asc'?scan'208";a="52048356"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 15:01:12 -0700
X-CSE-ConnectionGUID: +Y7PZjtRRWGcXjPEgfmMaQ==
X-CSE-MsgGUID: gmm8GACARMyI1yyGqSrfXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="asc'?scan'208";a="110146848"
Received: from cmatsuo-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.237])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 15:01:12 -0700
Date: Fri, 27 Sep 2024 15:01:04 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Kaplan <David.Kaplan@amd.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] Selective mitigation for trusted userspace
Message-ID: <20240927220104.f7lgj6h2shjgcr35@desk>
References: <20240919-selective-mitigation-v1-0-1846cf41895e@linux.intel.com>
 <ydu5mlvvvizkadyspu52afbdoyjq7akyx2665l3zit2tj6cs3s@4edufjodwmbu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhb4rgc3473jqtpo"
Content-Disposition: inline
In-Reply-To: <ydu5mlvvvizkadyspu52afbdoyjq7akyx2665l3zit2tj6cs3s@4edufjodwmbu>


--xhb4rgc3473jqtpo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 05:52:35PM +0200, Michal Koutn=C3=BD wrote:
> Hello.
>=20
> On Thu, Sep 19, 2024 at 02:52:31PM GMT, Pawan Gupta <pawan.kumar.gupta@li=
nux.intel.com> wrote:
> > This is an experimental series exploring the feasibility of selectively
> > applying CPU vulnerability mitigations on a per-process basis. The
> > motivation behind this work is to address the performance degradation
> > experienced by trusted user-space applications due to system-wide CPU
> > mitigations.
>=20
> This is an interesting idea (like an extension of core scheduling).
>=20
> > The rationale for choosing the cgroup interface over other potential
> > interfaces, such as LSMs, is cgroup's inherent support for core schedul=
ing.
>=20
> You don't list prctl (and process inheritance) interface here.

Apologies for the oversight. prctl is indeed the interface that Core
scheduling uses to group tasks. Cgroup was the initially proposed interface
but that later got changed to prctl.

> > Core scheduling allows the grouping of tasks such that they are schedul=
ed
> > to run on the same cores.=20
>=20
> And that is actually the way how core scheduling is implemented AFAICS
> -- cookie creation and passing via prctls.
> Thus I don't find the implementation via a cgroup attribute ideal.

Problem with prctl is that a process can't set its own skip-mitigation
status, unless it is privileged. So a privileged process has to spawn the
workload that needs to be unmitigated. This is not ideal for an application
that wants to selectively apply mitigations.

> (I'd also say that cgroups are more organization/resource domains but
> not so much security domains.)

Agree.

> > - Should child processes inherit the parent's unmitigated status?
>=20
> Assuming turning off mitigations is a a privileged operation, the
> fork could preserve it. It would be upon parent to clear it up properly
> before handing over execution to a child (cf e.g. dropping uid=3D0).

IIUC, skip-mitigation should be a capability that can be inherited by child
processes, or can be set for an executable file. If we want to leverage
Core scheduling, it will be callenging to have all trusted processes in the
system have the same cookie. But, all child processes of a trusted process
would inherit the skip-mitigation status and same cookie, so they can be
co-sccheduled.

--xhb4rgc3473jqtpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEhLB5DdoLvdxF3TZu/KkigcHMTKMFAmb3KyAACgkQ/KkigcHM
TKOnfRAAgAKoG6u8MXYIXEsDzXvbjK5Rt4Absjt1c6cMJBTIUHwPjtojrVWt0nmu
eH9v5ANey4LcZBbNa++2wTF1tTVtsNyyivHVgyKOqpB0zpKcwE7WtGyVnNi1Olle
Scit2Wtv0XmjwcoOpQvaDhub2InhzF/ttg+AGADrLZ5vnFQJF+/h6/4IEv7801Lu
PQU2aOjqodrE3f6T4CzS8bBn+YXYPiQzIzN8G1XU61bjCnTxntpwKksnHLCqVPhC
CjHDY8RwnwMCsszA9x5dVrNFiUYdFC0TyAvZwNBl1I5RA87jfWzhtKmdlqkHNpRA
0dC1RFUreRpTIKxY4kjtR7yxj1z55MMl+mX8TCYpmbD+TwZHKm87vG2n5X44EvxN
O2fixmlyIomcRD+iQ62sCVP6AL3qpPJcc1Cyrkyib6wQRFarrUy5KEUAOcvV8mek
f3jq24DdvtqRto2gCK8OvE8CpRdmqCuhhJGcxQLAXJ0Ps8l7O6xsiDFa8NKg2C7P
kbPUg+QYfvoyYKBkWOt60zz1KnJsGRZO1LMqQEwnGgUnrG+q1YxphnygteJBV/Ay
l2rhHREbaI2HPyyilWP73X6qkUwTJJaaeItxG8n18Fj0foFgU6w2CciZTHZx7Qhx
JqXeLjrGJy6jXhXVLXehIlkBoMJjKGEVUTsZ6/jw38XKEOtgbxE=
=RIGu
-----END PGP SIGNATURE-----

--xhb4rgc3473jqtpo--

