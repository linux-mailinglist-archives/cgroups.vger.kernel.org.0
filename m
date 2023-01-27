Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FBE67E3E1
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 12:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjA0Lnp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 06:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjA0LnY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 06:43:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DAD78AF0;
        Fri, 27 Jan 2023 03:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674819728; x=1706355728;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=++zl8Fr1gHaHdEpfDVW0NPiIeaWIfdHRn3Gz0GJc96k=;
  b=CroYin7l+6Ktf9um5WHFiX/DDqxDBCBUGEkoGHzeuCcsgHBCbBdDJbgo
   JiCVArXLobonklB8UMB9w0yyAxueehHcsHgHppGQZ0P6iNlwW/lko5Aes
   jvLSLzqMuh+iEKyaPz55O4gvathrFoJpgGbjz/Y9pWIBZs/9czhQVT76t
   L0kAx6f/vCBGBxR0+X+jWkMS6iNYQWFQV7UYg0K1JUxWCYljSeXUQtt5c
   zvXUNOBaU/N2ErME+JR1QV9yRICTaU+KQ+nco6pg2cYo6hiGw9vw7U8Ee
   w2t1oe4SgS7blw0TguMKrk50ggdWlodwjQfwMUySPNE6sMm/SqfzG56ZN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="391619989"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="391619989"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 03:41:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="837083792"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="837083792"
Received: from jgeary-mobl1.ger.corp.intel.com (HELO [10.213.233.162]) ([10.213.233.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 03:41:00 -0800
Message-ID: <246fefac-6c1d-e4f1-c0df-721ca23ab56a@linux.intel.com>
Date:   Fri, 27 Jan 2023 11:40:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC v3 00/12] DRM scheduling cgroup controller
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
 <20230123154239.GA24348@blackbody.suse.cz>
 <371f3ce5-3468-b91d-d688-7e89499ff347@linux.intel.com>
 <20230126130050.GA22442@blackbody.suse.cz> <Y9KyiCPYj2Mzym3Z@slm.duckdns.org>
 <b8a0872c-fe86-b174-ca3b-0fc04a98e224@linux.intel.com>
 <20230127100428.GA3527@blackbody.suse.cz>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230127100428.GA3527@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 27/01/2023 10:04, Michal Koutný wrote:
> On Thu, Jan 26, 2023 at 05:57:24PM +0000, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
>> So even if the RFC shows just a simple i915 implementation, the controller
>> itself shouldn't prevent a smarter approach (via exposed ABI).
> 
> scan/query + over budget notification is IMO limited in guarantees.

It is yes, I tried to stress out that it is not a hard guarantee in any 
shape and form and that the "quality" of adhering to the allocated 
budget will depend on individual hw and sw capabilities.

But it is what I believe is the best approach given a) how different in 
scheduling capability GPU drivers are and b) the very fact there isn't a 
central scheduling entity as opposed to the CPU side of things.

It is just no possible to do a hard guarantee system. GPUs do not 
preempt as nicely and easily as the CPUs do. And the frequency of 
context switches varies widely from too fast to "never", so again, 
charging would have several problems to overcome which would make the 
whole setup IMHO pointless.

And not only that some GPUs do not preempt nicely, but some even can't 
do any of this, period. Even if we stay within the lineage of hardware 
supported by only i915, we have three distinct categories: 1) can't do 
any of this, 2a) can do fine grained priority based scheduling with 
reasonable preemption capability, 2b) ditto but without reasonable 
preemption capability, and 3) like 2a) and 2b) but with the scheduler in 
the firmware and currently supporting coarse priority based scheduling.

Shall I also mention that a single cgroup can contain multiple GPU 
clients, all using different GPUs with a different mix of the above 
listed challenges?

The main point is, should someone prove me wrong and come up a smarter 
way at some point in the future, then "drm.weight" as an ABI remains 
compatible and the improvement can happen completely under the hood. In 
the mean time users get external control, and _some_ ability to improve 
the user experience with the scenarios such as I described yesterday.

>> [...]
>> Yes agreed, and to re-stress out, the ABI as proposed does not preclude
>> changing from scanning to charging or whatever. The idea was for it to be
>> compatible in concept with the CPU controller and also avoid baking in the
>> controlling method to individual drivers.
>> [...]
> 
> But I submit to your point of rather not exposing this via cgroup API
> for possible future refinements.

Ack.

>> Secondly, doing this in userspace would require the ability to get some sort
>> of an atomic snapshot of the whole tree hierarchy to account for changes in
>> layout of the tree and task migrations. Or some retry logic with some added
>> ABI fields to enable it.
> 
> Note, that the proposed implementation is succeptible to miscount due to
> concurrent tree modifications and task migrations too (scanning may not
> converge under frequent cgroup layout modifications, and migrating tasks
> may be summed 0 or >1 times). While in-kernel implementation may assure
> the snapshot view, it'd come at cost. (Read: since the mechanism isn't
> precise anyway, I don't suggest a fully synchronized scanning.)

The part that scanning may not converge in my _current implementation_ 
is true. For instance if clients would be constantly coming and going, 
for that I took a shortcut of not bothering to accumulate usage on 
process/client exit, and I just wait for a stable two periods to look at 
the current state. I reckon this is possibly okay for the real world.

Cgroup tree hierarchy modifications being the reason for not converging 
can also happen, but I thought I can hand wave that as not a realistic 
scenario. Perhaps I am not imaginative enough?

Under or over-accounting for migrating tasks I don't think can happen 
since I am explicitly handling that.

Regards,

Tvrtko
