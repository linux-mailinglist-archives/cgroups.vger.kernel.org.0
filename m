Return-Path: <cgroups+bounces-13881-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ckKeET9ijWl/1wAAu9opvQ
	(envelope-from <cgroups+bounces-13881-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 06:16:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D012A608
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 06:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DF1F302E858
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 05:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DF1233704;
	Thu, 12 Feb 2026 05:16:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FF761668;
	Thu, 12 Feb 2026 05:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770873404; cv=none; b=kLxD1GOTV6+LmPAb3LWTXNAWlggT0IA1JNc2p8g6Z4XO6wUe/Uj1eMDgNNE6tcm1a/xAa139upAkWDwFSJG2+3ho8RW+XwDEGhWhUnq6yyE4yfakM2iPJUdqDC16VYMSNTTjUgqTo0VlMw7//FRShB81uMTIa2gv0KSJCruScyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770873404; c=relaxed/simple;
	bh=bwUxVrY3k4wBqkypzd7fUBQxUMd/I+5Y1Cm0/ss2eYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOoPvtA5EBEIbVef/SqO0fYUxWHLyF/cEassHrP6XEuMKX+0pePVH+HSsfYmESkib6IkqXmZS2m7X5fx33vK5ESA54aK8iYPRXu0q1kHn3bTLQWtEwb0PMXHqQ4NsZXcU6adsur4uZAdn0hFn0/xMAWt87xAbI87/z009flkFU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA3F0339;
	Wed, 11 Feb 2026 21:16:35 -0800 (PST)
Received: from [10.164.148.47] (MacBook-Pro.blr.arm.com [10.164.148.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 118973F73F;
	Wed, 11 Feb 2026 21:16:37 -0800 (PST)
Message-ID: <331b6f7b-3b3e-49dc-9f20-b1e4df424fde@arm.com>
Date: Thu, 12 Feb 2026 10:46:34 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] memcg: use mod_node_page_state to update stats
To: Shakeel Butt <shakeel.butt@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <51819ca5a15d8928caac720426cd1ce82e89b429@linux.dev>
 <05aec69b-8e73-49ac-aa89-47b371fb6269@arm.com> <aYOuCmjQ5lGm8Mup@linux.dev>
 <4847c300-c7bb-4259-867c-4bbf4d760576@arm.com> <aYQuj6Ot-JS4tXvY@hyeyoo>
 <7df681ae0f8254f09de0b8e258b909eaacafadf4@linux.dev>
 <b77dc11e-fe09-4f0c-a912-d05faa01ff1c@arm.com> <aYtbevHEwx_3fn0Q@linux.dev>
 <5a6782f3-d758-4d9c-975b-5ae4b5d80d4e@arm.com> <aYxDkkDI4mk3r011@hyeyoo>
 <aYxIr5neJP8wBdZg@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aYxIr5neJP8wBdZg@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13881-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid]
X-Rspamd-Queue-Id: A92D012A608
X-Rspamd-Action: no action


On 11/02/26 2:54 pm, Shakeel Butt wrote:
> On Wed, Feb 11, 2026 at 05:53:38PM +0900, Harry Yoo wrote:
>> On Wed, Feb 11, 2026 at 01:07:40PM +0530, Dev Jain wrote:
>>> On 10/02/26 9:59 pm, Shakeel Butt wrote:
>>>> On Tue, Feb 10, 2026 at 01:08:49PM +0530, Dev Jain wrote:
>>>> [...]
>>>>>> Oh so it is arm64 specific issue. I tested on x86-64 machine and it solves
>>>>>> the little regression it had before. So, on arm64 all this_cpu_ops i.e. without
>>>>>> double underscore, uses LL/SC instructions. 
>>>>>>
>>>>>> Need more thought on this. 
>>>>>>
>>>>>>>> Also can you confirm whether my analysis of the regression was correct?
>>>>>>>>  Because if it was, then this diff looks wrong - AFAIU preempt_disable()
>>>>>>>>  won't stop an irq handler from interrupting the execution, so this
>>>>>>>>  will introduce a bug for code paths running in irq context.
>>>>>>>>
>>>>>>> I was worried about the correctness too, but this_cpu_add() is safe
>>>>>>> against IRQs and so the stat will be _eventually_ consistent?
>>>>>>>
>>>>>>> Ofc it's so confusing! Maybe I'm the one confused.
>>>>>> Yeah there is no issue with proposed patch as it is making the function
>>>>>> re-entrant safe.
>>>>> Ah yes, this_cpu_add() does the addition in one shot without read-modify-write.
>>>>>
>>>>> I am still puzzled whether the original patch was a bug fix or an optimization.
>>>> The original patch was a cleanup patch. The memcg stats update functions
>>>> were already irq/nmi safe without disabling irqs and that patch did the
>>>> same for the numa stats. Though it seems like that is causing regression
>>>> for arm64 as this_cpu* ops are expensive on arm64. 
>>>>
>>>>> The patch description says that node stat updation uses irq unsafe interface.
>>>>> Therefore, we had foo() calling __foo() nested with local_irq_save/restore. But
>>>>> there were code paths which directly called __foo() - so, your patch fixes a bug right
>>>> No, those places were already disabling irqs and should be fine.
>>> Please correct me if I am missing something here. Simply putting an
>>> if (!irqs_disabled()) -> dump_stack() in __lruvec_stat_mod_folio, before
>>> calling __mod_node_page_state, reveals:
>>>
>>> [ 6.486375] Call trace:
>>> [ 6.486376] show_stack+0x20/0x38 (C)
>>> [ 6.486379] dump_stack_lvl+0x74/0x90
>>> [ 6.486382] dump_stack+0x18/0x28
>>> [ 6.486383] __lruvec_stat_mod_folio+0x160/0x180
>>> [ 6.486385] folio_add_file_rmap_ptes+0x128/0x480
>>> [ 6.486388] set_pte_range+0xe8/0x320
>>> [ 6.486389] finish_fault+0x260/0x508
>>> [ 6.486390] do_fault+0x2d0/0x598
>>> [ 6.486391] __handle_mm_fault+0x398/0xb60
>>> [ 6.486393] handle_mm_fault+0x15c/0x298
>>> [ 6.486394] __get_user_pages+0x204/0xb88
>>> [ 6.486395] populate_vma_page_range+0xbc/0x1b8
>>> [ 6.486396] __mm_populate+0xcc/0x1e0
>>> [ 6.486397] __arm64_sys_mlockall+0x1d4/0x1f8
>>> [ 6.486398] invoke_syscall+0x50/0x120
>>> [ 6.486399] el0_svc_common.constprop.0+0x48/0xf0
>>> [ 6.486400] do_el0_svc+0x24/0x38
>>> [ 6.486400] el0_svc+0x34/0xf0
>>> [ 6.486402] el0t_64_sync_handler+0xa0/0xe8
>>> [ 6.486404] el0t_64_sync+0x198/0x1a0
>>>
>>> Indeed finish_fault() takes a PTL spin lock without irq disablement.
>> That indeed looks incorrect to me.
>> I was assuming __foo() is always called with IRQs disabled!
> Not necessarily. For stats which never get updated in IRQ context, can
> be updated using __foo() with just premption disabled.
>
>>>> I am working on adding batched stats update functionality in the hope
>>>> that will fix the regression.
>>> Thanks! FYI, I have zeroed in the issue on to preempt_disable(). Dropping this
>>> from _pcpu_protect_return solves the regression.
>> That's interesting, why is the cost of preempt disable/enable so high?
>>
> What made you (Dev) so convinced that preempt_disable is that expensive.

As I wrote above, dropping the preempt disable from _pcp_protect_return solved
the regression. So, it hints at the cost of this - although it seems surprising
that this may be expensive, so need to investigate : )

>
>>> Unlike x86, arm64 does a preempt_disable
>>> when doing this_cpu_*. On a cursory look it seems like this is unnecessary - since we
>>> are doing preempt_enable() immediately after reading the pointer, CPU migration is
>>> possible anyways, so there is nothing to be gained by reading pcpu pointer with
>>> preemption disabled. I am investigating whether we can simply drop this in general.
> [...]
>> ... so, removing preempt disable _in general_ is probably not a good idea.
>>
> Yup, I agree here.
>
>> [1] https://lore.kernel.org/all/20190311164837.GD24275@lakrids.cambridge.arm.com
>>
>> -- 
>> Cheers,
>> Harry / Hyeonggon
>>

