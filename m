Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48534B16F9
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 21:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbiBJUbR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 15:31:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbiBJUbQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 15:31:16 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52446B84;
        Thu, 10 Feb 2022 12:31:17 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21AK0glc018329;
        Thu, 10 Feb 2022 12:03:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=QcUqs6tEqdHP+OehbZpd4QHEqKhTch9yyV5pMVi5Xa8=;
 b=p76Gr3iEMYyiTUi2aIrmik7e89wgRwQNNmyAr2hBf8pX5+5NQ2mT8+pUNgI5Ms0oFAA0
 ansWUN60XPHPqDHEpUO56WbYZigf3K33DYCOGj8bug2BA7RC/PJgBbwHke46pkbCaEyF
 AbiK4T5thPOIIooK/i2RM4c+sOLk5gej87A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e592ug4p0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 12:03:21 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 12:03:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uf839KlAK1fa+0XtsVI5ab2V2dgpkIHLjIx0vpkSF6EVEpKQhu7eZPdhgeq17pQ2/R2vaWGrGX1dAd0pIzONOYIgnzWsjGE/rLSIAQymICz8KkVOvIg6UZqWMkliTRXZBfywNa3P22DkXnvEFPZrhJy+YAO8aaB8O5WhPAB/t3y1ZVSWX7xctUfhy3YhCqPA3utoANA6fZsQajC+MFnGgRnopaLtKCe4Q2Gj78CDll+hDqzNeXtQgwNZAJbR2CSUo+vHqPGqnUGbOhxilnv30fJIOdmEVfkIbZjrlOF4F2H/KctPMUzQqis269Y0zt7CL8+dy0cxlfa7eh6zBFG7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcUqs6tEqdHP+OehbZpd4QHEqKhTch9yyV5pMVi5Xa8=;
 b=Hv3wFI8CDHDCR72xI+dSmeD5kHYxA5F/5DDTK4B/o9nH1FWrrQomVze3tva5DQ4ihm4nyyeiC93bk5IKl0g6mbJ2R8nEaq1KbVaAM5GJUKbXdz837VQfNwYsQWCTDgr+FllyE6QM/v/OuLkOUxIg9rQzuUaovmYfn1uEd0QJGyE7Ff0piatvMJLg788IjsDJsd1NBdaj2E72kVemAbreCMRFQaw9vmBFbrn28XOAzInlycdSJsmceaQX1/UZc7WtKmGkdiA+kq7SgWEMg7E2MyesdkVnC8EQLYLY4+njPQzuueU7x9LmDnyJ3hWZGLTQeMdb7ZB7j367pF4Ymx+UHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by MN2PR15MB3534.namprd15.prod.outlook.com (2603:10b6:208:185::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 20:03:16 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 20:03:16 +0000
Date:   Thu, 10 Feb 2022 12:03:12 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] memcg: unify force charging conditions
Message-ID: <YgVvgCbbTrDPb5tT@carbon.dhcp.thefacebook.com>
References: <20220210081437.1884008-1-shakeelb@google.com>
 <20220210081437.1884008-3-shakeelb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220210081437.1884008-3-shakeelb@google.com>
