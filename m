Return-Path: <cgroups+bounces-14179-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOiAAN37nGmtMQQAu9opvQ
	(envelope-from <cgroups+bounces-14179-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 02:16:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B481806FA
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 02:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04E9B30574B2
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 01:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8242343BE;
	Tue, 24 Feb 2026 01:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MidSfS62"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F04137930
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 01:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771895769; cv=none; b=mW6Rmb1WlFiCYgay1YvDfVxEJuArcBWiDI+Yn8XnfBzmWJGLUiD5qFPTcvax4AA90z6oMFstLg0FbALPo3Nnvr3j2eOAmIkDMHBEIGavriETKe1Nl4L89GrUKu85MkUwvREHWRsj7PXV3QWpAW5PAMOMBxD83U3m28wgtkUuZqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771895769; c=relaxed/simple;
	bh=/WEwMXI9+NBYnYEUwRmLcJPLue1w5B8049oasKnv6uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dml5JZurWEc/FoZNh62FGnpekvQtfafXUEe7YWLlD9GTpwZBXYWFPh1tuo8ePogtmXr7DZvoz956ySnMzqKYfvg37IQXfdKzkUwAllMLKtIyf9LKO+WhkcOE2Od9Qi97C1hFpFvNOCwx5X0FZHFYk2XwbVxhzQJmlbrFBt+1CSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MidSfS62; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65c187dfc82so5969950a12.2
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 17:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771895766; x=1772500566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oyTNmHcTbqte4mfYZdJqgeiDYGxy4Pb6et+1aAN/vEo=;
        b=MidSfS62yG/6BrxdljqXq7zA2g7ak6LuqOkeDboDKzl/I1z14/EDZRKX2xEVJ7+t6e
         IwynIFXb0UyScYZEO72fq4jtO29jF8ItF2Bv19y7vTd8IQs+x5V9jS8wNhItLdkgS7On
         COT9cYxI3z0YgTX0xTeZ1ZyzBNEfDgqqUgQAEcIhdWy+gOrhE4uCIqjXc7o8m6evZ7zS
         qRs+xxtZy4LE9rlubZb3QJxB0J79jvt6Z+fwoNnHKz+DJ5qeZJuEvJobXWuNvcNYosOZ
         QKUN6EjJIn6sv98RiAa+EV7Jauh2H2+1NsClQvCCwNttX0nqmyGIQ4pnLIXDk/gwkPo4
         KBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771895766; x=1772500566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyTNmHcTbqte4mfYZdJqgeiDYGxy4Pb6et+1aAN/vEo=;
        b=cakikUX7ckV0xBsW+2ZCaMVRgD09f0SIP5McQUFX7/EAFg1Da0WGchR2b0hL++BML2
         dDe1JscVCrKtNCQRf+euvPURVtT6dDZecQrnawp7CDJfzWftBBULJYU7pEFMXOSni8JN
         dLDJ5rM4sjluqb8l/xcJHL6HY4CRPdF5E2Gj7+mAyrDrP2REkVStaEsZSbcqnlNiBDSO
         8wH77oSvUKsg7+tOh7/o15F9G2CGhvID6GEbrOZOLuzurQpU2fyTlCfTZCtM0M2yxP5o
         0HU2/qrFOpel7tR7WB8fwXbdA2UodGsWYiSFYvVZEtRbS17tDjyQCd05UswIynNP2kaO
         JqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDPt+GT8KzfSRPO8iYiTP26M2QqRzaH0P0t77hG8SDb/OW6zPlg32zGOafSTgZWfBnr58ZuqNl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx13/OizEjavdPXmODgZf1QBcUKSx/ocouUDfrnX/A63ADo5jgQ
	xbsfKN/3AMQQh3zbihnCGRNwu2jTnhwl9+8xlr6FJvk+t9xr4j5UWZ8iJH7VdDC19Q==
X-Gm-Gg: AZuq6aLqP4SyvfbhGoEdXrJVJCfN0xJdVlEDLdb1twGR7DT83LwMLr+3NH9BFwIpM0w
	B553+k0CsW/UZot1PEP3LvjQQ5aS7cpYbmNaAozCgwKvavz9d76OxW+yYffwwQ+VcME9XHhL65t
	CTL0aSxwZkBTcluy6CIWVtmw5oi/4ppym3rgLBPj3UOju63eZT63goRDUOFFyWgQV3X0x7aorgD
	hQ6+CVpgSp95PtOivMVM7xb/YKJfUPfjW2qvCJ/mfgS+DkQt4L/jaWygQrEqdScxzJiv5C0y2HS
	1T2GDKm0OKmkH/olz2S4XWWzqacRhdzuMBZFy8dwgVJUAzT9C1rX7i0l25z/URCT9tMxk5mgOid
	FhIBVZ06SWrvZtvF/i+S+dGoF35M8BdS74FYl1ab7KZ3+1IGkWJbWuradpord+APkgLEn4VtB25
	k4ds5yybkN+iAwC/4Sq1/Jdb3yYIxKlf5RHmBwWd5VEW3F7zPhr2Gj0p9h5D7da0o=
X-Received: by 2002:a17:907:d8b:b0:b87:1c20:7c63 with SMTP id a640c23a62f3a-b90819bfa47mr720467266b.20.1771895765741;
        Mon, 23 Feb 2026 17:16:05 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084e4bf5dsm379639166b.32.2026.02.23.17.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:16:04 -0800 (PST)
Date: Tue, 24 Feb 2026 01:16:01 +0000
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
Message-ID: <aZz70R4zeFajNUls@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14179-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mattbobrowski@google.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvz.org:email]
X-Rspamd-Queue-Id: 54B481806FA
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
> +
> +__weak noinline int bpf_lsm_namespace_install(struct nsset *nsset,
> +					  struct ns_common *ns)
> +{
> +	return 0;
> +}
> +
> +__bpf_hook_end();

Is the usage of __bpf_hook_start()/__bpf_hook_end() strictly necessary
here? If so, why is that? My understanding was that they're only
needed in situations where public function prototypes don't exist
(e.g., BPF kfuncs).

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

