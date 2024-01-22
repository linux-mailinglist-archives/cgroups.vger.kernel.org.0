Return-Path: <cgroups+bounces-1203-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA26837390
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 21:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25826B22544
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 20:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27FD40BE5;
	Mon, 22 Jan 2024 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpDahR7F"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799E63DB86;
	Mon, 22 Jan 2024 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954447; cv=none; b=Xb4h19ehP7MCmtf0kjRNkXxpmlVuAeadgmZJ6PfuDz5E49o+cshQAH5HUgIFWO3qQmdFRep4Wi//jvJCR2qy4HBfEXS4XKtwz1wIdEKCJwE3Fjuajb23J7Umx4ppy3k4EMloMbSql3vLNma0qmIR9vrHassVrOkEPdoniQ4v19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954447; c=relaxed/simple;
	bh=rUyMHHkZu6cL7ZgVe6OfxVcmPIxgxyB7LlB31VSOuhk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aPqKsQZO9g5t4l8dwHIfMoZ57g4fOZxKy0dKVGmxIcjJ9a5JuIZ5SQXs4OQS4QHN99Q+CDGEHlEF45fDLHzYvRRGhGQwz4km2/liHoMouNU/EIYeHoGO3NlmIgDoS7tTSGWMcYl9f3GAuvcmvhDGid5XJYVBNrbXml2jJaGFKA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpDahR7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59974C43394;
	Mon, 22 Jan 2024 20:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705954447;
	bh=rUyMHHkZu6cL7ZgVe6OfxVcmPIxgxyB7LlB31VSOuhk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fpDahR7FxoiZI53jeO5qmiFN5pjBSQfhKukLU+OStAMY4NSUCzIWlyZuWJtxgX8F6
	 9lqu7nnNRxa/jjeL4qlLEcjucjF2VRi0pL5H3+kMDFXnL3l3hBar7ejEqDMn4IXrCV
	 L3Dq3vGaDjaMH8tsniDwViGDeRNm41xzHIf4zrQg7gHwpI+mkNmOXFqVZAW/ZL+1Oe
	 zYpvuxb9A5VhDmaJdKVEQRheUF6iixy+ERnfDeprerHnHK5+PIjm3/pXimYIyFLCBg
	 i22Ox036aIg3G+t2QGZ2U9rj8n1ON/Z0gFPTtVhhqIE5gOMIAZ2Re2hTzYvn8A3FcD
	 M8G6z4Ow3Pjaw==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jan 2024 22:14:01 +0200
Message-Id: <CYLIDNAH2GKZ.2GZXE5Z7EXKSI@suppilovahvero>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>
Subject: Re: [PATCH v7 01/15] cgroup/misc: Add per resource callbacks for
 CSS events
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
 <20240122172048.11953-2-haitao.huang@linux.intel.com>
In-Reply-To: <20240122172048.11953-2-haitao.huang@linux.intel.com>

On Mon Jan 22, 2024 at 7:20 PM EET, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> The misc cgroup controller (subsystem) currently does not perform
> resource type specific action for Cgroups Subsystem State (CSS) events:
> the 'css_alloc' event when a cgroup is created and the 'css_free' event
> when a cgroup is destroyed.
>
> Define callbacks for those events and allow resource providers to
> register the callbacks per resource type as needed. This will be
> utilized later by the EPC misc cgroup support implemented in the SGX
> driver.
>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V7:
> - Make ops one per resource type and store them in array (Michal)
> - Rename the ops struct to misc_res_ops, and enforce the constraints of r=
equired callback
> functions (Jarkko)
> - Moved addition of priv field to patch 4 where it was used first. (Jarkk=
o)
>
> V6:
> - Create ops struct for per resource callbacks (Jarkko)
> - Drop max_write callback (Dave, Michal)
> - Style fixes (Kai)
> ---
>  include/linux/misc_cgroup.h | 11 +++++++
>  kernel/cgroup/misc.c        | 60 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 68 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> index e799b1f8d05b..0806d4436208 100644
> --- a/include/linux/misc_cgroup.h
> +++ b/include/linux/misc_cgroup.h
> @@ -27,6 +27,16 @@ struct misc_cg;
> =20
>  #include <linux/cgroup.h>
> =20
> +/**
> + * struct misc_res_ops: per resource type callback ops.
> + * @alloc: invoked for resource specific initialization when cgroup is a=
llocated.
> + * @free: invoked for resource specific cleanup when cgroup is deallocat=
ed.
> + */
> +struct misc_res_ops {
> +	int (*alloc)(struct misc_cg *cg);
> +	void (*free)(struct misc_cg *cg);
> +};
> +
>  /**
>   * struct misc_res: Per cgroup per misc type resource
>   * @max: Maximum limit on the resource.
> @@ -56,6 +66,7 @@ struct misc_cg {
> =20
>  u64 misc_cg_res_total_usage(enum misc_res_type type);
>  int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
> +int misc_cg_set_ops(enum misc_res_type type, const struct misc_res_ops *=
ops);
>  int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 =
amount);
>  void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64 a=
mount);
> =20
> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> index 79a3717a5803..b8c32791334c 100644
> --- a/kernel/cgroup/misc.c
> +++ b/kernel/cgroup/misc.c
> @@ -39,6 +39,9 @@ static struct misc_cg root_cg;
>   */
>  static u64 misc_res_capacity[MISC_CG_RES_TYPES];
> =20
> +/* Resource type specific operations */
> +static const struct misc_res_ops *misc_res_ops[MISC_CG_RES_TYPES];
> +
>  /**
>   * parent_misc() - Get the parent of the passed misc cgroup.
>   * @cgroup: cgroup whose parent needs to be fetched.
> @@ -105,6 +108,36 @@ int misc_cg_set_capacity(enum misc_res_type type, u6=
4 capacity)
>  }
>  EXPORT_SYMBOL_GPL(misc_cg_set_capacity);
> =20
> +/**
> + * misc_cg_set_ops() - set resource specific operations.
> + * @type: Type of the misc res.
> + * @ops: Operations for the given type.
> + *
> + * Context: Any context.
> + * Return:
> + * * %0 - Successfully registered the operations.
> + * * %-EINVAL - If @type is invalid, or the operations missing any requi=
red callbacks.
> + */
> +int misc_cg_set_ops(enum misc_res_type type, const struct misc_res_ops *=
ops)
> +{
> +	if (!valid_type(type))
> +		return -EINVAL;
> +
> +	if (!ops->alloc) {
> +		pr_err("%s: alloc missing\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (!ops->free) {
> +		pr_err("%s: free missing\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	misc_res_ops[type] =3D ops;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(misc_cg_set_ops);
> +
>  /**
>   * misc_cg_cancel_charge() - Cancel the charge from the misc cgroup.
>   * @type: Misc res type in misc cg to cancel the charge from.
> @@ -383,23 +416,37 @@ static struct cftype misc_cg_files[] =3D {
>  static struct cgroup_subsys_state *
>  misc_cg_alloc(struct cgroup_subsys_state *parent_css)
>  {
> +	struct misc_cg *parent_cg, *cg;
>  	enum misc_res_type i;
> -	struct misc_cg *cg;
> +	int ret;
> =20
>  	if (!parent_css) {
> -		cg =3D &root_cg;
> +		parent_cg =3D cg =3D &root_cg;
>  	} else {
>  		cg =3D kzalloc(sizeof(*cg), GFP_KERNEL);
>  		if (!cg)
>  			return ERR_PTR(-ENOMEM);
> +		parent_cg =3D css_misc(parent_css);
>  	}
> =20
>  	for (i =3D 0; i < MISC_CG_RES_TYPES; i++) {
>  		WRITE_ONCE(cg->res[i].max, MAX_NUM);
>  		atomic64_set(&cg->res[i].usage, 0);
> +		if (misc_res_ops[i]) {
> +			ret =3D misc_res_ops[i]->alloc(cg);
> +			if (ret)
> +				goto alloc_err;

So I'd consider pattern like this to avoid repetition:

			if (ret) {
				__misc_cg_free(cg);
				return PERR_PTR(ret);
			}

and call __misc_cg_free() also in misc_cg_free().

BR, Jarkko

