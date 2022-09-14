Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADDB5B8B74
	for <lists+cgroups@lfdr.de>; Wed, 14 Sep 2022 17:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiINPLF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Sep 2022 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiINPLD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Sep 2022 11:11:03 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709301A3B9
        for <cgroups@vger.kernel.org>; Wed, 14 Sep 2022 08:10:59 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v4so14565160pgi.10
        for <cgroups@vger.kernel.org>; Wed, 14 Sep 2022 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=xZSx75ilZmaUEZs6zH1DDH3DLY7hAQRgTpb/P4DWJZM=;
        b=jOiWuFpGnmyoC1VrTOuCdvPFzUYz84CfKFS2G8Ov0tzdE5aMxCQmvShalFAKGmOa5b
         PwEeGBJo+8m8aKNIVdLeUIZf4QNLqxG9sVmToF537m5YQI+9yxTajGGC86wBj5XXdX5Y
         D6kvOz5a7bWmhcmr/U36whNSDZExbYZh36NvwRPbjk07eY41Xo99eG1d6SDhty/chEjI
         z+o3OeGVhCaGONt3Em6JYVoqo784254Lg9IMsUzfOIWNBIfgUvkwfQRjWevx9u6APFR3
         f462PkUEv/kkGstRvWSsGOvuYyTLcUrNCOYZwHyV4JCGZPWpAK8bcLXzs1OgfAeBIceL
         Oc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=xZSx75ilZmaUEZs6zH1DDH3DLY7hAQRgTpb/P4DWJZM=;
        b=TwppEv1ikpBAHkc+17k7b6Srz5ShtAueApbh/tjBtJaWBPlzZo1YEfwVdiEJYxd/X9
         n6FuPTST41+1Fda6XIQtWLhGb9kBpoTTP6kh4GIjRLhdulEekjT/D8/QtvOlnCmrYLkQ
         yZ97OJOG1X+8jAcXs3hmC+O9mCkqDb/pzlaOXzvVQ2AnNY5Byo7OXoS8xLJ2Ffyl2/Uy
         Syx3LtVVzicl5wJI5+aVNr2ZXlQrvA/l44xb0WWpx/cBHizVJjazUWpXpsUkLD6PE5/o
         WZRSwv4uMWtYjvrkm3RwJ94bNiFeAgou7G1Y/JEU1wrvF6HuryoA3jhUk9lJk7jVT7ZB
         hAqA==
X-Gm-Message-State: ACgBeo1707d7QVGB+sW5r3eZjvzY8cO7DqkNsrie6kCFPNfTyFJLfkJD
        Ng4cY2wXcV0Nfr6ysdLzX7zPAQ==
X-Google-Smtp-Source: AA6agR6mepJWLa7zKnt5XoWQEJgYP7K2Ol1H7Z49Ed345ge1yHzE7K9Qf4a5I1COzgit+qL/ywDLXw==
X-Received: by 2002:a63:444:0:b0:438:c057:1462 with SMTP id 65-20020a630444000000b00438c0571462mr16994684pge.520.1663168258994;
        Wed, 14 Sep 2022 08:10:58 -0700 (PDT)
Received: from [10.4.86.190] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id c14-20020a170902d48e00b00176a579fae8sm10929605plg.210.2022.09.14.08.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 08:10:58 -0700 (PDT)
Message-ID: <120cb50d-d617-a60a-ec24-915f826318f1@bytedance.com>
Date:   Wed, 14 Sep 2022 23:10:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH] cgroup/cpuset: Add a new isolated
 mems.policy type.
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        wuyun.abel@bytedance.com
References: <20220904040241.1708-1-hezhongkun.hzk@bytedance.com>
 <YxWbBYZKDTrkmlOe@dhcp22.suse.cz>
 <0e5f380b-9201-0f56-9144-ce8449491fc8@bytedance.com>
 <YxXUjvWmZoG9vVNV@dhcp22.suse.cz>
 <ca5e57fd-4699-2cec-b328-3d6bac43c8ef@bytedance.com>
 <Yxc+HZ6rjcR535oN@dhcp22.suse.cz>
 <93d76370-6c43-5560-9a5f-f76a8cc979e0@bytedance.com>
 <YxmXeC7te2HAi4dX@dhcp22.suse.cz>
 <fa5e5a79-aa1a-a009-d0c8-0a39380a71b6@bytedance.com>
In-Reply-To: <fa5e5a79-aa1a-a009-d0c8-0a39380a71b6@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

>>
>>> Back to the previous question.
>>>> The question is how to implement that with a sensible semantic.
>>>
>>> Thanks for your analysis and suggestions.It is really difficult to add
>>> policy directly to cgroup for the hierarchical enforcement. It would 
>>> be a good idea to add pidfd_set_mempolicy.
>>
>> Are you going to pursue that path?

> Hi Michal, thanks for your suggestion and reply.
> 
>  > Are you going to pursue that path?
> 
> Yes，I'll give it a try as it makes sense to modify the policy dynamically.
> 
> Thanks.

Hi Michal, i have a question about pidfd_set_mempolicy, it would be 
better if you have some suggestions.

The task_struct of processes and threads are independent. If we change 
the mempolicy of the process through pidfd_set_mempolicy, the mempolicy 
of its thread will not change. Of course users can set the mempolicy of 
all threads by iterating through /proc/tgid/task.

The question is whether we should override the thread's mempolicy when 
setting the process's mempolicy.

There are two options:
A:Change the process's mempolicy and set that mempolicy to all it's threads.
B:Only change the process's mempolicy in kernel. The mempolicy of the 
thread needs to be modified by the user through pidfd_set_mempolicy in
userspace, if necessary.

Thanks.
