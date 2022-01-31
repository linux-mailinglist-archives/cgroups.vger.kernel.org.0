Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AA64A4CED
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 18:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350163AbiAaRQD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 12:16:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42276 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350165AbiAaRQA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 12:16:00 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VGnV3n030067;
        Mon, 31 Jan 2022 09:15:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=eCRYYz8CwNO8O2JABlB8+ChoY0hda0ZxFN3fTK4Xn+8=;
 b=Pg6Dze3XEAWrkTME0ubICe1S0BW96KIIb2kTwK0l47yJHhECMzLkCrtex6iQg0C5yCaN
 pTdtpaEaYayqZIb4SVwMWAl7BS+SzdfZXSEjg/b8ol6g0CYC2FrMAm0dkBFVSsF5wIIx
 lAt9V7ken9z18Etb4m8ihca/rxgJcpwIyXM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dw3jxa7kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 Jan 2022 09:15:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 09:15:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxzqlD0XE7123uH2Zy+Pi9Jx5wSB8+kTE/TanOqFdtmvovYCclZoZVFEqtrNLi+dQ8CT2C38egZDOP+644VDRhB5XfeOxsUTSgEDJfuQZuxA/M+EN04UWZgVuq3XP3sWu1rsVIr7ANy18wM2M6co4GGnDl5xiVwm6DvTz0q/otHVoWsMbw12R2aeo1V2piQwyaCbyyKphXIuri/35ajXfVwRAs0CUzfOCzG2dQsmtBvogpnLqMZQ6zHyosfOKVgDaqHs2j8ds5HhPEhhlSl2dVWATHcCNNPr+drcAsrEbY7Pp96P3oNzrnoTEClAAht75ktja+pO0OCDwQuFMBlcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuWp13DyHRmefihexGsLmJEzLpqDCMn+VPgb5FYuATI=;
 b=fCl9s3kc4LomzM3wqwb2MHXX3Qgw3gUFzu9st6fUqr6t42Nn3vLbMXEMwBPN2FUWTgmX481J/dbskqq43YCqIifDn8e69KjgPVuGfMx7EQ+rF1miQltiYerDQu3zvqH9DpjVyc78numFAyB3dbRQniZE0JLz/dD03snt9NAy7DW2C1zjIu3QTBJTvmZiHKWwnzJyH3zGQ2AB+CvOY0m0mrm5vywuAmsteCsI82qu7QQRQiI4lBU2eRRLzeUF2l360Tqr56t+B2sRX/XK0r2H1gXxyaY9KuKVtNg6yJDnzc3zjoUdeaUg7utVeeFWNSvYB6magWxiQAbaEl/mV5T7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SA1PR15MB4724.namprd15.prod.outlook.com (2603:10b6:806:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 17:15:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 17:15:45 +0000
Date:   Mon, 31 Jan 2022 09:15:41 -0800
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
Message-ID: <YfgZPSs8H6PBCwdt@carbon.dhcp.thefacebook.com>
References: <20211001190938.14050-1-longman@redhat.com>
 <20211001190938.14050-2-longman@redhat.com>
 <YVefHLo1+6lgw3aB@carbon.dhcp.thefacebook.com>
 <f7026256-4086-6632-569e-5b13594cb3fc@redhat.com>
 <YfgV2iiaVlR0hozD@carbon.dhcp.thefacebook.com>
 <95ba1931-e9c9-45c3-b080-d28f2ad368a7@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <95ba1931-e9c9-45c3-b080-d28f2ad368a7@redhat.com>
X-ClientProxiedBy: CO2PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:104:1::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ca13162-5475-4999-7075-08d9e4dd513c
X-MS-TrafficTypeDiagnostic: SA1PR15MB4724:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB4724F65469D8B63A6A89C5E1BE259@SA1PR15MB4724.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etLTuN8BsC101quEXvpU83mfyDoKygzmhxbeye2y0xv9GcG27U5RXyH9UQk3vra+ZWYTDMceS0FNwxThJwP6TcfOQmg+stIRiyCMQZIMsjbUaQ28MYTDi4yg3PHodqkF7SIqHcJSk5uFWcO65C1H8a5kO7nNhal3/ppgs8X/8t/TzWaDFu+JUj5pYG+AtXZYzZG8bI/XUmjamzfDdQyohWPqyPAFzu0+Iyu6hgJ7dUDaNUvf+tRNpHOsny8OaWbTSEYeJVG8mAS1dATyB0RzVdCMlsD3jhNLAOPV1Rf55TMDmqPixhC8uWl4sIJiPNPJPpAnXlLKoMSgRWauNeIBg5l58Epa6SoFgH6ZtpYZFgOEUSfjTyaHaOhj6AkemhyXxtPhRK5TgonvAiQJfiGM+d4HDwnNc0iPYa9cXsodzOBTJSvvbM2a6kzkfr+Vsn9iNMVAnk6jw17/veJI0M7XyVhvEgYFTZfwgbseS/Yp+9EMCS37aOuiimlnPbEYaf8qm2+dY9zW0DtdRlJMk6aKi6JuopKNJbUZlCp3epC5FDjyJ0HxIz8CC/blO8m0Up7zFSz6+4z01r0t1LcGIEW7A/4U75II0u7oDi11CX7+UFZU4S8otwT+ixB3gOOYccRZ7R3oVwfilxvfZgEOWfnk8jXVGWm8fP+wb+mhMz2iD1PGq2i8ATBpr6Rvnb2ZrxVUKKAuufBv4Mtl/NpejeOR1ubV34F8ctZJq/YlFeJ/U9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(83380400001)(316002)(6916009)(2906002)(8936002)(6486002)(966005)(7416002)(4326008)(5660300002)(86362001)(186003)(508600001)(8676002)(66946007)(53546011)(38100700002)(6666004)(6506007)(52116002)(9686003)(66556008)(66476007)(6512007)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1tDU4AyBhLMW31S6/FzEjw4RwJ7gxnCIGiqFJyqAYueBlUg2nVigYPwHvQMF?=
 =?us-ascii?Q?NBuWtUbNQlIPJZCh9u6sopRfnAMDQ1bypri4P7+hRjwTSZHZ609DNE6uaqCQ?=
 =?us-ascii?Q?J1xQxTLmik403ycSdiXS0pSQzvalr2rSAqU2eu+vcwAWTelimLGohfRlhudy?=
 =?us-ascii?Q?1blkfdsEUJtREDMf9ZzxBm0jR55vy4vDF7uItZbDKYMk7B+AtCUK5SqdGQ1v?=
 =?us-ascii?Q?vUTMSqqPEZBnVmlgsn9ve+5XSBRYWHZ35BLAM1vVm3tnbEuPDHjsNZryXy7Y?=
 =?us-ascii?Q?+F3IdS6T9ckIxupTA7xbwr0eW38B4udKSzK471topVSkHuYJFIiRMjDTdM3q?=
 =?us-ascii?Q?xrQmwV3WpDC8bRSp2sc5evvkC7Bm8kFeDfNwAqWblsXX4tx8eVtJ12NEEn0M?=
 =?us-ascii?Q?L/YK+6Ex24gyN8koHdvpvb2lG5L8rSZVSkBtqGZT0RPnCtaS6oUEDoRD7avz?=
 =?us-ascii?Q?WDcOAS6Ao5NOsBxIA7EJJY8L5OVXtzVkrxhEqnQE19My38lrXrcqB4pErNG0?=
 =?us-ascii?Q?SX43VBreyPJJm0zcN/pT6auAfgxPzVslF2JcY6suTEViNpWoEWZvr/xNPgKA?=
 =?us-ascii?Q?yKu7jSM+WrQ7AKHhSi5bSyq60Z7UL3gqkpix132M0P+SXW15WnWrZvNsXNTk?=
 =?us-ascii?Q?TJRovVA5H2s1QTG3V4Afd+MUBdcneftC5Bh0JJtg6qDhEKn6EC4mgYCq/lXj?=
 =?us-ascii?Q?DVF7YLpl7xiAxWqGGFNntsO1b54iqJ0rhxi1K27iWr3o7bxJKhnILLd6NUMy?=
 =?us-ascii?Q?lG/jZKCtQrCwNVmpPyR8pba99q8n8EdivILtxvSErm5mQZrTJFFpmexx1Mn5?=
 =?us-ascii?Q?i+NfeTG1W07wSu5LSD0afV3OlUytY7wPgNEDsn9uVBLOqAera67lKfoa4dWT?=
 =?us-ascii?Q?Xsq9kUst4DVbYbikKS2y4EoFYEH6CfUyd/FpRZ+zfUOMa4EP8gaZy3JNS5Hx?=
 =?us-ascii?Q?1h/6QnuICRrByiBhNr8B/M0YHHxxImznFujFikcTgb/a4IuvcAeJTy0YcWnp?=
 =?us-ascii?Q?557jKm64Qpt83p/GBx6BAJtgxY/9C+Pdu0G5b7/WCx03BmKjB4tpOtIGSo+y?=
 =?us-ascii?Q?stWXNDLFlMVE5urXO+c55mqYnu1tTMBZoqfZvJjp+n1r6d96BvUuL2jqbhiJ?=
 =?us-ascii?Q?uQU9CC1IePdRzxJDvc56ZhZKhRiygxi1CPHnq49/b33E2MMWrvpsPyCQ/VjZ?=
 =?us-ascii?Q?CWKAD/rFfIy0WFCBfGrc8KA5LioE8RicM+wphuUQ8ij2Q+L0iOTjwRp6OWCt?=
 =?us-ascii?Q?+2tzx9ich4lLjxF/i3fmOd9jga90RIQj5uLJwBYBAVL7cDEiRNV2BF/cKA3z?=
 =?us-ascii?Q?yiJzV4bSH4t8qyv73r1sML/K5wjVju7bDCJxeiW+yzBmDedM41x0rBBvhSgh?=
 =?us-ascii?Q?Sudv7DqxQ+H1oohNOJlEatRf7vbZt6ztwxaScFiSn/iOLyKMa0edv/1KaLkS?=
 =?us-ascii?Q?Q/J3oYw5LCBywNs7c9sVGgikl8yNi8Og8YVF0RRbNLbRTieqgw7pmt3J/3L5?=
 =?us-ascii?Q?1ZPM0jqZDYokUWI9+/XmyeKc99KhWBM3pfN/uwQnQG0eF+2gVuEdKvvd/nFl?=
 =?us-ascii?Q?x0GBzIAxC8FQtd4ZCHOwNC+1vnoVH03wvPV8FqT6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca13162-5475-4999-7075-08d9e4dd513c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 17:15:45.2237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgUX1LhETCicIChLUhXANGP45p3AA6AFmOzuYzdV0TdSCpuKVYie1HCKAHfKhytb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4724
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: _-e6E2-a_gdg1qqhi2oL-kOUZNWgJv3c
X-Proofpoint-ORIG-GUID: _-e6E2-a_gdg1qqhi2oL-kOUZNWgJv3c
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=1 adultscore=0 mlxscore=1
 phishscore=0 spamscore=1 impostorscore=0 lowpriorityscore=0
 mlxlogscore=199 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 12:09:09PM -0500, Waiman Long wrote:
> On 1/31/22 12:01, Roman Gushchin wrote:
> > On Sun, Jan 30, 2022 at 10:55:56PM -0500, Waiman Long wrote:
> > > On 10/1/21 19:51, Roman Gushchin wrote:
> > > > On Fri, Oct 01, 2021 at 03:09:36PM -0400, Waiman Long wrote:
> > > > > When freeing a page associated with an offlined memcg, refill_stock()
> > > > > will put it into local stock delaying its demise until another memcg
> > > > > comes in to take its place in the stock. To avoid that, we now check
> > > > > for offlined memcg and go directly in this case to the slowpath for
> > > > > the uncharge via the repurposed cancel_charge() function.
> > > > Hi Waiman!
> > > > 
> > > > I'm afraid it can make a cleanup of a dying cgroup slower: for every
> > > > released page we'll potentially traverse the whole cgroup tree and
> > > > decrease atomic page counters.
> > > > 
> > > > I'm not sure I understand the benefits we get from this change which
> > > > do justify the slowdown on the cleanup path.
> > > > 
> > > > Thanks!
> > > I was notified of a lockdep splat that this patch may help to prevent.
> > Would you mind to test this patch:
> > https://www.spinics.net/lists/cgroups/msg31244.html  ?
> > 
> > It should address this dependency.
> 
> Thanks for the pointer. I believe that your patch should be able to address
> this circular locking dependency.
> 
> Feel free to add my
> 
> Reviewed-by: Waiman Long <longman@redhat.com>

Thank you!
