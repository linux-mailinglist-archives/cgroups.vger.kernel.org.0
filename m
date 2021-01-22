Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89464300FFB
	for <lists+cgroups@lfdr.de>; Fri, 22 Jan 2021 23:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbhAVW3K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Jan 2021 17:29:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52854 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730331AbhAVTxd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Jan 2021 14:53:33 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MJm4bw028663;
        Fri, 22 Jan 2021 11:52:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=GMYOkqyoO/vq7SaP26fB4RE24TheJ12GDjxPk0mdcvw=;
 b=WT8eYVGcEOr7IpxOr1sq2iS1W1yXvB97XCEVxwGkWoPz4T6x36G6jMpXhIo3tiudLZpB
 ju8cUAwKwN7HLhrmW7iF973oyxNFsN38uuV1OILCS7pz8+tkStMBg5nBOVtoFNF8SWnV
 z/5CsDjv6lVDlgWZ/5KxyPl1nudth/4fmhE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 367qmbm8a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Jan 2021 11:52:17 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 11:52:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXD14an4fn+dfs2baOB4HArMb3LdiJ9V6l9pHrQUUjf3hwXNpxl4gQEaFx0+6mXtBjG51BKoh5B735ADoit33P1NKR/H2r3Xpbt6RN8asKK4m267RXbGduGGBZPJw6zl3C81H/mFETHsp7J+s0G+6i8NEkFtOPd/fpZua5FSxPSI1nBjXYQTgZaYP8YsF/HxJmCMj8v+DVPigV72OBrIq+SmKl7DWbIlI/dvvRDFzC6XBWv5myy4Fkof7FtN5LIPiTPVfln8I5y64usLcWzoSrFwEAEPp/Me5n7QmE3WRKbxV5XQYf+xdIfZJP1WKwhbz0nQ1IOXlzgYxgumXQd3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMYOkqyoO/vq7SaP26fB4RE24TheJ12GDjxPk0mdcvw=;
 b=RHveasNaon8xZDsrnjo9IHYBUUdgBUCMl+GVot2u/NJuUqr4AQvMuisUcntQDN1PjhkBfNp/y/TbKSZbFnLMqYo6VJWilVzCy5v/OfXS15FisvZ1QX0drpaCwaLH4+40YdJ4VwFtBEnolfXSRFHkINqvwxQGSPYwCR1XK+BrHMYwyrTQu/iNmhXpT8WLFQoXpVLR0jS1OkIRG2XIHVL3rfsGLrA9up3hsYdlQlkOGGZ1poMcOWwQNrEdmyqh0P7dCUv9S7IqFiro09exclXnNY52b6qe44QPwj3xjOwwcP+sirdlXA/HF0LN/G2XaPuHhajW2gc42mEZyn/akGEYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMYOkqyoO/vq7SaP26fB4RE24TheJ12GDjxPk0mdcvw=;
 b=W/7iV3tUp5W5Qg205uabbpD48JRtuHv6QNqhoGp9lVsfbbA5DZ5futVt9NDNIeI+Ha2un4po1RsboOsWpqLVtIiPa3E03rvIsBjTslMUO/WH+pkVXsB6Y9hiPbik/KBPPBJRawPznNJfPUrHO2YfPpj5HGuNBqMyi1DQMELz5tM=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3480.namprd15.prod.outlook.com (2603:10b6:a03:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 19:52:11 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%6]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 19:52:11 +0000
Date:   Fri, 22 Jan 2021 11:52:03 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH] Revert "mm: memcontrol: avoid workload stalls when
 lowering memory.high"
