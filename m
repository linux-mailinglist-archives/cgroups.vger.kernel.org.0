Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D508F369A96
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 21:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhDWTCd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 15:02:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22424 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232212AbhDWTCc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Apr 2021 15:02:32 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NJ0fnu024308;
        Fri, 23 Apr 2021 12:01:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=BVKv2y1CwMySf+78zGdHb71OEY0pzqxWthwxNaZ677w=;
 b=enATvBR0yaM1w8STLScUtXBFAXWNQtg/pr+oPSEzMHrVJndGDkLARMQJbsFLbBc74Fhb
 A2mYpM56omqMHlariIFVulCw4wSGV5peog4tmTeUpPGjolAZbWrF1TGLiQ6LSqi1slLX
 Tn8rdFsFZ5pveBLXZ7ihjtsecKt2T6OSDxY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 383b4q8cqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Apr 2021 12:01:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 12:01:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5tMg/yVBqeFwpFGiPwemcAJJasMVSktYUO1ymh9t+nZXMbNZYmtZmseKptQZdTMwIdNp1kJqFLjqwmukWbf0oQKn8wdTq8Qd0mBILjs71wh1wlLF9gHksZ3jLSIC7JEw1d6mr6kNj8hN0Fduju88XGah4gULyFWJeR15zdB5WPGlEVhOYStRZuUWhlBOJK4jbt8+qDQ0MlqDoM9CwIsyPNUn6knsudLQstS9AQVo8tdrrRlSdxm3mYwGSYKvwPI/FBp9OvGhWKofK9QFj5wTJF1jiPrdOhx1G/Ka497QK1LoyEDNynC4W10lpjkt3mLwIVCX9InPCjit7tWOeiPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVKv2y1CwMySf+78zGdHb71OEY0pzqxWthwxNaZ677w=;
 b=FwqGXYPRejTtVQ7jlAGzGJt4YaPfpTGzvdKA4V9Xg3356vga6hmR9yV4cVfRXTBfiasTtCledMwp+PaW1SstUGCCZgj1k1nRWY44Ln/G79hRbSUDkSuKM9r63dF2TiLU4K6DywscW4/PTF0x/SA/cbgDMhnZ5QkQMjXgfs2xzkA03Js9Btrn0YW5EupR62lZ3K0lJcPSQkqiqLkV5hR9tb+kfNKJRPwmi/qm7ogVfEPOEQGvEPd6q6sFAY3nTWTUr6H0IGwx+kXuavnjnYe89FdHjlZbawJ5tYh53TVE1x6DP0jDbahVsL+jGcPsKg0/qF0lSW+3BML3N24/xMTARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4963.namprd15.prod.outlook.com (2603:10b6:a03:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 19:01:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 19:01:42 +0000
Date:   Fri, 23 Apr 2021 12:01:38 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RFC PATCH] cgroup: add cgroup.signal
Message-ID: <YIMZkjzNFypjZao9@carbon.dhcp.thefacebook.com>
References: <20210423171351.3614430-1-brauner@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210423171351.3614430-1-brauner@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:c976]
X-ClientProxiedBy: MWHPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:300:4b::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c976) by MWHPR02CA0016.namprd02.prod.outlook.com (2603:10b6:300:4b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend Transport; Fri, 23 Apr 2021 19:01:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4718c350-46c9-4981-e10c-08d9068a3b5f
X-MS-TrafficTypeDiagnostic: BY3PR15MB4963:
X-Microsoft-Antispam-PRVS: <BY3PR15MB4963BB67541D736752717A02BE459@BY3PR15MB4963.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zyxfgQzjgWNpQ/QPn2fFz9PiIeHMMVPuXvBSXulJy5KvAr9nYeBJtj3ERvGr1x9RyWfL/erBl+DZ7MLdasBl6LUDVhNsYPlD+ZqVmwKogaJlsqcI6f1p5cgvFLp0Q+C5EtG3LUhPJB6hsObRR3XdgmEwQIYTzwku7jheL0qObPJ/cgGAElnkwE+ol/u79uZ075DJeGtKiiJiDZQ7B7Dj1e6hJX+zNViVf5qFX+EhdYXoFiUpBtojLfdOsRFj77bNec2JDBO30jFNnCkBAcdts0hWLH8Mpp1MYdXqLdCG8Q/CXjcFm0hL3X+mwxe2tBYazfkxrjytd0Bm/JWFw5BhsAses+B/FcTr7g98PQqGK26q1VkKNNtVAYXXD/CK1bAiv1efvEJFGY7VkDs565MN+AiskZgavSuL2H0mT/0LMBmvCZLtMYEBWWsDEJk/szm1fxaH1kXaq1C4OYuyMrPG2zpGkWg5xlWZUWF/0WAEzVQt9r5s4H6a8jEYkLESWG1pLcv4PrbQxVtsNXA34XdpMUuKiE5SFxhOCtmpIkhNVctL/kngImjdXDc2ykAS0sfcMGDmpbQOTPXoP1aZRdnM9HOx3JBJ+LFTGG0WLp1sM68=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(5660300002)(8936002)(6916009)(8676002)(478600001)(4326008)(6506007)(316002)(54906003)(83380400001)(86362001)(2906002)(52116002)(38100700002)(7696005)(55016002)(9686003)(16526019)(66556008)(66476007)(186003)(6666004)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AcWnGPFa0+oNYZ5AAFVRZqFVR/E3KJL4pH4cU65Uuyy1JCWcyzvTiOXUlNcP?=
 =?us-ascii?Q?3AuQ3mplqN/IomzWwBnqvaWxHjCYo/ZwRepLyPJIhiszC/a5n8zWg2X2WBtf?=
 =?us-ascii?Q?enJ2d8l49DFZouqjvmp+rPbAoGAwOh1D+C831bWsXCQJCDPuy95JwIntop0V?=
 =?us-ascii?Q?rPBNEY342zoy7vr953VoMN8VcgDb0d/Q9+yglAmp6iFke/RtQ0TlwFQ9DsVp?=
 =?us-ascii?Q?WurqDH9Vndd1Nxzgtbyl8L3nOBrAUFYl8uDztt8Ptq4xNPXWoPYvbezqUikI?=
 =?us-ascii?Q?LA954U8MU8tsMpkktvgwQxiVBOylrKXcRwx8upRzFzxc7V8ayH4RAPE7JY+5?=
 =?us-ascii?Q?pdQVq2SqlfDnHVWa8vMXdpd4EluxvkhIcBOKVOU+LVSypfukcOCx8RFMuC7C?=
 =?us-ascii?Q?K+BecSuq/CQ70cJAck1HxpMTGskzBcImCWSGsWdaNpXYPDbdZrJ7YmadlsZe?=
 =?us-ascii?Q?EeehyYmBqtQ1ZmvsV/Z59zL33hgFyeAXrZAGiq3w4NqZyMXBxvovvy48QZ02?=
 =?us-ascii?Q?w630tT1DZMquu/8I/2+q4k4rVZLg4NS1VHCLP6Hpjzw8LP8oJ8hwyZUDyyXW?=
 =?us-ascii?Q?UcCwn/H0M0n/LrOrjR6j9jCTCIWUVBJK9qvJeSQrnrcEqEW1rGJzq8rjX8To?=
 =?us-ascii?Q?P+zKqBQwbLz8TtMGIrY6qhC/P5/MrXCL3tUwBBJHEzGsapJoaHaGDMCpEVw1?=
 =?us-ascii?Q?UOanrHYIgtY4TaMksj9SSgy+kbr0pyTF8gbOtxSf2xfwWEUZZ2ogiGheCOUL?=
 =?us-ascii?Q?oor6fWrMr0jek5aAmPUaEV+QtmlrbZAk5F/uLi39UR/gIIpMu1PHe3An4JqR?=
 =?us-ascii?Q?CrfF9UIs2pH8TZ/Z4OmngBy8dbVn941RTgPW4tS0fQrGk5gagxEI3XhG6nkt?=
 =?us-ascii?Q?vJE702Uj0APXe/HjC+v35UAkw+VBBMnKGEZaFgPS/jV17w4/l4uvxojiczjJ?=
 =?us-ascii?Q?qbKSOf+kU/W8mL/zayFZJdp4mybylMGIvKsLio9CIaCAc7JtPxdhbBhIPNJw?=
 =?us-ascii?Q?CBsr1Q+Jf3BIvwOxmjoko9bHbCzC/oc2mRul7GZn0PL2HqEVascmT3BmklvE?=
 =?us-ascii?Q?SBnUJY1vKbghJzbza6KxApjy2XfV2716Ezy4SSFRYpbROaTVDhkqlZgBj0s4?=
 =?us-ascii?Q?qj0QFFjmDkT3wVz2NvmiPQiznTPaNF337S/xuw/wgWwwpaBwjrmkl/nFJoJc?=
 =?us-ascii?Q?mwVQ8yMnrO4Qt8nMi4J1dmXeEKHVe/c6/klwpajdfVdZ0Gx4rz5Uz7MoRcrg?=
 =?us-ascii?Q?q/GgXZzHtKHUUQdZo96p1FKKa+Y9Nx9DjWXq7j6qNGRiZZ2D0ug8xXWOEut4?=
 =?us-ascii?Q?2c024LiHlEvEQQNjmG2co55GcDMx0cKWQa5WOXzQ/ogazA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4718c350-46c9-4981-e10c-08d9068a3b5f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 19:01:42.3097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ndd1dvGouRm2axHc5CNGem8l9YJ7ktyoXeB8CJpmeAFSuuQkkvn7jknrBagb3Mv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4963
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: GEquYftbZzMZecj4qh3xBzTdTfMcwRlb
X-Proofpoint-ORIG-GUID: GEquYftbZzMZecj4qh3xBzTdTfMcwRlb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_07:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 mlxlogscore=999 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104230123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 23, 2021 at 07:13:51PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Introduce a new cgroup.signal file which is available in non-root
> cgroups and allows to send signals to cgroups. As with all new cgroup
> features this is recursive by default. This first implementation is
> restricted to sending SIGKILL with the possibility to be extended to
> other signals in the future which I think is very likely.
> 
> There are various use-cases of this interface. In container-land
> assuming a conservative layout where a container is treated as a
> separate machine each container usually has a delegated cgroup.
> 
> This means there is a 1:1 mapping between container and cgroup. If the
> container in addition uses a separate pid namespace then killing a
> container becomes a simple kill -9 <container-init-pid> from an ancestor
> pid namespace.
> 
> However, there are quite a few scenarios where that isn't true. For
> example, there are containers that share the cgroup with other processes
> on purpose that are supposed to be bound to the lifetime of the
> container but are not in the same pidns of the container. Containers
> that are in a delegated cgroup but share the pid namespace with the host
> or other containers.
> 
> Other use-cases arise for service management in systemd and potentially
> userspace oom implementations.
> 
> I'm honestly a bit worried because this patch feels way to
> straightforward right now and I've been holding it back because I fear I
> keep missing obvious problems. In any case, here are the semantics and
> the corner-cases that came to my mind and how I reasoned about them:
> - Signals are specified by writing the signal number into cgroup.signal.
>   An alternative would be to allow writing the signal name but I don't
>   think that's worth it. Callers like systemd can easily do a snprintf()
>   with the signal's define/enum.
> - Since signaling is a one-time event and we're holding cgroup_mutex()
>   as we do for freezer we don't need to worry about tasks joining the
>   cgroup while we're signaling the cgroup. Freezer needed to care about
>   this because a task could join or leave frozen/non-frozen cgroups.
>   Since we only support SIGKILL currently and SIGKILL works for frozen
>   tasks there's also not significant interaction with frozen cgroups.

Hello Christian!

I'm worried that we might miss a fork'ing task. If a task started fork'ing,
holding a tasklist_lock will not prevent it from joining the cgroup after
we'll release it. So I guess the task could escape from being killed, which
will obviously break user's expectations. Something to check here.


> - Since signaling leads to an event and not a state change the
>   cgroup.signal file is write-only.
> - Since we currently only support SIGKILL we don't need to generate a
>   separate notification and can rely on the unpopulated notification
>   meachnism. If we support more signals we can introduce a separate
>   notification in cgroup.events.

An alternative interface is to have echo "1" > cgroup.kill .
I'm not sure what's better long-term.
Given that it's unlikely that new signals will appear, maybe it's better
to decide right now if we're going to support anything beyond SIGKILL and
implement it all together. Otherwise applications would need to handle
-EINVAL on some signals on some kernel versions...

> - We skip signaling kthreads this also means a cgroup that has a kthread
>   but receives a SIGKILL signal will not become empty and consequently
>   no populated event will be generated. This could potentially be
>   handled if we were to generate an event whenever we are finished
>   sending a signal. I'm not sure that's worth it.

I think this is fine. Generally it's expected that all kthreads are in
the root cgroup (at least on cgroup v2). If it's not the case, a user should
be prepared for various side-effects. The freezer has them too. There is no
way to treat kthreads as normal processes without bad consequences.

> - Freezer doesn't care about tasks in different pid namespaces, i.e. if
>   you have two tasks in different pid namespaces the cgroup would still
>   be frozen.
>   The cgroup.signal mechanism should consequently behave the same way,
>   i.e.  signal all processes and ignore in which pid namespace they
>   exist. This would obviously mean that if you e.g. had a task from an
>   ancestor pid namespace join a delegated cgroup of a container in a
>   child pid namespace the container can kill that task. But I think this
>   is fine and actually the semantics we want since the cgroup has been
>   delegated.
> - It is currently not possible to signal tasks in ancestor or sibling
>   pid namespaces with regular singal APIs. This is not even possible
>   with pidfds right now as I've added a check access_pidfd_pidns() which
>   verifies that the task to be signaled is in the same or a descendant
>   pid namespace as the caller. However, with cgroup.signal this would be
>   possible whenever a task lives in a cgroup that is delegated to a
>   caller in an ancestor or sibling pid namespace.

I agree.

> - SIGKILLing a task that is PID 1 in a pid namespace which is
>   located in a delegated cgroup but which has children in non-delegated
>   cgroups (further up the hierarchy for example) would necessarily cause
>   those children to die too.
> - We skip signaling tasks that already have pending fatal signals.
> - If we are located in a cgroup that is going to get SIGKILLed we'll be
>   SIGKILLed as well which is fine and doesn't require us to do anything
>   special.
> - We're holding the read-side of tasklist lock while we're signaling
>   tasks. That seems fine since kill(-1, SIGKILL) holds the read-side
>   of tasklist lock walking all processes and is a way for unprivileged
>   users to trigger tasklist lock being held for a long time. In contrast
>   it would require a delegated cgroup with lots of processes and a deep
>   hierarchy to allow for something similar with this interface.
> 
> Fwiw, in addition to the system manager and container use-cases I think
> this has the potential to be picked up by the "kill" tool. In the future
> I'd hope we can do: kill -9 --cgroup /sys/fs/cgroup/delegated
> 
> Once we see this is a feasible direction and I haven't missed a bunch of
> obvious problems I'll add proper tests and send out a non-RFC version of
> this patch. Manual testing indicates it works as expected.

Overall it sounds very reasonable and makes total sense to me. Many userspace
applications can use the new interface instead of reading cgroup.procs in
a cycle and killing all processes or using the freezer and kill a frozen
list of tasks. It will simplify the code and make it more reliable.

Thanks!
