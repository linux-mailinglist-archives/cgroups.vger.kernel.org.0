Return-Path: <cgroups+bounces-1205-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608C383739B
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 21:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F3C28855B
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63040BE8;
	Mon, 22 Jan 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XypvkZ9k"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EFF41201;
	Mon, 22 Jan 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954687; cv=none; b=Ad42mPgNSreAxqr48VGFfEoBKEWhFZ3SoSXfA20RAGNY0EDoFMRh1KBnFbEHWI6OBpGD/qbtuFE331ArmtPIpPUEysnGZks0W7ouEXWQw5OL2XSWEJfc2L3TaBZybLl/E8+CIbF2b2z8vCBUAeAxDsiMiNj4tb4jn56kRseuJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954687; c=relaxed/simple;
	bh=hWU5txo3LcJxEQr4McFHIiGTJNky9qKl+UtbSV2xMjQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=QDzHwMIZ7duXYhkcbjCNEy1hIHuh9ZbUA/Xa4IKsKAuuM4pfzjrmSR+02D7icd6xbiz7fuks1f9MtcqdhwzxEgbgakkM5dExtmrFEyrnfbdMhET3DF7ncUX1VpOm/b2KxTG+OYFI+7sb7nvXbA0atdr2IADllXCdo6JBzn5aZRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XypvkZ9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF88C433F1;
	Mon, 22 Jan 2024 20:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705954686;
	bh=hWU5txo3LcJxEQr4McFHIiGTJNky9qKl+UtbSV2xMjQ=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=XypvkZ9kimBlfV6r3VOThWN5mAMD/5FI2oaLfKXsCKSK0dH5Ecm5/XFQjHqbeg9pL
	 K/AHD4F8tLSu6DVTGIkayfWOs2qO5sxkxQqEfCGgPsSrc0lEcF4k1iv5d8mElhqFcH
	 KxC6Zg6Ocn0qK+0mub61XDKt/ey6A44pazV47goiEHWIJ+OphcjPWFPva74L+bz/EY
	 oTAmU7UOByIMTpIdi1NAltIGy89sX+/wO+o32g/ANOpHFo65TICYB2wyp9uihh1Tvp
	 H+N9OVnkZR+NaboQNxiQlpttXpbwvHcKdm3zsx78PEzRw4tQhh5go1eylukLAIgfWF
	 l32JAt6dsyBRw==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jan 2024 22:18:01 +0200
Message-Id: <CYLIGPGLPBYO.14OTPEO55WM9G@suppilovahvero>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>
Subject: Re: [PATCH v7 03/15] cgroup/misc: Add SGX EPC resource type
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
 <20240122172048.11953-4-haitao.huang@linux.intel.com>
In-Reply-To: <20240122172048.11953-4-haitao.huang@linux.intel.com>

On Mon Jan 22, 2024 at 7:20 PM EET, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> Add SGX EPC memory, MISC_CG_RES_SGX_EPC, to be a valid resource type
> for the misc controller.
>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V6:
> - Split the original patch into this and the preceding one (Kai)
> ---
>  include/linux/misc_cgroup.h | 4 ++++
>  kernel/cgroup/misc.c        | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> index 541a5611c597..2f6cc3a0ad23 100644
> --- a/include/linux/misc_cgroup.h
> +++ b/include/linux/misc_cgroup.h
> @@ -17,6 +17,10 @@ enum misc_res_type {
>  	MISC_CG_RES_SEV,
>  	/* AMD SEV-ES ASIDs resource */
>  	MISC_CG_RES_SEV_ES,
> +#endif
> +#ifdef CONFIG_CGROUP_SGX_EPC
> +	/* SGX EPC memory resource */
> +	MISC_CG_RES_SGX_EPC,
>  #endif
>  	MISC_CG_RES_TYPES
>  };
> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> index 99d971ecc842..4c519423b071 100644
> --- a/kernel/cgroup/misc.c
> +++ b/kernel/cgroup/misc.c
> @@ -24,6 +24,10 @@ static const char *const misc_res_name[] =3D {
>  	/* AMD SEV-ES ASIDs resource */
>  	"sev_es",
>  #endif
> +#ifdef CONFIG_CGROUP_SGX_EPC
> +	/* Intel SGX EPC memory bytes */
> +	"sgx_epc",
> +#endif
>  };
> =20
>  /* Root misc cgroup */

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


