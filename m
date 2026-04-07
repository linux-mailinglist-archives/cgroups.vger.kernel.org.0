Return-Path: <cgroups+bounces-15179-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHg8OBdp1GnptgcAu9opvQ
	(envelope-from <cgroups+bounces-15179-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 04:16:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 436873A8F3D
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 04:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 484FE305BDFC
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2026 02:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E1B1EA7CE;
	Tue,  7 Apr 2026 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p7s78Uy1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0C274641
	for <cgroups@vger.kernel.org>; Tue,  7 Apr 2026 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527999; cv=none; b=mkDuU+WCUi/Q+e03Cv3C7qDKRYIdNxBsXgshVOKp9cDaC4JNrZAYzFkvg68AndSgWSzWBULcSZ930oywNueKJnUYOSuMKdk9uGfvkuIH6+2HXQsIAgU9kIwWM5ygaxm3LmxHQa0R5MqXz0T+U5wpODNFYhcSkIIl+DqL9nGowZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527999; c=relaxed/simple;
	bh=BpL5lX/zl4/fHlYKRyS8DJF8/l0lAbWfJLBW0e/+SYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWBrAjwKP/qed+CM25Bu2BdljGxep5OXeqwgu3xrPDF6wHtgXLPKInHpgE82T2dFKbbkF2vRBUH6tA4bHjt+lKwenM/AHi6xUCQcJH3dsB1Opm1cPvDR611BGlPmHHRaO/9gLpi9Yn2QQdBWh0Ux2Q6UEIIw54bgMmqA+s+3TlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p7s78Uy1; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bb35a69a-5be9-45f5-a557-1902487a1bc2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775527986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSDM3Xa9OKTpOqUyJXXJL/N9oKWp7CgjmMDNFGNadDU=;
	b=p7s78Uy1xvl6dGGM0H/S2+3LMU53v9/HniExRR/oiOtc7e6yjcBCt4BY01g7CRLXeb2hVg
	zDYw4oa6DyVw23A/EnX5JQIwIHy66z+3poLCY2j74zgp0p/h3vc+2kxmDji382FVGeEmpO
	8CGpM6DUnj+5UagK8/p3VNxy1WNSsMQ=
Date: Tue, 7 Apr 2026 10:12:30 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 32/33] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com,
 usamaarif642@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <20260406181116.4053796-1-joshua.hahnjy@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260406181116.4053796-1-joshua.hahnjy@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-15179-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 436873A8F3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/7/26 2:11 AM, Joshua Hahn wrote:
> On Thu,  5 Mar 2026 19:52:50 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> 
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> Now that everything is set up, switch folio->memcg_data pointers to
>> objcgs, update the accessors, and execute reparenting on cgroup death.
>>
>> Finally, folio->memcg_data of LRU folios and kmem folios will always
>> point to an object cgroup pointer. The folio->memcg_data of slab
>> folios will point to an vector of object cgroups.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>> ---
> 
> Hello Qi, thank you for this series!
> 
>>   static void memcg_online_kmem(struct mem_cgroup *memcg)
>> @@ -4949,16 +4985,20 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>>   static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
>>   			gfp_t gfp)
>>   {
>> -	int ret;
>> -
>> -	ret = try_charge(memcg, gfp, folio_nr_pages(folio));
> 
> While developing on top of mm-new I found that this was the last caller of
> try_charge(). I was thinking that it might be a nice opportunity to just

Yeah, we're already aware of this.

> remove the definition of try_charge() as well, maybe as a clean up patch
> at the end of the series.

Will send a separate cleanup patch later.

Thanks,
Qi




