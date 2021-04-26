Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC36A36B99C
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 21:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbhDZTD6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 15:03:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:54994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239967AbhDZTDp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Apr 2021 15:03:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619463782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pruVnX3wP3lTqUcxfMSZx+YIOxSZgwC20tCRJWOzLy0=;
        b=MWBe01p9+08/bKgfYaQ6CSdsjjv0fRAHpnoLeyyijQiu/gzw7J6RdsLVHEkjHphKhDMRqj
        eBUFbN4Cs/oVjDLhPhRnWU8I9IYSIke2EsjF/Mr7276CBdWUVGJvS9bRrwORPzOFsXy1eN
        DGysD8NYUIWDuf8nZ2JEg9WiFSCfbLY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66ADDAE72;
        Mon, 26 Apr 2021 19:03:02 +0000 (UTC)
Date:   Mon, 26 Apr 2021 21:03:00 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RFC PATCH] cgroup: add cgroup.signal
Message-ID: <YIcOZEbvky7hGbR1@blackbook>
References: <20210423171351.3614430-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5jsyb94QUhz03rfD"
Content-Disposition: inline
In-Reply-To: <20210423171351.3614430-1-brauner@kernel.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--5jsyb94QUhz03rfD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 23, 2021 at 07:13:51PM +0200, Christian Brauner <brauner@kernel.org> wrote:
> +static void __cgroup_signal(struct cgroup *cgrp, int signr)
> +{
> +	struct css_task_iter it;
> +	struct task_struct *task;
> +
> +	lockdep_assert_held(&cgroup_mutex);
> +
> +	css_task_iter_start(&cgrp->self, 0, &it);

I think here you'd need CSS_TASK_ITER_PROCS here to avoid signalling
multithreaded processes multiple times? (OTOH, with commiting just to
SIGKILL this may be irrelevant.)

> +static void cgroup_signal(struct cgroup *cgrp, int signr)
> [...]
> +	read_lock(&tasklist_lock);

(Thinking loudly.)
I wonder if it's possible to get rid of this? A similar check that
freezer does in cgroup_post_fork() but perhaps in cgroup_can_fork(). The
fork/clone would apparently fail for the soon-to-die parent but there's
already similar error path returning ENODEV (heh, the macabrous name
cgroup_is_dead() is already occupied).

This way the cgroup-killer wouldn't unncessarily preempt tasklist_lock
exclusive requestors system-wide.


> @@ -4846,6 +4916,11 @@ static struct cftype cgroup_base_files[] = {
> +	{
> +		.name = "cgroup.signal",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.write = cgroup_signal_write,

I think this shouldn't be visible in threaded cgroups (or return an
error when attempting to kill those).

--5jsyb94QUhz03rfD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmCHDmQACgkQia1+riC5
qSh+GQ/+PmzHNhWttonJMqWNiPPt+NmHzzLSkEChHAHdIbkJCDQioQD9VxMhjJ7I
ZngkGOpRUu08Do8M74VNjJRf9OhqfcD20HeA9pfeem6HCryubtmPaU2MS8wNj2oa
siqrCREHtVD8/N8Hop3U0mKL0xhJRX9gUAo7rd3TIHSpuRHgauhvxhE/HrJ3Ly6k
MXcVZSe0OE3nyQY4nEGO9NOCQ3hbKl89WQYCEnT/mXRNiSPreZYYB5b59uK4dbUM
nzdQ7wgVUoqX1z+DbGzBVzI6JIeoPXUn+4HoW10/3D2sDA0eFo2m1zLJBvxLj8lJ
4Usy57JOzH9252RbRzV6ytvr5TnujzHAnamCTgP1ZpbQzur/E5AYO3PtJ+7Tv793
F5h1AX48OdD53MoVCGLxtCwMzf8IPGPj09ZJnSYzt1IRo2V5u31/PDim9+knJsO5
zgAVqGBndAl3VcTMkvpqmYxQpCUgwzSELo3K/japZrE6/W5Li33DSvDwsjBIeAQs
XT9+/hRGENtf1rge3efo6nsdhmHZ6vwIxjnV/6KLTqjB5zLAyW62eIqpVuacbsFv
BRlZH74JtyMpGDi3jhBjQwFbpvkw4S5FDYMaKebFE9Zcy40d00CRX5x8Taoo5JP0
y4hL2R+lnAQ1aEKYTQK7HNgTGmK1rg4mw48KdMY3eBtVtHoQbxA=
=qlsS
-----END PGP SIGNATURE-----

--5jsyb94QUhz03rfD--
