Return-Path: <cgroups+bounces-14730-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCj2G2nsr2nkdAIAu9opvQ
	(envelope-from <cgroups+bounces-14730-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 11:03:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC8D249021
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 11:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C200430580B1
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 10:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74B736C9CF;
	Tue, 10 Mar 2026 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drxTRXjh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759AA33B6D0;
	Tue, 10 Mar 2026 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136928; cv=none; b=XSWVy2Ns66N7qOfQ/ReAlvQko5dIyxihiBko+PEbLJSFek62NwtFlAi3G8q1CKxglNgtlXil9kJyRmBzZCUliiTrOOBkB9Oa4QPHIZYFDeydGjrQW1Ct+6bnyJ7sLVxwlwrtdLwXrzmMPiI3fXaKNll/wdlW2lprXRLQvqmA2Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136928; c=relaxed/simple;
	bh=AW2EnKIV5unNPlYnpWuupPSYBSspc+mdKzfnj40e7Kg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k/aVmr/AK/GfJf9pE15yZjgTPVVJFdt5uSEmv65Kn2M7qC0j2mLRMP1/VUvJKa4Nz3DuFuRjMKCFf+XPxQioSTLcQ8/HJWIIerLv3/701AyPuRY5mHCqlpuWsOIvQnNfaYr3rLUnGqx8gsX+o62h9iI65O27Qi10MehMQrTLQZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drxTRXjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259F9C19423;
	Tue, 10 Mar 2026 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773136928;
	bh=AW2EnKIV5unNPlYnpWuupPSYBSspc+mdKzfnj40e7Kg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=drxTRXjhF4eQcf8EDkeyKeEvVHbYNanT4mOGmTFPQ8LB3Akq1ZMHaC3o8Dss2BO7O
	 RU6Xn0Wqn0d7aACg3Q4w4TnFwYujsUfbgv3KwON9BAAuksNZrN0Xw4Cbtei+40efBB
	 lQkCDpt/zbm/TyLAp3Qoz5otVWdwJ9VY7Gr/PfgpPljvUmlJ1Q+s4X36oMKafVti5a
	 /Uwi9V8Hy+kWarZdlcAcyj4Pxr520wBVA87MY9bzbBMIcBa1Jji/pUW8ADAALNYwad
	 SM6SjQeZk0gAuHGzoQqDmy3K4s3iZ5mhVEc5tE0DhU+cXSm6FTXrpB7y9HVCgtPqTN
	 EchgDwG+h3PcQ==
Message-ID: <332271be-7ed1-449e-b7f7-ad815a941b9c@kernel.org>
Date: Tue, 10 Mar 2026 11:02:02 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: vbabka@kernel.org
Subject: Re: [PATCH] mm/slab: fix an incorrect check in obj_exts_alloc_size()
To: Zw Tang <shicenci@gmail.com>, Harry Yoo <harry.yoo@oracle.com>
Cc: adilger.kernel@dilger.ca, akpm@linux-foundation.org,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, hao.li@linux.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, cl@gentwo.org,
 rientjes@google.com, roman.gushchin@linux.dev, viro@zeniv.linux.org.uk,
 surenb@google.com, stable@vger.kernel.org
References: <aa5NmA25QsFDMhof@hyeyoo>
 <20260309072219.22653-1-harry.yoo@oracle.com>
 <CAPHJ_VLzRECge4=L5RRqZyf-Sou8APi=Sc=d0brBAMdj3UC_Cw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPHJ_VLzRECge4=L5RRqZyf-Sou8APi=Sc=d0brBAMdj3UC_Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AFC8D249021
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14730-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/10/26 04:40, Zw Tang wrote:
> Hi Harry,
> 
> Thanks for the patch.
> 
> I tested it on my environment with the original syzkaller reproducer,
> and the warning no longer reproduces after applying the patch.
> 
> Kernel version tested: v7.0-rc2
> 
> Tested-by: Zw Tang shicenci@gmail.com

Thanks!


