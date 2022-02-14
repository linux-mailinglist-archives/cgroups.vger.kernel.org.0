Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CD04B5B72
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 21:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiBNUpu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 15:45:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiBNUpa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 15:45:30 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B599E242FB6
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 12:42:57 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21EIZSLP000859;
        Mon, 14 Feb 2022 11:46:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=kp6jXOEWknOWNgnpUOx3BYl1M1+KkCwo+I5QKInsF9U=;
 b=m3GzsayCxUahVgZcNrBR6i2eEbfu+gFQRburn7nb+7/3DVkPw1g03oCZ8YEnH5M/z3M1
 Kp2Z8D2Hqrq8qOjZjbV9HFGfTxaRsE69SwzMMVaQYVlFO0GQ+jqvx5OmetYBZ07UxWnZ
 E8IiCX4+GM4eVmMtdSVvJqfpaMPvf1wnCSs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e7dm2djpn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Feb 2022 11:46:10 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 11:46:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYOaYdv36ImPdBfjjyu3ggNMt2WkFceIb0csBNAj/ljjhwniJc7DLezmJIdnZ+2E2PtEZZUCZhfkQM9vsU4V+ZJgW58vHvfS+t5TVw1hcEbGsb9IwRac7OsKMJXiIETFmKwhcgYiuqsnnepXWVP14+7Ci4aLjkwuogL9dImrfh2H6eABH1m3VTLv9cu1R+jwC2XBRB3NnIq3/CiXeLb2zRXHL2DCc5bdghYEIdJLiK/dG0ndNZgsX7VrS3+Z/omkUtk3kt+YMzHpPvO+WbKoWqXKO67IoZVT6Vg0nQF6woFptuS25cN/7U8fzgORY1Mu/Wkzrv1NQuUd82Y+74R6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0M3fYxD9E0WmLlhUQtDBhxEmWcy2E13kkHah+NM8IE=;
 b=kIhgZjxM86kofVeL6pZ6vynC0qgV/N/aPHsp1ba/40rfC8xeaH5okgs0POpVGCf+mwOEIlY5OibcDp2GcIsdicojG7QxEehszuPUCQcqBaMQdrwZYWn02/CiIO6xLz7Ck/RB26gAskn2makWoz/P/2O2woAMcWLetPN9S3KQdNWmx5kzH71I1bsaUN65CN/kjR6gVQS9EazhqdegTFUsPlt7WtbGhtGLPPjxRUxsdNeDbYDhfqwqLK5w8XvypleHaMenMYOs/5CgFulYBOg5AlrIqjbq9kK/UO2YzQPq2KW78P2hfxvZ8drSX35Lj6WGMDD0PTMIFF8kqTd4w1cOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BN8PR15MB2578.namprd15.prod.outlook.com (2603:10b6:408:cd::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Mon, 14 Feb
 2022 19:46:06 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 19:46:06 +0000
Date:   Mon, 14 Feb 2022 11:46:02 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 2/4] mm/memcg: Disable threshold event handlers on
 PREEMPT_RT
Message-ID: <Ygqxeq3UmFNrZqjP@carbon.dhcp.thefacebook.com>
References: <20220211223537.2175879-1-bigeasy@linutronix.de>
 <20220211223537.2175879-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220211223537.2175879-3-bigeasy@linutronix.de>
