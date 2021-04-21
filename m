Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8892636731A
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 21:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245408AbhDUTFH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 15:05:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9730 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245417AbhDUTFC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Apr 2021 15:05:02 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LIxqLo031518;
        Wed, 21 Apr 2021 12:04:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=pmCvH+b8TCN+8GDVAOpl+l0ohuWQx7qmmsTRAgatbgI=;
 b=TB2FjrRSEly2Cw08PBeYWPjQS9JaaW/mgnByv2FONQNU7CyEWTDtDVA+l1PaPq8dq80+
 ess1pQiBkvzOxSNsg+HZgXpeiq9CCIal5/47VCSKPSGV92sxTizkB75V+hC5Cg9/TcNv
 GC+CKD60VD3GdufYf1CX0kKTLWDoQOuv1lQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 382726p2h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Apr 2021 12:04:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Apr 2021 12:04:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUGzmKnNE43GiDTDiBM98cg22BOanMkggJBipjPCNsD5ozYPJhF2mYQ8pjrWp+xguZzhkB7nBZPOtzJLjtDW1Nl/LQoCX4XFBkdgAiOF7bVjDYqSr/BiJhNitbWdmr6kBvmRM4Wr32HwChlWflr/wermRkQupazH6wdp2cRTFfL41Lb6+AeeqA8izKilUO4SDcVfIXptWDdj9kzvKenMt+RDgSR2QKw8jln5ONu1DjzO9rDt5vI+BaVTehxPQVjvv+iasKRjRfTQen1iy6K88gKaEAVOusNSKOTRdjJZpgHTCRcpV/zuQ0zsjE/8kF+Tg627wFGpP/t7CnjIS7Ca7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmCvH+b8TCN+8GDVAOpl+l0ohuWQx7qmmsTRAgatbgI=;
 b=dWOuDagis0b13/z3oGbRnR1ibwsTn4LQhGBvayModzPTYYIyxDQVknjDIGKlERfgVp5vmivAJiLo+IzNp/mtjGwQiROW2PbFGs8cAi355cHzrGPM7uydV3Z7bKO8sYszk6gfT06C+WALfErln1uHeIacDr+y+EN6/XLasZDJ9D+TqN5oSxQeJsVO5Fa+neFLFkkjdhUe9Y2L+Z01QtO6m02ijJwUziF3yKk2pQkXu70NhFUkhTqWNCaGGwx46LhpYUVw8xbLaKjHvCeKnRlPc4YnYpdchOfq/1VW+DNdZvI4jmOK3410omgnyJAMEYiwCmZZVSYEYt0l9HRt5Zy/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2757.namprd15.prod.outlook.com (2603:10b6:a03:156::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 21 Apr
 2021 19:04:10 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 19:04:10 +0000
Date:   Wed, 21 Apr 2021 12:04:05 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
Message-ID: <YIB3JYHvnuOi4CIt@carbon.dhcp.thefacebook.com>
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH8o5iIau85FaeLw@carbon.DHCP.thefacebook.com>
 <CALvZod7dXuFPeMv5NGu96uCosFpWY_Gy07iDsfSORCA0dT_zsA@mail.gmail.com>
 <YH+U4X8PKWZpOpAA@carbon.dhcp.thefacebook.com>
 <CALvZod7x=QR=p73BAxWPbFm+V8KFwYCcxNp-bOBvGaAttxjm7g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod7x=QR=p73BAxWPbFm+V8KFwYCcxNp-bOBvGaAttxjm7g@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:5e27]
