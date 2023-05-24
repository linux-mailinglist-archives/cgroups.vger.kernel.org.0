Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9CC70F141
	for <lists+cgroups@lfdr.de>; Wed, 24 May 2023 10:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240073AbjEXInK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 May 2023 04:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240301AbjEXImw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 May 2023 04:42:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26D6E4F
        for <cgroups@vger.kernel.org>; Wed, 24 May 2023 01:41:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2532d6c7ef2so8474a91.0
        for <cgroups@vger.kernel.org>; Wed, 24 May 2023 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684917680; x=1687509680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTHbB0gony/TYMogUW6Qo/V1GtsaSfduo/QCXMjaxUM=;
        b=ZnX7arnhJ7Q+Ipi910Jn2NK7QtDaPy4TlGLSCmXMrFgaUyqr1HH/K1c8b6/vd5Uy7O
         jNoxiqXlVyu7dS8JQ6XZcHcyTIWBo5LiGPQ2ieUIGyL0YZetHQ2aHFnCghlX8XgkIv+F
         f5EuBJnyV4VDQSb9NGCcJtePUs1XekOOsQ7ZeebwLbsoZ8oXPbGQ8lEuVgI+YY4ZT/0S
         A5DUGll7sRLEHXSOQqu1Q8FZI26Y3oe3l2415CbQ8TxjnBND2kMPXNEJYohRbUKP5kVZ
         woD/ctZI3vJHoAqhsIdLRO+9uYd6q4ASQGv3xtle4N7GIVzykLdRozpCCKQxXXlzaFno
         K06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684917680; x=1687509680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dTHbB0gony/TYMogUW6Qo/V1GtsaSfduo/QCXMjaxUM=;
        b=EWx4lbL1rmqxF3Ycq+6wc7skA3t594aEHgxvsT8qevB0qRMGuD4Epgyxn9CstXetu+
         Emo5ELyOLB6mm/0RcbvfsyuNJGtf0XKzQF05G/EAi2zZ36TZAbHFlX4ByKyh1vm8AeEC
         w2KHZ6kXH2MFB2xQ9bYQFvniU4uFBIL9Ssw671PNTSQ6M2e24b6Iv/xiw+R4bl9ccxyB
         z404mKPvHn5vzUV0R92uRDNKZqyXlO8vXMbp8c4jba3xIThdkzlXZeGRS9t7e1MoO9HL
         cHKgJJbZJ1b2lMJGObPUkkvdsNJmlHZhpm5kL69PKWawXI0q5Z6U80MMLmnmYkw9MMA/
         RawQ==
X-Gm-Message-State: AC+VfDzv6e6GvsNFWNXMNK8yqcq8kcEb2RROi0FL9CGKO2yysW3A4fFm
        BqCkqqZbID/Oqkj2K6BU9x9Ngw==
X-Google-Smtp-Source: ACHHUZ5hZGClD8Wm6BRjHwUzH4LIwlL/jyB4wklJZWIBhBzz+AkGHz5cDJ1YVqdT0xuc+4+ZgMFqtA==
X-Received: by 2002:a17:90b:378c:b0:23f:962e:825d with SMTP id mz12-20020a17090b378c00b0023f962e825dmr17772299pjb.1.1684917680462;
        Wed, 24 May 2023 01:41:20 -0700 (PDT)
Received: from [10.85.115.102] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id n3-20020a17090ab80300b00253298287ccsm857956pjr.14.2023.05.24.01.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 01:41:20 -0700 (PDT)
Message-ID: <8e65aa62-c92c-857d-3e27-8ccddf51b07f@bytedance.com>
Date:   Wed, 24 May 2023 16:41:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH] cgroup: rstat: Simplified
 cgroup_base_stat_flush() update last_bstat logic
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230518124142.57644-1-jiahao.os@bytedance.com>
 <f39b9229-e59c-2b1c-7f3f-1aeedfad44dc@bytedance.com>
 <5g73i4yvi4ub4dqrf4dnq5qghkyckoygmgd2st6be3gg7twww2@w6zim6nxpt3b>
 <4d49f7e7-2488-9690-258e-34e617cfef6f@bytedance.com>
 <remnwctqmxleig7ywt6puhxnpmzjo7xm6hlfhpnul46ulfnw7j@36sbuxhuatto>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <remnwctqmxleig7ywt6puhxnpmzjo7xm6hlfhpnul46ulfnw7j@36sbuxhuatto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/5/24 Michal Koutný wrote:
> On Wed, May 24, 2023 at 02:54:10PM +0800, Hao Jia <jiahao.os@bytedance.com> wrote:
>> Yes, so we need @curr to record the bstat value after the sequence fetch is
>> completed.
> 
> No, I still don't see a problem that it solves. If you find incorrect
> data being reported, please explain it more/with an example.

Sorry to confuse you.

My earliest patch is like this:

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 9c4c55228567..3e5c4c1c92c6 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -376,14 +376,14 @@ static void cgroup_base_stat_flush(struct cgroup 
*cgrp, int cpu)
     /* propagate percpu delta to global */
     cgroup_base_stat_sub(&delta, &rstatc->last_bstat);  (1) <---
     cgroup_base_stat_add(&cgrp->bstat, &delta);
- cgroup_base_stat_add(&rstatc->last_bstat, &delta);
+ rstatc->last_bstat = rstatc->bstat; 			(2) <--

     /* propagate global delta to parent (unless that's root) */
     if (cgroup_parent(parent)) {
        delta = cgrp->bstat;
        cgroup_base_stat_sub(&delta, &cgrp->last_bstat);
        cgroup_base_stat_add(&parent->bstat, &delta);
- cgroup_base_stat_add(&cgrp->last_bstat, &delta);
+ cgrp->last_bstat = cgrp->bstat;
     }
   }

If I understand correctly, the rstatc->bstat at (1) and (2) may be 
different. At (2) rstatc->bstat may have been updated on other CPUs.
Or we should not read rstatc->bstat directly, we should pass the 
following way

     do {
        seq = __u64_stats_fetch_begin(&rstatc->bsync);
        cur = rstatc->bstat;
     } while (__u64_stats_fetch_retry(&rstatc->bsync, seq));


> 
>> Yes, but it may not be obvious.
>> Another reason is that when we complete an update, we snapshot last_bstat as
>> the current bstat, which is better for readers to understand. Arithmetics is
>> somewhat obscure.
> 
> The readability here is subjective. It'd be interesting to have some
> data comparing arithmetics vs copying though.

Thanks for your suggestion, I plan to use RDTSC to compare the time 
consumption of arithmetics vs copying. Do you have better suggestions or 
tools?

Thanks,
Hao
