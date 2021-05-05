Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84B5374981
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 22:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhEEUg5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 16:36:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58252 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233965AbhEEUg5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 16:36:57 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 145KSRqu011628;
        Wed, 5 May 2021 13:35:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rlBMzLAoeanStvaeF3EEMgiRqtAOUI5utrwiwUipzP4=;
 b=h2oU2g4uAIdpD2AP35298CvXRSN8kasRd+thAFap74MfG+kxGJEYOqHUYYpF3HN+p/K4
 Fl/b2RfkEdNRay3nX/5aoDttiQDlcQvdU246oQbrr6mx0Dzb7QuzeiLqlaaf8kqoJoAR
 s2qpx58Zq2oKhDi72LcWMqI1XonZLM2bFTU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 38beb1nt3b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 13:35:49 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 13:35:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gufbgh+eCngaHqmb90IFBdpm2/TMAMcLdeHu5fhzAirHIDlICwasbO7BQVTZ40tXOcM878IJrGlhzyzJhLgl6yvbBl/jcoudh9thKqc3bagEg3dPGtigDf/r7L9iKTHZmsLnyOaTSRUAgKDvWOFQEzQatzZHOTMpVcej3QP1ulTe8NV/gqI2vwlydI01sJja9CPX8ywOl3JNBrDmnmZ6tNLdPfrT9ypfBjq7F6E4ONvcEFTsLF8ZQE8M3Rwgt6T93kM3lXsfn6GTkt6s7jSZq5OvM8ZAhT8csyMj8Jng7clm9cjMhjj+cIc+/wZHjCQbnb0hYOiNexNZiXJydDyYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlBMzLAoeanStvaeF3EEMgiRqtAOUI5utrwiwUipzP4=;
 b=GgNgbN3hbM+aOjU1h808x+NeCURTiUMWgrsbboURFHl2YIjmyz7GcHiQ/WjOb5xVRVzB3/LFnjR1DQGXxm2vT1gENobs5hCPoBJJw+PS7ueWaqvCbziTkbivuTGsYRcGaHF/i/CsCQ2uhvF+bAUOsbdr7Buuj+dp7wKEdn/3g2sL7n4fIpw5hFaYCuHs2ZfUFMT/RlO46f+5aduPakApmDvT4Bd3oEojv/MdtAMzTzX05cKgu2RBnvIrCdY1tIRZbGN7uXQuayAiNJMZvf2aL68k97yX2+mOYz99DcEfT7kPTTZC3OdYI5LR9qifcRInAXESvrYW/p0fuKOoKkxWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3398.namprd15.prod.outlook.com (2603:10b6:a03:10e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 5 May
 2021 20:35:46 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 20:35:46 +0000
Date:   Wed, 5 May 2021 13:35:41 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v4 1/3] mm: memcg/slab: Properly set up gfp flags for
 objcg pointer array
Message-ID: <YJMBnQ8zQJuLTf7B@carbon.dhcp.thefacebook.com>
References: <20210505200610.13943-1-longman@redhat.com>
 <20210505200610.13943-2-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210505200610.13943-2-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:c814]
