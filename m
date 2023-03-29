Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2E56CCF83
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 03:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjC2BbO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 21:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjC2BbO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 21:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAA010E5
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 18:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680053427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CspT4SBj2OPAfTD4GX2xH3Q/n47a5hkXe6pVA2r6P70=;
        b=cqR/3z/jV6E7nlWrqMpjJ0LXU8eyWdqLl1SOfFA7czIwSor0TcJsptZmuaUXvq83KPUJJx
        jvg3AfbzN9U5Bm1ed+8lGOzgyiuUhMHDz5iZ1wODbglVDaIllVIEPNc1uf7gtYb9LUmoCd
        pcJbT82w19hPaJk0WL1fQGkZwQO4arU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-CbtxejbKMCSLt1DqU1M2Lw-1; Tue, 28 Mar 2023 21:30:22 -0400
X-MC-Unique: CbtxejbKMCSLt1DqU1M2Lw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F318101A54F;
        Wed, 29 Mar 2023 01:30:21 +0000 (UTC)
Received: from [10.22.18.156] (unknown [10.22.18.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12153202701E;
        Wed, 29 Mar 2023 01:30:21 +0000 (UTC)
Message-ID: <c3d9cf24-1c3a-cda4-5063-6b7d27e9116f@redhat.com>
Date:   Tue, 28 Mar 2023 21:30:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: CLONE_INTO_CGROUP probably needs to call controller attach
 handlers
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, gscrivan@redhat.com
References: <20230328153943.op62j3sw7qaixdsq@wittgenstein>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230328153943.op62j3sw7qaixdsq@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/28/23 11:39, Christian Brauner wrote:
> Hey,
>
> Giuseppe reported that the the affinity mask isn't updated when a
> process is spawned directly into the target cgroup via
> CLONE_INTO_CGROUP. However, migrating a process will cause the affinity
> mask to be updated (see the repro at [1].
>
> I took a quick look and the issue seems to be that we don't call the
> various attach handlers during CLONE_INTO_CGROUP whereas we do for
> migration. So the solution seems to roughly be that we need to call the
> various attach handlers during CLONE_INTO_CGROUP as well when the
> parent's cgroups is different from the child cgroup. I think we need to
> call all of them, can, cancel and attach.
>
> The plumbing here might be a bit intricate since the arguments that the
> fork handlers take are different from the attach handlers.
>
> Christian
>
> [1]: https://paste.centos.org/view/f434fa1a
>
I saw that the current cgroup code already have the can_fork, fork and 
cancel_fork callbacks. Unfortunately such callbacks are not defined for 
cpuset yet. That is why the cpu affinity isn't correctly updated. I can 
post a patch to add those callback functions to cpuset which should then 
able to correctly address this issue.

Cheers,
Longman

