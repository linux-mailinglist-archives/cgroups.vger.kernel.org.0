Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DEE216C9B
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2020 14:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGGMO0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jul 2020 08:14:26 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33617 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgGGMO0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jul 2020 08:14:26 -0400
Received: by mail-wr1-f54.google.com with SMTP id f18so36831030wrs.0;
        Tue, 07 Jul 2020 05:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F9LJxovcUSPNZdF3NUzfceGi+J9EyhfzFFKBXy2kNNI=;
        b=Zv5Oza6aL4nJoxFui8QmkdCuufLbCRP8Mf6zpMX2wFaCmzA/7kjOX1XEUWtI53ew9+
         z8eTcr2ifhDJAd9/6fQenM4CnpALbVV8moIpE4ChhZ1sJ7DaX3UdoHSECEe6n/Uxa6Ui
         9vTU5lTI7aICB8VJZmerR0eZbb2AwCUitfTYmZl6O+N8C7IzM9RAoHBBPBGN8NAG6cA4
         HRJL78oNaY8VOohwh0cdQfSJfFxdCcnnXUAQK7WaW+jp9zSfSH3fpzIvi3V9GxVSpq6x
         R21DiYISLChyOxnxaOjyl4pO29e5cWAcXG2higBFOWzsV4nRO9d5m2uZeHFUtzay5+Pz
         ESaw==
X-Gm-Message-State: AOAM530WckB0dA3GvL9c5RyJ9dreWWLhoLFhIFy++E2lmmybHMJtRXB9
        uXOk+LbDIq6tZsKvZfN6lMA=
X-Google-Smtp-Source: ABdhPJx2p62DkvqQJFVgHhS+KncXimRczZEYgd7zQKP9q+v9KXZDitL6TpQ6lQ1nPjic1zaspwIsfA==
X-Received: by 2002:adf:f504:: with SMTP id q4mr52656042wro.163.1594124064098;
        Tue, 07 Jul 2020 05:14:24 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id z16sm749165wrr.35.2020.07.07.05.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 05:14:23 -0700 (PDT)
Date:   Tue, 7 Jul 2020 14:14:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [RFC PROPOSAL] memcg: per-memcg user space reclaim interface
Message-ID: <20200707121422.GP5913@dhcp22.suse.cz>
References: <20200702152222.2630760-1-shakeelb@google.com>
 <20200703063548.GM18446@dhcp22.suse.cz>
 <CALvZod5gthVX5m6o50OiYsXa=0_NpXK-tVvjTF42Oj4udr4Nuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5gthVX5m6o50OiYsXa=0_NpXK-tVvjTF42Oj4udr4Nuw@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 03-07-20 07:23:14, Shakeel Butt wrote:
> On Thu, Jul 2, 2020 at 11:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 02-07-20 08:22:22, Shakeel Butt wrote:
> > [...]
> > > Interface options:
> > > ------------------
> > >
> > > 1) memcg interface e.g. 'echo 10M > memory.reclaim'
> > >
> > > + simple
> > > + can be extended to target specific type of memory (anon, file, kmem).
> > > - most probably restricted to cgroup v2.
> > >
> > > 2) fadvise(PAGEOUT) on cgroup_dir_fd
> > >
> > > + more general and applicable to other FSes (actually we are using
> > > something similar for tmpfs).
> > > + can be extended in future to just age the LRUs instead of reclaim or
> > > some new use cases.
> >
> > Could you explain why memory.high as an interface to trigger pro-active
> > memory reclaim is not sufficient. Also memory.low limit to protect
> > latency sensitve workloads?
> 
> Yes, we can use memory.high to trigger [proactive] reclaim in a memcg
> but note that it can also introduce stalls in the application running
> in that memcg. Let's suppose the memory.current of a memcg is 100MiB
> and we want to reclaim 20MiB from it, we can set the memory.high to
> 80MiB but any allocation attempt from the application running in that
> memcg can get stalled/throttled. I want the functionality of the
> reclaim without potential stalls.

It would be great if the proposal mention this limitation.

> The memory.min is for protection against the global reclaim and is
> unrelated to this discussion.

Well, I was talkingg about memory.low. It is not meant only to protect
from the global reclaim. It can be used for balancing memory reclaim
from _any_ external memory pressure source. So it is somehow related to
the usecase you have mentioned.

What you consider a latency sensitive workload could be protected from
directly induced reclaim latencies. You could use low events to learn
about the external memory pressure and update your protection to allow
for some reclaim. I do understand that this wouldn't solve your problem
who gets reclaimed and maybe that is the crux on why it is not
applicable but that should really be mentioned explicitly.

-- 
Michal Hocko
SUSE Labs
