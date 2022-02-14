Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E714B5C51
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 22:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiBNVFM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 16:05:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiBNVFG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 16:05:06 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9954D1070B0
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 13:04:57 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21EIZC7k029498;
        Mon, 14 Feb 2022 11:45:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=H9Wr3/ezBw+hkMKpSz7vAbosRvhJOzjVmePT6r8jr8I=;
 b=rW3Z6sDy8nwktBL6e4z/uQnOBuxr173BxSAAfSTIrSBFAlbiFq260XRVuWid5OHZ14/T
 uele2ELjQljOPMAk3jYSLAtCSUtngVTmjA/5nQ5QWvza7dGR+GQ0lPmceplC3t+h7NMi
 lD+FxKOcUcA1BrOC0old5eZ63OHqMsEV+iU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e7hv54kye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Feb 2022 11:45:32 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 11:45:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wuy/1+oPEhJ/0HDmyUDQ8d1sbe8Rcn27ujR3BaBK1FR9V7mBQtvt90qp4AcPA3RNFCRUT+mCBwCfEHCAxwXPKudhUQL1R6CqG+x0rboT9AVRUa6fFljPCKn4Uo/bdnhg4n2G7UT1WG1j+zkGpxnxKDzjtYXeOkgMY+SlaZPVPGP43v3cE0Y3GJbaJj+HYkptNcYouMeasmJnI1a8K1icYVdrngY1CoaKo6ylN1DomIlyMqfdnBvEwG55ueXUrTmynSXxOa9XfJm6JkPf4Iw3+JMNMB76tFhTEx/n+TtvvTuI2xSuDSu/zIAW1oHoudNhpUYnMFfa6ST4Gx1QpXxJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9Wr3/ezBw+hkMKpSz7vAbosRvhJOzjVmePT6r8jr8I=;
 b=TdPdRTUxqSoKGlT3CJkJ7D3Rdn4bX567DRxjTqhrizT/N/gNMmjmGtpFxCxHQ1AJHY1azx7RWQ0AD6ixaOUIco+OdfMGijC1EvO8whz2cC1uPkvZuSzVmx1/vgo9vKmCUzPLH5lr2l3s0yO4PEo+oM90hfcBY8/vp7oMTVSLrVU95PedWpTOWfrFeNm+dMj90zwb6r52AXre1jwS3s3CglFYWg8FWRitkRu7lRGKScq2VnRaAInugufRqu6GbDzcGoKlF6L6JO+YpFk66fkdRRh6MOH4DhsRL0u0LkAl42Iwa3vbIkRI9PGSMX/HfPt+dasMj1e5zJdBziiT/yq8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by CY4PR15MB1287.namprd15.prod.outlook.com (2603:10b6:903:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Mon, 14 Feb
 2022 19:45:28 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 19:45:27 +0000
Date:   Mon, 14 Feb 2022 11:45:23 -0800
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
        Waiman Long <longman@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 1/4] mm/memcg: Revert ("mm/memcg: optimize user
 context object stock access")
Message-ID: <YgqxUxM7SNX2QLuM@carbon.dhcp.thefacebook.com>
References: <20220211223537.2175879-1-bigeasy@linutronix.de>
 <20220211223537.2175879-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220211223537.2175879-2-bigeasy@linutronix.de>
X-ClientProxiedBy: MW4PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:303:85::10) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87b695cd-23ad-4297-c5a1-08d9eff28cef
X-MS-TrafficTypeDiagnostic: CY4PR15MB1287:EE_
X-Microsoft-Antispam-PRVS: <CY4PR15MB1287A8E838E0C7C1720B4B2DBE339@CY4PR15MB1287.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AE2AKA9r8jvPQjJ3koOPVqxMPrjcuJ7WqJHs7T4qpPUsrba5jT5BT9Ca6Zd0W6vb9mSqW33mhKI/7g1AeDcwn9u9cJKZb3xZ1AD6Ctmj59XiyG8dCTHhdcfuDLp3jeUaFLTpyYyASHfRrYkrHmRLvMbfSO8T8LKfF1DJxhabqqlzF+AYaLJCqM/D1lmMirT3FEAp45z+nUoxhYtBMoggdshQpLDqRyLc3WcFV5dbhqG2bU408iDJtIW62ydvyF18vxQGcaNQVn7ZHRCd17Ubp7snE8VxnX2URmfYsHhm2sRVSaC5RVEX6BqpMcRkgxLfIJYYtFjAbrp3ttc95xo3LgoQ9Rb/XUmWYa9IkDh/lLHw0SVbTjjiyAA9/eKxth4Cj4QGZ4JNtEwc935YOdOq1YfisGuiCkOx6yKRX0sqYLchlBN/p5RGZ1FFxd2DnvAtslQlb1K/MwgIajlxzu8PGNePnVuMGKVv9VLLkY8h60s58NmPh9t957oN7znhgSjJU5//Ag9qfHCRu72Xou++lCdAJvZ1CVmvFO6uQTWNapUp5jv3B/nBoOwCbqecHf1uE8sUSvZ+Gu3hoICOALokf0Z8jqdVUyDXP63M+RF7CUulIuqCWR/wItEPetwadmrLkcxCO77lE2kJ6D7sZB3eBNoO27vDlX53CY4ma4eIBCvpTJTIDDgcSdAdJO0Lef0X9WoVf7v/jNCLSiuZjqmpZTePxyynBJUhaHkl3QHoyPNzWX0k+PI+Lx++OKjOzRsKSJQy5kdvC4vWhntAg7p/mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(316002)(186003)(66556008)(6916009)(4326008)(66476007)(8676002)(66946007)(508600001)(7416002)(38100700002)(966005)(6486002)(2906002)(86362001)(6506007)(6666004)(8936002)(52116002)(9686003)(5660300002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYbZ3fSYBoJtGk9AGAkAOqOzHTT2u/y7H8EqE60lrQWbCoDOkMaaXGJBNwVb?=
 =?us-ascii?Q?1duKq1bbBARcYA2yZhM+VcW0dX+Vd00VzD4ceOECoGasD9wtNkHNUWvEmN+2?=
 =?us-ascii?Q?X3wn/33wtbbi/FzSKryUkVdQ1wAs1TcL/ST8Shi+9V7qijg9S1mJ7Mk8hOVA?=
 =?us-ascii?Q?AQdDD0W7nIoISk1GgcJEiAM066vAQFTYwSokKDV6TW0MKQ6AQ3by5bHeml5c?=
 =?us-ascii?Q?DXSU8ZshxmRFzfZ/6iP575T8paiyqFlTqoI6llb/siVcef+/RPa8RcaieRsE?=
 =?us-ascii?Q?o79QBLBMVOHRxxl8kYM6zh52m4/SHaEKt/2/2Ktn/onTktekVjttCPUkW475?=
 =?us-ascii?Q?bGH7oN3qXr43BAQbeoE2F2W3VYxRH8Tj9FmsYxJtOqcRtaDclMcdEtJN8hoV?=
 =?us-ascii?Q?hhWY9GIgPH9rDs2mXHmkdzkSYbD/RK6I2+feO8v3aGKwFvBEijwhWu8etBgz?=
 =?us-ascii?Q?Ftc8/HCQKeUZSVo2JyFhDza/n3uXE9VeCPmBoOuazIk9X8gLiYrTyWV39kNT?=
 =?us-ascii?Q?HUqOlM7jxClF+wnPpFhoR1ElcNkZ4X4upKxjuqcJrKHiPKPA+Xi+gLdwYrr1?=
 =?us-ascii?Q?E5JhBAi9Mp0J2QpLdmU4eBNnZPf1oL6YxdtVOQMYNoH0LwyIIa0gaeO/En9Y?=
 =?us-ascii?Q?SIajlKNFXfpqhSBydOFGumVx15Nar+92vHr9KR4fS6h2sMSYKIhHWDMv8PMr?=
 =?us-ascii?Q?SnN68Pe43xsgLPUdr1FBn67ONrTDBgnbkZtXGJNC6NeNBI+yX6bttCz5CVPP?=
 =?us-ascii?Q?Iq5cvOnfTmBLVALHCqwk+fcsk8if1331El2ZxWmIpFBIW5tEddv1SMOPTV0b?=
 =?us-ascii?Q?kCpylH1ASwYFN0c4tYPYYesCuk4WlbrQ7/EQkAWL7Cr3IsjEBgTZ6wRYv9C3?=
 =?us-ascii?Q?L+Jt23iEdTX8hxAnuQjsK+7Y9BGNm2EI/lZVlXgk5wzOvwDtPH3c7bLb2/iu?=
 =?us-ascii?Q?MaLHJ528PbIlWi39Wl0RuLSeUf7IXAVazdPKQkzCyPMpzgHTOrvKSHwxSFwA?=
 =?us-ascii?Q?8kJPnSDaj5kgvgIeTK7sa8YAHCqu5rtspMuMBui1BrxKPATh4GIHm18vY1nR?=
 =?us-ascii?Q?oFgg33ZKiOvCNlQlw+4WKkzEHu0SnyS948c6Dr64ljh9GAokCImXzROs7X/C?=
 =?us-ascii?Q?qO45YAzy2QN/STziu8ry4KCPiO0LAuaM//ulWWS0vtIjmz7kLy96dyX3IAV/?=
 =?us-ascii?Q?fNGbovnf5oqfLd0jKODXYSUbQRFgKuCzLS9czL+OVZWjUHZ8zCxW8KTPCrh8?=
 =?us-ascii?Q?EXKkOgmwZtbiC5dlVVvV0V+WruE7nNkGfdbNezHjr7e70g1zFfZOy9mqHICC?=
 =?us-ascii?Q?8cUJ2eND1fEveXyzjZ9Qy/INxibocJR56dzh0DJD7j+pkCiRbvwnv+CPnjXE?=
 =?us-ascii?Q?ZpO0cIpTFXFV30IjU0C1P6Q4WybxlzyPAYBtqyRcxQ2VnflijWlc4+ibAbN2?=
 =?us-ascii?Q?tBBU9AF5UUIoML4jaV8td9UXiph2O+e4vOKKIEPMBTtO7rIn2qr3hnogH9xm?=
 =?us-ascii?Q?f4abK5DvBc/xdQT2hQLwBYBjkliZUN7xUI4DsHTfQP0TiMyW5NGrtRzrBVgL?=
 =?us-ascii?Q?FKcvHfr6exFaApxJVyLbW7Phug7zfjNTQ3OAwk1J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b695cd-23ad-4297-c5a1-08d9eff28cef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 19:45:27.7314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YD2DU+8e9M040gKIrNm6vhNH/k+69mZSKQGUMfrXAKhIqi+GcD9qGUBSJBmyTmZu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1287
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 37VTS7HsqcBjMuokic4g1_d34jyIt_mC
X-Proofpoint-GUID: 37VTS7HsqcBjMuokic4g1_d34jyIt_mC
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_07,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 mlxlogscore=828 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1011 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202140115
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

On Fri, Feb 11, 2022 at 11:35:34PM +0100, Sebastian Andrzej Siewior wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> The optimisation is based on a micro benchmark where local_irq_save() is
> more expensive than a preempt_disable(). There is no evidence that it is
> visible in a real-world workload and there are CPUs where the opposite is
> true (local_irq_save() is cheaper than preempt_disable()).
> 
> Based on micro benchmarks, the optimisation makes sense on PREEMPT_NONE
> where preempt_disable() is optimized away. There is no improvement with
> PREEMPT_DYNAMIC since the preemption counter is always available.
> 
> The optimization makes also the PREEMPT_RT integration more complicated
> since most of the assumption are not true on PREEMPT_RT.
> 
> Revert the optimisation since it complicates the PREEMPT_RT integration
> and the improvement is hardly visible.
> 
> [ bigeasy: Patch body around Michal's diff ]
> 
> Link: https://lore.kernel.org/all/YgOGkXXCrD%2F1k+p4@dhcp22.suse.cz
> Link: https://lkml.kernel.org/r/YdX+INO9gQje6d0S@linutronix.de
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
