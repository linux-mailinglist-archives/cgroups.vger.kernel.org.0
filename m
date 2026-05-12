Return-Path: <cgroups+bounces-15840-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A94DF71AmqfzAEAu9opvQ
	(envelope-from <cgroups+bounces-15840-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:39:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E877C51DE55
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AA363048F30
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088C939478F;
	Tue, 12 May 2026 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBcYMCav"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32DB3A256B
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578685; cv=none; b=bR+h3JGBFkB/hbM33fAs7sVpYPhl58mcbFzVLmXaQmWuW03p/GNZN945l+ESFd7pB3q/kQmIdced+cUoaWoG9cVoTBaLt1bEY3JvrA5hYuF9s0T4c3cu2aKsD7Zob0e7KcxypRDLA20jDWwV+kC8d2U8E2+TId3z4OJS9CDSFeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578685; c=relaxed/simple;
	bh=Nwo2TbV0fD6EXTmH2rKIOWXWBs8OkYg2xWQR+3+MReg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1e/u0AMwwCPRivo0wNMGLS8Ns/9+2o5oIdHOOtLSgJGwkM2egoeDnL1ih4Dp5fP7GK+1r34IBEvNDxghO2ZJ9jcfb0xDqTOFxUzE4/Hxj3920u3jVAIPOKFFmuK39kOwwNJ6A7qTh2IgIaZtalmxCWNmt+pvi34Rv8ynTMW4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBcYMCav; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad9a9be502so32487115ad.0
        for <cgroups@vger.kernel.org>; Tue, 12 May 2026 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778578683; x=1779183483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioBXofrBTXsmAzkxz6qRlweS7q2Y0HlvIwdOsQxLTTs=;
        b=bBcYMCavINxxQnvPURkUEZIPmrcMGnyF8t1ezJ6ZsLc27KaBj2AJW2y9bsQkCIh5p4
         lzzrN7HsaGrt8gIUcynllKMHHhoHV1DkIV8EbciyKOSGcXFy23S1iHAErtJlDycJpnLQ
         o2rV6qKC5eRFNQZdUF03jH5uiAxZEaoRJJ2Zysy5GuGQGlI+4lsYsSz31pOfjogEtqcH
         /WQvmBviQHOJKcQ1JFbayT+kfuT+SV8mFxF5va5l+lf0dW0lrph+rn1fX7qPRYeyDO9N
         80wus6sfZK6D8udtWm0c/qfx3qQhbDtone3CC5XnYvfzDlkMXs69rZa82i39N7FqLwVW
         791A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578683; x=1779183483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ioBXofrBTXsmAzkxz6qRlweS7q2Y0HlvIwdOsQxLTTs=;
        b=E5TXk5sqk4Wz5SHipmXCzjRKfevoHVd6CRr+u/SqrKAr/yVTdj7ksnn2BXaCv/xmw6
         g4Vhfb7S4aGjSeAqHaBbtlmd2GmSje+mCA5f63hP20WwBvjbZECR3yPifl/Gjexfj4HZ
         /zcHa+CoPRfJdg0ZKdRc5KwKRh88iH7Ntqfwo2200u3HbZZGq6yS/RjkHlEdKkaySzOu
         Nqk0g/2F/rWPgqgVtn+di5iAkVYwP4HZCS22YKHgDaNx824Y/2EKF2Zdwn0sJl7WG9xs
         ToQYzNOeI3QPz9jccb1badbpNgDH652vKed6Ym2PHKsalozTcnj8VXWYR95bo6RlMc1f
         EpDg==
X-Forwarded-Encrypted: i=1; AFNElJ/rzZm3kE9kJL/N+mKuy9kKNVAuIvxFaqmXeeUcq+5hcdfEkQ/FnuKvd+pdJWdRnd7rkDuDbZLi@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnIIzlBmO9ym5FiW5GcQyC5iGucU/xKlrWE+ebETQas4sRzXW
	SC6DClC9uZoSxZ9ONRVhzuasdJVbuP/sCseCLqaA1SzbkB8SPIDD9+xG
X-Gm-Gg: Acq92OEaPFMWCAip1N3w7fLsH6h+NB3kQbUm3vXcnsGeqF/LuRtun/ffyYUZ6VaZP3H
	c4UlDefZ74aOn3oI5iaLcE92DIjuGgCNVM3d1og+TZuMqvnJrAihtbLv93AAhhzvOjGhXxJcs6K
	it6DKHI9z67iyS5XpFw+Adr5U/GOinN/bnAO/DVqns4ceDFoZJGRC6S01UZ8AgUOV7FqJoR2gmq
	7P9VnAD746vlQ3r/rtMEo7E5tNxam/QrkYM708Dt+ktZy75cbcJMR2xxCCtPxQUHf1JOlF0Mgja
	NxnoO3K196LTIhEAIu1mXjId20Q4YPM51/uCNi0/SM4o5POM0RvynoyBJ67mRB023tM+c01RS4E
	mrf0+2vPUeF8gvUr4hlMMGO4rTyFwcBBOHjHzUoi1DD+mWgePGGaFQ/MGmhxA99MYK/S/zoZBHX
	RJbOUSgWvOLg/VbFHIQAh7v0NkgflNUZZSjb+4S0QgUr1c1KGR1wzG7A==
X-Received: by 2002:a17:903:94e:b0:2b2:3bb6:fbf8 with SMTP id d9443c01a7336-2bd0116e40emr24451505ad.16.1778578683270;
        Tue, 12 May 2026 02:38:03 -0700 (PDT)
Received: from [10.125.192.65] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d52ef9sm129588795ad.35.2026.05.12.02.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:38:02 -0700 (PDT)
Message-ID: <46eb7e35-0f8e-e667-1f86-f518fe699378@gmail.com>
Date: Tue, 12 May 2026 17:37:51 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] mm/zswap: Implement proactive writeback
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, yosry@kernel.org,
 mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
 <20260511105149.75584-3-jiahao.kernel@gmail.com>
 <CAKEwX=PW2+EN41ANutv4cv+iM+JpwV5V+NSp5ukAt0M6fbHFLg@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAKEwX=PW2+EN41ANutv4cv+iM+JpwV5V+NSp5ukAt0M6fbHFLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E877C51DE55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15840-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 2026/5/12 03:54, Nhat Pham wrote:
