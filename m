Return-Path: <cgroups+bounces-1848-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7DB867FD1
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 19:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A27B25054
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 18:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A6812F362;
	Mon, 26 Feb 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gPR38tQC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WZwMp4/M"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311BA12E1F0;
	Mon, 26 Feb 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971968; cv=none; b=aOn+Ck7Sc0p8zD4/fsYy797dOodf9/IAgbtxNLIYcdwgppl7pf70zi3nCxPCLikFsQATgVblEMc42PHaD7M/EPV/YLYc20hEI6WiYwF1Az1EUxiGkQ8qPl37iiQhwDX/jZih+UbYfn+J5lwLKZ4fiCAEA4mn2KmlyLnupy5jw64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971968; c=relaxed/simple;
	bh=VtTNzlrs59laxBrReK1p7Gu/2+icjRsBAWJsbkQfoCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6Q/y1ld4AojA3f2P5A1ZRP53CB/1zIWyKjMM7nkrDysjW8szHXQVadzd1jF7FRHDW9EUqUSmt794T6VrrVCztuWhlPg/q9DlK4NO2x0ok30oHJ8kRxIlARQ4Bl9ewHI1ft8mn/2rTFbx1qsDS1a2yamXJI3wk4xdv50VD9e+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gPR38tQC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WZwMp4/M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E6D722266;
	Mon, 26 Feb 2024 18:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708971960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4UyhI4+JQGYKohUyOLoFySmI6ZvFW1Av1C82+dFjLlg=;
	b=gPR38tQCbarzjcOA5Hlp+X9Lj4hIFsTOT0Qzt244SJY8KvyRvC7FRqXo1QYGH5ZkUEbLtm
	OSeYXKBZqDL9mnOZG9ta+A2lXAVa/XE38OD1mmlPdT+v4/JCWsDRH10tICpyI8vTYXIQBT
	Ur2UmafVx03bGnmQ8hWnB6nYAJxw4Fk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708971959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4UyhI4+JQGYKohUyOLoFySmI6ZvFW1Av1C82+dFjLlg=;
	b=WZwMp4/MHfh9IWOZhqIC0M/eopgmi3FfTMusCSrLzb8cpayG37bX5tKA0dVs1SiPGjL7rT
	oAM6VT+2C0wETj3VZVgHoyZ5/jqbXoBLsB3vXHTmZFS3zEPFDaoJFwbj0NLO1zlKt9TtkQ
	MlxSfClbuT9cWz/T/2pcg1xTdfNDgJ4=
Date: Mon, 26 Feb 2024 19:25:58 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Haitao Huang <haitao.huang@linux.intel.com>
Cc: jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org, 
	linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org, 
	cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, sohil.mehta@intel.com, tim.c.chen@linux.intel.com, 
	zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com, zhanb@microsoft.com, 
	anakrish@microsoft.com, mikko.ylinen@linux.intel.com, yangjie@microsoft.com, 
	chrisyan@microsoft.com
Subject: Re: [PATCH v9 04/15] x86/sgx: Implement basic EPC misc cgroup
 functionality
Message-ID: <7u3intene6yvlkuks5bix3tx27wog3da6ki5w2l5flaod5mjrq@flgmfdd4fbei>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-5-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mk6rhzbt6pcubuwj"
Content-Disposition: inline
In-Reply-To: <20240205210638.157741-5-haitao.huang@linux.intel.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.26
X-Spamd-Result: default: False [-3.26 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 BAYES_HAM(-0.36)[76.82%]
X-Spam-Flag: NO


--mk6rhzbt6pcubuwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 05, 2024 at 01:06:27PM -0800, Haitao Huang <haitao.huang@linux.intel.com> wrote:
> +static int sgx_epc_cgroup_alloc(struct misc_cg *cg);
> +
> +const struct misc_res_ops sgx_epc_cgroup_ops = {
> +	.alloc = sgx_epc_cgroup_alloc,
> +	.free = sgx_epc_cgroup_free,
> +};
> +
> +static void sgx_epc_misc_init(struct misc_cg *cg, struct sgx_epc_cgroup *epc_cg)
> +{
> +	cg->res[MISC_CG_RES_SGX_EPC].priv = epc_cg;
> +	epc_cg->cg = cg;
> +}

This is a possibly a nit pick but I share it here for consideration.

Would it be more prudent to have the signature like
  alloc(struct misc_res *res, struct misc_cg *cg)
so that implementations are free of the assumption of how cg and res are
stored?


Thanks,
Michal

--mk6rhzbt6pcubuwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZdzXtAAKCRAGvrMr/1gc
jpdtAP9DWI9U4DslLhCagwW21vXmXhw9bODS8LhGRCej42QUoQEApnC+8dZ4bSk3
Lmoa7gR+DzY5iQz88kGW8UD4FM1+6QI=
=yenn
-----END PGP SIGNATURE-----

--mk6rhzbt6pcubuwj--

