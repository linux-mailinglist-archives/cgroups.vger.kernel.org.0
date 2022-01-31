Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786734A4DE1
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 19:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbiAaSQZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 13:16:25 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52130 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239876AbiAaSQY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 13:16:24 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VGnN39019528;
        Mon, 31 Jan 2022 10:15:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=mqfYlSQGfCmMrRaGr84ijfIc3y+zO2llIRpui2fA2bw=;
 b=dM18ZNTk6QjKyO0uuXYLr3hjDMbGXeyrkbcQRmdAKscZb7yXWuZcc/m/FrSL9YGM7tvl
 tFxD3ngthlsitbJn4apE40S7dVNQGafpKmTw/HAnbgJMkVkeoy5XnNPnV3uMqFGf/lZu
 E1D9qRFnhIr8Iv/WZLyORYAyw3q8P6Cr79E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxer3tedj-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 Jan 2022 10:15:52 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 10:15:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpPuL2qDyhjWb7mxAaMJwEHEv+GwhdphgcySbAc7KxTQFzHQhrmQUSw2Bun5APMEjCSHC9IhcnAIHKPpiH1R/Aef8wQqOHR3B8teOf7JdnYJqUsrEh8Q0tMacxt5yxabvKz94qGiyH6D46UYgs8tId70wW4MFCAlfYnULyp0f14G9sL70NOuIQMNQt4hwbeAgwsZ+KgxKVYgOJYEsZ0aROIEHqW4xhQiQ6tjw6hL+/tJsNcinIixJbaNcAA15LBVEUOebaHhCZlvR1RQ1tc8/exiFn3BiDueUJHpFXyxz6Ez5OhGZdABmTsWNAAWri+TKuHTLblZJ5amos71qf2m4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqfYlSQGfCmMrRaGr84ijfIc3y+zO2llIRpui2fA2bw=;
 b=f1FT8wLsnWatP54CrfsD+aOjjYQyULFkNQDPp77UzUXFWdePU5ANlMkTv7Yjja7vYT4hLO7Cfg+gyIPWddEmL27/NucfGr4MCrJVat0xmEkcLbmJDSHW63Noc0+Ap/qfvs3eCIka8TI6zP1pk/emT1v17NVw2gZ9ddOu4IoT4aM5ScBzgjtsv/4zGWBxolqbdmBGEQFIHxIr2F25Mehm9Ht1uWDxVL4xmMaNcqlyniKiKcSezj55XqM5pnq4Fbi/4jrNJqb4V4tFpikmwOANtrLVppXdU0/pwagdSfmaJbYNXGtQqSPvZj7JUCeEu1w8Hx0jXRiDLQatEyRGYoIHFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SN6PR1501MB4142.namprd15.prod.outlook.com (2603:10b6:805:e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 18:15:50 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 18:15:50 +0000
Date:   Mon, 31 Jan 2022 10:15:45 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Michal Hocko <mhocko@suse.com>, Waiman Long <longman@redhat.com>,
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
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Message-ID: <YfgnUZQBRkqhrEIb@carbon.dhcp.thefacebook.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-4-longman@redhat.com>
 <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz>
 <YfgT/9tEREQNiiAN@cmpxchg.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YfgT/9tEREQNiiAN@cmpxchg.org>
X-ClientProxiedBy: MW4PR04CA0140.namprd04.prod.outlook.com
 (2603:10b6:303:84::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b79f4db-4ece-46b9-7e24-08d9e4e5b62e
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4142:EE_
X-Microsoft-Antispam-PRVS: <SN6PR1501MB414299845B5B18A18DCA2430BE259@SN6PR1501MB4142.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8EvdiOSKV/Rf9woA9qQgIrVgiwl4ON6Z+PAPb7/s/gfEVvlSegURmI/sX9ztkuF5bQ1Uh8tQLAq1kX9ZKjhuc39K+fvoqY2upHeaZE0E8GvxLZOKxhChKooJ8Bj/Y8GbhQBsG4F4688EIzLeYienD8Ym7T9bT6DM9Stuu0ns7SAhfcx+oxC22eqz0y1MOCCsHDx1TmZxhKLlA8SFJKbmqBO692rAVAs8ZuLNnN6wk9bR7rnC1dd7dTpuBm56iJGWCL8MCD+0q2DzsEMPBA2oRzY5cODPyvRX0meFnqWPWDV4QtrJllL04/bKYByxC5vThzIHJjd9ArxunOEFr+UtOnFyRnXNj0fwY4LTB75qAhCFJpOVWQNNOjHFPnvKL+NfPoOkP1YWjwNszQ6fNzjVk8nL0l/ksc7rJEZ5ShKCsDOBejDZO9QrZjuHZ6ZGRXtkRCvIA6eBdPEYYeWwJBzpZ0y3rXR1pNMlwB0v0O76s8XoTsPhWOzP81pEaTAJsaTWvTYhdFR8SM67raFSesldegv2dmke3A2z12RrwWmXiaaWjEkYKxmt8F+8ydP4EzUD8ew43BVw6oa7WVPseZYW5MTXdVyiiDPsavg1vbTybriW9f9jzzdgptnBpAHU21e9f0eQz9WZG+2yKwU9lQxUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(4326008)(66556008)(2906002)(86362001)(83380400001)(66946007)(38100700002)(66476007)(8676002)(7416002)(6916009)(54906003)(9686003)(6506007)(6666004)(6512007)(6486002)(52116002)(508600001)(5660300002)(316002)(186003)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rsx50cKXE/P0J3XnLbQY+z0sRv3lHFjvvAQBbNGHsv8NqKmTcHwd3ahFOjJ7?=
 =?us-ascii?Q?0OHDyKA/ymUjwb7FCdufFUL9AvafG1f9lcLKJNbdFgIIjyUgOWZSte7HmvUM?=
 =?us-ascii?Q?z+5iOCiHJ4n0iNUuBW2VkTL+wY5RL/0mmCFN/BCtAH0mwFhUtMkz7DwdjcTb?=
 =?us-ascii?Q?tIeLN1C3tARHoKB8x3UCMR49MCTnL5I0lkEoLEgOK4P29VOcf5UaOSEG/Az9?=
 =?us-ascii?Q?J4N7Ga8RkMog3cMF2D6lowwGx8zODqjOlwZ1cvFfvTUE6LBSxaxOYuv4Jcvy?=
 =?us-ascii?Q?3GiwBD1Fz0htLE8Bh90DUuyMv0Vt42C+Kqy1edKILJtcAm8ygIryPXHyMTbq?=
 =?us-ascii?Q?pI+qC2mHFizfJ/NPc3PsM6IP899uDSdTkRFSEAJ5s2/N7rpgdqWOC9Kf1zE2?=
 =?us-ascii?Q?L6XZTj1KpfaJyn7Dmde2a2bljHykB+L3ADtgwxwWtygdPRG08IVZ2PWFQuLF?=
 =?us-ascii?Q?UXJHejCAOGCyybjIMhDWzshBhTMZlVWvEeGSIfGNwz7qfuc0I+Qac7ONYoDt?=
 =?us-ascii?Q?ep+BBTrONUhmmCEAdgWAp4s13/86wPAkgQ00AdACblOtfWpQDLgHkLRxyzqY?=
 =?us-ascii?Q?+99kqejbET66fas4rmXx5eQGzg/pGT8F2ehdIRsgZ6ORH6U9desmQ2jy6nUy?=
 =?us-ascii?Q?il0IttYbKCXsDrrJYlgtHB6atbeBkDurxD06jO+IBogPCvoafrxPN97aWRUn?=
 =?us-ascii?Q?pkzykDUum5tnVbIOjip/GKWcZB/+lMC8q5Sj+d63RUlEG2aPHQVyGTF8Ff33?=
 =?us-ascii?Q?ASZxaCGZW/Rb55RYxk32Y4pceRzXTPARwkQPfGzNbYjINqok0CIug6gLbx5n?=
 =?us-ascii?Q?f6OPgNmlRHTrTwDCs6Wt7aK/PVxONemb69qGiJcOpYsi9M3MPNljdgqRAvJT?=
 =?us-ascii?Q?l0tCo8/5K/6lOemc/bqSgKmdNueb+unnwQKSGZX0E7LTzgyEnn9GddqLrBmi?=
 =?us-ascii?Q?WF5sA5YG7EN0rRPwlbPoUPzdnf+6VjMzW03WcyRWgmKwqUgIj8+Vd4RBJJEg?=
 =?us-ascii?Q?1t+fsoC0E3F0305LXcrrxWvPbvOFEbqtzspqq4bhYPwwTwBmDztgWHcyHi9k?=
 =?us-ascii?Q?/kRGno59MSLdefJ8wb9AZrK4wefOXTKhklIAlYr6kqKWD7j9dFVhNkFfXA3g?=
 =?us-ascii?Q?UjsZu5jI8GEtISblbCI6pe7oXV4BCXGtTlRwTk9PlaG9GizjDjz2byZhcWlC?=
 =?us-ascii?Q?u0S79BhFM2uxlT3bedt1j5ISS+YFITHcTJTlrWI976baQz07HrngZIiW9F1Z?=
 =?us-ascii?Q?eupcFc1PQE4x156rc7N0uXT/m3d4edmZhGtEUVt0LJo6roRiUDHIlCnZgp48?=
 =?us-ascii?Q?suFF0vNvIfN4exRSpJ6bb4WIWRaFIrQHZJh7+UquN8CO7vhAGGljwTF/ujR9?=
 =?us-ascii?Q?ilhM0km5Li4/EKkxpwNktNED1LX68tbif8XxPzFckt5+J5m3+hYQlv5yQTGV?=
 =?us-ascii?Q?nnVT1IDJKaAaT5GgNjEgrYyhxjRJMQ4s6kqdxmkra/UHsIfZ41+RLOhxe5js?=
 =?us-ascii?Q?eNWNntjwga99bg0rYCVS5g+O+ZElN9BMxN4MN42mL+4/W15rVcBT8j36Abry?=
 =?us-ascii?Q?6a813O8rI6nnwrlLRhwXlVhwQNzMPU76rH+KuBcz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b79f4db-4ece-46b9-7e24-08d9e4e5b62e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 18:15:50.6342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jI9ryMmAoaiFg3wq6ATva5C3xLQUVNb9uQlZ9u/0FxWJHQDxVnkSBOewJZFMjKrj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4142
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: CROFAq5vb8IYrqMu-o4B9busPsIHLwGy
X-Proofpoint-ORIG-GUID: CROFAq5vb8IYrqMu-o4B9busPsIHLwGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxlogscore=314 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 11:53:19AM -0500, Johannes Weiner wrote:
> On Mon, Jan 31, 2022 at 10:38:51AM +0100, Michal Hocko wrote:
> > On Sat 29-01-22 15:53:15, Waiman Long wrote:
> > > It was found that a number of offlined memcgs were not freed because
> > > they were pinned by some charged pages that were present. Even "echo
> > > 1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
> > > offlined but not freed memcgs tend to increase in number over time with
> > > the side effect that percpu memory consumption as shown in /proc/meminfo
> > > also increases over time.
> > > 
> > > In order to find out more information about those pages that pin
> > > offlined memcgs, the page_owner feature is extended to dump memory
> > > cgroup information especially whether the cgroup is offlined or not.
> > 
> > It is not really clear to me how this is supposed to be used. Are you
> > really dumping all the pages in the system to find out offline memcgs?
> > That looks rather clumsy to me. I am not against adding memcg
> > information to the page owner output. That can be useful in other
> > contexts.
> 
> We've sometimes done exactly that in production, but with drgn
> scripts. It's not very common, so it doesn't need to be very efficient
> either. Typically, we'd encounter a host with an unusual number of
> dying cgroups, ssh in and poke around with drgn to figure out what
> kind of objects are still pinning the cgroups in question.
> 
> This patch would make that process a little easier, I suppose.

Right. Over last few years I've spent enormous amount of time digging into
various aspects of this problem and in my experience the combination of drgn
for the inspection of the current state and bpf for following various decisions
on the reclaim path was the most useful combination.

I really appreciate an effort to put useful tools to track memcg references
into the kernel tree, however the page_owner infra has a limited usefulness
as it has to be enabled on the boot. But because it doesn't add any overhead,
I also don't think there any reasons to not add it.

Thanks!
