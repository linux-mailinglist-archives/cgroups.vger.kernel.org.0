Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7A16D5E82
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 13:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjDDLDD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 07:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbjDDLCs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 07:02:48 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F1F3C18;
        Tue,  4 Apr 2023 04:00:31 -0700 (PDT)
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3347ANHK024181;
        Tue, 4 Apr 2023 03:59:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=nDcbGdE1LonX/7dDygW9Mav/W816HIVPNJEmJMGQL7M=;
 b=vNVmkqbhJzf2LKGR317lmJvtEKUp+K4CjmGfe6KT/RIXMg20nLbvGvD94LCcYf3muvlC
 rMcqE2osxBDBbhZQDtCmwafP6f8A437C0KURMFtbsXnBiDkzoJFT78KZCwRv6X9/2u5t
 rc8a0f8QDKx2mo/Xicxtnc0NncW/CDE+t2qchEqVlSM4hdvxIaldymWRDLEdTK5MDBWt
 2ARWcrOliqkSL/8jbbsw3Q0kXmOp+pt70zuCRXRMExc2UTXLrFvRMu8JwUalpclrLv+A
 RGaqCmn56D8XB0Ys+wyEAV8y3p4dqf1OmWz8e5dJgbhac5VjpQ+HzUFdbf79D+zK+Gnp +g== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3ppkxgxbc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 03:59:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O93dN6Fq7UfXkL0/hRxH5EyfCwnspkegHjeOEeG8UfkzbN5LR9+1Op5oJviMdI/L1FtgHbNIaV07vnv1ojy+cme0VB2PUUyIhic8yHmbFV+N52L4sfVkVjoYhOx+Ll16QOLYd9W4ifCyOGXACNdmrWOMOYUGiAaiOUXY4hV7l/rWd8dYXtdMKAEXTXDYRPq2bFVqjOI8vWUFlfduhkQMxvQib4SZIwFKADAnFhEtNoug8pMdMQcfvJuCOubUXgZLp2mIObvRX9mTB6UTgGSEwv4osI4zJEpFqvG/AXDbPyrKWBEKSzwmgc95Rzz+IXwkAGpiY8x+Y5IBRVee0p30Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDcbGdE1LonX/7dDygW9Mav/W816HIVPNJEmJMGQL7M=;
 b=OzAvVoR3Dd0lAX6xGqj12MnPYnyWWS3CXOTceZcYd91W33b/nXfO+8CjNHIxPNtiEpwdbnpPx32mg0HUHDmk85uQ3j7tcnQ4IuSDSxGLNcNXkYUmtHIJB5EXbrb7m4rKInrUIQGIWZ1fEKdV1MKr/v5qPUmmIZbNjGezQcwtitkfdJvpw1II8+Xnx2SBEEN6jRzUkuBk72a/p54R90RnboL/SOWhybSpSLT24COARmiAoJbyHCVeBI2yzQpExETgG2w5rIbvHzDeSHIPza+hYcVy4FC49Vo3UtkBIIe8WfqQjBon7rNnNs60KbGdaQ85i8dMfa8NRWapdV/F3KmGcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDcbGdE1LonX/7dDygW9Mav/W816HIVPNJEmJMGQL7M=;
 b=PP5Gg+KAFYWECxY1yS99iuel4K2PvvqTELJmZSnoDuLZJBbAQSr0cB50E/SIUIsZ613a0RJoGMxZB9qHhP88BediWefrST+iarssrgWNfRKBFJ1yRWrQpQVl2RGNQdZeGIJkkO8n8IzFAwA2ImqFgdvsYHdBo+RCZtt9cb1oFFcn+swcyRPFZrxuDDxBSVDGlRFuC783/Q+1VKq0olQTF0Cq2g7lAcmiku9eiqDnNnL0xYAtnIjoAYATQ7PHNLNmRt+OT4NYqDC1tQsCX3d868tsaR7PVZFxYK5ZsWJNf2cN/KmHu3GLCxMcenwZWqxyfNhU+BhpVDWMKpu2EVvAKA==
