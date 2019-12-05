Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 515601138FA
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2019 01:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfLEAvq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Dec 2019 19:51:46 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60164 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728419AbfLEAvq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Dec 2019 19:51:46 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xB4NuUEf027865;
        Wed, 4 Dec 2019 16:51:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Q+26R79wCdvnCpgC7hkhkgA2onrQ5wdaxf7ZwR8lGOk=;
 b=fQX2HH+WDG1fa7AN3qBfJQy1KLYGVfLddUU3hIZvQgomMTFJQauTSe3zQ3BP2poaQbwI
 rz7nY5+Oe6cVUCfiebYsPmcIl36RnuLOG5xXpc0INOPPOofULtorroGbbeDwlLTjg/PM
 xUqU8bgo6gS/AuqP8bwdvO8wM3KoA7qdAp8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2wp7khvvc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 16:51:44 -0800
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 4 Dec 2019 16:51:43 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 4 Dec 2019 16:51:43 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 4 Dec 2019 16:51:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EexdWZsD1TI+fAyatnN7cDWqmBs6XxwQB7T/GwxVIFdH1jgA2IPzeY8UkFbGSXxdRQ0NtmSIHAi9yOAAol9Rgf9QmvLbZBT73GuCxQGVQShMEuIqVkmA6h1SXz0ESHgLVTt2H3IwAJpaTQnKvrIM6JtQaqVmD/bSq/9A20bp6wKpLl1SuHoc9SZcJffM35PO8VnP1F6QkEurRfZ7JTBPO/xOtTZ+3U99/8Xy/I8YFkpV3B9qMK2eBY37BDmaGwKmbtuhlPafivO3bjKe0k51FKqOXBSUY9P/8wikwT4muCQTBIkw67z3RGRvFkaQWqEZzSX0SS4XYhZJkPwtIuAWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+26R79wCdvnCpgC7hkhkgA2onrQ5wdaxf7ZwR8lGOk=;
 b=ZpyvUAekPrnB6SsuNnEDZ8xzDsYJGM+cfWQz5ZOzFl6VwUE4lkL+BixO1kjuMZuWjuixpT8QOCRL+HP8q7rm/bnKQqvCMWNLSRajQwYYpzm/cZ3ag2p9f9LHsHXe32wEvQBflpz1IFZBswEjZ5iLFS+O8Zbxy8qYEqq96yLDdW6ciBjy6k/cYv3XPR7Tuf8ClvCVp9q8WhzBokrlmdb8tRGxBtiGn7v46VNKHh1omfj3Ww8DjO0v1g6zr5hnB9frZk4Xf6AQbISjNI3zBigl7LwE1bSn7hrdcc6J+kn6VQ9nzmWYRP8D8anXx/duJ6AVFYiX5HFzAxbVx/3JUhv8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+26R79wCdvnCpgC7hkhkgA2onrQ5wdaxf7ZwR8lGOk=;
 b=OhmImlMywdaqvTxmoooDiS0b+S7IkbF1F7VVwlkZUrXO2JZdq9Skz2BY8grAMfHIwaHnEDiTQia2BnJk0g7GrkVo6l0vkpQF4/6p5Zc6o5YDDG6A/mvAYJ8ihxFCyOAfPpnaEDBUXNM6obASBmpW40OVNQyXHxoCc11Ixd9LI7U=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2951.namprd15.prod.outlook.com (20.178.237.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 00:51:30 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60%3]) with mapi id 15.20.2495.026; Thu, 5 Dec 2019
 00:51:30 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Kenny Ho <y2kenny@gmail.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: Question about device cgroup v2
