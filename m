Return-Path: <cgroups+bounces-16332-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LzFHF5ZFmo9lgcAu9opvQ
	(envelope-from <cgroups+bounces-16332-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 04:39:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C625DEA03
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 04:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C549E3033AFF
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 02:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD58351C22;
	Wed, 27 May 2026 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayI+kl0C"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A8275848
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849561; cv=none; b=aaxHK7mDzzEevPnbuwPZm3DtIqfQKOdEEH+XYKKYVQIUr4VXWsY1I1Onskr5aooz3qlzVwzyAYqFwPd0zBcJ+TFWkpmQIr6fEo1UbtNQjWKIn/cvlkWgLFkKDe6bMwSuLAd2J/UTRh3wa/khxaUCMrrluw/C99mb014Bx54tuO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849561; c=relaxed/simple;
	bh=YLHSJWtNRRKULvHiEhk/EuOJw3HGQnVcZ8LNPxAwLsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdu1AOWNxMFVwT1ZF9ds9Cj2/hnem36RU03EenGiyWIHpGr2z6um43XD6DHFzZaUIV6K71jtPGa2pABRqwBKRtwtB15HQHEgLwPBUD1J+P1kLWgygDWtfFZ46N+OsJLHV16YRF6pYrH9H9y4Heg4yaGGuQXtkLCEptUUw4+WCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayI+kl0C; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36ac67f489aso2098455a91.0
        for <cgroups@vger.kernel.org>; Tue, 26 May 2026 19:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779849559; x=1780454359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGwC6eNLghO2bBmS4gKEtdX6PelNtfsnZTEHkZ16hk4=;
        b=ayI+kl0CLKR5VSJ/Gf/s2mKDwbNBp9KiF4qPKCWfFUMVYKppunHFJqLVvNZHY18c19
         FX3jelKC9mzQhdh5RsupERasj63J30hN/P9toP0ciMSWINYKJQ9USeGqdH8av5IIZifF
         7Rpql11t9M9ZApGvsu1/WtmzrlOp/rkyx86pHSBAUhMLRkCcr7zYxxPHYflfXs4l8lNB
         i3DgcszCgaAq4ePyL8AvyFy/DCykRrmB6CC3eJ73lwJB5blQYd2wrQiUrWMHZOLoXXYa
         Dj46b3bJOhwtZKdh90zSRe0Na1qOUvi85/mokKjOvDfUkbpBnAgS8aidM8H5Cfppwxss
         ex3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779849559; x=1780454359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGwC6eNLghO2bBmS4gKEtdX6PelNtfsnZTEHkZ16hk4=;
        b=k9nQ2e1zE9wjG43rX7KGZ5u50Ps1K42s/kQUR1c+ohgfkqrtKkpHnWYAR4OPrzbzVz
         kZuTa8KwYT5liU8k++kSlCmjLKxlYogkiU7bUwvyXl1712lSbxtMA591DK6YAaepUVHC
         TXLZi1j9U5EWOhQp9C3ff6qOsyt/F5q4QAhGTyiPhxYbQc6JWU0DmL3pI5X/cG8CZlwe
         nIt4KKVRFuSzq20pUR1a/u/Vl6egfAv0g4lSDK2h6BeBnTzSgCY90ufuxOu5FXz9ihy5
         bZNIqH2TjkN5ouQn6Aq3sqtCP5jLgnTwTHDQAJMeLPlPW4S2mWL5sd/6JAkOC8qnLJRc
         a9vw==
X-Forwarded-Encrypted: i=1; AFNElJ/UuPmSTRVxBJ4r5IfSLE5QOitwR7RzSRJrJtqOvXLijmeBFJzM4Lza7kDQ22odda2rtSYJ0LIG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0h5c5CNJr4GMYeSsc3kYEF6T7uwnBvbcjWFYj9TEgSlpigx2A
	jm1JYneYlyciUdJsvx3+xhul9GlulhYuHK+wV5HGaJSEjG2W0MqdUim4
X-Gm-Gg: Acq92OHxp1q/SCkgIaq5SENMlOQQ/42zQFqNBRMPkWPIMQr+kg+CobePt7lHb1x+77y
	hHS/gDnbVWSPMjSLtU5+amI2R+YwG4Mt/7EJAe10L8mmtZdXb3pQZiOvYF8o54rCGywJpr4kIMB
	zBB7ltk1RoKiCurKBlhD791QtMwMdAIS8VARc0URf+5cmm9wx0L3/C2T0JHboBovNZc3AbiIqlU
	/zh1lcRyHbztpkQu6lzZUdsegmaOH6oj1WXGMH2IFdxvRDG09Xh0CeQPS66sy2+3TVm7WkzpBw/
	OQ9rcpDO6GfJKjBbFpYhF+cX9eqCoeXPDEWyou7fVshBsZClfQv1nRvGTvB3RYI9qB4aCOV8nKK
	VDYYr5JigBzlhdA0uidHsvf+cSmQBL58GsNjlkpxsrlYZFQegAKUIo3oq+JlzxOLPY84vGHhls+
	hTytK/MICIdpjhF4Z9985+ojyAH9l5+OSSMCqmem8NDIH6ukW5G/4fHAQ=
X-Received: by 2002:a17:90a:ac10:b0:36a:5b56:5c1d with SMTP id 98e67ed59e1d1-36a5b565cf7mr12903624a91.11.1779849559393;
        Tue, 26 May 2026 19:39:19 -0700 (PDT)
Received: from [10.125.192.130] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202b946dsm11616672a12.13.2026.05.26.19.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 19:39:18 -0700 (PDT)
Message-ID: <8eea0a0d-615f-ff72-b019-0634a5f1028b@gmail.com>
Date: Wed, 27 May 2026 10:39:08 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 0/4] mm/zswap: Implement per-cgroup proactive writeback
To: Yosry Ahmed <yosry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org,
 hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org,
 mkoutny@suse.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 muchun.song@linux.dev, roman.gushchin@linux.dev, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20260525122242.36127-1-jiahao.kernel@gmail.com>
 <20260525122424.3b2818f06832d9d55da8d69b@linux-foundation.org>
 <9b2ac88c-a67f-2512-d898-3dadd50ec03e@gmail.com>
 <CAO9r8zO1+brQroYufMZ2K=ZH_PBBpzYPsdYm-DT3K2GxoKJs9A@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAO9r8zO1+brQroYufMZ2K=ZH_PBBpzYPsdYm-DT3K2GxoKJs9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	TAGGED_FROM(0.00)[bounces-16332-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 29C625DEA03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/5/27 02:55, Yosry Ahmed wrote:
> On Tue, May 26, 2026 at 4:56 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>
>>
>>
>> On 2026/5/26 03:24, Andrew Morton wrote:
>>> On Mon, 25 May 2026 20:22:38 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:
>>>
>>>> Zswap currently writes back pages to backing swap reactively, triggered
>>>> either by the shrinker or by the pool reaching its size limit. Although
>>>> proactive memory reclaim can automatically write back a portion of zswap
>>>> pages via the shrinker, it cannot explicitly control the amount of
>>>> writeback for a specific memory cgroup. Moreover, proactive memory reclaim
>>>> may not always be triggered during a steady state.
>>>>
>>>> In certain scenarios, it is desirable to trigger writeback in advance to
>>>> free up memory. For example, users may want to prepare for an upcoming
>>>> memory-intensive workload by flushing cold memory to the backing storage
>>>> when the system is relatively idle.
>>>>
>>>> This patch series introduces a "zswap_writeback_only" key to memory.reclaim
>>>> cgroup interface, allowing users to proactively write back cold compressed
>>>> pages from zswap to the backing swap device. When specified, this key
>>>> bypasses standard memory reclaim and exclusively performs proactive zswap
>>>> writeback up to the requested budget. If omitted, the default reclaim
>>>> behavior remains unchanged.
>>>
>>> Thanks.  AI review found a few things to complain about, one of them
>>> described as "preexisting".
>>>
>>
>> Thanks Andrew.  I have replied to the AI's review comments in a separate
>> email and posted v3.
>> https://lore.kernel.org/all/20260526114601.67041-1-jiahao.kernel@gmail.com
> 
> Generally speaking, please give time for reviewers to take a look
> before sending a new version. Less than a day is usually too fast
> (unless you're iterating super fast with the reviewers). Review
> feedback does not have to be addressed immediately, usually wait for a
> bit to collect as much feedback as possible before spinning a new
> version.
>

Thanks for the advice, Yosry. Got it.

> I will take a look at v3 soon, thank you.

Appreciate you taking a look at v3.

Thakns,
Hao

