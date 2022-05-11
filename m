Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA43D522D14
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 09:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbiEKHV6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 03:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242816AbiEKHV5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 03:21:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6138A4BFC9;
        Wed, 11 May 2022 00:21:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0E5521F8FA;
        Wed, 11 May 2022 07:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652253715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oPT7y3vtMr9hrPGl5KbXi6Udsxr9fQRC1iNa9w9V8TY=;
        b=cxU4a2s88K5U+Lf0tA0v8r+T4GnaUuAC/B1HkF4OQxBRySnalhHSOl+sexwH0SSsLMsyBe
        NDG/A+Le+GpX3XoULZqJJM4maXRrpUufl9aMyUGBKwFcKKuvCGC19Bn0LMIEBSOge1PgJM
        KEty8LVfXNuk0DhuHnGvY6VS15VD/Qs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E24DF2C141;
        Wed, 11 May 2022 07:21:53 +0000 (UTC)
Date:   Wed, 11 May 2022 09:21:53 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        shy828301@gmail.com, roman.gushchin@linux.dev, shakeelb@google.com,
        linmiaohe@huawei.com, william.kucharski@oracle.com,
        peterx@redhat.com, hughd@google.com, vbabka@suse.cz,
        songmuchun@bytedance.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
Message-ID: <YntkEUKPquTbBjMu@dhcp22.suse.cz>
References: <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
 <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
 <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
 <6278fa75.1c69fb81.9c598.f794@mx.google.com>
 <Ynj/l+pyFJxKfcbQ@dhcp22.suse.cz>
 <6279c354.1c69fb81.7f6c1.15e0@mx.google.com>
 <Yno3pNQOn1lAMPnu@dhcp22.suse.cz>
 <627a5214.1c69fb81.1b7fb.47be@mx.google.com>
 <YnpqYte2jLdcBiPg@dhcp22.suse.cz>
 <627b1899.1c69fb81.cd831.12d9@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <627b1899.1c69fb81.cd831.12d9@mx.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 11-05-22 01:59:52, CGEL wrote:
> On Tue, May 10, 2022 at 03:36:34PM +0200, Michal Hocko wrote:
[...]
> > Can you come up with a sane hierarchical behavior?
> >
> 
> I think this new interface better be independent not hierarchical anyway. Especially
> when we treat container as lightweight virtual machine.

I suspect you are focusing too much on your usecase and do not realize
wider consequences of this being an user interface that still has to be
sensible for other usecases. Take a delagation of the control to
subgroups as an example. If this is a per memcg knob (like swappiness)
then children can override parent's THP policy. This might be a less of
the deal for swappiness because the anon/file reclaim balancing should
be mostly an internal thing. But THP policy is different because it has
other effects to workloads running outside of the said cgroup - higher
memory demand, higher contention for high-order memory etc.

I do not really see how this could be a sensible per-memcg policy
without being fully hierarchical.

> 
> > [...]
> > > > > For micro-service architecture, the application in one container is not a
> > > > > set of loosely tight processes, it's aim at provide one certain service,
> > > > > so different containers means different service, and different service
> > > > > has different QoS demand. 
> > > > 
> > > > OK, if they are tightly coupled you could apply the same THP policy by
> > > > an existing prctl interface. Why is that not feasible. As you are noting
> > > > below...
> > > > 
> > > > >     5.containers usually managed by compose software, which treats container as
> > > > > base management unit;
> > > > 
> > > > ..so the compose software can easily start up the workload by using prctl
> > > > to disable THP for whatever workloads it is not suitable for.
> > > 
> > > prctl(PR_SET_THP_DISABLE..) can not be elegance to support the semantic we
> > > need. If only some containers needs THP, other containers and host do not need
> > > THP. We must set host THP to always first, and call prctl() to close THP for
> > > host tasks and other containers one by one,
> > 
> > It might not be the most elegant solution but it should work.
> 
> So you agree it's reasonable to set THP policy for process in container, right?

Yes, like in any other processes.

> If so, IMHO, when there are thousands of processes launch and die on the machine,
> it will be horrible to do so by calling prctl(), I don't see the reasonability.

Could you be more specific? The usual prctl use would be normally
handled by the launcher and rely on the per-process policy to be
inherited down the road.

-- 
Michal Hocko
SUSE Labs
