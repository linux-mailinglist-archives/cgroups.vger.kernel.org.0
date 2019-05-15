Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FA51F7E6
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2019 17:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfEOPnL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 May 2019 11:43:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58618 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbfEOPnK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 May 2019 11:43:10 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FFT5CL012739;
        Wed, 15 May 2019 08:42:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=TlXDeJMRdkJ4Uwpc3adOfyTNz5a5KP+loB1W2f/SP/c=;
 b=UKx7ZdNiXg29iWe/+yAgOdoof9JSwauqu9rl8MbC7ROA8svkFEFOXqUp2oiaOf1thnqq
 RIr8rABWBovO1lIF1mR4FtXxN4li+v8CjybQ5TOjrxLVZlcmVayhi3VH7OZ/ZM+rBc3G
 YAacjPWwvB3/a+JRqPmYX+3YHv6s24VUoSE= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sgbw09snq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 15 May 2019 08:42:32 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 15 May 2019 08:42:31 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 15 May 2019 08:42:30 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 15 May 2019 08:42:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlXDeJMRdkJ4Uwpc3adOfyTNz5a5KP+loB1W2f/SP/c=;
 b=Jd/UihbZNrhJhyLxazMRFz9MfvuWkFwHzoOWziMR08UdXc7DxOFnxUUyuB+O2nC2jfuhmoEJUgBRzbmjFgF6blZZ1npq1aRqMBqrogp/8Ik947Unx8HL/v+XZMbfsDCLigNfhnjXdhI191/45mB2nIAg2mQB7WhCgZvckQbGZ/E=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1663.namprd15.prod.outlook.com (10.175.141.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 15:42:29 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 15:42:29 +0000
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
Thread-Index: AQHU7lSD68FtcB4UGUOYupgC9AfmOKY1TPCAgACBxACACo6VgIAIioaAgAkx7ACAARa2gIABKdKAgACqaACAAAlcAIAP0BQAgAZ0zoCAAN+MgIAAWnsA
Date:   Wed, 15 May 2019 15:42:29 +0000
Message-ID: <61F85297-8A31-42A7-AF99-324AF8AFCE18@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
 <20190410115907.GE19434@e105550-lin.cambridge.arm.com>
 <A2E9A149-9EAA-478D-A096-1D4D4BA442B3@fb.com>
 <CAKfTPtAFB3gSZYJN1BcjU_XoY=Pfu2xtea+2MEw7FkVc3mwTSA@mail.gmail.com>
 <E97E73F4-CE8C-4CD7-B6B6-5F63A4E881B1@fb.com>
 <F0A127DD-F9B6-4FBE-B9AD-8E8B00A7D676@fb.com>
 <CAKfTPtA_ouYCes9LnYn0quAKm273mi3vP-++GTBtYcQn07xc6Q@mail.gmail.com>
 <A62E5068-4A1E-44E3-99BB-02E98229C1E2@fb.com>
 <CAKfTPtAG3v=37wyLjzkNNK_6HdoMK6WO7AMYfa+G24rq2iyAfg@mail.gmail.com>
 <19AF6556-A2A2-435B-9358-CD22CF7BFD9F@fb.com>
 <2E7A1CDA-0384-474E-9011-5B209A1A58DF@fb.com>
 <0C1325C9-DE18-42C6-854D-64433ABD6FC3@fb.com>
 <CAKfTPtDxhjh0LsjgTwKhMMtFqhyDW6qtU-=9K1p-fCR6YLjxCQ@mail.gmail.com>
In-Reply-To: <CAKfTPtDxhjh0LsjgTwKhMMtFqhyDW6qtU-=9K1p-fCR6YLjxCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::3:7865]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23ba81cc-0a8c-4d8e-2d31-08d6d94bf011
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1663;
x-ms-traffictypediagnostic: MWHPR15MB1663:
x-microsoft-antispam-prvs: <MWHPR15MB1663964C591F3EF051E9660DB3090@MWHPR15MB1663.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(4326008)(305945005)(8676002)(68736007)(5660300002)(81156014)(50226002)(54906003)(2906002)(99286004)(316002)(7736002)(71200400001)(25786009)(71190400001)(14444005)(256004)(6116002)(83716004)(86362001)(8936002)(82746002)(36756003)(14454004)(486006)(102836004)(6486002)(64756008)(66946007)(2616005)(11346002)(446003)(76176011)(6512007)(33656002)(476003)(229853002)(81166006)(53546011)(6916009)(478600001)(66556008)(73956011)(66446008)(6506007)(66476007)(53936002)(6246003)(186003)(57306001)(76116006)(6436002)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1663;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WmuTJzVDP6EhqstyrcuTEztV6b/VLwl53tZbGHViZuCSFHMC9Dzzh2FsGHypexbv/b68JMfIXjideVcfr56BOiHwpdA9q6Bk0+wDQj+sl38wbbJX9Nv06iuAVR8OY5QggbmNnTQl0LsgiItsPeLl3JztogIA41zQyO+LGl72tXnnIMo0KlN3oP0bQLpWK+GObEMOOB05Uf+Yi/xgzCQFAEyct1B9UnQbO4uzarobap5uHUQ1zy3ESFBaYyfH0GWDwXOtyQDzDWgH33/DmSJc+4ijCaf9zBPjTVoy9PCiWN782jeYi/THHiRqNkyLBkFHj9whtiNTYT4v3xjeHkcBIPBCahcQNlCpftyZYytSvYrq2jn0ZfUoYU/+A/8TWGbZwomD92nUL/CW6z2CC7mRziONMSPBLR3/QVOOcMnsXdk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA6E44C6D36A944B83165EFB7A3F5407@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ba81cc-0a8c-4d8e-2d31-08d6d94bf011
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 15:42:29.1765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1663
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Vincent,

