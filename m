Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712934B7B30
	for <lists+cgroups@lfdr.de>; Wed, 16 Feb 2022 00:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244804AbiBOX2G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Feb 2022 18:28:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244406AbiBOX2F (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Feb 2022 18:28:05 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DBF2B27B;
        Tue, 15 Feb 2022 15:27:55 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FMa5Z7000917;
        Tue, 15 Feb 2022 15:27:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=9YjoEPMJYd+J9jPuyADgLhWKC5Rsz82AyQjg0ogfSgw=;
 b=cv6r/R26IwDLGpQQDvmB8iZxRTpDEbeQrW4co9PGz77pUCg8W6ERW+mrpNKDlLP6IERJ
 cs5Yn51ECW9Euwm7ATOq+mptungI0hKzw46TnMX1LKULWO7B6OeKurOBmrzJ90YtJj3q
 J+2S/ZtQvt7hrxYs3rwphmX/R/TOHizRprA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e8n44ra4c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Feb 2022 15:27:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 15:27:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZWtJCh87IUXqbsC8Wj7tq2lvNSHNbCtGvAB9hNDb4f5AOCa2JSu7SMgb8gKQ1IIoBgyCrTetfVLP3ljJceJDkdnEp8IElMz7JuJv8EvUiHW40MhpYL1gf7PnLgIRNQPRUDiVJ4kJykehD86jLzH8bGQ8AJ9N7Jrk4FD35Q5tDy1HIaHoELH5Ter4e5fEWa9/KdelIME65o+hrTrsfW2Ezuj8UjJakJB9MBRq71pI/cdEyY8Cw+at8x0Tvvj5qlP+KCLfgmboqM6MamyCFCQ3tyInW/OkXSXCUj5+YUHNJNFIbT8UUtGx6c9Blv3F3DxOVxrRui92Fm4QA/6lB4dNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YjoEPMJYd+J9jPuyADgLhWKC5Rsz82AyQjg0ogfSgw=;
 b=WND+8IXXkhNHN/E/+ctNQE/3fKoVLZiT1XUv7ynsidDYeO+f9U8niohCbpfh6suhHS5RiOgyUOMfXOesM4kntD0/SyIdeMOiRjIazMQZfG1I/ORSGesQB+NkzQz9S60wjbJN6DGp/3mzJIQG1bYA6D8s7/8hOjCexj4446rE9H7/Ls9MzccVt+nFGVFYGF54nN/DKgjwtU37KAOU1JxHihWvg8KXVQ/eO93Mxu2nW9yh0GElbNHP4DvK0ykHfkhsCUD1p4YLLA6W7VTg+2IfJfavsgKx7S41JfI07atoDeBE/5UiRJgGuZA9URwjVIKasIRdMGEeyw77P9lBeoqcCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by PH0PR15MB5006.namprd15.prod.outlook.com (2603:10b6:510:cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 23:27:36 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c%5]) with mapi id 15.20.4995.014; Tue, 15 Feb 2022
 23:27:36 +0000
Date:   Tue, 15 Feb 2022 15:27:32 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] memcg: synchronously enforce memory.high for
 large overcharges
Message-ID: <Ygw25FypLsN9ZQaZ@carbon.dhcp.thefacebook.com>
References: <20220211064917.2028469-1-shakeelb@google.com>
 <20220211064917.2028469-5-shakeelb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220211064917.2028469-5-shakeelb@google.com>
