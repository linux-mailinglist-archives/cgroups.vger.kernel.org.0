Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBADE6C4F12
	for <lists+cgroups@lfdr.de>; Wed, 22 Mar 2023 16:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCVPKo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Mar 2023 11:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjCVPKj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Mar 2023 11:10:39 -0400
X-Greylist: delayed 2027 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Mar 2023 08:10:35 PDT
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642B54D28B;
        Wed, 22 Mar 2023 08:10:35 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MDq4SE030293;
        Wed, 22 Mar 2023 07:25:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=WIFKt/lwj22OXSfQjLXjeXNCFoPB1NUDKCJV0aNbMc0=;
 b=F3BjvSyFNQV3IsMSO4q+lTG90j9RhpO8pPEcKmBIC9ZfSJZ7QKPpsgn2azAOv5vgU95l
 ZylBp9X0kck0I+4N8n/DGot8k27qv6SJ7hFRoBpHIXV5rKgrxUJOdObcgMDMQ2dYMEmE
 I6nYheDT2nvNxyLNNWBhltZ420mWaOwQqC1V5iSn8lzmuGaIFE6JzLliUftAj30HIvpc
 D5E7H6JUzlQ4cZYBLTNJjh+rNcUlsKneH3fmOF3poSJgatA7GN1D9DhnwJQZV9byoh6+
 gIBUIbY34crtqsKGY9vQ/T701MAsrPcfSnOcfIAgGosXWUiMPzXvQ0mo9l2wx/BrkpUr dg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3pd9mvg768-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 07:25:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoyyRvRcdQ9KyVVtdXiecOiJ8vDJzEKRirB2LL7QHueHoelqC5IJWuZeX3cnEdHOAvyYPjEQpqiYVy3Tw1QDFgYwRYrcnoTRUowt5NCfJPIKtaoYbSWY+5c7yrnyxVk+PwZty+p8ez7vlLKhKM2ReG2XRyR99/AwPVbE1pG22b4DCYFvDBipqO82284NCV1OO5SCWm5RGIci/8RUqyjTMERng+IT3Go+onKzLh24nG8AkGeEzFhnr7PzSv2OwUXMfoEgt0F0ejUyTs3Bt8gkfkFoUuR5owElYMVUy3hlJeBFpboapJQCDAgbHWgGok03mMkiopr7LeI4z20fJhw6vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIFKt/lwj22OXSfQjLXjeXNCFoPB1NUDKCJV0aNbMc0=;
 b=H6UISdgixYH93hnr7c7cBEkejZyoCqUSs4STojFkMrjiOQQeMq1qTh95p4yX8kXuUAU51oTUY9mL7J3tFG7/KEyq5eWscQbyPCrYVfYK0Tn326VfQi7pP5Di6WBKaH/g3zbQ8OLGuucwX1jm8Di54EknWlA6nEslSwdWAILpKSX4hylwwioO8EiBGSw3JtAoxG75tjd+kS6emGu9K3o4fX95mEVe73vuF0UC9NPWtHVZAPCGwQxvdTycAOBhE97dHehigdMTqG99yRAn821t3JYw42YZGO2WkQljhheeLGBusSlTVGpsDpnWDy+mUJ0oSdfqTbgr+ab6Mml+Q6H1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIFKt/lwj22OXSfQjLXjeXNCFoPB1NUDKCJV0aNbMc0=;
 b=lzSO3/GY7oO9kV+QxwvigMmMN70C+fshsKjUY8rqDvezOR3a2S6Ud3hU68zxM4DrXUCxTZ2tJlyFBn8E0c5CU2qH90rDqOevYaYZwVHpYrKL/NOgcPYu397rLCe2VTrl47dJrHRWa/5TK18KD0MhbVrwu0A6cfLE13HrVWglZmjiYv5AtTGMaC65/M33k3Op3JQwQ5ThcXTMWPZwLx1LWCWxOh5pHlQDKth5Ducj+o7cS8qKTIKiUzx0Qj1i1uUmSOOnhWk2pbwmr1TkErUVOfgGpuyd3YBXrnCXIsXoRPKoU1UFis2ygSdeAjPMHTL119sPYMAfO27fjUAKMIl2WQ==
