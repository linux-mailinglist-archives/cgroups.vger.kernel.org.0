Return-Path: <cgroups+bounces-13589-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJxSBcosgGlZ3wIAu9opvQ
	(envelope-from <cgroups+bounces-13589-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 05:49:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE03AC836D
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 05:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 913AA3008E32
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 04:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B462C17A1;
	Mon,  2 Feb 2026 04:49:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC7E2C11CD;
	Mon,  2 Feb 2026 04:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770007747; cv=none; b=OXNaThxk1WpFfO07KYBwAQLLr3yAmjtkjG8UDG3L13ludjFqsJ/BgFweCaKZ2d1Ml1Kqrx65o6CTH4FejcLXKfVNjjdT+aFLTvF5zGGUFstqqCmOMzGOLj7x3pEt2sgzsVZBnVkEsGIxvPl9t93/z6paFtQmaCd1DazGRu/i8Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770007747; c=relaxed/simple;
	bh=SMTLwTiGXiPrzkV2SsL2OnW5kJvjDOPABC51IhmEd1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P31t6ZST8Fwk0ApkcnW31hwkdQApVv3H1Gly6qtl2z0aeRbV9mG8DJ3U2oH6mkenUD6tCZ+fSHEcJb2soHV4VcNHQfYOohv/1eL3/XYBYQ2aRvqMvu9KoHKdtG2bzL/amsW/HFQ2KF66hVp7BlbJ/orXupfcz9Kvgjg6aBvQsOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0533339;
	Sun,  1 Feb 2026 20:48:58 -0800 (PST)
Received: from [10.164.136.51] (unknown [10.164.136.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 764743F740;
	Sun,  1 Feb 2026 20:49:01 -0800 (PST)
Message-ID: <2638bd96-d8cc-4733-a4ce-efdf8f223183@arm.com>
Date: Mon, 2 Feb 2026 10:18:52 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] memcg: use mod_node_page_state to update stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Qi Zheng <qi.zheng@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <20251110232008.1352063-2-shakeel.butt@linux.dev>
 <1052a452-9ba3-4da7-be47-7d27d27b3d1d@arm.com> <aYAmGc6lu973jRwu@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aYAmGc6lu973jRwu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13589-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,cgroups@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,arm.com:mid]
X-Rspamd-Queue-Id: BE03AC836D
X-Rspamd-Action: no action


On 02/02/26 9:56 am, Shakeel Butt wrote:
> On Thu, Jan 29, 2026 at 06:35:21PM +0530, Dev Jain wrote:
>> On 11/11/25 4:50 am, Shakeel Butt wrote:
>>> The memcg stats are safe against irq (and nmi) context and thus does not
>>> require disabling irqs. However some code paths for memcg stats also
>>> update the node level stats and use irq unsafe interface and thus
>>> require the users to disable irqs. However node level stats, on
>>> architectures with HAVE_CMPXCHG_LOCAL (all major ones), has interface
>>> which does not require irq disabling. Let's move memcg stats code to
>>> start using that interface for node level stats.
>>>
>>> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>>> ---
>> Hello Shakeel,
>>
>> We are seeing a regression in micromm/munmap benchmark with this patch, on arm64 -
>> the benchmark mmmaps a lot of memory, memsets it, and measures the time taken
>> to munmap. Please see below if my understanding of this patch is correct.
> Thanks for the report. Are you seeing regression in just the benchmark
> or some real workload as well? Also how much regression are you seeing?
> I have a kernel rebot regression report [1] for this patch as well which
> says 2.6% regression and thus it was on the back-burner for now. I will
> take look at this again soon.

The munmap regression is ~24%. Haven't observed a regression in any other
benchmark yet.

>
> [1] https://lore.kernel.org/all/202512101408.af3876df-lkp@intel.com/
>

