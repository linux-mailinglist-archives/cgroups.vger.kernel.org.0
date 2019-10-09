Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC924D17FC
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2019 21:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbfJITHd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Oct 2019 15:07:33 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45884 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJITHd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Oct 2019 15:07:33 -0400
Received: by mail-oi1-f194.google.com with SMTP id o205so2694041oib.12
        for <cgroups@vger.kernel.org>; Wed, 09 Oct 2019 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+bPchlFe8P2b2yUmNa3bdQRxfJiv3mEq1TIKEwwgaCA=;
        b=eQm1ILqVl4R8BVPAkNWC62rAuJ723z1q89mJG9W3MDId8npaCH1OILGRviLl5+2VIk
         HSaAAi7n/ozR1aoJRPX2/wOs0uW/gS3dZoaaB1NUYpO3+q2Z+AxrG3bUfvNpwXF6Rq6Z
         zfxNSB/6YU5XiSg1G9YjI3u2gKwVa4j8z2c80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+bPchlFe8P2b2yUmNa3bdQRxfJiv3mEq1TIKEwwgaCA=;
        b=bB2pw0QWpT+EIIRAMg5v2w6s0TC64vZvtdsLW/m8lvzE/Om/PafbRvm6A1bnoE1uR6
         Jp3ewypNfzGBN4jmVFmGzbzwRENsizCWhmklh/08soUGXBHhEg/eJyuswW6H31m9UDuz
         1V3l+tmcc/Q9IRbU+E2g5coAVZesmLJToMiG/U11xGM3Ki5dAbpcNNKV7WkZ+rPtE3KO
         K40g/4beQdaDbu8CC1VM4+8HSvJ0UvOW8zcDoxg1Iw0pqREcz33XkiMU+1tqCLZKi/Ex
         B91kH+fPfapEdnERFMjaOqPBp5uwiSuHhpQCmSHrdoc5V/aFgfU0m+NbxIi6cex/z9Ed
         c1Pg==
X-Gm-Message-State: APjAAAVK08aL7Th7rRmTRjiSdqMyuROiOYszOr0wxKgmsUzGCxVFRu/3
        eFZLrtzflQKk261u53uK4aJRqbis3BAOROXyKTYmjyEx
X-Google-Smtp-Source: APXvYqwSUFOOOJ8ln69YHDocHtnBdeHrDx8380DSqrznfXZtj1SaatRepgfNeKZqgVuHcnyfsQzw5UJx6mvxevt0oI0=
X-Received: by 2002:a54:4e8a:: with SMTP id c10mr3863413oiy.14.1570648051625;
 Wed, 09 Oct 2019 12:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190829060533.32315-15-Kenny.Ho@amd.com>
 <b3d2b3c1-8854-10ca-3e39-b3bef35bdfa9@amd.com> <20191009103153.GU16989@phenom.ffwll.local>
 <ee873e89-48fd-c4c9-1ce0-73965f4ad2ba@amd.com> <20191009153429.GI16989@phenom.ffwll.local>
 <c7812af4-7ec4-02bb-ff4c-21dd114cf38e@amd.com> <20191009160652.GO16989@phenom.ffwll.local>
 <CY4PR12MB17670EE9EE4A22663EB584E8F9950@CY4PR12MB1767.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB17670EE9EE4A22663EB584E8F9950@CY4PR12MB1767.namprd12.prod.outlook.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 9 Oct 2019 21:07:20 +0200
Message-ID: <CAKMK7uHO74GHf7c-SJ00O4rRKkh7C7AytpTZAnrKye0ZKKpTzw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 14/16] drm, cgroup: Introduce lgpu as DRM cgroup resource
To:     "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Nouveau Dev <nouveau@lists.freedesktop.org>
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Ho, Kenny" <Kenny.Ho@amd.com>,
        "y2kenny@gmail.com" <y2kenny@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "jsparks@cray.com" <jsparks@cray.com>,
        "lkaplan@cray.com" <lkaplan@cray.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 9, 2019 at 8:52 PM Greathouse, Joseph