Received: from BL3PR02MB8217.namprd02.prod.outlook.com (2603:10b6:208:33b::20)
 by CH0PR02MB8289.namprd02.prod.outlook.com (2603:10b6:610:fe::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 14:25:37 +0000
Received: from BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::cdaf:f99e:fb15:3978]) by BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::cdaf:f99e:fb15:3978%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 14:25:37 +0000
From:   Florian Schmidt <flosch@nutanix.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Florian Schmidt <flosch@nutanix.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC] memcg v1: provide read access to memory.pressure_level
Date:   Wed, 22 Mar 2023 14:25:25 +0000
Message-Id: <20230322142525.162469-1-flosch@nutanix.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::12) To BL3PR02MB8217.namprd02.prod.outlook.com
 (2603:10b6:208:33b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR02MB8217:EE_|CH0PR02MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 591a0444-8f06-46ca-966a-08db2ae14e89
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZxTK/N8UZhE4gIeG4cQkOooBsfGpWJxh34ZNeJ3Qk9nvwE1zub+P71nl2hqYB6BngvqwLPodbngPiUvzBBTJ2EFsLjLbWJItp+HLSfhfNZY5+vo4ZEJXEzyJVnvgj1+OcEKbpKAr6+YVi0Dq4guyD9QTEEMcF5D+5Zv+QsgXSgcX/osNj43bbWo+JFRGWaO0gQk4A2V+1eWGKAmPrIzqMWhp32azJ0AJXgpN5FgGrJqENc4aN07l4KK2nhO5F4u3+w+J4XyRQu1U5llXGOmIA9LjKgvvayIQ4Jif+vLwXro0C7Oe/ZPOo/BFBaVKujT5P7c5oJUrj4sa/Cj6j7RDIQRI0AX+gRtuyP3TT1I/CzfJ6NeqPrwuZfGvVjjbzIi5UZKM5PKDuhrBL1yA5OR54l26OQnDQ4riL/qkfOHL+8ljexv4H06WDEZqJCeP84vHCBrRVNNffB0zMVHRR5eJwusAiUkH7PmgC54Jm0B/hPBibgwXRxvXCToVtA4+HGosAOPXjBhy8V8Tc2I75TUXEyOuTwaj9DD2z5/bbzXAo1WQQZ/VsJl6cly97LVBEXpLy4SB5imX3C4kyUpOkO29DDxfP/UF7BPV2yaToRiqCD91qmWZx0Ws9AuT+9LwUaYMGwjOjClxtWZeX93CwYgccXhboEuMdpR80G3P19CwoC6KfcDRKHoo+tghv1AVd+5nEfvkuXe6wXxrAiZHPy3hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8217.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199018)(316002)(52116002)(41300700001)(110136005)(8936002)(26005)(4326008)(1076003)(478600001)(6512007)(6506007)(186003)(6486002)(6666004)(8676002)(5660300002)(2906002)(2616005)(83380400001)(38350700002)(38100700002)(66476007)(66946007)(66556008)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yorG/bcxx39CnBGxnMWjQ0uqVmaTChKf3DwWhO0/DTNENrM9uaPIkkFHo63f?=
 =?us-ascii?Q?DKCzec5pvR+dGbXg4tUPxL6QuDOJTuXN+Vp5h7rctneNEv7l9BLGWFekRpcD?=
 =?us-ascii?Q?E9XvbWqZ2GVPgpB5aHZwPzdnW3c+ro3yw4LQBNy77iRY7UoQ+yHPMsPyjZ5H?=
 =?us-ascii?Q?liCSeJeOYAZg2okx2VdL6nQSLI4jxgftVmGuJRpd0GptdQwdzOK5aED4ufru?=
 =?us-ascii?Q?sxQUdctWSnbvoIGrcqsun4em8pSca+5hMu3Lbe5HZHv6qvfy/rR6hRKpstYK?=
 =?us-ascii?Q?xTgjA+MU/MGo7hdcJr5xY23spWdqB4CNJBJ+3fDVT5yCvIJdloXHpjK8Z5fm?=
 =?us-ascii?Q?SLrgTr0S+yTdeoGP9L+D85tnTEsQM2RinGeBQO2Lg9lp/puEQTv8RpsPcbB+?=
 =?us-ascii?Q?9ly8TEQ2mF+1+l5x5lrRDaEn1MqmsafoPS6ZyZVPk3K7uhf3s1uzd6QTJ5bi?=
 =?us-ascii?Q?ZTzVrqim1l8zffO/xXGWnzLO41bZrlC2mSvklPJhmkFKj91FoALNDvyGOIc+?=
 =?us-ascii?Q?Jzw2aNsoD9VTi0lAbYt2HV+c2R5jTUKWvTM5jX+DVNLkj4j0F+nsmc4U3Zyt?=
 =?us-ascii?Q?rsLiDSgtiWg/rYD35S22SxVBK2miki6cz858KpmnybJqv+utjtD4l1fR0Yk/?=
 =?us-ascii?Q?kor+gWXrDEgy/388K0O6W0PwFp6aJULiA39uCLIbnKlvWRKZWXJbVbiXGLyJ?=
 =?us-ascii?Q?KxKSKue2BCjfXnMbHG3CH2jgBkhGgSGEKE852T/XRq79LPncxKy/ZBBfWHGc?=
 =?us-ascii?Q?kbCTNOuQ9qjReV6QYRvT6PxOsI/e5JXUMFlLiWZk1+/HwkhZA4TRzhtr0vp7?=
 =?us-ascii?Q?GHCEymUZDf1vE93iPHlDPW4AVGOKS8NSHsXI2k9cExDqS6Vj7No8xCPr1hyy?=
 =?us-ascii?Q?O8TTzZDBVEUysM8aoBq2zqHOg+OqX8m0EE/hR5+O6kgKfRg1jpASStoImtsP?=
 =?us-ascii?Q?EA3GgjsSCEZ7jknXrVDL4bKIRzdONnQfH/eOBrTOWxhPVg17EXCmfjuiiF7D?=
 =?us-ascii?Q?85J6gXjGNMtuNR4AhalxYFHfDt13EWpSXwqA41XFyYhMtIF/RKo4UJkYnArB?=
 =?us-ascii?Q?7M+YnISGhQZ/F6k4ghzhNWqPYPuQWXbXum3bG77di2N1bHZNfeKdpyPaPxqP?=
 =?us-ascii?Q?bGmjErvVgY5LDyFghATg56mwncXl9NZRCkWepPEVsvuMVkeLzXZGy2ER+bKJ?=
 =?us-ascii?Q?LgaUJ4tYszliX0lNrKsmgZijKpAkHFvqsgjeAl2UHLSvKvo+LM+nXNjzncrS?=
 =?us-ascii?Q?7TsjNfHV7nvF5RV7XMARsB1qAO2KxxhSEx1yxiMuNDLe4MvhtV+YqD8OuW0O?=
 =?us-ascii?Q?IeDgBngDg8tKEmsoWwWC/GnbBlz5ikog+tpUgsn8m0OP46DIA0K8pIYm7OCo?=
 =?us-ascii?Q?8VFFDByHAgSx4PHLGkOHVCDVdvue8Qb7Yoyhli3HvDSaeEHvCRffJ0F8Tfze?=
 =?us-ascii?Q?rGuEYR9Wi9NMHJpTr0KJDWLpTbrXFeD6jBO7jVclcFJJRhYirtY6e3tzGiC4?=
 =?us-ascii?Q?1RJXThsIH4ImEg/D377pxcg7TuYbWPnSbNzWf5abzsDoeSM8RA8CtIYdDabc?=
 =?us-ascii?Q?KB/rpiWCmD4C84mwdajsLtE0kbglOBlLlQuMX4ynasTE3FQ/zBFtI4zIk8b8?=
 =?us-ascii?Q?Gyh6Ty1yhDsvENsjZ1cef4o=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591a0444-8f06-46ca-966a-08db2ae14e89
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8217.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 14:25:37.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Zs9+kV2NFqlTkZzAsesxpkNXi8EqlPkpCoZWth5BZd0VfH27yN/f4L6CCf+00xEPhcANceovHxoWZiIwMb0t+c8VRx1aYwRhFq8bpj4luI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8289
X-Proofpoint-ORIG-GUID: fJRvEXj91nTNkxZdfht8Ee9FVVSoYQCk
X-Proofpoint-GUID: fJRvEXj91nTNkxZdfht8Ee9FVVSoYQCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroups v1 has a unique way of setting up memory pressure notifications:
the user opens "memory.pressure_level" of the cgroup they want to
monitor for pressure, then open "cgroup.event_control" and write the fd
(among other things) to that file. memory.pressure_level has no other
use, specifically it does not support any read or write operations.
Consequently, no handlers are provided, and the file ends up with
permissions 000. However, to actually use the mechanism, the subscribing
user must have read access to the file and open the fd for reading, see
memcg_write_event_control().

