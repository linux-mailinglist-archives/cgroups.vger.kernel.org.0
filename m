Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39B2370126
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2019 15:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfGVNf0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Jul 2019 09:35:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35879 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfGVNf0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Jul 2019 09:35:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so39520127wrs.3
        for <cgroups@vger.kernel.org>; Mon, 22 Jul 2019 06:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EuDatz2cIPnBgSI+pkeWKDYDKyeOHk8JclCsQ5sZzLM=;
        b=VGpCID8WH71gcHps8zEF+3lrlm1ioOGUgnV7oQuMIeUM2pFv1wc0bMfcELX1CnfN+y
         qmTIXDxbizRoLKZmI/3/1qES5xNjLyFErvawcLGd8Td7XMDiKKI7k6DUXBpjWltwblXU
         vVnxoA6y9nEV92dffnzh2+m22C66wHVRcLZsjwWpvb5aNdw+wvM0jw7AFLEGOSCUG8Fa
         yPxn2f7uMlkolB6dt2ixvXv/1Rx/FPtnrzjvYPoMUDZkgiMRZIlW2hYCtkLn9MjPtnEP
         H2ZJ567sxsMfdEfzKS7/6yImsLVrlZaM2B7VDfJWzV3vX7GvPvw8RejRo6rrXNsfNbKI
         dkhw==
X-Gm-Message-State: APjAAAXN5KqvJ5enUD8pAZ458DeDHOXRU9cQVa7Lx5qmKVKffaL1uu4N
        UIgF36sLlG2BZ92mvdiE/u+VAQ==
X-Google-Smtp-Source: APXvYqzstqSW3XoFfkCp9xxLOQKWJdHWzx1oDl6TMekdXwTGBVSAn5QVX8ZB6ardIoyNMSeKcj+hdQ==
X-Received: by 2002:adf:df10:: with SMTP id y16mr51366719wrl.302.1563802523990;
        Mon, 22 Jul 2019 06:35:23 -0700 (PDT)
Received: from localhost.localdomain ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id f2sm32641570wrq.48.2019.07.22.06.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 06:35:22 -0700 (PDT)
Date:   Mon, 22 Jul 2019 15:35:20 +0200
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
Message-ID: <20190722133520.GH25636@localhost.localdomain>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-5-juri.lelli@redhat.com>
 <5da6abab-00ff-9bb4-f24b-0bf5dfcd4c35@arm.com>
 <20190722122828.GG25636@localhost.localdomain>
 <07a45864-07bf-aa5d-3ff7-a300326b9040@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a45864-07bf-aa5d-3ff7-a300326b9040@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 22/07/19 15:21, Dietmar Eggemann wrote:
> On 7/22/19 2:28 PM, Juri Lelli wrote:
> > On 22/07/19 13:07, Dietmar Eggemann wrote:
> >> On 7/19/19 3:59 PM, Juri Lelli wrote:
> >>
> >> [...]
> >>
> >>> @@ -557,6 +558,38 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
> >>>  		double_lock_balance(rq, later_rq);
> >>>  	}
> >>>  
> >>> +	if (p->dl.dl_non_contending || p->dl.dl_throttled) {
> >>> +		/*
> >>> +		 * Inactive timer is armed (or callback is running, but
> >>> +		 * waiting for us to release rq locks). In any case, when it
> >>> +		 * will file (or continue), it will see running_bw of this
> >>
> >> s/file/fire ?
> > 
> > Yep.
> > 
> >>> +		 * task migrated to later_rq (and correctly handle it).
> >>
> >> Is this because of dl_task_timer()->enqueue_task_dl()->task_contending()
> >> setting dl_se->dl_non_contending = 0 ?
> > 
> > No, this is related to inactive_task_timer() callback. Since the task is
> > migrated (by this function calling set_task_cpu()) because a CPU hotplug
> > operation happened, we need to reflect this w.r.t. running_bw, or
> > inactive_task_timer() might sub from the new CPU and cause running_bw to
> > underflow.
> 
> I was more referring to the '... it will see running_bw of thus task
> migrated to later_rq ...) and specifically to the HOW the timer
> callback can detect this.

Oh, it actually doesn't "actively" detect this condition. The problem is
that if it still sees dl_non_contending == 1, it will sub (from the
"new" rq to which task's running_bw hasn't been added - w/o this fix)
and cause the underflow.
