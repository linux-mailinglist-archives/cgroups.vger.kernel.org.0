Return-Path: <cgroups+bounces-6242-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5DCA16F20
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2025 16:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5992E3A7577
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2025 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E091E5726;
	Mon, 20 Jan 2025 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pvy8Nlbl"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904881E32D9
	for <cgroups@vger.kernel.org>; Mon, 20 Jan 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386207; cv=none; b=COojIvqhWwZPG7rGllBwtwuCZu8JSQQC91oZh1QD+VTqVUZZL21MTQW14VhG+6Otm4/M+Ro+aw27X3rx4zvEYOhTtVnWDm3KNUYCkwYVjrVp+yYi0qZPf3Zf3Ve+dYz8pSUc5b2InaOXvmdS2lbVgME8UWUlEHz1+jsj3gOHugo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386207; c=relaxed/simple;
	bh=9+9b9SG5sk+pAABUD6zvKqDzoH/IskHcubMLq+I3ta0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RG+3qY7NA3BdV/dbuEfXzO5CJn+3yE6gFRf0aNtJh13cKhbp2bJHZkn6i3jphN/xQIEMyQlJgDpHd5E2f5weWMQ1JlsAMZW7LOJnZPINHufpU7Ja6tjq2x+XUIDpUvKfesrLDa6JumkSPRcIyDhF4kxDrCAQe6FAns5di0CfVSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pvy8Nlbl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737386203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFVwk2VrsevalC6D6th0fx99IWTy+CMBjZ3Dt3EDL28=;
	b=Pvy8Nlbl2dstI4/rXKAbZeoNU91RJrB+GSwHPPnLFLhPOSAYcjjo5TQ2UCpnEyNMATGkTu
	EIGZ3f1VM0t2pQoGsJT1wtkDCG7O60Y1gkYJieZSxEmCTljGJ8nKoEQKooq7i/VKLRsFqT
	CGbrdxFD7EMU6qx8GBsKHIgXy8egkGI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-hJBPFuTSNViehbeG5q1B4Q-1; Mon, 20 Jan 2025 10:16:40 -0500
X-MC-Unique: hJBPFuTSNViehbeG5q1B4Q-1
X-Mimecast-MFC-AGG-ID: hJBPFuTSNViehbeG5q1B4Q
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b9e433351dso900877585a.3
        for <cgroups@vger.kernel.org>; Mon, 20 Jan 2025 07:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737386200; x=1737991000;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFVwk2VrsevalC6D6th0fx99IWTy+CMBjZ3Dt3EDL28=;
        b=PLJFGlnTpl67W5LB53NSYBdWcSCy/R0CWGeJL7g/VTTpLhIx/dRRL5FvFYI4vlf5wJ
         lr7b0801pNf5IDTiGNpCv4DljYN14IlLJFxTiaxRVLHmQ/P1iZGsEHbzlkT+lsVsvVcH
         UcPLW4Kpk0Colz/gqAXbLveck+tcW/p2DPRihbNwOIWM0Owz/VSB+UFZtyzoyB53yM9F
         9PCU/qGFlcxrstcfvy0kp2ZwCQGj3D2pbY4NRB2ge+Ni+oY4vFVMDJeCYRSRDjyMa39O
         VxCesky33YFtkzeG0cvFzQ9AZu1rDXaD0FYFfY9/HS29SOoP38rWfZROnxmwliQdGmlt
         GNgg==
X-Forwarded-Encrypted: i=1; AJvYcCUU8o7lu54KvkwKp4bWCSEHCwRpSjHHOD0aXLHk3wwCOxkW7CgkvXzIqJvgbvS3QPya9lBZTNb2@vger.kernel.org
X-Gm-Message-State: AOJu0YxQqHRqjk3TrrY+apXFeC8KZ/+Msr1zdghGojb7I208IiR7B/qG
	15q4mpzdkPtUkcKtRST2mib0sNjvGvIqciCjvCyktB5NXTjBaPAeDi/bq6+uY61KCKXO8M5kaPd
	dhyNnNMUVgTzL7NfTqBTuJWmV9suyZnh01RdA0bokSnoNlnhPqm5/TC8=