This is all fine as long as the subscribing process runs as root and is
otherwise unconfined by further restrictions. However, if you add strict
access controls such as selinux, the permission bits will be enforced,
and opening memory.pressure_level for reading will fail, preventing the
process from subscribing, even as root.

There are several ways around this issue, but adding a dummy read
handler seems like the least invasive to me. I'd be interested to hear:
(a) do you think there is a less invasive way? Alternatively, we could
    add a flag in cftype in include/linux/cgroup-defs.h, but that seems
    more invasive for what is a legacy interface.
(b) would you be interested to take this patch, or is it too niche a fix
    for a legacy subsystem?
---
 mm/memcontrol.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..e48c749d9724 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3734,6 +3734,16 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	}
 }
 
+/*
+ * This function doesn't do anything useful. Its only job is to provide a read
+ * handler so that the file gets read permissions when it's created.
+ */
+static int mem_cgroup_dummy_seq_show(__always_unused struct seq_file *m,
+				     __always_unused void *v)
+{
+	return -EINVAL;
+}
+
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
@@ -5064,6 +5074,7 @@ static struct cftype mem_cgroup_legacy_files[] = {
 	},
 	{
 		.name = "pressure_level",
+		.seq_show = mem_cgroup_dummy_seq_show,
 	},
 #ifdef CONFIG_NUMA
 	{
-- 
2.32.0

