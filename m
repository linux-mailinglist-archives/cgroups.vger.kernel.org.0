Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83DFB6FF9D
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2019 14:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfGVM2d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Jul 2019 08:28:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55489 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfGVM2d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Jul 2019 08:28:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so34960427wmj.5
        for <cgroups@vger.kernel.org>; Mon, 22 Jul 2019 05:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l6/eI+1bfxhgnjF0+OZA0BlRzZcPL9vx2FzAtVqZorc=;
        b=RUXWxF1SaeiTMU2ULNitdCL5/LR9xCD+Rpt4NRWYGSDsK9HaQD/Dbs3JjDqVPwRqbV
         Ev2wlywZ3zwtOtWId+XUg3l5TKE8zSWa5UDYLU0koYg5f4oYt3XvfZx/2KsGQFK00dsP
         bM99gjbxgibxvjz1FZgzO9RQzjTf897qJ56nYH+l/9FVarvfBGr8NRBerAxkz2ty24Sf
         sGBezUdPqSMcvrLDlg12THVaRWjK0xtWKdzK7tQZI7Y6ghQe1ju0rb7sF3Sa/ZL3fpe5
         HDuRwNcWSmyclEu+2+qgsxX8E/Ze+B2/WWUjmMLWZnhz3r7akOWH4N1+fwSy+MKOzZRx
         QzEg==
X-Gm-Message-State: APjAAAVaWDRJszKJ2MDNmJbrMdb5XeFq7TiWzASAk8E0pCNmfdZriSpJ
        ZmdtNC0SnAsvUBRkfim3P59n+Q==
X-Google-Smtp-Source: APXvYqxlnx12U06nxALU+ypFMTNO8C+4v1VLcbEHRpfOkBv18csOs1A7a/44UULrCDehw/7w3JL4iw==
X-Received: by 2002:a1c:5602:: with SMTP id k2mr59725677wmb.173.1563798511297;
        Mon, 22 Jul 2019 05:28:31 -0700 (PDT)
Received: from localhost.localdomain ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id w25sm37202326wmk.18.2019.07.22.05.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 05:28:30 -0700 (PDT)
Date:   Mon, 22 Jul 2019 14:28:28 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v9 4/8] sched/deadline: Fix bandwidth accounting at all
 levels after offline migration
Message-ID: <20190722122828.GG25636@localhost.localdomain>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-5-juri.lelli@redhat.com>
 <5da6abab-00ff-9bb4-f24b-0bf5dfcd4c35@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5da6abab-00ff-9bb4-f24b-0bf5dfcd4c35@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 22/07/19 13:07, Dietmar Eggemann wrote:
> On 7/19/19 3:59 PM, Juri Lelli wrote:
> 
> [...]
> 
> > @@ -557,6 +558,38 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
> >  		double_lock_balance(rq, later_rq);
> >  	}
> >  
> > +	if (p->dl.dl_non_contending || p->dl.dl_throttled) {
> > +		/*
> > +		 * Inactive timer is armed (or callback is running, but
> > +		 * waiting for us to release rq locks). In any case, when it
> > +		 * will file (or continue), it will see running_bw of this
> 
> s/file/fire ?

Yep.

> > +		 * task migrated to later_rq (and correctly handle it).
> 
> Is this because of dl_task_timer()->enqueue_task_dl()->task_contending()
> setting dl_se->dl_non_contending = 0 ?

No, this is related to inactive_task_timer() callback. Since the task is
migrated (by this function calling set_task_cpu()) because a CPU hotplug
operation happened, we need to reflect this w.r.t. running_bw, or
inactive_task_timer() might sub from the new CPU and cause running_bw to
underflow.

Thanks,

Juri
