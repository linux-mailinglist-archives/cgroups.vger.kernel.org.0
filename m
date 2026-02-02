Return-Path: <cgroups+bounces-13604-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLrJHg7sgGleCAMAu9opvQ
	(envelope-from <cgroups+bounces-13604-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 19:25:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2660DD0229
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 19:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03C65300BDB6
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1600A2E22AA;
	Mon,  2 Feb 2026 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gw+Ln7ht";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qTqEPTV8"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B822DE71B
	for <cgroups@vger.kernel.org>; Mon,  2 Feb 2026 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056509; cv=none; b=dQL92CD1fCgcSCNxE1yKPsbBxSTDdmdreL2nUrKVQjhJOok/17vQjq7PDJP/zUcZNmHsEXZZCJDy9EstszEM52ATisWACnEkG9bdJtoLp2kNgUFxuPbVHUWE0ALM2tfUCSvZm3LD/HacliDOjVV9cnBCqwDCYxsR9my5KG46BZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056509; c=relaxed/simple;
	bh=ZgFPpzWS2e4pSmnR8N9TBShnHKYDmbpBdWZEJxThLWI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YvW9Ylfewjc4QS8+Sro50Oi9/LQBgxx4P+y82I2IUqqPO1SvmZezeRVNHFHiVNGevXKTTogBvi9v9D2TMU7JpTP9KQMtlBV0UVbr3PmknvIR1i2jscNj1c3TH6LwF4CY0AlBKHH4ieQHTuPo5XcqTIg3OHbTeRBcj+zyzHUp3GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gw+Ln7ht; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qTqEPTV8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770056507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJfpaXz7AFF7IJW/W7RDCIALtDcgndOMABwDoErkBSU=;
	b=Gw+Ln7htsdEGetNh+JUpA4stq+Y3jt4Q5xhlAzlox1bhKVX2M5q5fJ5Oh4tQ5TokhvcwHV
	uOResSQYqt06OgB402pRGyl7Rrxhnm3KjefQrydCc1liQjqQyOnccrlVACn0X0xrQnGCfi
	pUwt2Bbki8bFohxuscZtLuaSyQMkddQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-f6M-4W7YOw-5Olv4uO5Xow-1; Mon, 02 Feb 2026 13:21:46 -0500
X-MC-Unique: f6M-4W7YOw-5Olv4uO5Xow-1
X-Mimecast-MFC-AGG-ID: f6M-4W7YOw-5Olv4uO5Xow_1770056506
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50333a8184aso155053581cf.1
        for <cgroups@vger.kernel.org>; Mon, 02 Feb 2026 10:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770056506; x=1770661306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mJfpaXz7AFF7IJW/W7RDCIALtDcgndOMABwDoErkBSU=;
        b=qTqEPTV8wrsMr8O+Lv4CEdva3WUGxE1c+TdlC+niyw75G2FEuGGt1/AIgfYj3pnP0V
         6lJt/VSyL8Dj57U7BpvEcbW9FHqdFsnhvF2mp5x29PtKuwtMh4BiYvG7MeCbTDOZ7bdH
         7Z+h8rsvq0HjxD9K7hBt4sxVcFm+SPFAa/h2yh3kKscivBsbK1+d7kYyeI8gpEZh2pwo
         ge7rIaL33co5rOnx+SfALIE5OrR+ZdIwn3LfAtCsJX3DrfXpUu49RG8cQ09wlW/0FVrH
         wp2ckvKy+wgil4UqBA1Cx/nti7rshDIMmBdSDpumY5Y1i0ilk0mwHpTCmTlLiBf3Ge/m
         pQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770056506; x=1770661306;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJfpaXz7AFF7IJW/W7RDCIALtDcgndOMABwDoErkBSU=;
        b=PjTg/5wzm/Dt9XLofcC7LFINIPiX07GxUDn0ttXIVBqN7LsbeCXMrwr90v9xCwCQW7
         iNYWLjev6Wpupt7c/GCogeYSUYoOmVcEBkMLTBwPX2UdIh1jmKBPfkS/3J+GT6hRPEJo
         Zlhy22xgON7Um4VjgxsexUgx89JjjyENaMuZmtVKBvJDTJM9EvAnT1kgQVYnf4yAJG7w
         gF/0zMcBP5m1oP0JuXehJf2JUL7HdDGxroqYePiMVJIX6MF8/5vqJAYDOx1zaExvfb19
         VZehqWz1+87TDCsyxolD50Z0v0+/KAIDL3Idrcu2+9QvF37fp0FN0g46mpNVG6nSGa9Z
         2Y8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0VvCFTt558ABdTvyhERwJ9rR5zKx7pmFhKeWyh3LT6eqSrqBebY1FgOFGwcRqt3aTrTGn9v3L@vger.kernel.org
X-Gm-Message-State: AOJu0YzFHWcHfsZCgZCdp3vS/g7D3ZzfzcHvXtEWhlzEVo5Yn8AnuggO
	he14WSLgeERCUI+lD2Kl8XknESg0CnoU4yyC4CJ6H8uSySLm4cqWKOfypdLsbR6F6Ifw0C8/ilP
	9ROnZIcbTd0uGGQ88XX8c8Y4ZNcBefjXdAhlu+VCYvfiFpUsmYwmBcF0PiDw=
X-Gm-Gg: AZuq6aJa/j3iyWguEaj34wVD4PZDEW/wd6CLvW5oGPwS7ykxbZKZ5qUqDXOE3CH838j
	Qp5lOcWlUJ3S5sjfPc147uiuqAmLDtUviHaFO4kjHcOIy6Web+ohLFnNSRWY3nMy+81o9Zp+onQ
	gt483MTYqbvVLASGBTsgc31w+sBG+yy+j6epIuyeWw1wgzY7/AwjkMm2cvYPpG2vKLXSn/7e4rI
	0t2vZOsTgt5INjBYYn4tY4M3TMhan57RvkQsDWj2rklc7J66j0cPD3NLi9QJ/rPClpu9aNSiK0K
	mkFUMEJ3xj50OegEfkXELUNSszKv9UpqezR7yKBcJxje7Z4FIGgnzYIsfeCuok96iQQiQ/86gP5
	j8DbvKHW4o91D/LDIWiVzWPUPdfvUPOFEpJFSdu981weBePZ+glJa+2pn
X-Received: by 2002:ac8:580d:0:b0:501:40af:96cb with SMTP id d75a77b69052e-505d229cca2mr164744201cf.58.1770056505582;
        Mon, 02 Feb 2026 10:21:45 -0800 (PST)
X-Received: by 2002:ac8:580d:0:b0:501:40af:96cb with SMTP id d75a77b69052e-505d229cca2mr164743941cf.58.1770056505216;
        Mon, 02 Feb 2026 10:21:45 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337cbdc24sm114980071cf.32.2026.02.02.10.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 10:21:44 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ca4e6c43-2bf3-42b9-91eb-dfce4777b5da@redhat.com>
Date: Mon, 2 Feb 2026 13:21:43 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v2 1/2] cgroup/cpuset: Defer
 housekeeping_update() call from CPU hotplug to workqueue
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260130154254.1422113-1-longman@redhat.com>
 <20260130154254.1422113-2-longman@redhat.com>
 <20260202130526.GE1395266@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20260202130526.GE1395266@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-13604-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2660DD0229
