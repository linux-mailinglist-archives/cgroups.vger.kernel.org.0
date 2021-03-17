Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5D433FB2C
	for <lists+cgroups@lfdr.de>; Wed, 17 Mar 2021 23:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhCQW3I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Mar 2021 18:29:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54346 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCQW2s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Mar 2021 18:28:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HMO9q9192389;
        Wed, 17 Mar 2021 22:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=TH6wlzcCPWtIAtCjIQQeR6qoAZ/h/vMMRA5cV1RoqlM=;
 b=Co5tePda7Zj+SjqRUU0jFLHZavEIWbBdmriYVwSAUbDZbpREbP0nV7gPhr5DmQjef+/+
 ZDAbKBp2ufM5/mwGYZPSn33VGDiJT+RKaqsGxGTGFiSgPwAATQAA8frT7tZFsCmbg46h
 esq4LaGXTlV3J7iCcUxeGObWQt2Cf+lEDHNRQE4tlMlZ4Rwq4KqU8cjRB4/ogb6RvGtr
 i1WEl6whNToq+1n3PbhbkqUMvqluawsPX6h0H6agHeiZ9tJBI6pEoYLajqMhwKZlOinP
 Kg+OIldQmGOfV4J9NiqP59CaNRafQQVLnDyiEg2ZwHo0iITeteJCgGFTGUKmosmhkW/b 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 378jwbnsjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 22:25:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HMFqMX026239;
        Wed, 17 Mar 2021 22:25:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3797a358cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 22:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyeCEus8f+YvnvOA7GOH0wxJvEJBtdZnOJIuF7PeNDRTvGHa4cQk3OUDEiOosO8IZLfx7GMxWPPqxguFuCU9bzbY77OsTXqpqDkBvJIsYbRhVVBlCjq4V/w+TulByZI4AMz0lj49d9itW+z3XSJ/saZYEaY8t9tj9tW7w+MysRWhKN98G/2zxxYOWEzs5EecpqZxu4H++cLB18BNCOqIPhSfg3UGewSCwY9qTTNf1dGKNNJ0SxtOxRDTt0efKT8bP/rkKpBgvppGSzJmvmSEpXTyYKHWuPr7Q0GH3tErPeA4hjIJwtRHGErafW5NM8RRkFKD3ofgoEHeJnR0lE6NtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TH6wlzcCPWtIAtCjIQQeR6qoAZ/h/vMMRA5cV1RoqlM=;
 b=PxKhO46+3MpdCwCCkh64f7r4kEzuyZELlc+b1UNUd4orR1Q88/Ue3EaIcU5qUqN72nWE3EqnM/TpuxYfkZl7kBrgeNZFtXpP6ermb6Lb8izD6vrNSZ2iw8DSId7W71livFb/BKhGDc2Iz1urOYw+wFPKaZcIrjZ/jmgJZX2LX//6/90mYrKTMEOKgBHFXLOofICFKoGhWq8a2fLc9szwFliPIh1rgXJ1QvBq+fv1jHV+sSJjITgrqy5JCwEB5XAUBOv8HlCWzLtz/U7IxNhqAWWHC9Ow0EVsGTMqb3kwgf8YbIqMKvlS/FYFgdtPXiPVEBsn/t9qdd9UrsphnukMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TH6wlzcCPWtIAtCjIQQeR6qoAZ/h/vMMRA5cV1RoqlM=;
 b=tedqUrgaGs92xvt+gNwN941uXVHhL5htHWTHStTsXmvIsM/tof9mSIrnZvi+cR6IlD+KCRzQLyIyjlfCPx7vaOZLOw0bGotO9yA6NWju4k2hSX9FQZw44MmeUgLTc2mx73ACjT+shqmkABS5c1MeMfXwyfbLV/Te3ZBLRRcabJ4=
Authentication-Results: yandex-team.com; dkim=none (message not signed)
 header.d=none;yandex-team.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1774.namprd10.prod.outlook.com (2603:10b6:301:9::13)
 by MWHPR10MB1728.namprd10.prod.outlook.com (2603:10b6:301:9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 22:25:17 +0000
Received: from MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::24eb:1300:dd70:4183]) by MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::24eb:1300:dd70:4183%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 22:25:17 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Andrey Ryabinin <arbn@yandex-team.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Boris Burkov <boris@bur.io>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <arbn@yandex-team.com>
Subject: Re: [PATCH 4/4] sched/cpuacct: Make user/system times in
 cpuacct.stat more precise
