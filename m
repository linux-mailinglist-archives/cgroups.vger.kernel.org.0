Return-Path: <cgroups+bounces-2516-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAA48A6D4B
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 16:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8481A1F22DE3
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 14:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E3412C534;
	Tue, 16 Apr 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0r79liM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68F12C485;
	Tue, 16 Apr 2024 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276358; cv=none; b=b+z4rFK8SWRXs6S3GTma6ekxDmNNc/ZRjgAhIA1jIDcKa/FcLSWKz5KCCRtWYxXzZ2xdXjLvczg6F9ImWwmGxm6jN93FLr+z03uJrF6K8ymeXTui4clu1OoVAJg/GdQuY302g6sdyJvll4YrX3G2wPZk5APYrFuLb92wQA2vUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276358; c=relaxed/simple;
	bh=GW4b3JjjpzhyEgr0U37zkqjQS5CiLTeAstpJ8q/JZFw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bDw6ntiEFhsltMAKJZgDAUvxuUqjXXwam12E0F+G2Q9o6ZWFqn4dkjyFz+2ilKp13PNWrEPdb7FeCipkCsXpaSFFDCGCEHfxUkNQPPQwkP6IYNsyLJNHnsmLFs9ntbV4Um4J/dbL1SP32KHbKLyTYfRwptcZ8ZJ39KQ8ueGsU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0r79liM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D8FC2BD11;
	Tue, 16 Apr 2024 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276357;
	bh=GW4b3JjjpzhyEgr0U37zkqjQS5CiLTeAstpJ8q/JZFw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=a0r79liMkvsBhViEXn4XE6QleDlH/AJGLeB5n+/BVBlotBeJNnn8hAwhK30d55/yB
	 /hF0hI8/j4A5/tH1aKS7gPmqkwS+XkDBzYHw8mQaZ0vKJWejAyOYa4SMNjdv5MsTNo
	 DWWBeHyY099jZTeGY1Es3XOlD1FQzDJZTufrpVEgtRK3a+YPgTygu+apaBvLzJJpdp
	 BluSYTUE24rQqeZVRElwFhlyzyVbwuuyLPvc+DKA0UXjT38LFotuoleeI1riSwnNJE
	 xp51dBj8+vuspWsVcjqqMiuZjroQQRw15lPun3mzVxhBNIQZbd4iOlfTZNbfVQYMJZ
	 to9WKHuk8EMIg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Apr 2024 17:05:51 +0300
Message-Id: <D0LLS28WEXYA.G15BAG7WOJGR@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
 <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
In-Reply-To: <20240416032011.58578-15-haitao.huang@linux.intel.com>

On Tue Apr 16, 2024 at 6:20 AM EEST, Haitao Huang wrote:
> With different cgroups, the script starts one or multiple concurrent SGX
> selftests (test_sgx), each to run the unclobbered_vdso_oversubscribed
> test case, which loads an enclave of EPC size equal to the EPC capacity
> available on the platform. The script checks results against the
> expectation set for each cgroup and reports success or failure.
>
> The script creates 3 different cgroups at the beginning with following
> expectations:
>
> 1) SMALL - intentionally small enough to fail the test loading an
> enclave of size equal to the capacity.
> 2) LARGE - large enough to run up to 4 concurrent tests but fail some if
> more than 4 concurrent tests are run. The script starts 4 expecting at
> least one test to pass, and then starts 5 expecting at least one test
> to fail.
> 3) LARGER - limit is the same as the capacity, large enough to run lots o=
f
> concurrent tests. The script starts 8 of them and expects all pass.
> Then it reruns the same test with one process randomly killed and
> usage checked to be zero after all processes exit.
>
> The script also includes a test with low mem_cg limit and LARGE sgx_epc
> limit to verify that the RAM used for per-cgroup reclamation is charged
> to a proper mem_cg. For this test, it turns off swapping before start,
> and turns swapping back on afterwards.
>
> Add README to document how to run the tests.
>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

jarkko@mustatorvisieni:~/linux-tpmdd> sudo make -C tools/testing/selftests/=
sgx run_tests
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
arning: /tmp/ccqvDJVg.o: missing .note.GNU-stack section implies executable=
 stack
/usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: N=
OTE: This behaviour is deprecated and will be removed in a future version o=
f the linker
TAP version 13
1..2
# timeout set to 45
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
# timeout set to 45
# selftests: sgx: run_epc_cg_selftests.sh
# # Setting up limits.
# ./run_epc_cg_selftests.sh: line 50: echo: write error: Invalid argument
# # Failed setting up misc limits.
not ok 2 selftests: sgx: run_epc_cg_selftests.sh # exit=3D1
make: Leaving directory '/home/jarkko/linux-tpmdd/tools/testing/selftests/s=
gx'

This is what happens now.

BTW, I noticed a file that should not exist, i.e. README. Only thing
that should exist is the tests for kselftest and anything else should
not exist at all, so this file by definiton should not exist.

BR, Jarkko

