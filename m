Return-Path: <cgroups+bounces-1424-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABB1851DF7
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 20:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5031C20EAE
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0DF47772;
	Mon, 12 Feb 2024 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVUWUD1f"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1A4C99;
	Mon, 12 Feb 2024 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766542; cv=none; b=FFxq2p46AVcap8/Xd7g5Z81ls5NrTE4lCg+kGtSct2xom6lV31JF1iA4/82+4T2zc3k2AC6x8MNY+MroEO4OqwV4PUPQSSjeryucllR7qWxZyk1B4ujtewnxYUmb6smsee4XVh0AnoVQqPRUqICIGwUcRubjGcconudHJfLz/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766542; c=relaxed/simple;
	bh=8VK587v6NjtmmJpiNhoXP8t2pKiC0OMi67uBtyp2wQg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=f045cQfJFPjl/PfqUwWIJa2GOI2y5gO7GDRS7TqDluXv8TikSLbXmz1lMo0gUqnId34NBSJS5mGXc05x6etdmtEQkbCTW5SSzTQXGNhqTfn81+yjnAfmcR9hKUFHuQ0tlW13Fw/kvFvJ0rYSAUKylMn/TyOLuRTobca5wzQXgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVUWUD1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CB0C433C7;
	Mon, 12 Feb 2024 19:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707766542;
	bh=8VK587v6NjtmmJpiNhoXP8t2pKiC0OMi67uBtyp2wQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVUWUD1f3LL8rhOBowIs1Al404E69ndr2Hem1QpopQSLzH2Bd71nwuafZNBRhPwO2
	 okDhC36jliGDqZvUG7Lma4Q+XKxgKGX0PeaWGaDHrIsEBWng4BjQwMd9cLc6o/gHlV
	 F2Lcu6H9/BCZwNTQvNBIDBTF7TfBN9B/aEhMvRYojd/4D8WlgbM11nuBoTKGC9qk81
	 TGuK+0oufCPtxVEWLgjA1HGi9w9S97chMblNq+abDFg+ByaH3eRQ2PnYBW7YdRQYwZ
	 A9E9dY8KKzA1wDUrFOr3bohpIpgGWJDi39ifRFzk+D4YsK5OD92vXOf2ueRPKIviwn
	 xblLF9x9ROKaQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Feb 2024 21:35:35 +0200
Message-Id: <CZ3CPNVEG608.3LL5FU8SCDIOU@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 08/15] x86/sgx: Implement EPC reclamation flows for
 cgroup
X-Mailer: aerc 0.16.0
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-9-haitao.huang@linux.intel.com>
In-Reply-To: <20240205210638.157741-9-haitao.huang@linux.intel.com>

On Mon Feb 5, 2024 at 11:06 PM EET, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> Implement the reclamation flow for cgroup, encapsulated in the top-level
> function sgx_epc_cgroup_reclaim_pages(). It does a pre-order walk on its
> subtree, and make calls to sgx_reclaim_pages() at each node passing in
> the LRU of that node. It keeps track of total reclaimed pages, and pages
> left to attempt.  It stops the walk if desired number of pages are
> attempted.
>
> In some contexts, e.g. page fault handling, only asynchronous
> reclamation is allowed. Create a work-queue, corresponding work item and
> function definitions to support the asynchronous reclamation. Both
> synchronous and asynchronous flows invoke the same top level reclaim
> function, and will be triggered later by sgx_epc_cgroup_try_charge()
> when usage of the cgroup is at or near its limit.
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V9:
> - Add comments for static variables. (Jarkko)
>
> V8:
> - Remove alignment for substructure variables. (Jarkko)
>
> V7:
> - Split this out from the big patch, #10 in V6. (Dave, Kai)
> ---
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 181 ++++++++++++++++++++++++++-
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |   3 +
>  2 files changed, 183 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.c
> index f4a37ace67d7..16b6d9f909eb 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> @@ -8,9 +8,180 @@
>  /* The root EPC cgroup */
>  static struct sgx_epc_cgroup epc_cg_root;
> =20
> +/*
> + * The work queue that reclaims EPC pages in the background for cgroups.
> + *
> + * A cgroup schedules a work item into this queue to reclaim pages withi=
n the
> + * same cgroup when its usage limit is reached and synchronous reclamati=
on is not
> + * an option, e.g., in a fault handler.
> + */

Here I get a bit confused of the text because of "e.g., in a fault
handler".  Can we enumerate sites broadly where stimulus could
happen.

Does not have to be complete but at least the most common locations
would make this comment *actually* useful for later maintenance.

BR, Jarkko

