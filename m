Return-Path: <cgroups+bounces-2178-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8433C88E5FC
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 15:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13AAD1F26D6A
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BF715217E;
	Wed, 27 Mar 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLxzKta9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B470137C5B;
	Wed, 27 Mar 2024 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544159; cv=none; b=cUWutajUT1sUDLKKek9UY+Ny63l9LgSAsWp3iExM/8jsNaaCRNl+ZRyI/6InN1DXxycXhSk9yUyPlczCsVjIxH9XmJ4X5kBQEXr6CUo5LTLWAATE5jP1AZ5Ao/lL6/CyrrjxjgZmL9XNFJ2rdwFfnLCSQAJ/dLiMoAvoEFAV6/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544159; c=relaxed/simple;
	bh=/4hao90m2lFZTisPobhr+RiJ+36sJrqVQ3pwgxDkrBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ImvOhYfabBbrPk+ujQpHTG6BPynHq+e8HJY8oG4E7MvMWzcGlN1n7ZmSGMCpYm6/CgMLAVbu7Mu7PaCtsEZ/HFYysXt+kHVfJ4GD2v35gJwyLtrf5d0T0N2XUTX+47D2lAUH7r10GZoDpgWqBZmwnefI2+owmltFc3iBiF3U3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLxzKta9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E19AC433F1;
	Wed, 27 Mar 2024 12:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711544158;
	bh=/4hao90m2lFZTisPobhr+RiJ+36sJrqVQ3pwgxDkrBI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MLxzKta9uSeURjL488EfGW3OX8K32Kw2kZKlG8VZgIPm4zwHVv6tdHyjNfVklexGk
	 t3UPDgzQKbtC7bvVu7JLPF3xK26ZOYB7rcGUTxdFafBG8cshUtoHrFj+WKVgP5oh/e
	 hhiwo8mFKDeQBkna8gDi8ebecr7es1MBDuwHr1yE2kQbKRvnYz0FsFghCc9lc8uC8B
	 JpujHOrq+rBfCKPvyhUhHDH6/FE6PmJvkg/bvi3gNWNnG/Rnnr1Au5s42tVgXCUNgm
	 WA62QIs8B1+gggjgVmmgI3F+zwMQ00S8yJ//vKfxe1o11PEIfxipZqH3QE+nTYuHcX
	 SvIdg0O6xLYIw==
Message-ID: <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
Subject: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Haitao Huang <haitao.huang@linux.intel.com>,
 dave.hansen@linux.intel.com,  tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org,  linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org,  tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com,  sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com, 
	zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com, 
	yangjie@microsoft.com, chrisyan@microsoft.com
Date: Wed, 27 Mar 2024 14:55:34 +0200
In-Reply-To: <20240205210638.157741-16-haitao.huang@linux.intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
	 <20240205210638.157741-16-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-05 at 13:06 -0800, Haitao Huang wrote:
> The scripts rely on cgroup-tools package from libcgroup [1].
>=20
> To run selftests for epc cgroup:
>=20
> sudo ./run_epc_cg_selftests.sh
>=20
> To watch misc cgroup 'current' changes during testing, run this in a
> separate terminal:
>=20
> ./watch_misc_for_tests.sh current
>=20
> With different cgroups, the script starts one or multiple concurrent
> SGX
> selftests, each to run one unclobbered_vdso_oversubscribed test.=C2=A0
> Each
> of such test tries to load an enclave of EPC size equal to the EPC
> capacity available on the platform. The script checks results against
> the expectation set for each cgroup and reports success or failure.
>=20
> The script creates 3 different cgroups at the beginning with
> following
> expectations:
>=20
> 1) SMALL - intentionally small enough to fail the test loading an
> enclave of size equal to the capacity.
> 2) LARGE - large enough to run up to 4 concurrent tests but fail some
> if
> more than 4 concurrent tests are run. The script starts 4 expecting
> at
> least one test to pass, and then starts 5 expecting at least one test
> to fail.
> 3) LARGER - limit is the same as the capacity, large enough to run
> lots of
> concurrent tests. The script starts 8 of them and expects all pass.
> Then it reruns the same test with one process randomly killed and
> usage checked to be zero after all process exit.
>=20
> The script also includes a test with low mem_cg limit and LARGE
> sgx_epc
> limit to verify that the RAM used for per-cgroup reclamation is
> charged
> to a proper mem_cg.
>=20
> [1] https://github.com/libcgroup/libcgroup/blob/main/README
>=20
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V7:
> - Added memcontrol test.
>=20
> V5:
> - Added script with automatic results checking, remove the
> interactive
> script.
> - The script can run independent from the series below.
> ---
> =C2=A0.../selftests/sgx/run_epc_cg_selftests.sh=C2=A0=C2=A0=C2=A0=C2=A0 |=
 246
> ++++++++++++++++++
> =C2=A0.../selftests/sgx/watch_misc_for_tests.sh=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 13 +
> =C2=A02 files changed, 259 insertions(+)
> =C2=A0create mode 100755
> tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> =C2=A0create mode 100755
> tools/testing/selftests/sgx/watch_misc_for_tests.sh
>=20
> diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> new file mode 100755
> index 000000000000..e027bf39f005
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> @@ -0,0 +1,246 @@
> +#!/bin/bash

This is not portable and neither does hold in the wild.

It does not even often hold as it is not uncommon to place bash
to the path /usr/bin/bash. If I recall correctly, e.g. NixOS has
a path that is neither of those two.

