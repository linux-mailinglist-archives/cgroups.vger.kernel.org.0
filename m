Return-Path: <cgroups+bounces-13594-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC3INDFmgGlA7wIAu9opvQ
	(envelope-from <cgroups+bounces-13594-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 09:54:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09057C9D18
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 09:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B4AA3001392
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 08:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149EA29BD89;
	Mon,  2 Feb 2026 08:54:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913BE4A3C;
	Mon,  2 Feb 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770022444; cv=none; b=YYiApgrTtOCS9Y9b7o+/omLYEOz7nymXA9ESzVHWS+xEMmosNizAJ0+BKyto5jYCIQYTIHe31D4v82z/TiudcVVlq4UsYSWuF2d1gUT9OceurtTrObJ6qft1L0zCWHR9EAOsz1DCK39xh0Uk9/gpAz679CAaVf0BVLjr16nqrHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770022444; c=relaxed/simple;
	bh=L5BozPIX+bclBxZ7KoKXqotYg7/JAXk/wQVKWVmv0eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfWbacuWAnyi8R9Zt3z6yXu8Jd+/KEf4GnDHHt2v9g8p4oKgD3V7YdyXQBM6a4qcIkySsw7uLdIOi6jXTVFAnhnzZItNSSZWY25GwktypWEKACGasrlyROQHXWvz0xBnQr8fS+ToV6u32/PaB0J9GWIPcvspevO3txY+9yq7JoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44738339;
	Mon,  2 Feb 2026 00:53:55 -0800 (PST)
Received: from [10.164.18.75] (unknown [10.164.18.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC54E3F740;
	Mon,  2 Feb 2026 00:53:57 -0800 (PST)
Message-ID: <05aec69b-8e73-49ac-aa89-47b371fb6269@arm.com>
Date: Mon, 2 Feb 2026 14:23:54 +0530
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
 <2638bd96-d8cc-4733-a4ce-efdf8f223183@arm.com>
 <51819ca5a15d8928caac720426cd1ce82e89b429@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <51819ca5a15d8928caac720426cd1ce82e89b429@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13594-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:url,arm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09057C9D18
X-Rspamd-Action: no action


On 02/02/26 10:24 am, Shakeel Butt wrote:
>>>> Hello Shakeel,
>>>>
>>>>  We are seeing a regression in micromm/munmap benchmark with this patch, on arm64 -
>>>>  the benchmark mmmaps a lot of memory, memsets it, and measures the time taken
>>>>  to munmap. Please see below if my understanding of this patch is correct.
>>>>
>>>  Thanks for the report. Are you seeing regression in just the benchmark
>>>  or some real workload as well? Also how much regression are you seeing?
>>>  I have a kernel rebot regression report [1] for this patch as well which
>>>  says 2.6% regression and thus it was on the back-burner for now. I will
>>>  take look at this again soon.
>>>
>> The munmap regression is ~24%. Haven't observed a regression in any other
>> benchmark yet.
> Please share the code/benchmark which shows such regression, also if you can
> share the perf profile, that would be awesome.

https://gitlab.arm.com/tooling/fastpath/-/blob/main/containers/microbench/micromm.c
You can run this with
./micromm 0 munmap 10

Don't have a perf profile, I measured the time taken by above command, with and
without the patch.


