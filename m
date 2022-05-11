Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1338C522B87
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 07:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiEKFMB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 01:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiEKFMA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 01:12:00 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EE5E6B69
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 22:11:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a30so1091407ljq.9
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 22:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FsqMLvYhC8qarZmsr+129u+7sKwrIH+JPr+bFWl7+5k=;
        b=0aG7kU3eWAaKIv/Td9eRJ5q6oW+7HIa6nEf1s1DtvmoURqmTGUjIfod6WyVpZrOLQG
         edcTzONtr1MlDcl4mYXZXlsIlXhzvwUxwe7+C22rF9/+P8fccOBzqemsYOYv9io4jg/Q
         ZgiPvF/qI3UxE9/Jabe8hGdEibI51Ou1/0olIozn+yzyLafL/VSUFC/vqkEt/EM112RX
         JZcFcxwbJrUGmZwAYuNCS4ajsGwlkMVLFLO0ecCSpRxV5PwCaCzILghm/8EO5CELGx8d
         qxMOR0ACQ4+iZMB4bvvnZ73gAsuc+A36M7mRsYxpGgDt2PYVqARDUdyhG0vim6eZh8WI
         nPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FsqMLvYhC8qarZmsr+129u+7sKwrIH+JPr+bFWl7+5k=;
        b=wCNGujKF4zG+ukl09bD7LT6nVhhbFmhENA9AymppzsytrmZdM9jilZNjF7Naj7HuzI
         h1TaIlkTElc2Af1sRmFcwNcPX0Vg6ZBCeXameaXN5q42OXNbETpIdlje5AMx0HVAy2kD
         WBpJTOPyBBxCtOXfRys4kTFwBq95SWJv6n61/ZlRuCnLvlW06ZfaHvG/hHzmJeMmkmCm
         kHPVlgPyuXqSSpnUuguySeznfxEypVwqP3H1ahDAPa8WPMo/r1rOnk0Cxz2VhuAFKw4u
         FaSUeEuaSZyffXOuRVMy1eUmjq/8bigDPTjZWGRSbb1YPLi+m3XmylJuxGYtdO+umWOJ
         w/jQ==
X-Gm-Message-State: AOAM532uwG36nFE/jqQEYMtAmIMwi0YNLzS6tx46V997ASJrDY2Wohxy
        jvo198TCafwSzy4pKfOY98obfw==
X-Google-Smtp-Source: ABdhPJylxFLXHgGKD6Y69ipptaIp6insZc80YMZOxk6lThbPjMk/dpJzdxb/LCLLOqmDJlv2iM02fw==
X-Received: by 2002:a2e:9ecb:0:b0:24b:4e2a:a555 with SMTP id h11-20020a2e9ecb000000b0024b4e2aa555mr15778281ljk.149.1652245916570;
        Tue, 10 May 2022 22:11:56 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id m3-20020ac24283000000b0047255d210f4sm119249lfh.35.2022.05.10.22.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 22:11:56 -0700 (PDT)
Message-ID: <30a47b4e-7c4b-cd2d-998d-cfaf8d12d342@openvz.org>
Date:   Wed, 11 May 2022 08:11:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] percpu: improve percpu_alloc_percpu event trace
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org
References: <2b388d09-940e-990f-1f8a-2fdaa9210fa0@openvz.org>
 <a07be858-c8a3-7851-9086-e3262cbcf707@openvz.org> <YnsgbXKiNNSF+1ZO@carbon>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YnsgbXKiNNSF+1ZO@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/11/22 05:33, Roman Gushchin wrote:
> On Fri, May 06, 2022 at 10:29:25PM +0300, Vasily Averin wrote:
>>  TRACE_EVENT(percpu_alloc_percpu,
>>  
>> -	TP_PROTO(bool reserved, bool is_atomic, size_t size,
>> -		 size_t align, void *base_addr, int off, void __percpu *ptr),
>> +	TP_PROTO(unsigned long call_site,
>> +		 bool reserved, bool is_atomic, size_t size,
>> +		 size_t align, void *base_addr, int off,
>> +		 void __percpu *ptr, size_t bytes_alloc, gfp_t gfp_flags),
> 
> Don't we want to preserve the order and add the call_site at the end?
> Trace events are not ABI, but if we don't have a strong reason to break it,
> I'd preserve the old order.

I checked recent trace patches and found that order changes is acceptable.

commit 8c39b8bc82aafcc8dd378bd79c76fac8e8a89c8d
Author: David Howells <dhowells@redhat.com>
Date:   Fri Jan 14 11:44:54 2022 +0000

    cachefiles: Make some tracepoint adjustments

-           TP_printk("o=%08x i=%lx e=%d",
-                     __entry->obj, __entry->ino, __entry->error)
+           TP_printk("o=%08x dB=%lx B=%lx e=%d",
+                     __entry->obj, __entry->dino, __entry->ino, __entry->error)

On the other hand I'm agree to keep old order by default.
that's why I added bytes_alloc and gfp_flags to end of output.
However I think call_site is an exception. In all cases found, 
call_site is output first.
For me personally it simplified output parsing.

So I would like to know Steven's position on this question.

Thank you,
	Vasily Averin