Message-ID: <20210122195203.GA150782@carbon.dhcp.thefacebook.com>
References: <20210122184341.292461-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122184341.292461-1-hannes@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:a743]
X-ClientProxiedBy: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a743) by MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15 via Frontend Transport; Fri, 22 Jan 2021 19:52:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 972a5286-6138-4a25-fc76-08d8bf0f3583
X-MS-TrafficTypeDiagnostic: BYAPR15MB3480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB348097CA62323383BD356E3CBEA09@BYAPR15MB3480.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Osd8e09PqySVh+YkSx4uZ5Xs1gqzsTrIVltOLqs84+NVqfsFO4pDVasjIdF3jBhsQQUaoTVfhpcRSS0JBMdFi+lzrA3qP8Px2b/HPQYZD/T96QNUNyC4IKYS+VLCmzFsKl0gW0loHBTwU3+L8Lj0nnqcjJgzhQ4Ro5nqVHt7B6W95p5LglxkEvvMUeFHbprQUd8eFXIoJvL4qrUrWiAuuwL7K6In8jEgHeEx/od2GiG4R/PT6GDJF5hqAwK6dMNmuiSh+3epeAtfqoqPXWu5iTKgQj4xzjTr/2mxg+HfV/ZddqUZLudndI/nCnHdz5ERW52mGq1+B3D+zIYzRri0PY7ko8csj3YRsY8zx8ntf5YkYoVeDoLCO4hwzVlBmTBckC+GuKfmRrjrG0MomQ5Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39860400002)(396003)(136003)(55016002)(8936002)(316002)(1076003)(6916009)(478600001)(6666004)(5660300002)(54906003)(9686003)(4326008)(66556008)(6506007)(2906002)(66946007)(52116002)(7696005)(8676002)(16526019)(66476007)(186003)(83380400001)(86362001)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?E25a2fVE1WDpMTh5Har7KtmVu/y4A3mGUJFZLSiBpVV0W10I+70zXIj2F3eC?=
 =?us-ascii?Q?oyq3Vdr3RgKbVh4cNRXd4bEBzIVA/DlKpS22e4z4QsYdQ7zFAjBHEjJ0Bwvm?=
 =?us-ascii?Q?YrE37hoEUHcRr4EO/dsNjNuuI2FHR3J5UAbitgKotyCNBMC4ogIehkFkrwAL?=
 =?us-ascii?Q?FiE8uhtdw2+2ZkEmt9CxVLddkm66h1wkDfMqgkcW2Y5VTU5yS117kFZZCw/C?=
 =?us-ascii?Q?/xrSeR3qNKsyj2u1pvDJH5exqnkguciUWwXMnPUFpY5teaQCucOR7AKXayuo?=
 =?us-ascii?Q?a6DFilQmNdw7wEO7XC67S0EVg6DoUxqWlVXTBJffU997YxWxyMIcSmU5vgEw?=
 =?us-ascii?Q?yu+bEGFhoj1GGzsOCHqp+YdD8bUtuxudfw18PQcwDQbfjZ9ZuKvskXgMdCus?=
 =?us-ascii?Q?uXxX2YYobWNfzJajkSsUr4jMS00hT2LdYMnhWninm2EgqN4W6iK5h2PT41vZ?=
 =?us-ascii?Q?n5OYfpcmwtZDXesjk/PSgfwOg0noARuh4Hn6xmHR251f/Vck+kTZpCetCG0L?=
 =?us-ascii?Q?RyTlr0S8rMv/GJ6k+gLcg7OUIHb371S6Qi8+lb7nw1Y461A/xvxiBzWKsDMT?=
 =?us-ascii?Q?BHluWU4gK6PusS/YYTH1/2pnfE5zoI2RscmiE9B5JkuHkmoy9AfSQgp4uTst?=
 =?us-ascii?Q?r22ee1L0vB8AFYfkhRipsDEQ7AOVKqP0GeK9BudI6DtbKGggDuA+xJ4bduU4?=
 =?us-ascii?Q?3dAE42JvdXw/jWz5T/PKn7+pfj5vzlf13r7mtMxYfawbNnKtU4b9FyCV4pVJ?=
 =?us-ascii?Q?4ryq/gecmnh6NSuCP3o7i+VGYoq/0NY+lWddlcUMxBCwvO4H4jjQl2xwxKIO?=
 =?us-ascii?Q?FPbuqPUvhKSqkzQnLVjgTIgBHhpcY0Uk1/sAlCJt1uQZawXA6UVMZk4ts3Pf?=
 =?us-ascii?Q?eOKKL099HTxlvaP8QiQMIyInqP6Zk7Fbb/iw/QSYlEqHOnuJ7wtVe7wiAq5c?=
 =?us-ascii?Q?wou2Ua58yAqFe8PJq6XqTu/pQImuHInPCRV3Xue8uSVR8f49X3on5wL/78KB?=
 =?us-ascii?Q?aZTbLNt3DcuaKXnP4S/LP/SsYg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 972a5286-6138-4a25-fc76-08d8bf0f3583
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 19:52:11.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRn0FO3Xwd4jO6y9/CREzPkGdF4PfRGHs2XYBSYfnO0AitTlbKuxPswUeSWgYGE8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3480
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_14:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 22, 2021 at 01:43:41PM -0500, Johannes Weiner wrote:
> This reverts commit 536d3bf261a2fc3b05b3e91e7eef7383443015cf, as it
> can cause writers to memory.high to get stuck in the kernel forever,
> performing page reclaim and consuming excessive amounts of CPU cycles.
> 
> Before the patch, a write to memory.high would first put the new limit
> in place for the workload, and then reclaim the requested delta. After
> the patch, the kernel tries to reclaim the delta before putting the
> new limit into place, in order to not overwhelm the workload with a
> sudden, large excess over the limit. However, if reclaim is actively
> racing with new allocations from the uncurbed workload, it can keep
> the write() working inside the kernel indefinitely.
> 
> This is causing problems in Facebook production. A privileged
> system-level daemon that adjusts memory.high for various workloads
> running on a host can get unexpectedly stuck in the kernel and
> essentially turn into a sort of involuntary kswapd for one of the
> workloads. We've observed that daemon busy-spin in a write() for
> minutes at a time, neglecting its other duties on the system, and
> expending privileged system resources on behalf of a workload.
> 
> To remedy this, we have first considered changing the reclaim logic to
> break out after a couple of loops - whether the workload has converged
> to the new limit or not - and bound the write() call this way.
> However, the root cause that inspired the sequence change in the first
> place has been fixed through other means, and so a revert back to the
> proven limit-setting sequence, also used by memory.max, is preferable.
> 
> The sequence was changed to avoid extreme latencies in the workload
> when the limit was lowered: the sudden, large excess created by the
> limit lowering would erroneously trigger the penalty sleeping code
> that is meant to throttle excessive growth from below. Allocating
> threads could end up sleeping long after the write() had already
> reclaimed the delta for which they were being punished.
> 
> However, erroneous throttling also caused problems in other scenarios
> at around the same time. This resulted in commit b3ff92916af3 ("mm,
> memcg: reclaim more aggressively before high allocator throttling"),
> included in the same release as the offending commit. When allocating
> threads now encounter large excess caused by a racing write() to
> memory.high, instead of entering punitive sleeps, they will simply be
> tasked with helping reclaim down the excess, and will be held no
> longer than it takes to accomplish that. This is in line with regular
> limit enforcement - i.e. if the workload allocates up against or over
> an otherwise unchanged limit from below.
> 
> With the patch breaking userspace, and the root cause addressed by
> other means already, revert it again.
> 
> Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> Cc: <stable@vger.kernel.org> # 5.8+
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <guro@fb.com>
