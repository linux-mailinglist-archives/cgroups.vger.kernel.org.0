Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3D53B0A6
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 02:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiFBA0i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 20:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiFBA0h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 20:26:37 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87471258730
        for <cgroups@vger.kernel.org>; Wed,  1 Jun 2022 17:26:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x12so3325501pgj.7
        for <cgroups@vger.kernel.org>; Wed, 01 Jun 2022 17:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=y/gUgyMqWVcRsb+qEaGqa2cDEAVvpf+gfqD2gAKhZeo=;
        b=ItJwGzxeN7XJZuLKJ256vI76Qq2frqb9PjiPVfBOpWWW17LMKIqeeRXz/25pC8lXlQ
         GitrNQa5fCz82T6DMO0vkedLn7U6JEuYtbxflHVlzTWKVG+6DfJoQxGqYsnZ/+xP9M0k
         Y7vZ5P/Z+2irYU+pexBhC5bauIguFdJ0qJBwDxzCT1wlq/P3ppsnYXpBuS95KARPlcjP
         FlI6j+lIHVhfn+dpit9oxJno2DbgUK5gInvdPa2lFd/bs0Tl81/oY4zMhiGoGmRhLkd7
         mYXwcPEN+ZjzzMbHQxFOX8qgBNv3rbCp12Yn+M6Pc2+80NKRZ26j2Va+6/pXWTomYiPn
         DoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=y/gUgyMqWVcRsb+qEaGqa2cDEAVvpf+gfqD2gAKhZeo=;
        b=stsVb29P0i8lwDzjSu8cQqcc6ECNL8zW4rMUGc8K2lYHe2nSzZgM8SIiMPc4Y8CLUd
         yHcjKvf174PK43J7LbVenvAMscMG4TpWWFivzJt2eWVaPnXdF+logX84aP9pBIiCRqx8
         AD+mqBUY/OaY0HAcXfVp7rpAZs3q0oXYA+eoEOBfP/unp/xaekr/CGwcLdH0uDDfe1ak
         K0vQKY840W+mJwCurV++SKZg7W9FvO5odIh/g2Dl5Lk/wrFESrEMK1StobCez82J3Dz+
         DL6DmFU+gtx+5A86rU7CzG8HAJlvs7w61TPWy0lx2SqergktNrNkSFgygBfywf7SxvfU
         TwGQ==
X-Gm-Message-State: AOAM530SgU133lVZ2w/IiPz6uHchZmM/bQECMfr9gqtJtD8IMNl6Xcql
        W0MHgFQQiYduJZadtf947Tj1HDyAHlYPTg==
X-Google-Smtp-Source: ABdhPJyTDDferfqWzYFmGWnh7TdKImUbTnUOH9ymZWwxuTNL5eA0Ob24tCeayY4jYGH43fuUCbkSVg==
X-Received: by 2002:a05:6a00:8c5:b0:510:6eae:6fa1 with SMTP id s5-20020a056a0008c500b005106eae6fa1mr2145386pfu.12.1654129595907;
        Wed, 01 Jun 2022 17:26:35 -0700 (PDT)
Received: from [192.168.254.36] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id y27-20020aa793db000000b0050dc762818asm2013338pff.100.2022.06.01.17.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 17:26:35 -0700 (PDT)
Message-ID: <416dc60a-f0e5-7d05-1613-3cd0ca415768@linaro.org>
Date:   Wed, 1 Jun 2022 17:26:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
References: <20220525151517.8430-1-mkoutny@suse.com>
 <20220525151517.8430-3-mkoutny@suse.com>
 <20220525161455.GA16134@blackbody.suse.cz> <Yo7KfEOz92kS2z5Y@blackbook>
 <Yo/DtjEU/kYr190u@slm.duckdns.org>
 <0babd7df-bdef-9edc-3682-1144bc0c2d2b@linaro.org>
 <Ypf0VnKUMiuRgZqT@slm.duckdns.org>
 <1fb4d8d7-ccc0-b020-715e-38c2dfd94c23@linaro.org>
 <Ypf5jpI7dSmpi4W0@slm.duckdns.org>
 <c3bd8e63-7204-f86d-8efa-254db71185fc@linaro.org>
 <Ypf/MpwzByOrSp6A@slm.duckdns.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
In-Reply-To: <Ypf/MpwzByOrSp6A@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/1/22 17:07, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jun 01, 2022 at 05:00:44PM -0700, Tadeusz Struk wrote:
>> What I'm trying to say is that it's not really a ref imbalance problem.
>> I think once the kill_css() has been called on a css, and it is enqueued to be
>> killed, we shouldn't call css_put(css) on it anymore outside of the "killed call
>> flow path". It will all be handled by the css_killed_ref_fn() function.
>>
>> The fact the css_release() is called (via cgroup_kn_unlock()) just after
>> kill_css() causes the css->destroy_work to be enqueued twice on the same WQ
>> (cgroup_destroy_wq), just with different function. This results in the
>> BUG: corrupted list in insert_work issue.
> 
> I have a hard time following here. The kill / release paths relationship
> isn't that complicated. The kill path is invoked when the percpu_ref's base
> ref is killed and holds an extra ref so that it's guaranteed that release
> can't happen before the kill path is done with the css. When the final put
> happens - whether that's from the kill path or someone else, which often is
> the case - the release path triggers. If we have release getting scheduled
> while the kill path isn't finished, it is a reference counting problem,
> right?
> 
> Can you elaborate the exact scenario that you think is happening? Please
> feel free to omit the function calls and all that. Just lay out who's doing
> what.

Ok the problem is that

1. kill_css() triggers css_killed_ref_fn(), which enqueues &css->destroy_work on cgroup_destroy_wq
2. Last put_css() calls css_release(), which enqueues &css->destroy_work on cgroup_destroy_wq

We have two instances of the same work struct enqueued on the same WQ (cgroup_destroy_wq),
which causes "BUG: corrupted list in insert_work"

So I think the easiest way to solve this would be to have two separate work_structs,
one for the killed_ref path and css_release path as in:

https://lore.kernel.org/all/20220523212724.233314-1-tadeusz.struk@linaro.org/

-- 
Thanks,
Tadeusz
