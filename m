Return-Path: <cgroups+bounces-1005-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B66581CE1B
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 18:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03AC1B20F3A
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 17:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F59928DDA;
	Fri, 22 Dec 2023 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVYHACrG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675128E0F;
	Fri, 22 Dec 2023 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3ed1ca402so17111275ad.2;
        Fri, 22 Dec 2023 09:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703267489; x=1703872289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4tD8QJt5IDQ28yzz/LjJYgwMyYZ52WVpgrHwNEgAdM=;
        b=QVYHACrGNVPYIwz7fVf9qkA36FduRG38eGDl1hJxjGQrz6+IlgsjDkSXvVr8Y/stwR
         o8LlJaArhr+tHGiqYLv3Vja4pz0qv+9eMRFWe6Qecs7r6Xr0vSXo8UNAAQw1BT0FVfux
         DzTWR6hTDZpNsWWppsr+KTLQ+cxv5a07DiAQPak+nnpx0RlhaKbTNC1c85FeQWpbAEW7
         yy83PXluLRh0mQjppkhTKEer0n6U1dQ9cyterZqt1VP7xjmVdXMRwvCuNuQ2pIupJyhR
         s8XJtgk5pGnqZJCR5eHMW9pPbdgTONGejBpCMpltNiNUJsMpinQhLq6OlVp1u2bYgivh
         PStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703267489; x=1703872289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4tD8QJt5IDQ28yzz/LjJYgwMyYZ52WVpgrHwNEgAdM=;
        b=kKqkLlQ+TqaOAVZXTUZr3PSHo0sozqe0TKfIsJux+Lhqi2YbaQF/xJMQdTfeoTqzNz
         wQdaIMgHoF0yLb15trw3tzMI85KGvXb4WBaqysSrZORYt+Yt8QrOhh3EYbjFGIUPAcwF
         p4aZ55tdIFIxUZ7uNeHWOiHbGUF3KScsWTulrDY8PsePiw1jEAS5Cylud3+Cavn9Rjc1
         oeT4JDl9M1m81Fb/ZQvcjmFM23fSxiJWTNEChZGIcumrd45j0pydV29iMiFyKVK2C7iH
         QIZPHdL3GDA6Sjb89+uxk1pXgT6igb02ZasmaYKNAdURfE13EAPkv8bnP7sl8Farto13
         k2LA==
X-Gm-Message-State: AOJu0YzkmGkY/B45V5YuRvxzo0O6x7QxajyxhjQ9Rd2zC7iEp7VPKPnZ
	BR4VpVdaCM58cHtr6EDbmWhysgZURvWyVA==
X-Google-Smtp-Source: AGHT+IFO9d7pMpREpDrNeATJ9z3HGGEKsuUMq6752xXZMMZxXbbQu7/swGUV6iivPPpUAEjbyiuWLw==
X-Received: by 2002:a17:902:db02:b0:1d3:bc96:6c13 with SMTP id m2-20020a170902db0200b001d3bc966c13mr2020671plx.35.1703267489298;
        Fri, 22 Dec 2023 09:51:29 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id ju22-20020a170903429600b001d1cd7e4acesm3740735plb.68.2023.12.22.09.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:51:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 23 Dec 2023 02:51:26 +0900
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, bpf@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/4] bpf: Add new kfunc bpf_cpumask_set_from_pid
Message-ID: <ZYXMns6PV1byBWtg@mac.lan>
References: <20231222113102.4148-1-laoar.shao@gmail.com>
 <20231222113102.4148-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222113102.4148-4-laoar.shao@gmail.com>

Hello,

On Fri, Dec 22, 2023 at 11:31:01AM +0000, Yafang Shao wrote:
> Introducing a new kfunc: bpf_cpumask_set_from_pid. This function serves the
> purpose of retrieving the cpumask associated with a specific PID. Its
> utility is particularly evident within container environments. For
> instance, it allows for extracting the cpuset of a container using the
> init task within it.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
...
> +__bpf_kfunc bool bpf_cpumask_set_from_pid(struct cpumask *cpumask, u32 pid)
> +{
> +	struct task_struct *task;
> +
> +	if (!cpumask)
> +		return false;
> +
> +	task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
> +	if (!task)
> +		return false;
> +
> +	cpumask_copy(cpumask, task->cpus_ptr);
> +	put_task_struct(task);
> +	return true;
> +}

This seems awfully specific. Why is this necessary? Shouldn't the BPF prog
get the task and bpf_cpumask_copy() its ->cpus_ptr instead?

Thanks.

-- 
tejun

