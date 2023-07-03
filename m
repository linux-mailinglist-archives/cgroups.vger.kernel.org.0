Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F96745D00
	for <lists+cgroups@lfdr.de>; Mon,  3 Jul 2023 15:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGCNVq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jul 2023 09:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGCNVp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jul 2023 09:21:45 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2647E3
        for <cgroups@vger.kernel.org>; Mon,  3 Jul 2023 06:21:43 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3141a9f55ceso1109276f8f.0
        for <cgroups@vger.kernel.org>; Mon, 03 Jul 2023 06:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688390502; x=1690982502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHWzNyjZXNZPtpjfpDKGqXxhjvPbxJ5woITHXM5bTQI=;
        b=QTGTQzVnhUt5zgi+KE+DT5aXkgLjyKSC8GE7zpdjNmFULXeKdKmft+EJZ0kekibd52
         cBQcsfApadmPVftC8iBVGZtBpYFcuMB08epkDmLJM/4mCC6LZIX5lIRBJ40wzecIvz5z
         jOG212c7XYe7t6jNDCOZGmFs8bTn1KlPZD7OMBjM2XX+bhmsdvSYfNAuCH316BKlu245
         eNs+ddI1xilNaNXE2jmMqO8YKagDU+j8TUFw/t4dL8Wm314XhzO01mRIiqswmtxW/Zns
         X8bgAU9jO6IBYuPEfyTuAaaK5K0rnXqpliSiLuvr7MS8JvezUy23gePiH8Hv8v/Vdnti
         TeDw==
X-Gm-Message-State: ABy/qLYyU09N9Z3NURKa8ePQLgsY6rmxKOIwYi18EYx9p2tcoS2OJyBG
        QBg7bFltc83AwtKUP+nwmHw=
X-Google-Smtp-Source: APBJJlG1t7Px6QZsg14yGrUIuFovCG6UtEmHCUN5mSc/rn9IRQLdjtwQKpIcl+ov6a20mVwRoi0pgw==
X-Received: by 2002:a5d:49d1:0:b0:313:e8b7:d0f9 with SMTP id t17-20020a5d49d1000000b00313e8b7d0f9mr8370469wrs.4.1688390502074;
        Mon, 03 Jul 2023 06:21:42 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d6542000000b00313eee8c080sm21838944wrv.98.2023.07.03.06.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 06:21:41 -0700 (PDT)
Message-ID: <ab204a2d-9a30-7c90-8afa-fc84c935730f@grimberg.me>
Date:   Mon, 3 Jul 2023 16:21:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvmet: allow associating port to a cgroup via configfs
Content-Language: en-US
To:     Ofir Gal <ofir.gal@volumez.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        cgroups@vger.kernel.org, tj@kernel.org
References: <20230627100215.1206008-1-ofir.gal@volumez.com>
 <30d03bba-c2e1-7847-f17e-403d4e648228@grimberg.me>
 <90150ffd-ba2d-6528-21b7-7ea493cd2b9a@nvidia.com>
 <79894bd9-03c7-8d27-eb6a-5e1336550449@volumez.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <79894bd9-03c7-8d27-eb6a-5e1336550449@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


> Hey Sagi and Chaitanya,
> 
> On 28/06/2023 5:33, Chaitanya Kulkarni wrote:
>> On 6/27/23 14:13, Sagi Grimberg wrote:
>>> Hey Ofir,
>>>
>>>> Currently there is no way to throttle nvme targets with cgroup v2.
>>>
>>> How do you do it with v1?
> With v1 I would add a blkio rule at the cgroup root level. The bio's
> that the nvme target submits aren't associated to a specific cgroup,
> which makes them follow the rules of the cgroup root level.
> 
> V2 doesn't allow to set rules at the root level by design.
> 
>>>> The IOs that the nvme target submits lack associating to a cgroup,
>>>> which makes them act as root cgroup. The root cgroup can't be throttled
>>>> with the cgroup v2 mechanism.
>>>
>>> What happens to file or passthru backends? You paid attention just to
>>> bdev. I don't see how this is sanely supported with files. It's possible
>>> if you convert nvmet to use its own dedicated kthreads and infer the
>>> cg from the kthread. That presents a whole other set of issues.
>>>
>>
>> if we are doing it for one back-end we cannot leave other back-ends out ...
>>
>>> Maybe the cleanest way to implement something like this is to implement
>>> a full blown nvmet cgroup controller that you can apply a whole set of
>>> resources to, in addition to I/O.
> 
> Thorttiling files and passthru isn't possible with cgroup v1 as well,
> cgroup v2 broke the abillity to throttle bdevs. The purpose of the patch
> is to re-enable the broken functionality.

