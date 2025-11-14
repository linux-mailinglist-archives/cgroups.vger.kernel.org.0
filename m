Return-Path: <cgroups+bounces-11963-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E86C5EB5B
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 19:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F8FB380AE8
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A083451BB;
	Fri, 14 Nov 2025 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y/eRjNgj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E652346768
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142524; cv=none; b=s1mJpp15mb0hIGfZCzVHaEPTkuhStTZretT80/YZShHnGgOwh1A6xu/oFkAMiJoy4ZpLuwxz/6+ZZ+vbKYN9lRrmDNZ4K4CLlpMFzlFMWeYbSz7opRBurzGgQ/4tBThUCgcFJVRfgvBOV8n8rLl0NLNwAt6mP7tnTJW3MqsMNVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142524; c=relaxed/simple;
	bh=7V+XeZgw3ANN77+vPCxu6yzaCB1t8ks/x0sHCapzNrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0QonQGkHL5v4GNsefqGZu/8pFtOsGOHwMiFCmPYapXLff0xxfml7/5mvrF63vnWjPaxPaqAqWoi4mzB7ybEjdj43oYcM1x9gO9tEmth3RrD+kG4JePkJof0t36fVyasOg9vYDFA4ReKvZjiaZbJ/IbQyfMbML9jWg2JAV/t39I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y/eRjNgj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477549b3082so19234625e9.0
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 09:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763142521; x=1763747321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VTMQPJoV4ZgBH6Thg3JMd1LwLz0NHXt6GDT5LGUd8Vs=;
        b=Y/eRjNgjr5RWaKm+hvLZRHCir+oozc5O4zYxXmXHAd51Mq8NecvZgCtT6C1WoM5P8r
         Fc3XbuGmo6wQpoix6yFPxKkgDJEJ/alAmGXsxUN7pUA741TJCieGYXDvC1W8WeVY8XQc
         T56KE3pNKt7/FPQujPObwhrb+0txp9RDH0QftBSqRfq8JemQDXayfJKxvVYyxaVZR3Xr
         cuaA0xVOKAxSUOWrgq+TBS+JUdGQd+oZEAGRfhDwqs53p5VOR1ewgzXGom3aTkt+e3XN
         FWmEQEU7P02aZKunOpI2Fjv+GeWWd9MuBhcKrkreu2CpcGcgdvZyL9929PXEZ7vEU4UP
         GHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142521; x=1763747321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTMQPJoV4ZgBH6Thg3JMd1LwLz0NHXt6GDT5LGUd8Vs=;
        b=M+rNUdYt8Mhzw/OhO5AFI3cfpwuQzX91/xdwPkiPE4AYo1jfsvYMiClNvftKJg7Ido
         I2oVQly+qW7/myg+xI9epYMwb+s8n1Oqb6OMqlhLSlJiF6Sq8U0TivXakB9/36hg1/GC
         qCa+2iF0UUG3zuHDmK286XGR/s2XcdVNzuGWUoafmfCcFu1Dm+MHsBqXO5BUP8e4NM0I
         rRzVF2mMS/D8FbNG/6PikZNyMbgxgXf1yuceTZaQarxkT6QH96wx12zeIgCHSQdoAM6I
         XpGgX78sFb4e8Cib3ihKrsDeKfR7EYxp5LBUD2htiFe6AhLQ1kRUb2Fy00Gi4JcXL1Od
         mD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsm9Tx3SipIAfdtA55abRWdZIMvT5lLUGCL/VePYcdGksU6vddRrFnqAzka6B/aZEdx5KkyII/@vger.kernel.org
X-Gm-Message-State: AOJu0YxnypZRu6ly1ZJmI55SLfSTl3f/ZPKm19gzhxpyiMwHzGKRrDR+
	0xawgPIeXeOulFrxmQEm1/nBDLLfUcZmU6zWhLHUtV+ml7yELbK6RG2sQFmfu5vSwZE=
