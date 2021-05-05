Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F2F37488B
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 21:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhEETQN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 15:16:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53780 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233826AbhEETQI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 15:16:08 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145IoCZx009380;
        Wed, 5 May 2021 12:15:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=N64DO9z0bqZqETAacTTYxAfnw2za17Au4eGOan2WJAM=;
 b=WqretjUE8lCak/rTBE/0k6qV3IWzV0OjeM0RFP95IEyoXx8qA8DBlJZwd6VjT9mcPIg0
 +as/PI4obRlzsV6S7W8mzjsfqs7/5Wmnn0Dt0Rw7dTCtnP+oO8kkE9p5Uw871MKAhGeb
 Obvm6CDsW8VBeRRH0JMXC5p3G39BlakwAlI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38bebpne1y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 12:15:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 12:13:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQAhM0NloqWc9SOa4dnbBkgvXVm6tOvgXPNSze8wU31ONkvWI5SF75AivWWCFl1IksJpD+cYn8ofEMGLJvT+HxXzNbSBPBVz5N3Ob/O8fRkUMttZilkdvOTFreA57MQUbbTfca+T9mJDtoLE240HRsEOyUAgdcHuGU0YkPFHapO/wfr3wGoTJLCtPp8FShAcy3sardyTEScs0UdWX4EF+c8rMWh78B5iUtZ0ikSMEOSmHXf8uBPcJZJCDyv8p1XR/Vkjl/XAvu//tzT3+OJBs1Mbaf19tGesKxH5PrhyAvMCiWaOmY4nmO9t7jFUoKUSwgSztkLLFQaqMcu38QZd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N64DO9z0bqZqETAacTTYxAfnw2za17Au4eGOan2WJAM=;
 b=FLPIjgaw3LgXyHWRDpIxEyIytm0Kg3Ko0yECvf6bIQGSXpnU0ACrKYHWkb1D+CXQguWjCKxtHh2LjW7LZXKdr2vQNx0aR0L5a+hIwphpFsWsNt6c4cAVvro5+uUYj0PAb4PsxHJSG3X8I0Y9Vdd3jsuwhyVXejQ+px+0oUfbV6esMoJvj3fq1bV1oy+HJp/EqBRWspmFn0ykf0/elWMRhfXKRKhZdRL//qgrqLlmFtBp5yk1OhsHRE5MUREtBI7eCpPPC+aFYDwf+QYlgJtTym3Tfobj6Q612qlT6MjQSF7LKtDMDEChqHi4rWOqHcmgTnM5I/Uq6JIIjsQYoSpAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2712.namprd15.prod.outlook.com (2603:10b6:a03:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 19:13:53 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 19:13:53 +0000
Date:   Wed, 5 May 2021 12:13:48 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <containers@lists.linux.dev>
Subject: Re: [PATCH v2 1/5] cgroup: introduce cgroup.kill
Message-ID: <YJLubKN2JmffZjLd@carbon.dhcp.thefacebook.com>
References: <20210503143922.3093755-1-brauner@kernel.org>
 <YJLcbOtcv8qWtMRQ@carbon.DHCP.thefacebook.com>
 <20210505184632.jvg54r75d5lkdhuf@wittgenstein>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210505184632.jvg54r75d5lkdhuf@wittgenstein>
