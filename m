Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD5D13129A
	for <lists+cgroups@lfdr.de>; Mon,  6 Jan 2020 14:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgAFNKY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Jan 2020 08:10:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55794 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFNKY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Jan 2020 08:10:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so14886680wmj.5;
        Mon, 06 Jan 2020 05:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vu9QJE4YseoFoORr+glUnjER2lum2n5Fmao9NtM3PIE=;
        b=Qmry3npL+uon2eJcq/7lWfUMhGOxfaYkcOlq8is/UEYqFdbferfFuKRHJZ675o3jrd
         Y61+wgDSJPdA2QAQ0Rc+y+A3nveYHZ3D5sPZqZhBslXiPv3gtTWMwN7A+rcQa+fjWP9j
         YkHRM5Ge/kyJggZhKUKzDo7ubTAN2PYSRcNxuy4hqcpaE0ldf8PSlUMVNeXQSDDc22r2
         Eio8o2M9j2vOZx/IDlk6Tb758rvqlZ6hU/bcJqvA5oJamegJwgzRtlHFBS/G0joR0G5r
         4k3SifP/bol/7q3ebUzDZEEnKHOeD091OX0eIP2EG+cJPAIBkBIMp1tlr7eepAEIAX57
         k6cA==
X-Gm-Message-State: APjAAAUvewkARNni9YRnnjOWZ4szCyXNssJaVV5fkbW8nwJJ4Xp/0IT1
        RBdeL/CLaAuiOUeVRIEDdNAgwg4a
X-Google-Smtp-Source: APXvYqy98p6Gbv57CrgSCBw3//qlqbjd/XfXAeKhQJgUAMjp7jA95LuY+c3vWDw4ljcd4TFaL06olQ==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr34937526wmh.164.1578316222081;
        Mon, 06 Jan 2020 05:10:22 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id b137sm23650193wme.26.2020.01.06.05.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 05:10:21 -0800 (PST)
Date:   Mon, 6 Jan 2020 14:10:20 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Hui Zhu <teawater@gmail.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [RFC] memcg: Add swappiness to cgroup2
Message-ID: <20200106131020.GC9198@dhcp22.suse.cz>
References: <1577252208-32419-1-git-send-email-teawater@gmail.com>
 <20191225140546.GA311630@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191225140546.GA311630@chrisdown.name>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 25-12-19 14:05:46, Chris Down wrote:
> Hi Hui,
> 
> Hui Zhu writes:
> > Even if cgroup2 has swap.max, swappiness is still a very useful config.
> > This commit add swappiness to cgroup2.
> 
> When submitting patches like this, it's important to explain *why* you want
> it and what evidence there is. For example, how should one use this to
> compose a reasonable system? Why aren't existing protection controls
> sufficient for your use case? Where's the data?

Agreed!

> Also, why would swappiness be something cgroup-specific instead of
> hardware-specific, when desired swappiness is really largely about the
> hardware you have in your system?

I am not really sure I agree here though. Swappiness has been
traditionally more about workload because it has been believed that it
is a preference of the workload whether the anonymous or disk based
memory is more important. Whether this is a good interface is debatable
of course but time has shown that it is extremely hard to tune.

Not to mention that swappiness has been ignored for years for vast
majority workloads because of the highly biased file LRU reclaim.

At the time when cgroup v2 was introduced it'd been claimed that we
do not want to copy the v1 swappiness logic because of the semantic
shortcomings and that a better tuning should developed in future
replacing even the global knob. AFAIR Johannes wanted to have a refault
vs. cost based file/anon balancing.

The lack of a sensible hierarchical behavior has been even a stronger
argument.
-- 
Michal Hocko
SUSE Labs
