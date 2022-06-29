Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823BC55F65F
	for <lists+cgroups@lfdr.de>; Wed, 29 Jun 2022 08:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiF2GNI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jun 2022 02:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiF2GNH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Jun 2022 02:13:07 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2A1B8B
        for <cgroups@vger.kernel.org>; Tue, 28 Jun 2022 23:13:05 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id b23so17573376ljh.7
        for <cgroups@vger.kernel.org>; Tue, 28 Jun 2022 23:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tXBEMcYdLbL7j0CBnFEQrI7j8CDRw/szwLk4z5HVwIU=;
        b=6xIoLTbTENo5N5hHKjhjfiPk6YpVnyqcLFcwoVzvW3j8d4aWTu8RxffBad1YuW22ZQ
         B7JUZzvMlY3hMEVofUyVtHBYlj7NYSiQSjSmRtHMHwYaGzHsaqvwDqH4SBVu0eg2wt1p
         09spkd8NH3luZDqG7H3iAwgS+g1MUQ3GRFz+F1gyrPFJjm6z7aaVcn7gc2MOrFB/p6kF
         JajynDxOhztcu9FGmfWos5JDk1HGKQ0g4bqDoY+ExizDNO0aXZPzeg0b1uGZ74fHWMX+
         +J+20MEXlTNZIPQhPd4BwwqzofH2gf1h83iJVr7esOJIGCDxJ6fleBsVho2LMH/DFy0V
         agWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tXBEMcYdLbL7j0CBnFEQrI7j8CDRw/szwLk4z5HVwIU=;
        b=JImjSg+lKHyj3LhI+4wNOpEf/mz+K7iObLf1glw2z/VsejZey8WGJverSKr24i7cVs
         JauYWxJLtn0O0A1o+SWd3LVdJd3nxJ46JZxSO8EQrnwRTbznrH596w0iefSjgAT4m1ob
         J3Mb5fMqeJ9hJRFEgWD+XpHGn1wVSJfZDaFCLXIho5B8+hxZEQ8dQr5zSC61aLtwzexm
         UXRUUVdcJVbwguPEQ5Jy0NSt6PGW8jKehCKO8de6/35LgGrkf2Daut3yqyoSMBg+54kM
         RyVkcJnvKn4oT7eIJZ8zAWwQmsh5QLnwhMuXMjhYDCRvL2pNbPJjnpPLhUGPhdP53coA
         o63g==
X-Gm-Message-State: AJIora+Ktl09cAHLELfxroru30Tnf2sVDFlWpRZiHTAtmJL5qblyShLa
        94IXn3JYlVqZjigurLBiLGhdlA==
X-Google-Smtp-Source: AGRyM1uz1PB+XkmMF33YPm/T9ikaMMh3hNuHzNz1feoMJukKhHNlhRxnBXWZVy0f0Esc50JJckDEkA==
X-Received: by 2002:a2e:a707:0:b0:25a:7709:d8ce with SMTP id s7-20020a2ea707000000b0025a7709d8cemr849124lje.362.1656483184254;
        Tue, 28 Jun 2022 23:13:04 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id z9-20020a0565120c0900b0047f66471224sm2475170lfu.222.2022.06.28.23.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 23:13:03 -0700 (PDT)
Message-ID: <525a3eea-8431-64ad-e464-5503f3297722@openvz.org>
Date:   Wed, 29 Jun 2022 09:13:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH cgroup] cgroup: set the correct return code if hierarchy
 limits are reached
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <186d5b5b-a082-3814-9963-bf57dfe08511@openvz.org>
 <d8a9e9c6-856e-1502-95ac-abf9700ff568@openvz.org> <YrpO9CUDt8hpUprr@castle>
 <17916824-ba97-68ba-8166-9402d5f4440c@openvz.org>
 <20220628091648.GA12249@blackbody.suse.cz> <YrrIWe/nn5hoVyu9@mtj.duckdns.org>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YrrIWe/nn5hoVyu9@mtj.duckdns.org>
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

On 6/28/22 12:22, Tejun Heo wrote:
> On Tue, Jun 28, 2022 at 11:16:48AM +0200, Michal Koutný wrote:
>> The mkdir(2) manpage doesn't list EAGAIN at all. ENOSPC makes better
>> sense here. (And I suspect the dependency on this particular value won't
>> be very wide spread.)
> 
> Given how we use these system calls as triggers for random kernel
> operations, I don't think adhering to posix standard is necessary or
> possible. Using an error code which isn't listed in the man page isn't
> particularly high in the list of discrepancies.
> 
> Again, I'm not against changing it but I'd like to see better
> rationales. On one side, we have "it's been this way for a long time
> and there's nothing particularly broken about it". I'm not sure the
> arguments we have for the other side is strong enough yet.

I would like to recall this patch.

I experimented on fedora36 node with LXC and centos stream 9 container.
and I did not noticed any critical systemd troubles with original -EAGAIN.
When cgroup's limit is reached systemd cannot start new services, 
for example lxc-attach generates following output:

[root@fc34-vvs ~]# lxc-attach c9s
lxc-attach: c9s: cgroups/cgfsng.c: cgroup_attach_leaf: 2084 Resource temporarily unavailable - Failed to create leaf cgroup ".lxc"
lxc-attach: c9s: cgroups/cgfsng.c: __cgroup_attach_many: 3517 Resource temporarily unavailable - Failed to attach to cgroup fd 11
lxc-attach: c9s: attach.c: lxc_attach: 1679 Resource temporarily unavailable - Failed to attach cgroup
lxc-attach: c9s: attach.c: do_attach: 1237 No data available - Failed to receive lsm label fd
lxc-attach: c9s: attach.c: do_attach: 1375 Failed to attach to container

I did not found any loop in userspace caused by EAGAIN.
Messages looks unclear, however situation with the patched kernel is not much better:

[root@fc34-vvs ~]# lxc-attach c9s
lxc-attach: c9s: cgroups/cgfsng.c: cgroup_attach_leaf: 2084 No space left on device - Failed to create leaf cgroup ".lxc"
lxc-attach: c9s: cgroups/cgfsng.c: __cgroup_attach_many: 3517 No space left on device - Failed to attach to cgroup fd 11
lxc-attach: c9s: attach.c: lxc_attach: 1679 No space left on device - Failed to attach cgroup
lxc-attach: c9s: attach.c: do_attach: 1237 No data available - Failed to receive lsm label fd
lxc-attach: c9s: attach.c: do_attach: 1375 Failed to attach to container

Thank you,
	Vasily Averin
