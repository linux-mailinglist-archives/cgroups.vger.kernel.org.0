Return-Path: <cgroups+bounces-1045-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FAD81F23C
	for <lists+cgroups@lfdr.de>; Wed, 27 Dec 2023 22:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29021F22F3D
	for <lists+cgroups@lfdr.de>; Wed, 27 Dec 2023 21:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3640244C9D;
	Wed, 27 Dec 2023 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kYaaoK5z"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5522089;
	Wed, 27 Dec 2023 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y96asQPbaJt03KysqJKfEypiXYtPiAsmotprvY6IwhjZi5enSaIGPVg8Kf2QOXsv/ZPuqH8Xr2PV8ypWb1k32XupVzRREE+1y2XavEkbFrGBxvpzJi/jwOxXNqhmlmmZrW7HYHmO4E5ZXRf0E9xGA7fkv3ADS+6en82bG3fe2a555aw0nfSJR/ChOQ/YjEWGbeDAVeqwlH53uTQ8hCASWc8a8ISIZY8+gICK/+klIbd0eQgBBhdd5OK4HM1LKOu3qZMejVugWSukjjuUSQGveAzwYNJ1Tv55SdY5R48/3DVCGRiXEZwftyqvLcZdOT5CpF3ObsE2/SzmhnRNr9Q5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b17kFreCAYkgE/hZsC+XqA0Qwn9wp5W9cNYLPyPqp4U=;
 b=gMuKmjvSyy+z6EhIsmu95p0KyXayhL4MBqWKGF4N3iLIXPMMG/5MqfQsJjCLOLkD0/S+xN8wakQhMUY5q7Reya1Lu4p1ADzAMSI5BxVLme77Nk5ceUYVxLoGXV/uavNMVg2az4D+4Z5LmN7pOL76t/YzY68K3OzedgUYglvVecImKBjAX0quvEIwNqjYCtyrGDS0Ptr76D2/Mp/NHXn1YjmNLyX4kgqHdBB14GawwJtGbsnZiEhSymRySCges7Joey9/+N3Yu2H5lumjKuDjtgb7D8xuO4kVoM3MPa+dtf+YwbDNegyDNbohr7goC06blBvouruZxvD0giZmRz4MUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b17kFreCAYkgE/hZsC+XqA0Qwn9wp5W9cNYLPyPqp4U=;
 b=kYaaoK5zAaKTjrXS9Ga1skd0fZGY9sIo6toMJ25Ct9rQavwWdjxmgDoeRKEAlrvsSzO0g5uldXjXoyIZhifIaX5sXKcteP2VW43t1Lbg7/GIBPNVNM5aGBP2oy5j3HoNBnpimicUDjFAGFtOAfU+NUtR7KxOefW3up4pkxAuUuYg1lhZ0D8rUMCYwbctsmvAXSwXoTRk5ZsX2MMtYE6i/4flh4Rjb/Iqp+kN7/nBDIYWzkNyoBzBQQRuLppZ78E4X1xe8YQfJyPB3KwHb1wff3LYLaNSvXTBuc/8IxTHOQGn6qUjkgvD37ew01/WD0e2ELRVUQiy58vhA/j2iMocpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 21:41:56 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99b6:1e06:1e8b:4324]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99b6:1e06:1e8b:4324%5]) with mapi id 15.20.7113.029; Wed, 27 Dec 2023
 21:41:55 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeelb@google.com, muchun.song@linux.dev,
 nphamcs@gmail.com, david@redhat.com, ying.huang@intel.com,
 shy828301@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: fix split queue list crash when large folio
 migration
