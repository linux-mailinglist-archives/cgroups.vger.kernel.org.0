Return-Path: <cgroups+bounces-11962-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6814EC5EB04
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 18:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DD8E4E0F97
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 17:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B58346761;
	Fri, 14 Nov 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gYtvMqya"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3698346767
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142504; cv=none; b=P1ygTrS0t3ktADuPThrAP2v6IvvEtZTUSy/1+qfuTFr7V0d5Gg06R8BTF3rtxaAXRAa8Dd7+SiMiIhSjmIwiZpKMjUWEunlf8KdlJMQ1nAH0T9cks1Yf4Mb1ASzi4BnXmdTGnOuJG0cOKx3F+UIW2NvKa3MM3yLu62WYplA7UsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142504; c=relaxed/simple;
	bh=adgZ6OK/I9H/U8sQcgAcMsvimT/wOtV4kBOT9ZAu4RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUl6Vhjw6tigl8sCQxUu1ncp+izEELvqUYAEeqwu3kAHZL+rIH+wap4IjHR+oVA+LwblvxsdgBWg5CR01NaX1O0BGEvM/bmAVH3KHB2uUVzLEvTxD9E992Nr2xlK34Rc28d+OGxm5CkhqG0wsSJ474yCpTAdnG5kHgggQX2YrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gYtvMqya; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429c82bf86bso1272707f8f.1
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 09:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763142500; x=1763747300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=adgZ6OK/I9H/U8sQcgAcMsvimT/wOtV4kBOT9ZAu4RY=;
        b=gYtvMqya0ZUlXzUc+Nw5sIVVD6E7Maw6rxcKXBBMaMZ5GAgpgSPleddZ8lnz+JE/m0
         WggghavSm84iXbyyzpbaGoK9cJBczE2sMlw51rR429/4dbmIEycas9Of9FhItRgSOyNG
         mQVBBtV4J5mpPPMbFdjwPBP4VIVmQlHuMT6i/r3QrzKQnnQZqXnqYux7/WTQP9CX4zQX
         0vL9J1f+kk+P0y9K805VkYqlnnZoV2QA2HeMGS0Ire7EXwtoCtEnZsizqKzAx+VU4ION
         M6+sURvk4tewurdIZW6yu8jqafpMS2JLw+fehRdaxbBxvPyHgtH8WQRuEQpjVEpbJWrm
         Iq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142500; x=1763747300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adgZ6OK/I9H/U8sQcgAcMsvimT/wOtV4kBOT9ZAu4RY=;
        b=ivkTKc2Cz+Fe29kq4/qNlutaqnpfoKCmCLkxUbk5x3ygilKkaboffAgQenGzb84L2b
         K8JgJyZybzfOf6guf3rZjoIok4ajm2eXXSreMDQvzRFezOlGfN9H+TVWxb7rzJJ6P9yY
         6vFkBjWBsMObo//tym6/0O8FutKKK0MYEm6XJtFsjS123efTQjdhG92aE2Ts9R7EB9eQ
         T1EiVKKF5eiDtMhKTIZUswaRsuLe6llwUje7WQNjNmOYut3eexkSd1BlI8hqzJxHHUng
         1+8gtRM4XkNNBoFcXYJrcbfKmlKvjDdi/AXuCFDnq4pLSD5z8YbGrq8RIjx0u5PnXUFR
         RwVA==
X-Forwarded-Encrypted: i=1; AJvYcCXxIhV4onRaIPLfUsJ51tA2lD7RXi5PVOPf5zpp4B8Ym6vzC5+7T9yknmynXX1EHp0lUFmQXwiS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Esh0BKg1eX8cderH6lKiGKRhQbROmoUiJRnDrzlJ8iKziwER
	5qIrP9EzYtnSHRJO6q658fK13Scl0cO5gkA9Y8TkNGjIxb0k3YFjC7cvnuu5+BVgRf0=
