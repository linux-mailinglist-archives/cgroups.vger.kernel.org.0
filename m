Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EE16D8DF7
	for <lists+cgroups@lfdr.de>; Thu,  6 Apr 2023 05:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjDFDWu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Apr 2023 23:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbjDFDWs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Apr 2023 23:22:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381541FE7
        for <cgroups@vger.kernel.org>; Wed,  5 Apr 2023 20:22:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so295193pjb.5
        for <cgroups@vger.kernel.org>; Wed, 05 Apr 2023 20:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680751340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/21m2yLLPaau0hZnScyLMJt/iOdOd36gr8LwaGmrjkk=;
        b=UjR6qAdKwCf4JhGnnVtmV2pwm9se7kPWAMUPhZaCbtyZcvuE1N0flcKyd2uBFVOTrC
         WwUmb+zrcZnE4bFbhZG2UisTWrzQme6k9pof7bg7D6BwGYiqkgPN4nSVoPX+OVY1CkoV
         qa/rMmt+0D1YyngYNb8nXkzLNXcGB0OfhevUXIGVkUjEXR4lDwck4hwmJMR/zC16UCEZ
         hoO/1pd8TX2QwEmwnJBAMHyo1APThW4JcmR3CBw/z+d6dLeoQX48Pz+NAa0Afrsy/2W7
         9g7AJm+3XEnGF7c/m3VzAZSl7tOKMehPK9QpcPGTguEZFcfPB/ylmTNK2bws009RpgoZ
         uCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680751340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/21m2yLLPaau0hZnScyLMJt/iOdOd36gr8LwaGmrjkk=;
        b=CZ3Bge9YC6RScBSumMC5kQlNfaT611hNpuZxSyZARaU1ll5Gw9uCBjbHCe66n8B7FQ
         uKunwOArah3uC4PnvZgMmk+t758U7d2YA8m0khi2AwTeOagTDHcXhJtxbMRTRxrh3tBw
         b2omrW1i0rQURqeKU1YY6InswIouuBvL8Aj2o+yQOvCu8eiduzq8KGmPbKDEf+KrfU2H
         nZrorxD3JRbCvvJyR/lQCcqA/ZENVL1rUSyZ4hlSI3mnQbIKyj5Qure6PbjzDSAC2aFZ
         M9BB2orF4WMChfWRO1JQzmLtn7O4lk7M3+EDgdbDSgCZHM1iFJtR1DrcmlX//6ZJdJOz
         tAaw==
X-Gm-Message-State: AAQBX9e7+8LWz0NGJD03Np4sTK74kcanaJfwg6kFz+CLWdiyOQPBzTwz
        5HoChKkKCiM32l4CauJBz48ktw==
X-Google-Smtp-Source: AKy350a+CTrGkq15LOxcTO955yQUGgm4afSLyt6HMXSKDaSj/7zmzTY35UyD88f/dxAj2EGAEHzkNg==
X-Received: by 2002:a17:90b:3842:b0:23b:32e5:9036 with SMTP id nl2-20020a17090b384200b0023b32e59036mr8983848pjb.17.1680751340664;
        Wed, 05 Apr 2023 20:22:20 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902e98900b001a19438336esm262054plb.67.2023.04.05.20.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 20:22:20 -0700 (PDT)
Message-ID: <e444e0ca-a2ff-37f2-1f1a-032b9fd63235@bytedance.com>
Date:   Thu, 6 Apr 2023 11:22:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: Re: [PATCH v2] mm: oom: introduce cpuset oom
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     rientjes@google.com, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
References: <20230404115509.14299-1-ligang.bdlg@bytedance.com>
 <ZCw0sR6IqYa5Es7Q@dhcp22.suse.cz>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <ZCw0sR6IqYa5Es7Q@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 2023/4/4 22:31, Michal Hocko wrote:
> [CC cpuset people]
> 
> The oom report should be explicit about this being CPUSET specific oom
> handling so unexpected behavior could be nailed down to this change so I
Yes, the oom message looks like this:

```
[   65.470256] 
oom-kill:constraint=CONSTRAINT_CPUSET,nodemask=(null),cpuset=test,mems_allowed=0,global_oom,task_memcg=/user.slice/user-0.slice/session-4.scope,task=memkiller,pid=1968,uid=0
Apr  4 09:08:53 debian kernel: [   65.481992] Out of memory: Killed 
process 1968 (memkiller) total-vm:2099436kB, anon-rss:1971712kB, 
file-rss:1024kB, shmem-rss:0kB, UID:0 pgtables:3904kB oom_score_adj:0
```


> do not see a major concern from the oom POV. Nevertheless it would be
> still good to consider whether this should be an opt-in behavior. I
> personally do not see a major problem because most cpuset deployments I
> have seen tend to be well partitioned so the new behavior makes more
> sense.
> 

Since memcgroup oom is mandatory, cpuset oom should preferably be 
mandatory as well. But we can still consider adding an option to user.

How about introduce `/proc/sys/vm/oom_in_cpuset`?
