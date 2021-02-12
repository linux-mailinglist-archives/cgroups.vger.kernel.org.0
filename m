Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D2131A598
	for <lists+cgroups@lfdr.de>; Fri, 12 Feb 2021 20:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhBLTn3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Feb 2021 14:43:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47708 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhBLTn2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Feb 2021 14:43:28 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CJet4e127082;
        Fri, 12 Feb 2021 19:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=7l/HTcouzdCQubM+36EHWqvqjAfkWdgxqsZ9O6WgAtI=;
 b=GynNSQPPWRc4d7mYTUTMrlJCQR3amxCmINf4TcP5PoGWlchcIssENjWBGqNsviuICyRT
 yLkpItamXznEmHguU/7Dgn76uoQKE3HpNT48wUSyXv/ipTI+IpgK787KPut4lIGlXGv+
 qtdB+5VOf7Ah+bFodSvzpbcalLVtGdddVVX286XVoDGJrCRqGXpjljP7P5xGHhH3qhKm
 P754438qwbsL4iLfohqV33Xgu8QPL3fusqJnb9aBkN5pmBDCPa8JdXENNmFwGnsI8Xhn
 hOSM6GDyE5/T4BTdN+c7yw7byaricE8o0+uFzrgVJm0LtxkoYJOa3aRILKPCrwzzJ0Xs TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 36hgmavhkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 19:42:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CJfC9s156782;
        Fri, 12 Feb 2021 19:42:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3030.oracle.com with ESMTP id 36j521w6fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 19:42:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWOkOyVbIGm2Rj0SYBqxyZ2CnSPP7LDJlj2V8cY/T5cIVjDjtTtMNYTmH0Jk58t1PX3jriXdPeuN88u8gnvS6bFIirr9toDZIZRD8bzFDPOKV+HLbhMaJ3mJ2067xjIUaDt5VB5pTZUXnmAaD4EpX1qTkMheiu/8+bH4bQP/dj8I9GksZIdNXgAd2Jaf0Hfu2ZM8qAC+9u2lOnIjtDMVq1B1lHZ9hYmOtPud9ZGh3cB3E7C9F86ZP+2RlIxsGjoG3r+xab776AgiwGiPxWN3fTeJGdSKHK2D6/+/+DeYNWk+Fajts6PnMAIQxXbAoZu5SQZvc02zB6EzypLgsIyFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7l/HTcouzdCQubM+36EHWqvqjAfkWdgxqsZ9O6WgAtI=;
 b=Az4yjhhCACtH9qPp05PdCZU/kwFcNARZDk+amHl0y2WJ/NIAwo+jDytFKwguJO43te0bq0bbWG7acLjzPQ+aAnwjhzmIhRWbzNFTrmx8NzO+/4YmrVvAm9Bdi+A+eGONQfpANXOMjcGrb7J9FvG/8Ao87fgAZ08wSrJlyy1eutsmvM+T+rYSh0bXV9XRU0LNPo4eRIvILp7+/vMyjr8CujoAjrAtA6LxqFbRWg9BKraBhVI5+6YbByP/Np4K3dvmAVXq2X/YticZwixIw0if4dPYsMpL6cxpcn18W7kpAvnkqpYDGP/vWfP8y+mfhueYr7WSdwBeBirTvcBMK0RXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7l/HTcouzdCQubM+36EHWqvqjAfkWdgxqsZ9O6WgAtI=;
 b=SlZjlqjskJ4z8Crkg8O39BU+A7q+Mbf6UbnSJ5Q00EuWaj2Rif4AHVO5r9hFrT0bW7JKBefVRqZE457DdYVQsYIopCBGk/poISX3KzXqjuQQ07HHbigzHVd1nA6H72qrDjehO6rFau47x2hhMple5Yb2iG14PlCQmTxuNLvS6+M=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1774.namprd10.prod.outlook.com (2603:10b6:301:9::13)
 by CO1PR10MB4641.namprd10.prod.outlook.com (2603:10b6:303:6d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 12 Feb
 2021 19:42:10 +0000
Received: from MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::24eb:1300:dd70:4183]) by MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::24eb:1300:dd70:4183%3]) with mapi id 15.20.3846.031; Fri, 12 Feb 2021
 19:42:10 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alexey Klimov <aklimov@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com, tglx@linutronix.de,
        jobaker@redhat.com, audralmitchel@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rafael@kernel.org, tj@kernel.org,
        qais.yousef@arm.com, hannes@cmpxchg.org, klimov.linux@gmail.com
Subject: Re: [PATCH v2] cpu/hotplug: wait for cpuset_hotplug_work to finish
 on cpu onlining
