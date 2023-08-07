Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E287718D1
	for <lists+cgroups@lfdr.de>; Mon,  7 Aug 2023 05:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjHGDgz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 6 Aug 2023 23:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHGDgy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 6 Aug 2023 23:36:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FB49F
        for <cgroups@vger.kernel.org>; Sun,  6 Aug 2023 20:36:29 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68336d06620so3923409b3a.1
        for <cgroups@vger.kernel.org>; Sun, 06 Aug 2023 20:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691379388; x=1691984188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAmHsv0aooR3nX10HEjLL5tP/plsIB0hDyj15nET4fc=;
        b=HX/bG4KLwTRh5wjISv7jDf/BZhZZfMUQIkKKTpsE4Z/nEdgem5yGJQ+klykQb7Br0q
         y7EA4Xwz6bfgAGBQ4je7kw+PXiEnHaeArh2+vVWRJ5R9GbwnzOWeJoAemOa10kykp9xs
         sr7uBgapdp0vnVjhZdiUHAXUpwVoJqEWqfYiAHpIZuPu3bL/MJ/MEeLVObazbIxMmrPE
         ULlmAFuVXJtd3P6tz4I0Ken9ItLgysJzH3OhNswJQO8BKFVzsjN4sPM8mUk0t0qifGfh
         FFZ5MOWXOM+mbM3Pa2SRYH6Udxq6Z3Uu8YbpxsE+pFrs64y9fepLwckCpV2uWOFy/AW1
         apDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691379388; x=1691984188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WAmHsv0aooR3nX10HEjLL5tP/plsIB0hDyj15nET4fc=;
        b=YyU3MeyuVevKGEgFM+VJp1HL5deDnaV6y3Oof1VSE/2IHe9y5BUmNXAcY+wp070Xdc
         bsiOAEv/FVXkq3Vza7UvnqxtvS+/VAd/EzefPXaEk8bCHi1poFkM1pC2JdIiAD9CgLRD
         CWC6kaySXKWxIHCmb+/OOvThLsJFYrI8tqcPwIc5UZNgjo9RO66++usTjqYQB/d0xIMW
         RyPbeewgktCTJr/Jy39gqGidYNA/GHq+DuI9qa7akRc3s9aKrPpWd0bDFDN4264b3dRK
         hMzVO5sou7VgMlVAHGspYYEZ2c8TiUiTsD0Hm1AyJ2VDUA3T/6kyxHpwiAH0HTG0gA0p
         8o+w==
X-Gm-Message-State: AOJu0Yz4Y6wSVo8u8EuWljApQLkxci5m2kLUwOcxISCSgaHs7/JKRQMY
        BzWHX7zB/T6QGWGnIkBkPojdj5M1zrSiqFfB5sM=
X-Google-Smtp-Source: AGHT+IEZFPA7qWk9DHQsPtm3SkDoNZK1SccOG5TU0sYc3d+dZtsrq0mteg81HlB/V1W6YKLdp3+GKw==
X-Received: by 2002:a05:6a00:180c:b0:66a:386c:e6a6 with SMTP id y12-20020a056a00180c00b0066a386ce6a6mr11061551pfa.6.1691379388661;
        Sun, 06 Aug 2023 20:36:28 -0700 (PDT)
Received: from [10.85.115.102] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7820e000000b0063f00898245sm5106601pfi.146.2023.08.06.20.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 20:36:28 -0700 (PDT)
Message-ID: <2ee4f673-8218-ac72-684f-3cd78c46f750@bytedance.com>
Date:   Mon, 7 Aug 2023 11:36:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [External] Re: [PATCH] cgroup/rstat: record the cumulative
 per-cpu time of cgroup and its descendants
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230717093612.40846-1-jiahao.os@bytedance.com>
 <ZLWb-LsBD041hMvr@slm.duckdns.org>
 <2655026d-6ae4-c14c-95b0-4177eefa434f@bytedance.com>
 <ZLcJ1nH8KzWzoQWj@slm.duckdns.org>
 <b4424767-dce7-08a9-3759-43cc9dfa4273@bytedance.com>
 <3d2b68bf-9f40-c779-dcfd-4cf9939edecc@bytedance.com>
 <ZMKs_GpHEW6Pfusj@slm.duckdns.org> <ZMrNHf2tg8AZ2F0z@slm.duckdns.org>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <ZMrNHf2tg8AZ2F0z@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/8/3 Tejun Heo wrote:
> I couldn't come up with an answer. Let's go ahead with adding the field but
> can you please do the followings?
> 

Thank you for your suggestion. I am very willing to do it.

> * Name it to something like subtree_bstat instead of cumul_bstat. The
>    counters are all cumulative.

I did it in v2 patch.

> 
> * Are you sure the upward propagation logic is correct? It's calculating
>    global delta and then propagating to the per-cpu delta of the parent. Is
>    that correct because the two delta calculations always end up the same?

Sorry, I made a mistake and misled you. These two deltas are not always 
equal.

