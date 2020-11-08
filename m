Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E013C2AAC12
	for <lists+cgroups@lfdr.de>; Sun,  8 Nov 2020 17:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgKHQIx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Nov 2020 11:08:53 -0500
Received: from mail-bn8nam08on2044.outbound.protection.outlook.com ([40.107.100.44]:6816
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727570AbgKHQIw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 8 Nov 2020 11:08:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFvNWVEhsQc4hbCsyS9YI7FWgsb2CzWgve5QQX3g8brYwboqKjjJwvvm0tb5rn1CS56oz3n5Njxl+hKRLSarA/iAylskDDG3SO+b4Wc8AfpDmu1bqFhHqjjmIoxJV08aHb3pm4jN8lEsNUDhj4QS+DGuxrgL8/fSwGY3Df6zn3ewNi1/LfWg4qwEpKUzd7fCFjpEJswA/7xIwiacHPSWhEtD5521ZoFNNVbEOBuPb8a2XWHnR9qL3QK9J7zclDI7qXoyw+8coKuDl+VEFbok6HsGI97zZhMOWWMk6d5KKxMuw1BoSBQOs912ohiWRdhZZsM0tQkHPc66ipzbn8Bh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2cajyWv+8aq85qUtmXVdB+lKrja6lK1jL5SJc0rNHA=;
 b=KgU0BzI+bqWVzzOEbF5JjrZMUImewALT2xj2kghY9FoqQws/O5iwho91VQSTeC4X2TXME3RZuRhKg1V3BKrfuQrWsJu/uxm59p2sGjFEVCX49aWBrnZouE6YtFuCuQFGmkseGoqtWMSFQKJV7jlFvEKyVbbLllUYBoNGdGVEwXIW2fQuiko5NMvHC0W1P9nHkDILRqnKzREqt4U+B4/AdZmH7GVtofK62ebc2z8+Qd6YQmawoeJGoSjYW7Gdn2JnRCTpKuY6Kx/PvO0rWgY8a5x8j1wYZnUZ27FUHShZ12ZMsy9WxZ+SvLWJoLeyj4zvdOr2mHzTuh6PSp4dr3a4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2cajyWv+8aq85qUtmXVdB+lKrja6lK1jL5SJc0rNHA=;
 b=bTJiNj213/Ub97Bcsopo4ijz6WSFIU8XVOwlsWL1UJMia2UWYD99RZquaHum9AhzvfxQtyvsBxmosQwiTxfVNEBouRqEG4r3HTaccn96HDcTm7CPJhbdhiRiC6zjVsw43ETuqq0uHQ8m/r8Ssi0rm8HJKgm8voZ2kjg3lCGXIxM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3579.namprd11.prod.outlook.com (2603:10b6:5:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 16:08:48 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3541.024; Sun, 8 Nov 2020
 16:08:48 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Li Zefan <lizefan@huawei.com>
Subject: [PATCH 0/4] RFC: support for global CPU list abbreviations
Date:   Sun,  8 Nov 2020 11:08:12 -0500
Message-Id: <20201108160816.896881-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::38)
 To DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from t5610.wrs.com (128.224.252.2) by YT1PR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32 via Frontend Transport; Sun, 8 Nov 2020 16:08:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54bbee12-b326-4188-bc2d-08d884009394
X-MS-TrafficTypeDiagnostic: DM6PR11MB3579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3579DEF16E7203317BAFC75083EB0@DM6PR11MB3579.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qXPWGIi/eCRyrvhPxo4dMdmncScrgT5tOnGcp3B3W6eLaOY89p7wWOgNCbSsW6Wu3ysKwBrdk+PX8NdCbfzAL+ydNIoqFgOn9MV4uCgXygymkfp8MMAxdWHbbWUhWslrjwzppIVilmDGs8ewy7t1YJfw2JQxw1xG+VRnptzwqpoMPcROkN9O67gpyDkV+1nvIq7Gf8YpUI9/bWbdL+SGdcgIbEy6+SCH1+82LMjyivxnIxBvihN8SRa16bXxkbUkeTqB58P/xiyCD8hQl+EAYTYz1MEBkySbBrVPbSePZ7LjOefzsIxtnRDG5RIjzh7+jZRw/OBq9WBPbkT5JmeLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(396003)(376002)(136003)(346002)(44832011)(1076003)(54906003)(8936002)(6512007)(8676002)(86362001)(6666004)(2616005)(956004)(478600001)(52116002)(83380400001)(26005)(316002)(6506007)(66556008)(66946007)(4326008)(6916009)(66476007)(6486002)(186003)(2906002)(36756003)(5660300002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: P/NTXp5YGfiPFZbpeLVkx1xjsltGQAHumi1t7PUaE+I7a0BT5QeFA0a+BToddZoTUKkTa/fnzNRmLFBSTZwAxvPPx9IACa6xhMiwSIAmh1gYLPpu/3DhntnrYu9Mh632cm8/csCIqSnonPGJ/MXF8iXiTPtafri/3RM3D81bCf8S9rpUdNV9pSibM1AYNg98bkZdlpKn3Buo36W+94d3fgPerFWaW7ZEm42eZKK+569tJltpXZG5FOWPGO2jvCMfqB5DtrCKk3j24iIvpg9UFmxpFzGoxPq/xnR9kgcoF4Dyil/qCqPDtWNkcL1Dzt9FuNBNtgimyr5ncIKT/p4H83yFUxtgxYgqTwTgyC/lTljxlv1UL9RiiUi24d1Rbwtto4UBK0RSpQVqdndG+JpNqu7mhJnmp544NHEu+86yzE+VSsgpwM/ft8X1/dcyZYl/B29SVG5NacGIGYi8ACw9OqVJgLnNZZCsYbEZgzOrAU9oCaivh0rVjvpmR5qSYcH7J50ritMH+sGn/xCQBcpPAVP9q2cw7UCMK5LXnlgfKX0o7kB+T+wHbkpESTcf8GIXm1wBi6NOeSQ8s7bb75aLI07AVlabFQ0UlFQCYMaFJ/OG1W53vZU9MDvUkfC2jTzym1tirgP6jbIXwJxtXVljfA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bbee12-b326-4188-bc2d-08d884009394
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 16:08:48.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4N60EOUWGCDbLPT+dbJ/ZzhpdP9gT0xKiDw8aZafhlXw/MJjbU1Dh4yVsktE7Ed9cduTpvD1wEKX7MQBwfsWV9dwpba+i3KNqM8o02ANs4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3579
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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
  cpumask: un-inline cpulist_parse; prepare for ascii helpers
  cpumask: make "all" alias global and not just RCU
  cpumask: add a "none" alias to complement "all"
  cpumask: add "last" alias for cpu list specifications

 .../admin-guide/kernel-parameters.rst         |  20 +++
 .../admin-guide/kernel-parameters.txt         |   4 +-
 include/linux/cpumask.h                       |  12 +-
 kernel/rcu/tree_plugin.h                      |  13 +-
 lib/cpumask.c                                 | 132 ++++++++++++++++++
 5 files changed, 158 insertions(+), 23 deletions(-)

-- 
2.25.1

