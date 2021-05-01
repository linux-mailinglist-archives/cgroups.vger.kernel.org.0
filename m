Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91E737050D
	for <lists+cgroups@lfdr.de>; Sat,  1 May 2021 04:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhEACuL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Apr 2021 22:50:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230298AbhEACuL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Apr 2021 22:50:11 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1412leLQ016891;
        Fri, 30 Apr 2021 19:49:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=b0kP97dBev0D3IaTNiO7HeEdFidYC4lDAf6FxT+HgG8=;
 b=nJHkRYi2a6yYXqjfPFBKDghdqf7t1bcgj05kbIk8UTZjzzVQ8mIfgWoKNBIBgr4kQC3T
 rAP3IQl8b3QmjH78anGR/vwcAEiXiUbpM9GTZKtMc8z30foZv4V3cTja+ImyFwcN3xgO
 ttTzGMMurGQ7r0FbBIBwnr/VEzzVV1XpzOc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 388uc3rn7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Apr 2021 19:49:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Apr 2021 19:49:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5RiHw5szP82YZDu3vrewap8oTbCpWNUQHBPJEcgYInuZUkrAAdiX2q2te02DW13uOiyci77j1JO3UliR82b+PvQU+O+7d2+AxsCbaWLJLN2tJYvGCz3SbihqnLl2fDeGxFbyzO7vm3sRW0hlmp2dqx7jAKVsObbuCGQebQt14dMW8mVrZYs6rJcQ8TY8jsw/LwtDuP9VhDSdrtMA02tFvr1OTsw0yph+Y/U1JGSf5n3F7KvQR37CEsegbd2oQiuACbUceWah688ydFVpzwSdsjQcNz7skTpPbbfP2Co5FoD8RfJqs2Tao7pIgXWgmOKZtjLPf3nwK1aYG7NwmuyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0kP97dBev0D3IaTNiO7HeEdFidYC4lDAf6FxT+HgG8=;
 b=erNfLuZqppH9vjSzhcYN3KFBdAp1OvBz+06EgsgSwwOww67wRSJi85hMGFE+9tSfu+TnZmuPUJ4stv5qyIbLh4dflNDkqur8iy05qVwQufZO+v2fqUCVnno3MRQfC20jEfMRZXualYt2MQjC1rKgWQBD8jBAjFaX9IXu5X2zwP975KheOaGWogyEm+dEa5cnHxAz79ChctrWDieiX7PVt+Ed28eiLLjqupgS968xb1LBS+kc8pBWNOCpC0oC46UXjtKcoNJYUXvmttteIQNzcC13079egAZxMxUc7hh/tqwxOfmk1hSPJMTkwbH59GQovoVPJFE1iyqmr9wJU0LQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4631.namprd15.prod.outlook.com (2603:10b6:a03:37c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Sat, 1 May
 2021 02:49:10 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4087.035; Sat, 1 May 2021
 02:49:10 +0000
Date:   Fri, 30 Apr 2021 19:49:06 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH 5/5] tests/cgroup: test cgroup.kill
Message-ID: <YIzBopEtBSfso/WK@carbon.dhcp.thefacebook.com>
References: <20210429120113.2238065-1-brauner@kernel.org>
 <20210429120113.2238065-5-brauner@kernel.org>
 <YIuCDz3h9/ZQPCMV@carbon.dhcp.thefacebook.com>
 <20210430064740.uvradr4mmj4wf2i2@wittgenstein>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210430064740.uvradr4mmj4wf2i2@wittgenstein>
