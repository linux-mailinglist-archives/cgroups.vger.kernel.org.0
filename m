Return-Path: <cgroups+bounces-6449-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E213CA2B267
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 20:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B8916AE37
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 19:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F4A1A9B29;
	Thu,  6 Feb 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/S9dsBx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709EF1A9B3B
	for <cgroups@vger.kernel.org>; Thu,  6 Feb 2025 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870666; cv=none; b=JbKcUk4CX1o5Pk5T/sKu/nu50fNcSZMCxAqPOTSywxXFah+B4XmSBp3K1MCkVc8nhnot10nkTh9Hbo19zmgQRa5fH1/B7SvKzxJa6MAAJ5Weqej/oa7TJS967WjW2/yP2V3SBCdIYMVyHyYUA/1GRGGprD+4DCI7yyzL0WHsA4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870666; c=relaxed/simple;
	bh=1fOBSotabUbiNEkU1i3ahpn3iJT7kDj6sw5tfKLVTW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pd8WMbRcdeQRJc2419DAbr9/dd4gby7vEVW8G08THdTzrjq6g4ou9xlhhJwfpicozylzMkYgy5iWjQWSchTQ/gwYu0BlfcmmlEsnNkcq6m4I+c85dYpodF6P3xjzeC/++oc5vht1ZOUZovzU/9zoaW2YFJgFiT0krjUSiwQuAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/S9dsBx; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4679b5c66d0so40741cf.1
        for <cgroups@vger.kernel.org>; Thu, 06 Feb 2025 11:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738870663; x=1739475463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fOBSotabUbiNEkU1i3ahpn3iJT7kDj6sw5tfKLVTW0=;
        b=C/S9dsBxmtIWEuUWpGZ/SiOQO/VLZd62IK5XyOVsR5YjNVVHmnMDy9YFSc54ayDHbc
         pNo6xFaz6PjpSMlZ780pbdvSMCxrC1FfzgNVsBWPh4uBvyxcF6i4myNc1E0OfXEs9gSy
         Z9aLgqva0foSkAPWciHZe2LJ2+DxxYpxdM7jeIiQzddObKu4zJyaI0YApuRGRfk9yY86
         EXyNXh2pAApMxuP1RZ+CWZuwO5I5i9XfH8jdwRLvtSxVQPtBaJz9IuqHO2h6UFaCo8jc
         8r9qIm7HnBZKOQFpioQTXBxFXyxTOjnnYSZ2BIo+N0EsfPTm+skUTf1wUgiO9EasSgrH
         m8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738870663; x=1739475463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fOBSotabUbiNEkU1i3ahpn3iJT7kDj6sw5tfKLVTW0=;
        b=FUtFvoKU4K98TJbnUSLhaGc+vQ+ChSD6iwAS7pW6QWLFhVHbas1Uz8bVezGV0XVQ+L
         xXicDbmRlEpj/fqViBtNPg9hqerXc4FYTCkUGlydIwRWsBu77FGyjHJELaazsSJ8/m/0
         aGkxt2GOw2TuuSx16LiKAUu5urMaxTouBiGkQilbKzQlZIWu976sBVBGCtcAOzIxdMfB
         mCceRzqxGFVEUdbXJ4zR2e2/VxYHFdwJ7KaJFbqqRU9X4AW8eUTu2TiQd5NRMISSfg7c
         eBnQlhmq0MwccyDUnd5n2FK2XaNkhJjkV6XfDFacZolcny2PDFqXuS55UoKv6DDT5vsJ
         b4FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi64O18m3zRqpXNCNxedxNO9oZIuNrK/Pv95LiZ8uEE9pcWqa6xoPGs1DuxOnznJRCton0/A1O@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4rUHexaaW5KfrznGvpAKWrwFGIMkTbf5DiXxs/UTNMl+VB9t
	PSAqI2BPbcD5uXLAy06//Ow14j0GkGrghN3mU1gEdyLjkqmFv0IGx941EA5K8sUxAf1W5IH3MKJ
	4Stilf1IndAJEH0p0rw4/BK44JNrTAyAFqP4z
