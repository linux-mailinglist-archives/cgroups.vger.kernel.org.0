Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4358C751DC
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2019 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbfGYOx6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Jul 2019 10:53:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46334 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbfGYOx5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Jul 2019 10:53:57 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so49288175qtn.13
        for <cgroups@vger.kernel.org>; Thu, 25 Jul 2019 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rpQsWh8tKFiB0DisghLGOONFMKT1wn+vfgfBbAUOPSQ=;
        b=OEpCHpjy+7Mo84hrchMB/6zcHf71ju+A1I4m29ZHJK6VuYG6orfa3YhpmrReIYgGzX
         u5gs0kZveSgwO3shzXd5HocMNEETXZpxDQh8kqAo22eHJvyvOSE+UapcuwoDV3f51dne
         bwohgQ0eeH4JV5ccxn8rysL2tTriLczaCioPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rpQsWh8tKFiB0DisghLGOONFMKT1wn+vfgfBbAUOPSQ=;
        b=fAc4ybnziuGo+afwQQRD6V6SwKiVG3sh9w7fHyrYAesQ+dTfBuIzOH+PoloLI/sH5N
         xM0T4cvl5qfM2pWLJ3S+bfqOQQWMxWg8VhkaBCdCu4nlz33Hmf2MVi89HrzLw0fbX3oo
         dvzIQizLo9KgwG6LfLenU/TMrht7eBWAWdXTemgWVcHFy+fZeCOyyGauj6C8RBYzXARZ
         gxw+pLBYgjtPJfddddXi/iTZ4ohjoQs6TeJ4EM2yQF4/lhDe4K//BQU8O+ZEzn4js90S
         gwClTW/fHa6Ml8WrCm2SQOrsti6rlabWacyJkUQoEEtQvTClq3HVu430K5sUFf3JnQpp
         +xXA==
X-Gm-Message-State: APjAAAVg8YOtbAMuEzUxRR0gBXuKYb5VV0rpgzMYi+AAohBJaHgw+gaP
        Msl5KioMytP3AqsfRDaOY2nHLuysyX9PSg==
X-Google-Smtp-Source: APXvYqwe4cQgpMJVUKQnSVY0whP34x+pDj462jqi9VovQ4DrUT1xMj2tqY2ZAtDTxO7BBE70mMKlXg==
X-Received: by 2002:ac8:1c42:: with SMTP id j2mr62197636qtk.68.1564066436199;
        Thu, 25 Jul 2019 07:53:56 -0700 (PDT)
Received: from localhost (rrcs-24-103-44-77.nyc.biz.rr.com. [24.103.44.77])
        by smtp.gmail.com with ESMTPSA id a6sm22200235qkd.135.2019.07.25.07.53.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 07:53:55 -0700 (PDT)
Date:   Thu, 25 Jul 2019 10:53:55 -0400
From:   Chris Down <chris@chrisdown.name>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     cgroups@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "n.fahldieck@profihost.ag" <n.fahldieck@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>,
        p.kramme@profihost.ag
Subject: Re: No memory reclaim while reaching MemoryHigh
Message-ID: <20190725145355.GA7347@chrisdown.name>
References: <496dd106-abdd-3fca-06ad-ff7abaf41475@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <496dd106-abdd-3fca-06ad-ff7abaf41475@profihost.ag>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Stefan,

Stefan Priebe - Profihost AG writes:
>While using kernel 4.19.55 and cgroupv2 i set a MemoryHigh value for a
>varnish service.
>
>It happens that the varnish.service cgroup reaches it's MemoryHigh value
>and stops working due to throttling.

In that kernel version, the only throttling we have is reclaim-based throttling 
(I also have a patch out to do schedule-based throttling, but it's not in 
mainline yet). If the application is slowing down, it likely means that we are 
struggling to reclaim pages.

>But i don't understand is that the process itself only consumes 40% of
>it's cgroup usage.
>
>So the other 60% is dirty dentries and inode cache. If i issue an
>echo 3 > /proc/sys/vm/drop_caches
>
>the varnish cgroup memory usage drops to the 50% of the pure process.

As a caching server, doesn't Varnish have a lot of hot inodes/dentries in 
memory? If they are hot, it's possible it's hard for us to evict them.

>I thought that the kernel would trigger automatic memory reclaim if a
>cgroup reaches is memory high value to drop caches.

It does, that's the throttling you're seeing :-) I think more information is 
needed to work out what's going on here. For example: what do your kswapd 
counters look like? What does "stops working due to throttling" mean -- are you 
stuck in reclaim?

Thanks,

Chris
