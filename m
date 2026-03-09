Return-Path: <cgroups+bounces-14706-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIgcCvw+rmndAwIAu9opvQ
	(envelope-from <cgroups+bounces-14706-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 04:31:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F2423387C
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 04:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C97A300A4F9
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2026 03:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006827FB1F;
	Mon,  9 Mar 2026 03:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I1WPgWyD"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699E1E834E
	for <cgroups@vger.kernel.org>; Mon,  9 Mar 2026 03:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773027062; cv=none; b=pFVyBAS3HoJx1cEVFWctqzkjLSRdEPYxYF1zu+Ut/C2hHi9zinl/RqA3nqS/0uNRitEHf0gmaYyHVTFKn12stWD2jvwAvtCNAQRjCmP9a3l9xe4hAtqQFGShGqvkCd9odTHYv3f5/625LfWOIspFb+ZA6UJhDzdxcJmraGXWd/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773027062; c=relaxed/simple;
	bh=Cq7pOWkgy5Xl5CZLed48itED/PWHe5kSVrGncmLnpYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P74U1prXWW5RJWMR0HVpvktex8/APxbl3MiTMJJaUf1UDy8Tg1OoHyB5RAlTU/XAZXkv41OH8pooQG5Wnv7zf1G7nAwD0aJY1eoS3PCyIh8qXWqJcntgEKeHNuo8Euz9i31XyNVgYyC5tvhTdOhlpqjxBmoKzXAVP6Z0DNpX20E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I1WPgWyD; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c64681a1-2069-421c-9e62-bb63e4ce261a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773027058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGRzB9NB7RnJy1AFfNjO4UdJlA1IIFldq9U5XbxXvLE=;
	b=I1WPgWyDe1PpSkWi58Zt5V7YwT8hbeXPtsYCQU2giIVSqguWg0dr5EDnvQX68WY0JDajo9
	tmo9uHiI36ZHcYV17iiu58tmXfGiZvnz/M6Mgeww97WrWDnV7hmN4VjOCNQ1+WVMItxj8U
	hawDYa8Qn46vurq+8oinWUsny/0xQRQ=
Date: Sun, 8 Mar 2026 20:30:47 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
To: Usama Arif <usama.arif@linux.dev>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
 vbabka@suse.cz, apopple@nvidia.com, axelrasmussen@google.com,
 byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
 eperezma@redhat.com, gourry@gourry.net, jasowang@redhat.com,
 hannes@cmpxchg.org, joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, mst@redhat.com, rppt@kernel.org,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com, rakie.kim@sk.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
 virtualization@lists.linux.dev, weixugc@google.com,
 xuanzhuo@linux.alibaba.com, ying.huang@linux.alibaba.com,
 yuanchu@google.com, ziy@nvidia.com, kernel-team@meta.com
References: <20260308192438.1363382-1-usama.arif@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <20260308192438.1363382-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 10F2423387C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14706-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,suse.com,suse.cz,nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp.kobryn@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

On 3/8/26 12:24 PM, Usama Arif wrote:
> On Fri,  6 Mar 2026 20:55:20 -0800 "JP Kobryn (Meta)" <jp.kobryn@linux.dev> wrote:
[...]
>> +static void mpol_count_numa_alloc(struct mempolicy *pol, int intended_nid,
>> +				  struct page *page, unsigned int order)
>> +{
>> +	int actual_nid = page_to_nid(page);
>> +	long nr_pages = 1L << order;
>> +	enum node_stat_item hit_idx;
>> +	struct mem_cgroup *memcg;
>> +	struct lruvec *lruvec;
>> +	bool is_hit;
>> +
>> +	if (!root_mem_cgroup || mem_cgroup_disabled())
>> +		return;
> 
> Hello JP!
> 
> The stats are exposed via /proc/vmstat and are guarded by CONFIG_NUMA, not
> CONFIG_MEMCG. Early returning overhere would make it inaccuate. Does
> it make sense to use mod_node_page_state if memcg is not available,
> so that these global counters work regardless of cgroup configuration.
>

Good call. I can instead do:

if (!mem_cgroup_disabled() && root_mem_cgroup) {
	struct mem_cgroup *memcg;
	struct lruvec *lruvec;
	/* use lruvec for updating stats */
} else {
	/* use node for updating stats */
}

This should also take care of the bot warning on mem_cgroup_from_task()
not being available.

