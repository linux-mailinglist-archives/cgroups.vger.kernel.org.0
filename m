Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6353E66E388
	for <lists+cgroups@lfdr.de>; Tue, 17 Jan 2023 17:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjAQQ1O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Jan 2023 11:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjAQQ1N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Jan 2023 11:27:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BACD18173;
        Tue, 17 Jan 2023 08:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673972832; x=1705508832;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HxFIc/F4tODmGWHQvVFrU/McHRhB0/99ZlsYIwoeLug=;
  b=g+Lr213l0P00HO48cbQgG1Eup8Iytd2hTmWn8Hr8Fhc7oQXteO37unsu
   LN+PSDyiVcfuUfWw8gQgarHqFdKp3S34XzPur9gCHNpzigx2ku8Vecji7
   uxp912XJBzlRYnwrUCOgQz5a/GiY8YxRuJ4HqnXIjFE/39y6k8nPZ2cQe
   OOHtlPi4WJZZ+vwQ3h7vfe9wnz4hEv5DEKimxKs00bOphjPDDa8z9zFLO
   /ZMLPiN99clwfOcFPaZCkaVq0pRzFvrNGaxxr2ZRXqfZggOEuNd0yZ3sb
   3Sr14Xriw7krGlDi/jHths8FfeAY3qZ+IE7sRy0J9erEQOnmdPGJhYqPZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410977281"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="410977281"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:25:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="833230009"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="833230009"
Received: from rdaly-mobl.ger.corp.intel.com (HELO [10.213.212.83]) ([10.213.212.83])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:25:11 -0800
Message-ID: <db60bb1d-51b6-6830-5a4c-100ba38a2dbc@linux.intel.com>
Date:   Tue, 17 Jan 2023 16:25:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 04/12] drm/cgroup: Track clients per owning process
Content-Language: en-US
To:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Brian Welty <brian.welty@intel.com>, Kenny.Ho@amd.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, "T . J . Mercier" <tjmercier@google.com>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
 <20230112165609.1083270-5-tvrtko.ursulin@linux.intel.com>
 <20230117160311.GA15842@linux.intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230117160311.GA15842@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 17/01/2023 16:03, Stanislaw Gruszka wrote:
> Hi
> 
> On Thu, Jan 12, 2023 at 04:56:01PM +0000, Tvrtko Ursulin wrote:
>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>
>> To enable propagation of settings from the cgroup drm controller to drm we
>> need to start tracking which processes own which drm clients.
>>
>> Implement that by tracking the struct pid pointer of the owning process in
>> a new XArray, pointing to a structure containing a list of associated
>> struct drm_file pointers.
>>
>> Clients are added and removed under the filelist mutex and RCU list
>> operations are used below it to allow for lockless lookup.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> 
> <snip>
> 
>> +int drm_clients_open(struct drm_file *file_priv)
>> +{
>> +	struct drm_device *dev = file_priv->minor->dev;
>> +	struct drm_pid_clients *clients;
>> +	bool new_client = false;
>> +	unsigned long pid;
>> +
>> +	lockdep_assert_held(&dev->filelist_mutex);
>> +
>> +	pid = (unsigned long)rcu_access_pointer(file_priv->pid);
>> +	clients = xa_load(&drm_pid_clients, pid);
>> +	if (!clients) {
>> +		clients = __alloc_clients();
>> +		if (!clients)
>> +			return -ENOMEM;
>> +		new_client = true;
>> +	}
>> +	atomic_inc(&clients->num);
>> +	list_add_tail_rcu(&file_priv->clink, &clients->file_list);
>> +	if (new_client) {
>> +		void *xret;
>> +
>> +		xret = xa_store(&drm_pid_clients, pid, clients, GFP_KERNEL);
>> +		if (xa_err(xret)) {
>> +			list_del_init(&file_priv->clink);
>> +			kfree(clients);
>> +			return PTR_ERR(clients);
> 
> This looks incorrect, rather xa_err(xret) should be returned.

Thanks, looks like a copy & paste error. Noted to correct before next 
public post.

Regards,

Tvrtko
