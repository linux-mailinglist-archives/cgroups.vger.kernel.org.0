Return-Path: <cgroups+bounces-6172-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7EDA12C5B
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 21:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A397A28DF
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 20:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2393B1D86CB;
	Wed, 15 Jan 2025 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPi+FsJ9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF614B959;
	Wed, 15 Jan 2025 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972206; cv=none; b=EBfCQJca01UeSuzUtkSXQBMYM8hUuGb9kM5tgADaNRgzYlvgm3E6Mqc0cU7VcB6z/W5g3ov1BHDcTuzfvkPQ+PGr0OxV+wNiTgVeScSzSLANqoiglqK0YiswyuK/xRrICHD2gm8jm3tfAzihS1BmYKU+IHO4zFajpuqs17H6l/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972206; c=relaxed/simple;
	bh=ebJTyzRf7TeHhdhGRooikoTaUb3mDtdLFFrtVqxyoVM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pio9vLfHAFbi28lXjXllGeqVn5qhBoeAf+vPihAyjqJy+I7ayB4Ju8jCo6i7ReII+1wgj0Nm6MFqL5HGRB7LmLur7bbyY52tQvs59Hu3CgwrTIEQJHfARn4A0EqLkXosxeR9Q/GGHzONIoPSEOuqbth+t0MeqMLmBWu03OGYpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPi+FsJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACCCC4CED1;
	Wed, 15 Jan 2025 20:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736972206;
	bh=ebJTyzRf7TeHhdhGRooikoTaUb3mDtdLFFrtVqxyoVM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tPi+FsJ9qnrdDg7R8dqGTRnjYXQWvQGTetOiFOAD/thT2xB0brjVjy6QHPHk71Vkw
	 JPAosdkAFprbwEQBhR46/2EyBk7iHd8B4trrwWYJgc/VpWZEh6gQN2FzkyWc2ekRMs
	 JVSoX8k3rHjNx1AgJzdCzXSaPaJWSNW2Y9Lz9RVKgFbss43KlyNdyYgCb8sIcZkJKY
	 YsvuCekA6z7qjT1dOHpEUG4b+dZIaYwcgPNENleYxuf9UpFzk7X1dXw1sFgVflnBk7
	 +GOsevbZrr3zSRx/9S4ofo0oOuUVbP/TEvc5xdApcFCBICSc7Nao1t01ttk2zJmvka
	 u691AZFQlpGSw==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jan 2025 22:16:40 +0200
Message-Id: <D72X98Y1PLHR.ZP8VQ6S71OJM@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v17 00/16]  Add Cgroup support for SGX EPC memory
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <Florian.Fuerstenberg@t-systems.com>, <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <chenridong@huawei.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.18.2
References: <20240830164038.39343-1-haitao.huang@linux.intel.com>
 <FR4P281MB364378DFE998FADC1CE8B615DF1C2@FR4P281MB3643.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR4P281MB364378DFE998FADC1CE8B615DF1C2@FR4P281MB3643.DEUP281.PROD.OUTLOOK.COM>

On Wed Jan 15, 2025 at 6:53 PM EET, Florian.Fuerstenberg wrote:
> On Fri, Aug 30, 2024 at 16:40 UTC, Haitao Huang  wrote:
> > SGX Enclave Page Cache (EPC) memory allocations are separate from norma=
l
> > RAM allocations, and are managed solely by the SGX subsystem. The exist=
ing
> > cgroup memory controller cannot be used to limit or account for SGX EPC
> > memory, which is a desirable feature in some environments, e.g., suppor=
t
> > for pod level control in a Kubernates cluster on a VM or bare-metal hos=
t
> > [1,2].
> >
> > This patchset implements the support for sgx_epc memory within the misc
> > cgroup controller. A user can use the misc cgroup controller to set and
> > enforce a max limit on total EPC usage per cgroup. The implementation
> > reports current usage and events of reaching the limit per cgroup as we=
ll
> > as the total system capacity.
> >
> > Much like normal system memory, EPC memory can be overcommitted via vir=
tual
> > memory techniques and pages can be swapped out of the EPC to their back=
ing
> > store, which are normal system memory allocated via shmem and accounted=
 by
