Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05618519B09
	for <lists+cgroups@lfdr.de>; Wed,  4 May 2022 11:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbiEDJEh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 May 2022 05:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346889AbiEDJEE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 May 2022 05:04:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A5063FB
        for <cgroups@vger.kernel.org>; Wed,  4 May 2022 02:00:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w19so1189725lfu.11
        for <cgroups@vger.kernel.org>; Wed, 04 May 2022 02:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9h40UHG4+Vlt8Ck/eT8J9TW5C6yu4qO7t/1/LFEGiqY=;
        b=WV8AFjx0yOFxd5rVjjr2sLJ5mz+V5+uLTb8SILkuM1yrcMqzUSvPWiS2mpZw8xGb4r
         9qZ4I/VkzSXsP28HaPRPIrFVlF/ASJZx9O7CTX8EzLap0XCMvySddHQy7j98gc1T3N+w
         5C6I73NA84YBQltR4hG9pjh9Ip9cTCZicfKpbFFzp0NtpwgxPD/AH1MC8Lp0hvqVwJqC
         YXkbk/fZs0S5ef8KwZ0KTWOZHNzZiICXs9YcutrZ5rkun9sYbnD8JpXfWJgA8fFTrzFD
         MpWCsX9wWoxokW6zDRuaLX48cKgi+EoPmdbIPxi1GGEW7QJDhnMkWuLmbpidhOenlIf4
         rdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9h40UHG4+Vlt8Ck/eT8J9TW5C6yu4qO7t/1/LFEGiqY=;
        b=A3bqw6hHaYD3+Zv7wUavLrKaEBeQCFzEqFbOXt43Oog7m7LL6rl9Q3/Jf0XFpywG6u
         Zg8PLCfvwpQIOB0+QdTeXxt5FooyThzYKDW5geVUh8fuNUVOtbzNpRSOtlVuP0N47EUH
         SHjA3ZFDqdQWeLPoBgXLd49u4JE/47KPvUKhOO43IYgKuoES/7DUz8Cq9KAS2UZYHpUd
         GUbAYQ6qYGAa7SpNtRMx2DLxbo4bih7sKVezeqs3C0MGaMV5RHoLb6+dxvn+r4xu0AAW
         crBd43igk+6NlNVyWDjHhk5FcPLAszjUqXFnw6W8jWNfbB49zzJBlre5IGkAL8sD82ma
         h33g==
X-Gm-Message-State: AOAM530YAgng6WLJeFOrSt39ygorqu62nNh1f8jUtX4BOZckMJy4prib
        zFF496kN0QVLIxVC0fQPX3+4hw==
X-Google-Smtp-Source: ABdhPJziPdsSe7MlyMs4jK++JOgvd87NWYOeCBg4hkkKvteIrGgQq5sUczFdQtMM55Ef2i7SPN5aBQ==
X-Received: by 2002:a05:6512:1085:b0:472:1013:aac7 with SMTP id j5-20020a056512108500b004721013aac7mr13587675lfg.463.1651654821736;
        Wed, 04 May 2022 02:00:21 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id u20-20020ac243d4000000b0047255d21143sm1154631lfl.114.2022.05.04.02.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 02:00:21 -0700 (PDT)
Message-ID: <52a9f35b-458b-44c4-7fc8-d05c8db0c73f@openvz.org>
Date:   Wed, 4 May 2022 12:00:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: kernfs memcg accounting
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
References: <7e867cb0-89d6-402c-33d2-9b9ba0ba1523@openvz.org>
 <20220427140153.GC9823@blackbody.suse.cz>
 <7509fa9f-9d15-2f29-cb2f-ac0e8d99a948@openvz.org>
 <YnBLge4ZQNbbxufc@blackbook>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YnBLge4ZQNbbxufc@blackbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/3/22 00:22, Michal Koutný wrote:
> When struct mem_cgroup charging was introduced, there was a similar
> discussion [1].

Thank you, I'm missed this patch, it was very interesting and useful.
I would note though, that OpenVZ and LXC have another usecase:
we have separate and independent systemd instances inside OS containers.
So container's cgroups are created not in host's root memcg but 
inside accountable container's root memcg.  

> I can see following aspects here:
> 1) absolute size of kernfs_objects,
> 2) practical difference between a) and b),
> 3) consistency with memcg,
> 4) v1 vs v2 behavior.
...
> How do these reasonings align with your original intention of net
> devices accounting? (Are the creators of net devices inside the
> container?)

It is possible to create netdevice in one namespace/container 
and then move them to another one, and this possibility is widely used.
With my patch memory allocated by these devices will be not accounted
to new memcg, however I do not think it is a problem.
My patches protect the host mostly from misuse, when someone creates
a huge number of nedevices inside a container.

>> Do you think it is incorrect and new kernfs node should be accounted
>> to memcg of parent cgroup, as mem_cgroup_css_alloc()-> mem_cgroup_alloc() does?
> 
> I don't think either variant is incorrect. I'd very much prefer the
> consistency with memcg behavior (variant a)) but as I've listed the
> arguments above, it seems such a consistency can't be easily justified.

From my point of view it is most important to account allocated memory
to any cgroup inside container. Select of proper memcg is a secondary goal here.
Frankly speaking I do not see a big difference between memcg of current process,
memcg of newly created child and memcg of its parent.

As far as I understand, Roman chose the parent memcg because it was a special
case of creating a new memory group. He temporally changed active memcg
in mem_cgroup_css_alloc() and properly accounted all required memcg-specific
allocations.
However, he ignored accounting for a rather large struct mem_cgroup
therefore I think we can do not worry about 128 bytes of kernfs node.
Yes, it will be accounted to some other memcg, but the same thing
happens with kernfs nodes of other groups.
I don't think that's a problem.

>> Perhaps you mean that in this case kernfs should not be counted at all,
>> as almost all neighboring allocations do?
> 
> No, I think it wouldn't help here [2]. (Or which neighboring allocations
> do you mean? There must be at least nr_cgroups of them.)

Primary I mean here struct mem_cgroup allocation in mem_cgroup_alloc().
However, I think we need to take into account any other distributions called
inside cgroup_mkdir: struct cgroup and kernefs node in common part and 
any other cgroup-cpecific allocations in other .css_alloc functions.
They all can be called from inside container, allocates non-accountable
memory and by this way theoretically can be misused.
So I'm going to check this scenario a bit later.

Thank you,
	Vasily Averin
