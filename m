Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71144322DAD
	for <lists+cgroups@lfdr.de>; Tue, 23 Feb 2021 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhBWPjH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Feb 2021 10:39:07 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63486 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231177AbhBWPjF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Feb 2021 10:39:05 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NFJuhb002240;
        Tue, 23 Feb 2021 07:38:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=8Dnke+Xe9pmyGZPvfL7ey84TMNULpiFlkwLnLEfkkZ0=;
 b=Ix9HGaP6s3CXvh+Ec67e/h6DSqmrOE5z0WPR43Gbm11/kwZAlAqe2aPF730G2VWmgd/J
 9josdEMcWqdVJYHkoc5bVIYgFR0511QO213GUndZmDQX76y1cR5yPOBhKqhiZWBb/day
 ENW7t7B1d3RlunVdZJn+rJ+or1s8OTQfpyY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36ukctbsr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Feb 2021 07:38:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 07:37:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BseDYVJBTouiX0wG5gkiQ8y1fLceRauGWsflPyGa0dSLGY644iM5bn4nl4MQ4NbRwISByfYyf8m48rjafl7JH6CT+Y0tNXZ4IpzNrM92qpc2mqbaN29jrBScPD2uV/x/vnrx/bK8KG+NiA69nlyOCxWLY3qH/n7pH8lX98s0rPdcCNfPJdKMRQM9tLl8cnPS7BKuxmvppi5aPuXoku0nzZNJtK5ksL5E8im87UTsoc1P361cVmZ36ejdVD64Cm/M3MzH1fH7SASaoThpCr6cfGFd39O9KPdJwC37uMY+FjtoDrRt9sVKsaMX793E5ny1fPCfEpT4xIuYVckKjc6Rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Dnke+Xe9pmyGZPvfL7ey84TMNULpiFlkwLnLEfkkZ0=;
 b=aqSBQFrcyPBpZuV4tv9c1o7RiPH/qfRQ3y5XTRC/baEWu6BiKHGj2+h6Tjmez53MUk9rNbELeckM3NBiKgn0s58fPUXHfqnQuM5y+qXek3rtTSlf8+G+k5PwBRFDnHRKeHmpka1pKgCfn5iwIHsaJ8l0af1Y2fAXZTThjOcY94bwN7zro7U1gECfxVOPOftWIIIXBhuThR0ZIcRn3zXpfPbhUQYFLg2USWuQiJW1covFIm6GazoSxECGkyAnlQXOamNZvNFx78PxUB4rqVobfTNaT8s3wtm2hIZKKAnUf2KB3QGQxSs3f2kUyoUYzRZcxVVSsXc1Bd+cMRadulhRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 15:37:58 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 15:37:58 +0000
