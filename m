Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4362D2FE133
	for <lists+cgroups@lfdr.de>; Thu, 21 Jan 2021 05:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbhAUDw5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Jan 2021 22:52:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41832 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731712AbhAUCLJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Jan 2021 21:11:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10L29mTu078243;
        Thu, 21 Jan 2021 02:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=OPs4WlA7uDKrhe4fwAyB9Djai7DI8qa4Dh093prfKPk=;
 b=UQQH58W2miH1vTQIrdFmQNMPRawJz2Zu/NPSWCZKzwD9740CW+srwUjKQ4uVdEMpkafI
 XHRtiknO7IN/vRLZqhDAMC2lIKkiJtI/QMmfzUIsny84das5ahFTJiFSmXc4mWhNHgWH
 foZbk9Pu02H5+Z/66//5HxrfMZLNor5DPoxsEwJn/OjwdxXudLYRxVMB3jj43rOrxW37
 2iGz4E13Tk4JEa++5TTpr6ahnGJyuAXBWSzF7+7nUrIFBEHjy+kaRNL/VZvvNQg5SluM
 jVCxo4gBDc7cl5HEcbYPXdLXCLliwg2Vje19RWLVJ7tXsmg62eAMg+vT66gGgj/NrEn0 CA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3668qad7gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 02:09:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10L25qPT005202;
        Thu, 21 Jan 2021 02:09:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3020.oracle.com with ESMTP id 3668rext73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 02:09:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQqAWqnR8+Rk0AUk/ZwzWofphCM46q8RKloRQVU0305C12NPplipe7toEF7xxlkQiamA2y1IKOlgbiq1UL0qL3JSMaNmXnwRMnv7/uKuG0OoXpXw083bFPyzopYfHbvoyUUorLcioX5PndyOOqO3/csicrMzTXHaM+bWGxgxVlA5Sq07i0Rb0EgkAdGiIinfMLXCkooCzWfTmBf0zgPpsF8knqkeOWBGLNK5+2b53WHuzFhSJi5PYNWS9oltpZyu1IPyppCAaHB00KoAPsY4oIkgGEs10e5sSZh90KnffbMgrSvGptYlAKE20PR6AwfExkWzzNzyb++2SSJFvvjiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPs4WlA7uDKrhe4fwAyB9Djai7DI8qa4Dh093prfKPk=;
 b=Cay0w+icK5yhPIZSjkiG4/aKTXYwi0OGHErlkG4Lg3bWqAeyeYaX7JiF3W+/bNUq4mSiXEVN6MT8RDhh/nS0SqNPUhHSwSAIwvAwzAVV2lu6gl/4sTpupaprXjIM1kmH17BzjDvE57JuMRQ14r1W4T55LLK5sn4BQT0pM3fQzOLAGqXkZRbD44FrQaTOsgj+z5TS9oVXNWplcjuUTljk7lib3TWOyXFTjhIAyjBWvRifqhNFvQ4tKzpUdKDq3LNjO3P9X2ZBQvrWWtFSyYlymJgKDoBJnEu3OwKXG9gW1Lp/7Ufd56RrhVhHC9zQt/778rdKyasA1ToWNsH1pftKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPs4WlA7uDKrhe4fwAyB9Djai7DI8qa4Dh093prfKPk=;
 b=F2R+ZCTWhzg+pssSAbeiAFcEgiIqkygKzugHWDtwTsAn5lGFDaNSXDEzihfMtywqfeL+TutLSEHzjSMjk72VJVTLi7J3xOz92996Ky9IOSZkxUafu44KZqRXMoaKeQ5YMm41jYfTsygMaDlgvPcnPNPtKYz3R9AzwMT6hyfgrHA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1774.namprd10.prod.outlook.com (2603:10b6:301:9::13)
 by MWHPR10MB1774.namprd10.prod.outlook.com (2603:10b6:301:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 21 Jan
 2021 02:09:44 +0000
Received: from MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::cd03:d8e7:17c3:78d5]) by MWHPR10MB1774.namprd10.prod.outlook.com
 ([fe80::cd03:d8e7:17c3:78d5%6]) with mapi id 15.20.3763.015; Thu, 21 Jan 2021
 02:09:44 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alexey Klimov <aklimov@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yury.norov@gmail.com, tglx@linutronix.de, jobaker@redhat.com,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org, lizefan.x@bytedance.com,
        qais.yousef@arm.com, hannes@cmpxchg.org,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [RFC][PATCH] cpu/hotplug: wait for cpuset_hotplug_work to
 finish on cpu online
In-Reply-To: <CAFBcO+_PoXhbq+p-2z=acCpboJtOewXkp-9-3=csafoAYuNFQw@mail.gmail.com>
References: <20201203171431.256675-1-aklimov@redhat.com>
 <20201207083827.GD3040@hirez.programming.kicks-ass.net>
 <87k0tritvq.fsf@oracle.com> <87im7yc2bu.fsf@oracle.com>
 <CAFBcO+_PoXhbq+p-2z=acCpboJtOewXkp-9-3=csafoAYuNFQw@mail.gmail.com>
