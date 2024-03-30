Return-Path: <cgroups+bounces-2252-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C43892AC7
	for <lists+cgroups@lfdr.de>; Sat, 30 Mar 2024 12:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462901C20F0A
	for <lists+cgroups@lfdr.de>; Sat, 30 Mar 2024 11:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E362C69C;
	Sat, 30 Mar 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwLQiQGZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B6B67F;
	Sat, 30 Mar 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797975; cv=none; b=uU0NqG4+/yCvOvm0C6rcVlcbIrcfJCQVvgM81V2pVv7l1WjZJI3pTZs/HTjWPqSB+fU2u99zchkmSx1NiAxUZ6E6VLEXWLpPLmy8ZdyXidFqaAuyKlbYfwsBsB3wrgJ/v0A4xE7aDUXvxzUousTdbO0euRlexH386uUZ4JvIgCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797975; c=relaxed/simple;
	bh=QErKNpqz+w773d8QuEDTnf5cAcA6Lnte9xz7GTTbj/8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Zds/zCzDl9HVhxgcpheH/EsiP7IPnlSFTuzr4qF+SmbX4X+T8w6e+bW6x6YzPFmSxdViDx5WvgSj/NGVcIgXW2iU2qy+x3B1Tqkt5Wi3XrxpU3u4As7ScQgiiBCDi9AxsX83mLUFqWP3AbJKEBlH8JiYCZ60io79AQaG4oilp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwLQiQGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C96CC433F1;
	Sat, 30 Mar 2024 11:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711797974;
	bh=QErKNpqz+w773d8QuEDTnf5cAcA6Lnte9xz7GTTbj/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwLQiQGZkv970QfUwn/JaiNB3jcCUXXLpM+DdoKdopyIjaE9SEj7oq/L7IUMsgUtM
	 qAz7fAghXwWQxBRKORKAPjolRSaNpNmux7bhuiYljOkCOAdAg2KMQMh0p2Q4icEIF2
	 hHms8ZOrng77dovOkps/U81ETB27tQu0A9bafic8t2pdoddclDmCfgc+HI2b87D1Yp
	 wMS6UFjPnPL4Nt/Dkc5Kijy9qwptgBXSSIT0WCuHJHDywunJz7e4/CdYXWekcC/DIk
	 J/pZ2OxF8wW0DFe96ElieYm39CkBOh434wk7nm6oMj8H8BH/m0Z1r0lWzWOnucq2/y
	 e5sfelI85XWpw==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Mar 2024 13:26:08 +0200
Message-Id: <D071QIHLW7MP.UM9R3VYETIOK@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Haitao Huang"
 <haitao.huang@linux.intel.com>, <dave.hansen@linux.intel.com>,
 <tj@kernel.org>, <mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
 <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
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
 <D04OVW6I8MUA.1OAIHFQ8943SM@kernel.org>
 <op.2lbjl0oawjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D071OAFZ80O6.XEDXJ8AF4PK9@kernel.org>
In-Reply-To: <D071OAFZ80O6.XEDXJ8AF4PK9@kernel.org>

On Sat Mar 30, 2024 at 1:23 PM EET, Jarkko Sakkinen wrote:
> On Thu Mar 28, 2024 at 2:57 AM EET, Haitao Huang wrote:
> > On Wed, 27 Mar 2024 11:56:35 -0500, Jarkko Sakkinen <jarkko@kernel.org>=
 =20
> > wrote:
> >
> > > On Wed Mar 27, 2024 at 2:55 PM EET, Jarkko Sakkinen wrote:
> > >> On Mon, 2024-02-05 at 13:06 -0800, Haitao Huang wrote:
> > >> > The scripts rely on cgroup-tools package from libcgroup [1].
> > >> >
> > >> > To run selftests for epc cgroup:
> > >> >
> > >> > sudo ./run_epc_cg_selftests.sh
> > >> >
> > >> > To watch misc cgroup 'current' changes during testing, run this in=
 a
