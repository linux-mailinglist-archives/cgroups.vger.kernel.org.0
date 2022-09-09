Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C0C5B2C51
	for <lists+cgroups@lfdr.de>; Fri,  9 Sep 2022 05:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIIDBM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Sep 2022 23:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIIDBI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Sep 2022 23:01:08 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6D5110ABD
        for <cgroups@vger.kernel.org>; Thu,  8 Sep 2022 20:01:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso4141611pjk.0
        for <cgroups@vger.kernel.org>; Thu, 08 Sep 2022 20:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=43jwGnS59LTzri1tkRF1HTsqNOy+AaUcwDQj3xSUi9Y=;
        b=qM7Qs8uwZ40xVP0T/DV9fdTIwI8Ar1eOIcgUKjE3i9KoFTMohzGLYbHkhwyqZe7E0d
         Q1YmX6zciTiD7MuhNmdVrE3y0P4WyTeQNRE/4WUPtdHtX1LOLatHiueeuNJBzYIqHTpA
         izuKDQlivt/6Fj0DEObTu6oJxDRZHjHxZZ8xP8xpJ1uwQwOzEv8vAI5YduienxUtn/xc
         grqIzRFQMPivQAgRzcDBA5D5Cxh/ZUJJEXrkD/TbmOzd3d5owHGQyD1twfxhyyKqvrit
         uFpsDm70Mcz7N4AZJ6rjz1dFaGIsnntIj0ZXETPId6ungfNrNRz5p7IpTS7QqyD4AR2f
         GkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=43jwGnS59LTzri1tkRF1HTsqNOy+AaUcwDQj3xSUi9Y=;
        b=kJK2CKD2IAF0Ue352oz1XADbKVIb5HiWaAxOjsJ3z+Gwfi0/TlRffwAIogBtiwYnL2
         b38tajlzQeEXAPPkTs65vGfy2qpzPs+n1N1TPrXhXEm34ekk5+BSWAqpapjc0yl7ggiP
         ajPW8ZZrioia6xo8nJnHBQBMg/mksoQwQ+B++VeIe/kHaQTneUyaW1On4wkAUAzC2fet
         kAdDV3hKkZOvvZ4MTywRhy1SGZMYjf05j3FCR5l7Wvpua7dcaaSlkKWOkfmwbJM4Oc7o
         43seBd7zRUJdoGFGH5uGm5f5A0NpRfPQI/v2YWrJIjOxJa5svzIFgTand7jDfkNe4J8f
         HGKg==
X-Gm-Message-State: ACgBeo2wyoTL402Y9Uf/hUYOgYVC8F9ii/v+306I2KwJxxUqupfUAFhG
        2xqW3eRXBOBbVQ8S/QvCESpibw==
X-Google-Smtp-Source: AA6agR6BsP2ZvqecHewGiBFc53IL03+Xq/d1KflcwXIs2xvLmXq+uxFUFgIrTgmPdTq6yhFSncXrWA==
X-Received: by 2002:a17:902:ea02:b0:176:afd7:3d1d with SMTP id s2-20020a170902ea0200b00176afd73d1dmr11724510plg.120.1662692466553;
        Thu, 08 Sep 2022 20:01:06 -0700 (PDT)
Received: from [10.4.159.81] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id c20-20020a656754000000b0042af14719f4sm198700pgu.51.2022.09.08.20.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 20:01:06 -0700 (PDT)
Message-ID: <262052c8-c03c-24c4-9163-5df8e9f312be@bytedance.com>
Date:   Fri, 9 Sep 2022 11:00:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [Phishing Risk] Re: [Phishing Risk] Re: [Phishing Risk]
 [External] Re: [PATCH] cgroup/cpuset: Add a new isolated mems.policy type.
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220902063303.1057-1-hezhongkun.hzk@bytedance.com>
 <YxT/liaotbiOod51@slm.duckdns.org>
 <c05bdeac-b354-0ac7-3233-27f8e5cbb38a@bytedance.com>
 <YxeBGeOaQxvlPLzo@slm.duckdns.org>
 <d323bd95-476b-0901-855e-14c8796d1b23@bytedance.com>
 <Yxi4EYxMaPNkL+of@slm.duckdns.org>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <Yxi4EYxMaPNkL+of@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,
> Hello,
> 
> On Wed, Sep 07, 2022 at 08:06:30PM +0800, Zhongkun He wrote:
>> It would be better if one process had a way to dynamically modify the
>> mempolicy of another process. But unfortunately there is no interface or
>> system call to do that in userspace.
> 
> If you need to change the properties dynamically, I suggest adding this as a
> dynamic per-process interface first. That's more generic and useful for more
> cases.
> 
> Thanks.

Got it, thanks for your suggestion and reply.
