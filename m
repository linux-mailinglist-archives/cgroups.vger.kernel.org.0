Return-Path: <cgroups+bounces-14468-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AuxOOVxoWm6swQAu9opvQ
	(envelope-from <cgroups+bounces-14468-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 11:28:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB271B601F
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 11:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C8793037073
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F89A3EBF2F;
	Fri, 27 Feb 2026 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnN1h7rM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8DC395DB4;
	Fri, 27 Feb 2026 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188131; cv=none; b=GLfBkwx0th86eHjfphq4EdTVxFvMRUlX/2u93OnnD5qqbPegLF8WjDDz1m6vAWGFpUGOb1u2RIKlGaCEkwVnfW+ogk7NXvFr0nSJhcD3okd9EzFNXL45Z3qg+nYvUgE8WmWn/D9EvJYDQbfi8oRHYoKQvBWx49OE6m+1inRLBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188131; c=relaxed/simple;
	bh=/dKIc7p2rllISBSzFmr+GpDUadFf+dhQdPn3a5R3SfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYemovp554QCK0uv7RibpQWJDjl3Pd82Dk9dPdNCtNjKeUpOs7xQOWDPzSt+MxDfj8AH5Ho5C1jFlsBxVRvyeWPTlXNj7p4glWV86fiCwJaXxzI87wD8URKv/nCa1twh3OEAts+tB3/ScsTUIZcCpcdx9snA6Pv4Ch93xvfi9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnN1h7rM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3F5C116C6;
	Fri, 27 Feb 2026 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772188130;
	bh=/dKIc7p2rllISBSzFmr+GpDUadFf+dhQdPn3a5R3SfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnN1h7rM75DYnJ1YhbgrfUaNWpn3AMnaE7hGYWZV1XkrcFOncfo9nS0DPQaLLMwsJ
	 npDSoeBptsSlvHwWZYQWBZdt/Z+1zZxxphB+bBZrbW9TL9ZGhFopsyrEddGh6o3cOI
	 eYoRUPcQfEn4Hlx+RItqVYNucWje/ol9pwn/hdqAMbPT2SX8Ss4nEfEsN1zxgHbZK+
	 U0xFH9SxH4ms1YsPlDPtwLLFgt1g0LO4UiiK6ijdQZ5mSUxwBK1tB2D9g6MriHbw+4
	 uFOw87nA2zJ+HnN50N50zwyxjUp8K1v+URAEy0QtX59jZzI86TFrl3LknUcqm1hweF
	 siqh0lnv5JZkw==
Date: Fri, 27 Feb 2026 11:28:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 1/4] ns: add bpf hooks
Message-ID: <20260227-nullnummer-eisdiele-08db4c8fe99e@brauner>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
 <CAPhsuW63sEvK50ELaxo4LxjCS-2RdfxDzuMYhW59PDUHfF0-iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW63sEvK50ELaxo4LxjCS-2RdfxDzuMYhW59PDUHfF0-iQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14468-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CB271B601F
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 03:04:43PM -0800, Song Liu wrote:
> On Thu, Feb 19, 2026 at 4:38 PM Christian Brauner <brauner@kernel.org> wrote:
> [...]
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
> >
> > +#include <linux/bpf_lsm.h>
> >  #include <linux/ns_common.h>
> >  #include <linux/nstree.h>
> >  #include <linux/proc_ns.h>
> > @@ -77,6 +78,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
> >                 ret = proc_alloc_inum(&ns->inum);
> >         if (ret)
> >                 return ret;
> > +
> >         /*
> >          * Tree ref starts at 0. It's incremented when namespace enters
> >          * active use (installed in nsproxy) and decremented when all
> > @@ -86,11 +88,16 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
> >                 atomic_set(&ns->__ns_ref_active, 1);
> >         else
> >                 atomic_set(&ns->__ns_ref_active, 0);
> > -       return 0;
> > +
> > +       ret = bpf_lsm_namespace_alloc(ns);
> > +       if (ret && !inum)
> > +               proc_free_inum(ns->inum);
> > +       return ret;
> >  }
> 
> If we change the hook as
> 
>    bpf_lsm_namespace_alloc(ns, inum);
> 
> We can move it to the beginning of __ns_common_init().
> This change allows blocking __ns_common_init() before
> it makes any changes to the ns. Is this a better approach?

I don't think it matters tbh. We have no control when exactly
__ns_common_init() is called. That's up to the containing namespace. We
can't rely on the namespace to have been correctly set up at this time.
My main goal was to have struct ns_common to be fully initialized
already so that direct access to it's field already makes sense.

The containing namespace my already have to rollback a bunch of stuff
anyway.