cgroupv2 didn't break anything, this was never an intended feature of
the linux nvme target, so it couldn't have been broken. Did anyone
know that people are doing this with nvmet?

I'm pretty sure others on the list are treating this as a suggested
new feature for nvmet. and designing this feature as something that
is only supported for blkdevs is undersirable.


> There was an attempt to re-enable the functionality by allowing io
> throttle on the root cgroup but it's against the cgroup v2 design.
> Reference:
> https://lore.kernel.org/r/20220114093000.3323470-1-yukuai3@huawei.com/
> 
> A full blown nvmet cgroup controller may be a complete solution, but it
> may take some time to achieve,

I don't see any other sane solution here.

Maybe Tejun/others think differently here?

> while the feature is still broken.

Again, this is not a breakage.

> 
>>>
>>>> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
>>>> ---
>>>>    drivers/nvme/target/configfs.c    | 77 +++++++++++++++++++++++++++++++
>>>>    drivers/nvme/target/core.c        |  3 ++
>>>>    drivers/nvme/target/io-cmd-bdev.c | 13 ++++++
>>>>    drivers/nvme/target/nvmet.h       |  3 ++
>>>>    include/linux/cgroup.h            |  5 ++
>>>>    kernel/cgroup/cgroup-internal.h   |  5 --
>>>
>>> Don't mix cgroup and nvmet changes in the same patch.
> 
> Thanks for claryfing I wansn's sure if it's nessecary I would split the
> patch for v2.
> 
>>>
>>>>    6 files changed, 101 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/target/configfs.c
>>>> b/drivers/nvme/target/configfs.c
>>>> index 907143870da5..2e8f93a07498 100644
>>>> --- a/drivers/nvme/target/configfs.c
>>>> +++ b/drivers/nvme/target/configfs.c
>>>> @@ -12,6 +12,7 @@
>>>>    #include <linux/ctype.h>
>>>>    #include <linux/pci.h>
>>>>    #include <linux/pci-p2pdma.h>
>>>> +#include <linux/cgroup.h>
>>>>    #ifdef CONFIG_NVME_TARGET_AUTH
>>>>    #include <linux/nvme-auth.h>
>>>>    #endif
>>>> @@ -281,6 +282,81 @@ static ssize_t
>>>> nvmet_param_pi_enable_store(struct config_item *item,
>>>>    CONFIGFS_ATTR(nvmet_, param_pi_enable);
>>>>    #endif
>>>>    +static ssize_t nvmet_param_associated_cgroup_show(struct
>>>> config_item *item,
>>>> +        char *page)
>>>> +{
>>>> +    struct nvmet_port *port = to_nvmet_port(item);
>>>> +    ssize_t len = 0;
>>>> +    ssize_t retval;
>>>> +    char *suffix;
>>>> +
>>>> +    /* No cgroup has been set means the IOs are assoicated to the
>>>> root cgroup */
>>>> +    if (!port->cgrp)
>>>> +        goto root_cgroup;
>>>> +
>>>> +    retval = cgroup_path_ns(port->cgrp, page, PAGE_SIZE,
>>>> +                         current->nsproxy->cgroup_ns);
>>>> +    if (retval >= PATH_MAX || retval >= PAGE_SIZE)
>>>> +        return -ENAMETOOLONG;
>>>> +
>>>> +    /* No cgroup found means the IOs are assoicated to the root
>>>> cgroup */
>>>> +    if (retval < 0)
>>>> +        goto root_cgroup;
>>>> +
>>>> +    len += retval;
>>>> +
>>>> +    suffix = cgroup_is_dead(port->cgrp) ? " (deleted)\n" : "\n";
>>>> +    len += snprintf(page + len, PAGE_SIZE - len, suffix);
>>>> +
>>>> +    return len;
>>>> +
>>>> +root_cgroup:
>>>> +    return snprintf(page, PAGE_SIZE, "/\n");
>>>> +}
>>>> +
>>>> +static ssize_t nvmet_param_associated_cgroup_store(struct
>>>> config_item *item,
>>>> +        const char *page, size_t count)
>>>> +{
>>>> +    struct nvmet_port *port = to_nvmet_port(item);
>>>> +    struct cgroup_subsys_state *blkcg;
>>>> +    ssize_t retval = -EINVAL;
>>>> +    struct cgroup *cgrp;
>>>> +    char *path;
>>>> +    int len;
>>>> +
>>>> +    len = strcspn(page, "\n");
>>>> +    if (!len)
>>>> +        return -EINVAL;
>>>> +
>>>> +    path = kmemdup_nul(page, len, GFP_KERNEL);
>>>> +    if (!path)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    cgrp = cgroup_get_from_path(path);
>>>> +    kfree(path);
>>>> +    if (IS_ERR(cgrp))
>>>> +        return -ENOENT;
>>>> +
>>>> +    blkcg = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
>>>> +    if (!blkcg)
>>>> +        goto out_put_cgroup;
>>>> +
>>>> +    /* Put old cgroup */
>>>> +    if (port->cgrp)
>>>> +        cgroup_put(port->cgrp);
>>>> +
>>>> +    port->cgrp = cgrp;
>>>> +    port->blkcg = blkcg;
>>>> +
>>>> +    return count;
>>>> +
>>>> +out_put_cgroup:
>>>> +    cgroup_put(cgrp);
>>>> +    return retval;
>>>> +}
>>>
>>> I'm not at all convinced that nvmet ratelimiting does not
>>> require a dedicated cgroup controller... Rgardles, this doesn't
>>> look like a port attribute, its a subsystem attribute.
>>
>> +1 here, can you please explain the choice of port ?
> 
> In cgroup threads/processes are associated to a specific control group.
> Each control group may have different rules to throttle various devices.
> For example we may have 2 applications both using the same bdev.
> By associating the apps to different cgroups, we can create a different
> throttling rule for each app.
> Throttling is done by echoing "MAJOR:MINOR rbps=X wiops=Y" to "io.max"
> of the cgroup.
> 
> Associating a subsystem to a cgroup will only allow us to create a
> single rule for each namespace (bdev) in this subsystem.
> When associating the nvme port to the cgroup it acts as the "thread"
> that handles the IO for the target, which aligns with the cgroup design.

The port does not own the thread though, rdma/loop inherit the
"thread" from something entirely different. tcp uses the same worker
threads for all ports (global workqueue).

IIUC, a cgroup would be associated with a specific host, and the entity
that is host aware is a subsystem, not a port.

> Regardless if the attribute is part of the port or the subsystem, the
> user needs to specify constraints per namespace. I see no clear value in
> setting the cgroup attribute on the subsystem.

Maybe it would be worth to explain what you are trying to achieve here,
because my understanding is that you want to allow different hosts to
get different I/O service levels. The right place to do this is the
subsystem AFAICT.

> On the other hand, by associating a port to a cgroup we could have
> multiple constraints per namespace. It will allow the user to have more
> control of the behavior of his system.

Can you please clarify what you mean by "multiple constraints per
namespace"?

> For example a system with a RDMA port and a TCP port that are connected
> to the same subsystem's can apply different limits for each port.
> 
> This could be complimentary to NVMe ANA for example, where the target
> could apply different constraints for optimized and non-optimized paths

I don't understand what you are suggesting here. nvme already has
asymmetry semantics between controllers.

I think you are mixing two different things. There is asymmetric access
in nvmet (which could translate to tcp vs. rdma or to something else)
and there is providing different I/O service levels to different hosts.
I don't see how these two are connected.
