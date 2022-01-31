Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626C34A4DE7
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 19:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241340AbiAaSSB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 13:18:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35048 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234205AbiAaSSA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 13:18:00 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VGnVne005983;
        Mon, 31 Jan 2022 10:17:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ZrYiXgnptUhnsLXIpD13wD4hr7rlD5xARxXqkd6ZTt4=;
 b=Dfx90OmDFZg7iNs3FUE/+4SnC1qhW8fgDq3W/ro4WDl0npLrXlmELybOe08EV21sc8gF
 cbD1mgSghaw3uByL0WPet0zkBLkurFiXTulZc9WTcOroslJ8BgqoPVW3+pDtajXHzwkh
 yHFNei/ScDa9e3nSWSCa8aFL5UmLF8D84ns= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxh0p1rda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 Jan 2022 10:17:37 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 10:17:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6zlM9X5EsuESB4mhVB09X3AoQhA72x50LGKIpt09WNmc46eriNkjVSos+j+QYQmpBlVLzqXoJ177pmzSk79VedS1pAAvvVZXVnM2v8DLMhOTxXClWV363ynPuXYWEN+D1Pa7uumCJ0+5tOwZear/ogzJSW4UiGj6PlScatxwoOmLZan/SliAr4+HSkhHb9PK2hiTQz5OFGpFHuPPzAZY2/vGz8Xt19xBbxVmDI0BlNWLH7uBAp3VQhJ5JIRTWgm1i4xFPRCjT5h2vmLSm7xS2nobk35Fbt13b293SKNvowaR17qkdxKrvfADQsr7iYgAU4K0k4F5QObeg1jPikHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrYiXgnptUhnsLXIpD13wD4hr7rlD5xARxXqkd6ZTt4=;
 b=geS4WrBetyfxzvZWGgAv8NbkAVZaLxXTqhC7TvoAywvN5YgEzJHNh2YZdek/NK8cmjB9wa8t9Ar5b58oLAj3uBSOLKiqXZFCda+pjSptAtg+no6POo1DCGgFGFBnrsbopZ8C9tY9MqI8vJqDylfI130Kl060g3acKdpSSALqjfifZnOcZaglJJqOMCaooJiwbm2w+2YUyYmsSUWx9O1BoST2uyRjYTPd9Xp0v49Y55duJcuaKo3Mfg/csvJrvjdlzwnncOABtybent73FZV6iCL/sSXR8ZQzILi+87yndu8Svjl80uRHoWqDq1jsoSud+jZ3NjJZG3yuSomC6/QzpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by CY4PR15MB1352.namprd15.prod.outlook.com (2603:10b6:903:fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 18:17:29 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 18:17:29 +0000
Date:   Mon, 31 Jan 2022 10:17:25 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Avoid redundant work with 0 size
Message-ID: <YfgntbGtfPB7nblV@carbon.dhcp.thefacebook.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-2-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220129205315.478628-2-longman@redhat.com>
X-ClientProxiedBy: MW4PR04CA0311.namprd04.prod.outlook.com
 (2603:10b6:303:82::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d43841a-1311-4d00-ebfe-08d9e4e5f131
X-MS-TrafficTypeDiagnostic: CY4PR15MB1352:EE_
X-Microsoft-Antispam-PRVS: <CY4PR15MB13527FA70CC06CC5AD3C416BBE259@CY4PR15MB1352.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: day3PZ+lVT7WiCAOq0MyWjXkXopt1TN9/TCtsFmeRbJSv3JhMI4c5uLiHfXRfPgl0gORKUXQzuhuIdjhYkMODMg8U/VH6WQPV3kdNVMaaN+NAkjDjhfH+ok1BmT95awdrJZ6MuvGZ4cXfUDP+bftsRuJS/Y/VE07nGP/MC8N1rZ+4f6P44DFAx0rU3heHbJ9i/qG0hK86L2PAWV6bZs6IpSaSaolnsWdJ1JekX+uVvLvmZQ65SInevpIrvdJznviNPJ1dO7XGqcj6FH/+zRiWMLudBilXml/wzPUJiPRElqjusifiiODhIVJGY5TZehfs7PgEJeTnQlOlnpUG3QVBOYUquqTMWhZpQCZzN2/HLUE5/kx2xd86Vjim8+N0fKAyfPLlx4UKCCW2YG9bkaj1YGgilCwdCTv2BfVG001u0KV+0l4eZypsHDYGIGeSfUDe0uWWUE6PxFCzMvh2bgBH8p/X44CFO2RjfCETht28IWmY+D0mrZ4R9DSpgqTEeH6s8LyixyPnxDxq0W3wQNY0b5HCSm1OC8NsJ3OYAqxBd6ZEz/INRLgm5YDj/aiJyfUPz1jl9PP6mAA3rGJpVgOfj3U/pGef63U6Egc9YMe1irzCW4IYQwfn/ml5jGE7leomZ8ONiz43Mo9JepgbhMetg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(5660300002)(6512007)(9686003)(7416002)(186003)(83380400001)(6506007)(4744005)(2906002)(66476007)(8936002)(316002)(86362001)(38100700002)(6486002)(54906003)(6916009)(508600001)(4326008)(6666004)(8676002)(66946007)(66556008)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LgLHk+CFlFrJvx7xbvoRWvdLAMLkcOsBPxkQF+odL6rzU4HHgjJ65MGch5Vw?=
 =?us-ascii?Q?5op5dMqsNITtWw2Mf/pnX6BfiRhUmKkWYGreJE9LcLFFSQK40Ruq2QSSdyWN?=
 =?us-ascii?Q?7jwZ7DIKLc2sOVBpg9elQqm4TzPUCpsBLncM7LpkAnsDeRxMoL/MbxCiRRIB?=
 =?us-ascii?Q?U4fepIAL7N4QHqsj0ZzjeL/FnxDHYEohwjOZZ08zkBBSAM6+NPnuqBncwi1r?=
 =?us-ascii?Q?tGLcoMBkaMztcWDU1JjK7Uyxylrzbar5pBiTuUzm4Lvt44FzsDxcTnThmpxX?=
 =?us-ascii?Q?h4UykGHq+ArfeTpbSUHf+gNtCzM9fnG3R/mzAykZ9KdImfwMefs2pv8sNbZW?=
 =?us-ascii?Q?hR+ebayBA5czgYTPPrCfVs5oKwyt1X+QLz0kYLJJjinmwrjAkMHuTbT0rIgE?=
 =?us-ascii?Q?itiHfC+01WbBZ8hGgtuD4he9q02fPuJngfrCwqm1yqr05OfwKPVFz128EGgB?=
 =?us-ascii?Q?sgBm0+qU8SCGN3ni7784PYIE150+aBngbbU3/JcMAFhsrEJzuLiKbYFUIkH/?=
 =?us-ascii?Q?FoIw99WOG2bjgPVMzX1k4UrDCkO0qGakR+sXAtJ11reqsUmdlmnrn2670trj?=
 =?us-ascii?Q?jKHSBX4Ad7J2CGk4xu6YuA3E9+nVkYQHUXC2BLAh9KPsDYrr+kMJV/U5YRa3?=
 =?us-ascii?Q?Oi2yCxCNMIm2/Qm74zvIL1+qRnsDzR1Xr7gX8p2KYrmlQn3fvSJeE/KelTnw?=
 =?us-ascii?Q?DXThBns+RP7GPdoqfI8mT6klRXA8SBahBe56fLCRXD1hYbnJT5awYar3wYhK?=
 =?us-ascii?Q?u5BoqKlBFvqOXK247t698SGDRLGURgQDgZrU8QVWgtZr3He7z2ohmcvyz2iK?=
 =?us-ascii?Q?Oe0pj8YTvjprKfl8qJ15MLJZSrFZyD1lSeP9Ax0sTYpSx1ZlASN5rxk6nuyb?=
 =?us-ascii?Q?I4QZYCaPeUhmSFH4gCHKTXDmEwJUDQHrBU0bvqAVbO2b/6xQzJKPPpEyou3+?=
 =?us-ascii?Q?qAlN1ERH2Abplu16aALyxLztbihfVhhjs5uNHkflFUc8KC7fr1XVIWSJTBkX?=
 =?us-ascii?Q?F52ZmXRWNYYK9yoaXpMTOQdDQpKYYoIdJ0Ud3kbm84JiZLxedClJzi6zL4d/?=
 =?us-ascii?Q?DG48BMq2Ozm+GMu+cFVxtx3mnfDh7ib1+LgbqcZmipJaiOTJVh0XlPzu8zWY?=
 =?us-ascii?Q?f7cervZZFwrP3vauUf20sStv4z7W9VzU+1GopJxRoiVB4iFEDzyHwDJTqdNz?=
 =?us-ascii?Q?OHZAZCGL7BYdLf1HRffBKlvbNJQ5YaIp2btYOYbVphrDwSB/jtRiNc3cV35J?=
 =?us-ascii?Q?AiQ96r76N09aN7vikZ9+Q4H0h44mPs+h9TxkPU3WBnab6r67YsT7wrb74sLM?=
 =?us-ascii?Q?5kKDPdgfMERd/WnOUIKVV3w7W9HKvIEk/zj63oY1NnNKaRQwaucxD8g5sdw4?=
 =?us-ascii?Q?2+jE1qI/qVUpscCYWJ6z4ctCdLmrVjbEFn8+DpCcO4l6Fw1L63brhHawp+oc?=
 =?us-ascii?Q?DeX2QoUf88fbpJoViEIETUxhtTphW3BN37n3LVqHrTHMYRBUPnq0QYscM62B?=
 =?us-ascii?Q?14pPLm8V52SDgOL0UO1vndr7qAqLyi5g+RfGph/apiwzpurUryRHQczm/V0j?=
 =?us-ascii?Q?8D8rbJxGgD5xZYbiIvwDIgxs0EV+0n6u2f6afQRQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d43841a-1311-4d00-ebfe-08d9e4e5f131
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 18:17:29.6110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZIFZYuA8s5PLotaUQBI1y8H5qWdbsP/MBWDyv7JzcSRpnwfke+Q84ShZboLcxJt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1352
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 2ZpbdnwIO71Svx77BpyZHqbAO33nut3n
X-Proofpoint-ORIG-GUID: 2ZpbdnwIO71Svx77BpyZHqbAO33nut3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 mlxscore=0 mlxlogscore=960 priorityscore=1501 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201310119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jan 29, 2022 at 03:53:13PM -0500, Waiman Long wrote:
> For *scnprintf(), vsnprintf() is always called even if the input size is
> 0. That is a waste of time, so just return 0 in this case.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  lib/vsprintf.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b8129dd374c..a65df546fb06 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2895,13 +2895,15 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
>  {
>  	int i;
>  
> +	if (!size)
> +		return 0;
> +
>  	i = vsnprintf(buf, size, fmt, args);
>  
>  	if (likely(i < size))
>  		return i;
> -	if (size != 0)
> -		return size - 1;
> -	return 0;
> +
> +	return size - 1;
>  }
>  EXPORT_SYMBOL(vscnprintf);

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
