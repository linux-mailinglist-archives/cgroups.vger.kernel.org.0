Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D669E522FCE
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 11:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiEKJrx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 05:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiEKJrv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 05:47:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE2377FF;
        Wed, 11 May 2022 02:47:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s14so1358603plk.8;
        Wed, 11 May 2022 02:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cf/PeTJbEoBsfw/lhXYoJEgURdTIh89gvchfxAGn2nU=;
        b=PzYHM/ViCEy70BYdoGBxCtT6atNffiFaFydDfkT9aQJb3pJgXdtSnHgdGvWy7Uiay4
         R6fKLsYJogAA+dypr6QjY4Q2APT1hsrAHTm3bDEMpjsKH8DEzhgCHpcqtdyDDjMD0fKg
         TEVnRqgRsKbPHPWih2+gslNFAbxkM5zVmYqROc9Wpa1J0Zsed+Bz2urej8u7YIhqgGMK
         erY9/DBsHjK6vvcEJxTlMdYfsXuL7FD+T4Bp9vZ4k2C/XjOfjHpFLuY1SWsdL+uJtR/F
         iICE50NHXZCjlIoxVP67SYAHpA97TPWG/wh/kcNNL7PUJlUc0ZeDTTtZihv7+bx5t4Mv
         8B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cf/PeTJbEoBsfw/lhXYoJEgURdTIh89gvchfxAGn2nU=;
        b=7YB3KRFKVhAgRwdffqktMqdBgVQvy8XAuQhL3MXMIkViOokvk4meyVgAjqukcjpLYN
         qloutkDj80l5K1npNCIIt35OnhKnbqhGXh/PNM4aShT+50vGi64plLSoVvRv7zjKJf5D
         VGFqA4woHGE7suboE1FSUqyzwVkv+4KV3nYPb4dvA9i3aYHFRqnF9H93px9INhPOk8c9
         eCWIFSP5L1vLaXj94xLv0NEexEP9c8x1BAGaA+PFKcMZqGqfnvtY1wdE/hMncYVHqMpe
         z0a7kMmA50/oJ4AMEUB4HMs41vW2ScknO33B7YcrdJEuC+ctrZ7Mvdy0ALLGySCuCa/R
         Vw8A==
X-Gm-Message-State: AOAM5309jTR40u+6BRdcts7IhXFgxzmuTdwk4FvZcmJqmmGkuCwZtTvB
        xUigKuEVFxiUozb/u74r3vQ=
X-Google-Smtp-Source: ABdhPJzTPNbi7dyyvhP3OoGDSMDNoRQJ652fE8GTS+7d4GlljPh1p0/2oxu8BL1h++bAYwEcnvl7Iw==
X-Received: by 2002:a17:903:228f:b0:15e:be12:a181 with SMTP id b15-20020a170903228f00b0015ebe12a181mr24864682plh.21.1652262469638;
        Wed, 11 May 2022 02:47:49 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s13-20020a632c0d000000b003db141a5f26sm1337733pgs.1.2022.05.11.02.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 02:47:49 -0700 (PDT)
Message-ID: <627b8645.1c69fb81.5f934.3086@mx.google.com>
X-Google-Original-Message-ID: <20220511094747.GA1543658@cgel.zte@gmail.com>
Date:   Wed, 11 May 2022 09:47:47 +0000
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
References: <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
 <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
 <6278fa75.1c69fb81.9c598.f794@mx.google.com>
 <Ynj/l+pyFJxKfcbQ@dhcp22.suse.cz>
 <6279c354.1c69fb81.7f6c1.15e0@mx.google.com>
 <Yno3pNQOn1lAMPnu@dhcp22.suse.cz>
 <627a5214.1c69fb81.1b7fb.47be@mx.google.com>
 <YnpqYte2jLdcBiPg@dhcp22.suse.cz>
 <627b1899.1c69fb81.cd831.12d9@mx.google.com>
 <YntkEUKPquTbBjMu@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YntkEUKPquTbBjMu@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 11, 2022 at 09:21:53AM +0200, Michal Hocko wrote:
> On Wed 11-05-22 01:59:52, CGEL wrote:
> > On Tue, May 10, 2022 at 03:36:34PM +0200, Michal Hocko wrote:
> [...]
> > > Can you come up with a sane hierarchical behavior?
> > >
> > 
> > I think this new interface better be independent not hierarchical anyway. Especially
> > when we treat container as lightweight virtual machine.
> 
> I suspect you are focusing too much on your usecase and do not realize
> wider consequences of this being an user interface that still has to be
> sensible for other usecases. Take a delagation of the control to
> subgroups as an example. If this is a per memcg knob (like swappiness)
> then children can override parent's THP policy. This might be a less of
> the deal for swappiness because the anon/file reclaim balancing should
> be mostly an internal thing. But THP policy is different because it has
> other effects to workloads running outside of the said cgroup - higher
> memory demand, higher contention for high-order memory etc.
> 

Higher memory demand will be limited by memsw.limit_in_bytes right?
And cgroup really cares about high-order memory usage? At least for
now there are no cgroup limit for this.

> I do not really see how this could be a sensible per-memcg policy
> without being fully hierarchical.
>

Thanks to your patient discuss, as Roman said, I will try to realize this
with bpf.

> > 
> > > [...]
> > > > > > For micro-service architecture, the application in one container is not a
> > > > > > set of loosely tight processes, it's aim at provide one certain service,
> > > > > > so different containers means different service, and different service
> > > > > > has different QoS demand. 
> > > > > 
> > > > > OK, if they are tightly coupled you could apply the same THP policy by
> > > > > an existing prctl interface. Why is that not feasible. As you are noting
> > > > > below...
> > > > > 
> > > > > >     5.containers usually managed by compose software, which treats container as
> > > > > > base management unit;
> > > > > 
> > > > > ..so the compose software can easily start up the workload by using prctl
> > > > > to disable THP for whatever workloads it is not suitable for.
> > > > 
> > > > prctl(PR_SET_THP_DISABLE..) can not be elegance to support the semantic we
> > > > need. If only some containers needs THP, other containers and host do not need
> > > > THP. We must set host THP to always first, and call prctl() to close THP for
> > > > host tasks and other containers one by one,
> > > 
> > > It might not be the most elegant solution but it should work.
> > 
> > So you agree it's reasonable to set THP policy for process in container, right?
> 
> Yes, like in any other processes.
> 
> > If so, IMHO, when there are thousands of processes launch and die on the machine,
> > it will be horrible to do so by calling prctl(), I don't see the reasonability.
> 
> Could you be more specific? The usual prctl use would be normally
> handled by the launcher and rely on the per-process policy to be
> inherited down the road.
>
> -- 
> Michal Hocko
> SUSE Labs
