Return-Path: <cgroups+bounces-1428-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC652851E3A
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 20:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3DD1F23BCB
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 19:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4215D47A7A;
	Mon, 12 Feb 2024 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV2S7L0n"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCBC46435;
	Mon, 12 Feb 2024 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767944; cv=none; b=TddtHNIrpktRdWcYcQOYOu/S88epkI943eI0w2CJSu+zKf5AQRAy+DiX8kLgP/tp3IOM0BONoCrUQIOje3XFu32+NLJGIdVlDATpYeHHbj4+1+6/7nS/mTmxRJ6W6ICpyuFswbdT+r/4W8Dut1FSIWk1KanYlr6D2+Ru8yZ6fd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767944; c=relaxed/simple;
	bh=r8S/sbIq2+trVDIDyjR/VHgzjICcRo23QMsda6iYpfk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=HOlxMmi4rXLnez9KuOFmPK/2h7B8d+sEUlp6EKUckMBOViKDO33IBuAY9WFqGTvSm78voyMSEUEPMiL1/v2ntRAmpbV1CG8qrcn9uIkwQDGmT2LPAXfYONI5Fw+7eIns3sFLMGqbW4DwUPPqQkSQBTQxloIEF2F3Zwb0u4NtUU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV2S7L0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE52C43390;
	Mon, 12 Feb 2024 19:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707767943;
	bh=r8S/sbIq2+trVDIDyjR/VHgzjICcRo23QMsda6iYpfk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=FV2S7L0nDFE2yfQnloBYTUlUjVyBRgw9vTy54dqn5UTflrxuJwX46jmL4i07inaf0
	 FmczWV5V82RukiWZyujS/YuRWViV/7kBgtqI2oIGc9dr44gjfrysnREfu3Ud71AVwO
	 wrV9IKAsalHUUsPWCpBy87CAkEFtwzD0zBPZsshasC8giOTayIaAlufIyQp+zGsGE/
	 M1Hik2uj6jTpsDcM9QziQc81GnXp6rb7016VwRC5X+6pnxZzaihdUHDrIXQXrOtWtx
	 l/OHzF2/1W/DTE+SJStJ+oqf6rImSy5kijTlE2QcjGGtsIrIYuKF4KIHsK/SG/Ys7F
	 QnwNoOLm/1ybQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Feb 2024 21:58:57 +0200
Message-Id: <CZ3D7JMQC1PK.3PRW2YCMLE3G5@kernel.org>
Subject: Re: [PATCH v9 12/15] x86/sgx: Expose sgx_epc_cgroup_reclaim_pages()
 for global reclaimer
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
X-Mailer: aerc 0.16.0
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-13-haitao.huang@linux.intel.com>
In-Reply-To: <20240205210638.157741-13-haitao.huang@linux.intel.com>

On Mon Feb 5, 2024 at 11:06 PM EET, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> When cgroup is enabled, all reclaimable pages will be tracked in cgroup
> LRUs. The global reclaimer needs to start reclamation from the root
> cgroup. Expose the top level cgroup reclamation function so the global
> reclaimer can reuse it.
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V8:
> - Remove unneeded breaks in function declarations. (Jarkko)
>
> V7:
> - Split this out from the big patch, #10 in V6. (Dave, Kai)
> ---
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 2 +-
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.c
> index abf74fdb12b4..6e31f8727b8a 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> @@ -96,7 +96,7 @@ bool sgx_epc_cgroup_lru_empty(struct misc_cg *root)
>   * @indirect:   In ksgxd or EPC cgroup work queue context.
>   * Return:	Number of pages reclaimed.
>   */
> -static unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, b=
ool indirect)
> +unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool ind=
irect)

Now that is an ugly function name...

IMHO, be would not lost a lot of information if these would be shortened
as sgx_cgroup_reclaim_pages() and such and so forth.

No risk for amiguity and much much more digestable code to read.

BR, Jarkko