X-Gm-Gg: ASbGncvxHEWAkluVvgw4FHqJhJEOwLLykcdfdcq016Ss/SEuSuB6ok+QXHZUNqN5tQ5
	/3Y9kLiWE1i9W/81y1y6cq65HITTZnZfg4AmK24UQLuB7n3V/2CCjj74ySrCAUSlY/WOqkXwU7a
	BhKQe00P1hLCHZZiZyMmQkX9wRY0gu4Svmpx2bBTcsrI1NrC/XlpE7K3UpIQo7aWQZ3Lc/b8Pus
	YioDTGaplebsTLid6vl9gHzMlSAsni0DK1CmNkiMNHO4vMJw1h50Lrd5ZBX0eAGzTaRSpCycN1x
	5kXbLZ1N7NExD7ydybCb+tyhSrjddoeDMhkQ5ROqYNT9OtWbo1FmK4GRgT+yf2ipDvrJgklBQZr
	KgP5wlD2FtBHcOoYzeON9oexZZKVS8AdAO3LmCCcoFQjdjFp2jJ9NWDbi6mhPExdDde61Fi3jkr
	zyHwqEplZrGMZuSFCqqBHS
X-Google-Smtp-Source: AGHT+IH2xud28gYZ+H62Z6lkklRfg/TIad9tpaWDZW3kXUS1Y4xxjzGN1y6b5Rw7PdKjNP3p2x01oA==
X-Received: by 2002:a05:600c:548d:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-4778fe51db3mr38596455e9.2.1763142520765;
        Fri, 14 Nov 2025 09:48:40 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477952823d3sm19291225e9.11.2025.11.14.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 09:48:40 -0800 (PST)
Date: Fri, 14 Nov 2025 18:48:38 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <dschatzberg@meta.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 3/4] cgroup: Defer task cgroup unlink until after the
 task is done switching out
Message-ID: <wrcmeb2ooxyr5ygix4xy5j4gffb3oke4tcgjv3zdjfvhykoasg@splg4qifdxxo>
References: <20251029061918.4179554-1-tj@kernel.org>
 <20251029061918.4179554-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ul2jo6dszlc6rslz"
Content-Disposition: inline
In-Reply-To: <20251029061918.4179554-4-tj@kernel.org>


--ul2jo6dszlc6rslz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/4] cgroup: Defer task cgroup unlink until after the
 task is done switching out
MIME-Version: 1.0

On Tue, Oct 28, 2025 at 08:19:17PM -1000, Tejun Heo <tj@kernel.org> wrote:
> When a task exits, css_set_move_task(tsk, cset, NULL, false) unlinks the =
task
> from its cgroup. From the cgroup's perspective, the task is now gone. If =
this
> makes the cgroup empty, it can be removed, triggering ->css_offline() cal=
lbacks
> that notify controllers the cgroup is going offline resource-wise.
>=20
> However, the exiting task can still run, perform memory operations, and s=
chedule
> until the final context switch in finish_task_switch().
> This creates a confusing
> situation where controllers are told a cgroup is offline while resource
> activities are still happening in it.

(FWIW, I've always considered it impossible to (mm) charge into offlined
memcgs. Alhtogh I don't remember whether anything _relied_ on that...

> While this hasn't broken existing controllers,

=2E.. so hopefully not.)

>=20
> Split cgroup_task_exit() into two functions. cgroup_task_exit() now only =
calls
> the subsystem exit callbacks and continues to be called from do_exit(). T=
he
> css_set cleanup is moved to the new cgroup_task_dead() which is called fr=
om
> finish_task_switch() after the final context switch, so that the cgroup o=
nly
> appears empty after the task is truly done running.
>=20
> This also reorders operations so that subsys->exit() is now called before
> unlinking from the cgroup, which shouldn't break anything.
>=20
> Cc: Dan Schatzberg <dschatzberg@meta.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/cgroup.h |  2 ++
>  kernel/cgroup/cgroup.c | 23 ++++++++++++++---------
>  kernel/sched/core.c    |  2 ++
>  3 files changed, 18 insertions(+), 9 deletions(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

>=20
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 4068035176c4..bc892e3b37ee 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -138,6 +138,7 @@ extern void cgroup_cancel_fork(struct task_struct *p,
>  extern void cgroup_post_fork(struct task_struct *p,
>  			     struct kernel_clone_args *kargs);
>  void cgroup_task_exit(struct task_struct *p);
> +void cgroup_task_dead(struct task_struct *p);
>  void cgroup_task_release(struct task_struct *p);
>  void cgroup_task_free(struct task_struct *p);

"Hi, I'm four-stage process, you may remember me such callbacks as
css_killed and css_release."

--ul2jo6dszlc6rslz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRdrdBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ah5xgD6A1MLrMhxe8DkMTE6H4Ec
S//OOnd8AWbJP2Lw1LN17U0A/iYN6bny8iWy2XZcdySr7UzWZ4/t6pe3oSHlbXke
AigP
=FkM3
-----END PGP SIGNATURE-----

--ul2jo6dszlc6rslz--

