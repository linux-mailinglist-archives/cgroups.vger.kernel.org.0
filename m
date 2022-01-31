Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834B34A5099
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 21:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbiAaUyx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 15:54:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17962 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232590AbiAaUyw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 15:54:52 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VJxPw8021467;
        Mon, 31 Jan 2022 12:54:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=xyyEHXP2nW0NzwlhVNwOjjW4qZDXWl9phb79Ox+4rS0=;
 b=jT6c9H+1pdkY+OfRj0glhrPGxI1Vn/+ZDwzrB9MzPBiATPHNx6fC95Ejra1e5cRi3PoQ
 t3Qq+IKsuS7cdRafE5BAF+sYEMq8TmgkRxDNgD7XYjxYKC3a4T3pJZCVpeWU/EXkcGrg
 Hdr7hMrGVD9OPtnv/o9h+cYSRUoa8rGh9T4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dx6n2w84p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 Jan 2022 12:54:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 12:54:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hextz6yFclYeUe5nAJ4mR2NesC15YEhWCkUmK3/ewjEFyKYGnWApdQ/FzYVUlCglRuZTk5GiAHmp3pUPfVS5BvD0lZ8YahVMSHbmpXTMCCn7GsmNFKtEk6kQozYQehAqyZdn3gYVwsXgzcdUOPO/MCne2bCGNIDhjRSdEg38w/+weVAQlcdT/MB6gbUPxIe6dhU8/iOhfVGoXDsOOuPnrcRlbyJVKgJPWue56sEnsa3pNuTVRC35FryRrrLl5HnhEzN5LPcvVJdGGkoRI7Fn/YwRD9QGzQHxT7kK/zwCGiHJKej1Aileyy37avQZW9i2+HkiMpqYiN1qI6xT3dgbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyyEHXP2nW0NzwlhVNwOjjW4qZDXWl9phb79Ox+4rS0=;
 b=O7QNNQPyzSLf7y+a3cWVa6X+J405X3ZuwZBz7xx76CMXmyzHvf6XMOcqHaKjxnaBCmCifl8lzG9FaKf1+Ow1jUnW4cz8ElkUlfCVtIQpFgQyQs4r5kNIUj5EDS+yrkbdDAjIfBt+rmFX/1V9X2B116Vd2B8A+xOoQt5byrBYB5LrFruPi05h81eshH/ibVVI7G48GPOtz2xrdivRvGWACaJuLQS/i9hb0gvwC0TRN9/oMP6Uu31TB9CoLiKE68ky08yNMb37zHHAJMCHtUwyTolqg3TGGRAOOO8tfbKjHRhKAWF4XVO2qwXAmzJN5rA6oODvby7bT0/Q9uOkiQmn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by MWHPR15MB1294.namprd15.prod.outlook.com (2603:10b6:320:25::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 20:54:19 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 20:54:19 +0000
Date:   Mon, 31 Jan 2022 12:54:15 -0800
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
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v3 4/4] mm/page_owner: Record task command name
Message-ID: <YfhMd5LTzTHu9zMD@carbon.dhcp.thefacebook.com>
References: <20220131192308.608837-1-longman@redhat.com>
 <20220131192308.608837-5-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220131192308.608837-5-longman@redhat.com>
