Return-Path: <cgroups+bounces-2529-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990518A6F16
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 16:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE961C21CB9
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286B012F58A;
	Tue, 16 Apr 2024 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwJcvwvw"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25812F393;
	Tue, 16 Apr 2024 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279295; cv=none; b=R40yqxng8JCs2iH13XqUKyMW3iHEr1z9T7NqLwEP3o7rQrikSbtDCDjgnZzyeBHwFNVnxCE91PSfAq7xqHnPmMKO4fpU7hcylk3H837NRoFKw4H9u/q2f2XHwebUuIvQQzqpUKUskdeKqqCe0qCiv9lU2Dj6RRQ6on2MRIhD2nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279295; c=relaxed/simple;
	bh=WaRyDgdlQWs65FxF41w16qUbnfyOcRTcX21F7HNRP+I=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=hFnwUl6bVsEEeJ0uaRFMplk1hks3oR2JhkUQfUGkfVB9y9v+Vm90ZPuJcUQSdiY/9tyn4GQ/pXkue5lY7GEBocqF4MGwJDJtPN2WIfRORhZQTUGmQnlwhABxrkd9yt5bWPuCmBqNGHeCHDLsV2nFOhBx6PeNMCjUMwKjbMs8HAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwJcvwvw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713279295; x=1744815295;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=WaRyDgdlQWs65FxF41w16qUbnfyOcRTcX21F7HNRP+I=;
  b=gwJcvwvwvslzLuViltRyhvgddRUvotpcVlRcMw5YuucZwPTyJOiqCo1n
   iwJepJaVkl58xkVPNzjpe/ncM6UF5DM6DL3sR01MRSDvdAt9qLpD85FA6
   pb51gEo8WHKWDPL7FpS5xpbIvVxgYNzk0SI76cvv6vD+sibhVjcSkH3kG
   Al/3wRmfvHPGltifQRNTD8Au27swi6nmYMEtjhSHgAry2bCjnIBquxHS3
   T8YBod4AUxquyFItjTojzMwVE+QH2hC5/8/Ng7gGmnI5WFgn18uGrdxQ9
   vOOqbHdvWOa+Pi18w8dWcrDajPXUMl2DOi5tai5epp/wja6OubD2mUBf4
   Q==;
X-CSE-ConnectionGUID: 3tdmy6wkSHegU9SUXOvsng==
X-CSE-MsgGUID: +WxKgCuDTfGTqfIyitkXJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12509102"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="12509102"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:54:53 -0700
X-CSE-ConnectionGUID: Vru/2TEcQdGvvQwbD8yg3A==
X-CSE-MsgGUID: AoyMiLnKRwuS0fHRMOMAxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22339088"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 16 Apr 2024 07:54:50 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
 kai.huang@intel.com, tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
 <D0LLS28WEXYA.G15BAG7WOJGR@kernel.org> <D0LLVE07V8O0.S8XF3CY2DQ9A@kernel.org>
