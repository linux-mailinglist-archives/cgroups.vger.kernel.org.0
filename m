Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF806D4ECD
	for <lists+cgroups@lfdr.de>; Mon,  3 Apr 2023 19:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjDCRTh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Apr 2023 13:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjDCRTg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Apr 2023 13:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93A22115
        for <cgroups@vger.kernel.org>; Mon,  3 Apr 2023 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680542324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9kl6sR8CDHCLHRJZnldn58uw/G4gK2ubpkyUoDgp1A=;
        b=MioaBKWCgeHkpu2RUaIRi9vxNpSvchP05jY3t/53XHCo2hRfDQ7lQNVPvuTh4ytBzhe/fR
        i9CAYmwd8BP90YPHEuPMy/azmBN+OobX8MNeEnBgsAPKitK7fm96C4+FnRYrTSmTTiNBsZ
        9JoMCxRpp9NXvBIElh75yIKb8s3ct7I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-MhGGYRJeNb-Gfs5MyfcpgA-1; Mon, 03 Apr 2023 13:18:43 -0400
X-MC-Unique: MhGGYRJeNb-Gfs5MyfcpgA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E269886463;
        Mon,  3 Apr 2023 17:18:43 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9527492C13;
        Mon,  3 Apr 2023 17:18:42 +0000 (UTC)
Message-ID: <d9f0005c-6825-b2a0-eac3-fcbad6e32b2f@redhat.com>
Date:   Mon, 3 Apr 2023 13:18:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] cgroup/cpuset: Make cpuset_fork() handle
 CLONE_INTO_CGROUP properly
Content-Language: en-US
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230403165523.aphsec2epqi72k27@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 4/3/23 12:55, Michal Koutný wrote:
> On Fri, Mar 31, 2023 at 10:50:43AM -0400, Waiman Long <longman@redhat.com> wrote:
>> By default, the clone(2) syscall spawn a child process into the same
>> cgroup as its parent. With the use of the CLONE_INTO_CGROUP flag
>> introduced by commit ef2c41cf38a7 ("clone3: allow spawning processes
>> into cgroups"), the child will be spawned into a different cgroup which
>> is somewhat similar to writing the child's tid into "cgroup.threads".
>>
>> The current cpuset_fork() method does not properly handle the
>> CLONE_INTO_CGROUP case where the cpuset of the child may be different
>> from that of its parent.  Update the cpuset_fork() method to treat the
>> CLONE_INTO_CGROUP case similar to cpuset_attach().
> Should .can_fork=cpuset_can_fork in analogy to cpuset_can_attach be also
> devised? (Sorry if I missed that in the previous discussion.)

I have thought about that too.

However, the can_attach method checks only a couple of things:

1) PF_NO_SETAFFINITY flag - which won't be set in the case of fork() as 
it is for kthread only.
2) DL bandwidth - Juri has a cpuset outstanding to modify the way this 
check is being done. I want to wait until it is settled before tackling 
this, if necessary.
3) security_task_setscheduler() - the CLONE_INTO_CGROUP code has already 
checked that, we don't need to duplicate the check.

So we don't need a can_fork() check for now.

Cheers,
Longman