X-Originating-IP: [2620:10d:c090:400::5:47f7]
X-ClientProxiedBy: MW4PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:303:8e::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:47f7) by MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 19:13:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64178972-75df-4aed-d6c8-08d90ff9ebf5
X-MS-TrafficTypeDiagnostic: BYAPR15MB2712:
X-Microsoft-Antispam-PRVS: <BYAPR15MB27128E1D38E7DDBA0D7D9C04BE599@BYAPR15MB2712.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ScnhPpKlNVbOz8fYhc+W9ZBSLrDgq2S+lz5fcVkt14OEo5C3c77PPV8xEBL+DOSuftRox7akl/vgdeeBmHGoWTQk++R/QbzbvedR6wpyreJP+G8fYRpzYinku2Va5Gm1Gw1+zKFdcQrWQYpdCDcYUMWfYT+SCX+pLRFe9IHDaRVJEAkVpy6UEmSnCpfzoAYyMrEq3/HjBD7u860IDxeRRSfNzDnRC9cWJ72z3ymX4C8Autx/9dCaJgvR2uGPq2xFqI4YL+8YKg+XE/iFqHByHvedLaM0nyd4v2/zFss/IBSLNiJNbxxYeY9U13PAqYc3iN6Zx0LQqRxI7zGugxGOF27S51vuHYzTGLY1TySWt/l4g4VcEi8bGVqH1SZyi6lh8g3goKsiCUup+CVoUxZd59M8ObYTNY6dMN9PGJzX/eJqVs3o3Hh5khMc8dyYVbtlp0pSsJ3bNAMIX5zg8oRwHyPK+oczzTIbHkU7OQ+ayGOukMmweHEK5paxcVUg+TMczml3Yy3sRhrc6zkTiEEmIMnrbPNIDvP6pzKcR81uys4QPT+Ku0BacDiJCLgMvYrpYq2YPSFNBFhHNp9MtbLttuBh9HMT6+SMs+iYrcByavA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(8936002)(38100700002)(6916009)(66556008)(6506007)(86362001)(66946007)(66476007)(186003)(16526019)(8676002)(9686003)(83380400001)(54906003)(5660300002)(55016002)(30864003)(6666004)(7696005)(2906002)(4326008)(478600001)(316002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?u2wmJpVaZgtvPCeXHEid3+f6d9CENcNxow+rqIp62k/1lF2KFOmQHutnZhRj?=
 =?us-ascii?Q?Iyb01dpPDxM8l1zNfIgj9xaVWLfwrPbGQYjEnO/5XSaLidLiI7GI4MFZ+Olj?=
 =?us-ascii?Q?NctE1mCgLKUBUaL8x+d6jcs79Sgop5Wzz5jLt5rdGrYTKTuYkldou5H2rq2n?=
 =?us-ascii?Q?ayOEmTbJTdxmXlL7wv36fdjVcIUTcfJ5Gs3dAqjpxwmKjJa1h0hrqg6t3g+H?=
 =?us-ascii?Q?pP+R85lezEkOGdVWpRpcM8p5vKNY2HN1u/8WDPEiLyP1XE+wpxc0i/QpO/Gl?=
 =?us-ascii?Q?QfgQHfb9X6cK8HwLiIiQoQNOf9lmLQUaqyV0PdHXkCYcZUmLuMblNSVDF8EX?=
 =?us-ascii?Q?sJ33wZC94zhuuiGdjemA+QwtRT+u8eUIi0uxHLbFY4EJfF1pQdFstmkpiVBi?=
 =?us-ascii?Q?+ywXYtqfBqZZ3nQYiX5bkxJUtp1Y3apmqtYPmzSGld/VacHOq7jcaBvpAQm6?=
 =?us-ascii?Q?D6iYuijqK3im3PLdnHFMQ/4fgBPbeVsMwnFpqqx4aRyCW7Ys3Anfay8cVx25?=
 =?us-ascii?Q?WKWQZkZS+AOwPqqRCvcak+mVjRSDYqNkYA7KaoLAS6PI5Row4GdyXDu3wmDI?=
 =?us-ascii?Q?2Lphh/QMogDnPBpPS91Fe7CJlVb8DfkVLoIFxNFv81qHevDYQ47iPmkxvbVm?=
 =?us-ascii?Q?f971oGIqgDStFVA4kiegs7zpPf1YpGV0LaqSwlpbnw2NeOF46oH0sLwVqAV7?=
 =?us-ascii?Q?VL4TCCeWtBB1W0RxC0ZqtZbZ9m1g8a3rCFJkVhehulE2vOrQsnjKr7Bffl2L?=
 =?us-ascii?Q?qN2rIbZtF5/meAAU65YrNezqsYL9CqHLl9yfNGI+T/OnChaRyJqzVz9EuoQJ?=
 =?us-ascii?Q?nPMHZ8RurueAxro5E1ASp/dz42vL4HTFmP3hD0M0Ic/VpMUmlZXELGaXS4AC?=
 =?us-ascii?Q?3Oyc6LcG8sVqlP8shT4M6gDwFko6gb6HpUJYYXP4aP8VR3vEmOn3OEI16jc4?=
 =?us-ascii?Q?p4tUQNgYXjyOkAydvMO69Xort+o9Ks6Y9PkE95yM1liT5dCTvzRkdkOAqCyw?=
 =?us-ascii?Q?VXuvBstF7ZfkSzmrGdkDOWFLUJLd/gTiykOvOfUIJvqOQiYlUkVnwwuWVBTL?=
 =?us-ascii?Q?U8cPkgzkHWgI9k0Rd5qGN47JPlTJQHSJfhaJAyLlSzJvOHGZo7JqQJ5tMDp1?=
 =?us-ascii?Q?fgGiqwqMjEhrFxPbt87PREFfVMEO1TajmUDmAGWirmnS4eL0YdXTrHKugiBY?=
 =?us-ascii?Q?Sv7vEEosaP2UD06QML9suO6up0SaxqwLyzLNccsjYO8qGSfLB5nz59NS7KuI?=
 =?us-ascii?Q?a21efl4eP6jCJe54AgRIcB/pxKY49TWCSrLim+dBYw3VPeKv2/CRtzkDNup0?=
 =?us-ascii?Q?zW2Qck1zgvWtQ9CK80s4nEjYqYEE9S+UKpFBYfplx8G2iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64178972-75df-4aed-d6c8-08d90ff9ebf5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 19:13:53.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/53E+y1B4YP+Di4OL0ruaCXOOKkqACFtBkRB7sQjQTv+fy4f2K6t/ml0nlEPmRq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2712
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: TkZIb5Wg8O84bi-PqdPYt2yaIskvEtWk
X-Proofpoint-ORIG-GUID: TkZIb5Wg8O84bi-PqdPYt2yaIskvEtWk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_09:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=766 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 08:46:32PM +0200, Christian Brauner wrote:
> On Wed, May 05, 2021 at 10:57:00AM -0700, Roman Gushchin wrote:
> > On Mon, May 03, 2021 at 04:39:19PM +0200, Christian Brauner wrote:
> > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > 
> > > Introduce the cgroup.kill file. It does what it says on the tin and
> > > allows a caller to kill a cgroup by writing "1" into cgroup.kill.
> > > The file is available in non-root cgroups.
> > > 
> > > Killing cgroups is a process directed operation, i.e. the whole
> > > thread-group is affected. Consequently trying to write to cgroup.kill in
> > > threaded cgroups will be rejected and EOPNOTSUPP returned. This behavior
> > > aligns with cgroup.procs where reads in threaded-cgroups are rejected
> > > with EOPNOTSUPP.
> > > 
> > > The cgroup.kill file is write-only since killing a cgroup is an event
> > > not which makes it different from e.g. freezer where a cgroup
> > > transitions between the two states.
> > > 
> > > As with all new cgroup features cgroup.kill is recursive by default.
> > > 
> > > Killing a cgroup is protected against concurrent migrations through the
> > > cgroup mutex. To protect against forkbombs and to mitigate the effect of
> > > racing forks a new CGRP_KILL css set lock protected flag is introduced
> > > that is set prior to killing a cgroup and unset after the cgroup has
> > > been killed. We can then check in cgroup_post_fork() where we hold the
> > > css set lock already whether the cgroup is currently being killed. If so
> > > we send the child a SIGKILL signal immediately taking it down as soon as
> > > it returns to userspace. To make the killing of the child semantically
> > > clean it is killed after all cgroup attachment operations have been
> > > finalized.
> > > 
> > > There are various use-cases of this interface:
> > > - Containers usually have a conservative layout where each container
> > >   usually has a delegated cgroup. For such layouts there is a 1:1
> > >   mapping between container and cgroup. If the container in addition
> > >   uses a separate pid namespace then killing a container usually becomes
> > >   a simple kill -9 <container-init-pid> from an ancestor pid namespace.
> > >   However, there are quite a few scenarios where that isn't true. For
> > >   example, there are containers that share the cgroup with other
> > >   processes on purpose that are supposed to be bound to the lifetime of
> > >   the container but are not in the same pidns of the container.
> > >   Containers that are in a delegated cgroup but share the pid namespace
> > >   with the host or other containers.
> > > - Service managers such as systemd use cgroups to group and organize
> > >   processes belonging to a service. They usually rely on a recursive
> > >   algorithm now to kill a service. With cgroup.kill this becomes a
> > >   simple write to cgroup.kill.
> > > - Userspace OOM implementations can make good use of this feature to
> > >   efficiently take down whole cgroups quickly.
> > > - The kill program can gain a new
> > >   kill --cgroup /sys/fs/cgroup/delegated
> > >   flag to take down cgroups.
> > > 
> > > A few observations about the semantics:
> > > - If parent and child are in the same cgroup and CLONE_INTO_CGROUP is
> > >   not specified we are not taking cgroup mutex meaning the cgroup can be
> > >   killed while a process in that cgroup is forking.
> > >   If the kill request happens right before cgroup_can_fork() and before
> > >   the parent grabs its siglock the parent is guaranteed to see the
> > >   pending SIGKILL. In addition we perform another check in
> > >   cgroup_post_fork() whether the cgroup is being killed and is so take
> > >   down the child (see above). This is robust enough and protects gainst
> > >   forkbombs. If userspace really really wants to have stricter
> > >   protection the simple solution would be to grab the write side of the
> > >   cgroup threadgroup rwsem which will force all ongoing forks to
> > >   complete before killing starts. We concluded that this is not
> > >   necessary as the semantics for concurrent forking should simply align
> > >   with freezer where a similar check as cgroup_post_fork() is performed.
> > > 
> > >   For all other cases CLONE_INTO_CGROUP is required. In this case we
> > >   will grab the cgroup mutex so the cgroup can't be killed while we
> > >   fork. Once we're done with the fork and have dropped cgroup mutex we
> > >   are visible and will be found by any subsequent kill request.
> > > - We obviously don't kill kthreads. This means a cgroup that has a
> > >   kthread will not become empty after killing and consequently no
> > >   unpopulated event will be generated. The assumption is that kthreads
> > >   should be in the root cgroup only anyway so this is not an issue.
> > > - We skip killing tasks that already have pending fatal signals.
> > > - Freezer doesn't care about tasks in different pid namespaces, i.e. if
> > >   you have two tasks in different pid namespaces the cgroup would still
> > >   be frozen. The cgroup.kill mechanism consequently behaves the same
> > >   way, i.e. we kill all processes and ignore in which pid namespace they
> > >   exist.
> > > - If the caller is located in a cgroup that is killed the caller will
> > >   obviously be killed as well.
> > > 
> > > Cc: Shakeel Butt <shakeelb@google.com>
> > > Cc: Roman Gushchin <guro@fb.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: cgroups@vger.kernel.org
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > ---
> > > 
> > > The series can be pulled from
> > > 
> > > git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/cgroup.kill.v5.14
> > > 
> > > /* v2 */
> > > - Roman Gushchin <guro@fb.com>:
> > >   - Retrieve cgrp->flags only once and check CGRP_* bits on it.
> > > ---
> > >  include/linux/cgroup-defs.h |   3 +
> > >  kernel/cgroup/cgroup.c      | 127 ++++++++++++++++++++++++++++++++----
> > >  2 files changed, 116 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> > > index 559ee05f86b2..43fef771009a 100644
> > > --- a/include/linux/cgroup-defs.h
> > > +++ b/include/linux/cgroup-defs.h
> > > @@ -71,6 +71,9 @@ enum {
> > >  
> > >  	/* Cgroup is frozen. */
> > >  	CGRP_FROZEN,
> > > +
> > > +	/* Control group has to be killed. */
> > > +	CGRP_KILL,
> > >  };
> > >  
> > >  /* cgroup_root->flags */
> > > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > > index 9153b20e5cc6..aee84b99534a 100644
> > > --- a/kernel/cgroup/cgroup.c
> > > +++ b/kernel/cgroup/cgroup.c
> > > @@ -3654,6 +3654,80 @@ static ssize_t cgroup_freeze_write(struct kernfs_open_file *of,
> > >  	return nbytes;
> > >  }
> > >  
> > > +static void __cgroup_kill(struct cgroup *cgrp)
> > > +{
> > > +	struct css_task_iter it;
> > > +	struct task_struct *task;
> > > +
> > > +	lockdep_assert_held(&cgroup_mutex);
> > > +
> > > +	spin_lock_irq(&css_set_lock);
> > > +	set_bit(CGRP_KILL, &cgrp->flags);
> > > +	spin_unlock_irq(&css_set_lock);
> > > +
> > > +	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
> > > +	while ((task = css_task_iter_next(&it))) {
> > > +		/* Ignore kernel threads here. */
> > > +		if (task->flags & PF_KTHREAD)
> > > +			continue;
> > > +
> > > +		/* Skip tasks that are already dying. */
> > > +		if (__fatal_signal_pending(task))
> > > +			continue;
> > > +
> > > +		send_sig(SIGKILL, task, 0);
> > > +	}
> > > +	css_task_iter_end(&it);
> > > +
> > > +	spin_lock_irq(&css_set_lock);
> > > +	clear_bit(CGRP_KILL, &cgrp->flags);
> > > +	spin_unlock_irq(&css_set_lock);
> > > +}
> > > +
> > > +static void cgroup_kill(struct cgroup *cgrp)
> > > +{
> > > +	struct cgroup_subsys_state *css;
> > > +	struct cgroup *dsct;
> > > +
> > > +	lockdep_assert_held(&cgroup_mutex);
> > > +
> > > +	cgroup_for_each_live_descendant_pre(dsct, css, cgrp)
> > > +		__cgroup_kill(dsct);
> > > +}
> > > +
> > > +static ssize_t cgroup_kill_write(struct kernfs_open_file *of, char *buf,
> > > +				 size_t nbytes, loff_t off)
> > > +{
> > > +	ssize_t ret = 0;
> > > +	int kill;
> > > +	struct cgroup *cgrp;
> > > +
> > > +	ret = kstrtoint(strstrip(buf), 0, &kill);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (kill != 1)
> > > +		return -ERANGE;
> > > +
> > > +	cgrp = cgroup_kn_lock_live(of->kn, false);
> > > +	if (!cgrp)
> > > +		return -ENOENT;
> > > +
> > > +	/*
> > > +	 * Killing is a process directed operation, i.e. the whole thread-group
> > > +	 * is taken down so act like we do for cgroup.procs and only make this
> > > +	 * writable in non-threaded cgroups.
> > > +	 */
> > > +	if (cgroup_is_threaded(cgrp))
> > > +		ret = -EOPNOTSUPP;
> > > +	else
> > > +		cgroup_kill(cgrp);
> > > +
> > > +	cgroup_kn_unlock(of->kn);
> > > +
> > > +	return ret ?: nbytes;
> > > +}
> > > +
> > >  static int cgroup_file_open(struct kernfs_open_file *of)
> > >  {
> > >  	struct cftype *cft = of_cft(of);
> > > @@ -4846,6 +4920,11 @@ static struct cftype cgroup_base_files[] = {
> > >  		.seq_show = cgroup_freeze_show,
> > >  		.write = cgroup_freeze_write,
> > >  	},
> > > +	{
> > > +		.name = "cgroup.kill",
> > > +		.flags = CFTYPE_NOT_ON_ROOT,
> > > +		.write = cgroup_kill_write,
> > > +	},
> > >  	{
> > >  		.name = "cpu.stat",
> > >  		.seq_show = cpu_stat_show,
> > > @@ -6077,6 +6156,8 @@ void cgroup_post_fork(struct task_struct *child,
> > >  		      struct kernel_clone_args *kargs)
> > >  	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
> > >  {
> > > +	unsigned long cgrp_flags = 0;
> > > +	bool kill = false;
> > >  	struct cgroup_subsys *ss;
> > >  	struct css_set *cset;
> > >  	int i;
> > > @@ -6088,6 +6169,11 @@ void cgroup_post_fork(struct task_struct *child,
> > >  
> > >  	/* init tasks are special, only link regular threads */
> > >  	if (likely(child->pid)) {
> > > +		if (kargs->cgrp)
> > > +			cgrp_flags = kargs->cgrp->flags;
> > > +		else
> > > +			cgrp_flags = cset->dfl_cgrp->flags;
> > > +
> > >  		WARN_ON_ONCE(!list_empty(&child->cg_list));
> > >  		cset->nr_tasks++;
> > >  		css_set_move_task(child, NULL, cset, false);
> > > @@ -6096,23 +6182,32 @@ void cgroup_post_fork(struct task_struct *child,
> > >  		cset = NULL;
> > >  	}
> > >  
> > > -	/*
> > > -	 * If the cgroup has to be frozen, the new task has too.  Let's set
> > > -	 * the JOBCTL_TRAP_FREEZE jobctl bit to get the task into the
> > > -	 * frozen state.
> > > -	 */
> > > -	if (unlikely(cgroup_task_freeze(child))) {
> > > -		spin_lock(&child->sighand->siglock);
> > > -		WARN_ON_ONCE(child->frozen);
> > > -		child->jobctl |= JOBCTL_TRAP_FREEZE;
> > > -		spin_unlock(&child->sighand->siglock);
> > > +	if (!(child->flags & PF_KTHREAD)) {
> > > +		if (test_bit(CGRP_FREEZE, &cgrp_flags)) {
> > > +			/*
> > > +			 * If the cgroup has to be frozen, the new task has
> > > +			 * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
> > > +			 * get the task into the frozen state.
> > > +			 */
> > > +			spin_lock(&child->sighand->siglock);
> > > +			WARN_ON_ONCE(child->frozen);
> > > +			child->jobctl |= JOBCTL_TRAP_FREEZE;
> > > +			spin_unlock(&child->sighand->siglock);
> > > +
> > > +			/*
> > > +			 * Calling cgroup_update_frozen() isn't required here,
> > > +			 * because it will be called anyway a bit later from
> > > +			 * do_freezer_trap(). So we avoid cgroup's transient
> > > +			 * switch from the frozen state and back.
> > > +			 */
> > > +		}
> > 
> > I think this part can be optimized a bit further:
> > 1) we don't need atomic test_bit() here
> > 2) all PF_KTHREAD, CGRP_FREEZE and CGRP_KILL cases are very unlikely
> > 
> > So something like this could work (completely untested):
> > 
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 0965b44ff425..f567ca69119d 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -6190,13 +6190,15 @@ void cgroup_post_fork(struct task_struct *child,
> >                 cset = NULL;
> >         }
> >  
> > -       if (!(child->flags & PF_KTHREAD)) {
> > -               if (test_bit(CGRP_FREEZE, &cgrp_flags)) {
> > -                       /*
> > -                        * If the cgroup has to be frozen, the new task has
> > -                        * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
> > -                        * get the task into the frozen state.
> > -                        */
> > +
> > +       if (unlikely(!(child->flags & PF_KTHREAD) &&
> > +                    cgrp_flags & (CGRP_FREEZE | CGRP_KILL))) {
> 
> The unlikely might make sense.
> 
> But hm, I'm not a fan of the CGRP_FREEZE and CGRP_KILL check without
> test_bit(). That seems a bit ugly. Especially since nowhere in
> kernel/cgroup.c are these bits checked without test_bit().
> 
> Also, this wouldn't work afaict at least not for all values since
> CGRP_FREEZE and CGRP_KILL aren't flags, they're bits defined in an enum.
> (In contrast to cgroup_root->flags which are defined as flags _in an
> enum_.) So it seems they should really be used with test_bit. Otherwise
> this would probably have to be sm like
> 
> if (unlikely(!(child->flags & PF_KTHREAD) &&
> 	(cgrp_flags & (BIT_ULL(CGRP_FREEZE) | BIT_ULL(CGRP_KILL))) {
> 	.
> 	.
> 	.
> 
> which seems unreadable and makes the rest of cgroup.c for these values
> inconsistent.
> Note that before the check was the same for CGRP_FREEZE it was just
> hidden in the helper.
> I really think we should just leave the test_bit() checks.

Ok, you're right that it was (hidden) test_bit() here previously, so I
can't blame your patch and should blame my original code instead :)

Idk how badly we need to optimize this place and maybe having two checks
is a good price for a simpler code. After all, we can optimize it later.

With this said:
Acked-by: Roman Gushchin <guro@fb.com>

Thank you!
