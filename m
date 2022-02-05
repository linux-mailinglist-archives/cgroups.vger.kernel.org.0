Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D204AAA4D
	for <lists+cgroups@lfdr.de>; Sat,  5 Feb 2022 17:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355320AbiBEQ6y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Feb 2022 11:58:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18988 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239376AbiBEQ6x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Feb 2022 11:58:53 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2158uUVV015025;
        Sat, 5 Feb 2022 08:58:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=s2vIlAN/7DsTxLiP+mwrPc0mOmUin6NW3bRsxKydZ4M=;
 b=Ulk3+gg4Y+T4cbmvtkS4IYNUbhPTxGTXWU13ShGYoC4lNRfVyidgORBSIwJDocDobYnA
 972k/Aee33geuclOFOMlweyQHKrq9+7Ren3J6fKkvd24P//SKFRs6QhbMwKL0q9y9s/t
 m+Ax2ZglKB0jzuwjZBBjUEdsXNcfQrHenuQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e1p5m1k0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 05 Feb 2022 08:58:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 5 Feb 2022 08:58:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMy3ltpeTCz/aQHOmSIX4yk743lpFTCGQTHPCNFmzI/cCT8GnS2XU7vf10U7mNYuorS73LEo/8xYHuzYOQaChAPqD3cSydgvAj110xsFs7G4LTwMeu+YUuk0dJxfPQeQRTEPueP01/ft4ub4X5ErfYHW3/3e5XQUKzuSYes7YZihuOVHWHj0WWUm5ISMSlPTZG4G5O7R9LYQN26/ysvHnEmdfLqRxXCz/BPaoR8rHawm1ZShH3fDpzcKzsAQruZO42Rvrd/I/pjt3ejLH2oegSrybvKL3aktxil+u2kCDoZdyOMm6Qi5tU5BGJMKCN0V7kqX/eVpeYwrA+JRP2nS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2vIlAN/7DsTxLiP+mwrPc0mOmUin6NW3bRsxKydZ4M=;
 b=c3I9gU4H1eU+svRVuymp2UX85exajj3p4pLGfdeY6CfbsFThzlQYlLWgLqfzCQePf25GarL4Fgek2IuAxjVbF4go94alPVqTAIx17IrEOKFnQSGD0SKE62nvzKMz03fV8LKRzhScZlvPHsgtGjpYwjDplmZNcxl/HyQed1Fi62mCqyXq8PztWuNh1XFgPvdFPfwZrQmEWonGSE9UcfO3XkWoMG02j+B810Wxj4vuvDSf/j5uhEI7XIYj733r2JyRY+wDk1vwPo6iKvfl82jqWlf+XLXZS8WG6AUqaSFUdAPlroLefBv9n0OO+mXBbHw8zkGwYkdQpOEADTq3LPw1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SN7PR15MB4240.namprd15.prod.outlook.com (2603:10b6:806:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Sat, 5 Feb
 2022 16:58:31 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.022; Sat, 5 Feb 2022
 16:58:31 +0000
Date:   Sat, 5 Feb 2022 08:58:26 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH RESEND] mm: memcg: synchronize objcg lists with a
 dedicated spinlock
Message-ID: <Yf6sskyXcffxTA+b@carbon.dhcp.thefacebook.com>
References: <Yfm1IHmoGdyUR81T@carbon.dhcp.thefacebook.com>
 <20220203151912.87d47b82c1bc3f0d56be0e3a@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220203151912.87d47b82c1bc3f0d56be0e3a@linux-foundation.org>
