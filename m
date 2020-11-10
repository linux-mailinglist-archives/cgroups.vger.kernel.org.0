Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD312ACA82
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 02:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgKJBdm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Nov 2020 20:33:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48690 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbgKJBdm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Nov 2020 20:33:42 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA1Oep4005817;
        Mon, 9 Nov 2020 17:33:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=cCJ0/HQAoNBZeouMYSTI5E8ztU8ysZWj9Hljs5jus7w=;
 b=SJfauKtFjHsPzBdfj5C43dWLw61xffN1rgnGfAnLnq2oh854QXbBUQ3HmjDdMFIvTAOC
 TbFizYyJAEIcw526ZMd5t/d+/hTNycgMXKr3fcwzSvykmgIKpfwSO4l7twqih4T+QjOj
 00O0JclBDKCoTokftQgo0E86CKs35SVck2g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34pcmj802t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Nov 2020 17:33:11 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 9 Nov 2020 17:32:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8o0H4TYhlzr/Gx1a+uXZUhwdja35VqNJshQl9BNI+6OWJdyPCiXUId5HJg7IKcqORonlLlbw0eao7J7dsJFFES2z29d1s7VuoDAzDNIRU3MVlImo2GET/X2OpQzdETy4GaS8CRa6gD7bjo8cnqKA5bMEc/WPWLx6z8K3ORXOlVAsMW+t/VdsNbW+a5iDlus3nRRPshaqB6dZKdZRvCy5aNEHvu/DvLnzsPROU2HnrmrlyjoMXhzpx++jPIbscuysOL/k4+HDVYmp747OWEH53YLgPi8KlVv7cDZHn4VgfykLVuId1irf1Db7FELK7ttBgxLpLJYDKaqVZl8VmmlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCJ0/HQAoNBZeouMYSTI5E8ztU8ysZWj9Hljs5jus7w=;
 b=W96IUA94qLNKNzSUNYf/TQR/1+Q/blr9/GVygpd1wAi1KBO0Fm5Y/0yp+kBAUXdSSArYJ6Q15bTEhpKm5pXj5cTNduaNAqCLN31m3TfW2MFGPbw9UpKNNo7nQUIApykgDsJNuGfr1FmxtrbPgeEWba9BBCyvrDOO1loTZHF/JY0Tjv+CR6jBM5h6HsiWKhe1W6fwuv/Vfno14NosC7L37TkSw7YIJrfs5irZly7/Qal5LGvXLWuqJKsXWhRhtcW13VSdXi5EpZdie8INM7KGcxbCfZatjRSuw5m6DCJaPv0FNDxIiwu+H/ttFk9L+un+Q4shbbCOBfNXRZIGhZDd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCJ0/HQAoNBZeouMYSTI5E8ztU8ysZWj9Hljs5jus7w=;
 b=EKpf91nk5Zbc+st2+CvEAOMmqX80DMPiB6SrqYZtj8jwPTvhfHeiZUSS5gOPyGMl1TQLJrbuC30rH8mlsUvk3oKSPeZFxQqe0QC4EkNhUHX9W0AprxUHVluEOu8ivIqW+OFr608bT4ksH6S6F9U8QZndFX0dbon+Byqk+Ttaj3w=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2710.namprd15.prod.outlook.com (2603:10b6:a03:153::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Tue, 10 Nov
 2020 01:32:41 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 01:32:41 +0000
Date:   Mon, 9 Nov 2020 17:32:36 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, <esyr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>, <areber@redhat.com>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [External] Re: [PATCH 4/5] mm: memcg/slab: Fix root memcg vmstats
Message-ID: <20201110013236.GB2612097@carbon.dhcp.thefacebook.com>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-5-songmuchun@bytedance.com>
 <20201027184835.GB827280@carbon.dhcp.thefacebook.com>
 <CAMZfGtU1aViokYk1hkHbYEiqW5QNi49UTd-QTrkycLqj6Q+-8g@mail.gmail.com>
 <20201029001408.GF827280@carbon.dhcp.thefacebook.com>
 <CAMZfGtW9wa=S7+OQw_R+4LU5VzcN0H0OUPw-2XfTAJFniQN3TA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtW9wa=S7+OQw_R+4LU5VzcN0H0OUPw-2XfTAJFniQN3TA@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:f78e]
