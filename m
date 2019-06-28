Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A6959DBE
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2019 16:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF1ObR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jun 2019 10:31:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45323 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfF1ObP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jun 2019 10:31:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so6502218wre.12
        for <cgroups@vger.kernel.org>; Fri, 28 Jun 2019 07:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vIGColdwlEbXzgqC2nSGDJI+imgI3Vqv6hRTUWcURzQ=;
        b=hpNOx+M2/Sh5VPGyPXz44kyJ5gXNONHHGeYRsYZeIcxWGmKd924chiHKA6lpaANinj
         J1++lDa5Hqjp7W4GBW5QqLV7JFqJDM8TU9jI+g4mLpXkNOUVF+bbIPypcfNbNi6QeyZ0
         Qh4BIHiD8uSvQW+b9CXdTTnabi2c78DrAA+RcLeWyQ42IF5FkFpuXbQ+Fq9TNmdNT9Gc
         wHbL1F6TAzJZd+7I0pHLNi8I3tOCotmtSjq80Xnfh6bgdXIUApne6E3UOzCWxJSl5p4Y
         g0UKdUdSeTU2XRd3sE+IoyQMbg+7nV3fcHdOlh+SbrRxxD/ZAYbvGbD8I7aq1bOuL92v
         OkdA==
X-Gm-Message-State: APjAAAV/4kr32x7Mu5DY1oxSTZ2b/mzfhYgbM8lsr/D9J6TOCgLpsq7G
        xU8LNY845f/qE0FZOse7hamQsg==
X-Google-Smtp-Source: APXvYqwx09hYWkLmHko84vnw++BV/pG5dTLGCo1wtOyMVyrIMDG9Y8/TsrSYd/185KxfT1jmBBtkAg==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr1636482wrm.100.1561732272911;
        Fri, 28 Jun 2019 07:31:12 -0700 (PDT)
Received: from localhost.localdomain ([151.29.165.245])
        by smtp.gmail.com with ESMTPSA id j7sm3290365wru.54.2019.06.28.07.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 07:31:11 -0700 (PDT)
Date:   Fri, 28 Jun 2019 16:31:09 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v8 5/8] cgroup/cpuset: convert cpuset_mutex to
 percpu_rwsem
Message-ID: <20190628143109.GX26005@localhost.localdomain>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-6-juri.lelli@redhat.com>
 <20190628124553.GT3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628124553.GT3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 28/06/19 14:45, Peter Zijlstra wrote:
> On Fri, Jun 28, 2019 at 10:06:15AM +0200, Juri Lelli wrote:
> > @@ -2154,7 +2154,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
> >  	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
> >  	cs = css_cs(css);
> >  
> > -	mutex_lock(&cpuset_mutex);
> > +	percpu_down_read(&cpuset_rwsem);
> >  
> >  	/* allow moving tasks into an empty cpuset if on default hierarchy */
> >  	ret = -ENOSPC;
> > @@ -2178,7 +2178,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
> >  	cs->attach_in_progress++;
> >  	ret = 0;
> >  out_unlock:
> > -	mutex_unlock(&cpuset_mutex);
> > +	percpu_up_read(&cpuset_rwsem);
> >  	return ret;
> >  }
> >  
> > @@ -2188,9 +2188,9 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
> >  
> >  	cgroup_taskset_first(tset, &css);
> >  
> > -	mutex_lock(&cpuset_mutex);
> > +	percpu_down_read(&cpuset_rwsem);
> >  	css_cs(css)->attach_in_progress--;
> > -	mutex_unlock(&cpuset_mutex);
> > +	percpu_up_read(&cpuset_rwsem);
> >  }
> 
> These are the only percpu_down_read()s introduced in this patch; are we
> sure this is correct? Specifically, what serializes
> ->attach_in_progress?

No, I think it's wrong, sorry. I'll change to the write variant in next
version.

Thanks,

Juri
