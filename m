Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B59F056
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2019 08:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfD3GLY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Apr 2019 02:11:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33702 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725788AbfD3GLY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Apr 2019 02:11:24 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3U63pFe019772;
        Mon, 29 Apr 2019 23:10:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=gRgkygZzBGln/G/Zh+guVByvS/trVR9H02ChKFnZOaw=;
 b=i0VpaIhIoraLiaJ0U52b0KfPuKaEXisMLacY7goxtCVqvFhJTz/7XRpS5q5K/ARVOupq
 T9E3gWhR8tMIcXAMCeojYc75GaMGCfGJ2svCQY3Dj6WT6Djt8dscOPWAbpGZRUKS5VUm
 nZJu04844ffUxhQJ67ruYthEuywebl03blA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2s69fk14k2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Apr 2019 23:10:57 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 29 Apr 2019 23:10:56 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 29 Apr 2019 23:10:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRgkygZzBGln/G/Zh+guVByvS/trVR9H02ChKFnZOaw=;
 b=cjRHWy9QHlXAsOZXbVsBBhUsJu4r//kyS7bbipv11vQVUFqI1Fp7FtnTD3CaLZ4FLkj1xS4bw6FguSOuzrznZwFwUv5Id1yuy0JI41S2p9ce8hq+OFKGlhYP8yx5H4Dy1GB48q7y5acfERzZcBSPU3AGlfnIiugeRcuIuuI2SRE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1727.namprd15.prod.outlook.com (10.174.254.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 30 Apr 2019 06:10:53 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%10]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 06:10:53 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Kernel Team <Kernel-team@fb.com>,
        viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Topic: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Index: AQHU7lSD68FtcB4UGUOYupgC9AfmOKY1TPCAgACBxACACo6VgIAIioaAgAkx7ACAARa2gIABKdKA
Date:   Tue, 30 Apr 2019 06:10:52 +0000
Message-ID: <A62E5068-4A1E-44E3-99BB-02E98229C1E2@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
 <20190410115907.GE19434@e105550-lin.cambridge.arm.com>
 <A2E9A149-9EAA-478D-A096-1D4D4BA442B3@fb.com>
 <CAKfTPtAFB3gSZYJN1BcjU_XoY=Pfu2xtea+2MEw7FkVc3mwTSA@mail.gmail.com>
 <E97E73F4-CE8C-4CD7-B6B6-5F63A4E881B1@fb.com>
 <F0A127DD-F9B6-4FBE-B9AD-8E8B00A7D676@fb.com>
 <CAKfTPtA_ouYCes9LnYn0quAKm273mi3vP-++GTBtYcQn07xc6Q@mail.gmail.com>
In-Reply-To: <CAKfTPtA_ouYCes9LnYn0quAKm273mi3vP-++GTBtYcQn07xc6Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c091:180::25e5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82facd73-77f4-4447-4606-08d6cd3299c4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1727;
x-ms-traffictypediagnostic: MWHPR15MB1727:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB17278328DD68CC7D2375D3B8B33A0@MWHPR15MB1727.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(39860400002)(346002)(199004)(189003)(54014002)(51914003)(561944003)(2906002)(478600001)(71190400001)(68736007)(71200400001)(86362001)(83716004)(6116002)(33656002)(36756003)(82746002)(966005)(186003)(14454004)(4326008)(50226002)(446003)(66446008)(57306001)(53546011)(6506007)(11346002)(54906003)(97736004)(229853002)(66476007)(66946007)(81156014)(93886005)(8676002)(76176011)(8936002)(81166006)(53936002)(6246003)(14444005)(256004)(316002)(6486002)(6512007)(64756008)(73956011)(102836004)(6916009)(66556008)(6306002)(25786009)(486006)(2616005)(76116006)(7736002)(91956017)(305945005)(476003)(6436002)(5660300002)(99286004)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1727;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: le7jHbOw20GlvzoO2RsgOPnyFGEEcZ76bfN4HFC0nG1Y5fWlSi5GyrvNdDeguH76mYQj2xDPuPOtKA+meS2XRmxPAO7zi+nHJwtEWX2XaimnKbPQX/yZF7iWWdlCryP8ly6YK3p6D2uS5smKBOPGi/FdifNZZUtaaiBFVpTE/vqiO6FHkn59Xqg0hx/j6azpEH5Zcey4R/LJ0L6OPIV2JLyUkhARJomHJrhjTLbl0jxALX8XZ12S1bWFD78W94HI91EN1Xc7cboJWrlbWJIxTi/hS2UJYUeJTTg3wxcD59R7p6TuTaTen9RaVrbh5VhvCFLw99+G2k825vC/h8jqh3KsvhBPC5o1iZiqYdJg3A/Ftp3PI10eQWRZhyJMq/UfbQTJvn0F+eKI3ofJfYB3ouqClmvwitdZyg2ZJ48XyOc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A68FE30862D0884AAC470CC176BAE0D9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82facd73-77f4-4447-4606-08d6cd3299c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 06:10:52.9658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1727
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-30_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904300041
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Apr 29, 2019, at 8:24 AM, Vincent Guittot <vincent.guittot@linaro.org>=
 wrote:
>=20
> Hi Song,
>=20
> On Sun, 28 Apr 2019 at 21:47, Song Liu <songliubraving@fb.com> wrote:
>>=20
>> Hi Morten and Vincent,
>>=20
>>> On Apr 22, 2019, at 6:22 PM, Song Liu <songliubraving@fb.com> wrote:
>>>=20
>>> Hi Vincent,
>>>=20
>>>> On Apr 17, 2019, at 5:56 AM, Vincent Guittot <vincent.guittot@linaro.o=
rg> wrote:
>>>>=20
>>>> On Wed, 10 Apr 2019 at 21:43, Song Liu <songliubraving@fb.com> wrote:
>>>>>=20
>>>>> Hi Morten,
>>>>>=20
>>>>>> On Apr 10, 2019, at 4:59 AM, Morten Rasmussen <morten.rasmussen@arm.=
com> wrote:
>>>>>>=20
>>>>=20
>>>>>>=20
>>>>>> The bit that isn't clear to me, is _why_ adding idle cycles helps yo=
ur
>>>>>> workload. I'm not convinced that adding headroom gives any latency
>>>>>> improvements beyond watering down the impact of your side jobs. AFAI=
K,
>>>>>=20
>>>>> We think the latency improvements actually come from watering down th=
e
>>>>> impact of side jobs. It is not just statistically improving average
>>>>> latency numbers, but also reduces resource contention caused by the s=
ide
>>>>> workload. I don't know whether it is from reducing contention of ALUs=
,
>>>>> memory bandwidth, CPU caches, or something else, but we saw reduced
>>>>> latencies when headroom is used.
>>>>>=20
>>>>>> the throttling mechanism effectively removes the throttled tasks fro=
m
>>>>>> the schedule according to a specific duty cycle. When the side job i=
s
>>>>>> not throttled the main workload is experiencing the same latency iss=
ues
>>>>>> as before, but by dynamically tuning the side job throttling you can
>>>>>> achieve a better average latency. Am I missing something?
>>>>>>=20
>>>>>> Have you looked at your distribution of main job latency and tried t=
o
>>>>>> compare with when throttling is active/not active?
>>>>>=20
>>>>> cfs_bandwidth adjusts allowed runtime for each task_group each period
>>>>> (configurable, 100ms by default). cpu.headroom logic applies gentle
>>>>> throttling, so that the side workload gets some runtime in every peri=
od.
>>>>> Therefore, if we look at time window equal to or bigger than 100ms, w=
e
>>>>> don't really see "throttling active time" vs. "throttling inactive ti=
me".
>>>>>=20
>>>>>>=20
>>>>>> I'm wondering if the headroom solution is really the right solution =
for
>>>>>> your use-case or if what you are really after is something which is
>>>>>> lower priority than just setting the weight to 1. Something that
>>>>>=20
>>>>> The experiments show that, cpu.weight does proper work for priority: =
the
>>>>> main workload gets priority to use the CPU; while the side workload o=
nly
>>>>> fill the idle CPU. However, this is not sufficient, as the side workl=
oad
>>>>> creates big enough contention to impact the main workload.
>>>>>=20
>>>>>> (nearly) always gets pre-empted by your main job (SCHED_BATCH and
>>>>>> SCHED_IDLE might not be enough). If your main job consist
>>>>>> of lots of relatively short wake-ups things like the min_granularity
>>>>>> could have significant latency impact.
>>>>>=20
>>>>> cpu.headroom gives benefits in addition to optimizations in pre-empt
>>>>> side. By maintaining some idle time, fewer pre-empt actions are
>>>>> necessary, thus the main workload will get better latency.
>>>>=20
>>>> I agree with Morten's proposal, SCHED_IDLE should help your latency
>>>> problem because side job will be directly preempted unlike normal cfs
>>>> task even lowest priority.
>>>> In addition to min_granularity, sched_period also has an impact on the
>>>> time that a task has to wait before preempting the running task. Also,
>>>> some sched_feature like GENTLE_FAIR_SLEEPERS can also impact the
>>>> latency of a task.
>>>>=20
>>>> It would be nice to know if the latency problem comes from contention
>>>> on cache resources or if it's mainly because you main load waits
>>>> before running on a CPU
>>>>=20
>>>> Regards,
>>>> Vincent
>>>=20
>>> Thanks for these suggestions. Here are some more tests to show the impa=
ct
>>> of scheduler knobs and cpu.headroom.
>>>=20
>>> side-load | cpu.headroom | side/cpu.weight | min_gran | cpu-idle | main=
/latency
>>> -----------------------------------------------------------------------=
---------
>>> none    |      0       |     n/a         |    1 ms  |  45.20%  |   1.00
>>> ffmpeg   |      0       |      1          |   10 ms  |   3.38%  |   1.4=
6
>>> ffmpeg   |      0       |   SCHED_IDLE    |    1 ms  |   5.69%  |   1.4=
2
>>> ffmpeg   |    20%       |   SCHED_IDLE    |    1 ms  |  19.00%  |   1.1=
3
>>> ffmpeg   |    30%       |   SCHED_IDLE    |    1 ms  |  27.60%  |   1.0=
8
>>>=20
>>> In all these cases, the main workload is loaded with same level of
>>> traffic (request per second). Main workload latency numbers are normali=
zed
>>> based on the baseline (first row).
>>>=20
>>> For the baseline, the main workload runs without any side workload, the
>>> system has about 45.20% idle CPU.
>>>=20
>>> The next two rows compare the impact of scheduling knobs cpu.weight and
>>> sched_min_granularity. With cpu.weight of 1 and min_granularity of 10ms=
,
>>> we see a latency of 1.46; with SCHED_IDLE and min_granularity of 1ms, w=
e
>>> see a latency of 1.42. So SCHED_IDLE and min_granularity help protectin=
g
>>> the main workload. However, it is not sufficient, as the latency overhe=
ad
>>> is high (>40%).
>>>=20
>>> The last two rows show the benefit of cpu.headroom. With 20% headroom,
>>> the latency is 1.13; while with 30% headroom, the latency is 1.08.
>>>=20
>>> We can also see a clear correlation between latency and global idle CPU=
:
>>> more idle CPU yields better lower latency.
>>>=20
>>> Over all, these results show that cpu.headroom provides effective
>>> mechanism to control the latency impact of side workloads. Other knobs
>>> could also help the latency, but they are not as effective and flexible
>>> as cpu.headroom.
>>>=20
>>> Does this analysis address your concern?
>=20
> So, you results show that sched_idle class doesn't provide the
> intended behavior because it still delay the scheduling of sched_other
> tasks. In fact, the wakeup path of the scheduler doesn't make any
> difference between a cpu running a sched_other and a cpu running a
> sched_idle when looking for the idlest cpu and it can create some
> contentions between sched_other tasks whereas a cpu runs sched_idle
> task.