<Joseph.Greathouse@amd.com> wrote:
>
> > From: Daniel Vetter <daniel.vetter@ffwll.ch> On Behalf Of Daniel Vetter
> > Sent: Wednesday, October 9, 2019 11:07 AM
> > On Wed, Oct 09, 2019 at 03:53:42PM +0000, Kuehling, Felix wrote:
> > > On 2019-10-09 11:34, Daniel Vetter wrote:
> > > > On Wed, Oct 09, 2019 at 03:25:22PM +0000, Kuehling, Felix wrote:
> > > >> On 2019-10-09 6:31, Daniel Vetter wrote:
> > > >>> On Tue, Oct 08, 2019 at 06:53:18PM +0000, Kuehling, Felix wrote:
> > > >>>> The description sounds reasonable to me and maps well to the CU =
masking
> > > >>>> feature in our GPUs.
> > > >>>>
> > > >>>> It would also allow us to do more coarse-grained masking for exa=
mple to
> > > >>>> guarantee balanced allocation of CUs across shader engines or
> > > >>>> partitioning of memory bandwidth or CP pipes (if that is support=
ed by
> > > >>>> the hardware/firmware).
> > > >>> Hm, so this sounds like the definition for how this cgroup is sup=
posed to
> > > >>> work is "amd CU masking" (whatever that exactly is). And the abst=
ract
> > > >>> description is just prettification on top, but not actually the r=
eal
> > > >>> definition you guys want.
> > > >> I think you're reading this as the opposite of what I was trying t=
o say.
> > > >> Using CU masking is one possible implementation of LGPUs on AMD
> > > >> hardware. It's the one that Kenny implemented at the end of this p=
atch
> > > >> series, and I pointed out some problems with that approach. Other =
ways
> > > >> to partition the hardware into LGPUs are conceivable. For example =
we're
> > > >> considering splitting it along the lines of shader engines, which =
is
> > > >> more coarse-grain and would also affect memory bandwidth available=
 to
> > > >> each partition.
> > > > If this is supposed to be useful for admins then "other ways to par=
tition
> > > > the hw are conceivable" is the problem. This should be unique&clear=
 for
> > > > admins/end-users. Reading the implementation details and realizing =
that
> > > > the actual meaning is "amd CU masking" isn't good enough by far, si=
nce
> > > > that's meaningless on any other hw.
> > > >
> > > > And if there's other ways to implement this cgroup for amd, it's al=
so
> > > > meaningless (to sysadmins/users) for amd hw.
> > > >
> > > >> We could also consider partitioning pipes in our command processor=
,
> > > >> although that is not supported by our current CP scheduler firmwar=
e.
> > > >>
> > > >> The bottom line is, the LGPU model proposed by Kenny is quite abst=
ract
> > > >> and allows drivers implementing it a lot of flexibility depending =
on the
> > > >> capability of their hardware and firmware. We haven't settled on a=
 final
> > > >> implementation choice even for AMD.
> > > > That abstract model of essentially "anything goes" is the problem h=
ere
> > > > imo. E.g. for cpu cgroups this would be similar to allowing the bit=
maks to
> > > > mean "cpu core" on one machine "physical die" on the next and maybe
> > > > "hyperthread unit" on the 3rd. Useless for admins.
> > > >
> > > > So if we have a gpu bitmaks thing that might mean a command submiss=
io pipe
> > > > on one hw (maybe matching what vk exposed, maybe not), some compute=
 unit
> > > > mask on the next and something entirely different (e.g. intel has s=
o
> > > > called GT slices with compute cores + more stuff around) on the 3rd=
 vendor
> > > > then that's not useful for admins.
> > >
> > > The goal is to partition GPU compute resources to eliminate as much
> > > resource contention as possible between different partitions. Differe=
nt
> > > hardware will have different capabilities to implement this. No
> > > implementation will be perfect. For example, even with CPU cores that
> > > are supposedly well defined, you can still have different behaviours
> > > depending on CPU cache architectures, NUMA and thermal management acr=
oss
> > > CPU cores. The admin will need some knowledge of their hardware
> > > architecture to understand those effects that are not described by th=
e
> > > abstract model of cgroups.
> >
> > That's not the point I was making. For cpu cgroups there's a very well
> > defined connection between the cpu bitmasks/numbers in cgroups and the =
cpu
> > bitmasks you use in various system calls (they match). And that stuff
> > works across vendors.
> >
> > We need the same for gpus.
> >
> > > The LGPU model is deliberately flexible, because GPU architectures ar=
e
> > > much less standardized than CPU architectures. Expecting a common mod=
el
> > > that is both very specific and applicable to to all GPUs is unrealist=
ic,
> > > in my opinion.
> >
> > So pure abstraction isn't useful, we need to know what these bits mean.
> > Since if they e.g. mean vk pipes, then maybe I shouldn't be using those=
 vk