> On Mon, May 11, 2026 at 3:52 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 19538d6f169a..1173ac6836fa 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/workqueue.h>
>>   #include <linux/list_lru.h>
>>   #include <linux/zsmalloc.h>
>> +#include <linux/timekeeping.h>
>>
>>   #include "swap.h"
>>   #include "internal.h"
>> @@ -160,6 +161,12 @@ struct zswap_pool {
>>          char tfm_name[CRYPTO_MAX_ALG_NAME];
>>   };
>>
>> +struct zswap_shrink_walk_arg {
>> +       ktime_t cutoff_time;
>> +       bool proactive;
>> +       bool encountered_page_in_swapcache;
>> +};
>> +
>>   /* Global LRU lists shared by all zswap pools. */
>>   static struct list_lru zswap_list_lru;
>>
>> @@ -183,6 +190,7 @@ static struct shrinker *zswap_shrinker;
>>    * handle - zsmalloc allocation handle that stores the compressed page data
>>    * objcg - the obj_cgroup that the compressed memory is charged to
>>    * lru - handle to the pool's lru used to evict pages.
>> + * store_time - Time when the entry was stored, for proactive writeback.
>>    */
>>   struct zswap_entry {
>>          swp_entry_t swpentry;
>> @@ -192,6 +200,7 @@ struct zswap_entry {
>>          unsigned long handle;
>>          struct obj_cgroup *objcg;
>>          struct list_head lru;
>> +       ktime_t store_time;
> 
> On the implementation side - will this blow up struct zswap_entry
> memory footprint? If so, can you guard this behind a CONFIG option, if
> we are to go this route?

Thanks for the review. I'll address this in v2.

Thanks,
Hao

