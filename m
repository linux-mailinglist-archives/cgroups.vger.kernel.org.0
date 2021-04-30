Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75D036F4C5
	for <lists+cgroups@lfdr.de>; Fri, 30 Apr 2021 06:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhD3EGk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Apr 2021 00:06:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63292 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhD3EGj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Apr 2021 00:06:39 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13U44R8Q000741;
        Thu, 29 Apr 2021 21:05:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=X663s2OtcAp3Dk2qRZN17wfTZSt1hP0N7LpNVQVZmkc=;
 b=RFKMan1IV+ImrfIUEZc65UmXFrJ1hS5mjDUNdkUyEqU3DIh2RuLoO+ItmrWNVdFqMuG4
 5sZV7EplB25HDOUsr3riCLgiiQ9/vXtW9YiJOfiwU9qA2qa1p7QXOfO68F5tTHWBLiiN
 ppDUkAl7lGhOpER8t/zcKBbSBU1mzh/y67Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3882hct9pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 21:05:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 21:05:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEiD4R3XZsqqkr4NjuR4/J2eas+dJFtIW2FjAE20sR6TF26+dHcVMsUmzDT56Fn9ARyb431XUA2D4Mxc47S8rwDS0quvBL2zXfmx7dsJu3Fv6N7F3jhpTwbBGjun8SUju3/NdDFP+BoBExXrnJyF+n7p+sje0DhY9rNFEfxVsqVY8m3frjqIXVrTePVIYXeC3l/GgeOiBzAuMYAH7EOQY/fsgQCbL1/VssvEmocMqtwLR/7XRG3k1EUcv7V6qtJ+DVQpZKTli6fOXRcL2+8RKvOtLn5Pw4FyoZlTawKdXQhGYkF9sy45eSZCZAM/Dkyndyx7v9NZ0tit5ZTzgQi77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X663s2OtcAp3Dk2qRZN17wfTZSt1hP0N7LpNVQVZmkc=;
 b=UNmvgnTQ12yKNKh55fSFu9PDPYIY5zEauiw2lu/OxVcXdYns7XFg9J2QPjkdM5rCgEVFPZU3fu4LcK7Fw/03IBel5KYLjLBNHMKP814ZLPz0Hab6uZ59L2cz0K4MA97fU4u3CIS50u+2onBgDnrV/wmPg1Gk/i46+hxzALYcuTjhWef05mJDnam1fuVjuCAgIc3WrV2L3G+B06ZfU7AEtgO3menYedmth7cL3FfvPYimdPwK0x/Y2dH1wrmcgKniWdOEjlrN9upTVN2H//f8BasZoMtXIwr17H7v1RYZuNmrA6tosdKk14SHHCsQIIsIn6qsmXRdWhmhT2Akd3WaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4134.namprd15.prod.outlook.com (2603:10b6:a03:9a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Fri, 30 Apr
 2021 04:05:40 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 04:05:40 +0000
Date:   Thu, 29 Apr 2021 21:05:35 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 5/5] tests/cgroup: test cgroup.kill
Message-ID: <YIuCDz3h9/ZQPCMV@carbon.dhcp.thefacebook.com>
References: <20210429120113.2238065-1-brauner@kernel.org>
 <20210429120113.2238065-5-brauner@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210429120113.2238065-5-brauner@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:abbd]
