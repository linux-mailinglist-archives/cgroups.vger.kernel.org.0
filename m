Return-Path: <cgroups+bounces-16493-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C6gD+I1HGoeLgkAu9opvQ
	(envelope-from <cgroups+bounces-16493-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 15:21:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B58616579
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 15:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70678301C948
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A30B37D12D;
	Sun, 31 May 2026 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="sgczBqkd"
X-Original-To: cgroups@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4637DEA5;
	Sun, 31 May 2026 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780233676; cv=none; b=idQBJ/eKPC/jwLREBYN9RA+1ovuvnZ62hjFqkys0gZVn/ZsdZd6SM4lLMt5CaT0hEfB/z1iumm6ImGzuOuz2B/GF71rqth9chueI5X5qUFuuQPsMsp/pSW/GiWu+bCJs1XxacLEGrO6wvZ7kUt4c+A5MUu60+i95NPqs6TNI2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780233676; c=relaxed/simple;
	bh=NkLCDZo9LXRsqGOBgH+sOjw6Gdn5zu9MDMJG65v58e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQk75OjBMWqrobGd18p32MdFbsP5mxm7//t7B9MYAvo+0TzDtXbm0pFMW/Z1z83gCAyzevU6AefCbUV2K5c11Sv2eqCLwU152tEvc7cJ37XCfkEi4/jbYqindjJfCouKAO7Yukc744QzF5jPABoQEBTQ2Yv3V136E34Ch/5WOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=sgczBqkd; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780233669; bh=efWFEnx7JHA1iJHj3hsJgYHoiM9riuCLtXcPELWGRgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=sgczBqkdr3QIheLi1hWDVXZQDPpnacUxk9PExrnbL73WyOlu31ZrRRAS60ojrXyrz
	 0HakI3VAwFLAFyW9hojSi47VfDw3VGnWwPotztFBQyh+9zkawI5T2kyIdgpMYRRJ+z
	 9eF4hgbkYlF18wha3h9bxJVv/Qki+ZNmI4yBKwI8=
Received: from [10.24.9.42] ([123.112.11.230])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 545B08F2; Sun, 31 May 2026 21:21:05 +0800
X-QQ-mid: xmsmtpt1780233665tekiqghxd
Message-ID: <tencent_2C7744E4A6CB428C4BEA795851797EC38305@qq.com>
X-QQ-XMAILINFO: MTEKjEyAppcsB61xgzFKItQrQiTS8NoRA7KAQHHenjoWVIV1MGPmpeZrAbqeqW
	 7cvHDOx6eM/Ju24trFSDlWAZWvkGkeYC5p+qSjUFt0iNKZrG15pM61nRvh9+64Tp/LcFY95qmXVb
	 uDs9dRGyMdcWh/Q3OCyLiBbkXEpsqXdwwF1blDxNXBqZdt3mX38jLrH5avRc6Vafcnrmf3QyNGFn
	 AV1rjZqOTXD9aH9fPsTAtp0m53IP3+JRRZYI1mkd65PeVnW7zALRmZDvhAH27D87EZIPPcL0kDMY
	 bYkA5TDIvPApx6eRHRRZZoMDrrg/JP3ldBld/WOl8z3SF+mmjTPXNBDmUhzIrkF/peLwJMzXhHK1
	 eciPQ4ptjrk2RtZ+7ntyAAoNonr35NDDHI29c5JExB1WBIqgQs3BvW83rHZEK6HTuhMVadGfWI7x
	 l+ovaPfd9Za6EWKr9UgU5Zk905b3B7VjRqwNMteo/JOhymgAbENT858ml6g+xvGLfH1UeSuqhZdN
	 1GkzHl58H2er7/IjMzXU3UOkEsXVjDuEWpb3vj7VvXv7PCp7oHIJsrKuGJ2qC4SrrolZijWJdqwY
	 YOuPYqmX2keVDIeU00LjYFMTDs+HgobhTyJHy55oj7QKtFO66EQl4aUdCwKySa/sufXQzQXlORrN
	 cHO1mYeYOYcz28IsWaWY+M7Oxs5bCkMHyGmMPZeighr466YbhguwOiF6rdMBg+W+45Bf5YUulVIf
	 fPH/aHSvq4/op2Sfu4nzEDh8Amj5u+EhZKzqD9UXYNVBBv2pIrLfkX9SljZvCnRauooWjtzvcuiO
	 PD0Mqeha1S9NVXM/AVsqJmR5Bjqpk9CUbcJ4JOBhACaFdjEI2ihKR70wZQSDKpuxO3xI1ygH7Xz6
	 rCKeNjpQdF2KyZlHG0gm8pKD5z7BJHg38to6PNOnodzbDKh7ya1oulzivAboeW4PGY6iqa7zeBRN
	 SWTcuoz5jZTPVn7Sj2VqCcSnDMSc2qna9cazJOwwdOgyYVZcbHCctcD5BnkV+hn1NG5DEc52u7bU
	 EW2EEN9mlatNYtX7BwkrMXcKVYQjKCIzlg1I90Ip6cTEf3xyvCTEWML0pRSXscMW8xSHi24PGtbD
	 XE7/ZDlt4qhceHqMzRYhhRCrCTlTONRlqZl7gm
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-OQ-MSGID: <7fd6bf26-5c45-456c-b6d5-b5e8e1a15fea@qq.com>
Date: Sun, 31 May 2026 21:21:05 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 9/9] docs: mm: update THP swapin counter
 descriptions
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@meta.com>, Kairui Song <kasong@tencent.com>,
 Usama Arif <usamaarif642@gmail.com>, Chris Li <chrisl@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>,
 David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
 <tencent_0F6F682C60B99E9E0F1553E6BF3D86468409@qq.com>
 <CAKEwX=NDfJud3FM4Y+Ek3RtTtwi2aXWeDCujNxh2ReUEq-m4oA@mail.gmail.com>
