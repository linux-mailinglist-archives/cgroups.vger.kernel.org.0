Return-Path: <cgroups+bounces-1426-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA9851E30
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 20:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145E0284F20
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 19:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8192F47A70;
	Mon, 12 Feb 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLfU70b5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B447A40;
	Mon, 12 Feb 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767753; cv=none; b=G8ocK+2r01qpBg1j/5Y55uRd8SDBFlNSYPnCRYZHjTZYLDlh89oAzwxAnMhPb4Tsy+d09BKTECxdXtyR1q1rU1HOJd0eNFKFbCbOwz9W0Jo7P9seBsslRCBOBQo3BiXvitIh55J/0dcBpoNLMC20+AYhAOouTrAM3gRi7PSZ5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767753; c=relaxed/simple;
	bh=2L6MssMGXP7U0+Xe93Y5e9SpF/neBQBhwJxnYGmvuM8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FJtQT3cZa4t+RluFYJ+/BKf8TISfNgPlMzWPUoIKjGFAUQUp2pUtxYyqzLc0kSB3a8/AbjM7O8LKHd0Otpkno5zuiMLxGbtM3IcvAt5JZvdtqv//cPIe7NHFIqkOvsCmG0SrG6s2S+BN2pMjDV6TpW+oqh9XhrKUBI/klqVMI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLfU70b5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B42EC433C7;
	Mon, 12 Feb 2024 19:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707767752;
	bh=2L6MssMGXP7U0+Xe93Y5e9SpF/neBQBhwJxnYGmvuM8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=hLfU70b5NZcSgpce5iJAQVonPR1XdL+wvLI5GFLYgVG5WNhWqPspqW9s4W0Izb3DY
	 M6g+kxHCGhjKPax6Ya3qGPKEwF4daFdDbDcmTBdATF9KhKIyI4+DwS0zIcMMzNkRNw
	 kSM4xumtL+zwjPzb/eNrgS+jCDYVgIzE+3H8fhdXH8BDCu2mKDZIW5r9DjorzFeT36
	 4doNKuCS00Y7dLQsWAtDd9LW5/F2Ss1QcxdCdyp2DLpzi55nTS5Q45s7WxN4ONBdgy
	 VPXwXFKgSFQq7ZhNffKv0NBCz7UdqBe8pcD4QSJfcH2Ngz26iPQhD+KJUya0ZQfuZ7
	 uX/AW66dZzpmA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Feb 2024 21:55:46 +0200
Message-Id: <CZ3D53XFVXAW.25EK0ZBFH3HV2@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.16.0
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-11-haitao.huang@linux.intel.com>
In-Reply-To: <20240205210638.157741-11-haitao.huang@linux.intel.com>

On Mon Feb 5, 2024 at 11:06 PM EET, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> When the EPC usage of a cgroup is near its limit, the cgroup needs to
> reclaim pages used in the same cgroup to make room for new allocations.
> This is analogous to the behavior that the global reclaimer is triggered
> when the global usage is close to total available EPC.
>
> Add a Boolean parameter for sgx_epc_cgroup_try_charge() to indicate
> whether synchronous reclaim is allowed or not. And trigger the
> synchronous/asynchronous reclamation flow accordingly.
>
> Note at this point, all reclaimable EPC pages are still tracked in the
> global LRU and per-cgroup LRUs are empty. So no per-cgroup reclamation
> is activated yet.
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V7:
> - Split this out from the big patch, #10 in V6. (Dave, Kai)
> ---
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 26 ++++++++++++++++++++++++--
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |  4 ++--
>  arch/x86/kernel/cpu/sgx/main.c       |  2 +-
>  3 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.c
> index d399fda2b55e..abf74fdb12b4 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> @@ -184,13 +184,35 @@ static void sgx_epc_cgroup_reclaim_work_func(struct=
 work_struct *work)
>  /**
>   * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single EPC p=
age
>   * @epc_cg:	The EPC cgroup to be charged for the page.
> + * @reclaim:	Whether or not synchronous reclaim is allowed
>   * Return:
>   * * %0 - If successfully charged.
>   * * -errno - for failures.
>   */
> -int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
> +int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool reclai=
m)
>  {
> -	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
> +	for (;;) {
> +		if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
> +					PAGE_SIZE))
> +			break;
> +
> +		if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
> +			return -ENOMEM;
> + +		if (signal_pending(current))
> +			return -ERESTARTSYS;
> +
> +		if (!reclaim) {
> +			queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);
> +			return -EBUSY;
> +		}
> +
> +		if (!sgx_epc_cgroup_reclaim_pages(epc_cg->cg, false))
> +			/* All pages were too young to reclaim, try again a little later */
> +			schedule();

This will be total pain to backtrack after a while when something
needs to be changed so there definitely should be inline comments
addressing each branch condition.

I'd rethink this as:

1. Create static __sgx_epc_cgroup_try_charge() for addressing single
   iteration with the new "reclaim" parameter.
2. Add a new sgx_epc_group_try_charge_reclaim() function.

There's a bit of redundancy with sgx_epc_cgroup_try_charge() and
sgx_epc_cgroup_try_charge_reclaim() because both have almost the
same loop calling internal __sgx_epc_cgroup_try_charge() with
different parameters. That is totally acceptable.

Please also add my suggested-by.

BR, Jarkko

BR, Jarkko

