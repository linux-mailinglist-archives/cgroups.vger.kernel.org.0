Return-Path: <cgroups+bounces-845-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC451806631
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 05:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A0C1F217B5
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 04:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999345C8B;
	Wed,  6 Dec 2023 04:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lYSGLz5X"
X-Original-To: cgroups@vger.kernel.org
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 20:32:31 PST
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [IPv6:2001:41d0:203:375::ba])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA802137
	for <cgroups@vger.kernel.org>; Tue,  5 Dec 2023 20:32:31 -0800 (PST)
Message-ID: <0aba58ed-e3bd-4698-9e7d-e68b03573361@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701836655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fdl0UgMszSkcJcBC82FYLBHPO9CYWXwKkX+lnucWQbo=;
	b=lYSGLz5XZ1DTERSz2JhXtxo74DgHgXS2w6MeYn00CTymqpAne/9W/wCJuiGxWIb+vevd7U
	mYJIrRx3HYcfpwuHvzKCHHI0lt170/zAGOWGPG49sUf7kU43Pmt92GlW1mS2dDESxGW5xo
	aEtHqUq8SyVwp6jxBAj4dROemiB/lh4=
Date: Tue, 5 Dec 2023 20:24:07 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 3/3] selftests/bpf: Add selftests for cgroup1
 local storage
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
 jolsa@kernel.org, tj@kernel.org
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org
References: <20231205143725.4224-1-laoar.shao@gmail.com>
 <20231205143725.4224-4-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231205143725.4224-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/5/23 9:37 AM, Yafang Shao wrote:
> Expanding the test coverage from cgroup2 to include cgroup1. The result
> as follows,
>
> Already existing test cases for cgroup2:
>    #48/1    cgrp_local_storage/tp_btf:OK
>    #48/2    cgrp_local_storage/attach_cgroup:OK
>    #48/3    cgrp_local_storage/recursion:OK
>    #48/4    cgrp_local_storage/negative:OK
>    #48/5    cgrp_local_storage/cgroup_iter_sleepable:OK
>    #48/6    cgrp_local_storage/yes_rcu_lock:OK
>    #48/7    cgrp_local_storage/no_rcu_lock:OK
>
> Expanded test cases for cgroup1:
>    #48/8    cgrp_local_storage/cgrp1_tp_btf:OK
>    #48/9    cgrp_local_storage/cgrp1_recursion:OK
>    #48/10   cgrp_local_storage/cgrp1_negative:OK
>    #48/11   cgrp_local_storage/cgrp1_iter_sleepable:OK
>    #48/12   cgrp_local_storage/cgrp1_yes_rcu_lock:OK
>    #48/13   cgrp_local_storage/cgrp1_no_rcu_lock:OK
>
> Summary:
>    #48      cgrp_local_storage:OK
>    Summary: 1/13 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

