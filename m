Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F87051D297
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 09:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389721AbiEFH4R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 03:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344647AbiEFH4Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 03:56:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F5367D03
        for <cgroups@vger.kernel.org>; Fri,  6 May 2022 00:52:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w19so11222990lfu.11
        for <cgroups@vger.kernel.org>; Fri, 06 May 2022 00:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=LbwqLZPNjAVAGchFJpgdUXESVOy5RrVk4EawuoFFTlM=;
        b=GZn+Eatwi9msnEaiiuXKK3haDVt8cFLEFeWrtWgkIDrh/sFvPdajeBLE0LV8qTSKOy
         2dpUaZxHUW9ao+Tn/O+xNebjQBfxeeSoe5YgSeolObFLprDooWECch2w3ZxRr+BwubK3
         dm2zLgPdUo4gneJqSKKvrTkL/NtEir4+1p8bguVsn7xPvbt8JU33WbFzbYqx5nvCVY3R
         d5nM7ZsbuFaaGVcztnoDLOH2wFeaMTEs8U2kZ6/f+ZPktivu9km54F5Y3A+46fBmOFib
         PWtdR6uhF5bdavHFiBEv9ek8xuR8xmN+Az5yppLfeFbGOgK75q6RqwP3DnBoCbUCyfgV
         4N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=LbwqLZPNjAVAGchFJpgdUXESVOy5RrVk4EawuoFFTlM=;
        b=WtUMYGGF2+0lFO+EfXsTifrs+EFVr8sejbONOq1qi5ZuOSikyo6sYkd/wH19Ol6xCM
         265g0YLPz/74GcJgJAg5iaXcDLeS+PG5QUDlwHgdh1GMsxBZzrd55YgYwdAMbGUKrgcp
         9n8x2h4axemY04W9UQ7skfsgPPS+kE2x6scfVcxKOO4BPyQtePgRwZiTE0LcQwFzsmmD
         z1407SUdzyNE7yNLUu3N8ymAlxrKTiGh1gHT7pGBd0Ry7W1WU9L3ONQFoL7jeFqhjgTW
         nOQOwg6n2/1yk8laEHjUKWobEj8roLjZOmvWEYJufHu4e6i7OLgnacrxIvat/M8wGD8/
         iG5w==
X-Gm-Message-State: AOAM531bxzW0b8pV1lbOsP9vxR35p+F1fowdV+7D41eOyQGOnTNTUiqm
        u7aMZ3nieI/WahMrACWjzsWdPg==
X-Google-Smtp-Source: ABdhPJyu6pI3KdaS41jgby/EzI6xF/ZRhmlcPU94kpwkrj2/WyirEJqyTMQW+gcy3KZIzGnsvqJTjw==
X-Received: by 2002:a05:6512:b0e:b0:44a:a5a0:f60e with SMTP id w14-20020a0565120b0e00b0044aa5a0f60emr1644981lfu.669.1651823552540;
        Fri, 06 May 2022 00:52:32 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id b4-20020a0565120b8400b0047255d21196sm572848lfv.197.2022.05.06.00.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 00:52:31 -0700 (PDT)
Message-ID: <2b388d09-940e-990f-1f8a-2fdaa9210fa0@openvz.org>
Date:   Fri, 6 May 2022 10:52:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] percpu: improve percpu_alloc_percpu event trace
Content-Language: en-US
From:   Vasily Averin <vvs@openvz.org>
To:     Shakeel Butt <shakeelb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org
References: <8d627f02-183f-c4e7-7c15-77b2b438536b@openvz.org>
In-Reply-To: <8d627f02-183f-c4e7-7c15-77b2b438536b@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/6/22 07:46, Vasily Averin wrote:
> Added bytes_alloc and gfp_flags fields to the output of the
> percpu_alloc_percpu ftrace event. This is required to track
> memcg-accounted percpu allocations.

Perhaps it makes sense to add call_site too...
