Return-Path: <cgroups+bounces-3047-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D72408D6B5D
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2024 23:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32F1AB21991
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2024 21:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AD278C8F;
	Fri, 31 May 2024 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIYDMvHi"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE7F78C8E
	for <cgroups@vger.kernel.org>; Fri, 31 May 2024 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190040; cv=none; b=o4OfGFyNMdjkyo5R+duz2bWDz8COw/zq9gAvmjXdWmaMCdZlZLadW6N4S86JF/hW38XaZHFXp3zusla8xBtNUzPUPYGa354GfF4cs6hr7dk8fvVFJ5f7vhGpEPlpwEQZjUR8QImJGaGe6MkoMLTgYE5Z1mwn/nkqEQImBFIo1X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190040; c=relaxed/simple;
	bh=ZoonMjX+hy2dC/e3grvoJDzsRkeVHYWF+ZtOXmjMi1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMBN7cFMTZtUVS1Ekf5HmkCsNq79QT4YstcP/IyCJevhXtmOG3+XzbCl9xYFMJI2/6nywfNI97Fyc4PHYsHAaA7z7SR00l8d1Hw49VrFBHDQqoBwJOQndSwz4Xi/pJvKk0MVjtppD5gl+G2fynQmY7NCFdzXOatz1Ju6xZlBMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIYDMvHi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717190036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhJ9r9VGb6v6nJtrxpKIUn6gJ8+bAg2GbcmFOpF+Xps=;
	b=IIYDMvHiieI0EfEB8aqw1tedfe8ipsfwyQtlbXzpgj4wNGgwm3AlfheO3sRcdhgFN9p8yv
	ATRoknp8o3mHHHscQ7mTKtjjEi22dJShFRgpX2doqT2VqD5Xhyr6zUvz64A20oIGKCpplA
	vM8qlpRQ4j3QZTZsOQF+b4cbDkndnho=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-FFdWxYncNq-AimzezFZRAg-1; Fri,
 31 May 2024 17:13:53 -0400
X-MC-Unique: FFdWxYncNq-AimzezFZRAg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 287FA29AA381;
	Fri, 31 May 2024 21:13:53 +0000 (UTC)
