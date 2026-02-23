Return-Path: <cgroups+bounces-14141-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SlcNBCw2nGnsBQQAu9opvQ
	(envelope-from <cgroups+bounces-14141-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 12:12:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1F317552D
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 12:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 376BD3034295
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 11:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E135CB8B;
	Mon, 23 Feb 2026 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkWo2utT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AEA34CFA8;
	Mon, 23 Feb 2026 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845154; cv=none; b=B8ntaEkoxBTTKJl/UTwR0jgTn/qpbYNE4eeKkjVV2h/d+B6W3Fa5l8P8p6Dc7DlEYOpzcQZfNe7dZ1/JgWrB9zAA+cLzHLCOlHP/XUxtQqJS8ug65s77vYUtcN1NJPpQ9IOzww1ichCtE6/nEGvec6cPy/rNSBgB1dTGPBi290c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845154; c=relaxed/simple;
	bh=droTaAJnqZnfkdxTwCljX8/Yo6lqh/OpKnBUudN9Q98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dU2ARfTq0IbSkQL5VIZ7Z6X7lq/d3mTtgZx8BOORsLnU49WdF/vTZHVX24DfmT4hng2ABRYFPYxmVAICpt9K8E8yNM6gkUxHMy5WdoVE9XJ8ajd/2ZZNHzJxqxOcLjDAUfr7rp9h09R3+Mk4CHejq9kmYhu7xz50zCIpN2mAd10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkWo2utT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1DDC116C6;
	Mon, 23 Feb 2026 11:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771845153;
	bh=droTaAJnqZnfkdxTwCljX8/Yo6lqh/OpKnBUudN9Q98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QkWo2utTc5damWK/LgfJE9r2W2MsCt+mn3EaLii8Ok0k86JsxeXyxLwnpP0LTeX2V
	 4NDE/YPkIEw8zhesZjb2DBfg4sxjiciaEwA6rHYK530tJQ8uhkqVUNrZWt+mSLgZjU
	 +hjEE1IibiDnvr5BMpihOYUYIgAIdVDUP2yi77X/cyvgTFKj36ee27svDdSYc+M4ZD
	 kKKb6LHssarv9wpn6Ln35jI9vTGGHl3DSS5nCnUPdwNzKb11L+Us+lqC2KrULMZZ4z
	 lhJCxqovy4Ws0Mxxch3Bzt9PAHfnlBlfRpgvn7uYyiE0ORdnWEJLwUX6iSQs+ZoCUk
	 qn79nTCXtbrYA==
Date: Mon, 23 Feb 2026 12:12:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 1/4] ns: add bpf hooks
Message-ID: <20260223-ewigkeit-zwieback-4350eb90a616@brauner>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
 <aZwto86A08K91w0c@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZwto86A08K91w0c@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14141-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvz.org:email]
