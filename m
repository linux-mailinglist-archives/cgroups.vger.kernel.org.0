Return-Path: <cgroups+bounces-17749-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hv/zLtWOVWpAqAAAu9opvQ
	(envelope-from <cgroups+bounces-17749-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 03:20:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F36E7500C6
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 03:20:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=aLPVtxei;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17749-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17749-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3BF63017F8E
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2735F162;
	Tue, 14 Jul 2026 01:20:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359EF207DF7
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 01:20:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783992017; cv=none; b=QMZGpQpT0NHZJkqTkC/p3GI1PqdPVP3TNIyZThG+IjyYOtcb3wTt7FNCoeyfTXguQQIxIF6wKWEfDbw5LzHWq4vy6L0NgZX0OEZA6+Kg95LXHQVBansbfn7LE6wsgii6qf9E9/xyu3Tsa502uv30OeHe+MjgacdiyYcWMdO2G3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783992017; c=relaxed/simple;
	bh=PkJdQaEDMEfonIw8EEkQse6zdo9BDrmz2jybU6BcgoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+06Lxfa4N1i45fpuNjOwGE109Gd+UKY+eGoaJCc1XInSM+xkqLHz8xOmn7nkfc5K2IrilXg8fezO/MEhjQ1srJKVznk+SSPJJTsI5rXftWqIahQlJSi951KdR7zHPIWFwm9DPiEHXgh25RaZdmQVTHWaRIiR2UuyPPHdDsf8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aLPVtxei; arc=none smtp.client-ip=95.215.58.186
Message-ID: <87dc4105-b98b-4541-bafe-c0adfbf58836@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783992013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZctEu+mX1koEkj7iSspmtkQvsQ427myBTirKB+Ofv9Q=;
	b=aLPVtxeiDDTh4DfW/RDii/1ZK3BCZDRA8W8VefSwdDDRhy2veEza0ita+eFrzjWOY5Bk0U
	vLbN3hjYA6Wa1jSjTAKTmZn8V8wZFSNkQ3PzQuisAK1lml21UZjnDRdvQqr8v7DUdU0XZf
	mMwk10gxE/Gqd1uGn2LmMbIK2S+jeTg=
Date: Tue, 14 Jul 2026 09:19:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] memcg: move mem_cgroup_swappiness to memcontrol.h
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 David Hildenbrand <david@kernel.org>, Yuanchu Xie <yuanchu@google.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ridong Chen <chenridong@xiaomi.com>
References: <20260711091157.306070-1-ridong.chen@linux.dev>
 <20260711091157.306070-2-ridong.chen@linux.dev>
 <CAGsJ_4y39eSYqYwSPzqcZPk1wcJEYN3HZr83MPv8pMgN8Nct5A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <CAGsJ_4y39eSYqYwSPzqcZPk1wcJEYN3HZr83MPv8pMgN8Nct5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:baohua@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:david@kernel.org,m:yuanchu@google.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chenridong@xiaomi.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17749-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F36E7500C6



On 7/13/2026 11:08 PM, Barry Song wrote:
> On Sat, Jul 11, 2026 at 5:12 PM Ridong Chen <ridong.chen@linux.dev> wrote:
>>
>> From: Ridong Chen <chenridong@xiaomi.com>
>>
>> The per-memcg swappiness knob is v1-only; v2 always uses global
>> vm_swappiness and ignores the per-cgroup field.
>>
>> Guard memcg->swappiness with CONFIG_MEMCG_V1, and move the helper
>> to memcontrol.h where it belongs.
>>
>> No functional change for v1; v2-only kernels drop the unused field.
>>
>> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Barry Song <baohua@kernel.org>
> 
> With some nits.
> 
>> ---
> [...]
>>          struct mem_cgroup_per_node *nodeinfo[];
>> @@ -365,6 +366,9 @@ enum objext_flags {
>>
>>   #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
>>
>> +/* Defined in mm/vmscan.c; used by mem_cgroup_swappiness(). */
>> +extern int vm_swappiness;
> 
> This is a bit unusual. I'm not sure whether mm/swap.h would be
> a more appropriate place for this.
> 
Thank you for your reply.

The vm_swappiness variable is not utilized within mm/swap.c. 
Furthermore, since memcontrol.h does not include swap.h, retaining the 
extern int vm_swappiness declaration in mm/swap.h will result in a 
compilation failure.

-- 
Best regards
Ridong


