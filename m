Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80663DF956
	for <lists+cgroups@lfdr.de>; Wed,  4 Aug 2021 03:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhHDBkw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 21:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229869AbhHDBkw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Aug 2021 21:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628041239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=prEBRZoKY0mhe0m86DgKhDz/qFG3iaSQj/eiWjJyZK8=;
        b=AeGb706gsOlnqpA0U6aFrZxBFoVossX+31dgBxHLzYFamSRzwlO+hpZngv5dSN+EbSjzFe
        Pw0M03Zs+Ihvk34/txxBq4raI0TEIv+tpwPkjcKC9DHnRJ3VC3Zg3M7YUakbHRoQAFU4zU
        /K85QhFBnFU5HlIws9mwLiGpEc0NlWM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-x-OrBpuvNZK_nHHROo-PMA-1; Tue, 03 Aug 2021 21:40:38 -0400
X-MC-Unique: x-OrBpuvNZK_nHHROo-PMA-1
Received: by mail-qk1-f198.google.com with SMTP id p14-20020a05620a22eeb02903b94aaa0909so1050922qki.15
        for <cgroups@vger.kernel.org>; Tue, 03 Aug 2021 18:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=prEBRZoKY0mhe0m86DgKhDz/qFG3iaSQj/eiWjJyZK8=;
        b=OOF9xswd955ZTWCNDGLkTeLzQ/E6UjcOP1vggAxJt4ZMDothNzHnWn43zzv5b3ane4
         04OgQqWMRDVvRqCQuXaVLSEGT2+3lF+CqYAWoGDQ/rV4ruRYfRjB3E/1JvjYeGYxNOgM
         BGgxyPuwQ4LbTXU/2FuEUu+OoDnwiDZZka3+875vaxeyQVRwc5XYFJfqaL6k4OQ1HnUy
         2AEAy4sVeG8ixYcT1I7mVbwFMrn6vafGhbRkFSg5dbhwPYBlG7BwnFeQRfRehN4EW7qZ
         fKG/OMaJksyo8qOmDlZ6Ee+IQzVIfdAbutMDRMHPS+k7E73ubkHtoETLVsnklX7KU2+Q
         L1xg==
X-Gm-Message-State: AOAM530zz1FnbEp3WDbz955BshoWoGsfdTZGFSwmMiBZl2RsbMjYlP1k
        2WrJaxUrSORrvzWh2I2Y/41iN38RTf2bCuWnk06rEOTai/RQ94yiLanLujN32HKshIMT/VGyt+A
        fMmN2t5pMCRKORCLV6Q==
X-Received: by 2002:a05:6214:3a4:: with SMTP id m4mr24172390qvy.17.1628041238103;
        Tue, 03 Aug 2021 18:40:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8EWOBC1RHCyAbVwynmIEQicD29HOr33gfx2qHwud9l8mmYV9gdbAOwj5Mm31YWDE03ccxrg==
X-Received: by 2002:a05:6214:3a4:: with SMTP id m4mr24172377qvy.17.1628041237922;
        Tue, 03 Aug 2021 18:40:37 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id b1sm306006qtq.12.2021.08.03.18.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 18:40:37 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] mm/memcg: Disable task obj_stock for PREEMPT_RT
