Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0912D2E706
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2019 23:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfE2VF7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 May 2019 17:05:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45234 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfE2VF7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 May 2019 17:05:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id w34so588280pga.12
        for <cgroups@vger.kernel.org>; Wed, 29 May 2019 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IK6TE1g/zjrlYdKpXduba6GIWdiYkCXHBc8wY5Q2h6c=;
        b=vtINRHGv9pOMzEibPlyS5UheCDyPErD1isWONiJgdUP9nFIKtlhvlR8khJ6OGtj8Ub
         2wdHJ81EyLkh+O2THYqHMuUQbZJF51XI2o7C4rXJKaweU9flDgqo6sZDLCB0F0IFFr3o
         XqnUqkKAZMp1Fis0qGAWaWgx5BHhAoA8b1/epmScbDLNT3udqtjsXbQv7IDkMa30s/4G
         TamPt5Ni00hfDsvhp5BYEE1NK/vbSsMEkiDZqBc9TmZUl3WysTgYsyGgX0XmeD1uB6W5
         Er8tVXbeNNpFaTnDtxluP9+RPFR/EDG7A/hRp71FY8UUlceZIoQggoxcp7CX9wYlac9A
         /HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=IK6TE1g/zjrlYdKpXduba6GIWdiYkCXHBc8wY5Q2h6c=;
        b=a/4G6K14BpbSaiqMSE5n3g+/wC9lSPXcdv7CWQVNeg9tuWZTYWEo39LjzLd1aPwYRU
         ynKsafsnJTJ33XAf+Hhdwihuh8D5KB+ZeD1e1UjyZv/UPOYLGEK8CNNYhL2m9t88ROe+
         6nWKMfoJBk2n/xdiDsEiNU43G3gbQ3hM4uMoSxzhulRbGrPimyvq7cHbsbk0kdnhoXV7
         /sdws0dL4noMQW3vdEsXaSGDjIFKUO6iky1mj8A6asFb2avPvm5ZH6nL6r0E9kaffaee
         T98VVTXo7YkmnD1gK8ggRomMnv/81h1f1X5UcKtN0hSfOZln5FbP7zfBOeZwiGurlMi/
         J3BQ==
X-Gm-Message-State: APjAAAVMBozRH3Yc7wHMRlJU7W/iF59zNQ/1hzL70DFPcM6dyOOwreeR
        czAGV35qfgd7nnyG1uAz1kTTMw==
X-Google-Smtp-Source: APXvYqziz3dX83BfWwOt4Dg3dahd01BeeDJYhvSZSrbtcPTk/gYYJdIsVLXiqebnxwhOWddLSw5chQ==
X-Received: by 2002:a63:1460:: with SMTP id 32mr141850372pgu.319.1559163958462;
        Wed, 29 May 2019 14:05:58 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id z9sm254119pgc.82.2019.05.29.14.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 14:05:57 -0700 (PDT)
From:   bsegall@google.com
To:     Dave Chiluk <chiluk+linux@indeed.com>
Cc:     Phil Auld <pauld@redhat.com>, Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        pjt@google.com
Subject: Re: [PATCH v3 1/1] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
        <1559156926-31336-1-git-send-email-chiluk+linux@indeed.com>
        <1559156926-31336-2-git-send-email-chiluk+linux@indeed.com>
Date:   Wed, 29 May 2019 14:05:55 -0700
In-Reply-To: <1559156926-31336-2-git-send-email-chiluk+linux@indeed.com> (Dave
        Chiluk's message of "Wed, 29 May 2019 14:08:46 -0500")
Message-ID: <xm264l5dynrg.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dave Chiluk <chiluk+linux@indeed.com> writes:

> It has been observed, that highly-threaded, non-cpu-bound applications
> running under cpu.cfs_quota_us constraints can hit a high percentage of
> periods throttled while simultaneously not consuming the allocated
> amount of quota.  This use case is typical of user-interactive non-cpu
> bound applications, such as those running in kubernetes or mesos when
> run on multiple cpu cores.
>
> This has been root caused to threads being allocated per cpu bandwidth
> slices, and then not fully using that slice within the period. At which
> point the slice and quota expires.  This expiration of unused slice
> results in applications not being able to utilize the quota for which
> they are allocated.
>
> The expiration of per-cpu slices was recently fixed by
> 'commit 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift
> condition")'.  Prior to that it appears that this has been broken since
> at least 'commit 51f2176d74ac ("sched/fair: Fix unlocked reads of some
> cfs_b->quota/period")' which was introduced in v3.16-rc1 in 2014.  That
> added the following conditional which resulted in slices never being
> expired.


Yeah, having run the test, stranding only 1 ms per cpu rather than 5
doesn't help if you only have 10 ms of quota and even 10 threads/cpus.
The slack timer isn't important in this test, though I think it probably
should be changed.

Decreasing min_cfs_rq_runtime helps, but would mean that we have to pull
quota more often / always. The worst case here I think is where you
run/sleep for ~1ns, so you wind up taking the lock twice every
min_cfs_rq_runtime: once for assign and once to return all but min,
which you then use up doing short run/sleep. I suppose that determines
how much we care about this overhead at all.

Removing expiration means that in the worst case period and quota can be
effectively twice what the user specified, but only on very particular
workloads.

I think we should at least think about instead lowering
min_cfs_rq_runtime to some smaller value.
