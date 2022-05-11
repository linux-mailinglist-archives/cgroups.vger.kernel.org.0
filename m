Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABE0522BF6
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 08:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiEKGBq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 02:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiEKGBo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 02:01:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B660D326CE
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 23:01:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p26so1658120lfh.10
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 23:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KG2LP7lqw9uskhHUdz+/neRzxuQzhpKu6yMc7xnK/Nw=;
        b=ymECTCTfY6HysdomwfmKw5QWUX/LYJLfLVPUX3cID7988CkBbdzv4Aku3xtSvlHixS
         mLEUKjlqqEjDC/D0dqLnlo2CRSmatHUUKoX0cT2CfKO7C856mRyrIXYdTvYhusfPWxLA
         qgK4HNLVdHR50zn89GYGFuYzzQIPmwysOCOoGl0fi6a9fVknY6UH33Yk/lLXJvqdaKZC
         tphhA4klMvM9w/djtKoUNrB6JxH51OCpzoP6u8mQ2MulTxFfP9ygmlYJ2tbJQw5owmHm
         oC8clKUaILQ+G8AYEjejlZG6vDBahYAeBM+8p9Y3+ALCzbkyKzV6zMJwTti7o7nYmmsO
         mYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KG2LP7lqw9uskhHUdz+/neRzxuQzhpKu6yMc7xnK/Nw=;
        b=kfXlcvVwdDbCr/dGicRDOgJgA+1d4aso0pVh6TrsNIFlUwRYab/WMFj+525DV12cx/
         3qqPKWxdjnaYIdseiw8EffGtTBL7qZyjmHejRiUYpfeZxyRe39HkdC/CX5U/o5/avIUu
         ge7W3O1eE0OST5ZJKQXdBIv+7xDEqT8Glt3O/k6jlLcMWEP2uYaoCHpF1G7+qYNtL6V4
         SZdHKLHCu3IqsRGtvu8y0iYaXxhyriEOHxRpmsLyt1p3p4qvxFe81kEURBvsQphBuMdv
         ljiLND3MNaA9cYyg8vbb5oxbkonTIfW5On5VSst3/yeuHgwnzrdcyi5kfyymSQoLbQ75
         slLw==
X-Gm-Message-State: AOAM532olaK3FMeeK+F+r4BJYjrB59o26kDc3SB6HPIMuunxRFGskCB0
        uiFqqK74/tryGMiP+5bY6SRkZQ==
X-Google-Smtp-Source: ABdhPJzhOSrTTl7JsNVKxTfB5Rc4MG0yXwEh9nEh9pFJe8mx0Axc3u9gEEJWS24t2+EpklkRliWhcg==
X-Received: by 2002:a19:6905:0:b0:472:4d89:c49b with SMTP id e5-20020a196905000000b004724d89c49bmr18645249lfc.137.1652248901942;
        Tue, 10 May 2022 23:01:41 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id v26-20020a2e925a000000b00250749dab23sm167874ljg.99.2022.05.10.23.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 23:01:41 -0700 (PDT)
Message-ID: <0eec6575-548e-23e0-0d99-4e079a33d338@openvz.org>
Date:   Wed, 11 May 2022 09:01:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: kernfs memcg accounting
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
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
 <52a9f35b-458b-44c4-7fc8-d05c8db0c73f@openvz.org> <YnsoMEuWjlpDcmt3@carbon>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YnsoMEuWjlpDcmt3@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/11/22 06:06, Roman Gushchin wrote:
> On Wed, May 04, 2022 at 12:00:18PM +0300, Vasily Averin wrote:
>> From my point of view it is most important to account allocated memory
>> to any cgroup inside container. Select of proper memcg is a secondary goal here.
>> Frankly speaking I do not see a big difference between memcg of current process,
>> memcg of newly created child and memcg of its parent.
>>
>> As far as I understand, Roman chose the parent memcg because it was a special
>> case of creating a new memory group. He temporally changed active memcg
>> in mem_cgroup_css_alloc() and properly accounted all required memcg-specific
>> allocations.
> 
> My primary goal was to apply the memory pressure on memory cgroups with a lot
> of (dying) children cgroups. On a multi-cpu machine a memory cgroup structure
> is way larger than a page, so a cgroup which looks small can be really large
> if we calculate the amount of memory taken by all children memcg internals.
> 
> Applying this pressure to another cgroup (e.g. the one which contains systemd)
> doesn't help to reclaim any pages which are pinning the dying cgroups.
> 
> For other controllers (maybe blkcg aside, idk) it shouldn't matter, because
> there is no such problem there.
> 
> For consistency reasons I'd suggest to charge all *large* allocations
> (e.g. percpu) to the parent cgroup. Small allocations can be ignored.

I showed in [1] other large allocation:
"
number	bytes	$1*$2	sum	note	call_site
of	alloc
allocs
------------------------------------------------------------
1       14448   14448   14448   =       percpu_alloc_percpu:
1       8192    8192    22640   ++      (mem_cgroup_css_alloc+0x54)
49      128     6272    28912   ++      (__kernfs_new_node+0x4e)
49      96      4704    33616   ?       (simple_xattr_alloc+0x2c)
49      88      4312    37928   ++      (__kernfs_iattrs+0x56)
1       4096    4096    42024   ++      (cgroup_mkdir+0xc7)
1       3840    3840    45864   =       percpu_alloc_percpu:
4       512     2048    47912   +       (alloc_fair_sched_group+0x166)
4       512     2048    49960   +       (alloc_fair_sched_group+0x139)
1       2048    2048    52008   ++      (mem_cgroup_css_alloc+0x109)
"
[1] https://lore.kernel.org/all/1aa4cd22-fcb6-0e8d-a1c6-23661d618864@openvz.org/
=	already accounted
++	to be accounted first
+	to be accounted a bit later

There is no problems with objects allocated in mem_cgroup_alloc(),
they will be accounted to parent's memcg.
However I do not understand how to handle other large objects?

We could move set_active_memcg(parent) call from mem_cgroup_css_alloc() 
to cgroup_apply_control_enable() and handle allocation in all .css_alloc()

However I need to handle allocations called from cgroup_mkdir() too and
badly understand how to do it properly.

Thank you,
	Vasily Averin
