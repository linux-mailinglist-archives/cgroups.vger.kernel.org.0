Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014D479E50A
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 12:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjIMKf1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 06:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbjIMKf0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 06:35:26 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2120.outbound.protection.outlook.com [40.107.241.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881CAD3;
        Wed, 13 Sep 2023 03:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrXv8dgSIfG8atc7eQAOe5NxYgAMyHeysj76Kf60dW5pJXPTqB+foqOapQihAhn0C7xuaF1APNnKhoJ3kp4SMWYYUDrFs/p2z1NTtygMNiowcgtXCeNtdZ9gnT31LU3gdPJZkQnJaBr2XW1NbyS3ms2d3J+Fjy/MeU0zzGScrLJhpKSg7wUUX/b4B6FXwFCcjAtzfbtpjeGiBdWbHyeEMFL5Eq17ZMAsW9MBzrULN8T6dVSPXUkgeCWl5nhrDuirS3mOugzc6S18QEaPAOcJGgpBhlhYRoRl2gl6RuWFyRJ0D5NPrW7ufnYjNPT+s5YS1V0uyecdSHTW/BZKnoYUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/tUvI0rO/fZsEmr+L76aouRqGSfQ9Vy9Ur+y7I0tJI=;
 b=VYBzR3OVyDyzEOEi6UE2lrwrYFqy/7cPSkamQ1/FcTebc01lwkEsHvhec7Dr+j1Rb4vckIwZpkoihEjHfuUo6VzahE/yRz3pqLuFK7wqc+HSqIV8S/WAqrx3q6dQZQcrEpiDmYPevh9A2l7mfaAVAs33zXoPQAx4+cyqywxodNfpsb0LmrRKcud2vH97XozEove/nIoiBjd+ai+B/mJSKLnafxFRQqK5FrsjYgpywAPBRvZzoyZMe3sow3PDARmmRfQHkiAROeJ1akSfYRUmF5/Hoguo98zEzdOFRbgRkLxkiq8Iz86R04YTnHw6DK3vFIHTFLHGz4m5S5kBpKHM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/tUvI0rO/fZsEmr+L76aouRqGSfQ9Vy9Ur+y7I0tJI=;
 b=HBFjKf+lqbgZahi4GtYOmIJAhbgsmlroTn/BhlyfoKVYpahgfUrvnoxCpHzHY/6clGw1BibC0lKl3/OLNc3kj4xgC7wrhp5bnNYSXiZLv1aspGL2zKfurX9NDlImM0mJXa+tH3T+wlQK6VkEuJ49+Q/tplyGwiv6mbIbnfSL9cJDBxfEBI8WTE0P3Z+DiKeSu9Duc9Rk9Ui8HQTZ4D/E7keeGmZsfp81YOYP3nXSCdk3eitLzcSRWWBlPIc9uojNCy5XrrGcUTLgGyyCquakjOrS8ZUp8xewAS81nTFQKoueiclOkhnbhaqZ2ySdxSuVn95etkJTx0gRAJK6vzMQ+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3a4::9) by
 DB9P190MB1771.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:33f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.34; Wed, 13 Sep 2023 10:35:19 +0000
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::1dc2:35fa:896c:8ca3]) by DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::1dc2:35fa:896c:8ca3%5]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 10:35:19 +0000
Message-ID: <870aa2af-62b7-48ba-b1a0-77b651352211@nebius.com>
Date:   Wed, 13 Sep 2023 12:35:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] cgroup: list all subsystem states in debugfs
 files
Content-Language: ru
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        NB-Core Team <NB-CoreTeam@nebius.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andrey Ryabinin <arbn@yandex-team.com>
References: <20230911075437.74027-1-zeil@nebius.com>
 <20230911075437.74027-2-zeil@nebius.com>
 <CAJD7tkYM0JBukPMWCWtx-nrzGgPw4Y6m1p2_Ynb9fzSgsS0igg@mail.gmail.com>