X-ClientProxiedBy: MW4PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:303:86::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07cb144b-11a6-4a4a-4cce-08d9ecd06033
X-MS-TrafficTypeDiagnostic: MN2PR15MB3534:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB3534238F0D623537DD85013BBE2F9@MN2PR15MB3534.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krRvWwy6tDLPEP+hB7jAus0wBUPGQ8gZFCbkoC3OAejhmZXDHHHsV4tC01VQjP6hDDXqZozmS82wPDbr9a6qzfL+4oQeZylcquF8KNwI7+7DJJxwb5m9GIWW+FYrj2yIC35+BHS4zIYFxQPkIYXmjfXzzAFcqs4ICcib1fHD/eE9eGXc+KO01sEsqgffE5kKtyG4o2sb54kjYKoau36LPjU+kXTfQUwvx4PeiInuzuQpRVAfQ4FI/DZYlfpM4cF7P3NdwxXYJMhnQghRS3c2R5pEIxwR9G+6c0m+TXW19iPS1cuZCAGu0RPrYrYnPbxZdkSRNdbO9rQZNzU+lPkf+I2DA2fPpaqKqGAkUiZe3vMZwgbcSdmYV/Btz0hZSZHfJPlIZta2xSAPTiyHe3vYdRUQNxelLE/e6ZT2691M6o5RDsNgks6sEwI/+vXO/rTRp4VnOxQU9qL5nTXtNXnUkqyXdQFdpcTapmEXi/h28qC4O3ehiydjegd8ACJVNTLwGOrFMVVFjJ617PUAxlmRo2fhR6MkVn6CFvjc+Hq5BNd8AOngBedwxPCR3NLln3HmDc3IumyQQ7hbR5xatZq/GeeyKHe5aOsiwY2wlOwyBVtoDcstFJ7NJybskD01oHT6lJzxk4Yct5X0RWD6wts2zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(54906003)(83380400001)(66556008)(6916009)(186003)(316002)(8676002)(66476007)(66946007)(8936002)(38100700002)(6486002)(6506007)(6666004)(9686003)(508600001)(52116002)(6512007)(86362001)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ms3MhJKZhToTEDTzStt3w2zb3YcWjOvrVLnovlPh3sShYpH9tRi/YZR/MlbD?=
 =?us-ascii?Q?EJI/oSjM99jLFcKJYUgl9afs8hy3U96bZvflZcJRuj8enR/FMtf0Ct4rDQVx?=
 =?us-ascii?Q?7IJngS4rnpsFyUBjw9rKrZHDIFyG76v/84/v0vowjF3DHHbKOgsH7msoZn/O?=
 =?us-ascii?Q?QJlhv5Sd83aDBHdtHKqzUdpqypTwkkQnPVi4bMMMZACD0oldXx36238zpF+8?=
 =?us-ascii?Q?IyhPXDh0//WCzhNWPxH1Bv6WDR+QIzy6ErBGNZ+lwZFjGAvhRpAFt6df8EP0?=
 =?us-ascii?Q?Ht6SKqPpH6sAAJoYuWTGTWmcHloscv5Xy0kt5nprvSR58WCQ1XFrz1UY4F2c?=
 =?us-ascii?Q?CCzJCSiXgnT1aTBEuvkkgGNVwnWtzoKspoPHmgR1XMGDcSjGuhyfezR46VPJ?=
 =?us-ascii?Q?y2IRmfoxkv81LUVujov3l7B63eeIcioObSi2qxYICtLfiqFMor9Nj0sL/MEG?=
 =?us-ascii?Q?FuWyAFboVaoIRg36a0r7SymcdzKTjg5DB8o9+NFoGlbMF9eRregP3DQkLF+q?=
 =?us-ascii?Q?gLOBwF6CgbMS55XJ1EqK1giQDooaONXDcOIVprtiLjO3cFqG91idNUZmG99z?=
 =?us-ascii?Q?cKsrgqSSZHQNqWS3sn98cJOcI6ba4a7IV2Y1yTE6BHne5qGqGYRE99VUtnyB?=
 =?us-ascii?Q?QQOXK7J/GjzNC7VIjM3T5FjfzTvlGVCnmYAwtQkgyAqclheDYvoC/5bWlE+C?=
 =?us-ascii?Q?BZEhGwi/l9ROZ+80fmdcsUDzvww3pY3MV1bISWPLPcQ5ThB3C6QsLst8Pc4J?=
 =?us-ascii?Q?oq9Wk36RClg111jU8JV2pko60pOcHJU8oKx5igC0LFpBiDqtd3ckb2MI4NZB?=
 =?us-ascii?Q?co0n36bWpnribXlX6f7B8rbV8wGFxwe/RFQiJlwRsDRpKhSsX0edERBeca3X?=
 =?us-ascii?Q?YePorc7g7y/xYEkJXCRLjGFNnkCSOvPjhmZI5r3kCrAjRCwMkSJys+HlyYVY?=
 =?us-ascii?Q?LqX6pYmtEDz8D4IgeXfB8epnp3LRBDGxTSKfPZKYFoPxeqnMUxe6Vf0gd1A2?=
 =?us-ascii?Q?cC+3dj3/eRhpUjNMaBi7khSTHtiMbxYTN8YoGQPFiKZ/mUk0o7BudUNYpOq/?=
 =?us-ascii?Q?gopKci/nCTmcMXEHvFSNXh5h1K0NsTryEAnSsK1LRcfR6vkgGVD5NaQt7hKA?=
 =?us-ascii?Q?WhWMLDQNnUK8JM3BcSOvi6fQ9vcAt0OEj6goFg1ezTIfOLVEa4HD9IKlGdC/?=
 =?us-ascii?Q?LeLhG6U+HMuLT91JP6FLXjU32eEcfX6fjBY2e4psJlUPOFYWXY8PN+m9y3sE?=
 =?us-ascii?Q?O5ROaxlR5QnRXJFLDNK3vQ5rCyqmdSj6F5W4lnNTmJMyXKrViKOXl4nK0Lgy?=
 =?us-ascii?Q?wh8RC1Ltkk7ZjhbWfxuKkrXQGQ5XxeD4UUz8x1HUYJHM4Qek9DkHLZPboS8a?=
 =?us-ascii?Q?smbM2yoHsVKp03YX4yq283qDcujCXKjDPMOyW5T0WHXMnsB2/IZFv4D+gbRn?=
 =?us-ascii?Q?VbSp+TSof1NYsQn7lCbBh2PAFFLWr8QaKT3WCvERiHTnu+o0Zy35jWdcPheg?=
 =?us-ascii?Q?dq9EBwS6P723miYHFRKvuN9KcooEBfrUcRc5GdtDwvbBjlUgx4rnYGA3UxWD?=
 =?us-ascii?Q?JtT2gDHM7MTBYeeRfg4NtfGIpHjeN52riFjOToFX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cb144b-11a6-4a4a-4cce-08d9ecd06033
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 20:03:16.2369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLQdlSJorMtqTaFlMwRicVZdST5aWp8aty9WLZKxPmNy2g6LQj5torTM4MrJ2Stv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3534
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: oFxxgnjyEfaRquUlDtuhRjBhtrx6jSzM
X-Proofpoint-ORIG-GUID: oFxxgnjyEfaRquUlDtuhRjBhtrx6jSzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_09,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202100105
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

