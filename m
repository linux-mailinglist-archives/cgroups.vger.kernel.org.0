Return-Path: <cgroups+bounces-14478-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM78ACH2oWkwxgQAu9opvQ
	(envelope-from <cgroups+bounces-14478-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 20:53:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFA11BD1EA
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 20:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CB813002E4C
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 19:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0520F46AED1;
	Fri, 27 Feb 2026 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6FWDw0o"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4736921B;
	Fri, 27 Feb 2026 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221808; cv=none; b=L1907kC/sqtvPZkcuT2ZIcuDzmioIj3GhgLqW5mIRQYolXOCJj+SJ5lxEKLr/79RcdePsG4fCEFkmGG2L6H5ThEbLDbWTWPwVR2bm5oEXf8alCdphZrLn24ARbHx4V2jZFYLHRQ06I2SfJKu9zeR73khd87Ta+I4Uv2sD7i3e8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221808; c=relaxed/simple;
	bh=AxSwpsDmZB71i2iDeLN0Jw/yz74vwe+juNUzt8qw6iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/EBoF3HKqkvzrlFA2WuCZ9AxBANjqW+TSK0y3tEEhC/fniDWVJR7mT0Rp5fdomTAiDHlMV+Fpp85YI+wk4ybmnBG6qKvBT2DtxC9PjSONoE5ANY5N1bhw3+2u3uSAZvH2suPrrWOKS55oiddTZAgldNcFWdJOBVo+eaPsxwrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6FWDw0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B63C19421;
	Fri, 27 Feb 2026 19:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772221808;
	bh=AxSwpsDmZB71i2iDeLN0Jw/yz74vwe+juNUzt8qw6iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6FWDw0obIHq0Qc4ZQC+Rssv/kX9vJ38WTU1CDwADId+fny/K3Tw15sfPUJ9o0l/Q
	 +rsP7NPXZHAF+9KD3R8AA46ArLS30aVvRHf3W7ErCNfBEJYgOHlhLKVQS1Q4limEkG
	 +7jc4gOy4C/NKPZzI3Fp16Ec5ks5wyFJ0xPiIDSWweYobR9YBAC6X3LB2lEaUZuWhs
	 aE+tdlW8HWFRpQnWs6YcGeTwTpqnF/1KhIHlv03rmXeooS8wUjHtEO4kbsJkpI28eO
	 FmkZEifSux0OCOPjGaQXiLREOE9/jnuushhZtiyYmV7t1Q5+nf1T7ovDgedsjhnzfY
	 mghWHFB5MK0Uw==
Date: Fri, 27 Feb 2026 09:50:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 13/34] sched_ext: Refactor task init/exit helpers
Message-ID: <aaH1b9tpCzWG3--x@slm.duckdns.org>
References: <20260225050109.1070059-1-tj@kernel.org>
 <20260225050109.1070059-14-tj@kernel.org>
 <aaE_9YPu3T-pMXfO@gpd4>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaE_9YPu3T-pMXfO@gpd4>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14478-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 6DFA11BD1EA
X-Rspamd-Action: no action

Hello,

On Fri, Feb 27, 2026 at 07:55:49AM +0100, Andrea Righi wrote:
...
> Without CONFIG_EXT_GROUP_SCHED we get this:
> 
> In file included from kernel/sched/build_policy.c:62:
> kernel/sched/ext.c: In function ‘__scx_init_task’:
> kernel/sched/ext.c:3228:28: error: unused variable ‘tg’ [-Werror=unused-variable]
>  3228 |         struct task_group *tg = task_group(p);
>       |                            ^~
> cc1: all warnings being treated as errors
> 
> Maybe wrap tg inside an #ifdef CONFIG_EXT_GROUP_SCHED or we can do
> SCX_INIT_TASK_ARGS_CGROUP(task_group(p)) directly.

Yeah, there were a number of build failures w/o cgroup / cpu control
enabled. Fixed in my tree. Should be okay on the next posting.

Thanks.

-- 
tejun

