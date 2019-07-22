Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6A96FB59
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2019 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfGVIcV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Jul 2019 04:32:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44572 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfGVIcU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Jul 2019 04:32:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so38391792wrf.11
        for <cgroups@vger.kernel.org>; Mon, 22 Jul 2019 01:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R9bzahhq3ljNlfBNBmXOt8CPhPYVWX1wy9gOZA82RJA=;
        b=byZ1GhaJaYJwrGA3c0PQfljxVi7j5E+Z1XwNkPfdJTLCHWLcpcf6JqlpK8+46zBvvc
         StrRhpNuazZN3+ag8aC8vwAetoMrQnXTU/cTdHu0K1E+HfCCXbLp7BrN7DOatMInYq1p
         S2IwRQUipvj71z0shTlAOL3TM67gy1/matqUYOU8mOe57bXdoLQgRgejDGrFwOb+zFVQ
         f/JGhofMlJeW5J/7wu/nl3etSFE8ZR/s0QceVDzKF+hPSRAO1q/rmR3+EB+pRkvYMsQy
         UPSq89Q1+ot3JDXXR+9Ekq2Knkb6H6Cv6IZsPeZqbSq9COKHo1W5XHRXyV+xT6PnSdl8
         U4Ag==
X-Gm-Message-State: APjAAAVj2fiuDQ+XWe8IBXzy8ZxusjwUQBn/Cd1ChMJ8mu+NR7j8QJHe
        XQNwVtxyeMon9zmcSDv12fvlxA==
X-Google-Smtp-Source: APXvYqzJ4NshqzNR5HOD2m25St6NhYG/iWTOz3OYMgjlr9YRkiANXvso2vpl4fBH9Y+XtOi7i5PyFQ==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr9008216wrp.116.1563784338289;
        Mon, 22 Jul 2019 01:32:18 -0700 (PDT)
Received: from localhost.localdomain ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id x18sm34282815wmi.12.2019.07.22.01.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 01:32:17 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:32:14 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v9 2/8] sched/core: Streamlining calls to task_rq_unlock()
Message-ID: <20190722083214.GF25636@localhost.localdomain>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-3-juri.lelli@redhat.com>
 <50f00347-ffb3-285c-5a7d-3a9c5f813950@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f00347-ffb3-285c-5a7d-3a9c5f813950@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 22/07/19 10:21, Dietmar Eggemann wrote:
> On 7/19/19 3:59 PM, Juri Lelli wrote:
> > From: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> [...]
> 
> > @@ -4269,8 +4269,8 @@ static int __sched_setscheduler(struct task_struct *p,
> >  			 */
> >  			if (!cpumask_subset(span, &p->cpus_allowed) ||
> 
> This doesn't apply cleanly on v5.3-rc1 anymore due to commit
> 3bd3706251ee ("sched/core: Provide a pointer to the valid CPU mask").
> 
> >  			    rq->rd->dl_bw.bw == 0) {
> > -				task_rq_unlock(rq, p, &rf);
> > -				return -EPERM;
> > +				retval = -EPERM;
> > +				goto unlock;
> >  			}
> >  		}
> >  #endif

Thanks for reporting. The set is based on cgroup/for-next (as of last
week), though. I can of course rebase on tip/sched/core or mainline if
needed.

Best,

Juri

