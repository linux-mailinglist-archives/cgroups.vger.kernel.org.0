Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF3756D0E6
	for <lists+cgroups@lfdr.de>; Sun, 10 Jul 2022 20:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiGJSxj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 10 Jul 2022 14:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJSxi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 10 Jul 2022 14:53:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17621B879
        for <cgroups@vger.kernel.org>; Sun, 10 Jul 2022 11:53:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u13so5511448lfn.5
        for <cgroups@vger.kernel.org>; Sun, 10 Jul 2022 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MjnWXdJX+ay9kx38kvyoZNCAXjqkrOK+MR+sD5e42MA=;
        b=cCAnTvGpgv1VOxq4QkKFQPUKm0OlnZAicTALdTpQkPW6ZkfzK5lfFKgErveXFEI1Wd
         MpatJxtSvCVNb95GYpikEYkKUaEBzwBkS6TTqh+P+ByzCWcD91l/slOwCYBvcoyDdiMP
         5U32Dk4It78u4TtWOvdC+Q2jefWz2Al03roAtnxw6M9T7VrkgpbUXJTLFdFHU5zpxEF1
         5MGKdk5/L6AomK9B5OhwJK0Oru6FNGSTj+8GrmvdRjVKZ3n4gqdRSpQTiCYNkpw1E2I4
         8nE96IEzRTQRZEDAwq0erFlfDJd8w6p28D+5kWQ5nF3YFdUXUoSQCpFFdkEIxGT0n0kb
         JaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MjnWXdJX+ay9kx38kvyoZNCAXjqkrOK+MR+sD5e42MA=;
        b=Kc8YD2+CLP1oKDXoMwAQpQm9YpdjUANYKlJRczmlTZDwoOyyzPoy2JYTGb7Ts9aL7Q
         AvQwVdZxy28uodXHME+IIV7jLCDgKl2LloGsJdHz8TJqEWv+EEvlcMCF4BEC6tbqwUkP
         YtKkz+IHLHhhYx1oE+Bmd3nOvj6jjfoo5TK0EPOg2DnPpwgwEN8bpM8BfFD4QdqiN+kS
         6LjU7aHc2GnIlMEdYGW9JCXMteBLOyrjGYuh67jXWe0ZcmGnnqMH+vArLuLsGVNpqyWu
         08mvJv8vdgXULQGtdkXtQFvvBozIzy7Phj67dUE1AoAvA/O+QItzVV9lzaOgQBtXn4p/
         pW7w==
X-Gm-Message-State: AJIora+HZYkJi54WfD/5q8+2I53POnDtbR55FSF4/cPI5Dy3gkLlxXGK
        goisqk47PDnfHD0llsF3oNV+fg==
X-Google-Smtp-Source: AGRyM1uya0WGuv+8UUTsP18UtqUbrCvMhNHmF2mxy6w3S1UINsH8YvDnWNIxXJgNYXN1MAa0V+9leQ==
X-Received: by 2002:a05:6512:3f12:b0:47f:51de:d067 with SMTP id y18-20020a0565123f1200b0047f51ded067mr9074357lfa.146.1657479215403;
        Sun, 10 Jul 2022 11:53:35 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id o19-20020ac24e93000000b004793b9c2c12sm837853lfr.124.2022.07.10.11.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 11:53:34 -0700 (PDT)
Message-ID: <1a64fc6a-a33d-03f4-ec12-980e42148061@openvz.org>
Date:   Sun, 10 Jul 2022 21:53:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH mm v5 0/9] memcg: accounting for objects allocated by
 mkdir, cgroup
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>
Cc:     kernel@openvz.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
 <0fe836b4-5c0f-0e32-d511-db816d359748@openvz.org>
 <c516033f-a9e4-3485-26d9-a68afa694c1d@openvz.org>
 <YrSP25ebDmXE+kPS@dhcp22.suse.cz>
 <CALvZod4WsmrpfZtfnP4AmvtnkvBRngXXGyhM6+aQzkdfjsinAQ@mail.gmail.com>
 <YrXDV7uPpmDigh3G@dhcp22.suse.cz>
 <CALvZod6U8DvMUcuUNfpQRwfkevQB7=nP4ZLA2gWGNf_JGdyARQ@mail.gmail.com>
 <Yr7Ukyy0vhBjebo4@dhcp22.suse.cz>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <Yr7Ukyy0vhBjebo4@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/1/22 14:03, Michal Hocko wrote:
> On Mon 27-06-22 09:37:14, Shakeel Butt wrote:
>> On Fri, Jun 24, 2022 at 6:59 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
>>> Is it even possible to prevent from id
>>> depletion by the memory consumption? Any medium sized memcg can easily
>>> consume all the ids AFAICS.
>>
>> Though the patch series is pitched as protection against OOMs, I think
>> it is beneficial irrespective. Protection against an adversarial actor
>> should not be the aim here. IMO this patch series improves the memory
>> association to the actual user which is better than unattributed
>> memory treated as system overhead.
> 
> Considering the amount of memory and "normal" cgroup usage (I guess we
> can agree that delegated subtrees do not count their cgroups in
> thousands) is this really something that is worth bothering with?
> 
> I mean, these patches are really small and not really disruptive so I do
> not really see any problem with them. Except that they clearly add a
> maintenance overhead. Not directly with the memory they track but any
> future cgroup/memcg metadata related objects would need to be tracked as
> well and I am worried this will get quickly out of sync. So we will have
> a half assed solution in place that doesn't really help any containment
> nor it provides a good and robust consumption tracking.
> 
> All that being said I find these changes rather without a great value or
> use.

Dear Michal,
I sill have 2 questions:
1) if you do not want to account any memory allocated for cgroup objects,
should you perhaps revert commit 3e38e0aaca9e "mm: memcg: charge memcg percpu
memory to the parent cgroup". Is it an exception perhaps?
(in fact I hope you will not revert this patch, I just would like to know 
your explanations about this accounting)
2) my patch set includes kernfs accounting required for proper netdevices accounting

Allocs  Alloc   Allocation
number  size
--------------------------------------------
1   +  128      (__kernfs_new_node+0x4d)	kernfs node
1   +   88      (__kernfs_iattrs+0x57)		kernfs iattrs
1   +   96      (simple_xattr_alloc+0x28)	simple_xattr, can grow over 4Kb
1       32      (simple_xattr_set+0x59)
1       8       (__kernfs_new_node+0x30)

 2/9] memcg: enable accounting for kernfs nodes
 3/9] memcg: enable accounting for kernfs iattrs
 4/9] memcg: enable accounting for struct simple_xattr

What do you think about them? Should I resend them as a new separate patch set?

Thank you,
	Vasily Averin
