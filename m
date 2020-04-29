Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC371BD23E
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2020 04:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgD2C1p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Apr 2020 22:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgD2C1o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Apr 2020 22:27:44 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3359EC03C1AC
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2020 19:27:44 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w29so696489qtv.3
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2020 19:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j2BqRPlqFlKV+qbCocfSi2x/JssbK9MFgCKLqYpp14M=;
        b=yIS7iHAsJKIugA/8A/w12xYgJlTB3URYy1+zVBuG/07z9SfuYhVCBj5PiJkT0Sl+ji
         cXf8c1c1kahDA3yAOtTmKXArjKHd14VfmKaMdkMTPmYUTGT9rsh59FKalKFxHpPk83j/
         6h5k65Ipm/JdoKcB0TayOyf566CF1TYMAnhztvxsSe+BwiBqA3qd2wd4dPDUqUbXZhpF
         uHbegIniPpIGde6atAbSiqkWT/YfgXbyfmFXEoZf/A4Dbl49g/JVdbycBygXIQdXrWsS
         7yHAyDqE2Kg2ihWZShc7QF2VtZtp/xOzHOrit4A75A9vYuKtIEkgUrnHDttEgHdPRgAE
         B1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j2BqRPlqFlKV+qbCocfSi2x/JssbK9MFgCKLqYpp14M=;
        b=bd6Tbrb4L0n6RlAp4IWrbX5PMF3BKRb0DnhrNnaZTtal9rXnx6DoRP42lDNdqvzt12
         YcXzrCc1SLIVVoZSMVjB6nJM9RowHm2miDJXrcr5HhFI7qlRoIx+qLn6vB5JNaOEVqDh
         E6yoBj21lTMKmx4f0DLYiK+5na/eK20B/ITyvH269gwrtFnk4ajd10oTR6BiF+7lySuu
         eVQHmtrcwPDm9otvGolfc2lq0fQPD/LpOQKGK1Ehg2R/SH7Bie56wj4dxF/Jqm0JqlTR
         iyl8/j+lqyUqq8eVl2slzTb+oyEFJeHzZYiyMWGatNDvxnsV80HBiRbo66TrIIQZIDF3
         tnGA==
X-Gm-Message-State: AGi0PuYX/Ce83fq57dgVw2A3q3nPWa3d+dBDQkptgu3O/V1YtLa5bkb1
        HV3hjc8QmMQ0JMoOe0pGyM6G+Q==
X-Google-Smtp-Source: APiQypLsEKenWN4WzB6ddMhGOd0xHUK1mWQIdZD+RG622mVERdaN6cZAXO8dAWWRsrXwQyIKvlFoGA==
X-Received: by 2002:ac8:4ccc:: with SMTP id l12mr31941572qtv.129.1588127263372;
        Tue, 28 Apr 2020 19:27:43 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id s190sm5345219qkh.23.2020.04.28.19.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 19:27:42 -0700 (PDT)
Date:   Tue, 28 Apr 2020 22:27:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v5 0/4] Charge loop device i/o to issuing cgroup
Message-ID: <20200429022732.GA401038@cmpxchg.org>
References: <20200428161355.6377-1-schatzberg.dan@gmail.com>
 <20200428214653.GD2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428214653.GD2005@dread.disaster.area>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 29, 2020 at 07:47:34AM +1000, Dave Chinner wrote:
> On Tue, Apr 28, 2020 at 12:13:46PM -0400, Dan Schatzberg wrote:
> > This patch series does some
> > minor modification to the loop driver so that each cgroup can make
> > forward progress independently to avoid this inversion.
> > 
> > With this patch series applied, the above script triggers OOM kills
> > when writing through the loop device as expected.
> 
> NACK!
> 
> The IO that is disallowed should fail with ENOMEM or some similar
> error, not trigger an OOM kill that shoots some innocent bystander
> in the head. That's worse than using BUG() to report errors...

Did you actually read the script?

It's OOMing because it's creating 256M worth of tmpfs pages inside a
64M cgroup. It's not killing an innocent bystander, it's killing in
the cgroup that is allocating all that memory - after Dan makes sure
that memory is accounted to its rightful owner.

As opposed to before this series, where all this memory isn't
accounted properly and goes to the root cgroup - where, ironically, it
could cause OOM and kill an actually innocent bystander.
