Return-Path: <cgroups+bounces-2756-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 100658BA507
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 03:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19FA2B20F96
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 01:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD1E10949;
	Fri,  3 May 2024 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScvmS01x"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D63FC0C;
	Fri,  3 May 2024 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700704; cv=none; b=EWoDoXPY+uFWt8aPj+Odn5CfIApZGzQWPW/yq4lou8Iws0mv0HOGHMtIwSInu05Uc4nUivAa9ZvgzzSWaYHOapwYFXHLD61+jIp87PntRzgEqHoH4mGd0LISungr4Aicqh9rw5sVxLhSN8Dir3oHxySMTnNclroBAqNCSpf42e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700704; c=relaxed/simple;
	bh=6KMomhSz8zhsXPFTxWfV/8aUvl/7zXaRfUMTLeJdIF8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=brKNEiQwL61dyMsOQDjH83SsyTWyWaH2i2PwC8KxLAi+DkxLhW2j7gtDKdy/UcKiLeRijgsqgsLRPpP0skH1XF53ODwvmBfcB6QMFYV2Xc1GaUwLNmOmtNgHoDvseW2OzLAuCznDxaQMrLvfgPdJZx1C0sdXqEvhWkCDSaCJZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScvmS01x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8A4C113CC;
	Fri,  3 May 2024 01:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714700704;
	bh=6KMomhSz8zhsXPFTxWfV/8aUvl/7zXaRfUMTLeJdIF8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ScvmS01xy5teHAUmnYU1nnIhcIacQF7nuu72Gj97qy7S/6MvT1FiTsx3RRdjBZiCz
	 PBBkS+zDlmatJ28bsEtNp9seqSbMeyc575YxJPDV/0fX2PA1Z3/pG+QpWQzJlCAZ7U
	 tCXOr1/tyiPwDfnCH9MWqlzhFMDOg+ebjPH+J64gKytUYYMWrfmtIdy3C0KT020xo7
	 R/zKaLPvNe5B16p82MwM5izfpl7a8iymkpkeivlPwDXwnMAatE35bJvkScj9hrfcMb
	 2sFDfSxJxSDW2TVsqM7LvuWOqEbLQX1jkZOfKzhpjW5gyx41s/+Am5GqLTB9BMTK3I
	 xWJsaXMUMiuXQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 May 2024 04:44:57 +0300
Message-Id: <D0ZMO1P1SE1I.3BP2LLE1Q0IJA@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v13 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
 <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240430195108.5676-1-haitao.huang@linux.intel.com>
 <20240430195108.5676-15-haitao.huang@linux.intel.com>
In-Reply-To: <20240430195108.5676-15-haitao.huang@linux.intel.com>

On Tue Apr 30, 2024 at 10:51 PM EEST, Haitao Huang wrote:
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

Here's the transcript:

make: Entering directory '/home/jarkko/linux-tpmdd/tools/testing/selftests/=
sgx'
gcc -Wall -Werror -g -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../=
../../tools/include -fPIC -c main.c -o /home/jarkko/linux-tpmdd/tools/testi=
ng/selftests/sgx/main.o
gcc -Wall -Werror -g -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../=
../../tools/include -fPIC -c load.c -o /home/jarkko/linux-tpmdd/tools/testi=
ng/selftests/sgx/load.o
gcc -Wall -Werror -g -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../=
../../tools/include -fPIC -c sigstruct.c -o /home/jarkko/linux-tpmdd/tools/=
testing/selftests/sgx/sigstruct.o
gcc -Wall -Werror -g -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../=
../../tools/include -fPIC -c call.S -o /home/jarkko/linux-tpmdd/tools/testi=
ng/selftests/sgx/call.o
gcc -Wall -Werror -g -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../=
../../tools/include -fPIC -c sign_key.S -o /home/jarkko/linux-tpmdd/tools/t=
esting/selftests/sgx/sign_key.o
gcc -Wall -Werror -g -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../=
../../tools/include -fPIC -o /home/jarkko/linux-tpmdd/tools/testing/selftes=
ts/sgx/test_sgx /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/main.o=
 /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/load.o /home/jarkko/l=
inux-tpmdd/tools/testing/selftests/sgx/sigstruct.o /home/jarkko/linux-tpmdd=
/tools/testing/selftests/sgx/call.o /home/jarkko/linux-tpmdd/tools/testing/=
selftests/sgx/sign_key.o -z noexecstack -lcrypto
gcc -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE -fno-stack-pro=
tector -mrdrnd -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../../../=
tools/include test_encl.c test_encl_bootstrap.S -o /home/jarkko/linux-tpmdd=
/tools/testing/selftests/sgx/test_encl.elf -Wl,-T,test_encl.lds,--build-id=
=3Dnone
/usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: w=
arning: /tmp/ccToNCLw.o: missing .note.GNU-stack section implies executable=
 stack
/usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: N=
OTE: This behaviour is deprecated and will be removed in a future version o=
f the linker
TAP version 13
1..2
# timeout set to 120
# selftests: sgx: test_sgx
# TAP version 13
# 1..16
# # Starting 16 tests from 1 test cases.
# #  RUN           enclave.unclobbered_vdso ...
# #            OK  enclave.unclobbered_vdso
# ok 1 enclave.unclobbered_vdso
# #  RUN           enclave.unclobbered_vdso_oversubscribed ...
# #            OK  enclave.unclobbered_vdso_oversubscribed
# ok 2 enclave.unclobbered_vdso_oversubscribed
# #  RUN           enclave.unclobbered_vdso_oversubscribed_remove ...
# # main.c:402:unclobbered_vdso_oversubscribed_remove:Creating an enclave w=
ith 98566144 bytes heap may take a while ...
# # main.c:457:unclobbered_vdso_oversubscribed_remove:Changing type of 9856=
6144 bytes to trimmed may take a while ...
# # main.c:473:unclobbered_vdso_oversubscribed_remove:Entering enclave to r=
un EACCEPT for each page of 98566144 bytes may take a while ...
# # main.c:494:unclobbered_vdso_oversubscribed_remove:Removing 98566144 byt=
es from enclave may take a while ...
# #            OK  enclave.unclobbered_vdso_oversubscribed_remove
# ok 3 enclave.unclobbered_vdso_oversubscribed_remove
# #  RUN           enclave.clobbered_vdso ...
# #            OK  enclave.clobbered_vdso
# ok 4 enclave.clobbered_vdso
# #  RUN           enclave.clobbered_vdso_and_user_function ...
# #            OK  enclave.clobbered_vdso_and_user_function
# ok 5 enclave.clobbered_vdso_and_user_function
# #  RUN           enclave.tcs_entry ...
# #            OK  enclave.tcs_entry
# ok 6 enclave.tcs_entry
# #  RUN           enclave.pte_permissions ...
# #            OK  enclave.pte_permissions
# ok 7 enclave.pte_permissions
# #  RUN           enclave.tcs_permissions ...
# #            OK  enclave.tcs_permissions
# ok 8 enclave.tcs_permissions
# #  RUN           enclave.epcm_permissions ...
# #            OK  enclave.epcm_permissions
# ok 9 enclave.epcm_permissions
# #  RUN           enclave.augment ...
# #            OK  enclave.augment
# ok 10 enclave.augment
# #  RUN           enclave.augment_via_eaccept ...
# #            OK  enclave.augment_via_eaccept
# ok 11 enclave.augment_via_eaccept
# #  RUN           enclave.tcs_create ...
# #            OK  enclave.tcs_create
# ok 12 enclave.tcs_create
# #  RUN           enclave.remove_added_page_no_eaccept ...
# #            OK  enclave.remove_added_page_no_eaccept
# ok 13 enclave.remove_added_page_no_eaccept
# #  RUN           enclave.remove_added_page_invalid_access ...
# #            OK  enclave.remove_added_page_invalid_access
# ok 14 enclave.remove_added_page_invalid_access
# #  RUN           enclave.remove_added_page_invalid_access_after_eaccept .=
..
# #            OK  enclave.remove_added_page_invalid_access_after_eaccept
# ok 15 enclave.remove_added_page_invalid_access_after_eaccept
# #  RUN           enclave.remove_untouched_page ...
# #            OK  enclave.remove_untouched_page
# ok 16 enclave.remove_untouched_page
# # PASSED: 16 / 16 tests passed.
# # Totals: pass:16 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sgx: test_sgx
# timeout set to 120
# selftests: sgx: run_epc_cg_selftests.sh
# # Setting up SGX cgroup limits.
# ./run_epc_cg_selftests.sh: line 129: echo: write error: Invalid argument
# # Failed setting up misc limits for sgx_epc.
# SKIP: Kernel does not support SGX cgroup.
ok 2 selftests: sgx: run_epc_cg_selftests.sh # SKIP
make: Leaving directory '/home/jarkko/linux-tpmdd/tools/testing/selftests/s=
gx'
jarkko@mustatorvisieni:~/linux-tpmdd> zcat /proc/config.gz | grep GROUP_MIS=
C
CONFIG_CGROUP_MISC=3Dy

BR, Jarkko

