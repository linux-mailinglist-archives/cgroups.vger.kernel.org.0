Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33B36F6721
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 10:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjEDISb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 May 2023 04:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEDIRv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 May 2023 04:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F745BA0
        for <cgroups@vger.kernel.org>; Thu,  4 May 2023 01:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683187987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rvq9QYdFcVHzrD8NG0o1jSPMkcXmSSUXCp6nCK/Vwpg=;
        b=F1pCiity+N7IBL9c54xby+07f4dL9CixkQOb80cYFEV8KD9V7ECqlGjSYtrvsfQUTEXKG0
        fRswP9RFlSTm+VjETyEvgho/SUXV2BYSK3BtakhP3QroSg0JJ6Xt0zJgIriScrNgU3ptRH
        N6a61WwCbHn6tJpYXDkVJl0Pez2RkC8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-Qplt21g0NGilYPmvVw9gQQ-1; Thu, 04 May 2023 04:13:06 -0400
X-MC-Unique: Qplt21g0NGilYPmvVw9gQQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f173bd0fc9so969285e9.3
        for <cgroups@vger.kernel.org>; Thu, 04 May 2023 01:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187985; x=1685779985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rvq9QYdFcVHzrD8NG0o1jSPMkcXmSSUXCp6nCK/Vwpg=;
        b=lHqm+eCJNuVRIMTmUrGcj7k509TCWfIupMVkbi5G2aSvhGWLDOjw627dsNrCBn7uVg
         ftThZeAQVOKbpZvihqztc+Cxo8SEg3UjHNxwmyDPxsjl1jxM6uV77p7bJ5Rd8zSA8spZ
         IFKSFoQCOCKJLfWEUqDHyUb/6k7tt9dgQ+kH578sTYYvuK3c+ZDod/oIbM4VE4sttr+H
         WAgcdG4m3BFB4+lAs68qjV8gaGA+GErdiShEQWovdCDCtHLWqYgw/N0P8WyLUsSyFaOO
         BhKLHxq1tzsIvqPq8sUz7hgOBnzs/a5Z42Ue78P6CNdlaepItMFkrx+M8Sqg/hi/4ePu
         oYHQ==
X-Gm-Message-State: AC+VfDy1jniPM5WabomifnYVxtbGFAHXZXBqIdi1KpetekRPdMiKe+gB
        AY+aZmjQuHcc0Jg+nw4O93ObGYsW/93P6EeYmZWArnM65yutTNPfUOOqsXcDzwCV26ZonNffXsE
        B6FEKE1593NhEmWsFtQ==
X-Received: by 2002:a05:600c:24a:b0:3f2:51e7:f1f4 with SMTP id 10-20020a05600c024a00b003f251e7f1f4mr16934211wmj.10.1683187985567;
        Thu, 04 May 2023 01:13:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hVkeTRIDeTn1+y9PxDztu4Y6xMSwemGP+0X5YDwN5BdbQORRsgFb4petN+HtAjvh7m9g+7A==
X-Received: by 2002:a05:600c:24a:b0:3f2:51e7:f1f4 with SMTP id 10-20020a05600c024a00b003f251e7f1f4mr16934181wmj.10.1683187985261;
        Thu, 04 May 2023 01:13:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:b121:8011:79a:2d6b:5410:3927:2f38])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c00d300b003f19bca8f03sm4065842wmm.43.2023.05.04.01.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:13:04 -0700 (PDT)
Date:   Thu, 4 May 2023 10:13:00 +0200
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
Message-ID: <ZFNpDELMDUoK99HM@localhost.localdomain>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
 <20230503072228.115707-3-juri.lelli@redhat.com>
 <20230504062105.GD1734100@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504062105.GD1734100@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 04/05/23 08:21, Peter Zijlstra wrote:
> On Wed, May 03, 2023 at 09:22:24AM +0200, Juri Lelli wrote:
> > Turns out percpu_cpuset_rwsem - commit 1243dc518c9d ("cgroup/cpuset:
> > Convert cpuset_mutex to percpu_rwsem") - wasn't such a brilliant idea,
> > as it has been reported to cause slowdowns in workloads that need to
> > change cpuset configuration frequently and it is also not implementing
> > priority inheritance (which causes troubles with realtime workloads).
> 
> What were they doing ? Dynamically adjusting the DL parameters?
> 

Yes, calling sched_setattr to adjust params and/or add/remove DL
reservations.

