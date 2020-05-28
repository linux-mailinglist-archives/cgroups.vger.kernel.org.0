Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D1E1E6BA0
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 21:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406776AbgE1Tsg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 15:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406731AbgE1Tsf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 15:48:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A6CC08C5C7
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 12:48:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q11so545047wrp.3
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2+YFw/wWl/gn1xFnRRoYscp8dj86Zd6xiRRZw5MlcAI=;
        b=tqHUV/QEgE202z+GHgPg+fGlRS0xZIz4uyNfmy01XYON7v71D5ZVVMVzwMsmXRUNCI
         +wNnZXjkMRgh04H+0uTAJCwfBZkoEkVZ2TXn4uuWhvn/5WhRwgj7zAmDEeqDyjIBwvFQ
         0yUVIbbFUXGJfXQzBRIqhjggve4tOXbOWWNl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2+YFw/wWl/gn1xFnRRoYscp8dj86Zd6xiRRZw5MlcAI=;
        b=ZRHWZ5K5NMcxZEVFQHfFOCPtbSSPQhmGGnDWWl+BdwpPK7bWUfyu5VZHfrLeSi5+YH
         gJsGg6U1VD39pBrjIiFk8j38jloL4/32uqE6jhUrcodNDqOEVnrqf3jP30IlpcLwfLGU
         jJECi//Tk2pF6VDIJBI8sPJg9IR45SUWiSbplwSqqd9vEu66S4005OYB3WcInIL3g0OS
         zXvlvVz5ARj4xvqNeFgW3crrBTXR7n3E9gHkgudMQOTOQ8eGF/mZNgvJQbEeCerZ1h3f
         RrddtFaAzCXs4M8l37IIO1vCoGvji9X5HvAoRzh9CaCgFVUdToK8QmWTjI/TQoPuQZr8
         +wRw==
X-Gm-Message-State: AOAM533btEU9hI8v/vJfXoB/JQmiLETCm5ZrT0SxbslLipL9HzjG+TM7
        ByezQdCAf6SsmwVLJ0viEkT1Rw==
X-Google-Smtp-Source: ABdhPJwbCOVC5ocul7Wfmi+oZbpyKXkSi2NcpQnG2t0XZ9mSJ4faNZIYvWaeTEZWugouk/oUeG8yXQ==
X-Received: by 2002:adf:a283:: with SMTP id s3mr4706803wra.147.1590695312615;
        Thu, 28 May 2020 12:48:32 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id l204sm8225768wmf.19.2020.05.28.12.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:48:32 -0700 (PDT)
Date:   Thu, 28 May 2020 20:48:31 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200528194831.GA2017@chrisdown.name>
References: <20200520143712.GA749486@chrisdown.name>
 <CALvZod7rSeAKXKq_V0SggZWn4aL8pYWJiej4NdRd8MmuwUzPEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALvZod7rSeAKXKq_V0SggZWn4aL8pYWJiej4NdRd8MmuwUzPEw@mail.gmail.com>
User-Agent: Mutt/1.14.2 (2020-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Shakeel Butt writes:
>What was the initial reason to have different behavior in the first place?

This differing behaviour is simply a mistake, it was never intended to be this 
deviate from what happens elsewhere. To that extent this patch is as much a bug 
fix as it is an improvement.

>>  static void high_work_func(struct work_struct *work)
>> @@ -2378,16 +2384,20 @@ void mem_cgroup_handle_over_high(void)
>>  {
>>         unsigned long penalty_jiffies;
>>         unsigned long pflags;
>> +       unsigned long nr_reclaimed;
>>         unsigned int nr_pages = current->memcg_nr_pages_over_high;
>
>Is there any benefit to keep current->memcg_nr_pages_over_high after
>this change? Why not just use SWAP_CLUSTER_MAX?

I don't feel strongly either way, but current->memcg_nr_pages_over_high can be 
very large for large allocations.

That said, maybe we should just reclaim `max(SWAP_CLUSTER_MAX, current - high)` 
for each loop? I agree that with this design it looks like perhaps we don't 
need it any more.

Johannes, what do you think?