X-Rspamd-Queue-Id: 9C1F317552D
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:36:19AM +0000, Matt Bobrowski wrote:
> On Fri, Feb 20, 2026 at 01:38:29AM +0100, Christian Brauner wrote:
> > Add the three namespace lifecycle hooks and make them available to bpf
> > lsm program types. This allows bpf to supervise namespace creation. I'm
> > in the process of adding various "universal truth" bpf programs to
> > systemd that will make use of this. This e.g., allows to lock in a
> > program into a given set of namespaces.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
> >  kernel/bpf/bpf_lsm.c    | 25 +++++++++++++++++++++++++
> >  kernel/nscommon.c       |  9 ++++++++-
> >  kernel/nsproxy.c        |  7 +++++++
> >  4 files changed, 61 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > index 643809cc78c3..5ae438fdf567 100644
> > --- a/include/linux/bpf_lsm.h
> > +++ b/include/linux/bpf_lsm.h
> > @@ -12,6 +12,9 @@
> >  #include <linux/bpf_verifier.h>
> >  #include <linux/lsm_hooks.h>
> >  
> > +struct ns_common;
> > +struct nsset;
> > +
> >  #ifdef CONFIG_BPF_LSM
> >  
> >  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> > @@ -48,6 +51,11 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
> >  
> >  int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
> >  			     struct bpf_retval_range *range);
> > +
> > +int bpf_lsm_namespace_alloc(struct ns_common *ns);
> > +void bpf_lsm_namespace_free(struct ns_common *ns);
> > +int bpf_lsm_namespace_install(struct nsset *nsset, struct ns_common *ns);
> > +
> >  int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
> >  				const struct bpf_dynptr *value_p, int flags);
> >  int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
> > @@ -104,6 +112,19 @@ static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
> >  {
> >  	return false;
> >  }
> > +
> > +static inline int bpf_lsm_namespace_alloc(struct ns_common *ns)
> > +{
> > +	return 0;
> > +}
> > +static inline void bpf_lsm_namespace_free(struct ns_common *ns)
> > +{
> > +}
> > +static inline int bpf_lsm_namespace_install(struct nsset *nsset,
> > +					    struct ns_common *ns)
> > +{
> > +	return 0;
> > +}
> >  #endif /* CONFIG_BPF_LSM */
> >  
> >  #endif /* _LINUX_BPF_LSM_H */
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 0c4a0c8e6f70..f6378db46220 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -30,10 +30,32 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
> >  #include <linux/lsm_hook_defs.h>
> >  #undef LSM_HOOK
> >  
> > +__bpf_hook_start();
> > +
> > +__weak noinline int bpf_lsm_namespace_alloc(struct ns_common *ns)
> > +{
> > +	return 0;
> > +}
> > +
> > +__weak noinline void bpf_lsm_namespace_free(struct ns_common *ns)
> > +{
> > +}
> > +
> > +__weak noinline int bpf_lsm_namespace_install(struct nsset *nsset,
> > +					  struct ns_common *ns)
> > +{
> > +	return 0;
> > +}
> > +
> > +__bpf_hook_end();
> > +
> >  #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
> >  BTF_SET_START(bpf_lsm_hooks)
> >  #include <linux/lsm_hook_defs.h>
> >  #undef LSM_HOOK
> > +BTF_ID(func, bpf_lsm_namespace_alloc)
> > +BTF_ID(func, bpf_lsm_namespace_free)
> > +BTF_ID(func, bpf_lsm_namespace_install)
> >  BTF_SET_END(bpf_lsm_hooks)
> >  
> >  BTF_SET_START(bpf_lsm_disabled_hooks)
> > @@ -383,6 +405,8 @@ BTF_ID(func, bpf_lsm_task_prctl)
> >  BTF_ID(func, bpf_lsm_task_setscheduler)
> >  BTF_ID(func, bpf_lsm_task_to_inode)
> >  BTF_ID(func, bpf_lsm_userns_create)
> > +BTF_ID(func, bpf_lsm_namespace_alloc)
> > +BTF_ID(func, bpf_lsm_namespace_install)
> >  BTF_SET_END(sleepable_lsm_hooks)
> >  
> >  BTF_SET_START(untrusted_lsm_hooks)
> > @@ -395,6 +419,7 @@ BTF_ID(func, bpf_lsm_sk_alloc_security)
> >  BTF_ID(func, bpf_lsm_sk_free_security)
> >  #endif /* CONFIG_SECURITY_NETWORK */
> >  BTF_ID(func, bpf_lsm_task_free)
> > +BTF_ID(func, bpf_lsm_namespace_free)
> >  BTF_SET_END(untrusted_lsm_hooks)
> >  
> >  bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> > diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> > index bdc3c86231d3..c3613cab3d41 100644
> > --- a/kernel/nscommon.c
> > +++ b/kernel/nscommon.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
> >  
> > +#include <linux/bpf_lsm.h>
> >  #include <linux/ns_common.h>
> >  #include <linux/nstree.h>
> >  #include <linux/proc_ns.h>
> > @@ -77,6 +78,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
> >  		ret = proc_alloc_inum(&ns->inum);
> >  	if (ret)
> >  		return ret;
> > +
> >  	/*
> >  	 * Tree ref starts at 0. It's incremented when namespace enters
> >  	 * active use (installed in nsproxy) and decremented when all
> > @@ -86,11 +88,16 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
> >  		atomic_set(&ns->__ns_ref_active, 1);
> >  	else
> >  		atomic_set(&ns->__ns_ref_active, 0);
> > -	return 0;
> > +
> > +	ret = bpf_lsm_namespace_alloc(ns);
> > +	if (ret && !inum)
> > +		proc_free_inum(ns->inum);
> > +	return ret;
> >  }
> >  
> >  void __ns_common_free(struct ns_common *ns)
> >  {
> > +	bpf_lsm_namespace_free(ns);
> >  	proc_free_inum(ns->inum);
> >  }
> >  
> > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > index 259c4b4f1eeb..5742f9664dbb 100644
> > --- a/kernel/nsproxy.c
> > +++ b/kernel/nsproxy.c
> > @@ -9,6 +9,7 @@
> >   *             Pavel Emelianov <xemul@openvz.org>
> >   */
> >  
> > +#include <linux/bpf_lsm.h>
> >  #include <linux/slab.h>
> >  #include <linux/export.h>
> >  #include <linux/nsproxy.h>
> > @@ -379,6 +380,12 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
> >  
> >  static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
> >  {
> > +	int ret;
> > +
> > +	ret = bpf_lsm_namespace_install(nsset, ns);
> > +	if (ret)
> > +		return ret;
> > +
> >  	return ns->ops->install(nsset, ns);
> >  }
> 
> What's the reason for not adding these new hook points to the generic
> set of hooks that are currently being exposed directly by the LSM
> framework? Honestly, it seems a little odd to be providing
> declarations/definitions for a set of new hook points which are to be
> exclusively siloed to BPF LSM implementations only. I'd argue that
> some other LSM implementations could very well find namespace
> lifecycle events possibly interesting.

The LSM layer is of the opinion that adding new security hooks is only
acceptable if an implementation for an in-tree LSM is provided alongside
it (cf. [1]). IOW, your bpf lsm needs are not sufficient justification
for adding new security hooks. So if you want to add security hooks that
a bpf lsm makes use of then you need to come up with an implementation
for another in-tree LSM.

However, a subsystem is free to add as much bpf support as it wants:
none, some, flamethrower mode. Cgroupfs has traditionally been very bpf
friendly. I maintain namespaces and rewrote the infra allowing me to
manage them uniformly now. bpf literally just needs an attach point. I
could also just add fmodret tracepoints and achieve the same result.

The same way you add bpf kfuncs to support access to functionality that
put you way past what an in-tree use would be able do. The question is
whether you want such capabilities to be bounded by in-tree users as
well.

Either a bpf lsm is an inextensible fixture bound to the scope of
security_* or you allow subsystems open to it to add functionality just
like adding a kfuncs is.

[1]: https://patch.msgid.link/20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org

