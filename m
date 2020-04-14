Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5883B1A88C4
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 20:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503545AbgDNSM1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 14:12:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:54626 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503531AbgDNSML (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 14:12:11 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03EI4T5K023495;
        Tue, 14 Apr 2020 11:09:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=745c7R5noQJZyZzadl+HjR2ni9lSf396P96eRY/ZhmU=;
 b=03DbJ5drl5HQEVbImtwuqZcW0ICY2uANBQqTHd51+nRFb3fQUFysmvRTXyHkiDBT9ODA
 T1W3arQWw+xGTLTCua1N2RIYz8J51dvfjIHraV+5vDerqTqoHiiJsmdJ7jG1mmCdeTZD
 SbtNbfIr7KfqHOJPFDbO53g391V0VVuDQ7gGQ+uXsbrWe1Ci2/+GXUHkW/hCdvnUmQ2h
 drMRIO9xdvxMe1f1w0q7duViKyWFbttaiX10tmbtWGOz0vGLtK9OE9SW43mrfPXexzCE
 Mk2cpsdjNiobU5NArSmr9iYRglG2/WR/T33gn5hT9xrT42cf/9yk1IukwXWXreZXsZkK 1g== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by mx0a-002c1b01.pphosted.com with ESMTP id 30b9t97amp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Apr 2020 11:09:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjCda54OjK+DkgSx+WhIGFMP2hptc9WbjsHJn3sPCxlMl/I5rbNjWpnsfy+KRj/dwle2TW5iznuRx9ruPt5MfDZQxj5qpAJ6dtjX1qEPK8+DmPxMaElgM13aT35pZs+rHvSIHAHYAmuJ59cyaF6Dt8lt5mcnDecgR/Y1RLMCgnEclDe8FHZiyYfPiq6Dpxu3qkoFy9OMAZYyR/2jqQG91zgetPVsCbPOzEn5fSX7j/O88narE7lSsmz9AKsbNn/Tb4qAfHFHjk9CMhKPy4h7+UBDv4csu1wU2b4vUwAc4PQTVZe2ZP5pFaRMwe6CdPx6bFEU/q/q5T0CyDUuoDQEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=745c7R5noQJZyZzadl+HjR2ni9lSf396P96eRY/ZhmU=;
 b=R2uHSJubfmIx2fhFsgpxBibAeHTw35wKoHiAMm/GfPA+VrNwcuWuBEyO9H8wb8PqvwYSu0GKenfePeZIbeVJ4J9cIKsOs98oCnBRxh5Y4UGcZIPVfmDWEilEfmJLZmQ4sxhvMUz/P00RW8siyl1sTGEtLFKTJ/VAf85MD4Ur7pmBQYvlLgFQy891i+BIrRMfF8rLU2FaDiZ+aeXMKW+1ZPo1IrsGe6Inlp3/q30hiDhdG4FCEaYB6ejvCa4BGaBlTaFBFBuSippu0lMTQugc157NTzCluAItmBxlnYPq3gQsafwuIFk5nP3A25WCnqznX+iGdz/AAoMZNR4+6OwoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6303.namprd02.prod.outlook.com (2603:10b6:208:1bd::13)
 by MN2PR02MB6989.namprd02.prod.outlook.com (2603:10b6:208:20f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Tue, 14 Apr
 2020 16:08:39 +0000
Received: from MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::1dc5:77f3:3eaf:ffc8]) by MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::1dc5:77f3:3eaf:ffc8%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 16:08:39 +0000
From:   Ivan Teterevkov <ivan.teterevkov@nutanix.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "rientjes@google.com" <rientjes@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "guro@fb.com" <guro@fb.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "chris@chrisdown.name" <chris@chrisdown.name>,
        "yang.shi@linux.alibaba.com" <yang.shi@linux.alibaba.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "ziqian.lzq@antfin.com" <ziqian.lzq@antfin.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jonathan Davies <jond@nutanix.com>
Subject: RE: [RFC] memcg: fix default behaviour of non-overridden
 memcg.swappiness