X-Gm-Gg: ASbGncuMxeWIbOdEGVkVqQHn1ts8sjq50GxH/67UfDShysawQiKGiOKcV8+S3qrNUEC
	tSe4rFCAnxNhKvjjynw53Jk+UcdyMICac47ggxF6Gwce7KlHZBHEKuNejIQIM/eKeNxMt8zZmJY
	Dj77LS7uBI1mGece5/Vq0+lxvV/IP92GdaZ0fYD0qtPLR5K7xbb0iU4sVFr6+432O6DvV8J5KBG
	lkAAzQ5uujQ9D858paVN8CXGSDbra0vrYn0LCNEouRTKj6lNlYTOo/SueYO1BfnV9diNiEcnwTR
	i088SWl28LSf0cemlSUGF9cSsKYHNWWhbtwUf3e4xZu+uXzj1WQVULfSmoW3xx6FSMzsf+MTV2D
	76LzFbyYrOAz/1sgfKFLCGJJ5H0JrWDyKxV0Lc2epukYmLxridk3Q0pQkBHVUlfr4OhbgBcHpvH
	EYgZtikpYpYPt4gXC93Xgj
X-Google-Smtp-Source: AGHT+IGfqZxTVDZTeDBSihyOagzRQuVA2NQSR8GN+UiOM9xyyrGY6jNAtOzIVK8gI8hxZWVnxLGQAg==
X-Received: by 2002:a05:6000:4383:b0:42b:3c8d:1932 with SMTP id ffacd0b85a97d-42b59345301mr3744589f8f.23.1763142500182;
        Fri, 14 Nov 2025 09:48:20 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm11658313f8f.17.2025.11.14.09.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 09:48:19 -0800 (PST)
Date: Fri, 14 Nov 2025 18:48:17 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <dschatzberg@meta.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/4] cgroup: Move dying_tasks cleanup from
 cgroup_task_release() to cgroup_task_free()
Message-ID: <acjwpiayukusza5tybuhg7edwu2hjea3vpopxgukoc7pqc4d2s@qtcptnu44vyf>
References: <20251029061918.4179554-1-tj@kernel.org>
 <20251029061918.4179554-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3kggvokzmyvkuvuk"
Content-Disposition: inline
In-Reply-To: <20251029061918.4179554-3-tj@kernel.org>


--3kggvokzmyvkuvuk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4] cgroup: Move dying_tasks cleanup from
 cgroup_task_release() to cgroup_task_free()
MIME-Version: 1.0

On Tue, Oct 28, 2025 at 08:19:16PM -1000, Tejun Heo <tj@kernel.org> wrote:
> Currently, cgroup_task_exit() adds thread group leaders with live member
> threads to their css_set's dying_tasks list (so cgroup.procs iteration can
> still see the leader), and cgroup_task_release() later removes them with
> list_del_init(&task->cg_list).
>=20
> An upcoming patch will defer the dying_tasks list addition, moving it from
> cgroup_task_exit() (called from do_exit()) to a new function called from
> finish_task_switch().
> However, release_task() (which calls
> cgroup_task_release()) can run either before or after finish_task_switch(=
),

Just for better understanding -- when can release_task() run before
finish_task_switch()?

> creating a race where cgroup_task_release() might try to remove the task =
=66rom
> dying_tasks before or while it's being added.
>=20
> Move the list_del_init() from cgroup_task_release() to cgroup_task_free()=
 to
> fix this race. cgroup_task_free() runs from __put_task_struct(), which is
> always after both paths, making the cleanup safe.

(Ah, now I get the reasoning of more likely pids '0' for CSS_TASK_ITER_PROC=
S.)

Thanks,
Michal

--3kggvokzmyvkuvuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRdrXxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjAVAEA+MiTNuMxizSa+5JF74pj
6kyfERptGG15W7yN848dLqoBAKjW2f4y51/zFdSBNGBGE3gO2Hu0BbLlXVMVULHC
qfIP
=1O1J
-----END PGP SIGNATURE-----

--3kggvokzmyvkuvuk--