X-Gm-Gg: ASbGncus3W293ohE4kl9qA5KWiusN9hxJRzxerAtZZvCcbUaYbWdFayY8+IDolovjr9
	hmUr1FPjeWWmQnSS4coywDEXWG7NTLbk5Nzj/w3RbWpkpSXU7u2xNYjOMjN6vJlE/o9kuTh3TYY
	Zu2XbGgyO3fz1hYTNkmplnhRqw1HSda4xmuDWU23dxwoW1RTN5KwzqpMJIZNS1rar4sCyvJ2k9u
	i3w5VGj5fG8wlY41tGq7PajW689GSiTU4SHhNZ75Wl8r5GYgy48nkef9iK+aOhI4NbXy1XXNhjH
	QJTyyUQH4q3Ln5WIsMcQC5zO4rpr13w58fmLVFgQ
X-Received: by 2002:a05:620a:2888:b0:7b6:c695:fb7c with SMTP id af79cd13be357-7be6320c398mr2036648885a.33.1737386199927;
        Mon, 20 Jan 2025 07:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAugYu7eAzmB+V9801n/X6ILhXl5Iy718gPDbhQMp+yDHefGSzACN/HgoHHGjsPG6oXOpdJQ==
X-Received: by 2002:a05:620a:2888:b0:7b6:c695:fb7c with SMTP id af79cd13be357-7be6320c398mr2036645285a.33.1737386199619;
        Mon, 20 Jan 2025 07:16:39 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be6147f46fsm452707485a.35.2025.01.20.07.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 07:16:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d7f471a0-bf06-402d-a98f-0346ea8a30ef@redhat.com>
