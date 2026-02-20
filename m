Return-Path: <cgroups+bounces-14064-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /wOVAL6gmGkPKQMAu9opvQ
	(envelope-from <cgroups+bounces-14064-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 18:58:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA12169EBE
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 18:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F454301C963
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A83365A13;
	Fri, 20 Feb 2026 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LqQ4yysk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81352EDD52
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610295; cv=none; b=egGFVQnZT4aZFwrNwxHr0/LG8lRaR4CIcCkTGa6NUYUcGXXC/TqV8ro/t3BKeh7SDuHkcmX6nHouFIpZufdb3eJ9K7c/LL94WrQGU64MP2BQgmOw+c4mASGOIRgrSDTR8ZQA1+CeNwdipOs/z8H6Ckhg711BP65SuZ4qZubte7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610295; c=relaxed/simple;
	bh=YnswSjG8WhKSNZ/hhY9DAo5fku7RaUVfqMcHYdI1E6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOpenLlLVDG0DiZPfjVtOilMF2P9B1Ha30rYKYMyqjXRaTTHQoJOo12K2Hru9mM98Bt26h0eSGVOwq2gSNgyc1Iqc+zYseTg19mack02RKB04pmB4amGjv1nQRdhsoCYnKZk2YBCrqxDRBktOB+UgjTWAYuu3gk9m3IQAFq6DJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LqQ4yysk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4832c8f9d87so2793635e9.3
        for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 09:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771610292; x=1772215092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qjc7Lf5ark/1hfgAzfJZnbueKXyvbrGroEnzxtDEvpw=;
        b=LqQ4yyskZzmAlS9c3gHLBkba9zlDUCnauaMH3m4pv44K/wE7TmXiQC/UK21CvvD/b1
         C4Htt6ZyldjNUFTqfGcoipT0popgPfWIUwbfq8Qc+iMU7YdNSWfb+CmyR8R3B7dxo+X7
         qmFZNF1W2xwNES/nac37cMDY3+1A2SwkwPmPxzL1XGgK+LXvxkgKDrVAx1UtE4MYVO8W
         9zD6pZZeORrlYELEMr7P4T5ntL5sTVgkFDjXSan94JWIZ4ZiQ65YiFoMdvn+8YJCws/O
         ZoGC5f7EFKcpprFxJ+VGwplhgGRaPoW+a+AoOvfBAAfiCXw0WiBuK1qnNVZB4lDquSdc
         DT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771610292; x=1772215092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjc7Lf5ark/1hfgAzfJZnbueKXyvbrGroEnzxtDEvpw=;
        b=vfNL4Dd2GiFyxjvbsy0XjoG6V6ZIjo8/CRUzFqmzxbRwHT3/LxtGvj5ODp+TefYQHW
         bHDCpRL6RTLHSRA5j2Rnxg2BrHTMc6mM4VPSkEGDv4REGhxVDYGTfpZhmyTM2DFnL5lf
         RvPTLj7GHP3aYgH+2VLn7imcvBQxp2jeFWYP/muysNI04AW7Oge7I6xeO2LCGojMzkWJ
         8Q21qa+6K3Lh6OLS/uqmKigGLSBLk2FPKbTupzsE3VXbnJQuuo+m+LDoEqW3pTDs3vYc
         6jThlWJbOWBcFhIux5ffJjf74kYl9VB/O9OM5r9keGqUX5pL5OFafgBZfxnnjAHXrBcp
         17WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl9UkaJdiLgOmxCD9T96w47KgCHmhi8YVbxTJoE1IYSpj5x8Vk0Xv+bmcwvGX/0IvH8pwLC5NP@vger.kernel.org
X-Gm-Message-State: AOJu0YzVRd64iToZrbD/djL0BvBtaNvVCcua1pByWuugYmHe6UY3FU2z
	7OspSq3ewXryAXpzqxhcU06bNotCYHQe722P4OH/sReD9/xk0irQiJCuSyuzCYA0QSA=
X-Gm-Gg: AZuq6aJvDveYVcGeaaMxI2ztL+hoBmj0jE12BR7lD+umNcWPouu7ltui5xRtMUkZ5BY
	yvQy7sIPMopPVkTHEo4YpAUPlIXOlBdD2crTOESXD0BzYXvVHn6aqYeLXAAQhFirCgpzBr3P3Qh
	NaoL/M5M1xL5k5WbKgq3dAW7xk9XDRQK5MbjIE08OclVGa4yydOTLmngyhOlyn8xaotwITOqvnq
	rLPbOuDtf2sYlh/EH9bBsrxKen6JG2GNYEeTzJD6Go1aoLgQ1JlhS9NjJr7Oa6L5KQiTDZrp+1t
	6W16k0lOLA1aI03w1/RHdf9yZfIf0EV1YLT7xMCghDS+Ut/cEHJL2VOW6cj5XttE4RkT1AHIA+g
	9Yv4RJJNYUb0IkB7OopJfKj/as/f1UXmkfoWzmXcBDO8MbGD778aag4GpkijmQmnSiPT5Fw4iBp
	RWW6Vp1OYZVMcreGGYbg==
X-Received: by 2002:a05:600c:6218:b0:47d:3ffa:9838 with SMTP id 5b1f17b1804b1-483a95eb914mr3579945e9.1.1771610292057;
        Fri, 20 Feb 2026 09:58:12 -0800 (PST)
Received: from ?IPV6:2001:1a48:8:903::e14? ([2001:1a48:8:903::e14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c56d8sm134807145e9.8.2026.02.20.09.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 09:58:11 -0800 (PST)
Message-ID: <a1c11a09-da88-4edd-9571-0f792b59e9c3@suse.com>
Date: Fri, 20 Feb 2026 18:58:10 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Content-Language: en-US
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Leonardo Bras <leobras.c@gmail.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Frederic Weisbecker <fweisbecker@suse.de>
References: <20260206143430.021026873@redhat.com> <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad> <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash> <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad> <3f2b985a-2fb0-4d63-9dce-8a9cad8ce464@suse.com>
 <aZibbYH7yrDZlnJh@tpad>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <aZibbYH7yrDZlnJh@tpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	TAGGED_FROM(0.00)[bounces-14064-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,quantvps.com:url]
X-Rspamd-Queue-Id: 4FA12169EBE
X-Rspamd-Action: no action

On 2/20/26 18:35, Marcelo Tosatti wrote:
> 
> Only call rcu_free_sheaf_nobarn if pcs->rcu_free is not NULL.
> 
> So it seems safe?

I guess it is.

>> How would this work with houskeeping on return to userspace approach?
>> 
>> - Would we just walk the list of all caches to flush them? could be
>> expensive. Would we somehow note only those that need it? That would make
>> the fast paths do something extra?
>> 
>> - If some other CPU executed kmem_cache_destroy(), it would have to wait for
>> the isolated cpu returning to userspace. Do we have the means for
>> synchronizing on that? Would that risk a deadlock? We used to have a
>> deferred finishing of the destroy for other reasons but were glad to get rid
>> of it when it was possible, now it might be necessary to revive it?
> 
> I don't think you can expect system calls to return to userspace in 
> a given amount of time. Could be in kernel mode for long periods of
> time.
> 
>> How would this work with QPW?
>> 
>> - probably fast paths more expensive due to spin lock vs local_trylock_t
>> 
>> - flush_rcu_sheaves_on_cache() needs to be solved safely (see above)
>> 
>> What if we avoid percpu sheaves completely on isolated cpus and instead
>> allocate/free using the slowpaths?
>> 
>> - It could probably be achieved without affecting fastpaths, as we already
>> handle bootstrap without sheaves, so it's implemented in a way to not affect
>> fastpaths.
>> 
>> - Would it slow the isolcpu workloads down too much when they do a syscall?
>>   - compared to "houskeeping on return to userspace" flushing, maybe not?
>> Because in that case the syscall starts with sheaves flushed from previous
>> return, it has to do something expensive to get the initial sheaf, then
>> maybe will use only on or few objects, then on return has to flush
>> everything. Likely the slowpath might be faster, unless it allocates/frees
>> many objects from the same cache.
>>   - compared to QPW - it would be slower as QPW would mostly retain sheaves
>> populated, the need for flushes should be very rare
>> 
>> So if we can assume that workloads on isolated cpus make syscalls only
>> rarely, and when they do they can tolerate them being slower, I think the
>> "avoid sheaves on isolated cpus" would be the best way here.
> 
> I am not sure its safe to assume that. Ask Gemini about isolcpus use
> cases and:

I don't think it's answering the question about syscalls. But didn't read
too closely given the nature of it.

> 
> For example, AF_XDP bypass uses system calls (and wants isolcpus):
> 
> https://www.quantvps.com/blog/kernel-bypass-in-hft?srsltid=AfmBOoryeSxuuZjzTJIC9O-Ag8x4gSwjs-V4Xukm2wQpGmwDJ6t4szuE

Didn't spot system calls mentioned TBH.


