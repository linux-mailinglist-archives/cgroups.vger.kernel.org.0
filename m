Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C384DD17C9
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2019 20:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfJISwN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Oct 2019 14:52:13 -0400
Received: from mail-eopbgr800041.outbound.protection.outlook.com ([40.107.80.41]:21190
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730490AbfJISwN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 9 Oct 2019 14:52:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6EbnyfqDvrHDL8uEi1iX56qXJ2k8U3ahlaxInlVojth9afnyN4k9ApF+l0lr7LMRHz5EXEydtmjMikEhIc/aoLqKnCQWB9OTuBmbIjmH+2bKrYLfj8s/dGWKnUUHVQ0yZRgcfkJVACd9u/yuHYWqdFnpQOQT2MW35G3b4RAbBfjeiT3O1xvW8H60np1K5iyxN8rkfIqAJilQ+PVvH9VTZEpjXvua5V1vWHFSOttlcJ7NT/YE7yfTly+P8Gm0dH4PwzVcRc1L+Thmn1Ngrc+zFGxTEIDW8XEdnwWFqYjYBM7qIt+5/sY70RARuzX0GKkr8zf9iFIoFPVJQqoiEhXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJE58OhJv5vGbqUBw23Y5InTz90gGGlYH2hq4lCe1lg=;
 b=MW9i9Za+ZwY7goiM5zXT9iyUYsXa/6g69xlty5BYWfTWhX+Ba/9XSsj2TOvvNEp+D3rxYQFVl1eXGtJe6G2SUc2wPCc93tG3n+dugsegYKYHsAP5rUWCD2sRLYMaypyhqDctU4SGdv78wHjQQSfNqIYIAJ6m3C+3Tgw8fvGCEDKwtFAFjOvuHMxRlRikAuVD83MeOWqscSKZbcyfalQFFaePYCWEx3oab8NJfypap/LamV12p2+jydbLmEnQ+lD6kT6nNPQQxcCIXFofufK8TNsQ1YkYcdbXxVwpKvSHsnT36mYQkEscizPay69skGi24aQf/JTp8G89RJysDk2vBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJE58OhJv5vGbqUBw23Y5InTz90gGGlYH2hq4lCe1lg=;
 b=a5n2zsHF3mb5hKRZpTPBDQ8gg1CwkaxvzGVAdGsLdXOr7RM6c/9tNOfoRhxec3i/Av8agf+3M6csJXr8AZY/FbHLBu0gImV9Zkwu68VPxU0lJdQcoXVHQ6mLl9u5/f1w03INS+vKFTeOlFDD9yl8DZrlVMWaljxc7yYOqhpaa3U=
Received: from CY4PR12MB1767.namprd12.prod.outlook.com (10.175.62.137) by
 CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Wed, 9 Oct 2019 18:52:03 +0000
Received: from CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::bd28:116c:b1f2:8753]) by CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::bd28:116c:b1f2:8753%10]) with mapi id 15.20.2347.016; Wed, 9 Oct 2019
 18:52:03 +0000
From:   "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC:     "Ho, Kenny" <Kenny.Ho@amd.com>,
        "y2kenny@gmail.com" <y2kenny@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "jsparks@cray.com" <jsparks@cray.com>,
        "lkaplan@cray.com" <lkaplan@cray.com>
Subject: RE: [PATCH RFC v4 14/16] drm, cgroup: Introduce lgpu as DRM cgroup
 resource
Thread-Topic: [PATCH RFC v4 14/16] drm, cgroup: Introduce lgpu as DRM cgroup
 resource
Thread-Index: AQHVXi/hZf2pioSHekyans0yCEreb6dRVusAgAEGPYCAAFIAAIAAAoyAgAAFXgCAAAOuAIAAIcjw
Date:   Wed, 9 Oct 2019 18:52:03 +0000
Message-ID: <CY4PR12MB17670EE9EE4A22663EB584E8F9950@CY4PR12MB1767.namprd12.prod.outlook.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-15-Kenny.Ho@amd.com>
 <b3d2b3c1-8854-10ca-3e39-b3bef35bdfa9@amd.com>
 <20191009103153.GU16989@phenom.ffwll.local>
 <ee873e89-48fd-c4c9-1ce0-73965f4ad2ba@amd.com>
 <20191009153429.GI16989@phenom.ffwll.local>
 <c7812af4-7ec4-02bb-ff4c-21dd114cf38e@amd.com>
 <20191009160652.GO16989@phenom.ffwll.local>
