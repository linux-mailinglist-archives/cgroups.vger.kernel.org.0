Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316645588BA
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 21:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiFWT0y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 15:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiFWT0d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 15:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF53A7A6C3
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 11:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656009876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=636D/XRoEUnQhXwCEpL4spRdQ6LF5SX4zYskRSw7REM=;
        b=hAzvUZIYHyGmd07z5d08FoOvxSt8zGGMAd1kR38kJOsKDXMRNH+8dWBvel4IZ9VD6/ifmB
        ydazkQQ2n/DK7X5B/PtXm6nLNaYXbubTsydCF5MIK7Q8gXOEzC1S9pnmyuiQbXdjLB/4Qx
        xmn7eCupplV+ukHF+Ua++N78TGB6AgY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-IATsXzMENHiQai9JgaNilQ-1; Thu, 23 Jun 2022 14:44:34 -0400
X-MC-Unique: IATsXzMENHiQai9JgaNilQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F9DE3810786;
        Thu, 23 Jun 2022 18:44:34 +0000 (UTC)
Received: from [10.22.9.91] (unknown [10.22.9.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADC48141510C;
        Thu, 23 Jun 2022 18:44:33 +0000 (UTC)
Message-ID: <ab4bcd51-83c5-ae21-ddf6-607a31a7d6ac@redhat.com>
Date:   Thu, 23 Jun 2022 14:44:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH] cpuset: Allow setscheduler regardless of manipulated
 task
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20220623124944.2753-1-mkoutny@suse.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220623124944.2753-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/23/22 08:49, Michal Koutný wrote:
> When we migrate a task between two cgroups, one of the checks is a
> verification that we can modify task's scheduler settings
> (cap_task_setscheduler()).
>
> An implicit migration occurs also when enabling a controller on the
> unified hierarchy (think of parent to child migration). The
> aforementioned check may be problematic if the caller of the migration
> (enabling a controller) has no permissions over migrated tasks.
> For instance, user's cgroup that ends up running a process of a
> different user. Although cgroup permissions are configured favorably,
> the enablement fails due to the foreign process [1].
>
> Change the behavior by relaxing the permissions check on the unified
> hierarchy (or in v2 mode). This is in accordance with unified hierarchy
> attachment behavior when permissions of the source to target cgroups are
> decisive whereas the migrated task is opaque (for contrast, see more
> restrictive check in __cgroup1_procs_write()).
>
> [1] https://github.com/systemd/systemd/issues/18293#issuecomment-831205649
>
> Reasons for RFC:
>
> 1) The unified hierarchy attachment behavior -- is that the
>     right/consented model that migrated objects don't matter?
>
> 2) If 1) is true, have I missed any danger in allowing cpuset'ing a
>     possibly privileged processes?
That could be an issue.

> 2.2) cpuset may be in v2 mode even on v1 hierarchy with different
>     migration control rules (but checking migratee's creds in v1
>     eliminates effect of this patch).
>
> 3) Alternative approach would be to allow cpuset migrations only when
>     nothing effectively changes (which is the case for parent->child
>     migration upon controller enablement).
What do you mean by nothing effectively changes?
>
> 4) This is just idea draft, not tested in the real case.

Since the check is done on a taskset level, if only one of the tasks in 
the taskset fails, the whole taskset fails. Maybe we should consider an 
option for task based migration. So all the tasks that can be migrated 
will be migrated and the rests will be left behind in the original 
cpuset. Just a thought.

Cheers,
Longman

