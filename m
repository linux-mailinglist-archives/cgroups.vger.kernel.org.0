Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6A2C5C9B0
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2019 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfGBHBc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Jul 2019 03:01:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51286 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfGBHBc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Jul 2019 03:01:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so1759601wma.1
        for <cgroups@vger.kernel.org>; Tue, 02 Jul 2019 00:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7BmWpWsMHr5JYuSho9C6rnA1huvO7+aSrMupO2ViFEI=;
        b=eyqrKj+alANRrvLxGfVIzseseHuIBisxBg9b/2/jnfaz9W0METCkFODk/6pLWnOC6M
         XuWi44Ixxkh7TD11i1c2HbQKrrhKxEJ6chjqmnjAzaK/V1p1cAlc+Fh5F2tr8gEBOMsz
         PjrDu4VMWlDxPWUt/AJa2vW+HYfs3/m8LCC8H3LE/DKfEwuu+MvjNRnyZky9gWq/rAkB
         yCXpSuEjQt7ngx3dXg/bU3FdimCwbxrIrLr3jDWE9PRCwc4sTVoHL3EkTU+/lYza0PLB
         i3aiVkfE90asjIeL+bK5HcGPeGbhKauIwHC1D4q+nkdT65XmAjYc7MIpBf69f1Vzl5Y/
         LIRg==
X-Gm-Message-State: APjAAAUqPh46d2vicK4LFuZILhOpGneMBu4VdHONKlu2uJebEvujgOJO
        JsfJHSI4Gx+i2Hc/UsKK0sg4gQ==
X-Google-Smtp-Source: APXvYqxX3h0O/1RbPglcXFFfIUbuhS5iGSJGJV+SQNR4zsijY3wxjzid5bLZJjgEp5J82pyyIoCJtA==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr2168055wmc.53.1562050890608;
        Tue, 02 Jul 2019 00:01:30 -0700 (PDT)
Received: from localhost.localdomain ([151.15.224.253])
        by smtp.gmail.com with ESMTPSA id d10sm14299306wro.18.2019.07.02.00.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 00:01:30 -0700 (PDT)
Date:   Tue, 2 Jul 2019 09:01:28 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v8 8/8] rcu/tree: Setschedule gp ktread to SCHED_FIFO
 outside of atomic region
Message-ID: <20190702070128.GG26005@localhost.localdomain>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-9-juri.lelli@redhat.com>
 <20190701191308.GE3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701191308.GE3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 01/07/19 21:13, Peter Zijlstra wrote:
> On Fri, Jun 28, 2019 at 10:06:18AM +0200, Juri Lelli wrote:
> > sched_setscheduler() needs to acquire cpuset_rwsem, but it is currently
> > called from an invalid (atomic) context by rcu_spawn_gp_kthread().
> > 
> > Fix that by simply moving sched_setscheduler_nocheck() call outside of
> > the atomic region, as it doesn't actually require to be guarded by
> > rcu_node lock.
> 
> Maybe move this earlier in the series such that the bug doesn't manifest
> in bisection?

OK.
