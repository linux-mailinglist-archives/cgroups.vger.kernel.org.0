Return-Path: <cgroups+bounces-14862-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AOqN31sumnRWQIAu9opvQ
	(envelope-from <cgroups+bounces-14862-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 10:12:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 420FF2B8B9C
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 10:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA72730480BF
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 09:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166C3381AF3;
	Wed, 18 Mar 2026 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="AgJQl00u"
X-Original-To: cgroups@vger.kernel.org
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5327355055;
	Wed, 18 Mar 2026 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825008; cv=none; b=KVC7pOlDm3b2QJL0wA7KIAPSM3vUJUfswTPckwFrLsUEdbGf6DdLJrsA7WNKqZBgwWuoJ5Etu3gZN4DZKdpldsh6jv1lw9w08VZZMVt5xK94VvgAOKl+vgezXan+Fl3G+oIQ8GMM7jYuaGEF4fxIPZPTNOOxxFhmqBABH4eG8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825008; c=relaxed/simple;
	bh=WMohNM+YzlhM0/gmdxVoKhCxXW0JoElLUyM79Nt8Ahc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LXFFNTtji97ZJb6TS+pyvMHIbDrxH4QA1KiE92wdxDaLYtPwmFNjXVz1VhMcQUnl34eqYRIKv8VCPp1lHqe7cnKXpoAd17JxR/ablUzJoBw6iwDd7zIn//3gJb/pPKBGhjcU0p8fHSErpE9ePh6kdDGhLZuKgunJl4THOSg4Ec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=AgJQl00u; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 9540680806;
	Wed, 18 Mar 2026 12:10:02 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d76::1:28] (unknown [2a02:6bf:8080:d76::1:28])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id o9JDNh1AXiE0-EFkoaFuP;
	Wed, 18 Mar 2026 12:10:02 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1773825002;
	bh=Dd6XuJPnjneivtZklB4CYKV3hfCWaJbiOvdtqzCZpqU=;
	h=In-Reply-To:Cc:Date:References:To:Subject:From:Message-ID;
	b=AgJQl00uzHvhiHvMFORXwfVabAMbbRCujyEsBYWu+dl/BxpsSs//071PjmXu10U6n
	 jEvUghw81a35PlbiT+4Oz24oszL98VrNwF9y3njPbiXqBgHjN+tNlIPQbh4nBE7PI4
	 HYEPam99qmn9C+4OM9RPULoZjBoGYVRLQdg0fIdg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <444bb4c3-11c9-4e84-be1f-909f2383559e@yandex-team.ru>
Date: Wed, 18 Mar 2026 12:09:50 +0300
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
Content-Language: en-US
In-Reply-To: <abphjNOYaNslTA90@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14862-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d-tatianin@yandex-team.ru,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 420FF2B8B9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/18/26 11:25 AM, Michal Hocko wrote:
> On Tue 17-03-26 23:17:28, Daniil Tatianin wrote:
>> On 3/17/26 10:17 PM, Andrew Morton wrote:
>>> On Tue, 17 Mar 2026 13:00:58 +0300 Daniil Tatianin<d-tatianin@yandex-team.ru> wrote:
>>>
>>>> The current global sysctl compact_unevictable_allowed is too coarse.
>>>> In environments with mixed workloads, we may want to protect specific
>>>> important cgroups from compaction to ensure their stability and
>>>> responsiveness, while allowing compaction for others.
>>>>
>>>> This patch introduces a per-memcg compact_unevictable_allowed attribute.
>>>> This allows granular control over whether unevictable pages in a specific
>>>> cgroup can be compacted. The global sysctl still takes precedence if set
>>>> to disallow compaction, but this new setting allows opting out specific
>>>> cgroups.
>>>>
>>>> This also adds a new ISOLATE_UNEVICTABLE_CHECK_MEMCG flag to
>>>> isolate_migratepages_block to preserve the old behavior for the
>>>> ISOLATE_UNEVICTABLE flag unconditionally used by
>>>> isolage_migratepages_range.
>>> AI review asked questions:
>>> 	https://sashiko.dev/#/patchset/20260317100058.2316997-1-d-tatianin@yandex-team.ru
>>> Should this dynamically walk up the ancestor chain during evaluation to
>>> ensure it returns false if any ancestor has disallowed compaction?
>> I think ultimately it's up to cgroup maintainers whether the code should do
>> that, but as far as I understand the whole point of cgroups is that a child
>> can override the settings of its parent. Moreover, this property doesn't
>> have CFTYPE_NS_DELEGATABLE set, so a child cgroup cannot just toggle it at
>> will.
> In general any attributes should have proper hieararchical semantic. I
> am not sure what that should be in this case. What is a desire in a
> child cgroup can become fragmentation pressure to others.

 >
 > I think it would be really important to explain more thoroughly about
 > those usecases of mixed workloads.

I think there are many examples of a system where one process is more 
important than
others. For example, any sort of healthcheck or even the ssh daemon: 
these may become
unresponsive during heavy compaction due to thousands of TLB invalidate 
IPIs or page faulting
on pages that are being compacted. Another example is a VM that is 
responsible for routing
traffic of all other VMs or even the entire cluster, you really want to 
prioritize its responsiveness, while
still allowing compaction of memory for the rest of the system, for less 
important VMs or services etc.

 > Is the memcg even a suitable level of
 > abstraction for this tunable?

In my opinion it is, since it is relatively common to put all related 
tasks into one cgroup with preset memory limits etc.

 > Doesn't this belong to tasks if anything?

I think it would be very difficult to implement as a per-task attribute 
properly since compaction works at the folio
level. While folios have a pointer to the memcg that owns them, they may 
be mapped by multiple process in case
of shared memory. We would have to find all the address spaces mapping 
this folio, and then check the property on
every one of them, which may be set to different values. This may be 
problematic performance-wise to do for
every physical page, and it also introduces unclear semantics if 
different address spaces mapping the same page
have different opinions.

(resend because of html formatting in the previous email)