X-Originating-IP: [2620:10d:c090:400::5:ffce]
X-ClientProxiedBy: MW4PR04CA0216.namprd04.prod.outlook.com
 (2603:10b6:303:87::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ffce) by MW4PR04CA0216.namprd04.prod.outlook.com (2603:10b6:303:87::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Sat, 1 May 2021 02:49:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22ba9147-a259-40ca-543b-08d90c4bb222
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4631:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB46314F4A2A26550DA62BFF52BE5D9@SJ0PR15MB4631.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMsEcEBbVx0XU1IseILtYcsUUqt7ki0++FCS6utFB48vh6ZvREjFpiiy/1ekk5iVNwbiLFC9Dc79/AoNEqq9O4fEnju99G4F8QO2TU1XKYcacUXjZ5EGRxNKYXNyc4q7hmCxogcl8/KUneIyxcVT1Xlfj814ZESBP1BfFb/Eq7a9i1Va3yCyy7T9GplTntHg25GRju2gHfiot48OBm+SReYeMy3ZR6+OgfrH93knfL83lirX6jXWGJCN1HaHedKiTrQmILkeQqDOH9Ygz1NjnliRkwjwgOp5BT6LL8nMvd1QDyImke2NR1RtYPHRfPnD8lEZhBMPzORT7vkzYiiXt9i/hfjKD+x0j+NCoOiz2nUJW2Co+cI1iI7wi8x51ryhuexTy2pbpH6jA6BNMPYtUcqGrVtBlr2A97gJxF+uop2Kg/mWc/yU/rLDei3ZbR49TxpOu9kQlJ7Mn+NFXOtHhpq42BhenVxg4kFLytaNNM282uiwm931ScrH99s0k4tw2+t2HrFG7WWBLhRFVdie/TfLfEVAvaLIdEaXQI2ThhYJeTuW+JFk94MRxmQ4uFDugKI2DRefi44n/ZxZ63m1chq3Bz0d6ciy+Ckauqaw7MY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(7696005)(52116002)(6506007)(38100700002)(186003)(16526019)(316002)(54906003)(6916009)(2906002)(86362001)(8676002)(8936002)(66946007)(478600001)(5660300002)(6666004)(9686003)(4326008)(55016002)(66556008)(66574015)(83380400001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bkmjTE6KfsWpsCgIcqALPQIN69T2phHTTo4M8gOyEz23o0Wi7GwZp0tnjcsx?=
 =?us-ascii?Q?V8sdYVfG6yStZxyBZAUHCGnZ059G1GqT/qZ+YyBk97/aM+/9pBv4ZMlBJ5gf?=
 =?us-ascii?Q?UxeR7QJuPTmOc6BlIVPE/hl4c4pZhZ2dcOcFHddg53XV0+l/lJeQ5hdbmz/d?=
 =?us-ascii?Q?JS51EDuOJX4Z4BPprUltbAhoLe50i5HcP429IqbnBmkBge2RYXU7Vgc8L9it?=
 =?us-ascii?Q?KbECtbINCy9n9+ZPHvaYu5eCWj7sQVo6UR3qzpQPQAJcdJLEMUbGs7rWx/41?=
 =?us-ascii?Q?5bXMuQrlUdk17WhHHv6/ryvc+muuy1zwawMMlFgy3VDMR5OlJ3YQgRnNcBZA?=
 =?us-ascii?Q?ux/Aq+j8KSc9q12Bd03GlXb79ObulwrPyP4TVeASlBYM18haTWdbZaXk6GGm?=
 =?us-ascii?Q?9QUqITQu0NRd7yF0G0FSxA5De6hIkXvaQGD2OiZQCMnM+3tsmfpBptjHgTNw?=
 =?us-ascii?Q?1oQyhILsiY2kmlvuVJsCdybqk9etG8rTya5oM2Y0ITYCAGX+v2OpOLy6DUY4?=
 =?us-ascii?Q?1D8W1Ybf3SwsrKBrpUAnjh6M+MYhyMOMvaAoWRxy+EDsm9fQYkKqIkdZb48a?=
 =?us-ascii?Q?27Y/DbbwaHPnbEA3JN307oyMcbfrCGxz4FGYa/UT6frx2OuxL3IMQNSJyHQO?=
 =?us-ascii?Q?mibqHmOL3HlDhJQNwde+dRb2R2jZju+IEv+6w4TONJweNQkQSk0D2p4BcrTs?=
 =?us-ascii?Q?rk6pgtg4jeifIIqsK08BDIZhRwT10CT5wtnKqgHFQHWUVkXwxOVj3M6wngIV?=
 =?us-ascii?Q?zohJMKJDVFFUN9rA0c6eWjQ2k5yA/xwMOuxnFut24q4EiLpF70shgLjct6dt?=
 =?us-ascii?Q?wJDBQkeXi6Iv6gxCUNjyNZEP/s/asn4FhixrXwdVnqtODXMBZ5jalcNDtf3Z?=
 =?us-ascii?Q?J+usYWc7fR7EdDNVxgvPDFX9PvCxQtuOgQF84hlNvKaBAKEDRHU6bo80yJRp?=
 =?us-ascii?Q?n3eJru0tg6jtPXsA7PUdsml3iEZNW0Ag5CKUG2f8P/NQhWpWTAJOz6xXymcB?=
 =?us-ascii?Q?Ip3DnTUi0cx6hNmPZDUQxzhYJD1d20Oi/bm3Cix9abdNZTFIINxa5qC6jCCl?=
 =?us-ascii?Q?RXsqgcA6NLeDLjF5DDlePN8FkQQ8cxO/+9ApiXd1T4/2nXsMyVV0eWghZYui?=
 =?us-ascii?Q?M8c9293W5mkx7bJiCPiiWd31tPTgY+JnQBD3dIpDYCZ0vbdWPl5eZjwIt9FD?=
 =?us-ascii?Q?+pNC9SdbcU8AbjSDkCtArTihmS/1JXBbL5ypOZcsyEKlXlYH6a8q0xiomLiu?=
 =?us-ascii?Q?0ZDADm3apqR1h1IY5eZnyv/+FA2+SxvwzYL8KRePewIL7+LkOocbJ2D7dJWQ?=
 =?us-ascii?Q?sXA02IUfRFLDRyQklT74SZ66rnVtwokuIqM4juQ5EFS9EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ba9147-a259-40ca-543b-08d90c4bb222
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2021 02:49:10.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4gJOpP13IjruPnAx3kZLBsy2+tacGVQb44PV+HqfXZc8Xdd5iLHuAx8h49l4YHS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4631
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Gk8F9T5hGgHqzLzpOhbdTScg55Lyl-yO
X-Proofpoint-GUID: Gk8F9T5hGgHqzLzpOhbdTScg55Lyl-yO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-01_02:2021-04-30,2021-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105010018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 30, 2021 at 08:47:40AM +0200, Christian Brauner wrote:
> On Thu, Apr 29, 2021 at 09:05:35PM -0700, Roman Gushchin wrote:
> > On Thu, Apr 29, 2021 at 02:01:13PM +0200, Christian Brauner wrote:
> > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > 
> > > Test that the new cgroup.kill feature works as intended.
> > > 
> > > Cc: Roman Gushchin <guro@fb.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: cgroups@vger.kernel.org
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > ---
> > >  tools/testing/selftests/cgroup/.gitignore  |   3 +-
> > >  tools/testing/selftests/cgroup/Makefile    |   2 +
> > >  tools/testing/selftests/cgroup/test_kill.c | 293 +++++++++++++++++++++
> > >  3 files changed, 297 insertions(+), 1 deletion(-)
> > >  create mode 100644 tools/testing/selftests/cgroup/test_kill.c
> > > 
> > > diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
> > > index 84cfcabea838..be9643ef6285 100644
> > > --- a/tools/testing/selftests/cgroup/.gitignore
> > > +++ b/tools/testing/selftests/cgroup/.gitignore
> > > @@ -2,4 +2,5 @@
> > >  test_memcontrol
> > >  test_core
> > >  test_freezer
> > > -test_kmem
> > > \ No newline at end of file
> > > +test_kmem
> > > +test_kill
> > > diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
> > > index f027d933595b..87b7b0d90773 100644
> > > --- a/tools/testing/selftests/cgroup/Makefile
> > > +++ b/tools/testing/selftests/cgroup/Makefile
> > > @@ -9,6 +9,7 @@ TEST_GEN_PROGS = test_memcontrol
> > >  TEST_GEN_PROGS += test_kmem
> > >  TEST_GEN_PROGS += test_core
> > >  TEST_GEN_PROGS += test_freezer
> > > +TEST_GEN_PROGS += test_kill
> > >  
> > >  include ../lib.mk
> > >  
> > > @@ -16,3 +17,4 @@ $(OUTPUT)/test_memcontrol: cgroup_util.c ../clone3/clone3_selftests.h
> > >  $(OUTPUT)/test_kmem: cgroup_util.c ../clone3/clone3_selftests.h
> > >  $(OUTPUT)/test_core: cgroup_util.c ../clone3/clone3_selftests.h
> > >  $(OUTPUT)/test_freezer: cgroup_util.c ../clone3/clone3_selftests.h
> > > +$(OUTPUT)/test_kill: cgroup_util.c ../clone3/clone3_selftests.h
> > > diff --git a/tools/testing/selftests/cgroup/test_kill.c b/tools/testing/selftests/cgroup/test_kill.c
> > > new file mode 100644
> > > index 000000000000..c4e7b2e87395
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/cgroup/test_kill.c
> > > @@ -0,0 +1,293 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#include <stdbool.h>
> > > +#include <linux/limits.h>
> > > +#include <sys/ptrace.h>
> > > +#include <sys/types.h>
> > > +#include <sys/mman.h>
> > > +#include <unistd.h>
> > > +#include <stdio.h>
> > > +#include <errno.h>
> > > +#include <poll.h>
> > > +#include <stdlib.h>
> > > +#include <sys/inotify.h>
> > > +#include <string.h>
> > > +#include <sys/wait.h>
> > > +
> > > +#include "../kselftest.h"
> > > +#include "cgroup_util.h"
> > > +
> > > +#define DEBUG
> > > +#ifdef DEBUG
> > > +#define debug(args...) fprintf(stderr, args)
> > > +#else
> > > +#define debug(args...)
> > > +#endif
> > > +
> > > +/*
> > > + * Kill the given cgroup and wait for the inotify signal.
> > > + * If there are no events in 10 seconds, treat this as an error.
> > > + * Then check that the cgroup is in the desired state.
> > > + */
> > > +static int cg_kill_wait(const char *cgroup)
> > > +{
> > > +	int fd, ret = -1;
> > > +
> > > +	fd = cg_prepare_for_wait(cgroup);
> > > +	if (fd < 0)
> > > +		return fd;
> > > +
> > > +	ret = cg_write(cgroup, "cgroup.kill", "1");
> > > +	if (ret) {
> > > +		debug("Error: cg_write() failed\n");
> > > +		goto out;
> > > +	}
> > > +
> > > +	ret = cg_wait_for(fd);
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	ret = cg_read_strcmp(cgroup, "cgroup.events", "populated 0\n");
> > > +out:
> > > +	close(fd);
> > > +	return ret;
> > > +}
> > > +
> > > +/*
> > > + * A simple process running in a sleep loop until being
> > > + * re-parented.
> > > + */
> > > +static int child_fn(const char *cgroup, void *arg)
> > > +{
> > > +	int ppid = getppid();
> > > +
> > > +	while (getppid() == ppid)
> > > +		usleep(1000);
> > > +
> > > +	return getppid() == ppid;
> > > +}
> > > +
> > > +static int test_cgkill_simple(const char *root)
> > > +{
> > > +	int ret = KSFT_FAIL;
> > > +	char *cgroup = NULL;
> > > +	int i;
> > > +
> > > +	cgroup = cg_name(root, "cg_test_simple");
> > > +	if (!cgroup)
> > > +		goto cleanup;
> > > +
> > > +	if (cg_create(cgroup))
> > > +		goto cleanup;
> > > +
> > > +	for (i = 0; i < 100; i++)
> > > +		cg_run_nowait(cgroup, child_fn, NULL);
> > > +
> > > +	if (cg_wait_for_proc_count(cgroup, 100))
> > > +		goto cleanup;
> > > +
> > > +        if (cg_write(cgroup, "cgroup.kill", "1"))
> > > +		goto cleanup;
> > > +
> > > +	if (cg_read_strcmp(cgroup, "cgroup.events", "populated 1\n"))
> > > +		goto cleanup;
> > > +
> > > +	if (cg_kill_wait(cgroup))
> > > +		goto cleanup;
> > > +
> > > +	if (cg_read_strcmp(cgroup, "cgroup.events", "populated 0\n"))
> > > +		goto cleanup;
> > > +
> > > +	ret = KSFT_PASS;
> > > +
> > > +cleanup:
> > > +	if (cgroup)
> > > +		cg_destroy(cgroup);
> > > +	free(cgroup);
> > > +	return ret;
> > > +}
> > > +
> > > +/*
> > > + * The test creates the following hierarchy:
> > > + *       A
> > > + *    / / \ \
> > > + *   B  E  I K
> > > + *  /\  |
> > > + * C  D F
> > > + *      |
> > > + *      G
> > > + *      |
> > > + *      H
> > > + *
> > > + * with a process in C, H and 3 processes in K.
> > > + * Then it tries to kill the whole tree.
> > > + */
> > > +static int test_cgkill_tree(const char *root)
> > > +{
> > > +	char *cgroup[10] = {0};
> > > +	int ret = KSFT_FAIL;
> > > +	int i;
> > > +
> > > +	cgroup[0] = cg_name(root, "cg_test_tree_A");
> > > +	if (!cgroup[0])
> > > +		goto cleanup;
> > > +
> > > +	cgroup[1] = cg_name(cgroup[0], "B");
> > > +	if (!cgroup[1])
> > > +		goto cleanup;
> > > +
> > > +	cgroup[2] = cg_name(cgroup[1], "C");
> > > +	if (!cgroup[2])
> > > +		goto cleanup;
> > > +
> > > +	cgroup[3] = cg_name(cgroup[1], "D");
> > > +	if (!cgroup[3])
> > > +		goto cleanup;
> > > +
> > > +	cgroup[4] = cg_name(cgroup[0], "E");
> > > +	if (!cgroup[4])
> > > +		goto cleanup;
> > > +
> > > +	cgroup[5] = cg_name(cgroup[4], "F");
> > > +	if (!cgroup[5])
> > > +		goto cleanup;
> > > +
> > > +	cgroup[6] = cg_name(cgroup[5], "G");
> > > +	if (!cgroup[6])
> > > +		goto cleanup;
> > > +
> > > +	cgroup[7] = cg_name(cgroup[6], "H");
> > > +	if (!cgroup[7])
> > > +		goto cleanup;
> > > +
> > > +	cgroup[8] = cg_name(cgroup[0], "I");
> > > +	if (!cgroup[8])
> > > +		goto cleanup;
> > > +
> > > +	cgroup[9] = cg_name(cgroup[0], "K");
> > > +	if (!cgroup[9])
> > > +		goto cleanup;
> > > +
> > > +	for (i = 0; i < 10; i++)
> > > +		if (cg_create(cgroup[i]))
> > > +			goto cleanup;
> > > +
> > > +	cg_run_nowait(cgroup[2], child_fn, NULL);
> > > +	cg_run_nowait(cgroup[7], child_fn, NULL);
> > > +	cg_run_nowait(cgroup[9], child_fn, NULL);
> > > +	cg_run_nowait(cgroup[9], child_fn, NULL);
> > > +	cg_run_nowait(cgroup[9], child_fn, NULL);
> > > +
> > > +	/*
> > > +	 * Wait until all child processes will enter
> > > +	 * corresponding cgroups.
> > > +	 */
> > > +
> > > +	if (cg_wait_for_proc_count(cgroup[2], 1) ||
> > > +	    cg_wait_for_proc_count(cgroup[7], 1) ||
> > > +	    cg_wait_for_proc_count(cgroup[9], 3))
> > > +		goto cleanup;
> > > +
> > > +	/*
> > > +	 * Kill A and check that we get an empty notification.
> > > +	 */
> > > +	if (cg_kill_wait(cgroup[0]))
> > > +		goto cleanup;
> > > +
> > > +	if (cg_read_strcmp(cgroup[0], "cgroup.events", "populated 0\n"))
> > > +		goto cleanup;
> > > +
> > > +	ret = KSFT_PASS;
> > > +
> > > +cleanup:
> > > +	for (i = 9; i >= 0 && cgroup[i]; i--) {
> > > +		cg_destroy(cgroup[i]);
> > > +		free(cgroup[i]);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int forkbomb_fn(const char *cgroup, void *arg)
> > > +{
> > > +	int ppid;
> > > +
> > > +	fork();
> > > +	fork();
> > > +
> > > +	ppid = getppid();
> > > +
> > > +	while (getppid() == ppid)
> > > +		usleep(1000);
> > > +
> > > +	return getppid() == ppid;
> > > +}
> > > +
> > > +/*
> > > + * The test runs a fork bomb in a cgroup and tries to kill it.
> > > + */
> > > +static int test_cgkill_forkbomb(const char *root)
> > > +{
> > > +	int ret = KSFT_FAIL;
> > > +	char *cgroup = NULL;
> > > +
> > > +	cgroup = cg_name(root, "cg_forkbomb_test");
> > > +	if (!cgroup)
> > > +		goto cleanup;
> > > +
> > > +	if (cg_create(cgroup))
> > > +		goto cleanup;
> > > +
> > > +	cg_run_nowait(cgroup, forkbomb_fn, NULL);
> > > +
> > > +	usleep(100000);
> > > +
> > > +	if (cg_kill_wait(cgroup))
> > > +		goto cleanup;
> > > +
> > > +	if (cg_wait_for_proc_count(cgroup, 0))
> > > +		goto cleanup;
> > > +
> > > +	ret = KSFT_PASS;
> > > +
> > > +cleanup:
> > > +	if (cgroup)
> > > +		cg_destroy(cgroup);
> > > +	free(cgroup);
> > > +	return ret;
> > > +}
> > > +
> > > +#define T(x) { x, #x }
> > > +struct cgkill_test {
> > > +	int (*fn)(const char *root);
> > > +	const char *name;
> > > +} tests[] = {
> > > +	T(test_cgkill_simple),
> > > +	T(test_cgkill_tree),
> > > +	T(test_cgkill_forkbomb),
> > 
> > I'm a little bit worried about the forkbomb test: how reliable it is and won't
> > it kill the system, but Idk how make it better. Maybe instead of a true fork
> > bomb we need to spawn children by a single process? I'm not exactly sure.
> 
> I had the tests run in tight a loop and it didn't take down the system.
> The cgroup was nicely killed everytime which is why I kept it. Freezer
> performs the same test. So what we could do is freeze first and then
> kill under the assumption that the freezer tests don't suffer from the
> same problem.

Ok, I'm fine with it.
Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
