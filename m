Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0132C477B
	for <lists+cgroups@lfdr.de>; Wed, 25 Nov 2020 19:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbgKYSVX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Nov 2020 13:21:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19976 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729688AbgKYSVX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Nov 2020 13:21:23 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APIBe1E017406;
        Wed, 25 Nov 2020 10:21:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=I+DChthk9EiQffLmkW7CdZyX3w3ZthaRkxF45MUhAUU=;
 b=RSrHna0YSIa1WqX05smVN7dzqhNmogshqVt908LV95Sbi7NTtdHkjv+fpw1dDAWE1VCv
 3PuCIukl4ovtDk5KUPtA+rsmHwoUJWMW7v5Dcb/l8aMhH9q1AoyOk/tU5K80bhYFLwo4
 XopIxuwtv9LQkpX4O9h0Y4yEOqJdDKIDj40= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 350qy50vsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 Nov 2020 10:21:10 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 25 Nov 2020 10:21:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wjvd9qn2F3g5ABw+yLqO59zzTJeswxtpYZHkmdzyH4HPDASNlDli6tEb3Da5lKbC+t9mm6MrGilE60uzwiNNeocePl5U1L3z2X18qrLgJ8DUljY3vtPnHq73gInlzHIlh3rTgshszd8NxF6T8Fs2AVD4dyIUBPtPDNHg//k8Pu8/3tdrqVi3W79tTp0+NCBa+dF1JRf9FFWUgdNpt1XEx1xZcu/972F6IFyOqY1gjpriUdYc2790pmHWxcZIUtU+1qZHE+cUB4E4v+Y4oMExSMuBs7PN0DbFMTqhn66V9rmK/T+7f4a2RrQBDkAEDmfa4Rq9TJec9A/JB269fGP6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC0XA7PRBvXNoDxjpsoS98lL59qwkgWsvaA77URoGYA=;
 b=SAYQDeyhdC/ejh5HEMF4Sp1O9rw2MOEeNpYLzp/GdBD6iORPXCvtZy55l3zpRVvCc8nMzBVtoDpZTKsTAsMTjnwvLgYUj8lZDAlDV8cLPfM6wzRuFfuO9mxGSJ+1eiF7bORnU6hA+A4TYk7RC7KpWQQw9j6vNmdWSNPr3w5Cr0Xp+n9tauKJjHIiROpzjmg9sBp5jOEoz/ELbNlL5bVwk33T+qCWsLgYwof79z/TYA72MRP4LzA7ltGLRVZBf6Z2JiOHjCrRoTgOvV3WFM19284zgN6fhtTpYwc4jWGw7j2TJn3pygUK5RkofME3rf2FLVu7ZaMHZPgSy1cRQPSjmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC0XA7PRBvXNoDxjpsoS98lL59qwkgWsvaA77URoGYA=;
 b=JKdtFgG0d3tjmWOcNo4FMKYpVtOGkVujcJT0iyNT2g/BcuNOw5EhHp4i6vAQjCNEKkrIZyLmm1udBeFc3/p5aWKOVjUYWIek/4ORK2xK8Y7xLRaCc4UtKnuMY/hq8GEVMmj92/CCJr79CixAhIqtAA4qplb4k74bkibrRLQO7j0=
Authentication-Results: linux-vserver.org; dkim=none (message not signed)
 header.d=none;linux-vserver.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2438.namprd15.prod.outlook.com (2603:10b6:a02:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Wed, 25 Nov
 2020 18:21:08 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%7]) with mapi id 15.20.3589.031; Wed, 25 Nov 2020
 18:21:07 +0000
Date:   Wed, 25 Nov 2020 10:21:03 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
CC:     Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Regression from 5.7.17 to 5.9.9 with memory.low cgroup
 constraints
