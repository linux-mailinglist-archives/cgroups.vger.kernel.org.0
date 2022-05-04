Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5534251B036
	for <lists+cgroups@lfdr.de>; Wed,  4 May 2022 23:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378533AbiEDVTz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 May 2022 17:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357294AbiEDVTy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 May 2022 17:19:54 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58404220C6
        for <cgroups@vger.kernel.org>; Wed,  4 May 2022 14:16:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id g16so3275911lja.3
        for <cgroups@vger.kernel.org>; Wed, 04 May 2022 14:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tdFt0uQlPJ4mzIwCT11tWacBOCFR/O+DCJD9m2elhvY=;
        b=4BtgJE6tIVi5spqKRy2safmJJvFhDwqig/gu8SOgJVMNlQoN7e6oyggAGtbh0Ai3u+
         mR+n9pawKCECW0w4KaZIWSRlsLDNrXNLicQze8WR7YOF14HoGfcdcRrLoH9tjDGrbzFy
         WDWbyL2Nu4xZje0kDJ17xDqguvfoDCMUQSyM3hLgoAUlMcGEsTF7qPjnbhKhdYfxmucs
         wHUTkWv/1+fU/qFlF5OKiFmii/NXaHWgs3XvRrl4Eifnz5ATici85iWc4YhEkszOJAxc
         Bha+LOrKUOvCCgZ0Q3zYOFb0L/mULFRJtIuA6ZizjW+wmIlKvPAcW/NJrfdYapYD95QF
         c2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tdFt0uQlPJ4mzIwCT11tWacBOCFR/O+DCJD9m2elhvY=;
        b=FyvQrZelS1atqOP7o65w7qwlan2Y9wxG3hx8QaiEXJOQ0ZzOMnuuSgG1tY9H8o9W6m
         uCST13+VvtZ4IQfKOb+o8yrjfqbTBehR3/e9l0/b0CaaUSqs5pNw8ZC4L5td6ApNRaVr
         gwKMdVjZdkuJsY5RssDqwcfP2mPD4YXyOKHHCY0IQhTVLzSV+0VU546uyeb+qowtK6Os
         If9EYM+ZyVLPRIUWSQ1Dp8VUuVIjqsQOC65De2DWKcWD2dqCYGcoHi0gbgrc4Elsfl/W
         KYQgeGmGO6a7/ZynQQWydme8Y579ucYxS9GTqZSYpAUnII7efVVwzySfXmbYocz+H8NS
         oI8A==
X-Gm-Message-State: AOAM531Py5MyvN7CY8bgE4MzYEcsG5okuEF5EtTWDLmZPW2wb3msbljI
        3xPCHydLg9RC1uIxvofVQmPShA==
X-Google-Smtp-Source: ABdhPJxgHSAUGLfgLZIb2+0g5ez7rOXgrwqXJD1qFd+PALJWQypuORHFvFz0pwvJnOif4DAYaP2oCw==
X-Received: by 2002:a05:651c:10b4:b0:24f:88b:2dc3 with SMTP id k20-20020a05651c10b400b0024f088b2dc3mr13985315ljn.383.1651698974268;
        Wed, 04 May 2022 14:16:14 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id j26-20020a19f51a000000b0047255d21115sm1302266lfb.68.2022.05.04.14.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 14:16:13 -0700 (PDT)
Message-ID: <65244222-02c5-6e8d-7f4b-83651f378ce2@openvz.org>
Date:   Thu, 5 May 2022 00:16:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: kernfs memcg accounting
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
References: <7e867cb0-89d6-402c-33d2-9b9ba0ba1523@openvz.org>
 <20220427140153.GC9823@blackbody.suse.cz>
 <7509fa9f-9d15-2f29-cb2f-ac0e8d99a948@openvz.org>
 <YnBLge4ZQNbbxufc@blackbook>
 <52a9f35b-458b-44c4-7fc8-d05c8db0c73f@openvz.org>
 <20220504141001.GA10890@blackbody.suse.cz>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220504141001.GA10890@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/4/22 17:10, Michal Koutný wrote:
> On Wed, May 04, 2022 at 12:00:18PM +0300, Vasily Averin <vvs@openvz.org> wrote:
>> As far as I understand, Roman chose the parent memcg because it was a special
>> case of creating a new memory group. He temporally changed active memcg
>> in mem_cgroup_css_alloc() and properly accounted all required memcg-specific
>> allocations.
> 
>> However, he ignored accounting for a rather large struct mem_cgroup
>> therefore I think we can do not worry about 128 bytes of kernfs node.
> 
> Are you referring to the current code (>= v5.18-rc2)? All big structs
> related to mem_cgroup should be accounted. What is ignored?

mm/memcontrol.c:
5079 static struct mem_cgroup *mem_cgroup_alloc(void)
5080 {
5081         struct mem_cgroup *memcg;
...
5086         memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);

I think it should allocate at least 2 pages.

>> Primary I mean here struct mem_cgroup allocation in mem_cgroup_alloc().
> 
> Just note that memory controller may not be always enabled so
> cgroup_mkdir != mem_cgroup_alloc().

However if cgroup_mkdir() calls mem_cgroup_alloc() it correctly account huge percpu
allocations but ignores neighbour multipage allocation.

>> However, I think we need to take into account any other distributions called
>> inside cgroup_mkdir: struct cgroup and kernefs node in common part and 
>> any other cgroup-cpecific allocations in other .css_alloc functions.
>> They all can be called from inside container, allocates non-accountable
>> memory and by this way theoretically can be misused.
> 
> Also note that (if you're purely on unified hierachy) you can protect
> against that with cgroup.max.descendants and cgroup.max.depth.

In past OpenVz had a lot of limits for various resources (for example we had a limit 
for iptable rules), but it was very hard to configure them properly.
Finally we  decided to replace all such custom limits by common memory limit.
It isn't important how many resources tries to use container as long as
it doesn't exceed the memory limit.
Such resource limits can be useful, especially to prevent possible misuses.
However sooner or later there will be a legal user who will rest against them.
All you can do in this situation is to recommend him just increase the limit,
that makes the limit senseless.
Memory limits looks much more reasonable and understandable.

Thank you,
	Vasily Averin
