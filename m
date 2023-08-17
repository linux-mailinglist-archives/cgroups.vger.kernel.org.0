Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E9277F272
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 10:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346022AbjHQItm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Aug 2023 04:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349151AbjHQIte (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Aug 2023 04:49:34 -0400
X-Greylist: delayed 517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 01:49:32 PDT
Received: from out-41.mta1.migadu.com (out-41.mta1.migadu.com [95.215.58.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23D51BE7
        for <cgroups@vger.kernel.org>; Thu, 17 Aug 2023 01:49:32 -0700 (PDT)
Message-ID: <9ba0de31-b9b8-fb10-011e-b24e9dba5ccd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692261651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIphj18RtSktOChYllHuu9FMoXo0StpvUC/Vo4hk6Xc=;
        b=YoBZrjACVksy7EYTvMwTn/K0VhdgDsK1M9FMSZYMJ2ji5UPgut5HZmPHbNhafQHl9OVfRz
        hutBe++EfG9ZTsLKVWqvz45nyDwaBBdqTcSBVJQZxhkor7Bdr+Oqmg58p50bHfR9dy1AkI
        zpiGdJyUq2jAD+qB2jRuuxdP/waMHIg=
Date:   Thu, 17 Aug 2023 16:40:46 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4] mm: oom: introduce cpuset oom
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com,
        Zefan Li <lizefan.x@bytedance.com>,
        linux-kernel@vger.kernel.org
References: <20230411065816.9798-1-ligang.bdlg@bytedance.com>
 <ZDVwaqzOBNTpuR1w@dhcp22.suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gang Li <gang.li@linux.dev>
In-Reply-To: <ZDVwaqzOBNTpuR1w@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Apologize for the extremely delayed response. I was previously occupied
with work unrelated to the Linux kernel.

On 2023/4/11 22:36, Michal Hocko wrote:
> I believe it still wouldn't hurt to be more specific here.
> CONSTRAINT_CPUSET is rather obscure. Looking at this just makes my head
> spin.
>          /* Check this allocation failure is caused by cpuset's wall function */
>          for_each_zone_zonelist_nodemask(zone, z, oc->zonelist,
>                          highest_zoneidx, oc->nodemask)
>                  if (!cpuset_zone_allowed(zone, oc->gfp_mask))
>                          cpuset_limited = true;
> > Does this even work properly and why? prepare_alloc_pages sets
> oc->nodemask to current->mems_allowed but the above gives us
> cpuset_limited only if there is at least one zone/node that is not
> oc->nodemask compatible. So it seems like this wouldn't ever get set
> unless oc->nodemask got reset somewhere. This is a maze indeed.Is there

In __alloc_pages:
```
/*
  * Restore the original nodemask if it was potentially replaced with
  * &cpuset_current_mems_allowed to optimize the fast-path attempt.
  */
ac.nodemask = nodemask;
page = __alloc_pages_slowpath(alloc_gfp, order, &ac);

```

__alloc_pages set ac.nodemask back to mempolicy before call
__alloc_pages_slowpath.


> any reason why we cannot rely on __GFP_HARWALL here? Or should we

In prepare_alloc_pages:
```
if (cpusets_enabled()) {
	*alloc_gfp |= __GFP_HARDWALL;
	...
}
```

Since __GFP_HARDWALL is set as long as cpuset is enabled, I think we can
use it to determine if we are under the constraint of CPUSET.

But I have a question: Why we always set __GFP_HARDWALL when cpuset is
enabled, regardless of the value of cpuset.mem_hardwall?


Thanks,
Gang Li
