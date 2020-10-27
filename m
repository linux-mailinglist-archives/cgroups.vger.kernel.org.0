Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E7329C78E
	for <lists+cgroups@lfdr.de>; Tue, 27 Oct 2020 19:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828842AbgJ0SiG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Oct 2020 14:38:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44392 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1816649AbgJ0SiF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Oct 2020 14:38:05 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09RISnKi018227;
        Tue, 27 Oct 2020 11:37:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=cMXVRTSs1DLVZpM6m4yWKuNVljKiv3hC5Od+bfp0gcE=;
 b=XACdmCG/KaAs8w+ZQDoUn4Vc6pxJssn64FuMXr7qVImsdBLLmLtqmBT4+rTB9zAkZrhG
 SbALGK1hZ7DZa/tnV4yejoFzgtU+bpTT0i/oX6dwwey9BX5aGAcVUUoMQUKzy2M9UcBR
 hpuWwlg2pbKl/qKSH4uVvmdHGcYWqweIs+Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34egnf302w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Oct 2020 11:37:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 27 Oct 2020 11:37:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbeDxVLGO0l8nByhW0VuOoUxwBlUVKqUZJVDrjgBcCgEKoByacBJm8wRU9ZCoOT7WYIgb/kj2aTVPqiYCvJPaXIbmPafySz9gaJkQbZzCPwMz4eLl8uKkl1S7+eRZPngIMoorBt7Lfflmt1fZpisnX4qa5KxZ9vieEWrWE3oEr6Sa6MW+k/JbfBBQ3SzALYNxrwG0IKXXgbUq+Zl4MpHoxTomx47eMTkVDljy9rtKhIbmdV7Ddjcsw8+fhM1et6LuSBD6ciyDY9m2XybLVpiNHuqLBibJuQXJ5c+hwRmaBZ1obC8BUUGM2RpfdnFcKwSBUPi2vz5XQDcGy76aQJNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMXVRTSs1DLVZpM6m4yWKuNVljKiv3hC5Od+bfp0gcE=;
 b=ahDnCXivkGOmVNsqLy8I4DawOTlQ6T7wxy6RxzX763zvHivB9hKCARzLKD3RtPTqv5URsjwOZ+MUvhGlWXXna+kOEFIE2R+rNeqzBhaklgZNmd+85CzCB30hEyaGcPSa4/g5b/pNLaJI/vhk2LfqohSLcpx7j/gs7/UaqQu2WxL5rzKV2fGLphsz8EKVlUgh/s9D/ZVFj5oZCVE5Pafpg/Rf53sP0Uz8e7GLVYrCauM5Qd4ZU6lHb3WYzpCHCI/1DzVJdF4X8nrxQ3XEhVHQ+p7dMzHAYOuQ+MgZ2kJlK3h02u2YIODpjHAOmgPt+Cl+iOAP6XU+FeU1BBea7Bo2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMXVRTSs1DLVZpM6m4yWKuNVljKiv3hC5Od+bfp0gcE=;
 b=KzbJPd4rR975NsQJU8UZSOdJNC1M5rZtZV9FgosrxKGHS3PT5zLF7FDrfOj4wj8Fk2L/BU0gFQ5wbT6dRzmFqMLTJGgUCJ3Me2fCdhXpQ2jfA/j6ToPXt8O47oP6nyDXR1rcUBmKaue3IEN4K7o7wv0rpRi3ZsuBdOIrnN/p4Dc=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3649.namprd15.prod.outlook.com (2603:10b6:a03:1fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 18:37:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 18:37:41 +0000
Date:   Tue, 27 Oct 2020 11:37:36 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <iamjoonsoo.kim@lge.com>,
        <laoar.shao@gmail.com>, <chris@chrisdown.name>,
        <christian.brauner@ubuntu.com>, <peterz@infradead.org>,
        <mingo@kernel.org>, <keescook@chromium.org>, <tglx@linutronix.de>,
        <esyr@redhat.com>, <surenb@google.com>, <areber@redhat.com>,
        <elver@google.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 3/5] mm: memcg/slab: Rename *_lruvec_slab_state to
 *_lruvec_kmem_state
