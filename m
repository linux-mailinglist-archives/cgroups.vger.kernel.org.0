Return-Path: <cgroups+bounces-9055-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B397CB1F558
	for <lists+cgroups@lfdr.de>; Sat,  9 Aug 2025 18:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C9318C4602
	for <lists+cgroups@lfdr.de>; Sat,  9 Aug 2025 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724A92BE04F;
	Sat,  9 Aug 2025 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fouR70ma"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD3E190692;
	Sat,  9 Aug 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754755573; cv=none; b=q+rrGbu4/vsT2Vv4ZamMU3CcqeiNKkwa+YII9kYJf+7r0llCyxuOg6PS3JqW36FepDsMzGGFpRjvmsEvd4UkAd7H6SR64rkSi1mWawRdB9AMG1ygNGTbp3jtm7UQ2w5X0AcrKnlekozKlTVqULzL3+YklJGRyWJ+w0FSuGQ8+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754755573; c=relaxed/simple;
	bh=HAk69Pc5A1YrLY9i1RUYP3nywrOxPYN1GCMeY35TGyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1X1YK0JnLksD4LfSv7jWBNKsJIg16WXPXptN6+FK9kK+8A2hxTzIzozAjy1XDdDdtZcORMbeVti6XcYOeep4NZm3JYt1VvUHdKIPfVKah1aPokGZQ2+Rs6+AY8VRqUfWfMkCz1Tu9cHagVJtVu96M7SnTy+oYMifxqBWHNlFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fouR70ma; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id klw9uY1qF0fq3klwAueszH; Sat, 09 Aug 2025 17:57:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1754755020;
	bh=BiEn152QsMiVFPSw+oP65Hk1xCKOktxxpDWtbkBNJYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=fouR70maiFpPNUbTdYT+PBrW8VWShFOn3ifEPCIwLGJUEiir+pDcDJP0s/DTLLzmu
	 IPQHY2m6D3OhjTbYCNAMET1tORvsH0d0tslJrosrQ9MCvbtoya3ebtjR2uK/e/KjFY
	 H+l1mTHLs6jzsJpmJmKd50WaNGxAEJ/LwjhSGkcvt+J245SwQAKY8MHIQ6wvh58C72
	 52vCb9VScqzdVWl8qVkhXlC00gHhJSs4g3vXQehM2MG5grWTF/WJy1JmaFsQzsZWiX
	 R8f7Uq/aH3Q1J5PFLF+cScSBQ6oPSepL8GatOIYmOmRBIROcH75qizqwevF+ydyAs/
	 mekdWCuiloPEg==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 09 Aug 2025 17:57:00 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <30dd9cb7-8471-400e-b293-a1a52921a5f3@wanadoo.fr>
Date: Sat, 9 Aug 2025 17:56:49 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/4] cpuset: add helpers for cpuset related locks
To: chenridong@huaweicloud.com
Cc: bsegall@google.com, cgroups@vger.kernel.org, chenridong@huawei.com,
 dietmar.eggemann@arm.com, hannes@cmpxchg.org, juri.lelli@redhat.com,
 linux-kernel@vger.kernel.org, longman@redhat.com, lujialin4@huawei.com,
 mgorman@suse.de, mingo@redhat.com, mkoutny@suse.com, peterz@infradead.org,
 rostedt@goodmis.org, tj@kernel.org, vincent.guittot@linaro.org,
 vschneid@redhat.com
References: <20250808092515.764820-1-chenridong@huaweicloud.com>
 <20250808092515.764820-3-chenridong@huaweicloud.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20250808092515.764820-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/08/2025 à 11:25, Chen Ridong a écrit :
> From: Chen Ridong <chenridong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> 
> Add guard_cpus_read_and_cpuset and guard_cpuset helpers for cpuset, which
> will be user for subsequent patched to make code concise;
> 
> Signed-off-by: Chen Ridong <chenridong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>   include/linux/cpuset.h          |  1 +
>   kernel/cgroup/cpuset-internal.h |  2 ++
>   kernel/cgroup/cpuset.c          | 11 +++++++++++
>   3 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 2ddb256187b5..6153de28acf0 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -74,6 +74,7 @@ extern void inc_dl_tasks_cs(struct task_struct *task);
>   extern void dec_dl_tasks_cs(struct task_struct *task);
>   extern void cpuset_lock(void);
>   extern void cpuset_unlock(void);
> +extern void guard_cpuset(void);
>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
>   extern bool cpuset_cpu_is_isolated(int cpu);
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 75b3aef39231..084e19fe33d5 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -277,6 +277,8 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   				    char *buf, size_t nbytes, loff_t off);
>   int cpuset_common_seq_show(struct seq_file *sf, void *v);
>   
> +void guard_cpus_read_and_cpuset(void);
> +
>   /*
>    * cpuset-v1.c
>    */
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index cf7cd2255265..f6cdb5cdffe8 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -260,6 +260,17 @@ void cpuset_unlock(void)
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> +void guard_cpuset(void)
> +{
> +	guard(mutex)(&cpuset_mutex);
> +}
> +
> +void guard_cpus_read_and_cpuset(void)
> +{
> +	guard(cpus_read_lock)();
> +	guard(mutex)(&cpuset_mutex);
> +}
> +

Not sure that it works like that.

I think that these 2 functions are just no-op because whatever is 
"garded", it will be release when the function exits.

So, if correct, all this serie does is removing some existing 
synchronisation mechanism.

Do I miss something obvious?

CJ


>   static DEFINE_SPINLOCK(callback_lock);
>   
>   void cpuset_callback_lock_irq(void)


