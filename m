Return-Path: <cgroups+bounces-14217-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB5II52pnWmgQwQAu9opvQ
	(envelope-from <cgroups+bounces-14217-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 14:37:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ADA187D0A
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 14:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B6B9302F73D
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 13:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA563A1A43;
	Tue, 24 Feb 2026 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTmOl1Wg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00BD3A0EB2
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940120; cv=none; b=IgfxSMHS/t6d9O9y9xsQGDKWSl6gRmZs0Nn1Euub1x4GgOtcI240bxwSSJCC79v4OGvKmPRiudEUQV7FnZ3q6w0sSCE2NXOTx0M+wv/+7aV7N7ALKOToJBkFvyHo87SYad8IZNHJzL+4iy8aacH394Zao0lpar21GfbsHqGjVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940120; c=relaxed/simple;
	bh=qhbJpmZITKjbEAcPdtlGm6W8/Qffyxn/CjLw4UREa1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlZMM67aDf9vVkF212ejfqyPbGu+42Yuiq5lKly/sir2oDmFQIe8+tCf2FtdjoRZuogR6ztokZLVCgK0paKc8QpPTC60XzgJT+Ib6OoylNm7v74kc9gEvpcKBa8GvjeIzwOiI0aVfQplwz8KW4YeEo1CAkeunRrcX0yjVn8r6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TTmOl1Wg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65f771c6b89so11913a12.3
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 05:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771940116; x=1772544916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=017Au0WagCuxotQHTbuPbnn7OOhD26VlW9T9YwI+bmw=;
        b=TTmOl1WgO9ipDMNDDj3wD89bpFoluL+wCTIJLb4MqoavlpDQ7xDtodnvIGGDqUtyoV
         4RuHCPw2s1t1N3q7xh+MDGSRsMf2rHME6KoikPe0TAyvLoQ2PpIpze0jjE2xrJ1zLSxg
         lSiEZ0xAr3QCnDNChTXHZBsW60fDZ+7HIvIN19yVqKesbgtur9ChCDTEh/FEi/Wunz1D
         eSRz7a9cqDMe9Z2lGY1nPkhl0rL0NUbLZXbw3DCCismTWLKcz4H0yL6aFBSVNFViPnFZ
         dU5OygsDP70fjKg+dUuf9sLk/Cfc7KSLLOTxK/nT29jkbd8Yg0GgNshE+3zb3RZMh5Vs
         2RUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771940116; x=1772544916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=017Au0WagCuxotQHTbuPbnn7OOhD26VlW9T9YwI+bmw=;
        b=xF6yqvFA86E4wCJwbMBEVUG4yoDcwY5ap+dLa31pffdPrefzQvqFRNGqsxbV5NM0fS
         R9T1nVT53TxOY+uB3wcchQa0TL+npHYvQSwc4mE1z84h/X1KsE13Yf6kf0nCqRB5RGue
         37saEQHf5LG4AsTa2SUy8zAUxO51xl6OAaPLydstuWUKt39um4oja53KvIAIeXLPxIIC
         wlF0NuQ3YuMq868xYWEM6S2YcCa1++UUrWYRqdAH90Z9OHnXN6CPsxhxG8hsFFMc6lRN
         e199hjk3LdvlwCnGNc1IWLEOIVYF/neUyxFhddUhuFz9oS4T8xJM77Ps81rko9weJHw0
         ELKw==
X-Forwarded-Encrypted: i=1; AJvYcCXkBXM0xN6lr2nNWv92w6Nj3d+QG3W5nDkGTMAzNIkTx6y2tgau3gZAk+NoDewUrqUPJ0OMQaQo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvs98P0/1mbKM8CGpQs/6i5jGH2ZA30WgiXPQaRXkCRxViSGHT
	PSKAIdEQCkxU5VGt9OxhrGFQ/offE6xjJeMgbDmKuSkGMHDAfsCNin/nV/7krYUhzA==
X-Gm-Gg: AZuq6aKYEfjat0+5CyGPUBCVGPiYunb2FfATgzGK0ZplYLX9PFRLxjdr0XSDqiERRdn
	qy5yzoPW+ZAVCvnMuM4hiwu+xf/3Oruar2w6Y2t5lR8sxzU9cT5HfeIFs1/G85sy6KoPUPNC0e6
	piY4Xjq2YX3e5p0xJE0b4uUKepMjzIHMd5tWdnCxnV/Hgi968c6nrgxO3ndjxdX5pelR0egdaKd
	q+CY+wIFsos2z6sgS4EMFCRdX8vw9lFdaOx12KJ7O8Ypiq0uT/2pLwBOX3x2G560k8wPKkrzo/H
	CFW+BO1aPw4Clhfw9fxZOUS0wcgC7wCFuKuIGwdoEQfpWeqyPGntIivZRlLzTPxNFJTK/Y6HpdU
	G5debQGd8aYbDycRC1RnVzo6TtshT5FO14xtDgXQyysIEs+HZW9mu2wh8Rf0+r/Y1Pn8JLN1ORN
	bqg+BRLvmPnSNMpEiG9phESMoNZ8ycCJLTkXIFyaWOAG7W7jO2rlYj2UjXinrFZMU=
X-Received: by 2002:a17:906:eec7:b0:b87:117f:b6f0 with SMTP id a640c23a62f3a-b9081b23d01mr691501366b.30.1771940115631;
        Tue, 24 Feb 2026 05:35:15 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084a4d6e1sm426835366b.0.2026.02.24.05.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:35:15 -0800 (PST)
Date: Tue, 24 Feb 2026 13:35:11 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>,
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 1/4] ns: add bpf hooks
Message-ID: <aZ2pDzhDFpFMjgb1@google.com>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14217-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mattbobrowski@google.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,openvz.org:email]
X-Rspamd-Queue-Id: 27ADA187D0A
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 01:38:29AM +0100, Christian Brauner wrote:
> Add the three namespace lifecycle hooks and make them available to bpf
> lsm program types. This allows bpf to supervise namespace creation. I'm
> in the process of adding various "universal truth" bpf programs to
> systemd that will make use of this. This e.g., allows to lock in a
> program into a given set of namespaces.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
>  kernel/bpf/bpf_lsm.c    | 25 +++++++++++++++++++++++++
>  kernel/nscommon.c       |  9 ++++++++-
>  kernel/nsproxy.c        |  7 +++++++
>  4 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 643809cc78c3..5ae438fdf567 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -12,6 +12,9 @@
>  #include <linux/bpf_verifier.h>
>  #include <linux/lsm_hooks.h>
>  
> +struct ns_common;
> +struct nsset;
> +
>  #ifdef CONFIG_BPF_LSM
>  
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> @@ -48,6 +51,11 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
>  
>  int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>  			     struct bpf_retval_range *range);
> +
> +int bpf_lsm_namespace_alloc(struct ns_common *ns);
> +void bpf_lsm_namespace_free(struct ns_common *ns);
> +int bpf_lsm_namespace_install(struct nsset *nsset, struct ns_common *ns);
> +
>  int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
>  				const struct bpf_dynptr *value_p, int flags);
>  int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
> @@ -104,6 +112,19 @@ static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
>  {
>  	return false;
>  }
> +
> +static inline int bpf_lsm_namespace_alloc(struct ns_common *ns)
> +{
> +	return 0;
> +}
> +static inline void bpf_lsm_namespace_free(struct ns_common *ns)
> +{
> +}
> +static inline int bpf_lsm_namespace_install(struct nsset *nsset,
> +					    struct ns_common *ns)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_BPF_LSM */
>  
>  #endif /* _LINUX_BPF_LSM_H */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 0c4a0c8e6f70..f6378db46220 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -30,10 +30,32 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
>  
> +__bpf_hook_start();
> +
> +__weak noinline int bpf_lsm_namespace_alloc(struct ns_common *ns)
> +{
> +	return 0;
> +}
> +
> +__weak noinline void bpf_lsm_namespace_free(struct ns_common *ns)
> +{
> +}

