Return-Path: <cgroups+bounces-14470-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD3fFkV6oWkUtgQAu9opvQ
	(envelope-from <cgroups+bounces-14470-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 12:04:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7691B6557
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 12:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EEC730351F5
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 11:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5083E9F71;
	Fri, 27 Feb 2026 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIIhOIKC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4C371047;
	Fri, 27 Feb 2026 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772190271; cv=none; b=ZpaxaG0xGD9Q6WuSJsnIfZyONUa0Lk1eTh3CJiGt4+Bpspwu4YaL23YRKbFWgfx9vY3aZZE1ORZaRANYDKZVIsSHB/xvziy3H4HNkBGBfC9XSP/YNA3c6+E1+E1qfA7lIGRkSfsPKCZox+wko1i3EIVoyjkwFnVkpBLWLMbqJm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772190271; c=relaxed/simple;
	bh=Byf2OUrLc18kb4SOmwJFYE8o7cke1QxrybWScMhF4As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMh3lZa3vvgoPCGP8JGnDkR4LGK7mRB/OpECZPdtR+fkh3rOZfnArbuLvgEN9hlo6PhXZ5Rv2+OszIlVJRWFa5s3mw9cbjEflJKRnMaBByOlqyOxUXmpein0E4tgyJyN2SWnnxoAhMyPmUg0v24SDz+a89DL0Y5EXsrzj2A8v+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIIhOIKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C8CC116C6;
	Fri, 27 Feb 2026 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772190271;
	bh=Byf2OUrLc18kb4SOmwJFYE8o7cke1QxrybWScMhF4As=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIIhOIKCUvACE6/u+Y1uZ+QLjncqIzwnEeJznVBXDJde1S6nDh4g/pSEKOwNTSPLh
	 bJDIEBvkd95wtPbkMgy+dOjkMPNTSvA4ElDW2zGuHmKkNeeqDEM3as3jhH8egEPrAU
	 F1iT3bKjDLRs/+fL2mcf9njgKPYp2ub6L7YeoDgYU4w7Ie2JESvJysEtC2bW6Bat/0
	 RDNCzY9gHbnA5x4uNa6wH5YyYLCNArKEHuRPqhnB6ZxJU04CPKygT4MdXRN5/e7lJL
	 Vt//KxhoJDM0YAx/A8Mjvm2kr1bPBelNmwuLimlTeOr4N+0chbvr2VjyjB601cNQy+
	 qDr1bxOnZ0H2A==
Date: Fri, 27 Feb 2026 12:04:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Djalal Harouni <tixxdz@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 1/4] ns: add bpf hooks
Message-ID: <20260227-insolvent-zersplittern-09d53ba9a39b@brauner>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
 <6f4af118-ecb1-422e-a8db-8e6f50d6d988@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f4af118-ecb1-422e-a8db-8e6f50d6d988@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14470-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF7691B6557
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 01:44:23PM +0100, Djalal Harouni wrote:
> On 2/20/26 01:38, Christian Brauner wrote:
> > Add the three namespace lifecycle hooks and make them available to bpf
> > lsm program types. This allows bpf to supervise namespace creation. I'm
> > in the process of adding various "universal truth" bpf programs to
> > systemd that will make use of this. This e.g., allows to lock in a
> > program into a given set of namespaces.
> 
> Thank you Christian, so if this feature is added we will also
> use it.
> 
> The commit log says lock in a given set of namespaces where I see
> only setns path am I right? would it make sense to also have the

Yes.

> check around some callers of create_new_namespaces() where
> appropriate befor nsproxy switch if we don't want to go deep, but
> allow a bit of control or easy checks around
> CLONE_NEWNS/mount/pivot_root fs combinations?

Yes, I have planned that but we will massage that codepath quite a bit
this cycle to deal with some races so I'd rather push this out for this
reason and also...

... I need to think about how exactly we should hook into that. Probably
when we already have assembled the new namespace set but then I want to
pass it to the hook in a way that I can guarantee KF_TRUSTED_ARGS so
callers can use the macros I have to cast from struct ns_common to
actual namespace type.

We will need additional per-ns type hooks in the future as well. Like,
One would very likely want to supervise writes of idmappings to a userns
and so we need to add hooks for that into /proc/<pid>/{g,u}id_map as
well... and setgroups now come to think of it.

An fwiw, I'm replacing pivot_root() this cycle and I expect userspace to
fade it out eventually. It's an insane system call that holds tasklist
lock to walk _all task_ on the system each time you switch the
container's rootfs just to mess with the pwd and root. That creates all
kinds of races and no container setup actually needs to do the pwd/root
replacement.

So it's really unneeded unless you do weird stuff like switching out the
rootfs in init_mnt_ns post early boot. Which is insane and can't work
for a lot of other reasons and the pwd/root rewrite doesn't solve
pinning via fds anyway so really that all needs to be Michael Myers'ed.

Next release MOVE_MOUNT_BENEATH will take over that job by making it
work with locked mounts and the rootfs.

