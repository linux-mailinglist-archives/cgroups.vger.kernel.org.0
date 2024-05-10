Return-Path: <cgroups+bounces-2855-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA71C8C1EE1
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 09:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2B11C20C8A
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 07:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A3B15E81C;
	Fri, 10 May 2024 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqkCokKp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E61DFEA;
	Fri, 10 May 2024 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325579; cv=none; b=VxnyqJhUe7mAul7nmR9Mqb2yp2Tl+u7la3gDGQEjDDhsiIDXLGvHEsul0MXBTFBHC/r1qMUbwEmXKwoTzA/y8G5o8hk/uPBPDUk6tmruaoUyo64eHvM+PPDcM5xstVUcwLz3Au09NSuI1mBmaq/eRza3K5rPjzJk+C/yptktHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325579; c=relaxed/simple;
	bh=SArSvmFrU4xzTpk/q0k2FSyZRlXsa+EKseXL4ao2Wfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFQdKZgJ6pFm3/ngzttCzA40dk5ViGi4eg8J78LIt0Sd+kzbpJrS3nQ/ufRY8Bq0o2qT3MW9sWzXu8F8hmKPmskPWSGAb645ZpLO4mGi/SWH2STByW3Y/D96Fe0UPrZyE39GP6Y30OYPGcX13XRM6HLRkog/P10F/UkyGO7q7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqkCokKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5BAC113CC;
	Fri, 10 May 2024 07:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715325579;
	bh=SArSvmFrU4xzTpk/q0k2FSyZRlXsa+EKseXL4ao2Wfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XqkCokKpj7bmZLvsJn0DvwzMdVG3W9jhKgTCwMtZqc+uyePLZWw9Zupm2DAuLjgae
	 jFnqcNfR4UEn2EGZEqK65UY4UZuBcLhKdvPfmumX4Sle6HLCIXRxYo+L8bpHzPP3mn
	 hoa+ZI83GiPtCgoZOMfMN6lYS8oa36X5KRiDWImga/Uk/Gog3f+WkXdZxjVAhjxXId
	 FUTYiMy88x1qrQFXOUQ5+qTFU2ch2x/bT3K/GDJtBBdCJmAmQtCH7lq1Q04ci0e3BS
	 0AmRZnWQz3fNWAANyKjunD9DS/FQ/r65qSgILVl3WY6OwvozsEo8IomaJUBSWFiwba
	 dbFIqmZ8YLFSA==
Message-ID: <a78eb50f-f530-4f3a-9558-d81354e7ee8d@kernel.org>
Date: Fri, 10 May 2024 16:19:36 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme: multipath: pr_notice when iopolicy changes
To: John Meneghini <jmeneghi@redhat.com>, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, emilne@redhat.com, hare@kernel.org
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, aviv.coro@ibm.com
References: <20240403141756.88233-1-hare@kernel.org>
 <20240509204324.832846-4-jmeneghi@redhat.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240509204324.832846-4-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/24 05:43, John Meneghini wrote:
> Send a pr_notice when ever the iopolicy on a subsystem
> is changed. This is important for support reasons. It
> is fully expected that users will be changing the iopolicy
> with active IO in progress.
> 
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>  drivers/nvme/host/multipath.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index e9330bb1990b..0286e44a081f 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -67,6 +67,10 @@ static int nvme_activate_iopolicy(struct nvme_subsystem *subsys, int iopolicy)
>  		}
>  	}
>  	mutex_unlock(&subsys->lock);
> +
> +	pr_notice("%s: %s enable %d status %d for subsysnqn %s\n", __func__,
> +			nvme_iopolicy_names[iopolicy], enable, ret, subsys->subnqn);
> +
>  	return ret;
>  }
>  
> @@ -890,6 +894,8 @@ void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
>  {
>  	struct nvme_ctrl *ctrl;
>  
> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);

No need for the white line before this.

> +
>  	WRITE_ONCE(subsys->iopolicy, iopolicy);
>  
>  	mutex_lock(&nvme_subsystems_lock);
> @@ -898,6 +904,10 @@ void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
>  		nvme_mpath_clear_ctrl_paths(ctrl);
>  	}
>  	mutex_unlock(&nvme_subsystems_lock);
> +
> +	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
> +			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
> +			subsys->subnqn);

Using dev_notice(&subsys->dev, "...", ...); may be better. Same for the other
messages.

>  }
>  
>  static ssize_t nvme_subsys_iopolicy_store(struct device *dev,

-- 
Damien Le Moal
Western Digital Research