> > the memory controller. Similar to per-cgroup reclamation done by the me=
mory
> > controller, the EPC misc controller needs to implement a per-cgroup EPC
> > reclaiming process: when the EPC usage of a cgroup reaches its hard lim=
it
> > ('sgx_epc' entry in the 'misc.max' file), the cgroup starts swapping ou=
t
> > some EPC pages within the same cgroup to make room for new allocations.
> >
> > For that, this implementation tracks reclaimable EPC pages in a separat=
e
> > LRU list in each cgroup, and below are more details and justification o=
f
> > this design.
> >
> > Track EPC pages in per-cgroup LRUs (from Dave)
> > ----------------------------------------------
> >
> > tl;dr: A cgroup hitting its limit should be as similar as possible to t=
he
> > system running out of EPC memory. The only two choices to implement tha=
t
> > are nasty changes the existing LRU scanning algorithm, or to add new LR=
Us.
> > The result: Add a new LRU for each cgroup and scans those instead. Repl=
ace
> > the existing global cgroup with the root cgroup's LRU (only when this n=
ew
> > support is compiled in, obviously).
> >
> > The existing EPC memory management aims to be a miniature version of th=
e
> > core VM where EPC memory can be overcommitted and reclaimed. EPC
> > allocations can wait for reclaim. The alternative to waiting would have
> > been to send a signal and let the enclave die.
> >
> > This series attempts to implement that same logic for cgroups, for the =
same
> > reasons: it's preferable to wait for memory to become available and let
> > reclaim happen than to do things that are fatal to enclaves.
> >
> > There is currently a global reclaimable page SGX LRU list. That list (a=
nd
> > the existing scanning algorithm) is essentially useless for doing recla=
im
> > when a cgroup hits its limit because the cgroup's pages are scattered
> > around that LRU. It is unspeakably inefficient to scan a linked list wi=
th
> > millions of entries for what could be dozens of pages from a cgroup tha=
t
> > needs reclaim.
> >
> > Even if unspeakably slow reclaim was accepted, the existing scanning
> > algorithm only picks a few pages off the head of the global LRU. It wou=
ld
> > either need to hold the list locks for unreasonable amounts of time, or=
 be
> > taught to scan the list in pieces, which has its own challenges.
> >
> > Unreclaimable Enclave Pages
> > ---------------------------
> >
> > There are a variety of page types for enclaves, each serving different
> > purposes [5]. Although the SGX architecture supports swapping for all
> > types, some special pages, e.g., Version Array(VA) and Secure Enclave
> > Control Structure (SECS)[5], holds meta data of reclaimed pages and
> > enclaves. That makes reclamation of such pages more intricate to manage=
.
> > The SGX driver global reclaimer currently does not swap out VA pages. I=
t
> > only swaps the SECS page of an enclave when all other associated pages =
have
> > been swapped out. The cgroup reclaimer follows the same approach and do=
es
> > not track those in per-cgroup LRUs and considers them as unreclaimable
> > pages. The allocation of these pages is counted towards the usage of a
> > specific cgroup and is subject to the cgroup's set EPC limits.
> >
> > Earlier versions of this series implemented forced enclave-killing to
> > reclaim VA and SECS pages. That was designed to enforce the 'max' limit=
,
> > particularly in scenarios where a user or administrator reduces this li=
mit
> > post-launch of enclaves. However, subsequent discussions [3, 4] indicat=
ed
> > that such preemptive enforcement is not necessary for the misc-controll=
ers.
> > Therefore, reclaiming SECS/VA pages by force-killing enclaves were remo=
ved,
> > and the limit is only enforced at the time of new EPC allocation reques=
t.
> > When a cgroup hits its limit but nothing left in the LRUs of the subtre=
e,
> > i.e., nothing to reclaim in the cgroup, any new attempt to allocate EPC
> > within that cgroup will result in an 'ENOMEM'.
> >
> > Unreclaimable Guest VM EPC Pages
> > --------------------------------
> >
> > The EPC pages allocated for guest VMs by the virtual EPC driver are not
> > reclaimable by the host kernel [6]. Therefore an EPC cgroup also treats
> > those as unreclaimable and returns ENOMEM when its limit is hit and not=
hing
> > reclaimable left within the cgroup. The virtual EPC driver translates t=
he
> > ENOMEM error resulted from an EPC allocation request into a SIGBUS to t=
he
> > user process exactly the same way handling host running out of physical
> > EPC.
> >
> > This work was originally authored by Sean Christopherson a few years ag=
o,
> > and previously modified by Kristen C. Accardi to utilize the misc cgrou=
p
> > controller rather than a custom controller. I have been updating the
> > patches based on review comments since V2 [7-21], simplified the
> > implementation/design, added selftest scripts, fixed some stability iss=
ues
> > found from testing.
> >
> > Thanks to all for the review/test/tags/feedback provided on the previou=
s
> > versions.
> >
> > I appreciate your further reviewing/testing and providing tags if
> > appropriate.
>
> We have followed this work very closely and have been testing the series =
for over a year now. The most recent version runs in production and it work=
s extremely well for us and our customers.
>
>
>
> Our goal with these patches is to enable our customers to manage SGX conf=
idential workloads in Kubernetes in the same way as non-confidential worklo=
ads, which includes proper resource management including consumption monito=
ring and limits. Using established concepts, technologies and components th=
at are well known and widely used is an important aspect for us. In our vie=
w, managing EPC memory via Linux cgroups provides the greatest transparency=
 for (Kubernetes) users and administrators alike. This means that there is =