Received: from [10.22.9.214] (unknown [10.22.9.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91B2F105480A;
	Fri, 31 May 2024 21:13:52 +0000 (UTC)
Message-ID: <31980c80-0f61-4ff7-87ab-be901f08c682@redhat.com>
Date: Fri, 31 May 2024 17:13:51 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuset: Optimize the number of iterations in the
 scheduling domain construction process
To: Xavier <ghostxavier@sina.com>, lizefan.x@bytedance.com, tj@kernel.org,
 hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240531024837.255293-1-ghostxavier@sina.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240531024837.255293-1-ghostxavier@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 5/30/24 22:48, Xavier wrote:
> The process of constructing scheduling domains involves multiple loops
> and repeated evaluations, leading to numerous redundant and ineffective
> assessments that impact code efficiency.
>
> Here, we use Union-Find to optimize the merging of cpumasks. By employing
> path compression and union by rank, we effectively reduce the number of
> lookups and merge comparisons.
>
> Signed-off-by: Xavier <ghostxavier@sina.com>
> ---
>   kernel/cgroup/cpuset.c | 117 +++++++++++++++++++++++------------------
>   1 file changed, 66 insertions(+), 51 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c12b9fdb2..4bea1c2db 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -891,6 +891,44 @@ static inline int nr_cpusets(void)
>   	return static_key_count(&cpusets_enabled_key.key) + 1;
>   }
>   
> +/*define a union find node struct*/
> +struct uf_node {
> +	int parent;
> +	int rank;
> +};
> +
> +static int find_root(struct uf_node *nodes, int x)
> +{
> +	int root = x;
> +	int parent;
> +
> +	/*Find the root node and perform path compression at the same time*/
> +	while (nodes[root].parent != root) {
> +		parent = nodes[root].parent;
> +		nodes[root].parent = nodes[parent].parent;
> +		root = parent;
> +	}
> +	return root;
> +}
> +
> +/*Function to merge two sets, using union by rank*/
> +static void union_sets(struct uf_node *nodes, int a, int b)
> +{
> +	int root_a = find_root(nodes, a);
> +	int root_b = find_root(nodes, b);
> +
> +	if (root_a != root_b) {
> +		if (nodes[root_a].rank < nodes[root_b].rank) {
> +			nodes[root_a].parent = root_b;
> +		} else if (nodes[root_a].rank > nodes[root_b].rank) {
> +			nodes[root_b].parent = root_a;
> +		} else {
> +			nodes[root_b].parent = root_a;
> +			nodes[root_a].rank++;
> +		}
> +	}
> +}
> +
>   /*
>    * generate_sched_domains()
>    *
> @@ -950,13 +988,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   	struct cpuset *cp;	/* top-down scan of cpusets */
>   	struct cpuset **csa;	/* array of all cpuset ptrs */
>   	int csn;		/* how many cpuset ptrs in csa so far */
> -	int i, j, k;		/* indices for partition finding loops */
> +	int i, j;		/* indices for partition finding loops */
>   	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
>   	struct sched_domain_attr *dattr;  /* attributes for custom domains */
>   	int ndoms = 0;		/* number of sched domains in result */
>   	int nslot;		/* next empty doms[] struct cpumask slot */
>   	struct cgroup_subsys_state *pos_css;
>   	bool root_load_balance = is_sched_load_balance(&top_cpuset);
> +	struct uf_node *nodes;
>   
>   	doms = NULL;
>   	dattr = NULL;
> @@ -1022,33 +1061,31 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   	}
>   	rcu_read_unlock();
>   
> -	for (i = 0; i < csn; i++)
> -		csa[i]->pn = i;
> -	ndoms = csn;
> -
> -restart:
> -	/* Find the best partition (set of sched domains) */
> -	for (i = 0; i < csn; i++) {
> -		struct cpuset *a = csa[i];
> -		int apn = a->pn;
> +	nodes = kmalloc_array(csn, sizeof(struct uf_node), GFP_KERNEL);
> +	if (!nodes)
> +		goto done;
>   
> -		for (j = 0; j < csn; j++) {
> -			struct cpuset *b = csa[j];
> -			int bpn = b->pn;
>   
> -			if (apn != bpn && cpusets_overlap(a, b)) {
> -				for (k = 0; k < csn; k++) {
> -					struct cpuset *c = csa[k];
> +	/* Each node is initially its own parent */
> +	for (i = 0; i < csn; i++) {
> +		nodes[i].parent = i;
> +		nodes[i].rank = 0;
> +	}
>   
> -					if (c->pn == bpn)
> -						c->pn = apn;
> -				}
> -				ndoms--;	/* one less element */
> -				goto restart;
> -			}
> +	/* Merge overlapping cpusets */
> +	for (i = 0; i < csn; i++) {
> +		for (j = i + 1; j < csn; j++) {
> +			if (cpusets_overlap(csa[i], csa[j]))
> +				union_sets(nodes, i, j);
>   		}
>   	}
>   
> +	/* Calculate the number of domains after merging */
> +	for (i = 0; i < csn; i++) {
> +		if (nodes[i].parent == i)
> +			ndoms++;
> +	}
> +
>   	/*
>   	 * Now we know how many domains to create.
>   	 * Convert <csn, csa> to <ndoms, doms> and populate cpu masks.
> @@ -1065,47 +1102,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   			      GFP_KERNEL);
>   
>   	for (nslot = 0, i = 0; i < csn; i++) {
> -		struct cpuset *a = csa[i];
> -		struct cpumask *dp;
> -		int apn = a->pn;
> -
> -		if (apn < 0) {
> -			/* Skip completed partitions */
> -			continue;
> -		}
> -
> -		dp = doms[nslot];
> -
> -		if (nslot == ndoms) {
> -			static int warnings = 10;
> -			if (warnings) {
> -				pr_warn("rebuild_sched_domains confused: nslot %d, ndoms %d, csn %d, i %d, apn %d\n",
> -					nslot, ndoms, csn, i, apn);
> -				warnings--;
> -			}
> -			continue;
> -		}
> +		struct cpumask *dp = doms[nslot];
>   
>   		cpumask_clear(dp);
>   		if (dattr)
>   			*(dattr + nslot) = SD_ATTR_INIT;
>   		for (j = i; j < csn; j++) {
> -			struct cpuset *b = csa[j];
> +			if (find_root(nodes, j) == i) {
> +				if (i == j)
> +					nslot++;
>   
> -			if (apn == b->pn) {
> -				cpumask_or(dp, dp, b->effective_cpus);
> +				cpumask_or(dp, dp, csa[j]->effective_cpus);
>   				cpumask_and(dp, dp, housekeeping_cpumask(HK_TYPE_DOMAIN));
>   				if (dattr)
> -					update_domain_attr_tree(dattr + nslot, b);
> -
> -				/* Done with this partition */
> -				b->pn = -1;
> +					update_domain_attr_tree(dattr + nslot, csa[j]);
>   			}
>   		}
> -		nslot++;
>   	}
>   	BUG_ON(nslot != ndoms);
> -
> +	kfree(nodes);
>   done:
>   	kfree(csa);
>   

I have several issues with this patch.

1) The function comment describes the algorithm to find the set of 
domains. If you change the algorithm, you have to update the comment as 
well.

