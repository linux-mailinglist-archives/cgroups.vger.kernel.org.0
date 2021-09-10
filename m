Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF354066B0
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 07:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhIJFXX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 01:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhIJFXW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 01:23:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54542C061574;
        Thu,  9 Sep 2021 22:22:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w6so424718pll.3;
        Thu, 09 Sep 2021 22:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GiAJAArvmremFZL8MuX/lD3wxzrw3bHPueJYOVM9tdo=;
        b=jrzbmewRWK3TsvZT7rKAi8gViwiR+gddXgVX4IjLbsQmQuaAQNMVFGy/uUDNbnUmo4
         Zq454e0VUA1Clh6bXLc9ieMzumfSjFJQn8X8Rha3iG8cYdk8KGcpAM7mnpFm4gHNHs46
         gtRGjOtJz1vkEYb+66DTI0J09nT4mPzfMJ/61VL6IJ1C3lIqr1N5Ly0qY4zOgzbcw3hN
         aBsCvMeb5sNIKkvM1FYBrIPgHEKsP+M59ABRR83/GfiiN2YL5Tm3VHRaNKBS8LtCDrmt
         g5XOQzzRhinIGe+BWGLGwCA83o2jPNvwx9kZWr8zRfjNe4NdAaOPfOUkclUd6LsCjtnh
         ypgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GiAJAArvmremFZL8MuX/lD3wxzrw3bHPueJYOVM9tdo=;
        b=YqDxsX0BJQBr8rgnz1Y0yGnB3KPEygqgdooR9rJMsw/CUTJLVIl/5wl9uGmTV44rx4
         JkF8Q1MEjkkeM2atkqu5O5mJKUa6rUTrlc2g09LgBKAiRE0EzgH3coz7a0GGvMlgN4+t
         gmFMPxt+qQngKj3RRPFEkYJO+1f8vrbZmob0Ok2XkapmIck7OJ6WCUxqFG8ZWd/nzvID
         ZvKh26+nOj/FNb9wyE3rd9RYJwr8uaWFNCv5NN12tTmUPCnu/jXz8rh3WzvA8z9GgN+5
         akUkQNGsYkkjNIAmFrn78AUqZYYqxMdgf7LHqzJQ2sGWcFGja34ecvNK7Ta/H4n73Lma
         RPrQ==
X-Gm-Message-State: AOAM532yudFqmyTGJhO6VzG3eAt2mxdLiIOUtJYuEVXbX+xTsqpH0v5o
        KWONqjnIh4n4DNqOkyk+YJprXxWl6sg=
X-Google-Smtp-Source: ABdhPJxScW1NAhZ1gWcno6PyNnANmanddeov9K+dk3wmqD2Uz88T2VmTIMyHbMsqH/Vd86db5V7+UA==
X-Received: by 2002:a17:90a:4e:: with SMTP id 14mr7565565pjb.180.1631251331700;
        Thu, 09 Sep 2021 22:22:11 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.113])
        by smtp.gmail.com with ESMTPSA id d18sm3908870pge.65.2021.09.09.22.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 22:22:11 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] misc_cgroup: introduce misc.events and
 misc_events.local
To:     Vipin Sharma <vipinsh@google.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mkoutny@suse.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <CAHVum0cGkzLg_5fZNFNTG=RRqGYW-8YG2V3gst1TevjtQ4YdBA@mail.gmail.com>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <2ed98cd6-38bb-100c-9be5-e67f64d8dd62@gmail.com>
Date:   Fri, 10 Sep 2021 13:21:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHVum0cGkzLg_5fZNFNTG=RRqGYW-8YG2V3gst1TevjtQ4YdBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Vipin Sharma wrote on 2021/9/10 12:56 上午:
> On Tue, Sep 7, 2021 at 10:24 PM brookxu <brookxu.cn@gmail.com> wrote:
>>
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> Introduce misc.events and misc.events.local to make it easier for
>> us to understand the pressure of resources. The main idea comes
>> from mem_cgroup.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>> ---
>>  include/linux/misc_cgroup.h |  9 +++++++
>>  kernel/cgroup/misc.c        | 50 ++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> Thanks for the changes. Please also update the documentation at
> Documentation/admin-guide/cgroup-v2.rst for the new changes in the
> misc cgroup.
> 
All right, thanks.
