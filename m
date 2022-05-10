Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC825521444
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 13:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiEJL4v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 07:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiEJL4u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 07:56:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AFB26FA62;
        Tue, 10 May 2022 04:52:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so1831266pju.2;
        Tue, 10 May 2022 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=A0FdGVbgNiT4qf9UfDKCilymbnIPA66uo0bOacpn5kc=;
        b=TrL7vgw9hX+FCcAXW++0XCOVJrf3QJUaGJVBqbSUUAypLKKmpB4cuOYtIBhwBMrido
         OqyotI4LcRe4dMJ+sEuBiPjcoy6u9Gm8LaTMLc4E7CDUGb0NEMsgjYvEUgg7m8U3u0eG
         uNqKuhwvdn/9hCqYeSgtXmc1eW1Sa1IgzmrTCEpa+QNwe72//BvLag9bFRowZv0amPW+
         K0zp2D7YNGKRETl1r4545b2dw6ApogYm0APyDJ6wyU5HizQF3DIMoqbhuBwQs7H9835o
         9Pk6qqzXIs+ZUWEJuKxUj0q5OpeKBpKG9AfN10aApJkGDNEWGTwjKMkXfgA78Uj/xo3I
         DvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=A0FdGVbgNiT4qf9UfDKCilymbnIPA66uo0bOacpn5kc=;
        b=V+GbZHTeeuHbhVw0gO7v3wf+caGlLjNp1VYCicnDxhanmyXF5u5lk95mA4lEr2kMkU
         TtuV6XvyLxjJV1FELbbuOwoy7poEyMMsox8IRA3z32pEoCYcdNEzIVCyn462t2J4RFwF
         7kXG5KdNO0IhbJnI/KzJzlv3GN4bDhUki364afp4sPjjlS05LCvcjMgmGu7hiEnhe4R8
         K3v3YZIdLWw3zpkJ5W28VNFQUnYS56PchGPYB7+hpwnjN7Lgj5oJzl4OX3LwcOYsJtyb
         7tvRTzOqcbrQql3mXmUTsPlLHD+Zk0dR6DN1E8YpqBfsLLASQqrhbwBCEnyJbBhEizQ7
         YLUA==
X-Gm-Message-State: AOAM532BITCDh1ovltHuuaQuJKJmYrFb33BPZ8oeddvgqP6BcOq41AWC
        unWH819BJRMAAi6rUaO9nB4=
X-Google-Smtp-Source: ABdhPJzpCGfzQ/16cQjuL/Vez63BhmyceYNV0JvhPj7xnj3Zr9CcnvI0VZftKedC7iCHhww0lp68Kw==
X-Received: by 2002:a17:902:f24c:b0:15c:b564:e4cc with SMTP id j12-20020a170902f24c00b0015cb564e4ccmr20122350plc.137.1652183572783;
        Tue, 10 May 2022 04:52:52 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902e38100b0015e8d4eb1c8sm1828887ple.18.2022.05.10.04.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:52:52 -0700 (PDT)
Message-ID: <627a5214.1c69fb81.1b7fb.47be@mx.google.com>
X-Google-Original-Message-ID: <20220510115251.GA1357518@cgel.zte@gmail.com>
Date:   Tue, 10 May 2022 11:52:51 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        shy828301@gmail.com, roman.gushchin@linux.dev, shakeelb@google.com,
        linmiaohe@huawei.com, william.kucharski@oracle.com,
        peterx@redhat.com, hughd@google.com, vbabka@suse.cz,
        songmuchun@bytedance.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
References: <20220505033814.103256-1-xu.xin16@zte.com.cn>
 <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
 <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
 <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
 <6278fa75.1c69fb81.9c598.f794@mx.google.com>
 <Ynj/l+pyFJxKfcbQ@dhcp22.suse.cz>
 <6279c354.1c69fb81.7f6c1.15e0@mx.google.com>
 <Yno3pNQOn1lAMPnu@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yno3pNQOn1lAMPnu@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 10, 2022 at 12:00:04PM +0200, Michal Hocko wrote:
