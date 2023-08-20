Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEE7781ED4
	for <lists+cgroups@lfdr.de>; Sun, 20 Aug 2023 18:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjHTQ0X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 12:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjHTQ0W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 12:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13CE11F
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692548687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LTIIx7UvbdXxFhLIfELCeFcfxNRehzpT464zSPyQ1Nc=;
        b=dsiNBXUBOjKDeCbelycL8TBv7gZX8xSqp57aF+AvTiX3rIQCu6qt5jeBSGTcRGk2wWlmeJ
        /xBcfo0diUL/pz9CmGBDyPvxRhGdhZDoUBnexdX/CrQZZfWaZ4ieBfk9WInoITTFZ0uvv1
        FhhX4h6Filr/NMd1du2ojV57NaTU0KA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-KieFKDpHPWS2QniEUA84iw-1; Sun, 20 Aug 2023 12:24:41 -0400
X-MC-Unique: KieFKDpHPWS2QniEUA84iw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8BFE833948;
        Sun, 20 Aug 2023 16:24:40 +0000 (UTC)
Received: from [10.22.16.56] (unknown [10.22.16.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8C7D492C13;
        Sun, 20 Aug 2023 16:24:33 +0000 (UTC)
Message-ID: <883a5a4f-b34e-689c-2fbd-7bf03db532eb@redhat.com>
Date:   Sun, 20 Aug 2023 12:24:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/6] Backport rework of deadline bandwidth restoration for
 5.10.y
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>, stable@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230820152144.517461-1-qyousef@layalina.io>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230820152144.517461-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 8/20/23 11:21, Qais Yousef wrote:
> This is a backport of the series that fixes the way deadline bandwidth
> restoration is done which is causing noticeable delay on resume path. It also
> converts the cpuset lock back into a mutex which some users on Android too.
> I lack the details but AFAIU the read/write semaphore was slower on high
> contention.

Note that it was a percpu rwsem before this patch series. It was not a 
regular rwsem. Percpu rwsem isn't designed to handle high write lock 
contention. A regular rwsem should be similar to mutex in performance 
when handling high write lock contention.

Cheers,
Longman

