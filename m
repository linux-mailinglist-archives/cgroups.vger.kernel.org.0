Return-Path: <cgroups+bounces-14482-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCSGG+8Zoml7zQQAu9opvQ
	(envelope-from <cgroups+bounces-14482-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 23:25:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A881BEADA
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 23:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70BEF307E842
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 22:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF786453493;
	Fri, 27 Feb 2026 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRGYtVOs"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156E2882D6;
	Fri, 27 Feb 2026 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772231146; cv=none; b=cam9pXqrHIEeWpzxy+vjVuyvZ1c2PW5Wpl/mCBgeTx24Br4h5B5qPmRS1HEv8skJccmqeC/Cw3HKoQ4ya8s6gDcBS3pYwdWZW3fymt8tkH0hIfJRtJW8qrzXXDyedOKiDuqcpLKcUzf3ouPdLSzRLR9OD7Ovi2QRojS9ElRepj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772231146; c=relaxed/simple;
	bh=EDzJXC9OWyBIU0DAsYasPy6rJPMGi9FZQ8UQxq7JeFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VainnkdJwMxXW8Mq31+RcIqb9IHJ6yQmvC4xT2+vzmfM93pbzIUzQDnO1Srw7hdEDiQu4YRPADOzT/j7Ste2DSwthcxslUfLbSpVwgAz6/2T9DKh9sO24FlpvFP800DpNRypUxBFQZiyJ0Ef8T4hTnHx3RT1KorCBvXz/YfS+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRGYtVOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35858C116C6;
	Fri, 27 Feb 2026 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772231146;
	bh=EDzJXC9OWyBIU0DAsYasPy6rJPMGi9FZQ8UQxq7JeFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRGYtVOss0UKX989WQ7W7UpAwEqC+0MhDU/rpfago4LxMphBteQb83tPOq2qGsr6Z
	 6UdNZUpzJB+i/eHJc7KbOflzlktAeG7dmPPGtzW5h6sYdHvKEW3DBeNmzUds87xuEK
	 aEhm+1LKhvnhJtIeKwD+8PBn+cfpwXA37yjlO3c5nkkqTcw/l01oWweysalLeZDn/G
	 DcSEzYubXB1dX69xC3ROxciu9Ciid0YDCNdzoydMskCDc9+9F4nlo0+jvvaYhuNMN1
	 at/nK0W04bFerAhvNdlHAkUOHPqLOBVCEagtQX1uy67e5K9V2StAP3ukvvTc54lPZd
	 MN5JrxPiH2E7w==
Date: Fri, 27 Feb 2026 12:25:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 11/34] sched_ext: Enforce scheduler ownership when
 updating slice and dsq_vtime
Message-ID: <aaIZ6aeNJrZp14kh@slm.duckdns.org>
References: <20260225050109.1070059-1-tj@kernel.org>
 <20260225050109.1070059-12-tj@kernel.org>
 <aaBjHUr29afGuKVh@gpd4>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaBjHUr29afGuKVh@gpd4>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14482-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82A881BEADA
X-Rspamd-Action: no action

Hello, Andrea.

On Thu, Feb 26, 2026 at 04:13:33PM +0100, Andrea Righi wrote:
> My concern with this is that we may introduce some overhead for those
> schedulers that require frequent adjustment of slice / dsq_vtime directly.

I'm a bit skeptical about the premise. Unless p->scx.vtime/slice are used
for BPF side book-keeping, the only times they need to be modified are:

- When inserting into a vtime DSQ, vtime needs to be set. However, the
  interface functions already have provisions for setting vtime, so direct
  manipulation isn't necessary.

- slice can be simliar but can also be a bit more complicated. As slice only
  affects when the task actually gets on the CPU and a task may not have its
  eventual slice known at the time of its insertion into a user DSQ. In such
  cases, it may be necessary to set the slice as the task starts execution
  from e.g. ops.running().

- While a task is running, slice modification can be used to give the task
  more or less CPU time. Most commonly, these would be either extending
  slice to keep running the current task or preemting the task by setting
  the slice to zero and triggering a scheduling event.

So, as long as p->scx.vtime/slice are used to instruct the kernel what to
do, as opposed to being used for BPF side book-keeping, vtime doesn't need
to be directly modified at all and while slice may need to be modified,
those are mostly directly tied to actual scheduling operations and context
switches. I'd be surprised if the kfunc overhead is noticeable at all. kfunc
calls aren't expensive unless you're banging on it in a tight loop. Also,
note that in the lowest overhead scheduling scenario - direct dispatch to a
local DSQ from select_cpu()/enqueue() - neither is needed. It'd just be a
single scx_bpf_dsq_insert() call.

> While the scx_task_on_sched() check itself has likely zero impact, the
> kfunc invocations can potentially introduce measurable overhead.
> 
> I'm wondering if we could instead delegate the authority check at
> verification time, introducing something similar to PTR_TRUSTED
> (PTR_SCX_AUTH?) to struct task_struct * to represent that the scheduler has
> authority to access the task and allow direct writes to p->scx.slice /
> p->scx.dsq_vtime only when the register has that flag.
> 
> Then:
>  - for tasks passed from the core opts (enqueue, dispatch, etc.) we
>    automatically tag them with PTR_SCX_AUTH,
>  - tasks obtained externally (e.g., via bpf_task_from_pid()): they don't
>    have the flag (so no modification allowed) and in this case maybe we
>    provide a scx_bpf_auth_task() kfunc to perform the scx_task_on_sched()
>    check that returns p (or NULL) setting the auth flag if the scheduler
>    has full access to the task.

So, I'm not sure this is something we need to invest complexity into. The
only cases I can think of where the overhead might become visible is if the
BPF sched uses these fields for internal bookkeeping and keeps updating a
lot more times than there are actual scheduling events. However, I don't
think that's a usage model that we want to encourage.

Thanks.

-- 
tejun

