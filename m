Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B08C4B197B
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 00:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345675AbiBJX3i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 18:29:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345643AbiBJX3i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 18:29:38 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7230455AD;
        Thu, 10 Feb 2022 15:29:37 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANSZtY007913;
        Thu, 10 Feb 2022 15:29:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=LDxavjBAtLlIiuVK0anxtJ929PlDwlRJ0qoJxwiRFRA=;
 b=E3IWEAzKwV+YvGSef8OBPfY5wm6aB/B1VKKS8et+XNkpnBZKVz9DiOY5WjdWnw2uipCt
 lilLZOP2EtkRbpM056TFAgB1Y1r4WBXxbflYQXZcep9Yp0jPdUIGJ5kbx24p97TA/cLc
 C/1uZFtkwyyVaD5xzywgEAiagoZbmkHU5Mk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e58y9sern-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 15:29:30 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 15:29:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/f2XXCRO9ncrfEniRLaz+2pbtmpQ6YQ8Gt5zrNX6nwM5R0lLBw8fe/iSJhUpwE9dYp+u1NOL2ucjP0rqaS1sa4No78wQoFend0M+2y3xEn131uCQYjhwQ9BgnODNZ/xZg8lZS81VlMbYueoDO6eiCofaci7PtEfnRgdCDlY0JLrwwlSyXjSDRga1YKfVnKg5b9BmCn6dYqW4Ec9eB5O4bdj8zjIRdLVLrVq0/PSJnVoJBmrzphnUyi8MRlKRqlN6WZafiPwvtnrxLOUinr6lB3jYGYOE0eHxlWp1aUUqAF+lK9+VTlupaFQb0je7sWSYcjs30Zxn2sGgayYC+DrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDxavjBAtLlIiuVK0anxtJ929PlDwlRJ0qoJxwiRFRA=;
 b=JwGBxEPl1VEurl69jiLGOlCUTMf4SdWVGc6LcZSVTexo+4/lvTuO3qUR5+WKLwVn/bJK/c75D/K/wk9u2nq/JjYyBINNw40QICFz99s+LvXXIt6lyEDCt17LqJgOgK+fH+o3czoKuzTY75fFxlUyXPWOBsYiWYXEblfKYoTrtRT7IJPFhFQNJvFK+kiHX6IXErzosrjYkhcebiKQ7pm4vi0DhdprYPGsPPOoVP8d1CzOJSZIUsffj6VniL73f//BAuUrU9hhPch/5PrCbGNZGRM4dd7jRi2BqOeMKiLungO3I+0wnHeovPXMeXI5vuoHxWFJb7k490zgEWPkOj1i2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by CH2PR15MB4294.namprd15.prod.outlook.com (2603:10b6:610:2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 23:29:27 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 23:29:27 +0000
Date:   Thu, 10 Feb 2022 15:29:23 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] memcg: synchronously enforce memory.high
Message-ID: <YgWf0wL5RoSpNrWn@carbon.dhcp.thefacebook.com>
References: <20220210081437.1884008-1-shakeelb@google.com>
 <20220210081437.1884008-5-shakeelb@google.com>
 <YgVyZrDPxVgP6OLG@carbon.dhcp.thefacebook.com>
 <CALvZod5xFmCVV_AZO1be8pYakmDvYh-QXmNYtTNT4zvCw-m4bQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod5xFmCVV_AZO1be8pYakmDvYh-QXmNYtTNT4zvCw-m4bQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8394825c-792c-451e-3e1b-08d9eced2e0c
