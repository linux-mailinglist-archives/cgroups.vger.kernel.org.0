Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF9D57D8FD
	for <lists+cgroups@lfdr.de>; Fri, 22 Jul 2022 05:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiGVDbC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 23:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVDbB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 23:31:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640961EEF0
        for <cgroups@vger.kernel.org>; Thu, 21 Jul 2022 20:31:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d7so3543186plr.9
        for <cgroups@vger.kernel.org>; Thu, 21 Jul 2022 20:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/6Cb+8ADjWlGk1byx/gAv/ihrtjQyQM76AvewJ6raf0=;
        b=BEcZ5flLoTHKRlHcKGFXMGAK7PHpb1lCc5CBQgqqBDPQZQov25dfqyGsbsOsMv58tC
         UWjpwrPMbpT9fbLDpnXgRFmNstXP+69Ef2iw0cbtTSsGmRVSpa5ezEmPAM9zAdbntHmQ
         vudbUgEwJCcqnJZluroo91MVQykacN2gKArJBnEZD3JkVhIOqU7bGDha8UJ9nZLUeWjw
         TVammewdtB4Ni44XWU8JPxA4Vs7a1tnJuCT6gtRAi9rKZUOKxupeFCKPBQ7q3iitiObT
         fhJbN/aP282dSdyT8SEFzcZKp3w8dJnV7XULvZvmq9IOZAn6IuznR44/ylYwVWiVXr06
         zAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/6Cb+8ADjWlGk1byx/gAv/ihrtjQyQM76AvewJ6raf0=;
        b=ZOhRYFVDoOr5LQVQVmiWuWfDzYZFEUFB/eavs6VrM636MkWXQpBSS//+kSrhixTCad
         M3P8Qp6c1XGo+Fz4RWrZ7LywQh+MzP2HeyCw99c5lLJ1H0/rReXn2ERlIjEwW0Kh1PS1
         bor4xu5nkV1YMaWstMAye0opL7qAmOmiaCGR9WeysukBNS5AfDa4faNPWEqskYrZvnXr
         Uvefq0UFhqLp3VuDI4hygY/ZnsEYaQJYnFERjZ5w6YsLG7wYteQbXWeNWR9NDhs40q1O
         Fs2VW9hL9afog4qzKEmguK+j55ep+bvCaEi+BgavOEtyONWE3MnlSSNttPYg+LzvZ8aa
         TvaA==
X-Gm-Message-State: AJIora/w/mRitqIRk0UOg8eRXprcbzeGdJj328/zKG9GSN8/BshuGJLY
        F4BA9alZ603x7J6+Vwq1N3YxYQ==
X-Google-Smtp-Source: AGRyM1u66qOMhw/FmNyZzsrbRNGdNOEwQPTR6etWVvS2ZFcBdgNrRnpIXpackB09WcUPNKAXdNW/Dw==
X-Received: by 2002:a17:90b:4c4e:b0:1f0:48e7:7258 with SMTP id np14-20020a17090b4c4e00b001f048e77258mr1748828pjb.223.1658460659802;
        Thu, 21 Jul 2022 20:30:59 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id r9-20020aa79889000000b005284d10d8f6sm2538884pfl.215.2022.07.21.20.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 20:30:59 -0700 (PDT)
Message-ID: <65d9f79b-be9b-e21e-0624-5c9f2cc0c0b2@bytedance.com>
Date:   Fri, 22 Jul 2022 11:30:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 9/9] sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, hannes@cmpxchg.org,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-10-zhouchengming@bytedance.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220721040439.2651-10-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Chengming,

On 7/21/22 12:04 PM, Chengming Zhou Wrote:
> Now PSI already tracked workload pressure stall information for
> CPU, memory and IO. Apart from these, IRQ/SOFTIRQ could have
> obvious impact on some workload productivity, such as web service
> workload.
> 
> When CONFIG_IRQ_TIME_ACCOUNTING, we can get IRQ/SOFTIRQ delta time
> from update_rq_clock_task(), in which we can record that delta
> to CPU curr task's cgroups as PSI_IRQ_FULL status.

The {soft,}irq affection should be equal to all the runnable tasks
on that cpu, not only rq->curr. Further I think irqstall is per-cpu
rather than per-cgroup.

Abel
