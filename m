Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE22E680BAA
	for <lists+cgroups@lfdr.de>; Mon, 30 Jan 2023 12:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjA3LMb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Jan 2023 06:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjA3LMa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Jan 2023 06:12:30 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC447689;
        Mon, 30 Jan 2023 03:12:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4QQovX/iZcc5cqC/WnYtvZeazSGwbvrR8jBWK8TPAEBAt6AF0DCCe6gRVIRNjpG2coeJAx9/VVge0YA30gw+ithb1UVOiiTW/jbSyTNhVE6xLwql8fo0EbqkYkBWB4zQhSZxPvc7eJhxZejfjAJd2/CmXWYlcMRGG75jZRU151/ihewaG66auuleCbTJ1r19/KdnuDVI1BPyY0JwJI/eXJm6/KBFm2wK2FChYLvgkiethRniA+x597dNMePwK34EaFmz78++0E5+TBnU/7s9PBcGEIj2tFLmr1n509C6B0JV4DuUPeA5z1rsoeChBs1sYIeR251NY8ng0BrJe6vpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnfClW4dnpNYIts4/oNZ8ZyQfZwzKU3kZcQcXMc3fvU=;
 b=WWBOXKWFHmu9WhEIWqYTW+8Dz52DkEtp9LkCLABK3oDJryAtYM5UYm0/mQj/fbDPkkvxdwx0MMfPMp53je24RHl/AtJfsbkD/g4NGGqJ9XYs/skcCygKo3l+MyflafhPYYt2HgBLV278x6x4VubXmR8yX06JQPIk3cieAHH5n7VZdQUkX0bSOMVaxje5YemrCSkxjYQqkqaTJdJIsDWUo7OpD6/wICN/IjcOHcW0BTBegjR8yvajjRpAo/Nkp8M0FSMO07DiVBXo6D5vBLVS3zzE9zsLoNyQ7AGXJ0bku7s27ZDw5oUKIiSRgLFWUR59ZWYAyxblKsdfYmGHsI65SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnfClW4dnpNYIts4/oNZ8ZyQfZwzKU3kZcQcXMc3fvU=;
 b=fHD4un/Fav6WXJGyk9xPp9RMCsggDjybx4u31X0ENDkbRD1upa45Prp7KvTXDqvLyUONWZRPfJHooG8ZxljzglbYtQoTOJt4CQfq1m+8UAqmcEYLQ+lrmhRHZyTGUJnO5zoSxYb1BEJl+SqLVpweAtIgqOslj8wJ5e9WQ4ql/LObKRS5Tz3SRAPa3GaZImHxoKcxMFj4kQQVmsOS0bSKUufQRiGiGRYTJDr76FE+PUSibLmFgUTnj0UfDDweqg/5cZz3QWM8E/P5lp7vSpC3mxysxNOWEJ+MJoQMUw+nfMvi2PDc93XQUdzzVqX7nYGeR//V7uOIag/d0nvOFUojYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 11:12:20 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6043.023; Mon, 30 Jan 2023
 11:12:20 +0000
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <03ed2d166826cd7055810c66a175e20fa2153c52.1674538665.git-series.apopple@nvidia.com>
 <Y8/uGL+TA7ow4Zmu@nvidia.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 06/19] RDMA/usnic: convert to use vm_account
