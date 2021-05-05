Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C518E374986
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 22:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhEEUj7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 16:39:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49208 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234675AbhEEUj7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 16:39:59 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145KYxhO027646;
        Wed, 5 May 2021 13:38:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=RU75SMRO/mtB3tc7C0hCxRd/5hwa1TI5J2uZlWitDXY=;
 b=ZDeaAQ5cJcwjqg/TaH3c73IEx2g2Qnl2MKGjH6RECPbLT0QelamdgPbeNwk0CYQnFkXU
 eymDwbcGwQQwMrtq4V4rx//m6pHjGSpDxOHAF7Z0X2A2aknB8TzMxm4bOUZrLWQ/Dip4
 6qOiQMorutArGrp0/SZrL3D78o8IjeUqMIk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38bed2ws64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 13:38:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 13:38:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl/A5hp8KY88j3Dp+QqeJ2C85O+NlsCJHqBqcM1XHWh7qVoP8Ufc87FXE9eF/aW2Lkz2STLLfZtSedE1XRBrWzvsKWZKCCPDZsd0Sn0lJT7urHQecRrIm6FVCGGLtjYhhk5SvSjpAgi+xlXuf6qTBUDYJ/5JFLMI2x/ziLhRLFn3l6Bj3rq1cUTA3/4QHnidKNi7HAyroz1j/Dv8q48MTcLhIkd/ZYsbbl77yN0bRBb0qdmjoG+tGlMuPIZ6IHvqgwkxycyOvgGZqNBd1jgInBxwPASY4hE3s+KKhCZ8VGFg/nEfa1a3LAqCcofxNQSxA9iN5dxug9QTxyQafr/1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU75SMRO/mtB3tc7C0hCxRd/5hwa1TI5J2uZlWitDXY=;
 b=O/LMb83Pd0q0i3jvHtGS4ZnmvVTszaX6bmPxw19sJJnEqbfIiDFn6+LmAG2WzjuS3quiJm5ZKYRBBoiuK/32PlUQU03tB9YzGHypM8LcXG7t4dyZVUhhlI5OliFDyOnGZ4wd8Qb5V+Y6a7NNCkLTX94//JdiY9sEbgfHmGfeh32E3dUYMzLqa0/DaF225tik2+f6K8qW561bPEauf2+rd9bDrgQagbhYTlaBgKds3zffF1RxKSwDYv2DFfkhqGZ0aIGsHrmrS4CoDIG5xu7/PaM125gP9Rd5/ahXFL2fMNNUKHdlHz7TusN6C3RmxyLb+sh5WWobtNQCTUpUrQr38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3400.namprd15.prod.outlook.com (2603:10b6:a03:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 5 May
 2021 20:38:48 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 20:38:48 +0000
Date:   Wed, 5 May 2021 13:38:44 -0700
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
Subject: Re: [PATCH v4 3/3] mm: memcg/slab: Disable cache merging for
 KMALLOC_NORMAL caches
Message-ID: <YJMCVPIJyCFfcmiD@carbon.dhcp.thefacebook.com>
References: <20210505200610.13943-1-longman@redhat.com>
 <20210505200610.13943-4-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210505200610.13943-4-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:c814]