Thread-Topic: Question about device cgroup v2
Thread-Index: AQHVqv8Rj/Jm7ok6m0a9KTvaBNGsJKeqtkAA
Date:   Thu, 5 Dec 2019 00:51:30 +0000
Message-ID: <20191205005126.GA7159@localhost.localdomain>
References: <CAOWid-cR0ZqTja6rBjBcBLUwSFR2i3ZczTGOxpQFgvBSF0xLjQ@mail.gmail.com>
In-Reply-To: <CAOWid-cR0ZqTja6rBjBcBLUwSFR2i3ZczTGOxpQFgvBSF0xLjQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR06CA0056.namprd06.prod.outlook.com
 (2603:10b6:104:3::14) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::a843]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2247b31a-2bec-4b96-086c-08d7791d442d
x-ms-traffictypediagnostic: BYAPR15MB2951:
x-microsoft-antispam-prvs: <BYAPR15MB295154359241D5F84403ED36BE5C0@BYAPR15MB2951.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(396003)(376002)(136003)(189003)(199004)(11346002)(7736002)(14444005)(305945005)(71200400001)(8936002)(81166006)(81156014)(6916009)(86362001)(33656002)(71190400001)(9686003)(6512007)(6246003)(1411001)(6436002)(2906002)(6116002)(6486002)(229853002)(8676002)(6506007)(102836004)(186003)(478600001)(52116002)(25786009)(1076003)(14454004)(4326008)(66946007)(99286004)(76176011)(5660300002)(64756008)(66476007)(66446008)(66556008)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2951;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZnfdJWQt8k2HU7VxTSyShhII/1qwb70uk0But8aK1kbhsgKVJMVvC7kAEbMLf+JKg8TbX98aWea0w/VdPv8EM4j39G/nNDEFIrnFFW2qyH60noiQF5ukOrnyxWOqTvtnQdKQkWhruBISv7OAdDxIx7znxKf9Rir+KfdIb+1u8kiFggkwIequ2zfJtn+z3pVkil+B+3tc9tAwcHZkABvteu1C44PG4FoX4EgPJrxB+AMsS8YWynSK+LcBjNIBfZKskn5O8WfSXXl0Nhha/Q1H0G7L+c7m04ttEuLyWsWzgywi1+/+h8E5U/eKBI9z/F0k+0hYaFuJ6vqZaHgcMkW1iqEE8HFYLEasL1vBpqYxhq/eFRXS2xjmTYp+9VaFl8j9D/vCNZ1anuQMpZ/1c7+l/mq0TNFdZ4lZ5O0Crvqb9rYq/dp5DMw7j/skELWB6al
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A933E1B29D3B844C941DC442FE934AEF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2247b31a-2bec-4b96-086c-08d7791d442d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 00:51:30.5166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4uva8g3Lu0zLF9EvIBJfjW8vnlJ7Cix/vDlpzu06EEKBb8zrxpZiDvJThJ1/+UH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2951
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_04:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040197
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 04, 2019 at 07:00:07PM -0500, Kenny Ho wrote:
> Hi,
>=20
> I have been reading cgroup v2 for device cgroup along with bpf cgroup
> and have some questions.  For bpf cgroup, is it typical to not have a
> default bpf program to define "normal" behaviour?  Is it fair to say
> that, for device cgroup in v2, if it's not for the v1 implementation
> as the catch-all, userspace applications like container runtimes will
> have to supply their own bpf program in order to get the same
> functionality in v1?

Hi!

Yeah, there is no "default" program, partially because there is no default
bpf infrastructure to distribute and load bpf programs (or at least there
was no such infrastructure at the moment when the controller was introduced=
).

Also, it's not clear to me how such a program should look like. Should it b=
e
a bpf program which relies on data in a bpf map? But then you'll need some
convenient way to modify the data in the map. Maybe it can be a standalone =
tool,
which composes and loads bpf programs depending on ploicies. A library?

I agree, that to some extent cgroup v2 interface is less easy to use
(at the first time), but it's more flexible at the end. I'm not sure there
are many users who use the device controller directly.

Modern versions of systemd do support the cgroup v2 device controller,
so my assumption is that the majority of users will be covered by systemd.

Thanks!
