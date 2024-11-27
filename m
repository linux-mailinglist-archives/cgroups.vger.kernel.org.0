Return-Path: <cgroups+bounces-5706-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19BF9DAFE5
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2024 00:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A075164E60
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2024 23:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C0819939D;
	Wed, 27 Nov 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6wUeIa4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A51990D6
	for <cgroups@vger.kernel.org>; Wed, 27 Nov 2024 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732750728; cv=none; b=N9sqkQ9F7JgaLRAtQOT4UDvgtmFDfx/iddAR8VrCu1E+aowfzZNgHhMJMJikHBu21ttMA3A44dktKnnDZClByd0doyaHd2Vteq72zuILGYYbzFpzQWFJ86RUVcdLrqTIKehV3im3jIbKnIuTIz1u9PjiHXuBpOttDjzl/ADHMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732750728; c=relaxed/simple;
	bh=wWxmOxXxJwf00+naJRgY3wwuTvdFhzk21ESuvkmq7a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fmwm019qf+bzmWVw82/f6GvS4X5PkoYfcOwbfpB+hjvQINrn5B3nHIiTbcNYNx2CiK4v6zUx4n880bT+5ch7/BUsW7FopRRlKOy/GVq/SC49YpCQYRCyB1BZaJayEGwgUXkUC4tvPmYxca16TGutL8zs/9fCEU2iJdWcUE1sZ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6wUeIa4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-211eb2be4a8so9375ad.1
        for <cgroups@vger.kernel.org>; Wed, 27 Nov 2024 15:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732750726; x=1733355526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3WtH4trghzSdXXPfTxGxbair0NPafuCGwouqPLkhJM=;
        b=K6wUeIa4zq75yNdS86uyL1sn9GSlwvgstwcGKNhdJDGXdh+zalQFQmUd8jildBnRS/
         7+eLe1Umu9OWrOHV7DzPjzv7zzeffRPbeVAWSFbnPD93WtXaftHwv6nHyQqV13IdVyUt
         kD6ewDT57RoJSf//Gr8wLolaiuFHYE+HcspaFtf/VDXxoKGvra32XmlTOS3eipfpXP1V
         IK/p+it1wVuqh3wGpB4m3Ie9GGMKWTrPXEx9KRSVHsNDJGbc9jxeT0pHj44/8RyGKB9Y
         SqU+23XEQVKKe3ZRlwh8PyAb40sU6mZCrzlK6dhFVM9e/uktOI3gaavf/2gv80HqC+Qn
         Lytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732750726; x=1733355526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3WtH4trghzSdXXPfTxGxbair0NPafuCGwouqPLkhJM=;
        b=H/nX58T71pNqivQaCUuXnEztYBPsZcDReI3APewLlqcyaK2YDm8ftG3GFpFOVCmEaA
         pQ3xWw97h+wyjen98BEge4DFfkGCoeYgTZ0yoBgEu1Jifp3YEH019Na5PxTDB8kGPlNY
         p7vXn8en0cjg80QltgnKpiRzfs7RYYFP10Wvb0vro5SgQwiIrLOj6I3kOXDR/Z0aijSg
         RXzVtLRwZkqVLP3KJibYfRxcxzCQToR4kx2bRYqv2AlcuDj2h707w0ozGAchgbgN6f6P
         Kw4NifDEE1o4/5wlcl/CvQnPE22IzSOU/c6dXeoNXO9nFDDjy/eGJ/y/VNPblPIA2H5j
         nFkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWgR9Qw63OrCcZadUFU0xZpbyuVugrKgF403lOGbUjdSYo/tBE5wOfzNEwAOFjy6Kl2m5phDJt@vger.kernel.org
X-Gm-Message-State: AOJu0YwUP/ipNI9YYNYep2VnzeRZCDBC0p5JfLtBiJ5ak7GdzqVUS0Kw
	TDtcVWjgJQ+MDsojVBqMcM+mrng7Y2if9p5rbxoMWEuvlRc/RnnAP1IXxwKKZHE6FD41pNIJ+re
	cmRCGyTK6Fhbr5SZ8IMLsBpxO8VgFqmppBe+Y
X-Gm-Gg: ASbGncsPk+8T5uYQyZXQDIjdIE2ZMeBrgEzsJeENL2vfNRSXvcAH+WXdwbgfUni5zAW
	EqJUR1Wewk8aQK3lkeAVbtQhArSu+3KufyS2nFFFhqrdpGeuLl5p8lRGucT0=
X-Google-Smtp-Source: AGHT+IGbmo+NCTIyHSzrGZMJ1PCr9HDG5gkQ1VMf9lBo06pyyRaJckR1C2O+1rCJt37WnntNz5FmHQXMt81lGEnrPtg=
X-Received: by 2002:a17:903:947:b0:215:1659:1721 with SMTP id
 d9443c01a7336-2151f408939mr742585ad.12.1732750725717; Wed, 27 Nov 2024
 15:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com> <20241127025728.3689245-10-yuanchu@google.com>
 <CABVzXAnbSeUezF_dqk2=6HGTCd09T4rd6AssP7-dbCgZSkZgiw@mail.gmail.com>
In-Reply-To: <CABVzXAnbSeUezF_dqk2=6HGTCd09T4rd6AssP7-dbCgZSkZgiw@mail.gmail.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 27 Nov 2024 15:38:29 -0800
Message-ID: <CAJj2-QHZvSKoErQq-oQoZLbDMuJwwdAQef-B5=WKQS9iUE+gTQ@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] virtio-balloon: add workingset reporting
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 3:15=E2=80=AFPM Daniel Verkamp <dverkamp@chromium.o=
rg> wrote:
> >   * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN A=
NY WAY
> >   * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY=
 OF
> >   * SUCH DAMAGE. */
> > +#include "linux/workingset_report.h"
> >  #include <linux/types.h>
> >  #include <linux/virtio_types.h>
> >  #include <linux/virtio_ids.h>
>
> This seems to be including a non-uapi header
> (include/linux/workingset_report.h) from a uapi header
> (include/uapi/linux/virtio_balloon.h), which won't compile outside the
> kernel. Does anything in the uapi actually need declarations from
> workingset_report.h?
Good point. I should move the relevant constants over.

> > +
> > +struct virtio_balloon_working_set_notify {
> > +       /* REQUEST or CONFIG */
> > +       __le16 op;
> > +       __le16 node_id;
> > +       /* the following fields valid iff op=3DCONFIG */
> > +       __le32 report_threshold;
> > +       __le32 refresh_interval;
> > +       __le32 idle_age[WORKINGSET_REPORT_MAX_NR_BINS];
> > +};
> > +
> > +struct virtio_balloon_working_set_report_bin {
> > +       __le64 idle_age;
> > +       /* bytes in this bucket for anon and file */
> > +       __le64 anon_bytes;
> > +       __le64 file_bytes;
> > +};
> > +
> > +struct virtio_balloon_working_set_report {
> > +       __le32 error;
> > +       __le32 node_id;
> > +       struct virtio_balloon_working_set_report_bin
> > +               bins[WORKINGSET_REPORT_MAX_NR_BINS];
> > +};
> > +
> >  #endif /* _LINUX_VIRTIO_BALLOON_H */
>
> Have the spec changes been discussed in the virtio TC?
They have not. Thanks for bringing this up. I'll post in the VIRTIO TC.

Thanks,
Yuanchu

