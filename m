Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B154CB3EB
	for <lists+cgroups@lfdr.de>; Thu,  3 Mar 2022 02:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiCCAyY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Mar 2022 19:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiCCAyX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Mar 2022 19:54:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D6F4E387
        for <cgroups@vger.kernel.org>; Wed,  2 Mar 2022 16:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=CYkF4j9ODOf6PWDsqe5HpkOYKbyWN1x6jkFXxFgeeIM=; b=PIczBbwmNfBbdA0anRDnP9sLT/
        D3I9C7NxiY8yS5fxYRvD+X1Y8NvnQsAJ6KbMn84+WnmOEZa+a3EleuPGwa0XtNrxd/DGw/ef1rtU1
        3bIf2Ys5DyFChgu/ygcGG8BnMmFukl2vNmbxFArASFSZY6ZyT0XLRlLQa8fSBlXNPCjJoowfq4jS9
        bp+QFItZn2MI13nEq4VGHgZejK9Npe9yw+z2aObmhsMYU9751wB+FsdPvNlHBJng2wtpaCJ5DwQqC
        lk3yguR7pD9mPkSib4B1IcaZyooSafWXX2OS9hQcj3fEAcyqabJ6+MSKUbxvAzcBFKIHSE/Qq0kaC
        PiXVDfqQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPZif-00Eko6-Op; Thu, 03 Mar 2022 00:53:26 +0000
Message-ID: <9f8d4ddb-81ce-738a-d1f7-346ff9bf8ebd@infradead.org>
Date:   Wed, 2 Mar 2022 16:53:19 -0800
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
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220302185300.GA19699@blackbody.suse.cz>
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



On 3/2/22 10:53, Michal Koutný wrote:
> On Mon, Feb 21, 2022 at 04:58:11PM -0800, Randy Dunlap <rdunlap@infradead.org> wrote:
>> __setup() handlers should return 1 if the command line option is handled
>> and 0 if not (or maybe never return 0; it just pollutes init's environment).
> 
> Interesting.
> 
>> Instead of relying on this '.' quirk, just return 1 to indicate that
>> the boot option has been handled.
> 
> But your patch would return 1 even when no accepted value was passed,
> i.e. is the command line option considered handled in that case?

Yes, for some definition of "handled."  It was seen by the __setup handler.

> Did you want to return 1 only when the cgroup.memory= value is
> recognized?

Not really. I did consider that (for all of the similar patches that I am
posting).

I don't think those strings (even with invalid option values) should be
added to init's environment.

I'm willing to add a pr_warn() or pr_notice() for any unrecognized
option value, but it should still return 1 IMO.

-- 
~Randy
