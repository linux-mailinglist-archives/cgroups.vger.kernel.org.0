Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9307765AB0
	for <lists+cgroups@lfdr.de>; Thu, 27 Jul 2023 19:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjG0Roc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jul 2023 13:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0Rob (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jul 2023 13:44:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0274730ED;
        Thu, 27 Jul 2023 10:44:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso9940345ad.2;
        Thu, 27 Jul 2023 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690479870; x=1691084670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMgWDc9HbFTZfCAa6CCrY6Sm3n2por+mG+JbQWL++uA=;
        b=RCcaFekWryy06wzg7UAG1HDH/IAEIm1lTcU2yxEyeXZqezvcy9ba1nwpBwUzwpGQgc
         lQ3sb9j9/E0Yaev3i/fzaujjnPQbX7LogkJXoL90KihlX1Zom10V1ZM0F3VdaIkxDOKf
         dFkC6yqPsAl14hIZglw5FB2XcyowxvSwcPHyuYwmG2oIZ7foSHXypHzsEIgE9jMl8FcR
         Sb8z/S59K2ojW/sYB4CYTjqALXlxjMX7Hcx7WUUnGJQ4izz77GRc1u4vcaT0OWD5+F00
         r8vwmL5MFpeJ3guxnS7gaG6omeZ+Tu8E5AIyp2mAWjKMqDs4vCtnF3nlfvVOPCwN9xG0
         LNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690479870; x=1691084670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMgWDc9HbFTZfCAa6CCrY6Sm3n2por+mG+JbQWL++uA=;
        b=M/oQShgim3oMboW8cDAQIuVaIJ3dxVA+ZdFZ1mih7ggQreVU6ALPjx4wWbYQfucf3k
         QnyEc4L3DFcZ6h+RSmI2bIpjBbWU7/Mn10sLCUZZB+PPtAGCHfU/i1qcuye/dX/deMFv
         aXqA3Zlf7fu7VrOKwS7bFveWsOQXgXAbeJT0v1aH3fWfD6Ca2YbM2+HbAvLXcRU5hGNM
         P5G1uwLR4zGNh8ERYdm3wwJ/FToowzC2v6NShEqEWRLs41T5mOoR02/onPGYCtuM90Fw
         /Hw6Nsg1/Zo/MuG4OObqESFCzDAcgi3JeHQz7b6tDfKjxfRcBRmcjk6OmOKkHYTABure
         yd1Q==
X-Gm-Message-State: ABy/qLYRqlw/rtSzehwWu9AoNUrUOnHqV5rdPLOAJDRQFCjW1jLMDhSc
        xsmE/IypIp0sfH+0YjGFp/U=
X-Google-Smtp-Source: APBJJlHqO6KJcrPmL8ndI3Kt7nuHJUY3BOV2djXSTj7C+MJvcy3AYBia7KUeoSS44rKzovyqSIcHFw==
X-Received: by 2002:a17:902:ec8e:b0:1b3:d4d5:beb2 with SMTP id x14-20020a170902ec8e00b001b3d4d5beb2mr263plg.9.1690479870092;
        Thu, 27 Jul 2023 10:44:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:18d])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b001bbce3d4774sm1935589plb.79.2023.07.27.10.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:44:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 27 Jul 2023 07:44:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] cgroup/rstat: record the cumulative
 per-cpu time of cgroup and its descendants
Message-ID: <ZMKs_GpHEW6Pfusj@slm.duckdns.org>
References: <20230717093612.40846-1-jiahao.os@bytedance.com>
 <ZLWb-LsBD041hMvr@slm.duckdns.org>
 <2655026d-6ae4-c14c-95b0-4177eefa434f@bytedance.com>
 <ZLcJ1nH8KzWzoQWj@slm.duckdns.org>
 <b4424767-dce7-08a9-3759-43cc9dfa4273@bytedance.com>
 <3d2b68bf-9f40-c779-dcfd-4cf9939edecc@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d2b68bf-9f40-c779-dcfd-4cf9939edecc@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 27, 2023 at 08:05:44PM +0800, Hao Jia wrote:
> 
> 
> On 2023/7/19 Hao Jia wrote:
> > 
> > 
> > On 2023/7/19 Tejun Heo wrote:
> > > On Tue, Jul 18, 2023 at 06:08:50PM +0800, Hao Jia wrote:
> > > > https://github.com/jiaozhouxiaojia/cgv2-stat-percpu_test/tree/main
> > > 
> > > So, we run `stress -c 1` for 1 second in the asdf/test0 cgroup and
> > > asdf/cpu.stat correctly reports the cumulative usage. After removing
> > > asdf/test0 cgroup, asdf's usage_usec is still there. What's missing here?
> > 
> > Sorry, some of my expressions may have misled you.
> > 
> > Yes, cpu.stat will display the cumulative **global** cpu time of the
> > cgroup and its descendants (the corresponding kernel variable is
> > "cgrp->bstat"), and it will not be lost when the child cgroup is
> > removed.
> > 
> > Similarly, we need a **per-cpu** variable to record the accumulated
> > per-cpu time of cgroup and its descendants.
> > The existing kernel variable "cgroup_rstat_cpu(cgrp, cpu)->bstat" is not
> > satisfied, it only records the per-cpu time of cgroup itself,
> > So I try to add "cgroup_rstat_cpu(cgrp, cpu)->cumul_bstat" to record
> > per-cpu time of cgroup and its descendants.
> > 
> > In order to verify the correctness of my patch, I wrote a kernel module
> > to compare the results of calculating the per-cpu time of cgroup and its
> > descendants in two ways:
> >    Method 1. Traverse and add the per-cpu rstatc->bstat of cgroup and
> > each of its descendants.
> >    Method 2. Directly read "cgroup_rstat_cpu(cgrp, cpu)->cumul_bstat" in
> > the kernel.
> > 
> > When the child cgroup is not removed, the results calculated by the two
> > methods should be equal.
> > 
> > > What are you adding?
> > I want to add a **per-cpu variable** to record the cumulative per-cpu
> > time of cgroup and its descendants, which is similar to the variable
> > "cgrp->bstat", but it is a per-cpu variable.
> > It is very useful and convenient for calculating the usage of cgroup on
> > each cpu, and its behavior is similar to the "cpuacct.usage*" interface
> > of cgroup v1.
> > 
> 
> Hello Tejun,
> 
> I don't know if I explained it clearly, and do you understand what I mean?
> 
> Would you mind adding a variable like this to facilitate per-cpu usage
> calculations and migration from cgroup v1 to cgroup v2?

Oh yeah, I do. I'm just thinking whether we also want to expose that in the
cgroupfs. We are currently not showing anything per-cpu and the output
formatting gets nasty with a huge number of CPUs, so maybe that's not going
to work out all that well. Anyways, I'll get back to you next week.

Thanks.

-- 
tejun
