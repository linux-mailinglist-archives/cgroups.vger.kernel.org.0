Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E8752294C
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 03:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiEKB75 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 21:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiEKB74 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 21:59:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B8C4ECDF;
        Tue, 10 May 2022 18:59:55 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m12so486016plb.4;
        Tue, 10 May 2022 18:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=ygRJwU53ypBYWb0ipajvfg9wu8BsJDcxou4i7b0FONY=;
        b=AC0/bjCtvdumOBQpoatC2IVwm5A2dJuUre1XwUktN/jPod+nsh1Qg7qpzwCPVU6ilk
         abDUXuerlgxYt8a4AVPN3MTA5VcA8x5Q++NxwSevkqbdTbpdVIKJLQ7zFOf5vo7BohOj
         ev5UZepOZO/gSCuseNeREznvCgsHrov54w7j+92CDKqhK3q/fenS0pRYjexAGiZDs7wi
         QrQG65AnY78uCLRmGQUM24zwdctL84RC1o1+iqaXVI432IWUbOP5J0GbIFCPlb2OJ87n
         lxVk5K8DgOLb7QJHbPC/9sARdOUrI9NmPh9NE8beeIBmSx9CABeUVdN73Ne0QhbjhfAy
         KYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=ygRJwU53ypBYWb0ipajvfg9wu8BsJDcxou4i7b0FONY=;
        b=6EAVY64rtB3TCfmw/Gjsj0iTMUKOgdWZf9w3EZeTzepFzDNkqTlRWCBTlOSgqHJcSq
         fpwWGgywhtZ4jfDPHspblZKQcgr3Utu3N6nnU3e//Qqf/ysYPCvb/ROO9XFNJnlSh8VS
         3jYLArx6sppSUooGbQmAQdJON3he4nymcs7cqMx0z4Gb1AsDC7ZJO26VKGfwYfdgqxfs
         BwS0u8ycIpFNF6E9Ej+Jr9wSYqm7JhplqAq4HcjlaGhLUxT+czLATK0a325A5YgI5QTb
         A7PMJ0O8PHUE/JHnVlVJa9EVWvBqjs7xyFWhOs1srQ5TipeGZuM5FYHeNGM/HtbnslP2
         x38g==
X-Gm-Message-State: AOAM531YVKrJWS6jr8Sn0u6JrbI4ze7nhznGXPJOmEkVkxLln2yLWiTL
        i8jebiR9fHZF8INb5p/W4/8=
X-Google-Smtp-Source: ABdhPJz6SJazp2lQsRReL6XYXSBvynMV1jL0WCwdK6U711v08I70fN/Tk7cykMKTwI8/8EFo+qCUew==
X-Received: by 2002:a17:90a:94c2:b0:1d9:3fbd:bbe1 with SMTP id j2-20020a17090a94c200b001d93fbdbbe1mr2766800pjw.59.1652234394526;
        Tue, 10 May 2022 18:59:54 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b0015e8d4eb1f7sm304835plh.65.2022.05.10.18.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 18:59:53 -0700 (PDT)
Message-ID: <627b1899.1c69fb81.cd831.12d9@mx.google.com>
X-Google-Original-Message-ID: <20220511015952.GA1482876@cgel.zte@gmail.com>
Date:   Wed, 11 May 2022 01:59:52 +0000
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
 <627a5214.1c69fb81.1b7fb.47be@mx.google.com>
 <YnpqYte2jLdcBiPg@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnpqYte2jLdcBiPg@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 10, 2022 at 03:36:34PM +0200, Michal Hocko wrote:
> On Tue 10-05-22 11:52:51, CGEL wrote:
> > On Tue, May 10, 2022 at 12:00:04PM +0200, Michal Hocko wrote:
> > > On Tue 10-05-22 01:43:38, CGEL wrote:
> > > > On Mon, May 09, 2022 at 01:48:39PM +0200, Michal Hocko wrote:
> > > > > On Mon 09-05-22 11:26:43, CGEL wrote:
> > > > > > On Mon, May 09, 2022 at 12:00:28PM +0200, Michal Hocko wrote:
> > > > > > > On Sat 07-05-22 02:05:25, CGEL wrote:
> > > > > > > [...]
> > > > > > > > If there are many containers to run on one host, and some of them have high
> > > > > > > > performance requirements, administrator could turn on thp for them:
> > > > > > > > # docker run -it --thp-enabled=always
> > > > > > > > Then all the processes in those containers will always use thp.
> > > > > > > > While other containers turn off thp by:
> > > > > > > > # docker run -it --thp-enabled=never
> > > > > > > 
> > > > > > > I do not know. The THP config space is already too confusing and complex
> > > > > > > and this just adds on top. E.g. is the behavior of the knob
> > > > > > > hierarchical? What is the policy if parent memcg says madivise while
> > > > > > > child says always? How does the per-application configuration aligns
> > > > > > > with all that (e.g. memcg policy madivise but application says never via
> > > > > > > prctl while still uses some madvised - e.g. via library).
> > > > > > >
> > > > > > 
> > > > > > The cgroup THP behavior is align to host and totally independent just likes
> > > > > > /sys/fs/cgroup/memory.swappiness. That means if one cgroup config 'always'
> > > > > > for thp, it has no matter with host or other cgroup. This make it simple for
> > > > > > user to understand or control.
> > > > > 
> > > > > All controls in cgroup v2 should be hierarchical. This is really
> > > > > required for a proper delegation semantic.
> > > > >
> > > > 
> > > > Could we align to the semantic of /sys/fs/cgroup/memory.swappiness?
> > > > Some distributions like Ubuntu is still using cgroup v1.
> > > 
> > > cgroup v1 interface is mostly frozen. All new features are added to the
> > > v2 interface.
> > >
> > 
> > So what about we add this interface to cgroup v2?
> 
> Can you come up with a sane hierarchical behavior?
>

I think this new interface better be independent not hierarchical anyway. Especially
when we treat container as lightweight virtual machine.

> [...]
> > > > For micro-service architecture, the application in one container is not a
> > > > set of loosely tight processes, it's aim at provide one certain service,
> > > > so different containers means different service, and different service
> > > > has different QoS demand. 
> > > 
> > > OK, if they are tightly coupled you could apply the same THP policy by
> > > an existing prctl interface. Why is that not feasible. As you are noting
> > > below...
> > > 
> > > >     5.containers usually managed by compose software, which treats container as
> > > > base management unit;
> > > 
> > > ..so the compose software can easily start up the workload by using prctl
> > > to disable THP for whatever workloads it is not suitable for.
> > 
> > prctl(PR_SET_THP_DISABLE..) can not be elegance to support the semantic we
> > need. If only some containers needs THP, other containers and host do not need
> > THP. We must set host THP to always first, and call prctl() to close THP for
> > host tasks and other containers one by one,
> 
> It might not be the most elegant solution but it should work.

So you agree it's reasonable to set THP policy for process in container, right?
If so, IMHO, when there are thousands of processes launch and die on the machine,
it will be horrible to do so by calling prctl(), I don't see the reasonability. 

> Maintaining user interfaces for ever has some cost and the THP
> configuration space is quite large already. So I would rather not add
> more complication in unless that is absolutely necessary.
> 
> > in this process some tasks that start before we call prctl() may
> > already use THP with no need.
> 
> As long as all those processes have a common ancestor I do not see how
> that would be possible.
> 
For example:
1) userspace set THP policy to always
2) then one unrelated processe A may launch automatic by a script maybe
3) call prctl() to disable THP for A
process A may already use THP with no need.

> -- 
> Michal Hocko
> SUSE Labs