X-ClientProxiedBy: MW3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:303:2b::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e2ab44b-066d-4877-0f36-08d9e4fbd9b6
X-MS-TrafficTypeDiagnostic: MWHPR15MB1294:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB1294F38E56905AE548B3C5E0BE259@MWHPR15MB1294.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bs0cJbwyEZ3IsF4F7y8M08HLRriwbzjUCWrWA4U72oAyMnm17g7+6FNOTl3FjtL3wkRnndqSfI1XE3rKnitr6aQ7iVA8D0piE4rLUvCyha3eZvZ6fUxYE9BqLnSsb3ZcWs9Ip+x8MNvhFUXncpNfGKMyLS7v3E3Cd47xdtFVUVUrodDLG6lmtyPZgfhezsZgS3yoiw3Xl4gchhNi5vHqemMx8zqs23Pdi4hLnmSFF7JGY0WflWlti1oK6Ovp7ZPjn3m6HAyQg3EOJKtyIE+t2Dq32eKxQwmv8LubXU1HyzJxwV2wX/hTPnb/1GZTJR7z/OpmrOObGhvIy1JNaqSzDIK1mf/2UEUxuipu681itRVPudGygA7yE4Bt/7E3yHZ/grDercqWx5L3fy1KO5t5phaYpCDjG3Peka0RWKrpGCJIIbMTxUQHSLn0DoxBtY4Kv8ywMlhhU74TUwEU8EZC5pagSnVLZ1Gdu1APqH23p0c0eANurU6pAs2yhZld+zipft1igRxsfOvuFxrHaHNqYIDP1+BIzK4kjg+WZMWNQ7F6zIFlkoa39D9gN820i5KHlw97vgQ5U3CArGjjw3G14hKqEsAxG79+PVNgjKmRU21pmseBti+asQ6FHFmP3ISnz+mRD+rC25auHhwKRrR8wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(2906002)(38100700002)(6512007)(9686003)(52116002)(83380400001)(5660300002)(6916009)(66946007)(66556008)(66476007)(54906003)(7416002)(6486002)(4326008)(8676002)(6666004)(6506007)(86362001)(316002)(8936002)(508600001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F4kI4+FzbYQkcSajJhwGqu0gI1SBXyYfiMSAfpVN/OMGDXeLz5F6LAd1prSi?=
 =?us-ascii?Q?tDAk/Z8bQGsUMLZTssC00A6+F+hPDfbet2oFaVB3AWo5I1MK+QBrXFRjD6o0?=
 =?us-ascii?Q?tWY/dsxDZTcz9xec7VY/z5Y9NYfkb0lD61TbNwbTmsLaM/+s6cGX0MN6ZK1h?=
 =?us-ascii?Q?KHmA8UiSwXgKubOQtmu7gxGeVLc0MbkpvyVyhIfreIjSOpuUYwloIbbA39FQ?=
 =?us-ascii?Q?xzemZrj+/b68WRVnwEWKJfYREnjT1SM8Q1Cc4uji2WVO4Bqi3Dr+5tSCPPrS?=
 =?us-ascii?Q?d0DAPG1uIqkcUTSy7pf+T7xss/IFxAhS99nt80wkaI/QUvKjzdSYjZwRGjAx?=
 =?us-ascii?Q?gh0HEOwpPjStorN6Dp6F4lJSge3chHlDqw9sQrbcCQykuc7bagQ8cOLoYowk?=
 =?us-ascii?Q?6P61XqaPCqw82d+QhbWUoYOJPO1zadLXqbBMv6zlTaghgOsW4uO0TBjk8zF3?=
 =?us-ascii?Q?xk/46uRzYnG47VLfD1Dmz/nZknKOOm23+PvpPcTTpOex/vxGAFPMYcfPfU3m?=
 =?us-ascii?Q?2/899gN2/NPht1/1gkxCZ9ruU2t0hrqop0mVhkpZ9BNttaltimiP5DM8HIVU?=
 =?us-ascii?Q?3t5mLbsi1ZkfY2cqX1LxyiGeKqZTuXHTQZ8Pio47Wg0Vkbj1Hlz4vxGieMYV?=
 =?us-ascii?Q?PrO7m7rKCRQ/bFPsTneDTT2jP4MbGXjX2WYlH8wLlX2cb53qepTsh29jKmJu?=
 =?us-ascii?Q?bpmJhEDHXIeCrqKcyL42CKBvTyAjqMPAaDdIe82wa/k2MRcUNY0bSmfGkDeo?=
 =?us-ascii?Q?PrN1lywsq6HDdjtZ2aAoSK5YDKJQMhVVAH1sIyROZ/Smk2lbEZ0s9MqWPjQD?=
 =?us-ascii?Q?qXbrtfjy73S+4WhuQMIGnHTkPaznSMxNIxjSFiCCZqutuhuVevQeuDhFtrEP?=
 =?us-ascii?Q?o5i4B3YLad122Lx1NRjENhg9cP9ZJVCJVSNBYmMEe9ZfZKl1TSsz7wiHZzxY?=
 =?us-ascii?Q?Fuhfw1+6ab86d/jcTKbjOjGAp5C+QiBb2uqxXgLBPpHJ6/icyzRFEf5YZ3FC?=
 =?us-ascii?Q?Ng4pqgNvbxFKp3P1RHUMkoeO6KlmzH4XkgrlFWaqNUmFfv6kMnVKH8ZbToEV?=
 =?us-ascii?Q?hXHV2F9uozrrqddJG1r4SyKnlYFxjR/ZY0Rs25Jhq6rT18pJsOGlUTvuey9O?=
 =?us-ascii?Q?163dW0MSjgHtH25+pgLOZS8qDzT2VXgWO0aL9q5082dCcY16CGH3eBgtPWlz?=
 =?us-ascii?Q?SoG0u1mWDMN1xEqT2XsPiMrKLoYT+jpqs5RkGIJmtTGpmYu8ihO0y7vrBaU2?=
 =?us-ascii?Q?7HztINtQMxcPCBo7KHBUNZF0VNgACd0DDT+5Ihw7lzR2UqzLOu9pv3d+d6Gf?=
 =?us-ascii?Q?PDFJ+zkQ/EaCH6RXFwYNKFgNuSDsBqz8j6mfWShARruWCfx8ehhQdjx2hmcH?=
 =?us-ascii?Q?+FmA8SnYp1gHLb1a3dBv7RT4XwOozl2p4NHfmZ28Cg13vRdYkWveEzTVdMFv?=
 =?us-ascii?Q?VF/TciRvswCXLMiEJi63mMTDh+r2j5OAZZE6tOkCKM9grKzBdQF0iNsDTg2E?=
 =?us-ascii?Q?dm+Uuevg2d3QXvZC7S6kF0VxWtah/OjDwFJERLjMCngjOKP2GTmG5wbOPsit?=
 =?us-ascii?Q?q6SSZckLHpXtMhWBMG8BNCDjsnS208ihafKtCqoZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2ab44b-066d-4877-0f36-08d9e4fbd9b6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 20:54:19.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8ouCWjkJfrEPXJZDyS3Lg8P6R1y5yXLVXQP2wgyVuoh5SMPLtJI6RkPvs+/YzlO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1294
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: KD5fzkEGgenCQS62TyEdga0XkkX25X8Y
X-Proofpoint-ORIG-GUID: KD5fzkEGgenCQS62TyEdga0XkkX25X8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 02:23:08PM -0500, Waiman Long wrote:
> The page_owner information currently includes the pid of the calling
> task. That is useful as long as the task is still running. Otherwise,
> the number is meaningless. To have more information about the allocating
> tasks that had exited by the time the page_owner information is
> retrieved, we need to store the command name of the task.
> 
> Add a new comm field into page_owner structure to store the command name
> and display it when the page_owner information is retrieved. Only the
> first 15 characters of the command name will be copied, but that should
> be enough in most cases. Even for those commands with longer names,
> it shouldn't be hard to guess what they are.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/page_owner.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index a471c74c7fe0..8b2b381fd986 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -20,6 +20,7 @@
>   * to use off stack temporal storage
>   */
>  #define PAGE_OWNER_STACK_DEPTH (16)
> +#define PAGE_OWNER_COMM_LEN	16

Not sure I understand why not simply use TASK_COMM_LEN ?
