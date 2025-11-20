Return-Path: <cgroups+bounces-12119-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7363AC73D28
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CAC9134B7E2
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F6830AAC0;
	Thu, 20 Nov 2025 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mim/8sLH"
X-Original-To: cgroups@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5421018A
	for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639503; cv=none; b=SkYgM3SpXTe9A1xG4OIByku0hQezioGgLp4YlbIas/1fU/B6+2EwdhEnJ81VTChU5MPyYHRVhMevtf31ESw23NgvFpavoGMg3vyTruwomcX+hQOEvJSnlTZeljJQZZIbmote+SULqVql41b+4SdJQyGbuKXCHsJTBBe9Q3TFpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639503; c=relaxed/simple;
	bh=Bh7h0gzlYzRBTCD8lACrdU70G6YpSV6Yz6gdjLwU+BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=P83n5TWBgtmXXZZL/n+nS3EWAD9SktTc1wZoGThy7vWnzAwkWfVXV8xG5Lbwec2WUsLtguQQmNegm6amlqtQB4tg0LsuSfPdCHaPLNBaikcemqNebEbMR8pbSd2P+a3U+SnYaFQz0y96l3htgEwzGwcjSNolEq/W2tFWQ4Plmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mim/8sLH; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251120115133euoutp02e6a1a2fc9e50e03f26ef5e3f7c9abc6e~5tMZZRPyN1111911119euoutp02G
	for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 11:51:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251120115133euoutp02e6a1a2fc9e50e03f26ef5e3f7c9abc6e~5tMZZRPyN1111911119euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763639493;
	bh=YC8Iv9QeBZhANLAOcz5oFjg5bmmq4/vkYmOCTJfLHDU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=mim/8sLHH8wBOZcnEGhJKSSzHOut2ecemUFtS94qv3agiqwnPPM8RzXw0dqeTQYBf
	 xY/Q4aM5FqtJNZJbg7Eck7vGfoY88rD/XR+2d5B8dtOBK+Q0ObR/4ZY9sFXXecNsRf
	 0yKhV2oOp+9/NG6h03/jCL/7rKuo9dEuqQpUvU6A=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251120115132eucas1p160658ba63831911aadd0b0c2f70b7e28~5tMZMcv8j1678016780eucas1p1t;
	Thu, 20 Nov 2025 11:51:32 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251120115132eusmtip26809d2eaf3a7640f90ac60fb957db482~5tMYsTiV20736207362eusmtip2x;
	Thu, 20 Nov 2025 11:51:32 +0000 (GMT)
Message-ID: <73356b5f-ab5c-4e9e-b57f-b80981c35998@samsung.com>
Date: Thu, 20 Nov 2025 12:51:31 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 1/2] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
To: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marco Crivellari
	<marco.crivellari@suse.com>, Waiman Long <llong@redhat.com>,
	cgroups@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251118143052.68778-2-frederic@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251120115132eucas1p160658ba63831911aadd0b0c2f70b7e28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251120115132eucas1p160658ba63831911aadd0b0c2f70b7e28
X-EPHeader: CA
X-CMS-RootMailID: 20251120115132eucas1p160658ba63831911aadd0b0c2f70b7e28
References: <20251118143052.68778-1-frederic@kernel.org>
	<20251118143052.68778-2-frederic@kernel.org>
	<CGME20251120115132eucas1p160658ba63831911aadd0b0c2f70b7e28@eucas1p1.samsung.com>

On 18.11.2025 15:30, Frederic Weisbecker wrote:
> When a cpuset isolated partition is created / updated or destroyed,
> the IRQ threads are affine blindly to all the non-isolated CPUs. And
> this happens without taking into account the IRQ thread initial
> affinity that becomes ignored.
>
> For example in a system with 8 CPUs, if an IRQ and its kthread are
> initially affine to CPU 5, creating an isolated partition with only
> CPU 2 inside will eventually end up affining the IRQ kthread to all
> CPUs but CPU 2 (that is CPUs 0,1,3-7), losing the kthread preference for
> CPU 5.
>
> Besides the blind re-affinity, this doesn't take care of the actual
> low level interrupt which isn't migrated. As of today the only way to
> isolate non managed interrupts, along with their kthreads, is to
> overwrite their affinity separately, for example through /proc/irq/
>
> To avoid doing that manually, future development should focus on
> updating the IRQs affinity whenever cpuset isolated partitions are
> updated.
>
> In the meantime, cpuset shouldn't fiddle with IRQ threads directly.
> To prevent from that, set the PF_NO_SETAFFINITY flag to them.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

