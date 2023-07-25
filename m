Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D543E761A5D
	for <lists+cgroups@lfdr.de>; Tue, 25 Jul 2023 15:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjGYNrJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGYNrI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 09:47:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7324810FA;
        Tue, 25 Jul 2023 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690292825; x=1721828825;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+OP3tS0a6vPFOecpYmL8uA5ooqpSQiEgNnaksnOSZtQ=;
  b=bb7HfaBzkEk+MyncxF9qHtjbHTowxedaHPFbP5Mrknsf7XEzcDAiGexr
   aqavvuV+SdEdYGkafyMHSDC5l7N2OarRg2WIhNAFYEtOWOOlFTiMsn3Td
   SNGwrCYWUJrzZMlOUvqFStHSLkNmOxiDbyW4QrY0q1nxHhmm5KLu8PQlb
   5jvMrp8BafVNri0m03OpvI5aQlt5yxz+QUX10Pq42WjOWT/rH/huZ06D8
   X4XJmb3SX3HhYA1j1hc5jaweHnFuFlDxJpURlmg7VKdLlZ8uLfh5VrWw6
   faFG/oyqH3jA/v8BXy9TTSIjxcngx1zjo/pR+EP/3p87tUqEd4Co32g14
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352624098"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="352624098"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 06:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="755763480"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="755763480"
Received: from grdarcy-mobl1.ger.corp.intel.com (HELO [10.213.228.4]) ([10.213.228.4])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 06:47:00 -0700
Message-ID: <9200b403-6376-96da-d84c-783a3371f73f@linux.intel.com>
Date:   Tue, 25 Jul 2023 14:46:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 12/17] cgroup/drm: Introduce weight based drm cgroup
 control
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
 <20230712114605.519432-13-tvrtko.ursulin@linux.intel.com>
 <ZLsEEYDFlJZwrJiV@slm.duckdns.org>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <ZLsEEYDFlJZwrJiV@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 21/07/2023 23:17, Tejun Heo wrote:
> On Wed, Jul 12, 2023 at 12:46:00PM +0100, Tvrtko Ursulin wrote:
>> +DRM scheduling soft limits
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Please don't say soft limits for this. It means something different for
> memcg, so it gets really confusing. Call it "weight based CPU time control"
> and maybe call the triggering points as thresholds.

Yes sorry, you said that before and I forgot to reword it all when 
re-spinning. I have now marked it as TODO in my email client so 
hopefully next time round I don't forget.

Regards,

Tvrtko
