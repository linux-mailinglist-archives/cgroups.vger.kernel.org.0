Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B463AA93D
	for <lists+cgroups@lfdr.de>; Thu, 17 Jun 2021 04:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhFQC7e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Jun 2021 22:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230043AbhFQC7c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Jun 2021 22:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623898645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DAFQKb5VrgrYV0k/wY/7SUmNCOTFhI8VI1aGDC5iIO8=;
        b=AP8T6SHQDGeFomIdbb08DwtDjya1XrU912FCSbcvr+nxCOcnfhNSjWIk+2ADqaVyljqOzs
        DL50lDaRJLdZDgrdZAN4WVX+s/v9Ll9ax8hQJFcrVMrzyNlJgYzKKLPrRoNeM/l8nDVyxn
        CyubUrjBOi9sicPhXVplhOuJ80PlV7A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-zlUr7ZUrN7alu2kALZN2XQ-1; Wed, 16 Jun 2021 22:57:23 -0400
X-MC-Unique: zlUr7ZUrN7alu2kALZN2XQ-1
Received: by mail-wr1-f70.google.com with SMTP id y12-20020adffa4c0000b0290119c11bd29eso2290552wrr.2
        for <cgroups@vger.kernel.org>; Wed, 16 Jun 2021 19:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DAFQKb5VrgrYV0k/wY/7SUmNCOTFhI8VI1aGDC5iIO8=;
        b=fZdcGrHm2+0sUS6H1ypv4Z7KvdtCyBjj+7Ib0YbAcJ4WgkuD4bErzTckCmozdM/QrQ
         bDnj4APnXVh5jfHTHBuJxGdXsdUuhfztTh+n/q7MnXsRj2PsNFSvuJuDldjavNcii5YM
         oHhnj2lEPKrbGbcSgDIdtnAObxuWBToDee7w8OZGk/lqmoEH+fA/KaK8FNgZhtd+Su48
         SwDWMO9apezpgqkFHDaInKyTcnXoIdGNpEd01ruzv5TGDTZxIWNxZGujOp4Rrc+GAV/J
         vnZBSbKpd0+TObBIVAyLSbXybUJue7z41Oz8AuN5hYkYRmnIK80Wq0bawbTtNfQxf2hF
         8QmQ==
X-Gm-Message-State: AOAM5319I/nwTCV5HBzTx2Gmcqr3Z/ny+AEndvh3cniYLcJwUfwccT5E
        bWsR0esVv0kXWXGW5e+0HYMpffWkNOzJDXp0v87bqJLE3Vcp6MiQe0EDbakF4VagQjJc6w+GrP6
        KLOlhOpV4quBi3aGPUQ==
X-Received: by 2002:adf:fa08:: with SMTP id m8mr2588907wrr.319.1623898642537;
        Wed, 16 Jun 2021 19:57:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCrsdMs441mSf9ppOn+tdXQjRSYRgSoQKu8IvgKpu90SjG1vEtnx9wN6BEODI05JDaMf9R/Q==
X-Received: by 2002:adf:fa08:: with SMTP id m8mr2588889wrr.319.1623898642332;
        Wed, 16 Jun 2021 19:57:22 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id x7sm3933291wrn.3.2021.06.16.19.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 19:57:21 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/5] cgroup/cpuset: Add new cpus.partition type with no
 load balancing
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20210603212416.25934-1-longman@redhat.com>
 <20210603212416.25934-3-longman@redhat.com>
 <YMpjbCWpSDIz4bHt@slm.duckdns.org>
Message-ID: <557d7fdb-5dae-11e1-4f82-ae9f4334c06a@redhat.com>
Date:   Wed, 16 Jun 2021 22:57:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YMpjbCWpSDIz4bHt@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/16/21 4:47 PM, Tejun Heo wrote:
> Hello,
>
> Generally looks fine to me.
>
> On Thu, Jun 03, 2021 at 05:24:13PM -0400, Waiman Long wrote:
>> @@ -1984,12 +1987,31 @@ static int update_prstate(struct cpuset *cs, int val)
>>   			goto out;
>>   
>>   		err = update_parent_subparts_cpumask(cs, partcmd_enable,
>> -						     NULL, &tmp);
>> +						     NULL, &tmpmask);
>> +
>>   		if (err) {
>>   			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
>>   			goto out;
>> +		} else if (new_prs == PRS_ENABLED_NOLB) {
>> +			/*
>> +			 * Disable the load balance flag should not return an
>                                   ^ing
>
> and "else if" after "if (err) goto out" block is weird. The two conditions
> don't need to be tied together.

Yes, the else part is redundant in this case. Will remove it.


>
>> @@ -2518,6 +2547,9 @@ static int sched_partition_show(struct seq_file *seq, void *v)
>>   	case PRS_ENABLED:
>>   		seq_puts(seq, "root\n");
>>   		break;
>> +	case PRS_ENABLED_NOLB:
>> +		seq_puts(seq, "root-nolb\n");
>> +		break;
>>   	case PRS_DISABLED:
>>   		seq_puts(seq, "member\n");
>>   		break;
>> @@ -2544,6 +2576,8 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
>>   		val = PRS_ENABLED;
>>   	else if (!strcmp(buf, "member"))
>>   		val = PRS_DISABLED;
>> +	else if (!strcmp(buf, "root-nolb"))
>> +		val = PRS_ENABLED_NOLB;
>>   	else
>>   		return -EINVAL;
> I wonder whether there's a better name than "root-nolb" because nolb isn't
> the most readable and we are using space as the delimiter for other names.
> Would something like "isolated" work?

Right. "isolated" is a better name and it corresponds better with the 
isolcpus kernel command line option. Will change the name.

Thanks,
Longman

