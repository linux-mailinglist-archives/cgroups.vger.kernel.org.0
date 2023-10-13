Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B507C7D7E
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 08:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjJMGKH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Oct 2023 02:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJMGKG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Oct 2023 02:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F74D9
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697177357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TdKa29R/s7p3SCM8FO+OVeTHJOkKpc2DM547C4oMUjs=;
        b=bd2nAkb7vh1it4hAyNOfDiq4g11Nvhgn1v/DQyE1xqs8o8RYetgVEwhY/JuUKi6LhBVufg
        VTaDrxE4hf9VkLhmJGCVSkXYeEXutVZIS01tvdIuwBxBpc9/bs827pqH5r5mpk8fn5Ip0/
        tcdR3vhOOGOrq8HAL2bv180OgMbfPVU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-3xyV0xSoPeiawEZdqj4vAQ-1; Fri, 13 Oct 2023 02:09:16 -0400
X-MC-Unique: 3xyV0xSoPeiawEZdqj4vAQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6557c921df1so16782926d6.2
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 23:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697177356; x=1697782156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdKa29R/s7p3SCM8FO+OVeTHJOkKpc2DM547C4oMUjs=;
        b=kYfs0snq1Mt+a3/DTy0Lis6e6jlL5v5dqeXhWQRbAouok+IdNGUZebzMv8dWNHP3y/
         hq2Ih9mfDjrN6P4x1Y5h8w3htKll8QUENUHshcXdCFz+IVB7PNxKT3FHWsR6kGoujDoU
         W95nc4Li8uCqHH9YTefL6K3JVHZmla+law037VLZJGCqHyH/lA9v62QtT5TmaF5wp/fC
         6Ed7jLpX3A4co8cz/g3bCArvWsthqwW+4otgY30wQ+xH7lll53gOKVftpTAKO5yKgnW7
         2gLalcl3mqL+GP/pXDNmgKH5xwe0UrcNf4ejki25YoETML6xWU8Iob2CJGyadSRTFkbr
         6b7w==
X-Gm-Message-State: AOJu0Yw+xqx+NJ98aKOMOALZI3Qs8XZ7GKXYG+6rH6JVoer0vH56xuTK
        hPzqVIZSS4vziV1/egBkWT0u6L1EkLcvMTXY4MvKaAokN4/Fm0JMWb9Ok6gWVaDLSQyRHroij6I
        dbgOuGK+Rv2HeOA/XIA==
X-Received: by 2002:a05:6214:2582:b0:66d:2140:1f88 with SMTP id fq2-20020a056214258200b0066d21401f88mr2318765qvb.5.1697177355447;
        Thu, 12 Oct 2023 23:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHnAnXBBGQtF8EmDjLlH7fKrVFzQ8FDgdZEmabajsIP1Nje6CRdy3z0hXW8LQAgNsSsrRi3w==
X-Received: by 2002:a05:6214:2582:b0:66d:2140:1f88 with SMTP id fq2-20020a056214258200b0066d21401f88mr2318741qvb.5.1697177355096;
        Thu, 12 Oct 2023 23:09:15 -0700 (PDT)
Received: from localhost.localdomain ([151.29.94.163])
        by smtp.gmail.com with ESMTPSA id dm9-20020ad44e29000000b0066d15724ff7sm419693qvb.52.2023.10.12.23.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 23:09:14 -0700 (PDT)
Date:   Fri, 13 Oct 2023 08:09:09 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xia Fukun <xiafukun@huawei.com>
Subject: Re: [PATCH] cgroup/cpuset: Change nr_deadline_tasks to an atomic_t
 value
Message-ID: <ZSjfBWgZf15TchA5@localhost.localdomain>
References: <20231009191515.3262292-1-longman@redhat.com>
 <ZSTiULEnD7SF9n7y@localhost.localdomain>
 <6b769316-6434-5054-43f5-7933fc2bee01@redhat.com>
 <31e06652-1dbd-e32f-3123-d17e178c5c27@redhat.com>
 <ZSZZfImXuCG4Xvaz@localhost.localdomain>
 <389a8abc-7f0f-7bcc-bc58-f70f045d00a5@redhat.com>
 <c421a8d5-b364-d3c6-df18-2a6766fc069b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c421a8d5-b364-d3c6-df18-2a6766fc069b@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/10/23 12:35, Waiman Long wrote:
> On 10/11/23 08:54, Waiman Long wrote:

...

> > We can argue that there can be racing between cgroup_exit() and the
> > iteration of tasks in cpuset_attach() or cpuset_can_attach(). An
> > rcu_read_lock() is probably needed. I am stilling investigating that.
> 
> Cgroup has a rather complex task migration and iteration scheme. According
> to the following comments in include/linux/cgroup-defs.h:
> 
>         /*
>          * Lists running through all tasks using this cgroup group.
>          * mg_tasks lists tasks which belong to this cset but are in the
>          * process of being migrated out or in.  Protected by
>          * css_set_lock, but, during migration, once tasks are moved to
>          * mg_tasks, it can be read safely while holding cgroup_mutex.
>          */
>         struct list_head tasks;
>         struct list_head mg_tasks;
>         struct list_head dying_tasks;
> 
> I haven't fully figured out how that protection works yet. Assuming that is
> the case, task iteration in cpuset_attach() should be fine since
> cgroup_mutex is indeed held when it is invoked. That protection, however,
> does not applied to nr_deadline_tasks. It may be too costly to acquire
> cpuset_mutex before updating nr_deadline_tasks in cgroup_exit(). So changing
> it to an atomic_t should be the easy way out of the potential racing
> problem.

My biggest perplexity is/was still about dl_rebuild_rd_accounting() and
cgroup_exit(); I wonder if the latter, operating outside cpuset_mutex
guard, might still be racy wrt the former (even if we change to
atomic_t).

However, looking again at it, dl_rebuild_rd_accounting() operates on
css(es) via css_task_iter_start(), which grabs css_set_lock. So maybe we
are OK already also for this case?

Apologies for being pedantic, but we fought already several times with
races around these bits and now I'm probably over-suspicious. :)

Thanks,
Juri

