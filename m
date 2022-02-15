Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E724B7B32
	for <lists+cgroups@lfdr.de>; Wed, 16 Feb 2022 00:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbiBOX2x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Feb 2022 18:28:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiBOX2w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Feb 2022 18:28:52 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ADD2C64C;
        Tue, 15 Feb 2022 15:28:41 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FMa14v019785;
        Tue, 15 Feb 2022 15:28:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zK/BJT8ShN+IBm7uvEiaW90Ejn5WUgbfZVHW/0A5CRs=;
 b=EgKsw2qC4G6smfqksf0N6QJdyMLLBQmFRu6/hTH+tJqwB61g3q1r+c4EQOTZ5LjMvcak
 8RtRvE25op4JcYP0ledZms9SThwpceWXJq7VGS7xl/ImYiplxRKFdYYzpK2tNjvr+CMA
 vjpri+8LLo7p8alhn33OddY6gStwEVn/QVU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e8n408a72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Feb 2022 15:28:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 15:28:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlgODGxSQLnvkQY0gcACw/VLDMDkFY8rRCw9AC9vcr2/ACSEybbXWxdNffZaEnzmcghFiMFQ33fMTTIB+njchRrO9B3EESslQT2IuaLqqqNAiWqDNGkpT8Svcw7WGNPIplyFdVzxGbkJrVt3NMuG02SJZ805OvcezV4RrTNkpyCzupxFNtl8aWknDXYFJ+ZnFq836o6k8l96HNfz7cvuCnpA2o/QVTSG/CVHNVilZrLO3ogVPB5sFMW6k288aT3+zEWo1XQEEq69smxkyVWKHmn3GiP5reSVq9qv68HuULVsvxbolOxKYGxyQ6eDyJU3kGiDlNmtFRkaBtsu1MjWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK/BJT8ShN+IBm7uvEiaW90Ejn5WUgbfZVHW/0A5CRs=;
 b=amwfLA7UpqviYiQfke8Zt9++B7lhDYx+eph0yekGMqw1JGP+OkIcBFxsedfzHVGBMPVyHFQPxouacIvwwoGGnEc0VK2UYBbPCHQvcQZTM/MhhwT0NqsyD2TXe9M4Ey5BFtNDTLC3DFDBbF+KTK7pe/vAtWXq23bzRRwoFIJXv6s5f8S93bAP4rf+DGtnNY4wD2/ArbhPdgOs7uinibg5Jsj91LNnFcToi0KQehYy5UX1DX9CQp7WP9xQnRaex4pysk4o+2WokZDCqmBzs8mIZo1lErLISav94OLgsIJqjaUyY5pTQhX5oCRE2lHCH5MLQVCeXJcBiDL/L7yUEyhCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by DM6PR15MB3675.namprd15.prod.outlook.com (2603:10b6:5:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 23:28:27 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c%5]) with mapi id 15.20.4995.014; Tue, 15 Feb 2022
 23:28:27 +0000
Date:   Tue, 15 Feb 2022 15:28:24 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] selftests: memcg: test high limit for single
 entry allocation
Message-ID: <Ygw3GNtOiR33VNcv@carbon.dhcp.thefacebook.com>
References: <20220211064917.2028469-1-shakeelb@google.com>
 <20220211064917.2028469-4-shakeelb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220211064917.2028469-4-shakeelb@google.com>
