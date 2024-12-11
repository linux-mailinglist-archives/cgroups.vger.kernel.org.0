Return-Path: <cgroups+bounces-5819-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6845B9ED408
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 18:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689A7162AEB
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE781FF1D1;
	Wed, 11 Dec 2024 17:49:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30365246335;
	Wed, 11 Dec 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939387; cv=none; b=Qoh7RBYaDjFHYM8DLT9zZDHdYu613xdAjECmHXPSdCPF3Cf/wF5L/x3/NAOvc2FSwmMRlw2ql4QR9wuGJdLXLxu1vsztlrDKI9tCzs13hR/oK8FYf2HUZ6+M7efrpO7/9MwhcA82/bDq4rtEmHK2O8H1kWwZtVlQMYdyz/xLGbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939387; c=relaxed/simple;
	bh=Zbxk7SMv9dvH+dCvhBsL+l2jdoBHxcBW9kSrVlqpGSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z6ySo+2rmTCoy8OSaRV9D+D5nw0f/WX3pMabH+1tEC3huSBSm1WOPJfHllTmnRvgNvtU0w+UtpANilX+Ylk5/4GYsWRVju0P/h/Ax4g+KXPGGzUVjQ/vvYl9vS4QmQIcb5cr5ofPw8jupRHCNtSfpnREt+omAFk92xnkqyUvWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tLQpx-000000001OJ-0Wh1;
	Wed, 11 Dec 2024 12:49:25 -0500
Message-ID: <4e72ebcd6c12f0641c8c9040bbcdd7fc4cd54287.camel@surriel.com>
Subject: Re: [PATCH] memcg: allow exiting tasks to write back data to swap
From: Rik van Riel <riel@surriel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song	 <muchun.song@linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, 	cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com,
 Nhat Pham <nphamcs@gmail.com>
Date: Wed, 11 Dec 2024 12:49:24 -0500
In-Reply-To: <CAJD7tkZ9gSxdPUCgz_NaHSDPTC+HEhxNRbinp619sNSshScJ0A@mail.gmail.com>
References: <20241211105336.380cb545@fangorn>
	 <CAJD7tkboc5a4MDHvF7K4zx5WP0DE4rsGW_24s16Hx+Vvy2RQLQ@mail.gmail.com>
	 <768a404c6f951e09c4bfc93c84ee1553aa139068.camel@surriel.com>
	 <CAJD7tkYpk4kZChj9f-2EMp0XET6OUNbHqfVBgdFTEMnN+iomww@mail.gmail.com>
	 <6bc895883abca3522c9efc0c56189741194581e5.camel@surriel.com>
	 <CAJD7tkZ9gSxdPUCgz_NaHSDPTC+HEhxNRbinp619sNSshScJ0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Wed, 2024-12-11 at 09:30 -0800, Yosry Ahmed wrote:
> On Wed, Dec 11, 2024 at 9:20=E2=80=AFAM Rik van Riel <riel@surriel.com>
> wrote:
> >=20
> > On Wed, 2024-12-11 at 09:00 -0800, Yosry Ahmed wrote:
> > > On Wed, Dec 11, 2024 at 8:34=E2=80=AFAM Rik van Riel <riel@surriel.co=
m>
> > > wrote:
> > > > >=20
> > > > If it is a kernel directed memcg OOM kill, that is
> > > > true.
> > > >=20
> > > > However, if the exit comes from somewhere else,
> > > > like a userspace oomd kill, we might not hit that
> > > > code path.
> > >=20
> > > Why do we treat dying tasks differently based on the source of
> > > the
> > > kill?
> > >=20
> > Are you saying we should fail allocations for
> > every dying task, and add a check for PF_EXITING
> > in here?
>=20
> I am asking, not really suggesting anything :)
>=20
> Does it matter from the kernel perspective if the task is dying due
> to
> a kernel OOM kill or a userspace SIGKILL?
>=20
Currently, it does. I'm not sure it should, but
currently it does :/

We are dealing with two conflicting demands here.

On the one hand, we want the exit code to be able
to access things like futex memory, so it can
properly clean up everything the program left behind.

On the other hand, we don't want the exiting
program to drive up cgroup memory use, especially
not with memory that won't be reclaimed by the
exit.

My patch is an attempt to satisfy both of these
demands, in situations where we currently exhibit
a rather pathological behavior (glacially slow
exit).

--=20
All Rights Reversed.

