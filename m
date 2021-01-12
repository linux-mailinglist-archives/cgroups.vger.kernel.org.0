Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784CB2F3CD3
	for <lists+cgroups@lfdr.de>; Wed, 13 Jan 2021 01:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436866AbhALVhU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Jan 2021 16:37:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12988 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436767AbhALUNe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Jan 2021 15:13:34 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10CK98Lq003022;
        Tue, 12 Jan 2021 12:12:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=73Tn38H5d8wv5kXUmdSnYDgS0YX7jptk6FbRsH6Q42E=;
 b=I+QMYvfs33XzQrOxSL5mPBHEcrlp1qfvX9LnAHQ3spACP11rLCnrKeXZXEzR9UYG/SK+
 P8UoNwDG+2jF46Lm8a4juqISG3cQLgI21F1rxabKedkzmKcUUiVqB/mnMt0G/Md/ft0z
 30XPzZxqTNaS8vsZW1vOn95L4V71b0tQ+ok= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 361fp2s8k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Jan 2021 12:12:45 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 12 Jan 2021 12:12:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NM+dGsmVyZZ1oXwMApZRiTt9Qz0+Qs/s6H5/kwBt0krPYEMQa7kqFg2POQEJ/2a5JdmYDOTHtYn5kaGn0Pw+IdusywaB5C3ZYE9k4/omsK6Z3q1AhDakrnePN1w//jG1SCwfvHfGc8f9DPJ4MjBNGeZ1e7DylICjsrpUuHY/AIAH3vNufoZff8i7g4skOV7bYOwqI6rwz5W4J8XYha7ZitnqNBD6sO//52vl6ps+CnfiOddAeyehyLuV52f+gN5tu9tH3uv34yKAG2dhBYfDvM7XticutmE6ksANR1L3bNd7HmuPN+9n4NnYt0JCVnYn9ut5dKQ6+g4uaLI5L3/3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73Tn38H5d8wv5kXUmdSnYDgS0YX7jptk6FbRsH6Q42E=;
 b=MzNNatwIhLa4OGU49Zv1gefOyUippx8wgsyvmgK3WLYsA2n9MGqHBwhiEaPJUdfVlPk5fNA/IzvjNrnl7CykZiuhdHh2+EiVkvhs8lhrNSM2cF70upYYM+pnNyu9D7NE7HW42vwbxRmKffddk3z74Kuo6pNDxaD2llIp2nEqwRklGEfaaUHwFtZJvlSd0WruGNJS/P5tbZowli7IkvBv5p7WSaUGjgdbfJf3vZR10dTbPIxO3lLrfynELqgASKjId9x4mSS7yuuUxrZ1Ne4QUQiDXxWztKMfNY1NElZeihETLaa1M4y8q+BVQdtVMB3eYKYlUCk4Zu7Acjy2SJQkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73Tn38H5d8wv5kXUmdSnYDgS0YX7jptk6FbRsH6Q42E=;
 b=B9OjCJBx8VFG0YwavTrIWHgjm4332X4vpxSeb+qK0Uymvsg2ffbpGiVYW2GsDLae63fKdJ7rzFmfkQSWeJWVPiDz0IZ+WL/0h6xpw/s5Tw1pM4COqOV3oensT9PIieHKyDKFOoptzGE6unUyNwlZfy5KaZDA2QiLz6azBYJ3Ijc=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB4276.namprd15.prod.outlook.com (2603:10b6:a03:1b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 20:12:41 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 20:12:41 +0000
Date:   Tue, 12 Jan 2021 12:12:37 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <20210112201237.GB99586@carbon.dhcp.thefacebook.com>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
 <20210112170322.GA99586@carbon.dhcp.thefacebook.com>
 <X/38ZwyOE96SAfa9@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/38ZwyOE96SAfa9@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:329e]
