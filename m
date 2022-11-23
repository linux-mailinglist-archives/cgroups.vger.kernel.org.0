Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C682E63667B
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiKWRFK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 12:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbiKWRFJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 12:05:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DFC6868D;
        Wed, 23 Nov 2022 09:05:08 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f3so17291221pgc.2;
        Wed, 23 Nov 2022 09:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EztbpzZ3Kt/PihSs3M5nNP63NaXEehzBdLCvtUKvG5E=;
        b=RKa7MkTVo23uF7O9o9uVprUaLAkBBOnLupy8+9eq20WsELWHC3gn7EWXE5QZZKHWgE
         W5gpisnVSt2PfdQ7o92wW2ZgQOV2rO1+3Vp37Ti4G1tz2xNLFT7FdKUezFaDTEydRocP
         6J6urHkFaCS43MXSYtQP6FWwUqNcuGr90JoGwco/EBCVJCXNfQi0jRRzoEeIzgbNgwQ+
         fiL7/oB351BuHm4WO7aOCpXQ88TnjwPch218oKonZo8m81RUIAsKhRr4oThK/j4x/Pfd
         v+z6sXCqjjMEyf55xjUOAgWso7nGWdw00Lk/NqavHQsNO6YNwSU5UbZKd6YcuEoisdD1
         vX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EztbpzZ3Kt/PihSs3M5nNP63NaXEehzBdLCvtUKvG5E=;
        b=iPTvwqhL98lPsVbMsa9xUKuC5JbhaQKY+JfgwoX89VE4mmSmzrkTtDJBzt1AHmGEl2
         59EbU9Zq/UPJjghGeihzqLd6SygfTGE6h8eI1xqIeFCJqLnuaj+C/wn6KonyJTMGj7/v
         A5jJzEtU/NoxuJh0AjIx+7+eJ7MpMKqH0szkcmp1wffL4E1vvC9oVwn30Hj0lckEcI2k
         uCo8RRiI789DQRY6qWeCFqfgWLmyfQi+7Guae2detdsw1C99O2WF2YHd8kFROOBWxUkb
         kYNHgV5xOBVPEloqaS5flJ22VhF3rC+OAtS5P80mPz1Xnz56v7i5CBT+JhUKhUZEcere
         1zXw==
X-Gm-Message-State: ANoB5pnjVH2WeOdfQdiRRBmy0OmC11J/iuOt6qTDp/RMupfN/YnWuxbm
        qO2qakS3L9Nej5f3AbSqw0I=
X-Google-Smtp-Source: AA0mqf5w0WRAp1P0Br3o1b8NnntWzk1RV7xP89lexxIhdmhmFM0mnvmmoPBFNvQkNB/JYx4CfnIbLg==
X-Received: by 2002:a63:ec10:0:b0:477:b359:f03c with SMTP id j16-20020a63ec10000000b00477b359f03cmr5533123pgh.32.1669223107325;
        Wed, 23 Nov 2022 09:05:07 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 124-20020a620482000000b0057294f480casm13327967pfe.97.2022.11.23.09.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:05:06 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 07:05:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "haifeng.xu" <haifeng.xu@shopee.com>
Cc:     longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Optimize update_tasks_nodemask()
Message-ID: <Y35Swdpq+rJe+Tu3@slm.duckdns.org>
References: <20221123082157.71326-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123082157.71326-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 08:21:57AM +0000, haifeng.xu wrote:
> When change the 'cpuset.mems' under some cgroup, system will hung
> for a long time. From the dmesg, many processes or theads are
> stuck in fork/exit. The reason is show as follows.
> 
> thread A:
> cpuset_write_resmask /* takes cpuset_rwsem */
>   ...
>     update_tasks_nodemask
>       mpol_rebind_mm /* waits mmap_lock */
> 
> thread B:
> worker_thread
>   ...
>     cpuset_migrate_mm_workfn
>       do_migrate_pages /* takes mmap_lock */
> 
> thread C:
> cgroup_procs_write /* takes cgroup_mutex and cgroup_threadgroup_rwsem */
>   ...
>     cpuset_can_attach
>       percpu_down_write /* waits cpuset_rwsem */
> 
> Once update the nodemasks of cpuset, thread A wakes up thread B to
> migrate mm. But when thread A iterates through all tasks, including
> child threads and group leader, it has to wait the mmap_lock which
> has been take by thread B. Unfortunately, thread C wants to migrate
> tasks into cgroup at this moment, it must wait thread A to release
> cpuset_rwsem. If thread B spends much time to migrate mm, the
> fork/exit which acquire cgroup_threadgroup_rwsem also need to
> wait for a long time.
> 
> There is no need to migrate the mm of child threads which is
> shared with group leader. 

This is only a problem in cgroup1 and cgroup1 doesn't require the threads of
a given task to be in the same cgroup. I don't think you can optimize it
this way.

Thanks.

-- 
tejun
