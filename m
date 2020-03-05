Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3B717A720
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 15:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgCEOHt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 09:07:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33193 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCEOHt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 09:07:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id x7so7203136wrr.0;
        Thu, 05 Mar 2020 06:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ysjXrA7ar4xgt18wwLdEoZdnHgbhcxFKpVHqbdgcXzQ=;
        b=uccIOhmMuGQWPvkrWyn/RQZG9E+bc9mXxBgpsSB4YGc8Qm0+He40is5ViHZOyEuQ4a
         UBKK2UMgV9C466UbKQxkYaXTp8ntCcZTF3DO/fzGh0/X1ktC1GpXJfBWe09pMHh3fegA
         5y5Stk0ifCW+Z1IYnqXZs5vowe8ZVInbLAx0xX/nOt4pAEeNgJ94FJNTfB26vnL4X4sN
         AXASpzNw9hZprgyVonPg6gsT3Fn3HF99bKv3GDux0J/mB8nSnFmqBEGIZyGMYBRrWDjj
         BHNXCMyM51E7eLTSlrEj7ICjlZ82TR9CEN6mM3ODAsjs30f59kVZEzmbrt3qarASxThx
         An7A==
X-Gm-Message-State: ANhLgQ0hM0uJYXY2kcaZXbODHoVbPhRNCFstRLob+70EcVaWLbbrIucG
        zLgozTNKrykPkgSkf0uqBrU=
X-Google-Smtp-Source: ADFU+vv3GtvLSSt7BJOXGL09xkZ0IpAPw4/sXWXUqFH4vo9I6984dL0uk4GHdrmEyRkGJRXMspd7Hw==
X-Received: by 2002:a05:6000:1042:: with SMTP id c2mr10925506wrx.360.1583417265904;
        Thu, 05 Mar 2020 06:07:45 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id q16sm29442012wrj.73.2020.03.05.06.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 06:07:44 -0800 (PST)
Date:   Thu, 5 Mar 2020 15:07:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: fix NULL pointer dereference in
 __mem_cgroup_usage_unregister_event
Message-ID: <20200305140744.GY16139@dhcp22.suse.cz>
References: <5ee35fe7-2a90-ae71-9100-3f2833cbf252@gmail.com>
 <20200305092447.GQ16139@dhcp22.suse.cz>
 <1391a759-845e-11d4-09f4-9bd6e498db4f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1391a759-845e-11d4-09f4-9bd6e498db4f@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 05-03-20 21:28:20, brookxu wrote:
[...]
> We can reproduce this problem in the following ways：
> 
> 1. We create a new cgroup subdirectory and a new eventfd, and then we monitor multiple memory thresholds of the cgroup through this eventfd
> 2. closing this eventfd, the system will call __mem_cgroup_usage_unregister_event () multiple times to delete all events related to this eventfd.
> 
> The first time __mem_cgroup_usage_unregister_event () is called, the system will clear all items related to this eventfd in thresholds-> primary.
> Since there is currently only one eventfd, thresholds-> primary becomes empty, so the system will set thresholds-> primary and hresholds-> spare
> to NULL. If at this time, the user creates a new eventfd and monitor the memory threshold of this cgroup, then the system will re-initialize
> thresholds-> primary. Then when the system call __mem_cgroup_usage_unregister_event () is called for the second time, because thresholds-> primary
> is not empty, the system will access thresholds-> spare, but thresholds-> spare is NULL, which will trigger a crash.
> 
> In general, the longer it takes to delete all events related to this eventfd, the easier it is to trigger this problem.

Thank you for reproducing this on the current kernel and the above
description. That makes it much more easier to understand the underlying
problem. Please add it to the changelog. My memory about thresholds is
quite rusty so I will have to think about this more but I have some
coarse idea now at least.

-- 
Michal Hocko
SUSE Labs
