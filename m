Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380BC4BA55E
	for <lists+cgroups@lfdr.de>; Thu, 17 Feb 2022 17:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbiBQQGI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Feb 2022 11:06:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiBQQGG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Feb 2022 11:06:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2937D29C12D
        for <cgroups@vger.kernel.org>; Thu, 17 Feb 2022 08:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645113950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8C5mBTF/zQPiu7mRTQ0V1X+3+5OQ4DWAsdzOSei6/I=;
        b=g0/DkOjF130rSLL0p9nt5505Y/iggj+13Tzt4sfNyOz/3X4rjSLPiNKNyZFolR9QqMVaa8
        nQ/dVp9CScKvddp+4umIV9KQELbcV7X3b81qf2qDxshcoySmCKlIMhH+Rq9tIwHYsf7pOM
        6wc0NE72ghfjO/qbzvcwh0T/XrAnELI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-AC0NT4jMPtGBQ2c5x5SYAg-1; Thu, 17 Feb 2022 11:05:49 -0500
X-MC-Unique: AC0NT4jMPtGBQ2c5x5SYAg-1
Received: by mail-wm1-f71.google.com with SMTP id f26-20020a7bc8da000000b0037bd7f39dbbso1031711wml.3
        for <cgroups@vger.kernel.org>; Thu, 17 Feb 2022 08:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q8C5mBTF/zQPiu7mRTQ0V1X+3+5OQ4DWAsdzOSei6/I=;
        b=42Xhhk7iWAwyASsJAd0dtlDsmvtrSkDHcdefiNR9pWIMJKTVVlpQi4pg+mMkEzmPX9
         kIB0zorTvqwpyVjK0oIUNw6wRdOem5st8uJHEaNXIGFtnRbasKy+7402WsqXhCQ0IG1m
         0ZyF2x5ah1fAzPSvbEZiTRszsl+H9/+EOLv4VLrgxHZsxCEVuzLVodRV4EQYA2aWkN2t
         KQvmRCh4rdEH33N9D9uRHiiDTwWsHSdyQ1PDuK7SiwpLHTLGVmmI7Y0bCQayBBRjpaKU
         7GngJU3dOkkzG2RWl61dFboycSKIzzCTs+YswI7La0B2LCzJI7xuf5BVk1KHglNEF2Mq
         HMuw==
X-Gm-Message-State: AOAM531EIDDjJfC4JCv12BJKWmJkgzesAHJE9sC5rWPjNKAJfuydVJcb
        eq7mMZGIJJFTg67DNTmfshLJSkAiPtDNBVSoxvynnWC+IqNFGkVumYXNeygG3rNsutagf/lU72F
        iqiNj1DTP63+lkuETJQ==
X-Received: by 2002:adf:e78a:0:b0:1e6:3524:e135 with SMTP id n10-20020adfe78a000000b001e63524e135mr2961067wrm.601.1645113947653;
        Thu, 17 Feb 2022 08:05:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVqs24c8i2D8Lt4f9Z4iNheHvxgXvMVn69Wevb7xDbVFxS55ujEEr2K1D18VYZWPyWeX53MQ==
X-Received: by 2002:adf:e78a:0:b0:1e6:3524:e135 with SMTP id n10-20020adfe78a000000b001e63524e135mr2961045wrm.601.1645113947428;
        Thu, 17 Feb 2022 08:05:47 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id c17sm1579430wmh.31.2022.02.17.08.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 08:05:46 -0800 (PST)
Message-ID: <3113f00a-e910-2dfb-479f-268566445630@redhat.com>
Date:   Thu, 17 Feb 2022 17:05:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] KVM: Move VM's worker kthreads back to the original
 cgroup before exiting.
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Vipin Sharma <vipinsh@google.com>, seanjc@google.com
Cc:     kbuild-all@lists.01.org, mkoutny@suse.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, dmatlack@google.com,
        jiangshanlai@gmail.com, kvm@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217061616.3303271-1-vipinsh@google.com>
 <202202172046.GuW8pHQc-lkp@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <202202172046.GuW8pHQc-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/17/22 13:34, kernel test robot wrote:
>> 5859		reattach_err = cgroup_attach_task_all(current->real_parent, current);

This needs to be within rcu_dereference().

Paolo

>    5860		if (reattach_err) {
>    5861			kvm_err("%s: cgroup_attach_task_all failed on reattach with err %d\n",
>    5862				__func__, reattach_err);
>    5863		}
>    5864		return err;
>    5865	}
>    5866	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

