Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB514175A1
	for <lists+cgroups@lfdr.de>; Fri, 24 Sep 2021 15:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345069AbhIXN2M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Sep 2021 09:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344885AbhIXN2C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Sep 2021 09:28:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F0EC0A888B;
        Fri, 24 Sep 2021 06:02:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q23so8810095pfs.9;
        Fri, 24 Sep 2021 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0k4GidOpDOZlh4Z8G1WDVmPhA4Roxd0DMwZbEhyIkW0=;
        b=HmA3vYJrpvO5HCGcY/nOKAYXKJu2tMpAza2IwZBLmiwaBi3bpCiqGsRD2YiJi0Wpqd
         HQxVniQ+PdUJ/RcQQCVgacoFTkaDXsyLkbZ+huAdUO3/QrK756amHJ17LFNDSGW3M6Hf
         pr74o52t++xDu6/0SgJAwWwOuFtCGZzhpKHMCdt9rPK2l9t1f1Q0paQk1c6tjmZbW6Qo
         Fu+3/LqZIprNu82Ub/Appl8ZvLQjaOigNzq+sFA9+BIo4QKiqmEoJCwpIXYe9oX4pCG9
         RNPJPnUKD8MtfuCabWGyYSveEl1ShulzpiXzOk9zZcQsNdyftKW76tGLtf2BG1OFoGbO
         AUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0k4GidOpDOZlh4Z8G1WDVmPhA4Roxd0DMwZbEhyIkW0=;
        b=qnf1o0ReVuGVgAkO1FXZpaF/2zqk5V/9BnIwmScwlQcQz00CrhbLBGg34ikw+/4HIL
         0O6Z7BXzQIgochqJKmqbWHqUOcFQmYy1QosnmZIsencEGR9hQYwKVj190Hgp8ThZgPkr
         I8vwrVOgfckrOINH6tXl0mdDwJ5BTODPTl9Otske8pkHweKnRjTBepSA0jsFWARZDuzA
         PacGLnsNGafBL0yFTWZS1Fah5NjbKRyYL7lByS66PmBXtiXhJkuF3YJT1yYemx/qophN
         tyW7u6BrUXFHu/FXVgJ6mMkvGdalBKQMzxBoHgQH69RSr/BRwuOg7HaudyPQZt+q3nx7
         puCg==
X-Gm-Message-State: AOAM533UAOaCZ+vqbYaagMntP8KF6q62F6w9ePUzFcwW2kSz4p+YaMp0
        xdiBsjy1cppqjbW+87K1DQKe3eCjGkeE0g==
X-Google-Smtp-Source: ABdhPJz9zpVB4OsMX45ZrXC1ocVLVZ3gIGIp3sQBJS7/mWuhM3iTWdSyzvklHfx99GufppPE7an5nw==
X-Received: by 2002:a62:4dc5:0:b0:438:8133:fcef with SMTP id a188-20020a624dc5000000b004388133fcefmr9646405pfb.44.1632488574952;
        Fri, 24 Sep 2021 06:02:54 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.113])
        by smtp.gmail.com with ESMTPSA id x15sm9955227pgt.34.2021.09.24.06.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 06:02:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] mem_cgroup: optimize the atomic count of
 wb_completion
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <1632465983-30525-1-git-send-email-brookxu.cn@gmail.com>
 <YU2boTZhfbo0h/Xi@dhcp22.suse.cz>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <03145735-7764-4cd4-e15b-60402f4b447e@gmail.com>
Date:   Fri, 24 Sep 2021 21:02:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YU2boTZhfbo0h/Xi@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thanks for your time.

Michal Hocko wrote on 2021/9/24 17:34:
> On Fri 24-09-21 14:46:22, brookxu wrote:
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> In order to track inflight foreign writeback, we init
>> wb_completion.cnt to 1. For normal writeback, this cause
>> wb_wait_for_completion() to perform meaningless atomic
>> operations. Since foreign writebacks rarely occur in most
>> scenarios, we can init wb_completion.cnt to 0 and set
>> frn.done.cnt to 1. In this way we can avoid unnecessary
>> atomic operations.
> 
> Does this lead to any measurable differences?

I created multiple cgroups that performed IO on multiple disks, 
then flushed the cache with sync command, and no measurable
differences have been observed so far.

> 
