Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6026C4CC97D
	for <lists+cgroups@lfdr.de>; Thu,  3 Mar 2022 23:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiCCWzB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Mar 2022 17:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiCCWzA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Mar 2022 17:55:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A06EC5F4
        for <cgroups@vger.kernel.org>; Thu,  3 Mar 2022 14:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=WhlL7h61341iIESeWTlGbuGhMPR1lyzTfnmPlu4dcLQ=; b=SCFq8+cO6okq1ihYq2bG0Y1KNL
        AdmVymHxeldmywraXF2E/01Df0bz2MzSsQbpLLy4eD7iL2hltsD/4KXshR4FmgEp3vNhjyv9C94n+
        r42JfSLPt8b6a+pAo7vx3UajGo1JZi9bpNegCTmSLaXHJJFzsOKU2PqJ5UPSjoYD6tN6gMQA6pXeY
        Oh2sGCJ8qeT2mpBtzfjfINkRtttkHBXJjHs8xlRMLgQIdNqdqJBQkXpiq42qvedN4f9IDnGLLYFae
        DlPxT5/h4R9ZA7udADgVmsGtNDtMBGKN84O9S9kKdGfHx+tPuIvBhjrMJ9PX4mMb0a5Lgof8bVfGX
        ArPe3CUg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPuKi-00C3nL-37; Thu, 03 Mar 2022 22:54:04 +0000
Message-ID: <8c61e14d-493d-ecea-6bc5-076781e8e93d@infradead.org>
Date:   Thu, 3 Mar 2022 14:53:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] mm/memcontrol: return 1 from cgroup.memory __setup()
 handler
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     linux-mm@kvack.org, Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org
References: <20220222005811.10672-1-rdunlap@infradead.org>
 <20220302185300.GA19699@blackbody.suse.cz>
 <9f8d4ddb-81ce-738a-d1f7-346ff9bf8ebd@infradead.org>
 <20220303101406.GE10867@blackbody.suse.cz>
 <5130da56-0f22-8212-0ea3-6ddb8a8f5455@infradead.org>
 <YiFCAFZwG//aeQP2@blackbook>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YiFCAFZwG//aeQP2@blackbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 3/3/22 14:32, Michal Koutný wrote:
> On Thu, Mar 03, 2022 at 01:53:03PM -0800, Randy Dunlap <rdunlap@infradead.org> wrote:
>>> Isn't mere presence of the handler sufficient to filter those out? [1]
>>
>> What is [1] here?
> 
> Please ignore, too much editing on my side.
> 
>> I don't know of any case where "foo=2" should be passed to init if
>> there is a setup function for "foo=" defined.
> 
> Good. I was asking because of the following semantics:
> - absent handler -- pass to init,

Ack: if the handler code is not built, it is an Unknown boot option
and is passed to init.

> - returns 0 -- filter out,
> - returns negative -- filter out, print message.

Currently setup functions should return 1 (or any non-zero value)
to indicate "handled" or should return 0 to indicate "not handled".

Andrew has a patch in mmotm: include/linux/init.h so that the comment
before __setup() says:

/*
 * NOTE: __setup functions return values:
 * @fn returns 1 (or non-zero) if the option argument is "handled"
 * and returns 0 if the option argument is "not handled".
 */

>>> (Richer reporting or -EINVAL is by my understanding now a different
>>> problem.)

-- 
~Randy
