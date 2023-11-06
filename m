Return-Path: <cgroups+bounces-179-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EFD7E1932
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 04:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233AD1C20A1E
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 03:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF506EDC;
	Mon,  6 Nov 2023 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXTLJ/mX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880BECA
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 03:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7787C433C9;
	Mon,  6 Nov 2023 03:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699241210;
	bh=16hEpJyK4t6U7gx49fwTY6bI15ZJiHsgzXQDYDHEELE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PXTLJ/mX6yE/jYLi6RbCsBx4yIXEgI0n3lsYK6FY08SbW9f8vYCByzPywC6hW4+vp
	 qiEG4b7fGCVB/3YWjuh25f+lRX73XGbO5IKHQVoLNn8zFfJR24quxvPUb8fqM6i0gS
	 J6GnBUwPmVqyVvjNSVw0QaP4u6jnU2int4YlF3GrvCB/EOpd6pFUa7+u/oaS6k1a3q
	 hP/F2IP78ShycL4U3hs2n/dgGFedGsGgKfOo46oO1Fot4ZfHtIR/4Al+uFiPwBbi9m
	 iUDBQsukSzgMCZlLXiorM3hESZ8EfCtGMQJPpQH8wb5gEvURI2q7CJiYZ5pnL/2NMs
	 Z4Cm3uJoLe8RA==
Message-ID: <b4581a686daf943a4c9a24373db0dfd58b7fecd7.camel@kernel.org>
Subject: Re: [PATCH v6 00/12] Add Cgroup support for SGX EPC memory
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Haitao Huang <haitao.huang@linux.intel.com>,
 dave.hansen@linux.intel.com,  tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org,  linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org,  tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com,  sohil.mehta@intel.com
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com, 
	zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com, 
	yangjie@microsoft.com
Date: Mon, 06 Nov 2023 05:26:44 +0200
In-Reply-To: <20231030182013.40086-1-haitao.huang@linux.intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
Autocrypt: addr=jarkko@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-30 at 11:20 -0700, Haitao Huang wrote:
> SGX Enclave Page Cache (EPC) memory allocations are separate from normal =
RAM allocations, and
> are managed solely by the SGX subsystem. The existing cgroup memory contr=
oller cannot be used
> to limit or account for SGX EPC memory, which is a desirable feature in s=
ome environments,
> e.g., support for pod level control in a Kubernates cluster on a VM or ba=
remetal host [1,2].
> =C2=A0
> This patchset implements the support for sgx_epc memory within the misc c=
group controller. The
> user can use the misc cgroup controller to set and enforce a max limit on=
 total EPC usage per
> cgroup. The implementation reports current usage and events of reaching t=
he limit per cgroup as
> well as the total system capacity.
> =C2=A0
> With the EPC misc controller enabled, every EPC page allocation is accoun=
ted for a cgroup's
> usage, reflected in the 'sgx_epc' entry in the 'misc.current' interface f=
ile of the cgroup.
> Much like normal system memory, EPC memory can be overcommitted via virtu=
al memory techniques
> and pages can be swapped out of the EPC to their backing store (normal sy=
stem memory allocated
> via shmem, accounted by the memory controller). When the EPC usage of a c=
group reaches its hard
> limit ('sgx_epc' entry in the 'misc.max' file), the cgroup starts a recla=
mation process to swap
> out some EPC pages within the same cgroup and its descendant to their bac=
king store. Although
> the SGX architecture supports swapping for all pages, to avoid extra comp=
lexities, this
> implementation does not support swapping for certain page types, e.g.=C2=
=A0 Version Array(VA) pages,
> and treat them as unreclaimable pages.=C2=A0 When the limit is reached bu=
t nothing left in the
> cgroup for reclamation, i.e., only unreclaimable pages left, any new EPC =
allocation in the
> cgroup will result in an ENOMEM error.
>=20
> The EPC pages allocated for guest VMs by the virtual EPC driver are not r=
eclaimable by the host
> kernel [5]. Therefore they are also treated as unreclaimable from cgroup'=
s point of view.=C2=A0 And
> the virtual EPC driver translates an ENOMEM error resulted from an EPC al=
location request into
> a SIGBUS to the user process.
>=20
> This work was originally authored by Sean Christopherson a few years ago,=
 and previously
