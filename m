Return-Path: <cgroups+bounces-2259-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528C9893BEE
	for <lists+cgroups@lfdr.de>; Mon,  1 Apr 2024 16:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F541C214AD
	for <lists+cgroups@lfdr.de>; Mon,  1 Apr 2024 14:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B4540BE1;
	Mon,  1 Apr 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVnqzsan"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520944087A;
	Mon,  1 Apr 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980612; cv=none; b=YQS+BHS83/HGICuzBQuYO0bLIN+wwPwD5fNi2q4yWhJ3uW6iHVKs9iU4sUE0IkYkvc+KjKfNbHDPph3cTiGgenIBt91hRVU+BFQnqTPkisoA6FVATXl/M1KWGGpYUegjt8BEuqswRnV5EjnTEBOv6CrQ1rEODaVjTBtUS0lwyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980612; c=relaxed/simple;
	bh=TtRLHesnz+dcACnoZKKZM/LtsPcxKVCvvbWmluBaCVo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kLPJ5+iAlkianFaf126+uzZpP78z54FTqxsnFeoRIzR+SD+ZyGO8FBh2ZmjGbLM1t5RLhmGoD9zwnRy5UYFbGq7qHXHT3iOBp3dutBKxgzX7sIGumaeQmDcspjCeDqDotbpJw0evAGK5vsaK7Jjw17DK1DdRMthS+0hi2QJKWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVnqzsan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1369C433C7;
	Mon,  1 Apr 2024 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980612;
	bh=TtRLHesnz+dcACnoZKKZM/LtsPcxKVCvvbWmluBaCVo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=YVnqzsanqNdD048o1U6G5XqGysgokOHUJcldr8nVQE4OXs/MlEZUkGvhl3QFSxtSn
	 ZxeQsGMS6nnORcMWEwJxDPOB8VUEXAhDHq55PXPAm7qi0K+XqRYoDrhA20mbNDvnJf
	 YO4FtnxL8cNInkb3pfPW3/qtjW7KcfvMyjEj5nPpghsgz6Gzj5LQipXUGMzXY5VEZd
	 49H8iF3QyTP84qh3grU2Htp+juovX+IHAL+Ysh+MtZe6OD1+EqBctHBckmnpY/sh9f
	 hS4O82dp9l02jgyTbE3grqCTnFRecZWVUHLgh1nQuxhVGPZsalihS//dGk5/vu9c5z
	 Y9+t8pNzquJLw==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Apr 2024 17:10:05 +0300
Message-Id: <D08UH4V717IE.2KWT2L9GE3US1@kernel.org>
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
 <D071I61AGNZ7.HQGKJZI2D5UW@kernel.org>
 <op.2lgdg1tpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D082LCMM4PMU.GN9HOSMXOQR@kernel.org>
 <op.2lidt6qmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2lidt6qmwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Sun Mar 31, 2024 at 8:35 PM EEST, Haitao Huang wrote:
> On Sun, 31 Mar 2024 11:19:04 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Sat Mar 30, 2024 at 5:32 PM EET, Haitao Huang wrote:
> >> On Sat, 30 Mar 2024 06:15:14 -0500, Jarkko Sakkinen <jarkko@kernel.org=
>
> >> wrote:
> >>
> >> > On Thu Mar 28, 2024 at 5:54 AM EET, Haitao Huang wrote:
> >> >> On Wed, 27 Mar 2024 07:55:34 -0500, Jarkko Sakkinen =20
> >> <jarkko@kernel.org>
> >> >> wrote:
> >> >>
> >> >> > On Mon, 2024-02-05 at 13:06 -0800, Haitao Huang wrote:
> >> >> >> The scripts rely on cgroup-tools package from libcgroup [1].
> >> >> >>
> >> >> >> To run selftests for epc cgroup:
> >> >> >>
> >> >> >> sudo ./run_epc_cg_selftests.sh
> >> >> >>
> >> >> >> To watch misc cgroup 'current' changes during testing, run this =
=20
> >> in a
> >> >> >> separate terminal:
> >> >> >>
> >> >> >> ./watch_misc_for_tests.sh current
> >> >> >>
> >> >> >> With different cgroups, the script starts one or multiple =20
> >> concurrent
> >> >> >> SGX
> >> >> >> selftests, each to run one unclobbered_vdso_oversubscribed =20
> >> test.Each
> >> >> >> of such test tries to load an enclave of EPC size equal to the E=
PC
> >> >> >> capacity available on the platform. The script checks results =
=20
> >> against
> >> >> >> the expectation set for each cgroup and reports success or =20
> >> failure.
> >> >> >>
> >> >> >> The script creates 3 different cgroups at the beginning with
> >> >> >> following
> >> >> >> expectations:
> >> >> >>
> >> >> >> 1) SMALL - intentionally small enough to fail the test loading a=
n
> >> >> >> enclave of size equal to the capacity.
> >> >> >> 2) LARGE - large enough to run up to 4 concurrent tests but fail=
 =20
> >> some
> >> >> >> if
> >> >> >> more than 4 concurrent tests are run. The script starts 4 =20
> >> expecting
> >> >> >> at
> >> >> >> least one test to pass, and then starts 5 expecting at least one=
 =20