X-ClientProxiedBy: MWHPR18CA0069.namprd18.prod.outlook.com
 (2603:10b6:300:39::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c814) by MWHPR18CA0069.namprd18.prod.outlook.com (2603:10b6:300:39::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 20:38:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b1fd657-19f3-4b1f-812b-08d91005c934
X-MS-TrafficTypeDiagnostic: BYAPR15MB3400:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3400F5244EDE3222668C0560BE599@BYAPR15MB3400.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abPoqCPYUs7BY5u3WtwaAoaMZmIBC4sj7+mJRKGwZspk8V63LgAwu43Geod5X1fHLAQoWbr0wpjyZiQR6OnHlsE1h10JzXZ1kjsocXpTlq8Iuuws/XJwJBkItaRqykyU6TFH7J6QeTJr71RcdH+xcSfVHvzPh9cDVVJkThU5eEU6yHqdggWRocXA2hLIURYDrGiJf+R9nEg2vgWN2RFo0xSCExQntjf8yT4JQN1nJAI55t2bmd9+SAbMSVHuCLyuLKOIIy02p1wNEhiMPipjEfEXBJofUMQmoDcrYlr17l2AsVrWd6pHcTjJxGM7txT8Do83xmc7nu5l2XPnP6Dd0/4Z4Ig+j+c1rt+GWW2BHskIxbgijiaIx9nZ4Vl0/6oBfKRIkEmwpGC/9JifY7mpYoYl2am1Mit04JTJg1ltkwEKLCs0KXnpApg0ofzWNN27ZpomBBmtkArCqlMPqrQRcYc45yXmRD0kKoBjcQi3t5k3WzteOJOHXUiqB15jMGQhBPEl6jyxjpoPvrIesPs9aBLoLdy3MN/xVuenB3Hz3g2+VroWjPdCX/uMNjdd859zTue+ez2Jtf2+ZuzAobSq+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(6916009)(83380400001)(7416002)(38100700002)(478600001)(16526019)(9686003)(55016002)(186003)(52116002)(54906003)(8936002)(316002)(7696005)(4326008)(8676002)(86362001)(6666004)(4744005)(66556008)(5660300002)(66476007)(2906002)(6506007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hdCEmyIy/Wx7FfFihdZokQM9cOl5ReJtEET0UHBtIFwQ8BjG6UZiW0YtQtL8?=
 =?us-ascii?Q?9Ohyoxr2AeolOIuEQIVajndves4Ty+SzXkbMwI07xmJRii8IOHvXHxtw77V7?=
 =?us-ascii?Q?3K6BRkd0yrbL2qcjvNA9oivFkL/LtXXHYVTt6qH2E0UNEb9do6adZasu65Nn?=
 =?us-ascii?Q?NgAyRZiVxk6vhJQzwo5hDP2QzS/jTyxZRxz3fFm2gjxanWxm3D6H8Q4Go87A?=
 =?us-ascii?Q?7GwUMQRsMUJKSdBuKvcNTRI0m/jXx26pGSKwlAoOktJ0Cjj8r5VqbmlHW3vs?=
 =?us-ascii?Q?anHMrpe7sapYL5STYLp+MinIc7BVupXvOlJDKTiMV7OEULPu9kfaKWQWy4W2?=
 =?us-ascii?Q?46MuUGPw1I1icn6Inu7NxaA9b+KsYbNOTwgScKdiPNBpDl9hrSjSwWXLj/sr?=
 =?us-ascii?Q?qAvIK8cYHtcwx9muO9fyUMKXpswKjPT3nQ+FcD1mJyyaLya+DaCI897ZQ0iR?=
 =?us-ascii?Q?9JJi1JxingYjuobVnIOoGNKm2T3epsC3YSwNzMwJsHhnjb+hwjjhaW9pXXny?=
 =?us-ascii?Q?FpsAUga9IUBBj/ay/8fv+FoLFL5YQGC5mb551x0ltGzu4rroKbUs9D6tLrk1?=
 =?us-ascii?Q?GuhWDrWrtETD/7g1K5VjKuwuVbG7606GTJMDqA6HRZk0IXQ2HTqIFhKxG0uw?=
 =?us-ascii?Q?vFG4DR05pKr0w7Wf/8l+P030FvBt0yjZqsDm9GXA5IK1t7vrbMZ5bj1HVPUf?=
 =?us-ascii?Q?D2QHgvSGQ6B9Ct2TOxvv7p2qrPLr4XwnEUe0D8v4f+XmrgznSdANF2PdKLsO?=
 =?us-ascii?Q?oRvhuzJrYieJeUNsnC7YG8TWqapLXtcBzZDE0BtYC16ISVh4RJNxcBWdJo/h?=
 =?us-ascii?Q?wDMTff8TMa4VKmQp7E0A3rpeWSivkIQ8yJcROp8lzKkpUoLXAMUvGU+WEhMm?=
 =?us-ascii?Q?KubZoCEqYgH0tTWUgeoloxGSs2r1Li6QjxoFue8BLg6iLYY9RMfeZyDJPXA8?=
 =?us-ascii?Q?Rv8Z0gT0kqiHY388HbOqOBWHI52kZl5qu8XhGPwPxE809en5JFwyt2iW37dG?=
 =?us-ascii?Q?NALp9EnyI2sELtEVPTulajD+cNGq6t7bsf40bYfSD8CRbM8OoEhqmdT2Pt0M?=
 =?us-ascii?Q?/T1PAbg3rU2lwWdS7SL97c1qECcVd0UdXofQg5BZmlpASoiCq3VQ7QfWgPmU?=
 =?us-ascii?Q?ucQiDanVZgHxyNH5Cf7NT4HOgexqxf/l95I0PgIzWGVrmlwA7Hx0qPFrrcsI?=
 =?us-ascii?Q?eu6N6KV+i0KfG4iF86kMRk/z6ei+o0sxf9SSTk8JHrn0JmNPEHdXKjDXhqND?=
 =?us-ascii?Q?J38tj4SWsgZF9Rbq24zJciEYGeZ/KOC3jOB9oz5ZfAUfvc0NV4cJ7fPMvPN6?=
 =?us-ascii?Q?DlsFhDvzk2ngdFShmkvWTo8FiZfs+Aakg0mDM4pcj7enn4S5EPcugQL3GK1c?=
 =?us-ascii?Q?/lmrv2E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1fd657-19f3-4b1f-812b-08d91005c934
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 20:38:48.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRJtqhzybNT6f9fSec/7hGZu7SZGnvc9VOVmoNEZx8z3cWD0RmnU86NKFLf0NY+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3400
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: kljhDIU0nsXVpTtA4gSC4M1HQoL1AR-g
X-Proofpoint-GUID: kljhDIU0nsXVpTtA4gSC4M1HQoL1AR-g
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_10:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 suspectscore=0 mlxlogscore=634 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105050143
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 04:06:10PM -0400, Waiman Long wrote:
> The KMALLOC_NORMAL (kmalloc-<n>) caches are for unaccounted objects only
> when CONFIG_MEMCG_KMEM is enabled. To make sure that this condition
> remains true, we will have to prevent KMALOC_NORMAL caches to merge
> with other kmem caches. This is now done by setting its refcount to -1
> right after its creation.
> 
> Suggested-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Roman Gushchin <guro@fb.com>