From:   Dmitry Yakunin <zeil@nebius.com>
In-Reply-To: <CAJD7tkYM0JBukPMWCWtx-nrzGgPw4Y6m1p2_Ynb9fzSgsS0igg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:3a4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0P190MB1860:EE_|DB9P190MB1771:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a16aad-4184-4f4d-22b2-08dbb4451faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLXH4zsvyHerIu+SZS1aRJY8KmVpHnDzV8Y5J7WdCi7rSURfDiulEFUIv2a0MSyt8W15L4zjWiP0kDn9Q4Wl7VFE4TozVjaeE2dGUvqVOLIKx9r/JZWOBaIFapDEkSoro1WDqrnHMIqLXIzu8f3fDFJ0rLxrq6rUO6q4wGc2bvPhE+lmko5QtZ7tnuMybV1apCuUF5tuWSZ0vdqjhG6v2nSAPp5a2BMGFE9UOeFsij3N3ItD3o3DoYfvSR8JSMXGD0X3tx07PCJorpr7Bl/q+UVn8W6Uk7Y9iKdClM0GgQE3v8TQZsTd74oTfQyTKvKWPn48QVSuw2RO8GMwXuC+nA3ykni7w7girxSZGI0z9EPtWa8oyID6yhiZRy2tw7RnkrAbcM8Tw+7/6QTusrRifBS75Is+wTagaXnWUZ3IzxoWUkRUhpPuKNysasVd0/A+1OVMXYRXInVHLHV7IJtWphjhUhRDfnqOTGTrxmMg2I4utFLtuP2Q2NWLUePhV0GWc/tc7kNN4/pqxH3zo0Pa8AWEGz8gF7J7/fiQ8jwMxx8t5GjwP8suxxbNxqgrnt5bPzzApQWfRXiosUZLCTxS+xB/7gwTxRDEnEUNzBnAxH0vA1zlS4cPtyAHufZCDKYl7Zv/W499Xh40XkhCt8HgNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P190MB1860.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39850400004)(1800799009)(186009)(451199024)(41300700001)(83380400001)(53546011)(6486002)(6506007)(478600001)(6512007)(2616005)(966005)(2906002)(66946007)(66556008)(6916009)(26005)(54906003)(4326008)(8936002)(66476007)(8676002)(6666004)(36756003)(31696002)(38100700002)(86362001)(316002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDFDMkZEYVZwME1FL24zQ3R4azk0NkxVYy9weDM2Y1ArWVlnS0JyWENsU1Qr?=
 =?utf-8?B?SHlaN2JTdXcyZnhMNVQwWGJBckt1SmhuZTR0NTBhUzgwZlNETzJFTzczUldE?=
 =?utf-8?B?ZnhHY0gxeDVLRmRIeTVmZlRQVkNxSmx1Q214dnRFSWkvbnpiUE5sbnZkQmI0?=
 =?utf-8?B?NG5SbCtKa1MwMC9rUFpQalBxKzFILzgwd20yVDI2N210aWFUL1RhVkdCTmN0?=
 =?utf-8?B?YUgvMnVXS0xGSlhWd0o1L3MyZnE3TDlMM2NYcCt3V2RDT1RZRGVqUFpoUHhY?=
 =?utf-8?B?NXczQUZ3T2tuRVArcnpKWTQ4dHlmNWR5ZzQ0bnpEbVYvd01lL2dDeldMNXI1?=
 =?utf-8?B?VFdNT1ZzMjc0azlQeDlUV1hoTDJOTXZYTzQxREZQdVh3bS9yWjFpOElXRG9o?=
 =?utf-8?B?RzJHbkM0cy9TNlg1cW9IZFN3K2dNYzl2SVpuSXRiTTh4WFdCay80ZHkwcVo3?=
 =?utf-8?B?akkyYnAwblQxU1UyaDFqcUcrV3plMjRRNTBvMHpSZS82alZnVm9ueGNZcnJ1?=
 =?utf-8?B?V09JR1NWVkRGbENmTVNsaWVFekRVamNqeE56ajdPQ2FaT2xqSllqVTlhNkQx?=
 =?utf-8?B?aFZUejFCbjFMNW9Pamdwd0NldytPcTZEQURLbzB2a0J0VEE1QU9DakpWVjFk?=
 =?utf-8?B?UklDUEJWVnViWmVHRkdxVUpoK05rQUVCT29wa1pYVVA5YjdiTFpkRGhUY0d1?=
 =?utf-8?B?RjN6aW5BK3FDczA3em9OaGExOTliSURkTm8rL1BsUFF6SnE4emJ3TEcxWG9R?=
 =?utf-8?B?NXNZRzNSQWJKSTd1bGxpWFE0V0MySHYvNGZsMzNCWkQ4YnlHbFcyWjBET1po?=
 =?utf-8?B?aTlNY3BDbC9RQWJ1Qk1VcC9HQXFDdjdzK2pTVDh3ZTdPN2MvbTR4aWlsMTF3?=
 =?utf-8?B?aTJWT3A4OWMyazRlVGVUSXZaM21xQUdESmxjU0ZsSHdxb3JmUVU2ekprd2NT?=
 =?utf-8?B?RXRXRXF0MTFQemNwd0tzTjZPbFA0SGNyNFNWS01VWnFJMmdyNHlaZGU2UXJ3?=
 =?utf-8?B?UlljT2tEckpGQitYeFNTb0JNN24rVVZqVzZjM2xZVUVieEtGS1ZYcHRWYWc1?=
 =?utf-8?B?RlRvODBGeXlKNG1rRkpnQUp6NWpmOU8rbWFnM3VKeXNQc3ZOTE4vbk1DSkgy?=
 =?utf-8?B?d2lidzFLMFBsZ0pGaEVmc1lzMGJWNGFObG5DWTJlZU81a1N0ckZvdUNubTh2?=
 =?utf-8?B?UUpzTkRZOEhHc0RJak14WWRZa0EwU3k1Y0t5cUJZaWhrMWRYSGExcXBDVHZR?=
 =?utf-8?B?YzB5NDRMUnJ2U3dTMGU4UnRuejVXMnNvR1pYeHNjd3hJRVhIWm1GZ1ZOUHFU?=
 =?utf-8?B?QlV5bGpFcGdrWGhvZEttKzFnSDJtR2ZZV3ZLZWt2OFMwanZQWm1jVmdvR0tS?=
 =?utf-8?B?dHUzUW9xS1NlKzRrdGlFblZtOGJxSzFIWVNxZ2tHdW1iTWN6ZE9HSlRIR1U5?=
 =?utf-8?B?L3pRTEdxNTA3dkhpeTFwZDBDR3pKSWhuZWRpL1F6SnVENnJSeGUzc3ZGS0dv?=
 =?utf-8?B?c2k0L0wzR2lqMU1pWXlsQ2MzNDcydVM3alJiNG1pbDQ3Qm4xb3ZJdGtGYTNI?=
 =?utf-8?B?RHNPUUNDbWdNODN0dThBK0dUekFOcHhUaGt6NG40K250QlQ2T3ZmTUZLV0hJ?=
 =?utf-8?B?VEZtamhvcDdtTUdjQWoyejFzSTNGTk5TMjMvOXFVL01ZM2JLaWlUVWVMcnJr?=
 =?utf-8?B?UjJzZUpya09oNjVIUk1DZ0hpK1NLUVc4WXdJWG81YVRIakEzcEgyZFNGYUp2?=
 =?utf-8?B?bmFXV05WNStvZHdxVk5FZjVhL3oxMzl6UWE5aGFJa1FSWU8yMXRVdlJMd3Vt?=
 =?utf-8?B?YTYzdmdubTkrYnIwR0E2YytvYWFZdmhOYzlyZDhMd3N5a0lZdlhaV2tWc1FV?=
 =?utf-8?B?SzlLQ25laStoNzF6UzVzWHNOQ01qMXNGT01uVWRIcW14ekN5K0RTMW5HZ2wz?=
 =?utf-8?B?Q2VDQkJFWnlnNUlHVEZTaCttVVVRMDI5OHc4QTd6d2lwZzJqVktUblNCTkUy?=
 =?utf-8?B?c1ZQajhsMkVVVW9aaWR1Vzk3dDRHdDRPTmZVNG1CWS9CVlEvYmVCUVlDVFp2?=
 =?utf-8?B?R3FQMEdhWWppd2ZaSzJQTlRTNUNTQkowRjJTUU9JS1AxbmhLSFpPZ1UxTjRh?=
 =?utf-8?Q?4XseSAjUbGIORDvqewBoE1a6w?=
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a16aad-4184-4f4d-22b2-08dbb4451faa
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 10:35:18.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNj0YvdN73fdODAO9WdEMKnRHzDnkmxmXxZ4cbpKl3a6X5tjJHbRjYTUO+fEkmbI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1771
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Sure, if you can share you work it would be nice. Thank you.

On 12.09.2023 00:16, Yosry Ahmed wrote:
> On Mon, Sep 11, 2023 at 12:55 AM Yakunin, Dmitry (Nebius)
> <zeil@nebius.com> wrote:
>> After removing cgroup subsystem state could leak or live in background
>> forever because it is pinned by some reference. For example memory cgroup
>> could be pinned by pages in cache or tmpfs.
>>
>> This patch adds common debugfs interface for listing basic state for each
>> controller. Controller could define callback for dumping own attributes.
>>
>> In file /sys/kernel/debug/cgroup/<controller> each line shows state in
>> format: <common_attr>=<value>... [-- <controller_attr>=<value>... ]
>>
>> Common attributes:
>>
>> css - css pointer
>> cgroup - cgroup pointer
>> id - css id
>> ino - cgroup inode
>> flags - css flags
>> refcnt - css atomic refcount, for online shows huge bias
>> path - cgroup path
>>
>> This patch adds memcg attributes:
>>
>> mem_id - 16-bit memory cgroup id
>> memory - charged pages
>> memsw - charged memory+swap for v1 and swap for v2
>> kmem - charged kernel pages
>> tcpmem - charged tcp pages
>> shmem - shmem/tmpfs pages
>>
>> Link: https://lore.kernel.org/lkml/153414348591.737150.14229960913953276515.stgit@buzz
>> Suggested-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Reviewed-by: Andrey Ryabinin <arbn@yandex-team.com>
>> Signed-off-by: Dmitry Yakunin <zeil@nebius.com>
> FWIW, I was just recently working on a debugfs directly that exposes a
> list of all zombie memcgs as well as the "memory.stat" output for all
> of them.
>
> This entails a file at /sys/kernel/debug/zombie_memcgs/all that
> contains a list of zombie memcgs (with indentation to reflect the
> hierarchy) and an id for each of them.
>
> This id can be used to index per-memcg directories at
> /sys/kernel/debug/zombie_memcgs/<id>/, which include debug files. The
> only one we have so far is
> /sys/kernel/debug/zombie_memcgs/<id>/memory.stat.
>
> If there is interest in this, I can share more information.
>
>> ---
>>   include/linux/cgroup-defs.h |   1 +
>>   kernel/cgroup/cgroup.c      | 101 ++++++++++++++++++++++++++++++++++++
>>   mm/memcontrol.c             |  14 +++++
>>   3 files changed, 116 insertions(+)
>>
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index 8a0d5466c7be..810bd300cbee 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -673,6 +673,7 @@ struct cgroup_subsys {
>>          void (*exit)(struct task_struct *task);
>>          void (*release)(struct task_struct *task);
>>          void (*bind)(struct cgroup_subsys_state *root_css);
>> +       void (*css_dump)(struct cgroup_subsys_state *css, struct seq_file *m);
>>
>>          bool early_init:1;
>>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 625d7483951c..fb9931ff7570 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -40,6 +40,7 @@
>>   #include <linux/mount.h>
>>   #include <linux/pagemap.h>
>>   #include <linux/proc_fs.h>
>> +#include <linux/debugfs.h>
>>   #include <linux/rcupdate.h>
>>   #include <linux/sched.h>
>>   #include <linux/sched/task.h>
>> @@ -7068,3 +7069,103 @@ static int __init cgroup_sysfs_init(void)
>>   subsys_initcall(cgroup_sysfs_init);
>>
>>   #endif /* CONFIG_SYSFS */
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +void *css_debugfs_seqfile_start(struct seq_file *m, loff_t *pos)
>> +{
>> +       struct cgroup_subsys *ss = m->private;
>> +       struct cgroup_subsys_state *css;
>> +       int id = *pos;
>> +
>> +       rcu_read_lock();
>> +       css = idr_get_next(&ss->css_idr, &id);
>> +       *pos = id;
>> +       return css;
>> +}
>> +
>> +void *css_debugfs_seqfile_next(struct seq_file *m, void *v, loff_t *pos)
>> +{
>> +       struct cgroup_subsys *ss = m->private;
>> +       struct cgroup_subsys_state *css;
>> +       int id = *pos + 1;
>> +
>> +       css = idr_get_next(&ss->css_idr, &id);
>> +       *pos = id;
>> +       return css;
>> +}
>> +
>> +void css_debugfs_seqfile_stop(struct seq_file *m, void *v)
>> +{
>> +       rcu_read_unlock();
>> +}
>> +
>> +int css_debugfs_seqfile_show(struct seq_file *m, void *v)
>> +{
>> +       struct cgroup_subsys *ss = m->private;
>> +       struct cgroup_subsys_state *css = v;
>> +       /* data is NULL for root cgroup_subsys_state */
>> +       struct percpu_ref_data *data = css->refcnt.data;
>> +       size_t buflen;
>> +       char *buf;
>> +       int len;
>> +
>> +       seq_printf(m, "css=%pK cgroup=%pK id=%d ino=%lu flags=%#x refcnt=%lu path=",
>> +                  css, css->cgroup, css->id, cgroup_ino(css->cgroup),
>> +                  css->flags, data ? atomic_long_read(&data->count) : 0);
>> +
>> +       buflen = seq_get_buf(m, &buf);
>> +       if (buf) {
>> +               len = cgroup_path(css->cgroup, buf, buflen);
>> +               seq_commit(m, len < buflen ? len : -1);
>> +       }
>> +
>> +       if (ss->css_dump) {
>> +               seq_puts(m, " -- ");
>> +               ss->css_dump(css, m);
>> +       }
>> +
>> +       seq_putc(m, '\n');
>> +       return 0;
>> +}
>> +
>> +static const struct seq_operations css_debug_seq_ops = {
>> +       .start = css_debugfs_seqfile_start,
>> +       .next = css_debugfs_seqfile_next,
>> +       .stop = css_debugfs_seqfile_stop,
>> +       .show = css_debugfs_seqfile_show,
>> +};
>> +
>> +static int css_debugfs_open(struct inode *inode, struct file *file)
>> +{
>> +       int ret = seq_open(file, &css_debug_seq_ops);
>> +       struct seq_file *m = file->private_data;
>> +
>> +       if (!ret)
>> +               m->private = inode->i_private;
>> +       return ret;
>> +}
>> +
>> +static const struct file_operations css_debugfs_fops = {
>> +       .open = css_debugfs_open,
>> +       .read = seq_read,
>> +       .llseek = seq_lseek,
>> +       .release = seq_release,
>> +};
>> +
>> +static int __init css_debugfs_init(void)
>> +{
>> +       struct cgroup_subsys *ss;
>> +       struct dentry *dir;
>> +       int ssid;
>> +
>> +       dir = debugfs_create_dir("cgroup", NULL);
>> +       if (dir) {
>> +               for_each_subsys(ss, ssid)
>> +                       debugfs_create_file(ss->name, 0644, dir, ss,
>> +                                           &css_debugfs_fops);
>> +       }
>> +
>> +       return 0;
>> +}
>> +late_initcall(css_debugfs_init);
>> +#endif /* CONFIG_DEBUG_FS */
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 4b27e245a055..7b3d4a10ac63 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -5654,6 +5654,20 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>>          }
>>   }
>>
>> +static void mem_cgroup_css_dump(struct cgroup_subsys_state *css,
>> +                               struct seq_file *m)
>> +{
>> +       struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>> +
>> +       seq_printf(m, "mem_id=%u memory=%lu memsw=%lu kmem=%lu tcpmem=%lu shmem=%lu",
>> +                  mem_cgroup_id(memcg),
>> +                  page_counter_read(&memcg->memory),
>> +                  page_counter_read(&memcg->memsw),
>> +                  page_counter_read(&memcg->kmem),
>> +                  page_counter_read(&memcg->tcpmem),
>> +                  memcg_page_state(memcg, NR_SHMEM));
>> +}
>> +
>>   #ifdef CONFIG_MMU
>>   /* Handlers for move charge at task migration. */
>>   static int mem_cgroup_do_precharge(unsigned long count)
>> --
>> 2.25.1
>>
>>
