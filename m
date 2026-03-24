Return-Path: <cgroups+bounces-15015-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDSSItMgwmnHZgQAu9opvQ
	(envelope-from <cgroups+bounces-15015-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 06:27:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2443023BB
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 06:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F9DB3037455
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 05:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EAE2DCC04;
	Tue, 24 Mar 2026 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5I5O1ep"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864E028D8D1
	for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 05:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774330060; cv=none; b=cBVlNJf9Ku7ssc8UAHYRlQdAclTDTn2bu9D5y9fA4j4rBBa64D9ZuCJSmK/vba8ZL9oKndGuvukWePwo6dS8aFVf32x4nmMR26lJ1+yyP4iOmaWY9xPHylmppf/QT8riT3zNiuOxMaF3u6my/or1mAQ/ktDhHXY84vdnPwrxbWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774330060; c=relaxed/simple;
	bh=k9xXt2aJzUPiqvUhimxBVZN49fbykRnjPG0sd1v/0U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddZrvKF+7fseL1SFFQ8vgHzyBrGxMqJJaHi/CMIBCUAsofXYeyuFbZRXh/YvCoI/zPuj3jVHry3Bhh7O974l2RbzSw6XPb/eRkvzab/0iXAo3ru4v7qkuL/MEc289JpMfHEHXRpySZqpkOeGYCqP0h3Q5tZ/Z2m9z5InUVIZWGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5I5O1ep; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8d7f22d405so130904066b.0
        for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 22:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774330057; x=1774934857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jiqRu/0YnxP0Ivlp2p8FBB56aP3f+r4HN/z/TyoIUYU=;
        b=P5I5O1epz1REhqe3wkaraxZCMUzEaduOofdhWKQf/e48d4bM+iINzpqWzG0c+jNy66
         BsKxc/HLw1tpVZkXmdb9X/K54Q0WovpJaTzG+si0Ac4MkT3F+to/JGqABFwkRO7n4Roo
         Y3gYhBcGz8Zvj9XXHtnh9zB+B8rw1T0r7E8Zu71UqCBbgkG7QyoTdg9nv3nLfbahXnP7
         CqDXNX5qJAgbuJLprF3O4t2JvPPgY4J3A4pgaqv6bP7OycEMoq1snYmHCCdRZ3WCrrmL
         YiKJyAcqNKsa9MxeIT5VRqafaQ79xniRuFWF4+q7VoVEM/NRFZ7je2pGs+9JNF5KzNLO
         K8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774330057; x=1774934857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiqRu/0YnxP0Ivlp2p8FBB56aP3f+r4HN/z/TyoIUYU=;
        b=dNw3YCUcKeSQtbEsRlLIEBsF/0lRWvuohzSDN2K6VArlAVzmL4MXe7Cw2lzUldvguU
         lYUAyNdTX/8qRJase+OV/Ew3HIE8DrJeUBvsY3OykC/R+8XF5KaRoud2R4FeHeaoV1kA
         gXqrj8wJfa/ec1+OICzR57einV+EM2jqdEvGJyFXLfL5o4XWYLmMB9Kg+iXNFlDFYszF
         pTRDqLtsaocxoBwQxe4JYtrI8U0mB84LbThwDscez2/2A+gxcU4SD9lqvyScuBCy0uRY
         C68vxCTIVr3kTi6LeyxKtsO9EGO8KMRaFUJ23pHFEO6C5XMyBAwvRcTOWg3Ml/pOi/Ek
         3evA==
X-Forwarded-Encrypted: i=1; AJvYcCX0kDVQETyP6rBnL8bbyhpRaN/Kd4BvgYi1Fb9hqxd5tG7JQagx5XVFz0FdOlOZhUTBi2bfVah2@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYQaR0FY7YaPN2idL4O5+EOUwSa+MHtqfoLhWK+H2CqzzwZuS
	8BF7OJsLV4jDLOnh9eTwvnxms4yfuNKMjqKRFHt708T/JD8Ylht1QcFTlRFV3Xb1VQ==
X-Gm-Gg: ATEYQzw2ifpLax2qxMG+b8uKr7I1gsZLDCnHo7QI4Yrvz3+G9r5CvmQ/PhLDzBJ1q1B
	59PAFSahdKu2WHu855MT9hJDb5u+3FESsdvQD1ULEKBbKmVrXHfBWVehM/L9EES55Fw3np6I1pt
	vnkllxlnqoR3Qk/xPmT6R4m559YE+/jwVsFWs7Vsix6MoSDHbwaWgZZ4nF1RhRjr/UD0uJrbhtu
	oU9QJTgJuTLFV3QeJj5XH3gW+Zu0zqTRvtPPVBH5kU4sAYKqn56cUgF6VCoxeFwTPY/PJE34gW7
	EY0jAE/Ji5JVS2Eq6azotYX47Qyvqk/EcnRoRbZr1PbkOLazMe+r4PapSOy3drAXp9IWenlpQ/T
	LxPom+HNYYoX1UjWPSpIqZMmtLN+jBkNkobKcTxV6trb7dmblD7AmMjRZSvUqKd4yND0qxmF058
	ckjjM7nFVBHCRbi4uSjMxkdFWVw1i0LWCtFt1Uxugg93ZGNnCEWYimwgulF8lKGTA=
X-Received: by 2002:a17:906:782:b0:b95:2b77:75b6 with SMTP id a640c23a62f3a-b982f26ed28mr772701566b.19.1774330056535;
        Mon, 23 Mar 2026 22:27:36 -0700 (PDT)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f8c177sm592296266b.15.2026.03.23.22.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:27:35 -0700 (PDT)
Date: Tue, 24 Mar 2026 05:27:32 +0000
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
Message-ID: <acIgxNWe4Ev7lsj0@google.com>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
 <aZ2pDzhDFpFMjgb1@google.com>
 <20260227-krass-abzug-a2e42720db80@brauner>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-krass-abzug-a2e42720db80@brauner>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15015-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mattbobrowski@google.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E2443023BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Feb 27, 2026 at 03:33:21PM +0100, Christian Brauner wrote:
> On Tue, Feb 24, 2026 at 01:35:11PM +0000, Matt Bobrowski wrote:
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
> > 
> > I'm wondering how you foresee this hook functioning in a scenario
> > where the BPF LSM program is attached to this new hook point, although
> > with its attachment type being set to BPF_LSM_CGROUP instead of
> > BPF_LSM_MAC? You probably wouldn't want to utilize something like
> > BPF_LSM_CGROUP for your specific use case, but as things stand
> > currently I don't believe there's anyhthing preventing you from using
> > BPF_LSM_CGROUP with a hook like bpf_lsm_namespace_free().
> 
> Oh, I very much would like this to be attachable to cgroups.
> 
> > Notably, the BPF_LSM_CGROUP infrastructure is designed to execute BPF
> > programs based on the cgroup of the currently executing task. There
> > could be some surprises if the bpf_lsm_namespace_free() hook were to
> > ever be called from a context (e.g, kworker) other than the one
> > specified whilst attaching the BPF LSM program with type
> > BPF_LSM_CGROUP.
> 
> But isn't this then a generic problem? What about:
> 
> # RCU callbacks
> security_cred_free
> security_task_free
> security_inode_free_security_rcu
> security_bpf_prog_free
> security_xfrm_policy_free_security
> security_msg_queue_free_security
> security_shm_free_security
> security_sem_free_security
> security_audit_rule_free
> security_bdev_free_security
> security_sk_free_security
> 
> # Workqueues
> security_bpf_map_free
> security_bpf_token_free
> security_sb_free_security
> security_file_free_security
> security_file_release
> security_xfrm_state_free_security
> 
> ignoring sofirq/hardirq for now.

I'd need to take a another deep look, but yeah, from what I can tell
this is a broader general issue for BPF LSM programs which happen to
also make use of the BPF_LSM_CGROUP attachment type.

> So the only real problem I can see is that someone wants to do something
> from a *_free() hook that isn't actually freeing but actual policy based
> on the cgroup of @current? I find that hard to believe tbh.
> Fwiw, bpf_lsm_namespace_free() is classified as untrusted because at
> that point the outer namespace might already be blown away
> partially.  Effectively alloc() and free() hooks are mostly
> notification mechanisms of creation/destructions. If you want to do
> actual policy you might have to defer it until an actual operation
> is done.