> > >> > separate terminal:
> > >> >
> > >> > ./watch_misc_for_tests.sh current
> > >> >
> > >> > With different cgroups, the script starts one or multiple concurre=
nt
> > >> > SGX
> > >> > selftests, each to run one unclobbered_vdso_oversubscribed test.> =
Each
> > >> > of such test tries to load an enclave of EPC size equal to the EPC
> > >> > capacity available on the platform. The script checks results agai=
nst
> > >> > the expectation set for each cgroup and reports success or failure=
.
> > >> >
> > >> > The script creates 3 different cgroups at the beginning with
> > >> > following
> > >> > expectations:
> > >> >
> > >> > 1) SMALL - intentionally small enough to fail the test loading an
> > >> > enclave of size equal to the capacity.
> > >> > 2) LARGE - large enough to run up to 4 concurrent tests but fail s=
ome
> > >> > if
> > >> > more than 4 concurrent tests are run. The script starts 4 expectin=
g
> > >> > at
> > >> > least one test to pass, and then starts 5 expecting at least one t=
est
> > >> > to fail.
> > >> > 3) LARGER - limit is the same as the capacity, large enough to run
> > >> > lots of
> > >> > concurrent tests. The script starts 8 of them and expects all pass=
.
> > >> > Then it reruns the same test with one process randomly killed and
> > >> > usage checked to be zero after all process exit.
> > >> >
> > >> > The script also includes a test with low mem_cg limit and LARGE
> > >> > sgx_epc
> > >> > limit to verify that the RAM used for per-cgroup reclamation is
> > >> > charged
> > >> > to a proper mem_cg.
> > >> >
> > >> > [1] https://github.com/libcgroup/libcgroup/blob/main/README
> > >> >
> > >> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> > >> > ---
> > >> > V7:
> > >> > - Added memcontrol test.
> > >> >
> > >> > V5:
> > >> > - Added script with automatic results checking, remove the
> > >> > interactive
> > >> > script.
> > >> > - The script can run independent from the series below.
> > >> > ---
> > >> >  .../selftests/sgx/run_epc_cg_selftests.sh     | 246
> > >> > ++++++++++++++++++
> > >> >  .../selftests/sgx/watch_misc_for_tests.sh     |  13 +
> > >> >  2 files changed, 259 insertions(+)
> > >> >  create mode 100755
> > >> > tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> > >> >  create mode 100755
> > >> > tools/testing/selftests/sgx/watch_misc_for_tests.sh
> > >> >
> > >> > diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> > >> > b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> > >> > new file mode 100755
> > >> > index 000000000000..e027bf39f005
> > >> > --- /dev/null
> > >> > +++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> > >> > @@ -0,0 +1,246 @@
> > >> > +#!/bin/bash
> > >>
> > >> This is not portable and neither does hold in the wild.
> > >>
> > >> It does not even often hold as it is not uncommon to place bash
> > >> to the path /usr/bin/bash. If I recall correctly, e.g. NixOS has
> > >> a path that is neither of those two.
> > >>
> > >> Should be #!/usr/bin/env bash
> > >>
> > >> That is POSIX compatible form.
> > >>
> > >> Just got around trying to test this in NUC7 so looking into this in
> > >> more detail.
> > >>
> > >> That said can you make the script work with just "#!/usr/bin/env sh"
> > >> and make sure that it is busybox ash compatible?
> > >>
> > >> I don't see any necessity to make this bash only and it adds to the
> > >> compilation time of the image. Otherwise lot of this could be tested
> > >> just with qemu+bzImage+busybox(inside initramfs).
> > >>
> > >> Now you are adding fully glibc shenanigans for the sake of syntax
> > >> sugar.
> > >>
> > >> > +# SPDX-License-Identifier: GPL-2.0
> > >> > +# Copyright(c) 2023 Intel Corporation.
> > >> > +
> > >> > +TEST_ROOT_CG=3Dselftest
> > >> > +cgcreate -g misc:$TEST_ROOT_CG
> > >>
> > >> How do you know that cgcreate exists? It is used a lot in the script
> > >> with no check for the existence. Please fix e.g. with "command -v
> > >> cgreate".
> > >>
> > >> > +if [ $? -ne 0 ]; then
> > >> > +    echo "# Please make sure cgroup-tools is installed, and misc
> > >> > cgroup is mounted."
> > >> > +    exit 1
> > >> > +fi
> > >>
> > >> And please do not do it this way. Also, please remove the advice for
> > >> "cgroups-tool". This is not meant to be debian only. Better would be
> > >> to e.g. point out the URL of the upstream project.
> > >>
> > >> And yeah the whole message should be based on "command -v", not like
> > >> this.
> > >>
> > >> > +TEST_CG_SUB1=3D$TEST_ROOT_CG/test1
> > >> > +TEST_CG_SUB2=3D$TEST_ROOT_CG/test2
> > >> > +# We will only set limit in test1 and run tests in test3
> > >> > +TEST_CG_SUB3=3D$TEST_ROOT_CG/test1/test3
> > >> > +TEST_CG_SUB4=3D$TEST_ROOT_CG/test4
> > >> > +
> > >> > +cgcreate -g misc:$TEST_CG_SUB1
> > >>
> > >>
> > >>
> > >> > +cgcreate -g misc:$TEST_CG_SUB2
> > >> > +cgcreate -g misc:$TEST_CG_SUB3
> > >> > +cgcreate -g misc:$TEST_CG_SUB4
> > >> > +
> > >> > +# Default to V2
> > >> > +CG_MISC_ROOT=3D/sys/fs/cgroup
> > >> > +CG_MEM_ROOT=3D/sys/fs/cgroup
> > >> > +CG_V1=3D0
> > >> > +if [ ! -d "/sys/fs/cgroup/misc" ]; then
> > >> > +    echo "# cgroup V2 is in use."
> > >> > +else
> > >> > +    echo "# cgroup V1 is in use."
> > >>
> > >> Is "#" prefix a standard for kselftest? I don't know this, thus aski=
ng.
> > >>
> > >> > +    CG_MISC_ROOT=3D/sys/fs/cgroup/misc
> > >> > +    CG_MEM_ROOT=3D/sys/fs/cgroup/memory
> > >> > +    CG_V1=3D1
> > >>
> > >> Have you checked what is the indentation policy for bash scripts ins=
ide
> > >> kernel tree. I don't know what it is. That's why I'm asking.
> > >>
> > >> > +fi
> > >> > +
> > >> > +CAPACITY=3D$(grep "sgx_epc" "$CG_MISC_ROOT/misc.capacity" | awk
> > >> > '{print $2}')
> > >> > +# This is below number of VA pages needed for enclave of capacity
> > >> > size. So
> > >> > +# should fail oversubscribed cases
> > >> > +SMALL=3D$(( CAPACITY / 512 ))
> > >> > +
> > >> > +# At least load one enclave of capacity size successfully, maybe =
up
> > >> > to 4.
> > >> > +# But some may fail if we run more than 4 concurrent enclaves of
> > >> > capacity size.
> > >> > +LARGE=3D$(( SMALL * 4 ))
> > >> > +
> > >> > +# Load lots of enclaves
> > >> > +LARGER=3D$CAPACITY
> > >> > +echo "# Setting up limits."
> > >> > +echo "sgx_epc $SMALL" > $CG_MISC_ROOT/$TEST_CG_SUB1/misc.max
> > >> > +echo "sgx_epc $LARGE" >  $CG_MISC_ROOT/$TEST_CG_SUB2/misc.max
> > >> > +echo "sgx_epc $LARGER" > $CG_MISC_ROOT/$TEST_CG_SUB4/misc.max
> > >> > +
> > >> > +timestamp=3D$(date +%Y%m%d_%H%M%S)
> > >> > +
> > >> > +test_cmd=3D"./test_sgx -t unclobbered_vdso_oversubscribed"
> > >> > +
> > >> > +wait_check_process_status() {
> > >> > +    local pid=3D$1
> > >> > +    local check_for_success=3D$2  # If 1, check for success;
> > >> > +                                # If 0, check for failure
> > >> > +    wait "$pid"
> > >> > +    local status=3D$?
> > >> > +
> > >> > +    if [[ $check_for_success -eq 1 && $status -eq 0 ]]; then
> > >> > +        echo "# Process $pid succeeded."
> > >> > +        return 0
> > >> > +    elif [[ $check_for_success -eq 0 && $status -ne 0 ]]; then
> > >> > +        echo "# Process $pid returned failure."
> > >> > +        return 0
> > >> > +    fi
> > >> > +    return 1
> > >> > +}
> > >> > +
> > >> > +wai
> > >> > wait_and_detect_for_any() {
> > >>
> > >> what is "any"?
> > >>
> > >> Maybe for some key functions could have short documentation what the=
y
> > >> are and for what test uses them. I cannot possibly remember all of t=
his
> > >> just by hints such as "this waits for Any" ;-)
> > >>
> > >> I don't think there is actual kernel guideline to engineer the scrip=
t
> > >> to work with just ash but at least for me that would inevitably
> > >> increase my motivation to test this patch set more rather than less.
> > >
> > > I also wonder is cgroup-tools dependency absolutely required or could
> > > you just have a function that would interact with sysfs?
> >
> > I should have checked email before hit the send button for v10 :-).
> >
> > It'd be more complicated and less readable to do all the stuff without =
the =20
> > cgroup-tools, esp cgexec. I checked dependency, cgroup-tools only depen=
ds =20
> > on libc so I hope this would not cause too much inconvenience.
>
> As per cgroup-tools, please prove this. It makes the job for more
> complicated *for you* and you are making the job more  complicated
> to every possible person in the planet running any kernel QA.
>
> I weight the latter more than the former. And it is exactly the
> reason why we did custom user space kselftest in the first place.
> Let's keep the tradition. All I can say is that kselftest is=20
> unfinished in its current form.
>
> What is "esp cgexec"?

Also in kselftest we don't drive ultimate simplicity, we drive
efficient CI/QA. By open coding something like subset of
cgroup-tools needed to run the test you also help us later
on to backtrack the kernel changes. With cgroups-tools you
would have to use strace to get the same info.


BR, Jarkko

