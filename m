Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8613A2DAE
	for <lists+cgroups@lfdr.de>; Thu, 10 Jun 2021 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFJOGk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Jun 2021 10:06:40 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:42966 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhFJOGk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Jun 2021 10:06:40 -0400
Received: by mail-qt1-f179.google.com with SMTP id v6so12093566qta.9
        for <cgroups@vger.kernel.org>; Thu, 10 Jun 2021 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uSsccOa0ekLtQf+hjaaxgyVTpWcAkGjfjGCSWyqjUOg=;
        b=p+uFJn94QQUXOOtDh05HomeTNaioo2qs4MgUtE/BgEbOOymvokye9OWZZ6USc/gkix
         C3LmNlDP8EsLhpowFNdRa8lgOcWkWd0+2liquUXTo8FkQIMSeufT+JYW3IdTKbSFhTG4
         qP0cRqnA/g0BAFxkJuCQJaK5lM3JKvckL9qA0xPQJbHM5Qm+W8eb/UzE46XudJarXxAU
         TTsdaYbZpwwRZXJeukfOpFSdHaXQh0M1Ce56IrC3ysLqdUPzSPuK1ntKs6STEyTE1n/L
         0iPAmFIQ3YbicX4g8ZpkyMVgoWR7tNbU1WGZHL1ESGQSIo9ugwp8KfTFHwwawRO6u1zw
         R07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uSsccOa0ekLtQf+hjaaxgyVTpWcAkGjfjGCSWyqjUOg=;
        b=LLtfubWQWdQ3WpxGSj0b2dzK0UF8AtsdD4/4P00etBMUpHfZlG/Jfh1uWmC6+0AK3k
         xozC36MdrS/A13e/2sslPuB+8wEN9dnc6c95mVKV10Foqv7rf+gIq5EhFnBnYp+h/3KV
         tXFaY4iVWQ8EduCCwYdOS6uYvumknUG1DNhoeYcYCXuuEnAIpwBbT+/Mmznhr3AI/MRz
         EZPt4JN5IMD0i1d94IXs2Ow3HTIvpd+Sea6ySKd1oeGxVfZslKnQJYvSal25Zs1kMaaq
         J7pZAZ0XK/AAnov695vp1kjEF3n37zErnEPF488GjGbS+UjZn4XDUZ5pUAYo0X/xrBv8
         gL1g==
X-Gm-Message-State: AOAM530FBDo3Ef1L2EWZRzh/Ivc6ZdYBo8blaW/Z3W94iNjNbtNuoi33
        IVB90X0l9544Abf00vZg8IeDjUVii9He8Q==
X-Google-Smtp-Source: ABdhPJyogGJve5thu4jx3zEeMAQmG+o1jm4Lln/vsNb/p9zn216ZxGl0/0FN7ijgQms9QAvHqQv0cA==
X-Received: by 2002:ac8:684:: with SMTP id f4mr5271352qth.79.1623333807886;
        Thu, 10 Jun 2021 07:03:27 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id f5sm2172147qkm.124.2021.06.10.07.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:03:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 10 Jun 2021 10:03:25 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Alexander Kuznetsov <wwfq@yandex-team.ru>
Cc:     cgroups@vger.kernel.org, zeil@yandex-team.ru,
        dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH] cgroup1: don't allow '\n' in renaming
Message-ID: <YMIbrRdktYmolPXZ@slm.duckdns.org>
References: <1623223039-35764-1-git-send-email-wwfq@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623223039-35764-1-git-send-email-wwfq@yandex-team.ru>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 09, 2021 at 10:17:19AM +0300, Alexander Kuznetsov wrote:
> cgroup_mkdir() have restriction on newline usage in names:
> $ mkdir $'/sys/fs/cgroup/cpu/test\ntest2'
> mkdir: cannot create directory
> '/sys/fs/cgroup/cpu/test\ntest2': Invalid argument
> 
> But in cgroup1_rename() such check is missed.
> This allows us to make /proc/<pid>/cgroup unparsable:
> $ mkdir /sys/fs/cgroup/cpu/test
> $ mv /sys/fs/cgroup/cpu/test $'/sys/fs/cgroup/cpu/test\ntest2'
> $ echo $$ > $'/sys/fs/cgroup/cpu/test\ntest2'
> $ cat /proc/self/cgroup
> 11:pids:/
> 10:freezer:/
> 9:hugetlb:/
> 8:cpuset:/
> 7:blkio:/user.slice
> 6:memory:/user.slice
> 5:net_cls,net_prio:/
> 4:perf_event:/
> 3:devices:/user.slice
> 2:cpu,cpuacct:/test
> test2
> 1:name=systemd:/
> 0::/
> 
> Signed-off-by: Alexander Kuznetsov <wwfq@yandex-team.ru>
> Reported-by: Andrey Krasichkov <buglloc@yandex-team.ru>
> Acked-by: Dmitry Yakunin <zeil@yandex-team.ru>

Applied to cgroup/for-5.13-fixes

Thanks.

-- 
tejun