Message-ID: <20201027183736.GA827280@carbon.dhcp.thefacebook.com>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027080256.76497-4-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::4:e2f0]
X-ClientProxiedBy: MWHPR10CA0069.namprd10.prod.outlook.com
 (2603:10b6:300:2c::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:e2f0) by MWHPR10CA0069.namprd10.prod.outlook.com (2603:10b6:300:2c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 18:37:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e8b71e7-28a4-4d0d-a5e9-08d87aa7634b
X-MS-TrafficTypeDiagnostic: BY5PR15MB3649:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3649A63DFB02A1F41931E61EBE160@BY5PR15MB3649.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2YSXAd2ubxqgCvaX6+kESG8v+KgDG9VYxqvlZIYV5IS+Ghp3iD2PTvEEujq9FYnIa2prLK7AnF3NTgExw4talxuk/27Lf+s0J6nNiFNaCigrOBsNMwZOUMJNqLkg8saXoG6BZWkMG2unrHwkzBbADtwxlbR1dTF7ikqo5SYJ01UIG2k6uBDxDC9MjM+iQ6mbICoRioP/Xu+j7f1UOsAI2m79iIvNOrKgdRJ4uCqFXKwZEuhZBVCvj3R/trG76TZcCWCypNTIRfqwHdbIkmzw44rOUUvD2Xwqa9OlCN+RTcV4uo0Fn4SfLw3AcH6w3W8pDtpsplEqNFtvLPNsLaxDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(136003)(376002)(316002)(478600001)(5660300002)(7416002)(6916009)(7696005)(52116002)(55016002)(86362001)(8676002)(2906002)(16526019)(33656002)(83380400001)(6506007)(9686003)(1076003)(186003)(8936002)(4326008)(66556008)(66946007)(66476007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 9COSu1B/S+daUk35XVHihX9TDo2vv6ivAY00LHccSsuHtCukwyxncO4JzsZ3UTaOuVzpgMvXRp++MpJXqhZTDSVYItf8OHN7UsRtWfeK2FI18DcQx/S8aTP8ouXb7PzqOd8P82AgqYlG5uS+qPSc0RgSusL4b2nVoC15Xp4sS3jOTnr+0r99cAfqQVUPIMPf8ZG1+BiO0CcAIgAdRotgmPM1So5U0atO1JEJ8QkyyTtJl1MpweHw0Up8afCs8GEEUFLZME0chTp27kryJPqz6WME4c6auig9WfF32dABCzpqH+KmoTlcl4se/0lkuDIreF9K6PR82g1szHGumU3WwaE9iBrvCHlxvxcPL1TSPpLVwKMHzSzT5udH9bUyLlKLTxNTUErIozxnp3XdMvIm7iGA1p6rkEi9a7wlu9g8D9pe9/UHPNqorByaZKRAMR3ChUpwQxql7el8B6G1G+PS0rexZo9mHTBLRYPVFDxubhkwYkqg2zmGO8Bi0lSxyoyaFrQA7aPNsppAX5/gV6Q2C0S089holCIznN2FR8mPJaU1mFif/BohIh6JAE9L6V2o4ZZzPzN/LqYK7Z6zLNfEddF3pwAXKsCZ4Hv9o2OSjzbSzxQFXEU68FLRXNvtUqMW6jCcvf/G07Df8Ve7wFM5m86ckKICU+Wpsx7sMNNcZC0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8b71e7-28a4-4d0d-a5e9-08d87aa7634b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 18:37:41.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWflvGXeV0ZcCUaQX4BCPgnK2/0L7AbIpIu/d4BPt2yLza5izv3CeE1r8qJXZruj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3649
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_10:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 mlxscore=0 suspectscore=1 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010270109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 27, 2020 at 04:02:54PM +0800, Muchun Song wrote:
> The *_lruvec_slab_state is also suitable for pages allocated from buddy,
> not just for the slab objects. But the function name seems to tell us that
> only slab object is applicable. So we can rename the keyword of slab to
> kmem.

I agree, I think we've even discussed such a renaming in the past.
Please, drop the addition of VM_BUG_ON() (it's not related to the renaming, right?).

Other than that:
Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/memcontrol.h | 18 +++++++++---------
>  kernel/fork.c              |  2 +-
>  mm/memcontrol.c            |  3 ++-
>  mm/workingset.c            |  8 ++++----
>  4 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index d7e339bf72dc..95807bf6be64 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -793,15 +793,15 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  			      int val);
>  void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  			int val);
> -void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
> +void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
>  
> -static inline void mod_lruvec_slab_state(void *p, enum node_stat_item idx,
> +static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
>  					 int val)
>  {
>  	unsigned long flags;
>  
>  	local_irq_save(flags);
> -	__mod_lruvec_slab_state(p, idx, val);
> +	__mod_lruvec_kmem_state(p, idx, val);
>  	local_irq_restore(flags);
>  }
>  
> @@ -1227,7 +1227,7 @@ static inline void mod_lruvec_page_state(struct page *page,
>  	mod_node_page_state(page_pgdat(page), idx, val);
>  }
>  
> -static inline void __mod_lruvec_slab_state(void *p, enum node_stat_item idx,
> +static inline void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
>  					   int val)
>  {
>  	struct page *page = virt_to_head_page(p);
> @@ -1235,7 +1235,7 @@ static inline void __mod_lruvec_slab_state(void *p, enum node_stat_item idx,
>  	__mod_node_page_state(page_pgdat(page), idx, val);
>  }
>  
> -static inline void mod_lruvec_slab_state(void *p, enum node_stat_item idx,
> +static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
>  					 int val)
>  {
>  	struct page *page = virt_to_head_page(p);
> @@ -1330,14 +1330,14 @@ static inline void __dec_lruvec_page_state(struct page *page,
>  	__mod_lruvec_page_state(page, idx, -1);
>  }
>  
> -static inline void __inc_lruvec_slab_state(void *p, enum node_stat_item idx)
> +static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
>  {
> -	__mod_lruvec_slab_state(p, idx, 1);
> +	__mod_lruvec_kmem_state(p, idx, 1);
>  }
>  
> -static inline void __dec_lruvec_slab_state(void *p, enum node_stat_item idx)
> +static inline void __dec_lruvec_kmem_state(void *p, enum node_stat_item idx)
>  {
> -	__mod_lruvec_slab_state(p, idx, -1);
> +	__mod_lruvec_kmem_state(p, idx, -1);
>  }
>  
>  /* idx can be of type enum memcg_stat_item or node_stat_item */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 4b328aecabb2..4fb0bbc3b041 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -384,7 +384,7 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>  		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
>  				      account * (THREAD_SIZE / 1024));
>  	else
> -		mod_lruvec_slab_state(stack, NR_KERNEL_STACK_KB,
> +		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
>  				      account * (THREAD_SIZE / 1024));
>  }
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c0c27bee23ad..22b4fb941b54 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -866,7 +866,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  		__mod_memcg_lruvec_state(lruvec, idx, val);
>  }
>  
> -void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
> +void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
>  {
>  	pg_data_t *pgdat = page_pgdat(virt_to_page(p));
>  	struct mem_cgroup *memcg;
> @@ -2920,6 +2920,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  	if (mem_cgroup_disabled())
>  		return NULL;
>  
> +	VM_BUG_ON(!virt_addr_valid(p));
>  	page = virt_to_head_page(p);
>  
>  	/*
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 50d53f3699e4..2c707c92dd89 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -445,12 +445,12 @@ void workingset_update_node(struct xa_node *node)
>  	if (node->count && node->count == node->nr_values) {
>  		if (list_empty(&node->private_list)) {
>  			list_lru_add(&shadow_nodes, &node->private_list);
> -			__inc_lruvec_slab_state(node, WORKINGSET_NODES);
> +			__inc_lruvec_kmem_state(node, WORKINGSET_NODES);
>  		}
>  	} else {
>  		if (!list_empty(&node->private_list)) {
>  			list_lru_del(&shadow_nodes, &node->private_list);
> -			__dec_lruvec_slab_state(node, WORKINGSET_NODES);
> +			__dec_lruvec_kmem_state(node, WORKINGSET_NODES);
>  		}
>  	}
>  }
> @@ -541,7 +541,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
>  	}
>  
>  	list_lru_isolate(lru, item);
> -	__dec_lruvec_slab_state(node, WORKINGSET_NODES);
> +	__dec_lruvec_kmem_state(node, WORKINGSET_NODES);
>  
>  	spin_unlock(lru_lock);
>  
> @@ -564,7 +564,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
>  	 * shadow entries we were tracking ...
>  	 */
>  	xas_store(&xas, NULL);
> -	__inc_lruvec_slab_state(node, WORKINGSET_NODERECLAIM);
> +	__inc_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM);
>  
>  out_invalid:
>  	xa_unlock_irq(&mapping->i_pages);
> -- 
> 2.20.1
> 
