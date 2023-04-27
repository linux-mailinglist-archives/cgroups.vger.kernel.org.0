Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93B16F0A4B
	for <lists+cgroups@lfdr.de>; Thu, 27 Apr 2023 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbjD0QyI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Apr 2023 12:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244308AbjD0QyD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Apr 2023 12:54:03 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40902D44;
        Thu, 27 Apr 2023 09:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg2hV3V87khErcgoHH8whvyg7RgWFkt5ft0Gd+BKA4pfFAgUdPTWP8iz/mgofhdoEX3cZ90tmD2iFVJA9q6SlQ54KtDBuVTTYBUtuVMw0rh4r4lo2uTF95qfYzvPec3T8p+HnJz0bCDUkZiYIbvT//1c8dmepUsHfLRPBRkhdgYQ7OB4+A5WE98aYIltYVyha2afdzgOxRWXrtVSKcsV9xcNI9jb6x1pPbBu4QLB+efM2UYw1m/6vKw26+7LDG3s4c7zjAO8RvMI6h0DbZZPSP9DWUuWnil1JC7EwydeeMcqk14cKUXe6WGlFAZa0YF2/MA3ga7VuBE6arQC/i5KTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9VA/y0ULWdq2yOPtKaNNmChNlJPTp+5aSkzz1wc4b4=;
 b=Xw1P5urqrcUU6HzOMfOPIlvEOrhSg/UERvAPXt59Has4hyCWREEZBsYkFRQ+t+/sB7YkaM2OlMf3LW9/2m6YJgM42iwnkhZ8nVEK0pMXPeV3QlR/GC+sNC1mBmWh8UVrwd8Tmn/aysEc1a8muKUY4Prm9GJxaR80QmtB+RZ8CVisz6OAmbxnpHVN1YjgnGdPdoelU8EJo+BGFw7vaX6EoMidNpRvVYB0VXhjGyjRZAfTwbrbH+gU/Mng6kLEtPnt538Gz3xpirmPOdvf3lhUCND2otxWZIdmFH9JVR/EpWZX89Ok61NpJHSMogYmYlStUSeF46gS7Xj4DOpY5f10Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9VA/y0ULWdq2yOPtKaNNmChNlJPTp+5aSkzz1wc4b4=;
 b=CsoLQ34Q4UXb4wbeKJm1yQBEp3EmsTMJeIy4nvWjFaLcfFGkJ/JVim7AXgJ+DHfJEr9+Kx2Gos4ps0PE0BtcCKTzQAB2V39yv86Wa0Jzq4iUfLzMuWlnd1UZeTsBAOn/2QaqVE4Aa9LmwcwfyXU3gp/9qHbE6DMjlzN4csEYPWE=
