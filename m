Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5228448EF96
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 19:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiANSAW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 13:00:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8158 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbiANSAV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 13:00:21 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20EH5XtH030425;
        Fri, 14 Jan 2022 10:00:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=WLORcTTPKSa0P+gucxjXrpFHDo3xCpKJtCROdVQHIJs=;
 b=OkcWO7SNkcoKX4DFiHYOZlc8ln2VZ71MS/FblNPrd1HFflCB6CIJhFpjg5UGHS15VhEo
 0EbtWDVAl9MViLPorWenwO2ilVapM+J/xw65lvJrJ1ffvEqYa7tNg/c/frmcZLMKslz4
 GthF5M2tWz7zOzfsnsCMG457SB30sFuJZKk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dk65rapcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 Jan 2022 10:00:15 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 10:00:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYTTGQuzjpDn61ElQiUGMqknrgSmOc/Z0zW0URkfLMzYH6WixCJVpDe7zo0+EilkWLPNol6RuHc72BLM64rSXSfnbfL6m8QBQgiaOcql6UnRenNilzcPE8vaPI3cdSCXgKz+FkRem9dpYynS7tmIRaEu9qfspU5A+YZApyB/iStI6gUskEuTepe6J2TYD2Pe4rsOaJvsVrhGPpQvivudMVEUMN5CJU9bqr4xgpfmWDDfpGQQ+mnScBeh8HWZlD9NVo674kBGMrLTB0PN7QvtQSAJBO8jS/KzdAipwgMTWWcArmX/EjzTrPMOOVevw+Uqdg0PX2NNRlUyqSs3x5QU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLORcTTPKSa0P+gucxjXrpFHDo3xCpKJtCROdVQHIJs=;
 b=EeLAfnPG944Zgm98GgXp5feNDjlzFAyPKfSkZ+FJGtQYmNbzz1GqZsuWLhgxdXYujy8MHLfbkXbF7+fPzH7BqYM68sJctutVumPBeFoGQ0xE09PzQFPaVy7r9IM77EJTL3aw7cQIcUMyUfLqdSls3urZI8lCcOevv0xTwCDieNEZ4o6i3778TcCKMuhWvaktnhE+1mT+j/R5c8PCRiSdZmVaxvThSjXMcQIf7yZ4iXly2jtFWjLaF9dyu4A6XztYP3MpKkDBJzGFpY/aYumo5pt3T5EjIoZfZ75TBvMdzdys60t3O8pUuwYLfOR0LDtobzr0/B5peUkCScAsHeQbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BLAPR15MB4033.namprd15.prod.outlook.com (2603:10b6:208:27f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 18:00:13 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 18:00:12 +0000
Date:   Fri, 14 Jan 2022 10:00:08 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        <cgroups@vger.kernel.org>
Subject: Re: LTP test suite triggers LOCKDEP_CIRCULAR on linux-next
Message-ID: <YeG6KN9HW4uCF7fj@carbon.dhcp.thefacebook.com>
References: <87mtjzslv7.fsf@oc8242746057.ibm.com>
 <YeGjcF6CU/R6cyec@slm.duckdns.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YeGjcF6CU/R6cyec@slm.duckdns.org>
X-ClientProxiedBy: CO2PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:104:5::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 894d5f53-9afc-47f0-cbaa-08d9d787b5e3
X-MS-TrafficTypeDiagnostic: BLAPR15MB4033:EE_
X-Microsoft-Antispam-PRVS: <BLAPR15MB403306890775B59B3A64998ABE549@BLAPR15MB4033.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xC8lnyoC9kd4Srfqt0gh719XxA6U464+E7V/0ArSZz/o2UfSpTd8kCBLVLDqwF3D5Uqze0eICI9wLnb3uNNaoQPTio/nUhn30jk6cbd48uooRSRmhW8hEahvdBr8C81lXKRFfun6b8c6jN6p+5gjg2Rz+p5ez4QHNbYhHGQYbjL+l1DVZmzHxKQjGgA5Rg0HGZnPX5IfjRZLXgv6UTr2ExXlU8FFJZJEw/kZUn4NGXBnCpUAh0VheErMcJ0mbQ8SWbtKibJENbDmn3UOjBcUxaIOBRnQ+tRLAKXRlvdHzwvmjyalI1EcvqT4905z3CSV2jcK0zVLNgcuAZ8e7ILCGWvtkZ5CZBnzfFCwpQSXkbxvpcswYYenBmfM6vyxPnpQ5sObsIjRA98n+TO+UCpdJe8nnIvcy4N+7lEDKksvfAqxy6xO4vW5GpW8cEmRXlEt6zo9yRjthhGeYM40kBMj2rbVKeXZo4zYSBZ7kyWc3E3c6Nv4hokO2VXuSzU2XK53kN9XlsZrhJvR8t9peCLYn95maKdWtbS6dsuNGws3U0efnhXm5y02HUPewnNBJfW8n3AX0o84jZRNVlBMrd4KVO30z5xIEPGLNJqndKGLLpaYtPrQAhlShfZVUuTJENMWxpUAk+Gxy44N/capKBx7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(6916009)(316002)(8676002)(8936002)(83380400001)(66946007)(66476007)(66556008)(9686003)(4326008)(6486002)(2906002)(52116002)(38100700002)(6512007)(6666004)(6506007)(186003)(5660300002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R1YIBXBFiZGQeek2qjzHuo7sOAZ2XfB1EEQxd7l/Z4g1LZPSBhJfcmugc+hZ?=
 =?us-ascii?Q?Y3gvL4v4ZLYo2NIHDVNHdSdTk4eZFCe7mw6Ken/yrXbsizUuikSdU9creBYB?=
 =?us-ascii?Q?hnGZaPCMyIGG4hZzKdM8jNenmbb3rdReCIYHNKqGLPd8TlFEiBrLWDiCcEcD?=
 =?us-ascii?Q?6yzbW8vYb80B00Cyy4d2U+kFiVaVMxGUv5mr859Y8ySPlhaFDQ1VuY5JnGaj?=
 =?us-ascii?Q?yPkVEweCQpvMg6E2vjVgGQjqRZPzf1vDN90QYc62E7xhcVy38b927aK+1vU2?=
 =?us-ascii?Q?f5wv6CpRPVwVK+27t43S/oC7L+ucdBHCNuVNjlF+uBT5IU3rfQrh7shpwSAO?=
 =?us-ascii?Q?4Dyj6kVL3OCEXyZD+7bby34ML7dwxKR/6x98R5Sv5xTrWnL5GvKyqSEXWmMY?=
 =?us-ascii?Q?tyPbrWGv5aKHTGVb8OLSxnwzdYABS4SmmWWByxscQ5u/XYvM03CytRZiQBH1?=
 =?us-ascii?Q?RqBIjlEZx1dw/vNX3/WzZn5ILWc7zQCQb3GD7qTShyn8CyxiCg6S/EMyvdi0?=
 =?us-ascii?Q?2ngtviOzUz+YhsLOqMBfskVDg5VnOqb2cuzqJx3syuSKBwd7G7czA5wSajkW?=
 =?us-ascii?Q?QmOgiXYyxxPjYHGPQkyJEF2dyCn3HB10fC+mXx/HFjpu66+5LDfV3128w7F8?=
 =?us-ascii?Q?FfR2C3QlXdIGtFKkqrqemmv56Qy2KxqwsOyteMWbkV8bfx0ESoHwjXrARSEu?=
 =?us-ascii?Q?hTrQkYfzdJWm2YHClxg7R1O3OJkjhfCjoVOlwr3PEyEKSjzQI8RKtxKI0fnr?=
 =?us-ascii?Q?wwJvPLnbRr1P7pp9S9T+QQpp95nPH6COhsRwTIIWDwWGqxx25bmU9oRFiVAQ?=
 =?us-ascii?Q?5jC68Lc3v5jP5LUlQp0HOxOzMRlgHZ3wCgDfpb+xtVznuEquYMfmJRfshKj0?=
 =?us-ascii?Q?KuFVvkqLc0Gc1+rDJ5JKDH5lEu3pH0agRHGivqdEs2M2H9rdSVj0ZmdoL9q5?=
 =?us-ascii?Q?eKTsD6erRGKZIAcs1Y8L+TeUIa2gqSgBiXn96twVTi7MaGbJanhTQ+euhxPa?=
 =?us-ascii?Q?5k0daFSQzLeyySMBRlJPRtgh9sLuGQATL5U4Vt4GwntXlnp2g4BFNA4SD2UQ?=
 =?us-ascii?Q?C20wyrh966fh32S9vfujs9OWeRhhac1mCasvbNVCp7RSgeiOr3VoICYo+au/?=
 =?us-ascii?Q?diqfQ+53Kg3dtP+sQ6QArDyhGWyjgaV+MD6dVSXLKjkrGrMmwvCFfYPvVXOK?=
 =?us-ascii?Q?THk/kFURI9tqXL6CsNp2gSTN2vBWzCDfr6daD819J+RKsXgL3pXR5FG9yp/F?=
 =?us-ascii?Q?gTm7b6nKW+WJzeLkz7bL5C+PMIsPbCXcNxnq+H+wvOWKpAcnN6mTfxtIRRo/?=
 =?us-ascii?Q?A1zuSeXi4wU2GMGqyuJv/m3uiH9T4btM4pciZot8gPgP4d8CI7ZyTe8J7USc?=
 =?us-ascii?Q?Wi/Uc1b7o6DGtzqVZhlqUt6hb8/8LZiB2zgSgpDfUuw2V+ziyqoC/9h8T3SD?=
 =?us-ascii?Q?1CrNb7e81ogjidpQ1GS04ZzozV4BQ20BwLYgKm2J61SlAmmeskIYyQYFgCbB?=
 =?us-ascii?Q?M1+1joKStKq73z3CCnJjAVD+q88gUR1V8wUFK4dBl2hjher6DLLdXNkh5YxU?=
 =?us-ascii?Q?aqN1XouB7xJRFuddAkf4rKM/uRMTTMNytVZ7OlaK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 894d5f53-9afc-47f0-cbaa-08d9d787b5e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 18:00:12.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyPrP7tn7RBCPLKpbSPI3VXLZIbgl7sLUVoeZ7LSBwCypnTJS56hzCRUNYm8SSRE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4033
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: p_lXxoSe1AyI4q5muVw3TykvNF0AthdX
X-Proofpoint-ORIG-GUID: p_lXxoSe1AyI4q5muVw3TykvNF0AthdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_06,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=503 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201140112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 14, 2022 at 06:23:12AM -1000, Tejun Heo wrote:
> Roman, does this ring a bell?

Hm, interesting... Alexander, thanks for the report!

I think I know where the problem is and have a couple of ideas on how to tackle
it:
1) use a dedicated spinlock instead of css_lock to sync objcg lists,
2) push obj_cgroup_release()'s code to a work context.

