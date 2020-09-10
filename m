Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C23264810
	for <lists+cgroups@lfdr.de>; Thu, 10 Sep 2020 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgIJOgS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Sep 2020 10:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbgIJOct (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Sep 2020 10:32:49 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B760C06179A;
        Thu, 10 Sep 2020 07:32:48 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ef16so3416241qvb.8;
        Thu, 10 Sep 2020 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mY+K4wwI3uVC3MNpAenDFKOHI/Yx4eP9ajKsUNDpIAY=;
        b=iEmg7HsfmLxZys3AFomnebmzkqL4Q6IslUgZ24TBHj2QY7DH16fGDE7K2Uob+iyLFz
         NQLRdKxSgflbs3gpI9Kg5W9pRn5mrmHf2sy6LqIVFN5lnQfaI1U0lJ4qd248lSzlR6w6
         YM49BPXRRXN67RsKd5djmGZLjmcCwsPxk+lvOII/xkRZTpnpg5P7M7bWSs5TvOxqlFmV
         9fr0wNWrU2hBI0w0ghHfYDzuyiJxhBVUaIXkCj9F7xZ93d6nZNUHYmxzVUdqGB/JYQql
         R1GaE5G0qk09dwHzjROwTQbAaxhOK8RRO+ityTp39eDqfOdBdwaGZEt1QJDkq1CRTIuI
         on8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mY+K4wwI3uVC3MNpAenDFKOHI/Yx4eP9ajKsUNDpIAY=;
        b=bH584KRdFUPZH4JK6okI0WqQIllUz+JvNocJ9/MfMARIuwdeEs3c+DHsNDKhhiuZip
         Dcj3wCo/mg/BW0AvL3SVZz9oApYJYEaicdvxVC5GCzGXwV157TS7hsatiNSkoLa/YIQw
         I75akgrcs3heLlEEY/6Nv6uWwTcWu5WTUrZeft0fI/GIp8/i3k/l5If6UwdV5oW0CwRx
         t3lAsJfA2PNek7RRct/D1/KyYMi5eQykFOUysIB7fQdWsmfWTBhbusN6ZT+qUAfgAl2b
         S5CMUVziljfm45dQCTwtSNG6pXgmzB/Pjo215pQsGFQGR/pUjmQ4y9U5+imerVU0Bjzm
         Vsrg==
X-Gm-Message-State: AOAM531aNihw8wB8ibREdOIqNaGKfzaSGjTrQ2ds02KJvp3PTGi9gi0k
        SKYbxBPQB6vxmQ+IwsW2UhY=
X-Google-Smtp-Source: ABdhPJw3phbZ5WD4zOxA831D7z7xZoFIqONT2JZcX+PLvmPDJ91k4HIC4oPNrNP+fXqZGihX4XaoJw==
X-Received: by 2002:a0c:80c3:: with SMTP id 61mr8886894qvb.13.1599748366819;
        Thu, 10 Sep 2020 07:32:46 -0700 (PDT)
Received: from localhost (dhcp-48-d6-d5-c6-42-27.cpe.echoes.net. [199.96.181.106])
        by smtp.gmail.com with ESMTPSA id x6sm6850720qke.54.2020.09.10.07.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 07:32:46 -0700 (PDT)
Date:   Thu, 10 Sep 2020 10:32:44 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com
Subject: Re: [PATCH] taskstats: fix CGROUPSTATS_CMD_GET for cgroup v2
Message-ID: <20200910143244.GF4295@mtj.thefacebook.com>
References: <20200910055207.87702-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910055207.87702-1-zhouchengming@bytedance.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 10, 2020 at 01:52:07PM +0800, Chengming Zhou wrote:
> We found cgroupstats_build would return -EINVAL when using netlink
> CGROUPSTATS_CMD_GET interface to get stats on cgroup v2. Fix it by
> supporting cgroup v2 kernfs directory in cgroupstats_build, and export
> cgroup2_fs_type like we did for cgroup_fs_type.
> 
> Reported-by: Daowen Luo <luodaowen.backend@bytedance.com>
> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

The exclusion of cgroupstats from v2 interface was intentional due to the
duplication and inconsistencies with other statistics. If you need these
numbers, please justify and add them to the appropriate cgroupfs stat file.

Thanks.

-- 
tejun