no additional operational effort and troubleshooting is also greatly simpli=
fied.
>
>
>
> We would very much welcome it if the series were included in the main lin=
e, as this would significantly reduce our kernel maintenance efforts. Above=
 all, however, it would create a standard that our customers could trust wi=
thout hesitation.
>
>
>
> Tested-by: Florian F=C3=BCrstenberg florian.fuerstenberg@t-systems.com<ma=
ilto:florian.fuerstenberg@t-systems.com>
>
>
>
> Regards, Florian
>
> >
> > ---
> > V17:
> > - Remove unneeded EXPORT_SYMBOL_GPLs and @parent_cg in changes to misc.=
c (Kai)
> > - Use READ_ONCE()/WRITE_ONCE() for ops to be consistent with existing
> >  code in misc.c
> > - Fix W=3D1 warnings for '/**'.
> > - Rename sgx_cgroup_register() -> sgx_cgroup_init(), and move the
> >  sgx_cgroup_misc_init() call to it. Rename
> >  sgx_cgroup_{init,deinit}()->sgx_cgroup_wq_{init,deinit}() and make the=
m
> >  only do wq related init and rollback. (Kai)
> > - Move comments in sgx_can_reclaim_global() to patch "x86/sgx: Revise
> >  global reclamation for EPC cgroups"  (Kai)
> > - Remove inaccurate sentences in commit  "x86/sgx: Revise global
> >  reclamation for EPC cgroups" and move it right in front of patch
> >  "x86/sgx: Turn on per-cgroup EPC reclamation" (Kai)
> > - Fix error in initializing 'next' in sgx_cgroup_next_descendant_pre()
> > - Fix some grammar issue and capitalization in comments and change log.
> >  (Kai)
> >
> > V16:
> > - Revised the per-cgroup reclamation basic flow
> >  sgx_cgroup_reclaim_pages(): add next_cg field in each cgroup to track
> >  the next descendant to scan, and create a synchronized iterator to mor=
e
> >  fairly scan all descendants if needed for reclamation. (Kai)
> > - Separate patches to abstract the uses of global LRU, sgx_cgroup_recla=
im_direct(),
> >  sgx_cgroup_reclaim_global() implementaions. (Kai)
> > - MISC don't call the ops if capacity is zero. (Kai)
> > - Commit message improvements, clarified requirements for per-cgroup
> >  reclamation. (Kai)
> > - Fix bugs in handling failures during init.
> > - Only turn on callbacks and set capacity at the end of sgx_init()
> >
> > V15:
> > - Disable SGX when sgx_cgroup_init() fails instead of using BUG_ON()
> >  (Jarkko)
> > - Reset capacity if sgx_cgroup_init() fails. (Kai)
> > - Style fixes (Jarkko, Kai)
> > - In misc.c, only invoke the ->free() callbacks for resource types whos=
e
> >  ->alloc() callback  was called and returned success. (Ridong)
> >
> > V14:
> > - modified sgx_cgroup_reclaim_pages() to return the next node. Caller c=
an use it as the new
> >  starting node for next round of reclamation attempt if needed. This is=
 to fix a corner case
> > where a super busy top level cgroup may block reclamation in lower leve=
l cgroups. (Kai)
> > - Move renaming of sgx_should_reclaim_global() to the patch 'x86/sgx: A=
dd basic EPC reclamation
> > flow for cgroup'. (Kai)
> >
> > v13:
> > - Only allocate workqueue for SGX cgroup when misc is enabled and BUG_O=
N() when allocation fails
> > - Add more tags
> > - Commit logs and style improvements (Kai)
> > - Test script improvements (Jarkko)
> >
> > V12:
> > - Integrate test scripts to kselftests "run_tests" target. (Jarkko)
> > - Remove CGROUP_SGX_EPC kconfig, conditionally compile with CGROUP_MISC=
 enabled. (Jarkko)
> > - Explain why taking 'struct misc_cg *cg' as parameter, but not 'struct=
 misc_res *res' in the
