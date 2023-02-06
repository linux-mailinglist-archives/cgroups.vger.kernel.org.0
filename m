Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D52668C762
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 21:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjBFUPw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 15:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjBFUPu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 15:15:50 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EDC29E23;
        Mon,  6 Feb 2023 12:15:36 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w5so3380038plg.8;
        Mon, 06 Feb 2023 12:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJb35mhM2Hbo2R5tiLKHQvqDWiCTe8jrz1+VmmZokUg=;
        b=pBxCY01r9CDzvCb4m4soEW0AV3WnU9oLYZAyLjld3Nb+mxlySjB4wCvRVd9En70iko
         L/c/CzynnU7bG0S4aKqtD67H/E/jYTZxDQ5AFgyKeyeKJ+rmonw8UjOog8fEntBVAY0A
         LBQ5uYBcgGg995N5Pqmf08fP/3vPbIpGu96UwjTh8FgKOBInWv+p67r3FDZdKumz3pHZ
         pISkxr2SlRYJoylU6ag4JfjJoRRubNx4pDVSLHvNU4iXtM57kBmOjKD+Pt9xexDKVW4/
         zlru3lnpWVsD/Lm+ZHInNDu6+mBvdn5vmhqNHC5UTlg+pvwysYStqLSytggrrYL7eQCC
         Z0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJb35mhM2Hbo2R5tiLKHQvqDWiCTe8jrz1+VmmZokUg=;
        b=tbLx3p7y+A5SPzMBhueOyr469bhOd/alde+LmrPokuWaG05FM/ezht54gAVnoJOKB8
         6p4rCamOTm9toRP5d4oeHQxx5h5N9F6A32A13e45ioO7sjIpHqz/niIBceDdhUvBedrZ
         Xt+XwFjVSP+5+pXfG4XUL0+Ucqohho4j3h8DJUHPBWQoR5fHWB8PDQOV02LtYPVk8xr1
         x96cLZehg7W8UcujzlLtwkIWc3Od3AybfwEH3QBtdkaIF/DIntNg6C75x2+S0MUxh+r6
         2AdxMvZ7dmFSvgc4tnUGKFod/GR+IW6yE//F9tNjtV5lpBU995zOrqz7CdLd+QYi3SDW
         dlMw==
X-Gm-Message-State: AO0yUKWGYsB5TeBp30PSUCoKkh7S/2mHbT+qZEx6hw0JHmO/OD02uovu
        TeQVi27rkmihAXPx4GEuRrU=
X-Google-Smtp-Source: AK7set/FPg5UtlcVqKFFhDzRoEcFW7n1dj/21K9rfzkNeY9EIkjuCy6fBmKwwDN31wTnR5OOjFCAOA==
X-Received: by 2002:a17:90b:4aca:b0:230:b643:1f90 with SMTP id mh10-20020a17090b4aca00b00230b6431f90mr901808pjb.29.1675714535317;
        Mon, 06 Feb 2023 12:15:35 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090a678f00b00230ab56a1f3sm2852672pjj.51.2023.02.06.12.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:15:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 6 Feb 2023 10:15:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2] cgroup/cpuset: Don't filter offline CPUs in
 cpuset_cpus_allowed() for top cpuset tasks
Message-ID: <Y+Ff5Hi3S0ftz+XK@slm.duckdns.org>
References: <20230206034853.330463-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206034853.330463-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Feb 05, 2023 at 10:48:53PM -0500, Waiman Long wrote:
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user
> requested cpumask"), relax_compatible_cpus_allowed_ptr() is calling
> __sched_setaffinity() unconditionally. This helps to expose a bug in
> the current cpuset hotplug code where the cpumasks of the tasks in
> the top cpuset are not updated at all when some CPUs become online or
> offline. It is likely caused by the fact that some of the tasks in the
> top cpuset, like percpu kthreads, cannot have their cpu affinity changed.
> 
> One way to reproduce this as suggested by Peter is:
>  - boot machine
>  - offline all CPUs except one
>  - taskset -p ffffffff $$
>  - online all CPUs
> 
> Fix this by allowing cpuset_cpus_allowed() to return a wider mask that
> includes offline CPUs for those tasks that are in the top cpuset. For
> tasks not in the top cpuset, the old rule applies and only online CPUs
> will be returned in the mask since hotplug events will update their
> cpumasks accordingly.
> 
> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
> Reported-by: Will Deacon <will@kernel.org>
> Originally-from: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.2-fixes.

Thanks.

-- 
tejun
