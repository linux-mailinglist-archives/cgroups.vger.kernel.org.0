Return-Path: <cgroups+bounces-14740-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKErCEFRsGmBiAIAu9opvQ
	(envelope-from <cgroups+bounces-14740-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 18:13:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E25D255559
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 18:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A23F303514E
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7793C9445;
	Tue, 10 Mar 2026 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E5bgoUQu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F422FDC3C
	for <cgroups@vger.kernel.org>; Tue, 10 Mar 2026 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162140; cv=none; b=Gah1rChHgTEt1LIk/EWlfaFs39yrg/ZDHgwoqKj/o59fWp6V7V2YsKW7jgFm2epzpkreoJ1RVtddoVdr4n/dMK8S12oTFggMwITmKveXRGcDJPItDw8HHP92K26em0VuHJ6BK1+P/oTiI/wS6UyWOu0CQpSB32AE6i4XweCDr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162140; c=relaxed/simple;
	bh=UXdqamY6AIu9HPttzy2Zdui/eIc+rJ7wz+7z84q9oug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+5FLMoGdIlkr1btJXrYq7+o62L6UZKTD5B8hKBpH0afqbYqtGMRNKgBCzFnewePvF+c7hO2PKJP1EF343+32aHGPZiArGaI7mpcpXsJO+a+jxOBiruyh/NgqWTEN3y+R3bnyka8U6MrNdug66EEQZGiUvX9vzUKUc/6h3lvVyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E5bgoUQu; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <35272f7a-4c1e-48f8-8e99-82bf3baffab3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773162135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0LKshKUK3KitIMjNACXgO7TTkRiyZPtXq9EyeTBs6so=;
	b=E5bgoUQuw0+On5E2PJ89wAn5VJKu0l4SF5t/wicRslH5R9CgJYBndevL6URwlolo5gSWRA
	Rc/KugVqwjM2d90Y46q784Bkmf8xfQ3zQpYtXtd6nTtBR9SZPM+vh4LPJc3yEA8/OJ97D/
	64B0uIZzJgoLagIttfjTn+QWj07uYtA=
Date: Tue, 10 Mar 2026 10:01:53 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
 vbabka@suse.cz, apopple@nvidia.com, axelrasmussen@google.com,
 byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
 eperezma@redhat.com, gourry@gourry.net, jasowang@redhat.com,
 hannes@cmpxchg.org, joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, mst@redhat.com, rppt@kernel.org,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com, rakie.kim@sk.com,
 roman.gushchin@linux.dev, surenb@google.com, virtualization@lists.linux.dev,
 weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
 <aa9aDGwk8YteaEob@linux.dev> <dcf2e654-ad2f-4390-9b62-078e664158de@linux.dev>
 <abAmMjkZZLN9LXXM@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <abAmMjkZZLN9LXXM@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 0E25D255559
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14740-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,suse.com,suse.cz,nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/10/26 7:53 AM, Shakeel Butt wrote:
> On Mon, Mar 09, 2026 at 09:17:43PM -0700, JP Kobryn (Meta) wrote:
>> On 3/9/26 4:43 PM, Shakeel Butt wrote:
>>> On Fri, Mar 06, 2026 at 08:55:20PM -0800, JP Kobryn (Meta) wrote:
> [...]
>>>
>>> This seems like monotonic increasing metrics and I think you don't care about
>>> their absolute value but rather rate of change. Any reason this can not be
>>> achieved through tracepoints and BPF combination?
>>
>> We have the per-node reclaim stats (pg{steal,scan,refill}) in
>> nodeN/vmstat and memory.numa_stat now. The new stats in this patch would
>> be collected from the same source. They were meant to be used together,
>> so it seemed like a reasonable location. I think the advantage over
>> tracepoints is we get the observability on from the start and it would
>> be simple to extend existing programs that already read stats from the
>> cgroup dir files.
> 
> Convenience is not really justifying the cost of adding 18 counters,
> particularly in memcg. We can argue about adding just in system level metrics
> but not for memcg.
> 
> counter_cost = nr_cpus * nr_nodes * nr_memcg * 16 (struct lruvec_stats_percpu)
> 
> On a typical prod machine, we can see 1000s of memcg, 100s of cpus and couple of
> numa nodes. So, a single counter's cost can range from 200KiB to MiBs. This does
> not seem like a cost we should force everyone to pay.
> 
> If you really want these per-memcg and assuming these metrics are updated in
> non-performance critical path, we can try to decouple these and other reclaim
> related stats from rstat infra. That would at least reduce nr_cpus factor in the
> above equation to 1. Though we will need to actually evaluate the performance
> for the change before committing to it.

I could trade off the per-cgroup granularity and change these stats to
become global per-node stats.

