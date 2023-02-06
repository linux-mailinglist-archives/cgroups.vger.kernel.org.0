Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72F868C78A
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 21:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjBFUVe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 15:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBFUVc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 15:21:32 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9790E23C5F;
        Mon,  6 Feb 2023 12:21:28 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso14180725pju.0;
        Mon, 06 Feb 2023 12:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQClKqLnds1opGgSJyQ6rzcJmQ10WKwpGChwetbEKcU=;
        b=efdgSjsOXF6+7eDVBbj4cZDq2y8Fpq1m3BSA/uQkyn5ztYOfHyFuWj8++8RxqBigpS
         nMOi3bS404AzlJKhRG5k0awpokIR7Pvf60WrtttAOFmQ89gX3iAuanpf7TLimOS4gv81
         yG6/hoETkFN0z10oPR6XbojvJlTppWmvE5M4ZluVQghRtEG9kdWi/0qnz9tn5aiZX8T2
         kuykMeZD0bvey/NQ/rgOzvZAX5AJxppVXBvXUY+f4e4qqR997WJ4ScAs3zqFSp1rfXM+
         Hoaje4tIOy6/OGyDJmBZWKCefW2ObmDrZC+zgSQK4dyudG/cqaV2hm3IZLFDaSOdjD7t
         8jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQClKqLnds1opGgSJyQ6rzcJmQ10WKwpGChwetbEKcU=;
        b=tCBxCDisaweuXVQu+Yq79+q+zEC5QLo20X6gwqAuvzXE6XiG0dmy4m4SSOW0vx8U03
         hGfrCwAC25xoqtgxbhKw5qcAeshBqKl8UmElrQJvfAq9MmzlviWteKP8Fd+Z478IBVhG
         /OQmaTCJWaVouAmsJ7I1iMEqC07WJsAOj9oSipAqyo5RX3lPeMao0WdrADvab9E2agR4
         DZ55QmPrNc/wiirt0KyROT2Nqks7zn5av4ljSWgmDQvfkQLrla7gLjohcYcZvIbW/NxO
         RaRtVRjKXB81g81XvKIQH/VqqAV7ZPkwiA+u1ZdX9m/xHDXKOKs1t6sa4a/KcnNmqepV
         0Jpw==
X-Gm-Message-State: AO0yUKWBXFF1i7R+2vuSFOAqGgosneHNDqOWGYHxt1bUTWK5qDMXqiVu
        XwofDAUmWqCws/szazm8FK2ih9HFpO0=
X-Google-Smtp-Source: AK7set9HnLFBkxMFEQQv95VKfuIJ6fvPGtHx/M9hdT0MnjSe2iA8tslg1okbyq4seLvVxt7cnXKzlw==
X-Received: by 2002:a17:903:110e:b0:196:8798:57d9 with SMTP id n14-20020a170903110e00b00196879857d9mr260442plh.5.1675714887773;
        Mon, 06 Feb 2023 12:21:27 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902e8c300b0019602274208sm6719975plg.186.2023.02.06.12.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:21:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 6 Feb 2023 10:21:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2] cpuset: Call set_cpus_allowed_ptr() with appropriate
 mask for task
Message-ID: <Y+FhRW59h+h1bTcr@slm.duckdns.org>
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131221719.3176-3-will@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 31, 2023 at 10:17:19PM +0000, Will Deacon wrote:
> set_cpus_allowed_ptr() will fail with -EINVAL if the requested
> affinity mask is not a subset of the task_cpu_possible_mask() for the
> task being updated. Consequently, on a heterogeneous system with cpusets
> spanning the different CPU types, updates to the cgroup hierarchy can
> silently fail to update task affinities when the effective affinity
> mask for the cpuset is expanded.
> 
> For example, consider an arm64 system with 4 CPUs, where CPUs 2-3 are
> the only cores capable of executing 32-bit tasks. Attaching a 32-bit
> task to a cpuset containing CPUs 0-2 will correctly affine the task to
> CPU 2. Extending the cpuset to CPUs 0-3, however, will fail to extend
> the affinity mask of the 32-bit task because update_tasks_cpumask() will
> pass the full 0-3 mask to set_cpus_allowed_ptr().
> 
> Extend update_tasks_cpumask() to take a temporary 'cpumask' paramater
> and use it to mask the 'effective_cpus' mask with the possible mask for
> each task being updated.
> 
> Fixes: 431c69fac05b ("cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()")
> Signed-off-by: Will Deacon <will@kernel.org>

Applied to cgroup/for-6.2-fixes.

Thanks.

-- 
tejun
