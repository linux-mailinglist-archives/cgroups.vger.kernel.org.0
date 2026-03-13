Return-Path: <cgroups+bounces-14820-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFgZCRBYtGlbmAAAu9opvQ
	(envelope-from <cgroups+bounces-14820-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 19:31:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 792FE288C2C
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 19:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1761330E7C6B
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 18:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFBC3DD53E;
	Fri, 13 Mar 2026 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gOjsee/7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C253DD53B
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426561; cv=none; b=t8gZjYtKZGAoLNa5WlTcB5NWnV4BBFXaPYJt/jmSTtV/A9UPNqB3Ab+HhlsgpbD66rmhRAyYj82gMrSahfcUkTXq00gdIOUwa/AT3jJ0kHDutwRb9FjN/MzKy2ims/3GTcmVB+ug74O+N7bKBq9rARtoBekoO2tPyST2tQuTiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426561; c=relaxed/simple;
	bh=beT3slSxigQWpRi2wAgooEEIOo5XJcpPrhDfU9dsQZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ief7uPwYYRSC82lyMo4Dbk5vpaqnYpf54mxiaFgpkygJzmJq0L3JkmJa63pzdtOYOW5L6XHGFKNSpN2U6gvyGsf2/QzWYsnuK/HtUTd2YdgMBF0oHQm2jsLwz18RdGAEeIgDB72u87vjPSZGNwjQIFxmyD8JZg+b4ABMZgsuqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gOjsee/7; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cdc56556-2f69-46b7-8a7c-0f144a36004c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773426547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pv/nqWXHkfj7NbNE0aFGYmPjuMP96PKFI4ITkk92xic=;
	b=gOjsee/7ePXLg2aXVQRCN98jWrWOJGc7S6Od5X5MCK2XmZiOGkbnjW7aiGdNYAKZEniFby
	yIlBZdhFvB+0R6tKrR+2QHRw41SgEFGPECC6cQR00lVPRhhcghOc3/uCGAMO4OCyycW0lq
	ZTmH8SsM0A6v+7eY3IHoq5fzhd3ix7E=
Date: Fri, 13 Mar 2026 11:28:52 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
To: "Huang, Ying" <ying.huang@linux.alibaba.com>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
 apopple@nvidia.com, axelrasmussen@google.com, byungchul@sk.com,
 cgroups@vger.kernel.org, david@kernel.org, eperezma@redhat.com,
 gourry@gourry.net, jasowang@redhat.com, hannes@cmpxchg.org,
 joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, mst@redhat.com, rppt@kernel.org,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com, rakie.kim@sk.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
 virtualization@lists.linux.dev, weixugc@google.com,
 xuanzhuo@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
 <3a42463b-9ddd-4d64-b64c-6c2e6e4fc75d@kernel.org>
 <343bbd5b-67a0-46c4-8ec4-69158bf26b3f@linux.dev>
 <874imkpba1.fsf@DESKTOP-5N7EMDA>
 <cd3d7e2c-79fa-4c00-89ad-83beddf98bae@linux.dev>
 <60f71f4c-71d9-4751-8c6b-10179b98bef0@kernel.org>
 <87zf4cnkip.fsf@DESKTOP-5N7EMDA>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <87zf4cnkip.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14820-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,suse.com,nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp.kobryn@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 792FE288C2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 2:31 AM, Huang, Ying wrote:
> "Vlastimil Babka (SUSE)" <vbabka@kernel.org> writes:
> 
>> On 3/13/26 07:14, JP Kobryn (Meta) wrote:
>>> On 3/12/26 10:07 PM, Huang, Ying wrote:
>>>> "JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:
>>>>
>>>>> On 3/12/26 6:40 AM, Vlastimil Babka (SUSE) wrote:
>>>>>
>>>>> How about I change from per-policy hit/miss/foreign triplets to a single
>>>>> aggregated policy triplet (i.e. just 3 new counters which account for
>>>>> all policies)? They would follow the same hit/miss/foreign semantics
>>>>> already proposed (visible in quoted text above). This would still
>>>>> provide the otherwise missing signal of whether policy-driven
>>>>> allocations to a node are intentional or fallback.
>>>>>
>>>>> Note that I am also planning on moving the stats off of the memcg so the
>>>>> 3 new counters will be global per-node in response to similar feedback.
>>>>
>>>> Emm, what's the difference between these newly added counters and the
>>>> existing numa_hit/miss/foreign counters?
>>>
>>> The existing counters don't account for node masks in the policies that
>>> make use of them. An allocation can land on a node in the mask and still
>>> be considered a miss because it wasn't the preferred node.
>>
>> That sounds like we could just a new counter e.g. numa_hit_preferred and
>> adjust definitions accordingly? Or some other variant that fills the gap?
> 
> Or can we adjust the semantics of numa_hit/miss/foreign to consider the
> preferred nodemask instead of the preferred node?  Is there some
> programs to depends on the current behavior?

Good question. I think it comes down to whether the existing semantics
are correct with respect to policies that make use of node masks. I gave
some thoughts on this in the previous reply to Vlastimil. That
correctness may be outside of the scope of this patch, but I can give
that a try afterward. I'd like to send a revision that reduces the new
counters to just 3 and moves them off of the memcg (as previously
mentioned in thread).

I know numastat is one consumer of the existing stats. It seems up to
the user on the interpretation of the data. Not sure about others.

