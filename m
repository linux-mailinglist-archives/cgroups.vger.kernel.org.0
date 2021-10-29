Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534E544012A
	for <lists+cgroups@lfdr.de>; Fri, 29 Oct 2021 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhJ2RYW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Oct 2021 13:24:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1940 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229732AbhJ2RYW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Oct 2021 13:24:22 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19THE6B5020569;
        Fri, 29 Oct 2021 17:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=2sWDVwzigqWs7t7Psm7fio//xf8iT/GtRo+3ZSvQHgI=;
 b=Znme2SpqqAQwGf7LQlpr6mPwhCcPxkNPBdJHjTTA7iW9T9Nq7n3k0yEGiTUEJ4FmZ5rx
 a9vjfrS17zcIw3vq0VZ+oKSB84xpR2tGVUbkqMnD5fdYEdcTdML8FPKUeFMYT73+vBpZ
 UpB5qcBkIO5XrmtxRB16ZSZN9KjKZszCacLH+K32xGxYP3MVi91kMKZAXUw7ELDYa5Se
 Wvd2nkYtg7zuulGx4wiF42V6IalI7CIUPHdblEn05n5dj8EMS26VgwN3oMwm+O5ctqDR
 Wfn/17u+tu2ORzwrpDuQr/pVtLwPopPI8yj17zi9phryORncvAlDu4NBo71EBXelM6eY Ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byjkf9d3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 17:21:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19THG51D030246;
        Fri, 29 Oct 2021 17:21:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by userp3020.oracle.com with ESMTP id 3bx4gutxqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 17:21:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHcLeTEEzBq39778II+uLoKmnPLdBYfhUXIxsesuzWJ5eJAOytAGfPK5iCHD6T0SPpy3esEgVfSIvqQo3E22JcMud36SvJXVlw7ZXQbNfcTIEUs7S2dC22XW7pp51qHvEpMtzmXmu1UKGKX7926MfrghWV0V/xu6gRfB8AVBy4wIuD54RawdBkRRiN2kraYpiI6gdskZgZ1l5cE9G9yrcmyGhPgwo5PRIe+Smx401qMdrIHnITKDECP43Zx9CalGYCRMD2+488SsvdTWs7VetO6BncYCMEEFAC+9+QEXVQk2EsDeRanidTf+zNynTUrugghrA7QhXnZWLxOE1OKivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sWDVwzigqWs7t7Psm7fio//xf8iT/GtRo+3ZSvQHgI=;
 b=lNgI6zGJW5sy2XsFhiMEYP4alAnpKuq+s6ZIZzwjPypNc2aJANQxosV/vSkKmz+FfwAEx/bL8v0fx9ZNQ3npJPuMjLI1m3Ej6NpNuo+7q2C3mByOGq4l2X4CRNQaOnBOGae+hrZxLbYHKVfYx6HLSe9T6rWGcHX5A/rKG4oZy7FvddZ0o+6tK+Ih36n3wu+m3tJDqIQo31jm4anKfkexVmVVzM5NKwxy34p1aPtDHy+TmdwB9ASShbjpT5cmGrwvpup1uZk5/r/NJqbz/t4+O4PE/whKKJN9og3kI2WWkD+gDQo55jQlt3kDLdYtU+gDWF+wFXqyaziCp0byUznoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sWDVwzigqWs7t7Psm7fio//xf8iT/GtRo+3ZSvQHgI=;
 b=FtOLzYP6rzKZ5pM0O0yxkToDVvcTGN3tkIuxKxls6eKG4pnVPDlmHd8SwOxoo8/PYiMQwJnQcoru85UdGW+CQNgwULhFXy8OAia49QlF34OK2i+KNJXQLs4dQLURMWpkNTcPPkMFcNyyjuHLuGZMkhLfqrmAbLEnK9p5YJMjtHQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BYAPR10MB3029.namprd10.prod.outlook.com (2603:10b6:a03:8d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 17:21:36 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::938:e546:a29a:7f03]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::938:e546:a29a:7f03%6]) with mapi id 15.20.4628.020; Fri, 29 Oct 2021
 17:21:35 +0000
Date:   Fri, 29 Oct 2021 13:21:29 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Boris Burkov <boris@bur.io>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <arbn@yandex-team.com>
Subject: Re: [PATCH] cgroup: Fix rootcg cpu.stat guest double counting
Message-ID: <20211029172129.smeyk5adocjrwtlb@oracle.com>
References: <20211028221528.2174284-1-schatzberg.dan@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028221528.2174284-1-schatzberg.dan@gmail.com>
X-ClientProxiedBy: BL1PR13CA0418.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::33) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
Received: from oracle.com (98.229.125.203) by BL1PR13CA0418.namprd13.prod.outlook.com (2603:10b6:208:2c2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Fri, 29 Oct 2021 17:21:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca252eff-f404-4cf0-e17e-08d99b008eda
X-MS-TrafficTypeDiagnostic: BYAPR10MB3029:
X-Microsoft-Antispam-PRVS: <BYAPR10MB302954ADBBD3CA215AA2CCE4D9879@BYAPR10MB3029.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlWV3/DGetTONJwVl4xGpEzmesBb5DONInhiOWVAN3jZRsWe4ZzLuj8TTyvM3CIIU3uCkUK+HdE8eeHcko2c2M6RdQwbYTUCMBuEuLfnCbnsLDYrCJMRu/IJJwx41LXCTbdl5YYgjStzoiyOLpycEAiszPXQVRZ7iG8zG5S2FxdqU/444ZcOye6b4ThRiPMkbfXBV8wmt/QPbe1gAcWrqpVOp9YpyAsvfvra30nTyKI9u3O+GEiggQHCOj4VEgBHQYGCQbaKJI2l3SUa7KU8v5u6eCrMWLtnNMHjKhuhJqFdahEeEAWsfqpe9HtSe2R3FXicsO3HhWtaaVIOecH67mkzgxFnJtfNMcUu08kL9PkbzrO9O8X8qUjNceB5pF4wICrWB+evwvaeNeTccECUP+Qe8vziRf2dIPM/U8lE0jkSd4X4uwGEYzOh0ZUAsMbrcsv6SDpXMu7xsjzmHD5W6QIhbknHTfucOJxpNkiGAUw3ngAsLvQkLR4Wx5sqOLE4gSW4/Kj52lMQV4yuUJHfYowJZgKDcoM4sbWXVkK3304ce7HV9VO3WUz0vLEdgCLfpMB2YC7pdAGT43WvR5eY/wrTlmufexD6H2Ce+fV6fwvACEXErdK4w3DZXVltY7WyoD/0oFUkDQTGbNofVLMclFyDtRxmcIZ7GCBmXO8zidIfm0mIhDMBZ3ZHgIUP4Mff0tbZqWd7A9chwr6ZIbCxRu/L3+F84zlDV4aUAPBwMXRtrEzrRPUs3rtLDMKvTeohqqWDuXwP/3GZoQrR39/FVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(7696005)(5660300002)(4326008)(316002)(8936002)(508600001)(36756003)(38100700002)(66476007)(54906003)(38350700002)(26005)(66556008)(956004)(2616005)(1076003)(8886007)(7416002)(966005)(186003)(8676002)(6666004)(6916009)(55016002)(83380400001)(86362001)(4744005)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z7hD7L4Rr2orsX1LjzNWg0mBWyvuKBfPGjarfZU/HcRhByvQcEDg8YF7tgP3?=
 =?us-ascii?Q?kOrkXJz4x0vdLV2vb9DPOepfsqSayq2MU9qdmm8ZtlNbztT8QJR+eJGeweBk?=
 =?us-ascii?Q?EeReBQKEAuisM7DmcD6WEjjRuc9nfJpUT3co1OcxQ8MyOCojH3qQy7x2sBfq?=
 =?us-ascii?Q?c+FT/Y+KJiqzlWScVisGgGYYM5vSuQbC2uXBR4MZ/ZTAh8xAx09mZVRfWbgn?=
 =?us-ascii?Q?Pyr+ep7Y1zR3YB2A12TdOONmXGcEMiCjn77cP5kxe45qFBh30ltelfTJ0vpp?=
 =?us-ascii?Q?KLvl/JjQSNYCeJV7tmOEIaJNdnDIYzkLPpReEZB5QZQKQNg/Q+mw/2xHOoWX?=
 =?us-ascii?Q?YztFlp8bJ38xVHTqZa5hddcfamVKdUTdV8d4S8jLtbXAT9Jf7WtykW9Gx/nV?=
 =?us-ascii?Q?W71Uc3wy6DDl3HOsv++/sJCTO2a19TWcYRExwHBANytGu/9Zgo/uGRWQTdkh?=
 =?us-ascii?Q?9VjSTCZcEIPOSwg0mRfgVURsiYn8YzhNN4AgcnJAwiSxe0TqJiJDuY6uc1gp?=
 =?us-ascii?Q?JpzL7XF//OhXAjO5I7w88Al8bhzmqRJrT6bkhUL682j0R9Dd+Qd49eZa6wrS?=
 =?us-ascii?Q?Cg6D9R+Ce9nq3d9kHmr/LMUBQ1G1JnK5shkL4fX07VFA1EIVy287kL5kYOyC?=
 =?us-ascii?Q?k2rUXonrRnAVaLX7a6An5kruNls+d8rSMMtGYCXfoimTWghYLWOldDUU5CkH?=
 =?us-ascii?Q?QOBdLlJGKOs/gaSpo7sUMP/pCaO8uOYTJ5ax0PkoCZjq0D4yYoEcqYoBAOUk?=
 =?us-ascii?Q?CE/LRwDh7n6OKcTXpik7VLrBRyM2JVxj5z8pX3bca9ooUS4Bzu9nejfM46Ze?=
 =?us-ascii?Q?J+OKYr25mY7XBZHzzn9JptNqFKx+RV/bPrcgKPf7hk7ba/ULD5idbTO3DCDx?=
 =?us-ascii?Q?iow/NPax57egDxmRlhbjqLN6dgqLpgO/geJVbcbqRC/BJi+kHOc0tEmFxtAg?=
 =?us-ascii?Q?FXf3LAujH5/8v7Hs1ROZVhxlbuznRIuTlAZ+QJAwOlwUVOpKDGo754UAXx9S?=
 =?us-ascii?Q?rgxzwAddkzwvEjgb9LYgbyvuu9KnGmgWY91Opx1HUbTwygXXKv3OIDFK6Gmh?=
 =?us-ascii?Q?HiOLGFqgYQ37SJMGnnqrRRwCyhE+1+e+B/oE3goVaQ+KeA7C2gwrJqPZjLfE?=
 =?us-ascii?Q?2uku6Rbi03qHG0LsDEkJudSuXMji3EIBycuuwoW4s8zELhh7o52WMGwlCbuq?=
 =?us-ascii?Q?QuExI/PV9Oejg5QTOKnoop9WkWyce3X/jH2ozZCJ99VwiaaRVLKQINGXfL2Y?=
 =?us-ascii?Q?nwTkjGbElm2dQaN6QnbO4d+9yl43kMXfluwXSrBts5e5w3vw8MofUfkGZWGU?=
 =?us-ascii?Q?1tTwpSp7cUwSic/EZoyyRZJZBxJKp+XgT9GAQbh8IjgzOQeFmSKh4gTOQoVl?=
 =?us-ascii?Q?lfMbI1PDq/nxE0v9XgjdwvhZS5ImXyUx8w5r4YGuIbxisqM+6sGzcAhYcMFw?=
 =?us-ascii?Q?yayi3Ae/5Jvhk1r0RaHyZycMxlWW3E6XCQyNsbeQvPRz9U+T9fRUCFugOWzM?=
 =?us-ascii?Q?BfO+a+3sQk8y1iZgBYcqQXxukPrReucyS48hqt73AATeYnVJjmLDSZmetQ6e?=
 =?us-ascii?Q?yGJhcWZv4YHTn/O4BaNxHO5fxImqy6sKo6NsGhY86FEzP90yOeUb+RTVIqLv?=
 =?us-ascii?Q?S41o9UbxOj2EiIVbTCdAZm3tEKlprtx8edEaMvxJ1GqbWwz83+UmJZyCInXF?=
 =?us-ascii?Q?VJxpcQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca252eff-f404-4cf0-e17e-08d99b008eda
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 17:21:35.4207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kn2unLY9g+jABdX67Vfpcc/lUjVjzlOUUPl4feYplgrIvJ6X88D8+mWe2F+KcNw8mKpGAtkyDIKzWjK6Xx//rSibZO+9ZFHESAAmejE5uzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3029
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10152 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=720 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290096
X-Proofpoint-ORIG-GUID: AOl0Z25NyWf4epKcOct-yLhScpuU0S46
X-Proofpoint-GUID: AOl0Z25NyWf4epKcOct-yLhScpuU0S46
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 28, 2021 at 03:15:27PM -0700, Dan Schatzberg wrote:
> In account_guest_time in kernel/sched/cputime.c guest time is
> attributed to both CPUTIME_NICE and CPUTIME_USER in addition to
> CPUTIME_GUEST_NICE and CPUTIME_GUEST respectively. Therefore, adding
> both to calculate usage results in double counting any guest time at
> the rootcg.

Yes, definitely a bug.  The same fix was posted a couple months ago as
part of a series but never picked up:

  https://x-lore.kernel.org/all/20210820094005.20596-3-arbn@yandex-team.com/

The series also touched cputime, so we might be waiting for scheduler
folks?   +Ingo +Peter +Andrey
