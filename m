Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40F7EDF2B5
	for <lists+cgroups@lfdr.de>; Mon, 21 Oct 2019 18:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfJUQP7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Oct 2019 12:15:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24544 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbfJUQP7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Oct 2019 12:15:59 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9LG8Ifv018006;
        Mon, 21 Oct 2019 09:15:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=u3Vd60Bbgq3wAtkQCMYlek+E+O7HvF9vuNe6knekD7M=;
 b=lHvq13/iEjug8gKEVF7tIzZwfAEoUWOl0+pjSJlNd+2dmPaQb3qiV23oOEBR0dYgPxPv
 8Fru0ckjU0Ar4r7Yijw+Z/1nsdL4QUDoE1QKU+ixZGojE3ZDfNu4nSEK0OIPWnLeQte5
 DOruHIkjMAc2S4hTpucO/y3p131ggddIdMw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vr0ah7ec2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 21 Oct 2019 09:14:59 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Oct 2019 09:14:59 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 21 Oct 2019 09:14:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/0e3SqpIvWull4IgBiL3KCGp/8Utuvr8Zi0P0y2EL2RuQbKutmxErZhmw7huxsw0B+dpyoM0HfIi+KPShMK1TLVpXbXYlGKmrTxWxD0GaXUQ49rYZ+jQdTUuCFBoxRtd2cJMFv7zmWHTHcnt7Bh6ypAjYxi9EkRpklJmJ2PLyLzJ9ZtTr6mAM/qLKmV0DknON9TKkWv7SB4HeEVPsRzAy1fUtFAg7qHRPRv0UFgYjia+7I8FKTcOC+W9oFC5pmbbctKbk+RjKj8Re82ZmBEMwtC3lmQ99hLw6LGyQEbKYHvEBMltX4IJYHNdRF58eEEBWcPi/C0yDsWLcfFFgGJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3Vd60Bbgq3wAtkQCMYlek+E+O7HvF9vuNe6knekD7M=;
 b=b80g0CZirgiLObhN/DonDXA757ojkQScV/K226k9rR3tE++N19cItZ1cJdEew8D+HWfzEHiKQptj0AZz0ehWmNM8EE0Mg7mDJqjs1eb0uQNRmCrq+bkBab/puENzCW2V9tfdv2xIIjuYEEtarGOLTM4d6vTJkpfmfT1QLfN0nJeFlp3Spho3nGO8fOCgfj/Hz2TwyTgeaw8d9+lKAqXVxq2tRqCwhAvPd+9fMUUa6aQ2w/hFCr9EX5Z8BXZ3LhmWLXRwf4PxxjhQyaUGX4/q89kINK59FWRBLsTdggd1gUORS3hOrBHZtotTQBt+bKib8qUS6CBR9toImjvwlD8ZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3Vd60Bbgq3wAtkQCMYlek+E+O7HvF9vuNe6knekD7M=;
 b=e7iliPrCUuUq5WIjYhRHnuUX7ennhhNplZg/sA7yxAu8R4NoGtHMSNaodD/gARsFKkFF1TfrhwLzSzQvhB9OC0uxMy1ESMXlnbHGgHYFqXiT4oOGGceedh826ZI7lEOlHa8y7uiF7WjqioWGILd/SUPQz1RhRStq0WYv0SPqEF4=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3028.namprd15.prod.outlook.com (20.178.221.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 21 Oct 2019 16:14:58 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 16:14:58 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Honglei Wang <honglei.wang@oracle.com>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>
Subject: Re: [PATCH] cgroup: freezer: don't change task and cgroups status
 unnecessarily
Thread-Topic: [PATCH] cgroup: freezer: don't change task and cgroups status
 unnecessarily
Thread-Index: AQHVh+gjYPie2GVScEWCWWzVFHDWDKdlRYeA
Date:   Mon, 21 Oct 2019 16:14:58 +0000
Message-ID: <20191021161453.GA3407@castle.DHCP.thefacebook.com>
References: <20191021081826.8769-1-honglei.wang@oracle.com>
In-Reply-To: <20191021081826.8769-1-honglei.wang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0045.prod.exchangelabs.com (2603:10b6:a03:94::22)
 To BN8PR15MB2626.namprd15.prod.outlook.com (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::8f09]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be99510d-01c6-4f76-7b02-08d75641d12b
x-ms-traffictypediagnostic: BN8PR15MB3028:
x-microsoft-antispam-prvs: <BN8PR15MB30288669728CAE7B6D5620B9BE690@BN8PR15MB3028.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(8936002)(476003)(256004)(54906003)(4326008)(99286004)(86362001)(14454004)(6916009)(478600001)(305945005)(52116002)(7736002)(76176011)(11346002)(446003)(102836004)(386003)(6506007)(186003)(81166006)(8676002)(6486002)(6436002)(1076003)(46003)(229853002)(6116002)(81156014)(6246003)(6512007)(25786009)(2906002)(66946007)(316002)(66476007)(71200400001)(71190400001)(66556008)(64756008)(66446008)(486006)(9686003)(5660300002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3028;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SszsGntASZwLUCqikd5hMZB4zgaEHaUD1MtTA0EV8YCUODMJs9BahVZQvhcxiZ4rC5+RchfWnjJ07kxh3mJ4MRvCGZ5jmdWcZS5P0psl85azGACZX3p9NpI0Naevw1sRoMeevHyzc0MV+Z9ca1l/T5p3CUd4ox1CDPXO+TElfTxq+hhyJD7PNKABXrggBy8/ZwlmyhnX2bqx61OW9sXyu6VNu1w6oTd+ox5BToZlj5FmyT9UgKBGkp3BQqu+gTsJauNxgpkFGg6bgGcdWkiLjjB+T4/+n0chfzxrLfz523En8OojZG8N0656GSTVRhkKXOckKdhoAFXtNxulSUuIEL4cuDScC+U1blnk8Bxtnqf0D7uBzBHukUn6PepE6NiDX0SBcbVCoxSYxbfZpWqwXrenFBjDsbGNC6VzW/uophxlMtMS5D3GYgcVLdfcJuKQ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BF4FC44173D224AB600C19B6BD5299A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: be99510d-01c6-4f76-7b02-08d75641d12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 16:14:58.0543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B99PCtMLorn3D6GkRKMBX/35wSARjeUYS2t4/2vRNKr0WGK2fNNuUP46sUlOWy7v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3028
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_04:2019-10-21,2019-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=982 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910210153
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 21, 2019 at 04:18:26PM +0800, Honglei Wang wrote:
> Seems it's not necessary to adjust the task state and revisit the
> state of source and destination cgroups if the cgroups are not in
> freeze state and the task itself is not frozen.
>=20
> Signed-off-by: Honglei Wang <honglei.wang@oracle.com>

Hello Honglei!

Overall the patch looks correct to me, but what's the goal of this change?
Do you see any performance difference in some tests?
Maybe you can use freezer tests from kselftests to show the difference?

Your patch will sightly change the behavior of the freezer if unfreezing
of a cgroup is racing with the task migration. The change is probably fine
(at least I can't imagine why not), and I'd totally support the patch,
if there is any performance benefit.

Thank you!

> ---
>  kernel/cgroup/freezer.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
> index 8cf010680678..2dd66551d9a6 100644
> --- a/kernel/cgroup/freezer.c
> +++ b/kernel/cgroup/freezer.c
> @@ -230,6 +230,15 @@ void cgroup_freezer_migrate_task(struct task_struct =
*task,
>  	if (task->flags & PF_KTHREAD)
>  		return;
> =20
> +	/*
> +	 * It's not necessary to do changes if both of the src and dst cgroups
> +	 * are not freeze and task is not frozen.
                       ^^^
		are not freezing?
> +	 */
> +	if (!test_bit(CGRP_FREEZE, &src->flags) &&
> +	    !test_bit(CGRP_FREEZE, &dst->flags) &&
> +	    !task->frozen)
> +		return;
> +
>  	/*
>  	 * Adjust counters of freezing and frozen tasks.
>  	 * Note, that if the task is frozen, but the destination cgroup is not
> --=20
> 2.17.0
>=20
