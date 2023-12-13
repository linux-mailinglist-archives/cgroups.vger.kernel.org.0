Return-Path: <cgroups+bounces-932-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B7A8107E9
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 02:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B4B1C20AA4
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 01:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D27ECE;
	Wed, 13 Dec 2023 01:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CJ6kv5A4"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A106BBC;
	Tue, 12 Dec 2023 17:58:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ndh5Gl1WcMLjhvFN7DjuRYi98Ae1/hDtwsHeScBm+VRszK7Alf4EWqotuxzuDMTrfAS+oMsmCyvOf+GwGpug6E/i8TFFaIYpzvyoNYtQDAFG4Yqz5jQPCQGj/LmSwMDgjM67eu0/IUHnZwZcCaGCykO8mMGZJe4PR4oLbAMf0SQhzhuCf7kY4ExPwzn5eFI/5QzZEuHoLQ2Be2eJ/ML5ymN6kvp9uuJilxqNMJaiM+dYAmv8wPzNgDNP0LOKeDRJJyL52EBJdxpyow4TBzkSq/8L7cSXE83t1V84pOWl6zq8K0N625DxvzG7J8bP1kE4g+QZJ3YfoozvZa/6w3NamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnuD6vvpDO0TghFg1wH9FoZiAc95vN0a8uFinFOMLV4=;
 b=ArR5e5bjt10+o2adRuOfsRbD+HIR5geDRKLzGiwyyJQRN7PuKVuGVkLU1hcG9iuzoA95wAUNd6+77lkeQsxLFqZQw5D3DjJP1ctOJJQsEDlHOT0aVMhZU28cQyXl5/fgUSwwNZLTJgWApGOlAOEjEbkDM+RBInNYlVKJz3SWKLYAoaW2Vho57Uf/YyctV2kbI1mKYo/1yjiXsCiAYuTYRGFswjT7+ddXLuuJlz8VOkB5rJJ9oHzHZT5Svc9apl3nJh2Kl7lFXC4vcGfxyp4PKFDxQFCiXW5E+uq6SfBp/6oIWM0VMMj06otTB6B+hG7CVeAOXBdx+tYzPVL5Sz9DQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnuD6vvpDO0TghFg1wH9FoZiAc95vN0a8uFinFOMLV4=;
 b=CJ6kv5A4sQ8O3IbwTpb2azqxC1IVEqWJEh8Gv3aW3+trwKPfpYxZIePmI9yWiZA0wCUqMrDWv+6nmhSUML3fGoXO71IMAt8YbZKgBcxpyMuBChiD7h+id4L+wn23Djtq2bYwThW7fN/0m4mrS36N14Y5/KagER+A9cGiHTOj+z7JOVjCsK1driRcC99admKqn92luwdZsikyCykgEtpGoBeOapngR7bngtBRVXu2rvwxD/wzCojJRrhwe342dXUuaJpKkLyiPx4liLdl2MBEhc89zxuED8yiqxIJFfJBtrpKOMiuX1nmQOP9qothAp4kc8I3uYb16VeH0G4fI4iAtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by JH0PR06MB6655.apcprd06.prod.outlook.com (2603:1096:990:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 01:58:36 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 01:58:36 +0000
Message-ID: <86984d9b-c955-4b06-9097-2a757b1bacfe@vivo.com>
Date: Wed, 13 Dec 2023 09:58:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] mm: add defines for min/max swappiness
To: Dan Schatzberg <schatzberg.dan@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Jonathan Corbet <corbet@lwn.net>,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Li <chrisl@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
 <20231213013807.897742-2-schatzberg.dan@gmail.com>
