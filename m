Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F89D4A75A3
	for <lists+cgroups@lfdr.de>; Wed,  2 Feb 2022 17:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiBBQTp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Feb 2022 11:19:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8910 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230078AbiBBQTo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Feb 2022 11:19:44 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212AXuEq028273;
        Wed, 2 Feb 2022 08:19:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=O2ypQy06D8d1fwnU6n/8FzoRwjuAoe1Etk5yRumMdSs=;
 b=UZ0f+WqtXJezwcyWXC+ljcU8h+4n66ArX6qcaZH5b7H5Qd9bdmSj2D1rE76OJckjMiim
 NXWWpyNZybiRYGa3dkyR9WjTNbdKZYNfEQkmuU3wDjWQOX2R/HGnpZ77QFTRDYHJcqe9
 ne15TVXYMSPM/Gy+orYgLWz0Tzrc2dFHSjI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dyrahsx1n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Feb 2022 08:19:32 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 08:19:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbPtIPqHbz58pouIPs2A9NIB3td+o/7N/0Ko58ulDAhyfksF+acwbCEbdepi6WOwwAzUX/KIt5g9jF9XtRzHgYIGHsdxGDH3PGKT51qMIckoJj76GAw9K5bN6iNwDU6bydE2Nyvk7YxvmhXHEfqE0hIAP4GKaqIy2yElfjJEixwrweDvyMP1B6Hny73TaSQ9ZtMWF/hVjBjew0fEOItLBSVIJkvNLHfeJM6q2F3HzFAU1jvNg4RC+kdodP42tlGCCV1gWdduc+vnP+xmF/vJX1l8seHy/GDLBWA9Dw5KxVF9lea3iawOF9IwZZ75HePP1Fpe2SqhhcAc5E5qa1DKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2ypQy06D8d1fwnU6n/8FzoRwjuAoe1Etk5yRumMdSs=;
 b=glIY1EcvP/BiaVn0+gVPlAKOh3zUfxMpJXzU5XZjs3Ht1XkiHru77nc4M1sYbaSytfzXFOyE2l3Cm/yCQjBtgN2Mw2FND/29bebBQjMj/ucL0o+XKK2VZrAmyUkuuVJTBPXp4Y6m1qtidPacFBsFQ2wOOmiMyBPgxv5ETwm66rVrajdHVcsSJiFoUOaWaD6ISdx2l25GxAkPJ0Jn7nyom0j8Q1bHqbPOAQsimYH/iglGDAY0yDSTPKDCa6rc5CVb3eauOBQluHceHnQg/tDXYvW5ClWNCWBq2NW4Ww7s/LL84IUvOCKJJ23s8raeo8L+igCtUMDIV6NMzBlB2Oakrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by MN2PR15MB2990.namprd15.prod.outlook.com (2603:10b6:208:f2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 16:19:30 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 16:19:30 +0000
Date:   Wed, 2 Feb 2022 08:19:26 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH RESEND] mm: memcg: synchronize objcg lists with a
 dedicated spinlock
Message-ID: <YfqvDvvyFcoXHzRe@carbon.dhcp.thefacebook.com>
References: <Yfm1IHmoGdyUR81T@carbon.dhcp.thefacebook.com>
 <49447f71-bb84-8e1d-e0cb-c9e482d3459b@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <49447f71-bb84-8e1d-e0cb-c9e482d3459b@arm.com>
