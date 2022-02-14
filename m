Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FCB4B5BA6
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 22:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiBNUy2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 15:54:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiBNUy1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 15:54:27 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76225133949
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 12:54:04 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21EIZA6M029324;
        Mon, 14 Feb 2022 11:53:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=gSrE5ptjElCy1olfypgphHxI8neUSADFfac50rgksms=;
 b=jrIjO9LNVDV0HEQ0paTORp9SnNFvFhnBOppSv9dDYShvuDlS5nR+GNR03kA50FqjxadC
 IKfFdBEZQyOVvNzAt88DqnNOOEqz5haDMe1lGl1Tnn0BDMLB915Y8ocotkPubFc9P/id
 Yht/OR5SL90M1IkXIVVwh//9JTV3skaC9ns= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e7hv54nmx-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Feb 2022 11:53:45 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 11:53:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBJZILrN7v1Zy9yYMt6SQ1+6GgfBIYMZhLM4us9anUEpj8vaweA9i/ZfloXPVDy55sdo906yuYpEs6TEwHNAvmh6qPZgfKo+qNNTA6JVqAlRHIsqL1EtQlaBWh/UuPxQIPzvzYMkHBNTbHK9fykU1mEsmmiDti4UFjxi0ypzNCnAM82claEbHOXbVqYDkj2Y8UHq6QusQ8wDYft5D+t0KthudEjtVPLtdbt4skxj00m3NTmFt48BxFIyh4+Iha+C1z7kbhiCrQvY9M3tVbBA7DIgu66RJa4mPZj4dTwhzbXK72rIgB9HwfFd25+qLeohFxAGGIj4A9V4JR7G+T2g4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSrE5ptjElCy1olfypgphHxI8neUSADFfac50rgksms=;
 b=DN7aqeEkcSkrQeMwN/fGX/taekS8+5n2jWKlLfK54gDuMmS1d2cVSDgyy99PwVD7hZ0Dykr+bIRlvpIhfaEboeVc3w+YqfebeW6hptL5hbd+PqYr4pl9/EYCl+6IyHlh9SvG3PY8ksHrA5FpOqV1DVNCL6Q/hjUd6obnXko3Wr9KrleBvOr5LmI1U5SNSvVM8kU847B+vebAsOWXvhzcwvEUt2qkv2wtRHH6Y4MWCDrQWI5RnGo5/XcV9n7wJfCniz8kaH0no7ZJNTlD47hLCZeBhltn0MXCnGJirDqGZwmUr0v+9e3RGlnpF5h/LiVO/LadRT6faJlNcoyoYtc5+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by MW3PR15MB3947.namprd15.prod.outlook.com (2603:10b6:303:49::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 19:53:43 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 19:53:42 +0000
Date:   Mon, 14 Feb 2022 11:53:38 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 3/4] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
Message-ID: <YgqzQqGIGJYsdGwC@carbon.dhcp.thefacebook.com>
References: <20220211223537.2175879-1-bigeasy@linutronix.de>
 <20220211223537.2175879-4-bigeasy@linutronix.de>
 <YgqHSIa/WvJSXERe@cmpxchg.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YgqHSIa/WvJSXERe@cmpxchg.org>
