Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4464783A1A
	for <lists+cgroups@lfdr.de>; Tue, 22 Aug 2023 08:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjHVGjx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Aug 2023 02:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjHVGjw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Aug 2023 02:39:52 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Aug 2023 23:39:46 PDT
Received: from out-13.mta0.migadu.com (out-13.mta0.migadu.com [91.218.175.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D69E9
        for <cgroups@vger.kernel.org>; Mon, 21 Aug 2023 23:39:46 -0700 (PDT)
Message-ID: <3ac6b49e-f605-6f8f-ba22-a411269cb818@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692685909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkmheFjFxExaCu9L5a48Fws0uehvzL2G5MIM97l1kY8=;
        b=QMPCPA7FLfHqCiIiLXVPW69lDGE0fSXD2eJYvbjXmXmsgFpE/SjABJKQ/WbI6jyP0vVU8P
        QOGjpKqk+XX2DeE0jyNCysjqWaFWXWicyMZJZNtpMuoMcDIBQmB4q0Lp76NINGsMS2M+Pm
        15JKLKEgl8zodMWAv3PMCxJ8/bcy5tc=
Date:   Tue, 22 Aug 2023 14:31:41 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4] mm: oom: introduce cpuset oom
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gang Li <gang.li@linux.dev>
To:     Michal Hocko <mhocko@suse.com>, Waiman Long <longman@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com,
        Zefan Li <lizefan.x@bytedance.com>,
        linux-kernel@vger.kernel.org, gang.li@linux.dev
References: <20230411065816.9798-1-ligang.bdlg@bytedance.com>
 <ZDVwaqzOBNTpuR1w@dhcp22.suse.cz>
 <9ba0de31-b9b8-fb10-011e-b24e9dba5ccd@linux.dev>
In-Reply-To: <9ba0de31-b9b8-fb10-011e-b24e9dba5ccd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 2023/8/17 16:40, Gang Li wrote:
> On 2023/4/11 22:36, Michal Hocko wrote:
>> I believe it still wouldn't hurt to be more specific here.
>> CONSTRAINT_CPUSET is rather obscure. Looking at this just makes my head
>> spin.
>>          /* Check this allocation failure is caused by cpuset's wall 
>> function */
>>          for_each_zone_zonelist_nodemask(zone, z, oc->zonelist,
>>                          highest_zoneidx, oc->nodemask)
>>                  if (!cpuset_zone_allowed(zone, oc->gfp_mask))
>>                          cpuset_limited = true;
>> > Does this even work properly and why? prepare_alloc_pages sets
>> oc->nodemask to current->mems_allowed but the above gives us
>> cpuset_limited only if there is at least one zone/node that is not
>> oc->nodemask compatible. So it seems like this wouldn't ever get set
>> unless oc->nodemask got reset somewhere. This is a maze indeed.Is there
> 
> In __alloc_pages:
> ```
> /*
>   * Restore the original nodemask if it was potentially replaced with
>   * &cpuset_current_mems_allowed to optimize the fast-path attempt.
>   */
> ac.nodemask = nodemask;
> page = __alloc_pages_slowpath(alloc_gfp, order, &ac);
> 
> ```
> 
> __alloc_pages set ac.nodemask back to mempolicy before call
> __alloc_pages_slowpath.
> 
> 
>> any reason why we cannot rely on __GFP_HARWALL here? Or should we
> 
> In prepare_alloc_pages:
> ```
> if (cpusets_enabled()) {
>      *alloc_gfp |= __GFP_HARDWALL;
>      ...
> }
> ```
> 
> Since __GFP_HARDWALL is set as long as cpuset is enabled, I think we can
> use it to determine if we are under the constraint of CPUSET.
> 

We have two nodemasks: one from the parameters of __alloc_pages and
another from cpuset. If the node allowed by the parameters of
__alloc_pages is not allowed by cpuset, it means that this page
allocation is constrained by cpuset, and thus CONSTRAINT_CPUSET can be
returned.

I guess this piece of code is reasonable and we can keep the
code as it is.

Thanks,
Gang Li.
