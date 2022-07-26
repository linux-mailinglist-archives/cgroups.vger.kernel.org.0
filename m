Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7611758144B
	for <lists+cgroups@lfdr.de>; Tue, 26 Jul 2022 15:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbiGZNi2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jul 2022 09:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbiGZNi1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Jul 2022 09:38:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C61F2FF
        for <cgroups@vger.kernel.org>; Tue, 26 Jul 2022 06:38:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w205so9911791pfc.8
        for <cgroups@vger.kernel.org>; Tue, 26 Jul 2022 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tmctZBFguTrS1b7yrub84YkQuENPO2e8gipTSbzISyU=;
        b=fmzUdvxIgopv0HByWJp3GWf71zq/2KhCxgsN7JSU50LfrTaG85+Izym6Tk8RjqUPns
         7y9QLsMx6dZ0PN/ksMUXgLHVdtm9xer5hIMN2AA760oK2BYKVCmjXEt0VTP8UO4wL4ER
         jpUqUvJqt3XBCs9UUjuBd6lR4T6WE0rgM2zD7qH1B7rNnwfKbwnstYSn3Vg1e2QK4XBP
         odPJhd1ETh9sbQm+nRuVeGJ/zPMUdLwL5O3KhETlMrBsxHTf1vEzUgqPBXLE9aEPXStx
         IA6EKzZinS/QP0aFF246XBW0oeybrj69iPq/6mKd8R6ZMUhJe0P3dn4iyjmrLshA4OxB
         Y56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tmctZBFguTrS1b7yrub84YkQuENPO2e8gipTSbzISyU=;
        b=o7D+xPILwkgP3VWSkrjGnsVVvkQDJx/jvIGHBgI6rLgAajhuNiPme11BB6xOpSQa/5
         DGSQCybyfaHuJHUS+Zvk89EJb4wBqizCEkicl9ItLGZDEP6OkhLsmU7mXMMIsdJBn1yI
         A0Idaqj2GZ2axfEjTKeJV5e1u9wkIYWPHsk7jFxd6fWDZjbgofDmNhSYX9xZ3vGsceSi
         cFCnIZ6ImBwnPMGuYM1uFUZ2wzsToChuRcOlpafI1bDHAnSokCrWXNqIfSk5CbCw+ado
         BWCDJ3SmFYtGt9CBKWeceiw5g+tjGU2mws5xziswIzm7StN3FAXzkWTieA+lTYxpimhV
         ISuA==
X-Gm-Message-State: AJIora+ZbQKp7tomYW3GH7+5pxCWGnuAmDHmeHbCuYhtLUwvjEWsTWSk
        NSQ3mtYTBGHHAx7a2UrifhDaSQ==
X-Google-Smtp-Source: AGRyM1sKKwc2/5jVimHA4KFoctEXf+VN2GAqJ4QW/Q40ygpxpb47Cr3X0l/olLgym997YWYdvQA7ng==
X-Received: by 2002:a63:d847:0:b0:41a:dbc4:ef9e with SMTP id k7-20020a63d847000000b0041adbc4ef9emr11665683pgj.379.1658842705696;
        Tue, 26 Jul 2022 06:38:25 -0700 (PDT)
Received: from [10.5.61.95] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id cp1-20020a170902e78100b0016d2540c098sm11470422plb.231.2022.07.26.06.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:38:25 -0700 (PDT)
Message-ID: <a2bd997b-fc81-ca1c-3d65-99fbd34cfba7@bytedance.com>
Date:   Tue, 26 Jul 2022 21:38:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [External] Re: [PATCH 8/9] sched/psi: add kernel cmdline
 parameter psi_inner_cgroup
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-9-zhouchengming@bytedance.com>
 <Yt7KQc0nnOypB2b2@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Yt7KQc0nnOypB2b2@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/7/26 00:52, Johannes Weiner wrote:
> On Thu, Jul 21, 2022 at 12:04:38PM +0800, Chengming Zhou wrote:
>> PSI accounts stalls for each cgroup separately and aggregates it
>> at each level of the hierarchy. This may case non-negligible overhead
>> for some workloads when under deep level of the hierarchy.
>>
>> commit 3958e2d0c34e ("cgroup: make per-cgroup pressure stall tracking configurable")
>> make PSI to skip per-cgroup stall accounting, only account system-wide
>> to avoid this each level overhead.
>>
>> For our use case, we also want leaf cgroup PSI accounted for userspace
>> adjustment on that cgroup, apart from only system-wide management.
> 
> I hear the overhead argument. But skipping accounting in intermediate
> levels is a bit odd and unprecedented in the cgroup interface. Once we
> do this, it's conceivable people would like to do the same thing for
> other stats and accounting, like for instance memory.stat.

Right, it's a bit odd... We don't use PSI stats in intermediate levels
in our use case, but don't know what other use scenarios are. If they are
useful for other people, this patch can be dropped.

Thanks.

> 
> Tejun, what are your thoughts on this?
