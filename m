Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9546D63FB
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 15:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbjDDNxu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 09:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbjDDNxg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 09:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624D0469E
        for <cgroups@vger.kernel.org>; Tue,  4 Apr 2023 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680616361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2t022cV29B7Zbre5ZWJdAks4cSokwANFRg/jjQH6iKk=;
        b=G7VgNnALgbtc0CFUe4mF4BKXu9j0ctywryY0kk37/GM6KUpS27tIXZEdDdGAhqLhIQI6iN
        dReeTAbsTyYalZMlYdXOmvOobtFl96pBrZH/vGCFHrS+q3/ZbXZumN9EDeASKHGXI8q0dk
        RRSxcXwT9iTj3slavdCIodRxJXpnKrU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-12iwtGryPiqol-iNg5cCTw-1; Tue, 04 Apr 2023 09:52:39 -0400
X-MC-Unique: 12iwtGryPiqol-iNg5cCTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F4463855561;
        Tue,  4 Apr 2023 13:52:38 +0000 (UTC)
Received: from [10.22.32.153] (unknown [10.22.32.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3BF82166B26;
        Tue,  4 Apr 2023 13:52:37 +0000 (UTC)
Message-ID: <a01585bc-03f8-e32c-ac46-99ac484a5e5d@redhat.com>
Date:   Tue, 4 Apr 2023 09:52:37 -0400
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
 <d9f0005c-6825-b2a0-eac3-fcbad6e32b2f@redhat.com>
 <20230404091953.tcu3zg7npstk3ztc@blackpad>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230404091953.tcu3zg7npstk3ztc@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 4/4/23 05:19, Michal Koutný wrote:
> On Mon, Apr 03, 2023 at 01:18:42PM -0400, Waiman Long <longman@redhat.com> wrote:
>> 1) PF_NO_SETAFFINITY flag - which won't be set in the case of fork() as it
>> is for kthread only.
>> 2) DL bandwidth - Juri has a cpuset outstanding to modify the way this check
>> is being done. I want to wait until it is settled before tackling this, if
>> necessary.
> BTW what about CLONE_INTO_CGROUP where the target cpuset has empty
> effective cpuset?
Good point. That will require a can_fork() method then. I will look into 
that.
>
>> 3) security_task_setscheduler() - the CLONE_INTO_CGROUP code has already
>> checked that, we don't need to duplicate the check.
> Not sure what this refers to.
It is just checking of the task the has privilege of running into that 
cgroup.
>
>> So we don't need a can_fork() check for now.
> Anyway, good breakdown. Could you please add it to the commit message
> too?

Yes, I can put that into the commit log.

Cheers,
Longman

> Regards,
> Michal

