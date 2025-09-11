Return-Path: <cgroups+bounces-9978-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA6DB526FD
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 05:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265243A3E98
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 03:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CAC238C2A;
	Thu, 11 Sep 2025 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYOZJ9Vp"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41800236453
	for <cgroups@vger.kernel.org>; Thu, 11 Sep 2025 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560930; cv=none; b=UFQex4EeMvmmnaFVe2M0DszE8l0gb8w2y70BjCz6Q43N6fSbnRK1zqpe+hlCwq2eDhhCQ3qiA3x3Z0y909ZVfEwYIbxX1Kc8Atgb7KC0scIw5tKz8r0RaNQH3k/890ldYd3FOGarcM+dR/WNDyznYOjlSi1caThHWw5RSxD3CBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560930; c=relaxed/simple;
	bh=+Z8QomStjHp20zopj4gbng+cuHhjPRazDXDh4UGFg4A=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IHQYRsUXQpSpEZsjaUtImlmjfslRR2McRHyFcX+U6MHGb+tadM3pb34rCXnB8Irs3d1PtuEQ4MQsn1v6HH5r2tR2x/eLjPqLCglQhfj312zqXDlt1PkZJJftB2zWvfpd0Pi6uK44KeG8gko6eATl3CfjeLpPY5Y5WcRqexVeOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYOZJ9Vp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757560927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zUXNHK5jTe8K1SbWnZOWeRa/Xg+geoh26Woq/IY2Vg=;
	b=GYOZJ9VpkqP+s+ekz1Ts4aI6CrPt3ID6Uid3NHzd7blUKF5iIQ9gdy1MLHEKZYeLAt/u/W
	mfQDhYRemqi4NjQUxUX0+0n0A16TbzDOYW3Rrtory53HvE5vJy6q6L5Lnuu0NCJSHtNLq8
	2fmAbviJ7L3Grb+LjLeOIzv7d6DDuxY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-VFOyxT01NCysbx4kqG-5DQ-1; Wed, 10 Sep 2025 23:22:05 -0400
X-MC-Unique: VFOyxT01NCysbx4kqG-5DQ-1
X-Mimecast-MFC-AGG-ID: VFOyxT01NCysbx4kqG-5DQ_1757560925
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8163e227454so50660385a.0
        for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 20:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757560925; x=1758165725;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zUXNHK5jTe8K1SbWnZOWeRa/Xg+geoh26Woq/IY2Vg=;
        b=MYCic3dsWMsXEX0vrF1RHFPgpfQPh7N7OQgTs/RN7rzIzBNPODeDu/it7tQsTj/7jX
         Wln9Lmlyz/+PPXNX1Vn1wODLQUh3R0SoKDi8CS2om5KkrpgZvgaPEnUQ2dMTGs2QjA6u
         gn9MxD4kbJ4c+wU2UPW7uzKdXtXdeShwqSDg3YtCypQrYfadjsdElQ5SvNRoTEB+Xe8O
         nBhyWe6SPocgDFUcpsSh5PeK8T2n47gR7PlAgUcHBA04OoJH8sxv9DBai/adCdhPQSoM
         rtO27/Y8vTXhalrhJvUIznImylAvSavRdXY3g1W7wi9s/L+PJKhUlS0EW3NBSyRkpRJq
         YbOg==
X-Gm-Message-State: AOJu0YySa9AMRrQfVQhggOQ7aIOBokrlMdDWWfBj6e5h5NJFGZdCLCXp
	XH1WpSxTIV2dIs9wQwSOo9z/6HxHaNAVtBdPKpF1THLAD3fdpUPQ0tYV9CUbTJaT/vphF31C1hv
	ZxvkhvARgZVADNP9bL6g3bTBuXlGEmhlCyGJT7BYWkXcc4NAkdKWDwc+LF10=
X-Gm-Gg: ASbGncsOhYJUOdjLnjs/oWUF+ZMNPZjN/EErwHq/Cz7k9f63wqmcm3ebJf+wjAMLuxi
	Fmk70UQbl0DPKM303rdp+gREC2Uc8k5FS+frXX7bZ5U5REd4KQEM8qAiBcFdyUmTiSMSruKFLJ1
	12e8aeuDXaWyiljZZY1jLK9Rbs7802G+KJICMHPLqM50CwLne+yMaW6p+QoONEoqkuj1zIglSKW
	5h0HlUcNHkuDizGEK/WQsoLkmBdZsiVvsXHLbrO02+iLdcFISQkxHx6cT7dpqpAO1hn04ZxJWG2
	XA4lWheK87WUUFk8pTgVnbTe6we3fitcsPszipWWGR0Vc7jBFKbynhWlfvSMpmxXVOsbt/fVb40
	dJuQKaOxz8w==
