Return-Path: <cgroups+bounces-15188-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNTTHqFM1WkA4gcAu9opvQ
	(envelope-from <cgroups+bounces-15188-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 20:27:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D4E3B2E96
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 20:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 768A4301E723
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2026 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7942DF717;
	Tue,  7 Apr 2026 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X95BrSni"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1A25A33F;
	Tue,  7 Apr 2026 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775586463; cv=none; b=XkMlzoQEyw6hkGGWYKd5T6W/c7vg0o0QHsELFPC38b6SNoGvBx+2Runul56hX25Vy7WZauvYhOTpfoIe/UzqwR/dNpL0oeVXGPoYIQygCNAyRZrPAEKTjC1XXajS16zXNTKDoCL1zAZMzsFTVYq28iHxuQg4904tGox0pB/OGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775586463; c=relaxed/simple;
	bh=GzIaObYHKSieBS5jLgatarytMYl0UMmRJKIRCoGKfXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOsucq3ZQfn0A0cIfLGqI6aQ4wimic7tBMBeTqE3+5UoSd0eYuy8mvjD0EaZYOKW+X5U0g/X6hHHp90NfuBoj/XZFbQI3ZJPqiSR9L38KjKDLIjEJ+xmkwj02dfR8aUzd36zHMrelsz3BPNXTVWKxll1PqYDLYKb2uaRjZAw10Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X95BrSni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78092C116C6;
	Tue,  7 Apr 2026 18:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775586462;
	bh=GzIaObYHKSieBS5jLgatarytMYl0UMmRJKIRCoGKfXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X95BrSnixts2JtFkkb0kUqeQUzwArmSC4CX1ClUOenAM94vmbVHONlpSu7H5IBDSt
	 Y9Xk6sMKQj9BPVvM0cYolM6ucD5gNoqPSDDVtpwPRBpaYqWXjHjLB7fcpyURvvebD/
	 n3z433EM1XGRNn7FT9ox2aum5EWsd3c4ZllI+K4pA/T3BIcXopogqGV6nNqQqVOk08
	 lRl7LlUqVbyrqATWZensWkaZAdy6WEMYzW8mqpv8I9dFf0IhwLLVwO1gWpB+7VObgJ
	 BmpSgpL3aMAS+evdY9d8Pt9nwchevrHYslJ3ZoUHd+AAH8uoYQ+5NlmXjDFqKSA5L9
	 bzDuB/2jmeg+w==
Date: Tue, 7 Apr 2026 08:27:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Willy Barro Raffel <willybar@amazon.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Justinien Bouron <jbouron@amazon.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: Re: [PATCH] cgroup: add cpu.stat.percpu for per-CPU cgroup stats
Message-ID: <adVMne0wsVCvc2hH@slm.duckdns.org>
References: <20260407010642.3249-2-willybar@amazon.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407010642.3249-2-willybar@amazon.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15188-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23D4E3B2E96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 06:06:43PM -0700, Willy Barro Raffel wrote:
> Expose per-CPU subtree_bstat via a new cgroupfs file cpu.stat.percpu.
> Each line shows one CPU cumulative stats in io.stat-style key=value
> format:
> 
>   cpu0 usage_usec=123 user_usec=45 system_usec=78 nice_usec=0
>   cpu1 usage_usec=456 user_usec=123 system_usec=333 nice_usec=0
> 
> This completes the interface left as a TODO in commit 7716f383a583
> ("Merge tag 'cgroup-for-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup")
> which added per-CPU subtree_bstat but only exposed it via BPF/drgn.

Given how quickly cpu count is increasing with 1k CPUs on common prod
machines not too far off, I'm not sure naively formatting output for every
possible CPU is desirable.

Thanks.

-- 
tejun

