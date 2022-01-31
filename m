Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C147F4A4D04
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 18:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380829AbiAaRUN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 12:20:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48162 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241643AbiAaRUN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 12:20:13 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20VGnO8h021295;
        Mon, 31 Jan 2022 09:20:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=+QHk6bNqeMKQZkDd1PYJJBzp+I+WKzcnh3AcPFsPbHQ=;
 b=OEs3JlE1SKXj79mR0e8nCU7RWyw2cUucZdWJD8NdOoIBxB6A2v0QQ0mApV1uO0bPP8vr
 IR77pde4Zsq/tWVnmbG6/SIrPOz9n8AagMLTzRX9Fwc02lGkUN45g8dXeudTrr+VTX1L
 7ESOnVQTUTM24hxl+Bt+orHgyCG85S2Ses4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dw1yatfdv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 Jan 2022 09:20:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 09:19:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBIIO7YtpwQ8cZsRtaZaLFibzYjQIt557XFlMNR3LIdRpG8oOaaJI9+YgTm8GOSbcZhK0fAuKdFDQfxmdpMe/VNa81xPiomM62xm01oSjfOUk+m7a2C2ViTRWT6c5O0oUQDoJzLCsIS3uUYv/vjuK+MOUfJ8OxYQvofgKC1ixnViZuK9bFBp0bhWKf3lBRmiAFB+8K+Xd3bFUOikw7G+NQmeTj7EefuTh3CABQmqO24CaKyRQcFaLaPnefAYjsiQcQ66bao6r/vlcwQHfdEpU5oduQ3Z8/YYyVzKvqWzKYqTWsU5RR9i6cvTw+AEGEYsapm/BtZ4qZMN4NPLmMFysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bLrmDw6u2S/Kvi/BcqtNpS0WUjblid5rlImwzhd6lU=;
 b=dfwtfqgfLDnlvgp7vjv+bVllrW4lFNE12lV1xUZlBTQkcPKKZF6boj0jwOSMtU4W7cZtpmRFb/UaUIMAXlRVhBdtB50SISVdkVYLvjbtpxhyxaAVpnCSLxkN8HxaIfWL/NGPwjxpRsawEgO45fCYPyO15s6hAhuYErOSIM0fhkhDRG29pB8pkR6OzsQxo4aV+sv6cZflOlsAtohREdXFE92gxg5ZjK2aRXQvINRIDzNn4yGi1Dn4yXYn5N+DjJVJPCXhTgcqY89cCP2kLu7rcEfOgyO77YSt4YdoJrDLxp0AHO3b1Hk/O7i70Gpfl/Z5x+Q7ZnYhMI1pxsTzW84L1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by MW4PR15MB4699.namprd15.prod.outlook.com (2603:10b6:303:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Mon, 31 Jan
 2022 17:19:34 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 17:19:34 +0000
Date:   Mon, 31 Jan 2022 09:19:29 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 1/3] mm, memcg: Don't put offlined memcg into local stock
Message-ID: <YfgaIcSJhqEOnh65@carbon.dhcp.thefacebook.com>
References: <20211001190938.14050-1-longman@redhat.com>
 <20211001190938.14050-2-longman@redhat.com>
 <YVefHLo1+6lgw3aB@carbon.dhcp.thefacebook.com>
 <f7026256-4086-6632-569e-5b13594cb3fc@redhat.com>
 <YfgV2iiaVlR0hozD@carbon.dhcp.thefacebook.com>
 <95ba1931-e9c9-45c3-b080-d28f2ad368a7@redhat.com>
 <c950a93d-bb70-9a97-dabe-a1d58d755dad@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c950a93d-bb70-9a97-dabe-a1d58d755dad@redhat.com>
