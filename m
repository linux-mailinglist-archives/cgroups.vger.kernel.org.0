Return-Path: <cgroups+bounces-3121-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E77BB8FF10D
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 17:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C5328DD77
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 15:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DEB197553;
	Thu,  6 Jun 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ymg7ROBd"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07D196DB0
	for <cgroups@vger.kernel.org>; Thu,  6 Jun 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688749; cv=none; b=fH4ZftCl7/47bmX3KP1TbCJ0RT2q5TwGBKD3B78OKF61jydb2IHqKhkLAWMubUVDLOz1t04FZESdzaBxSjGbYDbsyl+sLPxNoego7udDL4eywHuhG6wA0ufVzo9g8JVPxjB7kNzRtPVvkJWL7u2xR5/yAEKDDrCNLridkv7hx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688749; c=relaxed/simple;
	bh=axEesd1KcqTkvjB0CnmuulRkE7CYYEayuZLnI4aD1Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hf1mC75dp+6oUBtCnDyhmpOpHBJ7GqDhU4Q7o+wQnIs9J1+pVrpQpEIxQQFq+RIPGN/DFRCpTsL45dhO0e5ZQrkpZjzVtRMISOgwRtZLl2h+v6opkIiemksXM56w5HgUCpvdDYfqW5qAzGCOwucZyDRYUNh6nVg/EdzerT4X+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ymg7ROBd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717688746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=do9l/6SevcYiTITfryG8vnwfYZ8K8fjEylRaQrA5X7Q=;
	b=Ymg7ROBdmznGuqsx7K2sdZUAPUrtJbZgS17WgC6LfscshXsyepuOUvEF7HJ4CoeNmmeXeU
	Ihe/QSjvL/UhtJDzkw6pgpkHr8JUF0jnDv3V4iGWQi0g9Mra7OsrT0+n+vDAYzg5CmXxEl
	mBPdoM7D9PcJ9S5Y3uQYWG3nfGtFyiQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-_NT2JrStN7CzC6EDXSlQDQ-1; Thu,
 06 Jun 2024 11:45:43 -0400
X-MC-Unique: _NT2JrStN7CzC6EDXSlQDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6F0E380008F;
	Thu,  6 Jun 2024 15:45:41 +0000 (UTC)
Received: from [10.22.33.43] (unknown [10.22.33.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 12844202A435;
	Thu,  6 Jun 2024 15:45:40 +0000 (UTC)
Message-ID: <8936c102-725d-4496-b014-cc3edfccf4dd@redhat.com>
Date: Thu, 6 Jun 2024 11:45:37 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cgroup/cpuset: export cpuset_cpus_allowed()
To: Fred Griffoul <fgriffo@amazon.co.uk>, griffoul@gmail.com
Cc: kernel test robot <lkp@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yi Liu <yi.l.liu@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ye Bin <yebin10@huawei.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20240606151017.41623-1-fgriffo@amazon.co.uk>
 <20240606151017.41623-2-fgriffo@amazon.co.uk>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240606151017.41623-2-fgriffo@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


On 6/6/24 11:10, Fred Griffoul wrote:
> A subsequent patch calls cpuset_cpus_allowed() in the vfio driver pci
> code. Export the symbol to be able to build the vfio driver as a kernel
> module.
>
> Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406060731.L3NSR1Hy-lkp@intel.com/
> ---
>   kernel/cgroup/cpuset.c | 1 +
>   1 file changed, 1 insertion(+)
>
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

LGTM

Acked-by: Waiman Long <longman@redhat.com>


