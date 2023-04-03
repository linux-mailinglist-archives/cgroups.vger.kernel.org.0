Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E123F6D4EFD
	for <lists+cgroups@lfdr.de>; Mon,  3 Apr 2023 19:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjDCRat (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Apr 2023 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjDCRas (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Apr 2023 13:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B481980
        for <cgroups@vger.kernel.org>; Mon,  3 Apr 2023 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680543001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1X5SC7LKhlLocmRueF17WE70pwm2bzlUhxp0ZwVzj8=;
        b=IahjsRdFSyItRmLJ+vFswwH48B7vpptoj0v2Q4yXRtFNJrqUUXm/xGzOpvhh2pzP5HFXml
        yFisx8JWHfaeh74pGmp2bb3VZxdvK06BjODSjGRmxR1MlBLTkZLUI+esJDJmhRTgF55Sb3
        ZGcATKjEb6QI6kIjFO1rz/aXD7C457s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-qzZGLCXJNiKX1MnoIJst9w-1; Mon, 03 Apr 2023 13:29:59 -0400
X-MC-Unique: qzZGLCXJNiKX1MnoIJst9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADD7B1C04B69;
        Mon,  3 Apr 2023 17:29:58 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E65A140C6EC4;
        Mon,  3 Apr 2023 17:29:57 +0000 (UTC)
Message-ID: <44843f08-b7c2-42e3-1951-a0c5688190a1@redhat.com>
Date:   Mon, 3 Apr 2023 13:29:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] cgroup/cpuset: Make cpuset_fork() handle
 CLONE_INTO_CGROUP properly
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
References: <20230331145045.2251683-1-longman@redhat.com>
 <20230331145045.2251683-2-longman@redhat.com>
 <20230403165523.aphsec2epqi72k27@blackpad>
 <d9f0005c-6825-b2a0-eac3-fcbad6e32b2f@redhat.com>
In-Reply-To: <d9f0005c-6825-b2a0-eac3-fcbad6e32b2f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 4/3/23 13:18, Waiman Long wrote:
>
> On 4/3/23 12:55, Michal Koutný wrote:
>> On Fri, Mar 31, 2023 at 10:50:43AM -0400, Waiman Long 
>> <longman@redhat.com> wrote:
>>> By default, the clone(2) syscall spawn a child process into the same
>>> cgroup as its parent. With the use of the CLONE_INTO_CGROUP flag
>>> introduced by commit ef2c41cf38a7 ("clone3: allow spawning processes
>>> into cgroups"), the child will be spawned into a different cgroup which
>>> is somewhat similar to writing the child's tid into "cgroup.threads".
>>>
>>> The current cpuset_fork() method does not properly handle the
>>> CLONE_INTO_CGROUP case where the cpuset of the child may be different
>>> from that of its parent.  Update the cpuset_fork() method to treat the
>>> CLONE_INTO_CGROUP case similar to cpuset_attach().
>> Should .can_fork=cpuset_can_fork in analogy to cpuset_can_attach be also
>> devised? (Sorry if I missed that in the previous discussion.)
>
> I have thought about that too.
>
> However, the can_attach method checks only a couple of things:
>
> 1) PF_NO_SETAFFINITY flag - which won't be set in the case of fork() 
> as it is for kthread only.
> 2) DL bandwidth - Juri has a cpuset outstanding to modify the way this 
> check is being done. I want to wait until it is settled before 
> tackling this, if necessary.

BTW, even cloning without CLONE_INTO_CGROUP can be an issue WRT DL 
bandwidth. So I will let the scheduler folk figure out what to do with that.

Cheers,
Longman