> On May 15, 2019, at 3:18 AM, Vincent Guittot <vincent.guittot@linaro.org>=
 wrote:
>=20
> Hi Song,
>=20
> On Tue, 14 May 2019 at 22:58, Song Liu <songliubraving@fb.com> wrote:
>>=20
>> Hi Vincent,
>>=20
>=20
> [snip]
>=20
>>>=20
>>> Here are some more results with both Viresh's patch and the cpu.headroo=
m
>>> set. In these tests, the side job runs with SCHED_IDLE, so we get benef=
it
>>> of Viresh's patch.
>>>=20
>>> We collected another metric here, average "cpu time" used by the reques=
ts.
>>> We also presented "wall time" and "wall - cpu" time. "wall time" is the
>>> same as "latency" in previous results. Basically, "wall time" includes =
cpu
>>> time, scheduling latency, and time spent waiting for data (from data ba=
se,
>>> memcache, etc.). We don't have good data that separates scheduling late=
ncy
>>> and time spent waiting for data, so we present "wall - cpu" time, which=
 is
>>> the sum of the two. Time spent waiting for data should not change in th=
ese
>>> tests, so changes in "wall - cpu" mostly comes from scheduling latency.
>>> All the latency numbers are normalized based on the "wall time" of the
>>> first row.
>>>=20
>>> side job | cpu.headroom |  cpu-idle | wall time | cpu time | wall - cpu
>>> -----------------------------------------------------------------------=
-
>>> none    |     n/a      |    42.4%  |   1.00    |   0.31   |   0.69
>>> ffmpeg   |       0      |    10.8%  |   1.17    |   0.38   |   0.79
>>> ffmpeg   |     25%      |    22.8%  |   1.08    |   0.35   |   0.73
>>>=20
>>> From these results, we can see that Viresh's patch reduces the latency
>>> overhead of the side job, from 42% (in previous results) to 17%. And
>>> a 25% cpu.headroom further reduces the latency overhead to 8%.
>>> cpu.headroom reduces time spent in "cpu time" and "wall - cpu" time,
>>> which means cpu.headroom yields better IPC and lower scheduling latency=
.
>>>=20
>>> I think these data demonstrate that
>>>=20
>>> 1. Viresh's work is helpful in reducing scheduling latency introduced
>>>    by SCHED_IDLE side jobs.
>>> 2. cpu.headroom work provides mechanism to further reduce scheduling
>>>    latency on top of Viresh's work.
>>>=20
>>> Therefore, the combination of the two work would give us mechanisms to
>>> control the latency overhead of side workloads.
>>>=20
>>> @Vincent, do these data and analysis make sense from your point of view=
?
>>=20
>> Do you have further questions/concerns with this set?
>=20
> Viresh's patchset takes into account CPU running only sched_idle task
> only for the fast wakeup path. But nothing special is (yet) done for
> the slow path or during idle load balance.
> The histogram that you provided for "Fallback to sched-idle CPU for
> better performance", shows that even if we have significantly reduced
> the long wakeup latency, there are still some wakeup latency evenly
> distributed in the range [16us-2msec]. Such values are most probably
> because of sched_other task doesn't always preempt sched_idle task and
> sometime waits for the next tick. This means that there are still
> margin for improving the results with sched_idle without adding a new
> knob.
> The headroom knob forces cpus to be idle from time to time and the
> scheduler fallbacks to the normal scheduling policy that tries to fill
> idle CPU in this case. I'm still not convinced that most of the
> increase of the latency increase is linked to contention when
> accessing shared resources.

I would like clarify that, we are not trying to convince that most of=20
the increase of the latency is from resource contention. Actually, we=20
also have data showing scheduling latency contributes more to the=20
latency overhead:

side job | cpu.headroom |  cpu-idle | wall time | cpu time | wall - cpu
------------------------------------------------------------------------
 none    |     n/a      |    42.4%  |   1.00    |   0.31   |   0.69
ffmpeg   |       0      |    10.8%  |   1.17    |   0.38   |   0.79
ffmpeg   |     25%      |    22.8%  |   1.08    |   0.35   |   0.73

Compared against first row, second row shows 17% of latency overhead=20
(wall time). Among this 17%, 7% is in the "cpu time" column, which=20
is from resource contention (lower IPC). The other 10% (wall - cpu) is
mostly from scheduling latency. These experiments already have Viresh's
current patch. Scheduling latency contributes more in the overall=20
latency w/o Viresh's patch.=20

So we agree that, in this case, most of the increased latency comes=20
from scheduling latency.=20

However, we still think cpu.headroom would add value. The following=20
table shows comparison of ideal cases, where we totally eliminated the=20
overhead of scheduling latency.=20

side job | cpu.headroom |  cpu-idle | wall time | cpu time | wall - cpu
------------------------------------------------------------------------
 none    |     n/a      |    42.4%  |   1.00    |   0.31   |   0.69
------------------------------------------------------------------------
        below are all from estimation, not from experiments
------------------------------------------------------------------------
ffmpeg   |       0      |     TBD   |   1.07    |   0.38   |   0.69
ffmpeg   |     25%      |     TBD   |   1.04    |   0.35   |   0.69

We can see, cpu.headroom helps control latency even with ideal scheduling.=
=20
The saving here (from 7% overhead to 4%) is not as significant. But it is
still meaningful in some cases.=20
=20
More important, cpu.headroom gives us mechanism to control the latency
overhead. It is a _protection_ mechanism, not some optimization. It is=20
somehow similar to current cpu.max knob, which limits the max cpu usage
of certain workload. cpu.headroom is more flexible than cpu.max, because
cpu.headroom could adjust the limits based on system load level dynamically=
.=20

Does this explanation make sense?

Thanks,
Song

