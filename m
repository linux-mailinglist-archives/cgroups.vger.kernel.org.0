Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F39363B847
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 03:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiK2CxW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 21:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbiK2CxI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 21:53:08 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490FF186D8
        for <cgroups@vger.kernel.org>; Mon, 28 Nov 2022 18:53:07 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b21so12082680plc.9
        for <cgroups@vger.kernel.org>; Mon, 28 Nov 2022 18:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVdaZGcP4j88Qml5mJfIo0BmHi+s/R7fEtpX29Aegis=;
        b=eOWHOBNDHn0V8MqJlRrEQyiG3etYoyVj6HwWZjScS+ro7oXp5NnHwhu5V0XnAqkFOl
         6coP5VmkxdS1kKd8anif+2CIXOCyWCUw00MMJ/B7ruMCC30ZGevpet4thlWyKu6g7Mmo
         oxCduW3h3rMAWAq4cf/olag3GY2b+yPIMI2YBT05xMmL0/RfvpD0b99A2JEK5SsjTDsA
         q4MgDxRM4yNHBfjWC2SAQEVHEA+qr+wd4kJUk8aa600dSny2BZsIut+ApQTNkGX8gD+g
         KnPhKTw4NnFHV0or2ZKsD9P0kbjJ7CMEEo6YXfNUfZKQF5scF01DdHZt5KqHaUvgR0oI
         XWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tVdaZGcP4j88Qml5mJfIo0BmHi+s/R7fEtpX29Aegis=;
        b=bB1ch4mRce+zO1/P3BnbFxMlBjSPdkmE/baAgmU9TId7DXlycIHywqRTP5JOcAx1jz
         ebGTMg0bZ1B9poCwE1RDtKjLgaw908oDi0ZzPC95VCM9gVf5i9CeiazItIYwnpZ0edIm
         g1mFX5McJ7pBVUajKGXQ1Biiy8uuf5pxmr9nVeyc64c3kuzLEfx7ziWg25ovoajzooZj
         VgtAtTicNAuNjsgV1oo6hp8lo9ybG1kDVHFje+cgvjRRi6ndQDysPpm2myn/a6EXVd0T
         opm6k2mKOSao05579WQlnia+oEEHDPnKDGGX5Ae3L3sHo9LR7NjQELnaqF0FMYlKfMeR
         fLxA==
X-Gm-Message-State: ANoB5pkVPJNRZHzmxW/Ikc0oeBBhUnHaw5X1f+WD5o9/PhfJJWpYEdue
        WbSRw8jMVsILKMsnwfG5U4QZlQ==
X-Google-Smtp-Source: AA0mqf5ciHYvPxuAaaVEz4jM+nFvHbYtSONxjtEHHR65kdwaI8ehoRIKYMPx9p3MtfkJfVceVwamuw==
X-Received: by 2002:a17:902:6505:b0:186:a7ff:e8ae with SMTP id b5-20020a170902650500b00186a7ffe8aemr34845364plk.77.1669690386709;
        Mon, 28 Nov 2022 18:53:06 -0800 (PST)
Received: from [10.54.24.49] (static-ip-147-99-134-202.rev.dyxnet.com. [202.134.99.147])
        by smtp.gmail.com with ESMTPSA id s4-20020a17090a764400b0020087d7e778sm172073pjl.37.2022.11.28.18.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 18:53:06 -0800 (PST)
Message-ID: <db6284ba-b936-b38c-662d-3189c14596e7@shopee.com>
Date:   Tue, 29 Nov 2022 10:53:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] cgroup/cpuset: Clean up cpuset_task_status_allowed
To:     Tejun Heo <tj@kernel.org>
Cc:     longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221125075133.12718-1-haifeng.xu@shopee.com>
 <Y4TqvlOmXqY/CBEc@slm.duckdns.org>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <Y4TqvlOmXqY/CBEc@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2022/11/29 01:07, Tejun Heo wrote:
> On Fri, Nov 25, 2022 at 07:51:33AM +0000, haifeng.xu wrote:
>> cpuset_task_status_allowed just shows mems_allowed status, so
>> rename it to task_mems_allowed. Moreover, it's only used in
>> proc_pid_status, so move it to fs/proc/array.c. There is no
>> intentional function change.
>>
>> Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
> 
> mems_allowed being a very much cpuset feature, I don't see how this is an
> improvement. The new code is different and can be another way of doing it,
> sure, but there's no inherent benefit to it. What's the point of the churn?
> 
> Thanks.
> 

Hi, tejun.

In proc_pid_status, task_cpus_allowed is used to show cpus_allowed, similar to that,
task_mems_allowed is more specific to show mems_allowed. Also cpuset_task_status_allowed
is used to dispaly memory status in '/proc/<pid>/status' and isn't used in other files, so
keep it in the fs/proc/array.c.

Thanks,
Haifeng.

