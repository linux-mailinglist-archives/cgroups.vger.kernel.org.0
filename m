Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C804C581425
	for <lists+cgroups@lfdr.de>; Tue, 26 Jul 2022 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiGZN3Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jul 2022 09:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbiGZN3H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Jul 2022 09:29:07 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1FA24974
        for <cgroups@vger.kernel.org>; Tue, 26 Jul 2022 06:29:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w185so13242958pfb.4
        for <cgroups@vger.kernel.org>; Tue, 26 Jul 2022 06:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:date:mime-version:user-agent:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=X3USgpc6XpCOBCdiioCqbAyVXBreMm9Zz3bCF8HFN0g=;
        b=SjllR868hgxEDh9ILkhQcdktay+vVaXMkeGGP/FcsIiRKddZ/zdt4NjkmtQGTwa9tV
         upJUGxh91elveza0mjXq731muQ1YN/CezSCfg+Cl7k415dl37wR3FnyEzzB5tDGm5JXf
         pmLZGUJEYRO8EpJd0kGf3TBGMq2Ei98wTZGN9xGmdO013r8PzAObNIh7F4CK+Uisu3gP
         ZvzTxyhNs9/f65nlKQx8/A0ZmiTErr8SVeVP86X7ui5QPyfAE0AOxyLDqYWOuvdl0kSh
         3zJXGb1sQfillJcV06Rj9XDT97CzfVDFhHuWE9xHUkYNE8dCxBfJe4qTj84CSS0I98Bn
         ZY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=X3USgpc6XpCOBCdiioCqbAyVXBreMm9Zz3bCF8HFN0g=;
        b=SCFCUgXRe6ihAe/nMU/acNuI7bcBNdMq4UeG5/O6VH74y+OeaWlk+IbzwTWrBwW6aY
         MFslsH5+BsE79pPBQGdjcOOdglBFlcU+W+xnJfRm7NQIGVzmSTohNBmNM9Si1lvhkvqY
         jyXQ+HiqXU3Q++r34W5R1fnTAlndCys+iRUozA6wSt0HXC59EMXCOQoDPkhlMkRlN69U
         4/D3DligxCYmUBmrHgTEzsSgZmxhpwi14mN+lDPBCn1Lcr0LvKCv7RYIlv0vcgQl3Tnm
         aGdSGbY98iDBAY+wZm5VqpMlP/Z5Wzfar4i5dT8O/HZ7pxMZ3S84eTutTzvBUjd5k58W
         pp8w==
X-Gm-Message-State: AJIora/dg513mPAUDbzeu5HJWn1Dnv1zUMeka0EW4k2bEAxltgmlcTrq
        RpRHy8AiKyhyXzZ9VJclhML7wg==
X-Google-Smtp-Source: AGRyM1uu96GcKvUEjZ6Zy/FK3UhP0PifS7RpUr/J/t0YTBIVEcqmvmEP5gpE7UlfyshnrKrhZ0P5eA==
X-Received: by 2002:a63:4913:0:b0:40d:8235:2d1c with SMTP id w19-20020a634913000000b0040d82352d1cmr14606268pga.584.1658842145943;
        Tue, 26 Jul 2022 06:29:05 -0700 (PDT)
Received: from [10.5.61.95] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 3-20020a620503000000b005283f9e9b19sm9135375pff.180.2022.07.26.06.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:29:05 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
X-Google-Original-From: Chengming Zhou <chengming.zhou@linux.dev>
Message-ID: <22a889ae-bf61-ff39-5e13-b32c95b77d4a@linux.dev>
Date:   Tue, 26 Jul 2022 21:28:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH 1/9] sched/psi: fix periodic aggregation shut off
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Chengming Zhou <zhouchengming@bytedance.com>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-2-zhouchengming@bytedance.com>
 <Yt65LEyN83mTGxwF@cmpxchg.org>
Content-Language: en-US
In-Reply-To: <Yt65LEyN83mTGxwF@cmpxchg.org>
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

On 2022/7/25 23:39, Johannes Weiner wrote:
> On Thu, Jul 21, 2022 at 12:04:31PM +0800, Chengming Zhou wrote:
>> @@ -871,13 +861,23 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>>  				clear |= TSK_MEMSTALL_RUNNING;
>>  			if (prev->in_iowait)
>>  				set |= TSK_IOWAIT;
>> +
>> +			/*
>> +			 * Periodic aggregation shuts off if there is a period of no
>> +			 * task changes, so we wake it back up if necessary. However,
>> +			 * don't do this if the task change is the aggregation worker
>> +			 * itself going to sleep, or we'll ping-pong forever.
>> +			 */
>> +			if (unlikely((prev->flags & PF_WQ_WORKER) &&
>> +				     wq_worker_last_func(prev) == psi_avgs_work))
>> +				wake_clock = false;
>>  		}
>>  
>>  		psi_flags_change(prev, clear, set);
>>  
>>  		iter = NULL;
>>  		while ((group = iterate_groups(prev, &iter)) && group != common)
>> -			psi_group_change(group, cpu, clear, set, now, true);
>> +			psi_group_change(group, cpu, clear, set, now, wake_clock);
>>  
>>  		/*
>>  		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
> 
> Wait, there is another psi_group_change() below this, which handles
> the clearing of TSK_RUNNING for common ancestors. We don't want to
> wake those either, so it needs s/true/wake_clock/ as well.

Yes, I was wrong, will fix.

Thanks!
