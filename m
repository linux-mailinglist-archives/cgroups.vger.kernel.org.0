Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABD14BAF02
	for <lists+cgroups@lfdr.de>; Fri, 18 Feb 2022 02:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiBRBJG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Thu, 17 Feb 2022 20:09:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiBRBJF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Feb 2022 20:09:05 -0500
X-Greylist: delayed 73 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 17:08:49 PST
Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ECC3B011;
        Thu, 17 Feb 2022 17:08:47 -0800 (PST)
Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masami.ichikawa@cybertrust.co.jp>)
        (not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id SJ7Y17851A;
        Fri, 18 Feb 2022 09:59:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlxfnbRYiAZhL0t0yltA8T5JjPDjkiTW18tiK6vXJWhCmjWH+kLEM5abvtZvQY1Fc6xHXWnWZNQKTsARzieuWxkfICku5hZZxcom1ifVoUT0JfGCWML6ttVr3UZaa7OcuW5r30K79MZdwK+EMtgqkcC853RJbEZ+gE/fUzND8Sz62h2jt1yMmQ8Bat2HV96CdDarpkNf0HHwNgcgQMQyymwO7tM8sgpf9Tqim4ISChYNR6yXqxaNGddbTBTTL8jW27vnapo41eDSYvRC2fyVTO3TVRUh2NrdswUKIJVrRpKt6XX7IsN5mRzoZHDuJj2N7g9o1EY9GzhVZ70gtXWaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Un1J5rsdzLuWq4M6RN2/tSztAw7KYkhRPpidmodejs=;
 b=iUXDwWSUyluEWkfPiRjF4mb1rw4SEgcyKxJqCuzG7e4yseOyzJOUVaX33JvloyvYFEjXu8AAX3N03rEfurPVOjRl4thEXI7mIQd88JArp1tQsfMrfdUKdeZwoDwKkFiTVw6CWlvRUBropUp807/3XWlKa3IHPZISueaAS+hlupBN9jZnsklAKXx8h0MOfJnwCQ1KNnSErdmxHm11fm4EC5AOKqHyMfomvHgcGkYMudehJMZpDBjIr8RrKT0ftowjfMZq7hJeFE8lqtcizLY2DQbU+s57sg9GT8CMtEq2JCWCxNZJiujM3hDBRxqd15byHi93mWXIM9v/j7fucT1Flw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cybertrust.co.jp;
Received: from TY2PR01MB3882.jpnprd01.prod.outlook.com (2603:1096:404:de::12)
 by OSBPR01MB2229.jpnprd01.prod.outlook.com (2603:1096:603:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 00:59:13 +0000
Received: from TY2PR01MB3882.jpnprd01.prod.outlook.com
 ([fe80::ad4d:dba:6675:d46d]) by TY2PR01MB3882.jpnprd01.prod.outlook.com
 ([fe80::ad4d:dba:6675:d46d%4]) with mapi id 15.20.4995.019; Fri, 18 Feb 2022
 00:59:13 +0000
X-Gm-Message-State: AOAM533UPSAHcufqitpU/9N9W/yD0orTsqe1RMmx5sf/whnre4kgYGPF
        dAGa8KvYMKRXpaZOSiHATywufZvOIEQsAMPLjb6sdA==
X-Google-Smtp-Source: ABdhPJz+M0VRjaCCeR7/7ZCSPKWcmGd8dAs4AdblzMoGZCV5Pt/y5UEAhyDQSIdSn/1hP8FSf0cJetSUR79X0qGRDHY=
X-Received: by 2002:a9d:ec2:0:b0:592:badf:cd7c with SMTP id
 60-20020a9d0ec2000000b00592badfcd7cmr1763014otj.67.1645145552505; Thu, 17 Feb
 2022 16:52:32 -0800 (PST)
References: <20220217161128.20291-1-mkoutny@suse.com>
In-Reply-To: <20220217161128.20291-1-mkoutny@suse.com>
From:   "Masami Ichikawa(CIP)" <masami.ichikawa@cybertrust.co.jp>
Date:   Fri, 18 Feb 2022 10:05:26 +0900
X-Gmail-Original-Message-ID: <CAODzB9qKWpQ5Rn4SwHUMa8xM6jfd-EuHPLyCPFHEbTFETM4Vvg@mail.gmail.com>
Message-ID: <CAODzB9qKWpQ5Rn4SwHUMa8xM6jfd-EuHPLyCPFHEbTFETM4Vvg@mail.gmail.com>
Subject: Re: [PATCH] cgroup-v1: Correct privileges check in release_agent writes
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Masami Ichikawa <masami.ichikawa@cybertrust.co.jp>,
        Tabitha Sable <tabitha.c.sable@gmail.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, stable@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: SN1PR12CA0097.namprd12.prod.outlook.com
 (2603:10b6:802:21::32) To TY2PR01MB3882.jpnprd01.prod.outlook.com
 (2603:1096:404:de::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 929d364c-b1aa-462b-f316-08d9f279e11d
X-MS-TrafficTypeDiagnostic: OSBPR01MB2229:EE_
X-Microsoft-Antispam-PRVS: <OSBPR01MB2229688A2466E67627E95D4CD4379@OSBPR01MB2229.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7U73ZDxkUsP0K+xDobuVkU0HhRwDZmje79IVtuh0/AMSW65ZoTNjCH1SMaN/wtQxLPyLFx3expCZX3FVYMoY7zosqZAAcOLpC1wZX3Wtn6vAacZatxCqgTNFZMQ4rXaspYKQ707MA8eBKGAmP5yxmIq77yCqdLk7ZrwPBxOSqHWmgvg0WZSSVn3K0ld3c+KstdVyeMCmVAdrNgMPlZlO4c/aK+Pwq8Pifgq5jQe7ize7t+0CDFxJAJajE6iOVGBdfcffOR7IL0/hCFUKi6oSiQP0Beh70t32rwWdOJJYEQ4ua+2aYgZnzyY+Jo3wRexvK1CIsyLSwfymPAjzbw1BMrVe3xunNfrPL3Fq+4H8UWOfCZVjCVA++O1Kxz4zeUmpIxCTlbSFs46xgpSQPFaOjh5qY0TdGt3f0QjUbFY1q4Vvwutq1FsT/KX29nKhB371QE/uOLvDeAn6Csz+/EPxa/cIoRU0L5FZsbjASiFa7uTXLG6iShl5PZR2nf1lePRjaO4LfYcSAH15gAc6/uoCq/N1IUkaAKr6w+tJfFf8YfnQeWkS4jD6X+PIb9sDURnZA2wMnmQU7KVEBODlcwAVhc9czQWxcIpHEt4VKrL9T81VzWsNECNTvWLcMZ/XpnV2ig/4xpY7xXVllL6PL1jPob1OsNiXIS2aGsl4WKwhrR18PSoyDqHOESUrNkWt7Jl+EXjfxvfkEQQxz55wKL6v8Sfy7ivFeQ8p06kGSKnLA4QDzSY47n7NainDx3ZcKh60ztOgTjGJXJ4V77DbC6otaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3882.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(53546011)(55236004)(82960400001)(8936002)(6506007)(9686003)(6666004)(6512007)(6862004)(4326008)(66556008)(8676002)(66476007)(26005)(186003)(66946007)(38350700002)(5660300002)(38100700002)(83380400001)(6486002)(107886003)(508600001)(86362001)(316002)(54906003)(2906002)(966005)(55446002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVVHT3dMNDIxdElCeUNUOVJYb1dhSjdhcDkrakNxRC9GWk9IN2ZWbThwTXJ4?=
 =?utf-8?B?YlF6WGVoNHVpMGhLYTRZR2pxRUJ6WDdXV2VwUS9PT2Q3bVRub09jMEUwdGNY?=
 =?utf-8?B?R0IyVXR5WXhoZlJTcmlnbGl4Nm5LbHJnNkc5TlB6Wkl2UWxEenpFaVVKaEo0?=
 =?utf-8?B?RVk4K3lLaWlrclp4czN4b0thMnI0VGNkTVQvVmdXSVcybjRZcEo4ZnhTdXA1?=
 =?utf-8?B?cjlyMVYvcml1K0NFZFgxSEpKYURkdnZoL0NLM0RHNnkrK1hDYy9qNHBBV0dO?=
 =?utf-8?B?eG5XTjBnSURZY2FLOE9EaW5WalBGQUxTTWtycWtneWs4ZmIrNzh0VERibmUy?=
 =?utf-8?B?WVJkUmlvbHpsOXlZTXFJYWlFOG5TVld6ZGtZYmU4YTRuTFhmWVBjSHVsb1NR?=
 =?utf-8?B?bGg2K0Q2dGpBelQyd0UyT1N3anNnTTZmQ2NNOFk5WlE3bENTeHhOVCtCYkE5?=
 =?utf-8?B?b0Q0ZE8xMWhSNzhqRWNBd0E5elBYV2YvRDRoeFB4Tmd6TW96TnFpbnpRNWN3?=
 =?utf-8?B?bldzcjJYenBYWVZyb1VObkNRUG4rRjVCRE13VHlTQ0ZpeEw0K3ZnWE9PVXhu?=
 =?utf-8?B?UXJrb1BpN2EveGxyL2ExOEtXUkxxVkpoRFFsQU9HY0RqL2E1VFBMZTJId0hB?=
 =?utf-8?B?cGFTWG5sUXFvbFkzWmhPbDNXOExKelBweHRzNVdwWVdqWWhid0N3NE9jcnRS?=
 =?utf-8?B?ZjRhZ0Z0ZmlhL2ZpajJaMFZQa04wNDAwVHE3enFZVlRhNHcwblZWeUpKTUxo?=
 =?utf-8?B?NFB5NG5NR3oyRXA2dlk0SXNiRk56bXQ5SlRLYTZPMzdwdWs5dWpDc2ZxTVQr?=
 =?utf-8?B?Sk40N29qUmtIb3poOGlRSEJSYkw4ZWRha1NxZkhPemdoTGJjb09uWFJqZ0k2?=
 =?utf-8?B?UGV5clJ4NEczbHFYY1c2cmpyY2tMNWtNVmpSRnFIMms1L1hqanlIenM3Zkcy?=
 =?utf-8?B?V1hlMHl6SFlacXJ4a2pibWJwcGZ3dWRaTFBsNXlSR3VnMUVveFdKTDJYV0l5?=
 =?utf-8?B?cHNsbHhRTXlnNzg4dHBDbzhXL0tyejJQbEF1bFdRdjF2VEE3S3paQzBlNTNL?=
 =?utf-8?B?VU94TkRmd1JkR0hLaSs5LzlRSGhEb1Z1ZmhEMEcxMFI0ZExiT1BtRnFsQWU1?=
 =?utf-8?B?a3hwL0k0R3dUaVgvaG8yOGNvdE16NXJzTWZNTUx3T3ZZUjRkTnRVZWlaT05O?=
 =?utf-8?B?dldzdnRyR2pOeE5EZU9yeW5yUG01N1dhQzkwU003NHI3UmZGcXBmNHAzUFZz?=
 =?utf-8?B?ZGhKU2Z4TkloZURCYW9WVURGdUhubXFwVTdzT0Z5SnJuVFAzSzRsMXcxcnFC?=
 =?utf-8?B?bUlabEFNSElSeWZ3TVpYSHZNaWlmWGRCMVhtelQ4U2U0ZnBiR0d5cUlhaG5M?=
 =?utf-8?B?L3RpV3hicGFTTUxGODFBVUphQmMyRjJQYkM4WmVpWXh6QnhsNVdOZ09pd2tZ?=
 =?utf-8?B?YU4xR28xaWRTUHV3UmZJRlJpQmNwQzRxeXJGeENJSk1hdXBOU3hBZFB4WFdR?=
 =?utf-8?B?T0NqTlpzdlllOFJ1V3VldGlnRjJjbGFtdjN3eXBiTkt4Mmp6S0g0SVhpV0ha?=
 =?utf-8?B?QkxFeXFjUVNsdlQ5WmdpZE5RaFlLS2tCQTVienRFT2RsRXovQllIQzFmZjFn?=
 =?utf-8?B?cjJDaGZrNnNrVjVTZlpuS3lCZ0JnQ25NWHh0Q0NPa1o0ekZlOHdSUDI0Y01Z?=
 =?utf-8?B?Q3ZhOHVjZnN2T0I0YkJkUkV3b1lWMDRNSUJ1bkVIS0FkQ0dsQkpNeXRYVy9X?=
 =?utf-8?B?L1lnNTduWGtOclhGcXE4cWJReEMyaVFnSG5BRkpzNzJsZkMwT0hzWlBBN25l?=
 =?utf-8?B?cndYZHN0YVdGMlgxRkhTN0lVZWY5Tmg2TEozRTBnY1AyS1NtZjcvZ3Roc3dT?=
 =?utf-8?B?L3VjanA0akFzS3hESGM1RU9YQzZScFRsczNDSjFZY1A0YnM4OVNYQmphS0ls?=
 =?utf-8?B?R1NnZ3A0VHZpN2w1VENFcjRGRlpSS1YzYlBSbFJYY2t5ZWpnLy9TNG1FQXlo?=
 =?utf-8?B?R0pJWUVHbG8wQnIyWlpJcmw1bHMyTG9IdXF5TWszdzhsZmJBZERMTXRzeXpi?=
 =?utf-8?B?QjJZakZnTENpYjZ4QTE4cXd1RmZNYzdXekRBL0ZSRVVscW91QmZCUzBFV0Zv?=
 =?utf-8?B?ckJFU1ZSSmVmQ1BtajFpSGcvdWNQa0M5RU1lVjRQNWZSbjh2QXZVRmJoc0FF?=
 =?utf-8?B?YzBSUTFLaUlGN3gzdTRpbFMwL3h1ajRnN2VVOFZ5R3BRcDR2TmZDLzdyeHRr?=
 =?utf-8?B?T09RT0Z6TmIzL0tpUlBTM0htWE0xdEZiTUg3RmRWSHV6UWVLWFc4K2FCN2dT?=
 =?utf-8?B?WTliZGg1cHczWGtnSCtzQzFjSXh2bzJvSkVoZzhBRDNrUHhkN1JUUT09?=
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 929d364c-b1aa-462b-f316-08d9f279e11d
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3882.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 00:59:13.2530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WavuJHUNmz/ljSig98bxh7HJk80aaw1CencmPMczagikgqQGhJZXa6nXyL1AG0Ojw2PREAjQabKupFaYIICB8QbUZwz7j89/ppkVxh+CVWNtO63ycC5caofznRpU54NX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2229
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 18, 2022 at 1:11 AM Michal Koutný <mkoutny@suse.com> wrote:
>
> The idea is to check: a) the owning user_ns of cgroup_ns, b)
> capabilities in init_user_ns.
>
> The commit 24f600856418 ("cgroup-v1: Require capabilities to set
> release_agent") got this wrong in the write handler of release_agent
> since it checked user_ns of the opener (may be different from the owning
> user_ns of cgroup_ns).
> Secondly, to avoid possibly confused deputy, the capability of the
> opener must be checked.
>
> Fixes: 24f600856418 ("cgroup-v1: Require capabilities to set release_agent")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/stable/20220216121142.GB30035@blackbody.suse.cz/
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  kernel/cgroup/cgroup-v1.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index 0e877dbcfeea..afc6c0e9c966 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -546,6 +546,7 @@ static ssize_t cgroup_release_agent_write(struct kernfs_open_file *of,
>                                           char *buf, size_t nbytes, loff_t off)
>  {
>         struct cgroup *cgrp;
> +       struct cgroup_file_ctx *ctx;
>
>         BUILD_BUG_ON(sizeof(cgrp->root->release_agent_path) < PATH_MAX);
>
> @@ -553,8 +554,9 @@ static ssize_t cgroup_release_agent_write(struct kernfs_open_file *of,
>          * Release agent gets called with all capabilities,
>          * require capabilities to set release agent.
>          */
> -       if ((of->file->f_cred->user_ns != &init_user_ns) ||
> -           !capable(CAP_SYS_ADMIN))
> +       ctx = of->priv;
> +       if ((ctx->ns->user_ns != &init_user_ns) ||
> +           !file_ns_capable(of->file, &init_user_ns, CAP_SYS_ADMIN))
>                 return -EPERM;
>
>         cgrp = cgroup_kn_lock_live(of->kn, false);
> --
> 2.34.1

Thank you. Looks good to me.

Reviewed-by: Masami Ichikawa(CIP) <masami.ichikawa@cybertrust.co.jp>
