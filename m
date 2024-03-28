Return-Path: <cgroups+bounces-2216-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FA388F43B
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 01:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29852A5213
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 00:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F3316423;
	Thu, 28 Mar 2024 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oj264fS3"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B62718C22;
	Thu, 28 Mar 2024 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711587452; cv=none; b=NnllTBQuKiGcsYrmC7daBZ0QYXUbdGXApxRpGKeZMomq8aJLTpt2QybqK711WvHHHRy10x9EKKwf/KeYmS/VLbZ7CbrfGpjSHLOyldEXifTLIrO/gvavT/xS6rB0im68lS+/NzohqPLZX5w9W93FmYBgMmN86gM4Hd8MC/2VJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711587452; c=relaxed/simple;
	bh=LMEa4+12A/57Ghvrda87UUmPNebE1EJUdYhkKKuwMCc=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=c1pVCBbitPAX4j3DzO/yhotyudxhaurAaqRcFOzU7Fc9UOcM3cLuk9gZ/XbrPZq8ciVMr2Aw+F7bv9vUOx3J4maG6awL71EaAYkC/8L9FptTYbiAldgwbeDmmOnt+BTz3oMZ2LoS6JSGj6alW38Mbm/ZQFZrdpwUfUQq469zYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oj264fS3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711587450; x=1743123450;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=LMEa4+12A/57Ghvrda87UUmPNebE1EJUdYhkKKuwMCc=;
  b=Oj264fS39+0Vyce4VwMC/JtJSUCF3FrR0Tht8CxhzYX30aG3nUFzWfzy
   ndIPJNzzxjdZCEo6KDhZRhPpRQR3YYbp+87L+pKuBM1vV6SvUqz3bACpt
   lXNP2YvxWCzJOXxfq8tU3jC3r6htVzaCEGDt1RotFbFZZxDKy24B6vZlW
   ZC8whJHmvc77E9xqf5RbL3f0ugVg5FEYOxxAtyt9Rnr/dclyAOf9saxe7
   Lp811Aywg4WOXAnwhvz1Q37DVF/ClG0WKbsS0+y0XqI6hSe6BjFOkMuYs
   6TeLHvb9+icgvkZ7rShtJ3VcvP070BVUDyeM9iyZZTQbi6n2wllzz0cWe
   g==;
X-CSE-ConnectionGUID: 04BoiYZqQWqKfiLErggk3A==
X-CSE-MsgGUID: BmATFsdVRsSnID1fT17QQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="9682583"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="9682583"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 17:57:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21125662"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 27 Mar 2024 17:57:27 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
 tj@kernel.org, mkoutny@suse.com, linux-kernel@vger.kernel.org,
 linux-sgx@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 sohil.mehta@intel.com, tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
 <D04OVW6I8MUA.1OAIHFQ8943SM@kernel.org>
Date: Wed, 27 Mar 2024 19:57:26 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2lbjl0oawjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <D04OVW6I8MUA.1OAIHFQ8943SM@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

