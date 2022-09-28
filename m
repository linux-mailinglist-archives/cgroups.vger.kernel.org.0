Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355525ED6E3
	for <lists+cgroups@lfdr.de>; Wed, 28 Sep 2022 09:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiI1HzQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Sep 2022 03:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiI1Hy4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Sep 2022 03:54:56 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6E2D7D;
        Wed, 28 Sep 2022 00:54:39 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1odRts-0007n0-5Z; Wed, 28 Sep 2022 09:54:36 +0200
Message-ID: <a66880d7-fc2e-4fa7-0711-5d93b4304607@leemhuis.info>
Date:   Wed, 28 Sep 2022 09:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, de-DE
To:     Vlastimil Babka <vbabka@suse.cz>,
        Anatoly Pugachev <matorola@gmail.com>,
        Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, cgroups@vger.kernel.org,
        sparclinux@vger.kernel.org, regressions@lists.linux.dev
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org>
 <20220918092849.GA10314@u164.east.ru>
 <eca7d9b3-9831-5d04-1f39-8976765df87a@suse.cz>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [sparc64] fails to boot, (was: Re: [PATCH memcg v6] net: set
 proper memcg for net_init hooks allocations)
In-Reply-To: <eca7d9b3-9831-5d04-1f39-8976765df87a@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664351679;1649a21f;
X-HE-SMSGID: 1odRts-0007n0-5Z
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 27.09.22 11:54, Vlastimil Babka wrote:
> On 9/18/22 11:28, Anatoly Pugachev wrote:
>> On Fri, Jun 03, 2022 at 07:19:43AM +0300, Vasily Averin wrote:
>>> __register_pernet_operations() executes init hook of registered
>>> pernet_operation structure in all existing net namespaces.
>> [...]
>> I'm unable to boot my sparc64 VM anymore (5.19 still boots, 6.0-rc1 does not),
>> bisected up to this patch,
>>
>> mator@ttip:~/linux-2.6$ git bisect bad
>> 1d0403d20f6c281cb3d14c5f1db5317caeec48e9 is the first bad commit
>> commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9
>> [...]
> 
> #regzbot introduced: 1d0403d20f6c

Thx for getting this regression tracked using regzbot. FWIW, that went
sideways (as your already noticed and mentioned on IRC), as that made
regzbot treat *your* mail as the report of the regressions. In cases
like this you need "#regzbot ^introduced 1d0403d20f6c" (since recently
"#regzbot introduced 1d0403d20f6c ^" works, too), as then regzbot will
consider the *parent* mail the report (and then regzbot will look out
for patches that link to them using a Link: tag).

No worries, I did the same mistake a few time already :-D I send a mail
with that command now, so let's resolve this subthread by marking it invalid

#regzbot invalid: mis-used regzbot command, now properly tracked

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

