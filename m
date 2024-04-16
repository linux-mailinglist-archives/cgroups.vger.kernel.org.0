Return-Path: <cgroups+bounces-2518-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CCE8A6D88
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 16:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501661F217DB
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F5513049C;
	Tue, 16 Apr 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rc9wnS+M"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D043C130E44;
	Tue, 16 Apr 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276619; cv=none; b=XpA4B93/FedZYIwGrs99MD0AQDoKT/Fwh7ExthZVkJhl+QSp/t+n56FyhezoiWkfPNX33pjbeIethpYwzfAnOs3S9i+h5PSDIz4JtraU1R2sQaF8QshDN7TAzBJqlm9fVMm/dfJ5PAaAnaYgrVPcsoHdDc+EFHJcaaX8QptDlsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276619; c=relaxed/simple;
	bh=CnqFUzo8UL/kd/hyzPQiXIi6sHVHjTGA/XehLo3EEAk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=OR2dc6CWtiBKgEN4U4UYHh0Gd/NbuRnbXc/lpYP2/YQB+zzzgeokNbnyxc9O+YLNn9xaUj+H3NdTWaVAhgcR+l/yF7K5mNj4TmEf4jWKdFPZxDz6/Q96EAYaSigLW/kgxh3pRQU3WTQ4YkUd6iFX2wFXJ9ohAHhBUs77EZ+Jksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rc9wnS+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75FFC32786;
	Tue, 16 Apr 2024 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276619;
	bh=CnqFUzo8UL/kd/hyzPQiXIi6sHVHjTGA/XehLo3EEAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rc9wnS+M/4NNuIAcdlGbCdArukIVQa7MRbKshkWBfu0bAlSGsTZnjaM5GpWNA+pn7
	 OImx3KIosCJC0nj+BdMGAGeFKeJoS60S+UmZbwPHfsEdL1D2hRwJLYzrzzxhiIvEU0
	 TPoM9i7iIG24HKYrMFK7P2K5jlpdZgUjpBDBFi9rh99R/uqVtNpVZmdQFfndlYutMP
	 r9NIF7AJDEiOws0Al7PmhSMpwGZYc6od/dRzMHHq2lKvltw7EJRKUqs1ZcWfZ/EhL0
	 oQ3XBb9xaeF5huxlUFSXK0+BlTRqBF4IpiVSz9N/JixSoVFCcr2LVfUI4noJSNGyt/
	 ptMF0i9e9F+Fw==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Apr 2024 17:10:12 +0300
Message-Id: <D0LLVE07V8O0.S8XF3CY2DQ9A@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Haitao Huang"
 <haitao.huang@linux.intel.com>, <dave.hansen@linux.intel.com>,
 <kai.huang@intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
X-Mailer: aerc 0.17.0
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
 <D0LLS28WEXYA.G15BAG7WOJGR@kernel.org>
In-Reply-To: <D0LLS28WEXYA.G15BAG7WOJGR@kernel.org>

On Tue Apr 16, 2024 at 5:05 PM EEST, Jarkko Sakkinen wrote:
> On Tue Apr 16, 2024 at 6:20 AM EEST, Haitao Huang wrote:
> > With different cgroups, the script starts one or multiple concurrent SG=
X
> > selftests (test_sgx), each to run the unclobbered_vdso_oversubscribed
> > test case, which loads an enclave of EPC size equal to the EPC capacity
> > available on the platform. The script checks results against the
> > expectation set for each cgroup and reports success or failure.
> >
> > The script creates 3 different cgroups at the beginning with following
> > expectations:
> >
> > 1) SMALL - intentionally small enough to fail the test loading an
> > enclave of size equal to the capacity.
> > 2) LARGE - large enough to run up to 4 concurrent tests but fail some i=
f
> > more than 4 concurrent tests are run. The script starts 4 expecting at
> > least one test to pass, and then starts 5 expecting at least one test
> > to fail.
> > 3) LARGER - limit is the same as the capacity, large enough to run lots=
 of