X-Received: by 2002:a05:620a:44c5:b0:81d:25c2:2c4e with SMTP id af79cd13be357-81d25c22cedmr807576185a.46.1757560925331;
        Wed, 10 Sep 2025 20:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6wIOxn+qzor+UFLMAx2tye8L0X7/ZJxBN9Pud85Nk4+Sk0PWu/AUbUjuFuG0tNMUXDzD8sQ==
X-Received: by 2002:a05:620a:44c5:b0:81d:25c2:2c4e with SMTP id af79cd13be357-81d25c22cedmr807573685a.46.1757560924769;
        Wed, 10 Sep 2025 20:22:04 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c9846379sm32341485a.18.2025.09.10.20.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 20:22:04 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b547fd22-4363-403a-a427-c20526fcf063@redhat.com>
Date: Wed, 10 Sep 2025 23:22:03 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] cgroup: relocate cgroup_attach_lock within
 cgroup_procs_write_start
To: Yi Tao <escape@linux.alibaba.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1757486368.git.escape@linux.alibaba.com>
 <324e2f62ed7a3666e28768d2c35b8aa957dd1651.1757486368.git.escape@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <324e2f62ed7a3666e28768d2c35b8aa957dd1651.1757486368.git.escape@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/25 2:59 AM, Yi Tao wrote:
> Later patches will introduce a new parameter `task` to
> cgroup_attach_lock, thus adjusting the position of cgroup_attach_lock
> within cgroup_procs_write_start.
>
> Between obtaining the threadgroup leader via PID and acquiring the
> cgroup attach lock, the threadgroup leader may change, which could lead
> to incorrect cgroup migration. Therefore, after acquiring the cgroup
> attach lock, we check whether the threadgroup leader has changed, and if
> so, retry the operation.
>
> Signed-off-by: Yi Tao <escape@linux.alibaba.com>
> ---
>   kernel/cgroup/cgroup.c | 61 ++++++++++++++++++++++++++----------------
>   1 file changed, 38 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 2b88c7abaa00..756807164091 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2994,29 +2994,13 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>   	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>   		return ERR_PTR(-EINVAL);
>   
> -	/*
> -	 * If we migrate a single thread, we don't care about threadgroup
> -	 * stability. If the thread is `current`, it won't exit(2) under our
> -	 * hands or change PID through exec(2). We exclude
> -	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
> -	 * callers by cgroup_mutex.
> -	 * Therefore, we can skip the global lock.
> -	 */
> -	lockdep_assert_held(&cgroup_mutex);
> -
> -	if (pid || threadgroup)
> -		*lock_mode = CGRP_ATTACH_LOCK_GLOBAL;
> -	else
> -		*lock_mode = CGRP_ATTACH_LOCK_NONE;
> -
> -	cgroup_attach_lock(*lock_mode);
> -
> +retry_find_task:
>   	rcu_read_lock();
>   	if (pid) {
>   		tsk = find_task_by_vpid(pid);
>   		if (!tsk) {
>   			tsk = ERR_PTR(-ESRCH);
> -			goto out_unlock_threadgroup;
> +			goto out_unlock_rcu;
>   		}
>   	} else {
>   		tsk = current;
> @@ -3033,15 +3017,46 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>   	 */
>   	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) {
>   		tsk = ERR_PTR(-EINVAL);
> -		goto out_unlock_threadgroup;
> +		goto out_unlock_rcu;
>   	}
>   
>   	get_task_struct(tsk);
> -	goto out_unlock_rcu;
> +	rcu_read_unlock();
> +
> +	/*
> +	 * If we migrate a single thread, we don't care about threadgroup
> +	 * stability. If the thread is `current`, it won't exit(2) under our
> +	 * hands or change PID through exec(2). We exclude
> +	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
> +	 * callers by cgroup_mutex.
> +	 * Therefore, we can skip the global lock.
> +	 */
> +	lockdep_assert_held(&cgroup_mutex);
> +
> +	if (pid || threadgroup)
> +		*lock_mode = CGRP_ATTACH_LOCK_GLOBAL;
> +	else
> +		*lock_mode = CGRP_ATTACH_LOCK_NONE;
> +
> +	cgroup_attach_lock(*lock_mode);
> +
> +	if (threadgroup) {
> +		if (!thread_group_leader(tsk)) {
Nit: You can combine the 2 conditions together to avoid excessive indent.

  if (threadgroup && !thread_group_leader(tsk)) {

> +			/*
> +			 * a race with de_thread from another thread's exec()
Should be "de_thread()" to signal that it is a function.
> +			 * may strip us of our leadership, if this happens,
> +			 * there is no choice but to throw this task away and
> +			 * try again; this is
> +			 * "double-double-toil-and-trouble-check locking".

This "double-double-toil-and-trouble-check" is a new term in the kernel 
source tree. I will suggest to use something simpler to avoid confusion.

Cheers, Longman