On Wed, 27 Mar 2024 11:56:35 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Wed Mar 27, 2024 at 2:55 PM EET, Jarkko Sakkinen wrote:
>> On Mon, 2024-02-05 at 13:06 -0800, Haitao Huang wrote:
>> > The scripts rely on cgroup-tools package from libcgroup [1].
>> >
>> > To run selftests for epc cgroup:
>> >
>> > sudo ./run_epc_cg_selftests.sh
>> >
>> > To watch misc cgroup 'current' changes during testing, run this in a
>> > separate terminal:
>> >
>> > ./watch_misc_for_tests.sh current
>> >
>> > With different cgroups, the script starts one or multiple concurrent
>> > SGX
>> > selftests, each to run one unclobbered_vdso_oversubscribed test.> Each
>> > of such test tries to load an enclave of EPC size equal to the EPC
>> > capacity available on the platform. The script checks results against
>> > the expectation set for each cgroup and reports success or failure.
>> >
>> > The script creates 3 different cgroups at the beginning with
>> > following
>> > expectations:
>> >
>> > 1) SMALL - intentionally small enough to fail the test loading an
>> > enclave of size equal to the capacity.
>> > 2) LARGE - large enough to run up to 4 concurrent tests but fail some
>> > if
>> > more than 4 concurrent tests are run. The script starts 4 expecting
>> > at
>> > least one test to pass, and then starts 5 expecting at least one test
>> > to fail.
>> > 3) LARGER - limit is the same as the capacity, large enough to run
>> > lots of
>> > concurrent tests. The script starts 8 of them and expects all pass.
>> > Then it reruns the same test with one process randomly killed and
>> > usage checked to be zero after all process exit.
>> >
>> > The script also includes a test with low mem_cg limit and LARGE
>> > sgx_epc
>> > limit to verify that the RAM used for per-cgroup reclamation is
>> > charged
>> > to a proper mem_cg.
>> >
>> > [1] https://github.com/libcgroup/libcgroup/blob/main/README
>> >
>> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> > ---
>> > V7:
>> > - Added memcontrol test.
>> >
>> > V5:
>> > - Added script with automatic results checking, remove the
>> > interactive
>> > script.
>> > - The script can run independent from the series below.
>> > ---
>> >  .../selftests/sgx/run_epc_cg_selftests.sh     | 246
>> > ++++++++++++++++++
>> >  .../selftests/sgx/watch_misc_for_tests.sh     |  13 +
>> >  2 files changed, 259 insertions(+)
>> >  create mode 100755
>> > tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>> >  create mode 100755
>> > tools/testing/selftests/sgx/watch_misc_for_tests.sh
>> >
>> > diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>> > b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>> > new file mode 100755
>> > index 000000000000..e027bf39f005
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>> > @@ -0,0 +1,246 @@
>> > +#!/bin/bash
>>
>> This is not portable and neither does hold in the wild.
>>
>> It does not even often hold as it is not uncommon to place bash
>> to the path /usr/bin/bash. If I recall correctly, e.g. NixOS has
>> a path that is neither of those two.
>>
>> Should be #!/usr/bin/env bash
>>
>> That is POSIX compatible form.
>>
>> Just got around trying to test this in NUC7 so looking into this in
>> more detail.
>>
>> That said can you make the script work with just "#!/usr/bin/env sh"
>> and make sure that it is busybox ash compatible?
>>
>> I don't see any necessity to make this bash only and it adds to the
>> compilation time of the image. Otherwise lot of this could be tested
>> just with qemu+bzImage+busybox(inside initramfs).
>>
>> Now you are adding fully glibc shenanigans for the sake of syntax
>> sugar.
>>
>> > +# SPDX-License-Identifier: GPL-2.0
>> > +# Copyright(c) 2023 Intel Corporation.
>> > +
>> > +TEST_ROOT_CG=selftest
>> > +cgcreate -g misc:$TEST_ROOT_CG
>>
>> How do you know that cgcreate exists? It is used a lot in the script
>> with no check for the existence. Please fix e.g. with "command -v
>> cgreate".
>>
>> > +if [ $? -ne 0 ]; then
>> > +    echo "# Please make sure cgroup-tools is installed, and misc
>> > cgroup is mounted."
>> > +    exit 1
>> > +fi
>>
>> And please do not do it this way. Also, please remove the advice for
>> "cgroups-tool". This is not meant to be debian only. Better would be
>> to e.g. point out the URL of the upstream project.
>>
>> And yeah the whole message should be based on "command -v", not like
>> this.
>>
>> > +TEST_CG_SUB1=$TEST_ROOT_CG/test1
>> > +TEST_CG_SUB2=$TEST_ROOT_CG/test2
>> > +# We will only set limit in test1 and run tests in test3
>> > +TEST_CG_SUB3=$TEST_ROOT_CG/test1/test3
>> > +TEST_CG_SUB4=$TEST_ROOT_CG/test4
>> > +
>> > +cgcreate -g misc:$TEST_CG_SUB1
>>
>>
>>
>> > +cgcreate -g misc:$TEST_CG_SUB2
>> > +cgcreate -g misc:$TEST_CG_SUB3
>> > +cgcreate -g misc:$TEST_CG_SUB4
>> > +
>> > +# Default to V2
>> > +CG_MISC_ROOT=/sys/fs/cgroup
>> > +CG_MEM_ROOT=/sys/fs/cgroup
>> > +CG_V1=0
>> > +if [ ! -d "/sys/fs/cgroup/misc" ]; then
>> > +    echo "# cgroup V2 is in use."
>> > +else
>> > +    echo "# cgroup V1 is in use."
>>
>> Is "#" prefix a standard for kselftest? I don't know this, thus asking.
>>
>> > +    CG_MISC_ROOT=/sys/fs/cgroup/misc
>> > +    CG_MEM_ROOT=/sys/fs/cgroup/memory
>> > +    CG_V1=1
>>
>> Have you checked what is the indentation policy for bash scripts inside
>> kernel tree. I don't know what it is. That's why I'm asking.
>>
>> > +fi
>> > +
>> > +CAPACITY=$(grep "sgx_epc" "$CG_MISC_ROOT/misc.capacity" | awk
>> > '{print $2}')
>> > +# This is below number of VA pages needed for enclave of capacity
>> > size. So
>> > +# should fail oversubscribed cases
>> > +SMALL=$(( CAPACITY / 512 ))
>> > +
>> > +# At least load one enclave of capacity size successfully, maybe up
>> > to 4.
>> > +# But some may fail if we run more than 4 concurrent enclaves of
>> > capacity size.
>> > +LARGE=$(( SMALL * 4 ))
>> > +
>> > +# Load lots of enclaves
>> > +LARGER=$CAPACITY
>> > +echo "# Setting up limits."
>> > +echo "sgx_epc $SMALL" > $CG_MISC_ROOT/$TEST_CG_SUB1/misc.max
>> > +echo "sgx_epc $LARGE" >  $CG_MISC_ROOT/$TEST_CG_SUB2/misc.max
>> > +echo "sgx_epc $LARGER" > $CG_MISC_ROOT/$TEST_CG_SUB4/misc.max
>> > +
>> > +timestamp=$(date +%Y%m%d_%H%M%S)
>> > +
>> > +test_cmd="./test_sgx -t unclobbered_vdso_oversubscribed"
>> > +
>> > +wait_check_process_status() {
>> > +    local pid=$1
>> > +    local check_for_success=$2  # If 1, check for success;
>> > +                                # If 0, check for failure
>> > +    wait "$pid"
>> > +    local status=$?
>> > +
>> > +    if [[ $check_for_success -eq 1 && $status -eq 0 ]]; then
>> > +        echo "# Process $pid succeeded."
>> > +        return 0
>> > +    elif [[ $check_for_success -eq 0 && $status -ne 0 ]]; then
>> > +        echo "# Process $pid returned failure."
>> > +        return 0
>> > +    fi
>> > +    return 1
>> > +}
>> > +
>> > +wai
>> > wait_and_detect_for_any() {
>>
>> what is "any"?
>>
>> Maybe for some key functions could have short documentation what they
>> are and for what test uses them. I cannot possibly remember all of this
>> just by hints such as "this waits for Any" ;-)
>>
>> I don't think there is actual kernel guideline to engineer the script
>> to work with just ash but at least for me that would inevitably
>> increase my motivation to test this patch set more rather than less.
>
> I also wonder is cgroup-tools dependency absolutely required or could
> you just have a function that would interact with sysfs?

I should have checked email before hit the send button for v10 :-).

It'd be more complicated and less readable to do all the stuff without the  
cgroup-tools, esp cgexec. I checked dependency, cgroup-tools only depends  
on libc so I hope this would not cause too much inconvenience.

I saw bash was also used in cgroup test scripts so at least that's  
consistent :-)
I can look into ash if that's required. Let me know.

Certainly can add more docs as you suggested.
Thanks
Haitao

