Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0A6EF675
	for <lists+cgroups@lfdr.de>; Wed, 26 Apr 2023 16:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241410AbjDZOcR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Apr 2023 10:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjDZOcM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Apr 2023 10:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81408768F
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682519483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0YRJ7TlPoY9IYDWRjmvki/mO0TL+b3mD3tzGtLzoUc=;
        b=TS6ZybJAbCBYU+OgyzZbZzd/QocAmogIukMjf7KpuUbz/g1EtUVT1CBh2MCEUqLMqx+Zyw
        W49lRq82RLNuxE4VlDrN8+2jRpBWPdUW+L10dTDIhomcYj4v1LevMCuqaj7OJKRKwa9sAp
        nfzzkIixCdxgzshuGmpcjW/uDw5rxRc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-nkGmRtJvMFW7UfTk2qISGg-1; Wed, 26 Apr 2023 10:31:15 -0400
X-MC-Unique: nkGmRtJvMFW7UfTk2qISGg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94f7a2b21fdso836181166b.2
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 07:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682519472; x=1685111472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0YRJ7TlPoY9IYDWRjmvki/mO0TL+b3mD3tzGtLzoUc=;
        b=PO0GxTn+jXexTeClFeTbzTwSzPAq6ZkNxRiJdfJdF/ZPa+e6UJA/aezEbCxZkm/+BU
         0h5OUR5qIaOM1zjtqmQRpAGSh+9AoFK7/E+dQftTrk85S+4TVg0D2tDKDIRUDoYbH42v
         FdxOegcyiHwKfKEgNGUoRHJ1lt22zjskrg9fIZpCQtyaQU63AR1ycyU2TfOaKsXOkZLX
         5fo092niYf9g7vrOcagoj3JVNsI2pddEmmMgK8JcQWtHXXyz+7P+rEY/8mgRsavkDDJV
         Lv2peCesjINdaBFGksD7hGbHm3YxBvD0n/kZj1qTLFlX0sBZ5HfmcpM7ze+mN8hubUhV
         DBfw==
X-Gm-Message-State: AAQBX9d+5pBHcQaBHgnYjlt04kBfbmvT4MAG6y+YA1RemhAp9cn6H9b0
        PvJP1XfDdah/0qmR+Bg4TSrPwtkFZUrc1ZvCAH5yTyGBgbK/DaqBRLfy3E1ET4QGsuWLDhufIZd
        vt+a+R9S7rsJ3OLRRiQ==
X-Received: by 2002:a17:906:5904:b0:94f:928a:af0f with SMTP id h4-20020a170906590400b0094f928aaf0fmr16872074ejq.47.1682519471930;
        Wed, 26 Apr 2023 07:31:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350a2Qx33w3mXxDNQvaU4xmScsVwPkVRXikQ4mXYM/czaQyeimOaj9xmuUVq8rnQ075JBB24M3A==
X-Received: by 2002:a17:906:5904:b0:94f:928a:af0f with SMTP id h4-20020a170906590400b0094f928aaf0fmr16872030ejq.47.1682519471458;
        Wed, 26 Apr 2023 07:31:11 -0700 (PDT)
Received: from [192.168.0.198] (host-82-53-138-176.retail.telecomitalia.it. [82.53.138.176])
        by smtp.gmail.com with ESMTPSA id gj19-20020a170906e11300b0095ec8dfc439sm1548225ejb.166.2023.04.26.07.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 07:31:10 -0700 (PDT)
Message-ID: <10fdfdd8-06bc-0f35-0fea-e604aa5c103a@redhat.com>
Date:   Wed, 26 Apr 2023 16:31:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/6] sched/cpuset: Bring back cpuset_mutex
To:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        mathieu.poirier@linaro.org, cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-3-juri.lelli@redhat.com>
 <fa585497-5c6d-f0ed-bdda-c71a81d315ad@redhat.com>
 <ZEkRq9iGkYP/8T5w@localhost.localdomain>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <ZEkRq9iGkYP/8T5w@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/26/23 13:57, Juri Lelli wrote:
> On 04/04/23 13:31, Waiman Long wrote:
>> On 3/29/23 08:55, Juri Lelli wrote:
>>> Turns out percpu_cpuset_rwsem - commit 1243dc518c9d ("cgroup/cpuset:
>>> Convert cpuset_mutex to percpu_rwsem") - wasn't such a brilliant idea,
>>> as it has been reported to cause slowdowns in workloads that need to
>>> change cpuset configuration frequently and it is also not implementing
>>> priority inheritance (which causes troubles with realtime workloads).
>>>
>>> Convert percpu_cpuset_rwsem back to regular cpuset_mutex. Also grab it
>>> only for SCHED_DEADLINE tasks (other policies don't care about stable
>>> cpusets anyway).
>>>
>>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>> I am thinking that maybe we should switch the percpu rwsem to a regular
>> rwsem as there are cases where a read lock is sufficient. This will also
>> avoid the potential PREEMPT_RT problem with PI and reduce the time it needs
>> to take a write lock.
> I'm not a big fan of rwsems for reasons like
> https://lore.kernel.org/lkml/20230321161140.HMcQEhHb@linutronix.de/, so
> I'd vote for a standard mutex unless we have a strong argument and/or
> numbers.

+1

-- Daniel