Date:   Wed, 20 Jan 2021 21:09:27 -0500
Message-ID: <87ft2voxbc.fsf@oracle.com>
Content-Type: text/plain
X-Originating-IP: [98.229.125.203]
X-ClientProxiedBy: MN2PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:208:a8::40) To MWHPR10MB1774.namprd10.prod.outlook.com
 (2603:10b6:301:9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from parnassus (98.229.125.203) by MN2PR12CA0027.namprd12.prod.outlook.com (2603:10b6:208:a8::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 02:09:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06a635ea-92bb-4817-ec04-08d8bdb19ea6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1774:
X-Microsoft-Antispam-PRVS: <MWHPR10MB17740B156F0671F1316F6B02D9A10@MWHPR10MB1774.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuWI/8aM02AZsQOdhK8poAo+oPK9gdMxRPS7KzlvjglFS9bP5m2mbRZWX7qsBR5ywvPXjJK2mbBBo+GtLlfqMuE16uqiLAdClNvNBqncN9wt7nFd5jvBbSlnwFA4/+ztjPOQ3G6HpWYB7HTeqoMY9WEPBd08yz6zUZf3CRjeMvSRN4S5Zr8sZp5ugvbr9xDriYdw1CSF1D9cXmFd0qr730IKILeuUT+/qMs3cJeH7trU2RQHui+JVXVex0t7fz/NCnsxyEwPPC2byjKMAE2MSn7AhkQHeSuTNB36TTmc4xl6H6T5TcGXr0fT6ExIMabiZsmdIpdBZcwezoCUdygZ4eTOtoMDtVRZ/NyzRbwzMOuLcbJRkdBZc0hInVhn38ZgKivIhA+bOLpOGficaBLTfd83YcHHIvl6qpRexnHdV8p9/vtNeAEyxbMt9l/sX93/+su5yy8b4jRzfc1CcZhwpy8Tlu1XKRrIJI/QXzRGbj3kv9SyBZgZ2acbaKPgH370dWeuX6O+yrEarX9NkSzOtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1774.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(376002)(39860400002)(52116002)(6486002)(6916009)(66946007)(5660300002)(2616005)(186003)(6666004)(956004)(26005)(16526019)(508600001)(54906003)(36756003)(83380400001)(316002)(66556008)(2906002)(6496006)(7416002)(8676002)(4326008)(86362001)(8936002)(4744005)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TRrWDze687fWEWVbDG3Hr/8faP0Ey5nidQI0jeSFaTIadhuBJnQjVE+mOLn06P5QYaK5jYoZTYaT1Bq+b7CIPCz9KxpBXuHdFROK5/RSkVmgLzeS8+NqRO2yNIjWT5GvYDlM6LZ/U382JrGvvTQIX+ZfJoRG0K1VA0fPZT9RpdZWRazGMviVC3DQS9RIvEKn1GcUlM2bIF9IOs0J/wxyHGFqc65DjcHg66Ze7I1kbbmv54PPgKTMbDwPb9cxB1KMqP4QPrZKnACyU8CtXPAvSIuN14tPlV8nDiFJGxiI92qCF0Q+H2qsJUQbxrZyoMgDZjtGNNtD8hKueug6WpAi6sdZH4NNYxyp1Ue1r6+wJ8FDxWAR3qzqYtRr/8oEChSWs4tbUF62otf/SxDd5rRyWCiJI6O1a6tzyZv+5vLiwOitITeJg67To6TdZF2nCsvbMUSB40KUD1l4I7YROrb956Ne1wNLIbfo5mJDXcf5V3MrtdO3seYNv6ssA+/y1Jw3BjbPHbk89DZpQ+myeWkJjb4zXIboL/K6CaXTnvv/bbOSbzoC2bAhaJu2v5Pcuiu1o3VptoKbUJX/l6tz5XZoLVrmmdOljhmqG3xtTl8Y8IpzKVdsHRmIvG0tR8XX3wcaqse14lttazQNUUdUAjdTFRyh7I0TgLwyKMVg2gxwSWZNckXCghIP/zAkF0n7XUAusWkyIJPWC1iCV+VDdnaPna1PahGI5yfuniOWCAJRCvAmuBF/zfxGX/m58XmJHTZV
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a635ea-92bb-4817-ec04-08d8bdb19ea6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1774.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 02:09:44.5913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWboO7ah59T9lh6Rm3aBnfk7bEdGatEF5iAGdzrvgDQgupYCDWE13plAxvHpoB0sYQbAIBgVW7v4E665omdEmBnaRhX5jwGQO2Ebd1jSc04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1774
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210006
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Alexey Klimov <aklimov@redhat.com> writes:
> Daniel, thank you for taking a look. I don't mind reviewing+testing
> another approach that you described.

Eh, I like yours better :)

>> Absent further discussion, Alexey, do you plan to post another version?
>
> I plan to update this patch and re-send in the next couple of days. It
> looks like it might be a series of two patches. Sorry for delays.

Not at all, this is just something I'm messing with when I have the
time.
