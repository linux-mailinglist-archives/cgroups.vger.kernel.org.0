Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F84E488E08
	for <lists+cgroups@lfdr.de>; Mon, 10 Jan 2022 02:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiAJB2e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 9 Jan 2022 20:28:34 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30263 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiAJB2d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 9 Jan 2022 20:28:33 -0500
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JXGRF3Bj3zbjhR;
        Mon, 10 Jan 2022 09:27:53 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 09:28:31 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 09:28:30 +0800
Subject: Re: [PATCH v5 2/2] block: cancel all throttled bios in del_gendisk()
To:     <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>
CC:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        <hch@infradead.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20211210083143.3181535-1-yukuai3@huawei.com>
 <20211210083143.3181535-3-yukuai3@huawei.com>
 <20220107150519.GA26824@blackbody.suse.cz> <YdiuN9kv5OvE/Rtf@slm.duckdns.org>
 <20220107213612.GQ4202@paulmck-ThinkPad-P17-Gen-1>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <9e318511-b33c-37c6-8ffd-75302280246d@huawei.com>
Date:   Mon, 10 Jan 2022 09:28:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220107213612.GQ4202@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/01/08 5:36, Paul E. McKenney 写道:
> On Fri, Jan 07, 2022 at 11:18:47AM -1000, Tejun Heo wrote:
>> Hello,
>>
>> On Fri, Jan 07, 2022 at 04:05:19PM +0100, Michal Koutný wrote:
>>> On Fri, Dec 10, 2021 at 04:31:43PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
>>>> +	 * queue_lock is held, rcu lock is not needed here.
>>>> +	 */
>>>> +	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg)
>>>> +		tg_drain_bios(&blkg_to_tg(blkg)->service_queue);
>>>
>>> FTR, I acknowledge this can work due to RCU peculiarities, however, I
>>> don't understand why is it preferred against more robust explict
>>> rcu_read_lock().
>>>
>>> (All in all, this isn't a deal breaker and I'm not confident evaluating
>>> the rest of the patch.)
>>
>> Cc'ing Paul for RCU. Paul, this nit is around whether or not to use
>> rcu_read_lock() in an irq disabled section. I can see both sides of the
>> arguments - it's weird to put in an extra rcu_read_lock() when technically
>> unnecessary but it's also nice to have something explicit and structured to
>> mark parts which require RCU protection. Putting in a comment is okay but
>> consistency is difficult to achieve that way.
>>
>> Maybe all these are unnecessary as lockdep would be able to catch them
>> anyway, or maybe we'd want something to explicitly mark RCU protected
>> sections. I don't know but whichever way, I think we need to establish a
>> convention.
> 
> The easiest thing to do is to use rcu_dereference_sched() instead of
> rcu_dereference().  This will cause lockdep to insist on preemption
> (for example, interrupts) being disabled.
> 
> Or is this a case where a function containing rcu_dereference() is invoked
> with interrupts disabled from some call sites and under rcu_read_lock()
> protection from other call sites?  In this case, it is usually best to
> include that redundant rcu_read_lock() [1].

Hi,

This is the later case, so I guess I'll include that redundant
rcu_read_lock().

Thanks,
Kuai
> 
> 							Thanx, Paul
> 
> [1]	If you are a glutton for punishment, or if you would otherwise
> 	have to add a cubic goatskin of rcu_read_lock() calls, you
> 	could instead write this priceless gem in place of the calls to
> 	rcu_dereference() in that common function:
> 
> 	p = rcu_dereference_check(ptr, rcu_read_lock_sched_held());
> 
> 	This would cause lockdep to be happy with either rcu_read_lock()
> 	or preemption being disabled.
> 
> 	This is more precise, and would be preferable in some cases,
> 	for example, if there were lots of hotpath callsites with
> 	interrupts disabled.  "Do we add 25 pairs of rcu_read_lock()
> 	and rcu_read_unlock()?	Or do we add just the one ugly
> 	rcu_dereference_check()?"
> .
> 