X-ClientProxiedBy: MW4PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:303:16d::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 389fc762-820e-4de4-ef21-08d9eff3b3f4
X-MS-TrafficTypeDiagnostic: MW3PR15MB3947:EE_
X-Microsoft-Antispam-PRVS: <MW3PR15MB3947A3C7559063D81697FA83BE339@MW3PR15MB3947.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpsKe3vLXKYpUvEvOMo+NrRbOEsQ5vLINVVQqTgOPI8gN3WLwLkJeBib5ZyUMIq29hYW36l9nmxVXE8dhVW5vjRhIO8W7/iU0fUeS9WbCGByIwWmT8Gq1MTF6+cgWMaBbMPEmB31aXhDa7b6VtWx2+x5m6xNzCxdHBzR1sMIExKE8UwK76sFr03XR9IfI1VNB5MV9Xi8aFK3A6BVPS8eiXRO4EhSXlcNZHX81m2Ad9tT+qSoWKsAFdjo9QU5+MefR4AR6SOgF8mEHqxVaUta/IXVIQvJX8MrPb+taoh7unqXYwcT8xTesKUIVReIidQA714coCDwD8G9PpbbptyDBRLmvwo2l0nrSrd5KH1KJhIzAjTtdebH2VqlVscHZ6X5sJkKmG94g/X4I24CqBrxWJV7j7LX4mnA4QJTw7lnDTJRiu94RglqfeuD+gEJ9JC0t1lK6T53MtaK9ugCU3kBHqNQauC5RA7/k9w39MQb2vatjYpAqtoxF5Nak1FPe4BUvK/RlP8Dcf+z9QVKyXDXsk6LpkvYc/EUcP69y38L9tbfpEbV3PyPkNXdmtCWQ+ejl7uO9RmQB5wZ6M6jvsQDdsNrmrDHx35J5iufMCW7vhcU+Fzt6e2nq6bqIr8qM03VeZ0zTO6XaceMLWbrPA652Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(52116002)(6666004)(8936002)(316002)(66946007)(9686003)(7416002)(66556008)(6486002)(8676002)(66476007)(4326008)(508600001)(6506007)(186003)(86362001)(83380400001)(54906003)(6916009)(2906002)(5660300002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5qfPEnRYa8dx5UK/dMOlo6XlYMxwFjV0bnG5f1xg4vsDjYyeAHcjnu89gSpO?=
 =?us-ascii?Q?ExU+tulnAu5H1wEuF48Q2QC4dahEUyZV50VltiFojtK8fJeMdDf3+0aKPzZL?=
 =?us-ascii?Q?0yfA9viPPOjf4F/LGLkOf06IOevzvMLM+mfP7YBw9IEuRPQS/oprJXC8ceNl?=
 =?us-ascii?Q?xmljUSYIQRpV080xkQ4LXwjG+ENoThkKw58iFM+N9ymi7cxVO9gqSM9fE+T8?=
 =?us-ascii?Q?9eGwjJypjTSkt5ahsI/Q1PDCGJvONoK4F0SS5otVOQYcEHlvDIRCjx2QwQZM?=
 =?us-ascii?Q?FpEcYm9UxY61ev8/OKxW/JigPbWs8KklMIgXCrM4ea0TvnU4JRyE9U/unNtZ?=
 =?us-ascii?Q?MvgAA4byMdt51r6QzMNTcoYFhcncs4WH0PZvZXqzqyj8kU5hlDZgkhV9lm65?=
 =?us-ascii?Q?4G5B3fwZrKs1TJxtdykc8BT980LW1EBuqBusToC2r6w9DsAu8/IsTIGaeoXR?=
 =?us-ascii?Q?iM3fPyqeJoAsUhOOHubK073CcioQCCUgLBKxcXNBXg+dNjMwZYKqhvbSvg9n?=
 =?us-ascii?Q?J2P5G/AH0Duwdz17q5FDr0PRo1GoLX7sYNXqXhUOFmbCo+6ireL4d9QOvP/7?=
 =?us-ascii?Q?K2XxlPVCbR2WfU5Wk/klgmeKFUEXG/rEXXNJMrQo9UtEwd1OJVrnbs6/IgOd?=
 =?us-ascii?Q?P17Ui2BRQ19UAVCte7pWuxvYrFsDbmY7elnNAGtKcdvlZb3EoP1YZjm/VBvh?=
 =?us-ascii?Q?JsyjdrrTruLjudwrMNLAIRbo+fRWFFa+IeYg6nfn8ckYBXuVXbI4P4SucPwL?=
 =?us-ascii?Q?1lYN5phvSJ37aJdn3mN022A3GagwdoxAaTyDwP15mT4zwrFA9rNMZlOVWuuI?=
 =?us-ascii?Q?CAUqqNPG8NrpaJNzM46FENcoizIYr+LQ2Z+CWxygNS2pGY1JSXdFpmzGCq4+?=
 =?us-ascii?Q?g/fkvuoxq2BGmHdprYHMFDVci6BFZKORnn9aldlzryRNRLeeQOD5/qZ0PwHu?=
 =?us-ascii?Q?IyZ9rLApaUMD1LhnnG2TiLxBkQC0Ty/V0sGUTozJCN0dnxK+etdncOUoyL8m?=
 =?us-ascii?Q?kq4weemVUIZEniED3sTIcGkUkWKWy29kNWLjuuqoPZ9Jv4+lRLw+y8n/2CX2?=
 =?us-ascii?Q?5eBqn+4nBxDpcCf5Igt62iP4GoJBcZvOW5v+ov19zX1arXu0KmxNjGLW3/ZC?=
 =?us-ascii?Q?MG1VRJdH1GwjYyzSi7oSHC50aKiuZXtiR2PROqGyhCLCJgx3XJNBHJjem60c?=
 =?us-ascii?Q?t+Y+6c/vQusP+nZciGXHMWxeqf+jEybL37Z+ZdfiUN61Ya3ZZsIe7WaUFsA6?=
 =?us-ascii?Q?FyRPKj/t2KD6mhzu2jhGS3wOCyomoyryjx97J2ZOETbqXf/VppWKXUkpJvak?=
 =?us-ascii?Q?b9pLGjp7sby+btWlvfjJcqKGu77ZYiwH9g2Ghv2aQbXqjl4KfRYbMby4av6s?=
 =?us-ascii?Q?87pJ+2wuVi1TwcatBxTwy1r8RvZd5eIsqBkOsgg82wl5UBHdGcdyflDfS8O7?=
 =?us-ascii?Q?S+oWm+eXMnMTKQJE2bN/Q5VfO/5N50VqXgI1ulOMhQx716ar+so7oUwkbVV4?=
 =?us-ascii?Q?JQ557mInvOPKfXa3ukhy7HpWwh3BpIEg1l0pxPxeIeo7c++xC9n1J/ex3QlU?=
 =?us-ascii?Q?GrjFoNJWIr2Jyl2t99ovKNj3QlD7EszIfhT1S3tf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 389fc762-820e-4de4-ef21-08d9eff3b3f4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 19:53:42.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcEGaajfedk5/GjirPJ2I5g56rvxzMbmpfgA7Bqba8Ls9SLcnJRIPwFQNfFPsFOD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3947
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: qecbmhKI6Er7j5J3fazG30q7zQ8_s3YL
X-Proofpoint-GUID: qecbmhKI6Er7j5J3fazG30q7zQ8_s3YL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_07,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202140115
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 14, 2022 at 11:46:00AM -0500, Johannes Weiner wrote:
> On Fri, Feb 11, 2022 at 11:35:36PM +0100, Sebastian Andrzej Siewior wrote:
> > The per-CPU counter are modified with the non-atomic modifier. The
> > consistency is ensured by disabling interrupts for the update.
> > On non PREEMPT_RT configuration this works because acquiring a
> > spinlock_t typed lock with the _irq() suffix disables interrupts. On
> > PREEMPT_RT configurations the RMW operation can be interrupted.
> > 
> > Another problem is that mem_cgroup_swapout() expects to be invoked with
> > disabled interrupts because the caller has to acquire a spinlock_t which
> > is acquired with disabled interrupts. Since spinlock_t never disables
> > interrupts on PREEMPT_RT the interrupts are never disabled at this
> > point.
> > 
> > The code is never called from in_irq() context on PREEMPT_RT therefore
> > disabling preemption during the update is sufficient on PREEMPT_RT.
> > The sections which explicitly disable interrupts can remain on
> > PREEMPT_RT because the sections remain short and they don't involve
> > sleeping locks (memcg_check_events() is doing nothing on PREEMPT_RT).
> > 
> > Disable preemption during update of the per-CPU variables which do not
> > explicitly disable interrupts.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  mm/memcontrol.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c1caa662946dc..466466f285cea 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -705,6 +705,8 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> >  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> >  	memcg = pn->memcg;
> >  
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +		preempt_disable();
> >  	/* Update memcg */
> >  	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
> >  
> > @@ -712,6 +714,8 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> >  	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
> >  
> >  	memcg_rstat_updated(memcg, val);
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +		preempt_enable();
> >  }
> 
> I notice you didn't annoate __mod_memcg_state(). I suppose that is
> because it's called with explicit local_irq_disable(), and that
> disables preemption on rt? And you only need another preempt_disable()
> for stacks that rely on coming from spin_lock_irq(save)?
> 
> That makes sense, but it's difficult to maintain. It'll easily break
> if somebody adds more memory accounting sites that may also rely on an
> irq-disabled spinlock somewhere.
> 
> So better to make this an unconditional locking protocol:
> 
> static void memcg_stats_lock(void)
> {
> #ifdef CONFIG_PREEMPT_RT
> 	preempt_disable();
> #else
> 	VM_BUG_ON(!irqs_disabled());
> #endif
> }
> 
> static void memcg_stats_unlock(void)
> {
> #ifdef CONFIG_PREEMPT_RT
> 	preempt_enable();
> #endif
> }
> 
> and always use these around the counter updates.

Thanks, Johannes, this looks really good to me. The code is already quite
complicated, the suggested locking protocol makes it easier to read and
support.

Otherwise the patch looks good to me. Sebastian, please, feel to add
Acked-by: Roman Gushchin <guro@fb.com> after incorporating Johannes's
suggestion.

Thanks!
