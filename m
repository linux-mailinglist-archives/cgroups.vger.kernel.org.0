Return-Path: <cgroups+bounces-2255-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A675C8932A6
	for <lists+cgroups@lfdr.de>; Sun, 31 Mar 2024 18:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C99AB20E74
	for <lists+cgroups@lfdr.de>; Sun, 31 Mar 2024 16:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6E2145340;
	Sun, 31 Mar 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVxCrW2H"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0D1F5F5;
	Sun, 31 Mar 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711901952; cv=none; b=qyCZWYGDa2qJJvp23qDlj3Szk1TXKnzx7sc0npIbdnjdOiMHzmCe5rO41aUMYfy9U2gYyn7wS9JkMLV1i8NS65JYJ+XxXdBLCKoO0D11ROMgPhXVz2lfOyzL+d/Nz+YFigdHppybbmL9Kitp40prgFpqL4+VpDVAS1b1bVqL0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711901952; c=relaxed/simple;
	bh=FQHb3aPYYs8wZ/nu5QzFLp3BZX8eUsavxGmJZ7+A/Dg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=VrX38ywdCS9X5haOpbyVC2qdtjwIKpU6NG8m4a2QAr0YnK5nC0a1KACA8KPCNv24zTYs1x4jmj3ddHZli4A7NJBg94h0EDk9kZHIn3hUg/0W/aVUFRcdVhrmn0WZ5JkgJnKNZuA3D6IDf4M1IyV8HsRXbDjv+UygyB0pAwKOlHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVxCrW2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CC7C433F1;
	Sun, 31 Mar 2024 16:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711901951;
	bh=FQHb3aPYYs8wZ/nu5QzFLp3BZX8eUsavxGmJZ7+A/Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVxCrW2HewU5O3Bqc9iU5VREDSiXXl1vMlsoeKs9fFO8Mu4rlLkdw4vYB1CjtJYDa
	 y6TR289kyLcHRavWUYbqul/d+ePA9tQGkoUUekDCHaSj9S4vOaK0+FNf0w54lpjT5C
	 hjHQJAZe6fQyPg0BrxyfruBLbO8tx/jIZo1Qa1Ftd5pAOv9ZmPnnZL++MYdINqaN/V
	 luQ4y9RBcMiDA55rF+4H0a+0OJA6N8J/tUxIMryZOwCx43U01hlt3KGtPyeibNe9H6
	 NugZP9k3E4flcWrPUf9GH8u0TqVvDJIglomjRxXEkuG7x0fmK+3Xfkcx1XOvSjHwdA
	 q06wp50Zc8bQQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 Mar 2024 19:19:04 +0300
Message-Id: <D082LCMM4PMU.GN9HOSMXOQR@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
X-Mailer: aerc 0.17.0
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
 <op.2lbrsagbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D071I61AGNZ7.HQGKJZI2D5UW@kernel.org>
 <op.2lgdg1tpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2lgdg1tpwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Sat Mar 30, 2024 at 5:32 PM EET, Haitao Huang wrote:
