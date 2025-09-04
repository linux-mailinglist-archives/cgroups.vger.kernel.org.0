Return-Path: <cgroups+bounces-9706-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8605B43B15
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 14:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A161C27F21
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 12:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037642C21C0;
	Thu,  4 Sep 2025 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Doy2IVcQ"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5162C0280;
	Thu,  4 Sep 2025 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987746; cv=none; b=ea3JF7FcBkrW0IfDrT7h1Ecj4vGBWOE7pRWwnxOlq7zfMErA1rpCCiTbDPsJmTBrGaMyn47PpA1qsl2XpYxhYppW0hphOHgdV6l7lFUZIdqeP76YsOPJF/zk2hOgM6XExZlXxOYYJ5NXi/2UNeLC90iTqMksRHWJlQgpiC9RcoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987746; c=relaxed/simple;
	bh=Pb0QyP3dyoTEwuCPxZnGieciZx0aotZ6+nPw4KQu5D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZ30zzAXQjAl3yeORgr5eVAiPoTFdSD62UwkTswWFBeiEYwESg0NMnbaTkixt84BaHOCrIqm5xW9ydVfCLwaPq6+39NGS4grYKSGHnzOfDWIkD3Z5xzXCK6mySgzxGQkoOGPrn6C/1EKt2O/T08EfVHIhDe8ujgB+t7A70ft29Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Doy2IVcQ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zq0zttv8W9LftJSDoTWI4vEahxxZ/eDadaO2lGU9frI=; b=Doy2IVcQPHNkqDcO8iZuikICP4
	jkpIXDdn4+zROswF5n31UFc9JSxN735+O/84PZPd/Z0rUnNx9ySQV4Gh0xJzoCXNYSg80Cz7E245H
	fruFNdhBk150qROe486hg/IygRQTiNOAymr6xRT9Unr2fr1Ts9FZ3fiNKa34lwlyuJVJdTHyXuBCY
	fFd3oqajvwbQyPXp71P8dHJ/ANLuhM3Encjvvxbdqk2U3g+rRr5GWaJv1ne/mv9xk1tcXW64JT4Cn
	bva1scV3a68EdytM8cobyaelkuOXX6NjEPj6JlIDJNpyVUVjJcWIGMhCZq04bVJ7XAai0t/d+d1QD
	CfxyRKxQ==;
Received: from [84.66.36.92] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uu8lt-006lVT-Iu; Thu, 04 Sep 2025 14:08:57 +0200
Message-ID: <58866bb5-9fee-4709-9350-70b978feaed4@igalia.com>
Date: Thu, 4 Sep 2025 13:08:56 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 21/21] drm/xe: Register with the DRM scheduling cgroup
 controller
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 intel-xe@lists.freedesktop.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
 <20250903152327.66002-22-tvrtko.ursulin@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20250903152327.66002-22-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 03/09/2025 16:23, Tvrtko Ursulin wrote:
> Wire up the scheduling weight notification into the driver.
> 
> DRM cgroup controller will notify the driver of scheduling weights for
> each DRM client, which the driver will map into the three GuC scheduling
> priorities by giving the lowest weight client the low priority, and
> respectively the highest one high. The other clients will not be changed
> as will not be the ones which have individually specified a priority other
> than normal.
> 
> The priority changes are done from a delayed worker to coalesce
> potentially numerous updates and also to allow taking the mutexes from a
> callback which runs with preemption disabled.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>   drivers/gpu/drm/xe/xe_device.c       | 18 +++++++
>   drivers/gpu/drm/xe/xe_device_types.h | 15 ++++++
>   drivers/gpu/drm/xe/xe_exec_queue.c   | 80 ++++++++++++++++++++++++++++
>   drivers/gpu/drm/xe/xe_exec_queue.h   |  5 ++
>   drivers/gpu/drm/xe/xe_guc_submit.c   |  8 ++-
>   drivers/gpu/drm/xe/xe_pm.c           |  4 ++
>   6 files changed, 129 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index 9e2952c9c06a..9fef10c50868 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -112,6 +112,10 @@ static int xe_file_open(struct drm_device *dev, struct drm_file *file)
>   		put_task_struct(task);
>   	}
>   
> +#ifdef CONFIG_CGROUP_DRM
> +	xef->cg.prio = XE_EXEC_QUEUE_PRIORITY_NORMAL; // TODO: inherit current cgroup priority
> +#endif

For the record from the updated branch this TODO is addressed like this:

#ifdef CONFIG_CGROUP_DRM
	/*
	 * Set the initial values to valid ones but note that both will get set
	 * and updated as the DRM core will soon notify the cgroup controller
	 * that the new client has entered the group via
	 * drmcgroup_client_open(). That in turn will trigger the weight
	 * notifications and then xe_drm_cgroup_notify_weight() will update both
	 * shortly.
	 */
	atomic_set(&xef->cg.weight, CGROUP_WEIGHT_DFL);
	xef->cg.prio = XE_EXEC_QUEUE_PRIORITY_NORMAL;
#endif

Regards,

Tvrtko

> +
>   	return 0;
>   }
>   
> @@ -368,6 +372,12 @@ static const struct file_operations xe_driver_fops = {
>   	.fop_flags = FOP_UNSIGNED_OFFSET,
>   };
>   
> +#ifdef CONFIG_CGROUP_DRM
> +static const struct drm_cgroup_ops xe_drm_cgroup_ops = {
> +	.notify_weight = xe_drm_cgroup_notify_weight,
> +};
> +#endif
> +
>   static struct drm_driver driver = {
>   	/* Don't use MTRRs here; the Xserver or userspace app should
>   	 * deal with them for Intel hardware.
> @@ -386,6 +396,10 @@ static struct drm_driver driver = {
>   #ifdef CONFIG_PROC_FS
>   	.show_fdinfo = xe_drm_client_fdinfo,
>   #endif
> +
> +#ifdef CONFIG_CGROUP_DRM
> +	.cg_ops = &xe_drm_cgroup_ops,
> +#endif
>   	.ioctls = xe_ioctls,
>   	.num_ioctls = ARRAY_SIZE(xe_ioctls),
>   	.fops = &xe_driver_fops,
> @@ -500,6 +514,10 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
>   	if (err)
>   		goto err;
>   
> +#ifdef CONFIG_CGROUP_DRM
> +	INIT_DELAYED_WORK(&xe->cg.work, xe_drm_cgroup_work);
> +#endif
> +
>   	return xe;
>   
>   err:
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 092004d14db2..dbc65a4aa08d 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -19,6 +19,7 @@
>   #include "xe_oa_types.h"
>   #include "xe_platform_types.h"
>   #include "xe_pmu_types.h"
> +#include "xe_exec_queue_types.h"
>   #include "xe_pt_types.h"
>   #include "xe_sriov_pf_types.h"
>   #include "xe_sriov_types.h"
> @@ -34,6 +35,7 @@
>   struct dram_info;
>   struct intel_display;
>   struct intel_dg_nvm_dev;
> +struct xe_file;
>   struct xe_ggtt;
>   struct xe_i2c;
>   struct xe_pat_ops;
> @@ -624,6 +626,12 @@ struct xe_device {
>   		unsigned int czclk_freq;
>   	};
>   #endif
> +
> +#ifdef CONFIG_CGROUP_DRM
> +	struct {
> +		struct delayed_work	work;
> +	} cg;
> +#endif
>   };
>   
>   /**
> @@ -685,6 +693,13 @@ struct xe_file {
>   
>   	/** @refcount: ref count of this xe file */
>   	struct kref refcount;
> +
> +#ifdef CONFIG_CGROUP_DRM
> +	struct {
> +		atomic_t weight;
> +		enum xe_exec_queue_priority prio;
> +	} cg;
> +#endif
>   };
>   
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
> index 063c89d981e5..2f072d2a0117 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue.c
> +++ b/drivers/gpu/drm/xe/xe_exec_queue.c
> @@ -1139,3 +1139,83 @@ void xe_exec_queue_jobs_ring_restore(struct xe_exec_queue *q)
>   	}
>   	spin_unlock(&sched->base.job_list_lock);
>   }
> +
> +#ifdef CONFIG_CGROUP_DRM
> +void xe_drm_cgroup_work(struct work_struct *work)
> +{
> +	struct xe_device *xe = container_of(work, typeof(*xe), cg.work.work);
> +	unsigned int weight, min = UINT_MAX, max = 0;
> +	struct drm_device *dev = &xe->drm;
> +	struct drm_file *file;
> +	struct xe_file *xef;
> +
> +	mutex_lock(&dev->filelist_mutex);
> +
> +	list_for_each_entry(file, &dev->filelist, lhead) {
> +		xef = to_xe_file(file);
> +		weight = atomic_read(&xef->cg.weight);
> +
> +		if (!weight)
> +			continue;
> +
> +		if (weight < min)
> +			min = weight;
> +
> +		if (weight > max)
> +			max = weight;
> +	}
> +
> +	list_for_each_entry(file, &dev->filelist, lhead) {
> +		enum xe_exec_queue_priority new_prio;
> +		struct xe_exec_queue *q;
> +		unsigned long i;
> +
> +		xef = to_xe_file(file);
> +		weight = atomic_read(&xef->cg.weight);
> +
> +		if (max == min)
> +			new_prio = XE_EXEC_QUEUE_PRIORITY_NORMAL;
> +		else if (weight == max)
> +			new_prio = XE_EXEC_QUEUE_PRIORITY_HIGH;
> +		else if (weight == min)
> +			new_prio = XE_EXEC_QUEUE_PRIORITY_LOW;
> +		else
> +			new_prio = XE_EXEC_QUEUE_PRIORITY_NORMAL;
> +
> +		if (new_prio == xef->cg.prio)
> +			continue;
> +
> +		mutex_lock(&xef->exec_queue.lock);
> +		xa_for_each(&xef->exec_queue.xa, i, q) {
> +			if (q->sched_props.priority !=
> +			    XE_EXEC_QUEUE_PRIORITY_NORMAL)
> +				continue;
> +
> +			xe_exec_queue_get(q);
> +			mutex_unlock(&xef->exec_queue.lock);
> +
> +			q->ops->set_priority(q, new_prio);
> +
> +			mutex_lock(&xef->exec_queue.lock);
> +			xe_exec_queue_put(q);
> +		}
> +		mutex_unlock(&xef->exec_queue.lock);
> +
> +		xef->cg.prio = new_prio;
> +	}
> +
> +	mutex_unlock(&dev->filelist_mutex);
> +}
> +
> +void xe_drm_cgroup_notify_weight(struct drm_file *file_priv,
> +				 unsigned int weight)
> +{
> +	struct xe_file *xef = to_xe_file(file_priv);
> +	struct xe_device *xe = xef->xe;
> +
> +	atomic_set(&xef->cg.weight, weight);
> +
> +	queue_delayed_work(system_unbound_wq, &xe->cg.work,
> +			   msecs_to_jiffies(100));
> +}
> +#endif
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue.h b/drivers/gpu/drm/xe/xe_exec_queue.h
> index 15ec852e7f7e..5f6b42c74086 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue.h
> +++ b/drivers/gpu/drm/xe/xe_exec_queue.h
> @@ -95,4 +95,9 @@ int xe_exec_queue_contexts_hwsp_rebase(struct xe_exec_queue *q, void *scratch);
>   void xe_exec_queue_jobs_ring_restore(struct xe_exec_queue *q);
>   
>   struct xe_lrc *xe_exec_queue_lrc(struct xe_exec_queue *q);
> +
> +void xe_drm_cgroup_notify_weight(struct drm_file *file_priv,
> +				 unsigned int weight);
> +void xe_drm_cgroup_work(struct work_struct *work);
> +
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index 86daf6f4728f..df1252f4cd62 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -427,13 +427,19 @@ static const int xe_exec_queue_prio_to_guc[] = {
>   static void init_policies(struct xe_guc *guc, struct xe_exec_queue *q)
>   {
>   	struct exec_queue_policy policy;
> -	enum xe_exec_queue_priority prio = q->sched_props.priority;
> +	enum xe_exec_queue_priority prio;
>   	u32 timeslice_us = q->sched_props.timeslice_us;
>   	u32 slpc_exec_queue_freq_req = 0;
>   	u32 preempt_timeout_us = q->sched_props.preempt_timeout_us;
>   
>   	xe_gt_assert(guc_to_gt(guc), exec_queue_registered(q));
>   
> +	prio = q->sched_props.priority;
> +#ifdef CONFIG_CGROUP_DRM
> +	if (prio == XE_EXEC_QUEUE_PRIORITY_NORMAL && q->xef)
> +		prio = q->xef->cg.prio;
> +#endif
> +
>   	if (q->flags & EXEC_QUEUE_FLAG_LOW_LATENCY)
>   		slpc_exec_queue_freq_req |= SLPC_CTX_FREQ_REQ_IS_COMPUTE;
>   
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index a2e85030b7f4..67291f19213b 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -124,6 +124,10 @@ int xe_pm_suspend(struct xe_device *xe)
>   	drm_dbg(&xe->drm, "Suspending device\n");
>   	trace_xe_pm_suspend(xe, __builtin_return_address(0));
>   
> +#ifdef CONFIG_CGROUP_DRM
> +	cancel_delayed_work_sync(&xe->cg.work);
> +#endif
> +
>   	err = xe_pxp_pm_suspend(xe->pxp);
>   	if (err)
>   		goto err;