I found and reproduced a bug case:
We build /sys/fs/cgroup/test /sys/fs/cgroup/test/t1, 
/sys/fs/cgroup/test/t1/tt1 in turn.
And there are only tasks in /sys/fs/cgroup/test/t1/tt1. After applying 
this patch, some operations and corresponding data changes are as follows:

Step 1、cat /sys/fs/cgroup/test/t1/tt1/cpu.stat
*cpu 6* current flush cgroup /test/t1/tt1
per-cpu delta utime 0 stime 0 sum_exec_runtime 257341
/test/t1/tt1 cumul_bstat(cpu 6) utime 0 stime 0 sum_exec_runtime 257341
/test/t1/tt1 cgrp->bstat utime 0 stime 0 sum_exec_runtime 257341
if (cgroup_parent(parent)) {
     cgrp delta utime 0 stime 0 sum_exec_runtime 257341
     parent(/test/t1) ->bstat utime 0 stime 0 sum_exec_runtime 257341
     parent(/test/t1) last_bstat utime 0 stime 0 sum_exec_runtime 0
     parent(/test/t1) cumul_bstat utime 0 stime 0 sum_exec_runtime 257341
}


Step 2、cat /sys/fs/cgroup/test/t1/tt1/cpu.stat
*cpu 12* current flush cgroup /test/t1/tt1
per-cpu delta utime 0 stime 1000000 sum_exec_runtime 747042
/test/t1/tt1 cumul_bstat utime 0 stime 1000000 sum_exec_runtime 747042
/test/t1/tt1 cgrp->bstat utime 0 stime 1000000 sum_exec_runtime 1004383
if (cgroup_parent(parent)) {
     cgrp delta utime 0 stime 1000000 sum_exec_runtime 747042
     parent(/test/t1) ->bstat utime 0 stime 1000000 sum_exec_runtime 1004383
     parent(/test/t1) last_bstat utime 0 stime 0 sum_exec_runtime 0
     parent(/test/t1) cumul_bstat utime 0 stime 1000000 sum_exec_runtime 
747042
}


Step 3、cat /sys/fs/cgroup/test/cpu.stat
(cgroup fulsh /test/t1/tt1 -> /test/t1 -> /test in turn)

*cpu 6*  current flush cgroup /test/t1/tt1
per-cpu delta utime 0 stime 0 sum_exec_runtime 263468
/test/t1/tt1 cumul_bstat(cpu 6) utime 0 stime 0 sum_exec_runtime 520809
/test/t1/tt1 cgrp->bstat utime 0 stime 1000000 sum_exec_runtime 1267851
if (cgroup_parent(parent)) {
     cgrp delta utime 0 stime 0 sum_exec_runtime 263468
     parent(/test/t1) ->bstat utime 0 stime 1000000 sum_exec_runtime 1267851
     parent(/test/t1) last_bstat utime 0 stime 0 sum_exec_runtime 0
     parent(/test/t1) cumul_bstat utime 0 stime 0 sum_exec_runtime 520809
}

*cpu 6* current flush cgroup /test/t1
per-cpu delta utime 0 stime 0 sum_exec_runtime 0
/test/t1 cumul_bstat(cpu 6) utime 0 stime 0 sum_exec_runtime 520809
/test/t1 cgrp->bstat utime 0 stime 1000000 sum_exec_runtime 1267851
if (cgroup_parent(parent)) {
     cgrp delta utime 0 stime 1000000 sum_exec_runtime 1267851  <---
     parent(/test) ->bstat utime 0 stime 1000000 sum_exec_runtime 1267851
     parent(/test) last_bstat utime 0 stime 0 sum_exec_runtime 0
     parent(/test) cumul_bstat (cpu 6) utime 0 stime 1000000 
sum_exec_runtime 1267851 <--- *error*
******
   Here cgrp delta is *not equal* to per-cpu delta.
   The frequency of cgroup (/test) and its chiled cgroup (/test/t1/tt1) 
  flush is inconsistent.
   In other words (when we call cgroup_base_stat_flush(), we will not 
necessarily flush to the highest-level cgroup except root(like step 1 
and 2 above)).
   Therefore, cgrp delta may contain the cumulative value of multiple 
per-cpu deltas.

   The correct value of parent(/test) cumul_bstat should be utime 0 
stime 0 sum_exec_runtime 520809.
******
}

*cpu 6* current flush cgroup /test
per-cpu delta utime 0 stime 0 sum_exec_runtime 0
cumul_bstat utime 0 stime 1000000 sum_exec_runtime 1267851
/test ->bstat utime 0 stime 1000000 sum_exec_runtime 1267851
	cgroup_parent(parent) is NULL end.


So we should add a per-cpu variable subtree_last_bstat similar to 
cgrp->last_bstat to record the last value.

I have sent v2 patch, please review it again.
v2 link:
https://lore.kernel.org/all/20230807032930.87785-1-jiahao.os@bytedance.com


> * Please add a comment explaining that the field is not currently used
>    outside of being read from bpf / drgn and what not and that we're still
>    trying to determine how to expose that in the cgroupfs interface.


Thanks, I did it in v2 patch.

Thanks,
Hao