X-ClientProxiedBy: MW4PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:303:dc::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f07bad0d-2827-44b2-668e-08d9f0dabfa2
X-MS-TrafficTypeDiagnostic: PH0PR15MB5006:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB500659F698C8C64E7E4B3783BE349@PH0PR15MB5006.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8VkxLF98X8uqGhxZasQd48QS42QBMyk9wZY9bR/qwlcPvLfco1JUM4qGPww61wGl0/rpHmucpGOxyILBqyFuRVUCh7k1Zy7AYkelMDEzKa1Vp9IbrYYD1CPSPXoMdmbfX9rg1TSS8crMaFgXComyu6AxAr2ZHkaJ5POl3QT2T2OYj0nc0shphlN74+4bMy3RUxaaDHsonkYF2T22WOpoougGlggYdgdRRRNoZzCeTl3ARBJMxI5xO40hdJopmkR/DhAZwxDH1invoY4IHpm470UMeCnRjw3E8RBKEJ2R7jhc3PxZUiaMVnBvMgTAsLCziBoZRMqS6jhKSdoJtKIhP5kWGnX7gt7YF/XnE9grFNnGzAJD72nsfcXSev7kXlMsn7H+p31IpFpYDBUIrKN+e1ANSOr89bR6fY5gzB+oH5iNzhcpE/8ZDnaTqQ9u9mlW1XV+AJ8Z1Dnzh1MNXjyouEQ77UjpxS5Uhikfz+qUI6FDD5mUJZsXYch7cDXu7IY4Ybdk4ZZuoICJbHBIm01Xnx7AGjahP1zQDqbYyZY13N+gYvok+H1PCrQSxtV9gYOdKC6pNsnRVN35sB3zhtnu20CFMp7fso4B4K+j2KoIf0wXF+fjFIF6odtR7LHxrtjM9nzie0u9HOPQbdoBEHutag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(6512007)(186003)(52116002)(66556008)(316002)(86362001)(8676002)(4326008)(8936002)(66946007)(6506007)(54906003)(6916009)(6666004)(83380400001)(9686003)(6486002)(38100700002)(508600001)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ec9reGwEdspMnFnlW9sN9LahgOGqq8xhq29+pLnObXfj1t9+0u6S3ZwH+pgB?=
 =?us-ascii?Q?7eul984KulWrUm/GgiIn6P250SYiFBFQRy/+O1KozeFHIV7z9c8ynVJT13y7?=
 =?us-ascii?Q?CQ+PuUqp4f4bdso3w0qpVef562S7KXNHXvvaUsXQMH9QOIOjsAzhPUqGYBqW?=
 =?us-ascii?Q?hMD63YeDCEZthRJ22wVGc83UDHgEeQVzGQuDDhcMtMeG6YNM5+iV51Km0LOe?=
 =?us-ascii?Q?PKrpYxtrvkavzoYbT2ByO+bMw3rMrPLJ/prYXjVII727sEEQq5lkGe/v/QEg?=
 =?us-ascii?Q?vJu4N0971noOWcoTJkn9m1pm78wEaUGvzLsNdHqdY0dGqLSYAdUcOfSxSwux?=
 =?us-ascii?Q?O7ScgdCrL8NLLCF/VdEuvxKvUVzgHbawUj2zTHtyEwUo2aJcdIY4BSpj/zrY?=
 =?us-ascii?Q?Pwz+8LVkHESqZIwNhgJdE8ERLegdggMAydznhn7Pd9qfbcNmsHNC3Ib8tZfb?=
 =?us-ascii?Q?CmTkolVLp55gu1QHHQp3k70b8PkgrjprsGwfbDsDtHJxa3UbhHqMFfWIDYct?=
 =?us-ascii?Q?/+mL5rHrbzv86kTtkXZBNMgxHFs4NO0PNDl5IqrtTpiMwS79SUYSY6hrzxKT?=
 =?us-ascii?Q?P+n+yCis7GA0+6uEfeDnPdL+DyND8lFTM7LZcIYhdjX+jq5oMPuRfyIpx15j?=
 =?us-ascii?Q?fXrnyY5un3Urtsu47Tvr2cq0eeIsC84OsGuZjHEQAGi9xRQaJCWrVB0MbN68?=
 =?us-ascii?Q?FUgHLa2E98HdNhVyfSL4kaPpYA0QYhZDno1fqUhwrFZfginbl8vzVEZhgk6m?=
 =?us-ascii?Q?mnaLP5eASR8h1qHN56pmeH4c+OkEhYWD6wSqGW4qauam/5zbTlnRvu+yrQue?=
 =?us-ascii?Q?PO3vTylDrHyW/yL8gu+x1D5N4JWeaOXLl+NWg06TK+l+8OBQZ+mEU8svI8xN?=
 =?us-ascii?Q?wGcTQvba31I8j6316RkVdjx0mc2exd//ciklUpchoXRl6QOiF+OILZyEOkYJ?=
 =?us-ascii?Q?tC/T5V25V1DL6tZPd23KWmDrYuRCwhw+2uuuGe1o+WHWRR8e2atwjyuHjp+t?=
 =?us-ascii?Q?avmQTmFXO3nOtUYGEHaeOyINsBor6zRmXuId9PmKC2wke3aICul/iVxKEShB?=
 =?us-ascii?Q?M88LAZqpFL/aPStHvDaOuieCOk9JuAr0573a5hx2b3yfjiOYEUsTaIn1TM47?=
 =?us-ascii?Q?JFUHzSB7M2MdWehj/liyD76Q/LWZjXnA33uJZ5oyOonQdQq6xQF+79mGBQSj?=
 =?us-ascii?Q?/DBRr0JUill7dI6pbtn/65ucF/67kHja5SUc+3GgN6NXjF+iugwOa9lM5kfD?=
 =?us-ascii?Q?v3Gu+JOCh4D8NJViPsc+VKfQI6dRD+QQUHrz9T8JYqIsrzGug8kxylW6DKE9?=
 =?us-ascii?Q?GElweqdFI7jiCbMCjNNJjHSfR0ftPs1zpzndTL8zCaNupHtB1oMHi/w7amwa?=
 =?us-ascii?Q?aLMTmifGgday29iTDYCUkexcztZDVooZwZcc/90TU4n1K80/SeTYZxrpBXVR?=
 =?us-ascii?Q?ccVemRQnpqJNlNQ8WSelvjxk7eKIcpNdOviojQvd7VpeF6hFiQB07PfHv4sn?=
 =?us-ascii?Q?CdpNZMJtpmkaF+PjFqKD0lPSi2vHox0tsGdApbdjthVga5DVHZibA76gckdE?=
 =?us-ascii?Q?Ze9A5lZTSHEg4s++LdZu9GT+z83+rzu1y/hKscH4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f07bad0d-2827-44b2-668e-08d9f0dabfa2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 23:27:36.5294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cw2VgEVw/i33HWc/FQ8/0dsSpnJjAgsUMMcYiOAE7o+m1wS6vgR52VaUiZ9mmX1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5006
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: X-44isA-YBAyKgBzVnMuC0thiY_3NmLQ
X-Proofpoint-ORIG-GUID: X-44isA-YBAyKgBzVnMuC0thiY_3NmLQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_07,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=682 impostorscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150134
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 10, 2022 at 10:49:17PM -0800, Shakeel Butt wrote:
> The high limit is used to throttle the workload without invoking the
> oom-killer. Recently we tried to use the high limit to right size our
> internal workloads. More specifically dynamically adjusting the limits
> of the workload without letting the workload get oom-killed. However due
> to the limitation of the implementation of high limit enforcement, we
> observed the mechanism fails for some real workloads.
> 
> The high limit is enforced on return-to-userspace i.e. the kernel let
> the usage goes over the limit and when the execution returns to
> userspace, the high reclaim is triggered and the process can get
> throttled as well. However this mechanism fails for workloads which do
> large allocations in a single kernel entry e.g. applications that
> mlock() a large chunk of memory in a single syscall. Such applications
> bypass the high limit and can trigger the oom-killer.
> 
> To make high limit enforcement more robust, this patch makes the limit
> enforcement synchronous only if the accumulated overcharge becomes
> larger than MEMCG_CHARGE_BATCH. So, most of the allocations would still
> be throttled on the return-to-userspace path but only the extreme
> allocations which accumulates large amount of overcharge without
> returning to the userspace will be throttled synchronously. The value
> MEMCG_CHARGE_BATCH is a bit arbitrary but most of other places in the
> memcg codebase uses this constant therefore for now uses the same one.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
> Changes since v1:
> - Based on Roman's comment simply the sync enforcement and only target
>   the extreme cases.

Reviewed-by: Roman Gushchin <guro@fb.com>

This version indeed looks more safe to me.

Thanks!