X-Rspamd-Action: no action

On 2/2/26 8:05 AM, Peter Zijlstra wrote:
> On Fri, Jan 30, 2026 at 10:42:53AM -0500, Waiman Long wrote:
>
>> +/* Both cpuset_mutex and cpus_read_locked acquired */
>> +static bool cpuset_locked;
>> +
>>   /*
>>    * A flag to force sched domain rebuild at the end of an operation.
>>    * It can be set in
>> @@ -285,10 +288,12 @@ void cpuset_full_lock(void)
>>   {
>>   	cpus_read_lock();
>>   	mutex_lock(&cpuset_mutex);
>> +	cpuset_locked = true;
>>   }
>>   
>>   void cpuset_full_unlock(void)
>>   {
>> +	cpuset_locked = false;
>>   	mutex_unlock(&cpuset_mutex);
>>   	cpus_read_unlock();
>>   }
>> @@ -1293,14 +1308,30 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>>    */
>>   static void update_isolation_cpumasks(void)
>>   {
>> -	int ret;
>> +	static DECLARE_WORK(isolcpus_work, isolcpus_workfn);
>>   
>>   	if (!isolated_cpus_updating)
>>   		return;
>>   
>> -	ret = housekeeping_update(isolated_cpus);
>> -	WARN_ON_ONCE(ret < 0);
>> +	/*
>> +	 * This function can be reached either directly from regular cpuset
>> +	 * control file write (cpuset_locked) or via hotplug (cpus_write_lock
>> +	 * && cpuset_mutex held). In the later case, we defer the
>> +	 * housekeeping_update() call to the system_unbound_wq to avoid the
>> +	 * possibility of deadlock. This also means that there will be a short
>> +	 * period of time where HK_TYPE_DOMAIN housekeeping cpumask will lag
>> +	 * behind isolated_cpus.
>> +	 */
>> +	if (!cpuset_locked) {
> I agree with Chen that this is bloody terrible.
>
> At the very least this should have:
>
> 	lockdep_assert_held(&cpuset_mutex);
>
> But ideally you'd do patches against this and tip/locking/core that add
> proper __guarded_by() annotations to this.

Yes, I am going to remove cpuset_locked in the next version. As for 
__guarded_by() annotation, I need to set up a clang environment that I 
can use to test it before I will work on that. I usually just use gcc 
for my compilation need.

Cheers,
Longman


