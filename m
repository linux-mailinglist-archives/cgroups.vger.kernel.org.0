Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DA24A6792
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 23:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbiBAWMH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 17:12:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27234 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231178AbiBAWMG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Feb 2022 17:12:06 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211HDoPI011037;
        Tue, 1 Feb 2022 14:11:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=/FzfVYFaP95kBfMHn/Q8NqoSQIdZb538e0pa76Luzq4=;
 b=HYzRIU/uVOb/fSL1nv5ZUuWddWhdgGh603bNMROVdhfqts11h401GQD4smb2z2ChlAf8
 rWLiw49sOsQDXWz0l3Uq2iGjnerZyXCQhQScrcUcvWdU7yZvVJfjwxo/+O+sGTPxJWV0
 mhYsCNuYMiPtIXbzRidt384FtjI8x7X9nS8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxq3gfwwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Feb 2022 14:11:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 14:11:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REpbpgx7ksRhleXB3LyC815tggNBLrA2U+0Pzg3D4pdl72nZucTJNdnge6/lrPJIFTKFwtI/OnQN1odoP/I2cv2nJ6AiBByemMCi0/jAVX4e1HkjEuL0TzN8KMlSZ5bVktRh4pLZnt3aiMjLkAW3KrZTHy+/T/uQv1xiQqzsLWbnWnPzgnb+4MewHABj8ta0zJy9wOKQWlI/hgiXr7ko0Ex6K0qBXJ3YffMxsB40FCfw/5x/hA7btiiS5vYf7Kqo+2fD5pJM3lg14BXKAxCgf8Fs2JBpGI35X/sylACqH7Ob5pKfg6KwErEYkN1YIXgAT+HM8J57n9OexIfbe/vU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FzfVYFaP95kBfMHn/Q8NqoSQIdZb538e0pa76Luzq4=;
 b=WVVAFuzQmdKmbJth7QEKUJffOmZSkyD1RzNTWTHJa/duGorBtRliZN48+9CvqvBYoy2aSy1bk14B+1mbJzHhmp9S+tqAOicCOWk4hYVHI3zLiePPIVwxXGISROaITwTZAGaaXyFRZfro0UR1xiZxSW2yODggMSOu5nKlwYqdf4U9pRsupSf1VPsgaFD20DTKu7FUKQvWubgnxKW6C3C1KokVF8tckDC+Obt4V1wGOCNGuc0Y93bx+9aN1RuP29leTIHSaWaEDJvuOVBMu7E6wm0bkAdh4sg0Hcu/mZmdnXbwlwJ3c2yVdlmcO3i4WrSMQvTFAGhcJNGmnVhUQKrAkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by MWHPR15MB1374.namprd15.prod.outlook.com (2603:10b6:300:bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 1 Feb
 2022 22:11:53 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 22:11:53 +0000
Date:   Tue, 1 Feb 2022 14:11:49 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
CC:     <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG/RFC] mm/memcg: Possible cgroup migrate/signal deadlock
Message-ID: <YfmwJe9cUQnBV311@carbon.dhcp.thefacebook.com>
References: <20220201205623.1325649-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220201205623.1325649-1-jeremy.linton@arm.com>
X-ClientProxiedBy: MWHPR22CA0065.namprd22.prod.outlook.com
 (2603:10b6:300:12a::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed36c456-be32-4f37-a4ff-08d9e5cfda51
X-MS-TrafficTypeDiagnostic: MWHPR15MB1374:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB13742EC52D63C8C8CEEA0BE7BE269@MWHPR15MB1374.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJnNPxa//f2cvTBjP3NiVdrw4gs2Np2/YfghKlFIdNvuMPGw8eiq7lM9ugB702F/zytcySOshuQJ7q93/h0DZvUKhUJBAvqlAXtuPGxVlxwpv331MY3te8XP/zqmq6RherMI3l3lgJWEw8Nn6eC3bYpxhogmqk0Qa+We17PPTxgcpg4oqu3Ns8T/wPXqf3mH9X80I8CyhzyPo6f/cHh0/J+tQ7dg+brXZkYg4KtfnoNgwvHAdha+Mg3pQrNfWXBEsHTy3UOXoon6Wr7XOugR1NtMIKXRf6EIfoEfpUShKd9DWOK3Dp1QwlsWm+6VfiTV5NuYcbxc1dLqlyYcggcU0+oaCaK13pi2MqHc4nxfGC9xvKxq6iGyUxC4ULgtPOXi9soYq3CMwF1XnWSuFokg014cvTH/dlHumvQMoqm84nWfRqibjSZJcadYHav6Taq5HmmA0ladWYCCClX+OEU10w/XW2p0Eb4k7LxdPyi5giGOCMOiRHnE8vnZIlxQS0wkAQ6Iv5MAZkJSzQJzwlkDWPns+84S1QLO8h5bI77LAohWRQnDzu/6219nj/qmJiVzin7RM+A7jzsX20V8E3yXxC7Yqr+CSkjDcOEps59hP/03D5qu/1R51bMF2+m4+LY+cyn/9KxBOONC+nr4rM1eoJDgRX21XmwAekaNAgBwz8KYYhmGTPhy76/YXL5CDoxEbH99M3kg0t68M5VWivF0Ud+KQO7p+lioUhFy5/yp8ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(8676002)(6506007)(4326008)(54906003)(6666004)(66476007)(66946007)(2906002)(66556008)(52116002)(83380400001)(6916009)(6486002)(508600001)(966005)(186003)(38100700002)(86362001)(9686003)(316002)(6512007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xGV7GXi+7xHfYvi9yPeeRLFh5n+6LaVqwcNhLLf6wOuYmsyN0gXHkSjO4H1k?=
 =?us-ascii?Q?QRMT/fJyz5FvyudT26v7KXIfqS2KLUa5FrPjlwskXu7xwWsvy3qN9bvc+3/G?=
 =?us-ascii?Q?kHf5eKLu4IvQ8rNAwKrhgEB3TZb0jyEZAQGhFiw5gF9uly0vInRjzvSifda1?=
 =?us-ascii?Q?ZJDaqdKKM24ivUj8vZKoEW4+ZsMHJCLKyQrKz+qyNziEmNG/2SNEHsCVkK7M?=
 =?us-ascii?Q?yLQDYIx0uClVU+hNFAx3xkp+OUWAcSvLcYK0enYoUzdoyJNTGCWvkWgGGXlB?=
 =?us-ascii?Q?JxArXo6HdJqcemcYrfB9h3m0AmjLkkS3XRr76GvfOtHgkSs0pGH+iK7V42k6?=
 =?us-ascii?Q?G3O5iRMcYfWEJKIXVep6cdY4BOJ6/kIQDfSS3tGRDbWHm1x1LYwhMeOioOYw?=
 =?us-ascii?Q?pQ9Z5AqEZ3HNBEGJI/jGTcieizToIhKHL5YKzzdDvyrNb1HA/jurt30Q8ANp?=
 =?us-ascii?Q?XII2OKwuZAKdGXzTaKcW7iW6BVjGjZZDNdAjNDtITT8S8oiLDSEfYRC0nzy+?=
 =?us-ascii?Q?7fKKPJFA0fMkjULGnrin6VvlOkDiBbCUi6FtlG/w/XJ0caqRgAipTxHuLuC+?=
 =?us-ascii?Q?uuYmPZ5w2cA3rGfI9Lbmx+7+ykFzXeFdt14sQ91PaSYR+6DcxATZQv8fOBld?=
 =?us-ascii?Q?BZQMXsi8eTeuq2S+adC6Vaf3H9wt6hL65dwmco08KmCP9X1JNxVLAWTfLfr5?=
 =?us-ascii?Q?lqRy+kFQiGL3igVeouENW5XVuM41uhCEVCaBHb0brsIZB47wUM0l/F9qwVey?=
 =?us-ascii?Q?NeBA77hlxwMHiEzy4Q2QMNWui2n9yeHyZ2MNTV4T5BoGbF28qh23OpRFRpcD?=
 =?us-ascii?Q?mBSTOsqnVMz7oI8B6dj2noyoepJWpFRd1Eo55h3WFsdDQpfR6uUbiGEyhOH+?=
 =?us-ascii?Q?mGFUlVeKGnOcdiBFk6A+aX8D1FIkuufeATMdMyuOZRCYJQv5vF7vi661E3cJ?=
 =?us-ascii?Q?rBG1fdcN2YxAjBXY1z/LKeysdR3bBe/M3bgRb6JXTo4N153dvwymrCHun0N/?=
 =?us-ascii?Q?1izaReWaYoXiwx8vodfZbn6Z1ImB00bCJxxolzwYSoW5V3sBmfvYfox5lDx0?=
 =?us-ascii?Q?HwlgQCbArdbf7Qw4RScpX14hHnzadU3jK608cDRkdwskttprMs2622isPmlZ?=
 =?us-ascii?Q?oDh765apyx4ZQksIoMW2rq+mwMVQkyauppCtZLib4+X1XjHhEe+VJd3tRMcz?=
 =?us-ascii?Q?s0at9j2p31DUOMDoaWfY8X2B5nTULxTbPnP2MUmFHATyZ4QEk5R4s8otCr+B?=
 =?us-ascii?Q?WFwaHCpYrEjlp65cghY+rnw5OR+B9pplsuoyYfsMRoGZ5lasqfwYYmrft8SP?=
 =?us-ascii?Q?kbhBLkseSGkHBFO39M87o1vQaVhHAjMB0VkIzQa7hxuvjb7nQ7EH/R6Hys2P?=
 =?us-ascii?Q?hPNdJ6N155/XCqtYp1KMb31Hk9/t5j6MpsiTSuw3WCsZ8i4KNHpTuzlB4jfA?=
 =?us-ascii?Q?yHqOXx+v2Yj6TPRS+jxVAyG89SLP925uYbWw9+AEHkQNpRsiGI9v1x02BP3u?=
 =?us-ascii?Q?i3kFynmD42f1UEkFjGDWlOsjhVLKcCgiW4hYFgCW5CkJ4TLmm/5pQTO7V+so?=
 =?us-ascii?Q?Vc3qyw5ZmoKyD5VK5XsPJhsHia8dZ9YspiERzPKL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed36c456-be32-4f37-a4ff-08d9e5cfda51
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 22:11:53.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjSRutj38i9iNqYPj5gH6ExHcSZi9idjLSlcGnY32v41EhUVXL64j7zoYVtTpAL8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1374
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 2Ix8bLaNHOfanH_GRYmStPMN1UGtx6Ye
X-Proofpoint-ORIG-GUID: 2Ix8bLaNHOfanH_GRYmStPMN1UGtx6Ye
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_10,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 clxscore=1011 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202010122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 01, 2022 at 02:56:23PM -0600, Jeremy Linton wrote:
> With CONFIG_MEMCG_KMEM and CONFIG_PROVE_LOCKING enabled (fedora
> rawhide kernel), running a simple podman test tosses a circular
> locking dependency warning. The podman container in question simpy
> contains the echo command and the libc/ld-linux needed to run it. The
> warning can be duplicated with just a single `podman build --network
> host --layers=false -t localhost/echo .` command, although the exact
> sequence that triggers the warning needs the task state to be changing
> the frozen state as well. So, its easier to duplicate with a slightly
> longer test case.
> 
> I've attempted to trigger the actual deadlock with some standalone
> code and been unsuccessful, but looking at the code it appears to be a
> legitimate deadlock if a signal is being sent to the process from
> another thread while the task is migrating between cgroups.
> 
> Attached is a fix which I'm confident fixes the problem, but I'm not
> really that confident in the fix since I don't fully understand all
> the possible states in the cgroup code. The fix avoids the deadlock by
> shifting the objcg->list manipulation to another spinlock and then
> using list_del_rcu in obj_cgroup_release.
> 
> There is a bit more information in the actual BZ
> https://bugzilla.redhat.com/show_bug.cgi?id=2033016 including a shell
> script with the podman test/etc.

Hi Jeremy!

Thank you for the report and the patch!

We've discussed this issue some time ago and I posted a very similar patch:
https://marc.info/?l=linux-cgroups&m=164221633621286&w=2 .

Also I did resend the latest version few hours ago, but somehow the
mail didn't make it to the mailing lists. Anyway, I've added you
explicitly to cc@ and just resent.

Thanks!
