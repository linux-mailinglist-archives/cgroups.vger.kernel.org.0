Return-Path: <cgroups+bounces-3101-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE988FBE6D
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2024 00:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357411C228B4
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2024 22:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA199168CC;
	Tue,  4 Jun 2024 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U50dsZ7k"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE3320C;
	Tue,  4 Jun 2024 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538441; cv=none; b=ok3902EVtwQso5aQEjbW8toDNWQAe4mfQM7v124ra1jg8aUhwhWUSTRWQFefoTboWOnqRRQ9aMm7tcpbXjHCL9ZVUant7oA7bFqo1PfkHjz2otppUWJhHQmzF2PX0sDXUY84XxkYKSOKouYipCUgxo/y/+QFtEFbNW0AkBE2sN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538441; c=relaxed/simple;
	bh=NQTkQHeOY2E4PqUwFkIfMHALr0nDPHYLaa8Ap72Ep8Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NAoP1ZJrIugPni22ukBS+64DWBwhE0WRpq/rTx8GPD/tNj/LmVl5T/zidsmKKnqAFSxT71Ty7ui8193Npi2eiKGNnHUGUqH4cNNGHyUPv01nKMCQj16AZ7Y+5oz2hofAngq93LnUMlAXJGYdVGZAD/TiojdA03qf7EA8U53tlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U50dsZ7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBADC2BBFC;
	Tue,  4 Jun 2024 22:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717538441;
	bh=NQTkQHeOY2E4PqUwFkIfMHALr0nDPHYLaa8Ap72Ep8Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=U50dsZ7kNEoV6ry+gD9c+oSDIESJkBhMtrEG0ihzGUQzRWSAj1ZPQ0GqHscmPTzjA
	 vWPuT8/Q1HYBzltMWxDReryIfS5+6YjwjkqtmzH4wLlJV1u+OiUzuXQsBTRUsngZU+
	 X0m0HFeSox3lHiC6YyXmxHNh8LA/cJ9T+eKyXm/aDiNh78NR1tiVgmAUY70ddzDdrb
	 ncv4P7an+gJZmV44yNBFygxQxtstaNiR9A+ekpCFIf7ur/BE+AgUSI1E77g9w8SbZ0
	 NB89P+x3jWqgzQTJF+akXLo7a+rxJO9QQY0fZwk9Jsk+udi9f4RrbqqYEzsgHPP/eN
	 5z+9SXd2keR2w==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jun 2024 01:00:34 +0300
Message-Id: <D1RKK8CENNXI.1KMNDADV9C1YM@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v14 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
 <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
 <20240531222630.4634-15-haitao.huang@linux.intel.com>
In-Reply-To: <20240531222630.4634-15-haitao.huang@linux.intel.com>

On Sat Jun 1, 2024 at 1:26 AM EEST, Haitao Huang wrote:
> With different cgroups, the script starts one or multiple concurrent SGX
> selftests (test_sgx), each to run the unclobbered_vdso_oversubscribed
> test case, which loads an enclave of EPC size equal to the EPC capacity
> available on the platform. The script checks results against the
> expectation set for each cgroup and reports success or failure.
>
> The script creates 3 different cgroups at the beginning with following
> expectations:
>
> 1) small - intentionally small enough to fail the test loading an
> enclave of size equal to the capacity.
> 2) large - large enough to run up to 4 concurrent tests but fail some if
> more than 4 concurrent tests are run. The script starts 4 expecting at
> least one test to pass, and then starts 5 expecting at least one test
> to fail.
> 3) larger - limit is the same as the capacity, large enough to run lots o=
f
> concurrent tests. The script starts 8 of them and expects all pass.
> Then it reruns the same test with one process randomly killed and
> usage checked to be zero after all processes exit.
>
> The script also includes a test with low mem_cg limit and large sgx_epc
> limit to verify that the RAM used for per-cgroup reclamation is charged
> to a proper mem_cg. For this test, it turns off swapping before start,
> and turns swapping back on afterwards.
>
> Add README to document how to run the tests.
>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

Reorg:

void sgx_cgroup_init(void)
{
	struct workqueue_struct *wq;

	/* eagerly allocate the workqueue: */
	wq =3D alloc_workqueue("sgx_cg_wq", wq_unbound | wq_freezable, wq_unbound_=
max_active);
	if (!wq) {
		pr_warn("sgx_cg_wq creation failed\n");
		return;
	}

	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_cgroup_ops);
	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);

	/* Depending on misc state, keep or destory the workqueue: */
	if (cgroup_subsys_enabled(misc_cgrp_subsys))
		sgx_cg_wq =3D wq;
	else
		destroy_workqueue(wq);
}

BTW, why two previous operations are performed if subsystem is not
enabled?

I.e. why not instead:

void sgx_cgroup_init(void)
{
	struct workqueue_struct *wq;

	/* Eagerly allocate the workqueue: */
	wq =3D alloc_workqueue("sgx_cg_wq", wq_unbound | wq_freezable, wq_unbound_=
max_active);
	if (!wq) {
		pr_warn("sgx_cg_wq creation failed\n");
		return;
	}

	if (!cgroup_subsys_enabled(misc_cgrp_subsys)) {
		destroy_workqueue(wq);
		return;
	}

	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_cgroup_ops);
	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
	sgx_cg_wq =3D wq;
}

Finally, why this does not have __init? And neither sgx_cgroup_misc_init().

The names for these are also somewhat confusing, maybe something like:

* __sgx_cgroups_misc_init()
* sgx_cgroups_misc_init()

And both with __init.

I just made a trivial checkpatch run as a final check, and spotted the
warning on BUG_ON(), and noticed that this can't be right as it is but
please comment and correct where I might have gotten something wrong.

With "--strict" flag I also catched these:

CHECK: spinlock_t definition without comment
#1308: FILE: arch/x86/kernel/cpu/sgx/sgx.h:122:
+	spinlock_t lock;

CHECK: multiple assignments should be avoided
#444: FILE: kernel/cgroup/misc.c:450:
+		parent_cg =3D cg =3D &root_cg;

BR, Jarkko

