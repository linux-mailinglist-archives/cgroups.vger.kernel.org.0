Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B6C557108
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 04:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352160AbiFWCXw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jun 2022 22:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377467AbiFWCXi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jun 2022 22:23:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95C140A04
        for <cgroups@vger.kernel.org>; Wed, 22 Jun 2022 19:23:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so1176347pjr.0
        for <cgroups@vger.kernel.org>; Wed, 22 Jun 2022 19:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=csCXiXt7nFq4+h4WD6heVCXixZoWRVAJL1Lssrp4las=;
        b=WA6u/LptxC6hvIktNHSr3CpHwaPyPUZckJ++HrZ8zmkycEVEbijkXaMLEyDey8F+Lt
         +g9qR64kyl7wYpz43zDjaGpxgpfUYBvM2MdhkLXKLiNBAox4WxuLcd38TMk7diCM5eOL
         tC9IYkjtiUnlLb0jH4nTwNbo1PbJKCHFNfMv2BUZLagEOhrTkFeGlPLJXXFHXNifaD81
         rS/gmlxZpPouMX1g7QzQbznGjyvAn1lNo0P9Oa/y0XRQ/pvZstMIW9Mc0r+zv5BrjsGH
         h8iGUiTl3PWQxbL7LmjM13/+bsHsPrxA+jWjulwftKo/3WMMHrO0Le7Wf11NO9X04NEA
         L3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=csCXiXt7nFq4+h4WD6heVCXixZoWRVAJL1Lssrp4las=;
        b=B1o07G5TeFoEu5EWJrJyVLEWBBWnerMZEE54vP2AXhvLlsQQ8sxxxOrMMBdqEP72pf
         C5HRJN8q3MJJPGy+JeUAfYdL7HFsPkh/WErYqocDWWGcPtfDe/CdM63a/+N2LTSt231O
         YAiGyTlQ1mx1asHqMmYGiO7qZhvGiPCuMzwWRGHgU4zyHZnQk7+5B3gBm0SEjhH6hDqc
         AIGpQdM0443uUD1ylB5xJue6M9MZSY0TiLsL5AX8Yq1xPAnDY4UlsoN8WT5EDbgWPfBJ
         cYqsv+FksAE/P9QCQ944jtSzoHDKi05rhUngspXBCqbwsxihid+kYFx2VN8qIrx24HRQ
         DMhA==
X-Gm-Message-State: AJIora9Y+0EDkF6YbGHwo0tE9MH/9TukJf92ur/Dc1yf+wKbelvqfChJ
        3viKwzg+A0q23VK2z+eWGDtPTA==
X-Google-Smtp-Source: AGRyM1uqKjCtHrQUq09eFtxE8toLu3fagTEkTNfoVLp49TLIhUukD4B98EO0re9osjwaTkK0xXam5A==
X-Received: by 2002:a17:90b:344f:b0:1ed:9f:a2de with SMTP id lj15-20020a17090b344f00b001ed009fa2demr1532594pjb.174.1655951013124;
        Wed, 22 Jun 2022 19:23:33 -0700 (PDT)
Received: from [10.70.253.98] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id h4-20020a62de04000000b0051bb61c0eacsm5989417pfg.20.2022.06.22.19.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 19:23:32 -0700 (PDT)
Message-ID: <888b6885-5380-e21f-260f-eb1bb89679c3@bytedance.com>
Date:   Thu, 23 Jun 2022 10:23:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [External] Re: [PATCH v2] sched: RT bandwidth interface for
 cgroup unified hierarchy
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     rdunlap@infradead.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622015557.7497-1-zhouchengming@bytedance.com>
 <20220622173929.GA669@blackbody.suse.cz>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220622173929.GA669@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Michal,

On 2022/6/23 01:39, Michal Koutný wrote:
> Hello Chengming.
> 
> On Wed, Jun 22, 2022 at 09:55:57AM +0800, Chengming Zhou <zhouchengming@bytedance.com> wrote:
>> We need to run RT threads in cgroup unified hierarchy, but we can't
>> since the default rt_bandwidth.rt_runtime of non-root task_group is 0
>> and we haven't interface to update it.
> 
> Do you really want to make use of group RT schedulling
> (CONFIG_RT_GROUP_SCHED) or just be able to run RT threads in the unified
> hieararchy with cpu controller enabled?
> 

The latter could meet our current needs I think, but it would be better that
we can put a max limit on the task_group in case multiple groups need to
run RT processes.

> Those are two different use cases, the former is more complex and it's a
> reason why v2 doesn't expose the RT attributes (yet).
> The latter is typically achieved by unsetting CONFIG_RT_GROUP_SCHED (and
> relying on the global rt_runtime limit).
> 

I don't know why v2 differ from v1 in the RT bandwidth control.. Is there
some links of explanation? (CFS bandwidth control can work on v2 now.)

If the problem can't be solved, we have to unset CONFIG_RT_GROUP_SCHED.

Thanks.

> Thanks,
> Michal