> On Sat, 30 Mar 2024 06:15:14 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Thu Mar 28, 2024 at 5:54 AM EET, Haitao Huang wrote:
> >> On Wed, 27 Mar 2024 07:55:34 -0500, Jarkko Sakkinen <jarkko@kernel.org=
>
> >> wrote:
> >>
> >> > On Mon, 2024-02-05 at 13:06 -0800, Haitao Huang wrote:
> >> >> The scripts rely on cgroup-tools package from libcgroup [1].
> >> >>
> >> >> To run selftests for epc cgroup:
> >> >>
> >> >> sudo ./run_epc_cg_selftests.sh
> >> >>
> >> >> To watch misc cgroup 'current' changes during testing, run this in =
a
> >> >> separate terminal:
> >> >>
> >> >> ./watch_misc_for_tests.sh current
> >> >>
> >> >> With different cgroups, the script starts one or multiple concurren=
t
> >> >> SGX
> >> >> selftests, each to run one unclobbered_vdso_oversubscribed test.Eac=
h
> >> >> of such test tries to load an enclave of EPC size equal to the EPC
> >> >> capacity available on the platform. The script checks results again=
st
> >> >> the expectation set for each cgroup and reports success or failure.
> >> >>
> >> >> The script creates 3 different cgroups at the beginning with
> >> >> following
> >> >> expectations:
> >> >>
> >> >> 1) SMALL - intentionally small enough to fail the test loading an
> >> >> enclave of size equal to the capacity.
> >> >> 2) LARGE - large enough to run up to 4 concurrent tests but fail so=
me
> >> >> if
> >> >> more than 4 concurrent tests are run. The script starts 4 expecting
> >> >> at
> >> >> least one test to pass, and then starts 5 expecting at least one te=
st
> >> >> to fail.
> >> >> 3) LARGER - limit is the same as the capacity, large enough to run
> >> >> lots of
> >> >> concurrent tests. The script starts 8 of them and expects all pass.
> >> >> Then it reruns the same test with one process randomly killed and
> >> >> usage checked to be zero after all process exit.
> >> >>
> >> >> The script also includes a test with low mem_cg limit and LARGE
> >> >> sgx_epc
> >> >> limit to verify that the RAM used for per-cgroup reclamation is
> >> >> charged
> >> >> to a proper mem_cg.
> >> >>
> >> >> [1] https://github.com/libcgroup/libcgroup/blob/main/README
> >> >>
> >> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> >> ---
> >> >> V7:
> >> >> - Added memcontrol test.
> >> >>
> >> >> V5:
> >> >> - Added script with automatic results checking, remove the
> >> >> interactive
> >> >> script.
> >> >> - The script can run independent from the series below.
> >> >> ---
> >> >>  .../selftests/sgx/run_epc_cg_selftests.sh     | 246
> >> >> ++++++++++++++++++
> >> >>  .../selftests/sgx/watch_misc_for_tests.sh     |  13 +
> >> >>  2 files changed, 259 insertions(+)
> >> >>  create mode 100755
> >> >> tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >> >>  create mode 100755
> >> >> tools/testing/selftests/sgx/watch_misc_for_tests.sh
> >> >>
> >> >> diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >> >> b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >> >> new file mode 100755
> >> >> index 000000000000..e027bf39f005
> >> >> --- /dev/null
> >> >> +++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >> >> @@ -0,0 +1,246 @@
> >> >> +#!/bin/bash
> >> >
> >> > This is not portable and neither does hold in the wild.
> >> >
> >> > It does not even often hold as it is not uncommon to place bash
> >> > to the path /usr/bin/bash. If I recall correctly, e.g. NixOS has
> >> > a path that is neither of those two.
> >> >
> >> > Should be #!/usr/bin/env bash
> >> >
> >> > That is POSIX compatible form.
> >> >
> >>
> >> Sure
> >>
> >> > Just got around trying to test this in NUC7 so looking into this in
> >> > more detail.
> >>
> >> Thanks. Could you please check if this version works for you?
> >>
> >> https://github.com/haitaohuang/linux/commit/3c424b841cf3cf66b085a424f4=
b537fbc3bbff6f
> >>
> >> >
> >> > That said can you make the script work with just "#!/usr/bin/env sh"
> >> > and make sure that it is busybox ash compatible?
> >>
> >> Yes.
> >>
> >> >
> >> > I don't see any necessity to make this bash only and it adds to the
> >> > compilation time of the image. Otherwise lot of this could be tested
> >> > just with qemu+bzImage+busybox(inside initramfs).
> >> >
> >>
> >> will still need cgroup-tools as you pointed out later. Compiling from =
=20
> >> its
> >> upstream code OK?
> >
> > Can you explain why you need it?
> >
> > What is the thing you cannot do without it?
> >
> > BR, Jarkko
> >
> I did not find a nice way to start a process in a specified cgroup like =
=20
> cgexec does. I could wrap the test in a shell: move the current shell to =
a =20
> new cgroup then do exec to run the test app. But that seems cumbersome as=
 =20
> I need to spawn many shells, and check results of them.  Another option i=
s =20
> create my own cgexec, which I'm sure will be very similar to cgexec code.=
 =20
> Was not sure how far we want to go with this.
>
> I can experiment with the shell wrapper idea and see how bad it can be an=
d =20
> fall back to implement cgexec? Open to suggestions.

I guess there's only few variants of how cgexec is invoked right?

The first thing we need to do is what exact steps those variants
perform.

After that we an decide how to implement exactly those variants.

E.g. without knowing do we need to perform any syscalls or can
this all done through sysfs affects somewhat how to proceed.

Right now if I want to build e.g. image with BuildRoot I'd need
to patch the existing recipe to add new dependencies in order to
execute these tests, and probably do the same for every project
that can package selftests to image.

BR, Jarkko

