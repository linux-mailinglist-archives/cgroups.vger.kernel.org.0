Return-Path: <cgroups+bounces-1835-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2657867A3E
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 16:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D831F2436F
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C5D12AAEE;
	Mon, 26 Feb 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qiHqOP8l";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b2FLq7ww"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDC219E3;
	Mon, 26 Feb 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961309; cv=none; b=JtOX2EUSCy5tdkaGrVc2UuD0+eJAKJebo0RC1TZSKDWujai6QRaqGigz5JY7dSuexByesFETn1+P1uOgy/FgCVwy6EaN9oT59MrHZhk6knN3m6JM1zmrYIXbdgN6H3LWZsUPqWlHxhl3PmS9u0PSCSVYpu/9sWAza5XX30iVWe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961309; c=relaxed/simple;
	bh=eITRa6/dNliWbYSQG0MqgGYZZFqc07AifDCVVZZDKK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3zjQe4jUxI4/obNeNxIgDUju0D4YDkEmgmNOMzFaAAQV0OPty58Eqi3Lt1ipxUd+4U6NPvM2GmsrEAmoQdBtjSaerDwu8lDyQPO7afynDC/cITDeUkR2MM8vY22Ji2YlUuUx8T8DlGBeCtpVktSwEIwMTVcg7G2Du/PRiVx6io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qiHqOP8l; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b2FLq7ww; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0031225CA;
	Mon, 26 Feb 2024 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708961306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qL2shtSe0WTJwYJugT1JyXRoQHJ5+B/iJUmAXE1O4c=;
	b=qiHqOP8lAAdRJmDR9/ScJ1aNBrgFj2AQi18FTYKkkfgks0eU5sPN8R4njbDlMsGyfyiPZm
	0mLQ2f689eFzU9WNY7U/4mNfy2ffumI9mZGGxY33ZcDpvChvPiTspwgNlDJVL7CkdIXB3O
	f2MsFbnjrl/aTEDBYr3QqnukALa0SPc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708961305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qL2shtSe0WTJwYJugT1JyXRoQHJ5+B/iJUmAXE1O4c=;
	b=b2FLq7wwz4tKaGoupw+8/bcv88zvY/14jI3062jmlBiC2sTsq9z03g0Sl3azKDDu8H7FkB
	llaXbffqGkfAHAz+Gc7yUh+W8Q1fMnv+i96Th1cjmpMUzUOW7Oo6PRpr7Nxm06WLeMGLAL
	/lBh6z837PzYYhWYHPNz7W2AF2PJaVs=
Date: Mon, 26 Feb 2024 16:28:24 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: introduce CPUTIME_FORCEIDLE_TASK
Message-ID: <pb7jf52x2qpofgttzz3fphkeiuxuamjbjqb64paw7dvvtv2sxd@mgcol2syra6z>
References: <20240219084134.10673-1-CruzZhao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cwh5t3gx4dedreqm"
Content-Disposition: inline
In-Reply-To: <20240219084134.10673-1-CruzZhao@linux.alibaba.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.08 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[16];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 R_MIXED_CHARSET(0.63)[subject];
	 MID_RHS_NOT_FQDN(0.50)[];
	 BAYES_HAM(-0.00)[19.37%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.08


--cwh5t3gx4dedreqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Mon, Feb 19, 2024 at 04:41:34PM +0800, Cruz Zhao <CruzZhao@linux.alibaba.com> wrote:
> As core sched uses rq_clock() as clock source to account forceidle
> time, irq time will be accounted into forceidle time. However, in
> some scenarios, forceidle sum will be much larger than exec runtime,
> e.g., we observed that forceidle time of task calling futex_wake()
> is 50% larger than exec runtime, which is confusing.

And those 50% turned out to be all attributed to irq time (that's
suggested by your diagram)?

(Could you argue about that time with data from /proc/stat alone?)

> Interfaces:
>  - task level: /proc/$pid/sched, row core_forceidle_task_sum.
>  - cgroup level: /sys/fs/cgroup/$cg/cpu.stat, row
>      core_sched.force_idle_task_usec.

Hm, when you touch this, could you please also add a section into
Documentation/admin-guide/cgroup-v2.rst about these entries?

(Alternatively, explain in the commit message why those aren't supposed
to be documented.
Alternative altenratively, would mere documenting of
core_sched.force_idle_usec help to prevent the confusion that you called
out above?)

Also, I wonder if the rstat counting code shouldn't be hidden with
CONFIG_SCHED_DEBUG too? (IIUC, that's the same one required to see
analogous stats in /proc/$pid/sched.)

Regards,
Michal

--cwh5t3gx4dedreqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZdyuFgAKCRAGvrMr/1gc
jlQ2AP9lHZzRmJGKHC/PArhq58TYH4bO31Cw8QJyLzpMB6/oOAEA7GubxdNMgkf8
rKxYVNUeG+tzvQedlpfiWwD+Ql7RTAA=
=aTWv
-----END PGP SIGNATURE-----

--cwh5t3gx4dedreqm--