> modified by Kristen C. Accardi to utilize the misc cgroup controller rath=
er than a custom
> controller. I have been updating the patches based on review comments sin=
ce V2 [3, 4, 10],
> simplified the implementation/design and fixed some stability issues foun=
d from testing.
> =C2=A0
> The patches are organized as following:=20
> - Patches 1-3 are prerequisite misc cgroup changes for adding new APIs, s=
tructs, resource
> =C2=A0 types.
> - Patch 4 implements basic misc controller for EPC without reclamation.
> - Patches 5-9 prepare for per-cgroup reclamation.
> =C2=A0=C2=A0=C2=A0 * Separate out the existing infrastructure of tracking=
 reclaimable pages
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from the global reclaimer(ksgxd) to a newl=
y created LRU list struct.
> =C2=A0=C2=A0=C2=A0 * Separate out reusable top-level functions for reclam=
ation.
> - Patch 10 adds support for per-cgroup reclamation.
> - Patch 11 adds documentation for the EPC cgroup.
> - Patch 12 adds test scripts.
>=20
> I appreciate your review and providing tags if appropriate.
>=20
> ---
> V6:
> - Dropped OOM killing path, only implement non-preemptive enforcement of =
max limit (Dave, Michal)
> - Simplified reclamation flow by taking out sgx_epc_reclaim_control, forc=
ed reclamation by
> =C2=A0 ignoring 'age".
> - Restructured patches: split misc API + resource types patch and the big=
 EPC cgroup patch