> On Tue 10-05-22 01:43:38, CGEL wrote:
> > On Mon, May 09, 2022 at 01:48:39PM +0200, Michal Hocko wrote:
> > > On Mon 09-05-22 11:26:43, CGEL wrote:
> > > > On Mon, May 09, 2022 at 12:00:28PM +0200, Michal Hocko wrote:
> > > > > On Sat 07-05-22 02:05:25, CGEL wrote:
> > > > > [...]
> > > > > > If there are many containers to run on one host, and some of them have high
> > > > > > performance requirements, administrator could turn on thp for them:
> > > > > > # docker run -it --thp-enabled=always
> > > > > > Then all the processes in those containers will always use thp.
> > > > > > While other containers turn off thp by:
> > > > > > # docker run -it --thp-enabled=never
> > > > > 
> > > > > I do not know. The THP config space is already too confusing and complex
> > > > > and this just adds on top. E.g. is the behavior of the knob
> > > > > hierarchical? What is the policy if parent memcg says madivise while
> > > > > child says always? How does the per-application configuration aligns
> > > > > with all that (e.g. memcg policy madivise but application says never via
> > > > > prctl while still uses some madvised - e.g. via library).
> > > > >
> > > > 
> > > > The cgroup THP behavior is align to host and totally independent just likes
> > > > /sys/fs/cgroup/memory.swappiness. That means if one cgroup config 'always'
> > > > for thp, it has no matter with host or other cgroup. This make it simple for
> > > > user to understand or control.
> > > 
> > > All controls in cgroup v2 should be hierarchical. This is really
> > > required for a proper delegation semantic.
> > >
> > 
> > Could we align to the semantic of /sys/fs/cgroup/memory.swappiness?
> > Some distributions like Ubuntu is still using cgroup v1.
> 
> cgroup v1 interface is mostly frozen. All new features are added to the
> v2 interface.
>

So what about we add this interface to cgroup v2?

> > > > If memcg policy madivise but application says never, just like host, the result
> > > > is no THP for that application.
> > > > 
> > > > > > By doing this we could promote important containers's performance with less
> > > > > > footprint of thp.
> > > > > 
> > > > > Do we really want to provide something like THP based QoS? To me it
> > > > > sounds like a bad idea and if the justification is "it might be useful"
> > > > > then I would say no. So you really need to come with a very good usecase
> > > > > to promote this further.
> > > > 
> > > > At least on some 5G(communication technology) machine, it's useful to provide
> > > > THP based QoS. Those 5G machine use micro-service software architecture, in
> > > > other words one service application runs in one container.
> > > 
> > > I am not really sure I understand. If this is one application per
> > > container (cgroup) then why do you really need per-group setting?
> > > Does the application is a set of different processes which are only very
> > > loosely tight?
> > > 
> > For micro-service architecture, the application in one container is not a
> > set of loosely tight processes, it's aim at provide one certain service,
> > so different containers means different service, and different service
> > has different QoS demand. 
> 
> OK, if they are tightly coupled you could apply the same THP policy by
> an existing prctl interface. Why is that not feasible. As you are noting
> below...
> 
> >     5.containers usually managed by compose software, which treats container as
> > base management unit;
> 
> ..so the compose software can easily start up the workload by using prctl
> to disable THP for whatever workloads it is not suitable for.

prctl(PR_SET_THP_DISABLE..) can not be elegance to support the semantic we
need. If only some containers needs THP, other containers and host do not need
THP. We must set host THP to always first, and call prctl() to close THP for
host tasks and other containers one by one, in this process some tasks that
start before we call prctl() may already use THP with no need. 

And compose's semantic treats container as base unit to manage not tasks. See:
https://docs.docker.com/compose/

If we treat container as lightweight virtual machine things may become clearer:
this virtual machine has it's own THP policy being set just likes
/sys/kernel/mm/transparent_hugepage/enabled in host, it has nothing to do
with host or other virtual machine.

> -- 
> Michal Hocko
> SUSE Labs
