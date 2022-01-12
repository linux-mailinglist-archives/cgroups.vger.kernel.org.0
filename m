Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A25648C62D
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354185AbiALOkE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 09:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354165AbiALOkA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 09:40:00 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F02C061751
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 06:40:00 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c19so3210084qtx.3
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 06:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=azTS6tnDk3tgwE9tswmIFeSjakmtEkN/3qV9mBsYccQ=;
        b=lTRxPpgHABlbCins2TOnLV9LVjCQ26SweG5q5/C2dMrN7f4+7+CdEQaKc4xcdS/zs3
         DnnJODvxalPzEBmfycggfJ4lZoZUdSfkcT1FFajWBuoDH4tbJJLL2YuL6VbiKPY23zjT
         s9abyL/GVEQlgdsFh47XnaBAIlnd4r3ZyvPyN5/9fVlr23f1ZQ+zFnmJ2EknoM6EVijq
         DtrWB4hpPieJhguRemvh6pArWmjvKs5iO38IbvNSIbHAERKk9TjFr3Jxk2ED+QMTUtWB
         yC+ONdLHxP7q+hbMjaRXE0DQCgYR737mTcvby6eksJwvQM1crqiY6MklMC7KIIBeXrYS
         SJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=azTS6tnDk3tgwE9tswmIFeSjakmtEkN/3qV9mBsYccQ=;
        b=B8Lrg2QbZG0zpFvcmqFP6q3ZtcI58a3kSPfrZIY3lo52NluZWjuFiVj4RbMPb/TuDG
         M0NyKZUdkl/jlAjgRxS1gIxdKkqAxgQFKurHllU8Jf9aB27jCwIaahxmOyir7uN51Ewi
         g7O0ojG8WcCj/LAbDc4HhRRD+FCkZwNKGTf+whaw+F6AB4Z57015XKXo3wqJQx/ri5WB
         jSkQLlGk9goJikcsQSB2rrWkZE0rEULxllfnGV0wxdEdQ8BMjeKmXMvyKiCcsYcsChQx
         OcJYu1SGqPyqDooNZL61emqhItuH3wjIR9ws+lXJ+IRiZwH25fBrIP+i6ycSPtHeQBgz
         0C7g==
X-Gm-Message-State: AOAM531ZhveMeVeo9tTzS9NcHy3jsVplJRWHxU5WyHx81cqsL5Z5p22T
        i+T8C5I5Q1+Oz5GD9V4gpm1P5Q==
X-Google-Smtp-Source: ABdhPJzrrSK3m7ltAbl1maAKx6vtdpBbyflm+yV6TugFLnybhDj8DR7ye+TY80jvOr5AzdzXhoJBmg==
X-Received: by 2002:ac8:5a4a:: with SMTP id o10mr7834867qta.617.1641998399438;
        Wed, 12 Jan 2022 06:39:59 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id 2sm129843qtx.66.2022.01.12.06.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 06:39:59 -0800 (PST)
Date:   Wed, 12 Jan 2022 09:39:58 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     torvalds@linux-foundation.org, ebiggers@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@android.com,
        syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
Message-ID: <Yd7oPlxCpnzNmFzc@cmpxchg.org>
References: <20220111232309.1786347-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111232309.1786347-1-surenb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 03:23:09PM -0800, Suren Baghdasaryan wrote:
> With write operation on psi files replacing old trigger with a new one,
> the lifetime of its waitqueue is totally arbitrary. Overwriting an
> existing trigger causes its waitqueue to be freed and pending poll()
> will stumble on trigger->event_wait which was destroyed.
> Fix this by disallowing to redefine an existing psi trigger. If a write
> operation is used on a file descriptor with an already existing psi
> trigger, the operation will fail with EBUSY error.
> Also bypass a check for psi_disabled in the psi_trigger_destroy as the
> flag can be flipped after the trigger is created, leading to a memory
> leak.
> 
> Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com
> Analyzed-by: Eric Biggers <ebiggers@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
