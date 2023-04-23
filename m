Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252786EBFCF
	for <lists+cgroups@lfdr.de>; Sun, 23 Apr 2023 15:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjDWNm2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 23 Apr 2023 09:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWNm1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 23 Apr 2023 09:42:27 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2087.outbound.protection.outlook.com [40.92.99.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD96C1B3
        for <cgroups@vger.kernel.org>; Sun, 23 Apr 2023 06:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDe/IX9I5v/HegF77oAx/wtVjXMmQnYhgFFUXAHXIpQX3O5nouAJtFbO0atmLOgGoPKr8CKYlUyEvLszBO1GplMM/ou3YBt4IckqcYusAFFBdhEEOAG/y7DXLC13Ugq6Vz2iYso3vK56NiXPz69tY92IrMrr97DVMlJjVwaPeD8DFlOHMdgbxQeBmW3oFoKK8pxtsd61szket0E5Oc2w27FvjXmMWh5ZBNLAqLyCohQs/B8L9ehZAk9LGWBg6BWqtZ7+YR5X7Vjo6vlPGTliieQ8gseweldYUC7MzjKRaf1hgEZpDG4aLEyItAhafpxyZQFbSQKvd7KoLpN7w4WlCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIBSi2pbn/GRsxaRiGPiV2kaV11LquoEHWqjt1iHLeQ=;
 b=RQcakmz1Yt58kyXNI9xw7Og3swC/ghUITgzw/PHr+6Mhh9YNguG9jJ+g8vzuIyoW+plN66Ph3A56Ho2tugW1pz1ZrUczHrzLrPPG77BbbEKC0Q4wxwFimVBWTxH5Zh18Sb89a3e4KcB89srG6Rt/R7i3lDl/spqRHLZ25Pk4g4C073n4iAVDTlH7h5M7npqbRTA+lwWXGJosjiXWA/AxiMcZ5nT9HLgG7mm/Ya1+ClangOj/YPf5PabAGqNbj8zF4qlFp1Kk1Yw5iILINVNL5CKuwHagjBxw+3ZVd/QpiNAZ1Pa99gRyZdIKYKtjnAN172hU6FoLCCOCoGPOXZ8OoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIBSi2pbn/GRsxaRiGPiV2kaV11LquoEHWqjt1iHLeQ=;
 b=KJ+gjWmdBo+1rb8raBF74OKTBvVq54chIy+o3AAaSZm4cZQNp/8XKN6hw8HFlVzdZ9g+L3NSc1GQtk1CijIjTvHuGDJUjzXuL0hhUVlR1/OoxvWN/GKOjrJwKlrpqGYT6c1gEKHeY+aj17nmQ99cLrvrW3/CC22I0Ymy/uvshA56Y+l0le8thNR8srtoEiCxvQXvoRTZBQCyigJrmH3ydBnUkln0uskAqUitxFFmbxSnOrIG2p+b/oyPDXKx+o4bpHpPmbcpNlR20eldWfLOptTVJlveJDWB5sQc1fi0RRh+k+D2VqIL6ZjPa0v5/o2yki0STevkWEOCrCTBdBKbUg==
Received: from TYCP286MB2335.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:17d::11)
 by TY3P286MB2500.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:22d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Sun, 23 Apr
 2023 13:42:20 +0000
Received: from TYCP286MB2335.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3f65:1cb4:43e7:81d3]) by TYCP286MB2335.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3f65:1cb4:43e7:81d3%6]) with mapi id 15.20.6319.032; Sun, 23 Apr 2023
 13:42:20 +0000
Date:   Sun, 23 Apr 2023 21:42:15 +0800
From:   Chingbin Li <liqb365@hotmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org
Subject: [PATCH] cgroup: align each value to its column name in /proc/cgroups
 file