X-ClientProxiedBy: MWHPR1401CA0016.namprd14.prod.outlook.com
 (2603:10b6:301:4b::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04fab4b6-39fc-46de-944f-08d9e667ca35
X-MS-TrafficTypeDiagnostic: MN2PR15MB2990:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB2990C8EC49484C31B0C24DE7BE279@MN2PR15MB2990.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wmv24z5j/H0Bz4QzymzOnTRhrpU4+FqFa7DPFv+dF8P0BZlcdf1zCk09kOfMLxYBh9WnkvQFVYQsE8/51n9wxsPQzozIvdR73l0OaFqLLO07IdaGVTVCnEQQEd8azzbk2aV3UUDlkbgUd2ef88NcUaASOld7KAoqG/7yTxMtruiZKaXfeHXz5ZH1GvRNUC4tdvJABttDj77QnBAclHdLmjmOT8C61AuchjkDDvLmjlEtxOGvOIhVAh9Vvy948mvaWVnuDCJWkG0tO1d0BiXFg4fZYvKBpN74n1CLUQ00YpEkxeLI7d7XCA/lvHOVS64UblZyIA8THsfyLc8mceESPCDv2MENsR/CPDjfgtcjFvdGDTQMDkVKrvb71k7uE65gmo+mZAF5M1Z3sLd4uGhMg/hRE3WbichL9gDS1/kk5Qa5vHXQQHZkzbtfGeoSh5U4pg+RAYTSj9cNe63PhLegcc2OtLV/cq/vz9kN5D3NKL9kEbr45iWnQXRfzM8k25uz4et5qa83llC48l4GquPi/4nl+O4lXSpmkS9y8jJm8ZkCmsvwHar2U4FaGB+SRyOmBaGbdnlnTuAzWXhyt8uqK7FZmAjo4T+/w36OidSUO89tJKxBjZCHBf0DYLoguCSI6vUVgwfNLGoW9LI1gDdumA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(186003)(7416002)(2906002)(5660300002)(8936002)(54906003)(86362001)(6512007)(8676002)(6916009)(508600001)(4326008)(66556008)(66476007)(66946007)(316002)(6486002)(53546011)(52116002)(6666004)(38100700002)(9686003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iqgLE8sWx4wI7pJoMIN3XRFVcyV63Y2gm57lTy1WFJ9N0SAYyFxsx/TNv/ag?=
 =?us-ascii?Q?303+lynqgq4k7DJl3eR2GcSyyBFsoHUA2Bn2rmpTtq+tKarY70PJkrwvSYpK?=
 =?us-ascii?Q?9tKd1awSuTErEJedTk6bCtwUCVFvZVWfLvcUeTKCi+mh4+6F0YQnzSG7s4Jz?=
 =?us-ascii?Q?fEbJu9Hddkn2hzIZWOB22C914g1ja7TRumYRN7gXz441AncuGhOLrAgji+0Y?=
 =?us-ascii?Q?T8kvrUQI2PTjqIADiFs4sjckcS3S2IhyZib/eYtGlzq1umSuSZdOJMggvgsF?=
 =?us-ascii?Q?BD7Z2sWLKyMAi+17d485wtB1i46JNUPhZq+bXypV1mZc0ZyKgnY5+wz0UaPg?=
 =?us-ascii?Q?TR70t7shlCiNinwXZW5S3CVO3ZZUf4YMGVGtGIj4itih5svy9wB/UsRZMYWa?=
 =?us-ascii?Q?sc1+JX89TZdrKdyrRZl8vik6fZk94QsB4S08cBVDil8EpVg9AqCqzkf5HBfN?=
 =?us-ascii?Q?K9AQEX9F4jqBoeuA5PxxMvxRb0dRqfUVFhEW+zKQVYQNDCxMpc06a55RGlqz?=
 =?us-ascii?Q?TmqamB9Z5DcY+XeUxMtGpUR2q2IXKSRtXW+MwT8j5EoUBOBtSj0yQmMTHstq?=
 =?us-ascii?Q?Z3EG+mvfaY+qTHKdOpTZlhPt9s7dA1m1Oj6e+I4MHgz6izXYJ3uaJ8IqV+N0?=
 =?us-ascii?Q?pZLNfZL+vY8LY6AMfQDL8yFGsc887c/1dhAupOXXmiNJxH1cba+MOOHneq7q?=
 =?us-ascii?Q?1WVTMM1nLUH9xpt4a3Rs5MzHz10DfKuWgLercx67V5vimg7EPCIYPk0HyvWA?=
 =?us-ascii?Q?ySJDPylTeo24F2KesBWHfcMVozWrBlem4ImqLe+IcDAJVVBan3jdrJ7CdxFE?=
 =?us-ascii?Q?SGu3EEV2ObZvz7sb5HWTKEwv7BZF4jitHQrb7ZjNc/DK2b7giebLW7A0eZrO?=
 =?us-ascii?Q?Omu1lkt+GZbeuzI16UbTBzSRq5uSKFPW1ScEfEx1OgUpAmM4KFN6DSX/UBRd?=
 =?us-ascii?Q?UUXSW75cqg6SrF1Pqc5CWfRSXBN05yZiUgwOEukC7UrVeKjFBZVfU94C2mAs?=
 =?us-ascii?Q?kF5VMs087D/sIOssUy3ZridS1p6WZiThrRbAvr5fX/WigrDiBb6zWaYhzcyx?=
 =?us-ascii?Q?TXztZb86mYqvtf+IvQm+LPlBLvBSSKAW06/Cm7iLOkZULIMjML71K+GovX4W?=
 =?us-ascii?Q?GQYkwORXc8BTcJudISFvLScBYPMUs2M+38VqSzqDaQZzo46dlbi8pWm88XQx?=
 =?us-ascii?Q?s3mWGzuWMLUBgUEOTTerIEkRw/QHUz5AWAIocIw9GTKaQEG8sXCQvhXRItyx?=
 =?us-ascii?Q?4dR+yD3aoR5Gx9YmMstyvUu1KHAQdyvc/y/uMc9dcAPplPdHR7bhMj9hAvIC?=
 =?us-ascii?Q?BfTZmtPzbhGQsyQr9sX0OxPNAaHPBWZ8DGgQDQoHQSEcpKFhGZfOquyEzMst?=
 =?us-ascii?Q?wybad4R2irsqu2/eIRTx3Fo+uTMboBBDDRJz13ztVcS1PfoMeGS2Dt9RRmB1?=
 =?us-ascii?Q?2VNzVk5C5J+zHUxBRGNlAp8knywYcaYRBVXsJ9RBmcoMnov0NUU+LGfXsq1o?=
 =?us-ascii?Q?6DVcHvzzX3o7fNvPHTOgmCqT25DxZ1enYPM28y5rnIS//AmnSqGTSKRBGnQ1?=
 =?us-ascii?Q?Gz9D3EuQ3qLOhURs4x4lvJm64tLePN8xJp/nunNN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fab4b6-39fc-46de-944f-08d9e667ca35
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 16:19:29.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCAMDVea71eyReIqtTslTN/o5OvUN++kT8RCqzAvDbyg+0SuO7w3d04gfXc3YHAa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2990
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 6x7TjkZEdCL19eusfLx4eafCLMX3TqKD
X-Proofpoint-ORIG-GUID: 6x7TjkZEdCL19eusfLx4eafCLMX3TqKD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_07,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=402 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 02, 2022 at 09:58:15AM -0600, Jeremy Linton wrote:
> On 2/1/22 16:33, Roman Gushchin wrote:
> > Alexander reported a circular lock dependency revealed by the mmap1
> > ltp test:
> >    LOCKDEP_CIRCULAR (suite: ltp, case: mtest06 (mmap1))
> >            WARNING: possible circular locking dependency detected
> >            5.17.0-20220113.rc0.git0.f2211f194038.300.fc35.s390x+debug #1 Not tainted
> >            ------------------------------------------------------
> >            mmap1/202299 is trying to acquire lock:
> >            00000001892c0188 (css_set_lock){..-.}-{2:2}, at: obj_cgroup_release+0x4a/0xe0
> >            but task is already holding lock:
> >            00000000ca3b3818 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x38/0x180
> >            which lock already depends on the new lock.
> >            the existing dependency chain (in reverse order) is:
> >            -> #1 (&sighand->siglock){-.-.}-{2:2}:
> >                   __lock_acquire+0x604/0xbd8
> >                   lock_acquire.part.0+0xe2/0x238
> >                   lock_acquire+0xb0/0x200
> >                   _raw_spin_lock_irqsave+0x6a/0xd8
> >                   __lock_task_sighand+0x90/0x190
> >                   cgroup_freeze_task+0x2e/0x90
> >                   cgroup_migrate_execute+0x11c/0x608
> >                   cgroup_update_dfl_csses+0x246/0x270
> >                   cgroup_subtree_control_write+0x238/0x518
> >                   kernfs_fop_write_iter+0x13e/0x1e0
> >                   new_sync_write+0x100/0x190
> >                   vfs_write+0x22c/0x2d8
> >                   ksys_write+0x6c/0xf8
> >                   __do_syscall+0x1da/0x208
> >                   system_call+0x82/0xb0
> >            -> #0 (css_set_lock){..-.}-{2:2}:
> >                   check_prev_add+0xe0/0xed8
> >                   validate_chain+0x736/0xb20
> >                   __lock_acquire+0x604/0xbd8
> >                   lock_acquire.part.0+0xe2/0x238
> >                   lock_acquire+0xb0/0x200
> >                   _raw_spin_lock_irqsave+0x6a/0xd8
> >                   obj_cgroup_release+0x4a/0xe0
> >                   percpu_ref_put_many.constprop.0+0x150/0x168
> >                   drain_obj_stock+0x94/0xe8
> >                   refill_obj_stock+0x94/0x278
> >                   obj_cgroup_charge+0x164/0x1d8
> >                   kmem_cache_alloc+0xac/0x528
> >                   __sigqueue_alloc+0x150/0x308
> >                   __send_signal+0x260/0x550
> >                   send_signal+0x7e/0x348
> >                   force_sig_info_to_task+0x104/0x180
> >                   force_sig_fault+0x48/0x58
> >                   __do_pgm_check+0x120/0x1f0
> >                   pgm_check_handler+0x11e/0x180
> >            other info that might help us debug this:
> >             Possible unsafe locking scenario:
> >                   CPU0                    CPU1
> >                   ----                    ----
> >              lock(&sighand->siglock);
> >                                           lock(css_set_lock);
> >                                           lock(&sighand->siglock);
> >              lock(css_set_lock);
> >             *** DEADLOCK ***
> >            2 locks held by mmap1/202299:
> >             #0: 00000000ca3b3818 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x38/0x180
> >             #1: 00000001892ad560 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put_many.constprop.0+0x0/0x168
> >            stack backtrace:
> >            CPU: 15 PID: 202299 Comm: mmap1 Not tainted 5.17.0-20220113.rc0.git0.f2211f194038.300.fc35.s390x+debug #1
> >            Hardware name: IBM 3906 M04 704 (LPAR)
> >            Call Trace:
> >             [<00000001888aacfe>] dump_stack_lvl+0x76/0x98
> >             [<0000000187c6d7be>] check_noncircular+0x136/0x158
> >             [<0000000187c6e888>] check_prev_add+0xe0/0xed8
> >             [<0000000187c6fdb6>] validate_chain+0x736/0xb20
> >             [<0000000187c71e54>] __lock_acquire+0x604/0xbd8
> >             [<0000000187c7301a>] lock_acquire.part.0+0xe2/0x238
> >             [<0000000187c73220>] lock_acquire+0xb0/0x200
> >             [<00000001888bf9aa>] _raw_spin_lock_irqsave+0x6a/0xd8
> >             [<0000000187ef6862>] obj_cgroup_release+0x4a/0xe0
> >             [<0000000187ef6498>] percpu_ref_put_many.constprop.0+0x150/0x168
> >             [<0000000187ef9674>] drain_obj_stock+0x94/0xe8
> >             [<0000000187efa464>] refill_obj_stock+0x94/0x278
> >             [<0000000187eff55c>] obj_cgroup_charge+0x164/0x1d8
> >             [<0000000187ed8aa4>] kmem_cache_alloc+0xac/0x528
> >             [<0000000187bf2eb8>] __sigqueue_alloc+0x150/0x308
> >             [<0000000187bf4210>] __send_signal+0x260/0x550
> >             [<0000000187bf5f06>] send_signal+0x7e/0x348
> >             [<0000000187bf7274>] force_sig_info_to_task+0x104/0x180
> >             [<0000000187bf7758>] force_sig_fault+0x48/0x58
> >             [<00000001888ae160>] __do_pgm_check+0x120/0x1f0
> >             [<00000001888c0cde>] pgm_check_handler+0x11e/0x180
> >            INFO: lockdep is turned off.
> > 
> > In this example a slab allocation from __send_signal() caused a
> > refilling and draining of a percpu objcg stock, resulted in a
> > releasing of another non-related objcg. Objcg release path requires
> > taking the css_set_lock, which is used to synchronize objcg lists.
> > 
> > This can create a circular dependency with the sighandler lock,
> > which is taken with the locked css_set_lock by the freezer code
> > (to freeze a task).
> > 
> > In general it seems that using css_set_lock to synchronize objcg lists
> > makes any slab allocations and deallocation with the locked
> > css_set_lock and any intervened locks risky.
> > 
> > To fix the problem and make the code more robust let's stop using
> > css_set_lock to synchronize objcg lists and use a new dedicated
> > spinlock instead.
> > 
> > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> > Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> > Reviewed-by: Waiman Long <longman@redhat.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Jeremy Linton <jeremy.linton@arm.com>
> > Cc: cgroups@vger.kernel.org
> > ---
> >   include/linux/memcontrol.h |  5 +++--
> >   mm/memcontrol.c            | 10 +++++-----
> >   2 files changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index b72d75141e12..0abbd685703b 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -219,7 +219,7 @@ struct obj_cgroup {
> >   	struct mem_cgroup *memcg;
> >   	atomic_t nr_charged_bytes;
> >   	union {
> > -		struct list_head list;
> > +		struct list_head list; /* protected by objcg_lock */
> >   		struct rcu_head rcu;
> >   	};
> >   };
> > @@ -315,7 +315,8 @@ struct mem_cgroup {
> >   #ifdef CONFIG_MEMCG_KMEM
> >   	int kmemcg_id;
> >   	struct obj_cgroup __rcu *objcg;
> > -	struct list_head objcg_list; /* list of inherited objcgs */
> > +	/* list of inherited objcgs, protected by objcg_lock */
> > +	struct list_head objcg_list;
> >   #endif
> >   	MEMCG_PADDING(_pad2_);
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 09d342c7cbd0..36e9f38c919d 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -254,7 +254,7 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
> >   }
> >   #ifdef CONFIG_MEMCG_KMEM
> > -extern spinlock_t css_set_lock;
> > +static DEFINE_SPINLOCK(objcg_lock);
> >   bool mem_cgroup_kmem_disabled(void)
> >   {
> > @@ -298,9 +298,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
> >   	if (nr_pages)
> >   		obj_cgroup_uncharge_pages(objcg, nr_pages);
> > -	spin_lock_irqsave(&css_set_lock, flags);
> > +	spin_lock_irqsave(&objcg_lock, flags);
> >   	list_del(&objcg->list);
> > -	spin_unlock_irqrestore(&css_set_lock, flags);
> > +	spin_unlock_irqrestore(&objcg_lock, flags);
> >   	percpu_ref_exit(ref);
> >   	kfree_rcu(objcg, rcu);
> > @@ -332,7 +332,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
> >   	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
> > -	spin_lock_irq(&css_set_lock);
> > +	spin_lock_irq(&objcg_lock);
> >   	/* 1) Ready to reparent active objcg. */
> >   	list_add(&objcg->list, &memcg->objcg_list);
> > @@ -342,7 +342,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
> >   	/* 3) Move already reparented objcgs to the parent's list */
> >   	list_splice(&memcg->objcg_list, &parent->objcg_list);
> > -	spin_unlock_irq(&css_set_lock);
> > +	spin_unlock_irq(&objcg_lock);
> >   	percpu_ref_kill(&objcg->refcnt);
> >   }
> > 
> 
> Thanks for taking care of this. Since it looks the same as my patch aside
> from the fact that I also defensivly converted the list_del to a
> list_del_rcu.
> 
> 
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> 
> and
> 
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> 

Thank you!
