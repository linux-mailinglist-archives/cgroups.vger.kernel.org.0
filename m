Return-Path: <cgroups+bounces-2249-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A1A892AAF
	for <lists+cgroups@lfdr.de>; Sat, 30 Mar 2024 12:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B192E28282C
	for <lists+cgroups@lfdr.de>; Sat, 30 Mar 2024 11:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C98C2BAF6;
	Sat, 30 Mar 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1ftU9vF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFF9BE6F;
	Sat, 30 Mar 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797321; cv=none; b=Hjw4wINcNy5QP8obsVwEzt5ugSGtowJRrRGd7nkNoqz+7ILmQXHNBk8sJYsupao+cVJ4LCUGaFNraAwas7PK8p4nONcVzHuIXLK7kO+waGYL2EfGTz1q378YJYsuBJnhrDWi8ZTzgmq+KKfLHFPzaoTlsDxkho2nw9vgiiRmfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797321; c=relaxed/simple;
	bh=BU+iZwlXyhOhb/Hxv5gnkF30nWmGZ2Tfi8rvRT0cHrQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AOPCWkMM2ymG1kPRk4CYyB0USMUmI1VmLGOqvfEYBZSOt6jhvETyb6jn/ixC/WWT13d00MZeOU+4es7Ezv8lZ5NVwE/AXLvLUm7iTHXlSJ8vAMBG0ToVpJAoOyM7XZNsJuTXBu7naGk1w4kxGH1ykzboLQ6xCXUvKm/Th483eRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1ftU9vF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA6CC433C7;
	Sat, 30 Mar 2024 11:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711797320;
	bh=BU+iZwlXyhOhb/Hxv5gnkF30nWmGZ2Tfi8rvRT0cHrQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=W1ftU9vFLnbH4j7hCK8xkdGjzTG/MGGbmBbVQVFzTq/zfl/JYzycktJouUNwAiMnq
	 Latzr1w792NX2lTxu1zNXfCyxU0gN224HMF9bk7ZDLBmL83YCL+hm9kTpvZZPQilr4
	 X3Y0xoTofPq/EsJyilTVGYeD70A3q3pqjmY0wFaVEtBU7g+b3rcHSnI/EONwSI2lT0
	 8wE+P/oTOx7VeVG/JeoKrLPkzMiaGZT4BcclAcqNsFiCncrBtdSc5hk2N35hNX/GKU
	 Yzvv2cqe3TV2PMvPgByy2kvtR0PHMZewgALyxULuKlFTzK+0c4II4VYXyV3eIzvZ/S
	 1PAE6gH3hxG9g==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Mar 2024 13:15:14 +0200
Message-Id: <D071I61AGNZ7.HQGKJZI2D5UW@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
 <op.2lbrsagbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2lbrsagbwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Thu Mar 28, 2024 at 5:54 AM EET, Haitao Huang wrote:
> On Wed, 27 Mar 2024 07:55:34 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Mon, 2024-02-05 at 13:06 -0800, Haitao Huang wrote:
> >> The scripts rely on cgroup-tools package from libcgroup [1].
> >>
> >> To run selftests for epc cgroup:
> >>
> >> sudo ./run_epc_cg_selftests.sh
> >>
> >> To watch misc cgroup 'current' changes during testing, run this in a
> >> separate terminal:
> >>
> >> ./watch_misc_for_tests.sh current
> >>
> >> With different cgroups, the script starts one or multiple concurrent
> >> SGX
> >> selftests, each to run one unclobbered_vdso_oversubscribed test.Each
> >> of such test tries to load an enclave of EPC size equal to the EPC
> >> capacity available on the platform. The script checks results against
> >> the expectation set for each cgroup and reports success or failure.
> >>
> >> The script creates 3 different cgroups at the beginning with
> >> following
> >> expectations:
> >>
> >> 1) SMALL - intentionally small enough to fail the test loading an
> >> enclave of size equal to the capacity.
> >> 2) LARGE - large enough to run up to 4 concurrent tests but fail some
> >> if
> >> more than 4 concurrent tests are run. The script starts 4 expecting
> >> at
> >> least one test to pass, and then starts 5 expecting at least one test
> >> to fail.
> >> 3) LARGER - limit is the same as the capacity, large enough to run
> >> lots of
> >> concurrent tests. The script starts 8 of them and expects all pass.
> >> Then it reruns the same test with one process randomly killed and
> >> usage checked to be zero after all process exit.
> >>
> >> The script also includes a test with low mem_cg limit and LARGE
> >> sgx_epc
> >> limit to verify that the RAM used for per-cgroup reclamation is
> >> charged
> >> to a proper mem_cg.
> >>
> >> [1] https://github.com/libcgroup/libcgroup/blob/main/README
> >>
> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> ---
> >> V7:
> >> - Added memcontrol test.
> >>
> >> V5:
> >> - Added script with automatic results checking, remove the
> >> interactive
> >> script.
> >> - The script can run independent from the series below.
> >> ---
> >>  .../selftests/sgx/run_epc_cg_selftests.sh     | 246
> >> ++++++++++++++++++
> >>  .../selftests/sgx/watch_misc_for_tests.sh     |  13 +
> >>  2 files changed, 259 insertions(+)
> >>  create mode 100755
> >> tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >>  create mode 100755
> >> tools/testing/selftests/sgx/watch_misc_for_tests.sh
> >>
> >> diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >> b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >> new file mode 100755
> >> index 000000000000..e027bf39f005
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >> @@ -0,0 +1,246 @@
> >> +#!/bin/bash
> >
> > This is not portable and neither does hold in the wild.
> >
> > It does not even often hold as it is not uncommon to place bash
> > to the path /usr/bin/bash. If I recall correctly, e.g. NixOS has
> > a path that is neither of those two.
> >
> > Should be #!/usr/bin/env bash
> >
> > That is POSIX compatible form.
> >
>
> Sure
>
> > Just got around trying to test this in NUC7 so looking into this in
> > more detail.
>
> Thanks. Could you please check if this version works for you?
>
> https://github.com/haitaohuang/linux/commit/3c424b841cf3cf66b085a424f4b53=
7fbc3bbff6f
>
> >
> > That said can you make the script work with just "#!/usr/bin/env sh"
> > and make sure that it is busybox ash compatible?
>
> Yes.
>
> >
> > I don't see any necessity to make this bash only and it adds to the
> > compilation time of the image. Otherwise lot of this could be tested
> > just with qemu+bzImage+busybox(inside initramfs).
> >
>
> will still need cgroup-tools as you pointed out later. Compiling from its=
 =20
> upstream code OK?

Can you explain why you need it?

What is the thing you cannot do without it?

BR, Jarkko

