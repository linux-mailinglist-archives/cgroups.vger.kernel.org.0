Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F142930FF9B
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 22:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhBDVsZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 16:48:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15172 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhBDVr6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 16:47:58 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114LhqBE028805;
        Thu, 4 Feb 2021 13:47:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=b5CsRZlKfhUByhWO6HuSpu54tV6Zf2eXy/IuBs/Ya+k=;
 b=qfdqCP33O4/qTFRQMXSWdxNLjhIc7zfa7ke/Z/qKf8/XIH3Nne4R190lE3YUzoyvs1L2
 cU+odzMkBGcLeyFxHIaKhPO7drhyhyutnK82HSQ9Pow47U3HGyFUVpm+38RDVYyKAM3x
 fThAXpdaYHfqDqPLormCjockUHpsnEojSm4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36fcrbdgn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Feb 2021 13:47:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 13:47:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaTYJ5pSKrFp9n9DZp3F11/UKJNgKDcMj6MTIQ/ddx/WS/MKDQRWPHWijxX/5aTQayZ3gTn3JEk9DpC/c2eQSiYFzy2RFnI9pp4qPw4NOOOxCVOnz0FbH+4fP57bYs65MACcOc8qv3LBFt3HJcvpcu9LOU49VKnuJf7hZedLF9Iub/gUY1P70jWcpexFJbOuvSovSvvEXCTChDXtHZCFKVwAeu1nbgiEk+LBMvU8Hu1OJleIDWmOT77XzrydrVddhZ1eod+l0VUjdGN4zEYNGrTiW7bE3zstRqvzB2M3pkZ55QG4hvFdugQg1lnvpId+oKvG93HauP78eO5srahVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5CsRZlKfhUByhWO6HuSpu54tV6Zf2eXy/IuBs/Ya+k=;
 b=W7qLh89xPQIGCe/gr8dwHgUKzVNVpiKHjiQQvT0EUFxt0PWcNRXEpmyCd4R692v0VFR/5eM/IXvYsa8nz2G7XDCkQjnIVIMU6raqlTcyfBffItubKVynsw3fUTpO1HtTtZpKSO+rXd7P1yn8EN+e0emxuPOMkvKyxRBR9tkU7CKllUES6PaFoMERaanOmqggB9YXcca2LwEQrGEGrdWFS0XzmT0zmDcL5pq7eEUYXFDEtIyBdMXpuDF6GzSIbLErqGPx7h1Jo/eG57Ppzh6BONaa1siKDcvk1kAdacRPIYPtl72LDW5cC6I85VH4ORd98heObOnAndDE95kMzO/Lqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5CsRZlKfhUByhWO6HuSpu54tV6Zf2eXy/IuBs/Ya+k=;
 b=Q1wdMx/q9i5pb0fAinX4wdv9jO6sfJ9MCzDK/5B2J6JxhYW3SkRZ9UrvXevrr2GYGCE7FGEUvsBcuJ8t1+32Mr4gzCFZzKNMe01jAku4flfqTqZpnGu8bawacPKWcpH/Ed+F1gL4Mf2DZE5NRGWQ6h6Nd5qhWT1eKmEhw/GD1vc=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2486.namprd15.prod.outlook.com (2603:10b6:a02:84::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.26; Thu, 4 Feb
 2021 21:47:07 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3805.028; Thu, 4 Feb 2021
 21:47:07 +0000
Date:   Thu, 4 Feb 2021 13:47:02 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 7/7] mm: memcontrol: consolidate lruvec stat flushing
Message-ID: <20210204214702.GA2053809@carbon.dhcp.thefacebook.com>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-8-hannes@cmpxchg.org>
 <20210203022530.GF1812008@carbon.dhcp.thefacebook.com>
 <YBxquyq6XzWlV3Wv@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBxquyq6XzWlV3Wv@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:b62b]