X-ClientProxiedBy: MWHPR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:301:4c::12) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5e27) by MWHPR15CA0050.namprd15.prod.outlook.com (2603:10b6:301:4c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 19:04:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97f551c6-60fb-402e-5555-08d904f83e82
X-MS-TrafficTypeDiagnostic: BYAPR15MB2757:
X-Microsoft-Antispam-PRVS: <BYAPR15MB275704D2CB6C6471BB8D1CFCBE479@BYAPR15MB2757.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jE7j/BNojuAX5nTHIT3CQR+otUEEPUEDELMF/sZjLaAgDzL4c0+d2mU/Sez72dL36opMxgg98JAR2hH54CfaIceTTbLUlqiFEbuQY43vTrKtyoWzvq384MsM5WlzxHAceWa9VeHygNlkGnMHMeSFARiW1lHu8qeLFq8UD8hbnh88jblUXxpupUs6ZY5mkZI3avZXupaGyXIrOQl9XkNM/fR1SQSxsuVFr5ZzsqSDIsAFByXHWnVg59kaU9uJcuWVs7TexW26LVZqPYtRYAVgQUPEIXYz3wZUoArBtxFeIapVcmH/QBH0FxvTKBf9BKPTpwVUvewQeeXjEJb7KSA3J871LNbsmXhpvmxT21qJduoxmeITaOgvx3Fsl8lA5h19NpJMfIwQNk0oow2oofq2rcoQWZNgmrOcfunru153b/3+OJERpstwdwgujIQK9Mut0QPZbf8rVGaE/cHLSoVmgRtQjw8JBP4fjBY0ff+Dwj4MvhOmp+eH8UjcqoK3vdO9QZOE/YVc6TcK7UqsQ/IFC/T+r6HSPIKXFe+BOFA+JLIgUSqk/tVUqvwVA/rWaCDNX9ubdYRkcnTE+dAohwGm3uuA5FViahSNWiR1wGoUH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(396003)(376002)(366004)(86362001)(6916009)(38100700002)(8676002)(66556008)(2906002)(7416002)(4326008)(6666004)(9686003)(478600001)(55016002)(83380400001)(54906003)(66946007)(66476007)(6506007)(53546011)(7696005)(5660300002)(8936002)(16526019)(186003)(52116002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pl2tB4FlopVIrXwNdRJ9hgvpmJJwDK0F4hJx62DB7LT72NCri9tDKoHqsfFq?=
 =?us-ascii?Q?/jNFJ+Q9CauYL3lfQCbZosRobyg1e80SAhRyWs4tuPqF81p5oxFjhl5jaAeE?=
 =?us-ascii?Q?YMfhiQQ+oYPMFgIyxhaNIDPxRpjRbIG06BdWZDyAgB16tQf9W8noa6oeW0Vx?=
 =?us-ascii?Q?3ZEgZy/7h3/E0F4hWirkqb+CJzAwWy+RCHScj3QPaTyVRB95GmFI/vmdF/Jm?=
 =?us-ascii?Q?pTmHThm5Sr9Fkeq0r2ZZnuKwlW2hKDBfukFkycBG8UwC1+Ah9z8v4G5ewjDB?=
 =?us-ascii?Q?V8Lzbgq4GzvIK5np09+PU3tyriz2WHX8JzMd+FA1NSger1RN105IRiMzyNTT?=
 =?us-ascii?Q?S23X7JhvUFJqunmZN+0N2v3rXEWCldfsJuvbqYf1vlZPPBjdtfOBaPfSERPA?=
 =?us-ascii?Q?6YYwfx4fid450sZkZl21SUNgiFjPmDebntPxoOT1Z5eos5ilolU69a2pDnQY?=
 =?us-ascii?Q?J4G5AZLiFyT2PdMKCUe5ZKGCo63h5+z7jKCa7cld9mLmPzKedveL1vTzI1nq?=
 =?us-ascii?Q?hb93CVspcn2Lu2jxsCz39cT+kKL2UROERp5nUBobmZsQdxdPqldwzxdkLW7y?=
 =?us-ascii?Q?nSsq5b+6tErZ58NEbgItMhDxE3oBiIoXieg/zk02vn5vnrlS9PLOuUyGOODb?=
 =?us-ascii?Q?/QjRH3hrleBagxaH1NJs9gx32PaT5d2i7j5Ri9kW0OPHe3jl7Gt2BUFrh04G?=
 =?us-ascii?Q?hoH7dgtq5kPZkDy0sADNLoLoTdceRJMFqFStEKhMGSarvkxjn0/FXespz4mx?=
 =?us-ascii?Q?PzvwK2+8lbbLL5a9rMh96cGq7J8X8kZlUKMqgH+gAC3ifmARCd+hent6oaYx?=
 =?us-ascii?Q?CqrDfvDlZ6wirQo59JBOEycwR4EaniLQbyjpFGkXRi3az2e/uRuRyEjB9O2n?=
 =?us-ascii?Q?9CYWix5QNpBAFzrT9zsWmfkIraV3a7BgmawslL6WzCQ/dUiTPb+dkTN2J9SN?=
 =?us-ascii?Q?OJU2Ly8HmtwMgyqRj7Lh8n5h8TQyEt2m2F1m15yeNcM7KOCs2cjmO3mK6Uhf?=
 =?us-ascii?Q?Oz7gc4qDxEWFox8dA1K02sP5rvHgS/IyKSbgUDCGH4HXoswzzJ+8aXtK3f6k?=
 =?us-ascii?Q?/gnVLNqSwFDfs4vtdxvW/SU7zXprZ4iQfFFJ19ayjcw1AXicDONMbKxEA7yO?=
 =?us-ascii?Q?1x3Hh3nA3NZ4Q+f7AF+GUYIcwDnQEcmk5oV07TQNypowh/phx9kSlOLFNDfx?=
 =?us-ascii?Q?1fn+ssVuhJR+BmJio/he9g26XFgxtzUw3ks1hd7I1AP2Q1cbSqcL7922xsjP?=
 =?us-ascii?Q?lPKNRiX6Uh4bcOYDWDyzS0qDFJl6yUIycLe1rjP/lnFBLlBGL4ZbzeLuN5M7?=
 =?us-ascii?Q?5tJQYvBTI9D9+dzQ7+OAPszyBxoB+wC4ZFdPg3q5+Y+bag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f551c6-60fb-402e-5555-08d904f83e82
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 19:04:09.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xrw5smVe7dXUvZE1PdOZlCRz6x943J2GW6z1zQwEXg49faxPdOMfomQNQjX5RFtY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2757
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: zsKqFfu2vlrkpKD6l8pikthIXJFP9HdN
X-Proofpoint-GUID: zsKqFfu2vlrkpKD6l8pikthIXJFP9HdN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_05:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104210130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 21, 2021 at 06:26:37AM -0700, Shakeel Butt wrote:
> On Tue, Apr 20, 2021 at 7:58 PM Roman Gushchin <guro@fb.com> wrote:
> >
> [...]
> > >
> > > Michal has suggested ALLOC_OOM which is less risky.
> >
> > The problem is that even if you'll serve the oom daemon task with pages
> > from a reserve/custom pool, it doesn't guarantee anything, because the task
> > still can wait for a long time on some mutex, taken by another process,
> > throttled somewhere in the reclaim.
> 
> I am assuming here by mutex you are referring to locks which
> oom-killer might have to take to read metrics or any possible lock
> which oom-killer might have to take which some other process can take
> too.
> 
> Have you observed this situation happening with oomd on production?

I'm not aware of any oomd-specific issues. I'm not sure if they don't exist
at all, but so far it's wasn't a problem for us. Maybe it because you tend to
have less pagecache (as I understand), maybe it comes to specific oomd
policies/settings.

I know we had different pains with mmap_sem and atop and similar programs,
where reading process data stalled on mmap_sem for a long time.

Thanks!
