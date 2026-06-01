Return-Path: <cgroups+bounces-16514-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL3OBYpoHWrqaAkAu9opvQ
	(envelope-from <cgroups+bounces-16514-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 13:10:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7455F61E1CA
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 13:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 242D33037BD4
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CFB392823;
	Mon,  1 Jun 2026 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJU5S+cl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB6352031
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312079; cv=none; b=XCPLFTfyF+JTrQbei2Gkt9pQbf7/bb6eilfrKFbqhULVICLw7y6SE0dhUxFLxgsNfHDELk/eVhdDmn1inMLmhVtFfFs+e2LTGX6OJ3OiYMCglmWXoobDzMCl7NklKpft/dneFG5POPVAQtDQmGSjRzxkW3hm7nOgKtvXfQJztCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312079; c=relaxed/simple;
	bh=rcUHPa2Utkg2qJhsQAPGPqiFCC8vSAwthtAZw8HMx0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqmRtaYOqUDUmKWGSWy4v33BQUeOwZb2sooJxvFJEkuqNQGyrv5k16xaG8Vo2+4wpNEtohPs0Wk+RahmwGeN6u8gvlJO3sR3aMnwhfLW78nybGhEcVenwD0K4CnPbRvtvk5gbl3vvKWI+UmOEeUYXxzHueZM43oB8ZyZITRDFCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJU5S+cl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8421f0e9c5bso828804b3a.3
        for <cgroups@vger.kernel.org>; Mon, 01 Jun 2026 04:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780312078; x=1780916878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tMRr0555UkSJVpwevwwfR/bu9FaT1rWJqjveLdcveY=;
        b=pJU5S+clkHKm2xT0spxPXWej3z9/XozPb81eCUvJQdPnOZoZmt/8jdVtla3CUYZl39
         hGszEu9Zlzw4NH8gEfmL4Xs4GYxAO4WM9bldkwDgIXJMBCKkCKROfVlFAcHo0Y/GEOo8
         KODpkulcdM0kTEyh45wBj26QujY/vLzad6NkOzGKvnPMSGsaUa5GZOWQQ4oK7B1lScC2
         6dWbBml8ag4wJf6XQdcOBKXi4tNUridWTP7HJiGpYylBgDx0JTNj6l6L2GiWjlLnex+d
         +sCxJ1x71sGERjmlfEGFjHkrZMo+VoSDl0uV3ERoUWojLHCGvqWL82BRr5180NIuUXdA
         Luew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780312078; x=1780916878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tMRr0555UkSJVpwevwwfR/bu9FaT1rWJqjveLdcveY=;
        b=bu5+S31gD/Lv6nXVAI2R1UMFb+FAy2K00OrWsskXG4JahLbcsxIbTwtol80J3LbCc1
         RUUZzLoNanRdvYevaVdfvUhBsY61jAujvm86bd3A1xSqSsqllvwVBig3e1cynVsPwtjY
         CEeFR1anBrpV1EhVn5ES/+IvY0wV1rMKExoVlobDEcy3k2+ymWmLqf0/d4Y55x39XHCu
         B7iGiF4DmaLOixKWH1URluEodPOlPDwqgFiylR1y/pPnUBy7GziheA8eeLj8296DWQz6
         13D5GZgw77MK8rgYarfCghcD696dVgDhJJBQ4il+zWKCnIcfDhqWNWQ2lrgMRSZ8v2UN
         +4Uw==
X-Forwarded-Encrypted: i=1; AFNElJ9p6ddsfIeOHEjskVUPQkUl1q13nk5xz+S64DWX/miJYqybPZ2a9EVA/7iA2gP5DE+qWRfj5l8s@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2dzwz9+ahZnoZunA3Z29heB2vbBFXyCXiYddPhiSWnFtTJka4
	E6F1gzs6hp1ClKrR05m99JMJlVlycK0ef/m3ukBfIHuA8Fmnb48U+lhC
X-Gm-Gg: Acq92OHeRZpaxqgyd4OEMkEqX0py/b2LEqdH85Wg9c78MagDj1LSMu6qEwNJ1itnVUe
	IDPBpIkXXa7DmIJwlV+2evbbEuiOfqvBJzZG6zN4ZmAUELdgphwPQyQlDr6oJehzkfMMvvNXl7V
	OP+lhUBetUKgZ5q+GI5xjM8Gw2fx0K1yajp2B2RtYxxSCi6C6nEJaj+bB8a8cAcc+MO83IbYu/9
	IdI8T1SGXp46i0UROJUYjxCCWT36c45zCIw0oBGe7uP48EKGHaCnTy5xbQvVO0RC7KqC9qibnJy
	KMuaxseTxwJ+MJerh7wBKrCimOCm5w1L1BbkqCvYl2HJtnn/KS4df6SWwHgv33C0uOcEI9z31wp
	1SajraI6ex9rLjNkyXvsU5ynBOdhiA5eLSEGVj2XR1GSBG8cSeKkVF/QoRmMXmhbrEQxsVRvbjW
	qXlsv6ZAYEESzUxHYEJJImp2YKNPgRb+T2hQ8q81uHfep9Rl0iHyqcYDF2c/Lw1Nlb
X-Received: by 2002:a05:6a00:190f:b0:842:4612:55f4 with SMTP id d2e1a72fcca58-84246127062mr5297173b3a.31.1780312077721;
        Mon, 01 Jun 2026 04:07:57 -0700 (PDT)
Received: from [10.125.192.75] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214ce9cebsm9839131b3a.52.2026.06.01.04.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 04:07:56 -0700 (PDT)
Message-ID: <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com>
Date: Mon, 1 Jun 2026 19:07:45 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor
 per-memcg
To: Yosry Ahmed <yosry@kernel.org>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com>
 <aho7nepN5jZtKmef@google.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <aho7nepN5jZtKmef@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	TAGGED_FROM(0.00)[bounces-16514-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lixiang.com:email]
X-Rspamd-Queue-Id: 7455F61E1CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/5/30 09:24, Yosry Ahmed wrote:
> On Tue, May 26, 2026 at 07:45:58PM +0800, Hao Jia wrote:
>> From: Hao Jia <jiahao1@lixiang.com>
>>
>> The zswap background writeback worker shrink_worker() uses a global
>> cursor zswap_next_shrink, protected by zswap_shrink_lock, to round-robin
>> across the online memcgs under root_mem_cgroup.
>>
>> Proactive writeback also wants a similar per-memcg cursor that is
>> scoped to the specified memcg, so that repeated invocations against
>> the same memcg make forward progress across its descendant memcgs
>> instead of restarting from the first child memcg each time.
> 
> Is this a problem in practice?
> 
> Is the concern the overhead of scanning memcgs repeatedly, or lack of
> fairness? I wonder if we should just do writeback in batches from all
> memcgs, similar to how reclaim does it, then evaluate at the end if we
> need to start over?
>

Not using a per-cgroup cursor will cause issues for "repeated 
small-budget calls" cases. For example, repeatedly triggering a 2MB 
writeback might result in only writing back pages from the first few 
child memcgs every time. In the worst-case scenario (where the writeback 
amount is less than WB_BATCH), it might only ever write back from the 
first child memcg.

Similar to how memory reclaim uses mem_cgroup_iter() (via struct 
mem_cgroup_reclaim_iter) and the old shrink_worker() used 
zswap_next_shrink, we need a shared cursor here.


>>
>> Naturally, group the cursor and its protecting spinlock into a
>> zswap_wb_iter struct, and make it a member of struct mem_cgroup to
>> realize per-memcg cursor management. Accordingly, shrink_worker() now
>> uses the lock and cursor in root_mem_cgroup->zswap_wb_iter.
> 
> If we really need to have per-memcg cursors (I am not a big fan), I
> think we can minimize the overhead by making the cursor updates use
> atomic cmpxchg instead of having a per-memcg lock.
> 

Because mem_cgroup_iter() always calls css_put(&prev->css), we cannot 
simply update zswap_wb_iter.pos via cmpxchg() after calling it. Doing so 
could lead to a double css_put() issue on prev->css.

Therefore, if we switch to the cmpxchg() approach, we wouldn't be able 
to reuse the existing mem_cgroup_iter() logic. We would have to write a 
new function similar to cgroup_iter(), and its implementation might end 
up looking a bit obscure/complex.

Currently, this lock is only used in shrink_memcg(), proactive 
writeback, and mem_cgroup_css_offline(). Note that shrink_memcg() only 
acquires the lock of the root cgroup, and mem_cgroup_css_offline() is 
unlikely to be a hot path.

So, should we keep the spin_lock or go with the cmpxchg() approach?
Yosry and Nhat, what are your thoughts on this?



>>
>> Because the cursor is now per-memcg, the offline cleanup must visit
>> every ancestor that could be holding a reference to the dying memcg.
>> Factor out __zswap_memcg_offline_cleanup() and walk from dead_memcg up
>> to the root.
> 
> Another reason why I don't like per-memcg cursors. There is too much
> complexity and I wonder if it's warranted. If we stick with per-memcg
> cursors please do the refactoring in separate patches to make the
> patches easier to review.


Sorry about that. I will try to keep each patch as simple as possible in 
the next version.


Thanks,
Hao



