Return-Path: <cgroups+bounces-6222-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DEAA151F8
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 15:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5DF16932B
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E650515749A;
	Fri, 17 Jan 2025 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBaQ5roy"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5330D18A6BD
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124756; cv=none; b=bjY1k6UEej+XcrxDCXbng1rH+K8mRGGFUBxmQsjGIOoU6F2bMMraX7zrYFtP5mWOusuHCE1fUEdbOH1RxIVpiktcykYAC99Ch8eU7hJRINqkRkk9NKQwlWj1JrNbBZmm4UGWczRqYvbLxlnY4393VMpyaHzb1sTYefvqmkA7B1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124756; c=relaxed/simple;
	bh=9aiV2WsoLtIXwxpY7L4SKMGw4fuYcqk+6LtnvmqJvXo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VITCtpxrYVPBYSoPzW4vh04ypT7mitFuh4yC4IJKY+aOumGogi+nOHGZUsDzSQPNlJJMG9ldqUd76EC0e3aCfv8iA05ZlpXCPxICpfu63WKD2KZa9AH2bq5bq+M0Xd0NHuxE2y0Rqb6x0U7SujKZ8a9bDkZRiiAaxKpJicxKH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBaQ5roy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737124753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dhUxCyRP1cMoxBuRi9UmIeVL7KMWt6XgO3KvXP/K3E=;
	b=jBaQ5roy44l1ePY5wVEw0uSQpogv087NinFuzT32KPQlVrRYpA88uhhGvSW5KF7B+zIJ+p
	knStrk8STBM1RebaOs/SEOMuujetZnLGZEOChyWEiBUgRf2Xae4pYn4VbMEdO37/tU6MSn
	Jse0XKMgKFMGULJgCMzFuhyhrS+mtM4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-D1QWwG_WOBuZsWJCxKOG0Q-1; Fri, 17 Jan 2025 09:39:12 -0500
X-MC-Unique: D1QWwG_WOBuZsWJCxKOG0Q-1
X-Mimecast-MFC-AGG-ID: D1QWwG_WOBuZsWJCxKOG0Q
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6fe99d179so465152085a.2
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 06:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737124751; x=1737729551;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dhUxCyRP1cMoxBuRi9UmIeVL7KMWt6XgO3KvXP/K3E=;
        b=GW4tIAp9DzY6xFGtRAMc0Seu+ie9lkLsYIYcFMdqOn0IW3J5fpW1OqPS6bt54uwvWS
         dCH8Mk18hkAwiQgDKH0dEyUGt36/n2C2y+ULuuwxtDbo4sX1ASzCWT07KCqqhtB5GRgD
         k4DLQJIgKUdhexca8Ud3GDS4zKBExrc/m0Aa6YkQLRm70h3gmYKGFgDL92qoSq4DkgOV
         9hmuJEj+H2EY/GPA1rj2noIptcAY7xywIZfSvfjgQZ2D+FVwxj5W1dwNbmiUoX2mVa0x
         Hf7sgfWqzHAOVzH2ZaCC1jipQxJtwtYEB1Wxo3/raPLqn0uSAfjEa85FpWTSAaGMG7cj
         JCnw==
X-Forwarded-Encrypted: i=1; AJvYcCWTLZIRY9hKWJmBp+iRuuk5f6kQoow9jP2laphatj1NVsvVwKN3NqPp4W3vsqvtrlwURBOxDetq@vger.kernel.org
X-Gm-Message-State: AOJu0YyIQVrbU3RVuoe8xdW/5s2iqlmOQlIL0IDbXWpLnHpu3E287P7k
	p0yTz+sSw/rEOZg2kQ+vjpIjNLxQhzKmuEZ/mraB1UUO4FxQEwJNESCBhY+WbCbMMTGVHZTY47h
	Ek0tem2B8kwVPBDzizrQ82/L8sNI41JxJWnl2GhHnQrTUMK9aPuOX2YY=
X-Gm-Gg: ASbGncu53n0CFDs6feFnKgjs63F+uCwJqQ6WltyGqtUPZSZi2ecTlzcpnF7NxAid5IW
	ShpPuXU7nit2mKLECqu+0AfWi2D2lsbdeBvi2f8N9uJXVLqG+kmZmakEAMxVT4wE9D11g+SRbCx
	YKbZJZXlorud5raPYaBPEYEg42u0YsFuwSZh7SEQQK+FdItvTVeNiIPUqI2yxHH2YsXgsThfRoY
	hLxpiNl7x4DHMhk2Q2qzW6GDi4qoaAwfp+vUSjJLjryfSoVnMI6pKXTCgjEe4qQATzhuJGSi+0n
	OpVXNOKJSwC59Ah7EDTfwvGIrF4=
X-Received: by 2002:a05:620a:2627:b0:7b6:d4a2:f11f with SMTP id af79cd13be357-7be63157d1fmr465180285a.0.1737124751439;
        Fri, 17 Jan 2025 06:39:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+a4qCjRsKvr+LzOKQI3elbUu5VyiP4pOK72L6494wLjwnoFS8gYiJXz1lvDLanaCJMQccxQ==
X-Received: by 2002:a05:620a:2627:b0:7b6:d4a2:f11f with SMTP id af79cd13be357-7be63157d1fmr465176185a.0.1737124750995;
        Fri, 17 Jan 2025 06:39:10 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614d9af2sm118375885a.77.2025.01.17.06.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 06:39:10 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b3988753-bd9e-400c-a9ab-a0d54324b9e1@redhat.com>
Date: Fri, 17 Jan 2025 09:39:09 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: Move procfs cpuset attribute under
 cgroup-v1.c
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Chen Ridong <chenridong@huawei.com>
References: <20250116095656.643976-1-mkoutny@suse.com>
 <b90d0be9-b970-442d-874d-1031a63d1058@redhat.com>
 <l7o4dygoe2h7koumizjqljs7meqs4dzngkw6ugypgk6smqdqbm@ocl4ldt5izmr>
 <Z4lA702nBSWNFQYm@slm.duckdns.org>
 <3ebd4519-4699-47ff-901e-a3ce30e45bcd@redhat.com>
 <Z4lgLxZXjoKuMh3r@slm.duckdns.org>
 <7ft2u3u5kniyb6s7tcajsntvmn7kbico7yjclgamjlr5rgqvwk@vzfqbcivt77i>
Content-Language: en-US
In-Reply-To: <7ft2u3u5kniyb6s7tcajsntvmn7kbico7yjclgamjlr5rgqvwk@vzfqbcivt77i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/17/25 5:44 AM, Michal Koutný wrote:
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
>   kernel/cgroup/cpuset-v1.c | 40 +++++++++++++++++++++++++++++++++++
>   kernel/cgroup/cpuset.c    | 44 ---------------------------------------
>   3 files changed, 43 insertions(+), 46 deletions(-)
>
> v2 changes:
> - explicitly say what's part of CPUSETS_V1
> - commit message wrt effective paths
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
> index 25c1d7b77e2f2..fff1a38f2725f 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -373,6 +373,46 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
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
> index 0f910c828973a..7d6e8db234290 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4244,50 +4244,6 @@ void cpuset_print_current_mems_allowed(void)
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
Acked-by: Waiman Long <longman@redhat.com>