Thread-Topic: [RFC] memcg: fix default behaviour of non-overridden
 memcg.swappiness
Thread-Index: AdX+Dc7TuUU65jcsTmmN9pfGvp9AeQAr94MABO48HRA=
Date:   Tue, 14 Apr 2020 16:08:39 +0000
Message-ID: <MN2PR02MB63033A5D2EE11A0D7DFEBE95E9DA0@MN2PR02MB6303.namprd02.prod.outlook.com>
References: <BL0PR02MB560170CD4D4245D4B89BC22EE9F40@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200320134428.GG24409@dhcp22.suse.cz>
In-Reply-To: <20200320134428.GG24409@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [31.125.170.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e2c41af-10e4-40dd-05a3-08d7e08e187c
x-ms-traffictypediagnostic: MN2PR02MB6989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6989C6F145A231B70F6BA5F6E9DA0@MN2PR02MB6989.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR02MB6303.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(396003)(39830400003)(376002)(346002)(366004)(44832011)(5660300002)(2906002)(8676002)(86362001)(478600001)(71200400001)(4744005)(33656002)(81156014)(8936002)(26005)(107886003)(54906003)(316002)(6916009)(4326008)(186003)(6506007)(66556008)(66476007)(7416002)(76116006)(52536014)(9686003)(66446008)(66946007)(64756008)(7696005)(55016002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 81fjC7P1yUMgY4+NpwMHI7pjn64+1RSsVdFiC63I2EjZYQbX8lBwmNU7DEdyHwfIflKXfLb+a0FrJbPvp7pE60U/FMcVzmqTGAxfpBRBUPbPLYOXKkkVryPhctMY+dTsII+QL66+zXKr0LB3NEdnG88v5xDMx/jEL7pZyaA8R0dElqLncU6RVjGVJ6Kes3ugmg0q/xUR133kE9bf0dEAL2dr1zJOgPWl9nakO/WANWVw7+3POwl+rIkamaAotUH5KDyycsv61hN0EYm14kBNs5kQn+J6KUvPLS0A4bpLrUHRmqT3bZ8xfS6OtYvq2YEsFFsBYJq7E+Lf0Kp77xSjEBCh2hb25SAiIVCTWNt6CyAnrxESnO0igeMiAcC9OrtW074jirVAVZ9vW+XTqipmh/Z+TGDjek6ryaEHOJaGE0c/uoHE5N5IRKkGOHpdRKZc
x-ms-exchange-antispam-messagedata: PrOqkpWRb9Lmx1mGa2XnylOJJ2/L1K4/mKxs21Cukmg4Wxva66c+exnxyQwDNQXu5lV/zyxZW3rn/9iha0pLf+xw5WL4w9rct+sxamv9I59p/gobmZV7Q/BzEOluJ1ye5fTYPzML0X9HH6AU3wrv1Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2c41af-10e4-40dd-05a3-08d7e08e187c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 16:08:39.4265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aAGl/A2ez2HORvWec3Er0IHF+Gsn+A2FgN90jguyi/fbSkLzjhQa7NfR2/Iudr+hXn9hbm8gWjdp3Eha+S1mEjv+Sx0Mm2PlpY12YIa5E+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6989
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_09:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 20 Mar 2020, Michal Hocko wrote:
> On Thu 19-03-20 17:38:30, Ivan Teterevkov wrote:
> > Also, shall this magic -1 be exposed to the user? I think it's a "no",
> > but what if the user wants to un-override the memcg.swappiness...
>=20
> If we are to use such a semantic then it absolutely has to be an opt-in b=
ehavior
> and expressed in some way to the user space (e.g. a symbolic name referri=
ng to
> the global setting).

A symbolic link would be a good approach but...

> I am not convinced we need it.

... agree and not going any further with the suggestion.

Support of the sysctl parameters in the kernel command line is a
better solution and would address my initially raised concern to
tackle the configuration parameters.

Thanks
Ivan
