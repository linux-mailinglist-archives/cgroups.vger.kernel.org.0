Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE301AC9E2
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2020 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633265AbgDPP2f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Apr 2020 11:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442466AbgDPP2d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Apr 2020 11:28:33 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE43C061A0F
        for <cgroups@vger.kernel.org>; Thu, 16 Apr 2020 08:28:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l78so5987071qke.7
        for <cgroups@vger.kernel.org>; Thu, 16 Apr 2020 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rMGtreOatVEYR4xQ6VveBD3ZVWSgS2maUcU8W3yRfLE=;
        b=rFEynzgFeDpdYxV542CPzFNIhibQUIccPl7/zDGoabrupO/hNa/co4cyDuvDCgMYac
         xXggmGZjBfmkynF5ZwWrrzoEplkuCpqDhpMztPGbgrBy2zlF8uCCrU2Z/tMxwWjnmrry
         u4ml82A3DWaW5w/4uXDWe0SVsnQroiVkEvYmgwckkkJ8u0esLgaymLIz0ZMbJMTXQ9Pv
         6yh8dDq8ttWGYnIwrsqCx/FlwRdSssWs5Sn9NIHvwsNRAR2VcYM1PczxmjzG2gkpf30Z
         XwrFytBiB7osgdp2UOlSVOFF0U/x7pdA94kwna1TwTMDg4Vh0dNKkbbkBVQs8JDBRT2V
         kUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rMGtreOatVEYR4xQ6VveBD3ZVWSgS2maUcU8W3yRfLE=;
        b=qmzysOmB2VT+4ttpubnmyYCHtZyYmQpv3Ua99nQtbYfpiPzEr/Sj4sbhON3T11Sag7
         /3k0uktOqx4YwMf79DS0jVk9ZIq98qnFSBdaMqy7al9CUGb30h7RjYpkN1pgm+5cnkN4
         JQGvfkKLet1uVkpscHkUr1zFfYgv697o/5DoLkmoKtYZfQ1ZTAYQFvppx+vEV7Zoe5SN
         RDHj4n+U8DqwZ07ZD/MYKj3KuLD6BY8rETyC5EFWSII/voV2F5AgZ08w443jzqUwZmef
         ec9SgTgD7AGvj/rlZRL34ebWX3YCRRnt3kfMq4xLee78iOjxo3uM53lmoKwl40MoSsVT
         VBXA==
X-Gm-Message-State: AGi0Pub/AJ/6rpPLmG+PkxHYKCJGv+KQlUtPCzZTaQ/k7WKgfcL6pCqM
        7ig+FML2Lgs84fiBOG0zN6aTGQ==
X-Google-Smtp-Source: APiQypJz4CZcsYAURwShmRlrfrBK99Z4C5EudPpGHD28P1A0CKliH58xqsqe116TmRINxbeHvAnpZw==
X-Received: by 2002:a37:e307:: with SMTP id y7mr22919119qki.420.1587050911999;
        Thu, 16 Apr 2020 08:28:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e623])
        by smtp.gmail.com with ESMTPSA id z18sm16400475qtz.77.2020.04.16.08.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:28:31 -0700 (PDT)
Date:   Thu, 16 Apr 2020 11:28:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v8 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20200416152830.GA195132@cmpxchg.org>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200116215222.GA64230@cmpxchg.org>
 <cdcdb710-1d78-6fac-48d7-35519ddcdc6a@linux.alibaba.com>
 <20200413180725.GA99267@cmpxchg.org>
 <8e7bf170-2bb5-f862-c12b-809f7f7d96cb@linux.alibaba.com>
 <20200414163114.GA136578@cmpxchg.org>
 <54af0662-cbb4-88c7-7eae-f969684025dd@linux.alibaba.com>
 <0bed9f1a-400d-d9a9-aeb4-de1dd9ccbb45@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bed9f1a-400d-d9a9-aeb4-de1dd9ccbb45@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Alex,

On Thu, Apr 16, 2020 at 04:01:20PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/4/15 下午9:42, Alex Shi 写道:
> > Hi Johannes,
> > 
> > Thanks a lot for point out!
> > 
> > Charging in __read_swap_cache_async would ask for 3 layers function arguments
> > pass, that would be a bit ugly. Compare to this, could we move out the
> > lru_cache add after commit_charge, like ksm copied pages?
> > 
> > That give a bit extra non lru list time, but the page just only be used only
> > after add_anon_rmap setting. Could it cause troubles?
> 
> Hi Johannes & Andrew,
> 
> Doing lru_cache_add_anon during swapin_readahead can give a very short timing 
> for possible page reclaiming for these few pages.
> 
> If we delay these few pages lru adding till after the vm_fault target page 
> get memcg charging(mem_cgroup_commit_charge) and activate, we could skip the 
> mem_cgroup_try_charge/commit_charge/cancel_charge process in __read_swap_cache_async().
> But the cost is maximum SWAP_RA_ORDER_CEILING number pages on each cpu miss
> page reclaiming in a short time. On the other hand, save the target vm_fault
> page from reclaiming before activate it during that time.

The readahead pages surrounding the faulting page might never get
accessed and pile up to large amounts. Users can also trigger
non-faulting readahead with MADV_WILLNEED.

So unfortunately, I don't see a way to keep these pages off the
LRU. They do need to be reclaimable, or they become a DoS vector.

I'm currently preparing a small patch series to make swap ownership
tracking an integral part of memcg and change the swapin charging
sequence, then you don't have to worry about it. This will also
unblock Joonsoo's "workingset protection/detection on the anonymous
LRU list" patch series, since he is blocked on the same problem - he
needs the correct LRU available at swapin time to process refaults
correctly. Both of your patch series are already pretty large, they
shouldn't need to also deal with that.
