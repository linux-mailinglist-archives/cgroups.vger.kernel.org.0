Return-Path: <cgroups+bounces-14537-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFt8Cm4OpmmFJgAAu9opvQ
	(envelope-from <cgroups+bounces-14537-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 23:25:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7CB1E556A
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 23:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E044306E3DB
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 21:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B994390986;
	Mon,  2 Mar 2026 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRvxKUmq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2461A6811;
	Mon,  2 Mar 2026 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772488601; cv=none; b=IbuBLtQZAD/R3v8rsfhQWBEdgsZASkdTzJJ5FkafMeLBoTbtAYPt1Wcb12Df1PVnrpTZQVpo7jlO64t+q2BkIqYnL30RoaF4BhlKGlhJVlHN49rrjUSb3y3bwMuxOGt+z4mdhD+Vj3aShg67dkAs1Hd1dLYhoF4xAEhVRhqrzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772488601; c=relaxed/simple;
	bh=UE2MVOl289ObbgK0+40wIBB2si4+wyFn2M+IMfT4G3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtZFIlRdeWVZlpjnYFMvx2IohTurDJ6n2JJvQDGVTfZ/MhBk1CpGoj+pqNNgX8wALSqdo71ZE8wYVg4oZ5yhQbxLzcFFrHmC0wxBSHIx+GpVAoYZoOXdla62yPNe8tLzmyDv83dIjXbWhKho86heoIW8d5yPwgPCt3uF8ydgRXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRvxKUmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56991C19423;
	Mon,  2 Mar 2026 21:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772488601;
	bh=UE2MVOl289ObbgK0+40wIBB2si4+wyFn2M+IMfT4G3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRvxKUmquy0pQpYUBrRNOmty6cnaQzc/xUveZw3X4JhzmeQZNQo2CUgli3772ZeIS
	 8k+sESJBNU7mB/f3N1RyAdCsVBzN7Yk23kuj73wG5PRN0/s3beVW8l0KxWHqv5kRm5
	 rahmkQTelJulzchyJtogFpRArYc9yoxhCVSwFLW5tC8GLZoJl1kgUcCrXkJ1Sy6HLm
	 wt6LSi77uYEK2X9e2BipShejoI0CdxWAWY33kc6crgBtGHc37HsZcePeIyeODpS8aP
	 Pm5+icuMZDfMBh3czHAlwlE7opHaq3vDYrqrtFR3WPOepGA2DAV2jYBV7UM3crsUTg
	 KASxeDsHqvpgQ==
Date: Mon, 2 Mar 2026 11:56:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, cgroups@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH] cgroup: Don't expose dead tasks in cgroup
Message-ID: <aaYHmCV2CW-tOT-Z@slm.duckdns.org>
References: <20260302120738.6KkDipsR@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302120738.6KkDipsR@linutronix.de>
X-Rspamd-Queue-Id: 9D7CB1E556A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14537-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,cmpxchg.org,suse.com,kernel.org,goodmis.org,web.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello, Seb.

On Mon, Mar 02, 2026 at 01:07:38PM +0100, Sebastian Andrzej Siewior wrote:
> Tejun, with this change, would it be okay to
> - replace the irq-work with kworker? With this change it should address
>   your concern regarding "run in definite time" as mentioned in [0]. So
>   it might be significantly delayed but it shouldn't be visible.
>   This would lift the restriction that a irq-work needs to run on this
>   CPU and the kworker could run on any CPU. 

Yeah, that's fine.

> - would it be okay to treat RT and !RT equally here (and do this delayed
>   cgroup_task_dead() in both cases)

I don't see why we'd bounce on !RT. Are there any benefits?

> @@ -5283,6 +5283,11 @@ static void *cgroup_procs_start(struct seq_file *s, loff_t *pos)
>  
>  static int cgroup_procs_show(struct seq_file *s, void *v)
>  {
> +	struct task_struct *tsk = v;
> +
> +	if (READ_ONCE(tsk->__state) & TASK_DEAD)
> +		return 0;

Does this actually close the window for systemd through operation ordering
or does it just reduce the race window?

Thanks.

-- 
tejun