X-ClientProxiedBy: CO2PR07CA0060.namprd07.prod.outlook.com (2603:10b6:100::28)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:abbd) by CO2PR07CA0060.namprd07.prod.outlook.com (2603:10b6:100::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 04:05:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e563aa73-a734-42b7-8007-08d90b8d375d
X-MS-TrafficTypeDiagnostic: BYAPR15MB4134:
X-Microsoft-Antispam-PRVS: <BYAPR15MB41344E7DABD68EE7F38A5DD4BE5E9@BYAPR15MB4134.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+9V1Y94MRjnBYk9jbziZKBno9jUjpwLh6gKbLLUm5rSyzfjwhEULHtvss3KqflI1mkEMVXXTGpIzVh9IW88sclTxCpsEXdgvTMOJp8S8R2HWMIC8X2lqGbIuA2v7mDmt69c19B1a9/jsdV5KS56+wMetXhUu/z2gyTYjRCdTYlR/lKW5O9e+BYLtsBwvuULV4sjqWlOxX/pN0jrskGyQOvEVcI8siG+47NWQF+2/4uZt5chvv7zQZznRezWavni2QqOIeMqeyeHkxtK4mI3uJ7MGkvEfSwjo1DCwO6qzOVyyBwqDn38mqqWA1JXzS0UECJcPiIS6LOkAMfTnXfomOpswkt8v3djtfFQS0l1OyHzZykhGf1mVHyPPo53Wr0F/ynrTCsNlMXJKskegmNfWoTejirfK/t08yyjpCZmuqn7j9qM/7zKQ7UArefv6SGP8CoupeIDt47nmvnkrhF/ett8dt43crEkTYp6za9BMjR6f4r4KPgnniWySApI1atrbaxH0z6Dy5SuE9iBqFFBs0DS60iwEyGfTYb6Fhjy3i6rPSxW/p+m8QzIjpWbg6iZ3HehqqT7YQKtRTfcvaS9SW7JR/Emd2KQ6FjyNrQboiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(8676002)(5660300002)(186003)(16526019)(86362001)(478600001)(55016002)(9686003)(4326008)(6666004)(38100700002)(316002)(83380400001)(52116002)(7696005)(6506007)(54906003)(6916009)(66574015)(8936002)(66476007)(66556008)(2906002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Z1ETOfoGdxCHkU+fEysR1g4QxerU6xBVYHO2aUFEX+CPfqt3R/NA6ppNCfNp?=
 =?us-ascii?Q?/47zlUUQvH4GuA43l6u0DlmsidpYANWjPePF1vZ9xhPhGKitSOVIXd5ptHzo?=
 =?us-ascii?Q?5ad+lto2ovYBinQi7ImO1AI7HL0jAueOj2GbjsPZSoTpc7GK2+GO00fi0Dlq?=
 =?us-ascii?Q?6tw7lfx9EZw8/y6usc70xEpSkwFtgIu5184lOoKdthRotFB1RI38+RLYCp6D?=
 =?us-ascii?Q?0ImbItNmM2+oEcvpSTS6f/QKaSr1bD1GjKJxxPmr4rcQM3YbWxE2vj+Kujcb?=
 =?us-ascii?Q?x9h8xCywabXvUJOIga8lO1YGVrqubFbIilt4hAlRhA48hLejK9MOfrirhq5B?=
 =?us-ascii?Q?MRT+XlHpAkrlJ1EmJApdxlygDKr3cLyy422ra1mOMp7QL25/ozU63JBR3YLw?=
 =?us-ascii?Q?Rle6BYD2rn8GuI+owup1mJFrPlDhWli5H9vuEPxfqMy0cF9i8CAJHJnxxeBV?=
 =?us-ascii?Q?EFQ5Uj7jmEKL6j9/AyJPpilLrkxOrQmBYOQ5VPH8CMFOyqvCuqyrAjPrJY2W?=
 =?us-ascii?Q?gLaD+2hjtQiwlQ1VxgGsDt2bi+P93pjqdpf6BuHG60wl5qI59Yd9D8iOE+Du?=
 =?us-ascii?Q?vjK4aTjY0W/lzthkXyIz0PDZEoWGZ7WiXAI8JshgRuIV9iO8OS3iDyVcctSU?=
 =?us-ascii?Q?LMnuPrD3Hl8kV01FyaZZ7lvSQh4gCECnmI2c9lE/i5PHY9LiePXa8bol1JQL?=
 =?us-ascii?Q?A3nNyTRflAMgu42cCE5J/w5qzovbXd70AWO4aH61xj5PZm8gXJD09nfGRF58?=
 =?us-ascii?Q?9rhtomH3ZWBBydw1dG0b36DmuNu3CSxo9evSFOYB1wEWfKcgUqvQY93NAo5d?=
 =?us-ascii?Q?cPWT6mDGNceG+M80LJ0ZIm9/6bEX55K2nD0au+AlyFRihYEf9oSYfr10JUkQ?=
 =?us-ascii?Q?M0YFodLdxoynkanX6wxAnf/kXQqxXpGUt57ymSwYi2pTT6VqO2wgNOP5Cl3J?=
 =?us-ascii?Q?KlLyembZw4v2BPyNRA+ZZgNU64ZAk1MBqDqTo//X7ElTAVgPXDLmWBXsyFpy?=
 =?us-ascii?Q?RJMM5JO5EPK11baooT1LmmNVZNKA1354LDbjJAjbg6c75WzwN74rPSSVibro?=
 =?us-ascii?Q?KVovwqJwFUpXI3QRDNdfSN2FJ0UbCUYZCgol/zO7fmD5hqI9SYAztRnD3ZLg?=
 =?us-ascii?Q?MUlqZJAq8AXKOQQ4M1S0moDse7ID/bbaDaCV6dvVwcJSMMy6CDZZcCxWvo4j?=
 =?us-ascii?Q?PoLcJhAZ/MRI/x5upyTRbNbT53kR5s/PFtuabX9K07HS+F/qVVX1udfIFJyj?=
 =?us-ascii?Q?HctZdApQgQVHEy7YxHSDSGZeTDXQ0PcQb17AOXRaQSnBpamavHi3eiSmAA/O?=
 =?us-ascii?Q?iF7Boc2jp0z7AyVRyvq1ihwCGK/JuxXjRBXjm5emCMCRUQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e563aa73-a734-42b7-8007-08d90b8d375d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 04:05:39.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHzxIOaHBduYedCcrkUd+LoacyDKjNK1dNXAxciR85/XiCU97NHtYOBln4MJSTz9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4134
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 9vySc12PNVOQWOTvuL6LovS_Og5iG-9g
X-Proofpoint-ORIG-GUID: 9vySc12PNVOQWOTvuL6LovS_Og5iG-9g
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_02:2021-04-28,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 29, 2021 at 02:01:13PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Test that the new cgroup.kill feature works as intended.
> 
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: cgroups@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  tools/testing/selftests/cgroup/.gitignore  |   3 +-
>  tools/testing/selftests/cgroup/Makefile    |   2 +
>  tools/testing/selftests/cgroup/test_kill.c | 293 +++++++++++++++++++++
>  3 files changed, 297 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/cgroup/test_kill.c
> 
> diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
> index 84cfcabea838..be9643ef6285 100644
> --- a/tools/testing/selftests/cgroup/.gitignore
> +++ b/tools/testing/selftests/cgroup/.gitignore
> @@ -2,4 +2,5 @@
>  test_memcontrol
>  test_core
>  test_freezer
> -test_kmem
> \ No newline at end of file
> +test_kmem
> +test_kill
> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
> index f027d933595b..87b7b0d90773 100644
> --- a/tools/testing/selftests/cgroup/Makefile
> +++ b/tools/testing/selftests/cgroup/Makefile
> @@ -9,6 +9,7 @@ TEST_GEN_PROGS = test_memcontrol
>  TEST_GEN_PROGS += test_kmem
>  TEST_GEN_PROGS += test_core
>  TEST_GEN_PROGS += test_freezer
> +TEST_GEN_PROGS += test_kill
>  
>  include ../lib.mk
>  
> @@ -16,3 +17,4 @@ $(OUTPUT)/test_memcontrol: cgroup_util.c ../clone3/clone3_selftests.h
>  $(OUTPUT)/test_kmem: cgroup_util.c ../clone3/clone3_selftests.h
>  $(OUTPUT)/test_core: cgroup_util.c ../clone3/clone3_selftests.h
>  $(OUTPUT)/test_freezer: cgroup_util.c ../clone3/clone3_selftests.h
> +$(OUTPUT)/test_kill: cgroup_util.c ../clone3/clone3_selftests.h
> diff --git a/tools/testing/selftests/cgroup/test_kill.c b/tools/testing/selftests/cgroup/test_kill.c
> new file mode 100644
> index 000000000000..c4e7b2e87395
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/test_kill.c
> @@ -0,0 +1,293 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <stdbool.h>
> +#include <linux/limits.h>
> +#include <sys/ptrace.h>
> +#include <sys/types.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <poll.h>
> +#include <stdlib.h>
> +#include <sys/inotify.h>
> +#include <string.h>
> +#include <sys/wait.h>
> +
> +#include "../kselftest.h"
> +#include "cgroup_util.h"
> +
> +#define DEBUG
> +#ifdef DEBUG
> +#define debug(args...) fprintf(stderr, args)
> +#else
> +#define debug(args...)
> +#endif
> +
> +/*
> + * Kill the given cgroup and wait for the inotify signal.
> + * If there are no events in 10 seconds, treat this as an error.
> + * Then check that the cgroup is in the desired state.
> + */
> +static int cg_kill_wait(const char *cgroup)
> +{
> +	int fd, ret = -1;
> +
> +	fd = cg_prepare_for_wait(cgroup);
> +	if (fd < 0)
> +		return fd;
> +
> +	ret = cg_write(cgroup, "cgroup.kill", "1");
> +	if (ret) {
> +		debug("Error: cg_write() failed\n");
> +		goto out;
> +	}
> +
> +	ret = cg_wait_for(fd);
> +	if (ret)
> +		goto out;
> +
> +	ret = cg_read_strcmp(cgroup, "cgroup.events", "populated 0\n");
> +out:
> +	close(fd);
> +	return ret;
> +}
> +
> +/*
> + * A simple process running in a sleep loop until being
> + * re-parented.
> + */
> +static int child_fn(const char *cgroup, void *arg)
> +{
> +	int ppid = getppid();
> +
> +	while (getppid() == ppid)
> +		usleep(1000);
> +
> +	return getppid() == ppid;
> +}
> +
> +static int test_cgkill_simple(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *cgroup = NULL;
> +	int i;
> +
> +	cgroup = cg_name(root, "cg_test_simple");
> +	if (!cgroup)
> +		goto cleanup;
> +
> +	if (cg_create(cgroup))
> +		goto cleanup;
> +
> +	for (i = 0; i < 100; i++)
> +		cg_run_nowait(cgroup, child_fn, NULL);
> +
> +	if (cg_wait_for_proc_count(cgroup, 100))
> +		goto cleanup;
> +
> +        if (cg_write(cgroup, "cgroup.kill", "1"))
> +		goto cleanup;
> +
> +	if (cg_read_strcmp(cgroup, "cgroup.events", "populated 1\n"))
> +		goto cleanup;
> +
> +	if (cg_kill_wait(cgroup))
> +		goto cleanup;
> +
> +	if (cg_read_strcmp(cgroup, "cgroup.events", "populated 0\n"))
> +		goto cleanup;
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	if (cgroup)
> +		cg_destroy(cgroup);
> +	free(cgroup);
> +	return ret;
> +}
> +
> +/*
> + * The test creates the following hierarchy:
> + *       A
> + *    / / \ \
> + *   B  E  I K
> + *  /\  |
> + * C  D F
> + *      |
> + *      G
> + *      |
> + *      H
> + *
> + * with a process in C, H and 3 processes in K.
> + * Then it tries to kill the whole tree.
> + */
> +static int test_cgkill_tree(const char *root)
> +{
> +	char *cgroup[10] = {0};
> +	int ret = KSFT_FAIL;
> +	int i;
> +
> +	cgroup[0] = cg_name(root, "cg_test_tree_A");
> +	if (!cgroup[0])
> +		goto cleanup;
> +
> +	cgroup[1] = cg_name(cgroup[0], "B");
> +	if (!cgroup[1])
> +		goto cleanup;
> +
> +	cgroup[2] = cg_name(cgroup[1], "C");
> +	if (!cgroup[2])
> +		goto cleanup;
> +
> +	cgroup[3] = cg_name(cgroup[1], "D");
> +	if (!cgroup[3])
> +		goto cleanup;
> +
> +	cgroup[4] = cg_name(cgroup[0], "E");
> +	if (!cgroup[4])
> +		goto cleanup;
> +
> +	cgroup[5] = cg_name(cgroup[4], "F");
> +	if (!cgroup[5])
> +		goto cleanup;
> +
> +	cgroup[6] = cg_name(cgroup[5], "G");
> +	if (!cgroup[6])
> +		goto cleanup;
> +
> +	cgroup[7] = cg_name(cgroup[6], "H");
> +	if (!cgroup[7])
> +		goto cleanup;
> +
> +	cgroup[8] = cg_name(cgroup[0], "I");
> +	if (!cgroup[8])
> +		goto cleanup;
> +
> +	cgroup[9] = cg_name(cgroup[0], "K");
> +	if (!cgroup[9])
> +		goto cleanup;
> +
> +	for (i = 0; i < 10; i++)
> +		if (cg_create(cgroup[i]))
> +			goto cleanup;
> +
> +	cg_run_nowait(cgroup[2], child_fn, NULL);
> +	cg_run_nowait(cgroup[7], child_fn, NULL);
> +	cg_run_nowait(cgroup[9], child_fn, NULL);
> +	cg_run_nowait(cgroup[9], child_fn, NULL);
> +	cg_run_nowait(cgroup[9], child_fn, NULL);
> +
> +	/*
> +	 * Wait until all child processes will enter
> +	 * corresponding cgroups.
> +	 */
> +
> +	if (cg_wait_for_proc_count(cgroup[2], 1) ||
> +	    cg_wait_for_proc_count(cgroup[7], 1) ||
> +	    cg_wait_for_proc_count(cgroup[9], 3))
> +		goto cleanup;
> +
> +	/*
> +	 * Kill A and check that we get an empty notification.
> +	 */
> +	if (cg_kill_wait(cgroup[0]))
> +		goto cleanup;
> +
> +	if (cg_read_strcmp(cgroup[0], "cgroup.events", "populated 0\n"))
> +		goto cleanup;
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	for (i = 9; i >= 0 && cgroup[i]; i--) {
> +		cg_destroy(cgroup[i]);
> +		free(cgroup[i]);
> +	}
> +
> +	return ret;
> +}
> +
> +static int forkbomb_fn(const char *cgroup, void *arg)
> +{
> +	int ppid;
> +
> +	fork();
> +	fork();
> +
> +	ppid = getppid();
> +
> +	while (getppid() == ppid)
> +		usleep(1000);
> +
> +	return getppid() == ppid;
> +}
> +
> +/*
> + * The test runs a fork bomb in a cgroup and tries to kill it.
> + */
> +static int test_cgkill_forkbomb(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *cgroup = NULL;
> +
> +	cgroup = cg_name(root, "cg_forkbomb_test");
> +	if (!cgroup)
> +		goto cleanup;
> +
> +	if (cg_create(cgroup))
> +		goto cleanup;
> +
> +	cg_run_nowait(cgroup, forkbomb_fn, NULL);
> +
> +	usleep(100000);
> +
> +	if (cg_kill_wait(cgroup))
> +		goto cleanup;
> +
> +	if (cg_wait_for_proc_count(cgroup, 0))
> +		goto cleanup;
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	if (cgroup)
> +		cg_destroy(cgroup);
> +	free(cgroup);
> +	return ret;
> +}
> +
> +#define T(x) { x, #x }
> +struct cgkill_test {
> +	int (*fn)(const char *root);
> +	const char *name;
> +} tests[] = {
> +	T(test_cgkill_simple),
> +	T(test_cgkill_tree),
> +	T(test_cgkill_forkbomb),

I'm a little bit worried about the forkbomb test: how reliable it is and won't
it kill the system, but Idk how make it better. Maybe instead of a true fork
bomb we need to spawn children by a single process? I'm not exactly sure.

Other than that the patch looks good to me.

And thank you for writing tests!

Roman
