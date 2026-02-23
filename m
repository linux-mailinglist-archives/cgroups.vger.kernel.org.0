Return-Path: <cgroups+bounces-14143-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAI2B4hMnGnYDQQAu9opvQ
	(envelope-from <cgroups+bounces-14143-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 13:48:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4711766C4
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 13:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA00F30379E9
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 12:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F2736604D;
	Mon, 23 Feb 2026 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZkgpyZJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E6365A01
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850689; cv=none; b=t9fsjvgpBkiokO0Wb/YcYlaTq8/P3fLgWL/mW0/ryfw8x43oin7nq2FGg268BQzv6Mwlv4EJS6MTz3KNJj4GwLjqcgw3sJAchpjafw4sVMNSeKwzNr+4IgSXTqdDS+K2yHPHpzEuLlkkjB9CichWGP3hExvrFoXQ/5nSZ+nXRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850689; c=relaxed/simple;
	bh=M68f3APN5bd7LHloA6NrKBqIULn49u+ujIMSnSth66g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6rgzjwX0ziqqPgeP+SO9huv6WUCIirE04m2AqikSUgCFy7lXt0pD8OB1nnQE01WIa1o6+nWWjgVlG4adrwa+kEOnxuGxcFQkj+6R2cWqOGNOLzwK9s3zUxTJBOXIqGiiFs8L27vanVPEIFDMe8kD1iw2y4IQt6zlrw+Wb3IuiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZkgpyZJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48375f10628so26977325e9.1
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 04:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771850686; x=1772455486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnW1Wqd58lECj55tVKLq7KbjiXWb8oIkcZq5dzctHUw=;
        b=lZkgpyZJMyM09+sAtaO3V0UzXHQP7CQNT2IjG9sVc0wdU3F2kGV3pfKFY9HSkqdsgi
         C+MemvkbIzd2+99eyd3Bv8rvgpHGilq6mrKLLATwQ960y/BvCvErppPryVvqOHXKgyJR
         sj0G+g/4vyM/EmCNhlqe4W/3KY3QnlxsH4omkH2nxdrrXZbDMa60It4wZC2j0tyHRLaU
         s70Yve3MKnM5umkzfIlPaxV5utVf7L+e8Kw7/iQF9XwgXyQW8+KCgb/HZwkHXnrjV7sq
         hT8APpHXZW49WjW1a4ZEWTMRHfoThs//HarOUfgFeSQE1KrVVuqtFXCTb1s0geIovADD
         oJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771850686; x=1772455486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnW1Wqd58lECj55tVKLq7KbjiXWb8oIkcZq5dzctHUw=;
        b=M5ZuHVfZtEMA9luPhuAiqSdQKrR5gyBIOIxXXtR6rAHaPCqvwhhyrxfsEF72AI6v5o
         u3AbbSLjxh/FHsgWnSYETqAqX1hcNTWCiCrJHmz94Oy26mxSj2H64uv7NQrXybORojee
         o29XJKOgtv6j0hPwo8AtBZVy7Ys38pXfsx4pg8QusjAkoOjYQwYC2985hv0nSK4370Ay
         TtbWDFL5quafqWSMBpDtByL3SEfY+FZ1Y9je4q6R+eFX7Sp6Re1NFfS1hVjP4oy5Qr5F
         uGg/GhPXNOu9n9l3AO7XVcBM/EeUosR96SfzP738O6uxTkW+cWnzqdQ1HJ+DwdFOjFhw
         4n5w==
X-Forwarded-Encrypted: i=1; AJvYcCU5/xjo12fvMNEP6ZmES4VOCWPMTRD9FeOFxzOYdbs6CdKiLDSPlpbGxNBBONnlSzPlliDTHN/s@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwq08tKjMA1bfvHiPQBexNvNaAfGQRpfd1s+iNLBjoNffaURA6
	FEiIDp77U5OnRS6h6SgEyLV5SJn84d+KzQDgeVRcO3NJhGfGklR4W05N
X-Gm-Gg: AZuq6aLD1j0Ojh7+12GmPPNELNpq1aF8eMRJqlFqfH1lF1oDXyAc4AUdB2qZicKyUTR
	77hzZVjLN0KRVDw8wWpqtF7fG0Fjc6VeU4uxzxv4GYdyGSFOYsnFP0nizaMUWet9Y0wPs9QOLJC
	7g7UJJVOdbiCL4A9QY4/7nXs6R7Fl8qBeIrfq7bEHd4ytvgWfA44tQYfSGlZvGeuuTqnvyOyRGY
	RKyVLWGYAes6aWbm0Dq3FX9dlKj4bXUkrAAnirgXqUS3YiasDQQ6DH5sRCMqpOLYd/ROfkgPHZW
	jl1MSg3aTEWx7UpEuw4n2i5NLfcsX5JUGv6RUJImnAGFSh428O8T1ZJ84qCL+L9MH7RrJw6O1+S
	kuYZXB3jAMbnxiwgruExck5mdpEZhS/aMdJPlYzYE2MZXD4XlMT88dGOlSCburDYfeG4ktbAMOq
	lBcgVrOq+jkCAfrundXzdDD8IPjNZNwvdfojylewfOa6tEnw==
X-Received: by 2002:a05:600c:638d:b0:480:1e40:3d2 with SMTP id 5b1f17b1804b1-483a95f5a62mr129387105e9.29.1771850685905;
        Mon, 23 Feb 2026 04:44:45 -0800 (PST)
Received: from [10.2.0.2] ([146.70.48.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3deb73bsm83621845e9.3.2026.02.23.04.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 04:44:45 -0800 (PST)
Message-ID: <6f4af118-ecb1-422e-a8db-8e6f50d6d988@gmail.com>
Date: Mon, 23 Feb 2026 13:44:23 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] ns: add bpf hooks
To: Christian Brauner <brauner@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Lennart Poettering <lennart@poettering.net>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
Content-Language: en-US
From: Djalal Harouni <tixxdz@gmail.com>
In-Reply-To: <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14143-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tixxdz@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,openvz.org:email]
X-Rspamd-Queue-Id: CC4711766C4
X-Rspamd-Action: no action

On 2/20/26 01:38, Christian Brauner wrote:
> Add the three namespace lifecycle hooks and make them available to bpf
> lsm program types. This allows bpf to supervise namespace creation. I'm
> in the process of adding various "universal truth" bpf programs to
> systemd that will make use of this. This e.g., allows to lock in a
> program into a given set of namespaces.

Thank you Christian, so if this feature is added we will also
use it.

The commit log says lock in a given set of namespaces where I see
only setns path am I right? would it make sense to also have the
check around some callers of create_new_namespaces() where
appropriate befor nsproxy switch if we don't want to go deep, but
allow a bit of control or easy checks around
CLONE_NEWNS/mount/pivot_root fs combinations?

Or defering the combination checks to userspace makes more sense?

The other clone flags are presumably nested so safe, for userns
there is already a check, and cgroup+sb you added in the other
patch is great!

Thank you!


> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>   include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
>   kernel/bpf/bpf_lsm.c    | 25 +++++++++++++++++++++++++
>   kernel/nscommon.c       |  9 ++++++++-
>   kernel/nsproxy.c        |  7 +++++++
>   4 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 643809cc78c3..5ae438fdf567 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -12,6 +12,9 @@
>   #include <linux/bpf_verifier.h>
>   #include <linux/lsm_hooks.h>
>   
> +struct ns_common;
> +struct nsset;
> +
>   #ifdef CONFIG_BPF_LSM
>   
>   #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> @@ -48,6 +51,11 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
>   
>   int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>   			     struct bpf_retval_range *range);
> +
> +int bpf_lsm_namespace_alloc(struct ns_common *ns);
> +void bpf_lsm_namespace_free(struct ns_common *ns);
> +int bpf_lsm_namespace_install(struct nsset *nsset, struct ns_common *ns);
> +
>   int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
>   				const struct bpf_dynptr *value_p, int flags);
>   int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
> @@ -104,6 +112,19 @@ static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
>   {
>   	return false;
>   }
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
>   #endif /* CONFIG_BPF_LSM */
>   
>   #endif /* _LINUX_BPF_LSM_H */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 0c4a0c8e6f70..f6378db46220 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -30,10 +30,32 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
>   #include <linux/lsm_hook_defs.h>
>   #undef LSM_HOOK
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
> +
>   #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
>   BTF_SET_START(bpf_lsm_hooks)
>   #include <linux/lsm_hook_defs.h>
>   #undef LSM_HOOK
> +BTF_ID(func, bpf_lsm_namespace_alloc)
> +BTF_ID(func, bpf_lsm_namespace_free)
> +BTF_ID(func, bpf_lsm_namespace_install)
>   BTF_SET_END(bpf_lsm_hooks)
>   
>   BTF_SET_START(bpf_lsm_disabled_hooks)
> @@ -383,6 +405,8 @@ BTF_ID(func, bpf_lsm_task_prctl)
>   BTF_ID(func, bpf_lsm_task_setscheduler)
>   BTF_ID(func, bpf_lsm_task_to_inode)
>   BTF_ID(func, bpf_lsm_userns_create)
> +BTF_ID(func, bpf_lsm_namespace_alloc)
> +BTF_ID(func, bpf_lsm_namespace_install)
>   BTF_SET_END(sleepable_lsm_hooks)
>   
>   BTF_SET_START(untrusted_lsm_hooks)
> @@ -395,6 +419,7 @@ BTF_ID(func, bpf_lsm_sk_alloc_security)
>   BTF_ID(func, bpf_lsm_sk_free_security)
>   #endif /* CONFIG_SECURITY_NETWORK */
>   BTF_ID(func, bpf_lsm_task_free)
> +BTF_ID(func, bpf_lsm_namespace_free)
>   BTF_SET_END(untrusted_lsm_hooks)
>   
>   bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index bdc3c86231d3..c3613cab3d41 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
>   
> +#include <linux/bpf_lsm.h>
>   #include <linux/ns_common.h>
>   #include <linux/nstree.h>
>   #include <linux/proc_ns.h>
> @@ -77,6 +78,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>   		ret = proc_alloc_inum(&ns->inum);
>   	if (ret)
>   		return ret;
> +
>   	/*
>   	 * Tree ref starts at 0. It's incremented when namespace enters
>   	 * active use (installed in nsproxy) and decremented when all
> @@ -86,11 +88,16 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>   		atomic_set(&ns->__ns_ref_active, 1);
>   	else
>   		atomic_set(&ns->__ns_ref_active, 0);
> -	return 0;
> +
> +	ret = bpf_lsm_namespace_alloc(ns);
> +	if (ret && !inum)
> +		proc_free_inum(ns->inum);
> +	return ret;
>   }
>   
>   void __ns_common_free(struct ns_common *ns)
>   {
> +	bpf_lsm_namespace_free(ns);
>   	proc_free_inum(ns->inum);
>   }
>   
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index 259c4b4f1eeb..5742f9664dbb 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -9,6 +9,7 @@
>    *             Pavel Emelianov <xemul@openvz.org>
>    */
>   
> +#include <linux/bpf_lsm.h>
>   #include <linux/slab.h>
>   #include <linux/export.h>
>   #include <linux/nsproxy.h>
> @@ -379,6 +380,12 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
>   
>   static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
>   {
> +	int ret;
> +
> +	ret = bpf_lsm_namespace_install(nsset, ns);
> +	if (ret)
> +		return ret;
> +
>   	return ns->ops->install(nsset, ns);
>   }
>   
> 


