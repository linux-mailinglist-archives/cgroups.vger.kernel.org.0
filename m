Return-Path: <cgroups+bounces-14870-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBb8D3ixumkVawIAu9opvQ
	(envelope-from <cgroups+bounces-14870-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 15:06:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D27EA2BC9F2
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 15:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F0C2304B0E7
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EC43D9DC0;
	Wed, 18 Mar 2026 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="NqGwoo7E"
X-Original-To: cgroups@vger.kernel.org
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E723DA5C8;
	Wed, 18 Mar 2026 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842643; cv=none; b=jfaXmQk4D7GQ/L+2525Hv3KfqG+RpuyiPNaT734mUNOleX301TggZZwKNvJ/ugq50UyzrOGop2A70INDi++cdDm7L7qZhSBLuklN7o6DJZWzAUHOTJ6R23YubSUW6H1D6Kck4zddRVpLsbdIvr/fgpoWf/eNTJtyFzzwRPI63es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842643; c=relaxed/simple;
	bh=sfpQlmzi8XIO8dyc6J7Ix6rk3VbGhGTXXBtU4Sy/NoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7BDcmyV1wrgGCtAbMcewD/MlBJk5TMxEjTCBPYGp8IUa9+1kMwv7LojPeRSLh05gO8YKb2Y/Mm+5g3PBNgxdoPKXIb8IGjBBAq3YJuz7lWvRyQvAH8MqqQbecowdtU4OrYrM/la6qwJlcGRgGhCYXfdueubP+firxxxnUOJAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=NqGwoo7E; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2DDEA809A3;
	Wed, 18 Mar 2026 17:03:56 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:468::1:1d] (unknown [2a02:6bf:8080:468::1:1d])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id r3O3Wn1AbuQ0-qkysLZc0;
	Wed, 18 Mar 2026 17:03:55 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1773842635;
	bh=wLXuKk78ioQLYQFMsgepJ5ZTbB+d4wSbD7IxAZxX5mc=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=NqGwoo7EgAjZiGAH2FZFPKJouSGf5sF4gkg32G8gy0jmPyIRIphmpS04HnUJ/uaPV
	 TMZn/E9VX1ehMBkY+CfY96KAe7IZRiQG2352SUP4UP8LAv/xvqyXNqAmjGPtMoO+Qw
	 Z6iWzjXtC8Qoa+sQ60Nv/OL2IRpCo0rQl1XffSSA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <fd7409a3-5f8c-492b-836d-559b001a61dd@yandex-team.ru>
Date: Wed, 18 Mar 2026 17:03:53 +0300
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: add memory.compact_unevictable_allowed cgroup
 attribute
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
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
 <3db237d0-1ee8-44b7-a356-f3015173f7c2@yandex-team.ru>
 <abphjNOYaNslTA90@tiehlicka>
 <7ca9876c-f3fa-441c-9a21-ae0ee5523318@yandex-team.ru>
 <abpue_k_9mjQAP6X@tiehlicka>
 <73322279-c6f8-4319-827b-938c20c96b9b@yandex-team.ru>
 <abp3-iJbazCpygIm@tiehlicka>
 <b9ceff32-1f8f-454e-84ce-b8788b3a4952@yandex-team.ru>
 <abqQtcNqxzxiZyf1@tiehlicka>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <abqQtcNqxzxiZyf1@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14870-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,yandex-team.ru:dkim,yandex-team.ru:mid]
X-Rspamd-Queue-Id: D27EA2BC9F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/18/26 2:47 PM, Michal Hocko wrote:
> On Wed 18-03-26 13:08:31, Daniil Tatianin wrote:
>> On 3/18/26 1:01 PM, Michal Hocko wrote:
>>> On Wed 18-03-26 12:25:17, Daniil Tatianin wrote:
>>>> On 3/18/26 12:20 PM, Michal Hocko wrote:
>>> [...]
>>>>> Shouldn't those use mlock?
>>>> Absolutely, mlock is required to mark a folio as unevictable. Note that
>>>> unevictable folios are still
>>>> perfectly eligible for compaction. This new property makes it so a cgroup
>>>> can say whether its
>>>> unevictable pages should be compacted (same as the global
>>>> compact_unevictable_allowed sysctl).
>>> If the mlock is already used then why do we need a per memcg control as
>>> well? Do we have different classes of mlocked pages some with acceptable
>>> compaction while others without?
> OK, I have misread the intention and this is exactly focused at mlock
> rather than general protection of all memcg charged memory. Now
>
>> The way it works is mlock(2) only prevents pages from being evicted
>> from the page cache by setting unevictable | mlocked flags on the
>> page. Such pages, however, are still allowed for compaction by
>> default, unless /proc/sys/vm/compact_unevictable_allowed is set to 0.
>> That property essentially "promotes" ALL such (unevictable) pages to a
>> new synthetic tier by making compaction skip them. The per-cgroup
>> property works similarly, however, it allows the scope to be much
>> smaller: from a global setting that promotes literally ALL unevictable
>> (mlocked) pages to this tier, to only promoting pages belonging to the
>> cgroup that has memory.compact_unevictable_allowed as 0.
> This is clear but what is not really clear to me is whether this is
> worth having as mlock workloads are already quite specific, the amount
> of mlocked memory shouldn't really consume huge portion of the memory so
> you still need to have a solid usecase where such a micro management
> really is worth it. In other words why a global
> compact_unevictable_allowed is not sufficient.

In my opinion both mlocked memory and non-compactible memory have the 
right to
co-exist on the same host without a global switch that turns one into 
the other. I agree
that it's not a super common thing, but I still think it can be beneficial.

Some examples include but not limited to: security: so that sensitive 
data is never swapped
to disk yet we have no problem if it gets compacted and the actual 
physical page gets replaced,
performance for some apps: so that we can e.g. memlock a large binary in 
memory to keep it in
page cache and improve startup time, but again don't care much if the 
actual backing pages are
replaced via compaction.

On the other hand, some critically important/real time applications do 
need protection from compaction
as well on top of the regular mlock, so that they have predictable 
latency and response time, which can
really fluctuate during heavy compaction. Both of these cases can 
coexist on the same physical machine.