> >> test
> >> >> >> to fail.
> >> >> >> 3) LARGER - limit is the same as the capacity, large enough to r=
un
> >> >> >> lots of
> >> >> >> concurrent tests. The script starts 8 of them and expects all =
=20
> >> pass.
> >> >> >> Then it reruns the same test with one process randomly killed an=
d
> >> >> >> usage checked to be zero after all process exit.
> >> >> >>
> >> >> >> The script also includes a test with low mem_cg limit and LARGE
> >> >> >> sgx_epc
> >> >> >> limit to verify that the RAM used for per-cgroup reclamation is
> >> >> >> charged
> >> >> >> to a proper mem_cg.
> >> >> >>
> >> >> >> [1] https://github.com/libcgroup/libcgroup/blob/main/README
> >> >> >>
> >> >> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> >> >> ---
> >> >> >> V7:
> >> >> >> - Added memcontrol test.
> >> >> >>
> >> >> >> V5:
> >> >> >> - Added script with automatic results checking, remove the
> >> >> >> interactive
> >> >> >> script.
> >> >> >> - The script can run independent from the series below.
> >> >> >> ---
> >> >> >>  .../selftests/sgx/run_epc_cg_selftests.sh     | 246
> >> >> >> ++++++++++++++++++
> >> >> >>  .../selftests/sgx/watch_misc_for_tests.sh     |  13 +
> >> >> >>  2 files changed, 259 insertions(+)
> >> >> >>  create mode 100755
> >> >> >> tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >> >> >>  create mode 100755
> >> >> >> tools/testing/selftests/sgx/watch_misc_for_tests.sh
> >> >> >>
> >> >> >> diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >> >> >> b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >> >> >> new file mode 100755
> >> >> >> index 000000000000..e027bf39f005
> >> >> >> --- /dev/null
> >> >> >> +++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> >> >> >> @@ -0,0 +1,246 @@
> >> >> >> +#!/bin/bash
> >> >> >
> >> >> > This is not portable and neither does hold in the wild.
> >> >> >
> >> >> > It does not even often hold as it is not uncommon to place bash
> >> >> > to the path /usr/bin/bash. If I recall correctly, e.g. NixOS has
> >> >> > a path that is neither of those two.
> >> >> >
> >> >> > Should be #!/usr/bin/env bash
> >> >> >
> >> >> > That is POSIX compatible form.
> >> >> >
> >> >>
> >> >> Sure
> >> >>
> >> >> > Just got around trying to test this in NUC7 so looking into this =
in
> >> >> > more detail.
> >> >>
> >> >> Thanks. Could you please check if this version works for you?
> >> >>
> >> >> =20
> >> https://github.com/haitaohuang/linux/commit/3c424b841cf3cf66b085a424f4=
b537fbc3bbff6f
> >> >>
> >> >> >
> >> >> > That said can you make the script work with just "#!/usr/bin/env =
=20
> >> sh"
> >> >> > and make sure that it is busybox ash compatible?
> >> >>
> >> >> Yes.
> >> >>
> >> >> >
> >> >> > I don't see any necessity to make this bash only and it adds to t=
he
> >> >> > compilation time of the image. Otherwise lot of this could be =20
> >> tested
> >> >> > just with qemu+bzImage+busybox(inside initramfs).
> >> >> >
> >> >>
> >> >> will still need cgroup-tools as you pointed out later. Compiling fr=
om
> >> >> its
> >> >> upstream code OK?
> >> >
> >> > Can you explain why you need it?
> >> >
> >> > What is the thing you cannot do without it?
> >> >
> >> > BR, Jarkko
> >> >
> >> I did not find a nice way to start a process in a specified cgroup lik=
e
> >> cgexec does. I could wrap the test in a shell: move the current shell =
=20
> >> to a
> >> new cgroup then do exec to run the test app. But that seems cumbersome=
 =20
> >> as
> >> I need to spawn many shells, and check results of them.  Another optio=
n =20
> >> is
> >> create my own cgexec, which I'm sure will be very similar to cgexec =
=20
> >> code.
> >> Was not sure how far we want to go with this.
> >>
> >> I can experiment with the shell wrapper idea and see how bad it can be=
 =20
> >> and
> >> fall back to implement cgexec? Open to suggestions.
> >
> > I guess there's only few variants of how cgexec is invoked right?
> >
> > The first thing we need to do is what exact steps those variants
> > perform.
> >
> > After that we an decide how to implement exactly those variants.
> >
> > E.g. without knowing do we need to perform any syscalls or can
> > this all done through sysfs affects somewhat how to proceed.
> >
> > Right now if I want to build e.g. image with BuildRoot I'd need
> > to patch the existing recipe to add new dependencies in order to
> > execute these tests, and probably do the same for every project
> > that can package selftests to image.
> >
> > BR, Jarkko
> >
> Can be done through sysfs without syscalls. I implemented the wrapper =20
> shell and it looks not as bad I expected.
> Will send an add-on patch with that change and other changes to address =
=20
> your comments so far for the test scripts.
> If we agree on the approach, I'll squash it with this one later.

So think this way. By having these open coded we can check in detail
that the feature works exactly how we would like.

Those tools add an abstraction layer which makes it harder to evaluate
this as a whole.

Also, that renders away all possible issues related to different
versions of 3rd party tools and their possible incompatibilities.

If pure bash for some reason would turn out to be unmanageable nothing
prevents to e.g. implement a small tool in C or Python that does the
tasks required. E.g. for testing TPM2 chips I implemented custom TPM2
user space just for kselftest, and in SGX we implemented "bare metal"
enclave implementation with the same rationale.

BR, Jarkko

