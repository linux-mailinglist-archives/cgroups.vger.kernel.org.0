Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AF068CB9C
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 02:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBGBBs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 20:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjBGBBr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 20:01:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5942ED76
        for <cgroups@vger.kernel.org>; Mon,  6 Feb 2023 17:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675731659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXqw41zJAY6Fl3i7sZ9FDkyQtJd0VRXI/SNzWbqT0Bw=;
        b=Ixpi9vJfE2X42945DHYJe/zP3y/qifzPPT+jUdct7YDcnJI0XPWr374Ni1un54QYqhS5hd
        xyPGRzDC86+9QVDRTUCmvr5BOi2uyR+8xsd08g5pipA0JMmxuKBUkTTQtzPnKOb8GqvlxU
        8cf+nL9306IA4i4QZeWvdMxKP71uZJY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-MisY_-TcPtyqLVDHujBbpQ-1; Mon, 06 Feb 2023 20:00:56 -0500
X-MC-Unique: MisY_-TcPtyqLVDHujBbpQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 949893C0F22C;
        Tue,  7 Feb 2023 01:00:55 +0000 (UTC)
Received: from [10.22.18.235] (unknown [10.22.18.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E687492B21;
        Tue,  7 Feb 2023 01:00:54 +0000 (UTC)
Message-ID: <24668a43-fb00-5240-6072-230c5f5d0943@redhat.com>
Date:   Mon, 6 Feb 2023 20:00:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@nvidia.com, jhubbard@nvidia.com, tjmercier@google.com,
        hannes@cmpxchg.org, surenb@google.com, mkoutny@suse.com,
        daniel@ffwll.ch, "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org>
 <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
 <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/6/23 17:39, Yosry Ahmed wrote:
> On Mon, Feb 6, 2023 at 2:36 PM Tejun Heo <tj@kernel.org> wrote:
>> On Mon, Feb 06, 2023 at 02:32:10PM -0800, Yosry Ahmed wrote:
>>> I guess it boils down to which we want:
>>> (a) Limit the amount of memory processes in a cgroup can be pinned/locked.
>>> (b) Limit the amount of memory charged to a cgroup that can be pinned/locked.
>>>
>>> The proposal is doing (a), I suppose if this was part of memcg it
>>> would be (b), right?
>>>
>>> I am not saying it should be one or the other, I am just making sure
>>> my understanding is clear.
>> I don't quite understand what the distinction would mean in practice. It's
>> just odd to put locked memory in a separate controller from interface POV.
> Assume we have 2 cgroups, A and B. A process in cgroup A creates a
> tmpfs file and writes to it, so the memory is now charged to cgroup A.
> Now imagine a process in cgroup B tries to lock this memory.
> - With (a) the amount of locked memory will count toward's cgroup A's
> limit, because cgroup A is charged for the memory.
> - With (b) the amount of locked memory will count toward's cgroup B's
> limit, because a process in cgroup B is locking the memory.
>
> I agree that it is confusing from an interface POV.

If it should not be part of the memcg, does it make sense to make it a 
resource in the existing misc controller? I believe we don't want a 
proliferation of new cgroup controllers.

Cheers,
Longman

