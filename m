Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD61ADD09
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2019 18:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389447AbfIIQZL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Sep 2019 12:25:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35812 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbfIIQZK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Sep 2019 12:25:10 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x89GNxV0029691;
        Mon, 9 Sep 2019 09:24:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=m/+u36wyBdJNgYpeuMX8Bk/u91XmjHB9gZiyi7/IxXk=;
 b=DGSmxlg0ivDhney3HH603x02F4rWpPqa7jDUV095V+eM4fwK7KOLAfllr6/ATr1BYSVd
 Ic8hvBXuXsSzEJBPDJXbYsaBv4nN1Hc8HmdDCeEcaRZdMRqGSS93o9CMytRJIqq8aPkJ
 AJouNGGa4tYqLJykb6rH+sxzrqb1hYiVicA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2uwrh2ghhq-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 09 Sep 2019 09:24:03 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 9 Sep 2019 09:23:39 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 9 Sep 2019 09:23:39 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 9 Sep 2019 09:23:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4bSKyKyXvVbVvTzuWiptbQj05aPKemC2ITYAT9UjBccDajEeOa9yK95Cte8GeyFMdQl+783j8Tibz/fZLeansz2DnldK665JVRoUaJ9266mi403gZnHszaB8nIpqgl0XbLWxE7I00EGE5y0RWsw1Nn/adoSfJQSgBp6+ksaGYF9JsxP6SqiF777Q5ha0ddKEq84e4+6/lMjxETH4pZJJuR/jVm12aHuxcXFCP/KtW9H9VVkCZfH4LI7+IXVUZztd1RXkVIrLkUxlESEyMmoANavciWJUjR4tuOB77I7lvxZfQeTMtIMkrsOamb8CWnYQuOEpRQLaVqswUFFz88y3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/+u36wyBdJNgYpeuMX8Bk/u91XmjHB9gZiyi7/IxXk=;
 b=nPd3SF7skQ6voQlZ+e/yDskNzGdXW20tEJvl5S+VajMgkcguqr1DV2nUs4kWH9Td1EmrK5ypbnewuU+tf94gcA5sS0GiWmgWMtXI6aB7PRk7dN7gML3Wzhb0kzsqP+7p6FUvys0PFmpM05XQnmRU8Nncp8hz0DxL9pB1WpFaLmSDjU3jR8goIHEqwLcpHPnWh7FarAanBigLdGLmsgosoDO1sZH9deWcKBLGsKcFrBNHwSQysBDk69jlxVdOxsVnwgbYn5ylPrZp5Fpjp+/GU6jLMQ6v/sQ+JD/Ut8OHA3WAhUTuLezWR7qMcuZJdxIR8YydLftMTZPNv4Zj+fi8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/+u36wyBdJNgYpeuMX8Bk/u91XmjHB9gZiyi7/IxXk=;
 b=PwZO/p4kQfRAep7egQlDvK3iqZyNv9M023X5cuQy4/hdgPyuHUdawsxN04FlKcDUwI9zSbqQe8PIuNJhzQudXQc8Z0L5NINE2/aSYO5uXqXesz5/NGsMT0jIcw4L9iJPa9dFC/Vf2539w8Nc5p3Jaqb5dpkIBMf535HL3PXBXRk=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2948.namprd15.prod.outlook.com (20.178.219.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 16:23:38 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::5d2:6eec:98cc:76d2]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::5d2:6eec:98cc:76d2%3]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 16:23:38 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Ivan Safonov <insafonov@gmail.com>
CC:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup: use kv(malloc|free) instead of
 pidlist_(allocate|free)
Thread-Topic: [PATCH] cgroup: use kv(malloc|free) instead of
 pidlist_(allocate|free)
Thread-Index: AQHVZlMwLyLH4umnXUO07VS6c1TXmqcjiTKA
Date:   Mon, 9 Sep 2019 16:23:38 +0000
Message-ID: <20190909162333.GA8571@tower.dhcp.thefacebook.com>
References: <20190908144041.19667-1-insafonov@gmail.com>
In-Reply-To: <20190908144041.19667-1-insafonov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:300:4b::32) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::eb41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ed38a49-f722-4e1b-34ff-08d7354211bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB2948;
x-ms-traffictypediagnostic: BN8PR15MB2948:
x-microsoft-antispam-prvs: <BN8PR15MB294840D1BF4C3ADD6E5BDCC7BEB70@BN8PR15MB2948.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(136003)(376002)(199004)(189003)(53936002)(5660300002)(486006)(478600001)(256004)(6916009)(6116002)(229853002)(66946007)(9686003)(6512007)(1411001)(52116002)(76176011)(6246003)(54906003)(14454004)(316002)(99286004)(2906002)(6436002)(64756008)(66476007)(66446008)(66556008)(4744005)(8936002)(1076003)(4326008)(6486002)(81166006)(81156014)(25786009)(305945005)(7736002)(386003)(33656002)(8676002)(71200400001)(86362001)(6506007)(71190400001)(186003)(476003)(11346002)(46003)(102836004)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2948;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rBrqclbEFtzTMyJHO+5vXC3Q+ItzqqWhaShDsIuat2QdZs9tMTCFaSQ6bvY3W8f1G5Z+0R1CyRyDuDkMXZRKpm2Qenx/vbKW+y/lkA+ELzyVl8EDTNrN0UrIEiTDDoY4JOkqgPNU7wQuBCj1VRgVsF1j9I5+IeAL89RSbK8xTf2hJHIbPjy5qVMeeCDU3pYqEU+01MvOrXz+tjesvv5VbprxLxiZFMdi4mks5OQMAXswinVXlqBOUagR9BGUP1bmR/v4tiee8djwUpNa7mNbgYgvxUZiMKF0IU8rYxhUjK0Lt61bzVwB5+1pFqiR8wxU9tCXFp1uo1deYOwm8cmvt+mqMLDV3MVT5tu8AraygFH3KMMVqIZAWVF1iuyCfinja1zyco/6OFnZHAxkFQ2J/N/PkPkQsn/JOC3dqr2oZ6s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <627F6A5E88B2754E875DE38D7C361586@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed38a49-f722-4e1b-34ff-08d7354211bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 16:23:38.1819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJo9nuTntlx1aBmJgetoCYxzJdrG3yhHm4w3QjT25dvpHH22pJOfdrLDxduzr7U/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2948
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-09_07:2019-09-09,2019-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=672 impostorscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909090166
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Sep 08, 2019 at 05:40:41PM +0300, Ivan Safonov wrote:
> Resolve TODO:
> > The following two functions "fix" the issue where there are more pids
> > than kmalloc will give memory for; in such cases, we use vmalloc/vfree.
> > TODO: replace with a kernel-wide solution to this problem
>=20
> kv(malloc|free) is appropriate replacement for pidlist_(allocate|free).
>=20
> Signed-off-by: Ivan Safonov <insafonov@gmail.com>

Looks good to me!

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