Date: Tue, 16 Apr 2024 09:54:48 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mbs1m05wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <D0LLVE07V8O0.S8XF3CY2DQ9A@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 16 Apr 2024 09:10:12 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Tue Apr 16, 2024 at 5:05 PM EEST, Jarkko Sakkinen wrote:
>> On Tue Apr 16, 2024 at 6:20 AM EEST, Haitao Huang wrote:
>> > With different cgroups, the script starts one or multiple concurrent  
>> SGX
>> > selftests (test_sgx), each to run the unclobbered_vdso_oversubscribed
>> > test case, which loads an enclave of EPC size equal to the EPC  
>> capacity
>> > available on the platform. The script checks results against the
>> > expectation set for each cgroup and reports success or failure.
>> >
>> > The script creates 3 different cgroups at the beginning with following
>> > expectations:
>> >
>> > 1) SMALL - intentionally small enough to fail the test loading an
>> > enclave of size equal to the capacity.
>> > 2) LARGE - large enough to run up to 4 concurrent tests but fail some  
>> if
>> > more than 4 concurrent tests are run. The script starts 4 expecting at
>> > least one test to pass, and then starts 5 expecting at least one test
>> > to fail.
>> > 3) LARGER - limit is the same as the capacity, large enough to run  
>> lots of
>> > concurrent tests. The script starts 8 of them and expects all pass.
>> > Then it reruns the same test with one process randomly killed and
>> > usage checked to be zero after all processes exit.
>> >
>> > The script also includes a test with low mem_cg limit and LARGE  
>> sgx_epc
>> > limit to verify that the RAM used for per-cgroup reclamation is  
>> charged
>> > to a proper mem_cg. For this test, it turns off swapping before start,
>> > and turns swapping back on afterwards.
>> >
>> > Add README to document how to run the tests.
>> >
>> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>>
>> jarkko@mustatorvisieni:~/linux-tpmdd> sudo make -C  
>> tools/testing/selftests/sgx run_tests
>> make: Entering directory  
>> '/home/jarkko/linux-tpmdd/tools/testing/selftests/sgx'
>> gcc -Wall -Werror -g  
>> -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../../../tools/include  
>> -fPIC -c main.c -o  
>> /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/main.o
>> gcc -Wall -Werror -g  
>> -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../../../tools/include  
>> -fPIC -c load.c -o  
>> /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/load.o
>> gcc -Wall -Werror -g  
>> -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../../../tools/include  
>> -fPIC -c sigstruct.c -o  
>> /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/sigstruct.o
>> gcc -Wall -Werror -g  
>> -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../../../tools/include  
>> -fPIC -c call.S -o  
>> /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/call.o
>> gcc -Wall -Werror -g  
>> -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../../../tools/include  
>> -fPIC -c sign_key.S -o  
>> /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/sign_key.o
>> gcc -Wall -Werror -g  
>> -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../../../tools/include  
>> -fPIC -o /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/test_sgx  
>> /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/main.o  
>> /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/load.o  
>> /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/sigstruct.o  
>> /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/call.o  
>> /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/sign_key.o -z  
>> noexecstack -lcrypto
>> gcc -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE  
>> -fno-stack-protector -mrdrnd  
>> -I/home/jarkko/linux-tpmdd/tools/testing/selftests/../../../tools/include  
>> test_encl.c test_encl_bootstrap.S -o  
>> /home/jarkko/linux-tpmdd/tools/testing/selftests/sgx/test_encl.elf  
>> -Wl,-T,test_encl.lds,--build-id=none
>> /usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld:  
>> warning: /tmp/ccqvDJVg.o: missing .note.GNU-stack section implies  
>> executable stack
>> /usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld:  
>> NOTE: This behaviour is deprecated and will be removed in a future  
>> version of the linker
>> TAP version 13
>> 1..2
>> # timeout set to 45
>> # selftests: sgx: test_sgx
>> # TAP version 13
>> # 1..16
>> # # Starting 16 tests from 1 test cases.
>> # #  RUN           enclave.unclobbered_vdso ...
>> # #            OK  enclave.unclobbered_vdso
>> # ok 1 enclave.unclobbered_vdso
>> # #  RUN           enclave.unclobbered_vdso_oversubscribed ...
>> # #            OK  enclave.unclobbered_vdso_oversubscribed
>> # ok 2 enclave.unclobbered_vdso_oversubscribed
>> # #  RUN           enclave.unclobbered_vdso_oversubscribed_remove ...
>> # # main.c:402:unclobbered_vdso_oversubscribed_remove:Creating an  
>> enclave with 98566144 bytes heap may take a while ...
>> # # main.c:457:unclobbered_vdso_oversubscribed_remove:Changing type of  
>> 98566144 bytes to trimmed may take a while ...
>> # # main.c:473:unclobbered_vdso_oversubscribed_remove:Entering enclave  
>> to run EACCEPT for each page of 98566144 bytes may take a while ...
>> # # main.c:494:unclobbered_vdso_oversubscribed_remove:Removing 98566144  
>> bytes from enclave may take a while ...
>> # #            OK  enclave.unclobbered_vdso_oversubscribed_remove
>> # ok 3 enclave.unclobbered_vdso_oversubscribed_remove
>> # #  RUN           enclave.clobbered_vdso ...
>> # #            OK  enclave.clobbered_vdso
>> # ok 4 enclave.clobbered_vdso
>> # #  RUN           enclave.clobbered_vdso_and_user_function ...
>> # #            OK  enclave.clobbered_vdso_and_user_function
>> # ok 5 enclave.clobbered_vdso_and_user_function
>> # #  RUN           enclave.tcs_entry ...
>> # #            OK  enclave.tcs_entry
>> # ok 6 enclave.tcs_entry
>> # #  RUN           enclave.pte_permissions ...
>> # #            OK  enclave.pte_permissions
>> # ok 7 enclave.pte_permissions
>> # #  RUN           enclave.tcs_permissions ...
>> # #            OK  enclave.tcs_permissions
>> # ok 8 enclave.tcs_permissions
>> # #  RUN           enclave.epcm_permissions ...
>> # #            OK  enclave.epcm_permissions
>> # ok 9 enclave.epcm_permissions
>> # #  RUN           enclave.augment ...
>> # #            OK  enclave.augment
>> # ok 10 enclave.augment
>> # #  RUN           enclave.augment_via_eaccept ...
>> # #            OK  enclave.augment_via_eaccept
>> # ok 11 enclave.augment_via_eaccept
>> # #  RUN           enclave.tcs_create ...
>> # #            OK  enclave.tcs_create
>> # ok 12 enclave.tcs_create
>> # #  RUN           enclave.remove_added_page_no_eaccept ...
>> # #            OK  enclave.remove_added_page_no_eaccept
>> # ok 13 enclave.remove_added_page_no_eaccept
>> # #  RUN           enclave.remove_added_page_invalid_access ...
>> # #            OK  enclave.remove_added_page_invalid_access
>> # ok 14 enclave.remove_added_page_invalid_access
>> # #  RUN            
>> enclave.remove_added_page_invalid_access_after_eaccept ...
>> # #            OK   
>> enclave.remove_added_page_invalid_access_after_eaccept
>> # ok 15 enclave.remove_added_page_invalid_access_after_eaccept
>> # #  RUN           enclave.remove_untouched_page ...
>> # #            OK  enclave.remove_untouched_page
>> # ok 16 enclave.remove_untouched_page
>> # # PASSED: 16 / 16 tests passed.
>> # # Totals: pass:16 fail:0 xfail:0 xpass:0 skip:0 error:0
>> ok 1 selftests: sgx: test_sgx
>> # timeout set to 45
>> # selftests: sgx: run_epc_cg_selftests.sh
>> # # Setting up limits.
>> # ./run_epc_cg_selftests.sh: line 50: echo: write error: Invalid  
>> argument
>> # # Failed setting up misc limits.
>> not ok 2 selftests: sgx: run_epc_cg_selftests.sh # exit=1
>> make: Leaving directory

