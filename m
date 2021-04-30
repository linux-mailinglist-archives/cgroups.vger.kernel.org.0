Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2C936F46A
	for <lists+cgroups@lfdr.de>; Fri, 30 Apr 2021 05:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhD3DVn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Apr 2021 23:21:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56220 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230074AbhD3DVm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Apr 2021 23:21:42 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13U37Evr027231;
        Thu, 29 Apr 2021 20:20:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kM0Qsq0Ge1QNBRcCm9o93boNdtjb9MhHZimLYSv5ELk=;
 b=IG4Y9d5UKvb77GRwR/vF9TXcJ9bmrjGTBtcZ2Bl6BSEvPqQwEvNZJXm8Ob1sO5ToAiXD
 G8ek2aTKW1IdlQYvRYHMkJVO+/RH+k/9/fSseTW/zmaNvOSNx/Mbu9toaBcKB0sRg//q
 Nb6zG9BCwzg4JEq/eKkudJ91VZ7E/24l7vI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3879ae31pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 20:20:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 20:20:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFmvUKZ52z1X0zaGZiAqdR8+Vsde4uahIIuMwcE3veoSYrmr5LUKjsYI8azTZEtlC7Dx2n1f30Osr1vuE92SN5GGgffdMbVqaQBjsVEgny6OAeJerVhlwJ9JY0+1oD6XGSJtheVlAC0BYy2Y2gZBq4wCF5ath6rHBvuc7kucuL2HpcGGpehxq2eFNY0jpQjqzYv0QLy6CDK6nvUY4HBVNy8so6OY6TQ4mTTJSkGkZLHItwMcxCI+FHeKnGedzxoSm+4JiemXg7IrzpebllOJZ5aoIFUdcbBH3F1MHu6sCS2abC60jXYystMUYs4PNpF2rvY46ImqRQyQyjO8GMm7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM0Qsq0Ge1QNBRcCm9o93boNdtjb9MhHZimLYSv5ELk=;
 b=T51j6pw6FimwjihiiUY/rS04ko1+sX3Bv/C/Ii2M8Z/0i/rztBtNpey4UmwClLlRqGtnYGNYgUrf1XLKso2wu1kQA7HdDj9pa0bxFg2kIQEy3IGcRXkPX8BFW3uSFQ7tG2r+ORX73cg2RSRkQjtFQsrFvUY9OJ4d60EM420iZUV4dwYfg7ryNjqykqpEDSu3Tk4z4zWjI1g2Zyz2G1/osMKsQZ124Io29iwnFSoCSzTbmj3XtgnMGAuwCTM4Sl6d+iUeiJi25PuQZUiKBrpyKjALoRYb2XAK9ue2MIVIPKrmAdMe5oY84q4J/rrKVfu6vz+LIudf2z4JLGiaxA3sFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3141.namprd15.prod.outlook.com (2603:10b6:a03:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Fri, 30 Apr
 2021 03:20:15 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 03:20:15 +0000
Date:   Thu, 29 Apr 2021 20:20:11 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/5] cgroup: introduce cgroup.kill
Message-ID: <YIt3a5R5tYgIpoVQ@carbon.dhcp.thefacebook.com>
References: <20210429120113.2238065-1-brauner@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210429120113.2238065-1-brauner@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:a5ce]
X-ClientProxiedBy: MWHPR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:300:6c::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a5ce) by MWHPR04CA0052.namprd04.prod.outlook.com (2603:10b6:300:6c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 03:20:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e977c27-98d7-4ba0-fd19-08d90b86df6f
X-MS-TrafficTypeDiagnostic: BYAPR15MB3141:
X-Microsoft-Antispam-PRVS: <BYAPR15MB31412003EE71EA35D57E3428BE5E9@BYAPR15MB3141.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdPvp5L5vUosT6yXCI6sDhiDLazwzzahBTch4Ayhy8mJQ9y3TEj6ZHS2poe9q0U7CPSuLLnoqaw415beI7YMpZ4RB9WS32UWzCFqzTKsXEzulkLRYdWLpRUsJWlSiqmN5PsIoOkQC1X6fQFhJ7ZKe7Hog9ilTbaTmlb9ymAFkHDhQUvjL6AIiujzdAiCugUOy6bwczTLCJG3uV+yOBtx5fXnMgfNiUf4ruN5DhUH+VgI9wFaS3qkwSF9/wocByx36iMs/PczUC/jlNmctPnZYR/utDrvkcIHZW7kt0ut9kAiQu4vwxPJqEM3rN9JGR0X4JNwAYCaf1K0t97RQ+Fw725EGQrU8WltxKgk40bh5N4oR/FXh3+KPl1UeEvu1sLh14hDyIs1KTQDv2Tw34mRLuc9+Sp66qvu5xZU0+yklGHRyHkbtl/4xja261WO9z5rcvHTn+ow46SIbG5P/T0BZIA5Rbzznhnb82X3kNSkdvdGKhzsl5zVCVY7mHqay/f5zrsS21Gpnt0hn01tKg2KOPuQa2TYEX+Tae5B3gBfbuO5THKnDx/9Ds+9Psuqv0j2/pYr+pT0WEN346nlntq+YgkZProXmnU0RwV1PXR9mBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(5660300002)(2906002)(8936002)(316002)(66946007)(55016002)(66476007)(38100700002)(6916009)(6506007)(52116002)(7696005)(86362001)(6666004)(8676002)(54906003)(4326008)(83380400001)(478600001)(66556008)(16526019)(9686003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rgOOzOK7Cq6KCGmyp4hxlPh3JgeJsCS/762vJGkRHjkQq6Sglp42mjB6zlBv?=
 =?us-ascii?Q?qHAdmpCOvSSHujn5Fz9KKRfbDXGDqrSZbwcWCejLs1YKzHtktQteXkUVLlXW?=
 =?us-ascii?Q?TldkaLZOMWtVOLWA9QBaJapeKhW8Bef+TqTLfsY4BgQ/VDPtMAjlxgda3QZZ?=
 =?us-ascii?Q?TxT/GV4kYURh7ym+C+EjPvMB1fWfxZiofJXgQ6GwZ3SwZOSW2sOkRD8s19cr?=
 =?us-ascii?Q?XLF9Mx+fkYfgp4E5NrvgRDabUGlk1fZpz5iUhtUKU0egRjyOqRv8AY0OVgpd?=
 =?us-ascii?Q?S8f5xuossa1woWWXAQL0I7s7wyfkFd9qoDPeJYpjoJy0tguNCW7nQCqLslHR?=
 =?us-ascii?Q?WqdhEgbDUDRUkus/bKVVNStXhnS6xUbfGXRgsrZglyVReoBLfgiSG5TzdwzU?=
 =?us-ascii?Q?LSvcBNMOzlc9AMLyzPA0+RQc2zcwz6Z/fRorCjSOSjOaCIQezpLl6rej7Rc6?=
 =?us-ascii?Q?BHlqXWkzX2jXiDyLOuNTfoFRKRIIaCZblfbKQHDlcQ/pfFeMcXCbEDcdpXuy?=
 =?us-ascii?Q?OCsRoEu1L9EaltZSySkjwB9rbhI3LrJgUFiXDS1hsZAQEJWsicv++ujSeKIA?=
 =?us-ascii?Q?909pHO6AlebQR591iqpC7JEP1uWW6lsvglH4vmU6Y9+BbosBz9GIjDMC4z82?=
 =?us-ascii?Q?xupjZfGOvWyB8ygdiEd45jULZ4lds9neLzkC89xOfAHSZRrf9H+u930VlH0H?=
 =?us-ascii?Q?ed4Q+NXBj/Ea61VQzzbEdStct+W5caAEWp6c5x9eeWfup33ffCkQWGWSHMYr?=
 =?us-ascii?Q?73M7VmjCssDB6hMuu3DGeMgQuvMs7OqlstfY9nNWl1P0yp5+DQ+kgOXcObwH?=
 =?us-ascii?Q?oH1QdN5EIoDsYtTuVDXd6iNLKyUHxeEZsR9hSk13E/ITILFYRiIxp1SVAgAx?=
 =?us-ascii?Q?RhdBcqKVKvhnZR+M6iNtbOLTvzY/Z9ha4j7RKVg9/YDpILXNT4Qb9QcT4OaR?=
 =?us-ascii?Q?786FSOkea5xN8TvFoljjmjtJeGVMpDMmEtBc/GRgXXGq4KjA1zQjeBEO6Uf1?=
 =?us-ascii?Q?SqmGWp++a3GxM0fDPSduSKAZ0arsWkth3YD8PcevARfhoA9vLjKToiBO7lVx?=
 =?us-ascii?Q?ekrXeL55tbsuRrMhAeMcFogzdBiMOz7KGtc/GSzuv0s+08GfkiOYFw0vzwFm?=
 =?us-ascii?Q?CRG4Oz6+9OeBUQI5Gqv0et+vX2cO9jrfUwMkmGNXnXtHZUOuUkp5Q943JRUK?=
 =?us-ascii?Q?T42mTa+ydoTQ292irrSjlLzHIQoD9T8WDSKpXa5ojmHNMxDHf8loUTHEb9uL?=
 =?us-ascii?Q?aw41+3m2ARY4Qq+M+/n09IKSmmS24rpEZI85B1d8+MJXeR3nbR0cfUwpqoJl?=
 =?us-ascii?Q?UmJa6Naj3qIuj3ec6cKfEl9NqpdunGP073Jc4qaHT+BA8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e977c27-98d7-4ba0-fd19-08d90b86df6f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 03:20:15.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +19rCi4Owc2OdbAFnTx76SsvPFGr3MCLxuG6T9aujNEdV8KICGhii1b5tN9KvuBD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3141
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: zshBST8CAQjjVsnvaeiS2AgJ7Q7CVrD2
X-Proofpoint-GUID: zshBST8CAQjjVsnvaeiS2AgJ7Q7CVrD2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_02:2021-04-28,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=960 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104300020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 29, 2021 at 02:01:09PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Introduce the cgroup.kill file. It does what it says on the tin and
> allows a caller to kill a cgroup by writing "1" into cgroup.kill.
> The file is available in non-root cgroups.
> 
> Killing cgroups is a process directed operation, i.e. the whole
> thread-group is affected. Consequently trying to write to cgroup.kill in
> threaded cgroups will be rejected and EOPNOTSUPP returned. This behavior
> aligns with cgroup.procs where reads in threaded-cgroups are rejected
> with EOPNOTSUPP.
> 
> The cgroup.kill file is write-only since killing a cgroup is an event
> not which makes it different from e.g. freezer where a cgroup
> transitions between the two states.
> 
> As with all new cgroup features cgroup.kill is recursive by default.
> 
> Killing a cgroup is protected against concurrent migrations through the
> cgroup mutex. To protect against forkbombs and to mitigate the effect of
> racing forks a new CGRP_KILL css set lock protected flag is introduced
> that is set prior to killing a cgroup and unset after the cgroup has
> been killed. We can then check in cgroup_post_fork() where we hold the
> css set lock already whether the cgroup is currently being killed. If so
> we send the child a SIGKILL signal immediately taking it down as soon as
> it returns to userspace. To make the killing of the child semantically
> clean it is killed after all cgroup attachment operations have been
> finalized.
> 
> There are various use-cases of this interface:
> - Containers usually have a conservative layout where each container
>   usually has a delegated cgroup. For such layouts there is a 1:1
>   mapping between container and cgroup. If the container in addition
>   uses a separate pid namespace then killing a container usually becomes
>   a simple kill -9 <container-init-pid> from an ancestor pid namespace.
>   However, there are quite a few scenarios where that isn't true. For
>   example, there are containers that share the cgroup with other
>   processes on purpose that are supposed to be bound to the lifetime of
>   the container but are not in the same pidns of the container.
>   Containers that are in a delegated cgroup but share the pid namespace
>   with the host or other containers.
> - Service managers such as systemd use cgroups to group and organize
>   processes belonging to a service. They usually rely on a recursive
>   algorithm now to kill a service. With cgroup.kill this becomes a
>   simple write to cgroup.kill.
> - Userspace OOM implementations can make good use of this feature to
>   efficiently take down whole cgroups quickly.
> - The kill program can gain a new
>   kill --cgroup /sys/fs/cgroup/delegated
>   flag to take down cgroups.
> 
> A few observations about the semantics:
> - If parent and child are in the same cgroup and CLONE_INTO_CGROUP is
>   not specified we are not taking cgroup mutex meaning the cgroup can be
>   killed while a process in that cgroup is forking.
>   If the kill request happens right before cgroup_can_fork() and before
>   the parent grabs its siglock the parent is guaranteed to see the
>   pending SIGKILL. In addition we perform another check in
>   cgroup_post_fork() whether the cgroup is being killed and is so take
>   down the child (see above). This is robust enough and protects gainst
>   forkbombs. If userspace really really wants to have stricter
>   protection the simple solution would be to grab the write side of the
>   cgroup threadgroup rwsem which will force all ongoing forks to
>   complete before killing starts. We concluded that this is not
>   necessary as the semantics for concurrent forking should simply align
>   with freezer where a similar check as cgroup_post_fork() is performed.
> 
>   For all other cases CLONE_INTO_CGROUP is required. In this case we
>   will grab the cgroup mutex so the cgroup can't be killed while we
>   fork. Once we're done with the fork and have dropped cgroup mutex we
>   are visible and will be found by any subsequent kill request.
> 
> - We obviously don't kill kthreads. This means a cgroup that has a
>   kthread will not become empty after killing and consequently no
>   unpopulated event will be generated. The assumption is that kthreads
>   should be in the root cgroup only anyway so this is not an issue.
> - We skip killing tasks that already have pending fatal signals.
> - Freezer doesn't care about tasks in different pid namespaces, i.e. if
>   you have two tasks in different pid namespaces the cgroup would still
>   be frozen. The cgroup.kill mechanism consequently behaves the same
>   way, i.e. we kill all processes and ignore in which pid namespace they
>   exist.
> - If the caller is located in a cgroup that is killed the caller will
>   obviously be killed as well.
> 
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: cgroups@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Hello Christian!

This version looks very good to me, thanks for working on it!
One small not below.

> ---
>  include/linux/cgroup-defs.h |  3 ++
>  kernel/cgroup/cgroup.c      | 90 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 559ee05f86b2..43fef771009a 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -71,6 +71,9 @@ enum {
>  
>  	/* Cgroup is frozen. */
>  	CGRP_FROZEN,
> +
> +	/* Control group has to be killed. */
> +	CGRP_KILL,
>  };
>  
>  /* cgroup_root->flags */
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 9153b20e5cc6..000f58b6ea35 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3654,6 +3654,80 @@ static ssize_t cgroup_freeze_write(struct kernfs_open_file *of,
>  	return nbytes;
>  }
>  
> +static void __cgroup_kill(struct cgroup *cgrp)
> +{
> +	struct css_task_iter it;
> +	struct task_struct *task;
> +
> +	lockdep_assert_held(&cgroup_mutex);
> +
> +	spin_lock_irq(&css_set_lock);
> +	set_bit(CGRP_KILL, &cgrp->flags);
> +	spin_unlock_irq(&css_set_lock);
> +
> +	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
> +	while ((task = css_task_iter_next(&it))) {
> +		/* Ignore kernel threads here. */
> +		if (task->flags & PF_KTHREAD)
> +			continue;
> +
> +		/* Skip tasks that are already dying. */
> +		if (__fatal_signal_pending(task))
> +			continue;
> +
> +		send_sig(SIGKILL, task, 0);
> +	}
> +	css_task_iter_end(&it);
> +
> +	spin_lock_irq(&css_set_lock);
> +	clear_bit(CGRP_KILL, &cgrp->flags);
> +	spin_unlock_irq(&css_set_lock);
> +}
> +
> +static void cgroup_kill(struct cgroup *cgrp)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct cgroup *dsct;
> +
> +	lockdep_assert_held(&cgroup_mutex);
> +
> +	cgroup_for_each_live_descendant_pre(dsct, css, cgrp)
> +		__cgroup_kill(dsct);
> +}
> +
> +static ssize_t cgroup_kill_write(struct kernfs_open_file *of, char *buf,
> +				 size_t nbytes, loff_t off)
> +{
> +	ssize_t ret = 0;
> +	int kill;
> +	struct cgroup *cgrp;
> +
> +	ret = kstrtoint(strstrip(buf), 0, &kill);
> +	if (ret)
> +		return ret;
> +
> +	if (kill != 1)
> +		return -ERANGE;
> +
> +	cgrp = cgroup_kn_lock_live(of->kn, false);
> +	if (!cgrp)
> +		return -ENOENT;
> +
> +	/*
> +	 * Killing is a process directed operation, i.e. the whole thread-group
> +	 * is taken down so act like we do for cgroup.procs and only make this
> +	 * writable in non-threaded cgroups.
> +	 */
> +	if (cgroup_is_threaded(cgrp))
> +		ret = -EOPNOTSUPP;
> +	else
> +		cgroup_kill(cgrp);
> +
> +	cgroup_kn_unlock(of->kn);
> +
> +	return ret ?: nbytes;
> +}
> +
>  static int cgroup_file_open(struct kernfs_open_file *of)
>  {
>  	struct cftype *cft = of_cft(of);
> @@ -4846,6 +4920,11 @@ static struct cftype cgroup_base_files[] = {
>  		.seq_show = cgroup_freeze_show,
>  		.write = cgroup_freeze_write,
>  	},
> +	{
> +		.name = "cgroup.kill",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.write = cgroup_kill_write,
> +	},
>  	{
>  		.name = "cpu.stat",
>  		.seq_show = cpu_stat_show,
> @@ -6077,6 +6156,7 @@ void cgroup_post_fork(struct task_struct *child,
>  		      struct kernel_clone_args *kargs)
>  	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
>  {
> +	bool kill = false;
>  	struct cgroup_subsys *ss;
>  	struct css_set *cset;
>  	int i;
> @@ -6088,6 +6168,12 @@ void cgroup_post_fork(struct task_struct *child,
>  
>  	/* init tasks are special, only link regular threads */
>  	if (likely(child->pid)) {
> +		struct cgroup *cgrp;
> +
> +		/* Check whether the target cgroup is being killed. */
> +		cgrp = kargs->cgrp ?: cset->dfl_cgrp;
> +		kill = test_bit(CGRP_KILL, &cgrp->flags);
> +
>  		WARN_ON_ONCE(!list_empty(&child->cg_list));
>  		cset->nr_tasks++;
>  		css_set_move_task(child, NULL, cset, false);
> @@ -6135,6 +6221,10 @@ void cgroup_post_fork(struct task_struct *child,
>  		put_css_set(rcset);
>  	}
>  
> +	/* Take down child immediately. */
> +	if (kill)
> +		send_sig(SIGKILL, child, 0);
> +

This part can be hot, so I'd integrate it better with the freezer check:
instead of getting child task's cgroup's flags and checking individual
bits twice we can do it once.

Other than that the patch looks good to me.

Thanks!
