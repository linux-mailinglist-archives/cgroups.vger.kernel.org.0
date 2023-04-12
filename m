Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EFF6DFCBF
	for <lists+cgroups@lfdr.de>; Wed, 12 Apr 2023 19:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDLRbY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Apr 2023 13:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDLRbX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Apr 2023 13:31:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0658F40C5
        for <cgroups@vger.kernel.org>; Wed, 12 Apr 2023 10:31:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so11232800pji.1
        for <cgroups@vger.kernel.org>; Wed, 12 Apr 2023 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681320681; x=1683912681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVE3G2vtoNe3tigwWwJhpxVf0V7qF7ZUFUl9foF/vUg=;
        b=U08PSEwkK+i+EG82Qzu3ybPuJ6WSf1SmNz8kb81QHhHmXbi/seRIaE6A2nHNN9s3H9
         GiVOJCz/B2TLEtghEPIjuk2DGe4OZDEE088ZWuDOYtHca776MnKKCEr8NmbeBnIorhXT
         Z5i4Wwus+Kuri7B66levj6GTyRQCL06SMbi2vJva4WO0/zlp6bYRKSknCuu722aUpUB5
         dRg4hJiNI1v9u6eFocJvBsZH2HpKHxOvlQy3JxGHrvpT919rSvAO1MedCyQj14kcRh7k
         g0BIybZWbqcEKlZ4XgxiBx66Rl0Ujg7XLStvI4+S8Af38DkkP9bFixy5cconkBIIit2N
         AA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681320681; x=1683912681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVE3G2vtoNe3tigwWwJhpxVf0V7qF7ZUFUl9foF/vUg=;
        b=Z3oloTUegeDpnuqkESCRrLlInuMyCDNgOs8MU0v6Utow1DP/FS6Y9s1q2HPYgpF2zd
         h0T2eIpiLUbDRQ5qgUc0ycK4wg6oEjFDR/xAK2dgSTQFI1Bh3RyXVNLjxTgvH/0MJx4u
         Ft+PW6w1JfJWGQtvzcienDD29K7xlaSt8FMTimCqs6Zi3a6zZ8WKzrf3h02/GynTv+ML
         uQZW1wSPPQYdQ6/K4O1nthnubViHEJclWybPdnivEo4UQMCx2nXvQeVwamhEWXCOSs7R
         Tzti+LO5MmRZ0dwqewm5KDyHiMDLQDfGuebfGSJNgt5dMIoGkBUT92vEtUUrwlsHWqRU
         8f1A==
X-Gm-Message-State: AAQBX9dtBwUIxuT9hHA9d6GyEzzPGqaXbNNxUYMdErw+o27Q8S2PPGMZ
        zjMjmUpycuo3Du9wLnHCaIo=
X-Google-Smtp-Source: AKy350bvB+zNMkRx5ZmpiIKqULpWmpkr8AqIHkmFN35YfaA4Sg8FcAVoksKf447KLTk/zMRWk0Is8A==
X-Received: by 2002:a05:6a20:c530:b0:dd:ac3a:b798 with SMTP id gm48-20020a056a20c53000b000ddac3ab798mr7163588pzb.13.1681320681247;
        Wed, 12 Apr 2023 10:31:21 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x24-20020aa793b8000000b00634a96493f7sm7574925pff.128.2023.04.12.10.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:31:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Apr 2023 07:31:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>,
        syzbot <syzbot+c39682e86c9d84152f93@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] cgroup,freezer: hold cpu_hotplug_lock before
 freezer_mutex
Message-ID: <ZDbq563-czAiFFQb@slm.duckdns.org>
References: <00000000000009483d05ec7a6b93@google.com>
 <695b8d1c-6b7a-91b1-6941-c459cab038b0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <695b8d1c-6b7a-91b1-6941-c459cab038b0@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 05, 2023 at 10:15:32PM +0900, Tetsuo Handa wrote:
> syzbot is reporting circular locking dependency between cpu_hotplug_lock
> and freezer_mutex, for commit f5d39b020809 ("freezer,sched: Rewrite core
> freezer logic") replaced atomic_inc() in freezer_apply_state() with
> static_branch_inc() which holds cpu_hotplug_lock.
> 
> cpu_hotplug_lock => cgroup_threadgroup_rwsem => freezer_mutex
> 
>   cgroup_file_write() {
>     cgroup_procs_write() {
>       __cgroup_procs_write() {
>         cgroup_procs_write_start() {
>           cgroup_attach_lock() {
>             cpus_read_lock() {
>               percpu_down_read(&cpu_hotplug_lock);
>             }
>             percpu_down_write(&cgroup_threadgroup_rwsem);
>           }
>         }
>         cgroup_attach_task() {
>           cgroup_migrate() {
>             cgroup_migrate_execute() {
>               freezer_attach() {
>                 mutex_lock(&freezer_mutex);
>                 (...snipped...)
>               }
>             }
>           }
>         }
>         (...snipped...)
>       }
>     }
>   }
> 
> freezer_mutex => cpu_hotplug_lock
> 
>   cgroup_file_write() {
>     freezer_write() {
>       freezer_change_state() {
>         mutex_lock(&freezer_mutex);
>         freezer_apply_state() {
>           static_branch_inc(&freezer_active) {
>             static_key_slow_inc() {
>               cpus_read_lock();
>               static_key_slow_inc_cpuslocked();
>               cpus_read_unlock();
>             }
>           }
>         }
>         mutex_unlock(&freezer_mutex);
>       }
>     }
>   }
> 
> Swap locking order by moving cpus_read_lock() in freezer_apply_state()
> to before mutex_lock(&freezer_mutex) in freezer_change_state().
> 
> Reported-by: syzbot <syzbot+c39682e86c9d84152f93@syzkaller.appspotmail.com>
> Link: https://syzkaller.appspot.com/bug?extid=c39682e86c9d84152f93
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to cgroup/for-6.3-fixes.

Thanks.

-- 
tejun