X-ClientProxiedBy: CO1PR15CA0085.namprd15.prod.outlook.com
 (2603:10b6:101:20::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:329e) by CO1PR15CA0085.namprd15.prod.outlook.com (2603:10b6:101:20::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 12 Jan 2021 20:12:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adc8c7ed-bf5c-43de-2f91-08d8b7366a88
X-MS-TrafficTypeDiagnostic: BY5PR15MB4276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB4276B2411F6796A0F9589118BEAA0@BY5PR15MB4276.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBYbozSS1Vr5w5BcJ6gDhqALf/qm10jcy6goumV+W1pO20kacmDwbRCPdCC2eZs3C5PK1Nl0lf1krlqO0Xo9dTBm/eVN+sI3jEO9jNGVDO1wUsBxjJQWUao6c8rAESsBRc83qeHlWkGQCdNPWfgLF6QUYQOJqTULuzJTI0NkPiEt75D4G5LE1aY4H2pQqtWpHXk6B5Nll6k4Wc9WW6Qehiq7G2hVJyoLTvF6NBrJXnzuzd5moVSNFmbGKSNRc83u1jYDZMUh6nXhwNspuzUhqhzxU8Gk8kPHcDMhTxsuZhDMqDS1oajjCHGyIUKR0eCPj3LzFPlWqQrFwYL/Hi+3CpUDx9QulsM88GwK5RIirgOSEaNujRfnlInEeUgENfzUsIxrGibx14pml+JbsAlOwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(16526019)(6916009)(52116002)(54906003)(55016002)(66556008)(83380400001)(8676002)(186003)(66946007)(9686003)(1076003)(8936002)(5660300002)(66476007)(316002)(86362001)(4326008)(6506007)(33656002)(6666004)(478600001)(2906002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EWDUSrxQqAHkEDoaH2aKykwTVXXYw4J1eGqlZc//2pUvd6xiLXvB9L2vRw9l?=
 =?us-ascii?Q?yQ3+Z25vADXPLn8eT5PoILagswgOg/lv0QI2dZNiyKqu/UhBvtMRMiIaLUuT?=
 =?us-ascii?Q?lr5Zr43fOyi7zDBW2D3p8mlxKJnaTIDxEO6pswDWjEKifUVCPIW3+Ox2j+YH?=
 =?us-ascii?Q?b1LIJWCM+lBjLcLSTP549fJKOH8DoqhsJWya9qEgCCs8IA3kjKUBJVkX/mNq?=
 =?us-ascii?Q?JBM92B4Bh5OW07hJTdMCGvBWdraM/Xc5obwcfv7JFyoqnB34H5n7hjqTCDBg?=
 =?us-ascii?Q?dOiwDJ8w1sOzAq4MtWAdi7A81Y7rSzvnpy/g7aC2fypK3v56zH3EE6dBudPi?=
 =?us-ascii?Q?C/0404zYkB9+xjYN+/6H3+UsB1bqlXpT/hrqER6FDube9XxdP+ALgAsZ4FWE?=
 =?us-ascii?Q?3AHMQ5iDdLUBb7xZUWj+h4dh81ECGh+8GM5+96oaOro5DHlwxoHDMAnD19kB?=
 =?us-ascii?Q?7zChsG7lwXsaJDREeSKQ44ns2b/Bg5L+6nBAKx7bu2sLQZVMPRGbVBTcSIXv?=
 =?us-ascii?Q?tbOPtCed7THUvAnt+Ub66iRIzQDu8i4jcZ3jdVjo4gKdOV8kPsl4A0sIfjwy?=
 =?us-ascii?Q?6R9w8r6HNChSTlV288VtA0HWL26VBbMF64bU/EdvfaS1p6xabde7jLGEjbAX?=
 =?us-ascii?Q?g4NCG9qoAL60pfDfu93HWwvWXZi+BAbvYE2RDaXeuGbLsjD0TkzToLx2aCg3?=
 =?us-ascii?Q?eXsNFR8c1V4ft/HR0rYDnIucWz3w6XiDAGIEZcfWgQK09ML/UCQJNIbRgNat?=
 =?us-ascii?Q?fYlIpJott1qaa+VqZk3agKv2zaT9qT7PQr4AzOhNkFd39MTLLi8Elz5XUR23?=
 =?us-ascii?Q?kHU8Yb7ieUSbh/BJrd2SZj/yoAUulJfFPpv1Qy6HzEPNx3chZT3p3YK0Mqdn?=
 =?us-ascii?Q?PRsMNJZi9errJ0cQfVadxz0fj+rBtN/+e1FXlwi4E/4Qdnxk5uI9dMZ5yWPl?=
 =?us-ascii?Q?KdwR1iwU6cqONpQNG7SPTJxX9n9WhKqfb5yBA48Yqw4f51NbPjhqeUKOqLDR?=
 =?us-ascii?Q?TMZZYgV5CGJxQMa/3O1ph5HfHg=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 20:12:41.5262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: adc8c7ed-bf5c-43de-2f91-08d8b7366a88
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRnQi+2U6se6R1sXmr4OggJ0Nov7qRneDNNudqJwqpjwJhrKtBP6Fmz2Ct4xuTUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4276
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_16:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 12, 2021 at 02:45:43PM -0500, Johannes Weiner wrote:
> On Tue, Jan 12, 2021 at 09:03:22AM -0800, Roman Gushchin wrote:
> > On Tue, Jan 12, 2021 at 11:30:11AM -0500, Johannes Weiner wrote:
> > > When a value is written to a cgroup's memory.high control file, the
> > > write() context first tries to reclaim the cgroup to size before
> > > putting the limit in place for the workload. Concurrent charges from
> > > the workload can keep such a write() looping in reclaim indefinitely.
> > > 
> > > In the past, a write to memory.high would first put the limit in place
> > > for the workload, then do targeted reclaim until the new limit has
> > > been met - similar to how we do it for memory.max. This wasn't prone
> > > to the described starvation issue. However, this sequence could cause
> > > excessive latencies in the workload, when allocating threads could be
> > > put into long penalty sleeps on the sudden memory.high overage created
> > > by the write(), before that had a chance to work it off.
> > > 
> > > Now that memory_high_write() performs reclaim before enforcing the new
> > > limit, reflect that the cgroup may well fail to converge due to
> > > concurrent workload activity. Bail out of the loop after a few tries.
> > > 
> > > Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> > > Cc: <stable@vger.kernel.org> # 5.8+
> > > Reported-by: Tejun Heo <tj@kernel.org>
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > ---
> > >  mm/memcontrol.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 605f671203ef..63a8d47c1cd3 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -6275,7 +6275,6 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
> > >  
> > >  	for (;;) {
> > >  		unsigned long nr_pages = page_counter_read(&memcg->memory);
> > > -		unsigned long reclaimed;
> > >  
> > >  		if (nr_pages <= high)
> > >  			break;
> > > @@ -6289,10 +6288,10 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
> > >  			continue;
> > >  		}
> > >  
> > > -		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> > > -							 GFP_KERNEL, true);
> > > +		try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> > > +					     GFP_KERNEL, true);
> > >  
> > > -		if (!reclaimed && !nr_retries--)
> > > +		if (!nr_retries--)
> > 
> > Shouldn't it be (!reclaimed || !nr_retries) instead?
> > 
> > If reclaimed == 0, it probably doesn't make much sense to retry.
> 
> We usually allow nr_retries worth of no-progress reclaim cycles to
> make up for intermittent reclaim failures.
> 
> The difference to OOMs/memory.max is that we don't want to loop
> indefinitely on forward progress, but we should allow the usual number
> of no-progress loops.

Re memory.max: trying really hard makes sense because we are OOMing otherwise.
With memory.high such an idea is questionable: if were not able to reclaim
a single page from the first attempt, it's unlikely that we can reclaim many
from repeating 16 times.

My concern here is that we can see CPU regressions in some cases when there is
no reclaimable memory. Do you think we can win something by trying harder?
If so, it's worth mentioning in the commit log. Because it's really a separate
change to what's described in the log, to some extent it's a move into an opposite
direction.

Thanks!
