Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A9C475043
	for <lists+cgroups@lfdr.de>; Wed, 15 Dec 2021 02:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhLOBFO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Dec 2021 20:05:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39532 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238958AbhLOBEe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Dec 2021 20:04:34 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BELbWRE002852;
        Tue, 14 Dec 2021 17:03:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=5iCF1rNv7/raNBX5b6Ddekpu+7nTy/ld4v6tScCL3hs=;
 b=Ebg9R/ddwTVeI+REYFYgspO+z5I6WPMMkerajj4xbb44Kkf2PCZxQWcmBsGlTF53wy25
 NvgDyG7Cmy/zNtairE4T8qAF64RdK6BCkqbOF4kHEhVO9m04X4RRisQ3hsp6yZM235E8
 TzoEJT8EROxvPN1RdtI7lAbsxZP26/ZtHI0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3cxs1eekjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Dec 2021 17:03:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 17:03:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgHBJlzzJgmAFqJHwiOYM2TDMXodLf7VBKtkbIB3WYXVYxWWzqpQJt17Gc4EF/QlzKFqOFiFd9k59kaomhfxca8/8c+Z0Kfa2OGwqMsmTe8L+hoHn8zyzqkshyEDjCQwYeog0thoMzlebnLOcJvynodhjYP1Emd8Rl4CBTrbrByzh431ELt+F1mh56ZIm9XIFELt1+LI/jkjjrPKgS/3h6k3OCX0qSuRLooVG3B6OWbR2Tq6qAqgBszlGQR8lxAiE+d1LZNCWcaDIF11cWoKwpIFhZ+R4g3hUC5voy9t8wjQlzsrpjVZVr7l4FHin4vcRxnwhsvrl5R2AKhywJPZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iCF1rNv7/raNBX5b6Ddekpu+7nTy/ld4v6tScCL3hs=;
 b=fmhqasVjpIZpY4QFPzuxHZ9WEy8wOtjWQ9sNz7iVXcBlhd+15KUpT1t/2it9d4EPCYPZCs0kI1AiLE+hI1iYDf8fOtJd6eKQKO1EYX+MDpcxYnPfOypIwmLEXTTm6CA+vsYQvTKyrjHi67GiuZL/qSnyj6g579HBpwHkYw1X59kJSkiRHamXEoNHvnaxpG37MtBrB6QNg7FHgx7ti31EBHqYsBWUbs75HNNp0o/327SvEDfgZBrkLxCV789exzbNfSyA9M+kRLagIT0k0OTAJjxGRnTcJ1eeLm7tUZiQRzjMNkCKuD/4l2bUu927TcpZizqL+1I4XSibn0T5n5MaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4867.namprd15.prod.outlook.com (2603:10b6:a03:3c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 15 Dec
 2021 01:03:18 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8584:55d7:8eae:9463]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8584:55d7:8eae:9463%7]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 01:03:18 +0000