Date:   Mon, 30 Jan 2023 22:10:39 +1100
In-reply-to: <Y8/uGL+TA7ow4Zmu@nvidia.com>
Message-ID: <87y1pkz376.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0042.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::11) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf7378f-7507-4440-dc2a-08db02b2dacf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLg4cJM8TymnJGBf58gUIqLhruDuwGS8aPTGZQLhzwG1lV5JOBS7xN9pBCRCDhWTvwZd1qa1lpwpMredOrfM+rqEBTY3UJmQ6GjeE+PkVc83kIDBOrkK9UlQ0YOV2wsO4Jue8NlJo78skTbwR0X5HieoGkPWaiz5GYZ3G88zL0dyppHUCpz5cLPBX5r/8RypcTv+g1qX63jpHBgRMrDPsYs/9m8h2u5fISpD+qsNk+RJrxBifQIhtdyTPhOvccPIIWIwJZABl+uxK5xf2aFgVKbpGMjveSeS5s+Lb8bktz78ytRZSspJgBO/mRI0eFg/xQt+EE1u+pV27zBa0Z5MPItHP6j+QM7VddFTHmMCi/BRp8zl/Bn7Rmve1Ht9qn+5mFYa/zaqDDfDFVUhphVNGgYGuChYZ3dKHMlnJxzteFbUMMRHpZQEnrIHC8YnIx4h/227tTHAu3MVxSIx6NWJbOubnOPPpzGG0d0ZoROJHYYHA7ig0HZvHOvQIgT48X9zzdPPggHHNUm8OgDDGgCUdag7CrTVwAE25sbtitWHxDL5IgsCPNP03MIYt15VEGPYJfePeqTxLv83wAoD/tUo7XzhVn6+KSudxNWaRpR7XpDT7FdrupzahpkK1dalAKrsayBn3aAOJSzsVgzGJiByUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199018)(8676002)(66476007)(66556008)(4326008)(41300700001)(66946007)(8936002)(83380400001)(6862004)(478600001)(86362001)(316002)(2906002)(38100700002)(6666004)(6486002)(26005)(6636002)(37006003)(6506007)(5660300002)(186003)(6512007)(54906003)(7416002)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nMPOa/MQi9zC6IQgdnWiQ18A/LKLk+i/EV1uxsZbNiRLcJHUTS3/U/Gc9KUT?=
 =?us-ascii?Q?tWIfBHtjaVQMldIlJ6YLZwb5J+oU8WinbDTil6t1Hsd70IeBsEEnsWBSyaBS?=
 =?us-ascii?Q?xV0OS5Ts9QitZ5s9QgzBihCcAxeGR406u48HqdSQm29+eJZ/nOn5PHMFHklW?=
 =?us-ascii?Q?uTbFhX/iklXpW3whBWtXS5Swf6wM1GzIHDIsxt5fHytanDeh8VH3Nd5h6Nn5?=
 =?us-ascii?Q?u6FTiwsIB2CWzhQmfopi3mUExTCngXzqJEchopanvsxf0nUuGLM9GiWvkYNj?=
 =?us-ascii?Q?OPGNR0IIRAKu/Ix/iBYYpXu9YV+uCyP+rlZADv4f2R6Vf1fv/582uneb2t9n?=
 =?us-ascii?Q?+loNZsm0tggXW0d6v5mib78C682S85q2QkJ99YEzPP8FQUELRABGYKrotCU0?=
 =?us-ascii?Q?xYQg72RLLebStrXznq5TjbAH8E7Iij+iB1V7sE2wwANPNCNhazroxvumYZVK?=
 =?us-ascii?Q?JNrArK2M2C62fmCy2glQomKxaYNIQMHS663tz8UBCgGModWM4aYEskRw6nox?=
 =?us-ascii?Q?lo3phoS80IYyIFqf2RaX861cWtEC4TJXrIfXATYUQJDojreXCR+fms0xkfhh?=
 =?us-ascii?Q?iciXAkJj3r2R7IodX0uppTn6IwWL8MG0KuQdp1sgYxMoFcfP0FN2luJxr5Hw?=
 =?us-ascii?Q?vCO3ojOvFqQbtE6o56rNUpzNmd0oz78N6yXEvsLZVXOfGwXavhuHLAiQOu6S?=
 =?us-ascii?Q?UHTZ540cE/qJJtm0sNE+FqGESi5zqQsypk+uXh1CZ5u0r9HVT1tCCbdFRZff?=
 =?us-ascii?Q?4aO723znCderSv6A8yRLgTelS32dfFqFcn+MjyRXfVg7uiuOZttkf3oIeCbD?=
 =?us-ascii?Q?SEKDLsis75mfDpt1BChNOKbBU2CkY3Zy0UUGPuqg6SCXXSVbZBDqlrY03gM9?=
 =?us-ascii?Q?djlvblpvhZB96nwAlmKc48bNa2NvrJMbr/ztmrqq0/He2toprkYA+66hQ6gG?=
 =?us-ascii?Q?YwFwsfGrZOqSmBGtAyDtvNlw5PRIEkKm08wO6IIbNmi66EzWvXv46xjYA3Uo?=
 =?us-ascii?Q?4gycZUDgbRoI8kOOSY3qG+vVumgluLerw/FUpai5mGpiSdIy4y0QBkq+6ma0?=
 =?us-ascii?Q?PS3KE6rSW30cXPUiKT7nY6EjwV/3Db/ojSm/UZVl9Jy5goV2qLYbXieQBohn?=
 =?us-ascii?Q?j1FUID3DWp076UYkHD0iBJb1zy9Y+Oweu+yKj+nFSYiLP1JDFBXUFqlqpdl2?=
 =?us-ascii?Q?4v/pw5R8apE5fRNxBwkiv9RZvMAGupLO5o18qkoF8CohqKODMGN3dl/O+uiM?=
 =?us-ascii?Q?v8zuZGRaBaIEkaO7WihYi9cZBYmj+kVbP9oV4OJmNHSFgNB/KfFujWAACeV9?=
 =?us-ascii?Q?/wKxmazGMuP3usLkWWEYADE7MAjhO9WjJn6RRXkrOcb2euawC2vryTjNP1/J?=
 =?us-ascii?Q?nI7LQb5U69nDKT0POye9Qz0DsNcdw+waom0P5DBjBD8FMBEWYjsHuhf5B+/V?=
 =?us-ascii?Q?yv/cFfLYmxc5WrlQXnmIKReUxkQPscDRu8YGMxcPnXqg1vD271vPNjP5Tk/I?=
 =?us-ascii?Q?Bos9vq7zfsBqAAngUJheQxVZHG/5E+3ERYhjgA70WYxSCh0qOyJuQ5KEs7hg?=
 =?us-ascii?Q?qZ69QCiU2HCjlDoegzggk+RN1L9YHGJkWQWACeJ0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf7378f-7507-4440-dc2a-08db02b2dacf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 11:12:20.3734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aglJFZmltWd9/spd+Fe4JkwXv4LcbzUvOFlcjJAOMYVI0+4wDtpUrwOyl5793f0Gv3/bFm2BbAp/6/debOlEsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Tue, Jan 24, 2023 at 04:42:35PM +1100, Alistair Popple wrote:
>> diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
>> index c301b3b..250276e 100644
>> --- a/drivers/infiniband/hw/usnic/usnic_uiom.c
>> +++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
>> @@ -89,8 +89,6 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
>>  	struct page **page_list;
>>  	struct scatterlist *sg;
>>  	struct usnic_uiom_chunk *chunk;
>> -	unsigned long locked;
>> -	unsigned long lock_limit;
>>  	unsigned long cur_base;
>>  	unsigned long npages;
>>  	int ret;
>> @@ -123,10 +121,8 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
>>  	uiomr->owning_mm = mm = current->mm;
>>  	mmap_read_lock(mm);
>>  
>> -	locked = atomic64_add_return(npages, &current->mm->pinned_vm);
>> -	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>> -
>> -	if ((locked > lock_limit) && !capable(CAP_IPC_LOCK)) {
>> +	vm_account_init_current(&uiomr->vm_account);
>> +	if (vm_account_pinned(&uiomr->vm_account, npages)) {
>>  		ret = -ENOMEM;
>>  		goto out;
>>  	}
>
> Is this error handling right? This driver tried to avoid the race by
> using atomic64_add_return() but it means that the out label undoes the add:
>
>
>> @@ -178,7 +174,8 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
>>  out:
>>  	if (ret < 0) {
>>  		usnic_uiom_put_pages(chunk_list, 0);
>> -		atomic64_sub(npages, &current->mm->pinned_vm);
>
> Here
>
>> +		vm_unaccount_pinned(&uiomr->vm_account, npages);
>> +		vm_account_release(&uiomr->vm_account);
>
> But with the new API we shouldn't call vm_unaccount_pinned() if
> vm_account_pinned() doesn't succeed?

Good point. Will add the following fix:

@@ -123,6 +123,7 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 
 	vm_account_init_current(&uiomr->vm_account);
 	if (vm_account_pinned(&uiomr->vm_account, npages)) {
+		npages = 0;
 		ret = -ENOMEM;
 		goto out;
 	}

>
> Jason

