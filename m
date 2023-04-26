Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195C36EF3E4
	for <lists+cgroups@lfdr.de>; Wed, 26 Apr 2023 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbjDZMAN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Apr 2023 08:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbjDZMAL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Apr 2023 08:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED59F5B9A
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 04:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682510341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Ai5lSfKqZn05lKJiIckUsbQ62jwMUlauJMlWabJYbM=;
        b=AIQZJyyRkmITgeCpvcovYnqiSu5KY6qH3NMQZGLJJbBSs6E4OuMjTjxMZ+Ok89o7a7l+02
        rAdvSmd7/hHnKyJx2VqovA5LHQvhr9w1WYhnGT12/X9LDwScwqQfJgU/6dPCuQ6mUnUHP7
        j3xWveedecuZ57XW3+InVxjnlkhUs9o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-a7H5eomjOJ6aVaMswbl19A-1; Wed, 26 Apr 2023 07:59:00 -0400
X-MC-Unique: a7H5eomjOJ6aVaMswbl19A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f21e35dc08so15777825e9.2
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 04:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682510339; x=1685102339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ai5lSfKqZn05lKJiIckUsbQ62jwMUlauJMlWabJYbM=;
        b=bgzOOF6hmO1MR5OobhEAGZZ4XeQrPYA2VVljU7XnvYhknoMDAXQtgviuWGkfoADEUp
         49aGZuh9Umt6aZtyZFRFG9PqnY4MUkAe4Ou9TiKUYDfQPgvDNxRiPUmpkjNkj9uS/ZjT
         vqRWy89TBHjBWj1eJaoo1vJUshP2P63qhaKANgqLXjy72qKwpced+moVEHL5KD+KqZZb
         HWbDq0+tKc9KrJ55JeTW95xMXnufV0/KFbtuAPojuBcyuMdtl1UEuc+MEx+xki81+RWy
         8xwqH7qMk+3m+jGg/Ms7uOWw9OpIICxszRzHmLOySF2iEKMBmMHDd7SEC1w5p21qnyP1
         TKlQ==
X-Gm-Message-State: AAQBX9dQYORxe9phHxB3ODsosfFlypHcT5z5XasxbDdafcgYRts3DG6n
        h0oWty1YM6AS375c61iuwC87cTUVWZ0AA1XklpS64gTie6/CD7yYyCctLBBC8EATYr0K0Kgd32P
        G0qGLV5pl/lzbj1zJig==
X-Received: by 2002:a7b:c7cd:0:b0:3f2:549b:3ede with SMTP id z13-20020a7bc7cd000000b003f2549b3edemr5205633wmk.5.1682510338784;
        Wed, 26 Apr 2023 04:58:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350bpjOR6q/pkojb+dwFIXEfQyiM0qxUUh7xSJoZfnYjmzfCOXvLnREJIDHJVves/LLRleOJrug==
X-Received: by 2002:a7b:c7cd:0:b0:3f2:549b:3ede with SMTP id z13-20020a7bc7cd000000b003f2549b3edemr5205621wmk.5.1682510338423;
        Wed, 26 Apr 2023 04:58:58 -0700 (PDT)
Received: from localhost.localdomain ([176.206.13.250])
        by smtp.gmail.com with ESMTPSA id jb12-20020a05600c54ec00b003f17003e26esm21171598wmb.15.2023.04.26.04.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 04:58:58 -0700 (PDT)
Date:   Wed, 26 Apr 2023 13:58:55 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 6/6] cgroup/cpuset: Iterate only if DEADLINE tasks are
 present
Message-ID: <ZEkR/z2bj/LKmzmP@localhost.localdomain>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-7-juri.lelli@redhat.com>
 <20230404200611.smho7hd4sc2qwrgf@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404200611.smho7hd4sc2qwrgf@airbuntu>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 04/04/23 21:06, Qais Yousef wrote:
> On 03/29/23 14:55, Juri Lelli wrote:
> > update_tasks_root_domain currently iterates over all tasks even if no
> > DEADLINE task is present on the cpuset/root domain for which bandwidth
> > accounting is being rebuilt. This has been reported to introduce 10+ ms
> > delays on suspend-resume operations.
> > 
> > Skip the costly iteration for cpusets that don't contain DEADLINE tasks.
> > 
> > Reported-by: Qais Yousef <qyousef@layalina.io>
> > Link: https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > ---
> 
> Wouldn't this be better placed as patch 4? The two fixes from Dietmar look
> orthogonal to me to the accounting problem. But it seems the whole lot needs to
> go to stable anyway, so good to keep them together. Should Dietmar fixes be at
> the end instead of this?

That should be an easy fixing indeed. Dietmar is working on refreshig
his bits.

Thanks for your reviews and tests Qais!

Best,
Juri