> >  changelog for patch #2. (Kai)
> > - Remove "unlikely" in patch #2 (Kai)
> >
> > V11:
> > - Update copyright years and use c style (Kai)
> > - Improve and simplify test scripts: remove cgroup-tools and bash depen=
dency, drop cgroup v1.
> >  (Jarkko, Michal)
> > - Add more stub/wrapper functions to minimize #ifdefs in c file. (Kai)
> > - Revise commit message for patch #8 to clarify design rational (Kai)
> > - Print error instead of WARN for init failure. (Kai)
> > - Add check for need to queue an async reclamation before returning fro=
m
> >  sgx_cgroup_try_charge(), do so if needed.
> >
> > V10:
> > - Use enum instead of boolean for the 'reclaim' parameters in
> >  sgx_alloc_epc_page(). (Dave, Jarkko)
> > - Pass mm struct instead of a boolean 'indirect'. (Dave, Jarkko)
> > - Add comments/macros to clarify the cgroup async reclaimer design. (Ka=
i)
> > - Simplify sgx_reclaim_pages() signature, removing a pointer passed in.
> >  (Kai)
> > - Clarify design of sgx_cgroup_reclaim_pages(). (Kai)
> >        - Does not return a value for callers to check.
> >        - Its usage pattern is similar to that of sgx_reclaim_pages() no=
w
> > - Add cond_resched() in the loop in the cgroup reclaimer to improve
> >  liveliness.
> > - Add logic for cgroup level reclamation in sgx_reclaim_direct()
> > - Restructure V9 patches 7-10 to make them flow better. (Kai)
> > - Disable cgroup if workqueue allocation failed during init. (Kai)
> > - Shorten names for EPC cgroup functions, structures and variables.
> >  (Jarkko)
> > - Separate out a helper for for addressing single iteration of the loop=
 in