Message-ID: <TYCP286MB233532036CE9F1D67ECAB422E9669@TYCP286MB2335.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [eJXTNL+LsbAK3tlu/c5vb/dK/1UI5bW5]
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To TYCP286MB2335.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:17d::11)
X-Microsoft-Original-Message-ID: <20230423134215.GA100742@liqb365-BATTLE-AX-B560M-HD-DELUXE>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2335:EE_|TY3P286MB2500:EE_
X-MS-Office365-Filtering-Correlation-Id: 295cf153-2c27-420c-f2ae-08db44008fc3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rj7QgNY0QDS+1RXzbkyQaQ6MjxIizwIWoRJCEIXz8I5g1pWInm2tn2T9h7k2X3wGn7Ix12TsccdXitOPkirceVarkiFGp2NBNYg36pY6qvhY9JCE9rgGI6jEBsvxiPk7ZwlYtKJ5MKa1I4XZzYSPzu6brvM9Fm3JqqGCD4Bmh1prlIJMzrwmHkBQcAbBma/ZUTLKycyNFo9qyDggpGbpVr6+OHz6hndauoErUkBaGzdX7XB6Y+A5bCnWCsolNw2S+ukoXYH0bG941H7+5PFfGbWpPOmRHFV+B57YITCPI55Dnz58uZcJb5avK99QjogX9QyYwvHQMPl6OfVo0/ZZpb5MUDbqvJBM1LCkQ4IW/0SOo9PenU5TVqEIqMrIZBAvGQLkkFOLRsRaqz97ncltvbqtXCtvC+K+8uB+DycOlgY6cGHJue7ecH35H57VzgAyMBtIqcgYppOhYwL1x9Cua9vr14xrzm4DX/JD1bKcWoGDoqme84eNBERjA10olcCFNjWgDm4dadTqJmMh+SGN4rXNNwu22m7/moybr7bW1+vL3u8iWYjlWYjEI4B62FUS
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n5R5gbS7rAWXB2LqqhaUYRzEWPxJNG5xjiYrNxHbg/SfnrLq9Wm+Z1RVVwAZ?=
 =?us-ascii?Q?vlsRoeqlXVhQRGg1HY20q8h1CkTZCNmDkgOcy+vr9/O1c0GoUvICP117kUra?=
 =?us-ascii?Q?D/0CDISMvBSBSy7PlFNGc58QeqOK8ZK11xpNVpTmrxHLv/tQmyYK4VUNBoO9?=
 =?us-ascii?Q?fzrbWUgi3b2cgXGGwnoDVRezwq+Z5UEKHp3Gspu3FSqb1OvkCMvs06PbywF1?=
 =?us-ascii?Q?/oobmS7WlU4b5zebt+MxGBQXS71a7p+s1D1LKlvotUJVi5UsH1SHdpq8jcPB?=
 =?us-ascii?Q?R8UbHtC8o/dn0hQZ0WCRcHpFpPQXKgr9GsgvUyDNLOvXMQcLTZKpc2vHy0Ha?=
 =?us-ascii?Q?/25W+oujwDWFUgMgwQ3QdAPmkB9yKwsPgJex/ye82boj++/YDLdiEdJjrQoA?=
 =?us-ascii?Q?MUyicuh/bJPsK1/zh7o2A7k41C1Ak3xz8fSF/ccxUl2kabgtwCRmlEsP2L0D?=
 =?us-ascii?Q?upZhEhsOnZuiV3tWvLMJLvYDj2nQl3mMOoEsQd2UeuXxgFIEA4gIHL3OrhAx?=
 =?us-ascii?Q?mHDBrCl3WT4AgI5xDa7c4Y7pDNEdsgrEmP4WFhIJkiEQJwUNz8w0d/WNwhLY?=
 =?us-ascii?Q?tb4BpnhDYjh8SrWG9ijP0OhI2LBjLYo83w85uoDRfQbfrg8UZYz5BYSv3E5y?=
 =?us-ascii?Q?94SO500e+YHVxsUzbc2LX479RuEFmiF3ZEZOx/J0v9PAa3qmVg1yuZmKsVeE?=
 =?us-ascii?Q?hDtkg4f2/KH1MbDD7+vCJwocnlQ+lURmso/mLC6AO1eQVmATChtVVfM6YzZV?=
 =?us-ascii?Q?P6UFdqannQfq9EEwpf4KN7FkYi0hhtFO3uoTFSGraanBZ9nTyegvaRrcx3Ok?=
 =?us-ascii?Q?hu3H0sV50+HIBR3x/7nB9fiKDNg0cCDStd3LRMVVxz81XJPzkPQr0vMcFNqF?=
 =?us-ascii?Q?t9suO8G2e1K86XdvhVvLNuBZp66+UQhWzltbR0lNN3rYEXEV1m15E4ivAOde?=
 =?us-ascii?Q?Qjk24xZeiOIkDTNWp6C9nrb7Swkv5CPEhNsvC6LcsDrrRBCyTjMZ4Zrf8yYi?=
 =?us-ascii?Q?Etweb/a4yPFTlbnbF03Au3h1qCc7sbT3ht574h45zLyPHg3f9ki5pjdvtW62?=
 =?us-ascii?Q?VOEZYSKfgY6qObjf2UoE2JO8wouDaOzJQ+xpC7jl1tueR42v+AmRwzShKnUS?=
 =?us-ascii?Q?3+4k+iDprYuBEBnZYwVI8+d+F6M1OQ3WOvpByCZrHuYwXy5CxN/j/jqFjyR4?=
 =?us-ascii?Q?9ifKNSmH+dAjfE2NEokSzbHTxSgFalGRTFrL1A=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 295cf153-2c27-420c-f2ae-08db44008fc3
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2335.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 13:42:20.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2500
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, the /proc/cgroups infomation looks messy:

/ # cat /proc/cgroups
#subsys_name	hierarchy	num_cgroups	enabled
cpuset	0	1	1
cpu	0	1	1
cpuacct	0	1	1
blkio	0	1	1
memory	0	1	1
devices	0	1	1
freezer	0	1	1
perf_event	0	1	1
hugetlb	0	1	1
pids	0	1	1

This tiny modification makes the information looks better:

/ # cat /proc/cgroups
#subsys_name	 hierarchy	num_cgroups	enabled
      cpuset	         0	          1	      1
         cpu	         0	          1	      1
     cpuacct	         0	          1	      1
       blkio	         0	          1	      1
      memory	         0	          1	      1
     devices	         0	          1	      1
     freezer	         0	          1	      1
  perf_event	         0	          1	      1
     hugetlb	         0	          1	      1
        pids	         0	          1	      1

Changes:

   Summary for each column:

   Column name   | Column name length        Max value length      |	  Max
   --------------------------------------------------------------------------------
  #subsys_name	 |      12		      10 (perf_event)      |	   12
     hierarchy	 |       9		      10 (INT_MAX) 	   |	   10
   num_cgroups	 |      11		      10 (INT_MAX) 	   |	   11
       enabled 	 |       7		       1 (bool value)      |	    7
   --------------------------------------------------------------------------------
   Unit: Character

   We use the max length values as the length for each column.

   Besides, insert a white space to 'seq_puts' statement:

   seq_puts(m, "subsys_name\t hierarchy\tnum_cgroups\tenabled\n");
			     ^

   The purpose is to make the 'hierarchy' column name has the same length as it's possible
   max value.

Signed-off-by: Chingbin Li <liqb365@hotmail.com>
---
 kernel/cgroup/cgroup-v1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 52bb5a74a23b..dbce2e950aa0 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -670,14 +670,14 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	struct cgroup_subsys *ss;
 	int i;

-	seq_puts(m, "#subsys_name\thierarchy\tnum_cgroups\tenabled\n");
+	seq_puts(m, "#subsys_name\t hierarchy\tnum_cgroups\tenabled\n");
 	/*
 	 * Grab the subsystems state racily. No need to add avenue to
 	 * cgroup_mutex contention.
 	 */

 	for_each_subsys(ss, i)
-		seq_printf(m, "%s\t%d\t%d\t%d\n",
+		seq_printf(m, "%12s\t%10d\t%11d\t%7d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
 			   atomic_read(&ss->root->nr_cgrps),
 			   cgroup_ssid_enabled(i));
--
2.25.1

