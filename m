Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11330B3FF8
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2019 20:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbfIPSFy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Sep 2019 14:05:54 -0400
Received: from mail-eopbgr700076.outbound.protection.outlook.com ([40.107.70.76]:21537
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726872AbfIPSFy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 16 Sep 2019 14:05:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCAMSY0EDi6Rmm56OO9j5bVIjeXaxZncjxSb0z5irVZku+rUErUZI9HUcSLTACJj47CXpiitjTb25fgdawC6v/quG8Ur7rHOVu6rfZQvPOr0cVZkccWhgjrd99IM6I4AWRIg59YaV2+KsSc6p8zSxQt7yJUInluV82VKgynezy+7ufBhIe75OJ84FnTofXuZpVB1v225nI06DsBsqQmxxQDh08DB0BV1xKBONUR04sL73cDQWBEZLalwvQi7GF/wxUjSiQMzlZgV36bIvY0ZIHQMMxrHSK0xb7difUvipuwugZxFYBRxg+Msh2QN4eLSTBAZmzrBWfrw8cdVU/qTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vde+IC7fzKXq9LD3RB4+/1dc6D0XU6OxfWBODFrOWkI=;
 b=cJYtJOC021ZForp964bdlRGH/AlRep+gKlDIzQArvTJhk4A7B03Z/yG8BhqDxVoqgUKheENdnorHIfbPzfpZcTSDnj+nz+MHcSiwQdG95njQ7BLoUjXTmL3m76MZhr0EoksO7akcSti/w1/5IC53u6DM50DKIRq54RdbE5KUMRpteMsMnpKRT8cqoa1+T0KAF33mdLOSupto7hV4qjx7m75FMYyhg6/nLSQvSBkQzIEOFebd0L2BEg4rO8J+N7JKoyEmgAPpQ/eIl7Mr2pKxVqjAXrRkBoQBAchjYdZgdf8q9NNvZkpf/FNjWSutFNTljxv1eUrX/OuIrFANrb0MZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vde+IC7fzKXq9LD3RB4+/1dc6D0XU6OxfWBODFrOWkI=;
 b=mlDTL+LIitn8bjGy1nm5ZbC189msYIO0wYi4hVaavbLkV6j/KQ9pROwUtXCto8l6MAO80E7uZ2fVbZqSNy60HOn/4UAzY8MyeNop7b+5NkSogeBzHCD5NwKSCVgywO/4UceFe5QZGnRvVMcC3ihVHYUBCoAdISfiJO4d6ByZehU=
Received: from MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) by
 MN2PR12MB3871.namprd12.prod.outlook.com (10.255.237.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 18:05:51 +0000
Received: from MN2PR12MB2911.namprd12.prod.outlook.com
 ([fe80::c8cf:fab8:48c1:8cee]) by MN2PR12MB2911.namprd12.prod.outlook.com
 ([fe80::c8cf:fab8:48c1:8cee%7]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 18:05:51 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "airlied@redhat.com" <airlied@redhat.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: AMDKFD (AMD GPU compute) support for device cgroup.
Thread-Topic: AMDKFD (AMD GPU compute) support for device cgroup.
Thread-Index: AQHVbLlfjITLMEYSwk+0RTk7UG2pLA==
Date:   Mon, 16 Sep 2019 18:05:51 +0000
Message-ID: <20190916180523.27341-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-clientproxiedby: YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::21) To MN2PR12MB2911.namprd12.prod.outlook.com
 (2603:10b6:208:a9::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harish.Kasiviswanathan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a7dca09-5f94-4ef9-e355-08d73ad0824d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB3871;
x-ms-traffictypediagnostic: MN2PR12MB3871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3871601E1ABA4B1EDAD5A35D8C8C0@MN2PR12MB3871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(199004)(189003)(50226002)(5660300002)(2906002)(4744005)(486006)(53936002)(36756003)(66946007)(6512007)(1076003)(66556008)(66476007)(64756008)(52116002)(81156014)(8676002)(66446008)(6436002)(14454004)(86362001)(478600001)(81166006)(71190400001)(2501003)(2616005)(4326008)(476003)(71200400001)(25786009)(3846002)(8936002)(6486002)(6116002)(256004)(54906003)(110136005)(99286004)(6506007)(66066001)(7736002)(386003)(305945005)(26005)(186003)(316002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3871;H:MN2PR12MB2911.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U+r5zNWbPlFDCqWqPs6FCrWvag5D7Ia7jUVmfEYaU1sQtQMuXVH3RjYmkVLNGAbBFVgatFLCr5g2x2WYBlm39+MALhadLbeDD3uW/Zf1WqkQh+0A+MinbijsoXdWP8qvWa7N3s5wOVj3JREHTcZjwOnQ9LiQWabFjwQTHW1tKwF5ZDalMWyjZZR+T1LephyzoLWkB9iV6FrJ/BkwUOHuZ4vSywIXVE7WSsDbqvcNd8CoDUhApGcA7bOsP7OKNYVfp7PEalYyFRYVyTDBcLMNrGC7/xObLjzweuOjvdh0fqq6Jp6UB2XqrAsjz3INfgXmTfYffqCJhBWgvWtM00Vu2pYF551RHpbuTfu/PReppg/x+Recm/p0NosHPVeTjZuHDG4K9DNFVndpfPamITUHObmxvC6wWTkVOHLLNkJGtUY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7dca09-5f94-4ef9-e355-08d73ad0824d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 18:05:51.2963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sorUimhX39jS8nf6YNobme26v97hJV1MlfxYSM8PySkxQd84UhelS959Q9an5Kwc3PdX8P2opB+ROV+di8OSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

Sorry. Resending these patches as I got distracted with other stuff and
couldn't follow through. As per our previous discussion the plan was to
upstream these changes (mainly patch 3 "Export devcgroup_check_permission")
through Alex Deucher's amd-staging-drm-next and Dave Airlie's drm-next tree=
s. I
am planning to take this route. I have rebased my patches to
amd-staging-drm-next.

You and Roman acked patch 3, it will be great if I can Reviewed-by, so that=
 the
upstream path can be smoother.

Best Regards,
Harish

***** Original note about this patch series for ref. ****

amdkfd (part of amdgpu) driver supports the AMD GPU compute stack. amdkfd
exposes only a single device /dev/kfd even if multiple AMD GPU (compute)
devices exist in a system. However, amdgpu drvier exposes a separate render
device file /dev/dri/renderDN for each device. To participate in device cgr=
oup
amdkfd driver will rely on these rendner device files