> > concurrent tests. The script starts 8 of them and expects all pass.
> > Then it reruns the same test with one process randomly killed and
> > usage checked to be zero after all processes exit.
> >
> > The script also includes a test with low mem_cg limit and LARGE sgx_epc
> > limit to verify that the RAM used for per-cgroup reclamation is charged
> > to a proper mem_cg. For this test, it turns off swapping before start,
> > and turns swapping back on afterwards.
> >
> > Add README to document how to run the tests.
> >
> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>
> jarkko@mustatorvisieni:~/linux-tpmdd> sudo make -C tools/testing/selftest=
s/sgx run_tests
> make: Entering directory '/home/jarkko/linux-tpmdd/tools/testing/selftest=
s/sgx'
> gcc -Wall -Werror -g -I/home/jarkko/linux-tpmdd/tools/testing/selftests/.=
./../../tools/include -fPIC -c main.c -o /home/jarkko/linux-tpmdd/tools/tes=
ting/selftests/sgx/main.o
> gcc -Wall -Werror -g -I/home/jarkko/linux-tpmdd/tools/testing/selftests/.=
./../../tools/include -fPIC -c load.c -o /home/jarkko/linux-tpmdd/tools/tes=
ting/selftests/sgx/load.o
> gcc -Wall -Werror -g -I/home/jarkko/linux-tpmdd/tools/testing/selftests/.=
./../../tools/include -fPIC -c sigstruct.c -o /home/jarkko/linux-tpmdd/tool=
s/testing/selftests/sgx/sigstruct.o
> gcc -Wall -Werror -g -I/home/jarkko/linux-tpmdd/tools/testing/selftests/.=
./../../tools/include -fPIC -c call.S -o /home/jarkko/linux-tpmdd/tools/tes=
ting/selftests/sgx/call.o
> gcc -Wall -Werror -g -I/home/jarkko/linux-tpmdd/tools/testing/selftests/.=
./../../tools/include -fPIC -c sign_key.S -o /home/jarkko/linux-tpmdd/tools=
/testing/selftests/sgx/sign_key.o
> gcc -Wall -Werror -g -I/home/jarkko/linux-tpmdd/tools/testing/selftests/.=
./../../tools/include -fPIC -o /home/jarkko/linux-tpmdd/tools/testing/selft=
ests/sgx/test_sgx /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/main=
.o /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/load.o /home/jarkko=
/linux-tpmdd/tools/testing/selftests/sgx/sigstruct.o /home/jarkko/linux-tpm=
dd/tools/testing/selftests/sgx/call.o /home/jarkko/linux-tpmdd/tools/testin=
g/selftests/sgx/sign_key.o -z noexecstack -lcrypto
> gcc -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE -fno-stack-p=
rotector -mrdrnd -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../../.=
./tools/include test_encl.c test_encl_bootstrap.S -o /home/jarkko/linux-tpm=
dd/tools/testing/selftests/sgx/test_encl.elf -Wl,-T,test_encl.lds,--build-i=
d=3Dnone
> /usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld:=
 warning: /tmp/ccqvDJVg.o: missing .note.GNU-stack section implies executab=
le stack
> /usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld:=
 NOTE: This behaviour is deprecated and will be removed in a future version=
 of the linker
> TAP version 13
> 1..2
> # timeout set to 45
> # selftests: sgx: test_sgx
> # TAP version 13
> # 1..16
> # # Starting 16 tests from 1 test cases.
> # #  RUN           enclave.unclobbered_vdso ...
> # #            OK  enclave.unclobbered_vdso
> # ok 1 enclave.unclobbered_vdso
> # #  RUN           enclave.unclobbered_vdso_oversubscribed ...
> # #            OK  enclave.unclobbered_vdso_oversubscribed
> # ok 2 enclave.unclobbered_vdso_oversubscribed
> # #  RUN           enclave.unclobbered_vdso_oversubscribed_remove ...
> # # main.c:402:unclobbered_vdso_oversubscribed_remove:Creating an enclave=
 with 98566144 bytes heap may take a while ...
