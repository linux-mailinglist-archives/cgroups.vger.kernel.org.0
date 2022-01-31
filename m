Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B194A5058
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 21:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377724AbiAaUj4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 15:39:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29232 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1378117AbiAaUjy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 15:39:54 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20VJxKlf020775;
        Mon, 31 Jan 2022 12:39:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=RmmASrmsJ4mGblkll99us5TvYRugFNg2MQ0rCs/dFGI=;
 b=ZmvSlPGWWbwEZZG973He8bfTc1nl7eoex4XP+U4JSfESyqXEkOs33LW8i4QWiDuKbYiC
 h+JWrEk4vx9uZpwq3+5bWEDe2PlOtnFiJvMb76Xw9/cIokTk2UPynhoLUPsAzr3SZsqt
 NaPhp+iFcihJmIWjO8zEqjDaIvA2WLOZebA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dxnvmrfhw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 Jan 2022 12:39:01 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 12:38:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUqXegJGbBxU98aD2ra8UzaTvx/tIVfW+P1Xw0NMcOmcgglvmSO7Z3edU4OpetTCo38u2S5HdgRHQQaAJd8ibOlVi0uDnlA4gcq7jeBfLh/oOSw2WCwQXCgJmjwF5E6ddzsFrARvnGjoJ+hgWWMG+2S93T+wv7iAblEg2h1I/5I1ZEKmkGiPW7owuJ8xQrUYuWnbqZNwHkw3t8n+osuv2BjZcOYMufoBkBJ3kitAK87ZdVS/Y3wUxpX1jYeXRGa7+bVMyJ21K70jVgAqea8VTVDFp4l3qffHK0cWf6KDmsDYhqwRKy5SceaPY/AHjdvtq8QuzWvXVmgZ9VeBmrh2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmmASrmsJ4mGblkll99us5TvYRugFNg2MQ0rCs/dFGI=;
 b=ldm2NZyhXbIuYDA8aRK6JP4RFvpWN3+qRSFodLYfDwiBy6akZqgP1Y+stIcetmB+ASSDM0HSrKxIFl9G8bPnYr2fp2xsZtn1k3+BrsFAE/CNU2vGPOtuSnziBn6bWMzqS2oTALmNEBjbILxDd6iWaMnrMoyBEHHCwmLCdnWHu7MLO+Zrs9zBvtHatVi+XGiTTXDa2xPXTcavGQvPzKw8uTFSX5ishtZtwvKPt0622Fo0KOXoqpmmphS1RwsVqlnCL/ZRRGuQPgJTjCZY7xpVytPJPEZSqc36l1EcX3eVps2S+iHylWmIDzhc7ERmnzvB09NCsjQKxGCWDVtw7vZhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by MN2PR15MB2797.namprd15.prod.outlook.com (2603:10b6:208:12b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 20:38:50 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 20:38:50 +0000
Date:   Mon, 31 Jan 2022 12:38:45 -0800
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
Subject: Re: [PATCH v3 2/4] mm/page_owner: Use scnprintf() to avoid excessive
 buffer overrun check
Message-ID: <YfhI1QHRL34QMOCu@carbon.dhcp.thefacebook.com>
References: <20220131192308.608837-1-longman@redhat.com>
 <20220131192308.608837-3-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220131192308.608837-3-longman@redhat.com>
X-ClientProxiedBy: CO2PR07CA0070.namprd07.prod.outlook.com (2603:10b6:100::38)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c470ae3e-4941-4a6d-509e-08d9e4f9b04e
X-MS-TrafficTypeDiagnostic: MN2PR15MB2797:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB2797216C55D06B210D20E7B2BE259@MN2PR15MB2797.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FH8PiVtfZ+KkUVzHfNxFSpgaaOqV7xe+R22LuQwn1qq1uE4w0UKHGM4/o8xKzm5JBZBlIUGqMk9K+crQrH/CJafpgA9Kfez9HCMrMxhkfHIW1vgZ/03cGJNLljF2F6FxBhxkBusT2TE+1jmRGYIsgp9JmK0XAy9I+Ze+iIIxHvloc/wOebaqdmAYJo0GhUPYhe2OqXsal4ip187adkt+xjili5Qmf45Kok6SeT5GmCktTiABi5OopXaW737EyRwj1O5QOENNfRr3sloDPg4wB9YxV74PyYbvi249R//7C7Q0jo8x65RzMMiQgUzHB7gIv3VargA5OVzpmX108SCavM//ZLKe+oq0ospsIQCATvLbzdOqx05RGSaftemQl/5zrm+lWmEqDuQJD3qWSSmyTipu4+qN8yhFKdqG5BOLYmJYqr914Rfp622wPmCbJnjw2nYdIjvA895Nf8Mu5zDkzvStNCASL6ZKjWCD/Ev9PBSmLmll7GysUVAfBqb4iPZUzlYeBCz8Mk35UKneRV6p2pTx/TV1ZRou4Q/apDRbBHh7GnqgmnuwP5JK+zRs/mOVlV7dusemTXLET9Cp0sE9lXut0XV5qOelujuQ/Eu4mChwDu1YPIzlrvDanx6aLOhzca2aQGXGQhw8MW/z7k0i+XlFOitp4lffYstzz+cYRbroIeTdPQwCQipHYqhrBb0x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8936002)(6666004)(38100700002)(66946007)(8676002)(66476007)(66556008)(5660300002)(52116002)(9686003)(6512007)(4326008)(6506007)(508600001)(7416002)(54906003)(6916009)(316002)(2906002)(4744005)(186003)(6486002)(482324003)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iLqvk1wrKzDZAktK7wlkZpVC3ZInEiNvehA48ymsAiqjwmxR7WbnD9ZMuAiy?=
 =?us-ascii?Q?7KXOtwkZvdrD6nXpQ3CzJE9c5D+jdVke6cfkGa3thAY2quLqqXSs0WO5tU2L?=
 =?us-ascii?Q?FLCB6loi+RMoG2t+BVlRJjONl55utCeFDJn0WZ+eYSb6acavqBNI+843BvHg?=
 =?us-ascii?Q?8BqdV9GBfFmT9ALdxknRn75DxRc+zVV53Sb07oEvgZ9hiaT4vuDRSQvnJU2N?=
 =?us-ascii?Q?Ajawr3qMGZZoWX0zt583XP/fEc80Edshk8ZbTomYEFKjMWAJhl2zrwZncFMg?=
 =?us-ascii?Q?NRLAto145vLpU6sTS6L5qJRDmwQZDDToO15shTpCsvb7YhG8EEyouIY6lBlL?=
 =?us-ascii?Q?75vuuWAVii494Z8IyVOqRy9qs4N6eloyeaAKosAqxFULjHPztCm3X0EnlSb6?=
 =?us-ascii?Q?1H7KCGDJbAxe0aGh6Skc4XfeV+W5CVvNpi0J7qoVe9ipu9Ef5GCcWBbZAR6i?=
 =?us-ascii?Q?f584v7VoyyuREtQaNd9S+UE0wFGcTVMq1af0sIGmisWH6l7rMgKWLPRSdWvd?=
 =?us-ascii?Q?a/X2iMnL6y06xd/nVeDWN7//VysXnSGBrUvSFeNq2fChMLRjVRo+FjgreB5f?=
 =?us-ascii?Q?KkEeKUkGkdGQ44gWXk/H1QtvceersmgiWnsPGIUoBi79GqcTrvv8apZg+aH1?=
 =?us-ascii?Q?Eweg2p5gSraTZU6c4AwSl4+pzsc30eRQhAQnFASOn19QqZFbVn2E2DeSNHTm?=
 =?us-ascii?Q?pB589UXeytCsnJYufg5qWjMhWsZEyCZFCmDn0AXxI9sy9Shyv2EWUSZawdh5?=
 =?us-ascii?Q?/ZjH6ilkO8IwbTeHd1uvYouzUPndDy44EjwdqCMPilSqAM/JaHSniz9ATeQw?=
 =?us-ascii?Q?+0uz8eN8wzvyXjX2nLnEpFKg928uDY4ieuMdM4OTiwRCWMjpSRHTHm+b3BUi?=
 =?us-ascii?Q?PZH0nMJZJCidGjuDaDYZPFOEEZ1ZfYW9i/pxMqLeSyKF0AS7mLpuLJm+3PI9?=
 =?us-ascii?Q?C1aQtge4TxxeRq2xq3qAVteqxDeftNk45i/1GznB6X82h6Vsn7/fO5bsElF8?=
 =?us-ascii?Q?hRJt4A42TX1pyW+uUTx6mJnyqSRKe3+bYYseSBfOFlWZGY1OzuZ4r+EJXEcj?=
 =?us-ascii?Q?iXtuBe46Wv92wEW6KlK0BXW5ypJ43p2Qond4WDkuAyptW0N5d1jjTM2td8Jt?=
 =?us-ascii?Q?vMS3MGVHRPxnrK75foct8WdYhcLHeHSSDBH7ivhyiTImEUs5uWJnTgR+yaaT?=
 =?us-ascii?Q?pL3R8cLI+eXLTaXzOavpJRtZozajwZoazQQh77tgc6VWz9c/e8socswio+DL?=
 =?us-ascii?Q?Kq5lP7x50ZX17p6mI2xc9Y/4318Lzs23G9xqpejh5qkHQus84cfcVGsCm+bX?=
 =?us-ascii?Q?cR1iX1nlMOU6UvckLnLyCmuzP4HEf+iyE2Y8Mg6fq9G7NmcZKtBQdowXw6GG?=
 =?us-ascii?Q?ShL+HuWJ86i56+/xC/v6CDvbeeBM2ZWlehlfCRy/cTatP34i8cf5T+rENhDt?=
 =?us-ascii?Q?NYY7Poabt9RzDm09kPz04ehH33bchkEckj4E1NKGdgSeBeg42QY+1MmecahN?=
 =?us-ascii?Q?bJX0j6cmpTeq0eMGcYhMH4xYC0+tXuQr96Rs8URx36OJN8fGvYKcHV4LCnXU?=
 =?us-ascii?Q?4+wLNfVhk8U7+yxiSYndu5aI0tgslYpEzZRAGaCp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c470ae3e-4941-4a6d-509e-08d9e4f9b04e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 20:38:50.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CT3h3ebv6Yo5qILYPv6KQCkIuk2cTvkfcpQQpDyrrvdQTKOGFjOc3/rBk25erwZC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2797
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: qjRv0hOVlfyu1gougN509t9q8LFm-7fZ
X-Proofpoint-GUID: qjRv0hOVlfyu1gougN509t9q8LFm-7fZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 02:23:06PM -0500, Waiman Long wrote:
> The snprintf() function can return a length greater than the given
> input size. That will require a check for buffer overrun after each
> invocation of snprintf(). scnprintf(), on the other hand, will never
> return a greater length. By using scnprintf() in selected places, we
> can avoid some buffer overrun checks except after stack_depot_snprint()
> and after the last snprintf().
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Roman Gushchin <guro@fb.com>
