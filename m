Return-Path: <cgroups+bounces-13335-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGlFF09McGnXXAAAu9opvQ
	(envelope-from <cgroups+bounces-13335-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 04:47:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F2508F8
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 04:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17DBC484BC6
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 03:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E7D339878;
	Wed, 21 Jan 2026 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Na4E4y7R"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B0364041;
	Wed, 21 Jan 2026 03:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768967047; cv=none; b=PtDVHW72Xz8vQpeh8dQOzzKMRzaDxeB9tSkQKP2165Bg4z0NSluVBufl+s9Y+BCWR3aFxvfdog8lQhF0ghPsxpLtCakDqmARcetjCVr1iTBHAD7tbJKSR4QLrmTce1s89SL/PKxQRDggHMP/4aWUid2sqC6fQeZzVdcmFQBY040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768967047; c=relaxed/simple;
	bh=pc6PFxiB92WScgXPXOss5T9AeKb2BZmC2H47noT3FWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYB4/IB3NevNjWJjWjTfJK+XUUEsLLm9CsrNQIEqeX3MstgHNNYqM2NM6F8YZ1qT/B+OD2ebE+UnyH6+8Ze5Ju22QjHmnJ13aY/YPO66lFBmEmctHIcAePb2qZC4KdfPQ9J1/fBFEKat9LSdGEgqDrQa1tXyAxnc/7l7RIwVgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Na4E4y7R; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <37734a82-1544-4015-b4dc-30583441a7ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768967040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwFI19rHKuXMHgysj9bfGW48tJBo1CHyFN+/G60RpAs=;
	b=Na4E4y7RhOpKWm1ULIll2sSG85tYL68sEW3f6Hvb1fr+XbIegK2R6fEGdm32+KOAUCMoVz
	dVxDtmmujwNa4ugYnRTV467zixs0i4F1VkAmcRGhagZdGLjJVIIe2CA/+SaZXNf44bxClx
	bVB5eCBt1made05ad31kGVo+G9fxQ2w=
Date: Wed, 21 Jan 2026 11:43:50 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 28/30 fix 1/2] mm: memcontrol: fix
 lruvec_stats->state_local reparenting
To: Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
 <e5afd1b5ae95d70f82433b9b4e13201342d16707.1768473427.git.zhengqi.arch@bytedance.com>
 <ifcth3hxyrwmmeo3nejettdtkw2ndxdjbylszmhq3vohuhsncl@k23pew6gywko>
 <5a18658e-2076-4cbf-bc53-5b6e99c1035f@linux.dev>
 <A13923AA-8200-4863-8080-EC4B254BA3AA@linux.dev>
 <moupi2ch2cpuyrurthk66igh275ks62pltjk2zfngxozj52oxs@64lxvcgh3ays>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <moupi2ch2cpuyrurthk66igh275ks62pltjk2zfngxozj52oxs@64lxvcgh3ays>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13335-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 293F2508F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/21/26 2:47 AM, Shakeel Butt wrote:
> On Tue, Jan 20, 2026 at 03:19:00PM +0800, Muchun Song wrote:
>>
>>
>>>> No reparenting local stats for v2.
>>>
>>> It seems that lruvec_stats->state_local (non-hierarchical) needs to be
>>> relocated in both v1 and v2.
>>
>> Here we might need to elaborate a bit. Specifically, in the function
>> `count_shadow_nodes`, the use of `lruvec_page_state_local` to obtain
>> LRU and SLAB pages seems to also require these logics to work correctly.
>> For SLAB, it appears that the statistics here have already been
>> problematic for a while since SLAB pages have been reparented, right?
>>
> 
> Thanks a lot, now it is clear and yes it seems like SLAB is problematic
> but now I am wondering if it is really worth fixing. For LRU pages, how
> about using lruvec_lru_size() defined in vmscan.c. That would at least
> keep count_shadow_nodes() working irrespective of LRU reparenting.

Do you mean calling lruvec_lru_size() in count_shadow_nodes()? But
numa_stat interface also reads lruvec_stats->state and make it visible
to the user.

> 


