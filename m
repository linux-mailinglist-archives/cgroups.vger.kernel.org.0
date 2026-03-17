Return-Path: <cgroups+bounces-14853-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JXTFfu2uWnJMQIAu9opvQ
	(envelope-from <cgroups+bounces-14853-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 21:18:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA52B2224
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 21:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BECDF302F233
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 20:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC62385512;
	Tue, 17 Mar 2026 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ApcygpHP"
X-Original-To: cgroups@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460F31065B;
	Tue, 17 Mar 2026 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773778672; cv=none; b=OSM2QqfYi09fQsvNDe4ra7FhoVH7ntn7qW0AGY7+Rt/8ficGcpv5BZsglqXePECEAOy1fQXC/ATShyf6V7nXys+1xCL6AlPCv5PLicBI2jb4AUXDnSw8M8OdS1AraXB2qIhyTrAgD1QMlpwaytWfWWYtYykCVUEi9d7Vp6BPIfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773778672; c=relaxed/simple;
	bh=cmufDcTL+XlnrwjEPCmwsR8y8up1koqC9R78WNqqg+E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SfYGXs5+TAyG3L1LqIfkwIJBJJKGXiHi+EbE8kQ9TQsIBxWSvwMkIVo4tP092R9eqv5TDr5yhjnJepi+S1LhegdAd+MPDRIoaYhmsLuLJLFai3FqvvLxvf15xDKnaSXWtVzkOeLi/7obbwI0fayG7ShLY+AVBgAE6tp39dvBc9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=ApcygpHP; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 763D0C01B1;
	Tue, 17 Mar 2026 23:17:38 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b50::1:27] (unknown [2a02:6bf:8080:b50::1:27])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id SHT6Lg1Aj4Y0-i9H44wn6;
	Tue, 17 Mar 2026 23:17:37 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1773778657;
	bh=KTpZkYcbRbdNorzXR3SBiT4lxA2YcKe7kjGcwQ9qQ+E=;
	h=In-Reply-To:Cc:Date:References:To:Subject:From:Message-ID;
	b=ApcygpHP/MK6B1QUZFw9cpUZcLIBq7MtG1QJ2KD70SfjA/KYWP8fvk8n0lDfWXzQg
	 vNYerE2ARSv89j3nKJbnKghHLnTcTMJBc2dFlqO+ZPwuSlpe5zis3gSO55Vxjofcyo
	 7jchpQcd2voG1vGP6+zQpPVNaA7+SiN9P6Y+HMAo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <3db237d0-1ee8-44b7-a356-f3015173f7c2@yandex-team.ru>
Date: Tue, 17 Mar 2026 23:17:28 +0300
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
Subject: Re: [PATCH] mm: add memory.compact_unevictable_allowed cgroup
 attribute
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Brendan Jackman <jackmanb@google.com>,
 Zi Yan <ziy@nvidia.com>, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, yc-core@yandex-team.ru
References: <20260317100058.2316997-1-d-tatianin@yandex-team.ru>
 <20260317121736.f73a828de2a989d1a07efea1@linux-foundation.org>
Content-Language: en-US
In-Reply-To: <20260317121736.f73a828de2a989d1a07efea1@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14853-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d-tatianin@yandex-team.ru,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yandex-team.ru:dkim,yandex-team.ru:email,yandex-team.ru:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 3AEA52B2224
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/17/26 10:17 PM, Andrew Morton wrote:
> On Tue, 17 Mar 2026 13:00:58 +0300 Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
>
>> The current global sysctl compact_unevictable_allowed is too coarse.
>> In environments with mixed workloads, we may want to protect specific
>> important cgroups from compaction to ensure their stability and
>> responsiveness, while allowing compaction for others.
>>
>> This patch introduces a per-memcg compact_unevictable_allowed attribute.
>> This allows granular control over whether unevictable pages in a specific
>> cgroup can be compacted. The global sysctl still takes precedence if set
>> to disallow compaction, but this new setting allows opting out specific
>> cgroups.
>>
>> This also adds a new ISOLATE_UNEVICTABLE_CHECK_MEMCG flag to
>> isolate_migratepages_block to preserve the old behavior for the
>> ISOLATE_UNEVICTABLE flag unconditionally used by
>> isolage_migratepages_range.
> AI review asked questions:
> 	https://sashiko.dev/#/patchset/20260317100058.2316997-1-d-tatianin@yandex-team.ru

> Should this dynamically walk up the ancestor chain during evaluation to
> ensure it returns false if any ancestor has disallowed compaction?

I think ultimately it's up to cgroup maintainers whether the code should 
do that, but as far as I understand the whole point of cgroups is that a 
child can override the settings of its parent. Moreover, this property 
doesn't have CFTYPE_NS_DELEGATABLE set, so a child cgroup cannot just 
toggle it at will.