In-Reply-To: <20210212003032.2037750-1-aklimov@redhat.com>
References: <20210212003032.2037750-1-aklimov@redhat.com>
Date:   Fri, 12 Feb 2021 14:41:58 -0500
Message-ID: <87tuqhrs3d.fsf@oracle.com>
Content-Type: text/plain
X-Originating-IP: [98.229.125.203]
X-ClientProxiedBy: MN2PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:208:15e::18) To MWHPR10MB1774.namprd10.prod.outlook.com
 (2603:10b6:301:9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from parnassus (98.229.125.203) by MN2PR17CA0005.namprd17.prod.outlook.com (2603:10b6:208:15e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Fri, 12 Feb 2021 19:42:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74e5e060-1d6e-471b-c189-08d8cf8e4921
X-MS-TrafficTypeDiagnostic: CO1PR10MB4641:
X-Microsoft-Antispam-PRVS: <CO1PR10MB46411B0933CC7CD2C5FE0F84D98B9@CO1PR10MB4641.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHLE78BP0s/SIpa0udFst6UKlPd8BRiXZ+rBE1YU5vWQth+1owxJXRMDqMZFxcu7z4xlri8c6icApvn6jGTF0x2cEuxRt01/GRz9EaqqioLkW2BFGT0Y4AdX35krWCKuMNVza0L78S8lWg0M6O2i5cnCwiRBK4MryLUJmHeFxLpX/Gbatr0zgh39aRHbeG47bAFKnKQem7ZmIY1hcHuYcK+4T0p3/r5EVRLbUY9wvrhxzE+C7VQwdIpR+HmOmW7Yl2Cz/25rgoAt9m6KKrxgurmkOigWU4ZflpGvuOKG7hyqspFLzFFHWJZjjy+Eh6/WA+8fccW3pYJ9h8f73VE5a2BfN416UY0+uih0Kjh0SMSImbN/7biF1Vr69KEgSXRm8RJq52fVjRvCDbmlDV2HMHuvIcF2IPwdFWd2H1gCBjOjPID8Cwha+s8/V/nRHpmG/rwkuh8t4mgl/2vyDXI/TY4pwZL6BurGuMYHKBrHp0OVZ8OtQyWgw1yFiu8UVDbbql6WS9cUXBOFS8hUkxoXkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1774.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(366004)(396003)(346002)(316002)(52116002)(2906002)(36756003)(6496006)(478600001)(5660300002)(7416002)(186003)(26005)(6486002)(16526019)(4326008)(6666004)(2616005)(66946007)(66476007)(66556008)(86362001)(956004)(8936002)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I5hmH59G5GzbRTKN94IcFOOujaXeCCNPzjYY19Slym58GyMv+drwDsa4LEuB?=
 =?us-ascii?Q?wuoXickvtRZ5R+8vbqykRvNRBGaBf8EH3aLGQ6lLIIbKQtpzinokRj23U24r?=
 =?us-ascii?Q?xx03NNxs/jid42mWWcFLqBFROdcHvY1+3ZJ3le4uxODIFBLnQUkqLPWr+Hk+?=
 =?us-ascii?Q?qYZePHd45gRSIY0VRekzQr8HAYJGYU0fM7BgDL4wdcnqUJ7oXT+gnCzL4d4d?=
 =?us-ascii?Q?bVON3ssxlncp2RcMUJ9EEO3eBkKJ10hGaBhT5SW0I6Pv+GpOwAmuFDRVR7oe?=
 =?us-ascii?Q?8atrzl3cStH7g1Nj5/cRsR63AGKEqfpbFn6v4uYQ5Rz3yUufK599oyNqHkec?=
 =?us-ascii?Q?WtQj9Cw+U98smxwRkZQrB382KXdUQbECmLQgI8EpxQk4fKvWypaBgKPKWT5h?=
 =?us-ascii?Q?572nc0vxp3sR4YC8bvc6gqP6LbyB0qn56Qy7MhIrEAJS7ioF0wnNjBsrZn4P?=
 =?us-ascii?Q?3qzRBstKVlWQ7srKQZBRtLU8g0a4DfLYDJ9dldAGE9sNliE0LFJc4M0BhZCF?=
 =?us-ascii?Q?0aJ93koir4tFDqry3o3J5cKM7Qc+2eAfCqVGZGmLXl7kP/w8zt940A+tO6O3?=
 =?us-ascii?Q?C/JDz5j3NyrEfgpdUbANgloNadOZdJA8kRbFxlfOjyV+w/rp1+AfD2E0S8/3?=
 =?us-ascii?Q?pDCJidrvAHX9WeSYUB0uv6amCQLwI/k6zWqVOzBpIiaw4vfsMg0ykS3pP+jo?=
 =?us-ascii?Q?sLKv4hwV+lX8UV0Cm4g9HzF5zkG8apAfk8V09JmAecF6PyQGT5Ikh27YhSfi?=
 =?us-ascii?Q?OD6WMjazwyVHQKAgNZ9mEmGIx6rxUbqdpobz+CsklgTRW0p68XikhNwpqRlE?=
 =?us-ascii?Q?W369+ykrRTmEm0uUquwXUNOm0j8kRMPAXTF5w+RMyu5pk5H4XnthC2YY4PlJ?=
 =?us-ascii?Q?/LHWyp8e6wcqM+Ny6JwNSv2Eo9MlVUf7BCb7LXuzF/SvqfHufsi7OUjxpm3f?=
 =?us-ascii?Q?avewJ+23fk+kyyKVaWXg+GgoJTVMUJfCBrLWjuYeWpnt1U6r3Be2N6qRVOcX?=
 =?us-ascii?Q?6W6rJM617wxwAtylnLkp22/hi7ije9rDF+4ysJfaKMBbQ4IX5acdkyR6StGL?=
 =?us-ascii?Q?UDGxzATaj4c474doE4PR10T+Q+kOufL/5/HnZwyVpbs+JZ/uA6j69UR27a4T?=
 =?us-ascii?Q?aV9BcL5EdxkuuFpTxChS5unDdG+TGapT9d4VGQDe7VjY92dO5JlINqns8W7J?=
 =?us-ascii?Q?VL0rNAJnzi5aWfT8lXY8pTDpsD6vMPU6AfecqLdajbkOdVo/desli/e+2rWz?=
 =?us-ascii?Q?c8IzaH9WY5mhJnBoCLUom4lJpqqo2gc5MZxMpmbvghHVrfi93vl15ZT+RSKC?=
 =?us-ascii?Q?XA2A6FUBnqhZFXO8KKJ0GiDT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e5e060-1d6e-471b-c189-08d8cf8e4921
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1774.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 19:42:10.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+7vyuX2L9yt4jefdd5hrRalBkH1dt2Y44D2vNVG0+UO+pGtQdYBymc2OyQpKhAt+fKdBjqVuVvtZI2ilvNUhqsVeEUBMtvHBZiXbwoXMlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4641
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120145
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120145
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Alexey Klimov <aklimov@redhat.com> writes:
> int cpu_device_up(struct device *dev)

Yeah, definitely better to do the wait here.

>  int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  {
> -	int cpu, ret = 0;
> +	struct device *dev;
> +	cpumask_var_t mask;
> +	int cpu, ret;
> +
> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
> +		return -ENOMEM;
>  
> +	ret = 0;
>  	cpu_maps_update_begin();
>  	for_each_online_cpu(cpu) {
>  		if (topology_is_primary_thread(cpu))
> @@ -2099,18 +2098,35 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  		 * called under the sysfs hotplug lock, so it is properly
>  		 * serialized against the regular offline usage.
>  		 */
> -		cpuhp_offline_cpu_device(cpu);
> +		dev = get_cpu_device(cpu);
> +		dev->offline = true;
> +
> +		cpumask_set_cpu(cpu, mask);
>  	}
>  	if (!ret)
>  		cpu_smt_control = ctrlval;
>  	cpu_maps_update_done();
> +
> +	/* Tell user space about the state changes */
> +	for_each_cpu(cpu, mask) {
> +		dev = get_cpu_device(cpu);
> +		kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
> +	}
> +
> +	free_cpumask_var(mask);
>  	return ret;
>  }

Hrm, should the dev manipulation be kept in one place, something like
this?

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 8817ccdc8e112..aa21219a7b7c4 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2085,11 +2085,20 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
 		if (ret)
 			break;
+
+		cpumask_set_cpu(cpu, mask);
+	}
+	if (!ret)
+		cpu_smt_control = ctrlval;
+	cpu_maps_update_done();
+
+	/* Tell user space about the state changes */
+	for_each_cpu(cpu, mask) {
 		/*
-		 * As this needs to hold the cpu maps lock it's impossible
+		 * When the cpu maps lock was taken above it was impossible
 		 * to call device_offline() because that ends up calling
 		 * cpu_down() which takes cpu maps lock. cpu maps lock
-		 * needs to be held as this might race against in kernel
+		 * needed to be held as this might race against in kernel
 		 * abusers of the hotplug machinery (thermal management).
 		 *
 		 * So nothing would update device:offline state. That would
@@ -2100,16 +2109,6 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 		 */
 		dev = get_cpu_device(cpu);
 		dev->offline = true;
-
-		cpumask_set_cpu(cpu, mask);
-	}
-	if (!ret)
-		cpu_smt_control = ctrlval;
-	cpu_maps_update_done();
-
-	/* Tell user space about the state changes */
-	for_each_cpu(cpu, mask) {
-		dev = get_cpu_device(cpu);
 		kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
 	}
 
@@ -2136,9 +2135,6 @@ int cpuhp_smt_enable(void)
 		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
 		if (ret)
 			break;
-		/* See comment in cpuhp_smt_disable() */
-		dev = get_cpu_device(cpu);
-		dev->offline = false;
 
 		cpumask_set_cpu(cpu, mask);
 	}
@@ -2152,7 +2148,9 @@ int cpuhp_smt_enable(void)
 
 	/* Tell user space about the state changes */
 	for_each_cpu(cpu, mask) {
+		/* See comment in cpuhp_smt_disable() */
 		dev = get_cpu_device(cpu);
+		dev->offline = false;
 		kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 	}
 
