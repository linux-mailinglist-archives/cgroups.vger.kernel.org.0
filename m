Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A53C6DDB98
	for <lists+cgroups@lfdr.de>; Tue, 11 Apr 2023 15:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDKNEp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 09:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjDKNEo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 09:04:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E27E30EB
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 06:04:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mn5-20020a17090b188500b00246eddf34f6so114049pjb.0
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681218264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZUxjOTN3EEVrgEvX6fomzktb865tnCcQCLiDPcQhKI=;
        b=i5JVHa5eM9KbQAKWODGWgoGm8LPXMSkBcQk0PHI3WSU6doos8dY3Jdj27hKGayaVka
         Nyxor8+0DirCbLUdnpgXe6e/OvT6Y3DNmSlM3KvuyBvNlVvtatXcJt7DQ1oH7wx4x2EI
         rvWneewVZL4FIVDgP7JYRH4AWs8kHIAAhzRlt0xLvFIn+iZHhb6xelC51sIQ9yDi0K1N
         /K9eTKj3lYhrPuxELIq7vLoDzhc1C6WmpDonYb0BJCGPJrx8guObqyAqQDO/RPydGVgV
         EFAvOY83IlO434GmAkUT8YJ6cxeQ8HWch3zrSVBKhuM3ddVPMwAngocF5fsQ9I+luQA1
         njQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681218264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZUxjOTN3EEVrgEvX6fomzktb865tnCcQCLiDPcQhKI=;
        b=YQm16ELvaHveENZXkfnWuiE1TFJLTjkzywIIHjElCUiGDgIL7hbS3+PrY93XmWvv8W
         Na4ITWJvFRcUfFO7ZFjN2YicJNqDw2MPAcPBJftpu9N/9WuTRcZcgheHDiDVVFP+48kq
         /Jzfv9eFgz/TuTy/RXEF7hwL7lG53M+B67wZ/KwSO0VN6ChjoZPaGggyk/VYefidWvL9
         k8bddIq+lfgS8zbtZ0Jwmb3zXQybDEUtAiqkhGR1aR2AtXoUVFI7LQCrJRZNmDdJGX9C
         USb3XA+Hsh4rwBbl12pqNM4G+2hnzcsJ6kQpTUrUXU1Xot2ASpL33NT5WQbBB/v2BAdj
         O/Tg==
X-Gm-Message-State: AAQBX9etwgvtfHMXIh3b+KfQ8EPd5mGYeWVev4+uK0DP8rqFX1ZecvXa
        BaQ6CCvFGVOnD03LhU7Krlck5Q==
X-Google-Smtp-Source: AKy350YwNMjah0OluGNu+/pypB0/gnmcJ/Jr9PqVh9UZDcWB78JzQ8zLBl/fBlxEkTDa9tQFrwPSag==
X-Received: by 2002:a05:6a20:c530:b0:eb:b8:bdc8 with SMTP id gm48-20020a056a20c53000b000eb00b8bdc8mr2482627pzb.57.1681218263733;
        Tue, 11 Apr 2023 06:04:23 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b00625d84a0194sm9826012pff.107.2023.04.11.06.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 06:04:23 -0700 (PDT)
Message-ID: <aa3382b4-4046-988f-42ea-8812dba7882b@bytedance.com>
Date:   Tue, 11 Apr 2023 21:04:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Re: [PATCH v4] mm: oom: introduce cpuset oom
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@suse.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com,
        Zefan Li <lizefan.x@bytedance.com>,
        linux-kernel@vger.kernel.org
References: <20230411065816.9798-1-ligang.bdlg@bytedance.com>
 <3myr57cw3qepul7igpifypxx4xd2buo2y453xlqhdw4xgjokc4@vi3odjfo3ahc>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <3myr57cw3qepul7igpifypxx4xd2buo2y453xlqhdw4xgjokc4@vi3odjfo3ahc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/4/11 20:23, Michal Koutný wrote:
> Hello.
> 
> On Tue, Apr 11, 2023 at 02:58:15PM +0800, Gang Li <ligang.bdlg@bytedance.com> wrote:
>> +	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>> +		if (nodes_equal(cs->mems_allowed, task_cs(current)->mems_allowed)) {
>> +			css_task_iter_start(&(cs->css), CSS_TASK_ITER_PROCS, &it);
>> +			while (!ret && (task = css_task_iter_next(&it)))
>> +				ret = fn(task, arg);
>> +			css_task_iter_end(&it);
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +	cpuset_read_unlock();
>> +	return ret;
>> +}
> 
> I see this traverses all cpusets without the hierarchy actually
> mattering that much. Wouldn't the CONSTRAINT_CPUSET better achieved by
> globally (or per-memcg) scanning all processes and filtering with:

Oh I see, you mean scanning all processes in all cpusets and scanning
all processes globally are equivalent.

> 	nodes_intersect(current->mems_allowed, p->mems_allowed

Perhaps it would be better to use nodes_equal first, and if no suitable
victim is found, then downgrade to nodes_intersect?

NUMA balancing mechanism tends to keep memory on the same NUMA node, and
if the selected victim's memory happens to be on a node that does not
intersect with the current process's node, we still won't be able to
free up any memory.

In this example:

A->mems_allowed: 0,1
B->mems_allowed: 1,2
nodes_intersect(A->mems_allowed, B->mems_allowed) == true

Memory Distribution:
+=======+=======+=======+
| Node0 | Node1 | Node2 |
+=======+=======+=======+
| A     |       |       |
+-------+-------+-------+
|       |       |B      |
+-------+-------+-------+

Process A invoke oom, then kill B.
But A still can't get any free mem on Node0 and 1.

> (`current` triggers the OOM, `p` is the iterated task)
> ?
> 
> Thanks,
> Michal
