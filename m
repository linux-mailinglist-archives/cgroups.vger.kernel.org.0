Return-Path: <cgroups+bounces-1204-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B810D837399
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 21:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398061F2CC4D
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 20:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF95B40BEE;
	Mon, 22 Jan 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gutplTJX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648513DB86;
	Mon, 22 Jan 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954660; cv=none; b=lTAxGrK7Nu68GiYRhDsztN+1phYyEoN5TNXoylqwfewaSoyT0KkQQB/4Nn6RehqEY+ZHfEbBuoZRUsL1jYI5E+nnMTMB+gFLMrOpQ6B5O7WgReGHAPEt+qryF6ioVRecZo+S0p5h15qJfgIhYZiOLKfmJsIFv2ZORb9GXp+U0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954660; c=relaxed/simple;
	bh=+Fq1mXLnuYMPXNG9tAtJqDwn7DKQ8T1le9LlREpJAOw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=O9as58dWQRE/GH0Su4MxT1ocowmo2Dbgqd1Kwj6Go0vyYXpmCdyw6iEryxaGJ9qXMAA0wLcdoVF4pOiYl97ZUwpda754JwamUkybB7nVfS6z7jyr15PG/TR0uaqmT27PhNYF8jwA6hY5n3nVaZdemifLtdXN+vbIlKBDBBCFTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gutplTJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151E0C433F1;
	Mon, 22 Jan 2024 20:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705954659;
	bh=+Fq1mXLnuYMPXNG9tAtJqDwn7DKQ8T1le9LlREpJAOw=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=gutplTJXgzet2QeHNjTbyvUzeIT6aUQqvQbMoS4O7ls2llV3Bvl2VYwZwEILlxbIw
	 JJ4WZyCP6phDlgnrHTmpswlfCbcmOzGEypIf6slgq5zze46cQH1snFKcJ/iDAnFnam
	 7Sw9aQPCEEBJ53NCYGIiM/XaxMsDNc1WFTfxcNo1CSS+zLAFrbEzZG7XQT98dxMvVv
	 yKp7Dfq50scfEMS1VDZGaNNI34aWH7EbHkn4Gh9Ym9dsES/+Xns1qDnKcOkM6svFb8
	 PpqDaqe45n5dLBjuME3EKvRBzT5cvK0v3qtYJ9X+G3EYqB33gjnmDV/hfleUmUrPb5
	 WV9QaHJDqDmhA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jan 2024 22:17:34 +0200
Message-Id: <CYLIGD14Q8YF.GBAMG72CJWYK@suppilovahvero>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>
Subject: Re: [PATCH v7 02/15] cgroup/misc: Export APIs for SGX driver
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
 <20240122172048.11953-3-haitao.huang@linux.intel.com>
In-Reply-To: <20240122172048.11953-3-haitao.huang@linux.intel.com>

