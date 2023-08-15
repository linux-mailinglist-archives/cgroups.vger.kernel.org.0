Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7312C77C480
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 02:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjHOAfv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 20:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjHOAf2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 20:35:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4E093;
        Mon, 14 Aug 2023 17:35:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdef6f5449so8233655ad.3;
        Mon, 14 Aug 2023 17:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692059727; x=1692664527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfAmkgzB7vT7tpPqvlusS7lhE5MuyQY4MvJWqWEdMxw=;
        b=Q3FsTHwS9lFILlCZTL+VSW2aBgIikI37LyzDBlO0rg0yAWWl8WiLTTad1Bw93yvH2Z
         6+H2tD04Xx312hOQjfVs27DFdL6BpDfUgH3bGOLnXfU6snGVTi+SuseJ4OifnvpGkxDr
         7JxqVmNrBAZB0ief7FxYgn9iQKvIGAqQQi5CNmTYRSrxjBEfskBkDsspIzSrAK/aJg7x
         f2nsQFkayTk8wUfT/jQZzyxeA+3lz1jN9M8+8YF+8FCQmW5s/n9Zuni13dkFGyJoQPYv
         QmmmIL1K28eb5SymTU5DSEDwbxqSnpm9lF4RfGQ00GO5KnsBKtt5CZPR0kq/u1Kq9JmR
         OySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692059727; x=1692664527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfAmkgzB7vT7tpPqvlusS7lhE5MuyQY4MvJWqWEdMxw=;
        b=a/eIgEVsQVCK2jeuI6d7P2BrOjdS9rPGLob1BvH5OfyYv8kAeSvdistIysZtaGpH8s
         d/6AXPL3TwN5fvfaj5vZn89EZque8L4plmgAB9MLVcMWg3BBncipy8tU/4mH0JpjGW9q
         XkdaBdbZWbWfcK6CQmI2RMA0EuZD3i7zUj3v/vJwpBFpEJLcaletm0hMyX452wx/Fxdr
         IZ6tbTAFJp8HxtZEE3TOcTfD85W0qYLDfT/UwqxXopl3YfmmAoqmxOjujHGqM3E6xeu+
         3xSu8Hjbret7mes1lXkcchM07LS9v6tdAdSqwfklQZ/cKkNuMQXb/f1M64ibpEOXdqgj
         WHfQ==
X-Gm-Message-State: AOJu0YwGwoUTUhEZGym9hJ9xUqLVpANwCTOZIvMya7gsBYYJFb9+bO9J
        +i9J7ksWOeIOBok200uESk7iItmiQW0=
X-Google-Smtp-Source: AGHT+IHI7QnEnuIcrHvGdYK8SghKW3IFtA+uZj3a3P6LJs/SVdXPUY2rHy+foXwaqvyorqLt4HERmQ==
X-Received: by 2002:a17:903:22cc:b0:1b6:797d:33fb with SMTP id y12-20020a17090322cc00b001b6797d33fbmr13717283plg.64.1692059727156;
        Mon, 14 Aug 2023 17:35:27 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id bh9-20020a170902a98900b001b89a6164desm9972446plb.118.2023.08.14.17.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 17:35:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Aug 2023 14:35:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
Message-ID: <ZNrITZVTf2EILRJq@slm.duckdns.org>
References: <CAJD7tkbF1tNi8v0W4Mnqs0rzpRBshOFepxFTa1SiSvmBEBUEvw@mail.gmail.com>
 <CALvZod55S3XeK-MquTq0mDuipq8j0vFymQeX_XnPb_HuPK+oGQ@mail.gmail.com>
 <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
 <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
 <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
 <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com>
 <ZNdEaw2nktq1NfmH@dhcp22.suse.cz>
 <CAJD7tkaFHgc3eN1K1wYsQFWMLu4+Frf9DJ-5HOja2nC20Es9Dw@mail.gmail.com>
 <ZNrDWqfjXtAYhnvT@slm.duckdns.org>
 <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Aug 14, 2023 at 05:28:22PM -0700, Yosry Ahmed wrote:
> > So, the original design used mutex for synchronize flushing with the idea
> > being that updates are high freq but reads are low freq and can be
> > relatively slow. Using rstats for mm internal operations changed this
> > assumption quite a bit and we ended up switching that mutex with a lock.
> 
> Naive question, do mutexes handle thundering herd problems better than
> spinlocks? I would assume so but I am not sure.

I don't know. We can ask Waiman if that becomes a problem.

> > * Flush-side, maybe we can break flushing into per-cpu or whatnot but
> >   there's no avoiding the fact that flushing can take quite a while if there
> >   are a lot to flush whether locks are split or not. I wonder whether it'd
> >   be possible to go back to mutex for flushing and update the users to
> >   either consume the cached values or operate in a sleepable context if
> >   synchronous read is necessary, which is the right thing to do anyway given
> >   how long flushes can take.
> 
> Unfortunately it cannot be broken down into per-cpu as all flushers
> update the same per-cgroup counters, so we need a bigger locking
> scope. Switching to atomics really hurts performance. Breaking down
> the lock to be per-cgroup is doable, but since we need to lock both
> the parent and the cgroup, flushing top-level cgroups (which I assume
> is most common) will lock the root anyway.

Plus, there's not much point in flushing in parallel, so I don't feel too
enthusiastic about splitting flush locking.

> All flushers right now operate in sleepable context, so we can go
> again to the mutex if you think this will make things better. The

Yes, I think that'd be more sane.

> slowness problem reported recently is in a sleepable context, it's
> just too slow for userspace if I understand correctly.

I mean, there's a certain amount of work to do. There's no way around it if
you wanna read the counters synchronously. The only solution there would be
using a cached value or having some sort of auto-flushing mechanism so that
the amount to flush don't build up too much - e.g. keep a count of the
number of entries to flush and trigger flush if it goes over some threshold.

Thanks.

-- 
tejun