X-ClientProxiedBy: MWHPR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:300:6c::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c814) by MWHPR04CA0067.namprd04.prod.outlook.com (2603:10b6:300:6c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 20:35:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b8a31f7-485b-4e62-be1a-08d910055c49
X-MS-TrafficTypeDiagnostic: BYAPR15MB3398:
X-Microsoft-Antispam-PRVS: <BYAPR15MB339826FB98BD8DF9A635C987BE599@BYAPR15MB3398.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7kuSk2jv4Y5liYg8tyH8tupzkaauq8DDLatv56CR9k52zRxikIf/i4gwfM7LFJDo/nSUwnHQwwflK85X0q2CzpSIkwF9Ij8NsAGuYKQ4xoil39H52PAS2jWlr+gMpplkrbMOglIwGs/wTwCq3h105LuCm4xBbQgLrGCP6VnjToSk+hhBF1gRf4whhED/dTTccOeyeZLBge9oh7oKBSIBnJVnccxpWmXje8NnK49vfL1N5nyMsZrFIN1bQEHJ2O2qbBkNarHjVYFyK4fMtlV6FUxgZwKlmlTgDwUXX9bx6pg2GJ++QyvXwiKswZciF6/UjyyUuFKxv0Q+oxvSViESmxxVJJW7AOOvxltZYYULGKMGnRI6LNivlh3crAk/c0Gv7WUGVV1wIkLOyqZEDImBaBzK1ZbfWI3Zn4jdugIgME2PgKq4p5+olUz70bvGd+dS8Sk+xuWVn9/+qm3gdMdHjsqP/wLAxMRQ9i6epCXOnaRXcxJDTvVtHvoMkllrFRaD7HhWAxvbKY+UZnxbI8Ru5T9itPuuMNWx72N91QiQvFEKgjGdB/TQ7No6q6a3iMdLHJ8RWGfZSyixUyC1UDfhTxfxJkV7+3TT6/wJAI+Dtfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(66476007)(8936002)(66556008)(478600001)(6506007)(5660300002)(66946007)(16526019)(316002)(4744005)(7416002)(55016002)(6666004)(38100700002)(186003)(6916009)(54906003)(7696005)(86362001)(83380400001)(2906002)(8676002)(9686003)(52116002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iBE8ofw4Ig89DqVi0aJAox8tzg6C9xd46FH4gCuFLz9sCLfYc8VDDqYIHm9m?=
 =?us-ascii?Q?CJimLtHgM9z6X3hye4zRaFvWOcKr5YGMq1CP/omir4geWZf091m9uGZuT3am?=
 =?us-ascii?Q?hU758gnsDG6A4J7vIBe0+o5dDkCN8ejmtoI7iyhevm+N1gDk9I1sjNfGbEr1?=
 =?us-ascii?Q?ujxhaOcfDwiLQIRVQxJpckg49ceC6VCjTfjueun0sOMFQUxGtWtseOrwLf41?=
 =?us-ascii?Q?/zO9ytJaxggb71Cg4NhgavWyVDQ0TQrX7yt73BALSg+yFj2XfjJLGHWo4luB?=
 =?us-ascii?Q?TF56+oiYIH3ILTHQUdQf3P4QoNSecXIGhaY3du8iRm7P6Y0D7C0nCoPluNt2?=
 =?us-ascii?Q?P5u/3arPV5yD/Kz14o0gZwNmxh/Bk+HJTx0PCzrbF57TCe/705SEG+wWmjjt?=
 =?us-ascii?Q?upy9P5MQbWIPmaKSTrvOKghvd/QlfWtNR31y8v4quy+tqxkieFJlqDA82qFI?=
 =?us-ascii?Q?7Sj6PoiBgpYOv8R6ATPE3A9RxzZM2f7Hv8Z+9KyJR18x5Rw0RODoOKIJEjjA?=
 =?us-ascii?Q?gpeL0PAVe6DEggrgt6bzXFz3O3D+F9j2DKFrQDu+wuC3C9u8xpgnNln3yhhy?=
 =?us-ascii?Q?hlB6PkWkGndR6o/g8EDGmG4/W2qqqcx9iEK1maoxCnFOoOLW98wuw4N3ti4e?=
 =?us-ascii?Q?MGiv4JKoVWN9R19IAtsLq4HpF1g9ujhAfq35+qW+aNNxCitxoDPL0EFKgwTj?=
 =?us-ascii?Q?OA99Mz4DFOPCdX6UUjPwIClsMEOSqFwLfziZItxRJpzyAAz4wWGOpUuAcg+z?=
 =?us-ascii?Q?/yY92NX2isImItGQopNdTdVBC/S8A9YflJDakIU+GBOC8tcvu+nbQ/0w2l7H?=
 =?us-ascii?Q?7EKhU8HxPn7UbWKTrx5BNsBu8wPl8xvpBh1AeikFlHOFSJOm3iTmVQs+u2da?=
 =?us-ascii?Q?rqJqE7obhkdzbvEB3dM1BPdB9GBrm59HM3fXt5qzQhjr/mZBP4AisVgqxUnU?=
 =?us-ascii?Q?qDzIRJHbGMxKYttgzyH8eEFQ49nlktbFNJDToQ2FkQ2Ayc37ZZmx4hp+YKZJ?=
 =?us-ascii?Q?qY7itxJnOlK+FnrLQ1oHDwIXa+pmxkTq/MBwYp15g2kEkKQM6qmJhXyPU9Mg?=
 =?us-ascii?Q?WiAPeiGpSKdKot0WHiELrDdhSJ3YqkaBHHFlXXLMvbVInc1P+C6RtTRa83oP?=
 =?us-ascii?Q?IJfFkTM4AL3Q/roLkH8ePKIRxS7x22zesFJyVw+aHTtjEu12BqdYUJqA2mq8?=
 =?us-ascii?Q?skVPqGHjmEqEgpSxDXAhcsIsbBpL4lf21kxhPh8ZmdtnXdCvKPeHYxcAdH2q?=
 =?us-ascii?Q?EvPRaBSjs8XgArf8bijmyef6Fj5jMF4N6Uvv2MAHekmczfvOHSwtlq51F09A?=
 =?us-ascii?Q?m5wEgu3mMCfOjvQRC1mJfCpkghN0RfQn7m2OlI2eR+9oq7okdtIjn+0LpR8s?=
 =?us-ascii?Q?JwZbVVI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8a31f7-485b-4e62-be1a-08d910055c49
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 20:35:45.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0nH3PCG08UCaq8vSFHo3i1xhozoPPg0MuohDyUcxdCPnrO3wcjnoqzQSNfn0rLV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3398
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 0hTzwir6dWDd663YOJyDkTusqpzPt8Hl
X-Proofpoint-GUID: 0hTzwir6dWDd663YOJyDkTusqpzPt8Hl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_10:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=834 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 04:06:08PM -0400, Waiman Long wrote:
> Since the merging of the new slab memory controller in v5.9, the page
> structure may store a pointer to obj_cgroup pointer array for slab pages.
> Currently, only the __GFP_ACCOUNT bit is masked off. However, the array
> is not readily reclaimable and doesn't need to come from the DMA buffer.
> So those GFP bits should be masked off as well.
> 
> Do the flag bit clearing at memcg_alloc_page_obj_cgroups() to make sure
> that it is consistently applied no matter where it is called.
> 
> Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Roman Gushchin <guro@fb.com>