X-ClientProxiedBy: MWHPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:300:c0::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:f78e) by MWHPR08CA0059.namprd08.prod.outlook.com (2603:10b6:300:c0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 01:32:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b7fa491-656f-4351-0082-08d8851883fe
X-MS-TrafficTypeDiagnostic: BYAPR15MB2710:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2710BE2B5B8818009EC7EDE6BEE90@BYAPR15MB2710.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnG0BMc5CB+91DhaZr8C/feDUurMAKJDEOC4YXUjLyU/wcRKz2A5QiVQtZ0+dxrPQJnFY9nH7LqConFJyWqttfd5qoONwH6SjAmyF4/wsxm4J9Dc0vGT0rEipzOmbebwGHofB/kMMiz2OZN5WW8KRO+Bg2bP77GlWbMSHk3nIsskve+ixmIzPO9mHTlkHlyUOYxGhk47FrZednVJvgsZ8SO0efXMnX++40W3Fb+eYj5wdWwm5hoQIEPNW6w+Oyva9/1xX6P1eKKFBSVbPS1zTX4S+tgHv0w1y77GO2cnysNkSE+gdPpepdcl6Ozwggx1KeVLFW1MPRsduubq2n6v9zjIge7dlvTobJkSKeDsIBTuw3617ElHRaquBXU+PpHJsOfxxV1e4KyXhVdHqnx3DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(83380400001)(6506007)(316002)(4326008)(9686003)(86362001)(1076003)(8936002)(33656002)(186003)(66946007)(66556008)(6666004)(66476007)(16526019)(6916009)(2906002)(7416002)(7696005)(52116002)(478600001)(966005)(5660300002)(8676002)(55016002)(54906003)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: OqrFrao1ZKmC3Ej2NkcotMXLrmqWPgKugQ9moYui3BX1ufaZWzsOFDuyd/tf+C/bcqKqfz1Tj3b/8Y6EgC5PlsqtQRnstmZktdVpdZt/Mqkei+5gs5ZUYYPB8glssO/QBvVvximjMUNXMT9koyJCOAPQQQJBSaXiBj+KY2ED9ZOuw5ygQL2q+NdrudkNGrNnT2DjNw9tmOTSXQZtquGGFHdmEjwRoONQYo5lFo+t6ykH6qtkCZUS6oz7fLwJc07es9+zBZyFt9ctSQyBhMihTAnRC7RBEWso1UXpw+gmcHUg+/qhwWbsJ+uRDUC+dvnPIIHvm0fX+ZdMTwvAhqZgbsbr2QJcb71+vXlCIjD/wZnZ/7sMkZZddg62RSsqFLOEdgajssPvsaEr8vyvCEBH5x8Ki/HeY8mxHvWZ2eBZd+eTblp8WykkT4yfoVzNt7HRgUOSeGjloumWUHezvP4J5wqsCfxAM5r8+jd/jtZVbFosaTVqXx03kT0UKf53q2tJIsUecs6qrrAnGARsE5+sghG2y/POyMRcaUl/6pCFE5c0w3H/maPTpJen5MAeKc1hPgzpMYp+9pbo/esd7/XIVx/rIqafx2w2jzIM0t+idDirtAYHDEHwrZdN4+4qdq6G64j0W8di/jdGUyUpvAfX6syEioqWSxS66kKU8AoSgLn4NBltWjdy2JDOlJsm3HEB
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7fa491-656f-4351-0082-08d8851883fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 01:32:41.6374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDC8OZm6kydHZmlVDZg9Hw+jY056zm4x3rpc+Pul6Dj7rk+hDvdEuh0r/aNvoWne
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2710
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_15:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011100009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 02:15:43PM +0800, Muchun Song wrote:
> On Thu, Oct 29, 2020 at 8:14 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Wed, Oct 28, 2020 at 10:56:20AM +0800, Muchun Song wrote:
> > > On Wed, Oct 28, 2020 at 2:48 AM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Tue, Oct 27, 2020 at 04:02:55PM +0800, Muchun Song wrote:
> > > > > If we reparent the slab objects to the root memcg, when we free
> > > > > the slab object, we need to update the per-memcg vmstats to keep
> > > > > it correct for the root memcg. Now this at least affects the vmstat
> > > > > of NR_KERNEL_STACK_KB for !CONFIG_VMAP_STACK when the thread stack
> > > > > size is smaller than the PAGE_SIZE.
> > > > >
> > > > > Fixes: ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes")
> > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > >
> > > > Can you, please, drop this patch for now?
> > > >
> > > > I'm working on a bigger cleanup related to the handling of the root memory
> > > > cgroup (I sent a link earlier in this thread), which already does a similar change.
> > > > There are several issues like this one, so it will be nice to fix them all at once.
> > >
> > > I have read the patch of https://lkml.org/lkml/2020/10/14/869. You
> > > mean this patch
> > > fixes this issue? It chooses to uncharge the root memcg. But here we may need to
> > > uncharge the root memcg to keep root vmstats correct. If we do not do
> > > this, we can
> > > see the wrong vmstats via root memory.stat(e.g. NR_KERNEL_STACK_KB).
> >
> > I pointed at a different patch in the same thread (it looks like you read the first one):
> > https://lkml.org/lkml/2020/10/21/612

Hi Muchun!

Can you please, resend your patch? The planned cleanup of the root memory cgroup
is more complex than expected, so I think it makes sense to merge your patch without
waiting for it. I'm sorry for delaying it initially.

Please, feel free to add
Acked-by: Roman Gushchin <guro@fb.com>

Thank you!

Roman
