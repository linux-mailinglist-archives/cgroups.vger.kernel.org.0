Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011981F650A
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2020 11:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFKJzp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jun 2020 05:55:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33737 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgFKJzT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jun 2020 05:55:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id j198so6574348wmj.0;
        Thu, 11 Jun 2020 02:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OGc4Jynhv8J9+LXwEVD2pmhTRYA7A0SBRA8Y9bWfwBM=;
        b=ZP3WT+PqgLjTcOB43l6GxF4o9GVmkvGG8l8sH87x0bHL7XqW1KaHyZDmXKTjJKOzkt
         RMgvMWpExF98C4c5Y8zco5vLKDG7hWRa43rDJfaSezsHoqaU+WlrqodiEafdyOR6DLBQ
         sVAhvx5jJLoHj705kpT+10r+i2FjIpJr8PQg+MUeEUNoTiXzrXv0eurO1JGi1H1SIPOZ
         S/KzhrJBCblA+SH0Gx9hzDttKjs8TI+oOrIpJt1f1hPWRjpYSRFdWMjxC2GYJ1vt1jOJ
         t2JOGG6A6SmkoGwePy6IL/YHQJu+TjWJQs041ML6lujAcOHokviij9GvmZXEDyLTidDh
         gLrA==
X-Gm-Message-State: AOAM530ngMhb6vfGTQmJl/t9EPNN5CQTYVgAf7hkzc9JAKRH3GtCAfhI
        VHBihFejIgcUSJAK6Xm9qRg=
X-Google-Smtp-Source: ABdhPJxdFlFuIOqczVMYLEkBB/5DcRTZD3uW4Gi3wzWe6yykRWLuYTOprRKGwBQhCme4nouL4V90Cw==
X-Received: by 2002:a7b:c18a:: with SMTP id y10mr7719246wmi.73.1591869316876;
        Thu, 11 Jun 2020 02:55:16 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
        by smtp.gmail.com with ESMTPSA id 67sm4301281wrk.49.2020.06.11.02.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 02:55:15 -0700 (PDT)
Date:   Thu, 11 Jun 2020 11:55:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200611095514.GD20450@dhcp22.suse.cz>
References: <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com>
 <CA+G9fYs2jg-j_5fdb0OW0G-JzDjN7b8d9qnX7uuk9p4c7mVSig@mail.gmail.com>
 <20200528150310.GG27484@dhcp22.suse.cz>
 <CA+G9fYvDXiZ9E9EfU6h0gsJ+xaXY77mRu9Jg+J7C=X4gJ3qvLg@mail.gmail.com>
 <20200528164121.GA839178@chrisdown.name>
 <CALOAHbAHGOsAUUM7qn=9L1u8kAf6Gztqt=SyHSmZ9XuYZWcKmg@mail.gmail.com>
 <20200529015644.GA84588@chrisdown.name>
 <20200529094910.GH4406@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529094910.GH4406@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 29-05-20 11:49:20, Michal Hocko wrote:
> On Fri 29-05-20 02:56:44, Chris Down wrote:
> > Yafang Shao writes:
> > > Look at this patch[1] carefully you will find that it introduces the
> > > same issue that I tried to fix in another patch [2]. Even more sad is
> > > these two patches are in the same patchset. Although this issue isn't
> > > related with the issue found by Naresh, we have to ask ourselves why
> > > we always make the same mistake ?
> > > One possible answer is that we always forget the lifecyle of
> > > memory.emin before we read it. memory.emin doesn't have the same
> > > lifecycle with the memcg, while it really has the same lifecyle with
> > > the reclaimer. IOW, once a reclaimer begins the protetion value should
> > > be set to 0, and after we traversal the memcg tree we calculate a
> > > protection value for this reclaimer, finnaly it disapears after the
> > > reclaimer stops. That is why I highly suggest to add an new protection
> > > member in scan_control before.
> > 
> > I agree with you that the e{min,low} lifecycle is confusing for everyone --
> > the only thing I've not seen confirmation of is any confirmed correlation
> > with the i386 oom killer issue. If you've validated that, I'd like to see
> > the data :-)
> 
> Agreed. Even if e{low,min} might still have some rough edges I am
> completely puzzled how we could end up oom if none of the protection
> path triggers which the additional debugging should confirm. Maybe my
> debugging patch is incomplete or used incorrectly (maybe it would be
> esier to use printk rather than trace_printk?).

It would be really great if we could move forward. While the fix (which
has been dropped from mmotm) is not super urgent I would really like to
understand how it could hit the observed behavior. Can we double check
that the debugging patch really doesn't trigger (e.g.
s@trace_printk@printk in the first step)? I have checked it again but
do not see any potential code path which would be affected by the patch
yet not trigger any output. But another pair of eyes would be really
great.
-- 
Michal Hocko
SUSE Labs
