Return-Path: <cgroups+bounces-14867-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHT6ISx6ummTWwIAu9opvQ
	(envelope-from <cgroups+bounces-14867-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 11:10:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CF52B9A9F
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 11:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD0783014110
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E7A3A7846;
	Wed, 18 Mar 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="RP2fJK9Q"
X-Original-To: cgroups@vger.kernel.org
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E13B583E;
	Wed, 18 Mar 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828530; cv=none; b=UpMUjQdER89SCA/4BQrJggvPnl6DRCBF81ZrtzWr96ObOkmNh5MnevI3iMF+wDuMH1XqbnkIX+NasqsmN9ooDBXCRBe/cphqtvx/N0y46Y+9bKvc+DhDXjTXcneloB8j7O9nCPyrOqqvp1nb+wcnwrvktyNARg7js2hfWzYnUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828530; c=relaxed/simple;
	bh=lAKCsUESusrvTiiXivO62NQeQo0GCTP7AN+sqhkA+BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQU8QNIgC5geNEyJYY6g44RZiO15x97B18YS/GRf5ujLNrWn3COdMYZ/x8gzzktQDHN4a+qq/BpnHzqWXkbN3wkiIxTjLkIdX1NlsOaLCdZtcj7Qk0cfu7TL6X8fxCETvYn8jzguyjb1vat6nlIv30tMbG9SFdb1x3/Z8ENsvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=RP2fJK9Q; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A1FC580720;
	Wed, 18 Mar 2026 13:08:34 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d76::1:28] (unknown [2a02:6bf:8080:d76::1:28])
	by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id V8KPvu1Aka60-RYge9HYj;
	Wed, 18 Mar 2026 13:08:34 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1773828514;
	bh=/UYl0wznLJWGqNkj7uK+GNRr0a5dPYQcnw33o6x4SnE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=RP2fJK9QMV9DI3DIYbpl2gXRektdNtQ0uUySwjAUUsKpm2gMrUJieKw5VeHWdFprO
	 e+YYMyJpw5rrcAogL3qaBI2g6tPjN0ZlOSkk5fMKsJtivBgqnFdGVBkIUvLjebGulE
	 rwmv/t5PjzSJkGLNNm5FndLJLBM714B52zpR5wS0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <b9ceff32-1f8f-454e-84ce-b8788b3a4952@yandex-team.ru>
Date: Wed, 18 Mar 2026 13:08:31 +0300
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
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <abp3-iJbazCpygIm@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14867-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,yandex-team.ru:dkim,yandex-team.ru:mid]
X-Rspamd-Queue-Id: 06CF52B9A9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/18/26 1:01 PM, Michal Hocko wrote:
> On Wed 18-03-26 12:25:17, Daniil Tatianin wrote:
>> On 3/18/26 12:20 PM, Michal Hocko wrote:
> [...]
>>> Shouldn't those use mlock?
>> Absolutely, mlock is required to mark a folio as unevictable. Note that
>> unevictable folios are still
>> perfectly eligible for compaction. This new property makes it so a cgroup
>> can say whether its
>> unevictable pages should be compacted (same as the global
>> compact_unevictable_allowed sysctl).
> If the mlock is already used then why do we need a per memcg control as
> well? Do we have different classes of mlocked pages some with acceptable
> compaction while others without?
>
The way it works is mlock(2) only prevents pages from being evicted from 
the page cache by
setting unevictable | mlocked flags on the page. Such pages, however, 
are still allowed for
compaction by default, unless /proc/sys/vm/compact_unevictable_allowed 
is set to 0. That
property essentially "promotes" ALL such (unevictable) pages to a new 
synthetic tier by
making compaction skip them. The per-cgroup property works similarly, 
however, it allows
the scope to be much smaller: from a global setting that promotes 
literally ALL unevictable
(mlocked) pages to this tier, to only promoting pages belonging to the 
cgroup that has
memory.compact_unevictable_allowed as 0.


