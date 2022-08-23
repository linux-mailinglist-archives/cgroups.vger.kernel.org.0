Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFB459EA2C
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 19:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiHWRsS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 13:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiHWRrk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 13:47:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB83AE9EE
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 08:43:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x19so13165532plc.5
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=WdZUWMe+w6NdkvEjJaHucwMuy21ym8cPJg6eP925ZQ0=;
        b=UhhdlLKQ2gDM2vQTqxNR3H3P54QELCmTYoRtFWOv3E2w4om1CvRbYVwedRQTd+Afao
         0qpcZIs3VEdxcpn3t4fBlWL3FsZsdeDru+azac3lUBr84uuKZTZ3mlZIQxwNYTEZ0+C3
         8myH9iaSwznHp48212VmuEt2w9h9vxetHBO1SHhA4XfmymVTL5vD34Si4OZGaZxmyCXq
         JZG25rmhvCeKVbiXdYQMg17r6Lw9PzEXpisKPi4dfNc9NyP3gXR5ayybTb+TbfD2MB3B
         gYFlnt6Ovve7/HS9Ci6ZQe4S/dcIGq/iyuwy9Rlll8tcHQ8vwDqGYJC8Fdolad+HrDWr
         CHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WdZUWMe+w6NdkvEjJaHucwMuy21ym8cPJg6eP925ZQ0=;
        b=BEYWvBUqKTsP1Fc9Z+3dHHvnjVJ8ZdQut7VEWsOHlg0/8/Bh24wWDkoLPqU6OehwJm
         TgyhXManwLVfuGT6OODKxwpFmQUHqmys1zD/uYhtLwqqmQOZeRyw7NzPmYgkdRV5kWIo
         duVmodzj/S2pLEzro60h8NvwqQugQEcmYyVxcef0qxHcTywixqGbGqPspZ7pqFHv00f3
         7j0H17uni5asg02ddnth7BPHAG5dsf0FLH64YKt50lPRVxUPv6S6BBs3ptms4eTz3t9B
         GrjEXKSAR/XYavKUb88dYciO66GxMTlMISktlwDfp2rFMF994cwrxmZ0+OrLN6IJULMA
         Yx2A==
X-Gm-Message-State: ACgBeo2oZ+9cX/7PqYvHNaUUPejsQ7w0iRb+dsPTnVNse3tV2vuJfrq0
        9sQ+Zyij76T9m4nipZH89e5Cwg==
X-Google-Smtp-Source: AA6agR7OpXoJDkm2+4ZBvbYX/W5se8d30EMUB4Q5KliLBfi18pBw/Gf4DLXJmE2fUpqYnxLetm9FLg==
X-Received: by 2002:a17:903:258f:b0:172:a6ac:1504 with SMTP id jb15-20020a170903258f00b00172a6ac1504mr24930414plb.60.1661269439249;
        Tue, 23 Aug 2022 08:43:59 -0700 (PDT)
Received: from [10.4.208.12] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id h16-20020a170902f55000b00172ad292b6bsm2148581plf.116.2022.08.23.08.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 08:43:58 -0700 (PDT)
Message-ID: <a562ede6-262c-b31b-4c96-75a69c265c41@bytedance.com>
Date:   Tue, 23 Aug 2022 23:43:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, corbet@lwn.net, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvKd6dezPM6UxfD/@slm.duckdns.org>
 <fcd0bd39-3049-a279-23e6-a6c02b4680a7@bytedance.com>
 <b89155d3-9315-fefc-408b-4cf538360a1c@bytedance.com>
 <YvPN07UlaPFAdlet@cmpxchg.org> <20220815132343.GA22640@blackbody.suse.cz>
 <9d1997a4-9278-07bd-7f57-952306b28b14@bytedance.com>
 <YwTz32VWuZeLHOHe@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YwTz32VWuZeLHOHe@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/8/23 23:35, Johannes Weiner wrote:
> On Tue, Aug 23, 2022 at 02:18:21PM +0800, Chengming Zhou wrote:
>> On 2022/8/15 21:23, Michal Koutný wrote:
>>> On Wed, Aug 10, 2022 at 11:25:07AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>> cgroup.pressure.enable sounds good to me too. Or, because it's
>>>> default-enabled and that likely won't change, cgroup.pressure.disable.
>>>
>>> Will it not change?
>>>
>>> I'd say that user would be interested in particular level or even just
>>> level in subtree for PSI, so the opt-out may result in lots of explicit
>>> disablements (or even watch for cgroups created and disable PSI there)
>>> to get some performance back.
>>>
>>> I have two suggestions based on the above:
>>> 1) Make the default globally configurable (mount option?)
>>> 2) Allow implicit enablement upon trigger creation
>>>
>>
>> I think suggestion 1) make sense in some use case, like make per-cgroup
>> PSI disabled by default using a mount option, then enable using the
>> "cgroup.pressure" interface.
>>
>> But suggestion 2) auto enable upon trigger creation, if we hide the
>> {cpu,memory,io}.pressure files when disabled, how can we create trigger?
>>
>> Want to see what do Johannes and Tejun think about these suggestions?
> 
> Re 1: I agree. If desired in the future we can make the default
> configurable. Kconfig, mount option, what have you. cgroup.pressure
> will work fine as a name regardless of what the default is.
> 
> Re 2: Not all consumers of the pressure metrics create trigger. I
> would argue that few do. So it isn't the best signal to decide on
> whether aggregation should occur. And yes, it's further complicated by
> the triggers being written to the very pressure files. If we don't
> hide them, we have to come up with another way to mark them as stale,
> lest they confuse the heck out of users. Without breaking format...
> 
> So IMO, default-enable, "cgroup.pressure" as a name, and hiding the
> pressure files should be good for now while allowing to make the
> default configurable down the line.

Agree, it's what we want for now. Thanks for your reply!


