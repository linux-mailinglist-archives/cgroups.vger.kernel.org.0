Return-Path: <cgroups+bounces-14473-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKICIsiroWkivgQAu9opvQ
	(envelope-from <cgroups+bounces-14473-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 15:35:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E05A1B9128
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 15:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71707309F1D2
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ACB2D8393;
	Fri, 27 Feb 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OygjcJMz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C402D7D2E;
	Fri, 27 Feb 2026 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772202806; cv=none; b=B5/owug2ljX4jSTGp0eRtkeb9NWB0pL2mY+XqDwKb7Nfpf/Y5lIlYooL0eiPgOSlj5YOVU4Pt1U6zIIcwHpLYvrMLypJc8QTvucjMsbfmZ1TvyNoGqVw1e+WvnxJYGkb0n6qAaDQ0QDcqvOADy7zDYhlphatJ9iVHRv/wfoyftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772202806; c=relaxed/simple;
	bh=wTlr065Mxrm4HC7hRwIZ4JNFSpk81XdsYFZasg3vLKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQrboA95F2erYBCKtiiZoeiuAn+g2R8IfELktfAFYY3b2R6QKTSpwcvEVeRH+ViczEzq6Q8EWTkW/6SFV71YoDC0PapWtrpFhiM9TmEz+7+lYlkyWRVsePVzdYvgTeygpVP7jcAuWdJiZyGcNrEtAkY/LNyA1o+xCwt+TusKvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OygjcJMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86EFC19423;
	Fri, 27 Feb 2026 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772202806;
	bh=wTlr065Mxrm4HC7hRwIZ4JNFSpk81XdsYFZasg3vLKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OygjcJMzTY8ovhsMsbu1MOqFaWeJnZoUJfrNVPa4foEGX9k68yazNchyMy2eFw1MI
	 S/jGYghyq/bcYk3c/iuCM8VhOPpsd2Defd38J1RT7tyCrTjSF3XjasmrmJVPOrbUak
	 sUmLluNn/WTYaBVhwi34I3XNpfd8ajAYHJSKF/MHG90/yGsmPOq8j1FclQ2NYnZ3Pl
	 mpq3qjhuBQkG2tnsTkx02c7yzP9rhetu6R63OJ+1RbVdCEnibWKswWd/VeYUQCyPYz
	 2W+9A850qwkv9Fc5+/KiQco14Eu7BSCKmFWf5k+B0lMZqjhd3+GGad9U/KopecW1wg
	 e5zWDaqxM4kbA==
Date: Fri, 27 Feb 2026 15:33:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 1/4] ns: add bpf hooks
Message-ID: <20260227-krass-abzug-a2e42720db80@brauner>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
 <aZ2pDzhDFpFMjgb1@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZ2pDzhDFpFMjgb1@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14473-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E05A1B9128
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 01:35:11PM +0000, Matt Bobrowski wrote:
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
> 
> I'm wondering how you foresee this hook functioning in a scenario
> where the BPF LSM program is attached to this new hook point, although
> with its attachment type being set to BPF_LSM_CGROUP instead of
> BPF_LSM_MAC? You probably wouldn't want to utilize something like
> BPF_LSM_CGROUP for your specific use case, but as things stand
> currently I don't believe there's anyhthing preventing you from using
> BPF_LSM_CGROUP with a hook like bpf_lsm_namespace_free().

Oh, I very much would like this to be attachable to cgroups.

> Notably, the BPF_LSM_CGROUP infrastructure is designed to execute BPF
> programs based on the cgroup of the currently executing task. There
> could be some surprises if the bpf_lsm_namespace_free() hook were to
> ever be called from a context (e.g, kworker) other than the one
> specified whilst attaching the BPF LSM program with type
> BPF_LSM_CGROUP.

But isn't this then a generic problem? What about:

# RCU callbacks
security_cred_free
security_task_free
security_inode_free_security_rcu
security_bpf_prog_free
security_xfrm_policy_free_security
security_msg_queue_free_security
security_shm_free_security
security_sem_free_security
security_audit_rule_free
security_bdev_free_security
security_sk_free_security

# Workqueues
security_bpf_map_free
security_bpf_token_free
security_sb_free_security
security_file_free_security
security_file_release
security_xfrm_state_free_security

ignoring sofirq/hardirq for now.

So the only real problem I can see is that someone wants to do something
from a *_free() hook that isn't actually freeing but actual policy based
on the cgroup of @current? I find that hard to believe tbh. Fwiw,
bpf_lsm_namespace_free() is classified as untrusted because at that
point the outer namespace might already be blown away partially.
Effectively alloc() and free() hooks are mostly notification mechanisms
of creation/destructions. If you want to do actual policy you might have
to defer it until an actual operation is done.