2) generate_sched_domains() is not in a performance critical path, so 
its performance is not as important. Also the csn array is typically not 
that big. Changing the algorithm may introduce new bugs which leads to 
the next point.

3) How do you test your code to ensure its correctness?

I applied your patch and run the ./test_cpuset_prs.sh got the following:

[   87.850866] BUG: kernel NULL pointer dereference, address: 
0000000000000000
[   87.857832] #PF: supervisor write access in kernel mode
[   87.863067] #PF: error_code(0x0002) - not-present page
[   87.868203] PGD 0 P4D 0
[   87.870745] Oops: 0002 [#1] PREEMPT SMP NOPTI
[   87.875105] CPU: 34 PID: 8789 Comm: test_cpuset_prs Kdump: loaded Not 
tainted 6.9.0-rc2-test+ #12
[   87.883976] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS 
SE5C620.86B.0X.02.0001.043020191705 04/30/2019
[   87.894402] RIP: 0010:memset_orig+0x72/0xb0
[   87.898597] Code: 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d8 0f 
1f 84 00 00 00 00 00 89 d1 83 e1 38 74 14 c1 e9 03 66 0f 1f 44 00 00 ff 
c9 <48> 89 07 48 8d 7f 08 75 f5 83 e2 07 74 0a ff ca 88 07 48 8d 7f 01
[   87.917343] RSP: 0018:ffffa1b2a29b7d28 EFLAGS: 00010202
[   87.922568] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 
0000000000000001
[   87.929701] RDX: 0000000000000010 RSI: 0000000000000000 RDI: 
0000000000000000
[   87.936834] RBP: ffff9184d9647620 R08: 0000000000000008 R09: 
0000000000000000
[   87.943967] R10: 0000000000000000 R11: 0000000000000001 R12: 
0000000000000002
[   87.951100] R13: 0000000000000000 R14: ffff9184ccca5798 R15: 
0000000000000003
[   87.958231] FS:  00007fb51944a740(0000) GS:ffff91947eb00000(0000) 
knlGS:0000000000000000
[   87.966316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.972061] CR2: 0000000000000000 CR3: 000000109627c005 CR4: 
00000000007706f0
[   87.979194] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   87.986327] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   87.993460] PKRU: 55555554
[   87.996174] Call Trace:
[   87.998626]  <TASK>
[   88.000733]  ? __die+0x24/0x70
[   88.003802]  ? page_fault_oops+0x14a/0x510
[   88.007909]  ? __schedule+0x3d1/0x1710
[   88.011659]  ? exc_page_fault+0x77/0x170
[   88.015584]  ? asm_exc_page_fault+0x26/0x30
[   88.019772]  ? memset_orig+0x72/0xb0
[   88.023349]  rebuild_sched_domains_locked+0x4f5/0x920
[   88.028403]  update_prstate+0x137/0x4e0
[   88.032245]  sched_partition_write+0x96/0x180
[   88.036613]  kernfs_fop_write_iter+0x12c/0x1c0
[   88.041067]  vfs_write+0x30c/0x430
[   88.044481]  ksys_write+0x63/0xe0
[   88.047801]  do_syscall_64+0x87/0x170
[   88.051474]  ? exc_page_fault+0x77/0x170
[   88.055400]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   88.060453] RIP: 0033:0x7fb5192fda57
[   88.064047] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 
1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   88.082794] RSP: 002b:00007ffc6e57d2d8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[   88.090361] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 
00007fb5192fda57
[   88.097490] RDX: 0000000000000007 RSI: 000055aee3c38f40 RDI: 
0000000000000001
[   88.104623] RBP: 000055aee3c38f40 R08: 0000000000000000 R09: 
00007fb5193b14e0
[   88.111757] R10: 00007fb5193b13e0 R11: 0000000000000246 R12: 
0000000000000007
[   88.118890] R13: 00007fb5193fb780 R14: 0000000000000007 R15: 
00007fb5193f69e0
[   88.126024]  </TASK>

So it is not ready for prime time yet.

Regards,
Longman


