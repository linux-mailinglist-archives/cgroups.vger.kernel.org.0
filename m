Return-Path: <cgroups+bounces-4516-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05C39616A4
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 20:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39B21C22EE0
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 18:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B485C1D27B7;
	Tue, 27 Aug 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+rsQzmV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C21CF2B8;
	Tue, 27 Aug 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782608; cv=none; b=Oj/WSTssSM/sBfPglLQLOBA/tEllvuPLL98nSbJCKKSvfASRwgH7V3IBnCd2K8oC26/Hp2OjO+9C9uQUAhx2C51T9aBO6npjqAL0c3rWruyWD3Vj6v3H31Ff1op6gsnTY/yU9VvaFiaxi54Odqc4pIUu09wCjYPGS3teT/14RzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782608; c=relaxed/simple;
	bh=oThr/IHEo/kvfoyvCuCzvD+In/VfXyrZvGOyTXkMn+0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Xdxcx7F3w+XvOTXeP259VdZDM5R1MNoVkVLsgD4FjetPZs6x75Ci+/sB6dgt8uugfZSFw2KExvS2hlzY4dTM2CEZ2LDKu1DTlm7JwsGarvksyto1vsDqnlAMDTnQsPVkeSHr/OYkijwUbjPR8ZAsnlbnlUrA2GRx/RrN6pgpE8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+rsQzmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8940AC567C2;
	Tue, 27 Aug 2024 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724782607;
	bh=oThr/IHEo/kvfoyvCuCzvD+In/VfXyrZvGOyTXkMn+0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=u+rsQzmVlmnkwAVJTDrKo36mnyuZoyQlRGcOm+p4aZGlnt8oAMw2LQyDe/uaCqTil
	 x8bMKTC9cShA+VBAoUAC12+mWoOrLHGhjAZpT7fNXqXmdy3ofrIShymdQ5kz+N+3CX
	 hkxe4eSLV1XEDoGC8QijD7jb1a55io3ytyIgrcmE9xIg7fvBVPQeft+TZADdWfq3+9
	 +F3ePJS1Nza9K1RnD8T94KonLYxDF35dGEiJYhqJKzCRYqFBdFtJ0nosRm6FtmRtfk
	 gqHV7LyopX0akMRvgl/5CK27qHcW+WANBird/u0w4Iv/2eE5Cp7z9clWI1TlaIsNHp
	 buOAU7gUc+oxA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Aug 2024 21:16:44 +0300
Message-Id: <D3QWELUYFVKI.2ODRK1OP9149A@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v16 13/16] x86/sgx: implement direct reclamation for
 cgroups
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <chenridong@huawei.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
 <20240821015404.6038-14-haitao.huang@linux.intel.com>
In-Reply-To: <20240821015404.6038-14-haitao.huang@linux.intel.com>

On Wed Aug 21, 2024 at 4:54 AM EEST, Haitao Huang wrote:
> sgx_reclaim_direct() was introduced to preemptively reclaim some pages
> as the best effort to avoid on-demand reclamation that can stall forward
> progress in some situations, e.g., allocating pages to load previously
> reclaimed page to perform EDMM operations on [1].
>
> Currently when the global usage is close to the capacity,
> sgx_reclaim_direct() makes one invocation to sgx_reclaim_pages_global()
> but does not guarantee there are free pages available for later
> allocations to succeed. In other words, the only goal here is to reduce
> the chance of on-demand reclamation at allocation time. In cases of
> allocation failure, the caller, the EDMM ioctl()'s, would return -EAGAIN
> to user space and let the user space to decide whether to retry or not.
>
> With EPC cgroups enabled, usage of a cgroup can also reach its limit
> (usually much lower than capacity) and trigger per-cgroup reclamation.
> Implement a similar strategy to reduce the chance of on-demand
> per-cgroup reclamation for this use case.
>
> Create a wrapper, sgx_cgroup_reclaim_direct(), to perform a preemptive
> reclamation at cgroup level, and have sgx_reclaim_direct() call it when
> EPC cgroup is enabled.
>
> [1] https://lore.kernel.org/all/a0d8f037c4a075d56bf79f432438412985f7ff7a.=
1652137848.git.reinette.chatre@intel.com/T/#u
>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 15 +++++++++++++++
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |  3 +++
>  arch/x86/kernel/cpu/sgx/main.c       |  4 ++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.c
> index 23a61689e0d9..b7d60b2d878d 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> @@ -252,6 +252,21 @@ void sgx_cgroup_reclaim_pages_global(struct mm_struc=
t *charge_mm)
>  	sgx_cgroup_reclaim_pages(&sgx_cg_root, charge_mm, SGX_NR_TO_SCAN);
>  }
> =20
> +/**
> + * sgx_cgroup_reclaim_direct() - Preemptive reclamation.
> + *
> + * Scan and attempt to reclaim %SGX_NR_TO_SCAN as best effort to allow c=
aller
> + * make quick progress.
> + */
> +void sgx_cgroup_reclaim_direct(void)
> +{
> +	struct sgx_cgroup *sgx_cg =3D sgx_get_current_cg();
> +
> +	if (sgx_cgroup_should_reclaim(sgx_cg))
> +		sgx_cgroup_reclaim_pages(sgx_cg, current->mm, SGX_NR_TO_SCAN);
> +	sgx_put_cg(sgx_cg);
> +}
> +
>  /*
>   * Asynchronous work flow to reclaim pages from the cgroup when the cgro=
up is
>   * at/near its maximum capacity.
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.h
> index c0390111e28c..cf2b946d993e 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> @@ -38,6 +38,8 @@ static inline void __init sgx_cgroup_register(void) { }
> =20
>  static inline void sgx_cgroup_reclaim_pages_global(struct mm_struct *cha=
rge_mm) { }
> =20
> +static inline void sgx_cgroup_reclaim_direct(void) { }
> +
>  #else /* CONFIG_CGROUP_MISC */
> =20
>  struct sgx_cgroup {
> @@ -90,6 +92,7 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg=
)
>  int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim re=
claim);
>  void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
>  void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm);
> +void sgx_cgroup_reclaim_direct(void);
>  int __init sgx_cgroup_init(void);
>  void __init sgx_cgroup_register(void);
>  void __init sgx_cgroup_deinit(void);
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index d00cb012838b..9a8f91ebd21b 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -428,6 +428,10 @@ static void sgx_reclaim_pages_global(struct mm_struc=
t *charge_mm)
>   */
>  void sgx_reclaim_direct(void)
>  {
> +	/* Reduce chance of per-cgroup reclamation for later allocation */
> +	sgx_cgroup_reclaim_direct();
> +
> +	/* Reduce chance of the global reclamation for later allocation */
>  	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
>  		sgx_reclaim_pages_global(current->mm);
>  }


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

