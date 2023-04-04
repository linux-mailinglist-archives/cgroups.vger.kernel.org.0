Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA096D64F8
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbjDDOOf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbjDDOOb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 10:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519DE422D
        for <cgroups@vger.kernel.org>; Tue,  4 Apr 2023 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680617575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHnav7rmFyKZwzKMs7eXEGCo+lHgh/MyPZc+xhNZR/U=;
        b=JCNXS+4l+0Ei1UeH67M6gWdNsxSw7u/YXFGrBymLVcx6ndZca13B89z3zzanKMWHu6feeP
        dj4xsWu6kmOTuGj0h2Pk1bL1WdKyxwyYSLwG1Pxsz/quVU2C13zcPN+OY5KG8Y5vM+aEzH
        P9OFvya3cMUeXciyqsEJaMF3sF3n5XU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-eBD4KOx6P-yw9rbEwUxkLg-1; Tue, 04 Apr 2023 10:12:50 -0400
X-MC-Unique: eBD4KOx6P-yw9rbEwUxkLg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E61553C10EC6;
        Tue,  4 Apr 2023 14:12:49 +0000 (UTC)
Received: from [10.22.32.153] (unknown [10.22.32.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FCCE492C14;
        Tue,  4 Apr 2023 14:12:49 +0000 (UTC)
Message-ID: <db9689cb-7d2b-8a76-06f4-271134dd1bfb@redhat.com>
Date:   Tue, 4 Apr 2023 10:12:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] cgroup/cpuset: Allow only one active attach operation
 per cpuset
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
 <20230331145045.2251683-4-longman@redhat.com>
 <20230403164736.lpjdpzxxnjlpxrqv@blackpad>
 <24b67530-62ce-4f9c-7b74-d41d2ccc710e@redhat.com>
 <20230404090737.3g3uxga52bojgdu5@blackpad>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230404090737.3g3uxga52bojgdu5@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 4/4/23 05:07, Michal Koutný wrote:
> Hi.
>
> On Mon, Apr 03, 2023 at 01:41:33PM -0400, Waiman Long <longman@redhat.com> wrote:
>> This patch is actually not related to the CLONE_INTO_GROUP problem in patch
>> 1. It is a generic problem when multiple users are moving threads into
>> cgroup.threads of the same or different cpusets simultaneously.
> I meant this:
> 	__cgroup_procs_write
> 	  cgroup_kn_lock_live
> 	    mutex_lock(&cgroup_mutex)
>
> and (more succintly)
> 	cgroup_update_dfl_csses
> 	  lockdep_assert_held(&cgroup_mutex)
>
> Even the threaded migrations should be synchronized here.
> Can you please explain in more detail what's the problematic case?

You are right. I missed the cgroup_mutex synchronization here. So this 
patch isn't needed. I will drop it in the next version.

Cheers,
Longman

