Return-Path: <cgroups+bounces-16343-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CDNLSCxFmokogcAu9opvQ
	(envelope-from <cgroups+bounces-16343-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 10:53:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BA65E161B
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 10:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A50F8304358B
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28AB3E315C;
	Wed, 27 May 2026 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sF9XrJaE"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1325A3E2768;
	Wed, 27 May 2026 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871972; cv=none; b=V73Laogp+s0b/jFzzaIiw/E/Tj4Ro5QMUigwk3ytir0usa41Vivau5F9+81afdG9Kl/LAfQfEilwVsxzS6NByWSuH3yIJdmJ+hl4DfZpyBGwUz2WxpMMBHHFxI1t+rtMsVsjalKK5D2Gs76gsYTHyTsZ9lRYeptb9lI68CndHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871972; c=relaxed/simple;
	bh=0vP6dAM0qtYEDeOo7lT2iXRxIT57lFamfuJ6xdotRDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kugm2MBQJeIktBoecjw/ASngDlElxhJ21P7jpULhIZUTwaSk+5qOtrePcNqJdx6LnSsywnD+ZZTSsnVig/6YJfFVJcfaVQGui09c4/kbwOr7TDFeD4K7TbtCKbRjRYtz8uNLqUzgmGbzi414e7DvnNevJrEQObj7q8HihbKpzRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sF9XrJaE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5SrhJd8D5kdySamJgDjj4vcaR6oJNFYx6iGp8z9Ljdo=; b=sF9XrJaEIa3q2QUrVJVXpFkrkJ
	+VEb7zw04rbo+YGauRNWAGaqofL2ZmjQkNVqLfDFRE/slMRdhN7woW1SGlwXk7RrrhN8jgM5kSNcD
	U1KuBHgMP9JOihHIWcqbZXXaTi2gZJxhz4fI+OVLKxtibDYeUTB/GGm2t48P967isrtfDSNfe6Ir9
	sfT0oOmpU7rltytq+hA5xXy6cHFCk2TmwrPy3/66VFIxTJTl8EianR0qwL29d8o8aNx45atJrDI25
	DIpbgBaFSEA7wjVCBACAAgm0/ckup9yvsEF5IsmxQCgeXedwymdEntAHQW8KGIBNJB427Cunfovzi
	0wDVOKRg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS9zy-000000028Ul-0UWa;
	Wed, 27 May 2026 08:52:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7BB34300673; Wed, 27 May 2026 10:52:21 +0200 (CEST)
Date: Wed, 27 May 2026 10:52:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tsbogend@alpha.franken.de, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com, longman@redhat.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, chenridong@huaweicloud.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	omosnace@redhat.com, kees@kernel.org, neelx@suse.com, sean@ashe.io,
	chjohnst@gmail.com, steve@abita.co, mproche@gmail.com,
	nick.lange@gmail.com, cgroups@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
Message-ID: <20260527085221.GQ3126523@noisy.programming.kicks-ass.net>
References: <20260526142838.774711-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526142838.774711-1-atomlin@atomlin.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16343-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com,huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,amd.com,ashe.io,abita.co,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim]
X-Rspamd-Queue-Id: 70BA65E161B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 10:28:38AM -0400, Aaron Tomlin wrote:
> At present, the task_setscheduler LSM hook provides security modules
> with the opportunity to mediate changes to a task's scheduling policy.
> However, when invoked via sched_setaffinity(), the hook lacks
> visibility into the actual CPU affinity mask being requested.
> Consequently, BPF-based security modules are entirely blind to the
> target CPUs and cannot make granular access control decisions based on
> spatial isolation.
> 
> In modern multi-tenant and real-time environments, CPU isolation is a
> critical boundary. The inability to audit or restrict specific CPU
> pinning requests limits the effectiveness of eBPF-driven security
> policies, particularly when attempting to shield isolated or
> cryptographic cores from unprivileged or compromised tasks.
> 
> This patch expands the security_task_setscheduler() hook signature to
> include a pointer to the requested cpumask. Because this is a shared
> hook used for multiple scheduling attribute changes, call sites that do
> not modify CPU affinity are updated to safely pass NULL.
> To protect against unverified dereferences, the parameter is annotated
> with __nullable in the LSM hook definition, ensuring the BPF verifier
> mandates explicit NULL checks for attached eBPF programs.
> 
> This change updates all in-tree security modules (SELinux and Smack) to
> accommodate the new parameter mechanically, whilst providing BPF LSMs
> with the necessary context to enforce strict affinity policies.

I'm not sure I really buy the Real-Time argument here; that really feels
like a straw man. Real-Time will need to account for the shared resource
usage inherent in using a single kernel image across the CPUs, affinity
alone does not Real-Time make in any way shape or form.

And the compromised task vs crypto thing feels like it wants sandboxing,
but wasn't that what seccomp is for, rather than lsm?

So while I don't think I object very much to the patch, I do find the
whole Changelog to be utterly questionable. Which makes me very
suspicious as to wtf this is actually for.

