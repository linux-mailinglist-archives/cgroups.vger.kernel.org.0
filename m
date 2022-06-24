Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82548559806
	for <lists+cgroups@lfdr.de>; Fri, 24 Jun 2022 12:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiFXKkU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Jun 2022 06:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiFXKkT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Jun 2022 06:40:19 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DE07C861
        for <cgroups@vger.kernel.org>; Fri, 24 Jun 2022 03:40:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z21so3696009lfb.12
        for <cgroups@vger.kernel.org>; Fri, 24 Jun 2022 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AJmnLzRfv3CKjpAFSm8w5uUX4zkxlzpS9NJDok/nCk8=;
        b=7HedpVdtZRLHDg268+oLo/eUh38UD497b1xuP0kyTrOApUY9ey+kT8c0TnmBPY+t9U
         mL3HMOpxmxQIYWukMfePC89vZe9yHBTYZIR98SC8JnF5PNc4ICv87ZpVlu0TxWY8d45R
         d9z0Mgc5yU0iDhbJBhLbs8Baz9W25uKdFESjuRdahXy0c+L74oYBwxW/vkQdtCl/Zp2b
         o7Ofb3Rb/6lKL6zcj87m09gmw0mAbgTtb4y8Hd8FQfwViCQZAfDmOdf8Vt7L2w/ctbFt
         osjhl7TXYXzxDD/VddKOpv5+aF5y9/2rtyKZkQcDfn86chNYao3fOf/kYoH3POPiDcmI
         cuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AJmnLzRfv3CKjpAFSm8w5uUX4zkxlzpS9NJDok/nCk8=;
        b=xKFaeaaPvuKDKHsPDi8MJsrrtDDQ6I8RkOSwPvFHTLI0h498hh92QO8yLd+2n2aYvl
         EP+H2hizEShEIMs+ZP5aJfhDWxyivQUqqLmCaHHrfrddfhCvwq2LVNOBKYjw7GZ+LknK
         2pQNUWvBVCtT7Lu2ZqWpngVUUbZ13Fc9JfLw8YPft2J8phlD/61C7rl+sKfHRou8UALX
         /YjNcK58je0I9xUHH6c74CIFW6PW4fCKiAciN7zZMN8GlJ2FJA0zwX8y9QMObCXBX468
         7grysfeE6zrxp/TxKyKvCc1A8647ncD/F4H1lK8mc4qmO43bY6Brz/NVLqb135scJuJq
         gtVA==
X-Gm-Message-State: AJIora+cPt6nTtEvdqjtgm3C42VWFdmFIGktfvYwMI7pY25zftfgy6Ml
        jHVvRuTUcJXyF10A8lFBUCR2kg==
X-Google-Smtp-Source: AGRyM1spY9eC2EEhD934ao3bTtj+9AIG31KaKJxVQ5yli2D+p9LF1XUzqtEEzlNZUQyOCZEGB0y6hQ==
X-Received: by 2002:a19:dc0f:0:b0:47f:1b37:8d8a with SMTP id t15-20020a19dc0f000000b0047f1b378d8amr8422183lfg.12.1656067215555;
        Fri, 24 Jun 2022 03:40:15 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id bq26-20020a056512151a00b0047976e7388bsm311119lfb.81.2022.06.24.03.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 03:40:15 -0700 (PDT)
Message-ID: <0f8146e3-5865-b7e6-6728-5baada375cf2@openvz.org>
Date:   Fri, 24 Jun 2022 13:40:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH mm v5 0/9] memcg: accounting for objects allocated by
 mkdir, cgroup
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>
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
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <CALvZod4WsmrpfZtfnP4AmvtnkvBRngXXGyhM6+aQzkdfjsinAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/23/22 19:55, Shakeel Butt wrote:
> On Thu, Jun 23, 2022 at 9:07 AM Michal Hocko <mhocko@suse.com> wrote:
>>
>> On Thu 23-06-22 18:03:31, Vasily Averin wrote:
>>> Dear Michal,
>>> do you still have any concerns about this patch set?
>>
>> Yes, I do not think we have concluded this to be really necessary. IIRC
>> Roman would like to see lingering cgroups addressed in not-so-distant
>> future (http://lkml.kernel.org/r/Ypd2DW7id4M3KJJW@carbon) and we already
>> have a limit for the number of cgroups in the tree. So why should we
>> chase after allocations that correspond the cgroups and somehow try to
>> cap their number via the memory consumption. This looks like something
>> that will get out of sync eventually and it also doesn't seem like the
>> best control to me (comparing to an explicit limit to prevent runaways).
>> --
> 
> Let me give a counter argument to that. On a system running multiple
> workloads, how can the admin come up with a sensible limit for the
> number of cgroups? There will definitely be jobs that require much
> more number of sub-cgroups. Asking the admins to dynamically tune
> another tuneable is just asking for more complications. At the end all
> the users would just set it to max.
> 
> I would recommend to see the commit ac7b79fd190b ("inotify, memcg:
> account inotify instances to kmemcg") where there is already a sysctl
> (inotify/max_user_instances) to limit the number of instances but
> there was no sensible way to set that limit on a multi-tenant system.

I've found that MEM_CGROUP_ID_MAX limits memory cgroups only. Other types
of cgroups do not have similar restrictions. Yes, we can set some per-container 
limit for all cgroups, but to me it looks like workaround while
proper memory accounting looks like real solution.

Btw could you please explain why memory cgroups have MEM_CGROUP_ID_MAX limit
Why it is required at all and why it was set to USHRT_MAX? I believe that
in the future it may be really reachable:

Let's set up per-container cgroup limit to some small numbers, 
for example to 512 as OpenVz doing right now. On real node with 300
containers we can easily get 100*300 = 30000 cgroups, and consume ~3Gb memory, 
without any misuse. I think it is too much to ignore its accounting.

Thank you,
	Vasily Averin