> >  sgx_cgroup_try_charge(). (Jarkko)
> > - More cleanup/clarifying/comments/style fixes. (Kai, Jarkko)
> >
> > V9:
> > - Add comments for static variables outside functions. (Jarkko)
> > - Remove unnecessary ifs. (Tim)
> > - Add more Reviewed-By: tags from Jarkko and TJ.
> >
> > V8:
> > - Style fixes. (Jarkko)
> > - Abstract _misc_res_free/alloc() (Jarkko)
> > - Remove unneeded NULL checks. (Jarkko)
> >
> > V7:
> > - Split the large patch for the final EPC implementation, #10 in V6, in=
to
> >  smaller ones. (Dave, Kai)
> > - Scan and reclaim one cgroup at a time, don't split sgx_reclaim_pages(=
)
> >  into two functions (Kai)
> > - Removed patches to introduce the EPC page states, list for storing
> >  candidate pages for reclamation. (not needed due to above changes)
> > - Make ops one per resource type and store them in array (Michal)
> > - Rename the ops struct to misc_res_ops, and enforce the constraints of
> >  required callback functions (Jarkko)
> > - Initialize epc cgroup in sgx driver init function. (Kai)
> > - Moved addition of priv field to patch 4 where it was used first. (Jar=
kko)
> > - Split sgx_get_current_epc_cg() out of sgx_epc_cg_try_charge() (Kai)
> > - Use a static for root cgroup (Kai)
> >
> > [1]https://lore.kernel.org/all/DM6PR21MB11772A6ED915825854B419D6C4989@D=
M6PR21MB1177.namprd21.prod.outlook.com/
> > [2]https://lore.kernel.org/all/ZD7Iutppjj+muH4p@himmelriiki/
> > [3]https://lore.kernel.org/lkml/7a1a5125-9da2-47b6-ba0f-cf24d84df16b@in=
tel.com/
> > [4]https://lore.kernel.org/lkml/yz44wukoic3syy6s4fcrngagurkjhe2hzka6kvx=
bajdtro3fwu@zd2ilht7wcw3/
> > [5]Documentation/arch/x86/sgx.rst, Section"Enclave Page Types"
> > [6]Documentation/arch/x86/sgx.rst, Section "Virtual EPC"
> > [7]v2: https://lore.kernel.org/all/20221202183655.3767674-1-kristen@lin=
ux.intel.com/
> > [8]v3: https://lore.kernel.org/linux-sgx/20230712230202.47929-1-haitao.=
huang@linux.intel.com/
> > [9]v4: https://lore.kernel.org/all/20230913040635.28815-1-haitao.huang@=
linux.intel.com/
> > [10]v5: https://lore.kernel.org/all/20230923030657.16148-1-haitao.huang=
@linux.intel.com/
> > [11]v6: https://lore.kernel.org/linux-sgx/20231030182013.40086-1-haitao=
.huang@linux.intel.com/
> > [12]v7: https://lore.kernel.org/linux-sgx/20240122172048.11953-1-haitao=
.huang@linux.intel.com/T/#t
> > [13]v8: https://lore.kernel.org/linux-sgx/20240130020938.10025-1-haitao=
.huang@linux.intel.com/T/#t
> > [14]v9: https://lore.kernel.org/lkml/20240205210638.157741-1-haitao.hua=
ng@linux.intel.com/T/
> > [15]v10: https://lore.kernel.org/linux-sgx/20240328002229.30264-1-haita=
o.huang@linux.intel.com/T/#t
> > [16]v11: https://lore.kernel.org/lkml/20240410182558.41467-1-haitao.hua=
ng@linux.intel.com/
> > [17]v12: https://lore.kernel.org/lkml/20240416032011.58578-1-haitao.hua=
ng@linux.intel.com/
> > [18]v13: https://lore.kernel.org/lkml/20240430195108.5676-1-haitao.huan=
g@linux.intel.com/
> > [19]v14: https://lore.kernel.org/linux-sgx/20240531222630.4634-1-haitao=
.huang@linux.intel.com/T/#t
> > [20]v15: https://lore.kernel.org/linux-sgx/20240617125321.36658-1-haita=
o.huang@linux.intel.com/T/#t
> > [21]v16: https://lore.kernel.org/lkml/20240821015404.6038-1-haitao.huan=
g@linux.intel.com/T/#t
> >
> > Haitao Huang (7):
> >  x86/sgx: Replace boolean parameters with enums
> >  x86/sgx: Encapsulate uses of the global LRU
> >  x86/sgx: Add basic EPC reclamation flow for cgroup
> >  x86/sgx: Charge mem_cgroup for per-cgroup reclamation
> >  x86/sgx: Implement direct reclamation for cgroups
> >  x86/sgx: Revise global reclamation for EPC cgroups
> >  selftests/sgx: Add scripts for EPC cgroup testing
> >
> > Kristen Carlson Accardi (7):
> >  cgroup/misc: Add per resource callbacks for CSS events
> >  cgroup/misc: Expose APIs for SGX driver
> >  cgroup/misc: Add SGX EPC resource type
> >  x86/sgx: Implement basic EPC misc cgroup functionality
> >  x86/sgx: Abstract tracking reclaimable pages in LRU
> >  x86/sgx: Implement async reclamation for cgroup
> >  x86/sgx: Turn on per-cgroup EPC reclamation
> >
> > Sean Christopherson (2):
> >  x86/sgx: Add sgx_epc_lru_list to encapsulate LRU list
> >  Docs/x86/sgx: Add description for cgroup support
> >
> > Documentation/arch/x86/sgx.rst                |  83 ++++
> > arch/x86/kernel/cpu/sgx/Makefile              |   1 +
> > arch/x86/kernel/cpu/sgx/encl.c                |  41 +-
> > arch/x86/kernel/cpu/sgx/encl.h                |   7 +-
> > arch/x86/kernel/cpu/sgx/epc_cgroup.c          | 441 ++++++++++++++++++
> > arch/x86/kernel/cpu/sgx/epc_cgroup.h          | 106 +++++
> > arch/x86/kernel/cpu/sgx/ioctl.c               |  10 +-
> > arch/x86/kernel/cpu/sgx/main.c                | 220 ++++++---
> > arch/x86/kernel/cpu/sgx/sgx.h                 |  54 ++-
> > arch/x86/kernel/cpu/sgx/virt.c                |   2 +-
> > include/linux/misc_cgroup.h                   |  41 ++
> > kernel/cgroup/misc.c                          | 112 ++++-
> > tools/testing/selftests/sgx/Makefile          |   3 +-
> > tools/testing/selftests/sgx/README            | 109 +++++
> > tools/testing/selftests/sgx/ash_cgexec.sh     |  16 +
> > tools/testing/selftests/sgx/config            |   4 +
> > .../selftests/sgx/run_epc_cg_selftests.sh     | 294 ++++++++++++
> > tools/testing/selftests/sgx/settings          |   2 +
> > .../selftests/sgx/watch_misc_for_tests.sh     |  11 +
> > 19 files changed, 1446 insertions(+), 111 deletions(-)
> > create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
> > create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
> > create mode 100644 tools/testing/selftests/sgx/README
> > create mode 100755 tools/testing/selftests/sgx/ash_cgexec.sh
> > create mode 100644 tools/testing/selftests/sgx/config
> > create mode 100755 tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> > create mode 100644 tools/testing/selftests/sgx/settings
> > create mode 100755 tools/testing/selftests/sgx/watch_misc_for_tests.sh
> >
> >
> > base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
> > --
> > 2.43.0
>
> >

If there was any missing my tag:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

