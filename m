Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A001C206B21
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2020 06:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgFXEai (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Jun 2020 00:30:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8984 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726131AbgFXEai (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Jun 2020 00:30:38 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05O4PAl2030909;
        Tue, 23 Jun 2020 21:30:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=j2101CErjOndZGUm/ygjJbsPSBU032t3FbmOjMUxhoE=;
 b=IyQta9mmaCNVA1OGp4EwEYPwsT3AitDcr9Wxj17xhEgSKcCzenO56hG33MtDKa/+rKfd
 4htzNBkOdUEynwXKkNflD5QlD2dwL3WNvrLZe4Hi/8QxrDyN402zFDBABbcthQvuhzIv
 6Rw20rpI5qpoF2MICAeW3emttMmYccFlaOE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31ux0vrc1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Jun 2020 21:30:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 21:30:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRWexaKbMUHHvRIdSmhI/FsoC2DGAHHXqXDlHqb+uB54Isnosq3mqpHKAV5nundBcHD1G/V5pYBS3jmhPXBfSL/htWbGvyEuGVwT0J9x+uws+d7pM6A1gywDJq3LImCZ3/QZYfXwNLjsrR/hmSY3zwcP1rUYwPibuehOCHpqD1BHUK3UXTgt5YbSXxcm7gcVQkxaTsiHvMQMamo4jWPJtSOw67ASRhHOtfNHTVm4ogWqOK4/T6fMEF5oXiCWzGiyxQ6fRlNmv3HUWsE4kID3vZOJxB+vso/SUJuwsa6Iam3uyAXKXRznESGAsS1k44Z4kHgTXoR1LyGatZelWn2Zsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI9ymdRiiHa+FT15ilKXN+zNYt3IVbTfgLFinUxjeZI=;
 b=faaUizWIBqxpo/UKXknuNz5B2mRdNbatXwu51KJtvtAE407BYWuDzSWvs3ad2DM+McOKggvNT2gjUSX0T1PjHA98nRk61NUEa1hkRg5yTbPqOE7lz5zTAtOjnJ9NkCnRei0Kai0Ghmz6gc2oPMwr2joSZgK2VXafnKE92xCmnVSz5luERcduZuD6fvTl8L8FbmRMrVLtJRquJQfhwAOUwHd92IKbh8Sm8ye+Oeoi5UESNv/MNtRfQT9VqKH+JiBprpDZzqzNQk9jkh2ukTbSv9Tzimfp2N+O6zXrlN3OFh3ys2y5NrDSKXCfVV/0bkOyrEv16e/0c2EAL4AalJthmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI9ymdRiiHa+FT15ilKXN+zNYt3IVbTfgLFinUxjeZI=;
 b=WC997DORN03qqIliFGIVILO0nHiQq/A8Au7Ab4F/rlZVFlf8/xdzpIDbkCfYNfiSQjWkkSXLxTVdvhd0gr2avAOdXjl8QIhqE3/VhmL8O2Q+tKpYjmnM53o2uzoH98ywBbaQ9ivgLQeQ7Cj5X6sH5zKAQFR5yrE0UNaHboWywLk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 04:30:28 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 04:30:28 +0000
Date:   Tue, 23 Jun 2020 21:30:21 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Xie Xun <xiexun162534@gmail.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shenwenbosmile@gmail.com" <shenwenbosmile@gmail.com>
Subject: Re: memcg missing charge when setting BPF
Message-ID: <20200624043021.GA3669@carbon.dhcp.thefacebook.com>
References: <1139555701.2821292.1592970418462.ref@mail.yahoo.com>
 <1139555701.2821292.1592970418462@mail.yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1139555701.2821292.1592970418462@mail.yahoo.com>
X-ClientProxiedBy: BY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2dfd) by BY5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:1d0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Wed, 24 Jun 2020 04:30:26 +0000
X-Originating-IP: [2620:10d:c090:400::5:2dfd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 276827ce-b772-4fbe-3e94-08d817f752b3
X-MS-TrafficTypeDiagnostic: BY5PR15MB3602:
X-Microsoft-Antispam-PRVS: <BY5PR15MB36025B31215A756C04A1C17EBE950@BY5PR15MB3602.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKhucdoBqzxq50QX6Aq9M/tkaum8FawlWxKmqSiiZ81DOc0F1Ei7oyrZ7WvsSYk0vpOcIQlHVB7mDvgy3GP+rvDIEjYtLF1Iwah/Smp8LrbH/kTTySW5gB1XQ3iNH7NeKDWeZ/y1XsSeaNtjTFfvmrXjq3tBb375AiqKnTv5MC8VOFJjvDHPqvo0PwYTdz2XVIxWG+wHBRxyN1cdP0fySI+BuAaa5cUZBq7T2AdpC08jroA/sk8fwJ4hDmVpeXEiUoJWIi1upcI+UWM2Gid3dH0BYHm+k4OqONu0Ze4yX9X/EAToBYzKlJ05kXJMGbOvpp2IUP8rLIUd4f0KyJNZ7iIgrcKBUmMRpFKilcwVQ9l5imBf/5TRQKutSii9mtUA0fc2kFgOlLTDW6PQNQEl0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(396003)(376002)(39860400002)(366004)(83380400001)(478600001)(6506007)(1076003)(86362001)(8936002)(6916009)(8676002)(2906002)(16526019)(966005)(52116002)(55016002)(316002)(33656002)(7696005)(66946007)(9686003)(5660300002)(66476007)(4326008)(54906003)(66556008)(6666004)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vxyF+EoA+mq4W08eUGJSr26OguTiVLqsI86AfGIXwmNIa1PnPxLlZ/tKcGxjFOIDFRYrWp9zUoEJ31CQzLNw8rSCMT40GkO/OEs/yvPx3AgnlvIPiLDXHNxYX0/ZK0vGsFKC4Sbvx9RGUyd5r4rdXdjm5u8Xnd/YXkL2ImEsgGoqZdLtNow5Zt9Zlt8moY1ie+7+sJt3ecd9sNeCt0xlLD0p8jG0hFjiiBDf3a42DAmga4Bkf8WgfaRkcRumu0FCKuDxNy436WvHpfmxZn0wPCKkNA6yzeWm/aIghbH5a2wHf/Pb3Z+A/fz1B6bYlbrZleipIuf4ooe46n1HumsbJzvI8I4r1vFjS5Ea1e9EBgfCqAHRWh34U0WQq0eqEGXCZEodaSxn5gKRsngAEYhr5iGZWeZuHpw8+wYkdcLtKsftnrneLeopyCV/gOLrLa8NYVBicezTOIqdfxDvLx7andv1IpQep7eBxPbaU6BcXyOrYiKbSqfpT5lp1SF2CEln0GV47liI2N0DGlMzSruMIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 276827ce-b772-4fbe-3e94-08d817f752b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 04:30:28.7143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CO1ONKMDkPAr+ikYTm1JxL8rHAQN8+yfmagoKrwlvLY2VGFyGFLsCty90I+mPB7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3602
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_01:2020-06-23,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 cotscore=-2147483648 mlxscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1011 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240032
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Xie!

It's actually not a surprise, it's a known limitation/exception.
Partially it was so because historically there was no way to account
percpu memory, and some bpf maps can are using it quite extensively.

Fortunately, it changed recently, and 5.9 will likely get an ability
to account percpu memory. The latest version of the patchset I've actually
sent today:
https://lore.kernel.org/linux-mm/20200623184515.4132564-1-guro@fb.com/T/#m0be45dd71e6a238985181c213d9934731949c089

I also have a patchset in work which adds a memcg accounting of bpf memory
(programs and maps). I plan to send it upstream on the next week. If everything
will go smoothly it might appear in 5.9 as well.

Unfortunately the magnitude of required changes does not allow to backport
these changes to older kernels.

Thanks!

PS I'll be completely offline till the end of the week. I'll respond all e-mail
on Monday, Jun 29th. Thanks!


On Wed, Jun 24, 2020 at 03:46:58AM +0000, Xie Xun wrote:
> Hello,
> 
> I found that programs can consume much more memory than memcg limit by setting BPF for many times. It's because that allocations during setting BPF are not charged by memcg.
> 
> 
> Below is how I did it:
> 
> 1. Run Linux kernel in a QEMU virtual machine (x86_64) with 1GB physical memory.
>    The kernel is built with memcg and memcg kmem accounting enabled.
> 
> 2. Create a docker (runC) container, with memory limit 100MB.
> 
>    docker run --name debian --memory 100000000 --kernel-memory 50000000 \
>    debian:slim /bin/bash
> 
> 3. In the container, run a program to set BPF for many times. I use prctl to set BPF.
> 
>    while(1)
>      {
>        prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bpf);
>      }
> 
> 4. Physical memory usage(the one by `free` or `top`) is increased by around 40MB,
>    but memory usage of the container's memcg doesn't increase a lot (around 100KB).
> 
> 5. Run several processes to set BPF, and almost all physical memory is consumed.
>    Sometimes some processes not in the container are also killed due to OOM.
> 
> I also try this with user namespace on, and I can still kill host processes inside container in this way. So this problem may be dangerous for containers that based on cgroups.
> 
> 
> kernel version: 5.3.6
> kernel configuration: in attachment (CONFIG_MEMCG_KMEM is on)
> 
> 
> This blog also shows this problem: https://urldefense.proofpoint.com/v2/url?u=https-3A__blog.xiexun.tech_break-2Dmemcg.html&d=DwIFaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=IBhsN9u88bNDFoDHNutIMKB-YrCvCOIvw-8z9RpB8RI&s=O1b3udJv7obq8vZ88-YPEDzs7hhGov3o_Txskn4IeyA&e= 
> 
> 
> Cause of this problem:
> 
> Memory allocations during setting BPF are not charged by memcg. For example,
> in kernel/bpf/core.c:bpf_prog_alloc, bpf_prog_alloc_no_stats and alloc_percpu_gfp
> are called to allocate memory. However, neither of them are charged by memcg.
> So if we trigger this path for many times, we can consume lots of memory, without
> increasing our memcg usage.
> 
> /* ------------ */
> struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
> {
>     gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
>     struct bpf_prog *prog;
>     int cpu;
> 
>     prog = bpf_prog_alloc_no_stats(size, gfp_extra_flags);
>     if (!prog)
>         return NULL;
> 
>     prog->aux->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
> 
>     /* ... */
> 
> }
> /* ------------ */
> 
> 
> My program that sets BPF:
> 
> /* ------------ */
> #include <unistd.h>
> #include <sys/prctl.h>
> #include <linux/prctl.h>
> #include <linux/seccomp.h>
> #include <linux/filter.h>
> #include <linux/audit.h>
> #include <linux/signal.h>
> #include <sys/ptrace.h>
> #include <stdio.h>
> #include <errno.h>
> 
> int main()
> {
>   struct sock_filter insns[] =
>     {
>      {
>       .code = 0x6,
>       .jt = 0,
>       .jf = 0,
>       .k = SECCOMP_RET_ALLOW
>      }
>     };
>   struct sock_fprog bpf =
>   {
>    .len = 1,
>    .filter = insns
>   };
>   int ret;
>  
>   ret = prctl(PR_SET_NO_NEW_PRIVS, 1, NULL, 0, 0);
>   if (ret)
>     {
>       printf("error1 %d\n", errno);
>       return 1;
>     }
>   int count = 0;
>   while (1)
>     {
>       ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bpf);
>       if (ret)
>         {
>           sleep(1);
>           printf("error %d\n", errno);
>         }
>       else
>         {
>           count++;
>           printf("ok %d\n", count);
>         }
>     }
>   return 0;
> }
> /* ------------ */
> 
> 
> Thanks,
> Xie Xun