> # # main.c:457:unclobbered_vdso_oversubscribed_remove:Changing type of 98=
566144 bytes to trimmed may take a while ...
> # # main.c:473:unclobbered_vdso_oversubscribed_remove:Entering enclave to=
 run EACCEPT for each page of 98566144 bytes may take a while ...
> # # main.c:494:unclobbered_vdso_oversubscribed_remove:Removing 98566144 b=
ytes from enclave may take a while ...
> # #            OK  enclave.unclobbered_vdso_oversubscribed_remove
> # ok 3 enclave.unclobbered_vdso_oversubscribed_remove
> # #  RUN           enclave.clobbered_vdso ...
> # #            OK  enclave.clobbered_vdso
> # ok 4 enclave.clobbered_vdso
> # #  RUN           enclave.clobbered_vdso_and_user_function ...
> # #            OK  enclave.clobbered_vdso_and_user_function
> # ok 5 enclave.clobbered_vdso_and_user_function
> # #  RUN           enclave.tcs_entry ...
> # #            OK  enclave.tcs_entry
> # ok 6 enclave.tcs_entry
> # #  RUN           enclave.pte_permissions ...
> # #            OK  enclave.pte_permissions
> # ok 7 enclave.pte_permissions
> # #  RUN           enclave.tcs_permissions ...
> # #            OK  enclave.tcs_permissions
> # ok 8 enclave.tcs_permissions
> # #  RUN           enclave.epcm_permissions ...
> # #            OK  enclave.epcm_permissions
> # ok 9 enclave.epcm_permissions
> # #  RUN           enclave.augment ...
> # #            OK  enclave.augment
> # ok 10 enclave.augment
> # #  RUN           enclave.augment_via_eaccept ...
> # #            OK  enclave.augment_via_eaccept
> # ok 11 enclave.augment_via_eaccept
> # #  RUN           enclave.tcs_create ...
> # #            OK  enclave.tcs_create
> # ok 12 enclave.tcs_create
> # #  RUN           enclave.remove_added_page_no_eaccept ...
> # #            OK  enclave.remove_added_page_no_eaccept
> # ok 13 enclave.remove_added_page_no_eaccept
> # #  RUN           enclave.remove_added_page_invalid_access ...
> # #            OK  enclave.remove_added_page_invalid_access
> # ok 14 enclave.remove_added_page_invalid_access
> # #  RUN           enclave.remove_added_page_invalid_access_after_eaccept=
 ...
> # #            OK  enclave.remove_added_page_invalid_access_after_eaccept
> # ok 15 enclave.remove_added_page_invalid_access_after_eaccept
> # #  RUN           enclave.remove_untouched_page ...
> # #            OK  enclave.remove_untouched_page
> # ok 16 enclave.remove_untouched_page
> # # PASSED: 16 / 16 tests passed.
> # # Totals: pass:16 fail:0 xfail:0 xpass:0 skip:0 error:0
> ok 1 selftests: sgx: test_sgx
> # timeout set to 45
> # selftests: sgx: run_epc_cg_selftests.sh
> # # Setting up limits.
> # ./run_epc_cg_selftests.sh: line 50: echo: write error: Invalid argument
> # # Failed setting up misc limits.
> not ok 2 selftests: sgx: run_epc_cg_selftests.sh # exit=3D1
> make: Leaving directory '/home/jarkko/linux-tpmdd/tools/testing/selftests=
/sgx'
>
> This is what happens now.
>
> BTW, I noticed a file that should not exist, i.e. README. Only thing
> that should exist is the tests for kselftest and anything else should
> not exist at all, so this file by definiton should not exist.

I'd suggest to sanity-check the kselftest with a person from Intel who
has worked with kselftest before the next version so that it will be
nailed next time. Or better internal review this single patch with a=20
person with expertise on kernel QA.

I did not check this but I have also suspicion that it might have some
checks whetehr it is run as root or not. If there are any, those should
be removed too. Let people set their environment however want...

BR, Jarkko

