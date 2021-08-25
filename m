Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF803F6FD6
	for <lists+cgroups@lfdr.de>; Wed, 25 Aug 2021 08:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbhHYGv1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Aug 2021 02:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbhHYGv1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Aug 2021 02:51:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E5FC061757;
        Tue, 24 Aug 2021 23:50:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so3463055pjb.3;
        Tue, 24 Aug 2021 23:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d+uKINOa87NY5sQC8KbNNxmjG4mjEIMotNpUXzjMBt8=;
        b=F2is7s0JDyYCs9D1dcOtqeVs29jPzSaMZ7VSaYeDx5jx0LCpMSW3ONANNVlYIxWg75
         83Uhx+ODUBgYV7AY17ST/XnTZZbXr92paojRXtqS93k57uaoLa78WjBBkf4729YzyAUd
         oCHDcNbSB5dOk3UUKILqu3yZb+99afLnUSBfhTBqoHigK+7zHgJOwCT9fzUo6Y1nWXJa
         rT5jcQBDU24SzDWLidC5lAxH2P4zaUic77sZcI2+PuTsx0hyA+xlJWIyd94V0gIyg7UJ
         Z1WPs7QmwFQ4/PDbOxmKKhA7RX2Cg4rS4JCwrGVLtCTqzM3p06vn0aK8Jlzl5EQNxZ5W
         BlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d+uKINOa87NY5sQC8KbNNxmjG4mjEIMotNpUXzjMBt8=;
        b=Ms90KEQC0hMKIwbRZJV3yg53bQPS2DRzJi5XIO64utlPWGEJYU+H/kOMK1OVzdKnTC
         m56gObUFAop3k8eoLuYBozYMOqXcYweVh4hEsQJBmjjldj2cMSoUqOjkW2S0ICiyYm8P
         guf3/jY/TaUnrGFnkZGmjH7HujQvp56BQRm8cg9HSCbC9zFuEPKxAKwBiDEjfB+SWUeB
         Ht3W9ouSuCYV6YUDxNfoQLs4xnjQwyyP9UCMTsKi2NTN4HR9zave7Kuv3LbgEPqtC2C4
         uG6tnmtN/YhqM6U7gbUYOdQDoCkIeIHYjH+VThLncJOge6g1PmGnO4rLstAdRIlGLRK8
         7KNQ==
X-Gm-Message-State: AOAM533Z3+/gohTmDuyI0QYinMoQlFq6FMIcxs9dx7aD+vL3LNrNTF+e
        Fr1IUxIQ/hVow8wLz9pDDv2AL2qLLkY=
X-Google-Smtp-Source: ABdhPJxjrFZmRLf8UoZCd1gA16nFdAlzSg0zoeiz/39CcKLKeP5/7QoBLzcOwsqQPAoXCLiJKABjEg==
X-Received: by 2002:a17:90b:3d6:: with SMTP id go22mr8723797pjb.80.1629874241326;
        Tue, 24 Aug 2021 23:50:41 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.117])
        by smtp.gmail.com with ESMTPSA id w8sm4323830pjd.55.2021.08.24.23.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 23:50:40 -0700 (PDT)
Subject: Re: [PATCH v2] misc_cgroup: use a counter to count the number of
 failures
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, vipinsh@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <a09f381462b1ce9c506a22713b998e21b459f7e9.1628899295.git.brookxu@tencent.com>
 <20210824164423.GA11859@blackbody.suse.cz> <YSVDwc/1sEmXdOK9@slm.duckdns.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <75e53c51-396d-cce2-65ed-70fb60e226bd@gmail.com>
Date:   Wed, 25 Aug 2021 14:50:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSVDwc/1sEmXdOK9@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Tejun Heo wrote on 2021/8/25 3:08:
> Hello,
> 
> On Tue, Aug 24, 2021 at 06:44:23PM +0200, Michal Koutný wrote:
>> However, the non-hierarchical failcnt interface looks like v1ism to me
>> (I think new features should come with v2 first in mind).
>> What about exposing this in misc.events file with max.$res_name entries? 
> 
> Ah yeah, good point. misc.events sounds like a good spot to put these.
> 
>> Or if the hierarchical reporting is unnecessary now, there can be just
>> misc.events.local for starters.
> 
> I'd prefer to stick with hierarchical counting as the first step at least.
> 
>> (That reminds me the forgotten pids.events[.local] rework [1], oops.)
>>
>> https://lore.kernel.org/lkml/20191128172612.10259-1-mkoutny@suse.com/#t
> 
> I think both counters are useful - the number of failures due to this type
> of limit in this subhierarchy, and the number of failures caused by this
> particular limit in this subhierarchy. It's a pretty subtle difference to
> encapsulate in a counter name tho.

Thanks all for good suggestion, I try to do it in next version. 

> Thanks.
> 
