Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116B437477D
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhEER6P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 13:58:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4906 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234645AbhEER6K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 13:58:10 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145Hsrcu026625;
        Wed, 5 May 2021 10:57:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=tE63KoTTc3ZDy3M2qKEnhEtm2nlfirO40BhO2Ed+C3U=;
 b=fuvgoep58fO61XAz0c/v46UvMj9wUXAZekynRfIXj6ifE6pZhupq/jAWOo9NT2aGZcS+
 KBXe0mBtc4FbBRyBy+LszYGU6iC/64ZPuWJf3aBNW/1ekVoDc/ZT44qlOug8kPoVpPfj
 3TNzt7Zwc/rIGoG68e0fSdJtXo2nLLJ95EQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38bee0mx8d-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 10:57:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 10:57:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2vXOdHEUI5aeicKmjQqes2v/hSu+PNn+7RWs+kFgOf959kuxjpthkIgNFgoNKVad7Dqe0rw+8TYpV3AUcVHQboXQ0IRBDUIPS4W5WAK3b6oGVgDD2xA9/3yRWiHFG/FqStFO9x3aZGlQs6IwIeXVImuAdUp2rMI5/r5bK0o+9tXde0J2CMISMfUOmUvG/C8zDxAJ0QJXGQzmNsnZ5OucD5mx1/osi3+Z+W9IVGlZ1BNages58EmA9IMbN5JkhQZ/1XsPmACnZPmx8+r1t4VHtr2PkYqQtW51fH8OR5Ta3nrRPCjwVbjncIQb1qEsLHFH+38xywYL8xDcaPlbm5LIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tE63KoTTc3ZDy3M2qKEnhEtm2nlfirO40BhO2Ed+C3U=;
 b=VH4nIzpBmFOi4usOFyErbb4RfzsVKRDsXn1jGwYV8sMGbAzI/l9IOxXZHnRKReSclHsWRuWWAGxhWag2hg8VGGsVr+a8Mbkpu+fe+rh5FexnbfX1LufEdUlKumOilnCIg4P1jNFbgIcxBNnBLQdsyc605W91C5R62jybVo5pDnGPW04arVGpMSl0zzjg8dJRDZjMg4aIKXo51dT1dBRNtJ2PWe4b533Oiad9keebgpJ8MlepB7QK21mFb2m+HS7lFusraJvR2yp7+BrZJksD5HncbdRYYTR7qGXy2NyMaXdq+Rf0ZNb8TUtPGUbPst1Ox7FLuR3/sIkby3HzJAPfsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3144.namprd15.prod.outlook.com (2603:10b6:a03:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.42; Wed, 5 May
 2021 17:57:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 17:57:03 +0000
Date:   Wed, 5 May 2021 10:57:00 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <containers@lists.linux.dev>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 1/5] cgroup: introduce cgroup.kill
Message-ID: <YJLcbOtcv8qWtMRQ@carbon.DHCP.thefacebook.com>
References: <20210503143922.3093755-1-brauner@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210503143922.3093755-1-brauner@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:6fa5]
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:6fa5) by SJ0PR03CA0041.namprd03.prod.outlook.com (2603:10b6:a03:33e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 17:57:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2841655d-6b5c-452d-f914-08d90fef3060
X-MS-TrafficTypeDiagnostic: BYAPR15MB3144:
X-Microsoft-Antispam-PRVS: <BYAPR15MB31445C671B8EEA34A9B90488BE599@BYAPR15MB3144.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VD77GkMjoirzRVC6vJnWIWHbezvHsXdfghxtdJYdks7JiFg6TGtlJ8+QAhT/XOK8D92+5m0yhde234oecnV5RjMpL09oQfY7osJ0eAzYSzOCWWhNKeeaNNc1GAVRXhmxkrgl5G5SKmhCmYgIDgFy6y/db9IBlKXbSXhQRxFsHdrKKTER4IRg2dI8CgtAL2rlt9tYOdFKeDSAkA+e3XZ6r1B90o1Gl0JkWfoTmk3q2uF0YD/6D/ata/sE7BB5Kj1K2cu5g+FoxsD2dS1dFLMifVnjkghGWNK3214jj0vOw4hLtSdzm06JQQ6janOO63nQAY8OJMAsCFYISPWbGxj8TL4/pdAP019eBRqFza1ABg23P+SoRSvZPP21WYFyaOFq7UUOZaOF5KmvNwEkO5ukKgIFe7+BtLVP+gst2Z9LlQNfA4D1xPe+mWGWfdop0MyVoB7sRYQY9IJpWUAmJkFCMRBjf16u3a6K41xXDsfXnIgtDuSYTM3f9HAd8me722F4T74qRH266yr9/zhSn5cqfl/wUQlBeuz9r3txYAHA0qkAI9HdmiV2i0feD+RF5Lnm34p0WANVPhBthOVMUDN5i9jslUaX9UcS9dpP9QA0+us=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(8676002)(30864003)(316002)(66476007)(2906002)(55016002)(54906003)(38100700002)(86362001)(186003)(83380400001)(8936002)(52116002)(478600001)(7696005)(66946007)(6916009)(6506007)(5660300002)(66556008)(16526019)(4326008)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bjkQpNXaNYLf3CR88zCplRc7i2FN0+Gruuvt5RuZN5GX0kibq2AEgcHDJo3n?=
 =?us-ascii?Q?iaK1R+iMQClDxhVeOY6WsyENCV6yB7a5m2knVcYnJjdtO4nZ197O7Vdgj5jF?=
 =?us-ascii?Q?SpnME7IPPNXUY5V7S8Ia2Z8EucnScs2FFZRLOiCA/WTphwHqnOkFvvvUUrJz?=
 =?us-ascii?Q?CH2/qqfM3v00MTNi3gvRctwveHL4WnEXXaj4GhTcHKUS2D59+rSXQpr3x9zC?=
 =?us-ascii?Q?kVw/hETNb2ivaI4V3Xd/t959m/+mWQXBxVRwhycbf97N6ZlhIXJEQp9N9yKZ?=
 =?us-ascii?Q?CCbasbWcT+Bcx8mSgY52C9mhz3OccELyelX74/RxWKC/dKRJr8lGOyHB62hc?=
 =?us-ascii?Q?hO7wxe+RvCMQmb4h1VjPSRMsDG1F5ub2FoSNj2i/sV7lgaa9FzGgO0vLzvH9?=
 =?us-ascii?Q?otYFVA40nZEIyUIquM2EVfXTKskWH0mc+cUPh+hoI6obXecdQ8NLyuZMCReS?=
 =?us-ascii?Q?yFP+xiqUkW15kg5POgT4r5SMztIQRRJ3jBqyvjq+RiVtv2VpaYpeNgy5dUp3?=
 =?us-ascii?Q?/W6LLfavuJYETbQq2Olj3pYw8ncAkX1t6XuVXMDM+JEfBckmqwbbs6qyJUVr?=
 =?us-ascii?Q?UZLZMWh2vo4FA8h8pwNLgXaDnMp3qk9Y+eqQsSMbrYTX59NC1GMGq7xfltWb?=
 =?us-ascii?Q?biO2nz4dUGKPJL2f9b435XYNvGBYKptKsbh6lUD9Llv2aLQtC+oKn/Qa3p1z?=
 =?us-ascii?Q?kJCkV/6i1rDMWPyp1jxdZDb3gqXRa0Lmlz2tLKowq3qBluJuvdgYpqBGZSrx?=
 =?us-ascii?Q?wACg6Hiquwt5arkYKS/nOFSFXS252msNAqEgIqJIzr3zj4Zz2fgqO6038zRo?=
 =?us-ascii?Q?BFdlxUY3TppLpDpDr+2dJ27dkkwSXUbQTyXO14uM/RrvNAY+CB7ocKoDyIZQ?=
 =?us-ascii?Q?u3fOg+q6HU9MV7MdbYtifvEOobkQm/svRrrda/F6VDswM6qcO2GDm4td2xku?=
 =?us-ascii?Q?X5AlBfvcz4qqRsVEIvV3523UPK8qEoCkDaBiDBG37FhB6bxZZBofm4hsLgGb?=
 =?us-ascii?Q?f//c6JJK/0b6uIpXf5hgVRCY0cXHCmO/At+uh0cKefIw5NAmelNIJRRAzrUg?=
 =?us-ascii?Q?LjGLOUOVAsqKrr45QGpvkSy+U3mvlwxockegveMdxw4wHLpe3Irm0yIrFmF+?=
 =?us-ascii?Q?nlXxzpLMRueDFP8itbb78Dgws/rvc/T7vNdPM4ZyFaUA6fbdYT7GVHSmzTDq?=
 =?us-ascii?Q?W8dKD8XOic5P/e/9WtD53Kz7FiArTyVZcFx8be/5UtcSpwxwdF+StvjRW+da?=
 =?us-ascii?Q?4pkxCaXttsL/UFB6Zglb+FIjE4xllBSOJftwP/8QzMppKqREV/NaTshtt/tb?=
 =?us-ascii?Q?H8qO2TklipjrouiANQoxO+pU1Kf15zOYA3NRKTgF+2c3xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2841655d-6b5c-452d-f914-08d90fef3060
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 17:57:03.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jmrb5yJhGUI0Qp/iAi0H1KEgwyFz4z0Lgbqf9vLJnpE/dcpRu7RnZrHtIyKRr9uD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3144
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: uU2fCwrsLAnyzyewBkPRI8ru-iYB1rV3
X-Proofpoint-GUID: uU2fCwrsLAnyzyewBkPRI8ru-iYB1rV3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_09:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011 bulkscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=889 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 03, 2021 at 04:39:19PM +0200, Christian Brauner wrote:
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
> ---
> 
> The series can be pulled from
> 
> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/cgroup.kill.v5.14
> 
> /* v2 */
> - Roman Gushchin <guro@fb.com>:
>   - Retrieve cgrp->flags only once and check CGRP_* bits on it.
> ---
>  include/linux/cgroup-defs.h |   3 +
>  kernel/cgroup/cgroup.c      | 127 ++++++++++++++++++++++++++++++++----
>  2 files changed, 116 insertions(+), 14 deletions(-)
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
> index 9153b20e5cc6..aee84b99534a 100644
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
> @@ -6077,6 +6156,8 @@ void cgroup_post_fork(struct task_struct *child,
>  		      struct kernel_clone_args *kargs)
>  	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
>  {
> +	unsigned long cgrp_flags = 0;
> +	bool kill = false;
>  	struct cgroup_subsys *ss;
>  	struct css_set *cset;
>  	int i;
> @@ -6088,6 +6169,11 @@ void cgroup_post_fork(struct task_struct *child,
>  
>  	/* init tasks are special, only link regular threads */
>  	if (likely(child->pid)) {
> +		if (kargs->cgrp)
> +			cgrp_flags = kargs->cgrp->flags;
> +		else
> +			cgrp_flags = cset->dfl_cgrp->flags;
> +
>  		WARN_ON_ONCE(!list_empty(&child->cg_list));
>  		cset->nr_tasks++;
>  		css_set_move_task(child, NULL, cset, false);
> @@ -6096,23 +6182,32 @@ void cgroup_post_fork(struct task_struct *child,
>  		cset = NULL;
>  	}
>  
> -	/*
> -	 * If the cgroup has to be frozen, the new task has too.  Let's set
> -	 * the JOBCTL_TRAP_FREEZE jobctl bit to get the task into the
> -	 * frozen state.
> -	 */
> -	if (unlikely(cgroup_task_freeze(child))) {
> -		spin_lock(&child->sighand->siglock);
> -		WARN_ON_ONCE(child->frozen);
> -		child->jobctl |= JOBCTL_TRAP_FREEZE;
> -		spin_unlock(&child->sighand->siglock);
> +	if (!(child->flags & PF_KTHREAD)) {
> +		if (test_bit(CGRP_FREEZE, &cgrp_flags)) {
> +			/*
> +			 * If the cgroup has to be frozen, the new task has
> +			 * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
> +			 * get the task into the frozen state.
> +			 */
> +			spin_lock(&child->sighand->siglock);
> +			WARN_ON_ONCE(child->frozen);
> +			child->jobctl |= JOBCTL_TRAP_FREEZE;
> +			spin_unlock(&child->sighand->siglock);
> +
> +			/*
> +			 * Calling cgroup_update_frozen() isn't required here,
> +			 * because it will be called anyway a bit later from
> +			 * do_freezer_trap(). So we avoid cgroup's transient
> +			 * switch from the frozen state and back.
> +			 */
> +		}

I think this part can be optimized a bit further:
1) we don't need atomic test_bit() here
2) all PF_KTHREAD, CGRP_FREEZE and CGRP_KILL cases are very unlikely

So something like this could work (completely untested):

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 0965b44ff425..f567ca69119d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6190,13 +6190,15 @@ void cgroup_post_fork(struct task_struct *child,
                cset = NULL;
        }
 
-       if (!(child->flags & PF_KTHREAD)) {
-               if (test_bit(CGRP_FREEZE, &cgrp_flags)) {
-                       /*
-                        * If the cgroup has to be frozen, the new task has
-                        * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
-                        * get the task into the frozen state.
-                        */
+
+       if (unlikely(!(child->flags & PF_KTHREAD) &&
+                    cgrp_flags & (CGRP_FREEZE | CGRP_KILL))) {
+               /*
+                * If the cgroup has to be frozen, the new task has
+                * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
+                * get the task into the frozen state.
+                */
+               if (cgrp_flags & CGRP_FREEZE) {
                        spin_lock(&child->sighand->siglock);
                        WARN_ON_ONCE(child->frozen);
                        child->jobctl |= JOBCTL_TRAP_FREEZE;
@@ -6215,7 +6217,8 @@ void cgroup_post_fork(struct task_struct *child,
                 * child down right after we finished preparing it for
                 * userspace.
                 */
-               kill = test_bit(CGRP_KILL, &cgrp_flags);
+               if (cgrp_flags & CGRP_KILL)
+                       kill = true;
        }
 
        spin_unlock_irq(&css_set_lock);


>  
>  		/*
> -		 * Calling cgroup_update_frozen() isn't required here,
> -		 * because it will be called anyway a bit later from
> -		 * do_freezer_trap(). So we avoid cgroup's transient switch
> -		 * from the frozen state and back.
> +		 * If the cgroup is to be killed notice it now and take the
> +		 * child down right after we finished preparing it for
> +		 * userspace.
>  		 */
> +		kill = test_bit(CGRP_KILL, &cgrp_flags);
>  	}
>  
>  	spin_unlock_irq(&css_set_lock);
> @@ -6135,6 +6230,10 @@ void cgroup_post_fork(struct task_struct *child,
>  		put_css_set(rcset);
>  	}
>  
> +	/* Cgroup has to be killed so take down child immediately. */
> +	if (kill)
> +		send_sig(SIGKILL, child, 0);

I think it's better to use do_send_sig_info() here, which skips the check
for the signal number, which is obviously valid.

Thanks!
