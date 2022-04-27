Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6393551253A
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 00:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiD0W1Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 18:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiD0W1P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 18:27:15 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893C02E685
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 15:24:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p12so5508396lfs.5
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 15:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oLug1+azcE2h7QMeDbpYAnTwrafPSTpRFVPk0zNJveg=;
        b=zI/nSf1n1K3Do1i5nBCb7lwViY+DJKmUvfVcoGHl/Q5SvQj83PNn1mVYoRuClPrpw9
         sCkAImuE2tFKtQFVPcYA9jGml9m/Bwy/ymA5Te4m1zi4dRCXKacQNmNJgYeS0VEfkWbh
         FvpiNqvdCThOvFYOiROhJZSsBkCxP0ox1W6C1im3DrClwe4LGTwoTkmKjqIyNiDE7bF0
         IWrLpdiZfx31n46ZBikenK9K101cENCfFgSuYqLOkJ+QkFHBJEC++7GoEDz9r43mo8AA
         LxJWR0R9yV0SBiYBa/bFhSnWkwE1pEHgs0W4l9FVYG8LeYNpO4bMEe33NvulIrzx7+7e
         S/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oLug1+azcE2h7QMeDbpYAnTwrafPSTpRFVPk0zNJveg=;
        b=Y+l7I552N0g6jGSAvPzXBdWhJwmq5UvLG0z9EePUWkcCAiJFoICnZdvC4u05eOj6c0
         CJL+scacXDmSi3ErY3/10U0KRbBGw2jUdppxuKLJ4tnmg7/TUkcYeZM44BOu4YoH/5Nv
         N08miJcTDx4vpeiA+ki+0PHEBcosWSvb4/2e+t0dNZon/xf3UfkgtzZ+3ODtfRtoiLpl
         rAGcR5dPufOStE3TXCpQjP/ftiUXkVk5Ea2OxujinkMAEWbYsrigJ1sv3TQYjLEm6kzE
         ue12pnfS6nzDL96ggQyMg4mW7aUUYwEoi4N2FXvSTtQlroWYkfN7RY41Jvylv8Sa6iNu
         K6AQ==
X-Gm-Message-State: AOAM530aHRzR0LMJy+942qc9RLwZg/P6OJn3xbyOWxExzpEDfw6IErsx
        nmVXHEhjQfpcIrsmrKjhRM/ui7xJ/qqTZvDy
X-Google-Smtp-Source: ABdhPJz1TeiDRK9Dtg2V4JeedZUcQpLNTqRFf/nLyars8/MHGhWw+9q7854+9snyo0BcYh5sVqbLYg==
X-Received: by 2002:a2e:a593:0:b0:24d:b9a6:b85c with SMTP id m19-20020a2ea593000000b0024db9a6b85cmr5137954ljp.309.1651097815894;
        Wed, 27 Apr 2022 15:16:55 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id a5-20020a2e9805000000b0024f12f0eb37sm999061ljj.95.2022.04.27.15.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 15:16:55 -0700 (PDT)
Message-ID: <6b18f82d-1950-b38e-f3f5-94f6c23f0edb@openvz.org>
Date:   Thu, 28 Apr 2022 01:16:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH memcg v4] net: set proper memcg for net_init hooks
 allocations
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, kernel@openvz.org,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Cgroups <cgroups@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <YmdeCqi6wmgiSiWh@carbon>
 <33085523-a8b9-1bf6-2726-f456f59015ef@openvz.org>
 <CALvZod4oaj9MpBDVUp9KGmnqu4F3UxjXgOLkrkvmRfFjA7F1dw@mail.gmail.com>
 <20220427122232.GA9823@blackbody.suse.cz>
 <CALvZod7v0taU51TNRu=OM5iJ-bnm1ryu9shjs80PuE-SWobqFg@mail.gmail.com>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <CALvZod7v0taU51TNRu=OM5iJ-bnm1ryu9shjs80PuE-SWobqFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/27/22 18:06, Shakeel Butt wrote:
> On Wed, Apr 27, 2022 at 5:22 AM Michal Koutný <mkoutny@suse.com> wrote:
>>
>> On Tue, Apr 26, 2022 at 10:23:32PM -0700, Shakeel Butt <shakeelb@google.com> wrote:
>>> [...]
>>>>
>>>> +static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
>>>> +{
>>>> +       struct mem_cgroup *memcg;
>>>> +
>>>
>>> Do we need memcg_kmem_enabled() check here or maybe
>>> mem_cgroup_from_obj() should be doing memcg_kmem_enabled() instead of
>>> mem_cgroup_disabled() as we can have "cgroup.memory=nokmem" boot
>>> param.

Shakeel, unfortunately I'm not ready to answer this question right now.
I even did not noticed that memcg_kmem_enabled() and mem_cgroup_disabled()
have a different nature.
If you have no objections I'm going to keep this place as is and investigate
this question later. 

>> I reckon such a guard is on the charge side and readers should treat
>> NULL and root_mem_group equally. Or is there a case when these two are
>> different?
>>
>> (I can see it's different semantics when stored in current->active_memcg
>> (and active_memcg() getter) but for such "outer" callers like here it
>> seems equal.)

Dear Michal,
I may have misunderstood your point of view, so let me explain my vision
in more detail.
I do not think that NULL and root_mem_cgroup are equal here:
- we have enabled cgroups and well-defined root_mem_cgroup,
- this function is called from inside memcg-limited container,
- we tried to get memcg from net, but without success,
  and as result got NULL from  mem_cgroup_from_obj()
  (frankly speaking I do not think this situation is really possible)
If we keep memcg = NULL, then current's memcg will not be masked and
net_init's allocations will be accounted to current's memcg. 
So we need to set active_memcg to root_mem_cgroup, it helps to avoid
incorrect accounting.

> I was more thinking about possible shortcut optimization and unrelated
> to this patch.
> 
> Vasily, can you please add documentation for get_mem_cgroup_from_obj()
> similar to get_mem_cgroup_from_mm()? Also for mem_cgroup_or_root().
> Please note that root_mem_cgroup can be NULL during early boot.

Ok, thank you for the remark, I'll improve it in next patch version.

Thank you,
	Vasily Averin
