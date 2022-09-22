Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3935E69CE
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiIVRll (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 13:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiIVRlg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 13:41:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18556EFA48;
        Thu, 22 Sep 2022 10:41:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so3148035pjq.3;
        Thu, 22 Sep 2022 10:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=YTw4/4H1DrZyYT8r3vAbsU7ElPYxgVDhU3+OM9JyucE=;
        b=ElLCbl1NZGRXMxpT6v5xRjFMH5pVD8Cb811OWdYBmSUbw6+6INd7SgCM411RdFKg2D
         3gBBwooCUeu9bguTScSkm/XZSKCxDniYvdgWCIhnkKXa/dj/aqMoxUdDf/Z4g4Z3Uyxz
         fJktrerUAVeMdfLrhHHvN0kbmKSsQmUR4AfFzNTL/auXAiED8nOxCign4vgffb5wAAha
         ODjUE/FYzl39vEFJ1jKVo1TaQdQR//fsoXDGhh7myPCV/CZ20tcFNpmeDfdQNQeVatLo
         Q6WOHGCkKXqSy8yRccfb+uwAOH7duIQ8LnHnLiFE59louwT8ra/ug4luSqNxIhGSaQle
         b8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YTw4/4H1DrZyYT8r3vAbsU7ElPYxgVDhU3+OM9JyucE=;
        b=V2HLaggexGwvc31+4BvmRIWl+0T6Z1XhW9NWT1U+/DA1RcG0SkW4ms6CJ9NjC1pu9p
         tjE6ekeYxMstIl2QW6q9wAJap0P8JBGB8w7rRgx9760AdaVDDOTSomXnSnVDs8MOwLum
         wGNX1PVsSRLcecCXucmd8syS0cDwc1MP0DQdPAyVwruWoRzeKUmYgEfX2EN6re04ym4B
         WAR6i5ZJCCDPN3xG0u4pIUuTLZQRwkAz5Mey9Q89VNVOjQqaCS/LZL/RkGa+LY95V/23
         75uzCBjoPw+3oc/aeH9wqLg77sj2B7gSnavmVBfFDP7+Y13vsrIH29XpU0pUCV53SNZt
         HgRg==
X-Gm-Message-State: ACrzQf2D71n+0kDGnXNauMmyUYn0HmHQdAnrTbF+FXenebFChG8ZFvlU
        MhGTBZLWg7mvedZzEGAwO742UqOMNqi+cA==
X-Google-Smtp-Source: AMsMyM46RQnmrtmArNIqRDGJepiXlLiVqEbR8tjp1VE8FwEn++T4TpusHiOcNrt//9HfQThYvL4t+w==
X-Received: by 2002:a17:902:e54b:b0:178:75b9:f1e9 with SMTP id n11-20020a170902e54b00b0017875b9f1e9mr4426028plf.104.1663868492316;
        Thu, 22 Sep 2022 10:41:32 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x128-20020a623186000000b0053e6eae9665sm4800874pfx.140.2022.09.22.10.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 10:41:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 22 Sep 2022 07:41:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [RFC PATCH 00/20] Add Cgroup support for SGX EPC memory
Message-ID: <YyyeSVSk/lWdo/W4@slm.duckdns.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922171057.1236139-1-kristen@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

(cc'ing memcg folks)

On Thu, Sep 22, 2022 at 10:10:37AM -0700, Kristen Carlson Accardi wrote:
> Add a new cgroup controller to regulate the distribution of SGX EPC memory,
> which is a subset of system RAM that is used to provide SGX-enabled
> applications with protected memory, and is otherwise inaccessible.
> 
> SGX EPC memory allocations are separate from normal RAM allocations,
> and is managed solely by the SGX subsystem. The existing cgroup memory
> controller cannot be used to limit or account for SGX EPC memory.
> 
> This patchset implements the sgx_epc cgroup controller, which will provide
> support for stats, events, and the following interface files:
> 
> sgx_epc.current
> 	A read-only value which represents the total amount of EPC
> 	memory currently being used on by the cgroup and its descendents.
> 
> sgx_epc.low
> 	A read-write value which is used to set best-effort protection
> 	of EPC usage. If the EPC usage of a cgroup drops below this value,
> 	then the cgroup's EPC memory will not be reclaimed if possible.
> 
> sgx_epc.high
> 	A read-write value which is used to set a best-effort limit
> 	on the amount of EPC usage a cgroup has. If a cgroup's usage
> 	goes past the high value, the EPC memory of that cgroup will
> 	get reclaimed back under the high limit.
> 
> sgx_epc.max
> 	A read-write value which is used to set a hard limit for
> 	cgroup EPC usage. If a cgroup's EPC usage reaches this limit,
> 	allocations are blocked until EPC memory can be reclaimed from
> 	the cgroup.

I don't know how SGX uses its memory but you said in the other message that
it's usually a really small portion of the memory and glancing the code it
looks like its own page aging and all. Can you give some concrete examples
on how it's used and why we need cgroup support for it? Also, do you really
need all three control knobs here? e.g. given that .high is only really
useful in conjunction with memory pressure and oom handling from userspace,
I don't see how this would actually be useful for something like this.

Thanks.

-- 
tejun
