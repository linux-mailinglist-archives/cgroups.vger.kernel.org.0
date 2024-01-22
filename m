Return-Path: <cgroups+bounces-1210-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95328373D0
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 21:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF421C23290
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 20:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F873D3B7;
	Mon, 22 Jan 2024 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPe+eF/r"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8F2CA8;
	Mon, 22 Jan 2024 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955519; cv=none; b=N3FnfkIAJXVfjusSCenGoQP12ZufA7ckZcXJac/Xb3Ep6gpIfRxfwEokOZ01G8odqMpWU9rGF8afS+JQZ8NzenJL8utDpQblecqs19ugf7n1Yo86CNFbHAyO2Jg6BopuLDuZpw9sTR9CDJ2EHA/orVlUW/aZ7sIqRr3mN6mDbfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955519; c=relaxed/simple;
	bh=lX95mZ24ENjeIfQOzcfLTShypXgPs84p0dynMFOg+lw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Br1oDsuVz9P5bjjuunaBFuoe6/hFBivOGjkYmooUJiRNiFVJy8BF/vqjLQ6sEqlPc2W7md2yeXxJ28Z81idtmas+COz05MAZr0D3ITXSnCbuHvUHtfjFuOJzRSlRv7ltDSgFvK6ogEZcmTynvIQwT4hmT3sJYRe+NwmY9mP5eBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPe+eF/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2148BC433C7;
	Mon, 22 Jan 2024 20:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705955518;
	bh=lX95mZ24ENjeIfQOzcfLTShypXgPs84p0dynMFOg+lw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=uPe+eF/rA7sTtZUvKZkt68zZ8/f+lKon7D2hDcZCK4Tr9JZe4O2JZHF8hDz9a+Ujm
	 ouFghdDZHWXyu+tYxJl2W3pPnpOrQLS9FQSXZ/K/gfCu7wvKUoJFB5FjcRMFBSvX0w
	 jSP1fbaPxUR/1sQ+kQjiyiV9GL3H1lKpJt87L7QcG+Br/BhLcaLnxJyS5W38Fg6vEH
	 CSW9ACot8PUcNv5Ep+akq/tYGy36kB2S1WpKdcWwmXyZzIzTzdrZrlkHhf05zTJwFb
	 6qnUYt2UWtJrgVKvTvaUbQfMW7vxPU4t1F8jAFZRFJCSwm3voLxNuh7PYrk/DLxmNL
	 O++2QxtHyRnUw==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jan 2024 22:31:53 +0200
Message-Id: <CYLIRBOVXWK1.3Q3J47OI076X@suppilovahvero>
Subject: Re: [PATCH v7 12/15] x86/sgx: Expose sgx_epc_cgroup_reclaim_pages()
 for global reclaimer
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>
X-Mailer: aerc 0.15.2
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
 <20240122172048.11953-13-haitao.huang@linux.intel.com>
In-Reply-To: <20240122172048.11953-13-haitao.huang@linux.intel.com>

On Mon Jan 22, 2024 at 7:20 PM EET, Haitao Huang wrote:
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
> V7:
> - Split this out from the big patch, #10 in V6. (Dave, Kai)
> ---
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 2 +-
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.c
> index c28ed12ff864..fdf1417d9ade 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> @@ -88,7 +88,7 @@ bool sgx_epc_cgroup_lru_empty(struct misc_cg *root)
>   * @indirect:   In ksgxd or EPC cgroup work queue context.
>   * Return:	Number of pages reclaimed.
>   */
> -static unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, b=
ool indirect)
> +unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool ind=
irect)
>  {
>  	/*
>  	 * Attempting to reclaim only a few pages will often fail and is ineffi=
cient, while
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/s=
gx/epc_cgroup.h
> index 6e156de5f7ff..05a4de9f7024 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> @@ -31,6 +31,12 @@ static inline int sgx_epc_cgroup_try_charge(struct sgx=
_epc_cgroup *epc_cg, bool
>  static inline void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg=
) { }
> =20
>  static inline void sgx_epc_cgroup_init(void) { }
> +
> +static inline unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *=
root,
> +							bool indirect)
> +{
> +	return 0;
> +}
>  #else
>  struct sgx_epc_cgroup {
>  	struct misc_cg			*cg;
> @@ -69,6 +75,9 @@ static inline void sgx_put_epc_cg(struct sgx_epc_cgroup=
 *epc_cg)
>  int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool reclai=
m);
>  void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
>  bool sgx_epc_cgroup_lru_empty(struct misc_cg *root);
> +unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root,
> +					  bool indirect);

Here, on the other hand, you could put the whole declaration to single
line.

> +
>  void sgx_epc_cgroup_init(void);
> =20
>  #endif

BR, Jarkko