On Mon Jan 22, 2024 at 7:20 PM EET, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> The SGX EPC cgroup will reclaim EPC pages when a usage in a cgroup
> reaches its or ancestor's limit. This requires a walk from the current
> cgroup up to the root similar to misc_cg_try_charge(). Export
> misc_cg_parent() to enable this walk.
>
> The SGX driver may also need start a global level reclamation from the
> root. Export misc_cg_root() for the SGX driver to access.
>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V6:
> - Make commit messages more concise and split the original patch into two=
(Kai)
> ---
>  include/linux/misc_cgroup.h | 24 ++++++++++++++++++++++++
>  kernel/cgroup/misc.c        | 21 ++++++++-------------
>  2 files changed, 32 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> index 0806d4436208..541a5611c597 100644
> --- a/include/linux/misc_cgroup.h
> +++ b/include/linux/misc_cgroup.h
> @@ -64,6 +64,7 @@ struct misc_cg {
>  	struct misc_res res[MISC_CG_RES_TYPES];
>  };
> =20
> +struct misc_cg *misc_cg_root(void);
>  u64 misc_cg_res_total_usage(enum misc_res_type type);
>  int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
>  int misc_cg_set_ops(enum misc_res_type type, const struct misc_res_ops *=
ops);
> @@ -84,6 +85,20 @@ static inline struct misc_cg *css_misc(struct cgroup_s=
ubsys_state *css)
>  	return css ? container_of(css, struct misc_cg, css) : NULL;
>  }
> =20
> +/**
> + * misc_cg_parent() - Get the parent of the passed misc cgroup.
> + * @cgroup: cgroup whose parent needs to be fetched.
> + *
> + * Context: Any context.
> + * Return:
> + * * struct misc_cg* - Parent of the @cgroup.
> + * * %NULL - If @cgroup is null or the passed cgroup does not have a par=
ent.
> + */
> +static inline struct misc_cg *misc_cg_parent(struct misc_cg *cgroup)
> +{
> +	return cgroup ? css_misc(cgroup->css.parent) : NULL;
> +}
> +
>  /*
>   * get_current_misc_cg() - Find and get the misc cgroup of the current t=
ask.
>   *
> @@ -108,6 +123,15 @@ static inline void put_misc_cg(struct misc_cg *cg)
>  }
> =20
>  #else /* !CONFIG_CGROUP_MISC */
> +static inline struct misc_cg *misc_cg_root(void)
> +{
> +	return NULL;
> +}
> +
> +static inline struct misc_cg *misc_cg_parent(struct misc_cg *cg)
> +{
> +	return NULL;
> +}
> =20
>  static inline u64 misc_cg_res_total_usage(enum misc_res_type type)
>  {
> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> index b8c32791334c..99d971ecc842 100644
> --- a/kernel/cgroup/misc.c
> +++ b/kernel/cgroup/misc.c
> @@ -43,18 +43,13 @@ static u64 misc_res_capacity[MISC_CG_RES_TYPES];
>  static const struct misc_res_ops *misc_res_ops[MISC_CG_RES_TYPES];
> =20
>  /**
> - * parent_misc() - Get the parent of the passed misc cgroup.
> - * @cgroup: cgroup whose parent needs to be fetched.
> - *
> - * Context: Any context.
> - * Return:
> - * * struct misc_cg* - Parent of the @cgroup.
> - * * %NULL - If @cgroup is null or the passed cgroup does not have a par=
ent.
> + * misc_cg_root() - Return the root misc cgroup.
>   */
> -static struct misc_cg *parent_misc(struct misc_cg *cgroup)
> +struct misc_cg *misc_cg_root(void)
>  {
> -	return cgroup ? css_misc(cgroup->css.parent) : NULL;
> +	return &root_cg;
>  }
> +EXPORT_SYMBOL_GPL(misc_cg_root);
> =20
>  /**
>   * valid_type() - Check if @type is valid or not.
> @@ -183,7 +178,7 @@ int misc_cg_try_charge(enum misc_res_type type, struc=
t misc_cg *cg, u64 amount)
>  	if (!amount)
>  		return 0;
> =20
> -	for (i =3D cg; i; i =3D parent_misc(i)) {
> +	for (i =3D cg; i; i =3D misc_cg_parent(i)) {
>  		res =3D &i->res[type];
> =20
>  		new_usage =3D atomic64_add_return(amount, &res->usage);
> @@ -196,12 +191,12 @@ int misc_cg_try_charge(enum misc_res_type type, str=
uct misc_cg *cg, u64 amount)
>  	return 0;
> =20
>  err_charge:
> -	for (j =3D i; j; j =3D parent_misc(j)) {
> +	for (j =3D i; j; j =3D misc_cg_parent(j)) {
>  		atomic64_inc(&j->res[type].events);
>  		cgroup_file_notify(&j->events_file);
>  	}
> =20
> -	for (j =3D cg; j !=3D i; j =3D parent_misc(j))
> +	for (j =3D cg; j !=3D i; j =3D misc_cg_parent(j))
>  		misc_cg_cancel_charge(type, j, amount);
>  	misc_cg_cancel_charge(type, i, amount);
>  	return ret;
> @@ -223,7 +218,7 @@ void misc_cg_uncharge(enum misc_res_type type, struct=
 misc_cg *cg, u64 amount)
>  	if (!(amount && valid_type(type) && cg))
>  		return;
> =20
> -	for (i =3D cg; i; i =3D parent_misc(i))
> +	for (i =3D cg; i; i =3D misc_cg_parent(i))
>  		misc_cg_cancel_charge(type, i, amount);
>  }
>  EXPORT_SYMBOL_GPL(misc_cg_uncharge);

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

