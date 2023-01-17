Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3166E309
	for <lists+cgroups@lfdr.de>; Tue, 17 Jan 2023 17:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjAQQEz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Jan 2023 11:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjAQQEx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Jan 2023 11:04:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A12E3A861;
        Tue, 17 Jan 2023 08:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673971492; x=1705507492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=83QUm+B1soJY7/5R+o87e442WuYAgBdKXUVW9VPPJwY=;
  b=IubsWkpoktWBNxNWo8Q20thw0LC165CNAyzo7Oolz9r+RtyZIgAjm3Rp
   A/KNXhaa+IEwcTMt5Ph+RxLkBkgsEQZY9LVP3tYJxmTFH/aLk88lXdWnt
   aFtxpoz1uPdcB4ouCvVb7boRTeDp7yz3qtCWa3OfyL3MqBKtYNQlJ3nGJ
   hmC67UgXtRZghYLUei/7ZifIEYnggj8toKfMSOwe4PP5alA9kxuXsqbBq
   8qnV9g5hcBbyOUZcFx2FQQ352MwtCF5o1BYUroOLBp46aa6EV7XzLXvI8
   /SebZ+j30dkD1d3Jsvwwu9gZjHcHjt04nFfviYG1V2k9Nmx8AeVxDu4gp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="323427596"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="323427596"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:03:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="904695680"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="904695680"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:03:13 -0800
Date:   Tue, 17 Jan 2023 17:03:11 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Brian Welty <brian.welty@intel.com>, Kenny.Ho@amd.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, "T . J . Mercier" <tjmercier@google.com>
Subject: Re: [RFC 04/12] drm/cgroup: Track clients per owning process
Message-ID: <20230117160311.GA15842@linux.intel.com>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
 <20230112165609.1083270-5-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112165609.1083270-5-tvrtko.ursulin@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi

On Thu, Jan 12, 2023 at 04:56:01PM +0000, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> 
> To enable propagation of settings from the cgroup drm controller to drm we
> need to start tracking which processes own which drm clients.
> 
> Implement that by tracking the struct pid pointer of the owning process in
> a new XArray, pointing to a structure containing a list of associated
> struct drm_file pointers.
> 
> Clients are added and removed under the filelist mutex and RCU list
> operations are used below it to allow for lockless lookup.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

<snip>

> +int drm_clients_open(struct drm_file *file_priv)
> +{
> +	struct drm_device *dev = file_priv->minor->dev;
> +	struct drm_pid_clients *clients;
> +	bool new_client = false;
> +	unsigned long pid;
> +
> +	lockdep_assert_held(&dev->filelist_mutex);
> +
> +	pid = (unsigned long)rcu_access_pointer(file_priv->pid);
> +	clients = xa_load(&drm_pid_clients, pid);
> +	if (!clients) {
> +		clients = __alloc_clients();
> +		if (!clients)
> +			return -ENOMEM;
> +		new_client = true;
> +	}
> +	atomic_inc(&clients->num);
> +	list_add_tail_rcu(&file_priv->clink, &clients->file_list);
> +	if (new_client) {
> +		void *xret;
> +
> +		xret = xa_store(&drm_pid_clients, pid, clients, GFP_KERNEL);
> +		if (xa_err(xret)) {
> +			list_del_init(&file_priv->clink);
> +			kfree(clients);
> +			return PTR_ERR(clients);

This looks incorrect, rather xa_err(xret) should be returned.

Regards
Stanislaw
