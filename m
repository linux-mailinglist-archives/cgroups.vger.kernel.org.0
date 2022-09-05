Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3F25AD023
	for <lists+cgroups@lfdr.de>; Mon,  5 Sep 2022 12:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiIEKbM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Sep 2022 06:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbiIEKbK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Sep 2022 06:31:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3570839B9D
        for <cgroups@vger.kernel.org>; Mon,  5 Sep 2022 03:31:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p18so8119828plr.8
        for <cgroups@vger.kernel.org>; Mon, 05 Sep 2022 03:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=08C+VXVc0IMFZrrErYdVw4bP2ZSZwMhBjMLfYmODNYY=;
        b=5qJtR8o8q181yaW02Pelm8vTh5nB2r4JcZaAQf0dDH/GMDD0eJ3Idryy96VUutJSOz
         KQ5J9dfV/XmiSfy5EmB0QFQTPnznNeCLysW/MtuxyOf9or/9pCi7+kTulpJV0lqNPJaQ
         l+qYtBb67hvNTpaB8DY83GYE8wxcqjjYVCk6I1zxMATw+o/9r/pyKNIOVDLDTLlVpS0N
         mjwDdQQgRjmDm88FKrmPj0gSJ5pK7bPiwQ+N+4s+ZDrbz3QrdEkhWW4XHITKpitraDVS
         JxW2ocZ64qsQC7v9cRrVwhvjFX0BsZnzhBr9owyS4NVMexUpNLtQvfy3woNaTPNw5LTq
         1snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=08C+VXVc0IMFZrrErYdVw4bP2ZSZwMhBjMLfYmODNYY=;
        b=SxDnJozMwuYzYZcCfy3ad7skc2wXzwTp1L6eA00YkKrSbTgtZ1GjlYQZrUhxvNoSQR
         vqqtj1xoyRuVUEJeVF3CL0YYSLAzT6Q+tvyl+W5fyccnCt5oYL0HaKnBqKY4FEg8RwnM
         +EQ8GAfg5tYBBpu9vPFpM8S+maLgtD2OY2VPARLSvnDJPa7GQA4MA+pBC6R4h0Glct+D
         uYt0VRNbsgnTzzMJFbbv8aaAEmXeEis8xitflP/fRhhsNG4gldq3xZJAF0B41JxF2rKe
         s8r7RK4Ko8sp5QvdYU5AGimOMNhXkAQnyAN+vv24Vx1Tjl5BReK65trma7mSLZ3UBQiU
         X47w==
X-Gm-Message-State: ACgBeo1g9SK/1BWsmW6gk9g9Y1xlpsu3rckdfvTSTg6gObCIWxLsJvYq
        i5rYtmVYWReNYFtQTTjeXESYtA==
X-Google-Smtp-Source: AA6agR7gFWof19I/xutyLSVCT2f+PsYjQouLLkyLJQ2fOpfCDSCz/eWBBqTJ20QLUG+Rzd90AMtE/Q==
X-Received: by 2002:a17:90a:4fa3:b0:200:8ba3:94bc with SMTP id q32-20020a17090a4fa300b002008ba394bcmr164449pjh.21.1662373867667;
        Mon, 05 Sep 2022 03:31:07 -0700 (PDT)
Received: from [10.4.229.138] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090b050a00b0020080e8c8besm950991pjz.40.2022.09.05.03.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 03:31:07 -0700 (PDT)
Message-ID: <0e5f380b-9201-0f56-9144-ce8449491fc8@bytedance.com>
Date:   Mon, 5 Sep 2022 18:30:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH] cgroup/cpuset: Add a new isolated
 mems.policy type.
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        wuyun.abel@bytedance.com
References: <20220904040241.1708-1-hezhongkun.hzk@bytedance.com>
 <YxWbBYZKDTrkmlOe@dhcp22.suse.cz>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <YxWbBYZKDTrkmlOe@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal, thanks for your reply.

The current 'mempolicy' is hierarchically independent. The default value 
of the child is to inherit from the parent. The modification of the 
child policy will not be restricted by the parent.

Of course, there are other options, such as the child's policy mode must 
be the same as the parent's. node can be the subset of parent's, but the 
interleave type will be complicated, that's why hierarchy independence 
is used. It would be better if you have other suggestions?

Thanks.

> On Sun 04-09-22 12:02:41, hezhongkun wrote:
>> From: Zhongkun He <hezhongkun.hzk@bytedance.com>
>>
>> Mempolicy is difficult to use because it is set in-process
>> via a system call. We want to make it easier to use mempolicy
>> in cpuset, and  we can control low-priority cgroups to
>> allocate memory in specified nodes. So this patch want to
>> adds the mempolicy interface in cpuset.
>>
>> The mempolicy priority of cpuset is lower than the task.
>> The order of getting the policy is:
>> 	1) vma mempolicy
>> 	2) task->mempolicy
>> 	3) cpuset->mempolicy
>> 	4) default policy.
>>
>> cpuset's policy is owned by itself, but descendants will
>> get the default mempolicy from parent.
> 
> What is the hierarchical behavior of the policy? Say parent has a
> stronger requirement (say bind) than a child (prefer)?
>   
>> How to use the mempolicy interface:
>> 	echo prefer:2 > /sys/fs/cgroup/zz/cpuset.mems.policy
>> 	echo bind:1-3 > /sys/fs/cgroup/zz/cpuset.mems.policy
>>          echo interleave:0,1,2,3 >/sys/fs/cgroup/zz/cpuset.mems.policy
> 
> Am I just confused or did you really mean to combine all these
> together?