From: Fujunjie <fujunjie1@qq.com>
In-Reply-To: <CAKEwX=NDfJud3FM4Y+Ek3RtTtwi2aXWeDCujNxh2ReUEq-m4oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16493-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[qq.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_MUA_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,meta.com,tencent.com,gmail.com,kernel.org,cmpxchg.org,google.com,linux.dev,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fujunjie1@qq.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,qq.com:mid,qq.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B1B58616579
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/30/2026 2:37 AM, Nhat Pham wrote:
> On Fri, May 29, 2026 at 5:19 AM fujunjie <fujunjie1@qq.com> wrote:
>>
>> The THP swapin counter descriptions still describe large swapin as
>> coming only from non-zswap swap devices. Update them now that
>> zswap-backed large folio swapin can also increment swpin.
>>
>> Also describe policy and backend rejection as swpin_fallback cases,
>> since speculative zswap large swapin can intentionally fall back before
>> doing large IO.
>>
>> Signed-off-by: fujunjie <fujunjie1@qq.com>
>> ---
>>  Documentation/admin-guide/mm/transhuge.rst | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index 23f8d13c2629..59b7a0d09243 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -667,13 +667,14 @@ zswpout
>>         piece without splitting.
>>
>>  swpin
>> -       is incremented every time a huge page is swapped in from a non-zswap
>> -       swap device in one piece.
>> +       is incremented every time a huge page is swapped in from swap or
>> +       zswap in one piece.
>>
>>  swpin_fallback
>> -       is incremented if swapin fails to allocate or charge a huge page
>> -       and instead falls back to using huge pages with lower orders or
>> -       small pages.
>> +       is incremented if swapin cannot use a huge page and instead falls
>> +       back to using huge pages with lower orders or small pages. This can
>> +       happen because allocation or charging fails, or because policy or
>> +       backend state rejects a speculative large swapin.
> 
> I think we should add separate zswpin and zswpin fallback counter for
> THP rather than overloading swpin. We already do that for zswpout vs
> swpout.

that makes sense.


