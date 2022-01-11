Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0D048B55C
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 19:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345375AbiAKSIH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 13:08:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58706 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345575AbiAKSHN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 13:07:13 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20BHRLOj013814;
        Tue, 11 Jan 2022 10:07:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=NzaRVqEgStNntr/wegozdwVQ+sz06RAwRK5GgN/PXkI=;
 b=pN1J54qrtRPEz1+FefYP2DKB/tdgtAI8Z3w2eCYGlLwPflU7akMm2+oSGyNXPLNlNBn6
 jij+6vw7W9THm/SJmmmyO+gWqap00uarjx6Pba/t3qHzovdEMXOknT04KYGK/HB5rHgz
 LkYxgnln5gLsmA4L4xFx32O2OKqdbq6ifTA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dh6cvun85-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Jan 2022 10:07:04 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 10:07:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5p67IJ8Y5YJT0TVkHHsJRTTLOaV8knCI3JIcbK4HyjiN91qe/tSBKpbOptBgHzzY0gGAQPGdFuYMOYwcp4Jg7qfwzWQzcdbMeyqZN+y+zdN0bkYGxaTLkJUBVg9M/2afw1JtIYsvAk7aTIbtcbXKJilCSKr/nv6EbMZhhEvCuSfcWrU73ZK875kPL3Nm5pOGE7lUfaOB81de4ZOKGusavYQwndy5ntPZozzSC9xbH+dsdmKT5AKq+yxi5BZJWoxP5R8b0HBdL0ddFHa4/2+m1g5xhEdcOXcsMWtDBNXF2CdEC+1MEFsY2PeCbrOi0tB5hECkBjU3Z2EnvQw/v8qcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzaRVqEgStNntr/wegozdwVQ+sz06RAwRK5GgN/PXkI=;
 b=f2luP6FSHRQH1DkMILp2iYc2gATddTjGK32qA9TVcxxQC8SfMrpDAWRGd+SB68QLNluwN0qiRxOIZYDflO4kaj1x//Vy2oZHy1Mj9YBl3pZ1BerBLhI0H1iWiD8jcHVTKBcY6Shy54U2IjxYhD+zzH3b5swBuplKGyU2CKhnHi5lYjPhvchtr74f7WspHWOC3JPWiHzu/vVBQyKAkY6O2fcp6ojc8RioZYV9/gftgtkI72t8g0aMDzSkPZtm+uCmnYttqlGXxJKghaH34n9cGXEEN4sI1Xe/0XED5U6L+mJ8UedyuC2BsCheKD+BhRt2RJAgztJqpQjGCZxwjjchrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2759.namprd15.prod.outlook.com (2603:10b6:a03:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 18:07:00 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 18:07:00 +0000
Date:   Tue, 11 Jan 2022 10:06:56 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <vbabka@suse.cz>, <willy@infradead.org>,
        <songmuchun@bytedance.com>, <shy828301@gmail.com>,
        <surenb@google.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 2/4] mm/memcg: mem_cgroup_per_node is already set to 0 on
 allocation