I'm wondering how you foresee this hook functioning in a scenario
where the BPF LSM program is attached to this new hook point, although
with its attachment type being set to BPF_LSM_CGROUP instead of
BPF_LSM_MAC? You probably wouldn't want to utilize something like
BPF_LSM_CGROUP for your specific use case, but as things stand
currently I don't believe there's anyhthing preventing you from using
BPF_LSM_CGROUP with a hook like bpf_lsm_namespace_free().

Notably, the BPF_LSM_CGROUP infrastructure is designed to execute BPF
programs based on the cgroup of the currently executing task. There
could be some surprises if the bpf_lsm_namespace_free() hook were to
ever be called from a context (e.g, kworker) other than the one
specified whilst attaching the BPF LSM program with type
BPF_LSM_CGROUP.

> +__weak noinline int bpf_lsm_namespace_install(struct nsset *nsset,
> +					  struct ns_common *ns)
> +{
> +	return 0;
> +}
> +
> +__bpf_hook_end();
> +
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
>  BTF_SET_START(bpf_lsm_hooks)
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
> +BTF_ID(func, bpf_lsm_namespace_alloc)
> +BTF_ID(func, bpf_lsm_namespace_free)
> +BTF_ID(func, bpf_lsm_namespace_install)
>  BTF_SET_END(bpf_lsm_hooks)
>  
>  BTF_SET_START(bpf_lsm_disabled_hooks)
> @@ -383,6 +405,8 @@ BTF_ID(func, bpf_lsm_task_prctl)
>  BTF_ID(func, bpf_lsm_task_setscheduler)
>  BTF_ID(func, bpf_lsm_task_to_inode)
>  BTF_ID(func, bpf_lsm_userns_create)
> +BTF_ID(func, bpf_lsm_namespace_alloc)
> +BTF_ID(func, bpf_lsm_namespace_install)
>  BTF_SET_END(sleepable_lsm_hooks)
>  
>  BTF_SET_START(untrusted_lsm_hooks)
> @@ -395,6 +419,7 @@ BTF_ID(func, bpf_lsm_sk_alloc_security)
>  BTF_ID(func, bpf_lsm_sk_free_security)
>  #endif /* CONFIG_SECURITY_NETWORK */
>  BTF_ID(func, bpf_lsm_task_free)
> +BTF_ID(func, bpf_lsm_namespace_free)
>  BTF_SET_END(untrusted_lsm_hooks)
>  
>  bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index bdc3c86231d3..c3613cab3d41 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
>  
> +#include <linux/bpf_lsm.h>
>  #include <linux/ns_common.h>
>  #include <linux/nstree.h>
>  #include <linux/proc_ns.h>
> @@ -77,6 +78,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  		ret = proc_alloc_inum(&ns->inum);
>  	if (ret)
>  		return ret;
> +
>  	/*
>  	 * Tree ref starts at 0. It's incremented when namespace enters
>  	 * active use (installed in nsproxy) and decremented when all
> @@ -86,11 +88,16 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  		atomic_set(&ns->__ns_ref_active, 1);
>  	else
>  		atomic_set(&ns->__ns_ref_active, 0);
> -	return 0;
> +
> +	ret = bpf_lsm_namespace_alloc(ns);
> +	if (ret && !inum)
> +		proc_free_inum(ns->inum);
> +	return ret;
>  }
>  
>  void __ns_common_free(struct ns_common *ns)
>  {
> +	bpf_lsm_namespace_free(ns);
>  	proc_free_inum(ns->inum);
>  }
>  
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index 259c4b4f1eeb..5742f9664dbb 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -9,6 +9,7 @@
>   *             Pavel Emelianov <xemul@openvz.org>
>   */
>  
> +#include <linux/bpf_lsm.h>
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <linux/nsproxy.h>
> @@ -379,6 +380,12 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
>  
>  static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
>  {
> +	int ret;
> +
> +	ret = bpf_lsm_namespace_install(nsset, ns);
> +	if (ret)
> +		return ret;
> +
>  	return ns->ops->install(nsset, ns);
>  }
>  
> 
> -- 
> 2.47.3
> 