Date: Mon, 20 Jan 2025 10:16:38 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cgroup/cpuset: Move procfs cpuset attribute under
 cgroup-v1.c
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Chen Ridong <chenridong@huawei.com>
References: <20250120145749.925170-1-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250120145749.925170-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/20/25 9:57 AM, Michal Koutný wrote:
> The cpuset file is a legacy attribute that is bound primarily to cpuset
> v1 hierarchy (equivalent information is available in /proc/$pid/cgroup path
> on the unified hierarchy in conjunction with respective
> cgroup.controllers showing where cpuset controller is enabled).
>
> Followup to commit b0ced9d378d49 ("cgroup/cpuset: move v1 interfaces to
> cpuset-v1.c") and hide CONFIG_PROC_PID_CPUSET under CONFIG_CPUSETS_V1.
> Drop an obsolete comment too.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   init/Kconfig              |  5 +++--
>   kernel/cgroup/cpuset-v1.c | 41 +++++++++++++++++++++++++++++++++++
>   kernel/cgroup/cpuset.c    | 45 ---------------------------------------
>   3 files changed, 44 insertions(+), 47 deletions(-)
>
> v3 changes:
> - move dependency on internal cgroup-internal.h to v1-only too
>    Reported-by: kernel test robot <lkp@intel.com>
>    Link: https://lore.kernel.org/oe-kbuild-all/202501180315.KcDn5BG5-lkp@intel.com/
>
> v2 changes:
> - explicitly say what's part of CPUSETS_V1
> - commit message wrt effective paths
Acked-by: Waiman Long <longman@redhat.com>

>
> diff --git a/init/Kconfig b/init/Kconfig
> index a20e6efd3f0fb..2f3121c49ed23 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1182,7 +1182,8 @@ config CPUSETS_V1
>   	help
>   	  Legacy cgroup v1 cpusets controller which has been deprecated by
>   	  cgroup v2 implementation. The v1 is there for legacy applications
> -	  which haven't migrated to the new cgroup v2 interface yet. If you
> +	  which haven't migrated to the new cgroup v2 interface yet. Legacy
> +	  interface includes cpuset filesystem and /proc/<pid>/cpuset. If you
>   	  do not have any such application then you are completely fine leaving
>   	  this option disabled.
>   
> @@ -1190,7 +1191,7 @@ config CPUSETS_V1
>   
>   config PROC_PID_CPUSET
>   	bool "Include legacy /proc/<pid>/cpuset file"
> -	depends on CPUSETS
> +	depends on CPUSETS_V1
>   	default y
>   
>   config CGROUP_DEVICE
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 25c1d7b77e2f2..81b5e2a50d587 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   
> +#include "cgroup-internal.h"
>   #include "cpuset-internal.h"
>   
>   /*
> @@ -373,6 +374,46 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
>   	return ret;
>   }
>   
> +#ifdef CONFIG_PROC_PID_CPUSET
> +/*
> + * proc_cpuset_show()
> + *  - Print tasks cpuset path into seq_file.
> + *  - Used for /proc/<pid>/cpuset.
> + */
> +int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
> +		     struct pid *pid, struct task_struct *tsk)
> +{
> +	char *buf;
> +	struct cgroup_subsys_state *css;
> +	int retval;
> +
> +	retval = -ENOMEM;
> +	buf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!buf)
> +		goto out;
> +
> +	rcu_read_lock();
> +	spin_lock_irq(&css_set_lock);
> +	css = task_css(tsk, cpuset_cgrp_id);
> +	retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
> +				       current->nsproxy->cgroup_ns);
> +	spin_unlock_irq(&css_set_lock);
> +	rcu_read_unlock();
> +
> +	if (retval == -E2BIG)
> +		retval = -ENAMETOOLONG;
> +	if (retval < 0)
> +		goto out_free;
> +	seq_puts(m, buf);
> +	seq_putc(m, '\n');
> +	retval = 0;
> +out_free:
> +	kfree(buf);
> +out:
> +	return retval;
> +}
> +#endif /* CONFIG_PROC_PID_CPUSET */
> +
>   static u64 cpuset_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
>   {
>   	struct cpuset *cs = css_cs(css);
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 0f910c828973a..5a637292faa20 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -21,7 +21,6 @@
>    *  License.  See the file COPYING in the main directory of the Linux
>    *  distribution for more details.
>    */
> -#include "cgroup-internal.h"
>   #include "cpuset-internal.h"
>   
>   #include <linux/init.h>
> @@ -4244,50 +4243,6 @@ void cpuset_print_current_mems_allowed(void)
>   	rcu_read_unlock();
>   }
>   
> -#ifdef CONFIG_PROC_PID_CPUSET
> -/*
> - * proc_cpuset_show()
> - *  - Print tasks cpuset path into seq_file.
> - *  - Used for /proc/<pid>/cpuset.
> - *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
> - *    doesn't really matter if tsk->cpuset changes after we read it,
> - *    and we take cpuset_mutex, keeping cpuset_attach() from changing it
> - *    anyway.
> - */
> -int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
> -		     struct pid *pid, struct task_struct *tsk)
> -{
> -	char *buf;
> -	struct cgroup_subsys_state *css;
> -	int retval;
> -
> -	retval = -ENOMEM;
> -	buf = kmalloc(PATH_MAX, GFP_KERNEL);
> -	if (!buf)
> -		goto out;
> -
> -	rcu_read_lock();
> -	spin_lock_irq(&css_set_lock);
> -	css = task_css(tsk, cpuset_cgrp_id);
> -	retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
> -				       current->nsproxy->cgroup_ns);
> -	spin_unlock_irq(&css_set_lock);
> -	rcu_read_unlock();
> -
> -	if (retval == -E2BIG)
> -		retval = -ENAMETOOLONG;
> -	if (retval < 0)
> -		goto out_free;
> -	seq_puts(m, buf);
> -	seq_putc(m, '\n');
> -	retval = 0;
> -out_free:
> -	kfree(buf);
> -out:
> -	return retval;
> -}
> -#endif /* CONFIG_PROC_PID_CPUSET */
> -
>   /* Display task mems_allowed in /proc/<pid>/status file. */
>   void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *task)
>   {


