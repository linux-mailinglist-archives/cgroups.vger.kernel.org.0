Return-Path: <cgroups+bounces-17748-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mHgLMLKMVWrCpwAAu9opvQ
	(envelope-from <cgroups+bounces-17748-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 03:11:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E0474FF9B
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 03:11:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=g1eB9y3B;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17748-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17748-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5E0130166DB
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 01:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C0335AC1B;
	Tue, 14 Jul 2026 01:11:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0D2DB7B4
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 01:11:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991469; cv=none; b=AtMzb+yC0PDtqdRuQjYhTCGrA5CMLHilxfBn4kFNNOsfnT7GD/pYyAqhZx49eflbbG4p5oKD7tOPGr+kKWjdVhb2k8c37OCzkBsu48YaEziCCzHQQTj8y2MqRnINu0tlBcgpx/50d1EE6tuiHmqIksrL1rxcy6tD+R9+cDYFrQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991469; c=relaxed/simple;
	bh=Mgw7NaaPuVDLHrO0U6xaVK9/AaB9d3h9em6m0az3yBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXmeJwPJDoUeYgI39C+mDom11TSqLLIDtf+qXP/u/sgVbtVkYmm4Cz1Zyua49tgENUuyvTW1HZFYQ/ydClLrUROR+KnLY9UdOog631iiVN1uRRicSS6pMpmHs4GumOK8D4AMwdtmzxYGVb9KLlsZuW5/guF0AQmHpQ7GpImoICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g1eB9y3B; arc=none smtp.client-ip=95.215.58.187
Message-ID: <9117db4b-2a7b-41f3-b5e7-db9d6343bc83@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783991464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBTuxEtzTYLRVryCNC/UKY74wgwZyisDAh2aK7ZURZk=;
	b=g1eB9y3BOcZwZblAVHaos/wcXy3DKhqfRLmswKAnzYIj7k5fLSyUOp11oj4sbNwb7qZf5D
	OVQeC6Z25fjQDNt934i+E6iM8eKME7IJcaZ32EqXAi0m56nj+UtEEi9MO7YgS4MX3WZ9ml
	YHKg9phMJ74p6SrUNcGJpNitn9lZTMc=
Date: Tue, 14 Jul 2026 09:10:46 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] mm: vmscan: fix node reclaim ignoring swappiness
 parameter
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
 <20260711091157.306070-3-ridong.chen@linux.dev>
 <CAGsJ_4xGKM3HxXw-mrtyr5HmwZL3L1QVZ27utCyozqSJr1F0gQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <CAGsJ_4xGKM3HxXw-mrtyr5HmwZL3L1QVZ27utCyozqSJr1F0gQ@mail.gmail.com>
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
	FORGED_RECIPIENTS(0.00)[m:baohua@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:david@kernel.org,m:yuanchu@google.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chenridong@xiaomi.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17748-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3E0474FF9B



On 7/13/2026 11:16 PM, Barry Song wrote:
> On Sat, Jul 11, 2026 at 5:12 PM Ridong Chen <ridong.chen@linux.dev> wrote:
>>
>> From: Ridong Chen <chenridong@xiaomi.com>
>>
>> sc_swappiness() had two separate definitions depending on
>> CONFIG_MEMCG. The !CONFIG_MEMCG variant simply returned
>> vm_swappiness, ignoring the proactive_swappiness value passed
>> through scan_control. This caused the swappiness parameter
>> written to /sys/devices/system/node/nodeX/reclaim to have no
>> effect when CONFIG_MEMCG is disabled.
>>
>> Fix this by consolidating sc_swappiness() into a single definition
>> that checks sc->proactive_swappiness first, then falls back to
>> mem_cgroup_swappiness() which already handles both CONFIG_MEMCG
>> and !CONFIG_MEMCG.
>>
>> Before fix (swappiness=max ignored, mostly file pages reclaimed):
>>
>>      # cat /proc/sys/vm/swappiness
>>      60
>>      # cat /proc/vmstat | grep pgsteal
>>      pgsteal_kswapd 0
>>      pgsteal_direct 0
>>      pgsteal_khugepaged 0
>>      pgsteal_proactive 1840
>>      pgsteal_anon 25
>>      pgsteal_file 1815
>>      # echo "64M swappiness=max" > /sys/devices/system/node/node0/reclaim
>>      # cat /proc/vmstat | grep pgsteal
>>      pgsteal_kswapd 0
>>      pgsteal_direct 0
>>      pgsteal_khugepaged 0
>>      pgsteal_proactive 18013
>>      pgsteal_anon 337
>>      pgsteal_file 17676
>>
>> After fix (swappiness=max honored, anon pages reclaimed as expected):
>>
>>      # cat /proc/vmstat | grep pgsteal
>>      pgsteal_kswapd 0
>>      pgsteal_direct 0
>>      pgsteal_khugepaged 0
>>      pgsteal_proactive 0
>>      pgsteal_anon 0
>>      pgsteal_file 0
>>      # echo "64M swappiness=max" > /sys/devices/system/node/node0/reclaim
>>      # cat /proc/vmstat | grep pgsteal
>>      pgsteal_kswapd 0
>>      pgsteal_direct 0
>>      pgsteal_khugepaged 0
>>      pgsteal_proactive 16283
>>      pgsteal_anon 16283
>>      pgsteal_file 0
>>
>> Fixes: 68cd9050d871 ("mm: add swappiness= arg to memory.reclaim")
>> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> 
> Reviewed-by: Barry Song <baohua@kernel.org>
> 
> As pointed out by Johannes, the Fixes tag should be
> b980077899ea.

Hi Johannes and Barry,

Thank you for your review. You are right, will update it.

-- 
Best regards
Ridong


