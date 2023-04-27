Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819066F0084
	for <lists+cgroups@lfdr.de>; Thu, 27 Apr 2023 07:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbjD0FyW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Apr 2023 01:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0FyW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Apr 2023 01:54:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB10B35A5
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 22:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682574821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TACSMy7Ug2sStH4pdeuOCgf93fUckqHIu/mqCYHofQw=;
        b=BExXH43zl/lMYtMnqZ0Gwm5AbDjCLKnqu/VOISxih+bqLuXw9gU7aHjiWZYk9eXDFS9bsq
        k8+VPn8C3y5409KO+DHR1cz7ITJhcmXSbmfpDBiLGNjYKtNRv/flVv8rUOVnqrDMcJ/tfU
        Rf1sIjm50WVEYEvOVkiqf+CW7uv6avw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-oDuiuRcYNSqoCZsvLsPUUQ-1; Thu, 27 Apr 2023 01:53:38 -0400
X-MC-Unique: oDuiuRcYNSqoCZsvLsPUUQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ef25aaeb5bso54395581cf.3
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 22:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682574817; x=1685166817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TACSMy7Ug2sStH4pdeuOCgf93fUckqHIu/mqCYHofQw=;
        b=Yrv3apfoBVN2SNN2CPlmJCAlAQn4wBhpiG8OXCRxVL42lm3OirW16IiN8r1u6wWKmN
         RvVaJgXztELYe5RIYNQZkwQ7ZaNFbDY3UMPb/7tYJyCXCkdWml+AkIa3jegTdtb8vxFU
         xjeOUyNe/IeoRDtOOQLmLtU98cq4EwP6WMnZLpHmIacmwpK7v9a4JPvJ0EBznRxa7l0E
         /u65M9XOK73ZBzYc2J1h3FqKCmDlFNG5DTldkRZ4v8FVurVCb6deZ28DrRmNEDYqes45
         PYpBnm4SgY0dhnZvrtGNRbhThZvmoiq9jVtQ1JQcve1FKBoQKvDXtq5rv6vDafc5+Pa/
         UM6Q==
X-Gm-Message-State: AC+VfDxdwVcYLzp60bP6bCvtYz024f/d1M7DLD2nxnioHXQorawkugHz
        Scil+jcvb1mHjo0xQ0IJ4g+ZhDUcu4jwdItm3wDuB/SLeUySTMKCQTBMYq+pVQ1M85q0dA0TpzT
        coxk4ZBIQbwLaO31rxA==
X-Received: by 2002:a05:622a:654:b0:3ef:5ec1:dab3 with SMTP id a20-20020a05622a065400b003ef5ec1dab3mr525101qtb.30.1682574817509;
        Wed, 26 Apr 2023 22:53:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4j6nF3w+Z8LmcylCbGKc5D5+oYOrfLipDhTKW/WdKR3wbjN7mgXy+G02OxwfvQJQwd+S5TJA==
X-Received: by 2002:a05:622a:654:b0:3ef:5ec1:dab3 with SMTP id a20-20020a05622a065400b003ef5ec1dab3mr525086qtb.30.1682574817237;
        Wed, 26 Apr 2023 22:53:37 -0700 (PDT)
Received: from localhost.localdomain ([176.206.13.250])
        by smtp.gmail.com with ESMTPSA id gd21-20020a05622a5c1500b003f0af201a2dsm1921750qtb.81.2023.04.26.22.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 22:53:36 -0700 (PDT)
Date:   Thu, 27 Apr 2023 07:53:27 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
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
        Sudeep Holla <sudeep.holla@arm.com>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        zhiguo.niu@uniissoc.com
Subject: Re: [PATCH 2/6] sched/cpuset: Bring back cpuset_mutex
Message-ID: <ZEoN1wq47uhE201p@localhost.localdomain>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-3-juri.lelli@redhat.com>
 <fa585497-5c6d-f0ed-bdda-c71a81d315ad@redhat.com>
 <ZEkRq9iGkYP/8T5w@localhost.localdomain>
 <d53a8af3-46e7-fe6e-5cdd-0421796f80d2@redhat.com>
 <CAB8ipk-ns=d+jNkKi1sjkSQmQidziCj34COkHZt6ZkRiG47HHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk-ns=d+jNkKi1sjkSQmQidziCj34COkHZt6ZkRiG47HHA@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 27/04/23 10:58, Xuewen Yan wrote:
> HI Juri,
> 
> Would this patch be merged tobe stable-rc? In kernel5.15, we also find
> that the rwsem would be blocked for a long  time, when we change the
> task's cpuset cgroup.
> And when we revert to the mutex, the delay would disappear.

Honestly, I'm not sure. This change is mostly improving performance, but
it is also true that it's fixing some priority inheritance corner cases.
So, I'm not sure it qualifies for stable, but it would be probably good to
have it there.

Thanks,
Juri

