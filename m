Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254457578F7
	for <lists+cgroups@lfdr.de>; Tue, 18 Jul 2023 12:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGRKJb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jul 2023 06:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGRKJ2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jul 2023 06:09:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA841715
        for <cgroups@vger.kernel.org>; Tue, 18 Jul 2023 03:08:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso43317095ad.2
        for <cgroups@vger.kernel.org>; Tue, 18 Jul 2023 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689674937; x=1692266937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/5gRpkxT+kOgGiftiK7jx1s41nMMWH8tu708xIUfYw=;
        b=e29uBYrQhBw4fVZyXQO7maKHrmGmHqN+r7Pfwwyw8qN9L6QCG6qasmVYpauU/7y7NX
         V1X4gAJCY8eMMHCZ6WctiEW3goRs8B6TcI3b+mYc0KIKrLxLOeTJRRMitQXRYx9PU0hU
         xSSWULc1KTRrdRMIQwft32MH3hqNk315E3+JLhLH/sXfdIbL3x+zsjwNwqs3Hk1HUWMb
         F7eLpqoe+75AjdzbXqk512b2wDlLhX0JV6O3mp4qSguIX3Rfwn2jkEyijkJgyjFqNUrL
         G9HD9+OO++W4mpIMQzFx1HP9oFlTa1ZHh7Dx9dO57Y3PiP7cdWJWnBfe6/QfwZk2S2a9
         joaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689674937; x=1692266937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V/5gRpkxT+kOgGiftiK7jx1s41nMMWH8tu708xIUfYw=;
        b=bEljdm3jcDYQZ3qtWpXkHGNBHqQM/Coqs6ysRalTvrpeKVi6wmUkCiVNc+8xLw0kVh
         iEh0Do8Xp4t/o+zcsgEMyJSCylgEtpKhQBPkyOI6Bz+sUbuLTkGdxOEfpxzRYQH2ryH7
         ZEDlwwqKmg7zzltRf4jowB+0Nwf9sXU00yBTct++IV65A0I7t+HiNfPO7E+Ago2BQ5Zw
         j0TTRg2fqD4zJa2VggxC1hXWkDhBjgufWHzoMHvm5lcKaXTGYsgI3PyiR0WUX/dqnDGb
         53DASpCIzXWcG3ISBgz9F+1Ii8HdwgfKADjhrJXZEAryGay357EO7FnAN0CM+1u7qiqn
         bXEA==
X-Gm-Message-State: ABy/qLZANIRtmBvsnDj2MSEqiufLU/c7on2Ha3KiCMMQPy7bPfOTdK30
        C1CuQgI3jn++5jAcucu0T4a7NQ==
X-Google-Smtp-Source: APBJJlEFg/kl/7XTuskKHo9ULsTb5Xfc2Qrbc6pjFZUAFHmaDKM1g7Mio3hVCETS9ghgb3jUUr8Kdw==
X-Received: by 2002:a17:902:ce84:b0:1b8:3e15:46a1 with SMTP id f4-20020a170902ce8400b001b83e1546a1mr16185279plg.67.1689674937417;
        Tue, 18 Jul 2023 03:08:57 -0700 (PDT)
Received: from [10.85.115.102] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001b869410ed2sm1464369plh.72.2023.07.18.03.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 03:08:57 -0700 (PDT)
Message-ID: <2655026d-6ae4-c14c-95b0-4177eefa434f@bytedance.com>
Date:   Tue, 18 Jul 2023 18:08:50 +0800
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
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <ZLWb-LsBD041hMvr@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Hello,
On 2023/7/18 Tejun Heo wrote:

> On Mon, Jul 17, 2023 at 05:36:12PM +0800, Hao Jia wrote:
>> Now the member variable bstat of the structure cgroup_rstat_cpu
> 
> You said "now" indicating that the behavior has changed recently but I don't
> see what changed there. Can you elaborate?

Thank you for your review, sorry for confusing you with my expression, 
it is true that it has not changed, bstat has always recorded the 
per-cpu time of cgroup itself.

> 
>> records the per-cpu time of the cgroup itself, but does not
>> include the per-cpu time of its descendants. The per-cpu time
> 
> It does. The per-cpu delta is added to its parent and then that will in turn
> be used to propagate to its parent.
>Yes, so only cgrp->bstat contains the cpu time of the cgroup and its 
descendants. rstatc->bstat only records the per-cpu time of cgroup itself.

> 
> I think you're misunderstanding how the code works. Can you please double
> check?

--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -361,11 +361,15 @@ static void cgroup_base_stat_flush(struct cgroup 
*cgrp, int cpu)
  	cgroup_base_stat_sub(&delta, &rstatc->last_bstat);
  	cgroup_base_stat_add(&cgrp->bstat, &delta);
  	cgroup_base_stat_add(&rstatc->last_bstat, &delta);

We add the current cgroup's per-cpu delta to its per-cpu variable 
(cumul_bstat).

+	cgroup_base_stat_add(&rstatc->cumul_bstat, &delta);

  	/* propagate global delta to parent (unless that's root) */
  	if (cgroup_parent(parent)) {
  		delta = cgrp->bstat;
+		rstatc = cgroup_rstat_cpu(parent, cpu);
+
  		cgroup_base_stat_sub(&delta, &cgrp->last_bstat);

Since we hold the global cgroup_rstat_lock and disable interrupts in 
cgroup_base_stat_flush() and we only update cgrp->bstat here.
So the global delta at this time is equal to the increment of this 
cgroup and its descendants on this cpu (unless root cgroup), so we can 
add the global delta to the cumul_bstat of its parent and propagate it 
upward.

+		cgroup_base_stat_add(&rstatc->cumul_bstat, &delta);
  		cgroup_base_stat_add(&parent->bstat, &delta);
  		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
  	}


I wrote a kernel module to verify and test the above kernel code,
The kernel module adds a cpu.stat_percpu_all file for each cgroup, which 
can output the per-cpu time information of the cgroup and its 
descendants calculated in two ways:
1. Cumulatively add the per-cpu bstat of cgroup and each of its descendants.
2. Directly output @cumul_bstat read in the kernel (patch has been applied).
When the child cgroup is not removed, the results calculated by the two 
methods should be equal.

NOTE: We need to flush the data before "cat cpu.stat_percpu_all", such 
as "cat cpu.stat".

Code link:
https://github.com/jiaozhouxiaojia/cgv2-stat-percpu_test/tree/main

The testing procedure is in README.

I installed the 6.5.0-rc1 kernel on my machine (an Intel Xeon(R) 
Platinum 8260 machine 96 CPUs in total.) and did some tests.
So far I haven't found anything unusual, if I'm wrong, please point it 
out, it's very helpful to me, thanks again!

Thanks,
Hao