Received: from BL3PR02MB8217.namprd02.prod.outlook.com (2603:10b6:208:33b::20)
 by SJ0PR02MB8434.namprd02.prod.outlook.com (2603:10b6:a03:3f6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 10:59:10 +0000
Received: from BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::5065:b9d6:42c9:823e]) by BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::5065:b9d6:42c9:823e%9]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 10:59:10 +0000
From:   Florian Schmidt <flosch@nutanix.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Florian Schmidt <flosch@nutanix.com>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memcg v1: provide read access to memory.pressure_level
Date:   Tue,  4 Apr 2023 10:58:59 +0000
Message-Id: <20230404105900.2005-1-flosch@nutanix.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:40::19) To BL3PR02MB8217.namprd02.prod.outlook.com
 (2603:10b6:208:33b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR02MB8217:EE_|SJ0PR02MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b22fe1-cda2-4fbc-6a92-08db34fb9e2c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqJuuJDAe/v2Mb1P4xWguSXGuxfz3vQMFm2/4l03tKTT1BkNjW4GzaQQolWp6lWV34OiqJSyIGZTMUAEBfzvL8DF8cq8yO7+1UJqmSrKhc2KWwaMFLdj3hq8121v6FxALLeTTOYMwZDMMruKSzPMXL42Rz+XPHmzcCmpkI70IWEnMZXaupUo4/bDHjIG0YJbpPIIEkSBFOm7xKlBNogFwriykKt7fedf5j6UHCFFAR5Y++CjPqUTdvd8wxjET2Ykx0dPMprsCvBAELEY1rLHrTg8TgZozVW/h7Qdo40cfo9ynwug2PoxI+sZejakXFLImfGuTG34QN6bp+66Ds3SKSa2Iqi1tssVxQEy3OL6xfuwT3zKjdPlulJvdjrjJaZdKujoINLSSjh7HJAy8WzAV1jJtBpZWMgv+yCrugj7GMG0tc/EKdtNLrO8h+L4cPa/k95dh2NOn4oVFkk3XvEd0oU8t4yXC5BuZE78oQ/Ykaz/QZ1RPDLJ+fQm8taU1r+n2afGFlXWi53JJCJ5V15Da6XYKmMnJe7UY2ZzpIg1NGFS4YaUg1iVel9okKJ4t9NQWkuSTkPd0ZGRBuvO1CZ2VIRNIui7J3xJmUs5IrsMdmXOohayrrG5V4kW5mUn3k+S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8217.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(38100700002)(38350700002)(5660300002)(7416002)(2616005)(26005)(1076003)(54906003)(110136005)(316002)(83380400001)(52116002)(36756003)(6486002)(6512007)(478600001)(186003)(86362001)(6666004)(6506007)(41300700001)(4326008)(8676002)(8936002)(66946007)(66476007)(66556008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sFYTxh1p4L21h61EFW8lB9GUFIIXqOvdWB//ZuaGnAVHN+HRvKp9eBA+E7wf?=
 =?us-ascii?Q?fCLl+/uhVFd04KntJAldSzHTit4E1gpOBRHTS6xc/iuPFEGu1z8Ym0xhE68m?=
 =?us-ascii?Q?+T+IYp0qLE9cYnhqhKnQ5lpsMVYpWtGm5wvCIZRuX/cdjEsBJE/GsTY1gBkI?=
 =?us-ascii?Q?U7Ss238zjwdC0n5iNtqjavliqyVzJzuFydOi/m9pmGcnqHj8UIAP75iwAQZX?=
 =?us-ascii?Q?4z5dBaEvy0YhxIKymU4YuQ1sy1IzGxy5z3deVfb4N+4R3SebDyNrKnHhe0Je?=
 =?us-ascii?Q?K7htCVHFVaVZgnNOgmgQtEco9hkbfq5kgDIMM1+25muWsZ4Qs+yyyJCAzSn1?=
 =?us-ascii?Q?zMKhxTFxF56/gby5IsFS0vMiBRIshgys8Vbienl1/Q/lzZJAbPeyp92vHJfX?=
 =?us-ascii?Q?ezmgZhSIG/bvtcO7I1LgD9dgmDg26nbf5fo3ZnU5HrhYhZxZjtDKPzTPkM2y?=
 =?us-ascii?Q?JKNWOg/XN32JxKqZTm090e7vakfw+bPrc9Cw/MzCP2PULhBRtFgYg8bSj2Hh?=
 =?us-ascii?Q?3RBOGIZ7oj8zsw7T3NLvJOZTUC/xMw2uKmOo6RXf7U14u9k2LRejJYG+wUky?=
 =?us-ascii?Q?IddSeKh8X4f97YdIIRIihGK9I17vXEUa/0KRQqwflhzOF9shQskUFxURKg/c?=
 =?us-ascii?Q?37yMuM6PaTPMPakgIWRP9Gx4r8j02Y9/1NTr5zmIE6SLLn92NPVAAZ7w8pfS?=
 =?us-ascii?Q?7OlH1GJxRky2h3t0t/g1wag1dSzpmRZHQ2x/xDkr++qydqdaLgybIZ+yOON4?=
 =?us-ascii?Q?P1D4blbXDlSS/8dpF71vXOmfg22kburmKSeedW7ZpaxpFJZTubVL7nuaLnR1?=
 =?us-ascii?Q?cRMvVSj1OxKCKVNNp1VKinqjzwk/llemZPnO/23f6r6CNBvFczHHaeywZIRk?=
 =?us-ascii?Q?kQ59Y1Bz3GsBdCbivpxzx8o7Y4G5G9MrAJ3duGVjerT+ZCSQJkA1AJxMLzJR?=
 =?us-ascii?Q?fBYSatPcf2XWT3F1AB7zkz+MTdRrbtrst29TqEK2ri0+SUnBUxNn5b3RNaxn?=
 =?us-ascii?Q?uQKQ0fXDdDBDhN/f5InhJlQPVChpWnUKFDButMr4XxO5Jct2jyr13kiJ5Eu+?=
 =?us-ascii?Q?7ajUZ1DgdjNbFbh8RNraSswjFQESzcRVF8CWeo2LZfVfGc67SpMWclqdpPAz?=
 =?us-ascii?Q?XD/JFpez+BrmiG3vgy7+gcsHsOApYRma1KVaOyEJc2SyG6rgEHtdXgyP9cpr?=
 =?us-ascii?Q?K1RjqMxDWUaod4Icm0aIy0DB4zRtPCUaZ+MuDm85Uy4HQHTdO7EZd3AJ3V/k?=
 =?us-ascii?Q?6tMxoXQHqRCZrgIZ3J5pOYmbTyaR61LFdYGOsVQFqdqZaYFmzHwZT4h86IXo?=
 =?us-ascii?Q?vctctOc728VByHyDBkYggerU1aabGYYDdGS3/VlZcG0OP4gCxXJb5HsMqAgI?=
 =?us-ascii?Q?OR4KL9/zJxUQUnhye93l5lzjDFq53p797BymEBaHGeXNQuqwoj0CVdgaplwo?=
 =?us-ascii?Q?2TMo+nyPIZIHzjsEEkx6SpfOI1AmqdzCSoIguV+x590lw0uYaWh9pZgPfDbf?=
 =?us-ascii?Q?uTew5Qg0nalMC3ZbgPO1rRLILyDGTFewUB2hHyIyXQRGW+gZW7nntwkXcOC3?=
 =?us-ascii?Q?WsJmxp4Bs5mFtPW+9j+JYwmHS2cutL+u+MAlIvUZX5GHevnZ7+/xA+P+rvTT?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b22fe1-cda2-4fbc-6a92-08db34fb9e2c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8217.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 10:59:09.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koNqZHjcQSq7iRW+FtQBvVcPKXNodTiKmP0PMC+n7SqpkbHnUTQsmvlij4QdC96lHaSVCy5nfWLXKdM7RdyCiL1Khr2GhnJMhaBAGw7YOSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8434
X-Proofpoint-ORIG-GUID: 8MyieedQATDPxHwbhPSUqbUZmsTnAmT7
X-Proofpoint-GUID: 8MyieedQATDPxHwbhPSUqbUZmsTnAmT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_04,2023-04-04_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Consequently, no handlers are provided, and cgroup_file_mode() sets the
permissions to 000. However, to actually use the mechanism, the
subscribing user must have read access to the file and open the fd for
reading, see memcg_write_event_control().

This is all fine as long as the subscribing process runs as root and is
otherwise unconfined by further restrictions. However, if you add strict
access controls such as selinux, the permission bits will be enforced,
and opening memory.pressure_level for reading will fail, preventing the
process from subscribing, even as root.

To work around this issue, introduce a dummy read handler. When
memory.pressure_level is created, cgroup_file_mode() will notice the
existence of a handler, and therefore add read permissions to the file.

Signed-off-by: Florian Schmidt <flosch@nutanix.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..1aa11e261570 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3734,6 +3734,16 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	}
 }
 
+/*
+ * This function doesn't do anything useful. Its only job is to provide a read
+ * handler for a file so that cgroup_file_mode() will add read permissions.
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