Date:   Tue, 14 Dec 2021 17:03:12 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <patches@lists.linux.dev>, Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, <cgroups@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        <kasan-dev@googlegroups.com>, Lu Baolu <baolu.lu@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Will Deacon <will@kernel.org>, <x86@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Message-ID: <Ybk+0LKrsAJatILE@carbon.dhcp.thefacebook.com>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
X-ClientProxiedBy: MWHPR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:301:1::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 042c7a8b-f401-4fb5-beb1-08d9bf66ae1d
X-MS-TrafficTypeDiagnostic: BY3PR15MB4867:EE_
X-Microsoft-Antispam-PRVS: <BY3PR15MB4867E2913F269576EEAE6DD7BE769@BY3PR15MB4867.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jS1LWwuqQXd2TtEe09kir//VPpeKyM4uBYGWzR6Xi45FwwHPgeLaQdphSeGx9WaiQ/+ojkr4BElyINTAYw4FWKFp564/CMjnfxcU231zt9+6wJ9H42J4bAW9w8AKfipVloBlZyMzwgZDuf+UGmgmXyr+Gynu8i9HRk7K0T4Pihuox22hElpl0Ai46lF3KbzhsFXf7XA6I30MKcM/urusuIa4IVdCB4VZbztfCuWy3+has0h2JcbB03sTMeAZhbvJ/l+ROH3OLJzfzuTKNHB4Xti2xr6TqZPgPBTICCPDvKWjjd6g79gjWAjBCNq1VXO1ywhb7L1uLXCrgG/zeETPWLjH/BdUWS85dhATA5mu6H7qQRH78AchJkVxjZqTpDDj9GwRZIVSpeijr9bbgrs3m+vLZBdKe5ZG541Yju3NcLIAhWs4z1iA3aVHBEoZwiimMxhaeY4zSQVnf3ip1M4mudR8XdRekLhxwmf7eLHyVrEAQ04aS7DqHzSytylGIedM9llAxk6ezVWAb0xPe8rjvtNmHVRISjlPhnE948zp9wHhCsefzMAmDt/nEVsbnqmzoe9ewCJyR3ExGX+JUxnlEWWrH2F2turV2Jj5a+tQU4kHApJtr/bOziYFEc27mQP8u9pPjirEvytmj8WP1dleU4QKy2vxwMuZkmUvYEoMAZ4JnVxFyHnZVdTPoR4Ey3SsVpnZZ50MsiPVaFknkwb5CyUWD7HngSdeSeSFBCUFI492nbo1k2vWKCTZgTZZGkTUf/KMj/gEiK7iq+Ox27hVHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(38100700002)(54906003)(66946007)(66476007)(6506007)(6512007)(316002)(6916009)(7416002)(6666004)(5660300002)(508600001)(966005)(9686003)(186003)(6486002)(4326008)(7406005)(8936002)(2906002)(53546011)(86362001)(52116002)(8676002)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0uOI6hYOHKq/jqnbH46j655Bazl+ipCDewfxZozId0Fyr4+TfRrnRm8IZrOm?=
 =?us-ascii?Q?wQcohQ8nQKpacVVRTGOCwQQh86Y+Ar9Wfc8QyjYGpoJJKVKp8o0x7P1Jp3Yh?=
 =?us-ascii?Q?zIqBahly9TQODyJ2xyaNBrrzZlx6pw1+S0bbpYVzPpgqLpP3YEoXlNGcjSqd?=
 =?us-ascii?Q?yh9Z0Ae5UHFiuU0j7DLt0WSZRNord8TaJpQ9mQR98dxFdop2NBHSywmCED8n?=
 =?us-ascii?Q?gdN7XxRQYoGMFZ81xFk7IyP41NEeQtCh6uMI6adBKZOQ64ntxRRISxNs6vHy?=
 =?us-ascii?Q?FOhw2LPkH4VHbeFURyiOQZBuhaV7s+7ou1FoixgEvcul5J2bGPmH0gFqZL6+?=
 =?us-ascii?Q?cz/2wuu4zpUXBRHLQMKyVM7oDDUWVE5g0jCO5Ie6V5tnnNk6zci5Y1yCJjI7?=
 =?us-ascii?Q?BXKb/+KXD0kn+59huLf8pSIewaMMrYtkjDOD6lAVcASX+S2Tl2h3JHX9xEzQ?=
 =?us-ascii?Q?qLtjAATEMBHwfyln5tjrotWC/mPycueYfegWVhpDrqZwLhW6ji8iVna3kIlm?=
 =?us-ascii?Q?braoTG2uVIsT0WcB0w+ldxE5pJmoqLGNsxFE7e0/9JmjQRC498iICvquFZfE?=
 =?us-ascii?Q?ic67NzMBdOCRNZmpqsu1eXAEzMnonyYnD0y8t1imHrEMnMzuynZBk0GFA+UJ?=
 =?us-ascii?Q?EhVobBPiA+iwRM4uXRGELDEP9x3BawixgIfwoDDJuD60bNkV40IM2V6tsphg?=
 =?us-ascii?Q?h80Ng867zCtwDmqYWJw/mkmP1wddmFBAOmoizms3ROOl4W6NuuJXKrZEhk29?=
 =?us-ascii?Q?IXVGQjHs7spJrmaoPBJsRavBkoT4dSn+fBI6pfdJaHQvsgH7RreNPNHaC4NA?=
 =?us-ascii?Q?faSc3W83xFdd6wPnXdXj34cDO/GdpWjsT7zruEWdCjJrPAqlVSkBBYTHSJEj?=
 =?us-ascii?Q?I+DGRAYArMz+aWbfH+XbtZiuSi4uNaSubiLKGuG7qj5r6qtinr8/vOEsCdNl?=
 =?us-ascii?Q?Yfw/6rvZ6667Jyb9t+ldsUcfQOv41k+tsPugPMpYAYs9boIbB79AdQdIErwA?=
 =?us-ascii?Q?x3re3duZ4Xftid38fy5cKwvslumyK5jrQvKL9eZL9jR592JH05YUAsNl41o5?=
 =?us-ascii?Q?V1YvjddxZWcmcbKqOydrseE0mkhiVYX49msMS8vSDcEtturRz1/7OKWGfQf5?=
 =?us-ascii?Q?mz76gFcwRwWFsZClvycCjtEkECKWNSvPEoTtbvBDsQcrgk6ABzRxRr6R54Bd?=
 =?us-ascii?Q?7sRmafz4IF394psyrI+NTgI/x36C3rsY8n+6gmpLpUMEjkNASAxRmaSg+CAL?=
 =?us-ascii?Q?vWe0h+odUnckb3k8pAhPqqDIN2lKnioG/r/zdfPRrmR//2g2/tz0JH+qTygT?=
 =?us-ascii?Q?k8AsDF7V1CRDUVkJyIoJKmziB0zjUO+60GDzXGzwxJ1RP4a6r3ju5oCg9e6n?=
 =?us-ascii?Q?LbgjCQDZD6ATSQw4tPm2LIGQ8gmkznuxhs1f2CT5Kt4RIb9MUsLxYmpUCvHc?=
 =?us-ascii?Q?j0hk/oY74NXgGCzLfFdtjIAmNZD55akfRLcxCNaLAXx0+PilZ+gteH7L3EPY?=
 =?us-ascii?Q?fHccNXUuZWGObd2zj/PaHqd796cZqQIhqmLYwchb+Uxk5RYESq3BmQ7DCNOZ?=
 =?us-ascii?Q?rcWuUIlj2/Wequcesfg+z/q+M4syYvZ5rAu1IGN6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 042c7a8b-f401-4fb5-beb1-08d9bf66ae1d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 01:03:18.2139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4fMzdI4/Zbbl+2mMygcTlPlVqiw44wsE/EU8AUHndQHntjl+AA6N4G2v5+LQD9d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4867
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: XZSMwr1sxF9aRjiQnmoy4hGZjISbwxSp
X-Proofpoint-GUID: XZSMwr1sxF9aRjiQnmoy4hGZjISbwxSp
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 phishscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112150004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 14, 2021 at 01:57:22PM +0100, Vlastimil Babka wrote:
> On 12/1/21 19:14, Vlastimil Babka wrote:
> > Folks from non-slab subsystems are Cc'd only to patches affecting them, and
> > this cover letter.
> > 
> > Series also available in git, based on 5.16-rc3:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
> 
> Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
> and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:

Hi Vlastimil!

I've started to review this patchset (btw, a really nice work, I like
the resulting code way more). Because I'm looking at v3 and I don't have
the whole v2 in my mailbox, here is what I've now:

* mm: add virt_to_folio() and folio_address()
Reviewed-by: Roman Gushchin <guro@fb.com>

* mm/slab: Dissolve slab_map_pages() in its caller
Reviewed-by: Roman Gushchin <guro@fb.com>

* mm/slub: Make object_err() static
Reviewed-by: Roman Gushchin <guro@fb.com>

* mm: Split slab into its own type
1) Shouldn't SLAB_MATCH() macro use struct folio instead of struct page for the
comparison?
2) page_slab() is used only in kasan and only in one place, so maybe it's better
to not introduce it as a generic helper?
Other than that
Reviewed-by: Roman Gushchin <guro@fb.com>

* mm: Add account_slab() and unaccount_slab()
1) maybe change the title to convert/replace instead of add?
2) maybe move later changes to memcg_alloc_page_obj_cgroups() to this patch?
Reviewed-by: Roman Gushchin <guro@fb.com>

* mm: Convert virt_to_cache() to use struct slab
Reviewed-by: Roman Gushchin <guro@fb.com>

* mm: Convert __ksize() to struct slab
It looks like certain parts of __ksize() can be merged between slab, slub and slob?
Reviewed-by: Roman Gushchin <guro@fb.com>

* mm: Use struct slab in kmem_obj_info()
Reviewed-by: Roman Gushchin <guro@fb.com>


I'll try to finish reviewing the patchset until the  end of the week.

Thanks!

Roman