This means no sgx cgroup turned on. (echoing sgx_epc entries into misc.max  
not allowed)
v12 removed the need for config CGROUP_SGX_EPC.
Did you by chance running on a previous kernel build without the sgx  
cgroup configured?

I did declare the configs in the config file but I missed it in my patch  
as stated earlier. IIUC, that would not cause this error though.

Maybe I should exit with the skip code if no CGROUP_MISC (no more  
CGROUP_SGX_EPC) is configured?

>> '/home/jarkko/linux-tpmdd/tools/testing/selftests/sgx'
>>
>> This is what happens now.
>>
>> BTW, I noticed a file that should not exist, i.e. README. Only thing
>> that should exist is the tests for kselftest and anything else should
>> not exist at all, so this file by definiton should not exist.
>
Could you point me to ths rule?

I felt some instructions needed as tests getting more complex, and was  
following examples:

tools/testing/selftests$ find . -name README
./futex/README
./tc-testing/README
./net/forwarding/README
./powerpc/nx-gzip/README
./ftrace/README
./arm64/signal/README
./arm64/fp/README
./arm64/README
./zram/README
./livepatch/README
./resctrl/README

> I'd suggest to sanity-check the kselftest with a person from Intel who
> has worked with kselftest before the next version so that it will be
> nailed next time. Or better internal review this single patch with a
> person with expertise on kernel QA.
>
I'll double check.

> I did not check this but I have also suspicion that it might have some
> checks whetehr it is run as root or not. If there are any, those should
> be removed too. Let people set their environment however want...
>
Do you mean this part?

+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+if [ "$(id -u)" -ne 0 ]; then
+    echo "SKIP: SGX Cgroup tests need root privileges."
+    exit $ksft_skip
+fi

I saw lots of similar code reported when I ran following in the selftests  
directory:

tools/testing/selftests$ grep -C 5 -r "root" */*.sh

Thanks
Haitao

