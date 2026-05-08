Return-Path: <cgroups+bounces-15669-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eArKHOQt/WlIYgAAu9opvQ
	(envelope-from <cgroups+bounces-15669-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 02:27:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1004F077C
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 02:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6ACA300D14B
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 00:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCF51BC08F;
	Fri,  8 May 2026 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdtqYvRs"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A2C1A9F9F
	for <cgroups@vger.kernel.org>; Fri,  8 May 2026 00:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778200033; cv=none; b=hwhJUCDkTiTVcw2FFkSEIwvIW1RepQ0I1VEfQz/kaobQpZORfZ9szfjpjTdQoZRTF3F3I12Iec4RlZ6NdzjLdBv1q/DKBJX14e9pGyfFrxJixmm4enKN6ZM0cX/dtn5ryQjLBlfrJOjihpTZg6I37pU05Hzg0ukdf19/PBgBkdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778200033; c=relaxed/simple;
	bh=pAy+ut5sDDPJe/IDKMS1VPfPYjFjUMBeOZqgH293uME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow9yObqEkURzX2r7YUq1dTaboqtH+bKueCIUBg+QHoOrwnhFu+ZnSGe++0jl5R+0YSJI7EqS7H0eTQ2Ng+gL/v3XRb8GqLUhu5xdTaWyN1pAeReuHpN9JGm1/YW6Yk+vR0SDcaR1K9V/57dDwcSSF0GdcxRr5mV9PObiEYTc8QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdtqYvRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6885C2BCB2;
	Fri,  8 May 2026 00:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778200032;
	bh=pAy+ut5sDDPJe/IDKMS1VPfPYjFjUMBeOZqgH293uME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdtqYvRsp7NXpdr3L+3l7U9pRsRWotak5hS4Oa65dyEDHzQIZ/RjHdtzy7dVR5m7V
	 eLExPo/3u89pzC9PDjWbh3lcCs3an9+Is24RhLzUI+rUOVYVSWCn6WfZlHhoE8q6Cx
	 vc/x2OgF3K1RoOcIsGLoOYvpFM6Q6kgjHxbQHpBIugvXpSXAG6JJZe4SSwJAaSl91u
	 tdvYcBrtcZtaXiLa1ZKKziAouk0IWC5a5SjUo8AOQ5clkha6ykPoaYpHieWYih+vCj
	 lHsPBUYgzpOiAZQC4c1zE98ouS7YvbwRrohvsosmsbvS7gKRLPT8Id2zauKjb+/vHS
	 v91mDXCFOkmEw==
Date: Thu, 7 May 2026 14:27:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: axboe@kernel.dk, cgroups@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH v3] blk-cgroup: fix leaks and online flag on
 radix_tree_insert failure
Message-ID: <af0t35krg3nQxMHM@slm.duckdns.org>
References: <20260506131124.16755-1-cuitao@kylinos.cn>
 <20260507061229.57466-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507061229.57466-1-cuitao@kylinos.cn>
X-Rspamd-Queue-Id: CC1004F077C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15669-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,slm.duckdns.org:mid]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 02:12:29PM +0800, Tao Cui wrote:
> When radix_tree_insert() fails in blkg_create(), the error path has two
> issues:
> 
> 1. blkg->online is set to true unconditionally, even when the blkg was
>    never fully inserted.  Move the assignment inside the success block.
> 
> 2. The error path calls blkg_put() without first calling
>    percpu_ref_kill().  Because the refcount is still in percpu mode,
>    percpu_ref_put() only does this_cpu_sub() without checking for zero,
>    so blkg_release() is never triggered.  This permanently leaks the
>    blkg memory, its percpu iostat, policy data, the parent blkg
>    reference, and the cgroup css reference — the latter preventing the
>    cgroup from ever being destroyed.
> 
> Fix by replacing blkg_put() with percpu_ref_kill(), matching the pattern
> used in blkg_destroy().
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