In-Reply-To: <20191009160652.GO16989@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Greathouse@amd.com; 
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13f0cd0c-bcee-4217-203d-08d74ce9c682
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CY4PR12MB1925:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB19255ADB9E13AE62D5C5C390F9950@CY4PR12MB1925.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(25786009)(76176011)(53546011)(6506007)(6306002)(55016002)(7696005)(9686003)(6636002)(86362001)(446003)(52536014)(71190400001)(478600001)(71200400001)(256004)(11346002)(14444005)(8676002)(6436002)(102836004)(5660300002)(54906003)(66476007)(8936002)(966005)(6246003)(66946007)(26005)(14454004)(110136005)(76116006)(486006)(186003)(66446008)(64756008)(66556008)(66066001)(99286004)(2906002)(476003)(316002)(33656002)(4326008)(229853002)(6116002)(7736002)(305945005)(81166006)(74316002)(3846002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1925;H:CY4PR12MB1767.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vDKmuOCfs+fEgNrdgP7z99RxgJMum1dTjxAoqxuehdG2vlrjWiaGgt5MWCFgZMfVbbvelXUU7xVrLhPPDfReT4p/HPmtH6u4+FBbnlmn7/ckSOA/86BQXWwVae+2vzO6246ZaAy0aqM9GBZjgompUAYPAxlfGZHvpTbJjtLXH6kIRYTEkk2vqXOie6+gVx1yykv0keTB+4iES2p4S4O3b+BTfInEmpnC4AXpxneeRzo4oQ5F0nWgsUrZEROQHSktafF6iCq6GXz6cWeaWsvqdgfN0ekAaVlVl2tCgWSTJIsFC1Y7Zs6o7HMsetX6+cUNuQXDrYdXv2lHQZteijENXWk5STH6mSbXSAOZmv/eEpT8/3uTqkVwMBIMchhuaKUkonZTLGX2OzWavBkep1IuxVWayf1vu5yWTxbCKhR7LUCtfLFRuYlnpwc0gtAjcNrFmEJwvdRt3IDzTUYGhLd3bA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f0cd0c-bcee-4217-203d-08d74ce9c682
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 18:52:03.5473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F96u6JHyXnHSDuDZ/GlEyC2YY1V+tpJ411OdAgmQ89pRaegqI3lAdBRuKNv7y4/0aMr9pCvxEEQ7Qkt1zuYAOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1925
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Daniel Vetter <daniel.vetter@ffwll.ch> On Behalf Of Daniel Vetter
> Sent: Wednesday, October 9, 2019 11:07 AM
> On Wed, Oct 09, 2019 at 03:53:42PM +0000, Kuehling, Felix wrote:
> > On 2019-10-09 11:34, Daniel Vetter wrote:
> > > On Wed, Oct 09, 2019 at 03:25:22PM +0000, Kuehling, Felix wrote:
> > >> On 2019-10-09 6:31, Daniel Vetter wrote:
> > >>> On Tue, Oct 08, 2019 at 06:53:18PM +0000, Kuehling, Felix wrote:
> > >>>> The description sounds reasonable to me and maps well to the CU ma=
sking
> > >>>> feature in our GPUs.
> > >>>>
> > >>>> It would also allow us to do more coarse-grained masking for examp=
le to
> > >>>> guarantee balanced allocation of CUs across shader engines or
> > >>>> partitioning of memory bandwidth or CP pipes (if that is supported=
 by
> > >>>> the hardware/firmware).
> > >>> Hm, so this sounds like the definition for how this cgroup is suppo=
sed to
> > >>> work is "amd CU masking" (whatever that exactly is). And the abstra=
ct
> > >>> description is just prettification on top, but not actually the rea=
l
> > >>> definition you guys want.
> > >> I think you're reading this as the opposite of what I was trying to =
say.
> > >> Using CU masking is one possible implementation of LGPUs on AMD
> > >> hardware. It's the one that Kenny implemented at the end of this pat=
ch
> > >> series, and I pointed out some problems with that approach. Other wa=
ys
> > >> to partition the hardware into LGPUs are conceivable. For example we=
're
> > >> considering splitting it along the lines of shader engines, which is
> > >> more coarse-grain and would also affect memory bandwidth available t=
o
> > >> each partition.
> > > If this is supposed to be useful for admins then "other ways to parti=
tion
> > > the hw are conceivable" is the problem. This should be unique&clear f=
or
> > > admins/end-users. Reading the implementation details and realizing th=
at
> > > the actual meaning is "amd CU masking" isn't good enough by far, sinc=
e
> > > that's meaningless on any other hw.
> > >
> > > And if there's other ways to implement this cgroup for amd, it's also
> > > meaningless (to sysadmins/users) for amd hw.
> > >
> > >> We could also consider partitioning pipes in our command processor,
> > >> although that is not supported by our current CP scheduler firmware.
> > >>
> > >> The bottom line is, the LGPU model proposed by Kenny is quite abstra=
ct
> > >> and allows drivers implementing it a lot of flexibility depending on=
 the
> > >> capability of their hardware and firmware. We haven't settled on a f=
inal
> > >> implementation choice even for AMD.
> > > That abstract model of essentially "anything goes" is the problem her=
e
> > > imo. E.g. for cpu cgroups this would be similar to allowing the bitma=
ks to
> > > mean "cpu core" on one machine "physical die" on the next and maybe
> > > "hyperthread unit" on the 3rd. Useless for admins.
> > >
> > > So if we have a gpu bitmaks thing that might mean a command submissio=
 pipe
> > > on one hw (maybe matching what vk exposed, maybe not), some compute u=
nit
> > > mask on the next and something entirely different (e.g. intel has so
> > > called GT slices with compute cores + more stuff around) on the 3rd v=
endor
> > > then that's not useful for admins.
> >
> > The goal is to partition GPU compute resources to eliminate as much
> > resource contention as possible between different partitions. Different
> > hardware will have different capabilities to implement this. No
> > implementation will be perfect. For example, even with CPU cores that
> > are supposedly well defined, you can still have different behaviours
> > depending on CPU cache architectures, NUMA and thermal management acros=
s
> > CPU cores. The admin will need some knowledge of their hardware
> > architecture to understand those effects that are not described by the
> > abstract model of cgroups.
>=20
> That's not the point I was making. For cpu cgroups there's a very well
> defined connection between the cpu bitmasks/numbers in cgroups and the cp=
u
> bitmasks you use in various system calls (they match). And that stuff
> works across vendors.
>=20
> We need the same for gpus.
>=20
> > The LGPU model is deliberately flexible, because GPU architectures are
> > much less standardized than CPU architectures. Expecting a common model
> > that is both very specific and applicable to to all GPUs is unrealistic=
,
> > in my opinion.
>=20
> So pure abstraction isn't useful, we need to know what these bits mean.
> Since if they e.g. mean vk pipes, then maybe I shouldn't be using those v=
k
> pipes in my application anymore. Or we need to define that the userspace
> driver needs to filter out any pipes that arent' accessible (if that's
> possible, no idea).
>=20
> cgroups that essentially have pure hw depedent meaning aren't useful.
> Note: this is about the fundamental meaning, not about the more unclear
> isolation guarantees (which are indeed hw specific on different cpu
> platforms). We're not talking about "different gpus might have different
> amounts of shared caches bitween different bitmasks". We're talking
> "different gpus might assign completely differen meaning to these
> bitmasks".
> -Daniel
<snip>

