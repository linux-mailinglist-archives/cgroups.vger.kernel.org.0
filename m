Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7E53EA41
	for <lists+cgroups@lfdr.de>; Mon,  6 Jun 2022 19:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbiFFNti (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Jun 2022 09:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiFFNth (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Jun 2022 09:49:37 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535DCB1C39;
        Mon,  6 Jun 2022 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654523376; x=1686059376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jaFngek02KK0QVo0Pp9IxJtKrA9CbibYgveWzH0AeXs=;
  b=DY+sozS6dsl9NhmNeqobBQwfXkDubuBHELp9s7hYfJWIljb0pOByIe94
   U4F+UIu+IAlHalU7AMf7cCtTNPMPm2mhDQsGm8J7sXKsJezoweUMha3HN
   c7HHvb7OQLjeE6YhK+hUdBpwK2y4+f/6s+k57vWzj5N7+vG+f4MK/96vO
   g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jun 2022 06:49:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:49:34 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 06:49:34 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 06:49:32 -0700
Date:   Mon, 6 Jun 2022 09:49:30 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Vasily Averin <vvs@openvz.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <kernel@openvz.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH memcg v6] net: set proper memcg for net_init hooks
 allocations
Message-ID: <Yp4F6n2Ie32re7Ed@qian>
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 03, 2022 at 07:19:43AM +0300, Vasily Averin wrote:
> __register_pernet_operations() executes init hook of registered
> pernet_operation structure in all existing net namespaces.
> 
> Typically, these hooks are called by a process associated with
> the specified net namespace, and all __GFP_ACCOUNT marked
> allocation are accounted for corresponding container/memcg.
> 
> However __register_pernet_operations() calls the hooks in the same
> context, and as a result all marked allocations are accounted
> to one memcg for all processed net namespaces.
> 
> This patch adjusts active memcg for each net namespace and helps
> to account memory allocated inside ops_init() into the proper memcg.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> ---
...
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 9ecead1042b9..dad16b484cd5 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1755,6 +1755,42 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
>  	rcu_read_unlock();
>  }
>  
> +/**
> + * get_mem_cgroup_from_obj - get a memcg associated with passed kernel object.
> + * @p: pointer to object from which memcg should be extracted. It can be NULL.
> + *
> + * Retrieves the memory group into which the memory of the pointed kernel
> + * object is accounted. If memcg is found, its reference is taken.
> + * If a passed kernel object is uncharged, or if proper memcg cannot be found,
> + * as well as if mem_cgroup is disabled, NULL is returned.
> + *
> + * Return: valid memcg pointer with taken reference or NULL.
> + */
> +static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	rcu_read_lock();
> +	do {
> +		memcg = mem_cgroup_from_obj(p);
> +	} while (memcg && !css_tryget(&memcg->css));
> +	rcu_read_unlock();
> +	return memcg;
> +}
...
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 0ec2f5906a27..6b9f19122ec1 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -18,6 +18,7 @@
>  #include <linux/user_namespace.h>
>  #include <linux/net_namespace.h>
>  #include <linux/sched/task.h>
> +#include <linux/sched/mm.h>
>  #include <linux/uidgid.h>
>  #include <linux/cookie.h>
>  
> @@ -1143,7 +1144,13 @@ static int __register_pernet_operations(struct list_head *list,
>  		 * setup_net() and cleanup_net() are not possible.
>  		 */
>  		for_each_net(net) {
> +			struct mem_cgroup *old, *memcg;
> +
> +			memcg = mem_cgroup_or_root(get_mem_cgroup_from_obj(net));
> +			old = set_active_memcg(memcg);
>  			error = ops_init(ops, net);
> +			set_active_memcg(old);
> +			mem_cgroup_put(memcg);
>  			if (error)
>  				goto out_undo;
>  			list_add_tail(&net->exit_list, &net_exit_list);
> -- 
> 2.36.1

This triggers a few boot warnings like those.

 virt_to_phys used for non-linear address: ffffd8efe2d2fe00 (init_net)
 WARNING: CPU: 87 PID: 3170 at arch/arm64/mm/physaddr.c:12 __virt_to_phys
 CPU: 87 PID: 3170 Comm: modprobe Tainted: G    B   W         5.19.0-rc1-next-20220606 #138
 pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __virt_to_phys
 lr : __virt_to_phys
 sp : ffff800051cc76b0
 x29: ffff800051cc76b0 x28: ffffd8efb5ba6ab8 x27: ffffd8efb5ba6b2c
 x26: ffffd8efb1bccb20 x25: ffffd8efbaaf8200 x24: ffff800051cc77f0
 x23: ffffd8efb744a000 x22: ffffd8efbb1bc000 x21: 0000600000000000
 x20: 0000d8efe2d2fe00 x19: ffffd8efe2d2fe00 x18: 0000000000000443
 x17: 0000000000000000 x16: 0000000000000002 x15: ffffd8efb9db2000
 x14: 0000000000000001 x13: 0000000000000000 x12: ffff6806c88f8986
 x11: 1fffe806c88f8985 x10: ffff6806c88f8985 x9 : dfff800000000000
 x8 : ffff4036447c4c2b x7 : 0000000000000001 x6 : ffff6806c88f8985
 x5 : ffff4036447c4c28 x4 : ffff6806c88f8986 x3 : ffffd8efb34b3850
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff400335f99a80
 Call trace:
  __virt_to_phys
  mem_cgroup_from_obj
  __register_pernet_operations
  register_pernet_operations
  register_pernet_subsys
  nfnetlink_init [nfnetlink]
  load_module
  __do_sys_finit_module
  __arm64_sys_finit_module
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync
 irq event stamp: 0
 hardirqs last  enabled at (0):  0x0
 hardirqs last disabled at (0):  copy_process
 softirqs last  enabled at (0):  copy_process
 softirqs last disabled at (0):  0x0

 virt_to_phys used for non-linear address: ffffd8efe2d2fe00 (init_net)
 WARNING: CPU: 156 PID: 3176 at arch/arm64/mm/physaddr.c:12 __virt_to_phys
 CPU: 156 PID: 3176 Comm: modprobe Tainted: G    B   W         5.19.0-rc1-next-20220606 #138
 pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __virt_to_phys
 lr : __virt_to_phys
 sp : ffff800051b376e0
 x29: ffff800051b376e0 x28: ffffd8efb5ba6ab8 x27: ffffd8efb5ba6b2c
 x26: ffffd8efb286e910 x25: ffffd8efbaaf8200 x24: ffff800051b37820
 x23: ffffd8efb744a000 x22: ffffd8efbb1bc000 x21: 0000600000000000
 x20: 0000d8efe2d2fe00 x19: ffffd8efe2d2fe00 x18: 00000000000001cb
 x17: 0000000000000000 x16: 0000000000000002 x15: ffffd8efb9db2000
 x14: 0000000000000001 x13: 0000000000000000 x12: ffff6806c8a03f86
 x8 : ffff40364501fc2b x7 : 0000000000000001 x6 : ffff6806c8a03f85
 x5 : ffff40364501fc28 x4 : ffff6806c8a03f86 x3 : ffffd8efb34b3850
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff40033376b4c0
 Call trace:
  __virt_to_phys
  mem_cgroup_from_obj
  __register_pernet_operations
  register_pernet_operations
  register_pernet_subsys
  nf_tables_module_init [nf_tables]
  do_one_initcall
  do_init_module
  load_module
  __do_sys_finit_module
  __arm64_sys_finit_module
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync
 irq event stamp: 0
 hardirqs last  enabled at (0):  0x0
 hardirqs last disabled at (0):  copy_process
 softirqs last  enabled at (0):  copy_process
 softirqs last disabled at (0):  0x0
