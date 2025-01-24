Return-Path: <cgroups+bounces-6263-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1906A1B120
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 08:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C22A188ECC2
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 07:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD09A1DB14B;
	Fri, 24 Jan 2025 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fuzhoy4v"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2E1D95BE
	for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737704969; cv=none; b=uiNlN9x8G3YMw75xGKGAAuToOaUbb4wXbaY8R6eDDXflm5SNA7OjoOdVE7OohE35yDH2cHfKuQ0RZHnDtkYjhETwVvjBvDCFxRF1ROUbmkVS+Zf9zw+HLUpEGPdY7HPOdeazw4AqMoZkQdjcddrA4p3x0dncUlTGWGfp5jSQK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737704969; c=relaxed/simple;
	bh=Awy505UaJPkp48e9y2lfNPkRKflzoPa5yjo9vK5w14k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOacDoyZA1KpKojW5VUOQb8sQ1tmBbp/WWztumlQunDBldJHnJ8vlbu+/zM22sQML5TEHKkJsgmiqez5S8OqO236/CSKzrmUqfawiitjsvAtTXns0F8EvMGceXpYitg9pjtugPatY/PRiLKNXmnDc+hx5+9ASKdCpyI7c1Ren3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fuzhoy4v; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso400240a91.2
        for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 23:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737704966; x=1738309766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uws+ehspnEbk0q5oAsWqCHUTLRfxlLuAIbCiJ7MZofs=;
        b=fuzhoy4vXPA51vYuY7HJCUOZwXpEZNi/OlOcckgVfDhSFWssvRSLH60pPxagdml84e
         Zs6/oNQm9j3KZlx09kvqr8Kg91BBL+cOBARHOpIg+8CYdt9Al2X8rbx5w3wNAd7b9sUW
         fwVIudEbRp8u7YnC+HQqyWDSPwNbEnlsVg7hxNGdd/Hcz+e5x0WE0TIiiqBbLSn5AU+y
         xwGyqGBvi1x/yDQNExKXZ+VWgzm8nDBoIqjG52XC0RqQlbGba859N33Gfe5NOWwrR96v
         QGvv2U4CJwJXyZdFFzE2TU1a0MBSHKFUGefmoarziTFCPlvpT4P6xhq5el2Q8twWwkkh
         VmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737704966; x=1738309766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uws+ehspnEbk0q5oAsWqCHUTLRfxlLuAIbCiJ7MZofs=;
        b=mj7iiC8TeILe0821lY2WCzQH0qcMrU4kG0TWPAHBfJ1RRw3Ew+8URfPljVVHrwXHEE
         hObimQFw4X95gl9Rl62RNABbwmpgyKobvkGQ1RZ0JZblUghnmtfcL4A+fcjfQh4lVK/g
         mOuB+2OjEIHMzNUjikFnWVU8gBNco54sB/slTgieWySInymZJItJj7p81fSIwqHjG0Fq
         n7yG2Nbo3VMTdlJauXL12gdYCQ69O/T3y9IC8mKqajSBGJNcw8TQvlLhchH1GAxsL43N
         HDtmBMAqyzrthK3l+9F3qHQ/jlzYLugBJXspnDthJEs9InNuSvo2H4iWlUdoJBUazjWJ
         2WNQ==
X-Gm-Message-State: AOJu0YwKapphbdw1GqNB7fP4ETOaN5WbNp5GL2A4ivAu6h/IESDJYMGA
	hU0cfT1IZxwJqaOb4dxSoEw6e9HGE52PxmbQYXKJE6tRtCzz8K+43/5CDGnByQg=
X-Gm-Gg: ASbGnctbYoaXeuiDl+LxSdhzXuqSsSJ3IVw5I5AgSbh6X9jjhF+dI4zpOJkIZzKNVt2
	f57kXwL6i1EgHkDIxE6qe1L1/XPWCjTzeHPHrd90+7DFA5VHc5XWOGqmFygD2JfLYyDkMReBBB5
	udFMZb4B2HCw27WcqQHn3NiZe+FBoAiLN9b4SkqX5YnQGFCLY/f5wrimUTkUyhQjo+iSM98RZEK
	xiSSiiXFCxPklKRL+Y0KqhpMniNPql2mRrnColSyEDHrd4CC7NfW+OzGM5LttjG8aqhgMZFMYgh
	tfhZBU6noF6WEhFYJW/ZsHrLqjG40w==
X-Google-Smtp-Source: AGHT+IEEJ+74un4tMKpaPeLW04njmN5HnJ938utpDTqTFM2Z68P/2bjYtoGBIV/UH9qBePmOk/E0og==
X-Received: by 2002:a05:6a00:1894:b0:725:e499:5b94 with SMTP id d2e1a72fcca58-72dafa6b3a7mr13902096b3a.4.1737704965963;
        Thu, 23 Jan 2025 23:49:25 -0800 (PST)
Received: from [10.254.144.106] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a69f5fdsm1208111b3a.5.2025.01.23.23.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 23:49:25 -0800 (PST)
Message-ID: <2bba87cf-69aa-4fac-ae1a-c50e2f376e2a@bytedance.com>
Date: Fri, 24 Jan 2025 15:49:16 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 1/3] cgroup/rstat: Fix forceidle time in cpu.stat
Content-Language: en-US
To: chenridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yury Norov <yury.norov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bitao Hu <yaoma@linux.alibaba.com>
Cc: "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250123174713.25570-1-wuyun.abel@bytedance.com>
 <20250123174713.25570-2-wuyun.abel@bytedance.com>
 <853d2669-e05b-435e-9ac1-86311ead56e5@huawei.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <853d2669-e05b-435e-9ac1-86311ead56e5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/25 9:47 AM, chenridong Wrote:
> 
> 
> On 2025/1/24 1:47, Abel Wu wrote:
>> The commit b824766504e4 ("cgroup/rstat: add force idle show helper")
>> retrieves forceidle_time outside cgroup_rstat_lock for non-root cgroups
>> which can be potentially inconsistent with other stats.
>>
>> Rather than reverting that commit, fix it in a way that retains the
>> effort of cleaning up the ifdef-messes.
>>
>> Fixes: b824766504e4 ("cgroup/rstat: add force idle show helper")
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   kernel/cgroup/rstat.c | 29 +++++++++++++----------------
>>   1 file changed, 13 insertions(+), 16 deletions(-)
>>
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index 5877974ece92..c2784c317cdd 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -613,36 +613,33 @@ static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat
>>   void cgroup_base_stat_cputime_show(struct seq_file *seq)
>>   {
>>   	struct cgroup *cgrp = seq_css(seq)->cgroup;
>> -	u64 usage, utime, stime, ntime;
>> +	struct cgroup_base_stat bstat;
>>   
>>   	if (cgroup_parent(cgrp)) {
>>   		cgroup_rstat_flush_hold(cgrp);
>> -		usage = cgrp->bstat.cputime.sum_exec_runtime;
>> +		bstat = cgrp->bstat;
> 
> Thank you for finding that.
> In my version 2, I used to assign cgrp->bstat to bstat.
> This is Tj's comment:
> https://lore.kernel.org/linux-kernel/ZoQ2ti7nnz9EJSc3@slm.duckdns.org/

Thanks for pointing out. Using memcpy() is fine for me, but I see
cgroup_base_stat_flush() is using the same pattern, and if we don't
want copy like this, it would be better unify them in a separate
patch.

But IMHO in either way, I don't think reading forceidle time outside
cgroup_rstat_lock is the right thing to do.

Best Regards,
	Abel


