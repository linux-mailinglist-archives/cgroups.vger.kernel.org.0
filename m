Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668B64BC019
	for <lists+cgroups@lfdr.de>; Fri, 18 Feb 2022 20:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiBRTID (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Feb 2022 14:08:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiBRTIB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Feb 2022 14:08:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF12D116D
        for <cgroups@vger.kernel.org>; Fri, 18 Feb 2022 11:07:44 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21IFfJdA023816;
        Fri, 18 Feb 2022 11:07:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ZEPyC9f4UuVTJzjbRKPP+Irqsg3MmM5Cprc5Xn9MmSc=;
 b=P/3MqhP09P1wfgvtUo8OqThCYldtJOeOWTrjDvyjwsZ+Sm1X6fTJ7VhdteqHaB0p+byb
 NahV2V0TY6FLwyov38g7rJ1i7iEQ59RhGTvj2OuaezpcW6e1/vH7QtyRom3joIirI6qR
 H8HLspyTms58ocqP/9kITK7v+pT4d5kIDgY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ea1mp5cd3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Feb 2022 11:07:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 11:07:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBQeUPT8DETXvFaAferV06/Tdx6n2LSsOU4+sxKjiTPZ0r6e5puzaIjrvtGyy3R7yfTEWQrwF6UvP6EK8i1kcOusWMX+ZP1H7iScFf56EeeSMhcM6mG0HyPOboz9KeMP+EqaWnAcEWB/rp35JsVAbLvJEbHkdeLjbAaZ/3FPU3zKT4hzms7zdAnrXSC5u4gmf1QKGIDwmkF1YKLQ1CgsDdySWrtysy2f3NfXyZXmTqJSIESDOCMiykCQp+l/RwZGHvGl1plYd5gWeVP6Mc9r/SH0GyYiXFjrP1uHx7JCg5ols7eoSyjqzMOiBQogjky3Mq2JDXf9lgbdrBolWbJJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEPyC9f4UuVTJzjbRKPP+Irqsg3MmM5Cprc5Xn9MmSc=;
 b=UE1b8iVfl5m09G6dE7x8jYkq8ALptTJCxLofLON3VdI0x24nD1C5xp41fOhdKTHiobevePLwmzjo9uXcITmE1uyYHX7bGGqTBJ3yChiUY6qKMtR98xiICIt53iovZhdRhs3euFeR0HjOB9szoVaH4Tfn7p+Y0h168GY1NBlMj5HONbHxY1wIt/aai/RPD+iNci0j0yCSvTnTYUYgP5HFDLz9VpVVofxtjLJZKRTOBNVrvKhuDGTpDpwWqgzS5rUGwz4AjfWTQityYwwdJCcGHtkdHxLkKywzsYa0sfp5/m/f0fKvn3Qepr6lP4ef1InXUez2O5Jq5UKg/Hb2Dy+5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by MWHPR15MB1392.namprd15.prod.outlook.com (2603:10b6:300:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 19:07:10 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c%5]) with mapi id 15.20.4995.014; Fri, 18 Feb 2022
 19:07:10 +0000
Date:   Fri, 18 Feb 2022 11:07:06 -0800
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
Subject: Re: [PATCH v3 4/5] mm/memcg: Opencode the inner part of
 obj_cgroup_uncharge_pages() in drain_obj_stock()
Message-ID: <Yg/uWoP9OMteS7ZR@carbon.DHCP.thefacebook.com>
References: <20220217094802.3644569-1-bigeasy@linutronix.de>
 <20220217094802.3644569-5-bigeasy@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220217094802.3644569-5-bigeasy@linutronix.de>