X-MS-TrafficTypeDiagnostic: CH2PR15MB4294:EE_
X-Microsoft-Antispam-PRVS: <CH2PR15MB4294E6E0C4181015251A546DBE2F9@CH2PR15MB4294.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyeX6rnkSV3w0J/pZsO6+zul5NnKbowaxFw0eHyloXWN6Fmuo+KkymQUTorocB/JuYaOZwKsCYu4i9LBoRhGQGrS7MtAozWqxgkQD2dzapzeXl5mHXk7z0nk9/qyvMeQ0+MPa5M0HXbNGqMfXmZrTtDspIBDFLaK6EVTMQia15ahtQBhjK1DHp7rzz6FRN5BaAuKOO9y6HW3KY+5feFB3n2WI23/4FfuSXn0jOTKaBRGo17IpAMmhvTBD9y6TY3AHe7R6KcokpUtFmhQtBrI7L9ZJ7jVKl4orxAkHuL6qlp9Sajc8OmVotZzh7LqAPOA8eE8pzDsD35olcvYLG4j8rOcz2yZKNwig9+IfcFvW8oFaIwBxVy5RvSGxRuIMrsP3KKBx3vJXMQO9M6L4AiPXwmy2QpbTGV55qN03Qt0oPzDJvU8Erasez65mZVn8mEXIUv8QR4vixntoFmjzf84LCpzEv06Cg7+qVwXXxmWwgZPN/glVL6ETKzqq3rXM4qYLVhPXxp+4k23XSvzpBi+0fkS5FABlG4X7Jw/zjBp768r5ZoUNTnODx3wJ/K4qo256WKXGNcdpq+bE4EeAG/aY/UBIqqxIdqrwsk+Dynz3RylDFigXIJI+s1ZoVb5Sn6lXfWKBMWxGPTgTKVLUBUa0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(4326008)(6486002)(8676002)(508600001)(38100700002)(83380400001)(66556008)(66476007)(86362001)(66946007)(6666004)(5660300002)(2906002)(6506007)(54906003)(6916009)(316002)(6512007)(9686003)(53546011)(52116002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tcg8U3uj2XniVgUO3U8X93H4Jh9z5duX3m/e8eXAuBCvZ+4X2YHjCbPy1VAZ?=
 =?us-ascii?Q?VM5c72jAzZ0mQL2VUMKLndvAuRtcBegVcc1aCywaZE2Y9wCTAHF9nQN9yn3q?=
 =?us-ascii?Q?ZBxse7jBK3XLxcZ7b2xL7A6gaXtT0eqmvZoMsjDL+gyVnAO2bo35xB8U1jR5?=
 =?us-ascii?Q?6RPKP4Q6PC52q0WdcxB6dHpwGmBgGdyGNoxe1zVgcihptViwEqiFaWWhu+2z?=
 =?us-ascii?Q?9Y0o92fW4kC8FfAXNFaXfHvZseBuyZ0gFxhrm6Zo//FSBESm8sT0YRobP2hp?=
 =?us-ascii?Q?Bgf/a0TKz5hUO+N3jiVv3S5gEypQmaZpXLj99TnMCCT1j+Pn+BVVEPBZn2YK?=
 =?us-ascii?Q?NHKqJ4bjYNLchdIN/zsf772CJ8tIrM2FD7yeg3wPqDQEGz/lJvf4QlkEBtr1?=
 =?us-ascii?Q?D+PFGyJ0z7s/QGRybc179Nbh/d+yA8q1NzE1Lg/q7pvUT3pYPuxh4N4f9iUZ?=
 =?us-ascii?Q?wB3bQP/s06Q5g0FROn/0xQcMmSjrOBwGtT222e+Q9WfiC2YJP4C77oZuWmON?=
 =?us-ascii?Q?vZtSShcTnpiwyT/ptNSxH/XZqFBtHhEqw8/11fs7Hl3XzmE4viI43xxRcyu2?=
 =?us-ascii?Q?UWSPfAnVNd0pGuy3LHq0DbTeJSR2mQdaQVnG44xkXDGfgTAgRaSp3d/6JUfV?=
 =?us-ascii?Q?qA44ztPnosnG9m37rtCR8XgC/1vR7e9Unl6uPY8m02aE0666+Qux5ziaW157?=
 =?us-ascii?Q?HW+/y/z5vAYGsE+PTPIi6jp8ugL1pCgw0laFowGxh0Nu8EPkjmUDxyBE+V9H?=
 =?us-ascii?Q?xZ2wLBeqSiuSgRzVC/hsxXNbqI+ALoiWpUabNsy2opdSCHqqErH/ZQ9azaEG?=
 =?us-ascii?Q?SUvDRcl0taJdZxdcIhuVlwTfXobE8vbuxl7q82yJ7hToVwwW97dsU9Vplskl?=
 =?us-ascii?Q?ZF2eaoMfbfgRjhD/QC7/o1jwjPviXbtYnA+7Y/KSPAMNsCT6FpftZ7tqNAWd?=
 =?us-ascii?Q?bGHm+m5B7ena1wERH9GEfQL1O9euOa1/BYq7JLICmdfIRP8XenIDxkbwiTmB?=
 =?us-ascii?Q?SDvCEIN8VwBNiJMMQICIcCdS5qyWpxLjSP9fMKTqItZEoiLqtzU4MsXXurc8?=
 =?us-ascii?Q?qT9uwt2Vn/XGNVCAmkwAhk67HQQt3xVNWUSqYzI8LRirpurTYPCLSRqe8qq0?=
 =?us-ascii?Q?zL6Gaq1JkDdZ9ettCALtvfeFSYzRr7w7GSYKT+L11CeXwMWqRRyNqDpLThyE?=
 =?us-ascii?Q?pmcNurc5Uf1gtvfs8E/qF1wcvlowx0++yDlFXsPWys8jRWGOGxUf28vNs2t2?=
 =?us-ascii?Q?SCKHKbmWg2P1wAPoqtB8k4sE/8KJGu6Vl2vR+uTBPljcAjva6pxsXs0KY0T9?=
 =?us-ascii?Q?xwIGryT6PmTt+qr/UoLF/puD7X9Q+wBjHjNXNJClmpnmh1OUG2YlisUTWRaS?=
 =?us-ascii?Q?2e2uzLCS3dGKumC/7EOJ5sR8HX08h/Sug6E+6bQUXiB6trbswi51cq+1AqLe?=
 =?us-ascii?Q?e1eMwMz1diFpV69mR4aMjnHEQpptHxDHkdipq9ZabLI9vdM4g6o08WnZ9rSX?=
 =?us-ascii?Q?Gb5i1R4y2TqjUwSOB4zUIS/kbshNGLXTPhaTTCwF/qs3XcnIF1+rBBBZbVox?=
 =?us-ascii?Q?cC0jSGv+38XcmEt2xje6Qf5v+W3RT+Vg96JzLmGkieAkTxkJ9wzr6UvZi70Q?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8394825c-792c-451e-3e1b-08d9eced2e0c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 23:29:27.4531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tDNX/ZRKdqo29imuRNAV76OVAH1jLU8jNt9M66xVybiHmLhFU4vvynzbsSY0rBK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB4294
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: MF68STxjlq6HvO8dRpTXYiRrPa8-G7mY
X-Proofpoint-ORIG-GUID: MF68STxjlq6HvO8dRpTXYiRrPa8-G7mY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_11,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 mlxlogscore=917 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202100120
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 10, 2022 at 02:22:36PM -0800, Shakeel Butt wrote:
> On Thu, Feb 10, 2022 at 12:15 PM Roman Gushchin <guro@fb.com> wrote:
> >
> [...]
> >
> > Has this approach been extensively tested in the production?
> >
> > Injecting sleeps at return-to-userspace moment is safe in terms of priority
> > inversions: a slowed down task will unlikely affect the rest of the system.
> >
> > It way less predictable for a random allocation in the kernel mode, what if
> > the task is already holding a system-wide resource?
> >
> > Someone might argue that it's not better than a system-wide memory shortage
> > and the same allocation might go into a direct reclaim anyway, but with
> > the way how memory.high is used it will happen way more often.
> >
> 
> Thanks for the review.
> 
> This patchset is tested in the test environment for now and I do plan
> to test this in production but that is a slow process and will take
> some time.
> 
> Let me answer the main concern you have raised i.e. the safety of
> throttling a task synchronously in the charge code path. Please note
> that synchronous memory reclaim and oom-killing can already cause the
> priority inversion issues you have mentioned. The way we usually
> tackle such issues are through userspace controllers. For example oomd
> is the userspace solution for catering such issues related to
> oom-killing. Here we have a similar userspace daemon monitoring the
> workload and deciding if it should let the workload grow or kill it.
> 
> Now should we keep the current high limit enforcement implementation
> and let it be ineffective for some real workloads or should we make
> the enforcement more robust and let the userspace tackle some corner
> case priority inversion issues. I think we should follow the second
> option as we already have precedence of doing the same for reclaim and
> oom-killing.

Well, in a theory it sounds good and I have no intention to oppose the
idea. However in practice we might easily get quite serious problems.
So I think we should be extra careful here. In the end we don't want to
pull and then revert this patch.

The difference between the system-wide direct reclaim and this case is that
usually kswapd is doing a good job of refilling the empty buffer, so we don't
usually work in the circumstances of the global memory shortage. And when we do,
often it's not working out quite well, this is why oomd and other similar
solutions are required.

Another option is to use your approach only for special cases (e.g. huge
allocations) and keep the existing approach for most other allocations.

Thanks!