X-Gm-Gg: ASbGnctU9j0mZDACfVLw5Ac6T0MPxrPUv6t1hmwTDppa7zb6p4yv3kz6O0LbeikU56Y
	MVvhq8lHlzHyot2gkVQ+XF87qD0dx6TK9u1E4XgoYbYKkYmE1GwZbBCsEX/pWGOPEme0uZ1/4Ka
	9+/G4qTCIOVFrtZr7IlQp96Z4mAEU=
X-Google-Smtp-Source: AGHT+IF5gcj7RwLxoY9dHuLAsZYeyd8PzDxP/5Bhyd910Q/jlsEYsY1jhfG9vSf69IxjLgvuxW1YntQdA6bHBpDIkHg=
X-Received: by 2002:ac8:6d10:0:b0:466:861a:f633 with SMTP id
 d75a77b69052e-47168810975mr122421cf.5.1738870663117; Thu, 06 Feb 2025
 11:37:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
 <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh> <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
In-Reply-To: <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 6 Feb 2025 11:37:31 -0800
X-Gm-Features: AWEUYZnlJFAzlgtpxwDOLgRzF9l_JBXAaDX14-ukU7OJ52CaWgfL_jvK_ty4s9Q
Message-ID: <CABdmKX2SnGytEHOr7-2V11hczZALy0joOD8uMDBqJZWviXPTTw@mail.gmail.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 11:09=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Feb 06, 2025 at 04:57:39PM +0100, Michal Koutn=C3=BD wrote:
> > Hello Shakeel.
> >
> > On Wed, Feb 05, 2025 at 02:20:29PM -0800, Shakeel Butt <shakeel.butt@li=
nux.dev> wrote:
> > > Memcg-v1 exposes hierarchical_[memory|memsw]_limit counters in its
> > > memory.stat file which applications can use to get their effective li=
mit
> > > which is the minimum of limits of itself and all of its ancestors.
> >
> > I was fan of equal idea too [1]. The referenced series also tackles
> > change notifications (to make this complete for apps that really want t=
o
> > scale based on the actual limit). I ceased to like it when I realized
> > there can be hierarchies when the effective value cannot be effectively
> > :) determined [2].
> >
> > > This is pretty useful in environments where cgroup namespace is used
> > > and the application does not have access to the full view of the
> > > cgroup hierarchy. Let's expose effective limits for memcg v2 as well.
> >
> > Also, the case for this exposition was never strongly built.
> > Why isn't PSI enough in your case?
> >
>
> Hi Michal,
>
> Oh I totally forgot about your series. In my use-case, it is not about
> dynamically knowning how much they can expand and adjust themselves but
> rather knowing statically upfront what resources they have been given.
> More concretely, these are workloads which used to completely occupy a
> single machine, though within containers but without limits. These
> workloads used to look at machine level metrics at startup on how much
> resources are available.
>
> Now these workloads are being moved to multi-tenant environment but
> still the machine is partitioned statically between the workloads. So,
> these workloads need to know upfront how much resources are allocated to
> them upfront and the way the cgroup hierarchy is setup, that information
> is a bit above the tree.
>
> I hope this clarifies the motivation behind this change i.e. the target
> is not dynamic load balancing but rather upfront static knowledge.
>
> thanks,
> Shakeel
>

We've been thinking of using memcg to both protect (memory.min) and
limit (via memcg OOM) memory hungry apps (games), while informing such
apps of their upper limit so they know how much they can allocate
before risking being killed. Visibility of the cgroup hierarchy isn't
an issue, but having a single file to read instead of walking up the
tree with multiple reads to calculate an effective limit would be
nice. Partial memcg activation in the hierarchy *is* an issue, but
walking up to the closest ancestor with memcg activated is better than
reading all the way up.

