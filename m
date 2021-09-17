Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2F940EEFD
	for <lists+cgroups@lfdr.de>; Fri, 17 Sep 2021 03:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbhIQB6n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Sep 2021 21:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhIQB6l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Sep 2021 21:58:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A12C061574;
        Thu, 16 Sep 2021 18:57:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g14so7746155pfm.1;
        Thu, 16 Sep 2021 18:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zdlBFrQubRXdUqdsVIqT/f0kDrO2skTyaf0KO7tBrEA=;
        b=Mm2mXvEmWnkptp65WTD/gcjpkxrVxksIJDvdZDvgHI6cEi5LGPVpNOLCxvzKWLk4NN
         mnF+nfWG/Xv/QVKeWwa7t1wa5NNH8xeUCdyTmKUrSooxGFE8oz89B+Q0BX8lONlE9LeW
         0sI9um0vnWjkWx7NfuRjc9xI3nBce0M16bpA7u1uI7ZQeiw229KqTvZKZcwFyLrLVW5I
         XlwYYmYV9Tkk5jBUlLrGTDbmGX5oseINzQ7WnQHiQl7RfIeyExo08fir0L66wd6uMOl3
         MVkmq+c5fY75mYTjwFd46+jTsA9ZqLp/W+vw959b4hSftgcER7wWk03a5gvMTgfVUUFJ
         kNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zdlBFrQubRXdUqdsVIqT/f0kDrO2skTyaf0KO7tBrEA=;
        b=pjCAczheeE2eUuInjw5w98fKvOPz5i6Q2OBESMH+JkLlCIiYP/B/9RGmpopw2vsmny
         nq7uW2FtMYOBAt/1xyMcGg5+SqZOCJllB3cxKBVQJi8YwUGl6jG9fQNdvh0DJc20V6tz
         ybkOKvUb30x8gN1yULfP8QYDzkDnx5LcFx6NpnR5hMVILUMMI+G9IO57ZcR2QzoQ7dqK
         B8ccWGoIVq5Vj1YcR1ls/KHnC8imWXmduCnx/GI03OUJ3BJ9xxfgaStGvg9tYZ0Yku8X
         VkgPGbvtxzofqZITVaieRsUs/fRPBNq/ssq8hP2vZ/l9ezGTkE9P7RYOYbnItTQtQlOS
         6yWQ==
X-Gm-Message-State: AOAM532v3c2OW4DZHNiLtc4A+xK5YbB6O5iXVGoEnTH8uJj2fEwsYSO8
        1XsE+k9XDZSGHP246neGEmq9RXDF9z0=
X-Google-Smtp-Source: ABdhPJzfbENTuBRjqv55PN+BgHOkd3mvK106kXS6TpfZpzi302Gp+NlZ64tDh7Ol7MCMPK1nbqpkHA==
X-Received: by 2002:a63:385e:: with SMTP id h30mr7600655pgn.187.1631843838356;
        Thu, 16 Sep 2021 18:57:18 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.115])
        by smtp.gmail.com with ESMTPSA id f27sm4292097pfq.78.2021.09.16.18.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 18:57:17 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] misc_cgroup: remove error log to avoid log flood
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        vipinsh@google.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
 <a960cd793f649bd944127fe5e5e3f4d8bb9040a4.1631671936.git.brookxu@tencent.com>
 <20210916175711.GA12643@blackbody.suse.cz>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <eece1309-4c1e-909a-22ea-3db31ad7a1da@gmail.com>
Date:   Fri, 17 Sep 2021 09:56:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210916175711.GA12643@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thanks for your time.

Michal Koutný wrote on 2021/9/17 1:57 上午:
> On Wed, Sep 15, 2021 at 10:18:50AM +0800, brookxu <brookxu.cn@gmail.com> wrote:
>> In scenarios where containers are frequently created and deleted,
>> a large number of error logs maybe generated. This log provides
>> less information, we can get more detailed info from misc.events.
> 
> IIUC, the log provides equal information (with persistence), no?
> 
>> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
>> index 4b2b492..fe3e8a0 100644
>> --- a/kernel/cgroup/misc.c
>> +++ b/kernel/cgroup/misc.c
>> @@ -157,13 +157,6 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
>>  		new_usage = atomic_long_add_return(amount, &res->usage);
>>  		if (new_usage > READ_ONCE(res->max) ||
>>  		    new_usage > READ_ONCE(misc_res_capacity[type])) {
>> -			if (!res->failed) {
>> -				pr_info("cgroup: charge rejected by the misc controller for %s resource in ",
>> -					misc_res_name[type]);
>> -				pr_cont_cgroup_path(i->css.cgroup);
>> -				pr_cont("\n");
>> -				res->failed = true;
>> -			}
> 
> As I argued previously, reporting this as "in" `i` cgroup instead
> of `cg` is not that useful and equivalent to the misc.events:*.max now,
> so the drop is appropriate.
> 
> The change/patch is OK,
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> 
> The commit message might be fixed (if you agree with remark).

Yeah, maybe we should make it more clearly, What do you think of
the commit below:

In scenarios where containers are frequently created and deleted,
a large number of error logs maybe generated. The logs only show
which node is about to go over the max limit, not the node which
resource request failed. As misc.event has provided relevant
information, maybe we can remove this log.


> 
