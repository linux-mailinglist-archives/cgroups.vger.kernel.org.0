Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4A51D37F
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 10:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbiEFIl0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 04:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbiEFIlZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 04:41:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783BD1FA4A
        for <cgroups@vger.kernel.org>; Fri,  6 May 2022 01:37:43 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id t25so8449572ljd.6
        for <cgroups@vger.kernel.org>; Fri, 06 May 2022 01:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aBTMT471I9stUbpF2UehdHUpsXmRCKk3eSoYzUSJuAk=;
        b=CzymT0keOAYq12hGiC9tdUPQ+0cbAR90o88Qaqegg+N9B43VyAFIxespm3LzMUVyio
         buGgFfOdndcJv+JlqyjTo6csz3qIr8IrXGbque9gxX6eB/WwKvysxFqnIsSJ3+n1txdw
         oqttcvlX/H50Jy+OQp2sk9DjEjxmPYusG9gOF+uwE74MXlduAS5Uh0GNTguObFy+l+M7
         Rw3tdHe2g/k5IljLNqdhHU90r92CBV7/v5jJa6X0G5EM4agu91pZoDdGy9R9bQKawB+f
         dKCYNoJyk+PeBe6AmMQ+3xnKwiddLgAQaCUCZUYf+duZb7t5B+m2+ubZ1xnHvsUjLAZT
         iMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aBTMT471I9stUbpF2UehdHUpsXmRCKk3eSoYzUSJuAk=;
        b=dqPPCNp9v6ajCofWHdwwhiO5sbCfrdSmz4MOjROMHgDcf2twjfkW8rSrhqg/OwMyrG
         odxAtuMO9FOpW3nM77PCXR/TtEkT2FOD5Fdv6AkcZ+akH8efZd09G5uIr1U8Hwu9o3nJ
         qXDVmavS8k515rVO5ABwNu2XDCnezMUV/erP8xyHRpPswiFktfiSWPZqmTKxvxW2tHO/
         2va8tfgh/3adyY03suUZgmYJEMTXLHReco0Pk0VVyqcYo6IfaFFqcv4xXmpYV9ZQ/2fS
         BIWemyLXPD3Obl2gPdtEyE6B6RnM5oa89SSBudLvAhDHITWOQwJ+Mrkg5IF0X9LA/wkd
         utHw==
X-Gm-Message-State: AOAM533uCCk0NlIyUAwV8IKdce5DVzHHLK5wKlpZgACE2TfI6j48NdLY
        r7SlsUfvrZbvncDT0jFhFH0w5Cewqkr79v9h
X-Google-Smtp-Source: ABdhPJzMuT19wgcsc6rd68Jx5RXNq7aryoQ/BwgKtYwBkrQmhjany5+obcXU2zmzKrWTjcPv40Whbg==
X-Received: by 2002:a2e:8692:0:b0:24f:c81:5d63 with SMTP id l18-20020a2e8692000000b0024f0c815d63mr1377913lji.517.1651826261838;
        Fri, 06 May 2022 01:37:41 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id g20-20020a056512119400b0047255d211fesm585120lfr.301.2022.05.06.01.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 01:37:41 -0700 (PDT)
Message-ID: <1aa4cd22-fcb6-0e8d-a1c6-23661d618864@openvz.org>
Date:   Fri, 6 May 2022 11:37:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: kernfs memcg accounting
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
References: <7e867cb0-89d6-402c-33d2-9b9ba0ba1523@openvz.org>
 <20220427140153.GC9823@blackbody.suse.cz>
 <7509fa9f-9d15-2f29-cb2f-ac0e8d99a948@openvz.org>
 <YnBLge4ZQNbbxufc@blackbook>
 <52a9f35b-458b-44c4-7fc8-d05c8db0c73f@openvz.org>
 <20220504141001.GA10890@blackbody.suse.cz>
 <65244222-02c5-6e8d-7f4b-83651f378ce2@openvz.org>
 <20220505094704.GB10890@blackbody.suse.cz>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220505094704.GB10890@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/5/22 12:47, Michal Koutný wrote:
> On Thu, May 05, 2022 at 12:16:12AM +0300, Vasily Averin <vvs@openvz.org> wrote:
>> I think it should allocate at least 2 pages.
> 
> After decoding kmalloc_type(), I agree this falls into a global
> (unaccouted) kmalloc_cache.
> 
>> However if cgroup_mkdir() calls mem_cgroup_alloc() it correctly account huge percpu
>> allocations but ignores neighbour multipage allocation.
> 
> So, the spillover is bound and proportional to memcg limit (same ration
> like these two sizes).
> But it may be better to account it properly, especially if it's
> contribution form an offlined mem_cgroup.

I've traced mkdir /sys/fs/cgroup/vvs.test on 4cpu VM with Fedora 
and self-complied upstream kernel, see table with results below.
These calculations are not precise, it depends on kernel config options,
number of cpus, enabled controllers, ignores possible page allocations etc
However I think this is enough to clarify the general situation.

Results:
- Total sum of accounted memory is ~60Kb.
- Accounted only 2 huge percpu allocation marked '=', ~18Kb.
  (and can be 0 without memory controller)
- kernfs nodes and iattrs are among the main memory consumers.
   they are marked '++' to be accounted first
- cgroup_mkdir always allocates 4Kb,
   so I think it should be accounted first too.
- mem_cgroup_css_alloc allocations consumes 10K,
   it's enough to be accounted, especially for VMs with 1-2 CPUs
- Almost all other allocations are quite small and can be ignored.
  Exceptions are percpu allocations in alloc_fair_sched_group(),
   this can consume a significant amount of memory on nodes
   with multiple processors.
   marked by '+', can be accounted later.
- kernfs nodes consumes ~6Kb memory inside simple_xattr_set() 
   and simple_xattr_alloc(). This is quite high numbers,
   but is not critical, and I think we can ignore it at the moment.
- If all proposed memory will be accounted it gives us ~47Kb, 
   or ~75% of all allocated memory.

Any comments are welcome.

Thank you,
	Vasily Averin

number	bytes	$1*$2	sum	note	call_site
of	alloc
allocs
------------------------------------------------------------
1       14448   14448   14448   =       percpu_alloc_percpu:
1       8192    8192    22640   ++      (mem_cgroup_css_alloc+0x54)
49      128     6272    28912   ++      (__kernfs_new_node+0x4e)
49      96      4704    33616   ?       (simple_xattr_alloc+0x2c)
49      88      4312    37928   ++      (__kernfs_iattrs+0x56)
1       4096    4096    42024   ++      (cgroup_mkdir+0xc7)
1       3840    3840    45864   =       percpu_alloc_percpu:
4       512     2048    47912   +       (alloc_fair_sched_group+0x166)
4       512     2048    49960   +       (alloc_fair_sched_group+0x139)
1       2048    2048    52008   ++      (mem_cgroup_css_alloc+0x109)
49      32      1568    53576   ?       (simple_xattr_set+0x5b)
2       584     1168    54744           (radix_tree_node_alloc.constprop.0+0x8d)
1       1024    1024    55768           (cpuset_css_alloc+0x30)
1       1024    1024    56792           (alloc_shrinker_info+0x79)
1       768     768     57560           percpu_alloc_percpu:
1       640     640     58200           (sched_create_group+0x1c)
33      16      528     58728           (__kernfs_new_node+0x31)
1       512     512     59240           (pids_css_alloc+0x1b)
1       512     512     59752           (blkcg_css_alloc+0x39)
9       48      432     60184           percpu_alloc_percpu:
13      32      416     60600           (__kernfs_new_node+0x31)
1       384     384     60984           percpu_alloc_percpu:
1       256     256     61240           (perf_cgroup_css_alloc+0x1c)
1       192     192     61432           percpu_alloc_percpu:
1       64      64      61496           (mem_cgroup_css_alloc+0x363)
1       32      32      61528           (ioprio_alloc_cpd+0x39)
1       32      32      61560           (ioc_cpd_alloc+0x39)
1       32      32      61592           (blkcg_css_alloc+0x6b)
1       32      32      61624           (alloc_fair_sched_group+0x52)
1       32      32      61656           (alloc_fair_sched_group+0x2e)
3       8       24      61680           (__kernfs_new_node+0x31)
3       8       24      61704           (alloc_cpumask_var_node+0x1b)
1       24      24      61728           percpu_alloc_percpu:
