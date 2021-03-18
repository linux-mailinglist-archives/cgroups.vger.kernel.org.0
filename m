Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC44D340DF2
	for <lists+cgroups@lfdr.de>; Thu, 18 Mar 2021 20:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhCRTNU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Mar 2021 15:13:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37260 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhCRTNN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Mar 2021 15:13:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IJ3vBT019530;
        Thu, 18 Mar 2021 19:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=k381lxwLG2fnstlsplMWqZjJew5AP+0V8oe6V2+EYwE=;
 b=HsVTTUU1EXtHxNSXeSMxPD1EXmioXLiHx665MD8wz3gWrcGrk0XvcOo9k1CJvzxQPZxA
 MtdDiks6vcbWQsVRXWlWmzDs4jHiJbKjhAnLxnMkAdQh8b3Nf1ZN5knLLCh+ix3Ad7On
 jRfeWmuwRQFjsQtg/sd8Hodn00RsHHrkKgsfMaImIVeRQcimKxL7Z/P4HgHbI2Bwt3V4
 nDcn1VrHz6pnTBRKoIynKS0oegoz7go2qly8kee5ib+QYODufTOsPCjlVZVei2c7kRDs
 AGrnwppi+emr6icre1JstUBE9LQ2Jv1VGzXuKKLFZhLlq722fBgNcmOfbWUQ5lgVhMfq /w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 378jwbrr4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 19:12:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IJ4nYo156495;
        Thu, 18 Mar 2021 19:12:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 3796ywkjej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 19:12:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgIsWt2Det5XRzWDpqp7dfeyG8oYSnq/P1w2EVkMOXZIAbIjXXYh446vu6BBQbRwHEYyNWt/fweygdAkiPLCMvqXFhBFGukg9QvzvhcmgT5r2gzumaNrZcXQ4z8WCBcr79j7sTJVkjUTfmWKm/2DVcT0C2kL7gJwIfMyeLPlDbfJ72fJecAmbIiTYOf3KgPq2Hv3/g55ZCAltrGZgWjqKYQ8o2ZxBhCf9PuwuFqkbLyDS+ldNcvETaXeweUA8VJ6KAsAAPm/zRRHD0p6CUIVyLP6H/AT0FTAgu02GiTebZQMkAnFPWPIYQmlN0Kl1c/nCUmAll9VQvSdzVWNqD7uQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k381lxwLG2fnstlsplMWqZjJew5AP+0V8oe6V2+EYwE=;
 b=RYFyuDfc3Q028rRMfgfXxWcO0iuqQkJAqzfE15WIpakdM3Xa1FxW4GkuAuyVmwvW9qPnydGYJ/KfImC2Pi9C4eOwkB0i+TjF1IMAffRyQOqPuhkwGlZgW6vxM3Z1NwlqEm/HKPEj4btem2dsz/D5LGtxBQohZz3tR7DoVmoGL+3wPqbB09lmtRZqfi8xYCqsavQkTxvZPl6kPlDuJuxD6jHsQ3Rgv2Bto9yzracNbDOEaNLJylIXfqESnOhReJLPrIC33W/hswgXTB/VLFt3dnbYspd8ykLsdoyrgIePlcx/yw5UeA5WYljB9u8lEmydRvOgoocrfg1azPyqTPLrSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k381lxwLG2fnstlsplMWqZjJew5AP+0V8oe6V2+EYwE=;
 b=C6aRsDgtrww45gnbuJ+sxvYEGrKacpdTz0RJXRGUjVE5Kb2GnDlz7wF7C+xnnVBDtJwb5q0kM4any6BYiyozF+6NeL8dVwsiTuGjYZGYQ8XygZyVyAEPmQrMPRXGEvc7fZEnuMRNzCXdjqgTEqO6Acj1lxxr3a8V/TiA6i0hzmU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1774.namprd10.prod.outlook.com (2603:10b6:301:9::13)
 by MWHPR10MB1373.namprd10.prod.outlook.com (2603:10b6:300:20::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 19:12:39 +0000
Received: from MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::24eb:1300:dd70:4183]) by MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::24eb:1300:dd70:4183%3]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 19:12:39 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alexey Klimov <aklimov@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, yury.norov@gmail.com,
        tglx@linutronix.de, Joshua Baker <jobaker@redhat.com>,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org,
        Qais Yousef <qais.yousef@arm.com>, hannes@cmpxchg.org,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH v2] cpu/hotplug: wait for cpuset_hotplug_work to finish
 on cpu onlining
In-Reply-To: <CAFBcO+99Ax5MuOtzNx=NrmnUN=+913Sc-DV83ObOi01A=kkN3w@mail.gmail.com>
References: <20210212003032.2037750-1-aklimov@redhat.com>
 <87tuqhrs3d.fsf@oracle.com>
 <CAFBcO+99Ax5MuOtzNx=NrmnUN=+913Sc-DV83ObOi01A=kkN3w@mail.gmail.com>
Date:   Thu, 18 Mar 2021 15:12:25 -0400
Message-ID: <87a6r0uvhi.fsf@oracle.com>
Content-Type: text/plain
X-Originating-IP: [98.229.125.203]
X-ClientProxiedBy: BL0PR02CA0127.namprd02.prod.outlook.com
 (2603:10b6:208:35::32) To MWHPR10MB1774.namprd10.prod.outlook.com
 (2603:10b6:301:9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from parnassus (98.229.125.203) by BL0PR02CA0127.namprd02.prod.outlook.com (2603:10b6:208:35::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 19:12:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 476ed314-c624-4991-c1f1-08d8ea41cbf2
X-MS-TrafficTypeDiagnostic: MWHPR10MB1373:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1373479A9F9D60C9D6BF2FA3D9699@MWHPR10MB1373.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8mawJpIF784pckxKc6ptadYf7/FVmKDIiD4onAUUyHtPmONgWGUeGhvwRja+flyhUTizNKH3QZwnbuPNaGfIwds6ZzXZNz6dJhs8D4jEzFZgFaz6HwEtGIFzVt/msCjXEyai5IMqw11CxeZlQPeFr1xSU27+qwTnYU9VL4QaPP6pDD7KCQpGR/6qM+re/Ro2w5BiwNbml07FDfONJWL2m6yHPa6yvsQLr7VYvPIvi9pyXkojYSu1lSF7ox6gUFmvoTb07j9NF8ZtxAMKO1FAY21/gZ9pXac5BJpKgNRafQ4AmUoWts+5kmG7gQz8BbgETcOTMvTsFf6tTWXUxThJxY2jN6+9X4HQGeFWC8uAxkm4+let409P9Qad/hnGdJQ/IX+i/nA9qn1wUt0in8XlXxAMYoIGb6Rv9BHZ/3Rz/msXOrZuB5/oSZrBuKDQJao1SPPLkbMU6nJZP7a2/Kua3MZxOiGbot9DtJTzoStDualB236/YbvhVW2hj0xER/F+ynbm/BoPpkgnfvQzt4HNiFjOErbIgdeBVASmXmUVZP6f1uzYw/plgihLv7bz+cNQ26OHf8JJ4C38V256ux75JVeuZvzroNSrD7368Q30y8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1774.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(39860400002)(346002)(6916009)(8676002)(66556008)(54906003)(83380400001)(16526019)(66476007)(52116002)(8936002)(36756003)(4744005)(6666004)(66946007)(316002)(7416002)(4326008)(6486002)(6496006)(5660300002)(38100700001)(2906002)(186003)(478600001)(2616005)(26005)(956004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VLsIScVJiRA3QrQgeoj+r66mte1in7+qHrJIb1fTHnBie3+OMUPlWurUtXnN?=
 =?us-ascii?Q?bCFWD0ey2IEq/5cXyIXNfHIhOU6/m2HfpQ5YfXHbucoDKhombNoSv5M3tsrN?=
 =?us-ascii?Q?4VTKOX9fdm9AZDXJL3zIqeO5UPVfwiXbvQAq/rY3teZ4ZJxGld1J3i398DVi?=
 =?us-ascii?Q?m7FDRVos1ra4ZkRV2E5eRyn3ErC/C6KoofBFATCK7MUXM29xkThGb8yVLwtY?=
 =?us-ascii?Q?azyCBupQcHUfG4Yvi4krFS/Y7HENvggDo0ShJ9CMdDy3XcjriIujRE9Yv8Ld?=
 =?us-ascii?Q?mUWdWHtAGwmmlb5Drdcn8Xf0MGNON0VSfKO8teMXdxsvfEh0QWCQcCBAVMdJ?=
 =?us-ascii?Q?rMdT9LBDoWkFvC4EVVps2i4tvzFYtSg8lLMPiCJCqm1R0PSkIZxkMMlaL+U9?=
 =?us-ascii?Q?b4ciawjccg1QrAb3IaM2b3QZxX/5FBXlONSNxvQBkXoBqefI942BWV6KjM/q?=
 =?us-ascii?Q?Xrp5/6DzRIgqWcpoWd7e5weXt43S4cqMtcwGKav/ALZp8rpBoTyqxsP7aLb1?=
 =?us-ascii?Q?EBYPGpYdsm/X0tcbuahNSEYA4tt8eakrNTBeoY3F/3iniW8mlKIsZvr2jYyt?=
 =?us-ascii?Q?Evc+yZ1QSwdJPrNokyxuLst1Z5kkVFh6p91Wzh6mrkWths6YpHxaH+e4wJTV?=
 =?us-ascii?Q?QLZtlADGX7tg5hyHzsj0jnerorJBIhKlRP02dbq2R8ZzM4AxcMygws9UTKbt?=
 =?us-ascii?Q?SWWZ85cZ6aGhl8DL8LmQS+OEKUBPPy8cz4vppn7stSZT1H+3/Iv5yRMizydw?=
 =?us-ascii?Q?W4BhCoZwW6WEKeW/2VDME6LDkdlZ6LOa4Hbn9IoDgecdfUP2XexgxdTC8mj1?=
 =?us-ascii?Q?oEpesSzPseJtc+YmqG0uDPrqNsKPgQdfxUgPxGbGealCDhNMqR5Jl6vcVb5K?=
 =?us-ascii?Q?UFpYxTEP1unRuYHPTZd1Gjwn93Fh0XpkLJgJJF1znmyP8ecMuAPzvYSCXI5r?=
 =?us-ascii?Q?J6zJVUfHzbYDnxB87QvrO8eepOGJQVg4y80PdBPCy/KTdVv+hKk54Sc0v1m4?=
 =?us-ascii?Q?4CWmcDEy1hdupq5pqgEnFMjJsqxYoq2GoR7u3mRnkuWxfV7cOMf9wpybTswg?=
 =?us-ascii?Q?aTvqZYj7vPgUzVFfTezj7hzLoXtkrLd7lmPiXQZpRs5m3z3rBY+nv2Xw318I?=
 =?us-ascii?Q?XbA03y2j2aWA0wNMkaQ8MdsKJtoVpPbZP2DmlJwUh9tzD0DuWlm/oGUMqztx?=
 =?us-ascii?Q?FoQ2WfGo8SPyaao+nyT3Q0Aosn4Sypp34TmXOj4X0/69AzHD3U1TR+gPgV4i?=
 =?us-ascii?Q?MjcZEe73Qlk5cJJOPTaYqBe1rArpfKFyPDrd7SE7UkwtWhKBNbffhmoeU0Me?=
 =?us-ascii?Q?QY4CWVsnxZXqBLgdspdSJtQe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476ed314-c624-4991-c1f1-08d8ea41cbf2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1774.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 19:12:39.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+0tNDlgakzMH3QZsP0mAPPIW9115MKMiQXr17cSqgIqYODq2XtRfO6HTAE7+NvHGNCx+T+aOgXSAyUbJ/cR+FQt9zkkFJhyGutvIFFtNbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1373
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180135
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180135
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Alexey Klimov <aklimov@redhat.com> writes:
> The first section of comment seems problematic to me with regards to such move:
>
>                  * As this needs to hold the cpu maps lock it's impossible
>                  * to call device_offline() because that ends up calling
>                  * cpu_down() which takes cpu maps lock. cpu maps lock
>                  * needs to be held as this might race against in kernel
>                  * abusers of the hotplug machinery (thermal management).
>
> Cpu maps lock is released in cpu_maps_update_done() hence we will move
> dev->offline out of cpu maps lock. Maybe I misunderstood the comment
> and it relates to calling cpu_down_maps_locked() under lock to avoid
> race?

Yes, that's what I take from the comment, the cpu maps lock protects
against racing hotplug operations.