Message-ID: <20201125182103.GA840171@carbon.dhcp.thefacebook.com>
References: <20201125123956.61d9e16a@hemera>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201125123956.61d9e16a@hemera>
X-Originating-IP: [2620:10d:c090:400::5:c6aa]
X-ClientProxiedBy: MWHPR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:300:116::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c6aa) by MWHPR07CA0001.namprd07.prod.outlook.com (2603:10b6:300:116::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 18:21:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c21846c-0af0-4cc6-79e6-08d8916ee0d3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2438:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2438F6C2E9F153A08D168547BEFA0@BYAPR15MB2438.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QdUT/iACuO2dDEWuYZnyzOae1FWiwHKqzPymlB3lZswQ0MQr5ZCiiR+7ATA17ryPGEtPezQ0ynXPXRnzl00eU0RfsGjGAFwbdA01qYSLJJU+cOxxD1bcd9ANsGScNa8uxcjP+MheAVBXepg4m+dj4llXqDqkI1xGWWMMCrV14lUgv9sia2BHuVPDwxqD9dkc6BpiMTLh9PZbof9C+wZUq5BlJnS1EYAHmJe/PeBuqoxSd/GiIi9J1Zr/ybpwVhjx1I3nHGDzz+pZUrtP2tlvoWlBRcQOCXwrySBEiofXVnYo6ii5/nCNbAA7rKe4p1n66yEjBUZTJpMlJR5i8aXQJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(376002)(346002)(66476007)(2906002)(1076003)(86362001)(54906003)(4326008)(6916009)(33656002)(316002)(55016002)(186003)(16526019)(8676002)(9686003)(8936002)(66574015)(52116002)(7696005)(66946007)(6506007)(66556008)(5660300002)(478600001)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: aHmtN4kCi+hMwmgikO8lDnpDzxW0wWJnqEzCoMh9cwnENsZlD1Bb2kcdipQpgjrf/l8SEDsT4plU1hrYmC7qwaAjmplIk/YkPPL9+GDlbSGt7TXVI8HktaJopOfjZZ2LtHSFu1FLnVbcdYB+NNrpdWpyfTDVGZXcGLWj3k8HZNwf8hDAi4SPedPoMBd1NaFp9NOMFCm5S+7T7EvUbycXXZTRmoKREXRy4QLfKDwuGa49OaVBC9g1MAHtz2TduGujlq0u/kDRJLQuprKgEF2UoPvQvqXAJ0Oy67wjqJpAoesWCFRnpnrwUCgMosKwV9dFDiAyF0fF51QH3vbXqqLHNA/VIQODfSLmjn9VeMZuu/Ujj2z9dVDPQ0/Hy/QigWwTvJfMORlJv/VUSqiMQfx8C8+uvwx2pu80ybEzbCeR0U6d9d0HjcoFQ4b9QJH98dfwznKBc1jFz9ZVR1yqiSJRumeBIa6+LJjahMKBVYHGH7uif4YvPZaitq1ueGZOgpYKy7xFvORpugwCdM1rzj6POd5oQqYIkPxOPI6GbfjXjDIaynZkysDT0kcBgG0E4H7f/n6g8NohPiTNRcdlWXucockhog/FDvhZrLyLXeHywBm0ZB6szBiQly6Iw3OpyaQFWz9Vk2ByXp5v2OOKXQ8dMhbxc9UuCVwcK3D6JosqwDbSH/M+Lnj8Og3ykLEgzq4/pBd1DSGYv6cDyrWsQPZmOvf34o85rXXdLGk6+HlQ/xPccK3JohJ0CLgVAdK/rh4iPVs3w1G5u7YwvnRiJ+X/FixaqrjHqgLoiBF6WC7LHHxaSccepW1IeaVnRSWbFD8ADPVbmcBVhicc7WZuhahnF/H5UNCRXUpblomtQ+wOoPJl+Z9QHh+L95bFuLJ9mBKBmHH4QESXWqg5qZJs13h7pGJfIfku8gMXimi6a+Cocdg=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c21846c-0af0-4cc6-79e6-08d8916ee0d3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 18:21:07.9189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyuoUoVfhAJk4wYNmI9tF+k3gdU3SPNmlHqXzW/WO34bIIETYGUZJCnAsnRaHAFi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2438
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_11:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=5
 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 25, 2020 at 12:39:56PM +0100, Bruno Prémont wrote:
> Hello,
> 
> On a production system I've encountered a rather harsh behavior from
> kernel in the context of memory cgroup (v2) after updating kernel from
> 5.7 series to 5.9 series.
> 
> 
> It seems like kernel is reclaiming file cache but leaving inode cache
> (reclaimable slabs) alone in a way that the server ends up trashing and
> maxing out on IO to one of its disks instead of doing actual work.
> 
> 
> My setup, server has 64G of RAM:
>   root
>    + system        { min=0, low=128M, high=8G, max=8G }
>      + base        { no specific constraints }
>      + backup      { min=0, low=32M, high=2G, max=2G }
>      + shell       { no specific constraints }
>   + websrv         { min=0, low=4G, high=32G, max=32G }
>   + website        { min=0, low=16G, high=40T, max=40T }
>     + website1     { min=0, low=64M, high=2G, max=2G }
>     + website2     { min=0, low=64M, high=2G, max=2G }
>       ...
>   + remote         { min=0, low=1G, high=14G, max=14G }
>     + webuser1     { min=0, low=64M, high=2G, max=2G }
>     + webuser2     { min=0, low=64M, high=2G, max=2G }
>       ...
> 
> 
> When the server was struggling I've had mostly IO on disk hosting
> system processes and some cache files of websrv processes.
> It seems that running backup does make the issue much more probable.
> 
> The processes in websrv are the most impacted by the trashing and this
> is the one with lots of disk cache and inode cache assigned to it.
> (note a helper running in websrv cgroup scan whole file system
> hierarchy once per hour and this keeps inode cache pretty filled.
> Dropping just file cache (about 10G) did not unlock situation but
> dropping reclaimable slabs (inode cache, about 30G) got the system back
> running.
> 
> 
> 
> Some metrics I have collected during a trashing period (metrics
> collected at about 5min interval) - I don't have ful memory.stat
> unfortunately:
> 
> system/memory.min              0              = 0
> system/memory.low              134217728      = 134217728
> system/memory.high             8589934592     = 8589934592
> system/memory.max              8589934592     = 8589934592
> system/memory.pressure
>     some avg10=54.41 avg60=59.28 avg300=69.46 total=7347640237
>     full avg10=27.45 avg60=22.19 avg300=29.28 total=3287847481
>   ->
>     some avg10=77.25 avg60=73.24 avg300=69.63 total=7619662740
>     full avg10=23.04 avg60=25.26 avg300=27.97 total=3401421903
> system/memory.current          262533120      < 263929856
> system/memory.events.local
>     low                        5399469        = 5399469
>     high                       0              = 0
>     max                        112303         = 112303
>     oom                        0              = 0
>     oom_kill                   0              = 0
> 
> system/base/memory.min         0              = 0
> system/base/memory.low         0              = 0
> system/base/memory.high        max            = max
> system/base/memory.max         max            = max
> system/base/memory.pressure
>     some avg10=18.89 avg60=20.34 avg300=24.95 total=5156816349
>     full avg10=10.90 avg60=8.50 avg300=11.68 total=2253916169
>   ->
>     some avg10=33.82 avg60=32.26 avg300=26.95 total=5258381824
>     full avg10=12.51 avg60=13.01 avg300=12.05 total=2301375471
> system/base/memory.current     31363072       < 32243712
> system/base/memory.events.local
>     low                        0              = 0
>     high                       0              = 0
>     max                        0              = 0
>     oom                        0              = 0
>     oom_kill                   0              = 0
> 
> system/backup/memory.min       0              = 0
> system/backup/memory.low       33554432       = 33554432
> system/backup/memory.high      2147483648     = 2147483648
> system/backup/memory.max       2147483648     = 2147483648
> system/backup/memory.pressure
>     some avg10=41.73 avg60=45.97 avg300=56.27 total=3385780085
>     full avg10=21.78 avg60=18.15 avg300=25.35 total=1571263731
>   ->
>     some avg10=60.27 avg60=55.44 avg300=54.37 total=3599850643
>     full avg10=19.52 avg60=20.91 avg300=23.58 total=1667430954
> system/backup/memory.current  222130176       < 222543872
> system/backup/memory.events.local
>     low                       5446            = 5446
>     high                      0               = 0
>     max                       0               = 0
>     oom                       0               = 0
>     oom_kill                  0               = 0
> 
> system/shell/memory.min       0               = 0
> system/shell/memory.low       0               = 0
> system/shell/memory.high      max             = max
> system/shell/memory.max       max             = max
> system/shell/memory.pressure
>     some avg10=0.00 avg60=0.12 avg300=0.25 total=1348427661
>     full avg10=0.00 avg60=0.04 avg300=0.06 total=493582108
>   ->
>     some avg10=0.00 avg60=0.00 avg300=0.06 total=1348516773
>     full avg10=0.00 avg60=0.00 avg300=0.00 total=493591500
> system/shell/memory.current  8814592          < 8888320
> system/shell/memory.events.local
>     low                      0                = 0
>     high                     0                = 0
>     max                      0                = 0
>     oom                      0                = 0
>     oom_kill                 0                = 0
> 
> website/memory.min           0                = 0
> website/memory.low           17179869184      = 17179869184
> website/memory.high          45131717672960   = 45131717672960
> website/memory.max           45131717672960   = 45131717672960
> website/memory.pressure
>     some avg10=0.00 avg60=0.00 avg300=0.00 total=415009408
>     full avg10=0.00 avg60=0.00 avg300=0.00 total=201868483
>   ->
>     some avg10=0.00 avg60=0.00 avg300=0.00 total=415009408
>     full avg10=0.00 avg60=0.00 avg300=0.00 total=201868483
> website/memory.current       11811520512      > 11456942080
> website/memory.events.local
>     low                      11372142         < 11377350
>     high                     0                = 0
>     max                      0                = 0
>     oom                      0                = 0
>     oom_kill                 0                = 0
> 
> remote/memory.min            0
> remote/memory.low            1073741824
> remote/memory.high           15032385536
> remote/memory.max            15032385536
> remote/memory.pressure
>     some avg10=0.00 avg60=0.25 avg300=0.50 total=2017364408
>     full avg10=0.00 avg60=0.00 avg300=0.01 total=738071296
>   ->
> remote/memory.current        84439040         > 81797120
> remote/memory.events.local
>     low                      11372142         < 11377350
>     high                     0                = 0
>     max                      0                = 0
>     oom                      0                = 0
>     oom_kill                 0                = 0
> 
> websrv/memory.min            0                = 0
> websrv/memory.low            4294967296       = 4294967296
> websrv/memory.high           34359738368      = 34359738368
> websrv/memory.max            34426847232      = 34426847232
> websrv/memory.pressure
>     some avg10=40.38 avg60=62.58 avg300=68.83 total=7760096704
>     full avg10=7.80 avg60=10.78 avg300=12.64 total=2254679370
>   ->
>     some avg10=89.97 avg60=83.78 avg300=72.99 total=8040513640
>     full avg10=11.46 avg60=11.49 avg300=11.47 total=2300116237
> websrv/memory.current        18421673984      < 18421936128
> websrv/memory.events.local
>     low                      0                = 0
>     high                     0                = 0
>     max                      0                = 0
>     oom                      0                = 0
>     oom_kill                 0                = 0
> 
> 
> 
> Is there something important I'm missing in my setup that could prevent
> things from starving?
> 
> Did memory.low meaning change between 5.7 and 5.9? From behavior it
> feels as if inodes are not accounted to cgroup at all and kernel pushes
> cgroups down to their memory.low by killing file cache if there is not
> enough free memory to hold all promises (and not only when a cgroup
> tries to use up to its promised amount of memory).
> As system was trashing as much with 10G of file cache dropped
> (completely unused memory) as with it in use.
> 
> 
> I will try to create a test-case for it to reproduce it on a test
> machine an be able to verify a fix or eventually bisect to triggering
> patch though it this all rings a bell, please tell!
> 
> Note until I have a test-case I'm reluctant to just wait [on
> production system] for next occurrence (usually at unpractical times) to
> gather some more metrics.

Hi Bruno!

Thank you for the report.

Can you, please, check if the following patch fixes the issue?

Thanks!

--

diff --git a/mm/slab.h b/mm/slab.h
index 6cc323f1313a..ef02b841bcd8 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -290,7 +290,7 @@ static inline struct obj_cgroup *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 
        if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s))) {
                obj_cgroup_put(objcg);
-               return NULL;
+               return (struct obj_cgroup *)-1UL;
        }
 
        return objcg;
@@ -501,9 +501,13 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
                return NULL;
 
        if (memcg_kmem_enabled() &&
-           ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
+           ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT))) {
                *objcgp = memcg_slab_pre_alloc_hook(s, size, flags);
 
+               if (unlikely(*objcgp == (struct obj_cgroup *)-1UL))
+                       return NULL;
+       }
+
        return s;
 }
 
