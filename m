Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE3A6F6728
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 10:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjEDIVS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 May 2023 04:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjEDIUk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 May 2023 04:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24D04490
        for <cgroups@vger.kernel.org>; Thu,  4 May 2023 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683188024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=StIZClLvWq1Og9t6DHx1Hzd3Kvv2y6bvz7gxny+91MY=;
        b=ZXqyK89zi8HFk4Ly6aPmIrWt/bgtyfJN7WNZ/9NKAQ37tywrrixO77kMZg1h4XAb26pMjC
        kpSSJT9SDO7HHqBVRCwNZCWSfkdjIjtBr6cYZ/Z94tkxaDj5ESQo3pGH2CYEJubWupXltM
        m75Xq+huZrPnwj+PviHYscFWz10ZDyQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-feLAZCW5ODS5yRLSKigpmw-1; Thu, 04 May 2023 04:13:43 -0400
X-MC-Unique: feLAZCW5ODS5yRLSKigpmw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3062e5d0cd3so31376f8f.3
        for <cgroups@vger.kernel.org>; Thu, 04 May 2023 01:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683188022; x=1685780022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StIZClLvWq1Og9t6DHx1Hzd3Kvv2y6bvz7gxny+91MY=;
        b=bRMXpq4huoM3h+KaqDtQcxb4DAXrHfkXQAkIcpU9uA5eIAykIbGKT021KEfn/KAUpp
         8ijRED5xwQ2fvbPQfItVU2oQoYqLROjL2Y7fWNdcQ/PxxaWCQWk9WJjFuREdvBw2Gjv4
         j4R6kC27raNrvd3QnM8TZOgAu7jslBVrhsI/Yyx7OW0RRox5r5NHCyWpxK3D0zlVUXAj
         9ZMpjNvYcUBCxTYdO4HNmlcrbqMbOgbIbdGRoBKc+y+A8JbgIW5KUa/M1JykZbLY1h9Y
         nbwHDZqTw0UDKGy4Ag33RihkadxcAO8DHaBckvACcuLFILYbksKqsnhdzl7+P7oy73oX
         fLBA==
X-Gm-Message-State: AC+VfDz6+WtF4FnAuCZWskOsgW1l49P9sUPaSXLe/ryLGA/DlC+VYHHk
        4DeE2GiDvL6dAeln93kpLBK6E2uhRyn+ERxXq3/C+7bA2rO6FSzTf0x9r3evaeS5kFQH1pKyhR/
        LsQcmRIyRWvkSWrVORQ==
X-Received: by 2002:a5d:420a:0:b0:306:b48:3fc4 with SMTP id n10-20020a5d420a000000b003060b483fc4mr1824582wrq.31.1683188022269;
        Thu, 04 May 2023 01:13:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6knmugZZ6j26dT1v2A0BMTbke1qENWBnpQ3CFgVVDPYEx3RlyJjucKmZv0kjkFf+iXpUNLBQ==
X-Received: by 2002:a5d:420a:0:b0:306:b48:3fc4 with SMTP id n10-20020a5d420a000000b003060b483fc4mr1824547wrq.31.1683188021948;
        Thu, 04 May 2023 01:13:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:b121:8011:79a:2d6b:5410:3927:2f38])
        by smtp.gmail.com with ESMTPSA id y11-20020adfe6cb000000b002f81b4227cesm36203234wrm.19.2023.05.04.01.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:13:41 -0700 (PDT)
Date:   Thu, 4 May 2023 10:13:37 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 2/6] sched/cpuset: Bring back cpuset_mutex
Message-ID: <ZFNpMT+gLbETz8Mp@localhost.localdomain>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
 <20230503072228.115707-3-juri.lelli@redhat.com>
 <20230504061842.GC1734100@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504061842.GC1734100@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 04/05/23 08:18, Peter Zijlstra wrote:
> On Wed, May 03, 2023 at 09:22:24AM +0200, Juri Lelli wrote:
> 
> >  /*
> > - * There are two global locks guarding cpuset structures - cpuset_rwsem and
> > + * There are two global locks guarding cpuset structures - cpuset_mutex and
> >   * callback_lock. We also require taking task_lock() when dereferencing a
> >   * task's cpuset pointer. See "The task_lock() exception", at the end of this
> > - * comment.  The cpuset code uses only cpuset_rwsem write lock.  Other
> > - * kernel subsystems can use cpuset_read_lock()/cpuset_read_unlock() to
> > - * prevent change to cpuset structures.
> > + * comment.  The cpuset code uses only cpuset_mutex. Other kernel subsystems
> > + * can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
> > + * structures.
> >   *
> >   * A task must hold both locks to modify cpusets.  If a task holds
> > - * cpuset_rwsem, it blocks others wanting that rwsem, ensuring that it
> > - * is the only task able to also acquire callback_lock and be able to
> > - * modify cpusets.  It can perform various checks on the cpuset structure
> > - * first, knowing nothing will change.  It can also allocate memory while
> > - * just holding cpuset_rwsem.  While it is performing these checks, various
> > - * callback routines can briefly acquire callback_lock to query cpusets.
> > - * Once it is ready to make the changes, it takes callback_lock, blocking
> > - * everyone else.
> > + * cpuset_mutex, it blocks others, ensuring that it is the only task able to
> > + * also acquire callback_lock and be able to modify cpusets.  It can perform
> > + * various checks on the cpuset structure first, knowing nothing will change.
> > + * It can also allocate memory while just holding cpuset_mutex.  While it is
> > + * performing these checks, various callback routines can briefly acquire
> > + * callback_lock to query cpusets.  Once it is ready to make the changes, it
> > + * takes callback_lock, blocking everyone else.
> >   *
> >   * Calls to the kernel memory allocator can not be made while holding
> >   * callback_lock, as that would risk double tripping on callback_lock
> > @@ -403,16 +402,16 @@ static struct cpuset top_cpuset = {
> >   * guidelines for accessing subsystem state in kernel/cgroup.c
> >   */
> >  
> > -DEFINE_STATIC_PERCPU_RWSEM(cpuset_rwsem);
> > +static DEFINE_MUTEX(cpuset_mutex);
> 
> Perhaps extend the comment to state you explicitly want a mutex for PI
> etc.. ?
> 

Sure, can do that.

Thanks!

