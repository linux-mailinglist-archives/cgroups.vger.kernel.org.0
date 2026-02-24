Return-Path: <cgroups+bounces-14177-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6v1GMZvtnGkKMQQAu9opvQ
	(envelope-from <cgroups+bounces-14177-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 01:15:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8B91802AA
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 01:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A0133011D4B
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 00:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BC52135D7;
	Tue, 24 Feb 2026 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0166C+uV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6B7199E94
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892119; cv=none; b=gn95JYRnDO3dcd9A6BniN26MUvA1BKfeHzuAi4oiWp2GXxlviVGOrOxXAXdvimgz6C0fyNKYjFsjxgwjBjcUxF3rsZe8eY/wLsZvgEXTI2119SKyQbHYyNtFyn+ehmt5rNP/TMDxZLHsy+bw/Cw1FnGJr3+thWOKED1RydeM0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892119; c=relaxed/simple;
	bh=IHU4YKQY5PYWHmXFzacaJDDgnkLmppJAryXMXDRIZlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Juogami1JmN+f/QtPH6IPpMZa5PJyaXCU3Viv6796IDLs3lH3lImubEAcG4v6p1HYgwhS/2VbG9foy3XnGUwu1gzn+hq3uLRLHt5V97SjtIEqQ7kysMh4SUihk4lPtIObXSAFYuQXz3UPaNJDj5E0hz1Q54ZDLCZnPzF/XTLFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0166C+uV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8f97c626aaso689068566b.2
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 16:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771892115; x=1772496915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0GMn/JpPA8zh6a0TMK+ntturbLwCrYg/Xc9jl0GDdTI=;
        b=0166C+uVmueaBxWX5gd2/2oYJu9cgqHbEdb4yr/Oll3oT7/4Pp5z7qsQoxNSHElrk0
         9/bQAVUjqmDkzoZ7/vuPd1NRmUwAAUUzdMtozRyc9wVB0ZjRs2OCIBE5yRNhrlufdc6H
         ck3WRdBgfo3hg6VNk1C/vLBRDDHzhhmXWRy0W9VIEFj8HPlTEBPPtIdZKCHPvSQ2BJQL
         LJxOivwfojIOSRldHyeCelhvAY7TKDCC5zN7Sjo6tZNDX5RnGTm1nmbWSSI4djoDLp6H
         DxnlVjhD1p5G4BdpfdaDB7YOnPFOIlDOvg2idH/6a8vXpDDs0WlIu1IVanGVidrBu+iV
         f3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771892115; x=1772496915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GMn/JpPA8zh6a0TMK+ntturbLwCrYg/Xc9jl0GDdTI=;
        b=GhMBS1o8awuWIx6lsh4VGI+iDqo88ebSDVu9zbXFKUrGt9tgBdPn6+jqqaCzrZxsf9
         AkG4wToUbKi8VTW+X9oo8HtzZVK2m3cgLescS9B29B7XWffoRDZUZFS7pp8GdQWKsice
         sXMou0bVphrZJY4W652HBpODflU90WWX5rwmhxAjlswvQ5Rosa4HTN625sfbKti3oImN
         7kzdAJr/zIMjrnah2Rq2Ud/OyQDTEByCzf0Hxe6nM6dy2lV1pdNWwKLlZFgNjYC+sNdA
         Slm0TvU3DXfSA7OcpaCEwQDvIVh6zD0FXFYVjJfl179l+JF9xTh5sf7lA9Pn4mHNluoF
         gcWg==
X-Forwarded-Encrypted: i=1; AJvYcCWWkKd9oSYA/4D0ECL6J+LtSmWjCRjLzmxK6DtJoY8ke9gblPcnUi8lpj09tDU86cFlyjZFuM3u@vger.kernel.org
X-Gm-Message-State: AOJu0YxMYXGjPGB8NMKJA5TvqplrABGEVn2+nJnQxyDcJ5vFoQ4Xg3LQ
	/YASdKvQncuPXcIHa3i+ClP6+cPBeK2Ls2x7fhui8pSowEh53pmsqiWwjIprE1Mo7A==
X-Gm-Gg: AZuq6aIkaagNp2s0xPHwSkedVShNwmVYiPSoGnuvhZsNOvarSr8jEtVPlo+qmOCukjP
	ixk82+6b/ueDHq7av4+bhoLNSk4UdBqfVVXEihdzJWiCgE61ndWuNq+wULEBtVybExQ+RC7bVhI
	+4Fd7EbDckfjUOoQS48c8FwT3Eq4nEX5r+I8xSsOlEOkfdZLSu1YZ+C18IsgO0QMgImfJ9m8Vk9
	R/tzNMAWXJ+Y5PalX6hCkSArNbZC1gy0pJz8UQo8VKBMV+x7QjXrIJXcY4RYTt+aupv19dho7D9
	oZEkHJ746q3fCutjGZOc7nZpu0U1PY9stfnpYZIF9ikML7RofpooL0fDGEUefX02aE2TZyAXJqx
	7iqcD3IxwmPqqQBtuUIGIoM8Ty8ieudk7bIbJP496Z6ckAWV1HqA905xbIbuWygcVvtVqlEGzKJ
	+E8xzMsMGlkTI6+PgYYVYkkbOCUaHaCqAuE6rGOqwXBjeJYJ098EH0+XeR//JMFc4=
X-Received: by 2002:a17:906:66d4:b0:b8e:fb1d:9eba with SMTP id a640c23a62f3a-b9081c1c4c5mr467058766b.54.1771892114268;
        Mon, 23 Feb 2026 16:15:14 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084e4be53sm382403166b.31.2026.02.23.16.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 16:15:13 -0800 (PST)
Date: Tue, 24 Feb 2026 00:15:10 +0000
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
Message-ID: <aZztjkqe-6U3d9DF@google.com>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
 <aZwto86A08K91w0c@google.com>
 <20260223-ewigkeit-zwieback-4350eb90a616@brauner>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-ewigkeit-zwieback-4350eb90a616@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14177-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mattbobrowski@google.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD8B91802AA
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:12:28PM +0100, Christian Brauner wrote:
> On Mon, Feb 23, 2026 at 10:36:19AM +0000, Matt Bobrowski wrote:
> > On Fri, Feb 20, 2026 at 01:38:29AM +0100, Christian Brauner wrote:
> > > Add the three namespace lifecycle hooks and make them available to bpf
> > > lsm program types. This allows bpf to supervise namespace creation. I'm
> > > in the process of adding various "universal truth" bpf programs to
> > > systemd that will make use of this. This e.g., allows to lock in a
> > > program into a given set of namespaces.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
> > >  kernel/bpf/bpf_lsm.c    | 25 +++++++++++++++++++++++++
> > >  kernel/nscommon.c       |  9 ++++++++-
> > >  kernel/nsproxy.c        |  7 +++++++
> > >  4 files changed, 61 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > > index 643809cc78c3..5ae438fdf567 100644
> > > --- a/include/linux/bpf_lsm.h
> > > +++ b/include/linux/bpf_lsm.h
> > > @@ -12,6 +12,9 @@
> > >  #include <linux/bpf_verifier.h>
> > >  #include <linux/lsm_hooks.h>
> > >  
> > > +struct ns_common;
> > > +struct nsset;
> > > +
> > >  #ifdef CONFIG_BPF_LSM
> > >  
> > >  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> > > @@ -48,6 +51,11 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
> > >  
> > >  int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
> > >  			     struct bpf_retval_range *range);
> > > +
> > > +int bpf_lsm_namespace_alloc(struct ns_common *ns);
> > > +void bpf_lsm_namespace_free(struct ns_common *ns);
> > > +int bpf_lsm_namespace_install(struct nsset *nsset, struct ns_common *ns);
> > > +
> > >  int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
> > >  				const struct bpf_dynptr *value_p, int flags);
> > >  int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
> > > @@ -104,6 +112,19 @@ static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
> > >  {
> > >  	return false;
> > >  }
> > > +
> > > +static inline int bpf_lsm_namespace_alloc(struct ns_common *ns)
> > > +{
> > > +	return 0;
> > > +}
> > > +static inline void bpf_lsm_namespace_free(struct ns_common *ns)
> > > +{
> > > +}
> > > +static inline int bpf_lsm_namespace_install(struct nsset *nsset,
> > > +					    struct ns_common *ns)
> > > +{
> > > +	return 0;
> > > +}
> > >  #endif /* CONFIG_BPF_LSM */
> > >  
> > >  #endif /* _LINUX_BPF_LSM_H */
> > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > index 0c4a0c8e6f70..f6378db46220 100644
> > > --- a/kernel/bpf/bpf_lsm.c
> > > +++ b/kernel/bpf/bpf_lsm.c
> > > @@ -30,10 +30,32 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
> > >  #include <linux/lsm_hook_defs.h>
> > >  #undef LSM_HOOK
> > >  
> > > +__bpf_hook_start();
> > > +
> > > +__weak noinline int bpf_lsm_namespace_alloc(struct ns_common *ns)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +__weak noinline void bpf_lsm_namespace_free(struct ns_common *ns)
> > > +{
> > > +}
> > > +
> > > +__weak noinline int bpf_lsm_namespace_install(struct nsset *nsset,
> > > +					  struct ns_common *ns)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +__bpf_hook_end();
> > > +
> > >  #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
> > >  BTF_SET_START(bpf_lsm_hooks)
> > >  #include <linux/lsm_hook_defs.h>
> > >  #undef LSM_HOOK
> > > +BTF_ID(func, bpf_lsm_namespace_alloc)
> > > +BTF_ID(func, bpf_lsm_namespace_free)
> > > +BTF_ID(func, bpf_lsm_namespace_install)
> > >  BTF_SET_END(bpf_lsm_hooks)
> > >  
> > >  BTF_SET_START(bpf_lsm_disabled_hooks)
> > > @@ -383,6 +405,8 @@ BTF_ID(func, bpf_lsm_task_prctl)
> > >  BTF_ID(func, bpf_lsm_task_setscheduler)
> > >  BTF_ID(func, bpf_lsm_task_to_inode)
> > >  BTF_ID(func, bpf_lsm_userns_create)
> > > +BTF_ID(func, bpf_lsm_namespace_alloc)
> > > +BTF_ID(func, bpf_lsm_namespace_install)
> > >  BTF_SET_END(sleepable_lsm_hooks)
> > >  
> > >  BTF_SET_START(untrusted_lsm_hooks)
> > > @@ -395,6 +419,7 @@ BTF_ID(func, bpf_lsm_sk_alloc_security)
> > >  BTF_ID(func, bpf_lsm_sk_free_security)
> > >  #endif /* CONFIG_SECURITY_NETWORK */
> > >  BTF_ID(func, bpf_lsm_task_free)
> > > +BTF_ID(func, bpf_lsm_namespace_free)
> > >  BTF_SET_END(untrusted_lsm_hooks)
> > >  
> > >  bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> > > diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> > > index bdc3c86231d3..c3613cab3d41 100644
> > > --- a/kernel/nscommon.c
> > > +++ b/kernel/nscommon.c
> > > @@ -1,6 +1,7 @@
> > >  // SPDX-License-Identifier: GPL-2.0-only
> > >  /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
> > >  
> > > +#include <linux/bpf_lsm.h>
> > >  #include <linux/ns_common.h>
> > >  #include <linux/nstree.h>
> > >  #include <linux/proc_ns.h>
> > > @@ -77,6 +78,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
> > >  		ret = proc_alloc_inum(&ns->inum);
> > >  	if (ret)
> > >  		return ret;
> > > +
> > >  	/*
> > >  	 * Tree ref starts at 0. It's incremented when namespace enters
> > >  	 * active use (installed in nsproxy) and decremented when all
> > > @@ -86,11 +88,16 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
> > >  		atomic_set(&ns->__ns_ref_active, 1);
> > >  	else
> > >  		atomic_set(&ns->__ns_ref_active, 0);
> > > -	return 0;
> > > +
> > > +	ret = bpf_lsm_namespace_alloc(ns);
> > > +	if (ret && !inum)
> > > +		proc_free_inum(ns->inum);
> > > +	return ret;
> > >  }
> > >  
> > >  void __ns_common_free(struct ns_common *ns)
> > >  {
> > > +	bpf_lsm_namespace_free(ns);
> > >  	proc_free_inum(ns->inum);
> > >  }
> > >  
> > > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > > index 259c4b4f1eeb..5742f9664dbb 100644
> > > --- a/kernel/nsproxy.c
> > > +++ b/kernel/nsproxy.c
> > > @@ -9,6 +9,7 @@
> > >   *             Pavel Emelianov <xemul@openvz.org>
> > >   */
> > >  
> > > +#include <linux/bpf_lsm.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/export.h>
> > >  #include <linux/nsproxy.h>
> > > @@ -379,6 +380,12 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
> > >  
> > >  static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
> > >  {
> > > +	int ret;
> > > +
> > > +	ret = bpf_lsm_namespace_install(nsset, ns);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	return ns->ops->install(nsset, ns);
> > >  }
> > 
> > What's the reason for not adding these new hook points to the generic
> > set of hooks that are currently being exposed directly by the LSM
> > framework? Honestly, it seems a little odd to be providing
> > declarations/definitions for a set of new hook points which are to be
> > exclusively siloed to BPF LSM implementations only. I'd argue that
> > some other LSM implementations could very well find namespace
> > lifecycle events possibly interesting.
> 
> The LSM layer is of the opinion that adding new security hooks is only
> acceptable if an implementation for an in-tree LSM is provided alongside
> it (cf. [1]). IOW, your bpf lsm needs are not sufficient justification
> for adding new security hooks. So if you want to add security hooks that
> a bpf lsm makes use of then you need to come up with an implementation
> for another in-tree LSM.

I apologize. I didn't realize that adding these as new generic LSM
hooks points had already been proposed and discussed with the LSM
maintainers. I just wanted to make sure that we weren't
unintentionally side-stepping.

> However, a subsystem is free to add as much bpf support as it wants:
> none, some, flamethrower mode. Cgroupfs has traditionally been very bpf
> friendly. I maintain namespaces and rewrote the infra allowing me to
> manage them uniformly now. bpf literally just needs an attach point. I
> could also just add fmodret tracepoints and achieve the same result.
> 
> The same way you add bpf kfuncs to support access to functionality that
> put you way past what an in-tree use would be able do. The question is
> whether you want such capabilities to be bounded by in-tree users as
> well.
>
> Either a bpf lsm is an inextensible fixture bound to the scope of
> security_* or you allow subsystems open to it to add functionality just
> like adding a kfuncs is.

Adding these dedicated BPF LSM hooks is OK with me, especially knowing
that I have agreement from you that you'll also be maintaining their
call sites.