Let me think a bit what's better and I'll come up with a patch.

Thanks!

> 
> On Thu, Jan 13, 2022 at 04:20:44PM +0100, Alexander Egorenkov wrote:
> > 
> > Hi,
> > 
> > our daily CI linux-next test reported the following finding on s390x arch:
> > 
> > 	 LOCKDEP_CIRCULAR (suite: ltp, case: mtest06 (mmap1))
> > 		 WARNING: possible circular locking dependency detected
> > 		 5.17.0-20220113.rc0.git0.f2211f194038.300.fc35.s390x+debug #1 Not tainted
> > 		 ------------------------------------------------------
> > 		 mmap1/202299 is trying to acquire lock:
> > 		 00000001892c0188 (css_set_lock){..-.}-{2:2}, at: obj_cgroup_release+0x4a/0xe0
> > 		 but task is already holding lock:
> > 		 00000000ca3b3818 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x38/0x180
> > 		 which lock already depends on the new lock.
> > 		 the existing dependency chain (in reverse order) is:
> > 		 -> #1 (&sighand->siglock){-.-.}-{2:2}:
> > 			__lock_acquire+0x604/0xbd8
> > 			lock_acquire.part.0+0xe2/0x238
> > 			lock_acquire+0xb0/0x200
> > 			_raw_spin_lock_irqsave+0x6a/0xd8
> > 			__lock_task_sighand+0x90/0x190
> > 			cgroup_freeze_task+0x2e/0x90
> > 			cgroup_migrate_execute+0x11c/0x608
> > 			cgroup_update_dfl_csses+0x246/0x270
> > 			cgroup_subtree_control_write+0x238/0x518
> > 			kernfs_fop_write_iter+0x13e/0x1e0
> > 			new_sync_write+0x100/0x190
> > 			vfs_write+0x22c/0x2d8
> > 			ksys_write+0x6c/0xf8
> > 			__do_syscall+0x1da/0x208
> > 			system_call+0x82/0xb0
> > 		 -> #0 (css_set_lock){..-.}-{2:2}:
> > 			check_prev_add+0xe0/0xed8
> > 			validate_chain+0x736/0xb20
> > 			__lock_acquire+0x604/0xbd8
> > 			lock_acquire.part.0+0xe2/0x238
> > 			lock_acquire+0xb0/0x200
> > 			_raw_spin_lock_irqsave+0x6a/0xd8
> > 			obj_cgroup_release+0x4a/0xe0
> > 			percpu_ref_put_many.constprop.0+0x150/0x168
> > 			drain_obj_stock+0x94/0xe8
> > 			refill_obj_stock+0x94/0x278
> > 			obj_cgroup_charge+0x164/0x1d8
> > 			kmem_cache_alloc+0xac/0x528
> > 			__sigqueue_alloc+0x150/0x308
> > 			__send_signal+0x260/0x550
> > 			send_signal+0x7e/0x348
> > 			force_sig_info_to_task+0x104/0x180
> > 			force_sig_fault+0x48/0x58
> > 			__do_pgm_check+0x120/0x1f0
> > 			pgm_check_handler+0x11e/0x180
> > 		 other info that might help us debug this:
> > 		  Possible unsafe locking scenario:
> > 			CPU0                    CPU1
> > 			----                    ----
> > 		   lock(&sighand->siglock);
> > 						lock(css_set_lock);
> > 						lock(&sighand->siglock);
> > 		   lock(css_set_lock);
> > 		  *** DEADLOCK ***
> > 		 2 locks held by mmap1/202299:
> > 		  #0: 00000000ca3b3818 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x38/0x180
> > 		  #1: 00000001892ad560 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put_many.constprop.0+0x0/0x168
> > 		 stack backtrace:
> > 		 CPU: 15 PID: 202299 Comm: mmap1 Not tainted 5.17.0-20220113.rc0.git0.f2211f194038.300.fc35.s390x+debug #1
> > 		 Hardware name: IBM 3906 M04 704 (LPAR)
> > 		 Call Trace:
> > 		  [<00000001888aacfe>] dump_stack_lvl+0x76/0x98 
> > 		  [<0000000187c6d7be>] check_noncircular+0x136/0x158 
> > 		  [<0000000187c6e888>] check_prev_add+0xe0/0xed8 
> > 		  [<0000000187c6fdb6>] validate_chain+0x736/0xb20 
> > 		  [<0000000187c71e54>] __lock_acquire+0x604/0xbd8 
> > 		  [<0000000187c7301a>] lock_acquire.part.0+0xe2/0x238 
> > 		  [<0000000187c73220>] lock_acquire+0xb0/0x200 
> > 		  [<00000001888bf9aa>] _raw_spin_lock_irqsave+0x6a/0xd8 
> > 		  [<0000000187ef6862>] obj_cgroup_release+0x4a/0xe0 
> > 		  [<0000000187ef6498>] percpu_ref_put_many.constprop.0+0x150/0x168 
> > 		  [<0000000187ef9674>] drain_obj_stock+0x94/0xe8 
> > 		  [<0000000187efa464>] refill_obj_stock+0x94/0x278 
> > 		  [<0000000187eff55c>] obj_cgroup_charge+0x164/0x1d8 
> > 		  [<0000000187ed8aa4>] kmem_cache_alloc+0xac/0x528 
> > 		  [<0000000187bf2eb8>] __sigqueue_alloc+0x150/0x308 
> > 		  [<0000000187bf4210>] __send_signal+0x260/0x550 
> > 		  [<0000000187bf5f06>] send_signal+0x7e/0x348 
> > 		  [<0000000187bf7274>] force_sig_info_to_task+0x104/0x180 
> > 		  [<0000000187bf7758>] force_sig_fault+0x48/0x58 
> > 		  [<00000001888ae160>] __do_pgm_check+0x120/0x1f0 
> > 		  [<00000001888c0cde>] pgm_check_handler+0x11e/0x180 
> > 		 INFO: lockdep is turned off.
> > 
> > 
> > Regards
> > Alex
> 
> -- 
> tejun