This patch landed in today's linux-next as commit 844dcacab287 ("genirq: 
Fix interrupt threads affinity vs. cpuset isolated partitions"). In my 
tests I found that it triggers a warnings on some of my test systems. 
This is example of such warning:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/kthread.c:599 kthread_bind_mask+0x2c/0x84
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.18.0-rc1-00031-g844dcacab287 #16177 PREEMPT
Hardware name: Samsung Exynos (Flattened Device Tree)
Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from __warn+0x80/0x1d0
  __warn from warn_slowpath_fmt+0x1b0/0x1bc
  warn_slowpath_fmt from kthread_bind_mask+0x2c/0x84
  kthread_bind_mask from wake_up_and_wait_for_irq_thread_ready+0x3c/0xd4
  wake_up_and_wait_for_irq_thread_ready from __setup_irq+0x3e8/0x894
  __setup_irq from request_threaded_irq+0xe4/0x15c
  request_threaded_irq from devm_request_threaded_irq+0x78/0x104
  devm_request_threaded_irq from max8997_irq_init+0x15c/0x24c
  max8997_irq_init from max8997_i2c_probe+0x118/0x208
  max8997_i2c_probe from i2c_device_probe+0x1bc/0x358
  i2c_device_probe from really_probe+0xe0/0x3d8
  really_probe from __driver_probe_device+0x9c/0x1e0
  __driver_probe_device from driver_probe_device+0x30/0xc0
  driver_probe_device from __device_attach_driver+0xa8/0x120
  __device_attach_driver from bus_for_each_drv+0x84/0xdc
  bus_for_each_drv from __device_attach+0xb0/0x20c
  __device_attach from bus_probe_device+0x8c/0x90
  bus_probe_device from device_add+0x5b0/0x7f0
  device_add from i2c_new_client_device+0x170/0x360
  i2c_new_client_device from of_i2c_register_device+0x80/0xc8
  of_i2c_register_device from of_i2c_register_devices+0x84/0xf8
  of_i2c_register_devices from i2c_register_adapter+0x240/0x7b0
  i2c_register_adapter from s3c24xx_i2c_probe+0x2a0/0x570
  s3c24xx_i2c_probe from platform_probe+0x5c/0x98
  platform_probe from really_probe+0xe0/0x3d8
  really_probe from __driver_probe_device+0x9c/0x1e0
  __driver_probe_device from driver_probe_device+0x30/0xc0
  driver_probe_device from __driver_attach+0x124/0x1d4
  __driver_attach from bus_for_each_dev+0x70/0xc4
  bus_for_each_dev from bus_add_driver+0xe0/0x220
  bus_add_driver from driver_register+0x7c/0x118
  driver_register from do_one_initcall+0x70/0x328
  do_one_initcall from kernel_init_freeable+0x1c0/0x234
  kernel_init_freeable from kernel_init+0x1c/0x12c
  kernel_init from ret_from_fork+0x14/0x28
Exception stack(0xf082dfb0 to 0xf082dff8)
...
irq event stamp: 78529
hardirqs last  enabled at (78805): [<c01bc4f8>] __up_console_sem+0x50/0x60
hardirqs last disabled at (78816): [<c01bc4e4>] __up_console_sem+0x3c/0x60
softirqs last  enabled at (78784): [<c013bb14>] handle_softirqs+0x328/0x520
softirqs last disabled at (78779): [<c013beb8>] __irq_exit_rcu+0x144/0x1f0
---[ end trace 0000000000000000 ]---

Reverting $subject on top of linux-next fixes this issue. Let me know 
how I can help debugging it.


> ---
>   kernel/irq/manage.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 400856abf672..76e2cbe21d1f 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -176,7 +176,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
>   }
>   
>   /**
> - * irq_set_thread_affinity - Notify irq threads to adjust affinity
> + * irq_thread_update_affinity - Notify irq threads to adjust affinity
>    * @desc:	irq descriptor which has affinity changed
>    *
>    * Just set IRQTF_AFFINITY and delegate the affinity setting to the
> @@ -184,7 +184,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
>    * we hold desc->lock and this code can be called from hard interrupt
>    * context.
>    */
> -static void irq_set_thread_affinity(struct irq_desc *desc)
> +static void irq_thread_update_affinity(struct irq_desc *desc)
>   {
>   	struct irqaction *action;
>   
> @@ -283,7 +283,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>   		fallthrough;
>   	case IRQ_SET_MASK_OK_NOCOPY:
>   		irq_validate_effective_affinity(data);
> -		irq_set_thread_affinity(desc);
> +		irq_thread_update_affinity(desc);
>   		ret = 0;
>   	}
>   
> @@ -1035,8 +1035,16 @@ static void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *a
>   		set_cpus_allowed_ptr(current, mask);
>   	free_cpumask_var(mask);
>   }
> +
> +static inline void irq_thread_set_affinity(struct task_struct *t,
> +					   struct irq_desc *desc)
> +{
> +	kthread_bind_mask(t, irq_data_get_effective_affinity_mask(&desc->irq_data));
> +}
>   #else
>   static inline void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
> +static inline void irq_thread_set_affinity(struct task_struct *t,
> +					   struct irq_desc *desc) { }
>   #endif
>   
>   static int irq_wait_for_interrupt(struct irq_desc *desc,
> @@ -1221,6 +1229,7 @@ static void wake_up_and_wait_for_irq_thread_ready(struct irq_desc *desc,
>   	if (!action || !action->thread)
>   		return;
>   
> +	irq_thread_set_affinity(action->thread, desc);
>   	wake_up_process(action->thread);
>   	wait_event(desc->wait_for_threads,
>   		   test_bit(IRQTF_READY, &action->thread_flags));
> @@ -1405,16 +1414,7 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
>   	 * references an already freed task_struct.
>   	 */
>   	new->thread = get_task_struct(t);
> -	/*
> -	 * Tell the thread to set its affinity. This is
> -	 * important for shared interrupt handlers as we do
> -	 * not invoke setup_affinity() for the secondary
> -	 * handlers as everything is already set up. Even for
> -	 * interrupts marked with IRQF_NO_BALANCE this is
> -	 * correct as we want the thread to move to the cpu(s)
> -	 * on which the requesting code placed the interrupt.
> -	 */
> -	set_bit(IRQTF_AFFINITY, &new->thread_flags);
> +
>   	return 0;
>   }
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