X-ClientProxiedBy: CO2PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:102:1::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f31da43-9d28-4e1b-d7d5-08d9f0dade77
X-MS-TrafficTypeDiagnostic: DM6PR15MB3675:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB3675473456090E1AD55C2026BE349@DM6PR15MB3675.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /TXzhtY5rr4mpXZ+k40FNu6aFiYZJC7bvzbcIS7ueWTTY5ib52tzUWmGSvF24MQe7kK0GtdHvOIX09Ktj7lTsK7oe+0oKIA/QdRg/+zJJVGt0JUPZYfjEsev86lgHgfqhzwAr2aGhPcSPy9T/F4vFM0m7IOkOHS8LEGJsNyWV2Kd6DzgZYK+38xtjMzu/p9QwiakDhtQ8ySYj/0AnoVB78R6ZtDII8FCQLXVfx0t8fcnRSEWTTbnXAPQTVfLK7qzl3Wdai2vUHtxvgwpeZaF4PlGRQExZO0IkaM2FQmGmOUH4cCd/7bvr0Om+BTHg9buEF3orAy23DYfFMettrYuRdRIosTYeG9wjMI1onNVaLbYUtLwIx9B5oWUAgFWUvsLLVOtBffsMHEt1DvI/jcXyK0axQUxTaiRTOuS+eGx/Jx0cPvFR/REaeOXhw0dBRhlcSYQ+upkpMI0ubd3+O0AoVY+zbP9mzht0sXIq6d97fqXEjXFF9kc+Vzw35IRAT5SopumKEM+YLU0adb2uYW/oiSEXDROvhNFL/sGNHDqO7g9epDw+xOk1MHfa8A/57GcZg6kLYk+3FCzG/Naizqq/IrHamHlFeV5xWS/SfxqJK2eBtfoYH71yutHPC6CgiNvbc8mnhylvzgMzLzqrENe6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66476007)(9686003)(6916009)(66556008)(186003)(86362001)(8676002)(4326008)(316002)(6512007)(6506007)(8936002)(54906003)(6666004)(83380400001)(6486002)(38100700002)(508600001)(4744005)(52116002)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W6Y5rjcLAWw7avospRLzoQoEZSfutwCB11TaExTY0Sbwyr5FjSNepUg9mBXO?=
 =?us-ascii?Q?N462n6UReFQBVZ+vvQuxLqYvbgoSBUsjaM3OhpKjr15a84NDOC1hh3epWa3e?=
 =?us-ascii?Q?rS0yYIX1IfGzJT015vvU7YqeKLYLi+wq/Utb7gLciMWXixvZjr5amkepIL5Y?=
 =?us-ascii?Q?mv/lAuK/dh4N5U/H8Xlu5rvg4lzb+P9QzISHLCPKTkmwOrqUVb7Vrpz1t7yy?=
 =?us-ascii?Q?MSC1OwsBQeVDnb6HC+athwR7BrzN+BFj5wxVg8mYYhNtZWizqTZevjezXG/u?=
 =?us-ascii?Q?zj3dlygCa+qfHdg5/UKTzYbRKaoyloyMOQWZjBX+y49zASaaYHTCcfmnzaaK?=
 =?us-ascii?Q?SQBi8JUacR2HGyXNB3JjswChp8JvxXFU/VYBsTl9q+2sXAnp82+TOhtzXzb5?=
 =?us-ascii?Q?1f5Glw88CZZs1YjB2zQkZXLXfDxHL8agiTTtRPaVFRqpKqJOaSMs7YyYupDo?=
 =?us-ascii?Q?eHlNB4ABxiAO+zeYkUc2jQG/oSdektgVIslVUEi3/on3cgFRX1qXeEougfz7?=
 =?us-ascii?Q?Mzon0ZKEFRQ8/we/Dz8x0fghQA99pXv0hsca2HXVRdr1QlxKBxcUvUDgUJwK?=
 =?us-ascii?Q?xC/C35oWqqHVrFoHOxqiryvP7PrELsqSrQ9J7QRGyAPojPkL+SMeZNg5lvrD?=
 =?us-ascii?Q?8+iP6F/XECtW5x4KGikKzQ1kM19zYVOSQC8rSYyDu2Zj82J5vF7KhPiJ8AqM?=
 =?us-ascii?Q?qZ2YnJgLogEAmIkYbKA9Q/VSo8PuagbtaJnlk8kFxQ2egJb1Mk4NAdvbIGYv?=
 =?us-ascii?Q?IDPWKKWa/r+HVSLz5Jk6zIHVJwsg2w5tqZ/0Gk7wO5uZ8m0s9oYJmWikssmQ?=
 =?us-ascii?Q?9LHrOsW1tUKrgC56Y99zxpZUXfCV6dr9hK+HgFbXzvIHftBv9twKJFsJr84f?=
 =?us-ascii?Q?R8B9ES5acWmKeW769B35Id3VwcX3DmikEC8NKYJi5326lQEtBy10XwDu0+Bg?=
 =?us-ascii?Q?ciJkcZiTEvNGrs+F3MCcNCiWtIXDetieJU6dZFq9IKTou5plKwn1vMBfEwES?=
 =?us-ascii?Q?4hX2w/yjkOrL+JG5k3QdqlZKGwSzmdOtOvi9DvwVfO7n2NusrFK9/bfvgSp4?=
 =?us-ascii?Q?74/lGLJJvxabXLQS7p5+Ltxn7f4PP+jaPHJEg9EeGgd4Szf6BM/WJZlfBVj3?=
 =?us-ascii?Q?KQYrvhg3fvJ9/R8LOuvnAjPFU1HAmmGSON3/ohQCSBWSX8w2f9Terwk1BKtS?=
 =?us-ascii?Q?jqy2xN4WGEdd8VQmL7rcKHTYUHwMozvzxHP4EePAlSeBG3tR6QTDX8F/LryA?=
 =?us-ascii?Q?T8h9e2VugyMDUSVsYq7cIXQukyMvmWHpEZwKeJWCRmXskNY0Wix359O2mHU7?=
 =?us-ascii?Q?o7EAbnLWWkhc8mq8MSMEtzO1AGeAUfofAWQ/uuGUrfYeHY5dYw3jwc46haYM?=
 =?us-ascii?Q?b+lBCvgT2DV0nN5epk92mZvrHTeK3mvyrAudrjpFZl63DNl2flFJxzSCMEPp?=
 =?us-ascii?Q?lhXMstdB3yv4kgKOz6IuvgMVPub3N211agMQ9fmU1KEoSbUbuas7sOmlWSx0?=
 =?us-ascii?Q?dz0pW/EtzNuMOYz7RX30/9AGzomDXXSneQvWLrj9CfCt/NfcgPJwSHvSg6Yg?=
 =?us-ascii?Q?6TqHFlTIDb1Y4oh/qs48A02CkGD7nQwq/j9zlLj5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f31da43-9d28-4e1b-d7d5-08d9f0dade77
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 23:28:27.6974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KF9vzL9bon/etBEMaJr7D9S++9gFxsEGIdJBBOV0O1vX05cc5ngNDZR5oGvQAOYW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3675
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: d9NDBvVE_DOQCdkFbw--BZh8JjaYgpfX
X-Proofpoint-GUID: d9NDBvVE_DOQCdkFbw--BZh8JjaYgpfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_07,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=912
 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202150134
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

On Thu, Feb 10, 2022 at 10:49:16PM -0800, Shakeel Butt wrote:
> Test the enforcement of memory.high limit for large amount of memory
> allocation within a single kernel entry. There are valid use-cases
> where the application can trigger large amount of memory allocation
> within a single syscall e.g. mlock() or mmap(MAP_POPULATE). Make sure
> memory.high limit enforcement works for such use-cases.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
> Changes since v1:
> - None

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
