Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5E519D993
	for <lists+cgroups@lfdr.de>; Fri,  3 Apr 2020 16:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404090AbgDCOz2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Apr 2020 10:55:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34654 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404079AbgDCOz1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Apr 2020 10:55:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id 14so6387839qtp.1;
        Fri, 03 Apr 2020 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WueqobVTQhcuC12qhXxBjSlUXTsOjQxipqHLExYdXc0=;
        b=r1b480yVF4TVvjrmu9e9b50NuC47Vk3m0YSl40WOSeQXq8lJeps/ADO+KJNjeKJzJj
         aGGZJZfUuaq3cRlitmPYQ2IQv77nhZDHwTOFW4atm0XMsImQWiDGLolaa9PagsIpXjgb
         EM2oNoZdvmXAhaoNA0X7jbbK3rIy8dL8zcXGxbVDVblZmNjnIRyoagBiqvD5Wg0DfMft
         Je19HLCWupm6dDLYgsaD2ZSvaSjPdO2mdFOlfM68Q7pRDcuIodjlvnxsEyHv1ozQY4VN
         td2ZZZmZjc3IOVeCUgGknW+DVuUoBKjpERAgu440DgNTZua5AIfvoANdbzhN23UAUpXq
         kuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=WueqobVTQhcuC12qhXxBjSlUXTsOjQxipqHLExYdXc0=;
        b=WTC2VyVjGW6Bdvq3uq0HhQ47SRmgpyi/1gnYae1brmpJjJu6sZl3g3I3hb/F2E5ZeC
         etMDHQIH2F1+wobgxul9kwd0jbDqCPvnDBAzMacKgmF3r+7kVXvG5zLMCgiBO4GIW/8j
         sTqQlbS7tRSTQ4Cx1h1oA6Y/eChuL3fbSXwVii1dDTtfsr5I4r1dFBz9xAvABbJYHZBE
         yYnAWHHDd8n8kGvnnY3+/cIO7EYo9hChd2BsaElLClCQpwIhuDu4V1hvU9Fk4FdweaKo
         Syg/MxHOr4qelEze3qy5F9/z58rn5oG2ZomyOeJo8n/yQljBWhax6K9bmDkiUWuO2p5O
         fDVA==
X-Gm-Message-State: AGi0PuZkh6d23U1jHy707FK6BcAfWXvHZjZUk75s4QeK+Db1wDVQzqi6
        M9mbOTUB4nsrgd8qWaBd19A=
X-Google-Smtp-Source: APiQypIWYRFn9PmjXGuhOXLCtTNa/5UW/zyNPX9KmNkdo6y3Q3MtaY+o4pitao0ov7CK3dInjarMMg==
X-Received: by 2002:ac8:2f15:: with SMTP id j21mr8898994qta.55.1585925726184;
        Fri, 03 Apr 2020 07:55:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::842b])
        by smtp.gmail.com with ESMTPSA id f188sm3895379qkd.101.2020.04.03.07.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:55:25 -0700 (PDT)
Date:   Fri, 3 Apr 2020 10:55:23 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Qian Cai <cai@lca.pw>, Prateek Sood <prsood@codeaurora.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Deadlock due to "cpuset: Make cpuset hotplug synchronous"
Message-ID: <20200403145523.GC162390@mtj.duckdns.org>
References: <F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw>
 <20200325191922.GM162390@mtj.duckdns.org>
 <20200326101529.xh763j5frq2r7mqv@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200326101529.xh763j5frq2r7mqv@e107158-lin>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 26, 2020 at 10:15:32AM +0000, Qais Yousef wrote:
> On 03/25/20 15:19, Tejun Heo wrote:
> > On Wed, Mar 25, 2020 at 03:16:56PM -0400, Qian Cai wrote:
> > > The linux-next commit a49e4629b5ed (“cpuset: Make cpuset hotplug synchronous”)
> > > introduced real deadlocks with CPU hotplug as showed in the lockdep splat, since it is
> > > now making a relation from cpu_hotplug_lock —> cgroup_mutex.
> > 
> > Prateek, can you please take a look? Given that the merge window is just around
> > the corner, we might have to revert and retry later if it can't be resolved
> > quickly.
> 
> I've ran cpuset_hotplug and cpuhotplug LTP tests using next-20200325 but
> couldn't reproduce it.
> 
> Hopefully that can be fixed, but if you had to revert it, do you mind picking
> this instead to fix the LTP issue I encountered before?
> 
> 	https://lore.kernel.org/lkml/20200211141554.24181-1-qais.yousef@arm.com/

So, I'd rather not, for now anyway. It isn't a real problem and I don't wanna
add a wait vector there.

Thanks.

-- 
tejun