X-ClientProxiedBy: MWHPR12CA0058.namprd12.prod.outlook.com
 (2603:10b6:300:103::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b62b) by MWHPR12CA0058.namprd12.prod.outlook.com (2603:10b6:300:103::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 21:47:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c0155e4-d5b1-4000-139d-08d8c9566b26
X-MS-TrafficTypeDiagnostic: BYAPR15MB2486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB248694EA84460293E1244C5CBEB39@BYAPR15MB2486.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vVLEqZ9mlge0J+5HAecU1PrDyDoR8C1GJ3e4CsSBN3ypoGmtAnhu6213ErO+wbccuUon6+8YqDdanHEavex26vaTuTaMYtWmqfgPBZtXdR0EMZnq3ttkaXkpLzi6H46AxTBTSb48H+Oz3DMcGb4GmgvwkUziG/zsD9eZJqgjZ7YIZT9SxpA4yZP8vVQFrb8cR9K7nRIUYWXkoClq1j+1Oo4Lh+k8ODFL2jmXu+GqhavwNFUozl9qu1kq+MXlTMAFp4EiAtaR66jrW9kH+Js6EQ/RcGaOUMr5RN3NKBqB5vYdqPeFR12/puwhndIMQIdzvA9TfGocPJBVOy58OEkmnZfXd77Rh51f7/ope27uoMKb1AxstrEiY/0fh61sNgdWHtiLDuwffyE2pLPWmI0awFnvtdIhHNvxSlCe65MO9iIM08tDKCMXu2M4T/XwxoqmKh+KvNToV8jkB4nVeEoBrG7gPAbvcJtW1RLfSMjJTX9J59b+tMTrmjdUw6DWWhCih7/GKjokzHNN2+6BmrSbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39860400002)(366004)(396003)(478600001)(54906003)(4326008)(1076003)(66946007)(6916009)(16526019)(6666004)(186003)(55016002)(8676002)(52116002)(6506007)(86362001)(7696005)(83380400001)(66476007)(66556008)(5660300002)(316002)(33656002)(9686003)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Q0RfjLp6MjOCiY8LAv8E0wBA9tk9SMzgn/7hgqnuhwx0M6Dm9KJXEerODerX?=
 =?us-ascii?Q?Fb7bSvEP4hZ8dvrmR91gyD4Olz201Ow3LMZHcGO+ziCeOOGDG8GB60TunWfv?=
 =?us-ascii?Q?1UJCZbVYisA2ME6CNr5eua8Z8fHoaSKCvILHzmrgvZjLNNRHFEWZYLTQJ6+P?=
 =?us-ascii?Q?MdkBqhJXhqhgWOfxSWHLGtMdl59bVvoiM0F/mhFMNWCcNr1XV7zvmr6IPiJT?=
 =?us-ascii?Q?Dv0MQfhccEFriP9WOdn8eZNCl0gmVSc6TVWjvDFNZPSRLsUjGuAUbAoe2zXN?=
 =?us-ascii?Q?28C+/Wbj/mz1MII+hfLf0q4vm/VxcmfsgkN1HrEy34hjlkvtj11BoVOfxH2B?=
 =?us-ascii?Q?atJRp5i8/sWcLIup11QJCu4Z5JXLABwLIuq8infJ3u/SZs3GNCqOiM4UIJ/t?=
 =?us-ascii?Q?XfJp19/pfp/M+FJR9RjCnNskTlAsQqCWye3aYGZjZH0n3Ivtzjpsc+dvZJQY?=
 =?us-ascii?Q?PInuWr4W3CRCUDa9ouo8rFjHJlimXA8gkIGDHUaMjxyY0k5Y/g2GdHvXIZRz?=
 =?us-ascii?Q?igD9PVQ4ZMtgesVEGVYcorDQpoDXQGO5tB6c+9fMptjcZqup4jFlrsBIh09h?=
 =?us-ascii?Q?WNs+DySYS5QZl0poO7MsovLRKH0hMrmMrPe3cwBcFRUqTn9R5Hnpn2OgmB+C?=
 =?us-ascii?Q?DTVXsD/UU+J0T97KDx7B4AED36z+Y5Ha3VkWQD5tUGtFj7uuwrvNf/TkiiMo?=
 =?us-ascii?Q?L7cPCFFTYw4pn9YeUEkB2JYgVjVr5PPK4DkzXyhfeHI+aQPK0cPZI4yP8ZrH?=
 =?us-ascii?Q?FBP+o4k8XWc03h1DmlLyc7c6SaiRRD1t9cNXux4sXKURkWCLaTnnxDm33IKN?=
 =?us-ascii?Q?yd3W5Xoj7kIy04AX+LsII2/AxaZvc73wvwFV5uLBNTSWIUuZ8oY3iJykmowP?=
 =?us-ascii?Q?IPcDdtb1JJUNq0xTBGuCPzNl4ZmA0sQ3YrxfkC/3LydoeYiO1nkUjXsI1Dgj?=
 =?us-ascii?Q?NU66GxbqsokRJ9aL96ZVd4nVcYtm9PkgPcPkjZEXgkx2F/EOOllYJFe4Pv1S?=
 =?us-ascii?Q?6AfbQzaj2dCc5JPQ4sniiVRvyFGZAbOHwzOenzcFb5vsk2kdb+xOZyN11G6J?=
 =?us-ascii?Q?XyLAQOFjg+4VcLVoyX8+wMhOmY4WeslNaxfpjFztWVrm/XZXcjY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0155e4-d5b1-4000-139d-08d8c9566b26
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 21:47:07.7031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLMNz3KurxeGzNiowZ0zubvjWts4IYYV8LEeEnW4fU/nP4UxF3iN6hHdkr+px9yF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2486
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_12:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 04, 2021 at 04:44:27PM -0500, Johannes Weiner wrote:
> On Tue, Feb 02, 2021 at 06:25:30PM -0800, Roman Gushchin wrote:
> > On Tue, Feb 02, 2021 at 01:47:46PM -0500, Johannes Weiner wrote:
> > > There are two functions to flush the per-cpu data of an lruvec into
> > > the rest of the cgroup tree: when the cgroup is being freed, and when
> > > a CPU disappears during hotplug. The difference is whether all CPUs or
> > > just one is being collected, but the rest of the flushing code is the
> > > same. Merge them into one function and share the common code.
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > ---
> > >  mm/memcontrol.c | 88 +++++++++++++++++++++++--------------------------
> > >  1 file changed, 42 insertions(+), 46 deletions(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index b205b2413186..88e8afc49a46 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2410,39 +2410,56 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
> > >  	mutex_unlock(&percpu_charge_mutex);
> > >  }
> > >  
> > > -static int memcg_hotplug_cpu_dead(unsigned int cpu)
> > > +static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg, int cpu)
> > >  {
> > > -	struct memcg_stock_pcp *stock;
> > > -	struct mem_cgroup *memcg;
> > > -
> > > -	stock = &per_cpu(memcg_stock, cpu);
> > > -	drain_stock(stock);
> > > +	int nid;
> > >  
> > > -	for_each_mem_cgroup(memcg) {
> > > +	for_each_node(nid) {
> > > +		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
> > > +		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = { 0, };
> >   			      				      ^^^^
> > 							   Same here.
> > 
> > > +		struct batched_lruvec_stat *lstatc;
> > >  		int i;
> > >  
> > > -		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> > > -			int nid;
> > > -
> > > -			for_each_node(nid) {
> > > -				struct batched_lruvec_stat *lstatc;
> > > -				struct mem_cgroup_per_node *pn;
> > > -				long x;
> > > -
> > > -				pn = memcg->nodeinfo[nid];
> > > +		if (cpu == -1) {
> > > +			int cpui;
> > > +			/*
> > > +			 * The memcg is about to be freed, collect all
> > > +			 * CPUs, no need to zero anything out.
> > > +			 */
> > > +			for_each_online_cpu(cpui) {
> > > +				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpui);
> > > +				for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> > > +					stat[i] += lstatc->count[i];
> > > +			}
> > > +		} else {
> > > +			/*
> > > +			 * The CPU has gone away, collect and zero out
> > > +			 * its stats, it may come back later.
> > > +			 */
> > > +			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> > >  				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
> > > -
> > > -				x = lstatc->count[i];
> > > +				stat[i] = lstatc->count[i];
> > >  				lstatc->count[i] = 0;
> > > -
> > > -				if (x) {
> > > -					do {
> > > -						atomic_long_add(x, &pn->lruvec_stat[i]);
> > > -					} while ((pn = parent_nodeinfo(pn, nid)));
> > > -				}
> > >  			}
> > >  		}
> > > +
> > > +		do {
> > > +			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> > > +				atomic_long_add(stat[i], &pn->lruvec_stat[i]);
> > > +		} while ((pn = parent_nodeinfo(pn, nid)));
> > >  	}
> > > +}
> > > +
> > > +static int memcg_hotplug_cpu_dead(unsigned int cpu)
> > > +{
> > > +	struct memcg_stock_pcp *stock;
> > > +	struct mem_cgroup *memcg;
> > > +
> > > +	stock = &per_cpu(memcg_stock, cpu);
> > > +	drain_stock(stock);
> > > +
> > > +	for_each_mem_cgroup(memcg)
> > > +		memcg_flush_lruvec_page_state(memcg, cpu);
> > >  
> > >  	return 0;
> > >  }
> > > @@ -3636,27 +3653,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
> > >  	}
> > >  }
> > >  
> > > -static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg)
> > > -{
> > > -	int node;
> > > -
> > > -	for_each_node(node) {
> > > -		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
> > > -		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = {0, };
> > > -		struct mem_cgroup_per_node *pi;
> > > -		int cpu, i;
> > > -
> > > -		for_each_online_cpu(cpu)
> > > -			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> > > -				stat[i] += per_cpu(
> > > -					pn->lruvec_stat_cpu->count[i], cpu);
> > > -
> > > -		for (pi = pn; pi; pi = parent_nodeinfo(pi, node))
> > > -			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> > > -				atomic_long_add(stat[i], &pi->lruvec_stat[i]);
> > > -	}
> > > -}
> > > -
> > >  #ifdef CONFIG_MEMCG_KMEM
> > >  static int memcg_online_kmem(struct mem_cgroup *memcg)
> > >  {
> > > @@ -5197,7 +5193,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
> > >  	 * Flush percpu lruvec stats to guarantee the value
> > >  	 * correctness on parent's and all ancestor levels.
> > >  	 */
> > > -	memcg_flush_lruvec_page_state(memcg);
> > > +	memcg_flush_lruvec_page_state(memcg, -1);
> > 
> > I wonder if adding "cpu" or "percpu" into the function name will make clearer what -1 means?
> > E.g. memcg_flush_(per)cpu_lruvec_stats(memcg, -1).
> 
> Yes, it's a bit ominous. I changed it to
> 
> 	memcg_flush_lruvec_page_state_cpu(memcg, -1);

Works for me!
But honestly I don't understand what does "page_state" mean in this context.

Thanks!
