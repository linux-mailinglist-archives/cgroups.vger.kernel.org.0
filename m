Return-Path: <cgroups+bounces-3155-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2259043C0
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2024 20:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C11C2421B
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2024 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F57152DE0;
	Tue, 11 Jun 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DADGpltb"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF67811FF
	for <cgroups@vger.kernel.org>; Tue, 11 Jun 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130749; cv=none; b=VeOX3IHlfbN4YCgyVCD3zAJ6b3/ubU6bLHIwtv97F7lnDOh3gpmhWIyd/4ThvSczmN8XDmOFX3LC93cogPGfHpKA10Bnrm36m/WJDXfOxA8zUWhro4pbRBhWngW0dyKktuxcE/nqaBbU/a2ks6zLUBW4OvehK9FqUZolQHQfGoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130749; c=relaxed/simple;
	bh=zMfNx1bcKVBF/ayDVPOPv0SC5Cwb9Hr1j4nh3w6x99g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0um4tMMmYCu7MHPKj9D4RJ+JQDgODa/DgA7bZw3DKzoeQx83eqaQgcOar3UucjpYbDcfsFuWcYwQqsKL9JFmQLGRpIpLkVly5yvT39ZBoE7DVw7ugNYJJr//jCbsOr0VqqUzSCF9ssbBa/VhZ1s7uhfmLQdJ6bbtRSCtJe3ZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DADGpltb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718130746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PqOnBky8522sPp9kN8g0ZitRlje0QHj9GfJfJd2aVkA=;
	b=DADGpltbZDNzMX5YOxBE8t8UJgmVkeVYALNOa7t2CM7E4mINgWsr8PzPxhvekmueeSA7De
	ote9OzOf80Ehpg+Wzzp63rfpy+8vP5TTXY1/Erc1HgffM79VdDk3tPYv1YJF0cf88/c1oB
	3mtB62LFDR9K5HJUL9qZPDyJe9dV35U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-9G9oTOUOOpiA8HYANcT_Tw-1; Tue,
 11 Jun 2024 14:32:23 -0400
X-MC-Unique: 9G9oTOUOOpiA8HYANcT_Tw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB98F19560AD;
	Tue, 11 Jun 2024 18:32:18 +0000 (UTC)
Received: from [10.22.33.230] (unknown [10.22.33.230])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF26019560AA;
	Tue, 11 Jun 2024 18:32:11 +0000 (UTC)
Message-ID: <df361d1c-13e2-4a47-aaf7-c8ffc5b1ad2a@redhat.com>
Date: Tue, 11 Jun 2024 14:32:09 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] cgroup/cpuset: export cpuset_cpus_allowed()
To: Fred Griffoul <fgriffo@amazon.co.uk>, griffoul@gmail.com
Cc: kernel test robot <lkp@intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Jeremy Linton <jeremy.linton@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yi Liu <yi.l.liu@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ye Bin <yebin10@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, cgroups@vger.kernel.org
References: <20240611174430.90787-1-fgriffo@amazon.co.uk>
 <20240611174430.90787-2-fgriffo@amazon.co.uk>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240611174430.90787-2-fgriffo@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 6/11/24 13:44, Fred Griffoul wrote:
> A subsequent patch calls cpuset_cpus_allowed() in the vfio driver pci
> code. Export the symbol to be able to build the vfio driver as a kernel
> module.
>
> This is not enough, however: when CONFIG_CPUSETS is _not_ defined
> cpuset_cpus_allowed() is an inline function returning
> task_cpu_possible_mask(). For the arm64 architecture this function is
> also inline: it checks the arm64_mismatched_32bit_el0 static key and
> calls system_32bit_el0_cpumask(). We need to export those symbols as
> well.
>
> Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406060731.L3NSR1Hy-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202406070659.pYu6zNrx-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202406101154.iaDyTRwZ-lkp@intel.com/
> ---
>   arch/arm64/kernel/cpufeature.c | 2 ++
>   kernel/cgroup/cpuset.c         | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 56583677c1f2..2f1de6343bee 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -127,6 +127,7 @@ static bool __read_mostly allow_mismatched_32bit_el0;
>    * seen at least one CPU capable of 32-bit EL0.
>    */
>   DEFINE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
> +EXPORT_SYMBOL_GPL(arm64_mismatched_32bit_el0);
>   
>   /*
>    * Mask of CPUs supporting 32-bit EL0.
> @@ -1614,6 +1615,7 @@ const struct cpumask *system_32bit_el0_cpumask(void)
>   
>   	return cpu_possible_mask;
>   }
> +EXPORT_SYMBOL_GPL(system_32bit_el0_cpumask);
>   
>   static int __init parse_32bit_el0_param(char *str)
>   {
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 4237c8748715..9fd56222aa4b 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4764,6 +4764,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>   	rcu_read_unlock();
>   	spin_unlock_irqrestore(&callback_lock, flags);
>   }
> +EXPORT_SYMBOL_GPL(cpuset_cpus_allowed);
>   
>   /**
>    * cpuset_cpus_allowed_fallback - final fallback before complete catastrophe.
Acked-by: Waiman Long <longman@redhat.com>