Date:   Tue, 23 Feb 2021 07:37:54 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: fix slub memory accounting
Message-ID: <YDUhUtzLBmSV325H@carbon.lan>
References: <20210223092423.42420-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210223092423.42420-1-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:719f]
X-ClientProxiedBy: MWHPR08CA0050.namprd08.prod.outlook.com
 (2603:10b6:300:c0::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:719f) by MWHPR08CA0050.namprd08.prod.outlook.com (2603:10b6:300:c0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 15:37:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf6eb310-d0df-4e68-7bf9-08d8d810ff33
X-MS-TrafficTypeDiagnostic: BY5PR15MB3602:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3602E5A2891B4F3D91A467C9BE809@BY5PR15MB3602.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0ms235NVAWg5DLGZlmzhBSyEVcvJBNmll/38W3TEBRg1eTk/Pk1e7zsjlEBPSmAGk53ltjgs2nvd6R4iKY6WvfUNGH+5hP6hMiDuLH3WBAkeE9MjpMi9DuJhjnBVg9pjDppnMgwo+DNDZSDlTnAprc8PBs7h0APOjloHMuHyz2I+gQZQoWabMHRglQ0+QQ8u524RRgqrNe5dF1rB2R0ZABi2PdzXQARDPd8cHyBp7RRrDzAzkOl6n8kl9aT34fcdgfrTwsVuIsXk423OnivcOaI5aoSgDe8aAHZeXeRFBSrlLxXycbYWOknQcYhNn46PFqETmp31hnxGvpCQc68H6DZ3KD93kYJqg/vmFsB7rj+REVFmUbZAmlxzAU5nnLf9/Ok1dpqLjEbtzPTrPeFvo8QavQyMN+UQ3uKBOeeNaEQRJL6GiADL8/bol3qQchtg86L/wjwip5Tb9dQDUWJXM0rX7V2EGi+0CwInPwyXM2lae9LfxqsQWHTWERxSyqyEsEcYlkp8b/xx3Hiv8G6hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(376002)(136003)(396003)(316002)(478600001)(36756003)(83380400001)(86362001)(15650500001)(4744005)(5660300002)(66556008)(66476007)(66946007)(6666004)(4326008)(16526019)(186003)(2906002)(8676002)(8886007)(52116002)(7696005)(55016002)(8936002)(6916009)(9686003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QBii8X6Dz3ZSm7V6DcGb8M1sSnt+hbGmcQpQHoqL4MVyAUbSVK1b8wjZG2+I?=
 =?us-ascii?Q?0XM1GgxcofhF8ojhmDMauXgbEx6QI9KyvLTQU4Xyl9+bH5g5Q4L2Latx6Rbj?=
 =?us-ascii?Q?hmHH/oaSLDAEXO/DK0W6IVz/prYPLmilvQyXWD6Ie082P9ggI6/RbUI9EXNl?=
 =?us-ascii?Q?YjmxscNRvoW1EPpwgXfAai6goXF3CNvqLbql9cGBmznEDxuA9iHOPMxsYq1r?=
 =?us-ascii?Q?PngpfPK0ANT57NhNdd2ScOSCvUINoiX41d7AAb8SgbmgBsjN/UunVup3pn/l?=
 =?us-ascii?Q?GdqpDaDWCnNo/r6Diawi5IUHvj9Wc0PIB1MpuWw67yItsRsyFGhSMnQUemt5?=
 =?us-ascii?Q?ITAQeQHaJiCpjRTJzC+AYOBaw6QReMbmfc84Mp8WlVNVR4Tt05tabod90H9v?=
 =?us-ascii?Q?sOe22M/yoH9N/TNlxeVeRgNCYxx/kU5ltOXTi5YBHwl1JC4EjxV1kr78+nTI?=
 =?us-ascii?Q?Maol6tIgAAeudjOZuTCPR92aJMOx191Xne8hS/eTBPkfCIIlB+44IIShpaus?=
 =?us-ascii?Q?FdevPNz7SQJ12Zx50pIIRii5oRBhfMtXY4mhbpNA4cXuvJvqV49zN2OEAe4K?=
 =?us-ascii?Q?Hr4iN9N4b10I8msR+KAkYq9KVJUy7aMdrIy/mfzZFbHFooGFuPiWUzn5hj4M?=
 =?us-ascii?Q?eBPNtws6G61Mw1CoYJ2qch39q+yP75dnJqJ8+Q+M73tctZWaQIREapLG+dbE?=
 =?us-ascii?Q?udZPrG1wvltsmUTqY1EYTK99B7EvC/7tJzn0IfAphEpFPBusWogleW6st9Ki?=
 =?us-ascii?Q?IsvoTXJHz6ZniIfUJ7kXF9VYh+kDZau8G3WTeHt2FIZTFdufJxHRZrt2+FUv?=
 =?us-ascii?Q?VNqvVS3zpRooNiyeynzDYQGg2LPch1wPVUljiXZSgdAqxamS6eHlPy/7mr9c?=
 =?us-ascii?Q?x17jn7x2HsqbU/Dh75TVti3dniiQY6lZ3szlrggqswJAq2xqy9EH32g4asOd?=
 =?us-ascii?Q?HbsZQLXXl7fPMuOHAwwK5KlHAo7kzOTe667znRTrhY1pVIHgNz3IUEtW95w1?=
 =?us-ascii?Q?r8B+FUOQoU1ZNjdowDt9TVxECg0o+mwbLsmrVC28og28Epb3ADK0rhzlgnJI?=
 =?us-ascii?Q?qdIlJQoAAfIVpTIdbNuuOJmRlKfi6Zyaj0u/kqwVhxYytCQhtXSc4ytElxnT?=
 =?us-ascii?Q?cKc2wwBKIYU3aqi5rGNCmwA/PSmC8/kWkDQLa4aC0nPhs2saqHhbLFITkJbY?=
 =?us-ascii?Q?a1lRlASS2OsKTymCw4xcPDNmxBiPo5oppMk9Klc2769U1jF3EEG2/rKc2yW6?=
 =?us-ascii?Q?yDSu5OsZ8ENzDVPJCjrG2wOcf+oUA+gJMXSnJrEnpirdZhAFgeP3qupqjOlg?=
 =?us-ascii?Q?hXjncksFRUJlCtdYNOkn32K0MBwGt1HJXVMbaY1qpCfq6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6eb310-d0df-4e68-7bf9-08d8d810ff33
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 15:37:58.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJZFgEkkZuWL0jo7X3Q9ki0JiCrPzi5nSbXVIznH5cHTSwzxEmv7fwXZkk/C4h+g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3602
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=784 malwarescore=0
 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102230131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 23, 2021 at 05:24:23PM +0800, Muchun Song wrote:
> SLUB currently account kmalloc() and kmalloc_node() allocations larger
> than order-1 page per-node. But it forget to update the per-memcg
> vmstats. So it can lead to inaccurate statistics of "slab_unreclaimable"
> which is from memory.stat. Fix it by using mod_lruvec_page_state instead
> of mod_node_page_state.
> 
> Fixes: 6a486c0ad4dc ("mm, sl[ou]b: improve memory accounting")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
