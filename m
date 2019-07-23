Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D49E71AEF
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2019 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbfGWO6Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Jul 2019 10:58:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40172 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbfGWO6Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Jul 2019 10:58:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so43532552wrl.7
        for <cgroups@vger.kernel.org>; Tue, 23 Jul 2019 07:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Q95sKPFk9TccCca5wm3MHqC/bILt6AlguaLb9p5BtM=;
        b=rcaVJd6jSywMyzULYpFa8nCQFQm1pwdoYaCfaPqMV1xZdg0LQmORRNmY3YmyF13+DJ
         LYp1wRzcBLxArgzhFM7idwDWzM4xlmu4+g0Ie3UckRs2dDd8d/4/Vkqj/BozG3m7tyyH
         gWwpCX+HQmkJNpSVAZ4FUVHu8Ln2pfAZ97yPzg+tEw0Ciyu170/gggidw//tFKQNe56J
         Hpp5I6kcAAKW+N/D5pCGVvDdTpMfhD4C/ibyz+1Ujelq8gvMyDoEto7VMeAWKoAqKMtJ
         XusIcnwmfI0uaYFCNTrvpsBI1amDXjFWnSP6VceISE+EJEo1jzD9JWNSJsiFCX+YbItF
         u9Mw==
X-Gm-Message-State: APjAAAWwJVpxWGzexwFPCDc5Xs8CwOium6GgS5ZGO9o4c7/YX/vDmENp
        bPiHtZt9wY5aNe+kjU084rA+eg==
X-Google-Smtp-Source: APXvYqwajsaIpsTNukBrd6DpemfTekkynv+5Etmj9MGkQ//eh78SY+UKHQhzkijD9ozwvRSKVYHHOw==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr85777998wrr.41.1563893903061;
        Tue, 23 Jul 2019 07:58:23 -0700 (PDT)
Received: from localhost.localdomain ([151.82.8.29])
        by smtp.gmail.com with ESMTPSA id x11sm30735456wmi.26.2019.07.23.07.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 07:58:21 -0700 (PDT)
Date:   Tue, 23 Jul 2019 16:58:18 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v9 2/8] sched/core: Streamlining calls to task_rq_unlock()
Message-ID: <20190723145818.GI25636@localhost.localdomain>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-3-juri.lelli@redhat.com>
 <50f00347-ffb3-285c-5a7d-3a9c5f813950@arm.com>
 <20190722083214.GF25636@localhost.localdomain>
 <20190723103131.GB3402@hirez.programming.kicks-ass.net>
 <20190723131100.GE696309@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723131100.GE696309@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 23/07/19 06:11, Tejun Heo wrote:
> On Tue, Jul 23, 2019 at 12:31:31PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 22, 2019 at 10:32:14AM +0200, Juri Lelli wrote:
> > 
> > > Thanks for reporting. The set is based on cgroup/for-next (as of last
> > > week), though. I can of course rebase on tip/sched/core or mainline if
> > > needed.
> > 
> > TJ; I would like to take these patches through the scheduler tree if you
> > don't mind. Afaict there's no real conflict vs cgroup/for-next (I
> > applied the patches and then did a pull of cgroup/for-next which
> > finished without complaints).
> 
> Yeah, for sure, please go ahead.
> 
> Thanks.

Thanks!