LGTM with a few nits below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   .../bpf/prog_tests/cgrp_local_storage.c       | 92 ++++++++++++++++++-
>   .../selftests/bpf/progs/cgrp_ls_recursion.c   | 84 +++++++++++++----
>   .../selftests/bpf/progs/cgrp_ls_sleepable.c   | 67 ++++++++++++--
>   .../selftests/bpf/progs/cgrp_ls_tp_btf.c      | 82 ++++++++++++-----
>   4 files changed, 278 insertions(+), 47 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
> index 63e776f4176e..9524cde4cbf6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
> @@ -19,6 +19,9 @@ struct socket_cookie {
>   	__u64 cookie_value;
>   };
>   
> +bool is_cgroup1;
> +int target_hid;
> +
>   static void test_tp_btf(int cgroup_fd)
>   {
>   	struct cgrp_ls_tp_btf *skel;
> @@ -29,6 +32,9 @@ static void test_tp_btf(int cgroup_fd)
>   	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>   		return;
>   
> +	skel->bss->is_cgroup1 = is_cgroup1;
> +	skel->bss->target_hid = target_hid;

Let reverse the order like below to be consistent with other code patterns:
+	skel->bss->target_hid = target_hid;
+	skel->bss->is_cgroup1 = is_cgroup1;

> +
>   	/* populate a value in map_b */
>   	err = bpf_map_update_elem(bpf_map__fd(skel->maps.map_b), &cgroup_fd, &val1, BPF_ANY);
>   	if (!ASSERT_OK(err, "map_update_elem"))
> @@ -130,6 +136,9 @@ static void test_recursion(int cgroup_fd)
>   	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>   		return;
>   
> +	skel->bss->target_hid = target_hid;
> +	skel->bss->is_cgroup1 = is_cgroup1;
> +
>   	err = cgrp_ls_recursion__attach(skel);
>   	if (!ASSERT_OK(err, "skel_attach"))
>   		goto out;
> [...]
> diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
> index 4c7844e1dbfa..985ff419249c 100644
> --- a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
> +++ b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
> @@ -17,7 +17,11 @@ struct {
>   
>   __u32 target_pid;
>   __u64 cgroup_id;
> +int target_hid;
> +bool is_cgroup1;
>   
> +struct cgroup *bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id) __ksym;
> +void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
>   void bpf_rcu_read_lock(void) __ksym;
>   void bpf_rcu_read_unlock(void) __ksym;
>   
> @@ -37,23 +41,56 @@ int cgroup_iter(struct bpf_iter__cgroup *ctx)
>   	return 0;
>   }
>   
> +static void __no_rcu_lock(struct cgroup *cgrp)
> +{
> +	long *ptr;
> +
> +	/* Note that trace rcu is held in sleepable prog, so we can use
> +	 * bpf_cgrp_storage_get() in sleepable prog.
> +	 */
> +	ptr = bpf_cgrp_storage_get(&map_a, cgrp, 0,
> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (ptr)
> +		cgroup_id = cgrp->kn->id;
> +}
> +
>   SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> -int no_rcu_lock(void *ctx)
> +int cgrp1_no_rcu_lock(void *ctx)
>   {
>   	struct task_struct *task;
>   	struct cgroup *cgrp;
> -	long *ptr;
> +
> +	if (!is_cgroup1)
> +		return 0;

Do we need this check? Looks like the user space controls whether it will
be loaded or not depending on whether it is cgrp1.

> +
> +	task = bpf_get_current_task_btf();
> +	if (task->pid != target_pid)
> +		return 0;
> +
> +	/* bpf_task_get_cgroup1 can work in sleepable prog */
> +	cgrp = bpf_task_get_cgroup1(task, target_hid);
> +	if (!cgrp)
> +		return 0;
> +
> +	__no_rcu_lock(cgrp);
> +	bpf_cgroup_release(cgrp);
> +	return 0;
> +}
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int no_rcu_lock(void *ctx)
> +{
> +	struct task_struct *task;
> +
> +	if (is_cgroup1)
> +		return 0;

Same here, check is not needed.

>   
>   	task = bpf_get_current_task_btf();
>   	if (task->pid != target_pid)
>   		return 0;
>   
>   	/* task->cgroups is untrusted in sleepable prog outside of RCU CS */
> -	cgrp = task->cgroups->dfl_cgrp;
> -	ptr = bpf_cgrp_storage_get(&map_a, cgrp, 0,
> -				   BPF_LOCAL_STORAGE_GET_F_CREATE);
> -	if (ptr)
> -		cgroup_id = cgrp->kn->id;
> +	__no_rcu_lock(task->cgroups->dfl_cgrp);
>   	return 0;
>   }
>   
> @@ -68,6 +105,22 @@ int yes_rcu_lock(void *ctx)
>   	if (task->pid != target_pid)
>   		return 0;
>   
> +	if (is_cgroup1) {
> +		bpf_rcu_read_lock();
> +		cgrp = bpf_task_get_cgroup1(task, target_hid);
> +		if (!cgrp) {
> +			bpf_rcu_read_unlock();
> +			return 0;
> +		}
> +
> +		ptr = bpf_cgrp_storage_get(&map_a, cgrp, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
> +		if (ptr)
> +			cgroup_id = cgrp->kn->id;
> +		bpf_cgroup_release(cgrp);
> +		bpf_rcu_read_unlock();
> +		return 0;
> +	}
> +
>   	bpf_rcu_read_lock();
>   	cgrp = task->cgroups->dfl_cgrp;
>   	/* cgrp is trusted under RCU CS */

[...]


