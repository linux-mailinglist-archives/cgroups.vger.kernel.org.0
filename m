Return-Path: <cgroups+bounces-16667-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dlppFZ/qImrPfAEAu9opvQ
	(envelope-from <cgroups+bounces-16667-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:26:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D3C64948A
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:26:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GSPu40WW;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16667-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16667-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96898303885F
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E413D1CB5;
	Fri,  5 Jun 2026 15:18:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2835BDDB;
	Fri,  5 Jun 2026 15:18:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672696; cv=none; b=mz6+ohfbpHgpWVgaCdYFDeNCNotOVh+u1Ho/6/aa4OwpJTHMQodDTnaSZzQTI6ZZCZ9s1an5+ET1+mte/5erWL/jsO0A96UK1QN32pTf0lGecgT1qOqE2b9JFlCB0IfEg63SCuvhVKgxJVAla+UrAkZ1IKx1xBKR1lUSXoUinDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672696; c=relaxed/simple;
	bh=vn/5cXhuJlOMn30ZTneglH3cHmpvMV952zzgBo9k3TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHIu2y41jAa7ACfYYFZj3vTkCE8L2KP5jAWd8WGpfki2df7Yhn1iixtJUaF0rZsYG8xzi2NJUhQvJzM66PC204K1P+Fh2w0nfKhyz6r5L7ozWRVc5lr/MKABfKwvnwKJ7Zr5n+MtnbOD80cydgj+iE7Gx+6qOkQR+38avqA4Yvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSPu40WW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696671F00893;
	Fri,  5 Jun 2026 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780672694;
	bh=bpBz50L7GInctas+/Il3i3Hx7c4Pv4RIfM6k49q0DxM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GSPu40WWv9onXNY6VO0dlcw7gsX0kg6588NMgROX+7us5AEUFjsK+9/iM1JALiQve
	 s9FIHVxGScwUx0snSzqh7890Rvu3diNQ15ki1tIq4j85wka8H7p6WucwIqbQyOM2I2
	 hBnkXoJI7ZJAVkpkIbJHfqCEh/o6znOhql5PeV2JEp1IfSIOLjl5P7nQ3iis3Uzq+P
	 9u60D0CPpvy8fLYJp7JncpQfH9t2EKVDtKWBGdJkd2OBdXVDzj6rGRatKgUGb8/23Z
	 3WlhRQF0kKRXyR0Kptz8QJfDNfZ3JHMDu8VjLy2Y3RB4RxB6Mo2Y/6NFLb9Ra1VK57
	 7YcT54/CLRijQ==
Message-ID: <25c4bc47-b65d-4c04-8a8f-18eef2b5566a@kernel.org>
Date: Fri, 5 Jun 2026 17:18:07 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: don't allow empty relative nodemask in
 mpol_relative_nodemask()
To: Farhad Alemi <farhad.alemi@berkeley.edu>,
 Gregory Price <gourry@gourry.net>
Cc: falemi@asu.edu, Yury Norov <ynorov@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, cgroups@vger.kernel.org
References: <20260528124133.c88c27b11a8ea0ef05e494f7@linux-foundation.org>
 <20260529152616.2308736-1-joshua.hahnjy@gmail.com> <ahnRIDBk4bQ3xX2q@yury>
 <fe33c767-ea11-43e2-8732-f752c9c1205c@kernel.org>
 <ah6X-RtVX75YP7VX@gourry-fedora-PF4VCD3F>
 <c98eb14d-b878-4eeb-91f0-d2b1d4407e1e@kernel.org>
 <ah6oS7wiGB4u4-eR@gourry-fedora-PF4VCD3F>
 <CA+0ovCiEz6SP_sn3kN4Tb+_oC=eHMXy_Ffj=usV3wREdQrUtww@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <CA+0ovCiEz6SP_sn3kN4Tb+_oC=eHMXy_Ffj=usV3wREdQrUtww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16667-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:farhad.alemi@berkeley.edu,m:gourry@gourry.net,m:falemi@asu.edu,m:ynorov@nvidia.com,m:joshua.hahnjy@gmail.com,m:akpm@linux-foundation.org,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:longman@redhat.com,m:linux@rasmusvillemoes.dk,m:cgroups@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[asu.edu,nvidia.com,gmail.com,linux-foundation.org,intel.com,sk.com,linux.alibaba.com,kvack.org,vger.kernel.org,redhat.com,rasmusvillemoes.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13D3C64948A

On 6/2/26 17:01, Farhad Alemi wrote:
> Confirmed, with a standalone reproducer (attached); it panics linus/master
> at e8c2f9fdadee. cs->mems_allowed can legitimately be empty
> on v2 -- a freshly created cpuset child that never had cpuset.mems
> written keeps mems_allowed empty (never initialized) while effective_mems
> is inherited non-empty in cpuset_css_online(), and v2 allows attaching
> tasks to it (the empty-mems guard in cpuset_can_attach_check() is gated
> on !is_in_v2_mode()). So the non-empty guarantee holds for effective_mems,
> not for the configured cs->mems_allowed; forbidding empty cpuset.mems
> would break v2's inherit-from-parent semantics.
> 
> The reproducer enables +cpuset, mkdirs a child without writing
> cpuset.mems, moves a task in, mbind()s a VMA with
> MPOL_BIND | MPOL_F_RELATIVE_NODES, and offlines a CPU; the hotplug walk
> then calls mpol_rebind_mm(mm, &cs->mems_allowed) with the empty mask and
> folds modulo nodes_weight(*rel) == 0 (console logs attached).
> 
> The newmems instinct looks right: it's the effective, online mask the
> task is actually allowed to use, guarantee_online_mems() keeps it
> non-empty, and it matches cpuset_attach(), which already rebinds against
> cs->effective_mems. The fix this implies:
> 
>   - mpol_rebind_mm(mm, &cs->mems_allowed);
>   + mpol_rebind_mm(mm, &newmems);
> 
> I built the current base (e8c2f9fdadee) with and without this one-liner:
> the unpatched kernel panics on the first cpu1 offline, while the patched
> kernel runs the reproducer's 8 offline/online cycles cleanly, with no
> divide error.
> 
> This regressed in ae1c802382f7 ("cpuset: apply cs->effective_{cpus,mems}",
> v3.17), which moved cpuset_attach() to the effective mask but left this
> rebind on cs->mems_allowed.
> 
> Happy to send this as a proper patch (Fixes: ae1c802382f7, Cc: stable,
> reproducer) if you agree the cpuset side is right, or to test a
> mempolicy-side fix if not.

Yes, please send a patch, including a high-level explanation of what you
analyzed above!

-- 
Cheers,

David