X-ClientProxiedBy: MWHPR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:301:2::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fda6154-e4c6-43a2-ab15-08d9e8c8bcc2
X-MS-TrafficTypeDiagnostic: SN7PR15MB4240:EE_
X-Microsoft-Antispam-PRVS: <SN7PR15MB4240D4864B845410B909C259BE2A9@SN7PR15MB4240.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9BvB5ialvtvsRYxZpkAGSQZUY2TlZhO4wWY1EHUiuA1fPUbfnwqVCnqel4O3XHogR5T4MOm5cDIpbOdU4Ue1ap5hBzq2dsbyI4t5/9nb2hcJFGEPeHRMNxe51NWAhQeQK8WgisJ8zRbm9fmaFuUe4rRovV9CceaRmQzxqSKIKcO3HMMmgP4NXRuIxPvmW66PrGnpaV+QO1hWHOmFAotvASbioFOEuDi5q0He352twAM+MAk6yfq+X0HSUQavt1eucpzznpfKwA3tRouRE+nc3E/6sI8cdrZUDyU52eIG2eFJA/CEJux2aXXBKgN8+Ztn0vtVjClGe16t1HvO2e5KVddX2Dt6S0Ti9v5a7oxg8xjs5mx13aK+2FUgTNopK+uWmct4DdTwozT8E6uXHD1nAsX2zqPa+TCslECzSH+xMpktySmL9FU8DbG+vnAWPK9bYepP4Khp0hWTCM+LeHgBnLGvV74gfwRn0MSXCbLV06CQZ5WvZvj350Ra1IlMAgYCAGEC0pmj1OGRSKuMoRR2jafbFBfsvdUR6zfKcP9XODfFQpXCBje29JQn0Xw353fzPT62As84jpsUOr58JxQZCeV8u/ah02nhYU72sMEQuYCnAXSUDpNMK4gPsVyqQ4b8ErfMCIwlWYLWvmzOhDWwXWhRVDstR/RiW35pKUhDKbZz8w4nE1vzf8LoVRtZw+H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(4744005)(52116002)(6506007)(83380400001)(6512007)(186003)(7416002)(9686003)(6916009)(86362001)(6666004)(5660300002)(2906002)(66556008)(508600001)(4326008)(8936002)(8676002)(54906003)(66476007)(6486002)(38100700002)(66946007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AARTkhwWiLD7xCiMPZRdrGbGhX9RbiwDudIWPwxhOv9OOLvsXHfKMMszV5Bw?=
 =?us-ascii?Q?rv9yi7SWNqlhS6gZ+9hzBR42egnWfVbNwf5jEUCsAO0dzrHxHPvlZN/FNqx9?=
 =?us-ascii?Q?pwB3oF5i+SZ5Wx1T/CNLVnDahvKEWvaaJLvFow/qiFhRtzvI/qsXU9HsGNDe?=
 =?us-ascii?Q?mBObpD7rMNb1WT1kZUql9nhzTNOpP9bsH8aPiEkAy43jYKYQqC4A6rJgsaEy?=
 =?us-ascii?Q?beNRNIfB+711v06/0cGfvT0MDmCwC2vBjkTNPsI2AmLZf+rYiHqvxER1+Xcc?=
 =?us-ascii?Q?tv/Rrr30hOy86SWn8lmvD/jnrY0GfT0fnuWdDO3TDJtjPczPt7+kdjWnhPCZ?=
 =?us-ascii?Q?ERUBP+rzsutQ8QZVYbDJ3PMalg3JtcqfZ3N8KYGLBcoIb9koFDW5EYBWj5Gr?=
 =?us-ascii?Q?Eg6vS6K7d8qH65En/phSwHqliJj2UdfsgYISzh3MsyschMuUvrPzsUiRShJL?=
 =?us-ascii?Q?SrLg86K3jXmxdEZWOfnF66epdCfwHNSlOUSlD3BlG6MrxqfMfO1E4Jx1MbQf?=
 =?us-ascii?Q?+2FbD/ISMj/BAKvLdOuYA5o5Ahg04+zq+DzFxrYSzs/rr1bTY/AL0xMR/VhI?=
 =?us-ascii?Q?oZVAtIHSZL49XBP3I1ofYf4ie9U39rmx7Pr0KBN2TEcdjk4RblnMrnd7uL0l?=
 =?us-ascii?Q?I6p2zB+6+XOyeBh2g905i66kLokEaledN5nrijbvaQMwgswbMMt2khvZRAk2?=
 =?us-ascii?Q?Wk5WVIGTJV0VlewgfHyHUXboHS2ztm8llOzrjOrbJOuaetjd47d8tvysc95M?=
 =?us-ascii?Q?rU0wmv1wlfFbp0dt8sKY2HmkN/K9wi5hj+2LZy8Grt4+qvEppoEYRNWItku5?=
 =?us-ascii?Q?9r6JvmUli3PfznpFSvkbfLNjLSB7PBjNVM6em049dDylkF7MPnRKiYHJjWHE?=
 =?us-ascii?Q?vNyW3XooXG3W/3BKEQzItGJ9+FX8CVkZwkxBc36V9CwRt0S986Nn81OzpgG7?=
 =?us-ascii?Q?Ohvv8Z7ob71Bh1e5yr4QQs17M+iXXZdy62km62DH3i8OaAKYXJNdBBqOSuzl?=
 =?us-ascii?Q?tGK22XaG5TUrpU2PA8V+uk+6gQR3U4ibTfXl3kigUUTQxHcLcsq3RBWTpFMI?=
 =?us-ascii?Q?iAeErW+T/ERFSgnUQfuXuivFWaZNppFMXUYGsrS64xOfitMBvYRiwsG7aYWf?=
 =?us-ascii?Q?JIaOuXgRCPY9OUy+GkP+rpX29kD6RUHBSlE2S9HdGsoEnjMcoziWKarKF0a6?=
 =?us-ascii?Q?Hr4KmABXy+4s/BGodAwzhjCDAUYMdjzgNyMtfaVEqQkG8YdQh1fpjgu45RGm?=
 =?us-ascii?Q?WmP7LlwGtK5c0jYznA2w4ZnUt4pAoO8De4qG31Oi/dXsG8wEWxWldRmK5U36?=
 =?us-ascii?Q?Ne8lH4TmeUQ8so8X3jwKSyGnBf5pHe+SeqGSPSAtJiFND+ShKYREl9fvAsDB?=
 =?us-ascii?Q?02OrYMKFOzpu49Vrz6elYJfXJeyQeCmYGaB2T2jx6NwkiY0dkisNFM1GA29I?=
 =?us-ascii?Q?H7s2n9nKc5nEfSjQQDTs446sPl1F7McYUnicaxX86fZMAxItkLUSOO7GXw7h?=
 =?us-ascii?Q?HmU3W51YODRPHSbqLoY2k7bvnYWrz1G1nnyi5896f4Bcx0GMaMK8dNaLDxBI?=
 =?us-ascii?Q?UvmJUKJjxVy+WE9G0gcRqpEqJVOx1RbRLkEPEK/Z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fda6154-e4c6-43a2-ab15-08d9e8c8bcc2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 16:58:30.9957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jS+3StTmYWeOIKv+iaKzU6/ZnxYycOAC2lBNPPhaCETS+70UMIKvgWHn3JvAnwMo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4240
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: zH9xBOVOWo2rPp56TisqnTSQWTn5aar0
X-Proofpoint-ORIG-GUID: zH9xBOVOWo2rPp56TisqnTSQWTn5aar0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_12,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=494 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 03, 2022 at 03:19:12PM -0800, Andrew Morton wrote:
> On Tue, 1 Feb 2022 14:33:04 -0800 Roman Gushchin <guro@fb.com> wrote:
> 
> > Alexander reported a circular lock dependency revealed by the mmap1
> > ltp test:
> >   LOCKDEP_CIRCULAR (suite: ltp, case: mtest06 (mmap1))
> > 
> > ...
> >
> > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> 
> I'm thinking it needs cc:stable.  It sounds unlikely that we'll hit it
> in real life, but lockdep splats are concerning and I expect downstream
> kernel consumers will end up merging this anyway, for this reason.
> 

I agree.

I'm somewhat surprised that we haven't seen any such warnings until recently,
so I guess some recent kmem accounting change made it more probable.

Anyway, it feels like it's a low risk change and I see no reasons
to not backport it to stable.

Thank you!
