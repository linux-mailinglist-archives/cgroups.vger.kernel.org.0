Return-Path: <cgroups+bounces-293-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 516C37E7396
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 22:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FB01C20A9E
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE98038DD8;
	Thu,  9 Nov 2023 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuB6bZN6"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D5374E3;
	Thu,  9 Nov 2023 21:27:20 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46533C07;
	Thu,  9 Nov 2023 13:27:19 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28003daaaa6so1203078a91.0;
        Thu, 09 Nov 2023 13:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699565239; x=1700170039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzwwVLnenU8epgb0q6ZVSvJsSZNxGycIk5GiMaPfDBA=;
        b=QuB6bZN6faIPs0ref/M+/SwFgA+ooBXDybi5Xx7hLoWqR2bEuWtAX+R9pfyQ/Tyqm7
         oto4cp0GSGZmdWIlv20DkRF6gm2TJK/By8j85RNL3SNwKXFCPRp7uC7LlzeD3FjpZE/8
         DRq6T63JKEfaQz6X/mNsDYdIcJvj9YgD3dryGOn1Z5FW3UHE55MDlSK5mHEl47I0caUf
         pQiStIdFKtk0YSm1tf3Se7KmU/RwuoNH7dmEgsb0/Y4eNH88bffy0JhC1ip6KyT4+sn7
         sFwUHtWKhO95uOCJAO/Chkjgw/mReb1tOvutog6Waad4o4mOjsFyORK1AsaGX5oA4gtD
         BnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699565239; x=1700170039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzwwVLnenU8epgb0q6ZVSvJsSZNxGycIk5GiMaPfDBA=;
        b=h35thHUtnAgO6TvK13tcSrL0XYLJ2QEzl7zjV3WcTeXEvw/3Umxq/58E/IEAztcRKs
         lI6/2nCVdR9dvCgdJY3bpLMwc7tVrbbVPjcCCnFtPgdS6bbK45iSfrDxkuS508MNErPj
         sJuNTIMMTv62ZrHoWkovRP50/L15kCwO4ZCTQWrOl/kEz85y98E+Gky2omg3S8ZmSlJb
         d9P9x+tBIbSDdFZzxRpjK1TiEK+tzHcJQovIMIesCEYphBwfEFha0Nvr1zjPQw+r763D
         /jPS3XmPG218hD5nvhCiGPxxHtLzeiS7SvgqT1J70DHiFqD/9ydhK8ShDra6t9Xvp/Y9
         J+xA==
X-Gm-Message-State: AOJu0YyAXbVuekxcJVGmkkitUU9QIijaweg7FEgtPTrOH+3/x1tO5JZn
	WHZbfZFed3fFFpsQapOoaJk=
X-Google-Smtp-Source: AGHT+IF1ShZDG3mepF3iNjjElyViaZbQIYf8RS0iwZzcEmfjGC4KaJjy1A3aguTdtJ0cIUL5xC6xKg==
X-Received: by 2002:a17:90b:4d0c:b0:27d:420:7b34 with SMTP id mw12-20020a17090b4d0c00b0027d04207b34mr3040522pjb.37.1699565238923;
        Thu, 09 Nov 2023 13:27:18 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id be11-20020a170902aa0b00b001c736370245sm3953772plb.54.2023.11.09.13.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:27:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Nov 2023 11:27:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, longman@redhat.com, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH v3 bpf-next 05/11] cgroup: Add a new helper for cgroup1
 hierarchy
Message-ID: <ZU1OtTunGctymOYo@slm.duckdns.org>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
 <20231029061438.4215-6-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029061438.4215-6-laoar.shao@gmail.com>

Hello,

On Sun, Oct 29, 2023 at 06:14:32AM +0000, Yafang Shao wrote:
> +/**
> + * task_get_cgroup1 - Acquires the associated cgroup of a task within a
> + * specific cgroup1 hierarchy. The cgroup1 hierarchy is identified by its
> + * hierarchy ID.
> + * @tsk: The target task
> + * @hierarchy_id: The ID of a cgroup1 hierarchy
> + *
> + * On success, the cgroup is returned. On failure, ERR_PTR is returned.
> + * We limit it to cgroup1 only.
> + */
> +struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id)
> +{
> +	struct cgroup *cgrp = ERR_PTR(-ENOENT);
> +	struct cgroup_root *root;
> +
> +	rcu_read_lock();
> +	for_each_root(root) {
> +		/* cgroup1 only*/
> +		if (root == &cgrp_dfl_root)
> +			continue;
> +		if (root->hierarchy_id != hierarchy_id)
> +			continue;
> +		spin_lock_irq(&css_set_lock);
> +		cgrp = task_cgroup_from_root(tsk, root);
> +		if (!cgrp || !cgroup_tryget(cgrp))
> +			cgrp = ERR_PTR(-ENOENT);
> +		spin_unlock_irq(&css_set_lock);

As Hou suggested, please use irqsave/restore. Other than that, looks fine to
me.

Thanks.

-- 
tejun