In-Reply-To: <20210217120004.7984-4-arbn@yandex-team.com>
References: <20210217120004.7984-1-arbn@yandex-team.com>
 <20210217120004.7984-4-arbn@yandex-team.com>
Date:   Wed, 17 Mar 2021 18:25:13 -0400
Message-ID: <87o8fhl8om.fsf@oracle.com>
Content-Type: text/plain
X-Originating-IP: [98.229.125.203]
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To MWHPR10MB1774.namprd10.prod.outlook.com
 (2603:10b6:301:9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from parnassus (98.229.125.203) by MN2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:208:1a0::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 22:25:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e15f62e-3c9b-40f2-3170-08d8e9938ac2
X-MS-TrafficTypeDiagnostic: MWHPR10MB1728:
X-Microsoft-Antispam-PRVS: <MWHPR10MB17282A094CA3EC154F332958D96A9@MWHPR10MB1728.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8r1iemy4ZzX44SxLIcdxcqBL+2LQipBPVXbnEGcby3MpXM4ESi7ZPADeR4cA5QAeZD6Ouq/H/TvayFu8HD1rsahtJmvXOXZ4Kt4Vej+ZyBf0n/FzvnnegzBn3jACrN6o4gVg/NKwB6CZMPKGp+pyPlfdq3yYr1hkTTuBZP1YbmoWd/yUmrtIGrLfUfPDB87wdbQrLNeK2/SxLvpN4bs8fIbwTqhQBEqPOckBtmrA70xnzafRlBRFL5VxOY/EyB2vd1jFy+Dk7O0EAK6NKWq9Xq1f1O2euwoaIojzYqpkMNqumyMZzsrKXyvIrHbWxDD4aW90aCIFaDkNsMYPnfOhc79sLqKqk3fTT37g5UmzrV6q6HlGiHeKoNDUL+7h8obkosoF5mWBkOElZdtnFYZ/nn6i03L/yoIitfoxYBWyuHrQWs05TZNteL8B3jz/eouhrpFjrKXc6exaBKAcKJzGY9lYkX7SttBvr+w3gzzqm5b8xGt0vfZ9OLEx98aaASbFXXB2WiYJkudaCUil1k9Sq84X2PbTSgX4IHcrISbNjK7zZvSAGoVsxsXnSMZXhbPF2jsUSeiD9j3cz/7RAsAh9/nsIDcnu+7fU77/Bzc3kpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1774.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(366004)(396003)(5660300002)(54906003)(110136005)(8936002)(66476007)(6486002)(66946007)(4326008)(6496006)(2906002)(921005)(66556008)(316002)(86362001)(36756003)(186003)(26005)(16526019)(52116002)(8676002)(478600001)(4744005)(956004)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nhdGYSA/S6KNH5WXW/F6+05SGGRzrylOqRmpKwKwMMoTxOxzeTRjiTr9lPuR?=
 =?us-ascii?Q?ovwd36MvEqq4MYBS2xRxT/eDP3NNAvys12LMloUfaoJAXZLfwPep1ulOiAu4?=
 =?us-ascii?Q?yVKCCm6lDib2GJX2LUGR2xPjWl3qOzzv9isI5sHz6lJdiy/VwvSrW3ZajqfR?=
 =?us-ascii?Q?tCnYI6ia6/iD3XhvkwkQzdSZGFuWMFLUUamlVjmHDzR3ICw+/x4FXp/GGGt1?=
 =?us-ascii?Q?lQxL5lahfROHRKzdlosbntyiLL8uKsR2BNoo9LK0AgldNqyYoT8Ck2FSI1sr?=
 =?us-ascii?Q?uAeCF1Gq9Lb2LGUKt/d5q8pd9lHEZ/rvmC+M6Sr/2rNm1jz7HpYpuf7Gl7Bo?=
 =?us-ascii?Q?+PaoVdj1IuDUUK2cWriMdODAs872O2V81goWqhvLg7Af3K3t6esxT+RhjKA4?=
 =?us-ascii?Q?nCPeVKau7QMHq3iLUpK4OHOV5bp+i9FBWQWtwZ62Uqe0L0XIgvqDA7zYtWnG?=
 =?us-ascii?Q?OwOLecDhCxkxnRW+VI9kZvR5e/klvDO5SQczYU2bZPPWqLWEYXnB5KL+6uIk?=
 =?us-ascii?Q?vEyuN9l8/I5oLObB3VzCA+8eMUpjlFMKwaZHH8HeFMo6N9R1LCGC4WWQREjo?=
 =?us-ascii?Q?Aho4uZ29fnIoxh7SfwoTx0W1bhmQZ4v/AQtXY0bTBNAtKlLPwBro6vOb/Ouk?=
 =?us-ascii?Q?2MFQIxUOvVhXazVFVvaHRfEmkTQR0msNYlB3MFYp/xY1iuci767xPngu0AT9?=
 =?us-ascii?Q?sZT3aQ7DItwA8Zhkgog6Dyo/5rConmmQlWc3xH4sjvmkvhEYpTpncVDHS72A?=
 =?us-ascii?Q?Nk+MYQW3yJZb3212LKWOnUgXINiGpVwbHgFpDzghHTR9csdI/g+wMWPEtu2F?=
 =?us-ascii?Q?h7L/uEz1KDSz6/MKuowJi8/rj6JTjV/vWEc+A6PFl2+ghf4n2X/hw7+HAJWD?=
 =?us-ascii?Q?T7ciHdssmsOcFgl6FWKIU/1lFQjiXQXATiuwrBUbOJgeZJeJFMSsofpgs515?=
 =?us-ascii?Q?VVycq+Oja6WwzhtQm/J73etz0rdRyeIRp9hPa9rfPkFZ3ocUocfVmLH9Q98r?=
 =?us-ascii?Q?jJkxq1OL6+IJ6Ju3jlWI8icuSOjEk9AxIJP7/vF4aQtVefPIFsZ5H/F412Ib?=
 =?us-ascii?Q?XM7iVjUq9booDJp2cR0CYRHC7XzlXuGyAaL4TRuq/oqLTZvLd5ovCcCXuvhl?=
 =?us-ascii?Q?4ftPPx4i0AWwAy+zTjWYA/INNkYFqdcHl8zKsImIKgR3AIDbC2vE6jk5IyFD?=
 =?us-ascii?Q?uO93gZ3Cokqv0xjE8A6hO7SWg93ezGPztXLX3I1R7RJQxx8cLcT9J0DtWi3n?=
 =?us-ascii?Q?lmqRizVW+hcfMpoV68AuzcvNfCRX7sJaJlusGoDdStNNakgocUUISMSd5WeS?=
 =?us-ascii?Q?JFOIUkNc/qkoT6X1zR6GTXq+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e15f62e-3c9b-40f2-3170-08d8e9938ac2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1774.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 22:25:17.2930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8IoUBZ0bMXO1bpKPw+W23gKQkg3XV/7ib/M9Ij+O+f5s1jPyTiV2wUk48p7V86JyRjeD0aXXlphVFUF/Ei+iQm0P3wTlvYubm6nZ1ZDztk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1728
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170156
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170157
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Andrey Ryabinin <arbn@yandex-team.com> writes:
>  static int cpuacct_stats_show(struct seq_file *sf, void *v)
>  {
        ...
>  	for_each_possible_cpu(cpu) {
>  		u64 *cpustat = per_cpu_ptr(ca->cpustat, cpu)->cpustat;
>  
> -		val[CPUACCT_STAT_USER] += cpustat[CPUTIME_USER];
> -		val[CPUACCT_STAT_USER] += cpustat[CPUTIME_NICE];
> -		val[CPUACCT_STAT_SYSTEM] += cpustat[CPUTIME_SYSTEM];
> -		val[CPUACCT_STAT_SYSTEM] += cpustat[CPUTIME_IRQ];
> -		val[CPUACCT_STAT_SYSTEM] += cpustat[CPUTIME_SOFTIRQ];
> +		cputime.utime += cpustat[CPUTIME_USER];
> +		cputime.utime += cpustat[CPUTIME_NICE];
> +		cputime.stime += cpustat[CPUTIME_SYSTEM];
> +		cputime.stime += cpustat[CPUTIME_IRQ];
> +		cputime.stime += cpustat[CPUTIME_SOFTIRQ];
> +
> +		cputime.sum_exec_runtime += this_cpu_read(*ca->cpuusage);
>  	}

                cputime.sum_exec_runtime += *per_cpu_ptr(ca->cpuusage, cpu);

Or the stats can all be 0...