> =C2=A0 (Kai, Michal)
> - Dropped some Tested-by/Reviewed-by tags due to significant changes
> - Added more selftests
>=20
> v5:
> - Replace the manual test script with a selftest script.
> - Restore the "From" tag for some patches to Sean (Kai)
> - Style fixes (Jarkko)
>=20
> v4:
> - Collected "Tested-by" from Mikko. I kept it for now as no functional ch=
anges in v4.
> - Rebased on to v6.6_rc1 and reordered patches as described above.
> - Separated out the bug fixes [7,8,9]. This series depend on those patche=
s. (Dave, Jarkko)
> - Added comments in commit message to give more preview what's to come ne=
xt. (Jarkko)
> - Fixed some documentation error, gap, style (Mikko, Randy)
> - Fixed some comments, typo, style in code (Mikko, Kai)
> - Patch format and background for reclaimable vs unreclaimable (Kai, Jark=
ko)
> - Fixed typo (Pavel)
> - Exclude the previous fixes/enhancements for self-tests. Patch 18 now de=
pends on series [6]
> - Use the same to list for cover and all patches. (Solo)
> =C2=A0
> v3:
> =C2=A0
> - Added EPC states to replace flags in sgx_epc_page struct. (Jarkko)
> - Unrolled wrappers for cond_resched, list (Dave)
> - Separate patches for adding reclaimable and unreclaimable lists. (Dave)
> - Other improvements on patch flow, commit messages, styles. (Dave, Jarkk=
o)
> - Simplified the cgroup tree walking with plain
> =C2=A0 css_for_each_descendant_pre.
> - Fixed race conditions and crashes.
> - OOM killer to wait for the victim enclave pages being reclaimed.
> - Unblock the user by handling misc_max_write callback asynchronously.
> - Rebased onto 6.4 and no longer base this series on the MCA patchset.
> - Fix an overflow in misc_try_charge.
> - Fix a NULL pointer in SGX PF handler.
> - Updated and included the SGX selftest patches previously reviewed. Thos=
e
> =C2=A0 patches fix issues triggered in high EPC pressure required for cgr=
oup
> =C2=A0 testing.
> - Added test scripts to help setup and test SGX EPC cgroups.
> =C2=A0
> [1]https://lore.kernel.org/all/DM6PR21MB11772A6ED915825854B419D6C4989@DM6=
PR21MB1177.namprd21.prod.outlook.com/
> [2]https://lore.kernel.org/all/ZD7Iutppjj+muH4p@himmelriiki/
> [3]https://lore.kernel.org/all/20221202183655.3767674-1-kristen@linux.int=
el.com/
> [4]https://lore.kernel.org/linux-sgx/20230712230202.47929-1-haitao.huang@=
linux.intel.com/
> [5]Documentation/arch/x86/sgx.rst, Section "Virtual EPC"
> [6]https://lore.kernel.org/linux-sgx/20220905020411.17290-1-jarkko@kernel=
.org/
> [7]https://lore.kernel.org/linux-sgx/ZLcXmvDKheCRYOjG@slm.duckdns.org/
> [8]https://lore.kernel.org/linux-sgx/20230721120231.13916-1-haitao.huang@=
linux.intel.com/
> [9]https://lore.kernel.org/linux-sgx/20230728051024.33063-1-haitao.huang@=
linux.intel.com/
> [10]https://lore.kernel.org/all/20230923030657.16148-1-haitao.huang@linux=
.intel.com/
>=20
> Haitao Huang (2):
> =C2=A0 x86/sgx: Introduce EPC page states
> =C2=A0 selftests/sgx: Add scripts for EPC cgroup testing
>=20
> Kristen Carlson Accardi (5):
> =C2=A0 cgroup/misc: Add per resource callbacks for CSS events
> =C2=A0 cgroup/misc: Export APIs for SGX driver
> =C2=A0 cgroup/misc: Add SGX EPC resource type
> =C2=A0 x86/sgx: Implement basic EPC misc cgroup functionality
> =C2=A0 x86/sgx: Implement EPC reclamation for cgroup
>=20
> Sean Christopherson (5):
> =C2=A0 x86/sgx: Add sgx_epc_lru_list to encapsulate LRU list
> =C2=A0 x86/sgx: Use sgx_epc_lru_list for existing active page list
> =C2=A0 x86/sgx: Use a list to track to-be-reclaimed pages
> =C2=A0 x86/sgx: Restructure top-level EPC reclaim function
> =C2=A0 Docs/x86/sgx: Add description for cgroup support
>=20
> =C2=A0Documentation/arch/x86/sgx.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 74 ++++
> =C2=A0arch/x86/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +
> =C2=A0arch/x86/kernel/cpu/sgx/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0arch/x86/kernel/cpu/sgx/encl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0arch/x86/kernel/cpu/sgx/epc_cgroup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 319 ++++++++++++++++++
> =C2=A0arch/x86/kernel/cpu/sgx/epc_cgroup.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 49 +++
> =C2=A0arch/x86/kernel/cpu/sgx/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 245 +++++++++-----
> =C2=A0arch/x86/kernel/cpu/sgx/sgx.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 88 +++=
+-
> =C2=A0include/linux/misc_cgroup.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 42 +++
> =C2=A0kernel/cgroup/misc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 52 ++-
> =C2=A0.../selftests/sgx/run_epc_cg_selftests.sh=C2=A0=C2=A0=C2=A0=C2=A0 |=
 196 +++++++++++
> =C2=A0.../selftests/sgx/watch_misc_for_tests.sh=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 13 +
> =C2=A012 files changed, 996 insertions(+), 98 deletions(-)
> =C2=A0create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
> =C2=A0create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
> =C2=A0create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests=
.sh
> =C2=A0create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests=
.sh
>=20

Is this expected to work on NUC7?

Planning to test this next week (no time this week).

BR, Jarkko