Message-ID: <Yd3HQGCmDcyWY6QB@carbon.dhcp.thefacebook.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <20220111010302.8864-2-richard.weiyang@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220111010302.8864-2-richard.weiyang@gmail.com>
X-ClientProxiedBy: MWHPR1201CA0005.namprd12.prod.outlook.com
 (2603:10b6:301:4a::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fea710b-d0a6-4ab2-44e2-08d9d52d29d8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2759:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB275963BD8F73A5D1387BBDDFBE519@BYAPR15MB2759.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5EEbStY0nQQxp3T6tp38Eg3IV8GVPnKBA1D141kAqnlBwQl53zC73jqsgIL41Lswx+ZA9W6sJq9bAd/QIDL0BNlgkp4MRTaIbu/9IaZXli7LoY2u7fStyMzN7naKXeI8ekGs3oVzZu0XCnrNoFf4R0MQ+n8qOcICNgtr1QmQEsZZ8ol2ryGkFYX+4Hv6lCVoMwLu/f7XxnHEivEYSVaLQOZn8sx+42U+Y5HR3NzI36pAm3RmJ0uhvn1BEmapd+HtvQEda/Lj8eMPC0qIJo8rZ0ML5nhR1VXfepfk25NVDelBPoBvHdfL6fudEs4KfutnZ2dkoM4FGvDZoVnO58Tz7zNHxNVRvJsRW9WIP70DeSIVHKeNqBi4D/W+TQ2rMGp5PnFZWci7JmwJm7SWN3K51e3lTZTRCT3M9cVDK9zarQNvjqSWKXgz2T7A4bg6pJnWsxDmHaTvwcA0UFIiAbeu8L37YgQyx+RrJ5DvY59zGd5iRyW7q8e90kl+qVDY/I+QG/ehSpwn0FMlt3ji1Ee9tjTEKLFMAiwHIUi00aY32zsO50PZuHu/Uwjad7iIScnc/2NoFKqi81BFtrmYRdHRV5wDsLE1xaoFIlxd/gphkV8eTDBMsiUMX8wOexynQ2XHqKVUJLRYH9B2rpMGenptqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6916009)(6512007)(508600001)(316002)(6486002)(86362001)(8676002)(52116002)(9686003)(186003)(4326008)(66946007)(5660300002)(66476007)(7416002)(6666004)(558084003)(2906002)(6506007)(66556008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kQwPvaG7gn8y4N8FQKVaJyDRzNxIasRuQr+fcIiQAOV2kUnjTgQxl+fNpRKh?=
 =?us-ascii?Q?ORSw2BSiKO/IhefdKdGS0fMssRFDHR8zAW3EHLvCDhw1aLZcTcoCf0hyEBk8?=
 =?us-ascii?Q?+maFq0W+DgWPiNtIJnvXTDmDDqllJe6uNrfFKTY508E6VqKzCPFpNyaJhX22?=
 =?us-ascii?Q?EsLCwGc5eZObiM3mv4V1WKj5jcZGmYESTcbwbHiZaqmyy4BTHEA79Ri5tk74?=
 =?us-ascii?Q?vFXwagHuk7WtPDmDp4yrSJod3SQiHAVwAzX7hd19atCKay8hZTTVeGHFK4UQ?=
 =?us-ascii?Q?nPRGmYv2ErOEOgW6/ceAN/L8DA1N1QCtzAf58VYaG0Z7n4WfqfNR/1spqruJ?=
 =?us-ascii?Q?3CgfpAOwQ8jLSqOZ9Q4YGYodmFfQKlyUReITeqsCWVzzZbF1Vp+sXPnWSYFW?=
 =?us-ascii?Q?iRwpnjUyMSgXMJtDhYAJxcyj892/CFkUHtEAoBLtgQ71RMKBZBMiuBoWbwby?=
 =?us-ascii?Q?NDRYwMudXYK7ygCowi7jds/jImUlFw35QEvdupXx7DVhw/3fBXeiN9voFJoc?=
 =?us-ascii?Q?D82JhG/m7AFdfQoLde9AJr9/WNL8aANmnOGGzOThAQBcMsRwlJLN5d1cJhBO?=
 =?us-ascii?Q?jX2IdGQt736PU6UWSk204j2hWuwOAuwuOdveEO1jU/khBV2kxMUbtDyjlCCh?=
 =?us-ascii?Q?vcZXF4Fgws63TszDTGCe6vZ6Elzj/LvYSFT2u/kYucONRAwc0uublLVfHliD?=
 =?us-ascii?Q?cT1iaohC/Czn78XHKjxUn/UEQ4FPeW+P8B3nVFAtMgK7oOHo1+y8rTWoAKWT?=
 =?us-ascii?Q?kX+697mWtnAKQLKddGgIvnWlZN3eAbAWF1THj2JEPMkcn+FkbDcSozDSmqXz?=
 =?us-ascii?Q?ZWNevuNrwQ5UuQfZFbSyoURFoajSKpspLeKJJEJRHhnLxd015q71cS/b2kX2?=
 =?us-ascii?Q?4wna8O3HWDBLXvNZugpionLcRpUtu6RrWvMsz96ofLhEorOmCtUXHP1xlzz2?=
 =?us-ascii?Q?X4Je0Ce5Ug47viKv5swi1PEY2C4Ik/HJmlRcaXxd2wFnMHZg4+2WMHkM8Erg?=
 =?us-ascii?Q?cbNnUTmeBW/3jHBVGhSQX9HZSQ9zBlzvrhV7jv47z4mFtgCbNa2RheT1WQgY?=
 =?us-ascii?Q?gTmcJqir+c6YYjiMNXyAvPSYgJf20lcZGWJqrnVnWuUXVzFivsW+VHBzMl3T?=
 =?us-ascii?Q?cPLOhxrn+6UECfhmS9PKE0uVws+FZRZQ+3o34cZP9ZkRss3918rA5fDC0ZXz?=
 =?us-ascii?Q?6dpbuD+CmZnU5k3pvFcFDD95YBKYhYIsus70zoHEWZdYnpEYyg45FZvVlR49?=
 =?us-ascii?Q?Krfcgc0rS2DhZPEPnPh2uNtUOaYMQPmyPhU2qGFUEc2f60U3pO9kBNW/hvCA?=
 =?us-ascii?Q?3oeTfWjr1beQAXF6yb2SU/4gERLyaaLTDJfzFYdOerziYOkH21SST8iDhLvp?=
 =?us-ascii?Q?w1cyVvp1o9SSgWt67QRcl/bIi+X5YuuUD9Eac22Lf/BrQgs5yEtN7gb6JQ4Q?=
 =?us-ascii?Q?MffVWRCdhegkBxI14nQJvHCOGaJYSROEF/0pdao+/uUoRwbsORscya57L2iE?=
 =?us-ascii?Q?JnlGEY/z+LWYQNiME+Fkby7J4MVl41w3pRBdsXVRJzCOBfjDXqstBuI0hCZL?=
 =?us-ascii?Q?C5KsXnBqtp19z2dQvb9JLfb4vnvS2b4F+a5NiG2F?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fea710b-d0a6-4ab2-44e2-08d9d52d29d8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:07:00.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9/bMVwN7KsLMoLkPpAxodTOIeDTeNHFnYcAgTygIyYYtS0q7hYDEBjLTpNUs12i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2759
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: FpJMdzThkIiuESfbTs13n9jQcahQGck_
X-Proofpoint-ORIG-GUID: FpJMdzThkIiuESfbTs13n9jQcahQGck_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=695
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 01:03:00AM +0000, Wei Yang wrote:
> kzalloc_node() would set data to 0, so it's not necessary to set it
> again.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