> > pipes in my application anymore. Or we need to define that the userspac=
e
> > driver needs to filter out any pipes that arent' accessible (if that's
> > possible, no idea).
> >
> > cgroups that essentially have pure hw depedent meaning aren't useful.
> > Note: this is about the fundamental meaning, not about the more unclear
> > isolation guarantees (which are indeed hw specific on different cpu
> > platforms). We're not talking about "different gpus might have differen=
t
> > amounts of shared caches bitween different bitmasks". We're talking
> > "different gpus might assign completely differen meaning to these
> > bitmasks".
> > -Daniel
> <snip>
>
> One thing that comes to mind is the OpenCL 1.2+ SubDevices mechanism: htt=
ps://www.khronos.org/registry/OpenCL/sdk/1.2/docs/man/xhtml/clCreateSubDevi=
ces.html
>
> The concept of LGPU in cgroups seems to match up nicely with an OpenCL Su=
bDevice, at least for compute tasks. We want to divide up the device and gi=
ve some configurable subset of it to the user as a logical GPU or sub-devic=
e.
>
> OpenCL defines Compute Units (CUs), and any GPU vendor that runs OpenCL h=
as some mapping of their internal compute resources to this concept of CUs.=
 Off the top of my head (I may be misremembering some of these):
> - AMD: Compute Units (CUs)
> - ARM: Shader Cores (SCs)
> - Intel: Execution Units (EUs)
> - Nvidia: Streaming Multiprocessors (SMs)
> - Qualcomm: Shader Processors (SPs)
>
> The clCreateSubDevices() API has a variety of ways to slice and dice thes=
e compute resources across sub-devices. PARTITION_EQUALLY and PARTITION_BY_=
COUNTS could possibly be handled by a simple high-level mechanism that just=
 allows you to request some percentage of the available GPU compute resourc=
es.
>
> PARTITION_BY_AFFINITY_DOMAIN, however, splits up the CUs based on lower-l=
evel information such as what cache levels are shared or what NUMA domain a=
 collection of CUs is in. I would argue that a runtime that wants to do thi=
s needs to know a bit about the mapping of CUs to underlying hardware resou=
rces.
>
> A cgroup implementation that presented a CU bitmap could sit at the botto=
m of all three of these partitioning schemes, and more advanced ones if the=
y come up. We might be getting side-tracked by the fact that AMD calls its =
resources CUs. The OpenCL (or Vulkan, etc.) concept of a Compute Unit is cr=
oss-vendor. The concept of targeting work to [Khronos-defined] Compute Unit=
s isn't AMD-specific. A bitmap of [Khronos-defined] CUs could map to any of=
 these broad vendor compute resources.
>
> There may be other parts of the GPU that we want to divide up -- command =
queue resources, pipes, render backends, etc. I'm not sure if any of those =
have been "standardized" between GPUs to such an extent that they make sens=
e to put into cgroups yet -- I'm ignorant outside of the compute world. But=
 at least the concept of CUs (or SMs, or EUs, etc.) seems to be standard ac=
ross GPUs and (to me anyway) seems like a reasonable place to allows admini=
strators, developers, users, etc. to divide up their GPUs.
>
> And whatever mechanisms a GPU vendor may put in place to do clCreateSubDe=
vices() could then be additionally used inside the kernel for their cgroups=
 LGPU partitioning.

Yeah this is the stuff I meant. I quickly checked intel's CL driver,
and from a quick look we don't support that. Adding Karol, who might
know whether this works on nvidia hw and how. If opencl CU don't
really apply to more than amdgpu, then that's not really helping much
with making this stuff more broadly useful.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
