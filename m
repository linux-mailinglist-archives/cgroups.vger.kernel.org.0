Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A1D36299A
	for <lists+cgroups@lfdr.de>; Fri, 16 Apr 2021 22:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbhDPUqK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Apr 2021 16:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbhDPUqJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Apr 2021 16:46:09 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B863C061574;
        Fri, 16 Apr 2021 13:45:41 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c123so25412402qke.1;
        Fri, 16 Apr 2021 13:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AWk2YlZvUGRhuI33/yUiX9atOwnUzYG38aU0FDL42xY=;
        b=FgYVOoIdZ4sQvOUT1JHrYKUFU+jlAZrX78C0g+MopM30ar0Syn+iLvzEO4VIqddWS1
         UysK6NZeNoZrgjYV+94LqtBg6zzL4j3YA3ymub+zYiZ7HeXW3eMcsbQNgLEtZbgEAGEd
         NwCAVBm68ZCQW0pd7nhRSmXyzRUx0qFOpF8n1ks4cGty5hzQZtu4xGt9G3IVGDqP9VrG
         VTBRVjqLw/87EP9NdCFf6ROhq+1yNH/Xh6Ix7K4uGy2tqn4qFLaaZo1GG5OF2CTo7hEd
         SIXouwLYFVsVloQAJHhTNhAQXYBEWaadxBljbSdFOBdn/wblVABFvDN+h05QUmQdmsf9
         Oj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AWk2YlZvUGRhuI33/yUiX9atOwnUzYG38aU0FDL42xY=;
        b=THu5hV+PI2o7Y+BiWjZPatXRyslvtLoaYB24V5YY2mlixyqjL2PsKJMztaxi1oSnns
         XbmuraSgHeMqlhJ/H/aNGodKjZSTiVpXfayQurD8Yy8oLTj6xeYQlj6gfDYgpY6ZFBuf
         u5JZuTh7kp84tkQo0OJG7KnUNPaIziaL7Bh40Xp+/yrsgkTzFgqV7qyyjhJ7Q1HiHocC
         oawXWpMVpexEy9Mfx1WdaUK3Ktfa6IPvBUk6yD/Ou7bncJZ8wt/v44L5GUh42BFEbwVF
         dCKjRLnx55r0c7fztS8SM2baVmDUG+G6h9CSAXIrCTP7buOWAbGy82L2/AX5UTsj1S77
         cZyw==
X-Gm-Message-State: AOAM533NVAQHbQoQdjSd8MmRxypL/OFK+QjBwAe1/9ufrM3oAi6xXZOc
        U5UhlZnYUX41M2hXV2EBzxc=
X-Google-Smtp-Source: ABdhPJyX8/BQOqDnQxqWydHtq9WFubnpAjgvt6v3UvuDsQ4ggOX+pCilpGTIHgM2bhHS+JSGkl88gg==
X-Received: by 2002:a05:620a:15c:: with SMTP id e28mr1105610qkn.311.1618605940283;
        Fri, 16 Apr 2021 13:45:40 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id p21sm2843517qkp.95.2021.04.16.13.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:45:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 16 Apr 2021 16:45:38 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Odin Ugedal <odin@uged.al>
Cc:     corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [RFC] docs/admin-guide/cgroup-v2: Add hugetlb rsvd files
Message-ID: <YHn3cifQv1FUOqfU@slm.duckdns.org>
References: <20210416141146.542786-1-odin@uged.al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416141146.542786-1-odin@uged.al>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(cc'ing memcg maintainers)

On Fri, Apr 16, 2021 at 04:11:46PM +0200, Odin Ugedal wrote:
> Add missing docs about reservation accounting for hugetlb in cgroup v2.
> 
> Signed-off-by: Odin Ugedal <odin@uged.al>
> ---
> RFC: This is linking from cgroup-v1 docs, and that is probably not
> optimal. The information about the difference between reservation
> accounting and page fault accounting is pretty hard to make short.
> 
> I think we have four ways to do it, but I don't know what is
> most optimal:
> 
> - Link from cgroup-v2 to cgroup-v1 (this patch)
> - Have a separate description for both v1 and v2
> - Move description from cgroup-v1 to cgroup-v2, and link from v1 to
>   v2.

This would be my preference but I don't really mind the other way around
that much.

> - Move info from cgroup-v1 to admin-guide/mm/hugetlbpage or
>   vm/hugetlbfs_reserv, and link from cgroup to them.

What do others think?

Thanks.

-- 
tejun