Received: from DM6PR21MB1177.namprd21.prod.outlook.com (2603:10b6:5:161::25)
 by BL1PR21MB3331.namprd21.prod.outlook.com (2603:10b6:208:39c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.5; Thu, 27 Apr
 2023 16:53:52 +0000
Received: from DM6PR21MB1177.namprd21.prod.outlook.com
 ([fe80::5596:b228:b8ed:2a33]) by DM6PR21MB1177.namprd21.prod.outlook.com
 ([fe80::5596:b228:b8ed:2a33%6]) with mapi id 15.20.6363.009; Thu, 27 Apr 2023
 16:53:52 +0000
From:   Anand Krishnamoorthi <anakrish@microsoft.com>
To:     Mikko Ylinen <mikko.ylinen@linux.intel.com>,
        Liz Zhang <lizzha@microsoft.com>
CC:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Bo Zhang (ACC)" <zhanb@microsoft.com>,
        "zhiquan1.li@intel.com" <zhiquan1.li@intel.com>
Subject: Re: [EXTERNAL] [PATCH v2 00/18]  Add Cgroup support for SGX EPC
 memory
Thread-Topic: [EXTERNAL] [PATCH v2 00/18]  Add Cgroup support for SGX EPC
 memory
Thread-Index: AQHZBn0ZUYTbjHaiT0mTf4KgoZqzI68a1mCqgA+MvpiAB7oOgIAOJuXC
Date:   Thu, 27 Apr 2023 16:53:52 +0000
Message-ID: <DM6PR21MB11773AC7B4ED51BF1DC46AF8C46A9@DM6PR21MB1177.namprd21.prod.outlook.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <DM6PR21MB11778ABA54CD33A5822D5B24C4929@DM6PR21MB1177.namprd21.prod.outlook.com>
 <DM6PR21MB11772A6ED915825854B419D6C4989@DM6PR21MB1177.namprd21.prod.outlook.com>
 <ZD7Iutppjj+muH4p@himmelriiki>
In-Reply-To: <ZD7Iutppjj+muH4p@himmelriiki>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-27T16:53:51.912Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1177:EE_|BL1PR21MB3331:EE_
x-ms-office365-filtering-correlation-id: 3531d14c-e59a-4fd6-dc0f-08db473ffb2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oNzIPtjBdjk7+QELRVQk05167iwq0utXlVbQb9ZvxJ43X5GKjwsf9QPYS8EpqujrBapxq8undutQx+qvbzbTpQE586Mq9AG4HQlmCr0bsRl4CkXu09deOIb37mS+P6fRgG2RT+yuVHFMMv1c3ax3xC3gkG0rZS0ImiIkS0JM3qkAnT/5l4FvBbMS1teauun5mlnThzWgBYGPXE/5Ee+kxShBcLtKfcmbe+UEXv1EGYybZg3LCSdc1+tI0FuLNQbyCliWe5+7R2dmyZ0fTv7Pojfa7MULLOCXHPBVMOIRoyZPXupiQLMPHgNa5jEwSqmYD8qVB7Pqol9mpBmzNxj+8NJ4iz1HD+FVmMgFFqXbB23SlBy8XI1Ods3KBZh3A3s75LnEd/BgYcRSE28XRP7AO5hDwfNangtqA/VHpUZGQ36QJjsVEDd8vavAdonG4Va+VHHKJmrDKFMVDgR0Yzx0CCUH7eUMeLfmPsa7Wvd7gZZz4GWN6iVGM0FAqOpZ6s+jxlq5RFIzqE9CXE3jJmVbfCfQXAIN2eKQ7QPujhTHnbTZR4Tn57kKhl00dkhTIfY+3bg6YDwUN1VaDJX34QwTvH/zNYW7weTMUF2JnPVK91cn07Y0wPI+t9V3PHeGQa3GZNaaSJmdke4MXvTpQLeWe8CHLbRbYNh9UChGbyKhfLGbsRqZQQf5/1s3jUd1cMMO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1177.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(54906003)(10290500003)(478600001)(110136005)(82950400001)(86362001)(8936002)(52536014)(4326008)(8990500004)(5660300002)(33656002)(38100700002)(8676002)(2906002)(38070700005)(66946007)(66446008)(55016003)(316002)(786003)(82960400001)(6636002)(64756008)(66476007)(76116006)(66556008)(122000001)(41300700001)(186003)(966005)(91956017)(9686003)(6506007)(53546011)(71200400001)(7696005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?C6D1esQQodc/W5htfYQD6Q1UEWVw9oFrRzBe75ib/kxyb8bY5D33r/eHIe?=
 =?iso-8859-1?Q?QVdRa7GKzyEz0c2tZHTpBf8brviUKg+SnWLV9acAdyh7QTKSlTegdHbBnS?=
 =?iso-8859-1?Q?xU272N+a07UBdV1ThOUmMvmvhpcaEQKpgbI/IkYa82Ov7vV2CbAOEQEwQa?=
 =?iso-8859-1?Q?6eow0QRu7Zv9layyy8rrG4gBnXOiw2P/TBGaQnKiYVBeYO1ZIxL+TlRjFi?=
 =?iso-8859-1?Q?Q3h787Em4Ta4FpWsSGoInKOU/iYhMU3nbM3Pc+IdD5r22WhMFmJ4gKDp++?=
 =?iso-8859-1?Q?+vW05NYRif4o1U/QmybEZPHq8TFKYANnKbU+2h/OjSywDlKuPxqZY7rJVV?=
 =?iso-8859-1?Q?zv29a1E4gvMaRClNysAYzyJW7CfaSLGDiqM4RsIoMX+GcOOxB1sCwmeLif?=
 =?iso-8859-1?Q?UazZmbYKIyNxFDL0kn61MC3QfxEIemmpcmYrbgc+wUEI8TylKPn1kkCyiJ?=
 =?iso-8859-1?Q?f+bjuLXrRLaulZtKy1w2qJtbWFaDCUtuWMnK1VOrzDDxY8Pbo/tGK2t4Y0?=
 =?iso-8859-1?Q?Lh9az51xZzLba2K+ZeFhwYrBiSpKiSRRfgUsjks3XIYXot17rQaXGOr4Qh?=
 =?iso-8859-1?Q?xP3B2d4AVDfbBEQc+YjceZgj1n5khn/JppBj8w7CxOtc5PqbShIa5dPYfX?=
 =?iso-8859-1?Q?1MK1EXdvOYXkkjSFqWh38+Z3HxOE9YN+Yph5k9iG2xYzJYCqa1MKf98qEX?=
 =?iso-8859-1?Q?sgELxRsCY98/0x56jTqmKRTFY5T9zw1oDZMnuu+CzNS2DnIQCHI5kFLiPs?=
 =?iso-8859-1?Q?si5hTjVWItx+UTEPXdixGAIQCh5rXeuzlc4Y+MJss7hETuvehD2h9KMpAj?=
 =?iso-8859-1?Q?rahR4z8W+CQ2H3Zc9yD1j3yeU6LZd4GC29QjZ8k/OyDVgdZo/gj5JBPcln?=
 =?iso-8859-1?Q?qpvnJzgBWjFacEpURljuXtLn3Z3Wh7O973cZmHlMW6qhrn4dnjIXEJatJ8?=
 =?iso-8859-1?Q?IJ6jAgH9Yfcguh118o3ppVfOzkj6tXwhnnPJsT/wM0pWeTFGGtpJY7bSQh?=
 =?iso-8859-1?Q?xlV60PHHB5syyJdIDEF4HuCNl0LCe2IDvMDbZA4ZYZvVgtLDuxBw44wYA7?=
 =?iso-8859-1?Q?Z6URF6A6PU3b6opio24RkGBZ1XAEpslRgvO+lUkZTnQbbEjTwIBSCRiVrc?=
 =?iso-8859-1?Q?vADHhsrx1Cir1NzNRAo9Nqa03ZQJXyfdaKiw6nxRGtXgOTBFe2bfp3cemA?=
 =?iso-8859-1?Q?eGb7b5w+tMKmXNaHcM7Kpzz8hRmm2+ttggrR0wXL+LL+ZYZtDEVTOg2HM6?=
 =?iso-8859-1?Q?U6lFLgF1Y7nV4i2I9cxMJ+74Ve6OjkFOR6yCPo/oOL+RY7hk33BImY4Csy?=
 =?iso-8859-1?Q?ryyvBt3zamC3+5OR02gG+Tr5qOeglRE6Uj2jJv/+yfKRA9DL9cRSXebtGP?=
 =?iso-8859-1?Q?TKy0bxDZMX0aGHAF9VCm6xlzZ7F3HdUaPInYFRU+svAfHDqIF4V5d4AwcM?=
 =?iso-8859-1?Q?Je1zbmW1RaKAqDe1OOz4B4BPP0ueliV2Hf2rd/SBjQsL0dFOmGhKNPbw0+?=
 =?iso-8859-1?Q?egBrGn2PCZRxPTeAb5dbdkfOFkiznfzz3b9m76LgyHjgpTlsNej3QabEl2?=
 =?iso-8859-1?Q?DEQetl7763W6gwy9xg+NBzLx1ogYKIbmTbF8As5SbHbyUC1uMw0dfRI1+n?=
 =?iso-8859-1?Q?K11g97xktSZyB4i33oOFa4Iwu1A1s3yyf4kQKhZc0C9VnRRA8NHsiay6Li?=
 =?iso-8859-1?Q?LYLzrkzH3HpYcAkLQz+6oWc0QebqXYD1zkQO74Ps?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1177.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3531d14c-e59a-4fd6-dc0f-08db473ffb2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 16:53:52.5110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Fwc6OzMLb/RWHUcRA6tidwH6bWTo27pc0g6/Rr5ygkyFbtMuf/Bz8K/3U9XdW8tL4CVY8hiO5LObAJa1wuERQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3331
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Adding Liz Zhang.




From: Mikko Ylinen <mikko.ylinen@linux.intel.com>
Sent: Tuesday, April 18, 2023 9:44 AM
To: Anand Krishnamoorthi <anakrish@microsoft.com>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>; jarkko@kernel.org <j=
arkko@kernel.org>; dave.hansen@linux.intel.com <dave.hansen@linux.intel.com=
>; tj@kernel.org <tj@kernel.org>; linux-kernel@vger.kernel.org <linux-kerne=
l@vger.kernel.org>; linux-sgx@vger.kernel.org <linux-sgx@vger.kernel.org>; =
cgroups@vger.kernel.org <cgroups@vger.kernel.org>; Bo Zhang (ACC) <zhanb@mi=
crosoft.com>; zhiquan1.li@intel.com <zhiquan1.li@intel.com>
Subject: Re: [EXTERNAL] [PATCH v2 00/18] Add Cgroup support for SGX EPC mem=
ory

[Some people who received this message don't often get email from mikko.yli=
nen@linux.intel.com. Learn why this is important at https://aka.ms/LearnAbo=
utSenderIdentification ]

Hi,

On Thu, Apr 13, 2023 at 06:49:53PM +0000, Anand Krishnamoorthi wrote:
> For Azure, SGX cgroup support feature is very useful.
> It is needed to enforce the EPC resource limitation of Kubernetes pods on=
 SGX nodes.

I've been working on enabling the same use case with the difference that
I'm setting per container EPC limits (instead of pods). The Open Container
Initiative (OCI) runtime spec [1] defines how it's done and with the misc
controller implemented here "misc.max": "sgx_epc 42" setting for a containe=
r
is supported by runc out of the box.

In addition to being able to set limits per container/pod, the cgroup for
SGX EPC helps to build better telemetry/monitoring for EPC consumtion.

[1] https://github.com/opencontainers/runtime-spec/blob/main/config-linux.m=
d#unified

>
> Today, in Azure Kubernetes Service, each pod on SGX node claims a nominal=
 EPC memory requirement. K8s will track the unclaimed EPC memories on SGX n=
odes to schedule pods.
> However, there's no enforcement on the node whether the pod uses more EPC=
 memory than what it claims. If EPC is running out on the node, the kernel =
will do EPC paging, which will cause all pods suffering performance degrada=
tion.
>
> Cgroup support for EPC will enforce EPC resource limitation on pod level,=
 so that when a pod tries to use more EPC than what it claims, it will be E=
PC paged while other pods are not affected.
>
> -Anand
>
> From: Anand Krishnamoorthi <anakrish@microsoft.com>
> Sent: Monday, April 3, 2023 2:26 PM
> To: Kristen Carlson Accardi <kristen@linux.intel.com>; jarkko@kernel.org =
<jarkko@kernel.org>; dave.hansen@linux.intel.com <dave.hansen@linux.intel.c=
om>; tj@kernel.org <tj@kernel.org>; linux-kernel@vger.kernel.org <linux-ker=
nel@vger.kernel.org>; linux-sgx@vger.kernel.org <linux-sgx@vger.kernel.org>=
; cgroups@vger.kernel.org <cgroups@vger.kernel.org>; Bo Zhang (ACC) <zhanb@=
microsoft.com>
> Cc: zhiquan1.li@intel.com <zhiquan1.li@intel.com>
> Subject: Re: [EXTERNAL] [PATCH v2 00/18] Add Cgroup support for SGX EPC m=
emory
>
> Adding Bo Zhang to thread.
>
> -Anand
>
>
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> Sent: Friday, December 2, 2022 10:36 AM
> To: jarkko@kernel.org <jarkko@kernel.org>; dave.hansen@linux.intel.com <d=
ave.hansen@linux.intel.com>; tj@kernel.org <tj@kernel.org>; linux-kernel@vg=
er.kernel.org <linux-kernel@vger.kernel.org>; linux-sgx@vger.kernel.org <li=
nux-sgx@vger.kernel.org>; cgroups@vger.kernel.org <cgroups@vger.kernel.org>
> Cc: zhiquan1.li@intel.com <zhiquan1.li@intel.com>
> Subject: [EXTERNAL] [PATCH v2 00/18] Add Cgroup support for SGX EPC memor=
y
>
> Utilize the Miscellaneous cgroup controller to regulate the distribution
> of SGX EPC memory, which is a subset of system RAM that is used to provid=
e
> SGX-enabled applications with protected memory, and is otherwise inaccess=
ible.
>
> SGX EPC memory allocations are separate from normal RAM allocations,
> and is managed solely by the SGX subsystem. The existing cgroup memory
> controller cannot be used to limit or account for SGX EPC memory.
>
> This patchset implements the support for sgx_epc memory within the
> misc cgroup controller, and then utilizes the misc cgroup controller
> to provide support for setting the total system capacity, max limit
> per cgroup, and events.
>
> This work was originally authored by Sean Christopherson a few years ago,
> and was modified to work with more recent kernels, and to utilize the
> misc cgroup controller rather than a custom controller. It is currently
> based on top of the MCA patches.
>
> Here's the MCA patchset for reference.
> https://lore.kernel.org/linux-sgx/2d52c8c4-8ed0-6df2-2911-da5b9fcc9ae4@in=
tel.com/T/#t
>
> The patchset adds support for multiple LRUs to track both reclaimable
> EPC pages (i.e. pages the reclaimer knows about), as well as unreclaimabl=
e
> EPC pages (i.e. pages which the reclaimer isn't aware of, such as va page=
s).
> These pages are assigned to an LRU, as well as an enclave, so that an
> enclave's full EPC usage can be tracked, and limited to a max value. Duri=
ng
> OOM events, an enclave can be have its memory zapped, and all the EPC pag=
es
> not tracked by the reclaimer can be freed.
>
> I appreciate your comments and feedback.
>
> Changelog:
>
> v2:
>  * rename struct sgx_epc_lru to sgx_epc_lru_lists to be more clear
>    that this struct contains 2 lists.
>  * use inline functions rather than macros for sgx_epc_page_list*
>    wrappers.
>  * Remove flags macros and open code all flags.
>  * Improve the commit message for RECLAIM_IN_PROGRESS patch to make
>    it more clear what the patch does.
>  * remove notifier_block from misc cgroup changes and use a set
>    of ops for callbacks instead.
>  * rename root_misc to misc_cg_root and parent_misc to misc_cg_parent
>  * consolidate misc cgroup changes to 2 patches and remove most of
>    the previous helper functions.
>
> Kristen Carlson Accardi (7):
>   x86/sgx: Add 'struct sgx_epc_lru_lists' to encapsulate lru list(s)
>   x86/sgx: Use sgx_epc_lru_lists for existing active page list
>   x86/sgx: Track epc pages on reclaimable or unreclaimable lists
>   cgroup/misc: Add per resource callbacks for css events
>   cgroup/misc: Prepare for SGX usage
>   x86/sgx: Add support for misc cgroup controller
>   Docs/x86/sgx: Add description for cgroup support
>
> Sean Christopherson (11):
>   x86/sgx: Call cond_resched() at the end of sgx_reclaim_pages()
>   x86/sgx: Store struct sgx_encl when allocating new VA pages
>   x86/sgx: Introduce RECLAIM_IN_PROGRESS flag for EPC pages
>   x86/sgx: Use a list to track to-be-reclaimed pages during reclaim
>   x86/sgx: Allow reclaiming up to 32 pages, but scan 16 by default
>   x86/sgx: Return the number of EPC pages that were successfully
>     reclaimed
>   x86/sgx: Add option to ignore age of page during EPC reclaim
>   x86/sgx: Prepare for multiple LRUs
>   x86/sgx: Expose sgx_reclaim_pages() for use by EPC cgroup
>   x86/sgx: Add helper to grab pages from an arbitrary EPC LRU
>   x86/sgx: Add EPC OOM path to forcefully reclaim EPC
>
>  Documentation/x86/sgx.rst            |  77 ++++
>  arch/x86/Kconfig                     |  13 +
>  arch/x86/kernel/cpu/sgx/Makefile     |   1 +
>  arch/x86/kernel/cpu/sgx/encl.c       |  90 ++++-
>  arch/x86/kernel/cpu/sgx/encl.h       |   4 +-
>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 539 +++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |  59 +++
>  arch/x86/kernel/cpu/sgx/ioctl.c      |  14 +-
>  arch/x86/kernel/cpu/sgx/main.c       | 412 ++++++++++++++++----
>  arch/x86/kernel/cpu/sgx/sgx.h        | 122 +++++-
>  arch/x86/kernel/cpu/sgx/virt.c       |  28 +-
>  include/linux/misc_cgroup.h          |  35 ++
>  kernel/cgroup/misc.c                 |  76 +++-
>  13 files changed, 1341 insertions(+), 129 deletions(-)
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.c
>  create mode 100644 arch/x86/kernel/cpu/sgx/epc_cgroup.h
>
> --
> 2.38.1

--
Regards, Mikko
