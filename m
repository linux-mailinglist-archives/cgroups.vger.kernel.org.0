Return-Path: <cgroups+bounces-14494-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPNjNiFdpWlc+QUAu9opvQ
	(envelope-from <cgroups+bounces-14494-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 10:49:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 542191D5BFF
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 10:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 607943010B97
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 09:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE6338758F;
	Mon,  2 Mar 2026 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlHx7zde"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4063D1F1932;
	Mon,  2 Mar 2026 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444802; cv=none; b=B6p+db+pHjaL8+Xxau3rQPHPAgFNPrPBXv3F7OVUmclGfXrvpWWNYoHK2rhvOzlA+EQRNrcAzaQjkCFokQq6AKgJHoQIDEHnocSsFlB+vFo+Wy0c1oDgHE3H3AoFmFy+PnTZsbT4QeraEU4yKGD3cQYS+AhCj+EEDXgCGtQQQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444802; c=relaxed/simple;
	bh=8wFnx3X4NMytZXbi1Mnp6003sE19tT03Vwn1QWGE/uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q340G3OibYjNJHmRu97BhCbIj65J6Rq4DPqh72VbXkN1h3ovHdLxlI93/I83oVbkLnkuxR23XSyWC/xnHEBA4U28bO3W67Hg9JgkNOxXLYcgi42AfXn0Wek59U1bvKFrt10d1Z7/4imiMJIKGddeM7pNxt/w49ekw3/1a5mLRrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlHx7zde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423A6C19423;
	Mon,  2 Mar 2026 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772444801;
	bh=8wFnx3X4NMytZXbi1Mnp6003sE19tT03Vwn1QWGE/uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlHx7zdeQ/hBJTs6DoMfuclnuE7usfSzVkHN2qMzfRttktKjdSC6uPjYMwVduF9Xb
	 gemQV9HWAfbzfCOwpxYx5urx2++PFZJB1kmrPqWVPTcWl9aVLQI/6CMdyQjdDAvmRz
	 8X4u2jBKOaNsfttvy5Sd4mh8J8xRW5yTlT5MR6PnbpU9cRv0qNhDBh4NLbU8XereEu
	 5HUXp4PftYXfpIX6ZnhFYH52qV+LFwb+dq3E9tKcz7wf1iKEgh+GzC7V2TA7c9EmdR
	 P7jFLmAC5aszbn1J0/4Y7Ibh8invYfciKq3qp8Sbr7vIqFP9vk949Mkv5pWjVUUFd4
	 +HaULYgIpdVjw==
Date: Mon, 2 Mar 2026 10:46:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 1/4] ns: add bpf hooks
Message-ID: <20260302-begehbar-kanister-9801d1198abf@brauner>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
 <CAPhsuW63sEvK50ELaxo4LxjCS-2RdfxDzuMYhW59PDUHfF0-iQ@mail.gmail.com>
 <20260227-nullnummer-eisdiele-08db4c8fe99e@brauner>
 <CAPhsuW5GCK02OXvFeNQVW-QoX9eJ7CyiT=oEDsCYyht-Hve3sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5GCK02OXvFeNQVW-QoX9eJ7CyiT=oEDsCYyht-Hve3sQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-14494-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.428];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 542191D5BFF
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 08:38:48AM -0800, Song Liu wrote:
> On Fri, Feb 27, 2026 at 2:28 AM Christian Brauner <brauner@kernel.org> wrote:
> [...]
> > >
> > > If we change the hook as
> > >
> > >    bpf_lsm_namespace_alloc(ns, inum);
> > >
> > > We can move it to the beginning of __ns_common_init().
> > > This change allows blocking __ns_common_init() before
> > > it makes any changes to the ns. Is this a better approach?
> >
> > I don't think it matters tbh. We have no control when exactly
> > __ns_common_init() is called. That's up to the containing namespace. We
> > can't rely on the namespace to have been correctly set up at this time.
> > My main goal was to have struct ns_common to be fully initialized
> > already so that direct access to it's field already makes sense.
> 
> Good point on having ns_common initialized. Besides inum, we
> should also pass ns_type and ops into the hook.

But why? The struct ns_common is already fully initialized when it is
passed to bpf_lsm_namespace_alloc() including ops, inum, ns_type etc.

> 
> OTOH, shall we have the hook before proc_alloc_inum()? With
> this change, the hook can block the operation before it causes
> any contention on proc_inum_ida. IOW, how about we have:

I think that contention is meaningless and I'd rather have struct
ns_common fully set up so that all fields can be accessed.

> 
> @@ -71,6 +71,10 @@ int __ns_common_init(struct ns_common *ns, u32
> ns_type, const struct proc_ns_ope
>         ns_debug(ns, ops);
>  #endif
> 
> +       ret = bpf_lsm_namespace_alloc(ns, inum);
> +       if (ret)
> +               return ret;
> +
>         if (inum)
>                 ns->inum = inum;
>         else
> 
> With this change, ns is already initialized, except the inum.
> 
> WDYT?
> 
> Thanks,
> Song
> 
> > The containing namespace my already have to rollback a bunch of stuff
> > anyway.