On Thu, Feb 10, 2022 at 12:14:35AM -0800, Shakeel Butt wrote:
> Currently the kernel force charges the allocations which have __GFP_HIGH
> flag without triggering the memory reclaim. __GFP_HIGH indicates that
> the caller is high priority and since commit 869712fd3de5 ("mm:
> memcontrol: fix network errors from failing __GFP_ATOMIC charges") the
> kernel let such allocations do force charging. Please note that
> __GFP_ATOMIC has been replaced by __GFP_HIGH.
> 
> __GFP_HIGH does not tell if the caller can block or can trigger reclaim.
> There are separate checks to determine that. So, there is no need to
> skip reclaim for __GFP_HIGH allocations. So, handle __GFP_HIGH together
> with __GFP_NOFAIL which also does force charging.

This sounds very reasonable. But shouldn't we check if __GFP_DIRECT_RECLAIM
is set and bail out otherwise?

Thanks!

> 
> Please note that this is a noop change as there are no __GFP_HIGH
> allocators in kernel which also have __GFP_ACCOUNT (or SLAB_ACCOUNT) and
> does not allow reclaim for now. The reason for this patch is to simplify
> the reasoning of the following patches.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/memcontrol.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c40c27822802..ae73a40818b0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2560,15 +2560,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		goto retry;
>  	}
>  
> -	/*
> -	 * Memcg doesn't have a dedicated reserve for atomic
> -	 * allocations. But like the global atomic pool, we need to
> -	 * put the burden of reclaim on regular allocation requests
> -	 * and let these go through as privileged allocations.
> -	 */
> -	if (gfp_mask & __GFP_HIGH)
> -		goto force;
> -
>  	/*
>  	 * Prevent unbounded recursion when reclaim operations need to
>  	 * allocate memory. This might exceed the limits temporarily,
> @@ -2642,7 +2633,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		goto retry;
>  	}
>  nomem:
> -	if (!(gfp_mask & __GFP_NOFAIL))
> +	/*
> +	 * Memcg doesn't have a dedicated reserve for atomic
> +	 * allocations. But like the global atomic pool, we need to
> +	 * put the burden of reclaim on regular allocation requests
> +	 * and let these go through as privileged allocations.
> +	 */
> +	if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH)))
>  		return -ENOMEM;
>  force:
>  	/*
> -- 
> 2.35.1.265.g69c8d7142f-goog
> 
