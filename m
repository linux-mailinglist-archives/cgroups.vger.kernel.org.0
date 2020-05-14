Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057671D2DCC
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2020 13:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgENLFD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 May 2020 07:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgENLFD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 May 2020 07:05:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB21C061A0C;
        Thu, 14 May 2020 04:05:02 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so12306969pjb.3;
        Thu, 14 May 2020 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZMXJJmn4oIa+JQJYqBoFnxPMqQn52lyOsqRLxMD4w8M=;
        b=dOXhUBHkmcRcqC6sZCJHlAmTMHFYPALmKXWIC7fdx6azSSyt1YVXktUWn7/BrnQ2QS
         eBpbHXGT0bwSzLEXpB4eWFBTl8AWd7qE582wwQEJmtdrrwyYPbY9lz4Sr//I5F6EPyJb
         vT+EfPkP/ISnItuSOf4UM76jnCZO/rHDFqxVfhXOxWIaVqZC3XxTvCpsBLsP8SGw/RHa
         bilmMONguFO/cjHo99nsLV7sQpHe/uBCbdGlxMWeK+r7KRm1Us6aszBgcpD6GIkGIlkD
         2t6WZUTUlJgUx4f+O1rm85EnM2Os64rvrHme0ErrsjYw2+3z5nlED3VtZS5KbH9xWsih
         YIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZMXJJmn4oIa+JQJYqBoFnxPMqQn52lyOsqRLxMD4w8M=;
        b=Hg3+4rd9vTl1Za7VT2+60KmHkgamKYxYvqs8T9eF2w48m+vObaMlsJaajCPLSg6J7N
         UzjL/HWyKUffRNBITEMG0Unbe70jO94BxOBugafOMlGmkuL2XrXA0xh9ihRdYK5jha2I
         zjmlu1vi3vL2HHO5XpxhJOl3kkiFIY8i8izxbnJKTaRyBuQbRsAW91OZC08Eu0Ms8r9w
         RbONHP8+5wzsz6oNU8uI/b+CbFYYXdV5aR/aBiGPyV4kBgzeWKLUKxw9trWmvugxEtwK
         k9psMmqpWc+U7NFgvcqLzSJf9++P97cogkE68zTcfG9xKLwVA9eCsva7/apO5SbCZSGx
         Pt1g==
X-Gm-Message-State: AOAM53122TqEqpJ3HJo31Y2L5lDwRbsG412MeqOjme9sTgoZzFlGc2Mr
        EfjYnKZGPoQTwehb3TGyBJE=
X-Google-Smtp-Source: ABdhPJzP6ABAznnkwvc7vzJ57R61MSe09PVbObJ/HjbmtVoC4vT66gTy1Vivmscp0dwyra37/1hnng==
X-Received: by 2002:a17:902:7c97:: with SMTP id y23mr3349987pll.231.1589454302354;
        Thu, 14 May 2020 04:05:02 -0700 (PDT)
Received: from [192.168.68.125] ([210.185.116.244])
        by smtp.gmail.com with ESMTPSA id a6sm2095533pfk.159.2020.05.14.04.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 04:05:00 -0700 (PDT)
Subject: Re: [PATCH 00/19 V2] mm: memcontrol: charge swapin pages on
 instantiation
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200513113032.GA93568@dev-dsk-sblbir-1c-a524888b.ap-northeast-1.amazon.com>
 <20200513123545.GB488426@cmpxchg.org>
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <f6a474e3-b491-dbf2-c404-f04999b039ff@gmail.com>
Date:   Thu, 14 May 2020 21:04:53 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513123545.GB488426@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 13/5/20 10:35 pm, Johannes Weiner wrote:
> As a result, the memcg gets a breakdown for memory.stat without having
> to have private knowledge of what a page cache page is - how to test
> it, when it's safe to test it, whether there can be huge pages in the
> page cache, etc. pp. Memcg can focus on counting bytes, and the VM
> code that is specialized in dealing with the page cache (or anon
> pages, or shmem pages) can fill in those kinds of details for us.
> 
> Less dependencies, less duplication, simpler API rules.
> 
> The memory.stat output is the same, it's just much simpler code.

Makes sense! Thanks, I should spend some time to re-read all of the memcontrol.c code :)

Balbir Singh.
