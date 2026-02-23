Return-Path: <cgroups+bounces-14160-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGMEFKeYnGluJgQAu9opvQ
	(envelope-from <cgroups+bounces-14160-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 19:12:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF6017B54D
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 19:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E44A5305C26F
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 18:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE03633B6C2;
	Mon, 23 Feb 2026 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eJ6KvF+w"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C033AD8C
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870191; cv=none; b=D1UrkfRBUBtqG0AzGck8vSO6QOBbH4wUdAhm7BVVvw1LBrwCzG3sbZ/HDMKYVxPVR18RPiKe4WXl9iyL7ur7w0Oa4Zh1nf421xYGi3rCrpnCVGchwUJ90A2k/t3iYw4EXoEGEEYbzNnH8XC0NjtwRu3HQFh2tIFyNyz+UPmYvDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870191; c=relaxed/simple;
	bh=na/tbwRSN/OigPDxIRS1cy7OFRsKozjFHxklEBqVDRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2hFBapTZDob0Usnlsl37CtsJMFN/KnA/5dXp7PBID5gCFpLSiyfHJfmcNgu5ad+ErRI0U9ocu4MXFDKzdoJ8KZaOt9JIyQoTwiSRfluPY6OMxErwbaOsrfRkis5q9ufJV62hkmw6j/7vJOU2cnoiJXLvkP42XjDAHvmsB1a3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eJ6KvF+w; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4836cd6e0d4so5884555e9.3
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 10:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771870188; x=1772474988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8G05LLid+B1Y6OxsFG39BFRld+8LCwvvG4/myaZjVXo=;
        b=eJ6KvF+wI5hUEvJS0eamjzoRr8JJTJzpro4/Y4YGppW7oMiGOds020QPmtnrOtOkL2
         F4jURF4t9F0Rez0cfDv2mZxt8W6e3fuS23iC4QSLhBhdIUAz/PQNKGUXtBkX7y/iPDDh
         mpH/tPsg01G+UVFrTvxhaGQdukB+dzEnEgRlYa++wJQTgtr7EXjrLOfd/2dBWNMAgobk
         td1YNCKrq2Wncryad+1cH3QJl6KzLzsORZVIRq7yrZDMMdCqEJ21GL2SND9gr0WET1KI
         Uyzl+jLUM0IcqmBcuNyAD9WABgqMFrj8ZcAsVTAKUtbvPE5t4NnwrWbJUpcQ0sdwK51P
         G/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771870188; x=1772474988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8G05LLid+B1Y6OxsFG39BFRld+8LCwvvG4/myaZjVXo=;
        b=psU6AhwQ8DhPWy6AYH/ZxZsNtPwpTdaSQX366gaHroK+fBcpye77kLKVsv2QJMHjAm
         BFmAKqXUq8WFgR0Vwh4iaNaG4eDyrAesWgOAtFOqjgO+74dQOxkFCWdyeLCOfuoJvhXu
         hP5F5i8G6aGeUgeyCYZVk2eS3opr136Jvx8l9SsvRXvPywHpWIouRbuMAMtU7y1bWBEY
         m8y+MXAiIs+xZh49sYxfcnSqUHHhqMlM0rbfMNjgdMgn1dt8XdVEq5CMPFB4EMd/Xs+M
         TXF4QssEk32rECLUm5Pj0Wf+re2m8DBM6CaagY4LdlVz01dxC4l8acRJloa5CaAsvQNj
         XNcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRZArMZP0W/86WxcJzUN13hGvRR45H3lVRHkUaNMX5gCSqzaO2v//uh/SHLnUqBZXtuWU5DHWO@vger.kernel.org
X-Gm-Message-State: AOJu0YzWwNXLhunDLT9EaR0z1cP9eR/pjwrVJ3vcmhuczho9ZXWnhDB4
	AOwGJrCtKY5DaXZbDpijJs04ccnDoweYLOfedk2as2GPDXGxXZN6Ey2tHf/V69v0AuM=
X-Gm-Gg: AZuq6aJCCK9JMJ7FtaaPAj1yG48C82CDF0TWSILzFBzZoFiFkuealwfjrRVxq9tlakU
	zVZ84bTylBOiKCbHi7uwcqBtisua75LQXNu48YbJexjjTpV17bJ9jn/eiagAOJLwmzQtyd5p3Su
	2v6COE4w0LJ8nvuQMqcKX1Ijmar0For8FxOp6lbDZKZmaF1reSW440qI9jw6neKm+S+kphQjYb9
	NulaDRaedmRoJtDH1ApH1+BdK6rVqRO3wO32bVylHK0gKoKGNFYXQipoP+y+R1Cbo/okOmncRYj
	2yQfo4toFNQeAYRauKGi0hhlRCpqtZAosQ2UWWg+VmBX1mqh+7xsoO4KHkIud5/apmL1oYdb9fs
	gdbpbYaCnZHspHZQtoi1EiXj6btSygpQCSi7VvQYTER2Yuvjxg4gRqOdPbiP5v55Ra6JOZ/qwVy
	PUJYHPuqQ50IrMvBjfaA==
X-Received: by 2002:a05:600c:4e48:b0:47a:94fc:d063 with SMTP id 5b1f17b1804b1-483a95eb348mr98005385e9.1.1771870188427;
        Mon, 23 Feb 2026 10:09:48 -0800 (PST)
Received: from ?IPV6:2001:1a48:8:903::e14? ([2001:1a48:8:903::e14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bfa015sm20581839f8f.8.2026.02.23.10.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 10:09:48 -0800 (PST)
Message-ID: <1fd2efef-888b-4d3c-9c72-bdb2d594336f@suse.com>
Date: Mon, 23 Feb 2026 19:09:47 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Content-Language: en-US
To: Marcelo Tosatti <mtosatti@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc: Leonardo Bras <leobras.c@gmail.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Frederic Weisbecker <fweisbecker@suse.de>
References: <20260206143430.021026873@redhat.com> <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad> <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash> <aZL45yORfkNvS9Rs@tiehlicka>
 <aZiRAa6uf4KhscJC@tpad> <aZiSHT5DwIZwc/cH@tpad>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <aZiSHT5DwIZwc/cH@tpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,linutronix.de,redhat.com,suse.de];
	TAGGED_FROM(0.00)[bounces-14160-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: EDF6017B54D
X-Rspamd-Action: no action

On 2/20/26 17:55, Marcelo Tosatti wrote:
> 
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/slab.h>
> #include <linux/timex.h>
> #include <linux/preempt.h>
> #include <linux/irqflags.h>
> #include <linux/vmalloc.h>
> 
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Gemini AI");
> MODULE_DESCRIPTION("A simple kmalloc performance benchmark");
> 
> static int size = 64; // Default allocation size in bytes
> module_param(size, int, 0644);
> 
> static int iterations = 1000000; // Default number of iterations
> module_param(iterations, int, 0644);
> 
> static int __init kmalloc_bench_init(void) {
>     void **ptrs;
>     cycles_t start, end;
>     uint64_t total_cycles;
>     int i;
>     pr_info("kmalloc_bench: Starting test (size=%d, iterations=%d)\n", size, iterations);
> 
>     // Allocate an array to store pointers to avoid immediate kfree-reuse optimization
>     ptrs = vmalloc(sizeof(void *) * iterations);
>     if (!ptrs) {
>         pr_err("kmalloc_bench: Failed to allocate pointer array\n");
>         return -ENOMEM;
>     }
> 
>     preempt_disable();
>     start = get_cycles();
> 
>     for (i = 0; i < iterations; i++) {
>         ptrs[i] = kmalloc(size, GFP_ATOMIC);
>     }
> 
>     end = get_cycles();
> 
>     total_cycles = end - start;
>     preempt_enable();

While preempt_disable() simplifies things, it can misrepresent the cost of
preempt_disable() that's part of the locking - that will become nested and
then the nested preempt_disable() is typically cheaper, etc.

Also the way it kmallocs all iterations and then kfree all iterations may
skew the probabilities of fastpaths, cache hotness etc.

When introducing sheaves I had a similar microbenchmark, but there was
different amounts of inner-loop iteraions, no outer preempt_disable(), and
linear vs randomized array. See:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/commit/?h=slub-percpu-sheaves-v6-benchmarking&id=04028eeffba18a4f821a7194bc9d14f7488bd7d9

(at this point the SLUB_HAS_SHEAVES parts should be removed and the
kmem_cache_print_stats() stuff also shouldn't be interesting for QPW
evaluation).

> 
>     pr_info("kmalloc_bench: Total cycles for %d allocs: %llu\n", iterations, total_cycles);
>     pr_info("kmalloc_bench: Avg cycles per kmalloc: %llu\n", total_cycles / iterations);
> 
>     // Cleanup
>     for (i = 0; i < iterations; i++) {
>         kfree(ptrs[i]);
>     }
>     vfree(ptrs);
> 
>     return 0;
> }
> 
> static void __exit kmalloc_bench_exit(void) {
>     pr_info("kmalloc_bench: Module unloaded\n");
> }
> 
> 