Should be #!/usr/bin/env bash

That is POSIX compatible form.

Just got around trying to test this in NUC7 so looking into this in
more detail.

That said can you make the script work with just "#!/usr/bin/env sh"
and make sure that it is busybox ash compatible?

I don't see any necessity to make this bash only and it adds to the
compilation time of the image. Otherwise lot of this could be tested
just with qemu+bzImage+busybox(inside initramfs).

Now you are adding fully glibc shenanigans for the sake of syntax
sugar.

> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2023 Intel Corporation.
> +
> +TEST_ROOT_CG=3Dselftest
> +cgcreate -g misc:$TEST_ROOT_CG

How do you know that cgcreate exists? It is used a lot in the script
with no check for the existence. Please fix e.g. with "command -v
cgreate".

> +if [ $? -ne 0 ]; then
> +=C2=A0=C2=A0=C2=A0 echo "# Please make sure cgroup-tools is installed, a=
nd misc
> cgroup is mounted."
> +=C2=A0=C2=A0=C2=A0 exit 1
> +fi

And please do not do it this way. Also, please remove the advice for
"cgroups-tool". This is not meant to be debian only. Better would be
to e.g. point out the URL of the upstream project.

And yeah the whole message should be based on "command -v", not like
this.

> +TEST_CG_SUB1=3D$TEST_ROOT_CG/test1
> +TEST_CG_SUB2=3D$TEST_ROOT_CG/test2
> +# We will only set limit in test1 and run tests in test3
> +TEST_CG_SUB3=3D$TEST_ROOT_CG/test1/test3
> +TEST_CG_SUB4=3D$TEST_ROOT_CG/test4
> +
> +cgcreate -g misc:$TEST_CG_SUB1



> +cgcreate -g misc:$TEST_CG_SUB2
> +cgcreate -g misc:$TEST_CG_SUB3
> +cgcreate -g misc:$TEST_CG_SUB4
> +
> +# Default to V2
> +CG_MISC_ROOT=3D/sys/fs/cgroup
> +CG_MEM_ROOT=3D/sys/fs/cgroup
> +CG_V1=3D0
> +if [ ! -d "/sys/fs/cgroup/misc" ]; then
> +=C2=A0=C2=A0=C2=A0 echo "# cgroup V2 is in use."
> +else
> +=C2=A0=C2=A0=C2=A0 echo "# cgroup V1 is in use."

Is "#" prefix a standard for kselftest? I don't know this, thus asking.

> +=C2=A0=C2=A0=C2=A0 CG_MISC_ROOT=3D/sys/fs/cgroup/misc
> +=C2=A0=C2=A0=C2=A0 CG_MEM_ROOT=3D/sys/fs/cgroup/memory
> +=C2=A0=C2=A0=C2=A0 CG_V1=3D1

Have you checked what is the indentation policy for bash scripts inside
kernel tree. I don't know what it is. That's why I'm asking.

> +fi
> +
> +CAPACITY=3D$(grep "sgx_epc" "$CG_MISC_ROOT/misc.capacity" | awk
> '{print $2}')
> +# This is below number of VA pages needed for enclave of capacity
> size. So
> +# should fail oversubscribed cases
> +SMALL=3D$(( CAPACITY / 512 ))
> +
> +# At least load one enclave of capacity size successfully, maybe up
> to 4.
> +# But some may fail if we run more than 4 concurrent enclaves of
> capacity size.
> +LARGE=3D$(( SMALL * 4 ))
> +
> +# Load lots of enclaves
> +LARGER=3D$CAPACITY
> +echo "# Setting up limits."
> +echo "sgx_epc $SMALL" > $CG_MISC_ROOT/$TEST_CG_SUB1/misc.max
> +echo "sgx_epc $LARGE" >=C2=A0 $CG_MISC_ROOT/$TEST_CG_SUB2/misc.max
> +echo "sgx_epc $LARGER" > $CG_MISC_ROOT/$TEST_CG_SUB4/misc.max
> +
> +timestamp=3D$(date +%Y%m%d_%H%M%S)
> +
> +test_cmd=3D"./test_sgx -t unclobbered_vdso_oversubscribed"
> +
> +wait_check_process_status() {
> +=C2=A0=C2=A0=C2=A0 local pid=3D$1
> +=C2=A0=C2=A0=C2=A0 local check_for_success=3D$2=C2=A0 # If 1, check for =
success;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If 0, check for failure
> +=C2=A0=C2=A0=C2=A0 wait "$pid"
> +=C2=A0=C2=A0=C2=A0 local status=3D$?
> +
> +=C2=A0=C2=A0=C2=A0 if [[ $check_for_success -eq 1 && $status -eq 0 ]]; t=
hen
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "# Process $pid succeede=
d."
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0
> +=C2=A0=C2=A0=C2=A0 elif [[ $check_for_success -eq 0 && $status -ne 0 ]];=
 then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "# Process $pid returned=
 failure."
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0
> +=C2=A0=C2=A0=C2=A0 fi
> +=C2=A0=C2=A0=C2=A0 return 1
> +}
> +
> +wai
> wait_and_detect_for_any() {

what is "any"?

Maybe for some key functions could have short documentation what they
are and for what test uses them. I cannot possibly remember all of this
just by hints such as "this waits for Any" ;-)

I don't think there is actual kernel guideline to engineer the script
to work with just ash but at least for me that would inevitably
increase my motivation to test this patch set more rather than less.

BR, Jarkko