One thing that comes to mind is the OpenCL 1.2+ SubDevices mechanism: https=
://www.khronos.org/registry/OpenCL/sdk/1.2/docs/man/xhtml/clCreateSubDevice=
s.html

The concept of LGPU in cgroups seems to match up nicely with an OpenCL SubD=
evice, at least for compute tasks. We want to divide up the device and give=
 some configurable subset of it to the user as a logical GPU or sub-device.
=20
OpenCL defines Compute Units (CUs), and any GPU vendor that runs OpenCL has=
 some mapping of their internal compute resources to this concept of CUs. O=
ff the top of my head (I may be misremembering some of these):
- AMD: Compute Units (CUs)
- ARM: Shader Cores (SCs)
- Intel: Execution Units (EUs)
- Nvidia: Streaming Multiprocessors (SMs)
- Qualcomm: Shader Processors (SPs)

The clCreateSubDevices() API has a variety of ways to slice and dice these =
compute resources across sub-devices. PARTITION_EQUALLY and PARTITION_BY_CO=
UNTS could possibly be handled by a simple high-level mechanism that just a=
llows you to request some percentage of the available GPU compute resources=
.

PARTITION_BY_AFFINITY_DOMAIN, however, splits up the CUs based on lower-lev=
el information such as what cache levels are shared or what NUMA domain a c=
ollection of CUs is in. I would argue that a runtime that wants to do this =
needs to know a bit about the mapping of CUs to underlying hardware resourc=
es.

A cgroup implementation that presented a CU bitmap could sit at the bottom =
of all three of these partitioning schemes, and more advanced ones if they =
come up. We might be getting side-tracked by the fact that AMD calls its re=
sources CUs. The OpenCL (or Vulkan, etc.) concept of a Compute Unit is cros=
s-vendor. The concept of targeting work to [Khronos-defined] Compute Units =
isn't AMD-specific. A bitmap of [Khronos-defined] CUs could map to any of t=
hese broad vendor compute resources.

There may be other parts of the GPU that we want to divide up -- command qu=
eue resources, pipes, render backends, etc. I'm not sure if any of those ha=
ve been "standardized" between GPUs to such an extent that they make sense =
to put into cgroups yet -- I'm ignorant outside of the compute world. But a=
t least the concept of CUs (or SMs, or EUs, etc.) seems to be standard acro=
ss GPUs and (to me anyway) seems like a reasonable place to allows administ=
rators, developers, users, etc. to divide up their GPUs.

And whatever mechanisms a GPU vendor may put in place to do clCreateSubDevi=
ces() could then be additionally used inside the kernel for their cgroups L=
GPU partitioning.

Thanks
-Joe