To:     Thomas Gleixner <tglx@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Luis Goncalves <lgoncalv@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210803175519.22298-1-longman@redhat.com> <87h7g62jxm.ffs@tglx>
Message-ID: <8953e099-356e-ee09-a701-f4c7f4cda487@redhat.com>
Date:   Tue, 3 Aug 2021 21:40:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87h7g62jxm.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/3/21 7:21 PM, Thomas Gleixner wrote:
> Waiman,
>
> On Tue, Aug 03 2021 at 13:55, Waiman Long wrote:
>
> please Cc RT people on RT related patches.
>
>> For PREEMPT_RT kernel, preempt_disable() and local_irq_save()
>> are typically converted to local_lock() and local_lock_irqsave()
>> respectively.
> That's just wrong. local_lock has a clear value even on !RT kernels. See
>
>    https://www.kernel.org/doc/html/latest/locking/locktypes.html#local-lock
>
I understand what local_lock is for. For !RT kernel, local_lock() still 
requires the use of a pseudo_lock which is not the goal of this patch to 
put one there.
>> These two variants of local_lock() are essentially
>> the same.
> Only on RT kernels.
That is right. So this is a change aimed for easier integration with RT 
kernel.
>
>> + * For PREEMPT_RT kernel, preempt_disable() and local_irq_save() may have
>> + * to be changed to variants of local_lock(). This eliminates the
>> + * performance advantage of using preempt_disable(). Fall back to always
>> + * use local_irq_save() and use only irq_obj for simplicity.
> Instead of adding that comment you could have just done the full
> conversion, but see below.
Well, I can do that if you want me to.
>
>>    */
>> +static inline bool use_task_obj_stock(void)
>> +{
>> +	return !IS_ENABLED(CONFIG_PREEMPT_RT) && likely(in_task());
>> +}
>> +
>>   static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
>>   {
>>   	struct memcg_stock_pcp *stock;
>>   
>> -	if (likely(in_task())) {
>> +	if (use_task_obj_stock()) {
>>   		*pflags = 0UL;
>>   		preempt_disable();
>>   		stock = this_cpu_ptr(&memcg_stock);
> This is clearly the kind of conditional locking which is frowned upon
> rightfully.
>
> So if we go to reenable memcg for RT we end up with:
>
> 	if (use_task_obj_stock()) {
>             preempt_disable();
>          } else {
>             local_lock_irqsave(memcg_stock_lock, flags);
>          }
>          
> and further down we end up with:
The purpose of this series is to improve kmem_cache allocation and free 
performance for non-RT kernel. So not disabling/enabling interrupt help 
a bit in this regard.
>
>> @@ -2212,7 +2222,7 @@ static void drain_local_stock(struct work_struct *dummy)
>>   
>>   	stock = this_cpu_ptr(&memcg_stock);
>>   	drain_obj_stock(&stock->irq_obj);
>> -	if (in_task())
>> +	if (use_task_obj_stock())
>>   		drain_obj_stock(&stock->task_obj);
>>   	drain_stock(stock);
>>   	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
>> Thanks,
>>
>>          tglx
>>
>
> 	/*
> 	 * The only protection from memory hotplug vs. drain_stock races is
> 	 * that we always operate on local CPU stock here with IRQ disabled
> 	 */
> -	local_irq_save(flags);
> +	local_lock_irqsave(memcg_stock_lock, flags);
>          ...
> 	if (use_task_obj_stock())
>    		drain_obj_stock(&stock->task_obj);
>
> which is incomprehensible garbage.
>
> The comment above the existing local_irq_save() is garbage w/o any local
> lock conversion already today (and even before the commit which
> introduced stock::task_obj) simply because that comment does not explain
> the why.
That comment was added by commit 72f0184c8a00 ("mm, memcg: remove 
hotplug locking from try_charge"). It was there before my commits.

>
> I can just assume that for stock->task_obj the IRQ protection is
> completely irrelevant. If not and _all_ members of stock have to be
> protected against memory hotplug by disabling interrupts then any other
> function which just disables preemption is broken.
That is correct specifically for task_obj, but not for other data.
>
> To complete the analysis of drain_local_stock(). AFAICT that function
> can only be called from task context. So what is the purpose of this
> in_task() conditional there?
>
> 	if (in_task())
>    		drain_obj_stock(&stock->task_obj);
I haven't done a full analysis to see if it can be called from task 
context only. Maybe in_task() check isn't needed, but having it there 
provides the safety that it will still work in case it can be called 
from interrupt context.
>
> I assume it's mechanical conversion of:
>
> -       drain_obj_stock(stock);
> +       drain_obj_stock(&stock->irq_obj);
> +       if (in_task())
> +               drain_obj_stock(&stock->task_obj);
>
> all over the place without actually looking at the surrounding code,
> comments and call sites.
>
> This patch is certainly in line with that approach, but it's just adding
> more confusion.

What is your suggestion for improving this patch?

Cheers,
Longman

