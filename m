Return-Path: <cgroups+bounces-9640-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41320B41A1B
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 11:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA5C1BA3956
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 09:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505F12253EB;
	Wed,  3 Sep 2025 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhfLccV8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC382AE66
	for <cgroups@vger.kernel.org>; Wed,  3 Sep 2025 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891958; cv=none; b=j6S6EwmPla5FQK3Zrybh4TJffgCbp3eZLcyWaOIonX/BoWpuK3vEjNBw7v1WvViVfLb1yMfXTiU2p+13ZOuSqXhZAq8qrM1qlssP2VfcVsSGzMn6mz+lOg5k/rzf76MtXz3jQMlGK02ECvrjsJR58e1zo3cnsd4Z36Qmhb+ciBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891958; c=relaxed/simple;
	bh=QYNEiv8UzZcglF4OuHMoI1sYm9C7MmUjrT8VXMrcbjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeinTKAKCCaMGa4ykR4+W1PV6uVJOfgzzc2jbAAxDGPnP6HBjqVb4iAJIRHMHicPrnBG3YXxk9yKyc2nKTIYDHLPubOvLY+V8/i7sN9hFKckMVw2Ykh0/U/1sYsaYlUmHHmwli2ouBaLBRm3LWlqYEJ1DhSMeAEkgJIy1vyIXAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhfLccV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A583EC4CEF7
	for <cgroups@vger.kernel.org>; Wed,  3 Sep 2025 09:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756891957;
	bh=QYNEiv8UzZcglF4OuHMoI1sYm9C7MmUjrT8VXMrcbjs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qhfLccV8/Wbfuwadslg9tMoSbyC9NvfNemfzNfxSH06nEDnEN0sNAWr77z/XZ8n9J
	 9VfNzkq4/ecF1fmyWEYvi+TEKFq8YzUvonjCkDUs9OAqZkgBBDCbe2gugiQYPpdaol
	 X6b6WfUD71CUarVo/NS1fFB5p3xaogSGU6DU+p4va/RS1u0jfd3T0UwXKkF+ESNYh7
	 Z9g4X1DWTGA0TnA39LqW/05YHGpCm9C9d65MPwAD8TYxHTOtJ8vuvUboATXt8PyvVg
	 y/nAbH+p7iBztJIeDNbx4bkVnHUwusXDiQyKpxkSVTpwDSm2G4C+cG1rWD4c/4GUJS
	 pdFRWp+53f01Q==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e970acf352fso5662815276.2
        for <cgroups@vger.kernel.org>; Wed, 03 Sep 2025 02:32:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVI6gBuFznJOvOmMd6YyuqKztWensJF7PIrIr6cvRpyN9gbY+E1ZR/2zeeL/IDLAmClYIM6vwT@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFz+Rw2H7Ylaib6nsC5TDQh693uLK1imYqQB05T1LTJ/APZI8
	2+UeuyoeM0Bz1js8XkLtpumCNlEFoapN4idMtc0NgtWRk/DjDuMhwCUC9mOnX0vE2lIVbNiBHO4
	C6O+P9OyDJ15y1L7yhKg6bdWOPba84wMJurRYG398Ow==
X-Google-Smtp-Source: AGHT+IHVyg4p5QR0RAptgKvMSgPMubewuNwv+4U8GLEeqLb+YipS9iGNECUENqyGY22+4BFCeDQZqDuyHgVV9qNx8gs=
X-Received: by 2002:a05:690c:6d8c:b0:722:6a6c:c010 with SMTP id
 00721157ae682-7227633350bmr137460257b3.8.1756891956703; Wed, 03 Sep 2025
 02:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330> <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>
 <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330> <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
 <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330> <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
 <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330> <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
 <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330> <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>
 <aLXEkRAGmTlTGeQO@yjaykim-PowerEdge-T330> <CACePvbXAXbxqRi3_OoiSJKVs0dzuC-021AVaTkE3XOSx7FWvXQ@mail.gmail.com>
In-Reply-To: <CACePvbXAXbxqRi3_OoiSJKVs0dzuC-021AVaTkE3XOSx7FWvXQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 3 Sep 2025 02:32:25 -0700
X-Gmail-Original-Message-ID: <CACePvbU2iqLyjc2uR3d=56S4A-N4P7k3oUnwA-6D=TFfQ17jBA@mail.gmail.com>
X-Gm-Features: Ac12FXybUwxod4Em_QKVug5j6Ua_Z4DLXXFTPr86WOiopqyMskJfrqtzgT6b41k
Message-ID: <CACePvbU2iqLyjc2uR3d=56S4A-N4P7k3oUnwA-6D=TFfQ17jBA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
To: YoungJun Park <youngjun.park@lge.com>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com, 
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:40=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
> You are missing the fact that you need to track two sets of the tier mask=
.
> the "swap.ters" is a local tiername you need to track. Default is empty.
>
> The runtime tier set is the local tier mask walk to the parent, and
> collect all parent local bitmasks and aggregate into an effective set.
> The effective tier bitmask is used as the swap allocator.
>
> What you purpose still has the same problem at:
> 1) parent "- +ssd"
> 2) child "' # same as parent.
>
> If we do what your proposal is. Child will have "ssd" on the bit mask
> at creation
> When parents remove the "ssd". the child will keep having the "ssd".
>
> In  my original proposal, if a parent removes ssd then the child will
> automatically get it as well.
>
> I am not happy that you keep introducing change to my proposal and
> introduce the same buggy behavior again and again. Please respect my
> time, I am spending my long weekend writing an email to you. Please
> don't introduce the same bug again just for the sake of changing
> behavior. Be careful and think through what you are proposing.

Please accept the sincere apology from me.  I was grumpy, sorry about
that. I was under pressure to be somewhere else but this email is
taking longer than I expected to write. I let my bad temper get the
better of me and I am sorry about that.

You might not have realized that the proposal you made has the same
kind of buggy behavior for the usage case where the change of the
parent and the child gets it.

One side note, I do want to rate limit the new proposals I have to
defend against. On the other hand, when you make a proposal to change,
you have no way to predict where I will consider it good or bad.
Otherwise we don't need to have this discussion. My hash reply is
uncalled for and I realized that now.

I am over it now, let's put this behind us and continue our discussion.

Best regards,

Chris

