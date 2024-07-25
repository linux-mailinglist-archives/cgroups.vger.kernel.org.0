Return-Path: <cgroups+bounces-3892-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E391193BF2D
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 11:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B231C20D98
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 09:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0982198831;
	Thu, 25 Jul 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NkpYvZVZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82365198830
	for <cgroups@vger.kernel.org>; Thu, 25 Jul 2024 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900317; cv=none; b=NgiInfbC27o9VaDySyIDI0jVdUac3CUu/6zGY2YldNEThBP+tT1wOamFfJL77rRv80GFkRtSAuo4GQCYkpBhR3/ALseqnZoGAQnDtAwur6dE21BplO8XbS9KplrlCW04Ztaxspxc+BTYQnkDw9XiWvmgpgph+O0tQpqs+SH2OPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900317; c=relaxed/simple;
	bh=hb9nkF2epFQFHjaDtYLTuSh5dWNP8eOlbA6nvUSQKwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oARJwL72bl8LHiqHrpSQm0OQYbjUC3qDY3qi2adJwdsGuXdtfigztgSnzqMcO4N9bQpZvYwZX/iqfzuFfiddaiqJcdskfY77IceeLgqOwddVIGuCvwOB8xODVTE7np25t/uWZm2qjMrcKRQRPAaK0VgzoXSna8ErO/WvxwjTr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NkpYvZVZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so47847866b.2
        for <cgroups@vger.kernel.org>; Thu, 25 Jul 2024 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721900314; x=1722505114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oW2kUzY/zrUY3o3SxhYU0xffCdGPSOZ86O2BpsusKg0=;
        b=NkpYvZVZTTYiHJOVSvVF/DH4wjuyXWXv6Mnx/Yok6FIHhNwwfcFVwv5ZEo5rJm+g6o
         xZzfJtUYPLHhcP4EPPo7mQ+6CpH3cdNnZMXdTUF6+pnJD3YZGpBXlYWXaxCS4ZEi/Gtp
         b3900cN/QnDISXI6Z/gQ8eSyBaJcVnXfS+xRspN17BM3nwQEcJZ3+gpm0c7aFp92K7pe
         8HfdHMG7G0PRzFPmTDofvLbFGRqWVfXP0aPXxXUJ5KAiAiHStqkTx1cdM7/8Bgze45eV
         PMBp4/LD1ixPP8K6TWaQqwoKiCFcknamATCLDm/QgCkLlAui/0hs9UZxJzkDCLlamRAI
         73Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900314; x=1722505114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW2kUzY/zrUY3o3SxhYU0xffCdGPSOZ86O2BpsusKg0=;
        b=aVRbLLPriAwOqWT1XB+6+3DBs3j7AqY1E4dbmJsSV9QtSj252eHrCDOEHUgAEqxhYW
         uLHLn8e99XUEUEHTltpZ1tCO5tq/ElabJXYsqgEOsOzEHZRwPt8Xcgzf62BE0hNU5WwC
         KIJ4vWWUTyhFQqlq98jTohnAqqrqjs2jyzxVaGEr3EL1GO4nNzy1yDXfBHCyHtKHEhmK
         8+RgDEoD36bXn67RpTzJOMPvoV9fYWgzvmdF8CmWd0WBA15QnNjOz9rI/GYAzcn33U3K
         ERcs09sXBqDCV1CGghDC/vVtYMtEuHgL1+l56uwGrylklm1nAvNY8HGCBEsJDMaW+XXm
         XJAQ==
X-Gm-Message-State: AOJu0YwzwpZOPAIn6fCsJxPhzne0pbK4UT8cLQC9dsqLegJDKVZtD5bb
	7LSejVO8U9XZL4GD9HQgLNqz4kr/FRRrYbu6RmF0ApsdW+YiHlJbPTr5KwNwN2Q=
X-Google-Smtp-Source: AGHT+IECWpI5VnoSqnkn5P0EW43K3U3vSJvnZ8eWqaDqIzUWXmrhMeFaRkO1vIkoocBUmFGFlXDnzw==
X-Received: by 2002:a17:906:c145:b0:a7a:a138:dbc1 with SMTP id a640c23a62f3a-a7acb3f02e1mr107001066b.20.1721900313753;
        Thu, 25 Jul 2024 02:38:33 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4116fsm52574866b.103.2024.07.25.02.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:38:33 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:38:31 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: xiujianfeng <xiujianfeng@huawei.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v5 2/5] cgroup/pids: Make event counters hierarchical
Message-ID: <hs3oag7blyg5kkdu6ikbw7f6hefkdfk2qgqqnpothq7yx4qsts@gv2v4dbpfmv6>
References: <20240521092130.7883-1-mkoutny@suse.com>
 <20240521092130.7883-3-mkoutny@suse.com>
 <f124ce60-196e-2392-c4a9-11cdcacf9927@huawei.com>
 <cb0efc16-6df2-72b7-47ea-ce524d428cc1@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q37u4k236h4pzrv7"
Content-Disposition: inline
In-Reply-To: <cb0efc16-6df2-72b7-47ea-ce524d428cc1@huawei.com>


--q37u4k236h4pzrv7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jianfeng.

On Tue, Jul 16, 2024 at 11:27:39AM GMT, xiujianfeng <xiujianfeng@huawei.com=
> wrote:
> On 2024/7/3 14:59, xiujianfeng wrote:
=2E..
> >         for (; parent_pids(p); p =3D parent_pids(p)) {
> >                 if (p =3D=3D pids_over_limit) {
> >                         limit =3D true;
> >                         atomic64_inc(&p->events_local[PIDCG_MAX]);
> >                         cgroup_file_notify(&p->events_local_file);
> >                 }
> >                 if (limit)
> >                         atomic64_inc(&p->events[PIDCG_MAX]);
> >=20
> >                 cgroup_file_notify(&p->events_file);
> >         }
> > }
> >=20
> > Consider this scenario: there are 4 groups A, B, C,and D. The
> > relationships are as follows, the latter is the child of the former:
> >=20
> > root->A->B->C->D
> >=20
> > Then the user is polling on C.pids.events. When a process in D forks and
> > fails due to B.max restrictions(pids_forking is D, and pids_over_limit
> > is B), the user is awakened. However, when the user reads C.pids.events,
> > he will find that the content has not changed. because the 'limit' is
> > set to true started from B, and C.pids.events shows as below:
> >=20
> > seq_printf(sf, "max %lld\n", (s64)atomic64_read(&events[PIDCG_MAX]));
> >=20
> > Wouldn't this behavior confuse the user? Should the code to be changed
> > to this?

Two generic notes:
- event notifications can be rate limited, so users won't necessarily
  see every change,
- upon notification it's better to read the event counter/status anyway
  to base a response on it.

But your remark is justified, there is no reason in this case for
"spurious" event notification. It's an omission from v3 version of the
patch when there had been also pids.events:max.imposed (that'd trigger
events from D up to the root, it's only internal PIDCG_FORKFAIL now).

The upwards traversal loop can be simplified and fixed with only
PIDCG_MAX exposed. Can you send it as a separate patch please?

(Apologies for late response, somehow I didn't see your e-mails.)

Michal

--q37u4k236h4pzrv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqIdEAAKCRAt3Wney77B
SdzDAQDFHxjJt2JJhI0O9L5Frx7c6tdltnSjJD5lGd6xbuWuKAD/bywRNtDNhUNw
boPmBSmMastkeBVP03nYhqm1kBlneQY=
=o/0c
-----END PGP SIGNATURE-----

--q37u4k236h4pzrv7--