X-ClientProxiedBy: MW4PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:303:b6::10) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee73fd6d-abba-4ba0-6595-08d9f311dd58
X-MS-TrafficTypeDiagnostic: MWHPR15MB1392:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB13921CDAF393E1E2069D301BBE379@MWHPR15MB1392.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDKpzjHF2IiNRAbfV7KO8E9s6vPUoOTc+TRIZsD2kfxr4KgHzDvcpNE1+Oi2CcVTTbEHG4rFGARAGwEvm/yZeTWvMGBuDSQe0luO3L89Mtqio2BTPArgZ3GNARfpLPK0Hto2GAhb934mdKkKIW0zXlyk56dcEHNniHby5loY2Nms6BgB+je1VsHgQPPG9M5FSO6UXGLvSrtcohJPfY72Z6QRmHjjS9qC6aPPq0kPPJWZUP+PqK9AieImiV9qHNN6ppj7u+95VjlR41NN8qG+OddUffahh5xm0Wh5Ep37opUMuFTa6jI82tSpp2tEHAyenEtuHUq6tdcYnaHZUTg1qZmdwVgtS9KbgY86GZZtLdrbma3HvoJWcNcLN9Rm8qmIxAo1IPT7p0rbUfUz6hevVbCWJebDFMAZL4c2qKr5lV3uFR+rSGjXY4nIowVpkUADwTzXxD7LfKmbfohLlKhzBIw966KiUDouIQWdzg4S2zopASFf/sLB1MYlw5lF5HB9iy/o9XASxosahvpIdrMazmz6wLFahOSm7WN34O9ZuUl+8s1GRlI4J331ovbdsnSXeDO82XzqDtKPae+PDgom8PVnM4q5v+w79mKW2QySESVHU5PLDJwODukzxFBmU3ORd2pehrXNAqZg9pkQn5eGdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66556008)(66476007)(8676002)(4326008)(186003)(508600001)(8936002)(83380400001)(5660300002)(66946007)(6916009)(6506007)(4744005)(7416002)(38100700002)(6486002)(6512007)(54906003)(9686003)(2906002)(6666004)(52116002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EqDfqlNS24096MOcqX1DBr6/rx5vMcOf87bnpEkD3brPhd8XhUpwiSiDy+NR?=
 =?us-ascii?Q?sPXrC6eH8zyAmgr7pcxa0+QjbOBnWET9AwGxir8jhrlfRnIsxJ4Y+ZSQ1721?=
 =?us-ascii?Q?7D59g6yw7MgBPHCTLep6IbgZespRn6vegeGSS0SwI/8MP22WLlO6huaF1wtC?=
 =?us-ascii?Q?HhfnsHVQ2vuTL7b8chubQRw0pSJ4ECF3GmBs+ByeLNLgkO7F1TjAazcB0sX2?=
 =?us-ascii?Q?TL4xk4TpH9Ttt4dCCV5xn64oFo6shpRSOQdRQqIUMNa5XSAHUEegcNBBlJgZ?=
 =?us-ascii?Q?vCi49Gc3byVAcVQ2AUoKRp4PqLZ91/Wp5XGNDcTmaTME2dcbcId8YfyaVPoG?=
 =?us-ascii?Q?iJaczSYjmNKToePdxGsHOZQz3kC7aEAOhOsT1aO/I5iB6ahq2hNJv1LOnhb3?=
 =?us-ascii?Q?Q6RHGMpdTrnAbO6+e0CQjeJbozQUXxc2nmOWWdEVaSFvxeVgx5DzbiGkVtuA?=
 =?us-ascii?Q?bcrPqcx1wLVyUjlegLW5QAsTg1x1s0+N4e+m+iMSsq03tfVvANHqlEQkWc6R?=
 =?us-ascii?Q?uF7xoX1mnqmyxBfaldar8w9Fpfz8Sf8iy1UNtIRoXyAxZK4NvqNhhcKJeqeX?=
 =?us-ascii?Q?BwHdTIpy1DiZ9W3L5RubKO5V9ev2sSRza8aCzUG03pXGH6Pex8QWqFIi/qxR?=
 =?us-ascii?Q?n36itclCwW/umOLeakZPEou8lC9j7jnZBY2ZbLGJtcKhaV7RM4/29Yiaz3JJ?=
 =?us-ascii?Q?/kJpX5g/IxsBwRe1gyizky/NEUNZhnEhZGHCnNX/fiKyc4slf3gmbKwUyytv?=
 =?us-ascii?Q?Lgq7eNe7V2E0BU74NDSlsZMut/TUQbgBS3jUJJ9EwjnBng3Jls2slU/PyMZ6?=
 =?us-ascii?Q?gSbof8eNdyA6+SQlwoVqxg1wX0TvjLDk7t6kqgvIGfiQDsDlTUGaMhCRVM2H?=
 =?us-ascii?Q?EA6bI2tmMxQzrE2wk6fzg4+NJF7Buw5G5WwZCKiwcj0npW9XAr1b1jsZm5DF?=
 =?us-ascii?Q?rB01uE4Pxv5zCluH8NYP8O0UXJ+Hn+iz3JAGGdoWizYDjyY7lOV/yBuUmL/v?=
 =?us-ascii?Q?Dp1pt/qFXicujv1Zng+APlgFI8/IfHx6DZ6cAooufEUamKxW8CMkUrdrlLRR?=
 =?us-ascii?Q?CAc572RzCeTtNH7SDM9nLKXoDFF4DFB1dLCIRk7ecusRi+d2f3W0ZWzifpXj?=
 =?us-ascii?Q?/wLqUuOmTZnOaoAIOZVGZnlU8i7ApQjIns7uDh+R1i2WXVk139RJDpWtvosD?=
 =?us-ascii?Q?Buk/1NyU9P0/32SCl3/ykkx3sl3xeXRJFB03BJEkbL+BcFmSynbCtYYut4ES?=
 =?us-ascii?Q?CUc1aVz7FmrUURI45DK+isC1+pPAiAnQu2fwbmGD/9j87VfCC1yN7d05VuKb?=
 =?us-ascii?Q?81TjrB8pKSZy3Q7RL2r2RbD3kwu580KBdAwZ3Yw2t/52qJA1700inMwq9Ea9?=
 =?us-ascii?Q?yOPcS6LdBcl8gfVjG3kr0YzG6cfIDmmo6PuXJOldhOnjbaRvnoGLBoZqGTTF?=
 =?us-ascii?Q?yoJrxgXqa4c6Gh3BwrZuLxwuOvjVbiwaqpjeRi0SeCJbU2sb7PmLaFaKfo2l?=
 =?us-ascii?Q?1AsdXCHwCGfjInveQD/yPiwhuYTak/0eZrWDjeE8TGFfky47ZWbLpcXJXm9s?=
 =?us-ascii?Q?egrg5WKehakh2jcNzo0Ke+HxNH/FZhk7+78+Z149?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee73fd6d-abba-4ba0-6595-08d9f311dd58
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 19:07:10.4905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEvt8/qCdtjV07SPnoobe4+rOzHr402vbfbaoQ14CtB9j1K15DSCHzUPVISHHxYy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1392
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 3v0_wWPtWxoCUnBDvD3KEyxj2hH-7QxW
X-Proofpoint-ORIG-GUID: 3v0_wWPtWxoCUnBDvD3KEyxj2hH-7QxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_08,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 suspectscore=0 mlxlogscore=624 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180117
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

On Thu, Feb 17, 2022 at 10:48:01AM +0100, Sebastian Andrzej Siewior wrote:
> From: Johannes Weiner <hannes@cmpxchg.org>
> 
> Provide the inner part of refill_stock() as __refill_stock() without
> disabling interrupts. This eases the integration of local_lock_t where
> recursive locking must be avoided.
> Open code obj_cgroup_uncharge_pages() in drain_obj_stock() and use
> __refill_stock(). The caller of drain_obj_stock() already disables
> interrupts.
> 
> [bigeasy: Patch body around Johannes' diff ]
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Roman Gushchin <guro@fb.com>