X-ClientProxiedBy: MW4PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:303:dd::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79dace62-fb66-4f7a-feb9-08d9e4ddd9b5
X-MS-TrafficTypeDiagnostic: MW4PR15MB4699:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB469958AE86ABD7A924A1288EBE259@MW4PR15MB4699.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxOsC0LGB+WycI3svdl4Jt9LoMaWITPDiqwQm+EUPXjekyh1HrPFpXinzDewQySpnXbG3msLmFzE9oyZAZwCdf4Jkc7IPS0T3pA/7vRRU6qjo/DIYKwlPBGErrubumfrp5TI73onLzBxJpoFVoOyTq4V0q5xzgTcbH59Zv+Ln6Uvuf75halDQsZCL8Ayljl6bbDv2ZPsK0UJCU7s5U1xI9dcTAL/MsOCGOBeoSomAmyD7s5heyIbl7AfAi/QB1t0wcmTlL62G6m4n/rwVB9mCNP10TEU+LnhtJg4eIIr5fjNuVdJk6G9uMA6D3kmW09057BUsAy1NCccSIPKdFlnu7S33HgevHSOG4xAj/+T6ppS23MZmTjvoPOeVWKHApVHp348F1fQ0Cl7hg/UmWE3utwVFklZ9/+rrJVGOdNGDqDPfyLlnYEGIN3EQ485uaalL9TmXZE7U2tIZOMuGt4FT485SVBxPea2a1nQ799cgoNS1Bb2KY3bN0/CDUSrACucFak28KoVJUABqmZWcM/INKYYVpFiAVrOxaNRTbJe6s1A2yA7V8E6LXXNsrb3ACpK0jneHM+NMZJSRirdyErPpGq0jcBaN1s2dyuvQWi1EAQ467ScGfMbIrmI4gQAsQhwxcrPm4iStzoxc6KQ3Rwd2wurOIGa6ZtN830N0UwtsuqKTixXBJCLOeHimd+JxCJvyEm7fnSTVVEWEmDAn2sYpQDy/Y5X+M3z2WxhBzO4ysA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(966005)(52116002)(186003)(66476007)(6486002)(8676002)(8936002)(2906002)(66946007)(66556008)(86362001)(4326008)(38100700002)(508600001)(54906003)(6506007)(6512007)(6666004)(7416002)(5660300002)(9686003)(316002)(6916009)(83380400001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Qm7NY0xrlJii5PA/+pLz5lk/fncPyogIMwkwHQ8VF628H6dpI4qulKoVBnM?=
 =?us-ascii?Q?uCgCCU7aPohX6FbDAWYGO+0cKel0d75RQcXoQBIdPeXQe3K3N5OviP0QczLI?=
 =?us-ascii?Q?bJT2qka7pqB2uo8pNOYg09grvOWjEiLYxsOylCH33cNrqFvfpO3OAl7VwCpq?=
 =?us-ascii?Q?P2hanEntA8woiXDh6wGuqFHbYefR2dbpQK5OkicZh2kBI6kgRHBg7qRERc31?=
 =?us-ascii?Q?fAhDbzaVbJkDuZQ3WHYSlcyqbJVCMVuvItz0Sg6/BtX9TEoZrQ+szfRDJrIe?=
 =?us-ascii?Q?pByuDVI7PiwTM9Fd0fUytF8bHM+jGm1KTBgSwRilRpQt8igX1Rl7yobzhplp?=
 =?us-ascii?Q?wnyWqLoot5M8mfNgSZUdSHUWJ4v+u0upnzTY5jP3nJ35g8t1YYofek+Nubbv?=
 =?us-ascii?Q?WIHYO/4wQmue492kOv7KyuLQlgSbDMUaEhuvqPJfryohCGzKZnmi+VG5zaYs?=
 =?us-ascii?Q?yyONgwKykLJmrokZ0IeGRN0eZBMgAsguR+0ITGu7cWleR9EOTtXm3smMLOtY?=
 =?us-ascii?Q?5ZmZpY60ipPa/bZ/kx3WLBPkAaHNWwBAtPN6sBeh5uycsnl+uZxgVgmeQN79?=
 =?us-ascii?Q?kVrEldhAcVRtLBFT8Z2UxdrCFmy5q65qobjaeJY8UivcOvnMyHWtTVRPtEKW?=
 =?us-ascii?Q?RcJlbSNyeOnd5wXLfyZPXWfvXkHwov9J8Y8pCGuBdHHpKfPfHJJAywUPE/tw?=
 =?us-ascii?Q?VXz1LuxvfDcm86SohmoILRh0oFhhIHxAHLvN5bIKtspX8ZzIN7KTKPYGD9SM?=
 =?us-ascii?Q?BBxhJ2VVXEf7UpCKxMQlcvARfQx/VqPuuhWw2OVVupqJAxUsTteMdtlx9212?=
 =?us-ascii?Q?Nyn9Yr5Xlwswn5n/0UUJ6VeYtmW6h9tcvBWoygFb+V0QdL0q+B9nCta+gNmJ?=
 =?us-ascii?Q?dMtePZcNRri/o2rpDsyBfB4jtnkaKyfl4AUaIn2eBQpP3pz7osj8bkd9xIvW?=
 =?us-ascii?Q?ER1qfWnAc12FgusXw5UZajsmd406LJ/lPkxkMjGnpDyxJ6uhSysivocm/fmE?=
 =?us-ascii?Q?jCGipgF8CX7w202et8PjXJ9yvt0QVxLvZCNI10IthHhtW+bbSro44QAwrv01?=
 =?us-ascii?Q?Jr12SmrqciVu1t/YcPFKoS6Gh5JmJHvWu0IOePNb7eYccL0dAwdEsOX8pnld?=
 =?us-ascii?Q?/Svv7A8A6d2ttwNYJu+CoRjPab2m1IdjM0IsNKPZm/qug5OmUwl4gfvo88cI?=
 =?us-ascii?Q?1IrfOBseX2SvdxcRrnJ8s6JDXdk4r3xM00Zb956nguyBtWvmVrG+cs2s6j9Q?=
 =?us-ascii?Q?uMHxWAdAK2aJQnapIhZrWbpPxvrIDjgpiDF+I6GXj0ChPNx+07gsX2Ruif2C?=
 =?us-ascii?Q?O3sDGDEBLOsSC7pkzmKhhxcckMRE8fleUGWk8JWzQfCOMY7Ii3qkt5hb0SrD?=
 =?us-ascii?Q?OYHTOEg2+Oj+Qr3SFs2dJTPDyPEHBi9L3IRYduiG2MHsqQrcuLQ3YLCW/PWx?=
 =?us-ascii?Q?luJkJZ9RIo9mkY5bFX0tr+gh2JXyYrLviZ9Uwp1hWLpEO1BeNlR9QbqWSXh/?=
 =?us-ascii?Q?w0hStvoK0ta5Zkuvoov6qDUJwJ4esM6H15caRuS7XPexYJhSfynrP0gIIZnN?=
 =?us-ascii?Q?te0ZqUSKimY4F1eIrvufFxLYyxZx/1tdNLSHPIyU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79dace62-fb66-4f7a-feb9-08d9e4ddd9b5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 17:19:34.1905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oHVsx1nXVhCciQk3HjM0/xUJ26YmmAf/xgIE6Ep7H0Bf5l+Tsvu0e8MZfeas5Z7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4699
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: C3_AOlY-mn8-o3UON0fIG5Y0F0JgCbgN
X-Proofpoint-ORIG-GUID: C3_AOlY-mn8-o3UON0fIG5Y0F0JgCbgN
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=339 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201310113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 12:15:19PM -0500, Waiman Long wrote:
> On 1/31/22 12:09, Waiman Long wrote:
> > On 1/31/22 12:01, Roman Gushchin wrote:
> > > On Sun, Jan 30, 2022 at 10:55:56PM -0500, Waiman Long wrote:
> > > > On 10/1/21 19:51, Roman Gushchin wrote:
> > > > > On Fri, Oct 01, 2021 at 03:09:36PM -0400, Waiman Long wrote:
> > > > > > When freeing a page associated with an offlined memcg, refill_stock()
> > > > > > will put it into local stock delaying its demise until another memcg
> > > > > > comes in to take its place in the stock. To avoid that, we now check
> > > > > > for offlined memcg and go directly in this case to the slowpath for
> > > > > > the uncharge via the repurposed cancel_charge() function.
> > > > > Hi Waiman!
> > > > > 
> > > > > I'm afraid it can make a cleanup of a dying cgroup slower: for every
> > > > > released page we'll potentially traverse the whole cgroup tree and
> > > > > decrease atomic page counters.
> > > > > 
> > > > > I'm not sure I understand the benefits we get from this change which
> > > > > do justify the slowdown on the cleanup path.
> > > > > 
> > > > > Thanks!
> > > > I was notified of a lockdep splat that this patch may help to prevent.
> > > Would you mind to test this patch:
> > > https://www.spinics.net/lists/cgroups/msg31244.html  ?
> > > 
> > > It should address this dependency.
> > 
> > Thanks for the pointer. I believe that your patch should be able to
> > address this circular locking dependency.
> > 
> > Feel free to add my
> > 
> > Reviewed-by: Waiman Long <longman@redhat.com>
> 
> BTW, have you posted it to lkml? If not, would you mind doing so?

Not yet.

I was waiting for Alexander to confirm that it resolves the originally reported
issue. I just pinged him, will wait for tomorrow and post the patch in any case.

Thanks!
