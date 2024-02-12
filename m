Return-Path: <cgroups+bounces-1427-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A11D851E33
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 20:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7A91C21CF2
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305F947A6F;
	Mon, 12 Feb 2024 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBjPuaiQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC5D47A63;
	Mon, 12 Feb 2024 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767807; cv=none; b=FYgeVF0bd2LNOZxHR/g9sFoPreq84Mvdu5j8C/IsJjj7Ta3L0Iy5z0sPp1cU2J090+Q6Qc+5tz2p3zgq5kdSDvM6Ua0pM2AbZRhH17tNr7eIn7og5EhWZ1Do4Wntgo0IgjgYkXzfypaz0mtJwS6KqMgVQRLhei3oeyJWwVc6Iug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767807; c=relaxed/simple;
	bh=dmVX8i40tnB9ewS4UawWwIEkd+FyBOxmlrA+K6xKYOE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=nw9rR4GCqHn8+7t2aJ6eMS0ByUAERj1X/Knhk1fil6mMN3kNF7XP1M0xLcbW1dY0MyfGalTCIFnwIkbfGTtxoeKvCxlCqvJSwQ7pDPSOlZ7+BTqPg0c+5QqAXDUqfSZ2Z7fiaABffsTswp5QEZWM4k4GwrWqLTxMfcZf4Z5DsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBjPuaiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B4CC433F1;
	Mon, 12 Feb 2024 19:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707767806;
	bh=dmVX8i40tnB9ewS4UawWwIEkd+FyBOxmlrA+K6xKYOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBjPuaiQGQ6Hz7D7U/V25N7rwnkmbY0aRQz5R2YdCQXauO+59x7nfy5SXkEInwI1K
	 /8igDEFdeAYl2VIQQgoEdDZ+DzgG4lO/M4PuAEOOUJej6fZkiabDg4LJSlJnTirNsK
	 H6LtFfnZn+R6zRaxOkoE44Gm8Exwu21uzkoC1ys1RifRxElY1qLb5U73PQx4ozHrUA
	 2iJYg1yVn4xQ3reVg279w6Z3h/s+xvi5NPQm4bxwQ+43+btXeWf375yECveTzEMZcz
	 CcjGHUpZrLXhCrY9VHUxytD4F43e6s0wxmr8KS/Q/dSdrgyjSYrOeMql9UpUYhfkZ2
	 0LYHQW7plpdzA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Feb 2024 21:56:40 +0200
Message-Id: <CZ3D5SNJ8O14.2AQBOPEH3DFSG@kernel.org>
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
Subject: Re: [PATCH v9 11/15] x86/sgx: Abstract check for global reclaimable
 pages
X-Mailer: aerc 0.16.0
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-12-haitao.huang@linux.intel.com>
In-Reply-To: <20240205210638.157741-12-haitao.huang@linux.intel.com>

On Mon Feb 5, 2024 at 11:06 PM EET, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> To determine if any page available for reclamation at the global level,
> only checking for emptiness of the global LRU is not adequate when pages
> are tracked in multiple LRUs, one per cgroup. For this purpose, create a
> new helper, sgx_can_reclaim(), currently only checks the global LRU,
> later will check emptiness of LRUs of all cgroups when per-cgroup
> tracking is turned on. Replace all the checks of the global LRU,
> list_empty(&sgx_global_lru.reclaimable), with calls to
> sgx_can_reclaim().
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> v7:
> - Split this out from the big patch, #10 in V6. (Dave, Kai)
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index 2279ae967707..6b0c26cac621 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -37,6 +37,11 @@ static inline struct sgx_epc_lru_list *sgx_lru_list(st=
ruct sgx_epc_page *epc_pag
>  	return &sgx_global_lru;
>  }
> =20

/*
 * Description
 */
> +static inline bool sgx_can_reclaim(void)
> +{
> +	return !list_empty(&sgx_global_lru.reclaimable);
> +}
> +
>  static atomic_long_t sgx_nr_free_pages =3D ATOMIC_LONG_INIT(0);
> =20
>  /* Nodes with one or more EPC sections. */
> @@ -398,7 +403,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_lis=
t *lru, unsigned int *nr_to
>  static bool sgx_should_reclaim(unsigned long watermark)
>  {
>  	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
> -	       !list_empty(&sgx_global_lru.reclaimable);
> +		sgx_can_reclaim();
>  }
> =20
>  static void sgx_reclaim_pages_global(bool indirect)
> @@ -601,7 +606,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, =
bool reclaim)
>  			break;
>  		}
> =20
> -		if (list_empty(&sgx_global_lru.reclaimable)) {
> +		if (!sgx_can_reclaim()) {
>  			page =3D ERR_PTR(-ENOMEM);
>  			break;
>  		}

BR, Jarkko

