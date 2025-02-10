Return-Path: <cgroups+bounces-6490-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49C7A2F3D0
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 17:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B108818895F1
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5AC24394C;
	Mon, 10 Feb 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V6guh7cP"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CCF1F4625
	for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205674; cv=none; b=IYDaYc7oGjxE63DqOjk81QJ3XMKKsxKrHdRxZ6AYClHvlve6kvLqOtKUrdaySNM5RpXZuaQkhaIV8nQEmciqPEFQyBYzoBZQeRfkCjV4TqB4tfpzzkviUibXeDOfYKE/Wr0XvhSIIKyW3jXVoSoWhbqKZHQfri3xUuVIJSgm2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205674; c=relaxed/simple;
	bh=rqymZ0NurZ4uwh32hr1IPMHTuWwsGkx6A3GbSMGR6Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWnBG9jxBFOZA8nBz60CVrFt06mitn6plhre2P5wBCRhSJ9hfyY5YorUSl4wA96jTpEao5913z2N7hhu3saVXpX5PLLTlt2H2OS3W+KGDAHEpTz2twYdmemdm+UFZ8un/LzMrJKDEywkOaLDro5fD4qyglXlO9fkodScd34D0i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V6guh7cP; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cab1d59c-4dac-4a5b-8dfa-43c2ac03b675@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739205668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLKGhgf5O0fUKKbSlKGAihHeN6U7qrQ5l3EDkpVZISY=;
	b=V6guh7cPGDO66uUcdvNqRSqMaULGvA+Qft0V/aGzvtm0qN+vVAro0jceFR2y0A3QPrti+R
	4Vkk8U2ufOnStWo84Fv4ONxpbj68tL48y//OSkQEE25rMAlaX/gu2Ym8GzJ/d/F46TTIHQ
	Nfj5mxf90dLgCQESDZ2yaBJd9PhmEWI=
Date: Mon, 10 Feb 2025 08:41:00 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 5/6] kernfs: Use RCU to access kernfs_node::parent.
Content-Language: en-GB
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hillf Danton <hdanton@sina.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Marco Elver <elver@google.com>, Tejun Heo <tj@kernel.org>,
 tglx@linutronix.de, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 bpf@vger.kernel.org
References: <20250203135023.416828-1-bigeasy@linutronix.de>
 <20250203135023.416828-6-bigeasy@linutronix.de>
 <20250210084331.IJB3qKdl@linutronix.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250210084331.IJB3qKdl@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2/10/25 12:43 AM, Sebastian Andrzej Siewior wrote:
> On 2025-02-03 14:50:22 [+0100], To cgroups@vger.kernel.org wrote:
>> kernfs_rename_lock is used to obtain stable kernfs_node::{name|parent}
>> pointer. This is a preparation to access kernfs_node::parent under RCU
>> and ensure that the pointer remains stable under the RCU lifetime
>> guarantees.
> …
>
> The robot complained that the selftests for bpf broke. As it turns out,
> the tests access kernfs_node::{parent|name} and after the rename
> ::parent is gone so it does not compile.
> If there are no objections, I would merge this into 5/6 and repost.
> "test_progs -a test_profiler" passes.
>
> diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
> index 8bd1ebd7d6afd..a4f518ee5f4de 100644
> --- a/tools/testing/selftests/bpf/progs/profiler.inc.h
> +++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
> @@ -223,7 +223,7 @@ static INLINE void* read_full_cgroup_path(struct kernfs_node* cgroup_node,
>   		if (bpf_cmp_likely(filepart_length, <=, MAX_PATH)) {
>   			payload += filepart_length;
>   		}
> -		cgroup_node = BPF_CORE_READ(cgroup_node, parent);
> +		cgroup_node = BPF_CORE_READ(cgroup_node, __parent);
>   	}
>   	return payload;
>   }
> @@ -300,6 +300,7 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
>   	cgroup_data->cgroup_proc_length = 0;
>   	cgroup_data->cgroup_full_length = 0;
>   
> +	bpf_rcu_read_lock();
>   	size_t cgroup_root_length =
>   		bpf_probe_read_kernel_str(payload, MAX_PATH,
>   					  BPF_CORE_READ(root_kernfs, name));
> @@ -323,6 +324,7 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
>   		cgroup_data->cgroup_full_length = payload_end_pos - payload;
>   		payload = payload_end_pos;
>   	}
> +	bpf_rcu_read_unlock();

All programs calling this function populate_cgroup_info() is not sleepable program
so the whole prog is protected by rcu and there is no need for above
bpf_rcu_read_{lock,unlock}().

>   
>   	return (void*)payload;
>   }