X-ClientProxiedBy: MWHPR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:300:d4::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d2fd1a6-f47c-4755-9432-08d9eff2a3df
X-MS-TrafficTypeDiagnostic: BN8PR15MB2578:EE_
X-Microsoft-Antispam-PRVS: <BN8PR15MB25780889F74C524F4AF9709DBE339@BN8PR15MB2578.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BmoX5IoUs3cHX3Xox0IpTuZbX7/SyMGfte6WEkCxBjZeEJSeJ6cdlfYbuwMmV6/ntSgyPei+gyovJT88I/te3IEk+Zy02ECcKRAkKPyq0pRNFOUYbvBGQ7e+OuPILLjpwoqe5238Dfy8pRa5r9yJwFyg8xg+Cu+szFmV+SpDAQMeVLwpR9rpnDgw9HZYLR7B+eBAgDn5xOZyebfxii5fmG5DUU63kzy5zRBRvRPuILif8cOSFpxqFZ7O26OssbAc4j8MuV5PGz5sJ3+XZdERDN2JghpSM1OYjXidwE5TsgmRhh9AStA6tcdqTRqZxsIFWlk1C0i+YS9/znoDrfvchwhbk32NyA1lh8tJGd4MEqJ5xFImrnOxshGvPxwrOoXmk0JCU0VS2QEa5gJQDgNfui/1jBkNNvJlCxwM0ILPmjEbBjXNh2Dg9k6A8C5m4b/e33a941s9H6RbgBTyEYVPs0JT3Hw4Bq1a9YHFrqLGVnjCaNpEscnByjUrezgFlBLf5ElVUeB/UUUzs42NYMEnfZVq2YubwfXsOwmT2An656u50VSQJrmX+dVvnEouQjg6/9yiQKH4PTrtV7WPAPRrxCJY6G9R+inPiARIwTLBnwuVeu19ICBZSe+cgeFYH3lUH7w2fkE4nJHUXPU5XrpXMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(66476007)(66946007)(9686003)(6512007)(66556008)(8676002)(6916009)(54906003)(508600001)(52116002)(6486002)(86362001)(6666004)(316002)(83380400001)(38100700002)(4326008)(8936002)(186003)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?toirrM7TUiGTIosHPZOx1DFDEGiQPMcrErrhR1Xk/iP6ErExouYP9Lx5IF?=
 =?iso-8859-1?Q?QuBeUhh7rlwo/zltNZjg/p14I+wHtgQ+P0wisPblYOLmzYpLwl4xSgRDvD?=
 =?iso-8859-1?Q?rT7yC7iM6HwFRXW/OjIBDaJsH7R7ml39PAdMnyNWBmzM0PY7MCYt3vqHd5?=
 =?iso-8859-1?Q?6mg626bpR96cKiHp7Doe23M2xAjeAFZrPWYq0GkLSaJl1BqWN0CxDnZGiX?=
 =?iso-8859-1?Q?GBqKka9l93HYu2ey10Hodp2utGDlvJ5dJY74x2SF6rmn8ZhmGKi0ityCAd?=
 =?iso-8859-1?Q?1jhdjubXBGUaAeny4wjQayn2pEQrAxdgK4CkOafP/eG/a+JAKHRFyPG9yO?=
 =?iso-8859-1?Q?qJtPkiQq0OrIKUEpWoJIhIXMcQUtQcrfhOWGwMcKRzDxopSJGZvAm4LKJH?=
 =?iso-8859-1?Q?8yN8OMClJ8WV/Uu6qfQna1soFsbFySCH7AVySrABzfOUV6zM3dqT1x7tN7?=
 =?iso-8859-1?Q?vRZtxnwuBG0eeSmoN6F6Pnk7Dxdutvli/GzmZrJkRn847VBDDdq74QkDl9?=
 =?iso-8859-1?Q?Jiqrn7M9MRMSmULXv/uKCkjWkm8AUaHCUmvdFIRsGLMRVqy1OGKF7CI4FI?=
 =?iso-8859-1?Q?I0dIkWS+8t4aa8A404gGSmKvizwaCKDLy0PXlrK0pbGoVrlHiweKcpOwfz?=
 =?iso-8859-1?Q?0pO8onNEeIOT7rlr+BMMPSycwnLi8vr2ZK1eaOcmo3VP6i4uwMBlsx9LI3?=
 =?iso-8859-1?Q?VMFfvJOWZkDhg6n83/K5P/IIVXGBzqoaNv8/VFqJERcvi1lQh+nnrJYbNJ?=
 =?iso-8859-1?Q?vuPmHiupUmTtrzsGIzrSx5WY/RPnZMQcD4gjjShCX1NhzJ32d3ZEpc53Dg?=
 =?iso-8859-1?Q?D2/YfVoPldwQNOwcLmBHhK3sFSRLZ1K1IM8Vv79VKRlZpPK6L9aLh1/aOl?=
 =?iso-8859-1?Q?7dHoZ0JF+3QSDrvXDaw7FgFllJ6Y71k3iOtGerCRszyVAtr3/UJlM0R7Sf?=
 =?iso-8859-1?Q?FjRvAWpgn9OuHmULd6H+hO4j7Af/VG8U4oMTNfuv8M2YSeOwmFGSVxDU9o?=
 =?iso-8859-1?Q?+3YaprqLOsUN5pjVG2k7GpA7n6XpZk4ZaQ4wVLGVaJ1NAJplTrsM7+uRfS?=
 =?iso-8859-1?Q?2ueHB9Me2sAIrZIyWcpKoDw+ku5RMjktUEcfoU2GMiJ7cBXAOMhdwCz9lH?=
 =?iso-8859-1?Q?OG3d2OGfskyZJu8DXI5DU6Y61VPUfzcBJ7sc2XYP0Zwf5ZZSU62ZwWvXh9?=
 =?iso-8859-1?Q?HtZtWJzQywTn6AgMYwUNjE3iWGuWgchSH7NmB+DjHKDDPmlK1AV46h+PjL?=
 =?iso-8859-1?Q?OV93sOfQtsISKq20xh7l3UH4AgZl6y+6OfK0QyCc1Et+bdoBjgGDUv24WC?=
 =?iso-8859-1?Q?pyM5cRokfoFi/L1IhVWUmCw9teA0mY5mA6Mmo33fJtULWd/Fd7tj4zdgu8?=
 =?iso-8859-1?Q?IHtfblzDJG9ziIXPODxw3LRHYJ0eF0MXN+Mwo095iG+vgzZp7wITCfc04Y?=
 =?iso-8859-1?Q?XWePLxNdlr6F8YHGazXzqUoilT2WEZ07wHxt1qDFNdTLCc9hIjNVBSEClr?=
 =?iso-8859-1?Q?CfxUO7PGFQR627z/LyiyByuXYTMYlbh74ircRaothREUDNvEQodgR3uCTU?=
 =?iso-8859-1?Q?WRjECoqvKqPaZ5y7wfMh3dPL+ljj2/9yoD6zILj9KutxFim8GBMljSrEZF?=
 =?iso-8859-1?Q?7fKPSHEyBHcDOFIHlPLc4Z7OVsD6jYpsAj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2fd1a6-f47c-4755-9432-08d9eff2a3df
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 19:46:06.1504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZGRSxkbPYAhEVMYHwdWFgDKpDPisHBo68tzgtXqBHpwoMwFggBYO8Z2Vf0rPbw0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2578
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: DBA3R_e_-oabWDNT7VhqyHwQCPF2Q_My
X-Proofpoint-ORIG-GUID: DBA3R_e_-oabWDNT7VhqyHwQCPF2Q_My
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_07,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxlogscore=364 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140115
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 11, 2022 at 11:35:35PM +0100, Sebastian Andrzej Siewior wrote:
> During the integration of PREEMPT_RT support, the code flow around
> memcg_check_events() resulted in `twisted code'. Moving the code around
> and avoiding then would then lead to an additional local-irq-save
> section within memcg_check_events(). While looking better, it adds a
> local-irq-save section to code flow which is usually within an
> local-irq-off block on non-PREEMPT_RT configurations.
> 
> The threshold event handler is a deprecated memcg v1 feature. Instead of
> trying to get it to work under PREEMPT_RT just disable it. There should
> be no users on PREEMPT_RT. From that perspective it makes even less
> sense to get it to work under PREEMPT_RT while having zero users.
> 
> Make memory.soft_limit_in_bytes and cgroup.event_control return
> -EOPNOTSUPP on PREEMPT_RT. Make an empty memcg_check_events() and
> memcg_write_event_control() which return only -EOPNOTSUPP on PREEMPT_RT.
> Document that the two knobs are disabled on PREEMPT_RT.
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Suggested-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Roman Gushchin <guro@fb.com>