Date: Wed, 27 Dec 2023 16:41:53 -0500
X-Mailer: MailMate (1.14r5994)
Message-ID: <B88A05D7-718B-4E6B-80E7-349EF5CDD4BA@nvidia.com>
In-Reply-To: <61273e5e9b490682388377c20f52d19de4a80460.1703054559.git.baolin.wang@linux.alibaba.com>
References: <61273e5e9b490682388377c20f52d19de4a80460.1703054559.git.baolin.wang@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_62C3866B-2F20-4963-92C2-299FA8E90C08_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0012.prod.exchangelabs.com (2603:10b6:208:10c::25)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: e4717c72-cc8f-4ebf-fb51-08dc0724a572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zPFBjRHiJYfU2k5fl+LtX1slAHrxUS216Z4do+AvVIxZTFtquDmloGS7SHOw01LU92lMVNB2ERAMcJ51iCeHOpgYHlREscs05DxgbfouBFs7bxb+CwbgQ6NQha9QhCC85bo8w/Ti7bTQvwazdrmCnRmQ4SUc1jWA70JH5P7hrbvO5z8hjpbLIUTzhqhJWn+ET3IPElS6IgWwphPe/pLFvLzJV1pRyw2AlbTe5KR3CpwUZBMI0YcJEBmEdlVAfXBtH1qDunO24z9I1baskamvjXnedXJG3d20sAq0mSlxn81qooDY1zVSbniCraBHx9X7CIe5ywLFhimFS/JuaxGLb9sjBIAVwtATyqybRcslJppc81y8S48wWMWgR96D82wzmttYpGPDu6smpXZ8ilJOq4BLsVtEQ9Kn0j+BYDKhRMikc65L0ZZgnlwudVSTox/Js46exJvycLovLae4DQJv0TJ483msF6EEoDT5MbsWf0F+wWiYJ1cCmbR3N0hQPN3LrJ14uMBx4GGrY86xCpf/HtZEAUa71kwszv+TTS18uZO3U+fBJSgdRRJqyE/0d7ifuwPz5yiwbN0wfksztDIhUJ2QdwrmK4tEUtFqu/5+xBPSyIFqAUdgPefIim65jiu4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(6916009)(66946007)(66556008)(316002)(66476007)(8936002)(4326008)(8676002)(6512007)(6506007)(2616005)(26005)(478600001)(6486002)(41300700001)(38100700002)(5660300002)(7416002)(2906002)(235185007)(33656002)(53546011)(86362001)(36756003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T2RuhNPDyc9HBaLHdHA+bnSaYQxAvel6i6n7uoPKKvqm1mNhzuRVww/Nyi9e?=
 =?us-ascii?Q?xZBw3PjTbwIzk9ck8UNSRU5mMBfK6OEYT4TS2Nx+FhpCRTuwDxPjy1ASRKFH?=
 =?us-ascii?Q?LOQpbzouRuyTnmyMVgdKqrzto8d/a/4atk8m6jERa+jZQJGuxtqsGwRuX1f+?=
 =?us-ascii?Q?uMvhRiA9ZHd7CV7nJXzPy5BBFWjLnCs+tGiqqabOOziAq2FfuMULYQi3E6ld?=
 =?us-ascii?Q?uNGStUVP/fZic6p2GwFtj49i+dLb+4lDtJtuDB4pmjivuFUJ4B0ecRUkCj9T?=
 =?us-ascii?Q?WoPirmXtQUhDQ9okuCk4UsgLfRj3FVgvUl3fr/l/PSeaehKpY/W3VMZbS+I1?=
 =?us-ascii?Q?H8KvwdshSecOH36kqDHh+lHQp43ATX2otoOu5teVr+EScI4fouOyP9FKTCiX?=
 =?us-ascii?Q?OJfz5hL5jwXWn7Ke9+efXi76CUUpkYUGTjN+/ZUr8vuXHuR7mB3vk3B8N3xh?=
 =?us-ascii?Q?8l7yRDFvOCFAXukwEuQD2tEnVkyrmLAFrsA9ENlkjk5ngR9OZ18Yp+R5+urM?=
 =?us-ascii?Q?wtebhLVxqaut57KcwbIFyMyKpPhNi3BA2NzJPDBBsX1RqiELfd1t8Bp1+Fxj?=
 =?us-ascii?Q?4iTP7FnfZMEa3Vt8fB5HjlMKlDopy7d/Qqcdq74s45vW0G3IcGny6gsCsk+/?=
 =?us-ascii?Q?Dodjje1h7fgsvgh/DhH6JoHPpr5YT67NYvOT6Xy5hZu+0WxaIywgSyNl3Ip1?=
 =?us-ascii?Q?97+xIMOYleQejlfI9mpuloDt2lMudFsdttmbj8iuHO33d9XP3ao0Aqw6mOv3?=
 =?us-ascii?Q?j4bQjXc+ygG0TO2KnC+Qhk3psGyTDyDXug9jZF8d08L1f4JpWOKZmKiQ0z0h?=
 =?us-ascii?Q?k+kUSDk1KSQol+CWPJ1g5Uw/DoTBi69XA1ipk1i5llGg1vAxL97wy4ATH8ED?=
 =?us-ascii?Q?QR99l9nph9HXb1lQCkHBLBl38vdvwbNNSCmoAqhfMiHXt6Sw1Qc7qMPvTUIw?=
 =?us-ascii?Q?xtNDmdg7i5OnrIneR9abDsjABmbcJdC5slqe8HoKrdl8cN6BeeH8HW4Vy+CR?=
 =?us-ascii?Q?ENnzg1aDtN0nVZHUFJpls74JmFZF8NoakW6w82QXo1XratWalP6RWkI8US16?=
 =?us-ascii?Q?Mxcgx62bHjkKWOOvuR1H/3elpJYWl5r8uoIt1xiO6ZHrwRd0URXkuQUm8RIT?=
 =?us-ascii?Q?2Jc5/8affWr0w+M2TGqrtJzPIGxlAcenrBfGVOhcBeuus1Oxk5SujbBudFHB?=
 =?us-ascii?Q?LtArFWfrAv6+Nu2QHgE4ZNO7HslyiKShFK9T/jQ5/Z8IOuM+CSP9eK7PHntt?=
 =?us-ascii?Q?4DFgzp1Bhtu4OqKHWTjsnf0OFrXEUMYVdtKgW5/n3J4uschdhTk+fOMOlkJY?=
 =?us-ascii?Q?Ycc7+jZ3Vfkze+bycsRJU5wcCCC3CcwhQgnfs9oyjmfg5b/Rqd3EXguOP4zU?=
 =?us-ascii?Q?qvSNqTkyp30kj7AKVrfdcwuNnFjAhplQH5Pn86Z0Ti9ODx5JkMvhphWPGX7P?=
 =?us-ascii?Q?9yfWMF7s/wSW3RS482ATpYZuGmRUsHKuuamAMlAF0kyltY7KJiV/0A8yszRO?=
 =?us-ascii?Q?vc/0xE70wS+S6G+9R9AnIYYKPyxV4aQe5XPvhTUPfzJ3q5SZ2BO/4m8+2NQ3?=
 =?us-ascii?Q?/uIhg+w5qrwEhzpQP6o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4717c72-cc8f-4ebf-fb51-08dc0724a572
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 21:41:55.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jegkfNHVN8o6rWgaqcXqNhxVPmNOEasIR6U2Ic3/oQYTUkc9Cx1Jf0Fk2ou7Q4LR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808

--=_MailMate_62C3866B-2F20-4963-92C2-299FA8E90C08_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 20 Dec 2023, at 1:51, Baolin Wang wrote:

> When running autonuma with enabling multi-size THP, I encountered the f=
ollowing
> kernel crash issue:
>
> [  134.290216] list_del corruption. prev->next should be fffff9ad42e1c4=
90,
> but was dead000000000100. (prev=3Dfffff9ad42399890)
> [  134.290877] kernel BUG at lib/list_debug.c:62!
> [  134.291052] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [  134.291210] CPU: 56 PID: 8037 Comm: numa01 Kdump: loaded Tainted:
> G            E      6.7.0-rc4+ #20
> [  134.291649] RIP: 0010:__list_del_entry_valid_or_report+0x97/0xb0
> ......
> [  134.294252] Call Trace:
> [  134.294362]  <TASK>
> [  134.294440]  ? die+0x33/0x90
> [  134.294561]  ? do_trap+0xe0/0x110
> ......
> [  134.295681]  ? __list_del_entry_valid_or_report+0x97/0xb0
> [  134.295842]  folio_undo_large_rmappable+0x99/0x100
> [  134.296003]  destroy_large_folio+0x68/0x70
> [  134.296172]  migrate_folio_move+0x12e/0x260
> [  134.296264]  ? __pfx_remove_migration_pte+0x10/0x10
> [  134.296389]  migrate_pages_batch+0x495/0x6b0
> [  134.296523]  migrate_pages+0x1d0/0x500
> [  134.296646]  ? __pfx_alloc_misplaced_dst_folio+0x10/0x10
> [  134.296799]  migrate_misplaced_folio+0x12d/0x2b0
> [  134.296953]  do_numa_page+0x1f4/0x570
> [  134.297121]  __handle_mm_fault+0x2b0/0x6c0
> [  134.297254]  handle_mm_fault+0x107/0x270
> [  134.300897]  do_user_addr_fault+0x167/0x680
> [  134.304561]  exc_page_fault+0x65/0x140
> [  134.307919]  asm_exc_page_fault+0x22/0x30
>
> The reason for the crash is that, the commit 85ce2c517ade ("memcontrol:=
 only
> transfer the memcg data for migration") removed the charging and unchar=
ging
> operations of the migration folios and cleared the memcg data of the ol=
d folio.
>
> During the subsequent release process of the old large folio in destroy=
_large_folio(),
> if the large folio needs to be removed from the split queue, an incorre=
ct split
> queue can be obtained (which is pgdat->deferred_split_queue) because th=
e old
> folio's memcg is NULL now. This can lead to list operations being perfo=
rmed
> under the wrong split queue lock protection, resulting in a list crash =
as above.
>
> After the migration, the old folio is going to be freed, so we can remo=
ve it
> from the split queue in mem_cgroup_migrate() a bit earlier before clear=
ing the
> memcg data to avoid getting incorrect split queue.
>
> Fixes: 85ce2c517ade ("memcontrol: only transfer the memcg data for migr=
ation")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/huge_memory.c |  2 +-
>  mm/memcontrol.c  | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 6be1a380a298..c50dc2e1483f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3124,7 +3124,7 @@ void folio_undo_large_rmappable(struct folio *fol=
io)
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	if (!list_empty(&folio->_deferred_list)) {
>  		ds_queue->split_queue_len--;
> -		list_del(&folio->_deferred_list);
> +		list_del_init(&folio->_deferred_list);
>  	}
>  	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ae8c62c7aa53..e66e0811cccc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7575,6 +7575,17 @@ void mem_cgroup_migrate(struct folio *old, struc=
t folio *new)
>
>  	/* Transfer the charge and the css ref */
>  	commit_charge(new, memcg);
> +	/*
> +	 * If the old folio a large folio and is in the split queue, it needs=


should be:
If the old folio is a large folio and in the split queue


> +	 * to be removed from the split queue now, in case getting an incorre=
ct
> +	 * split queue in destroy_large_folio() after the memcg of the old fo=
lio
> +	 * is cleared.
> +	 *
> +	 * In addition, the old folio is about to be freed after migration, s=
o
> +	 * removing from the split queue a bit earlier seems reasonable.
               ^
               it
> +	 */
> +	if (folio_test_large(old) && folio_test_large_rmappable(old))
> +		folio_undo_large_rmappable(old);
>  	old->memcg_data =3D 0;
>  }
>
> -- =

> 2.39.3

Otherwise, LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_62C3866B-2F20-4963-92C2-299FA8E90C08_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmWMmiEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUhuUP/2qt+2EBDEnsbqe3Z+8Gu+zMUM0OqBSImR45
2qPsUoIxVbdzGzjpwzf5IIGsYR9qpw3zdbDlcmzQrYgaweBEdouuq8M0qmJLLKo4
TvGllkn8CdC97cY9WUcwJzjfZhTA+ckMYjOvzlfSYoy14kOb8X4RZzlH3cOQlKGY
cqDNT6XE29tqfnselohiEasfeQIJtPb0HLg1SkqVfgIVRY+DdFT0Du7v0ahyRuCp
7MCvwTtY0P+rQJaKTT+/mFnidxW9hnbow0itAI3OYWYBUOQEqLtMQ7mIDZywyO8z
HPsiWMH7aSdYi094TPxSUh1jm3w2iQCd8qeN7Km6K1hOitHm0dAFlZR+hoIu4/Y1
CmUWhTu6VgFBdbixcIu0AKQKNUQzdR+Kq+CdY56JiIht0tzqbhANGiwtQ/Q6Dwb9
1v/crbT5Avth8Ly3D3BXvJQJUkBuFBn0QaGU/wfspm5IbqtA3jbYF3cIwMddgblI
HfQ9deQiItH8nJNr0ClCGLaXmjEBddJjPDePza3+25fbU4QIVTwblEilxqZtHX7x
bXmkKlPe9n0OPmXOGEe4F/ZQbKQRZMgaeAYozZsH+JwKuGM8qkNKQSYbWfP62zYQ
2woz5cxd17syHfYhlevErbSpr+I6d2z0OAgBfmBDGlkg4PsCfwj5Sofnn08OWRmR
GNSU5prL
=vDrS
-----END PGP SIGNATURE-----

--=_MailMate_62C3866B-2F20-4963-92C2-299FA8E90C08_=--