From: Huan Yang <11133793@vivo.com>
In-Reply-To: <20231213013807.897742-2-schatzberg.dan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|JH0PR06MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b85bfb-1f23-41d0-7bd4-08dbfb7f0472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cMVyrlBw+570TONArruBa7DzP3dJyVCV7Z3r5vivnDhIWQJQS/DozFF+SQRr49qiZxNi0dfauv6db+uSxR168fZnNmFxGSJ9TzcpxMZ08MgoqtHI4kiNtxU9ZymOrWxNUY49YlMfO8NJqRLGn8mLUNBNXLzLQLZK+3H4r7+uqBFxMgyNBUlOjQvXi5Ue7LlEy+jkUFZT49uLrQrIJc4Jt05pk0dmIY8+RrRWNWsgotDsVl+TAJTnsl6Rjm+diVqZJGI1no6QL4ppSHPgvFFXnlvs5Go/J3q968QYe5F161d8eUtYXK/A5pY1a9O8m21Z0+QZ6kbS+ik28dsvoh1+Z9k8mcrjm2/H+hf+Sdra4nKBq2PPTTFqE+JXLIRpCtegjxquzS/oWRQqoApl7ezGjTfa35nE424UWBFAboBlKSSubmw+2MMx+mK1Bbw+18W47NCQQSSplmwTC3fYriE3cHxC7hZANYgJtsUHCt6RYtLkygsvBSKxoJ5m+k3LUp+qrTxlRj/dRMqsZ078WNFoONwX3SoRXnX2KhugMmpt27tyuj7dxHkTGgpXFOgrbT0ER3g36brvCvaZYoSJcF+uMFgV1kRlAK0EiRnu7W6cs0+iowij0wWsfthjx8OH3PcuXbSYcT92nRz1lTT+SkoyJtDgS4xSPgwQYPfdkY1lKbXEMEliOB9ewpLRjHEjN4OhqnVbhWrmZ4EAr5nnDoRmeGunNVdWW1gX6KTBOtwnQJF1ZmBYjSmQN24PYJ+KqR7t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2616005)(26005)(6512007)(6506007)(6666004)(52116002)(83380400001)(7416002)(4326008)(5660300002)(8936002)(8676002)(41300700001)(2906002)(478600001)(110136005)(966005)(6486002)(66556008)(66946007)(54906003)(316002)(6636002)(66476007)(38100700002)(31696002)(36756003)(38350700005)(31686004)(45980500001)(43740500002)(81742002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1hDR0svSHNBWnlTRXFxYk41eXgzR2hRSUV4WG01R043Q28ya0lQaFV0eDlT?=
 =?utf-8?B?UmVOWWk5QW5BU3FEK1o5cVJOWGJGcDJBcWVKcXJZQnJVOGRhekErVkdDc1RV?=
 =?utf-8?B?OHZGNzVhdHR1TmJsK3EzUSs5OFhLTHBtMllPK2tncVRVN1Z5bEptTDBscUxC?=
 =?utf-8?B?K1lvQkdEQ3Y0Y2N2OEFCWFhTM0I4NVFGMTJIOHgrR3VRN2RMVmE0dVZiTFVY?=
 =?utf-8?B?b1p4c3U4Ym45b1dCeW8venFvQTJuaXdLVDVEV0M1a2VxSi8yQVlhZVQ3aVYx?=
 =?utf-8?B?dG4vR05Ma1BsSFF6NjNZNkZCSExwYmE5T054NWdMSGRGcVJPMXN3Vkpldk9Q?=
 =?utf-8?B?Y0pCRzFIQlM3Z3htQTZSUlRKTmlhZGprUnF2bXVjTGM5Rk1yOUR2eW95aXlr?=
 =?utf-8?B?bWlqWXRaa2p2aDE4S0Y4T2hKOXdVMllMR1NDenJBOHhNNG51eEJ6eXFUNGVV?=
 =?utf-8?B?VVBEazhHY2dEV1h1SmdCT3lUSyt2Uy9RSDFsMm5BSFY4My9ENXRPS1lxS1A1?=
 =?utf-8?B?NXFiRzZrTDhseGNqc0RyNWpidjg2RndWWHI1ZnRic01nUW1JeDJ4RStnTUtM?=
 =?utf-8?B?T1hVbG4vMFZLYWxYQ0txWW5JRzF3Z3hhSm05RExTRlVBdWE2L0RHUFB1bkl5?=
 =?utf-8?B?eEVrZzVvTmRCK1hLVncrc0RnT05oZjM2TGREL2t4UG5Lc3NtMHo4MkNDSlhu?=
 =?utf-8?B?eFV5Y1RaVmlaRGU2a3E5N1RlWThTblRQRFVveWFpSkx0YzdaRmNmeFd1SDR6?=
 =?utf-8?B?SWhOTzBDZFNWR25IV3l1SFcwVzZqaTZ0Mk5HekJaalFCdkxoVXVNSVE4R2Fz?=
 =?utf-8?B?dlpyWDk5SThhcU13Qlh4ZW5JOXdEbnlXWk1hc2FBVjhJQm9lNlQvZXA4U1Q5?=
 =?utf-8?B?SERwNTRnc21Eb2tKczBaYjBhSXFwNkVFcmJNU29pZFRIUm11QzFROXFkbzA0?=
 =?utf-8?B?VUZ5M1ZOUGxaV1VtVEtaQ1huOFhMbEdBdzF0Z1pjVDdWWXF3NXFaRlNiOCtr?=
 =?utf-8?B?ZHlKaFdNYldwbFVCeEtqQlhSRWJtellmalhuRk5sWHlTaW1zbUo4cSt0Vjc4?=
 =?utf-8?B?c2MwNkpzZHNJZVk5dlRPNms0QWFFMFNHbCtBbWJ5dTBBeUxrYWRndDB1Y01J?=
 =?utf-8?B?S3JYaGlVeDZqbmVNaGpYSmFGQWliZGdTUmtPN0RraTBXc2gzdDV3VUsvUmE4?=
 =?utf-8?B?NHBpcHlWWElHd29CVEEvQTFRalpJR09RZ0ZNTjFxaUpvTml0bDA3eEVJWGJy?=
 =?utf-8?B?ejliUzh1WmhjZy9ZalBLb25NaXAxM2VpbG9yVmRJNC8zd0dPcGlpd0s5ZGxE?=
 =?utf-8?B?OUovRGRzVHlsU0NqMWpsOW12U2srNkdzZ3FlZ2dKRU9NUjdZbndCTGkzZm5X?=
 =?utf-8?B?TmEwRTQyOHNmRXJ6enZCandsSm96TzBJOGdSOXl0K1BuZ25GZ2sxV0QwbXVm?=
 =?utf-8?B?a2tBVFNGUmJGU3h4RkI1bUQ4L3pmNldFOXloZGRTZmxWZmZuZFZScll1RGU0?=
 =?utf-8?B?YVU0THZmUFBoSHU4UTVWanpnblhzbUs2bjNteHZPUHRoSGQ1U09DeUtDZ2Ju?=
 =?utf-8?B?N0Q2RGRmN3hGYWEzbm1iM09oUW5EUEJodjRiTGlEd09DdVl5YmlSdEJ6UVdX?=
 =?utf-8?B?bm9yTHBKMm9yaks0UGcrR09FazNVekNHNWdRcmdSNThqNTRtUkZxQ0RBcFFl?=
 =?utf-8?B?S3dhSldFdUE3MjlJcGZVT3hhZnhJU2JLWWkxeExaY1YzbmJtbDk3NW9qZHE1?=
 =?utf-8?B?akFrS2JhcFBPT0RYZTNWaEJzdHNPNFNaSXljVEJWWll6NjVyaG9Jemd0SnZn?=
 =?utf-8?B?dEhCbGFmZmVoaDNRZFBxK29iend2UFBPd212WTBIb3hESzdNVk9Cd1dWTEtY?=
 =?utf-8?B?L1pNRGhZOXVTS0QxbTVjNjBBaWJWRkZtdXJhU0Q1aWRkbUVaQXd0V2cvai9X?=
 =?utf-8?B?VGZ6Vy9tQjFabmN5RTM2enhaQmk3QmxrMGYyalRRa1BZeHlLWTF2TktvNisz?=
 =?utf-8?B?SFp3NWErQXVzRXBTSUZZYmE2ZWc4RDhJbmlVSGlmYlh5aE1ySmlDQlpvY1d4?=
 =?utf-8?B?VlJvTktHRG5adVFqNnFiYWxnYjEvQk1LYVZsL3FoL09VMHJMNlJ6bk1RbEEz?=
 =?utf-8?Q?bbS02joSerUIp6lP9UQ6Jwq9B?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b85bfb-1f23-41d0-7bd4-08dbfb7f0472
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 01:58:36.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5gZHgk7FUxWBvOcMHKIWwplh59J7T4zZy5/jvoP+BP+ajLIPqZuIPQfo5cFmkhCzsTK92xH8TdQxjUt774woQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6655


在 2023/12/13 9:38, Dan Schatzberg 写道:
> [????????? schatzberg.dan@gmail.com ????????? https://aka.ms/LearnAboutSenderIdentification,????????????]
>
> We use the constants 0 and 200 in a few places in the mm code when
> referring to the min and max swappiness. This patch adds MIN_SWAPPINESS
> and MAX_SWAPPINESS #defines to improve clarity. There are no functional
> changes.
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> ---
>   include/linux/swap.h |  2 ++
>   mm/memcontrol.c      |  2 +-
>   mm/vmscan.c          | 10 +++++-----
>   3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index f6dd6575b905..e2ab76c25b4a 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -407,6 +407,8 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>
>   #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
>   #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
> +#define MIN_SWAPPINESS 0
> +#define MAX_SWAPPINESS 200

Do MAX_SWAPPINESS apply for all swapppiness? If so, maybe better change 
swappiness sysctl define:
```
sysctl.c:

{
         .procname    = "swappiness",
         .data        = &vm_swappiness,
         .maxlen        = sizeof(vm_swappiness),
         .mode        = 0644,
         .proc_handler    = proc_dointvec_minmax,
         .extra1        = SYSCTL_ZERO,
         .extra2        = SYSCTL_TWO_HUNDRED,
     },

```

Here hard code swappiness in [0, 200], and now add a new define.

And many other code hard reference 200 into max value of swappiness, like:

```
memcontrol.c:
static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
                        struct cftype *cft, u64 val)
{
     struct mem_cgroup *memcg = mem_cgroup_from_css(css);

     if (val > 200)
         return -EINVAL;

     if (!mem_cgroup_is_root(memcg))
         memcg->swappiness = val;
     else
         vm_swappiness = val;

     return 0;
}
vmscan.c:

/*
  * From 0 .. 200.  Higher means more swappy.
  */
int vm_swappiness = 60;

```


>   extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>                                                    unsigned long nr_pages,
>                                                    gfp_t gfp_mask,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1c1061df9cd1..9748a6b88bb8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4337,7 +4337,7 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
>   {
>          struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>
> -       if (val > 200)
> +       if (val > MAX_SWAPPINESS)
>                  return -EINVAL;
>
>          if (!mem_cgroup_is_root(memcg))
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 506f8220c5fe..2aa671fe938b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2403,7 +2403,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>          ap = swappiness * (total_cost + 1);
>          ap /= anon_cost + 1;
>
> -       fp = (200 - swappiness) * (total_cost + 1);
> +       fp = (MAX_SWAPPINESS - swappiness) * (total_cost + 1);
>          fp /= file_cost + 1;
>
>          fraction[0] = ap;
> @@ -4400,7 +4400,7 @@ static int get_type_to_scan(struct lruvec *lruvec, int swappiness, int *tier_idx
>   {
>          int type, tier;
>          struct ctrl_pos sp, pv;
> -       int gain[ANON_AND_FILE] = { swappiness, 200 - swappiness };
> +       int gain[ANON_AND_FILE] = { swappiness, MAX_SWAPPINESS - swappiness };
>
>          /*
>           * Compare the first tier of anon with that of file to determine which
> @@ -4444,7 +4444,7 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
>                  type = LRU_GEN_ANON;
>          else if (swappiness == 1)
>                  type = LRU_GEN_FILE;
> -       else if (swappiness == 200)
> +       else if (swappiness == MAX_SWAPPINESS)
>                  type = LRU_GEN_ANON;
>          else
>                  type = get_type_to_scan(lruvec, swappiness, &tier);
> @@ -5368,9 +5368,9 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
>
>          lruvec = get_lruvec(memcg, nid);
>
> -       if (swappiness < 0)
> +       if (swappiness < MIN_SWAPPINESS)
>                  swappiness = get_swappiness(lruvec, sc);
> -       else if (swappiness > 200)
> +       else if (swappiness > MAX_SWAPPINESS)
>                  goto done;
>
>          switch (cmd) {
> --
> 2.34.1
>

