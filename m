Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1F583234
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiG0SmR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiG0SmA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 14:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E31987C16
        for <cgroups@vger.kernel.org>; Wed, 27 Jul 2022 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658943555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R5b5gVej4MQa9hZ7l9p+CF9FxGIX65gr66TPXFnDVek=;
        b=htknciyco9Q8g5xVq50hhmYD67cvzuMCM7CweoGB8idlFisjYflQ6kL87RP90gmMOgpg2Y
        1FdmhHuJaZ7TcWNwMRYvjSR9OPrr92qzVr30ajqxeKBlcNuB4XFjtgV3X6wNrJf1vSlVMZ
        0576FxkzW8ZMmZWrMeZP/0tqCRpG3ho=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-1FOChaSJNo2NPllRWIsRog-1; Wed, 27 Jul 2022 13:39:11 -0400
X-MC-Unique: 1FOChaSJNo2NPllRWIsRog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2494785A58A;
        Wed, 27 Jul 2022 17:39:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.193])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1541C2026D64;
        Wed, 27 Jul 2022 17:39:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 27 Jul 2022 19:39:10 +0200 (CEST)
Date:   Wed, 27 Jul 2022 19:39:08 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH RESEND 3/3 cgroup/for-5.20] cgroup: Make !percpu
 threadgroup_rwsem operations optional
Message-ID: <20220727173906.GB18822@redhat.com>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
 <YtDvl7Qjc5zI3e/b@slm.duckdns.org>
 <YtwFjPnCtw8ySnuv@slm.duckdns.org>
 <20220725121208.GB28662@redhat.com>
 <YuB1QW6Kce5nkBu6@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuB1QW6Kce5nkBu6@slm.duckdns.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On 07/26, Tejun Heo wrote:
>
> > __rcu_sync_enter(rsp, false) works just like rcu_sync_enter_start() but it can
> > be safely called at any moment.
>
> Yeah, I originally used rcu_sync_enter_start() but quickly found out that it
> can't be reverted reliably. Given how cold the option switching path is, I
> think it's fine to pay an extra synchronize_rcu() there rather than adding
> more complexity to rcu_sync_enter() unless this will be useful somewhere
> else too.

Yes, agreed. As I said, this is just for record, so that I can find this (simple)
patch on lkml if we have another user of __rcu_sync_enter(rsp, bool wait).

> > And can't resist, off-topic question... Say, cgroup_attach_task_all() does
> >
> > 	mutex_lock(&cgroup_mutex);
> > 	percpu_down_write(&cgroup_threadgroup_rwsem);
> >
> > and this means that synchronize_rcu() can be called with cgroup_mutex held.
> > Perhaps it makes sense to change this code to do
> >
> > 	rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
> > 	mutex_lock(&cgroup_mutex);
> > 	percpu_down_write(&cgroup_threadgroup_rwsem);
> > 	...
> > 	percpu_up_write(&cgroup_threadgroup_rwsem);
> > 	mutex_unlock(&cgroup_mutex);
> > 	rcu_sync_exit(&cgroup_threadgroup_rwsem.rss);
> >
> > ? Just curious.
>
> I'm not quite following.

Me too ;)

> Are you saying that if we switching the rwsem into
> slow mode before grabbing the locks, we can avoid inducing latencies on
> other users?

Well yes, in that another mutex_lock(&cgroup_mutex) won't sleep until
synchronize_rcu() (called under cgroup_mutex) completes.

> Hmm... assuming that I'm understanding you correctly, one
> problem with that approach is that everyone would be doing synchronize_rcu()
> whether they want to change favoring state.

Hmm... I didn't mean the changing if favoring state... And in any case,
this won't cause any additional synchronize_rcu().

Nevermind, please forget, this probably makes no sense.

Oleg.