I don't think scheduling delay is the only (or dominating) factor of=20
extra latency. Here are some data to show it.=20

I measured IPC (instructions per cycle) of the main workload under=20
different scenarios:

side-load | cpu.headroom | side/cpu.weight  | IPC  =20
----------------------------------------------------
 none     |     0%       |       N/A        | 0.66=20
 ffmpeg   |     0%       |    SCHED_IDLE    | 0.53=20
 ffmpeg   |    20%       |    SCHED_IDLE    | 0.58=20
 ffmpeg   |    30%       |    SCHED_IDLE    | 0.62=20

These data show that the side workload has a negative impact on the=20
main workload's IPC. And cpu.headroom could help reduce this impact. =20

Therefore, while optimizations in the wakeup path should help the=20
latency; cpu.headroom would add _significant_ benefit on top of that.=20

Does this assessment make sense?=20


> Viresh (cced to this email) is working on improving such behavior at
> wake up and has sent an patch related to the subject:
> https://lkml.org/lkml/2019/4/25/251
> I'm curious if this would improve the results.

I could try it with our workload next week (I am at LSF/MM this=20
week). Also, please keep in mind that this test sometimes takes=20
multiple days to setup and run.=20

Thanks,
Song

>=20
> Regards,
> Vincent
>=20
>>>=20
>>> Thanks,
>>> Song
>>>=20
>>=20
>> Could you please share your comments and suggestions on this work? Did
>> the results address your questions/concerns?
>>=20
>> Thanks again,
>> Song
>>=20
>>>>=20
>>>>>=20
>>>>> Thanks,
>>>>> Song
>>>>>=20
>>>>>>=20
>>>>>> Morten

