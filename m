Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31F42DC2D9
	for <lists+cgroups@lfdr.de>; Wed, 16 Dec 2020 16:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgLPPMx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Dec 2020 10:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgLPPMw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Dec 2020 10:12:52 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEE6C061794;
        Wed, 16 Dec 2020 07:12:12 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id i67so15233319qkf.11;
        Wed, 16 Dec 2020 07:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e8UBHhFg+dlyjUuWALZhGhLIm76hEru3ETvVso2v0Xo=;
        b=pUc3eRmZd45iQpeNK/64AmkrzUhbIBAM7pKzZyYLjQeKyB92dntNljnfvCDG7UOutC
         m/WplD/grRAc7RqIf6063SJhpGRrhLVYsa9EmZMmHYKsibbOpNo+pejGfsc60bR5sK3u
         JIiiMJnAt/e0LnjeULzz4tUefO9MJl5Uu91PouXkDceaxnRZvddl2dX1yMBiPDJWMG5B
         PDW6Zg21tN16gCA2MkTzQgcFZKUV4Tx+84qwNpxl1l8c52lXa52B3/snRWQwGIpQaZPy
         2uyKK9OID73/SM8cyaK+p6T52VS1GXnZf8lAoAUK+vqxq9+awrc6NDtSziLwoUTrHPwg
         Swlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=e8UBHhFg+dlyjUuWALZhGhLIm76hEru3ETvVso2v0Xo=;
        b=UxDzIxJiQzmXCj9AuA8mQMhm6tV4OJTCC/U33kT05S26XQZBk75g05XrPxqAFjWBCT
         TV50CVvPteFl1CtVHbuBjyKPi86i30ePKBHV61QXeTeplRyVW5tR2YJ4Kz0HjxjMAEPM
         1xLihIcbhPgmCVlX8c83kaEMxnP6fjx63UL7XW0TkMyPKrrPvLd0IQGQmfYXdqMRYFGf
         NuR5700XBYDFuXMFZEEaN3zujXzqcb3gHtqieIdLs+I2gJTHcHYwHVOYKSx4RDyMMqhL
         7UiZKhWEbKnP8np+b5rkqu81xRxZJsypdSsTRsSu+8XtIopWFSRogF5RR2xig/7q99An
         TLIA==
X-Gm-Message-State: AOAM532K8mehH6mWtmugF8sHqI6NcO4Bw3T1hHDnLONpWC4Zg0CqEpLI
        dORXySV00+8vSBQLfxD+/TA=
X-Google-Smtp-Source: ABdhPJx2/ZfJDb661nknanAm+DlY7sFbTIbgs412PIO0Y3vFbW3msA4JbTx1zcL0vP4tXf8Lha4ubg==
X-Received: by 2002:a37:a8a:: with SMTP id 132mr44425530qkk.327.1608131531351;
        Wed, 16 Dec 2020 07:12:11 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:cbde])
        by smtp.gmail.com with ESMTPSA id u4sm1069961qtv.49.2020.12.16.07.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 07:12:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Dec 2020 10:11:36 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: Fix memory leak when parsing multiple source
 parameters
Message-ID: <X9ojqIbV/SxSrNy7@mtj.duckdns.org>
References: <20201209121322.77665-1-miaoqinglang@huawei.com>
 <20201210012943.92845-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210012943.92845-1-miaoqinglang@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 10, 2020 at 09:29:43AM +0800, Qinglang Miao wrote:
> A memory leak is found in cgroup1_parse_param() when multiple source
> parameters overwrite fc->source in the fs_context struct without free.
> 
> unreferenced object 0xffff888100d930e0 (size 16):
>   comm "mount", pid 520, jiffies 4303326831 (age 152.783s)
>   hex dump (first 16 bytes):
>     74 65 73 74 6c 65 61 6b 00 00 00 00 00 00 00 00  testleak........
>   backtrace:
>     [<000000003e5023ec>] kmemdup_nul+0x2d/0xa0
>     [<00000000377dbdaa>] vfs_parse_fs_string+0xc0/0x150
>     [<00000000cb2b4882>] generic_parse_monolithic+0x15a/0x1d0
>     [<000000000f750198>] path_mount+0xee1/0x1820
>     [<0000000004756de2>] do_mount+0xea/0x100
>     [<0000000094cafb0a>] __x64_sys_mount+0x14b/0x1f0
> 
> Fix this bug by permitting a single source parameter and rejecting with
> an error all subsequent ones.
> 
> Fixes: 8d2451f4994f ("cgroup1: switch to option-by-option parsing")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Applied to cgroup/for-5.11.

Thanks.

-- 
tejun
