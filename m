Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21822ACE40
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 05:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbgKJEIA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Nov 2020 23:08:00 -0500
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:63329
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731962AbgKJEH6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 9 Nov 2020 23:07:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0YzYFtopKvVS4FFqBqdEyLCMHZtZ+131jNTPS0Y7rugd/mphlupAM1oN0fNrACdpuK9Bqz9ehTU8/BwuKb3eA5RWGt3FSRy0SBC47S4oip5wHKCrBO0qqHju44V74wdQpFfuKkOcq1+HhrZ7clkXa6pfbguN7lTzg7Y77PoZ+FftDF7lUckrIXTCfYuJdsHFxbHU0aw/ih5+MFlpbl+H4uqAU+6JiQk54g9kLYSQqeV+1/9/0S3NlnwZqOTv+caGk/aoxab9eISoneQQ4gcKIFMy2QPCl2/IOCIyWHsM+HM37TJ74Hi59AStC0NzCOiTnvn7XnzzVlgDAG9F3i32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgapYnIfV3plaWKhCs5Aau4vM3VRHr0rL1XiKWUc4Z4=;
 b=VfmrPX2kmFOpY17yNBM+5EFUTIMWmNyxOK3fqhEhp5t2BBLUl4Gkm1GH+IlGnG+CZiL9F/PgP4fqQBrifX2iCflDGFSzOMEC7e9nq/dIEWU30f3sLAksb+ZSKL2aHZu5Sqa9HLN1l313u4GrMhbJHuNN5SbITtZWthvIpWN873CLYn23K1RP0Rp86pDsPdLcQ4wvevVO/P1foly+/oJzC8EOAeIgP3bBqJN7gDMvfpg1rf8NN0PZkMBxoiVPGX5rttsdIMnC8QNZ5bEFBrj2Knw+zxGYpEtw9/rk97nVmDDH+bH/mtCvr0pxKgMqSO+yo3qv9g2PALC9yOvC7Vq2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgapYnIfV3plaWKhCs5Aau4vM3VRHr0rL1XiKWUc4Z4=;
 b=CAR8j8uyGJF0qflE/IR+R/UfGXDEqiuqxqDbZH8ZEnLNpphWfWH51OhxMCa+DpEcMJlIdzx4qZZx/eVnVGFt1LfwoScUVBkYsfcjXX6l9In1gL+UogzhZVyBKLbSmrVlyMK4r1rr4qdS0CEUWs34N+PJY5yqd3Vlb6LyLtb4U5o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4489.namprd11.prod.outlook.com (2603:10b6:5:203::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Tue, 10 Nov
 2020 04:07:55 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 04:07:55 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org, rdunlap@infradead.org,
        colin.king@canonical.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Li Zefan <lizefan@huawei.com>
Subject: [PATCH v2 0/4] support for global CPU list abbreviations
Date:   Mon,  9 Nov 2020 23:07:21 -0500
Message-Id: <20201110040725.1478297-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::15) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from t5610.wrs.com (128.224.252.2) by YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 04:07:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7737f54-e6f6-4d77-51c2-08d8852e337f
X-MS-TrafficTypeDiagnostic: DM6PR11MB4489:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB44890EBD2520E017A1CC002E83E90@DM6PR11MB4489.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7zyF4s5P9GYW3FTWRNt8bdvsxHW7Jbj2/GHcYKK1vDRfz68XhIp/fimLnc2GUHjPaUTDGT7fJsJ0XnXJn8322+ISJHrPjWeK7FcaHQQ4qRMn9rH6FMY4VBdtwpdfZLGPZSCik18vxTDuvmT4vbJ/U8XVq1F2K9rWiTTmNYikBdd1qCNZilGChNv026W8ExelkwGZ8RSYJO4T3tqbaR8eBogVm58i7EDxC8WOCE3NYt6xgYq1SeUnHA6nEDIVqCWOtM5xDikpdzk2yqXxDYPerIrOh+M4MiqJ5zEJBPgjum3M0db7eahg7eYpDYkqcxejHEKc0fQ86llStgSmYpcUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(376002)(366004)(136003)(2616005)(1076003)(956004)(7416002)(26005)(6506007)(16526019)(186003)(52116002)(6666004)(4326008)(6486002)(83380400001)(5660300002)(66556008)(66946007)(66476007)(8936002)(2906002)(6512007)(8676002)(36756003)(6916009)(316002)(54906003)(86362001)(478600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xyP24diOwb5hMDmUNM4DlWRFgWC62eqBeUF+yFDklhNhbNUJem80hDpqxyeNf3LJnH9sHNSmZHOgy5ExgkF8TQo9XVtnNEVYsAsdBK39Q9tcWanLNn+mJjWCcfBtj+f9n/Nu2fqmSm6j5cfR2ZNh0hjad/itBOFTgGT2JJ0ehdtmZyAMD5O+7SfUh3ZC76uiDl+x2w4E6t2n2BoFwFoOjGGCIt1XcqyaQjL/DjSZ4FxVSyJ8JLCOEibnOht3DEa0WJ8XlZnFAqf2mL7P9qBc4K9V6+fbSS4YRT4iil0RY1TcIgvX8LK7k+Ws5qsVVFDjrRCMivlsSqIZhEv0uHzmqL56OhaGoruH0JzN5UnalsK1q/odMw+BRnsQre8eqhmKdoZkdJ6kTzidiOZn8d0iNRd8e3vYahRul28qhAWHwII0divyXnoY8QeNrA/HZnuUWKvKHc/HVWxmRDd8VfWOPLAiiujAGsjc1tK4lWz8dtAD0gZfoqaPfMK9Fxyxw+PG5U+fiV7QzOiWqAIGXL9hbvSljAkPv8Ibz4fStqb1NyeXm1PtefDvKl+acn6SWyJ1hLl3Nkh9mC18AQH5/VUN8VAXt9em974JQE3P4kGd/FcCsWIOYXMGMPYNtpqxbDY6mKfKp2QfVtu7FqkTNs09tA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7737f54-e6f6-4d77-51c2-08d8852e337f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 04:07:55.3639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ej8tEaEC/za3rez0IUnylu+MprdCrJoUr9C8DoluL/luel8QhL6ja6OMxCMCZd1nFXGpakBLqEVBjCKPMKkkIHuq/YNq74ferJ0jNumKJus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4489
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

RFC/v1 ---> v2:

commit #1:
   leave one line stub behind for !SMP solving build failures.
   Reported by Randy Dunlap and various build bots.

commit #4
   manage to remember '\0' char in strlen from one line to the next.
   Reported by Colin King.

Original description from v1/RFC below remains unchanged...

 ---

The basic objective here was to add support for "nohz_full=8-last" and/or
"rcu_nocbs="4-last" -- essentially introduce "last" as a portable
reference evaluated at boot/runtime for anything using a CPU list.

The thinking behind this, is that people carve off a few early CPUs to
support housekeeping tasks, and perhaps dedicate one to a busy I/O
peripheral, and then the remaining pool of CPUs out to the end are a
part of a commonly configured pool used for the real work the user
cares about.

Extend that logic out to a fleet of machines - some new, and some
nearing EOL, and you've probably got a wide range of core counts to
contend with - even though the early number of cores dedicated to the
system overhead probably doesn't vary.

This change would enable sysadmins to have a common bootarg across all
such systems, and would also avoid any off-by-one fencepost errors that
happen for users who might briefly forget that core counts start at
zero.

Looking around before starting, I noticed RCU already had a short-form
abbreviation "all" -- but if we want to treat CPU lists in a uniform
matter, then tokens shouldn't be implemented at a subsystem level and
hence be subsystem specific; each with their own variations.

So I moved "all" to global use - for boot args, and for cgroups.  Then
I added the inverse "none" and finally, the one I wanted -- "last".

The use of "last" isn't a standalone word like "all" or "none".  It will
be a part of a complete range specification, possibly with CSV separate
ranges, and possibly specified multiple times.  So I had to be a bit
more careful with string matching - and hence un-inlined the parse
function as commit #1 in this series.

But it really is a generic support for "replace token ABC with known at
boot value XYZ" - for example, it would be trivial to extend support to
add "half" as a dynamic token to be replaced with 1/2 the core count,
even though I wouldn't suggest that has a use case like "last" does.

I tested the string matching with a bunch of intentionally badly crafted
strings in a user-space harness, and tested bootarg use with nohz_full
and rcu_nocbs, and also the post-boot cgroup use case as per below:

   root@hackbox:/sys/fs/cgroup/cpuset# mkdir foo
   root@hackbox:/sys/fs/cgroup/cpuset# cd foo
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   
   root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 10-last > cpuset.cpus
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   10-15
   root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo all > cpuset.cpus
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   0-15
   root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo none > cpuset.cpus
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   
   root@hackbox:/sys/fs/cgroup/cpuset/foo#

This was on a 16 core machine with CONFIG_NR_CPUS=16 in .config file.

Note that the two use cases (boot and runtime) are why you see "early"
parameter in the code - I entertained just sticking the string copy on
the stack vs. the early alloc dance, but this felt more correct/robust.
The cgroup and modular code using cpulist_parse() are runtime cases.

---

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>

Paul Gortmaker (4):
  cpumask: un-inline cpulist_parse for SMP; prepare for ascii helpers
  cpumask: make "all" alias global and not just RCU
  cpumask: add a "none" alias to complement "all"
  cpumask: add "last" alias for cpu list specifications

 .../admin-guide/kernel-parameters.rst         |  20 +++
 .../admin-guide/kernel-parameters.txt         |   4 +-
 include/linux/cpumask.h                       |   8 ++
 kernel/rcu/tree_plugin.h                      |  13 +-
 lib/cpumask.c                                 | 132 ++++++++++++++++++
 5 files changed, 165 insertions(+), 12 deletions(-)

-- 
2.25.1

